Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BFF76CCF9EB
	for <qemu-devel@archiver.kernel.org>; Wed, 29 Oct 2025 15:54:05 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vE8ST-0004c7-D8; Wed, 29 Oct 2025 11:51:33 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1vE8SM-0004Uv-U3
 for qemu-devel@nongnu.org; Wed, 29 Oct 2025 11:51:27 -0400
Received: from mail-ej1-x635.google.com ([2a00:1450:4864:20::635])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1vE8S3-0002uM-4B
 for qemu-devel@nongnu.org; Wed, 29 Oct 2025 11:51:25 -0400
Received: by mail-ej1-x635.google.com with SMTP id
 a640c23a62f3a-b472842981fso3020266b.1
 for <qemu-devel@nongnu.org>; Wed, 29 Oct 2025 08:51:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1761753060; x=1762357860; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=hH1NTFxh3WCuSCKtyOLnZNkjnkW5oLfrCD/8JkcGtSM=;
 b=n8xv+fe6TKwfDq10WQx1E7G8nASyrCmjs9BptPSomaNR/aLIQI8KDkovIEA21cPvuk
 lDnF56HMDgPPzEXkUOx/tdSF1G6XWejiEKvnVM+rs8ojshFaswcF4do+BcuACcwTBkrw
 mQ+FSe7Fdzyi3mde+krOnX7p6QWo5y0mMUqjQvlQfDyHxQqBHDFog39vhvqlIMvDDm51
 DTe2R4mRvYZJY3hDHp60on5+rW0r9UoQ0XAZJt15NbqtaD+sk09idRzNmRjkc2QuJvTP
 u0/UU00JquVDll5AZGhTjOuQJe3dN73igRtQm6qMKt4Zp3pHh3O9mMjhyujjLWDLNtE+
 Fh1A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1761753060; x=1762357860;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=hH1NTFxh3WCuSCKtyOLnZNkjnkW5oLfrCD/8JkcGtSM=;
 b=XqT3IfMNg+uZWJod9VZyo5Gcx0emfSLvkb4rHxr8s86nZh6imUOZsw+3eiq603OSaN
 BycbhAbRflTdsNq2n0nYwiHmZtsQqHi8E80dOHTWvbofdYF9w3bxAxPduOk2477/aPi3
 PCvuke2mDouDTM6XA5Nc0VLQiiODXKMO2a9n6WiSgJ1wwNUZ4kTor8Z6qG6uwPXr+mmy
 3l/lETggrNqpGqKF+v1ir2/oGf8jE3G54FtzKGQDnICHPWJ2zPbvwx0gS8hE6shUb+I1
 V6esD+ykxwsXNg//ojjQqCathEmVF6VRBNuzklmpEEGEXhs561nsokQqIesJLooUG8Pb
 bZUQ==
X-Gm-Message-State: AOJu0YxEuZUF03rLaQUB2nA7HJQRkkgJ3zxZw+hQWRgZavANn3dNr2HQ
 QfmEyLRfh+vQ8kOtblQUYIYaR+iktYoUp7j+/up7jcjFzstfjB6mt6rHEqBJkRh2Nno=
X-Gm-Gg: ASbGncuiiFkyKXmARIZhSAoeWe1oTxGauCIeTKDv97uz1eaJj2SKLHKf5TXRCVGGezj
 8KUGxPpR8bAlwLM47GYMo33XfiqmrTModrVrIYtDBn5rG4bnjYjpqlhOOwBCpHk+jSE+gTgnrzl
 IR4gp6gDj+AabLAvsUlVuFF9320k7KYEAUHNihxRl+zZXtaSDqeaVAnMrXOBhGdihZOvTD1XgS6
 xa3CnNaYJ79SOLg99OMEEYz+nyo8Rls2uM3BdGmvnPxuDMRV1jDETeTQMxFr/WnQaGSxx9C9g0t
 t/991lodG1FyxqCHW1qUrEgoDoE0HGdlRlsrOcrFEUFCXmUt99yb1mYpqeqqXRixNR5sCh19yDD
 Zr/MAcTYkelrZzyxqHKmPuTJq5EjOZGSMuaW80XWa6zAwK2gbqFn43vgpr+jsjjBL7fHMQM4+JO
 IP
X-Google-Smtp-Source: AGHT+IEbWE1CIRhAp/bCaTB4SLBeyGsJgvvG3GPZz7keyKHJHG2OrM+dfL9bLdzk/JBq6eDjlEeUAA==
X-Received: by 2002:a17:906:fe4a:b0:b45:e8e2:ade3 with SMTP id
 a640c23a62f3a-b703d5fafb4mr320500166b.64.1761753060216; 
 Wed, 29 Oct 2025 08:51:00 -0700 (PDT)
Received: from draig.lan ([185.126.160.19]) by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-b6d853c664asm1468001666b.42.2025.10.29.08.50.54
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 29 Oct 2025 08:50:58 -0700 (PDT)
Received: from draig.lan (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id B3C155F7C7;
 Wed, 29 Oct 2025 15:50:48 +0000 (GMT)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Cc: Julian Ganz <neither@nut.email>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Alexandre Iooss <erdnaxe@crans.org>,
 Mahmoud Mandour <ma.mandourr@gmail.com>
Subject: [PULL 29/35] tests: add plugin asserting correctness of discon
 event's to_pc
Date: Wed, 29 Oct 2025 15:50:38 +0000
Message-ID: <20251029155045.257802-30-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20251029155045.257802-1-alex.bennee@linaro.org>
References: <20251029155045.257802-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::635;
 envelope-from=alex.bennee@linaro.org; helo=mail-ej1-x635.google.com
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

From: Julian Ganz <neither@nut.email>

We recently introduced plugin API for the registration of callbacks for
discontinuity events, specifically for interrupts, exceptions and host
call events. The callback receives various bits of information,
including the VCPU index and PCs.

This change introduces a test plugin asserting the correctness of that
behaviour in cases where this is possible with reasonable effort.

Reviewed-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
Signed-off-by: Julian Ganz <neither@nut.email>
Message-ID: <20251027110344.2289945-30-alex.bennee@linaro.org>
Signed-off-by: Alex Bennée <alex.bennee@linaro.org>

diff --git a/tests/tcg/plugins/discons.c b/tests/tcg/plugins/discons.c
new file mode 100644
index 00000000000..2e0e664e823
--- /dev/null
+++ b/tests/tcg/plugins/discons.c
@@ -0,0 +1,221 @@
+/*
+ * SPDX-License-Identifier: GPL-2.0-or-later
+ * Copyright (C) 2025, Julian Ganz <neither@nut.email>
+ *
+ * This plugin exercises the discontinuity plugin API and asserts some
+ * of its behaviour regarding reported program counters.
+ */
+#include <stdio.h>
+
+#include <qemu-plugin.h>
+
+QEMU_PLUGIN_EXPORT int qemu_plugin_version = QEMU_PLUGIN_VERSION;
+
+struct cpu_state {
+    uint64_t last_pc;
+    uint64_t from_pc;
+    uint64_t next_pc;
+    uint64_t has_from;
+    bool has_next;
+    enum qemu_plugin_discon_type next_type;
+};
+
+struct insn_data {
+    uint64_t addr;
+    uint64_t next_pc;
+    bool next_valid;
+};
+
+static struct qemu_plugin_scoreboard *states;
+
+static qemu_plugin_u64 last_pc;
+static qemu_plugin_u64 from_pc;
+static qemu_plugin_u64 has_from;
+
+static bool abort_on_mismatch;
+static bool trace_all_insns;
+
+static bool addr_eq(uint64_t a, uint64_t b)
+{
+    if (a == b) {
+        return true;
+    }
+
+    uint64_t a_hw;
+    uint64_t b_hw;
+    if (!qemu_plugin_translate_vaddr(a, &a_hw) ||
+        !qemu_plugin_translate_vaddr(b, &b_hw))
+    {
+        return false;
+    }
+
+    return a_hw == b_hw;
+}
+
+static void report_mismatch(const char *pc_name, unsigned int vcpu_index,
+                            enum qemu_plugin_discon_type type, uint64_t last,
+                            uint64_t expected, uint64_t encountered)
+{
+    gchar *report;
+    const char *discon_type_name = "unknown";
+
+    if (addr_eq(expected, encountered)) {
+        return;
+    }
+
+    switch (type) {
+    case QEMU_PLUGIN_DISCON_INTERRUPT:
+        discon_type_name = "interrupt";
+        break;
+    case QEMU_PLUGIN_DISCON_EXCEPTION:
+        discon_type_name = "exception";
+        break;
+    case QEMU_PLUGIN_DISCON_HOSTCALL:
+        discon_type_name = "hostcall";
+        break;
+    default:
+        break;
+    }
+
+    report = g_strdup_printf("Discon %s PC mismatch on VCPU %d\n"
+                             "Expected:      %"PRIx64"\nEncountered:   %"
+                             PRIx64"\nExecuted Last: %"PRIx64
+                             "\nEvent type:    %s\n",
+                             pc_name, vcpu_index, expected, encountered, last,
+                             discon_type_name);
+    if (abort_on_mismatch) {
+        /*
+         * The qemu log infrastructure may lose messages when aborting. Using
+         * fputs directly ensures the final report is visible to developers.
+         */
+        fputs(report, stderr);
+        g_abort();
+    } else {
+        qemu_plugin_outs(report);
+    }
+    g_free(report);
+}
+
+static void vcpu_discon(qemu_plugin_id_t id, unsigned int vcpu_index,
+                        enum qemu_plugin_discon_type type, uint64_t from_pc,
+                        uint64_t to_pc)
+{
+    struct cpu_state *state = qemu_plugin_scoreboard_find(states, vcpu_index);
+
+    if (type == QEMU_PLUGIN_DISCON_EXCEPTION &&
+        addr_eq(state->last_pc, from_pc))
+    {
+        /*
+         * For some types of exceptions, insn_exec will be called for the
+         * instruction that caused the exception. This is valid behaviour and
+         * does not need to be reported.
+         */
+    } else if (state->has_next) {
+        /*
+         * We may encounter discontinuity chains without any instructions
+         * being executed in between.
+         */
+        report_mismatch("source", vcpu_index, type, state->last_pc,
+                        state->next_pc, from_pc);
+    } else if (state->has_from) {
+        report_mismatch("source", vcpu_index, type, state->last_pc,
+                        state->from_pc, from_pc);
+    }
+
+    state->has_from = false;
+
+    state->next_pc = to_pc;
+    state->next_type = type;
+    state->has_next = true;
+}
+
+static void insn_exec(unsigned int vcpu_index, void *userdata)
+{
+    struct cpu_state *state = qemu_plugin_scoreboard_find(states, vcpu_index);
+
+    if (state->has_next) {
+        report_mismatch("target", vcpu_index, state->next_type, state->last_pc,
+                        state->next_pc, state->last_pc);
+        state->has_next = false;
+    }
+
+    if (trace_all_insns) {
+        g_autoptr(GString) report = g_string_new(NULL);
+        g_string_append_printf(report, "Exec insn at %"PRIx64" on VCPU %d\n",
+                               state->last_pc, vcpu_index);
+        qemu_plugin_outs(report->str);
+    }
+}
+
+static void vcpu_tb_trans(qemu_plugin_id_t id, struct qemu_plugin_tb *tb)
+{
+    size_t n_insns = qemu_plugin_tb_n_insns(tb);
+    for (size_t i = 0; i < n_insns; i++) {
+        struct qemu_plugin_insn *insn = qemu_plugin_tb_get_insn(tb, i);
+        uint64_t pc = qemu_plugin_insn_vaddr(insn);
+        uint64_t next_pc = pc + qemu_plugin_insn_size(insn);
+        uint64_t has_next = (i + 1) < n_insns;
+
+        qemu_plugin_register_vcpu_insn_exec_inline_per_vcpu(insn,
+                                                            QEMU_PLUGIN_INLINE_STORE_U64,
+                                                            last_pc, pc);
+        qemu_plugin_register_vcpu_insn_exec_inline_per_vcpu(insn,
+                                                            QEMU_PLUGIN_INLINE_STORE_U64,
+                                                            from_pc, next_pc);
+        qemu_plugin_register_vcpu_insn_exec_inline_per_vcpu(insn,
+                                                            QEMU_PLUGIN_INLINE_STORE_U64,
+                                                            has_from, has_next);
+        qemu_plugin_register_vcpu_insn_exec_cb(insn, insn_exec,
+                                               QEMU_PLUGIN_CB_NO_REGS, NULL);
+    }
+}
+
+QEMU_PLUGIN_EXPORT int qemu_plugin_install(qemu_plugin_id_t id,
+                                           const qemu_info_t *info,
+                                           int argc, char **argv)
+{
+    if (!info->system_emulation) {
+        qemu_plugin_outs("Testing of the disontinuity plugin API is only"
+                         " possible in system emulation mode.");
+        return 0;
+    }
+
+    /* Set defaults */
+    abort_on_mismatch = true;
+    trace_all_insns = false;
+
+    for (int i = 0; i < argc; i++) {
+        char *opt = argv[i];
+        g_auto(GStrv) tokens = g_strsplit(opt, "=", 2);
+        if (g_strcmp0(tokens[0], "abort") == 0) {
+            if (!qemu_plugin_bool_parse(tokens[0], tokens[1],
+                                        &abort_on_mismatch)) {
+                fprintf(stderr, "boolean argument parsing failed: %s\n", opt);
+                return -1;
+            }
+        } else if (g_strcmp0(tokens[0], "trace-all") == 0) {
+            if (!qemu_plugin_bool_parse(tokens[0], tokens[1],
+                                        &trace_all_insns)) {
+                fprintf(stderr, "boolean argument parsing failed: %s\n", opt);
+                return -1;
+            }
+        } else {
+            fprintf(stderr, "option parsing failed: %s\n", opt);
+            return -1;
+        }
+    }
+
+    states = qemu_plugin_scoreboard_new(sizeof(struct cpu_state));
+    last_pc = qemu_plugin_scoreboard_u64_in_struct(states, struct cpu_state,
+                                                   last_pc);
+    from_pc = qemu_plugin_scoreboard_u64_in_struct(states, struct cpu_state,
+                                                   from_pc);
+    has_from = qemu_plugin_scoreboard_u64_in_struct(states, struct cpu_state,
+                                                    has_from);
+
+    qemu_plugin_register_vcpu_discon_cb(id, QEMU_PLUGIN_DISCON_ALL,
+                                        vcpu_discon);
+    qemu_plugin_register_vcpu_tb_trans_cb(id, vcpu_tb_trans);
+
+    return 0;
+}
diff --git a/tests/tcg/plugins/meson.build b/tests/tcg/plugins/meson.build
index 61a007d9e74..561584159eb 100644
--- a/tests/tcg/plugins/meson.build
+++ b/tests/tcg/plugins/meson.build
@@ -1,6 +1,6 @@
 t = []
 if get_option('plugins')
-  foreach i : ['bb', 'empty', 'inline', 'insn', 'mem', 'reset', 'syscall', 'patch']
+  foreach i : ['bb', 'discons', 'empty', 'inline', 'insn', 'mem', 'reset', 'syscall', 'patch']
     if host_os == 'windows'
       t += shared_module(i, files(i + '.c') + '../../../contrib/plugins/win32_linker.c',
                         include_directories: '../../../include/qemu',
-- 
2.47.3


