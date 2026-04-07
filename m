Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 25B27FF5135
	for <qemu-devel@archiver.kernel.org>; Tue,  7 Apr 2026 19:19:42 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wABUO-0006GS-Dw; Tue, 07 Apr 2026 14:49:28 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1wABSb-0002em-4B
 for qemu-devel@nongnu.org; Tue, 07 Apr 2026 14:47:38 -0400
Received: from mail-pg1-x534.google.com ([2607:f8b0:4864:20::534])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1wA84X-0000cl-9H
 for qemu-devel@nongnu.org; Tue, 07 Apr 2026 11:10:36 -0400
Received: by mail-pg1-x534.google.com with SMTP id
 41be03b00d2f7-c76b0cda2aeso2083252a12.2
 for <qemu-devel@nongnu.org>; Tue, 07 Apr 2026 08:10:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1775574631; x=1776179431; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
 :to:content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=XmlK8qp4QxDkmjc3jQkfJt8CwnmWAquFsEPPWzRTxLY=;
 b=Jd8tZ6Y8/NpHB8jn4Bec3WdWLIbRV3cFHymF7eVbX/x3nVxNJMNR7NNO2xKLMgs5bI
 1Wki3xAvDjpWVpqxDyCI7Nz9NKBJovl7xlkNK2jCJ0HC2OCTQmVxfQis1/u74dfPbve/
 IEafX+DfbFW6co4utxNN7/PN1jB7KBfIkUbmFxJVT7P//74H8IQ445gs13NvgFm5sCYu
 H7eT/HsmZWACaFdt+PwOcrFBejzPqCUNf+gXmzjXLPNU1RyuCyMFsqMc7zTVGi305C7P
 taDaY6hNzwbOdwzsr9Y2a9daJX83O3DeSjU0d9igMxz2pSZqzRcbTDelXyS9Ax0WzBUv
 Ss+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1775574631; x=1776179431;
 h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
 :to:content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=XmlK8qp4QxDkmjc3jQkfJt8CwnmWAquFsEPPWzRTxLY=;
 b=gT0ZoQfl0ZuC7Fpjp4w5JCZ4FLvLeP9sBlZo6SWU3fZ/Lxl9bGilTrn1a8sTU6gCA7
 6naOHJO3ZnJwkNRQ6F0FaJv9GJRr0PRba+dHi8lgkjgMSA9KC6tKYZfH0YwyS9VELc0H
 hdpXTKfytlxxxTIXeGn0uQkF2z9K/QrsdkCoqHlOKqGD9vxeaL1lyBlHPhqSfOvQ/iUt
 0C36IHYyMQnRsZSEUZTqI7xSlLSlmCFuRUbuRmotIPc/3KZJf1jC1B1+N7BAvkSoLDh7
 sHP+rgLhA4nZeciUUsYT1F9w0nfQwqNTkTz+XYzO8R7L/AgHZOnzq+k2/Tm820M+rW34
 rVrA==
X-Forwarded-Encrypted: i=1;
 AJvYcCW27yz6Bxp+7Dm6yMRidx4PHXfroulBFhzgR2zdwyUzuhoZhnvsunfRnbzkGVncf3bCrUG9UvrVPsZh@nongnu.org
X-Gm-Message-State: AOJu0Ywsv7Cdx3JAUKIn8WrY5/Jn7DKG8sb1qLzS38+5cV+B/6Hwu5Yu
 JixwzLcjvLYc2Iu8bVlwRM70JKaH+X7rgDVCfE/dhKlfRbJsPc8xdA9TkiGZYirdwws=
X-Gm-Gg: AeBDievJmHOA7q4AHgytToimvc48uSL+xLzNfD6yFUZ/SYF1f08pCywvncPJzW4Jl4P
 1hj4KG6xsOMRSjdiMP7x9sFqN+8aMN4HgTIrJarfBLPoJ9AiTr2kmnwjzRk0hOdTZlAFc1Oxh4l
 T91ClY1N36Kx8lg+SMjzY6TUCei4RQw+clSEyxc8GCCdP0wlwZo84H3VxiNMk/JIj0nTu1zmy2Q
 MHuD65xIWCbU3VoSwFuPFoyplGGRzYBn/N50sbdD28XWmOoXXJscl0yNCBW7BE9gdTSLdBGrJ2o
 J9tvj5tx+CMT2Frz2Qtcrgu28JrwVDxluNfNRvk+JJxI1XmG1FbNZiZO7dRVWIwBW7ylWRbX900
 412jSbb03olrfwwHjmE1ZoEfnurZVJBOESJeCtXoJcAh20soXc8kEyuryRmhYgOVl+eYuohUiFs
 dpSAYqRhC4C7i+PtHxsgWot3+XzOBkHCKMgVpnxCap28K4rJ1H74PANKmwjl1QQSiyR5Pesg==
X-Received: by 2002:a05:6a20:a108:b0:394:a026:4c48 with SMTP id
 adf61e73a8af0-39f2f08410dmr18017905637.41.1775574630606; 
 Tue, 07 Apr 2026 08:10:30 -0700 (PDT)
Received: from [192.168.1.169] (216-71-219-44.dyn.novuscom.net.
 [216.71.219.44]) by smtp.gmail.com with ESMTPSA id
 41be03b00d2f7-c76c659bedesm15245569a12.30.2026.04.07.08.10.29
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 07 Apr 2026 08:10:29 -0700 (PDT)
Message-ID: <10c81813-d4e6-4d77-bb21-3d3c15734f6f@linaro.org>
Date: Tue, 7 Apr 2026 08:10:28 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v9 18/20] target/arm/tcg/translate.c: replace
 translator_ldl_swap with translator_ldl_end
Content-Language: en-US
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
Cc: philmd@linaro.org, Paolo Bonzini <pbonzini@redhat.com>,
 Peter Maydell <peter.maydell@linaro.org>, jim.macarthur@linaro.org,
 qemu-arm@nongnu.org
References: <20260407022748.57629-1-pierrick.bouvier@linaro.org>
 <20260407022748.57629-19-pierrick.bouvier@linaro.org>
 <4c80af84-a0d8-4f1d-9fa8-4c3b38a5559e@linaro.org>
From: Pierrick Bouvier <pierrick.bouvier@linaro.org>
Autocrypt: addr=pierrick.bouvier@linaro.org; keydata=
 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
 ZtfdHNZotF092MIH0IQC3poExQpV/WBYFAI=
In-Reply-To: <4c80af84-a0d8-4f1d-9fa8-4c3b38a5559e@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::534;
 envelope-from=pierrick.bouvier@linaro.org; helo=mail-pg1-x534.google.com
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

On 4/6/26 11:59 PM, Richard Henderson wrote:
> On 4/7/26 12:27, Pierrick Bouvier wrote:
>> Signed-off-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
>> ---
>>    target/arm/cpu.c           |  6 +-----
>>    target/arm/tcg/translate.c | 11 +++++------
>>    2 files changed, 6 insertions(+), 11 deletions(-)
>>
>> diff --git a/target/arm/cpu.c b/target/arm/cpu.c
>> index ccc47c8a9ad..b62de8addff 100644
>> --- a/target/arm/cpu.c
>> +++ b/target/arm/cpu.c
>> @@ -828,15 +828,11 @@ static void arm_disas_set_info(const CPUState *cpu, disassemble_info *info)
>>        }
>>    
>>        info->endian = BFD_ENDIAN_LITTLE;
>> -    if (bswap_code(sctlr_b)) {
>> -        info->endian = target_big_endian() ? BFD_ENDIAN_LITTLE : BFD_ENDIAN_BIG;
>> -    }
>>        info->flags &= ~INSN_ARM_BE32;
>> -#ifndef CONFIG_USER_ONLY
>>        if (sctlr_b) {
>> +        info->endian |= BFD_ENDIAN_BIG;
>>            info->flags |= INSN_ARM_BE32;
>>        }
>> -#endif
>>    }
>>    
>>    static void aarch64_cpu_dump_state(CPUState *cs, FILE *f, int flags)
> 
> With $subject, this should be split to its own patch.
>

Sure, will split it.

> With that,
> Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
> 
> 
> r~
> 
>> diff --git a/target/arm/tcg/translate.c b/target/arm/tcg/translate.c
>> index 1fbe41ec643..5b6a80930af 100644
>> --- a/target/arm/tcg/translate.c
>> +++ b/target/arm/tcg/translate.c
>> @@ -6283,14 +6283,13 @@ static void disas_thumb_insn(DisasContext *s, uint32_t insn)
>>    static uint16_t arm_lduw_code(CPUARMState *env, DisasContextBase* s,
>>                                  target_ulong addr, bool sctlr_b)
>>    {
>> -#ifndef CONFIG_USER_ONLY
>> -    /* In big-endian (BE32) mode, adjacent Thumb instructions have been swapped
>> -       within each word.  Undo that now.  */
>> +    MemOp end = MO_LE;
>>        if (sctlr_b) {
>> +        /* In BE32 mode, adjacent Thumb instructions are swapped. */
>>            addr ^= 2;
>> +        end = MO_BE;
>>        }
>> -#endif
>> -    return translator_lduw_swap(env, s, addr, bswap_code(sctlr_b));
>> +    return translator_lduw_end(env, s, addr, end);
>>    }
>>    
>>    static bool insn_crosses_page(CPUARMState *env, DisasContext *s)
>> @@ -6531,7 +6530,7 @@ static void arm_post_translate_insn(DisasContext *dc)
>>    static uint32_t arm_ldl_code(CPUARMState *env, DisasContextBase *s,
>>                                 target_ulong addr, bool sctlr_b)
>>    {
>> -    return translator_ldl_swap(env, s, addr, bswap_code(sctlr_b));
>> +    return translator_ldl_end(env, s, addr, sctlr_b ? MO_BE : MO_LE);
>>    }
>>    
>>    static void arm_tr_translate_insn(DisasContextBase *dcbase, CPUState *cpu)
> 


