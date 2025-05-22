Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5C3CBC54E90
	for <qemu-devel@archiver.kernel.org>; Thu, 22 May 2025 15:17:38 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uI7fH-0004PC-W7; Thu, 22 May 2025 11:17:00 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <tomitamoeko@gmail.com>)
 id 1uI7fF-0004Os-9y
 for qemu-devel@nongnu.org; Thu, 22 May 2025 11:16:57 -0400
Received: from mail-pf1-x442.google.com ([2607:f8b0:4864:20::442])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <tomitamoeko@gmail.com>)
 id 1uI7fC-0007bR-3d
 for qemu-devel@nongnu.org; Thu, 22 May 2025 11:16:56 -0400
Received: by mail-pf1-x442.google.com with SMTP id
 d2e1a72fcca58-742c2ed0fe1so5304637b3a.1
 for <qemu-devel@nongnu.org>; Thu, 22 May 2025 08:16:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1747927011; x=1748531811; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=A+n4qWhRiYJ8WWSS1cLt4tQidBRZMZ5H3Qcz1gp0bv8=;
 b=WWX5nmWAcouWMQiSiCMWwaPliA0byuaJK7Iv3YJ87rPwSv2yNhvh12KUgMKq/OK1jC
 02Kpt4ld4RzYMGrx02pu6dMs/rzqIDbhc/PuTAPn6EcNZwDOaxPp2XWEU1cFL4s3O3dq
 GVpmoGinwg9a3SWgq2hRbeWnkA6Xs45k3BfsQiFElxAEUwxDOfk5J1TAPre0SwswHnMX
 Qn5jPns+B0OYfLAKECyy3ErTNO66C+OawtA1Dnz8Qpr/u2b92q4kl/FwuI1oKRX86VtC
 fLqVWf/VewUbTYaEysWGoCImjI25kVXpK8Yie5T7gw+DSsZa+cTETpBwojMQOkuu8dYu
 6b1A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1747927011; x=1748531811;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=A+n4qWhRiYJ8WWSS1cLt4tQidBRZMZ5H3Qcz1gp0bv8=;
 b=ITx1mGV2Nb7Gwn792bgt5+4mJN8k8gupCQMHgUnLz+Rlt3QhoWjEv7dbRgx0nNsNs6
 A7fTIVKoDEksQMehi67UTRR8TD7xWc6st/qFk+jGjJlfwZ2XmZyd+sVKjwFWhM38KaLt
 33D930Xp41uySLwbS+mPx9vNiQBQgfHbAcHcs7rcEXL8uZyj/Jw928qqHg2s6+yFHK96
 ksASdwNihabp83j7O4II9PJv4OMkRFt5OU7fbH1vc0qcbtEt+CLm2O1lw7xhm4aLJQqm
 aXM6R8eFtnl6dVCIbtwazfp9JbKhU4BRdoc3WxvjIzQHG7/UAvj/xYFO6aI9UoTfU2xL
 WjiA==
X-Gm-Message-State: AOJu0YyV3vNxOylTdsFtbdBNET1/ntghHOnNs2z2ZPXqPILhhaj4/zhQ
 iANevvz+0EFapx5/IAAjNfp7rvl1GTTKEJe9bhBUQQAXcAk+lsl89Xs=
X-Gm-Gg: ASbGncta7iaajEDI2QRn0oogHG0aya8XD0biEPb7mmkD29brUivtrRGdLr3AP8g/std
 zcNLgWwhhKeg8ELYlbLl/283oY3wmUM9Bbz7KtSwp88GXJwYX0eMOnZEmxI8D8Rbu18r5Vpins7
 MTja8HtNLDGeo/KtoM542KqJp3I3j5tuN4ZBllbk0y3Qq2Jc8fdjnom2jhikCcx9gVd6x+gT3hF
 jcOOFkE9Esv3LFvBuWp61VWQLBFeE+ujDCriJW4XBV72VyKT0KT0BHaNF6/kxZtpsbvVhriuwSt
 M2Ie01zfU1+bynyyDCrhWNqBa1QeAf3opdY0qqdk37C3TknNsdDmzkqFafp7G0U+A52P2985aoz
 Y
X-Google-Smtp-Source: AGHT+IFherqNTuikQUrcCqxG1iNKELp8p2/bW2jkmkAQ5Pwdls97eyr3qyYmwpwlT49fHbAkW5giKg==
X-Received: by 2002:a05:6a00:3a14:b0:740:67ce:1d8b with SMTP id
 d2e1a72fcca58-742a97b7a1bmr35179019b3a.7.1747927011097; 
 Thu, 22 May 2025 08:16:51 -0700 (PDT)
Received: from localhost.localdomain ([139.227.17.250])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-742a987150bsm11729125b3a.136.2025.05.22.08.16.46
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 22 May 2025 08:16:50 -0700 (PDT)
From: Tomita Moeko <tomitamoeko@gmail.com>
To: Alex Williamson <alex.williamson@redhat.com>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>,
 Tomita Moeko <tomitamoeko@gmail.com>
Cc: qemu-devel@nongnu.org,
 =?UTF-8?q?Corvin=20K=C3=B6hne?= <c.koehne@beckhoff.com>,
 edmund.raile@proton.me, Edmund Raile <edmund.raile@protonmail.com>
Subject: [PATCH v2] vfio/igd: Fix incorrect error propagation in
 vfio_pci_igd_opregion_detect()
Date: Thu, 22 May 2025 23:16:36 +0800
Message-ID: <20250522151636.20001-1-tomitamoeko@gmail.com>
X-Mailer: git-send-email 2.47.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::442;
 envelope-from=tomitamoeko@gmail.com; helo=mail-pf1-x442.google.com
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

In vfio_pci_igd_opregion_detect(), errp will be set when the device does
not have OpRegion or is hotplugged. This errp will be propagated to
pci_qdev_realize(), which interprets it as failure, causing unexpected
termination on devices without OpRegion like SR-IOV VFs or discrete
GPUs. Fix it by not setting errp in vfio_pci_igd_opregion_detect().

This patch also checks if the device has OpRegion before hotplug status
to prevent unwanted warning messages on non-IGD devices.

Fixes: c0273e77f2d7 ("vfio/igd: Detect IGD device by OpRegion")
Resolves: https://gitlab.com/qemu-project/qemu/-/issues/2968
Reported-by: Edmund Raile <edmund.raile@protonmail.com>
Link: https://lore.kernel.org/qemu-devel/30044d14-17ec-46e3-b9c3-63d27a5bde27@gmail.com
Tested-by: Edmund Raile <edmund.raile@protonmail.com>
Signed-off-by: Tomita Moeko <tomitamoeko@gmail.com>
---
v2:
* Add Tested-by from Edmund Raile. Thanks for the contribution.
* Rebased on vfio-next
* Fix typos.

 hw/vfio/igd.c | 22 ++++++++++------------
 1 file changed, 10 insertions(+), 12 deletions(-)

diff --git a/hw/vfio/igd.c b/hw/vfio/igd.c
index 5b6341c5bf..e7a9d1ffc1 100644
--- a/hw/vfio/igd.c
+++ b/hw/vfio/igd.c
@@ -187,23 +187,21 @@ static bool vfio_pci_igd_opregion_init(VFIOPCIDevice *vdev,
 }
 
 static bool vfio_pci_igd_opregion_detect(VFIOPCIDevice *vdev,
-                                         struct vfio_region_info **opregion,
-                                         Error **errp)
+                                         struct vfio_region_info **opregion)
 {
     int ret;
 
-    /* Hotplugging is not supported for opregion access */
-    if (vdev->pdev.qdev.hotplugged) {
-        error_setg(errp, "IGD OpRegion is not supported on hotplugged device");
-        return false;
-    }
-
     ret = vfio_device_get_region_info_type(&vdev->vbasedev,
                     VFIO_REGION_TYPE_PCI_VENDOR_TYPE | PCI_VENDOR_ID_INTEL,
                     VFIO_REGION_SUBTYPE_INTEL_IGD_OPREGION, opregion);
     if (ret) {
-        error_setg_errno(errp, -ret,
-                         "Device does not support IGD OpRegion feature");
+        return false;
+    }
+
+    /* Hotplugging is not supported for opregion access */
+    if (vdev->pdev.qdev.hotplugged) {
+        warn_report("IGD device detected, but OpRegion is not supported "
+                    "on hotplugged device.");
         return false;
     }
 
@@ -524,7 +522,7 @@ static bool vfio_pci_igd_config_quirk(VFIOPCIDevice *vdev, Error **errp)
     }
 
     /* IGD device always comes with OpRegion */
-    if (!vfio_pci_igd_opregion_detect(vdev, &opregion, errp)) {
+    if (!vfio_pci_igd_opregion_detect(vdev, &opregion)) {
         return true;
     }
     info_report("OpRegion detected on Intel display %x.", vdev->device_id);
@@ -695,7 +693,7 @@ static bool vfio_pci_kvmgt_config_quirk(VFIOPCIDevice *vdev, Error **errp)
         return true;
     }
 
-    if (!vfio_pci_igd_opregion_detect(vdev, &opregion, errp)) {
+    if (!vfio_pci_igd_opregion_detect(vdev, &opregion)) {
         /* Should never reach here, KVMGT always emulates OpRegion */
         return false;
     }
-- 
2.47.2


