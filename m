Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4BAC8CD8CB2
	for <qemu-devel@archiver.kernel.org>; Tue,  9 Jun 2026 17:46:50 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wX0X9-0002pQ-2q; Tue, 09 Jun 2026 13:46:39 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1wX0X4-0002js-05
 for qemu-devel@nongnu.org; Tue, 09 Jun 2026 13:46:34 -0400
Received: from mail-pl1-x62b.google.com ([2607:f8b0:4864:20::62b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1wX0X2-0005Hm-D9
 for qemu-devel@nongnu.org; Tue, 09 Jun 2026 13:46:33 -0400
Received: by mail-pl1-x62b.google.com with SMTP id
 d9443c01a7336-2bf2247e38eso61028055ad.3
 for <qemu-devel@nongnu.org>; Tue, 09 Jun 2026 10:46:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1781027190; x=1781631990; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:to:subject:user-agent:mime-version:date:message-id:from
 :to:cc:subject:date:message-id:reply-to;
 bh=mdvuifZjD5g92rJd40J7wg7++LQzVDIh8pWHV4sj+CY=;
 b=T4uYiR9qwsnvqwJbsfwkDg48DnOPegfSzkLCqxLIDwJOGU6IEIGwH33ZRirXJI7/Vk
 5zQZfkw9RKWkXzKNvTjD9/Bs/2AWUDu2FVSqrKOaCY9TG0c+pCfMBAjqhaeMVC9XA5cw
 XgFviyrkLsOlMQ53jHxKTLU11uekkeO+X9SDF6KpVS+OT3BJ9RMBOXuspNt3HIvhvXpB
 lJO81NNGwMI+6Zkrq4yoE7yuaZwFrpZTnqEqyqHZlj315/p1Q4crbFnAZOueJGbZaXpD
 KoDbh4zNxYv2Br395RjxqSNvJmByCUKO+EkSDWnXbirvoRC4xaAGSfinWCBliP/R4Cay
 rjKA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1781027190; x=1781631990;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:to:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=mdvuifZjD5g92rJd40J7wg7++LQzVDIh8pWHV4sj+CY=;
 b=ddVDJuoiyi+tzv8Sgr/EHAmoKIQGLtvHEogXS5wGXukth/kDTe+EIxhirOH/9pHF54
 gME54Z/50p6j7IROPXsk0t5KiA/XWK7ZHLq4tlHQmTjOkvE/SDC3soh9SkGkDJbcwYQD
 +oHNTMz3zs22K0X/2wFlhfP9l19RB/A1GzE4OZ9VuVeVJG4cxrb8NsWQuyTffQ76wkD6
 r855vPpoxW8XbqzqxoRlLaN1r3UrlVmSGNHOql/thMX0M+ALuG62jN6qhnP7f8X58wWw
 80j/SXgbIOKuoZHnZMM7xwxzui04KcSIjL2ILFR0ldUOSfoCTsgcMmzIubfepchm3kW/
 1e4Q==
X-Gm-Message-State: AOJu0Yytn5cJcOZrKTM87Kmue9OsqODCqK1M+/NthZTuHl4op0uMkxEQ
 gCFmvjnD1RBaKbAvizna2Y1hHZuRFioBPfgZD0wEiG/aIZIxTIm9rXT/ezT0tYglDKNbvkYE9o1
 CXAibKgw=
X-Gm-Gg: Acq92OGASLOkX9oJJLV6PQYcBRwgrRkWS2So2wP2aXdHqGns9JAzqqFhOJhtzwAY/gV
 GoWYalPkrXRuyk507QQMpW5b1x1RxaWTBUE9fTxWZFfK49PTHkjJ1v01lePGbbNpKcy3lGakARC
 FXzHNWHJMC58tr7BTzSxCaz4jrFnlxvavm0YwB/hkPNoe2UJDVxP57Q6TNVnoVYlF+auLUMeOb7
 d/VX+OvZ4SrP9umYrTr9v5gFWEx2C9usJgnj62cgqvT8Nn3dqvAzq8mJow5jIA42zGBFjSn2cfW
 FkIVSUnvxmC3C0S52y7QrzioSbcPl5OhVKCC7DBTKVI0QJ0UPFyvu+56d2Dz+/Mj8YHNWB54yws
 vEy9NP+yo6/k4dHB4oA6eDJwvFl9/r1UNZPnCKLPW55CJYOzrMoPCsVOIp+OyLr49kHkt7Ozdov
 f5TZ3UJe1H0SbgQNZLHFeViWLq9RT2qXefR0yN0A5KaxHh0LQ=
X-Received: by 2002:a17:902:fc46:b0:2bf:2188:a90f with SMTP id
 d9443c01a7336-2c1e85c5ae8mr237611575ad.32.1781027189545; 
 Tue, 09 Jun 2026 10:46:29 -0700 (PDT)
Received: from [192.168.0.4] ([71.212.142.33])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2c16649fcdfsm286857135ad.78.2026.06.09.10.46.28
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 09 Jun 2026 10:46:28 -0700 (PDT)
Message-ID: <7914fe09-fdb4-4f5b-a283-aa364d0c4525@linaro.org>
Date: Tue, 9 Jun 2026 10:46:27 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 3/5] target/arm: trigger timer recalc on SCR:ECVEN change
To: qemu-devel@nongnu.org
References: <20260609140008.3206970-1-alex.bennee@linaro.org>
 <20260609140008.3206970-4-alex.bennee@linaro.org>
From: Richard Henderson <richard.henderson@linaro.org>
Content-Language: en-US
In-Reply-To: <20260609140008.3206970-4-alex.bennee@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62b;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x62b.google.com
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

On 6/9/26 07:00, Alex Bennée wrote:
> Toggling the ECVEN state affects the offset calculated in
> gt_phys_raw_cnt_offset so we should trigger a re-calculation on its
> change.
> 
> Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
> ---
>   target/arm/helper.c | 9 +++++++++
>   1 file changed, 9 insertions(+)
> 
> diff --git a/target/arm/helper.c b/target/arm/helper.c
> index 5c640853060..22f5117ee54 100644
> --- a/target/arm/helper.c
> +++ b/target/arm/helper.c
> @@ -37,6 +37,9 @@
>   #include "qemu/plugin.h"
>   
>   static void switch_mode(CPUARMState *env, int mode);
> +#ifndef CONFIG_USER_ONLY
> +static void gt_recalc_timer(ARMCPU *cpu, int timeridx);
> +#endif
>   
>   int compare_u64(const void *a, const void *b)
>   {
> @@ -821,6 +824,12 @@ static void scr_write(CPUARMState *env, const ARMCPRegInfo *ri, uint64_t value)
>       changed = env->cp15.scr_el3 ^ value;
>       env->cp15.scr_el3 = value;
>   
> +#ifndef CONFIG_USER_ONLY
> +    if (changed & SCR_ECVEN) {
> +        gt_recalc_timer(cpu, GTIMER_PHYS);
> +    }
> +#endif
> +
>       /*
>        * If SCR_EL3.{NS,NSE} changes, i.e. change of security state,
>        * we must invalidate all TLBs below EL3.

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

As an aside, gt_phys_raw_cnt_offset is missing a check on EL3 existing, before the check 
for ECVEn set.


r~

