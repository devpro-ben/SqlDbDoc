using System;
using System.Data;
using System.Data.SqlClient;
using System.Diagnostics;
using System.IO;
using System.Xml;
using System.Xml.Xsl;
using System.Linq;
using NConsoler;
using DocumentFormat.OpenXml.Packaging;
using DocumentFormat.OpenXml.Wordprocessing;

namespace Altairis.SqlDbDoc {
    class Program {
        private static readonly string[] FORMATS = { "html", "wikiplex", "xml" };
        private static readonly string[] HTML_EXTENSIONS = { ".htm", ".html", ".xhtml" };
        private static readonly string[] WIKI_EXTENSIONS = { ".txt", ".wiki" };
        private static readonly string[] DOCX_EXTENSIONS = { ".docx" };

        private static string connectionString;

        static void Main(string[] args) {
            Console.WriteLine("Altairis DB>doc version {0:4}", System.Reflection.Assembly.GetExecutingAssembly().GetName().Version);
            Console.WriteLine("Copyright (c) Altairis, 2011 | www.altairis.cz | SqlDbDoc.codeplex.com");
			Console.WriteLine("Modifications by HAVIT, 2015 | www.havit.eu | https://github.com/hakenr/SqlDbDoc");
            Console.WriteLine("Modifications by Ben, 2020 | https://github.com/devpro-ben/SqlDbDoc");
            Console.WriteLine();

            // Add console trace listener
            Trace.Listeners.Add(new ConsoleTraceListener());

            // Run actions
            Consolery.Run();
        }

        // Actions
        [Action("Generate documentation from given database")]
        public static void CreateDocumentation(
            [Required(Description = "connection string")] string connection,
            [Required(Description = "output file name")] string fileName,
            [Optional(false, "y", Description = "overwrite output file")] bool overwrite,
            [Optional(null, "f", Description = "output format: html, wikiplex, xml, docx (autodetected when omitted)")] string format,
            [Optional(false, Description = "debug mode (show detailed error messages)")] bool debug,
			[Optional(null, "t", Description = "xslt template (file name)")] string template,
            [Optional(null, "i", Description = "objects to include in documentation.")] string[] includeObjects,
            [Optional(null, "d", Description = "docx template (file name, .docx)")] string docxTemplate
            ) {

            // Validate arguments
            if (connection == null) throw new ArgumentNullException("connection");
            if (string.IsNullOrWhiteSpace(connection)) throw new ArgumentException("Value cannot be empty or whitespace only string.", "connection");
            if (fileName == null) throw new ArgumentNullException("fileName");
            if (string.IsNullOrWhiteSpace(fileName)) throw new ArgumentException("Value cannot be empty or whitespace only string.", "fileName");

            // Validate output file
            if (File.Exists(fileName) && !overwrite) {
                Console.WriteLine("ERROR: Target file already exists. Use /y to overwrite.");
                return;
            }

            // Get output format
            if (string.IsNullOrWhiteSpace(format)) {
                Console.WriteLine("Autodetecting output format...");
                if (Array.IndexOf(HTML_EXTENSIONS, Path.GetExtension(fileName)) > -1) {
                    format = "html";
                }
                else if (Array.IndexOf(WIKI_EXTENSIONS, Path.GetExtension(fileName)) > -1) {
                    format = "wikiplex";
                } else if (Array.IndexOf(DOCX_EXTENSIONS, Path.GetExtension(fileName)) > -1) {
                    format = "docx";
                } else {
                    format = "xml";
                }
            }
            else {
                format = format.ToLower().Trim();
                if (Array.IndexOf(FORMATS, format) == -1) throw new ArgumentOutOfRangeException("format", "Unknown format string.");
            }
            Console.WriteLine("Output format: {0}", format);

            try {

                // Prepare XML document
                var doc = new XmlDocument();

                // Process database info
                connectionString = connection;
                doc.AppendChild(doc.CreateElement("database"));
                doc.DocumentElement.SetAttribute("dateGenerated", XmlConvert.ToString(DateTime.Now, XmlDateTimeSerializationMode.Unspecified));
                RenderDatabase(doc.DocumentElement);

                // Process schemas
                RenderSchemas(doc.DocumentElement);

                // Process top-level objects
                if (includeObjects != null) {
                    includeObjects = includeObjects.Where(x => !string.IsNullOrWhiteSpace(x))
                        .Select(x => x.ToLower()).ToArray();
                }
                
                RenderChildObjects(0, doc.DocumentElement, includeObjects);

                if (format.Equals("xml")) {
                    // Save raw XML
                    Console.Write("Saving raw XML...");
                    doc.Save(fileName);
                    Console.WriteLine("OK");
                    return;
                }

                // Read XSL template code
                string xslt;
	            if (!String.IsNullOrWhiteSpace(template))
	            {
		            xslt = File.ReadAllText(template);
	            }
	            else if (format.Equals("html")) {
                    xslt = Resources.Templates.Html;
                } else if (format.Equals("docx")) {
                    xslt = Resources.Templates.Docx;
                } else {
                    xslt = Resources.Templates.WikiPlex;
                }

                // Prepare XSL transformation
                Console.Write("Preparing XSL transformation...");
                using (var sr = new StringReader(xslt))
                using (var xr = XmlReader.Create(sr)) {
                    var tran = new XslCompiledTransform();
                    tran.Load(xr);
                    Console.WriteLine("OK");

                    Console.Write("Performing XSL transformation...");
                    if (format.Equals("docx")) {
                        var stringWriter = new StringWriter();
                        var xmlWriter = XmlWriter.Create(stringWriter);
                        tran.Transform(doc, xmlWriter);
                        CreateDocxFile(fileName, stringWriter, docxTemplate);
                    } else {
                        using (var fw = File.CreateText(fileName)) {
                            tran.Transform(doc, null, fw);
                        }
                    }
                        
                    Console.WriteLine("OK");
                }
            }
            catch (Exception ex) {
                Console.WriteLine("Failed!");
                Console.WriteLine(ex.Message);
                if (debug) Console.WriteLine(ex.ToString());
            }
        }

        private static void CreateDocxFile(string fileName, StringWriter stringWriter, string templateFilename) {
            // Create an Xml Document of the new content.
            XmlDocument newWordContent = new XmlDocument();
            var xml = stringWriter.ToString();
            newWordContent.LoadXml(xml);

            //Copy the Word 2007 source document to the output file.
            if (!string.IsNullOrWhiteSpace(templateFilename)) {
                File.Copy(templateFilename, fileName, true);
            }
            else {
                File.WriteAllBytes(fileName, Resources.Templates.DocTemplate);
            }
            

            //Use the Open XML SDK version 2.0 to open the output 
            //  document in edit mode.
            using (WordprocessingDocument output =
              WordprocessingDocument.Open(fileName, true)) {
                //Using the body element within the new content XmlDocument
                //  create a new Open Xml Body object.
                Body updatedBodyContent =
                  new Body(newWordContent.DocumentElement.InnerXml);

                //Replace the existing Document Body with the new content.
                output.MainDocumentPart.Document.Body = updatedBodyContent;

                //Save the updated output document.
                output.MainDocumentPart.Document.Save();
            }
        }

        // Helper methods

        static void RenderSchemas(XmlElement parentElement) {
            // Get list of schemas
            var dt = new DataTable();
            using (var da = new SqlDataAdapter(Resources.Commands.GetSchemas, connectionString)) {
                da.Fill(dt);
            }

            // Populate schemas
            for (int i = 0; i < dt.Rows.Count; i++) {
                var e = parentElement.AppendChild(parentElement.OwnerDocument.CreateElement("schema")) as XmlElement;
                e.SetAttribute("name", (string)dt.Rows[i][0]);
            }
        }

        static void RenderDatabase(XmlElement parentElement) {
            // Get current database info
            var dt = new DataTable();
            using (var da = new SqlDataAdapter(Resources.Commands.GetDatabase, connectionString)) {
                da.Fill(dt);
            }

            // Display database info
            foreach (DataColumn col in dt.Columns) {
                var value = dt.Rows[0].ToXmlString(col);
                if (!string.IsNullOrWhiteSpace(value)) parentElement.SetAttribute(col.ColumnName, value);
            }
        }

        static void RenderChildObjects(int parentObjectId, XmlElement parentElement, string[] includeObjects) {
            // Get all database objects with given parent
            var dt = new DataTable();
            using (var da = new SqlDataAdapter(Resources.Commands.GetObjects, connectionString)) {
                da.SelectCommand.Parameters.Add("@parent_object_id", SqlDbType.Int).Value = parentObjectId;
                da.Fill(dt);
            }
            
            // Process all objects
            foreach (DataRow row in dt.Rows) {
                if (includeObjects != null && !includeObjects.Contains(row["name"].ToString().ToLower()))
                    continue;

                var objectId = (int)row["id"];
                Trace.WriteLine(string.Format("{0}.{1}", row["schema"], row["name"]));

                // Create object element
                var e = parentElement.AppendChild(parentElement.OwnerDocument.CreateElement("object")) as XmlElement;
                foreach (DataColumn col in dt.Columns) {
                    var value = row.ToXmlString(col);
                    if (!string.IsNullOrWhiteSpace(value)) e.SetAttribute(col.ColumnName, value);
                }

                Trace.Indent();
                // Process columns
                RenderColumns(objectId, e);

                // Process refrence keys
                RenderRefrenceKeys(objectId, e);

                // Process default constraints
                RenderDefaultConstraints(objectId, e);

                // Process check constraints
                RenderCheckConstraints(objectId, e);

                // Process triggers
                RenderTriggers(objectId, e);

                // Process indexes
                RenderIndexes(objectId, e);

                // Process child objects
                RenderChildObjects(objectId, e, null);
                Trace.Unindent();
            }
        }

        private static void RenderIndexes(int parentObjectId, XmlElement parentElement) {
            // Get all indexes with given parent
            var dt = new DataTable();
            using (var da = new SqlDataAdapter(Resources.Commands.GetIndexes, connectionString)) {
                da.SelectCommand.Parameters.Add("@parent_object_id", SqlDbType.Int).Value = parentObjectId;
                da.Fill(dt);
            }

            // Process all indexes
            var currentName = "";
            XmlElement e = null;
            foreach (DataRow row in dt.Rows) {
                Trace.WriteLine(string.Format("{0}", row["name"]));

                // Create index element
                if (currentName != row["name"].ToString()) {
                    e = parentElement.AppendChild(parentElement.OwnerDocument.CreateElement("index")) as XmlElement;
                    foreach (DataColumn col in dt.Columns) {
                        var value = row.ToXmlString(col);
                        if (!string.IsNullOrWhiteSpace(value) && col.ColumnName != "columnName") e.SetAttribute(col.ColumnName, value);
                    }
                }
                if (e != null) {
                    var se = e.AppendChild(e.OwnerDocument.CreateElement("column")) as XmlElement;
                    se.SetAttribute("name", row["columnName"].ToString());
                }
                
                currentName = row["name"].ToString();
            }
        }

        private static void RenderTriggers(int parentObjectId, XmlElement parentElement) {
            // Get all triggers with given parent
            var dt = new DataTable();
            using (var da = new SqlDataAdapter(Resources.Commands.GetTriggers, connectionString)) {
                da.SelectCommand.Parameters.Add("@parent_object_id", SqlDbType.Int).Value = parentObjectId;
                da.Fill(dt);
            }

            // Process all triggers
            foreach (DataRow row in dt.Rows) {
                Trace.WriteLine(string.Format("{0}", row["name"]));

                // Create trigger element
                var e = parentElement.AppendChild(parentElement.OwnerDocument.CreateElement("trigger")) as XmlElement;
                foreach (DataColumn col in dt.Columns) {
                    var value = row.ToXmlString(col);
                    if (!string.IsNullOrWhiteSpace(value)) e.SetAttribute(col.ColumnName, value);
                }
            }
        }

        private static void RenderCheckConstraints(int parentObjectId, XmlElement parentElement) {
            // Get all check constraints with given parent
            var dt = new DataTable();
            using (var da = new SqlDataAdapter(Resources.Commands.GetCheckConstraints, connectionString)) {
                da.SelectCommand.Parameters.Add("@parent_object_id", SqlDbType.Int).Value = parentObjectId;
                da.Fill(dt);
            }

            // Process all check constraints
            foreach (DataRow row in dt.Rows) {
                Trace.WriteLine(string.Format("{0}", row["name"]));

                // Create check constraint element
                var e = parentElement.AppendChild(parentElement.OwnerDocument.CreateElement("checkConstraint")) as XmlElement;
                foreach (DataColumn col in dt.Columns) {
                    var value = row.ToXmlString(col);
                    if (!string.IsNullOrWhiteSpace(value)) e.SetAttribute(col.ColumnName, value);
                }
            }
        }

        private static void RenderDefaultConstraints(int parentObjectId, XmlElement parentElement) {
            // Get all default constraints with given parent
            var dt = new DataTable();
            using (var da = new SqlDataAdapter(Resources.Commands.GetDefaultConstraints, connectionString)) {
                da.SelectCommand.Parameters.Add("@parent_object_id", SqlDbType.Int).Value = parentObjectId;
                da.Fill(dt);
            }

            // Process all default constraints
            foreach (DataRow row in dt.Rows) {
                Trace.WriteLine(string.Format("{0}", row["name"]));

                // Create default constraint element
                var e = parentElement.AppendChild(parentElement.OwnerDocument.CreateElement("defaultConstraint")) as XmlElement;
                foreach (DataColumn col in dt.Columns) {
                    var value = row.ToXmlString(col);
                    if (!string.IsNullOrWhiteSpace(value)) e.SetAttribute(col.ColumnName, value);
                }
            }
        }

        private static void RenderRefrenceKeys(int parentObjectId, XmlElement parentElement) {
            // Get all refrence keys with given parent
            var dt = new DataTable();
            using (var da = new SqlDataAdapter(Resources.Commands.GetRefrenceKeys, connectionString)) {
                da.SelectCommand.Parameters.Add("@parent_object_id", SqlDbType.Int).Value = parentObjectId;
                da.Fill(dt);
            }

            // Process all refrence keys
            foreach (DataRow row in dt.Rows) {
                Trace.WriteLine(string.Format("{0}", row["name"]));

                // Create refrence key element
                var e = parentElement.AppendChild(parentElement.OwnerDocument.CreateElement("refrence")) as XmlElement;
                foreach (DataColumn col in dt.Columns) {
                    var value = row.ToXmlString(col);
                    if (!string.IsNullOrWhiteSpace(value)) e.SetAttribute(col.ColumnName, value);
                }
            }
        }

        static void RenderColumns(int objectId, XmlElement parentElement) {
            // Get all columns object with given parent
            var dt = new DataTable();
            using (var da = new SqlDataAdapter(Resources.Commands.GetColumns, connectionString)) {
                da.SelectCommand.Parameters.Add("@object_id", SqlDbType.Int).Value = objectId;
                da.Fill(dt);
            }

            // Process all columns
            foreach (DataRow row in dt.Rows) {
                Trace.WriteLine(string.Format("{0} {1}", row["name"], row["type"]));

                // Create object element
                var e = parentElement.AppendChild(parentElement.OwnerDocument.CreateElement("column")) as XmlElement;
                foreach (DataColumn col in dt.Columns) {
                    var value = row.ToXmlString(col);
                    if (string.IsNullOrWhiteSpace(value)) continue;

                    if (col.ColumnName.IndexOf(':') == -1) {
                        // Plain attribute
                        e.SetAttribute(col.ColumnName, value);
                    }
                    else {
                        // Nested element/attribute
                        var names = col.ColumnName.Split(':');
                        var se = (e.SelectSingleNode(names[0]) ?? e.AppendChild(e.OwnerDocument.CreateElement(names[0]))) as XmlElement;
                        se.SetAttribute(names[1], value);
                    }
                }
            }
        }

    }
}
