setwd("C:/Users/Elham/EMG")
library(edfReader)
library(biosignalEMG)
files = dir(paste(getwd(),'/Bitaliano Recordings', sep=""))
Simple_mydata_Tension <-      data.frame ("patient_name" = "" , "v1" = 0, "v2" = 0, "v3" = 0, "v4" = 0, "v5" = 0, "v6" = 0, "label" = 0)
Simple_mydata_Movement <-     data.frame ("patient_name" = "" , "v1" = 0, "v2" = 0, "v3" = 0, "v4" = 0, "v5" = 0, "v6" = 0, "label" = 0)
Simple_mydata_Urge2Move <-    data.frame ("patient_name" = "" , "v1" = 0, "v2" = 0, "v3" = 0, "v4" = 0, "v5" = 0, "v6" = 0, "label" = 0)
Simple_mydata_Sensorimotor <- data.frame ("patient_name" = "" , "v1" = 0, "v2" = 0, "v3" = 0, "v4" = 0, "v5" = 0, "v6" = 0, "label" = 0)


Tension <- data.frame("patient_name" = c("boyle", "britt", "caleb", "cristian", "drgrecu",
                                         "Dripsiroglu","emmy", "graham", "hannah","kirsten", "nadia", "rachel", 
                                         "seamus", "silvia", "tina", "tyler","wing", "yik" ),
                      "label" = c(0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 1, 0, 0, 0, 1,0,1))

Movement <- data.frame("patient_name" = c("boyle", "britt", "caleb", "cristian", "drgrecu",
                                         "Dripsiroglu","emmy", "graham", "hannah","kirsten", "nadia", "rachel", 
                                         "seamus", "silvia", "tina", "tyler","wing", "yik" ),
                      "label" = c(0, 0, 0, 1, 1,0, 1,0,0,1,0,1,1,0,0,0,0,0))

Urge2Move <- data.frame("patient_name" = c("boyle", "britt", "caleb", "cristian", "drgrecu",
                                          "Dripsiroglu","emmy", "graham", "hannah","kirsten", "nadia", "rachel", 
                                          "seamus", "silvia", "tina", "tyler","wing", "yik" ),
                       "label" = c(1,0,0,0,0,0,0,1,0,0,0,0,1,0,0,1,0,0))

Sensorimotor <- data.frame("patient_name" = c("boyle", "britt", "caleb", "cristian", "drgrecu",
                                           "Dripsiroglu","emmy", "graham", "hannah","kirsten", "nadia", "rachel", 
                                           "seamus", "silvia", "tina", "tyler","wing", "yik" ),
                        "label" = c(0, 0, 1, 1, 0, 0, 1, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0))


for (i in 1: length(files))
{

        fname = paste(getwd(),'/Bitaliano Recordings/',files[i],sep="")
        just_file_name <- unlist(strsplit(files[i], split = " "))
        one_patient_name <- just_file_name[1]
        hdr <- readEdfHeader(fname)
        sig <- readEdfSignals(hdr, signals = "Ordinary", from = 0, till = Inf,
                              physical = TRUE, fragments = FALSE, recordStarts = FALSE,
                              mergeASignals = FALSE, simplify = TRUE)
        
        MySig <- sig$signal
        sig_sum <- as.numeric(summary(MySig))
        new <- data.frame("patient_name" = one_patient_name, 
                          "v1" = sig_sum[1], "v2" = sig_sum[2], 
                          "v3" = sig_sum[3], "v4" = sig_sum[4],  
                          "v5" = sig_sum[5], "v6" = sig_sum[6], 
                          "label" = Tension$label[Tension$patient_name == one_patient_name])
        Simple_mydata_Tension <- rbind(Simple_mydata_Tension, new)
        
        
        new <- data.frame("patient_name" = one_patient_name, 
                          "v1" = sig_sum[1], "v2" = sig_sum[2], 
                          "v3" = sig_sum[3], "v4" = sig_sum[4],  
                          "v5" = sig_sum[5], "v6" = sig_sum[6], 
                          "label" = Movement$label[Movement$patient_name == one_patient_name])
        Simple_mydata_Movement <- rbind(Simple_mydata_Movement, new)
        
        new <- data.frame("patient_name" = one_patient_name, 
                          "v1" = sig_sum[1], "v2" = sig_sum[2], 
                          "v3" = sig_sum[3], "v4" = sig_sum[4],  
                          "v5" = sig_sum[5], "v6" = sig_sum[6], 
                          "label" = Urge2Move$label[Urge2Move$patient_name == one_patient_name])
        Simple_mydata_Urge2Move <- rbind(Simple_mydata_Urge2Move, new)
        
        new <- data.frame("patient_name" = one_patient_name, 
                          "v1" = sig_sum[1], "v2" = sig_sum[2], 
                          "v3" = sig_sum[3], "v4" = sig_sum[4],  
                          "v5" = sig_sum[5], "v6" = sig_sum[6], 
                          "label" = Sensorimotor$label[Sensorimotor$patient_name == one_patient_name])
        Simple_mydata_Sensorimotor <- rbind(Simple_mydata_Sensorimotor, new)
        
}

