"""
script which assigns a proper device core function based on a flag ('cpu' or 'gpu')
"""

from ccpi.filters.cpu_regularisers_cython import TV_ROF_CPU, TV_FGP_CPU, dTV_FGP_CPU
from ccpi.filters.gpu_regularisers import TV_ROF_GPU, TV_FGP_GPU, dTV_FGP_GPU

def ROF_TV(inputData, regularisation_parameter, iterations,
                     time_marching_parameter,device='cpu'):
    if device == 'cpu':
        return TV_ROF_CPU(inputData,
                     regularisation_parameter,
                     iterations, 
                     time_marching_parameter)
    elif device == 'gpu':
        return TV_ROF_GPU(inputData,
                     regularisation_parameter,
                     iterations, 
                     time_marching_parameter)
    else:
        raise ValueError('Unknown device {0}. Expecting gpu or cpu'\
                         .format(device))

def FGP_TV(inputData, regularisation_parameter,iterations,
                     tolerance_param, methodTV, nonneg, printM, device='cpu'):
    if device == 'cpu':
        return TV_FGP_CPU(inputData,
                     regularisation_parameter,
                     iterations, 
                     tolerance_param,
                     methodTV,
                     nonneg,
                     printM)
    elif device == 'gpu':
        return TV_FGP_GPU(inputData,
                     regularisation_parameter,
                     iterations, 
                     tolerance_param,
                     methodTV,
                     nonneg,
                     printM)
    else:
        raise ValueError('Unknown device {0}. Expecting gpu or cpu'\
                         .format(device))
def FGP_dTV(inputData, refdata, regularisation_parameter, iterations,
                     tolerance_param, eta_const, methodTV, nonneg, printM, device='cpu'):
    if device == 'cpu':
        return dTV_FGP_CPU(inputData,
                     refdata,
                     regularisation_parameter,
                     iterations, 
                     tolerance_param,
                     eta_const,
                     methodTV,
                     nonneg,
                     printM)
    elif device == 'gpu':
        return dTV_FGP_GPU(inputData,
                     refdata,
                     regularisation_parameter,
                     iterations, 
                     tolerance_param,
                     eta_const,
                     methodTV,
                     nonneg,
                     printM)
    else:
        raise ValueError('Unknown device {0}. Expecting gpu or cpu'\
                         .format(device))