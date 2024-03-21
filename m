Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 145D8C54E68
	for <qemu-devel@archiver.kernel.org>; Thu, 21 Mar 2024 08:19:15 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rnDct-00015d-SK; Thu, 21 Mar 2024 04:18:16 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1rnDcq-00015B-E0
 for qemu-devel@nongnu.org; Thu, 21 Mar 2024 04:18:13 -0400
Received: from mail-pl1-x62c.google.com ([2607:f8b0:4864:20::62c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1rnDco-0005TO-TR
 for qemu-devel@nongnu.org; Thu, 21 Mar 2024 04:18:12 -0400
Received: by mail-pl1-x62c.google.com with SMTP id
 d9443c01a7336-1dee5daa236so5039005ad.0
 for <qemu-devel@nongnu.org>; Thu, 21 Mar 2024 01:18:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1711009089; x=1711613889; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=e22/WRojH77uUxTiZE4vkI+RCNjduJDHrgnxZNbBYNc=;
 b=y9aWNFnTvb4HzL8O6OBwgvkMRH9HVdfv+01YlMCapSQIMCLbW2dzxPviqvFqXWUD6O
 2NQftS1PzYi5nK3mCGAOjxwK1HdgAekTjzk59G4FDk3z75yrJHZ7bRJRFrhOl1JYluxR
 e5XRZBAPf4maxjUmWzRF6nu6265OWqNDed5i/z9xPuxbJ0VUG9U6G6ZSA2hxMQeR7DMN
 1sESwPHvanDJD/IERsrdi1KUL0BDb6WFEK+oKGOXMAIp2z379EeECPWbVH68GWuvhyXn
 IWu8DH5H4SoLywd+Xl5wEiyx1HZzZ4F97LnK23plkf9yPVB3CAunPzy4FPEvWtnA66jP
 II9g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1711009089; x=1711613889;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=e22/WRojH77uUxTiZE4vkI+RCNjduJDHrgnxZNbBYNc=;
 b=j5aTuSn8ty/gWDMfYzebfqlJBN13pDInfROJsd1OgrNPi6HdYo0PtsKovIYs26B95j
 bTcwmls4SDkB0KJGQM8jZ0dGTfNlqbcYR7dTMJLOWSnpaoM2S1YZzoNryqAKsWIkOV16
 fLrUVZydiCx14rKz49VvPvW90kx7LVud7gDxoAeGu+/Lss51qg/TUEpHfOdKwUO78uVE
 SbY5bqwYRZ6b4yY7d/DmMuOLnpA11RaD4hUwJugevOsXbwBfA2o3kVd2iOyegGqunOpH
 yR9hxzZaz1BTB+lF4COr0YFJLJ4dVzh1Gu3JrK1fKvzq3JnBVHgAe1WSPhPnlUO75SZ2
 yKhA==
X-Forwarded-Encrypted: i=1;
 AJvYcCUuLCyvDUDlkTGXRufyW1JxUzAUPqMREuhoNHUDMNLZH4oBBa/jbVkRR9qPclAXpKZBBnR1ujMwn/vkvNUGnBVDUdKJB/0=
X-Gm-Message-State: AOJu0YxSsLyMcwAl7WFXhWC+lhG2BnFvDa0IGcugY92Cn3U08ag8i4gc
 Y2XKucTGUlNMGFBM1rga+bMU13AiqjZcZh04Kjdva+ME0BdIaCA066REJqeg7xY=
X-Google-Smtp-Source: AGHT+IEimOKmM7E/hMZ9MZbbV0m1VeEXhAWuMq/QJy5uw0FOS0aZUC9Urq8nyy3k1uHENqmYEDwAeA==
X-Received: by 2002:a17:902:b08f:b0:1e0:27e5:449c with SMTP id
 p15-20020a170902b08f00b001e027e5449cmr3994558plr.67.1711009089170; 
 Thu, 21 Mar 2024 01:18:09 -0700 (PDT)
Received: from [172.20.1.19] (173-197-098-125.biz.spectrum.com.
 [173.197.98.125]) by smtp.gmail.com with ESMTPSA id
 b7-20020a170902650700b001e0648dfd68sm2258032plk.296.2024.03.21.01.18.07
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 21 Mar 2024 01:18:08 -0700 (PDT)
Message-ID: <ed5675bc-f82b-4d4e-95e4-1a3045dd1870@linaro.org>
Date: Wed, 20 Mar 2024 22:18:04 -1000
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] target/riscv: Fix the element agnostic function problem
To: Huang Tao <eric.huang@linux.alibaba.com>, qemu-devel@nongnu.org
Cc: qemu-riscv@nongnu.org, zhiwei_liu@linux.alibaba.com,
 dbarboza@ventanamicro.com, liwei1518@gmail.com, bin.meng@windriver.com,
 alistair.francis@wdc.com, palmer@dabbelt.com
References: <20240321035816.99983-1-eric.huang@linux.alibaba.com>
Content-Language: en-US
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20240321035816.99983-1-eric.huang@linux.alibaba.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62c;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x62c.google.com
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

On 3/20/24 17:58, Huang Tao wrote:
> In RVV and vcrypto instructions, the masked and tail elements are set to 1s
> using vext_set_elems_1s function if the vma/vta bit is set. It is the element
> agnostic policy.
> 
> However, this function can't deal the big endian situation. This patch fixes
> the problem by adding handling of such case.
> 
> Signed-off-by: Huang Tao <eric.huang@linux.alibaba.com>
> Suggested-by: Richard Henderson <richard.henderson@linaro.org>
> ---
> Changes in v2:
> - Keep the api of vext_set_elems_1s
> - Reduce the number of patches.
> ---
>   target/riscv/vector_internals.c | 22 ++++++++++++++++++++++
>   1 file changed, 22 insertions(+)
> 
> diff --git a/target/riscv/vector_internals.c b/target/riscv/vector_internals.c
> index 12f5964fbb..3e45b9b4a7 100644
> --- a/target/riscv/vector_internals.c
> +++ b/target/riscv/vector_internals.c
> @@ -30,6 +30,28 @@ void vext_set_elems_1s(void *base, uint32_t is_agnostic, uint32_t cnt,
>       if (tot - cnt == 0) {
>           return ;
>       }
> +
> +#if HOST_BIG_ENDIAN
> +    /*
> +     * Deal the situation when the elements are insdie
> +     * only one uint64 block including setting the
> +     * masked-off element.
> +     */
> +    if ((tot - 1) ^ cnt < 8) {
> +        memset(base + H1(tot - 1), -1, tot - cnt);
> +        return;
> +    }

(1) tot will always be a multiple of 8, afaik, so there's no need for this first block.
(2) Using if not #if means that the code is always compile-tested, even if it is eliminated.


r~

