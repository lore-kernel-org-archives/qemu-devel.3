Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D2A42C83F17
	for <qemu-devel@archiver.kernel.org>; Wed, 23 Jul 2025 16:09:52 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uec2B-0002GZ-8m; Wed, 23 Jul 2025 12:09:35 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <tomitamoeko@gmail.com>)
 id 1uec22-00029Y-Ll
 for qemu-devel@nongnu.org; Wed, 23 Jul 2025 12:09:27 -0400
Received: from mail-pg1-x543.google.com ([2607:f8b0:4864:20::543])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <tomitamoeko@gmail.com>)
 id 1uec21-0004Ax-3W
 for qemu-devel@nongnu.org; Wed, 23 Jul 2025 12:09:26 -0400
Received: by mail-pg1-x543.google.com with SMTP id
 41be03b00d2f7-b321bd36a41so106517a12.2
 for <qemu-devel@nongnu.org>; Wed, 23 Jul 2025 09:09:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1753286963; x=1753891763; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=WXm2Lhh0irodL+aVAw/JV0Qy+oR2s/H9XmkkNHBbafY=;
 b=OIj9N5sNrgVdJfGClPDh19sWFfxnTOOC54WTsAWKvnsPs1zbIx8tk0/+Y1f9vc4pZP
 +0RKmDBNTCQau6IHdqGZ54ovb2ogssQz8/MwieeNq+ETxuSp7F1gOjOWfF4mKSMygGH0
 lukbJIp6pC3SIAdt4/m/4MYGNS9wa871ybCeDby/yGKPLmQTFmnmkQcfpS2hoIV8BFqe
 Xwuh4gJoSQGYHuRqKjEDFPiSfWn88YkWgcZhmDt0OxNPJ9CzOrEHsOb3yQBxQs5shayp
 N5QySxVKk3L+qInHSlY/hWs1LvC6bsJmbPRE/WmIwmVN3OYSkSjKsVbfMAx8qfWAZOp1
 dzfg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1753286963; x=1753891763;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=WXm2Lhh0irodL+aVAw/JV0Qy+oR2s/H9XmkkNHBbafY=;
 b=n/TLkXKvm+JBkdiYQgFHE8iCD6T4V5rBUCcZpcXNZ7MsNC4RodX26DxRxiOkq8/FtD
 fWSn3sVGanlk6Hqv95ZnbonZw0H+InWTvk4fFVyG5kHJpwC+oKNt386pGrlqgLugctXQ
 63lc7/Qf2oeaL8Dw7T+syaNdVlmmLw0Vv+hqcgzt8YcA+XTC62g2bChm/iyh3dzFO70h
 aPac0r+Szm6mhX4VkEdGV9ZqboFbv+qVhlbyDbGIiBtjHkslRD4vCr5/3yKFCQTkppYk
 Q1wsXtQ1CbTUbHHtaXvRLPlTc3wppsfZskdrxFxYioZjqfk94SU+q8F/u41ViaibFJhc
 n3FA==
X-Gm-Message-State: AOJu0Yz2jDtRaBRGGNEMB7FQjiP7EWjfvDX6k9RHg4Ym88cyBOLAR2ft
 /exGMxxjyDxSQhnVRkVh1Kj5uvG7ZHsAGKsZkp/936uTUS86vk2MwsUhTqHBAW0UCg==
X-Gm-Gg: ASbGnctHwmDdVA9mGgzAyMcDn3u53IDSwuP73qQ1koHEmj/mTxEAbT3/gjEMNW7LD/V
 tWI9mO4J9864B27hDjAdPLbPSFZUtfZB3EKmfCpaEEUQXWLexq+9UenLPZpg2zcb2b2u5+qzrny
 Nk+Xxz6lCH2USNCgd2iPSS9vncDL+VomIExMc/kFknRb3KxCxN3Jsme9WyXLIrrwXDbHnMzp3kN
 QwAbXdGxSGzvwX4zBEjW61Dr6OWaz1+bH2fHdUzWheyXRNs3yrOAdDb6Ygo4wmSjWKT/QunGzio
 PMVgCev1uu/Htc763W2pSXs9VTVlqgaW3SONi1AspOveLi6Plv60bErLO5yDXaP1RDhtnEIYlep
 KIGh+daXfA5OMsxwSBnuBG8JJowaKaeTSQb0=
X-Google-Smtp-Source: AGHT+IFkj18Jydq8s09MP7X1mJ3ft1iOFLNLcHKEp9bYQGgVxY8DEo34qX5AWfC+lU0kzWg71lLKOA==
X-Received: by 2002:a17:90b:5844:b0:311:9c9a:58ca with SMTP id
 98e67ed59e1d1-31e507b3c87mr5333579a91.8.1753286963517; 
 Wed, 23 Jul 2025 09:09:23 -0700 (PDT)
Received: from localhost.localdomain ([139.227.17.46])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-31e519f61eesm1968353a91.14.2025.07.23.09.09.20
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 23 Jul 2025 09:09:23 -0700 (PDT)
From: Tomita Moeko <tomitamoeko@gmail.com>
To: Alex Williamson <alex.williamson@redhat.com>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>,
 Tomita Moeko <tomitamoeko@gmail.com>
Cc: qemu-devel@nongnu.org
Subject: [PATCH 2/2] vfio/igd: Fix VGA regions are not exposed in legacy mode
Date: Thu, 24 Jul 2025 00:09:06 +0800
Message-ID: <20250723160906.44941-3-tomitamoeko@gmail.com>
X-Mailer: git-send-email 2.47.2
In-Reply-To: <20250723160906.44941-1-tomitamoeko@gmail.com>
References: <20250723160906.44941-1-tomitamoeko@gmail.com>
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

In commit a59d06305fff ("vfio/pci: Introduce x-pci-class-code option"),
pci_register_vga() has been moved ouside of vfio_populate_vga(). As a
result, IGD VGA ranges are no longer properly exposed to guest.

To fix this, call pci_register_vga() after vfio_populate_vga() legacy
mode. A wrapper function vfio_pci_config_register_vga() is introduced
to handle it.

Fixes: a59d06305fff ("vfio/pci: Introduce x-pci-class-code option")
Signed-off-by: Tomita Moeko <tomitamoeko@gmail.com>
---
 hw/vfio/igd.c | 10 +++++++---
 hw/vfio/pci.c | 13 ++++++++++---
 hw/vfio/pci.h |  1 +
 3 files changed, 18 insertions(+), 6 deletions(-)

diff --git a/hw/vfio/igd.c b/hw/vfio/igd.c
index 5b1ad1a804..ee0767b0b8 100644
--- a/hw/vfio/igd.c
+++ b/hw/vfio/igd.c
@@ -574,9 +574,13 @@ static bool vfio_pci_igd_config_quirk(VFIOPCIDevice *vdev, Error **errp)
          * If VGA is not already enabled, try to enable it. We shouldn't be
          * using legacy mode without VGA.
          */
-        if (!vdev->vga && !vfio_populate_vga(vdev, &err)) {
-            error_setg(&err, "Unable to enable VGA access");
-            goto error;
+        if (!vdev->vga) {
+            if (vfio_populate_vga(vdev, &err)) {
+                vfio_pci_config_register_vga(vdev);
+            } else {
+                error_setg(&err, "Unable to enable VGA access");
+                goto error;
+            }
         }
 
         /* Enable OpRegion and LPC bridge quirk */
diff --git a/hw/vfio/pci.c b/hw/vfio/pci.c
index 15136f94f8..d5ea4a5a83 100644
--- a/hw/vfio/pci.c
+++ b/hw/vfio/pci.c
@@ -3172,6 +3172,15 @@ static void vfio_unregister_req_notifier(VFIOPCIDevice *vdev)
     vdev->req_enabled = false;
 }
 
+void vfio_pci_config_register_vga(VFIOPCIDevice *vdev)
+{
+    assert(vdev->vga != NULL);
+
+    pci_register_vga(&vdev->pdev, &vdev->vga->region[QEMU_PCI_VGA_MEM].mem,
+                     &vdev->vga->region[QEMU_PCI_VGA_IO_LO].mem,
+                     &vdev->vga->region[QEMU_PCI_VGA_IO_HI].mem);
+}
+
 bool vfio_pci_config_setup(VFIOPCIDevice *vdev, Error **errp)
 {
     PCIDevice *pdev = &vdev->pdev;
@@ -3293,9 +3302,7 @@ bool vfio_pci_config_setup(VFIOPCIDevice *vdev, Error **errp)
     vfio_bars_register(vdev);
 
     if (vdev->vga && vfio_is_vga(vdev)) {
-        pci_register_vga(&vdev->pdev, &vdev->vga->region[QEMU_PCI_VGA_MEM].mem,
-                         &vdev->vga->region[QEMU_PCI_VGA_IO_LO].mem,
-                         &vdev->vga->region[QEMU_PCI_VGA_IO_HI].mem);
+        vfio_pci_config_register_vga(vdev);
     }
 
     return true;
diff --git a/hw/vfio/pci.h b/hw/vfio/pci.h
index 44cae5afd6..810a842f4a 100644
--- a/hw/vfio/pci.h
+++ b/hw/vfio/pci.h
@@ -255,6 +255,7 @@ extern const VMStateDescription vfio_display_vmstate;
 
 void vfio_pci_bars_exit(VFIOPCIDevice *vdev);
 bool vfio_pci_add_capabilities(VFIOPCIDevice *vdev, Error **errp);
+void vfio_pci_config_register_vga(VFIOPCIDevice *vdev);
 bool vfio_pci_config_setup(VFIOPCIDevice *vdev, Error **errp);
 bool vfio_pci_interrupt_setup(VFIOPCIDevice *vdev, Error **errp);
 void vfio_pci_intx_eoi(VFIODevice *vbasedev);
-- 
2.47.2


