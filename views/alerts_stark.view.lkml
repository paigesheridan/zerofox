view: alerts_stark {
  sql_table_name: `brewer-test.csv_datasets.alerts_stark`
    ;;

  dimension: a_records {
    type: string
    sql: ${TABLE}.A_Records ;;
  }

  dimension: alert_id {
    type: number
    sql: ${TABLE}.Alert_ID ;;
  }

  dimension: alert_type {
    type: string
    sql: ${TABLE}.Alert_Type ;;
  }

  dimension: assignee {
    type: string
    sql: ${TABLE}.Assignee ;;
  }

  dimension: closed {
    type: string
    sql: ${TABLE}.Closed ;;
  }

  dimension: confirmed_phishing {
    type: yesno
    sql: ${TABLE}.Confirmed_Phishing ;;
  }

  dimension: content_creation_date {
    type: string
    sql: ${TABLE}.Content_Creation_Date ;;
  }

  dimension: content_removed {
    type: string
    sql: ${TABLE}.Content_Removed ;;
  }

  dimension_group: created {
    type: time
    timeframes: [
      raw,
      time,
      day_of_week,
      date,
      week,
      month,
      quarter,
      year
    ]
    sql: ${TABLE}.Created_At ;;
  }


  dimension: domain_live {
    type: yesno
    sql: ${TABLE}.Domain_Live ;;
  }

  dimension: domain_matching_type {
    type: string
    sql: ${TABLE}.Domain_Matching_Type ;;
  }

  dimension: domain_redirects {
    type: string
    sql: ${TABLE}.Domain_Redirects ;;
  }

  dimension: entity_id {
    type: number
    sql: ${TABLE}.Entity_ID ;;
  }

  dimension: entity_name {
    type: string
    sql: ${TABLE}.Entity_Name ;;
  }

  dimension: entity_tags {
    type: string
    sql: ${TABLE}.Entity_Tags ;;
  }

  dimension: escalated {
    type: yesno
    sql: ${TABLE}.Escalated ;;
  }

  dimension: escalated_date {
    type: string
    sql: ${TABLE}.Escalated_Date ;;
  }

  dimension: keywords {
    type: string
    sql: ${TABLE}.Keywords ;;
  }

  dimension_group: last_modified {
    type: time
    timeframes: [
      raw,
      time,
      date,
      week,
      month,
      quarter,
      year
    ]
    sql: ${TABLE}.Last_Modified ;;
  }


  dimension: location_ids {
    type: string
    sql: ${TABLE}.Location_IDs ;;
  }

  dimension: matching_term {
    type: string
    sql: ${TABLE}.Matching_Term ;;
  }

  dimension: mx_records {
    type: string
    sql: ${TABLE}.MX_Records ;;
  }

  dimension: network_name {
    type: string
    sql: ${TABLE}.Network_Name ;;
  }

  dimension: not_helpful {
    type: string
    sql: ${TABLE}.Not_Helpful ;;
  }

  dimension: notes {
    type: string
    sql: ${TABLE}.Notes ;;
  }

  dimension: offending_content_url {
    type: string
    sql: ${TABLE}.Offending_Content_URL ;;
  }

  dimension: perpetrator_display_name {
    type: string
    sql: ${TABLE}.Perpetrator_Display_Name ;;
  }

  dimension: perpetrator_id {
    type: string
    sql: ${TABLE}.Perpetrator_ID ;;
  }

  dimension: perpetrator_type {
    type: string
    sql: ${TABLE}.Perpetrator_Type ;;
  }

  dimension: perpetrator_username {
    type: string
    sql: ${TABLE}.Perpetrator_Username ;;
  }

  dimension: registrar {
    type: string
    sql: ${TABLE}.Registrar ;;
  }

  dimension: reviewed_date {
    type: string
    sql: ${TABLE}.Reviewed_Date ;;
  }

  dimension: rule_id {
    type: number
    sql: ${TABLE}.Rule_ID ;;
  }

  dimension: rule_name {
    type: string
    sql: ${TABLE}.Rule_Name ;;
  }

  dimension: screenshot_url {
    type: string
    sql: ${TABLE}.Screenshot_URL ;;
  }

  dimension: security_banner_inserted {
    type: string
    sql: ${TABLE}.Security_Banner_Inserted ;;
  }

  dimension: severity {
    type: string
    sql: CASE WHEN ${TABLE}.Severity = 1 then "Info"
    WHEN ${TABLE}.Severity = 2 then "Low"
    WHEN ${TABLE}.Severity = 3 then "Medium"
    WHEN ${TABLE}.Severity = 4 then "High"
    WHEN ${TABLE}.Severity = 5 then "Critical" ELSE null end;;
  }

  measure: count_critical_alerts {
    type: count
    filters: [severity: "Critical"]
  }

  measure: percent_critical_alerts {
    type: number
    sql: 1.0*${count_critical_alerts}/nullif(${count},0) ;;
    value_format_name: percent_1
  }

  measure: count_high_alerts {
    type: count
    filters: [severity: "High"]
  }

  measure: percent_high_alerts {
    type: number
    sql: 1.0*${count_high_alerts}/nullif(${count},0) ;;
    value_format_name: percent_1
  }

  dimension: status {
    type: string
    sql: ${TABLE}.Status ;;
  }

  dimension: tags {
    type: string
    sql: ${TABLE}.Tags ;;
  }

  dimension_group: takedown_accepted {
    type: time
    timeframes: [raw,time,date,week]
    sql:  CASE WHEN ${TABLE}.takedown_accepted = "N/A" THEN null ELSE TIMESTAMP(${TABLE}.takedown_accepted) END ;;
  }

  dimension_group: takedown_denied {
    type: time
    timeframes: [raw,time,date,week]
    sql:  CASE WHEN ${TABLE}.Takedown_Denied = "N/A" THEN null ELSE TIMESTAMP(${TABLE}.Takedown_Denied) END;;
  }

  dimension_group: takedown_requested {
    type: time
    timeframes: [raw,time,date,week]
    sql: CASE WHEN ${TABLE}.takedown_requested = "N/A" THEN null ELSE TIMESTAMP(${TABLE}.takedown_requested) END;;
  }

  dimension: time_to_takedown {
    label: "Time to Takedown"
    type: number
    sql:TIMESTAMP_DIFF(${takedown_accepted_raw},${takedown_requested_raw},minute) ;;
  }

  measure: average_time_to_takedown {
    label: "Average Time to Takedown (in minutes)"
    type: average
    sql: ${time_to_takedown} ;;
    value_format_name: decimal_1
  }

  dimension: typosquatting_strategy_name {
    type: string
    sql: ${TABLE}.Typosquatting_Strategy_Name ;;
  }

  measure: count {
    type: count
    drill_fields: [detail*]
  }

  # ----- Sets of fields for drilling ------
  set: detail {
    fields: [
      rule_name,
      perpetrator_display_name,
      typosquatting_strategy_name,
      entity_name,
      network_name,
      perpetrator_username
    ]
  }
}
