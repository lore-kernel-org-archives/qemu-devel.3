Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A3653EF48CA
	for <qemu-devel@archiver.kernel.org>; Fri, 13 Feb 2026 06:07:33 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vqmKi-0004MY-5z; Fri, 13 Feb 2026 01:07:17 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1vqmKb-0004Is-Je; Fri, 13 Feb 2026 01:07:12 -0500
Received: from isrv.corpit.ru ([212.248.84.144])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1vqmKY-0001N5-VX; Fri, 13 Feb 2026 01:07:09 -0500
Received: from tsrv.corpit.ru (tsrv.tls.msk.ru [192.168.177.2])
 by isrv.corpit.ru (Postfix) with ESMTP id 3BD35188BFA;
 Fri, 13 Feb 2026 09:07:02 +0300 (MSK)
Received: from think4mjt.tls.msk.ru (mjtthink.wg.tls.msk.ru [192.168.177.146])
 by tsrv.corpit.ru (Postfix) with ESMTP id 4C0AD363994;
 Fri, 13 Feb 2026 09:07:05 +0300 (MSK)
From: Michael Tokarev <mjt@tls.msk.ru>
To: qemu-devel@nongnu.org
Cc: Michael Tokarev <mjt@tls.msk.ru>,
	qemu-stable@nongnu.org
Subject: [ANNOUNCE] QEMU 10.1.4 Stable released
Date: Fri, 13 Feb 2026 09:07:01 +0300
Message-ID: <20260213060704.200732-1-mjt@tls.msk.ru>
X-Mailer: git-send-email 2.47.3
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=212.248.84.144; envelope-from=mjt@tls.msk.ru;
 helo=isrv.corpit.ru
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

Hi everyone,

The QEMU v10.1.4 stable release is now available.

You can grab the tarball from our download page here:

  https://www.qemu.org/download/#source

  https://download.qemu.org/qemu-10.1.4.tar.xz
  https://download.qemu.org/qemu-10.1.4.tar.xz.sig (signature)

v10.1.4 is now tagged in the official qemu.git repository, and the
stable-10.1 branch has been updated accordingly:

  https://gitlab.com/qemu-project/qemu/-/commits/stable-10.1

There are 95 changes since the previous v10.1.3 release.

Thank you everyone who has been involved and helped with the stable series!

/mjt

Changelog (stable-10.1-hash master-hash Author Name: Commmit-Subject):

384ba786ab Michael Tokarev:
 Update version for 10.1.4 release
5323c1b9e6 80c97930a9 Andrey Drobyshev:
 scripts/qemugdb: timers: Fix KeyError in 'qemu timers' command
2a4209ee94 d22e9aec57 Aleksandr Sergeev:
 linux-user/syscall.c: Prevent acquiring clone_lock while fork()
25d3fa6367 25465c0e1f Jonathan Cameron:
 hw/cxl: Take into account how many media operations are requested for param check
36c85f19e1 87f8e5a71d Jonathan Cameron:
 hw/cxl: Check for overflow on santize media as both base and offset 64bit.
fc186fdb6a 3560b51979 Honglei Huang:
 virtio-gpu: fix error handling in virgl_cmd_resource_create_blob
21500ffad2 efd581a8cd Li Chen:
 virtio-pmem: ignore empty queue notifications
da9b1cd37f e27194e087 Joelle van Dyne:
 virtio-gpu-virgl: correct parent for blob memory region
95aac32313 7b913094c7 zhenwei pi:
 cryptodev-builtin: Limit the maximum size
1ea1baa5c8 91c6438caf zhenwei pi:
 hw/virtio/virtio-crypto: verify asym request size
259da6b08f 66cf169e29 Igor Mammedov:
 q35: Fix migration of SMRAM state
0901e4379f f73e5ed9bc Kevin Wolf:
 pcie_sriov: Fix PCI_SRIOV_* accesses in pcie_sriov_pf_exit()
dbb6465a08 623db85647 Kevin Wolf:
 virtio: Fix crash when sriov-pf is set for non-PCI-Express device
88d40c0578 fff77cfb84 Dorinda Bassey:
 virtio-dmabuf: Ensure UUID persistence for hash table insertion
5e40faac9c fd3a2c601a Wafer Xie:
 vdpa: fix vhost-vdpa suspended state not be shared
ea4be299f0 efea7ddb46 Jamin Lin:
 hw/i2c/aspeed_i2c: Fix DMA moving data into incorrect address
6af4aff205 9cbd8ee7f6 Jamin Lin:
 hw/i2c/aspeed: Fix wrong I2CC_DMA_LEN when I2CM_DMA_TX/RX_ADDR set first
1b107b64b8 7d64f04863 Jamin Lin:
 hw/arm/aspeed_ast27x0: Fix EHCI3/4 IRQ routing to GIC
2cf4cbc011 0a1d477067 Nabih Estefan:
 hw/i2c/aspeed_i2c.c: Add a check for dma_read
4bad6c7c9e 4c6521296d Cédric Le Goater:
 hw/adc: Fix out-of-bounds write in Aspeed ADC model
d7500e1259 46dee71a94 Gerd Hoffmann:
 hw/uefi: fix size negotiation
46853d7d3a eda9baa17a Akihiko Odaki:
 hw/nvme: Fix bootindex suffix use-after-free
de302beabe 587f4a1805 John Snow:
 python: fix msys64 wheel directory specification
4a08de6d46 94e72135d4 Ilia Levi:
 tests/qtest/ufs-test: Add test for mcq completion queue wraparound
4093551fdb f78762a3cc Ilia Levi:
 hw/ufs: Fix mcq completion queue wraparound
e4ccceaa34 ed621cc8e2 Jeuk Kim:
 hw/ufs: fix CQE endianness and UPIU length
43539aeaf6 289e6a3edf Jeuk Kim:
 hw/ufs: Ensure DBC of PRDT uses only lower 18 bits
5594fe1415 d9ca273f8f Alex Bennée:
 tests/functional: migrate sbsa_ref test images
6e47285707 e4f1a9b1da Thomas Huth:
 pc-bios/optionrom: Use 32-bit linker emulation for the optionroms
356f4bf499 2eb8d97343 Paolo Bonzini:
 target/i386/tcg: fix a few instructions that do not support VEX.L=1
c35df6aa24 d68f0e2e90 Icenowy Zheng:
 linux-user: fixup termios2 related things on PowerPC
ad62f095c3 4f22fcb5c6 Vivian Wang:
 linux-user: Add missing termios baud rates
790d4660c7 947b971cad Luca Bonissi:
 linux-user: Add termios2 support to sparc target
b2ae0dfc9f afbe0ff81c Luca Bonissi:
 linux-user: Add termios2 support to sh4 target
ed70cb9917 edf9184f4f Luca Bonissi:
 linux-user: Add termios2 support to mips target
64c435a412 edc741710a Luca Bonissi:
 linux-user: Add termios2 support to hppa target
d56a471701 8d8c6aeee8 Luca Bonissi:
 linux-user: Add termios2 support to alpha target
b4fdd67021 e9a8a10e84 Luca Bonissi:
 linux-user: Add termios2 support
000dc91c0e cf10273aff Alex Bennée:
 hw/intc: avoid byte swap fiddling in gicv3 its path
3b0b8f0193 f0de58ccf6 Pierrick Bouvier:
 bsd-user/syscall_defs.h: define STAT_TIME_T_EXT only for 32 bits
374bf44ecc 369c1ba2b7 Richard Henderson:
 bsd-user: Fix __i386__ test for TARGET_HAS_STAT_TIME_T_EXT
aef41c4cd1 214f79fdfb Bernhard Beschow:
 hw/sd/sdhci: Fix TYPE_IMX_USDHC to implement sd-spec-version 3 by default
48c61c2efb 83017c4aaa Pierrick Bouvier:
 linux-user/aarch64/target_fcntl.h: add missing TARGET_O_LARGEFILE definition
9945f966c6 290e4e7de7 Philippe Mathieu-Daudé:
 tests/functional: Mark another MIPS replay test as flaky
2b873575d3 1c11aa1807 Philippe Mathieu-Daudé:
 tests/functional: Mark the MIPS replay tests as flaky
56943614f2 7be4256281 Philippe Mathieu-Daudé:
 accel/nvmm: Fix 'cpu' typo in nvmm_init_vcpu()
ac167f2f9d b67a35622f Peter Maydell:
 target/arm: Correctly trap HCR.TID1 registers in v7A
d32a6bdf2e 205ca535ab Peter Maydell:
 target/arm: Correctly honour HCR.TID3 for v7A cores
c9ac53e1d4 8da52b8401 Peter Maydell:
 target/arm: Don't specify ID_PFR1 accessfn twice
a246fac13b 7cf096d609 Alex Bennée:
 tests/functional: migrate aspeed_rainier image
86b3d39699 49ee001a5b Yao Zi:
 hw/loongarch/virt: Don't abort on access to unimplemented IOCSR
469308eeb8 a7be2e0a3f Song Gao:
 target/loongarch: Fix exception ADEF/ADEM missing to update CSR_BADV
47f5eb44e3 e4f0ef58d5 Song Gao:
 target/loongarch: Fix exception BCE missing to update CSR_BADV
e39caabd23 70cf9b7bf7 Song Gao:
 target/loongach: Fix some exceptions failure in updating CSR_BADV
4f702110f4 ff54394eed Xianglai Li:
 hw/loongarch/virt: Fix irq allocation failure with pci device from fdt
eb6ec3d5a8 47de28a0b7 Xianglai Li:
 hw/loongarch/virt: Modify the interrupt trigger type in fdt table
43fd7e29ba c7504ba2a5 Vulnerability Report:
 hw/i386/kvm: fix PIRQ bounds check in xen_physdev_map_pirq()
2a57020689 ed88bdcfbd Paolo Bonzini:
 target/i386/tcg: allow VEX in 16-bit protected mode
766c34ccf5 5e3572ef2e Paolo Bonzini:
 target/i386/tcg: mask addresses for VSIB
bd792679ca 73dd6e4a36 Paolo Bonzini:
 target/i386/tcg: do not mark all SSE instructions as unaligned
768ad6c12c 11dac41f2e Laurent Vivier:
 m68k: fix CAS2 writeback when Dc1=�2
827c5bfe33 894c8bd56f Paolo Bonzini:
 configs: use default prefix for Windows compilation
c51a959081 628bda1ab7 Fabiano Rosas:
 target/ppc: Fix env->quiesced migration
4ec12db86e 9290c10ae9 Matthew Lugg:
 tests: add tcg coverage for fixed mremap bugs
3ef571a4da 81ceab3049 Matthew Lugg:
 linux-user: fix reserved_va page leak in do_munmap
1f65eb3d5d 2422884ec5 Matthew Lugg:
 linux-user: fix mremap errors for invalid ranges
1b5caf073f aaed9ca179 Matthew Lugg:
 linux-user: fix mremap unmapping adjacent region
48437a384a 82ae60c8b5 Jean-Christian CÎRSTEA:
 linux-user: allow null `pathname` for statx()/fstatat()
944741cfa5 af6db3b713 Richard Henderson:
 tcg/riscv: Fix TCG_REG_TMP0 clobber in tcg_gen_dup{m,i}
e0842a3275 23b53ec3a8 Paolo Bonzini:
 tcg/optimize: Do use affected bits
ccb199fc95 08b12bfb8f Richard Henderson:
 tcg/optimize: Fix a_mask computation for orc
f71aca857a 7d2d577de0 Richard Henderson:
 tcg/optimize: Save o_mask in fold_masks_zosa_int
020288b092 e714f1a3d4 Jie Song:
 monitor/qmp: cleanup SocketChardev listener sources early to avoid fd handling race
32a8e10684 75bcfb98a1 Cédric Le Goater:
 tests/functional: Fix URL of gb200nvl-bmc image
832f421978 3fbadbb392 Alano Song:
 hw/i2c/imx: Fix trace func name error
4029ff773e 0db1b556e4 Paolo Bonzini:
 target/i386/tcg: ignore V3 in 32-bit mode
82a3e0c6f9 60efba3c1b Andrew Cooper:
 target/i386: Fix #GP error code for INT instructions
ede2f1e49c 00829ae384 Zesen Liu:
 qdev: fix error handling in set_uint64_checkmask
05836f5f81 d7e1df7699 Cédric Le Goater:
 gdbstub: Fix const qualifier build errors with recent glibc
d15bb0b3e4 dfe87815ba Cédric Le Goater:
 monitor: Fix const qualifier build errors with recent glibc
9b13c950b9 e37a0d514a Cédric Le Goater:
 tests/vhost-user-bridge.c: Fix const qualifier build errors with recent glibc
e436f7bb36 2f5c96d534 Cédric Le Goater:
 i386: Fix const qualifier build errors with recent glibc
46ff6a1ca2 326e620fc0 Cédric Le Goater:
 Fix const qualifier build errors with recent glibc
831cf1c18b 83f6dceb8f Thomas Huth:
 qga: Fix ubsan warning
28db12b336 ab0065e36a Thomas Huth:
 tests/qemu-iotests: Fix check for existing file in _require_disk_usage()
e20d07862d b002acacc1 Hanna Czenczek:
 Revert "nvme: Fix coroutine waking"
d763d9b749 ac3520f599 Hanna Czenczek:
 nvme: Note in which AioContext some functions run
6758c408c3 307bc43095 Kevin Wolf:
 block: Fix BDS use after free during shutdown
59bb74c5d6 e742b7bdc2 Stefan Weil:
 scripts/nsis.py: Tell makensis that WoA is 64 bit
cee3e62d52 46228925ed Hanna Czenczek:
 vhost: Always initialize cached vring data
7ceeab2dc4 8062bfd517 Denis V. Lunev:
 scripts: fix broken error path in modinfo-collect.py
8864d375de dd77ef99aa Alex Bennée:
 target/arm: handle unaligned PC during tlb probe
1dfa2156a9 eafc5f69e6 Alex Bennée:
 gitlab: move custom runners to Ubuntu 24.04
7a08ce0419 7e71b8e7f2 Michael Tokarev:
 gitlab-ci.d/cirrus: Update the FreeBSD job to v14.3
c27375417d 41706d3e72 Richard Henderson:
 tcg: Zero extend 32-bit addresses for TCI
469b4b6fcb 2c3165a1a6 Kevin Wolf:
 file-posix: Handle suspended dm-multipath better for SG_IO


