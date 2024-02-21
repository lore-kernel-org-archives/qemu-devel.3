Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4EA2BC48BEB
	for <qemu-devel@archiver.kernel.org>; Wed, 21 Feb 2024 17:31:45 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rcqRP-0004Lw-Ht; Wed, 21 Feb 2024 12:31:31 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dbarboza@ventanamicro.com>)
 id 1rcqRL-0004HR-O7
 for qemu-devel@nongnu.org; Wed, 21 Feb 2024 12:31:30 -0500
Received: from mail-pl1-x62f.google.com ([2607:f8b0:4864:20::62f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <dbarboza@ventanamicro.com>)
 id 1rcqRI-00025t-MH
 for qemu-devel@nongnu.org; Wed, 21 Feb 2024 12:31:27 -0500
Received: by mail-pl1-x62f.google.com with SMTP id
 d9443c01a7336-1dc29f1956cso6582965ad.0
 for <qemu-devel@nongnu.org>; Wed, 21 Feb 2024 09:31:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=ventanamicro.com; s=google; t=1708536682; x=1709141482; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=+V3z5cUg6GqXrunSorOWYDeSme866E99CGieQ/1mVy4=;
 b=dbOoW06AKy6JCfSJumAzqkiKMbxG0Zd7GHiT457Z+2nnKvQfIbEzqKxtWSHlEehmT3
 3t19MXuhz6PJgYAyeIgCEajxCRLVjhDbnh9UKS2xKklfOiBGhVDyeAb9BM0YF8XvzV6e
 LKTq0A9KzYEUfy/bBXS8Azy+s8nVn55aTVpxU4vVx+crmS/dRzWvzHwP4gXR1ctTV7jY
 mdPKaKe0RNo7zFOqz5u3Tu+riAeD6WZy0Tg+mTnCj0NxCg2RSVW6UOyqiu/BR56iQQvO
 RRxwSTxtvjyCFpYz2NCZq2hypyPsKIB1EkIpMKRUIkucrliA0t6fwGRk66TrB95oc4Fi
 TLxA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1708536682; x=1709141482;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=+V3z5cUg6GqXrunSorOWYDeSme866E99CGieQ/1mVy4=;
 b=wI8jZKA02+zIHtJ1DDQY0u0ygPyClxHy3smgy0FyS+DUKb1TFuimg1AnaOcDTiBkJy
 PhXP9TuoYbX68b7xWXk42qp/jw+a155+b/7Hnc+x0YDqhl6XHEGtRtuRgdaQBv6Afxee
 5mpM8cZJ0xBAO6uf4MTQE+0mZSNroIij8/72vGSDtibBSwCUadcZgXU+UVUBCxIXGEnI
 E+EkLuGavXj6gGEEfkrGg67xGqrgz/tmaC8hS4nREVoX+GnWT/sCSEJbH0pZ8nb6PVEg
 5b5OwrA3nwWv/WJ9wDyUxZeGkvUHRBVx08JTdksfvjj8zMFqX6FiFZafjE8V8HAjHkGN
 s0/g==
X-Forwarded-Encrypted: i=1;
 AJvYcCUtGg6zcKJO3fAII5The89fW6lfPen1RdXz0+5dH2xNxN60xBlXqyJql+XVKMJNuXxXbQYP1x6gDHPKrrNqqB9l87zXLqk=
X-Gm-Message-State: AOJu0YxH2NfrWTzlsIWoq673SL4p4QXBW7H9lqPpEPF1yCczwUQEfxqo
 S6T/8V0OkXi8yEHA8Jd1qPxWvFaf4hicJHZgtmc0X88XH6B/DvE0NQv8gmDl2EM=
X-Google-Smtp-Source: AGHT+IG3a7YYfeYH5E/Ok+hMAVkPc5mYlmwHWfAmoDTPlaqe66HZZ65Y5K/9hZl4/jLOuqnaSV7LDg==
X-Received: by 2002:a17:903:11c8:b0:1d9:a91b:778 with SMTP id
 q8-20020a17090311c800b001d9a91b0778mr21077356plh.30.1708536682070; 
 Wed, 21 Feb 2024 09:31:22 -0800 (PST)
Received: from [192.168.68.110] ([177.94.15.159])
 by smtp.gmail.com with ESMTPSA id
 q18-20020a170902c9d200b001db90df1283sm8318708pld.4.2024.02.21.09.31.19
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 21 Feb 2024 09:31:21 -0800 (PST)
Message-ID: <ec025245-ed62-4c8b-8110-0eb996280bde@ventanamicro.com>
Date: Wed, 21 Feb 2024 14:31:18 -0300
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 3/4] target/riscv: Apply modularized matching conditions
 for watchpoint
Content-Language: en-US
To: Alvin Chang <alvinga@andestech.com>, qemu-riscv@nongnu.org,
 qemu-devel@nongnu.org
Cc: alistair.francis@wdc.com, bin.meng@windriver.com, liwei1518@gmail.com,
 zhiwei_liu@linux.alibaba.com
References: <20240219032559.79665-1-alvinga@andestech.com>
 <20240219032559.79665-4-alvinga@andestech.com>
From: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
In-Reply-To: <20240219032559.79665-4-alvinga@andestech.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62f;
 envelope-from=dbarboza@ventanamicro.com; helo=mail-pl1-x62f.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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



On 2/19/24 00:25, Alvin Chang wrote:
> We have implemented trigger_common_match(), which checks if the enabled
> privilege levels of the trigger match CPU's current privilege level.
> Remove the related code in riscv_cpu_debug_check_watchpoint() and invoke
> trigger_common_match() to check the privilege levels of the type 2 and
> type 6 triggers for the watchpoints.
> 
> Only load/store bits and loaded/stored address should be further checked
> in riscv_cpu_debug_check_watchpoint().
> 
> Signed-off-by: Alvin Chang <alvinga@andestech.com>
> ---
>   target/riscv/debug.c | 26 ++++++--------------------
>   1 file changed, 6 insertions(+), 20 deletions(-)
> 
> diff --git a/target/riscv/debug.c b/target/riscv/debug.c
> index b971ed5d7a..67ba19c966 100644
> --- a/target/riscv/debug.c
> +++ b/target/riscv/debug.c
> @@ -899,13 +899,12 @@ bool riscv_cpu_debug_check_watchpoint(CPUState *cs, CPUWatchpoint *wp)
>       for (i = 0; i < RV_MAX_TRIGGERS; i++) {
>           trigger_type = get_trigger_type(env, i);
>   
> +        if (!trigger_common_match(env, trigger_type, i)) {
> +            continue;
> +        }
> +

The same comments I made in patch 2 also applies here. It's ok to change
how the function behaves as long as we're doing it on purpose and explaining
why in the commit message. Otherwise this if (!trigger_common_match()"
conditional should "return false" instead of keep looping to maintain
the existing behavior.

Thanks,

Daniel

>           switch (trigger_type) {
>           case TRIGGER_TYPE_AD_MATCH:
> -            /* type 2 trigger cannot be fired in VU/VS mode */
> -            if (env->virt_enabled) {
> -                return false;
> -            }
> -
>               ctrl = env->tdata1[i];
>               addr = env->tdata2[i];
>               flags = 0;
> @@ -918,10 +917,7 @@ bool riscv_cpu_debug_check_watchpoint(CPUState *cs, CPUWatchpoint *wp)
>               }
>   
>               if ((wp->flags & flags) && (wp->vaddr == addr)) {
> -                /* check U/S/M bit against current privilege level */
> -                if ((ctrl >> 3) & BIT(env->priv)) {
> -                    return true;
> -                }
> +                return true;
>               }
>               break;
>           case TRIGGER_TYPE_AD_MATCH6:
> @@ -937,17 +933,7 @@ bool riscv_cpu_debug_check_watchpoint(CPUState *cs, CPUWatchpoint *wp)
>               }
>   
>               if ((wp->flags & flags) && (wp->vaddr == addr)) {
> -                if (env->virt_enabled) {
> -                    /* check VU/VS bit against current privilege level */
> -                    if ((ctrl >> 23) & BIT(env->priv)) {
> -                        return true;
> -                    }
> -                } else {
> -                    /* check U/S/M bit against current privilege level */
> -                    if ((ctrl >> 3) & BIT(env->priv)) {
> -                        return true;
> -                    }
> -                }
> +                return true;
>               }
>               break;
>           default:

