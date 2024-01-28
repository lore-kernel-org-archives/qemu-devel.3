Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 75447C47DDB
	for <qemu-devel@archiver.kernel.org>; Sun, 28 Jan 2024 04:46:34 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rTx0V-0004o9-U4; Sat, 27 Jan 2024 23:42:59 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1rTx0U-0004nQ-31
 for qemu-devel@nongnu.org; Sat, 27 Jan 2024 23:42:58 -0500
Received: from mail-ot1-x333.google.com ([2607:f8b0:4864:20::333])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1rTx0S-0004La-FY
 for qemu-devel@nongnu.org; Sat, 27 Jan 2024 23:42:57 -0500
Received: by mail-ot1-x333.google.com with SMTP id
 46e09a7af769-6e11cda9f6fso320121a34.2
 for <qemu-devel@nongnu.org>; Sat, 27 Jan 2024 20:42:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1706416975; x=1707021775; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=s84QwsvJ4FUEfSYgoD2xLjKpOUhTXQHsXWR0Okjxs+g=;
 b=esJ/DG5QHYlz2RF+C3L4+gDhtW4weBNIESMy+VH73gs4fqs3DIiqGV8v1a0MnXenqM
 r01sw0vlhje4nemCojnzakN3R/wtOVIsM5CQVAVRWIP5vHS/vrkHKQjjkARmx19rTtzH
 vSElKnvVTzJcUAg/vtps7NDm3K92HDF7ps3S1h8VDYxTNfr3wYbRRUgDLdMuTRJSSAvk
 s1lHa1EMS5dkZsGDJAUlpSEaHXkVe+XLp1rh2rn4k1GON1AbcJ4fN9YH+qCGixCXfWBL
 LeA7op+40LLJ0cKfp4EeQFzQXxnNGKS2LM6LfAwMsSOod6hJwr/yR6kTIBPc04wutNOO
 2ZFw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1706416975; x=1707021775;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=s84QwsvJ4FUEfSYgoD2xLjKpOUhTXQHsXWR0Okjxs+g=;
 b=oUhPt28u/rNlgUHrnmec/MhZZuHYnbr7+QYOuusVrVN0BOxLwTxCxOQbKGZE+6j07L
 3uLdI0FSJw97t2vRW4/O29jyilmG9ccsQmP0+Oc/1cxUtaEJrgD+3Kzvmiexh/pjMGBV
 RuBrWHWCJS618n5gMF1L9bM5iFC5FeiluSs6hHffzlbjpaIuQeB3d3KRyf+nqvB2TICd
 tyyo+YL9ahkq/WHq1TyxGEQghsbol7bpvrgRM0l3F1cZJkOnVJis2XkdVS4MaMFfRGS6
 Bel2sYAJhcTVEUPDRDMjO2L9t2756IHSKdHborIXJ718x/VIC77hXTrdBQ5bs1DR7+8Q
 cUUg==
X-Gm-Message-State: AOJu0YzhjSxeY93QGH+zvwO+0Z1zB3HxqkAdHIV0WuROVeTKAHqBg8AC
 PeqCeGXiSqUCbznDEA55NqXyBuV4sFdRiDWRaFRD8JqqW1/NT9wIyLxzfUyIzBIKvDCzFSxBk0T
 MCfSuBA==
X-Google-Smtp-Source: AGHT+IFjOJsDxai7Yqjd+IMqWSxpXCgee7cKN31LdGejTnFIbhjTt+jtXs/xsTE4PIV0sYEgB8/RWw==
X-Received: by 2002:a05:6358:2826:b0:175:7a57:81ed with SMTP id
 k38-20020a056358282600b001757a5781edmr3127610rwb.23.1706416975133; 
 Sat, 27 Jan 2024 20:42:55 -0800 (PST)
Received: from stoup..
 (ppp121-45-131-89.bri-pow-que-bras31.tpg.internode.on.net. [121.45.131.89])
 by smtp.gmail.com with ESMTPSA id
 w24-20020a17090aaf9800b002906e09e1d1sm5631873pjq.18.2024.01.27.20.42.53
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 27 Jan 2024 20:42:54 -0800 (PST)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: Ilya Leoshkevich <iii@linux.ibm.com>
Subject: [PATCH 15/33] tests/tcg: Add the PROT_NONE gdbstub test
Date: Sun, 28 Jan 2024 14:41:55 +1000
Message-Id: <20240128044213.316480-16-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240128044213.316480-1-richard.henderson@linaro.org>
References: <20240128044213.316480-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::333;
 envelope-from=richard.henderson@linaro.org; helo=mail-ot1-x333.google.com
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

Make sure that qemu gdbstub, like gdbserver, allows reading from and
writing to PROT_NONE pages.

Signed-off-by: Ilya Leoshkevich <iii@linux.ibm.com>
Message-Id: <20240109230808.583012-4-iii@linux.ibm.com>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 tests/tcg/multiarch/prot-none.c          | 40 ++++++++++++++++++++++++
 tests/tcg/multiarch/Makefile.target      |  9 +++++-
 tests/tcg/multiarch/gdbstub/prot-none.py | 22 +++++++++++++
 3 files changed, 70 insertions(+), 1 deletion(-)
 create mode 100644 tests/tcg/multiarch/prot-none.c
 create mode 100644 tests/tcg/multiarch/gdbstub/prot-none.py

diff --git a/tests/tcg/multiarch/prot-none.c b/tests/tcg/multiarch/prot-none.c
new file mode 100644
index 0000000000..dc56aadb3c
--- /dev/null
+++ b/tests/tcg/multiarch/prot-none.c
@@ -0,0 +1,40 @@
+/*
+ * Test that GDB can access PROT_NONE pages.
+ *
+ * SPDX-License-Identifier: GPL-2.0-or-later
+ */
+#include <assert.h>
+#include <stdlib.h>
+#include <string.h>
+#include <sys/mman.h>
+#include <unistd.h>
+
+void break_here(void *q)
+{
+}
+
+int main(void)
+{
+    long pagesize = sysconf(_SC_PAGESIZE);
+    void *p, *q;
+    int err;
+
+    p = mmap(NULL, pagesize * 2, PROT_READ | PROT_WRITE,
+             MAP_PRIVATE | MAP_ANONYMOUS, -1, 0);
+    assert(p != MAP_FAILED);
+    q = p + pagesize - 1;
+    strcpy(q, "42");
+
+    err = mprotect(p, pagesize * 2, PROT_NONE);
+    assert(err == 0);
+
+    break_here(q);
+
+    err = mprotect(p, pagesize * 2, PROT_READ);
+    assert(err == 0);
+    if (getenv("PROT_NONE_PY")) {
+        assert(strcmp(q, "24") == 0);
+    }
+
+    return EXIT_SUCCESS;
+}
diff --git a/tests/tcg/multiarch/Makefile.target b/tests/tcg/multiarch/Makefile.target
index d31ba8d6ae..315a2e1358 100644
--- a/tests/tcg/multiarch/Makefile.target
+++ b/tests/tcg/multiarch/Makefile.target
@@ -101,13 +101,20 @@ run-gdbstub-registers: sha512
 		--bin $< --test $(MULTIARCH_SRC)/gdbstub/registers.py, \
 	checking register enumeration)
 
+run-gdbstub-prot-none: prot-none
+	$(call run-test, $@, env PROT_NONE_PY=1 $(GDB_SCRIPT) \
+		--gdb $(GDB) \
+		--qemu $(QEMU) --qargs "$(QEMU_OPTS)" \
+		--bin $< --test $(MULTIARCH_SRC)/gdbstub/prot-none.py, \
+	accessing PROT_NONE memory)
+
 else
 run-gdbstub-%:
 	$(call skip-test, "gdbstub test $*", "need working gdb with $(patsubst -%,,$(TARGET_NAME)) support")
 endif
 EXTRA_RUNS += run-gdbstub-sha1 run-gdbstub-qxfer-auxv-read \
 	      run-gdbstub-proc-mappings run-gdbstub-thread-breakpoint \
-	      run-gdbstub-registers
+	      run-gdbstub-registers run-gdbstub-prot-none
 
 # ARM Compatible Semi Hosting Tests
 #
diff --git a/tests/tcg/multiarch/gdbstub/prot-none.py b/tests/tcg/multiarch/gdbstub/prot-none.py
new file mode 100644
index 0000000000..f1f1dd82cb
--- /dev/null
+++ b/tests/tcg/multiarch/gdbstub/prot-none.py
@@ -0,0 +1,22 @@
+"""Test that GDB can access PROT_NONE pages.
+
+This runs as a sourced script (via -x, via run-test.py).
+
+SPDX-License-Identifier: GPL-2.0-or-later
+"""
+from test_gdbstub import main, report
+
+
+def run_test():
+    """Run through the tests one by one"""
+    gdb.Breakpoint("break_here")
+    gdb.execute("continue")
+    val = gdb.parse_and_eval("*(char[2] *)q").string()
+    report(val == "42", "{} == 42".format(val))
+    gdb.execute("set *(char[3] *)q = \"24\"")
+    gdb.execute("continue")
+    exitcode = int(gdb.parse_and_eval("$_exitcode"))
+    report(exitcode == 0, "{} == 0".format(exitcode))
+
+
+main(run_test)
-- 
2.34.1


