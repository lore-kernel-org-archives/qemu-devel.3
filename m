Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 544B9D46BF0
	for <qemu-devel@archiver.kernel.org>; Thu, 29 Jan 2026 01:41:34 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vlGtI-0000AB-2v; Wed, 28 Jan 2026 20:32:12 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1vlGt3-0008Rc-LZ
 for qemu-devel@nongnu.org; Wed, 28 Jan 2026 20:31:58 -0500
Received: from mail-pj1-x1036.google.com ([2607:f8b0:4864:20::1036])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1vlGsz-00038J-0N
 for qemu-devel@nongnu.org; Wed, 28 Jan 2026 20:31:57 -0500
Received: by mail-pj1-x1036.google.com with SMTP id
 98e67ed59e1d1-34c363eb612so248218a91.0
 for <qemu-devel@nongnu.org>; Wed, 28 Jan 2026 17:31:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1769650312; x=1770255112; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=CS8cAUD1XBowpTM1qiiVbzgN4octq0VLJzHo/F3/zzM=;
 b=XSHzJzwl3ubukcOQyVoG8+0e3Q4b/f2b5pDOHmmopMll3UO3kXozek5xZimVgxiLeB
 r397qtr2IiAs1fFLJJKZopGGndd4iGG4vpOY0z+4UtWIgFdw2PMMFLP9HOCxnASIGI0c
 r12XY8Hws+M6b4d25H9VfzJb/4pP+RXplX69IbVLMwMlQyct8Mt227phjkFl9I+3Gndp
 5sljf3x0ATejlJci7eMD/M11CzxItARe/PIlpYdt4cYFBKP8KJsGgRQYIs0Pi7PjWKs3
 dlzZCRKBbDmjNaD8b2DkQj79fp7f1KSsKHrBqrxQ4J7wc/2V6Gn0Hfvog+Gjl+q/urgl
 +z4g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1769650312; x=1770255112;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=CS8cAUD1XBowpTM1qiiVbzgN4octq0VLJzHo/F3/zzM=;
 b=HrF6uDVB/XJvJdPf0zDqJeAlocPbu2nxdQT/xqlnpj2F9OfGzp4kBhBf70BHTsbhvE
 pNJLBdpzNMcA4CFIlRNx56YV6dI+dtwQVAbzkGaZYb2RY1v1UK6DXZCqr8tYs5LrSwsT
 ACndyqcw3j1w6nUFp6wFoTWbH2KzTCmRtazRncehlpc656OajYOQqI/2zlIlYbXTBInm
 oVvw5fzxh3sCbsC8RHcS2iOqsgdmtyjxupoKsMPGZueEYq5MdY0nduUI+RnaTuciuowR
 1OPYmh6BaZSh3ObT3pLNSlmr35n6/NqrhAiZSdxlVYkkAxCdMvFYzNO5C2gVvbCDHNKB
 evpw==
X-Gm-Message-State: AOJu0YxbO/nArwx9KJI9RiZ7CpOHTVqrQDolQnyQf1R9XRnK0WRDwp6v
 +DCIXrsTB08Aruj2sTJTlaUpp/yXfIZygdhUPYYZFPg/mXesWkYtRhqLsl4fqVDq/l/wmB3vA0x
 SK8qI
X-Gm-Gg: AZuq6aIXXQ0mrUSEPLX+xSBpPNafvOATjyrxVB1v9e6bNj8gDqQn+uYynV0KgRyE47j
 wJxCn85Krs3PSd5a8VBtmPw70z7jDVCmZMT6P0qW05uVmU92+fgdfvepYP2ok91LHxQfx6XXUSj
 CMGlqj56FW5qubuM9tF4HQCqXX/KUT4ngFe9yCsYUOpxClt4+e5ll8fnDK1kG5UNOJM2Q6pVwfM
 0yPyrai51XBv5v3VeKoDLXEcYwvgeRuWyN8RRyHPfikd0XVELIPyQVoz1IU9xq4UAAAhlwrEL8e
 /1nk5iE2Bk2qRpxAKojOo5yTzTrhCavNBM5EwqSgN5s6oAQzHQt3lyrJgqe6vn0PydYyOxtn1XB
 JUk4cIJ3MMBCZSuc56ccovz3Nbe6uhutYBdhRZEPdiNKhUesuR4o9dabMNOu8wOGhz7nyrJSv4l
 NvtvUXTVaUiaDOp6KG8qoaeRVNMUBWCfRqONH8QQPFb8trZXEUhqpSymEGFZVzbiMM
X-Received: by 2002:a17:90b:1e51:b0:340:54a1:d6fe with SMTP id
 98e67ed59e1d1-353fecd6218mr6443282a91.15.1769650311504; 
 Wed, 28 Jan 2026 17:31:51 -0800 (PST)
Received: from pc.taild8403c.ts.net (216-71-219-44.dyn.novuscom.net.
 [216.71.219.44]) by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-353f61e0007sm6627143a91.12.2026.01.28.17.31.50
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 28 Jan 2026 17:31:51 -0800 (PST)
From: Pierrick Bouvier <pierrick.bouvier@linaro.org>
To: qemu-devel@nongnu.org
Cc: Ziyang Zhang <functioner@sjtu.edu.cn>, Mingyuan Xia <xiamy@ultrarisc.com>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>
Subject: [PULL 07/20] tcg tests: add a test to verify the syscall filter
 plugin API
Date: Wed, 28 Jan 2026 17:31:21 -0800
Message-ID: <20260129013134.3956938-8-pierrick.bouvier@linaro.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260129013134.3956938-1-pierrick.bouvier@linaro.org>
References: <20260129013134.3956938-1-pierrick.bouvier@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::1036;
 envelope-from=pierrick.bouvier@linaro.org; helo=mail-pj1-x1036.google.com
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

From: Ziyang Zhang <functioner@sjtu.edu.cn>

Register a syscall filter callback in tests/tcg/plugins/sycall.c,
returns a specific value for a magic system call number, and check
it in tests/tcg/multiarch/test-plugin-syscall-filter.c.

Signed-off-by: Ziyang Zhang <functioner@sjtu.edu.cn>
Co-authored-by: Mingyuan Xia <xiamy@ultrarisc.com>
Reviewed-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
[Pierrick - Changed syscall number to 4096 to make it work with mips32]
[Pierrick - Skip test when compiling without plugins enabled]
Signed-off-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
---
 .../multiarch/test-plugin-syscall-filter.c    | 39 +++++++++++++++++++
 tests/tcg/plugins/syscall.c                   | 19 +++++++++
 tests/tcg/multiarch/Makefile.target           |  7 +++-
 3 files changed, 64 insertions(+), 1 deletion(-)
 create mode 100644 tests/tcg/multiarch/test-plugin-syscall-filter.c

diff --git a/tests/tcg/multiarch/test-plugin-syscall-filter.c b/tests/tcg/multiarch/test-plugin-syscall-filter.c
new file mode 100644
index 00000000000..951e338a7c9
--- /dev/null
+++ b/tests/tcg/multiarch/test-plugin-syscall-filter.c
@@ -0,0 +1,39 @@
+/*
+ * SPDX-License-Identifier: GPL-2.0-or-later
+ *
+ * This test attempts to execute a magic syscall. The syscall test plugin
+ * should intercept this and return an expected value.
+ */
+
+#include <stdint.h>
+#include <stdio.h>
+#include <stdlib.h>
+#include <unistd.h>
+
+int main(int argc, char *argv[])
+{
+#ifdef SKIP
+    return EXIT_SUCCESS;
+#endif
+    /*
+     * We cannot use a very large magic syscall number, because on some ISAs,
+     * QEMU will treat it as an illegal instruction and trigger a critical
+     * exception. For instance, on arm32, the syscall number cannot exceed
+     * ARM_NR_BASE (0xf0000), as can be seen in
+     * "linux-user/arm/cpu_loop.c:cpu_loop".
+     * As well, some arch expect a minimum, like 4000 for mips 32 bits.
+     *
+     * Therefore, we pick 4096 because, as of now, no ISA in Linux uses this
+     * number. This is just a test case; replace this number as needed in the
+     * future.
+     *
+     * The corresponding syscall filter is implemented in
+     * "tests/tcg/plugins/syscall.c".
+     */
+    long ret = syscall(4096, 0x66CCFF);
+    if (ret != 0xFFCC66) {
+        fprintf(stderr, "Error: unexpected syscall return value %ld\n", ret);
+        return EXIT_FAILURE;
+    }
+    return EXIT_SUCCESS;
+}
diff --git a/tests/tcg/plugins/syscall.c b/tests/tcg/plugins/syscall.c
index 42801f5c863..5658f830879 100644
--- a/tests/tcg/plugins/syscall.c
+++ b/tests/tcg/plugins/syscall.c
@@ -170,6 +170,24 @@ static void vcpu_syscall_ret(qemu_plugin_id_t id, unsigned int vcpu_idx,
     }
 }
 
+static bool vcpu_syscall_filter(qemu_plugin_id_t id, unsigned int vcpu_index,
+                                int64_t num, uint64_t a1, uint64_t a2,
+                                uint64_t a3, uint64_t a4, uint64_t a5,
+                                uint64_t a6, uint64_t a7, uint64_t a8,
+                                uint64_t *sysret)
+{
+    /* Special syscall to test the filter functionality. */
+    if (num == 4096 && a1 == 0x66CCFF) {
+        *sysret = 0xFFCC66;
+
+        if (!statistics) {
+            qemu_plugin_outs("magic syscall filtered, set magic return\n");
+        }
+        return true;
+    }
+    return false;
+}
+
 static void print_entry(gpointer val, gpointer user_data)
 {
     SyscallStats *entry = (SyscallStats *) val;
@@ -255,6 +273,7 @@ QEMU_PLUGIN_EXPORT int qemu_plugin_install(qemu_plugin_id_t id,
 
     qemu_plugin_register_vcpu_syscall_cb(id, vcpu_syscall);
     qemu_plugin_register_vcpu_syscall_ret_cb(id, vcpu_syscall_ret);
+    qemu_plugin_register_vcpu_syscall_filter_cb(id, vcpu_syscall_filter);
     qemu_plugin_register_atexit_cb(id, plugin_exit, NULL);
     return 0;
 }
diff --git a/tests/tcg/multiarch/Makefile.target b/tests/tcg/multiarch/Makefile.target
index f5b4d2b8138..07d0b27bdd3 100644
--- a/tests/tcg/multiarch/Makefile.target
+++ b/tests/tcg/multiarch/Makefile.target
@@ -202,8 +202,13 @@ run-plugin-test-plugin-mem-access-with-libmem.so: \
 	CHECK_PLUGIN_OUTPUT_COMMAND= \
 	$(SRC_PATH)/tests/tcg/multiarch/check-plugin-output.sh \
 	$(QEMU) $<
+run-plugin-test-plugin-syscall-filter-with-libsyscall.so:
 
-EXTRA_RUNS_WITH_PLUGIN += run-plugin-test-plugin-mem-access-with-libmem.so
+EXTRA_RUNS_WITH_PLUGIN += run-plugin-test-plugin-mem-access-with-libmem.so \
+			  run-plugin-test-plugin-syscall-filter-with-libsyscall.so
+else
+# test-plugin-syscall-filter needs syscall plugin to succeed
+test-plugin-syscall-filter: CFLAGS+=-DSKIP
 endif
 
 # Update TESTS
-- 
2.47.3


