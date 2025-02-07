Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 67F53C0219C
	for <qemu-devel@archiver.kernel.org>; Fri,  7 Feb 2025 10:02:03 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tgL9Y-0006mf-S9; Fri, 07 Feb 2025 05:00:05 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1tgL9W-0006mI-Re; Fri, 07 Feb 2025 05:00:02 -0500
Received: from isrv.corpit.ru ([86.62.121.231])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1tgL9U-0001pl-7y; Fri, 07 Feb 2025 05:00:02 -0500
Received: from tsrv.corpit.ru (tsrv.tls.msk.ru [192.168.177.2])
 by isrv.corpit.ru (Postfix) with ESMTP id D4359E7345;
 Fri, 07 Feb 2025 12:59:14 +0300 (MSK)
Received: from gandalf.tls.msk.ru (mjt.wg.tls.msk.ru [192.168.177.130])
 by tsrv.corpit.ru (Postfix) with ESMTP id 470E01B09C9;
 Fri,  7 Feb 2025 12:59:56 +0300 (MSK)
Received: by gandalf.tls.msk.ru (Postfix, from userid 1000)
 id 0C27F52D73; Fri, 07 Feb 2025 12:59:56 +0300 (MSK)
From: Michael Tokarev <mjt@tls.msk.ru>
To: qemu-devel@nongnu.org
Cc: qemu-stable@nongnu.org,
	Michael Tokarev <mjt@tls.msk.ru>
Subject: [Stable-9.2.1 v2 00/49] Patch Round-up for stable 9.2.1,
 freeze on 2025-02-06 (frozen)
Date: Fri,  7 Feb 2025 12:59:43 +0300
Message-Id: <qemu-stable-9.2.1-20250207102656@cover.tls.msk.ru>
X-Mailer: git-send-email 2.39.5
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=86.62.121.231; envelope-from=mjt@tls.msk.ru;
 helo=isrv.corpit.ru
X-Spam_score_int: -68
X-Spam_score: -6.9
X-Spam_bar: ------
X-Spam_report: (-6.9 / 5.0 requ) BAYES_00=-1.9, RCVD_IN_DNSWL_HI=-5,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

The following patches are queued for QEMU stable v9.2.1:

  https://gitlab.com/qemu-project/qemu/-/commits/staging-9.2

Patch freeze is 2025-02-06 (frozen), and the release is planned for 2025-02-08:

  https://wiki.qemu.org/Planning/9.2

Please respond here or CC qemu-stable@nongnu.org on any patches
you think shouldn't be included in the release.

The changes which are staging for inclusion, with the original commit hash
from master branch, are given below the bottom line.

Thanks!

/mjt

--------------------------------------
01* d06a9d843fb6 Christian Schoenebeck:
   9pfs: fix regression regarding CVE-2023-2861
02* 04e006ab36a8 Richard Henderson:
   tcg: Reset free_temps before tcg_optimize
03* b438362a1425 Roman Artemev:
   tcg/riscv: Fix StoreStore barrier generation
04* 57e2cc9abf5d Gerd Hoffmann:
   x86/loader: only patch linux kernels
05* 0f5715e4b570 Gerd Hoffmann:
   roms: re-add edk2-basetools target
06* 74dc38d0c6c1 Heinrich Schuchardt:
   pc-bios: add missing riscv64 descriptor
07* 9678b9c50572 Peter Maydell:
   hw/intc/arm_gicv3_its: Zero initialize local DTEntry etc structs
08* e2d98f257138 Thomas Huth:
   meson.build: Disallow libnfs v6 to fix the broken macOS build
09* 3f2a05b31ee9 Maciej S. Szmigiero:
   target/i386: Reset TSCs of parked vCPUs too on VM reset
10* 0d0141fadc90 Yong-Xuan Wang:
   hw/intc/riscv_aplic: Fix APLIC in_clrip and clripnum write emulation
11* 14e568ab4836 David Hildenbrand:
   s390x/s390-virtio-ccw: don't crash on weird RAM sizes
12* d41989e75483 Bibo Mao:
   target/loongarch: Use actual operand size with vbsrl check
13* 916f50172baa Philippe Mathieu-Daudé:
   docs: Correct '-runas' and '-fsdev/-virtfs proxy' indentation
14* b4859e8f33a7 Philippe Mathieu-Daudé:
   docs: Correct release of TCG trace-events removal
15* 93dcc9390e5a Han Han:
   target/i386/cpu: Fix notes for CPU models
16* d127294f265e Shameer Kolothum:
   migration/multifd: Fix compile error caused by page_size usage
17* b93d897ea2f0 Fabiano Rosas:
   migration/multifd: Fix compat with QEMU < 9.0
18* 86bee9e0c761 Fabiano Rosas:
   migration: Add more error handling to analyze-migration.py
19* 2aead53d39b8 Fabiano Rosas:
   migration: Remove unused argument in vmsd_desc_field_end
20* 69d1f784569f Fabiano Rosas:
   migration: Fix parsing of s390 stream
21* c76ee1f6255c Fabiano Rosas:
   s390x: Fix CSS migration
22* f52965bf0eee Fabiano Rosas:
   migration: Rename vmstate_info_nullptr
23* 9867c3a7ced1 Peter Xu:
   migration: Dump correct JSON format for nullptr replacement
24* 35049eb0d2fc Fabiano Rosas:
   migration: Fix arrays of pointers in JSON writer
25* cdc3970f8597 Yuan Liu:
   multifd: bugfix for migration using compression methods
26* 2588a5f99b0c Yuan Liu:
   multifd: bugfix for incorrect migration data with QPL compression
27* a523bc52166c Yuan Liu:
   multifd: bugfix for incorrect migration data with qatzip compression
28* ec2dfb7c389b Philippe Mathieu-Daudé:
   tests/functional/test_rx_gdbsim: Use stable URL for test_linux_sash
29* 4572dacc33e2 Keoseong Park:
   hw/ufs: Adjust value to match CPU's endian format
30* a87077316ed2 Philippe Mathieu-Daudé:
   tests/qtest/boot-serial-test: Correct HPPA machine name
31* 78b0c15a563a Gabriel Barrantes:
   backends/cryptodev-vhost-user: Fix local_error leaks
32* bb5b7fced6b5 Phil Dennis-Jordan:
   hw/usb/hcd-xhci-pci: Use modulo to select MSI vector as per spec
33* 694632fd4498 Sebastian Ott:
   pci: ensure valid link status bits for downstream ports
34* 42e2a7a0ab23 Nicholas Piggin:
   pci/msix: Fix msix pba read vector poll end calculation
35* 1ad32644fe4c Igor Mammedov:
   tests: acpi: whitelist expected blobs
36* 0b053391985a Igor Mammedov:
   pci: acpi: Windows 'PCI Label Id' bug workaround
37* 9fb1c9a1bb26 Igor Mammedov:
   tests: acpi: update expected blobs
38* 1ce979e7269a Li Zhijian:
   hw/cxl: Fix msix_notify: Assertion `vector < dev->msix_entries_nr`
39* be27b5149c86 Paolo Bonzini:
   make-release: only leave tarball of wrap-file subprojects
40* cf4c26355188 Zhao Liu:
   i386/cpu: Mark avx10_version filtered when prefix is NULL
41* 145f12ea885c Daniel P. Berrangé:
   crypto: fix bogus error benchmarking pbkdf on fast machines
42 8113dbbcdaee Zhao Liu:
   stub: Fix build failure with --enable-user --disable-system --enable-tools
43 1edc3d43f20d Peter Maydell:
   target/arm: arm_reset_sve_state() should set FPSR, not FPCR
44 664280abddcb Hongren Zheng:
   hw/usb/canokey: Fix buffer overflow for OUT packet
45 719168fba7c3 Steve Sistare:
   physmem: fix qemu_ram_alloc_from_fd size calculation
46 e43ced8be18d Ilya Leoshkevich:
   target/s390x: Fix MVC not always invalidating translation blocks
47 84dfdcbff33f Laurent Vivier:
   net: Fix announce_self
48 c6a1b591a68b Laurent Vivier:
   net/dump: Correctly compute Ethernet packet offset
49 8b647bd35250 Dominik 'Disconnect3d' Czarnota:
   gdbstub/user-target: fix gdbserver int format (%d -> %x)

(commit(s) marked with * were in previous series and are not resent)

