# Author: Matthiaspr
# Date last modified: 22.06.2017

# This script has to be run in the Exchange Management Shell in order to function!
# Powershell script for exporting Exchange mailboxes for a list of users

$content = Get-Content C:\<path>\<to>\<text_file>.txt  # One entry per line, either the users DisplayName or SAMAccountName/Alias attribute

foreach ($line in $content) # Iterate through every User 
{
	$currentMailbox = Get-Mailbox $line
	if($currentMailbox.ForwardingAddress -eq $null) # Only when no ForwardingAdress is specified for the user
	{
		$Sam = $currentMailbox.SamAccountName
		New-MailboxExportRequest -Name $Sam -Mailbox $currentMailbox -FilePath \\<server FQDN>\<shared folder name>\<PST name>.pst
	  # "-Name $Sam" in order to easily identify the later MailboxExportRequest
  }
}
