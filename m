Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7401010F6FCB
	for <qemu-devel@archiver.kernel.org>; Wed,  1 Apr 2026 15:09:37 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w7xBZ-0007Jf-3T; Wed, 01 Apr 2026 11:08:49 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1w7xB4-0006yV-Fl
 for qemu-devel@nongnu.org; Wed, 01 Apr 2026 11:08:20 -0400
Received: from mail-pg1-x535.google.com ([2607:f8b0:4864:20::535])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1w7xB2-0004zl-4F
 for qemu-devel@nongnu.org; Wed, 01 Apr 2026 11:08:17 -0400
Received: by mail-pg1-x535.google.com with SMTP id
 41be03b00d2f7-c06cb8004e8so2828434a12.0
 for <qemu-devel@nongnu.org>; Wed, 01 Apr 2026 08:08:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1775056093; x=1775660893; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:autocrypt:references:cc:to
 :from:content-language:subject:user-agent:mime-version:date
 :message-id:from:to:cc:subject:date:message-id:reply-to;
 bh=2ck0U6aROSJUofviXgnTWrJTFFjrRL0Xg5ByJrn5LgU=;
 b=ZC17I+8Og85y5AcRBk2Q49lIAFbI361x6CSzlqJRn20ZZXSveuW9xiEASo07vZJw8r
 tgiapK7bRV7Fdm47UBsilzffv+V52IfKRbjSRQHu59RcuHKpWhXe7/9W+iqnDWZQxi6D
 N+8L/+nvjzpaj+/Vukmu0bxv3k3l8OOxBStVjfTn2TO+9GSzg+l6xU0U1vS6hmrFN7NI
 3+qLD0mxZ/qZOhqoZzQznMKksU/YRq4LxNihaeCjKEAI7fEcwWupZRo31er9f/7YLkGf
 RgvkHdj5PJALTNOwfq3j7qg1WEAam7sfmyMmYe5bMZo1vh7azbY5+ACyZW67Jq5BXNcL
 wgVw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1775056093; x=1775660893;
 h=content-transfer-encoding:in-reply-to:autocrypt:references:cc:to
 :from:content-language:subject:user-agent:mime-version:date
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=2ck0U6aROSJUofviXgnTWrJTFFjrRL0Xg5ByJrn5LgU=;
 b=FD4Ct6B+tviGTI64Bl0biIP9Do8Iplp9TY9UcgXqp6Z+EvN8ab4h9Ryce9Hcdm1jqj
 ESZB/aH5la7uJGHp3s+iTNmo63uKsAc7Sz67M9cyyx+FLbdGDKiRrLWZ38xzQkPuOKQj
 9a3QIUawamm0f6l3u5ByM60kiCovKtvSP+P76UEJUilQaKHYREu7GPKtn+6c5w7fypX4
 raR8p8XbPRQ9qrRiSaIC2/aTiAxaMARmP0BcZKtaGn67KDqT6Ms5nmjlwig3S2bgyzP7
 0bppoPv6vW9Pz+imNcUnweXCfyUw/7TCV+1dRSsWhjW3xXIH1Vh1XuuMBr9gisaDcH4K
 QqQA==
X-Forwarded-Encrypted: i=1;
 AJvYcCVlhtj262dX/tXu4OdpEBOVI5mR/egtWESyKZ/wa7OP5+yw2Kt2nsbg4RRUnw/0wU/YH3vNU6uIpyoS@nongnu.org
X-Gm-Message-State: AOJu0Yx3GPQeXCETNFnulOedNrO7orsd3IIwt4wDl14FacXwRTRGwz3i
 miYiJv16udGXhZBgmJvAKC5ix/w3wB/n05LXxsYauc7T8fbRR9SNgx+Qz9eaIlwEyvA=
X-Gm-Gg: ATEYQzzOkm5QYYNsY2LDEpfGXFheYBsk0eKAfPBsYJtQ1ddl6u/WnMxDhLtYy0wexVT
 Aukl4046aLHsog+yEq9FYz3xQr0sOy10ft6CTLCbkMxxG3sGVXImBebDVFg2wUoHeDa4j5RXceH
 jrtRX2p8L7SnLpFW1eu0uPzgTDp/7IfiPtWn7OjED9Cfzm96wDSUUPSf3+OwTU467Fn/9CKpLKV
 XbOsMfxY1IPDg+XPdt5nmXvuqLnb76Ymiy9AYmeKx5zKlRjUUbgcWSBOJdjr4ACdhvmcJSbwylf
 3IxM19Ro6WsLvnWBhgXAdgGPsFpnDAo6a4a6xRBbnU9YY+BNJMTnhSlziE/Qj2CnOEziTm2YTUd
 LKcxtmYU10TSPpfsTViNGXDHanzrZturT62TiGWy6+Nt35YEnV4WQ0TJgkFGW74HQ0HITgVKqKU
 2zs6AA7pTHNLY71JeAbGTHZXaZLi2kiA5NDCR5UcKdhxU7OqiQKnDaz0X+30tRwnafUmNv
X-Received: by 2002:a05:6a20:7fa9:b0:398:b499:44f1 with SMTP id
 adf61e73a8af0-39ef777be6emr4185386637.58.1775056093221; 
 Wed, 01 Apr 2026 08:08:13 -0700 (PDT)
Received: from [192.168.1.87] (216-71-219-44.dyn.novuscom.net. [216.71.219.44])
 by smtp.gmail.com with ESMTPSA id
 41be03b00d2f7-c76c65a3f08sm203065a12.31.2026.04.01.08.08.12
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 01 Apr 2026 08:08:12 -0700 (PDT)
Message-ID: <a121306e-79c9-464e-9511-1997bc3d00e9@linaro.org>
Date: Wed, 1 Apr 2026 08:08:12 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH-for-11.1 1/2] target/mips: Expand TCGv type as 32-bit for
 XBurst MXU
Content-Language: en-US
From: Pierrick Bouvier <pierrick.bouvier@linaro.org>
To: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 qemu-devel@nongnu.org
Cc: Jiaxun Yang <jiaxun.yang@flygoat.com>,
 Aurelien Jarno <aurelien@aurel32.net>, Aleksandar Rikalo
 <arikalo@gmail.com>, Anton Johansson <anjo@rev.ng>,
 Siarhei Volkau <lis8215@gmail.com>
References: <20260401144503.80510-1-philmd@linaro.org>
 <20260401144503.80510-2-philmd@linaro.org>
 <03df34f1-674a-4e52-bd22-ad77e7884b6b@linaro.org>
Autocrypt: addr=pierrick.bouvier@linaro.org; keydata=
 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
 ZtfdHNZotF092MIH0IQC3poExQpV/WBYFAI=
In-Reply-To: <03df34f1-674a-4e52-bd22-ad77e7884b6b@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::535;
 envelope-from=pierrick.bouvier@linaro.org; helo=mail-pg1-x535.google.com
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

On 4/1/26 8:00 AM, Pierrick Bouvier wrote:
> On 4/1/26 7:45 AM, Philippe Mathieu-Daudé wrote:
>> The MXU extension is only built as 32-bit, so TCGv expands
>> to TCGv_i32. Use the latter which is more explicit.
>>
>> In gen_mxu_s32madd_sub() directly expand:
>>
>>    - tcg_gen_ext[u]_tl_i64 -> tcg_gen_ext[u]_i32_i64
>>    - tcg_gen_concat_tl_i64 -> tcg_gen_concat_i32_i64
>>
>> the rest being mechanical changes.
>>
>> Cc: Siarhei Volkau <lis8215@gmail.com>
>> Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
>> ---
>>    target/mips/tcg/mxu_translate.c | 1954 +++++++++++++++----------------
>>    1 file changed, 977 insertions(+), 977 deletions(-)
>>
> 
> Yes, it's the kind of changes we should do, but as you see, it's quite
> invasive and produce massive patches that can be hard to review.
> That's why I'm more in favor to keep TCGv and all tcg_gen.*tl as it is,
> and add magic in header to compile it as expected.
> 
> That said, there is nothing wrong with this patch, I'm just questioning
> the approach for all other targets.
> 
> Reviewed-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
> 
> Regards,
> Pierrick

One solution we could use, is

in tcg-op.h:

#ifdef COMPILING_PER_TARGET
/* we make sure there is no TCG_TL_BITS definition, and define
    it as TARGET_LONG_BITS */
#ifdef TCG_TL_BITS
#error You should not define TCG_TL_BITS for target specific files
#endif
#define TCG_TL_BITS TARGET_LONG_BITS

#else /* ! COMPILING_PER_TARGET */
#ifndef TCG_TL_BITS
#error TCG_TL_BITS should be defined for common code
#endif
#endif

#if TCG_TL_BITS == 32
... /* define TCGv as 32 bit + tcg_gen_ops */
#elif TCG_TL_BITS == 64
...
#endif

And in a given C file:
#define TCG_TL_BITS
#include "tcg-op.h"

This makes sure that for common code, we have explicitly chosen a 
variant for tcg operations. As well, for target specific code, there is 
no changes needed.

So we get the exact same result and compile time guarantees than your 
changes, but without any massive patch to change all occurences.

Regards,
Pierrick

