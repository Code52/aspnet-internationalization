﻿[Code52.i18n] - ASP.NET Internationalisation for MVC

-- About Code52 i18n --
The purpose of the Code52 i18n project is to provide an easy way to implement localisation support to ASP.NET project. We currently have a reference implementation for MVC3 Razor and MVC4 Razor.

-- About Code52 --
We want to build fun stuff in our spare time, give back to projects which need support, and create a community which is inclusive and engaging.

Find out more about Code52 on their website http://code52.org/

-- Getting Started --

:::::::::::::::::::::::::::::::
1. Create a Language resource file
:::::::::::::::::::::::::::::::

    Add a new item > Resources File. (If resources file isn't visible try changing the selection on the left hand side to the root (such as Visual C#)
    I usually create a resource file specifically for language resources

    Ensure that strings is the current section selection.

    If your resource file is in a separate project you may wish to change the access modifier to public so you can access it from other projects.

:::::::::::::::::::::::::::::::
2. Add reference to language selection UserControl
:::::::::::::::::::::::::::::::

    Add the following reference to a page / layout that you wish to display the language selection options to the user.

        @Html.Partial("LanguageSelection")

	
:::::::::::::::::::::::::::::::
3. Update your site layout
:::::::::::::::::::::::::::::::


    Instructions
    ------------

	Add this using statement to the top of your Razor file to reference the CultureHelper class:
	
	@using $rootnamespace$.Code52.i18n


	Before the closing </head> tag reference a stylesheet to for the language selection page:

	<link href="@Url.Content("~/Content/Code52.i18n/Code52.i18n.css")" rel="stylesheet" type="text/css" />

	

    Before the closing </body> tag of your page, add the following scripts to set up the localisation and validation:

    <script type="text/javascript" src="http://ajax.aspnetcdn.com/ajax/jquery.validate/1.9/jquery.validate.min.js"></script>
    <script type="text/javascript" src="@Url.Content("~/Scripts/jquery.globalize/globalize.js")"></script>
    <script type="text/javascript" src="@Url.Content("~/Scripts/jquery.cookie.js")"></script>
    <script type="text/javascript" src="@Url.Content(string.Format("~/Scripts/jquery.globalize/cultures/globalize.culture.{0}.js", CultureHelper.GetCurrentCulture()))"></script>
    @if (CultureHelper.GetCurrentNeutralCulture() != "en")
    {
	<script type="text/javascript" src="@String.Format("http://ajax.aspnetcdn.com/ajax/jquery.validate/1.9/localization/messages_{0}.js", CultureHelper.GetCurrentNeutralCulture())"></script>    
	}
    <script type="text/javascript" src="@Url.Content("~/Scripts/Code52.i18n.js")"></script>
    <script type="text/javascript" src="@Url.Content("/i18n/Code52.i18n.language.js")"></script>
    <script type="text/javascript">
        Code52.Language.Init('@CultureHelper.GetCurrentCulture()');    
    </script>


	If you're not sure how it should look, here's one we prepared earlier:

	https://gist.github.com/2028204



    Explanation 
    ------------
    
        <script type="text/javascript" src="@Url.Content("/Scripts/Code52.i18n.js")"></script>

    This is the reference to the javascript that handles the language selection control and initialises localisation within javascript.

        <script type="text/javascript" src="@Url.Content("/i18n/Code52.i18n.language.js")"></script>
    
    This references the MVC action that generates a Javascript object from the Language resource file.

        <script type="text/javascript">
            Code52.Language.Init('@CultureHelper.GetCurrentCulture()');
        </script>
    
    This statement initialises localisation for the current culture.