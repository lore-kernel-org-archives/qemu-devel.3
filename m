Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 49861C8303C
	for <qemu-devel@archiver.kernel.org>; Fri, 11 Jul 2025 08:31:19 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ua95D-0000TO-8a; Fri, 11 Jul 2025 04:26:15 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1ua8xH-00047V-SI; Fri, 11 Jul 2025 04:18:04 -0400
Received: from isrv.corpit.ru ([212.248.84.144])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1ua8xE-0003vj-Gj; Fri, 11 Jul 2025 04:18:03 -0400
Received: from tsrv.corpit.ru (tsrv.tls.msk.ru [192.168.177.2])
 by isrv.corpit.ru (Postfix) with ESMTP id 1FCAA1356CB;
 Fri, 11 Jul 2025 11:17:18 +0300 (MSK)
Received: from think4mjt.tls.msk.ru (mjtthink.wg.tls.msk.ru [192.168.177.146])
 by tsrv.corpit.ru (Postfix) with ESMTP id 1704823FA40;
 Fri, 11 Jul 2025 11:17:45 +0300 (MSK)
From: Michael Tokarev <mjt@tls.msk.ru>
To: qemu-devel@nongnu.org
Cc: qemu-stable@nongnu.org,
	Michael Tokarev <mjt@tls.msk.ru>
Subject: [Stable-10.0.3 00/39] Patch Round-up for stable 10.0.3,
 freeze on 2025-07-21
Date: Fri, 11 Jul 2025 11:15:56 +0300
Message-ID: <qemu-stable-10.0.3-20250711105634@cover.tls.msk.ru>
X-Mailer: git-send-email 2.47.2
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=212.248.84.144; envelope-from=mjt@tls.msk.ru;
 helo=isrv.corpit.ru
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9,
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

The following patches are queued for QEMU stable v10.0.3:

  https://gitlab.com/qemu-project/qemu/-/commits/staging-10.0

Patch freeze is 2025-07-21, and the release is planned for 2025-07-23:

  https://wiki.qemu.org/Planning/10.0

Please respond here or CC qemu-stable@nongnu.org on any additional patches
you think should (or shouldn't) be included in the release.

The changes which are staging for inclusion, with the original commit hash
from master branch, are given below the bottom line.

Thanks!

/mjt

--------------------------------------
01 fb8e59abbe46 Jamin Lin:
   hw/misc/aspeed_hace: Ensure HASH_IRQ is always set to prevent firmware 
   hang
02 e6941ac10619 Jamin Lin:
   hw/arm/aspeed_ast27x0: Fix RAM size detection failure on BE hosts
03 9498e2f7e1a2 Weifeng Liu:
   ui/gtk: Document scale and coordinate handling
04 3a6b314409b4 Weifeng Liu:
   ui/gtk: Use consistent naming for variables in different coordinates
05 a19665448156 Weifeng Liu:
   gtk/ui: Introduce helper gd_update_scale
06 8fb072472c38 Weifeng Liu:
   ui/gtk: Update scales in fixed-scale mode when rendering GL area
07 30aa105640b0 Weifeng Liu:
   ui/sdl: Consider scaling in mouse event handling
08 7ed96710e82c Daniel P. Berrangé:
   ui/vnc.c: replace big endian flag with byte order value
09 70097442853c Daniel P. Berrangé:
   ui/vnc: take account of client byte order in pixman format
10 63d320909220 Daniel P. Berrangé:
   ui/vnc: fix tight palette pixel encoding for 8/16-bpp formats
11 e6bc01777e5a Guenter Roeck:
   hw/arm: Add missing psci_conduit to NPCM8XX SoC boot info
12 a9403bfcd930 Huaitong Han:
   vhost: Don't set vring call if guest notifier is unused
13 0b006153b7ec Bernhard Beschow:
   hw/i386/pc_piix: Fix RTC ISA IRQ wiring of isapc machine
14 31753d5a336f Sairaj Kodilkar:
   hw/i386/amd_iommu: Fix device setup failure when PT is on.
15 0f178860df34 Vasant Hegde:
   hw/i386/amd_iommu: Fix xtsup when vcpus < 255
16 5ddd6c8dc849 Volker Rümelin:
   audio: fix SIGSEGV in AUD_get_buffer_size_out()
17 ccb4fec0e5f2 Volker Rümelin:
   audio: fix size calculation in AUD_get_buffer_size_out()
18 d009f26a54f5 Volker Rümelin:
   hw/audio/asc: fix SIGSEGV in asc_realize()
19 0b901459a87a Xin Li (Intel):
   target/i386: Remove FRED dependency on WRMSRNS
20 2e887187454e Stefan Hajnoczi:
   iotests: fix 240
21 eef2dd03f948 Fiona Ebner:
   hw/core/qdev-properties-system: Add missing return in set_drive_helper()
22 9c55c03c05c1 Bibo Mao:
   hw/loongarch/virt: Fix big endian support with MCFG table
23 f5ec751ee70d Shameer Kolothum:
   hw/arm/virt: Check bypass iommu is not set for iommu-map DT property
24 e372214e663a Ethan Chen:
   qemu-options.hx: Fix reversed description of icount sleep behavior
25 cd38e638c43e Peter Maydell:
   hw/arm/mps2: Configure the AN500 CPU with 16 MPU regions
26 5ad2b1f443a9 J. Neuschäfer:
   linux-user/arm: Fix return value of SYS_cacheflush
27 e7788da9860c Song Gao:
   target/loongarch: add check for fcond
28 c2a2e1ad2a74 Song Gao:
   target/loongarch: fix vldi/xvldi raise wrong error
29 0d0fc3f46589 Richard Henderson:
   tcg: Fix constant propagation in tcg_reg_alloc_dup
30 9a3bf0e0ab62 Solomon Tan:
   target/arm: Make RETA[AB] UNDEF when pauth is not implemented
31 a412575837b6 Philippe Mathieu-Daudé:
   target/arm: Correct KVM & HVF dtb_compatible value
32 1fa2ffdbec55 Yiwei Zhang:
   virtio-gpu: support context init multiple timeline
33 78e378154120 Kevin Wolf:
   hw/s390x/ccw-device: Fix memory leak in loadparm setter
34 f9b0f6930407 Richard Henderson:
   target/arm: Fix SME vs AdvSIMD exception priority
35 b4b2e070f41d Richard Henderson:
   target/arm: Fix sve_access_check for SME
36 e6ffd009c771 Richard Henderson:
   target/arm: Fix 128-bit element ZIP, UZP, TRN
37 3801c5b75ffc Richard Henderson:
   target/arm: Fix PSEL size operands to tcg_gen_gvec_ands
38 cfc688c00ade Richard Henderson:
   target/arm: Fix f16_dotadd vs nan selection
39 bf020eaa6741 Richard Henderson:
   target/arm: Fix bfdotadd_ebf vs nan selection

