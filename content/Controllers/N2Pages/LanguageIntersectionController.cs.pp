
namespace $rootnamespace$.Controllers.N2Pages
{
	using System.Web.Mvc;

	using N2;
	using N2.Web;
	using N2.Web.Mvc;

	using $rootnamespace$.Models.N2Pages;
	using $rootnamespace$.N2Baseline;

	[Controls(typeof(LanguageIntersection))]
	public class LanguageIntersectionController : ContentController<LanguageIntersection>
	{
		public override ActionResult Index()
		{
			ContentItem language = Request.SelectLanguage(CurrentItem);
			if (language != null)
			{
				if (language.Url.StartsWith("http"))
					return Redirect(language.Url);

				return ViewPage(language);
			}

			if (CurrentItem.RedirectUrl != CurrentItem.Url)
				return Redirect(CurrentItem.RedirectUrl);

			return View(CurrentItem);
		}
	}
}