Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 04B4DE8305C
	for <qemu-devel@archiver.kernel.org>; Tue,  3 Feb 2026 07:40:01 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vnB0n-0005RU-G4; Tue, 03 Feb 2026 02:39:49 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <razvanghiorghe16@gmail.com>)
 id 1vnB0m-0005RL-8c
 for qemu-devel@nongnu.org; Tue, 03 Feb 2026 02:39:48 -0500
Received: from mail-wr1-x432.google.com ([2a00:1450:4864:20::432])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <razvanghiorghe16@gmail.com>)
 id 1vnB0i-0001gM-5T
 for qemu-devel@nongnu.org; Tue, 03 Feb 2026 02:39:45 -0500
Received: by mail-wr1-x432.google.com with SMTP id
 ffacd0b85a97d-432d2c7a8b9so4527355f8f.2
 for <qemu-devel@nongnu.org>; Mon, 02 Feb 2026 23:39:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1770104382; x=1770709182; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=sI4FkrE9WReztiTMDMz+fi7beSE+y3Xc9/AefNJ755w=;
 b=B3+Zd6icZ/6AUbHmQ7oI72UAYZyh6FBrwJT40GXmxuGDyxKko/2GziCiRRLELf3Tys
 4ifWE6NJp9kmYnEcy20N48Gk0QQKLBwlzTaMd/4k7vvircBqPBrnIFxwybIGR+TA/WT1
 jd3nH/VuHcGwXTKQH88bZuv8FgvXLq+SmLB0aSQWhxTy4tAL2sJOfyp+1uGjUWtjf8Tu
 aV5yhqnvSHUafo/i5BedGCVGdeLGGw4DBqdXIDtBaMS6A026VZLowF46oSpMYIJIxW99
 nNEoZwNNw/Yu1VwDc8rcpJPDCD7p2NGS3tndPGE/tISY3RhmeuiN1OJSwVIV8An4jZ96
 0Kew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1770104382; x=1770709182;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=sI4FkrE9WReztiTMDMz+fi7beSE+y3Xc9/AefNJ755w=;
 b=KxljqXeH7P8Ba9dG91vu0U/O+0/Fw5yYBFVc719J4Pw93XLOyJBIi2XcagZzNGxhdN
 7iItvEfcwXvVELhWsfvh0HRSjKinV1ttGXKey3gaHSq8zky3Qzf+qooy24wVMONcDGQm
 9tv2lE0xVUk7HgFDdPpUqrvaLXM+2NNS0L9dwAUm2X+L1eEhbZlLSA1z0CefWBRnWDW5
 Vdko5gPdRAGCEgeYC/whXSJImTyB7BTxwHQude1dBWtiQ2JE/jENLvLM3re2IWic5R7G
 daa1Vs/dg8aWhHFRnY+GypAI+cFLmnbYZRQL16M0LqYRoTCkIj/KlGHKkMyjMBR5Dm6Z
 Au/g==
X-Gm-Message-State: AOJu0Yxwj3gHeu2dL9IL6NaUU/prWpLi93C+InByjalcNzhhdhblbuiZ
 7cK7w+y932Z5L6esxMda/a8oWFsuOC5wraMBCHoUMX/AstNwr2SDFsKZpXZ5Ig==
X-Gm-Gg: AZuq6aKi9LhKU8OOL4p5o6ALuGSKbUG0zHbT1ZiRkS5ZZTQiZXMpKrqX74rIY3Q4vwd
 Wa2Rje9rMX+C4k1iOzFhDRP+PE9DcbUl+SgspJ60tZZ99df2dqulU2XxoeQ4AmrH2Qyn5OD8+A8
 gC1aDgUPgG3XjYQ5H0Ks6qaQdqQhbXK/at8n9KCKtxti7Hx7VXnVEMZluLd8MarXRmz+RT2fwRK
 pNfw8MId5GRU3EbWuVmRvjRbZuGZOjFMHJL47Rclix7upDxOlTzQ+kgdu8CnSsVLT7YMpA3MNUm
 ROIu6DWTxkPnW1CEuC86UskkvqvVS2O2ckWnCTOtzcWDFn2BCql0Q/QDzgspBVSeuggfAS9DgDi
 RuosQuypUzL0+Si1oU0OAbmy8aw22UW8pYimIPWTAUt5SCNpoY4qf4sjzxLn6YzW6LY5DKfhtmG
 HrgkOujROU7LDorDcXvLXBk68pnk8/
X-Received: by 2002:a05:6000:186a:b0:435:e060:8071 with SMTP id
 ffacd0b85a97d-435f3a7a4dbmr20651698f8f.16.1770104381963; 
 Mon, 02 Feb 2026 23:39:41 -0800 (PST)
Received: from localhost.localdomain ([92.180.8.65])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-436143d81desm1684077f8f.42.2026.02.02.23.39.41
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 02 Feb 2026 23:39:41 -0800 (PST)
From: Razvan Ghiorghe <razvanghiorghe16@gmail.com>
To: qemu-devel@nongnu.org
Cc: laurent@vivier.eu, richard.henderson@linaro.org,
 Razvan Ghiorghe <razvanghiorghe16@gmail.com>
Subject: [PATCH] tests/tcg/x86_64: Add tests for zero_bss() with RX PT_LOAD
 segments
Date: Tue,  3 Feb 2026 09:36:56 +0200
Message-ID: <20260203073740.19913-2-razvanghiorghe16@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260203073740.19913-1-razvanghiorghe16@gmail.com>
References: <20260203073740.19913-1-razvanghiorghe16@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::432;
 envelope-from=razvanghiorghe16@gmail.com; helo=mail-wr1-x432.google.com
X-Spam_score_int: -17
X-Spam_score: -1.8
X-Spam_bar: -
X-Spam_report: (-1.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FREEMAIL_ENVFROM_END_DIGIT=0.25, FREEMAIL_FROM=0.001,
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

Add 2 test cases to validate the fix for issue #3179, where the linux-user
ELF Loader incorrectly rejected binaries with .bss sections in R_X PT_LOAD
segments.

test-zerobss-1.c: defines a minimal _start routine that exists immediately
without accessing the .bss region. Although a .bss region is present in ELF,
it is never referenced at runtime. This test validates that the loader can
correctly handle and zero the fractional .bss region in an R_X segment
without triggering permission violations.

test-zerobss-2.c: explicitly reads from multiple .bss variables to verify
they are zeroed properly. If the .bss was correctly zeroed, the exit code will
be 0.

rx_anonymous_bss.ld: tests require a custom linker script to create the specific ELF
layout that triggers the bug. The linker script:
- creates a single PT_LOAD segment with FLAGS(5) = PF_R | PF_X (read-execute)
- places .text and .bss in this same segment
- sets .bss to ALIGN(1) to force it into the tail of the R_X segment
- results in p_filesz < p_memsz, where the gap is anonymous .bss

Expected behavior:
- Without the fix: Both tests fail with "PT_LOAD with non-writable bss"
- With the fix: Both tests pass (exit code 0)

Signed-off-by: Razvan Ghiorghe <razvanghiorghe16@gmail.com>
---
 tests/tcg/x86_64/Makefile.target     | 15 ++++++++++++
 tests/tcg/x86_64/rx_anonymous_bss.ld | 27 +++++++++++++++++++++
 tests/tcg/x86_64/test-zerobss-1.c    | 20 ++++++++++++++++
 tests/tcg/x86_64/test-zerobss-2.c    | 36 ++++++++++++++++++++++++++++
 4 files changed, 98 insertions(+)
 create mode 100644 tests/tcg/x86_64/rx_anonymous_bss.ld
 create mode 100644 tests/tcg/x86_64/test-zerobss-1.c
 create mode 100644 tests/tcg/x86_64/test-zerobss-2.c

diff --git a/tests/tcg/x86_64/Makefile.target b/tests/tcg/x86_64/Makefile.target
index be20fc64e8..ca375a4318 100644
--- a/tests/tcg/x86_64/Makefile.target
+++ b/tests/tcg/x86_64/Makefile.target
@@ -19,6 +19,9 @@ X86_64_TESTS += test-1648
 X86_64_TESTS += test-2175
 X86_64_TESTS += cross-modifying-code
 X86_64_TESTS += fma
+
+X86_64_TESTS +=  test-zerobss-1
+X86_64_TESTS +=  test-zerobss-2
 TESTS=$(MULTIARCH_TESTS) $(X86_64_TESTS) test-x86_64
 else
 TESTS=$(MULTIARCH_TESTS)
@@ -36,5 +39,17 @@ test-x86_64: LDFLAGS+=-lm -lc
 test-x86_64: test-i386.c test-i386.h test-i386-shift.h test-i386-muldiv.h
 	$(CC) $(CFLAGS) $< -o $@ $(LDFLAGS)
 
+test-zerobss-1: $(SRC_PATH)/tests/tcg/x86_64/test-zerobss-1.c
+	$(CC) -nostdlib -static -fno-stack-protector -fno-pie -no-pie \
+	     -Wl,-T,$(SRC_PATH)/tests/tcg/x86_64/rx_anonymous_bss.ld \
+	     -Wl,--build-id=none \
+	     $< -o $@
+
+test-zerobss-2: $(SRC_PATH)/tests/tcg/x86_64/test-zerobss-2.c
+	$(CC) -nostdlib -static -fno-stack-protector -fno-pie -no-pie \
+	     -Wl,-T,$(SRC_PATH)/tests/tcg/x86_64/rx_anonymous_bss.ld \
+	     -Wl,--build-id=none \
+	     $< -o $@
+
 %: $(SRC_PATH)/tests/tcg/x86_64/%.c
 	$(CC) $(CFLAGS) $< -o $@ $(LDFLAGS)
diff --git a/tests/tcg/x86_64/rx_anonymous_bss.ld b/tests/tcg/x86_64/rx_anonymous_bss.ld
new file mode 100644
index 0000000000..3ec72fde6c
--- /dev/null
+++ b/tests/tcg/x86_64/rx_anonymous_bss.ld
@@ -0,0 +1,27 @@
+/* Linker script to create RX PT_LOAD with anonymous .bss tail
+ * SPDX-License-Identifier: GPL-2.0-or-later
+ */
+PHDRS
+{
+    text PT_LOAD FLAGS(5);
+}
+SECTIONS
+{
+    . = 0x400000;
+    .text : {
+        *(.text .text.*)
+        _etext = .;
+    } :text
+    .bss ALIGN(1) : {
+        _bss_start = .;
+        *(.bss .bss.* COMMON)
+        _bss_end = .;
+    } :text
+    /DISCARD/ : {
+        *(.note.GNU-stack)
+        *(.note.gnu.property)
+        *(.comment)
+        *(.eh_frame)
+    }
+}
+ENTRY(_start)
diff --git a/tests/tcg/x86_64/test-zerobss-1.c b/tests/tcg/x86_64/test-zerobss-1.c
new file mode 100644
index 0000000000..809ea3cb52
--- /dev/null
+++ b/tests/tcg/x86_64/test-zerobss-1.c
@@ -0,0 +1,20 @@
+ /*
+  * .bss region exists but unused
+  * SPDX-License-Identifier: GPL-2.0-or-later
+  */
+int x;
+void _start(void)
+{
+    /*
+     * Exit immediately & never touched x
+     */
+    __asm__ volatile(
+        "mov $60, %%rax\n"
+        "xor %%rdi, %%rdi\n"
+        "syscall\n"
+        : /* no out */
+        : /* no in */
+        : "rax", "rdi"
+    );
+    __builtin_unreachable();
+}
diff --git a/tests/tcg/x86_64/test-zerobss-2.c b/tests/tcg/x86_64/test-zerobss-2.c
new file mode 100644
index 0000000000..1f4f0d9704
--- /dev/null
+++ b/tests/tcg/x86_64/test-zerobss-2.c
@@ -0,0 +1,36 @@
+/*
+ * Test case for zero_bss() with anonymous BSS in RX PT_LOAD
+ *
+ * This binary has .bss in the same PT_LOAD as .text (R_X permissions),
+ * but the BSS is anonymous (beyond p_filesz), not file-backed.
+ * Actual behavior:
+ * old code: Fails with "PT_LOAD with non-writable bss"
+ * new code: Succeeds, zeros BSS, exits with code 0
+ * SPDX-License-Identifier: GPL-2.0-or-later
+ */
+
+/* These will be included in .bss (uninitialized anonymous memory) */
+int bss_value;
+int bss_array[64];
+
+void _start(void)
+{
+    int sum = bss_value;
+    int i;
+
+    for (i = 0; i < 64; i++) {
+        sum += bss_array[i];
+    }
+    /* If BSS was properly zeroed, sum should be 0 */
+    /* Exit with sum as exit code */
+    __asm__ volatile (
+        "movl %0, %%edi\n\t"
+        "movl $60, %%eax\n\t"
+        "syscall\n\t"
+        : /* no out*/
+        : "r" (sum)
+        : "rdi", "rax"
+    );
+
+    __builtin_unreachable();
+}
-- 
2.43.0


