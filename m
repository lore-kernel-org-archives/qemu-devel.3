Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A6152CA1013
	for <qemu-devel@archiver.kernel.org>; Sun,  7 Sep 2025 08:24:24 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uv9Pt-0007zu-Ul; Sun, 07 Sep 2025 03:02:27 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1uv9Pq-0007zH-8p; Sun, 07 Sep 2025 03:02:22 -0400
Received: from isrv.corpit.ru ([212.248.84.144])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1uv9Pk-0004IC-Oe; Sun, 07 Sep 2025 03:02:20 -0400
Received: from tsrv.corpit.ru (tsrv.tls.msk.ru [192.168.177.2])
 by isrv.corpit.ru (Postfix) with ESMTP id D9550151048;
 Sun, 07 Sep 2025 10:02:03 +0300 (MSK)
Received: from think4mjt.origo (mjtthink.wg.tls.msk.ru [192.168.177.146])
 by tsrv.corpit.ru (Postfix) with ESMTP id D9F3B2793B5;
 Sun,  7 Sep 2025 10:02:04 +0300 (MSK)
From: Michael Tokarev <mjt@tls.msk.ru>
To: qemu-devel@nongnu.org
Cc: qemu-stable@nongnu.org,
	Michael Tokarev <mjt@tls.msk.ru>
Subject: [Stable-10.0.4 v2 00/81] Patch Round-up for stable 10.0.4,
 freeze on 2025-09-06 (frozen)
Date: Sun,  7 Sep 2025 10:01:37 +0300
Message-ID: <qemu-stable-10.0.4-20250907000448@cover.tls.msk.ru>
X-Mailer: git-send-email 2.47.3
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=212.248.84.144; envelope-from=mjt@tls.msk.ru;
 helo=isrv.corpit.ru
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9,
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

The following patches are queued for QEMU stable v10.0.4:

  https://gitlab.com/qemu-project/qemu/-/commits/staging-10.0

Patch freeze is 2025-09-06 (frozen), and the release is planned for 2025-09-08:

  https://wiki.qemu.org/Planning/10.0

Please respond here or CC qemu-stable@nongnu.org on any additional patches
you think should (or shouldn't) be included in the release.

The changes which are staging for inclusion, with the original commit hash
from master branch, are given below the bottom line.

Thanks!

/mjt

--------------------------------------
01* e74aad9f81cc Peter Maydell:
   host-utils: Drop workaround for buggy Apple Clang __builtin_subcll()
02* b8882becd572 Michael Tokarev:
   hw/display/qxl-render.c: fix qxl_unpack_chunks() chunk size calculation
03* feea87cd6b64 Paolo Bonzini:
   target/i386: fix width of third operand of VINSERTx128
04* 3cdd990aa920 Peter Maydell:
   linux-user/aarch64: Clear TPIDR2_EL0 when delivering signals
05* 99870aff907b Peter Maydell:
   linux-user/aarch64: Support TPIDR2_MAGIC signal frame record
06* 8d6c7de1cc71 Alex Bennée:
   docs/user: clarify user-mode expects the same OS
07* e895095c78ab Philippe Mathieu-Daudé:
   target/mips: Only update MVPControl.EVP bit if executed by master VPE
08* 2bfcd27e00a4 Luc Michel:
   hw/net/cadence_gem: fix register mask initialization
09* 2865bf1c5795 Pierrick Bouvier:
   system/physmem: fix use-after-free with dispatch
10* 653a75a9d7f9 Michael Tokarev:
   roms/Makefile: fix npcmNxx_bootrom build rules
11* e111ffe48b29 Daniel Henrique Barboza:
   linux-user/strace.list: add riscv_hwprobe entry
12* 16aa7771afea Daniel Henrique Barboza:
   target/riscv: do not call GETPC() in check_ret_from_m_mode()
13* 30ef718423e8 Xu Lu:
   target/riscv: Fix exception type when VU accesses supervisor CSRs
14* 77707bfdf871 Vac Chen:
   target/riscv: Fix pmp range wraparound on zero
15* b6f1244678be Yang Jialong:
   intc/riscv_aplic: Fix target register read when source is inactive
16* e443ba03361b Jay Chang:
   target/riscv: Restrict mideleg/medeleg/medelegh access to S-mode harts
17* 86bc3a0abf10 Jay Chang:
   target/riscv: Restrict midelegh access to S-mode harts
18* caab7ac83507 Bibo Mao:
   target/loongarch: Fix valid virtual address checking
19* 6fcf5ebafad6 Jonah Palmer:
   virtio: fix off-by-one and invalid access in virtqueue_ordered_fill
20* c1997099dc26 Hanna Czenczek:
   vhost: Do not abort on log-start error
21* d63c388dadb7 Hanna Czenczek:
   vhost: Do not abort on log-stop error
22* 6071d13c6a37 Akihiko Odaki:
   virtio-net: Fix VLAN filter table reset timing
23* cad9aa6fbdcc Akihiko Odaki:
   pcie_sriov: Fix configuration and state synchronization
24* e8145dcd311b David Woodhouse:
   intel_iommu: Allow both Status Write and Interrupt Flag in QI wait
25* a7842d94067c Sairaj Kodilkar:
   hw/i386/amd_iommu: Move IOAPIC memory region initialization to the end
26* b10bd4bd17ac Zenghui Yu:
   hw/intc/arm_gicv3_kvm: Write all 1's to clear enable/active
27* 35cca0f95ff5 Vacha Bhavsar:
   target/arm: Fix big-endian handling of NEON gdb remote debugging
28* 97b3d732afec Vacha Bhavsar:
   target/arm: Fix handling of setting SVE registers from gdb
29* 13ed972b4ce5 Jamin Lin:
   hw/ssi/aspeed_smc: Fix incorrect FMC_WDT2 register read on AST1030
30* cd9f752fee75 Alex Richardson:
   target/arm: add support for 64-bit PMCCNTR in AArch32 mode
31* 0311a6edb9db Peter Maydell:
   scripts/make-release: Go back to cloning all the EDK2 submodules
32* b217d987a3c5 Michael Tokarev:
   qga: correctly write to /sys/power/state on linux
33 d973766e10 Michael Tokarev:
   Revert "i386/cpu: Fix cpu number overflow in CPUID.01H.EBX[23:16]"
34* e68ec2980901 Xiaoyao Li:
   i386/cpu: Move adjustment of CPUID_EXT_PDCM before feature_dependencies[] 
   check
35* f985a1195ba2 Chuang Xu:
   i386/cpu: Fix number of addressable IDs field for CPUID.01H.EBX[23:16]
36* a62fef582995 Qian Wen:
   i386/cpu: Fix cpu number overflow in CPUID.01H.EBX[23:16]
37* 4e5d58969ed6 Zhao Liu:
   target/i386/cpu: Move addressable ID encoding out of compat property in 
   CPUID[0x1]
38* 301fbbaf03fb Nicholas Piggin:
   ppc/xive: Fix xive trace event output
39* f0aab779418e Nicholas Piggin:
   ppc/xive: Report access size in XIVE TM operation error logs
40* f16697292add Glenn Miles:
   ppc/xive2: Fix calculation of END queue sizes
41* e8cf73b84987 Michael Kowal:
   ppc/xive2: Remote VSDs need to match on forwarding address
42* d1023a296c82 Nicholas Piggin:
   ppc/xive2: fix context push calculation of IPB priority
43* bde8c148bb22 Nicholas Piggin:
   ppc/xive: Fix PHYS NSR ring matching
44* 576830428eea Michael Kowal:
   ppc/xive2: Reset Generation Flipped bit on END Cache Watch
45* 8d373176181f Glenn Miles:
   ppc/xive2: Fix irq preempted by lower priority group irq
46* d4720a7faf4b Glenn Miles:
   ppc/xive2: Fix treatment of PIPR in CPPR update
47* c7ac771ee750 William Hu:
   ui/curses: Fix infinite loop on windows
48* e66644c48e96 WANG Rui:
   target/loongarch: Fix [X]VLDI raising exception incorrectly
49* 31b737b19dca Klaus Jensen:
   hw/nvme: fix namespace attachment
50* bc0c24fdb157 Klaus Jensen:
   hw/nvme: revert CMIC behavior
51* 53493c1f836f Keith Busch:
   hw/nvme: cap MDTS value for internal limitation
52* 4af976ef398e Kevin Wolf:
   rbd: Fix .bdrv_get_specific_info implementation
53* c0df98ab1f3d Werner Fink:
   qemu-iotests: Ignore indentation in Killed messages
54* e262646e12ac Philippe Mathieu-Daudé:
   hw/sd/ssi-sd: Return noise (dummy byte) when no card connected
55* 6ad034e71232 Sv. Lockal:
   mkvenv: Support pip 25.2
56* f757d9d90d19 Mauro Matteo Cascella:
   hw/uefi: clear uefi-vars buffer in uefi_vars_write callback
57* 88e5a28d5aab Gerd Hoffmann:
   hw/uefi: return success for notifications
58* fc8ee8fe58ad Gerd Hoffmann:
   hw/uefi: check access for first variable
59* 040237436f42 Gerd Hoffmann:
   hw/uefi: open json file in binary mode
60 ab85146ac4c6 Paolo Bonzini:
   python: mkvenv: fix messages printed by mkvenv
61 c12cbaa007c9 Zero Tang:
   i386/tcg/svm: fix incorrect canonicalization
62 f91563d011a0 Joel Stanley:
   linux-user: Add strace for rseq
63 376cdd7e9c94 Steve Sistare:
   hw/intc/arm_gicv3_kvm: preserve pending interrupts during cpr
64 186db6a73bc5 Smail AIDER:
   target/arm: Trap PMCR when MDCR_EL2.TPMCR is set
65 5ffd387e9e0f Peter Maydell:
   scripts/kernel-doc: Avoid new Perl precedence warning
66 1748c0d59228 Richard Henderson:
   qemu/atomic: Finish renaming atomic128-cas.h headers
67 2e27650bddd3 Peter Maydell:
   hw/arm/stm32f205_soc: Don't leak TYPE_OR_IRQ objects
68 85ff0e956bf2 Kostiantyn Kostiuk:
   qga/installer: Remove QGA VSS if QGA installation failed
69 edf3780a7dad Kostiantyn Kostiuk:
   qga-vss: Write hex value of error in log
70 28c5d27dd4dc minglei.liu:
   qga: Fix truncated output handling in guest-exec status reporting
71 b2e4534a2c9c Markus Armbruster:
   i386/kvm/vmsr_energy: Plug memory leak on failure to connect socket
72 ec14a3de622a Markus Armbruster:
   vfio scsi ui: Error-check qio_channel_socket_connect_sync() the same way
73 c9a1ea9c52e6 Markus Armbruster:
   Revert "tests/qtest: use qos_printf instead of g_test_message"
74 8e4649cac9bc Laurent Vivier:
   e1000e: Prevent crash from legacy interrupt firing after MSI-X enable
75 14ab44b96d5b Philippe Mathieu-Daudé:
   elf: Add EF_MIPS_ARCH_ASE definitions
76 7a09b3cc70ab Philippe Mathieu-Daudé:
   linux-user/mips: Select 74Kf CPU to run MIPS16e binaries
77 51c3aebfda64 Philippe Mathieu-Daudé:
   linux-user/mips: Select M14Kc CPU to run microMIPS binaries
78 1f82ca723478 Denis Rastyogin:
   target/mips: fix TLB huge page check to use 64-bit shift
79 46d03bb23dde Aditya Gupta:
   hw/ppc: Fix build error with CONFIG_POWERNV disabled
80 3284d1c07cfd Peter Maydell:
   hw/gpio/pca9554: Avoid leak in pca9554_set_pin()
81 606978500c3d Michael Tokarev:
   block/curl: fix curl internal handles handling

(commit(s) marked with * were in previous series and are not resent)

