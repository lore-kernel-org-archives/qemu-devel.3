Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B5BFFD2A55B
	for <qemu-devel@archiver.kernel.org>; Wed, 16 Oct 2024 20:11:31 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t1ALx-0004kE-0i; Wed, 16 Oct 2024 16:10:41 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1t1ALv-0004jY-D8; Wed, 16 Oct 2024 16:10:39 -0400
Received: from isrv.corpit.ru ([86.62.121.231])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1t1ALt-0000ee-5S; Wed, 16 Oct 2024 16:10:39 -0400
Received: from tsrv.corpit.ru (tsrv.tls.msk.ru [192.168.177.2])
 by isrv.corpit.ru (Postfix) with ESMTP id F0DA998F92;
 Wed, 16 Oct 2024 23:10:04 +0300 (MSK)
Received: from think4mjt.tls.msk.ru (mjtthink.wg.tls.msk.ru [192.168.177.146])
 by tsrv.corpit.ru (Postfix) with ESMTP id EB91E156372;
 Wed, 16 Oct 2024 23:10:24 +0300 (MSK)
From: Michael Tokarev <mjt@tls.msk.ru>
To: qemu-devel@nongnu.org
Cc: qemu-stable@nongnu.org,
	Michael Tokarev <mjt@tls.msk.ru>
Subject: [Stable-9.1.1 00/49] Patch Round-up for stable 9.1.1,
 freeze on 2024-10-16 (frozen)
Date: Wed, 16 Oct 2024 23:09:51 +0300
Message-Id: <qemu-stable-9.1.1-20241016195251@cover.tls.msk.ru>
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

The following patches are queued for QEMU stable v9.1.1:

  https://gitlab.com/qemu-project/qemu/-/commits/staging-9.1

Patch freeze is 2024-10-16 (frozen), and the release is planned for 2024-10-18:

  https://wiki.qemu.org/Planning/9.1

Please respond here or CC qemu-stable@nongnu.org on any additional patches
you think should (or shouldn't) be included in the release.

The changes which are staging for inclusion, with the original commit hash
from master branch, are given below the bottom line.

Thanks!

/mjt

--------------------------------------
01* ead5078cf1a5 Helge Deller:
   target/hppa: Fix PSW V-bit packaging in cpu_hppa_get for hppa64
02* 48b8583698d9 Daniel P. Berrangé:
   iotests: fix expected output from gnutls
03* c72cab5ad9f8 Tiago Pasqualini:
   crypto: run qcrypto_pbkdf2_count_iters in a new thread
04* e6c09ea4f9e5 Daniel P. Berrangé:
   crypto: check gnutls & gcrypt support the requested pbkdf hash
05* 586ac2c67d70 Daniel P. Berrangé:
   crypto: avoid leak of ctx when bad cipher mode is given
06* d0068b746a0a Alex Bennée:
   tests/docker: remove debian-armel-cross
07* 19d2111059c8 Alex Bennée:
   tests/docker: update debian i686 and mipsel images to bookworm
08* 1231bc7d12c3 Thomas Huth:
   contrib/plugins/Makefile: Add a 'distclean' target
09* 7fc6611cad3e Volker Rümelin:
   hw/audio/virtio-sound: fix heap buffer overflow
10* 110684c9a69a Jan Klötzke:
   hw/intc/arm_gic: fix spurious level triggered interrupts
11* ae23cd00170b Gert Wollny:
   ui/sdl2: set swap interval explicitly when OpenGL is enabled
12* 8d5ab746b1e6 Daniel P. Berrangé:
   gitlab: fix logic for changing docker tag on stable branches
13* 637b0aa13956 Mattias Nissler:
   softmmu: Support concurrent bounce buffers
14* b84f06c2bee7 David Hildenbrand:
   softmmu/physmem: fix memory leak in dirty_memory_extend()
15* d8d5ca40048b Fea.Wang:
   softmmu/physmem.c: Keep transaction attribute in address_space_map()
16* 2d0a071e625d Mattias Nissler:
   mac_dbdma: Remove leftover `dma_memory_unmap` calls
17* 4ce562290878 Fabiano Rosas:
   migration/multifd: Fix rb->receivedmap cleanup race
18* 6cce0dcc6f7a Jacob Abrams:
   hw/char/stm32l4x5_usart.c: Enable USART ACK bit response
19* 8676007eff04 Peter Maydell:
   target/arm: Correct ID_AA64ISAR1_EL1 value for neoverse-v1
20* d33d3adb5737 Helge Deller:
   target/hppa: Fix random 32-bit linux-user crashes
21* 203beb6f0474 Arman Nabiev:
   target/ppc: Fix migration of CPUs with TLB_EMB TLB type
22* 405e352d28c2 Fabiano Rosas:
   migration/multifd: Fix p->iov leak in multifd-uadk.c
23* 4265b4f35843 Bibo Mao:
   hw/loongarch/virt: Add description for virt machine type
24* 9d8d5a5b9078 TANG Tiancheng:
   tcg: Fix iteration step in 32-bit gvec operation
25* 8bded2e73e80 Fabiano Rosas:
   target/ppc: Fix lxvx/stxvx facility check
26* 2e4fdf566062 Mark Cave-Ayland:
   hw/mips/jazz: fix typo in in-built NIC alias
27* bc02be4508d8 Alex Bennée:
   util/timer: avoid deadlock when shutting down
28* 6475155d5192 Fiona Ebner:
   block/reqlist: allow adding overlapping requests
29* 67d762e716a7 Ard Biesheuvel:
   target/arm: Avoid target_ulong for physical address lookups
30* 9601076b3b0b Jan Luebbe:
   hw/sd/sdcard: Fix handling of disabled boot partitions
31* c60473d29254 Alex Bennée:
   testing: bump mips64el cross to bookworm and fix package list
32* 0e60fc80938d Marc-André Lureau:
   vnc: fix crash when no console attached
33 a9ee641bd46f Philippe Mathieu-Daudé:
   linux-user/flatload: Take mmap_lock in load_flt_binary()
34 2884596f5f38 Richard Henderson:
   linux-user: Fix parse_elf_properties GNU0_MAGIC check
35 4cabcb89b101 Richard Henderson:
   tcg/ppc: Use TCG_REG_TMP2 for scratch tcg_out_qemu_st
36 3213da7b9539 Richard Henderson:
   tcg/ppc: Use TCG_REG_TMP2 for scratch index in prepare_host_addr
37 352cc9f300d8 Richard Henderson:
   target/m68k: Always return a temporary from gen_lea_mode
38 461a9252e249 Pierrick Bouvier:
   meson: fix machine option for x86_version
39 6ae8c5382b23 Paolo Bonzini:
   meson: define qemu_isa_flags
40 8db4e0f92e83 Paolo Bonzini:
   meson: ensure -mcx16 is passed when detecting ATOMIC128
41 e0c0ea6eca4f Alexandra Diupina:
   hw/intc/arm_gicv3: Add cast to match the documentation
42 12dc8f6eca1e Alexandra Diupina:
   hw/intc/arm_gicv3: Add cast to match the documentation
43 3db74afec3ca Alexandra Diupina:
   hw/intc/arm_gicv3_cpuif: Add cast to match the documentation
44 cd247eae16ab Peter Maydell:
   hw/char/pl011: Use correct masks for IBRD and FBRD
45 f27206ceedbe Marc-André Lureau:
   hw/audio/hda: free timer on exit
46 6d6e23361fc7 Marc-André Lureau:
   hw/audio/hda: fix memory leak on audio setup
47 244d52ff736f Marc-André Lureau:
   ui/dbus: fix leak on message filtering
48 330ef31deb2e Marc-André Lureau:
   ui/win32: fix potential use-after-free with dbus shared memory
49 cf5988978129 Marc-André Lureau:
   ui/dbus: fix filtering all update messages

(commit(s) marked with * were in previous series and are not resent)

