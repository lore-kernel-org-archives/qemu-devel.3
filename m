Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AF1A4C3DA63
	for <qemu-devel@archiver.kernel.org>; Tue, 23 Jul 2024 22:18:38 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sWNp0-0005Lb-FU; Tue, 23 Jul 2024 18:17:26 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1sWNoy-0005J5-PX
 for qemu-devel@nongnu.org; Tue, 23 Jul 2024 18:17:24 -0400
Received: from mail-pf1-x435.google.com ([2607:f8b0:4864:20::435])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1sWNox-0004ix-0c
 for qemu-devel@nongnu.org; Tue, 23 Jul 2024 18:17:24 -0400
Received: by mail-pf1-x435.google.com with SMTP id
 d2e1a72fcca58-70d2ae44790so1717038b3a.2
 for <qemu-devel@nongnu.org>; Tue, 23 Jul 2024 15:17:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1721773041; x=1722377841; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=kZnJW0odpJB6Jn6jB0v6ML9CNn+yk0AqxZ3Yulij9s8=;
 b=JzVYUfhQ7rvvCnlVOcLvLdQnXRJoFJfX7N8bxm0kKzltZYN5Exl0fML5Kq0E+VFdIE
 LC550qF/x2DnJh6Pon2oSIiXKtcS6aTtKa1fjmIO96PDmL0fRpj2NoelTNOjmjna1XPk
 s+DzUNRHWqAMyRiziG/zpzcjjI9brYvcFEpIyXgFM8i1Fiqh/pF7k4xz7uP3EpC1EvIV
 cc+cZuojfUxrttDUwc9xwZaXeJvqfqXG7fFiuAR8xS/By97D91SKqClUThjqN/fSHB6w
 CdKVnxvr5TavxYl+OZCTJUZlNm1PB2Kk6ip5GTMdD42kzbuw7g0XSU89E/tIgbYrcNHd
 dFFA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1721773041; x=1722377841;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=kZnJW0odpJB6Jn6jB0v6ML9CNn+yk0AqxZ3Yulij9s8=;
 b=Xq7hTGfOCdMtAUsi0bZRSx4HYf+qvU7Mfaj22Xzz6IXx9yuuS5bQoVwFb1hz4814b1
 kRIJnlzA0k6koh4JG2r8b6O//7cITlSWaKrzMGIuHB5Qwq9kvCgklA3X7KXGji/xjGZi
 00AJRojMN+gYG+mR98wodYSUr00ImsYp31AysdHzKxkHxR8oPP9/NnwBorXGEbTQEgI2
 7tpOpnBjDiHGPgbIa098mhpIr2KlOTZ82+tpT9nrkfzDsFG/MI8971+6cVyz0I8rS9Uq
 e0JaFYrjUzJd0T1gDGihqms8MzJSxsB0gqP91ca9Nj2drcoLawBK3J0ZA8SFoijG4SS8
 TjCA==
X-Forwarded-Encrypted: i=1;
 AJvYcCW6P7WQQ7BAEQQWecNnbIvGG7GuN46vc75+LewOMPqFRjN50P0sLtRwkGZzvXuf2crsc9vOoqze3sa9zxJEvxZcSHUyb3Y=
X-Gm-Message-State: AOJu0YyJTw5HYOJ62Tqr6GMvyGnijpdYOOzIAE2eu5aOMMwDwcoRGNoL
 v2I4nkLin5Eg50L7Y/k9hyYMlqo5C3mQZR7tw7u3iDiP6kxSnbPm5lJ7AgOpmaqg5RZLS00OgwT
 VTqKzkQ==
X-Google-Smtp-Source: AGHT+IHZd6JpYvzTrRykUyoc0g1/Fwi3/H5pIUFpCOlfJpuWLDdP+uHg3j3mwL1Uj0B1JF2nL0QJvQ==
X-Received: by 2002:a05:6a00:2392:b0:706:375e:220d with SMTP id
 d2e1a72fcca58-70d087c5f60mr10141659b3a.30.1721773041064; 
 Tue, 23 Jul 2024 15:17:21 -0700 (PDT)
Received: from [192.168.1.113] ([203.56.128.103])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-70d1c99ce43sm4678025b3a.205.2024.07.23.15.17.17
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 23 Jul 2024 15:17:20 -0700 (PDT)
Message-ID: <821cff40-c233-491a-af49-cd4df719bc29@linaro.org>
Date: Wed, 24 Jul 2024 08:17:12 +1000
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH qemu] fix for SME FMOPA instructions
To: ~danikhan632 <danikhan632@gmail.com>
Cc: zhaoshiz@quicinc.com, steplong@quicinc.com,
 qemu-devel <qemu-devel@nongnu.org>
References: <172174307919.22473.9260569782229496330-0@git.sr.ht>
Content-Language: en-US
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <172174307919.22473.9260569782229496330-0@git.sr.ht>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::435;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x435.google.com
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

On 7/23/24 23:21, ~danikhan632 wrote:
> From: Daniyal Khan <danikhan632@gmail.com>
> 
> ---
>   target/arm/tcg/sme_helper.c    | 122 +++++++++++++++++++++------------
>   target/arm/tcg/translate-sme.c |  37 +++++++++-
>   2 files changed, 115 insertions(+), 44 deletions(-)
> 
> diff --git a/target/arm/tcg/sme_helper.c b/target/arm/tcg/sme_helper.c
> index e2e05750399..e95045dfecc 100644
> --- a/target/arm/tcg/sme_helper.c
> +++ b/target/arm/tcg/sme_helper.c
> @@ -893,15 +893,16 @@ void HELPER(sme_fmopa_s)(void *vza, void *vzn, void *vzm, void *vpn,
>       intptr_t row, col, oprsz = simd_maxsz(desc);
>       uint32_t neg = simd_data(desc) << 31;
>       uint16_t *pn = vpn, *pm = vpm;
> -    float_status fpst;
> +    float_status *fpst = vst;
> +    float_status local_fpst;
>   
>       /*
>        * Make a copy of float_status because this operation does not
>        * update the cumulative fp exception status.  It also produces
>        * default nans.
>        */
> -    fpst = *(float_status *)vst;
> -    set_default_nan_mode(true, &fpst);
> +    local_fpst = *fpst;
> +    set_default_nan_mode(true, &local_fpst);
>   
>       for (row = 0; row < oprsz; ) {
>           uint16_t pa = pn[H2(row >> 4)];
> @@ -916,8 +917,8 @@ void HELPER(sme_fmopa_s)(void *vza, void *vzn, void *vzm, void *vpn,
>                           if (pb & 1) {
>                               uint32_t *a = vza_row + H1_4(col);
>                               uint32_t *m = vzm + H1_4(col);
> -                            *a = float32_muladd(n, *m, *a, 0, vst);
> -                        }
> +                            *a = float32_muladd(n, *m, *a, 0, &local_fpst);

This is now fixed upstream with 31d93fedf41c24b0badb38cd9317590d1ef74e37.

> +static float64 float16_to_float64_denormal(uint16_t a, float_status *status)
> +{
> +    if ((a & 0x7c00) == 0 && (a & 0x03ff) != 0) {
> +        /* This is a denormal number */
> +        int16_t exp = -14;
> +        uint16_t frac = a & 0x03ff;
> +        while ((frac & 0x0400) == 0) {
> +            frac <<= 1;
> +            exp--;
> +        }
> +        /* Remove the implicit bit */
> +        frac &= 0x03ff;
> +        /* Create the float64 */
> +        uint64_t f64 = ((uint64_t)(a & 0x8000) << 48) |
> +                       ((uint64_t)(exp + 1023) << 52) |
> +                       ((uint64_t)frac << 42);
> +        return *(float64 *)&f64;
> +    } else {
> +        /* For normal numbers, use the existing function*/
> +        return float16_to_float64(a, false, status);
> +    }
> +}


Why do you believe this is needed?  Conversion is handled correctly in float16_to_float64. 
  The same goes for the rest of the patch.


r~

