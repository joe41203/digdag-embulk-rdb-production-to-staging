require 'gimei'
require 'romaji'
require 'faker'
require 'pry'

module Embulk
  module Filter

    class FakerFilterPlugin < FilterPlugin
      # filter plugin file name must be: embulk/filter/<name>.rb
      Plugin.register_filter('faker', self)

      def self.transaction(config, in_schema, &control)

        task = {
          columns_params: config.param('mask', :array, default: [])
        }

        out_columns = in_schema
        
        puts "task #{task}"
        puts "in_schema #{in_schema}"
        puts "out_columns #{out_columns}"

        puts "Faker filter started."
        yield(task, out_columns)
        puts "Faker filter finished."
      end

      def initialize(task, in_schema, out_schema, page_builder)
        super
        @columns_params = task['columns_params']
      end

      def close
      end

      def add(page)
        page.each do |record|
          @page_builder.add(fakered_record(page, record))
        end
      end

      def finish
        @page_builder.finish
      end

      private

      def fakered_record(page, record)
        @columns_params.each do |params|
          select_column = page.schema.select{ |c| c.name == params['name'] }
          embulk_col = select_column.first
          
          puts "page #{page}"
          puts "record #{record}"
          puts "params #{params}"
          puts "select_column #{select_column}"
          puts "embulk_col #{embulk_col}"
          record[embulk_col.index] = make_val(params)
        end
        puts "record2 #{record}"

        return record
      end

      def fakes
        gimei = Gimei.name
        
        return {
          name_kanji: gimei.kanji,
          name_romaji: (Romaji.kana2romaji gimei.katakana).split.map(&:capitalize).join(' '),
          email: Faker::Internet.email,
          address: Faker::Address.full_address
        }
      end

      def make_val(params)
        fakes[params["type"].to_sym]
      end
    end
  end
end
