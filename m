Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7D6AEEA8107
	for <qemu-devel@archiver.kernel.org>; Tue, 10 Feb 2026 12:20:33 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vpmgn-0004eT-8C; Tue, 10 Feb 2026 07:17:57 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1vpmfX-0002Gz-4b; Tue, 10 Feb 2026 07:16:41 -0500
Received: from isrv.corpit.ru ([212.248.84.144])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1vpmfU-0000R4-QX; Tue, 10 Feb 2026 07:16:38 -0500
Received: from tsrv.corpit.ru (tsrv.tls.msk.ru [192.168.177.2])
 by isrv.corpit.ru (Postfix) with ESMTP id 66B83187DB2;
 Tue, 10 Feb 2026 15:14:30 +0300 (MSK)
Received: from think4mjt.tls.msk.ru (mjtthink.wg.tls.msk.ru [192.168.177.146])
 by tsrv.corpit.ru (Postfix) with ESMTP id 05898360CD7;
 Tue, 10 Feb 2026 15:15:26 +0300 (MSK)
From: Michael Tokarev <mjt@tls.msk.ru>
To: qemu-devel@nongnu.org
Cc: qemu-stable@nongnu.org,
	Michael Tokarev <mjt@tls.msk.ru>
Subject: [Stable-10.1.4 v2 00/95] Patch Round-up for stable 10.1.4,
 freeze on 2026-02-10 (frozen)
Date: Tue, 10 Feb 2026 15:14:56 +0300
Message-ID: <qemu-stable-10.1.4-20260210151454@cover.tls.msk.ru>
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

The following patches are queued for QEMU stable v10.1.4:

  https://gitlab.com/qemu-project/qemu/-/commits/staging-10.1

Patch freeze is 2026-02-10 (frozen), and the release is planned for 2026-02-12:

  https://wiki.qemu.org/Planning/10.1

Please respond here or CC qemu-stable@nongnu.org on any additional patches
you think should (or shouldn't) be included in the release.

The changes which are staging for inclusion, with the original commit hash
from master branch, are given below the bottom line.

Thanks!

/mjt

--------------------------------------
01* 2c3165a1a61c Kevin Wolf:
   file-posix: Handle suspended dm-multipath better for SG_IO
02* 41706d3e72d6 Richard Henderson:
   tcg: Zero extend 32-bit addresses for TCI
03* 7e71b8e7f2f6 Michael Tokarev:
   gitlab-ci.d/cirrus: Update the FreeBSD job to v14.3
04* eafc5f69e621 Alex Bennée:
   gitlab: move custom runners to Ubuntu 24.04
05* dd77ef99aa02 Alex Bennée:
   target/arm: handle unaligned PC during tlb probe
06* 8062bfd51764 Denis V. Lunev:
   scripts: fix broken error path in modinfo-collect.py
07* 46228925edd5 Hanna Czenczek:
   vhost: Always initialize cached vring data
08* e742b7bdc244 Stefan Weil:
   scripts/nsis.py: Tell makensis that WoA is 64 bit
09* 307bc43095b8 Kevin Wolf:
   block: Fix BDS use after free during shutdown
10* ac3520f599fe Hanna Czenczek:
   nvme: Note in which AioContext some functions run
11* b002acacc1d7 Hanna Czenczek:
   Revert "nvme: Fix coroutine waking"
12* ab0065e36adf Thomas Huth:
   tests/qemu-iotests: Fix check for existing file in _require_disk_usage()
13* 83f6dceb8f5c Thomas Huth:
   qga: Fix ubsan warning
14* 326e620fc014 Cédric Le Goater:
   Fix const qualifier build errors with recent glibc
15* 2f5c96d53409 Cédric Le Goater:
   i386: Fix const qualifier build errors with recent glibc
16* e37a0d514a17 Cédric Le Goater:
   tests/vhost-user-bridge.c: Fix const qualifier build errors with recent 
   glibc
17* dfe87815ba45 Cédric Le Goater:
   monitor: Fix const qualifier build errors with recent glibc
18* d7e1df769910 Cédric Le Goater:
   gdbstub: Fix const qualifier build errors with recent glibc
19* 00829ae3845f Zesen Liu:
   qdev: fix error handling in set_uint64_checkmask
20* 60efba3c1bff Andrew Cooper:
   target/i386: Fix #GP error code for INT instructions
21* 0db1b556e4bc Paolo Bonzini:
   target/i386/tcg: ignore V3 in 32-bit mode
22* 3fbadbb3927a Alano Song:
   hw/i2c/imx: Fix trace func name error
23* 75bcfb98a13d Cédric Le Goater:
   tests/functional: Fix URL of gb200nvl-bmc image
24* e714f1a3d4d1 Jie Song:
   monitor/qmp: cleanup SocketChardev listener sources early to avoid fd 
   handling race
25* 7d2d577de0c7 Richard Henderson:
   tcg/optimize: Save o_mask in fold_masks_zosa_int
26* 08b12bfb8f53 Richard Henderson:
   tcg/optimize: Fix a_mask computation for orc
27* 23b53ec3a8a2 Paolo Bonzini:
   tcg/optimize: Do use affected bits
28* af6db3b71310 Richard Henderson:
   tcg/riscv: Fix TCG_REG_TMP0 clobber in tcg_gen_dup{m,i}
29* 82ae60c8b5cb Jean-Christian CÎRSTEA:
   linux-user: allow null `pathname` for statx()/fstatat()
30* aaed9ca1797d Matthew Lugg:
   linux-user: fix mremap unmapping adjacent region
31* 2422884ec5a1 Matthew Lugg:
   linux-user: fix mremap errors for invalid ranges
32* 81ceab30492e Matthew Lugg:
   linux-user: fix reserved_va page leak in do_munmap
33* 9290c10ae9d0 Matthew Lugg:
   tests: add tcg coverage for fixed mremap bugs
34* 628bda1ab759 Fabiano Rosas:
   target/ppc: Fix env->quiesced migration
35* 894c8bd56ff1 Paolo Bonzini:
   configs: use default prefix for Windows compilation
36* 11dac41f2e83 Laurent Vivier:
   m68k: fix CAS2 writeback when Dc1==Dc2
37* 73dd6e4a36dd Paolo Bonzini:
   target/i386/tcg: do not mark all SSE instructions as unaligned
38* 5e3572ef2e94 Paolo Bonzini:
   target/i386/tcg: mask addresses for VSIB
39* ed88bdcfbdcf Paolo Bonzini:
   target/i386/tcg: allow VEX in 16-bit protected mode
40* c7504ba2a560 Vulnerability Report:
   hw/i386/kvm: fix PIRQ bounds check in xen_physdev_map_pirq()
41* 47de28a0b7fb Xianglai Li:
   hw/loongarch/virt: Modify the interrupt trigger type in fdt table
42* ff54394eed14 Xianglai Li:
   hw/loongarch/virt: Fix irq allocation failure with pci device from fdt
43* 70cf9b7bf7af Song Gao:
   target/loongach: Fix some exceptions failure in updating CSR_BADV
44* e4f0ef58d53e Song Gao:
   target/loongarch: Fix exception BCE missing to update CSR_BADV
45* a7be2e0a3f7d Song Gao:
   target/loongarch: Fix exception ADEF/ADEM missing to update CSR_BADV
46* 49ee001a5b83 Yao Zi:
   hw/loongarch/virt: Don't abort on access to unimplemented IOCSR
47* 7cf096d609e6 Alex Bennée:
   tests/functional: migrate aspeed_rainier image
48* 8da52b8401af Peter Maydell:
   target/arm: Don't specify ID_PFR1 accessfn twice
49* 205ca535abac Peter Maydell:
   target/arm: Correctly honour HCR.TID3 for v7A cores
50* b67a35622f9a Peter Maydell:
   target/arm: Correctly trap HCR.TID1 registers in v7A
51* 7be4256281f4 Philippe Mathieu-Daudé:
   accel/nvmm: Fix 'cpu' typo in nvmm_init_vcpu()
52* 1c11aa180714 Philippe Mathieu-Daudé:
   tests/functional: Mark the MIPS replay tests as flaky
53* 290e4e7de7a5 Philippe Mathieu-Daudé:
   tests/functional: Mark another MIPS replay test as flaky
54* 83017c4aaa9e Pierrick Bouvier:
   linux-user/aarch64/target_fcntl.h: add missing TARGET_O_LARGEFILE 
   definition
55* 214f79fdfb43 Bernhard Beschow:
   hw/sd/sdhci: Fix TYPE_IMX_USDHC to implement sd-spec-version 3 by default
56* 369c1ba2b7c7 Richard Henderson:
   bsd-user: Fix __i386__ test for TARGET_HAS_STAT_TIME_T_EXT
57* f0de58ccf656 Pierrick Bouvier:
   bsd-user/syscall_defs.h: define STAT_TIME_T_EXT only for 32 bits
58* cf10273aff81 Alex Bennée:
   hw/intc: avoid byte swap fiddling in gicv3 its path
59* e9a8a10e84c1 Luca Bonissi:
   linux-user: Add termios2 support
60* 8d8c6aeee859 Luca Bonissi:
   linux-user: Add termios2 support to alpha target
61* edc741710ace Luca Bonissi:
   linux-user: Add termios2 support to hppa target
62* edf9184f4feb Luca Bonissi:
   linux-user: Add termios2 support to mips target
63* afbe0ff81c29 Luca Bonissi:
   linux-user: Add termios2 support to sh4 target
64* 947b971cad90 Luca Bonissi:
   linux-user: Add termios2 support to sparc target
65* 4f22fcb5c67f Vivian Wang:
   linux-user: Add missing termios baud rates
66* d68f0e2e9069 Icenowy Zheng:
   linux-user: fixup termios2 related things on PowerPC
67* 2eb8d9734355 Paolo Bonzini:
   target/i386/tcg: fix a few instructions that do not support VEX.L=1
68* e4f1a9b1dacb Thomas Huth:
   pc-bios/optionrom: Use 32-bit linker emulation for the optionroms
69* d9ca273f8f31 Alex Bennée:
   tests/functional: migrate sbsa_ref test images
70* 289e6a3edf50 Jeuk Kim:
   hw/ufs: Ensure DBC of PRDT uses only lower 18 bits
71* ed621cc8e2a6 Jeuk Kim:
   hw/ufs: fix CQE endianness and UPIU length
72* f78762a3cc81 Ilia Levi:
   hw/ufs: Fix mcq completion queue wraparound
73* 94e72135d4d6 Ilia Levi:
   tests/qtest/ufs-test: Add test for mcq completion queue wraparound
74* 587f4a1805c8 John Snow:
   python: fix msys64 wheel directory specification
75 eda9baa17a28 Akihiko Odaki:
   hw/nvme: Fix bootindex suffix use-after-free
76 46dee71a945d Gerd Hoffmann:
   hw/uefi: fix size negotiation
77 4c6521296d2b Cédric Le Goater:
   hw/adc: Fix out-of-bounds write in Aspeed ADC model
78 0a1d47706702 Nabih Estefan:
   hw/i2c/aspeed_i2c.c: Add a check for dma_read
79 7d64f04863ed Jamin Lin:
   hw/arm/aspeed_ast27x0: Fix EHCI3/4 IRQ routing to GIC
80 9cbd8ee7f67f Jamin Lin:
   hw/i2c/aspeed: Fix wrong I2CC_DMA_LEN when I2CM_DMA_TX/RX_ADDR set first
81 efea7ddb4689 Jamin Lin:
   hw/i2c/aspeed_i2c: Fix DMA moving data into incorrect address
82 fd3a2c601ab4 Wafer Xie:
   vdpa: fix vhost-vdpa suspended state not be shared
83 fff77cfb8413 Dorinda Bassey:
   virtio-dmabuf: Ensure UUID persistence for hash table insertion
84 623db8564768 Kevin Wolf:
   virtio: Fix crash when sriov-pf is set for non-PCI-Express device
85 f73e5ed9bc4c Kevin Wolf:
   pcie_sriov: Fix PCI_SRIOV_* accesses in pcie_sriov_pf_exit()
86 66cf169e29b0 Igor Mammedov:
   q35: Fix migration of SMRAM state
87 91c6438caffc zhenwei pi:
   hw/virtio/virtio-crypto: verify asym request size
88 7b913094c703 zhenwei pi:
   cryptodev-builtin: Limit the maximum size
89 e27194e087ae Joelle van Dyne:
   virtio-gpu-virgl: correct parent for blob memory region
90 efd581a8cd44 Li Chen:
   virtio-pmem: ignore empty queue notifications
91 3560b5197957 Honglei Huang:
   virtio-gpu: fix error handling in virgl_cmd_resource_create_blob
92 87f8e5a71d06 Jonathan Cameron:
   hw/cxl: Check for overflow on santize media as both base and offset 64bit.
93 25465c0e1fd7 Jonathan Cameron:
   hw/cxl: Take into account how many media operations are requested for 
   param check
94 d22e9aec5723 Aleksandr Sergeev:
   linux-user/syscall.c: Prevent acquiring clone_lock while fork()
95 80c97930a93c Andrey Drobyshev:
   scripts/qemugdb: timers: Fix KeyError in 'qemu timers' command

(commit(s) marked with * were in previous series and are not resent)

