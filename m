Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B5CB0FF5135
	for <qemu-devel@archiver.kernel.org>; Tue,  7 Apr 2026 19:54:07 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wACUJ-0000Bd-0f; Tue, 07 Apr 2026 15:53:27 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1wACU9-00007R-3Z
 for qemu-devel@nongnu.org; Tue, 07 Apr 2026 15:53:21 -0400
Received: from mail-pl1-x62f.google.com ([2607:f8b0:4864:20::62f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1wACU6-0005Om-Oz
 for qemu-devel@nongnu.org; Tue, 07 Apr 2026 15:53:16 -0400
Received: by mail-pl1-x62f.google.com with SMTP id
 d9443c01a7336-2b2429f98d0so35609865ad.2
 for <qemu-devel@nongnu.org>; Tue, 07 Apr 2026 12:53:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1775591593; x=1776196393; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:autocrypt:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:from:to:cc:subject:date:message-id:reply-to;
 bh=JZ6nHuUt18/4fZjn/qu2uoIzXLiSnb58NNEawO4HgTs=;
 b=Tt1WaHsw1Uf0zGJjqKW+RTobN1sKN30YaHxCSRiyd+KZ0saWPTnbijpKVC9gsuJMan
 YS6cMSecxfaSbY6afnKd90VphxnINUf5MkU0dMgO9oGQ5E+Ts7m4fgg3t77yKBlhjvB6
 jP3fXMtbcRV4FxG57jd9Uw9M3rp8MjkVpzYX7Y21A9dP5CO5Liuix5+Kxzd1QS2U5ne0
 6dFYSCZfBDPHD9PJOjSV9g2+IBrZSSnkCEAg0FkNEP/1366qsiu8xm2ACCNR4L9hurIB
 /AA4NIAl4YfOBvr06Lid1Msd+OFncs1lUIE7QAnbLDRGP9/oQ13uv9FP8rSSRU8PE+zB
 YzZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1775591593; x=1776196393;
 h=content-transfer-encoding:in-reply-to:autocrypt:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=JZ6nHuUt18/4fZjn/qu2uoIzXLiSnb58NNEawO4HgTs=;
 b=hL11v5CifbDuhJ2jYp1w8Isr2HUSSYW41OKfRSfc5eq+XGwJZ5PMc5p7Um9TDRdlJ2
 /rc8qTxZkDuJvBcEiHzw4+r5rP/63yRDCTmDNKQwXfsMFIgJ+EtuZiuftuPJCcaI7cBG
 72g/q2mDe4v52fN+ERZRvbLvzw5pw13PsGxWqiXajbkg1QWGVFo5sY5CPbpok0b3/95x
 5sLSqtDdT+q0mp6GOaTEfZ/pWMJ7K664/DCT7igBbImKzlSR/YlitfGC1WqHmdQedZg+
 PSeqkt4bKPQ1Dz2obqvkIgXnB8DUXbdXcBNBwiJoBsDwzdBJt9cSpHM0uKBFoOgQj7Ut
 E0Ww==
X-Forwarded-Encrypted: i=1;
 AJvYcCWZZ+pibheSNyTNrbOb2tTHyq5XuW/x8Ryu54iScflQCam6PwqlKdwwjQjtCPT0rCSRXQmSwQ+aqSns@nongnu.org
X-Gm-Message-State: AOJu0YwAoVzZqoKbwEKiSRsfmJoTjpMA5f2ipfJp2/wgKaQemLFIxI5B
 in6hNMNrj2lVKF1IQYmAlIxP+ASTp4uomdV3zrwVKwHdRk3Ugmb0Su6Fl4O1ssAvYCOzzl1gMBp
 M/qlvUtk=
X-Gm-Gg: AeBDietsemrh53Zy5H7z156YcvqQ8jAzpP/ftBL7eG4JwUagAaTLgpqd9IgZYW3YHl3
 1/jQigV9Nar12To4VU/2OS8Aj8an11Bf7QHKxSDqgOTAkuXf0ycX1vcnemp1smhpSeG8UewkJj5
 F5d9tSftIyrPLI4INjchTYA+o7qyL1Zsy55VsBfVZq3J1+2gTCuacalPTbzgk7rqjc0G9jgK3P5
 CyCJHtJ3NGga1Qx0Iit+UsJEWgYXkyYjOdN7z6x+lbbgLcOrdYPX763VwKxy1CawgQg6wG97eSl
 h76ItBYFoPn2qglyQoOffH8M1nGUUvu1a/9uiMlHYOJuk+U7qwdP/a7kc88yHq1quWuup6/dij+
 veW5miJkApHg66t/9pkb6XBCBzhNy5QKCxt/0Mpv0xBO1q7c3Uz5kFAYTomgurHsCPWealM64bT
 c9JQrswn56xwV5gOArYJw+UaB+sf1U9eHj/gPI3DxODdadt3MHv6Yr0YMkaQ2fDnh/o13cbg==
X-Received: by 2002:a17:902:ce06:b0:2ae:c5fc:b2ea with SMTP id
 d9443c01a7336-2b28176a398mr179473285ad.30.1775591592855; 
 Tue, 07 Apr 2026 12:53:12 -0700 (PDT)
Received: from [192.168.1.169] (216-71-219-44.dyn.novuscom.net.
 [216.71.219.44]) by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2b27472d20bsm180908805ad.16.2026.04.07.12.53.11
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 07 Apr 2026 12:53:12 -0700 (PDT)
Message-ID: <4beca66b-a3e1-4480-8830-d548c2b06670@linaro.org>
Date: Tue, 7 Apr 2026 12:53:11 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v9 13/20] target/arm/tcg/translate.c: extract
 aarch64_translate_code()
To: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 Richard Henderson <richard.henderson@linaro.org>, jim.macarthur@linaro.org,
 qemu-arm@nongnu.org
References: <20260407022748.57629-1-pierrick.bouvier@linaro.org>
 <20260407022748.57629-14-pierrick.bouvier@linaro.org>
 <7166f802-fe21-4672-895a-3bb946c41a55@linaro.org>
From: Pierrick Bouvier <pierrick.bouvier@linaro.org>
Content-Language: en-US
Autocrypt: addr=pierrick.bouvier@linaro.org; keydata=
 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
 ZtfdHNZotF092MIH0IQC3poExQpV/WBYFAI=
In-Reply-To: <7166f802-fe21-4672-895a-3bb946c41a55@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62f;
 envelope-from=pierrick.bouvier@linaro.org; helo=mail-pl1-x62f.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

On 4/7/26 12:23 PM, Philippe Mathieu-Daudé wrote:
> On 7/4/26 04:27, Pierrick Bouvier wrote:
>> This allows to get rid of TARGET_AARCH64, and helps with next patch
>> which will define at runtime tcg address type, by adding a second entry
>> point in a different source file.
>>
>> Suggested-by: Richard Henderson <richard.henderson@linaro.org>
>> Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
>> Signed-off-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
>> ---
>>    target/arm/internals.h         |  2 ++
>>    target/arm/tcg/stubs32.c       |  7 +++++++
>>    target/arm/tcg/translate-a64.c |  8 ++++++++
>>    target/arm/tcg/translate.c     | 18 ++++++++----------
>>    4 files changed, 25 insertions(+), 10 deletions(-)
> 
> 
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
>> index 35ad7530c4b..c5af26e2b7e 100644
>> --- a/target/arm/tcg/translate-a64.c
>> +++ b/target/arm/tcg/translate-a64.c
>> @@ -10949,3 +10949,11 @@ const TranslatorOps aarch64_translator_ops = {
>>        .translate_insn     = aarch64_tr_translate_insn,
>>        .tb_stop            = aarch64_tr_tb_stop,
>>    };
>> +
> 
> Please get translator_loop() declaration with explicit:
> 
> #include "exec/translator.h"
>

Done.

>> +void aarch64_translate_code(CPUState *cpu, TranslationBlock *tb,
>> +                            int *max_insns, vaddr pc, void *host_pc)
>> +{
>> +     DisasContext dc = {};
> 
>> +     translator_loop(cpu, tb, max_insns, pc, host_pc,
>> +                     &aarch64_translator_ops, &dc.base);
>> +}
>> diff --git a/target/arm/tcg/translate.c b/target/arm/tcg/translate.c
>> index 204f9657993..0597c9d4bed 100644
>> --- a/target/arm/tcg/translate.c
>> +++ b/target/arm/tcg/translate.c
>> @@ -6878,18 +6878,16 @@ static const TranslatorOps thumb_translator_ops = {
> 
> Ditto (pre-existing):
> 
> #include "exec/translator.h"
>

Done.

>>    void arm_translate_code(CPUState *cpu, TranslationBlock *tb,
>>                            int *max_insns, vaddr pc, void *host_pc)
>>    {
>> -    DisasContext dc = { };
>> -    const TranslatorOps *ops = &arm_translator_ops;
>>        CPUARMTBFlags tb_flags = arm_tbflags_from_tb(tb);
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
>> +                        (EX_TBFLAG_AM32(tb_flags, THUMB)
>> +                        ? &thumb_translator_ops
>> +                        : &arm_translator_ops),
>> +                        &dc.base);
>>        }
>> -#endif
>> -
>> -    translator_loop(cpu, tb, max_insns, pc, host_pc, ops, &dc.base);
>>    }
> 

