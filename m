Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EE677C52D70
	for <qemu-devel@archiver.kernel.org>; Mon,  5 Aug 2024 20:19:30 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sb49b-0004MD-Ao; Mon, 05 Aug 2024 16:18:03 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from
 <3bTOxZgUKCtQJ0L8F6EE6B4.2ECG4CK-34L4BDED6DK.EH6@flex--tavip.bounces.google.com>)
 id 1sb49T-0003iq-A8
 for qemu-devel@nongnu.org; Mon, 05 Aug 2024 16:17:55 -0400
Received: from mail-yb1-xb49.google.com ([2607:f8b0:4864:20::b49])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from
 <3bTOxZgUKCtQJ0L8F6EE6B4.2ECG4CK-34L4BDED6DK.EH6@flex--tavip.bounces.google.com>)
 id 1sb49Q-0001VG-GR
 for qemu-devel@nongnu.org; Mon, 05 Aug 2024 16:17:54 -0400
Received: by mail-yb1-xb49.google.com with SMTP id
 3f1490d57ef6-e0be470f76bso7577021276.3
 for <qemu-devel@nongnu.org>; Mon, 05 Aug 2024 13:17:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=google.com; s=20230601; t=1722889069; x=1723493869; darn=nongnu.org;
 h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
 :date:from:to:cc:subject:date:message-id:reply-to;
 bh=HolQ6M2QNUE2ejhU+N0utPdQeOsLaCbhpFMvlfrSt68=;
 b=uZDRhc+KQTimayIm6PWtaVrkHvy1YUccUMWvqGAQxpu1is+QVmPkKBMK0xG5G4mACq
 mtguNMcC75TQxAz7WWJBFIcGYgSqM4/Qx/mB7lzrWmepmc5E60JsNMlxZS5oMd++eFHm
 R9AF/iiaSF1xt+xOLkSry6NlEYrb4amUI0iUrVcipoSzz7Sw08B4KAuKCI85rTNOTXbw
 4NLax8QhpPUlq22Co2yujk/qqrkX6dweMYO6uz7aIaKniquZr7mvPxM0XUtFTtTkaW1p
 k6Haq6uUpOhya6aMgpTqgdBSZNeMLdZ164SZuTxxwMKUR0JlbT5nWG7RzV19kiI+uruv
 8pNw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1722889069; x=1723493869;
 h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
 :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=HolQ6M2QNUE2ejhU+N0utPdQeOsLaCbhpFMvlfrSt68=;
 b=OZOvy98Q8jQg5IrXtQ9qvYkhRH8yHmeLlroTPPaaK8Pxq2qWWN9KmXhzQU8Cl8Ra/n
 vGbnyUioTMwqAaYCXP082kjARbzHS+1POAEWYh3CXOQq2g3bZM6fEU4Aod4sgrY5KRcC
 MnRgPDDvVQrdmgc/VZJ6HNUZpEQu7GUTpc2LBBb3LLe0kpAyU/GalmHeFUXyFUFunsb3
 rxfdiNXMyDe6c5ZqVHXdmmdGiEfgtc1JcOK7ypy9I9i4uvyr8NZDJptYcyt/wkoHcuCB
 lFD15NfQq7Z4lIyZe5JYcoYhztGaIaBFtjtIW2jOwr0EU3Gw8S2D8BmOXpwn6fiImXbf
 BrJA==
X-Gm-Message-State: AOJu0YyGugkJ+6r3cqRzw7G3ps92/tOE3Haya4LcIGP6TSrurgUMultJ
 +POlmVQfXGG6YaLSvdS+trVJHyG1u272JXm8m8Oes97tqZ045l04a/A2AP7XthdNPllW62WBmVe
 nCgkhBxJVBvzComL+Xzo3jsItC88Fn88piM4xLQFAb9Ui6l8xequjqZJOa0JGBPEA4wjV0qWXmX
 d3tijCNqTikxT5H6jj5CrQhhRqQA==
X-Google-Smtp-Source: AGHT+IHJ2yivBPbFmiyhK3hrpQuvMsngp9pP9WhL1UClne9zJKqUNbF4+KVclnzUr+aIx/QWIhVmtv/sfw==
X-Received: from warp10.c.googlers.com ([fda3:e722:ac3:cc00:24:72f4:c0a8:750])
 (user=tavip job=sendgmr) by 2002:a05:6902:100c:b0:e0b:c18c:ebfb
 with SMTP id
 3f1490d57ef6-e0bde1eca27mr94734276.2.1722889069374; Mon, 05 Aug 2024 13:17:49
 -0700 (PDT)
Date: Mon,  5 Aug 2024 13:17:11 -0700
In-Reply-To: <20240805201719.2345596-1-tavip@google.com>
Mime-Version: 1.0
References: <20240805201719.2345596-1-tavip@google.com>
X-Mailer: git-send-email 2.46.0.rc2.264.g509ed76dc8-goog
Message-ID: <20240805201719.2345596-17-tavip@google.com>
Subject: [RFC PATCH 16/23] test/unit: add spi-tester
From: Octavian Purdila <tavip@google.com>
To: qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org, stefanst@google.com, pbonzini@redhat.com, 
 alex.bennee@linaro.org, thuth@redhat.com, peter.maydell@linaro.org, 
 marcandre.lureau@redhat.com, alistair@alistair23.me, berrange@redhat.com, 
 philmd@linaro.org, jsnow@redhat.com, crosa@redhat.com, bleal@redhat.com
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::b49;
 envelope-from=3bTOxZgUKCtQJ0L8F6EE6B4.2ECG4CK-34L4BDED6DK.EH6@flex--tavip.bounces.google.com;
 helo=mail-yb1-xb49.google.com
X-Spam_score_int: -95
X-Spam_score: -9.6
X-Spam_bar: ---------
X-Spam_report: (-9.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_MED=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
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
 tests/unit/spi_tester.c | 60 +++++++++++++++++++++++++++++++++++++++++
 tests/unit/spi_tester.h | 32 ++++++++++++++++++++++
 2 files changed, 92 insertions(+)
 create mode 100644 tests/unit/spi_tester.c
 create mode 100644 tests/unit/spi_tester.h

diff --git a/tests/unit/spi_tester.c b/tests/unit/spi_tester.c
new file mode 100644
index 0000000000..7bccc680cc
--- /dev/null
+++ b/tests/unit/spi_tester.c
@@ -0,0 +1,60 @@
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
+#include "spi_tester.h"
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
+static void spi_tester_realize(SSIPeripheral *d, Error **errp)
+{
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
+    k->realize     = spi_tester_realize;
+    k->transfer    = spi_tester_transfer;
+    k->set_cs      = spi_tester_set_cs;
+    k->cs_polarity = SSI_CS_LOW;
+}
+
+static const TypeInfo spi_tester_info = {
+    .name          = TYPE_SPI_TESTER,
+    .parent        = TYPE_SSI_PERIPHERAL,
+    .instance_size = sizeof(SpiTesterState),
+    .class_init    = spi_tester_class_init,
+};
+
+static void spi_tester_register_types(void)
+{
+    type_register_static(&spi_tester_info);
+}
+
+type_init(spi_tester_register_types)
diff --git a/tests/unit/spi_tester.h b/tests/unit/spi_tester.h
new file mode 100644
index 0000000000..16e08d2b5c
--- /dev/null
+++ b/tests/unit/spi_tester.h
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
+#ifndef TESTS_UNIT_SPI_TESTER_H
+#define TESTS_UNIT_SPI_TESTER_H
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
+#endif /* TESTS_UNIT_SPI_TESTER_H */
-- 
2.46.0.rc2.264.g509ed76dc8-goog


