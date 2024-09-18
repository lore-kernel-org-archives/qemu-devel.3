Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A9152CDD552
	for <qemu-devel@archiver.kernel.org>; Wed, 18 Sep 2024 19:24:42 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sr0HB-0006Sp-VE; Wed, 18 Sep 2024 15:23:45 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from
 <3uSjrZgUKCvQpWrelckkcha.Ykimaiq-Zarahjkjcjq.knc@flex--tavip.bounces.google.com>)
 id 1sr0H9-0006K9-Rg
 for qemu-devel@nongnu.org; Wed, 18 Sep 2024 15:23:43 -0400
Received: from mail-pl1-x649.google.com ([2607:f8b0:4864:20::649])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from
 <3uSjrZgUKCvQpWrelckkcha.Ykimaiq-Zarahjkjcjq.knc@flex--tavip.bounces.google.com>)
 id 1sr0H8-0007RC-45
 for qemu-devel@nongnu.org; Wed, 18 Sep 2024 15:23:43 -0400
Received: by mail-pl1-x649.google.com with SMTP id
 d9443c01a7336-206b912491eso12762505ad.0
 for <qemu-devel@nongnu.org>; Wed, 18 Sep 2024 12:23:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=google.com; s=20230601; t=1726687419; x=1727292219; darn=nongnu.org;
 h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
 :date:from:to:cc:subject:date:message-id:reply-to;
 bh=mcht1UrN4o7a748za6EPwH1dmZHR+9K1RZ6hCAmN+lI=;
 b=1FSy1Man3j5Q6YQ8ep3L0mHftBs9+R+3qBBAVEASTF9PCbiCUx9J+tHFML4SQ/R1Hj
 h5YomAbt3sP6Km7IiUvriuxoxqiT0WD7qi+G26Hdwp6TFh17oLz9DayzrgbiV5BqlkL0
 CUYFx8iznga4nbfYImdqNzHqv+hBUHtcXLm4X99jaLkB98RVaddIdKOJpiHh5clzKmWB
 8Mx5MXU0btX6C66x0ZuFjwwxpwkykr/yeNu7c0yoDamIWuUsw5VSThHH0zR1K8eMArwh
 9fwbIC07m2OwEkiP+vfDjaEwT31c/H5HvCZYN+1UKWJyChuCQm/+KAbgBHKdyFInDSo1
 T3TA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1726687419; x=1727292219;
 h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
 :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=mcht1UrN4o7a748za6EPwH1dmZHR+9K1RZ6hCAmN+lI=;
 b=rufJ0N5Q/W9NLuRGEvb2vWKT98r067kKlWN2GX5DG1hcfsHdk6WN9HfvEHZTPV+7QD
 JLjK/VINe9hpSI5NHqmIJ38AqUh4nso6h+J91sO6iBAxa7LWtRL6qsa6KAsBQ/URkUYV
 +GBSnMx2/WEBhr3bRYnOk3EOzovZTC8ZeGk70ECCLuZ0NIfnjuxRPOLuNCFQFOI4oJGO
 CY6P1NL6QHrhlXSRayBxqDG7lIVQfeEl76fVo1B9FEgzRB0EtVVoPy3apKtoVD53bkf7
 uQ5+af1KuanXbJAmz4aUU+MRszdYe9gZrZYZn2QtfNZC8lD0eOh/qZL3TA0fBlkwc6oA
 BZUA==
X-Gm-Message-State: AOJu0Yzh/x6TjU/qANyTmOIK9QqAPyeW1HkalPc+MgnKhF0YmpNXcvaI
 6wXCo+bOIcIp01icqO6D2AzNafHiSC3dn7kVUnxd9/qO87x8ZtYw4E3g7XwMw3lqNk2EmnVZOi/
 tRsFRKZhpvXgFlin48h3GIvturJGinMzH3hjsxVYhIxAqvQdbg4D54sDofaf69gaW9pnaEAdZ6B
 NTX/z5n2nx2kSCYfc5KSrjg7UeBg==
X-Google-Smtp-Source: AGHT+IFumOnyLqv5J02XQqn8ZjlwZgw+QflJFXmX8qjlVZTiSy/Y/YtmA/2k4SYTA4kmWIIOqKQUJoKluQ==
X-Received: from warp10.c.googlers.com ([fda3:e722:ac3:cc00:24:72f4:c0a8:750])
 (user=tavip job=sendgmr) by 2002:a17:902:e204:b0:1fb:1658:926 with
 SMTP id
 d9443c01a7336-208cc3b9e48mr3785ad.6.1726687417742; Wed, 18 Sep 2024 12:23:37
 -0700 (PDT)
Date: Wed, 18 Sep 2024 12:22:50 -0700
In-Reply-To: <20240918192254.3136903-1-tavip@google.com>
Mime-Version: 1.0
References: <20240918192254.3136903-1-tavip@google.com>
X-Mailer: git-send-email 2.46.0.662.g92d0881bb0-goog
Message-ID: <20240918192254.3136903-23-tavip@google.com>
Subject: [PATCH 22/25] hw/misc: add spi-tester
From: Octavian Purdila <tavip@google.com>
To: qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org, stefanst@google.com, pbonzini@redhat.com, 
 peter.maydell@linaro.org, marcandre.lureau@redhat.com, berrange@redhat.com, 
 eduardo@habkost.net, luc@lmichel.fr, damien.hedde@dahe.fr, 
 alistair@alistair23.me, thuth@redhat.com, philmd@linaro.org, jsnow@redhat.com, 
 crosa@redhat.com, lvivier@redhat.com
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::649;
 envelope-from=3uSjrZgUKCvQpWrelckkcha.Ykimaiq-Zarahjkjcjq.knc@flex--tavip.bounces.google.com;
 helo=mail-pl1-x649.google.com
X-Spam_score_int: -95
X-Spam_score: -9.6
X-Spam_bar: ---------
X-Spam_report: (-9.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_MED=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 USER_IN_DEF_DKIM_WL=-7.5 autolearn=unavailable autolearn_force=no
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
 include/hw/misc/spi_tester.h | 32 +++++++++++++++++
 hw/misc/spi_tester.c         | 67 ++++++++++++++++++++++++++++++++++++
 hw/misc/Kconfig              |  5 +++
 hw/misc/meson.build          |  1 +
 4 files changed, 105 insertions(+)
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
index 0000000000..2793ce52dc
--- /dev/null
+++ b/hw/misc/spi_tester.c
@@ -0,0 +1,67 @@
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
+#include "qemu/osdep.h"
+#include "migration/vmstate.h"
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
+static const VMStateDescription vmstate_spi_tester = {
+    .name = "spi-tester",
+    .version_id = 1,
+    .minimum_version_id = 1,
+    .fields = (const VMStateField[]) {
+        VMSTATE_SSI_PERIPHERAL(ssidev, SpiTesterState),
+        VMSTATE_BOOL(cs, SpiTesterState),
+        VMSTATE_END_OF_LIST()
+    }
+};
+
+static void spi_tester_class_init(ObjectClass *klass, void *data)
+{
+    SSIPeripheralClass *k = SSI_PERIPHERAL_CLASS(klass);
+    DeviceClass *dc = DEVICE_CLASS(klass);
+
+    dc->vmsd = &vmstate_spi_tester;
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
index 4f22231fa3..413171f379 100644
--- a/hw/misc/meson.build
+++ b/hw/misc/meson.build
@@ -159,6 +159,7 @@ system_ss.add(when: 'CONFIG_SBSA_REF', if_true: files('sbsa_ec.c'))
 system_ss.add(when: 'CONFIG_LASI', if_true: files('lasi.c'))
 
 system_ss.add(when: 'CONFIG_I2C_TESTER', if_true: files('i2c_tester.c'))
+system_ss.add(when: 'CONFIG_SPI_TESTER', if_true: files('spi_tester.c'))
 
 system_ss.add(when: 'CONFIG_FLEXCOMM', if_true: files('flexcomm.c'))
 system_ss.add(when: 'CONFIG_RT500_CLKCTL', if_true: files('rt500_clkctl0.c', 'rt500_clkctl1.c'))
-- 
2.46.0.662.g92d0881bb0-goog


