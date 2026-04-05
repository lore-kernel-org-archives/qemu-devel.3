Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B13C0E9D828
	for <qemu-devel@archiver.kernel.org>; Sun,  5 Apr 2026 23:30:22 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w9Wuz-0000kN-1a; Sun, 05 Apr 2026 19:30:13 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1w9Wux-0000i8-Fp
 for qemu-devel@nongnu.org; Sun, 05 Apr 2026 19:30:11 -0400
Received: from mail-pf1-x42c.google.com ([2607:f8b0:4864:20::42c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1w9Wuv-0004F4-T4
 for qemu-devel@nongnu.org; Sun, 05 Apr 2026 19:30:11 -0400
Received: by mail-pf1-x42c.google.com with SMTP id
 d2e1a72fcca58-82d03827316so1103534b3a.0
 for <qemu-devel@nongnu.org>; Sun, 05 Apr 2026 16:30:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1775431808; x=1776036608; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:to:subject:user-agent:mime-version:date:message-id:from
 :to:cc:subject:date:message-id:reply-to;
 bh=nenjRWV7Ht32r3oQVrWxtzlug6zUWn8l52CcNdxEP1k=;
 b=Bx/br7uWIu4grycPUP57fpi1P1CE1AIzjS3iqHLR9xgLAnk4CLZ2QgpI2ptEqjKyJv
 mmKd0/1nUzCPf1u8G4KH4RzjRgMjBrNkoWXAmDvzK5rn9qVQHGP69Gg1X+e9IbBxBRsy
 AF+ShFNoDrUA3+/haX7LFX3CdXDZgTusJJ/hBh9ZNKpkFSZurBbZ64KNdUddJyFTFyyY
 vnX5Du22b1F3w+B+03+n8Cz/YntcO5LirMh/e8IF706Z6nqgWDHTO8IuzxmS+IJaF+t7
 orDjR8VbMjk6J7imaiiCml7tW4V/Z2/E1TGZ1HSjn9bOv97CnRKq/TorxlTGH69d9NMY
 yepQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1775431808; x=1776036608;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:to:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=nenjRWV7Ht32r3oQVrWxtzlug6zUWn8l52CcNdxEP1k=;
 b=MPWvQtQXKHn2+fQmwb2Nj4MW33gaHzQq4R2hHjIkzpDkYI6/b49AYQlkveGoYLdXca
 Y0o7YazwA3hnQnkjaC7FysR3eTExc39ahcDsY6C3JI0QrpsqQZ7BoXE9VTxsamHRfUl6
 Bz9Dn/B6iM2XReYiP3Nw/L6asmmlkC5gCFHh3h6qnIWHc9ivdkHrOO7O5Ju2fFkLbseO
 C5kS/yon97wlpBg0W3jVCBTWfeMd94Eu0BjSgfTmvWNQGQTsNST3WnjUrpYmjGnxKs4n
 TdSjGMqT0dVWWIyJ1bOiY0Hcrj54Jckaz3qGHvJ+cbwIntGTU3kt8imd8kNhG0exmH2g
 QWNw==
X-Gm-Message-State: AOJu0YzCAfL1c+TfV6+ZIiJn2ve2YJ8AFda7e9I9aH3ure5ygdIOo19d
 g9x4y1xGsgxvsO7ivyzcq0qd7FBNhPy+s62lnXw0wGgCe89oi5JKKBeJQYtz6+PLFVtGwD0ditK
 WgFtB
X-Gm-Gg: AeBDievubbMg235i2r5WE8nnaJ2uU+Bp1sdfd+7UondJ4S2m9yRruUzz9Kylsd0Qv7d
 lGcj+TteT+QFrIs9i9XrVNxvITXDblsarh12oOv/8b/fF9+pzjOQTBNbFyatkDPPXXqbKkk6u3t
 ah7Zm/CzsUUe0zEdkJxYNNv2NXPZw8iHGTX+R3/gaY56JVruRL73ypSfxsonrtVVORWl6lNcBFj
 N5UMEWxF/KuavVeUntEfp6ScTF/xH3RybmnekcA72z9OtmU1NM8VD5jJwsPq/BOKIzTbyQKYOZ9
 251Nhh/e5KAZTgtz4a+c3DaT4AMwnPu1vIjp1p+Ja4EOIihxFBzK4AfYzBPdy5944vQFn2DmV6p
 MfglQVvE+DV2xBM5IxNh41Tv7X33evUyVPwbSH351MknwUT5UM6CzrJYpsTxDQob2parc+1cIOo
 m/VJZDMNDAXWgQYOAOXJd2kOj4MhEZSaPrmpiBStobECbxg0pxrki8AoBvJm3HKPnybuE=
X-Received: by 2002:a05:6a00:1388:b0:82a:1c99:dce0 with SMTP id
 d2e1a72fcca58-82d001e6c18mr12611644b3a.2.1775431807834; 
 Sun, 05 Apr 2026 16:30:07 -0700 (PDT)
Received: from [192.168.1.105] (124-150-69-109.tpgi.com.au. [124.150.69.109])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-82cf9b3c930sm12357369b3a.17.2026.04.05.16.30.06
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sun, 05 Apr 2026 16:30:07 -0700 (PDT)
Message-ID: <48c4ff79-fbe8-4026-b922-e0959738dce7@linaro.org>
Date: Mon, 6 Apr 2026 09:30:02 +1000
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH 09/35] target/arm: migrate Granule Protection traps to
 registerfields
To: qemu-devel@nongnu.org
References: <20260320130607.2071996-1-alex.bennee@linaro.org>
 <20260320130607.2071996-10-alex.bennee@linaro.org>
From: Richard Henderson <richard.henderson@linaro.org>
Content-Language: en-US
In-Reply-To: <20260320130607.2071996-10-alex.bennee@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::42c;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x42c.google.com
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
>   target/arm/syndrome.h | 30 +++++++++++++++++++++++++++---
>   1 file changed, 27 insertions(+), 3 deletions(-)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

r~

> 
> diff --git a/target/arm/syndrome.h b/target/arm/syndrome.h
> index fb86e7bf6a8..3fd82f5b565 100644
> --- a/target/arm/syndrome.h
> +++ b/target/arm/syndrome.h
> @@ -462,12 +462,36 @@ static inline uint32_t syn_bxjtrap(int cv, int cond, int rm)
>       return res;
>   }
>   
> +/*
> + * ISS encoding for a Granule Protection Check exception
> + *
> + * These are only reported to EL3
> + */
> +FIELD(GPC_ISS, xFSC, 0, 6)
> +FIELD(GPC_ISS, WnR, 6, 1) /* Write not Read */
> +FIELD(GPC_ISS, S1PTW, 7, 1)
> +FIELD(GPC_ISS, CM, 8, 1)
> +FIELD(GPC_ISS, VNCR, 13, 1)
> +FIELD(GPC_ISS, GPCSC, 14, 6)
> +FIELD(GPC_ISS, InD, 20, 1) /* Instruction not Data access */
> +FIELD(GPC_ISS, S2PTW, 21, 1)
> +
>   static inline uint32_t syn_gpc(int s2ptw, int ind, int gpcsc, int vncr,
>                                  int cm, int s1ptw, int wnr, int fsc)
>   {
> -    return (EC_GPC << ARM_EL_EC_SHIFT) | ARM_EL_IL | (s2ptw << 21)
> -        | (ind << 20) | (gpcsc << 14) | (vncr << 13) | (cm << 8)
> -        | (s1ptw << 7) | (wnr << 6) | fsc;
> +    uint32_t res = syn_set_ec(0, EC_GPC);
> +    res = FIELD_DP32(res, SYNDROME, IL, 1);
> +
> +    res = FIELD_DP32(res, GPC_ISS, S2PTW, s2ptw);
> +    res = FIELD_DP32(res, GPC_ISS, InD, ind);
> +    res = FIELD_DP32(res, GPC_ISS, GPCSC, gpcsc);
> +    res = FIELD_DP32(res, GPC_ISS, VNCR, vncr);
> +    res = FIELD_DP32(res, GPC_ISS, CM, cm);
> +    res = FIELD_DP32(res, GPC_ISS, S1PTW, s1ptw);
> +    res = FIELD_DP32(res, GPC_ISS, WnR, wnr);
> +    res = FIELD_DP32(res, GPC_ISS, xFSC, fsc);
> +
> +    return res;
>   }
>   
>   static inline uint32_t syn_insn_abort(int same_el, int ea, int s1ptw, int fsc)


