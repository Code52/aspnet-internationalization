namespace $rootnamespace$.Controllers 
{
    using System.Collections;
    using System.Globalization;
    using System.Linq;
    using System.Resources;
    using System.Text;
    using System.Web;
    using System.Web.Mvc;

    [OutputCache(Duration = 60, VaryByCustom = "culture")]
    public class LanguageController : Controller 
    {
        public JavaScriptResult Language()
        {
            return GetResourceScript(Resources.Language.ResourceManager);
        }

        JavaScriptResult GetResourceScript(ResourceManager resourceManager)
        {
            var cacheName = string.Format("ResourceJavaScripter.{0}", CultureInfo.CurrentCulture.Name);
            var value = HttpRuntime.Cache.Get(cacheName) as JavaScriptResult;
            if (value == null)
            {
                JavaScriptResult javaScriptResult = CreateResourceScript(resourceManager);
                HttpContext.Cache.Insert(cacheName, javaScriptResult);
                return javaScriptResult;
            }
            return value;
        }

        static JavaScriptResult CreateResourceScript(ResourceManager resourceManager)
        {
            var resourceSet = resourceManager.GetResourceSet(CultureInfo.CurrentCulture, true, true);
            var sb = new StringBuilder("Code52.Language.Dictionary={");
            foreach (DictionaryEntry dictionaryEntry in resourceSet)
            {
                var s = dictionaryEntry.Value as string;
                if (s == null)
                {
                    continue;
                }
                string value = resourceSet.GetString((string)dictionaryEntry.Key) ?? s;
                sb.AppendFormat("\"{0}\":\"{1}\",", dictionaryEntry.Key, Microsoft.Security.Application.Encoder.JavaScriptEncode(value.Replace("\"", "\\\"").Replace('{', '[').Replace('}', ']'), false));
            }
            string script = sb.ToString();
            if (!string.IsNullOrEmpty(script) && script.Last() != '{')
            {
                script = script.Remove(script.Length - 1);
            }
            script += "};";
            return new JavaScriptResult { Script = script };
        }
    }
}
