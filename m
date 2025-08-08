Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A1E90C87FDA
	for <qemu-devel@archiver.kernel.org>; Fri,  8 Aug 2025 20:43:31 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ukTur-0002yj-Do; Fri, 08 Aug 2025 16:42:17 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1ukTuo-0002x6-6R
 for qemu-devel@nongnu.org; Fri, 08 Aug 2025 16:42:14 -0400
Received: from mail-pl1-x634.google.com ([2607:f8b0:4864:20::634])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1ukTuk-0003Ck-M1
 for qemu-devel@nongnu.org; Fri, 08 Aug 2025 16:42:13 -0400
Received: by mail-pl1-x634.google.com with SMTP id
 d9443c01a7336-24003ed822cso15373225ad.1
 for <qemu-devel@nongnu.org>; Fri, 08 Aug 2025 13:42:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1754685729; x=1755290529; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=UCnnXWfvqtRCVbfN0E52T8SkudA5RqZI+yQNyvWP9uU=;
 b=I/nd8qIDJUXGKJ7IlD4L8YSv33Xwm4Dp1Y4kXDTl8WloIdLSoHa9N3BsHCkKZFQWly
 mdBFqeJt3C8onEKqyvdqOyPlwyBvcrYAkBl+WmmqRaAlmt2f98dXcH4BReiEWPMZDQqQ
 e5nq5xqe4IzBcMUXf6gnjnkyo2QOD4dPMytHalJ3m7KVC/kDlmYPKBBFN9VjdEQyk+lS
 CmwjUSRQdRk0JrbhISLh/ezg0kePrc4mD76DW7d7zlTxhTqWuOgwTDomaLw0zOFefuAe
 uIyxJyO1sXNtjdyMqwWkYTPW8avFVjt6hfwao80VWKnxonWU2ICftu4rGVYpFMdlrG8h
 jr5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1754685729; x=1755290529;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=UCnnXWfvqtRCVbfN0E52T8SkudA5RqZI+yQNyvWP9uU=;
 b=sAzuiwWXs9cCxa6ZI0xvfI4MNebKFqYsIER8M/0X4Yb9U+jtAJHisQl33jqt3NibmY
 hobfmre58RBC8USey1D4jYESA0gi8B+9r9Olknyv27btkDsfdsyVsE1WZvGZF/6ybyBg
 8WNZ1YFbCZvB2g4xbL9m2apHcjgRZ/QEB1KUyvVr7+SoLPxCOUzffCDXFp7UW8YWuIy4
 GQTbq2axtF29zJ8wt1vhk2uSh+5wnlU3pRrVCT8M3S9ETrJ6zy82ehDAK2zE+H1B9hAA
 /u3/CzYHhXaunVsaX8Lq+KcG4Q1NhRk99UsVwc9oCnYjpeRdWhxabmh/UQYa6iyhnxGd
 177A==
X-Gm-Message-State: AOJu0YzBBGHEv58o15D6YH6bwRLzchHgQgKYs8Cn/zq6qFtuWAYYAvSN
 zM5u3AnmOMHBUFx0fM7H9yXFQycuBTtPAi3OI4AFL4kCiiJ1UmXoVzL+7a9vMOyOUg4NiGAJinC
 cwi68KKWXCA==
X-Gm-Gg: ASbGncvac2wrgs+5OrGlhuThvjKWri+OXvgD+4H4bie1G2FXGmmBwmDTO6ssllQQcBC
 y1tV38FhLz1E7LcGsxP4iRppMGvdWei6JZHERRzBcXDqdw2JfFr6DUvXhLxRIOe9AU+cT65VPmm
 ogq22S2fqVKktgrc3W9GO9+hBLPN19uRgDd7xl+DPYyw6HCV0Jf9y/0T15jKJ/Xkw01ZXP6Rz0k
 xlgwO9In8IkSJpYlhrQy7++LykYdveXWG59+RcxOuQ1xpNSl4iJKgAOR7oF2nbiJEKDdhuoauss
 fqdw3kr9yc7V/ZWwak38rxYRp9Q5U2sMHGuEwRyTCujgzzL2aAKCJjWWLrAHwupEgWpXjNjkaEL
 90Yy2YCHP3NuQwyBTubU5Sg==
X-Google-Smtp-Source: AGHT+IF+/I1UFWXuqW7ersrevQbUhhb3sW9sFPZm1yVR4tLdHSZPy0jKl7WPbock4hQPk5SCiG5jdw==
X-Received: by 2002:a17:903:1b43:b0:240:2145:e527 with SMTP id
 d9443c01a7336-242c204c492mr51205175ad.25.1754685728871; 
 Fri, 08 Aug 2025 13:42:08 -0700 (PDT)
Received: from pc.. ([38.41.223.211]) by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-241e899a814sm217789945ad.117.2025.08.08.13.42.08
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 08 Aug 2025 13:42:08 -0700 (PDT)
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
Subject: [PATCH v6 2/9] contrib/plugins/uftrace: define cpu operations and
 implement aarch64
Date: Fri,  8 Aug 2025 13:41:49 -0700
Message-ID: <20250808204156.659715-3-pierrick.bouvier@linaro.org>
X-Mailer: git-send-email 2.47.2
In-Reply-To: <20250808204156.659715-1-pierrick.bouvier@linaro.org>
References: <20250808204156.659715-1-pierrick.bouvier@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::634;
 envelope-from=pierrick.bouvier@linaro.org; helo=mail-pl1-x634.google.com
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

We define a new CpuOps structure that will be used to implement tracking
independently of guest architecture.

As well, we now instrument only instructions following ones that might
have touched the frame pointer.

Reviewed-by: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>
Signed-off-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
---
 contrib/plugins/uftrace.c | 114 ++++++++++++++++++++++++++++++++++++--
 1 file changed, 110 insertions(+), 4 deletions(-)

diff --git a/contrib/plugins/uftrace.c b/contrib/plugins/uftrace.c
index 4af0130b159..d060513446c 100644
--- a/contrib/plugins/uftrace.c
+++ b/contrib/plugins/uftrace.c
@@ -11,14 +11,94 @@
 
 #include <qemu-plugin.h>
 #include <glib.h>
+#include <stdio.h>
 
 QEMU_PLUGIN_EXPORT int qemu_plugin_version = QEMU_PLUGIN_VERSION;
 
+typedef struct Cpu Cpu;
+
+typedef struct {
+    void (*init)(Cpu *cpu);
+    void (*end)(Cpu *cpu);
+    uint64_t (*get_frame_pointer)(Cpu *cpu);
+    bool (*does_insn_modify_frame_pointer)(const char *disas);
+} CpuOps;
+
 typedef struct Cpu {
     GByteArray *buf;
+    CpuOps ops;
+    void *arch;
 } Cpu;
 
+typedef struct {
+    struct qemu_plugin_register *reg_fp;
+} Aarch64Cpu;
+
 static struct qemu_plugin_scoreboard *score;
+static CpuOps arch_ops;
+
+static uint64_t cpu_read_register64(Cpu *cpu, struct qemu_plugin_register *reg)
+{
+    GByteArray *buf = cpu->buf;
+    g_byte_array_set_size(buf, 0);
+    size_t sz = qemu_plugin_read_register(reg, buf);
+    g_assert(sz == 8);
+    g_assert(buf->len == 8);
+    return *((uint64_t *) buf->data);
+}
+
+static struct qemu_plugin_register *plugin_find_register(const char *name)
+{
+    g_autoptr(GArray) regs = qemu_plugin_get_registers();
+    for (int i = 0; i < regs->len; ++i) {
+        qemu_plugin_reg_descriptor *reg;
+        reg = &g_array_index(regs, qemu_plugin_reg_descriptor, i);
+        if (!strcmp(reg->name, name)) {
+            return reg->handle;
+        }
+    }
+    return NULL;
+}
+
+static uint64_t aarch64_get_frame_pointer(Cpu *cpu_)
+{
+    Aarch64Cpu *cpu = cpu_->arch;
+    return cpu_read_register64(cpu_, cpu->reg_fp);
+}
+
+static void aarch64_init(Cpu *cpu_)
+{
+    Aarch64Cpu *cpu = g_new0(Aarch64Cpu, 1);
+    cpu_->arch = cpu;
+    cpu->reg_fp = plugin_find_register("x29");
+    if (!cpu->reg_fp) {
+        fprintf(stderr, "uftrace plugin: frame pointer register (x29) is not "
+                        "available. Please use an AArch64 cpu (or -cpu max).\n");
+        g_abort();
+    }
+}
+
+static void aarch64_end(Cpu *cpu)
+{
+    g_free(cpu->arch);
+}
+
+static bool aarch64_does_insn_modify_frame_pointer(const char *disas)
+{
+    /*
+     * Check if current instruction concerns fp register "x29".
+     * We add a prefix space to make sure we don't match addresses dump
+     * in disassembly.
+     */
+    return strstr(disas, " x29");
+}
+
+static CpuOps aarch64_ops = {
+    .init = aarch64_init,
+    .end = aarch64_end,
+    .get_frame_pointer = aarch64_get_frame_pointer,
+    .does_insn_modify_frame_pointer = aarch64_does_insn_modify_frame_pointer,
+};
 
 static void track_callstack(unsigned int cpu_index, void *udata)
 {
@@ -28,19 +108,37 @@ static void vcpu_tb_trans(qemu_plugin_id_t id, struct qemu_plugin_tb *tb)
 {
     size_t n_insns = qemu_plugin_tb_n_insns(tb);
 
+    /*
+     * Callbacks and inline instrumentation are inserted before an instruction.
+     * Thus, to see instruction effect, we need to wait for next one.
+     * Potentially, the last instruction of a block could modify the frame
+     * pointer. Thus, we need to always instrument first instruction in a tb.
+     */
+    bool instrument_insn = true;
     for (size_t i = 0; i < n_insns; i++) {
         struct qemu_plugin_insn *insn = qemu_plugin_tb_get_insn(tb, i);
 
-        uintptr_t pc = qemu_plugin_insn_vaddr(insn);
-        qemu_plugin_register_vcpu_insn_exec_cb(insn, track_callstack,
-                                               QEMU_PLUGIN_CB_R_REGS,
-                                               (void *) pc);
+        if (instrument_insn) {
+            uintptr_t pc = qemu_plugin_insn_vaddr(insn);
+            qemu_plugin_register_vcpu_insn_exec_cb(insn, track_callstack,
+                                                   QEMU_PLUGIN_CB_R_REGS,
+                                                   (void *) pc);
+            instrument_insn = false;
+        }
+
+        char *disas = qemu_plugin_insn_disas(insn);
+        if (arch_ops.does_insn_modify_frame_pointer(disas)) {
+            instrument_insn = true;
+        }
     }
 }
 
 static void vcpu_init(qemu_plugin_id_t id, unsigned int vcpu_index)
 {
     Cpu *cpu = qemu_plugin_scoreboard_find(score, vcpu_index);
+    cpu->ops = arch_ops;
+
+    cpu->ops.init(cpu);
     cpu->buf = g_byte_array_new();
 }
 
@@ -64,6 +162,14 @@ QEMU_PLUGIN_EXPORT int qemu_plugin_install(qemu_plugin_id_t id,
                                            const qemu_info_t *info,
                                            int argc, char **argv)
 {
+    if (!strcmp(info->target_name, "aarch64")) {
+        arch_ops = aarch64_ops;
+    } else {
+        fprintf(stderr, "plugin uftrace: %s target is not supported\n",
+                info->target_name);
+        return 1;
+    }
+
     score = qemu_plugin_scoreboard_new(sizeof(Cpu));
     qemu_plugin_register_vcpu_init_cb(id, vcpu_init);
     qemu_plugin_register_atexit_cb(id, at_exit, NULL);
-- 
2.47.2


