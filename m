Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EC1CBD5E122
	for <qemu-devel@archiver.kernel.org>; Sat,  9 Nov 2024 06:40:11 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t9f85-00030o-N2; Sat, 09 Nov 2024 01:39:30 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1t9f7t-0002u4-BU; Sat, 09 Nov 2024 01:39:17 -0500
Received: from isrv.corpit.ru ([86.62.121.231])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1t9f7q-0001vY-Jn; Sat, 09 Nov 2024 01:39:17 -0500
Received: from tsrv.corpit.ru (tsrv.tls.msk.ru [192.168.177.2])
 by isrv.corpit.ru (Postfix) with ESMTP id 5ACAEA12E7;
 Sat,  9 Nov 2024 09:38:09 +0300 (MSK)
Received: from tls.msk.ru (mjt.wg.tls.msk.ru [192.168.177.130])
 by tsrv.corpit.ru (Postfix) with SMTP id C32D5167DCB;
 Sat,  9 Nov 2024 09:39:03 +0300 (MSK)
Received: (nullmailer pid 3272489 invoked by uid 1000);
 Sat, 09 Nov 2024 06:39:03 -0000
From: Michael Tokarev <mjt@tls.msk.ru>
To: qemu-devel@nongnu.org
Cc: qemu-stable@nongnu.org, Michael Tokarev <mjt@tls.msk.ru>
Subject: [Stable-7.2.15 v1 00/33] Patch Round-up for stable 7.2.15,
 freeze on 2024-11-18
Date: Sat,  9 Nov 2024 09:38:26 +0300
Message-Id: <qemu-stable-7.2.15-20241109093832@cover.tls.msk.ru>
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
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
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

The following patches are queued for QEMU stable v7.2.15:

  https://gitlab.com/qemu-project/qemu/-/commits/staging-7.2

Patch freeze is 2024-11-18, and the release is planned for 2024-11-20:

  https://wiki.qemu.org/Planning/7.2

Please respond here or CC qemu-stable@nongnu.org on any additional patches
you think should (or shouldn't) be included in the release.

The changes which are staging for inclusion, with the original commit hash
from master branch, are given below the bottom line.

Thanks!

/mjt

--------------------------------------
01 d8d5ca40048b Fea.Wang:
   softmmu/physmem.c: Keep transaction attribute in address_space_map()
02 8bded2e73e80 Fabiano Rosas:
   target/ppc: Fix lxvx/stxvx facility check
03 6475155d5192 Fiona Ebner:
   block/reqlist: allow adding overlapping requests
04 3e964275d65b Alexander Bulekov:
   fuzz: disable leak-detection for oss-fuzz builds
05 e6d8e5e6e366 Paolo Bonzini:
   tracetool: avoid invalid escape in Python string
06 a9ee641bd46f Philippe Mathieu-Daudé:
   linux-user/flatload: Take mmap_lock in load_flt_binary()
07 2884596f5f38 Richard Henderson:
   linux-user: Fix parse_elf_properties GNU0_MAGIC check
08 9472083e642b Stefano Garzarella:
   scsi: fetch unit attention when creating the request
09 3db74afec3ca Alexandra Diupina:
   hw/intc/arm_gicv3_cpuif: Add cast to match the documentation
10 f27206ceedbe Marc-André Lureau:
   hw/audio/hda: free timer on exit
11 5504a8126115 Peter Xu:
   KVM: Dynamic sized kvm memslots array
12 64e0e63ea16a Tom Dohrmann:
   accel/kvm: check for KVM_CAP_READONLY_MEM on VM
13 d9280ea31747 Stefan Berger:
   tests: Wait for migration completion on destination QEMU to avoid failures
14 04bbc3ee52b3 Kevin Wolf:
   raw-format: Fix error message for invalid offset/size
15 a7cfd751fb26 Richard Henderson:
   tcg: Reset data_gen_ptr correctly
16 987b63f24afe Peter Maydell:
   target/i386: Avoid unreachable variable declaration in mmu_translate()
17 b56617bbcb47 Alexander Graf:
   target/i386: Walk NPT in guest real mode
18 8704132805cf Ilya Leoshkevich:
   linux-user/ppc: Fix sigmask endianness issue in sigreturn
19 97f116f9c6fd Alex Bennée:
   gitlab: make check-[dco|patch] a little more verbose
20 e29bc931e169 Stefan Weil:
   Fix calculation of minimum in colo_compare_tcp
21 75fe36b4e8a9 Bernhard Beschow:
   net/tap-win32: Fix gcc 14 format truncation errors
22 1505b651fdbd Peter Maydell:
   target/arm: Don't assert in regime_is_user() for E10 mmuidx values
23 5a60026cad4e Evgenii Prokopiev:
   target/riscv/csr.c: Fix an access to VXSAT
24 929e4277c128 TANG Tiancheng:
   target/riscv: Correct SXL return value for RV32 in RV64 QEMU
25 a84be2baa9ec Sergey Makarov:
   hw/intc: Don't clear pending bits on IRQ lowering
26 f8c1f36a2e3d Rob Bradford:
   target/riscv: Set vtype.vill on CPU reset
27 0678e9f29c23 Anup Patel:
   hw/intc/riscv_aplic: Fix in_clrip[x] read emulation
28 2ae6cca1d338 Yong-Xuan Wang:
   hw/intc/riscv_aplic: Check and update pending when write sourcecfg
29 c128d39edeff Anton Blanchard:
   target/riscv: Fix vcompress with rvv_ta_all_1s
30 c9b8a13a8841 Ilya Leoshkevich:
   target/ppc: Set ctx->opcode for decode_insn32()
31 e6b2fa1b81ac Peter Maydell:
   target/arm: Fix SVE SDOT/UDOT/USDOT (4-way, indexed)
32 9529aa6bb4d1 Klaus Jensen:
   hw/nvme: fix handling of over-committed queues
33 042b4ebfd229 Christian Schoenebeck:
   9pfs: fix crash on 'Treaddir' request

