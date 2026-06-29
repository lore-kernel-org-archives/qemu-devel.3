Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D00C2C43458
	for <qemu-devel@archiver.kernel.org>; Mon, 29 Jun 2026 12:02:11 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1weAgD-0007EL-Np; Mon, 29 Jun 2026 08:01:37 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1weAfl-0006xg-AQ
 for qemu-devel@nongnu.org; Mon, 29 Jun 2026 08:01:10 -0400
Received: from mail-wr1-x42a.google.com ([2a00:1450:4864:20::42a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1weAfh-0007Sw-N6
 for qemu-devel@nongnu.org; Mon, 29 Jun 2026 08:01:09 -0400
Received: by mail-wr1-x42a.google.com with SMTP id
 ffacd0b85a97d-47248615e4dso1505097f8f.2
 for <qemu-devel@nongnu.org>; Mon, 29 Jun 2026 05:01:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1782734464; x=1783339264; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=lN37vHzTAwH+qCtzUf9JtjJBEPMP/QIkkrtzMW9C0cA=;
 b=Ftjj8NTXT7i2R+9FoFysqb/hnROVWDbUmSFdKcaUALBTRQto26fXIpHhllHKqY4/6j
 biMqybKFtfxJh5ZqEIcFMOgwX8qmKrsdR0re99y2RBHhND3wqRPiSvaotHsOOXd7PcGJ
 DbF8VaENGN+Ed/8GwUDJXICmEU2BF/GDZFbLM8I66f0UxxQyps0DQC1gBXAh6mIYrtxE
 OrbWYhhQqd28CHXmmuYjeX8RbtIOD8I4AekYKyWQN9svi2DujvH2bBLQlWnpSe0Matfr
 ZnONwTrb7QAcdFByTvqds2+wN1QoKmhZGeNY1jKmK4LbnaqM3FGSlY9LOTu04aBF9cFx
 nS0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1782734464; x=1783339264;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=lN37vHzTAwH+qCtzUf9JtjJBEPMP/QIkkrtzMW9C0cA=;
 b=cYNVbOZkDS/BjWMaT27vG4sJCUATgQGNuLARk/PgyYkFicSzT8XmUMPTKbapEopVY6
 pW/QOmVaJsfWpXIGp8ZzTmyqY9zO/ARvCb2Mst34GX3ja+xogvv+6dUNp7U8cXe7J+6Z
 Z3k/tezkkjnJkq6UcLFXy3Mj0pGdryJ2bvTAbSefMF7jvZnnSJ4p2HWeyUHXO9QAxdnV
 Jc3qiJssz5jon0rEidQ9QDmQ3W08IklOZbCr/COUkMrp5h6eLQlfp3Z0kpmIdoLp50/U
 z6HCj9dBL6LYrnrALktg4cNfqXQ9nMo/sQKHjfhVOcQ2r1AsHErdGvo59VL29zg2KFS9
 DVHA==
X-Gm-Message-State: AOJu0Yx9GU4L6Nwh8C6wJE+igrK5dgmqQ00DR0WgaQ+LtAUaDd0+yWQi
 mY3UN2ZYRCYYmhN5aXLQoHP3KhS7N9T0ZD3JPHh6XXm7sRgKtl2Qbq9x7yi0MnOcVnOyQUXJFLo
 rf1AR
X-Gm-Gg: AfdE7cn4rK0JVCfQDOxaTw8BmggszAHNECtD+xX8fadkxqRNjMuix/XvLq7W5g348V+
 rwWdkRLdEeU1GQwop6re8tUbnoOo0pTT/Qb0RcYOCTuEgbzv6oE+Y81lo338oQeyN1D+tLXC6B0
 bT+rigTDdKGMiHHotBPlR3dR5NfE2A7LIP9G27dNAyhz+u0zBb3Hd8IigZhoWPRL5L8ATOIA9vv
 bQ1NnHLbKsjEBJcpiS1fgSkRF1byflbsCuWDBDRxbuuqcj/kuIWd295wYbW7bZd4yMoDJhMgW+L
 let6dGVgMAQGdkh2RNwWBEdNa1a0ow8P8tFuy0ibZ0+imNZkPvlsP6RZUhPZgBH3pXn75NZIR2v
 uWD8Ze3RXjbhT04e5/Y3aGiGLCOfF9P/Nx+1FSKgQWp5GTZUF4udmwp4zFpt2kJpNmsBBilsWnw
 6h5FszjX956hAx4vRDO1PYY4XDoABqiXJl6w5qCOkccUJ+p5arHMSciAFlov6HaD3QejDxNMFng
 n5aF62UR2x0wBfyoglAPA==
X-Received: by 2002:a05:6000:1866:b0:470:2fb1:3dbc with SMTP id
 ffacd0b85a97d-4702fb13e3cmr14121796f8f.35.1782734463916; 
 Mon, 29 Jun 2026 05:01:03 -0700 (PDT)
Received: from lanath.. (wildly.archaic.org.uk. [81.2.115.145])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-473dddcb295sm8753061f8f.35.2026.06.29.05.01.03
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 29 Jun 2026 05:01:03 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 29/54] tests/tcg/aarch64/system: Alternative boot object for
 exception logging
Date: Mon, 29 Jun 2026 13:00:07 +0100
Message-ID: <20260629120032.1645265-30-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260629120032.1645265-1-peter.maydell@linaro.org>
References: <20260629120032.1645265-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42a;
 envelope-from=peter.maydell@linaro.org; helo=mail-wr1-x42a.google.com
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

From: Jim MacArthur <jim.macarthur@linaro.org>

This allows us to record information about exceptions using a small
area of memory, and continue with the test so it can verify exceptions
have been taken where expected.

LOGGING_VECTOR_TABLE is added to switch this on, and vec_logging_boot.o
is built from boot.S with this flag. Since boot.o is created for multiple
test targets, we have to build a separate object and selectively link this
new vec_logging_boot.o into particular test binaries.

Signed-off-by: Jim MacArthur <jim.macarthur@linaro.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Message-id: 20260618-jmac-gpc3b-v3-5-353e546067e7@linaro.org
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 tests/tcg/aarch64/Makefile.softmmu-target | 11 ++--
 tests/tcg/aarch64/system/boot.S           | 65 +++++++++++++++++++++++
 tests/tcg/aarch64/system/boot.h           | 14 +++++
 3 files changed, 86 insertions(+), 4 deletions(-)
 create mode 100644 tests/tcg/aarch64/system/boot.h

diff --git a/tests/tcg/aarch64/Makefile.softmmu-target b/tests/tcg/aarch64/Makefile.softmmu-target
index f7a7d2b800..c353b7f8d6 100644
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
 
+vector_log_boot.o: $(CRT_PATH)/boot.S
+	$(CC) $(CFLAGS) $(EXTRA_CFLAGS) -DLOGGING_VECTOR_TABLE -x assembler-with-cpp -Wa,--noexecstack -c $< -o $@
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
index 8bfa4e4efc..c6e5ad889b 100644
--- a/tests/tcg/aarch64/system/boot.S
+++ b/tests/tcg/aarch64/system/boot.S
@@ -60,6 +60,40 @@ curr_sp0_irq:
 curr_sp0_fiq:
 curr_sp0_serror:
 curr_spx_sync:
+#ifdef LOGGING_VECTOR_TABLE
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
@@ -404,6 +439,36 @@ ttb_stage2:
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
+#ifdef LOGGING_VECTOR_TABLE
+	.align 12
+	.global exception_fault_address
+	.type exception_fault_address, @object
+	.size exception_fault_address, 8
+	.global exception_type_code
+	.type exception_type_code, @object
+	.size exception_type_code, 8
+	/*
+         * These fields record details of the last exception, if
+         * LOGGING_VECTOR_TABLE is defined.
+         */
+exception_log:
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


