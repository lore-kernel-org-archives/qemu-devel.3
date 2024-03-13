Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 10112C54E58
	for <qemu-devel@archiver.kernel.org>; Wed, 13 Mar 2024 21:36:36 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rkWF3-0001Vq-Qs; Wed, 13 Mar 2024 17:34:29 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rkWF2-0001V3-M0
 for qemu-devel@nongnu.org; Wed, 13 Mar 2024 17:34:28 -0400
Received: from mail-wm1-x332.google.com ([2a00:1450:4864:20::332])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rkWEm-0007mM-Gm
 for qemu-devel@nongnu.org; Wed, 13 Mar 2024 17:34:28 -0400
Received: by mail-wm1-x332.google.com with SMTP id
 5b1f17b1804b1-413f1853b64so174785e9.3
 for <qemu-devel@nongnu.org>; Wed, 13 Mar 2024 14:34:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1710365650; x=1710970450; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Mop7Z5XVl4lLMq97v4+OC8Djyhqf7oPYLBMfdu8kMMs=;
 b=xnE1TCbdcHZLbLA3PLHxjeFkfqg1YXQWcgdoUf4YOYT53SMouZcmS1sgvYkJMr9DLM
 4quU5Dk03xpicflLj/TlVbPCZL/Z41SaOOow0lpXCNkHrmwTkp+rzCMOqagDi8NFUkmi
 p/Bet2YqBkA2aJKmUX5lEetcrppVEg4F/npkh5ei8u5oTw/GX0AVX2vy/Bh86CVihFUe
 bmgnJsbvdjabR2pnooEHXcoRgYrbg2r52V4MuLJ6ktotuNzgW9QRXI9FohAQJ8asvDfE
 jm7gWsltXIn/OmoM5Wpx8FLCjidsZ/7CFlkArgprQWe/6/luC8YZEfdnp8kHIsUA1OmQ
 VEyQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1710365650; x=1710970450;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Mop7Z5XVl4lLMq97v4+OC8Djyhqf7oPYLBMfdu8kMMs=;
 b=OdFgLg5w0dg0+vy0rKdAYzhKjac4xrEJ2vtcv0FqcXo9saP9fBfL2QcnKNmHUiabA3
 ClW7IuQfrWdgXXszWv2tc4nepp4wUg1JKW2uazyFWRF0puxOJ2T0Ugc/9ee7hqxRiiT1
 qMO7I6MN3sQo7UtRhvodNFqg4yLlT5Ee7oKPwtj39g8OHPP1h4dClU1leM6DsrP+yjgo
 PDoV1M2rdC0UQkSo+u7pgehQYikw4hzNz5Ip+8Xwc3K/Vcpy9vel/e8qhnsM+poXERFm
 A9KLHadNrBwIEH2HpuerDyRCjZY2PcGhQobuVYMeb5QdTv1mu9du1uZY60zj4oYgp4jv
 rhkQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCUWdHacJiFGyJsAv/8TyTytiO8V7cjKIva057VKyZ92d/nakKsA1nWJ49LyliLGzDoqBy9KLqegSu0DDPWCs5UIepCL9IE=
X-Gm-Message-State: AOJu0YznJ6foLMRIkYWe7k3lPKAoBIYzOMHuSaUEnxFla/z/miwA+5UK
 I4mXdD2zQ8dKhva1xhx2tdxY0Q6lb5M7gCHit8g4NtJZeGY/XSGw8DyrQd8YnQo=
X-Google-Smtp-Source: AGHT+IHCuF1wlxBec2FSTOP7Kfl2CcKkxtYeqc0aUQOMU/oOnhiirnhopkXorE8z+tIt+NfNOUXPIg==
X-Received: by 2002:a05:600c:19cd:b0:413:ea5a:7787 with SMTP id
 u13-20020a05600c19cd00b00413ea5a7787mr25095wmq.22.1710365650111; 
 Wed, 13 Mar 2024 14:34:10 -0700 (PDT)
Received: from m1x-phil.lan ([176.176.182.179])
 by smtp.gmail.com with ESMTPSA id
 h2-20020a05600c350200b00413177c3f1dsm280038wmq.18.2024.03.13.14.34.07
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Wed, 13 Mar 2024 14:34:08 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: Richard Henderson <richard.henderson@linaro.org>,
	qemu-devel@nongnu.org
Cc: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>, Thomas Huth <thuth@redhat.com>,
 qemu-ppc@nongnu.org
Subject: [PATCH-for-9.0? 04/12] gdbstub/system: Rename 'user_ctx' argument as
 'ctx'
Date: Wed, 13 Mar 2024 22:33:31 +0100
Message-ID: <20240313213339.82071-5-philmd@linaro.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20240313213339.82071-1-philmd@linaro.org>
References: <20240313213339.82071-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::332;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x332.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=unavailable autolearn_force=no
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

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 gdbstub/internals.h | 8 ++++----
 gdbstub/system.c    | 8 ++++----
 2 files changed, 8 insertions(+), 8 deletions(-)

diff --git a/gdbstub/internals.h b/gdbstub/internals.h
index 7055138dee..e39c4b113c 100644
--- a/gdbstub/internals.h
+++ b/gdbstub/internals.h
@@ -187,7 +187,7 @@ typedef union GdbCmdVariant {
 
 #define get_param(p, i)    (&g_array_index(p, GdbCmdVariant, i))
 
-void gdb_handle_query_rcmd(GArray *params, void *user_ctx); /* system */
+void gdb_handle_query_rcmd(GArray *params, void *ctx); /* system */
 void gdb_handle_query_offsets(GArray *params, void *user_ctx); /* user */
 void gdb_handle_query_xfer_auxv(GArray *params, void *user_ctx); /*user */
 void gdb_handle_v_file_open(GArray *params, void *user_ctx); /* user */
@@ -200,11 +200,11 @@ void gdb_handle_query_supported_user(const char *gdb_supported); /* user */
 bool gdb_handle_set_thread_user(uint32_t pid, uint32_t tid); /* user */
 bool gdb_handle_detach_user(uint32_t pid); /* user */
 
-void gdb_handle_query_attached(GArray *params, void *user_ctx); /* both */
+void gdb_handle_query_attached(GArray *params, void *ctx); /* both */
 
 /* system only */
-void gdb_handle_query_qemu_phy_mem_mode(GArray *params, void *user_ctx);
-void gdb_handle_set_qemu_phy_mem_mode(GArray *params, void *user_ctx);
+void gdb_handle_query_qemu_phy_mem_mode(GArray *params, void *ctx);
+void gdb_handle_set_qemu_phy_mem_mode(GArray *params, void *ctx);
 
 /* sycall handling */
 void gdb_handle_file_io(GArray *params, void *user_ctx);
diff --git a/gdbstub/system.c b/gdbstub/system.c
index a3ce384cd1..d235403855 100644
--- a/gdbstub/system.c
+++ b/gdbstub/system.c
@@ -488,13 +488,13 @@ bool gdb_can_reverse(void)
  */
 
 void gdb_handle_query_qemu_phy_mem_mode(GArray *params,
-                                        void *user_ctx)
+                                        void *ctx)
 {
     g_string_printf(gdbserver_state.str_buf, "%d", phy_memory_mode);
     gdb_put_strbuf();
 }
 
-void gdb_handle_set_qemu_phy_mem_mode(GArray *params, void *user_ctx)
+void gdb_handle_set_qemu_phy_mem_mode(GArray *params, void *ctx)
 {
     if (!params->len) {
         gdb_put_packet("E22");
@@ -509,7 +509,7 @@ void gdb_handle_set_qemu_phy_mem_mode(GArray *params, void *user_ctx)
     gdb_put_packet("OK");
 }
 
-void gdb_handle_query_rcmd(GArray *params, void *user_ctx)
+void gdb_handle_query_rcmd(GArray *params, void *ctx)
 {
     const guint8 zero = 0;
     int len;
@@ -539,7 +539,7 @@ void gdb_handle_query_rcmd(GArray *params, void *user_ctx)
  * Execution state helpers
  */
 
-void gdb_handle_query_attached(GArray *params, void *user_ctx)
+void gdb_handle_query_attached(GArray *params, void *ctx)
 {
     gdb_put_packet("1");
 }
-- 
2.41.0


