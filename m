Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 08283C27C53
	for <qemu-devel@archiver.kernel.org>; Sat, 22 Jun 2024 16:56:22 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sL41V-0004T4-9R; Sat, 22 Jun 2024 12:55:33 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1sL41T-0004Sa-Ui
 for qemu-devel@nongnu.org; Sat, 22 Jun 2024 12:55:31 -0400
Received: from mail-pf1-x434.google.com ([2607:f8b0:4864:20::434])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1sL41S-0001mX-AS
 for qemu-devel@nongnu.org; Sat, 22 Jun 2024 12:55:31 -0400
Received: by mail-pf1-x434.google.com with SMTP id
 d2e1a72fcca58-7066c799382so370065b3a.3
 for <qemu-devel@nongnu.org>; Sat, 22 Jun 2024 09:55:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1719075329; x=1719680129; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id:from
 :to:cc:subject:date:message-id:reply-to;
 bh=BDsAQ7Faz0CJ6QN+3lU9nvKNb3jLqhqG+fEBguDOLOc=;
 b=frpzp7cFcqYYGLUFOZZj9jz/KMIppHROK9YxA8AfHL6Cgd6NGQ2jFIrEvUkKjeOgAK
 Z6kn8Uj/sj3icBzCaAtXI+gA/9+cdfLTF3DFEatPIkftwmP2omJTo/j9vpnG21x4IZvc
 HKF5WLy04wqbn+ukkd6NovgPO9+FGuO6QsN6AN3Qze4CEMUKhR/jnd1UPnKBmjb4pmoU
 LxeY6UmuImOtflXAWj8DcoZoozDpntVx1aEq99q4M9vo/BngDYcXBEfRuTyg/QbEXYtC
 QOs+dBsaIkCoqaSRs5v+9fcfSbCK5YUCFIfrwG3ysB2cmUXxGJ6ITtotRh8WJimf30FQ
 plcA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1719075329; x=1719680129;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=BDsAQ7Faz0CJ6QN+3lU9nvKNb3jLqhqG+fEBguDOLOc=;
 b=JzIs4YArMv/k6G8D3M+rQN5fCDJnlWDtm8EE3+DbMQ000Ell04nMayIiMZj38EeXub
 NEB68ptLSoOo4uEEDny4Qemq7ocXHfQueIji1Whg8+woYIeTcmUgv75ZqZBvfDb6Ed/p
 fAuzo/MEyQIHwdBKZa0Lg7+FvsxQly+JlEWfSqZRl4pwbrXu/D1e+0Rz81Up2YigU9bM
 fD97iD/XjIH9qxIq8iysxklPRdLZG7l1xCNzorkCYJxBgAvxat7UrssLr015EOUWVvN1
 BmdJiWbGlFOtutgnsz7mLlW/A/che1XooYAVvM7ColpHXMUHKINycWvK+032vyp1laLH
 tRJQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCUcH9Q0TmYceYo//MPQNvtbFHEm/tWvGEZwlMS7+CIDjxzN3lYds5HkqagtY86PU+g/JV0oyRz5mm9DEaNz30AZtjU9sqI=
X-Gm-Message-State: AOJu0YznZI4Ejki/xRknZ+7IDePCRBAEMgt3BCurJZw97RyyLtb1LMCT
 Ksx8ATQlcO8W7FKrTbDn7aCtIMr3cG/4gu2PBXIJvi8/GlJfnC6nN8VPBuVfgbI=
X-Google-Smtp-Source: AGHT+IFiEbkLzlwE3jNKxGTS8f6YG6Lz0T0fKWzbKBniK2UkWlqXZ8maz/cPHfiPtD54o4KcIp/Y1A==
X-Received: by 2002:a05:6a20:b713:b0:1b6:da8b:ad with SMTP id
 adf61e73a8af0-1bcf7eecf04mr285596637.34.1719075328735; 
 Sat, 22 Jun 2024 09:55:28 -0700 (PDT)
Received: from [192.168.0.4] (174-21-76-141.tukw.qwest.net. [174.21.76.141])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-7065126d0b0sm3285189b3a.103.2024.06.22.09.55.28
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sat, 22 Jun 2024 09:55:28 -0700 (PDT)
Message-ID: <448c9d98-8793-4c1a-90a8-f4883aa67a29@linaro.org>
Date: Sat, 22 Jun 2024 09:55:26 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PULL 15/23] Revert "host/i386: assume presence of SSE2"
To: Paolo Bonzini <pbonzini@redhat.com>, qemu-devel@nongnu.org
References: <20240622061558.530543-1-pbonzini@redhat.com>
 <20240622061558.530543-16-pbonzini@redhat.com>
Content-Language: en-US
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20240622061558.530543-16-pbonzini@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::434;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x434.google.com
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

On 6/21/24 23:15, Paolo Bonzini wrote:
> This reverts commit b18236897ca15c3db1506d8edb9a191dfe51429c.
> The x86-64 instruction set can now be tuned down to x86-64 v1
> or i386 Pentium Pro.
> 
> Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
> ---
>   host/include/i386/host/cpuinfo.h | 1 +
>   util/bufferiszero.c              | 4 ++--
>   util/cpuinfo-i386.c              | 1 +
>   3 files changed, 4 insertions(+), 2 deletions(-)
> 
> diff --git a/host/include/i386/host/cpuinfo.h b/host/include/i386/host/cpuinfo.h
> index 72f6fad61e5..81771733eaa 100644
> --- a/host/include/i386/host/cpuinfo.h
> +++ b/host/include/i386/host/cpuinfo.h
> @@ -14,6 +14,7 @@
>   #define CPUINFO_POPCNT          (1u << 4)
>   #define CPUINFO_BMI1            (1u << 5)
>   #define CPUINFO_BMI2            (1u << 6)
> +#define CPUINFO_SSE2            (1u << 7)
>   #define CPUINFO_AVX1            (1u << 9)
>   #define CPUINFO_AVX2            (1u << 10)
>   #define CPUINFO_AVX512F         (1u << 11)
> diff --git a/util/bufferiszero.c b/util/bufferiszero.c
> index 11c080e02cf..74864f7b782 100644
> --- a/util/bufferiszero.c
> +++ b/util/bufferiszero.c
> @@ -188,14 +188,14 @@ static biz_accel_fn const accel_table[] = {
>   
>   static unsigned best_accel(void)
>   {
> -#ifdef CONFIG_AVX2_OPT
>       unsigned info = cpuinfo_init();
>   
> +#ifdef CONFIG_AVX2_OPT
>       if (info & CPUINFO_AVX2) {
>           return 2;
>       }
>   #endif
> -    return 1;
> +    return info & CPUINFO_SSE2 ? 1 : 0;
>   }

Merge conflict with master here -- bufferiszero.c has been split.
This hunk now goes in host/include/i386/host/bufferiszero.c.inc.


r~

