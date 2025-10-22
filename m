Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E5115CCD1AB
	for <qemu-devel@archiver.kernel.org>; Wed, 22 Oct 2025 06:55:11 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vBSkN-0007Kz-SD; Wed, 22 Oct 2025 02:55:00 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <functioner@sjtu.edu.cn>)
 id 1vBSkG-0007Hp-Ak
 for qemu-devel@nongnu.org; Wed, 22 Oct 2025 02:54:54 -0400
Received: from smtp233.sjtu.edu.cn ([202.120.2.233])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <functioner@sjtu.edu.cn>)
 id 1vBSkE-0007fi-1H
 for qemu-devel@nongnu.org; Wed, 22 Oct 2025 02:54:52 -0400
Received: from mta91.sjtu.edu.cn (unknown [10.118.0.91])
 by smtp233.sjtu.edu.cn (Postfix) with ESMTPS id 6C31A101B6934;
 Wed, 22 Oct 2025 14:54:46 +0800 (CST)
Received: from mstore136.sjtu.edu.cn (unknown [10.118.0.136])
 by mta91.sjtu.edu.cn (Postfix) with ESMTP id 3F65E37C8FB;
 Wed, 22 Oct 2025 14:54:46 +0800 (CST)
Date: Wed, 22 Oct 2025 14:54:46 +0800 (CST)
From: Ziyang Zhang <functioner@sjtu.edu.cn>
To: qemu-devel <qemu-devel@nongnu.org>
Cc: Riku Voipio <riku.voipio@iki.fi>, Laurent Vivier <laurent@vivier.eu>, 
 alex bennee <alex.bennee@linaro.org>, 
 Alexandre Iooss <erdnaxe@crans.org>, 
 Mahmoud Mandour <ma.mandourr@gmail.com>, 
 Pierrick Bouvier <pierrick.bouvier@linaro.org>, 
 richard henderson <richard.henderson@linaro.org>, 
 Zhengwei Qi <qizhwei@sjtu.edu.cn>, Yun Wang <yunwang94@sjtu.edu.cn>, 
 Mingyuan Xia <xiamy@ultrarisc.com>, Kailiang Xu <xukl2019@sjtu.edu.cn>
Message-ID: <577112454.5812719.1761116086174.JavaMail.zimbra@sjtu.edu.cn>
In-Reply-To: <1341969682.5812455.1761115945695.JavaMail.zimbra@sjtu.edu.cn>
References: <1341969682.5812455.1761115945695.JavaMail.zimbra@sjtu.edu.cn>
Subject: [RFC PATCH V2 2/2] tcg tests: add a test to verify the syscall
 filter plugin API
MIME-Version: 1.0
Content-Type: text/plain; charset=GB2312
Content-Transfer-Encoding: 7bit
X-Originating-IP: [119.237.255.163]
X-Mailer: Zimbra 10.0.14_GA_4767 (ZimbraWebClient - GC141
 (Win)/10.0.15_GA_4781)
Thread-Topic: tcg tests: add a test to verify the syscall filter plugin API
Thread-Index: O8UVQ/TJHmck9snQ4N2r1rVTqb8mpCd4fjGN
Received-SPF: pass client-ip=202.120.2.233;
 envelope-from=functioner@sjtu.edu.cn; helo=smtp233.sjtu.edu.cn
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

Register a syscall filter callback in tests/tcg/plugins/sycall.c,
returns a specific value for a magic system call number, and check
it in tests/tcg/multiarch/test-plugin-syscall-filter.c.

Signed-off-by: Ziyang Zhang <functioner@sjtu.edu.cn>
---
 tests/tcg/multiarch/Makefile.target              |  4 +++-
 tests/tcg/multiarch/test-plugin-syscall-filter.c | 21 +++++++++++++++++++++
 tests/tcg/plugins/syscall.c                      | 14 ++++++++++++++
 3 files changed, 38 insertions(+), 1 deletion(-)

diff --git a/tests/tcg/multiarch/Makefile.target b/tests/tcg/multiarch/Makefile.target
index f5b4d2b813..4005e3a8a9 100644
--- a/tests/tcg/multiarch/Makefile.target
+++ b/tests/tcg/multiarch/Makefile.target
@@ -202,8 +202,10 @@ run-plugin-test-plugin-mem-access-with-libmem.so: \
 	CHECK_PLUGIN_OUTPUT_COMMAND= \
 	$(SRC_PATH)/tests/tcg/multiarch/check-plugin-output.sh \
 	$(QEMU) $<
+run-plugin-test-plugin-syscall-filter-with-libsyscall.so:
 
-EXTRA_RUNS_WITH_PLUGIN += run-plugin-test-plugin-mem-access-with-libmem.so
+EXTRA_RUNS_WITH_PLUGIN += run-plugin-test-plugin-mem-access-with-libmem.so \
+			   			  run-plugin-test-plugin-syscall-filter-with-libsyscall.so
 endif
 
 # Update TESTS
diff --git a/tests/tcg/multiarch/test-plugin-syscall-filter.c b/tests/tcg/multiarch/test-plugin-syscall-filter.c
new file mode 100644
index 0000000000..e8676e4c29
--- /dev/null
+++ b/tests/tcg/multiarch/test-plugin-syscall-filter.c
@@ -0,0 +1,21 @@
+/*
+ * SPDX-License-Identifier: GPL-2.0-or-later
+ *
+ * This test attempts to execute a magic syscall. The syscall test plugin
+ * should intercept this and returns an expected value.
+ */
+
+#include <stdint.h>
+#include <stdio.h>
+#include <stdlib.h>
+#include <unistd.h>
+
+int main(int argc, char *argv[])
+{
+    long ret = syscall(0x66CCFF);
+    if (ret != 0xFFCC66) {
+        perror("ERROR: syscall returned unexpected value!!!");
+        return EXIT_FAILURE;
+    }
+    return EXIT_SUCCESS;
+}
diff --git a/tests/tcg/plugins/syscall.c b/tests/tcg/plugins/syscall.c
index 42801f5c86..310f69ff05 100644
--- a/tests/tcg/plugins/syscall.c
+++ b/tests/tcg/plugins/syscall.c
@@ -170,6 +170,19 @@ static void vcpu_syscall_ret(qemu_plugin_id_t id, unsigned int vcpu_idx,
     }
 }
 
+static bool vcpu_syscall_filter(qemu_plugin_id_t id, unsigned int vcpu_index,
+                         int64_t num, uint64_t a1, uint64_t a2,
+                         uint64_t a3, uint64_t a4, uint64_t a5,
+                         uint64_t a6, uint64_t a7, uint64_t a8, uint64_t *ret)
+{
+    if (num == 0x66CCFF) {
+        *ret = 0xFFCC66;
+        qemu_plugin_outs("syscall 0x66CCFF filtered, ret=0xFFCC66\n");
+        return true;
+    }
+    return false;
+}
+
 static void print_entry(gpointer val, gpointer user_data)
 {
     SyscallStats *entry = (SyscallStats *) val;
@@ -255,6 +268,7 @@ QEMU_PLUGIN_EXPORT int qemu_plugin_install(qemu_plugin_id_t id,
 
     qemu_plugin_register_vcpu_syscall_cb(id, vcpu_syscall);
     qemu_plugin_register_vcpu_syscall_ret_cb(id, vcpu_syscall_ret);
+    qemu_plugin_register_vcpu_syscall_filter_cb(id, vcpu_syscall_filter);
     qemu_plugin_register_atexit_cb(id, plugin_exit, NULL);
     return 0;
 }

-- 
2.25.1

