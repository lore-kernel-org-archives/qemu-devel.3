Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 42439C3DA4A
	for <qemu-devel@archiver.kernel.org>; Thu,  8 Aug 2024 05:08:45 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sbvO8-0001Bw-46; Thu, 08 Aug 2024 01:08:36 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <gustavo.romero@linaro.org>)
 id 1sbvO4-0000wn-34
 for qemu-devel@nongnu.org; Thu, 08 Aug 2024 01:08:32 -0400
Received: from mail-pj1-x102e.google.com ([2607:f8b0:4864:20::102e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <gustavo.romero@linaro.org>)
 id 1sbvO2-0001bU-1F
 for qemu-devel@nongnu.org; Thu, 08 Aug 2024 01:08:31 -0400
Received: by mail-pj1-x102e.google.com with SMTP id
 98e67ed59e1d1-2cf93dc11c6so503456a91.1
 for <qemu-devel@nongnu.org>; Wed, 07 Aug 2024 22:08:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1723093708; x=1723698508; darn=nongnu.org;
 h=content-transfer-encoding:content-language:in-reply-to:mime-version
 :user-agent:date:message-id:from:references:cc:to:subject:from:to:cc
 :subject:date:message-id:reply-to;
 bh=qWL37pcmKKZfStzIyyB2slRnkA+/9hjkNmqqRl+6hzs=;
 b=rXRgFPRzWU0QI/bcFqmqv37IlFvabiweqB7m291db2N4sl9Ax0GvM9m+3LB5tg+4h8
 yfAjAt8mSWEoUHc8e3q+GjxkihPaXCfqyeqteXTBnzr8ZQ+dxAJvvehXPlIFMBEHL9aY
 vWnWozYAGhxLQ9n2+XzOJiF8sbXrn+VM9G9hRzLXtMI7hm0p+p1o2gBQkIjcehA+86Fw
 gSnHjClEb53h4jAGNj+/L+ojDCpkL0ZRiorShO5DMv9/l/xKkNj5hJPk86VrdIocCEEN
 BluiFqpwb4RJS2pCoCtlfyfx4tWY1XdHFO2PS4thEpELULYp25loHomexm3JBsXN+NXm
 gghw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1723093708; x=1723698508;
 h=content-transfer-encoding:content-language:in-reply-to:mime-version
 :user-agent:date:message-id:from:references:cc:to:subject
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=qWL37pcmKKZfStzIyyB2slRnkA+/9hjkNmqqRl+6hzs=;
 b=Q2/DUdqBSQApLljlzmC8J7hyZli0BYfW0RcTCLjpPrwpaaYy6hfpoP5Baubvn2nT3+
 HtNq3U1jmYdobDAPVAvMEe/a0oaBGYeOxkWCmtk8zkcSwr6eTf2Ipz7teUq3GKM+aTbx
 NXfWHa+yFXXaShNdL1L/W+HpSouyBrGJ+i65v6atPAGQq33cC5LgW89ijkcLRB2yEZEX
 MM9E/MUEmtUM11B7Rv+O23XMPiUiZhzleZyqhXnEyAfewzzWz/xaxiztrRqVAsQOL6Ks
 kGrgHAp+tTvqe4+s8qYE/c+5SgMNV3rGBxbDzf7Vz+xnf0XSeRIpmTtcM8IfufPyT7oq
 iXIw==
X-Forwarded-Encrypted: i=1;
 AJvYcCXDl1KE4x8A6vebqDvu9vYootc6kXQ5liKSMiGKCCt+ZGUArMjW1ZU/dxgbtFHyN6tX1HxGWyFYHU+gvj5oZEVW6B1EoIc=
X-Gm-Message-State: AOJu0YzqcAVm/VNbpuYVdO71XEqHoFYid2HXUipAWSBTU24nhvE3HjQ1
 gXHbN0HOviPHvysxQDBAIZ9HhLaH5cDmjv0gY9NanRF8UBs2Rl451hTpzi0gKo4=
X-Google-Smtp-Source: AGHT+IEZfd4vmeoEIXhMfAFhrqZ1pF4VfJTCHkhj88pxfumShW4Vv9sRJFHcm9hPjKZMSvgh3VZhHg==
X-Received: by 2002:a17:90b:3909:b0:2cd:7d6f:31b0 with SMTP id
 98e67ed59e1d1-2d1c34952c5mr886072a91.43.1723093708451; 
 Wed, 07 Aug 2024 22:08:28 -0700 (PDT)
Received: from [192.168.0.103] ([187.75.36.187])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-2d1b3b63c2bsm2497916a91.55.2024.08.07.22.08.26
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 07 Aug 2024 22:08:27 -0700 (PDT)
Subject: Re: [PATCH 4/4] tests/tcg/aarch64: Extend MTE gdbstub tests to system
 mode
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org,
 philmd@linaro.org, alex.bennee@linaro.org
Cc: peter.maydell@linaro.org
References: <20240722160709.1677430-1-gustavo.romero@linaro.org>
 <20240722160709.1677430-5-gustavo.romero@linaro.org>
 <07beb08d-c0c2-434a-bac0-5d5e461d7a6d@linaro.org>
From: Gustavo Romero <gustavo.romero@linaro.org>
Message-ID: <66efea5b-c217-48b9-f11b-b2ac0a51ccc2@linaro.org>
Date: Thu, 8 Aug 2024 02:08:25 -0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.6.0
MIME-Version: 1.0
In-Reply-To: <07beb08d-c0c2-434a-bac0-5d5e461d7a6d@linaro.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::102e;
 envelope-from=gustavo.romero@linaro.org; helo=mail-pj1-x102e.google.com
X-Spam_score_int: -47
X-Spam_score: -4.8
X-Spam_bar: ----
X-Spam_report: (-4.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, NICE_REPLY_A=-2.732,
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

Hi Richard,

On 7/25/24 8:17 PM, Richard Henderson wrote:
> On 7/23/24 02:07, Gustavo Romero wrote:
>>   def run_test():
>> -    gdb.execute("break 95", False, True)
>> +    if mode == "system":
>> +        # Break address: where to break before performing the tests
>> +        # Addresss is the last insn. before 'main' returns. See mte.c
>> +        ba = "*main+52"
> 
> Ugly.  You can add labels in your inline asm block instead.

I forgot about that possibility. Thanks. This motivated me to
convert mte.c to mte.S. I think there is no benefit in keeping
the test in C with a bunch of inline asm blocks. Please see v2.


>> diff --git a/tests/tcg/aarch64/system/boot.S b/tests/tcg/aarch64/system/boot.S
>> index 501685d0ec..a12393d00b 100644
>> --- a/tests/tcg/aarch64/system/boot.S
>> +++ b/tests/tcg/aarch64/system/boot.S
>> @@ -135,11 +135,22 @@ __start:
>>       orr    x1, x1, x3
>>       str    x1, [x2]            /* 2nd 2mb (.data & .bss)*/
>> +        /* Third block: .mte_page */
>> +    adrp    x1, .mte_page
>> +    add    x1, x1, :lo12:.mte_page
>> +    bic    x1, x1, #(1 << 21) - 1
>> +    and     x4, x1, x5
>> +    add    x2, x0, x4, lsr #(21 - 3)
>> +    ldr    x3, =(3 << 53) | 0x401 | 1 << 2    /* attr(AF, NX, block, AttrIndx=Attr1) */
>> +    orr    x1, x1, x3
>> +    str    x1, [x2]
>> +
>>       /* Setup/enable the MMU.  */
>>       /*
>>        * TCR_EL1 - Translation Control Registers
>>        *
>> +     * TBI0[37] = 0b1 => Top Byte ignored and used for tagged addresses
>>        * IPS[34:32] = 40-bit PA, 1TB
>>        * TG0[14:15] = b00 => 4kb granuale
>>        * ORGN0[11:10] = Outer: Normal, WB Read-Alloc No Write-Alloc Cacheable
>> @@ -152,16 +163,22 @@ __start:
>>        * with at least 1gb range to see RAM. So we start with a
>>        * level 1 lookup.
>>        */
>> -    ldr    x0, = (2 << 32) | 25 | (3 << 10) | (3 << 8)
>> +    ldr    x0, = (1 << 37) | (2 << 32) | 25 | (3 << 10) | (3 << 8)
>>       msr    tcr_el1, x0
>> -    mov    x0, #0xee            /* Inner/outer cacheable WB */
>> +    /*
>> +     * Attr0: Normal, Inner/outer cacheable WB
>> +     * Attr1: Tagged Normal (MTE)
>> +     */
>> +    mov    x0, #0xf0ee
> 
> Up to here, I think we're fine, no matter the emulated cpu model.
> 
>>       msr    mair_el1, x0
>>       isb
>>       /*
>>        * SCTLR_EL1 - System Control Register
>>        *
>> +     * ATA[43] = 1 = enable access to allocation tags at EL1
>> +     * TCF[40] = 1 = Tag Check Faults cause a synchronous exception
>>        * WXN[19] = 0 = no effect, Write does not imply XN (execute never)
>>        * I[12] = Instruction cachability control
>>        * SA[3] = SP alignment check
>> @@ -169,7 +186,8 @@ __start:
>>        * M[0] = 1, enable stage 1 address translation for EL0/1
>>        */
>>       mrs    x0, sctlr_el1
>> -    ldr    x1, =0x100d            /* bits I(12) SA(3) C(2) M(0) */
>> +    /* Bits set: ATA(43) TCF(40) I(12) SA(3) C(2) M(0) */
>> +    ldr    x1, =(0x100d | 1 << 43 | 1 << 40)
> 
> But here, it's only legal to run this modified boot.S on -cpu max.
> We should check for MTE enabled before setting those, or
> set them elsewhere, e.g. in main of the specific MTE test.

Right. I move all these bits for MTE to mte.S, under main function,
and just left the page table setting in boot.S, since we need to
set it before the MMU is turned on.


>> @@ -239,3 +257,5 @@ ttb_stage2:
>>   stack:
>>       .space 65536, 0
>>   stack_end:
>> +
>> +    .section .mte_page
> 
> Why?
> 
>> diff --git a/tests/tcg/aarch64/system/kernel.ld b/tests/tcg/aarch64/system/kernel.ld
>> index 7b3a76dcbf..7c00c1c378 100644
>> --- a/tests/tcg/aarch64/system/kernel.ld
>> +++ b/tests/tcg/aarch64/system/kernel.ld
>> @@ -18,6 +18,11 @@ SECTIONS
>>       .bss : {
>>           *(.bss)
>>       }
>> +    /* align MTE section to next (third) 2mb */
>> +    . = ALIGN(1 << 22);
>> +    .mte : {
>> +        *(.mte_page)
>> +    }
> 
> Why?
> 
>>       /DISCARD/ : {
>>           *(.ARM.attributes)
>>       }
>> diff --git a/tests/tcg/aarch64/system/mte.c b/tests/tcg/aarch64/system/mte.c
>> new file mode 100644
>> index 0000000000..58a5ac31ff
>> --- /dev/null
>> +++ b/tests/tcg/aarch64/system/mte.c
>> @@ -0,0 +1,40 @@
>> +#include <inttypes.h>
>> +
>> +int main(void)
>> +{
>> +    uint8_t *addr;
>> +
>> +    /*
>> +     * Third 2MB chunk in the second 1GB block.
>> +     * See .mte_page section in kernel.ld.
>> +     */
>> +    addr = (void *)((1UL << 30) | (1UL << 22));
> 
> ... because you're not using .mte_page here, just computing it.

.mte_page is used in boot.S for setting the page table entry, in:

         /* Third block: .mte_page */
         adrp    x1, .mte_page
         add     x1, x1, :lo12:.mte_page
	[...]

That's why it's being computed in kernel.ld. That said, you're
right that it's better to also tie 'addr' to it instead of having
a hard-coded value.

I'm using the .mte_page address in the new mte.S test in v2, so
now the value for 'addr' used in the test is tied to that computed
value.


>> +
>> +    asm (
>> +        /*
>> +         * Set GCR for randon tag generation. 0xA5 is just a random value to set
> 
> random
> 
>> +         * GCR != 0 so the tag generated by 'irg' is not zero.
>> +         */
>> +        "ldr x1, =0xA5;"
>> +        "msr gcr_el1, x1;"
> 
> I think it might be easier to split the asm:
> 
>    asm volatile("msr gcr_el1, %0" : : "r"(0xA5));

hmm, all the tests are built with optimizations disabled,
so no need to use volatile? Anyways, in v2 I'm using mov
instead of ldr, and since it's .S, no more inline asm.


>> +
>> +         /* Generate a logical tag and put it in 'addr' pointer. */
>> +         "irg %[addr], %[addr];"
> 
>    asm("irg %0,%0" : "+r"(addr));
> 
>> +
>> +         /*
>> +          * Store the generated tag to memory region pointed to by 'addr', i.e.
>> +          * set the allocation tag for the memory region.
>> +          */
>> +         "stg %[addr], [%[addr]];"
> 
> Storing addr into addr is a titch confusing, clearer with zero?
> 
>    asm("stg xzr,[%0]" : : "r"(addr))

This an invalid insn. xzr reg. can't be used as operand 1 in 'stg',
because register 31 is encoded as sp, not xzr.

However, I don't want to zero the allocation tag. Actually, it's
the opposite, I want it != 0, that's why I set gcr_el1 != 0: to
get a non-zero tag from 'irg'.

I agree it's a tad confusing, but the thing is, 'stg' expects a
tagged address in the source operand, not a "pure" tag, hence the
use of 'addr' in operand 1. But I think it could be:

stg tagged_addr, [addr]

In v2 I put a comment that stg actually extracts the tag to be
stored in [addr] from the address in 'tagged_addr'


>> +
>> +         /*
>> +          * Store a random value (0xdeadbeef) to *addr. This must not cause any
>> +          * Tag Check Fault since logical and allocation tags are set the same.
>> +          */
>> +     "ldr x1, =0xdeadbeef;"
>> +     "str x1, [x0];"
> 
> Where does x0 come from?  Certainly not "addr"...
> Can you use "addr" directly in the gdb script?

Yep, it should be 'addr' instead of x0 here. It's a leftover.
Fixed in v2. Thanks.


Cheers,
Gustavo

