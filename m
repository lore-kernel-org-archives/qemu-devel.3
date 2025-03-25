Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6C13DC35FFC
	for <qemu-devel@archiver.kernel.org>; Tue, 25 Mar 2025 06:50:57 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1twy7d-0004X0-HR; Tue, 25 Mar 2025 02:50:50 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1twy7a-0004WW-SK; Tue, 25 Mar 2025 02:50:46 -0400
Received: from isrv.corpit.ru ([86.62.121.231])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1twy7Y-0001cM-9y; Tue, 25 Mar 2025 02:50:46 -0400
Received: from tsrv.corpit.ru (tsrv.tls.msk.ru [192.168.177.2])
 by isrv.corpit.ru (Postfix) with ESMTP id 93862107D5F;
 Tue, 25 Mar 2025 09:49:21 +0300 (MSK)
Received: from gandalf.tls.msk.ru (mjt.wg.tls.msk.ru [192.168.177.130])
 by tsrv.corpit.ru (Postfix) with ESMTP id 32B3E1D5E6E;
 Tue, 25 Mar 2025 09:50:31 +0300 (MSK)
Received: by gandalf.tls.msk.ru (Postfix, from userid 1000)
 id 2BB5257024; Tue, 25 Mar 2025 09:50:31 +0300 (MSK)
From: Michael Tokarev <mjt@tls.msk.ru>
To: qemu-devel@nongnu.org
Cc: qemu-stable@nongnu.org,
	Michael Tokarev <mjt@tls.msk.ru>
Subject: [Stable-7.2.17 v2 00/34] Patch Round-up for stable 7.2.17,
 freeze on 2025-03-24 (frozen)
Date: Tue, 25 Mar 2025 09:50:21 +0300
Message-Id: <qemu-stable-7.2.17-20250325094839@cover.tls.msk.ru>
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

The following patches are queued for QEMU stable v7.2.17:

  https://gitlab.com/qemu-project/qemu/-/commits/staging-7.2

Patch freeze is 2025-03-24 (frozen), and the release is planned for 2025-03-26:

  https://wiki.qemu.org/Planning/7.2

Please respond here or CC qemu-stable@nongnu.org on any additional patches
you think should (or shouldn't) be included in the release.

The changes which are staging for inclusion, with the original commit hash
from master branch, are given below the bottom line.

Thanks!

/mjt

--------------------------------------
01* 27a8d899c7a1 Khem Raj:
   linux-user: Do not define struct sched_attr if libc headers do
02* 4dafba778aa3 Volker Rümelin:
   ui/sdl2: reenable the SDL2 Windows keyboard hook procedure
03* 7a74e468089a Mikael Szreder:
   target/sparc: Fix gdbstub incorrectly handling registers f32-f62
04* b819fd699424 Peter Maydell:
   target/arm: Report correct syndrome for UNDEFINED CNTPS_*_EL1 from EL2 
   and NS EL1
05* ccda792945d6 Peter Maydell:
   target/arm: Report correct syndrome for UNDEFINED S1E2 AT ops at EL3
06* 707d478ed8f2 Peter Maydell:
   target/arm: Report correct syndrome for UNDEFINED LOR sysregs when NS=0
07* 4cf494865161 Peter Maydell:
   target/arm: Make CP_ACCESS_TRAPs to AArch32 EL3 be Monitor traps
08* d04c6c3c000a Peter Maydell:
   hw/intc/arm_gicv3_cpuif: Don't downgrade monitor traps for AArch32 EL3
09* 464ce71a963b Bernhard Beschow:
   Kconfig: Extract CONFIG_USB_CHIPIDEA from CONFIG_IMX
10* 63dc0b864739 Sairaj Kodilkar:
   amd_iommu: Use correct DTE field for interrupt passthrough
11* 6291a28645a0 Philippe Mathieu-Daudé:
   hw/i386/amd_iommu: Explicit use of AMDVI_BASE_ADDR in amdvi_init
12* 3684717b7407 Sairaj Kodilkar:
   amd_iommu: Use correct bitmask to set capability BAR
13* 83cb18ac4500 Stefano Garzarella:
   cryptodev/vhost: allocate CryptoDevBackendVhost using g_mem0()
14* ffd455963f23 Max Chou:
   target/riscv: rvv: Fix unexpected behavior of vector reduction 
   instructions when vl is 0
15* 3fba76e61caa Daniel Henrique Barboza:
   target/riscv/debug.c: use wp size = 4 for 32-bit CPUs
16* c86edc547692 Daniel Henrique Barboza:
   target/riscv: throw debug exception before page fault
17* 3521f9cadc29 Rodrigo Dias Correa:
   goldfish_rtc: Fix tick_offset migration
18* 2ad638a3d160 Denis Rastyogin:
   block/qed: fix use-after-free by nullifying timer pointer after free
19* 3b2e22c0bbe2 Patrick Venture:
   hw/gpio: npcm7xx: fixup out-of-bounds access
20* 29c041ca7f8d Nicholas Piggin:
   ppc/pnv/occ: Fix common area sensor offsets
21* 937df81af675 Peter Maydell:
   hw/net/smc91c111: Ignore attempt to pop from empty RX fifo
22* 2fa3a5b94696 Peter Maydell:
   hw/net/smc91c111: Sanitize packet numbers
23* aad6f264add3 Peter Maydell:
   hw/net/smc91c111: Sanitize packet length on tx
24* 700d3d6dd41d Peter Maydell:
   hw/net/smc91c111: Don't allow data register access to overrun buffer
25* b75c5f987916 Kevin Wolf:
   block: Zero block driver state before reopening
26* 48170c2d865a Greg Kurz:
   docs: Rename default-configs to configs
27 9cf6e41fe293 Philippe Mathieu-Daudé:
   ui/cocoa: Temporarily ignore annoying deprecated declaration warnings
28 e6c38d2ab55d Joe Komlodi:
   util/cacheflush: Make first DSB unconditional on aarch64
29 298a04998fa4 Richard Henderson:
   target/arm: Make DisasContext.{fp, sve}_access_checked tristate
30 cc7abc35dfa7 Richard Henderson:
   target/arm: Simplify pstate_sm check in sve_access_check
31* 50e975414906 Konstantin Shkolnyy:
   vdpa: Fix endian bugs in shadow virtqueue
32 b027f55a994a Konstantin Shkolnyy:
   vdpa: Allow vDPA to work on big-endian machine
33 73c0c904fc99 Nicholas Piggin:
   target/ppc: Fix e200 duplicate SPRs
34 78877b2e0646 Jamin Lin:
   hw/misc/aspeed_hace: Fix buffer overflow in has_padding function

(commit(s) marked with * were in previous series and are not resent)

