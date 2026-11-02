Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BC611606A324
	for <qemu-devel@archiver.kernel.org>; Mon,  2 Nov 2026 13:36:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256 header.s=google header.b=h1bGPVxa
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xNsCZ-000304-T7; Mon, 02 Nov 2026 08:35:55 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1xNsCZ-0002zf-4Y
 for qemu-devel@nongnu.org; Mon, 02 Nov 2026 08:35:55 -0500
Received: from mail-wr1-x42e.google.com ([2a00:1450:4864:20::42e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1xNsCW-0002DM-Sl
 for qemu-devel@nongnu.org; Mon, 02 Nov 2026 08:35:54 -0500
Received: by mail-wr1-x42e.google.com with SMTP id
 ffacd0b85a97d-48b001cd92bso1637138f8f.2
 for <qemu-devel@nongnu.org>; Mon, 02 Nov 2026 05:35:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1793626551; x=1794231351; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=yQ+2GB3UOTI75peeRfyLCyAxcVqzqbmShg2g3uozfaI=;
 b=h1bGPVxaJmwsKkGKBUiSUNpn5ODUSkuQV9QznpnYWTnDDzsOnDVMnwXXYq0eRdOWyl
 q55Br2GIXRctUW7RobWwOvKYzRde8HTMrhPFnphbcdRw9dY0Pu3FaedS9X4EOCM36j7j
 Lpz+JoKFrZMe1YvpQo5pnmtGORdxvGp6W7tUm1Nnfc2a+jTmBGCpxU0TltRA+UPET+6I
 WtwxORwC3Lg7gZu70NAWHXVhJBwz5DfUn49foufnmLQ/OBlrLSvIr9pb6v3+jaJHiMEX
 m4BvcUYUggaw6WPQBozKz+A7Oln0cZSXafT2UzJ1+vx9N8S7StBpDtkSWfvx5j4L7wO/
 gTBQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793626551; x=1794231351;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=yQ+2GB3UOTI75peeRfyLCyAxcVqzqbmShg2g3uozfaI=;
 b=eRS7sNRa4C0PkYu+SN418KeoHdkTbVhZWRbyIwZF/Vb8N0vMYkbXwLuxDkjVPJ/+Qi
 JL+hCDDJ6oWH7z0tjm78YOdF99TnWhTNWC0pvDBvemvcnoqeKxrtPPbmEf7fAI14U/VZ
 7qxfY/tTKNDQxai8AVsKke4CmVcpNN5LhhwskAJPKkUN/TNyL+ykcX1J9U+U1mvgxpoa
 Nu3Z3QjyLQwETRTRYbCdeO2xkXFvTBE0VFxFWuZ0MM2w0tSr49HMXm6qrRXOxFPkc7mi
 huU/76kbtAGtDN/ByB3DXx/S9BQ21E8j7CtQR+2NjNPwuRyiUfHu9ZqpuZ/U+PINf/8j
 F3Jg==
X-Gm-Message-State: APuU4Z9fIdw92k14mdKIuZHQmjowPRG+DJRuXrRg8a7romPGErWdidNE
 RoOiguO4hzRhdgalwFMmClfNLA0B4qAaAK/Y6FXKntLjVvC3Ct2xtxwCiy6KWSSK7ACpbqtepNb
 Hyf6W1zw=
X-Gm-Gg: AYBFou3NesSWeBMurdymkQ5AziracPSM6j6YHjMfMiLSk3kw7K/VjaV0og+LilDYHDi
 h1bLayPUXn+qbPTcUeRFoqIFysWgJeU+KPh5nDTqmt2qkV11JzDQ8XDr1ZbNlSdAJkvnV7zadf2
 ZrJAljPyoZSpZ6DCP6hy/aCnuVmbe3f2k7Tpe7HTYE77Qlc87ITz/S0n1htKLwvvOITlAKa98Je
 y8RpQIDOjZ8RmbKgQGpLBSU1lbiyqZ5ZuXYWav6W3PMISf8zK2hwUxK1y4l2/TeYyTRpro+st3T
 kigfzcQYT34FNAYFdzO10qaGsiasOjqHGgGDbhgl/o3Ab3404Sh9Qsabwd/fIsIpvNXmvINnJfd
 LHOl3HooAJ4qqPXxFnXn8OQVR1vYQtbB08B1vnB2hKaS5w3fiW3aQ4smKgp4GkQI1tbyZxil4uj
 9UlQUTRAmlGuEiEbf+zR2Hp6d3wIGJD9e9DvmwIksShhhAFGeXblxxyqzTm8IOREWmqem5cVx0l
 tOPZ02fizsNm82EcyVYeLPyuyWg34SlGcBH4Zs/2EZ4xeuZw/Y+7kueMR77WbDk65GR0RUVRBDu
 UkC+OSGXHW/dDNbcR3Z/1S2rNO9KuvMXuRvmDHx33fC6G4AE8CdGjb3s+0t8OSrZuF0WonKVhjo
 HyH+G7isZKV95zQDiFSOQjVdGpRwdjrUr+Q==
X-Received: by 2002:a05:6000:25f0:b0:48e:f10:ce6e with SMTP id
 ffacd0b85a97d-48e6e2e7602mr20832216f8f.13.1793626551171; 
 Mon, 02 Nov 2026 05:35:51 -0800 (PST)
Received: from lanath.. (wildly.archaic.org.uk. [81.2.115.145])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-48e71a4d3e9sm22556760f8f.6.2026.11.02.05.35.49
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 02 Nov 2026 05:35:50 -0800 (PST)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 01/47] hw/arm/bcm2838_pcie: add BCM2838 PCIe Root Complex
Date: Mon,  2 Nov 2026 13:35:01 +0000
Message-ID: <20261102133547.1375701-2-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261102133547.1375701-1-peter.maydell@linaro.org>
References: <20261102133547.1375701-1-peter.maydell@linaro.org>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42e;
 envelope-from=peter.maydell@linaro.org; helo=mail-wr1-x42e.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
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
X-Spam-Status: No, score=-18.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

From: Marcelo Manzo <marcelomanzo@gmail.com>

Add the PCI-facing "root" part (D0:F0) of the BCM2838 (Raspberry Pi
4B / BCM2711) PCIe Root Complex: a PCIe root port with the vendor's
device/vendor IDs and capability offsets, not usable on its own
without the host-facing part added in the next patch.

Adapted from patch 13/41 of Sergey Kambalin's "Raspberry Pi 4B
machine" series (patchwork series 829638, posted to qemu-devel in
2024 but never merged) against current QEMU master; the surrounding
PCIe/GENET networking support for raspi4b was left unmerged upstream
(base scaffolding aside), so this and the following patches complete
and debug that series to get real networking working under
raspi4b.

Signed-off-by: Marcelo Manzo <marcelomanzo@gmail.com>
Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
Message-id: 20261027143036.44973-2-marcelomanzo@gmail.com
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 include/hw/arm/bcm2838_pcie.h |  54 ++++++++++++++++++
 hw/arm/bcm2838_pcie.c         | 101 ++++++++++++++++++++++++++++++++++
 hw/arm/meson.build            |   4 +-
 3 files changed, 158 insertions(+), 1 deletion(-)
 create mode 100644 include/hw/arm/bcm2838_pcie.h
 create mode 100644 hw/arm/bcm2838_pcie.c

diff --git a/include/hw/arm/bcm2838_pcie.h b/include/hw/arm/bcm2838_pcie.h
new file mode 100644
index 00000000000..cb95c653318
--- /dev/null
+++ b/include/hw/arm/bcm2838_pcie.h
@@ -0,0 +1,54 @@
+/*
+ * BCM2838 PCIe Root Complex emulation
+ *
+ * Copyright (C) 2022 Ovchinnikov Vitalii <vitalii.ovchinnikov@auriga.com>
+ *
+ * SPDX-License-Identifier: GPL-2.0-or-later
+ */
+
+#ifndef BCM2838_PCIE_H
+#define BCM2838_PCIE_H
+
+#include "exec/hwaddr.h"
+#include "hw/core/sysbus.h"
+#include "hw/pci/pci.h"
+#include "hw/pci/pcie_host.h"
+#include "hw/pci/pcie_port.h"
+#include "qom/object.h"
+
+#define TYPE_BCM2838_PCIE_ROOT "bcm2838-pcie-root"
+OBJECT_DECLARE_TYPE(BCM2838PcieRootState, BCM2838PcieRootClass,
+                    BCM2838_PCIE_ROOT)
+
+#define BCM2838_PCIE_VENDOR_ID      0x14E4
+#define BCM2838_PCIE_DEVICE_ID      0x2711
+#define BCM2838_PCIE_REVISION       20
+
+#define BCM2838_PCIE_REGS_SIZE      0x9310
+#define BCM2838_PCIE_NUM_IRQS       4
+
+#define BCM2838_PCIE_EXP_CAP_OFFSET 0xAC
+#define BCM2838_PCIE_AER_CAP_OFFSET 0x100
+
+#define BCM2838_PCIE_EXT_CFG_DATA   0x8000
+#define BCM2838_PCIE_EXT_CFG_INDEX  0x9000
+
+struct BCM2838PcieRootState {
+    /*< private >*/
+    PCIESlot parent_obj;
+
+    /*< public >*/
+    /* Controller registers above the 4KB config space; little-endian bytes */
+    uint8_t regs[BCM2838_PCIE_REGS_SIZE - PCIE_CONFIG_SPACE_SIZE];
+};
+
+struct BCM2838PcieRootClass {
+    /*< private >*/
+    PCIERootPortClass parent_obj;
+
+    /*< public >*/
+    void (*parent_realize)(PCIDevice *dev, Error **errp);
+};
+
+
+#endif /* BCM2838_PCIE_H */
diff --git a/hw/arm/bcm2838_pcie.c b/hw/arm/bcm2838_pcie.c
new file mode 100644
index 00000000000..edd174c3768
--- /dev/null
+++ b/hw/arm/bcm2838_pcie.c
@@ -0,0 +1,101 @@
+/*
+ * BCM2838 PCIe Root Complex emulation
+ *
+ * Copyright (C) 2022 Ovchinnikov Vitalii <vitalii.ovchinnikov@auriga.com>
+ *
+ * SPDX-License-Identifier: GPL-2.0-or-later
+ */
+
+#include "qemu/osdep.h"
+#include "qemu/log.h"
+#include "qapi/error.h"
+#include "hw/core/irq.h"
+#include "hw/pci-host/gpex.h"
+#include "hw/core/qdev-properties.h"
+#include "migration/vmstate.h"
+#include "qemu/module.h"
+#include "hw/pci/pcie.h"
+#include "hw/pci/pcie_aer.h"
+#include "hw/arm/bcm2838_pcie.h"
+#include "trace.h"
+
+/*
+ * RC root part (D0:F0)
+ */
+
+static void bcm2838_pcie_root_port_reset_hold(Object *obj, ResetType type)
+{
+    PCIERootPortClass *rpc = PCIE_ROOT_PORT_GET_CLASS(obj);
+    PCIDevice *dev = PCI_DEVICE(obj);
+    BCM2838PcieRootState *s = BCM2838_PCIE_ROOT(dev);
+
+    if (rpc->parent_phases.hold) {
+        rpc->parent_phases.hold(obj, type);
+    }
+
+    memset(s->regs, 0xFF, sizeof(s->regs));
+}
+
+static void bcm2838_pcie_root_init(Object *obj)
+{
+    PCIBridge *br = PCI_BRIDGE(obj);
+    br->bus_name = "pcie.1";
+}
+
+static const VMStateDescription vmstate_bcm2838_pcie_root = {
+    .name = "bcm2838-pcie-root",
+    .priority = MIG_PRI_PCI_BUS,
+    .version_id = 1,
+    .minimum_version_id = 1,
+    .post_load = pcie_cap_slot_post_load,
+    .fields = (const VMStateField[]) {
+        VMSTATE_PCI_DEVICE(parent_obj.parent_obj.parent_obj, PCIESlot),
+        VMSTATE_STRUCT(parent_obj.parent_obj.parent_obj.exp.aer_log,
+                       PCIESlot, 0, vmstate_pcie_aer_log, PCIEAERLog),
+        VMSTATE_UINT8_ARRAY(regs, BCM2838PcieRootState,
+                            BCM2838_PCIE_REGS_SIZE - PCIE_CONFIG_SPACE_SIZE),
+        VMSTATE_END_OF_LIST()
+    }
+};
+
+static void bcm2838_pcie_root_class_init(ObjectClass *class, const void *data)
+{
+    DeviceClass *dc = DEVICE_CLASS(class);
+    PCIDeviceClass *k = PCI_DEVICE_CLASS(class);
+    ResettableClass *rc = RESETTABLE_CLASS(class);
+    PCIERootPortClass *rpc = PCIE_ROOT_PORT_CLASS(class);
+
+    dc->desc = "BCM2711 PCIe Bridge";
+    dc->vmsd = &vmstate_bcm2838_pcie_root;
+
+    resettable_class_set_parent_phases(rc, NULL,
+                                       bcm2838_pcie_root_port_reset_hold,
+                                       NULL, &rpc->parent_phases);
+
+    /*
+     * PCI-facing part of the host bridge, not usable without the host-facing
+     * part, which can't be device_add'ed.
+     */
+    dc->user_creatable = false;
+    k->vendor_id = BCM2838_PCIE_VENDOR_ID;
+    k->device_id = BCM2838_PCIE_DEVICE_ID;
+    k->revision = BCM2838_PCIE_REVISION;
+
+    rpc->exp_offset = BCM2838_PCIE_EXP_CAP_OFFSET;
+    rpc->aer_offset = BCM2838_PCIE_AER_CAP_OFFSET;
+}
+
+static const TypeInfo bcm2838_pcie_root_info = {
+    .name = TYPE_BCM2838_PCIE_ROOT,
+    .parent = TYPE_PCIE_ROOT_PORT,
+    .instance_size = sizeof(BCM2838PcieRootState),
+    .instance_init = bcm2838_pcie_root_init,
+    .class_init = bcm2838_pcie_root_class_init,
+};
+
+static void bcm2838_pcie_register(void)
+{
+    type_register_static(&bcm2838_pcie_root_info);
+}
+
+type_init(bcm2838_pcie_register)
diff --git a/hw/arm/meson.build b/hw/arm/meson.build
index bcc068de040..f3c1b0e00f1 100644
--- a/hw/arm/meson.build
+++ b/hw/arm/meson.build
@@ -104,7 +104,9 @@ arm_common_ss.add(when: 'CONFIG_EXYNOS4', if_true: files('exynos4_boards.c'))
 arm_common_ss.add(when: 'CONFIG_MAX78000FTHR', if_true: files('max78000fthr.c'))
 arm_common_ss.add(when: 'CONFIG_NETDUINO2', if_true: files('netduino2.c'))
 arm_common_ss.add(when: 'CONFIG_RASPI', if_true: files('bcm2835_peripherals.c'))
-arm_common_ss.add(when: 'CONFIG_RASPI', if_true: files('bcm2838_peripherals.c'))
+arm_common_ss.add(when: 'CONFIG_RASPI', if_true: files(
+    'bcm2838_peripherals.c',
+    'bcm2838_pcie.c'))
 arm_common_ss.add(when: 'CONFIG_STRONGARM', if_true: files('strongarm.c'))
 arm_common_ss.add(when: 'CONFIG_SX1', if_true: files('omap_sx1.c'))
 arm_common_ss.add(when: 'CONFIG_VERSATILE', if_true: files('versatilepb.c'))
-- 
2.43.0


