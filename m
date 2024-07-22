Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 23B1FC3DA5D
	for <qemu-devel@archiver.kernel.org>; Mon, 22 Jul 2024 23:25:26 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sW2OZ-0003YG-JF; Mon, 22 Jul 2024 19:24:43 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1sW2OX-0003XY-Fc
 for qemu-devel@nongnu.org; Mon, 22 Jul 2024 19:24:41 -0400
Received: from mail-pf1-x432.google.com ([2607:f8b0:4864:20::432])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1sW2OU-000609-Fr
 for qemu-devel@nongnu.org; Mon, 22 Jul 2024 19:24:40 -0400
Received: by mail-pf1-x432.google.com with SMTP id
 d2e1a72fcca58-70d333d5890so845149b3a.0
 for <qemu-devel@nongnu.org>; Mon, 22 Jul 2024 16:24:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1721690675; x=1722295475; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=qsevfAY9GIpyUuote11CGtGX1WMHv6oHZhtvbmU0TbM=;
 b=qlOziCAxicy9P7g33u938WVae/1IBhbC4hEwv8w5F0hBaDlI+dQn74Rnq3TzMcEIWn
 CTEgWM0xDrewSeWI2BLplSMa4WKj6gqGv3nciIxG4It8J42I8Qc6I8+I1c/v84RTxA8j
 xRUWTuicn6ouPN/Lz1gvwR2phwjePlawUBLnSWZLRYQVDt0n6vynGyttXuOND/fqHApM
 apFdHM6MqyAxX0PjvPYqLGZQiyUd00ftA2jQoxvyiHuc9lNYh1U28HZ+OixfgPqUA4sf
 CgilYuqXjnoXEEd9vBb7A1Rm2KCMrmqElb8vindE8Yf7+Tm5U5SpdyDs8t6ZHqulLE52
 jF+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1721690675; x=1722295475;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=qsevfAY9GIpyUuote11CGtGX1WMHv6oHZhtvbmU0TbM=;
 b=Uf92e4adFOcguvpXNmpeR2lt1qOiTQo+j2n/LFNegGKlUX3mll/THHKJk2r7iZVP7R
 dBe4ULXGDWIPFgOHIQj6mNYG22X4gsG4aCUmLyzpdny5OSNbM2YFdpK5K0Sd75HMFxCh
 4aMKDSTGCXqE+4HAw704EnoyXuo+6jrTK3W8u0yb0mZaGgaM6mQDikhktFGxQ7Kp4ZdI
 Oh+zzSGq9SyBgB3BFhT4uLYTOluGqMOGb7w9esC+UPTs1mBetR9ITldB4OloGg45K1Dc
 SB85D7BVoCLlU8XIpRUZsXm1dtHfS3yRSiMgPzfjCPaJQBCygMrcb6n1hPL5Yjaq4XRz
 uWpw==
X-Forwarded-Encrypted: i=1;
 AJvYcCV77pggSyG0+zyUwAqozDLa07kZsRsLAKXaXDChk9j/O7vqza+EM9qsIJHIQbukoN68GnywzBXEnWjs7YNNVXwfzgL/K2w=
X-Gm-Message-State: AOJu0YxViGCmatbvTkNRYBXhQ3lxnaqhrKB+1L2Z+1ydEKkna3pmCFIL
 Lsz1u5ADE0na5psBftrmCsixjXVFGD5yqSh3ydizeQY881qp5RLpGp8yfb5ay33/O7RbS0s29kl
 fhKS0iw==
X-Google-Smtp-Source: AGHT+IFjbgaSlchWf1/Bs2E21pyHGqFrMPKy7eiFI8Q2zF61Fl6QYk8Xn5UU7/ZH6G9veEAioEtORg==
X-Received: by 2002:a05:6a00:10c3:b0:70d:2892:402b with SMTP id
 d2e1a72fcca58-70d289243a2mr6541538b3a.7.1721690675375; 
 Mon, 22 Jul 2024 16:24:35 -0700 (PDT)
Received: from [192.168.1.113] ([203.56.128.103])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-70d241803fdsm2731099b3a.220.2024.07.22.16.24.32
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 22 Jul 2024 16:24:34 -0700 (PDT)
Message-ID: <0b27836e-88d2-475a-9cd4-bf781861298c@linaro.org>
Date: Tue, 23 Jul 2024 09:24:29 +1000
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/2] util/getauxval: Ensure setting errno if not found
To: Vivian Wang <uwu@dram.page>, qemu-devel@nongnu.org
Cc: Richard Henderson <rth@twiddle.net>, Laurent Vivier <laurent@vivier.eu>
References: <20240721090817.120888-1-uwu@dram.page>
 <20240721090817.120888-2-uwu@dram.page>
Content-Language: en-US
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20240721090817.120888-2-uwu@dram.page>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::432;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x432.google.com
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

On 7/21/24 19:08, Vivian Wang wrote:
> Sometimes zero is a valid value for getauxval (e.g. AT_EXECFD). Make
> sure that we can distinguish between a valid zero value and a not found
> entry by setting errno.
> 
> Ignore getauxval from sys/auxv.h on glibc < 2.19 because it does not set
> errno.
> 
> Signed-off-by: Vivian Wang <uwu@dram.page>
> ---
>   util/getauxval.c | 14 ++++++++++++--
>   1 file changed, 12 insertions(+), 2 deletions(-)
> 
> diff --git a/util/getauxval.c b/util/getauxval.c
> index b124107d61..f1008bdc59 100644
> --- a/util/getauxval.c
> +++ b/util/getauxval.c
> @@ -24,7 +24,13 @@
>   
>   #include "qemu/osdep.h"
>   
> -#ifdef CONFIG_GETAUXVAL
> +/* If glibc < 2.19, getauxval can't be used because it does not set errno if
> +   entry is not found. */
> +#if defined(CONFIG_GETAUXVAL) && \
> +    (!defined(__GLIBC__) \
> +        || __GLIBC__ > 2 \
> +        || (__GLIBC__ == 2 && __GLIBC_MINOR__ >= 19))

Version 2.19 is so long ago that all supported OS releases have something newer.  For 
Alpine Linux using musl, the first commit of getauxval had the errno setting.

Therefore we don't need this check.

> @@ -95,6 +101,7 @@ unsigned long qemu_getauxval(unsigned long type)
>           }
>       }
>   
> +    errno = ENOENT;
>       return 0;
>   }

Ok.

> @@ -104,7 +111,9 @@ unsigned long qemu_getauxval(unsigned long type)
>   unsigned long qemu_getauxval(unsigned long type)
>   {
>       unsigned long aux = 0;
> -    elf_aux_info(type, &aux, sizeof(aux));
> +    int ret = elf_aux_info(type, &aux, sizeof(aux));
> +    if (ret != 0)
> +        errno = ret;

Braces required.

>       return aux;
>   }
>   
> @@ -112,6 +121,7 @@ unsigned long qemu_getauxval(unsigned long type)
>   
>   unsigned long qemu_getauxval(unsigned long type)
>   {
> +    errno = ENOSYS;
>       return 0;
>   }

Ok.


r~

