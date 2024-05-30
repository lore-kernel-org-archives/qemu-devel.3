Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D79F7C25B74
	for <qemu-devel@archiver.kernel.org>; Thu, 30 May 2024 07:45:59 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sCaTk-0001vA-7F; Thu, 30 May 2024 03:45:40 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>)
 id 1sCaTY-0001tJ-UP; Thu, 30 May 2024 03:45:29 -0400
Received: from mail-pf1-x42b.google.com ([2607:f8b0:4864:20::42b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>)
 id 1sCaTK-000315-DF; Thu, 30 May 2024 03:45:28 -0400
Received: by mail-pf1-x42b.google.com with SMTP id
 d2e1a72fcca58-70232305fecso307251b3a.2; 
 Thu, 30 May 2024 00:45:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1717055107; x=1717659907; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=rr4J6dxm5AtV4yAbJU19/SHZXAqfpuKCexnfNQQEgp8=;
 b=TE0rBmo/RMIjMcqiiLq9L0vchpi/+gNXrYj3AYm8QriJQtQYyAoMHMjqBcV9jNCMuC
 PMQ5bseXyVsdWNhu1xLjF1lUkQi4w/xtJWI6oZ5/0xo1TOAH/oN/EcqWTQ+hkT9zohzO
 49NAL4vDmKgDk796W/OHiq8RS/S62X5KkSt+Fa2xBE++rIzSH/mmiPJvX+GynG7bWqmx
 16hNK8xCPHnROZgCyRkvfOHHI0IGTh4IOuwnwr0GgjMoSEuebb9ufEoAx5ZTbupKGdmU
 vG6ljmE2zEElMN1tPVvLZ9G5ESba5o8TiIa2+b7bPer4cDfH+F/IE3+qFwVh04TA+KIG
 7Viw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1717055107; x=1717659907;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=rr4J6dxm5AtV4yAbJU19/SHZXAqfpuKCexnfNQQEgp8=;
 b=OWrH9M0jzctNbJwmXjP/fz5b/IkfxJihwZJklJHSLVj8c6fOsvVLVXj7Iaz0+NkpvD
 VL0R/r0zi3HbESz8lYmXcas1N81twJBQ0DorsBVIqeqZMykgu3YGG5LxM1+oRUL9QLZe
 wUjfDIpZRbzoR9Ndn+9hQiuIL7RlLVEY+13cNK/qCDwAa9V4CusSLTcVzBGIWtBkVlK1
 NzCsFG1qlavmwx3ly7LtRJJSF7rk8qmZRIiqcdy1uFxZNm2uP9I1IALcQRnpQvbwvWxH
 qeqx0lZczMwhCGpPrSao4HBH9Fiu/EPq4gkFwCtDXGUqhhy1E5UjwBgOfABhMGq0oGMO
 lF8A==
X-Forwarded-Encrypted: i=1;
 AJvYcCVfLH8/3vMg16t7vMz2SgUtd0z4F/FzrqTOWntZ2CICQanKlOdreiZIxOXvhBmkHEgTyYOA5soBmzrh8AFsozQEFZwD
X-Gm-Message-State: AOJu0YwzVrRMkqA/yLTSE3/oABRZell+qhwss5MV5LYdtY9+ePR2ys33
 dN1K35smLGZGtG0OdP6WL+Xm6P2RyP/ywmp7dml61nZAV2QYjPK5CopZkg==
X-Google-Smtp-Source: AGHT+IErhFRqyaaMVyaK5X3ImbnaR5GCT6W+TxcRJCSykVwxk81VnEgxXCfQeqE5W1sQWR2JCq/kPA==
X-Received: by 2002:a05:6a20:158c:b0:1af:a35b:a34f with SMTP id
 adf61e73a8af0-1b264563a5emr1552498637.25.1717055107323; 
 Thu, 30 May 2024 00:45:07 -0700 (PDT)
Received: from wheely.local0.net ([1.146.118.54])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-1f61aa2e998sm8025335ad.62.2024.05.30.00.45.03
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 30 May 2024 00:45:07 -0700 (PDT)
From: Nicholas Piggin <npiggin@gmail.com>
To: qemu-devel@nongnu.org
Cc: Nicholas Piggin <npiggin@gmail.com>, Peter Xu <peterx@redhat.com>,
 Fabiano Rosas <farosas@suse.de>, Thomas Huth <thuth@redhat.com>,
 Laurent Vivier <lvivier@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 qemu-ppc@nongnu.org
Subject: [PATCH v3 1/4] tests/qtest: Move common define from libqos-spapr.h to
 new ppc-util.h
Date: Thu, 30 May 2024 17:44:49 +1000
Message-ID: <20240530074453.21780-2-npiggin@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240530074453.21780-1-npiggin@gmail.com>
References: <20240530074453.21780-1-npiggin@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::42b;
 envelope-from=npiggin@gmail.com; helo=mail-pf1-x42b.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

The spapr QEMU machine defaults is useful outside libqos, so create a
new header for ppc specific qtests and move it there.

Reviewed-by: Thomas Huth <thuth@redhat.com>
Signed-off-by: Nicholas Piggin <npiggin@gmail.com>
---
 tests/qtest/libqos/libqos-spapr.h |  7 -------
 tests/qtest/ppc-util.h            | 19 +++++++++++++++++++
 tests/qtest/boot-serial-test.c    |  2 +-
 tests/qtest/prom-env-test.c       |  2 +-
 tests/qtest/pxe-test.c            |  2 +-
 5 files changed, 22 insertions(+), 10 deletions(-)
 create mode 100644 tests/qtest/ppc-util.h

diff --git a/tests/qtest/libqos/libqos-spapr.h b/tests/qtest/libqos/libqos-spapr.h
index e4483c14f8..a446276416 100644
--- a/tests/qtest/libqos/libqos-spapr.h
+++ b/tests/qtest/libqos/libqos-spapr.h
@@ -9,11 +9,4 @@ QOSState *qtest_spapr_boot(const char *cmdline_fmt, ...)
     G_GNUC_PRINTF(1, 2);
 void qtest_spapr_shutdown(QOSState *qs);
 
-/* List of capabilities needed to silence warnings with TCG */
-#define PSERIES_DEFAULT_CAPABILITIES             \
-    "cap-cfpc=broken,"                           \
-    "cap-sbbc=broken,"                           \
-    "cap-ibs=broken,"                            \
-    "cap-ccf-assist=off,"
-
 #endif
diff --git a/tests/qtest/ppc-util.h b/tests/qtest/ppc-util.h
new file mode 100644
index 0000000000..f68ee93520
--- /dev/null
+++ b/tests/qtest/ppc-util.h
@@ -0,0 +1,19 @@
+/*
+ * PowerPC misc useful things
+ *
+ * Copyright (c) 2024, IBM Corporation.
+ *
+ * SPDX-License-Identifier: GPL-2.0-or-later
+ */
+
+#ifndef PPC_UTIL_H
+#define PPC_UTIL_H
+
+/* List of capabilities needed to silence warnings with TCG */
+#define PSERIES_DEFAULT_CAPABILITIES             \
+    "cap-cfpc=broken,"                           \
+    "cap-sbbc=broken,"                           \
+    "cap-ibs=broken,"                            \
+    "cap-ccf-assist=off,"
+
+#endif /* PPC_UTIL_H */
diff --git a/tests/qtest/boot-serial-test.c b/tests/qtest/boot-serial-test.c
index df389adeeb..3b92fa5d50 100644
--- a/tests/qtest/boot-serial-test.c
+++ b/tests/qtest/boot-serial-test.c
@@ -15,7 +15,7 @@
 
 #include "qemu/osdep.h"
 #include "libqtest.h"
-#include "libqos/libqos-spapr.h"
+#include "ppc-util.h"
 
 static const uint8_t bios_avr[] = {
     0x88, 0xe0,             /* ldi r24, 0x08   */
diff --git a/tests/qtest/prom-env-test.c b/tests/qtest/prom-env-test.c
index 39ccb59797..14705105ad 100644
--- a/tests/qtest/prom-env-test.c
+++ b/tests/qtest/prom-env-test.c
@@ -21,7 +21,7 @@
 
 #include "qemu/osdep.h"
 #include "libqtest.h"
-#include "libqos/libqos-spapr.h"
+#include "ppc-util.h"
 
 #define MAGIC   0xcafec0de
 #define ADDRESS 0x4000
diff --git a/tests/qtest/pxe-test.c b/tests/qtest/pxe-test.c
index e4b48225a5..a3f900fbea 100644
--- a/tests/qtest/pxe-test.c
+++ b/tests/qtest/pxe-test.c
@@ -16,7 +16,7 @@
 #include <glib/gstdio.h>
 #include "libqtest.h"
 #include "boot-sector.h"
-#include "libqos/libqos-spapr.h"
+#include "ppc-util.h"
 
 #define NETNAME "net0"
 
-- 
2.43.0


