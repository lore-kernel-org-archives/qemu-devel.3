Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 307C8C3DA7F
	for <qemu-devel@archiver.kernel.org>; Mon,  5 Aug 2024 20:19:22 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sb495-0001nR-Dx; Mon, 05 Aug 2024 16:17:31 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from
 <3UzOxZgUKCroyf0nulttlqj.htrvjrz-ij0jqstslsz.twl@flex--tavip.bounces.google.com>)
 id 1sb493-0001h8-Kh
 for qemu-devel@nongnu.org; Mon, 05 Aug 2024 16:17:29 -0400
Received: from mail-pl1-x64a.google.com ([2607:f8b0:4864:20::64a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from
 <3UzOxZgUKCroyf0nulttlqj.htrvjrz-ij0jqstslsz.twl@flex--tavip.bounces.google.com>)
 id 1sb491-0001OU-6V
 for qemu-devel@nongnu.org; Mon, 05 Aug 2024 16:17:29 -0400
Received: by mail-pl1-x64a.google.com with SMTP id
 d9443c01a7336-1fc6db23c74so115137205ad.0
 for <qemu-devel@nongnu.org>; Mon, 05 Aug 2024 13:17:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=google.com; s=20230601; t=1722889044; x=1723493844; darn=nongnu.org;
 h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
 :date:from:to:cc:subject:date:message-id:reply-to;
 bh=JASjBppiABUPjVgHvBEg2ThgRlH+bgfpU7wO5e+NaYE=;
 b=1226g7oegg9vUhLbTAtjLydrqssAY52KEi+t9PqFJ0cFVgWWFQZ9BB0BnpuPYSVC23
 L9tJWAwuEgtwAgk5fyPfsdlniDX8Hlry0e3+NWDYmryvMqDgjOtgGCNkd3pmJjGKzfvV
 Is0XM5XwR7tsjIMF6w+4SNJHfFcRy7/GHG5trFSzUPwEufxwUhK2+Wo/Eo8eacb3wPNP
 7ITxqbxd3YWf+eejO3x3WbxojC6s3+iuSyzm7St98SZWmHBJjBUVgx4xCRkwgcnixPNh
 akxMuOiHjMRrJa2wMQQSPzOnQsVgaqaeKJARNRvVekR9GufzU4FlYTty1ltNhjMeXneR
 ec1A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1722889044; x=1723493844;
 h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
 :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=JASjBppiABUPjVgHvBEg2ThgRlH+bgfpU7wO5e+NaYE=;
 b=snY0N364TfQrK43cE16fzJZZ9rvndp602vE5u/FpRirgjWZ0H9JNSpQ9QP6R3+Qb+w
 Wfio1iYsLTsvKTrXoDVHpxwtZUvBzKk7PPjSSzY0zmNOfhMvAyK72fzjM8iCni5jdyNd
 T6w0NLcmPtFCsdS5Flb/fGooGq+SIVTcaZTwB9nlMs0ISd44k8gOrgRDW/ahOVM+r0Ch
 JMS+KK+VYAdO70zdUUVWSvPJ7xayATpa0ZHLlCwRMPKU7fX8ErYnCkVun6NMemFLVtSv
 LYi4EOfiBU7HbW6KJQSBPkq192OZCCNMmFOCNEy9ntNd5S4giaNKC+12hUNsMLRoQZaI
 WHow==
X-Gm-Message-State: AOJu0YyuYjfdXYH2/TZRgsS2yS7Oet80i+vurABNXVvEXJTYp6MdBRHO
 ToQRn4PO2U/OOucTGxSHub+7zaO04ULtPJLTtSlmosE2ca3N9igKZNEiIKEL3Z7/TtxTcrFjQ4E
 BW3lEaDBTMkgp2H1nYyiLmjiO7si9Yd2GAL2VBaq3uuBCMQDyf+oqMvdl4snSNng44OzxXH1Mhx
 B3SQJ7LW9eypd7CBYI5JNZFWmjxg==
X-Google-Smtp-Source: AGHT+IGyyrIk3asawWetry+p/a5ZrU/dzfAfbZwm1JHiJ5mZUxhVOeR9NEDFuaROBsMRxBz+palCTk5KCA==
X-Received: from warp10.c.googlers.com ([fda3:e722:ac3:cc00:24:72f4:c0a8:750])
 (user=tavip job=sendgmr) by 2002:a17:902:c38c:b0:1fb:7f2c:5642
 with SMTP id
 d9443c01a7336-1ff5730306cmr8797235ad.4.1722889043889; Mon, 05 Aug 2024
 13:17:23 -0700 (PDT)
Date: Mon,  5 Aug 2024 13:16:57 -0700
In-Reply-To: <20240805201719.2345596-1-tavip@google.com>
Mime-Version: 1.0
References: <20240805201719.2345596-1-tavip@google.com>
X-Mailer: git-send-email 2.46.0.rc2.264.g509ed76dc8-goog
Message-ID: <20240805201719.2345596-3-tavip@google.com>
Subject: [RFC PATCH 02/23] tests/unit: add fifo test
From: Octavian Purdila <tavip@google.com>
To: qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org, stefanst@google.com, pbonzini@redhat.com, 
 alex.bennee@linaro.org, thuth@redhat.com, peter.maydell@linaro.org, 
 marcandre.lureau@redhat.com, alistair@alistair23.me, berrange@redhat.com, 
 philmd@linaro.org, jsnow@redhat.com, crosa@redhat.com, bleal@redhat.com
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::64a;
 envelope-from=3UzOxZgUKCroyf0nulttlqj.htrvjrz-ij0jqstslsz.twl@flex--tavip.bounces.google.com;
 helo=mail-pl1-x64a.google.com
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

Add a simple FIFO unit test that test wrap around and push, pop and
peek for both fifo8 and fifo32.

Signed-off-by: Octavian Purdila <tavip@google.com>
---
 tests/unit/meson.build |  1 +
 tests/unit/test-fifo.c | 98 ++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 99 insertions(+)
 create mode 100644 tests/unit/test-fifo.c

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
diff --git a/tests/unit/test-fifo.c b/tests/unit/test-fifo.c
new file mode 100644
index 0000000000..1686f8bd59
--- /dev/null
+++ b/tests/unit/test-fifo.c
@@ -0,0 +1,98 @@
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
+    int i;
+
+    for (i = 0; i < cycles; i++) {
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
-- 
2.46.0.rc2.264.g509ed76dc8-goog


