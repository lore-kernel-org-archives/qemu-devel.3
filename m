Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5BB26C47DD9
	for <qemu-devel@archiver.kernel.org>; Sun, 24 Mar 2024 23:38:57 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1roXPp-0003YD-LL; Sun, 24 Mar 2024 19:38:13 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1roXPn-0003Y1-QR
 for qemu-devel@nongnu.org; Sun, 24 Mar 2024 19:38:11 -0400
Received: from mail-pf1-x436.google.com ([2607:f8b0:4864:20::436])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1roXPm-0001Zb-9j
 for qemu-devel@nongnu.org; Sun, 24 Mar 2024 19:38:11 -0400
Received: by mail-pf1-x436.google.com with SMTP id
 d2e1a72fcca58-6ea7f2d093aso2122199b3a.3
 for <qemu-devel@nongnu.org>; Sun, 24 Mar 2024 16:38:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1711323488; x=1711928288; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:references:cc:to:from
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=6cUxaXdK/kmujnddbeaGBXzh1jEQ3cbj7Ib3DWDF+2w=;
 b=L0bMFyvIgvPZ7dlCxw+HsQKShs/5frwYhwnuRPlDW/BaMlqVcb9Ay0b8HNBfe7Q5xK
 P6zktsOVl0RvKa2E595nMoyriGXISRxWrrcaVHzHNH9LV5Tb3WXPsHs5M+y8/DLMJvTK
 0rQXjjcvBtRkuUUyPm3CkrP3Q8ti2iRS5JE3+ROz3CZbVUNKf9Nb4A9AKz2ZiZql0v5P
 44NYi6k0kkaY47OOxR2xbVGgIt6sRKyCQnexwt4cfzFgMVRYsmhXi0o0kp9xa6s9oR8Z
 4nAsVuHySFUtWtEixm0T6/Sqf4/MxOR5gM6My8r86D81VBHt9zB0j065f8JNjPJddimV
 JEEA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1711323488; x=1711928288;
 h=content-transfer-encoding:in-reply-to:references:cc:to:from
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=6cUxaXdK/kmujnddbeaGBXzh1jEQ3cbj7Ib3DWDF+2w=;
 b=M5oI59bv3/n0WcDIR/WBgttKdmkv08UrZx0UHfP7hT2c6iRg8jK9e+1lUDCrYu8yet
 mGFNCQqW8NdkQwjBt8hcgd6a0XYYYRUSaMCdVjZuC2dCcmY5tQf9OummFjT0Yz5VLkPY
 si7Tuls4nOlfPv7GPY8MwqEvhLdL3+kN+mHKtPXlk1arAoMRVGrcvwuUkmNPswfN8Y/w
 zGvDfrnzxqSVpoPuCcHLgMrpdnAKG3YNer3vDwbZc6yeV7gKNu0XK2EXZnhG4LKFQRL5
 Z/mzFAJiFtliwkoMAyEHiAX+TG1jPC1dap20fGe08TwcqYwfH7O6/9x4bHx4QtxMrudu
 0LmA==
X-Gm-Message-State: AOJu0Yww0WHHWlk1Vs63DzDSe50hQQX2b3zAWILt26QoAAMpD28zgzW8
 wJdQwc3kKzLkDh4oj8Jq73b12/EStr/3+rxO8DHnrLrE2pUsYo/Q58lQC+ilSNI=
X-Google-Smtp-Source: AGHT+IHn/0l4ubVKqawgK5X0Z+/wGtezNBisptkJoXo4eJK1wYImfUVpWCbV9Ha8kxTrpmI4dtz/AA==
X-Received: by 2002:a05:6a00:1949:b0:6ea:ab48:5dd9 with SMTP id
 s9-20020a056a00194900b006eaab485dd9mr1769162pfk.6.1711323488562; 
 Sun, 24 Mar 2024 16:38:08 -0700 (PDT)
Received: from [172.20.1.19] (173-197-098-125.biz.spectrum.com.
 [173.197.98.125]) by smtp.gmail.com with ESMTPSA id
 du12-20020a056a002b4c00b006e6813f2301sm3136880pfb.56.2024.03.24.16.38.07
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sun, 24 Mar 2024 16:38:08 -0700 (PDT)
Message-ID: <1502f024-a384-4c2f-aa2f-de63bcdd97f9@linaro.org>
Date: Sun, 24 Mar 2024 13:38:05 -1000
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 3/3] target/hppa: fix building gva for wide mode
Content-Language: en-US
From: Richard Henderson <richard.henderson@linaro.org>
To: Sven Schnelle <svens@stackframe.org>
Cc: qemu-devel@nongnu.org, Helge Deller <deller@gmx.de>
References: <20240324080945.991100-1-svens@stackframe.org>
 <20240324080945.991100-4-svens@stackframe.org>
 <c26dd647-bf03-4ade-8266-e1c653554110@linaro.org>
In-Reply-To: <c26dd647-bf03-4ade-8266-e1c653554110@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::436;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x436.google.com
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

On 3/24/24 11:39, Richard Henderson wrote:
> On 3/23/24 22:09, Sven Schnelle wrote:
>> 64 Bit hppa no longer has a fixed 32/32 bit split between space and
>> offset. Instead it uses 42 bits for the offset. The lower 10 bits of
>> the space are always zero, leaving 22 bits actually used. Simply or
>> the values together to build the gva.
>>
>> Signed-off-by: Sven Schnelle <svens@stackframe.org>
>> ---
>>   target/hppa/mem_helper.c | 13 +++++++------
>>   1 file changed, 7 insertions(+), 6 deletions(-)
>>
>> diff --git a/target/hppa/mem_helper.c b/target/hppa/mem_helper.c
>> index 84785b5a5c..6f895fced7 100644
>> --- a/target/hppa/mem_helper.c
>> +++ b/target/hppa/mem_helper.c
>> @@ -523,13 +523,16 @@ void HELPER(itlbp_pa11)(CPUHPPAState *env, target_ulong addr, 
>> target_ulong reg)
>>   }
>>   static void itlbt_pa20(CPUHPPAState *env, target_ulong r1,
>> -                       target_ulong r2, vaddr va_b)
>> +                       target_ulong r2, uint64_t spc, uint64_t off)
>>   {
>>       HPPATLBEntry *ent;
>> -    vaddr va_e;
>> +    vaddr va_b, va_e;
>>       uint64_t va_size;
>>       int mask_shift;
>> +    va_b = off & gva_offset_mask(env->psw);
>> +    va_b |= spc << 32;
> 
> Actually, no, these instructions don't form a GVA in the normal fashion:
> 
> space ← ISR;
> offset ← cat(ISR{32..63},IOR{32..63});
> VIRTUAL_ADDR ← (space<<32) | (offset);
> 
>> -    vaddr va_b = deposit64(env->cr[CR_IOR], 32, 32, env->cr[CR_ISR]);
> 
> But this is wrong too.

Actually, no.  The

   VIRTUAL_ADDR = (space << 32) | offset

line constructs a 96-bit virtual address.  The low 32 bits of ISR have already replaced 
the high 32 bits of IOR, so this line really only adds the high 32 bits of space as bits 
[96:64] of the full virtual address.

Truncated to 64 bits, the deposit as written is exactly right.


r~

