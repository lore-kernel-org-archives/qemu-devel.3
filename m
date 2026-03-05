Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D9527F3D33A
	for <qemu-devel@archiver.kernel.org>; Thu,  5 Mar 2026 17:34:08 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vyCZr-0007rg-LY; Thu, 05 Mar 2026 12:33:35 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vyCZo-0007qV-ML
 for qemu-devel@nongnu.org; Thu, 05 Mar 2026 12:33:33 -0500
Received: from mail-wr1-x42b.google.com ([2a00:1450:4864:20::42b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vyCZl-0000EH-GS
 for qemu-devel@nongnu.org; Thu, 05 Mar 2026 12:33:30 -0500
Received: by mail-wr1-x42b.google.com with SMTP id
 ffacd0b85a97d-439bcec8613so3339093f8f.3
 for <qemu-devel@nongnu.org>; Thu, 05 Mar 2026 09:33:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1772732007; x=1773336807; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=Ka2HIJsgQAKn0lxDxZQRE6w76KFNVq+d9QNbm4Kyz14=;
 b=RVxDJE170fYRaEM1S8BlAYgyOjBj261xdrvB5pCfvLISh5hWl+1ARjhJpX8/+RdmdW
 wv5dkZeuZgv4lDDykcCs/uFKlG5RbNnFjiAFahUK9KY4oRJ17XESDJQCbZSqxhnBhjEB
 iGTrZKcXOWtAozisWu8agXxZOgzFjxRV4MKEVKFV9MxWGbfBGaX8+b7Up6geLcsyWseA
 +ENPEyqFIBrLc4MN3M13JJCgSmZdSEO9EY5y1/SFOZ/ZXu1Qy5QWv7la26P6kXRW+9Qu
 ao3n45QbsUeQy/N56D0DEogqW0yUX3X5cPR/8kFbvFyUFg0tWwZR7hP6FvLHCKHWZdH/
 Ouig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1772732007; x=1773336807;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=Ka2HIJsgQAKn0lxDxZQRE6w76KFNVq+d9QNbm4Kyz14=;
 b=eRXMqmCJCDKI5+x75R1MzaSWJbPyTOk+6FEeBqfwDiIFRXH72BFMUTp372Ih9ls2hJ
 31wXjsyYsEMRfmzJniLXo8ltHjaPqzORI2Q/h5dJDjpySfqzpiPJ+Z+Xf6JbiLazgbEj
 hOZQnT2txFoxS5B4wzCb08LnLMpENvyhGYL3GONCc0p63dL3KrU3N5OLX16FmT1afI5a
 mWrz42O367sBK/m8wIRuNg+lRbPfeFz8anidsjLffjo8RjsufFO8nd0EXkAKNFgxbE1x
 Or0YFNnbSItUkMQ2QONx7NhbwiGpf4bE3UbxYCZnYJnN1S01fZEICccH9kO9MX7a3t0r
 v3uA==
X-Forwarded-Encrypted: i=1;
 AJvYcCX8jJwjQuFXiqQlS+Up+a/DbrJTiMD6dizDSnSU7p9WeSHUIntDwuvLYIlyU6RKxf3L/WeIz/ztkYzl@nongnu.org
X-Gm-Message-State: AOJu0YzpWfCxpChVOVelH03YI8zc958jfCiruioyqbJc3a6vkt/JqRar
 oeBys1VyEMXRLJaF03Zgag47L02NKOKe0eixzUBXPK8aKbYLH+Fix6MDm+tDIQNK0Bg=
X-Gm-Gg: ATEYQzxDVXNJxzYsearQVj54l2aBN5fHt6LdUFw1LAbXbppyJZ3XHbW7fygXJbWUKh4
 LQwWkZjogl2C9FMxBnZBkY4JAf4jmrGlIEo8fRf5z7i6Nh8OdqRb00YJTz/3ZBtgpPMzigN05gk
 zH7wB5/Z3ylqMEvYWMli2jkg7vkGHgvvXYhYwC5kFeiZnQsnmFEc2GYzV36ALY9TyNwnCw/9q48
 P3JlWi2pzsjxYC3AK9VHj4jCingyCeY1NdhKGiKLV3SPLWDsbKEr7O9CnZMMZfDxxm4U0qFLF+T
 gYlEmoL+pEK1hEgJ+IR9vGwWaX3LKQX140EJqIL6wJhQNULzP8Ll2oG27t5jj7fdTjcoL4ytP8i
 1pV6KjlECIZNiV7x8TQuLVA+V9rvGgXMTjM+FVtqNVYA05pYjEJKu0i320eHvHYFwzd09o5PI42
 Mw/0KhINbzkFOXVIv31V8EKymfMZ8MkIZcumJ2vcD1gTOfpjIKmm8X0V4CQRdjQkDHNg==
X-Received: by 2002:a05:6000:420f:b0:439:ad2d:99f7 with SMTP id
 ffacd0b85a97d-439c80005b8mr12153266f8f.28.1772732006782; 
 Thu, 05 Mar 2026 09:33:26 -0800 (PST)
Received: from [192.168.69.208] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-4399c75b272sm50061340f8f.24.2026.03.05.09.33.25
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 05 Mar 2026 09:33:25 -0800 (PST)
Message-ID: <81547e70-5b7b-41dd-89fc-732f4209ef61@linaro.org>
Date: Thu, 5 Mar 2026 18:33:25 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v7 1/8] plugins/core: clamp syscall arguments if target is
 32-bit
Content-Language: en-US
To: Florian Hofhammer <florian.hofhammer@epfl.ch>, qemu-devel@nongnu.org
Cc: Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 Laurent Vivier <laurent@vivier.eu>,
 Richard Henderson <richard.henderson@linaro.org>
References: <20260305-setpc-v5-v7-0-4c3adba52403@epfl.ch>
 <20260305-setpc-v5-v7-1-4c3adba52403@epfl.ch>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20260305-setpc-v5-v7-1-4c3adba52403@epfl.ch>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
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

+Laurent

On 5/3/26 11:05, Florian Hofhammer wrote:
> From: Pierrick Bouvier <pierrick.bouvier@linaro.org>
> 
> Syscall arguments are abi_long in user code, and plugin syscall
> interface works with uint64_t only.
> 
> According to C integer promotion rules, the value is sign extended
> before becoming unsigned, thus setting high bits when only 32-bit lower
> ones should have a significant value.
> 
> As a result, we need to clamp values we receive from user-code
> accordingly.
> 
> Signed-off-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
> ---
>   plugins/core.c | 21 +++++++++++++++++++++
>   1 file changed, 21 insertions(+)
> 
> diff --git a/plugins/core.c b/plugins/core.c
> index 42fd986593..d6173422e9 100644
> --- a/plugins/core.c
> +++ b/plugins/core.c
> @@ -513,6 +513,23 @@ void qemu_plugin_tb_trans_cb(CPUState *cpu, struct qemu_plugin_tb *tb)
>       }
>   }
>   
> +static void clamp_syscall_arguments(uint64_t *a1, uint64_t *a2, uint64_t *a3,
> +                                    uint64_t *a4, uint64_t *a5, uint64_t *a6,
> +                                    uint64_t *a7, uint64_t *a8)
> +{
> +    if (target_long_bits() == 32) {

IIUC this is related to the target ABI, so maybe we want to
unconditionally use:

    const uint64_t mask = MAKE_64BIT_MASK(0, TARGET_ABI_BITS);

Maybe guarded with #if TARGET_ABI_BITS < 64?

> +        const uint64_t mask = UINT32_MAX;
> +        *a1 &= mask;
> +        *a2 &= mask;
> +        *a3 &= mask;
> +        *a4 &= mask;
> +        *a5 &= mask;
> +        *a6 &= mask;
> +        *a7 &= mask;
> +        *a8 &= mask;
> +    }
> +}

