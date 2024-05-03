Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id ECBD8C4345F
	for <qemu-devel@archiver.kernel.org>; Fri,  3 May 2024 14:58:37 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s2uMk-0005FO-MN; Fri, 03 May 2024 10:58:26 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1s2uMh-00058g-8S
 for qemu-devel@nongnu.org; Fri, 03 May 2024 10:58:25 -0400
Received: from mail-ej1-x62e.google.com ([2a00:1450:4864:20::62e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1s2uMb-0003sL-5A
 for qemu-devel@nongnu.org; Fri, 03 May 2024 10:58:19 -0400
Received: by mail-ej1-x62e.google.com with SMTP id
 a640c23a62f3a-a58772187d8so1290397966b.3
 for <qemu-devel@nongnu.org>; Fri, 03 May 2024 07:58:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1714748294; x=1715353094; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=HHFBgWtcBeYxK+i5BuVSxC9MHuW8xFh3C8v3HLX40ZQ=;
 b=coxeZlVvG6t3lFvxXXkV8MV3gyn0y8E7s/rbwAR2t+cHgptnpMtgAibxJgok1MHudU
 98owfERMJePxXODnC+eDJ/dtxBJWFeAVDUGs24KNyV0pRwfor8nMwWERWuxtJktgxPtn
 v1ex3aAWMsRzOj43qTiJ0X9U3/H7jNDv6S0LDbt0W4uZxJqrHwO8yEDbiLU+VEbrFj5g
 aU7LqypviW1IqIiNt1ZBGhqGXJISY/y5+3jxF5OznBSG6is6waG9yQx8DQlq9P7ok/xY
 UR8/qHVOw6Gv0on3zC2/a3uNLiRcUSbxM+T/M+P4XiSYZRc4RzLejb30MHCc/Ror6Juq
 Ug6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1714748294; x=1715353094;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=HHFBgWtcBeYxK+i5BuVSxC9MHuW8xFh3C8v3HLX40ZQ=;
 b=qMMFo7aAED7fNzBuRtsflHX/UQnjK+XXBWaUELAqPHLqLfoxJk62k2eKaudQTw5Aqu
 O6I0+XPU2WUIG8ksewLnPioPR/qLXiwMj5kF4labouBgkvcfp0BBKSb/S0mIAE/30B+i
 AHXPmhjvvrXJx1u90RZAo2er22qtFgYrGI6OAemBeMraI0zhjWnUZeMQT4bJ5UZbyPhD
 5MCIqEvBiP5aRUU3aLeL5Vw9GLw/nDBMIjHki/MdW3cZrvtJQjy7kDWOqxleTmlewPcH
 WePpiDiQKw2XxP/rQKN3TUBslyhrRjKNMUq6eru9DY4ccnNTPPklbA0vLA8TcSLjD1wO
 06xw==
X-Forwarded-Encrypted: i=1;
 AJvYcCXpHo2XLaJ85D24W6ujWw7NwZNX/FUNQRdGDC2+GJYJS2BjPsvoOlbQjKU+0ycAROGHKH5dNxKJyACl7Dwb3LS55EkpR1k=
X-Gm-Message-State: AOJu0Yy/qbirpOW1E8oKO9ghAJUULLc+KrsnmbzRSoI5G7MyjKMhE8VL
 f6L7FmJtDme92MxkbRPOvS6U/BIXuIp6oLucB4gNtBc7ACFzbsXU85n3Zja3qpY=
X-Google-Smtp-Source: AGHT+IH6039xxoCpm/B9EXU1Y8Gnfml+9EyQeP56YyfHI4Ndr5cwbE/vaJ9DDo3ox4zr0VfelFEcTg==
X-Received: by 2002:a17:906:816:b0:a55:5ff4:ff4f with SMTP id
 e22-20020a170906081600b00a555ff4ff4fmr2557709ejd.71.1714748293949; 
 Fri, 03 May 2024 07:58:13 -0700 (PDT)
Received: from [192.168.69.100] ([176.176.179.187])
 by smtp.gmail.com with ESMTPSA id
 q6-20020a1709060e4600b00a5875dd74c2sm1790061eji.131.2024.05.03.07.58.12
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 03 May 2024 07:58:13 -0700 (PDT)
Message-ID: <4906224c-b37e-4480-adc7-362ad2023b36@linaro.org>
Date: Fri, 3 May 2024 16:58:12 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] target/arm: Restrict translation disabled alignment check
 to VMSA
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
Cc: =?UTF-8?Q?Cl=C3=A9ment_Chigot?= <chigot@adacore.com>,
 qemu-stable@nongnu.org
References: <20240424170908.759043-1-richard.henderson@linaro.org>
 <20240424170908.759043-2-richard.henderson@linaro.org>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20240424170908.759043-2-richard.henderson@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::62e;
 envelope-from=philmd@linaro.org; helo=mail-ej1-x62e.google.com
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

On 24/4/24 19:09, Richard Henderson wrote:
> For cpus using PMSA, when the MPU is disabled, the default memory
> type is Normal, Non-cachable.
> 
> Fixes: 59754f85ed3 ("target/arm: Do memory type alignment check when translation disabled")
> Reported-by: Clément Chigot <chigot@adacore.com>
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
> 
> Since v9 will likely be tagged tomorrow without this fixed,
> Cc: qemu-stable@nongnu.org
> 
> ---
>   target/arm/tcg/hflags.c | 12 ++++++++++--
>   1 file changed, 10 insertions(+), 2 deletions(-)
> 
> diff --git a/target/arm/tcg/hflags.c b/target/arm/tcg/hflags.c
> index 5da1b0fc1d..66de30b828 100644
> --- a/target/arm/tcg/hflags.c
> +++ b/target/arm/tcg/hflags.c
> @@ -38,8 +38,16 @@ static bool aprofile_require_alignment(CPUARMState *env, int el, uint64_t sctlr)
>       }
>   
>       /*
> -     * If translation is disabled, then the default memory type is
> -     * Device(-nGnRnE) instead of Normal, which requires that alignment
> +     * With PMSA, when the MPU is disabled, all memory types in the
> +     * default map is Normal.
> +     */
> +    if (arm_feature(env, ARM_FEATURE_PMSA)) {
> +        return false;
> +    }
> +
> +    /*
> +     * With VMSA, if translation is disabled, then the default memory type
> +     * is Device(-nGnRnE) instead of Normal, which requires that alignment
>        * be enforced.  Since this affects all ram, it is most efficient
>        * to handle this during translation.
>        */

This one is in target-arm.next:
https://lore.kernel.org/qemu-devel/CAFEAcA98UrBLsAXKzLSkUnC2G_RZd56veqUkSGSttoADfkEKGA@mail.gmail.com/

