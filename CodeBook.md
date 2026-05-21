# CodeBook — Getting and Cleaning Data Course Project

## Source Data

Raw data collected from the accelerometers of Samsung Galaxy S smartphones worn by 30 volunteers performing six activities.

Original source: [UCI HAR Dataset](http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones)

Download: `https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip`

---

## Transformations Applied

1. **Merged** `train` and `test` partitions (X, y, subject files) into one data frame using `rbind()`.
2. **Extracted** only the 66 measurements that are means or standard deviations (columns whose original names contain `mean()` or `std()`).
3. **Replaced** integer activity codes with descriptive labels from `activity_labels.txt` (e.g., `1` → `WALKING`).
4. **Renamed** all variable names to be human-readable:
   - Leading `t` → `time`, leading `f` → `frequency`
   - `Acc` → `Accelerometer`, `Gyro` → `Gyroscope`, `Mag` → `Magnitude`
   - `BodyBody` → `Body` (corrects a duplication in the raw data)
   - Parentheses and dots removed; `mean`/`std` capitalised
5. **Summarised** by computing the **mean** of every measurement variable for each `subject × activity` combination, producing 180 rows (30 subjects × 6 activities).

---

## Output File: `tidy_data.txt`

180 rows × 68 columns. Written with `write.table(..., row.names = FALSE)`.

---

## Variables

### Identifiers

| Variable | Type | Values |
|---|---|---|
| `subject` | integer | 1–30 — ID of the volunteer |
| `activity` | character | WALKING, WALKING_UPSTAIRS, WALKING_DOWNSTAIRS, SITTING, STANDING, LAYING |

### Measurement Variables (columns 3–68)

Each of the 66 measurement columns contains the **average** of that measurement for the given subject and activity. All values are normalised and bounded within [−1, 1] (dimensionless).

Naming convention: `{domain}{Sensor}{Statistic}{Axis}`

| Part | Meaning |
|---|---|
| `time` | Time-domain signal |
| `frequency` | Frequency-domain signal (FFT applied) |
| `Accelerometer` | Linear acceleration (from accelerometer) |
| `Gyroscope` | Angular velocity (from gyroscope) |
| `Body` | Body component of the signal |
| `Gravity` | Gravity component of the signal |
| `Jerk` | Jerk signal (time derivative) |
| `Magnitude` | Euclidean magnitude of 3-D signal |
| `Mean` | Mean value |
| `Std` | Standard deviation |
| `X` / `Y` / `Z` | 3-axial direction |

#### Complete list of measurement columns

```
timeBodyAccelerometerMeanX
timeBodyAccelerometerMeanY
timeBodyAccelerometerMeanZ
timeBodyAccelerometerStdX
timeBodyAccelerometerStdY
timeBodyAccelerometerStdZ
timeGravityAccelerometerMeanX
timeGravityAccelerometerMeanY
timeGravityAccelerometerMeanZ
timeGravityAccelerometerStdX
timeGravityAccelerometerStdY
timeGravityAccelerometerStdZ
timeBodyAccelerometerJerkMeanX
timeBodyAccelerometerJerkMeanY
timeBodyAccelerometerJerkMeanZ
timeBodyAccelerometerJerkStdX
timeBodyAccelerometerJerkStdY
timeBodyAccelerometerJerkStdZ
timeBodyGyroscopeMeanX
timeBodyGyroscopeMeanY
timeBodyGyroscopeMeanZ
timeBodyGyroscopeStdX
timeBodyGyroscopeStdY
timeBodyGyroscopeStdZ
timeBodyGyroscopeJerkMeanX
timeBodyGyroscopeJerkMeanY
timeBodyGyroscopeJerkMeanZ
timeBodyGyroscopeJerkStdX
timeBodyGyroscopeJerkStdY
timeBodyGyroscopeJerkStdZ
timeBodyAccelerometerMagnitudeMean
timeBodyAccelerometerMagnitudeStd
timeGravityAccelerometerMagnitudeMean
timeGravityAccelerometerMagnitudeStd
timeBodyAccelerometerJerkMagnitudeMean
timeBodyAccelerometerJerkMagnitudeStd
timeBodyGyroscopeMagnitudeMean
timeBodyGyroscopeMagnitudeStd
timeBodyGyroscopeJerkMagnitudeMean
timeBodyGyroscopeJerkMagnitudeStd
frequencyBodyAccelerometerMeanX
frequencyBodyAccelerometerMeanY
frequencyBodyAccelerometerMeanZ
frequencyBodyAccelerometerStdX
frequencyBodyAccelerometerStdY
frequencyBodyAccelerometerStdZ
frequencyBodyAccelerometerJerkMeanX
frequencyBodyAccelerometerJerkMeanY
frequencyBodyAccelerometerJerkMeanZ
frequencyBodyAccelerometerJerkStdX
frequencyBodyAccelerometerJerkStdY
frequencyBodyAccelerometerJerkStdZ
frequencyBodyGyroscopeMeanX
frequencyBodyGyroscopeMeanY
frequencyBodyGyroscopeMeanZ
frequencyBodyGyroscopeStdX
frequencyBodyGyroscopeStdY
frequencyBodyGyroscopeStdZ
frequencyBodyAccelerometerMagnitudeMean
frequencyBodyAccelerometerMagnitudeStd
frequencyBodyAccelerometerJerkMagnitudeMean
frequencyBodyAccelerometerJerkMagnitudeStd
frequencyBodyGyroscopeMagnitudeMean
frequencyBodyGyroscopeMagnitudeStd
frequencyBodyGyroscopeJerkMagnitudeMean
frequencyBodyGyroscopeJerkMagnitudeStd
```
