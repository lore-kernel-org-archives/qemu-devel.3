Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 155EBC54E4A
	for <qemu-devel@archiver.kernel.org>; Thu,  7 Mar 2024 20:11:58 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1riK5J-00048s-So; Thu, 07 Mar 2024 15:11:21 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1riK5G-000484-3A
 for qemu-devel@nongnu.org; Thu, 07 Mar 2024 15:11:18 -0500
Received: from mail-pf1-x431.google.com ([2607:f8b0:4864:20::431])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1riK5E-0002k3-96
 for qemu-devel@nongnu.org; Thu, 07 Mar 2024 15:11:17 -0500
Received: by mail-pf1-x431.google.com with SMTP id
 d2e1a72fcca58-6e5b1c6daa3so98361b3a.1
 for <qemu-devel@nongnu.org>; Thu, 07 Mar 2024 12:11:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1709842274; x=1710447074; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=JFJT6F1ZxJBQ41DTlkQDFYaRyoAVvShkS3Vpj+OOKHo=;
 b=FOC2bB49G+7cPrA8CYv8LyspzFxnUb4Fefqz9R/Q/IbwyJOPQ8jetwarOQ+IpSRup+
 VxH90BeIvO+riXRNwEln+/xRw8aUtzMOihsE86O//uoxD54vbNJMo8+iQ+344d6eUCoM
 3d+aFl4p9x0P3qbUGQUyVXhIWTZlUKC8iEm5qVEmwKe7vUdz/B6uFAsqjzSsoeEJzpkI
 C57X2VCrZi2z1pveiZllzKxRuK2/KLsNqIGHA9PJFNKlkOipsGOJ9miELYuvtm6NpUYN
 QaWIglpSPYYRa0DeGkNm7DwqLBRpar06W5LVRJxvws5qYjp7NRZWar/EjIJ8XeQ892Uk
 vgfQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1709842274; x=1710447074;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=JFJT6F1ZxJBQ41DTlkQDFYaRyoAVvShkS3Vpj+OOKHo=;
 b=xPGJnaXSGuywvHtl+tAy1iY7sIMbiK82CjAn5uh3mUSMiklI4ogqqKXmcwSNkDos+2
 MZVsn05C+qf5JZdvnV5Dim8QqxNkihCbzfioaLtSctEveoO7Iexf0w/MGQGwx0PtGX9q
 DjCR5u9LUIZfRXJrrMKnzvSdX2NZ+WssVMPMfWpJK42esKzfXL8fXQvhRfPJayh6kyIO
 Ik0nRJyQ6IEoRZu3x+tOd6U5kde7YNmtKMj0AHDQdfSU/v4i6txi8SwFYT691we5Hdwl
 JHdQogq1ZjDvv+1RW1ulxJYp0ZNNREEulS3hBgbqBzk4MmfB9Gvo1o5Ulk+HFYel711F
 pNqQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCVQqVtlvMw52MR1oVOlS2ZpXGUez706gk4Ws18sP0niCQ/AlRqyzhErplbgJnwyHmrMQH+Nd0zF1HASaeoJ1omwL6Sedgc=
X-Gm-Message-State: AOJu0YyKRm4ngHZogEcwEkQpV/rUSJ2X8cQWo1FwFDpcA4SvJnIkF/2A
 6c6ZyzMSxBmQrdw9SgdLQw0J0K65t3MlUAv7tURiylGnVad1/t+/YxU6g21YAKI=
X-Google-Smtp-Source: AGHT+IEgqbqK570AM379ihum2AxWVdrt6e2KDdLPnrDBkJ48MxjsJWhUrpyf3zW80IY/+A7Cw1Ej9A==
X-Received: by 2002:a05:6a00:190e:b0:6e6:4647:998e with SMTP id
 y14-20020a056a00190e00b006e64647998emr9122744pfi.8.1709842274472; 
 Thu, 07 Mar 2024 12:11:14 -0800 (PST)
Received: from [192.168.6.128] (098-147-055-211.res.spectrum.com.
 [98.147.55.211]) by smtp.gmail.com with ESMTPSA id
 s62-20020a625e41000000b006e612df4627sm8422093pfb.39.2024.03.07.12.11.12
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 07 Mar 2024 12:11:14 -0800 (PST)
Message-ID: <d86b22f7-e601-4bd0-9edc-88d84f572595@linaro.org>
Date: Thu, 7 Mar 2024 10:11:09 -1000
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] target/riscv: Implement dynamic establishment of custom
 decoder
Content-Language: en-US
To: Daniel Henrique Barboza <dbarboza@ventanamicro.com>,
 Huang Tao <eric.huang@linux.alibaba.com>, qemu-devel@nongnu.org
Cc: qemu-riscv@nongnu.org, zhiwei_liu@linux.alibaba.com, liwei1518@gmail.com, 
 bin.meng@windriver.com, alistair.francis@wdc.com, palmer@dabbelt.com,
 Christoph Muellner <christoph.muellner@vrull.eu>
References: <20240306093308.35188-1-eric.huang@linux.alibaba.com>
 <9b9c1af9-5dca-4270-8dfe-a62223c8cbbb@ventanamicro.com>
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <9b9c1af9-5dca-4270-8dfe-a62223c8cbbb@ventanamicro.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::431;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x431.google.com
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

On 3/7/24 09:55, Daniel Henrique Barboza wrote:
> (--- adding Richard ---)
> 
> 
> On 3/6/24 06:33, Huang Tao wrote:
>> In this patch, we modify the decoder to be a freely composable data
>> structure instead of a hardcoded one. It can be dynamically builded up
>> according to the extensions.
>> This approach has several benefits:
>> 1. Provides support for heterogeneous cpu architectures. As we add decoder in
>>     CPUArchState, each cpu can have their own decoder, and the decoders can be
>>     different due to cpu's features.
>> 2. Improve the decoding efficiency. We run the guard_func to see if the decoder
>>     can be added to the dynamic_decoder when building up the decoder. Therefore,
>>     there is no need to run the guard_func when decoding each instruction. It can
>>     improve the decoding efficiency
>> 3. For vendor or dynamic cpus, it allows them to customize their own decoder
>>     functions to improve decoding efficiency, especially when vendor-defined
>>     instruction sets increase. Because of dynamic building up, it can skip the other
>>     decoder guard functions when decoding.
>>
>> Signed-off-by: Huang Tao <eric.huang@linux.alibaba.com>
>> Suggested-by: Christoph Muellner <christoph.muellner@vrull.eu>
>> Co-authored-by: LIU Zhiwei <zhiwei_liu@linux.alibaba.com>
>> ---
>>   target/riscv/cpu.c         | 20 ++++++++++++++++++++
>>   target/riscv/cpu.h         |  2 ++
>>   target/riscv/cpu_decoder.h | 34 ++++++++++++++++++++++++++++++++++
>>   target/riscv/translate.c   | 28 ++++++++++++----------------
>>   4 files changed, 68 insertions(+), 16 deletions(-)
>>   create mode 100644 target/riscv/cpu_decoder.h
>>
>> diff --git a/target/riscv/cpu.c b/target/riscv/cpu.c
>> index 5ff0192c52..cadcd51b4f 100644
>> --- a/target/riscv/cpu.c
>> +++ b/target/riscv/cpu.c
>> @@ -38,6 +38,7 @@
>>   #include "kvm/kvm_riscv.h"
>>   #include "tcg/tcg-cpu.h"
>>   #include "tcg/tcg.h"
>> +#include "cpu_decoder.h"
>>   /* RISC-V CPU definitions */
>>   static const char riscv_single_letter_exts[] = "IEMAFDQCBPVH";
>> @@ -1102,6 +1103,23 @@ static void riscv_cpu_satp_mode_finalize(RISCVCPU *cpu, Error 
>> **errp)
>>   }
>>   #endif
>> +static void riscv_cpu_finalize_dynamic_decoder(RISCVCPU *cpu)
>> +{
>> +    CPURISCVState *env = &cpu->env;
>> +    decode_fn *dynamic_decoder;
>> +    dynamic_decoder = g_new0(decode_fn, decoder_table_size);
>> +    int j = 0;
>> +    for (size_t i = 0; i < decoder_table_size; ++i) {
>> +        if (decoder_table[i].guard_func &&
>> +            decoder_table[i].guard_func(&cpu->cfg)) {
>> +            dynamic_decoder[j] = decoder_table[i].decode_fn;
>> +            j++;
>> +        }
>> +    }
>> +
>> +    env->decoder = dynamic_decoder;

You should save J into ENV as well, or use GPtrArray which would carry the length along 
with it naturally.

Is the cpu configuration on each cpu, or on the cpu class?

Even if the configuration is per cpu, this new element belongs in ArchCPU not 
CPUArchState.  Usually all of CPUArchState is zeroed during reset.

>> @@ -1153,9 +1149,8 @@ static void decode_opc(CPURISCVState *env, DisasContext *ctx, 
>> uint16_t opcode)
>>                                                ctx->base.pc_next + 2));
>>           ctx->opcode = opcode32;
>> -        for (size_t i = 0; i < ARRAY_SIZE(decoders); ++i) {
>> -            if (decoders[i].guard_func(ctx->cfg_ptr) &&
>> -                decoders[i].decode_func(ctx, opcode32)) {
>> +        for (size_t i = 0; i < decoder_table_size; ++i) {
>> +            if (ctx->decoder[i](ctx, opcode32)) {
>>                   return;

You definitely should not be using decoder_table_size here, because you eliminated 
elements, which are in fact NULL here.

> Am I missing something? It seems we can just remove the ctx->decode pointer altogether
> and use env->decoder.

We try to avoid placing env into DisasContext, so that it is much harder to make the 
mistake of referencing env fields at translation-time, when you really needed to generate 
tcg code to reference the fields at runtime.



r~


