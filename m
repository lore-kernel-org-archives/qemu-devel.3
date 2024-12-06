Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0A2AFE7717B
	for <qemu-devel@archiver.kernel.org>; Fri,  6 Dec 2024 12:32:32 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tJXSK-0007Cs-NE; Fri, 06 Dec 2024 07:29:12 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <tomitamoeko@gmail.com>)
 id 1tJXRR-000607-Hx
 for qemu-devel@nongnu.org; Fri, 06 Dec 2024 07:28:17 -0500
Received: from mail-pg1-x543.google.com ([2607:f8b0:4864:20::543])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <tomitamoeko@gmail.com>)
 id 1tJXRN-00044B-TN
 for qemu-devel@nongnu.org; Fri, 06 Dec 2024 07:28:16 -0500
Received: by mail-pg1-x543.google.com with SMTP id
 41be03b00d2f7-7e6d04f74faso1418400a12.1
 for <qemu-devel@nongnu.org>; Fri, 06 Dec 2024 04:28:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1733488092; x=1734092892; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=DbyhL467kLFoNyl59lj+CqWMKUpCY5M1py2Usy4VavY=;
 b=IIo3F1XipzVPKoQU7L3/CXHmYs4GRU4hq8RDGfobATi4GGnYp2ZEOnRyJK8vGeFFR4
 VaQUhZRlPId4Xj+3sJCC6mRS1Z/JTurpfgcFdaHjoOIILlDgNkPMeOXi4zVQg/sjbCuT
 TliT4WSoSDr6oj380aKBUR6Scf5nS85VwF9NSTnTEwrzJGqE1l712rzVsUqsjRBwvtuT
 91VEu/fBXSzxgWIqlq+/fM2rNtJHfNgE6GbWwK6rbufhI/L3pgacX/9MAzpSCHoSEYGk
 +3SVem0zYqPNvg9WwHKDUvnWvC8+LaXQwT8qiPjaodALUe3PbM21HtS9AJvi8G1oBlDI
 AfRA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1733488092; x=1734092892;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=DbyhL467kLFoNyl59lj+CqWMKUpCY5M1py2Usy4VavY=;
 b=W3H669w60dbGAax0gfT1TKLGt1P52JdHXJjlN308F3jlFZPpXwsn3Tfx+z0D4DS6u6
 ZhiZgx8BvW6E0UD6fiiGR4wrdids854SILZIMMCKO1yx/IN72MzkrHmxIZ97f9T3TAeW
 4I2BGB0OoqHWp9K7pZkbNmIc0pncSCJWHx5c38SYpoxEQFC8DujMpPMa1Q5GxzpAyouc
 REXI7p6w0JuWceBCfjfxr8zrhMtEb6Z2B2jZmpwJxd3NKQyQvx1CA9HW3A6PH4LARlSG
 uA+MlfV6vpgz/AidAKWYoFBNfy7NO+EvndUX0yLydvrUUUN0ecLPM/hKPTHSji1PJTLn
 Breg==
X-Gm-Message-State: AOJu0Yzbw8Lc381HqFSgsSZTuA66L2hhvDhvqcsZ46mPAc5neDflNcvG
 XWRzMfnLnDhBr3eY7vJojiCUsVvWYRnuGsJQJ8Fs6PvbHZWyju4=
X-Gm-Gg: ASbGncuavLAfUdz4BLYFL5rCjXWHE39rTDG8gfxzrOG+fXRCGSCFrbc9rOwXDVX8PQK
 I0Vh08fdC3FZBQlmCVWFYoh3GfgdC+f1Rvbybfa7invAwlibDxR7jk57ZEWrspfC00fXPR39Os+
 ckF2i7QMhlpR5M79bQ1wE96tcdInTOLQCju7jq/dMVEtStGsJUjjk0nipLx6aWmFywnXqshRk32
 vOthN5iaD9YcgrZFHtJxIsAv4Ltp9Q09oBt/JtAZRaJ03FxO1Hg4/r42Q==
X-Google-Smtp-Source: AGHT+IHsa5HWvav2cpVUakpvjSeMJk2vdddGmxJ7TKhFYDXJjteWN7/lkHX2hBlcultZsrKnIwc5cA==
X-Received: by 2002:a17:90a:2ca3:b0:2ef:2980:4411 with SMTP id
 98e67ed59e1d1-2ef41c0db62mr11259048a91.9.1733488092525; 
 Fri, 06 Dec 2024 04:28:12 -0800 (PST)
Received: from kotori-desktop.lan ([58.38.120.33])
 by smtp.gmail.com with ESMTPSA id
 41be03b00d2f7-7fd15710123sm2579866a12.49.2024.12.06.04.28.10
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 06 Dec 2024 04:28:12 -0800 (PST)
From: Tomita Moeko <tomitamoeko@gmail.com>
To: Alex Williamson <alex.williamson@redhat.com>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>
Cc: qemu-devel@nongnu.org,
 =?UTF-8?q?Corvin=20K=C3=B6hne?= <c.koehne@beckhoff.com>,
 Tomita Moeko <tomitamoeko@gmail.com>
Subject: [PATCH v4 07/10] vfio/igd: add macro for declaring mirrored registers
Date: Fri,  6 Dec 2024 20:27:45 +0800
Message-ID: <20241206122749.9893-8-tomitamoeko@gmail.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20241206122749.9893-1-tomitamoeko@gmail.com>
References: <20241206122749.9893-1-tomitamoeko@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::543;
 envelope-from=tomitamoeko@gmail.com; helo=mail-pg1-x543.google.com
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

igd devices have multipe registers mirroring mmio address and pci
config space, more than a single BDSM register. To support this,
the read/write functions are made common and a macro is defined to
simplify the declaration of MemoryRegionOps.

Signed-off-by: Tomita Moeko <tomitamoeko@gmail.com>
---
 hw/vfio/igd.c | 60 ++++++++++++++++++++++++++++++---------------------
 1 file changed, 36 insertions(+), 24 deletions(-)

diff --git a/hw/vfio/igd.c b/hw/vfio/igd.c
index 49b6547776..18d159aa8e 100644
--- a/hw/vfio/igd.c
+++ b/hw/vfio/igd.c
@@ -421,16 +421,9 @@ static const MemoryRegionOps vfio_igd_index_quirk = {
     .endianness = DEVICE_LITTLE_ENDIAN,
 };
 
-#define IGD_BDSM_MMIO_OFFSET 0x1080C0
-
-static uint64_t vfio_igd_quirk_bdsm_read(void *opaque,
-                                          hwaddr addr, unsigned size)
+static uint64_t vfio_igd_pci_config_read(VFIOPCIDevice *vdev, uint64_t offset,
+                                         unsigned size)
 {
-    VFIOPCIDevice *vdev = opaque;
-    uint64_t offset;
-
-    offset = IGD_BDSM_GEN11 + addr;
-
     switch (size) {
     case 1:
         return pci_get_byte(vdev->pdev.config + offset);
@@ -441,21 +434,17 @@ static uint64_t vfio_igd_quirk_bdsm_read(void *opaque,
     case 8:
         return pci_get_quad(vdev->pdev.config + offset);
     default:
-        hw_error("igd: unsupported read size, %u bytes", size);
+        hw_error("igd: unsupported pci config read at %lx, size %u",
+                 offset, size);
         break;
     }
 
     return 0;
 }
 
-static void vfio_igd_quirk_bdsm_write(void *opaque, hwaddr addr,
-                                       uint64_t data, unsigned size)
+static void vfio_igd_pci_config_write(VFIOPCIDevice *vdev, uint64_t offset,
+                                      uint64_t data, unsigned size)
 {
-    VFIOPCIDevice *vdev = opaque;
-    uint64_t offset;
-
-    offset = IGD_BDSM_GEN11 + addr;
-
     switch (size) {
     case 1:
         pci_set_byte(vdev->pdev.config + offset, data);
@@ -470,17 +459,39 @@ static void vfio_igd_quirk_bdsm_write(void *opaque, hwaddr addr,
         pci_set_quad(vdev->pdev.config + offset, data);
         break;
     default:
-        hw_error("igd: unsupported read size, %u bytes", size);
+        hw_error("igd: unsupported pci config write at %lx, size %u",
+                 offset, size);
         break;
     }
 }
 
-static const MemoryRegionOps vfio_igd_bdsm_quirk = {
-    .read = vfio_igd_quirk_bdsm_read,
-    .write = vfio_igd_quirk_bdsm_write,
-    .endianness = DEVICE_LITTLE_ENDIAN,
+#define VFIO_IGD_QUIRK_MIRROR_REG(reg, name)                            \
+static uint64_t vfio_igd_quirk_read_##name(void *opaque,                \
+                                           hwaddr addr, unsigned size)  \
+{                                                                       \
+    VFIOPCIDevice *vdev = opaque;                                       \
+                                                                        \
+    return vfio_igd_pci_config_read(vdev, reg + addr, size);            \
+}                                                                       \
+                                                                        \
+static void vfio_igd_quirk_write_##name(void *opaque, hwaddr addr,      \
+                                        uint64_t data, unsigned size)   \
+{                                                                       \
+    VFIOPCIDevice *vdev = opaque;                                       \
+                                                                        \
+    vfio_igd_pci_config_write(vdev, reg + addr, data, size);            \
+}                                                                       \
+                                                                        \
+static const MemoryRegionOps vfio_igd_quirk_mirror_##name = {           \
+    .read = vfio_igd_quirk_read_##name,                                 \
+    .write = vfio_igd_quirk_write_##name,                               \
+    .endianness = DEVICE_LITTLE_ENDIAN,                                 \
 };
 
+VFIO_IGD_QUIRK_MIRROR_REG(IGD_BDSM_GEN11, bdsm)
+
+#define IGD_BDSM_MMIO_OFFSET    0x1080C0
+
 void vfio_probe_igd_bar0_quirk(VFIOPCIDevice *vdev, int nr)
 {
     VFIOQuirk *quirk;
@@ -510,8 +521,9 @@ void vfio_probe_igd_bar0_quirk(VFIOPCIDevice *vdev, int nr)
     quirk = vfio_quirk_alloc(1);
     quirk->data = vdev;
 
-    memory_region_init_io(&quirk->mem[0], OBJECT(vdev), &vfio_igd_bdsm_quirk,
-                          vdev, "vfio-igd-bdsm-quirk", 8);
+    memory_region_init_io(&quirk->mem[0], OBJECT(vdev),
+                          &vfio_igd_quirk_mirror_bdsm, vdev,
+                          "vfio-igd-bdsm-quirk", 8);
     memory_region_add_subregion_overlap(vdev->bars[0].region.mem,
                                         IGD_BDSM_MMIO_OFFSET, &quirk->mem[0],
                                         1);
-- 
2.45.2


