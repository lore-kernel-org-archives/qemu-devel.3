Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A2394C48BF6
	for <qemu-devel@archiver.kernel.org>; Sun,  3 Mar 2024 19:27:24 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rgrTv-00048X-5G; Sun, 03 Mar 2024 14:26:43 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <gustavo.romero@linaro.org>)
 id 1rgrTt-000489-Vx
 for qemu-devel@nongnu.org; Sun, 03 Mar 2024 14:26:42 -0500
Received: from mail-pf1-x429.google.com ([2607:f8b0:4864:20::429])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <gustavo.romero@linaro.org>)
 id 1rgrTs-00031B-8W
 for qemu-devel@nongnu.org; Sun, 03 Mar 2024 14:26:41 -0500
Received: by mail-pf1-x429.google.com with SMTP id
 d2e1a72fcca58-6e56da425b5so2694310b3a.0
 for <qemu-devel@nongnu.org>; Sun, 03 Mar 2024 11:26:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1709493993; x=1710098793; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=d5m9mhIK8JyytOQksDR6IYtiA11v8ohv/oTiKgv5/GE=;
 b=LcEAtvvtjtxtzXyVKdfDGlwecnBh8mGkOTSfVdZEGG5+Ce8Uz+xkExtn1OfcPI8SbK
 iWIfczPueDO1NNGJ54BV/tyJ/L2Ic+FBP3HdhQZfqQueQtecgcBg7VdMG8XK3g6mtSUU
 I1oE/wm0agjS7pnX357wX5V+nPn5K8Gb/JfVuFnmKVY0GqTdQQdhy+4qIqvNthLIZ1Ur
 Pu1UPP0Ad4Sk7F8dvEnSNop9cNOLU99PazuHyeZDyOaKkf27trpeCUhxUDh6e8tIND4S
 ZzRpE+5PNA1nEj3WMEvjfNqt6ZVhg7ygukAq2JS4dM7lXq9LyaM/Q3N9rLqPTMz8vjyW
 w/lQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1709493993; x=1710098793;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=d5m9mhIK8JyytOQksDR6IYtiA11v8ohv/oTiKgv5/GE=;
 b=TQdyKL9eEwm+3vMSutSf+6FHxUlz4SASPu7WuzOMeSwMgsrdf+tPp9QoAwQBy46+jP
 LzVht4A/gaBt/NJj9vSiNwnvlUPnKSXWRXLSOI5M/kmwQBLunaqWVh32CIhDLfnKBSvt
 Eywzz4VzaHi7bNMCzIgTik/nX0R5UN4cJBCwi7h04ouccQN2n0mFwOBT4n3taEYOF+GI
 kp4Fw3UvFq/ivlWx+yQt+pxMc/Eekqj4jOPRaF+evxqXZHq8KNcq6tfOsBWRoBy0D6+z
 NC4N7FzzSYHFHJQKi3H6Nu/E+0qUEzEfJ4UWDUZ/51imVlz3nN6WimJg/dvew5pfny9U
 f+eg==
X-Gm-Message-State: AOJu0YwbCqbgio6S5LFL8Q8vxDiEW/rZerscDChQnSChZUaUeRgHWTzD
 cnjpNFwnJ7TYLWC2oPKLeqKK8xrfyWeBQVBK1F9KmSS6FU9EIgq8NhiGBy1Z1eRoNtCbtqPQUxO
 Z
X-Google-Smtp-Source: AGHT+IGEwsfhYHXN+Tn1tAwL4LwbMvg/EC2Ttbow815mKScrPcKmLMGdinobTqTCR0WeCTjD89cvGA==
X-Received: by 2002:a05:6a00:1915:b0:6e5:75cd:eff0 with SMTP id
 y21-20020a056a00191500b006e575cdeff0mr7141652pfi.31.1709493992604; 
 Sun, 03 Mar 2024 11:26:32 -0800 (PST)
Received: from amd.. ([2804:7f0:b401:120f:3e7c:3fff:fe7a:e83b])
 by smtp.gmail.com with ESMTPSA id
 du6-20020a056a002b4600b006e5933a0da9sm5941287pfb.165.2024.03.03.11.26.30
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 03 Mar 2024 11:26:32 -0800 (PST)
From: Gustavo Romero <gustavo.romero@linaro.org>
To: qemu-devel@nongnu.org,
	alex.bennee@linaro.org
Cc: peter.maydell@linaro.org,
	gustavo.romero@linaro.org
Subject: [PATCH 1/2] gdbstub: Add Xfer:siginfo:read stub
Date: Sun,  3 Mar 2024 19:26:09 +0000
Message-Id: <20240303192610.498490-1-gustavo.romero@linaro.org>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::429;
 envelope-from=gustavo.romero@linaro.org; helo=mail-pf1-x429.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
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

Add stub to handle Xfer:siginfo:read query that requests the machine's
siginfo data.

This is used when GDB users execute 'print $_siginfo' and when the
machine stops due to a signal, like on a SIGSEGV. The information in
siginfo allows GDB to determine further details on the signal, like the
fault address/insn when the SIGSEGV is caught. The siginfo is also used
by GDB to find out the si_code automatically and show additional info to
the user in some cases.

This is only a QEMU user mode and Linux-only feature.

Signed-off-by: Gustavo Romero <gustavo.romero@linaro.org>
---
 gdbstub/gdbstub.c     |  9 +++++++++
 gdbstub/internals.h   |  1 +
 gdbstub/user-target.c | 31 +++++++++++++++++++++++++++++++
 3 files changed, 41 insertions(+)

diff --git a/gdbstub/gdbstub.c b/gdbstub/gdbstub.c
index 2909bc8c69..54c1f6fb3c 100644
--- a/gdbstub/gdbstub.c
+++ b/gdbstub/gdbstub.c
@@ -1650,7 +1650,10 @@ static void handle_query_supported(GArray *params, void *user_ctx)
     if (gdbserver_state.c_cpu->opaque) {
         g_string_append(gdbserver_state.str_buf, ";qXfer:auxv:read+");
     }
+
     g_string_append(gdbserver_state.str_buf, ";QCatchSyscalls+");
+
+    g_string_append(gdbserver_state.str_buf, ";qXfer:siginfo:read+");
 #endif
     g_string_append(gdbserver_state.str_buf, ";qXfer:exec-file:read+");
 #endif
@@ -1799,6 +1802,12 @@ static const GdbCmdParseEntry gdb_gen_query_table[] = {
         .cmd_startswith = 1,
         .schema = "l,l0"
     },
+    {
+        .handler = gdb_handle_query_xfer_siginfo,
+        .cmd = "Xfer:siginfo:read::",
+        .cmd_startswith = 1,
+        .schema = "l,l0"
+     },
 #endif
     {
         .handler = gdb_handle_query_xfer_exec_file,
diff --git a/gdbstub/internals.h b/gdbstub/internals.h
index 56b7c13b75..fcfe7c2d26 100644
--- a/gdbstub/internals.h
+++ b/gdbstub/internals.h
@@ -190,6 +190,7 @@ typedef union GdbCmdVariant {
 void gdb_handle_query_rcmd(GArray *params, void *user_ctx); /* softmmu */
 void gdb_handle_query_offsets(GArray *params, void *user_ctx); /* user */
 void gdb_handle_query_xfer_auxv(GArray *params, void *user_ctx); /*user */
+void gdb_handle_query_xfer_siginfo(GArray *params, void *user_ctx); /*user */
 void gdb_handle_v_file_open(GArray *params, void *user_ctx); /* user */
 void gdb_handle_v_file_close(GArray *params, void *user_ctx); /* user */
 void gdb_handle_v_file_pread(GArray *params, void *user_ctx); /* user */
diff --git a/gdbstub/user-target.c b/gdbstub/user-target.c
index b7d4c37cd8..3a4cf96622 100644
--- a/gdbstub/user-target.c
+++ b/gdbstub/user-target.c
@@ -284,6 +284,37 @@ void gdb_handle_query_xfer_auxv(GArray *params, void *user_ctx)
     gdb_put_packet_binary(gdbserver_state.str_buf->str,
                       gdbserver_state.str_buf->len, true);
 }
+
+void gdb_handle_query_xfer_siginfo(GArray *params, void *user_ctx)
+{
+    TaskState *ts;
+    unsigned long offset, len;
+    target_siginfo_t tmp_siginfo;
+    uint8_t *siginfo_offset;
+
+    offset = get_param(params, 0)->val_ul;
+    len = get_param(params, 1)->val_ul;
+
+    if (offset + len > sizeof(target_siginfo_t)) {
+        /* Invalid offset and/or requested length. */
+        gdb_put_packet("E01");
+        return;
+    }
+
+    ts = gdbserver_state.c_cpu->opaque;
+
+    /* Filter out si_type from si_code. See comment in siginfo_noswap(). */
+    tmp_siginfo = ts->sync_signal.info;
+    tmp_siginfo.si_code = sextract32(tmp_siginfo.si_code, 0, 16);
+
+    siginfo_offset = (uint8_t *)&tmp_siginfo + offset;
+
+    /* Reply */
+    g_string_assign(gdbserver_state.str_buf, "l");
+    gdb_memtox(gdbserver_state.str_buf, (const char *)siginfo_offset, len);
+    gdb_put_packet_binary(gdbserver_state.str_buf->str,
+                          gdbserver_state.str_buf->len, true);
+}
 #endif
 
 static const char *get_filename_param(GArray *params, int i)
-- 
2.34.1


