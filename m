Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5A193C02192
	for <qemu-devel@archiver.kernel.org>; Fri,  7 Feb 2025 07:25:07 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tgIiZ-0004AS-6M; Fri, 07 Feb 2025 02:24:03 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1tgIiW-00049C-Lz; Fri, 07 Feb 2025 02:24:00 -0500
Received: from isrv.corpit.ru ([86.62.121.231])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1tgIiU-0007Q9-P4; Fri, 07 Feb 2025 02:24:00 -0500
Received: from tsrv.corpit.ru (tsrv.tls.msk.ru [192.168.177.2])
 by isrv.corpit.ru (Postfix) with ESMTP id 4DBD7E71F8;
 Fri, 07 Feb 2025 10:23:02 +0300 (MSK)
Received: from gandalf.tls.msk.ru (mjt.wg.tls.msk.ru [192.168.177.130])
 by tsrv.corpit.ru (Postfix) with ESMTP id 8A2551B06D0;
 Fri,  7 Feb 2025 10:23:43 +0300 (MSK)
Received: by gandalf.tls.msk.ru (Postfix, from userid 1000)
 id 7C93952D65; Fri, 07 Feb 2025 10:23:43 +0300 (MSK)
From: Michael Tokarev <mjt@tls.msk.ru>
To: qemu-devel@nongnu.org
Cc: qemu-stable@nongnu.org,
	Michael Tokarev <mjt@tls.msk.ru>
Subject: [Stable-7.2.16 v2 00/33] Patch Round-up for stable 7.2.16,
 freeze on 2025-02-06 (frozen)
Date: Fri,  7 Feb 2025 10:23:35 +0300
Message-Id: <qemu-stable-7.2.16-20250207102241@cover.tls.msk.ru>
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

The following patches are queued for QEMU stable v7.2.16:

  https://gitlab.com/qemu-project/qemu/-/commits/staging-7.2

Patch freeze is 2025-02-06 (frozen), and the release is planned for 2025-02-08:

  https://wiki.qemu.org/Planning/7.2

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
04* da80f11efeea Philippe Mathieu-Daudé:
   cirrus-ci: Remove MSYS2 jobs duplicated with gitlab-ci
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
16* 26dcf2be7e15 Ahmad Fatoum:
   hw/openrisc/openrisc_sim: keep serial@90000000 as default
17* b438362a1425 Roman Artemev:
   tcg/riscv: Fix StoreStore barrier generation
18* e7fca81e1705 Alexander Bulekov:
   fuzz: specify audiodev for usb-audio
19* 57e2cc9abf5d Gerd Hoffmann:
   x86/loader: only patch linux kernels
20* 9678b9c50572 Peter Maydell:
   hw/intc/arm_gicv3_its: Zero initialize local DTEntry etc structs
21* e2d98f257138 Thomas Huth:
   meson.build: Disallow libnfs v6 to fix the broken macOS build
22* 14e568ab4836 David Hildenbrand:
   s390x/s390-virtio-ccw: don't crash on weird RAM sizes
23* b4859e8f33a7 Philippe Mathieu-Daudé:
   docs: Correct release of TCG trace-events removal
24* 93dcc9390e5a Han Han:
   target/i386/cpu: Fix notes for CPU models
25* 78b0c15a563a Gabriel Barrantes:
   backends/cryptodev-vhost-user: Fix local_error leaks
26* bb5b7fced6b5 Phil Dennis-Jordan:
   hw/usb/hcd-xhci-pci: Use modulo to select MSI vector as per spec
27* 694632fd4498 Sebastian Ott:
   pci: ensure valid link status bits for downstream ports
28* 42e2a7a0ab23 Nicholas Piggin:
   pci/msix: Fix msix pba read vector poll end calculation
29* 1ad32644fe4c Igor Mammedov:
   tests: acpi: whitelist expected blobs
30* 0b053391985a Igor Mammedov:
   pci: acpi: Windows 'PCI Label Id' bug workaround
31* 9fb1c9a1bb26 Igor Mammedov:
   tests: acpi: update expected blobs
32 1edc3d43f20d Peter Maydell:
   target/arm: arm_reset_sve_state() should set FPSR, not FPCR
33 664280abddcb Hongren Zheng:
   hw/usb/canokey: Fix buffer overflow for OUT packet

(commit(s) marked with * were in previous series and are not resent)

