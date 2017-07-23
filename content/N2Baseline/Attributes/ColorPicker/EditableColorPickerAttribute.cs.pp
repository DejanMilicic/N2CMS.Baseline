using System;
using System.Linq;
using System.Web.UI.WebControls;
using N2.Details;
using N2.Resources;

namespace $rootnamespace$.N2Baseline.Attributes.ColorPicker
{
	[AttributeUsage(AttributeTargets.Property)]
	public class EditableColorPickerAttribute : EditableTextBoxAttribute
	{
		bool _hashSymbol = false;
		bool _requiredValue = false;
		bool _caps = true;

		public EditableColorPickerAttribute(string title, int sortOrder, bool hashSymbol, bool requiredValue, bool caps)
			: base(title, sortOrder)
		{
			this.HashSymbol = hashSymbol;
			this.RequiredValue = requiredValue;
			this.Caps = caps;
		}

		public EditableColorPickerAttribute(string title, int sortOrder, bool hashSymbol, bool requiredValue)
			: base(title, sortOrder)
		{
			this.HashSymbol = hashSymbol;
			this.RequiredValue = requiredValue;
		}

		public EditableColorPickerAttribute(string title, int sortOrder, bool hashSymbol)
			: base(title, sortOrder)
		{
			this.HashSymbol = hashSymbol;
		}

		public EditableColorPickerAttribute(string title, int sortOrder)
			: base(title, sortOrder)
		{
		}

		public EditableColorPickerAttribute()
			: base(null, 50)
		{

		}

		#region Properties

		public bool HashSymbol
		{
			get { return this._hashSymbol; }
			set { this._hashSymbol = value; }
		}

		public bool RequiredValue
		{
			get { return this._requiredValue; }
			set { this._requiredValue = value; }
		}

		public bool Caps
		{
			get { return this._caps; }
			set { this._caps = value; }
		}

		#endregion

		/// <summary>
		/// Since we want to add script load and custom cssclass color.
		/// </summary>
		/// <param name="container">The panel onto which the text box was added.</param>
		/// <returns>The editor control that was added.</returns>
		protected override System.Web.UI.Control AddEditor(System.Web.UI.Control container)
		{
			TextBox textbox = new TextBox();

			textbox.CssClass = "color {";
			textbox.CssClass += String.Join(",", (new[]
				{
					HashSymbol ? "hash:true" : "",
					!RequiredValue ? "required:false" : "",
					!Caps ? "caps:false" : "",
				})
				.ToList().Where(str => !String.IsNullOrWhiteSpace(str))
			);
			textbox.CssClass += "}";

			container.Controls.Add(textbox);

			textbox.Page.JavaScript("/N2Baseline/Attributes/ColorPicker/UI/jscolor.js");

			return textbox;
		}
	}
}