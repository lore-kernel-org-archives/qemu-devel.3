Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 079A0C3ABAC
	for <qemu-devel@archiver.kernel.org>; Fri,  2 May 2025 08:29:13 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uAllJ-0002fW-0V; Fri, 02 May 2025 04:28:49 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <manos.pitsidianakis@linaro.org>)
 id 1uAllH-0002f3-4m
 for qemu-devel@nongnu.org; Fri, 02 May 2025 04:28:47 -0400
Received: from mail-wr1-x434.google.com ([2a00:1450:4864:20::434])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <manos.pitsidianakis@linaro.org>)
 id 1uAllE-0001qW-Ej
 for qemu-devel@nongnu.org; Fri, 02 May 2025 04:28:46 -0400
Received: by mail-wr1-x434.google.com with SMTP id
 ffacd0b85a97d-39ac56756f6so1754067f8f.2
 for <qemu-devel@nongnu.org>; Fri, 02 May 2025 01:28:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1746174522; x=1746779322; darn=nongnu.org;
 h=mime-version:message-id:in-reply-to:references:user-agent:subject
 :cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=X3dwH3ri7jWkmtpB6vmUtFtMZzeYOWWAci9OZKMkGyw=;
 b=REjV7CSBFFRk6QlazeoBtPHZUAVrZKMG85wwOn+RfDxqrGLbvtiovJVkM/YZhO2K4g
 G6X9uOKYIjThDTcncBmjbIyjz3wSrk4lfqYmfRHmiRQ6Px94Iinrk50kakhwbgIg3T87
 lgMtquomKWaV3NzCpVDNkfRLiKodV+rWhLMQKl7ZqR18CT1cfKHGFgl+XmIm01zp2Dbf
 tUozBPWtvR6iMPHAKUa96pJif1kCi0oz1Mktnrlqb70tdJbzWgYgAmNYj6GUyNGUXFdb
 E2nMBAxbV0N9GvjilNBwvAolvmRuuzDUPeF8Ka12RpGOrQPs0hsYWsDux9J1J6nc8EFJ
 XBrQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1746174522; x=1746779322;
 h=mime-version:message-id:in-reply-to:references:user-agent:subject
 :cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=X3dwH3ri7jWkmtpB6vmUtFtMZzeYOWWAci9OZKMkGyw=;
 b=XZMuOsw9ICKHNuMgiv6UNJni5BBZquZuGm1ghttllG/jcXdSJvjMS1ZxMUKH3qtFXG
 e8GC0hVX378YZNgCU4sleA6mRSkNV5g/VJeY9u2KPL1FDH87z+shs/p+thT5WouJHebq
 LARA7Ty4fmxmsIk/dtRp/VOQt3UEOg4l/+s7W3YNbhPuGb+Qha8+mbIPL6IBM+NMO/3j
 30muEuKCe1jhICZbr3FmP3ItbnwRRGm0cSuNQb5xQ/dI46S793y33rKLKzHT3Zg2MMmy
 x4NiGwuosJXT01Psr3qljYMFat/GwsOCaqYdgYnKXOHMVazSxLvaHiK013iPCR1xOouL
 TUKg==
X-Gm-Message-State: AOJu0YwPK3H9loUXx85A9kQr7/m6c8EEqx0PwHSiG4yNdkAVC/vXOOV+
 nMcop4bV62Sc9j5HlGDYc62LLwR0dvIjRgI9JTTOeENNTQBsmlpmoBUGLInyKQu/46r45aTqHiQ
 S0Rc=
X-Gm-Gg: ASbGncseSNqSybNyAJXSHZrqonk+yftKqcPJ8SDMn5cgyc3rUqVgG/QRMqyN7jzNcbi
 kR+ad2JBKGAX7Efeeuy+guqJvDnExenMJjGwTP5KK1btbcRnC/HTCG0+aVuOvvWwpK1LXit3vSv
 qdqwSjoI2j8LMln4ZzbVyHa/JVzHfsYJ9t/r9d4678iS+n4uWkSXfhtUhUBCFx3RKFnjhhqMZ35
 FTbqNAvyXqGtKc0xdnMo3oWMHqVB34z38MavZwCt8JqlyjFJhBa2HCnbZ+0Ze5p/9yz14Tz9N5d
 JZGfC4+gFxDiWCWVYoQYsOOw8vDumR+P6ws8yweMpIYFcgZe4RYvr09fg/BInEsj5EJgzLLl7e0
 iVIoR/ehs2B+mag==
X-Google-Smtp-Source: AGHT+IFSQWXEYhV+a9Znm66QhWbnMrZV8ZHjGcxy9c2i9Go2kWusrXqGvoZw4gMDgts4O/S6LmujTA==
X-Received: by 2002:a5d:47a6:0:b0:391:3049:d58d with SMTP id
 ffacd0b85a97d-3a099a862cdmr1179981f8f.0.1746174522286; 
 Fri, 02 May 2025 01:28:42 -0700 (PDT)
Received: from meli-email.org (adsl-194.109.242.94.tellas.gr. [109.242.94.194])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-441b89d15dasm36546275e9.16.2025.05.02.01.28.41
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 02 May 2025 01:28:41 -0700 (PDT)
Date: Fri, 02 May 2025 10:54:15 +0300
From: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>
To: qemu-devel@nongnu.org, Alex Benn=?UTF-8?B?w6k=?=e <alex.bennee@linaro.org>
Cc: Thomas Huth <thuth@redhat.com>, Alexandre Iooss <erdnaxe@crans.org>,
 Michael S. Tsirkin <mst@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Alex Benn=?UTF-8?B?w6k=?=e <alex.bennee@linaro.org>,
 David Hildenbrand <david@redhat.com>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>, qemu-arm@nongnu.org,
 Philippe Mathieu-Daud=?UTF-8?B?w6kg?=<philmd@linaro.org>,
 Peter Xu <peterx@redhat.com>, Peter Maydell <peter.maydell@linaro.org>,
 Mahmoud Mandour <ma.mandourr@gmail.com>,
 Julian Armistead <julian.armistead@linaro.org>,
 Jim MacArthur <jim.macarthur@linaro.org>
Subject: Re: [PATCH 3/9] tests/tcg: make aarch64 boot.S handle different
 starting modes
User-Agent: meli/0.8.12
References: <20250428125918.449346-1-alex.bennee@linaro.org>
 <20250428125918.449346-4-alex.bennee@linaro.org>
In-Reply-To: <20250428125918.449346-4-alex.bennee@linaro.org>
Message-ID: <svmkvs.2mf5q4qhsfz83@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Received-SPF: pass client-ip=2a00:1450:4864:20::434;
 envelope-from=manos.pitsidianakis@linaro.org; helo=mail-wr1-x434.google.com
X-Spam_score_int: 12
X-Spam_score: 1.2
X-Spam_bar: +
X-Spam_report: (1.2 / 5.0 requ) BAYES_00=-1.9, CTE_8BIT_MISMATCH=0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_SBL_CSS=3.335, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

On Mon, 28 Apr 2025 15:59, Alex Bennée <alex.bennee@linaro.org> wrote:
>Currently the boot.S code assumes everything starts at EL1. This will
>break things like the memory test which will barf on unaligned memory
>access when run at a higher level.
>
>Adapt the boot code to do some basic verification of the starting mode
>and the minimal configuration to move to the lower exception levels.
>With this we can run the memory test with:
>
>  -M virt,secure=on
>  -M virt,secure=on,virtualization=on
>  -M virt,virtualisation=on
>
>If a test needs to be at a particular EL it can use the semihosting
>command line to indicate the level we should execute in.
>
>Cc: Julian Armistead <julian.armistead@linaro.org>
>Cc: Jim MacArthur <jim.macarthur@linaro.org>
>Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
>
>---
>v2
>  - allow tests to control the final EL we end up at
>---
> tests/tcg/aarch64/Makefile.softmmu-target |   3 +-
> tests/tcg/aarch64/system/boot.S           | 127 +++++++++++++++++++++-
> 2 files changed, 128 insertions(+), 2 deletions(-)
>
>diff --git a/tests/tcg/aarch64/Makefile.softmmu-target b/tests/tcg/aarch64/Makefile.softmmu-target
>index 9c52475b7a..f7a7d2b800 100644
>--- a/tests/tcg/aarch64/Makefile.softmmu-target
>+++ b/tests/tcg/aarch64/Makefile.softmmu-target
>@@ -68,7 +68,8 @@ run-plugin-semiconsole-with-%: semiconsole
> 
> # vtimer test needs EL2
> QEMU_EL2_MACHINE=-machine virt,virtualization=on,gic-version=2 -cpu cortex-a57 -smp 4
>-run-vtimer: QEMU_OPTS=$(QEMU_EL2_MACHINE) $(QEMU_BASE_ARGS) -kernel
>+QEMU_EL2_BASE_ARGS=-semihosting-config enable=on,target=native,chardev=output,arg="2"
>+run-vtimer: QEMU_OPTS=$(QEMU_EL2_MACHINE) $(QEMU_EL2_BASE_ARGS) -kernel
> 
> # Simple Record/Replay Test
> .PHONY: memory-record


The insertions in boot.S have mixed spaces/tabs


>diff --git a/tests/tcg/aarch64/system/boot.S b/tests/tcg/aarch64/system/boot.S
>index a5df9c173d..19b18bdeec 100644
>--- a/tests/tcg/aarch64/system/boot.S
>+++ b/tests/tcg/aarch64/system/boot.S
>@@ -16,6 +16,7 @@
> #define semihosting_call hlt 0xf000
> #define SYS_WRITEC	0x03	/* character to debug channel */
> #define SYS_WRITE0	0x04	/* string to debug channel */
>+#define SYS_GET_CMDLINE 0x15	/* get command line */
> #define SYS_EXIT	0x18
> 
> 	.align	12
>@@ -81,10 +82,129 @@ lower_a32_serror:
> .error:
> 	.string "Terminated by exception.\n"
> 
>+	.align 8
>+.get_cmd:
>+	.quad	cmdline
>+	.quad	128
>+
> 	.text
> 	.align 4
> 	.global __start
> __start:
>+	/*
>+	 * The test can set the semihosting command line to the target
>+	 * EL needed for the test. Keep that in w11.
>+	 */
>+	mov	x0, SYS_GET_CMDLINE
>+	adr	x1, .get_cmd
>+	semihosting_call
>+	adrp	x10, cmdline
>+	add	x10, x10, :lo12:cmdline
>+	ldrb	w11, [x10]
>+	cbz	w11, 1f

Suggested sanity check:

cmp w11, #'0'
b.lt curr_sp0_sync
cmp w11, #'4'
b.ge curr_sp0_sync

>+	sub 	w11, w11, #'0'
>+1:
>+
>+	/* Determine current Exception Level */
>+	mrs     x0, CurrentEL
>+	lsr     x0, x0, #2        /* CurrentEL[3:2] contains the current EL */
>+
>+	/* Branch based on current EL */
>+	cmp     x0, #3
>+	b.eq    setup_el3
>+	cmp     x0, #2
>+	b.eq    setup_el2
>+	cmp     x0, #1
>+	b.eq    at_testel            /* Already at EL1, skip transition */
>+	/* Should not be at EL0 - error out */
>+	b       curr_sp0_sync
>+
>+setup_el3:
>+	/* Ensure we trap if we get anything wrong */
>+	adr	x0, vector_table
>+	msr	vbar_el3, x0
>+
>+	/* Does the test want to be at EL3? */
>+	cmp	w11, #3
>+	beq	at_testel
>+
>+	/* Configure EL3 to for lower states (EL2 or EL1) */
>+	mrs     x0, scr_el3
>+	orr     x0, x0, #(1 << 10)    /* RW = 1: EL2/EL1 execution state is AArch64 */
>+	orr     x0, x0, #(1 << 0)     /* NS = 1: Non-secure state */
>+	msr     scr_el3, x0
>+
>+	/*
>+	 * We need to check if EL2 is actually enabled via ID_AA64PFR0_EL1,
>+	 * otherwise we should just jump straight to EL1.
>+	 */
>+	mrs     x0, id_aa64pfr0_el1
>+	ubfx    x0, x0, #8, #4        /* Extract EL2 field (bits 11:8) */
>+	cbz     x0, el2_not_present   /* If field is 0 no EL2 */
>+
>+
>+	/* Prepare SPSR for exception return to EL2 */
>+	mov	x0, #0x3c9            /* DAIF bits and EL2h mode (9) */
>+	msr     spsr_el3, x0
>+
>+	/* Set EL2 entry point */
>+	adr     x0, setup_el2
>+	msr     elr_el3, x0
>+
>+	/* Return to EL2 */
>+	eret
>+	nop
>+
>+el2_not_present:
>+	/* Initialize SCTLR_EL1 with reset value */
>+	msr     sctlr_el1, xzr
>+
>+	/* Set EL1 entry point */
>+	adr     x0, at_testel
>+	msr     elr_el3, x0
>+
>+	/* Prepare SPSR for exception return to EL1h with interrupts masked */
>+	mov     x0, #0x3c5            /* DAIF bits and EL1h mode (5) */
>+	msr     spsr_el3, x0
>+
>+	isb                           /* Synchronization barrier */
>+	eret                          /* Jump to EL1 */
>+
>+setup_el2:
>+	/* Ensure we trap if we get anything wrong */
>+	adr	x0, vector_table
>+	msr	vbar_el2, x0
>+
>+	/* Does the test want to be at EL2? */
>+	cmp	w11, #2
>+	beq	at_testel
>+
>+	/* Configure EL2 to allow transition to EL1 */
>+	mrs     x0, hcr_el2
>+	orr     x0, x0, #(1 << 31)    /* RW = 1: EL1 execution state is AArch64 */
>+	msr     hcr_el2, x0
>+
>+	/* Initialize SCTLR_EL1 with reset value */
>+	msr     sctlr_el1, xzr
>+
>+	/* Set EL1 entry point */
>+	adr     x0, at_testel
>+	msr     elr_el2, x0
>+
>+	/* Prepare SPSR for exception return to EL1 */
>+	mov     x0, #(0x5 << 0)       /* EL1h (SPx), with interrupts disabled */
>+	msr     spsr_el2, x0
>+
>+	/* Return to EL1 */
>+	eret
>+
>+	nop
>+
>+	/*
>+	 * At the target EL for the test, usually EL1. Note we still
>+	 * set everything up as if we were at EL1.
>+	 */
>+at_testel:
> 	/* Installs a table of exception vectors to catch and handle all
> 	   exceptions by terminating the process with a diagnostic.  */
> 	adr	x0, vector_table
>@@ -100,7 +220,7 @@ __start:
> 	 * maps RAM to the first Gb. The stage2 tables have two 2mb
> 	 * translation block entries covering a series of adjacent
> 	 * 4k pages.
>-	*/
>+ 	 */

Accidental space

> 
> 	/* Stage 1 entry: indexed by IA[38:30] */
> 	adr	x1, .				/* phys address */
>@@ -233,6 +353,11 @@ __sys_outc:
> 	ret
> 
> 	.data
>+
>+	.align 8
>+cmdline:
>+	.space 128, 0
>+
> 	.align	12
> 
> 	/* Translation table
>-- 
>2.39.5

Otherwise,

Reviewed-by: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>

