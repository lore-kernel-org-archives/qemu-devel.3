Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 46FC6CA0EC0
	for <qemu-devel@archiver.kernel.org>; Fri,  8 Aug 2025 20:43:38 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ukTut-00030Q-Az; Fri, 08 Aug 2025 16:42:19 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1ukTur-0002yT-3U
 for qemu-devel@nongnu.org; Fri, 08 Aug 2025 16:42:17 -0400
Received: from mail-pl1-x633.google.com ([2607:f8b0:4864:20::633])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1ukTup-0003DX-Eh
 for qemu-devel@nongnu.org; Fri, 08 Aug 2025 16:42:16 -0400
Received: by mail-pl1-x633.google.com with SMTP id
 d9443c01a7336-23dc5bcf49eso29792865ad.2
 for <qemu-devel@nongnu.org>; Fri, 08 Aug 2025 13:42:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1754685733; x=1755290533; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=2RkF9BIocl4i6I0VbIlztg88We7hPlBDy2e1enRmrPU=;
 b=zk371KLxppmNvygkt/LCVrOWv8CHI4TdkQwVThuUqKJ3nZNtr7b+NvxI0fxTRnPcwQ
 dcgf2UBbRxV/Ei5jWz6MFeYbn8J8+jjedPU2PLxAAJQf9uQlLbEwdLJ6CpraN0+feZOu
 x2mwqmwEPBDdsVT23M7alrbfxcmCSk2iHXaGlWe2OVUE3tqvD4vJadK/olFx+2WJ2tXQ
 pkBEBECZ96mCLHJr5Ue0Nm+e/i8644A2g6pAAga8lgQNr4IrczKPUrZL6GQgd9bRFfio
 WJvYq64pe8Fheq0tTctU0D/Bejh8U6EBboWqX4Il4+C6zjb2rNUy142P2j2oGLInzbW9
 rfMQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1754685733; x=1755290533;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=2RkF9BIocl4i6I0VbIlztg88We7hPlBDy2e1enRmrPU=;
 b=jiq6c4YbwYpRWM/zXy+F/+yFs2QODBIfJZrd3yyRfdpkwkirJ6fFstSgQxN9NCNKG4
 u1wBV8KxkXK3UirDiXMru2UF1bUS5I+FmL0GhqyMPjdYBXPjjeobCgOCQUpq7VcUyF3s
 8dhsM4+UPNIxA31qSxlFWk5Mhxlcxr8sfbbLF0v3J5dAwrUVLXLV8eepMGQCzu9NjA4d
 TXHGLGFSj6oeyvCW2IqfOrCjVdShQY5nlboS+hfccvwt+5h+7fcMuH7Zmr8r75wyLKQ/
 rDC61/8zic1TgPSgSMjNWeIOpLXyAFJ3WVxBiTr6GYZg8AhocdIPKIrC0HK5viNbnunJ
 3+6Q==
X-Gm-Message-State: AOJu0YymAOIjH9YauoNAa6FCdU4VNRQwcp5+uT1EWQ706UpM5vR23nlN
 3OH8yAV5K0xOUKUOkewYndOUhtSbGxPk8MxdO0lxvrhCn+qWXPV+bAsinsFZjrv69OFKqVUOL7w
 VNtFGNTnb+Q==
X-Gm-Gg: ASbGncuA2NgOsUoGrzg6k3MKzUL0bG7gPhLBxLwxheNmchQRrRQZUP0k7rRhEp3OKxj
 LXr0Z6zLV4afgqUPtmXxTUS/T526LijPM1kReE5xoXb0OwY9TQakxQDOL7V/dS4WZajcCtSvxGO
 AJoosNcMTDrmaf+noUtqXQV69kefwMhzIGbCLCGXVfS6TBEMSIS5AcPPg9+DxH4RM6wEDlzPH6p
 WAm4mY+0b/70ch733YhLCn+cfpL8jxxkvgdTu9CkE9Tddl+WJSmB7HHqBufy2RFO9E3rUvlTyMo
 Vkhz7zE0DMBQ/lLPOOfXm063+V++NEUH5lbPwIawNuXCL6B1DBgSM9QkwMTSBQ89v9fzk7/OMoi
 28iehM3E6HOzifjhQIQtu1Q==
X-Google-Smtp-Source: AGHT+IG+iKvLMgriWVJfoaweeLzPkqbcF+SHH6NhT5P3zHGg0PJ1KX3q/3oefabGKzJsyuzVv052ew==
X-Received: by 2002:a17:902:da91:b0:234:d292:be7a with SMTP id
 d9443c01a7336-242c1fdca31mr70883275ad.1.1754685733612; 
 Fri, 08 Aug 2025 13:42:13 -0700 (PDT)
Received: from pc.. ([38.41.223.211]) by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-241e899a814sm217789945ad.117.2025.08.08.13.42.12
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 08 Aug 2025 13:42:13 -0700 (PDT)
From: Pierrick Bouvier <pierrick.bouvier@linaro.org>
To: qemu-devel@nongnu.org,
	pierrick.bouvier@linaro.org
Cc: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>,
 Peter Maydell <peter.maydell@linaro.org>,
 rowan Hart <rowanbhart@gmail.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Gustavo Romero <gustavo.romero@linaro.org>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Alexandre Iooss <erdnaxe@crans.org>,
 Mahmoud Mandour <ma.mandourr@gmail.com>,
 Richard Henderson <richard.henderson@linaro.org>
Subject: [PATCH v6 7/9] contrib/plugins/uftrace: implement x64 support
Date: Fri,  8 Aug 2025 13:41:54 -0700
Message-ID: <20250808204156.659715-8-pierrick.bouvier@linaro.org>
X-Mailer: git-send-email 2.47.2
In-Reply-To: <20250808204156.659715-1-pierrick.bouvier@linaro.org>
References: <20250808204156.659715-1-pierrick.bouvier@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::633;
 envelope-from=pierrick.bouvier@linaro.org; helo=mail-pl1-x633.google.com
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

It's trivial to implement x64 support, as it's the same stack layout
as aarch64.

Reviewed-by: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>
Signed-off-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
---
 contrib/plugins/uftrace.c | 86 +++++++++++++++++++++++++++++++++++++++
 1 file changed, 86 insertions(+)

diff --git a/contrib/plugins/uftrace.c b/contrib/plugins/uftrace.c
index 290e40ee390..e4b5308e0d7 100644
--- a/contrib/plugins/uftrace.c
+++ b/contrib/plugins/uftrace.c
@@ -80,6 +80,21 @@ typedef struct {
     struct qemu_plugin_register *reg_scr_el3;
 } Aarch64Cpu;
 
+typedef enum {
+    X64_RING0,
+    X64_RING1,
+    X64_RING2,
+    X64_RING3,
+    X64_REAL_MODE,
+    X64_PRIVILEGE_LEVEL_MAX,
+} X64PrivilegeLevel;
+
+typedef struct {
+    struct qemu_plugin_register *reg_rbp;
+    struct qemu_plugin_register *reg_cs;
+    struct qemu_plugin_register *reg_cr0;
+} X64Cpu;
+
 typedef struct {
     uint64_t timestamp;
     uint64_t data;
@@ -568,6 +583,75 @@ static CpuOps aarch64_ops = {
     .does_insn_modify_frame_pointer = aarch64_does_insn_modify_frame_pointer,
 };
 
+static uint8_t x64_num_privilege_levels(void)
+{
+    return X64_PRIVILEGE_LEVEL_MAX;
+}
+
+static const char *x64_get_privilege_level_name(uint8_t pl)
+{
+    switch (pl) {
+    case X64_RING0: return "Ring0";
+    case X64_RING1: return "Ring1";
+    case X64_RING2: return "Ring2";
+    case X64_RING3: return "Ring3";
+    case X64_REAL_MODE: return "RealMode";
+    default:
+        g_assert_not_reached();
+    }
+}
+
+static uint8_t x64_get_privilege_level(Cpu *cpu_)
+{
+    X64Cpu *cpu = cpu_->arch;
+    uint64_t cr0 = cpu_read_register64(cpu_, cpu->reg_cr0);
+    uint64_t protected_mode = (cr0 >> 0) & 0b1;
+    if (!protected_mode) {
+        return X64_REAL_MODE;
+    }
+    uint32_t cs = cpu_read_register32(cpu_, cpu->reg_cs);
+    uint32_t ring_level = (cs >> 0) & 0b11;
+    return ring_level;
+}
+
+static uint64_t x64_get_frame_pointer(Cpu *cpu_)
+{
+    X64Cpu *cpu = cpu_->arch;
+    return cpu_read_register64(cpu_, cpu->reg_rbp);
+}
+
+static void x64_init(Cpu *cpu_)
+{
+    X64Cpu *cpu = g_new0(X64Cpu, 1);
+    cpu_->arch = cpu;
+    cpu->reg_rbp = plugin_find_register("rbp");
+    g_assert(cpu->reg_rbp);
+    cpu->reg_cs = plugin_find_register("cs");
+    g_assert(cpu->reg_cs);
+    cpu->reg_cr0 = plugin_find_register("cr0");
+    g_assert(cpu->reg_cr0);
+}
+
+static void x64_end(Cpu *cpu)
+{
+    g_free(cpu->arch);
+}
+
+static bool x64_does_insn_modify_frame_pointer(const char *disas)
+{
+    return strstr(disas, "rbp");
+}
+
+static CpuOps x64_ops = {
+    .init = x64_init,
+    .end = x64_end,
+    .get_frame_pointer = x64_get_frame_pointer,
+    .get_privilege_level = x64_get_privilege_level,
+    .num_privilege_levels = x64_num_privilege_levels,
+    .get_privilege_level_name = x64_get_privilege_level_name,
+    .does_insn_modify_frame_pointer = x64_does_insn_modify_frame_pointer,
+};
+
 static void track_privilege_change(unsigned int cpu_index, void *udata)
 {
     Cpu *cpu = qemu_plugin_scoreboard_find(score, cpu_index);
@@ -775,6 +859,8 @@ QEMU_PLUGIN_EXPORT int qemu_plugin_install(qemu_plugin_id_t id,
 
     if (!strcmp(info->target_name, "aarch64")) {
         arch_ops = aarch64_ops;
+    } else if (!strcmp(info->target_name, "x86_64")) {
+        arch_ops = x64_ops;
     } else {
         fprintf(stderr, "plugin uftrace: %s target is not supported\n",
                 info->target_name);
-- 
2.47.2


