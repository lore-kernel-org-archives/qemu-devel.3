Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CB3BAD1D494
	for <qemu-devel@archiver.kernel.org>; Thu,  8 Jan 2026 21:18:45 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vdxOu-00083B-Kt; Thu, 08 Jan 2026 16:18:36 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1vdxOt-0007z1-G8
 for qemu-devel@nongnu.org; Thu, 08 Jan 2026 16:18:35 -0500
Received: from mail-pl1-x632.google.com ([2607:f8b0:4864:20::632])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1vdxOr-0005c7-Uc
 for qemu-devel@nongnu.org; Thu, 08 Jan 2026 16:18:35 -0500
Received: by mail-pl1-x632.google.com with SMTP id
 d9443c01a7336-2a0a95200e8so22109805ad.0
 for <qemu-devel@nongnu.org>; Thu, 08 Jan 2026 13:18:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1767907112; x=1768511912; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=SdNaqiszSBoOWDss/LL9uxnIOL+bqt3SvH6b1CMjkPo=;
 b=roHtpLPIiC1phkDf+76sCxGPntXWqCzSU7gy//T1uqPjvBh3dD+yMu69iSklSPXfAG
 f/9UfroYtJzGc8YL71pS8xJuCi2LWkGE4AK44kwYqPTHD8DaFR5sjv85ckeP4274YaHr
 Y2EMlzNBMeS+gZ88indr6wj1qSRikvUK+lDRfd0OjxwWDCvUK3wbX1AhL9Yu+F6vpSeE
 0V8kqXJ0OSexnSyrWC+8pi4yWnbbWSZRXqTR4QBFgO+fMO+ckN7hQG07VQSMyjeb2Yh8
 1RWRYjg+cUD00k/+yqz2TpHS1cakHzw9Ce2LB4HRN5pfNmVh8i5e/DAhIV5Pd+7GlNAL
 KEoA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1767907112; x=1768511912;
 h=content-transfer-encoding:in-reply-to:from:references:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=SdNaqiszSBoOWDss/LL9uxnIOL+bqt3SvH6b1CMjkPo=;
 b=L2LEoBT74plPVvnF+L0mBi3WwoIYm67FIbuItStSXbpIpoEFLXZq1EnO0gBxvgfW3T
 wHjhCBoNU3UBSqpkqj043twu7xWfpi/nw/ZWfgflCD0+uqh74TO2u3obXsah9nipLupc
 qXOfPDMwrBJN2HrOgDBuQuIEeTnH+oBFzdpzxId85S+/RBM1CmhHHkATayiYVDEyVwXM
 JBydnMhcKIZwGDTCaqQ8MG+3uTwbqUmYvniUaI5Y3/YevNiUxLxbi20Muaz2LnHIgCS+
 E5Gc1I0kg3dRnuUrqCcqy9kgwFUq66Ch4dryjle4iWOXMdEIkevDshrNix1f2SSRCMa3
 kdLQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCUInEXi6YkmtnLWoCJYuUzg6tjMvYz5Raq00u/KWB5u+lRjXlHlFVr3I//n8mpz60t4TiYxZfgOvCBq@nongnu.org
X-Gm-Message-State: AOJu0YzRhJ/v2y7RXOsf2q7M4DFtNgaXKw6702XsEqGjuyauvMm6LJNn
 FR8KbqDWKGYTgQFKaKTRbJFGuI9KS2qGYQyTJ7zq+tZB5eo5k2jX8V0cMiLhQLV13jI=
X-Gm-Gg: AY/fxX5mkU+Gb5wlcZZ9lWQMnXUmoNau560g4vxtgIGk1RuVqlKpnz10RRHJ9HgDzgh
 LLenWrYXG1334o6dyI1PNI4hhDYVL98SXKE3iRMNXkN3S19pHPkGw4pYsT7g0Ggm+SRIw0Po0Gl
 EOZ6ssSc4gy79GeYDnyloYFp7TJqReZw3jVL/TyvE/BHtGjhw4/R9aij/RysjtTitWZt7xC/nyM
 TDDO8Mw9XF/RhwSLkgsu7spNiBP0BWRSnm8/81FRfCByTzqyAwd6SYnip/LJGj7T2XAcPQTtTqF
 mNqFczMZjhsCt37Xa3np6DkqYt1BnmKwj7peB1frfVihgURTdfLlWYPkCl+KN9pcs51ZNRdJ99t
 CaOUX/hA1Bi9YhuNQFupYq3PF+l7ulV3Zzr+kaboE9Z8Ywf1H/2BYvyXv3IzkSPqAGtfZrcLYre
 aIo5iA8z2jXOrcRByutffbPAUSieiTAKpZ89jzGH6JDn+toWIgnnxvUm7M
X-Google-Smtp-Source: AGHT+IGW1GVmK0xYcx2SOXLWs3dEdipYqJHtk1USFGm8i/xLmJnInuJVxfpW1THMpCvf9IpIOHnXrg==
X-Received: by 2002:a17:902:d4cc:b0:29e:9387:f2b9 with SMTP id
 d9443c01a7336-2a3ee45d592mr58354605ad.24.1767907112085; 
 Thu, 08 Jan 2026 13:18:32 -0800 (PST)
Received: from [192.168.1.87] (216-71-219-44.dyn.novuscom.net. [216.71.219.44])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2a3e3c3a507sm85396045ad.3.2026.01.08.13.18.31
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 08 Jan 2026 13:18:31 -0800 (PST)
Message-ID: <4af4c866-de04-4bab-8270-909e6173751c@linaro.org>
Date: Thu, 8 Jan 2026 13:18:31 -0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 07/50] host/include/x86_64/bufferiszero: Remove no SSE2
 fallback
Content-Language: en-US
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
References: <20260108053018.626690-1-richard.henderson@linaro.org>
 <20260108053018.626690-8-richard.henderson@linaro.org>
 <1928a9b9-aa81-49a8-844b-18617cc966ce@linaro.org>
 <2379c4d9-3401-41cd-8a95-d833f799e10d@linaro.org>
From: Pierrick Bouvier <pierrick.bouvier@linaro.org>
In-Reply-To: <2379c4d9-3401-41cd-8a95-d833f799e10d@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::632;
 envelope-from=pierrick.bouvier@linaro.org; helo=mail-pl1-x632.google.com
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

On 1/8/26 1:15 PM, Richard Henderson wrote:
> On 1/9/26 07:09, Pierrick Bouvier wrote:
>> On 1/7/26 9:29 PM, Richard Henderson wrote:
>>> Since x86_64 always has SSE2, we can remove the fallback
>>> that was present for i686.
>>>
>>> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
>>> ---
>>>    host/include/x86_64/host/bufferiszero.c.inc | 5 -----
>>>    1 file changed, 5 deletions(-)
>>>
>>> diff --git a/host/include/x86_64/host/bufferiszero.c.inc b/host/include/x86_64/host/
>>> bufferiszero.c.inc
>>> index 74ae98580f..7e9d896a8d 100644
>>> --- a/host/include/x86_64/host/bufferiszero.c.inc
>>> +++ b/host/include/x86_64/host/bufferiszero.c.inc
>>> @@ -3,7 +3,6 @@
>>>     * buffer_is_zero acceleration, x86 version.
>>>     */
>>> -#if defined(CONFIG_AVX2_OPT) || defined(__SSE2__)
>>>    #include <immintrin.h>
>>>    /* Helper for preventing the compiler from reassociating
>>> @@ -119,7 +118,3 @@ static unsigned best_accel(void)
>>>    #endif
>>>        return info & CPUINFO_SSE2 ? 1 : 0;
>>>    }
>>> -
>>> -#else
>>> -# include "host/include/generic/host/bufferiszero.c.inc"
>>> -#endif
>>
>> The only other user for this file is now
>> host/include/aarch64/host/bufferiszero.c.inc.
>>
>> Code could be directly moved there instead, so host/include/generic/host/
>> bufferiszero.c.inc can be removed.
>>
>> It can be done in another commit though.
> 
> No.  Everyone who *doesn't* have such a file uses generic.
> 
> 
> r~

Oops, missed util/bufferiszero.c indeed.

