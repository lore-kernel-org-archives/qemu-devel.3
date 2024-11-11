Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3ADAFD3ABC9
	for <qemu-devel@archiver.kernel.org>; Mon, 11 Nov 2024 16:05:40 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tAWuA-0002BR-DA; Mon, 11 Nov 2024 11:04:42 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <paolo.savini@embecosm.com>)
 id 1tAWu8-0002BA-UN
 for qemu-devel@nongnu.org; Mon, 11 Nov 2024 11:04:40 -0500
Received: from mail-wm1-x335.google.com ([2a00:1450:4864:20::335])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <paolo.savini@embecosm.com>)
 id 1tAWu7-0001al-81
 for qemu-devel@nongnu.org; Mon, 11 Nov 2024 11:04:40 -0500
Received: by mail-wm1-x335.google.com with SMTP id
 5b1f17b1804b1-4315839a7c9so44443805e9.3
 for <qemu-devel@nongnu.org>; Mon, 11 Nov 2024 08:04:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=embecosm.com; s=google; t=1731341077; x=1731945877; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:subject:autocrypt:from
 :content-language:references:cc:to:user-agent:mime-version:date
 :message-id:from:to:cc:subject:date:message-id:reply-to;
 bh=QtgyJ5TvmwCZVv/R6BE3vSx9eApn96ZhY9WwSKf5umk=;
 b=djnQ/ZP5YRwXsC1KgmreG1MQ5gO1A7MOZakmmQtja8DeK3XPFxRbqEIv51fCUYdomt
 SAbw4QU6cYOnlI6pbUPHcwzQDjWx0ZX700iZsY+WWXTztObGONcwwwfZH6BvQLcb5rt+
 nVY1dTxsc/05zylIc/oHeOxIlSSmQTUzijh1fVhMXcCDZusLJdAp6LcdPBGpNJm0jemP
 lL6A0Wb4KGIwSfeTuP4jyMSErytJDdcXXzPB5IRCrIdPq/DpJDKz/UzDr//lx9pVf8pg
 IY0TSuLITcXoYlbNUtwDZ7kD4un7Q3gV+QEjBZXZepFICe/N3tEuAUCNVeU+dvOp+G8i
 qvpA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1731341077; x=1731945877;
 h=content-transfer-encoding:in-reply-to:subject:autocrypt:from
 :content-language:references:cc:to:user-agent:mime-version:date
 :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=QtgyJ5TvmwCZVv/R6BE3vSx9eApn96ZhY9WwSKf5umk=;
 b=H/WFJ46jlVOlgwCQsFMnXFKtqzfNdCRKHpDO3q/AQc1j3+d0A3HSfdcsKuEkkPk3Kc
 OV+8IlPuabv+0a7NAyLwvtRBZFBqvS89fGCU4PU36gN6o4qM4DWzRSG7L+W74EtF+OdP
 dUjHACTQ7QjeyE3PSbjkNajkOa90b/eWzfku+dPJkMitF32lFdyYcEwjFeyU10C3mAX0
 zSvP8nflg6BfqRrtFLPwcjoSHQsrt0ih7rTY1INorJR9LTsxUdOGqS/7ssXMo97ZgRZl
 x1Ag4dkjdtWRRaaUA/N9yyFuVz/qEl8FFO0lu3rYG88a2EBwR9sxkPZamBRAVWUkhWkZ
 qMkA==
X-Forwarded-Encrypted: i=1;
 AJvYcCVysfTdA3ByV8PPL/FskH7afzSMSpuJzstdnstUiKp+HoO57F7qviIj7USU5arfzeWoo+RuZ20v/gRw@nongnu.org
X-Gm-Message-State: AOJu0Yy55191whoDnZcqmiprUov7C+crFvX/npIeyXnDHd89fUGKprJz
 ayjnELh/71d9OxX94zvkBa3IMvAb4voo2k92qdfIujBTvruiBRRWm+BxQ2UAVbw=
X-Google-Smtp-Source: AGHT+IG1LIgUMh3FQyS9f54sD+AYG4R9xEJCU+zUnqeMHId55I+2j08bQEKNqTCh07erRKG5UVueNA==
X-Received: by 2002:a05:600c:510c:b0:426:647b:1bfc with SMTP id
 5b1f17b1804b1-432b751cb7cmr111906175e9.30.1731341075848; 
 Mon, 11 Nov 2024 08:04:35 -0800 (PST)
Received: from [192.168.0.124] ([212.69.42.53])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-432b0562ccdsm176928395e9.23.2024.11.11.08.04.35
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 11 Nov 2024 08:04:35 -0800 (PST)
Message-ID: <a9f51b76-1cd7-405f-b4a7-384c7447ff88@embecosm.com>
Date: Mon, 11 Nov 2024 16:04:35 +0000
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: Richard Henderson <richard.henderson@linaro.org>,
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>, qemu-devel@nongnu.org,
 qemu-riscv@nongnu.org
Cc: Palmer Dabbelt <palmer@dabbelt.com>,
 Alistair Francis <alistair.francis@wdc.com>, Bin Meng <bmeng.cn@gmail.com>,
 Weiwei Li <liwei1518@gmail.com>, Liu Zhiwei <zhiwei_liu@linux.alibaba.com>,
 Helene Chelin <helene.chelin@embecosm.com>, Nathan Egge <negge@google.com>,
 Max Chou <max.chou@sifive.com>
References: <20241029194348.59574-1-paolo.savini@embecosm.com>
 <20241029194348.59574-3-paolo.savini@embecosm.com>
 <7a046c99-c4e7-4395-8dc9-9139e9bfba06@linaro.org>
 <96e7601d-14aa-4741-8f6a-ae4a1c397a44@embecosm.com>
 <54c99505-21ef-422c-a7fe-a2d7dabc3d6c@linaro.org>
 <6b06b532-c53f-4b5b-b65d-d54d7c746ffc@ventanamicro.com>
 <230f448b-07f4-413c-9be6-e10a8e55be73@linaro.org>
Content-Language: en-US
From: Paolo Savini <paolo.savini@embecosm.com>
Autocrypt: addr=paolo.savini@embecosm.com; keydata=
 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
Subject: Re: [RFC v4 2/2] target/riscv: rvv: improve performance of RISC-V
 vector loads and stores on large amounts of data.
In-Reply-To: <230f448b-07f4-413c-9be6-e10a8e55be73@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::335;
 envelope-from=paolo.savini@embecosm.com; helo=mail-wm1-x335.google.com
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

Hi Richard, Daniel,

This might be a silly question, but why do we need to ensure atomicity 
when emulating these guest instructions? I might be wrong but I didn't 
see an explicit requirement for the vector instructions to be atomic in 
the documentation of the RISC-V V extension.

Anyway the patches from Max have landed and since one of them already 
uses memcpy() where this patch does and achieves a similar performance 
improvement we should probably drop this particular patch. I'm wondering 
whether we should be concerned about atomicity there too?

https://github.com/qemu/qemu/blob/134b443512825bed401b6e141447b8cdc22d2efe/target/riscv/vector_helper.c#L224

Thanks

Paolo

On 11/8/24 09:11, Richard Henderson wrote:
> On 11/7/24 12:58, Daniel Henrique Barboza wrote:
>> On 11/4/24 9:48 AM, Richard Henderson wrote:
>>> On 10/30/24 15:25, Paolo Savini wrote:
>>>> On 10/30/24 11:40, Richard Henderson wrote:
>>>>>     __builtin_memcpy DOES NOT equal VMOVDQA
>>>> I am aware of this. I took __builtin_memcpy as a generic enough way 
>>>> to emulate loads and stores that should allow several hosts to 
>>>> generate the widest load/store instructions they can and on x86 I 
>>>> see this generates instructions vmovdpu/movdqu that are not always 
>>>> guaranteed to be atomic. x86 though guarantees them to be atomic if 
>>>> the memory address is aligned to 16 bytes.
>>>
>>> No, AMD guarantees MOVDQU is atomic if aligned, Intel does not.
>>> See the comment in util/cpuinfo-i386.c, and the two 
>>> CPUINFO_ATOMIC_VMOVDQ[AU] bits.
>>>
>>> See also host/include/*/host/atomic128-ldst.h, HAVE_ATOMIC128_RO, 
>>> and atomic16_read_ro.
>>> Not that I think you should use that here; it's complicated, and I 
>>> think you're better off relying on the code in accel/tcg/ when more 
>>> than byte atomicity is required.
>>>
>>
>> Not sure if that's what you meant but I didn't find any clear example of
>> multi-byte atomicity using qatomic_read() and friends that would be 
>> closer
>> to what memcpy() is doing here. I found one example in 
>> bdrv_graph_co_rdlock()
>> that seems to use a mem barrier via smp_mb() and qatomic_read() inside a
>> loop, but I don't understand that code enough to say.
>
> Memory barriers provide ordering between loads and stores, but they 
> cannot be used to address atomicity of individual loads and stores.
>
>
>> I'm also wondering if a common pthread_lock() wrapping up these 
>> memcpy() calls
>> would suffice in this case. Even if we can't guarantee that 
>> __builtin_memcpy()
>> will use arch specific vector insns in the host it would already be a 
>> faster
>> path than falling back to fn(...).
>
> Locks would certainly not be faster than calling the accel/tcg function.
>
>
>> In a quick detour, I'm not sure if we really considered how ARM SVE 
>> implements these
>> helpers. E.g gen_sve_str():
>>
>> https://gitlab.com/qemu-project/qemu/-/blob/master/target/arm/tcg/translate-sve.c#L4182 
>>
>
> Note that ARM SVE defines these instructions to have byte atomicity.
>
>
> r~

