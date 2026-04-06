Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1EF6AFB5173
	for <qemu-devel@archiver.kernel.org>; Mon,  6 Apr 2026 22:47:18 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w9siu-0002HP-V3; Mon, 06 Apr 2026 18:47:12 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1w9sim-0002Gz-Sa
 for qemu-devel@nongnu.org; Mon, 06 Apr 2026 18:47:06 -0400
Received: from mail-pg1-x531.google.com ([2607:f8b0:4864:20::531])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1w9sik-00030P-No
 for qemu-devel@nongnu.org; Mon, 06 Apr 2026 18:47:04 -0400
Received: by mail-pg1-x531.google.com with SMTP id
 41be03b00d2f7-c766a95a72dso2743404a12.1
 for <qemu-devel@nongnu.org>; Mon, 06 Apr 2026 15:47:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1775515621; x=1776120421; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:autocrypt:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:from:to:cc:subject:date:message-id:reply-to;
 bh=lpRfp2SYqxiRHLIPbDhlbp+xMaSOY1I4WRNm5fiIZ6g=;
 b=bi+LIb2XvU7NJ6ulkwuk/z75m+9AV5dVxKPJ3YSuNkx7YIripp5Ilngo5SaCMlnZk5
 /2GnNAGmQ+N+D0CVjXBl2KT8xZSjC3UXFtvf7RrfcglILP7w5XwnhLUVTOz/8cEOaYr5
 07HThAtpHV5J2CKqVmuBDa/1g/8WJgxQy/gYBYcvXvsCbs+T4JqR7jBNSVy5ylFOWWji
 3Qo8q0Owt46Eq2AHBtG3IVwEAdOknQmuFPpAjqlisIGO33mEKFh8tTysTQQTmmuEUhE5
 yddsTIXMRFale/nDHx1UfKDrLJCXPitB4gnPWoE0WccmiKih7EX7A/byrJwS4WXs6Gt8
 LxEQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1775515621; x=1776120421;
 h=content-transfer-encoding:in-reply-to:autocrypt:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=lpRfp2SYqxiRHLIPbDhlbp+xMaSOY1I4WRNm5fiIZ6g=;
 b=FGKvYKPqjnbgHx6999RXpnTUlriZ/yaRXrRSHcxpJ6PBNTZNRIXVww0TfdQaQvndt3
 CDawU0ZE6RGLJmwGdtbqqNetCtyDNNREkHIaMl6DXKRZ5/c0y5pVaAlIgVJORz6A7btB
 Cem8BzlsqI3L/Ezo537Z7Mr3O7i4QHF7YPM4l8W/vxHvtNFIoWCnyObi9egMSXtDMv1/
 idXBj9ke5NA8WfzjokIIHEPlXL8wgKcTvCJcB4ydq73oE7fbjfOWlVLhLNbHGXukGO47
 J4L2EOqeWy7/Dc9onD4ELsJYdxOVLDj0LjStUghjC98pYgOIrnsYYCCb7OhQP07CsxJT
 b3SA==
X-Forwarded-Encrypted: i=1;
 AJvYcCWCAXD9OUxph2piWz/jRCDDYCDnQ1yBaivYFokcNGObvHHA4Ar30h7ETTpz7MsRD0gVFc0shPFsR0ZP@nongnu.org
X-Gm-Message-State: AOJu0YwGCEc21/ciq24hVgwYdFFAGUQ2aCYCFcG3N59487RSaGSbOEBi
 ywcPIKdsZdzvXf/soM4/tZWCQyUlOlwFSTq8xIkYXif5uqfBDzKqn5uUsLAcjGh4b9M=
X-Gm-Gg: AeBDietoqF8kYEgJdMqDXQzSyq1HY9C9JM4nLOpc3BcgqLhOrJiUTlEEN5ATfUJhywX
 ClPGScA2Nfxsj3YfXOLLfVOVz0YzAPb9GOYk06iwxm8kICFWS0Mzf3dgQcKAezYYUHCYGe4LZZl
 AZEiYLmmbTA36jLCB031GC4KndvWSW6e1yAU7Byxy/x62ZpH9ulTpMX7L0u2LlzEygalfIpwILY
 Clwx0+uy8YY+giqVufLmirW9q+ZIPEYhRRch2SfHZZ3ShidBKuF9f+qVoZNuIdGkBFXkmPux31M
 7RFAfCmp14mPDBojISkbLcxhTw0fdzTOgZDlqsY2s3sv5CtEwgULpXULMrP3L5iCgZ7Ajxgp2ID
 hadAhWxzkhjY1DD1Q8NuGqI5Xwpl9WifH26QYeXcm6Fm1NBtQoq1B90DnE0UKImqMg16ou8T+6S
 SeNTuRGoS6epROqr1LwDRFmIDs7sfvxZuqRPhCfxgE1TFbxnUi/r57UqOFNrPBMl3O1mcFH+wKl
 5aw+qON
X-Received: by 2002:a05:6a21:32a4:b0:39b:ba95:b127 with SMTP id
 adf61e73a8af0-39f2ed94fd2mr15728962637.4.1775515621065; 
 Mon, 06 Apr 2026 15:47:01 -0700 (PDT)
Received: from [192.168.1.168] (216-71-219-44.dyn.novuscom.net.
 [216.71.219.44]) by smtp.gmail.com with ESMTPSA id
 41be03b00d2f7-c76c6563c43sm13138092a12.20.2026.04.06.15.47.00
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 06 Apr 2026 15:47:00 -0700 (PDT)
Message-ID: <70ae25b0-11b2-430a-9d8b-4c3f095a6824@linaro.org>
Date: Mon, 6 Apr 2026 15:46:59 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v8 19/20] target/arm/tcg/translate.c: remove TARGET_AARCH64
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>, jim.macarthur@linaro.org,
 Paolo Bonzini <pbonzini@redhat.com>, philmd@linaro.org, qemu-arm@nongnu.org
References: <20260406182609.193886-1-pierrick.bouvier@linaro.org>
 <20260406182609.193886-20-pierrick.bouvier@linaro.org>
 <fa336642-d1b7-42e9-955e-440baae09974@linaro.org>
From: Pierrick Bouvier <pierrick.bouvier@linaro.org>
Content-Language: en-US
Autocrypt: addr=pierrick.bouvier@linaro.org; keydata=
 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
 ZtfdHNZotF092MIH0IQC3poExQpV/WBYFAI=
In-Reply-To: <fa336642-d1b7-42e9-955e-440baae09974@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::531;
 envelope-from=pierrick.bouvier@linaro.org; helo=mail-pg1-x531.google.com
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
List-Id: qemu development <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

On 4/6/26 3:45 PM, Richard Henderson wrote:
> On 4/7/26 04:26, Pierrick Bouvier wrote:
>> We extract aarch64_translate_code function, and stub it accordingly.
>>
>> Suggested-by: Richard Henderson <richard.henderson@linaro.org>
>> Signed-off-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
>> ---
>>    target/arm/internals.h         |  2 ++
>>    target/arm/tcg/stubs32.c       |  7 +++++++
>>    target/arm/tcg/translate-a64.c |  8 ++++++++
>>    target/arm/tcg/translate.c     | 19 ++++++++-----------
>>    4 files changed, 25 insertions(+), 11 deletions(-)
>>
>> diff --git a/target/arm/internals.h b/target/arm/internals.h
>> index 8ec27508473..2850edcb198 100644
>> --- a/target/arm/internals.h
>> +++ b/target/arm/internals.h
>> @@ -381,6 +381,8 @@ void arm_init_cpreg_list(ARMCPU *cpu);
>>    
>>    void arm_cpu_register_gdb_regs_for_features(ARMCPU *cpu);
>>    void arm_translate_init(void);
>> +void aarch64_translate_code(CPUState *cs, TranslationBlock *tb,
>> +                            int *max_insns, vaddr pc, void *host_pc);
>>    void arm_translate_code(CPUState *cs, TranslationBlock *tb,
>>                            int *max_insns, vaddr pc, void *host_pc);
>>    
>> diff --git a/target/arm/tcg/stubs32.c b/target/arm/tcg/stubs32.c
>> index c5a0bc61f47..3945dc49e5e 100644
>> --- a/target/arm/tcg/stubs32.c
>> +++ b/target/arm/tcg/stubs32.c
>> @@ -3,6 +3,7 @@
>>     */
>>    
>>    #include "qemu/osdep.h"
>> +#include "target/arm/internals.h"
>>    #include "target/arm/tcg/translate.h"
>>    
>>    
>> @@ -15,3 +16,9 @@ void a64_translate_init(void)
>>    {
>>        /* Don't initialize for 32 bits. Call site will be fixed later. */
>>    }
>> +
>> +void aarch64_translate_code(CPUState *cs, TranslationBlock *tb,
>> +                            int *max_insns, vaddr pc, void *host_pc)
>> +{
>> +    g_assert_not_reached();
>> +}
>> diff --git a/target/arm/tcg/translate-a64.c b/target/arm/tcg/translate-a64.c
>> index ebab9f36f08..db3990576c0 100644
>> --- a/target/arm/tcg/translate-a64.c
>> +++ b/target/arm/tcg/translate-a64.c
>> @@ -10948,3 +10948,11 @@ const TranslatorOps aarch64_translator_ops = {
>>        .translate_insn     = aarch64_tr_translate_insn,
>>        .tb_stop            = aarch64_tr_tb_stop,
>>    };
>> +
>> +void aarch64_translate_code(CPUState *cpu, TranslationBlock *tb,
>> +                            int *max_insns, vaddr pc, void *host_pc)
>> +{
>> +     DisasContext dc = {};
>> +     translator_loop(cpu, tb, max_insns, pc, host_pc,
>> +                     &aarch64_translator_ops, &dc.base, TCG_TYPE_I64);
>> +}
>> diff --git a/target/arm/tcg/translate.c b/target/arm/tcg/translate.c
>> index aea38507ef4..9a971325144 100644
>> --- a/target/arm/tcg/translate.c
>> +++ b/target/arm/tcg/translate.c
>> @@ -6906,19 +6906,16 @@ static const TranslatorOps thumb_translator_ops = {
>>    void arm_translate_code(CPUState *cpu, TranslationBlock *tb,
>>                            int *max_insns, vaddr pc, void *host_pc)
>>    {
>> -    DisasContext dc = { };
>> -    const TranslatorOps *ops = &arm_translator_ops;
>>        CPUARMTBFlags tb_flags = arm_tbflags_from_tb(tb);
>> -    TCGType addr_type = is_a64(cpu_env(cpu)) ? TCG_TYPE_I64 : TCG_TYPE_I32;
>>    
>> -    if (EX_TBFLAG_AM32(tb_flags, THUMB)) {
>> -        ops = &thumb_translator_ops;
>> -    }
>> -#ifdef TARGET_AARCH64
>>        if (EX_TBFLAG_ANY(tb_flags, AARCH64_STATE)) {
>> -        ops = &aarch64_translator_ops;
>> +        aarch64_translate_code(cpu, tb, max_insns, pc, host_pc);
>> +    } else {
>> +        DisasContext dc = { };
>> +        translator_loop(cpu, tb, max_insns, pc, host_pc,
>> +                (EX_TBFLAG_AM32(tb_flags, THUMB)
>> +                 ? &thumb_translator_ops
>> +                 : &arm_translator_ops),
>> +                &dc.base, TCG_TYPE_I32);
>>        }
>> -#endif
>> -
>> -    translator_loop(cpu, tb, max_insns, pc, host_pc, ops, &dc.base, addr_type);
>>    }
> 
> Oh, I see my confusion on the previous patch.
> Yes, re-ordering this would be helpful.
>

Yes, I think I missed the (implicit idea) that we would have two 
different entry points for translations, in two separate files, and thus 
TCG_TYPE_VA could automatically set accordingly.

> Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
> 
> 
> r~


