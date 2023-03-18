function CreateXMLFile {
    $xml = New-Object System.Xml.XmlTextWriter("test.xml" , $null)
    # Formatting
    $xml.Formatting = 'Indented'
    $xml.Indentation = 1
    $Xml.IndentChar = "`t"
    #
    $xml.WriteStartDocument()

    $xml.WriteStartElement("Testfälle")

    $xml.WriteStartElement("Scenario")

    $xml.WriteStartElement("GIVEN")
    $xml.WriteStartElement("Given")
    $xml.WriteAttributeString("value", "This is a given in a scenario")
    $xml.WriteEndElement()
    $xml.WriteStartElement("Given")
    $xml.WriteAttributeString("value", "This is another given in a scenario")
    $xml.WriteEndElement()
    $xml.WriteStartElement("Given")
    $xml.WriteAttributeString("value", "This is a given another in a scenario")
    $xml.WriteEndElement()
    $xml.WriteEndElement()

    $xml.WriteStartElement("WHEN")
    $xml.WriteStartElement("When")
    $xml.WriteAttributeString("value", "This is a when in a scenario")
    $xml.WriteEndElement()
    $xml.WriteEndElement()

    $xml.WriteEndElement()

    $xml.WriteStartElement("Scenario")

    $xml.WriteStartElement("GIVEN")
    $xml.WriteStartElement("Given")
    $xml.WriteAttributeString("value", "This is a given in a scenario")
    $xml.WriteEndElement()
    $xml.WriteStartElement("Given")
    $xml.WriteAttributeString("value", "This is another given in a scenario")
    $xml.WriteEndElement()
    $xml.WriteStartElement("Given")
    $xml.WriteAttributeString("value", "This is a given another in a scenario")
    $xml.WriteEndElement()
    $xml.WriteEndElement()

    $xml.WriteStartElement("WHEN")
    $xml.WriteStartElement("When")
    $xml.WriteAttributeString("value", "This is a when in a scenario")
    $xml.WriteEndElement()
    $xml.WriteEndElement()

    $xml.WriteEndElement()

    $xml.WriteEndElement()

    #End of Document
    $xml.WriteEndDocument()
    $xml.Flush()
    $xml.Close()
}


CreateXMLFile

function GetScenariosFromXML {
    $xmlPath = "test.xml"
    $xml = Select-Xml -Path $xmlPath -XPath "//Scenario"
    foreach ($node in $xml.Node) {
        Write-Host "Scenario:", $node.Name
        foreach ($given in $node.GIVEN.ChildNodes) {
            Write-Host "Given:", $given.InnerText
        }
        foreach ($when in $node.WHEN.ChildNodes) {
            Write-Host "When:", $when.InnerText
        }
    }
}


GetScenariosFromXML