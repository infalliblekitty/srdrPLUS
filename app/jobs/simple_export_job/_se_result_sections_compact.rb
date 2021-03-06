require 'simple_export_job/sheet_info'

def build_result_sections_compact(p, project, highlight, wrap)
  project.extraction_forms_projects.each do |ef|
    ef.extraction_forms_projects_sections.each do |section|

      # If this is a type1 section then we proceed.
      if section.extraction_forms_projects_section_type_id == 3

        # Add a new sheet.
        p.workbook.add_worksheet(name: "#{ section.section.name }") do |sheet|

          # Every row represents an extraction.
          project.extractions.each do |extraction|
            eefps = section.extractions_extraction_forms_projects_sections.find_by(extraction: extraction, extraction_forms_projects_section: section)
          end  # project.extractions.each do |extraction|
        end  # END p.workbook.add_worksheet(name: "#{ section.section.name }") do |sheet|
      end  # END if section.extraction_forms_projects_section_type_id == 3
    end  # END ef.extraction_forms_projects_sections.each do |section|
  end  # END project.extraction_forms_projects.each do |ef|
end
