json.unlabeled_citations_projects do
  json.array!(@unlabeled_citations_projects) do |citations_project|
    citation = citations_project.citation

    json.citations_project_id citations_project.id
    json.name citation.name
    json.abstract citation.abstract
    json.pmid citation.pmid
    json.refman citation.refman
    if citation.journal.present?
      json.journal do
        json.publication_date citation.journal.publication_date
        json.name citation.journal.name
        json.volume citation.journal.volume
        json.issue citation.journal.issue
      end
    end
    json.authors do
      json.array! citation.authors, :id, :name
    end
    json.keywords do
      json.array! citation.keywords, :id, :name
    end
    
    ## Not sure if we will ever display taggings that are not created by the screener, but we currently send the projects_users_role info regardless
    json.taggings @unlabeled_taggings[ citations_project.id ] do |tagging|
      json.id tagging.id
      json.tag do
        json.name tagging.tag.name
        json.id tagging.tag.id
      end
    end

    json.notes ( @unlabeled_notes[ citations_project.id ] || [] )[ 0 .. 0 ] do |note|
      json.id note.id
      json.value note.value
    end
  end
end

json.labeled_citations_projects do
  json.array!(@past_labels) do |label|
    citation = label.citations_project.citation
    citations_project = label.citations_project

    json.citations_project_id citations_project.id
    json.name citation.name
    json.abstract citation.abstract
    json.pmid citation.pmid
    json.refman citation.refman
    if citation.journal.present?
      json.journal do
        json.publication_date citation.journal.publication_date
        json.name citation.journal.name
        json.volume citation.journal.volume
        json.issue citation.journal.issue
      end
    end
    json.authors do
      json.array! citation.authors, :id, :name
    end
    json.keywords do
      json.array! citation.keywords, :id, :name
    end

    json.taggings @labeled_taggings[ citations_project.id ] do |tagging|
      json.id tagging.id
      json.tag do
        json.name tagging.tag.name
        json.id tagging.tag.id
      end
    end

    json.notes ( @labeled_notes[ citations_project.id ] || [] )[ 0 .. 0 ] do |note|
      json.id note.id
      json.value note.value
    end

    json.label do
      json.id label.id
      json.label_type_id label.label_type_id
      json.projects_users_role_id label.projects_users_role_id
      json.created_at label.created_at
      json.updated_at label.updated_at
      json.labels_reasons label.labels_reasons do |labels_reason|
        json.id labels_reason.id
        json.reason do
          json.name labels_reason.reason.name
          json.id labels_reason.reason.id
        end
      end
    end
  end
end

json.options @assignment_options do |option|
  json.type option.assignment_option_type.name
  json.label_type option.label_type.name
end
