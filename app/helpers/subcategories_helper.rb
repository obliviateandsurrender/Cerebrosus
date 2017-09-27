module SubcategoriesHelper
    def cat(id)
        @cat = Category.find(id)
        rescue ActiveRecord::RecordNotFound
    end
end
