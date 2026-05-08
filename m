Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6D94CCD342F
	for <qemu-devel@archiver.kernel.org>; Fri,  8 May 2026 17:20:57 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wLOsJ-0005aH-PM; Fri, 08 May 2026 13:20:31 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jim.macarthur@linaro.org>)
 id 1wLOsD-0005ZE-5A
 for qemu-devel@nongnu.org; Fri, 08 May 2026 13:20:25 -0400
Received: from mail-wm1-x330.google.com ([2a00:1450:4864:20::330])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <jim.macarthur@linaro.org>)
 id 1wLOs8-0002Jb-9A
 for qemu-devel@nongnu.org; Fri, 08 May 2026 13:20:23 -0400
Received: by mail-wm1-x330.google.com with SMTP id
 5b1f17b1804b1-4896c22fcbaso20939895e9.0
 for <qemu-devel@nongnu.org>; Fri, 08 May 2026 10:20:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1778260817; x=1778865617; darn=nongnu.org;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=Sj83pQ1FvTLzFDLi7fANMNJBNhCHQLFTCbga/AJf4eU=;
 b=aM+5BZVBEqYyPl/ihSc5lYVWP2extbOg7PKAwNwuR+jZ4SqD1yob1qtey4CM3kypoi
 QE6WR+A9e+7yQI4q4jem03ww1eKXI0aC1rLMWO8i9G+O25z+gXZKFSsdX7ltyEd7+JjH
 bKXOEWtaBxiMRQAixEEs4w0Ri5jNcarZ4chbTesW3ayM92NoNnXryo7FUBsrAXS1u2LN
 Xx07nLCtObu8Ubt4gUEYVbqNNPrurY+ToDiWv5a3mKQ0+IKtDC2SPfihO9gL9ONXMVC2
 zPACwIGf9AMvRrQ5hIl1RBoTsWBDkIuln5q9CAeZOql4ZGwWnHdG8pGfSxVF6WABITRA
 QXUw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1778260817; x=1778865617;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=Sj83pQ1FvTLzFDLi7fANMNJBNhCHQLFTCbga/AJf4eU=;
 b=LNe+gpAzYKWbQNqkXMGPqgyl7J4mvDaY0mIFGGFzGQp138UnwXMVZzW6Va5K5aPJBV
 nCH8i51EhiBmBmZoyggxkcqYWQKKvPdgDT0QfyT8Sy1/9PkfB96xQnTngNYcxULHTbEx
 1st+pA1vCaLHX+rIOzHou90ksI2zo+GQfKRIc/uv2AxRb/JXuyZJmcZlfGdX/nVeIARP
 xUyPQbikPN38FvejO5iucd6ve4RQkieafLVmxny81Ypdhn7ijHzbI+vpjTbpPXDyH1kf
 EDNQeYgOFJ04XDT5rMGyTpRGOnP8WQUF40rpIOR5fr/gkwzQbRWDHPIhXka1V6wgS2j1
 6MmA==
X-Gm-Message-State: AOJu0YzYYNigkvDCNAsgeTbelyqMPpQ5NHqwQGwwqrV+/mbj5A4iVFMd
 apgKOz6wVSRUGPXh/YotEAK31+I8EgXNg4ix1HERsbBXf0iXp0zGJLrT7ImjrfaOduzQjh95yYI
 64WdO
X-Gm-Gg: AeBDievkSOBuyb0JuPdfxlzE9oGMWVmccEfGnubpHdlRx3wRDYquvmg+73tRV8pEDCC
 8rI8UQkb5y+jym5EsIHaAoKkz3TaeNghHMlrlNgEnSveYN+SzApPwC5Eban6hT0KYkB8LlsPYJR
 drkjJZezq35FP6JdD8FAvl2KLSG9GXguSdI2erDq/MJ2y3zbFriEx9Ik+EbB0l3VDpOutmOMQlf
 a7LA9Um9y/lTgpOHhf98u6QlsPKjWrrBo7GK8grBK0seZeqtkq40Bl/eO+HepOIJT/4O0V3zfFa
 +MMmdhMQCORHRF3joM8gJ0rD/2rT/MUwxs76ELAa09tTlyecPIWUHQaRKcTXuMWV4g255FixJDi
 LApJX2805upvTeM7EiZ6xLwY5H/RC47Xstui6v4RkIVj658VTGApE8nthbHj4fV5l80Nntm/4IP
 xnHHQNDecoKS+CNwJLvqZVToFSwGg=
X-Received: by 2002:a05:600c:3b17:b0:48a:568f:ae8a with SMTP id
 5b1f17b1804b1-48e51e1a870mr206847285e9.8.1778260816472; 
 Fri, 08 May 2026 10:20:16 -0700 (PDT)
Received: from [127.0.1.1] ([2a10:d582:31e:0:e47d:4cf0:1918:bbbd])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-48e6dd2c550sm9516965e9.3.2026.05.08.10.20.16
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 08 May 2026 10:20:16 -0700 (PDT)
From: Jim MacArthur <jim.macarthur@linaro.org>
Date: Fri, 08 May 2026 18:20:13 +0100
Subject: [PATCH 2/3] altvec.S: Alternative vector table for aarch64 testing
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260508-jmac-gpctest-v1-2-e57e42c87e1e@linaro.org>
References: <20260508-jmac-gpctest-v1-0-e57e42c87e1e@linaro.org>
In-Reply-To: <20260508-jmac-gpctest-v1-0-e57e42c87e1e@linaro.org>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>, qemu-arm@nongnu.org, 
 Jim MacArthur <jim.macarthur@linaro.org>
X-Mailer: b4 0.13.0
Received-SPF: pass client-ip=2a00:1450:4864:20::330;
 envelope-from=jim.macarthur@linaro.org; helo=mail-wm1-x330.google.com
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

Sets up a potential replacement vector table which will record
and ignore certain types of exception. Indicative values are
recorded in 'exception_log'. Most exception types are handled
in the same way as the table in boot.S.

Signed-off-by: Jim MacArthur <jim.macarthur@linaro.org>
---
 tests/tcg/aarch64/Makefile.softmmu-target |   2 +-
 tests/tcg/aarch64/system/altvec.S         | 129 ++++++++++++++++++++++++++++++
 2 files changed, 130 insertions(+), 1 deletion(-)

diff --git a/tests/tcg/aarch64/Makefile.softmmu-target b/tests/tcg/aarch64/Makefile.softmmu-target
index f7a7d2b800..60c65f4969 100644
--- a/tests/tcg/aarch64/Makefile.softmmu-target
+++ b/tests/tcg/aarch64/Makefile.softmmu-target
@@ -8,7 +8,7 @@ AARCH64_SYSTEM_SRC=$(AARCH64_SRC)/system
 VPATH+=$(AARCH64_SYSTEM_SRC)
 
 # These objects provide the basic boot code and helper functions for all tests
-CRT_OBJS=boot.o
+CRT_OBJS=boot.o altvec.o
 
 AARCH64_TEST_C_SRCS=$(wildcard $(AARCH64_SYSTEM_SRC)/*.c)
 AARCH64_TEST_S_SRCS=$(AARCH64_SYSTEM_SRC)/mte.S
diff --git a/tests/tcg/aarch64/system/altvec.S b/tests/tcg/aarch64/system/altvec.S
new file mode 100644
index 0000000000..079846b639
--- /dev/null
+++ b/tests/tcg/aarch64/system/altvec.S
@@ -0,0 +1,129 @@
+/* SPDX-License-Identifier: GPL-2.0-or-later */
+/*
+ * Alternative AArch64 vector table. Can replace the vector table
+ * in boot.S and record & ignore some exceptions in exception_log.
+ * Maintains the semihosting error print and exit for most
+ * exceptions.
+ *
+ * Copyright Linaro Ltd 2026
+ *
+ */
+
+#define semihosting_call hlt 0xf000
+#define SYS_WRITE0	0x04	/* string to debug channel */
+#define SYS_EXIT	0x18
+	.align	12
+
+	.macro	ventry	label
+	.align	7
+	b	\label
+	.endm
+
+	.global alt_vector_table
+alt_vector_table:
+	/* Current EL with SP0.	 */
+	ventry	curr_sp0_sync		/* Synchronous	*/
+	ventry	curr_sp0_irq		/* Irq/vIRQ  */
+	ventry	curr_sp0_fiq		/* Fiq/vFIQ  */
+	ventry	curr_sp0_serror		/* SError/VSError  */
+
+	/* Current EL with SPx.	 */
+	ventry	curr_spx_sync		/* Synchronous	*/
+	ventry	curr_spx_irq		/* IRQ/vIRQ  */
+	ventry	curr_spx_fiq		/* FIQ/vFIQ  */
+	ventry	curr_spx_serror		/* SError/VSError  */
+
+	/* Lower EL using AArch64.  */
+	ventry	lower_a64_sync		/* Synchronous	*/
+	ventry	lower_a64_irq		/* IRQ/vIRQ  */
+	ventry	lower_a64_fiq		/* FIQ/vFIQ  */
+	ventry	lower_a64_serror	/* SError/VSError  */
+
+	/* Lower EL using AArch32.  */
+	ventry	lower_a32_sync		/* Synchronous	*/
+	ventry	lower_a32_irq		/* IRQ/vIRQ  */
+	ventry	lower_a32_fiq		/* FIQ/vFIQ  */
+	ventry	lower_a32_serror	/* SError/VSError  */
+
+	.text
+	.align 4
+
+curr_spx_sync:
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
+curr_sp0_sync:
+curr_sp0_irq:
+curr_sp0_fiq:
+curr_sp0_serror:
+curr_spx_irq:
+curr_spx_fiq:
+curr_spx_serror:
+lower_a64_sync:
+lower_a64_irq:
+lower_a64_fiq:
+lower_a64_serror:
+lower_a32_sync:
+lower_a32_irq:
+lower_a32_fiq:
+lower_a32_serror:
+generic_exception:
+	adr	x1, .unexp_excp
+exit_msg:
+	mov	x0, SYS_WRITE0
+	semihosting_call
+	mov	x0, 1 /* EXIT_FAILURE */
+	bl 	_exit
+	/* never returns */
+print_debug_msg:
+	mov	x0, SYS_WRITE0
+	semihosting_call
+	ret
+_exit:
+	mov    x1, x0
+	ldr    x0, =0x20026 /* ADP_Stopped_ApplicationExit */
+	stp    x0, x1, [sp, #-16]!
+	mov    x1, sp
+	mov    x0, SYS_EXIT
+	semihosting_call
+
+
+	.section .rodata
+.unexp_excp:
+	.string "Unexpected exception (via alternative handler).\n"
+
+	.data
+	.align 8
+	.global exception_log
+exception_log:
+	.space 128, 0
+

-- 
2.43.0


