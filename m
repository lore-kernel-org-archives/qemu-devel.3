Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EF416C46CD2
	for <qemu-devel@archiver.kernel.org>; Sat, 27 Jan 2024 05:02:16 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rTaoq-0003jF-Cm; Sat, 27 Jan 2024 00:01:28 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1rTaol-0003Xr-My
 for qemu-devel@nongnu.org; Sat, 27 Jan 2024 00:01:23 -0500
Received: from mail-pg1-x533.google.com ([2607:f8b0:4864:20::533])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1rTaok-0003CZ-3b
 for qemu-devel@nongnu.org; Sat, 27 Jan 2024 00:01:23 -0500
Received: by mail-pg1-x533.google.com with SMTP id
 41be03b00d2f7-5bdbe2de25fso959247a12.3
 for <qemu-devel@nongnu.org>; Fri, 26 Jan 2024 21:01:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1706331680; x=1706936480; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=2mS+gkomBPghq9G8NO+j+fgiIModnyVymVv2YIh5hQ4=;
 b=LvLhQG8bC/MyF/AnH20NMl83Anola0X4uot9uPji8cnXiq3FAOYqu6EC8U+Ps3tcAk
 ADeQZw+tX82MKwcmF5/JFhHNSS+W6q+wZDOJ2eR/DQfyNALGyw2OjJ3ZH2lCZ1/iXho6
 a093Rnwu8dCL74I2T0PR7ghi6ldigObxOWVWrUXqzr5S4F12QvLFD1H21eZE4K9L3BAb
 LG0/jg8UANyMm7289OyvDm0x08jFbA1b8AfYdpB6g6vw7ASzcfQUkxob2+C3Vwwsf/lX
 WLS8IV3j3jbYKfOaGQdb1x8PNZKuxbW61iujOt9cVG1Smsr+Ri5jxOPmQQNhkZEiwP8b
 uPYg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1706331680; x=1706936480;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=2mS+gkomBPghq9G8NO+j+fgiIModnyVymVv2YIh5hQ4=;
 b=Cbb/fGdTqoEB+rSEVoPGKMVzvTMW069V41PX6W6FtmfTH7C8hItAot/8K/ffsplV/u
 S7tnv2nJrqqUujdwHiwFHT0b2J1DpqBNeJdLGzlbH8iAMlk49XNX6NiJDy/foStEpH8G
 Xnd4UJElyd0QmF1zKQuTpBXfGweFEYB/YwdCBRCvaTpCH9XoE85jbUUgxg4qKEy4k+iU
 xVvc14EQw0mjkFVL1Bc+ia8wi89cgIRmsWfxmMnIu/u3k8v1ovMNaxbawFJyfVIX7I67
 +nAzFQNeuFrZPLI2DXAHluiR12n7PV9FTllanoO2OeKbXcukdgj8l52MVA7FP82bXpqK
 BVAA==
X-Gm-Message-State: AOJu0YwTo/gCWmAj++X2zYaFT/coDVdZ007i53hKpjT2WBWspg06ycLZ
 eueMTUGgQav2M2y9lucnym15FqcrD/uY9eE25LDxeWSYrL21SbW9QpmjMS7nQcM=
X-Google-Smtp-Source: AGHT+IG8Jn3Pnx1V9rdUSjpZ5NoTZhC1MnhYDoK8xqJBMgaSoiuz0ArUUBYJa1IFVPuZrYVzTz/JLA==
X-Received: by 2002:a05:6a20:7da7:b0:19b:7d64:7d93 with SMTP id
 v39-20020a056a207da700b0019b7d647d93mr1260431pzj.61.1706331680186; 
 Fri, 26 Jan 2024 21:01:20 -0800 (PST)
Received: from ?IPV6:2001:8003:c96c:3c00:b5dc:ba0f:990f:fb9e?
 ([2001:8003:c96c:3c00:b5dc:ba0f:990f:fb9e])
 by smtp.gmail.com with ESMTPSA id
 su16-20020a17090b535000b00293851b198csm2004694pjb.56.2024.01.26.21.01.18
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 26 Jan 2024 21:01:19 -0800 (PST)
Message-ID: <bdad581f-546d-4aa0-a93d-9110db5fef84@linaro.org>
Date: Sat, 27 Jan 2024 15:01:15 +1000
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 02/23] scripts/coccinelle: Add cpu_env.cocci_template
 script
Content-Language: en-US
To: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>
References: <20240126220407.95022-1-philmd@linaro.org>
 <20240126220407.95022-3-philmd@linaro.org>
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20240126220407.95022-3-philmd@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::533;
 envelope-from=richard.henderson@linaro.org; helo=mail-pg1-x533.google.com
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

On 1/27/24 08:03, Philippe Mathieu-Daudé wrote:
> Add a Coccinelle script to convert the following slow path
> (due to the QOM cast macro):
> 
>    &ARCH_CPU(..)->env
> 
> to the following fast path:
> 
>    cpu_env(..)
> 
> Signed-off-by: Philippe Mathieu-Daudé<philmd@linaro.org>
> ---
>   MAINTAINERS                               |  1 +
>   scripts/coccinelle/cpu_env.cocci_template | 92 +++++++++++++++++++++++
>   2 files changed, 93 insertions(+)
>   create mode 100644 scripts/coccinelle/cpu_env.cocci_template

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>


> +/* Both first_cpu/current_cpu are CPUState* */
> +@@
> +symbol first_cpu;
> +symbol current_cpu;
> +@@
> +(
> +-    CPU(first_cpu)
> ++    first_cpu
> +|
> +-    CPU(current_cpu)
> ++    current_cpu
> +)

I think part of Paolo's query is if there are any new instances of

commit 96449e4a30a56e3303d6d0407aca130c71671754
Author: Philippe Mathieu-Daudé <philmd@linaro.org>
Date:   Tue May 12 09:00:18 2020 +0200

     target: Remove unnecessary CPU() cast
...
       @@
       typedef CPUState;
       CPUState *s;
       @@
       -   CPU(s)
       +   s


r~

