Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C307DC5B56A
	for <qemu-devel@archiver.kernel.org>; Wed, 12 Aug 2026 12:18:56 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wu7tD-0004zd-Mk; Wed, 12 Aug 2026 08:16:59 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1wu7t9-0004eg-5g
 for qemu-devel@nongnu.org; Wed, 12 Aug 2026 08:16:55 -0400
Received: from mail-wm1-x335.google.com ([2a00:1450:4864:20::335])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1wu7t7-000076-5P
 for qemu-devel@nongnu.org; Wed, 12 Aug 2026 08:16:54 -0400
Received: by mail-wm1-x335.google.com with SMTP id
 5b1f17b1804b1-4980dc26022so8858375e9.1
 for <qemu-devel@nongnu.org>; Wed, 12 Aug 2026 05:16:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1786537012; x=1787141812; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=h+cmZP9tIR8/f3Ux03T5Hyngz9RHSqaEs0VOCoIAJMU=;
 b=kfieIBTeGpy4cWOWaf3yeNIUizZLO7XZKtX7VwSHyp4NxJlTRWW6QIASlc2pA+OXud
 ZgaFTz1g08PD4EwtBljgOvVWr7oPjW7yKuuo+sfzm1dRM4m8Cv68yLOUtDeD4VT9N9uP
 t6Gv/8w1wT1ogEf0JyBZq5TIGnILdNVpOtd6Z07/wCwEeXhPpSTBkrqgW4y68IO4LXI8
 pV5szSLCmgaanu/qETvD6QFx2J+4A/w48f/5Sp5OVyr4OFm7vYAlTrllOhMqUQXpIDmc
 3XpiIK4LMWP0e0BfgxMMJxmHm0KcvrAKdKUjOY5ADc1pdEVJQ+NkYwdHsjqcsJN65dor
 6k3g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1786537012; x=1787141812;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=h+cmZP9tIR8/f3Ux03T5Hyngz9RHSqaEs0VOCoIAJMU=;
 b=Qq8Q5aetF23XwQSRX+N5lvXpSjYE5qFij7s05PtRBLVHBBaEprscxnwXj+jg301WQQ
 CaLkxyG6j1uOCoVz27Ny2CYrZobxAIT/gt4FY1N27cG1EwejJYAG8fS/+h4NpQniyBO/
 BmBKzTckyne2ew7+r3gR/7rgO2rtiGrcrfdOduk2RNxwCl1VUrknxrckhNJNmJN0drg8
 wVy7c4wpzRFKkpYsqz2oPUzBbzYIQCZL51WtgYiaOIJrP6msdi/fackP2PK1zCwgCiEM
 J00RiuDgupAsXhx05NmhUmgwpy7iqVJ/RD/hBkgCiMkrvEH20hvhfl+m7jkqqN6WlIg0
 ZStA==
X-Gm-Message-State: AOJu0YxciBUnffBKpj87iLa7b6ogc6+Ve6rimHvUdBofxwfrI24TiztZ
 owbpK89SSIEp/T6YUrYnAk/kyZGK6iCj5sQsZrwXlIFmLiUORcPHDMIlbl69it4w5DrLyu/SDTA
 L/RRo
X-Gm-Gg: AR+sD11KowUl3t2JhnC3m+yp111c6KfKAaYZ2MN1kEznZjXrCIF0dAd8SMbO7UZf756
 ZVxQ/gRTMVZZf3fQ9DScsyaryYsodkBa+sV3nrIu9AWpoCLCgFPpa4aPul49c8H6EL+yO+ESd/U
 /IiHLyrMfw40NtIx72J4FC250ZJlvITG18NbVgsTeP9vB8rr7rChKOsCOnn3BpA/qjNck7/31ZJ
 A5NxMe1GseK+sJoSvCXys2NlDyMhrJ5BDsN3EYIDHQGCiY559APsdDkRGlk9saKo5hGSsb/eEzD
 LzrAtAFwVlFfgvlenRT0k5WTawhQmV2NxGF4VRzHtZ5nzfwf2ex1IKfJvrPWkP6lwgnbfHc7tT6
 BjxvZjoo4Ik0cB6fo/eXcMS7TtmrYoNp/mt80DqfzSVHe4XzxBfZXTk39Ju0+wes6a/44yS3oCd
 0Gl40zMqqb5Fql0tOgI8FJEjpR2OjuRb83A9b/5xbeXhq/yduOgR9EqhFY5g6nqA0cTVNCFNKhG
 cD8JF3lsnQXOdrSwLr+wIWOH5CMbZQQSJpj3LnyT5gSs3OU61kz08+5ZBMePKXnKAaQ6w==
X-Received: by 2002:a05:600c:35c5:b0:499:79b9:e226 with SMTP id
 5b1f17b1804b1-4997bf7c39fmr68421225e9.0.1786537011766; 
 Wed, 12 Aug 2026 05:16:51 -0700 (PDT)
Received: from lanath.. (wildly.archaic.org.uk. [81.2.115.145])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4997ad79e5csm36963805e9.3.2026.08.12.05.16.49
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 12 Aug 2026 05:16:50 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 16/26] hw/arm: Add Axiado EVK SCM3003
Date: Wed, 12 Aug 2026 13:16:12 +0100
Message-ID: <20260812121622.649730-17-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260812121622.649730-1-peter.maydell@linaro.org>
References: <20260812121622.649730-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::335;
 envelope-from=peter.maydell@linaro.org; helo=mail-wm1-x335.google.com
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

From: Kuan-Jui Chiu <kchiu@axiado.com>

Add EVK axiado-scm3003 built with AX3000 SoC

Signed-off-by: Kuan-Jui Chiu <kchiu@axiado.com>
Message-id: 20260713073033.3883619-7-kchiu@axiado.com
Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
[PMM: KConfig for the board has to depend on TCG && ARM]
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 hw/arm/Kconfig                 |  6 ++++
 hw/arm/ax3000-boards.c         | 56 ++++++++++++++++++++++++++++++++++
 hw/arm/ax3000-evk.c            | 27 ++++++++++++++++
 hw/arm/meson.build             |  3 ++
 include/hw/arm/ax3000-boards.h | 28 +++++++++++++++++
 5 files changed, 120 insertions(+)
 create mode 100644 hw/arm/ax3000-boards.c
 create mode 100644 hw/arm/ax3000-evk.c
 create mode 100644 include/hw/arm/ax3000-boards.h

diff --git a/hw/arm/Kconfig b/hw/arm/Kconfig
index 32e7d83339..d16b3d2f47 100644
--- a/hw/arm/Kconfig
+++ b/hw/arm/Kconfig
@@ -733,3 +733,9 @@ config AXIADO_SOC
     select AXIADO_CLK
     select AXIADO_SDHCI
     select UNIMP
+
+config AXIADO_EVK
+    bool
+    default y
+    depends on TCG && ARM
+    select AXIADO_SOC
diff --git a/hw/arm/ax3000-boards.c b/hw/arm/ax3000-boards.c
new file mode 100644
index 0000000000..4b8deec15c
--- /dev/null
+++ b/hw/arm/ax3000-boards.c
@@ -0,0 +1,56 @@
+/*
+ * Axiado Boards
+ *
+ * Author: Kuan-Jui Chiu <kchiu@axiado.com>
+ *
+ * SPDX-License-Identifier: GPL-2.0-or-later
+ */
+
+#include "qemu/osdep.h"
+#include "hw/arm/ax3000-boards.h"
+#include "hw/arm/boot.h"
+#include "hw/arm/machines-qom.h"
+#include "qemu/error-report.h"
+#include "qom/object.h"
+
+static struct arm_boot_info ax3000_binfo = {
+    .loader_start = AX3000_DRAM0_BASE,
+    .board_id = -1,
+};
+
+static void ax3000_machine_init(MachineState *machine)
+{
+    Ax3000MachineState *ams = AX3000_MACHINE(machine);
+
+    ams->soc = AX3000_SOC(object_new(TYPE_AX3000_SOC));
+    object_property_add_child(OBJECT(machine), "soc", OBJECT(ams->soc));
+    sysbus_realize_and_unref(SYS_BUS_DEVICE(ams->soc), &error_fatal);
+
+    ax3000_binfo.ram_size = machine->ram_size;
+    arm_load_kernel(&ams->soc->cpu[0], machine, &ax3000_binfo);
+}
+
+static void ax3000_machine_class_init(ObjectClass *oc, const void *data)
+{
+    MachineClass *mc = MACHINE_CLASS(oc);
+
+    mc->init = ax3000_machine_init;
+    mc->default_cpus = AX3000_NUM_CPUS;
+    mc->min_cpus = AX3000_NUM_CPUS;
+    mc->max_cpus = AX3000_NUM_CPUS;
+    mc->default_cpu_type = ARM_CPU_TYPE_NAME("cortex-a53");
+}
+
+static const TypeInfo ax3000_machine_types[] = {
+    {
+        .name          = TYPE_AX3000_MACHINE,
+        .parent        = TYPE_MACHINE,
+        .instance_size = sizeof(Ax3000MachineState),
+        .class_size    = sizeof(Ax3000MachineClass),
+        .class_init    = ax3000_machine_class_init,
+        .interfaces    = aarch64_machine_interfaces,
+        .abstract      = true,
+    }
+};
+
+DEFINE_TYPES(ax3000_machine_types)
diff --git a/hw/arm/ax3000-evk.c b/hw/arm/ax3000-evk.c
new file mode 100644
index 0000000000..a170848871
--- /dev/null
+++ b/hw/arm/ax3000-evk.c
@@ -0,0 +1,27 @@
+/*
+ * Axiado Evaluation Kit Emulation
+ *
+ * Author: Kuan-Jui Chiu <kchiu@axiado.com>
+ *
+ * SPDX-License-Identifier: GPL-2.0-or-later
+ */
+
+#include "qemu/osdep.h"
+#include "hw/arm/ax3000-boards.h"
+
+static void axiado_scm3003_class_init(ObjectClass *oc, const void *data)
+{
+    MachineClass *mc = MACHINE_CLASS(oc);
+
+    mc->desc = "Axiado SCM3003 EVK Board";
+}
+
+static const TypeInfo ax3000_evk_types[] = {
+    {
+        .name          = MACHINE_TYPE_NAME("axiado-scm3003"),
+        .parent        = TYPE_AX3000_MACHINE,
+        .class_init    = axiado_scm3003_class_init,
+    }
+};
+
+DEFINE_TYPES(ax3000_evk_types)
diff --git a/hw/arm/meson.build b/hw/arm/meson.build
index 0254b82df1..8ee5307a91 100644
--- a/hw/arm/meson.build
+++ b/hw/arm/meson.build
@@ -112,6 +112,9 @@ arm_common_ss.add(when: 'CONFIG_VEXPRESS', if_true: files('vexpress.c'))
 
 arm_common_ss.add(when: ['CONFIG_AXIADO_SOC', 'TARGET_AARCH64'], if_true: files(
   'ax3000-soc.c'))
+arm_common_ss.add(when: ['CONFIG_AXIADO_EVK', 'TARGET_AARCH64'], if_true: files(
+  'ax3000-boards.c',
+  'ax3000-evk.c'))
 
 arm_common_ss.add(files('boot.c'))
 
diff --git a/include/hw/arm/ax3000-boards.h b/include/hw/arm/ax3000-boards.h
new file mode 100644
index 0000000000..4a632661e1
--- /dev/null
+++ b/include/hw/arm/ax3000-boards.h
@@ -0,0 +1,28 @@
+/*
+ * Axiado Boards
+ *
+ * Author: Kuan-Jui Chiu <kchiu@axiado.com>
+ *
+ * SPDX-License-Identifier: GPL-2.0-or-later
+ */
+
+#ifndef AXIADO_BOARD_H
+#define AXIADO_BOARD_H
+
+#include "hw/core/boards.h"
+#include "hw/arm/ax3000-soc.h"
+
+#define TYPE_AX3000_MACHINE       MACHINE_TYPE_NAME("ax3000")
+OBJECT_DECLARE_TYPE(Ax3000MachineState, Ax3000MachineClass, AX3000_MACHINE)
+
+typedef struct Ax3000MachineState {
+    MachineState parent;
+
+    Ax3000SoCState *soc;
+} Ax3000MachineState;
+
+typedef struct Ax3000MachineClass {
+    MachineClass parent;
+
+} Ax3000MachineClass;
+#endif
-- 
2.43.0


