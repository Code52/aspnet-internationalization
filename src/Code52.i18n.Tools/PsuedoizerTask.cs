namespace Code52.i18n {
    using System.IO;

    using Microsoft.Build.Framework;

    public class PsuedoizerTask : ITask {
        [Required]
        public string InputResourceFile { get; set; }

        [Required]
        public string OutputResourceFile { get; set; }

        public bool Execute() {
            var msgArgs = new BuildMessageEventArgs("Psuedoizer: Adapted from MSDN BugSlayer 2004-Apr i18n Article.", string.Empty, "PsuedoizerTask", MessageImportance.Normal);
            BuildEngine.LogMessageEvent(msgArgs);

            if (!File.Exists(InputResourceFile)) {
                var errorArgs = new BuildMessageEventArgs("Input ressource file could not be located.", string.Empty, "PsuedoizerTask", MessageImportance.High);
                BuildEngine.LogMessageEvent(errorArgs);
                return false;
            }

            Psuedoizer psuedoizer = new Psuedoizer();
            psuedoizer.Run(InputResourceFile, OutputResourceFile);

            return true;
        }

        public IBuildEngine BuildEngine { get; set; }

        public ITaskHost HostObject { get; set; }
    }
}