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


# GetScenariosFromXML

function ReadFileAndGetInfos($filePath) {
    $xml = New-Object System.Xml.XmlTextWriter("test.xml" , $null)
    # Formatting
    $xml.Formatting = 'Indented'
    $xml.Indentation = 1
    $Xml.IndentChar = "`t"
    #
    $xml.WriteStartDocument()
    $xml.WriteStartElement("Testfälle")
    $lines = Get-Content $filePath
    $currentType = ""
    $scenarioIndex = 0
    foreach ($line in $lines) {
        if ($line -match $scenarioPattern) {
            if ($currentType -ne "Scenario" -and $scenarioIndex -ne 0) {
                $xml.WriteEndElement()
                $xml.WriteEndElement()
            }
            $xml.WriteStartElement("Scenario")
            $xml.WriteElementString('Beschreibung',$line)
            $currentType = "Scenario"
            $scenarioIndex++
        } if ($line -match $givenPattern) {
            if ($currentType -ne "Given") {
                $xml.WriteEndElement()
                $xml.WriteStartElement("Given")
                $xml.WriteElementString('Beschreibung', $line)
            }
            if ($currentType -eq "Given") {
                $xml.WriteElementString('Beschreibung', $line)
            }
            $currentType = "Given"
        } elseif ($line -match $whenPattern) {
            if ($currentType -ne "When") {
                $xml.WriteEndElement()
                $xml.WriteStartElement("When")
                $xml.WriteElementString('Beschreibung', $line)
            }
            if ($currentType -eq "When") {
                $xml.WriteElementString('Beschreibung', $line)
            }
            $currentType = "When"
        } elseif ($line -match $thenPattern) {
            if ($currentType -ne "Then") {
                $xml.WriteEndElement()
                $xml.WriteStartElement("Then")
                $xml.WriteElementString('Beschreibung', $line)
            }
            if ($currentType -eq "Then") {
                $xml.WriteElementString('Beschreibung', $line)
            }
            $currentType = "Then"
        }
    }
    $xml.WriteEndElement()
    $xml.WriteEndDocument()
    $xml.Flush()
    $xml.Close()
}

ReadFileAndGetInfos "codeunit.txt"

$scenarioPattern = ".*SCENARIO.*"
$givenPattern = "\[GIVEN.*"
$whenPattern = "\[WHEN.*"
$thenPattern = "\[THEN.*"