Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8B412C28B2E
	for <qemu-devel@archiver.kernel.org>; Thu, 13 Mar 2025 09:58:17 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tsfJr-0008GZ-DZ; Thu, 13 Mar 2025 05:57:39 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tsfJp-0008DN-4A
 for qemu-devel@nongnu.org; Thu, 13 Mar 2025 05:57:37 -0400
Received: from mail-wm1-x336.google.com ([2a00:1450:4864:20::336])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tsfJg-0007Lk-39
 for qemu-devel@nongnu.org; Thu, 13 Mar 2025 05:57:36 -0400
Received: by mail-wm1-x336.google.com with SMTP id
 5b1f17b1804b1-43cef035a3bso4532865e9.1
 for <qemu-devel@nongnu.org>; Thu, 13 Mar 2025 02:57:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1741859846; x=1742464646; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:content-language:references
 :cc:to:from:subject:user-agent:mime-version:date:message-id:from:to
 :cc:subject:date:message-id:reply-to;
 bh=iPWgPIY6I1VKyMeLivzTkC2uSMHMnO4WIIfb+L5CIjM=;
 b=BMYv82+UhWhGPer6FI3E+SUaB08rX+LDm4LScdspZQvFkHA/R8DunF/1t1WYZ21tCq
 mg44oAhMmAGkLvt8HwzZ9noA03QzZ/sL955DNO2Eq3bLkK4e3Lc++K59NJAZy+ag6KuA
 ocgbDxzxDxRkc6kL3MR9kM+f+5lno0oP8HXN4TInJWGwkyTJGRHIaJbthD21YXRtKRBY
 1FI9Hvub5oM6FHIZYQBoqA2nLlU74YfuxY6PFrmDQg30sE2D/Qo211Vd5Lzu96oW2VuT
 9NI6ymvAI6osyJor11PpNKAU6ZULLuxlyM5ONJshCz+Yelu/ctY6igNvfKs/f6eoNanH
 jdJA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1741859846; x=1742464646;
 h=content-transfer-encoding:in-reply-to:content-language:references
 :cc:to:from:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=iPWgPIY6I1VKyMeLivzTkC2uSMHMnO4WIIfb+L5CIjM=;
 b=hECRV/PPVOlC/K6iyJJOiZ/AikRQlV6/BW6M/T3PCiqXPJd9/77g+ezDORS5GFszt4
 LErCw1OVVh7Fa6L0W9tfM2QAC9OQrIZY+Wwy0jFA3lFQgDOVr3q38YzqCq9EHrOLBDYB
 r/uczTIFZprpnIeAHBFaelTzs6gIM4nqGdhvCwfKw9IxguRr8i/FIlByM66pMaydnh8M
 Lep4dDtjJRrTNboyVWaGF/ZbWL76kPe68jxQ5y4eF26hAmST97MoeiYbcKkWMcSTgpmi
 jNMX5WYEx0lBoCMpZr+DxzWZ9fFFUpxWxYj657IDuu/NGUHEItS/a1EyEKN6C1EcO/bY
 LZ9Q==
X-Forwarded-Encrypted: i=1;
 AJvYcCUPATRxmw2ewrlrjc8ss8hCz6XsWCo5qQcd0ipaD2JkCRdDqDthXnhSe0jg4WUf0UGJU+V9Wob2yKxA@nongnu.org
X-Gm-Message-State: AOJu0YxRiIQ6p2yJEg3MQAQYCw3MG6czRhpqD+fxEPpdUVi24waGrGp+
 oRrHIWeGULMKzGRQAqW8gub2NjFDQtsyDBJQAEGYSzwguDtWY31husQ4k+uJFPw=
X-Gm-Gg: ASbGnctcmovUOijZh8gmXcgFe6tvsUaBOeOTLvUp4LgFQJexrBkx50UgSYlU2qmu/GW
 qV6MooHYinRzL+noAYl45YZEflsKhx4yqB8xABK3raobXs75EkesM+Vuu6omgWBhyEQZdwxIoqT
 +VASPLsajvbHHnpDtfgb56vqoq++Ii08VlYylnQcXvKg7Y20VF4UXtuG3HFSKaDWCxJCAsd6/Yo
 x43lh9u2YO60i4/Rd7xI1m17ULhCsBdiMfpPmC/dA0smlePTABRQ7SI2BbdBAHoGDx+waHVC5uV
 WsdlmFDI4sV7T/prJ0b+pimrlD4nIGuRKWGdPEwaohHIVXyIxm3j9quOrrkN9MZfvzUON070TwF
 /qH5IkpMZqTzuB05ez9uzHMPTOQ==
X-Google-Smtp-Source: AGHT+IGBEaIV3m2cE8S7FtNDWK/NxuMMHuLw3peUL6i5EECvj9DpnceQMlTXukLfGTLYBpOMGHJ53g==
X-Received: by 2002:a05:600d:14:b0:43c:e2dd:98f3 with SMTP id
 5b1f17b1804b1-43ce2dda00amr151135165e9.21.1741859846439; 
 Thu, 13 Mar 2025 02:57:26 -0700 (PDT)
Received: from [192.168.1.20] (88-178-97-237.subs.proxad.net. [88.178.97.237])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-43d18a4c3c6sm14662815e9.35.2025.03.13.02.57.25
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 13 Mar 2025 02:57:25 -0700 (PDT)
Message-ID: <67025499-bf51-460f-9876-6a48b72c5c0d@linaro.org>
Date: Thu, 13 Mar 2025 10:57:25 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 10/37] accel/tcg: Use cpu_ld*_code_mmu in translator.c
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
Cc: pierrick.bouvier@linaro.org, pbonzini@redhat.com
References: <20250313034524.3069690-1-richard.henderson@linaro.org>
 <20250313034524.3069690-11-richard.henderson@linaro.org>
 <d36bc719-555c-486e-a4c4-a0e00702eefc@linaro.org>
Content-Language: en-US
In-Reply-To: <d36bc719-555c-486e-a4c4-a0e00702eefc@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::336;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x336.google.com
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

On 13/3/25 10:54, Philippe Mathieu-Daudé wrote:
> Hi Richard,
> 
> On 13/3/25 04:44, Richard Henderson wrote:
>> Cache the mmu index in DisasContextBase.
>> Perform the read on host endianness, which lets us
>> share code with the translator_ld fast path.
>>
>> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
>> ---
>>   include/exec/translator.h |  1 +
>>   accel/tcg/translator.c    | 57 ++++++++++++++++++---------------------
>>   2 files changed, 27 insertions(+), 31 deletions(-)
>>
>> diff --git a/include/exec/translator.h b/include/exec/translator.h
>> index d70942a10f..205dd85bba 100644
>> --- a/include/exec/translator.h
>> +++ b/include/exec/translator.h
>> @@ -73,6 +73,7 @@ struct DisasContextBase {
>>       int max_insns;
>>       bool plugin_enabled;
>>       bool fake_insn;
>> +    uint8_t code_mmuidx;
>>       struct TCGOp *insn_start;
>>       void *host_addr[2];
>> diff --git a/accel/tcg/translator.c b/accel/tcg/translator.c
>> index 0260fb1915..64fa069b51 100644
>> --- a/accel/tcg/translator.c
>> +++ b/accel/tcg/translator.c
>> @@ -11,10 +11,9 @@
>>   #include "qemu/log.h"
>>   #include "qemu/error-report.h"
>>   #include "exec/exec-all.h"
>> +#include "exec/cpu-ldst-common.h"
>>   #include "exec/translator.h"
>> -#include "exec/cpu_ldst.h"
>>   #include "exec/plugin-gen.h"
>> -#include "exec/cpu_ldst.h"
>>   #include "exec/tswap.h"
>>   #include "tcg/tcg-op-common.h"
>>   #include "internal-target.h"
>> @@ -142,6 +141,7 @@ void translator_loop(CPUState *cpu, 
>> TranslationBlock *tb, int *max_insns,
>>       db->host_addr[1] = NULL;
>>       db->record_start = 0;
>>       db->record_len = 0;
>> +    db->code_mmuidx = cpu_mmu_index(cpu, true);
>>       ops->init_disas_context(db, cpu);
>>       tcg_debug_assert(db->is_jmp == DISAS_NEXT);  /* no early exit */
>> @@ -457,55 +457,50 @@ bool translator_st(const DisasContextBase *db, 
>> void *dest,
>>   uint8_t translator_ldub(CPUArchState *env, DisasContextBase *db, 
>> vaddr pc)
>>   {
>> -    uint8_t raw;
>> +    uint8_t val;
>> -    if (!translator_ld(env, db, &raw, pc, sizeof(raw))) {
>> -        raw = cpu_ldub_code(env, pc);
>> -        record_save(db, pc, &raw, sizeof(raw));
>> +    if (!translator_ld(env, db, &val, pc, sizeof(val))) {
>> +        MemOpIdx oi = make_memop_idx(MO_UB, db->code_mmuidx);
>> +        val = cpu_ldb_code_mmu(env, pc, oi, 0);
>> +        record_save(db, pc, &val, sizeof(val));
>>       }
>> -    return raw;
>> +    return val;
>>   }
>>   uint16_t translator_lduw(CPUArchState *env, DisasContextBase *db, 
>> vaddr pc)
>>   {
>> -    uint16_t raw, tgt;
>> +    uint16_t val;
>> -    if (translator_ld(env, db, &raw, pc, sizeof(raw))) {
>> -        tgt = tswap16(raw);
>> -    } else {
>> -        tgt = cpu_lduw_code(env, pc);
>> -        raw = tswap16(tgt);
>> -        record_save(db, pc, &raw, sizeof(raw));
>> +    if (!translator_ld(env, db, &val, pc, sizeof(val))) {
>> +        MemOpIdx oi = make_memop_idx(MO_UW, db->code_mmuidx);
> 
> Could we pass MO_TE rather than calling tswap()?

Answer to that is in the next patch ;)

> 
>> +        val = cpu_ldw_code_mmu(env, pc, oi, 0);
>> +        record_save(db, pc, &val, sizeof(val));
> 
> So recorded bytes are in host endianness, is it still OK w.r.t.
> translator_st() use?
> 
>>       }
>> -    return tgt;
>> +    return tswap16(val);
>>   }

