using N2;

namespace $rootnamespace$.N2Baseline.Interfaces.ContentItemActions
{
    /// <summary>
    /// Action that is executed after content item has been saved by N2
    /// </summary>
    interface ISaved
    {
        void OnSaved(ContentItem item, ItemEventArgs e);
    }
}