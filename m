Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2474BC5DF94
	for <qemu-devel@archiver.kernel.org>; Tue, 25 Aug 2026 07:07:18 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wylFR-00062v-RO; Tue, 25 Aug 2026 03:07:05 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1wylFP-00060w-IY; Tue, 25 Aug 2026 03:07:03 -0400
Received: from isrv.corpit.ru ([212.248.84.144])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1wylFM-0005rh-QL; Tue, 25 Aug 2026 03:07:03 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=tls.msk.ru; s=202602;
 t=1787641580; bh=7pvc1+VJDfsMjPUJaX9xtHjAp4FZTbF+OGh4iPUW+TQ=;
 h=From:To:Cc:Subject:Date;
 b=UunxW42kvaBFFrKPWrQ/QHpnGzyjosqiKhl+CazcHUcIpk02Ro6Kv9pBr9lXeaVvp
 4nr09/Mxd0XRJTLgNw0VpGU/i6GOyMUdntsFc/rN4FRTVWShlFkaK6pzxAFoBt1F2r
 S/0gEkzDD4nfjhAhR3+84nQabotsWLYFyvrNX7xBgcw95LSiqbV0tOL1Rc2hRQZ5uL
 uGoz02WK9XuatcxVb3PeGUFYuPjqTpELNfwf+13wBx5ebx1KUFrySc273T1zc/LW5M
 2oiOXE8w65FrdYeDcMEu6CphsrYv2tpx1xAJI20/4Ec322WNtWsSJQJ7g0xIwPBgNt
 xly3yLHGz9BMQ==
Received: from tsrv.corpit.ru (tsrv.tls.msk.ru [192.168.177.2])
 by isrv.corpit.ru (Postfix) with ESMTP id 66DBA1CE20D;
 Tue, 25 Aug 2026 10:06:20 +0300 (MSK)
Received: from gandalf.tls.msk.ru (mjt.wg.tls.msk.ru [192.168.177.130])
 by tsrv.corpit.ru (Postfix) with ESMTP id 29E33415F8A;
 Tue, 25 Aug 2026 10:06:57 +0300 (MSK)
Received: by gandalf.tls.msk.ru (Postfix, from userid 1000)
 id DCA82323FE; Tue, 25 Aug 2026 10:06:19 +0300 (MSK)
From: Michael Tokarev <mjt@tls.msk.ru>
To: qemu-devel@nongnu.org
Cc: qemu-stable@nongnu.org,
	Michael Tokarev <mjt@tls.msk.ru>
Subject: [Stable-11.1.1 v2 00/91] Patch Round-up for stable 11.1.1,
 freeze on 2026-08-24 (frozen)
Date: Tue, 25 Aug 2026 10:05:14 +0300
Message-ID: <qemu-stable-11.1.1-20260825100540@cover.tls.msk.ru>
X-Mailer: git-send-email 2.47.3
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=212.248.84.144; envelope-from=mjt@tls.msk.ru;
 helo=isrv.corpit.ru
X-Spam_score_int: -19
X-Spam_score: -2.0
X-Spam_bar: --
X-Spam_report: (-2.0 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

The following patches are queued for QEMU stable v11.1.1:

  https://gitlab.com/qemu-project/qemu/-/commits/staging-11.1

Patch freeze is 2026-08-24 (frozen), and the release is planned for 2026-08-26:

  https://wiki.qemu.org/Planning/11.1

Please respond here or CC qemu-stable@nongnu.org on any additional patches
you think should (or shouldn't) be included in the release.

The changes which are staging for inclusion, with the original commit hash
from master branch, are given below the bottom line.

Thanks!

/mjt

--------------------------------------
01* bc4681990bb6 Mikulas Patocka:
   linux-user/sh4: Deliver SIGILL on invalid instruction
02* 668d571bf0c2 Mikulas Patocka:
   linux-user/sh4: Initialize the FPSCR register on signal
03* f7ad7b1f8c81 Mikulas Patocka:
   linux-user/sh4: Fix crashes on signal delivery in conditional delay slot
04* 01b4e06b5225 Saul Freedman:
   target/i386/kvm: Fix CET SSP MSR read feature check
05* 0177efb9b758 Brian Cain:
   target/hexagon: accept valid packets rejected by check
06* d2504d4cea32 Brian Cain:
   tests/tcg/hexagon: add slot-assignment tests
07* 8f5bf4fa0aa2 Brian Cain:
   target/hexagon: don't let an idef-parser dest clobber its own source
08* 4713988da1c3 Matt Turner:
   linux-user: implement mount_setattr(2)
09* 2fad751ed6b1 Philippe Mathieu-Daudé:
   hw/arm/aspeed: Add missing PCI_EXPRESS -> PCIE_PORT Kconfig dependency
10* 6440880ed371 Philippe Mathieu-Daudé:
   hw/arm/aspeed: Add missing Kconfig dependencies on required components
11* 9e96b5953e2f Brian Cain:
   host-utils: fix ssub32/64_saturate return type and clamp direction
12* aae77f5dddef Ilya Leoshkevich:
   target/s390x: Make PRNO TRNG interruptible
13* abe1d893f41d Ilya Leoshkevich:
   tests/tcg/s390x: Test PRNO TRNG interruptibility
14* 0103cb1cd175 Ilya Leoshkevich:
   target/s390x: Fix DR/D INT64_MIN / -1 host crash
15* aa5d03bc9351 Ilya Leoshkevich:
   tests/tcg/s390x: Test DR overflow (INT64_MIN / -1)
16* 4e994ebb0144 Christian Borntraeger:
   hw/char/sclpconsole-lm: avoid guest triggerable assert
17* df607fd05604 Joshua Daley:
   s390x/ipl: validate num_comp against iplb length before iterating
18* a9f1e84c6b82 Joshua Daley:
   pc-bios/s390-ccw: fix out-of-bounds read in iso_get_file_size()
19* 33909d4ebd5c Joshua Daley:
   pc-bios/s390-ccw: bounds-check zipl menu entry index before array write
20* a3856a7ba44b Joshua Daley:
   pc-bios/s390-ccw: bound zipl menu strlen and replace VLA in 
   zipl_print_entry
21* c4d9412cdd1c Jared Rossi:
   pc-bios/s390-ccw: Fix off-by-one errors with loadparm and boot entries
22* 9b3d68edb24d Eric Farman:
   pc-bios/s390-ccw.img: update s390x bios
23* 2c32c273da6d Ilya Leoshkevich:
   target/s390x/tcg: Set STCK/STCKF condition code after the store
24* e79ea4472691 Ilya Leoshkevich:
   tests/tcg/s390x: Test STCKF condition code on a faulting store
25* ac7fa2e9d457 Peter Xu:
   migration/multifd: Validate next_packet_size in zlib/zstd recv
26* cf45083edc2b Peter Xu:
   migration/multifd: Replace assert() with error_setg() in recv paths
27* 80776c4df92c Bin Guo:
   hw/intc/loongarch_pch_pic: Validate htmsi_vector before indexing 
   parent_irq
28* 15700a66ecb5 Thomas Huth:
   hw/usb/dev-uas: Don't abort if guest provided an undersized buffer for 
   status
29* 46099d990055 Thomas Huth:
   hw/net/vmxnet3: Do not abort if guest provides bad interrupt numbers
30* ebec7c732298 Denis V. Lunev:
   tests/qtest/ide-test: parametrize the ATAPI CD-ROM read test
31* fe543c2d787a Denis V. Lunev:
   tests/qtest/ide-test: add a multi-sector ATAPI DMA read test
32* 502dbdfd9687 Denis V. Lunev:
   tests/qtest/ide-test: cover raw (2352-byte) ATAPI CD reads
33* de86ef3dfd33 Denis V. Lunev:
   tests/qtest/libqos/ahci: support raw (2352-byte) READ CD
34* 31f13e71afd1 Denis V. Lunev:
   tests/qtest/ahci: cover raw (2352-byte) ATAPI CD reads
35* 12289dc700d9 Denis V. Lunev:
   hw/ide/atapi: read the whole elementary transfer asynchronously
36* be1ee6a8f6e3 Denis V. Lunev:
   tests/qtest/ahci: regression test for ATAPI read vs. drain
37* 6ccf1e73fc65 Dario Faggioli:
   hw/i386/pc: xen: reinstate the "xenfv" machine alias
38* 59fc7b747d56 Peter Maydell:
   hw/net/rtl8139: Fix handling of VLAN tags on incoming short packets
39* f3a10c1c4547 Peter Maydell:
   hw/net/rtl8139: Send whole of vlan-tagged packet when doing loopback
40* 60d010f66f2a Bin Guo:
   hw/block/pflash_cfi01: Restore ROMD mode after migration
41* 6dab35f5492b Stefan Hajnoczi:
   hw/nvme: add SPDM_SOCKET Kconfig dependency
42* 260d49d8e283 Alex Bennée:
   hw/elf_ops: defend against weird elf headers
43 3181e53c13a1 Richard Henderson:
   tcg/optimize: INDEX_op_mul is commutative
44 5fe51606146c Richard Henderson:
   tcg/optimize: Fix s_mask computation for shifts
45 784b7f28e276 Ilya Chichkov:
   accel/tcg: Allow overlapping reads in record_save
46 0924d9d3db36 Simon Scherer:
   target/i386: Clear OF, SF, and AF for fcomi/fucomi
47 ce0ee66044be Simon Scherer:
   target/i386: fix incorrect decoding of EXTRQ_i
48 3589cd995b4f Craaijo, Jos:
   target/i386: fix long mode segment override prefix decoding
49 36f634fe4ab6 Andrey Polivoda:
   target/i386: allow transition to virtual-8086 mode only if CPL == 0 and 
   CPU is not in long mode
50 380b95961817 Andrey Polivoda:
   target/i386: decode opcode extensions group 3 /1 as TEST
51 eb3f7fe382ba Paolo Bonzini:
   serial: clear transmit retry callback on unrealize
52 501187d0bc62 Paolo Bonzini:
   meson: make linker warnings non-fatal on Linux
53 215a4fc08f2a Jan Mercl:
   target/loongarch: check FPE before reading fcc in bceqz/bcnez
54 e131c28b6eb2 Richard Henderson:
   tcg: Return success from tcg_region_alloc__locked
55 fcdbc78ad4de Richard Henderson:
   tcg: Return success from tcg_region_alloc
56 f5d2d8532f3c Richard Henderson:
   tcg: Defer tb_flush when initial thread region alloc fails
57 d05febdd32cc Richard Henderson:
   hw/intc: Fix arm kvm gicv3 selection
58 a0c093900d84 Philippe Mathieu-Daudé:
   hw/intc/arm_gicv3: Have GIC kconfig select GICv3 for HVF and WHPX
59 b4f6f672a3e1 Richard Henderson:
   tcg: Export tcg_gen_ussub_i{32,64,tl}
60 bab972a2b0e3 Richard Henderson:
   target/arm: Fix SVE2 WHILEWR/WHILERW zero diff boundary case
61 32953700108c Richard Henderson:
   tests/tcg/aarch64: Add regression test for whilewr/whilerw
62 eea4de1bd8e8 Chinmay Rath:
   hw/watchdog: Add lower bound check for watchdogNumber
63 7c84752396d1 Mohamed Mediouni:
   whpx: i386: fix xsaves enablement in legacy probing path
64 32452bac6d99 Mohamed Mediouni:
   hw/i386: fw_cfg: do not set VMX feature control on WHPX
65 3bfcd8ef6bd2 Mohamed Mediouni:
   whpx: i386: enable fast hypercall output
66 7b0516912e44 Mohamed Mediouni:
   whpx: i386: synchronise PAT too
67 37ce6d8da757 Mohamed Mediouni:
   whpx: i386: work around Hyper-V FP state oddities
68 93f38b6e8817 Mohamed Mediouni:
   whpx: i386: inject back db
69 4a884ba94b43 Max Chou:
   target/riscv: Fix PC sync in trans_sspopchk for CFI exception handling
70 ebef6685a1a2 Abhigyan Kumar:
   target/riscv: use SXL instead of MXL for read_sstatus
71 d5ab0bdefe41 Zeng Chi:
   target/riscv: Fix memory leak in riscv_trigger_unrealize()
72 5a9fa8b58209 Zephyr Li:
   target/riscv: do not count ECALL in minstret
73 51362da8f73b Ivan Efremov:
   target/riscv: Fix seed CSR sign extension
74 e80cf2947978 Ivan Efremov:
   tests/qtest: Add seed CSR zero extension test
75 6985cfc87512 TANG Tiancheng:
   disas/riscv: Fix th.srri decoding
76 7a8454ef2930 TANG Tiancheng:
   disas/riscv: Fix 6-bit immediate extraction
77 7899d3c6bdb0 TANG Tiancheng:
   disas/riscv: Use signed type for vector immediates
78 00cec77a7f9f TANG Tiancheng:
   disas/riscv: Decode unsigned vector immediates as unsigned
79 f16fd27b3fe3 Andrew Jones:
   hw/riscv/riscv-iommu: fix U-bit check to apply only to leaf S/VS-stage 
   PTEs
80 aa51eec00446 Andrew Jones:
   hw/riscv/riscv-iommu: preserve requested perm in spa_fetch()
81 bd1ee9ab3c39 A-Shehab:
   target/riscv: allow menvcfg/henvcfg LPE and SSE bits on RV32
82 d4151cf26751 Richard Henderson:
   disas/riscv: Fix rv32 encoding of zext.h
83 d610e55c8390 Richard Henderson:
   disas/riscv: Fix isa decoding of rev8
84 ecbd3a031f12 Richard Henderson:
   disas/riscv: Fix typo in th.lbib format
85 12289f2f9a0f wangyang:
   target/riscv: honor zicbo* envcfg gating in linux-user mode
86 af1e669cef16 wangyang:
   target/riscv: reject FMV.X.W/FMV.W.X under Zfinx
87 e68cc2e5cd28 wangyang:
   target/riscv: enforce even register constraints for Zdinx fcvt pairs
88 e4ae434836a9 Chao Liu:
   tests/qtest: remove trace output from k230 watchdog test
89 409c7d8682ae Joel Stanley:
   target/riscv: Restore register dump zero padding
90 a9779d24be31 Frédéric Pétrot:
   target/riscv: Allow UXL to be 3 in mstatus on rv128
91 85d38315fd19 Christian S. Lima:
   target/riscv/tcg: sret in virtual user mode raises virtual instruction 
   exception

(commit(s) marked with * were in previous series and are not resent)

