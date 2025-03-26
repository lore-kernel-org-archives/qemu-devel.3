Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EBAE2C36008
	for <qemu-devel@archiver.kernel.org>; Wed, 26 Mar 2025 18:27:07 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1txVSZ-0000Uz-Al; Wed, 26 Mar 2025 14:26:41 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1txVSN-0000Tr-8q
 for qemu-devel@nongnu.org; Wed, 26 Mar 2025 14:26:27 -0400
Received: from mail-oa1-x31.google.com ([2001:4860:4864:20::31])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1txVSL-0002lc-77
 for qemu-devel@nongnu.org; Wed, 26 Mar 2025 14:26:27 -0400
Received: by mail-oa1-x31.google.com with SMTP id
 586e51a60fabf-2c7e5fb8c38so51280fac.1
 for <qemu-devel@nongnu.org>; Wed, 26 Mar 2025 11:26:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1743013583; x=1743618383; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id:from
 :to:cc:subject:date:message-id:reply-to;
 bh=6LgpZRLhA0HGtc6l0Eja7ojaPjTlpePfziAt3iuU+W4=;
 b=D/igSPvQeQQ2wBnA1FIbEII+qvYrpoLCQU6ay3fmfAQsQDVwlLWdnl1dNKm98S+WRv
 ZCDBR4NUih5gHExz+ru/+KK1tsGYzxJPZNGkczopcwebYODhx+9cewmU5fiySyyDXHc/
 6qxSnHWPuYSFhzpkm/RO06s1OIFndXsa3kB1m6/UGImgAkYDhdXgXJcUyatGzLVyAd5t
 kmz6zNFq06zcJ+PC03oll0LIjZAsg9H5srulqDSvscC9DtTAc4rmFKtMc3BZjpAkMu3c
 zSfkDd5oYge4kKAHrb+theZ573EQBQBPQRsAgdOoPVjk4e2wSNgKbKBTUZEQlWoQpxhL
 QdQQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1743013583; x=1743618383;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=6LgpZRLhA0HGtc6l0Eja7ojaPjTlpePfziAt3iuU+W4=;
 b=Q5z2v8VVZF+nXTF9yL8+WF9YOwbJpIuw7dt3ICdeVuxvwOTPd/eRIpXfJjC2zFQNba
 cbYCUBxBYbkj3SdG0kjTcj42oNXUyXNiLHOu7VvtrvJ7FtE7HMriqOBgThWeTTfHENPq
 sdolj8pjTtLAs+zbr+ccBwRxzlCO/HQBjpMehpZvaIfFy6t1s3rSsykdDbqWWgHaXOUQ
 ZqeCCY9yzA8rkMeDchFoVbxeJdwYnEJ1MQ4+hFgIb1VL7Do6+4j9jp7vJr73NnJC5hI3
 kVLiD8WfRyjQNElrZXKkFZSWeJqGdt2Bdr9NyJ5zSW55Z9mZNd92orhIIthtTFZBE/2N
 2GfA==
X-Gm-Message-State: AOJu0YxK5D9LikSvhZ+aLHwBZAAf/TurT6rJcqZrbEK7K7azIXsnHsjY
 s72Y6Wbwf7v85A392qo2t4zBHZXHtmgQ1E8shygCZucquvoXp/xKMZVLELv8Vepapx/2HUJdtm9
 t
X-Gm-Gg: ASbGncv1D4hWGJjb+alqZz70phTkLp46jMId8TGVLKjuyBweVmGF9LfsJ3YDf1+z5dE
 XMlT+gSEciJXelSdZVaH0YTbcMwSZdQy53S2XiWS2peFt6SomhNhTk0Jw2HwMJ4XfUSSirB7miz
 n2Qm0lDYRI4MgnQU9wTf5pUC4V5TvjwjoCOTS9Jes+gubD3rBPm3AgcDXZumLuxlVFre+jS+y9y
 c433mPVe6XytqvENhFqVVIkvv3rR+q78ULFrKzPCrNik38hCGgblrp3EoBZvhahGH/uQksF1OIw
 FVQk5Uz1tDRtgSkOLTLk9V1Lp9qjp79s5Soovs7///BjkcresOQCBc7qo05CFLzoRhAByYrqnEX
 FdPhaQHgIwjUNBCg5+eDzUw==
X-Google-Smtp-Source: AGHT+IHacoO94vyVCBFyFocbqZpIDyGfiJXU9RCD9xPEYW4VzyoiJC3uR2PXn8AwCuK1Zp8qKRuAKg==
X-Received: by 2002:a05:6871:3585:b0:29e:3921:b1ea with SMTP id
 586e51a60fabf-2c84820e329mr329201fac.30.1743013583477; 
 Wed, 26 Mar 2025 11:26:23 -0700 (PDT)
Received: from [172.20.102.85] (syn-071-042-197-003.biz.spectrum.com.
 [71.42.197.3]) by smtp.gmail.com with ESMTPSA id
 586e51a60fabf-2c77ecbf0dcsm3179182fac.23.2025.03.26.11.26.22
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 26 Mar 2025 11:26:23 -0700 (PDT)
Message-ID: <8b5e37b4-8679-46ef-a32f-6c95d36af2db@linaro.org>
Date: Wed, 26 Mar 2025 13:26:21 -0500
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH-for-10.1 8/8] target/mips: Introduce
 mips_env_64bit_enabled() helper
To: qemu-devel@nongnu.org
References: <20250325154058.92735-1-philmd@linaro.org>
 <20250325154058.92735-9-philmd@linaro.org>
Content-Language: en-US
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20250325154058.92735-9-philmd@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2001:4860:4864:20::31;
 envelope-from=richard.henderson@linaro.org; helo=mail-oa1-x31.google.com
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

On 3/25/25 10:40, Philippe Mathieu-Daudé wrote:
> mips_env_64bit_enabled() returns whether the CPU is running
> in 32-bit or 64-bit (behavior which might change at runtime).
> 
> Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
> ---
>   target/mips/internal.h | 5 +++++
>   1 file changed, 5 insertions(+)
> 
> diff --git a/target/mips/internal.h b/target/mips/internal.h
> index 28eb28936ba..8107a59b908 100644
> --- a/target/mips/internal.h
> +++ b/target/mips/internal.h
> @@ -225,6 +225,11 @@ static inline void mips_env_set_pc(CPUMIPSState *env, target_ulong value)
>       }
>   }
>   
> +static inline bool mips_env_64bit_enabled(CPUMIPSState *env)
> +{
> +    return env->hflags & MIPS_HFLAG_64;
> +}
> +
>   static inline bool mips_env_is_bigendian(CPUMIPSState *env)
>   {
>       return extract32(env->CP0_Config0, CP0C0_BE, 1);

Maybe delay this until you need it?

r~

