Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A9479CD1284
	for <qemu-devel@archiver.kernel.org>; Tue,  2 Apr 2024 14:26:33 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rrf4L-0000lm-Ux; Tue, 02 Apr 2024 10:24:58 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rrf4I-0000kO-4I
 for qemu-devel@nongnu.org; Tue, 02 Apr 2024 10:24:54 -0400
Received: from mail-wm1-x336.google.com ([2a00:1450:4864:20::336])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rrf4F-0007az-KL
 for qemu-devel@nongnu.org; Tue, 02 Apr 2024 10:24:53 -0400
Received: by mail-wm1-x336.google.com with SMTP id
 5b1f17b1804b1-4156dfa8a5cso9454175e9.3
 for <qemu-devel@nongnu.org>; Tue, 02 Apr 2024 07:24:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1712067890; x=1712672690; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=1SmMA2WUYuMdtgR4elvc+VfJjaj3cdDvnYNz/tQrOUw=;
 b=hb7kieW82LlLJuoQnppfDJv3NIowOFcAqoWsZQzMZmJGrn2J7bClLxWBGsekgCdJVC
 6GBcwiXilliUtRRkLlJNRu+B3/Yktu0VKELk6Xx+nxTPnURMo8IKEhH3Dfq5JA0oBu9p
 BoRJj15zUKlorKuVpRwn/5LxQy5aSXJkTFG3dYtZXe4Uq0FELxM7V5a8njrJ19Ytz2DD
 +whb+VeJicvGkX04SPedxEZ/6Mh+t4grrXQEedydbKpBLOCnaZeRsT8ztgSu4U0R5wiE
 A20tnfcs4YEE+EGFV/vrEGxZOEuKZLXDVQZuPUq6PDkrkZjs3x53Fq7GEe8Dr0s27SMi
 Yvzg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1712067890; x=1712672690;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=1SmMA2WUYuMdtgR4elvc+VfJjaj3cdDvnYNz/tQrOUw=;
 b=gdsWvPHRH7DWpNiuE3SiSJr3hqGHmYT7Qa7dV0q2t9B/lscYFLvVnBsjSGdnyO6ZUj
 YkU+zbJLNOgV5eg3iKIagAQUYqRKCR9E/rmEQ3gn6OBs97SVo+UHAUS+u28TPIs9fl0j
 xwXi1vN5Wz3DpEEmOyY6mZfGJY23FcjPkLAsTRpyEvA8HF67MwzjuVL+jW1X3FjYrEOZ
 ZjC2rlf0HHKW3wzU9qgpHefnNsMhjapqzAunZQukrv55s3dBZvhDhyCTRwDnZkvonsfP
 1xfb33YMyqFp76wS0DNEX7BMgVxsf2FkD+BqwsU2jEfBDAbZCsT68XeWXUYXTF2Rxz56
 cCbA==
X-Gm-Message-State: AOJu0YwPdohQlah1gFIDR1DQjhB5BrI6L87hjk33xhgoSfAsXurlT9tY
 nKjjzuIeSdnjWydfoToAaQZFa4lRP3VF4T1Ofw1xJqVCSUmvoRXWCQa2JY94kkeAxROsabmiRf0
 eHvk=
X-Google-Smtp-Source: AGHT+IFCfFzlxgMnREUyncytBY03AG2ycFfrVg2xQ9fXZDUncxBQQ/fBaP/YQ6jaH0P9nFaeyeQWAQ==
X-Received: by 2002:a05:600c:1797:b0:415:8651:9bae with SMTP id
 x23-20020a05600c179700b0041586519baemr2547892wmo.41.1712067889798; 
 Tue, 02 Apr 2024 07:24:49 -0700 (PDT)
Received: from m1x-phil.lan ([176.187.202.91])
 by smtp.gmail.com with ESMTPSA id
 l2-20020adff482000000b0033ec312cd8asm14249866wro.33.2024.04.02.07.24.47
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Tue, 02 Apr 2024 07:24:49 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-ppc@nongnu.org, qemu-block@nongnu.org, qemu-arm@nongnu.org,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Thomas Huth <thuth@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
Subject: [PULL 02/15] gdbstub: Correct invalid mentions of 'softmmu' by
 'system'
Date: Tue,  2 Apr 2024 16:24:17 +0200
Message-ID: <20240402142431.70700-3-philmd@linaro.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20240402142431.70700-1-philmd@linaro.org>
References: <20240402142431.70700-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::336;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x336.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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
Reviewed-by: Thomas Huth <thuth@redhat.com>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Message-Id: <20240313213339.82071-3-philmd@linaro.org>
---
 gdbstub/internals.h | 20 ++++++++++----------
 gdbstub/system.c    |  2 +-
 2 files changed, 11 insertions(+), 11 deletions(-)

diff --git a/gdbstub/internals.h b/gdbstub/internals.h
index e83b179920..66c939c67f 100644
--- a/gdbstub/internals.h
+++ b/gdbstub/internals.h
@@ -115,7 +115,7 @@ void gdb_read_byte(uint8_t ch);
 
 /*
  * Packet acknowledgement - we handle this slightly differently
- * between user and softmmu mode, mainly to deal with the differences
+ * between user and system mode, mainly to deal with the differences
  * between the flexible chardev and the direct fd approaches.
  *
  * We currently don't support a negotiated QStartNoAckMode
@@ -125,7 +125,7 @@ void gdb_read_byte(uint8_t ch);
  * gdb_got_immediate_ack() - check ok to continue
  *
  * Returns true to continue, false to re-transmit for user only, the
- * softmmu stub always returns true.
+ * system stub always returns true.
  */
 bool gdb_got_immediate_ack(void);
 /* utility helpers */
@@ -135,12 +135,12 @@ CPUState *gdb_first_attached_cpu(void);
 void gdb_append_thread_id(CPUState *cpu, GString *buf);
 int gdb_get_cpu_index(CPUState *cpu);
 unsigned int gdb_get_max_cpus(void); /* both */
-bool gdb_can_reverse(void); /* softmmu, stub for user */
+bool gdb_can_reverse(void); /* system emulation, stub for user */
 int gdb_target_sigtrap(void); /* user */
 
 void gdb_create_default_process(GDBState *s);
 
-/* signal mapping, common for softmmu, specialised for user-mode */
+/* signal mapping, common for system, specialised for user-mode */
 int gdb_signal_to_target(int sig);
 int gdb_target_signal_to_gdb(int sig);
 
@@ -157,12 +157,12 @@ void gdb_continue(void);
 int gdb_continue_partial(char *newstates);
 
 /*
- * Helpers with separate softmmu and user implementations
+ * Helpers with separate system and user implementations
  */
 void gdb_put_buffer(const uint8_t *buf, int len);
 
 /*
- * Command handlers - either specialised or softmmu or user only
+ * Command handlers - either specialised or system or user only
  */
 void gdb_init_gdbserver_state(void);
 
@@ -187,7 +187,7 @@ typedef union GdbCmdVariant {
 
 #define get_param(p, i)    (&g_array_index(p, GdbCmdVariant, i))
 
-void gdb_handle_query_rcmd(GArray *params, void *user_ctx); /* softmmu */
+void gdb_handle_query_rcmd(GArray *params, void *user_ctx); /* system */
 void gdb_handle_query_offsets(GArray *params, void *user_ctx); /* user */
 void gdb_handle_query_xfer_auxv(GArray *params, void *user_ctx); /*user */
 void gdb_handle_query_xfer_siginfo(GArray *params, void *user_ctx); /*user */
@@ -203,7 +203,7 @@ bool gdb_handle_detach_user(uint32_t pid); /* user */
 
 void gdb_handle_query_attached(GArray *params, void *user_ctx); /* both */
 
-/* softmmu only */
+/* system only */
 void gdb_handle_query_qemu_phy_mem_mode(GArray *params, void *user_ctx);
 void gdb_handle_set_qemu_phy_mem_mode(GArray *params, void *user_ctx);
 
@@ -213,11 +213,11 @@ bool gdb_handled_syscall(void);
 void gdb_disable_syscalls(void);
 void gdb_syscall_reset(void);
 
-/* user/softmmu specific syscall handling */
+/* user/system specific syscall handling */
 void gdb_syscall_handling(const char *syscall_packet);
 
 /*
- * Break/Watch point support - there is an implementation for softmmu
+ * Break/Watch point support - there is an implementation for system
  * and user mode.
  */
 bool gdb_supports_guest_debug(void);
diff --git a/gdbstub/system.c b/gdbstub/system.c
index 83fd452800..a3ce384cd1 100644
--- a/gdbstub/system.c
+++ b/gdbstub/system.c
@@ -1,5 +1,5 @@
 /*
- * gdb server stub - softmmu specific bits
+ * gdb server stub - system specific bits
  *
  * Debug integration depends on support from the individual
  * accelerators so most of this involves calling the ops helpers.
-- 
2.41.0


