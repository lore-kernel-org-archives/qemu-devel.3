Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A5BFFD591AE
	for <qemu-devel@archiver.kernel.org>; Mon, 18 Nov 2024 19:36:18 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tD7X4-0006YH-Nq; Mon, 18 Nov 2024 14:35:34 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1tD7Wx-0006X2-Og; Mon, 18 Nov 2024 14:35:27 -0500
Received: from isrv.corpit.ru ([86.62.121.231])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1tD7Wv-0002f9-BE; Mon, 18 Nov 2024 14:35:27 -0500
Received: from tsrv.corpit.ru (tsrv.tls.msk.ru [192.168.177.2])
 by isrv.corpit.ru (Postfix) with ESMTP id 409C8A54DC;
 Mon, 18 Nov 2024 22:35:17 +0300 (MSK)
Received: from tls.msk.ru (mjt.wg.tls.msk.ru [192.168.177.130])
 by tsrv.corpit.ru (Postfix) with SMTP id B199617359A;
 Mon, 18 Nov 2024 22:35:20 +0300 (MSK)
Received: (nullmailer pid 2312665 invoked by uid 1000);
 Mon, 18 Nov 2024 19:35:20 -0000
From: Michael Tokarev <mjt@tls.msk.ru>
To: qemu-devel@nongnu.org
Cc: qemu-stable@nongnu.org, Michael Tokarev <mjt@tls.msk.ru>
Subject: [Stable-8.2.8 v2 00/61] Patch Round-up for stable 8.2.8,
 freeze on 2024-11-18
Date: Mon, 18 Nov 2024 22:35:03 +0300
Message-Id: <qemu-stable-8.2.8-20241118211929@cover.tls.msk.ru>
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

The following patches are queued for QEMU stable v8.2.8:

  https://gitlab.com/qemu-project/qemu/-/commits/staging-8.2

Patch freeze is 2024-11-18 (today), and the release is planned for 2024-11-20:

  https://wiki.qemu.org/Planning/8.2

Please respond here or CC qemu-stable@nongnu.org on any additional patches
you think should (or shouldn't) be included in the release.

The changes which are staging for inclusion, with the original commit hash
from master branch, are given below the bottom line.

Thanks!

/mjt

--------------------------------------
01* d8d5ca40048b Fea.Wang:
   softmmu/physmem.c: Keep transaction attribute in address_space_map()
02* 8676007eff04 Peter Maydell:
   target/arm: Correct ID_AA64ISAR1_EL1 value for neoverse-v1
03* 9d8d5a5b9078 TANG Tiancheng:
   tcg: Fix iteration step in 32-bit gvec operation
04* 8bded2e73e80 Fabiano Rosas:
   target/ppc: Fix lxvx/stxvx facility check
05* 6475155d5192 Fiona Ebner:
   block/reqlist: allow adding overlapping requests
06* 67d762e716a7 Ard Biesheuvel:
   target/arm: Avoid target_ulong for physical address lookups
07* 3e964275d65b Alexander Bulekov:
   fuzz: disable leak-detection for oss-fuzz builds
08* c60473d29254 Alex Bennée:
   testing: bump mips64el cross to bookworm and fix package list
09* a9ee641bd46f Philippe Mathieu-Daudé:
   linux-user/flatload: Take mmap_lock in load_flt_binary()
10* 2884596f5f38 Richard Henderson:
   linux-user: Fix parse_elf_properties GNU0_MAGIC check
11* 4cabcb89b101 Richard Henderson:
   tcg/ppc: Use TCG_REG_TMP2 for scratch tcg_out_qemu_st
12* 3213da7b9539 Richard Henderson:
   tcg/ppc: Use TCG_REG_TMP2 for scratch index in prepare_host_addr
13* 352cc9f300d8 Richard Henderson:
   target/m68k: Always return a temporary from gen_lea_mode
14* 3db74afec3ca Alexandra Diupina:
   hw/intc/arm_gicv3_cpuif: Add cast to match the documentation
15* f27206ceedbe Marc-André Lureau:
   hw/audio/hda: free timer on exit
16* 330ef31deb2e Marc-André Lureau:
   ui/win32: fix potential use-after-free with dbus shared memory
17* 5504a8126115 Peter Xu:
   KVM: Dynamic sized kvm memslots array
18* d9280ea31747 Stefan Berger:
   tests: Wait for migration completion on destination QEMU to avoid failures
19* d60bd080e783 Peter Maydell:
   tests/qemu-iotests/211.out: Update to expect MapEntry 'compressed' field
20* 04bbc3ee52b3 Kevin Wolf:
   raw-format: Fix error message for invalid offset/size
21* a7cfd751fb26 Richard Henderson:
   tcg: Reset data_gen_ptr correctly
22* b56617bbcb47 Alexander Graf:
   target/i386: Walk NPT in guest real mode
23* 115ade42d501 Richard Henderson:
   target/i386: Use probe_access_full_mmu in ptw_translate
24* bbd5630a75e7 Ilya Leoshkevich:
   linux-user: Emulate /proc/self/maps under mmap_lock
25* 8704132805cf Ilya Leoshkevich:
   linux-user/ppc: Fix sigmask endianness issue in sigreturn
26* 3b5948f808e3 Avihai Horon:
   vfio/migration: Report only stop-copy size in vfio_state_pending_exact()
27* 97f116f9c6fd Alex Bennée:
   gitlab: make check-[dco|patch] a little more verbose
28* 24be5341fbee Pierrick Bouvier:
   dockerfiles: fix default targets for debian-loongarch-cross
29* e29bc931e169 Stefan Weil:
   Fix calculation of minimum in colo_compare_tcp
30* 1f37280b37db Daniel P. Berrangé:
   net: fix build when libbpf is disabled, but libxdp is enabled
31* 75fe36b4e8a9 Bernhard Beschow:
   net/tap-win32: Fix gcc 14 format truncation errors
32* 1505b651fdbd Peter Maydell:
   target/arm: Don't assert in regime_is_user() for E10 mmuidx values
33* bab209af3503 Ido Plat:
   target/arm: Fix arithmetic underflow in SETM instruction
34* 5a60026cad4e Evgenii Prokopiev:
   target/riscv/csr.c: Fix an access to VXSAT
35* 929e4277c128 TANG Tiancheng:
   target/riscv: Correct SXL return value for RV32 in RV64 QEMU
36* a84be2baa9ec Sergey Makarov:
   hw/intc: Don't clear pending bits on IRQ lowering
37* f8c1f36a2e3d Rob Bradford:
   target/riscv: Set vtype.vill on CPU reset
38* 0678e9f29c23 Anup Patel:
   hw/intc/riscv_aplic: Fix in_clrip[x] read emulation
39* 2ae6cca1d338 Yong-Xuan Wang:
   hw/intc/riscv_aplic: Check and update pending when write sourcecfg
40* d201a127e164 Daniel Henrique Barboza:
   target/riscv/kvm: set 'aia_mode' to default in error path
41* fd16cfb2995e Daniel Henrique Barboza:
   target/riscv/kvm: clarify how 'riscv-aia' default works
42* c128d39edeff Anton Blanchard:
   target/riscv: Fix vcompress with rvv_ta_all_1s
43* c9b8a13a8841 Ilya Leoshkevich:
   target/ppc: Set ctx->opcode for decode_insn32()
44* 0324d236d291 Nicholas Piggin:
   target/ppc: Fix mtDPDES targeting SMT siblings
45* e6b2fa1b81ac Peter Maydell:
   target/arm: Fix SVE SDOT/UDOT/USDOT (4-way, indexed)
46* 37dfcba1a049 Hanna Czenczek:
   migration: Ensure vmstate_save() sets errp
47* 9529aa6bb4d1 Klaus Jensen:
   hw/nvme: fix handling of over-committed queues
48* 042b4ebfd229 Christian Schoenebeck:
   9pfs: fix crash on 'Treaddir' request
49 8fa11a4df344 Alexander Graf:
   target/i386: Fix legacy page table walk
50 8491026a08b4 Helge Deller:
   linux-user: Fix setreuid and setregid to use direct syscalls
51 f27550804688 Richard Henderson:
   target/arm: Drop user-only special case in sve_stN_r
52 2a339fee4506 Richard Henderson:
   accel/tcg: Fix user-only probe_access_internal plugin check
53 fb7f3572b111 Ilya Leoshkevich:
   linux-user: Tolerate CONFIG_LSM_MMAP_MIN_ADDR
54 f7150b215139 Richard Henderson:
   linux-user/arm: Reduce vdso alignment to 4k
55 95c9e2209cc0 Richard Henderson:
   linux-user/arm: Select vdso for be8 and be32 modes
56 8377e3fb854d Peter Maydell:
   tcg: Allow top bit of SIMD_DATA_BITS to be set in simd_desc()
57 7ba055b49b74 Pierrick Bouvier:
   target/i386: fix hang when using slow path for ptw_setl
58 44e794896759 Alex Bennée:
   contrib/plugins: add compat for g_memdup2
59 c3d7c18b0d61 Thomas Huth:
   hw/misc/mos6522: Fix bad class definition of the MOS6522 device
60 626b39006d2f Paolo Bonzini:
   hw/audio/hda: fix memory leak on audio setup
61 b2cc69997924 Guenter Roeck:
   usb-hub: Fix handling port power control messages

(commit(s) marked with * were in previous series and are not resent)

