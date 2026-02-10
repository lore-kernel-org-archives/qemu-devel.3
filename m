Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 06134EA8107
	for <qemu-devel@archiver.kernel.org>; Tue, 10 Feb 2026 12:17:07 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vpmdi-0000dQ-Sx; Tue, 10 Feb 2026 07:14:47 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1vpmdh-0000d8-Kc; Tue, 10 Feb 2026 07:14:45 -0500
Received: from isrv.corpit.ru ([212.248.84.144])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1vpmde-0008OO-R5; Tue, 10 Feb 2026 07:14:45 -0500
Received: from tsrv.corpit.ru (tsrv.tls.msk.ru [192.168.177.2])
 by isrv.corpit.ru (Postfix) with ESMTP id 56B49187D9A;
 Tue, 10 Feb 2026 15:13:42 +0300 (MSK)
Received: from think4mjt.tls.msk.ru (mjtthink.wg.tls.msk.ru [192.168.177.146])
 by tsrv.corpit.ru (Postfix) with ESMTP id E8F0F360CBC;
 Tue, 10 Feb 2026 15:14:37 +0300 (MSK)
From: Michael Tokarev <mjt@tls.msk.ru>
To: qemu-devel@nongnu.org
Cc: qemu-stable@nongnu.org,
	Michael Tokarev <mjt@tls.msk.ru>
Subject: [Stable-10.2.1 v2 00/78] Patch Round-up for stable 10.2.1,
 freeze on 2026-02-10 (frozen)
Date: Tue, 10 Feb 2026 15:14:09 +0300
Message-ID: <qemu-stable-10.2.1-20260210151332@cover.tls.msk.ru>
X-Mailer: git-send-email 2.47.3
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
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

The following patches are queued for QEMU stable v10.2.1:

  https://gitlab.com/qemu-project/qemu/-/commits/staging-10.2

Patch freeze is 2026-02-10 (frozen), and the release is planned for 2026-02-12:

  https://wiki.qemu.org/Planning/10.2

Please respond here or CC qemu-stable@nongnu.org on any additional patches
you think should (or shouldn't) be included in the release.

The changes which are staging for inclusion, with the original commit hash
from master branch, are given below the bottom line.

Thanks!

/mjt

--------------------------------------
01* 60efba3c1bff Andrew Cooper:
   target/i386: Fix #GP error code for INT instructions
02* 0db1b556e4bc Paolo Bonzini:
   target/i386/tcg: ignore V3 in 32-bit mode
03* 3fbadbb3927a Alano Song:
   hw/i2c/imx: Fix trace func name error
04* 75bcfb98a13d Cédric Le Goater:
   tests/functional: Fix URL of gb200nvl-bmc image
05* e714f1a3d4d1 Jie Song:
   monitor/qmp: cleanup SocketChardev listener sources early to avoid fd 
   handling race
06* 7d2d577de0c7 Richard Henderson:
   tcg/optimize: Save o_mask in fold_masks_zosa_int
07* 08b12bfb8f53 Richard Henderson:
   tcg/optimize: Fix a_mask computation for orc
08* 23b53ec3a8a2 Paolo Bonzini:
   tcg/optimize: Do use affected bits
09* af6db3b71310 Richard Henderson:
   tcg/riscv: Fix TCG_REG_TMP0 clobber in tcg_gen_dup{m,i}
10* 82ae60c8b5cb Jean-Christian CÎRSTEA:
   linux-user: allow null `pathname` for statx()/fstatat()
11* c333f9c4ee21 Jim MacArthur:
   linux-user/elfload.c: Correction to HWCAP2 accessor
12* aaed9ca1797d Matthew Lugg:
   linux-user: fix mremap unmapping adjacent region
13* 2422884ec5a1 Matthew Lugg:
   linux-user: fix mremap errors for invalid ranges
14* 81ceab30492e Matthew Lugg:
   linux-user: fix reserved_va page leak in do_munmap
15* 9290c10ae9d0 Matthew Lugg:
   tests: add tcg coverage for fixed mremap bugs
16* 628bda1ab759 Fabiano Rosas:
   target/ppc: Fix env->quiesced migration
17* 894c8bd56ff1 Paolo Bonzini:
   configs: use default prefix for Windows compilation
18* 11dac41f2e83 Laurent Vivier:
   m68k: fix CAS2 writeback when Dc1==Dc2
19* 73dd6e4a36dd Paolo Bonzini:
   target/i386/tcg: do not mark all SSE instructions as unaligned
20* 5e3572ef2e94 Paolo Bonzini:
   target/i386/tcg: mask addresses for VSIB
21* ed88bdcfbdcf Paolo Bonzini:
   target/i386/tcg: allow VEX in 16-bit protected mode
22* c7504ba2a560 Vulnerability Report:
   hw/i386/kvm: fix PIRQ bounds check in xen_physdev_map_pirq()
23* 47de28a0b7fb Xianglai Li:
   hw/loongarch/virt: Modify the interrupt trigger type in fdt table
24* ff54394eed14 Xianglai Li:
   hw/loongarch/virt: Fix irq allocation failure with pci device from fdt
25* 70cf9b7bf7af Song Gao:
   target/loongach: Fix some exceptions failure in updating CSR_BADV
26* e4f0ef58d53e Song Gao:
   target/loongarch: Fix exception BCE missing to update CSR_BADV
27* a7be2e0a3f7d Song Gao:
   target/loongarch: Fix exception ADEF/ADEM missing to update CSR_BADV
28* 49ee001a5b83 Yao Zi:
   hw/loongarch/virt: Don't abort on access to unimplemented IOCSR
29* c5712ad83fa4 Philippe Mathieu-Daudé:
   hw/arm: Re-enable the MAX78000FTHR machine in qemu-system-arm/aarch64
30* 7cf096d609e6 Alex Bennée:
   tests/functional: migrate aspeed_rainier image
31* 8da52b8401af Peter Maydell:
   target/arm: Don't specify ID_PFR1 accessfn twice
32* 205ca535abac Peter Maydell:
   target/arm: Correctly honour HCR.TID3 for v7A cores
33* b67a35622f9a Peter Maydell:
   target/arm: Correctly trap HCR.TID1 registers in v7A
34* 7be4256281f4 Philippe Mathieu-Daudé:
   accel/nvmm: Fix 'cpu' typo in nvmm_init_vcpu()
35* 83017c4aaa9e Pierrick Bouvier:
   linux-user/aarch64/target_fcntl.h: add missing TARGET_O_LARGEFILE 
   definition
36* 214f79fdfb43 Bernhard Beschow:
   hw/sd/sdhci: Fix TYPE_IMX_USDHC to implement sd-spec-version 3 by default
37* 369c1ba2b7c7 Richard Henderson:
   bsd-user: Fix __i386__ test for TARGET_HAS_STAT_TIME_T_EXT
38* f0de58ccf656 Pierrick Bouvier:
   bsd-user/syscall_defs.h: define STAT_TIME_T_EXT only for 32 bits
39* cf10273aff81 Alex Bennée:
   hw/intc: avoid byte swap fiddling in gicv3 its path
40* e9a8a10e84c1 Luca Bonissi:
   linux-user: Add termios2 support
41* 8d8c6aeee859 Luca Bonissi:
   linux-user: Add termios2 support to alpha target
42* edc741710ace Luca Bonissi:
   linux-user: Add termios2 support to hppa target
43* edf9184f4feb Luca Bonissi:
   linux-user: Add termios2 support to mips target
44* afbe0ff81c29 Luca Bonissi:
   linux-user: Add termios2 support to sh4 target
45* 947b971cad90 Luca Bonissi:
   linux-user: Add termios2 support to sparc target
46* 4f22fcb5c67f Vivian Wang:
   linux-user: Add missing termios baud rates
47* d68f0e2e9069 Icenowy Zheng:
   linux-user: fixup termios2 related things on PowerPC
48* 2eb8d9734355 Paolo Bonzini:
   target/i386/tcg: fix a few instructions that do not support VEX.L=1
49* 815567b4ea35 Daniel P. Berrangé:
   gitlab: preserve base rules for container template
50* e4f1a9b1dacb Thomas Huth:
   pc-bios/optionrom: Use 32-bit linker emulation for the optionroms
51* d9ca273f8f31 Alex Bennée:
   tests/functional: migrate sbsa_ref test images
52* 289e6a3edf50 Jeuk Kim:
   hw/ufs: Ensure DBC of PRDT uses only lower 18 bits
53* ed621cc8e2a6 Jeuk Kim:
   hw/ufs: fix CQE endianness and UPIU length
54* f78762a3cc81 Ilia Levi:
   hw/ufs: Fix mcq completion queue wraparound
55* 94e72135d4d6 Ilia Levi:
   tests/qtest/ufs-test: Add test for mcq completion queue wraparound
56* 587f4a1805c8 John Snow:
   python: fix msys64 wheel directory specification
57 eda9baa17a28 Akihiko Odaki:
   hw/nvme: Fix bootindex suffix use-after-free
58 46dee71a945d Gerd Hoffmann:
   hw/uefi: fix size negotiation
59 4c6521296d2b Cédric Le Goater:
   hw/adc: Fix out-of-bounds write in Aspeed ADC model
60 0a1d47706702 Nabih Estefan:
   hw/i2c/aspeed_i2c.c: Add a check for dma_read
61 7d64f04863ed Jamin Lin:
   hw/arm/aspeed_ast27x0: Fix EHCI3/4 IRQ routing to GIC
62 9cbd8ee7f67f Jamin Lin:
   hw/i2c/aspeed: Fix wrong I2CC_DMA_LEN when I2CM_DMA_TX/RX_ADDR set first
63 efea7ddb4689 Jamin Lin:
   hw/i2c/aspeed_i2c: Fix DMA moving data into incorrect address
64 fd3a2c601ab4 Wafer Xie:
   vdpa: fix vhost-vdpa suspended state not be shared
65 fff77cfb8413 Dorinda Bassey:
   virtio-dmabuf: Ensure UUID persistence for hash table insertion
66 623db8564768 Kevin Wolf:
   virtio: Fix crash when sriov-pf is set for non-PCI-Express device
67 f73e5ed9bc4c Kevin Wolf:
   pcie_sriov: Fix PCI_SRIOV_* accesses in pcie_sriov_pf_exit()
68 66cf169e29b0 Igor Mammedov:
   q35: Fix migration of SMRAM state
69 91c6438caffc zhenwei pi:
   hw/virtio/virtio-crypto: verify asym request size
70 7b913094c703 zhenwei pi:
   cryptodev-builtin: Limit the maximum size
71 e27194e087ae Joelle van Dyne:
   virtio-gpu-virgl: correct parent for blob memory region
72 efd581a8cd44 Li Chen:
   virtio-pmem: ignore empty queue notifications
73 3560b5197957 Honglei Huang:
   virtio-gpu: fix error handling in virgl_cmd_resource_create_blob
74 87f8e5a71d06 Jonathan Cameron:
   hw/cxl: Check for overflow on santize media as both base and offset 64bit.
75 25465c0e1fd7 Jonathan Cameron:
   hw/cxl: Take into account how many media operations are requested for 
   param check
76 d22e9aec5723 Aleksandr Sergeev:
   linux-user/syscall.c: Prevent acquiring clone_lock while fork()
77 251a3d4ca3c9 Paolo Bonzini:
   Revert "tcg/user: do not set exit_request gratuitously"
78 80c97930a93c Andrey Drobyshev:
   scripts/qemugdb: timers: Fix KeyError in 'qemu timers' command

(commit(s) marked with * were in previous series and are not resent)

