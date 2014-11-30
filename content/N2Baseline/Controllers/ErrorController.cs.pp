
namespace $rootnamespace$.N2Baseline.Controllers
{
	using System.Linq;
	using System.Web.Mvc;

	using N2;
	using N2.Web.Mvc;

	using $rootnamespace$.Models.N2Pages;
	using $rootnamespace$.N2Baseline;
	using $rootnamespace$.N2Baseline.Interfaces;

	public class ErrorController : ContentController
	{
		// GET: Error
		public ActionResult Error404()
		{
			this.Response.StatusCode = 404;
			this.Response.StatusDescription = "File not found";

			ContentItem closestStartPage = Fetch.FindStartPageOfPath(this.Request.RawUrl);

			if (closestStartPage is LanguageIntersection)
			{
				closestStartPage = (closestStartPage as LanguageIntersection).RedirectTo;
			}

			IPage404 page404 = Fetch.Descendents<IPage404>(closestStartPage).FirstOrDefault();

			if (page404 != null)
			{
				return this.ViewPage(page404 as N2.ContentItem);
			}
			else
			{
				return this.Content("Error 404");
			}
		}
	}
}