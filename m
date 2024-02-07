Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 142C7C4828F
	for <qemu-devel@archiver.kernel.org>; Wed,  7 Feb 2024 16:39:24 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rXkwV-00031f-Pk; Wed, 07 Feb 2024 11:38:35 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1rXkwS-0002zh-4y
 for qemu-devel@nongnu.org; Wed, 07 Feb 2024 11:38:32 -0500
Received: from mail-wr1-x429.google.com ([2a00:1450:4864:20::429])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1rXkwN-0006Bb-91
 for qemu-devel@nongnu.org; Wed, 07 Feb 2024 11:38:31 -0500
Received: by mail-wr1-x429.google.com with SMTP id
 ffacd0b85a97d-33b0f36b808so658469f8f.3
 for <qemu-devel@nongnu.org>; Wed, 07 Feb 2024 08:38:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1707323905; x=1707928705; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=5KJnAd/m0KGguzc/ly2OcxGET3ckYILVYJ7JRk/PTxI=;
 b=s6PDiUegFVlSnXH8YTlwNfbdqhWilqYNpzqCzBuNhDAuDdZ361PB+GxrBaJ+Bf0NCK
 +Jx2dqdVkf+sZSyH84ucV4gmrk8/ZJb1vnyEOI9RM/Z+kk8Au2i8fibQZ11u/D1dDHLi
 CRsntqg3/qeYd0mEb/Nw+vEUqu3Af4yGqf9zsYF5xpnMjNB9zVyWwI/PA0wT8jz20IPy
 OV/k2NwtOsrYpfaMLKXUgoX7UM6AEkEm3wEyoRmKbU+xmtsWL+Gsp0ST71XB2swr0wBb
 WtWTyTRFAfcAkKBOyMMOADVlzrkRq4XMSQAszDePWd3I23YdZuwOTcj5dqxScCW22yAK
 G42Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1707323905; x=1707928705;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=5KJnAd/m0KGguzc/ly2OcxGET3ckYILVYJ7JRk/PTxI=;
 b=sN/vR0xl3kRSRPzDffVvu3sCkDfcZh5y1YJqLtfX1+bOk1un8WvZGePhj/WEZ9GRcf
 aaWBPjmiJhKecMC7eFycZSCHoVpxlMjPntUna7J9i9vGVZxm4Sk1Yp6r0XFIiItF0q9i
 LllpMoDkIUxfF34iXd4MVrnPqzxrCGbwr2QfPmzziBrlGFIecwMyinuzN3hQuehrUQKj
 OXLyny90OqXYiaLUXrc2jhAiYFcUgjp6D82e/Y1Ydwu1QOexR02plGPTHQ1MGyvb6ntC
 DUzgmfmTz0qkbhn/CqRmHYOgVtvjIy1auxvyj4tDgbOcFJfNjofJPt4IuMRNXe/Gptd9
 DI2Q==
X-Gm-Message-State: AOJu0Ywt6FX4YuVtBdjFUeYVSIlHv4O6VE7ygo/JlTmbv5CsJ+MG4nga
 qJ2pfI5j4K22LdyRAAZfjUQtyEAp09qCk9Df+cLjPsCLJyottQ2wuTGtpcwSjmI=
X-Google-Smtp-Source: AGHT+IF9VickhyecZOJwME0QBAJAMHWcwaQQF970D9Gx+XhaMtGVndh8N+3ffgzOPMo3aKT0qGuCZw==
X-Received: by 2002:adf:ecc3:0:b0:33b:37f6:2388 with SMTP id
 s3-20020adfecc3000000b0033b37f62388mr4149932wro.58.1707323905659; 
 Wed, 07 Feb 2024 08:38:25 -0800 (PST)
X-Forwarded-Encrypted: i=1;
 AJvYcCV4xwNCVOQMPGULI/JYjc6IgG/O8Um2nQJ+6HOUuNEu2CqPr5Rj+E8wUXYIkPZTciNs9c6zu7wk7b8BE2gYNUeRQi0ZpqinY9LeYQ7f83qubpvSdlIu4Er9c43b/1nFBYCM5uBx6UMWHFSO9EbAFxMjAU3KjnCOKXhT6JwUqyyXyqItny7G4xcN3oyD2w4vXkzSWYukbrABOzyoD2VYXmRe7eocIEZJ14esXqKuhT/4fDVJ2XdF7bxQj2nTHOfK08IGGqzhC34hwmpx+DpERXic05oZzvHGRBWBMGGlxt9Sr5HcVfSh5jQgoK5Qj/AfvI5N6Tt335AWI1K2SyhF51uvBHVkPUPGpIe9kEHk+hN7M973woNexzYMWktqqpO9txLjplLtesr/nzEHBZf7S+tUnfdt+aYovEuC4lKqczw9DhRRgxJVwImupnAO39r/lYxdmedXtua0tcXmCF/gkjc+ePOLNzs14abo1bARa9jeV0LHUHak1eoB/PDKmhrMMHeAVTXPQnNPTtXAW5ihNlWsiH6KHEk90HU5Eihr3J6yqk7tDHnaqMMBMCtqr7JGCrd2FFOMQZQ9q8t0pIghRiQnqM+a2dbNc3ApnqdwqEerI+cNLV5BUwCd951FCc8nJeQ1ekXFUzYaSJqiBwicOedgCbsh/xoPjamBV91MGC3uZ+oLrqi3SRzEkIhmPpNU4br0gz6Qw/PcD1fBigdQTYLeBdenL07LrjJTOng7k/CPm/x1eiIryBHf6hcebcGYDNALygoWTxWKqeaOMN5FkfY6Tzv9sZBeiTRoZl7dWHm34KP1eUyzZDbUEmGxW6tsn7rSXWr1Tgmrj89eRduEMcg8ewcDfIEZ25MfklRv
Received: from draig.lan ([85.9.250.243]) by smtp.gmail.com with ESMTPSA id
 d11-20020adff2cb000000b0033b278cf5fesm1852996wrp.102.2024.02.07.08.38.17
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 07 Feb 2024 08:38:24 -0800 (PST)
Received: from draig.lan (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id 761775F9CF;
 Wed,  7 Feb 2024 16:38:13 +0000 (GMT)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Cc: devel@lists.libvirt.org, Jiaxun Yang <jiaxun.yang@flygoat.com>,
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>,
 Chris Wulff <crwulff@gmail.com>, Weiwei Li <liwei1518@gmail.com>,
 Bin Meng <bin.meng@windriver.com>, Thomas Huth <thuth@redhat.com>,
 qemu-riscv@nongnu.org, Marek Vasut <marex@denx.de>,
 Liu Zhiwei <zhiwei_liu@linux.alibaba.com>,
 Aleksandar Rikalo <aleksandar.rikalo@syrmia.com>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Alistair Francis <alistair.francis@wdc.com>, Warner Losh <imp@bsdimp.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Aurelien Jarno <aurelien@aurel32.net>,
 Beraldo Leal <bleal@redhat.com>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Max Filippov <jcmvbkbc@gmail.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Ed Maste <emaste@freebsd.org>, Palmer Dabbelt <palmer@dabbelt.com>,
 Li-Wen Hsu <lwhsu@freebsd.org>, Laurent Vivier <laurent@vivier.eu>,
 Kyle Evans <kevans@freebsd.org>,
 Wainer dos Santos Moschetta <wainersm@redhat.com>,
 Riku Voipio <riku.voipio@iki.fi>, Ilya Leoshkevich <iii@linux.ibm.com>
Subject: [PATCH v2 14/14] tests/tcg: Add the syscall catchpoint gdbstub test
Date: Wed,  7 Feb 2024 16:38:12 +0000
Message-Id: <20240207163812.3231697-15-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240207163812.3231697-1-alex.bennee@linaro.org>
References: <20240207163812.3231697-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::429;
 envelope-from=alex.bennee@linaro.org; helo=mail-wr1-x429.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, T_SCC_BODY_TEXT_LINE=-0.01,
 T_SPF_TEMPERROR=0.01 autolearn=unavailable autolearn_force=no
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
---
 tests/tcg/multiarch/catch-syscalls.c          | 51 ++++++++++++++++++
 tests/tcg/multiarch/Makefile.target           | 10 +++-
 tests/tcg/multiarch/gdbstub/catch-syscalls.py | 53 +++++++++++++++++++
 3 files changed, 113 insertions(+), 1 deletion(-)
 create mode 100644 tests/tcg/multiarch/catch-syscalls.c
 create mode 100644 tests/tcg/multiarch/gdbstub/catch-syscalls.py

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


