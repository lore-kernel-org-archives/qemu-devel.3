Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A789DC4345F
	for <qemu-devel@archiver.kernel.org>; Tue, 30 Apr 2024 19:42:32 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s1tMM-0006Rj-Nw; Tue, 30 Apr 2024 15:41:50 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ltaylorsimpson@gmail.com>)
 id 1s1tML-0006RX-Q0
 for qemu-devel@nongnu.org; Tue, 30 Apr 2024 15:41:49 -0400
Received: from mail-oo1-xc36.google.com ([2607:f8b0:4864:20::c36])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <ltaylorsimpson@gmail.com>)
 id 1s1tMI-0006fP-3I
 for qemu-devel@nongnu.org; Tue, 30 Apr 2024 15:41:47 -0400
Received: by mail-oo1-xc36.google.com with SMTP id
 006d021491bc7-5ad2da2196aso3951970eaf.2
 for <qemu-devel@nongnu.org>; Tue, 30 Apr 2024 12:41:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1714506104; x=1715110904; darn=nongnu.org;
 h=content-language:thread-index:content-transfer-encoding
 :mime-version:message-id:date:subject:in-reply-to:references:cc:to
 :from:from:to:cc:subject:date:message-id:reply-to;
 bh=ToMG8MUfcepB09bTK2d3EnQUBS+qe1GcZHe3fbzeTew=;
 b=A8R8kzQ0vXsgGQ/xPSv17UhbvO0ZJhxQSWr3c0HPU+Ndb9mwZ5belxQI+v+DSlhFQc
 MC6bnovNsi5TVi3M6ANQ/gxHen+jqwTMwTFLz5dBd2a+097G7TgSYrro97/oEqcILU9e
 bKSBPQeeLehbDf22DZqwPzF/fWSTVaoyykcTXqVICMAt7GyA/9/pDxzqh6gwmo6YJWLv
 4C3CzKhFNn8wuQR7ZAA/JmwJfSzyjtptDjWJECYN+uyQGD3XzcPOz+Qz+SxTLLWQSmpp
 hI/BgeKk6ot1+Q4G8JmQpMXCy9JcLhgsXcDosKyn0G3b5NnSc7vFQAvTkSVMv5+xUQij
 4TbA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1714506104; x=1715110904;
 h=content-language:thread-index:content-transfer-encoding
 :mime-version:message-id:date:subject:in-reply-to:references:cc:to
 :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=ToMG8MUfcepB09bTK2d3EnQUBS+qe1GcZHe3fbzeTew=;
 b=Ec+oElPTd5A9mGBV/szA91k3tSKcooy+K+HS4hIMK2L/EAYWK5EJ7ed+1MreCgfvBa
 5K9n0wLENNLQww+nYRDpbqXneDL5luG0yr5ONgrwtF5uxDRXH8VbwS/og8GAbqPfn6Di
 RzvaHiMmdEenp3q3H2UOv/Oje/Vp9ff23DH6vYJ/TVFWcv26xLCiqZvF7H88azGfSpqh
 9P3388vmxDwlupPq1ykwFdvGtjyOdVFKsD1CtD2Ks4YSAfXSd0ncz1v1GkoiSCtOD2eF
 XdnlWWNwr6r71IQNJIQVAenDFJzhGPEcW4dkS45evB4hsmywHH2b4txiTQV7zql7NFb0
 1r4w==
X-Forwarded-Encrypted: i=1;
 AJvYcCVBX+16Fhs++hIew9zMUYh3/o9A6ziIu8qf9Nssxs4qD1G0AauKETmRIdXHj98uTdPo8pzmTFGOoTOYr8iBR/j13XRphC4=
X-Gm-Message-State: AOJu0Yw3bCKb3wHnM2E7eLfSCMQ0dC3x1s5PR5Y055IvGwGbYM7uOlLz
 H17/09ateAh9g7DvsPWcBaV8OGDUTP41ORMx1ExVXJW96nosFdZv
X-Google-Smtp-Source: AGHT+IGELTjVtlXvCrbFQ5IY0v+MdtTQEdJs++/dXrBMb0/pk+dvCWUoWgAhJkvOJPv2yYjzcZWuMQ==
X-Received: by 2002:a4a:1ac3:0:b0:5aa:6404:936a with SMTP id
 186-20020a4a1ac3000000b005aa6404936amr397009oof.5.1714506104289; 
 Tue, 30 Apr 2024 12:41:44 -0700 (PDT)
Received: from DESKTOPUU50BPD ([2603:8080:1f00:9c00:d4ad:6f4f:f449:e021])
 by smtp.gmail.com with ESMTPSA id
 v12-20020a4aaecc000000b005a586b0906esm5501711oon.26.2024.04.30.12.41.42
 (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
 Tue, 30 Apr 2024 12:41:43 -0700 (PDT)
From: <ltaylorsimpson@gmail.com>
To: "'Matheus Tavares Bernardino'" <quic_mathbern@quicinc.com>,
 <qemu-devel@nongnu.org>
Cc: <bcain@quicinc.com>, <sidneym@quicinc.com>, <ale@rev.ng>, <anjo@rev.ng>,
 <richard.henderson@linaro.org>, "'Laurent Vivier'" <laurent@vivier.eu>
References: <5c90567ec28723865e144f386b36f5b676b7a5d3.1714486874.git.quic_mathbern@quicinc.com>
In-Reply-To: <5c90567ec28723865e144f386b36f5b676b7a5d3.1714486874.git.quic_mathbern@quicinc.com>
Subject: RE: [PATCH v3] Hexagon: add PC alignment check and exception
Date: Tue, 30 Apr 2024 14:41:48 -0500
Message-ID: <02cb01da9b36$719b3fb0$54d1bf10$@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 7bit
X-Mailer: Microsoft Outlook 16.0
Thread-Index: AQFAkKq+nqE/XEISDiGMeodexK5GNbK1R38Q
Content-Language: en-us
Received-SPF: pass client-ip=2607:f8b0:4864:20::c36;
 envelope-from=ltaylorsimpson@gmail.com; helo=mail-oo1-xc36.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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



> -----Original Message-----
> From: Matheus Tavares Bernardino <quic_mathbern@quicinc.com>
> Sent: Tuesday, April 30, 2024 9:25 AM
> To: qemu-devel@nongnu.org
> Cc: bcain@quicinc.com; sidneym@quicinc.com; ale@rev.ng; anjo@rev.ng;
> ltaylorsimpson@gmail.com; richard.henderson@linaro.org; Laurent Vivier
> <laurent@vivier.eu>
> Subject: [PATCH v3] Hexagon: add PC alignment check and exception
> 
> The Hexagon Programmer's Reference Manual says that the exception 0x1e
> should be raised upon an unaligned program counter. Let's implement that
> and also add some tests.
> 
> Signed-off-by: Matheus Tavares Bernardino <quic_mathbern@quicinc.com>
> ---
> v2: https://lore.kernel.org/qemu-
> devel/e559b521d1920f804df10244c8c07564431aeba5.1714419461.git.quic_ma
> thbern@quicinc.com/
> 
> Thanks for the comments, Richard and Taylor!
> 
> Changed in v3:
> - Removed now unnecessary pkt_raises_exception addition.
> - Added HEX_EXCP_PC_NOT_ALIGNED handling at
>   linux-user/hexagon/cpu_loop.c.
> - Merged all tests into a C file that uses signal handler to check
>   that the exception was raised.
> 
>  target/hexagon/cpu.h                       |  7 ++
>  target/hexagon/cpu_bits.h                  |  4 +
>  target/hexagon/macros.h                    |  3 -
>  linux-user/hexagon/cpu_loop.c              |  4 +
>  target/hexagon/op_helper.c                 |  9 +--
>  tests/tcg/hexagon/unaligned_pc.c           | 85 ++++++++++++++++++++++
>  tests/tcg/hexagon/Makefile.target          |  4 +
>  tests/tcg/hexagon/unaligned_pc_multi_cof.S |  5 ++
>  8 files changed, 113 insertions(+), 8 deletions(-)  create mode 100644
> tests/tcg/hexagon/unaligned_pc.c  create mode 100644
> tests/tcg/hexagon/unaligned_pc_multi_cof.S
> 



> a/tests/tcg/hexagon/unaligned_pc.c b/tests/tcg/hexagon/unaligned_pc.c
> new file mode 100644
> index 0000000000..1add2d0d99
> --- /dev/null
> +++ b/tests/tcg/hexagon/unaligned_pc.c
> @@ -0,0 +1,85 @@
> +#include <stdio.h>
> +#include <signal.h>
> +#include <setjmp.h>
> +#include <stdlib.h>
> +
> +/* will be changed in signal handler */ volatile sig_atomic_t
> +completed_tests; static jmp_buf after_test; static int nr_tests;
> +
> +void __attribute__((naked)) test_return(void) {
> +    asm volatile(
> +        "allocframe(#0x8)\n"
> +        "r0 = #0xffffffff\n"
> +        "framekey = r0\n"
> +        "dealloc_return\n"
> +        : : : "r0");

Add r29, r30, r31 to clobbers list.
Add framekey to clobbers list (assuming the compiler will take it).

> +}
> +
> +void test_endloop(void)
> +{
> +    asm volatile(
> +        "loop0(1f, #2)\n"
> +        "1: r0 = #0x3\n"
> +        "sa0 = r0\n"
> +        "{ nop }:endloop0\n"
> +        : : : "r0");
> +}

Add sa0, lc0, usr to the clobbers list.

> +
> +void test_multi_cof(void)
> +{
> +    asm volatile(
> +        "p0 = cmp.eq(r0, r0)\n"
> +        "{\n"
> +        "    if (p0) jump test_multi_cof_unaligned\n"
> +        "    jump 1f\n"
> +        "}\n"
> +        "1: nop\n"
> +        : : : "p0");
> +}
> +
> +void sigbus_handler(int signum)
> +{
> +    /* retore framekey after test_return */
> +    asm volatile(
> +        "r0 = #0\n"
> +        "framekey = r0\n"
> +        : : : "r0");

Add framekey to the clobbers list.

> +    printf("Test %d complete\n", completed_tests);
> +    completed_tests++;
> +    siglongjmp(after_test, 1);
> +}
> +
> +void test_done(void)
> +{
> +    int err = (completed_tests != nr_tests);
> +    puts(err ? "FAIL" : "PASS");
> +    exit(err);
> +}
> +
> +typedef void (*test_fn)(void);
> +
> +int main()
> +{
> +    test_fn tests[] = { test_return, test_endloop, test_multi_cof,
test_done
> };
> +    nr_tests = (sizeof(tests) / sizeof(tests[0])) - 1;
> +
> +    struct sigaction sa = {
> +        .sa_sigaction = sigbus_handler,
> +        .sa_flags = SA_SIGINFO
> +    };
> +
> +    if (sigaction(SIGBUS, &sa, NULL) < 0) {
> +        perror("sigaction");
> +        return EXIT_FAILURE;
> +    }
> +
> +    sigsetjmp(after_test, 1);
> +    tests[completed_tests]();
> +
> +    /* should never get here */
> +    puts("FAIL");
> +    return 1;
> +}
> diff --git a/tests/tcg/hexagon/Makefile.target
> b/tests/tcg/hexagon/Makefile.target
> index f839b2c0d5..75139e731c 100644
> --- a/tests/tcg/hexagon/Makefile.target
> +++ b/tests/tcg/hexagon/Makefile.target
> @@ -51,6 +51,7 @@ HEX_TESTS += scatter_gather  HEX_TESTS += hvx_misc
> HEX_TESTS += hvx_histogram  HEX_TESTS += invalid-slots
> +HEX_TESTS += unaligned_pc
> 
>  run-and-check-exception = $(call run-test,$2,$3 2>$2.stderr; \
>  	test $$? -eq 1 && grep -q "exception $(strip $1)" $2.stderr) @@ -
> 108,6 +109,9 @@ preg_alias: preg_alias.c hex_test.h
>  read_write_overlap: read_write_overlap.c hex_test.h
>  reg_mut: reg_mut.c hex_test.h
> 
> +unaligned_pc: unaligned_pc.c unaligned_pc_multi_cof.S
> +	$(CC) $(CFLAGS) $(CROSS_CC_GUEST_CFLAGS) -mv73 $^ -o $@
> $(LDFLAGS)
> +
>  # This test has to be compiled for the -mv67t target
>  usr: usr.c hex_test.h
>  	$(CC) $(CFLAGS) -mv67t -O2 -Wno-inline-asm -Wno-expansion-to-
> defined $< -o $@ $(LDFLAGS) diff --git
> a/tests/tcg/hexagon/unaligned_pc_multi_cof.S
> b/tests/tcg/hexagon/unaligned_pc_multi_cof.S
> new file mode 100644
> index 0000000000..10accd0057
> --- /dev/null
> +++ b/tests/tcg/hexagon/unaligned_pc_multi_cof.S
> @@ -0,0 +1,5 @@
> +.org 0x3
> +.global test_multi_cof_unaligned
> +test_multi_cof_unaligned:
> +	nop
> +	jumpr r31
> --
> 2.37.2



