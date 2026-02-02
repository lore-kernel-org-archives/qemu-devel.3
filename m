Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0DD94E7DF16
	for <qemu-devel@archiver.kernel.org>; Mon,  2 Feb 2026 17:57:22 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vmyAb-0007Re-3b; Mon, 02 Feb 2026 12:57:05 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1vmyAZ-0007Qj-5a
 for qemu-devel@nongnu.org; Mon, 02 Feb 2026 12:57:03 -0500
Received: from mail-pg1-x52c.google.com ([2607:f8b0:4864:20::52c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1vmyAX-0008GR-Ou
 for qemu-devel@nongnu.org; Mon, 02 Feb 2026 12:57:02 -0500
Received: by mail-pg1-x52c.google.com with SMTP id
 41be03b00d2f7-c65822dead7so1854006a12.3
 for <qemu-devel@nongnu.org>; Mon, 02 Feb 2026 09:57:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1770055020; x=1770659820; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
 :to:content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=831PZeoEGhHjEJFXtrpbmInT+faGeD93DRE7pLYd0XE=;
 b=sXCAmSkz9Yjo+BV1it9x8AtvFQOPr40G8YECGwzfskkzIkHNGdO7MfbE3N4PRiHy7d
 YVO+aJYRK7BzAKCYvWDL9PCWbsf5tA5o8P+5Hb58TblNFdM7TvIngrSG5huiDZQ6hv9J
 yHGqY6aSc97P9NayFXCqexuArsKElg5lVlZ6riPiyTyi7NpNnr4keJGEOs29leGDC4Os
 OHAZqDvjdhZIuBxwnHKfWyRrWfugoYx+Oj9l+e9iDKKwCV1VMtYjuPSpwpYIIRlsg1/L
 sBrHp5rIb9omZrM8g64GkuPHezbVRPfTMCRVZKEF0a9/OJYf/m7Lh+e75t6/ZNk32f8h
 mGhw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1770055020; x=1770659820;
 h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
 :to:content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=831PZeoEGhHjEJFXtrpbmInT+faGeD93DRE7pLYd0XE=;
 b=PBMCoGJyFzn+I8bCTxVTB9us2eIv5Q/cWmU9P9I6/nY0wyo3wpKH6180jyBVqAKOjF
 V8xwD9rJp+poeYWBwPo/ggEZHqWnY2FAk8igYWrt2vBcpMMLozbDID0Q58mn3LP3Mniz
 3fFzOByVCIhSW1Jcj5gGvMug5orvz6eSOCMREzWRLo7y5inUIGEopVo8ux6hAST6ZoZC
 tOxf/y//cnQBpFLDB9l8USdzV/ZkTk/Vwp+ZdCFXT0SYcpgWUIfnnaWgBiuFu4P8K+jB
 PFvg/nu/FTKXAezMIpLcjqTiI5kHVsnpxJgKD/vNBoXD31NhQT2+OTX+WHOSeyAIX3o3
 0JJQ==
X-Gm-Message-State: AOJu0Yw789EIeno7HmLG9OyxA0NVOBWwUJ6nm3hlVLNjRewafYvXv65L
 ow4tbHjoj4N/4Y17Y8MBPl0c2nxaKQtST9U2+UXgcrjUSgEAg3O+84/kRCiuHyEtJSE=
X-Gm-Gg: AZuq6aL88Lgn1MuB/xeuzNh15KExrAGriU3V4j2tUaAgxth1Ol3NQqsVKdu8/XkC4Lx
 MNGpBRFZM55ZBE7b6FvZq2soGcWf9swWia67COYM+UVH1XRALOgpVsXnXdkZurLPFlfKaev9PKN
 dvjcwhr/Ei2sMkBvtPtlyRy5xM3L8aAUgsFl17lQM984ojxfV/TJMn+PXGz6TTL1TU8vmaJYJ76
 rPNuGvBeFaVTLhBT8mharufQK5hPfLJM5JpTh1uBy2McjbRsQCV41+mNB4pZxnJMyzb1H0/Sl/V
 vKiyQpYznZZAPduVeYSqx5fpNH28UMgXEcUE0OU7rgw7fDxRxixxf3W7jiqsCJzmSzXDYFFWEl4
 h1y6m4B7PbH6tR/MOMN2+c1pOtcLo7SV+5LxIlE7OFI/Z2aLtz0Lz4MYJkkUOaBj1yUww8Y3LIQ
 z7wKcMtpdL2RYr+al8xkHJfQNB8cJ3yc+1+VSljvEtKHjeNEpntBag4eHQ
X-Received: by 2002:a17:90a:d604:b0:349:3fe8:e7de with SMTP id
 98e67ed59e1d1-3543b3ad375mr10891843a91.28.1770055019936; 
 Mon, 02 Feb 2026 09:56:59 -0800 (PST)
Received: from [192.168.1.87] (216-71-219-44.dyn.novuscom.net. [216.71.219.44])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-3547778cb83sm112208a91.13.2026.02.02.09.56.59
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 02 Feb 2026 09:56:59 -0800 (PST)
Message-ID: <041edfda-541f-4274-94ba-b7e6b64399ac@linaro.org>
Date: Mon, 2 Feb 2026 09:56:58 -0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 06/11] target/ppc: Introduce ppc_code_endian() helper
Content-Language: en-US
To: Anton Johansson <anjo@rev.ng>, =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?=
 <philmd@linaro.org>
Cc: qemu-devel@nongnu.org, Chinmay Rath <rathc@linux.ibm.com>,
 Nicholas Piggin <npiggin@gmail.com>,
 Richard Henderson <richard.henderson@linaro.org>, qemu-ppc@nongnu.org
References: <20260122221106.57184-1-philmd@linaro.org>
 <20260122221106.57184-7-philmd@linaro.org>
 <aYC1bfhw1CtIED8Y@hive.localdomain> <aYC28VNE0yNjlJw6@hive.localdomain>
From: Pierrick Bouvier <pierrick.bouvier@linaro.org>
Autocrypt: addr=pierrick.bouvier@linaro.org; keydata=
 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
 ZtfdHNZotF092MIH0IQC3poExQpV/WBYFAI=
In-Reply-To: <aYC28VNE0yNjlJw6@hive.localdomain>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::52c;
 envelope-from=pierrick.bouvier@linaro.org; helo=mail-pg1-x52c.google.com
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

On 2/2/26 6:39 AM, Anton Johansson wrote:
> On 02/02/26, Anton Johansson wrote:
>> On 22/01/26, Philippe Mathieu-Daudé wrote:
>>> Introduce the ppc_code_endian() helper which returns the
>>> MemOp endianness for the CODE path.
>>>
>>> Use it in need_byteswap(), removing one TARGET_BIG_ENDIAN.
>>>
>>> Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
>>> ---
>>>   target/ppc/translate.c | 11 ++++++-----
>>>   1 file changed, 6 insertions(+), 5 deletions(-)
>>>
>>> diff --git a/target/ppc/translate.c b/target/ppc/translate.c
>>> index 17e6d07c8c2..4a9199a4473 100644
>>> --- a/target/ppc/translate.c
>>> +++ b/target/ppc/translate.c
>>> @@ -214,14 +214,15 @@ static inline bool is_ppe(const DisasContext *ctx)
>>>       return !!(ctx->flags & POWERPC_FLAG_PPE42);
>>>   }
>>>   
>>> +static inline MemOp ppc_code_endian(const DisasContext *ctx)
>>> +{
>>> +    return MO_BE ^ (ctx->le_mode * MO_BSWAP);
>>> +}
>>
>> This was not super obvious to me, is this a common pattern?
> 
> Ignore this comment, I see we do it for translator_ld*()!:)

I agree that even though it's used there, it's far from being obvious 
when reading it :)

