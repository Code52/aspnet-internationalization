namespace $rootnamespace$.Code52.i18n 
{
    using System;
    using System.Collections.Concurrent;
    using System.Collections.Generic;
    using System.Linq;
    using System.Threading;

    public static class CultureHelper {
        // This is a list of cultures supported by your application
        private static readonly IList<string> _cultures = new List<string> {
                                                                               "en-GB",  // first culture is the DEFAULT
                                                                               "fr",
                                                                               "pl"
                                                                           };
        private static readonly ConcurrentDictionary<string, string> _getImplementedCultureCache = new ConcurrentDictionary<string, string>();

        public static string GetImplementedCulture(string name) {
          if (string.IsNullOrEmpty(name))
            return GetDefaultCulture(); // return Default culture
          if (_getImplementedCultureCache.ContainsKey(name))
            return _getImplementedCultureCache[name];   // we have worked this out before and cached the result. Send it back.
          if (_cultures.Any(c => c.Equals(name, StringComparison.InvariantCultureIgnoreCase)))
            return CacheCulture(name, name); // the culture is in our supported list, accept it
          
          // We did not get an exact culture match. Fallback to a language match, eg en-AU == en-US by matching the en prefix.
          var n = GetNeutralCulture(name);
          foreach (var c in _cultures)
            if (c.StartsWith(n))
              return CacheCulture(name, c);
          return CacheCulture(name, GetDefaultCulture()); // return Default culture as no match found
        }

        private static string CacheCulture(string originalName, string implementedName)
        {
            _getImplementedCultureCache.AddOrUpdate(originalName, implementedName, (_, __) => implementedName);
            return implementedName;
        }

        public static string GetDefaultCulture() {
            return _cultures[0]; // return Default culture
        }

        public static string GetCurrentCulture() {
            return Thread.CurrentThread.CurrentCulture.Name;
        }

        public static string GetCurrentNeutralCulture() {
            return GetNeutralCulture(Thread.CurrentThread.CurrentCulture.Name);
        }

        public static string GetNeutralCulture(string name) {
            if (name.Length <= 2)
                return name;

            return name.Substring(0, 2); // Read first two chars only. E.g. "en", "es"
        }
    }
}