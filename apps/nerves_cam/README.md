# NervesCam

Provices a Streamer Plug over the [Picam](https://hex.pm/packages/picam) package. It is lifted from the example application for the ElixirConf 2017 Nerves training.

The `Nerves.Picam` GenServer must be started from the main firmware application. Starting it here leads to errors, probably caused by timing.


The error is " raspijpgs: No imagers detected!" and is raised in the Picam C code when none are (indeed) deteted.
