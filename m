Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 78F01C5475B
	for <qemu-devel@archiver.kernel.org>; Sat,  9 Mar 2024 03:12:14 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rin6n-0000xc-O1; Fri, 08 Mar 2024 22:10:49 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <gustavo.romero@linaro.org>)
 id 1rin6b-0000tr-SF
 for qemu-devel@nongnu.org; Fri, 08 Mar 2024 22:10:39 -0500
Received: from mail-pj1-x102b.google.com ([2607:f8b0:4864:20::102b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <gustavo.romero@linaro.org>)
 id 1rin6a-00049D-19
 for qemu-devel@nongnu.org; Fri, 08 Mar 2024 22:10:37 -0500
Received: by mail-pj1-x102b.google.com with SMTP id
 98e67ed59e1d1-29acdf99d5aso1885546a91.2
 for <qemu-devel@nongnu.org>; Fri, 08 Mar 2024 19:10:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1709953833; x=1710558633; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=cJ2k7mY3US4N+1K4KGAFenl+VPGVVipLS3o/9vKMmQg=;
 b=PD1l+LvqdDS3GAC+Kw6RzqxYJ9EK+wF5A4drr8Oj0KDOGDtIA/lerfjzez0bAs56p5
 Frk75iynltR0qz1n/uxtpHYT1sPPJGxo4f4TIKqde+GQPRNn322Pvf1MKWVG6hhuEtOp
 I1+5qh+pacjyCY5+yBGy8MLQx/0GzbnMQOlS3LPfOY5C1GbANhx5gSP5IDUCLti2VrV9
 4h0UvkFxmE6EDIDGPySjN/7gZCDMbebDBQfkPgVWm2CghG583FW+EAXGqCoHHsMiw/zb
 u/EE3Q7doZsx0o7JDscffs/yi9Tq9II1jxFGZK07teAdc38SToxhIPHZEN+uOly7UV7J
 jTcg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1709953833; x=1710558633;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=cJ2k7mY3US4N+1K4KGAFenl+VPGVVipLS3o/9vKMmQg=;
 b=isIdKYL5f2HKSwOQRcttHKEozIChFhsbKbWItREdInzGgM9EiEhBWXZyHPkJO1UU3C
 nmdy6K1zW2MmrzbQs1dabhDsoHA7CfiPltfV3hcNe5CNZYAYL/UlrZOD23iXzjo2Lnbi
 qjpdKpsHv2ETrWRfGUQMCxjIDsDsq9SBaAmbqaak1hNrSZbQ5Htoupib7rVeXaAyTC8M
 9QiyxDOmaZ/hCRLrgKDOIK7IO+FFZd212cS6crRrdZy7YtVs/CcpIxcyY/tDzlYLjVYZ
 +szwrKbLFt3STlauMpq945ErbxgmWLpRjKnwJB6xevlIYmCRDfcSd0v/DP8CB6SJNDHQ
 U9vw==
X-Gm-Message-State: AOJu0YxmcDnPHODLfvHLIRZlE1WMMQW/9OKojgh1KdMWn6JPjiKGbYvr
 B9CJDimR6qFgt0H/CUFc+l2pwOkBi5/d1v7j4mGbXbsRajMnKOx9geh97zc8iSimfh6EW+SnlQG
 wY4U=
X-Google-Smtp-Source: AGHT+IG75RuJTzTotx3d5QE9H4+l4xE3JCI1kwO98e8sfnkSF5PDYie08RpRCWl6UprtNQhhYs9PsA==
X-Received: by 2002:a17:903:1103:b0:1dc:f91b:5e96 with SMTP id
 n3-20020a170903110300b001dcf91b5e96mr570599plh.59.1709953832868; 
 Fri, 08 Mar 2024 19:10:32 -0800 (PST)
Received: from amd.. ([2804:7f0:b401:7e8e:3e7c:3fff:fe7a:e83b])
 by smtp.gmail.com with ESMTPSA id
 w13-20020a170902d3cd00b001dd707d5fe6sm349566plb.158.2024.03.08.19.10.30
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 08 Mar 2024 19:10:32 -0800 (PST)
From: Gustavo Romero <gustavo.romero@linaro.org>
To: qemu-devel@nongnu.org,
	richard.henderson@linaro.org
Cc: alex.bennee@linaro.org, peter.maydell@linaro.org, laurent@vivier.eu,
 philmd@linaro.org, gustavo.romero@linaro.org
Subject: [PATCH v3 4/5] gdbstub: Add Xfer:siginfo:read stub
Date: Sat,  9 Mar 2024 03:09:00 +0000
Message-Id: <20240309030901.1726211-5-gustavo.romero@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240309030901.1726211-1-gustavo.romero@linaro.org>
References: <20240309030901.1726211-1-gustavo.romero@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::102b;
 envelope-from=gustavo.romero@linaro.org; helo=mail-pj1-x102b.google.com
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

Add stub to handle Xfer:siginfo:read packet query that requests the
machine's siginfo data.

This is used when GDB user executes 'print $_siginfo' and when the
machine stops due to a signal, for instance, on SIGSEGV. The information
in siginfo allows GDB to determiner further details on the signal, like
the fault address/insn when the SIGSEGV is caught.

Signed-off-by: Gustavo Romero <gustavo.romero@linaro.org>
---
 gdbstub/gdbstub.c   |  8 ++++++++
 gdbstub/internals.h |  1 +
 gdbstub/user.c      | 23 +++++++++++++++++++++++
 3 files changed, 32 insertions(+)

diff --git a/gdbstub/gdbstub.c b/gdbstub/gdbstub.c
index 2909bc8c69..ab38cea46b 100644
--- a/gdbstub/gdbstub.c
+++ b/gdbstub/gdbstub.c
@@ -1651,6 +1651,8 @@ static void handle_query_supported(GArray *params, void *user_ctx)
         g_string_append(gdbserver_state.str_buf, ";qXfer:auxv:read+");
     }
     g_string_append(gdbserver_state.str_buf, ";QCatchSyscalls+");
+
+    g_string_append(gdbserver_state.str_buf, ";qXfer:siginfo:read+");
 #endif
     g_string_append(gdbserver_state.str_buf, ";qXfer:exec-file:read+");
 #endif
@@ -1799,6 +1801,12 @@ static const GdbCmdParseEntry gdb_gen_query_table[] = {
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
diff --git a/gdbstub/user.c b/gdbstub/user.c
index df040c6ffa..5e175b5d62 100644
--- a/gdbstub/user.c
+++ b/gdbstub/user.c
@@ -616,3 +616,26 @@ void gdb_handle_set_catch_syscalls(GArray *params, void *user_ctx)
 err:
     gdb_put_packet("E00");
 }
+
+void gdb_handle_query_xfer_siginfo(GArray *params, void *user_ctx)
+{
+    unsigned long offset, len;
+    uint8_t *siginfo_offset;
+
+    offset = get_param(params, 0)->val_ul;
+    len = get_param(params, 1)->val_ul;
+
+    if (offset + len > gdbserver_user_state.siginfo_len) {
+        /* Invalid offset and/or requested length. */
+        gdb_put_packet("E01");
+        return;
+    }
+
+    siginfo_offset = (uint8_t *)gdbserver_user_state.siginfo + offset;
+
+    /* Reply */
+    g_string_assign(gdbserver_state.str_buf, "l");
+    gdb_memtox(gdbserver_state.str_buf, (const char *)siginfo_offset, len);
+    gdb_put_packet_binary(gdbserver_state.str_buf->str,
+                          gdbserver_state.str_buf->len, true);
+}
-- 
2.34.1


