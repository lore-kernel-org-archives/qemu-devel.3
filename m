Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6407AC2BD05
	for <qemu-devel@archiver.kernel.org>; Mon, 24 Jun 2024 05:34:04 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sLcIa-000347-HI; Mon, 24 Jun 2024 01:31:28 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <gustavo.romero@linaro.org>)
 id 1sLcIS-00032q-RU
 for qemu-devel@nongnu.org; Mon, 24 Jun 2024 01:31:22 -0400
Received: from mail-pf1-x436.google.com ([2607:f8b0:4864:20::436])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <gustavo.romero@linaro.org>)
 id 1sLcIQ-0004aO-9b
 for qemu-devel@nongnu.org; Mon, 24 Jun 2024 01:31:20 -0400
Received: by mail-pf1-x436.google.com with SMTP id
 d2e1a72fcca58-70666aceb5bso1219084b3a.1
 for <qemu-devel@nongnu.org>; Sun, 23 Jun 2024 22:31:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1719207076; x=1719811876; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=fV2Lm6jWmJZV5HP3sflY623iLhWfKTN1g+jJJledmtw=;
 b=hvUuXYeNpOtc9S0ScjzxN3l3PDXmTzW6JqkIQCEPvBAmudNIWp64O4Nr3jB5QmsBxL
 mxPnad3COWDLTaglSGL4N5vKiYG1XAQLyqJQX0bOgQOV4senEFUyyPl1YHAlJDAA5gr8
 ZANuiN8YGbWjBJyCMGYTA+blxsHsCd+nIO2Pbh7joVTGWO5rjeVkDnuNRhXjpXsrI5Is
 PnEO+C181EfxgJCbMSHxGhHRnOZfNc667+MOkF6UhPFXzAlwi5GAJ/aKfWLKnOz/+w7V
 OWHRr2oRTsu9WwctXz2F3//8XJubDXNzpf99jUKuRxI5144+9H3hQV32CbRyCUewFJXb
 9nAg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1719207076; x=1719811876;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=fV2Lm6jWmJZV5HP3sflY623iLhWfKTN1g+jJJledmtw=;
 b=GkfM8lxC41eaBMPT2pWROyMLJQKFvRb52+79PiRfNDsigNL1XPOjFY2BuuNyXxgBhK
 +/opidMPySOjxe8nKug1DTVd7pbUiASe5rGhcfUnVLJBFCAlXuVi+jweJXK4nyTjNf5w
 IWi+GIdrnseB5ERL12Zh0dJMP0+kJUJoYCDmDdomIteoo6ehBhcsAHJykcj0eFU6kRQv
 449QLBFALdp/USLttjW8uWswgFhu6pDjc6W2GKj7uABXu0EU/rN+Pz16pxtRwDgy590G
 lBmjfXcvNjc7QN2bbqKv3NoO+b3xZsbL3bpUO/FqN3M2eAjP3osR9DeNiQQQWwitCyF6
 QUFw==
X-Gm-Message-State: AOJu0Yxjnm7jxRxndFiLNtjCTH4BUOf7tSF9CV6P6JZLMpsklsxQxkVk
 GwyNtNI3dfDRw31uimn/ntE31B7yjSbpzCpZMlRV224mNKY90km7+5klonshQcpE2Hf+VXTQFTz
 ZDo4=
X-Google-Smtp-Source: AGHT+IGiBfCHLjPlEcxsoo8UUuarMpNJq/8Kw+2A9pnmMLTXmavpXdM4SjAjf8aOVno7Vg14ogjD3Q==
X-Received: by 2002:a05:6a00:80f2:b0:706:5c14:29b4 with SMTP id
 d2e1a72fcca58-7067473fc66mr3188497b3a.32.1719207076409; 
 Sun, 23 Jun 2024 22:31:16 -0700 (PDT)
Received: from amd.. ([2804:7f0:b401:1758:3e7c:3fff:fe7a:e83b])
 by smtp.gmail.com with ESMTPSA id
 41be03b00d2f7-716b4a73183sm3953601a12.39.2024.06.23.22.31.13
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 23 Jun 2024 22:31:15 -0700 (PDT)
From: Gustavo Romero <gustavo.romero@linaro.org>
To: qemu-devel@nongnu.org, alex.bennee@linaro.org, richard.henderson@linaro.org
Cc: philmd@linaro.org,
	peter.maydell@linaro.org,
	gustavo.romero@linaro.org
Subject: [PATCH v4 3/9] gdbstub: Add support for target-specific stubs
Date: Mon, 24 Jun 2024 05:30:40 +0000
Message-Id: <20240624053046.221802-4-gustavo.romero@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240624053046.221802-1-gustavo.romero@linaro.org>
References: <20240624053046.221802-1-gustavo.romero@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::436;
 envelope-from=gustavo.romero@linaro.org; helo=mail-pf1-x436.google.com
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

Currently, it's not possible to have stubs specific to a given target,
even though there are GDB features which are target-specific, like, for
instance, memory tagging.

This commit introduces gdb_extend_qsupported_features,
gdb_extend_query_table, and gdb_extend_set_table functions as interfaces
to extend the qSupported string, the query handler table, and the set
handler table, allowing target-specific stub implementations.

Signed-off-by: Gustavo Romero <gustavo.romero@linaro.org>
Reviewed-by: Alex Bennée <alex.bennee@linaro.org>
---
 gdbstub/gdbstub.c          | 102 ++++++++++++++++++++++++++++++++++---
 include/gdbstub/commands.h |  22 ++++++++
 2 files changed, 118 insertions(+), 6 deletions(-)

diff --git a/gdbstub/gdbstub.c b/gdbstub/gdbstub.c
index 9ff2f4177d..b1ca253f97 100644
--- a/gdbstub/gdbstub.c
+++ b/gdbstub/gdbstub.c
@@ -1609,6 +1609,20 @@ static void handle_query_thread_extra(GArray *params, void *user_ctx)
     gdb_put_strbuf();
 }
 
+static char *extended_qsupported_features;
+void gdb_extend_qsupported_features(char *qsupported_features)
+{
+    /*
+     * We don't support different sets of CPU gdb features on different CPUs yet
+     * so assert the feature strings are the same on all CPUs, or is set only
+     * once (1 CPU).
+     */
+    g_assert(extended_qsupported_features == NULL ||
+             g_strcmp0(extended_qsupported_features, qsupported_features) == 0);
+
+    extended_qsupported_features = qsupported_features;
+}
+
 static void handle_query_supported(GArray *params, void *user_ctx)
 {
     CPUClass *cc;
@@ -1648,6 +1662,11 @@ static void handle_query_supported(GArray *params, void *user_ctx)
     }
 
     g_string_append(gdbserver_state.str_buf, ";vContSupported+;multiprocess+");
+
+    if (extended_qsupported_features) {
+        g_string_append(gdbserver_state.str_buf, extended_qsupported_features);
+    }
+
     gdb_put_strbuf();
 }
 
@@ -1729,6 +1748,41 @@ static const GdbCmdParseEntry gdb_gen_query_set_common_table[] = {
     },
 };
 
+/* Compares if a set of command parsers is equal to another set of parsers. */
+static bool cmp_cmds(GdbCmdParseEntry *c, GdbCmdParseEntry *d, int size)
+{
+    for (int i = 0; i < size; i++) {
+        if (!(c[i].handler == d[i].handler &&
+            g_strcmp0(c[i].cmd, d[i].cmd) == 0 &&
+            c[i].cmd_startswith == d[i].cmd_startswith &&
+            g_strcmp0(c[i].schema, d[i].schema) == 0)) {
+
+            /* Sets are different. */
+            return false;
+        }
+    }
+
+    /* Sets are equal, i.e. contain the same command parsers. */
+    return true;
+}
+
+static GdbCmdParseEntry *extended_query_table;
+static int extended_query_table_size;
+void gdb_extend_query_table(GdbCmdParseEntry *table, int size)
+{
+    /*
+     * We don't support different sets of CPU gdb features on different CPUs yet
+     * so assert query table is the same on all CPUs, or is set only once
+     * (1 CPU).
+     */
+    g_assert(extended_query_table == NULL ||
+             (extended_query_table_size == size &&
+              cmp_cmds(extended_query_table, table, size)));
+
+    extended_query_table = table;
+    extended_query_table_size = size;
+}
+
 static const GdbCmdParseEntry gdb_gen_query_table[] = {
     {
         .handler = handle_query_curr_tid,
@@ -1821,6 +1875,22 @@ static const GdbCmdParseEntry gdb_gen_query_table[] = {
 #endif
 };
 
+static GdbCmdParseEntry *extended_set_table;
+static int extended_set_table_size;
+void gdb_extend_set_table(GdbCmdParseEntry *table, int size)
+{
+    /*
+     * We don't support different sets of CPU gdb features on different CPUs yet
+     * so assert set table is the same on all CPUs, or is set only once (1 CPU).
+     */
+    g_assert(extended_set_table == NULL ||
+             (extended_set_table_size == size &&
+              cmp_cmds(extended_set_table, table, size)));
+
+    extended_set_table = table;
+    extended_set_table_size = size;
+}
+
 static const GdbCmdParseEntry gdb_gen_set_table[] = {
     /* Order is important if has same prefix */
     {
@@ -1859,11 +1929,21 @@ static void handle_gen_query(GArray *params, void *user_ctx)
         return;
     }
 
-    if (!process_string_cmd(gdb_get_cmd_param(params, 0)->data,
-                            gdb_gen_query_table,
-                            ARRAY_SIZE(gdb_gen_query_table))) {
-        gdb_put_packet("");
+    if (process_string_cmd(gdb_get_cmd_param(params, 0)->data,
+                           gdb_gen_query_table,
+                           ARRAY_SIZE(gdb_gen_query_table))) {
+        return;
+    }
+
+    if (extended_query_table &&
+        process_string_cmd(gdb_get_cmd_param(params, 0)->data,
+                           extended_query_table,
+                           extended_query_table_size)) {
+        return;
     }
+
+    /* Can't handle query, return Empty response. */
+    gdb_put_packet("");
 }
 
 static void handle_gen_set(GArray *params, void *user_ctx)
@@ -1878,11 +1958,21 @@ static void handle_gen_set(GArray *params, void *user_ctx)
         return;
     }
 
-    if (!process_string_cmd(gdb_get_cmd_param(params, 0)->data,
+    if (process_string_cmd(gdb_get_cmd_param(params, 0)->data,
                            gdb_gen_set_table,
                            ARRAY_SIZE(gdb_gen_set_table))) {
-        gdb_put_packet("");
+        return;
     }
+
+    if (extended_set_table &&
+        process_string_cmd(gdb_get_cmd_param(params, 0)->data,
+                           extended_set_table,
+                           extended_set_table_size)) {
+        return;
+    }
+
+    /* Can't handle set, return Empty response. */
+    gdb_put_packet("");
 }
 
 static void handle_target_halt(GArray *params, void *user_ctx)
diff --git a/include/gdbstub/commands.h b/include/gdbstub/commands.h
index dd45c38472..2204c3ddbe 100644
--- a/include/gdbstub/commands.h
+++ b/include/gdbstub/commands.h
@@ -71,4 +71,26 @@ typedef struct GdbCmdParseEntry {
  */
 int gdb_put_packet(const char *buf);
 
+/**
+ * gdb_extend_query_table() - Extend query table.
+ * @table: The table with the additional query packet handlers.
+ * @size: The number of handlers to be added.
+ */
+void gdb_extend_query_table(GdbCmdParseEntry *table, int size);
+
+/**
+ * gdb_extend_set_table() - Extend set table.
+ * @table: The table with the additional set packet handlers.
+ * @size: The number of handlers to be added.
+ */
+void gdb_extend_set_table(GdbCmdParseEntry *table, int size);
+
+/**
+ * gdb_extend_qsupported_features() - Extend the qSupported features string.
+ * @qsupported_features: The additional qSupported feature(s) string. The string
+ * should start with a semicolon and, if there are more than one feature, the
+ * features should be separate by a semiocolon.
+ */
+void gdb_extend_qsupported_features(char *qsupported_features);
+
 #endif /* GDBSTUB_COMMANDS_H */
-- 
2.34.1


