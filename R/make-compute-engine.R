library(googleComputeEngineR)

## construct the correct tag name for your custom image
tag <- gce_tag_container("bioc_rstudio")
# gcr.io/mark-edmondson-gde/my_rstudio

## start a 50GB RAM instance
vm <- gce_vm(name = "rstudio-big",
              predefined_type = "e2-highmem-8",
              template = "rstudio",
              dynamic_image = "bioconductor/bioconductor_docker:devel",
              username = "kirk", password = "pass1234",
              disk_size_gb = 100)

## wait for it to launch
# gce_push_registry(vm, save_name = "my_rstudio", container_name = "rstudio")

# gce_vm_stop(vm)