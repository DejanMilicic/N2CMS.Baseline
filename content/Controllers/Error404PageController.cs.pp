
namespace $rootnamespace$.Controllers
{
	using System.Web.Mvc;
	using N2.Web;

	using $rootnamespace$.Models;

	[Controls(typeof(Error404Page))]
	public class Error404PageController : Controller
	{
		// GET: Error404Page
		public ActionResult Index()
		{
			return View();
		}
	}
}