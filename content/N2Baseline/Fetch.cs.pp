
namespace $rootnamespace$.N2Baseline
{
	using System;
	using System.Collections.Generic;
	using System.Linq;
	using System.Web;

	using N2;
	using N2.Collections;
	using N2.Definitions;
	using N2.Engine.Globalization;

	public static class Fetch
	{
		/// <summary>
		/// for any given path, find most suitable start page it could belong to. Used for 404
		/// </summary>
		/// <returns></returns>
		public static N2.ContentItem FindStartPageOfPath(string path)
		{
			var pathSegments = path.Split(new string[] { "/" }, StringSplitOptions.RemoveEmptyEntries);
			if (pathSegments.Any())
			{
				N2.ContentItem page = N2.Context.Current.UrlParser.Parse("/" + pathSegments.First());
				if (page != null && page is IStartPage)
				{
					return page;
				}
			}

			return N2.Find.StartPage;
		}

		#region Fetch.Page

		public static N2.ContentItem Page(int id)
		{
			return N2.Context.Current.Persister.Get(id);
		}

		public static T Page<T>(int id) where T : N2.ContentItem
		{
			N2.ContentItem page = Fetch.Page(id);
			if (page is T)
			{
				return page as T;
			}
			else
			{
				return null;
			}
		}

		public static N2.ContentItem PageByUrl(string pageUrl)
		{
			return N2.Context.Current.UrlParser.Parse(pageUrl);
		}

		public static T PageByUrl<T>(string pageUrl) where T : N2.ContentItem
		{
			N2.ContentItem page = Fetch.PageByUrl(pageUrl);
			if (page is T)
			{
				return page as T;
			}
			else
			{
				return null;
			}
		}

		#endregion

		#region Fetch.CurrentPage

		public static N2.ContentItem CurrentPage
		{
			get
			{
				/*
				var wc = N2.Context.Current.Resolve<IWebContext>();
				return wc.CurrentPage;
				*/

				try
				{
					return N2.Context.CurrentPage ?? Fetch.PageByUrl(HttpContext.Current.Request.RawUrl);
				}
				catch
				{
					return null;
				}
			}
		}

		#endregion

		#region Fetch.RootPage

		public static N2.ContentItem RootPage
		{
			get
			{
				try
				{
					return N2.Find.RootItem;
				}
				catch
				{
					return null;
				}
			}
		}

		#endregion

		#region Fetch.StartPage

		public static N2.ContentItem StartPage
		{
			get
			{
				/*
				var wc = N2.Context.Current.Resolve<IWebContext>();

				StartPage startPage = null;

				if (wc.CurrentPage == null) // not executing on N2 page
				{
					startPage = Find.StartPage as StartPage;
				}
				else
				{
					startPage = Fetch.Closest<StartPage>(wc.CurrentPage);
				}

				return startPage;
				*/

				N2.ContentItem currentPage = Fetch.CurrentPage;
				if (currentPage != null)
				{
					IStartPage startPage = Fetch.Closest<IStartPage>(Fetch.CurrentPage);
					if (startPage != null)
					{
						return startPage as N2.ContentItem;
					}
				}

				try
				{
					return N2.Context.Current.UrlParser.StartPage;
				}
				catch
				{
					return null;
				}
			}
		}

		#endregion

		#region Fetch.LevelOf

		/// <summary>
		/// For multilingual sites: Root = 0, LanguageIntersection = 1, StartPage = 2, etc
		/// For monolingual site: Root = 0, StartPage = 1, etc
		/// </summary>
		/// <param name="page"></param>
		/// <returns></returns>
		public static int LevelOf(N2.ContentItem page = null)
		{
			if (page == null) page = Fetch.CurrentPage;
			return Fetch.Ancestors(page: page, includeSelf: false).Count();
		}

		#endregion

		#region Fetch.SelectedItem

		/// <summary>
		/// If you call your ToolbarPlugin with ?{Selection.SelectedQueryKey}={selected} this property will return
		/// site node that was selected at the moment when toolbar icon was clicked
		/// </summary>
		//		public static ContentItem SelectedItem
		//		{
		//			get { return (new N2.Edit.SelectionUtility(HttpContext.Current.Request, N2.Context.Current)).SelectedItem; }
		//		}

		#endregion

		#region Fetch.Closest

		public static T Closest<T>(N2.ContentItem page = null) where T : class
		{
			if (page == null) page = Fetch.CurrentPage;
			return N2.Find.Closest<T>(page);
		}

		#endregion

		#region Fetch.Children

		/// <summary>
		/// Defaults: children of current item, pages, regardless of visibility
		/// </summary>
		/// <returns></returns>
		public static IEnumerable<T> Children<T>(
				N2.ContentItem parent = null,
				bool onlyVisible = false,
				bool includeParts = false
			)
		{
			if (parent == null) parent = Fetch.CurrentPage;

			ItemFilter filters = N2.Content.Is.Accessible();
			filters += N2.Content.Is.Published();
			if (onlyVisible) filters += N2.Content.Is.Visible();
			if (!includeParts) filters += N2.Content.Is.Page();

			return N2.Content.Traverse.Children(parent, filters).OfType<T>();
		}

		public static IEnumerable<ContentItem> Children(
				N2.ContentItem parent = null,
				bool onlyVisible = false,
				bool includeParts = false
			)
		{
			if (parent == null) parent = Fetch.CurrentPage;

			return Fetch.Children<N2.ContentItem>
				(
					parent: parent,
					onlyVisible: onlyVisible,
					includeParts: includeParts
				);
		}

		#endregion

		#region Fetch.Descendents

		public static IEnumerable<T> Descendents<T>(
				N2.ContentItem parent = null,
				bool onlyVisible = false,
				bool includeParts = false
			)
		{
			if (parent == null) parent = Fetch.CurrentPage;

			ItemFilter filters = N2.Content.Is.Accessible();
			filters += N2.Content.Is.Published();
			if (onlyVisible) filters += N2.Content.Is.Visible();
			if (!includeParts) filters += N2.Content.Is.Page();

			return N2.Content.Traverse.Descendants(parent, filters).OfType<T>();
		}

		public static IEnumerable<ContentItem> Descendents(
				N2.ContentItem parent = null,
				bool onlyVisible = false,
				bool includeParts = false
			)
		{
			if (parent == null) parent = Fetch.CurrentPage;

			return Fetch.Descendents<N2.ContentItem>
				(
					parent: parent,
					onlyVisible: onlyVisible,
					includeParts: includeParts
				);
		}

		#endregion

		#region Fetch.Translations

		public static IEnumerable<ContentItem> Translations(N2.ContentItem page = null)
		{
			if (page == null) page = Fetch.CurrentPage;
			return N2.Context.Current.Resolve<LanguageGatewaySelector>().GetLanguageGateway(page).FindTranslations(page);
		}

		#endregion

		#region Fetch.Ancestors

		/// <summary>
		/// Ancestors up to the start page
		/// </summary>
		public static IEnumerable<ContentItem> Ancestors(
				N2.ContentItem page = null,
				bool includeSelf = true,
				bool onlyVisible = false
			)
		{
			if (page == null) page = Fetch.CurrentPage;

			ItemFilter filters = N2.Content.Is.Accessible();
			filters += N2.Content.Is.Published();
			if (onlyVisible) filters += N2.Content.Is.Visible();

			return N2.Find.EnumerateParents(page, Fetch.RootPage, includeSelf).Where(filters);
		}

		public static N2.ContentItem AncestorAtLevel(N2.ContentItem page = null, int level = 0)
		{
			if (page == null) page = Fetch.CurrentPage;
			return Fetch.Ancestors(page, onlyVisible: false).Reverse().Skip(level).FirstOrDefault();
		}

		#endregion

		#region Fetch.Siblings

		public static IEnumerable<T> Siblings<T>(
				N2.ContentItem page = null,
				bool includeSelf = false,
				bool onlyVisible = false
			)
		{
			if (page == null) page = Fetch.CurrentPage;

			ItemFilter filters = N2.Content.Is.Accessible();
			filters += N2.Content.Is.Published();
			if (onlyVisible) filters += N2.Content.Is.Visible();

			if (includeSelf)
			{
				return N2.Content.Traverse.Siblings(page, filters).OfType<T>();
			}
			else
			{
				return N2.Content.Traverse.Siblings(page, filters).Except(new[] { page }).OfType<T>();
			}
		}

		public static IEnumerable<ContentItem> Siblings(
				N2.ContentItem page = null,
				bool includeSelf = false,
				bool onlyVisible = false
			)
		{
			if (page == null) page = Fetch.CurrentPage;

			return Fetch.Siblings<N2.ContentItem>
				(
					page: page,
					includeSelf: includeSelf,
					onlyVisible: onlyVisible
				);
		}

		public static N2.ContentItem PrevSibling(N2.ContentItem item = null)
		{
			if (item == null) item = Fetch.CurrentPage;
			return N2.Content.Traverse.PreviousSibling(item);
		}

		public static T PrevSibling<T>(N2.ContentItem item = null, bool wrap = false) where T : class
		{
			if (item == null) item = Fetch.CurrentPage;
			N2.ContentItem currSibling = Fetch.PrevSibling(item);
			while ((currSibling != null) && (!(currSibling is T)))
			{
				currSibling = Fetch.PrevSibling(currSibling);
			}

			if (currSibling != null && currSibling is T)
			{
				return currSibling as T;
			}
			else
			{
				if (wrap)
				{
					return Fetch.Siblings<T>().LastOrDefault();
				}
				else
				{
					return default(T);
				}
			}
		}

		public static N2.ContentItem NextSibling(N2.ContentItem item = null)
		{
			if (item == null) item = Fetch.CurrentPage;
			return N2.Content.Traverse.NextSibling(item);
		}

		public static T NextSibling<T>(N2.ContentItem item = null, bool wrap = false) where T : class
		{
			if (item == null) item = Fetch.CurrentPage;
			N2.ContentItem currSibling = Fetch.NextSibling(item);
			while ((currSibling != null) && (!(currSibling is T)))
			{
				currSibling = Fetch.NextSibling(currSibling);
			}

			if (currSibling != null && currSibling is T)
			{
				return currSibling as T;
			}
			else
			{
				if (wrap)
				{
					return Fetch.Siblings<T>().FirstOrDefault();
				}
				else
				{
					return default(T);
				}
			}
		}

		#endregion

		#region Fetch.ClosestMatch

		public static N2.ContentItem ClosestMatch(string url)
		{
			return N2.Content.Traverse.Path(url).StopItem;
		}

		#endregion
	}
}