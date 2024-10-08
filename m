Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 63B8ACED24D
	for <qemu-devel@archiver.kernel.org>; Tue,  8 Oct 2024 01:25:33 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sxyuF-0005Jt-N9; Mon, 07 Oct 2024 21:20:55 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from
 <3m4gEZwUKCvwxezmtksskpi.gsquiqy-hiziprsrkry.svk@flex--tavip.bounces.google.com>)
 id 1sxysx-0008CE-JD
 for qemu-devel@nongnu.org; Mon, 07 Oct 2024 21:19:36 -0400
Received: from mail-yw1-x1149.google.com ([2607:f8b0:4864:20::1149])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from
 <3m4gEZwUKCvwxezmtksskpi.gsquiqy-hiziprsrkry.svk@flex--tavip.bounces.google.com>)
 id 1sxyst-0000CW-74
 for qemu-devel@nongnu.org; Mon, 07 Oct 2024 21:19:34 -0400
Received: by mail-yw1-x1149.google.com with SMTP id
 00721157ae682-6e2b049b64aso81158297b3.3
 for <qemu-devel@nongnu.org>; Mon, 07 Oct 2024 18:19:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=google.com; s=20230601; t=1728350364; x=1728955164; darn=nongnu.org;
 h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
 :date:from:to:cc:subject:date:message-id:reply-to;
 bh=UWggVGt8pbE9ZLsUZv4jH44X5yOt44e5jHCMlGNjp7Y=;
 b=a7goeXj4xpd6QVZucbFLqeoo/qPRNmaftLcNPO5RqWa4dtcwb5fvbAOo/gFAuj1eI8
 yTqXbWYK5kULLpevzOiSJCy8RTEKyXi1vOw+k/9c9u4ChJTA41b+fuXAaVk8PZCGjCe9
 Z6dCam6aESV/eqE8L/a0RvwPlAZrgKpC+SNemGQA7wJAHol0r3R/B/YNyDrAS2/NXMiM
 1Q3uY3+F4dRSf+OSSBeyDpJR7ztZb+3gzaXttRYqoYxFv4CQ+3LdPhtStBTOu1md9Oui
 1VgEYaekDdL1auVUopeUaVbrUDpGk6s9IoAbnQMUXqH5tsNXyvpsVvHK1PRJ/tIT9ylI
 Gi6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1728350364; x=1728955164;
 h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
 :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=UWggVGt8pbE9ZLsUZv4jH44X5yOt44e5jHCMlGNjp7Y=;
 b=mZ+Yz8s1krXk77laXY97zVaKm9+WD7gIgTDatbze/B2QZnod5q9vCnzekqB0rO5/QF
 H9GMF2HAeEu7nJvHNyySIqQDjvtsN9OhNU0J0M5dcCTq9MkcaGlw00AjIeOrFgiUtuPX
 E9+7s6XkayJGYAMfqBPsmjd4vL3xOrkNk3DJGewZ14X43v4LLePCinUbhy9kSHe81YMk
 xH0VqhmkHuoRJC5FNUMIHsPHHCgWBSHGgH+6KBzknPa8c+ncTc91JyUza8/yJUGvCfmH
 RqUZ/weEtJSrkS204OkgFqjiwyMl1RNXHqMUkPhV4M71CEsimhHkBhpBrKGMSxdbMoIb
 huFg==
X-Gm-Message-State: AOJu0YzGkHnS7f6a2VuKYVDhnr6wyBBs+CyPJpsCwioV1BubJ2d+dBQ4
 FC9epnrthHjVOM5fTOOoaup9BFsWHR/zsX1wefwzKHB97DviRGli8cRh825MLFelAJ9uWyOtW9r
 +zFkqqsowIn7QcJq1FuBm+tRtvOh0FB8gMkCoNH6TutT+lhRPjQ6/fooKO5+I8tTwfB8urc0esK
 jz26cEWfZiWZBQfgKXMp2KyyIhpQ==
X-Google-Smtp-Source: AGHT+IEnKoproXBmyAwcgsF2f2+HISyD0A+czH81es2a+FVh2KqZfn9xb+61J5CW4nGtkj6QDLnqUisx7g==
X-Received: from warp10.c.googlers.com ([fda3:e722:ac3:cc00:24:72f4:c0a8:750])
 (user=tavip job=sendgmr) by 2002:a25:26d0:0:b0:e17:8e73:866c with
 SMTP id
 3f1490d57ef6-e2893945130mr35092276.10.1728350363413; Mon, 07 Oct 2024
 18:19:23 -0700 (PDT)
Date: Mon,  7 Oct 2024 18:18:42 -0700
In-Reply-To: <20241008011852.1439154-1-tavip@google.com>
Mime-Version: 1.0
References: <20241008011852.1439154-1-tavip@google.com>
X-Mailer: git-send-email 2.47.0.rc0.187.ge670bccf7e-goog
Message-ID: <20241008011852.1439154-17-tavip@google.com>
Subject: [PATCH v2 16/25] system/qtest: add APIS to check for memory access
 failures
From: Octavian Purdila <tavip@google.com>
To: qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org, stefanst@google.com, pbonzini@redhat.com, 
 peter.maydell@linaro.org, marcandre.lureau@redhat.com, berrange@redhat.com, 
 eduardo@habkost.net, luc@lmichel.fr, damien.hedde@dahe.fr, 
 alistair@alistair23.me, thuth@redhat.com, philmd@linaro.org, jsnow@redhat.com, 
 crosa@redhat.com, lvivier@redhat.com
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::1149;
 envelope-from=3m4gEZwUKCvwxezmtksskpi.gsquiqy-hiziprsrkry.svk@flex--tavip.bounces.google.com;
 helo=mail-yw1-x1149.google.com
X-Spam_score_int: -95
X-Spam_score: -9.6
X-Spam_bar: ---------
X-Spam_report: (-9.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_MED=-0.024,
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

Add read*/write*_fail qtest APIs to check for memory access failures.

Signed-off-by: Octavian Purdila <tavip@google.com>
---
 tests/qtest/libqtest-single.h | 92 +++++++++++++++++++++++++++++++++++
 tests/qtest/libqtest.h        | 76 +++++++++++++++++++++++++++++
 system/qtest.c                | 44 ++++++++++-------
 tests/qtest/libqtest.c        | 73 ++++++++++++++++++++++++++-
 4 files changed, 265 insertions(+), 20 deletions(-)

diff --git a/tests/qtest/libqtest-single.h b/tests/qtest/libqtest-single.h
index 851724cbcb..c22037c8b2 100644
--- a/tests/qtest/libqtest-single.h
+++ b/tests/qtest/libqtest-single.h
@@ -265,6 +265,98 @@ static inline uint64_t readq(uint64_t addr)
     return qtest_readq(global_qtest, addr);
 }
 
+/**
+ * writeb_fail:
+ * @addr: Guest address to write to.
+ * @value: Value being written.
+ *
+ * Writes an 8-bit value to memory expecting a failure.
+ */
+static inline void writeb_fail(uint64_t addr, uint8_t value)
+{
+    qtest_writeb_fail(global_qtest, addr, value);
+}
+
+/**
+ * writew_fail:
+ * @addr: Guest address to write to.
+ * @value: Value being written.
+ *
+ * Writes a 16-bit value to memory expecting a failure.
+ */
+static inline void writew_fail(uint64_t addr, uint16_t value)
+{
+    qtest_writew_fail(global_qtest, addr, value);
+}
+
+/**
+ * writel_fail:
+ * @addr: Guest address to write to.
+ * @value: Value being written.
+ *
+ * Writes a 32-bit value to memory expecting a failure.
+ */
+static inline void writel_fail(uint64_t addr, uint32_t value)
+{
+    qtest_writel_fail(global_qtest, addr, value);
+}
+
+/**
+ * writeq_fail:
+ * @addr: Guest address to write to.
+ * @value: Value being written.
+ *
+ * Writes a 64-bit value to memory expecting a failure.
+ */
+static inline void writeq_fail(uint64_t addr, uint64_t value)
+{
+    qtest_writeq_fail(global_qtest, addr, value);
+}
+
+/**
+ * readb_fail:
+ * @addr: Guest address to read from.
+ *
+ * Reads an 8-bit value from memory expecting a failure.
+ */
+static inline void readb_fail(uint64_t addr)
+{
+    qtest_readb_fail(global_qtest, addr);
+}
+
+/**
+ * readw_fail:
+ * @addr: Guest address to read from.
+ *
+ * Reads a 16-bit value from memory expecting a failure.
+ */
+static inline void readw_fail(uint64_t addr)
+{
+    qtest_readw_fail(global_qtest, addr);
+}
+
+/**
+ * readl_fail:
+ * @addr: Guest address to read from.
+ *
+ * Reads a 32-bit value from memory expecting a failure.
+ */
+static inline void readl_fail(uint64_t addr)
+{
+    qtest_readl_fail(global_qtest, addr);
+}
+
+/**
+ * readq_fail:
+ * @addr: Guest address to read from.
+ *
+ * Reads a 64-bit value from memory expecting a failure.
+ */
+static inline void readq_fail(uint64_t addr)
+{
+    qtest_readq_fail(global_qtest, addr);
+}
+
 /**
  * memread:
  * @addr: Guest address to read from.
diff --git a/tests/qtest/libqtest.h b/tests/qtest/libqtest.h
index beb96b18eb..f9bbeb2e60 100644
--- a/tests/qtest/libqtest.h
+++ b/tests/qtest/libqtest.h
@@ -549,6 +549,82 @@ uint32_t qtest_readl(QTestState *s, uint64_t addr);
  */
 uint64_t qtest_readq(QTestState *s, uint64_t addr);
 
+/**
+ * qtest_writeb_fail:
+ * @s: #QTestState instance to operate on.
+ * @addr: Guest address to write to.
+ * @value: Value being written.
+ *
+ * Writes an 8-bit value to memory expecting a failure.
+ */
+void qtest_writeb_fail(QTestState *s, uint64_t addr, uint8_t value);
+
+/**
+ * qtest_writew_fail:
+ * @s: #QTestState instance to operate on.
+ * @addr: Guest address to write to.
+ * @value: Value being written.
+ *
+ * Writes a 16-bit value to memory expecting a failure.
+ */
+void qtest_writew_fail(QTestState *s, uint64_t addr, uint16_t value);
+
+/**
+ * qtest_writel_fail:
+ * @s: #QTestState instance to operate on.
+ * @addr: Guest address to write to.
+ * @value: Value being written.
+ *
+ * Writes a 32-bit value to memory expecting a failure.
+ */
+void qtest_writel_fail(QTestState *s, uint64_t addr, uint32_t value);
+
+/**
+ * qtest_writeq_fail:
+ * @s: #QTestState instance to operate on.
+ * @addr: Guest address to write to.
+ * @value: Value being written.
+ *
+ * Writes a 64-bit value to memory expecting a failure.
+ */
+void qtest_writeq_fail(QTestState *s, uint64_t addr, uint64_t value);
+
+/**
+ * qtest_readb_fail:
+ * @s: #QTestState instance to operate on.
+ * @addr: Guest address to read from.
+ *
+ * Reads an 8-bit value from memory expecting a failure.
+ */
+void qtest_readb_fail(QTestState *s, uint64_t addr);
+
+/**
+ * qtest_readw_fail:
+ * @s: #QTestState instance to operate on.
+ * @addr: Guest address to read from.
+ *
+ * Reads a 16-bit value from memory expecting a failure.
+ */
+void qtest_readw_fail(QTestState *s, uint64_t addr);
+
+/**
+ * qtest_readl_fail:
+ * @s: #QTestState instance to operate on.
+ * @addr: Guest address to read from.
+ *
+ * Reads a 32-bit value from memory expecting a failure.
+ */
+void qtest_readl_fail(QTestState *s, uint64_t addr);
+
+/**
+ * qtest_readq_fail:
+ * @s: #QTestState instance to operate on.
+ * @addr: Guest address to read from.
+ *
+ * Reads a 64-bit value from memory expecting a failure.
+ */
+void qtest_readq_fail(QTestState *s, uint64_t addr);
+
 /**
  * qtest_memread:
  * @s: #QTestState instance to operate on.
diff --git a/system/qtest.c b/system/qtest.c
index 12703a2045..95bb80a2bc 100644
--- a/system/qtest.c
+++ b/system/qtest.c
@@ -514,26 +514,30 @@ static void qtest_process_command(CharBackend *chr, gchar **words)
 
         if (words[0][5] == 'b') {
             uint8_t data = value;
-            address_space_write(first_cpu->as, addr, MEMTXATTRS_UNSPECIFIED,
-                                &data, 1);
+            ret = address_space_write(first_cpu->as, addr,
+                                      MEMTXATTRS_UNSPECIFIED, &data, 1);
         } else if (words[0][5] == 'w') {
             uint16_t data = value;
             tswap16s(&data);
-            address_space_write(first_cpu->as, addr, MEMTXATTRS_UNSPECIFIED,
-                                &data, 2);
+            ret = address_space_write(first_cpu->as, addr,
+                                      MEMTXATTRS_UNSPECIFIED, &data, 2);
         } else if (words[0][5] == 'l') {
             uint32_t data = value;
             tswap32s(&data);
-            address_space_write(first_cpu->as, addr, MEMTXATTRS_UNSPECIFIED,
-                                &data, 4);
+            ret = address_space_write(first_cpu->as, addr,
+                                      MEMTXATTRS_UNSPECIFIED, &data, 4);
         } else if (words[0][5] == 'q') {
             uint64_t data = value;
             tswap64s(&data);
-            address_space_write(first_cpu->as, addr, MEMTXATTRS_UNSPECIFIED,
-                                &data, 8);
+            ret = address_space_write(first_cpu->as, addr,
+                                      MEMTXATTRS_UNSPECIFIED, &data, 8);
         }
         qtest_send_prefix(chr);
-        qtest_send(chr, "OK\n");
+        if (ret == MEMTX_OK) {
+            qtest_send(chr, "OK\n");
+        } else {
+            qtest_send(chr, "FAIL\n");
+        }
     } else if (strcmp(words[0], "readb") == 0 ||
                strcmp(words[0], "readw") == 0 ||
                strcmp(words[0], "readl") == 0 ||
@@ -548,26 +552,30 @@ static void qtest_process_command(CharBackend *chr, gchar **words)
 
         if (words[0][4] == 'b') {
             uint8_t data;
-            address_space_read(first_cpu->as, addr, MEMTXATTRS_UNSPECIFIED,
-                               &data, 1);
+            ret = address_space_read(first_cpu->as, addr,
+                                     MEMTXATTRS_UNSPECIFIED, &data, 1);
             value = data;
         } else if (words[0][4] == 'w') {
             uint16_t data;
-            address_space_read(first_cpu->as, addr, MEMTXATTRS_UNSPECIFIED,
-                               &data, 2);
+            ret = address_space_read(first_cpu->as, addr,
+                                     MEMTXATTRS_UNSPECIFIED, &data, 2);
             value = tswap16(data);
         } else if (words[0][4] == 'l') {
             uint32_t data;
-            address_space_read(first_cpu->as, addr, MEMTXATTRS_UNSPECIFIED,
-                               &data, 4);
+            ret = address_space_read(first_cpu->as, addr,
+                                     MEMTXATTRS_UNSPECIFIED, &data, 4);
             value = tswap32(data);
         } else if (words[0][4] == 'q') {
-            address_space_read(first_cpu->as, addr, MEMTXATTRS_UNSPECIFIED,
-                               &value, 8);
+            ret = address_space_read(first_cpu->as, addr,
+                                     MEMTXATTRS_UNSPECIFIED, &value, 8);
             tswap64s(&value);
         }
         qtest_send_prefix(chr);
-        qtest_sendf(chr, "OK 0x%016" PRIx64 "\n", value);
+        if (ret == MEMTX_OK) {
+            qtest_sendf(chr, "OK 0x%016" PRIx64 "\n", value);
+        } else {
+            qtest_sendf(chr, "FAIL\n");
+        }
     } else if (strcmp(words[0], "read") == 0) {
         g_autoptr(GString) enc = NULL;
         uint64_t addr, len;
diff --git a/tests/qtest/libqtest.c b/tests/qtest/libqtest.c
index 9d07de1fbd..4055d6b953 100644
--- a/tests/qtest/libqtest.c
+++ b/tests/qtest/libqtest.c
@@ -666,7 +666,7 @@ static GString *qtest_client_socket_recv_line(QTestState *s)
     return line;
 }
 
-static gchar **qtest_rsp_args(QTestState *s, int expected_args)
+static gchar **_qtest_rsp_args(QTestState *s, int expected_args, bool fail)
 {
     GString *line;
     gchar **words;
@@ -700,7 +700,11 @@ redo:
     }
 
     g_assert(words[0] != NULL);
-    g_assert_cmpstr(words[0], ==, "OK");
+    if (fail) {
+        g_assert_cmpstr(words[0], ==, "FAIL");
+    } else {
+        g_assert_cmpstr(words[0], ==, "OK");
+    }
 
     for (i = 0; i < expected_args; i++) {
         g_assert(words[i] != NULL);
@@ -709,6 +713,11 @@ redo:
     return words;
 }
 
+static gchar **qtest_rsp_args(QTestState *s, int expected_args)
+{
+    return _qtest_rsp_args(s, expected_args, false);
+}
+
 static void qtest_rsp(QTestState *s)
 {
     gchar **words = qtest_rsp_args(s, 0);
@@ -716,6 +725,13 @@ static void qtest_rsp(QTestState *s)
     g_strfreev(words);
 }
 
+static void qtest_rsp_fail(QTestState *s)
+{
+    gchar **words = _qtest_rsp_args(s, 0, true);
+
+    g_strfreev(words);
+}
+
 static int qtest_query_target_endianness(QTestState *s)
 {
     gchar **args;
@@ -1103,6 +1119,13 @@ static void qtest_write(QTestState *s, const char *cmd, uint64_t addr,
     qtest_rsp(s);
 }
 
+static void qtest_write_fail(QTestState *s, const char *cmd, uint64_t addr,
+                             uint64_t value)
+{
+    qtest_sendf(s, "%s 0x%" PRIx64 " 0x%" PRIx64 "\n", cmd, addr, value);
+    qtest_rsp_fail(s);
+}
+
 void qtest_writeb(QTestState *s, uint64_t addr, uint8_t value)
 {
     qtest_write(s, "writeb", addr, value);
@@ -1123,6 +1146,26 @@ void qtest_writeq(QTestState *s, uint64_t addr, uint64_t value)
     qtest_write(s, "writeq", addr, value);
 }
 
+void qtest_writeb_fail(QTestState *s, uint64_t addr, uint8_t value)
+{
+    qtest_write_fail(s, "writeb", addr, value);
+}
+
+void qtest_writew_fail(QTestState *s, uint64_t addr, uint16_t value)
+{
+    qtest_write_fail(s, "writew", addr, value);
+}
+
+void qtest_writel_fail(QTestState *s, uint64_t addr, uint32_t value)
+{
+    qtest_write_fail(s, "writel", addr, value);
+}
+
+void qtest_writeq_fail(QTestState *s, uint64_t addr, uint64_t value)
+{
+    qtest_write_fail(s, "writeq", addr, value);
+}
+
 static uint64_t qtest_read(QTestState *s, const char *cmd, uint64_t addr)
 {
     gchar **args;
@@ -1138,6 +1181,12 @@ static uint64_t qtest_read(QTestState *s, const char *cmd, uint64_t addr)
     return value;
 }
 
+static void qtest_read_fail(QTestState *s, const char *cmd, uint64_t addr)
+{
+    qtest_sendf(s, "%s 0x%" PRIx64 "\n", cmd, addr);
+    qtest_rsp_fail(s);
+}
+
 uint8_t qtest_readb(QTestState *s, uint64_t addr)
 {
     return qtest_read(s, "readb", addr);
@@ -1158,6 +1207,26 @@ uint64_t qtest_readq(QTestState *s, uint64_t addr)
     return qtest_read(s, "readq", addr);
 }
 
+void qtest_readb_fail(QTestState *s, uint64_t addr)
+{
+    qtest_read_fail(s, "readb", addr);
+}
+
+void qtest_readw_fail(QTestState *s, uint64_t addr)
+{
+    qtest_read_fail(s, "readw", addr);
+}
+
+void qtest_readl_fail(QTestState *s, uint64_t addr)
+{
+    qtest_read_fail(s, "readl", addr);
+}
+
+void qtest_readq_fail(QTestState *s, uint64_t addr)
+{
+    qtest_read(s, "readq", addr);
+}
+
 static int hex2nib(char ch)
 {
     if (ch >= '0' && ch <= '9') {
-- 
2.47.0.rc0.187.ge670bccf7e-goog


