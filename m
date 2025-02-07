Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 910AEC02196
	for <qemu-devel@archiver.kernel.org>; Fri,  7 Feb 2025 11:55:25 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tgMwu-0002Sq-UI; Fri, 07 Feb 2025 06:55:09 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1tgMwt-0002R5-2i; Fri, 07 Feb 2025 06:55:07 -0500
Received: from isrv.corpit.ru ([86.62.121.231])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1tgMwq-0005K3-FS; Fri, 07 Feb 2025 06:55:06 -0500
Received: from tsrv.corpit.ru (tsrv.tls.msk.ru [192.168.177.2])
 by isrv.corpit.ru (Postfix) with ESMTP id 78700E73DA;
 Fri, 07 Feb 2025 14:54:20 +0300 (MSK)
Received: from gandalf.tls.msk.ru (mjt.wg.tls.msk.ru [192.168.177.130])
 by tsrv.corpit.ru (Postfix) with ESMTP id 0999F1B0B54;
 Fri,  7 Feb 2025 14:55:02 +0300 (MSK)
Received: by gandalf.tls.msk.ru (Postfix, from userid 1000)
 id 00D6752D93; Fri, 07 Feb 2025 14:55:01 +0300 (MSK)
From: Michael Tokarev <mjt@tls.msk.ru>
To: qemu-devel@nongnu.org
Cc: qemu-stable@nongnu.org,
	Michael Tokarev <mjt@tls.msk.ru>
Subject: [Stable-9.1.3 v2 00/65] Patch Round-up for stable 9.1.3,
 freeze on 2025-02-06 (frozen)
Date: Fri,  7 Feb 2025 14:54:51 +0300
Message-Id: <qemu-stable-9.1.3-20250207102547@cover.tls.msk.ru>
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

The following patches are queued for QEMU stable v9.1.3:

  https://gitlab.com/qemu-project/qemu/-/commits/staging-9.1

Patch freeze is 2025-02-06 (frozen), and the release is planned for 2025-02-08:

  https://wiki.qemu.org/Planning/9.1

Please respond here or CC qemu-stable@nongnu.org on any patches
you think shouldn't be included in the release.

This is supposed to be the last stable release in 9.1.x series.

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
08* cfa3a6c54511 Pierrick Bouvier:
   plugins: add missing export for qemu_plugin_num_vcpus
09* 87ae45e602e2 Peter Xu:
   migration: Allow pipes to keep working for fd migrations
10* 9379ea9db3c0 Akihiko Odaki:
   virtio-net: Add queues before loading them
11* e8185fdc63e1 Harsh Prateek Bora:
   ppc/spapr: fix drc index mismatch for partially enabled vcpus
12* 3abb67323aee Guenter Roeck:
   scsi: megasas: Internal cdbs have 16-byte length
13* abf0f092c1dd Christian Schoenebeck:
   tests/9p: fix Rreaddir response name
14* 4ec984965079 Christian Schoenebeck:
   tests/9p: add missing Rgetattr response name
15* 462db8fb1d40 Christian Schoenebeck:
   tests/9p: add 'use-after-unlink' test
16* 3bc4db44430f Christian Schoenebeck:
   9pfs: remove obsolete comment in v9fs_getattr()
17* c81e7219e073 Christian Schoenebeck:
   9pfs: fix 'Tgetattr' after unlink
18* eaab44ccc59b Christian Schoenebeck:
   tests/9p: also check 'Tgetattr' in 'use-after-unlink' test
19* fa416ae6157a Nicholas Piggin:
   target/ppc: Fix non-maskable interrupt while halted
20* 2fc0a78a5773 Glenn Miles:
   target/ppc: Fix THREAD_SIBLING_FOREACH for multi-socket
21* 9162f1012576 Klaus Jensen:
   hw/nvme: fix msix_uninit with exclusive bar
22* 6651f8f2e505 Klaus Jensen:
   hw/nvme: take a reference on the subsystem on vf realization
23* 26dcf2be7e15 Ahmad Fatoum:
   hw/openrisc/openrisc_sim: keep serial@90000000 as default
24* 5311599cdc48 Peter Maydell:
   target/riscv: Avoid bad shift in riscv_cpu_do_interrupt()
25* d06a9d843fb6 Christian Schoenebeck:
   9pfs: fix regression regarding CVE-2023-2861
26* 04e006ab36a8 Richard Henderson:
   tcg: Reset free_temps before tcg_optimize
27* b438362a1425 Roman Artemev:
   tcg/riscv: Fix StoreStore barrier generation
28* 57e2cc9abf5d Gerd Hoffmann:
   x86/loader: only patch linux kernels
29* 0f5715e4b570 Gerd Hoffmann:
   roms: re-add edk2-basetools target
30* 74dc38d0c6c1 Michael Tokarev:
   pc-bios: add missing riscv64 descriptor
31* 9678b9c50572 Peter Maydell:
   hw/intc/arm_gicv3_its: Zero initialize local DTEntry etc structs
32* e2d98f257138 Thomas Huth:
   meson.build: Disallow libnfs v6 to fix the broken macOS build
33* eea5aeef84e1 Albert Esteve:
   vhost-user: fix shared object return values
34* 3f2a05b31ee9 Maciej S. Szmigiero:
   target/i386: Reset TSCs of parked vCPUs too on VM reset
35* 0d0141fadc90 Yong-Xuan Wang:
   hw/intc/riscv_aplic: Fix APLIC in_clrip and clripnum write emulation
36* 14e568ab4836 David Hildenbrand:
   s390x/s390-virtio-ccw: don't crash on weird RAM sizes
37* 591e848aca7a Alex Bennée:
   config/targets: update aarch64_be-linux-user gdb XML list
38* d41989e75483 Bibo Mao:
   target/loongarch: Use actual operand size with vbsrl check
39* b4859e8f33a7 Philippe Mathieu-Daudé:
   docs: Correct release of TCG trace-events removal
40* 93dcc9390e5a Han Han:
   target/i386/cpu: Fix notes for CPU models
41* 86bee9e0c761 Fabiano Rosas:
   migration: Add more error handling to analyze-migration.py
42* 2aead53d39b8 Fabiano Rosas:
   migration: Remove unused argument in vmsd_desc_field_end
43* 69d1f784569f Fabiano Rosas:
   migration: Fix parsing of s390 stream
44* c76ee1f6255c Fabiano Rosas:
   s390x: Fix CSS migration
45* f52965bf0eee Fabiano Rosas:
   migration: Rename vmstate_info_nullptr
46* 9867c3a7ced1 Peter Xu:
   migration: Dump correct JSON format for nullptr replacement
47* 35049eb0d2fc Fabiano Rosas:
   migration: Fix arrays of pointers in JSON writer
48* cdc3970f8597 Yuan Liu:
   multifd: bugfix for migration using compression methods
49* 2588a5f99b0c Yuan Liu:
   multifd: bugfix for incorrect migration data with QPL compression
50* a87077316ed2 Philippe Mathieu-Daudé:
   tests/qtest/boot-serial-test: Correct HPPA machine name
51* 78b0c15a563a Gabriel Barrantes:
   backends/cryptodev-vhost-user: Fix local_error leaks
52* bb5b7fced6b5 Phil Dennis-Jordan:
   hw/usb/hcd-xhci-pci: Use modulo to select MSI vector as per spec
53* 694632fd4498 Sebastian Ott:
   pci: ensure valid link status bits for downstream ports
54* 42e2a7a0ab23 Nicholas Piggin:
   pci/msix: Fix msix pba read vector poll end calculation
55* 1ad32644fe4c Igor Mammedov:
   tests: acpi: whitelist expected blobs
56* 0b053391985a Igor Mammedov:
   pci: acpi: Windows 'PCI Label Id' bug workaround
57* 9fb1c9a1bb26 Igor Mammedov:
   tests: acpi: update expected blobs
58* 1ce979e7269a Li Zhijian:
   hw/cxl: Fix msix_notify: Assertion `vector < dev->msix_entries_nr`
59 1edc3d43f20d Peter Maydell:
   target/arm: arm_reset_sve_state() should set FPSR, not FPCR
60 664280abddcb Hongren Zheng:
   hw/usb/canokey: Fix buffer overflow for OUT packet
61 719168fba7c3 Steve Sistare:
   physmem: fix qemu_ram_alloc_from_fd size calculation
62 e43ced8be18d Ilya Leoshkevich:
   target/s390x: Fix MVC not always invalidating translation blocks
63 84dfdcbff33f Laurent Vivier:
   net: Fix announce_self
64 c6a1b591a68b Laurent Vivier:
   net/dump: Correctly compute Ethernet packet offset
65 8b647bd35250 Dominik 'Disconnect3d' Czarnota:
   gdbstub/user-target: fix gdbserver int format (%d -> %x)

(commit(s) marked with * were in previous series and are not resent)

