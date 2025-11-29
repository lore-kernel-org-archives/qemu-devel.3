Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DED6AD116EA
	for <qemu-devel@archiver.kernel.org>; Sat, 29 Nov 2025 14:18:16 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vPLlT-0005be-2G; Sat, 29 Nov 2025 09:17:31 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vPLlQ-0005b9-VU
 for qemu-devel@nongnu.org; Sat, 29 Nov 2025 09:17:28 -0500
Received: from mail-wm1-x330.google.com ([2a00:1450:4864:20::330])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vPLlP-0006vW-Gs
 for qemu-devel@nongnu.org; Sat, 29 Nov 2025 09:17:28 -0500
Received: by mail-wm1-x330.google.com with SMTP id
 5b1f17b1804b1-47774d3536dso21838145e9.0
 for <qemu-devel@nongnu.org>; Sat, 29 Nov 2025 06:17:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1764425845; x=1765030645; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=Jnhk6bB2EkTrcFrInfuDuaY7eciA+m/hwXFEtwcfF7Q=;
 b=vd+q0l0m7BxVV7sfUa12otr4zt5+AiD0NdCQtxvJ9kCC/mU0nGqGj1REepiuSXSfjD
 dBOYS80+8fmE7eTVvs3Ft4MaVkXrOi10CRg0EHZ3iWZlnkM4PgWb0A80CCe4uFvYU70+
 rmuuxy/p5tBtJiDoOr/MMAAI/2pimSVfUcyqTutVBc0JIi8fzserpRJtRmCEZbEOJs9r
 omimWypb0cpY9eIyfK94Oyy+H9GsZ3oZRaR3DMAs+4JFrLNn0ycnbp6quS6/ycc/ASwM
 2t9ebg/zQC/uS1dwpgO/NlwKYXRcCj+eUWz/Zw1jsG7ey5vcDGNQRtKGDCeW+UWlrwpk
 KS0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1764425845; x=1765030645;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=Jnhk6bB2EkTrcFrInfuDuaY7eciA+m/hwXFEtwcfF7Q=;
 b=jGJPO7JKJERQSwMRnN9jr35mw7vMDhQxXnYywRwyM9MqSRiUEX2xvunW+LGoS1HE17
 escd5oLratb72luXuauNU1VAS+faK85ciUEJMUsw/nTahAf82JAnErDJs+ISMC1qG8ha
 x5Rn500gRrPrvRLgO/vA8gKq1U/6Dwhc9OVRK38Xv7M5x0AMcDWK6/+g50zeHX1/Qq0v
 6JaK7YuWWCAV0NM8ZZzbuo5M2bCeeNDkiIJFc75CpqGSZ3W2w/pa4xYImt+HuC1itYvu
 Hvz/4vF3celIPCN4fFyaxGomzc7mY0lV8CeK8zYMt9V32jxnAUkhdReonJxOuLO7K4UY
 xk0A==
X-Forwarded-Encrypted: i=1;
 AJvYcCUFfqJcSA2g6SSlb6WtAe8+ZVkLDVOAzDClZpOSjGoKsmsAjq8X9c2NmvHhU6j34PTGFkiT7jDZW2ek@nongnu.org
X-Gm-Message-State: AOJu0YwZK0uM5TiSiUxHaDq9U+NcK/OmtMcbe7rdgru9PjqcFCrafbv5
 /cTZCIOxuyukWNmLK004F8CBbQ0MArrCeXIGdFELMwr0r+W1EOCuFxu1/C8kWfseBOQ=
X-Gm-Gg: ASbGncvzzetYUmpOlaiETCZkpRIbOqZN2/JMoBvHwvP8JmCSSKmXGKylkzJxdwrp/Ia
 LzN35wukVDzSrw4gOrJmkiFfEB15iqD7QwTEcTohFDd7uZActFlnOkcLh2ryq+9SHnzuKOSJlqY
 h35rZmB+fPw2bEndCb1LY7FQPeOFKQEpk9kz/3hc+7/rN1qg6e74bGB7heSerW+PRf3YRvbb1FR
 gro1Fn+rzzOLb72zLvT5iTqXFvqTBOg2R9xtlJ+7X1NYRCR8ORRmPh1UziuiOWlULVLjtjk875A
 c39CIjEX8wWfsNv1lDK8HqBRb3WIZVrFUm1eZ+r9GbQY9gEv69tb5xjcNQwfYvu3GXuruPP4SkB
 PZqMZIMVlnPUvuqPxCCqmnqHdbliWj5Pyefwsk6bx8iliQfTdAtS8abEqDKnKEZz6bXHHfUBFK6
 pmNw/SxalnDY0b4gAod5ChsRc1kF47//w=
X-Google-Smtp-Source: AGHT+IEaufXXM5qRZ6u3bD5YrrwEjgho8E+s1w3UNY642rwVKbX0RrxYjA7ovPlllzhqu/Bv1oQc9w==
X-Received: by 2002:a05:600c:3b01:b0:475:d9de:952e with SMTP id
 5b1f17b1804b1-477c04c357dmr285218315e9.1.1764425845502; 
 Sat, 29 Nov 2025 06:17:25 -0800 (PST)
Received: from [192.168.1.152] ([78.196.4.158])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4790ab8bb21sm207530665e9.0.2025.11.29.06.17.24
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sat, 29 Nov 2025 06:17:24 -0800 (PST)
Message-ID: <6546cd49-008a-492a-ac0a-5f63ac21e39e@linaro.org>
Date: Sat, 29 Nov 2025 15:17:24 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 8/8] chardev/char: qemu_char_open(): add return value
Content-Language: en-US
To: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>,
 marcandre.lureau@redhat.com
Cc: pbonzini@redhat.com, qemu-devel@nongnu.org, d-tatianin@yandex-team.ru
References: <20251129134350.487839-1-vsementsov@yandex-team.ru>
 <20251129134350.487839-9-vsementsov@yandex-team.ru>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20251129134350.487839-9-vsementsov@yandex-team.ru>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::330;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x330.google.com
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

On 29/11/25 14:43, Vladimir Sementsov-Ogievskiy wrote:
> Accordingly with recommendations in include/qapi/error.h accompany
> errp by boolean return value and get rid of error propagation.
> 
> Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
> ---
>   chardev/char.c | 15 +++++++--------
>   1 file changed, 7 insertions(+), 8 deletions(-)


> -    if (cc->chr_open) {
> -        cc->chr_open(chr, backend, errp);
> +    if (cc->chr_open && !cc->chr_open(chr, backend, errp)) {
> +        return false;
>       }
> +
> +    return true;
>   }

Alternatively:

     if (!cc->chr_open) {
         return true;
     }
     return cc->chr_open(chr, backend, errp);

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>


