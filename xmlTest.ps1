$xml = New-Object System.Xml.XmlTextWriter("test.xml" ,$null)
# Formatting
$xml.Formatting = 'Indented'
$xml.Indentation = 1
$Xml.IndentChar = "`t"
#
$xml.WriteStartDocument()

$xml.WriteComment("Testfälle")
$xml.WriteStartElement("Scenario")

$xml.WriteStartElement("GIVEN")

$xml.WriteEndElement()

$xml.WriteEndElement()




$xml.WriteEndDocument()
