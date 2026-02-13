Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DF991EF48CC
	for <qemu-devel@archiver.kernel.org>; Fri, 13 Feb 2026 06:07:10 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vqmKU-00045v-PB; Fri, 13 Feb 2026 01:07:02 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1vqmKP-000445-68; Fri, 13 Feb 2026 01:06:57 -0500
Received: from isrv.corpit.ru ([212.248.84.144])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1vqmKM-0001MN-Ql; Fri, 13 Feb 2026 01:06:56 -0500
Received: from tsrv.corpit.ru (tsrv.tls.msk.ru [192.168.177.2])
 by isrv.corpit.ru (Postfix) with ESMTP id 14E81188BF8;
 Fri, 13 Feb 2026 09:06:49 +0300 (MSK)
Received: from think4mjt.tls.msk.ru (mjtthink.wg.tls.msk.ru [192.168.177.146])
 by tsrv.corpit.ru (Postfix) with ESMTP id 25651363993;
 Fri, 13 Feb 2026 09:06:52 +0300 (MSK)
From: Michael Tokarev <mjt@tls.msk.ru>
To: qemu-devel@nongnu.org
Cc: Michael Tokarev <mjt@tls.msk.ru>,
	qemu-stable@nongnu.org
Subject: [ANNOUNCE] QEMU 10.0.8 Stable released
Date: Fri, 13 Feb 2026 09:06:34 +0300
Message-ID: <20260213060647.200707-1-mjt@tls.msk.ru>
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

The QEMU v10.0.8 stable release is now available.

You can grab the tarball from our download page here:

  https://www.qemu.org/download/#source

  https://download.qemu.org/qemu-10.0.8.tar.xz
  https://download.qemu.org/qemu-10.0.8.tar.xz.sig (signature)

v10.0.8 is now tagged in the official qemu.git repository, and the
stable-10.0 branch has been updated accordingly:

  https://gitlab.com/qemu-project/qemu/-/commits/stable-10.0

There are 85 changes since the previous v10.0.7 release.

Thank you everyone who has been involved and helped with the stable series!

/mjt

Changelog (stable-10.0-hash master-hash Author Name: Commmit-Subject):

bb77968955 Michael Tokarev:
 Update version for 10.0.8 release
e4fb63f1a8 80c97930a9 Andrey Drobyshev:
 scripts/qemugdb: timers: Fix KeyError in 'qemu timers' command
b6c0a76016 d22e9aec57 Aleksandr Sergeev:
 linux-user/syscall.c: Prevent acquiring clone_lock while fork()
12ce00e31a 3560b51979 Honglei Huang:
 virtio-gpu: fix error handling in virgl_cmd_resource_create_blob
90b3d44f6d efd581a8cd Li Chen:
 virtio-pmem: ignore empty queue notifications
8d5a8ebaaf e27194e087 Joelle van Dyne:
 virtio-gpu-virgl: correct parent for blob memory region
3464e88bc9 7b913094c7 zhenwei pi:
 cryptodev-builtin: Limit the maximum size
e649201bb9 91c6438caf zhenwei pi:
 hw/virtio/virtio-crypto: verify asym request size
79fd6bf98d 66cf169e29 Igor Mammedov:
 q35: Fix migration of SMRAM state
8b3ac19ae1 fff77cfb84 Dorinda Bassey:
 virtio-dmabuf: Ensure UUID persistence for hash table insertion
c228a06d9c fd3a2c601a Wafer Xie:
 vdpa: fix vhost-vdpa suspended state not be shared
517830b989 efea7ddb46 Jamin Lin:
 hw/i2c/aspeed_i2c: Fix DMA moving data into incorrect address
623b0bad8e 9cbd8ee7f6 Jamin Lin:
 hw/i2c/aspeed: Fix wrong I2CC_DMA_LEN when I2CM_DMA_TX/RX_ADDR set first
4c12f312d0 0a1d477067 Nabih Estefan:
 hw/i2c/aspeed_i2c.c: Add a check for dma_read
793da59173 4c6521296d Cédric Le Goater:
 hw/adc: Fix out-of-bounds write in Aspeed ADC model
f81dd3987a 46dee71a94 Gerd Hoffmann:
 hw/uefi: fix size negotiation
b2137aabc6 eda9baa17a Akihiko Odaki:
 hw/nvme: Fix bootindex suffix use-after-free
66b489b368 587f4a1805 John Snow:
 python: fix msys64 wheel directory specification
51f314c12c 94e72135d4 Ilia Levi:
 tests/qtest/ufs-test: Add test for mcq completion queue wraparound
851536a836 f78762a3cc Ilia Levi:
 hw/ufs: Fix mcq completion queue wraparound
318779a5f2 ed621cc8e2 Jeuk Kim:
 hw/ufs: fix CQE endianness and UPIU length
fa886ca495 289e6a3edf Jeuk Kim:
 hw/ufs: Ensure DBC of PRDT uses only lower 18 bits
4f4ccd438b d9ca273f8f Alex Bennée:
 tests/functional: migrate sbsa_ref test images
07e8cd9556 e4f1a9b1da Thomas Huth:
 pc-bios/optionrom: Use 32-bit linker emulation for the optionroms
fe84cb0037 2eb8d97343 Paolo Bonzini:
 target/i386/tcg: fix a few instructions that do not support VEX.L=1
207df2f80c d68f0e2e90 Icenowy Zheng:
 linux-user: fixup termios2 related things on PowerPC
0ed119360f 4f22fcb5c6 Vivian Wang:
 linux-user: Add missing termios baud rates
7c0402f0dc 947b971cad Luca Bonissi:
 linux-user: Add termios2 support to sparc target
be468e6f9f afbe0ff81c Luca Bonissi:
 linux-user: Add termios2 support to sh4 target
ebf963f559 edf9184f4f Luca Bonissi:
 linux-user: Add termios2 support to mips target
f1f8f23a14 edc741710a Luca Bonissi:
 linux-user: Add termios2 support to hppa target
9a78e261c3 8d8c6aeee8 Luca Bonissi:
 linux-user: Add termios2 support to alpha target
ac4ed4bd6b e9a8a10e84 Luca Bonissi:
 linux-user: Add termios2 support
eb5a0a6eeb cf10273aff Alex Bennée:
 hw/intc: avoid byte swap fiddling in gicv3 its path
e990f9a83d f0de58ccf6 Pierrick Bouvier:
 bsd-user/syscall_defs.h: define STAT_TIME_T_EXT only for 32 bits
83b0cf4c0e 369c1ba2b7 Richard Henderson:
 bsd-user: Fix __i386__ test for TARGET_HAS_STAT_TIME_T_EXT
5a84115173 214f79fdfb Bernhard Beschow:
 hw/sd/sdhci: Fix TYPE_IMX_USDHC to implement sd-spec-version 3 by default
21846ec434 83017c4aaa Pierrick Bouvier:
 linux-user/aarch64/target_fcntl.h: add missing TARGET_O_LARGEFILE definition
373ee7d1fb 290e4e7de7 Philippe Mathieu-Daudé:
 tests/functional: Mark another MIPS replay test as flaky
dadefc1b2a 1c11aa1807 Philippe Mathieu-Daudé:
 tests/functional: Mark the MIPS replay tests as flaky
012d0a1753 b67a35622f Peter Maydell:
 target/arm: Correctly trap HCR.TID1 registers in v7A
4d402fcd1c 205ca535ab Peter Maydell:
 target/arm: Correctly honour HCR.TID3 for v7A cores
bf1070909b 8da52b8401 Peter Maydell:
 target/arm: Don't specify ID_PFR1 accessfn twice
21264e6c98 7cf096d609 Alex Bennée:
 tests/functional: migrate aspeed_rainier image
8491f94268 49ee001a5b Yao Zi:
 hw/loongarch/virt: Don't abort on access to unimplemented IOCSR
ed709c0e1d a7be2e0a3f Song Gao:
 target/loongarch: Fix exception ADEF/ADEM missing to update CSR_BADV
788dcf5c0a e4f0ef58d5 Song Gao:
 target/loongarch: Fix exception BCE missing to update CSR_BADV
6fdac75e78 70cf9b7bf7 Song Gao:
 target/loongach: Fix some exceptions failure in updating CSR_BADV
297b8ea0f5 ff54394eed Xianglai Li:
 hw/loongarch/virt: Fix irq allocation failure with pci device from fdt
cf6d62c5c9 47de28a0b7 Xianglai Li:
 hw/loongarch/virt: Modify the interrupt trigger type in fdt table
4ba877461e c7504ba2a5 Vulnerability Report:
 hw/i386/kvm: fix PIRQ bounds check in xen_physdev_map_pirq()
4f0a748c93 ed88bdcfbd Paolo Bonzini:
 target/i386/tcg: allow VEX in 16-bit protected mode
43ea497790 5e3572ef2e Paolo Bonzini:
 target/i386/tcg: mask addresses for VSIB
dbd9c5112c 73dd6e4a36 Paolo Bonzini:
 target/i386/tcg: do not mark all SSE instructions as unaligned
275a88c250 11dac41f2e Laurent Vivier:
 m68k: fix CAS2 writeback when Dc1=�2
71615b13f6 894c8bd56f Paolo Bonzini:
 configs: use default prefix for Windows compilation
6a19810d96 9290c10ae9 Matthew Lugg:
 tests: add tcg coverage for fixed mremap bugs
92bf9c32c9 81ceab3049 Matthew Lugg:
 linux-user: fix reserved_va page leak in do_munmap
cab823a454 2422884ec5 Matthew Lugg:
 linux-user: fix mremap errors for invalid ranges
d3ba2bcf5d aaed9ca179 Matthew Lugg:
 linux-user: fix mremap unmapping adjacent region
087712da63 82ae60c8b5 Jean-Christian CÎRSTEA:
 linux-user: allow null `pathname` for statx()/fstatat()
8c3c8daaad af6db3b713 Richard Henderson:
 tcg/riscv: Fix TCG_REG_TMP0 clobber in tcg_gen_dup{m,i}
446e4e1a66 e714f1a3d4 Jie Song:
 monitor/qmp: cleanup SocketChardev listener sources early to avoid fd handling race
943c736516 3fbadbb392 Alano Song:
 hw/i2c/imx: Fix trace func name error
fb6b39358f 0db1b556e4 Paolo Bonzini:
 target/i386/tcg: ignore V3 in 32-bit mode
95f5470012 60efba3c1b Andrew Cooper:
 target/i386: Fix #GP error code for INT instructions
05636333e9 00829ae384 Zesen Liu:
 qdev: fix error handling in set_uint64_checkmask
0a879fb466 d7e1df7699 Cédric Le Goater:
 gdbstub: Fix const qualifier build errors with recent glibc
5be91f937c dfe87815ba Cédric Le Goater:
 monitor: Fix const qualifier build errors with recent glibc
f417f1d0b3 e37a0d514a Cédric Le Goater:
 tests/vhost-user-bridge.c: Fix const qualifier build errors with recent glibc
47d030d1a0 2f5c96d534 Cédric Le Goater:
 i386: Fix const qualifier build errors with recent glibc
ae2224c4d7 326e620fc0 Cédric Le Goater:
 Fix const qualifier build errors with recent glibc
4e529c2abe 83f6dceb8f Thomas Huth:
 qga: Fix ubsan warning
3b0b68549f b002acacc1 Hanna Czenczek:
 Revert "nvme: Fix coroutine waking"
466c6a1d6a ac3520f599 Hanna Czenczek:
 nvme: Note in which AioContext some functions run
71bfe50b6a 307bc43095 Kevin Wolf:
 block: Fix BDS use after free during shutdown
97055b3f87 e742b7bdc2 Stefan Weil:
 scripts/nsis.py: Tell makensis that WoA is 64 bit
b2997c5a18 46228925ed Hanna Czenczek:
 vhost: Always initialize cached vring data
f121f524fa dd77ef99aa Alex Bennée:
 target/arm: handle unaligned PC during tlb probe
b9bef0a51b 41706d3e72 Richard Henderson:
 tcg: Zero extend 32-bit addresses for TCI
4162e46522 61432e805e Alex Bennée:
 tests/docker: fix debian-all-test-cross
9107a75a83 6da616bb17 Alex Bennée:
 tests/docker: handle host-arch selection for all-test-cross
3aefdb1970 408c862910 Alex Bennée:
 tests/docker: add --arch-only to qemu deps for all-test-cross
85df3071b6 eafc5f69e6 Alex Bennée:
 gitlab: move custom runners to Ubuntu 24.04
cb1be41c9d 7e71b8e7f2 Michael Tokarev:
 gitlab-ci.d/cirrus: Update the FreeBSD job to v14.3
07421d312c c8958b7eb4 Paolo Bonzini:
 tests/vm: bump FreeBSD image to 14.3


