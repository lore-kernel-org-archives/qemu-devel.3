Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 142D4C48260
	for <qemu-devel@archiver.kernel.org>; Thu,  8 Feb 2024 21:13:59 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rYBhl-00007P-GD; Thu, 08 Feb 2024 16:13:09 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1rYBhi-00006p-Vx
 for qemu-devel@nongnu.org; Thu, 08 Feb 2024 16:13:07 -0500
Received: from mail-pl1-x636.google.com ([2607:f8b0:4864:20::636])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1rYBhd-00053j-2w
 for qemu-devel@nongnu.org; Thu, 08 Feb 2024 16:13:06 -0500
Received: by mail-pl1-x636.google.com with SMTP id
 d9443c01a7336-1d8da50bffaso1483495ad.2
 for <qemu-devel@nongnu.org>; Thu, 08 Feb 2024 13:13:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1707426779; x=1708031579; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=Ipc2NmqOs9CgMDunTFwU/6Jw/KOoy4huD5QiC9nbkzY=;
 b=GHcxMQZntDWZA091pQkYC0/gYT1zv3NvTLq6573GNaLcE2lOOijahObLJpFo4kU59j
 mcEhiOooE/4xwnUZj6clOXeQHrIPfH8zZlc+Hez8NMO6RltotvjZMszMif8h6494ApXq
 fGDG8fEldvH20wvEmnwmLPz5svpBJ/zz82BSq1XL1B9oLYjJeplK9KV8JFxpIy4uDY4k
 fpyJumINMFCIq0ALlvuouT4jMbWTRf+wecJwH3I8qYbTDHFsjQqB/I7n0DoTn1Fh1j7f
 Rbx006zOsbMXHMChyU2fSRELSfGm+jE9Z8clCNwIVSu0wzAJLVTId9LPrUiK4sjqqzTU
 pHZg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1707426779; x=1708031579;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=Ipc2NmqOs9CgMDunTFwU/6Jw/KOoy4huD5QiC9nbkzY=;
 b=BUbD70tinZbJWVU5Q9RuqpLs1viHBQKHemS5D/9kbxWpdbmJrDEVNJmJiED9wmddLN
 27NgaqmveWDEX8gomfWsaDE+dkHMLIcC+YG/LJrdzzXXrpGgh5AQ6cBTJB/R2m0ZBnBl
 1MXM+8gMLGdLi0z+0GSz74BR1lpFlZM7hTbVdIHjnlcYFmkmyV5R0hr9wkIFS70D0UKZ
 PGxsUKv4hn9P9Py54MUieyxZdytRVHa0aRKbd0B5bJ7v3FkGm+a5da0hkoDkap0AzFJe
 TDHjFg6xfzJk7MTFLlSmQ+2oASzOUhnR30KNCOFSpv0Px1KTtF1vkhrz0ZeCE9dEvw1w
 lzdw==
X-Gm-Message-State: AOJu0YyxxT1+IYQcbIMMISP74ysbD4hXYHgxxCi9PjNZC1I77TRNv2Lu
 Zf/L6vyTTqS8UWag9PZ/mG8OqopuGrJfIs7go5CryGri/46/3mT4Yz6Gp/htFCw=
X-Google-Smtp-Source: AGHT+IFjxwh835rGPE4+wHkRNAGhmtkKXWULXR7C5jRuxgka6gHirMyQUEn4M9bgOHEr7SDTgdyO5A==
X-Received: by 2002:a17:902:d48b:b0:1d9:ee5f:a980 with SMTP id
 c11-20020a170902d48b00b001d9ee5fa980mr617087plg.26.1707426779325; 
 Thu, 08 Feb 2024 13:12:59 -0800 (PST)
X-Forwarded-Encrypted: i=1;
 AJvYcCVjfeIglCJ+6/cRrA5aiRSaFbUvoJ4O3K3lPqPx1Kj2RvjmnqDDi9xhE4I5NPZAM62jHC0bwzCnvApOxFg5KRF24fuR0mw=
Received: from [192.168.4.112] (066-027-223-101.inf.spectrum.com.
 [66.27.223.101]) by smtp.gmail.com with ESMTPSA id
 jk15-20020a170903330f00b001d947e65ad8sm199627plb.251.2024.02.08.13.12.58
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 08 Feb 2024 13:12:58 -0800 (PST)
Message-ID: <f3fe1d8c-cd40-4753-8d2a-dca881be7846@linaro.org>
Date: Thu, 8 Feb 2024 11:12:55 -1000
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 09/13] target/hppa: Allow read-access to PSW with rsm
 0,reg instruction
Content-Language: en-US
To: deller@kernel.org, qemu-devel@nongnu.org
Cc: Helge Deller <deller@gmx.de>
References: <20240207182023.36316-1-deller@kernel.org>
 <20240207182023.36316-10-deller@kernel.org>
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20240207182023.36316-10-deller@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::636;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x636.google.com
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

On 2/7/24 08:20, deller@kernel.org wrote:
> From: Helge Deller <deller@gmx.de>
> 
> HP-UX 11 and HP ODE tools use the "rsm 0,%reg" instruction in not priviledged
> code paths to get the current PSW flags. The constant 0 means that no bits of
> the PSW shall be reset, so this is effectively a read-only access to the PSW.
> Allow this read-only access even for not privileged code.
> 
> Signed-off-by: Helge Deller <deller@gmx.de>
> ---
>   target/hppa/translate.c | 8 +++++++-
>   1 file changed, 7 insertions(+), 1 deletion(-)
> 
> diff --git a/target/hppa/translate.c b/target/hppa/translate.c
> index 10fdc0813d..7e58775bbf 100644
> --- a/target/hppa/translate.c
> +++ b/target/hppa/translate.c
> @@ -2156,10 +2156,16 @@ static bool trans_ldsid(DisasContext *ctx, arg_ldsid *a)
>   
>   static bool trans_rsm(DisasContext *ctx, arg_rsm *a)
>   {
> +#ifdef CONFIG_USER_ONLY
>       CHECK_MOST_PRIVILEGED(EXCP_PRIV_OPR);
> -#ifndef CONFIG_USER_ONLY
> +#else
>       TCGv_i64 tmp;
>   
> +    /* HP-UX 11i and HP ODE use rsm for read-access to PSW */
> +    if (a->i) {
> +        CHECK_MOST_PRIVILEGED(EXCP_PRIV_OPR);
> +    }
> +
>       nullify_over(ctx);

Wow, that is not documented in the manual.  I wonder what this user-land software uses 
this for?  There aren't many bits in there that are relevant to user-land.

I suppose PSW_W is readable from there, but that can be inferred from SAR...

Acked-by: Richard Henderson <richard.henderson@linaro.org>


r~

