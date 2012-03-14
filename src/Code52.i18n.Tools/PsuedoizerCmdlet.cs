namespace Code52.i18n
{
    using System.Management.Automation;

    [Cmdlet("Code52", "Psuedoizer")]
    public class PsuedoizerCmdlet : PSCmdlet
    {
        [Parameter(HelpMessage = "InputResourceFile", Mandatory = true)]
        public string InputResourceFile { get; set; }

        [Parameter(HelpMessage = "OutputResourceFile", Mandatory = true)]
        public string OutputResourceFile { get; set; }

        protected override void ProcessRecord() {

            this.WriteObject("Psuedoizer: Adapted from MSDN BugSlayer 2004-Apr i18n Article");
            this.WriteObject(string.Format(" - generating resource file from {0}", InputResourceFile));
            this.WriteObject(string.Format(" - output to {0}", OutputResourceFile));

            Psuedoizer psuedoizer = new Psuedoizer();
            psuedoizer.Run(InputResourceFile, OutputResourceFile);

            this.WriteObject(string.Format("Psuedoizer completed successfully"));
        }
    }
}