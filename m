Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 59F94C54E58
	for <qemu-devel@archiver.kernel.org>; Mon, 18 Mar 2024 17:33:29 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rmGqg-0000cg-Bt; Mon, 18 Mar 2024 13:32:34 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1rmGqb-0000bd-WE
 for qemu-devel@nongnu.org; Mon, 18 Mar 2024 13:32:30 -0400
Received: from mail-pl1-x62d.google.com ([2607:f8b0:4864:20::62d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1rmGqZ-00028T-DC
 for qemu-devel@nongnu.org; Mon, 18 Mar 2024 13:32:29 -0400
Received: by mail-pl1-x62d.google.com with SMTP id
 d9443c01a7336-1e00d1e13acso7854515ad.0
 for <qemu-devel@nongnu.org>; Mon, 18 Mar 2024 10:32:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1710783145; x=1711387945; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=x0yq9zfy4fLMTn+6jMX8v3nHfrY4ljxQa5EU3gclCy4=;
 b=SH3ByUtj5gnxJsdMPK2ukOOdM+0iNZDolcYg4Rh6P7Eu3RCQY4VrX660UyXVUIIexO
 4VaChh72cD9Mwrf76ZZcjuB16EjxrhvURJmqlmMDvoKXv0hKvT/alygUhMbf2hQ5lly/
 dQmyjLMSTtOLiVWBuMIwmcBxzYprEqCBHs3Nrb++LwEuY5lpQBnYnVQ2q0SD6HKhzAkD
 E7KOmMsRuR+OrF+CuaGrBZQd/QbVSeMYgCclBtKdNx3XpZlB9C11TcDZyzam8Wt01nvC
 Ea9JOxS7Z2HSALjp9nrUyKrTr5QtwicsjUh8hVIj6U41CDLNY6IiYa9zcdigYUxMwVP8
 WQDQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1710783145; x=1711387945;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=x0yq9zfy4fLMTn+6jMX8v3nHfrY4ljxQa5EU3gclCy4=;
 b=keRr9f58HsEwBChrpTQaJd3aRNd1tUU15Ta1YUSOsKiElLy93nnG6wBJiMU+BtWROD
 x0ce1eUSwppvsLGKxzqRBjTkiCAIZLwv9irDCMCuj+mFSbyysWKmp+9i/xJxr/DJwEpj
 qH4e+VcUF+lmhw/Qi3FVmS+W0OhZMnl03bytb8lwL6B/7YJ9r0p9hNWkGDKFwF2dkVds
 ITUd3fT7X0UAymqnm6sitQEXqKVk4s9kHnoosNTGHFS9vDOvjI1VC45yZ4e0pvRklnT/
 VSyKuD3ccq8HIc9KhxoSSVuvNTwSPiRjlPAwg//cQiBCZUaPlgZ9opz0x6MzEOdLl06L
 ok6g==
X-Forwarded-Encrypted: i=1;
 AJvYcCW3hCr/YUKY7P7p1ZLPq4dFjLhpHR552Plhsdx5Xv9NKqix8+OIltUarXrcWiiuob0aToKUi3ZWepk9Ly66xmBKbzJjFto=
X-Gm-Message-State: AOJu0Yx54Si+EIlYOAir2WfMexYKX1EBEXRgTJtuy9BMmCIzl0TXej5v
 NCJkPFsxMo94adzELmNW0fmre/YxLv1oj2kWiND4U2ciEpwf8TndKAOMNc3ifzI=
X-Google-Smtp-Source: AGHT+IE0rR47fChDPvzJIqHEgK7zofmQS+eOPwHcYlewR/MaTNwekj+zyl0VoKqZ2S7ssOm5ohkb5Q==
X-Received: by 2002:a17:902:cf12:b0:1de:f99d:c4dc with SMTP id
 i18-20020a170902cf1200b001def99dc4dcmr452582plg.0.1710783145547; 
 Mon, 18 Mar 2024 10:32:25 -0700 (PDT)
Received: from [172.20.1.19] (173-197-098-125.biz.spectrum.com.
 [173.197.98.125]) by smtp.gmail.com with ESMTPSA id
 x7-20020a170902a38700b001dee4bd73e0sm8328068pla.59.2024.03.18.10.32.23
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 18 Mar 2024 10:32:24 -0700 (PDT)
Message-ID: <068a88ff-dfe0-4bbe-aa28-9ff3c6c61ea1@linaro.org>
Date: Mon, 18 Mar 2024 07:32:21 -1000
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/2] target/s390x: Use mutable temporary value for op_ts
Content-Language: en-US
To: Ilya Leoshkevich <iii@linux.ibm.com>, David Hildenbrand
 <david@redhat.com>, Thomas Huth <thuth@redhat.com>
Cc: qemu-s390x@nongnu.org, qemu-devel@nongnu.org, Ido Plat <ido.plat@ibm.com>
References: <20240318162633.13017-1-iii@linux.ibm.com>
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20240318162633.13017-1-iii@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62d;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x62d.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=unavailable autolearn_force=no
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

On 3/18/24 06:26, Ilya Leoshkevich wrote:
> From: Ido Plat <ido.plat@ibm.com>
> 
> Otherwise TCG would assume the register that holds t1 would be constant
> and reuse whenever it needs the value within it.
> 
> Reviewed-by: Ilya Leoshkevich <iii@linux.ibm.com>
> [iii: Adjust a newline and capitalization]
> Signed-off-by: Ido Plat <ido.plat@ibm.com>
> ---
>   target/s390x/tcg/translate.c | 3 ++-
>   1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/target/s390x/tcg/translate.c b/target/s390x/tcg/translate.c
> index 0d0c672c959..3fdddac7684 100644
> --- a/target/s390x/tcg/translate.c
> +++ b/target/s390x/tcg/translate.c
> @@ -4781,8 +4781,9 @@ static DisasJumpType op_trXX(DisasContext *s, DisasOps *o)
>   
>   static DisasJumpType op_ts(DisasContext *s, DisasOps *o)
>   {
> -    TCGv_i32 t1 = tcg_constant_i32(0xff);
> +    TCGv_i32 t1 = tcg_temp_new_i32();
>   
> +    tcg_gen_movi_i32(t1, 0xff);
>       tcg_gen_atomic_xchg_i32(t1, o->in2, t1, get_mem_index(s), MO_UB);

Better as

     TCGv_i32 ff = tcg_constant_i32(0xff);
     TCGv_i32 t1 = tcg_temp_new_i32();

     tcg_gen_atomic_xchg_i32(t1, o->in2, ff, get_mem_index(s), MO_UB);

With that,
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>


r~

