Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 28FD0EA8105
	for <qemu-devel@archiver.kernel.org>; Tue, 10 Feb 2026 12:22:58 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vpmjI-0002Hb-Be; Tue, 10 Feb 2026 07:20:32 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1vpmhh-0006Qq-Cr; Tue, 10 Feb 2026 07:18:54 -0500
Received: from isrv.corpit.ru ([212.248.84.144])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1vpmhf-0001LZ-1a; Tue, 10 Feb 2026 07:18:53 -0500
Received: from tsrv.corpit.ru (tsrv.tls.msk.ru [192.168.177.2])
 by isrv.corpit.ru (Postfix) with ESMTP id A08AF187DD4;
 Tue, 10 Feb 2026 15:16:01 +0300 (MSK)
Received: from think4mjt.tls.msk.ru (mjtthink.wg.tls.msk.ru [192.168.177.146])
 by tsrv.corpit.ru (Postfix) with ESMTP id 40877360CED;
 Tue, 10 Feb 2026 15:16:57 +0300 (MSK)
From: Michael Tokarev <mjt@tls.msk.ru>
To: qemu-devel@nongnu.org
Cc: qemu-stable@nongnu.org,
	Michael Tokarev <mjt@tls.msk.ru>
Subject: [Stable-10.0.8 v2 00/85] Patch Round-up for stable 10.0.8,
 freeze on 2026-02-10 (frozen)
Date: Tue, 10 Feb 2026 15:16:33 +0300
Message-ID: <qemu-stable-10.0.8-20260210151548@cover.tls.msk.ru>
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

The following patches are queued for QEMU stable v10.0.8:

  https://gitlab.com/qemu-project/qemu/-/commits/staging-10.0

Patch freeze is 2026-02-10 (frozen), and the release is planned for 2026-02-12:

  https://wiki.qemu.org/Planning/10.0

Please respond here or CC qemu-stable@nongnu.org on any additional patches
you think should (or shouldn't) be included in the release.

The changes which are staging for inclusion, with the original commit hash
from master branch, are given below the bottom line.

Thanks!

/mjt

--------------------------------------
01* c8958b7eb494 Paolo Bonzini:
   tests/vm: bump FreeBSD image to 14.3
02* 7e71b8e7f2f6 Michael Tokarev:
   gitlab-ci.d/cirrus: Update the FreeBSD job to v14.3
03* eafc5f69e621 Alex Bennée:
   gitlab: move custom runners to Ubuntu 24.04
04* 408c8629105f Alex Bennée:
   tests/docker: add --arch-only to qemu deps for all-test-cross
05* 6da616bb1700 Alex Bennée:
   tests/docker: handle host-arch selection for all-test-cross
06* 61432e805e50 Alex Bennée:
   tests/docker: fix debian-all-test-cross
07* 41706d3e72d6 Richard Henderson:
   tcg: Zero extend 32-bit addresses for TCI
08* dd77ef99aa02 Alex Bennée:
   target/arm: handle unaligned PC during tlb probe
09* 46228925edd5 Hanna Czenczek:
   vhost: Always initialize cached vring data
10* e742b7bdc244 Stefan Weil:
   scripts/nsis.py: Tell makensis that WoA is 64 bit
11* 307bc43095b8 Kevin Wolf:
   block: Fix BDS use after free during shutdown
12* ac3520f599fe Hanna Czenczek:
   nvme: Note in which AioContext some functions run
13* b002acacc1d7 Hanna Czenczek:
   Revert "nvme: Fix coroutine waking"
14* 83f6dceb8f5c Thomas Huth:
   qga: Fix ubsan warning
15* 326e620fc014 Cédric Le Goater:
   Fix const qualifier build errors with recent glibc
16* 2f5c96d53409 Cédric Le Goater:
   i386: Fix const qualifier build errors with recent glibc
17* e37a0d514a17 Cédric Le Goater:
   tests/vhost-user-bridge.c: Fix const qualifier build errors with recent 
   glibc
18* dfe87815ba45 Cédric Le Goater:
   monitor: Fix const qualifier build errors with recent glibc
19* d7e1df769910 Cédric Le Goater:
   gdbstub: Fix const qualifier build errors with recent glibc
20* 00829ae3845f Zesen Liu:
   qdev: fix error handling in set_uint64_checkmask
21* 60efba3c1bff Andrew Cooper:
   target/i386: Fix #GP error code for INT instructions
22* 0db1b556e4bc Paolo Bonzini:
   target/i386/tcg: ignore V3 in 32-bit mode
23* 3fbadbb3927a Alano Song:
   hw/i2c/imx: Fix trace func name error
24* e714f1a3d4d1 Jie Song:
   monitor/qmp: cleanup SocketChardev listener sources early to avoid fd 
   handling race
25* af6db3b71310 Richard Henderson:
   tcg/riscv: Fix TCG_REG_TMP0 clobber in tcg_gen_dup{m,i}
26* 82ae60c8b5cb Jean-Christian CÎRSTEA:
   linux-user: allow null `pathname` for statx()/fstatat()
27* aaed9ca1797d Matthew Lugg:
   linux-user: fix mremap unmapping adjacent region
28* 2422884ec5a1 Matthew Lugg:
   linux-user: fix mremap errors for invalid ranges
29* 81ceab30492e Matthew Lugg:
   linux-user: fix reserved_va page leak in do_munmap
30* 9290c10ae9d0 Matthew Lugg:
   tests: add tcg coverage for fixed mremap bugs
31* 894c8bd56ff1 Paolo Bonzini:
   configs: use default prefix for Windows compilation
32* 11dac41f2e83 Laurent Vivier:
   m68k: fix CAS2 writeback when Dc1==Dc2
33* 73dd6e4a36dd Paolo Bonzini:
   target/i386/tcg: do not mark all SSE instructions as unaligned
34* 5e3572ef2e94 Paolo Bonzini:
   target/i386/tcg: mask addresses for VSIB
35* ed88bdcfbdcf Paolo Bonzini:
   target/i386/tcg: allow VEX in 16-bit protected mode
36* c7504ba2a560 Vulnerability Report:
   hw/i386/kvm: fix PIRQ bounds check in xen_physdev_map_pirq()
37* 47de28a0b7fb Xianglai Li:
   hw/loongarch/virt: Modify the interrupt trigger type in fdt table
38* ff54394eed14 Xianglai Li:
   hw/loongarch/virt: Fix irq allocation failure with pci device from fdt
39* 70cf9b7bf7af Song Gao:
   target/loongach: Fix some exceptions failure in updating CSR_BADV
40* e4f0ef58d53e Song Gao:
   target/loongarch: Fix exception BCE missing to update CSR_BADV
41* a7be2e0a3f7d Song Gao:
   target/loongarch: Fix exception ADEF/ADEM missing to update CSR_BADV
42* 49ee001a5b83 Yao Zi:
   hw/loongarch/virt: Don't abort on access to unimplemented IOCSR
43* 7cf096d609e6 Alex Bennée:
   tests/functional: migrate aspeed_rainier image
44* 8da52b8401af Peter Maydell:
   target/arm: Don't specify ID_PFR1 accessfn twice
45* 205ca535abac Peter Maydell:
   target/arm: Correctly honour HCR.TID3 for v7A cores
46* b67a35622f9a Peter Maydell:
   target/arm: Correctly trap HCR.TID1 registers in v7A
47* 1c11aa180714 Philippe Mathieu-Daudé:
   tests/functional: Mark the MIPS replay tests as flaky
48* 290e4e7de7a5 Philippe Mathieu-Daudé:
   tests/functional: Mark another MIPS replay test as flaky
49* 83017c4aaa9e Pierrick Bouvier:
   linux-user/aarch64/target_fcntl.h: add missing TARGET_O_LARGEFILE 
   definition
50* 214f79fdfb43 Bernhard Beschow:
   hw/sd/sdhci: Fix TYPE_IMX_USDHC to implement sd-spec-version 3 by default
51* 369c1ba2b7c7 Richard Henderson:
   bsd-user: Fix __i386__ test for TARGET_HAS_STAT_TIME_T_EXT
52* f0de58ccf656 Pierrick Bouvier:
   bsd-user/syscall_defs.h: define STAT_TIME_T_EXT only for 32 bits
53* cf10273aff81 Alex Bennée:
   hw/intc: avoid byte swap fiddling in gicv3 its path
54* e9a8a10e84c1 Luca Bonissi:
   linux-user: Add termios2 support
55* 8d8c6aeee859 Luca Bonissi:
   linux-user: Add termios2 support to alpha target
56* edc741710ace Luca Bonissi:
   linux-user: Add termios2 support to hppa target
57* edf9184f4feb Luca Bonissi:
   linux-user: Add termios2 support to mips target
58* afbe0ff81c29 Luca Bonissi:
   linux-user: Add termios2 support to sh4 target
59* 947b971cad90 Luca Bonissi:
   linux-user: Add termios2 support to sparc target
60* 4f22fcb5c67f Vivian Wang:
   linux-user: Add missing termios baud rates
61* d68f0e2e9069 Icenowy Zheng:
   linux-user: fixup termios2 related things on PowerPC
62* 2eb8d9734355 Paolo Bonzini:
   target/i386/tcg: fix a few instructions that do not support VEX.L=1
63* e4f1a9b1dacb Thomas Huth:
   pc-bios/optionrom: Use 32-bit linker emulation for the optionroms
64* d9ca273f8f31 Alex Bennée:
   tests/functional: migrate sbsa_ref test images
65* 289e6a3edf50 Jeuk Kim:
   hw/ufs: Ensure DBC of PRDT uses only lower 18 bits
66* ed621cc8e2a6 Jeuk Kim:
   hw/ufs: fix CQE endianness and UPIU length
67* f78762a3cc81 Ilia Levi:
   hw/ufs: Fix mcq completion queue wraparound
68* 94e72135d4d6 Ilia Levi:
   tests/qtest/ufs-test: Add test for mcq completion queue wraparound
69* 587f4a1805c8 John Snow:
   python: fix msys64 wheel directory specification
70 eda9baa17a28 Akihiko Odaki:
   hw/nvme: Fix bootindex suffix use-after-free
71 46dee71a945d Gerd Hoffmann:
   hw/uefi: fix size negotiation
72 4c6521296d2b Cédric Le Goater:
   hw/adc: Fix out-of-bounds write in Aspeed ADC model
73 0a1d47706702 Nabih Estefan:
   hw/i2c/aspeed_i2c.c: Add a check for dma_read
74 9cbd8ee7f67f Jamin Lin:
   hw/i2c/aspeed: Fix wrong I2CC_DMA_LEN when I2CM_DMA_TX/RX_ADDR set first
75 efea7ddb4689 Jamin Lin:
   hw/i2c/aspeed_i2c: Fix DMA moving data into incorrect address
76 fd3a2c601ab4 Wafer Xie:
   vdpa: fix vhost-vdpa suspended state not be shared
77 fff77cfb8413 Dorinda Bassey:
   virtio-dmabuf: Ensure UUID persistence for hash table insertion
78 66cf169e29b0 Igor Mammedov:
   q35: Fix migration of SMRAM state
79 91c6438caffc zhenwei pi:
   hw/virtio/virtio-crypto: verify asym request size
80 7b913094c703 zhenwei pi:
   cryptodev-builtin: Limit the maximum size
81 e27194e087ae Joelle van Dyne:
   virtio-gpu-virgl: correct parent for blob memory region
82 efd581a8cd44 Li Chen:
   virtio-pmem: ignore empty queue notifications
83 3560b5197957 Honglei Huang:
   virtio-gpu: fix error handling in virgl_cmd_resource_create_blob
84 d22e9aec5723 Aleksandr Sergeev:
   linux-user/syscall.c: Prevent acquiring clone_lock while fork()
85 80c97930a93c Andrey Drobyshev:
   scripts/qemugdb: timers: Fix KeyError in 'qemu timers' command

(commit(s) marked with * were in previous series and are not resent)

