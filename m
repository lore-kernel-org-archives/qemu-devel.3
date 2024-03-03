Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A0CFDC5478C
	for <qemu-devel@archiver.kernel.org>; Sun,  3 Mar 2024 02:10:57 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rgbIw-0000VW-5p; Sat, 02 Mar 2024 21:10:18 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1rgbIt-0000Tl-Ad
 for qemu-devel@nongnu.org; Sat, 02 Mar 2024 21:10:15 -0500
Received: from mail-pg1-x536.google.com ([2607:f8b0:4864:20::536])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1rgbIn-0008Qz-6b
 for qemu-devel@nongnu.org; Sat, 02 Mar 2024 21:10:14 -0500
Received: by mail-pg1-x536.google.com with SMTP id
 41be03b00d2f7-5dbcfa0eb5dso3179026a12.3
 for <qemu-devel@nongnu.org>; Sat, 02 Mar 2024 18:10:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1709431806; x=1710036606; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=hZzRf3NTHKpptwBGTIxgEOUGLrULCKZ2XASd/MlZOZs=;
 b=ljETqiB9kO99+fr6gROK3TrMechxuTFU9uhy2r0f7L33gIPSFWOOgNxppf4QGMK9FB
 YtIdbtKC6t2rBhvEBJUaxUMpA04wSv4Rg23/Rk/riA6Wam28wADV4xeiswKO2fBVXxcj
 L9hrdgpN9+EjowMweD5qo1+/aZzAHn6Ee0vfR+kXDneEtRIN5DDcfx2T6/qqks2GLvyH
 3iVugeNwsIG3Hd+kGkz+jgUvmYL6fvKKtfU+7kn+iDWuoRBM4rsCuhho3VtUHCAAYSM9
 PuGSjlain5KIRqTSSNNHWJ/T6KBysHzUvTBjRIyl90ZUrH37vADhi59afotgeSvfIv8b
 whAQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1709431806; x=1710036606;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=hZzRf3NTHKpptwBGTIxgEOUGLrULCKZ2XASd/MlZOZs=;
 b=Jf5RS0hyu+W9v8sT15jddeFwRPXkh1m9A2kJ2vfI5osRdae6FZYS3wvBYv7z501Hpa
 MACT/vvegPU8LAY23yQ2s07hG8cRKs0R2NP6iZTunbE+895nNefBdFJavwN/pNN39yxV
 aIu0SR/bvvrpTISRvE0A8hqrO5D2xy9yqEkS16iw6Lzo1+lRhrGlmeYOFbLilCLjxuub
 RsWjaOiIYF8s6eE3/HIGM6lKbKztECtzAtA3BKmtRyytlqXH/tn6bvBBQISkwbav+XNr
 C9YnRJXunzzy0BzyBuK6yMwy3VKmg/ZZuxOhAzrLnJmE+hXgUnt7oydPvSZfCV+gWlN5
 83sQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCX4msSfvYSi0QLvo7F7wcYVYiC1otQjNVsBbAojqiLiJa2f5ZmL6p2eRtikk8qDCZops7L8IZibu96yOHxOVB4DFiTjkSo=
X-Gm-Message-State: AOJu0YyReRk8B5lNMy+6o+hNhXiheTrnU2Fd8teFWpRx6dwy+58z0dMF
 ChCvgFom26XOzWrS0HwYcVFXO28+Efl0mBXoTJQ/C5+ydF6YWrFQq2dHiNrMkZCBkLq6E+QNtCh
 8
X-Google-Smtp-Source: AGHT+IGnVkaRutCm+WDhyAwN+ycoE1NPVZhTdcrcI9rudJqxzTdUCpTEUoUgUoNpjvDcmKXohzggQA==
X-Received: by 2002:a17:903:1111:b0:1dc:fc0b:6a41 with SMTP id
 n17-20020a170903111100b001dcfc0b6a41mr2520882plh.59.1709431806410; 
 Sat, 02 Mar 2024 18:10:06 -0800 (PST)
Received: from [192.168.6.128] (098-147-055-211.res.spectrum.com.
 [98.147.55.211]) by smtp.gmail.com with ESMTPSA id
 p23-20020a1709027ed700b001dcf8ebe89bsm2076033plb.112.2024.03.02.18.10.05
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sat, 02 Mar 2024 18:10:06 -0800 (PST)
Message-ID: <4f6bbf0f-20d2-4599-a8b3-5fb0a381d6dd@linaro.org>
Date: Sat, 2 Mar 2024 16:10:02 -1000
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/5] target/hppa: Fix unaligned double word accesses for
 hppa64
Content-Language: en-US
To: deller@kernel.org, qemu-devel@nongnu.org
Cc: deller@gmx.de
References: <20240302223524.24421-1-deller@kernel.org>
 <20240302223524.24421-2-deller@kernel.org>
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20240302223524.24421-2-deller@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::536;
 envelope-from=richard.henderson@linaro.org; helo=mail-pg1-x536.google.com
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

On 3/2/24 12:35, deller@kernel.org wrote:
> From: Guenter Roeck <linux@roeck-us.net>
> 
> Unaligned 64-bit accesses were found in Linux to clobber carry bits,
> resulting in bad results if an arithmetic operation involving a
> carry bit was executed after an unaligned 64-bit operation.
> 
> hppa 2.0 defines additional carry bits in PSW register bits 32..39.
> When restoring PSW after executing an unaligned instruction trap,
> those bits were not cleared and ended up to be active all the time.
> Clearing bit 32..39 in psw prior to restoring it solves the problem.
> 
> Fixes: 931adff31478 ("target/hppa: Update cpu_hppa_get/put_psw for hppa64")
> Cc: Richard Henderson <richard.henderson@linaro.org>
> Cc: Charlie Jenkins <charlie@rivosinc.com>
> Cc: Helge Deller <deller@gmx.de>
> Signed-off-by: Guenter Roeck <linux@roeck-us.net>
> Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>   target/hppa/helper.c | 7 ++++++-
>   1 file changed, 6 insertions(+), 1 deletion(-)
> 
> diff --git a/target/hppa/helper.c b/target/hppa/helper.c
> index 859644c47a..7b798d1227 100644
> --- a/target/hppa/helper.c
> +++ b/target/hppa/helper.c
> @@ -76,7 +76,12 @@ void cpu_hppa_put_psw(CPUHPPAState *env, target_ulong psw)
>       }
>       psw &= ~reserved;
>   
> -    env->psw = psw & ~(PSW_N | PSW_V | PSW_CB);
> +    if (hppa_is_pa20(env)) {
> +        env->psw = psw & ~(PSW_N | PSW_V | PSW_CB | 0xff00000000ull);
> +    } else {
> +        env->psw = psw & ~(PSW_N | PSW_V | PSW_CB);
> +    }

https://patchew.org/QEMU/20240217015811.1975411-1-linux@roeck-us.net/

was the better version.


r~

