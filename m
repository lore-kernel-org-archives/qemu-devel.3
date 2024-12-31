Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 71BB6E77188
	for <qemu-devel@archiver.kernel.org>; Tue, 31 Dec 2024 15:21:21 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tSe2T-0001VN-7s; Tue, 31 Dec 2024 10:20:09 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <tomitamoeko@gmail.com>)
 id 1tSe2R-0001TS-OD
 for qemu-devel@nongnu.org; Tue, 31 Dec 2024 10:20:07 -0500
Received: from mail-pl1-x644.google.com ([2607:f8b0:4864:20::644])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <tomitamoeko@gmail.com>)
 id 1tSe2Q-0004Pn-3f
 for qemu-devel@nongnu.org; Tue, 31 Dec 2024 10:20:07 -0500
Received: by mail-pl1-x644.google.com with SMTP id
 d9443c01a7336-21661be2c2dso122768355ad.1
 for <qemu-devel@nongnu.org>; Tue, 31 Dec 2024 07:20:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1735658405; x=1736263205; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=fv8TDkpuXKMzX6doq09O8WaBd227yXR7oY2Dt7j1sM0=;
 b=bOO/TWKxnHT+VFWWNyKCH8c02TRZyuFWoc4OX2lxqDzzmbov8vAXciZtouLpn8jiEU
 d2EhurhaKrao6ezeMv1FlEj7gTgz2FAmBUo0LBNUOgaqJMk3J8lsdVu2UYxjZ5s8KCZy
 z6jbl4sM59ZChkHMk4MEl+tbuFMVnWYEembUX5iGCD6koeYyJtNsLLKUbt6M3rESHL0c
 /d6Pr4TKqUAIXc982eQdvk4g8GE66RkjQKy7gA5icUM0cAwzurcfA6bNOAgBOR+pgLH0
 btH8KdLdw/g1jmTNGa2CElWwdg2Av9UABtb9pxHdBFMiosREQNfuEnmeZYQT5qUH4IuH
 c3vw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1735658405; x=1736263205;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=fv8TDkpuXKMzX6doq09O8WaBd227yXR7oY2Dt7j1sM0=;
 b=XS9RegTglqOoNaaXfUEHr6qvFvK20DPoXedx4vm73NuNSmFPyBrB0fKy/GG4LOs07/
 BZ0XbsbyhX1RJCvtF2MKBzAzpcBULtOvy7Wi+WIWNOluz5FBIjQZud17ZZjbuPBaHS7S
 uZaYn862Y9Xuazg/RLv05UJ+Qz9fZtQkAaVEL9vb2wBdyIxZzpSnqsvu6hwo8lEYqurF
 SBUybXuFp1TaLb97klPbsa+XN4HRLrnit8FxOtR9hOle3Kg0y2f/oF+x8xqhD+9dVGLy
 bk/XmUxKTPc5szMl724Hb3MbouN06ONGYuPOXolqEoLgZNyJcvhGCTUoaSd0tPhcxzzD
 Guww==
X-Gm-Message-State: AOJu0YxsC67BhFj83hRz7rf2jtAQ0MV57LAqcvR+rfVf0HNnnAAWF9SZ
 2jokQXaAw8v5rWo37V894NgPaooQHCXHteL5Rfo3ZV89vfPAjf4=
X-Gm-Gg: ASbGncshT7qpohovVGWkOG3sTUAUt6H5MsqiOk3TryhNc9hihkpJyx1aPDIapshZY+T
 prSTHoV1csyNDnJo2fEkq+Pc1Z9ESeABozGd7vQwjohvaGChoAOA0QxLWv0RhYLnLK1pqJb1DNE
 gny7C852a1WAWIOBpcj55N/0poWxYiB0rcJirRgBtGxlAoHOzp5mkxgyBBd7sIlipdhXhLgBCp8
 8lYS3VhKsF22HsVvbnUohIfNIlWy7bsvK+8WLoqQ11TIXn/V0d/1gq30SUvHyXUbnK9mQ==
X-Google-Smtp-Source: AGHT+IHpgDV9czZpTkOgf8qgRnPVfP8mJs01IU7QujUGTZCRZphxm7XG81N/WT9oSixBYmCSpdvJdQ==
X-Received: by 2002:a05:6a20:9f96:b0:1e0:dd4a:46b3 with SMTP id
 adf61e73a8af0-1e5e0461e0dmr55946280637.16.1735658404821; 
 Tue, 31 Dec 2024 07:20:04 -0800 (PST)
Received: from localhost.localdomain ([58.38.120.107])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-72aad8309e8sm20933481b3a.43.2024.12.31.07.20.03
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 31 Dec 2024 07:20:04 -0800 (PST)
From: Tomita Moeko <tomitamoeko@gmail.com>
To: Alex Williamson <alex.williamson@redhat.com>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>
Cc: qemu-devel@nongnu.org,
	Tomita Moeko <tomitamoeko@gmail.com>
Subject: [PATCH 2/3] vfio/pci: introduce config_offset field in
 VFIOConfigMirrorQuirk
Date: Tue, 31 Dec 2024 23:19:52 +0800
Message-ID: <20241231151953.59992-3-tomitamoeko@gmail.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20241231151953.59992-1-tomitamoeko@gmail.com>
References: <20241231151953.59992-1-tomitamoeko@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::644;
 envelope-from=tomitamoeko@gmail.com; helo=mail-pl1-x644.google.com
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

Device may only expose a specific portion of PCI config space through a
region in a BAR, such behavior is seen in igd GGC and BDSM mirrors in
BAR0. To handle these, config_offset is introduced to allow mirroring
arbitrary region in PCI config space.

Signed-off-by: Tomita Moeko <tomitamoeko@gmail.com>
---
 hw/vfio/pci-quirks.c | 5 +++++
 hw/vfio/pci-quirks.h | 3 ++-
 2 files changed, 7 insertions(+), 1 deletion(-)

diff --git a/hw/vfio/pci-quirks.c b/hw/vfio/pci-quirks.c
index bb2ce1d904..5a0b25a544 100644
--- a/hw/vfio/pci-quirks.c
+++ b/hw/vfio/pci-quirks.c
@@ -162,6 +162,7 @@ static uint64_t vfio_generic_quirk_mirror_read(void *opaque,
     (void)vfio_region_read(&vdev->bars[mirror->bar].region,
                            addr + mirror->offset, size);
 
+    addr += mirror->config_offset;
     data = vfio_pci_read_config(&vdev->pdev, addr, size);
     trace_vfio_quirk_generic_mirror_read(vdev->vbasedev.name,
                                          memory_region_name(mirror->mem),
@@ -175,6 +176,7 @@ static void vfio_generic_quirk_mirror_write(void *opaque, hwaddr addr,
     VFIOConfigMirrorQuirk *mirror = opaque;
     VFIOPCIDevice *vdev = mirror->vdev;
 
+    addr += mirror->config_offset;
     vfio_pci_write_config(&vdev->pdev, addr, data, size);
     trace_vfio_quirk_generic_mirror_write(vdev->vbasedev.name,
                                           memory_region_name(mirror->mem),
@@ -456,6 +458,7 @@ static void vfio_probe_ati_bar2_quirk(VFIOPCIDevice *vdev, int nr)
     mirror->mem = quirk->mem;
     mirror->vdev = vdev;
     mirror->offset = 0x4000;
+    mirror->config_offset = 0;
     mirror->bar = nr;
 
     memory_region_init_io(mirror->mem, OBJECT(vdev),
@@ -908,6 +911,7 @@ static void vfio_probe_nvidia_bar0_quirk(VFIOPCIDevice *vdev, int nr)
     mirror->mem = quirk->mem;
     mirror->vdev = vdev;
     mirror->offset = 0x88000;
+    mirror->config_offset = 0;
     mirror->bar = nr;
     last = (LastDataSet *)&mirror->data;
     last->quirk = quirk;
@@ -929,6 +933,7 @@ static void vfio_probe_nvidia_bar0_quirk(VFIOPCIDevice *vdev, int nr)
         mirror->mem = quirk->mem;
         mirror->vdev = vdev;
         mirror->offset = 0x1800;
+        mirror->config_offset = 0;
         mirror->bar = nr;
         last = (LastDataSet *)&mirror->data;
         last->quirk = quirk;
diff --git a/hw/vfio/pci-quirks.h b/hw/vfio/pci-quirks.h
index c0e96a01cc..d1532e379b 100644
--- a/hw/vfio/pci-quirks.h
+++ b/hw/vfio/pci-quirks.h
@@ -60,7 +60,8 @@ extern const MemoryRegionOps vfio_generic_window_data_quirk;
  */
 typedef struct VFIOConfigMirrorQuirk {
     struct VFIOPCIDevice *vdev;
-    uint32_t offset;
+    uint32_t offset; /* Offset in BAR */
+    uint32_t config_offset; /* Offset in PCI config space */
     uint8_t bar;
     MemoryRegion *mem;
     uint8_t data[];
-- 
2.45.2


