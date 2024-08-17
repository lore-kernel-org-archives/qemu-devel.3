Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BB994C52D7F
	for <qemu-devel@archiver.kernel.org>; Sat, 17 Aug 2024 10:32:21 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sfGds-0006Hm-An; Sat, 17 Aug 2024 06:26:43 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from
 <3w3rAZgUKCvYrYtgnemmejc.amkocks-bctcjlmlels.mpe@flex--tavip.bounces.google.com>)
 id 1sfGde-0006Cb-Km
 for qemu-devel@nongnu.org; Sat, 17 Aug 2024 06:26:26 -0400
Received: from mail-yw1-x1149.google.com ([2607:f8b0:4864:20::1149])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from
 <3w3rAZgUKCvYrYtgnemmejc.amkocks-bctcjlmlels.mpe@flex--tavip.bounces.google.com>)
 id 1sfGdU-00036w-2G
 for qemu-devel@nongnu.org; Sat, 17 Aug 2024 06:26:18 -0400
Received: by mail-yw1-x1149.google.com with SMTP id
 00721157ae682-6b41e02c255so14811777b3.3
 for <qemu-devel@nongnu.org>; Sat, 17 Aug 2024 03:26:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=google.com; s=20230601; t=1723890372; x=1724495172; darn=nongnu.org;
 h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
 :date:from:to:cc:subject:date:message-id:reply-to;
 bh=EdDFjN4g9840m4ms6BWuG3c9OsfCPZptsfLAgkhTmCM=;
 b=sfl4HVdfERObjd8+7SaJGpmlnZvTEhfQzEvcKUsMDbu8skhuRRm9ojlPdRNmWkxg1L
 Bitq2SYyQJEpRvtRjJWZhhGOaSgSSKaaptzAtA2qDhrNpUYrLdB9SVqDCGTDX6SSqIwo
 AcfI8RUIniyBQa64XtLvgZpR8MQVhMQMf6Cu+PM+KCglGGnO1FC/iLi5edhI9uHK9KgH
 G+PPIDm8qUD/TNOH2e695pmVOqSDfktILPnYRVUMtcZ2Z1syOGoyHMqzCH8ldh8R5NP0
 Aq5loEGSuQvHt2XMIa5Zw4ysv0leh6SUyieB/fl7tkrn2LX/J/fOx93f6N/ruImpLj6T
 1mOA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1723890372; x=1724495172;
 h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
 :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=EdDFjN4g9840m4ms6BWuG3c9OsfCPZptsfLAgkhTmCM=;
 b=JNyVqizryCiyjYhcunP3PVtIqbS2N/0eTWSEdCvKYKiaJq7Q4EokzPx9dET18NOSOs
 MsD8XbNkVOnTXBkrio+TVVvYZ2QHUOhteTnlvbU7wLSFhKK7viXkBG429QTPgJ0S5Rvq
 izcDDdeAvisH5onUiauAcvCG4fr64sbvkPy9pnMnfE6OHRHEC/J6G5Czkk4WTsSyxS8W
 EeHUqzCavAUARA+IX/Yc444RhPtibdjGe+AKsFTtCV+EVq9KxVSuN8qCe4sykUqVqDP1
 IJzMtZb/ZDnReSTcdirJ8x4ygNmscilKpIOieLPhMZE4iOKzoQxmTsvld2MMx3OxJ1bN
 6LHw==
X-Gm-Message-State: AOJu0YyLlVObqxs3NdgjhjiALGPypmIDLCd09FVx3dLr6fPmYzHaJPCk
 /uRtjyBtVRTw0KlCu3RQh45kOgh/O2sFY04Y1Mu1AMVQbMr8CkjOZ8T20lO7mz1+Kc0ebyjPNSQ
 su+8ER65jbyyM7HabfLhuLx5rToEl/VTDbSBgTELdz6F+TqSJZns5kdq/dEhn2ucbR6OID5SLqv
 SJtXWrxPx2Y/Axq+34Iyr9yyIXUg==
X-Google-Smtp-Source: AGHT+IFcgcsEXNw5jKOCMhnaMDYtW3+TMa6YckRhQVtjWLh7mWiMa1x2Q/Exdoj9Z9zVz/zRPrISd9BTgg==
X-Received: from warp10.c.googlers.com ([fda3:e722:ac3:cc00:24:72f4:c0a8:750])
 (user=tavip job=sendgmr) by 2002:a25:d311:0:b0:e0b:6bb1:fac with
 SMTP id
 3f1490d57ef6-e1180f677afmr53534276.9.1723890371752; Sat, 17 Aug 2024 03:26:11
 -0700 (PDT)
Date: Sat, 17 Aug 2024 03:25:45 -0700
In-Reply-To: <20240817102606.3996242-1-tavip@google.com>
Mime-Version: 1.0
References: <20240817102606.3996242-1-tavip@google.com>
X-Mailer: git-send-email 2.46.0.184.g6999bdac58-goog
Message-ID: <20240817102606.3996242-3-tavip@google.com>
Subject: [RFC PATCH v2 02/23] tests/unit: add fifo test
From: Octavian Purdila <tavip@google.com>
To: qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org, stefanst@google.com, pbonzini@redhat.com, 
 thuth@redhat.com, peter.maydell@linaro.org, marcandre.lureau@redhat.com, 
 alistair@alistair23.me, berrange@redhat.com, philmd@linaro.org, 
 jsnow@redhat.com, crosa@redhat.com
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::1149;
 envelope-from=3w3rAZgUKCvYrYtgnemmejc.amkocks-bctcjlmlels.mpe@flex--tavip.bounces.google.com;
 helo=mail-yw1-x1149.google.com
X-Spam_score_int: -95
X-Spam_score: -9.6
X-Spam_bar: ---------
X-Spam_report: (-9.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_MED=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01,
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

Add a simple FIFO unit test that test wrap around and push, pop and
peek for both fifo8 and fifo32.

Signed-off-by: Octavian Purdila <tavip@google.com>
---
 tests/unit/test-fifo.c | 97 ++++++++++++++++++++++++++++++++++++++++++
 tests/unit/meson.build |  1 +
 2 files changed, 98 insertions(+)
 create mode 100644 tests/unit/test-fifo.c

diff --git a/tests/unit/test-fifo.c b/tests/unit/test-fifo.c
new file mode 100644
index 0000000000..3e6f007229
--- /dev/null
+++ b/tests/unit/test-fifo.c
@@ -0,0 +1,97 @@
+/*
+ * QEMU FIFO testing
+ *
+ * Copyright (C) 2024 Google LLC
+ *
+ * SPDX-License-Identifier: GPL-2.0-or-later
+ *
+ * This work is licensed under the terms of the GNU GPL, version 2 or later.
+ * See the COPYING file in the top-level directory.
+ */
+
+#include "qemu/osdep.h"
+
+#include "qemu/fifo8.h"
+#include "qemu/fifo32.h"
+
+typedef struct {
+    Fifo8 fifo8;
+    Fifo32 fifo32;
+} TestFixture;
+
+#define FIFO_SIZE 13
+
+/*
+ * Test fixture initialization.
+ */
+static void set_up(TestFixture *f, gconstpointer data)
+{
+    int n = (uintptr_t) data;
+
+    fifo8_create(&f->fifo8, n);
+    fifo32_create(&f->fifo32, n);
+}
+
+static void tear_down(TestFixture *f, gconstpointer user_data)
+{
+    fifo8_destroy(&f->fifo8);
+    fifo32_destroy(&f->fifo32);
+}
+
+static void test_push_pop_batch(TestFixture *f, int n)
+{
+    uint8_t i;
+
+    /* push and check peek */
+    for (i = 0; i < n; i++) {
+        uint8_t val8 = i;
+        uint32_t val32 = i | ((i + 1) << 8) | ((i + 2) << 16) | ((i + 3) << 24);
+
+        fifo8_push(&f->fifo8, val8);
+        if (i == 0) {
+            g_assert(*fifo8_peek_buf(&f->fifo8, 1, NULL) == val8);
+        }
+
+        fifo32_push(&f->fifo32, val32);
+        if (i == 0) {
+            g_assert(fifo32_peek(&f->fifo32) == val32);
+        }
+    }
+
+    /* check peek and pop */
+    for (i = 0; i < n; i++) {
+        uint8_t val8 = i;
+        uint32_t val32 = i | ((i + 1) << 8) | ((i + 2) << 16) | ((i + 3) << 24);
+
+        g_assert(*fifo8_peek_buf(&f->fifo8, 1, NULL) == val8);
+        g_assert(fifo8_pop(&f->fifo8) == val8);
+
+        g_assert(fifo32_peek(&f->fifo32) == val32);
+        g_assert(fifo32_pop(&f->fifo32) == val32);
+    }
+}
+
+/* max n should be less then 256 - 3 */
+static void wrap_around_test(TestFixture *f, gconstpointer user_data)
+{
+    int n = (uintptr_t) user_data;
+    const int cycles = 3;
+
+    for (int i = 0; i < cycles; i++) {
+        test_push_pop_batch(f, n / 2 + 1);
+    }
+}
+
+/* mock-ups */
+void *vmstate_info_buffer;
+uint32_t vmstate_info_uint32;
+
+int main(int argc, char **argv)
+{
+    g_test_init(&argc, &argv, NULL);
+
+    g_test_add("/fifo/wrap-around", TestFixture, (gconstpointer)FIFO_SIZE,
+               set_up, wrap_around_test, tear_down);
+
+    return g_test_run();
+}
diff --git a/tests/unit/meson.build b/tests/unit/meson.build
index 26c109c968..397f2503f8 100644
--- a/tests/unit/meson.build
+++ b/tests/unit/meson.build
@@ -47,6 +47,7 @@ tests = {
   'test-logging': [],
   'test-qapi-util': [],
   'test-interval-tree': [],
+  'test-fifo': [],
 }
 
 if have_system or have_tools
-- 
2.46.0.184.g6999bdac58-goog


