﻿<?xml version="1.0"?>

<configuration>
	<configSections>
		<sectionGroup name="system.web.webPages.razor" type="System.Web.WebPages.Razor.Configuration.RazorWebSectionGroup, System.Web.WebPages.Razor, Version=3.0.0.0, Culture=neutral, PublicKeyToken=31BF3856AD364E35">
			<section name="host" type="System.Web.WebPages.Razor.Configuration.HostSection, System.Web.WebPages.Razor, Version=3.0.0.0, Culture=neutral, PublicKeyToken=31BF3856AD364E35" requirePermission="false" />
			<section name="pages" type="System.Web.WebPages.Razor.Configuration.RazorPagesSection, System.Web.WebPages.Razor, Version=3.0.0.0, Culture=neutral, PublicKeyToken=31BF3856AD364E35" requirePermission="false" />
		</sectionGroup>
	</configSections>

	<system.web.webPages.razor>
		<host factoryType="System.Web.Mvc.MvcWebRazorHostFactory, System.Web.Mvc, Version=5.0.0.0, Culture=neutral, PublicKeyToken=31BF3856AD364E35" />
		<pages pageBaseType="System.Web.Mvc.WebViewPage">
			<namespaces>
				<add namespace="System.Web.Mvc" />
				<add namespace="System.Web.Mvc.Ajax" />
				<add namespace="System.Web.Mvc.Html" />
				<add namespace="System.Web.Routing" />
				<add namespace="$rootnamespace$" />
				<add namespace="SquishIt.Framework" />
			</namespaces>
		</pages>
	</system.web.webPages.razor>

	<appSettings>
		<add key="webpages:Enabled" value="false" />
	</appSettings>

	<system.webServer>
		<handlers>
			<remove name="BlockViewHandler"/>
			<add name="BlockViewHandler" path="*" verb="*" preCondition="integratedMode" type="System.Web.HttpNotFoundHandler" />
		</handlers>
	</system.webServer>
</configuration>
