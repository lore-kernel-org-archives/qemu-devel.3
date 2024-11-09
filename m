Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0B54BD5E366
	for <qemu-devel@archiver.kernel.org>; Sat,  9 Nov 2024 12:08:52 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t9kGC-000847-0k; Sat, 09 Nov 2024 07:08:12 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1t9kG9-00082m-Ax; Sat, 09 Nov 2024 07:08:09 -0500
Received: from isrv.corpit.ru ([86.62.121.231])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1t9kG6-0003aD-9s; Sat, 09 Nov 2024 07:08:08 -0500
Received: from tsrv.corpit.ru (tsrv.tls.msk.ru [192.168.177.2])
 by isrv.corpit.ru (Postfix) with ESMTP id 8E336A15E8;
 Sat,  9 Nov 2024 15:07:06 +0300 (MSK)
Received: from tls.msk.ru (mjt.wg.tls.msk.ru [192.168.177.130])
 by tsrv.corpit.ru (Postfix) with SMTP id 53490167F76;
 Sat,  9 Nov 2024 15:08:01 +0300 (MSK)
Received: (nullmailer pid 3295247 invoked by uid 1000);
 Sat, 09 Nov 2024 12:08:01 -0000
From: Michael Tokarev <mjt@tls.msk.ru>
To: qemu-devel@nongnu.org
Cc: qemu-stable@nongnu.org, Michael Tokarev <mjt@tls.msk.ru>
Subject: [Stable-9.0.4 v1 00/57] Patch Round-up for stable 9.0.4,
 freeze on 2024-11-18
Date: Sat,  9 Nov 2024 15:07:02 +0300
Message-Id: <qemu-stable-9.0.4-20241109150303@cover.tls.msk.ru>
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

The following patches are queued for QEMU stable v9.0.4:

  https://gitlab.com/qemu-project/qemu/-/commits/staging-9.0

Patch freeze is 2024-11-18, and the release is planned for 2024-11-20:

  https://wiki.qemu.org/Planning/9.0

Please respond here or CC qemu-stable@nongnu.org on any additional patches
you think should (or shouldn't) be included in the release.

The changes which are staging for inclusion, with the original commit hash
from master branch, are given below the bottom line.

This is supposed to be the last release in 9.0.x series.  Please switch to
a more recent 9.1.x series for a currently supported qemu.

Thanks!

/mjt

--------------------------------------
01 d8d5ca40048b Fea.Wang:
   softmmu/physmem.c: Keep transaction attribute in address_space_map()
02 8676007eff04 Peter Maydell:
   target/arm: Correct ID_AA64ISAR1_EL1 value for neoverse-v1
03 9d8d5a5b9078 TANG Tiancheng:
   tcg: Fix iteration step in 32-bit gvec operation
04 8bded2e73e80 Fabiano Rosas:
   target/ppc: Fix lxvx/stxvx facility check
05 2e4fdf566062 Mark Cave-Ayland:
   hw/mips/jazz: fix typo in in-built NIC alias
06 6475155d5192 Fiona Ebner:
   block/reqlist: allow adding overlapping requests
07 67d762e716a7 Ard Biesheuvel:
   target/arm: Avoid target_ulong for physical address lookups
08 3e964275d65b Alexander Bulekov:
   fuzz: disable leak-detection for oss-fuzz builds
09 c60473d29254 Alex Bennée:
   testing: bump mips64el cross to bookworm and fix package list
10 0e60fc80938d Marc-André Lureau:
   vnc: fix crash when no console attached
11 a9ee641bd46f Philippe Mathieu-Daudé:
   linux-user/flatload: Take mmap_lock in load_flt_binary()
12 2884596f5f38 Richard Henderson:
   linux-user: Fix parse_elf_properties GNU0_MAGIC check
13 4cabcb89b101 Richard Henderson:
   tcg/ppc: Use TCG_REG_TMP2 for scratch tcg_out_qemu_st
14 3213da7b9539 Richard Henderson:
   tcg/ppc: Use TCG_REG_TMP2 for scratch index in prepare_host_addr
15 352cc9f300d8 Richard Henderson:
   target/m68k: Always return a temporary from gen_lea_mode
16 3db74afec3ca Alexandra Diupina:
   hw/intc/arm_gicv3_cpuif: Add cast to match the documentation
17 f27206ceedbe Marc-André Lureau:
   hw/audio/hda: free timer on exit
18 244d52ff736f Marc-André Lureau:
   ui/dbus: fix leak on message filtering
19 330ef31deb2e Marc-André Lureau:
   ui/win32: fix potential use-after-free with dbus shared memory
20 cf5988978129 Marc-André Lureau:
   ui/dbus: fix filtering all update messages
21 615586cb3568 Paolo Bonzini:
   tcg/s390x: fix constraint for 32-bit TSTEQ/TSTNE
22 5504a8126115 Peter Xu:
   KVM: Dynamic sized kvm memslots array
23 d9280ea31747 Stefan Berger:
   tests: Wait for migration completion on destination QEMU to avoid failures
24 68ad89b75ad2 Thomas Huth:
   Revert "hw/sh4/r2d: Realize IDE controller before accessing it"
25 d60bd080e783 Peter Maydell:
   tests/qemu-iotests/211.out: Update to expect MapEntry 'compressed' field
26 04bbc3ee52b3 Kevin Wolf:
   raw-format: Fix error message for invalid offset/size
27 a7cfd751fb26 Richard Henderson:
   tcg: Reset data_gen_ptr correctly
28 b56617bbcb47 Alexander Graf:
   target/i386: Walk NPT in guest real mode
29 115ade42d501 Richard Henderson:
   target/i386: Use probe_access_full_mmu in ptw_translate
30 bbd5630a75e7 Ilya Leoshkevich:
   linux-user: Emulate /proc/self/maps under mmap_lock
31 8704132805cf Ilya Leoshkevich:
   linux-user/ppc: Fix sigmask endianness issue in sigreturn
32 310df7a9fe40 Yao Zi:
   linux-user/riscv: Fix definition of RISCV_HWPROBE_EXT_ZVFHMIN
33 3b5948f808e3 Avihai Horon:
   vfio/migration: Report only stop-copy size in vfio_state_pending_exact()
34 97f116f9c6fd Alex Bennée:
   gitlab: make check-[dco|patch] a little more verbose
35 24be5341fbee Pierrick Bouvier:
   dockerfiles: fix default targets for debian-loongarch-cross
36 e29bc931e169 Stefan Weil:
   Fix calculation of minimum in colo_compare_tcp
37 1f37280b37db Daniel P. Berrangé:
   net: fix build when libbpf is disabled, but libxdp is enabled
38 75fe36b4e8a9 Bernhard Beschow:
   net/tap-win32: Fix gcc 14 format truncation errors
39 1505b651fdbd Peter Maydell:
   target/arm: Don't assert in regime_is_user() for E10 mmuidx values
40 5a60026cad4e Evgenii Prokopiev:
   target/riscv/csr.c: Fix an access to VXSAT
41 929e4277c128 TANG Tiancheng:
   target/riscv: Correct SXL return value for RV32 in RV64 QEMU
42 a84be2baa9ec Sergey Makarov:
   hw/intc: Don't clear pending bits on IRQ lowering
43 f8c1f36a2e3d Rob Bradford:
   target/riscv: Set vtype.vill on CPU reset
44 2ae6cca1d338 Yong-Xuan Wang:
   hw/intc/riscv_aplic: Check and update pending when write sourcecfg
45 d201a127e164 Daniel Henrique Barboza:
   target/riscv/kvm: set 'aia_mode' to default in error path
46 fd16cfb2995e Daniel Henrique Barboza:
   target/riscv/kvm: clarify how 'riscv-aia' default works
47 c128d39edeff Anton Blanchard:
   target/riscv: Fix vcompress with rvv_ta_all_1s
48 c9b8a13a8841 Ilya Leoshkevich:
   target/ppc: Set ctx->opcode for decode_insn32()
49 0324d236d291 Nicholas Piggin:
   target/ppc: Fix mtDPDES targeting SMT siblings
50 07f2770503e2 Nicholas Piggin:
   ppc/xive: Fix ESB length overflow on 32-bit hosts
51 16c687d84574 Jonathan Cameron:
   hw/acpi: Fix ordering of BDF in Generic Initiator PCI Device Handle.
52 056c5c90c171 Peter Maydell:
   Revert "target/arm: Fix usage of MMU indexes when EL3 is AArch32"
53 efbe180ad2ed Peter Maydell:
   target/arm: Add new MMU indexes for AArch32 Secure PL1&0
54 e6b2fa1b81ac Peter Maydell:
   target/arm: Fix SVE SDOT/UDOT/USDOT (4-way, indexed)
55 37dfcba1a049 Hanna Czenczek:
   migration: Ensure vmstate_save() sets errp
56 9529aa6bb4d1 Klaus Jensen:
   hw/nvme: fix handling of over-committed queues
57 042b4ebfd229 Christian Schoenebeck:
   9pfs: fix crash on 'Treaddir' request

