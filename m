Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 09E0FC54E4A
	for <qemu-devel@archiver.kernel.org>; Thu,  7 Mar 2024 21:44:15 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1riLWN-000092-TF; Thu, 07 Mar 2024 16:43:23 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dbarboza@ventanamicro.com>)
 id 1riLWL-00008m-Di
 for qemu-devel@nongnu.org; Thu, 07 Mar 2024 16:43:21 -0500
Received: from mail-pl1-x62a.google.com ([2607:f8b0:4864:20::62a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <dbarboza@ventanamicro.com>)
 id 1riLWJ-0002WG-3G
 for qemu-devel@nongnu.org; Thu, 07 Mar 2024 16:43:20 -0500
Received: by mail-pl1-x62a.google.com with SMTP id
 d9443c01a7336-1dd6198c4e2so5819395ad.2
 for <qemu-devel@nongnu.org>; Thu, 07 Mar 2024 13:43:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=ventanamicro.com; s=google; t=1709847797; x=1710452597; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=MfK7W5gmvT+g0XsJfqW1j3QuE+eaaW8RgalDvnquAys=;
 b=betTI737nOWllJH4jRc7loJ2arygZcTVD0cVG5eHwrwT60eoWiUzTs0a1cFfm290R8
 n69RFEud5TXhmwULqdLoG7+hBBVJLZqpqFHoyuz1VjRMIoNL8wL3XuQMWczdirOuh0BQ
 7NthX2wS0uHQIh56KGSxk6UkW1TQyKAqg8ZuCn3BMoH5kjEQ4U0kandQgc7hJ9WW7bCk
 rPX7e0xqmHTLxae8w1v23pl3pWNc5JYTg6hbCbNLm8diue9qWDNJl+Qv+NQsnLC7TMr4
 NgYjWJXKPmE4RpEXYK+54TpqRun4ok0FRw+sez9Hz8Bt4mRGYCGk5ZEZqxm1VpcBsTQb
 PAXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1709847797; x=1710452597;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=MfK7W5gmvT+g0XsJfqW1j3QuE+eaaW8RgalDvnquAys=;
 b=l8LMvlC20mlpbibrP4nOyWRLnM3A29snBqXnPLJbYTuT0YQhAs0cZKEix4pT9b9qP0
 q4/ig9ZTeWpOc3Cb7plDay9nZgatfp+YbcFKNrL2ZWqIO0V8pHpT8F8bn/vxcnNGhKOx
 pRw7JGpq/y92XHsY1FcJkO52WG6iYzfEL4RbnZfXn/c+B58obeiVK36yMfN64/Vfh6JQ
 HJcJJc5VYU0zx/yWyWhGZSafyCdTE8jC538LlS0BPRajWdaSa4bJwZeG0m2kvozgJmQa
 TcIt9p2xUhxLr0xHHyTGpYzj2tv54OIQ5am2C0lwl7vSkeG6ctq1GX7e333STIoxNgTA
 PCyA==
X-Forwarded-Encrypted: i=1;
 AJvYcCVoKKi2ZIesqaGidYPb2VYBkQrrgD73p+Z6l0hdlHXrHGBMopKyOhp0Qqvqk4CAbsRtkAdON3P1796gY5tNdMe5qq/MYEY=
X-Gm-Message-State: AOJu0Yyxj0swTQ+MXlkiiaDeHq/5jV/VlQmnMaH/EYu0PQicyxfie5Zb
 xr0hzMRsJPJ1HBcbCbDabm6Q3UgzoxD+8v6bNpdZKqj86POqMtpHQojZ5q3Ju0M=
X-Google-Smtp-Source: AGHT+IFzY53NaXnvaDMrTnW6KAyzNJf8LjMNfS43Qh/+YnZb/eQLoYo3cKQHBBErA1fB1yfnmtuCBg==
X-Received: by 2002:a17:902:76c4:b0:1dd:8fe:cca5 with SMTP id
 j4-20020a17090276c400b001dd08fecca5mr9153279plt.47.1709847797611; 
 Thu, 07 Mar 2024 13:43:17 -0800 (PST)
Received: from [192.168.68.110] ([177.94.15.159])
 by smtp.gmail.com with ESMTPSA id
 lc8-20020a170902fa8800b001dc8923a2c4sm15163849plb.294.2024.03.07.13.43.14
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 07 Mar 2024 13:43:16 -0800 (PST)
Message-ID: <18c0b9a4-2965-4897-9034-833530e99970@ventanamicro.com>
Date: Thu, 7 Mar 2024 18:43:12 -0300
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] target/riscv: Implement dynamic establishment of custom
 decoder
Content-Language: en-US
To: Richard Henderson <richard.henderson@linaro.org>,
 Huang Tao <eric.huang@linux.alibaba.com>, qemu-devel@nongnu.org
Cc: qemu-riscv@nongnu.org, zhiwei_liu@linux.alibaba.com, liwei1518@gmail.com, 
 bin.meng@windriver.com, alistair.francis@wdc.com, palmer@dabbelt.com,
 Christoph Muellner <christoph.muellner@vrull.eu>
References: <20240306093308.35188-1-eric.huang@linux.alibaba.com>
 <9b9c1af9-5dca-4270-8dfe-a62223c8cbbb@ventanamicro.com>
 <d86b22f7-e601-4bd0-9edc-88d84f572595@linaro.org>
From: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
In-Reply-To: <d86b22f7-e601-4bd0-9edc-88d84f572595@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62a;
 envelope-from=dbarboza@ventanamicro.com; helo=mail-pl1-x62a.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=unavailable autolearn_force=no
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



On 3/7/24 17:11, Richard Henderson wrote:
> On 3/7/24 09:55, Daniel Henrique Barboza wrote:
>> (--- adding Richard ---)
>>
>>
>> On 3/6/24 06:33, Huang Tao wrote:
>>> In this patch, we modify the decoder to be a freely composable data
>>> structure instead of a hardcoded one. It can be dynamically builded up
>>> according to the extensions.
>>> This approach has several benefits:
>>> 1. Provides support for heterogeneous cpu architectures. As we add decoder in
>>>     CPUArchState, each cpu can have their own decoder, and the decoders can be
>>>     different due to cpu's features.
>>> 2. Improve the decoding efficiency. We run the guard_func to see if the decoder
>>>     can be added to the dynamic_decoder when building up the decoder. Therefore,
>>>     there is no need to run the guard_func when decoding each instruction. It can
>>>     improve the decoding efficiency
>>> 3. For vendor or dynamic cpus, it allows them to customize their own decoder
>>>     functions to improve decoding efficiency, especially when vendor-defined
>>>     instruction sets increase. Because of dynamic building up, it can skip the other
>>>     decoder guard functions when decoding.
>>>
>>> Signed-off-by: Huang Tao <eric.huang@linux.alibaba.com>
>>> Suggested-by: Christoph Muellner <christoph.muellner@vrull.eu>
>>> Co-authored-by: LIU Zhiwei <zhiwei_liu@linux.alibaba.com>
>>> ---
>>>   target/riscv/cpu.c         | 20 ++++++++++++++++++++
>>>   target/riscv/cpu.h         |  2 ++
>>>   target/riscv/cpu_decoder.h | 34 ++++++++++++++++++++++++++++++++++
>>>   target/riscv/translate.c   | 28 ++++++++++++----------------
>>>   4 files changed, 68 insertions(+), 16 deletions(-)
>>>   create mode 100644 target/riscv/cpu_decoder.h
>>>
>>> diff --git a/target/riscv/cpu.c b/target/riscv/cpu.c
>>> index 5ff0192c52..cadcd51b4f 100644
>>> --- a/target/riscv/cpu.c
>>> +++ b/target/riscv/cpu.c
>>> @@ -38,6 +38,7 @@
>>>   #include "kvm/kvm_riscv.h"
>>>   #include "tcg/tcg-cpu.h"
>>>   #include "tcg/tcg.h"
>>> +#include "cpu_decoder.h"
>>>   /* RISC-V CPU definitions */
>>>   static const char riscv_single_letter_exts[] = "IEMAFDQCBPVH";
>>> @@ -1102,6 +1103,23 @@ static void riscv_cpu_satp_mode_finalize(RISCVCPU *cpu, Error **errp)
>>>   }
>>>   #endif
>>> +static void riscv_cpu_finalize_dynamic_decoder(RISCVCPU *cpu)
>>> +{
>>> +    CPURISCVState *env = &cpu->env;
>>> +    decode_fn *dynamic_decoder;
>>> +    dynamic_decoder = g_new0(decode_fn, decoder_table_size);
>>> +    int j = 0;
>>> +    for (size_t i = 0; i < decoder_table_size; ++i) {
>>> +        if (decoder_table[i].guard_func &&
>>> +            decoder_table[i].guard_func(&cpu->cfg)) {
>>> +            dynamic_decoder[j] = decoder_table[i].decode_fn;
>>> +            j++;
>>> +        }
>>> +    }
>>> +
>>> +    env->decoder = dynamic_decoder;

In time: I think we should rename this to 'decoders' to make it easier to figure out
that it's an array instead of a single element. Same thing with the ctx->decoder pointer.

> 
> You should save J into ENV as well, or use GPtrArray which would carry the length along with it naturally.
> 
> Is the cpu configuration on each cpu, or on the cpu class?
> 
> Even if the configuration is per cpu, this new element belongs in ArchCPU not CPUArchState.  Usually all of CPUArchState is zeroed during reset.
> 
>>> @@ -1153,9 +1149,8 @@ static void decode_opc(CPURISCVState *env, DisasContext *ctx, uint16_t opcode)
>>>                                                ctx->base.pc_next + 2));
>>>           ctx->opcode = opcode32;
>>> -        for (size_t i = 0; i < ARRAY_SIZE(decoders); ++i) {
>>> -            if (decoders[i].guard_func(ctx->cfg_ptr) &&
>>> -                decoders[i].decode_func(ctx, opcode32)) {
>>> +        for (size_t i = 0; i < decoder_table_size; ++i) {
>>> +            if (ctx->decoder[i](ctx, opcode32)) {
>>>                   return;
> 
> You definitely should not be using decoder_table_size here, because you eliminated elements, which are in fact NULL here.
> 
>> Am I missing something? It seems we can just remove the ctx->decode pointer altogether
>> and use env->decoder.
> 
> We try to avoid placing env into DisasContext, so that it is much harder to make the mistake of referencing env fields at translation-time, when you really needed to generate tcg code to reference the fields at runtime.

Right. And you mentioned that ArchState isn't the ideal place and we should put the
decoders in ArchCPU, so there's that.

In this case, if we were not to use ctx->decoders, we would need to retrieve a RISCVCPU
in riscv_tr_translate_insn() to get access to them ....


I'd rather keep ctx->decoders and assign it in tr_init_disas() since that function already
uses a RISCVCPU pointer. The extra pointer in DisasContext seems worthy in this case.


Thanks,

Daniel





> 
> 
> 
> r~
> 

