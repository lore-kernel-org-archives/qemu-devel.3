Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B7841C5478A
	for <qemu-devel@archiver.kernel.org>; Wed, 21 Feb 2024 20:37:37 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rctKj-0000NK-St; Wed, 21 Feb 2024 15:36:49 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1rctKi-0000Ms-Sg
 for qemu-devel@nongnu.org; Wed, 21 Feb 2024 15:36:48 -0500
Received: from mail-pl1-x634.google.com ([2607:f8b0:4864:20::634])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1rctKa-0001ln-6j
 for qemu-devel@nongnu.org; Wed, 21 Feb 2024 15:36:48 -0500
Received: by mail-pl1-x634.google.com with SMTP id
 d9443c01a7336-1d7232dcb3eso43068625ad.2
 for <qemu-devel@nongnu.org>; Wed, 21 Feb 2024 12:36:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1708547798; x=1709152598; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=Mgolz4yoRUWALxvvOjEvE5Ml5l8Hp2k3h4ZtOzVkDCA=;
 b=Zq9HMz5vzZUrq5FN/2abI4X54KPDn/gvholknPPSOak7Az/Be8+8xKNniVzZ0BqOAh
 VIySaqiRXb6sjNTFHycPQaqiiuqm+E4sgEaFYySnezjnSXPVOg2Dpm0D4Q2+Jpz0qKPq
 wCYesiG19OFrZLep1ga5vUFfOQCM/4Xh74Jk2wcJ+ar3YnBoyV/FfNwcNYX4Ir+5GgDk
 wvb190hfTo/hiPv9em0vyikKHsVU4tGgDjurkIVUtHxim/n4CpyfRdav4IYsF8g5MaRy
 cndvGsTxuqg9UYn6vQmItBWEPR9w2Xai6EkYWk9oP9Oh0QyZ6jwSTBqi3FgLxAG75tVE
 QxVA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1708547798; x=1709152598;
 h=content-transfer-encoding:in-reply-to:from:references:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=Mgolz4yoRUWALxvvOjEvE5Ml5l8Hp2k3h4ZtOzVkDCA=;
 b=Y9QT0eljyqYNEJwIWXG7lcVWW46MG5GGAOuLXQ6J4yROQgTxeTXhkD8uMkmfxchAFb
 kUFnf9+p0wykWY+am91ZH5mnEjNFnq/GEX6OaSuziEPUl5oRSVTpDpCfJlHcwrKIjfkA
 zrHKEB9W3NbYTgQDlBWYJOeVnDPnb5y6jFMbFuJUtvJUl/ixUDUO9exAo4Qo/t3If53e
 MTjn4vR6N7jbgGgEFVpHTFB1Q0v3RdJsMVDw+4bh96Gbx1vvH0mdk4KeulRoCefGWN6N
 nxhFKbp7uiymOT3ppo4fQJexUL5s1uE+m8fq9NCob3GGhdd9uRlNzprRty2utpmQCVOX
 xk3Q==
X-Forwarded-Encrypted: i=1;
 AJvYcCWKTQRqWKitVGYlsidpxCLLO+btYUlxDr6mbGtaQ0y02YS7TLrKRoLYEDBQSNSYhZVjcyUsZWfR/APvHHY+2ZA8iZ18/Do=
X-Gm-Message-State: AOJu0YyMv6up79qxcrXvOHPOAECSawdVSnO2uWTgiNM4Y8sWGCyO5xax
 ZtGaeH4Bthb7X7bt+JNbwAmpZqfDA+JQSIJnPOMHE5WXPtwIiUmiItKFkECqIBQ=
X-Google-Smtp-Source: AGHT+IE1JktQK9cOyHS6Q5t69omayErvaPwM/HxNraB6NzpPwH2iV0C0PrQM5uRWP/Il84Ipi5vs7A==
X-Received: by 2002:a17:902:e84f:b0:1db:de79:8664 with SMTP id
 t15-20020a170902e84f00b001dbde798664mr11954747plg.60.1708547797983; 
 Wed, 21 Feb 2024 12:36:37 -0800 (PST)
Received: from [172.20.1.19] (173-197-098-125.biz.spectrum.com.
 [173.197.98.125]) by smtp.gmail.com with ESMTPSA id
 h18-20020a170902f2d200b001db579a146csm8524173plc.241.2024.02.21.12.36.35
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 21 Feb 2024 12:36:37 -0800 (PST)
Message-ID: <d2a70405-edd2-494b-bac2-14fd392bcc82@linaro.org>
Date: Wed, 21 Feb 2024 10:36:33 -1000
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH v2 10/22] target/arm: Handle PSTATE.ALLINT on taking
 an exception
Content-Language: en-US
To: Jinjie Ruan <ruanjinjie@huawei.com>, peter.maydell@linaro.org,
 eduardo@habkost.net, marcel.apfelbaum@gmail.com, philmd@linaro.org,
 wangyanan55@huawei.com, qemu-devel@nongnu.org, qemu-arm@nongnu.org
References: <20240221130823.677762-1-ruanjinjie@huawei.com>
 <20240221130823.677762-11-ruanjinjie@huawei.com>
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20240221130823.677762-11-ruanjinjie@huawei.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::634;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x634.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, T_SCC_BODY_TEXT_LINE=-0.01,
 T_SPF_TEMPERROR=0.01 autolearn=ham autolearn_force=no
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

On 2/21/24 03:08, Jinjie Ruan via wrote:
> Set or clear PSTATE.ALLINT on taking an exception to ELx according to the
> SCTLR_ELx.SPINTMASK bit.
> 
> Signed-off-by: Jinjie Ruan <ruanjinjie@huawei.com>
> ---
>   target/arm/helper.c | 9 +++++++++
>   1 file changed, 9 insertions(+)
> 
> diff --git a/target/arm/helper.c b/target/arm/helper.c
> index 62c8e5d611..952ea7c02a 100644
> --- a/target/arm/helper.c
> +++ b/target/arm/helper.c
> @@ -11540,6 +11540,15 @@ static void arm_cpu_do_interrupt_aarch64(CPUState *cs)
>           }
>       }
>   
> +    if (cpu_isar_feature(aa64_nmi, cpu) &&
> +        (env->cp15.sctlr_el[new_el] & SCTLR_NMI)) {
> +        if (!(env->cp15.sctlr_el[new_el] & SCTLR_SPINTMASK)) {
> +            new_mode |= PSTATE_ALLINT;
> +        } else {
> +            new_mode &= ~PSTATE_ALLINT;
> +        }
> +    }

new_mode starts at zero and adds state as required -- there is no need to clear allint 
here... though I see that we do the same for SSBS.

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>


r~


