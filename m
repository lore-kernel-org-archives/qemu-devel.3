Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3333FEF48CA
	for <qemu-devel@archiver.kernel.org>; Fri, 13 Feb 2026 06:06:44 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vqmK0-0003xY-R5; Fri, 13 Feb 2026 01:06:33 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1vqmJp-0003qH-4J; Fri, 13 Feb 2026 01:06:23 -0500
Received: from isrv.corpit.ru ([212.248.84.144])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1vqmJl-0001KT-6z; Fri, 13 Feb 2026 01:06:20 -0500
Received: from tsrv.corpit.ru (tsrv.tls.msk.ru [192.168.177.2])
 by isrv.corpit.ru (Postfix) with ESMTP id 36C08188BF7;
 Fri, 13 Feb 2026 09:06:11 +0300 (MSK)
Received: from think4mjt.tls.msk.ru (mjtthink.wg.tls.msk.ru [192.168.177.146])
 by tsrv.corpit.ru (Postfix) with ESMTP id 392A7363992;
 Fri, 13 Feb 2026 09:06:14 +0300 (MSK)
From: Michael Tokarev <mjt@tls.msk.ru>
To: qemu-devel@nongnu.org
Cc: Michael Tokarev <mjt@tls.msk.ru>,
	qemu-stable@nongnu.org
Subject: [ANNOUNCE] QEMU 10.2.1 Stable released
Date: Fri, 13 Feb 2026 09:05:58 +0300
Message-ID: <20260213060607.200695-1-mjt@tls.msk.ru>
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

The QEMU v10.2.1 stable release is now available.

You can grab the tarball from our download page here:

  https://www.qemu.org/download/#source

  https://download.qemu.org/qemu-10.2.1.tar.xz
  https://download.qemu.org/qemu-10.2.1.tar.xz.sig (signature)

v10.2.1 is now tagged in the official qemu.git repository, and the
stable-10.2 branch has been updated accordingly:

  https://gitlab.com/qemu-project/qemu/-/commits/stable-10.2

There are 78 changes since the previous v10.2.0 release.

Thank you everyone who has been involved and helped with the stable series!

/mjt

Changelog (stable-10.2-hash master-hash Author Name: Commmit-Subject):

2d3df8abca Michael Tokarev:
 Update version for 10.2.1 release
63a76e0123 80c97930a9 Andrey Drobyshev:
 scripts/qemugdb: timers: Fix KeyError in 'qemu timers' command
b5ce6809b4 251a3d4ca3 Paolo Bonzini:
 Revert "tcg/user: do not set exit_request gratuitously"
1af5215667 d22e9aec57 Aleksandr Sergeev:
 linux-user/syscall.c: Prevent acquiring clone_lock while fork()
ba31a6fca7 25465c0e1f Jonathan Cameron:
 hw/cxl: Take into account how many media operations are requested for param check
fd0abbb386 87f8e5a71d Jonathan Cameron:
 hw/cxl: Check for overflow on santize media as both base and offset 64bit.
e5628119e1 3560b51979 Honglei Huang:
 virtio-gpu: fix error handling in virgl_cmd_resource_create_blob
cfc706b38e efd581a8cd Li Chen:
 virtio-pmem: ignore empty queue notifications
be88ad424c e27194e087 Joelle van Dyne:
 virtio-gpu-virgl: correct parent for blob memory region
51514aa3c2 7b913094c7 zhenwei pi:
 cryptodev-builtin: Limit the maximum size
2ac11c1d93 91c6438caf zhenwei pi:
 hw/virtio/virtio-crypto: verify asym request size
080b623ed4 66cf169e29 Igor Mammedov:
 q35: Fix migration of SMRAM state
8c65f73b31 f73e5ed9bc Kevin Wolf:
 pcie_sriov: Fix PCI_SRIOV_* accesses in pcie_sriov_pf_exit()
a440980876 623db85647 Kevin Wolf:
 virtio: Fix crash when sriov-pf is set for non-PCI-Express device
ab67c542a9 fff77cfb84 Dorinda Bassey:
 virtio-dmabuf: Ensure UUID persistence for hash table insertion
ad2c2ef5e5 fd3a2c601a Wafer Xie:
 vdpa: fix vhost-vdpa suspended state not be shared
0b1ddf19d0 efea7ddb46 Jamin Lin:
 hw/i2c/aspeed_i2c: Fix DMA moving data into incorrect address
a66c02ea9d 9cbd8ee7f6 Jamin Lin:
 hw/i2c/aspeed: Fix wrong I2CC_DMA_LEN when I2CM_DMA_TX/RX_ADDR set first
146214796c 7d64f04863 Jamin Lin:
 hw/arm/aspeed_ast27x0: Fix EHCI3/4 IRQ routing to GIC
2f46d99451 0a1d477067 Nabih Estefan:
 hw/i2c/aspeed_i2c.c: Add a check for dma_read
d4c6c60993 4c6521296d Cédric Le Goater:
 hw/adc: Fix out-of-bounds write in Aspeed ADC model
8bf4744182 46dee71a94 Gerd Hoffmann:
 hw/uefi: fix size negotiation
89f7d4fb13 eda9baa17a Akihiko Odaki:
 hw/nvme: Fix bootindex suffix use-after-free
a2fbfefbb7 587f4a1805 John Snow:
 python: fix msys64 wheel directory specification
0c2fd08dc8 94e72135d4 Ilia Levi:
 tests/qtest/ufs-test: Add test for mcq completion queue wraparound
ad5f6ffcd0 f78762a3cc Ilia Levi:
 hw/ufs: Fix mcq completion queue wraparound
88ef8726ff ed621cc8e2 Jeuk Kim:
 hw/ufs: fix CQE endianness and UPIU length
cce96e6052 289e6a3edf Jeuk Kim:
 hw/ufs: Ensure DBC of PRDT uses only lower 18 bits
92e6f27829 d9ca273f8f Alex Bennée:
 tests/functional: migrate sbsa_ref test images
49d3f1381d e4f1a9b1da Thomas Huth:
 pc-bios/optionrom: Use 32-bit linker emulation for the optionroms
8aee37581e 815567b4ea Daniel P. Berrangé:
 gitlab: preserve base rules for container template
f48aaf926e 2eb8d97343 Paolo Bonzini:
 target/i386/tcg: fix a few instructions that do not support VEX.L=1
d0be1b581c d68f0e2e90 Icenowy Zheng:
 linux-user: fixup termios2 related things on PowerPC
1e762859ce 4f22fcb5c6 Vivian Wang:
 linux-user: Add missing termios baud rates
22a55fc7df 947b971cad Luca Bonissi:
 linux-user: Add termios2 support to sparc target
c1fac5fbfe afbe0ff81c Luca Bonissi:
 linux-user: Add termios2 support to sh4 target
ce78d40265 edf9184f4f Luca Bonissi:
 linux-user: Add termios2 support to mips target
06cfe78536 edc741710a Luca Bonissi:
 linux-user: Add termios2 support to hppa target
20b93df8d7 8d8c6aeee8 Luca Bonissi:
 linux-user: Add termios2 support to alpha target
5380228f7f e9a8a10e84 Luca Bonissi:
 linux-user: Add termios2 support
ba3581de79 cf10273aff Alex Bennée:
 hw/intc: avoid byte swap fiddling in gicv3 its path
9707eaa47b f0de58ccf6 Pierrick Bouvier:
 bsd-user/syscall_defs.h: define STAT_TIME_T_EXT only for 32 bits
ff338c6f78 369c1ba2b7 Richard Henderson:
 bsd-user: Fix __i386__ test for TARGET_HAS_STAT_TIME_T_EXT
769d19221e 214f79fdfb Bernhard Beschow:
 hw/sd/sdhci: Fix TYPE_IMX_USDHC to implement sd-spec-version 3 by default
6f54455c10 83017c4aaa Pierrick Bouvier:
 linux-user/aarch64/target_fcntl.h: add missing TARGET_O_LARGEFILE definition
4131a1d83c 7be4256281 Philippe Mathieu-Daudé:
 accel/nvmm: Fix 'cpu' typo in nvmm_init_vcpu()
6bcd958030 b67a35622f Peter Maydell:
 target/arm: Correctly trap HCR.TID1 registers in v7A
5ead00ce11 205ca535ab Peter Maydell:
 target/arm: Correctly honour HCR.TID3 for v7A cores
bcc7fc8f81 8da52b8401 Peter Maydell:
 target/arm: Don't specify ID_PFR1 accessfn twice
35abae4511 7cf096d609 Alex Bennée:
 tests/functional: migrate aspeed_rainier image
d9dd5dad31 c5712ad83f Philippe Mathieu-Daudé:
 hw/arm: Re-enable the MAX78000FTHR machine in qemu-system-arm/aarch64
1a1ebc90cd 49ee001a5b Yao Zi:
 hw/loongarch/virt: Don't abort on access to unimplemented IOCSR
0b92a8a130 a7be2e0a3f Song Gao:
 target/loongarch: Fix exception ADEF/ADEM missing to update CSR_BADV
7d662d328d e4f0ef58d5 Song Gao:
 target/loongarch: Fix exception BCE missing to update CSR_BADV
b8456254d0 70cf9b7bf7 Song Gao:
 target/loongach: Fix some exceptions failure in updating CSR_BADV
21af0baf9a ff54394eed Xianglai Li:
 hw/loongarch/virt: Fix irq allocation failure with pci device from fdt
e12259821c 47de28a0b7 Xianglai Li:
 hw/loongarch/virt: Modify the interrupt trigger type in fdt table
058e1774d6 c7504ba2a5 Vulnerability Report:
 hw/i386/kvm: fix PIRQ bounds check in xen_physdev_map_pirq()
11e286fb93 ed88bdcfbd Paolo Bonzini:
 target/i386/tcg: allow VEX in 16-bit protected mode
6594e50e7e 5e3572ef2e Paolo Bonzini:
 target/i386/tcg: mask addresses for VSIB
51bc24d427 73dd6e4a36 Paolo Bonzini:
 target/i386/tcg: do not mark all SSE instructions as unaligned
359076c8a0 11dac41f2e Laurent Vivier:
 m68k: fix CAS2 writeback when Dc1=�2
920634e411 894c8bd56f Paolo Bonzini:
 configs: use default prefix for Windows compilation
639ffcbd64 628bda1ab7 Fabiano Rosas:
 target/ppc: Fix env->quiesced migration
4cc64bd6c4 9290c10ae9 Matthew Lugg:
 tests: add tcg coverage for fixed mremap bugs
860f8f3f53 81ceab3049 Matthew Lugg:
 linux-user: fix reserved_va page leak in do_munmap
5ac0811f40 2422884ec5 Matthew Lugg:
 linux-user: fix mremap errors for invalid ranges
a8adf882fd aaed9ca179 Matthew Lugg:
 linux-user: fix mremap unmapping adjacent region
86ce6e0773 c333f9c4ee Jim MacArthur:
 linux-user/elfload.c: Correction to HWCAP2 accessor
e71e02caa7 82ae60c8b5 Jean-Christian CÎRSTEA:
 linux-user: allow null `pathname` for statx()/fstatat()
f34c0eb054 af6db3b713 Richard Henderson:
 tcg/riscv: Fix TCG_REG_TMP0 clobber in tcg_gen_dup{m,i}
a53ba65fff 23b53ec3a8 Paolo Bonzini:
 tcg/optimize: Do use affected bits
b276b2ca22 08b12bfb8f Richard Henderson:
 tcg/optimize: Fix a_mask computation for orc
682e043b17 7d2d577de0 Richard Henderson:
 tcg/optimize: Save o_mask in fold_masks_zosa_int
d6b9de8f9e e714f1a3d4 Jie Song:
 monitor/qmp: cleanup SocketChardev listener sources early to avoid fd handling race
a7383751c2 75bcfb98a1 Cédric Le Goater:
 tests/functional: Fix URL of gb200nvl-bmc image
2af81f1251 3fbadbb392 Alano Song:
 hw/i2c/imx: Fix trace func name error
59c9137156 0db1b556e4 Paolo Bonzini:
 target/i386/tcg: ignore V3 in 32-bit mode
b33a563281 60efba3c1b Andrew Cooper:
 target/i386: Fix #GP error code for INT instructions


