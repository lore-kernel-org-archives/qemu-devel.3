Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F2FDEC25B75
	for <qemu-devel@archiver.kernel.org>; Wed, 15 May 2024 17:33:07 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s7IUR-0005EX-U2; Wed, 15 May 2024 13:32:31 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <gustavo.romero@linaro.org>)
 id 1s7IUK-0005DH-Pk
 for qemu-devel@nongnu.org; Wed, 15 May 2024 13:32:25 -0400
Received: from mail-pf1-x430.google.com ([2607:f8b0:4864:20::430])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <gustavo.romero@linaro.org>)
 id 1s7IUI-0002Dx-Hv
 for qemu-devel@nongnu.org; Wed, 15 May 2024 13:32:24 -0400
Received: by mail-pf1-x430.google.com with SMTP id
 d2e1a72fcca58-6f44a2d1e3dso6399542b3a.3
 for <qemu-devel@nongnu.org>; Wed, 15 May 2024 10:32:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1715794341; x=1716399141; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=vcj2Py+dn09bF4yGtRILmfWfVgmwYYBz6rwT+Eir1qs=;
 b=yoF98k5kBwun4mRCDD19bMLP9gsEiSB6KjA0ciBYFODMVrGhN45tk+aKizre2PEFtj
 IAvX9gfDx7Q/M8Ka3WLRGFSP3pvkUVGHbplg0p4nHC2vRfAJDIfslMOEQrkgl/KCFX38
 d7KCKpK64AbqVJR6LEtdQkE3DOwhDTdkNsSkANg7+z25v8Y8y9ntoBxhitWvXd3AX+4D
 8a20W3erWbX4yIsKjd8SwKQsVq5sfWYzIhoplEPfWrqVJLJBGPtTsm8VWevr3UxDKDsu
 CBFeybe0Drwm7fkZd79J2I2U9FshXB8rZlf2lK/Ol/3smu3ouSTyGHzXqYQiX19zAV/3
 q+Xg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1715794341; x=1716399141;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=vcj2Py+dn09bF4yGtRILmfWfVgmwYYBz6rwT+Eir1qs=;
 b=doI9cMeRPvrGN8GfdpAtNWMLj7Se5Wyp1CXaeFkFAonUdcqVvlTaAMXVb0ZXhwSUKZ
 wYatuCU4c4fDRytmaKxoTvY8ZjQethDDc+UxY+Tl0WEqQWsIQwGFusQZrT6092wz1hou
 n7iMPQ1JNIH+sYTfx4kwGz31dHX6WOTjzzG3BKpdiEpWeRNwX9xRmNXLWrLZa5xMwSjL
 rzDQUgCSX5E8PLQNrjAG6XWluZw2WvenazTmYwcPDVahgNGSEcRDej7TCDP62kmBb42q
 PGl0ft3nR7S+t1Ho6Vw1T+Teg6zZ8sLLIpNV+lSm9SBRv2DssGSQPcunRHr0wSdPCvMF
 l7Sw==
X-Gm-Message-State: AOJu0YxLu9gba6oO69UDxeW2nj6hvrxPFWpWcbcZAhv1DO+E9AfLzfb9
 0oILH0XkhrYqvTwDq8NwnUsT3XYkB30vcIkZu+yJJDvZi88i5WTyQMQrFW9xme7T0EHd6JdQCFt
 ge+g=
X-Google-Smtp-Source: AGHT+IEDkHDCKafzHLNZkL0ho5FbmdMhCQOpDkgzzOTLQyfGrDcY9VG2mrqDiRiYeIoY4VQ+tQ2YMg==
X-Received: by 2002:a05:6a20:430e:b0:1af:dd77:86ab with SMTP id
 adf61e73a8af0-1afde1faeadmr16681248637.54.1715794340627; 
 Wed, 15 May 2024 10:32:20 -0700 (PDT)
Received: from amd.. ([2804:7f0:b401:224b:3e7c:3fff:fe7a:e83b])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-6f4d2a66c6asm11365133b3a.6.2024.05.15.10.32.18
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 15 May 2024 10:32:20 -0700 (PDT)
From: Gustavo Romero <gustavo.romero@linaro.org>
To: qemu-devel@nongnu.org, philmd@linaro.org, peter.maydell@linaro.org,
 alex.bennee@linaro.org, richard.henderson@linaro.org
Cc: gustavo.romero@linaro.org
Subject: [PATCH 1/4] gdbstub: Add support for target-specific stubs
Date: Wed, 15 May 2024 17:31:29 +0000
Message-Id: <20240515173132.2462201-2-gustavo.romero@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240515173132.2462201-1-gustavo.romero@linaro.org>
References: <20240515173132.2462201-1-gustavo.romero@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::430;
 envelope-from=gustavo.romero@linaro.org; helo=mail-pf1-x430.google.com
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

This commit introduces set_query_supported_arch,
set_gdb_gen_query_table_arch, and set_gdb_gen_set_table_arch functions
as interfaces to extend the qSupported string, the query handler table,
and set handler table per target, so allowing target-specific stub
implementation.

Besides that, it moves GdbCmdParseEntry struct, its related types, and
gdb_put_packet to include/exec/gdbstub.h so they are also available in
the target-specific stubs.

Signed-off-by: Gustavo Romero <gustavo.romero@linaro.org>
---
 gdbstub/gdbstub.c      | 108 +++++++++++++++++++++++------------------
 gdbstub/internals.h    |  22 ---------
 gdbstub/syscalls.c     |   1 +
 include/exec/gdbstub.h |  86 +++++++++++++++++++++++++++++++-
 4 files changed, 147 insertions(+), 70 deletions(-)

diff --git a/gdbstub/gdbstub.c b/gdbstub/gdbstub.c
index b3574997ea..4996530fde 100644
--- a/gdbstub/gdbstub.c
+++ b/gdbstub/gdbstub.c
@@ -920,43 +920,6 @@ static int cmd_parse_params(const char *data, const char *schema,
     return 0;
 }
 
-typedef void (*GdbCmdHandler)(GArray *params, void *user_ctx);
-
-/*
- * cmd_startswith -> cmd is compared using startswith
- *
- * allow_stop_reply -> true iff the gdbstub can respond to this command with a
- *   "stop reply" packet. The list of commands that accept such response is
- *   defined at the GDB Remote Serial Protocol documentation. see:
- *   https://sourceware.org/gdb/onlinedocs/gdb/Stop-Reply-Packets.html#Stop-Reply-Packets.
- *
- * schema definitions:
- * Each schema parameter entry consists of 2 chars,
- * the first char represents the parameter type handling
- * the second char represents the delimiter for the next parameter
- *
- * Currently supported schema types:
- * 'l' -> unsigned long (stored in .val_ul)
- * 'L' -> unsigned long long (stored in .val_ull)
- * 's' -> string (stored in .data)
- * 'o' -> single char (stored in .opcode)
- * 't' -> thread id (stored in .thread_id)
- * '?' -> skip according to delimiter
- *
- * Currently supported delimiters:
- * '?' -> Stop at any delimiter (",;:=\0")
- * '0' -> Stop at "\0"
- * '.' -> Skip 1 char unless reached "\0"
- * Any other value is treated as the delimiter value itself
- */
-typedef struct GdbCmdParseEntry {
-    GdbCmdHandler handler;
-    const char *cmd;
-    bool cmd_startswith;
-    const char *schema;
-    bool allow_stop_reply;
-} GdbCmdParseEntry;
-
 static inline int startswith(const char *string, const char *pattern)
 {
   return !strncmp(string, pattern, strlen(pattern));
@@ -1645,6 +1608,13 @@ static void handle_query_thread_extra(GArray *params, void *user_ctx)
     gdb_put_strbuf();
 }
 
+/* Arch-specific qSupported */
+char *query_supported_arch = NULL;
+void set_query_supported_arch(char *query_supported)
+{
+    query_supported_arch = query_supported;
+}
+
 static void handle_query_supported(GArray *params, void *user_ctx)
 {
     CPUClass *cc;
@@ -1684,6 +1654,11 @@ static void handle_query_supported(GArray *params, void *user_ctx)
     }
 
     g_string_append(gdbserver_state.str_buf, ";vContSupported+;multiprocess+");
+
+    if (query_supported_arch) {
+        g_string_append(gdbserver_state.str_buf, query_supported_arch);
+    }
+
     gdb_put_strbuf();
 }
 
@@ -1765,6 +1740,16 @@ static const GdbCmdParseEntry gdb_gen_query_set_common_table[] = {
     },
 };
 
+
+/* Arch-specific query table */
+static GdbCmdParseEntry *gdb_gen_query_table_arch = NULL ;
+static int gdb_gen_query_table_arch_size = 0;
+void set_gdb_gen_query_table_arch(GdbCmdParseEntry  *table, int size)
+{
+    gdb_gen_query_table_arch = table;
+    gdb_gen_query_table_arch_size = size;
+}
+
 static const GdbCmdParseEntry gdb_gen_query_table[] = {
     {
         .handler = handle_query_curr_tid,
@@ -1857,6 +1842,15 @@ static const GdbCmdParseEntry gdb_gen_query_table[] = {
 #endif
 };
 
+/* Arch-specific set table */
+static GdbCmdParseEntry *gdb_gen_set_table_arch = NULL;
+static int gdb_gen_set_table_arch_size = 0;
+void set_gdb_gen_set_table_arch(GdbCmdParseEntry *table, int size)
+{
+    gdb_gen_set_table_arch = table;
+    gdb_gen_set_table_arch_size = size;
+}
+
 static const GdbCmdParseEntry gdb_gen_set_table[] = {
     /* Order is important if has same prefix */
     {
@@ -1889,17 +1883,27 @@ static void handle_gen_query(GArray *params, void *user_ctx)
         return;
     }
 
-    if (!process_string_cmd(get_param(params, 0)->data,
-                            gdb_gen_query_set_common_table,
-                            ARRAY_SIZE(gdb_gen_query_set_common_table))) {
+    if (process_string_cmd(get_param(params, 0)->data,
+                           gdb_gen_query_set_common_table,
+                           ARRAY_SIZE(gdb_gen_query_set_common_table)) == 0) {
         return;
     }
 
     if (process_string_cmd(get_param(params, 0)->data,
                            gdb_gen_query_table,
-                           ARRAY_SIZE(gdb_gen_query_table))) {
-        gdb_put_packet("");
+                           ARRAY_SIZE(gdb_gen_query_table)) == 0) {
+        return;
     }
+
+    if (gdb_gen_query_table_arch &&
+        process_string_cmd(get_param(params, 0)->data,
+                           gdb_gen_query_table_arch,
+                           gdb_gen_query_table_arch_size) == 0) {
+        return;
+    }
+
+    /* Can't handle query, return Empty response. */
+    gdb_put_packet("");
 }
 
 static void handle_gen_set(GArray *params, void *user_ctx)
@@ -1908,17 +1912,27 @@ static void handle_gen_set(GArray *params, void *user_ctx)
         return;
     }
 
-    if (!process_string_cmd(get_param(params, 0)->data,
-                            gdb_gen_query_set_common_table,
-                            ARRAY_SIZE(gdb_gen_query_set_common_table))) {
+    if (process_string_cmd(get_param(params, 0)->data,
+                           gdb_gen_query_set_common_table,
+                           ARRAY_SIZE(gdb_gen_query_set_common_table)) == 0) {
         return;
     }
 
     if (process_string_cmd(get_param(params, 0)->data,
                            gdb_gen_set_table,
-                           ARRAY_SIZE(gdb_gen_set_table))) {
-        gdb_put_packet("");
+                           ARRAY_SIZE(gdb_gen_set_table)) == 0) {
+        return;
     }
+
+    if (gdb_gen_set_table_arch &&
+        process_string_cmd(get_param(params, 0)->data,
+                           gdb_gen_set_table_arch,
+                           gdb_gen_set_table_arch_size) == 0) {
+        return;
+    }
+
+    /* Can't handle set, return Empty response. */
+    gdb_put_packet("");
 }
 
 static void handle_target_halt(GArray *params, void *user_ctx)
diff --git a/gdbstub/internals.h b/gdbstub/internals.h
index 32f9f63297..34121dc61a 100644
--- a/gdbstub/internals.h
+++ b/gdbstub/internals.h
@@ -106,7 +106,6 @@ static inline int tohex(int v)
  */
 
 void gdb_put_strbuf(void);
-int gdb_put_packet(const char *buf);
 int gdb_put_packet_binary(const char *buf, int len, bool dump);
 void gdb_hextomem(GByteArray *mem, const char *buf, int len);
 void gdb_memtohex(GString *buf, const uint8_t *mem, int len);
@@ -166,27 +165,6 @@ void gdb_put_buffer(const uint8_t *buf, int len);
  */
 void gdb_init_gdbserver_state(void);
 
-typedef enum GDBThreadIdKind {
-    GDB_ONE_THREAD = 0,
-    GDB_ALL_THREADS,     /* One process, all threads */
-    GDB_ALL_PROCESSES,
-    GDB_READ_THREAD_ERR
-} GDBThreadIdKind;
-
-typedef union GdbCmdVariant {
-    const char *data;
-    uint8_t opcode;
-    unsigned long val_ul;
-    unsigned long long val_ull;
-    struct {
-        GDBThreadIdKind kind;
-        uint32_t pid;
-        uint32_t tid;
-    } thread_id;
-} GdbCmdVariant;
-
-#define get_param(p, i)    (&g_array_index(p, GdbCmdVariant, i))
-
 void gdb_handle_query_rcmd(GArray *params, void *ctx); /* system */
 void gdb_handle_query_offsets(GArray *params, void *user_ctx); /* user */
 void gdb_handle_query_xfer_auxv(GArray *params, void *user_ctx); /*user */
diff --git a/gdbstub/syscalls.c b/gdbstub/syscalls.c
index 02e3a8f74c..ee9a16495e 100644
--- a/gdbstub/syscalls.c
+++ b/gdbstub/syscalls.c
@@ -18,6 +18,7 @@
 #include "gdbstub/syscalls.h"
 #include "trace.h"
 #include "internals.h"
+#include "exec/gdbstub.h"
 
 /* Syscall specific state */
 typedef struct {
diff --git a/include/exec/gdbstub.h b/include/exec/gdbstub.h
index eb14b91139..7bf189d7f3 100644
--- a/include/exec/gdbstub.h
+++ b/include/exec/gdbstub.h
@@ -144,4 +144,88 @@ void gdb_set_stop_cpu(CPUState *cpu);
 /* in gdbstub-xml.c, generated by scripts/feature_to_c.py */
 extern const GDBFeature gdb_static_features[];
 
-#endif
+typedef void (*GdbCmdHandler)(GArray *params, void *user_ctx);
+
+typedef enum GDBThreadIdKind {
+    GDB_ONE_THREAD = 0,
+    GDB_ALL_THREADS,     /* One process, all threads */
+    GDB_ALL_PROCESSES,
+    GDB_READ_THREAD_ERR
+} GDBThreadIdKind;
+
+typedef union GdbCmdVariant {
+    const char *data;
+    uint8_t opcode;
+    unsigned long val_ul;
+    unsigned long long val_ull;
+    struct {
+        GDBThreadIdKind kind;
+        uint32_t pid;
+        uint32_t tid;
+    } thread_id;
+} GdbCmdVariant;
+
+#define get_param(p, i)    (&g_array_index(p, GdbCmdVariant, i))
+
+/*
+ * cmd_startswith -> cmd is compared using startswith
+ *
+ * allow_stop_reply -> true iff the gdbstub can respond to this command with a
+ *   "stop reply" packet. The list of commands that accept such response is
+ *   defined at the GDB Remote Serial Protocol documentation. see:
+ *   https://sourceware.org/gdb/onlinedocs/gdb/Stop-Reply-Packets.html#Stop-Reply-Packets.
+ *
+ * schema definitions:
+ * Each schema parameter entry consists of 2 chars,
+ * the first char represents the parameter type handling
+ * the second char represents the delimiter for the next parameter
+ *
+ * Currently supported schema types:
+ * 'l' -> unsigned long (stored in .val_ul)
+ * 'L' -> unsigned long long (stored in .val_ull)
+ * 's' -> string (stored in .data)
+ * 'o' -> single char (stored in .opcode)
+ * 't' -> thread id (stored in .thread_id)
+ * '?' -> skip according to delimiter
+ *
+ * Currently supported delimiters:
+ * '?' -> Stop at any delimiter (",;:=\0")
+ * '0' -> Stop at "\0"
+ * '.' -> Skip 1 char unless reached "\0"
+ * Any other value is treated as the delimiter value itself
+ */
+typedef struct GdbCmdParseEntry {
+    GdbCmdHandler handler;
+    const char *cmd;
+    bool cmd_startswith;
+    const char *schema;
+    bool allow_stop_reply;
+} GdbCmdParseEntry;
+
+#define get_cmd_parsers(p) (&g_array_index(p, GdbCmdParseEntry, 0))
+
+/**
+ * set_gdb_gen_query_table_arch() - set a table to handle arch-specific query
+ * packets
+ */
+void set_gdb_gen_query_table_arch(GdbCmdParseEntry *table, int size);
+
+/**
+ * set_gdb_gen_set_table_arch() - set a table to handle arch-specific set
+ * packets
+ */
+void set_gdb_gen_set_table_arch(GdbCmdParseEntry *, int size);
+
+/**
+ * set_query_supported_arch() - set arch-specific features in qSupported
+ * features
+ */
+void set_query_supported_arch(char *);
+
+/**
+ * gdb_put_packet() - put string into gdb server's buffer so it is sent
+ * to the client
+ */
+int gdb_put_packet(const char *buf);
+
+#endif /* GDBSTUB_H */
-- 
2.34.1


