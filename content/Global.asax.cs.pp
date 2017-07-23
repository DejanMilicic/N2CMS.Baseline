
namespace $rootnamespace$
{
	using System.Web.Mvc;
	using System.Web.Routing;
	using $rootnamespace$.N2Baseline.Interfaces.ContentItemActions;
    using System;

	public class Global : System.Web.HttpApplication
	{
		protected void Application_Start()
		{
			AreaRegistration.RegisterAllAreas();
			RouteConfig.RegisterRoutes(RouteTable.Routes);

			N2.Context.Current.Persister.ItemSaved += Persister_ItemSaved;
		}

		protected void Application_End(object sender, EventArgs e)
	    {
	        N2.Context.Current.Persister.ItemSaved -= Persister_ItemSaved;
	    }

	    private void Persister_ItemSaved(object sender, N2.ItemEventArgs e)
	    {
	        // check if item is not deleted
	        if (e.AffectedItem is ISaved && e.AffectedItem.State != N2.ContentState.Deleted)
	        {
	            (e.AffectedItem as ISaved).OnSaved(e.AffectedItem, e);
	        }
	    }
	}
}