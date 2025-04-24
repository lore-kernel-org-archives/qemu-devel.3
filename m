Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 00AF9C369AB
	for <qemu-devel@archiver.kernel.org>; Thu, 24 Apr 2025 06:55:20 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u7qTw-0004VV-Ba; Thu, 24 Apr 2025 02:54:48 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1u7qTu-0004VI-I6
 for qemu-devel@nongnu.org; Thu, 24 Apr 2025 02:54:46 -0400
Received: from mail-wm1-x331.google.com ([2a00:1450:4864:20::331])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1u7qTs-0000w2-Rp
 for qemu-devel@nongnu.org; Thu, 24 Apr 2025 02:54:46 -0400
Received: by mail-wm1-x331.google.com with SMTP id
 5b1f17b1804b1-43cec5cd73bso2876085e9.3
 for <qemu-devel@nongnu.org>; Wed, 23 Apr 2025 23:54:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1745477683; x=1746082483; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id:from
 :to:cc:subject:date:message-id:reply-to;
 bh=LJqDqb3zgt+C4ZQ5uifmY2LyBhUT60Z8PlWqzA1UJcs=;
 b=b5ty3Y9X8fdKiYjb3J1aG8dAuYl2q5kue47je0/lf94iy/SmDZhqS8hGgrvNWlYJFe
 u+UthMYcCEm21JUHOHaFyGGSx9TZ8rb4XfoFpJ0CBlTqqu3eJ2Y7+dPN6zN1sH99ft6V
 iGBcCmvoFTyDkmM6QjuRHzSe4XK51Ofo+n1utV6NHSL5SqzdsYjO7gQpH0QM07enPEOl
 f3ppVqN4J1I3Uk7GFnNvERdfXPbPoawOnPjJdsXPWJAquYWAe98NOp6MnBLhDZ4lfUmx
 hI02wJjoF7q4pUa4r89u8ThBr+OCQgKXC1GregrAoHr37ZYRUrhDfMIeZEW88qMf+GSU
 oHnQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1745477683; x=1746082483;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=LJqDqb3zgt+C4ZQ5uifmY2LyBhUT60Z8PlWqzA1UJcs=;
 b=JBqG+EPqHbak18nKR9qmM445Cyg15jgLQB7zFp6fcObCxj7HyhY8z57j8ZL5r4hjT2
 yXuS5DgX2BC6ZevYWZM6Vp4CrGnbjdHIx1KpoD7orS34bYenIz/u4BYbKpqaDYEcTeth
 y0fXhIwlScToJ/lPyhGaUsjDcaW02iR4eWggo2tvBhJ7CM5HWZo+H/9kfJCDMbHSijlF
 ZHPkwN46Cp+NR6A6sXnITMyqH745itji/ToSEHaEP17/Iy/HfZQr/8SI1uMcv4cib/Cr
 k2qM0/5T0lSe669DV/lyMU4rgeK+D8ndWvSS1fXkHrfLN+nFL4oGGVqvFZwDj04bRLYM
 k7cQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCXt0rIxVKOMaE2lLLNmmmeP8pSIm0ph6SwcNYIWPvXbOLcSsZtzob3FyDgWtL6LHGFb5qNRfcgjV4Hg@nongnu.org
X-Gm-Message-State: AOJu0Yw3uaaCV84Oc+zBPjxTaVDira05rPKQRW3ULmyTNGwpwnhGul5h
 eMJOUMu8eKWYV5pS1fwzFhwMYfwfkT19tUjRjlrFSCvCov9IgesZ39TVK6t57sk=
X-Gm-Gg: ASbGnctL3OshQ4UgNG6m7NpyEnR3Z+vrK/Oibe/0oMPBtwFHsLIIyRapBph2LbabzCU
 qhs4QelO0OdEDrlIj8ZTBFeBIphRMoijfTmHRb28GCFp5Ow5UmwLEHGX5pU0bQwApteM8GvoWh/
 WEfJGa0I8bIA565Iay+2Qm1YJifPfG4A4IcWa5AeiDTJpYX+tfTBJqDZtU3wfYHZTAVvZhrOhog
 J5ZF8i0KJGkEG9Iy7/ZRhYvMVFCbyCsAO9fsLP4E237cAVnSx1Bms95EgTVgrdm/4zslmA13MIk
 bsjCMCv3t69AZzYJq32Eu0fuU3t0bEv/FBQMJet1B/piGR41eCSOTJlPHJH/Xk7WznWowGj5N+8
 l017i9crAsxynbA==
X-Google-Smtp-Source: AGHT+IHheP7cK+bS4Er53rQda1CTPIrVcU1j3GQ9mQQYXLKm4B8hLgvwb6YbzN8IKc04xe3AaiJcQg==
X-Received: by 2002:a05:600c:1c91:b0:43d:5ec:b2f4 with SMTP id
 5b1f17b1804b1-4409bd18185mr12678575e9.10.1745477682860; 
 Wed, 23 Apr 2025 23:54:42 -0700 (PDT)
Received: from [192.168.69.169] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4409d2bec50sm8251835e9.33.2025.04.23.23.54.41
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 23 Apr 2025 23:54:42 -0700 (PDT)
Message-ID: <87d5270d-6c90-48a5-a973-a647a67e6c20@linaro.org>
Date: Thu, 24 Apr 2025 08:54:41 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 03/15] accel/tcg: Add CPUState arg to
 tb_invalidate_phys_page_range__locked
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
References: <20250424011918.599958-1-richard.henderson@linaro.org>
 <20250424011918.599958-4-richard.henderson@linaro.org>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20250424011918.599958-4-richard.henderson@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::331;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x331.google.com
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

On 24/4/25 03:19, Richard Henderson wrote:
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>   accel/tcg/tb-maint.c | 9 ++++++---
>   1 file changed, 6 insertions(+), 3 deletions(-)
> 
> diff --git a/accel/tcg/tb-maint.c b/accel/tcg/tb-maint.c
> index 714dcaedc9..e8a465c9ac 100644
> --- a/accel/tcg/tb-maint.c
> +++ b/accel/tcg/tb-maint.c
> @@ -1100,9 +1100,12 @@ bool tb_invalidate_phys_page_unwind(CPUState *cpu, tb_page_addr_t addr,
>   /*
>    * @p must be non-NULL.
>    * Call with all @pages locked.
> + * If cpu may be NULL outside of a cpu context.  In which case,

s/If cpu/@cpu/ ?

> + * precise_smc need not be detected.
>    */

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>


