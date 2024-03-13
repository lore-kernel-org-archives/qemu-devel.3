Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A74CFC54E66
	for <qemu-devel@archiver.kernel.org>; Wed, 13 Mar 2024 21:35:15 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rkWEn-0001OK-B7; Wed, 13 Mar 2024 17:34:13 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rkWEh-0001Lt-QR
 for qemu-devel@nongnu.org; Wed, 13 Mar 2024 17:34:07 -0400
Received: from mail-wr1-x430.google.com ([2a00:1450:4864:20::430])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rkWEe-0007lP-6t
 for qemu-devel@nongnu.org; Wed, 13 Mar 2024 17:34:07 -0400
Received: by mail-wr1-x430.google.com with SMTP id
 ffacd0b85a97d-33eaafc4419so929705f8f.0
 for <qemu-devel@nongnu.org>; Wed, 13 Mar 2024 14:34:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1710365643; x=1710970443; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=uuIA7snzjzJiFQGDzy7Q/aN2eTCJoDKnsUbMdeEplEw=;
 b=FSHEEgOgac6vBkgLCgzc4U3EOB8nYfdwa62xIazqXk9886zyIozSCgD8/M3eZk8Li3
 s5Ow3QncZWOci54U+378xve2pXL9VsonR/M6vNJ8Sq4RxTM5y2nH7UudRKyhlFyyOSr+
 uua9fMpwvDarW9kAjOwk1k71HMF7vxI7t4wLaw96ZgW74f2C3O3qH4SocAV87BmkXH8s
 /Kg6MxxyTUzXBVuB5AwkYnVIc0EOKVxvJnKSZgfh4wu9kp4qL1uzTVp07o4fgyM1d5xt
 fXlFvo8Z1bbruFfq+zi2eL9Pq1jvln9yE4e5bZJHnM3utnxSRL8H+2RCk6SOIjeUFvEN
 Do/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1710365643; x=1710970443;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=uuIA7snzjzJiFQGDzy7Q/aN2eTCJoDKnsUbMdeEplEw=;
 b=ROeRKRlk6pGIYpt7jfx9KDhGt40IxYfzfTMUyCL38f3kdpx6lFniKD1antQwCE66aj
 pzkfoTrZv1mgTvWUjhIZSBur1zxF20J3HkpT6lYv8rRHsMxqTgvwRWekEwEmCQqVOLek
 UO7qIrZhzWAk4Tmr3e3lo0Lm6B+Kn9FfC5g6TKzTdgau252nTNDl+yQdazRPighUwoWX
 3XxoZICIrDA27WMnQ2s/ftqL5BWRZVnw/g10zrbXwGTRSnSkNnipUlTYcbQnOKGaQesJ
 Wf8Z5YNu5FUZebKQcQkTQPa636qXkSj4YnazhGPK4wYIKxeEu1xkNYg67f7kjQVv+NuD
 7vkg==
X-Forwarded-Encrypted: i=1;
 AJvYcCUcygHxUszxwuig1DJA/dFvrCLTm8yaiULLGejIEVKvDz5HrLAevsC0f+dYMGL19isYbm7cbgg4UHhK9CJdEScNO6tELe8=
X-Gm-Message-State: AOJu0YymeAe2sC5Ec8rxLMR8faUZx72hopb92GCnJsk3RRG09Hb7+UFj
 WjiWKsj3wP2G5bbCVHsQh+81p8qN/kFTKtqpm8pfK42AwmBlqir6q+e9LMj9u3A=
X-Google-Smtp-Source: AGHT+IF8GIBRoGhlQMCieR/Zp6nPhkmxqt6EJQqbxmZNV+EaNoeNivyzrnwDdv7z2KeoSRV67WmEVg==
X-Received: by 2002:adf:fece:0:b0:33d:7e9:9543 with SMTP id
 q14-20020adffece000000b0033d07e99543mr25952wrs.32.1710365642885; 
 Wed, 13 Mar 2024 14:34:02 -0700 (PDT)
Received: from m1x-phil.lan ([176.176.182.179])
 by smtp.gmail.com with ESMTPSA id
 p3-20020a5d4e03000000b0033e9e26a2d0sm74645wrt.37.2024.03.13.14.34.01
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Wed, 13 Mar 2024 14:34:02 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: Richard Henderson <richard.henderson@linaro.org>,
	qemu-devel@nongnu.org
Cc: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>, Thomas Huth <thuth@redhat.com>,
 qemu-ppc@nongnu.org
Subject: [PATCH-for-9.0? 03/12] gdbstub: Correct invalid mentions of 'softmmu'
 by 'system'
Date: Wed, 13 Mar 2024 22:33:30 +0100
Message-ID: <20240313213339.82071-4-philmd@linaro.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20240313213339.82071-1-philmd@linaro.org>
References: <20240313213339.82071-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::430;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x430.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
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
 gdbstub/internals.h | 20 ++++++++++----------
 gdbstub/system.c    |  2 +-
 2 files changed, 11 insertions(+), 11 deletions(-)

diff --git a/gdbstub/internals.h b/gdbstub/internals.h
index b472459838..7055138dee 100644
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
 void gdb_handle_v_file_open(GArray *params, void *user_ctx); /* user */
@@ -202,7 +202,7 @@ bool gdb_handle_detach_user(uint32_t pid); /* user */
 
 void gdb_handle_query_attached(GArray *params, void *user_ctx); /* both */
 
-/* softmmu only */
+/* system only */
 void gdb_handle_query_qemu_phy_mem_mode(GArray *params, void *user_ctx);
 void gdb_handle_set_qemu_phy_mem_mode(GArray *params, void *user_ctx);
 
@@ -212,11 +212,11 @@ bool gdb_handled_syscall(void);
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


