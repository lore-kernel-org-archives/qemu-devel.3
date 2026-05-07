Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1DD72CD343F
	for <qemu-devel@archiver.kernel.org>; Thu,  7 May 2026 15:57:02 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wL11G-0003Rd-Ck; Thu, 07 May 2026 11:52:10 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1wL118-0003Ob-Oh
 for qemu-devel@nongnu.org; Thu, 07 May 2026 11:52:02 -0400
Received: from mail-wm1-x32d.google.com ([2a00:1450:4864:20::32d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1wL116-0003kF-I3
 for qemu-devel@nongnu.org; Thu, 07 May 2026 11:52:02 -0400
Received: by mail-wm1-x32d.google.com with SMTP id
 5b1f17b1804b1-4891e86fabeso12799555e9.1
 for <qemu-devel@nongnu.org>; Thu, 07 May 2026 08:52:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1778169119; x=1778773919; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=NpvH/R2i57f6KnUbvaj8PUa3Nl1jmHGibvqUo7D9DqY=;
 b=AI+UHNQWq2EAI7n3oO/bDV8eupmYgeZ+LgKgfVLNatii7g8rluQ350fofMyuKhd2W6
 aytDne/aFMmKgoJIB2LX92nedvHl3GQhpuvhvVLNBRfHabBqxLlLGR65dSxlhnyK5WAV
 AGGkXyIKtpfNfySRx6paZ5ABDqIyNx9FGjpqzQ/hrOHKnZ1TXfejVeAD9NEkp7do8jbd
 xsP+JMIIpE0qBzhDfOBErtDztgkp/HpXPhoHY6uPiU3Z3JV+12A1ABhU5CtYbHHN7y8o
 HzT+Q56bQ0AfBuxKPkkOZ9wqAhJvFpfXLOXZ3/OLydlt2FKkF7YGDAsL03tmbGQVU6IP
 TU7g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1778169119; x=1778773919;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=NpvH/R2i57f6KnUbvaj8PUa3Nl1jmHGibvqUo7D9DqY=;
 b=AwbVFBhOBpFTs86SFQqmarM+wCz1xQQHq0e+n5xqzyEohSPnEC4Z+ySqZ8aJ2X1QVz
 mobCLYA1zJLuS6l++C+tzq/c4+ai8nKKdqPwBKxxcxrwgOBLj1162F9GxhWcPGX2PTsl
 tDw/jrnDQhM1IG1j0TU8JZLKnfc6u7OQQAGCAvmHmgx0JSM5FfsQeEXEh4mk/ne8UfZe
 fkN8bp2Tmb4+HBvu0cRoQZMTie83O8lhPpcFgFqkdS+tQHS08M2+DPj3yZ+Hm+2TPxx9
 Fo6iiqPfnq0vgerDxkp4To/BSSb4lvsZ5fPlgySseQYya46Fm7lY2cKJP0Uyt/G2eDqC
 bBrA==
X-Gm-Message-State: AOJu0YxMJBygvaNavpDzT8WC+jRWi+UVO5g88XrmKKR2Uy1AvCGTuCRk
 7MqKtRL3MzblAnqOb/l3AKKTcyPa410x8HL0nV61XsOL6aWQEeDIrNOh526yNwV9cM8okhI+fYp
 uqUca
X-Gm-Gg: AeBDieuA7wQEK59YwxP+MUJItBEmzocZ+k8sr6KWzS+AekAkCPaydCWN42d1pmU6mDv
 YyrZkp/Y01RCdeFL3Fy7Qdaoyrt16d528y7kzWqZ8uTuN9XtVdqArNhrL96tQV0T/xAO9kpU3na
 Mh+xvsFob4Ebt5iatMdROG2sVv+vRkBqlzjOXobnpnRLofcJ3m+fx9oV4m3xvhss1q5C9JG9/6X
 X1BeRPIy/37HUDO9CZsWSGP7XygMueM4csBkpgeks+oNS4xZNlNWIBBFvGtzettvQ+hGj1703cM
 50tTpA0cc8nfkKfwVcIzY/9MWFlyR91EP5J0dwAbn8CZF+UnORSQ07GeOQYA5cYqxgfuSiKreWK
 QqL8tnCyyq7b99mBYln4ILX00zYZVNCJUh5o5ZmD2sQ5uYubp9JpxpFnyKuGJOxEnCjBhgYPH1u
 GsEf4AfajutDODmcj2UgIciKofCYlVn9jVtZPHWlmu0Cyr7qNW72Q117s6palNQNis5t2EQCiGQ
 50b6YDMrczCSTgv
X-Received: by 2002:a05:600c:1d18:b0:488:78f2:6b0 with SMTP id
 5b1f17b1804b1-48e51f41b9cmr134944375e9.29.1778169118640; 
 Thu, 07 May 2026 08:51:58 -0700 (PDT)
Received: from lanath.. (wildly.archaic.org.uk. [81.2.115.145])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-48e5312df8dsm41552195e9.18.2026.05.07.08.51.57
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 07 May 2026 08:51:57 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 03/67] hw/intc: Skeleton of GICv5 IRS classes
Date: Thu,  7 May 2026 16:50:50 +0100
Message-ID: <20260507155154.1886557-4-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260507155154.1886557-1-peter.maydell@linaro.org>
References: <20260507155154.1886557-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32d;
 envelope-from=peter.maydell@linaro.org; helo=mail-wm1-x32d.google.com
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
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

This commit adds the skeleton of the classes for the GICv5 IRS
(Interrupt Routing Service).  Since the IRS is the main (and only
non-optional) part of the GICv5 outside the CPU, we call it simply
"GICv5", in line with how we've handled the GICv3.

Since we're definitely going to need to have support for KVM VMs
where we present the guest with a GICv5, we use the same split
between an abstract "common" and a concrete specific-to-TCG child
class that we have for the various GICv3 components.  This avoids
having to refactor out the base class later.

Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
Reviewed-by: Jonathan Cameron <jonathan.cameron@huawei.com>
Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Message-id: 20260327111700.795099-4-peter.maydell@linaro.org
---
 hw/intc/Kconfig                    |  5 ++++
 hw/intc/arm_gicv5.c                | 39 ++++++++++++++++++++++++++++++
 hw/intc/arm_gicv5_common.c         | 31 ++++++++++++++++++++++++
 hw/intc/meson.build                |  4 +++
 include/hw/intc/arm_gicv5.h        | 32 ++++++++++++++++++++++++
 include/hw/intc/arm_gicv5_common.h | 31 ++++++++++++++++++++++++
 6 files changed, 142 insertions(+)
 create mode 100644 hw/intc/arm_gicv5.c
 create mode 100644 hw/intc/arm_gicv5_common.c
 create mode 100644 include/hw/intc/arm_gicv5.h
 create mode 100644 include/hw/intc/arm_gicv5_common.h

diff --git a/hw/intc/Kconfig b/hw/intc/Kconfig
index 9f456d7e43..636d00b7e8 100644
--- a/hw/intc/Kconfig
+++ b/hw/intc/Kconfig
@@ -35,6 +35,11 @@ config ARM_GIC_KVM
     bool
     depends on ARM_GIC && KVM
 
+config ARM_GICV5
+    bool
+    depends on TCG
+    select MSI_NONBROKEN
+
 config XICS
     bool
 
diff --git a/hw/intc/arm_gicv5.c b/hw/intc/arm_gicv5.c
new file mode 100644
index 0000000000..f9dab710d3
--- /dev/null
+++ b/hw/intc/arm_gicv5.c
@@ -0,0 +1,39 @@
+/*
+ * ARM GICv5 emulation: Interrupt Routing Service (IRS)
+ *
+ * Copyright (c) 2025 Linaro Limited
+ *
+ * SPDX-License-Identifier: GPL-2.0-or-later
+ */
+
+#include "qemu/osdep.h"
+#include "hw/intc/arm_gicv5.h"
+
+OBJECT_DEFINE_TYPE(GICv5, gicv5, ARM_GICV5, ARM_GICV5_COMMON)
+
+static void gicv5_reset_hold(Object *obj, ResetType type)
+{
+    GICv5 *s = ARM_GICV5(obj);
+    GICv5Class *c = ARM_GICV5_GET_CLASS(s);
+
+    if (c->parent_phases.hold) {
+        c->parent_phases.hold(obj, type);
+    }
+}
+
+static void gicv5_init(Object *obj)
+{
+}
+
+static void gicv5_finalize(Object *obj)
+{
+}
+
+static void gicv5_class_init(ObjectClass *oc, const void *data)
+{
+    ResettableClass *rc = RESETTABLE_CLASS(oc);
+    GICv5Class *gc = ARM_GICV5_CLASS(oc);
+
+    resettable_class_set_parent_phases(rc, NULL, gicv5_reset_hold, NULL,
+                                       &gc->parent_phases);
+}
diff --git a/hw/intc/arm_gicv5_common.c b/hw/intc/arm_gicv5_common.c
new file mode 100644
index 0000000000..b0194f7f26
--- /dev/null
+++ b/hw/intc/arm_gicv5_common.c
@@ -0,0 +1,31 @@
+/*
+ * Common base class for GICv5 IRS
+ *
+ * Copyright (c) 2025 Linaro Limited
+ *
+ * SPDX-License-Identifier: GPL-2.0-or-later
+ */
+
+#include "qemu/osdep.h"
+#include "hw/intc/arm_gicv5_common.h"
+
+OBJECT_DEFINE_ABSTRACT_TYPE(GICv5Common, gicv5_common, ARM_GICV5_COMMON, SYS_BUS_DEVICE)
+
+static void gicv5_common_reset_hold(Object *obj, ResetType type)
+{
+}
+
+static void gicv5_common_init(Object *obj)
+{
+}
+
+static void gicv5_common_finalize(Object *obj)
+{
+}
+
+static void gicv5_common_class_init(ObjectClass *oc, const void *data)
+{
+    ResettableClass *rc = RESETTABLE_CLASS(oc);
+
+    rc->phases.hold = gicv5_common_reset_hold;
+}
diff --git a/hw/intc/meson.build b/hw/intc/meson.build
index c6de2d9d00..d7db99ce35 100644
--- a/hw/intc/meson.build
+++ b/hw/intc/meson.build
@@ -12,6 +12,10 @@ system_ss.add(when: 'CONFIG_ARM_GICV3', if_true: files(
   'arm_gicv3_its.c',
   'arm_gicv3_redist.c',
 ))
+system_ss.add(when: 'CONFIG_ARM_GICV5', if_true: files(
+  'arm_gicv5_common.c',
+  'arm_gicv5.c',
+))
 system_ss.add(when: 'CONFIG_ALLWINNER_A10_PIC', if_true: files('allwinner-a10-pic.c'))
 system_ss.add(when: 'CONFIG_ASPEED_SOC', if_true: files('aspeed_vic.c'))
 system_ss.add(when: 'CONFIG_ASPEED_SOC', if_true: files('aspeed_intc.c'))
diff --git a/include/hw/intc/arm_gicv5.h b/include/hw/intc/arm_gicv5.h
new file mode 100644
index 0000000000..3cd9652f6f
--- /dev/null
+++ b/include/hw/intc/arm_gicv5.h
@@ -0,0 +1,32 @@
+/*
+ * ARM GICv5 emulation: Interrupt Routing Service (IRS)
+ *
+ * Copyright (c) 2025 Linaro Limited
+ *
+ * SPDX-License-Identifier: GPL-2.0-or-later
+ */
+
+#ifndef HW_INTC_ARM_GICV5_H
+#define HW_INTC_ARM_GICV5_H
+
+#include "qom/object.h"
+#include "hw/core/sysbus.h"
+#include "hw/intc/arm_gicv5_common.h"
+
+#define TYPE_ARM_GICV5 "arm-gicv5"
+
+OBJECT_DECLARE_TYPE(GICv5, GICv5Class, ARM_GICV5)
+
+/*
+ * This class is for TCG-specific state for the GICv5.
+ */
+struct GICv5 {
+    GICv5Common parent_obj;
+};
+
+struct GICv5Class {
+    GICv5CommonClass parent_class;
+    ResettablePhases parent_phases;
+};
+
+#endif
diff --git a/include/hw/intc/arm_gicv5_common.h b/include/hw/intc/arm_gicv5_common.h
new file mode 100644
index 0000000000..d2243c7660
--- /dev/null
+++ b/include/hw/intc/arm_gicv5_common.h
@@ -0,0 +1,31 @@
+/*
+ * Common base class for GICv5 IRS
+ *
+ * Copyright (c) 2025 Linaro Limited
+ *
+ * SPDX-License-Identifier: GPL-2.0-or-later
+ */
+
+#ifndef HW_INTC_ARM_GICV5_COMMON_H
+#define HW_INTC_ARM_GICV5_COMMON_H
+
+#include "qom/object.h"
+#include "hw/core/sysbus.h"
+
+#define TYPE_ARM_GICV5_COMMON "arm-gicv5-common"
+
+OBJECT_DECLARE_TYPE(GICv5Common, GICv5CommonClass, ARM_GICV5_COMMON)
+
+/*
+ * This class is for common state that will eventually be shared
+ * between TCG and KVM implementations of the GICv5.
+ */
+struct GICv5Common {
+    SysBusDevice parent_obj;
+};
+
+struct GICv5CommonClass {
+    SysBusDeviceClass parent_class;
+};
+
+#endif
-- 
2.43.0


