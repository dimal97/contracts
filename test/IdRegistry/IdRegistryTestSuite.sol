// SPDX-License-Identifier: UNLICENSED
pragma solidity 0.8.18;

import "forge-std/Test.sol";

import {IdRegistryHarness} from "../Utils.sol";

/* solhint-disable state-visibility */

abstract contract IdRegistryTestSuite is Test {
    IdRegistryHarness idRegistry;

    /*//////////////////////////////////////////////////////////////
                                CONSTANTS
    //////////////////////////////////////////////////////////////*/

    address constant FORWARDER = address(0xC8223c8AD514A19Cc10B0C94c39b52D4B43ee61A);

    address owner = address(this);

    function setUp() public {
        idRegistry = new IdRegistryHarness(FORWARDER);
    }

    /*//////////////////////////////////////////////////////////////
                              TEST HELPERS
    //////////////////////////////////////////////////////////////*/

    function _register(address caller) internal {
        _registerWithRecovery(caller, address(0));
    }

    function _registerWithRecovery(address caller, address recovery) internal {
        idRegistry.disableTrustedOnly();
        vm.prank(caller);
        idRegistry.register(caller, recovery);
    }

    function _assertNoRecoveryState(uint256 fid) internal {
        assertEq(idRegistry.getRecoveryTsOf(fid), 0);
        assertEq(idRegistry.getRecoveryDestinationOf(fid), address(0));
    }
}
