Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 257E1606A31E
	for <qemu-devel@archiver.kernel.org>; Fri, 23 Oct 2026 14:00:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=NIPj88ay
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xKFo5-0000qo-7o; Fri, 23 Oct 2026 09:59:41 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcelomanzo@gmail.com>)
 id 1xKFnw-0000gs-2g
 for qemu-devel@nongnu.org; Fri, 23 Oct 2026 09:59:32 -0400
Received: from mail-qk1-x72f.google.com ([2607:f8b0:4864:20::72f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <marcelomanzo@gmail.com>)
 id 1xKFns-0004nn-Q8
 for qemu-devel@nongnu.org; Fri, 23 Oct 2026 09:59:31 -0400
Received: by mail-qk1-x72f.google.com with SMTP id
 af79cd13be357-93e64d52949so80431985a.1
 for <qemu-devel@nongnu.org>; Fri, 23 Oct 2026 06:59:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1792763968; x=1793368768; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=L6uJpMNtTUQgR8jA8ZiqwDPhi9BYwMFvJtfO7zsqCjw=;
 b=NIPj88ayKMEzz2T/eJX/spIRWd8Czt9MM1l04VIJzBdDYyx5Sd8ZwB6F6+Z66ZIpmb
 xIm6rjdBVpQFJKQpB/Qx49Y4RRMQ8hwvws6j78BoSnNzjFTIEJM8pbDO2bKYtX5CpUmz
 qYrIv/qbetF7VhJzKylXLMj/Fg7Vu6N9zCdVsvN6SrBILdcVSza8iTC3fqiYqc1Szz72
 YxehJ3fCH605ok9p/0lXY4BE98DVxRR2KJOZRn6CjD0wKpavHDU4OtuCZl6YTkGNU3O4
 0yjgv2SHWUX475pNQY0/TGMmr46yBrE8pX9B2/CG8Y6OHqsRYlMLY9+A8PzsdhO/r5jQ
 6nhA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792763968; x=1793368768;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=L6uJpMNtTUQgR8jA8ZiqwDPhi9BYwMFvJtfO7zsqCjw=;
 b=sTO8CYGuxcp8XTj2LO7g5EFXXCEoyPezrkUjnhnvDWTRXkSAVu5hA/5KRHLlYYpVTt
 l49Y1W7XfJ1b3SsOijbSL+VuqTfQRsnth7COHxyfRu84VDzxCJubSMQrZs/fAWso8VOJ
 7LDxUtTL2HvNXls/f2RzbrTiC44RvXpny951LrVNwKdefPzwcV1u8NRXvoufY6wDX3SF
 nQ+bpd9tB+9Gjo8ZGkxUT55iZCvlusUi5gPn1Pxi3q0b+ENUhUOIS3NPvwS+JLQWWYNk
 JRmJDiNXoEErqioLHxb9bTkP8C+NOmE7atmtyqn6Bg8e36UGe+OmdexH7R7n6KGE5Sen
 leSw==
X-Gm-Message-State: AFq9FYIUra4O3u9aAtKk8Q/HW6DHlJ1K/S8YVzRaNW5o439wjlzVI0DA
 9u4RzX3S2dGz+uwlxAfkFRjLAfL2ceKc2YU0qI5PCZbHDouX30pqj2PUYxtkGarc
X-Gm-Gg: AYBFou3BQiKLFU1xJuCXKtal0ClqItsI6FuNsRKxLcJVq5TxFVOv4iPBA1prr+iJi8f
 xdkWx58EkaCMyP2mK3zIDxljHj2Np3fddR87GFFIInXSOIrQe7u7hG+bGVCqLl8/nbYoMJZTN7M
 UZHHCnnwhDfaGBQDhp4fmOOqRRYKd7+03eqJBaLvQMKGuO9iUCfoeTIIZRbPr48fwhhHftCvd41
 eCd/iv3f8eNpZs7s38LBCK+57N5Wfz9OlKgZ8e0jBpxNDfgoV+gS5+zJpI5v4ZQj89g2fEYLHo0
 OvDRoithhHucNYbAGsFLF+rU+q+wgrXDLmHWOj1M/JD//wPZW13lYGoEJSwEmQxOT33/J5E4mOP
 iU8uJM/KuJ2hTuRtgfxgbqzHPstFxMgreiQvqq6njVbIbxBEsIormc8d9EfYpx6ljCgkeTleH55
 u4PJ05vNB+Tfan/dxwtWD36jJgAQovHfQb8r75XNqUc3WUMu+8L/4ASmqOT7KfPEc7A+tu+WJoM
 /kWW/CrG8x5R7qqQrCnyE6dw0Ojl4ePeQowetAm1qThGOxFk2OSl61S0cqBDmkNeVgNpjKkY/lb
 wjdzM4JHqw9KRPc47W/n37KyxcZSFl2hHIdBxM2Jfi+79Hxcmryk
X-Received: by 2002:a05:620a:1710:b0:93e:f4f4:346 with SMTP id
 af79cd13be357-93f6f7d01a4mr435885185a.39.1792763967785; 
 Fri, 23 Oct 2026 06:59:27 -0700 (PDT)
Received: from localhost.localdomain ([2606:6d00:159:2900:450e:e72b:156b:33d1])
 by smtp.gmail.com with ESMTPSA id
 af79cd13be357-94047811552sm23741285a.18.2026.10.23.06.59.27
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Fri, 23 Oct 2026 06:59:27 -0700 (PDT)
From: Marcelo Manzo <marcelomanzo@gmail.com>
To: qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org, peter.maydell@linaro.org, philmd@oss.qualcomm.com,
 Marcelo Manzo <marcelomanzo@gmail.com>
Subject: [PATCH v5 01/16] hw/arm/bcm2838_pcie: add BCM2838 PCIe Root Complex
Date: Fri, 23 Oct 2026 09:59:09 -0400
Message-ID: <20261023135924.64990-3-marcelomanzo@gmail.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20261023135924.64990-1-marcelomanzo@gmail.com>
References: <20261023135924.64990-1-marcelomanzo@gmail.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::72f;
 envelope-from=marcelomanzo@gmail.com; helo=mail-qk1-x72f.google.com
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
---
 hw/arm/bcm2838_pcie.c         | 101 ++++++++++++++++++++++++++++++++++
 hw/arm/meson.build            |   4 +-
 include/hw/arm/bcm2838_pcie.h |  54 ++++++++++++++++++
 3 files changed, 158 insertions(+), 1 deletion(-)
 create mode 100644 hw/arm/bcm2838_pcie.c
 create mode 100644 include/hw/arm/bcm2838_pcie.h

diff --git a/hw/arm/bcm2838_pcie.c b/hw/arm/bcm2838_pcie.c
new file mode 100644
index 0000000000..edd174c376
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
index bcc068de04..f3c1b0e00f 100644
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
diff --git a/include/hw/arm/bcm2838_pcie.h b/include/hw/arm/bcm2838_pcie.h
new file mode 100644
index 0000000000..cb95c65331
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
-- 
2.55.0


