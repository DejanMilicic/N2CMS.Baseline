
namespace $rootnamespace$.N2Baseline.Controllers
{
	using System.Web.Mvc;

	using N2.Web.Mvc;

	public class BaseN2Controller<T> : ContentController<T> where T : N2.ContentItem
	{
		public override ActionResult Index()
		{
			return this.CurrentItem.IsPage
				? this.View(string.Format("N2Pages/{0}", this.CurrentItem.GetContentType().Name), this.CurrentItem)
				: this.PartialView(string.Format("N2Parts/{0}", this.CurrentItem.GetContentType().Name), this.CurrentItem);
		}

		protected new ViewResultBase View(object model)
		{
			N2.ContentItem item = ExtractFromModel(model) ?? this.CurrentItem;

			if (item != null && !item.IsPage)
				return this.PartialView(model);

			return base.View(model);
		}

		protected new ViewResultBase View(string viewName, object model)
		{
			N2.ContentItem item = ExtractFromModel(model) ?? this.CurrentItem;

			if (item != null && !item.IsPage)
				return this.PartialView(viewName, model);

			return base.View(viewName, model);
		}

		private static N2.ContentItem ExtractFromModel(object model)
		{
			var item = model as N2.ContentItem;

			if (item != null)
				return item;

			var itemContainer = model as N2.Web.UI.IItemContainer;

			return itemContainer != null ? itemContainer.CurrentItem : null;
		}
	}
}