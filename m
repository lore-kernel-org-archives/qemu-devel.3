Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 38530C3ABAA
	for <qemu-devel@archiver.kernel.org>; Mon,  5 May 2025 17:06:27 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uBzF3-0005gO-Vj; Mon, 05 May 2025 13:04:34 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <tomitamoeko@gmail.com>)
 id 1uBzE4-0005Iq-Aw
 for qemu-devel@nongnu.org; Mon, 05 May 2025 13:03:37 -0400
Received: from mail-pl1-x644.google.com ([2607:f8b0:4864:20::644])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <tomitamoeko@gmail.com>)
 id 1uBzE0-0003Y5-8h
 for qemu-devel@nongnu.org; Mon, 05 May 2025 13:03:30 -0400
Received: by mail-pl1-x644.google.com with SMTP id
 d9443c01a7336-225477548e1so48992515ad.0
 for <qemu-devel@nongnu.org>; Mon, 05 May 2025 10:03:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1746464606; x=1747069406; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=rn+qumXINtUzUlkl69fW++OXSdSZfpKeEY56RZfGqlQ=;
 b=MNVSap1g13OdaAF+yAf67UzXhqOxv12Q0NK46GX83Z6LoIUyNGbhAQBkQnYlPbNKdf
 OWzB/6l6JzDizpJII/TtgLxsl+rGgkTVh0btOK5MwBKLJl8QqQ1Q134VKEK9ecT6XRiU
 yvqIvL0NkilQDoZpxw0ix0/86Ds3wQoK7Zyp1zr81brekXYQOvFvrlbNdAUgTFLlpjm+
 N5/lwPGYOx6pql6xu9DLNncHRWDC01ZHp0i6ix26+MxdAlPkOyNLV03VgQWiYs1X7JAg
 50ohhk3Gm1gCB6S5527AvlbJtfy24hdrf1Dxj+x4iW9yVaGS/Jei/ogIVE65R02Cu1Jt
 +7vg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1746464606; x=1747069406;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=rn+qumXINtUzUlkl69fW++OXSdSZfpKeEY56RZfGqlQ=;
 b=KFdo2J8tHR3K6daCUiHVpKyHMpkWIKesM8mudq3a9Fc4GeFTGNo/6SZ5/mQXevgOib
 8ZoPT+cUQOCL8I7+RM8sOBJ17KvSQllClwkBw594md4k/idWNHPCYhPR0RHh+42Qvpgp
 zlXUmqyiYDHjbxHZnMRQgLGsOQF/4Eq6YGujqoLJjnvzGdVmwCkdThdZVRgLkCG7T9VI
 s8k3dY2+wlslDBFYV1UzGsljX24Zawg5vv+1HM0gEJsPjl/AG2vjmL+hB4irBFHtRQxn
 CXFvW52SUYm28i60e/hYLttx5Z8AuduLj1XBDfEL7rQG1sxc1LBVm9zyiorSieU60FVz
 SuFg==
X-Gm-Message-State: AOJu0Yx8IVzUUGHsVxyBDQj8wm7fBBAYDqx0wL19XHBWLttEiFbCNOzY
 4bvh8DOsl2nskWCmelp7NYmHw63A8ALIesCkr5qnAGgeCRa6q+g=
X-Gm-Gg: ASbGnctse114GVfYr07KNSTpn/NqwstHraFgsUXMxF5H60fW3i5VtQr5akAbE+gKvgl
 efXchEnYBa8PJk+EuR9asNtwUo/CjYet2rqIrD46pISSA8Urilj1azJ00cXGalL/oXlQOKhvJPQ
 OdtAOm9gows0n0dY6R92IUa+nWqjNbDq1/JIsc9iC5FFAzmH5TyV05gbliG5anI21221xrGsyF0
 u5jBX8Y0juBdobo3tAEgoeG4HbSiSfqmAJUZdZkntyzr1GjdJ/UIFKEXAFmTEOxaQSE31Qls3DH
 2JhiVVJGVPdl4s54G+IWvmDH9hkPAmgAJq5y4CuvfsKLUwjPjCNstf5q
X-Google-Smtp-Source: AGHT+IEh6h63tCRjjx30nNpWCAkfBYgvP4n3lLHX2R2x3nAVDraNBlGJiclM4qAb1LL0P+vpGIlsqA==
X-Received: by 2002:a17:902:ebc3:b0:22d:c605:a30c with SMTP id
 d9443c01a7336-22e1e8d326cmr119957865ad.11.1746464606243; 
 Mon, 05 May 2025 10:03:26 -0700 (PDT)
Received: from localhost.localdomain ([139.227.182.131])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-22e151e9e9dsm57335135ad.83.2025.05.05.10.03.23
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 05 May 2025 10:03:25 -0700 (PDT)
From: Tomita Moeko <tomitamoeko@gmail.com>
To: Alex Williamson <alex.williamson@redhat.com>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>,
 Tomita Moeko <tomitamoeko@gmail.com>
Cc: qemu-devel@nongnu.org,
 =?UTF-8?q?Corvin=20K=C3=B6hne?= <c.koehne@beckhoff.com>
Subject: [PATCH v3 3/9] vfio/igd: Detect IGD device by OpRegion
Date: Tue,  6 May 2025 01:02:59 +0800
Message-ID: <20250505170305.23622-4-tomitamoeko@gmail.com>
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

There is currently no straightforward way to distinguish if a Intel
graphics device is IGD or discrete GPU. However, only IGD devices have
OpRegion. Use the presence of VFIO_REGION_SUBTYPE_INTEL_IGD_OPREGION
to identify IGD devices. Still, OpRegion on hotplugged IGD device is
not supported.

Signed-off-by: Tomita Moeko <tomitamoeko@gmail.com>
---
 hw/vfio/igd.c | 30 ++++++++++++++++--------------
 1 file changed, 16 insertions(+), 14 deletions(-)

diff --git a/hw/vfio/igd.c b/hw/vfio/igd.c
index b1fce76f72..347253d08c 100644
--- a/hw/vfio/igd.c
+++ b/hw/vfio/igd.c
@@ -185,9 +185,10 @@ static bool vfio_pci_igd_opregion_init(VFIOPCIDevice *vdev,
     return true;
 }
 
-static bool vfio_pci_igd_setup_opregion(VFIOPCIDevice *vdev, Error **errp)
+static bool vfio_pci_igd_opregion_detect(VFIOPCIDevice *vdev,
+                                         struct vfio_region_info **opregion,
+                                         Error **errp)
 {
-    g_autofree struct vfio_region_info *opregion = NULL;
     int ret;
 
     /* Hotplugging is not supported for opregion access */
@@ -198,17 +199,13 @@ static bool vfio_pci_igd_setup_opregion(VFIOPCIDevice *vdev, Error **errp)
 
     ret = vfio_device_get_region_info_type(&vdev->vbasedev,
                     VFIO_REGION_TYPE_PCI_VENDOR_TYPE | PCI_VENDOR_ID_INTEL,
-                    VFIO_REGION_SUBTYPE_INTEL_IGD_OPREGION, &opregion);
+                    VFIO_REGION_SUBTYPE_INTEL_IGD_OPREGION, opregion);
     if (ret) {
         error_setg_errno(errp, -ret,
                          "Device does not supports IGD OpRegion feature");
         return false;
     }
 
-    if (!vfio_pci_igd_opregion_init(vdev, opregion, errp)) {
-        return false;
-    }
-
     return true;
 }
 
@@ -480,6 +477,7 @@ void vfio_probe_igd_bar0_quirk(VFIOPCIDevice *vdev, int nr)
 
 static bool vfio_pci_igd_config_quirk(VFIOPCIDevice *vdev, Error **errp)
 {
+    g_autofree struct vfio_region_info *opregion = NULL;
     int ret, gen;
     uint64_t gms_size;
     uint64_t *bdsm_size;
@@ -487,16 +485,17 @@ static bool vfio_pci_igd_config_quirk(VFIOPCIDevice *vdev, Error **errp)
     bool legacy_mode_enabled = false;
     Error *err = NULL;
 
-    /*
-     * This must be an Intel VGA device at address 00:02.0 for us to even
-     * consider enabling legacy mode.  The vBIOS has dependencies on the
-     * PCI bus address.
-     */
     if (!vfio_pci_is(vdev, PCI_VENDOR_ID_INTEL, PCI_ANY_ID) ||
         !vfio_is_vga(vdev)) {
         return true;
     }
 
+    /* IGD device always comes with OpRegion */
+    if (!vfio_pci_igd_opregion_detect(vdev, &opregion, errp)) {
+        return true;
+    }
+    info_report("OpRegion detected on Intel display %x.", vdev->device_id);
+
     /*
      * IGD is not a standard, they like to change their specs often.  We
      * only attempt to support back to SandBridge and we hope that newer
@@ -572,7 +571,7 @@ static bool vfio_pci_igd_config_quirk(VFIOPCIDevice *vdev, Error **errp)
 
     /* Setup OpRegion access */
     if ((vdev->features & VFIO_FEATURE_ENABLE_IGD_OPREGION) &&
-        !vfio_pci_igd_setup_opregion(vdev, errp)) {
+        !vfio_pci_igd_opregion_init(vdev, opregion, errp)) {
         goto error;
     }
 
@@ -672,8 +671,11 @@ error:
  */
 static bool vfio_pci_kvmgt_config_quirk(VFIOPCIDevice *vdev, Error **errp)
 {
+    g_autofree struct vfio_region_info *opregion = NULL;
+
     if ((vdev->features & VFIO_FEATURE_ENABLE_IGD_OPREGION) &&
-        !vfio_pci_igd_setup_opregion(vdev, errp)) {
+        (!vfio_pci_igd_opregion_detect(vdev, &opregion, errp) ||
+         !vfio_pci_igd_opregion_init(vdev, opregion, errp))) {
         return false;
     }
 
-- 
2.47.2


