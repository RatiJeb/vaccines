module VaccineItems
  class VaccineItemService
    attr_reader :result

    def initialize
      @result = OpenStruct.new(success?: false, vaccine_item: VaccineItem.new)
    end

    def list
      VaccineItem.all
    end

    def new
      @result
    end

    def edit(id)
      find_record(id)
    end

    def create(params)
      result.tap do |r|
        r.vaccine_item = VaccineItem.new(params)
        r.send("success?=", r.vaccine_item.save)
      end
    end

    def update(id, params)
      find_record(id)

      result.tap do |r|
        r.send("success?=", r.vaccine_item.update(params))
      end
    end

    def delete(id)
      find_record(id)

      result.tap do |r|
        r.send("success?=", r.vaccine_item.destroy)
      end
    end

    private

    def find_record(id)
      result.vaccine_item = VaccineItem.find(id)
      result
    end
  end
end