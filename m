Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 90C74D42BBE
	for <qemu-devel@archiver.kernel.org>; Tue, 12 Nov 2024 18:17:20 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tAvRv-0007Q2-Dk; Tue, 12 Nov 2024 13:17:12 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tAvRm-00072S-Kd
 for qemu-devel@nongnu.org; Tue, 12 Nov 2024 13:17:04 -0500
Received: from mail-pf1-x42f.google.com ([2607:f8b0:4864:20::42f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tAvRh-0002a6-W6
 for qemu-devel@nongnu.org; Tue, 12 Nov 2024 13:17:00 -0500
Received: by mail-pf1-x42f.google.com with SMTP id
 d2e1a72fcca58-723f37dd76cso6252165b3a.0
 for <qemu-devel@nongnu.org>; Tue, 12 Nov 2024 10:16:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1731435416; x=1732040216; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=kgaRKPyoKGY0lmL3jESziCCMCKNi+ytVvkJzPgSL+SA=;
 b=LkavVAI3G4+geiQeHiwCOMKXoZp33W6Vdk/4hAmAZftiR5DU5KrfijCaEw32sdED2x
 k2KzVH8YN/QhCPZnEU/WPqoS0k01O2/r7Wwd+AMfZOEy0tvjGuV4S7t482PUuk9MI65T
 5mJ+XsamohZEqmeqnNLFgtcj1oRFKWai5NXmz64zkwpg7ZrR/4xYBTX80YVlP9awn6dK
 oOnXowkRzRJeDAiC0YySsZzkO5nzxaUaXO1Fn2jzy7GvPrSUIvNac2tTVyz09lLkeKxH
 en/bfA7SVi63DTrhc7jkNMLf69rFhWpMx2s2I/sa57yqTC1qzqii007efhz0NWOwgKmT
 ilqg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1731435416; x=1732040216;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=kgaRKPyoKGY0lmL3jESziCCMCKNi+ytVvkJzPgSL+SA=;
 b=hDm25vsXrcihdXRvoQLFsHp5UiyVjxQU3uXgUkM41BOenVsQHk6xDP6d+RMAgLzNAp
 +TL5sfsM3tVI4fXJzY54mA53a9iO6/flH1JGLaZGxJ7qwPP1Asa/TifIdEIDF4r9VYpU
 w8rXGiCAEHclqDgAFSTneIufEpVHLpF0/oZ39xdQbKAX8AsQbrX8ZMh9IC6P9EZB+r3i
 4J80uqgLVS+pyEYaLYzK7zHokusCneP7+bT80+SJxOLJry4FB9m8afcIYADgJ4yl8s70
 xctDk4eZzF1JibEQwFHtifK1g4ehJlfKrRf7aotLD4Mi34R+Bw2TwtIVVE8CvIMbjrz6
 a3Bg==
X-Forwarded-Encrypted: i=1;
 AJvYcCWt+QydtApEXntaAlGH/v4b96eiBzz4cB/dKansjS+sMhD972kUs8DumXuGcjOXQK9lqbEz3I80cUK5@nongnu.org
X-Gm-Message-State: AOJu0Yy6NuJMk+DQw3SCAh+WbtPg7IAai4is6heCw+Yp4g7u9S03lHmQ
 O7IWYAw+rpEZsS7G+mLk22jDnzunWSxyX6o5E2gYwyDkNMsBliPWfieTWH+XrPU=
X-Google-Smtp-Source: AGHT+IFrCqfasquGDyXl/rHEAFQkxjH6xYcT6lAwch7TSTl6Rw8XTFze6391uzVd8mTd2Rah24YSVg==
X-Received: by 2002:a05:6a21:3296:b0:1db:db84:da47 with SMTP id
 adf61e73a8af0-1dc704503efmr198378637.29.1731435416082; 
 Tue, 12 Nov 2024 10:16:56 -0800 (PST)
Received: from [192.168.52.227] (wsip-24-120-228-34.lv.lv.cox.net.
 [24.120.228.34]) by smtp.gmail.com with ESMTPSA id
 41be03b00d2f7-7f41f65aa9csm10730997a12.74.2024.11.12.10.16.55
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 12 Nov 2024 10:16:55 -0800 (PST)
Message-ID: <f8043207-f525-4f64-9a1e-a354f6cad6fc@linaro.org>
Date: Tue, 12 Nov 2024 10:16:53 -0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 4/6] target/mips: Decode LSA shift amount using
 decodetree function
To: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 qemu-devel@nongnu.org
Cc: Aleksandar Rikalo <arikalo@gmail.com>,
 Jiaxun Yang <jiaxun.yang@flygoat.com>, Aurelien Jarno <aurelien@aurel32.net>
References: <20241112172022.88348-1-philmd@linaro.org>
 <20241112172022.88348-5-philmd@linaro.org>
Content-Language: en-US
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20241112172022.88348-5-philmd@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::42f;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x42f.google.com
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

On 11/12/24 09:20, Philippe Mathieu-Daudé wrote:
> Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
> ---
>   target/mips/tcg/msa.decode       | 3 ++-
>   target/mips/tcg/rel6.decode      | 4 +++-
>   target/mips/tcg/msa_translate.c  | 4 ++--
>   target/mips/tcg/rel6_translate.c | 9 +++++++--
>   4 files changed, 14 insertions(+), 6 deletions(-)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

r~

> 
> diff --git a/target/mips/tcg/msa.decode b/target/mips/tcg/msa.decode
> index 4410e2a02e..798e8c401a 100644
> --- a/target/mips/tcg/msa.decode
> +++ b/target/mips/tcg/msa.decode
> @@ -21,6 +21,7 @@
>   &msa_elm_df         df  wd ws       n
>   &msa_elm                wd ws
>   
> +%lsa_sa             6:2  !function=plus_1
>   %elm_df             16:6 !function=elm_df
>   %elm_n              16:6 !function=elm_n
>   %bit_df             16:7 !function=bit_df
> @@ -29,7 +30,7 @@
>   %3r_df_h            21:1 !function=plus_1
>   %3r_df_w            21:1 !function=plus_2
>   
> -@lsa                ...... rs:5 rt:5 rd:5 ... sa:2 ......   &r
> +@lsa                ...... rs:5 rt:5 rd:5 ... .. ......     &r sa=%lsa_sa
>   @ldst               ...... sa:s10 ws:5 wd:5 .... df:2       &msa_i
>   @bz_v               ...... ... ..    wt:5 sa:s16            &msa_bz df=3
>   @bz                 ...... ...  df:2 wt:5 sa:s16            &msa_bz
> diff --git a/target/mips/tcg/rel6.decode b/target/mips/tcg/rel6.decode
> index d6989cf56e..a9031171b5 100644
> --- a/target/mips/tcg/rel6.decode
> +++ b/target/mips/tcg/rel6.decode
> @@ -16,7 +16,9 @@
>   
>   &r                  rs rt rd sa
>   
> -@lsa                ...... rs:5 rt:5 rd:5 ... sa:2 ......   &r
> +%lsa_sa             6:2  !function=plus_1
> +
> +@lsa                ...... rs:5 rt:5 rd:5 ... .. ......     &r sa=%lsa_sa
>   
>   LSA                 000000 ..... ..... ..... 000 .. 000101  @lsa
>   DLSA                000000 ..... ..... ..... 000 .. 010101  @lsa
> diff --git a/target/mips/tcg/msa_translate.c b/target/mips/tcg/msa_translate.c
> index 82b149922f..75cf80a20e 100644
> --- a/target/mips/tcg/msa_translate.c
> +++ b/target/mips/tcg/msa_translate.c
> @@ -780,7 +780,7 @@ TRANS_DF_iv(ST, trans_msa_ldst, gen_helper_msa_st);
>   
>   static bool trans_LSA(DisasContext *ctx, arg_r *a)
>   {
> -    return gen_lsa(ctx, a->rd, a->rt, a->rs, a->sa + 1);
> +    return gen_lsa(ctx, a->rd, a->rt, a->rs, a->sa);
>   }
>   
>   static bool trans_DLSA(DisasContext *ctx, arg_r *a)
> @@ -788,5 +788,5 @@ static bool trans_DLSA(DisasContext *ctx, arg_r *a)
>       if (TARGET_LONG_BITS != 64) {
>           return false;
>       }
> -    return gen_dlsa(ctx, a->rd, a->rt, a->rs, a->sa + 1);
> +    return gen_dlsa(ctx, a->rd, a->rt, a->rs, a->sa);
>   }
> diff --git a/target/mips/tcg/rel6_translate.c b/target/mips/tcg/rel6_translate.c
> index 363bc86491..2522ecae2b 100644
> --- a/target/mips/tcg/rel6_translate.c
> +++ b/target/mips/tcg/rel6_translate.c
> @@ -11,6 +11,11 @@
>   #include "qemu/osdep.h"
>   #include "translate.h"
>   
> +static inline int plus_1(DisasContext *ctx, int x)
> +{
> +    return x + 1;
> +}
> +
>   /* Include the auto-generated decoders.  */
>   #include "decode-rel6.c.inc"
>   
> @@ -23,7 +28,7 @@ bool trans_REMOVED(DisasContext *ctx, arg_REMOVED *a)
>   
>   static bool trans_LSA(DisasContext *ctx, arg_r *a)
>   {
> -    return gen_lsa(ctx, a->rd, a->rt, a->rs, a->sa + 1);
> +    return gen_lsa(ctx, a->rd, a->rt, a->rs, a->sa);
>   }
>   
>   static bool trans_DLSA(DisasContext *ctx, arg_r *a)
> @@ -31,5 +36,5 @@ static bool trans_DLSA(DisasContext *ctx, arg_r *a)
>       if (TARGET_LONG_BITS != 64) {
>           return false;
>       }
> -    return gen_dlsa(ctx, a->rd, a->rt, a->rs, a->sa + 1);
> +    return gen_dlsa(ctx, a->rd, a->rt, a->rs, a->sa);
>   }


