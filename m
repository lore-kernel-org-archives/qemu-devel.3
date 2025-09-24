Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BE5CCCAC5A5
	for <qemu-devel@archiver.kernel.org>; Wed, 24 Sep 2025 17:25:05 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v1TDf-0002Jw-Cg; Wed, 24 Sep 2025 13:23:57 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1v1TDK-0002GR-PG
 for qemu-devel@nongnu.org; Wed, 24 Sep 2025 13:23:35 -0400
Received: from mail-pf1-x431.google.com ([2607:f8b0:4864:20::431])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1v1TDA-0004Bv-3T
 for qemu-devel@nongnu.org; Wed, 24 Sep 2025 13:23:32 -0400
Received: by mail-pf1-x431.google.com with SMTP id
 d2e1a72fcca58-77c1814ca1dso66630b3a.2
 for <qemu-devel@nongnu.org>; Wed, 24 Sep 2025 10:23:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1758734595; x=1759339395; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=6Dq6Xwl8YOCeC0be8dOHmRUv6kYXbfLrlBskyxIcfBA=;
 b=kquz9EqRIXbBMMxZ1Yc1wJ+RDKN+g//0xuLxAPDQnq73CEFI2tPZe4w8B4xbapkpRi
 qaSV3ZtKqVa9LTiuaZ/2cYxKRzZ5Bp+XF2x15Tu131KA7MM+BGjpJc8rSxfF7n7Ioo8+
 l4k4JQmw62iwKlrVt/rwxDnFoBqoTlFYQBMVNR+t9WcUpxsgInTutWxBolnBrROAITGK
 0qJPeUbXQgu6oGvk5At291y3+CPgJuUyMx8BI+4RVlwM7JfFnhvy8s36pGXwVGvhqD0V
 2KmYGxDmIL7/lRlQ4xuNYN2d/iBVKZa5A/mXxLrTY18yJspYomRJ6YBla80RchEjOVjT
 q2vg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1758734595; x=1759339395;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=6Dq6Xwl8YOCeC0be8dOHmRUv6kYXbfLrlBskyxIcfBA=;
 b=dU/x0FkntiNauF1ZXZsB8+1DDeDbisUMrZaoV5BUYSXZKOruJDWmZjXaRKYXoHk+07
 70I96JRCib+Snv1XDW3Ll3jDkoK11lNA6rGj6lzgeDjqagP9VMiYB3PPcum57HUiBZPG
 Ptjj+NQPo6SJekpX4mlhC1Kiy196EZ2f3Xzrgeb6anNPn6pBdL4em3fg50uZCVtFDohU
 5JLXbUflYchGIfvvR8mGMRwvEZ6K9APvxFXy9Ucj2NZjGybwtkVv4DmwAv/mEuZG0/Co
 grrijU7nGWGEjtIYxlSHmsg9m/X94E22SUPshRTj+PmQt1qIzCqTaQ5pTkrtdm0nUkRc
 WPCg==
X-Forwarded-Encrypted: i=1;
 AJvYcCXc0nmP0FlHmnTyPHVRAUS/SxSgXuxXMpXlpYMwTyjgStZ+TYiRkHmz+W8roYC0neWHZn+TxQ9AB3TV@nongnu.org
X-Gm-Message-State: AOJu0YywGst/CxdlOYOrrv3PGs8mHblIHy4X34rHMvMC4Y8SpsNVB1cB
 8otD/i7gbOO1KlxFkfb5G1/RkwuZsYDvdJ8QJfJ71My2bc/yWy6YiesIx3xXitK9DlRxa4tnkdw
 cv2uY
X-Gm-Gg: ASbGncsraPhcVF1Eup/fKiCWLutW5aYLS+Mj93ZIfrQD+93PhTF3knkCcAulPUoCWO8
 3NE78wB8O72jUwOH1CJDfwF6P1R1Noj7P8ByS/X41MpIZIBHSnIwTNK/AtDjjuvamqBqfcaUPr9
 D5CnXEenWiEgZvPd9D899bSuOkPRyqLgfZTu9/gxb9pSFYKnmmhocEv8GRqEir+YsTN5msFuCvF
 9DQgNYWXrbaPN6dgiC6eVOwNIokIm6DRTxbjYF7P0lPUBuqCaS4fUGMpnmCi/7DvJDDGqXjs61Y
 ZaNAMNBziez70ohR2UqBabnssx82UcFEg5CTkY4kNVqgUxjL1dfg4qNWqFj8R2scI13n/tLDn6r
 k+1le1g0GM9AkpbOQWhLAi4tu8MHpvRmK+kYl
X-Google-Smtp-Source: AGHT+IGoYiHhdS84dwDbj5wE3VIRmByJa2Ore2DqvOiVYL45KU4FhhF/KIYSkoOpeF/b+t7jhRFIwA==
X-Received: by 2002:a05:6a00:2350:b0:77f:7d98:9571 with SMTP id
 d2e1a72fcca58-780fce2cc9fmr751774b3a.14.1758734595177; 
 Wed, 24 Sep 2025 10:23:15 -0700 (PDT)
Received: from [192.168.0.4] ([71.212.157.132])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-77cfbb7ab97sm19315461b3a.14.2025.09.24.10.23.14
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 24 Sep 2025 10:23:14 -0700 (PDT)
Message-ID: <2923c909-6170-4603-a70d-bbbc583a68fb@linaro.org>
Date: Wed, 24 Sep 2025 10:23:13 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] accel/tcg: Remove cpu_loop_exit_restore() stub
To: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>
References: <20250924165039.52250-1-philmd@linaro.org>
From: Richard Henderson <richard.henderson@linaro.org>
Content-Language: en-US
In-Reply-To: <20250924165039.52250-1-philmd@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::431;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x431.google.com
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

On 9/24/25 09:50, Philippe Mathieu-Daudé wrote:
> Not needed since commit 63e7af20352 ("hw/mips: Restrict ITU to TCG").
> 
> Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
> ---
>   include/exec/cpu-common.h | 2 +-
>   accel/stubs/tcg-stub.c    | 5 -----
>   2 files changed, 1 insertion(+), 6 deletions(-)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

And queued.

r~

> 
> diff --git a/include/exec/cpu-common.h b/include/exec/cpu-common.h
> index 9b658a3f48f..f373781ae07 100644
> --- a/include/exec/cpu-common.h
> +++ b/include/exec/cpu-common.h
> @@ -221,9 +221,9 @@ static inline bool cpu_loop_exit_requested(CPUState *cpu)
>   
>   G_NORETURN void cpu_loop_exit_noexc(CPUState *cpu);
>   G_NORETURN void cpu_loop_exit_atomic(CPUState *cpu, uintptr_t pc);
> +G_NORETURN void cpu_loop_exit_restore(CPUState *cpu, uintptr_t pc);
>   #endif /* CONFIG_TCG */
>   G_NORETURN void cpu_loop_exit(CPUState *cpu);
> -G_NORETURN void cpu_loop_exit_restore(CPUState *cpu, uintptr_t pc);
>   
>   /* accel/tcg/cpu-exec.c */
>   int cpu_exec(CPUState *cpu);
> diff --git a/accel/stubs/tcg-stub.c b/accel/stubs/tcg-stub.c
> index 3b76b8b17c1..77055e39644 100644
> --- a/accel/stubs/tcg-stub.c
> +++ b/accel/stubs/tcg-stub.c
> @@ -17,8 +17,3 @@ G_NORETURN void cpu_loop_exit(CPUState *cpu)
>   {
>       g_assert_not_reached();
>   }
> -
> -G_NORETURN void cpu_loop_exit_restore(CPUState *cpu, uintptr_t pc)
> -{
> -    g_assert_not_reached();
> -}


