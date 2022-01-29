{
 "cells": [
  {
   "cell_type": "markdown",
   "id": "0d345e4a",
   "metadata": {},
   "source": [
    "### Thanks to the Bkmains' great efforts, this note book was entirely inspired from him"
   ]
  },
  {
   "cell_type": "code",
   "execution_count": null,
   "id": "0833f93f",
   "metadata": {},
   "outputs": [],
   "source": [
    "### Improting all the needed packages \n",
    "\n",
    "using Bootstrap \n",
    "using CSV \n",
    "using CategoricalArrays\n",
    "using Chain\n",
    "using DataFrames \n",
    "import Downloads\n",
    "using GLM \n",
    "using Plots \n",
    "using Random \n",
    "using StatsPlots \n",
    "using Statistics\n"
   ]
  },
  {
   "cell_type": "code",
   "execution_count": 20,
   "id": "bc84b7c1",
   "metadata": {},
   "outputs": [
    {
     "data": {
      "text/plain": [
       "\"participation.csv\""
      ]
     },
     "execution_count": 20,
     "metadata": {},
     "output_type": "execute_result"
    }
   ],
   "source": [
    "Downloads.download(\"https://vincentarelbundock.github.io/Rdatasets/csv/Ecdat/Participation.csv\", \n",
    "    \"participation.csv\")"
   ]
  },
  {
   "cell_type": "code",
   "execution_count": 24,
   "id": "bd6a5c86",
   "metadata": {},
   "outputs": [],
   "source": [
    "df_raw = CSV.read(\"participation.csv\", DataFrame)"
   ]
  },
  {
   "cell_type": "code",
   "execution_count": null,
   "id": "9c046bbb",
   "metadata": {},
   "outputs": [],
   "source": [
    "print(df_raw)"
   ]
  },
  {
   "cell_type": "code",
   "execution_count": 23,
   "id": "efe59f89",
   "metadata": {},
   "outputs": [
    {
     "data": {
      "text/html": [
       "<div class=\"data-frame\"><p>8 rows × 7 columns</p><table class=\"data-frame\"><thead><tr><th></th><th>variable</th><th>mean</th><th>min</th><th>median</th><th>max</th><th>nmissing</th><th>eltype</th></tr><tr><th></th><th title=\"Symbol\">Symbol</th><th title=\"Union{Nothing, Float64}\">Union…</th><th title=\"Any\">Any</th><th title=\"Union{Nothing, Float64}\">Union…</th><th title=\"Any\">Any</th><th title=\"Int64\">Int64</th><th title=\"DataType\">DataType</th></tr></thead><tbody><tr><th>1</th><td>Column1</td><td>436.5</td><td>1</td><td>436.5</td><td>872</td><td>0</td><td>Int64</td></tr><tr><th>2</th><td>lfp</td><td></td><td>no</td><td></td><td>yes</td><td>0</td><td>String3</td></tr><tr><th>3</th><td>lnnlinc</td><td>10.6856</td><td>7.1869</td><td>10.6431</td><td>12.3757</td><td>0</td><td>Float64</td></tr><tr><th>4</th><td>age</td><td>3.99553</td><td>2.0</td><td>3.9</td><td>6.2</td><td>0</td><td>Float64</td></tr><tr><th>5</th><td>educ</td><td>9.30734</td><td>1</td><td>9.0</td><td>21</td><td>0</td><td>Int64</td></tr><tr><th>6</th><td>nyc</td><td>0.311927</td><td>0</td><td>0.0</td><td>3</td><td>0</td><td>Int64</td></tr><tr><th>7</th><td>noc</td><td>0.982798</td><td>0</td><td>1.0</td><td>6</td><td>0</td><td>Int64</td></tr><tr><th>8</th><td>foreign</td><td></td><td>no</td><td></td><td>yes</td><td>0</td><td>String3</td></tr></tbody></table></div>"
      ],
      "text/latex": [
       "\\begin{tabular}{r|ccccccc}\n",
       "\t& variable & mean & min & median & max & nmissing & eltype\\\\\n",
       "\t\\hline\n",
       "\t& Symbol & Union… & Any & Union… & Any & Int64 & DataType\\\\\n",
       "\t\\hline\n",
       "\t1 & Column1 & 436.5 & 1 & 436.5 & 872 & 0 & Int64 \\\\\n",
       "\t2 & lfp &  & no &  & yes & 0 & String3 \\\\\n",
       "\t3 & lnnlinc & 10.6856 & 7.1869 & 10.6431 & 12.3757 & 0 & Float64 \\\\\n",
       "\t4 & age & 3.99553 & 2.0 & 3.9 & 6.2 & 0 & Float64 \\\\\n",
       "\t5 & educ & 9.30734 & 1 & 9.0 & 21 & 0 & Int64 \\\\\n",
       "\t6 & nyc & 0.311927 & 0 & 0.0 & 3 & 0 & Int64 \\\\\n",
       "\t7 & noc & 0.982798 & 0 & 1.0 & 6 & 0 & Int64 \\\\\n",
       "\t8 & foreign &  & no &  & yes & 0 & String3 \\\\\n",
       "\\end{tabular}\n"
      ],
      "text/plain": [
       "\u001b[1m8×7 DataFrame\u001b[0m\n",
       "\u001b[1m Row \u001b[0m│\u001b[1m variable \u001b[0m\u001b[1m mean     \u001b[0m\u001b[1m min    \u001b[0m\u001b[1m median  \u001b[0m\u001b[1m max     \u001b[0m\u001b[1m nmissing \u001b[0m\u001b[1m eltype   \u001b[0m\n",
       "\u001b[1m     \u001b[0m│\u001b[90m Symbol   \u001b[0m\u001b[90m Union…   \u001b[0m\u001b[90m Any    \u001b[0m\u001b[90m Union…  \u001b[0m\u001b[90m Any     \u001b[0m\u001b[90m Int64    \u001b[0m\u001b[90m DataType \u001b[0m\n",
       "─────┼──────────────────────────────────────────────────────────────────\n",
       "   1 │ Column1   436.5     1       436.5    872             0  Int64\n",
       "   2 │ lfp      \u001b[90m          \u001b[0m no     \u001b[90m         \u001b[0m yes             0  String3\n",
       "   3 │ lnnlinc   10.6856   7.1869  10.6431  12.3757         0  Float64\n",
       "   4 │ age       3.99553   2.0     3.9      6.2             0  Float64\n",
       "   5 │ educ      9.30734   1       9.0      21              0  Int64\n",
       "   6 │ nyc       0.311927  0       0.0      3               0  Int64\n",
       "   7 │ noc       0.982798  0       1.0      6               0  Int64\n",
       "   8 │ foreign  \u001b[90m          \u001b[0m no     \u001b[90m         \u001b[0m yes             0  String3"
      ]
     },
     "execution_count": 23,
     "metadata": {},
     "output_type": "execute_result"
    }
   ],
   "source": [
    "describe(df_raw)"
   ]
  },
  {
   "cell_type": "code",
   "execution_count": null,
   "id": "18c75eb7",
   "metadata": {},
   "outputs": [],
   "source": [
    "### Doing some adjustments over the data\n",
    "\n",
    "df = select(df_raw, :lfp => (x -> recode(x, \"yes\" => 1,\"no\" =>0)) => :lfp,\n",
    "            :lnnlinc,\n",
    "           :age,\n",
    "            :age => ByRow(x -> x^2) => :age²,\n",
    "            Between(:educ, :noc),\n",
    "            :foreign => categorical => :foreign)"
   ]
  },
  {
   "cell_type": "code",
   "execution_count": 30,
   "id": "c409c773",
   "metadata": {},
   "outputs": [
    {
     "data": {
      "text/html": [
       "<div class=\"data-frame\"><p>2 rows × 6 columns</p><table class=\"data-frame\"><thead><tr><th></th><th>lfp</th><th>lnnlinc_mean</th><th>age_mean</th><th>educ_mean</th><th>nyc_mean</th><th>noc_mean</th></tr><tr><th></th><th title=\"Int64\">Int64</th><th title=\"Float64\">Float64</th><th title=\"Float64\">Float64</th><th title=\"Float64\">Float64</th><th title=\"Float64\">Float64</th><th title=\"Float64\">Float64</th></tr></thead><tbody><tr><th>1</th><td>0</td><td>10.7513</td><td>4.08535</td><td>9.59448</td><td>0.409766</td><td>0.902335</td></tr><tr><th>2</th><td>1</td><td>10.6083</td><td>3.89002</td><td>8.97007</td><td>0.197007</td><td>1.07731</td></tr></tbody></table></div>"
      ],
      "text/latex": [
       "\\begin{tabular}{r|cccccc}\n",
       "\t& lfp & lnnlinc\\_mean & age\\_mean & educ\\_mean & nyc\\_mean & noc\\_mean\\\\\n",
       "\t\\hline\n",
       "\t& Int64 & Float64 & Float64 & Float64 & Float64 & Float64\\\\\n",
       "\t\\hline\n",
       "\t1 & 0 & 10.7513 & 4.08535 & 9.59448 & 0.409766 & 0.902335 \\\\\n",
       "\t2 & 1 & 10.6083 & 3.89002 & 8.97007 & 0.197007 & 1.07731 \\\\\n",
       "\\end{tabular}\n"
      ],
      "text/plain": [
       "\u001b[1m2×6 DataFrame\u001b[0m\n",
       "\u001b[1m Row \u001b[0m│\u001b[1m lfp   \u001b[0m\u001b[1m lnnlinc_mean \u001b[0m\u001b[1m age_mean \u001b[0m\u001b[1m educ_mean \u001b[0m\u001b[1m nyc_mean \u001b[0m\u001b[1m noc_mean \u001b[0m\n",
       "\u001b[1m     \u001b[0m│\u001b[90m Int64 \u001b[0m\u001b[90m Float64      \u001b[0m\u001b[90m Float64  \u001b[0m\u001b[90m Float64   \u001b[0m\u001b[90m Float64  \u001b[0m\u001b[90m Float64  \u001b[0m\n",
       "─────┼──────────────────────────────────────────────────────────────\n",
       "   1 │     0       10.7513   4.08535    9.59448  0.409766  0.902335\n",
       "   2 │     1       10.6083   3.89002    8.97007  0.197007  1.07731"
      ]
     },
     "execution_count": 30,
     "metadata": {},
     "output_type": "execute_result"
    }
   ],
   "source": [
    "### @chain is a macro from Chain.jl that makes it possible to do multiple group by in Julia \n",
    "### the chain function is downloads from the  Chain package \n",
    "@chain df begin \n",
    "    groupby(:lfp) \n",
    "    combine([:lnnlinc, :age, :educ, :nyc, :noc] .=> mean)\n",
    "end"
   ]
  },
  {
   "cell_type": "code",
   "execution_count": 31,
   "id": "669b645c",
   "metadata": {},
   "outputs": [
    {
     "data": {
      "text/html": [
       "<div class=\"data-frame\"><p>2 rows × 8 columns</p><table class=\"data-frame\"><thead><tr><th></th><th>lfp</th><th>lfp_mean</th><th>lnnlinc_mean</th><th>age_mean</th><th>age²_mean</th><th>educ_mean</th><th>nyc_mean</th><th>noc_mean</th></tr><tr><th></th><th title=\"Int64\">Int64</th><th title=\"Float64\">Float64</th><th title=\"Float64\">Float64</th><th title=\"Float64\">Float64</th><th title=\"Float64\">Float64</th><th title=\"Float64\">Float64</th><th title=\"Float64\">Float64</th><th title=\"Float64\">Float64</th></tr></thead><tbody><tr><th>1</th><td>0</td><td>0.0</td><td>10.7513</td><td>4.08535</td><td>18.0357</td><td>9.59448</td><td>0.409766</td><td>0.902335</td></tr><tr><th>2</th><td>1</td><td>1.0</td><td>10.6083</td><td>3.89002</td><td>15.9496</td><td>8.97007</td><td>0.197007</td><td>1.07731</td></tr></tbody></table></div>"
      ],
      "text/latex": [
       "\\begin{tabular}{r|cccccccc}\n",
       "\t& lfp & lfp\\_mean & lnnlinc\\_mean & age\\_mean & age²\\_mean & educ\\_mean & nyc\\_mean & noc\\_mean\\\\\n",
       "\t\\hline\n",
       "\t& Int64 & Float64 & Float64 & Float64 & Float64 & Float64 & Float64 & Float64\\\\\n",
       "\t\\hline\n",
       "\t1 & 0 & 0.0 & 10.7513 & 4.08535 & 18.0357 & 9.59448 & 0.409766 & 0.902335 \\\\\n",
       "\t2 & 1 & 1.0 & 10.6083 & 3.89002 & 15.9496 & 8.97007 & 0.197007 & 1.07731 \\\\\n",
       "\\end{tabular}\n"
      ],
      "text/plain": [
       "\u001b[1m2×8 DataFrame\u001b[0m\n",
       "\u001b[1m Row \u001b[0m│\u001b[1m lfp   \u001b[0m\u001b[1m lfp_mean \u001b[0m\u001b[1m lnnlinc_mean \u001b[0m\u001b[1m age_mean \u001b[0m\u001b[1m age²_mean \u001b[0m\u001b[1m educ_mean \u001b[0m\u001b[1m nyc_mean\u001b[0m ⋯\n",
       "\u001b[1m     \u001b[0m│\u001b[90m Int64 \u001b[0m\u001b[90m Float64  \u001b[0m\u001b[90m Float64      \u001b[0m\u001b[90m Float64  \u001b[0m\u001b[90m Float64   \u001b[0m\u001b[90m Float64   \u001b[0m\u001b[90m Float64 \u001b[0m ⋯\n",
       "─────┼──────────────────────────────────────────────────────────────────────────\n",
       "   1 │     0       0.0       10.7513   4.08535    18.0357    9.59448  0.409766 ⋯\n",
       "   2 │     1       1.0       10.6083   3.89002    15.9496    8.97007  0.197007\n",
       "\u001b[36m                                                                1 column omitted\u001b[0m"
      ]
     },
     "execution_count": 31,
     "metadata": {},
     "output_type": "execute_result"
    }
   ],
   "source": [
    "## If you want to have the calculated mean without the needed of listing the columns \n",
    "## manually, you can use the Real function \n",
    "\n",
    "@chain df begin \n",
    "    groupby(:lfp)\n",
    "    combine(names(df,Real) .=> mean)\n",
    "end"
   ]
  },
  {
   "cell_type": "code",
   "execution_count": 32,
   "id": "8892de02",
   "metadata": {},
   "outputs": [
    {
     "data": {
      "text/html": [
       "<div class=\"data-frame\"><p>4 rows × 3 columns</p><table class=\"data-frame\"><thead><tr><th></th><th>lfp</th><th>foreign</th><th>nrow</th></tr><tr><th></th><th title=\"Int64\">Int64</th><th title=\"CategoricalValue{String3, UInt32}\">Cat…</th><th title=\"Int64\">Int64</th></tr></thead><tbody><tr><th>1</th><td>0</td><td>no</td><td>402</td></tr><tr><th>2</th><td>0</td><td>yes</td><td>69</td></tr><tr><th>3</th><td>1</td><td>no</td><td>254</td></tr><tr><th>4</th><td>1</td><td>yes</td><td>147</td></tr></tbody></table></div>"
      ],
      "text/latex": [
       "\\begin{tabular}{r|ccc}\n",
       "\t& lfp & foreign & nrow\\\\\n",
       "\t\\hline\n",
       "\t& Int64 & Cat… & Int64\\\\\n",
       "\t\\hline\n",
       "\t1 & 0 & no & 402 \\\\\n",
       "\t2 & 0 & yes & 69 \\\\\n",
       "\t3 & 1 & no & 254 \\\\\n",
       "\t4 & 1 & yes & 147 \\\\\n",
       "\\end{tabular}\n"
      ],
      "text/plain": [
       "\u001b[1m4×3 DataFrame\u001b[0m\n",
       "\u001b[1m Row \u001b[0m│\u001b[1m lfp   \u001b[0m\u001b[1m foreign \u001b[0m\u001b[1m nrow  \u001b[0m\n",
       "\u001b[1m     \u001b[0m│\u001b[90m Int64 \u001b[0m\u001b[90m Cat…    \u001b[0m\u001b[90m Int64 \u001b[0m\n",
       "─────┼───────────────────────\n",
       "   1 │     0  no         402\n",
       "   2 │     0  yes         69\n",
       "   3 │     1  no         254\n",
       "   4 │     1  yes        147"
      ]
     },
     "execution_count": 32,
     "metadata": {},
     "output_type": "execute_result"
    }
   ],
   "source": [
    "## If you want to observe the number of rows per each lfp and the foreign \n",
    "@chain df begin \n",
    "    groupby([:lfp,:foreign]) ## here we are grouping by 2 columns namely :lfp and foreign \n",
    "    combine(nrow)\n",
    "end"
   ]
  },
  {
   "cell_type": "code",
   "execution_count": 33,
   "id": "951aedb2",
   "metadata": {},
   "outputs": [
    {
     "data": {
      "text/html": [
       "<div class=\"data-frame\"><p>2 rows × 3 columns</p><table class=\"data-frame\"><thead><tr><th></th><th>lfp</th><th>no</th><th>yes</th></tr><tr><th></th><th title=\"Int64\">Int64</th><th title=\"Union{Missing, Int64}\">Int64?</th><th title=\"Union{Missing, Int64}\">Int64?</th></tr></thead><tbody><tr><th>1</th><td>0</td><td>402</td><td>69</td></tr><tr><th>2</th><td>1</td><td>254</td><td>147</td></tr></tbody></table></div>"
      ],
      "text/latex": [
       "\\begin{tabular}{r|ccc}\n",
       "\t& lfp & no & yes\\\\\n",
       "\t\\hline\n",
       "\t& Int64 & Int64? & Int64?\\\\\n",
       "\t\\hline\n",
       "\t1 & 0 & 402 & 69 \\\\\n",
       "\t2 & 1 & 254 & 147 \\\\\n",
       "\\end{tabular}\n"
      ],
      "text/plain": [
       "\u001b[1m2×3 DataFrame\u001b[0m\n",
       "\u001b[1m Row \u001b[0m│\u001b[1m lfp   \u001b[0m\u001b[1m no     \u001b[0m\u001b[1m yes    \u001b[0m\n",
       "\u001b[1m     \u001b[0m│\u001b[90m Int64 \u001b[0m\u001b[90m Int64? \u001b[0m\u001b[90m Int64? \u001b[0m\n",
       "─────┼───────────────────────\n",
       "   1 │     0     402      69\n",
       "   2 │     1     254     147"
      ]
     },
     "execution_count": 33,
     "metadata": {},
     "output_type": "execute_result"
    }
   ],
   "source": [
    "@chain df begin\n",
    "    groupby([:lfp, :foreign])\n",
    "    combine(nrow)\n",
    "    unstack(:lfp, :foreign, :nrow)\n",
    "end"
   ]
  },
  {
   "cell_type": "markdown",
   "id": "854130d1",
   "metadata": {},
   "source": [
    "### Building a predictive model "
   ]
  },
  {
   "cell_type": "code",
   "execution_count": 34,
   "id": "c45a3877",
   "metadata": {},
   "outputs": [
    {
     "data": {
      "text/plain": [
       "StatsModels.TableRegressionModel{GeneralizedLinearModel{GLM.GlmResp{Vector{Float64}, Binomial{Float64}, ProbitLink}, GLM.DensePredChol{Float64, LinearAlgebra.Cholesky{Float64, Matrix{Float64}}}}, Matrix{Float64}}\n",
       "\n",
       "lfp ~ 1 + lnnlinc + age + age² + educ + nyc + noc + foreign\n",
       "\n",
       "Coefficients:\n",
       "────────────────────────────────────────────────────────────────────────────\n",
       "                   Coef.  Std. Error      z  Pr(>|z|)  Lower 95%   Upper 95%\n",
       "────────────────────────────────────────────────────────────────────────────\n",
       "(Intercept)    3.74896     1.40663     2.67    0.0077   0.992006   6.50591\n",
       "lnnlinc       -0.666932    0.13192    -5.06    <1e-06  -0.92549   -0.408374\n",
       "age            2.07531     0.405407    5.12    <1e-06   1.28073    2.86989\n",
       "age²          -0.294345    0.0499446  -5.89    <1e-08  -0.392235  -0.196456\n",
       "educ           0.0191963   0.0179255   1.07    0.2842  -0.015937   0.0543295\n",
       "nyc           -0.714465    0.100397   -7.12    <1e-11  -0.911238  -0.517691\n",
       "noc           -0.146985    0.0508854  -2.89    0.0039  -0.246718  -0.0472509\n",
       "foreign: yes   0.71438     0.121324    5.89    <1e-08   0.476589   0.95217\n",
       "────────────────────────────────────────────────────────────────────────────"
      ]
     },
     "execution_count": 34,
     "metadata": {},
     "output_type": "execute_result"
    }
   ],
   "source": [
    "probit = glm(@formula(lfp ~ lnnlinc + age + age² + educ + nyc + noc + foreign),\n",
    "             df, Binomial(), ProbitLink())\n",
    "\n",
    "###  the first formula is written manually "
   ]
  },
  {
   "cell_type": "code",
   "execution_count": 35,
   "id": "f3fbf4c1",
   "metadata": {},
   "outputs": [
    {
     "data": {
      "text/plain": [
       "StatsModels.TableRegressionModel{GeneralizedLinearModel{GLM.GlmResp{Vector{Float64}, Binomial{Float64}, ProbitLink}, GLM.DensePredChol{Float64, LinearAlgebra.Cholesky{Float64, Matrix{Float64}}}}, Matrix{Float64}}\n",
       "\n",
       "lfp ~ 1 + lnnlinc + age + age² + educ + nyc + noc + foreign\n",
       "\n",
       "Coefficients:\n",
       "────────────────────────────────────────────────────────────────────────────\n",
       "                   Coef.  Std. Error      z  Pr(>|z|)  Lower 95%   Upper 95%\n",
       "────────────────────────────────────────────────────────────────────────────\n",
       "(Intercept)    3.74896     1.40663     2.67    0.0077   0.992006   6.50591\n",
       "lnnlinc       -0.666932    0.13192    -5.06    <1e-06  -0.92549   -0.408374\n",
       "age            2.07531     0.405407    5.12    <1e-06   1.28073    2.86989\n",
       "age²          -0.294345    0.0499446  -5.89    <1e-08  -0.392235  -0.196456\n",
       "educ           0.0191963   0.0179255   1.07    0.2842  -0.015937   0.0543295\n",
       "nyc           -0.714465    0.100397   -7.12    <1e-11  -0.911238  -0.517691\n",
       "noc           -0.146985    0.0508854  -2.89    0.0039  -0.246718  -0.0472509\n",
       "foreign: yes   0.71438     0.121324    5.89    <1e-08   0.476589   0.95217\n",
       "────────────────────────────────────────────────────────────────────────────"
      ]
     },
     "execution_count": 35,
     "metadata": {},
     "output_type": "execute_result"
    }
   ],
   "source": [
    "### Another method to build the Predictive model \n",
    "probit = glm(Term(:lfp) ~ sum(Term.(propertynames(df)[2:end])),\n",
    "             df, Binomial(), ProbitLink())\n"
   ]
  },
  {
   "cell_type": "code",
   "execution_count": 38,
   "id": "99de92ba",
   "metadata": {},
   "outputs": [
    {
     "data": {
      "text/plain": [
       "StatsModels.TableRegressionModel{GeneralizedLinearModel{GLM.GlmResp{Vector{Float64}, Binomial{Float64}, ProbitLink}, GLM.DensePredChol{Float64, LinearAlgebra.Cholesky{Float64, Matrix{Float64}}}}, Matrix{Float64}}\n",
       "\n",
       "lfp ~ 1 + lnnlinc + age + :(age ^ 2) + educ + nyc + noc + foreign\n",
       "\n",
       "Coefficients:\n",
       "────────────────────────────────────────────────────────────────────────────\n",
       "                   Coef.  Std. Error      z  Pr(>|z|)  Lower 95%   Upper 95%\n",
       "────────────────────────────────────────────────────────────────────────────\n",
       "(Intercept)    3.74896     1.40663     2.67    0.0077   0.992006   6.50591\n",
       "lnnlinc       -0.666932    0.13192    -5.06    <1e-06  -0.92549   -0.408374\n",
       "age            2.07531     0.405407    5.12    <1e-06   1.28073    2.86989\n",
       "age ^ 2       -0.294345    0.0499446  -5.89    <1e-08  -0.392235  -0.196456\n",
       "educ           0.0191963   0.0179255   1.07    0.2842  -0.015937   0.0543295\n",
       "nyc           -0.714465    0.100397   -7.12    <1e-11  -0.911238  -0.517691\n",
       "noc           -0.146985    0.0508854  -2.89    0.0039  -0.246718  -0.0472509\n",
       "foreign: yes   0.71438     0.121324    5.89    <1e-08   0.476589   0.95217\n",
       "────────────────────────────────────────────────────────────────────────────"
      ]
     },
     "execution_count": 38,
     "metadata": {},
     "output_type": "execute_result"
    }
   ],
   "source": [
    "probit = glm(@formula(lfp ~ lnnlinc + age + age^2 + educ + nyc + noc + foreign),\n",
    "             df, Binomial(), ProbitLink())"
   ]
  },
  {
   "cell_type": "code",
   "execution_count": 65,
   "id": "a696c2d8",
   "metadata": {},
   "outputs": [],
   "source": [
    "df_pred = DataFrame(lnnlinc=10.0, age= 2.0:0.01:6.2, educ = 9, nyc = 0, noc = 1, foreign = \"yes\")"
   ]
  },
  {
   "cell_type": "code",
   "execution_count": 66,
   "id": "4a42f28e",
   "metadata": {},
   "outputs": [],
   "source": [
    "probit_pred = predict(probit, df_pred, interval=:confidence)"
   ]
  },
  {
   "cell_type": "code",
   "execution_count": 41,
   "id": "b8b4ab58",
   "metadata": {},
   "outputs": [
    {
     "data": {
      "image/svg+xml": [
       "<?xml version=\"1.0\" encoding=\"utf-8\"?>\n",
       "<svg xmlns=\"http://www.w3.org/2000/svg\" xmlns:xlink=\"http://www.w3.org/1999/xlink\" width=\"600\" height=\"400\" viewBox=\"0 0 2400 1600\">\n",
       "<defs>\n",
       "  <clipPath id=\"clip080\">\n",
       "    <rect x=\"0\" y=\"0\" width=\"2400\" height=\"1600\"/>\n",
       "  </clipPath>\n",
       "</defs>\n",
       "<path clip-path=\"url(#clip080)\" d=\"\n",
       "M0 1600 L2400 1600 L2400 0 L0 0  Z\n",
       "  \" fill=\"#ffffff\" fill-rule=\"evenodd\" fill-opacity=\"1\"/>\n",
       "<defs>\n",
       "  <clipPath id=\"clip081\">\n",
       "    <rect x=\"480\" y=\"0\" width=\"1681\" height=\"1600\"/>\n",
       "  </clipPath>\n",
       "</defs>\n",
       "<path clip-path=\"url(#clip080)\" d=\"\n",
       "M219.866 1423.18 L2352.76 1423.18 L2352.76 47.2441 L219.866 47.2441  Z\n",
       "  \" fill=\"#ffffff\" fill-rule=\"evenodd\" fill-opacity=\"1\"/>\n",
       "<defs>\n",
       "  <clipPath id=\"clip082\">\n",
       "    <rect x=\"219\" y=\"47\" width=\"2134\" height=\"1377\"/>\n",
       "  </clipPath>\n",
       "</defs>\n",
       "<polyline clip-path=\"url(#clip082)\" style=\"stroke:#000000; stroke-linecap:butt; stroke-linejoin:round; stroke-width:2; stroke-opacity:0.1; fill:none\" points=\"\n",
       "  280.231,1423.18 280.231,47.2441 \n",
       "  \"/>\n",
       "<polyline clip-path=\"url(#clip082)\" style=\"stroke:#000000; stroke-linecap:butt; stroke-linejoin:round; stroke-width:2; stroke-opacity:0.1; fill:none\" points=\"\n",
       "  759.317,1423.18 759.317,47.2441 \n",
       "  \"/>\n",
       "<polyline clip-path=\"url(#clip082)\" style=\"stroke:#000000; stroke-linecap:butt; stroke-linejoin:round; stroke-width:2; stroke-opacity:0.1; fill:none\" points=\"\n",
       "  1238.4,1423.18 1238.4,47.2441 \n",
       "  \"/>\n",
       "<polyline clip-path=\"url(#clip082)\" style=\"stroke:#000000; stroke-linecap:butt; stroke-linejoin:round; stroke-width:2; stroke-opacity:0.1; fill:none\" points=\"\n",
       "  1717.49,1423.18 1717.49,47.2441 \n",
       "  \"/>\n",
       "<polyline clip-path=\"url(#clip082)\" style=\"stroke:#000000; stroke-linecap:butt; stroke-linejoin:round; stroke-width:2; stroke-opacity:0.1; fill:none\" points=\"\n",
       "  2196.57,1423.18 2196.57,47.2441 \n",
       "  \"/>\n",
       "<polyline clip-path=\"url(#clip080)\" style=\"stroke:#000000; stroke-linecap:butt; stroke-linejoin:round; stroke-width:4; stroke-opacity:1; fill:none\" points=\"\n",
       "  219.866,1423.18 2352.76,1423.18 \n",
       "  \"/>\n",
       "<polyline clip-path=\"url(#clip080)\" style=\"stroke:#000000; stroke-linecap:butt; stroke-linejoin:round; stroke-width:4; stroke-opacity:1; fill:none\" points=\"\n",
       "  280.231,1423.18 280.231,1404.28 \n",
       "  \"/>\n",
       "<polyline clip-path=\"url(#clip080)\" style=\"stroke:#000000; stroke-linecap:butt; stroke-linejoin:round; stroke-width:4; stroke-opacity:1; fill:none\" points=\"\n",
       "  759.317,1423.18 759.317,1404.28 \n",
       "  \"/>\n",
       "<polyline clip-path=\"url(#clip080)\" style=\"stroke:#000000; stroke-linecap:butt; stroke-linejoin:round; stroke-width:4; stroke-opacity:1; fill:none\" points=\"\n",
       "  1238.4,1423.18 1238.4,1404.28 \n",
       "  \"/>\n",
       "<polyline clip-path=\"url(#clip080)\" style=\"stroke:#000000; stroke-linecap:butt; stroke-linejoin:round; stroke-width:4; stroke-opacity:1; fill:none\" points=\"\n",
       "  1717.49,1423.18 1717.49,1404.28 \n",
       "  \"/>\n",
       "<polyline clip-path=\"url(#clip080)\" style=\"stroke:#000000; stroke-linecap:butt; stroke-linejoin:round; stroke-width:4; stroke-opacity:1; fill:none\" points=\"\n",
       "  2196.57,1423.18 2196.57,1404.28 \n",
       "  \"/>\n",
       "<path clip-path=\"url(#clip080)\" d=\"M274.884 1481.64 L291.203 1481.64 L291.203 1485.58 L269.259 1485.58 L269.259 1481.64 Q271.921 1478.89 276.504 1474.26 Q281.111 1469.61 282.291 1468.27 Q284.537 1465.74 285.416 1464.01 Q286.319 1462.25 286.319 1460.56 Q286.319 1457.8 284.375 1456.07 Q282.453 1454.33 279.351 1454.33 Q277.152 1454.33 274.699 1455.09 Q272.268 1455.86 269.49 1457.41 L269.49 1452.69 Q272.314 1451.55 274.768 1450.97 Q277.222 1450.39 279.259 1450.39 Q284.629 1450.39 287.824 1453.08 Q291.018 1455.77 291.018 1460.26 Q291.018 1462.39 290.208 1464.31 Q289.421 1466.2 287.314 1468.8 Q286.736 1469.47 283.634 1472.69 Q280.532 1475.88 274.884 1481.64 Z\" fill=\"#000000\" fill-rule=\"evenodd\" fill-opacity=\"1\" /><path clip-path=\"url(#clip080)\" d=\"M763.564 1466.95 Q766.921 1467.66 768.796 1469.93 Q770.694 1472.2 770.694 1475.53 Q770.694 1480.65 767.176 1483.45 Q763.657 1486.25 757.176 1486.25 Q755 1486.25 752.685 1485.81 Q750.393 1485.39 747.94 1484.54 L747.94 1480.02 Q749.884 1481.16 752.199 1481.74 Q754.514 1482.32 757.037 1482.32 Q761.435 1482.32 763.726 1480.58 Q766.041 1478.84 766.041 1475.53 Q766.041 1472.48 763.889 1470.77 Q761.759 1469.03 757.939 1469.03 L753.912 1469.03 L753.912 1465.19 L758.125 1465.19 Q761.574 1465.19 763.402 1463.82 Q765.231 1462.43 765.231 1459.84 Q765.231 1457.18 763.333 1455.77 Q761.458 1454.33 757.939 1454.33 Q756.018 1454.33 753.819 1454.75 Q751.62 1455.16 748.981 1456.04 L748.981 1451.88 Q751.643 1451.14 753.958 1450.77 Q756.296 1450.39 758.356 1450.39 Q763.68 1450.39 766.782 1452.83 Q769.884 1455.23 769.884 1459.35 Q769.884 1462.22 768.24 1464.21 Q766.597 1466.18 763.564 1466.95 Z\" fill=\"#000000\" fill-rule=\"evenodd\" fill-opacity=\"1\" /><path clip-path=\"url(#clip080)\" d=\"M1241.41 1455.09 L1229.61 1473.54 L1241.41 1473.54 L1241.41 1455.09 M1240.18 1451.02 L1246.06 1451.02 L1246.06 1473.54 L1251 1473.54 L1251 1477.43 L1246.06 1477.43 L1246.06 1485.58 L1241.41 1485.58 L1241.41 1477.43 L1225.81 1477.43 L1225.81 1472.92 L1240.18 1451.02 Z\" fill=\"#000000\" fill-rule=\"evenodd\" fill-opacity=\"1\" /><path clip-path=\"url(#clip080)\" d=\"M1707.77 1451.02 L1726.12 1451.02 L1726.12 1454.96 L1712.05 1454.96 L1712.05 1463.43 Q1713.07 1463.08 1714.09 1462.92 Q1715.1 1462.73 1716.12 1462.73 Q1721.91 1462.73 1725.29 1465.9 Q1728.67 1469.08 1728.67 1474.49 Q1728.67 1480.07 1725.2 1483.17 Q1721.72 1486.25 1715.4 1486.25 Q1713.23 1486.25 1710.96 1485.88 Q1708.72 1485.51 1706.31 1484.77 L1706.31 1480.07 Q1708.39 1481.2 1710.61 1481.76 Q1712.84 1482.32 1715.31 1482.32 Q1719.32 1482.32 1721.65 1480.21 Q1723.99 1478.1 1723.99 1474.49 Q1723.99 1470.88 1721.65 1468.77 Q1719.32 1466.67 1715.31 1466.67 Q1713.44 1466.67 1711.56 1467.08 Q1709.71 1467.5 1707.77 1468.38 L1707.77 1451.02 Z\" fill=\"#000000\" fill-rule=\"evenodd\" fill-opacity=\"1\" /><path clip-path=\"url(#clip080)\" d=\"M2196.98 1466.44 Q2193.83 1466.44 2191.98 1468.59 Q2190.15 1470.74 2190.15 1474.49 Q2190.15 1478.22 2191.98 1480.39 Q2193.83 1482.55 2196.98 1482.55 Q2200.13 1482.55 2201.96 1480.39 Q2203.81 1478.22 2203.81 1474.49 Q2203.81 1470.74 2201.96 1468.59 Q2200.13 1466.44 2196.98 1466.44 M2206.26 1451.78 L2206.26 1456.04 Q2204.5 1455.21 2202.7 1454.77 Q2200.91 1454.33 2199.15 1454.33 Q2194.53 1454.33 2192.07 1457.45 Q2189.64 1460.58 2189.29 1466.9 Q2190.66 1464.89 2192.72 1463.82 Q2194.78 1462.73 2197.26 1462.73 Q2202.47 1462.73 2205.47 1465.9 Q2208.51 1469.05 2208.51 1474.49 Q2208.51 1479.82 2205.36 1483.03 Q2202.21 1486.25 2196.98 1486.25 Q2190.98 1486.25 2187.81 1481.67 Q2184.64 1477.06 2184.64 1468.33 Q2184.64 1460.14 2188.53 1455.28 Q2192.42 1450.39 2198.97 1450.39 Q2200.73 1450.39 2202.51 1450.74 Q2204.32 1451.09 2206.26 1451.78 Z\" fill=\"#000000\" fill-rule=\"evenodd\" fill-opacity=\"1\" /><path clip-path=\"url(#clip080)\" d=\"M1247.72 1550.12 Q1240.62 1550.12 1237.88 1551.75 Q1235.15 1553.37 1235.15 1557.29 Q1235.15 1560.4 1237.18 1562.25 Q1239.25 1564.07 1242.79 1564.07 Q1247.66 1564.07 1250.58 1560.63 Q1253.54 1557.16 1253.54 1551.43 L1253.54 1550.12 L1247.72 1550.12 M1259.4 1547.71 L1259.4 1568.04 L1253.54 1568.04 L1253.54 1562.63 Q1251.54 1565.88 1248.55 1567.44 Q1245.55 1568.97 1241.23 1568.97 Q1235.75 1568.97 1232.5 1565.91 Q1229.29 1562.82 1229.29 1557.67 Q1229.29 1551.65 1233.3 1548.6 Q1237.34 1545.54 1245.33 1545.54 L1253.54 1545.54 L1253.54 1544.97 Q1253.54 1540.93 1250.87 1538.73 Q1248.23 1536.5 1243.42 1536.5 Q1240.37 1536.5 1237.47 1537.23 Q1234.57 1537.97 1231.9 1539.43 L1231.9 1534.02 Q1235.11 1532.78 1238.14 1532.17 Q1241.16 1531.54 1244.03 1531.54 Q1251.76 1531.54 1255.58 1535.55 Q1259.4 1539.56 1259.4 1547.71 Z\" fill=\"#000000\" fill-rule=\"evenodd\" fill-opacity=\"1\" /><path clip-path=\"url(#clip080)\" d=\"M1294.92 1549.81 Q1294.92 1543.44 1292.28 1539.94 Q1289.67 1536.44 1284.93 1536.44 Q1280.22 1536.44 1277.57 1539.94 Q1274.96 1543.44 1274.96 1549.81 Q1274.96 1556.14 1277.57 1559.64 Q1280.22 1563.14 1284.93 1563.14 Q1289.67 1563.14 1292.28 1559.64 Q1294.92 1556.14 1294.92 1549.81 M1300.78 1563.62 Q1300.78 1572.72 1296.73 1577.15 Q1292.69 1581.6 1284.35 1581.6 Q1281.27 1581.6 1278.53 1581.13 Q1275.79 1580.68 1273.21 1579.72 L1273.21 1574.03 Q1275.79 1575.43 1278.31 1576.1 Q1280.82 1576.76 1283.43 1576.76 Q1289.19 1576.76 1292.06 1573.74 Q1294.92 1570.75 1294.92 1564.67 L1294.92 1561.77 Q1293.11 1564.92 1290.27 1566.48 Q1287.44 1568.04 1283.49 1568.04 Q1276.94 1568.04 1272.93 1563.05 Q1268.92 1558.05 1268.92 1549.81 Q1268.92 1541.53 1272.93 1536.53 Q1276.94 1531.54 1283.49 1531.54 Q1287.44 1531.54 1290.27 1533.1 Q1293.11 1534.66 1294.92 1537.81 L1294.92 1532.4 L1300.78 1532.4 L1300.78 1563.62 Z\" fill=\"#000000\" fill-rule=\"evenodd\" fill-opacity=\"1\" /><path clip-path=\"url(#clip080)\" d=\"M1343.33 1548.76 L1343.33 1551.62 L1316.4 1551.62 Q1316.79 1557.67 1320.03 1560.85 Q1323.31 1564 1329.14 1564 Q1332.51 1564 1335.66 1563.17 Q1338.84 1562.35 1341.96 1560.69 L1341.96 1566.23 Q1338.81 1567.57 1335.5 1568.27 Q1332.19 1568.97 1328.79 1568.97 Q1320.26 1568.97 1315.26 1564 Q1310.29 1559.04 1310.29 1550.57 Q1310.29 1541.82 1315 1536.69 Q1319.75 1531.54 1327.77 1531.54 Q1334.96 1531.54 1339.13 1536.18 Q1343.33 1540.8 1343.33 1548.76 M1337.48 1547.04 Q1337.41 1542.23 1334.77 1539.37 Q1332.16 1536.5 1327.83 1536.5 Q1322.93 1536.5 1319.97 1539.27 Q1317.04 1542.04 1316.6 1547.07 L1337.48 1547.04 Z\" fill=\"#000000\" fill-rule=\"evenodd\" fill-opacity=\"1\" /><polyline clip-path=\"url(#clip082)\" style=\"stroke:#000000; stroke-linecap:butt; stroke-linejoin:round; stroke-width:2; stroke-opacity:0.1; fill:none\" points=\"\n",
       "  219.866,1277.3 2352.76,1277.3 \n",
       "  \"/>\n",
       "<polyline clip-path=\"url(#clip082)\" style=\"stroke:#000000; stroke-linecap:butt; stroke-linejoin:round; stroke-width:2; stroke-opacity:0.1; fill:none\" points=\"\n",
       "  219.866,964.318 2352.76,964.318 \n",
       "  \"/>\n",
       "<polyline clip-path=\"url(#clip082)\" style=\"stroke:#000000; stroke-linecap:butt; stroke-linejoin:round; stroke-width:2; stroke-opacity:0.1; fill:none\" points=\"\n",
       "  219.866,651.332 2352.76,651.332 \n",
       "  \"/>\n",
       "<polyline clip-path=\"url(#clip082)\" style=\"stroke:#000000; stroke-linecap:butt; stroke-linejoin:round; stroke-width:2; stroke-opacity:0.1; fill:none\" points=\"\n",
       "  219.866,338.347 2352.76,338.347 \n",
       "  \"/>\n",
       "<polyline clip-path=\"url(#clip080)\" style=\"stroke:#000000; stroke-linecap:butt; stroke-linejoin:round; stroke-width:4; stroke-opacity:1; fill:none\" points=\"\n",
       "  219.866,1423.18 219.866,47.2441 \n",
       "  \"/>\n",
       "<polyline clip-path=\"url(#clip080)\" style=\"stroke:#000000; stroke-linecap:butt; stroke-linejoin:round; stroke-width:4; stroke-opacity:1; fill:none\" points=\"\n",
       "  219.866,1277.3 238.764,1277.3 \n",
       "  \"/>\n",
       "<polyline clip-path=\"url(#clip080)\" style=\"stroke:#000000; stroke-linecap:butt; stroke-linejoin:round; stroke-width:4; stroke-opacity:1; fill:none\" points=\"\n",
       "  219.866,964.318 238.764,964.318 \n",
       "  \"/>\n",
       "<polyline clip-path=\"url(#clip080)\" style=\"stroke:#000000; stroke-linecap:butt; stroke-linejoin:round; stroke-width:4; stroke-opacity:1; fill:none\" points=\"\n",
       "  219.866,651.332 238.764,651.332 \n",
       "  \"/>\n",
       "<polyline clip-path=\"url(#clip080)\" style=\"stroke:#000000; stroke-linecap:butt; stroke-linejoin:round; stroke-width:4; stroke-opacity:1; fill:none\" points=\"\n",
       "  219.866,338.347 238.764,338.347 \n",
       "  \"/>\n",
       "<path clip-path=\"url(#clip080)\" d=\"M128.288 1263.1 Q124.677 1263.1 122.848 1266.67 Q121.043 1270.21 121.043 1277.34 Q121.043 1284.44 122.848 1288.01 Q124.677 1291.55 128.288 1291.55 Q131.922 1291.55 133.728 1288.01 Q135.556 1284.44 135.556 1277.34 Q135.556 1270.21 133.728 1266.67 Q131.922 1263.1 128.288 1263.1 M128.288 1259.4 Q134.098 1259.4 137.154 1264 Q140.232 1268.59 140.232 1277.34 Q140.232 1286.06 137.154 1290.67 Q134.098 1295.25 128.288 1295.25 Q122.478 1295.25 119.399 1290.67 Q116.343 1286.06 116.343 1277.34 Q116.343 1268.59 119.399 1264 Q122.478 1259.4 128.288 1259.4 Z\" fill=\"#000000\" fill-rule=\"evenodd\" fill-opacity=\"1\" /><path clip-path=\"url(#clip080)\" d=\"M148.45 1288.7 L153.334 1288.7 L153.334 1294.58 L148.45 1294.58 L148.45 1288.7 Z\" fill=\"#000000\" fill-rule=\"evenodd\" fill-opacity=\"1\" /><path clip-path=\"url(#clip080)\" d=\"M167.547 1290.65 L183.866 1290.65 L183.866 1294.58 L161.922 1294.58 L161.922 1290.65 Q164.584 1287.89 169.167 1283.26 Q173.774 1278.61 174.954 1277.27 Q177.2 1274.75 178.079 1273.01 Q178.982 1271.25 178.982 1269.56 Q178.982 1266.81 177.038 1265.07 Q175.116 1263.33 172.014 1263.33 Q169.815 1263.33 167.362 1264.1 Q164.931 1264.86 162.153 1266.41 L162.153 1261.69 Q164.977 1260.56 167.431 1259.98 Q169.885 1259.4 171.922 1259.4 Q177.292 1259.4 180.487 1262.08 Q183.681 1264.77 183.681 1269.26 Q183.681 1271.39 182.871 1273.31 Q182.084 1275.21 179.977 1277.8 Q179.399 1278.47 176.297 1281.69 Q173.195 1284.88 167.547 1290.65 Z\" fill=\"#000000\" fill-rule=\"evenodd\" fill-opacity=\"1\" /><path clip-path=\"url(#clip080)\" d=\"M126.205 950.116 Q122.593 950.116 120.765 953.681 Q118.959 957.223 118.959 964.352 Q118.959 971.459 120.765 975.024 Q122.593 978.565 126.205 978.565 Q129.839 978.565 131.644 975.024 Q133.473 971.459 133.473 964.352 Q133.473 957.223 131.644 953.681 Q129.839 950.116 126.205 950.116 M126.205 946.413 Q132.015 946.413 135.07 951.019 Q138.149 955.602 138.149 964.352 Q138.149 973.079 135.07 977.686 Q132.015 982.269 126.205 982.269 Q120.394 982.269 117.316 977.686 Q114.26 973.079 114.26 964.352 Q114.26 955.602 117.316 951.019 Q120.394 946.413 126.205 946.413 Z\" fill=\"#000000\" fill-rule=\"evenodd\" fill-opacity=\"1\" /><path clip-path=\"url(#clip080)\" d=\"M146.366 975.718 L151.251 975.718 L151.251 981.598 L146.366 981.598 L146.366 975.718 Z\" fill=\"#000000\" fill-rule=\"evenodd\" fill-opacity=\"1\" /><path clip-path=\"url(#clip080)\" d=\"M174.283 951.112 L162.477 969.561 L174.283 969.561 L174.283 951.112 M173.056 947.038 L178.936 947.038 L178.936 969.561 L183.866 969.561 L183.866 973.45 L178.936 973.45 L178.936 981.598 L174.283 981.598 L174.283 973.45 L158.681 973.45 L158.681 968.936 L173.056 947.038 Z\" fill=\"#000000\" fill-rule=\"evenodd\" fill-opacity=\"1\" /><path clip-path=\"url(#clip080)\" d=\"M126.529 637.131 Q122.918 637.131 121.089 640.696 Q119.283 644.237 119.283 651.367 Q119.283 658.473 121.089 662.038 Q122.918 665.58 126.529 665.58 Q130.163 665.58 131.968 662.038 Q133.797 658.473 133.797 651.367 Q133.797 644.237 131.968 640.696 Q130.163 637.131 126.529 637.131 M126.529 633.427 Q132.339 633.427 135.394 638.034 Q138.473 642.617 138.473 651.367 Q138.473 660.094 135.394 664.7 Q132.339 669.283 126.529 669.283 Q120.718 669.283 117.64 664.7 Q114.584 660.094 114.584 651.367 Q114.584 642.617 117.64 638.034 Q120.718 633.427 126.529 633.427 Z\" fill=\"#000000\" fill-rule=\"evenodd\" fill-opacity=\"1\" /><path clip-path=\"url(#clip080)\" d=\"M146.691 662.733 L151.575 662.733 L151.575 668.612 L146.691 668.612 L146.691 662.733 Z\" fill=\"#000000\" fill-rule=\"evenodd\" fill-opacity=\"1\" /><path clip-path=\"url(#clip080)\" d=\"M172.339 649.469 Q169.19 649.469 167.339 651.621 Q165.51 653.774 165.51 657.524 Q165.51 661.251 167.339 663.427 Q169.19 665.58 172.339 665.58 Q175.487 665.58 177.315 663.427 Q179.167 661.251 179.167 657.524 Q179.167 653.774 177.315 651.621 Q175.487 649.469 172.339 649.469 M181.621 634.816 L181.621 639.075 Q179.862 638.242 178.056 637.802 Q176.274 637.362 174.514 637.362 Q169.885 637.362 167.431 640.487 Q165.001 643.612 164.653 649.932 Q166.019 647.918 168.079 646.853 Q170.139 645.765 172.616 645.765 Q177.825 645.765 180.834 648.936 Q183.866 652.084 183.866 657.524 Q183.866 662.848 180.718 666.066 Q177.57 669.283 172.339 669.283 Q166.343 669.283 163.172 664.7 Q160.001 660.094 160.001 651.367 Q160.001 643.172 163.89 638.311 Q167.778 633.427 174.329 633.427 Q176.089 633.427 177.871 633.774 Q179.676 634.122 181.621 634.816 Z\" fill=\"#000000\" fill-rule=\"evenodd\" fill-opacity=\"1\" /><path clip-path=\"url(#clip080)\" d=\"M126.783 324.145 Q123.172 324.145 121.343 327.71 Q119.538 331.252 119.538 338.381 Q119.538 345.488 121.343 349.053 Q123.172 352.594 126.783 352.594 Q130.417 352.594 132.223 349.053 Q134.052 345.488 134.052 338.381 Q134.052 331.252 132.223 327.71 Q130.417 324.145 126.783 324.145 M126.783 320.442 Q132.593 320.442 135.649 325.048 Q138.728 329.631 138.728 338.381 Q138.728 347.108 135.649 351.715 Q132.593 356.298 126.783 356.298 Q120.973 356.298 117.894 351.715 Q114.839 347.108 114.839 338.381 Q114.839 329.631 117.894 325.048 Q120.973 320.442 126.783 320.442 Z\" fill=\"#000000\" fill-rule=\"evenodd\" fill-opacity=\"1\" /><path clip-path=\"url(#clip080)\" d=\"M146.945 349.747 L151.829 349.747 L151.829 355.627 L146.945 355.627 L146.945 349.747 Z\" fill=\"#000000\" fill-rule=\"evenodd\" fill-opacity=\"1\" /><path clip-path=\"url(#clip080)\" d=\"M172.014 339.215 Q168.681 339.215 166.76 340.997 Q164.862 342.78 164.862 345.904 Q164.862 349.029 166.76 350.812 Q168.681 352.594 172.014 352.594 Q175.348 352.594 177.269 350.812 Q179.19 349.006 179.19 345.904 Q179.19 342.78 177.269 340.997 Q175.371 339.215 172.014 339.215 M167.339 337.224 Q164.329 336.483 162.64 334.423 Q160.973 332.363 160.973 329.4 Q160.973 325.256 163.913 322.849 Q166.876 320.442 172.014 320.442 Q177.176 320.442 180.116 322.849 Q183.056 325.256 183.056 329.4 Q183.056 332.363 181.366 334.423 Q179.7 336.483 176.714 337.224 Q180.093 338.011 181.968 340.303 Q183.866 342.594 183.866 345.904 Q183.866 350.928 180.788 353.613 Q177.732 356.298 172.014 356.298 Q166.297 356.298 163.218 353.613 Q160.163 350.928 160.163 345.904 Q160.163 342.594 162.061 340.303 Q163.959 338.011 167.339 337.224 M165.626 329.84 Q165.626 332.525 167.292 334.03 Q168.982 335.534 172.014 335.534 Q175.024 335.534 176.714 334.03 Q178.426 332.525 178.426 329.84 Q178.426 327.155 176.714 325.65 Q175.024 324.145 172.014 324.145 Q168.982 324.145 167.292 325.65 Q165.626 327.155 165.626 329.84 Z\" fill=\"#000000\" fill-rule=\"evenodd\" fill-opacity=\"1\" /><path clip-path=\"url(#clip080)\" d=\"M21.7677 869.958 L39.6235 869.958 L39.6235 861.874 Q39.6235 857.386 37.3 854.935 Q34.9765 852.484 30.6797 852.484 Q26.4147 852.484 24.0912 854.935 Q21.7677 857.386 21.7677 861.874 L21.7677 869.958 M16.4842 876.387 L16.4842 861.874 Q16.4842 853.885 20.1126 849.811 Q23.7092 845.705 30.6797 845.705 Q37.7138 845.705 41.3104 849.811 Q44.907 853.885 44.907 861.874 L44.907 869.958 L64.0042 869.958 L64.0042 876.387 L16.4842 876.387 Z\" fill=\"#000000\" fill-rule=\"evenodd\" fill-opacity=\"1\" /><path clip-path=\"url(#clip080)\" d=\"M33.8307 817.823 Q33.2578 818.81 33.0032 819.987 Q32.7167 821.133 32.7167 822.534 Q32.7167 827.499 35.9632 830.172 Q39.1779 832.814 45.2253 832.814 L64.0042 832.814 L64.0042 838.702 L28.3562 838.702 L28.3562 832.814 L33.8944 832.814 Q30.6479 830.968 29.0883 828.008 Q27.4968 825.048 27.4968 820.815 Q27.4968 820.21 27.5923 819.478 Q27.656 818.746 27.8151 817.855 L33.8307 817.823 Z\" fill=\"#000000\" fill-rule=\"evenodd\" fill-opacity=\"1\" /><path clip-path=\"url(#clip080)\" d=\"M14.5426 797.612 Q21.8632 801.877 29.0246 803.946 Q36.186 806.015 43.5384 806.015 Q50.8908 806.015 58.1159 803.946 Q65.3091 801.845 72.5979 797.612 L72.5979 802.704 Q65.1182 807.479 57.8931 809.866 Q50.668 812.221 43.5384 812.221 Q36.4406 812.221 29.2474 809.866 Q22.0542 807.51 14.5426 802.704 L14.5426 797.612 Z\" fill=\"#000000\" fill-rule=\"evenodd\" fill-opacity=\"1\" /><path clip-path=\"url(#clip080)\" d=\"M14.479 786.249 L14.479 780.393 L64.0042 780.393 L64.0042 786.249 L14.479 786.249 Z\" fill=\"#000000\" fill-rule=\"evenodd\" fill-opacity=\"1\" /><path clip-path=\"url(#clip080)\" d=\"M14.479 750.092 L19.3487 750.092 L19.3487 755.694 Q19.3487 758.845 20.6219 760.086 Q21.895 761.295 25.2052 761.295 L28.3562 761.295 L28.3562 751.651 L32.9077 751.651 L32.9077 761.295 L64.0042 761.295 L64.0042 767.184 L32.9077 767.184 L32.9077 772.786 L28.3562 772.786 L28.3562 767.184 L25.8736 767.184 Q19.9216 767.184 17.2162 764.415 Q14.479 761.646 14.479 755.63 L14.479 750.092 Z\" fill=\"#000000\" fill-rule=\"evenodd\" fill-opacity=\"1\" /><path clip-path=\"url(#clip080)\" d=\"M58.657 739.525 L77.5631 739.525 L77.5631 745.413 L28.3562 745.413 L28.3562 739.525 L33.7671 739.525 Q30.5842 737.679 29.0564 734.878 Q27.4968 732.045 27.4968 728.13 Q27.4968 721.637 32.6531 717.595 Q37.8093 713.521 46.212 713.521 Q54.6147 713.521 59.771 717.595 Q64.9272 721.637 64.9272 728.13 Q64.9272 732.045 63.3994 734.878 Q61.8398 737.679 58.657 739.525 M46.212 719.6 Q39.7508 719.6 36.0905 722.274 Q32.3984 724.915 32.3984 729.562 Q32.3984 734.209 36.0905 736.883 Q39.7508 739.525 46.212 739.525 Q52.6732 739.525 56.3653 736.883 Q60.0256 734.209 60.0256 729.562 Q60.0256 724.915 56.3653 722.274 Q52.6732 719.6 46.212 719.6 Z\" fill=\"#000000\" fill-rule=\"evenodd\" fill-opacity=\"1\" /><path clip-path=\"url(#clip080)\" d=\"M34.4036 703.049 L34.4036 662.245 L39.7508 662.245 L39.7508 703.049 L34.4036 703.049 M47.3897 703.049 L47.3897 662.245 L52.8005 662.245 L52.8005 703.049 L47.3897 703.049 Z\" fill=\"#000000\" fill-rule=\"evenodd\" fill-opacity=\"1\" /><path clip-path=\"url(#clip080)\" d=\"M58.5933 647.254 L58.5933 636.75 L22.3406 636.75 L24.6323 648.177 L18.7758 648.177 L16.4842 636.814 L16.4842 630.385 L58.5933 630.385 L58.5933 619.881 L64.0042 619.881 L64.0042 647.254 L58.5933 647.254 Z\" fill=\"#000000\" fill-rule=\"evenodd\" fill-opacity=\"1\" /><path clip-path=\"url(#clip080)\" d=\"M14.5426 608.646 L14.5426 603.553 Q22.0542 598.779 29.2474 596.424 Q36.4406 594.037 43.5384 594.037 Q50.668 594.037 57.8931 596.424 Q65.1182 598.779 72.5979 603.553 L72.5979 608.646 Q65.3091 604.413 58.1159 602.344 Q50.8908 600.243 43.5384 600.243 Q36.186 600.243 29.0246 602.344 Q21.8632 604.413 14.5426 608.646 Z\" fill=\"#000000\" fill-rule=\"evenodd\" fill-opacity=\"1\" /><polyline clip-path=\"url(#clip082)\" style=\"stroke:#009af9; stroke-linecap:butt; stroke-linejoin:round; stroke-width:4; stroke-opacity:1; fill:none\" points=\"\n",
       "  280.231,360.064 285.022,355.999 289.813,351.989 294.604,348.034 299.394,344.134 304.185,340.288 308.976,336.495 313.767,332.756 318.558,329.07 323.349,325.435 \n",
       "  328.14,321.852 332.93,318.321 337.721,314.84 342.512,311.41 347.303,308.029 352.094,304.697 356.885,301.415 361.676,298.18 366.466,294.993 371.257,291.853 \n",
       "  376.048,288.76 380.839,285.713 385.63,282.712 390.421,279.756 395.212,276.844 400.002,273.977 404.793,271.153 409.584,268.373 414.375,265.635 419.166,262.94 \n",
       "  423.957,260.286 428.748,257.673 433.538,255.101 438.329,252.569 443.12,250.076 447.911,247.623 452.702,245.209 457.493,242.833 462.284,240.495 467.074,238.194 \n",
       "  471.865,235.93 476.656,233.702 481.447,231.511 486.238,229.354 491.029,227.233 495.82,225.147 500.61,223.094 505.401,221.075 510.192,219.09 514.983,217.137 \n",
       "  519.774,215.217 524.565,213.329 529.356,211.472 534.147,209.647 538.937,207.852 543.728,206.088 548.519,204.354 553.31,202.649 558.101,200.973 562.892,199.327 \n",
       "  567.683,197.708 572.473,196.118 577.264,194.555 582.055,193.02 586.846,191.512 591.637,190.03 596.428,188.575 601.219,187.145 606.009,185.741 610.8,184.362 \n",
       "  615.591,183.008 620.382,181.679 625.173,180.374 629.964,179.093 634.755,177.836 639.545,176.601 644.336,175.39 649.127,174.202 653.918,173.036 658.709,171.892 \n",
       "  663.5,170.77 668.291,169.67 673.081,168.591 677.872,167.533 682.663,166.496 687.454,165.48 692.245,164.483 697.036,163.507 701.827,162.551 706.617,161.614 \n",
       "  711.408,160.696 716.199,159.797 720.99,158.918 725.781,158.057 730.572,157.214 735.363,156.389 740.153,155.583 744.944,154.794 749.735,154.023 754.526,153.269 \n",
       "  759.317,152.533 764.108,151.813 768.899,151.111 773.689,150.424 778.48,149.755 783.271,149.102 788.062,148.464 792.853,147.843 797.644,147.238 802.435,146.648 \n",
       "  807.225,146.074 812.016,145.515 816.807,144.971 821.598,144.442 826.389,143.928 831.18,143.429 835.971,142.945 840.761,142.475 845.552,142.02 850.343,141.579 \n",
       "  855.134,141.152 859.925,140.739 864.716,140.34 869.507,139.955 874.297,139.584 879.088,139.226 883.879,138.882 888.67,138.552 893.461,138.234 898.252,137.931 \n",
       "  903.043,137.64 907.833,137.363 912.624,137.098 917.415,136.847 922.206,136.608 926.997,136.383 931.788,136.17 936.579,135.97 941.369,135.783 946.16,135.609 \n",
       "  950.951,135.447 955.742,135.298 960.533,135.161 965.324,135.037 970.115,134.925 974.905,134.826 979.696,134.739 984.487,134.664 989.278,134.602 994.069,134.552 \n",
       "  998.86,134.515 1003.65,134.49 1008.44,134.477 1013.23,134.477 1018.02,134.489 1022.81,134.513 1027.6,134.55 1032.4,134.599 1037.19,134.66 1041.98,134.734 \n",
       "  1046.77,134.82 1051.56,134.919 1056.35,135.03 1061.14,135.153 1065.93,135.289 1070.72,135.438 1075.51,135.599 1080.3,135.772 1085.1,135.959 1089.89,136.158 \n",
       "  1094.68,136.37 1099.47,136.595 1104.26,136.832 1109.05,137.083 1113.84,137.346 1118.63,137.623 1123.42,137.913 1128.21,138.216 1133,138.532 1137.79,138.862 \n",
       "  1142.59,139.205 1147.38,139.562 1152.17,139.932 1156.96,140.317 1161.75,140.715 1166.54,141.127 1171.33,141.553 1176.12,141.993 1180.91,142.447 1185.7,142.916 \n",
       "  1190.49,143.4 1195.28,143.898 1200.08,144.411 1204.87,144.939 1209.66,145.482 1214.45,146.04 1219.24,146.613 1224.03,147.202 1228.82,147.806 1233.61,148.427 \n",
       "  1238.4,149.063 1243.19,149.715 1247.98,150.384 1252.78,151.069 1257.57,151.771 1262.36,152.489 1267.15,153.225 1271.94,153.977 1276.73,154.748 1281.52,155.535 \n",
       "  1286.31,156.341 1291.1,157.164 1295.89,158.006 1300.68,158.866 1305.47,159.744 1310.27,160.642 1315.06,161.558 1319.85,162.494 1324.64,163.449 1329.43,164.424 \n",
       "  1334.22,165.419 1339.01,166.435 1343.8,167.471 1348.59,168.527 1353.38,169.605 1358.17,170.704 1362.96,171.825 1367.76,172.967 1372.55,174.132 1377.34,175.319 \n",
       "  1382.13,176.528 1386.92,177.761 1391.71,179.017 1396.5,180.297 1401.29,181.6 1406.08,182.928 1410.87,184.28 1415.66,185.658 1420.46,187.06 1425.25,188.488 \n",
       "  1430.04,189.942 1434.83,191.422 1439.62,192.929 1444.41,194.463 1449.2,196.024 1453.99,197.612 1458.78,199.229 1463.57,200.874 1468.36,202.548 1473.15,204.251 \n",
       "  1477.95,205.983 1482.74,207.746 1487.53,209.539 1492.32,211.362 1497.11,213.217 1501.9,215.103 1506.69,217.021 1511.48,218.972 1516.27,220.956 1521.06,222.972 \n",
       "  1525.85,225.023 1530.64,227.107 1535.44,229.226 1540.23,231.38 1545.02,233.57 1549.81,235.795 1554.6,238.057 1559.39,240.356 1564.18,242.692 1568.97,245.066 \n",
       "  1573.76,247.478 1578.55,249.928 1583.34,252.418 1588.14,254.948 1592.93,257.517 1597.72,260.128 1602.51,262.779 1607.3,265.472 1612.09,268.208 1616.88,270.986 \n",
       "  1621.67,273.807 1626.46,276.671 1631.25,279.58 1636.04,282.533 1640.83,285.532 1645.63,288.576 1650.42,291.666 1655.21,294.803 1660,297.988 1664.79,301.219 \n",
       "  1669.58,304.499 1674.37,307.828 1679.16,311.206 1683.95,314.633 1688.74,318.111 1693.53,321.639 1698.32,325.219 1703.12,328.85 1707.91,332.534 1712.7,336.27 \n",
       "  1717.49,340.059 1722.28,343.902 1727.07,347.799 1731.86,351.751 1736.65,355.757 1741.44,359.819 1746.23,363.937 1751.02,368.112 1755.82,372.343 1760.61,376.632 \n",
       "  1765.4,380.978 1770.19,385.382 1774.98,389.845 1779.77,394.367 1784.56,398.948 1789.35,403.589 1794.14,408.29 1798.93,413.052 1803.72,417.874 1808.51,422.757 \n",
       "  1813.31,427.702 1818.1,432.708 1822.89,437.776 1827.68,442.907 1832.47,448.1 1837.26,453.356 1842.05,458.675 1846.84,464.057 1851.63,469.502 1856.42,475.011 \n",
       "  1861.21,480.584 1866,486.22 1870.8,491.921 1875.59,497.685 1880.38,503.514 1885.17,509.406 1889.96,515.363 1894.75,521.384 1899.54,527.469 1904.33,533.618 \n",
       "  1909.12,539.831 1913.91,546.108 1918.7,552.449 1923.5,558.853 1928.29,565.321 1933.08,571.852 1937.87,578.446 1942.66,585.102 1947.45,591.821 1952.24,598.601 \n",
       "  1957.03,605.443 1961.82,612.347 1966.61,619.311 1971.4,626.335 1976.19,633.419 1980.99,640.562 1985.78,647.764 1990.57,655.024 1995.36,662.341 2000.15,669.715 \n",
       "  2004.94,677.145 2009.73,684.63 2014.52,692.169 2019.31,699.762 2024.1,707.407 2028.89,715.104 2033.68,722.852 2038.48,730.65 2043.27,738.496 2048.06,746.39 \n",
       "  2052.85,754.33 2057.64,762.316 2062.43,770.346 2067.22,778.419 2072.01,786.533 2076.8,794.688 2081.59,802.882 2086.38,811.114 2091.18,819.381 2095.97,827.684 \n",
       "  2100.76,836.019 2105.55,844.386 2110.34,852.784 2115.13,861.209 2119.92,869.662 2124.71,878.14 2129.5,886.641 2134.29,895.164 2139.08,903.706 2143.87,912.267 \n",
       "  2148.67,920.844 2153.46,929.435 2158.25,938.038 2163.04,946.652 2167.83,955.275 2172.62,963.904 2177.41,972.537 2182.2,981.173 2186.99,989.809 2191.78,998.444 \n",
       "  2196.57,1007.07 2201.36,1015.7 2206.16,1024.32 2210.95,1032.92 2215.74,1041.52 2220.53,1050.09 2225.32,1058.66 2230.11,1067.2 2234.9,1075.72 2239.69,1084.22 \n",
       "  2244.48,1092.7 2249.27,1101.14 2254.06,1109.56 2258.86,1117.94 2263.65,1126.29 2268.44,1134.6 2273.23,1142.87 2278.02,1151.1 2282.81,1159.29 2287.6,1167.44 \n",
       "  2292.39,1175.53 \n",
       "  \"/>\n",
       "<polyline clip-path=\"url(#clip082)\" style=\"stroke:#e26f46; stroke-linecap:butt; stroke-linejoin:round; stroke-width:4; stroke-opacity:1; fill:none\" points=\"\n",
       "  280.231,593.88 285.022,586.867 289.813,579.935 294.604,573.085 299.394,566.317 304.185,559.632 308.976,553.029 313.767,546.508 318.558,540.07 323.349,533.714 \n",
       "  328.14,527.441 332.93,521.25 337.721,515.14 342.512,509.113 347.303,503.167 352.094,497.303 356.885,491.52 361.676,485.817 366.466,480.195 371.257,474.653 \n",
       "  376.048,469.191 380.839,463.808 385.63,458.504 390.421,453.278 395.212,448.131 400.002,443.06 404.793,438.066 409.584,433.149 414.375,428.307 419.166,423.541 \n",
       "  423.957,418.848 428.748,414.23 433.538,409.686 438.329,405.213 443.12,400.813 447.911,396.484 452.702,392.226 457.493,388.038 462.284,383.919 467.074,379.869 \n",
       "  471.865,375.887 476.656,371.972 481.447,368.123 486.238,364.34 491.029,360.623 495.82,356.969 500.61,353.379 505.401,349.852 510.192,346.387 514.983,342.984 \n",
       "  519.774,339.641 524.565,336.358 529.356,333.134 534.147,329.969 538.937,326.861 543.728,323.81 548.519,320.816 553.31,317.877 558.101,314.993 562.892,312.163 \n",
       "  567.683,309.386 572.473,306.662 577.264,303.99 582.055,301.369 586.846,298.798 591.637,296.277 596.428,293.806 601.219,291.383 606.009,289.008 610.8,286.68 \n",
       "  615.591,284.398 620.382,282.162 625.173,279.971 629.964,277.825 634.755,275.722 639.545,273.663 644.336,271.646 649.127,269.672 653.918,267.738 658.709,265.846 \n",
       "  663.5,263.993 668.291,262.181 673.081,260.407 677.872,258.672 682.663,256.974 687.454,255.314 692.245,253.691 697.036,252.104 701.827,250.553 706.617,249.037 \n",
       "  711.408,247.556 716.199,246.109 720.99,244.696 725.781,243.316 730.572,241.969 735.363,240.654 740.153,239.371 744.944,238.119 749.735,236.898 754.526,235.708 \n",
       "  759.317,234.548 764.108,233.418 768.899,232.317 773.689,231.245 778.48,230.201 783.271,229.186 788.062,228.198 792.853,227.238 797.644,226.305 802.435,225.398 \n",
       "  807.225,224.518 812.016,223.663 816.807,222.835 821.598,222.032 826.389,221.253 831.18,220.5 835.971,219.771 840.761,219.066 845.552,218.386 850.343,217.728 \n",
       "  855.134,217.095 859.925,216.484 864.716,215.896 869.507,215.331 874.297,214.788 879.088,214.267 883.879,213.768 888.67,213.291 893.461,212.836 898.252,212.401 \n",
       "  903.043,211.988 907.833,211.596 912.624,211.224 917.415,210.873 922.206,210.543 926.997,210.233 931.788,209.942 936.579,209.672 941.369,209.422 946.16,209.191 \n",
       "  950.951,208.979 955.742,208.788 960.533,208.615 965.324,208.461 970.115,208.327 974.905,208.211 979.696,208.115 984.487,208.037 989.278,207.978 994.069,207.937 \n",
       "  998.86,207.915 1003.65,207.911 1008.44,207.926 1013.23,207.959 1018.02,208.01 1022.81,208.079 1027.6,208.167 1032.4,208.273 1037.19,208.397 1041.98,208.539 \n",
       "  1046.77,208.698 1051.56,208.876 1056.35,209.072 1061.14,209.286 1065.93,209.518 1070.72,209.768 1075.51,210.036 1080.3,210.322 1085.1,210.626 1089.89,210.949 \n",
       "  1094.68,211.289 1099.47,211.647 1104.26,212.023 1109.05,212.418 1113.84,212.831 1118.63,213.262 1123.42,213.711 1128.21,214.179 1133,214.665 1137.79,215.17 \n",
       "  1142.59,215.693 1147.38,216.235 1152.17,216.795 1156.96,217.375 1161.75,217.973 1166.54,218.59 1171.33,219.226 1176.12,219.882 1180.91,220.557 1185.7,221.251 \n",
       "  1190.49,221.965 1195.28,222.698 1200.08,223.451 1204.87,224.224 1209.66,225.017 1214.45,225.831 1219.24,226.664 1224.03,227.518 1228.82,228.393 1233.61,229.288 \n",
       "  1238.4,230.205 1243.19,231.142 1247.98,232.101 1252.78,233.081 1257.57,234.083 1262.36,235.107 1267.15,236.152 1271.94,237.22 1276.73,238.311 1281.52,239.424 \n",
       "  1286.31,240.559 1291.1,241.718 1295.89,242.9 1300.68,244.106 1305.47,245.335 1310.27,246.588 1315.06,247.866 1319.85,249.168 1324.64,250.494 1329.43,251.846 \n",
       "  1334.22,253.222 1339.01,254.625 1343.8,256.053 1348.59,257.507 1353.38,258.987 1358.17,260.494 1362.96,262.028 1367.76,263.589 1372.55,265.178 1377.34,266.794 \n",
       "  1382.13,268.439 1386.92,270.112 1391.71,271.813 1396.5,273.544 1401.29,275.305 1406.08,277.095 1410.87,278.915 1415.66,280.766 1420.46,282.648 1425.25,284.561 \n",
       "  1430.04,286.505 1434.83,288.482 1439.62,290.491 1444.41,292.533 1449.2,294.607 1453.99,296.716 1458.78,298.858 1463.57,301.035 1468.36,303.247 1473.15,305.494 \n",
       "  1477.95,307.776 1482.74,310.095 1487.53,312.45 1492.32,314.842 1497.11,317.272 1501.9,319.74 1506.69,322.246 1511.48,324.791 1516.27,327.375 1521.06,329.999 \n",
       "  1525.85,332.663 1530.64,335.369 1535.44,338.115 1540.23,340.904 1545.02,343.734 1549.81,346.608 1554.6,349.525 1559.39,352.485 1564.18,355.491 1568.97,358.541 \n",
       "  1573.76,361.636 1578.55,364.778 1583.34,367.966 1588.14,371.202 1592.93,374.485 1597.72,377.817 1602.51,381.197 1607.3,384.627 1612.09,388.106 1616.88,391.636 \n",
       "  1621.67,395.218 1626.46,398.851 1631.25,402.536 1636.04,406.274 1640.83,410.066 1645.63,413.911 1650.42,417.811 1655.21,421.767 1660,425.778 1664.79,429.845 \n",
       "  1669.58,433.97 1674.37,438.151 1679.16,442.391 1683.95,446.69 1688.74,451.048 1693.53,455.465 1698.32,459.943 1703.12,464.482 1707.91,469.082 1712.7,473.744 \n",
       "  1717.49,478.469 1722.28,483.256 1727.07,488.108 1731.86,493.023 1736.65,498.003 1741.44,503.048 1746.23,508.158 1751.02,513.334 1755.82,518.577 1760.61,523.887 \n",
       "  1765.4,529.263 1770.19,534.708 1774.98,540.22 1779.77,545.801 1784.56,551.451 1789.35,557.17 1794.14,562.958 1798.93,568.815 1803.72,574.743 1808.51,580.741 \n",
       "  1813.31,586.809 1818.1,592.947 1822.89,599.156 1827.68,605.436 1832.47,611.786 1837.26,618.208 1842.05,624.7 1846.84,631.263 1851.63,637.897 1856.42,644.601 \n",
       "  1861.21,651.376 1866,658.221 1870.8,665.137 1875.59,672.122 1880.38,679.177 1885.17,686.301 1889.96,693.494 1894.75,700.755 1899.54,708.084 1904.33,715.48 \n",
       "  1909.12,722.943 1913.91,730.472 1918.7,738.067 1923.5,745.726 1928.29,753.448 1933.08,761.234 1937.87,769.082 1942.66,776.99 1947.45,784.959 1952.24,792.986 \n",
       "  1957.03,801.071 1961.82,809.213 1966.61,817.41 1971.4,825.66 1976.19,833.963 1980.99,842.317 1985.78,850.72 1990.57,859.172 1995.36,867.669 2000.15,876.211 \n",
       "  2004.94,884.795 2009.73,893.42 2014.52,902.084 2019.31,910.786 2024.1,919.522 2028.89,928.291 2033.68,937.09 2038.48,945.918 2043.27,954.773 2048.06,963.651 \n",
       "  2052.85,972.551 2057.64,981.47 2062.43,990.406 2067.22,999.356 2072.01,1008.32 2076.8,1017.29 2081.59,1026.27 2086.38,1035.25 2091.18,1044.23 2095.97,1053.21 \n",
       "  2100.76,1062.18 2105.55,1071.15 2110.34,1080.11 2115.13,1089.05 2119.92,1097.98 2124.71,1106.89 2129.5,1115.77 2134.29,1124.64 2139.08,1133.47 2143.87,1142.27 \n",
       "  2148.67,1151.04 2153.46,1159.77 2158.25,1168.46 2163.04,1177.11 2167.83,1185.71 2172.62,1194.27 2177.41,1202.77 2182.2,1211.21 2186.99,1219.6 2191.78,1227.93 \n",
       "  2196.57,1236.2 2201.36,1244.39 2206.16,1252.52 2210.95,1260.58 2215.74,1268.56 2220.53,1276.47 2225.32,1284.3 2230.11,1292.04 2234.9,1299.7 2239.69,1307.28 \n",
       "  2244.48,1314.76 2249.27,1322.15 2254.06,1329.45 2258.86,1336.65 2263.65,1343.76 2268.44,1350.77 2273.23,1357.67 2278.02,1364.47 2282.81,1371.17 2287.6,1377.76 \n",
       "  2292.39,1384.24 \n",
       "  \"/>\n",
       "<polyline clip-path=\"url(#clip082)\" style=\"stroke:#3da44d; stroke-linecap:butt; stroke-linejoin:round; stroke-width:4; stroke-opacity:1; fill:none\" points=\"\n",
       "  280.231,194.618 285.022,192.9 289.813,191.203 294.604,189.526 299.394,187.871 304.185,186.235 308.976,184.62 313.767,183.024 318.558,181.448 323.349,179.891 \n",
       "  328.14,178.353 332.93,176.835 337.721,175.335 342.512,173.853 347.303,172.39 352.094,170.945 356.885,169.517 361.676,168.108 366.466,166.715 371.257,165.34 \n",
       "  376.048,163.982 380.839,162.641 385.63,161.317 390.421,160.009 395.212,158.717 400.002,157.441 404.793,156.181 409.584,154.937 414.375,153.708 419.166,152.495 \n",
       "  423.957,151.297 428.748,150.114 433.538,148.946 438.329,147.792 443.12,146.653 447.911,145.529 452.702,144.418 457.493,143.322 462.284,142.24 467.074,141.171 \n",
       "  471.865,140.116 476.656,139.074 481.447,138.046 486.238,137.031 491.029,136.029 495.82,135.04 500.61,134.063 505.401,133.099 510.192,132.148 514.983,131.209 \n",
       "  519.774,130.283 524.565,129.368 529.356,128.466 534.147,127.575 538.937,126.697 543.728,125.83 548.519,124.974 553.31,124.13 558.101,123.298 562.892,122.476 \n",
       "  567.683,121.666 572.473,120.867 577.264,120.079 582.055,119.302 586.846,118.536 591.637,117.78 596.428,117.035 601.219,116.3 606.009,115.576 610.8,114.862 \n",
       "  615.591,114.159 620.382,113.465 625.173,112.782 629.964,112.109 634.755,111.446 639.545,110.792 644.336,110.149 649.127,109.515 653.918,108.891 658.709,108.276 \n",
       "  663.5,107.672 668.291,107.076 673.081,106.49 677.872,105.913 682.663,105.346 687.454,104.787 692.245,104.238 697.036,103.698 701.827,103.167 706.617,102.646 \n",
       "  711.408,102.133 716.199,101.628 720.99,101.133 725.781,100.647 730.572,100.169 735.363,99.6999 740.153,99.2395 744.944,98.7876 749.735,98.3443 754.526,97.9095 \n",
       "  759.317,97.4832 764.108,97.0653 768.899,96.6557 773.689,96.2545 778.48,95.8615 783.271,95.4768 788.062,95.1003 792.853,94.732 797.644,94.3718 802.435,94.0198 \n",
       "  807.225,93.6758 812.016,93.3398 816.807,93.0118 821.598,92.6918 826.389,92.3797 831.18,92.0755 835.971,91.7792 840.761,91.4908 845.552,91.2102 850.343,90.9373 \n",
       "  855.134,90.6723 859.925,90.415 864.716,90.1654 869.507,89.9235 874.297,89.6893 879.088,89.4628 883.879,89.2439 888.67,89.0327 893.461,88.8291 898.252,88.633 \n",
       "  903.043,88.4446 907.833,88.2637 912.624,88.0904 917.415,87.9247 922.206,87.7665 926.997,87.6158 931.788,87.4726 936.579,87.337 941.369,87.2089 946.16,87.0884 \n",
       "  950.951,86.9753 955.742,86.8698 960.533,86.7718 965.324,86.6813 970.115,86.5984 974.905,86.523 979.696,86.4551 984.487,86.3948 989.278,86.3421 994.069,86.297 \n",
       "  998.86,86.2594 1003.65,86.2295 1008.44,86.2072 1013.23,86.1926 1018.02,86.1857 1022.81,86.1864 1027.6,86.1949 1032.4,86.2111 1037.19,86.2351 1041.98,86.267 \n",
       "  1046.77,86.3066 1051.56,86.3542 1056.35,86.4097 1061.14,86.4731 1065.93,86.5445 1070.72,86.624 1075.51,86.7116 1080.3,86.8073 1085.1,86.9111 1089.89,87.0232 \n",
       "  1094.68,87.1436 1099.47,87.2724 1104.26,87.4095 1109.05,87.5551 1113.84,87.7093 1118.63,87.872 1123.42,88.0434 1128.21,88.2235 1133,88.4124 1137.79,88.6102 \n",
       "  1142.59,88.8169 1147.38,89.0327 1152.17,89.2576 1156.96,89.4917 1161.75,89.7351 1166.54,89.9879 1171.33,90.2501 1176.12,90.5219 1180.91,90.8034 1185.7,91.0946 \n",
       "  1190.49,91.3958 1195.28,91.7069 1200.08,92.0281 1204.87,92.3595 1209.66,92.7012 1214.45,93.0533 1219.24,93.4161 1224.03,93.7895 1228.82,94.1737 1233.61,94.5689 \n",
       "  1238.4,94.9752 1243.19,95.3927 1247.98,95.8215 1252.78,96.2619 1257.57,96.7139 1262.36,97.1778 1267.15,97.6535 1271.94,98.1415 1276.73,98.6417 1281.52,99.1543 \n",
       "  1286.31,99.6796 1291.1,100.218 1295.89,100.769 1300.68,101.333 1305.47,101.91 1310.27,102.501 1315.06,103.106 1319.85,103.725 1324.64,104.357 1329.43,105.004 \n",
       "  1334.22,105.666 1339.01,106.342 1343.8,107.033 1348.59,107.74 1353.38,108.461 1358.17,109.199 1362.96,109.952 1367.76,110.721 1372.55,111.506 1377.34,112.308 \n",
       "  1382.13,113.127 1386.92,113.963 1391.71,114.816 1396.5,115.686 1401.29,116.575 1406.08,117.481 1410.87,118.406 1415.66,119.349 1420.46,120.312 1425.25,121.293 \n",
       "  1430.04,122.294 1434.83,123.315 1439.62,124.355 1444.41,125.416 1449.2,126.498 1453.99,127.6 1458.78,128.724 1463.57,129.87 1468.36,131.037 1473.15,132.226 \n",
       "  1477.95,133.438 1482.74,134.673 1487.53,135.931 1492.32,137.212 1497.11,138.517 1501.9,139.847 1506.69,141.201 1511.48,142.58 1516.27,143.984 1521.06,145.413 \n",
       "  1525.85,146.869 1530.64,148.351 1535.44,149.859 1540.23,151.395 1545.02,152.958 1549.81,154.549 1554.6,156.168 1559.39,157.815 1564.18,159.491 1568.97,161.197 \n",
       "  1573.76,162.932 1578.55,164.697 1583.34,166.493 1588.14,168.319 1592.93,170.177 1597.72,172.066 1602.51,173.987 1607.3,175.94 1612.09,177.926 1616.88,179.946 \n",
       "  1621.67,181.999 1626.46,184.085 1631.25,186.206 1636.04,188.362 1640.83,190.553 1645.63,192.779 1650.42,195.041 1655.21,197.34 1660,199.675 1664.79,202.047 \n",
       "  1669.58,204.456 1674.37,206.904 1679.16,209.389 1683.95,211.913 1688.74,214.476 1693.53,217.078 1698.32,219.719 1703.12,222.401 1707.91,225.123 1712.7,227.886 \n",
       "  1717.49,230.69 1722.28,233.535 1727.07,236.422 1731.86,239.351 1736.65,242.323 1741.44,245.337 1746.23,248.395 1751.02,251.496 1755.82,254.64 1760.61,257.829 \n",
       "  1765.4,261.062 1770.19,264.34 1774.98,267.662 1779.77,271.03 1784.56,274.443 1789.35,277.902 1794.14,281.407 1798.93,284.958 1803.72,288.555 1808.51,292.2 \n",
       "  1813.31,295.891 1818.1,299.63 1822.89,303.415 1827.68,307.249 1832.47,311.13 1837.26,315.059 1842.05,319.037 1846.84,323.062 1851.63,327.136 1856.42,331.259 \n",
       "  1861.21,335.43 1866,339.651 1870.8,343.92 1875.59,348.239 1880.38,352.606 1885.17,357.023 1889.96,361.49 1894.75,366.006 1899.54,370.571 1904.33,375.186 \n",
       "  1909.12,379.85 1913.91,384.564 1918.7,389.328 1923.5,394.142 1928.29,399.005 1933.08,403.917 1937.87,408.879 1942.66,413.891 1947.45,418.952 1952.24,424.063 \n",
       "  1957.03,429.223 1961.82,434.432 1966.61,439.69 1971.4,444.997 1976.19,450.354 1980.99,455.759 1985.78,461.212 1990.57,466.714 1995.36,472.265 2000.15,477.863 \n",
       "  2004.94,483.509 2009.73,489.203 2014.52,494.944 2019.31,500.733 2024.1,506.568 2028.89,512.45 2033.68,518.378 2038.48,524.353 2043.27,530.373 2048.06,536.438 \n",
       "  2052.85,542.549 2057.64,548.704 2062.43,554.903 2067.22,561.147 2072.01,567.434 2076.8,573.764 2081.59,580.137 2086.38,586.552 2091.18,593.008 2095.97,599.506 \n",
       "  2100.76,606.045 2105.55,612.624 2110.34,619.243 2115.13,625.901 2119.92,632.597 2124.71,639.332 2129.5,646.104 2134.29,652.913 2139.08,659.758 2143.87,666.638 \n",
       "  2148.67,673.554 2153.46,680.503 2158.25,687.486 2163.04,694.502 2167.83,701.55 2172.62,708.629 2177.41,715.739 2182.2,722.879 2186.99,730.047 2191.78,737.244 \n",
       "  2196.57,744.468 2201.36,751.719 2206.16,758.995 2210.95,766.296 2215.74,773.62 2220.53,780.968 2225.32,788.337 2230.11,795.728 2234.9,803.138 2239.69,810.568 \n",
       "  2244.48,818.016 2249.27,825.481 2254.06,832.962 2258.86,840.457 2263.65,847.967 2268.44,855.49 2273.23,863.025 2278.02,870.57 2282.81,878.125 2287.6,885.688 \n",
       "  2292.39,893.259 \n",
       "  \"/>\n",
       "<path clip-path=\"url(#clip080)\" d=\"\n",
       "M1906.8 300.469 L2281.66 300.469 L2281.66 93.1086 L1906.8 93.1086  Z\n",
       "  \" fill=\"#ffffff\" fill-rule=\"evenodd\" fill-opacity=\"1\"/>\n",
       "<polyline clip-path=\"url(#clip080)\" style=\"stroke:#000000; stroke-linecap:butt; stroke-linejoin:round; stroke-width:4; stroke-opacity:1; fill:none\" points=\"\n",
       "  1906.8,300.469 2281.66,300.469 2281.66,93.1086 1906.8,93.1086 1906.8,300.469 \n",
       "  \"/>\n",
       "<polyline clip-path=\"url(#clip080)\" style=\"stroke:#009af9; stroke-linecap:butt; stroke-linejoin:round; stroke-width:4; stroke-opacity:1; fill:none\" points=\"\n",
       "  1930.8,144.949 2074.8,144.949 \n",
       "  \"/>\n",
       "<path clip-path=\"url(#clip080)\" d=\"M2098.8 126.21 L2103.06 126.21 L2103.06 162.229 L2098.8 162.229 L2098.8 126.21 Z\" fill=\"#000000\" fill-rule=\"evenodd\" fill-opacity=\"1\" /><path clip-path=\"url(#clip080)\" d=\"M2125.1 126.21 L2125.1 129.752 L2121.02 129.752 Q2118.73 129.752 2117.83 130.678 Q2116.95 131.604 2116.95 134.011 L2116.95 136.303 L2123.96 136.303 L2123.96 139.613 L2116.95 139.613 L2116.95 162.229 L2112.66 162.229 L2112.66 139.613 L2108.59 139.613 L2108.59 136.303 L2112.66 136.303 L2112.66 134.497 Q2112.66 130.169 2114.68 128.201 Q2116.69 126.21 2121.07 126.21 L2125.1 126.21 Z\" fill=\"#000000\" fill-rule=\"evenodd\" fill-opacity=\"1\" /><path clip-path=\"url(#clip080)\" d=\"M2132.78 158.34 L2132.78 172.09 L2128.5 172.09 L2128.5 136.303 L2132.78 136.303 L2132.78 140.238 Q2134.12 137.923 2136.16 136.812 Q2138.22 135.678 2141.07 135.678 Q2145.79 135.678 2148.73 139.428 Q2151.69 143.178 2151.69 149.289 Q2151.69 155.4 2148.73 159.15 Q2145.79 162.9 2141.07 162.9 Q2138.22 162.9 2136.16 161.789 Q2134.12 160.655 2132.78 158.34 M2147.27 149.289 Q2147.27 144.59 2145.33 141.928 Q2143.41 139.243 2140.03 139.243 Q2136.65 139.243 2134.7 141.928 Q2132.78 144.59 2132.78 149.289 Q2132.78 153.988 2134.7 156.673 Q2136.65 159.335 2140.03 159.335 Q2143.41 159.335 2145.33 156.673 Q2147.27 153.988 2147.27 149.289 Z\" fill=\"#000000\" fill-rule=\"evenodd\" fill-opacity=\"1\" /><polyline clip-path=\"url(#clip080)\" style=\"stroke:#e26f46; stroke-linecap:butt; stroke-linejoin:round; stroke-width:4; stroke-opacity:1; fill:none\" points=\"\n",
       "  1930.8,196.789 2074.8,196.789 \n",
       "  \"/>\n",
       "<path clip-path=\"url(#clip080)\" d=\"M2098.8 178.05 L2103.06 178.05 L2103.06 214.069 L2098.8 214.069 L2098.8 178.05 Z\" fill=\"#000000\" fill-rule=\"evenodd\" fill-opacity=\"1\" /><path clip-path=\"url(#clip080)\" d=\"M2122.02 191.129 Q2118.59 191.129 2116.6 193.814 Q2114.61 196.476 2114.61 201.129 Q2114.61 205.782 2116.58 208.467 Q2118.57 211.129 2122.02 211.129 Q2125.42 211.129 2127.41 208.444 Q2129.4 205.758 2129.4 201.129 Q2129.4 196.522 2127.41 193.837 Q2125.42 191.129 2122.02 191.129 M2122.02 187.518 Q2127.57 187.518 2130.74 191.129 Q2133.91 194.74 2133.91 201.129 Q2133.91 207.495 2130.74 211.129 Q2127.57 214.74 2122.02 214.74 Q2116.44 214.74 2113.27 211.129 Q2110.12 207.495 2110.12 201.129 Q2110.12 194.74 2113.27 191.129 Q2116.44 187.518 2122.02 187.518 Z\" fill=\"#000000\" fill-rule=\"evenodd\" fill-opacity=\"1\" /><path clip-path=\"url(#clip080)\" d=\"M2138.5 188.143 L2142.76 188.143 L2148.08 208.374 L2153.38 188.143 L2158.41 188.143 L2163.73 208.374 L2169.03 188.143 L2173.29 188.143 L2166.51 214.069 L2161.48 214.069 L2155.91 192.819 L2150.3 214.069 L2145.28 214.069 L2138.5 188.143 Z\" fill=\"#000000\" fill-rule=\"evenodd\" fill-opacity=\"1\" /><path clip-path=\"url(#clip080)\" d=\"M2201.92 200.041 L2201.92 202.124 L2182.34 202.124 Q2182.62 206.522 2184.98 208.837 Q2187.36 211.129 2191.6 211.129 Q2194.05 211.129 2196.34 210.527 Q2198.66 209.925 2200.93 208.721 L2200.93 212.749 Q2198.64 213.721 2196.23 214.231 Q2193.82 214.74 2191.34 214.74 Q2185.14 214.74 2181.51 211.129 Q2177.9 207.518 2177.9 201.36 Q2177.9 194.995 2181.32 191.268 Q2184.77 187.518 2190.6 187.518 Q2195.84 187.518 2198.87 190.897 Q2201.92 194.254 2201.92 200.041 M2197.66 198.791 Q2197.62 195.296 2195.7 193.212 Q2193.8 191.129 2190.65 191.129 Q2187.09 191.129 2184.93 193.143 Q2182.8 195.157 2182.48 198.814 L2197.66 198.791 Z\" fill=\"#000000\" fill-rule=\"evenodd\" fill-opacity=\"1\" /><path clip-path=\"url(#clip080)\" d=\"M2223.94 192.124 Q2223.22 191.708 2222.36 191.522 Q2221.53 191.314 2220.51 191.314 Q2216.9 191.314 2214.96 193.675 Q2213.03 196.013 2213.03 200.411 L2213.03 214.069 L2208.75 214.069 L2208.75 188.143 L2213.03 188.143 L2213.03 192.171 Q2214.38 189.809 2216.53 188.675 Q2218.68 187.518 2221.76 187.518 Q2222.2 187.518 2222.73 187.587 Q2223.27 187.634 2223.91 187.749 L2223.94 192.124 Z\" fill=\"#000000\" fill-rule=\"evenodd\" fill-opacity=\"1\" /><polyline clip-path=\"url(#clip080)\" style=\"stroke:#3da44d; stroke-linecap:butt; stroke-linejoin:round; stroke-width:4; stroke-opacity:1; fill:none\" points=\"\n",
       "  1930.8,248.629 2074.8,248.629 \n",
       "  \"/>\n",
       "<path clip-path=\"url(#clip080)\" d=\"M2098.8 255.677 L2098.8 239.983 L2103.06 239.983 L2103.06 255.515 Q2103.06 259.196 2104.49 261.048 Q2105.93 262.876 2108.8 262.876 Q2112.25 262.876 2114.24 260.677 Q2116.25 258.478 2116.25 254.682 L2116.25 239.983 L2120.51 239.983 L2120.51 265.909 L2116.25 265.909 L2116.25 261.927 Q2114.7 264.288 2112.64 265.446 Q2110.6 266.58 2107.9 266.58 Q2103.43 266.58 2101.11 263.802 Q2098.8 261.024 2098.8 255.677 M2109.52 239.358 L2109.52 239.358 Z\" fill=\"#000000\" fill-rule=\"evenodd\" fill-opacity=\"1\" /><path clip-path=\"url(#clip080)\" d=\"M2133.41 262.02 L2133.41 275.77 L2129.12 275.77 L2129.12 239.983 L2133.41 239.983 L2133.41 243.918 Q2134.75 241.603 2136.79 240.492 Q2138.85 239.358 2141.69 239.358 Q2146.41 239.358 2149.35 243.108 Q2152.32 246.858 2152.32 252.969 Q2152.32 259.08 2149.35 262.83 Q2146.41 266.58 2141.69 266.58 Q2138.85 266.58 2136.79 265.469 Q2134.75 264.335 2133.41 262.02 M2147.9 252.969 Q2147.9 248.27 2145.95 245.608 Q2144.03 242.923 2140.65 242.923 Q2137.27 242.923 2135.33 245.608 Q2133.41 248.27 2133.41 252.969 Q2133.41 257.668 2135.33 260.353 Q2137.27 263.015 2140.65 263.015 Q2144.03 263.015 2145.95 260.353 Q2147.9 257.668 2147.9 252.969 Z\" fill=\"#000000\" fill-rule=\"evenodd\" fill-opacity=\"1\" /><path clip-path=\"url(#clip080)\" d=\"M2163.5 262.02 L2163.5 275.77 L2159.22 275.77 L2159.22 239.983 L2163.5 239.983 L2163.5 243.918 Q2164.84 241.603 2166.88 240.492 Q2168.94 239.358 2171.78 239.358 Q2176.51 239.358 2179.45 243.108 Q2182.41 246.858 2182.41 252.969 Q2182.41 259.08 2179.45 262.83 Q2176.51 266.58 2171.78 266.58 Q2168.94 266.58 2166.88 265.469 Q2164.84 264.335 2163.5 262.02 M2177.99 252.969 Q2177.99 248.27 2176.04 245.608 Q2174.12 242.923 2170.74 242.923 Q2167.36 242.923 2165.42 245.608 Q2163.5 248.27 2163.5 252.969 Q2163.5 257.668 2165.42 260.353 Q2167.36 263.015 2170.74 263.015 Q2174.12 263.015 2176.04 260.353 Q2177.99 257.668 2177.99 252.969 Z\" fill=\"#000000\" fill-rule=\"evenodd\" fill-opacity=\"1\" /><path clip-path=\"url(#clip080)\" d=\"M2211.65 251.881 L2211.65 253.964 L2192.06 253.964 Q2192.34 258.362 2194.7 260.677 Q2197.09 262.969 2201.32 262.969 Q2203.78 262.969 2206.07 262.367 Q2208.38 261.765 2210.65 260.561 L2210.65 264.589 Q2208.36 265.561 2205.95 266.071 Q2203.54 266.58 2201.07 266.58 Q2194.86 266.58 2191.23 262.969 Q2187.62 259.358 2187.62 253.2 Q2187.62 246.835 2191.04 243.108 Q2194.49 239.358 2200.33 239.358 Q2205.56 239.358 2208.59 242.737 Q2211.65 246.094 2211.65 251.881 M2207.39 250.631 Q2207.34 247.136 2205.42 245.052 Q2203.52 242.969 2200.37 242.969 Q2196.81 242.969 2194.66 244.983 Q2192.53 246.997 2192.2 250.654 L2207.39 250.631 Z\" fill=\"#000000\" fill-rule=\"evenodd\" fill-opacity=\"1\" /><path clip-path=\"url(#clip080)\" d=\"M2233.66 243.964 Q2232.94 243.548 2232.09 243.362 Q2231.25 243.154 2230.23 243.154 Q2226.62 243.154 2224.68 245.515 Q2222.76 247.853 2222.76 252.251 L2222.76 265.909 L2218.47 265.909 L2218.47 239.983 L2222.76 239.983 L2222.76 244.011 Q2224.1 241.649 2226.25 240.515 Q2228.4 239.358 2231.48 239.358 Q2231.92 239.358 2232.46 239.427 Q2232.99 239.474 2233.64 239.589 L2233.66 243.964 Z\" fill=\"#000000\" fill-rule=\"evenodd\" fill-opacity=\"1\" /></svg>\n"
      ]
     },
     "execution_count": 41,
     "metadata": {},
     "output_type": "execute_result"
    }
   ],
   "source": [
    "plot(df_pred.age, Matrix(probit_pred), labels=[\"lfp\" \"lower\" \"upper\"],\n",
    "     xlabel=\"age\", ylabel=\"Pr(lfp=1)\")"
   ]
  },
  {
   "cell_type": "code",
   "execution_count": 42,
   "id": "b4adaf76",
   "metadata": {},
   "outputs": [
    {
     "data": {
      "text/plain": [
       "boot_sample (generic function with 1 method)"
      ]
     },
     "execution_count": 42,
     "metadata": {},
     "output_type": "execute_result"
    }
   ],
   "source": [
    "function boot_sample(df)\n",
    "    df_boot = df[rand(1:nrow(df), nrow(df)), :]\n",
    "    probit_boot = glm(@formula(lfp ~ lnnlinc + age + age^2 + educ + nyc + noc + foreign),\n",
    "                      df_boot, Binomial(), ProbitLink())\n",
    "    return (; (Symbol.(coefnames(probit_boot)) .=> coef(probit_boot))...)\n",
    "end"
   ]
  },
  {
   "cell_type": "code",
   "execution_count": 43,
   "id": "1b0f2635",
   "metadata": {},
   "outputs": [
    {
     "data": {
      "text/plain": [
       "run_boot (generic function with 1 method)"
      ]
     },
     "execution_count": 43,
     "metadata": {},
     "output_type": "execute_result"
    }
   ],
   "source": [
    "function run_boot(df, reps)\n",
    "    coef_boot = DataFrame()\n",
    "    for _ in 1:reps\n",
    "        push!(coef_boot, boot_sample(df))\n",
    "    end\n",
    "    return coef_boot\n",
    "end"
   ]
  },
  {
   "cell_type": "code",
   "execution_count": 44,
   "id": "78a07636",
   "metadata": {},
   "outputs": [
    {
     "name": "stdout",
     "output_type": "stream",
     "text": [
      "  2.161693 seconds (6.03 M allocations: 942.063 MiB, 4.74% gc time, 68.27% compilation time)\n"
     ]
    },
    {
     "data": {
      "text/html": [
       "<div class=\"data-frame\"><p>1,000 rows × 8 columns (omitted printing of 1 columns)</p><table class=\"data-frame\"><thead><tr><th></th><th>(Intercept)</th><th>lnnlinc</th><th>age</th><th>age ^ 2</th><th>educ</th><th>nyc</th><th>noc</th></tr><tr><th></th><th title=\"Float64\">Float64</th><th title=\"Float64\">Float64</th><th title=\"Float64\">Float64</th><th title=\"Float64\">Float64</th><th title=\"Float64\">Float64</th><th title=\"Float64\">Float64</th><th title=\"Float64\">Float64</th></tr></thead><tbody><tr><th>1</th><td>3.89753</td><td>-0.683644</td><td>2.19622</td><td>-0.315711</td><td>0.00184476</td><td>-0.759661</td><td>-0.116304</td></tr><tr><th>2</th><td>6.03733</td><td>-0.808077</td><td>1.85422</td><td>-0.277391</td><td>0.00815517</td><td>-0.817424</td><td>-0.196143</td></tr><tr><th>3</th><td>3.78851</td><td>-0.702459</td><td>2.09578</td><td>-0.289319</td><td>0.0274796</td><td>-0.560228</td><td>-0.131949</td></tr><tr><th>4</th><td>3.84855</td><td>-0.673669</td><td>2.20824</td><td>-0.30794</td><td>-0.00995106</td><td>-0.817733</td><td>-0.199632</td></tr><tr><th>5</th><td>3.86901</td><td>-0.677679</td><td>2.07178</td><td>-0.285416</td><td>0.00782889</td><td>-0.610081</td><td>-0.173919</td></tr><tr><th>6</th><td>4.24138</td><td>-0.678265</td><td>2.28935</td><td>-0.338982</td><td>0.0034059</td><td>-0.926661</td><td>-0.350053</td></tr><tr><th>7</th><td>3.76902</td><td>-0.64247</td><td>1.91971</td><td>-0.278204</td><td>0.0287484</td><td>-0.727808</td><td>-0.201696</td></tr><tr><th>8</th><td>5.15023</td><td>-0.798031</td><td>1.90498</td><td>-0.26878</td><td>0.0373576</td><td>-0.800226</td><td>-0.111041</td></tr><tr><th>9</th><td>3.12347</td><td>-0.650024</td><td>2.37745</td><td>-0.335066</td><td>0.00352704</td><td>-0.768625</td><td>-0.101193</td></tr><tr><th>10</th><td>2.4329</td><td>-0.62523</td><td>2.32566</td><td>-0.321631</td><td>0.0426932</td><td>-0.541257</td><td>-0.0643429</td></tr><tr><th>11</th><td>3.06523</td><td>-0.625967</td><td>2.12135</td><td>-0.298013</td><td>0.0336568</td><td>-0.723162</td><td>-0.061559</td></tr><tr><th>12</th><td>4.60502</td><td>-0.85555</td><td>2.72291</td><td>-0.365987</td><td>0.00235041</td><td>-0.600223</td><td>-0.198477</td></tr><tr><th>13</th><td>6.53008</td><td>-0.797675</td><td>1.40956</td><td>-0.221066</td><td>0.0365393</td><td>-0.885277</td><td>-0.220697</td></tr><tr><th>14</th><td>2.14633</td><td>-0.540803</td><td>2.23767</td><td>-0.315759</td><td>0.0151176</td><td>-0.78152</td><td>-0.174004</td></tr><tr><th>15</th><td>1.74928</td><td>-0.481763</td><td>2.40743</td><td>-0.347117</td><td>-0.0157087</td><td>-0.750511</td><td>-0.157627</td></tr><tr><th>16</th><td>5.04343</td><td>-0.772946</td><td>2.16923</td><td>-0.309786</td><td>0.00697176</td><td>-0.835845</td><td>-0.220684</td></tr><tr><th>17</th><td>3.21179</td><td>-0.537728</td><td>1.78635</td><td>-0.262943</td><td>-0.0090764</td><td>-0.721048</td><td>-0.188545</td></tr><tr><th>18</th><td>6.20101</td><td>-0.996644</td><td>2.45431</td><td>-0.342986</td><td>0.0651541</td><td>-0.642571</td><td>-0.227372</td></tr><tr><th>19</th><td>3.36975</td><td>-0.623907</td><td>2.01254</td><td>-0.294752</td><td>0.0376487</td><td>-0.81264</td><td>-0.149462</td></tr><tr><th>20</th><td>4.20439</td><td>-0.739063</td><td>2.36511</td><td>-0.333994</td><td>0.0170522</td><td>-0.758426</td><td>-0.224078</td></tr><tr><th>21</th><td>2.58454</td><td>-0.541718</td><td>1.89479</td><td>-0.270313</td><td>0.0234723</td><td>-0.646551</td><td>-0.127249</td></tr><tr><th>22</th><td>2.90434</td><td>-0.536464</td><td>1.82871</td><td>-0.272165</td><td>0.00331773</td><td>-0.634511</td><td>-0.00722016</td></tr><tr><th>23</th><td>5.49798</td><td>-0.691475</td><td>1.35163</td><td>-0.201982</td><td>-0.00427995</td><td>-0.689496</td><td>-0.0837819</td></tr><tr><th>24</th><td>7.40983</td><td>-0.885409</td><td>1.12672</td><td>-0.175524</td><td>0.0467756</td><td>-0.789496</td><td>-0.0525805</td></tr><tr><th>25</th><td>4.68955</td><td>-0.795269</td><td>2.05814</td><td>-0.276166</td><td>0.0317646</td><td>-0.670591</td><td>-0.0921888</td></tr><tr><th>26</th><td>5.37405</td><td>-0.822864</td><td>1.95716</td><td>-0.268404</td><td>0.0325762</td><td>-0.683122</td><td>-0.123383</td></tr><tr><th>27</th><td>4.0729</td><td>-0.803499</td><td>2.66621</td><td>-0.368712</td><td>0.0338197</td><td>-0.774696</td><td>-0.237184</td></tr><tr><th>28</th><td>3.30481</td><td>-0.598957</td><td>1.99496</td><td>-0.280004</td><td>0.00112482</td><td>-0.87051</td><td>-0.190765</td></tr><tr><th>29</th><td>4.66477</td><td>-0.684524</td><td>1.65512</td><td>-0.242086</td><td>0.0164044</td><td>-0.730929</td><td>-0.0982033</td></tr><tr><th>30</th><td>0.768289</td><td>-0.397229</td><td>2.30299</td><td>-0.320106</td><td>-0.0163254</td><td>-0.694104</td><td>-0.171745</td></tr><tr><th>&vellip;</th><td>&vellip;</td><td>&vellip;</td><td>&vellip;</td><td>&vellip;</td><td>&vellip;</td><td>&vellip;</td><td>&vellip;</td></tr></tbody></table></div>"
      ],
      "text/latex": [
       "\\begin{tabular}{r|cccccccc}\n",
       "\t& (Intercept) & lnnlinc & age & age \\^ 2 & educ & nyc & noc & \\\\\n",
       "\t\\hline\n",
       "\t& Float64 & Float64 & Float64 & Float64 & Float64 & Float64 & Float64 & \\\\\n",
       "\t\\hline\n",
       "\t1 & 3.89753 & -0.683644 & 2.19622 & -0.315711 & 0.00184476 & -0.759661 & -0.116304 & $\\dots$ \\\\\n",
       "\t2 & 6.03733 & -0.808077 & 1.85422 & -0.277391 & 0.00815517 & -0.817424 & -0.196143 & $\\dots$ \\\\\n",
       "\t3 & 3.78851 & -0.702459 & 2.09578 & -0.289319 & 0.0274796 & -0.560228 & -0.131949 & $\\dots$ \\\\\n",
       "\t4 & 3.84855 & -0.673669 & 2.20824 & -0.30794 & -0.00995106 & -0.817733 & -0.199632 & $\\dots$ \\\\\n",
       "\t5 & 3.86901 & -0.677679 & 2.07178 & -0.285416 & 0.00782889 & -0.610081 & -0.173919 & $\\dots$ \\\\\n",
       "\t6 & 4.24138 & -0.678265 & 2.28935 & -0.338982 & 0.0034059 & -0.926661 & -0.350053 & $\\dots$ \\\\\n",
       "\t7 & 3.76902 & -0.64247 & 1.91971 & -0.278204 & 0.0287484 & -0.727808 & -0.201696 & $\\dots$ \\\\\n",
       "\t8 & 5.15023 & -0.798031 & 1.90498 & -0.26878 & 0.0373576 & -0.800226 & -0.111041 & $\\dots$ \\\\\n",
       "\t9 & 3.12347 & -0.650024 & 2.37745 & -0.335066 & 0.00352704 & -0.768625 & -0.101193 & $\\dots$ \\\\\n",
       "\t10 & 2.4329 & -0.62523 & 2.32566 & -0.321631 & 0.0426932 & -0.541257 & -0.0643429 & $\\dots$ \\\\\n",
       "\t11 & 3.06523 & -0.625967 & 2.12135 & -0.298013 & 0.0336568 & -0.723162 & -0.061559 & $\\dots$ \\\\\n",
       "\t12 & 4.60502 & -0.85555 & 2.72291 & -0.365987 & 0.00235041 & -0.600223 & -0.198477 & $\\dots$ \\\\\n",
       "\t13 & 6.53008 & -0.797675 & 1.40956 & -0.221066 & 0.0365393 & -0.885277 & -0.220697 & $\\dots$ \\\\\n",
       "\t14 & 2.14633 & -0.540803 & 2.23767 & -0.315759 & 0.0151176 & -0.78152 & -0.174004 & $\\dots$ \\\\\n",
       "\t15 & 1.74928 & -0.481763 & 2.40743 & -0.347117 & -0.0157087 & -0.750511 & -0.157627 & $\\dots$ \\\\\n",
       "\t16 & 5.04343 & -0.772946 & 2.16923 & -0.309786 & 0.00697176 & -0.835845 & -0.220684 & $\\dots$ \\\\\n",
       "\t17 & 3.21179 & -0.537728 & 1.78635 & -0.262943 & -0.0090764 & -0.721048 & -0.188545 & $\\dots$ \\\\\n",
       "\t18 & 6.20101 & -0.996644 & 2.45431 & -0.342986 & 0.0651541 & -0.642571 & -0.227372 & $\\dots$ \\\\\n",
       "\t19 & 3.36975 & -0.623907 & 2.01254 & -0.294752 & 0.0376487 & -0.81264 & -0.149462 & $\\dots$ \\\\\n",
       "\t20 & 4.20439 & -0.739063 & 2.36511 & -0.333994 & 0.0170522 & -0.758426 & -0.224078 & $\\dots$ \\\\\n",
       "\t21 & 2.58454 & -0.541718 & 1.89479 & -0.270313 & 0.0234723 & -0.646551 & -0.127249 & $\\dots$ \\\\\n",
       "\t22 & 2.90434 & -0.536464 & 1.82871 & -0.272165 & 0.00331773 & -0.634511 & -0.00722016 & $\\dots$ \\\\\n",
       "\t23 & 5.49798 & -0.691475 & 1.35163 & -0.201982 & -0.00427995 & -0.689496 & -0.0837819 & $\\dots$ \\\\\n",
       "\t24 & 7.40983 & -0.885409 & 1.12672 & -0.175524 & 0.0467756 & -0.789496 & -0.0525805 & $\\dots$ \\\\\n",
       "\t25 & 4.68955 & -0.795269 & 2.05814 & -0.276166 & 0.0317646 & -0.670591 & -0.0921888 & $\\dots$ \\\\\n",
       "\t26 & 5.37405 & -0.822864 & 1.95716 & -0.268404 & 0.0325762 & -0.683122 & -0.123383 & $\\dots$ \\\\\n",
       "\t27 & 4.0729 & -0.803499 & 2.66621 & -0.368712 & 0.0338197 & -0.774696 & -0.237184 & $\\dots$ \\\\\n",
       "\t28 & 3.30481 & -0.598957 & 1.99496 & -0.280004 & 0.00112482 & -0.87051 & -0.190765 & $\\dots$ \\\\\n",
       "\t29 & 4.66477 & -0.684524 & 1.65512 & -0.242086 & 0.0164044 & -0.730929 & -0.0982033 & $\\dots$ \\\\\n",
       "\t30 & 0.768289 & -0.397229 & 2.30299 & -0.320106 & -0.0163254 & -0.694104 & -0.171745 & $\\dots$ \\\\\n",
       "\t$\\dots$ & $\\dots$ & $\\dots$ & $\\dots$ & $\\dots$ & $\\dots$ & $\\dots$ & $\\dots$ &  \\\\\n",
       "\\end{tabular}\n"
      ],
      "text/plain": [
       "\u001b[1m1000×8 DataFrame\u001b[0m\n",
       "\u001b[1m  Row \u001b[0m│\u001b[1m (Intercept) \u001b[0m\u001b[1m lnnlinc   \u001b[0m\u001b[1m age     \u001b[0m\u001b[1m age ^ 2   \u001b[0m\u001b[1m educ        \u001b[0m\u001b[1m nyc       \u001b[0m\u001b[1m no\u001b[0m ⋯\n",
       "\u001b[1m      \u001b[0m│\u001b[90m Float64     \u001b[0m\u001b[90m Float64   \u001b[0m\u001b[90m Float64 \u001b[0m\u001b[90m Float64   \u001b[0m\u001b[90m Float64     \u001b[0m\u001b[90m Float64   \u001b[0m\u001b[90m Fl\u001b[0m ⋯\n",
       "──────┼─────────────────────────────────────────────────────────────────────────\n",
       "    1 │    3.89753   -0.683644  2.19622  -0.315711   0.00184476  -0.759661  -0 ⋯\n",
       "    2 │    6.03733   -0.808077  1.85422  -0.277391   0.00815517  -0.817424  -0\n",
       "    3 │    3.78851   -0.702459  2.09578  -0.289319   0.0274796   -0.560228  -0\n",
       "    4 │    3.84855   -0.673669  2.20824  -0.30794   -0.00995106  -0.817733  -0\n",
       "    5 │    3.86901   -0.677679  2.07178  -0.285416   0.00782889  -0.610081  -0 ⋯\n",
       "    6 │    4.24138   -0.678265  2.28935  -0.338982   0.0034059   -0.926661  -0\n",
       "    7 │    3.76902   -0.64247   1.91971  -0.278204   0.0287484   -0.727808  -0\n",
       "    8 │    5.15023   -0.798031  1.90498  -0.26878    0.0373576   -0.800226  -0\n",
       "    9 │    3.12347   -0.650024  2.37745  -0.335066   0.00352704  -0.768625  -0 ⋯\n",
       "   10 │    2.4329    -0.62523   2.32566  -0.321631   0.0426932   -0.541257  -0\n",
       "   11 │    3.06523   -0.625967  2.12135  -0.298013   0.0336568   -0.723162  -0\n",
       "  ⋮   │      ⋮           ⋮         ⋮         ⋮           ⋮           ⋮         ⋱\n",
       "  991 │    5.96651   -0.801122  1.67656  -0.244864   0.0157645   -0.802483  -0\n",
       "  992 │    1.9278    -0.500438  2.10367  -0.300194   0.0224147   -0.750327  -0 ⋯\n",
       "  993 │    4.37019   -0.750974  2.06325  -0.282058   0.0264602   -0.638799  -0\n",
       "  994 │    2.1564    -0.506433  2.12799  -0.299474  -0.00236112  -0.778277  -0\n",
       "  995 │    4.50008   -0.655927  1.85878  -0.270815  -0.026267    -0.595757  -0\n",
       "  996 │    3.65681   -0.631198  1.91247  -0.268847   0.00620034  -0.672621  -0 ⋯\n",
       "  997 │    3.82428   -0.583837  1.75444  -0.264595  -0.00302802  -0.737808  -0\n",
       "  998 │    4.3505    -0.707234  2.17916  -0.319459   0.00677002  -0.772209  -0\n",
       "  999 │    2.37425   -0.583229  2.25732  -0.315333   0.0342427   -0.846287  -0\n",
       " 1000 │    5.35087   -0.843876  2.16397  -0.29809    0.0140982   -0.483684  -0 ⋯\n",
       "\u001b[36m                                                  2 columns and 979 rows omitted\u001b[0m"
      ]
     },
     "execution_count": 44,
     "metadata": {},
     "output_type": "execute_result"
    }
   ],
   "source": [
    "Random.seed!(1234)\n",
    "@time coef_boot = run_boot(df, 1000)"
   ]
  },
  {
   "cell_type": "code",
   "execution_count": 46,
   "id": "8d3372da",
   "metadata": {},
   "outputs": [
    {
     "data": {
      "text/html": [
       "<div class=\"data-frame\"><p>2 rows × 8 columns</p><table class=\"data-frame\"><thead><tr><th></th><th>(Intercept)</th><th>lnnlinc</th><th>age</th><th>age ^ 2</th><th>educ</th><th>nyc</th><th>noc</th><th>foreign: yes</th></tr><tr><th></th><th title=\"Float64\">Float64</th><th title=\"Float64\">Float64</th><th title=\"Float64\">Float64</th><th title=\"Float64\">Float64</th><th title=\"Float64\">Float64</th><th title=\"Float64\">Float64</th><th title=\"Float64\">Float64</th><th title=\"Float64\">Float64</th></tr></thead><tbody><tr><th>1</th><td>1.24129</td><td>-0.947283</td><td>1.29334</td><td>-0.405375</td><td>-0.015854</td><td>-0.926779</td><td>-0.259494</td><td>0.478879</td></tr><tr><th>2</th><td>6.79873</td><td>-0.443171</td><td>2.98478</td><td>-0.19818</td><td>0.0565269</td><td>-0.52503</td><td>-0.0525333</td><td>0.961622</td></tr></tbody></table></div>"
      ],
      "text/latex": [
       "\\begin{tabular}{r|cccccccc}\n",
       "\t& (Intercept) & lnnlinc & age & age \\^ 2 & educ & nyc & noc & foreign: yes\\\\\n",
       "\t\\hline\n",
       "\t& Float64 & Float64 & Float64 & Float64 & Float64 & Float64 & Float64 & Float64\\\\\n",
       "\t\\hline\n",
       "\t1 & 1.24129 & -0.947283 & 1.29334 & -0.405375 & -0.015854 & -0.926779 & -0.259494 & 0.478879 \\\\\n",
       "\t2 & 6.79873 & -0.443171 & 2.98478 & -0.19818 & 0.0565269 & -0.52503 & -0.0525333 & 0.961622 \\\\\n",
       "\\end{tabular}\n"
      ],
      "text/plain": [
       "\u001b[1m2×8 DataFrame\u001b[0m\n",
       "\u001b[1m Row \u001b[0m│\u001b[1m (Intercept) \u001b[0m\u001b[1m lnnlinc   \u001b[0m\u001b[1m age     \u001b[0m\u001b[1m age ^ 2   \u001b[0m\u001b[1m educ       \u001b[0m\u001b[1m nyc       \u001b[0m\u001b[1m noc \u001b[0m ⋯\n",
       "\u001b[1m     \u001b[0m│\u001b[90m Float64     \u001b[0m\u001b[90m Float64   \u001b[0m\u001b[90m Float64 \u001b[0m\u001b[90m Float64   \u001b[0m\u001b[90m Float64    \u001b[0m\u001b[90m Float64   \u001b[0m\u001b[90m Floa\u001b[0m ⋯\n",
       "─────┼──────────────────────────────────────────────────────────────────────────\n",
       "   1 │     1.24129  -0.947283  1.29334  -0.405375  -0.015854   -0.926779  -0.2 ⋯\n",
       "   2 │     6.79873  -0.443171  2.98478  -0.19818    0.0565269  -0.52503   -0.0\n",
       "\u001b[36m                                                               2 columns omitted\u001b[0m"
      ]
     },
     "execution_count": 46,
     "metadata": {},
     "output_type": "execute_result"
    }
   ],
   "source": [
    "conf_boot = mapcols(x -> quantile(x, [0.025, 0.975]), coef_boot)"
   ]
  },
  {
   "cell_type": "code",
   "execution_count": 47,
   "id": "b62efd9d",
   "metadata": {},
   "outputs": [
    {
     "data": {
      "text/plain": [
       "8×2 Matrix{Float64}:\n",
       "  0.992006   6.50591\n",
       " -0.92549   -0.408374\n",
       "  1.28073    2.86989\n",
       " -0.392235  -0.196456\n",
       " -0.015937   0.0543295\n",
       " -0.911238  -0.517691\n",
       " -0.246718  -0.0472509\n",
       "  0.476589   0.95217"
      ]
     },
     "execution_count": 47,
     "metadata": {},
     "output_type": "execute_result"
    }
   ],
   "source": [
    "confint(probit)"
   ]
  },
  {
   "cell_type": "code",
   "execution_count": 48,
   "id": "5beb2c14",
   "metadata": {},
   "outputs": [
    {
     "data": {
      "text/html": [
       "<div class=\"data-frame\"><p>2 rows × 8 columns</p><table class=\"data-frame\"><thead><tr><th></th><th>(Intercept)</th><th>lnnlinc</th><th>age</th><th>age ^ 2</th><th>educ</th><th>nyc</th><th>noc</th><th>foreign: yes</th></tr><tr><th></th><th title=\"Float64\">Float64</th><th title=\"Float64\">Float64</th><th title=\"Float64\">Float64</th><th title=\"Float64\">Float64</th><th title=\"Float64\">Float64</th><th title=\"Float64\">Float64</th><th title=\"Float64\">Float64</th><th title=\"Float64\">Float64</th></tr></thead><tbody><tr><th>1</th><td>0.992006</td><td>-0.92549</td><td>1.28073</td><td>-0.392235</td><td>-0.015937</td><td>-0.911238</td><td>-0.246718</td><td>0.476589</td></tr><tr><th>2</th><td>6.50591</td><td>-0.408374</td><td>2.86989</td><td>-0.196456</td><td>0.0543295</td><td>-0.517691</td><td>-0.0472509</td><td>0.95217</td></tr></tbody></table></div>"
      ],
      "text/latex": [
       "\\begin{tabular}{r|cccccccc}\n",
       "\t& (Intercept) & lnnlinc & age & age \\^ 2 & educ & nyc & noc & foreign: yes\\\\\n",
       "\t\\hline\n",
       "\t& Float64 & Float64 & Float64 & Float64 & Float64 & Float64 & Float64 & Float64\\\\\n",
       "\t\\hline\n",
       "\t1 & 0.992006 & -0.92549 & 1.28073 & -0.392235 & -0.015937 & -0.911238 & -0.246718 & 0.476589 \\\\\n",
       "\t2 & 6.50591 & -0.408374 & 2.86989 & -0.196456 & 0.0543295 & -0.517691 & -0.0472509 & 0.95217 \\\\\n",
       "\\end{tabular}\n"
      ],
      "text/plain": [
       "\u001b[1m2×8 DataFrame\u001b[0m\n",
       "\u001b[1m Row \u001b[0m│\u001b[1m (Intercept) \u001b[0m\u001b[1m lnnlinc   \u001b[0m\u001b[1m age     \u001b[0m\u001b[1m age ^ 2   \u001b[0m\u001b[1m educ       \u001b[0m\u001b[1m nyc       \u001b[0m\u001b[1m noc \u001b[0m ⋯\n",
       "\u001b[1m     \u001b[0m│\u001b[90m Float64     \u001b[0m\u001b[90m Float64   \u001b[0m\u001b[90m Float64 \u001b[0m\u001b[90m Float64   \u001b[0m\u001b[90m Float64    \u001b[0m\u001b[90m Float64   \u001b[0m\u001b[90m Floa\u001b[0m ⋯\n",
       "─────┼──────────────────────────────────────────────────────────────────────────\n",
       "   1 │    0.992006  -0.92549   1.28073  -0.392235  -0.015937   -0.911238  -0.2 ⋯\n",
       "   2 │    6.50591   -0.408374  2.86989  -0.196456   0.0543295  -0.517691  -0.0\n",
       "\u001b[36m                                                               2 columns omitted\u001b[0m"
      ]
     },
     "execution_count": 48,
     "metadata": {},
     "output_type": "execute_result"
    }
   ],
   "source": [
    "conf_param = DataFrame(permutedims(confint(probit)), names(conf_boot))"
   ]
  },
  {
   "cell_type": "code",
   "execution_count": 49,
   "id": "fb6dbbe3",
   "metadata": {},
   "outputs": [
    {
     "data": {
      "text/html": [
       "<div class=\"data-frame\"><p>4 rows × 8 columns</p><table class=\"data-frame\"><thead><tr><th></th><th>(Intercept)</th><th>lnnlinc</th><th>age</th><th>age ^ 2</th><th>educ</th><th>nyc</th><th>noc</th><th>foreign: yes</th></tr><tr><th></th><th title=\"Float64\">Float64</th><th title=\"Float64\">Float64</th><th title=\"Float64\">Float64</th><th title=\"Float64\">Float64</th><th title=\"Float64\">Float64</th><th title=\"Float64\">Float64</th><th title=\"Float64\">Float64</th><th title=\"Float64\">Float64</th></tr></thead><tbody><tr><th>1</th><td>1.24129</td><td>-0.947283</td><td>1.29334</td><td>-0.405375</td><td>-0.015854</td><td>-0.926779</td><td>-0.259494</td><td>0.478879</td></tr><tr><th>2</th><td>6.79873</td><td>-0.443171</td><td>2.98478</td><td>-0.19818</td><td>0.0565269</td><td>-0.52503</td><td>-0.0525333</td><td>0.961622</td></tr><tr><th>3</th><td>0.992006</td><td>-0.92549</td><td>1.28073</td><td>-0.392235</td><td>-0.015937</td><td>-0.911238</td><td>-0.246718</td><td>0.476589</td></tr><tr><th>4</th><td>6.50591</td><td>-0.408374</td><td>2.86989</td><td>-0.196456</td><td>0.0543295</td><td>-0.517691</td><td>-0.0472509</td><td>0.95217</td></tr></tbody></table></div>"
      ],
      "text/latex": [
       "\\begin{tabular}{r|cccccccc}\n",
       "\t& (Intercept) & lnnlinc & age & age \\^ 2 & educ & nyc & noc & foreign: yes\\\\\n",
       "\t\\hline\n",
       "\t& Float64 & Float64 & Float64 & Float64 & Float64 & Float64 & Float64 & Float64\\\\\n",
       "\t\\hline\n",
       "\t1 & 1.24129 & -0.947283 & 1.29334 & -0.405375 & -0.015854 & -0.926779 & -0.259494 & 0.478879 \\\\\n",
       "\t2 & 6.79873 & -0.443171 & 2.98478 & -0.19818 & 0.0565269 & -0.52503 & -0.0525333 & 0.961622 \\\\\n",
       "\t3 & 0.992006 & -0.92549 & 1.28073 & -0.392235 & -0.015937 & -0.911238 & -0.246718 & 0.476589 \\\\\n",
       "\t4 & 6.50591 & -0.408374 & 2.86989 & -0.196456 & 0.0543295 & -0.517691 & -0.0472509 & 0.95217 \\\\\n",
       "\\end{tabular}\n"
      ],
      "text/plain": [
       "\u001b[1m4×8 DataFrame\u001b[0m\n",
       "\u001b[1m Row \u001b[0m│\u001b[1m (Intercept) \u001b[0m\u001b[1m lnnlinc   \u001b[0m\u001b[1m age     \u001b[0m\u001b[1m age ^ 2   \u001b[0m\u001b[1m educ       \u001b[0m\u001b[1m nyc       \u001b[0m\u001b[1m noc \u001b[0m ⋯\n",
       "\u001b[1m     \u001b[0m│\u001b[90m Float64     \u001b[0m\u001b[90m Float64   \u001b[0m\u001b[90m Float64 \u001b[0m\u001b[90m Float64   \u001b[0m\u001b[90m Float64    \u001b[0m\u001b[90m Float64   \u001b[0m\u001b[90m Floa\u001b[0m ⋯\n",
       "─────┼──────────────────────────────────────────────────────────────────────────\n",
       "   1 │    1.24129   -0.947283  1.29334  -0.405375  -0.015854   -0.926779  -0.2 ⋯\n",
       "   2 │    6.79873   -0.443171  2.98478  -0.19818    0.0565269  -0.52503   -0.0\n",
       "   3 │    0.992006  -0.92549   1.28073  -0.392235  -0.015937   -0.911238  -0.2\n",
       "   4 │    6.50591   -0.408374  2.86989  -0.196456   0.0543295  -0.517691  -0.0\n",
       "\u001b[36m                                                               2 columns omitted\u001b[0m"
      ]
     },
     "execution_count": 49,
     "metadata": {},
     "output_type": "execute_result"
    }
   ],
   "source": [
    "append!(conf_boot, conf_param)"
   ]
  },
  {
   "cell_type": "code",
   "execution_count": 50,
   "id": "9f634288",
   "metadata": {},
   "outputs": [
    {
     "data": {
      "text/html": [
       "<div class=\"data-frame\"><p>4 rows × 9 columns (omitted printing of 2 columns)</p><table class=\"data-frame\"><thead><tr><th></th><th>statistic</th><th>(Intercept)</th><th>lnnlinc</th><th>age</th><th>age ^ 2</th><th>educ</th><th>nyc</th></tr><tr><th></th><th title=\"String\">String</th><th title=\"Float64\">Float64</th><th title=\"Float64\">Float64</th><th title=\"Float64\">Float64</th><th title=\"Float64\">Float64</th><th title=\"Float64\">Float64</th><th title=\"Float64\">Float64</th></tr></thead><tbody><tr><th>1</th><td>boot lo</td><td>1.24129</td><td>-0.947283</td><td>1.29334</td><td>-0.405375</td><td>-0.015854</td><td>-0.926779</td></tr><tr><th>2</th><td>boot hi</td><td>6.79873</td><td>-0.443171</td><td>2.98478</td><td>-0.19818</td><td>0.0565269</td><td>-0.52503</td></tr><tr><th>3</th><td>parametric lo</td><td>0.992006</td><td>-0.92549</td><td>1.28073</td><td>-0.392235</td><td>-0.015937</td><td>-0.911238</td></tr><tr><th>4</th><td>parametric hi</td><td>6.50591</td><td>-0.408374</td><td>2.86989</td><td>-0.196456</td><td>0.0543295</td><td>-0.517691</td></tr></tbody></table></div>"
      ],
      "text/latex": [
       "\\begin{tabular}{r|cccccccc}\n",
       "\t& statistic & (Intercept) & lnnlinc & age & age \\^ 2 & educ & nyc & \\\\\n",
       "\t\\hline\n",
       "\t& String & Float64 & Float64 & Float64 & Float64 & Float64 & Float64 & \\\\\n",
       "\t\\hline\n",
       "\t1 & boot lo & 1.24129 & -0.947283 & 1.29334 & -0.405375 & -0.015854 & -0.926779 & $\\dots$ \\\\\n",
       "\t2 & boot hi & 6.79873 & -0.443171 & 2.98478 & -0.19818 & 0.0565269 & -0.52503 & $\\dots$ \\\\\n",
       "\t3 & parametric lo & 0.992006 & -0.92549 & 1.28073 & -0.392235 & -0.015937 & -0.911238 & $\\dots$ \\\\\n",
       "\t4 & parametric hi & 6.50591 & -0.408374 & 2.86989 & -0.196456 & 0.0543295 & -0.517691 & $\\dots$ \\\\\n",
       "\\end{tabular}\n"
      ],
      "text/plain": [
       "\u001b[1m4×9 DataFrame\u001b[0m\n",
       "\u001b[1m Row \u001b[0m│\u001b[1m statistic     \u001b[0m\u001b[1m (Intercept) \u001b[0m\u001b[1m lnnlinc   \u001b[0m\u001b[1m age     \u001b[0m\u001b[1m age ^ 2   \u001b[0m\u001b[1m educ       \u001b[0m\u001b[1m \u001b[0m ⋯\n",
       "\u001b[1m     \u001b[0m│\u001b[90m String        \u001b[0m\u001b[90m Float64     \u001b[0m\u001b[90m Float64   \u001b[0m\u001b[90m Float64 \u001b[0m\u001b[90m Float64   \u001b[0m\u001b[90m Float64    \u001b[0m\u001b[90m \u001b[0m ⋯\n",
       "─────┼──────────────────────────────────────────────────────────────────────────\n",
       "   1 │ boot lo           1.24129   -0.947283  1.29334  -0.405375  -0.015854    ⋯\n",
       "   2 │ boot hi           6.79873   -0.443171  2.98478  -0.19818    0.0565269\n",
       "   3 │ parametric lo     0.992006  -0.92549   1.28073  -0.392235  -0.015937\n",
       "   4 │ parametric hi     6.50591   -0.408374  2.86989  -0.196456   0.0543295\n",
       "\u001b[36m                                                               3 columns omitted\u001b[0m"
      ]
     },
     "execution_count": 50,
     "metadata": {},
     "output_type": "execute_result"
    }
   ],
   "source": [
    "insertcols!(conf_boot, 1, :statistic => [\"boot lo\", \"boot hi\", \"parametric lo\", \"parametric hi\"])"
   ]
  },
  {
   "cell_type": "code",
   "execution_count": 51,
   "id": "3e099e47",
   "metadata": {},
   "outputs": [
    {
     "data": {
      "text/html": [
       "<div class=\"data-frame\"><p>8 rows × 5 columns</p><table class=\"data-frame\"><thead><tr><th></th><th>statistic</th><th>boot lo</th><th>boot hi</th><th>parametric lo</th><th>parametric hi</th></tr><tr><th></th><th title=\"String\">String</th><th title=\"Float64\">Float64</th><th title=\"Float64\">Float64</th><th title=\"Float64\">Float64</th><th title=\"Float64\">Float64</th></tr></thead><tbody><tr><th>1</th><td>(Intercept)</td><td>1.24129</td><td>6.79873</td><td>0.992006</td><td>6.50591</td></tr><tr><th>2</th><td>lnnlinc</td><td>-0.947283</td><td>-0.443171</td><td>-0.92549</td><td>-0.408374</td></tr><tr><th>3</th><td>age</td><td>1.29334</td><td>2.98478</td><td>1.28073</td><td>2.86989</td></tr><tr><th>4</th><td>age ^ 2</td><td>-0.405375</td><td>-0.19818</td><td>-0.392235</td><td>-0.196456</td></tr><tr><th>5</th><td>educ</td><td>-0.015854</td><td>0.0565269</td><td>-0.015937</td><td>0.0543295</td></tr><tr><th>6</th><td>nyc</td><td>-0.926779</td><td>-0.52503</td><td>-0.911238</td><td>-0.517691</td></tr><tr><th>7</th><td>noc</td><td>-0.259494</td><td>-0.0525333</td><td>-0.246718</td><td>-0.0472509</td></tr><tr><th>8</th><td>foreign: yes</td><td>0.478879</td><td>0.961622</td><td>0.476589</td><td>0.95217</td></tr></tbody></table></div>"
      ],
      "text/latex": [
       "\\begin{tabular}{r|ccccc}\n",
       "\t& statistic & boot lo & boot hi & parametric lo & parametric hi\\\\\n",
       "\t\\hline\n",
       "\t& String & Float64 & Float64 & Float64 & Float64\\\\\n",
       "\t\\hline\n",
       "\t1 & (Intercept) & 1.24129 & 6.79873 & 0.992006 & 6.50591 \\\\\n",
       "\t2 & lnnlinc & -0.947283 & -0.443171 & -0.92549 & -0.408374 \\\\\n",
       "\t3 & age & 1.29334 & 2.98478 & 1.28073 & 2.86989 \\\\\n",
       "\t4 & age \\^ 2 & -0.405375 & -0.19818 & -0.392235 & -0.196456 \\\\\n",
       "\t5 & educ & -0.015854 & 0.0565269 & -0.015937 & 0.0543295 \\\\\n",
       "\t6 & nyc & -0.926779 & -0.52503 & -0.911238 & -0.517691 \\\\\n",
       "\t7 & noc & -0.259494 & -0.0525333 & -0.246718 & -0.0472509 \\\\\n",
       "\t8 & foreign: yes & 0.478879 & 0.961622 & 0.476589 & 0.95217 \\\\\n",
       "\\end{tabular}\n"
      ],
      "text/plain": [
       "\u001b[1m8×5 DataFrame\u001b[0m\n",
       "\u001b[1m Row \u001b[0m│\u001b[1m statistic    \u001b[0m\u001b[1m boot lo   \u001b[0m\u001b[1m boot hi    \u001b[0m\u001b[1m parametric lo \u001b[0m\u001b[1m parametric hi \u001b[0m\n",
       "\u001b[1m     \u001b[0m│\u001b[90m String       \u001b[0m\u001b[90m Float64   \u001b[0m\u001b[90m Float64    \u001b[0m\u001b[90m Float64       \u001b[0m\u001b[90m Float64       \u001b[0m\n",
       "─────┼───────────────────────────────────────────────────────────────────\n",
       "   1 │ (Intercept)    1.24129    6.79873         0.992006      6.50591\n",
       "   2 │ lnnlinc       -0.947283  -0.443171       -0.92549      -0.408374\n",
       "   3 │ age            1.29334    2.98478         1.28073       2.86989\n",
       "   4 │ age ^ 2       -0.405375  -0.19818        -0.392235     -0.196456\n",
       "   5 │ educ          -0.015854   0.0565269      -0.015937      0.0543295\n",
       "   6 │ nyc           -0.926779  -0.52503        -0.911238     -0.517691\n",
       "   7 │ noc           -0.259494  -0.0525333      -0.246718     -0.0472509\n",
       "   8 │ foreign: yes   0.478879   0.961622        0.476589      0.95217"
      ]
     },
     "execution_count": 51,
     "metadata": {},
     "output_type": "execute_result"
    }
   ],
   "source": [
    "conf_boot_t = permutedims(conf_boot, :statistic)"
   ]
  },
  {
   "cell_type": "code",
   "execution_count": 52,
   "id": "36835911",
   "metadata": {},
   "outputs": [
    {
     "data": {
      "text/html": [
       "<div class=\"data-frame\"><p>8 rows × 6 columns</p><table class=\"data-frame\"><thead><tr><th></th><th>statistic</th><th>estimate</th><th>boot lo</th><th>boot hi</th><th>parametric lo</th><th>parametric hi</th></tr><tr><th></th><th title=\"String\">String</th><th title=\"Float64\">Float64</th><th title=\"Float64\">Float64</th><th title=\"Float64\">Float64</th><th title=\"Float64\">Float64</th><th title=\"Float64\">Float64</th></tr></thead><tbody><tr><th>1</th><td>(Intercept)</td><td>3.74896</td><td>1.24129</td><td>6.79873</td><td>0.992006</td><td>6.50591</td></tr><tr><th>2</th><td>lnnlinc</td><td>-0.666932</td><td>-0.947283</td><td>-0.443171</td><td>-0.92549</td><td>-0.408374</td></tr><tr><th>3</th><td>age</td><td>2.07531</td><td>1.29334</td><td>2.98478</td><td>1.28073</td><td>2.86989</td></tr><tr><th>4</th><td>age ^ 2</td><td>-0.294345</td><td>-0.405375</td><td>-0.19818</td><td>-0.392235</td><td>-0.196456</td></tr><tr><th>5</th><td>educ</td><td>0.0191963</td><td>-0.015854</td><td>0.0565269</td><td>-0.015937</td><td>0.0543295</td></tr><tr><th>6</th><td>nyc</td><td>-0.714465</td><td>-0.926779</td><td>-0.52503</td><td>-0.911238</td><td>-0.517691</td></tr><tr><th>7</th><td>noc</td><td>-0.146985</td><td>-0.259494</td><td>-0.0525333</td><td>-0.246718</td><td>-0.0472509</td></tr><tr><th>8</th><td>foreign: yes</td><td>0.71438</td><td>0.478879</td><td>0.961622</td><td>0.476589</td><td>0.95217</td></tr></tbody></table></div>"
      ],
      "text/latex": [
       "\\begin{tabular}{r|cccccc}\n",
       "\t& statistic & estimate & boot lo & boot hi & parametric lo & parametric hi\\\\\n",
       "\t\\hline\n",
       "\t& String & Float64 & Float64 & Float64 & Float64 & Float64\\\\\n",
       "\t\\hline\n",
       "\t1 & (Intercept) & 3.74896 & 1.24129 & 6.79873 & 0.992006 & 6.50591 \\\\\n",
       "\t2 & lnnlinc & -0.666932 & -0.947283 & -0.443171 & -0.92549 & -0.408374 \\\\\n",
       "\t3 & age & 2.07531 & 1.29334 & 2.98478 & 1.28073 & 2.86989 \\\\\n",
       "\t4 & age \\^ 2 & -0.294345 & -0.405375 & -0.19818 & -0.392235 & -0.196456 \\\\\n",
       "\t5 & educ & 0.0191963 & -0.015854 & 0.0565269 & -0.015937 & 0.0543295 \\\\\n",
       "\t6 & nyc & -0.714465 & -0.926779 & -0.52503 & -0.911238 & -0.517691 \\\\\n",
       "\t7 & noc & -0.146985 & -0.259494 & -0.0525333 & -0.246718 & -0.0472509 \\\\\n",
       "\t8 & foreign: yes & 0.71438 & 0.478879 & 0.961622 & 0.476589 & 0.95217 \\\\\n",
       "\\end{tabular}\n"
      ],
      "text/plain": [
       "\u001b[1m8×6 DataFrame\u001b[0m\n",
       "\u001b[1m Row \u001b[0m│\u001b[1m statistic    \u001b[0m\u001b[1m estimate   \u001b[0m\u001b[1m boot lo   \u001b[0m\u001b[1m boot hi    \u001b[0m\u001b[1m parametric lo \u001b[0m\u001b[1m paramet\u001b[0m ⋯\n",
       "\u001b[1m     \u001b[0m│\u001b[90m String       \u001b[0m\u001b[90m Float64    \u001b[0m\u001b[90m Float64   \u001b[0m\u001b[90m Float64    \u001b[0m\u001b[90m Float64       \u001b[0m\u001b[90m Float64\u001b[0m ⋯\n",
       "─────┼──────────────────────────────────────────────────────────────────────────\n",
       "   1 │ (Intercept)    3.74896     1.24129    6.79873         0.992006      6.5 ⋯\n",
       "   2 │ lnnlinc       -0.666932   -0.947283  -0.443171       -0.92549      -0.4\n",
       "   3 │ age            2.07531     1.29334    2.98478         1.28073       2.8\n",
       "   4 │ age ^ 2       -0.294345   -0.405375  -0.19818        -0.392235     -0.1\n",
       "   5 │ educ           0.0191963  -0.015854   0.0565269      -0.015937      0.0 ⋯\n",
       "   6 │ nyc           -0.714465   -0.926779  -0.52503        -0.911238     -0.5\n",
       "   7 │ noc           -0.146985   -0.259494  -0.0525333      -0.246718     -0.0\n",
       "   8 │ foreign: yes   0.71438     0.478879   0.961622        0.476589      0.9\n",
       "\u001b[36m                                                                1 column omitted\u001b[0m"
      ]
     },
     "execution_count": 52,
     "metadata": {},
     "output_type": "execute_result"
    }
   ],
   "source": [
    "insertcols!(conf_boot_t, 2, :estimate => coef(probit))"
   ]
  },
  {
   "cell_type": "code",
   "execution_count": 54,
   "id": "a5b3d07c",
   "metadata": {},
   "outputs": [
    {
     "data": {
      "text/html": [
       "<div class=\"data-frame\"><p>8 rows × 6 columns</p><table class=\"data-frame\"><thead><tr><th></th><th>statistic</th><th>estimate</th><th>boot lo</th><th>boot hi</th><th>parametric lo</th><th>parametric hi</th></tr><tr><th></th><th title=\"String\">String</th><th title=\"Float64\">Float64</th><th title=\"Float64\">Float64</th><th title=\"Float64\">Float64</th><th title=\"Float64\">Float64</th><th title=\"Float64\">Float64</th></tr></thead><tbody><tr><th>1</th><td>(Intercept)</td><td>3.74896</td><td>1.24129</td><td>0.699181</td><td>0.992006</td><td>0.992006</td></tr><tr><th>2</th><td>lnnlinc</td><td>-0.666932</td><td>0.947283</td><td>0.890693</td><td>0.92549</td><td>0.92549</td></tr><tr><th>3</th><td>age</td><td>2.07531</td><td>1.29334</td><td>1.16584</td><td>1.28073</td><td>1.28073</td></tr><tr><th>4</th><td>age ^ 2</td><td>-0.294345</td><td>0.405375</td><td>0.390511</td><td>0.392235</td><td>0.392235</td></tr><tr><th>5</th><td>educ</td><td>0.0191963</td><td>0.015854</td><td>0.0181344</td><td>0.015937</td><td>0.015937</td></tr><tr><th>6</th><td>nyc</td><td>-0.714465</td><td>0.926779</td><td>0.9039</td><td>0.911238</td><td>0.911238</td></tr><tr><th>7</th><td>noc</td><td>-0.146985</td><td>0.259494</td><td>0.241436</td><td>0.246718</td><td>0.246718</td></tr><tr><th>8</th><td>foreign: yes</td><td>0.71438</td><td>0.478879</td><td>0.467138</td><td>0.476589</td><td>0.476589</td></tr></tbody></table></div>"
      ],
      "text/latex": [
       "\\begin{tabular}{r|cccccc}\n",
       "\t& statistic & estimate & boot lo & boot hi & parametric lo & parametric hi\\\\\n",
       "\t\\hline\n",
       "\t& String & Float64 & Float64 & Float64 & Float64 & Float64\\\\\n",
       "\t\\hline\n",
       "\t1 & (Intercept) & 3.74896 & 1.24129 & 0.699181 & 0.992006 & 0.992006 \\\\\n",
       "\t2 & lnnlinc & -0.666932 & 0.947283 & 0.890693 & 0.92549 & 0.92549 \\\\\n",
       "\t3 & age & 2.07531 & 1.29334 & 1.16584 & 1.28073 & 1.28073 \\\\\n",
       "\t4 & age \\^ 2 & -0.294345 & 0.405375 & 0.390511 & 0.392235 & 0.392235 \\\\\n",
       "\t5 & educ & 0.0191963 & 0.015854 & 0.0181344 & 0.015937 & 0.015937 \\\\\n",
       "\t6 & nyc & -0.714465 & 0.926779 & 0.9039 & 0.911238 & 0.911238 \\\\\n",
       "\t7 & noc & -0.146985 & 0.259494 & 0.241436 & 0.246718 & 0.246718 \\\\\n",
       "\t8 & foreign: yes & 0.71438 & 0.478879 & 0.467138 & 0.476589 & 0.476589 \\\\\n",
       "\\end{tabular}\n"
      ],
      "text/plain": [
       "\u001b[1m8×6 DataFrame\u001b[0m\n",
       "\u001b[1m Row \u001b[0m│\u001b[1m statistic    \u001b[0m\u001b[1m estimate   \u001b[0m\u001b[1m boot lo  \u001b[0m\u001b[1m boot hi   \u001b[0m\u001b[1m parametric lo \u001b[0m\u001b[1m parametri\u001b[0m ⋯\n",
       "\u001b[1m     \u001b[0m│\u001b[90m String       \u001b[0m\u001b[90m Float64    \u001b[0m\u001b[90m Float64  \u001b[0m\u001b[90m Float64   \u001b[0m\u001b[90m Float64       \u001b[0m\u001b[90m Float64  \u001b[0m ⋯\n",
       "─────┼──────────────────────────────────────────────────────────────────────────\n",
       "   1 │ (Intercept)    3.74896    1.24129   0.699181        0.992006       0.99 ⋯\n",
       "   2 │ lnnlinc       -0.666932   0.947283  0.890693        0.92549        0.92\n",
       "   3 │ age            2.07531    1.29334   1.16584         1.28073        1.28\n",
       "   4 │ age ^ 2       -0.294345   0.405375  0.390511        0.392235       0.39\n",
       "   5 │ educ           0.0191963  0.015854  0.0181344       0.015937       0.01 ⋯\n",
       "   6 │ nyc           -0.714465   0.926779  0.9039          0.911238       0.91\n",
       "   7 │ noc           -0.146985   0.259494  0.241436        0.246718       0.24\n",
       "   8 │ foreign: yes   0.71438    0.478879  0.467138        0.476589       0.47\n",
       "\u001b[36m                                                                1 column omitted\u001b[0m"
      ]
     },
     "execution_count": 54,
     "metadata": {},
     "output_type": "execute_result"
    }
   ],
   "source": [
    "select!(conf_boot_t, :statistic, :estimate, 3:6 .=> x -> abs.(x .- conf_boot_t.estimate), renamecols=false)"
   ]
  },
  {
   "cell_type": "code",
   "execution_count": 55,
   "id": "76753ee6",
   "metadata": {},
   "outputs": [
    {
     "data": {
      "image/svg+xml": [
       "<?xml version=\"1.0\" encoding=\"utf-8\"?>\n",
       "<svg xmlns=\"http://www.w3.org/2000/svg\" xmlns:xlink=\"http://www.w3.org/1999/xlink\" width=\"600\" height=\"400\" viewBox=\"0 0 2400 1600\">\n",
       "<defs>\n",
       "  <clipPath id=\"clip120\">\n",
       "    <rect x=\"0\" y=\"0\" width=\"2400\" height=\"1600\"/>\n",
       "  </clipPath>\n",
       "</defs>\n",
       "<path clip-path=\"url(#clip120)\" d=\"\n",
       "M0 1600 L2400 1600 L2400 0 L0 0  Z\n",
       "  \" fill=\"#ffffff\" fill-rule=\"evenodd\" fill-opacity=\"1\"/>\n",
       "<defs>\n",
       "  <clipPath id=\"clip121\">\n",
       "    <rect x=\"480\" y=\"0\" width=\"1681\" height=\"1600\"/>\n",
       "  </clipPath>\n",
       "</defs>\n",
       "<path clip-path=\"url(#clip120)\" d=\"\n",
       "M147.478 1366.38 L2352.76 1366.38 L2352.76 47.2441 L147.478 47.2441  Z\n",
       "  \" fill=\"#ffffff\" fill-rule=\"evenodd\" fill-opacity=\"1\"/>\n",
       "<defs>\n",
       "  <clipPath id=\"clip122\">\n",
       "    <rect x=\"147\" y=\"47\" width=\"2206\" height=\"1320\"/>\n",
       "  </clipPath>\n",
       "</defs>\n",
       "<polyline clip-path=\"url(#clip122)\" style=\"stroke:#000000; stroke-linecap:butt; stroke-linejoin:round; stroke-width:2; stroke-opacity:0.1; fill:none\" points=\"\n",
       "  224.543,1366.38 224.543,47.2441 \n",
       "  \"/>\n",
       "<polyline clip-path=\"url(#clip122)\" style=\"stroke:#000000; stroke-linecap:butt; stroke-linejoin:round; stroke-width:2; stroke-opacity:0.1; fill:none\" points=\"\n",
       "  517.564,1366.38 517.564,47.2441 \n",
       "  \"/>\n",
       "<polyline clip-path=\"url(#clip122)\" style=\"stroke:#000000; stroke-linecap:butt; stroke-linejoin:round; stroke-width:2; stroke-opacity:0.1; fill:none\" points=\"\n",
       "  810.585,1366.38 810.585,47.2441 \n",
       "  \"/>\n",
       "<polyline clip-path=\"url(#clip122)\" style=\"stroke:#000000; stroke-linecap:butt; stroke-linejoin:round; stroke-width:2; stroke-opacity:0.1; fill:none\" points=\"\n",
       "  1103.61,1366.38 1103.61,47.2441 \n",
       "  \"/>\n",
       "<polyline clip-path=\"url(#clip122)\" style=\"stroke:#000000; stroke-linecap:butt; stroke-linejoin:round; stroke-width:2; stroke-opacity:0.1; fill:none\" points=\"\n",
       "  1396.63,1366.38 1396.63,47.2441 \n",
       "  \"/>\n",
       "<polyline clip-path=\"url(#clip122)\" style=\"stroke:#000000; stroke-linecap:butt; stroke-linejoin:round; stroke-width:2; stroke-opacity:0.1; fill:none\" points=\"\n",
       "  1689.65,1366.38 1689.65,47.2441 \n",
       "  \"/>\n",
       "<polyline clip-path=\"url(#clip122)\" style=\"stroke:#000000; stroke-linecap:butt; stroke-linejoin:round; stroke-width:2; stroke-opacity:0.1; fill:none\" points=\"\n",
       "  1982.67,1366.38 1982.67,47.2441 \n",
       "  \"/>\n",
       "<polyline clip-path=\"url(#clip122)\" style=\"stroke:#000000; stroke-linecap:butt; stroke-linejoin:round; stroke-width:2; stroke-opacity:0.1; fill:none\" points=\"\n",
       "  2275.69,1366.38 2275.69,47.2441 \n",
       "  \"/>\n",
       "<polyline clip-path=\"url(#clip120)\" style=\"stroke:#000000; stroke-linecap:butt; stroke-linejoin:round; stroke-width:4; stroke-opacity:1; fill:none\" points=\"\n",
       "  147.478,1366.38 2352.76,1366.38 \n",
       "  \"/>\n",
       "<polyline clip-path=\"url(#clip120)\" style=\"stroke:#000000; stroke-linecap:butt; stroke-linejoin:round; stroke-width:4; stroke-opacity:1; fill:none\" points=\"\n",
       "  224.543,1366.38 224.543,1347.48 \n",
       "  \"/>\n",
       "<polyline clip-path=\"url(#clip120)\" style=\"stroke:#000000; stroke-linecap:butt; stroke-linejoin:round; stroke-width:4; stroke-opacity:1; fill:none\" points=\"\n",
       "  517.564,1366.38 517.564,1347.48 \n",
       "  \"/>\n",
       "<polyline clip-path=\"url(#clip120)\" style=\"stroke:#000000; stroke-linecap:butt; stroke-linejoin:round; stroke-width:4; stroke-opacity:1; fill:none\" points=\"\n",
       "  810.585,1366.38 810.585,1347.48 \n",
       "  \"/>\n",
       "<polyline clip-path=\"url(#clip120)\" style=\"stroke:#000000; stroke-linecap:butt; stroke-linejoin:round; stroke-width:4; stroke-opacity:1; fill:none\" points=\"\n",
       "  1103.61,1366.38 1103.61,1347.48 \n",
       "  \"/>\n",
       "<polyline clip-path=\"url(#clip120)\" style=\"stroke:#000000; stroke-linecap:butt; stroke-linejoin:round; stroke-width:4; stroke-opacity:1; fill:none\" points=\"\n",
       "  1396.63,1366.38 1396.63,1347.48 \n",
       "  \"/>\n",
       "<polyline clip-path=\"url(#clip120)\" style=\"stroke:#000000; stroke-linecap:butt; stroke-linejoin:round; stroke-width:4; stroke-opacity:1; fill:none\" points=\"\n",
       "  1689.65,1366.38 1689.65,1347.48 \n",
       "  \"/>\n",
       "<polyline clip-path=\"url(#clip120)\" style=\"stroke:#000000; stroke-linecap:butt; stroke-linejoin:round; stroke-width:4; stroke-opacity:1; fill:none\" points=\"\n",
       "  1982.67,1366.38 1982.67,1347.48 \n",
       "  \"/>\n",
       "<polyline clip-path=\"url(#clip120)\" style=\"stroke:#000000; stroke-linecap:butt; stroke-linejoin:round; stroke-width:4; stroke-opacity:1; fill:none\" points=\"\n",
       "  2275.69,1366.38 2275.69,1347.48 \n",
       "  \"/>\n",
       "<path clip-path=\"url(#clip120)\" d=\"M47.022 1554.99 Q48.5933 1560.95 51.2122 1565.7 Q53.8311 1570.44 57.6122 1574.22 Q61.3932 1578.01 66.1727 1580.66 Q70.9522 1583.28 76.8775 1584.85 L74.2586 1587.47 Q67.9568 1586.08 63.0137 1583.59 Q58.0869 1581.08 54.4204 1577.42 Q50.7703 1573.77 48.2824 1568.86 Q45.7944 1563.95 44.4031 1557.61 L47.022 1554.99 Z\" fill=\"#000000\" fill-rule=\"evenodd\" fill-opacity=\"1\" /><path clip-path=\"url(#clip120)\" d=\"M53.9948 1550.02 L57.3012 1546.71 L81.7388 1571.15 L78.4324 1574.45 L53.9948 1550.02 Z\" fill=\"#000000\" fill-rule=\"evenodd\" fill-opacity=\"1\" /><path clip-path=\"url(#clip120)\" d=\"M92.3617 1538.4 L103.427 1549.46 L100.415 1552.47 L89.4482 1541.51 Q86.8457 1538.9 84.5377 1538.62 Q82.2298 1538.35 80.2002 1540.38 Q77.7613 1542.81 77.9087 1545.78 Q78.056 1548.74 80.7403 1551.42 L91.1014 1561.79 L88.0733 1564.81 L69.741 1546.48 L72.7691 1543.45 L75.6171 1546.3 Q75.0442 1543.57 75.6826 1541.29 Q76.3373 1539 78.2524 1537.09 Q81.4114 1533.93 84.9961 1534.27 Q88.5643 1534.6 92.3617 1538.4 Z\" fill=\"#000000\" fill-rule=\"evenodd\" fill-opacity=\"1\" /><path clip-path=\"url(#clip120)\" d=\"M88.8753 1516.94 L94.0804 1522.14 L100.284 1515.94 L102.625 1518.28 L96.421 1524.48 L106.373 1534.43 Q108.615 1536.68 109.859 1536.71 Q111.12 1536.73 113.002 1534.84 L116.095 1531.75 L118.616 1534.27 L115.523 1537.36 Q112.036 1540.85 109.417 1540.88 Q106.782 1540.9 103.345 1537.46 L93.3929 1527.51 L91.1832 1529.72 L88.8426 1527.38 L91.0523 1525.17 L85.8472 1519.96 L88.8753 1516.94 Z\" fill=\"#000000\" fill-rule=\"evenodd\" fill-opacity=\"1\" /><path clip-path=\"url(#clip120)\" d=\"M128.339 1504.71 L129.812 1506.18 L115.965 1520.03 Q119.271 1522.94 122.577 1522.91 Q125.884 1522.85 128.879 1519.85 Q130.614 1518.11 131.809 1516.07 Q133.02 1514.01 133.773 1511.55 L136.621 1514.4 Q135.688 1516.71 134.346 1518.77 Q133.004 1520.83 131.252 1522.58 Q126.866 1526.97 121.742 1526.99 Q116.636 1526.99 112.282 1522.63 Q107.78 1518.13 107.568 1513.07 Q107.355 1507.98 111.48 1503.86 Q115.179 1500.16 119.713 1500.4 Q124.247 1500.62 128.339 1504.71 M124.443 1506.84 Q121.939 1504.4 119.107 1504.28 Q116.292 1504.15 114.066 1506.38 Q111.545 1508.9 111.447 1511.85 Q111.365 1514.78 113.722 1517.59 L124.443 1506.84 Z\" fill=\"#000000\" fill-rule=\"evenodd\" fill-opacity=\"1\" /><path clip-path=\"url(#clip120)\" d=\"M138.307 1483.55 Q137.505 1483.76 136.768 1484.23 Q136.032 1484.67 135.312 1485.4 Q132.758 1487.95 133.053 1490.99 Q133.347 1494 136.457 1497.11 L146.115 1506.77 L143.087 1509.8 L124.754 1491.47 L127.782 1488.44 L130.63 1491.29 Q129.91 1488.67 130.63 1486.34 Q131.334 1484 133.511 1481.83 Q133.822 1481.52 134.248 1481.19 Q134.657 1480.84 135.197 1480.47 L138.307 1483.55 Z\" fill=\"#000000\" fill-rule=\"evenodd\" fill-opacity=\"1\" /><path clip-path=\"url(#clip120)\" d=\"M151.811 1465.82 L154.626 1468.63 Q152.646 1469.21 151.009 1470.16 Q149.372 1471.07 148.062 1472.38 Q145.133 1475.31 145.378 1478.8 Q145.607 1482.27 148.963 1485.62 Q152.318 1488.98 155.805 1489.23 Q159.275 1489.45 162.205 1486.52 Q163.514 1485.22 164.447 1483.59 Q165.38 1481.94 165.953 1479.96 L168.735 1482.74 Q168.064 1484.59 167 1486.25 Q165.953 1487.88 164.431 1489.41 Q160.289 1493.55 155.248 1493.38 Q150.207 1493.22 145.787 1488.8 Q141.302 1484.31 141.188 1479.29 Q141.09 1474.25 145.378 1469.96 Q146.769 1468.57 148.39 1467.54 Q149.994 1466.49 151.811 1465.82 Z\" fill=\"#000000\" fill-rule=\"evenodd\" fill-opacity=\"1\" /><path clip-path=\"url(#clip120)\" d=\"M180.439 1452.61 L181.912 1454.08 L168.064 1467.93 Q171.371 1470.84 174.677 1470.81 Q177.983 1470.75 180.979 1467.75 Q182.714 1466.02 183.909 1463.97 Q185.12 1461.91 185.873 1459.45 L188.721 1462.3 Q187.788 1464.61 186.446 1466.67 Q185.104 1468.73 183.352 1470.48 Q178.965 1474.87 173.842 1474.89 Q168.735 1474.89 164.381 1470.53 Q159.88 1466.03 159.667 1460.97 Q159.455 1455.88 163.579 1451.76 Q167.279 1448.06 171.813 1448.3 Q176.347 1448.52 180.439 1452.61 M176.543 1454.74 Q174.039 1452.3 171.207 1452.18 Q168.392 1452.05 166.166 1454.28 Q163.645 1456.8 163.547 1459.75 Q163.465 1462.68 165.822 1465.49 L176.543 1454.74 Z\" fill=\"#000000\" fill-rule=\"evenodd\" fill-opacity=\"1\" /><path clip-path=\"url(#clip120)\" d=\"M195.465 1451.92 L205.187 1461.64 L202.159 1464.67 L176.854 1439.37 L179.882 1436.34 L182.665 1439.12 Q181.977 1436.54 182.632 1434.31 Q183.287 1432.05 185.3 1430.04 Q188.639 1426.7 193.369 1427.27 Q198.116 1427.83 202.437 1432.15 Q206.759 1436.47 207.315 1441.22 Q207.888 1445.95 204.549 1449.29 Q202.536 1451.3 200.293 1451.97 Q198.051 1452.61 195.465 1451.92 M199.311 1435.28 Q195.988 1431.95 192.731 1431.45 Q189.474 1430.91 187.084 1433.3 Q184.694 1435.69 185.218 1438.96 Q185.742 1442.2 189.065 1445.52 Q192.387 1448.85 195.645 1449.39 Q198.902 1449.89 201.292 1447.5 Q203.681 1445.11 203.158 1441.87 Q202.634 1438.6 199.311 1435.28 Z\" fill=\"#000000\" fill-rule=\"evenodd\" fill-opacity=\"1\" /><path clip-path=\"url(#clip120)\" d=\"M196.021 1409.79 L201.226 1415 L207.43 1408.79 L209.77 1411.13 L203.567 1417.34 L213.519 1427.29 Q215.761 1429.53 217.005 1429.56 Q218.265 1429.58 220.148 1427.7 L223.241 1424.6 L225.762 1427.12 L222.668 1430.22 Q219.182 1433.7 216.563 1433.74 Q213.928 1433.75 210.49 1430.32 L200.539 1420.36 L198.329 1422.57 L195.988 1420.23 L198.198 1418.02 L192.993 1412.82 L196.021 1409.79 Z\" fill=\"#000000\" fill-rule=\"evenodd\" fill-opacity=\"1\" /><path clip-path=\"url(#clip120)\" d=\"M203.812 1398.2 L206.431 1395.58 Q212.749 1396.99 217.66 1399.48 Q222.587 1401.95 226.237 1405.6 Q229.903 1409.27 232.391 1414.21 Q234.895 1419.14 236.287 1425.44 L233.668 1428.06 Q232.096 1422.13 229.461 1417.37 Q226.826 1412.57 223.045 1408.79 Q219.264 1405.01 214.501 1402.41 Q209.754 1399.79 203.812 1398.2 Z\" fill=\"#000000\" fill-rule=\"evenodd\" fill-opacity=\"1\" /><path clip-path=\"url(#clip120)\" d=\"M399.443 1495.53 L402.455 1492.52 L427.924 1517.98 L424.912 1521 L399.443 1495.53 Z\" fill=\"#000000\" fill-rule=\"evenodd\" fill-opacity=\"1\" /><path clip-path=\"url(#clip120)\" d=\"M438.399 1485.38 L449.464 1496.44 L446.452 1499.46 L435.486 1488.49 Q432.883 1485.89 430.575 1485.61 Q428.267 1485.33 426.238 1487.36 Q423.799 1489.8 423.946 1492.76 Q424.094 1495.72 426.778 1498.41 L437.139 1508.77 L434.111 1511.8 L415.779 1493.46 L418.807 1490.44 L421.655 1493.28 Q421.082 1490.55 421.72 1488.28 Q422.375 1485.98 424.29 1484.07 Q427.449 1480.91 431.034 1481.25 Q434.602 1481.58 438.399 1485.38 Z\" fill=\"#000000\" fill-rule=\"evenodd\" fill-opacity=\"1\" /><path clip-path=\"url(#clip120)\" d=\"M459.645 1464.13 L470.71 1475.2 L467.698 1478.21 L456.732 1467.24 Q454.129 1464.64 451.821 1464.36 Q449.513 1464.08 447.484 1466.11 Q445.045 1468.55 445.192 1471.51 Q445.339 1474.48 448.024 1477.16 L458.385 1487.52 L455.357 1490.55 L437.024 1472.22 L440.053 1469.19 L442.901 1472.04 Q442.328 1469.31 442.966 1467.03 Q443.621 1464.74 445.536 1462.82 Q448.695 1459.66 452.279 1460.01 Q455.848 1460.34 459.645 1464.13 Z\" fill=\"#000000\" fill-rule=\"evenodd\" fill-opacity=\"1\" /><path clip-path=\"url(#clip120)\" d=\"M451.248 1443.72 L454.26 1440.71 L479.729 1466.18 L476.717 1469.19 L451.248 1443.72 Z\" fill=\"#000000\" fill-rule=\"evenodd\" fill-opacity=\"1\" /><path clip-path=\"url(#clip120)\" d=\"M467.698 1441.54 L470.71 1438.53 L489.042 1456.87 L486.031 1459.88 L467.698 1441.54 M460.562 1434.41 L463.574 1431.4 L467.387 1435.21 L464.376 1438.22 L460.562 1434.41 Z\" fill=\"#000000\" fill-rule=\"evenodd\" fill-opacity=\"1\" /><path clip-path=\"url(#clip120)\" d=\"M499.518 1424.26 L510.583 1435.33 L507.571 1438.34 L496.604 1427.37 Q494.002 1424.77 491.694 1424.49 Q489.386 1424.21 487.356 1426.24 Q484.918 1428.68 485.065 1431.64 Q485.212 1434.6 487.897 1437.29 L498.258 1447.65 L495.229 1450.68 L476.897 1432.35 L479.925 1429.32 L482.773 1432.17 Q482.2 1429.43 482.839 1427.16 Q483.494 1424.87 485.409 1422.95 Q488.568 1419.79 492.152 1420.14 Q495.721 1420.46 499.518 1424.26 Z\" fill=\"#000000\" fill-rule=\"evenodd\" fill-opacity=\"1\" /><path clip-path=\"url(#clip120)\" d=\"M512.154 1398.5 L514.969 1401.31 Q512.989 1401.88 511.352 1402.83 Q509.715 1403.75 508.406 1405.06 Q505.476 1407.99 505.721 1411.48 Q505.951 1414.95 509.306 1418.3 Q512.662 1421.66 516.148 1421.9 Q519.618 1422.13 522.548 1419.2 Q523.857 1417.89 524.79 1416.27 Q525.723 1414.62 526.296 1412.64 L529.079 1415.42 Q528.408 1417.27 527.344 1418.92 Q526.296 1420.56 524.774 1422.08 Q520.633 1426.22 515.591 1426.06 Q510.55 1425.9 506.131 1421.48 Q501.646 1416.99 501.531 1411.97 Q501.433 1406.93 505.721 1402.64 Q507.113 1401.25 508.733 1400.22 Q510.337 1399.17 512.154 1398.5 Z\" fill=\"#000000\" fill-rule=\"evenodd\" fill-opacity=\"1\" /><path clip-path=\"url(#clip120)\" d=\"M764.419 1456.08 Q760.769 1459.73 760.196 1461.97 Q759.623 1464.21 761.636 1466.23 Q763.24 1467.83 765.237 1467.73 Q767.234 1467.6 769.051 1465.79 Q771.555 1463.28 771.293 1460.01 Q771.031 1456.7 768.085 1453.76 L767.414 1453.08 L764.419 1456.08 M769.182 1448.83 L779.641 1459.29 L776.629 1462.3 L773.847 1459.52 Q774.485 1462.22 773.749 1464.56 Q772.996 1466.88 770.77 1469.11 Q767.954 1471.92 764.713 1472.02 Q761.472 1472.09 758.821 1469.44 Q755.727 1466.34 756.218 1462.71 Q756.726 1459.06 760.834 1454.95 L765.057 1450.73 L764.762 1450.43 Q762.684 1448.35 760.179 1448.6 Q757.675 1448.81 755.203 1451.28 Q753.632 1452.86 752.519 1454.72 Q751.406 1456.59 750.784 1458.72 L748.001 1455.93 Q749.016 1453.64 750.26 1451.77 Q751.488 1449.89 752.961 1448.42 Q756.938 1444.44 760.965 1444.54 Q764.992 1444.64 769.182 1448.83 Z\" fill=\"#000000\" fill-rule=\"evenodd\" fill-opacity=\"1\" /><path clip-path=\"url(#clip120)\" d=\"M788.529 1431.64 Q785.255 1428.37 782.096 1427.93 Q778.954 1427.47 776.515 1429.91 Q774.092 1432.33 774.534 1435.49 Q774.993 1438.63 778.266 1441.91 Q781.523 1445.16 784.666 1445.62 Q787.825 1446.06 790.248 1443.64 Q792.686 1441.2 792.228 1438.06 Q791.786 1434.9 788.529 1431.64 M798.644 1435.73 Q803.326 1440.42 803.522 1444.77 Q803.735 1449.14 799.447 1453.43 Q797.859 1455.02 796.206 1456.18 Q794.569 1457.36 792.752 1458.19 L789.822 1455.26 Q791.868 1454.66 793.505 1453.71 Q795.142 1452.76 796.484 1451.41 Q799.447 1448.45 799.365 1445.42 Q799.299 1442.41 796.173 1439.29 L794.683 1437.8 Q795.371 1440.35 794.716 1442.61 Q794.061 1444.87 792.032 1446.9 Q788.66 1450.27 784.028 1449.76 Q779.396 1449.25 775.156 1445.01 Q770.901 1440.76 770.393 1436.13 Q769.886 1431.49 773.258 1428.12 Q775.287 1426.09 777.546 1425.44 Q779.805 1424.78 782.358 1425.47 L779.576 1422.69 L782.587 1419.68 L798.644 1435.73 Z\" fill=\"#000000\" fill-rule=\"evenodd\" fill-opacity=\"1\" /><path clip-path=\"url(#clip120)\" d=\"M812.885 1406.21 L814.358 1407.68 L800.51 1421.53 Q803.817 1424.44 807.123 1424.41 Q810.43 1424.34 813.425 1421.35 Q815.16 1419.61 816.355 1417.57 Q817.566 1415.5 818.319 1413.05 L821.167 1415.9 Q820.234 1418.2 818.892 1420.27 Q817.55 1422.33 815.798 1424.08 Q811.412 1428.47 806.288 1428.48 Q801.182 1428.48 796.828 1424.13 Q792.326 1419.63 792.114 1414.57 Q791.901 1409.48 796.026 1405.35 Q799.725 1401.66 804.259 1401.9 Q808.793 1402.11 812.885 1406.21 M808.989 1408.33 Q806.485 1405.9 803.653 1405.78 Q800.838 1405.65 798.612 1407.88 Q796.091 1410.4 795.993 1413.34 Q795.911 1416.27 798.268 1419.09 L808.989 1408.33 Z\" fill=\"#000000\" fill-rule=\"evenodd\" fill-opacity=\"1\" /><path clip-path=\"url(#clip120)\" d=\"M988.285 1525.24 Q984.635 1528.89 984.062 1531.13 Q983.489 1533.37 985.502 1535.38 Q987.106 1536.99 989.103 1536.89 Q991.1 1536.76 992.917 1534.94 Q995.421 1532.44 995.159 1529.16 Q994.897 1525.86 991.951 1522.91 L991.28 1522.24 L988.285 1525.24 M993.048 1517.98 L1003.51 1528.44 L1000.5 1531.46 L997.713 1528.67 Q998.351 1531.37 997.614 1533.71 Q996.862 1536.04 994.635 1538.26 Q991.82 1541.08 988.579 1541.18 Q985.338 1541.24 982.687 1538.59 Q979.593 1535.5 980.084 1531.86 Q980.592 1528.21 984.7 1524.11 L988.923 1519.88 L988.628 1519.59 Q986.55 1517.51 984.045 1517.75 Q981.541 1517.97 979.069 1520.44 Q977.498 1522.01 976.385 1523.88 Q975.272 1525.74 974.65 1527.87 L971.867 1525.09 Q972.882 1522.8 974.126 1520.93 Q975.354 1519.05 976.827 1517.57 Q980.804 1513.6 984.831 1513.7 Q988.858 1513.79 993.048 1517.98 Z\" fill=\"#000000\" fill-rule=\"evenodd\" fill-opacity=\"1\" /><path clip-path=\"url(#clip120)\" d=\"M1012.39 1500.8 Q1009.12 1497.52 1005.96 1497.08 Q1002.82 1496.62 1000.38 1499.06 Q997.958 1501.48 998.4 1504.64 Q998.858 1507.79 1002.13 1511.06 Q1005.39 1514.32 1008.53 1514.78 Q1011.69 1515.22 1014.11 1512.8 Q1016.55 1510.36 1016.09 1507.21 Q1015.65 1504.05 1012.39 1500.8 M1022.51 1504.89 Q1027.19 1509.57 1027.39 1513.92 Q1027.6 1518.3 1023.31 1522.58 Q1021.72 1524.17 1020.07 1525.33 Q1018.43 1526.51 1016.62 1527.35 L1013.69 1524.42 Q1015.73 1523.81 1017.37 1522.86 Q1019.01 1521.91 1020.35 1520.57 Q1023.31 1517.61 1023.23 1514.58 Q1023.17 1511.57 1020.04 1508.44 L1018.55 1506.95 Q1019.24 1509.51 1018.58 1511.76 Q1017.93 1514.02 1015.9 1516.05 Q1012.53 1519.42 1007.89 1518.92 Q1003.26 1518.41 999.022 1514.17 Q994.766 1509.91 994.259 1505.28 Q993.752 1500.65 997.123 1497.28 Q999.153 1495.25 1001.41 1494.59 Q1003.67 1493.94 1006.22 1494.63 L1003.44 1491.84 L1006.45 1488.83 L1022.51 1504.89 Z\" fill=\"#000000\" fill-rule=\"evenodd\" fill-opacity=\"1\" /><path clip-path=\"url(#clip120)\" d=\"M1036.75 1475.36 L1038.22 1476.83 L1024.38 1490.68 Q1027.68 1493.6 1030.99 1493.56 Q1034.3 1493.5 1037.29 1490.5 Q1039.03 1488.77 1040.22 1486.72 Q1041.43 1484.66 1042.18 1482.2 L1045.03 1485.05 Q1044.1 1487.36 1042.76 1489.42 Q1041.42 1491.48 1039.66 1493.24 Q1035.28 1497.62 1030.15 1497.64 Q1025.05 1497.64 1020.69 1493.28 Q1016.19 1488.78 1015.98 1483.73 Q1015.77 1478.64 1019.89 1474.51 Q1023.59 1470.81 1028.12 1471.06 Q1032.66 1471.27 1036.75 1475.36 M1032.86 1477.49 Q1030.35 1475.05 1027.52 1474.94 Q1024.7 1474.8 1022.48 1477.03 Q1019.96 1479.55 1019.86 1482.5 Q1019.78 1485.43 1022.13 1488.24 L1032.86 1477.49 Z\" fill=\"#000000\" fill-rule=\"evenodd\" fill-opacity=\"1\" /><path clip-path=\"url(#clip120)\" d=\"M1050.32 1432.76 L1068.32 1432.98 L1065.03 1436.27 L1051.37 1437.01 L1050.63 1450.68 L1047.34 1453.97 L1047.11 1435.96 L1050.32 1432.76 Z\" fill=\"#000000\" fill-rule=\"evenodd\" fill-opacity=\"1\" /><path clip-path=\"url(#clip120)\" d=\"M1101.5 1424.88 L1113.04 1413.34 L1115.83 1416.13 L1100.31 1431.64 L1097.53 1428.86 Q1097.46 1425.03 1097.43 1418.51 Q1097.39 1411.97 1097.28 1410.18 Q1097.08 1406.81 1096.48 1404.96 Q1095.87 1403.08 1094.68 1401.88 Q1092.73 1399.94 1090.13 1400.08 Q1087.54 1400.22 1085.35 1402.41 Q1083.79 1403.96 1082.6 1406.24 Q1081.42 1408.5 1080.55 1411.56 L1077.21 1408.22 Q1078.41 1405.42 1079.73 1403.28 Q1081.06 1401.13 1082.5 1399.69 Q1086.3 1395.89 1090.45 1395.53 Q1094.61 1395.17 1097.79 1398.35 Q1099.29 1399.86 1100.08 1401.79 Q1100.86 1403.69 1101.21 1407.01 Q1101.27 1407.89 1101.36 1412.36 Q1101.42 1416.81 1101.5 1424.88 Z\" fill=\"#000000\" fill-rule=\"evenodd\" fill-opacity=\"1\" /><path clip-path=\"url(#clip120)\" d=\"M1338.27 1466.87 L1339.74 1468.34 L1325.89 1482.19 Q1329.2 1485.1 1332.51 1485.07 Q1335.81 1485 1338.81 1482.01 Q1340.54 1480.27 1341.74 1478.23 Q1342.95 1476.16 1343.7 1473.71 L1346.55 1476.56 Q1345.62 1478.86 1344.27 1480.93 Q1342.93 1482.99 1341.18 1484.74 Q1336.79 1489.13 1331.67 1489.14 Q1326.56 1489.14 1322.21 1484.79 Q1317.71 1480.29 1317.5 1475.23 Q1317.28 1470.14 1321.41 1466.02 Q1325.11 1462.32 1329.64 1462.56 Q1334.17 1462.77 1338.27 1466.87 M1334.37 1468.99 Q1331.87 1466.56 1329.04 1466.44 Q1326.22 1466.31 1323.99 1468.54 Q1321.47 1471.06 1321.38 1474 Q1321.29 1476.93 1323.65 1479.75 L1334.37 1468.99 Z\" fill=\"#000000\" fill-rule=\"evenodd\" fill-opacity=\"1\" /><path clip-path=\"url(#clip120)\" d=\"M1349.64 1444.23 L1339.72 1434.31 L1342.74 1431.3 L1368.2 1456.77 L1365.19 1459.78 L1362.44 1457.03 Q1363.13 1459.62 1362.48 1461.87 Q1361.82 1464.1 1359.79 1466.13 Q1356.47 1469.45 1351.72 1468.9 Q1346.99 1468.32 1342.67 1464 Q1338.35 1459.68 1337.78 1454.95 Q1337.22 1450.2 1340.54 1446.88 Q1342.57 1444.85 1344.81 1444.21 Q1347.06 1443.54 1349.64 1444.23 M1345.78 1460.89 Q1349.1 1464.21 1352.36 1464.75 Q1355.62 1465.26 1358.01 1462.87 Q1360.4 1460.48 1359.89 1457.23 Q1359.37 1453.95 1356.04 1450.63 Q1352.72 1447.31 1349.46 1446.8 Q1346.19 1446.28 1343.8 1448.67 Q1341.41 1451.05 1341.93 1454.33 Q1342.46 1457.57 1345.78 1460.89 Z\" fill=\"#000000\" fill-rule=\"evenodd\" fill-opacity=\"1\" /><path clip-path=\"url(#clip120)\" d=\"M1366.86 1443.64 L1355.76 1432.54 L1358.78 1429.53 L1369.76 1440.51 Q1372.36 1443.12 1374.69 1443.41 Q1376.99 1443.69 1379.02 1441.66 Q1381.46 1439.22 1381.32 1436.26 Q1381.18 1433.28 1378.5 1430.59 L1368.11 1420.2 L1371.12 1417.19 L1389.45 1435.52 L1386.44 1438.53 L1383.62 1435.72 Q1384.2 1438.48 1383.56 1440.76 Q1382.92 1443 1381 1444.92 Q1377.85 1448.08 1374.24 1447.75 Q1370.64 1447.42 1366.86 1443.64 M1362.9 1424.52 L1362.9 1424.52 Z\" fill=\"#000000\" fill-rule=\"evenodd\" fill-opacity=\"1\" /><path clip-path=\"url(#clip120)\" d=\"M1391.22 1398.5 L1394.03 1401.31 Q1392.05 1401.88 1390.42 1402.83 Q1388.78 1403.75 1387.47 1405.06 Q1384.54 1407.99 1384.79 1411.48 Q1385.01 1414.95 1388.37 1418.3 Q1391.73 1421.66 1395.21 1421.9 Q1398.68 1422.13 1401.61 1419.2 Q1402.92 1417.89 1403.85 1416.27 Q1404.79 1414.62 1405.36 1412.64 L1408.14 1415.42 Q1407.47 1417.27 1406.41 1418.92 Q1405.36 1420.56 1403.84 1422.08 Q1399.7 1426.22 1394.66 1426.06 Q1389.61 1425.9 1385.19 1421.48 Q1380.71 1416.99 1380.59 1411.97 Q1380.5 1406.93 1384.79 1402.64 Q1386.18 1401.25 1387.8 1400.22 Q1389.4 1399.17 1391.22 1398.5 Z\" fill=\"#000000\" fill-rule=\"evenodd\" fill-opacity=\"1\" /><path clip-path=\"url(#clip120)\" d=\"M1651.76 1444.1 L1662.83 1455.16 L1659.82 1458.17 L1648.85 1447.21 Q1646.25 1444.61 1643.94 1444.33 Q1641.63 1444.05 1639.6 1446.08 Q1637.16 1448.52 1637.31 1451.48 Q1637.46 1454.44 1640.14 1457.13 L1650.5 1467.49 L1647.48 1470.52 L1629.14 1452.18 L1632.17 1449.16 L1635.02 1452 Q1634.45 1449.27 1635.09 1447 Q1635.74 1444.7 1637.66 1442.79 Q1640.81 1439.63 1644.4 1439.97 Q1647.97 1440.3 1651.76 1444.1 Z\" fill=\"#000000\" fill-rule=\"evenodd\" fill-opacity=\"1\" /><path clip-path=\"url(#clip120)\" d=\"M1678.17 1443.23 Q1680.16 1447.78 1679.95 1449.99 Q1679.74 1452.2 1677.71 1454.23 L1675.3 1456.64 L1672.78 1454.12 L1674.55 1452.35 Q1675.79 1451.1 1675.89 1449.83 Q1675.99 1448.55 1674.63 1445.52 L1673.8 1443.61 L1648.34 1432.98 L1651.54 1429.79 L1671.6 1438.4 L1662.99 1418.33 L1666.19 1415.14 L1678.17 1443.23 Z\" fill=\"#000000\" fill-rule=\"evenodd\" fill-opacity=\"1\" /><path clip-path=\"url(#clip120)\" d=\"M1684.24 1398.5 L1687.05 1401.31 Q1685.07 1401.88 1683.44 1402.83 Q1681.8 1403.75 1680.49 1405.06 Q1677.56 1407.99 1677.81 1411.48 Q1678.04 1414.95 1681.39 1418.3 Q1684.75 1421.66 1688.23 1421.9 Q1691.7 1422.13 1694.63 1419.2 Q1695.94 1417.89 1696.88 1416.27 Q1697.81 1414.62 1698.38 1412.64 L1701.16 1415.42 Q1700.49 1417.27 1699.43 1418.92 Q1698.38 1420.56 1696.86 1422.08 Q1692.72 1426.22 1687.68 1426.06 Q1682.64 1425.9 1678.22 1421.48 Q1673.73 1416.99 1673.62 1411.97 Q1673.52 1406.93 1677.81 1402.64 Q1679.2 1401.25 1680.82 1400.22 Q1682.42 1399.17 1684.24 1398.5 Z\" fill=\"#000000\" fill-rule=\"evenodd\" fill-opacity=\"1\" /><path clip-path=\"url(#clip120)\" d=\"M1944.11 1444.77 L1955.18 1455.83 L1952.17 1458.85 L1941.2 1447.88 Q1938.6 1445.28 1936.29 1445 Q1933.98 1444.72 1931.95 1446.75 Q1929.51 1449.19 1929.66 1452.15 Q1929.81 1455.11 1932.49 1457.8 L1942.85 1468.16 L1939.83 1471.19 L1921.49 1452.86 L1924.52 1449.83 L1927.37 1452.68 Q1926.8 1449.94 1927.44 1447.67 Q1928.09 1445.38 1930.01 1443.46 Q1933.16 1440.3 1936.75 1440.64 Q1940.32 1440.97 1944.11 1444.77 Z\" fill=\"#000000\" fill-rule=\"evenodd\" fill-opacity=\"1\" /><path clip-path=\"url(#clip120)\" d=\"M1952.07 1426.5 Q1949.65 1428.93 1950.14 1432.23 Q1950.61 1435.52 1953.9 1438.81 Q1957.19 1442.1 1960.48 1442.61 Q1963.77 1443.08 1966.21 1440.64 Q1968.62 1438.24 1968.13 1434.93 Q1967.64 1431.63 1964.36 1428.35 Q1961.11 1425.09 1957.8 1424.6 Q1954.48 1424.1 1952.07 1426.5 M1949.52 1423.95 Q1953.44 1420.02 1958.24 1420.33 Q1963.04 1420.64 1967.55 1425.16 Q1972.06 1429.66 1972.38 1434.47 Q1972.69 1439.27 1968.77 1443.2 Q1964.82 1447.14 1960.02 1446.83 Q1955.23 1446.49 1950.73 1441.99 Q1946.21 1437.47 1945.88 1432.69 Q1945.57 1427.89 1949.52 1423.95 Z\" fill=\"#000000\" fill-rule=\"evenodd\" fill-opacity=\"1\" /><path clip-path=\"url(#clip120)\" d=\"M1977.26 1398.5 L1980.08 1401.31 Q1978.1 1401.88 1976.46 1402.83 Q1974.82 1403.75 1973.51 1405.06 Q1970.58 1407.99 1970.83 1411.48 Q1971.06 1414.95 1974.41 1418.3 Q1977.77 1421.66 1981.25 1421.9 Q1984.72 1422.13 1987.65 1419.2 Q1988.96 1417.89 1989.9 1416.27 Q1990.83 1414.62 1991.4 1412.64 L1994.19 1415.42 Q1993.51 1417.27 1992.45 1418.92 Q1991.4 1420.56 1989.88 1422.08 Q1985.74 1426.22 1980.7 1426.06 Q1975.66 1425.9 1971.24 1421.48 Q1966.75 1416.99 1966.64 1411.97 Q1966.54 1406.93 1970.83 1402.64 Q1972.22 1401.25 1973.84 1400.22 Q1975.44 1399.17 1977.26 1398.5 Z\" fill=\"#000000\" fill-rule=\"evenodd\" fill-opacity=\"1\" /><path clip-path=\"url(#clip120)\" d=\"M2078.82 1574.27 L2081.33 1576.78 L2078.45 1579.66 Q2076.83 1581.28 2076.84 1582.57 Q2076.88 1583.85 2078.58 1585.55 L2080.2 1587.17 L2085.16 1582.21 L2087.5 1584.55 L2082.54 1589.51 L2098.53 1605.5 L2095.5 1608.53 L2079.51 1592.54 L2076.63 1595.42 L2074.29 1593.08 L2077.17 1590.2 L2075.89 1588.92 Q2072.83 1585.86 2072.87 1583.05 Q2072.88 1580.22 2075.98 1577.12 L2078.82 1574.27 Z\" fill=\"#000000\" fill-rule=\"evenodd\" fill-opacity=\"1\" /><path clip-path=\"url(#clip120)\" d=\"M2097.7 1573.9 Q2095.27 1576.32 2095.76 1579.63 Q2096.24 1582.92 2099.53 1586.21 Q2102.82 1589.5 2106.11 1590 Q2109.4 1590.48 2111.84 1588.04 Q2114.24 1585.63 2113.75 1582.33 Q2113.26 1579.02 2109.99 1575.75 Q2106.73 1572.49 2103.42 1572 Q2100.1 1571.49 2097.7 1573.9 M2095.14 1571.34 Q2099.07 1567.42 2103.87 1567.73 Q2108.66 1568.04 2113.18 1572.56 Q2117.68 1577.06 2118.01 1581.87 Q2118.32 1586.66 2114.39 1590.59 Q2110.45 1594.54 2105.65 1594.23 Q2100.86 1593.88 2096.35 1589.38 Q2091.84 1584.86 2091.51 1580.08 Q2091.2 1575.29 2095.14 1571.34 Z\" fill=\"#000000\" fill-rule=\"evenodd\" fill-opacity=\"1\" /><path clip-path=\"url(#clip120)\" d=\"M2122.43 1550.57 Q2121.63 1550.79 2120.89 1551.26 Q2120.15 1551.7 2119.43 1552.42 Q2116.88 1554.98 2117.17 1558.02 Q2117.47 1561.03 2120.58 1564.14 L2130.24 1573.8 L2127.21 1576.83 L2108.88 1558.5 L2111.9 1555.47 L2114.75 1558.32 Q2114.03 1555.7 2114.75 1553.37 Q2115.46 1551.03 2117.63 1548.85 Q2117.94 1548.54 2118.37 1548.22 Q2118.78 1547.87 2119.32 1547.5 L2122.43 1550.57 Z\" fill=\"#000000\" fill-rule=\"evenodd\" fill-opacity=\"1\" /><path clip-path=\"url(#clip120)\" d=\"M2146.13 1538.07 L2147.6 1539.54 L2133.76 1553.39 Q2137.06 1556.3 2140.37 1556.27 Q2143.67 1556.2 2146.67 1553.21 Q2148.4 1551.47 2149.6 1549.43 Q2150.81 1547.36 2151.56 1544.91 L2154.41 1547.76 Q2153.48 1550.07 2152.14 1552.13 Q2150.79 1554.19 2149.04 1555.94 Q2144.66 1560.33 2139.53 1560.34 Q2134.43 1560.34 2130.07 1555.99 Q2125.57 1551.49 2125.36 1546.43 Q2125.15 1541.34 2129.27 1537.22 Q2132.97 1533.52 2137.5 1533.76 Q2142.04 1533.98 2146.13 1538.07 M2142.23 1540.2 Q2139.73 1537.76 2136.9 1537.64 Q2134.08 1537.51 2131.86 1539.74 Q2129.34 1542.26 2129.24 1545.2 Q2129.16 1548.13 2131.51 1550.95 L2142.23 1540.2 Z\" fill=\"#000000\" fill-rule=\"evenodd\" fill-opacity=\"1\" /><path clip-path=\"url(#clip120)\" d=\"M2142.66 1524.71 L2145.67 1521.7 L2164 1540.03 L2160.99 1543.04 L2142.66 1524.71 M2135.52 1517.57 L2138.53 1514.56 L2142.35 1518.38 L2139.34 1521.39 L2135.52 1517.57 Z\" fill=\"#000000\" fill-rule=\"evenodd\" fill-opacity=\"1\" /><path clip-path=\"url(#clip120)\" d=\"M2172.99 1512.29 Q2169.72 1509.01 2166.56 1508.57 Q2163.41 1508.11 2160.98 1510.55 Q2158.55 1512.98 2158.99 1516.13 Q2159.45 1519.28 2162.73 1522.55 Q2165.98 1525.81 2169.13 1526.27 Q2172.29 1526.71 2174.71 1524.29 Q2177.15 1521.85 2176.69 1518.7 Q2176.25 1515.55 2172.99 1512.29 M2183.11 1516.38 Q2187.79 1521.06 2187.98 1525.42 Q2188.2 1529.79 2183.91 1534.07 Q2182.32 1535.66 2180.67 1536.82 Q2179.03 1538 2177.21 1538.84 L2174.28 1535.91 Q2176.33 1535.3 2177.97 1534.35 Q2179.6 1533.4 2180.94 1532.06 Q2183.91 1529.1 2183.83 1526.07 Q2183.76 1523.06 2180.63 1519.93 L2179.14 1518.44 Q2179.83 1521 2179.18 1523.25 Q2178.52 1525.51 2176.49 1527.54 Q2173.12 1530.91 2168.49 1530.41 Q2163.86 1529.9 2159.62 1525.66 Q2155.36 1521.4 2154.85 1516.77 Q2154.35 1512.14 2157.72 1508.77 Q2159.75 1506.74 2162.01 1506.08 Q2164.27 1505.43 2166.82 1506.12 L2164.04 1503.33 L2167.05 1500.32 L2183.11 1516.38 Z\" fill=\"#000000\" fill-rule=\"evenodd\" fill-opacity=\"1\" /><path clip-path=\"url(#clip120)\" d=\"M2195.76 1486.15 L2206.82 1497.21 L2203.81 1500.22 L2192.84 1489.26 Q2190.24 1486.66 2187.93 1486.38 Q2185.63 1486.1 2183.6 1488.13 Q2181.16 1490.57 2181.3 1493.53 Q2181.45 1496.49 2184.14 1499.18 L2194.5 1509.54 L2191.47 1512.57 L2173.14 1494.23 L2176.16 1491.21 L2179.01 1494.05 Q2178.44 1491.32 2179.08 1489.05 Q2179.73 1486.75 2181.65 1484.84 Q2184.81 1481.68 2188.39 1482.02 Q2191.96 1482.35 2195.76 1486.15 Z\" fill=\"#000000\" fill-rule=\"evenodd\" fill-opacity=\"1\" /><path clip-path=\"url(#clip120)\" d=\"M2209.44 1486.28 L2212.9 1482.83 L2217.05 1486.98 L2213.6 1490.44 L2209.44 1486.28 M2196.26 1473.1 L2199.72 1469.65 L2203.88 1473.81 L2200.42 1477.26 L2196.26 1473.1 Z\" fill=\"#000000\" fill-rule=\"evenodd\" fill-opacity=\"1\" /><path clip-path=\"url(#clip120)\" d=\"M2244.11 1463.33 Q2246.11 1467.88 2245.89 1470.09 Q2245.68 1472.3 2243.65 1474.33 L2241.24 1476.74 L2238.72 1474.22 L2240.49 1472.45 Q2241.74 1471.2 2241.83 1469.93 Q2241.93 1468.65 2240.57 1465.62 L2239.74 1463.71 L2214.29 1453.08 L2217.48 1449.89 L2237.55 1458.5 L2228.94 1438.43 L2232.13 1435.24 L2244.11 1463.33 Z\" fill=\"#000000\" fill-rule=\"evenodd\" fill-opacity=\"1\" /><path clip-path=\"url(#clip120)\" d=\"M2260.38 1423.82 L2261.85 1425.29 L2248 1439.14 Q2251.31 1442.05 2254.62 1442.02 Q2257.92 1441.95 2260.92 1438.96 Q2262.65 1437.22 2263.85 1435.18 Q2265.06 1433.12 2265.81 1430.66 L2268.66 1433.51 Q2267.73 1435.82 2266.39 1437.88 Q2265.04 1439.94 2263.29 1441.69 Q2258.91 1446.08 2253.78 1446.1 Q2248.68 1446.1 2244.32 1441.74 Q2239.82 1437.24 2239.61 1432.18 Q2239.39 1427.09 2243.52 1422.97 Q2247.22 1419.27 2251.75 1419.51 Q2256.29 1419.73 2260.38 1423.82 M2256.48 1425.95 Q2253.98 1423.51 2251.15 1423.39 Q2248.33 1423.26 2246.11 1425.49 Q2243.59 1428.01 2243.49 1430.95 Q2243.41 1433.88 2245.76 1436.7 L2256.48 1425.95 Z\" fill=\"#000000\" fill-rule=\"evenodd\" fill-opacity=\"1\" /><path clip-path=\"url(#clip120)\" d=\"M2269.14 1399.32 L2271.98 1402.16 Q2270.05 1402.79 2268.35 1403.83 Q2266.65 1404.88 2265.17 1406.35 Q2262.93 1408.6 2262.49 1410.41 Q2262.06 1412.21 2263.44 1413.59 Q2264.49 1414.64 2265.89 1414.44 Q2267.29 1414.23 2270.25 1412.34 L2271.51 1411.54 Q2275.4 1409.02 2278.01 1408.94 Q2280.61 1408.83 2282.85 1411.07 Q2285.41 1413.62 2284.87 1417.14 Q2284.34 1420.64 2280.81 1424.18 Q2279.33 1425.65 2277.43 1426.96 Q2275.57 1428.27 2273.23 1429.47 L2270.12 1426.36 Q2272.66 1425.55 2274.72 1424.37 Q2276.76 1423.18 2278.35 1421.59 Q2280.48 1419.46 2280.9 1417.6 Q2281.31 1415.72 2279.99 1414.39 Q2278.76 1413.16 2277.27 1413.34 Q2275.8 1413.51 2272.39 1415.7 L2271.1 1416.5 Q2267.71 1418.71 2265.26 1418.74 Q2262.79 1418.76 2260.66 1416.63 Q2258.07 1414.05 2258.5 1410.81 Q2258.92 1407.56 2262.29 1404.19 Q2263.96 1402.52 2265.68 1401.3 Q2267.4 1400.07 2269.14 1399.32 Z\" fill=\"#000000\" fill-rule=\"evenodd\" fill-opacity=\"1\" /><polyline clip-path=\"url(#clip122)\" style=\"stroke:#000000; stroke-linecap:butt; stroke-linejoin:round; stroke-width:2; stroke-opacity:0.1; fill:none\" points=\"\n",
       "  147.478,1204.01 2352.76,1204.01 \n",
       "  \"/>\n",
       "<polyline clip-path=\"url(#clip122)\" style=\"stroke:#000000; stroke-linecap:butt; stroke-linejoin:round; stroke-width:2; stroke-opacity:0.1; fill:none\" points=\"\n",
       "  147.478,1009.02 2352.76,1009.02 \n",
       "  \"/>\n",
       "<polyline clip-path=\"url(#clip122)\" style=\"stroke:#000000; stroke-linecap:butt; stroke-linejoin:round; stroke-width:2; stroke-opacity:0.1; fill:none\" points=\"\n",
       "  147.478,814.028 2352.76,814.028 \n",
       "  \"/>\n",
       "<polyline clip-path=\"url(#clip122)\" style=\"stroke:#000000; stroke-linecap:butt; stroke-linejoin:round; stroke-width:2; stroke-opacity:0.1; fill:none\" points=\"\n",
       "  147.478,619.038 2352.76,619.038 \n",
       "  \"/>\n",
       "<polyline clip-path=\"url(#clip122)\" style=\"stroke:#000000; stroke-linecap:butt; stroke-linejoin:round; stroke-width:2; stroke-opacity:0.1; fill:none\" points=\"\n",
       "  147.478,424.048 2352.76,424.048 \n",
       "  \"/>\n",
       "<polyline clip-path=\"url(#clip122)\" style=\"stroke:#000000; stroke-linecap:butt; stroke-linejoin:round; stroke-width:2; stroke-opacity:0.1; fill:none\" points=\"\n",
       "  147.478,229.058 2352.76,229.058 \n",
       "  \"/>\n",
       "<polyline clip-path=\"url(#clip120)\" style=\"stroke:#000000; stroke-linecap:butt; stroke-linejoin:round; stroke-width:4; stroke-opacity:1; fill:none\" points=\"\n",
       "  147.478,1366.38 147.478,47.2441 \n",
       "  \"/>\n",
       "<polyline clip-path=\"url(#clip120)\" style=\"stroke:#000000; stroke-linecap:butt; stroke-linejoin:round; stroke-width:4; stroke-opacity:1; fill:none\" points=\"\n",
       "  147.478,1204.01 166.376,1204.01 \n",
       "  \"/>\n",
       "<polyline clip-path=\"url(#clip120)\" style=\"stroke:#000000; stroke-linecap:butt; stroke-linejoin:round; stroke-width:4; stroke-opacity:1; fill:none\" points=\"\n",
       "  147.478,1009.02 166.376,1009.02 \n",
       "  \"/>\n",
       "<polyline clip-path=\"url(#clip120)\" style=\"stroke:#000000; stroke-linecap:butt; stroke-linejoin:round; stroke-width:4; stroke-opacity:1; fill:none\" points=\"\n",
       "  147.478,814.028 166.376,814.028 \n",
       "  \"/>\n",
       "<polyline clip-path=\"url(#clip120)\" style=\"stroke:#000000; stroke-linecap:butt; stroke-linejoin:round; stroke-width:4; stroke-opacity:1; fill:none\" points=\"\n",
       "  147.478,619.038 166.376,619.038 \n",
       "  \"/>\n",
       "<polyline clip-path=\"url(#clip120)\" style=\"stroke:#000000; stroke-linecap:butt; stroke-linejoin:round; stroke-width:4; stroke-opacity:1; fill:none\" points=\"\n",
       "  147.478,424.048 166.376,424.048 \n",
       "  \"/>\n",
       "<polyline clip-path=\"url(#clip120)\" style=\"stroke:#000000; stroke-linecap:butt; stroke-linejoin:round; stroke-width:4; stroke-opacity:1; fill:none\" points=\"\n",
       "  147.478,229.058 166.376,229.058 \n",
       "  \"/>\n",
       "<path clip-path=\"url(#clip120)\" d=\"M50.9921 1204.46 L80.6679 1204.46 L80.6679 1208.39 L50.9921 1208.39 L50.9921 1204.46 Z\" fill=\"#000000\" fill-rule=\"evenodd\" fill-opacity=\"1\" /><path clip-path=\"url(#clip120)\" d=\"M91.5706 1217.35 L99.2095 1217.35 L99.2095 1190.99 L90.8993 1192.65 L90.8993 1188.39 L99.1632 1186.73 L103.839 1186.73 L103.839 1217.35 L111.478 1217.35 L111.478 1221.29 L91.5706 1221.29 L91.5706 1217.35 Z\" fill=\"#000000\" fill-rule=\"evenodd\" fill-opacity=\"1\" /><path clip-path=\"url(#clip120)\" d=\"M99.5335 994.817 Q95.9224 994.817 94.0937 998.382 Q92.2882 1001.92 92.2882 1009.05 Q92.2882 1016.16 94.0937 1019.72 Q95.9224 1023.27 99.5335 1023.27 Q103.168 1023.27 104.973 1019.72 Q106.802 1016.16 106.802 1009.05 Q106.802 1001.92 104.973 998.382 Q103.168 994.817 99.5335 994.817 M99.5335 991.113 Q105.344 991.113 108.399 995.72 Q111.478 1000.3 111.478 1009.05 Q111.478 1017.78 108.399 1022.39 Q105.344 1026.97 99.5335 1026.97 Q93.7234 1026.97 90.6447 1022.39 Q87.5892 1017.78 87.5892 1009.05 Q87.5892 1000.3 90.6447 995.72 Q93.7234 991.113 99.5335 991.113 Z\" fill=\"#000000\" fill-rule=\"evenodd\" fill-opacity=\"1\" /><path clip-path=\"url(#clip120)\" d=\"M91.5706 827.373 L99.2095 827.373 L99.2095 801.007 L90.8993 802.674 L90.8993 798.415 L99.1632 796.748 L103.839 796.748 L103.839 827.373 L111.478 827.373 L111.478 831.308 L91.5706 831.308 L91.5706 827.373 Z\" fill=\"#000000\" fill-rule=\"evenodd\" fill-opacity=\"1\" /><path clip-path=\"url(#clip120)\" d=\"M95.1586 632.383 L111.478 632.383 L111.478 636.318 L89.5336 636.318 L89.5336 632.383 Q92.1956 629.628 96.7789 624.999 Q101.385 620.346 102.566 619.003 Q104.811 616.48 105.691 614.744 Q106.594 612.985 106.594 611.295 Q106.594 608.54 104.649 606.804 Q102.728 605.068 99.6261 605.068 Q97.4271 605.068 94.9734 605.832 Q92.5428 606.596 89.7651 608.147 L89.7651 603.425 Q92.5891 602.291 95.0428 601.712 Q97.4965 601.133 99.5335 601.133 Q104.904 601.133 108.098 603.818 Q111.293 606.503 111.293 610.994 Q111.293 613.124 110.483 615.045 Q109.696 616.943 107.589 619.536 Q107.01 620.207 103.909 623.425 Q100.807 626.619 95.1586 632.383 Z\" fill=\"#000000\" fill-rule=\"evenodd\" fill-opacity=\"1\" /><path clip-path=\"url(#clip120)\" d=\"M104.348 422.694 Q107.705 423.412 109.58 425.68 Q111.478 427.949 111.478 431.282 Q111.478 436.398 107.959 439.199 Q104.441 441.999 97.9595 441.999 Q95.7836 441.999 93.4688 441.56 Q91.1771 441.143 88.7234 440.286 L88.7234 435.773 Q90.6678 436.907 92.9826 437.486 Q95.2974 438.064 97.8206 438.064 Q102.219 438.064 104.51 436.328 Q106.825 434.592 106.825 431.282 Q106.825 428.226 104.672 426.513 Q102.543 424.777 98.7234 424.777 L94.6956 424.777 L94.6956 420.935 L98.9085 420.935 Q102.358 420.935 104.186 419.569 Q106.015 418.18 106.015 415.588 Q106.015 412.925 104.117 411.513 Q102.242 410.078 98.7234 410.078 Q96.8021 410.078 94.603 410.495 Q92.4039 410.912 89.7651 411.791 L89.7651 407.625 Q92.4271 406.884 94.7419 406.513 Q97.0798 406.143 99.14 406.143 Q104.464 406.143 107.566 408.574 Q110.668 410.981 110.668 415.101 Q110.668 417.972 109.024 419.962 Q107.381 421.93 104.348 422.694 Z\" fill=\"#000000\" fill-rule=\"evenodd\" fill-opacity=\"1\" /><path clip-path=\"url(#clip120)\" d=\"M101.895 215.852 L90.0891 234.301 L101.895 234.301 L101.895 215.852 M100.668 211.778 L106.547 211.778 L106.547 234.301 L111.478 234.301 L111.478 238.19 L106.547 238.19 L106.547 246.338 L101.895 246.338 L101.895 238.19 L86.2929 238.19 L86.2929 233.676 L100.668 211.778 Z\" fill=\"#000000\" fill-rule=\"evenodd\" fill-opacity=\"1\" /><polyline clip-path=\"url(#clip122)\" style=\"stroke:#000000; stroke-linecap:butt; stroke-linejoin:round; stroke-width:4; stroke-opacity:1; fill:none\" points=\"\n",
       "  239.194,520.049 239.194,141.676 \n",
       "  \"/>\n",
       "<polyline clip-path=\"url(#clip122)\" style=\"stroke:#000000; stroke-linecap:butt; stroke-linejoin:round; stroke-width:4; stroke-opacity:1; fill:none\" points=\"\n",
       "  532.215,1323.77 532.215,965.387 \n",
       "  \"/>\n",
       "<polyline clip-path=\"url(#clip122)\" style=\"stroke:#000000; stroke-linecap:butt; stroke-linejoin:round; stroke-width:4; stroke-opacity:1; fill:none\" points=\"\n",
       "  825.236,856.542 825.236,377.026 \n",
       "  \"/>\n",
       "<polyline clip-path=\"url(#clip122)\" style=\"stroke:#000000; stroke-linecap:butt; stroke-linejoin:round; stroke-width:4; stroke-opacity:1; fill:none\" points=\"\n",
       "  1118.26,1145.46 1118.26,990.267 \n",
       "  \"/>\n",
       "<polyline clip-path=\"url(#clip122)\" style=\"stroke:#000000; stroke-linecap:butt; stroke-linejoin:round; stroke-width:4; stroke-opacity:1; fill:none\" points=\"\n",
       "  1411.28,1008.37 1411.28,1001.74 \n",
       "  \"/>\n",
       "<polyline clip-path=\"url(#clip122)\" style=\"stroke:#000000; stroke-linecap:butt; stroke-linejoin:round; stroke-width:4; stroke-opacity:1; fill:none\" points=\"\n",
       "  1704.3,1329.04 1704.3,972.08 \n",
       "  \"/>\n",
       "<polyline clip-path=\"url(#clip122)\" style=\"stroke:#000000; stroke-linecap:butt; stroke-linejoin:round; stroke-width:4; stroke-opacity:1; fill:none\" points=\"\n",
       "  1997.32,1088.28 1997.32,990.601 \n",
       "  \"/>\n",
       "<polyline clip-path=\"url(#clip122)\" style=\"stroke:#000000; stroke-linecap:butt; stroke-linejoin:round; stroke-width:4; stroke-opacity:1; fill:none\" points=\"\n",
       "  2290.34,963.098 2290.34,778.634 \n",
       "  \"/>\n",
       "<line clip-path=\"url(#clip122)\" x1=\"255.194\" y1=\"520.049\" x2=\"223.194\" y2=\"520.049\" style=\"stroke:#000000; stroke-width:3.2; stroke-opacity:1\"/>\n",
       "<line clip-path=\"url(#clip122)\" x1=\"255.194\" y1=\"141.676\" x2=\"223.194\" y2=\"141.676\" style=\"stroke:#000000; stroke-width:3.2; stroke-opacity:1\"/>\n",
       "<line clip-path=\"url(#clip122)\" x1=\"548.215\" y1=\"1323.77\" x2=\"516.215\" y2=\"1323.77\" style=\"stroke:#000000; stroke-width:3.2; stroke-opacity:1\"/>\n",
       "<line clip-path=\"url(#clip122)\" x1=\"548.215\" y1=\"965.387\" x2=\"516.215\" y2=\"965.387\" style=\"stroke:#000000; stroke-width:3.2; stroke-opacity:1\"/>\n",
       "<line clip-path=\"url(#clip122)\" x1=\"841.236\" y1=\"856.542\" x2=\"809.236\" y2=\"856.542\" style=\"stroke:#000000; stroke-width:3.2; stroke-opacity:1\"/>\n",
       "<line clip-path=\"url(#clip122)\" x1=\"841.236\" y1=\"377.026\" x2=\"809.236\" y2=\"377.026\" style=\"stroke:#000000; stroke-width:3.2; stroke-opacity:1\"/>\n",
       "<line clip-path=\"url(#clip122)\" x1=\"1134.26\" y1=\"1145.46\" x2=\"1102.26\" y2=\"1145.46\" style=\"stroke:#000000; stroke-width:3.2; stroke-opacity:1\"/>\n",
       "<line clip-path=\"url(#clip122)\" x1=\"1134.26\" y1=\"990.267\" x2=\"1102.26\" y2=\"990.267\" style=\"stroke:#000000; stroke-width:3.2; stroke-opacity:1\"/>\n",
       "<line clip-path=\"url(#clip122)\" x1=\"1427.28\" y1=\"1008.37\" x2=\"1395.28\" y2=\"1008.37\" style=\"stroke:#000000; stroke-width:3.2; stroke-opacity:1\"/>\n",
       "<line clip-path=\"url(#clip122)\" x1=\"1427.28\" y1=\"1001.74\" x2=\"1395.28\" y2=\"1001.74\" style=\"stroke:#000000; stroke-width:3.2; stroke-opacity:1\"/>\n",
       "<line clip-path=\"url(#clip122)\" x1=\"1720.3\" y1=\"1329.04\" x2=\"1688.3\" y2=\"1329.04\" style=\"stroke:#000000; stroke-width:3.2; stroke-opacity:1\"/>\n",
       "<line clip-path=\"url(#clip122)\" x1=\"1720.3\" y1=\"972.08\" x2=\"1688.3\" y2=\"972.08\" style=\"stroke:#000000; stroke-width:3.2; stroke-opacity:1\"/>\n",
       "<line clip-path=\"url(#clip122)\" x1=\"2013.32\" y1=\"1088.28\" x2=\"1981.32\" y2=\"1088.28\" style=\"stroke:#000000; stroke-width:3.2; stroke-opacity:1\"/>\n",
       "<line clip-path=\"url(#clip122)\" x1=\"2013.32\" y1=\"990.601\" x2=\"1981.32\" y2=\"990.601\" style=\"stroke:#000000; stroke-width:3.2; stroke-opacity:1\"/>\n",
       "<line clip-path=\"url(#clip122)\" x1=\"2306.34\" y1=\"963.098\" x2=\"2274.34\" y2=\"963.098\" style=\"stroke:#000000; stroke-width:3.2; stroke-opacity:1\"/>\n",
       "<line clip-path=\"url(#clip122)\" x1=\"2306.34\" y1=\"778.634\" x2=\"2274.34\" y2=\"778.634\" style=\"stroke:#000000; stroke-width:3.2; stroke-opacity:1\"/>\n",
       "<circle clip-path=\"url(#clip122)\" cx=\"239.194\" cy=\"278.009\" r=\"14\" fill=\"#009af9\" fill-rule=\"evenodd\" fill-opacity=\"1\" stroke=\"#000000\" stroke-opacity=\"1\" stroke-width=\"3.2\"/>\n",
       "<circle clip-path=\"url(#clip122)\" cx=\"532.215\" cy=\"1139.06\" r=\"14\" fill=\"#009af9\" fill-rule=\"evenodd\" fill-opacity=\"1\" stroke=\"#000000\" stroke-opacity=\"1\" stroke-width=\"3.2\"/>\n",
       "<circle clip-path=\"url(#clip122)\" cx=\"825.236\" cy=\"604.353\" r=\"14\" fill=\"#009af9\" fill-rule=\"evenodd\" fill-opacity=\"1\" stroke=\"#000000\" stroke-opacity=\"1\" stroke-width=\"3.2\"/>\n",
       "<circle clip-path=\"url(#clip122)\" cx=\"1118.26\" cy=\"1066.41\" r=\"14\" fill=\"#009af9\" fill-rule=\"evenodd\" fill-opacity=\"1\" stroke=\"#000000\" stroke-opacity=\"1\" stroke-width=\"3.2\"/>\n",
       "<circle clip-path=\"url(#clip122)\" cx=\"1411.28\" cy=\"1005.27\" r=\"14\" fill=\"#009af9\" fill-rule=\"evenodd\" fill-opacity=\"1\" stroke=\"#000000\" stroke-opacity=\"1\" stroke-width=\"3.2\"/>\n",
       "<circle clip-path=\"url(#clip122)\" cx=\"1704.3\" cy=\"1148.33\" r=\"14\" fill=\"#009af9\" fill-rule=\"evenodd\" fill-opacity=\"1\" stroke=\"#000000\" stroke-opacity=\"1\" stroke-width=\"3.2\"/>\n",
       "<circle clip-path=\"url(#clip122)\" cx=\"1997.32\" cy=\"1037.68\" r=\"14\" fill=\"#009af9\" fill-rule=\"evenodd\" fill-opacity=\"1\" stroke=\"#000000\" stroke-opacity=\"1\" stroke-width=\"3.2\"/>\n",
       "<circle clip-path=\"url(#clip122)\" cx=\"2290.34\" cy=\"869.721\" r=\"14\" fill=\"#009af9\" fill-rule=\"evenodd\" fill-opacity=\"1\" stroke=\"#000000\" stroke-opacity=\"1\" stroke-width=\"3.2\"/>\n",
       "<polyline clip-path=\"url(#clip122)\" style=\"stroke:#000000; stroke-linecap:butt; stroke-linejoin:round; stroke-width:4; stroke-opacity:1; fill:none\" points=\"\n",
       "  209.891,471.44 209.891,84.5781 \n",
       "  \"/>\n",
       "<polyline clip-path=\"url(#clip122)\" style=\"stroke:#000000; stroke-linecap:butt; stroke-linejoin:round; stroke-width:4; stroke-opacity:1; fill:none\" points=\"\n",
       "  502.913,1319.52 502.913,958.602 \n",
       "  \"/>\n",
       "<polyline clip-path=\"url(#clip122)\" style=\"stroke:#000000; stroke-linecap:butt; stroke-linejoin:round; stroke-width:4; stroke-opacity:1; fill:none\" points=\"\n",
       "  795.934,854.082 795.934,354.625 \n",
       "  \"/>\n",
       "<polyline clip-path=\"url(#clip122)\" style=\"stroke:#000000; stroke-linecap:butt; stroke-linejoin:round; stroke-width:4; stroke-opacity:1; fill:none\" points=\"\n",
       "  1088.96,1142.89 1088.96,989.931 \n",
       "  \"/>\n",
       "<polyline clip-path=\"url(#clip122)\" style=\"stroke:#000000; stroke-linecap:butt; stroke-linejoin:round; stroke-width:4; stroke-opacity:1; fill:none\" points=\"\n",
       "  1381.98,1008.38 1381.98,1002.17 \n",
       "  \"/>\n",
       "<polyline clip-path=\"url(#clip122)\" style=\"stroke:#000000; stroke-linecap:butt; stroke-linejoin:round; stroke-width:4; stroke-opacity:1; fill:none\" points=\"\n",
       "  1675,1326.01 1675,970.649 \n",
       "  \"/>\n",
       "<polyline clip-path=\"url(#clip122)\" style=\"stroke:#000000; stroke-linecap:butt; stroke-linejoin:round; stroke-width:4; stroke-opacity:1; fill:none\" points=\"\n",
       "  1968.02,1085.79 1968.02,989.571 \n",
       "  \"/>\n",
       "<polyline clip-path=\"url(#clip122)\" style=\"stroke:#000000; stroke-linecap:butt; stroke-linejoin:round; stroke-width:4; stroke-opacity:1; fill:none\" points=\"\n",
       "  2261.04,962.651 2261.04,776.791 \n",
       "  \"/>\n",
       "<line clip-path=\"url(#clip122)\" x1=\"225.891\" y1=\"471.44\" x2=\"193.891\" y2=\"471.44\" style=\"stroke:#000000; stroke-width:3.2; stroke-opacity:1\"/>\n",
       "<line clip-path=\"url(#clip122)\" x1=\"225.891\" y1=\"84.5781\" x2=\"193.891\" y2=\"84.5781\" style=\"stroke:#000000; stroke-width:3.2; stroke-opacity:1\"/>\n",
       "<line clip-path=\"url(#clip122)\" x1=\"518.913\" y1=\"1319.52\" x2=\"486.913\" y2=\"1319.52\" style=\"stroke:#000000; stroke-width:3.2; stroke-opacity:1\"/>\n",
       "<line clip-path=\"url(#clip122)\" x1=\"518.913\" y1=\"958.602\" x2=\"486.913\" y2=\"958.602\" style=\"stroke:#000000; stroke-width:3.2; stroke-opacity:1\"/>\n",
       "<line clip-path=\"url(#clip122)\" x1=\"811.934\" y1=\"854.082\" x2=\"779.934\" y2=\"854.082\" style=\"stroke:#000000; stroke-width:3.2; stroke-opacity:1\"/>\n",
       "<line clip-path=\"url(#clip122)\" x1=\"811.934\" y1=\"354.625\" x2=\"779.934\" y2=\"354.625\" style=\"stroke:#000000; stroke-width:3.2; stroke-opacity:1\"/>\n",
       "<line clip-path=\"url(#clip122)\" x1=\"1104.96\" y1=\"1142.89\" x2=\"1072.96\" y2=\"1142.89\" style=\"stroke:#000000; stroke-width:3.2; stroke-opacity:1\"/>\n",
       "<line clip-path=\"url(#clip122)\" x1=\"1104.96\" y1=\"989.931\" x2=\"1072.96\" y2=\"989.931\" style=\"stroke:#000000; stroke-width:3.2; stroke-opacity:1\"/>\n",
       "<line clip-path=\"url(#clip122)\" x1=\"1397.98\" y1=\"1008.38\" x2=\"1365.98\" y2=\"1008.38\" style=\"stroke:#000000; stroke-width:3.2; stroke-opacity:1\"/>\n",
       "<line clip-path=\"url(#clip122)\" x1=\"1397.98\" y1=\"1002.17\" x2=\"1365.98\" y2=\"1002.17\" style=\"stroke:#000000; stroke-width:3.2; stroke-opacity:1\"/>\n",
       "<line clip-path=\"url(#clip122)\" x1=\"1691\" y1=\"1326.01\" x2=\"1659\" y2=\"1326.01\" style=\"stroke:#000000; stroke-width:3.2; stroke-opacity:1\"/>\n",
       "<line clip-path=\"url(#clip122)\" x1=\"1691\" y1=\"970.649\" x2=\"1659\" y2=\"970.649\" style=\"stroke:#000000; stroke-width:3.2; stroke-opacity:1\"/>\n",
       "<line clip-path=\"url(#clip122)\" x1=\"1984.02\" y1=\"1085.79\" x2=\"1952.02\" y2=\"1085.79\" style=\"stroke:#000000; stroke-width:3.2; stroke-opacity:1\"/>\n",
       "<line clip-path=\"url(#clip122)\" x1=\"1984.02\" y1=\"989.571\" x2=\"1952.02\" y2=\"989.571\" style=\"stroke:#000000; stroke-width:3.2; stroke-opacity:1\"/>\n",
       "<line clip-path=\"url(#clip122)\" x1=\"2277.04\" y1=\"962.651\" x2=\"2245.04\" y2=\"962.651\" style=\"stroke:#000000; stroke-width:3.2; stroke-opacity:1\"/>\n",
       "<line clip-path=\"url(#clip122)\" x1=\"2277.04\" y1=\"776.791\" x2=\"2245.04\" y2=\"776.791\" style=\"stroke:#000000; stroke-width:3.2; stroke-opacity:1\"/>\n",
       "<circle clip-path=\"url(#clip122)\" cx=\"209.891\" cy=\"278.009\" r=\"14\" fill=\"#e26f46\" fill-rule=\"evenodd\" fill-opacity=\"1\" stroke=\"#000000\" stroke-opacity=\"1\" stroke-width=\"3.2\"/>\n",
       "<circle clip-path=\"url(#clip122)\" cx=\"502.913\" cy=\"1139.06\" r=\"14\" fill=\"#e26f46\" fill-rule=\"evenodd\" fill-opacity=\"1\" stroke=\"#000000\" stroke-opacity=\"1\" stroke-width=\"3.2\"/>\n",
       "<circle clip-path=\"url(#clip122)\" cx=\"795.934\" cy=\"604.353\" r=\"14\" fill=\"#e26f46\" fill-rule=\"evenodd\" fill-opacity=\"1\" stroke=\"#000000\" stroke-opacity=\"1\" stroke-width=\"3.2\"/>\n",
       "<circle clip-path=\"url(#clip122)\" cx=\"1088.96\" cy=\"1066.41\" r=\"14\" fill=\"#e26f46\" fill-rule=\"evenodd\" fill-opacity=\"1\" stroke=\"#000000\" stroke-opacity=\"1\" stroke-width=\"3.2\"/>\n",
       "<circle clip-path=\"url(#clip122)\" cx=\"1381.98\" cy=\"1005.27\" r=\"14\" fill=\"#e26f46\" fill-rule=\"evenodd\" fill-opacity=\"1\" stroke=\"#000000\" stroke-opacity=\"1\" stroke-width=\"3.2\"/>\n",
       "<circle clip-path=\"url(#clip122)\" cx=\"1675\" cy=\"1148.33\" r=\"14\" fill=\"#e26f46\" fill-rule=\"evenodd\" fill-opacity=\"1\" stroke=\"#000000\" stroke-opacity=\"1\" stroke-width=\"3.2\"/>\n",
       "<circle clip-path=\"url(#clip122)\" cx=\"1968.02\" cy=\"1037.68\" r=\"14\" fill=\"#e26f46\" fill-rule=\"evenodd\" fill-opacity=\"1\" stroke=\"#000000\" stroke-opacity=\"1\" stroke-width=\"3.2\"/>\n",
       "<circle clip-path=\"url(#clip122)\" cx=\"2261.04\" cy=\"869.721\" r=\"14\" fill=\"#e26f46\" fill-rule=\"evenodd\" fill-opacity=\"1\" stroke=\"#000000\" stroke-opacity=\"1\" stroke-width=\"3.2\"/>\n",
       "<path clip-path=\"url(#clip120)\" d=\"\n",
       "M1786.15 246.735 L2279.25 246.735 L2279.25 91.2152 L1786.15 91.2152  Z\n",
       "  \" fill=\"#ffffff\" fill-rule=\"evenodd\" fill-opacity=\"1\"/>\n",
       "<polyline clip-path=\"url(#clip120)\" style=\"stroke:#000000; stroke-linecap:butt; stroke-linejoin:round; stroke-width:4; stroke-opacity:1; fill:none\" points=\"\n",
       "  1786.15,246.735 2279.25,246.735 2279.25,91.2152 1786.15,91.2152 1786.15,246.735 \n",
       "  \"/>\n",
       "<circle clip-path=\"url(#clip120)\" cx=\"1882.15\" cy=\"143.055\" r=\"23\" fill=\"#009af9\" fill-rule=\"evenodd\" fill-opacity=\"1\" stroke=\"#000000\" stroke-opacity=\"1\" stroke-width=\"5.12\"/>\n",
       "<path clip-path=\"url(#clip120)\" d=\"M1996.92 147.395 Q1996.92 142.696 1994.97 140.034 Q1993.05 137.349 1989.67 137.349 Q1986.29 137.349 1984.35 140.034 Q1982.43 142.696 1982.43 147.395 Q1982.43 152.095 1984.35 154.78 Q1986.29 157.442 1989.67 157.442 Q1993.05 157.442 1994.97 154.78 Q1996.92 152.095 1996.92 147.395 M1982.43 138.345 Q1983.77 136.03 1985.81 134.919 Q1987.87 133.784 1990.72 133.784 Q1995.44 133.784 1998.38 137.534 Q2001.34 141.284 2001.34 147.395 Q2001.34 153.507 1998.38 157.257 Q1995.44 161.007 1990.72 161.007 Q1987.87 161.007 1985.81 159.895 Q1983.77 158.761 1982.43 156.446 L1982.43 160.335 L1978.15 160.335 L1978.15 124.317 L1982.43 124.317 L1982.43 138.345 Z\" fill=\"#000000\" fill-rule=\"evenodd\" fill-opacity=\"1\" /><path clip-path=\"url(#clip120)\" d=\"M2018.45 137.396 Q2015.02 137.396 2013.03 140.081 Q2011.04 142.743 2011.04 147.395 Q2011.04 152.048 2013.01 154.733 Q2015 157.395 2018.45 157.395 Q2021.85 157.395 2023.84 154.71 Q2025.83 152.025 2025.83 147.395 Q2025.83 142.789 2023.84 140.104 Q2021.85 137.396 2018.45 137.396 M2018.45 133.784 Q2024 133.784 2027.17 137.396 Q2030.34 141.007 2030.34 147.395 Q2030.34 153.761 2027.17 157.395 Q2024 161.007 2018.45 161.007 Q2012.87 161.007 2009.7 157.395 Q2006.55 153.761 2006.55 147.395 Q2006.55 141.007 2009.7 137.396 Q2012.87 133.784 2018.45 133.784 Z\" fill=\"#000000\" fill-rule=\"evenodd\" fill-opacity=\"1\" /><path clip-path=\"url(#clip120)\" d=\"M2047.45 137.396 Q2044.03 137.396 2042.03 140.081 Q2040.04 142.743 2040.04 147.395 Q2040.04 152.048 2042.01 154.733 Q2044 157.395 2047.45 157.395 Q2050.85 157.395 2052.84 154.71 Q2054.84 152.025 2054.84 147.395 Q2054.84 142.789 2052.84 140.104 Q2050.85 137.396 2047.45 137.396 M2047.45 133.784 Q2053.01 133.784 2056.18 137.396 Q2059.35 141.007 2059.35 147.395 Q2059.35 153.761 2056.18 157.395 Q2053.01 161.007 2047.45 161.007 Q2041.87 161.007 2038.7 157.395 Q2035.55 153.761 2035.55 147.395 Q2035.55 141.007 2038.7 137.396 Q2041.87 133.784 2047.45 133.784 Z\" fill=\"#000000\" fill-rule=\"evenodd\" fill-opacity=\"1\" /><path clip-path=\"url(#clip120)\" d=\"M2070.62 127.048 L2070.62 134.409 L2079.4 134.409 L2079.4 137.72 L2070.62 137.72 L2070.62 151.794 Q2070.62 154.965 2071.48 155.868 Q2072.36 156.77 2075.02 156.77 L2079.4 156.77 L2079.4 160.335 L2075.02 160.335 Q2070.09 160.335 2068.22 158.507 Q2066.34 156.655 2066.34 151.794 L2066.34 137.72 L2063.22 137.72 L2063.22 134.409 L2066.34 134.409 L2066.34 127.048 L2070.62 127.048 Z\" fill=\"#000000\" fill-rule=\"evenodd\" fill-opacity=\"1\" /><path clip-path=\"url(#clip120)\" d=\"M2101.53 135.173 L2101.53 139.201 Q2099.72 138.275 2097.78 137.812 Q2095.83 137.349 2093.75 137.349 Q2090.58 137.349 2088.98 138.321 Q2087.4 139.294 2087.4 141.238 Q2087.4 142.72 2088.54 143.576 Q2089.67 144.409 2093.1 145.173 L2094.56 145.497 Q2099.09 146.47 2100.99 148.252 Q2102.91 150.011 2102.91 153.182 Q2102.91 156.794 2100.04 158.9 Q2097.2 161.007 2092.2 161.007 Q2090.11 161.007 2087.84 160.59 Q2085.6 160.196 2083.1 159.386 L2083.1 154.988 Q2085.46 156.215 2087.75 156.84 Q2090.04 157.442 2092.29 157.442 Q2095.3 157.442 2096.92 156.423 Q2098.54 155.382 2098.54 153.507 Q2098.54 151.77 2097.36 150.845 Q2096.2 149.919 2092.24 149.062 L2090.76 148.715 Q2086.8 147.882 2085.04 146.169 Q2083.28 144.433 2083.28 141.423 Q2083.28 137.766 2085.88 135.775 Q2088.47 133.784 2093.24 133.784 Q2095.6 133.784 2097.68 134.132 Q2099.77 134.479 2101.53 135.173 Z\" fill=\"#000000\" fill-rule=\"evenodd\" fill-opacity=\"1\" /><path clip-path=\"url(#clip120)\" d=\"M2113.91 127.048 L2113.91 134.409 L2122.68 134.409 L2122.68 137.72 L2113.91 137.72 L2113.91 151.794 Q2113.91 154.965 2114.77 155.868 Q2115.65 156.77 2118.31 156.77 L2122.68 156.77 L2122.68 160.335 L2118.31 160.335 Q2113.38 160.335 2111.5 158.507 Q2109.63 156.655 2109.63 151.794 L2109.63 137.72 L2106.5 137.72 L2106.5 134.409 L2109.63 134.409 L2109.63 127.048 L2113.91 127.048 Z\" fill=\"#000000\" fill-rule=\"evenodd\" fill-opacity=\"1\" /><path clip-path=\"url(#clip120)\" d=\"M2143.31 138.391 Q2142.59 137.974 2141.73 137.789 Q2140.9 137.581 2139.88 137.581 Q2136.27 137.581 2134.33 139.942 Q2132.4 142.28 2132.4 146.678 L2132.4 160.335 L2128.12 160.335 L2128.12 134.409 L2132.4 134.409 L2132.4 138.437 Q2133.75 136.076 2135.9 134.942 Q2138.05 133.784 2141.13 133.784 Q2141.57 133.784 2142.1 133.854 Q2142.64 133.9 2143.28 134.016 L2143.31 138.391 Z\" fill=\"#000000\" fill-rule=\"evenodd\" fill-opacity=\"1\" /><path clip-path=\"url(#clip120)\" d=\"M2159.56 147.303 Q2154.4 147.303 2152.4 148.483 Q2150.41 149.664 2150.41 152.511 Q2150.41 154.78 2151.9 156.122 Q2153.4 157.442 2155.97 157.442 Q2159.51 157.442 2161.64 154.942 Q2163.79 152.419 2163.79 148.252 L2163.79 147.303 L2159.56 147.303 M2168.05 145.544 L2168.05 160.335 L2163.79 160.335 L2163.79 156.4 Q2162.33 158.761 2160.16 159.895 Q2157.98 161.007 2154.84 161.007 Q2150.85 161.007 2148.49 158.784 Q2146.15 156.539 2146.15 152.789 Q2146.15 148.414 2149.07 146.192 Q2152.01 143.97 2157.82 143.97 L2163.79 143.97 L2163.79 143.553 Q2163.79 140.613 2161.85 139.016 Q2159.93 137.396 2156.43 137.396 Q2154.21 137.396 2152.1 137.928 Q2150 138.46 2148.05 139.525 L2148.05 135.59 Q2150.39 134.687 2152.59 134.247 Q2154.79 133.784 2156.87 133.784 Q2162.5 133.784 2165.27 136.701 Q2168.05 139.618 2168.05 145.544 Z\" fill=\"#000000\" fill-rule=\"evenodd\" fill-opacity=\"1\" /><path clip-path=\"url(#clip120)\" d=\"M2180.95 156.446 L2180.95 170.196 L2176.66 170.196 L2176.66 134.409 L2180.95 134.409 L2180.95 138.345 Q2182.29 136.03 2184.33 134.919 Q2186.39 133.784 2189.23 133.784 Q2193.96 133.784 2196.89 137.534 Q2199.86 141.284 2199.86 147.395 Q2199.86 153.507 2196.89 157.257 Q2193.96 161.007 2189.23 161.007 Q2186.39 161.007 2184.33 159.895 Q2182.29 158.761 2180.95 156.446 M2195.44 147.395 Q2195.44 142.696 2193.49 140.034 Q2191.57 137.349 2188.19 137.349 Q2184.81 137.349 2182.87 140.034 Q2180.95 142.696 2180.95 147.395 Q2180.95 152.095 2182.87 154.78 Q2184.81 157.442 2188.19 157.442 Q2191.57 157.442 2193.49 154.78 Q2195.44 152.095 2195.44 147.395 Z\" fill=\"#000000\" fill-rule=\"evenodd\" fill-opacity=\"1\" /><circle clip-path=\"url(#clip120)\" cx=\"1882.15\" cy=\"194.895\" r=\"23\" fill=\"#e26f46\" fill-rule=\"evenodd\" fill-opacity=\"1\" stroke=\"#000000\" stroke-opacity=\"1\" stroke-width=\"5.12\"/>\n",
       "<path clip-path=\"url(#clip120)\" d=\"M1982.43 208.286 L1982.43 222.036 L1978.15 222.036 L1978.15 186.249 L1982.43 186.249 L1982.43 190.185 Q1983.77 187.87 1985.81 186.759 Q1987.87 185.624 1990.72 185.624 Q1995.44 185.624 1998.38 189.374 Q2001.34 193.124 2001.34 199.235 Q2001.34 205.347 1998.38 209.097 Q1995.44 212.847 1990.72 212.847 Q1987.87 212.847 1985.81 211.735 Q1983.77 210.601 1982.43 208.286 M1996.92 199.235 Q1996.92 194.536 1994.97 191.874 Q1993.05 189.189 1989.67 189.189 Q1986.29 189.189 1984.35 191.874 Q1982.43 194.536 1982.43 199.235 Q1982.43 203.935 1984.35 206.62 Q1986.29 209.282 1989.67 209.282 Q1993.05 209.282 1994.97 206.62 Q1996.92 203.935 1996.92 199.235 Z\" fill=\"#000000\" fill-rule=\"evenodd\" fill-opacity=\"1\" /><path clip-path=\"url(#clip120)\" d=\"M2020.18 199.143 Q2015.02 199.143 2013.03 200.323 Q2011.04 201.504 2011.04 204.351 Q2011.04 206.62 2012.52 207.962 Q2014.03 209.282 2016.6 209.282 Q2020.14 209.282 2022.27 206.782 Q2024.42 204.259 2024.42 200.092 L2024.42 199.143 L2020.18 199.143 M2028.68 197.384 L2028.68 212.175 L2024.42 212.175 L2024.42 208.24 Q2022.96 210.601 2020.78 211.735 Q2018.61 212.847 2015.46 212.847 Q2011.48 212.847 2009.12 210.624 Q2006.78 208.379 2006.78 204.629 Q2006.78 200.254 2009.7 198.032 Q2012.64 195.81 2018.45 195.81 L2024.42 195.81 L2024.42 195.393 Q2024.42 192.453 2022.47 190.856 Q2020.55 189.236 2017.06 189.236 Q2014.84 189.236 2012.73 189.768 Q2010.62 190.3 2008.68 191.365 L2008.68 187.43 Q2011.02 186.527 2013.22 186.087 Q2015.41 185.624 2017.5 185.624 Q2023.12 185.624 2025.9 188.541 Q2028.68 191.458 2028.68 197.384 Z\" fill=\"#000000\" fill-rule=\"evenodd\" fill-opacity=\"1\" /><path clip-path=\"url(#clip120)\" d=\"M2052.47 190.231 Q2051.76 189.814 2050.9 189.629 Q2050.07 189.421 2049.05 189.421 Q2045.44 189.421 2043.49 191.782 Q2041.57 194.12 2041.57 198.518 L2041.57 212.175 L2037.29 212.175 L2037.29 186.249 L2041.57 186.249 L2041.57 190.277 Q2042.91 187.916 2045.07 186.782 Q2047.22 185.624 2050.3 185.624 Q2050.74 185.624 2051.27 185.694 Q2051.8 185.74 2052.45 185.856 L2052.47 190.231 Z\" fill=\"#000000\" fill-rule=\"evenodd\" fill-opacity=\"1\" /><path clip-path=\"url(#clip120)\" d=\"M2068.72 199.143 Q2063.56 199.143 2061.57 200.323 Q2059.58 201.504 2059.58 204.351 Q2059.58 206.62 2061.06 207.962 Q2062.57 209.282 2065.14 209.282 Q2068.68 209.282 2070.81 206.782 Q2072.96 204.259 2072.96 200.092 L2072.96 199.143 L2068.72 199.143 M2077.22 197.384 L2077.22 212.175 L2072.96 212.175 L2072.96 208.24 Q2071.5 210.601 2069.33 211.735 Q2067.15 212.847 2064 212.847 Q2060.02 212.847 2057.66 210.624 Q2055.32 208.379 2055.32 204.629 Q2055.32 200.254 2058.24 198.032 Q2061.18 195.81 2066.99 195.81 L2072.96 195.81 L2072.96 195.393 Q2072.96 192.453 2071.02 190.856 Q2069.09 189.236 2065.6 189.236 Q2063.38 189.236 2061.27 189.768 Q2059.16 190.3 2057.22 191.365 L2057.22 187.43 Q2059.56 186.527 2061.76 186.087 Q2063.96 185.624 2066.04 185.624 Q2071.66 185.624 2074.44 188.541 Q2077.22 191.458 2077.22 197.384 Z\" fill=\"#000000\" fill-rule=\"evenodd\" fill-opacity=\"1\" /><path clip-path=\"url(#clip120)\" d=\"M2106.18 191.226 Q2107.78 188.356 2110 186.99 Q2112.22 185.624 2115.23 185.624 Q2119.28 185.624 2121.48 188.472 Q2123.68 191.296 2123.68 196.527 L2123.68 212.175 L2119.4 212.175 L2119.4 196.666 Q2119.4 192.939 2118.08 191.134 Q2116.76 189.328 2114.05 189.328 Q2110.74 189.328 2108.82 191.527 Q2106.9 193.726 2106.9 197.523 L2106.9 212.175 L2102.61 212.175 L2102.61 196.666 Q2102.61 192.916 2101.29 191.134 Q2099.97 189.328 2097.22 189.328 Q2093.96 189.328 2092.03 191.55 Q2090.11 193.749 2090.11 197.523 L2090.11 212.175 L2085.83 212.175 L2085.83 186.249 L2090.11 186.249 L2090.11 190.277 Q2091.57 187.893 2093.61 186.759 Q2095.65 185.624 2098.45 185.624 Q2101.27 185.624 2103.24 187.06 Q2105.23 188.495 2106.18 191.226 Z\" fill=\"#000000\" fill-rule=\"evenodd\" fill-opacity=\"1\" /><path clip-path=\"url(#clip120)\" d=\"M2154.35 198.148 L2154.35 200.231 L2134.77 200.231 Q2135.04 204.629 2137.4 206.944 Q2139.79 209.235 2144.02 209.235 Q2146.48 209.235 2148.77 208.634 Q2151.09 208.032 2153.35 206.828 L2153.35 210.856 Q2151.06 211.828 2148.65 212.337 Q2146.25 212.847 2143.77 212.847 Q2137.57 212.847 2133.93 209.235 Q2130.32 205.624 2130.32 199.467 Q2130.32 193.101 2133.75 189.374 Q2137.2 185.624 2143.03 185.624 Q2148.26 185.624 2151.29 189.004 Q2154.35 192.361 2154.35 198.148 M2150.09 196.898 Q2150.04 193.402 2148.12 191.319 Q2146.22 189.236 2143.08 189.236 Q2139.51 189.236 2137.36 191.249 Q2135.23 193.263 2134.9 196.921 L2150.09 196.898 Z\" fill=\"#000000\" fill-rule=\"evenodd\" fill-opacity=\"1\" /><path clip-path=\"url(#clip120)\" d=\"M2165.55 178.888 L2165.55 186.249 L2174.33 186.249 L2174.33 189.56 L2165.55 189.56 L2165.55 203.634 Q2165.55 206.805 2166.41 207.708 Q2167.29 208.61 2169.95 208.61 L2174.33 208.61 L2174.33 212.175 L2169.95 212.175 Q2165.02 212.175 2163.15 210.347 Q2161.27 208.495 2161.27 203.634 L2161.27 189.56 L2158.15 189.56 L2158.15 186.249 L2161.27 186.249 L2161.27 178.888 L2165.55 178.888 Z\" fill=\"#000000\" fill-rule=\"evenodd\" fill-opacity=\"1\" /><path clip-path=\"url(#clip120)\" d=\"M2194.95 190.231 Q2194.23 189.814 2193.38 189.629 Q2192.54 189.421 2191.52 189.421 Q2187.91 189.421 2185.97 191.782 Q2184.05 194.12 2184.05 198.518 L2184.05 212.175 L2179.77 212.175 L2179.77 186.249 L2184.05 186.249 L2184.05 190.277 Q2185.39 187.916 2187.54 186.782 Q2189.7 185.624 2192.77 185.624 Q2193.21 185.624 2193.75 185.694 Q2194.28 185.74 2194.93 185.856 L2194.95 190.231 Z\" fill=\"#000000\" fill-rule=\"evenodd\" fill-opacity=\"1\" /><path clip-path=\"url(#clip120)\" d=\"M2199.42 186.249 L2203.68 186.249 L2203.68 212.175 L2199.42 212.175 L2199.42 186.249 M2199.42 176.157 L2203.68 176.157 L2203.68 181.55 L2199.42 181.55 L2199.42 176.157 Z\" fill=\"#000000\" fill-rule=\"evenodd\" fill-opacity=\"1\" /><path clip-path=\"url(#clip120)\" d=\"M2231.25 187.245 L2231.25 191.226 Q2229.44 190.231 2227.61 189.745 Q2225.81 189.236 2223.96 189.236 Q2219.81 189.236 2217.52 191.874 Q2215.23 194.49 2215.23 199.235 Q2215.23 203.981 2217.52 206.62 Q2219.81 209.235 2223.96 209.235 Q2225.81 209.235 2227.61 208.749 Q2229.44 208.24 2231.25 207.245 L2231.25 211.18 Q2229.46 212.013 2227.54 212.43 Q2225.64 212.847 2223.49 212.847 Q2217.64 212.847 2214.19 209.166 Q2210.74 205.485 2210.74 199.235 Q2210.74 192.893 2214.21 189.259 Q2217.71 185.624 2223.77 185.624 Q2225.74 185.624 2227.61 186.041 Q2229.49 186.435 2231.25 187.245 Z\" fill=\"#000000\" fill-rule=\"evenodd\" fill-opacity=\"1\" /></svg>\n"
      ]
     },
     "execution_count": 55,
     "metadata": {},
     "output_type": "execute_result"
    }
   ],
   "source": [
    "scatter(0.05 .+ (1:8), conf_boot_t.estimate,\n",
    "        yerror=(conf_boot_t.\"boot lo\", conf_boot_t.\"boot hi\"),\n",
    "        label=\"bootstrap\",\n",
    "        xticks=(1:8, conf_boot_t.statistic), xrotation=45)\n",
    "scatter!(-0.05 .+ (1:8), conf_boot_t.estimate,\n",
    "         yerror=(conf_boot_t.\"parametric lo\", conf_boot_t.\"parametric hi\"),\n",
    "         label=\"parametric\")"
   ]
  },
  {
   "cell_type": "code",
   "execution_count": 56,
   "id": "0b44d7f5",
   "metadata": {},
   "outputs": [
    {
     "data": {
      "text/plain": [
       "boot_probit (generic function with 1 method)"
      ]
     },
     "execution_count": 56,
     "metadata": {},
     "output_type": "execute_result"
    }
   ],
   "source": [
    "function boot_probit(df_boot)\n",
    "    probit_boot = glm(@formula(lfp ~ lnnlinc + age + age^2 + educ + nyc + noc + foreign),\n",
    "                      df_boot, Binomial(), ProbitLink())\n",
    "    return (; (Symbol.(coefnames(probit_boot)) .=> coef(probit_boot))...)\n",
    "end"
   ]
  },
  {
   "cell_type": "code",
   "execution_count": 57,
   "id": "b01c3396",
   "metadata": {},
   "outputs": [
    {
     "name": "stdout",
     "output_type": "stream",
     "text": [
      "  1.797000 seconds (3.19 M allocations: 753.296 MiB, 9.10% gc time, 57.34% compilation time)\n"
     ]
    },
    {
     "data": {
      "text/plain": [
       "Bootstrap Sampling\n",
       "  Estimates:\n",
       "     Var │ Estimate    Bias         StdError\n",
       "         │ Float64     Float64      Float64\n",
       "    ─────┼────────────────────────────────────\n",
       "       1 │  3.74896     0.140457    1.40631\n",
       "       2 │ -0.666932   -0.0153319   0.129736\n",
       "       3 │  2.07531     0.0181637   0.425717\n",
       "       4 │ -0.294345   -0.00301596  0.0527653\n",
       "       5 │  0.0191963   0.00079884  0.0181964\n",
       "       6 │ -0.714465   -0.0113149   0.103201\n",
       "       7 │ -0.146985   -0.00136068  0.0522856\n",
       "       8 │  0.71438     0.00181945  0.12334\n",
       "  Sampling: BasicSampling\n",
       "  Samples:  1000\n",
       "  Data:     DataFrame: { 872 × 8 }\n"
      ]
     },
     "execution_count": 57,
     "metadata": {},
     "output_type": "execute_result"
    }
   ],
   "source": [
    "Random.seed!(1234)\n",
    "@time bs = bootstrap(boot_probit, df, BasicSampling(1000))"
   ]
  },
  {
   "cell_type": "code",
   "execution_count": 58,
   "id": "5875585d",
   "metadata": {},
   "outputs": [
    {
     "data": {
      "text/plain": [
       "((3.7489556492270046, 1.2412907300091576, 6.798729981241069), (-0.666931846730145, -0.947282535484641, -0.4431707323683804), (2.075310025309939, 1.2933397235685078, 2.984776234514459), (-0.29434520313637685, -0.4053753283179059, -0.19817960501825843), (0.019196260085104576, -0.015853977489616467, 0.05652693672034061), (-0.714464748168673, -0.9267794739575888, -0.525029649023962), (-0.1469845045078348, -0.2594938657967272, -0.05253327657352253), (0.7143798526957532, 0.4788791797099516, 0.961621530254209))"
      ]
     },
     "execution_count": 58,
     "metadata": {},
     "output_type": "execute_result"
    }
   ],
   "source": [
    "\n",
    "bs_ci = confint(bs, PercentileConfInt(0.95))"
   ]
  },
  {
   "cell_type": "code",
   "execution_count": 59,
   "id": "5e1c0b0b",
   "metadata": {},
   "outputs": [
    {
     "data": {
      "text/plain": [
       "8-element Vector{Tuple{Float64, Float64, Float64}}:\n",
       " (3.7489556492270046, 2.507664919217847, 3.049774332014064)\n",
       " (-0.666931846730145, 0.280350688754496, 0.22376111436176466)\n",
       " (2.075310025309939, 0.7819703017414312, 0.90946620920452)\n",
       " (-0.29434520313637685, 0.11103012518152905, 0.09616559811811842)\n",
       " (0.019196260085104576, 0.035050237574721047, 0.03733067663523604)\n",
       " (-0.714464748168673, 0.21231472578891575, 0.18943509914471102)\n",
       " (-0.1469845045078348, 0.11250936128889238, 0.09445122793431227)\n",
       " (0.7143798526957532, 0.23550067298580163, 0.24724167755845583)"
      ]
     },
     "execution_count": 59,
     "metadata": {},
     "output_type": "execute_result"
    }
   ],
   "source": [
    "conf_boot_t.bootstrap = [(ci[1], ci[1] - ci[2], ci[3] - ci[1]) for ci in bs_ci]"
   ]
  },
  {
   "cell_type": "code",
   "execution_count": 60,
   "id": "06d3358a",
   "metadata": {},
   "outputs": [
    {
     "data": {
      "text/html": [
       "<div class=\"data-frame\"><p>8 rows × 7 columns</p><table class=\"data-frame\"><thead><tr><th></th><th>statistic</th><th>estimate</th><th>boot lo</th><th>boot hi</th><th>parametric lo</th><th>parametric hi</th><th>bootstrap</th></tr><tr><th></th><th title=\"String\">String</th><th title=\"Float64\">Float64</th><th title=\"Float64\">Float64</th><th title=\"Float64\">Float64</th><th title=\"Float64\">Float64</th><th title=\"Float64\">Float64</th><th title=\"Tuple{Float64, Float64, Float64}\">Tuple…</th></tr></thead><tbody><tr><th>1</th><td>(Intercept)</td><td>3.74896</td><td>1.24129</td><td>0.699181</td><td>0.992006</td><td>0.992006</td><td>(3.74896, 2.50766, 3.04977)</td></tr><tr><th>2</th><td>lnnlinc</td><td>-0.666932</td><td>0.947283</td><td>0.890693</td><td>0.92549</td><td>0.92549</td><td>(-0.666932, 0.280351, 0.223761)</td></tr><tr><th>3</th><td>age</td><td>2.07531</td><td>1.29334</td><td>1.16584</td><td>1.28073</td><td>1.28073</td><td>(2.07531, 0.78197, 0.909466)</td></tr><tr><th>4</th><td>age ^ 2</td><td>-0.294345</td><td>0.405375</td><td>0.390511</td><td>0.392235</td><td>0.392235</td><td>(-0.294345, 0.11103, 0.0961656)</td></tr><tr><th>5</th><td>educ</td><td>0.0191963</td><td>0.015854</td><td>0.0181344</td><td>0.015937</td><td>0.015937</td><td>(0.0191963, 0.0350502, 0.0373307)</td></tr><tr><th>6</th><td>nyc</td><td>-0.714465</td><td>0.926779</td><td>0.9039</td><td>0.911238</td><td>0.911238</td><td>(-0.714465, 0.212315, 0.189435)</td></tr><tr><th>7</th><td>noc</td><td>-0.146985</td><td>0.259494</td><td>0.241436</td><td>0.246718</td><td>0.246718</td><td>(-0.146985, 0.112509, 0.0944512)</td></tr><tr><th>8</th><td>foreign: yes</td><td>0.71438</td><td>0.478879</td><td>0.467138</td><td>0.476589</td><td>0.476589</td><td>(0.71438, 0.235501, 0.247242)</td></tr></tbody></table></div>"
      ],
      "text/latex": [
       "\\begin{tabular}{r|ccccccc}\n",
       "\t& statistic & estimate & boot lo & boot hi & parametric lo & parametric hi & bootstrap\\\\\n",
       "\t\\hline\n",
       "\t& String & Float64 & Float64 & Float64 & Float64 & Float64 & Tuple…\\\\\n",
       "\t\\hline\n",
       "\t1 & (Intercept) & 3.74896 & 1.24129 & 0.699181 & 0.992006 & 0.992006 & (3.74896, 2.50766, 3.04977) \\\\\n",
       "\t2 & lnnlinc & -0.666932 & 0.947283 & 0.890693 & 0.92549 & 0.92549 & (-0.666932, 0.280351, 0.223761) \\\\\n",
       "\t3 & age & 2.07531 & 1.29334 & 1.16584 & 1.28073 & 1.28073 & (2.07531, 0.78197, 0.909466) \\\\\n",
       "\t4 & age \\^ 2 & -0.294345 & 0.405375 & 0.390511 & 0.392235 & 0.392235 & (-0.294345, 0.11103, 0.0961656) \\\\\n",
       "\t5 & educ & 0.0191963 & 0.015854 & 0.0181344 & 0.015937 & 0.015937 & (0.0191963, 0.0350502, 0.0373307) \\\\\n",
       "\t6 & nyc & -0.714465 & 0.926779 & 0.9039 & 0.911238 & 0.911238 & (-0.714465, 0.212315, 0.189435) \\\\\n",
       "\t7 & noc & -0.146985 & 0.259494 & 0.241436 & 0.246718 & 0.246718 & (-0.146985, 0.112509, 0.0944512) \\\\\n",
       "\t8 & foreign: yes & 0.71438 & 0.478879 & 0.467138 & 0.476589 & 0.476589 & (0.71438, 0.235501, 0.247242) \\\\\n",
       "\\end{tabular}\n"
      ],
      "text/plain": [
       "\u001b[1m8×7 DataFrame\u001b[0m\n",
       "\u001b[1m Row \u001b[0m│\u001b[1m statistic    \u001b[0m\u001b[1m estimate   \u001b[0m\u001b[1m boot lo  \u001b[0m\u001b[1m boot hi   \u001b[0m\u001b[1m parametric lo \u001b[0m\u001b[1m parametri\u001b[0m ⋯\n",
       "\u001b[1m     \u001b[0m│\u001b[90m String       \u001b[0m\u001b[90m Float64    \u001b[0m\u001b[90m Float64  \u001b[0m\u001b[90m Float64   \u001b[0m\u001b[90m Float64       \u001b[0m\u001b[90m Float64  \u001b[0m ⋯\n",
       "─────┼──────────────────────────────────────────────────────────────────────────\n",
       "   1 │ (Intercept)    3.74896    1.24129   0.699181        0.992006       0.99 ⋯\n",
       "   2 │ lnnlinc       -0.666932   0.947283  0.890693        0.92549        0.92\n",
       "   3 │ age            2.07531    1.29334   1.16584         1.28073        1.28\n",
       "   4 │ age ^ 2       -0.294345   0.405375  0.390511        0.392235       0.39\n",
       "   5 │ educ           0.0191963  0.015854  0.0181344       0.015937       0.01 ⋯\n",
       "   6 │ nyc           -0.714465   0.926779  0.9039          0.911238       0.91\n",
       "   7 │ noc           -0.146985   0.259494  0.241436        0.246718       0.24\n",
       "   8 │ foreign: yes   0.71438    0.478879  0.467138        0.476589       0.47\n",
       "\u001b[36m                                                               2 columns omitted\u001b[0m"
      ]
     },
     "execution_count": 60,
     "metadata": {},
     "output_type": "execute_result"
    }
   ],
   "source": [
    "conf_boot_t"
   ]
  },
  {
   "cell_type": "code",
   "execution_count": 61,
   "id": "88857c72",
   "metadata": {},
   "outputs": [
    {
     "data": {
      "text/html": [
       "<div class=\"data-frame\"><p>8 rows × 9 columns (omitted printing of 2 columns)</p><table class=\"data-frame\"><thead><tr><th></th><th>statistic</th><th>estimate</th><th>boot lo</th><th>boot hi</th><th>parametric lo</th><th>parametric hi</th><th>estimate 2</th></tr><tr><th></th><th title=\"String\">String</th><th title=\"Float64\">Float64</th><th title=\"Float64\">Float64</th><th title=\"Float64\">Float64</th><th title=\"Float64\">Float64</th><th title=\"Float64\">Float64</th><th title=\"Float64\">Float64</th></tr></thead><tbody><tr><th>1</th><td>(Intercept)</td><td>3.74896</td><td>1.24129</td><td>0.699181</td><td>0.992006</td><td>0.992006</td><td>3.74896</td></tr><tr><th>2</th><td>lnnlinc</td><td>-0.666932</td><td>0.947283</td><td>0.890693</td><td>0.92549</td><td>0.92549</td><td>-0.666932</td></tr><tr><th>3</th><td>age</td><td>2.07531</td><td>1.29334</td><td>1.16584</td><td>1.28073</td><td>1.28073</td><td>2.07531</td></tr><tr><th>4</th><td>age ^ 2</td><td>-0.294345</td><td>0.405375</td><td>0.390511</td><td>0.392235</td><td>0.392235</td><td>-0.294345</td></tr><tr><th>5</th><td>educ</td><td>0.0191963</td><td>0.015854</td><td>0.0181344</td><td>0.015937</td><td>0.015937</td><td>0.0191963</td></tr><tr><th>6</th><td>nyc</td><td>-0.714465</td><td>0.926779</td><td>0.9039</td><td>0.911238</td><td>0.911238</td><td>-0.714465</td></tr><tr><th>7</th><td>noc</td><td>-0.146985</td><td>0.259494</td><td>0.241436</td><td>0.246718</td><td>0.246718</td><td>-0.146985</td></tr><tr><th>8</th><td>foreign: yes</td><td>0.71438</td><td>0.478879</td><td>0.467138</td><td>0.476589</td><td>0.476589</td><td>0.71438</td></tr></tbody></table></div>"
      ],
      "text/latex": [
       "\\begin{tabular}{r|cccccccc}\n",
       "\t& statistic & estimate & boot lo & boot hi & parametric lo & parametric hi & estimate 2 & \\\\\n",
       "\t\\hline\n",
       "\t& String & Float64 & Float64 & Float64 & Float64 & Float64 & Float64 & \\\\\n",
       "\t\\hline\n",
       "\t1 & (Intercept) & 3.74896 & 1.24129 & 0.699181 & 0.992006 & 0.992006 & 3.74896 & $\\dots$ \\\\\n",
       "\t2 & lnnlinc & -0.666932 & 0.947283 & 0.890693 & 0.92549 & 0.92549 & -0.666932 & $\\dots$ \\\\\n",
       "\t3 & age & 2.07531 & 1.29334 & 1.16584 & 1.28073 & 1.28073 & 2.07531 & $\\dots$ \\\\\n",
       "\t4 & age \\^ 2 & -0.294345 & 0.405375 & 0.390511 & 0.392235 & 0.392235 & -0.294345 & $\\dots$ \\\\\n",
       "\t5 & educ & 0.0191963 & 0.015854 & 0.0181344 & 0.015937 & 0.015937 & 0.0191963 & $\\dots$ \\\\\n",
       "\t6 & nyc & -0.714465 & 0.926779 & 0.9039 & 0.911238 & 0.911238 & -0.714465 & $\\dots$ \\\\\n",
       "\t7 & noc & -0.146985 & 0.259494 & 0.241436 & 0.246718 & 0.246718 & -0.146985 & $\\dots$ \\\\\n",
       "\t8 & foreign: yes & 0.71438 & 0.478879 & 0.467138 & 0.476589 & 0.476589 & 0.71438 & $\\dots$ \\\\\n",
       "\\end{tabular}\n"
      ],
      "text/plain": [
       "\u001b[1m8×9 DataFrame\u001b[0m\n",
       "\u001b[1m Row \u001b[0m│\u001b[1m statistic    \u001b[0m\u001b[1m estimate   \u001b[0m\u001b[1m boot lo  \u001b[0m\u001b[1m boot hi   \u001b[0m\u001b[1m parametric lo \u001b[0m\u001b[1m parametri\u001b[0m ⋯\n",
       "\u001b[1m     \u001b[0m│\u001b[90m String       \u001b[0m\u001b[90m Float64    \u001b[0m\u001b[90m Float64  \u001b[0m\u001b[90m Float64   \u001b[0m\u001b[90m Float64       \u001b[0m\u001b[90m Float64  \u001b[0m ⋯\n",
       "─────┼──────────────────────────────────────────────────────────────────────────\n",
       "   1 │ (Intercept)    3.74896    1.24129   0.699181        0.992006       0.99 ⋯\n",
       "   2 │ lnnlinc       -0.666932   0.947283  0.890693        0.92549        0.92\n",
       "   3 │ age            2.07531    1.29334   1.16584         1.28073        1.28\n",
       "   4 │ age ^ 2       -0.294345   0.405375  0.390511        0.392235       0.39\n",
       "   5 │ educ           0.0191963  0.015854  0.0181344       0.015937       0.01 ⋯\n",
       "   6 │ nyc           -0.714465   0.926779  0.9039          0.911238       0.91\n",
       "   7 │ noc           -0.146985   0.259494  0.241436        0.246718       0.24\n",
       "   8 │ foreign: yes   0.71438    0.478879  0.467138        0.476589       0.47\n",
       "\u001b[36m                                                               4 columns omitted\u001b[0m"
      ]
     },
     "execution_count": 61,
     "metadata": {},
     "output_type": "execute_result"
    }
   ],
   "source": [
    "select!(conf_boot_t, Not(:bootstrap), :bootstrap => [\"estimate 2\", \"boot lo 2\", \"boot hi 2\"])"
   ]
  },
  {
   "cell_type": "code",
   "execution_count": 62,
   "id": "7243dc3f",
   "metadata": {},
   "outputs": [
    {
     "data": {
      "text/html": [
       "<div class=\"data-frame\"><p>8 rows × 9 columns (omitted printing of 2 columns)</p><table class=\"data-frame\"><thead><tr><th></th><th>statistic</th><th>estimate</th><th>estimate 2</th><th>boot lo</th><th>parametric lo</th><th>boot lo 2</th><th>boot hi</th></tr><tr><th></th><th title=\"String\">String</th><th title=\"Float64\">Float64</th><th title=\"Float64\">Float64</th><th title=\"Float64\">Float64</th><th title=\"Float64\">Float64</th><th title=\"Float64\">Float64</th><th title=\"Float64\">Float64</th></tr></thead><tbody><tr><th>1</th><td>(Intercept)</td><td>3.74896</td><td>3.74896</td><td>1.24129</td><td>0.992006</td><td>2.50766</td><td>0.699181</td></tr><tr><th>2</th><td>lnnlinc</td><td>-0.666932</td><td>-0.666932</td><td>0.947283</td><td>0.92549</td><td>0.280351</td><td>0.890693</td></tr><tr><th>3</th><td>age</td><td>2.07531</td><td>2.07531</td><td>1.29334</td><td>1.28073</td><td>0.78197</td><td>1.16584</td></tr><tr><th>4</th><td>age ^ 2</td><td>-0.294345</td><td>-0.294345</td><td>0.405375</td><td>0.392235</td><td>0.11103</td><td>0.390511</td></tr><tr><th>5</th><td>educ</td><td>0.0191963</td><td>0.0191963</td><td>0.015854</td><td>0.015937</td><td>0.0350502</td><td>0.0181344</td></tr><tr><th>6</th><td>nyc</td><td>-0.714465</td><td>-0.714465</td><td>0.926779</td><td>0.911238</td><td>0.212315</td><td>0.9039</td></tr><tr><th>7</th><td>noc</td><td>-0.146985</td><td>-0.146985</td><td>0.259494</td><td>0.246718</td><td>0.112509</td><td>0.241436</td></tr><tr><th>8</th><td>foreign: yes</td><td>0.71438</td><td>0.71438</td><td>0.478879</td><td>0.476589</td><td>0.235501</td><td>0.467138</td></tr></tbody></table></div>"
      ],
      "text/latex": [
       "\\begin{tabular}{r|cccccccc}\n",
       "\t& statistic & estimate & estimate 2 & boot lo & parametric lo & boot lo 2 & boot hi & \\\\\n",
       "\t\\hline\n",
       "\t& String & Float64 & Float64 & Float64 & Float64 & Float64 & Float64 & \\\\\n",
       "\t\\hline\n",
       "\t1 & (Intercept) & 3.74896 & 3.74896 & 1.24129 & 0.992006 & 2.50766 & 0.699181 & $\\dots$ \\\\\n",
       "\t2 & lnnlinc & -0.666932 & -0.666932 & 0.947283 & 0.92549 & 0.280351 & 0.890693 & $\\dots$ \\\\\n",
       "\t3 & age & 2.07531 & 2.07531 & 1.29334 & 1.28073 & 0.78197 & 1.16584 & $\\dots$ \\\\\n",
       "\t4 & age \\^ 2 & -0.294345 & -0.294345 & 0.405375 & 0.392235 & 0.11103 & 0.390511 & $\\dots$ \\\\\n",
       "\t5 & educ & 0.0191963 & 0.0191963 & 0.015854 & 0.015937 & 0.0350502 & 0.0181344 & $\\dots$ \\\\\n",
       "\t6 & nyc & -0.714465 & -0.714465 & 0.926779 & 0.911238 & 0.212315 & 0.9039 & $\\dots$ \\\\\n",
       "\t7 & noc & -0.146985 & -0.146985 & 0.259494 & 0.246718 & 0.112509 & 0.241436 & $\\dots$ \\\\\n",
       "\t8 & foreign: yes & 0.71438 & 0.71438 & 0.478879 & 0.476589 & 0.235501 & 0.467138 & $\\dots$ \\\\\n",
       "\\end{tabular}\n"
      ],
      "text/plain": [
       "\u001b[1m8×9 DataFrame\u001b[0m\n",
       "\u001b[1m Row \u001b[0m│\u001b[1m statistic    \u001b[0m\u001b[1m estimate   \u001b[0m\u001b[1m estimate 2 \u001b[0m\u001b[1m boot lo  \u001b[0m\u001b[1m parametric lo \u001b[0m\u001b[1m boot lo \u001b[0m ⋯\n",
       "\u001b[1m     \u001b[0m│\u001b[90m String       \u001b[0m\u001b[90m Float64    \u001b[0m\u001b[90m Float64    \u001b[0m\u001b[90m Float64  \u001b[0m\u001b[90m Float64       \u001b[0m\u001b[90m Float64 \u001b[0m ⋯\n",
       "─────┼──────────────────────────────────────────────────────────────────────────\n",
       "   1 │ (Intercept)    3.74896     3.74896    1.24129        0.992006  2.50766  ⋯\n",
       "   2 │ lnnlinc       -0.666932   -0.666932   0.947283       0.92549   0.280351\n",
       "   3 │ age            2.07531     2.07531    1.29334        1.28073   0.78197\n",
       "   4 │ age ^ 2       -0.294345   -0.294345   0.405375       0.392235  0.11103\n",
       "   5 │ educ           0.0191963   0.0191963  0.015854       0.015937  0.035050 ⋯\n",
       "   6 │ nyc           -0.714465   -0.714465   0.926779       0.911238  0.212315\n",
       "   7 │ noc           -0.146985   -0.146985   0.259494       0.246718  0.112509\n",
       "   8 │ foreign: yes   0.71438     0.71438    0.478879       0.476589  0.235501\n",
       "\u001b[36m                                                               4 columns omitted\u001b[0m"
      ]
     },
     "execution_count": 62,
     "metadata": {},
     "output_type": "execute_result"
    }
   ],
   "source": [
    "select(conf_boot_t, :statistic, r\"estimate\", r\"lo\", r\"hi\")"
   ]
  },
  {
   "cell_type": "code",
   "execution_count": 63,
   "id": "5ccad298",
   "metadata": {},
   "outputs": [
    {
     "data": {
      "text/html": [
       "<div class=\"data-frame\"><p>8 rows × 9 columns (omitted printing of 2 columns)</p><table class=\"data-frame\"><thead><tr><th></th><th>statistic</th><th>estimate</th><th>boot lo</th><th>boot hi</th><th>parametric lo</th><th>parametric hi</th><th>estimate 2</th></tr><tr><th></th><th title=\"String\">String</th><th title=\"Float64\">Float64</th><th title=\"Float64\">Float64</th><th title=\"Float64\">Float64</th><th title=\"Float64\">Float64</th><th title=\"Float64\">Float64</th><th title=\"Float64\">Float64</th></tr></thead><tbody><tr><th>1</th><td>nyc</td><td>-0.714465</td><td>0.926779</td><td>0.9039</td><td>0.911238</td><td>0.911238</td><td>-0.714465</td></tr><tr><th>2</th><td>lnnlinc</td><td>-0.666932</td><td>0.947283</td><td>0.890693</td><td>0.92549</td><td>0.92549</td><td>-0.666932</td></tr><tr><th>3</th><td>age ^ 2</td><td>-0.294345</td><td>0.405375</td><td>0.390511</td><td>0.392235</td><td>0.392235</td><td>-0.294345</td></tr><tr><th>4</th><td>noc</td><td>-0.146985</td><td>0.259494</td><td>0.241436</td><td>0.246718</td><td>0.246718</td><td>-0.146985</td></tr><tr><th>5</th><td>educ</td><td>0.0191963</td><td>0.015854</td><td>0.0181344</td><td>0.015937</td><td>0.015937</td><td>0.0191963</td></tr><tr><th>6</th><td>foreign: yes</td><td>0.71438</td><td>0.478879</td><td>0.467138</td><td>0.476589</td><td>0.476589</td><td>0.71438</td></tr><tr><th>7</th><td>age</td><td>2.07531</td><td>1.29334</td><td>1.16584</td><td>1.28073</td><td>1.28073</td><td>2.07531</td></tr><tr><th>8</th><td>(Intercept)</td><td>3.74896</td><td>1.24129</td><td>0.699181</td><td>0.992006</td><td>0.992006</td><td>3.74896</td></tr></tbody></table></div>"
      ],
      "text/latex": [
       "\\begin{tabular}{r|cccccccc}\n",
       "\t& statistic & estimate & boot lo & boot hi & parametric lo & parametric hi & estimate 2 & \\\\\n",
       "\t\\hline\n",
       "\t& String & Float64 & Float64 & Float64 & Float64 & Float64 & Float64 & \\\\\n",
       "\t\\hline\n",
       "\t1 & nyc & -0.714465 & 0.926779 & 0.9039 & 0.911238 & 0.911238 & -0.714465 & $\\dots$ \\\\\n",
       "\t2 & lnnlinc & -0.666932 & 0.947283 & 0.890693 & 0.92549 & 0.92549 & -0.666932 & $\\dots$ \\\\\n",
       "\t3 & age \\^ 2 & -0.294345 & 0.405375 & 0.390511 & 0.392235 & 0.392235 & -0.294345 & $\\dots$ \\\\\n",
       "\t4 & noc & -0.146985 & 0.259494 & 0.241436 & 0.246718 & 0.246718 & -0.146985 & $\\dots$ \\\\\n",
       "\t5 & educ & 0.0191963 & 0.015854 & 0.0181344 & 0.015937 & 0.015937 & 0.0191963 & $\\dots$ \\\\\n",
       "\t6 & foreign: yes & 0.71438 & 0.478879 & 0.467138 & 0.476589 & 0.476589 & 0.71438 & $\\dots$ \\\\\n",
       "\t7 & age & 2.07531 & 1.29334 & 1.16584 & 1.28073 & 1.28073 & 2.07531 & $\\dots$ \\\\\n",
       "\t8 & (Intercept) & 3.74896 & 1.24129 & 0.699181 & 0.992006 & 0.992006 & 3.74896 & $\\dots$ \\\\\n",
       "\\end{tabular}\n"
      ],
      "text/plain": [
       "\u001b[1m8×9 DataFrame\u001b[0m\n",
       "\u001b[1m Row \u001b[0m│\u001b[1m statistic    \u001b[0m\u001b[1m estimate   \u001b[0m\u001b[1m boot lo  \u001b[0m\u001b[1m boot hi   \u001b[0m\u001b[1m parametric lo \u001b[0m\u001b[1m parametri\u001b[0m ⋯\n",
       "\u001b[1m     \u001b[0m│\u001b[90m String       \u001b[0m\u001b[90m Float64    \u001b[0m\u001b[90m Float64  \u001b[0m\u001b[90m Float64   \u001b[0m\u001b[90m Float64       \u001b[0m\u001b[90m Float64  \u001b[0m ⋯\n",
       "─────┼──────────────────────────────────────────────────────────────────────────\n",
       "   1 │ nyc           -0.714465   0.926779  0.9039          0.911238       0.91 ⋯\n",
       "   2 │ lnnlinc       -0.666932   0.947283  0.890693        0.92549        0.92\n",
       "   3 │ age ^ 2       -0.294345   0.405375  0.390511        0.392235       0.39\n",
       "   4 │ noc           -0.146985   0.259494  0.241436        0.246718       0.24\n",
       "   5 │ educ           0.0191963  0.015854  0.0181344       0.015937       0.01 ⋯\n",
       "   6 │ foreign: yes   0.71438    0.478879  0.467138        0.476589       0.47\n",
       "   7 │ age            2.07531    1.29334   1.16584         1.28073        1.28\n",
       "   8 │ (Intercept)    3.74896    1.24129   0.699181        0.992006       0.99\n",
       "\u001b[36m                                                               4 columns omitted\u001b[0m"
      ]
     },
     "execution_count": 63,
     "metadata": {},
     "output_type": "execute_result"
    }
   ],
   "source": [
    "sort(conf_boot_t, :estimate)"
   ]
  },
  {
   "cell_type": "code",
   "execution_count": 64,
   "id": "47dba45f",
   "metadata": {},
   "outputs": [
    {
     "data": {
      "text/html": [
       "<div class=\"data-frame\"><p>8 rows × 9 columns (omitted printing of 2 columns)</p><table class=\"data-frame\"><thead><tr><th></th><th>statistic</th><th>estimate</th><th>boot lo</th><th>boot hi</th><th>parametric lo</th><th>parametric hi</th><th>estimate 2</th></tr><tr><th></th><th title=\"String\">String</th><th title=\"Float64\">Float64</th><th title=\"Float64\">Float64</th><th title=\"Float64\">Float64</th><th title=\"Float64\">Float64</th><th title=\"Float64\">Float64</th><th title=\"Float64\">Float64</th></tr></thead><tbody><tr><th>1</th><td>educ</td><td>0.0191963</td><td>0.015854</td><td>0.0181344</td><td>0.015937</td><td>0.015937</td><td>0.0191963</td></tr><tr><th>2</th><td>noc</td><td>-0.146985</td><td>0.259494</td><td>0.241436</td><td>0.246718</td><td>0.246718</td><td>-0.146985</td></tr><tr><th>3</th><td>age ^ 2</td><td>-0.294345</td><td>0.405375</td><td>0.390511</td><td>0.392235</td><td>0.392235</td><td>-0.294345</td></tr><tr><th>4</th><td>foreign: yes</td><td>0.71438</td><td>0.478879</td><td>0.467138</td><td>0.476589</td><td>0.476589</td><td>0.71438</td></tr><tr><th>5</th><td>nyc</td><td>-0.714465</td><td>0.926779</td><td>0.9039</td><td>0.911238</td><td>0.911238</td><td>-0.714465</td></tr><tr><th>6</th><td>lnnlinc</td><td>-0.666932</td><td>0.947283</td><td>0.890693</td><td>0.92549</td><td>0.92549</td><td>-0.666932</td></tr><tr><th>7</th><td>(Intercept)</td><td>3.74896</td><td>1.24129</td><td>0.699181</td><td>0.992006</td><td>0.992006</td><td>3.74896</td></tr><tr><th>8</th><td>age</td><td>2.07531</td><td>1.29334</td><td>1.16584</td><td>1.28073</td><td>1.28073</td><td>2.07531</td></tr></tbody></table></div>"
      ],
      "text/latex": [
       "\\begin{tabular}{r|cccccccc}\n",
       "\t& statistic & estimate & boot lo & boot hi & parametric lo & parametric hi & estimate 2 & \\\\\n",
       "\t\\hline\n",
       "\t& String & Float64 & Float64 & Float64 & Float64 & Float64 & Float64 & \\\\\n",
       "\t\\hline\n",
       "\t1 & educ & 0.0191963 & 0.015854 & 0.0181344 & 0.015937 & 0.015937 & 0.0191963 & $\\dots$ \\\\\n",
       "\t2 & noc & -0.146985 & 0.259494 & 0.241436 & 0.246718 & 0.246718 & -0.146985 & $\\dots$ \\\\\n",
       "\t3 & age \\^ 2 & -0.294345 & 0.405375 & 0.390511 & 0.392235 & 0.392235 & -0.294345 & $\\dots$ \\\\\n",
       "\t4 & foreign: yes & 0.71438 & 0.478879 & 0.467138 & 0.476589 & 0.476589 & 0.71438 & $\\dots$ \\\\\n",
       "\t5 & nyc & -0.714465 & 0.926779 & 0.9039 & 0.911238 & 0.911238 & -0.714465 & $\\dots$ \\\\\n",
       "\t6 & lnnlinc & -0.666932 & 0.947283 & 0.890693 & 0.92549 & 0.92549 & -0.666932 & $\\dots$ \\\\\n",
       "\t7 & (Intercept) & 3.74896 & 1.24129 & 0.699181 & 0.992006 & 0.992006 & 3.74896 & $\\dots$ \\\\\n",
       "\t8 & age & 2.07531 & 1.29334 & 1.16584 & 1.28073 & 1.28073 & 2.07531 & $\\dots$ \\\\\n",
       "\\end{tabular}\n"
      ],
      "text/plain": [
       "\u001b[1m8×9 DataFrame\u001b[0m\n",
       "\u001b[1m Row \u001b[0m│\u001b[1m statistic    \u001b[0m\u001b[1m estimate   \u001b[0m\u001b[1m boot lo  \u001b[0m\u001b[1m boot hi   \u001b[0m\u001b[1m parametric lo \u001b[0m\u001b[1m parametri\u001b[0m ⋯\n",
       "\u001b[1m     \u001b[0m│\u001b[90m String       \u001b[0m\u001b[90m Float64    \u001b[0m\u001b[90m Float64  \u001b[0m\u001b[90m Float64   \u001b[0m\u001b[90m Float64       \u001b[0m\u001b[90m Float64  \u001b[0m ⋯\n",
       "─────┼──────────────────────────────────────────────────────────────────────────\n",
       "   1 │ educ           0.0191963  0.015854  0.0181344       0.015937       0.01 ⋯\n",
       "   2 │ noc           -0.146985   0.259494  0.241436        0.246718       0.24\n",
       "   3 │ age ^ 2       -0.294345   0.405375  0.390511        0.392235       0.39\n",
       "   4 │ foreign: yes   0.71438    0.478879  0.467138        0.476589       0.47\n",
       "   5 │ nyc           -0.714465   0.926779  0.9039          0.911238       0.91 ⋯\n",
       "   6 │ lnnlinc       -0.666932   0.947283  0.890693        0.92549        0.92\n",
       "   7 │ (Intercept)    3.74896    1.24129   0.699181        0.992006       0.99\n",
       "   8 │ age            2.07531    1.29334   1.16584         1.28073        1.28\n",
       "\u001b[36m                                                               4 columns omitted\u001b[0m"
      ]
     },
     "execution_count": 64,
     "metadata": {},
     "output_type": "execute_result"
    }
   ],
   "source": [
    "conf_boot_t[sortperm(conf_boot_t.\"boot hi\" + conf_boot_t.\"boot lo\"), :]"
   ]
  },
  {
   "cell_type": "code",
   "execution_count": null,
   "id": "16ddc61e",
   "metadata": {},
   "outputs": [],
   "source": []
  }
 ],
 "metadata": {
  "kernelspec": {
   "display_name": "Julia 1.7.1",
   "language": "julia",
   "name": "julia-1.7"
  },
  "language_info": {
   "file_extension": ".jl",
   "mimetype": "application/julia",
   "name": "julia",
   "version": "1.7.1"
  }
 },
 "nbformat": 4,
 "nbformat_minor": 5
}
