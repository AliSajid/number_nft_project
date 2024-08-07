// SPDX-FileCopyrightText: 2024 Ali Sajid Imami
//
// SPDX-License-Identifier: MIT

import { HardhatUserConfig } from 'hardhat/config';
import '@nomicfoundation/hardhat-toolbox';
import '@nomiclabs/hardhat-ethers';
import '@nomiclabs/hardhat-waffle';

const config: HardhatUserConfig = {
    solidity: '0.8.24',
    paths: {
        sources: './contracts',
        tests: './test',
        cache: './cache',
        artifacts: '../number_nft_frontend/src/lib/contracts'
    }
};

export default config;
