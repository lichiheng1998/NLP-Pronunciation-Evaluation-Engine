# NLP Pronunciation Evaluation Engine
Using NLP/ML algorithms and statistical models to evaluate the pronunciation levels

Feature extraction: 

Used PocketSphinx system’s alignment routines: a two-pass alignment approach over a fixed grammar by using the time endpoints in recognizing the phonemes of the expected utterance, using a finite state grammar defined by JSpeech Grammar Format. 
Applied Cepstral mean normalization to the first pass of the alignment for adapting audio characteristics. 
For the second pass, used PocketSphinx phoneme alignment API to select sub-segments from the audio 
For each sub-segments, run the recognizer; 
Acoustic score: For three aligned phonemes at a time in sequence, counted how soon the expected phoneme occurs in the n-best recognition results
Substitution: For three adjacent phonemes at a time in the alignment, used a grammar specifying the first and the last phonemes; counted how high the expected middle phoneme ranks in the n-best results of all possible phonemes in between(n usually takes 30), represented as a score between [0, 1] 
Insertion/deletion: For two aligned phonemes at a time in sequence, used a grammar to look for the first expected phoneme, followed by an optional not expected phonemes including silence counted as insertion, and then followed by an optional expected phoneme to account for deletion. Each time insertion/deletion appeared, the [0, 1] substitution score was reduced.
Produced each phoneme’s duration and the logarithm of its acoustic score as features in our DNN classifier feature inputs. For each word, applied the first 4 features for each phoneme in the word, plus the 5th feature for the whole word. Below is the feature vector for each phoneme in the word:
A duration
An acoustic score from the alignment phase
[0, 1] score for substitution
0, 1] score with reductions after insertion/deletion detected
An additional insertion and deletion score at the end of the feature vector for the word, which is identical to the first insertion/deletion score of the next word. 

Training and results:

Used non-standard PocketSphinx parameters with a frame rate of 65 per second, -topn value of 64.
Used 4 features per phoneme described above with support vector machine classification routines from the Python Scikit-learn SVC library configured with a radial basis functional kernel and probability prediction. 
Obtained 82% accuracy using DNN, 75% accuracy using linear logistic regression model.
