Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 27EE3CDD553
	for <qemu-devel@archiver.kernel.org>; Wed, 18 Sep 2024 19:26:01 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sr0H3-0005ua-RB; Wed, 18 Sep 2024 15:23:37 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from
 <3rSjrZgUKCugdKfSZQYYQVO.MYWaOWe-NOfOVXYXQXe.YbQ@flex--tavip.bounces.google.com>)
 id 1sr0Gz-0005e0-Ty
 for qemu-devel@nongnu.org; Wed, 18 Sep 2024 15:23:34 -0400
Received: from mail-pg1-x549.google.com ([2607:f8b0:4864:20::549])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from
 <3rSjrZgUKCugdKfSZQYYQVO.MYWaOWe-NOfOVXYXQXe.YbQ@flex--tavip.bounces.google.com>)
 id 1sr0Gw-0007OI-SN
 for qemu-devel@nongnu.org; Wed, 18 Sep 2024 15:23:33 -0400
Received: by mail-pg1-x549.google.com with SMTP id
 41be03b00d2f7-7db0c10238eso243a12.1
 for <qemu-devel@nongnu.org>; Wed, 18 Sep 2024 12:23:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=google.com; s=20230601; t=1726687407; x=1727292207; darn=nongnu.org;
 h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
 :date:from:to:cc:subject:date:message-id:reply-to;
 bh=zkqCq3UBOk2L0o2tmmbXwYQ/qvmJvwtlw+/zSEQNzWA=;
 b=GUrodj3Ss+XC+4y9ux3iEhUWHNcJXyTpCK2grQI8ff/c23if+7QzZU7EAeU4gP0Slp
 MdRwZX8bWFQUsFEmxcPDud1pihuN59DZc0OXzE+xjTgXIWhIFwmIPDh0WclGbeZdwa2R
 o9QZE/KjpBcOOjYr/u976y+8ctPch2MTH603Mtcus/TapkgrHIfSFIkVV7EyJ1Abr3pY
 5NBvZhHLF4eQ5EsPzpaZfR3QfKTeix6p9D3kMwDsFo12fobwVBITCWlXjxTJfjzSi96B
 k4a9U/KUSkwVL5wKqMS0eBIjClHQu5RdE81/gm4IpAzFA/P+rW8JSRuTeyoRu5xpACFg
 AXOA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1726687407; x=1727292207;
 h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
 :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=zkqCq3UBOk2L0o2tmmbXwYQ/qvmJvwtlw+/zSEQNzWA=;
 b=kFJIFj8eh5e0jUL6dkRWg6nxNK4ruwBHmFw8KS+JD7Pd12ROmwC5Yipb2t9PxP4Ns7
 6ViRZhhEcsn0k4XIxJzoMg/udoF+plGxsFpiPQq5Bx3clgBu8nhgnwPGl1iCrNDQhYWn
 pSMpSLZYt6uL24A1ritEgqHoOmVneyKB6uHeSWQAsoGGdyhCedlZGzWqrcVR4eKZGwHM
 ohcJNoh8XDBqenlsqeWBgpHacwIROncqJrwrjChyAkJmVIiaX6T9N0/Y8n5/XHxRr/p2
 51fygYM80Ajio00dOq72oQVqdtABFxlb/WEKFP1fEY/VLlgvcCEKBICL7ZNghc4DKHg7
 BTJA==
X-Gm-Message-State: AOJu0YzTkeK/2Mymrx9LMHrWBDUrbC+eOqKDEvQPn3fEt9YUPYEgseno
 fnoh9c8UMe3q2k41gxwix5zWKanTcmkZ6fknlG6pQzeRcS3Y1rXprAUdgPsjhCLYte4kV3KNQ9K
 HQKBViDtSzK0Mw5JnNwS6Ivsw2Olnkai3A308Pgtl3ninWOXadGpQesWCEn4KPCkADaF+yPLyl6
 YQfZld9MUFB8dsbFtNamywsLtyOQ==
X-Google-Smtp-Source: AGHT+IFFnTJnAHcDVQHG9k5Fbg6XW/RStSCi8m3xgHv3+kPEOAQhOeU6Mrf6t7YEgzR1PNAkRWCvKUqwvw==
X-Received: from warp10.c.googlers.com ([fda3:e722:ac3:cc00:24:72f4:c0a8:750])
 (user=tavip job=sendgmr) by 2002:a63:1916:0:b0:7a1:f561:8c99 with
 SMTP id
 41be03b00d2f7-7db2f8517dbmr37036a12.6.1726687405779; Wed, 18 Sep 2024
 12:23:25 -0700 (PDT)
Date: Wed, 18 Sep 2024 12:22:44 -0700
In-Reply-To: <20240918192254.3136903-1-tavip@google.com>
Mime-Version: 1.0
References: <20240918192254.3136903-1-tavip@google.com>
X-Mailer: git-send-email 2.46.0.662.g92d0881bb0-goog
Message-ID: <20240918192254.3136903-17-tavip@google.com>
Subject: [PATCH 16/25] system/qtest: add APIS to check for memory access
 failures
From: Octavian Purdila <tavip@google.com>
To: qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org, stefanst@google.com, pbonzini@redhat.com, 
 peter.maydell@linaro.org, marcandre.lureau@redhat.com, berrange@redhat.com, 
 eduardo@habkost.net, luc@lmichel.fr, damien.hedde@dahe.fr, 
 alistair@alistair23.me, thuth@redhat.com, philmd@linaro.org, jsnow@redhat.com, 
 crosa@redhat.com, lvivier@redhat.com
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::549;
 envelope-from=3rSjrZgUKCugdKfSZQYYQVO.MYWaOWe-NOfOVXYXQXe.YbQ@flex--tavip.bounces.google.com;
 helo=mail-pg1-x549.google.com
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
2.46.0.662.g92d0881bb0-goog


