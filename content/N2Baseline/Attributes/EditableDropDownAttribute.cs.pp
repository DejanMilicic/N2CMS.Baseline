using System;
using System.Collections.Generic;
using System.Web.UI;
using System.Web.UI.WebControls;
using N2;
using N2.Details;

namespace $rootnamespace$.N2Baseline.Attributes
{
	[AttributeUsage(AttributeTargets.Property)]
	public abstract class EditableDropDownAttribute : AbstractEditableAttribute
	{
		public override bool UpdateItem(ContentItem item, Control editor)
		{
			DropDownList ddl = editor as DropDownList;
			if (ddl.SelectedValue != item[Name] as string)
			{
				item[Name] = ddl.SelectedValue;
				return true;
			}
			return false;
		}

		public override void UpdateEditor(ContentItem item, Control editor)
		{
			DropDownList ddl = editor as DropDownList;
			if (ddl.Items.FindByValue(item[Name] as string) != null)
				ddl.SelectedValue = item[Name] as string;
		}

		public override Control AddTo(Control container)
		{
			Control panel = AddPanel(container);
			AddLabel(panel);
			Control ddl = AddDropDown(panel);
			if (Validate)
				AddRegularExpressionValidator(panel, ddl);
			if (Required)
				AddRequiredFieldValidator(panel, ddl);
			return ddl;
		}

		private Control AddDropDown(Control panel)
		{
			DropDownList ddl = new DropDownList();
			foreach (ListItem li in GetListItems(panel))
			{
				ddl.Items.Add(li);
			}
			ddl.ID = Name;
			panel.Controls.Add(ddl);
			return ddl;
		}

		protected override Control AddEditor(Control container)
		{
			throw new Exception("The method or operation is not implemented.");
		}

		protected abstract IEnumerable<ListItem> GetListItems(Control container);
	}
}