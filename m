Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AB4F5C2D0D1
	for <qemu-devel@archiver.kernel.org>; Mon, 24 Jun 2024 05:31:55 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sLcIO-00031o-9N; Mon, 24 Jun 2024 01:31:16 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <gustavo.romero@linaro.org>)
 id 1sLcIL-00031I-EI
 for qemu-devel@nongnu.org; Mon, 24 Jun 2024 01:31:13 -0400
Received: from mail-il1-x12b.google.com ([2607:f8b0:4864:20::12b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <gustavo.romero@linaro.org>)
 id 1sLcIJ-0004ZO-MV
 for qemu-devel@nongnu.org; Mon, 24 Jun 2024 01:31:13 -0400
Received: by mail-il1-x12b.google.com with SMTP id
 e9e14a558f8ab-37636c3872bso6964005ab.3
 for <qemu-devel@nongnu.org>; Sun, 23 Jun 2024 22:31:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1719207070; x=1719811870; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=PsonJ1zRH/+YC/a6OR7EHJ04b9L1NQ9IXkQt5iZNFyk=;
 b=GYIlJMe9PyzXYLOoThosxLGBwB/5uwpLL/r0yugXgkvS/uu8iFh5Tyk7Xstx38xZWR
 JdlykFA+swzkVEU90FOmHxqnfEjwgCJ8as+/WpCwjPsm1Var1/yf2WHCpshvzPtEhVH3
 NL/EV0pUoWIg+DI+aYbOSPNrRHgvqWP2bqZcR8YbQ/cfsjwfMmhZoGinW5DFn3a3qVHB
 +/pjql9LXwn9EIh6TDF8MiI6smDjDUXGRIxLr3kber9wJlz9cF4beqa+B1YmM3aCJ51h
 LF65rS2o2hf976219bk8NoLvBohRlEHIGYBnsJkKIl2mJ0SA63bEvI/+DTAIKqmh9zR6
 B4Nw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1719207070; x=1719811870;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=PsonJ1zRH/+YC/a6OR7EHJ04b9L1NQ9IXkQt5iZNFyk=;
 b=rSGIsw3uoGfaiOU3gJATWXQiAHXIAWCkUI4VQvYB40Wv8x8vk58gPCAuTW2mqUBNai
 yrlCOg7fwJhYDZVXcS+kx2eLs6KDJ8WUumn+GM9XWGq/9jABOjHff3HIWMmhEkOOQDI5
 nOWPowhrteKAp1TIkEUZiEHU0D/sek6kvi9cRf2jK8AvGYkkfo+qzD9LSdLHHj45ko+g
 cb2hNKUTaYWTufxIM+p4s/DQnRyvjAK0LtUP3VgUTHl+vh4BDjdJzlXzAeVkR7fvldaC
 ZR+yzKnQYY0o9fqg8vNKRqT64+xghFGz4P0PjC2n+Gnahi0dhhiVMzaeX6EMxLXjjw+f
 MQtQ==
X-Gm-Message-State: AOJu0YwARfDpf2SIwjSEvPx/P0tHsNYQ5zyRhPdArWNbBpTVOeNWWtwi
 vH/QHFZppzL6elakOOxjm7SFebLUoTDn35JE/R5B5iCYrF/uAbQ45ULO8aMEEJBQLv5wc3aoMbt
 R2a4=
X-Google-Smtp-Source: AGHT+IGAXFoB9t1ijTruQFFO95dQ3kzMEh0bsm4tczv8g86KCiTezZWYwzqjGHVDE0QLZFJNLvT34g==
X-Received: by 2002:a92:ca0d:0:b0:374:5a2d:178 with SMTP id
 e9e14a558f8ab-3763f5adca5mr47915645ab.2.1719207070000; 
 Sun, 23 Jun 2024 22:31:10 -0700 (PDT)
Received: from amd.. ([2804:7f0:b401:1758:3e7c:3fff:fe7a:e83b])
 by smtp.gmail.com with ESMTPSA id
 41be03b00d2f7-716b4a73183sm3953601a12.39.2024.06.23.22.31.07
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 23 Jun 2024 22:31:09 -0700 (PDT)
From: Gustavo Romero <gustavo.romero@linaro.org>
To: qemu-devel@nongnu.org, alex.bennee@linaro.org, richard.henderson@linaro.org
Cc: philmd@linaro.org,
	peter.maydell@linaro.org,
	gustavo.romero@linaro.org
Subject: [PATCH v4 1/9] gdbstub: Clean up process_string_cmd
Date: Mon, 24 Jun 2024 05:30:38 +0000
Message-Id: <20240624053046.221802-2-gustavo.romero@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240624053046.221802-1-gustavo.romero@linaro.org>
References: <20240624053046.221802-1-gustavo.romero@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::12b;
 envelope-from=gustavo.romero@linaro.org; helo=mail-il1-x12b.google.com
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

Change 'process_string_cmd' to return true on success and false on
failure, instead of 0 and -1.

Signed-off-by: Gustavo Romero <gustavo.romero@linaro.org>
Reviewed-by: Alex Bennée <alex.bennee@linaro.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
---
 gdbstub/gdbstub.c | 40 ++++++++++++++++++++--------------------
 1 file changed, 20 insertions(+), 20 deletions(-)

diff --git a/gdbstub/gdbstub.c b/gdbstub/gdbstub.c
index b3574997ea..37314b92e5 100644
--- a/gdbstub/gdbstub.c
+++ b/gdbstub/gdbstub.c
@@ -962,14 +962,14 @@ static inline int startswith(const char *string, const char *pattern)
   return !strncmp(string, pattern, strlen(pattern));
 }
 
-static int process_string_cmd(const char *data,
-                              const GdbCmdParseEntry *cmds, int num_cmds)
+static bool process_string_cmd(const char *data,
+                               const GdbCmdParseEntry *cmds, int num_cmds)
 {
     int i;
     g_autoptr(GArray) params = g_array_new(false, true, sizeof(GdbCmdVariant));
 
     if (!cmds) {
-        return -1;
+        return false;
     }
 
     for (i = 0; i < num_cmds; i++) {
@@ -984,16 +984,16 @@ static int process_string_cmd(const char *data,
         if (cmd->schema) {
             if (cmd_parse_params(&data[strlen(cmd->cmd)],
                                  cmd->schema, params)) {
-                return -1;
+                return false;
             }
         }
 
         gdbserver_state.allow_stop_reply = cmd->allow_stop_reply;
         cmd->handler(params, NULL);
-        return 0;
+        return true;
     }
 
-    return -1;
+    return false;
 }
 
 static void run_cmd_parser(const char *data, const GdbCmdParseEntry *cmd)
@@ -1007,7 +1007,7 @@ static void run_cmd_parser(const char *data, const GdbCmdParseEntry *cmd)
 
     /* In case there was an error during the command parsing we must
     * send a NULL packet to indicate the command is not supported */
-    if (process_string_cmd(data, cmd, 1)) {
+    if (!process_string_cmd(data, cmd, 1)) {
         gdb_put_packet("");
     }
 }
@@ -1523,9 +1523,9 @@ static void handle_v_commands(GArray *params, void *user_ctx)
         return;
     }
 
-    if (process_string_cmd(get_param(params, 0)->data,
-                           gdb_v_commands_table,
-                           ARRAY_SIZE(gdb_v_commands_table))) {
+    if (!process_string_cmd(get_param(params, 0)->data,
+                            gdb_v_commands_table,
+                            ARRAY_SIZE(gdb_v_commands_table))) {
         gdb_put_packet("");
     }
 }
@@ -1889,15 +1889,15 @@ static void handle_gen_query(GArray *params, void *user_ctx)
         return;
     }
 
-    if (!process_string_cmd(get_param(params, 0)->data,
-                            gdb_gen_query_set_common_table,
-                            ARRAY_SIZE(gdb_gen_query_set_common_table))) {
+    if (process_string_cmd(get_param(params, 0)->data,
+                           gdb_gen_query_set_common_table,
+                           ARRAY_SIZE(gdb_gen_query_set_common_table))) {
         return;
     }
 
-    if (process_string_cmd(get_param(params, 0)->data,
-                           gdb_gen_query_table,
-                           ARRAY_SIZE(gdb_gen_query_table))) {
+    if (!process_string_cmd(get_param(params, 0)->data,
+                            gdb_gen_query_table,
+                            ARRAY_SIZE(gdb_gen_query_table))) {
         gdb_put_packet("");
     }
 }
@@ -1908,13 +1908,13 @@ static void handle_gen_set(GArray *params, void *user_ctx)
         return;
     }
 
-    if (!process_string_cmd(get_param(params, 0)->data,
-                            gdb_gen_query_set_common_table,
-                            ARRAY_SIZE(gdb_gen_query_set_common_table))) {
+    if (process_string_cmd(get_param(params, 0)->data,
+                           gdb_gen_query_set_common_table,
+                           ARRAY_SIZE(gdb_gen_query_set_common_table))) {
         return;
     }
 
-    if (process_string_cmd(get_param(params, 0)->data,
+    if (!process_string_cmd(get_param(params, 0)->data,
                            gdb_gen_set_table,
                            ARRAY_SIZE(gdb_gen_set_table))) {
         gdb_put_packet("");
-- 
2.34.1


