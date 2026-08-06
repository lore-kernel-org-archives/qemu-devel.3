Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 37522C55174
	for <qemu-devel@archiver.kernel.org>; Thu,  6 Aug 2026 01:07:16 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wrmYF-00026y-9u; Wed, 05 Aug 2026 21:05:39 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brchuckz@aol.com>) id 1wrmY4-0001tI-Gt
 for qemu-devel@nongnu.org; Wed, 05 Aug 2026 21:05:28 -0400
Received: from sonic311-25.consmr.mail.ne1.yahoo.com ([66.163.188.206])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <brchuckz@aol.com>) id 1wrmY1-0006N3-Ir
 for qemu-devel@nongnu.org; Wed, 05 Aug 2026 21:05:27 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=aol.com; s=a2048;
 t=1785978322; bh=G3VmkipyMhZjj38uG/j4xipQ/TGQEWVZ1kywsdVeHas=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From:Subject:Reply-To;
 b=sYh2bdc5USWGn/sFhSPBJe1EnhxZwUUrqvj6+oB/+JhLjRbMnVh3ubZYOYS5WoeKzb47Ne6IdsUr+VjRfAq1jQOMuqLmQDN5nDLtrS3DO/eKwtYyXyibDTdDvisZ0WRb8Xyyv7mON2D3Li4ATYkY5IfbFjubGkG5Q8wRdJ43aS7qp5mSvnjFRY+KskoQomSsIri5FNhgQghUnIYROeMM2Mp+/ugQzt/TlGlBgsHiTQW0emGg6+aqLt3B6JbGnfgVGTkmju/re4cvJSWOpM0gHj0RWDutE1O6iyiKsebTnLghagbWhAl7QvVLmwTJvQ9v7VbPNlDQAw5kkJhscqLP2w==
X-SONIC-DKIM-SIGN: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048;
 t=1785978323; bh=DZ9DSj/zpZJ3CsUxLDF6vIBJyRg0So43YHTPMQfuJzl=;
 h=X-Sonic-MF:From:To:Subject:Date:From:Subject;
 b=TAKI7iHY46DjDMy++WItmCEFlDeyjlPs21SUXO0aljNq/2YyX2/COoN7d0+2e2YIPHsw2g5FFMEDH8l75xCjHJgb9Z/zCGVy68wfROiuG3/OXveUYSM2rTBn6QuJbBvfbfUGrqG/CPsY/BTXWtGw9fLZo8E6jkplPHW0FQ/7IGtkun1/1F0v8dNNjgyaSbctYhseiz6/Ym9cvSgDT07oW+3x8V6fYm1QZgw3PE819oS91wLUcqMna8rCyrTiFd9ffPRd/rxP2ZVNE89g0NsWE+Dz1EPjkuSABRrLzTR2j1h+x9qoKRa6m+igpzNJ+TdBYfG/Wm7zvXUfNQbATfBUtQ==
X-YMail-OSG: MK2xyiEVM1mskLxz7Nzv39526zcsIPBExeYJkJ6wwg4Pj7cCurKbGeeUSjkNAg5
 Wg6SU9axyUHI.gGoWPw3yN.J9PfmYE42REwRg6sBTQzgu2NEa1PkSI71xSyPnmk6Nvx738HTf9w7
 dUyDx9ZvQoqjsEhkQomCM9xunTW5RshlOICtH3y.dhV4Icz39Vgt4uuFdX4jbd2dnDqGj0vnxw31
 TlDQbsVjdc2uC33HzYzumdCjHf0BFoMC3sqsIhMd8mXqY5Iwr6GWQ33QJRYFGCc_ClN2CK2e.FO5
 CBNNHWiMSqA5X5lO5VbgbAP8WZJtuUgkDgULDS6VHqraDXhM.4F_Qq8OlcRGxUnGIiQB.RwIgR.m
 giAgfnSysr4GZdMwxhE4Sy.ylDeCtvO.Bxnjg_1KhYzUZLw53HJ4wEV.Xd4h.uulOl40wQFyugU7
 TA4ye7aYvWJW3ybt4ACGEwzfLYTu6vIJJar1ABuktyaKu0YFlRQ3VNExJYRHwSfC8jER.KlXP2kK
 ehmQ0zkxeXl7FIjPY0KhhGRsAVDaLTFzu_w9iGLENNk.rSHaxJy92adtBp1DmMwXKC9vVe4BpTAw
 Pp.Ms2_WnYXp8G39Aio1cKvP4IZR7Nk3BlHkDfJ28sBOP1s4if.p3jmhLjnVQCh3htfQyhxtm56d
 EdLjfVqkyF3DyhD1K_KctZjXYVF_3Roq5AuxNkmJSEmoC.lVZnIm9GH_pMhF5tJSPMmqHLpyKcEs
 30oX.OITe50tYOLvnf5Cd8rEf3tcoJCDeAYRUq80rinoSaaChYs1qZg6wCUxTqVQAQ_JRg6vBkq8
 ghRpDSLtjLhRGvpV2Rr9GukwbQPjMJ2OzC2Vc5REMRcMAA8GjRazto24P0c6SBoJ.TGhTPeHW.ze
 .hB1FKxmTyyuesnANSBe2UFg3gi0gwgfho5OssocFgr2cHUdbsumdUsdvYoKvvWqltnG7yz3WBXM
 s5sgutRVx5S0pJdQ8NlhgkUnaR1JEmCXdd6xE20WSvfrs5xGjX9oX1GxQT60AU6exo2b_C4Lg.x3
 oVo7No7MTuw2RM2oJYxuVxgqMa7i2FMmyuzFsA4CtFERiA.zmByC4ZNaPtwPibn9jttakKgmaymn
 CNhlbogFnNY7GNAulF_Mp0InKzXoTjVGPXLbjmSpoSn3R7pgowzThrHRLCVw3AArpKrZDxqbDk6p
 ULrXqTil2x5RJOOeeSqElUxMu.LX.Egf05mDG3yvnAT5eaD.pWpwkJIYELMQBQQ_TPY2TWGcPUzh
 Y0owemd.IPVo4aJ0kHg4gck8C.C1sXfOMYRpbzjYK3dQhv_Mam7aHTY.33orh6PSva82D1gbGr6X
 Ptw9wpn4IpM.H64I5A5G9jbVNkqzMcMSAkGOGGhHcY39hXJgxOt8MqLEbQZMF_QgJaaFiEZhvyMi
 bgBc.mnDx.2tz6LljKKrtvV.qDI1haWPf.9MD7gIwQu94tctzGm6QvJVgLl4CvVy4wtMwhC7OK46
 y.9JsBpMNRxKaPFthdfwct_.pUYD0pNkk1jvObfQdPaelAVPthSq1d9DKeJlgQ8LQwQEOXAnOcaU
 7ojhZAWihDIOhA1vEiTV3n9T4WYQBaTQPwT26YSYt4ocgp78AJOIhDgkJ3r_fEVZKPNwf1tHOHnC
 cTWqil54q1DiY36AFrqJed90uIiIK.TkwxCX9Ev91irKlcWsfLwH6iBCPPCVr4we99H1kHToEqeW
 MzO5pDyfaeNd83lNStHKneUBbBfFt5.c1N_h7CLeL26Q44apRYC5jk14fsryUIDrHO5Cnh6B9pvd
 jImYKbY2z3bPvVD3ZzHG5sj.616szDR88RkZ2jTgt_mtuCSu8mg07WC1gXAYIZARQvCpwbknHhUS
 MKMLYBKKDJU0U5zEoKPoOxtGF_dGkQD4gAF_5CjAp8K8Ptqhlnb4YTdsX.lxxHigF1LUD3p8L07R
 r6E6R_iUr5NBpacyKSJzYKXkoeeLfKbyMpCw4OJ0_4Fy.v3R1ADimO4uKo1ilUhtUTOcZ.WkRJV7
 e4xuC9RwBAevbyvJM_8sESWSDgN4lRqcxBRwA3jjmqzUuod1onTzjLMlyh73OKpUJcSsYd8FiVMd
 yACclYtGNxBqeZWcHaMs80lwpWaE2QPMLnwEw4GhR.Rj_aKyatY2CLiyL.kpGePTCcT4yO8YGG0m
 34C17PuwEmDDyXCxekBzXUchFB_QTyam7SK68sYCbjOmeoqJ2ZDwJg7aJmHV5
X-Sonic-MF: <brchuckz@aol.com>
X-Sonic-ID: af215a46-7fce-4258-a2a7-e4fc20b5d1e5
Received: from sonic.gate.mail.ne1.yahoo.com by
 sonic311.consmr.mail.ne1.yahoo.com with HTTP; Thu, 6 Aug 2026 01:05:22 +0000
Received: by hermes--production-bf1-54b5569bdc-xjdx5 (Yahoo Inc. Hermes SMTP
 Server) with ESMTPA ID 734f0c8329adecc00a98ec91cc943adb; 
 Thu, 06 Aug 2026 01:05:16 +0000 (UTC)
From: Chuck Zmudzinski <brchuckz@aol.com>
To: qemu-devel@nongnu.org
Cc: qemu-stable@nongnu.org, xen-devel@lists.xenproject.org,
 Stefano Stabellini <sstabellini@kernel.org>,
 Anthony PERARD <anthony@xenproject.org>,
 "Edgar E . Iglesias" <edgar.iglesias@gmail.com>,
 Jan Beulich <jbeulich@suse.com>, Andrew Cooper <andrew.cooper3@citrix.com>,
 =?UTF-8?q?Roger=20Pau=20Monn=C3=A9?= <roger@xenproject.org>,
 Teddy Astie <teddy.astie@vates.tech>, Tomita Moeko <tomitamoeko@gmail.com>
Subject: [PATCH v5 4/6] xen/igd: enable guest creation when ROM read fails
Date: Wed,  5 Aug 2026 21:04:54 -0400
Message-ID: <20260806010506.492490-5-brchuckz@aol.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260806010506.492490-1-brchuckz@aol.com>
References: <20260806010506.492490-1-brchuckz@aol.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=66.163.188.206; envelope-from=brchuckz@aol.com;
 helo=sonic311-25.consmr.mail.ne1.yahoo.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

For newer IGD devices, the host option ROM is not readable from sysfs
and this results in a call to error_fail() that causes Qemu to
exit(1) so guest creation fails with the current implementation for
many newer IGD devices. But this read failure need not be a fatal
error causing guest creation to fail because the guest does not need
the option ROM to successfully boot and run. The guest only needs the
option ROM for getting graphics output from the guest during early
boot before the guest OS loads the Intel IGD graphics drivers.

To fix this, allow guest creation to continue by avoiding setting errp
if the attempt to read the host ROM file from sysfs fails. In this case,
the memory for the guest option ROM has been allocated so free that
memory by calling object_unparent(OBJECT(&s->dev.rom)) before
continuing.

Replace the error_report() and error_printf() messages for this case
when the option ROM cannot be read via sysfs with a suitable
info_report() message.

In the case when the host option ROM cannot be read via the sysfs
interface, xen_pt_register_regions() will attempt to setup the option
ROM for the guest the same way it would for any other Xen passthrough
PCI device that has an option ROM.

Signed-off-by: Chuck Zmudzinski <brchuckz@aol.com>
---
Changes in v4:
  - v4 is the first version of the series that has this patch

Changes in v5:
  - Shorten info_report message to resolve checkpatch line length warning

This patch provides initial support for many newer Intel IGD devices
so, at least, guest creation will not fail if such newer Intel
IGD devices are passed through to a Xen HVM guest. But this patch
alone is not sufficient for proper operation of the Intel IGD
for many, if not all, of the newer Intel IGD devices when passed
through to a Xen HVM guest.

There are two main problems with more recent, modern devices:

1. The newer divices might require patches to the Intel OpRegion
   and also an extended video bios table (VBT). Without support
   for these aspects of the newer devices, the experience will
   not be great and in many cases the Intel IGD still will not
   function properly in the guest.

2. The newer devices only work with UEFI AFAICT, and the Ovmf*
   platforms provided by the upsream edk2 project do not provide
   support for the Intel IGD. It appears the problem is that the
   ekd2 project deems the fact that the hardware manufacturer does
   not provide the necessary firmware, the EFI graphics output
   protocol (GOP) driver, in the ordinary way by making the EFI
   GOP driver accessible in virtual environments via the option
   ROM of the real PCI device, to be a reason to reject patches
   that add support for the Intel IGD. This, however, is not a
   fatal problem since it only affects the guest during early boot
   when OVMF or the bootloader is running and the guest OS
   graphics drivers have not yet been loaded. Lack of support
   for the Intel IGD in OVMF does not seem to affect the experience
   negatively once the guest OS graphics drivers have been loaded.
   So efforts to address this problem are only important in cases
   when it is necessary to get graphics output from OVMF and/or
   the guest bootloader.

The next two patches in this patchset address these two problems.
Of those two patches, the first one is more necessary, and the
second of those two patches is only needed to provide graphics output
from the guest during early boot.

 hw/xen/xen_pt_graphics.c | 7 +++++++
 hw/xen/xen_pt_load_rom.c | 5 +----
 2 files changed, 8 insertions(+), 4 deletions(-)

diff --git a/hw/xen/xen_pt_graphics.c b/hw/xen/xen_pt_graphics.c
index 0ae95cc..a124233 100644
--- a/hw/xen/xen_pt_graphics.c
+++ b/hw/xen/xen_pt_graphics.c
@@ -187,6 +187,13 @@ void xen_pt_setup_vga(XenPCIPassthroughState *s, XenHostPCIDevice *dev,
         return;
     }
 
+    /* Case when the host ROM file from sysfs could not be read */
+    if (!bios_size) {
+        object_unparent(OBJECT(&s->dev.rom));
+        bios = NULL;
+        return;
+    }
+
     if (bios_size < sizeof(struct rom_header)) {
         error_setg(errp, "VGA: VBIOS image corrupt (too small)");
         return;
diff --git a/hw/xen/xen_pt_load_rom.c b/hw/xen/xen_pt_load_rom.c
index 407b630..eaf0ae1 100644
--- a/hw/xen/xen_pt_load_rom.c
+++ b/hw/xen/xen_pt_load_rom.c
@@ -77,10 +77,7 @@ void *pci_assign_dev_load_option_rom(PCIDevice *dev,
     memset(ptr, 0xff, dev->romsize);
 
     if (!fread(ptr, 1, st.st_size, fp)) {
-        error_report("pci-assign: Cannot read from host %s", rom_file);
-        error_printf("Device option ROM contents are probably invalid "
-                     "(check dmesg).\nSkip option ROM probe with rombar=0, "
-                     "or load from file with romfile=\n");
+        info_report("pci-assign: Can't read Option ROM %s from host", rom_file);
         goto close_rom;
     }
 
-- 
2.52.0


