Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (unknown [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5D99410F996B
	for <qemu-devel@archiver.kernel.org>; Wed,  8 Apr 2026 18:40:38 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wAXpB-0000aE-HG; Wed, 08 Apr 2026 14:40:25 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1wAXp8-0000Ez-SD
 for qemu-devel@nongnu.org; Wed, 08 Apr 2026 14:40:22 -0400
Received: from mail-wm1-x32b.google.com ([2a00:1450:4864:20::32b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1wAO9B-0006x1-SO
 for qemu-devel@nongnu.org; Wed, 08 Apr 2026 04:20:27 -0400
Received: by mail-wm1-x32b.google.com with SMTP id
 5b1f17b1804b1-488b8efed61so5888975e9.1
 for <qemu-devel@nongnu.org>; Wed, 08 Apr 2026 01:20:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1775636422; x=1776241222; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=Pi8Bexgb6zf96/7by79sOjhk80rY6cZUfTO7NQOJIwo=;
 b=nJM78j5LDk8lP2vffjAHwbopby8tYHLx+igwxlcrlg5JJPRYB7T9kjonk/5hNdHYY1
 3OUh8ddRuFFwUwBwsOgTa/KgmYak9d0vVT5M52vPchVwZ70pmoeEELuDdubYHl5iB+hQ
 RY+j1JIQ0d1XlUJLmBk6RCQex6q4lZxQvv/LBmFVD0Daa1OVVt3Kgy+HbHx15VZOZa01
 ebtFuYn70nzlAZtkOKKdK+QBVoG9wVh/c8iviHnWtsCN0gUemwwwrJ2jKl9eIpjwTp/C
 2N619X76HguS6xXOZbL+12a7f5iXA3uDXGBNHFYPuZW0jAUNqqekWzuVZ8ucqUwzhaOp
 UMcQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1775636422; x=1776241222;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=Pi8Bexgb6zf96/7by79sOjhk80rY6cZUfTO7NQOJIwo=;
 b=s/abdg6WpEgIC8I7tOl/7bVpLpNBtw4zSKhLa1uhWymafkgfmd6aF12SIyXhISog3B
 9QvTQBqS/ZzSpJ6onrmXKQcUBCIS9uZlaHF5D9bHqWswf5Iky5mwp7oKSsTBqa5Ml5TG
 5a/Gu98k4FDK34Wk1jJm1LCFAn0IpwYZSlwi16VbrQ+12wwIoQz3WJ7HF9yE1ni8zBbd
 V1P5OcrOl9PuUPU68Ckt8zyy0TgsSzhmOa1d1cMovxd2WfEaooyrHW+H4vdBIxA2WAEF
 caE4ZVc7TUwvKZBRwolNnoNT3gMERbIgw+/Wa1XR3nFw7iJKNu6agyrGBG/gOXEkmNHf
 5YSw==
X-Forwarded-Encrypted: i=1;
 AJvYcCXIpHEm5dGzgtwRwRXUU+D7kJ1ZuRP7rrtR8wYaS9H2RvuT3vfnbr/7OXK5kgw2QtZJtGyYiljcdy67@nongnu.org
X-Gm-Message-State: AOJu0YxY/sD3hzobXqBQQmbrXNtDJc/4eUO1caBykIJhMKb9otOjGsue
 FOMkh6JKOu9y1uLCUDLGDygDNfCb5ZJOd2Vft0gWHmAb8u1V7813UCZ2p3a2UoLSJss=
X-Gm-Gg: AeBDievpO0HLy/QcbHJMmSI1YauavGcNrzzTkviZcHphH6wFTp1fPSKGMB8eyNr4RcZ
 bQvDfzgoohw9n0MDlx/9iKFgmdbvU0jaynmR43kMFc3PdrjjOpqXQW9g8nRfMgHlcCAFzrSbqLO
 XpMylAMVL7WIxa3XySWpOcOYEfoYpFytpIGbljRLV2ZoWV2rG3eSvYUHBUGHWs2q6GaRSU2uVAq
 QwHUUlBo4DPFOUhXqeoYNXZBsKlHUTBJjtUbh3M2XU9XKSIH0d9G2Vfa7iL5Tbe/+5ujVFO6rxP
 QItZs6IinbLxxAQZoNl4mbtEyMU4eBp5NhKG+oAqsCbrXuHzwPQP71N5aqmNhsTU8Ih4wZ6s4zV
 7osb5iPcLk10Hsr9Ay12srFG+ALeoWmBCXyyLRGg8J+PNaZQFqD6XX0mOOIhDm6pLvyseqhqPjC
 gGAgcG7TzI5aulPfGpJSWeT44PJiefd1QZIDyxSj8whf++6FrZ+L8L8IjQICjlFgEOcw==
X-Received: by 2002:a05:600c:620d:b0:485:fbd2:f72 with SMTP id
 5b1f17b1804b1-4889945faa5mr259585465e9.1.1775636422289; 
 Wed, 08 Apr 2026 01:20:22 -0700 (PDT)
Received: from [192.168.69.228] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-488a952a03asm290837685e9.0.2026.04.08.01.20.20
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 08 Apr 2026 01:20:21 -0700 (PDT)
Message-ID: <f40a06f2-d3b7-4130-a7ea-cd90337c6bb2@linaro.org>
Date: Wed, 8 Apr 2026 10:20:20 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 26/29] target/arm/tcg/translate.c: remove MO_TE usage
To: Richard Henderson <richard.henderson@linaro.org>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>, qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Jim MacArthur <jim.macarthur@linaro.org>, anjo@rev.ng
References: <20260109053158.2800705-1-pierrick.bouvier@linaro.org>
 <20260109053158.2800705-27-pierrick.bouvier@linaro.org>
 <5fc9d07c-cd22-45c0-bb5e-8bf93d20f112@linaro.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Content-Language: en-US
In-Reply-To: <5fc9d07c-cd22-45c0-bb5e-8bf93d20f112@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32b;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x32b.google.com
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

On 9/1/26 23:50, Richard Henderson wrote:
> On 1/9/26 16:31, Pierrick Bouvier wrote:
>> dc->be_data is already set just above in the same function:
>> ```
>>      dc->be_data = EX_TBFLAG_ANY(tb_flags, BE_DATA) ? MO_BE : MO_LE;
>> ```
>>
>> Signed-off-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
>> ---
>>   target/arm/tcg/translate.c | 1 -
>>   1 file changed, 1 deletion(-)
>>
>> diff --git a/target/arm/tcg/translate.c b/target/arm/tcg/translate.c
>> index ec4358ba402..55b89817cb1 100644
>> --- a/target/arm/tcg/translate.c
>> +++ b/target/arm/tcg/translate.c
>> @@ -6327,7 +6327,6 @@ static void 
>> arm_tr_init_disas_context(DisasContextBase *dcbase, CPUState *cs)
>>       if (arm_feature(env, ARM_FEATURE_M)) {
>>           dc->vfp_enabled = 1;
>> -        dc->be_data = MO_TE;
>>           dc->v7m_handler_mode = EX_TBFLAG_M32(tb_flags, HANDLER);
>>           dc->v8m_secure = EX_TBFLAG_M32(tb_flags, SECURE);
>>           dc->v8m_stackcheck = EX_TBFLAG_M32(tb_flags, STACKCHECK);
> 
> Whoops, yes indeed.
> 
> Cc: qemu-stable@nongnu.org

As per my v10 comments, why Cc stable? This is just removing pointless 
code, right?

> Fixes: a729a46b05a ("target/arm: Add wrapper macros for accessing tbflags")

This commit doesn't seem to be related.

Do you mean commit 79cabf1f473 ("target/arm: Recover 4 bits from
TBFLAGs")?

     We had completely run out of TBFLAG bits.
     Split A- and M-profile bits into two overlapping buckets.
     This results in 4 free bits.

     We used to initialize all of the a32 and m32 fields in DisasContext
     by assignment, in arm_tr_init_disas_context.  Now we only initialize
     either the a32 or m32 by assignment, because the bits overlap in
     tbflags.  So zero the entire structure in gen_intermediate_code.

Since BE_DATA is in the TBFLAG_ANY set, I don't get why it
is set to MO_TE for M-profile.

At any rate this patch description deserves a better explanation IMHO.

> Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
> 
> 
> r~


