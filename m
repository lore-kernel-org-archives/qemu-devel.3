Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 406FBD26D9E
	for <qemu-devel@archiver.kernel.org>; Fri,  9 Jan 2026 21:31:03 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1veK3z-00017K-AI; Fri, 09 Jan 2026 16:30:31 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1veK3t-00016V-RW
 for qemu-devel@nongnu.org; Fri, 09 Jan 2026 16:30:28 -0500
Received: from mail-pj1-x1035.google.com ([2607:f8b0:4864:20::1035])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1veK3s-0002UR-3D
 for qemu-devel@nongnu.org; Fri, 09 Jan 2026 16:30:25 -0500
Received: by mail-pj1-x1035.google.com with SMTP id
 98e67ed59e1d1-34c868b197eso4077606a91.2
 for <qemu-devel@nongnu.org>; Fri, 09 Jan 2026 13:30:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1767994222; x=1768599022; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=pmLRiJGAe32AZkkzXPXqZG7JFN/54iycc+dJ2yegT6s=;
 b=yuICwL+jtwJOhb+F+Bfsyl0SMY9w5hxfYoUshwY/ILdtCDkbwNZaCRWyBCEARVWvSc
 f2xQM0B7KUZvrRLPaUNgRJmHgqWJi+fihVr4E+KixmRg/zXgAnAm/t11fra14xXeSxdi
 AmUc8lyV9rn0RW6f3Ihmd8snMfVaHAbOEGWUuWHvQSL4BgTGs4svWgTmwZ5I38jkcQs5
 KMkuyyZrFzhusZ8pK5ZM4D9sCjsA6pLM85lAleP79S+jJwgkOz7S7U2VbTm9THnG/+A2
 wVc5SHQCPbxzU9xGJvJvgLtBrCOqU6Eu1/Y5kISVpexsyrVn7sa2hm6I+DLD62szDwti
 5h+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1767994222; x=1768599022;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=pmLRiJGAe32AZkkzXPXqZG7JFN/54iycc+dJ2yegT6s=;
 b=rw4YzJet4C38RF7l1yO/NbEzrMB5yEAAndHLXANa+3TfazTZIb4szN4uP2I5bVKBFl
 yL5UbvFyX17eaoZaN7llnfB9Zt2lERPTdSPNVsxN4Q2LqRfcbFBqE+xRlxmBHModT3zx
 ogxkJK2VOUTl1OU4P0IUR6AQzSPAnfB14Ra/vbItyFTAOj0gMlyK1PugEK5M+1hji1tu
 0nnI6w0iPITq0dgRwT4gacGNjhPrffkyg3WgMJA4EpuemYTryoakI5FG+kRaAySDRJP1
 CIWfSD4F578VNQ98fA6KwzgYscv93NdP65Ycr1a22HZIcwsFyIdO61P1ugb51JU7/jPA
 tN9Q==
X-Forwarded-Encrypted: i=1;
 AJvYcCX/aC9Fay98x1WF7dCQn1fMoFB7dK3eRVxxKWgdHRHplqSg4mLYCuF+dh46xyZyHS0BQa5PfzxJ9ymC@nongnu.org
X-Gm-Message-State: AOJu0YwZrtTvHtdv4i8zuCwTagAnVM8XgNYx4IFxIdu4I9VFzLn8IV9t
 OCb5T7Ybud6p8aYZh7QQ1CaGp6FszyJGvkXGPuO0NXg6a+z8W2WYJrwgnjklRV2nVr4=
X-Gm-Gg: AY/fxX5yvcXRV3pidZg4/2p0f/uVxaaOASeyPLHlvLYQVaDr/Wy4jmlHvdVU+SQwTDp
 iygdhGJX3YdeD++uzW6z8fUtO3f+rrfjN63zmB4JK5ZvMCeMuJBBl4ijC09qas8vdTeW/hkp3km
 P9iHINxT+tAqZ6lWC3pC+OXbPa82uZX9ywvHOoAr1iGjhyh8uzYvzBXtmkkcvBnFaCZNWfm6WOG
 QYuXRIccPGJOO/3HsJiRSCCXk9UJxwechA6j7zNt7ZhnTjup9UKtS2gangVFow2T3z8IgaNYyCd
 T4Tyt5veMJefoT8b0cUxm42zGMayJFaHf30oTs1Atbu00n5msA1WdzKLAdwiBGnDoY+FqeWwiQo
 IRI5Qfl3I/eiC9vLgTZzXpdW1iL+HQfQiQ2US+Y3cCTjT+kPW8jkM2c5+aKSyroFEL9nFTMNH8b
 6DrVh0DDoL9xUkWw4YE3uzqPClmwvnzSu63iPTqFN9YhzQM/HV04C84RwM
X-Google-Smtp-Source: AGHT+IHn3NDOWCdCmWPJvP7a8PcGLrm6YvriYiV30Ahc+eetAo2huFi8+0G+kryF9aTEgSHgePNadw==
X-Received: by 2002:a17:90b:17cd:b0:340:f05a:3eca with SMTP id
 98e67ed59e1d1-34f68c4d69bmr10819362a91.20.1767994222235; 
 Fri, 09 Jan 2026 13:30:22 -0800 (PST)
Received: from [192.168.1.87] (216-71-219-44.dyn.novuscom.net. [216.71.219.44])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-34f5f7c4141sm11468363a91.6.2026.01.09.13.30.21
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 09 Jan 2026 13:30:21 -0800 (PST)
Message-ID: <ae624681-1ea4-46b4-9dd2-0f558f2749df@linaro.org>
Date: Fri, 9 Jan 2026 13:30:21 -0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 05/29] include/exec/helper-{gen, proto}.h: add conditional
 HAS_HELPER64 define
Content-Language: en-US
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Jim MacArthur <jim.macarthur@linaro.org>, anjo@rev.ng
References: <20260109053158.2800705-1-pierrick.bouvier@linaro.org>
 <20260109053158.2800705-6-pierrick.bouvier@linaro.org>
 <bcad5451-4779-4914-9b8f-e63bfe5a2b26@linaro.org>
From: Pierrick Bouvier <pierrick.bouvier@linaro.org>
In-Reply-To: <bcad5451-4779-4914-9b8f-e63bfe5a2b26@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::1035;
 envelope-from=pierrick.bouvier@linaro.org; helo=mail-pj1-x1035.google.com
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

On 1/9/26 1:22 PM, Richard Henderson wrote:
> On 1/9/26 16:31, Pierrick Bouvier wrote:
>> It allows to include helper for 64 bits variants selectively, by
>> including helper-{gen, proto}.h and defining HAS_HELPER64.
>>
>> Signed-off-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
>> ---
>>    include/exec/helper-gen.h   | 6 ++++++
>>    include/exec/helper-proto.h | 6 ++++++
>>    2 files changed, 12 insertions(+)
> 
> I guess I'll need to read further to find out what you want,
> but you shouldn't need this.
> 
> I've built these headers for multiple inclusion, so that the HELPER_H manipulation can be
> done by the target.  You shouldn't need to modify the generic headers.
> 

Unfortunately include/exec/helper-gen.h harcodes the name helper.h, so 
an extension is needed there.

An alternative is to stop using helper-gen.h, and do the include by 
hand, but it's more verbose in my opinion. For arm, it means moving this 
to every .c (instead of translate.h), and manually add:

#define HELPER_H "helper.h"
#include "exec/helper-gen.h.inc"
#undef  HELPER_H
#define HELPER_H "helper64.h"
#include "exec/helper-gen.h.inc"
#undef  HELPER_H

If you prefer this, I don't mind changing. It just seemed like the right 
abstraction since most of arch will have the need to define 32 and 64 
bits helpers.

> 
> r~
> 
>>
>> diff --git a/include/exec/helper-gen.h b/include/exec/helper-gen.h
>> index f7ec1556997..c96e13b835a 100644
>> --- a/include/exec/helper-gen.h
>> +++ b/include/exec/helper-gen.h
>> @@ -13,4 +13,10 @@
>>    #include "exec/helper-gen.h.inc"
>>    #undef  HELPER_H
>>    
>> +#ifdef HAS_HELPER64
>> +#define HELPER_H "helper64.h"
>> +#include "exec/helper-gen.h.inc"
>> +#undef  HELPER_H
>> +#endif
>> +
>>    #endif /* HELPER_GEN_H */
>> diff --git a/include/exec/helper-proto.h b/include/exec/helper-proto.h
>> index 6935cb4f16f..002460722e3 100644
>> --- a/include/exec/helper-proto.h
>> +++ b/include/exec/helper-proto.h
>> @@ -13,4 +13,10 @@
>>    #include "exec/helper-proto.h.inc"
>>    #undef  HELPER_H
>>    
>> +#ifdef HAS_HELPER64
>> +#define HELPER_H "helper64.h"
>> +#include "exec/helper-proto.h.inc"
>> +#undef  HELPER_H
>> +#endif
>> +
>>    #endif /* HELPER_PROTO_H */
> 


