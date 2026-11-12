Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0570F606A8A8
	for <qemu-devel@archiver.kernel.org>; Thu, 12 Nov 2026 22:54:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=eebVvqlC
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xRdgM-0006U6-J3; Thu, 12 Nov 2026 17:54:14 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <aleszlucero@gmail.com>)
 id 1xRdgK-0006Ti-Fq
 for qemu-devel@nongnu.org; Thu, 12 Nov 2026 17:54:12 -0500
Received: from mail-vk1-xa34.google.com ([2607:f8b0:4864:20::a34])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <aleszlucero@gmail.com>)
 id 1xRdgI-0007eN-Iq
 for qemu-devel@nongnu.org; Thu, 12 Nov 2026 17:54:12 -0500
Received: by mail-vk1-xa34.google.com with SMTP id
 71dfb90a1353d-5edf97136aaso440856e0c.2
 for <qemu-devel@nongnu.org>; Thu, 12 Nov 2026 14:54:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20260707; t=1794524049; x=1795128849; darn=nongnu.org;
 h=cc:to:message-id:content-transfer-encoding:content-type
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=diw2syloOGFeAB8ZbmbFjMcv5z/SS6pOmThvm+dbyjE=;
 b=eebVvqlCGtZPI0+jYPtBvp1i0ggzZVR9e7vLQWL7QEMXvfMh5dm8ay4YypgdcCnLgS
 rtSCoF+hf0zNwgL2ss9vC3J9fe9ng+pcJaZc3YTpYfEM+6M54O14GmBi9DjcJilBFQii
 z3ugpICjLb/kvNdXFIJtnCObTGRD2LuQZKucwTUSFTVSV0rtiyFPJIsVc25ud3u/VP6N
 /lfGNDq0aaIpl/Vyobltkv7PraiMr2GIOdYXD24iXqt1WzyuZPjyWomq7o+kxSDl9ZlU
 gwshUYl2AVXMV5X5Q5JIncwGcDOVJx5lWnw2EQzSwKUR1Q6JkH8GutPMinQ3Xhhy1KZA
 oDtw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1794524049; x=1795128849;
 h=cc:to:message-id:content-transfer-encoding:content-type
 :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=diw2syloOGFeAB8ZbmbFjMcv5z/SS6pOmThvm+dbyjE=;
 b=FYZUB6pTHbFGXr+qSAogB6JKPUvdLyF/z+B8yeZukuZe/zv/hjMmkzIL1E8A/Tau/U
 an+i9ahl+Zflc08y3zNZka1uTOM09AgfBJrWlyrl4xZ8osTVnHpDGqjzM9gYj/LDH3+1
 ErmiFibkLZIh69FF3fGZgNuKc24GZ6Qo/NzDvXt367y1D3AETZYzfhJjHv7EInhwd4ar
 cZ8rS4ILQ4L95dpqvGJYD5f6Gjf0fF+OmjhKAmUNKmE4wbJfMpVruizP0NzOiyM6ziwT
 GpJcC2zQjG1KchF3FUMYLZCLUc83dPlbnqd0929GazSwk//f8T/VO4+G9/anrBmDcdLW
 H02w==
X-Gm-Message-State: APuU4Z9mOM8EVyJ/cTgfl9Rp6h1m6t0WIXvMrVFmC4/MolT9wjWqaBUk
 Fu9neNyoeNCZ/+X93H+XlX7TJlNLhp7TSbhBnZJTJz2hJdmxx0P3fR+1
X-Gm-Gg: AYBFou2CwLdhTe8nuAcguBtKgvKIz2kQngwIeRhPb/NbWRJtcWdhaw5I8z2ZO7vGnnm
 BwccEm12IvLCyMOtmTcdO21BgQFVLauGf5sS2nvq2hNd82HBLe3qhVuJSocO67yzOnzIIFiNet3
 bFvoWUG3dQRuy7rPTUuT20FdqVLhuAuqAYGVs6EDZUIn63/vb8elk1ISK6jDufiLW0BH0ovToIa
 VuXdyWFO5rydaN3FqpCoHr0/OxLVjmmCXaAQLZuCyNXUJsKpLHNhTfFwP4nXmaODBdCUt9/3izz
 bR8Vgd5YXVosCXH/F0O/my6Q9mLcPvNq6ZjgHHcpBok3UfMC7FZGfAoOk10LoupAs05v5G+YQfd
 lMlWzoxugDv7qZYtZ94yJE60Y1pNkDOwS309O0l3Y9O6Oq0mnFSocea5yz403JoChb2y+j730QZ
 BX6bSQGiY2IgQIUpQRTGRGi3SFDofphl1krKyMwrzZ72RwhqMCyMMf/++/ozsjIRG2u2hEDDj6P
 kekjX0rHbBbOq9OrCxu6eT1oX/TU9vXEUFpUsBVz5EQUQnmJDkQZSydGdjqC4lVArkLYtcB3CdU
 gWgPRUk5EE/LYuqYkcEM
X-Received: by 2002:a05:6122:2897:b0:5ec:3e18:a188 with SMTP id
 71dfb90a1353d-5ee3466f8d1mr266040e0c.1.1794524049277; 
 Thu, 12 Nov 2026 14:54:09 -0800 (PST)
Received: from [192.168.0.8] ([2a09:bac5:565f:323c::501:e])
 by smtp.gmail.com with ESMTPSA id
 71dfb90a1353d-5ee34e3255fsm298922e0c.4.2026.11.12.14.54.07
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 12 Nov 2026 14:54:07 -0800 (PST)
From: =?utf-8?q?Oscar_Alejandro_S=C3=A1nchez_Lucero?= <aleszlucero@gmail.com>
Date: Thu, 12 Nov 2026 16:54:02 -0600
Subject: [PATCH v2] hw/pci-bridge: Convert pci-bridge to Resettable interface
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20261112-pci-bridge-resettable-v2-1-a555b78a2262@gmail.com>
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/4WNQQ6DIBBFr2JmXRqGtmC68h6NC8BRJ1ExYEwbw
 91LvUCX7//89w9IFJkSPKsDIu2cOCwF1KUCP9plIMFdYVBSaURUYvUsXOSuNJESbZt1Ewkp69o
 Yax53g1C2a6Se36f31RYeOW0hfs6bHX/pP+OOAgV1N+2NU7p31Ayz5enqwwxtzvkLZ3HB6LoAA
 AA=
X-Change-ID: 20261112-pci-bridge-resettable-008877a75471
To: qemu-devel@nongnu.org
Cc: =?utf-8?q?Oscar_Alejandro_S=C3=A1nchez_Lucero?= <aleszlucero@gmail.com>, 
 "Michael S. Tsirkin" <mst@redhat.com>, 
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>, 
 Peter Maydell <peter.maydell@linaro.org>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1794524047; l=2580;
 i=aleszlucero@gmail.com; s=20261104; h=from:subject:message-id;
 bh=j6ZW6tTnLtPGW0B89vxeq9Ggo+kWL5UEtqSZZuOfFcA=;
 b=jXvXQlCwGnBBFpfzkw43LjOPNBdR7XoYNX6OEDowBLwT0PpqtbujPQ++4WPWwj7BLl1S5/Pcs
 kciwzJoZvSGDDQTWLeoXxPxusK0glAmCxdbFXWomRvyJ+x2MgjDIuSb
X-Developer-Key: i=aleszlucero@gmail.com; a=ed25519;
 pk=zRzEBMID7l1FXqr2CjfnlIn++3m3N05FuNYb5zPA3cw=
Received-SPF: pass client-ip=2607:f8b0:4864:20::a34;
 envelope-from=aleszlucero@gmail.com; helo=mail-vk1-xa34.google.com
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

Replace the deprecated device_class_set_legacy_reset() with the
ResettableClass hold phase.

Signed-off-by: Oscar Alejandro Sánchez Lucero <aleszlucero@gmail.com>
---
To: qemu-devel@nongnu.org
To: Michael S. Tsirkin <mst@redhat.com>
Cc: Marcel Apfelbaum <marcel.apfelbaum@gmail.com>
Cc: Peter Maydell <peter.maydell@linaro.org>
---
Changes in v2:
- Set rc->phases.hold directly without parent_phases chaining.
- Link to v1: https://lore.kernel.org/qemu-devel/20261112-pci-bridge-resettable-v1-1-ed36c7b26fbe@gmail.com
---
 hw/pci-bridge/pci_bridge_dev.c | 10 ++++++----
 1 file changed, 6 insertions(+), 4 deletions(-)

diff --git a/hw/pci-bridge/pci_bridge_dev.c b/hw/pci-bridge/pci_bridge_dev.c
index bc53bcb..783a545 100644
--- a/hw/pci-bridge/pci_bridge_dev.c
+++ b/hw/pci-bridge/pci_bridge_dev.c
@@ -31,6 +31,7 @@
 #include "system/memory.h"
 #include "hw/pci/pci_bus.h"
 #include "hw/core/hotplug.h"
+#include "hw/core/resettable.h"
 #include "qom/object.h"
 
 #define TYPE_PCI_BRIDGE_DEV      "pci-bridge"
@@ -158,11 +159,11 @@ static void pci_bridge_dev_write_config(PCIDevice *d,
     }
 }
 
-static void qdev_pci_bridge_dev_reset(DeviceState *qdev)
+static void pci_bridge_dev_reset_hold(Object *obj, ResetType type)
 {
-    PCIDevice *dev = PCI_DEVICE(qdev);
+    PCIDevice *dev = PCI_DEVICE(obj);
 
-    pci_bridge_reset(qdev);
+    pci_bridge_reset(DEVICE(obj));
     if (shpc_present(dev)) {
         shpc_reset(dev);
     }
@@ -245,6 +246,7 @@ static void pci_bridge_dev_class_init(ObjectClass *klass, const void *data)
     DeviceClass *dc = DEVICE_CLASS(klass);
     PCIDeviceClass *k = PCI_DEVICE_CLASS(klass);
     HotplugHandlerClass *hc = HOTPLUG_HANDLER_CLASS(klass);
+    ResettableClass *rc = RESETTABLE_CLASS(klass);
 
     k->realize = pci_bridge_dev_realize;
     k->exit = pci_bridge_dev_exitfn;
@@ -253,7 +255,7 @@ static void pci_bridge_dev_class_init(ObjectClass *klass, const void *data)
     k->device_id = PCI_DEVICE_ID_REDHAT_BRIDGE;
     k->class_id = PCI_CLASS_BRIDGE_PCI;
     dc->desc = "Standard PCI Bridge";
-    device_class_set_legacy_reset(dc, qdev_pci_bridge_dev_reset);
+    rc->phases.hold = pci_bridge_dev_reset_hold;
     device_class_set_props(dc, pci_bridge_dev_properties);
     dc->vmsd = &pci_bridge_dev_vmstate;
     set_bit(DEVICE_CATEGORY_BRIDGE, dc->categories);

---
base-commit: 29760efaf96bbe5928f8111881eddbf5ac06439e
change-id: 20261112-pci-bridge-resettable-008877a75471

Best regards,
-- 
Oscar Alejandro Sánchez Lucero <aleszlucero@gmail.com>


