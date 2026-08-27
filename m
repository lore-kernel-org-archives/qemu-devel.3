Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A7F94C61DC4
	for <qemu-devel@archiver.kernel.org>; Thu, 27 Aug 2026 15:57:30 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wzcTL-0007NE-D9; Thu, 27 Aug 2026 11:56:59 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1wzcTE-0007Kq-H6; Thu, 27 Aug 2026 11:56:52 -0400
Received: from isrv.corpit.ru ([212.248.84.144])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1wzcTC-00052W-8A; Thu, 27 Aug 2026 11:56:52 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=tls.msk.ru; s=202602;
 t=1787846201; bh=JWcEKlCrOGD1sTwhyHBj3EVq4lLeCeQa83TRHshuXTk=;
 h=From:To:Cc:Subject:Date;
 b=r+Rukw1grQDLpfHMA700B2gB/EiPyTCj3tPOAZGVMkxFQTK60Yg3qycvhEhK/JLAm
 bjpHCccbik31N8jvySjUEGDODAp62fX+Y5NXBHbmQYVtVJQutBbIcxIjV5rTgpK0sE
 IasZ4mTIgXJ4Xz3c9QpJfFUEi9H5nUvZfw750vHJqIlWWIkyJ4VLYnyDMoxdiF4KYl
 ntG1w3OmLcUNSMMGjwm7diRVt7wwxKIzjfY+mH+l6+VMd6VRUBuwQwOtnwJu8xPhou
 mCDoofhnVR04xdEWgsbtRwLe4AKZhrlvcT+lE66vCamP7GtVbyQPMlIYCjOe9FPzvC
 iChUm2Wp3rs6Q==
Received: from tsrv.corpit.ru (tsrv.tls.msk.ru [192.168.177.2])
 by isrv.corpit.ru (Postfix) with ESMTP id 495D81CF28F;
 Thu, 27 Aug 2026 18:56:41 +0300 (MSK)
Received: from gandalf.tls.msk.ru (mjt.wg.tls.msk.ru [192.168.177.130])
 by tsrv.corpit.ru (Postfix) with ESMTP id 8432641948A;
 Thu, 27 Aug 2026 18:56:44 +0300 (MSK)
Received: by gandalf.tls.msk.ru (Postfix, from userid 1000)
 id BB5C936397; Thu, 27 Aug 2026 18:56:08 +0300 (MSK)
From: Michael Tokarev <mjt@tls.msk.ru>
To: qemu-devel@nongnu.org
Cc: qemu-stable@nongnu.org,
	Michael Tokarev <mjt@tls.msk.ru>
Subject: [ANNOUNCE] QEMU 11.1.1 Stable released
Date: Thu, 27 Aug 2026 18:56:06 +0300
Message-ID: <20260827155607.639070-1-mjt@tls.msk.ru>
X-Mailer: git-send-email 2.47.3
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
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

Hi everyone,

The QEMU v11.1.1 stable release is now available.

You can grab the tarball from our download page here:

  https://www.qemu.org/download/#source

  https://download.qemu.org/qemu-11.1.1.tar.xz
  https://download.qemu.org/qemu-11.1.1.tar.xz.sig (signature)

v11.1.1 is now tagged in the official qemu.git repository, and the
stable-11.1 branch has been updated accordingly:

  https://gitlab.com/qemu-project/qemu/-/commits/stable-11.1

There are 91 changes since the previous v11.1.0 release.

Thank you everyone who has been involved and helped with the stable series!

/mjt

Changelog (stable-11.1-hash master-hash Author Name: Commmit-Subject):

c3d48b7d1e8 Michael Tokarev:
 Update version for 11.1.1 release
3e2849a33c9 85d38315fd Christian S. Lima:
 target/riscv/tcg: sret in virtual user mode raises virtual instruction exception
486ce35b39b a9779d24be Frédéric Pétrot:
 target/riscv: Allow UXL to be 3 in mstatus on rv128
2c0db8a985e 409c7d8682 Joel Stanley:
 target/riscv: Restore register dump zero padding
f9530009f69 e4ae434836 Chao Liu:
 tests/qtest: remove trace output from k230 watchdog test
e0611379203 e68cc2e5cd wangyang:
 target/riscv: enforce even register constraints for Zdinx fcvt pairs
d1f63a04cf8 af1e669cef wangyang:
 target/riscv: reject FMV.X.W/FMV.W.X under Zfinx
bb72fd70109 12289f2f9a wangyang:
 target/riscv: honor zicbo* envcfg gating in linux-user mode
adf74c01ed7 ecbd3a031f Richard Henderson:
 disas/riscv: Fix typo in th.lbib format
2c2d25853e1 d610e55c83 Richard Henderson:
 disas/riscv: Fix isa decoding of rev8
326411de08f d4151cf267 Richard Henderson:
 disas/riscv: Fix rv32 encoding of zext.h
d767c0d95ea bd1ee9ab3c A-Shehab:
 target/riscv: allow menvcfg/henvcfg LPE and SSE bits on RV32
292af62ed09 aa51eec004 Andrew Jones:
 hw/riscv/riscv-iommu: preserve requested perm in spa_fetch()
c75952b065b f16fd27b3f Andrew Jones:
 hw/riscv/riscv-iommu: fix U-bit check to apply only to leaf S/VS-stage PTEs
ab8547c74c1 00cec77a7f TANG Tiancheng:
 disas/riscv: Decode unsigned vector immediates as unsigned
a15c135c2c7 7899d3c6bd TANG Tiancheng:
 disas/riscv: Use signed type for vector immediates
508eb3dd61e 7a8454ef29 TANG Tiancheng:
 disas/riscv: Fix 6-bit immediate extraction
36024d5d98f 6985cfc875 TANG Tiancheng:
 disas/riscv: Fix th.srri decoding
88b441bc373 e80cf29479 Ivan Efremov:
 tests/qtest: Add seed CSR zero extension test
b0b3d341ca8 51362da8f7 Ivan Efremov:
 target/riscv: Fix seed CSR sign extension
1edfaf11576 5a9fa8b582 Zephyr Li:
 target/riscv: do not count ECALL in minstret
f449779db24 d5ab0bdefe Zeng Chi:
 target/riscv: Fix memory leak in riscv_trigger_unrealize()
44e88d1a1ef ebef6685a1 Abhigyan Kumar:
 target/riscv: use SXL instead of MXL for read_sstatus
ef002da4944 4a884ba94b Max Chou:
 target/riscv: Fix PC sync in trans_sspopchk for CFI exception handling
039201db1f9 93f38b6e88 Mohamed Mediouni:
 whpx: i386: inject back db
b9a42d07b4a 37ce6d8da7 Mohamed Mediouni:
 whpx: i386: work around Hyper-V FP state oddities
a4049cf8690 7b0516912e Mohamed Mediouni:
 whpx: i386: synchronise PAT too
5c16e7ad5dc 3bfcd8ef6b Mohamed Mediouni:
 whpx: i386: enable fast hypercall output
fd87e7a8c54 32452bac6d Mohamed Mediouni:
 hw/i386: fw_cfg: do not set VMX feature control on WHPX
793bc2f82f9 7c84752396 Mohamed Mediouni:
 whpx: i386: fix xsaves enablement in legacy probing path
3c3bdea4c4a eea4de1bd8 Chinmay Rath:
 hw/watchdog: Add lower bound check for watchdogNumber
362f1623616 3295370010 Richard Henderson:
 tests/tcg/aarch64: Add regression test for whilewr/whilerw
371cff91208 bab972a2b0 Richard Henderson:
 target/arm: Fix SVE2 WHILEWR/WHILERW zero diff boundary case
17532efeaa6 b4f6f672a3 Richard Henderson:
 tcg: Export tcg_gen_ussub_i{32,64,tl}
802ab469a5d a0c093900d Philippe Mathieu-Daudé:
 hw/intc/arm_gicv3: Have GIC kconfig select GICv3 for HVF and WHPX
a1d64c7ecd9 d05febdd32 Richard Henderson:
 hw/intc: Fix arm kvm gicv3 selection
58a5803f22c f5d2d8532f Richard Henderson:
 tcg: Defer tb_flush when initial thread region alloc fails
14976fc01b7 fcdbc78ad4 Richard Henderson:
 tcg: Return success from tcg_region_alloc
d5367567581 e131c28b6e Richard Henderson:
 tcg: Return success from tcg_region_alloc__locked
b947b77e271 215a4fc08f Jan Mercl:
 target/loongarch: check FPE before reading fcc in bceqz/bcnez
6e7f8933d73 501187d0bc Paolo Bonzini:
 meson: make linker warnings non-fatal on Linux
780da10b0a7 eb3f7fe382 Paolo Bonzini:
 serial: clear transmit retry callback on unrealize
abfd1af48bd 380b959618 Andrey Polivoda:
 target/i386: decode opcode extensions group 3 /1 as TEST
4b6ba25a739 36f634fe4a Andrey Polivoda:
 target/i386: allow transition to virtual-8086 mode only if CPL == 0 and CPU is not in long mode
6cc5f14292f 3589cd995b Craaijo, Jos:
 target/i386: fix long mode segment override prefix decoding
b66ebf444bf ce0ee66044 Simon Scherer:
 target/i386: fix incorrect decoding of EXTRQ_i
1621cc4971b 0924d9d3db Simon Scherer:
 target/i386: Clear OF, SF, and AF for fcomi/fucomi
1215e2a16c8 784b7f28e2 Ilya Chichkov:
 accel/tcg: Allow overlapping reads in record_save
075194c6589 5fe5160614 Richard Henderson:
 tcg/optimize: Fix s_mask computation for shifts
f50d3d4a0ba 3181e53c13 Richard Henderson:
 tcg/optimize: INDEX_op_mul is commutative
1cdd486e5e8 260d49d8e2 Alex Bennée:
 hw/elf_ops: defend against weird elf headers
5b8167a83d2 6dab35f549 Stefan Hajnoczi:
 hw/nvme: add SPDM_SOCKET Kconfig dependency
5ea267f2408 60d010f66f Bin Guo:
 hw/block/pflash_cfi01: Restore ROMD mode after migration
e244b68eee8 f3a10c1c45 Peter Maydell:
 hw/net/rtl8139: Send whole of vlan-tagged packet when doing loopback
c9f0ac98b2a 59fc7b747d Peter Maydell:
 hw/net/rtl8139: Fix handling of VLAN tags on incoming short packets
f04f55578ae 6ccf1e73fc Dario Faggioli:
 hw/i386/pc: xen: reinstate the "xenfv" machine alias
76e3cd5a96d be1ee6a8f6 Denis V. Lunev:
 tests/qtest/ahci: regression test for ATAPI read vs. drain
1e4ab5af46a 12289dc700 Denis V. Lunev:
 hw/ide/atapi: read the whole elementary transfer asynchronously
de0ba7ecd9e 31f13e71af Denis V. Lunev:
 tests/qtest/ahci: cover raw (2352-byte) ATAPI CD reads
033fdd2653a de86ef3dfd Denis V. Lunev:
 tests/qtest/libqos/ahci: support raw (2352-byte) READ CD
7f7ad47bd99 502dbdfd96 Denis V. Lunev:
 tests/qtest/ide-test: cover raw (2352-byte) ATAPI CD reads
a34b3fd1e86 fe543c2d78 Denis V. Lunev:
 tests/qtest/ide-test: add a multi-sector ATAPI DMA read test
043b76442bd ebec7c7322 Denis V. Lunev:
 tests/qtest/ide-test: parametrize the ATAPI CD-ROM read test
b203a315941 46099d9900 Thomas Huth:
 hw/net/vmxnet3: Do not abort if guest provides bad interrupt numbers
14addd62843 15700a66ec Thomas Huth:
 hw/usb/dev-uas: Don't abort if guest provided an undersized buffer for status
15344d76f2f 80776c4df9 Bin Guo:
 hw/intc/loongarch_pch_pic: Validate htmsi_vector before indexing parent_irq
d9ef500245b cf45083edc Peter Xu:
 migration/multifd: Replace assert() with error_setg() in recv paths
a647c8c0d75 ac7fa2e9d4 Peter Xu:
 migration/multifd: Validate next_packet_size in zlib/zstd recv
12d97018d62 e79ea44726 Ilya Leoshkevich:
 tests/tcg/s390x: Test STCKF condition code on a faulting store
7b8decf5dde 2c32c273da Ilya Leoshkevich:
 target/s390x/tcg: Set STCK/STCKF condition code after the store
41159464971 9b3d68edb2 Eric Farman:
 pc-bios/s390-ccw.img: update s390x bios
ad0e925eb41 c4d9412cdd Jared Rossi:
 pc-bios/s390-ccw: Fix off-by-one errors with loadparm and boot entries
623610af04c a3856a7ba4 Joshua Daley:
 pc-bios/s390-ccw: bound zipl menu strlen and replace VLA in zipl_print_entry
82ce8ab787c 33909d4ebd Joshua Daley:
 pc-bios/s390-ccw: bounds-check zipl menu entry index before array write
15170634bc2 a9f1e84c6b Joshua Daley:
 pc-bios/s390-ccw: fix out-of-bounds read in iso_get_file_size()
656906057e9 df607fd056 Joshua Daley:
 s390x/ipl: validate num_comp against iplb length before iterating
987183f34d2 4e994ebb01 Christian Borntraeger:
 hw/char/sclpconsole-lm: avoid guest triggerable assert
6bbe986ce70 aa5d03bc93 Ilya Leoshkevich:
 tests/tcg/s390x: Test DR overflow (INT64_MIN / -1)
811040e242c 0103cb1cd1 Ilya Leoshkevich:
 target/s390x: Fix DR/D INT64_MIN / -1 host crash
412e2834cbc abe1d893f4 Ilya Leoshkevich:
 tests/tcg/s390x: Test PRNO TRNG interruptibility
84844c9e8de aae77f5ddd Ilya Leoshkevich:
 target/s390x: Make PRNO TRNG interruptible
277d4e94c1d 9e96b5953e Brian Cain:
 host-utils: fix ssub32/64_saturate return type and clamp direction
dd91028cd58 6440880ed3 Philippe Mathieu-Daudé:
 hw/arm/aspeed: Add missing Kconfig dependencies on required components
e2f860671ea 2fad751ed6 Philippe Mathieu-Daudé:
 hw/arm/aspeed: Add missing PCI_EXPRESS -> PCIE_PORT Kconfig dependency
8a1d98d7ddc 4713988da1 Matt Turner:
 linux-user: implement mount_setattr(2)
c1522f68f58 8f5bf4fa0a Brian Cain:
 target/hexagon: don't let an idef-parser dest clobber its own source
dc761320844 d2504d4cea Brian Cain:
 tests/tcg/hexagon: add slot-assignment tests
d1c5b1006fd 0177efb9b7 Brian Cain:
 target/hexagon: accept valid packets rejected by check
a1a6e8ab136 01b4e06b52 Saul Freedman:
 target/i386/kvm: Fix CET SSP MSR read feature check
4a9db4d91bb f7ad7b1f8c Mikulas Patocka:
 linux-user/sh4: Fix crashes on signal delivery in conditional delay slot
73ac7cff737 668d571bf0 Mikulas Patocka:
 linux-user/sh4: Initialize the FPSCR register on signal
32f305bca18 bc4681990b Mikulas Patocka:
 linux-user/sh4: Deliver SIGILL on invalid instruction


