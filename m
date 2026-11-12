Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6C43A606A31C
	for <qemu-devel@archiver.kernel.org>; Thu, 12 Nov 2026 13:01:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=Ht698EPt
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xRUQO-00083Z-Tb; Thu, 12 Nov 2026 08:01:14 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <aleszlucero@gmail.com>)
 id 1xRTiO-0007aS-K0
 for qemu-devel@nongnu.org; Thu, 12 Nov 2026 07:15:40 -0500
Received: from mail-ua1-x932.google.com ([2607:f8b0:4864:20::932])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <aleszlucero@gmail.com>)
 id 1xRTiM-0002QV-Hn
 for qemu-devel@nongnu.org; Thu, 12 Nov 2026 07:15:40 -0500
Received: by mail-ua1-x932.google.com with SMTP id
 a1e0cc1a2514c-99be509f943so954801241.0
 for <qemu-devel@nongnu.org>; Thu, 12 Nov 2026 04:15:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20260707; t=1794485728; x=1795090528; darn=nongnu.org;
 h=cc:to:message-id:content-transfer-encoding:content-type
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=x4Xs76mEvIOB3Bl27AF5QONxOrGZt1cc23cTVK2ClNA=;
 b=Ht698EPtEyvpqcSNvxCrhJfmCDB8TPGJdQNRQf/eQPQdSn9wLuN2UqvEeAvOmf/xi8
 YncBXNCVNIjD9b/3icwkqvLafcs20yYhxl4Xk8gUcosoyCQeLFCGF3KLmrUHmB+fDOB1
 3ZlT8gbYGUyQKv8q7kHLOWcCogHyL5VtpU8l5J21BWQBSecQ8rHEFfE94YLdZTuZInrX
 kXGH6WK0bDOgpOVqTkLLxE/21ya3bGrcZ8Q2yO306NhxrZbDQdcke/8X0kSvNt8Lk/4p
 GXUmZDpeibLVXe/ptp6tbi05wmC8rXoD7wEwN+iqjkty1FfNYZqElscL6QtElEc4ng16
 uDZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1794485728; x=1795090528;
 h=cc:to:message-id:content-transfer-encoding:content-type
 :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=x4Xs76mEvIOB3Bl27AF5QONxOrGZt1cc23cTVK2ClNA=;
 b=f0Xcfvo2jx2qIsp1Kzk02hcxfTlEXR8jyz24wEXhGQTL4EFcYNXv1f+ABCJJP84ass
 RjMCr3uhBteKESfC89MvUSoqBYK7LZ+C+AikvpGYIrOsymbqJylGF7ZGb9+Bu9iBQhZl
 ns6k+UQfl06gxd/JKhiudumk3Lh47StwY48gs9m9OiGVCqD1DNS8rcZiXE1lPc1g+QG4
 Atf5bAZI4mde0sMnBTysd0loWZz4VNXMQ7tng/7sXRzntpdFo5hqHT0ZDdviC6Hw4gjt
 zuKCcusVu1+OHBgjOT7dRn74ndbVIqlgMoWYoSDS8Dt7jBgY1sRX9mE08bAcs0Cr4SQo
 KYnA==
X-Gm-Message-State: APuU4Z9ce0/l2zTh0S3nleyfgjTrzhGiVCDn2IRo+PDOsglg4dlHG4kY
 D5WLcBHf/JeiMXMsIPzLe3zJSqrtkCDbvXY1W+Yonulb+/EK8sbV0xJV
X-Gm-Gg: AYBFou3Xura1LXXmCQDPyp0JETKcJKnYZXV+L3mEkBtwP7ETqKSUiRUAQxXhPe/g3OD
 HTbn6f9yMdpcLgBIU5+mAowzrP4FRi9PE50xxCJ8UtLy9WY3n28ad4GNVi+fKw9Z5xzlFuWf+Zt
 tyV9UlMv3GxXRvD3GAJhOKQ96Pa5TH0HpMgenYcl8X4Rb9z+4GGUmj+WMM1xnUlfD1AnsiLVv3y
 ZaZVd4xQDLQ17lxyB5LdWUjAffFoTbZEiiIww07ZObqlKfrw/QwZCMCjFfAdjLzIJeTmlJSbMdh
 Xmz5v7yeq/EwFmsqafoFuZy84xSwyIwY3pF1Yxr0p2OKRga42gJchzfhAI7MRWdkkZlcwr6sqMU
 YWSfy2pA3J9O1qNxcPQM2Ri/FrFbwuKBb198gXmkbz0FrOROqSd1Wsu1zZOedPfncNTz+Oof1/r
 9/xmPYWmfe1EetpYVAJoqdrFGCiXT1nuhgLS5SMxKiWR3LhK3x6TFGPmbCSJS6kLGOzG4enZMdN
 g4L+tzbzJnYzdwpTbjn52uLCh42fFIQ4CGM9j89zfAz3Ij/SPbP+2h36hiP8bawvz5i1QzIT3Pg
 x0XjHWfuA040TUrfKg==
X-Received: by 2002:a05:6102:5708:b0:7ce:8505:9848 with SMTP id
 ada2fe7eead31-7d50618e5c0mr2295389137.31.1794485728428; 
 Thu, 12 Nov 2026 04:15:28 -0800 (PST)
Received: from [192.168.0.8] ([2a09:bac1:6b40:8::11:223])
 by smtp.gmail.com with ESMTPSA id
 ada2fe7eead31-7d302331dc7sm5382417137.4.2026.11.12.04.15.27
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 12 Nov 2026 04:15:27 -0800 (PST)
From: =?utf-8?q?Oscar_Alejandro_S=C3=A1nchez_Lucero?= <aleszlucero@gmail.com>
Date: Thu, 12 Nov 2026 06:14:55 -0600
Subject: [PATCH] hw/pci-bridge: Convert pci-bridge to Resettable interface
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20261112-pci-bridge-resettable-v1-1-ed36c7b26fbe@gmail.com>
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/x2MQQqAMAzAviI9W1iHOvEr4mHOqgVR6YYI4t8dH
 kNIHoiswhG64gHlS6IcewYqCwir3xdGmTKDNbYhIotnEBxVpmyUI6fkx43RmLZ1zru6cgS5PZV
 nuf9vP7zvB6m2Ng1nAAAA
X-Change-ID: 20261112-pci-bridge-resettable-008877a75471
To: qemu-devel@nongnu.org
Cc: =?utf-8?q?Oscar_Alejandro_S=C3=A1nchez_Lucero?= <aleszlucero@gmail.com>, 
 "Michael S. Tsirkin" <mst@redhat.com>, 
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1794485727; l=3512;
 i=aleszlucero@gmail.com; s=20261104; h=from:subject:message-id;
 bh=txgiMrkkkHMBeFbw6+ZzStevrj0emU9g82K/LaSFSOU=;
 b=Y1dSPsjYPLZBw2K5LrJuCOrZThvtosf5AGtVVVKH/Bw1m0s3Hur4dxoPQ3kEC5VPFVevWb1tn
 EZQubhWsANXCilplPU3qLnxUlWy29fDWMqp4cIMtxJlf4b+wYdXQnbj
X-Developer-Key: i=aleszlucero@gmail.com; a=ed25519;
 pk=zRzEBMID7l1FXqr2CjfnlIn++3m3N05FuNYb5zPA3cw=
Received-SPF: pass client-ip=2607:f8b0:4864:20::932;
 envelope-from=aleszlucero@gmail.com; helo=mail-ua1-x932.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-Mailman-Approved-At: Thu, 12 Nov 2026 08:00:18 -0500
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

Replace the deprecated device_class_set_legacy_reset() in pci_bridge_dev.c
with the three-phase ResettableClass interface, chaining the hold phase
to the parent class.

Signed-off-by: Oscar Alejandro Sánchez Lucero <aleszlucero@gmail.com>
---
To: qemu-devel@nongnu.org
To: Michael S. Tsirkin <mst@redhat.com>
Cc: Marcel Apfelbaum <marcel.apfelbaum@gmail.com>
---
 hw/pci-bridge/pci_bridge_dev.c | 25 ++++++++++++++++++++-----
 1 file changed, 20 insertions(+), 5 deletions(-)

diff --git a/hw/pci-bridge/pci_bridge_dev.c b/hw/pci-bridge/pci_bridge_dev.c
index bc53bcb..4e08852 100644
--- a/hw/pci-bridge/pci_bridge_dev.c
+++ b/hw/pci-bridge/pci_bridge_dev.c
@@ -31,11 +31,18 @@
 #include "system/memory.h"
 #include "hw/pci/pci_bus.h"
 #include "hw/core/hotplug.h"
+#include "hw/core/resettable.h"
 #include "qom/object.h"
 
 #define TYPE_PCI_BRIDGE_DEV      "pci-bridge"
 #define TYPE_PCI_BRIDGE_SEAT_DEV "pci-bridge-seat"
-OBJECT_DECLARE_SIMPLE_TYPE(PCIBridgeDev, PCI_BRIDGE_DEV)
+OBJECT_DECLARE_TYPE(PCIBridgeDev, PCIBridgeDevClass, PCI_BRIDGE_DEV)
+
+struct PCIBridgeDevClass {
+    PCIDeviceClass parent_class;
+
+    ResettablePhases parent_phases;
+};
 
 struct PCIBridgeDev {
     /*< private >*/
@@ -158,11 +165,15 @@ static void pci_bridge_dev_write_config(PCIDevice *d,
     }
 }
 
-static void qdev_pci_bridge_dev_reset(DeviceState *qdev)
+static void pci_bridge_dev_reset_hold(Object *obj, ResetType type)
 {
-    PCIDevice *dev = PCI_DEVICE(qdev);
+    PCIDevice *dev = PCI_DEVICE(obj);
+    PCIBridgeDevClass *bdc = PCI_BRIDGE_DEV_GET_CLASS(obj);
 
-    pci_bridge_reset(qdev);
+    if (bdc->parent_phases.hold) {
+        bdc->parent_phases.hold(obj, type);
+    }
+    pci_bridge_reset(DEVICE(obj));
     if (shpc_present(dev)) {
         shpc_reset(dev);
     }
@@ -245,6 +256,8 @@ static void pci_bridge_dev_class_init(ObjectClass *klass, const void *data)
     DeviceClass *dc = DEVICE_CLASS(klass);
     PCIDeviceClass *k = PCI_DEVICE_CLASS(klass);
     HotplugHandlerClass *hc = HOTPLUG_HANDLER_CLASS(klass);
+    ResettableClass *rc = RESETTABLE_CLASS(klass);
+    PCIBridgeDevClass *bdc = PCI_BRIDGE_DEV_CLASS(klass);
 
     k->realize = pci_bridge_dev_realize;
     k->exit = pci_bridge_dev_exitfn;
@@ -253,7 +266,8 @@ static void pci_bridge_dev_class_init(ObjectClass *klass, const void *data)
     k->device_id = PCI_DEVICE_ID_REDHAT_BRIDGE;
     k->class_id = PCI_CLASS_BRIDGE_PCI;
     dc->desc = "Standard PCI Bridge";
-    device_class_set_legacy_reset(dc, qdev_pci_bridge_dev_reset);
+    resettable_class_set_parent_phases(rc, NULL, pci_bridge_dev_reset_hold,
+                                       NULL, &bdc->parent_phases);
     device_class_set_props(dc, pci_bridge_dev_properties);
     dc->vmsd = &pci_bridge_dev_vmstate;
     set_bit(DEVICE_CATEGORY_BRIDGE, dc->categories);
@@ -266,6 +280,7 @@ static const TypeInfo pci_bridge_dev_info = {
     .name              = TYPE_PCI_BRIDGE_DEV,
     .parent            = TYPE_PCI_BRIDGE,
     .instance_size     = sizeof(PCIBridgeDev),
+    .class_size        = sizeof(PCIBridgeDevClass),
     .class_init        = pci_bridge_dev_class_init,
     .instance_finalize = pci_bridge_dev_instance_finalize,
     .interfaces = (const InterfaceInfo[]) {

---
base-commit: 29760efaf96bbe5928f8111881eddbf5ac06439e
change-id: 20261112-pci-bridge-resettable-008877a75471

Best regards,
-- 
Oscar Alejandro Sánchez Lucero <aleszlucero@gmail.com>


