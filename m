Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F123BF47CD2
	for <qemu-devel@archiver.kernel.org>; Thu,  5 Mar 2026 20:53:08 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vyFg9-0006as-3d; Thu, 05 Mar 2026 15:52:17 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1vyFg6-0006ZL-06
 for qemu-devel@nongnu.org; Thu, 05 Mar 2026 15:52:14 -0500
Received: from mail-qt1-x830.google.com ([2607:f8b0:4864:20::830])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1vyFg1-00066W-RQ
 for qemu-devel@nongnu.org; Thu, 05 Mar 2026 15:52:13 -0500
Received: by mail-qt1-x830.google.com with SMTP id
 d75a77b69052e-5069b3e0c66so127206691cf.1
 for <qemu-devel@nongnu.org>; Thu, 05 Mar 2026 12:52:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1772743929; x=1773348729; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=rd8M5nodG2RHn+UrDTOzLTrwNAgiU0HwN3M6Mlv5xCQ=;
 b=YyFW2chC5DnLJXtpsbFNPj3LBAh8F+ofeHtPAZi7guIiS4zBu0pySEvpdn5bISf6j6
 FYzJpxZSViPCvTFmw1r6pCKCRmMbX23Y/reeyvUKlb2YwjyrET1iCMqjTAZ20fBLUXrZ
 bAmk8z4L9M6f73h/2UNDPaWa82fA2WRXqcKmiZwW9BA12T1ZI83SVuNtW7inJhtgOUKm
 a03opoEMnAeO3bowLiagmU+2naIsCAS07JBop2CKrROubEz1v7jpFxd/3ephkKErUmYn
 o6TOhz2kK7OVD6MPOcubxsZdEFaKlnXsUkR9O2VZeCu6GAhgmBhHGMDO5nyuKboESr+n
 6+gA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1772743929; x=1773348729;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=rd8M5nodG2RHn+UrDTOzLTrwNAgiU0HwN3M6Mlv5xCQ=;
 b=B+FpMWg2lwesVWTgJ2SoOpfGE07FOkgTIEMjNP9pe7tqwEoggydNaMaQpI1V7bH593
 NYle2CFXfAbWNK4GTme06Mqz2aT3yT1rG//UjlcJTJD5d4W5QUn4UPAfewOZEyPzBO1a
 HPMloO4v1kNg5YwaMXfsgvSpVlRXOmADVxZalJEckywXYRLyLrwzp5YhQ9lvQZuiqD6s
 o1y6PVrVFu9kdFHPeFSTJBLSIJjTptxS5ogNqY+mAxdqvfAUjLXiTV9dmzDye7zG23zj
 oQVGQL5c0d5MILo0pZoNAkEmKawH1VpTnpALc2WKwDCjxVXLvhyzOUyGRzD+dTLeHect
 +0FA==
X-Gm-Message-State: AOJu0YyeKvb45hWpjBClrju/appiuaPB0wD5PPDMq00/dWDE4sp4tQqJ
 gFrLyGHF3BE5Yj+1/TPOH2moqc1eNR92uCJ9hKHP/yzQnYsfeuVQXGEr9f7aXrrLI013rjxkNbH
 WT1SI
X-Gm-Gg: ATEYQzwmwPTEL71D/TpleZd9ON7rvxunj5lq8+wOAlzKyDPUVAvPBqFXyaHNVFzHlS8
 +TfkOcSa5LaMdAVgmjluMfMj+n5QZl2Vw2MPBUVeRwdI/6AUgkiYgQN7kfmxT0NOF7acS1FTxZ8
 roq8jA5pHkl8H4Fei4nr8hvmRXgt/S6/vm/IpWkr1yUsVSiiVedmX80rSK8BmTPbnUzzpxfzdAD
 ZCKo3mCy0i4Pndu/MOeGQAkonWQUxBJGtFt6ZbKyN5tVAMmQk9QH+GXDPoXJXm1fCQU9bLDt0Sv
 DD/sQik2fjmzColpQX15HjOj5UpgIahLSOJDlj0a/rzl4gbqqsNq9Kh3rMhaEqaK3OQOW5FSIXr
 uuu8uHxCuYBp+/nTqsDY+DBQIKEXUak5/9yklGHkVZmQ40v2cpgtnGXr6IQFGe0nNAnAfDeBT5f
 +hb1o+JVnSsPwHXRHTs72nNfyJvCfklEZV0hOilbP4zkFSA6VQkClMIVlfOXRfYrxcFxYEtHTAs
 Kcw
X-Received: by 2002:a05:622a:292:b0:505:e529:11e9 with SMTP id
 d75a77b69052e-508e69b9239mr49038901cf.36.1772743928511; 
 Thu, 05 Mar 2026 12:52:08 -0800 (PST)
Received: from pc.taild8403c.ts.net (216-71-219-44.dyn.novuscom.net.
 [216.71.219.44]) by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-89a0e31b035sm65559396d6.17.2026.03.05.12.52.07
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 05 Mar 2026 12:52:08 -0800 (PST)
From: Pierrick Bouvier <pierrick.bouvier@linaro.org>
To: qemu-devel@nongnu.org, peter.maydell@linaro.org,
 richard.henderson@linaro.org, pbonzini@redhat.com, stefanha@redhat.com
Cc: pierrick.bouvier@linaro.org
Subject: [PULL 05/12] tests/tcg: add tests for qemu_plugin_set_pc API
Date: Thu,  5 Mar 2026 12:51:45 -0800
Message-ID: <20260305205152.2121854-6-pierrick.bouvier@linaro.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260305205152.2121854-1-pierrick.bouvier@linaro.org>
References: <20260305205152.2121854-1-pierrick.bouvier@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::830;
 envelope-from=pierrick.bouvier@linaro.org; helo=mail-qt1-x830.google.com
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
List-Id: qemu development <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

From: Florian Hofhammer <florian.hofhammer@epfl.ch>

The test plugin intercepts execution in different contexts. Without the
plugin, any of the implemented test functions would trigger an assert
and fail. With the plugin, control flow is redirected to skip the assert
and return cleanly via the qemu_plugin_set_pc() API.

Signed-off-by: Florian Hofhammer <florian.hofhammer@epfl.ch>
Reviewed-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
Link: https://lore.kernel.org/qemu-devel/20260305-setpc-v5-v7-5-4c3adba52403@epfl.ch
Signed-off-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
---
 MAINTAINERS                                   |   1 +
 .../{ => plugin}/test-plugin-mem-access.c     |   0
 .../tcg/multiarch/plugin/test-plugin-set-pc.c | 134 ++++++++++++++++++
 tests/tcg/plugins/setpc.c                     | 105 ++++++++++++++
 tests/tcg/arm/Makefile.target                 |   6 +
 tests/tcg/hexagon/Makefile.target             |   8 ++
 tests/tcg/multiarch/Makefile.target           |  17 ++-
 .../{ => plugin}/check-plugin-output.sh       |   0
 tests/tcg/plugins/meson.build                 |   1 +
 9 files changed, 269 insertions(+), 3 deletions(-)
 rename tests/tcg/multiarch/{ => plugin}/test-plugin-mem-access.c (100%)
 create mode 100644 tests/tcg/multiarch/plugin/test-plugin-set-pc.c
 create mode 100644 tests/tcg/plugins/setpc.c
 rename tests/tcg/multiarch/{ => plugin}/check-plugin-output.sh (100%)

diff --git a/MAINTAINERS b/MAINTAINERS
index 6698e5ff69c..63c0af4d86d 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -4104,6 +4104,7 @@ S: Maintained
 F: docs/devel/tcg-plugins.rst
 F: plugins/
 F: tests/tcg/plugins/
+F: tests/tcg/multiarch/plugin/
 F: tests/functional/aarch64/test_tcg_plugins.py
 F: contrib/plugins/
 F: scripts/qemu-plugin-symbols.py
diff --git a/tests/tcg/multiarch/test-plugin-mem-access.c b/tests/tcg/multiarch/plugin/test-plugin-mem-access.c
similarity index 100%
rename from tests/tcg/multiarch/test-plugin-mem-access.c
rename to tests/tcg/multiarch/plugin/test-plugin-mem-access.c
diff --git a/tests/tcg/multiarch/plugin/test-plugin-set-pc.c b/tests/tcg/multiarch/plugin/test-plugin-set-pc.c
new file mode 100644
index 00000000000..f8343dfba84
--- /dev/null
+++ b/tests/tcg/multiarch/plugin/test-plugin-set-pc.c
@@ -0,0 +1,134 @@
+/*
+ * SPDX-License-Identifier: GPL-2.0-or-later
+ *
+ * Copyright (C) 2026, Florian Hofhammer <florian.hofhammer@epfl.ch>
+ *
+ * This test set exercises the qemu_plugin_set_pc() function in four different
+ * contexts:
+ * 1. in an instruction callback during normal execution,
+ * 2. in an instruction callback during signal handling,
+ * 3. in a memory access callback.
+ * 4. in a syscall callback,
+ */
+#include <assert.h>
+#include <signal.h>
+#include <stdint.h>
+#include <stdlib.h>
+#include <stdio.h>
+#include <unistd.h>
+
+/* If we issue this magic syscall, ... */
+#define MAGIC_SYSCALL 4096
+/* ... the plugin either jumps directly to the target address ... */
+#define SETPC 0
+/* ... or just updates the target address for future use in callbacks. */
+#define SETTARGET 1
+
+static int signal_handled;
+
+void panic(const char *msg)
+{
+    fprintf(stderr, "Panic: %s\n", msg);
+    abort();
+}
+
+/*
+ * This test executes a magic syscall which communicates two addresses to the
+ * plugin via the syscall arguments. Whenever we reach the "bad" instruction
+ * during normal execution, the plugin should redirect control flow to the
+ * "good" instruction instead.
+ */
+void test_insn(void)
+{
+    long ret = syscall(MAGIC_SYSCALL, SETTARGET, &&bad_insn, &&good_insn,
+                       NULL);
+    assert(ret == 0 && "Syscall filter did not return expected value");
+bad_insn:
+    panic("PC redirection in instruction callback failed");
+good_insn:
+    puts("PC redirection in instruction callback succeeded");
+}
+
+/*
+ * This signal handler communicates a "bad" and a "good" address to the plugin
+ * similar to the previous test, and skips to the "good" address when the "bad"
+ * one is reached. This serves to test whether PC redirection via
+ * qemu_plugin_set_pc() also works properly in a signal handler context.
+ */
+void usr1_handler(int signum)
+{
+    long ret = syscall(MAGIC_SYSCALL, SETTARGET, &&bad_signal, &&good_signal,
+                       NULL);
+    assert(ret == 0 && "Syscall filter did not return expected value");
+bad_signal:
+    panic("PC redirection in instruction callback failed");
+good_signal:
+    signal_handled = 1;
+    puts("PC redirection in instruction callback succeeded");
+}
+
+/*
+ * This test sends a signal to the process, which should trigger the above
+ * signal handler. The signal handler should then exercise the PC redirection
+ * functionality in the context of a signal handler, which behaves a bit
+ * differently from normal execution.
+ */
+void test_sighandler(void)
+{
+    struct sigaction sa = {0};
+    sa.sa_handler = usr1_handler;
+    sigaction(SIGUSR1, &sa, NULL);
+    pid_t pid = getpid();
+    kill(pid, SIGUSR1);
+    assert(signal_handled == 1 && "Signal handler was not executed properly");
+}
+
+/*
+ * This test communicates a "good" address and the address of a local variable
+ * to the plugin. Upon accessing the local variable, the plugin should then
+ * redirect control flow to the "good" address via qemu_plugin_set_pc().
+ */
+void test_mem(void)
+{
+    static uint32_t test = 1;
+    long ret = syscall(MAGIC_SYSCALL, SETTARGET, NULL, &&good_mem, &test);
+    assert(ret == 0 && "Syscall filter did not return expected value");
+    /* Ensure read access to the variable to trigger the plugin callback */
+    assert(test == 1);
+    panic("PC redirection in memory access callback failed");
+good_mem:
+    puts("PC redirection in memory access callback succeeded");
+}
+
+/*
+ * This test executes a magic syscall which is intercepted and its actual
+ * execution skipped via the qemu_plugin_set_pc() API. In a proper plugin,
+ * syscall skipping would rather be implemented via the syscall filtering
+ * callback, but we want to make sure qemu_plugin_set_pc() works in different
+ * contexts.
+ */
+__attribute__((noreturn))
+void test_syscall(void)
+{
+    syscall(MAGIC_SYSCALL, SETPC, &&good_syscall);
+    panic("PC redirection in syscall callback failed");
+good_syscall:
+    /*
+     * Note: we execute this test last and exit straight from here because when
+     * the plugin redirects control flow upon syscall, the stack frame for the
+     * syscall function (and potential other functions in the call chain in
+     * libc) is still live and the stack is not unwound properly. Thus,
+     * returning from here is risky and breaks on some architectures, so we
+     * just exit directly from this test.
+     */
+    _exit(EXIT_SUCCESS);
+}
+
+
+int main(int argc, char *argv[])
+{
+    test_insn();
+    test_sighandler();
+    test_mem();
+    test_syscall();
+}
diff --git a/tests/tcg/plugins/setpc.c b/tests/tcg/plugins/setpc.c
new file mode 100644
index 00000000000..8f2d025e245
--- /dev/null
+++ b/tests/tcg/plugins/setpc.c
@@ -0,0 +1,105 @@
+/*
+ * SPDX-License-Identifier: GPL-2.0-or-later
+ *
+ * Copyright (C) 2026, Florian Hofhammer <florian.hofhammer@epfl.ch>
+ */
+#include <assert.h>
+#include <glib.h>
+#include <inttypes.h>
+#include <unistd.h>
+
+#include <qemu-plugin.h>
+
+/* If we detect this magic syscall, ... */
+#define MAGIC_SYSCALL 4096
+/* ... the plugin either jumps directly to the target address ... */
+#define SETPC 0
+/* ... or just updates the target address for future use in callbacks. */
+#define SETTARGET 1
+
+QEMU_PLUGIN_EXPORT int qemu_plugin_version = QEMU_PLUGIN_VERSION;
+
+static uint64_t source_pc;
+static uint64_t target_pc;
+static uint64_t target_vaddr;
+
+static bool vcpu_syscall_filter(qemu_plugin_id_t id, unsigned int vcpu_index,
+                                int64_t num, uint64_t a1, uint64_t a2,
+                                uint64_t a3, uint64_t a4, uint64_t a5,
+                                uint64_t a6, uint64_t a7, uint64_t a8,
+                                uint64_t *sysret)
+{
+    if (num == MAGIC_SYSCALL) {
+        if (a1 == SETPC) {
+            qemu_plugin_outs("Magic syscall detected, jump to clean exit\n");
+            qemu_plugin_set_pc(a2);
+        } else if (a1 == SETTARGET) {
+            qemu_plugin_outs("Magic syscall detected, set target_pc / "
+                             "target_vaddr\n");
+            source_pc = a2;
+            target_pc = a3;
+            target_vaddr = a4;
+            *sysret = 0;
+            return true;
+        } else {
+            qemu_plugin_outs("Unknown magic syscall argument, ignoring\n");
+        }
+    }
+    return false;
+}
+
+static void vcpu_insn_exec(unsigned int vcpu_index, void *userdata)
+{
+    uint64_t vaddr = (uint64_t)userdata;
+    if (vaddr == source_pc) {
+        g_assert(target_pc != 0);
+        g_assert(target_vaddr == 0);
+
+        qemu_plugin_outs("Marker insn detected, jump to clean return\n");
+        qemu_plugin_set_pc(target_pc);
+    }
+}
+
+static void vcpu_mem_access(unsigned int vcpu_index,
+                            qemu_plugin_meminfo_t info,
+                            uint64_t vaddr, void *userdata)
+{
+    if (vaddr != 0 && vaddr == target_vaddr) {
+        g_assert(source_pc == 0);
+        g_assert(target_pc != 0);
+
+        qemu_plugin_outs("Marker mem access detected, jump to clean return\n");
+        qemu_plugin_set_pc(target_pc);
+    }
+}
+
+static void vcpu_tb_trans(qemu_plugin_id_t id, struct qemu_plugin_tb *tb)
+{
+    size_t insns = qemu_plugin_tb_n_insns(tb);
+    for (size_t i = 0; i < insns; i++) {
+        struct qemu_plugin_insn *insn = qemu_plugin_tb_get_insn(tb, i);
+        uint64_t insn_vaddr = qemu_plugin_insn_vaddr(insn);
+        /*
+         * Note: we cannot only register the callbacks if the instruction is
+         * in one of the functions of interest, because symbol lookup for
+         * filtering does not work for all architectures (e.g., ppc64).
+         */
+        qemu_plugin_register_vcpu_insn_exec_cb(insn, vcpu_insn_exec,
+                                               QEMU_PLUGIN_CB_RW_REGS_PC,
+                                               (void *)insn_vaddr);
+        qemu_plugin_register_vcpu_mem_cb(insn, vcpu_mem_access,
+                                         QEMU_PLUGIN_CB_RW_REGS_PC,
+                                         QEMU_PLUGIN_MEM_R, NULL);
+    }
+}
+
+
+QEMU_PLUGIN_EXPORT int qemu_plugin_install(qemu_plugin_id_t id,
+                                           const qemu_info_t *info,
+                                           int argc, char **argv)
+{
+
+    qemu_plugin_register_vcpu_syscall_filter_cb(id, vcpu_syscall_filter);
+    qemu_plugin_register_vcpu_tb_trans_cb(id, vcpu_tb_trans);
+    return 0;
+}
diff --git a/tests/tcg/arm/Makefile.target b/tests/tcg/arm/Makefile.target
index 6189d7a0e24..613bbf0939a 100644
--- a/tests/tcg/arm/Makefile.target
+++ b/tests/tcg/arm/Makefile.target
@@ -78,4 +78,10 @@ sha512-vector: sha512.c
 
 ARM_TESTS += sha512-vector
 
+ifeq ($(CONFIG_PLUGIN),y)
+# Require emitting arm32 instructions, otherwise the vCPU might accidentally
+# try to execute Thumb instructions in arm32 mode after qemu_plugin_set_pc()
+test-plugin-set-pc: CFLAGS+=-marm
+endif
+
 TESTS += $(ARM_TESTS)
diff --git a/tests/tcg/hexagon/Makefile.target b/tests/tcg/hexagon/Makefile.target
index f86f02bb31c..a70ef2f6607 100644
--- a/tests/tcg/hexagon/Makefile.target
+++ b/tests/tcg/hexagon/Makefile.target
@@ -126,3 +126,11 @@ v73_scalar: CFLAGS += -Wno-unused-function
 
 hvx_histogram: hvx_histogram.c hvx_histogram_row.S
 	$(CC) $(CFLAGS) $(CROSS_CC_GUEST_CFLAGS) $^ -o $@ $(LDFLAGS)
+
+ifeq ($(CONFIG_PLUGIN),y)
+# LLVM is way too aggressive with inlining and dead code elimination even at
+# -O0, which interferes with the test. What looks like dead code in this test
+# to the compiler isn't actually dead code, so we need to disable all potential
+# LLVM optimization passes.
+test-plugin-set-pc: CFLAGS += -Xclang -disable-llvm-passes
+endif
diff --git a/tests/tcg/multiarch/Makefile.target b/tests/tcg/multiarch/Makefile.target
index 07d0b27bdd3..a347efbadf0 100644
--- a/tests/tcg/multiarch/Makefile.target
+++ b/tests/tcg/multiarch/Makefile.target
@@ -14,6 +14,10 @@ ifeq ($(filter %-linux-user, $(TARGET)),$(TARGET))
 VPATH 	       += $(MULTIARCH_SRC)/linux
 MULTIARCH_SRCS += $(notdir $(wildcard $(MULTIARCH_SRC)/linux/*.c))
 endif
+ifeq ($(CONFIG_PLUGIN),y)
+VPATH 	       += $(MULTIARCH_SRC)/plugin
+MULTIARCH_SRCS += $(notdir $(wildcard $(MULTIARCH_SRC)/plugin/*.c))
+endif
 MULTIARCH_TESTS = $(MULTIARCH_SRCS:.c=)
 
 #
@@ -200,13 +204,20 @@ run-plugin-test-plugin-mem-access-with-libmem.so: \
 	PLUGIN_ARGS=$(COMMA)print-accesses=true
 run-plugin-test-plugin-mem-access-with-libmem.so: \
 	CHECK_PLUGIN_OUTPUT_COMMAND= \
-	$(SRC_PATH)/tests/tcg/multiarch/check-plugin-output.sh \
+	$(SRC_PATH)/tests/tcg/multiarch/plugin/check-plugin-output.sh \
 	$(QEMU) $<
 run-plugin-test-plugin-syscall-filter-with-libsyscall.so:
+run-plugin-test-plugin-set-pc-with-libsetpc.so:
 
 EXTRA_RUNS_WITH_PLUGIN += run-plugin-test-plugin-mem-access-with-libmem.so \
-			  run-plugin-test-plugin-syscall-filter-with-libsyscall.so
-else
+			  run-plugin-test-plugin-syscall-filter-with-libsyscall.so \
+			  run-plugin-test-plugin-set-pc-with-libsetpc.so
+
+else # CONFIG_PLUGIN=n
+# Do not build the syscall skipping test if it's not tested with the setpc
+# plugin because it will simply fail the test.
+MULTIARCH_TESTS := $(filter-out test-plugin-set-pc, $(MULTIARCH_TESTS))
+
 # test-plugin-syscall-filter needs syscall plugin to succeed
 test-plugin-syscall-filter: CFLAGS+=-DSKIP
 endif
diff --git a/tests/tcg/multiarch/check-plugin-output.sh b/tests/tcg/multiarch/plugin/check-plugin-output.sh
similarity index 100%
rename from tests/tcg/multiarch/check-plugin-output.sh
rename to tests/tcg/multiarch/plugin/check-plugin-output.sh
diff --git a/tests/tcg/plugins/meson.build b/tests/tcg/plugins/meson.build
index c5e49753fd9..b3e3a9a6d02 100644
--- a/tests/tcg/plugins/meson.build
+++ b/tests/tcg/plugins/meson.build
@@ -7,6 +7,7 @@ test_plugins = [
 'mem.c',
 'patch.c',
 'reset.c',
+'setpc.c',
 'syscall.c',
 ]
 
-- 
2.47.3


