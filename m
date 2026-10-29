Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E9FAB606A31A
	for <qemu-devel@archiver.kernel.org>; Thu, 29 Oct 2026 16:17:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=hl32ZzU5
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xMSor-0001CZ-8t; Thu, 29 Oct 2026 12:17:38 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <tomitamoeko@gmail.com>)
 id 1xMSoa-00015r-MX
 for qemu-devel@nongnu.org; Thu, 29 Oct 2026 12:17:21 -0400
Received: from mail-dl2-x09.google.com ([2607:f8b0:4864:38::9])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <tomitamoeko@gmail.com>)
 id 1xMSoY-00014P-Ud
 for qemu-devel@nongnu.org; Thu, 29 Oct 2026 12:17:20 -0400
Received: by mail-dl2-x09.google.com with SMTP id
 a92af1059eb24-1397ad3d891so499623c88.0
 for <qemu-devel@nongnu.org>; Thu, 29 Oct 2026 09:17:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20260707; t=1793290636; x=1793895436; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=gVcC5Gzf2tPZg/I6MzhH11U85cUkzdbrm3zPjb3Wf3k=;
 b=hl32ZzU57PnypuZebGyNlrUGRnVqTxmF4aYOqxSR0WkICUese265KDMRPnubWlzjnM
 2vm8QfcTrZ8dUF03HN72V4pTVxeiKQdfBUTqEM3nnicx60eLPACFDU7iFrqNlrelTxCf
 vAAze1+tF+6zefL88Fiu06OfTV6UVgqwPEDvMxyvHwP1n1xXlFH1IdivvTiyIiOoI10H
 qxvP0BHG2KH7XdAoP/YW4I/KEd5NOWhffwugq5djCv9nVv1NfD0+aU9YvS4T8erF9xAR
 9qUF9eSDJkn+f4O/rn5iVRqaHqgzipY/LY8oNONTL6H69Vqstr13AqAJWH0+1vOzzngL
 rVdA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793290636; x=1793895436;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=gVcC5Gzf2tPZg/I6MzhH11U85cUkzdbrm3zPjb3Wf3k=;
 b=ooTbVtoNtNPul0GIARBbIY5b7XJSrsI0ZtgqZwy5+9A1yzOKjpyikFvA/09KtgOVPy
 uwwElYVk/e9WwWVHjX5UtSWXFEaBSOk92dEbWCqqK6OypzueQ8T48aLWdnyMeIhDYDyE
 hG2LzS9qh89fUdLz9Rhe0/RN+NUNHzlgerrM5LmwyIdGyGjcSFtdTkWF17znls9z44Ts
 RW60cP/ikq7lQl7sXKII3c0BE+lqmfGEzP1iyrIzCHmlEe6+/F2vqYQ/QFQXirk56AVT
 75ISPlSspKe9cd+6M/T/U2pq70rH1hpS+UpM/uh9i5v5tRctldwAY9Xbr+ls5YonpcHT
 fiPg==
X-Gm-Message-State: AFq9FYKNZhGGDJpuORqeoSzHdUoTz81jCbDiL9v33xHfRoKkMwBnXfvs
 Im1TtyoIzRDuli9pimhLrBFlCe/uL/2AAaaxKbksmVzBQW54GZHdHyb3ucV0aas=
X-Gm-Gg: AYBFou0kVGgpz4mzKiJmLBX6qJdZDqp+5C7BD9SyLVDO/++b0NCWQVwoHHmeViRcmdC
 JdKu1OARJYfXuWtCTrOSea0gGqF3yvYFJGVAdIpj1+H7P/DKxiKSOSVF3aZWX79hxlwGvti80w+
 fd9z7g79NQlPkxjnh3VR5+XgPuI4eOoFwbRY6OkXPfbd79kauEM1jK00W2tw5w+CMwKlj6ZdyOB
 VPen0qgp1Lj2o/wCQiGemKIQnKYmRHQ19LmserFCi8dYH2dvmCwnno9kc6GlbfCViLu+qqSKd4b
 eFE/YpbesgrC3hIXflRa7nDVmhkP7Jk/0+Nbv53wqnD5xToLFuqxRv2bD9jHwW71bvybH6g2EBj
 hR3kuxqW3dqt7PNsYuNWVceOj+phEvCrpS5tdKNDLMxne4EeF4FeL6c29Z6rANI8ffSI/a9jA76
 6HbjxL678FIDAyHeK11JEZVIWYLTJu+6jxp1gM1x4lOjU1GRKjITkMXh54S21Gp1oboBbeZO+V2
 yeW5I2qfa6G4xI0FR6aAGNCqGnIyYJvkbG9EYivvFU4ZjC+Hfx2w7ZxUfZOZfP0lVGz/w4qjRq9
 EqF9Lzt9JmZO1zeMCA==
X-Received: by 2002:a05:7301:c009:b0:36a:713:a76b with SMTP id
 5a478bee46e88-36a2007fcc2mr7457102eec.6.1793290635975; 
 Thu, 29 Oct 2026 09:17:15 -0700 (PDT)
Received: from kotori-desktop ([2408:820c:8ffa:1190::9a0])
 by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-36a410fa771sm188887eec.27.2026.10.29.09.17.10
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 29 Oct 2026 09:17:15 -0700 (PDT)
From: Tomita Moeko <tomitamoeko@gmail.com>
To: qemu-devel@nongnu.org
Cc: Alex Williamson <alex@shazbot.org>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>,
 Tomita Moeko <tomitamoeko@gmail.com>, Yuan Wang <yuan1.wang@intel.com>,
 Bosheng Xue <bosheng.xue@intel.com>, Junjie Cao <junjie.cao@intel.com>
Subject: [PATCH] vfio/igd: Use version mapping for MTL/ARL quirk selection
Date: Fri, 30 Oct 2026 00:17:02 +0800
Message-ID: <20261029161702.117078-1-tomitamoeko@gmail.com>
X-Mailer: git-send-email 2.53.0
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:38::9;
 envelope-from=tomitamoeko@gmail.com; helo=mail-dl2-x09.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_PASS,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Meteor Lake and Arrow Lake use graphics IP version 12.70, but igd_gen()
only returns the major version (generation). Encode the existing device
ID mapping as (version * 100 + release) so that MTL/ARL can be selected
in the BAR0 pcode stolen access quirk instead of a separate device ID
check.

Signed-off-by: Tomita Moeko <tomitamoeko@gmail.com>
Cc: Yuan Wang <yuan1.wang@intel.com>
Cc: Bosheng Xue <bosheng.xue@intel.com>
Cc: Junjie Cao <junjie.cao@intel.com>
---
 hw/vfio/igd.c | 30 +++++++++++++++++-------------
 1 file changed, 17 insertions(+), 13 deletions(-)

diff --git a/hw/vfio/igd.c b/hw/vfio/igd.c
index 4c7d654592..728b60d3d4 100644
--- a/hw/vfio/igd.c
+++ b/hw/vfio/igd.c
@@ -58,8 +58,9 @@
  * not be taken as an indication that all the devices are supported, or even
  * supportable, some of them don't even support VT-d.
  * See linux:include/drm/i915_pciids.h for IDs.
+ * Returns (version * 100 + release).
  */
-static int igd_gen(VFIOPCIDevice *vdev)
+static int igd_graphics_ver(VFIOPCIDevice *vdev)
 {
     /*
      * Device IDs for Broxton/Apollo Lake are 0x0a84, 0x1a84, 0x1a85, 0x5a84
@@ -67,38 +68,39 @@ static int igd_gen(VFIOPCIDevice *vdev)
      * Prefix 0x0a is taken by Haswell, this rule should be matched first.
      */
     if ((vdev->device_id & 0xffe) == 0xa84) {
-        return 9;
+        return 900;
     }
 
     switch (vdev->device_id & 0xff00) {
     case 0x0100:    /* SandyBridge, IvyBridge */
-        return 6;
+        return 600;
     case 0x0400:    /* Haswell */
     case 0x0a00:    /* Haswell */
     case 0x0c00:    /* Haswell */
     case 0x0d00:    /* Haswell */
     case 0x0f00:    /* Valleyview/Bay Trail */
-        return 7;
+        return 700;
     case 0x1600:    /* Broadwell */
     case 0x2200:    /* Cherryview */
-        return 8;
+        return 800;
     case 0x1900:    /* Skylake */
     case 0x3100:    /* Gemini Lake */
     case 0x5900:    /* Kaby Lake */
     case 0x3e00:    /* Coffee Lake */
     case 0x9B00:    /* Comet Lake */
-        return 9;
+        return 900;
     case 0x8A00:    /* Ice Lake */
     case 0x4500:    /* Elkhart Lake */
     case 0x4E00:    /* Jasper Lake */
-        return 11;
+        return 1100;
     case 0x9A00:    /* Tiger Lake */
     case 0x4C00:    /* Rocket Lake */
     case 0x4600:    /* Alder Lake */
     case 0xA700:    /* Raptor Lake */
+        return 1200;
     case 0x7D00:    /* Meteor Lake / Arrow Lake */
     case 0xB600:    /* Arrow Lake */
-        return 12;
+        return 1270;
     }
 
     /*
@@ -109,6 +111,12 @@ static int igd_gen(VFIOPCIDevice *vdev)
     return -1;
 }
 
+static int igd_gen(VFIOPCIDevice *vdev)
+{
+    int ver = igd_graphics_ver(vdev);
+    return ver < 0 ? -1 : ver / 100;
+}
+
 #define IGD_ASLS 0xfc /* ASL Storage Register */
 #define IGD_GMCH 0x50 /* Graphics Control Register */
 #define IGD_BDSM 0x5c /* Base Data of Stolen Memory */
@@ -458,10 +466,6 @@ static bool vfio_pci_igd_override_gms(int gen, uint32_t gms, uint32_t *gmch)
 #define IGD_BDSM_MMIO_OFFSET        0x1080C0
 #define IGD_MTL_PCODE_STOLEN_ACCESS 0x138914
 
-#define IGD_IS_MTL_OR_ARL(vdev) \
-    ((((vdev)->device_id & 0xff00) == 0x7d00) || \
-     (((vdev)->device_id & 0xff00) == 0xb600))
-
 static uint64_t vfio_igd_pcode_stolen_access_read(void *opaque, hwaddr addr,
                                                   unsigned size)
 {
@@ -591,7 +595,7 @@ void vfio_probe_igd_bar0_quirk(VFIOPCIDevice *vdev, int nr)
      * Return 0 for PCODE stolen memory access detection (0x138914) so GOP
      * stays on the standard access path in the VM.
      */
-    if (IGD_IS_MTL_OR_ARL(vdev)) {
+    if (igd_graphics_ver(vdev) == 1270) {
         pcode_stolen_access_quirk = vfio_quirk_alloc(1);
         memory_region_init_io(pcode_stolen_access_quirk->mem, OBJECT(vdev),
                               &vfio_igd_pcode_stolen_access_quirk, vdev,
-- 
2.53.0


