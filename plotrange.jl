# load packages -----------------------------------------------------------------------------
using DelimitedFiles
using CairoMakie
using OrderedCollections 


# load functions ----------------------------------------------------------------------------
include("ranges.jl");
include("functions.jl");


# generate plot -----------------------------------------------------------------------------
set_theme!(theme_light();)

filename = "open-raise-BU-cash.csv";
plotrange(filename, titleplot="Open-Raise BU (NL5)")
