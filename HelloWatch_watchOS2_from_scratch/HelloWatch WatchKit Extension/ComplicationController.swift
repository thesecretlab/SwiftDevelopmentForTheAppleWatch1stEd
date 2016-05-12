//
//  ComplicationController.swift
//  HelloWatch WatchKit Extension
//
//  Created by Jon Manning on 2/03/2016.
//  Copyright © 2016 Secret Lab. All rights reserved.
//

import ClockKit


// BEGIN complication_protocol
class ComplicationController: NSObject,
    CLKComplicationDataSource {
// END complication_protocol

    
    // BEGIN complication_typealiases
    // A "Meal" is an hour of the day, and the name of 
    // the meal to have at that hour.
    typealias Meal = (hour: Int, name: String)
    
    // A MealOccurrence is a specific meal that's had 
    // at a specific date and time.
    typealias MealOccurrence = (name: String, date: NSDate)
    // END complication_typealiases
    
    // BEGIN complication_meal_list
    // Define the list of meals.
    let meals : [Meal] = [
        (7, "Breakfast"),
        (9, "Second Breakfast"),
        (10, "Brunch"),
        (11, "Elevenses"),
        (13, "Lunch"),
        (16, "Tea"),
        (19, "Dinner"),
        (21, "Supper"),
        (23, "Snack")
    ]
    // END complication_meal_list
    
    // BEGIN complication_next_meal_occurrence
    func nextMealOccurrenceAfterDate(date: NSDate) -> MealOccurrence {
        // Determine the next MealOccurrence that happens after the provided date.
        
        let calendar = NSCalendar.currentCalendar()
        
        // Determine the date's hour value.
        let hour = calendar.components(NSCalendarUnit.Hour, fromDate: date).hour
        
        // Find the next Meal whose hour is after this date's hour.
        var selectedMeal : Meal? = nil
        
        for meal in meals  {
            if meal.hour > hour {
                selectedMeal = meal
                break
            }
        }
        
        // Stores the calculated date of this next meal's occurrence.
        var mealDate : NSDate
        
        if selectedMeal == nil {
            
            // No more meals take place today. The next meal will be the first
            // meal that occurs tomorrow.
            selectedMeal = meals[0]
        }
        
        // Calculate the date for this meal.
        
        // Start by getting a new date where the time is set to the start of
        // the meal's hour
        mealDate = calendar.dateBySettingHour(
            selectedMeal!.hour, minute: 0, second: 0,
            ofDate: NSDate(), options: [])!
        
        // If this date is BEFORE the specified date...
        if mealDate.earlierDate(date) == mealDate {
            // ...then we've wrapped around to the start of the day.
            // We should add one day to the date.
            mealDate = calendar.dateByAddingUnit(
                .Day, value: 1, toDate: mealDate, options: [])!
        }

        
        // Return the MealOccurrence - its name, and the date at which it's had.
        return (selectedMeal!.name, mealDate)
    }
    // END complication_next_meal_occurrence
    
    
    // BEGIN complication_timetravel
    func getSupportedTimeTravelDirectionsForComplication(
        complication: CLKComplication,
        withHandler handler: (CLKComplicationTimeTravelDirections) -> Void) {
        // Provides the direction of time travel that this complication can do.
        // In this case, we support forward time travel.
        handler([.Forward])
    }
    // END complication_timetravel
    
    // BEGIN complication_current_entry
    func getCurrentTimelineEntryForComplication(complication: CLKComplication,
         withHandler handler: (CLKComplicationTimelineEntry?) -> Void) {
        
        // Provides the current entry on the timeline.
        
        // Get the current date.
        let date = NSDate()
        
        // Get the next meal that happens after this date.
        let meal = nextMealOccurrenceAfterDate(date)
        
        // Get the template for this meal occurrence.
        let template = templateForMeal(meal, inComplication: complication)
        
        // Create an entry using this date and template.
        let entry = CLKComplicationTimelineEntry(date: date,
                                                 complicationTemplate: template)
        
        // Provide it to watchOS.
        handler(entry)
        
    }
    // END complication_current_entry
    
    // BEGIN complication_template
    func templateForMeal(mealOccurrence : MealOccurrence?,
         inComplication complication: CLKComplication) -> CLKComplicationTemplate {
        
        // Given a meal occurrence, creates and prepares a complication template.
        
        // Different complication families require different kinds of templates.
        // If you want to support different families, add more cases to this 
        // switch statement.
        
        let mealName = mealOccurrence?.name ?? "Next Meal"
        
        switch complication.family {
        case .UtilitarianLarge:
            
            // Create the template
            let t = CLKComplicationTemplateUtilitarianLargeFlat()
            
            t.textProvider = CLKSimpleTextProvider(
                text: mealName)
            
            return t;
        default:
            fatalError("Unsupported complication family: \(complication.family)")
        }
        
    }
    // END complication_template
    
    // BEGIN complication_future_entries
    func getTimelineEntriesForComplication(complication: CLKComplication,
         afterDate date: NSDate, limit: Int,
               withHandler handler: ([CLKComplicationTimelineEntry]?) -> Void) {
        
        // Provides the list of timeline entries that will take place in the 
        // future.
        
        var timelineEntries : [CLKComplicationTimelineEntry] = []
        
        // We'll create the list of timeline entries by figuring out the next meal
        // after nextMealDate, and then setting nextMealDate to that next 
        // meal's date. We can then repeat the process.
        var nextMealDate = date
        
        // We've been asked to create no more than 'limit' entries.
        for _ in 0..<limit {
            
            // Get the next meal after nextMealDate
            let nextOccurrence = nextMealOccurrenceAfterDate(nextMealDate)
            
            // Create the template and timeline entry for this meal
            let template = templateForMeal(
                nextOccurrence, inComplication: complication)
            let entry = CLKComplicationTimelineEntry(
                date: nextOccurrence.date, complicationTemplate: template)
            
            // Add it to the list
            timelineEntries.append(entry)
            
            // Next meal should be after this meal's date
            nextMealDate = nextOccurrence.date
            
        }
        
        // Provide the list to watchOS
        handler(timelineEntries)
        
    }
    // END complication_future_entries
    
    // BEGIN complication_placeholder
    func getPlaceholderTemplateForComplication(complication: CLKComplication,
         withHandler handler: (CLKComplicationTemplate?) -> Void) {
        
        // Provides a placeholder template for the complication, used in the 
        // complication selection screen.
        
        // Passing in 'nil' here because we're not actually trying to
        // show information, we just want the placeholder template.
        let template = templateForMeal(nil, inComplication: complication)
        
        handler(template)
    }
    // END complication_placeholder
    
    /*
    // MARK: - Timeline Configuration
    
    func getSupportedTimeTravelDirectionsForComplication(complication: CLKComplication, withHandler handler: (CLKComplicationTimeTravelDirections) -> Void) {
        handler([.Forward, .Backward])
    }
    
    func getTimelineStartDateForComplication(complication: CLKComplication, withHandler handler: (NSDate?) -> Void) {
        handler(nil)
    }
    
    func getTimelineEndDateForComplication(complication: CLKComplication, withHandler handler: (NSDate?) -> Void) {
        handler(nil)
    }
    
    func getPrivacyBehaviorForComplication(complication: CLKComplication, withHandler handler: (CLKComplicationPrivacyBehavior) -> Void) {
        handler(.ShowOnLockScreen)
    }
    
    // MARK: - Timeline Population
    
    func getCurrentTimelineEntryForComplication(complication: CLKComplication, withHandler handler: ((CLKComplicationTimelineEntry?) -> Void)) {
        // Call the handler with the current timeline entry
        handler(nil)
    }
    
    func getTimelineEntriesForComplication(complication: CLKComplication, beforeDate date: NSDate, limit: Int, withHandler handler: (([CLKComplicationTimelineEntry]?) -> Void)) {
        // Call the handler with the timeline entries prior to the given date
        handler(nil)
    }
    
    func getTimelineEntriesForComplication(complication: CLKComplication, afterDate date: NSDate, limit: Int, withHandler handler: (([CLKComplicationTimelineEntry]?) -> Void)) {
        // Call the handler with the timeline entries after to the given date
        handler(nil)
    }
    
    // MARK: - Update Scheduling
    
    func getNextRequestedUpdateDateWithHandler(handler: (NSDate?) -> Void) {
        // Call the handler with the date when you would next like to be given the opportunity to update your complication content
        handler(nil);
    }
    
    // MARK: - Placeholder Templates
    
    func getPlaceholderTemplateForComplication(complication: CLKComplication, withHandler handler: (CLKComplicationTemplate?) -> Void) {
        // This method will be called once per supported complication, and the results will be cached
        handler(nil)
    }
    */
}
