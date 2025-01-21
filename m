Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 32DC9C0218B
	for <qemu-devel@archiver.kernel.org>; Tue, 21 Jan 2025 11:43:54 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1taCdT-0005Mt-NZ; Tue, 21 Jan 2025 06:41:35 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1taCdQ-0005LV-Jb
 for qemu-devel@nongnu.org; Tue, 21 Jan 2025 06:41:32 -0500
Received: from mail-wr1-x42b.google.com ([2a00:1450:4864:20::42b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1taCdN-0003Of-B4
 for qemu-devel@nongnu.org; Tue, 21 Jan 2025 06:41:32 -0500
Received: by mail-wr1-x42b.google.com with SMTP id
 ffacd0b85a97d-3862d16b4f5so3145062f8f.0
 for <qemu-devel@nongnu.org>; Tue, 21 Jan 2025 03:41:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1737459686; x=1738064486; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=cyX5PKm7gMuZd0pQEaHJ3A+gIhVc1meczJHLvspqXIY=;
 b=durdhZqF4tHlWGW02QkwKNArmikCFFDrPqG3lD9cTmciT1gpTVpPX7UG+u0uLf/Vq5
 nayp1gVPvU00iwWVcNUSk9NKixOPQqCpBPwB+P+2abqf3rQqqUAW0Y3GJiZ8T4OoY6RF
 S2kuLuLM8cOsTe8JhENSXLMK7deBoTYZOv199P4JJ+h/NHWdf2KpYb0mIaXT4JR9AgVk
 McgcFUVjCypXQX4RVDR4Zl4cQWB2czaI8pTiWYziXwZeIltecfJMeYLVZujF/KVmnSzt
 RF42u57g91MFAC1+g1ebT3pMzT73NbgNPLazVDPEe3US/EsDb4/CZGWIep4KIL92GGPs
 Ff3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1737459686; x=1738064486;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=cyX5PKm7gMuZd0pQEaHJ3A+gIhVc1meczJHLvspqXIY=;
 b=G6CC2pHnLEWsZbJEZjY45e0a3erduTvmkRypXFgzi10yuL5lnCK9TyouBadCFssxjZ
 gkHFmgaNTfFwwYSOCRe+z0rYTmrQedKIHA0PJZNGahQKc3hX5wrSKB9txRRPbJ5PQ9JB
 /OiG7XMXzxQ/8MQuP7nenP7Mcb163Z/tJBxdDgIncPnCDNsnEgbtm1Nw2KJ6nyX5swqo
 KrZwpUmpajrU2X7Wm+cVjJ0BqPPmmhVMvR3vNz6ohLr8oxHfKnP3Yyo+Kgi5CX0qMhbD
 Xj+XzWTEoHX1APbSoBZfHwlI9+Ssfw86pi5m9RW6XYvWD54KyfOgObEZ/q3oK2I2iUGd
 6g0Q==
X-Gm-Message-State: AOJu0YwVPf9pvmtDr1TSsAJ3RdM0fR44hDzoKrhYNQ6Oo8X2ajQLEYDW
 C2hoXLtlHPwG3HtJ02Rnn2yQlLEjhu4yMT8Ley13wO/fx5MyHffSRFXJtlFMU7bu8kBk1AmEm4l
 AMEc=
X-Gm-Gg: ASbGncvoc/KxMnSLK9A5TRxGgLkL7UJTqyN2X9CGb/Ci0dy2m9xD+69wFW1sOUihDMf
 3mu+8AQVnCEmG0GU5BX0wZR7swOhu+1k0R6Lse/KzYQQt+mrOBWaJkW4HVgivTAIu3vOjXj7AIl
 mWAdk3tqXZBjj7YHhOWbdxgaIbJZtUVRbFcdqEr//XuKG3dzZQrnQ/HriCpfUGcd2m8iV7S/PMz
 J5vBQ8/nfqKK7Y/3djWkTSSJTlRgCI9pUE+pHHWDvNXWfuxppYdwVaWosKV/KX1wC3sDTYibNy7
 pGmLvUGoP/SZwoAGiNYcrHcVWmFyj9BdsXQnZWQy11g5
X-Google-Smtp-Source: AGHT+IEx+UQCtRLciv8/c/J74uoXTeSchq83sY/i+Oe2hK2uv70zHQ4B8Ug2Kfgs3imx44w9PRo+uQ==
X-Received: by 2002:a05:6000:2a1:b0:386:42b1:d7e4 with SMTP id
 ffacd0b85a97d-38bec54287fmr18087643f8f.19.1737459685675; 
 Tue, 21 Jan 2025 03:41:25 -0800 (PST)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4389046c59csm177990735e9.40.2025.01.21.03.41.24
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Tue, 21 Jan 2025 03:41:25 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Richard Henderson <richard.henderson@linaro.org>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 qemu-arm@nongnu.org,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH 06/11] gdbstub: Prefer cached CpuClass over CPU_GET_CLASS()
 macro
Date: Tue, 21 Jan 2025 12:40:51 +0100
Message-ID: <20250121114056.53949-7-philmd@linaro.org>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250121114056.53949-1-philmd@linaro.org>
References: <20250121114056.53949-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42b;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x42b.google.com
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

CpuState caches its CPUClass since commit 6fbdff87062
("cpu: cache CPUClass in CPUState for hot code paths"),
use it.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 gdbstub/gdbstub.c     | 26 +++++++++-----------------
 gdbstub/system.c      |  7 ++-----
 gdbstub/user-target.c |  6 ++----
 gdbstub/user.c        |  7 ++-----
 4 files changed, 15 insertions(+), 31 deletions(-)

diff --git a/gdbstub/gdbstub.c b/gdbstub/gdbstub.c
index e366df12d4a..282e13e163f 100644
--- a/gdbstub/gdbstub.c
+++ b/gdbstub/gdbstub.c
@@ -354,7 +354,6 @@ static const char *get_feature_xml(const char *p, const char **newp,
                                    GDBProcess *process)
 {
     CPUState *cpu = gdb_get_first_cpu_in_process(process);
-    CPUClass *cc = CPU_GET_CLASS(cpu);
     GDBRegisterState *r;
     size_t len;
 
@@ -377,11 +376,11 @@ static const char *get_feature_xml(const char *p, const char **newp,
                          "<!DOCTYPE target SYSTEM \"gdb-target.dtd\">"
                          "<target>"));
 
-            if (cc->gdb_arch_name) {
+            if (cpu->cc->gdb_arch_name) {
                 g_ptr_array_add(
                     xml,
                     g_markup_printf_escaped("<architecture>%s</architecture>",
-                                            cc->gdb_arch_name(cpu)));
+                                            cpu->cc->gdb_arch_name(cpu)));
             }
             for (guint i = 0; i < cpu->gdb_regs->len; i++) {
                 r = &g_array_index(cpu->gdb_regs, GDBRegisterState, i);
@@ -520,11 +519,10 @@ GArray *gdb_get_register_list(CPUState *cpu)
 
 int gdb_read_register(CPUState *cpu, GByteArray *buf, int reg)
 {
-    CPUClass *cc = CPU_GET_CLASS(cpu);
     GDBRegisterState *r;
 
-    if (reg < cc->gdb_num_core_regs) {
-        return cc->gdb_read_register(cpu, buf, reg);
+    if (reg < cpu->cc->gdb_num_core_regs) {
+        return cpu->cc->gdb_read_register(cpu, buf, reg);
     }
 
     for (guint i = 0; i < cpu->gdb_regs->len; i++) {
@@ -538,11 +536,10 @@ int gdb_read_register(CPUState *cpu, GByteArray *buf, int reg)
 
 static int gdb_write_register(CPUState *cpu, uint8_t *mem_buf, int reg)
 {
-    CPUClass *cc = CPU_GET_CLASS(cpu);
     GDBRegisterState *r;
 
-    if (reg < cc->gdb_num_core_regs) {
-        return cc->gdb_write_register(cpu, mem_buf, reg);
+    if (reg < cpu->cc->gdb_num_core_regs) {
+        return cpu->cc->gdb_write_register(cpu, mem_buf, reg);
     }
 
     for (guint i = 0; i < cpu->gdb_regs->len; i++) {
@@ -570,7 +567,7 @@ static void gdb_register_feature(CPUState *cpu, int base_reg,
 
 void gdb_init_cpu(CPUState *cpu)
 {
-    CPUClass *cc = CPU_GET_CLASS(cpu);
+    CPUClass *cc = cpu->cc;
     const GDBFeature *feature;
 
     cpu->gdb_regs = g_array_new(false, false, sizeof(GDBRegisterState));
@@ -1646,11 +1643,8 @@ void gdb_extend_qsupported_features(char *qflags)
 
 static void handle_query_supported(GArray *params, void *user_ctx)
 {
-    CPUClass *cc;
-
     g_string_printf(gdbserver_state.str_buf, "PacketSize=%x", MAX_PACKET_LENGTH);
-    cc = CPU_GET_CLASS(first_cpu);
-    if (cc->gdb_core_xml_file) {
+    if (first_cpu->cc->gdb_core_xml_file) {
         g_string_append(gdbserver_state.str_buf, ";qXfer:features:read+");
     }
 
@@ -1697,7 +1691,6 @@ static void handle_query_supported(GArray *params, void *user_ctx)
 static void handle_query_xfer_features(GArray *params, void *user_ctx)
 {
     GDBProcess *process;
-    CPUClass *cc;
     unsigned long len, total_len, addr;
     const char *xml;
     const char *p;
@@ -1708,8 +1701,7 @@ static void handle_query_xfer_features(GArray *params, void *user_ctx)
     }
 
     process = gdb_get_cpu_process(gdbserver_state.g_cpu);
-    cc = CPU_GET_CLASS(gdbserver_state.g_cpu);
-    if (!cc->gdb_core_xml_file) {
+    if (!gdbserver_state.g_cpu->cc->gdb_core_xml_file) {
         gdb_put_packet("");
         return;
     }
diff --git a/gdbstub/system.c b/gdbstub/system.c
index 8ce79fa88cf..215a2c5dcad 100644
--- a/gdbstub/system.c
+++ b/gdbstub/system.c
@@ -452,8 +452,6 @@ static int phy_memory_mode;
 int gdb_target_memory_rw_debug(CPUState *cpu, hwaddr addr,
                                uint8_t *buf, int len, bool is_write)
 {
-    CPUClass *cc;
-
     if (phy_memory_mode) {
         if (is_write) {
             cpu_physical_memory_write(addr, buf, len);
@@ -463,9 +461,8 @@ int gdb_target_memory_rw_debug(CPUState *cpu, hwaddr addr,
         return 0;
     }
 
-    cc = CPU_GET_CLASS(cpu);
-    if (cc->memory_rw_debug) {
-        return cc->memory_rw_debug(cpu, addr, buf, len, is_write);
+    if (cpu->cc->memory_rw_debug) {
+        return cpu->cc->memory_rw_debug(cpu, addr, buf, len, is_write);
     }
 
     return cpu_memory_rw_debug(cpu, addr, buf, len, is_write);
diff --git a/gdbstub/user-target.c b/gdbstub/user-target.c
index 22bf4008c0f..355b1901b4f 100644
--- a/gdbstub/user-target.c
+++ b/gdbstub/user-target.c
@@ -233,10 +233,8 @@ void gdb_handle_query_offsets(GArray *params, void *user_ctx)
 static inline int target_memory_rw_debug(CPUState *cpu, target_ulong addr,
                                          uint8_t *buf, int len, bool is_write)
 {
-    CPUClass *cc;
-    cc = CPU_GET_CLASS(cpu);
-    if (cc->memory_rw_debug) {
-        return cc->memory_rw_debug(cpu, addr, buf, len, is_write);
+    if (cpu->cc->memory_rw_debug) {
+        return cpu->cc->memory_rw_debug(cpu, addr, buf, len, is_write);
     }
     return cpu_memory_rw_debug(cpu, addr, buf, len, is_write);
 }
diff --git a/gdbstub/user.c b/gdbstub/user.c
index c2bdfc3d491..375f7f80653 100644
--- a/gdbstub/user.c
+++ b/gdbstub/user.c
@@ -665,11 +665,8 @@ int gdb_continue_partial(char *newstates)
 int gdb_target_memory_rw_debug(CPUState *cpu, hwaddr addr,
                                uint8_t *buf, int len, bool is_write)
 {
-    CPUClass *cc;
-
-    cc = CPU_GET_CLASS(cpu);
-    if (cc->memory_rw_debug) {
-        return cc->memory_rw_debug(cpu, addr, buf, len, is_write);
+    if (cpu->cc->memory_rw_debug) {
+        return cpu->cc->memory_rw_debug(cpu, addr, buf, len, is_write);
     }
     return cpu_memory_rw_debug(cpu, addr, buf, len, is_write);
 }
-- 
2.47.1


