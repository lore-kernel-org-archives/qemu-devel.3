Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 913D4C02196
	for <qemu-devel@archiver.kernel.org>; Fri,  7 Feb 2025 10:22:43 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tgLUV-0007yT-Kn; Fri, 07 Feb 2025 05:21:44 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1tgLUS-0007yE-U9; Fri, 07 Feb 2025 05:21:41 -0500
Received: from isrv.corpit.ru ([86.62.121.231])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1tgLUQ-0006It-Go; Fri, 07 Feb 2025 05:21:40 -0500
Received: from tsrv.corpit.ru (tsrv.tls.msk.ru [192.168.177.2])
 by isrv.corpit.ru (Postfix) with ESMTP id A8650E7378;
 Fri, 07 Feb 2025 13:20:54 +0300 (MSK)
Received: from gandalf.tls.msk.ru (mjt.wg.tls.msk.ru [192.168.177.130])
 by tsrv.corpit.ru (Postfix) with ESMTP id 215A51B0A6A;
 Fri,  7 Feb 2025 13:21:36 +0300 (MSK)
Received: by gandalf.tls.msk.ru (Postfix, from userid 1000)
 id 16BBF52D85; Fri, 07 Feb 2025 13:21:36 +0300 (MSK)
From: Michael Tokarev <mjt@tls.msk.ru>
To: qemu-devel@nongnu.org
Cc: qemu-stable@nongnu.org,
	Michael Tokarev <mjt@tls.msk.ru>
Subject: [Stable-8.2.9 v2 00/51] Patch Round-up for stable 8.2.9,
 freeze on 2025-02-06 (frozen)
Date: Fri,  7 Feb 2025 13:21:26 +0300
Message-Id: <qemu-stable-8.2.9-20250207102509@cover.tls.msk.ru>
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

The following patches are queued for QEMU stable v8.2.9:

  https://gitlab.com/qemu-project/qemu/-/commits/staging-8.2

Patch freeze is 2025-02-06 (frozen), and the release is planned for 2025-02-08:

  https://wiki.qemu.org/Planning/8.2

Please respond here or CC qemu-stable@nongnu.org on any patches
you think shouldn't be included in the release.

The changes which are staging for inclusion, with the original commit hash
from master branch, are given below the bottom line.

Thanks!

/mjt

--------------------------------------
01* 3bf7dcd47a3d Peter Maydell:
   hw/intc/openpic: Avoid taking address of out-of-bounds array index
02* 3d7680fb18c7 Peter Maydell:
   bitops.h: Define bit operations on 'uint32_t' arrays
03* 335be5bc44aa Peter Maydell:
   hw/intc/loongarch_extioi: Use set_bit32() and clear_bit32() for s->isr
04* d95fd9838b54 Ilya Leoshkevich:
   linux-user: Fix strace output for s390x mmap()
05* a8575f7fb2f2 Akihiko Odaki:
   virtio-net: Fix size check in dhclient workaround
06* 5102f9df4a9a Kevin Wolf:
   qdev: Fix set_pci_devfn() to visit option only once
07* fbdea3d6c13d Jakub Jelen:
   ssh: Do not switch session to non-blocking mode
08* 3abb67323aee Guenter Roeck:
   scsi: megasas: Internal cdbs have 16-byte length
09* abf0f092c1dd Christian Schoenebeck:
   tests/9p: fix Rreaddir response name
10* 4ec984965079 Christian Schoenebeck:
   tests/9p: add missing Rgetattr response name
11* 462db8fb1d40 Christian Schoenebeck:
   tests/9p: add 'use-after-unlink' test
12* 3bc4db44430f Christian Schoenebeck:
   9pfs: remove obsolete comment in v9fs_getattr()
13* c81e7219e073 Christian Schoenebeck:
   9pfs: fix 'Tgetattr' after unlink
14* eaab44ccc59b Christian Schoenebeck:
   tests/9p: also check 'Tgetattr' in 'use-after-unlink' test
15* fa416ae6157a Nicholas Piggin:
   target/ppc: Fix non-maskable interrupt while halted
16* 9162f1012576 Klaus Jensen:
   hw/nvme: fix msix_uninit with exclusive bar
17* 6651f8f2e505 Klaus Jensen:
   hw/nvme: take a reference on the subsystem on vf realization
18* 26dcf2be7e15 Ahmad Fatoum:
   hw/openrisc/openrisc_sim: keep serial@90000000 as default
19* 5311599cdc48 Peter Maydell:
   target/riscv: Avoid bad shift in riscv_cpu_do_interrupt()
20* b4358ed4fd29 Thomas Huth:
   Update FreeBSD CI jobs FreeBSD 14.1
21* cc6cb422e095 Thomas Huth:
   .gitlab-ci.d/cirrus: Remove the netbsd and openbsd jobs
22* de11da6448ca Philippe Mathieu-Daudé:
   .gitlab-ci.d/cirrus: Drop support for macOS 13 (Ventura)
23* d06a9d843fb6 Christian Schoenebeck:
   9pfs: fix regression regarding CVE-2023-2861
24* b438362a1425 Roman Artemev:
   tcg/riscv: Fix StoreStore barrier generation
25* e7fca81e1705 Alexander Bulekov:
   fuzz: specify audiodev for usb-audio
26* 57e2cc9abf5d Gerd Hoffmann:
   x86/loader: only patch linux kernels
27* 6539c73dccfa Gerd Hoffmann:
   edk2: get version + date from git submodule
28* 6494a08d1025 Gerd Hoffmann:
   edk2: commit version info
29* 0f5715e4b570 Gerd Hoffmann:
   roms: re-add edk2-basetools target
30* 9678b9c50572 Peter Maydell:
   hw/intc/arm_gicv3_its: Zero initialize local DTEntry etc structs
31* e2d98f257138 Thomas Huth:
   meson.build: Disallow libnfs v6 to fix the broken macOS build
32* eea5aeef84e1 Albert Esteve:
   vhost-user: fix shared object return values
33* 14e568ab4836 David Hildenbrand:
   s390x/s390-virtio-ccw: don't crash on weird RAM sizes
34* d41989e75483 Bibo Mao:
   target/loongarch: Use actual operand size with vbsrl check
35* b4859e8f33a7 Philippe Mathieu-Daudé:
   docs: Correct release of TCG trace-events removal
36* 93dcc9390e5a Han Han:
   target/i386/cpu: Fix notes for CPU models
37* a87077316ed2 Philippe Mathieu-Daudé:
   tests/qtest/boot-serial-test: Correct HPPA machine name
38* 78b0c15a563a Gabriel Barrantes:
   backends/cryptodev-vhost-user: Fix local_error leaks
39* bb5b7fced6b5 Phil Dennis-Jordan:
   hw/usb/hcd-xhci-pci: Use modulo to select MSI vector as per spec
40* 694632fd4498 Sebastian Ott:
   pci: ensure valid link status bits for downstream ports
41* 42e2a7a0ab23 Nicholas Piggin:
   pci/msix: Fix msix pba read vector poll end calculation
42* 1ad32644fe4c Igor Mammedov:
   tests: acpi: whitelist expected blobs
43* 0b053391985a Igor Mammedov:
   pci: acpi: Windows 'PCI Label Id' bug workaround
44* 9fb1c9a1bb26 Igor Mammedov:
   tests: acpi: update expected blobs
45* 1ce979e7269a Li Zhijian:
   hw/cxl: Fix msix_notify: Assertion `vector < dev->msix_entries_nr`
46 1edc3d43f20d Peter Maydell:
   target/arm: arm_reset_sve_state() should set FPSR, not FPCR
47 664280abddcb Hongren Zheng:
   hw/usb/canokey: Fix buffer overflow for OUT packet
48 719168fba7c3 Steve Sistare:
   physmem: fix qemu_ram_alloc_from_fd size calculation
49 e43ced8be18d Ilya Leoshkevich:
   target/s390x: Fix MVC not always invalidating translation blocks
50 8b647bd35250 Dominik 'Disconnect3d' Czarnota:
   gdbstub/user-target: fix gdbserver int format (%d -> %x)
51 4b52d63249a5 Akihiko Odaki:
   tap: Remove qemu_using_vnet_hdr()

(commit(s) marked with * were in previous series and are not resent)

