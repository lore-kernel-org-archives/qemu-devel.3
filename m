Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2CDDFCD4F54
	for <qemu-devel@archiver.kernel.org>; Thu, 28 May 2026 15:36:00 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wSclM-0002Kw-2Z; Thu, 28 May 2026 11:35:12 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jim.macarthur@linaro.org>)
 id 1wSclE-0002HC-EE
 for qemu-devel@nongnu.org; Thu, 28 May 2026 11:35:05 -0400
Received: from mail-wm1-x336.google.com ([2a00:1450:4864:20::336])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <jim.macarthur@linaro.org>)
 id 1wScl8-0007br-Al
 for qemu-devel@nongnu.org; Thu, 28 May 2026 11:35:03 -0400
Received: by mail-wm1-x336.google.com with SMTP id
 5b1f17b1804b1-4891e5b9c1fso112727645e9.2
 for <qemu-devel@nongnu.org>; Thu, 28 May 2026 08:34:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1779982497; x=1780587297; darn=nongnu.org;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=A3ZjY9XAHXF5+tqD9XXR8Q92fc9OY13ALUDW4tvh2xE=;
 b=TRP3SvtmEtRIHv7ExCvkyD+0PjNp4bRtrMMT4l6FuIU05d4ZCJnLOwCQF5D3TAsRJR
 s17DkYrpId6fVQc9L+9A72nOV4p9SpsNOLqKdi0rsPxYL7VRm6LsAo52ptJiqDAFVrIB
 OevFGIp+5kqAElqMmcM0VKe3JFKM1y8Tdvu1ksD5YjInyeTyWBt7mr8Gc30/8ZJqeZdZ
 J7VBiQS5bG+6PiARTQ+5uBPPu7fEdRKbTeQVnkYx2769oCtLh6RyxELm2YIzvUo0UBU0
 mvcV32nEn96//gyTQbRe9xjaw6jRIrNMdWlVoAd676McB+l/4I8UX0ad/XPVteqWtcFp
 MmPQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1779982497; x=1780587297;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=A3ZjY9XAHXF5+tqD9XXR8Q92fc9OY13ALUDW4tvh2xE=;
 b=gsdmc33+qh9O7wwhEY8RmhB6oynkVuV/D0pto6j4fH4I3d8IPGkcu+kUWN1/tHevRI
 nfHDuCv0kgcWyPnY6jw7hCp0kP6Fa91RlP5aRBNXmmmGrOdP7+Yx6MLw517b0zynesxv
 hH1sKAquerlL26scQdIm2+JTYYyU524yxwj+wyWod1tuSIkKv82s4N92gx016TsLivo6
 q/0l7s4Yz37klhjLviuTZyr0/D7JPVKDAFbiok1PCXNpTt13AyMTDdeGc3Hn1KdZIhOT
 eof6IH5EXL/LNNcw6NH3kiZnGp2D7QNSpRN++eCB1MNgw/gnhLSnlhy2UlZUwviewYkJ
 SRnQ==
X-Gm-Message-State: AOJu0YweYJgUQQAnUYC+i1ZaSSMYtleCIIO3OxUHprvcYpSi4x0KrxsN
 jqMI18TRmetpT2j/Ix3eCa8jINzf4ND9cWT8cS6ItWQ32v870rp2RKBCb/lmtiSh2BWSPFHLCW6
 DhYG4
X-Gm-Gg: Acq92OErp75VUON9htOsyKoS7dJb2a8rcLAsv+udV4TBk1CLtbDwq+ck2P462nhp61m
 UF0fPSLzsVxlY8JK0kWws68gDWOMcDHoqSb7MiZ0ED2GKbYqpIgPvbeBFQ9jEVB4Oyj4PBcKTyB
 YTiUnh55/Ov7pT786bNXaKsCd+9KXIFKZ96FuQD8MCyNKmTlK3H/M5a2Dyta8XUNUeUTfWvIg9E
 Rx8h8XnQN5+DHMrpZAcgLePNKL1v9FD0/PfIQ1cXvAnNu1eH+8E7ZE5IYrX1W3YIASHR1nEyoub
 s6YMt3hCeutIyxkkANpwXshV63WEfZ1vIWiI4HFvIG0Wn/hz2hngIkLlhOocJklFFuZd6WIGxr1
 WJWrUcNTttceVX332bYwUE7jf2fhdabjvWiT7OV7ENWkgMzNKIqylxGurUxLBt8Mt4i2dzk1EPN
 0oNin/7JmpJ7Iutf7yF+k6mSDyNCeWvWXuvhA7ug==
X-Received: by 2002:a05:600c:8b84:b0:490:5466:8576 with SMTP id
 5b1f17b1804b1-490546689a7mr448742385e9.1.1779982496952; 
 Thu, 28 May 2026 08:34:56 -0700 (PDT)
Received: from [127.0.1.1] ([2a10:d582:31e:0:f5a7:372a:ab8b:3c01])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4909298d41bsm46514785e9.11.2026.05.28.08.34.56
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 28 May 2026 08:34:56 -0700 (PDT)
From: Jim MacArthur <jim.macarthur@linaro.org>
Date: Thu, 28 May 2026 16:34:39 +0100
Subject: [PATCH 4/5] tests/tcg/aarch64/system: Alternative boot object for
 exception logging
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260528-jmac-gpc3b-v1-4-d34c46c5069f@linaro.org>
References: <20260528-jmac-gpc3b-v1-0-d34c46c5069f@linaro.org>
In-Reply-To: <20260528-jmac-gpc3b-v1-0-d34c46c5069f@linaro.org>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>, qemu-arm@nongnu.org, 
 Jim MacArthur <jim.macarthur@linaro.org>
X-Mailer: b4 0.13.0
Received-SPF: pass client-ip=2a00:1450:4864:20::336;
 envelope-from=jim.macarthur@linaro.org; helo=mail-wm1-x336.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

This allows us to record information about exceptions using a small
area of memory, and continue with the test so it can verify exceptions
have been taken where expected.

ALT_VECTOR_TABLE is added to switch this on, and altboot.o
is built from boot.S with this flag. Since boot.o is created for multiple
test targets, we have to build a separate object and selectively link this
new altboot.o into particular test binaries.

Signed-off-by: Jim MacArthur <jim.macarthur@linaro.org>
---
 tests/tcg/aarch64/Makefile.softmmu-target | 11 ++++--
 tests/tcg/aarch64/system/boot.S           | 62 +++++++++++++++++++++++++++++++
 tests/tcg/aarch64/system/boot.h           | 14 +++++++
 3 files changed, 83 insertions(+), 4 deletions(-)

diff --git a/tests/tcg/aarch64/Makefile.softmmu-target b/tests/tcg/aarch64/Makefile.softmmu-target
index f7a7d2b800..47b32968fb 100644
--- a/tests/tcg/aarch64/Makefile.softmmu-target
+++ b/tests/tcg/aarch64/Makefile.softmmu-target
@@ -25,7 +25,7 @@ LDFLAGS=-Wl,-T$(LINK_SCRIPT)
 TESTS+=$(AARCH64_TESTS) $(MULTIARCH_TESTS)
 EXTRA_RUNS+=$(MULTIARCH_RUNS)
 CFLAGS+=-nostdlib -ggdb -O0 $(MINILIB_INC)
-LDFLAGS+=-static -nostdlib $(CRT_OBJS) $(MINILIB_OBJS) -lgcc
+LDFLAGS+=-static -nostdlib $(MINILIB_OBJS) -lgcc
 
 config-cc.mak: Makefile
 	$(quiet-@)( \
@@ -36,17 +36,20 @@ config-cc.mak: Makefile
 # building head blobs
 .PRECIOUS: $(CRT_OBJS)
 
+altboot.o: $(CRT_PATH)/boot.S
+	$(CC) $(CFLAGS) $(EXTRA_CFLAGS) -DALT_VECTOR_TABLE -x assembler-with-cpp -Wa,--noexecstack -c $< -o $@
+
 %.o: $(CRT_PATH)/%.S
 	$(CC) $(CFLAGS) $(EXTRA_CFLAGS) -x assembler-with-cpp -Wa,--noexecstack -c $< -o $@
 
 # Build and link the tests
 %: %.c $(LINK_SCRIPT) $(CRT_OBJS) $(MINILIB_OBJS)
-	$(CC) $(CFLAGS) $(EXTRA_CFLAGS) $< -o $@ $(LDFLAGS)
+	$(CC) $(CFLAGS) $(EXTRA_CFLAGS) $< -o $@ $(LDFLAGS) boot.o
 
 memory: CFLAGS+=-DCHECK_UNALIGNED=1
 
 memory-sve: memory.c $(LINK_SCRIPT) $(CRT_OBJS) $(MINILIB_OBJS)
-	$(CC) $(CFLAGS) $(EXTRA_CFLAGS) $< -o $@ $(LDFLAGS)
+	$(CC) $(CFLAGS) $(EXTRA_CFLAGS) $< -o $@ $(LDFLAGS) boot.o
 
 memory-sve: CFLAGS+=-DCHECK_UNALIGNED=1 -march=armv8.1-a+sve -O3
 
@@ -107,7 +110,7 @@ QEMU_MTE_ENABLED_MACHINE=-M virt,mte=on -cpu max -display none
 QEMU_OPTS_WITH_MTE_ON = $(QEMU_MTE_ENABLED_MACHINE) $(QEMU_BASE_ARGS) -kernel
 mte: CFLAGS+=-march=armv8.5-a+memtag
 mte: mte.S $(LINK_SCRIPT) $(CRT_OBJS) $(MINILIB_OBJS)
-	$(CC) $(CFLAGS) $(EXTRA_CFLAGS) $< -o $@ $(LDFLAGS)
+	$(CC) $(CFLAGS) $(EXTRA_CFLAGS) $< -o $@ $(LDFLAGS) boot.o
 
 run-mte: QEMU_OPTS=$(QEMU_OPTS_WITH_MTE_ON)
 run-mte: mte
diff --git a/tests/tcg/aarch64/system/boot.S b/tests/tcg/aarch64/system/boot.S
index 8bfa4e4efc..225ae76388 100644
--- a/tests/tcg/aarch64/system/boot.S
+++ b/tests/tcg/aarch64/system/boot.S
@@ -60,6 +60,40 @@ curr_sp0_irq:
 curr_sp0_fiq:
 curr_sp0_serror:
 curr_spx_sync:
+#ifdef ALT_VECTOR_TABLE
+	sub     sp, sp, #16
+	stp     x0, x1, [sp, #0]
+	mrs     x0, ESR_EL3
+	lsr 	x0, x0, #26
+	and 	x0, x0, #0x3f
+	cmp 	x0, #37
+	beq 	data_fault
+	cmp 	x0, #30
+	beq 	gpc_fault
+	b       generic_exception
+
+data_fault:
+	mrs     x0, FAR_EL3
+	adrp    x1, exception_log
+	str     x0, [x1]
+	ldr     x0, =0x1001
+	str     x0, [x1, #8]
+	b       skip_return
+gpc_fault:
+	mrs     x0, FAR_EL3
+	adrp    x1, exception_log
+	str     x0, [x1]
+	ldr     x0, =0x1002
+	str     x0, [x1, #8]
+	/* Fall through */
+skip_return:
+	mrs     x0, ELR_EL3
+	add     x0, x0, #4 /* Skip faulting instruction */
+	msr     ELR_EL3, x0
+	ldp     x0, x1, [sp, #0]
+	add     sp, sp, #16
+	eret
+#endif
 curr_spx_irq:
 curr_spx_fiq:
 curr_spx_serror:
@@ -71,6 +105,7 @@ lower_a32_sync:
 lower_a32_irq:
 lower_a32_fiq:
 lower_a32_serror:
+generic_exception:
 	adr	x1, .unexp_excp
 exit_msg:
 	mov	x0, SYS_WRITE0
@@ -404,6 +439,33 @@ ttb_stage2:
 	.space	4096, 0
 
 	.align	12
+	.global realms_gpt0
+	/* GPT stage 0 table */
+realms_gpt0:
+	.space 4096, 0
+	.align 17
+	.global realms_gpt1
+	/* GPT stage 1 table, initialised to all 0xFF (full access) */
+realms_gpt1:
+	.space 524288, 0xFF
+#ifdef ALT_VECTOR_TABLE
+	.align 8
+	.global exception_log
+	.global exception_fault_address
+	.global exception_type_code
+exception_log:
+	/*
+	 *These fields record details of the last exception, if ALT_VECTOR_TABLE
+	 * is defined.
+	 */
+exception_fault_address:
+	/* The contents of FAR_EL3 when an exception is taken. */
+	.space 8, 0
+exception_type_code:
+	/* A generic code indicating what type of exception occurred. */
+	.space 8, 0
+#endif
+	.align 12
 system_stack:
 	.space 4096, 0
 system_stack_end:
diff --git a/tests/tcg/aarch64/system/boot.h b/tests/tcg/aarch64/system/boot.h
new file mode 100644
index 0000000000..cb9ab6c1b9
--- /dev/null
+++ b/tests/tcg/aarch64/system/boot.h
@@ -0,0 +1,14 @@
+/* SPDX-License-Identifier: GPL-2.0-or-later */
+/*
+ *
+ *
+ * Copyright (c) 2026 Linaro Ltd
+ *
+ */
+
+
+/* Global variables exported in boot.S */
+extern volatile uint64_t exception_fault_address; /* Updated by ISR */
+extern volatile uint64_t exception_type_code; /* Updated by ISR */
+extern uint64_t realms_gpt0[];
+extern uint64_t realms_gpt1[];

-- 
2.43.0


