Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8D1D9C28B2F
	for <qemu-devel@archiver.kernel.org>; Sat, 15 Mar 2025 07:43:33 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ttMAe-0001uV-FX; Sat, 15 Mar 2025 03:43:00 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1ttMAb-0001tX-HG; Sat, 15 Mar 2025 03:42:57 -0400
Received: from isrv.corpit.ru ([86.62.121.231])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1ttMAY-0004jn-8D; Sat, 15 Mar 2025 03:42:56 -0400
Received: from tsrv.corpit.ru (tsrv.tls.msk.ru [192.168.177.2])
 by isrv.corpit.ru (Postfix) with ESMTP id 7F219FFAF4;
 Sat, 15 Mar 2025 10:41:55 +0300 (MSK)
Received: from gandalf.tls.msk.ru (mjt.wg.tls.msk.ru [192.168.177.130])
 by tsrv.corpit.ru (Postfix) with ESMTP id 69D251CACBE;
 Sat, 15 Mar 2025 10:42:49 +0300 (MSK)
Received: by gandalf.tls.msk.ru (Postfix, from userid 1000)
 id 58E69559D4; Sat, 15 Mar 2025 10:42:49 +0300 (MSK)
From: Michael Tokarev <mjt@tls.msk.ru>
To: qemu-devel@nongnu.org
Cc: qemu-stable@nongnu.org,
	Michael Tokarev <mjt@tls.msk.ru>
Subject: [Stable-8.2.10 00/42] Patch Round-up for stable 8.2.10,
 freeze on 2025-03-24
Date: Sat, 15 Mar 2025 10:42:02 +0300
Message-Id: <qemu-stable-8.2.10-20250315104136@cover.tls.msk.ru>
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

The following patches are queued for QEMU stable v8.2.10:

  https://gitlab.com/qemu-project/qemu/-/commits/staging-8.2

Patch freeze is 2025-03-24, and the release is planned for 2025-03-26:

  https://wiki.qemu.org/Planning/8.2

Please respond here or CC qemu-stable@nongnu.org on any additional patches
you think should (or shouldn't) be included in the release.

The changes which are staging for inclusion, with the original commit hash
from master branch, are given below the bottom line.

Thanks!

/mjt

--------------------------------------
01 27a8d899c7a1 Khem Raj:
   linux-user: Do not define struct sched_attr if libc headers do
02 1e3d4d9a1a32 Laurent Vivier:
   qmp: update vhost-user protocol feature maps
03 66a1b4991c32 Thomas Huth:
   gitlab-ci.d/cirrus: Update the FreeBSD job to v14.2
04 4dafba778aa3 Volker Rümelin:
   ui/sdl2: reenable the SDL2 Windows keyboard hook procedure
05 937df81af675 Peter Maydell:
   hw/net/smc91c111: Ignore attempt to pop from empty RX fifo
06 7a74e468089a Mikael Szreder:
   target/sparc: Fix gdbstub incorrectly handling registers f32-f62
07 c81d1fafa623 Richard Henderson:
   linux-user: Honor elf alignment when placing images
08 4b7b20a3b72c Fabiano Rosas:
   elfload: Fix alignment when unmapping excess reservation
09 b819fd699424 Peter Maydell:
   target/arm: Report correct syndrome for UNDEFINED CNTPS_*_EL1 from EL2 
   and NS EL1
10 1960d9701ef7 Peter Maydell:
   target/arm: Report correct syndrome for UNDEFINED AT ops with wrong NSE, 
   NS
11 ccda792945d6 Peter Maydell:
   target/arm: Report correct syndrome for UNDEFINED S1E2 AT ops at EL3
12 707d478ed8f2 Peter Maydell:
   target/arm: Report correct syndrome for UNDEFINED LOR sysregs when NS=0
13 4cf494865161 Peter Maydell:
   target/arm: Make CP_ACCESS_TRAPs to AArch32 EL3 be Monitor traps
14 d04c6c3c000a Peter Maydell:
   hw/intc/arm_gicv3_cpuif: Don't downgrade monitor traps for AArch32 EL3
15 4d436fb05c2a Peter Maydell:
   target/arm: Honour SDCR.TDCC and SCR.TERR in AArch32 EL3 non-Monitor modes
16 464ce71a963b Bernhard Beschow:
   Kconfig: Extract CONFIG_USB_CHIPIDEA from CONFIG_IMX
17 63dc0b864739 Sairaj Kodilkar:
   amd_iommu: Use correct DTE field for interrupt passthrough
18 3684717b7407 Sairaj Kodilkar:
   amd_iommu: Use correct bitmask to set capability BAR
19 83cb18ac4500 Stefano Garzarella:
   cryptodev/vhost: allocate CryptoDevBackendVhost using g_mem0()
20 50e975414906 Konstantin Shkolnyy:
   vdpa: Fix endian bugs in shadow virtqueue
21 7bd4eaa847fc Bibo Mao:
   target/loongarch/gdbstub: Fix gdbstub incorrectly handling some registers
22 12c365315ab2 Joelle van Dyne:
   target/arm/hvf: sign extend the data for a load operation when SSE=1
23 ffd455963f23 Max Chou:
   target/riscv: rvv: Fix unexpected behavior of vector reduction 
   instructions when vl is 0
24 3fba76e61caa Daniel Henrique Barboza:
   target/riscv/debug.c: use wp size = 4 for 32-bit CPUs
25 c86edc547692 Daniel Henrique Barboza:
   target/riscv: throw debug exception before page fault
26 3521f9cadc29 Rodrigo Dias Correa:
   goldfish_rtc: Fix tick_offset migration
27 2ad638a3d160 Denis Rastyogin:
   block/qed: fix use-after-free by nullifying timer pointer after free
28 87c8b4fc3c1c Markus Armbruster:
   docs/about/build-platforms: Correct minimum supported Python version
29 3b2e22c0bbe2 Patrick Venture:
   hw/gpio: npcm7xx: fixup out-of-bounds access
30 cde3247651dc Peter Maydell:
   target/arm: Correct LDRD atomicity and fault behaviour
31 ee786ca11504 Peter Maydell:
   target/arm: Correct STRD atomicity
32 02ae315467ce Peter Maydell:
   util/qemu-timer.c: Don't warp timer from timerlist_rearm()
33 db0d4017f9b9 Eugenio Pérez:
   net: parameterize the removing client from nc list
34 e7891c575fb2 Eugenio Pérez:
   net: move backend cleanup to NIC cleanup
35 29c041ca7f8d Nicholas Piggin:
   ppc/pnv/occ: Fix common area sensor offsets
36 2fa3a5b94696 Peter Maydell:
   hw/net/smc91c111: Sanitize packet numbers
37 aad6f264add3 Peter Maydell:
   hw/net/smc91c111: Sanitize packet length on tx
38 700d3d6dd41d Peter Maydell:
   hw/net/smc91c111: Don't allow data register access to overrun buffer
39 3a11b653a63f Philippe Mathieu-Daudé:
   hw/xen/hvm: Fix Aarch64 typo
40 b75c5f987916 Kevin Wolf:
   block: Zero block driver state before reopening
41 48170c2d865a Greg Kurz:
   docs: Rename default-configs to configs
42 9cf6e41fe293 Philippe Mathieu-Daudé:
   ui/cocoa: Temporarily ignore annoying deprecated declaration warnings

