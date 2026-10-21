Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4D802606A31A
	for <qemu-devel@archiver.kernel.org>; Wed, 21 Oct 2026 14:46:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256 header.s=google header.b=ItDmMiKX
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xJXZt-0003sh-Bi; Wed, 21 Oct 2026 10:46:23 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1xJXZJ-0003pm-TC
 for qemu-devel@nongnu.org; Wed, 21 Oct 2026 10:45:31 -0400
Received: from mail-wm1-x32f.google.com ([2a00:1450:4864:20::32f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1xJXZD-0004Cm-6r
 for qemu-devel@nongnu.org; Wed, 21 Oct 2026 10:45:26 -0400
Received: by mail-wm1-x32f.google.com with SMTP id
 5b1f17b1804b1-4a16af2a232so5034615e9.1
 for <qemu-devel@nongnu.org>; Wed, 21 Oct 2026 07:45:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1792593919; x=1793198719; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=6LXEZsP6fpcvqIzrCehw/JWiQYJLGoIPx9ke6QAhCyk=;
 b=ItDmMiKXRIgvFqmCsuBa+DC2DGJXr2m2GMe2X+Mn8bCVIrGdA8LdrUoCOWPJqlrvAM
 Y7xKdu8Q2mJYN7y4j9JbzQBmRd2IPn36kahdVW9YSIpSMlSFmZsaNxQLMaMBjYD8UucK
 ot6QTUoNxXl0v5dERrPb1WuJp1DL0ux8qFv0236JFVATKGWQOrIZmNKk2bCafv5BnGDq
 Rg4/DuXXWI1QC5MtZzJB1OEND1h/I33MhnGbOHKnfokrNRDv3yY4hYnOyKXRebfFNtrL
 9EMhqRLv6xk+9HBhQ6gk8JelWVIQCK9yhOM9ApeoTGt00eplm67NsbQEikgbqxaRNlig
 kAsg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792593919; x=1793198719;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:to:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=6LXEZsP6fpcvqIzrCehw/JWiQYJLGoIPx9ke6QAhCyk=;
 b=ah6AfJm5Ce4mVFh3GcBINrjQakH5ZOYg0F0K/gr7cvfhtmo7ksWrJfdXsv2y54CJbZ
 RpbC53V8nSuklWwKyHPvNKi3XFzNdbzJqUl/AzT4VpB84rEzxICE9acIeiAeoPDi12Ki
 Yn4AGYsn8dOFGjMpgSe/2tTWLshCzeRhrTopK2C3EZaiunx1ulIL6rnyFv+mWt75ycUT
 fWsN2MDx3d8OKL15aDmbRKjVARJQw0YpuvtD6BtF++7xU3SKeEGzyklRb05M85zaXOMA
 Q3crIUdhkJaE4A1TX7Q4xpnZD+AbX3o45zQXUf18NZqTNh2ufMzjt4uREdbypAmL+fP4
 Yubw==
X-Forwarded-Encrypted: i=1;
 AKwUvBw03diYClhNtchWQAM6zkusqflxffAC86pNzpgcdC/dZP/aLAZsu0LguBo6HmYge3KoEmUZsUvplLJw@nongnu.org
X-Gm-Message-State: AFq9FYJX9iuqF+hUNAD4TefA9Q6nnv7Kk1LLlRMroUqcSRQkwqEodNz9
 uLpQY095pcQOWzVyqpOZI8NpBaDX9aGzxhsD3m52KyPFGZDLw74tHRc52IlizR+E1FkaErWRVpl
 FdZLvdRg=
X-Gm-Gg: AYBFou2rrPfkEH6vNFcXf7FbYQbL29jPHT+rTly2fyIREQygv0OnPzeqlVatBRXPNiR
 7ySs2hmIS5kkHMU4V/7AN5UfZdl100gs7vlUngUzETgPaAPv2+mOxsO+3rfyjwS8a8Ueviyy+gP
 xnl4YBDLBF+fcVVKxe1h0FiW1MdAlwwKN2ZoBw4trHtJHDhVx8OX7S6UD4Ugw0uU8Y3gZFZRXtp
 uE+cxEp6Lkeg97lavrgehfuvUA7as3Iv3Owrto3Wwlj0ElJhmalNMDSfM0P80LtnzsqSe6S8kET
 u17o32Omgcxs20B4op9LyDVfvuD36NDehyI3Ge++TaadMvHLk4gKaJ/NEkesdEiuc11+5NFc8HL
 0vnQFZGUsH2JKmTNMVQPe2n4Tnl0n75io+f2HxBRfJiVzsROc3gQkHVwqU5I/mjERsKiT43dNVF
 0TYHuao/ElJwVgrvXG/J73nGO6/yYLbyK/hs8BWWS9ujrwZEFLQ6n+FTj5F+eW9MkrvWEDRIzci
 KW+r+TEMwLuHJDkAScawIyZZz+wipiQNgwbcGLSrstW9DNHF6OnD2ahLNZoY5LU3EolS6L3o2gM
 1Yx4p3mv/G82JscfVHIxMl6okfI=
X-Received: by 2002:a05:600c:4689:b0:4a1:d73d:4137 with SMTP id
 5b1f17b1804b1-4a1fdd4da2emr47671335e9.28.1792593919479; 
 Wed, 21 Oct 2026 07:45:19 -0700 (PDT)
Received: from [192.168.2.121] (pd95f64ec.dip0.t-ipconnect.de.
 [217.95.100.236]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4a20230ca3esm21626945e9.15.2026.10.21.07.45.18
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 21 Oct 2026 07:45:19 -0700 (PDT)
Message-ID: <aa95e88d-10f1-4882-a705-b75bbfd9ae8a@linaro.org>
Date: Wed, 21 Oct 2026 16:45:17 +0200
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 4/4] hw/intc/exynos4210_combiner: write default case is
 unreachable, not guest error
To: Peter Maydell <peter.maydell@linaro.org>, qemu-arm@nongnu.org,
 qemu-devel@nongnu.org
References: <20261019162217.3272337-1-peter.maydell@linaro.org>
 <20261019162217.3272337-5-peter.maydell@linaro.org>
From: Richard Henderson <richard.henderson@linaro.org>
Content-Language: en-US
In-Reply-To: <20261019162217.3272337-5-peter.maydell@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32f;
 envelope-from=richard.henderson@linaro.org; helo=mail-wm1-x32f.google.com
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
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
X-Spam-Status: No, score=-17.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On 10/19/26 18:22, Peter Maydell wrote:
> In exynos4210_combiner_write(), we rule out "reg_n > 1" before we
> start doing anything as being an invalid guest access.  The default
> case in the later "switch (reg_n)" is therefore unreachable, because
> it has explicit cases for 0 and 1.  Use g_assert_not_reached()
> instead of a LOG_GUEST_ERROR.
> 
> Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
> ---
>   hw/intc/exynos4210_combiner.c | 4 +---
>   1 file changed, 1 insertion(+), 3 deletions(-)
> 
> diff --git a/hw/intc/exynos4210_combiner.c b/hw/intc/exynos4210_combiner.c
> index 2bdb9a0152c..80295ae6402 100644
> --- a/hw/intc/exynos4210_combiner.c
> +++ b/hw/intc/exynos4210_combiner.c
> @@ -242,9 +242,7 @@ static void exynos4210_combiner_write(void *opaque, hwaddr offset,
>           exynos4210_combiner_update(s, grp_quad_base_n + 3);
>           break;
>       default:
> -        qemu_log_mask(LOG_GUEST_ERROR,
> -                      "exynos4210.combiner: unallowed write access at offset 0x"
> -                      HWADDR_FMT_plx "\n", offset);
> +        g_assert_not_reached();
>           break;
>       }
>   }

You could remove the break as well as unreachable.

r~

