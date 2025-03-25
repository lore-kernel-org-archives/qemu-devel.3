Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 330A9C36008
	for <qemu-devel@archiver.kernel.org>; Tue, 25 Mar 2025 06:56:22 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1twyAG-00081W-F4; Tue, 25 Mar 2025 02:53:32 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1twy8q-0005Mc-T9; Tue, 25 Mar 2025 02:52:05 -0400
Received: from isrv.corpit.ru ([86.62.121.231])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1twy8o-0001uM-Lv; Tue, 25 Mar 2025 02:52:04 -0400
Received: from tsrv.corpit.ru (tsrv.tls.msk.ru [192.168.177.2])
 by isrv.corpit.ru (Postfix) with ESMTP id C4C95107D75;
 Tue, 25 Mar 2025 09:49:33 +0300 (MSK)
Received: from gandalf.tls.msk.ru (mjt.wg.tls.msk.ru [192.168.177.130])
 by tsrv.corpit.ru (Postfix) with ESMTP id 671231D5E80;
 Tue, 25 Mar 2025 09:50:43 +0300 (MSK)
Received: by gandalf.tls.msk.ru (Postfix, from userid 1000)
 id 6930A57048; Tue, 25 Mar 2025 09:50:43 +0300 (MSK)
From: Michael Tokarev <mjt@tls.msk.ru>
To: qemu-devel@nongnu.org
Cc: qemu-stable@nongnu.org,
	Michael Tokarev <mjt@tls.msk.ru>
Subject: [Stable-9.2.3 v2 00/69] Patch Round-up for stable 9.2.3,
 freeze on 2025-03-24 (frozen)
Date: Tue, 25 Mar 2025 09:50:24 +0300
Message-Id: <qemu-stable-9.2.3-20250325094901@cover.tls.msk.ru>
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

The following patches are queued for QEMU stable v9.2.3:

  https://gitlab.com/qemu-project/qemu/-/commits/staging-9.2

Patch freeze is 2025-03-24 (frozen), and the release is planned for 2025-03-26:

  https://wiki.qemu.org/Planning/9.2

Please respond here or CC qemu-stable@nongnu.org on any additional patches
you think should (or shouldn't) be included in the release.

The changes which are staging for inclusion, with the original commit hash
from master branch, are given below the bottom line.

Thanks!

/mjt

--------------------------------------
01* b819fd699424 Peter Maydell:
   target/arm: Report correct syndrome for UNDEFINED CNTPS_*_EL1 from EL2 
   and NS EL1
02* 1960d9701ef7 Peter Maydell:
   target/arm: Report correct syndrome for UNDEFINED AT ops with wrong NSE, 
   NS
03* ccda792945d6 Peter Maydell:
   target/arm: Report correct syndrome for UNDEFINED S1E2 AT ops at EL3
04* 707d478ed8f2 Peter Maydell:
   target/arm: Report correct syndrome for UNDEFINED LOR sysregs when NS=0
05* 4cf494865161 Peter Maydell:
   target/arm: Make CP_ACCESS_TRAPs to AArch32 EL3 be Monitor traps
06* d04c6c3c000a Peter Maydell:
   hw/intc/arm_gicv3_cpuif: Don't downgrade monitor traps for AArch32 EL3
07* 4d436fb05c2a Peter Maydell:
   target/arm: Honour SDCR.TDCC and SCR.TERR in AArch32 EL3 non-Monitor modes
08* 2b95a2d01b04 Peter Maydell:
   target/arm: Correct errors in WFI/WFE trapping
09* 464ce71a963b Bernhard Beschow:
   Kconfig: Extract CONFIG_USB_CHIPIDEA from CONFIG_IMX
10* bc82af6b0dcb Akihiko Odaki:
   hw/net: Fix NULL dereference with software RSS
11* de538288e4da Thomas Huth:
   hw/i386/pc: Fix crash that occurs when introspecting TYPE_PC_MACHINE 
   machines
12* 38ef383073b8 Thomas Huth:
   hw/i386/microvm: Fix crash that occurs when introspecting the microvm 
   machine
13* 63dc0b864739 Sairaj Kodilkar:
   amd_iommu: Use correct DTE field for interrupt passthrough
14* 3684717b7407 Sairaj Kodilkar:
   amd_iommu: Use correct bitmask to set capability BAR
15* 83cb18ac4500 Stefano Garzarella:
   cryptodev/vhost: allocate CryptoDevBackendVhost using g_mem0()
16* 131fe64e63c8 Alexander Graf:
   hw/virtio/virtio-nsm: Respond with correct length
17* e87b6efb11be Matias Ezequiel Vara Larsen:
   vhost-user-snd: correct the calculation of config_size
18* 7bd4eaa847fc Bibo Mao:
   target/loongarch/gdbstub: Fix gdbstub incorrectly handling some registers
19* 6debfb2cb179 Paolo Bonzini:
   physmem: replace assertion with error
20* fd207677a830 Joelle van Dyne:
   target/arm/hvf: Disable SME feature
21* 12c365315ab2 Joelle van Dyne:
   target/arm/hvf: sign extend the data for a load operation when SSE=1
22* ffd455963f23 Max Chou:
   target/riscv: rvv: Fix unexpected behavior of vector reduction 
   instructions when vl is 0
23* bf3adf93f167 Max Chou:
   target/riscv: rvv: Fix incorrect vlen comparison in prop_vlen_set
24* 3fba76e61caa Daniel Henrique Barboza:
   target/riscv/debug.c: use wp size = 4 for 32-bit CPUs
25* c86edc547692 Daniel Henrique Barboza:
   target/riscv: throw debug exception before page fault
26* 3521f9cadc29 Rodrigo Dias Correa:
   goldfish_rtc: Fix tick_offset migration
27* 2ad638a3d160 Denis Rastyogin:
   block/qed: fix use-after-free by nullifying timer pointer after free
28* 87c8b4fc3c1c Markus Armbruster:
   docs/about/build-platforms: Correct minimum supported Python version
29* 3b2e22c0bbe2 Patrick Venture:
   hw/gpio: npcm7xx: fixup out-of-bounds access
30* db6c2192839e Peter Maydell:
   target/arm: Apply correct timer offset when calculating deadlines
31* 5709038aa8b4 Peter Maydell:
   target/arm: Don't apply CNTVOFF_EL2 for EL2_VIRT timer
32* bdd641541fbe Peter Maydell:
   target/arm: Make CNTPS_* UNDEF from Secure EL1 when Secure EL2 is enabled
33* 4aecd4b442d7 Peter Maydell:
   target/arm: Always apply CNTVOFF_EL2 for CNTV_TVAL_EL02 accesses
34* 02c648a0a103 Peter Maydell:
   target/arm: Refactor handling of timer offset for direct register accesses
35* f9f99d7ca522 Alex Bennée:
   target/arm: Implement SEL2 physical and virtual timers
36* 5dcaea8bcd82 Alex Bennée:
   hw/arm: enable secure EL2 timers for virt machine
37* 9a9d9e82093e Alex Bennée:
   hw/arm: enable secure EL2 timers for sbsa machine
38* cde3247651dc Peter Maydell:
   target/arm: Correct LDRD atomicity and fault behaviour
39* ee786ca11504 Peter Maydell:
   target/arm: Correct STRD atomicity
40* 02ae315467ce Peter Maydell:
   util/qemu-timer.c: Don't warp timer from timerlist_rearm()
41* db0d4017f9b9 Eugenio Pérez:
   net: parameterize the removing client from nc list
42* e7891c575fb2 Eugenio Pérez:
   net: move backend cleanup to NIC cleanup
43* 68adcc784bad Stefano Stabellini:
   xen: No need to flush the mapcache for grants
44* 29c041ca7f8d Nicholas Piggin:
   ppc/pnv/occ: Fix common area sensor offsets
45* 2fa3a5b94696 Peter Maydell:
   hw/net/smc91c111: Sanitize packet numbers
46* aad6f264add3 Peter Maydell:
   hw/net/smc91c111: Sanitize packet length on tx
47* 700d3d6dd41d Peter Maydell:
   hw/net/smc91c111: Don't allow data register access to overrun buffer
48* 3a11b653a63f Philippe Mathieu-Daudé:
   hw/xen/hvm: Fix Aarch64 typo
49* b75c5f987916 Kevin Wolf:
   block: Zero block driver state before reopening
50* 48170c2d865a Greg Kurz:
   docs: Rename default-configs to configs
51 e6c38d2ab55d Joe Komlodi:
   util/cacheflush: Make first DSB unconditional on aarch64
52 298a04998fa4 Richard Henderson:
   target/arm: Make DisasContext.{fp, sve}_access_checked tristate
53 cc7abc35dfa7 Richard Henderson:
   target/arm: Simplify pstate_sm check in sve_access_check
54 02ce6cea71be Guo Hongyu:
   target/loongarch: Fix vldi inst
55* 50e975414906 Konstantin Shkolnyy:
   vdpa: Fix endian bugs in shadow virtqueue
56 b027f55a994a Konstantin Shkolnyy:
   vdpa: Allow vDPA to work on big-endian machine
57 672cb29d1e81 Santiago Monserrat Campanello:
   docs/about/emulation: Fix broken link
58 86c78b280607 Deepak Gupta:
   target/riscv: fix access permission checks for CSR_SSP
59 d2c5759c8dd4 Deepak Gupta:
   target/riscv: fixes a bug against `ssamoswap` behavior in M-mode
60 1a010d22b7ad Richard Henderson:
   linux-user/riscv: Fix handling of cpu mask in riscv_hwprobe syscall
61 ca2737d6eca7 Yao Zi:
   host/include/loongarch64: Fix inline assembly compatibility with Clang
62 1490d0bcdfcb Harsh Prateek Bora:
   ppc/spapr: fix default cpu for pre-9.0 machines.
63 8defe9da0813 Nicholas Piggin:
   target/ppc: Fix facility interrupt checks for VSX
64 73c0c904fc99 Nicholas Piggin:
   target/ppc: Fix e200 duplicate SPRs
65 14fb6dbbc50f Michael Tokarev:
   Makefile: "make dist" generates a .xz, not .bz2
66 e83845316abc Chao Liu:
   target/riscv: refactor VSTART_CHECK_EARLY_EXIT() to accept vl as a 
   parameter
67 4e9e2478dfd2 Chao Liu:
   target/riscv: fix handling of nop for vstart >= vl in some vector 
   instruction
68 78877b2e0646 Jamin Lin:
   hw/misc/aspeed_hace: Fix buffer overflow in has_padding function
69 7b8cbe5162e6 Steven Lee:
   hw/intc/aspeed: Fix IRQ handler mask check

(commit(s) marked with * were in previous series and are not resent)

