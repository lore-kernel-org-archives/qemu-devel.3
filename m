Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 08D53109C028
	for <qemu-devel@archiver.kernel.org>; Wed, 25 Mar 2026 15:18:51 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w5Pzm-0004mt-DC; Wed, 25 Mar 2026 11:18:10 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1w5PzZ-0004ed-QP
 for qemu-devel@nongnu.org; Wed, 25 Mar 2026 11:18:00 -0400
Received: from mail-wm1-x332.google.com ([2a00:1450:4864:20::332])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1w5PzX-0008F3-Li
 for qemu-devel@nongnu.org; Wed, 25 Mar 2026 11:17:57 -0400
Received: by mail-wm1-x332.google.com with SMTP id
 5b1f17b1804b1-486fe2024a9so39613595e9.0
 for <qemu-devel@nongnu.org>; Wed, 25 Mar 2026 08:17:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1774451874; x=1775056674; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=XA8bPid9+EKsdhouBQu4lXqcrGO4SDDhjT8ZDU7r9Ac=;
 b=gDlBNZryujxUPYMA8/BnVCijWZf0qp420J55G+vf7tKSN3x8Pqv3FIwmQo7jm5P000
 ELP//bkrzYHGVzV6jQXa39QuJffo/c43gXnhHDNRqLc2jfUv469WTQERcU7nVVfwu4xe
 5Cq8GvnUqSNQ5NGjFSGs6BQBU1SAujyKmBGunygDutb6V9cnE43VFN2hGpluHS0UmvhP
 ry1wnnUtJYodjUlHqnT5jtKlH44HIPMCwBbppcPbGYqHx5213fvgJEjkTiClB19wBNgz
 mQ43h7ly8wDlkG7bZZUPB5Wp7VyFOU250iaM2EUr+KOokPkICGfMNrCb8909mzsovwzw
 Y60g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1774451874; x=1775056674;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=XA8bPid9+EKsdhouBQu4lXqcrGO4SDDhjT8ZDU7r9Ac=;
 b=hbUVswK3ZG+NdngZsY8SwE2rzKkRenpYR5MTh4AUWuhq7/cGBs8uXGbwOwHFZ2WEOU
 Gjao1BEu0swe0V9obe9LaqnZVejFOiJ4mBZiSeZdc9LWVd6TxDJ68LMoYubrQookr5mP
 FC2MIpLL50Q3l4SgfOeSLKJKdwLS+k9e4FXNh00hpVqDrUqQbSBmUJb56TZkftXFmdOM
 uvxqBjruNh97RRMUKblNCdBX+XpEGeNsR61eO+ABLGXi+YWSTSe3XU7AIqCCJ0uoq+Dz
 dU5WCIltWza3rLqQZU2gbQKV33L4ZWHjWEZVSmnlwI0OX1gnkWiu0XF2UL5uBbr5AgY1
 6I/g==
X-Forwarded-Encrypted: i=1;
 AJvYcCXKt97bDfeJ82/palTKjoDD98agVgTUiQkaiLVR08vMu9CWg5/0iEgRnYazlImMcc+NxqCP89bkzSmg@nongnu.org
X-Gm-Message-State: AOJu0YxhjKc0tF2+z6kb0nERehdYYx4BE0NYqkUDIaw7v+JEgOWm0wDm
 /FgGoO4na0tlrLA4Z6OONspBpywKR66mdee+lw4Olb5E/2u/yIrPWXYc6ICgJWs5+PfzScKK4YV
 X2z/7iQE=
X-Gm-Gg: ATEYQzyUq+dU++tjwtcDzWnW2lVM+jci0jcNs1lU6U5EXUv8KYoFU741YGb4Gdc/eyd
 lqYORdX3cogQJitVb/e1B4bKTNk+wO/fZ29OyHfTMi1ga4Q7TrHXQE6qhEne5KlmW07I9TaV1OP
 Ux4oYoEWYBk88aOE1nBTge7cYVCnADFJ8J+kadYKNhYH9rwbV+hg5SsGqmTSsCZaoyLt20p5C5M
 e48jEhVlHgO6msEnd72DaQVfTy6edskdF5BAzGF6W9/fy4XFdqVI14h6NCk8O5VfYaqCWbuqEtm
 hgPIuiVrNjmoctaGqvyW4ImLABB/21yvMkzgRNkUmeddgrplnB9xThK+FSU/09lPYmMSTt0Rv+x
 SCOYQWSWtKjV93AUSsi5IkypdYaOMCZ5a1SabBF/VyWHOJv/b3gPKy0IQbQhEP13lgY6LxMmQxI
 xlBQP0QPFV0nxOk8pIFDrbWPNo/IZwHMKopmLRRIh8coyWUs1rETfjLs0auMjmo+DJPuIvnNp3
X-Received: by 2002:a05:600c:1f12:b0:486:fdca:ea8d with SMTP id
 5b1f17b1804b1-48716050758mr55535255e9.25.1774451873986; 
 Wed, 25 Mar 2026 08:17:53 -0700 (PDT)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4871174f2cesm139322565e9.10.2026.03.25.08.17.52
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Wed, 25 Mar 2026 08:17:52 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: Michael Tokarev <mjt@tls.msk.ru>,
	qemu-devel@nongnu.org
Cc: =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 kvm@vger.kernel.org, Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Yanan Wang <wangyanan55@huawei.com>, Zhao Liu <zhao1.liu@intel.com>
Subject: [PATCH-for-11.0? 3/6] qom: Declare GlobalProperty structure in
 'qom/compat-properties.h'
Date: Wed, 25 Mar 2026 16:17:25 +0100
Message-ID: <20260325151728.45378-4-philmd@linaro.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260325151728.45378-1-philmd@linaro.org>
References: <20260325151728.45378-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::332;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x332.google.com
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

While GlobalProperty is expected to only be used by QDev board
layer, it is used by the lower QOM API, so define it in the
qom/ namespace. This helps to build binary which use QOM but
don't need the QDev layer.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 include/hw/core/boards.h          |  1 +
 include/hw/core/qdev-properties.h |  1 +
 include/hw/core/qdev.h            | 17 ----------------
 include/qom/compat-properties.h   | 32 +++++++++++++++++++++++++++++++
 qom/object.c                      |  2 +-
 5 files changed, 35 insertions(+), 18 deletions(-)
 create mode 100644 include/qom/compat-properties.h

diff --git a/include/hw/core/boards.h b/include/hw/core/boards.h
index b7138f2715e..ec8999c0e14 100644
--- a/include/hw/core/boards.h
+++ b/include/hw/core/boards.h
@@ -8,6 +8,7 @@
 #include "system/blockdev.h"
 #include "qapi/qapi-types-machine.h"
 #include "qemu/module.h"
+#include "qom/compat-properties.h"
 #include "qom/object.h"
 #include "hw/core/cpu.h"
 #include "hw/core/resettable.h"
diff --git a/include/hw/core/qdev-properties.h b/include/hw/core/qdev-properties.h
index d8745d4c65f..17543957a6c 100644
--- a/include/hw/core/qdev-properties.h
+++ b/include/hw/core/qdev-properties.h
@@ -1,6 +1,7 @@
 #ifndef QEMU_QDEV_PROPERTIES_H
 #define QEMU_QDEV_PROPERTIES_H
 
+#include "qom/compat-properties.h"
 #include "hw/core/qdev.h"
 
 /**
diff --git a/include/hw/core/qdev.h b/include/hw/core/qdev.h
index 778617787c7..337d69ea2c3 100644
--- a/include/hw/core/qdev.h
+++ b/include/hw/core/qdev.h
@@ -404,23 +404,6 @@ struct BusState {
     ResettableState reset;
 };
 
-/**
- * typedef GlobalProperty - a global property type
- *
- * @used: Set to true if property was used when initializing a device.
- * @optional: If set to true, GlobalProperty will be skipped without errors
- *            if the property doesn't exist.
- *
- * An error is fatal for non-hotplugged devices, when the global is applied.
- */
-typedef struct GlobalProperty {
-    const char *driver;
-    const char *property;
-    const char *value;
-    bool used;
-    bool optional;
-} GlobalProperty;
-
 /*** Board API.  This should go away once we have a machine config file.  ***/
 
 /**
diff --git a/include/qom/compat-properties.h b/include/qom/compat-properties.h
new file mode 100644
index 00000000000..6e44aabc26b
--- /dev/null
+++ b/include/qom/compat-properties.h
@@ -0,0 +1,32 @@
+/*
+ * QEMU Object Model
+ *
+ * Copyright IBM, Corp. 2011
+ *
+ * Authors:
+ *  Anthony Liguori   <aliguori@us.ibm.com>
+ *
+ * SPDX-License-Identifier: GPL-2.0-or-later
+ */
+
+#ifndef QEMU_COMPAT_PROPERTIES_H
+#define QEMU_COMPAT_PROPERTIES_H
+
+/**
+ * typedef GlobalProperty - a global property type
+ *
+ * @used: Set to true if property was used when initializing a device.
+ * @optional: If set to true, GlobalProperty will be skipped without errors
+ *            if the property doesn't exist.
+ *
+ * An error is fatal for non-hotplugged devices, when the global is applied.
+ */
+typedef struct GlobalProperty {
+    const char *driver;
+    const char *property;
+    const char *value;
+    bool used;
+    bool optional;
+} GlobalProperty;
+
+#endif
diff --git a/qom/object.c b/qom/object.c
index ff8ede8a328..838b1d2b225 100644
--- a/qom/object.c
+++ b/qom/object.c
@@ -11,8 +11,8 @@
  */
 
 #include "qemu/osdep.h"
-#include "hw/core/qdev.h"
 #include "qapi/error.h"
+#include "qom/compat-properties.h"
 #include "qom/object.h"
 #include "qom/object_interfaces.h"
 #include "qemu/cutils.h"
-- 
2.53.0


