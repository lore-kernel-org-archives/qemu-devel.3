Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1ED6BCA0EC0
	for <qemu-devel@archiver.kernel.org>; Fri,  8 Aug 2025 20:42:56 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ukTus-0002zJ-50; Fri, 08 Aug 2025 16:42:18 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1ukTum-0002x0-Tb
 for qemu-devel@nongnu.org; Fri, 08 Aug 2025 16:42:14 -0400
Received: from mail-pl1-x633.google.com ([2607:f8b0:4864:20::633])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1ukTuk-0003Cc-9U
 for qemu-devel@nongnu.org; Fri, 08 Aug 2025 16:42:12 -0400
Received: by mail-pl1-x633.google.com with SMTP id
 d9443c01a7336-2400f746440so20851205ad.2
 for <qemu-devel@nongnu.org>; Fri, 08 Aug 2025 13:42:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1754685728; x=1755290528; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=KsrgAwcfXPf60wLi3R10FjsXpsAPM+d7uJ0mGFTRCRw=;
 b=MAI31nQ3dMQTULDWyoAItG0hL9C3jpRfp5XuMgyaMWi9xEXVapwng51RaEihIOHw6b
 xHryHrJHscPIEQK9aObAt44ETHEmkuG1vGS0bPL+V3oT8VclH6cENFS8PdsuASDVfbbE
 jkgtUfjOSiOVp5XJ8pPJtTiX3W5Xz+Jt69qVcHnnfZKUKtE0WXT/k86kAYH7VS39O5rN
 EeX/sGK5Ro+Yp65gCRir27sZSyjG85qd27vFfAzZsuMkENUJli2vbf/JKzkEVDqHufha
 BdaeIsmmlb4XwMMPWjvD6byoBHyRmLRT74gUp3AtLYPtWZ0Qh9dzvU0ANKRzUmijng4j
 pnJQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1754685728; x=1755290528;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=KsrgAwcfXPf60wLi3R10FjsXpsAPM+d7uJ0mGFTRCRw=;
 b=kJIBKJp2xeXBCth3JOP7vVas0X8OK2v8es+zOhskWZYff+9okoVtHEWPkgmKrPehfX
 sjCOJAUka9RkCQeUAMVNUbkrL5jiHKkbzWJyRpklCbZiTk1Sv7+NUAKS/lWH7pt/wMcP
 Bfa5+csD7YJqAqTq/PI+xZHqgZf/T9i0yuTD1Io8PocT9Z50E/m5rhkXVLzmbM2BnozF
 ize7oeziWdTAkkNV1yp0RzgjIt4hqNcOLWbX/VgAbwc5sJHz1ec1XHcDj3EnIJlQ3dM4
 L5/9dBsQUQTQDDPlvq7R1h8GwhHHwO82A66drceEwEt1xVVt/X3LVTOOzKVJuHvV4kj3
 SlcA==
X-Gm-Message-State: AOJu0YyBSRF+nEyKNi3D+E3p6a+FAJbJGnMTiP/iGDO10Tux/51bF/06
 tc7jgFw74QX4sLLzLIRNbBGoq5Qe27+imdu2/njKDl/Z50kYGBJqFNh3FP2G+PGR2DlCHWDCsRa
 Dugz/1VPmdA==
X-Gm-Gg: ASbGncs48XgdFA6/iMP+v1eh0h1XbQdGT9Z3XxrDp79VqOSCM/+/L7nS8mx7Tdtxz1y
 ad4Kt8a1qy+j9Cv4qyodT9hiKJwz3Kbfg0LSfpR7r3oi9KgdjBd3pPgrnmGDBgWa6eGcdzTwLTR
 9nW4S4oMQpJJR1XG3x3qJmBDF718Zjg9UjJHKheIjVJn7y5tin1R7imxMxn84bIN54kzw6FDDVO
 8/fWplsJ2Jgg86WikQBnNOsP4tqL2U5qdher2ipmA/5ctAs1ivw9galRmgNYeqgTvNwla7EidE/
 JVoQHxdEXsBG3qZLDqER1hW2gGN3zJXgHoWDriD3mNbcqedZ09Q/Y88gGLjXAwUPOpU3RF5th9X
 mD+ohXt4L+S5Z7WPeuPhzpA==
X-Google-Smtp-Source: AGHT+IEwyCsAeCiNeliWBaQeHKXOqBNPQx4cnRwJB7/U5KzSuW3BJCZlF3epghzUvbxKefiWhlTrtA==
X-Received: by 2002:a17:903:1aa3:b0:240:8262:1a46 with SMTP id
 d9443c01a7336-242c21e355fmr60893775ad.25.1754685727922; 
 Fri, 08 Aug 2025 13:42:07 -0700 (PDT)
Received: from pc.. ([38.41.223.211]) by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-241e899a814sm217789945ad.117.2025.08.08.13.42.07
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 08 Aug 2025 13:42:07 -0700 (PDT)
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
Subject: [PATCH v6 1/9] contrib/plugins/uftrace: skeleton file
Date: Fri,  8 Aug 2025 13:41:48 -0700
Message-ID: <20250808204156.659715-2-pierrick.bouvier@linaro.org>
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

We define a scoreboard that will hold our data per cpu. As well, we
define a buffer per cpu that will be used to read registers and memories
in a thread-safe way.

For now, we just instrument all instructions with an empty callback.

Reviewed-by: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>
Signed-off-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
---
 contrib/plugins/uftrace.c   | 73 +++++++++++++++++++++++++++++++++++++
 contrib/plugins/meson.build |  3 +-
 2 files changed, 75 insertions(+), 1 deletion(-)
 create mode 100644 contrib/plugins/uftrace.c

diff --git a/contrib/plugins/uftrace.c b/contrib/plugins/uftrace.c
new file mode 100644
index 00000000000..4af0130b159
--- /dev/null
+++ b/contrib/plugins/uftrace.c
@@ -0,0 +1,73 @@
+/*
+ * Copyright (C) 2025, Pierrick Bouvier <pierrick.bouvier@linaro.org>
+ *
+ * Generates a trace compatible with uftrace (similar to uftrace record).
+ * https://github.com/namhyung/uftrace
+ *
+ * See docs/about/emulation.rst|Uftrace for details and examples.
+ *
+ * SPDX-License-Identifier: GPL-2.0-or-later
+ */
+
+#include <qemu-plugin.h>
+#include <glib.h>
+
+QEMU_PLUGIN_EXPORT int qemu_plugin_version = QEMU_PLUGIN_VERSION;
+
+typedef struct Cpu {
+    GByteArray *buf;
+} Cpu;
+
+static struct qemu_plugin_scoreboard *score;
+
+static void track_callstack(unsigned int cpu_index, void *udata)
+{
+}
+
+static void vcpu_tb_trans(qemu_plugin_id_t id, struct qemu_plugin_tb *tb)
+{
+    size_t n_insns = qemu_plugin_tb_n_insns(tb);
+
+    for (size_t i = 0; i < n_insns; i++) {
+        struct qemu_plugin_insn *insn = qemu_plugin_tb_get_insn(tb, i);
+
+        uintptr_t pc = qemu_plugin_insn_vaddr(insn);
+        qemu_plugin_register_vcpu_insn_exec_cb(insn, track_callstack,
+                                               QEMU_PLUGIN_CB_R_REGS,
+                                               (void *) pc);
+    }
+}
+
+static void vcpu_init(qemu_plugin_id_t id, unsigned int vcpu_index)
+{
+    Cpu *cpu = qemu_plugin_scoreboard_find(score, vcpu_index);
+    cpu->buf = g_byte_array_new();
+}
+
+static void vcpu_end(unsigned int vcpu_index)
+{
+    Cpu *cpu = qemu_plugin_scoreboard_find(score, vcpu_index);
+    g_byte_array_free(cpu->buf, true);
+    memset(cpu, 0, sizeof(Cpu));
+}
+
+static void at_exit(qemu_plugin_id_t id, void *data)
+{
+    for (size_t i = 0; i < qemu_plugin_num_vcpus(); ++i) {
+        vcpu_end(i);
+    }
+
+    qemu_plugin_scoreboard_free(score);
+}
+
+QEMU_PLUGIN_EXPORT int qemu_plugin_install(qemu_plugin_id_t id,
+                                           const qemu_info_t *info,
+                                           int argc, char **argv)
+{
+    score = qemu_plugin_scoreboard_new(sizeof(Cpu));
+    qemu_plugin_register_vcpu_init_cb(id, vcpu_init);
+    qemu_plugin_register_atexit_cb(id, at_exit, NULL);
+    qemu_plugin_register_vcpu_tb_trans_cb(id, vcpu_tb_trans);
+
+    return 0;
+}
diff --git a/contrib/plugins/meson.build b/contrib/plugins/meson.build
index 1876bc78438..7eb3629c95d 100644
--- a/contrib/plugins/meson.build
+++ b/contrib/plugins/meson.build
@@ -1,5 +1,6 @@
 contrib_plugins = ['bbv', 'cache', 'cflow', 'drcov', 'execlog', 'hotblocks',
-                   'hotpages', 'howvec', 'hwprofile', 'ips', 'stoptrigger']
+                   'hotpages', 'howvec', 'hwprofile', 'ips', 'stoptrigger',
+                   'uftrace']
 if host_os != 'windows'
   # lockstep uses socket.h
   contrib_plugins += 'lockstep'
-- 
2.47.2


