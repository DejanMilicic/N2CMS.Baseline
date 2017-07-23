using System;
using System.Collections;
using System.Collections.Generic;
using System.Web.UI;
using System.Web.UI.WebControls;
using N2.Details;

namespace $rootnamespace$.N2Baseline.Attributes
{
	[AttributeUsage(AttributeTargets.Property)]
	public abstract class EditableCheckBoxListAttribute : AbstractEditableAttribute
	{
		public override bool UpdateItem(N2.ContentItem item, Control editor)
		{
			CheckBoxList cbl = editor as CheckBoxList;
			ArrayList items = new ArrayList();
			foreach (ListItem li in cbl.Items)
			{
				if (li.Selected)
				{
					items.Add(li.Value);
				}
			}
			string[] itemID = (string[])items.ToArray(typeof(string));
			item[this.Name] = String.Join(",", itemID);
			return true;
		}

		public override void UpdateEditor(N2.ContentItem item, Control editor)
		{
			CheckBoxList cbl = editor as CheckBoxList;
			if (cbl != null)
			{
				foreach (ListItem li in cbl.Items)
				{
					if (item[this.Name].ToString().Contains(li.Value))
					{
						li.Selected = true;
					}
				}
			}
		}

		public override Control AddTo(Control container)
		{
			Control panel = AddPanel(container);
			AddLabel(panel);
			Control cbl = AddCheckboxlist(panel);
			if (Validate)
				AddRegularExpressionValidator(panel, cbl);
			if (Required)
				AddRequiredFieldValidator(panel, cbl);
			return cbl;
		}

		private Control AddCheckboxlist(Control panel)
		{
			CheckBoxList cbl = new CheckBoxList();
			foreach (ListItem li in GetListItems(panel))
			{
				cbl.Items.Add(li);
			}
			cbl.ID = Name;
			panel.Controls.Add(cbl);
			return cbl;
		}

		protected override Control AddEditor(Control container)
		{
			throw new Exception("The method or operation is not implemented.");
		}

		protected abstract IEnumerable<ListItem> GetListItems(Control container);
	}
}