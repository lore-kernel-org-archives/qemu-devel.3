Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 280D0C5472F
	for <qemu-devel@archiver.kernel.org>; Tue, 27 Aug 2024 06:52:54 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sipyX-0005Rh-Qe; Tue, 27 Aug 2024 02:46:45 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from
 <3MnbNZgUKCpEEvG3A19916z.x97Bz7F-yzGz689818F.9C1@flex--tavip.bounces.google.com>)
 id 1sipyK-0004EL-1O
 for qemu-devel@nongnu.org; Tue, 27 Aug 2024 02:46:32 -0400
Received: from mail-pl1-x64a.google.com ([2607:f8b0:4864:20::64a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from
 <3MnbNZgUKCpEEvG3A19916z.x97Bz7F-yzGz689818F.9C1@flex--tavip.bounces.google.com>)
 id 1sipyG-0006Bl-H1
 for qemu-devel@nongnu.org; Tue, 27 Aug 2024 02:46:31 -0400
Received: by mail-pl1-x64a.google.com with SMTP id
 d9443c01a7336-1ff24acb60dso47548385ad.0
 for <qemu-devel@nongnu.org>; Mon, 26 Aug 2024 23:46:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=google.com; s=20230601; t=1724741172; x=1725345972; darn=nongnu.org;
 h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
 :date:from:to:cc:subject:date:message-id:reply-to;
 bh=X2yHlfFCVO0YfF3xgHCRZ6c8oJqo6hQZyjUxPy9WUWU=;
 b=w8dhbBlAFGt4620I79UpYtuBkfUUflt4lixyTK2OSrNj4nqs7fGHbLpDFgXrZZguUz
 z/xlFHeCHgCfuzKnGlrKVtyneYaLJFasIjezNeFBWSMNo2+ZKzPid5q0lxLADfc8XxKZ
 qm/m/o1MaDtMF2oxU1Z1hpNheA1XN8sswmZ71fZLrl2iBV0uwIgr76P4BNP9zlfJrwyI
 0WuR/Cpvo133HRUviemNfBEmCRgl8+KCAIZKxXq7OZvDodEXSR6dsV0RJH51OYJLUSDX
 0ag1/ZJfgh7xwl+7Y2pOdU4mF/8p3fDhIvvtD2U2xIxobbx3UwMY6SwxsmtbfVO0G0d8
 PQ+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1724741172; x=1725345972;
 h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
 :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=X2yHlfFCVO0YfF3xgHCRZ6c8oJqo6hQZyjUxPy9WUWU=;
 b=JIQ6ACdbST+DUSSt/+8JtYPAM++Q8jDgx2VQlA9tNAEzMh7gX/ZuzLE6Yc9dnGjvve
 R2D+jXzOqvGUvOkz+AFsUnqZMFTtvK60l6/v9YmlfwSrYCOiYr6gUFvVUfXY233+sopA
 ZjPIjaUasKBFGXgPnPAeVQzscEu/jTcL+eDtY1+tSh9xOQ0omkBkmVJsepYnlQg4RI6T
 tITu6Xl5vB1Olwk+CO9/4UHeXRjaLeD8E13fSywKGNCNetvgBvhzhV1hzYl7S7LVz/fh
 Sz3M5cc/KzlBCXQDkppU7UJtpoZxUaTyF6nIJpXoPO0rcBTmyJWkgkfGRFZOhFPZKvKG
 qxuw==
X-Gm-Message-State: AOJu0YxE0xsUbH5rxoNFaGE65FnZyJzCKO32bCTmNxIT97dhcINC5peF
 h9hstFHGOIQUluhQLZy9ajKRrojE969wKk5RzJf/NWr//JemjVMC+HmVsbS0YK1ldryPCjILrx8
 XwDQA/s5k5dqHG2hmeIfNVGl6+9cdTNRIV43UUROxAarrdYhEtn0qYteTBYIGiVKfhq3VmfG1bt
 8kw9FqQvO7HpND45SmdmD4y0h+Vw==
X-Google-Smtp-Source: AGHT+IHfDT0CEx6IeWVnAIRwh8szSNPNPPQCJKPXrCW2qL0dCoc/JwNcrjLrcytsBJoNYQkhj4NDSnUPGw==
X-Received: from warp10.c.googlers.com ([fda3:e722:ac3:cc00:24:72f4:c0a8:750])
 (user=tavip job=sendgmr) by 2002:a17:903:23c1:b0:1fb:bd8:f83e with
 SMTP id
 d9443c01a7336-204dddf1032mr30155ad.4.1724741170323; Mon, 26 Aug 2024 23:46:10
 -0700 (PDT)
Date: Mon, 26 Aug 2024 23:45:25 -0700
In-Reply-To: <20240827064529.1246786-1-tavip@google.com>
Mime-Version: 1.0
References: <20240827064529.1246786-1-tavip@google.com>
X-Mailer: git-send-email 2.46.0.295.g3b9ea8a38a-goog
Message-ID: <20240827064529.1246786-22-tavip@google.com>
Subject: [RFC PATCH v3 21/24] hw/misc: add spi-tester
From: Octavian Purdila <tavip@google.com>
To: qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org, stefanst@google.com, pbonzini@redhat.com, 
 peter.maydell@linaro.org, marcandre.lureau@redhat.com, berrange@redhat.com, 
 eduardo@habkost.net, luc@lmichel.fr, damien.hedde@dahe.fr, 
 alistair@alistair23.me, thuth@redhat.com, philmd@linaro.org, jsnow@redhat.com, 
 crosa@redhat.com, lvivier@redhat.com
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::64a;
 envelope-from=3MnbNZgUKCpEEvG3A19916z.x97Bz7F-yzGz689818F.9C1@flex--tavip.bounces.google.com;
 helo=mail-pl1-x64a.google.com
X-Spam_score_int: -95
X-Spam_score: -9.6
X-Spam_bar: ---------
X-Spam_report: (-9.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_MED=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01,
 USER_IN_DEF_DKIM_WL=-7.5 autolearn=ham autolearn_force=no
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

Add a simple SPI peripheral that echoes back received data. Useful for
testing SPI controllers.

Signed-off-by: Octavian Purdila <tavip@google.com>
---
 include/hw/misc/spi_tester.h | 32 ++++++++++++++++++++++
 hw/misc/spi_tester.c         | 52 ++++++++++++++++++++++++++++++++++++
 hw/misc/Kconfig              |  5 ++++
 hw/misc/meson.build          |  1 +
 4 files changed, 90 insertions(+)
 create mode 100644 include/hw/misc/spi_tester.h
 create mode 100644 hw/misc/spi_tester.c

diff --git a/include/hw/misc/spi_tester.h b/include/hw/misc/spi_tester.h
new file mode 100644
index 0000000000..8935f3f1af
--- /dev/null
+++ b/include/hw/misc/spi_tester.h
@@ -0,0 +1,32 @@
+/*
+ * Simple SPI peripheral device used for SPI controller testing.
+ *
+ * Copyright (c) 2024 Google LLC.
+ *
+ * SPDX-License-Identifier: GPL-2.0-or-later
+ *
+ * This work is licensed under the terms of the GNU GPL, version 2 or later.
+ * See the COPYING file in the top-level directory.
+ */
+
+#ifndef HW_SPI_TESTER_H
+#define HW_SPI_TESTER_H
+
+#include "qemu/osdep.h"
+#include "qemu/log.h"
+#include "qemu/module.h"
+#include "qemu/bswap.h"
+#include "hw/irq.h"
+#include "hw/ssi/ssi.h"
+#include "qemu/timer.h"
+#include "hw/qdev-properties.h"
+
+#define TYPE_SPI_TESTER "spi-tester"
+#define SPI_TESTER(obj) OBJECT_CHECK(SpiTesterState, (obj), TYPE_SPI_TESTER)
+
+typedef struct {
+    SSIPeripheral ssidev;
+    bool cs;
+} SpiTesterState;
+
+#endif /* HW_SPI_TESTER_H */
diff --git a/hw/misc/spi_tester.c b/hw/misc/spi_tester.c
new file mode 100644
index 0000000000..86599d1184
--- /dev/null
+++ b/hw/misc/spi_tester.c
@@ -0,0 +1,52 @@
+/*
+ * Simple SPI peripheral echo device used for SPI controller testing.
+ *
+ * Copyright (c) 2024 Google LLC.
+ *
+ * SPDX-License-Identifier: GPL-2.0-or-later
+ *
+ * This work is licensed under the terms of the GNU GPL, version 2 or later.
+ * See the COPYING file in the top-level directory.
+ */
+
+#include "hw/misc/spi_tester.h"
+
+static uint32_t spi_tester_transfer(SSIPeripheral *dev, uint32_t value)
+{
+    SpiTesterState *s = SPI_TESTER(dev);
+
+    if (s->cs) {
+        return 0;
+    }
+
+    return value;
+}
+
+static int spi_tester_set_cs(SSIPeripheral *dev, bool select)
+{
+    SpiTesterState *s = SPI_TESTER(dev);
+
+    s->cs = select;
+
+    return 0;
+}
+
+static void spi_tester_class_init(ObjectClass *klass, void *data)
+{
+    SSIPeripheralClass *k = SSI_PERIPHERAL_CLASS(klass);
+
+    k->transfer    = spi_tester_transfer;
+    k->set_cs      = spi_tester_set_cs;
+    k->cs_polarity = SSI_CS_LOW;
+}
+
+static const TypeInfo spi_tester_types[] = {
+    {
+        .name          = TYPE_SPI_TESTER,
+        .parent        = TYPE_SSI_PERIPHERAL,
+        .instance_size = sizeof(SpiTesterState),
+        .class_init    = spi_tester_class_init,
+    },
+};
+
+DEFINE_TYPES(spi_tester_types);
diff --git a/hw/misc/Kconfig b/hw/misc/Kconfig
index 3e93c12c8e..484ee3149f 100644
--- a/hw/misc/Kconfig
+++ b/hw/misc/Kconfig
@@ -218,6 +218,11 @@ config I2C_TESTER
     default y if TEST_DEVICES
     depends on I2C
 
+config SPI_TESTER
+    bool
+    default y if TEST_DEVICES
+    depends on SSI
+
 config FLEXCOMM
     bool
     select I2C
diff --git a/hw/misc/meson.build b/hw/misc/meson.build
index a0f7a52a23..c804237712 100644
--- a/hw/misc/meson.build
+++ b/hw/misc/meson.build
@@ -158,6 +158,7 @@ system_ss.add(when: 'CONFIG_SBSA_REF', if_true: files('sbsa_ec.c'))
 system_ss.add(when: 'CONFIG_LASI', if_true: files('lasi.c'))
 
 system_ss.add(when: 'CONFIG_I2C_TESTER', if_true: files('i2c_tester.c'))
+system_ss.add(when: 'CONFIG_SPI_TESTER', if_true: files('spi_tester.c'))
 
 system_ss.add(when: 'CONFIG_FLEXCOMM', if_true: files('flexcomm.c'))
 system_ss.add(when: 'CONFIG_RT500_CLKCTL', if_true: files('rt500_clkctl0.c', 'rt500_clkctl1.c'))
-- 
2.46.0.295.g3b9ea8a38a-goog


