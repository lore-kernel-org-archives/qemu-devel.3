Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 04195C4828F
	for <qemu-devel@archiver.kernel.org>; Fri,  9 Feb 2024 19:49:10 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rYWrG-0006CD-7k; Fri, 09 Feb 2024 14:48:22 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1rYWqg-0005XN-4U
 for qemu-devel@nongnu.org; Fri, 09 Feb 2024 14:47:46 -0500
Received: from mail-lf1-x135.google.com ([2a00:1450:4864:20::135])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1rYWqd-0005Bs-CN
 for qemu-devel@nongnu.org; Fri, 09 Feb 2024 14:47:45 -0500
Received: by mail-lf1-x135.google.com with SMTP id
 2adb3069b0e04-5114cd44f6aso1727827e87.1
 for <qemu-devel@nongnu.org>; Fri, 09 Feb 2024 11:47:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1707508061; x=1708112861; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=0d2pZ0e5UPseU4WURy0h/XaynSRo4oQrGrKaJsFP1mk=;
 b=D04MeVw6XDM2wuEcccS4EWl4dfDc2uL0JAho5nfkoK1E6wkaTHWI7YYnaId0JfBfs9
 ieCwt8xZnhKROJZHL/TF9zG9IyRqsES+odLEhlH2kjJrIf3Um5CmG3Vsl3ezUgVVAloo
 9WaUR/GjzWIyuV1viOGyat3aNMPSvJ7cOBaj/okNROEwLBlu0AEl2vUE+ouGiNluhAl1
 9VWb98LzIutt4sV99bWgtqbvH523ne1P2jxRa+JM83/JA1+TlQYymLBhpqqZukogU8lh
 Ij2Kq6HPrP6nVelIIJSqcXlc3WA6MO1s1I0vrk2Qj0LoymvV2qOCgP61NfNEtSR6v/7t
 F7kQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1707508061; x=1708112861;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=0d2pZ0e5UPseU4WURy0h/XaynSRo4oQrGrKaJsFP1mk=;
 b=MU+B98y45T09ZtCJzlftC1oEzVKzj9YJOpyJLvOt1qFYXjY0AixJ9xAJA9hFlTk++D
 iZ+sRkmVm6NKVHbkwi3NYfq+p/6MHdYMHmDQkZwA2+A3MszXGgao+wLu+1oK0b5JkQ8/
 MDYgusRC4owI7wMIkmQAHk1Z7nzA+C8WevQ5glkR+S5MeK0jekdsj+XyU0U4JPS1iWhD
 xb/AP1J5T/JfLzqMwg0o3QNYqvVcraTALY6D9LAXN3dZETKkSBDUqZ65YhxQ9ocpMX2U
 uknded/Vz7/++h05QEwHPmbQcZBOea4IJmwiQvLf2M8mK2ghUW3CNoWJfkaABLjOqWQz
 Pd7Q==
X-Gm-Message-State: AOJu0YxN1CUGLN3ulOweNXNXNn2RSHYODeCzplN0GGXSwH8wLgk73l0w
 XN/skRxgqWE176h+DABV54TDBiShlW3WwBK5DFUoxPrWsK+8Ql9YBYssFpEsGdE=
X-Google-Smtp-Source: AGHT+IFo/GcgeTYSLnKUjtLnTsCI+xoMMfe+qP1u0yFX/16OlthLP6p6a5udSi8yIOaMsMTE55ilYQ==
X-Received: by 2002:ac2:46c9:0:b0:511:7a9f:58c4 with SMTP id
 p9-20020ac246c9000000b005117a9f58c4mr13997lfo.38.1707508061303; 
 Fri, 09 Feb 2024 11:47:41 -0800 (PST)
X-Forwarded-Encrypted: i=1;
 AJvYcCV+GudEapOEZ8vtHIuZXPTnXLEBWebpO7XOzUgL8Vqawfr9vXcTZobC9GsRAPt6F8h31WrkA2MEJggGgMxf8k3oBpm3nKQghWIUpSSC8SS1EHgiQohmKViknw==
Received: from draig.lan ([85.9.250.243]) by smtp.gmail.com with ESMTPSA id
 bv4-20020a0560001f0400b0033b670b0a6asm43626wrb.74.2024.02.09.11.47.36
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 09 Feb 2024 11:47:37 -0800 (PST)
Received: from draig.lan (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id A40AC5F7DF;
 Fri,  9 Feb 2024 19:47:35 +0000 (GMT)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Cc: Ilya Leoshkevich <iii@linux.ibm.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PULL 10/10] tests/tcg: Add the syscall catchpoint gdbstub test
Date: Fri,  9 Feb 2024 19:47:34 +0000
Message-Id: <20240209194734.3424785-11-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240209194734.3424785-1-alex.bennee@linaro.org>
References: <20240209194734.3424785-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::135;
 envelope-from=alex.bennee@linaro.org; helo=mail-lf1-x135.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

From: Ilya Leoshkevich <iii@linux.ibm.com>

Check that adding/removing syscall catchpoints works.

Reviewed-by: Alex Bennée <alex.bennee@linaro.org>
Signed-off-by: Ilya Leoshkevich <iii@linux.ibm.com>
Message-Id: <20240202152506.279476-6-iii@linux.ibm.com>
Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
Message-Id: <20240207163812.3231697-15-alex.bennee@linaro.org>

diff --git a/tests/tcg/multiarch/catch-syscalls.c b/tests/tcg/multiarch/catch-syscalls.c
new file mode 100644
index 00000000000..d1ff1936a7a
--- /dev/null
+++ b/tests/tcg/multiarch/catch-syscalls.c
@@ -0,0 +1,51 @@
+/*
+ * Test GDB syscall catchpoints.
+ *
+ * SPDX-License-Identifier: GPL-2.0-or-later
+ */
+#define _GNU_SOURCE
+#include <stdlib.h>
+#include <unistd.h>
+
+const char *catch_syscalls_state = "start";
+
+void end_of_main(void)
+{
+}
+
+int main(void)
+{
+    int ret = EXIT_FAILURE;
+    char c0 = 'A', c1;
+    int fd[2];
+
+    catch_syscalls_state = "pipe2";
+    if (pipe2(fd, 0)) {
+        goto out;
+    }
+
+    catch_syscalls_state = "write";
+    if (write(fd[1], &c0, sizeof(c0)) != sizeof(c0)) {
+        goto out_close;
+    }
+
+    catch_syscalls_state = "read";
+    if (read(fd[0], &c1, sizeof(c1)) != sizeof(c1)) {
+        goto out_close;
+    }
+
+    catch_syscalls_state = "check";
+    if (c0 == c1) {
+        ret = EXIT_SUCCESS;
+    }
+
+out_close:
+    catch_syscalls_state = "close";
+    close(fd[0]);
+    close(fd[1]);
+
+out:
+    catch_syscalls_state = "end";
+    end_of_main();
+    return ret;
+}
diff --git a/tests/tcg/multiarch/Makefile.target b/tests/tcg/multiarch/Makefile.target
index 315a2e13588..e10951a8016 100644
--- a/tests/tcg/multiarch/Makefile.target
+++ b/tests/tcg/multiarch/Makefile.target
@@ -108,13 +108,21 @@ run-gdbstub-prot-none: prot-none
 		--bin $< --test $(MULTIARCH_SRC)/gdbstub/prot-none.py, \
 	accessing PROT_NONE memory)
 
+run-gdbstub-catch-syscalls: catch-syscalls
+	$(call run-test, $@, $(GDB_SCRIPT) \
+		--gdb $(GDB) \
+		--qemu $(QEMU) --qargs "$(QEMU_OPTS)" \
+		--bin $< --test $(MULTIARCH_SRC)/gdbstub/catch-syscalls.py, \
+	hitting a syscall catchpoint)
+
 else
 run-gdbstub-%:
 	$(call skip-test, "gdbstub test $*", "need working gdb with $(patsubst -%,,$(TARGET_NAME)) support")
 endif
 EXTRA_RUNS += run-gdbstub-sha1 run-gdbstub-qxfer-auxv-read \
 	      run-gdbstub-proc-mappings run-gdbstub-thread-breakpoint \
-	      run-gdbstub-registers run-gdbstub-prot-none
+	      run-gdbstub-registers run-gdbstub-prot-none \
+	      run-gdbstub-catch-syscalls
 
 # ARM Compatible Semi Hosting Tests
 #
diff --git a/tests/tcg/multiarch/gdbstub/catch-syscalls.py b/tests/tcg/multiarch/gdbstub/catch-syscalls.py
new file mode 100644
index 00000000000..ccce35902fb
--- /dev/null
+++ b/tests/tcg/multiarch/gdbstub/catch-syscalls.py
@@ -0,0 +1,53 @@
+"""Test GDB syscall catchpoints.
+
+SPDX-License-Identifier: GPL-2.0-or-later
+"""
+from test_gdbstub import main, report
+
+
+def check_state(expected):
+    """Check the catch_syscalls_state value"""
+    actual = gdb.parse_and_eval("catch_syscalls_state").string()
+    report(actual == expected, "{} == {}".format(actual, expected))
+
+
+def run_test():
+    """Run through the tests one by one"""
+    gdb.Breakpoint("main")
+    gdb.execute("continue")
+
+    # Check that GDB stops for pipe2/read calls/returns, but not for write.
+    gdb.execute("delete")
+    try:
+        gdb.execute("catch syscall pipe2 read")
+    except gdb.error as exc:
+        exc_str = str(exc)
+        if "not supported on this architecture" in exc_str:
+            print("SKIP: {}".format(exc_str))
+            return
+        raise
+    for _ in range(2):
+        gdb.execute("continue")
+        check_state("pipe2")
+    for _ in range(2):
+        gdb.execute("continue")
+        check_state("read")
+
+    # Check that deletion works.
+    gdb.execute("delete")
+    gdb.Breakpoint("end_of_main")
+    gdb.execute("continue")
+    check_state("end")
+
+    # Check that catch-all works (libc should at least call exit).
+    gdb.execute("delete")
+    gdb.execute("catch syscall")
+    gdb.execute("continue")
+    gdb.execute("delete")
+    gdb.execute("continue")
+
+    exitcode = int(gdb.parse_and_eval("$_exitcode"))
+    report(exitcode == 0, "{} == 0".format(exitcode))
+
+
+main(run_test)
-- 
2.39.2


