Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 019D5C2BBCA
	for <qemu-devel@archiver.kernel.org>; Fri, 28 Jun 2024 05:22:14 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sN433-0003K4-AN; Fri, 28 Jun 2024 01:21:25 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <gustavo.romero@linaro.org>)
 id 1sN431-0003Jl-UW
 for qemu-devel@nongnu.org; Fri, 28 Jun 2024 01:21:23 -0400
Received: from mail-ot1-x336.google.com ([2607:f8b0:4864:20::336])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <gustavo.romero@linaro.org>)
 id 1sN42z-0008FD-Ue
 for qemu-devel@nongnu.org; Fri, 28 Jun 2024 01:21:23 -0400
Received: by mail-ot1-x336.google.com with SMTP id
 46e09a7af769-6f8d0a1e500so180432a34.3
 for <qemu-devel@nongnu.org>; Thu, 27 Jun 2024 22:21:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1719552080; x=1720156880; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=o3gvu6OQ0lTozaroxzspcc5vQ9JngNtD70BqjIlE6nA=;
 b=Ehwp394Ik4S43iFkkFMBP5vSTf8JYBn4a1F4Xtj9XvJisqhy25wII/hkr2a772SnL9
 0JckTtLGW+sfHYprkbgvqFWaHL6hmadN6PG8XJLVBYUvHBGh1ug43wgAawYlpOx0DMtr
 q0fbvuqvTedRrF1rPfUHayiM8EbvpfD5OU5Efx2ny5QryAPUEFCDbK/fdC1Hz8U8MGtp
 bEEEUeF0CtpPtrmCx77/eVGneA0ZdMb56H3m3euZtW6XEddbck7AsTx+OI9UudEpjCU/
 91ub0FagcSPrZMpbSkIX+rPeFi8SOcQ1K9cwPqOnitw9qar6dFmjK0w3PVWv8pMX9qpK
 aVaQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1719552080; x=1720156880;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=o3gvu6OQ0lTozaroxzspcc5vQ9JngNtD70BqjIlE6nA=;
 b=NUF8cOmtl6GBl3kGMUenUaW+pUuW4nJW+7Her2ALIo+DbyCP4ReHH0uiZUKVP7RgTn
 Qb1UCYLvjHkJYDxY9A9NmvEgntUxchNouzBhdcRoCX5rYETAY5ZZDnuyXgR0KskuMTDD
 gBSCZRBQBgclMhuQ4QLI8rR6J7MoNzkUFo56I8BPWumMmJyqo4wL/IekWj1HGuDqmIO3
 ezBhscsZO9MKmWTUeCkpMuEnIBUKp+piF09A1ZQeP7gsr5nF+f4IuaRlPv9d6tKM5GcN
 tOqIOrlq+1WdHf3ZPDzoc+Lz1sB0wsmSL1Qfvy/ZTbom9JnyybCo7Dc5xJ2+U8fj08tk
 DLvw==
X-Gm-Message-State: AOJu0YzXKlGgl9qdJfCu4D3ytI8fl5q1X74y3kbvgpUHMzcIDC3qJoNi
 /z36mHfcDDMxOw3/xpF1ChTDPh+QMTVF1ocgjP6XaS0VN+wP/gTanC30Q74sbajJe1+v16vP8hz
 n
X-Google-Smtp-Source: AGHT+IGUhPIlPwIb1cuSRswv7LZCDqa2Jv05k5I9jPRJZjM12wqNeOmKGAlCW8jdapXczJec6OFYjA==
X-Received: by 2002:a05:6830:168c:b0:6f9:8c58:712a with SMTP id
 46e09a7af769-700b11f55cemr15872617a34.15.1719552080287; 
 Thu, 27 Jun 2024 22:21:20 -0700 (PDT)
Received: from amd.. ([2804:7f0:b401:391e:3e7c:3fff:fe7a:e83b])
 by smtp.gmail.com with ESMTPSA id
 41be03b00d2f7-72c6b2a16cdsm423932a12.46.2024.06.27.22.21.17
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 27 Jun 2024 22:21:19 -0700 (PDT)
From: Gustavo Romero <gustavo.romero@linaro.org>
To: qemu-devel@nongnu.org, philmd@linaro.org, alex.bennee@linaro.org,
 richard.henderson@linaro.org
Cc: peter.maydell@linaro.org,
	gustavo.romero@linaro.org
Subject: [PATCH v6 09/11] gdbstub: Use true to set cmd_startswith
Date: Fri, 28 Jun 2024 05:08:48 +0000
Message-Id: <20240628050850.536447-10-gustavo.romero@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240628050850.536447-1-gustavo.romero@linaro.org>
References: <20240628050850.536447-1-gustavo.romero@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::336;
 envelope-from=gustavo.romero@linaro.org; helo=mail-ot1-x336.google.com
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

cmd_startswith is a boolean so use 'true' to set it instead of 1.

Signed-off-by: Gustavo Romero <gustavo.romero@linaro.org>
---
 gdbstub/gdbstub.c | 80 +++++++++++++++++++++++------------------------
 1 file changed, 40 insertions(+), 40 deletions(-)

diff --git a/gdbstub/gdbstub.c b/gdbstub/gdbstub.c
index 5c1612ed2a..b9ad0a063e 100644
--- a/gdbstub/gdbstub.c
+++ b/gdbstub/gdbstub.c
@@ -1433,26 +1433,26 @@ static const GdbCmdParseEntry gdb_v_commands_table[] = {
     {
         .handler = handle_v_cont_query,
         .cmd = "Cont?",
-        .cmd_startswith = 1
+        .cmd_startswith = true
     },
     {
         .handler = handle_v_cont,
         .cmd = "Cont",
-        .cmd_startswith = 1,
+        .cmd_startswith = true,
         .allow_stop_reply = true,
         .schema = "s0"
     },
     {
         .handler = handle_v_attach,
         .cmd = "Attach;",
-        .cmd_startswith = 1,
+        .cmd_startswith = true,
         .allow_stop_reply = true,
         .schema = "l0"
     },
     {
         .handler = handle_v_kill,
         .cmd = "Kill;",
-        .cmd_startswith = 1
+        .cmd_startswith = true
     },
 #ifdef CONFIG_USER_ONLY
     /*
@@ -1462,25 +1462,25 @@ static const GdbCmdParseEntry gdb_v_commands_table[] = {
     {
         .handler = gdb_handle_v_file_open,
         .cmd = "File:open:",
-        .cmd_startswith = 1,
+        .cmd_startswith = true,
         .schema = "s,L,L0"
     },
     {
         .handler = gdb_handle_v_file_close,
         .cmd = "File:close:",
-        .cmd_startswith = 1,
+        .cmd_startswith = true,
         .schema = "l0"
     },
     {
         .handler = gdb_handle_v_file_pread,
         .cmd = "File:pread:",
-        .cmd_startswith = 1,
+        .cmd_startswith = true,
         .schema = "l,L,L0"
     },
     {
         .handler = gdb_handle_v_file_readlink,
         .cmd = "File:readlink:",
-        .cmd_startswith = 1,
+        .cmd_startswith = true,
         .schema = "s0"
     },
 #endif
@@ -1748,7 +1748,7 @@ static const GdbCmdParseEntry gdb_gen_query_set_common_table[] = {
     {
         .handler = handle_set_qemu_sstep,
         .cmd = "qemu.sstep=",
-        .cmd_startswith = 1,
+        .cmd_startswith = true,
         .schema = "l0"
     },
 };
@@ -1804,7 +1804,7 @@ static const GdbCmdParseEntry gdb_gen_query_table[] = {
     {
         .handler = handle_query_thread_extra,
         .cmd = "ThreadExtraInfo,",
-        .cmd_startswith = 1,
+        .cmd_startswith = true,
         .schema = "t0"
     },
 #ifdef CONFIG_USER_ONLY
@@ -1816,14 +1816,14 @@ static const GdbCmdParseEntry gdb_gen_query_table[] = {
     {
         .handler = gdb_handle_query_rcmd,
         .cmd = "Rcmd,",
-        .cmd_startswith = 1,
+        .cmd_startswith = true,
         .schema = "s0"
     },
 #endif
     {
         .handler = handle_query_supported,
         .cmd = "Supported:",
-        .cmd_startswith = 1,
+        .cmd_startswith = true,
         .schema = "s0"
     },
     {
@@ -1834,7 +1834,7 @@ static const GdbCmdParseEntry gdb_gen_query_table[] = {
     {
         .handler = handle_query_xfer_features,
         .cmd = "Xfer:features:read:",
-        .cmd_startswith = 1,
+        .cmd_startswith = true,
         .schema = "s:l,l0"
     },
 #if defined(CONFIG_USER_ONLY)
@@ -1842,27 +1842,27 @@ static const GdbCmdParseEntry gdb_gen_query_table[] = {
     {
         .handler = gdb_handle_query_xfer_auxv,
         .cmd = "Xfer:auxv:read::",
-        .cmd_startswith = 1,
+        .cmd_startswith = true,
         .schema = "l,l0"
     },
     {
         .handler = gdb_handle_query_xfer_siginfo,
         .cmd = "Xfer:siginfo:read::",
-        .cmd_startswith = 1,
+        .cmd_startswith = true,
         .schema = "l,l0"
      },
 #endif
     {
         .handler = gdb_handle_query_xfer_exec_file,
         .cmd = "Xfer:exec-file:read:",
-        .cmd_startswith = 1,
+        .cmd_startswith = true,
         .schema = "l:l,l0"
     },
 #endif
     {
         .handler = gdb_handle_query_attached,
         .cmd = "Attached:",
-        .cmd_startswith = 1
+        .cmd_startswith = true
     },
     {
         .handler = gdb_handle_query_attached,
@@ -1901,14 +1901,14 @@ static const GdbCmdParseEntry gdb_gen_set_table[] = {
     {
         .handler = handle_set_qemu_sstep,
         .cmd = "qemu.sstep:",
-        .cmd_startswith = 1,
+        .cmd_startswith = true,
         .schema = "l0"
     },
 #ifndef CONFIG_USER_ONLY
     {
         .handler = gdb_handle_set_qemu_phy_mem_mode,
         .cmd = "qemu.PhyMemMode:",
-        .cmd_startswith = 1,
+        .cmd_startswith = true,
         .schema = "l0"
     },
 #endif
@@ -1916,7 +1916,7 @@ static const GdbCmdParseEntry gdb_gen_set_table[] = {
     {
         .handler = gdb_handle_set_catch_syscalls,
         .cmd = "CatchSyscalls:",
-        .cmd_startswith = 1,
+        .cmd_startswith = true,
         .schema = "s0",
     },
 #endif
@@ -2012,7 +2012,7 @@ static int gdb_handle_packet(const char *line_buf)
             static const GdbCmdParseEntry target_halted_cmd_desc = {
                 .handler = handle_target_halt,
                 .cmd = "?",
-                .cmd_startswith = 1,
+                .cmd_startswith = true,
                 .allow_stop_reply = true,
             };
             cmd_parser = &target_halted_cmd_desc;
@@ -2023,7 +2023,7 @@ static int gdb_handle_packet(const char *line_buf)
             static const GdbCmdParseEntry continue_cmd_desc = {
                 .handler = handle_continue,
                 .cmd = "c",
-                .cmd_startswith = 1,
+                .cmd_startswith = true,
                 .allow_stop_reply = true,
                 .schema = "L0"
             };
@@ -2035,7 +2035,7 @@ static int gdb_handle_packet(const char *line_buf)
             static const GdbCmdParseEntry cont_with_sig_cmd_desc = {
                 .handler = handle_cont_with_sig,
                 .cmd = "C",
-                .cmd_startswith = 1,
+                .cmd_startswith = true,
                 .allow_stop_reply = true,
                 .schema = "l0"
             };
@@ -2047,7 +2047,7 @@ static int gdb_handle_packet(const char *line_buf)
             static const GdbCmdParseEntry v_cmd_desc = {
                 .handler = handle_v_commands,
                 .cmd = "v",
-                .cmd_startswith = 1,
+                .cmd_startswith = true,
                 .schema = "s0"
             };
             cmd_parser = &v_cmd_desc;
@@ -2064,7 +2064,7 @@ static int gdb_handle_packet(const char *line_buf)
             static const GdbCmdParseEntry detach_cmd_desc = {
                 .handler = handle_detach,
                 .cmd = "D",
-                .cmd_startswith = 1,
+                .cmd_startswith = true,
                 .schema = "?.l0"
             };
             cmd_parser = &detach_cmd_desc;
@@ -2075,7 +2075,7 @@ static int gdb_handle_packet(const char *line_buf)
             static const GdbCmdParseEntry step_cmd_desc = {
                 .handler = handle_step,
                 .cmd = "s",
-                .cmd_startswith = 1,
+                .cmd_startswith = true,
                 .allow_stop_reply = true,
                 .schema = "L0"
             };
@@ -2087,7 +2087,7 @@ static int gdb_handle_packet(const char *line_buf)
             static const GdbCmdParseEntry backward_cmd_desc = {
                 .handler = handle_backward,
                 .cmd = "b",
-                .cmd_startswith = 1,
+                .cmd_startswith = true,
                 .allow_stop_reply = true,
                 .schema = "o0"
             };
@@ -2099,7 +2099,7 @@ static int gdb_handle_packet(const char *line_buf)
             static const GdbCmdParseEntry file_io_cmd_desc = {
                 .handler = gdb_handle_file_io,
                 .cmd = "F",
-                .cmd_startswith = 1,
+                .cmd_startswith = true,
                 .schema = "L,L,o0"
             };
             cmd_parser = &file_io_cmd_desc;
@@ -2110,7 +2110,7 @@ static int gdb_handle_packet(const char *line_buf)
             static const GdbCmdParseEntry read_all_regs_cmd_desc = {
                 .handler = handle_read_all_regs,
                 .cmd = "g",
-                .cmd_startswith = 1
+                .cmd_startswith = true
             };
             cmd_parser = &read_all_regs_cmd_desc;
         }
@@ -2120,7 +2120,7 @@ static int gdb_handle_packet(const char *line_buf)
             static const GdbCmdParseEntry write_all_regs_cmd_desc = {
                 .handler = handle_write_all_regs,
                 .cmd = "G",
-                .cmd_startswith = 1,
+                .cmd_startswith = true,
                 .schema = "s0"
             };
             cmd_parser = &write_all_regs_cmd_desc;
@@ -2131,7 +2131,7 @@ static int gdb_handle_packet(const char *line_buf)
             static const GdbCmdParseEntry read_mem_cmd_desc = {
                 .handler = handle_read_mem,
                 .cmd = "m",
-                .cmd_startswith = 1,
+                .cmd_startswith = true,
                 .schema = "L,L0"
             };
             cmd_parser = &read_mem_cmd_desc;
@@ -2142,7 +2142,7 @@ static int gdb_handle_packet(const char *line_buf)
             static const GdbCmdParseEntry write_mem_cmd_desc = {
                 .handler = handle_write_mem,
                 .cmd = "M",
-                .cmd_startswith = 1,
+                .cmd_startswith = true,
                 .schema = "L,L:s0"
             };
             cmd_parser = &write_mem_cmd_desc;
@@ -2153,7 +2153,7 @@ static int gdb_handle_packet(const char *line_buf)
             static const GdbCmdParseEntry get_reg_cmd_desc = {
                 .handler = handle_get_reg,
                 .cmd = "p",
-                .cmd_startswith = 1,
+                .cmd_startswith = true,
                 .schema = "L0"
             };
             cmd_parser = &get_reg_cmd_desc;
@@ -2164,7 +2164,7 @@ static int gdb_handle_packet(const char *line_buf)
             static const GdbCmdParseEntry set_reg_cmd_desc = {
                 .handler = handle_set_reg,
                 .cmd = "P",
-                .cmd_startswith = 1,
+                .cmd_startswith = true,
                 .schema = "L?s0"
             };
             cmd_parser = &set_reg_cmd_desc;
@@ -2175,7 +2175,7 @@ static int gdb_handle_packet(const char *line_buf)
             static const GdbCmdParseEntry insert_bp_cmd_desc = {
                 .handler = handle_insert_bp,
                 .cmd = "Z",
-                .cmd_startswith = 1,
+                .cmd_startswith = true,
                 .schema = "l?L?L0"
             };
             cmd_parser = &insert_bp_cmd_desc;
@@ -2186,7 +2186,7 @@ static int gdb_handle_packet(const char *line_buf)
             static const GdbCmdParseEntry remove_bp_cmd_desc = {
                 .handler = handle_remove_bp,
                 .cmd = "z",
-                .cmd_startswith = 1,
+                .cmd_startswith = true,
                 .schema = "l?L?L0"
             };
             cmd_parser = &remove_bp_cmd_desc;
@@ -2197,7 +2197,7 @@ static int gdb_handle_packet(const char *line_buf)
             static const GdbCmdParseEntry set_thread_cmd_desc = {
                 .handler = handle_set_thread,
                 .cmd = "H",
-                .cmd_startswith = 1,
+                .cmd_startswith = true,
                 .schema = "o.t0"
             };
             cmd_parser = &set_thread_cmd_desc;
@@ -2208,7 +2208,7 @@ static int gdb_handle_packet(const char *line_buf)
             static const GdbCmdParseEntry thread_alive_cmd_desc = {
                 .handler = handle_thread_alive,
                 .cmd = "T",
-                .cmd_startswith = 1,
+                .cmd_startswith = true,
                 .schema = "t0"
             };
             cmd_parser = &thread_alive_cmd_desc;
@@ -2219,7 +2219,7 @@ static int gdb_handle_packet(const char *line_buf)
             static const GdbCmdParseEntry gen_query_cmd_desc = {
                 .handler = handle_gen_query,
                 .cmd = "q",
-                .cmd_startswith = 1,
+                .cmd_startswith = true,
                 .schema = "s0"
             };
             cmd_parser = &gen_query_cmd_desc;
@@ -2230,7 +2230,7 @@ static int gdb_handle_packet(const char *line_buf)
             static const GdbCmdParseEntry gen_set_cmd_desc = {
                 .handler = handle_gen_set,
                 .cmd = "Q",
-                .cmd_startswith = 1,
+                .cmd_startswith = true,
                 .schema = "s0"
             };
             cmd_parser = &gen_set_cmd_desc;
-- 
2.34.1


