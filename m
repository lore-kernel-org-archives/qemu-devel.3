Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C9E63C5B572
	for <qemu-devel@archiver.kernel.org>; Mon, 17 Aug 2026 09:07:17 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wvtHw-0003F6-3n; Mon, 17 Aug 2026 05:05:48 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1wvtHi-0003DE-0V; Mon, 17 Aug 2026 05:05:34 -0400
Received: from isrv.corpit.ru ([212.248.84.144])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1wvtHe-0001aq-2l; Mon, 17 Aug 2026 05:05:33 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=tls.msk.ru; s=202602;
 t=1786957498; bh=ZkMtQTJQNR24RJiJtvD/HVRUHgs0leU5biQU7GxHRE8=;
 h=From:To:Cc:Subject:Date;
 b=WSgl1mo5IzAfduELvXZLvAL2t50hMb8sEG77/srxFuOYrZTMR1ICP8LbGFPj7b/1Y
 dWtPBm1RtbQqlYJob3yraZVKJlQvkJiKI7VbSTg/wxZ5XHqFSTbsJJtJ6L+vchDNWU
 YvOxgHhc3oplfO8eKF59vSy8HFzCBHvlL5Sg5dWxKT0DBjrKuJPV1d2jbXyoDHEWy/
 PuWSZriy5h0Bz2vaX7lhKjBsql5DtAvNEvLvZFc49OPJnhjBsgUR0XV+bsxLJJ7hDR
 bMhfbO16NYd9fOPpbxx5FXbHaFAl4hx2lIp7R1jeRWgNNSn8YKq//CJNfRkzl2MrNy
 C1f3h22jNFIgg==
Received: from tsrv.corpit.ru (tsrv.tls.msk.ru [192.168.177.2])
 by isrv.corpit.ru (Postfix) with ESMTP id DD8BD1CBA34;
 Mon, 17 Aug 2026 12:04:58 +0300 (MSK)
Received: from gandalf.tls.msk.ru (mjt.wg.tls.msk.ru [192.168.177.130])
 by tsrv.corpit.ru (Postfix) with ESMTP id BA7DA40D016;
 Mon, 17 Aug 2026 12:05:19 +0300 (MSK)
Received: by gandalf.tls.msk.ru (Postfix, from userid 1000)
 id 83B5530CE0; Mon, 17 Aug 2026 12:04:53 +0300 (MSK)
From: Michael Tokarev <mjt@tls.msk.ru>
To: qemu-devel@nongnu.org
Cc: qemu-stable@nongnu.org,
	Michael Tokarev <mjt@tls.msk.ru>
Subject: [Stable-11.1.1 00/42] Patch Round-up for stable 11.1.1,
 freeze on 2026-08-24
Date: Mon, 17 Aug 2026 12:04:05 +0300
Message-ID: <qemu-stable-11.1.1-20260817111826@cover.tls.msk.ru>
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

Patch freeze is 2026-08-24, and the release is planned for 2026-08-26:

  https://wiki.qemu.org/Planning/11.1

Please respond here or CC qemu-stable@nongnu.org on any additional patches
you think should (or shouldn't) be included in the release.

The changes which are staging for inclusion, with the original commit hash
from master branch, are given below the bottom line.

Thanks!

/mjt

--------------------------------------
01 bc4681990bb6 Mikulas Patocka:
   linux-user/sh4: Deliver SIGILL on invalid instruction
02 668d571bf0c2 Mikulas Patocka:
   linux-user/sh4: Initialize the FPSCR register on signal
03 f7ad7b1f8c81 Mikulas Patocka:
   linux-user/sh4: Fix crashes on signal delivery in conditional delay slot
04 01b4e06b5225 Saul Freedman:
   target/i386/kvm: Fix CET SSP MSR read feature check
05 0177efb9b758 Brian Cain:
   target/hexagon: accept valid packets rejected by check
06 d2504d4cea32 Brian Cain:
   tests/tcg/hexagon: add slot-assignment tests
07 8f5bf4fa0aa2 Brian Cain:
   target/hexagon: don't let an idef-parser dest clobber its own source
08 4713988da1c3 Matt Turner:
   linux-user: implement mount_setattr(2)
09 2fad751ed6b1 Philippe Mathieu-Daudé:
   hw/arm/aspeed: Add missing PCI_EXPRESS -> PCIE_PORT Kconfig dependency
10 6440880ed371 Philippe Mathieu-Daudé:
   hw/arm/aspeed: Add missing Kconfig dependencies on required components
11 9e96b5953e2f Brian Cain:
   host-utils: fix ssub32/64_saturate return type and clamp direction
12 aae77f5dddef Ilya Leoshkevich:
   target/s390x: Make PRNO TRNG interruptible
13 abe1d893f41d Ilya Leoshkevich:
   tests/tcg/s390x: Test PRNO TRNG interruptibility
14 0103cb1cd175 Ilya Leoshkevich:
   target/s390x: Fix DR/D INT64_MIN / -1 host crash
15 aa5d03bc9351 Ilya Leoshkevich:
   tests/tcg/s390x: Test DR overflow (INT64_MIN / -1)
16 4e994ebb0144 Christian Borntraeger:
   hw/char/sclpconsole-lm: avoid guest triggerable assert
17 df607fd05604 Joshua Daley:
   s390x/ipl: validate num_comp against iplb length before iterating
18 a9f1e84c6b82 Joshua Daley:
   pc-bios/s390-ccw: fix out-of-bounds read in iso_get_file_size()
19 33909d4ebd5c Joshua Daley:
   pc-bios/s390-ccw: bounds-check zipl menu entry index before array write
20 a3856a7ba44b Joshua Daley:
   pc-bios/s390-ccw: bound zipl menu strlen and replace VLA in 
   zipl_print_entry
21 c4d9412cdd1c Jared Rossi:
   pc-bios/s390-ccw: Fix off-by-one errors with loadparm and boot entries
22 9b3d68edb24d Eric Farman:
   pc-bios/s390-ccw.img: update s390x bios
23 2c32c273da6d Ilya Leoshkevich:
   target/s390x/tcg: Set STCK/STCKF condition code after the store
24 e79ea4472691 Ilya Leoshkevich:
   tests/tcg/s390x: Test STCKF condition code on a faulting store
25 ac7fa2e9d457 Peter Xu:
   migration/multifd: Validate next_packet_size in zlib/zstd recv
26 cf45083edc2b Peter Xu:
   migration/multifd: Replace assert() with error_setg() in recv paths
27 80776c4df92c Bin Guo:
   hw/intc/loongarch_pch_pic: Validate htmsi_vector before indexing 
   parent_irq
28 15700a66ecb5 Thomas Huth:
   hw/usb/dev-uas: Don't abort if guest provided an undersized buffer for 
   status
29 46099d990055 Thomas Huth:
   hw/net/vmxnet3: Do not abort if guest provides bad interrupt numbers
30 ebec7c732298 Denis V. Lunev:
   tests/qtest/ide-test: parametrize the ATAPI CD-ROM read test
31 fe543c2d787a Denis V. Lunev:
   tests/qtest/ide-test: add a multi-sector ATAPI DMA read test
32 502dbdfd9687 Denis V. Lunev:
   tests/qtest/ide-test: cover raw (2352-byte) ATAPI CD reads
33 de86ef3dfd33 Denis V. Lunev:
   tests/qtest/libqos/ahci: support raw (2352-byte) READ CD
34 31f13e71afd1 Denis V. Lunev:
   tests/qtest/ahci: cover raw (2352-byte) ATAPI CD reads
35 12289dc700d9 Denis V. Lunev:
   hw/ide/atapi: read the whole elementary transfer asynchronously
36 be1ee6a8f6e3 Denis V. Lunev:
   tests/qtest/ahci: regression test for ATAPI read vs. drain
37 6ccf1e73fc65 Dario Faggioli:
   hw/i386/pc: xen: reinstate the "xenfv" machine alias
38 59fc7b747d56 Peter Maydell:
   hw/net/rtl8139: Fix handling of VLAN tags on incoming short packets
39 f3a10c1c4547 Peter Maydell:
   hw/net/rtl8139: Send whole of vlan-tagged packet when doing loopback
40 60d010f66f2a Bin Guo:
   hw/block/pflash_cfi01: Restore ROMD mode after migration
41 6dab35f5492b Stefan Hajnoczi:
   hw/nvme: add SPDM_SOCKET Kconfig dependency
42 260d49d8e283 Alex Bennée:
   hw/elf_ops: defend against weird elf headers

