Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 79DEAE9D827
	for <qemu-devel@archiver.kernel.org>; Sun,  5 Apr 2026 23:22:40 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w9WnU-0003C4-Ip; Sun, 05 Apr 2026 19:22:28 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1w9WnT-0003Ao-42
 for qemu-devel@nongnu.org; Sun, 05 Apr 2026 19:22:27 -0400
Received: from mail-pj1-x1031.google.com ([2607:f8b0:4864:20::1031])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1w9WnR-0002s1-KG
 for qemu-devel@nongnu.org; Sun, 05 Apr 2026 19:22:26 -0400
Received: by mail-pj1-x1031.google.com with SMTP id
 98e67ed59e1d1-35c206f0481so3286323a91.0
 for <qemu-devel@nongnu.org>; Sun, 05 Apr 2026 16:22:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1775431344; x=1776036144; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:to:subject:user-agent:mime-version:date:message-id:from
 :to:cc:subject:date:message-id:reply-to;
 bh=tp3zmo5L29XsyPQdubePyff6DmBK7RGaR/pnwo6K6y4=;
 b=piXRhdbVZHSQOMITbjCQnSJeoDsUD+hvlTLhzdzaC6jjo25+m5YXlEO3Lrcya6CWIR
 fUETV6s/nwhDPkLgf8EJ6JDKkF2MsaOYwCBfLdnExzjs6Zb8T3UopGflTY6BNsQ9r8T+
 EjLTtoljieowvDeeYoZtZXgcBGN7lTd2JfAllTjjDns3mRdyhxr3B6dN5AlYhqNr7Cgx
 IWUZxSFw2+BbgJXyGfjRuMFBh9CtUwSyyV7+zkdcVTJ0nOGQC4ltxcKe4+SPynbGAwmz
 7/+liMF/j6AcM+LSc3AppcRVyVezTfal1DzZcrOvfli2ZZppY35fOioz5Ff+0MVf1eME
 PsTQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1775431344; x=1776036144;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:to:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=tp3zmo5L29XsyPQdubePyff6DmBK7RGaR/pnwo6K6y4=;
 b=Vvg5B4A4eGzzrhMfYqnKQkM3nSTZ0+SwosHMef+USo/9idiZXM98+veyg7qkeRZaCm
 4Vvqfc5Wg39Gb51vyBQFl5rIvRqTLQmuUUW5JS7TeyAamUZp+BedBBOVZ0/qXGPgRj6Y
 sRYyKpY8kWtxcz2daDyISEeg33tIVPXECApH7oO2ubxgPcaGyeAtb+XHuSfUQUnff++T
 1wqXIanwQ6zgYnzwmGbCZsX6Rrwsnrc5tbWIFv/ol2ni8WeCYK+CiJ+xpW0GJOo48GBu
 6HLww2vBWZKLFTne4WmL3H9xrBKVyb1M9nMKEoZ0HJaGC0+YsrNxkLpKPSmwlRF9jpDz
 cCKw==
X-Gm-Message-State: AOJu0YwgX4FcfgOERkRSQxS9Y2ChVHHb+qx5c1VVwteBpiQy60E6GW+n
 GTUE2JffMvXuze78zmdCrO3Ka4j+YD4c/XUWvrNW/ZnbbKAtJ1eaWUrWBRujuJ/aOp8f2+RuNeU
 /cfEZ
X-Gm-Gg: AeBDietyGjt6XhpbgjONoSoxhARPwnC9xYsIow2WnTNUECawgqYpglTnX15GMS3jpDV
 7ckf4Pgt62Uac0AgpBEJFEFidMJOhCVlimRh8jcZT5W9bckVW07cGXcLrMy8jXka2c3UJ+vgC6D
 O74XbcwMs+byQMsrcpTQ31RWK/FvlVxlR4ai7vdrg4Q7iRnttSSqo9i/ixXqlysmzBEN4lTghDS
 gGDAu5Hsja/WM0jg/zCmpQ4ST4d78JQFObUntkGiaVwHMUhtsEBEa6yO1j9RZi8DJZgXHux6OrW
 2/kINJgEHkbXDwekiZtySANIcpKqoHt8mgoolP8U+bOmPIT+ykeDJveDUhI8rt9RMPtP9hB7BwM
 tqE6ysMWsVVTmfk0bBLvswe6GH6WEo662uBjZIwI8/38xrWqvfCjJYwjnO6Rm7yWYzzSM+lDyum
 lu8j8A9lN1jjdfX204rcyyOqQ73CrZzNYYgmIcGCWDzxrXKhN1ffkF2zTrocy4SXci0EA=
X-Received: by 2002:a17:90a:d605:b0:35b:93d8:6aaa with SMTP id
 98e67ed59e1d1-35de68ce83emr10014399a91.19.1775431344055; 
 Sun, 05 Apr 2026 16:22:24 -0700 (PDT)
Received: from [192.168.1.105] (124-150-69-109.tpgi.com.au. [124.150.69.109])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-35de69fce68sm3352399a91.10.2026.04.05.16.22.22
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sun, 05 Apr 2026 16:22:23 -0700 (PDT)
Message-ID: <1869a77a-5259-463d-a7ef-bc5f0506c735@linaro.org>
Date: Mon, 6 Apr 2026 09:22:18 +1000
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH 05/35] target/arm: migrate SME trap syndromes to
 registerfields
To: qemu-devel@nongnu.org
References: <20260320130607.2071996-1-alex.bennee@linaro.org>
 <20260320130607.2071996-6-alex.bennee@linaro.org>
From: Richard Henderson <richard.henderson@linaro.org>
Content-Language: en-US
In-Reply-To: <20260320130607.2071996-6-alex.bennee@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::1031;
 envelope-from=richard.henderson@linaro.org; helo=mail-pj1-x1031.google.com
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

On 3/21/26 00:05, Alex Bennée wrote:
> Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
> ---
>   target/arm/syndrome.h | 12 ++++++++++--
>   1 file changed, 10 insertions(+), 2 deletions(-)
> 
> diff --git a/target/arm/syndrome.h b/target/arm/syndrome.h
> index b145a52769f..abec0a4908e 100644
> --- a/target/arm/syndrome.h
> +++ b/target/arm/syndrome.h
> @@ -384,10 +384,18 @@ static inline uint32_t syn_erettrap(int eret_op)
>       return res;
>   }
>   
> +/*
> + * ISS encoding for an exception due to SME functionality
> + */
> +FIELD(SME_ISS, SMTC, 0, 2)
> +
>   static inline uint32_t syn_smetrap(SMEExceptionType etype, bool is_16bit)
>   {
> -    return (EC_SMETRAP << ARM_EL_EC_SHIFT)
> -        | (is_16bit ? 0 : ARM_EL_IL) | etype;
> +    uint32_t res = syn_set_ec(0, EC_SMETRAP);
> +    res = FIELD_DP32(res, SYNDROME, IL, is_16bit ? 0 : 1);
> +    res = FIELD_DP32(res, SME_ISS, SMTC, etype);
> +
> +    return res;
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

r~

