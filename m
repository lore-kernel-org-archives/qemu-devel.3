Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DE365CAC5BB
	for <qemu-devel@archiver.kernel.org>; Fri, 10 Oct 2025 06:56:56 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v773C-0007j9-Ny; Fri, 10 Oct 2025 02:56:26 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1v773A-0007iu-W1
 for qemu-devel@nongnu.org; Fri, 10 Oct 2025 02:56:25 -0400
Received: from mail-wr1-x42b.google.com ([2a00:1450:4864:20::42b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1v7737-0004H3-49
 for qemu-devel@nongnu.org; Fri, 10 Oct 2025 02:56:23 -0400
Received: by mail-wr1-x42b.google.com with SMTP id
 ffacd0b85a97d-3f1aff41e7eso1290574f8f.0
 for <qemu-devel@nongnu.org>; Thu, 09 Oct 2025 23:56:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1760079374; x=1760684174; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=DUDH1hROZs8SgyYwnHf33Sn+qSQDEixgLf4vPIhkQCc=;
 b=NxZWzv+KVQyY8EXZOA/BJlah6Ery07ed97HkybA11BUCBa+Lfx9OIMsEMcBh5jK4mP
 Wln740wDwCCwBJ4ARSxzvoQH2AB4+rPt5yGzGiRnrWrXwelkAPKfvUm9f3oKRRKOYxXD
 1+zuCJ6vTfA3l6ABwt/EWD4pHpSgZghqq7r1hNhx327TkVqj1UBXrBVcgjMYQTIhoA+v
 m9sJxEII/jl0eQHbQ2RgS50x7iuzpmMtmHE1zWscz7k5HIk4YHA13xcaFOcAtdbACBu8
 zckmskxxa+RBe1aPF+Pu8Obj/Hqr6SfsLjdfEzIYaOh+5DhWumb97u1jWiOXAGWVdKJL
 uSnw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1760079374; x=1760684174;
 h=content-transfer-encoding:in-reply-to:from:references:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=DUDH1hROZs8SgyYwnHf33Sn+qSQDEixgLf4vPIhkQCc=;
 b=Jexr7QYI/83v0RMVFnU7v29Fx51gztzi6hQi/sXSaCNZI70mPWC20I7HHmZGgwvAj2
 UMcT13VdZILdvrUC1Uvx6+tiCZYMuGcggF/yXS0Q6B5IMlR1EKk328hsx64fzxOED0yo
 lAb8H4vnb5QmnUoBgF8Zryt57WUIky5LGH0EI2+6iDJtzE9Fde0spBqLuxa/G9vScVsB
 TbKKAvikkhy6pxS0M4VaoTfYkUU6aWUjy4b7s8OHydcJLhTlRXayBR/6aFl1xU4RKEL0
 XLOrzOifasyGCwrgpjjbuR8b0icSdcfo5ssX1/GWBCZ/Crw4Z0MgMc7PINGCr468YCzu
 qq1g==
X-Forwarded-Encrypted: i=1;
 AJvYcCVS9bB/P/tbi0PAL5ypxvM4gmujXesLqW6NZUvEEgqAoZx9GlyWZk/ToGvTR70lDOd1UULjiMsNVFga@nongnu.org
X-Gm-Message-State: AOJu0YzW5kcpBWz/KDWxW0DgB5+1MFu0gAhcaVtD3W2anrL2PLWHgg58
 ecCmVPcFzZsPWlVA5xfObNUBNi0//7+0/RyRYKXFzwrO64szpvR2CTCwBSNHc84MDUMxQhALdkq
 f0hmL2vYS2w==
X-Gm-Gg: ASbGncv6u5DB7sPyKiyANiRFmKxcMQKSsDiqSM06yrX16ikA3m5cTisoHWrlA+UCx1T
 zhb2E2+08XItgweFzgGsChPVBasCo545ChRxTbYz/B+/3O430sk6qYaZ7ZvYPJLphmMcyF0JsdP
 Y3K+dWEgU6DVv59TXMZEqS/GxUs5iguewiOkKsoiFfRuSUhQUtMAwnzuqIi/4WxCVoNS8pv2pcl
 ES8Q6DO8OuXJMIocQrQSeUHgAMOAFjZR4tG3IsILY0LhNaDATDnKxmkIzljQUcV/hf5L5Ff865p
 ZMLzWd6+r0VnLm2ns1YjqS78g2wIX2wHPRSbBxDqEIl6vq38wlaJHsSLj1v4LH5mxxQr4tVDD+X
 V5AsG6y5QSWHqevmeaRXMAWkTzCSnhFBct1Fq0upwU/pS8c2Rb47/oCvxlGfmgAZgeQtMPjjCpN
 aPoRjKSXePzbjiMf6jIpWP1JVzuMWX
X-Google-Smtp-Source: AGHT+IEM7H0r/YPEnTiAzpo/rennLKDUpDjANurNiq38YMxpXrt7gjJuf5P5vqnyQGw6ywBnlteI0w==
X-Received: by 2002:a05:6000:1a8b:b0:410:3a4f:1298 with SMTP id
 ffacd0b85a97d-42667177dd6mr7684697f8f.15.1760079374097; 
 Thu, 09 Oct 2025 23:56:14 -0700 (PDT)
Received: from [192.168.69.221] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-426ce5e0a03sm2608626f8f.37.2025.10.09.23.56.13
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 09 Oct 2025 23:56:13 -0700 (PDT)
Message-ID: <250f202b-1ac1-45cb-bdcc-28c33fa9c377@linaro.org>
Date: Fri, 10 Oct 2025 08:56:12 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 02/10] target/openrisc: Explode MO_TExx -> MO_TE | MO_xx
Content-Language: en-US
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
References: <20251009081903.13426-1-philmd@linaro.org>
 <20251009081903.13426-3-philmd@linaro.org>
 <d2bb74d0-7e4f-45a2-8b94-d1f7a67cc8f9@linaro.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <d2bb74d0-7e4f-45a2-8b94-d1f7a67cc8f9@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42b;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x42b.google.com
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

On 9/10/25 18:43, Richard Henderson wrote:
> On 10/9/25 01:18, Philippe Mathieu-Daudé wrote:
>> Extract the implicit MO_TE definition in order to replace
>> it in the next commit.
>>
>> Mechanical change using:
>>
>>    $ for n in UW UL UQ UO SW SL SQ; do \
>>        sed -i -e "s/MO_TE$n/MO_TE | MO_$n/" \
>>             $(git grep -l MO_TE$n target/openrisc); \
>>      done
>>
>> Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
>> ---
>>   target/openrisc/translate.c | 16 ++++++++--------
>>   1 file changed, 8 insertions(+), 8 deletions(-)
> 
> Why bother splitting, instead of just changing to MO_BEUL, etc?

In v3 I'll add a new patch introducing mo_endian(). Even if a target
is only build for a particular endianness (sometimes a QEMU limitation)
I think having an explicit mo_endian() is useful because 1/ only a
single place to look at / change if more endianness support added
and 2/ common style between our different targets. Therefore for
this patch I prefer a mechanical change before manual following ones.

