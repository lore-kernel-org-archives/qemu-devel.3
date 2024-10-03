Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 61133CF34BD
	for <qemu-devel@archiver.kernel.org>; Thu,  3 Oct 2024 18:10:56 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1swQHX-0003op-QI; Thu, 03 Oct 2024 14:10:31 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1swQHW-0003mU-1l
 for qemu-devel@nongnu.org; Thu, 03 Oct 2024 14:10:30 -0400
Received: from mail-pl1-x635.google.com ([2607:f8b0:4864:20::635])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1swQHU-0006xJ-9u
 for qemu-devel@nongnu.org; Thu, 03 Oct 2024 14:10:29 -0400
Received: by mail-pl1-x635.google.com with SMTP id
 d9443c01a7336-20bb39d97d1so11342405ad.2
 for <qemu-devel@nongnu.org>; Thu, 03 Oct 2024 11:10:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1727979026; x=1728583826; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=wlExpvMTsPp3gUtX3rXfzKJzkoOyoB0lLS5DEqxnYeE=;
 b=Hj05F+uRbomWSxWiiVxPV/L0KVzKZ0gjbdOltAAcb6ilvf/QczHGCQjWxH26bK0PmV
 XveMQGMhP7RCFH6uiGuFihaUgp7/RrrI2ULQmo/ANdTahkDlLKuoPSIpKU7sdcnpKa3E
 2An5n5QJepbrb7s6UzSXADLlbpu3On+Z4QOzq6qvFn49SdeoHw1LZj6/RYbktXOK2mXe
 15LTO9mTHTgpC6GzCeMw8WO1DHFnW5fJn05xjTwULbbNKBQhTC1T+5eBJMeRzZy/YX8g
 GHDrkOZvZTXbS3ed56/pFWSwJPx4NagDarf6O4Lalb1mUzBqMaArbBNBfeuOo9Z1s/AH
 IwkQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1727979026; x=1728583826;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=wlExpvMTsPp3gUtX3rXfzKJzkoOyoB0lLS5DEqxnYeE=;
 b=NQULm6L6ezqJFUzAzHm71F+r5j+uxUz78qZi7NP0nPcarvoiF1ED21ROSp43nJq/js
 iw2poR14ug1BvaaM8KgPADy3itedH4luBAfZvJQzSoZ6io/LgMptuAhZG/rTRJWvS4Aq
 DK33EdGWKb3zJaW8ZXwS0mfwtq2hCVKi8KrS82vweJygauzbxJlZhc9CvXpE6lP15P0q
 oPPr3GtGoW9p09N8wrztIdvBVMmeenwAMD4aQ2jzWNTi2/tTzrDWYPEAW0o/Tp6wmsJ9
 +KHEljq9bUV+2A8bg/kOANpJ/HcR+xd67oWqBVCUoINbiOu+KPoikkcBYwVKKRyvPPJs
 HwEg==
X-Forwarded-Encrypted: i=1;
 AJvYcCWLeA4U24bh5P2jrCtTaxGq7xqg15mzMO8GwJZlNi1I68poxsOXkaiMT6ZAN3+DqD6iiIxbk9q5bMwB@nongnu.org
X-Gm-Message-State: AOJu0Yy4HhysfKoq7EcwX7PLbaukCQYCp4OcZPA5Te9JNISx0vi+1oYq
 ELMsziJuSVJNunCSXihTAR/ncNsjIV8NbqRzwfh/QuNYdj2Olam9+K+JjKH8bJU=
X-Google-Smtp-Source: AGHT+IFYO76hNNAtpQEv3crXMRlJHAatZ31D8xb65ApUHIvCMTiYgfhuE2GQnmDOrRKgf59LZSAAvA==
X-Received: by 2002:a17:902:e94e:b0:207:18f5:7e78 with SMTP id
 d9443c01a7336-20bff1c8aaamr654315ad.48.1727979026477; 
 Thu, 03 Oct 2024 11:10:26 -0700 (PDT)
Received: from [192.168.0.4] (174-21-81-121.tukw.qwest.net. [174.21.81.121])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-20bef706e87sm11637075ad.239.2024.10.03.11.10.25
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 03 Oct 2024 11:10:26 -0700 (PDT)
Message-ID: <8920d4e9-9289-4a7d-be04-ff0f60806e78@linaro.org>
Date: Thu, 3 Oct 2024 11:10:24 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 09/12] target/arm: Implement the SETG* instructions
To: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Peter Maydell <peter.maydell@linaro.org>,
 Gustavo Romero <gustavo.romero@linaro.org>
Cc: qemu-arm@nongnu.org, qemu-devel@nongnu.org, Anton Johansson <anjo@rev.ng>
References: <20230912140434.1333369-1-peter.maydell@linaro.org>
 <20230912140434.1333369-10-peter.maydell@linaro.org>
 <7c750b58-e845-4d80-b5a5-7eda8f505fb6@linaro.org>
Content-Language: en-US
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <7c750b58-e845-4d80-b5a5-7eda8f505fb6@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::635;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x635.google.com
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

On 9/24/24 12:14, Philippe Mathieu-Daudé wrote:
> Hi Peter,
> 
> (patch merged as commit 6087df574400659226861fa5ba47970f1fbd277b).
> 
> On 12/9/23 16:04, Peter Maydell wrote:
>> The FEAT_MOPS SETG* instructions are very similar to the SET*
>> instructions, but as well as setting memory contents they also
>> set the MTE tags. They are architecturally required to operate
>> on tag-granule aligned regions only.
>>
>> Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
>> Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
>> ---
>> v2: - separate helper functions calling do_setp/setm/sete
>>      - use cpu_st16_mmu()
> 
> So you replaced the pair of cpu_stq_mmuidx_ra() from v1 by
> cpu_st16_mmu().
> 
>> ---
>>   target/arm/internals.h         | 10 ++++
>>   target/arm/tcg/helper-a64.h    |  3 ++
>>   target/arm/tcg/a64.decode      |  5 ++
>>   target/arm/tcg/helper-a64.c    | 86 ++++++++++++++++++++++++++++++++--
>>   target/arm/tcg/mte_helper.c    | 40 ++++++++++++++++
>>   target/arm/tcg/translate-a64.c | 20 +++++---
>>   6 files changed, 155 insertions(+), 9 deletions(-)
> 
> 
>> +/*
>> + * Similar, but setting tags. The architecture requires us to do this
>> + * in 16-byte chunks. SETP accesses are not tag checked; they set
>> + * the tags.
>> + */
>> +static uint64_t set_step_tags(CPUARMState *env, uint64_t toaddr,
>> +                              uint64_t setsize, uint32_t data, int memidx,
>> +                              uint32_t *mtedesc, uintptr_t ra)
>> +{
>> +    void *mem;
>> +    uint64_t cleanaddr;
>> +
>> +    setsize = MIN(setsize, page_limit(toaddr));
>> +
>> +    cleanaddr = useronly_clean_ptr(toaddr);
>> +    /*
>> +     * Trapless lookup: returns NULL for invalid page, I/O,
>> +     * watchpoints, clean pages, etc.
>> +     */
>> +    mem = tlb_vaddr_to_host(env, cleanaddr, MMU_DATA_STORE, memidx);
>> +
>> +#ifndef CONFIG_USER_ONLY
>> +    if (unlikely(!mem)) {
>> +        /*
>> +         * Slow-path: just do one write. This will handle the
>> +         * watchpoint, invalid page, etc handling correctly.
>> +         * The architecture requires that we do 16 bytes at a time,
>> +         * and we know both ptr and size are 16 byte aligned.
>> +         * For clean code pages, the next iteration will see
>> +         * the page dirty and will use the fast path.
>> +         */
>> +        uint64_t repldata = data * 0x0101010101010101ULL;
>> +        MemOpIdx oi16 = make_memop_idx(MO_TE | MO_128, memidx);
> 
> I'm trying to understand the MO_TE use, but I'm not seeing it in
> https://developer.arm.com/documentation/ddi0602/2024-06/Base-Instructions/SETGP--SETGM-- 
> SETGE--Memory-set-with-tag-setting-
> pseudo code. I also checked
> https://developer.arm.com/documentation/ddi0602/2024-06/Shared-Pseudocode/aarch64- 
> functions-mops?lang=en#impl-aarch64.MemSetBytes.4
> and https://developer.arm.com/documentation/ddi0602/2024-06/Shared-Pseudocode/aarch64- 
> functions-memory?lang=en#AArch64.MemSingleWrite.5

It's not actually needed.  All of the bytes stored are identical (see the construction of 
repldata).

Removing MO_TE will store the bytes in host byte order, which will avoid an unnecessary 
bswap on big-endian hosts.

The stores here are all from

     while tagstep > 0 do
         tagaddr = memset.toaddress + memset.setsize + (tagstep - 1) * 16;
         AArch64.MemTag[tagaddr, accdesc] = tag;
         tagstep = tagstep - 1;


r~

