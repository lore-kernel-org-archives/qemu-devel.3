Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 08F89C3DA70
	for <qemu-devel@archiver.kernel.org>; Thu, 25 Jul 2024 23:18:41 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sX7iR-0004cH-02; Thu, 25 Jul 2024 19:17:43 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1sX7iP-0004bi-7b
 for qemu-devel@nongnu.org; Thu, 25 Jul 2024 19:17:41 -0400
Received: from mail-pg1-x531.google.com ([2607:f8b0:4864:20::531])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1sX7iN-0001Qd-2Q
 for qemu-devel@nongnu.org; Thu, 25 Jul 2024 19:17:40 -0400
Received: by mail-pg1-x531.google.com with SMTP id
 41be03b00d2f7-7a23fbb372dso308095a12.0
 for <qemu-devel@nongnu.org>; Thu, 25 Jul 2024 16:17:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1721949457; x=1722554257; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=Uq6x2xvCga3sDTvdX4fU2f5EvITv1hROhLfG6pBxsQU=;
 b=r8fk2ZeTF3sPAlWkUGsP3HRBLK2N7WMqtaKQYaWvLMki90U/120Z5+uVqdsVfFI7BT
 ljVaSUQqu3jxICTCkeEUDbDI9gkpltZuCcECt3zDOXFnxQdxKAY6kxqUPg+388y9dQGK
 hGEbjHEvy2lTsXIqv7jMSumSEmRRw/8m76rTcPy2nEPJL24KeEwjHhAh6MrojRUTZPWQ
 2SaBnKGeC1lxBYLHoSApotN3vI1WLJzzSH/9sCor/r0P8IlM97pyrfevZWVVH+bQz6QN
 Qv7sa48d4sq5UrTezJ/0zh1Z6Y580rSFawwZ3gkxGATlv+q3zj9Xe7rbNQs/WaSXFSSV
 zdmA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1721949457; x=1722554257;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=Uq6x2xvCga3sDTvdX4fU2f5EvITv1hROhLfG6pBxsQU=;
 b=LQo6GzGi5VcCOquSOeCkTW5kAYaFZrLIhCw0UxCqfZaul9gpOrkA1JwBJ+iFsN4YCI
 F7WY6DSuBCEew/1SUbXjAdAR0/tLFAC2baOu2fMaJLc57TpbkNpxoIxY6HwuHB2OYODR
 AgwIlCZ0Ldl7o3QJUMussaRe1l/+5EmuMnpUjEZRxzJriCBY/DEiKgNK7tso/gJ0NpMX
 A9THOX+FGRmDd3oPXX2+OT4T35Vs+m3f9X9bMnUfCWyg8Vt6hpAtVooKkhtTEcXxgPq9
 ce/CfioLq1eZ1FhIpceOSjy1RH/qwwEpZVIjBOksML9Ad11pFvqDLDcGVDhfDgVHobsv
 aQtw==
X-Forwarded-Encrypted: i=1;
 AJvYcCXrAE2ajqejNp+IZ0nLCgaf1zuS0pTLPM7TVZOrICjE3bFXMWpx87MLDwj9bzx3894spmowim5gEWfnLPyUBe780Nyp5Qw=
X-Gm-Message-State: AOJu0YzYAGPr2/ANjqpLml7WkABQ7K80cLDpm23VzAAlg6kkFVbSPw6r
 AEa/M9ERcQI2sdSAkcnJ5Hsl+piUv/lCGGP5mzBdr5v+YXARIauCyt87lLvp6cI=
X-Google-Smtp-Source: AGHT+IH3GpZ/Zzt/UD2bh2KfBID+h3M1/FfD/0uEeiZLptOIHoHFQ6QXgVeTBzxtQBBkk0YUwZH54A==
X-Received: by 2002:a05:6a20:2588:b0:1c3:b106:a045 with SMTP id
 adf61e73a8af0-1c47289f52cmr5508074637.27.1721949456883; 
 Thu, 25 Jul 2024 16:17:36 -0700 (PDT)
Received: from [192.168.1.113] ([203.56.128.103])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-70ead72ad5asm1676461b3a.90.2024.07.25.16.17.34
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 25 Jul 2024 16:17:36 -0700 (PDT)
Message-ID: <07beb08d-c0c2-434a-bac0-5d5e461d7a6d@linaro.org>
Date: Fri, 26 Jul 2024 09:17:29 +1000
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 4/4] tests/tcg/aarch64: Extend MTE gdbstub tests to system
 mode
To: Gustavo Romero <gustavo.romero@linaro.org>, qemu-devel@nongnu.org,
 philmd@linaro.org, alex.bennee@linaro.org
Cc: peter.maydell@linaro.org
References: <20240722160709.1677430-1-gustavo.romero@linaro.org>
 <20240722160709.1677430-5-gustavo.romero@linaro.org>
Content-Language: en-US
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20240722160709.1677430-5-gustavo.romero@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::531;
 envelope-from=richard.henderson@linaro.org; helo=mail-pg1-x531.google.com
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

On 7/23/24 02:07, Gustavo Romero wrote:
>   def run_test():
> -    gdb.execute("break 95", False, True)
> +    if mode == "system":
> +        # Break address: where to break before performing the tests
> +        # Addresss is the last insn. before 'main' returns. See mte.c
> +        ba = "*main+52"

Ugly.  You can add labels in your inline asm block instead.

> diff --git a/tests/tcg/aarch64/system/boot.S b/tests/tcg/aarch64/system/boot.S
> index 501685d0ec..a12393d00b 100644
> --- a/tests/tcg/aarch64/system/boot.S
> +++ b/tests/tcg/aarch64/system/boot.S
> @@ -135,11 +135,22 @@ __start:
>   	orr	x1, x1, x3
>   	str	x1, [x2]			/* 2nd 2mb (.data & .bss)*/
>   
> +        /* Third block: .mte_page */
> +	adrp	x1, .mte_page
> +	add	x1, x1, :lo12:.mte_page
> +	bic	x1, x1, #(1 << 21) - 1
> +	and 	x4, x1, x5
> +	add	x2, x0, x4, lsr #(21 - 3)
> +	ldr	x3, =(3 << 53) | 0x401 | 1 << 2	/* attr(AF, NX, block, AttrIndx=Attr1) */
> +	orr	x1, x1, x3
> +	str	x1, [x2]
> +
>   	/* Setup/enable the MMU.  */
>   
>   	/*
>   	 * TCR_EL1 - Translation Control Registers
>   	 *
> +	 * TBI0[37] = 0b1 => Top Byte ignored and used for tagged addresses
>   	 * IPS[34:32] = 40-bit PA, 1TB
>   	 * TG0[14:15] = b00 => 4kb granuale
>   	 * ORGN0[11:10] = Outer: Normal, WB Read-Alloc No Write-Alloc Cacheable
> @@ -152,16 +163,22 @@ __start:
>   	 * with at least 1gb range to see RAM. So we start with a
>   	 * level 1 lookup.
>   	 */
> -	ldr	x0, = (2 << 32) | 25 | (3 << 10) | (3 << 8)
> +	ldr	x0, = (1 << 37) | (2 << 32) | 25 | (3 << 10) | (3 << 8)
>   	msr	tcr_el1, x0
>   
> -	mov	x0, #0xee			/* Inner/outer cacheable WB */
> +	/*
> +	 * Attr0: Normal, Inner/outer cacheable WB
> +	 * Attr1: Tagged Normal (MTE)
> +	 */
> +	mov	x0, #0xf0ee

Up to here, I think we're fine, no matter the emulated cpu model.

>   	msr	mair_el1, x0
>   	isb
>   
>   	/*
>   	 * SCTLR_EL1 - System Control Register
>   	 *
> +	 * ATA[43] = 1 = enable access to allocation tags at EL1
> +	 * TCF[40] = 1 = Tag Check Faults cause a synchronous exception
>   	 * WXN[19] = 0 = no effect, Write does not imply XN (execute never)
>   	 * I[12] = Instruction cachability control
>   	 * SA[3] = SP alignment check
> @@ -169,7 +186,8 @@ __start:
>   	 * M[0] = 1, enable stage 1 address translation for EL0/1
>   	 */
>   	mrs	x0, sctlr_el1
> -	ldr	x1, =0x100d			/* bits I(12) SA(3) C(2) M(0) */
> +	/* Bits set: ATA(43) TCF(40) I(12) SA(3) C(2) M(0) */
> +	ldr	x1, =(0x100d | 1 << 43 | 1 << 40)

But here, it's only legal to run this modified boot.S on -cpu max.
We should check for MTE enabled before setting those, or
set them elsewhere, e.g. in main of the specific MTE test.

> @@ -239,3 +257,5 @@ ttb_stage2:
>   stack:
>   	.space 65536, 0
>   stack_end:
> +
> +	.section .mte_page

Why?

> diff --git a/tests/tcg/aarch64/system/kernel.ld b/tests/tcg/aarch64/system/kernel.ld
> index 7b3a76dcbf..7c00c1c378 100644
> --- a/tests/tcg/aarch64/system/kernel.ld
> +++ b/tests/tcg/aarch64/system/kernel.ld
> @@ -18,6 +18,11 @@ SECTIONS
>       .bss : {
>           *(.bss)
>       }
> +    /* align MTE section to next (third) 2mb */
> +    . = ALIGN(1 << 22);
> +    .mte : {
> +        *(.mte_page)
> +    }

Why?

>       /DISCARD/ : {
>           *(.ARM.attributes)
>       }
> diff --git a/tests/tcg/aarch64/system/mte.c b/tests/tcg/aarch64/system/mte.c
> new file mode 100644
> index 0000000000..58a5ac31ff
> --- /dev/null
> +++ b/tests/tcg/aarch64/system/mte.c
> @@ -0,0 +1,40 @@
> +#include <inttypes.h>
> +
> +int main(void)
> +{
> +    uint8_t *addr;
> +
> +    /*
> +     * Third 2MB chunk in the second 1GB block.
> +     * See .mte_page section in kernel.ld.
> +     */
> +    addr = (void *)((1UL << 30) | (1UL << 22));

... because you're not using .mte_page here, just computing it.

> +
> +    asm (
> +        /*
> +         * Set GCR for randon tag generation. 0xA5 is just a random value to set

random

> +         * GCR != 0 so the tag generated by 'irg' is not zero.
> +         */
> +        "ldr x1, =0xA5;"
> +        "msr gcr_el1, x1;"

I think it might be easier to split the asm:

   asm volatile("msr gcr_el1, %0" : : "r"(0xA5));

> +
> +         /* Generate a logical tag and put it in 'addr' pointer. */
> +         "irg %[addr], %[addr];"

   asm("irg %0,%0" : "+r"(addr));

> +
> +         /*
> +          * Store the generated tag to memory region pointed to by 'addr', i.e.
> +          * set the allocation tag for the memory region.
> +          */
> +         "stg %[addr], [%[addr]];"

Storing addr into addr is a titch confusing, clearer with zero?

   asm("stg xzr,[%0]" : : "r"(addr));

> +
> +         /*
> +          * Store a random value (0xdeadbeef) to *addr. This must not cause any
> +          * Tag Check Fault since logical and allocation tags are set the same.
> +          */
> +	 "ldr x1, =0xdeadbeef;"
> +	 "str x1, [x0];"

Where does x0 come from?  Certainly not "addr"...
Can you use "addr" directly in the gdb script?


r~

