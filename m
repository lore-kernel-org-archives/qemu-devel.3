Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A33A3C3ABAA
	for <qemu-devel@archiver.kernel.org>; Mon,  5 May 2025 17:05:17 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uBzF7-0005ts-SB; Mon, 05 May 2025 13:04:37 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <tomitamoeko@gmail.com>)
 id 1uBzEK-0005PX-J4
 for qemu-devel@nongnu.org; Mon, 05 May 2025 13:03:51 -0400
Received: from mail-pl1-x644.google.com ([2607:f8b0:4864:20::644])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <tomitamoeko@gmail.com>)
 id 1uBzEI-0003bO-5h
 for qemu-devel@nongnu.org; Mon, 05 May 2025 13:03:48 -0400
Received: by mail-pl1-x644.google.com with SMTP id
 d9443c01a7336-227d6b530d8so43216765ad.3
 for <qemu-devel@nongnu.org>; Mon, 05 May 2025 10:03:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1746464625; x=1747069425; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=hJwJHiJB0iHJl8WVa0nZGVloU9GdqXULF4TLgfiyH6M=;
 b=AHDNxR4BBBo8lCmTilR/e7wAk0j8A3t0c6npYBAguwoBMpCIUwo549lPlPr/yqVRCa
 w43Ro9lRYNbVj2lZG+YlzCLKOnH7CDFk/GHU4exUWWkuXMVE4Tb0ktGrRu7ZsVgmnNgA
 S4rA2STL0PMP79R8yuvsHE8gpDKh1lIYjkxTeNp2nOlKo8OkdWaEaxs3LV35hDG6BI0L
 L1UqEmmdyvUiOlljWrpidrlHtxyScMYIIKMBIQHYptrAGDY2VhVKwPNcRmG4/V1ILFUM
 Ql8r1O9RGLV5PLBvzKMWUzKMj4AlWkcRNnWUBtnYfsK1j7NmvBqOOJdHzoOVLkgDRHb8
 6Vag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1746464625; x=1747069425;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=hJwJHiJB0iHJl8WVa0nZGVloU9GdqXULF4TLgfiyH6M=;
 b=g87vX0nUiTYE9AndmmLE/y1dT5+/p06daOKTkBb2Osvt+n9kdLabgnwya8RwOzoqam
 sqW/PiqHzDRIh3dAUhkq49VruHSjCjQKzee+KhRJieN67/5ebQ8drjBXcaeFYdzemlk0
 JIeu67iL1OfeCZVU9aAICM4VziH/Y8Qu8uRH2e7d7Ql/4tHVu/4rurhTgY12sp5cMc65
 Dg4EJJ9ZUv5iyWk5Ss0T4m0j6+qpcCgER2UoIyt2qeXAnhgzT+0B6gWOQPM7P3CR8JFM
 VfakyOrTShpkYnFLA/egCLt9y57WhLKtRSlyCFVrYuKEjJaUO1oyw/v3tIgIu372gu7L
 OtNw==
X-Gm-Message-State: AOJu0Yy03d29cuOxTWiL3KwA5qF7yLDjoCoJxY1RH/itfxGgcZm69zYe
 fOlWlPfO/7GGhzNMzXmMz2fvYhRVFHp+Wbn5e8fT+v3EOLEcWr8=
X-Gm-Gg: ASbGncuT7mSDUkLrnoWX6hU8LPnmtF6Vm/8yd5RLyyZkg2bLuT4dpF3K2Kwx9A1Hgdy
 0lglDDJnBeQ4ArdRh31lemtWSHhI8wNBLN/+V7ox1E8p7cGF1fPAHxhjikml4gbpQlf4Kh/RSOW
 Nzma4kFInC/BuobcKyF3VoxljMzQeUHbLmuu86l7ktxPJ9FBBQ3+EXTTTIWvxI+ivUrRy8mhFZg
 sqyZh2K0lFef1lvpne10tbTU3G+BSBWubyf740OA0Jm5DPHIIRRbId7Vr22Wzv7XwIxsPbEoFLd
 Gn+21Cqko7XNFUK9gn4EhhqF1BYbuqkUss97umooP9boRCMN3sfMTBMe
X-Google-Smtp-Source: AGHT+IHkZW4ZK/UdlgnD2kFJvMYVz8HYqxIieTsvxy3wO3LxibZpk4oM0JPDoA3B9lsd9iCI0anrtA==
X-Received: by 2002:a17:903:1aec:b0:224:1935:fb91 with SMTP id
 d9443c01a7336-22e10313ad3mr207584025ad.27.1746464623719; 
 Mon, 05 May 2025 10:03:43 -0700 (PDT)
Received: from localhost.localdomain ([139.227.182.131])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-22e151e9e9dsm57335135ad.83.2025.05.05.10.03.40
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 05 May 2025 10:03:43 -0700 (PDT)
From: Tomita Moeko <tomitamoeko@gmail.com>
To: Alex Williamson <alex.williamson@redhat.com>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>,
 Tomita Moeko <tomitamoeko@gmail.com>
Cc: qemu-devel@nongnu.org,
 =?UTF-8?q?Corvin=20K=C3=B6hne?= <c.koehne@beckhoff.com>
Subject: [PATCH v3 8/9] vfio/igd: Only emulate GGC register when x-igd-gms is
 set
Date: Tue,  6 May 2025 01:03:04 +0800
Message-ID: <20250505170305.23622-9-tomitamoeko@gmail.com>
X-Mailer: git-send-email 2.47.2
In-Reply-To: <20250505170305.23622-1-tomitamoeko@gmail.com>
References: <20250505170305.23622-1-tomitamoeko@gmail.com>
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

x-igd-gms is used for overriding DSM region size in GGC register in
both config space and MMIO BAR0, by default host value is used.
There is no need to emulate it in default case.

Signed-off-by: Tomita Moeko <tomitamoeko@gmail.com>
---
 hw/vfio/igd.c | 49 ++++++++++++++++++++++++++-----------------------
 1 file changed, 26 insertions(+), 23 deletions(-)

diff --git a/hw/vfio/igd.c b/hw/vfio/igd.c
index 8ad9d723e2..886d44f017 100644
--- a/hw/vfio/igd.c
+++ b/hw/vfio/igd.c
@@ -478,22 +478,24 @@ void vfio_probe_igd_bar0_quirk(VFIOPCIDevice *vdev, int nr)
         return;
     }
 
-    ggc_quirk = vfio_quirk_alloc(1);
-    ggc_mirror = ggc_quirk->data = g_malloc0(sizeof(*ggc_mirror));
-    ggc_mirror->mem = ggc_quirk->mem;
-    ggc_mirror->vdev = vdev;
-    ggc_mirror->bar = nr;
-    ggc_mirror->offset = IGD_GGC_MMIO_OFFSET;
-    ggc_mirror->config_offset = IGD_GMCH;
-
-    memory_region_init_io(ggc_mirror->mem, OBJECT(vdev),
-                          &vfio_generic_mirror_quirk, ggc_mirror,
-                          "vfio-igd-ggc-quirk", 2);
-    memory_region_add_subregion_overlap(vdev->bars[nr].region.mem,
-                                        ggc_mirror->offset, ggc_mirror->mem,
-                                        1);
+    if (vdev->igd_gms) {
+        ggc_quirk = vfio_quirk_alloc(1);
+        ggc_mirror = ggc_quirk->data = g_malloc0(sizeof(*ggc_mirror));
+        ggc_mirror->mem = ggc_quirk->mem;
+        ggc_mirror->vdev = vdev;
+        ggc_mirror->bar = nr;
+        ggc_mirror->offset = IGD_GGC_MMIO_OFFSET;
+        ggc_mirror->config_offset = IGD_GMCH;
 
-    QLIST_INSERT_HEAD(&vdev->bars[nr].quirks, ggc_quirk, next);
+        memory_region_init_io(ggc_mirror->mem, OBJECT(vdev),
+                              &vfio_generic_mirror_quirk, ggc_mirror,
+                              "vfio-igd-ggc-quirk", 2);
+        memory_region_add_subregion_overlap(vdev->bars[nr].region.mem,
+                                            ggc_mirror->offset, ggc_mirror->mem,
+                                            1);
+
+        QLIST_INSERT_HEAD(&vdev->bars[nr].quirks, ggc_quirk, next);
+    }
 
     bdsm_quirk = vfio_quirk_alloc(1);
     bdsm_mirror = bdsm_quirk->data = g_malloc0(sizeof(*bdsm_mirror));
@@ -632,9 +634,15 @@ static bool vfio_pci_igd_config_quirk(VFIOPCIDevice *vdev, Error **errp)
      * 32MiB. This option should only be used when the desired size cannot be
      * set from DVMT Pre-Allocated option in host BIOS.
      */
-    if (vdev->igd_gms &&
-        !vfio_pci_igd_override_gms(gen, vdev->igd_gms, &gmch)) {
-        return false;
+    if (vdev->igd_gms) {
+        if (!vfio_pci_igd_override_gms(gen, vdev->igd_gms, &gmch)) {
+            return false;
+        }
+
+        /* GMCH is read-only, emulated */
+        pci_set_long(vdev->pdev.config + IGD_GMCH, gmch);
+        pci_set_long(vdev->pdev.wmask + IGD_GMCH, 0);
+        pci_set_long(vdev->emulated_config_bits + IGD_GMCH, ~0);
     }
 
     gms_size = igd_stolen_memory_size(gen, gmch);
@@ -652,11 +660,6 @@ static bool vfio_pci_igd_config_quirk(VFIOPCIDevice *vdev, Error **errp)
     fw_cfg_add_file(fw_cfg_find(), "etc/igd-bdsm-size",
                     bdsm_size, sizeof(*bdsm_size));
 
-    /* GMCH is read-only, emulated */
-    pci_set_long(vdev->pdev.config + IGD_GMCH, gmch);
-    pci_set_long(vdev->pdev.wmask + IGD_GMCH, 0);
-    pci_set_long(vdev->emulated_config_bits + IGD_GMCH, ~0);
-
     /* BDSM is read-write, emulated.  The BIOS needs to be able to write it */
     if (gen < 11) {
         pci_set_long(vdev->pdev.config + IGD_BDSM, 0);
-- 
2.47.2


