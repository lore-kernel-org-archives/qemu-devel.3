Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BAC5FC2BD09
	for <qemu-devel@archiver.kernel.org>; Mon, 24 Jun 2024 05:34:02 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sLcIa-00033d-2L; Mon, 24 Jun 2024 01:31:28 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <gustavo.romero@linaro.org>)
 id 1sLcIR-00032W-6v
 for qemu-devel@nongnu.org; Mon, 24 Jun 2024 01:31:20 -0400
Received: from mail-oo1-xc2e.google.com ([2607:f8b0:4864:20::c2e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <gustavo.romero@linaro.org>)
 id 1sLcIN-0004aD-OK
 for qemu-devel@nongnu.org; Mon, 24 Jun 2024 01:31:18 -0400
Received: by mail-oo1-xc2e.google.com with SMTP id
 006d021491bc7-5b9776123a3so1776493eaf.0
 for <qemu-devel@nongnu.org>; Sun, 23 Jun 2024 22:31:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1719207073; x=1719811873; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=6Sf8/CZYkfq0TP6X1c0yibA0dD8nesLemm2CrbqDsi4=;
 b=QNDemYyzGDy/WnmXd+bYeLRTIZxGOyoNxy3//YW33+nzh5x4QRzGJaJZH4WpVc9trl
 XtWf6oQMWFaOEMX9Z0tJymNS5MWh7lE+26tAcXGqHG348Wp6fo59z0cshjoSFLo5CQSr
 TIHN4hZ46ZW9f5fn78lFRNTmChCAm+fKYyJsAKOJoIwAKtllDgyalkRi4W7ir39bTW+E
 k57jKoc7Hava9mTaN56JvEmILdtVkgI/B3knfx0zX/v1PKqeqCTcG/gpIUcU+/12ITLW
 NnomFDFS2XAu8P5hKfj6vun6Vy4sFmx8mUqVgXRDUwkOWrMd9tkq6xQk+ALb/D04/ThG
 NYpQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1719207073; x=1719811873;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=6Sf8/CZYkfq0TP6X1c0yibA0dD8nesLemm2CrbqDsi4=;
 b=MyyUewkpVrK80jW6Tr9OBtIqYbUYhiHMJnnjGwLIeAju6fMNuo+HrkdJcxWEfISZC2
 fUU9/sN2UpKqChq2SjuFYZ6aphur8Yp+GQKrTtNFj2QiQAJIVth3xAU7hBeXXU+hX4rs
 6QbYGDk4lThb0wIJ5AFy0IgsaFR0w7khRIpKdtahJmeHU8CrIbYlBHuu3qPmJ0jpP4kD
 5bV2Hid/g1Pc1GFNtGowPzkHjDMUZd7KpDbwHr2NP/iPDZxElmn9zEguKk7LoHuNehC6
 8iZULhIlxYkD2vDy4+mmOLRlU/v20DfC/ejd49aIricFK8FcgFc+CXLWjSuhr58cYqbZ
 QUgg==
X-Gm-Message-State: AOJu0YyOfaXJ17QpcYxdJLyWqvtlMD1cHJfY8YJI99WD45dUTe1Dvym/
 nSFfCgXwAYp3HRjGAC/uBQkuWRqbJkboq3m5ca2GG9f/tGBkOIAA2OrwI4SkTGMP/nqPOuULmxh
 /buA=
X-Google-Smtp-Source: AGHT+IF376CweXhOTTi1incOvo+/F1TDX9DQ8FPeNeIoJCzrwJ+mhHtRx4cCVuYbwhVo1cevJeC0gQ==
X-Received: by 2002:a05:6358:61cc:b0:19f:315e:c83 with SMTP id
 e5c5f4694b2df-1a23fbf03e9mr430259155d.2.1719207073284; 
 Sun, 23 Jun 2024 22:31:13 -0700 (PDT)
Received: from amd.. ([2804:7f0:b401:1758:3e7c:3fff:fe7a:e83b])
 by smtp.gmail.com with ESMTPSA id
 41be03b00d2f7-716b4a73183sm3953601a12.39.2024.06.23.22.31.10
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 23 Jun 2024 22:31:12 -0700 (PDT)
From: Gustavo Romero <gustavo.romero@linaro.org>
To: qemu-devel@nongnu.org, alex.bennee@linaro.org, richard.henderson@linaro.org
Cc: philmd@linaro.org,
	peter.maydell@linaro.org,
	gustavo.romero@linaro.org
Subject: [PATCH v4 2/9] gdbstub: Move GdbCmdParseEntry into a new header file
Date: Mon, 24 Jun 2024 05:30:39 +0000
Message-Id: <20240624053046.221802-3-gustavo.romero@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240624053046.221802-1-gustavo.romero@linaro.org>
References: <20240624053046.221802-1-gustavo.romero@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::c2e;
 envelope-from=gustavo.romero@linaro.org; helo=mail-oo1-xc2e.google.com
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

Move GdbCmdParseEntry and its associated types into a separate header
file to allow the use of GdbCmdParseEntry and other gdbstub command
functions outside of gdbstub.c.

Since GdbCmdParseEntry and get_param are now public, kdoc
GdbCmdParseEntry and rename get_param to gdb_get_cmd_param.

This commit also makes gdb_put_packet public since is used in gdbstub
command handling.

Signed-off-by: Gustavo Romero <gustavo.romero@linaro.org>
Reviewed-by: Alex Bennée <alex.bennee@linaro.org>
---
 gdbstub/gdbstub.c          | 134 ++++++++++++++-----------------------
 gdbstub/internals.h        |  22 ------
 gdbstub/syscalls.c         |   7 +-
 gdbstub/system.c           |   7 +-
 gdbstub/user-target.c      |  25 +++----
 gdbstub/user.c             |   7 +-
 include/gdbstub/commands.h |  74 ++++++++++++++++++++
 7 files changed, 148 insertions(+), 128 deletions(-)
 create mode 100644 include/gdbstub/commands.h

diff --git a/gdbstub/gdbstub.c b/gdbstub/gdbstub.c
index 37314b92e5..9ff2f4177d 100644
--- a/gdbstub/gdbstub.c
+++ b/gdbstub/gdbstub.c
@@ -30,6 +30,7 @@
 #include "qemu/error-report.h"
 #include "trace.h"
 #include "exec/gdbstub.h"
+#include "gdbstub/commands.h"
 #include "gdbstub/syscalls.h"
 #ifdef CONFIG_USER_ONLY
 #include "accel/tcg/vcpu-state.h"
@@ -920,43 +921,6 @@ static int cmd_parse_params(const char *data, const char *schema,
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
@@ -1023,7 +987,7 @@ static void handle_detach(GArray *params, void *user_ctx)
             return;
         }
 
-        pid = get_param(params, 0)->val_ul;
+        pid = gdb_get_cmd_param(params, 0)->val_ul;
     }
 
 #ifdef CONFIG_USER_ONLY
@@ -1061,13 +1025,13 @@ static void handle_thread_alive(GArray *params, void *user_ctx)
         return;
     }
 
-    if (get_param(params, 0)->thread_id.kind == GDB_READ_THREAD_ERR) {
+    if (gdb_get_cmd_param(params, 0)->thread_id.kind == GDB_READ_THREAD_ERR) {
         gdb_put_packet("E22");
         return;
     }
 
-    cpu = gdb_get_cpu(get_param(params, 0)->thread_id.pid,
-                      get_param(params, 0)->thread_id.tid);
+    cpu = gdb_get_cpu(gdb_get_cmd_param(params, 0)->thread_id.pid,
+                      gdb_get_cmd_param(params, 0)->thread_id.tid);
     if (!cpu) {
         gdb_put_packet("E22");
         return;
@@ -1079,7 +1043,7 @@ static void handle_thread_alive(GArray *params, void *user_ctx)
 static void handle_continue(GArray *params, void *user_ctx)
 {
     if (params->len) {
-        gdb_set_cpu_pc(get_param(params, 0)->val_ull);
+        gdb_set_cpu_pc(gdb_get_cmd_param(params, 0)->val_ull);
     }
 
     gdbserver_state.signal = 0;
@@ -1095,7 +1059,7 @@ static void handle_cont_with_sig(GArray *params, void *user_ctx)
      *       omit the addr parameter
      */
     if (params->len) {
-        signal = get_param(params, 0)->val_ul;
+        signal = gdb_get_cmd_param(params, 0)->val_ul;
     }
 
     gdbserver_state.signal = gdb_signal_to_target(signal);
@@ -1115,18 +1079,18 @@ static void handle_set_thread(GArray *params, void *user_ctx)
         return;
     }
 
-    if (get_param(params, 1)->thread_id.kind == GDB_READ_THREAD_ERR) {
+    if (gdb_get_cmd_param(params, 1)->thread_id.kind == GDB_READ_THREAD_ERR) {
         gdb_put_packet("E22");
         return;
     }
 
-    if (get_param(params, 1)->thread_id.kind != GDB_ONE_THREAD) {
+    if (gdb_get_cmd_param(params, 1)->thread_id.kind != GDB_ONE_THREAD) {
         gdb_put_packet("OK");
         return;
     }
 
-    pid = get_param(params, 1)->thread_id.pid;
-    tid = get_param(params, 1)->thread_id.tid;
+    pid = gdb_get_cmd_param(params, 1)->thread_id.pid;
+    tid = gdb_get_cmd_param(params, 1)->thread_id.tid;
 #ifdef CONFIG_USER_ONLY
     if (gdb_handle_set_thread_user(pid, tid)) {
         return;
@@ -1142,7 +1106,7 @@ static void handle_set_thread(GArray *params, void *user_ctx)
      * Note: This command is deprecated and modern gdb's will be using the
      *       vCont command instead.
      */
-    switch (get_param(params, 0)->opcode) {
+    switch (gdb_get_cmd_param(params, 0)->opcode) {
     case 'c':
         gdbserver_state.c_cpu = cpu;
         gdb_put_packet("OK");
@@ -1167,9 +1131,9 @@ static void handle_insert_bp(GArray *params, void *user_ctx)
     }
 
     res = gdb_breakpoint_insert(gdbserver_state.c_cpu,
-                                get_param(params, 0)->val_ul,
-                                get_param(params, 1)->val_ull,
-                                get_param(params, 2)->val_ull);
+                                gdb_get_cmd_param(params, 0)->val_ul,
+                                gdb_get_cmd_param(params, 1)->val_ull,
+                                gdb_get_cmd_param(params, 2)->val_ull);
     if (res >= 0) {
         gdb_put_packet("OK");
         return;
@@ -1191,9 +1155,9 @@ static void handle_remove_bp(GArray *params, void *user_ctx)
     }
 
     res = gdb_breakpoint_remove(gdbserver_state.c_cpu,
-                                get_param(params, 0)->val_ul,
-                                get_param(params, 1)->val_ull,
-                                get_param(params, 2)->val_ull);
+                                gdb_get_cmd_param(params, 0)->val_ul,
+                                gdb_get_cmd_param(params, 1)->val_ull,
+                                gdb_get_cmd_param(params, 2)->val_ull);
     if (res >= 0) {
         gdb_put_packet("OK");
         return;
@@ -1225,10 +1189,10 @@ static void handle_set_reg(GArray *params, void *user_ctx)
         return;
     }
 
-    reg_size = strlen(get_param(params, 1)->data) / 2;
-    gdb_hextomem(gdbserver_state.mem_buf, get_param(params, 1)->data, reg_size);
+    reg_size = strlen(gdb_get_cmd_param(params, 1)->data) / 2;
+    gdb_hextomem(gdbserver_state.mem_buf, gdb_get_cmd_param(params, 1)->data, reg_size);
     gdb_write_register(gdbserver_state.g_cpu, gdbserver_state.mem_buf->data,
-                       get_param(params, 0)->val_ull);
+                       gdb_get_cmd_param(params, 0)->val_ull);
     gdb_put_packet("OK");
 }
 
@@ -1243,7 +1207,7 @@ static void handle_get_reg(GArray *params, void *user_ctx)
 
     reg_size = gdb_read_register(gdbserver_state.g_cpu,
                                  gdbserver_state.mem_buf,
-                                 get_param(params, 0)->val_ull);
+                                 gdb_get_cmd_param(params, 0)->val_ull);
     if (!reg_size) {
         gdb_put_packet("E14");
         return;
@@ -1264,16 +1228,16 @@ static void handle_write_mem(GArray *params, void *user_ctx)
     }
 
     /* gdb_hextomem() reads 2*len bytes */
-    if (get_param(params, 1)->val_ull >
-        strlen(get_param(params, 2)->data) / 2) {
+    if (gdb_get_cmd_param(params, 1)->val_ull >
+        strlen(gdb_get_cmd_param(params, 2)->data) / 2) {
         gdb_put_packet("E22");
         return;
     }
 
-    gdb_hextomem(gdbserver_state.mem_buf, get_param(params, 2)->data,
-                 get_param(params, 1)->val_ull);
+    gdb_hextomem(gdbserver_state.mem_buf, gdb_get_cmd_param(params, 2)->data,
+                 gdb_get_cmd_param(params, 1)->val_ull);
     if (gdb_target_memory_rw_debug(gdbserver_state.g_cpu,
-                                   get_param(params, 0)->val_ull,
+                                   gdb_get_cmd_param(params, 0)->val_ull,
                                    gdbserver_state.mem_buf->data,
                                    gdbserver_state.mem_buf->len, true)) {
         gdb_put_packet("E14");
@@ -1291,16 +1255,16 @@ static void handle_read_mem(GArray *params, void *user_ctx)
     }
 
     /* gdb_memtohex() doubles the required space */
-    if (get_param(params, 1)->val_ull > MAX_PACKET_LENGTH / 2) {
+    if (gdb_get_cmd_param(params, 1)->val_ull > MAX_PACKET_LENGTH / 2) {
         gdb_put_packet("E22");
         return;
     }
 
     g_byte_array_set_size(gdbserver_state.mem_buf,
-                          get_param(params, 1)->val_ull);
+                          gdb_get_cmd_param(params, 1)->val_ull);
 
     if (gdb_target_memory_rw_debug(gdbserver_state.g_cpu,
-                                   get_param(params, 0)->val_ull,
+                                   gdb_get_cmd_param(params, 0)->val_ull,
                                    gdbserver_state.mem_buf->data,
                                    gdbserver_state.mem_buf->len, false)) {
         gdb_put_packet("E14");
@@ -1324,8 +1288,8 @@ static void handle_write_all_regs(GArray *params, void *user_ctx)
     }
 
     cpu_synchronize_state(gdbserver_state.g_cpu);
-    len = strlen(get_param(params, 0)->data) / 2;
-    gdb_hextomem(gdbserver_state.mem_buf, get_param(params, 0)->data, len);
+    len = strlen(gdb_get_cmd_param(params, 0)->data) / 2;
+    gdb_hextomem(gdbserver_state.mem_buf, gdb_get_cmd_param(params, 0)->data, len);
     registers = gdbserver_state.mem_buf->data;
     for (reg_id = 0;
          reg_id < gdbserver_state.g_cpu->gdb_num_g_regs && len > 0;
@@ -1360,7 +1324,7 @@ static void handle_read_all_regs(GArray *params, void *user_ctx)
 static void handle_step(GArray *params, void *user_ctx)
 {
     if (params->len) {
-        gdb_set_cpu_pc(get_param(params, 0)->val_ull);
+        gdb_set_cpu_pc(gdb_get_cmd_param(params, 0)->val_ull);
     }
 
     cpu_single_step(gdbserver_state.c_cpu, gdbserver_state.sstep_flags);
@@ -1373,7 +1337,7 @@ static void handle_backward(GArray *params, void *user_ctx)
         gdb_put_packet("E22");
     }
     if (params->len == 1) {
-        switch (get_param(params, 0)->opcode) {
+        switch (gdb_get_cmd_param(params, 0)->opcode) {
         case 's':
             if (replay_reverse_step()) {
                 gdb_continue();
@@ -1408,7 +1372,7 @@ static void handle_v_cont(GArray *params, void *user_ctx)
         return;
     }
 
-    res = gdb_handle_vcont(get_param(params, 0)->data);
+    res = gdb_handle_vcont(gdb_get_cmd_param(params, 0)->data);
     if ((res == -EINVAL) || (res == -ERANGE)) {
         gdb_put_packet("E22");
     } else if (res) {
@@ -1426,7 +1390,7 @@ static void handle_v_attach(GArray *params, void *user_ctx)
         goto cleanup;
     }
 
-    process = gdb_get_process(get_param(params, 0)->val_ul);
+    process = gdb_get_process(gdb_get_cmd_param(params, 0)->val_ul);
     if (!process) {
         goto cleanup;
     }
@@ -1523,7 +1487,7 @@ static void handle_v_commands(GArray *params, void *user_ctx)
         return;
     }
 
-    if (!process_string_cmd(get_param(params, 0)->data,
+    if (!process_string_cmd(gdb_get_cmd_param(params, 0)->data,
                             gdb_v_commands_table,
                             ARRAY_SIZE(gdb_v_commands_table))) {
         gdb_put_packet("");
@@ -1555,7 +1519,7 @@ static void handle_set_qemu_sstep(GArray *params, void *user_ctx)
         return;
     }
 
-    new_sstep_flags = get_param(params, 0)->val_ul;
+    new_sstep_flags = gdb_get_cmd_param(params, 0)->val_ul;
 
     if (new_sstep_flags  & ~gdbserver_state.supported_sstep_flags) {
         gdb_put_packet("E22");
@@ -1615,13 +1579,13 @@ static void handle_query_thread_extra(GArray *params, void *user_ctx)
     CPUState *cpu;
 
     if (!params->len ||
-        get_param(params, 0)->thread_id.kind == GDB_READ_THREAD_ERR) {
+        gdb_get_cmd_param(params, 0)->thread_id.kind == GDB_READ_THREAD_ERR) {
         gdb_put_packet("E22");
         return;
     }
 
-    cpu = gdb_get_cpu(get_param(params, 0)->thread_id.pid,
-                      get_param(params, 0)->thread_id.tid);
+    cpu = gdb_get_cpu(gdb_get_cmd_param(params, 0)->thread_id.pid,
+                      gdb_get_cmd_param(params, 0)->thread_id.tid);
     if (!cpu) {
         return;
     }
@@ -1673,7 +1637,7 @@ static void handle_query_supported(GArray *params, void *user_ctx)
 #endif
 
     if (params->len) {
-        const char *gdb_supported = get_param(params, 0)->data;
+        const char *gdb_supported = gdb_get_cmd_param(params, 0)->data;
 
         if (strstr(gdb_supported, "multiprocess+")) {
             gdbserver_state.multiprocess = true;
@@ -1707,15 +1671,15 @@ static void handle_query_xfer_features(GArray *params, void *user_ctx)
         return;
     }
 
-    p = get_param(params, 0)->data;
+    p = gdb_get_cmd_param(params, 0)->data;
     xml = get_feature_xml(p, &p, process);
     if (!xml) {
         gdb_put_packet("E00");
         return;
     }
 
-    addr = get_param(params, 1)->val_ul;
-    len = get_param(params, 2)->val_ul;
+    addr = gdb_get_cmd_param(params, 1)->val_ul;
+    len = gdb_get_cmd_param(params, 2)->val_ul;
     total_len = strlen(xml);
     if (addr > total_len) {
         gdb_put_packet("E00");
@@ -1889,13 +1853,13 @@ static void handle_gen_query(GArray *params, void *user_ctx)
         return;
     }
 
-    if (process_string_cmd(get_param(params, 0)->data,
+    if (process_string_cmd(gdb_get_cmd_param(params, 0)->data,
                            gdb_gen_query_set_common_table,
                            ARRAY_SIZE(gdb_gen_query_set_common_table))) {
         return;
     }
 
-    if (!process_string_cmd(get_param(params, 0)->data,
+    if (!process_string_cmd(gdb_get_cmd_param(params, 0)->data,
                             gdb_gen_query_table,
                             ARRAY_SIZE(gdb_gen_query_table))) {
         gdb_put_packet("");
@@ -1908,13 +1872,13 @@ static void handle_gen_set(GArray *params, void *user_ctx)
         return;
     }
 
-    if (process_string_cmd(get_param(params, 0)->data,
+    if (process_string_cmd(gdb_get_cmd_param(params, 0)->data,
                            gdb_gen_query_set_common_table,
                            ARRAY_SIZE(gdb_gen_query_set_common_table))) {
         return;
     }
 
-    if (!process_string_cmd(get_param(params, 0)->data,
+    if (!process_string_cmd(gdb_get_cmd_param(params, 0)->data,
                            gdb_gen_set_table,
                            ARRAY_SIZE(gdb_gen_set_table))) {
         gdb_put_packet("");
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
index 02e3a8f74c..4e1295b782 100644
--- a/gdbstub/syscalls.c
+++ b/gdbstub/syscalls.c
@@ -16,6 +16,7 @@
 #include "sysemu/runstate.h"
 #include "gdbstub/user.h"
 #include "gdbstub/syscalls.h"
+#include "gdbstub/commands.h"
 #include "trace.h"
 #include "internals.h"
 
@@ -154,9 +155,9 @@ void gdb_handle_file_io(GArray *params, void *user_ctx)
         uint64_t ret;
         int err;
 
-        ret = get_param(params, 0)->val_ull;
+        ret = gdb_get_cmd_param(params, 0)->val_ull;
         if (params->len >= 2) {
-            err = get_param(params, 1)->val_ull;
+            err = gdb_get_cmd_param(params, 1)->val_ull;
         } else {
             err = 0;
         }
@@ -196,7 +197,7 @@ void gdb_handle_file_io(GArray *params, void *user_ctx)
         gdbserver_syscall_state.current_syscall_cb = NULL;
     }
 
-    if (params->len >= 3 && get_param(params, 2)->opcode == (uint8_t)'C') {
+    if (params->len >= 3 && gdb_get_cmd_param(params, 2)->opcode == (uint8_t)'C') {
         gdb_put_packet("T02");
         return;
     }
diff --git a/gdbstub/system.c b/gdbstub/system.c
index d235403855..1ad87fe7fd 100644
--- a/gdbstub/system.c
+++ b/gdbstub/system.c
@@ -16,6 +16,7 @@
 #include "qemu/cutils.h"
 #include "exec/gdbstub.h"
 #include "gdbstub/syscalls.h"
+#include "gdbstub/commands.h"
 #include "exec/hwaddr.h"
 #include "exec/tb-flush.h"
 #include "sysemu/cpus.h"
@@ -501,7 +502,7 @@ void gdb_handle_set_qemu_phy_mem_mode(GArray *params, void *ctx)
         return;
     }
 
-    if (!get_param(params, 0)->val_ul) {
+    if (!gdb_get_cmd_param(params, 0)->val_ul) {
         phy_memory_mode = 0;
     } else {
         phy_memory_mode = 1;
@@ -519,7 +520,7 @@ void gdb_handle_query_rcmd(GArray *params, void *ctx)
         return;
     }
 
-    len = strlen(get_param(params, 0)->data);
+    len = strlen(gdb_get_cmd_param(params, 0)->data);
     if (len % 2) {
         gdb_put_packet("E01");
         return;
@@ -527,7 +528,7 @@ void gdb_handle_query_rcmd(GArray *params, void *ctx)
 
     g_assert(gdbserver_state.mem_buf->len == 0);
     len = len / 2;
-    gdb_hextomem(gdbserver_state.mem_buf, get_param(params, 0)->data, len);
+    gdb_hextomem(gdbserver_state.mem_buf, gdb_get_cmd_param(params, 0)->data, len);
     g_byte_array_append(gdbserver_state.mem_buf, &zero, 1);
     qemu_chr_be_write(gdbserver_system_state.mon_chr,
                       gdbserver_state.mem_buf->data,
diff --git a/gdbstub/user-target.c b/gdbstub/user-target.c
index a9c6c64512..b5e01fd8b0 100644
--- a/gdbstub/user-target.c
+++ b/gdbstub/user-target.c
@@ -9,6 +9,7 @@
 
 #include "qemu/osdep.h"
 #include "exec/gdbstub.h"
+#include "gdbstub/commands.h"
 #include "qemu.h"
 #include "internals.h"
 #ifdef CONFIG_LINUX
@@ -250,8 +251,8 @@ void gdb_handle_query_xfer_auxv(GArray *params, void *user_ctx)
         return;
     }
 
-    offset = get_param(params, 0)->val_ul;
-    len = get_param(params, 1)->val_ul;
+    offset = gdb_get_cmd_param(params, 0)->val_ul;
+    len = gdb_get_cmd_param(params, 1)->val_ul;
     ts = get_task_state(gdbserver_state.c_cpu);
     saved_auxv = ts->info->saved_auxv;
     auxv_len = ts->info->auxv_len;
@@ -288,7 +289,7 @@ void gdb_handle_query_xfer_auxv(GArray *params, void *user_ctx)
 
 static const char *get_filename_param(GArray *params, int i)
 {
-    const char *hex_filename = get_param(params, i)->data;
+    const char *hex_filename = gdb_get_cmd_param(params, i)->data;
     gdb_hextomem(gdbserver_state.mem_buf, hex_filename,
                  strlen(hex_filename) / 2);
     g_byte_array_append(gdbserver_state.mem_buf, (const guint8 *)"", 1);
@@ -306,8 +307,8 @@ static void hostio_reply_with_data(const void *buf, size_t n)
 void gdb_handle_v_file_open(GArray *params, void *user_ctx)
 {
     const char *filename = get_filename_param(params, 0);
-    uint64_t flags = get_param(params, 1)->val_ull;
-    uint64_t mode = get_param(params, 2)->val_ull;
+    uint64_t flags = gdb_get_cmd_param(params, 1)->val_ull;
+    uint64_t mode = gdb_get_cmd_param(params, 2)->val_ull;
 
 #ifdef CONFIG_LINUX
     int fd = do_guest_openat(cpu_env(gdbserver_state.g_cpu), 0, filename,
@@ -325,7 +326,7 @@ void gdb_handle_v_file_open(GArray *params, void *user_ctx)
 
 void gdb_handle_v_file_close(GArray *params, void *user_ctx)
 {
-    int fd = get_param(params, 0)->val_ul;
+    int fd = gdb_get_cmd_param(params, 0)->val_ul;
 
     if (close(fd) == -1) {
         g_string_printf(gdbserver_state.str_buf, "F-1,%d", errno);
@@ -338,9 +339,9 @@ void gdb_handle_v_file_close(GArray *params, void *user_ctx)
 
 void gdb_handle_v_file_pread(GArray *params, void *user_ctx)
 {
-    int fd = get_param(params, 0)->val_ul;
-    size_t count = get_param(params, 1)->val_ull;
-    off_t offset = get_param(params, 2)->val_ull;
+    int fd = gdb_get_cmd_param(params, 0)->val_ul;
+    size_t count = gdb_get_cmd_param(params, 1)->val_ull;
+    off_t offset = gdb_get_cmd_param(params, 2)->val_ull;
 
     size_t bufsiz = MIN(count, BUFSIZ);
     g_autofree char *buf = g_try_malloc(bufsiz);
@@ -383,9 +384,9 @@ void gdb_handle_v_file_readlink(GArray *params, void *user_ctx)
 
 void gdb_handle_query_xfer_exec_file(GArray *params, void *user_ctx)
 {
-    uint32_t pid = get_param(params, 0)->val_ul;
-    uint32_t offset = get_param(params, 1)->val_ul;
-    uint32_t length = get_param(params, 2)->val_ul;
+    uint32_t pid = gdb_get_cmd_param(params, 0)->val_ul;
+    uint32_t offset = gdb_get_cmd_param(params, 1)->val_ul;
+    uint32_t length = gdb_get_cmd_param(params, 2)->val_ul;
 
     GDBProcess *process = gdb_get_process(pid);
     if (!process) {
diff --git a/gdbstub/user.c b/gdbstub/user.c
index e34b58b407..b36033bc7a 100644
--- a/gdbstub/user.c
+++ b/gdbstub/user.c
@@ -16,6 +16,7 @@
 #include "exec/hwaddr.h"
 #include "exec/tb-flush.h"
 #include "exec/gdbstub.h"
+#include "gdbstub/commands.h"
 #include "gdbstub/syscalls.h"
 #include "gdbstub/user.h"
 #include "gdbstub/enums.h"
@@ -793,7 +794,7 @@ void gdb_syscall_return(CPUState *cs, int num)
 
 void gdb_handle_set_catch_syscalls(GArray *params, void *user_ctx)
 {
-    const char *param = get_param(params, 0)->data;
+    const char *param = gdb_get_cmd_param(params, 0)->data;
     GDBSyscallsMask catch_syscalls_mask;
     bool catch_all_syscalls;
     unsigned int num;
@@ -858,8 +859,8 @@ void gdb_handle_query_xfer_siginfo(GArray *params, void *user_ctx)
     unsigned long offset, len;
     uint8_t *siginfo_offset;
 
-    offset = get_param(params, 0)->val_ul;
-    len = get_param(params, 1)->val_ul;
+    offset = gdb_get_cmd_param(params, 0)->val_ul;
+    len = gdb_get_cmd_param(params, 1)->val_ul;
 
     if (offset + len > gdbserver_user_state.siginfo_len) {
         /* Invalid offset and/or requested length. */
diff --git a/include/gdbstub/commands.h b/include/gdbstub/commands.h
new file mode 100644
index 0000000000..dd45c38472
--- /dev/null
+++ b/include/gdbstub/commands.h
@@ -0,0 +1,74 @@
+#ifndef GDBSTUB_COMMANDS_H
+#define GDBSTUB
+
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
+#define gdb_get_cmd_param(p, i)    (&g_array_index(p, GdbCmdVariant, i))
+
+/**
+ * typedef GdbCmdParseEntry - gdb command parser
+ *
+ * This structure keeps the information necessary to match a gdb command,
+ * parse it (extract its parameters), and select the correct handler for it.
+ *
+ * @cmd: The command to be matched
+ * @cmd_startswith: If true, @cmd is compared using startswith
+ * @schema: Each schema for the command parameter entry consists of 2 chars,
+ * the first char represents the parameter type handling the second char
+ * represents the delimiter for the next parameter.
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
+ *
+ * @allow_stop_reply: True iff the gdbstub can respond to this command with a
+ * "stop reply" packet. The list of commands that accept such response is
+ * defined at the GDB Remote Serial Protocol documentation. See:
+ * https://sourceware.org/gdb/onlinedocs/gdb/Stop-Reply-Packets.html#Stop-Reply-Packets.
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
+ * gdb_put_packet() - put string into gdb server's buffer so it is sent
+ * to the client
+ */
+int gdb_put_packet(const char *buf);
+
+#endif /* GDBSTUB_COMMANDS_H */
-- 
2.34.1


