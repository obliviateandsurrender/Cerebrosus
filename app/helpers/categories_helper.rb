module CategoriesHelper
    def subcat(id)
        @subcat = Subcategory.find(categories_id: id)
        rescue ActiveRecord::RecordNotFound
    end
end
