Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D7467C48BEB
	for <qemu-devel@archiver.kernel.org>; Wed, 21 Feb 2024 17:27:11 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rcqM0-0008C4-Kp; Wed, 21 Feb 2024 12:25:56 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dbarboza@ventanamicro.com>)
 id 1rcqLz-00089o-B8
 for qemu-devel@nongnu.org; Wed, 21 Feb 2024 12:25:55 -0500
Received: from mail-pl1-x631.google.com ([2607:f8b0:4864:20::631])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <dbarboza@ventanamicro.com>)
 id 1rcqLx-0001Bj-J5
 for qemu-devel@nongnu.org; Wed, 21 Feb 2024 12:25:55 -0500
Received: by mail-pl1-x631.google.com with SMTP id
 d9443c01a7336-1d93edfa76dso44385535ad.1
 for <qemu-devel@nongnu.org>; Wed, 21 Feb 2024 09:25:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=ventanamicro.com; s=google; t=1708536351; x=1709141151; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=/XwhC+KfPAJsGVSX29D1cLKRWy6NmiBSvHsmRxAD9qU=;
 b=AhtLQIA+GvxjdG/i365/VUHO1osrzNxkzIJoF1+B8/Hp2kzJA6bVTh+apu0NCO3VR1
 FtUUsZ7BcuEnH68Fd/YEzPvH9g7XNxSfWMGvV70GYE54H4OrEOWdlVxpW/9s8aSKG8EQ
 QufHr+hpCg3ZnFTLthIV3qKpfeMqdspW33kxSm1lky+Y9Ql5ZIl1onmPeChgrIy7+A/+
 WHyVGKQ9VoH2B5Erl+Or2MgOdJ5biIDnslBJjNSXTPMOPF73XUcOOIbUZoUVnp1azQiS
 pWzYgajo2jRAleL4/G+rD9ED08rKGInoTm1UDknuD1BF5KbqbHO/Om5re0yt1Y1OS1j6
 jfcQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1708536351; x=1709141151;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=/XwhC+KfPAJsGVSX29D1cLKRWy6NmiBSvHsmRxAD9qU=;
 b=oa8mUKVB7Kq4OzCxQFfMpSkx0eOZ6dF4Kd6zg62YLVNM/xwCdhlhh5zKkhBakkmuc/
 VSSAQnMR04MDj2xJlnv5TBKRliU9cGihz53EHUDqYctWqw7DDucHfXUsrs089tYLQmdM
 YTdKzo/WhEGfutjbWYzCvRcHxbJUtehcr/9lYLYF3fQLBGdnx10kPOPooshimANQFrUj
 dMoHuYrga/RcfZ6qrBdCvyPk88mlSAWWXwnnERP+GAv1ZznbXn5fV0x41XlW1v+wHx6X
 JeLWvLnnP+IFfPNc4o3BZE3b/apTDIklMnl1M1QgupPxpj2sflq04+sfSaVNOa1e8My0
 RykA==
X-Forwarded-Encrypted: i=1;
 AJvYcCUtzWPw3JvEuIA2T1EmuIsNjMXtB1ZcTsOzN55LHAuSmpELLdK0E3m+iZVo9Kml4cD31IjY5Pgid+/Aic2kGYml1lzXHFY=
X-Gm-Message-State: AOJu0Yw+CdzBiZ//M/12GgWRTgXwyCxXNgbkzp/zmNgRFW6VqjY3pqRF
 0xbfij2aY4H2frNzpd8kKZGjidp9DaMN6wIUZkVP4jwTYlqPYn2A4HplrGj/9yY=
X-Google-Smtp-Source: AGHT+IFpYltHIzGvdA943cqGDYZA9E7lmr9ynlKv3jtrv5tiFJLjupfiiIthKkdRAm7RvWCOvH3YWw==
X-Received: by 2002:a17:903:2cd:b0:1dc:3e49:6795 with SMTP id
 s13-20020a17090302cd00b001dc3e496795mr1309079plk.47.1708536351071; 
 Wed, 21 Feb 2024 09:25:51 -0800 (PST)
Received: from [192.168.68.110] ([177.94.15.159])
 by smtp.gmail.com with ESMTPSA id
 j6-20020a17090276c600b001db693d89fdsm8310055plt.179.2024.02.21.09.25.48
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 21 Feb 2024 09:25:50 -0800 (PST)
Message-ID: <801fb2e4-bb09-47e9-b7f6-899de574c4a3@ventanamicro.com>
Date: Wed, 21 Feb 2024 14:25:46 -0300
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/4] target/riscv: Apply modularized matching conditions
 for breakpoint
Content-Language: en-US
To: Alvin Chang <alvinga@andestech.com>, qemu-riscv@nongnu.org,
 qemu-devel@nongnu.org
Cc: alistair.francis@wdc.com, bin.meng@windriver.com, liwei1518@gmail.com,
 zhiwei_liu@linux.alibaba.com
References: <20240219032559.79665-1-alvinga@andestech.com>
 <20240219032559.79665-3-alvinga@andestech.com>
From: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
In-Reply-To: <20240219032559.79665-3-alvinga@andestech.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::631;
 envelope-from=dbarboza@ventanamicro.com; helo=mail-pl1-x631.google.com
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
> Remove the related code in riscv_cpu_debug_check_breakpoint() and invoke
> trigger_common_match() to check the privilege levels of the type 2 and
> type 6 triggers for the breakpoints.
> 
> Only the execution bit and the executed PC should be futher checked in

typo: further

> riscv_cpu_debug_check_breakpoint().
> 
> Signed-off-by: Alvin Chang <alvinga@andestech.com>
> ---
>   target/riscv/debug.c | 26 ++++++--------------------
>   1 file changed, 6 insertions(+), 20 deletions(-)
> 
> diff --git a/target/riscv/debug.c b/target/riscv/debug.c
> index 7932233073..b971ed5d7a 100644
> --- a/target/riscv/debug.c
> +++ b/target/riscv/debug.c
> @@ -855,21 +855,17 @@ bool riscv_cpu_debug_check_breakpoint(CPUState *cs)
>           for (i = 0; i < RV_MAX_TRIGGERS; i++) {
>               trigger_type = get_trigger_type(env, i);
>   
> +            if (!trigger_common_match(env, trigger_type, i)) {
> +                continue;
> +            }
> +

I believe this will change how the function behaves. Before this patch, we would
'return false' if we have a TRIGGER_TYPE_AD_MATCH and env->virt_enabled is true.

Now, for the same case, we'll keep looping until we found a match, or return 'false'
if we run out of triggers.

This seems ok to do, but we should state in the commit msg that we're intentionally
change how the function works. If that's not the idea and we want to preserve the existing
behavior, we would need to do:

>   
> +            if (!trigger_common_match(env, trigger_type, i)) {
> +                return false;
> +            }

Instead of just continue looping. Thanks,


Daniel

>               switch (trigger_type) {
>               case TRIGGER_TYPE_AD_MATCH:
> -                /* type 2 trigger cannot be fired in VU/VS mode */
> -                if (env->virt_enabled) {
> -                    return false;
> -                }
> -
>                   ctrl = env->tdata1[i];
>                   pc = env->tdata2[i];
>   
>                   if ((ctrl & TYPE2_EXEC) && (bp->pc == pc)) {
> -                    /* check U/S/M bit against current privilege level */
> -                    if ((ctrl >> 3) & BIT(env->priv)) {
> -                        return true;
> -                    }
> +                    return true;
>                   }
>                   break;
>               case TRIGGER_TYPE_AD_MATCH6:
> @@ -877,17 +873,7 @@ bool riscv_cpu_debug_check_breakpoint(CPUState *cs)
>                   pc = env->tdata2[i];
>   
>                   if ((ctrl & TYPE6_EXEC) && (bp->pc == pc)) {
> -                    if (env->virt_enabled) {
> -                        /* check VU/VS bit against current privilege level */
> -                        if ((ctrl >> 23) & BIT(env->priv)) {
> -                            return true;
> -                        }
> -                    } else {
> -                        /* check U/S/M bit against current privilege level */
> -                        if ((ctrl >> 3) & BIT(env->priv)) {
> -                            return true;
> -                        }
> -                    }
> +                    return true;
>                   }
>                   break;
>               default:

