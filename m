Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A3DF3C54E58
	for <qemu-devel@archiver.kernel.org>; Fri, 15 Mar 2024 21:29:49 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rlF7A-0000z4-MO; Fri, 15 Mar 2024 17:29:20 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1rlF74-0000xJ-Vd
 for qemu-devel@nongnu.org; Fri, 15 Mar 2024 17:29:15 -0400
Received: from mail-pf1-x429.google.com ([2607:f8b0:4864:20::429])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1rlF72-00062p-R9
 for qemu-devel@nongnu.org; Fri, 15 Mar 2024 17:29:14 -0400
Received: by mail-pf1-x429.google.com with SMTP id
 d2e1a72fcca58-6e6082eab17so2347003b3a.1
 for <qemu-devel@nongnu.org>; Fri, 15 Mar 2024 14:29:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1710538151; x=1711142951; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=PHlXGhlJbUlZATbLsXMoxAgW9JAsVtI8n+jSvPJLsKU=;
 b=M5rWc9guTljAVilhzjsFwCahW5KSJ3AvSDZe5R7O5CuSFaE6IrBUzEQhfT8AL21Znv
 pGc8BjDQOiPxydNfG93KyxNcUft9Liif4qFw7K0auPsSNtMXLp1++ny73sb+StWc/bP/
 xJb1ki7sBleQPjzpX/UZiYGauiQNsVtFV4mKwyBnTIch8mIVQIWGzxZgMWGSSNWhDCe4
 WXyPYsZGDxlCQE6AqCBwSoPCLJUQhPuWoZCk7yQA8h+Mh7ffR5My7svd/TAa2VQ2f4ix
 9EmHKCyAd6xW7wHEm9vQpAEwg5qPq1tSDDXzK/U7vQT9zkrhXGe7wxBcOylKols2wpp5
 Q9eg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1710538151; x=1711142951;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=PHlXGhlJbUlZATbLsXMoxAgW9JAsVtI8n+jSvPJLsKU=;
 b=mnLKdog+WGuFuhjVDyFFLUzIKB22hLOWx/oJWmNojygibgBlKQMt9ZXnN9M6QyzAy2
 wFVVQCzuw0RzQC5UsNaEggjYXfk0bJRXa9ZPRepTiYd+4/rKmFEsap/bvnFpqS+KD0QV
 0eo7x0Kfy6l/H6n8l9fWlFlf3FI85mERWhKbvSSS4es3BcH4PMpPhD6tCfKV8kDP9cVt
 hRIOelyg8oRk9PVMNwcmRhgURbYlw0e7AIe7BsFnRRkHyl/eCyI9hdF2lZ7wmHrGb5xn
 QTZvUiCLNssjECD0oenw/HhJ7vLwhYeiNCjR7bEszUCMx9gzBCSl8TpWVpAXkttAEhIZ
 h1SQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCWqJf+XYH3qY1f+wf9kF4o02GQGpl1dTg+qzbW9TO9/0FO0YSA2ag4ScO9/bduxLsystauIGCnCxpRHDp2qfKLdOgWwdCs=
X-Gm-Message-State: AOJu0Yz6V2fHYvf0LY/tMg8C+LweG9SWyJyMl134zZE3HWSQmMBHsBzS
 DtLiK918xVApRM6R6Y4UA7Uyc3D0ohMoiKAGa1fgVkOTXpBmEGjUGfdl0eSWp+w=
X-Google-Smtp-Source: AGHT+IH2cre5Yk7pdjUbtaUfxNZ/ztBSsat+WSbv/Ml000S4tZN8JEY3CX4rn9dbIcYi5H30x7RhTw==
X-Received: by 2002:a05:6a20:12c9:b0:1a1:4d0c:7de2 with SMTP id
 v9-20020a056a2012c900b001a14d0c7de2mr6649512pzg.56.1710538150780; 
 Fri, 15 Mar 2024 14:29:10 -0700 (PDT)
Received: from [172.20.1.19] (173-197-098-125.biz.spectrum.com.
 [173.197.98.125]) by smtp.gmail.com with ESMTPSA id
 o14-20020a63fb0e000000b005cfc1015befsm2951730pgh.89.2024.03.15.14.29.09
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 15 Mar 2024 14:29:10 -0700 (PDT)
Message-ID: <3e43eb36-b240-4446-b56f-9f155176788c@linaro.org>
Date: Fri, 15 Mar 2024 11:29:05 -1000
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH-for-9.1 10/12] exec/cpu-defs: Restrict SOFTMMU specific
 definitions to accel/tcg/
Content-Language: en-US
To: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 qemu-devel@nongnu.org
Cc: =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>, Thomas Huth <thuth@redhat.com>,
 qemu-ppc@nongnu.org
References: <20240313213339.82071-1-philmd@linaro.org>
 <20240313213339.82071-11-philmd@linaro.org>
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20240313213339.82071-11-philmd@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::429;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x429.google.com
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

On 3/13/24 11:33, Philippe Mathieu-Daudé wrote:
> CPU_TLB_foo definitions are specific to SoftMMU and
> only used in accel/tcg/.
> 
> Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
> ---
>   accel/tcg/internal-target.h | 26 ++++++++++++++++++++++++++
>   include/exec/cpu-defs.h     | 26 --------------------------
>   2 files changed, 26 insertions(+), 26 deletions(-)
> 
> diff --git a/accel/tcg/internal-target.h b/accel/tcg/internal-target.h
> index b22b29c461..9b5cc9168b 100644
> --- a/accel/tcg/internal-target.h
> +++ b/accel/tcg/internal-target.h
> @@ -12,6 +12,32 @@
>   #include "exec/exec-all.h"
>   #include "exec/translate-all.h"
>   
> +#if defined(CONFIG_SOFTMMU) && defined(CONFIG_TCG)

I see this is moved intact, but drop the CONFIG_TCG ifdef within accel/tcg/.
With that change,

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

r~

