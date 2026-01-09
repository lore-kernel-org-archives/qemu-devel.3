Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D39F7D26D9F
	for <qemu-devel@archiver.kernel.org>; Fri,  9 Jan 2026 21:37:44 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1veKAY-00050d-Pd; Fri, 09 Jan 2026 16:37:18 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1veKAX-000506-NE
 for qemu-devel@nongnu.org; Fri, 09 Jan 2026 16:37:17 -0500
Received: from mail-pl1-x636.google.com ([2607:f8b0:4864:20::636])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1veKAV-00041M-Qf
 for qemu-devel@nongnu.org; Fri, 09 Jan 2026 16:37:17 -0500
Received: by mail-pl1-x636.google.com with SMTP id
 d9443c01a7336-2a102494058so15610315ad.0
 for <qemu-devel@nongnu.org>; Fri, 09 Jan 2026 13:37:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1767994634; x=1768599434; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=tQwSKkdtw23GxXnOmQ1Q7mn68L0Nx+Fsgm1qj7J4Gsk=;
 b=pjgJ4zIfZ7fdlCQAFZwOBcovYryP8kfTgYBQmjn/8H0fFeLpQMPh4jOX0reRNLmyF/
 Lp1mu2xg4l5s4Q0PDkcFpEZdvVCy+3Yc/aFCwPgbuiYdZLiYS1OpQpqZwGU6eS/3l1Zf
 WjWW688zTnq6zrA0oMJBhsZmRpKAXYvLLh0dfOg3Kh5fMQBgugvP7ec5gPQYmv4IMP1F
 KcsR5DLY0zsuel0gYP8rFZJmU0g/r5mtkGxLDktI38OhEnH12YOLfBTYe9IHkbGuNoe6
 Dtv1L1S6ttDFGpbCPSUR/E0yH3ZyB6macLhEB3jfB/mawiEQoFnVvUH+/1jWrkuD0iQU
 gg7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1767994634; x=1768599434;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=tQwSKkdtw23GxXnOmQ1Q7mn68L0Nx+Fsgm1qj7J4Gsk=;
 b=uxd9agiruaVLg2C/FN482tszdBWnOB320Ev6oqS29H3Xxl4CykPVV7YcNxeEYlFnK4
 vXrYbvuzUnvocc+XX2Oaqg9BUZnYgS3vBGOLdxRE4u/HXPPf+1HbLrVYfsWW6/UGBwO7
 vEGjvGArNdSQWFZb58OY22rJ3jqle93RVXYZme/EZEVLsdg6W94vySjAu34o2bZi8W29
 +qrDm+Wf+iYsf5SkWeObtcXDJAxHmichUNKgvrCtWLc59iH1/iZxlcDPzilsNd98s8kg
 v+b7xy+Q8bgV39C6xKCoXRzqr2FhVaVkurzcMC+GOtP/0L5DTYIF6/ZHx1ShoUT1Taye
 zE4w==
X-Forwarded-Encrypted: i=1;
 AJvYcCXvLgnl8vOSFKrdjeuA6wEUv59QG8zQKKpH21xM/C//DvRcjGOMWdnW3lSa+jWTu/Hgf6rn7sTc0N79@nongnu.org
X-Gm-Message-State: AOJu0YyjIjHHLIY511992LfsQEaF0ec/B/qeBjAyew+SLHtaF4o6gWsK
 8gJX88MvHXrJc+4mNFnfv61jsAk1aX1mtePwZsLsBpDXTTIrdtJ06shDPwTFfYhizGY=
X-Gm-Gg: AY/fxX6CzI8R/Xr4poD0llmTiBNy09o3Zj6c4pGwk+Tw26on1H+GWKo7tgzN4Kh5d0Z
 vNCSTUsgESsaPfdsKMxDpkxxdX1wIUNMPGLmCRH+p/6cvan0El8zTrQRbs3mzYnHUpYQI1p5QJR
 zkTrZt7PezrD7NFkwvom1b2Ml5c4oNvXTL947gracowSbip96qvrtR9dYngbsQzNbYQYzP1FfQ0
 ZMo6DzAZPT/Vf2fTAYPuSrRRC76R8NooXpz92nw322/ZPbgSLMUtpcAEagcTrJjtUJUJZcE+DaJ
 6b/v4qJZQoohawoVhhH/JzsEkPDA1VIweAflQOZFUYTrsUVkNMYpgmM98VfblddzCmUTq9qHFdw
 Sh+SmE6gb/1OyBb0+xix9iJ7AAOy29kT7YNyHKlJ9t1S3nX6llen2wEF0AnHBvf9ZM+2cAHZ010
 AU2KCcMZo6KP1EHw71Mx9GfG0oWuZLrJiefREHs+EsRyrYA5+cbtTwZIZi
X-Google-Smtp-Source: AGHT+IGCMrgou9jRaYsppcEXfGsFpKsFO/0WYNMHj9mvkXTzsNY9v8kHMuFXQz+Cp24LVkvnv2GI+g==
X-Received: by 2002:a17:903:3c64:b0:2a0:9047:a738 with SMTP id
 d9443c01a7336-2a3e39d838emr128541875ad.19.1767994633973; 
 Fri, 09 Jan 2026 13:37:13 -0800 (PST)
Received: from [192.168.1.87] (216-71-219-44.dyn.novuscom.net. [216.71.219.44])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2a3e3c39fefsm114283305ad.17.2026.01.09.13.37.13
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 09 Jan 2026 13:37:13 -0800 (PST)
Message-ID: <e6a2191a-0b72-402e-9b06-d06269b5363e@linaro.org>
Date: Fri, 9 Jan 2026 13:37:13 -0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 06/29] target/arm: extract helper64.h
Content-Language: en-US
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Jim MacArthur <jim.macarthur@linaro.org>, anjo@rev.ng
References: <20260109053158.2800705-1-pierrick.bouvier@linaro.org>
 <20260109053158.2800705-7-pierrick.bouvier@linaro.org>
 <059994bb-41af-4fed-a058-b100b4a3734f@linaro.org>
From: Pierrick Bouvier <pierrick.bouvier@linaro.org>
In-Reply-To: <059994bb-41af-4fed-a058-b100b4a3734f@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::636;
 envelope-from=pierrick.bouvier@linaro.org; helo=mail-pl1-x636.google.com
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

On 1/9/26 1:30 PM, Richard Henderson wrote:
> On 1/9/26 16:31, Pierrick Bouvier wrote:
>> --- a/target/arm/tcg/translate.c
>> +++ b/target/arm/tcg/translate.c
>> @@ -26,6 +26,9 @@
>>    #include "arm_ldst.h"
>>    #include "semihosting/semihost.h"
>>    #include "cpregs.h"
>> +#ifdef TARGET_AARCH64
>> +#define HAS_HELPER64
>> +#endif
>>    #include "exec/helper-proto.h"
>>    #include "exec/target_page.h"
>>    
>> @@ -33,6 +36,12 @@
>>    #include "exec/helper-info.c.inc"
>>    #undef  HELPER_H
>>    
>> +#ifdef TARGET_AARCH64
>> +#define HELPER_H "helper64.h"
>> +#include "exec/helper-info.c.inc"
>> +#undef  HELPER_H
>> +#endif
>> +
>>    #define ENABLE_ARCH_4T    arm_dc_feature(s, ARM_FEATURE_V4T)
>>    #define ENABLE_ARCH_5     arm_dc_feature(s, ARM_FEATURE_V5)
>>    /* currently all emulated v5 cores are also v5TE, so don't bother */
> 
> In the ideal case, only the files that require the helper data will include it. So, for
> example, the helper-sme.h data would only be included by translate-sme.c and sme_helper.c,
> etc.
> 
> I now see that while I planned for this with how I set up HELPER_H, I didn't follow
> through with the cleanups anywhere.
> 

I'm ok to do this if you prefer.

In this case, may I suggest we rename helper to something different and 
let actual names be placeholders for:
#define HELPER_H "helper-impl*.h"
#include "exec/helper-gen.h.inc"
#undef HELPER_H

This way, C files don't have to deal with this, and simply see:
#include "helper.h"

Any other name is welcome is you prefer.

> 
> r~


