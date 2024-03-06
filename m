Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 592C0C5475B
	for <qemu-devel@archiver.kernel.org>; Wed,  6 Mar 2024 12:51:20 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rhqiz-00046M-NN; Wed, 06 Mar 2024 07:50:21 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dbarboza@ventanamicro.com>)
 id 1rhqiy-00045A-AR
 for qemu-devel@nongnu.org; Wed, 06 Mar 2024 07:50:20 -0500
Received: from mail-pf1-x42e.google.com ([2607:f8b0:4864:20::42e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <dbarboza@ventanamicro.com>)
 id 1rhqiw-0000bO-CQ
 for qemu-devel@nongnu.org; Wed, 06 Mar 2024 07:50:19 -0500
Received: by mail-pf1-x42e.google.com with SMTP id
 d2e1a72fcca58-6e5a232fe80so611920b3a.0
 for <qemu-devel@nongnu.org>; Wed, 06 Mar 2024 04:50:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=ventanamicro.com; s=google; t=1709729417; x=1710334217; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=vN52UaDpk5D7vKtAoIgf9PA/6BlBQMxCYSVnVaLx1dw=;
 b=Zxae4pkOahMQYdnld161ID+XxU73lWgH9NSEGiBHcSj1zIc/4PNsLxBg32GU3rBU6o
 8hxbU962JHUgwtqKcLksLzCR/dV7sT4OFPkVQXYofRgd1auh8Wvs6w3iAE4Y+E/m69vZ
 WSerHBrqibmvNCfn3e1IDefmDT/1J3MfTn0oA2sAtxBiqg2Fk53Jj1xHkdfqpFr20xhJ
 6sh4t56XH5CzboDyWJf1Powra6gPv+XyXr7Iep0tlqBr7b+mYU40Q0ZhJW1bPg1HJIMV
 aec69bLEONU1hMQ5fAJvQN6Yh26X3bwhq+9e9fVxzrn6cTr+1ER1LKGqenoF/KJCedx8
 IRyg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1709729417; x=1710334217;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=vN52UaDpk5D7vKtAoIgf9PA/6BlBQMxCYSVnVaLx1dw=;
 b=C6NlN3CB73NkKNrnOMyC1H2RrK5mL6AdgZgMqVshGG4YNcanGChyrIVxzgDVFPinz2
 DxvFoRmW01uIQU8ivI//USBII+AfHxZ+tUBBMwHBhCFt4nUWMs3KI1e4K/7PSSWbnjC4
 /UVSEdBsy+KfUzEYx/9cni888D5ywekrLqTLHWel54LC7XKhvC2XjO4gUxQi3uTRt0dJ
 jggGAdzCo9iGKyFJz7P9HWrBfGKka4rptw0enkqnXQGzfihMppfpHWuC9pkz37s3/4Iw
 IY1LfmVE7hechW6Wi4LQSmODlwibFqWrDf3hnLapwN6iZHLQjUz3/5fKr616n5pQodiJ
 n9Pg==
X-Forwarded-Encrypted: i=1;
 AJvYcCV8aZpBkhT1cAnZPE/v2N2jrwgMXV3WMWGt5YTjj9KYLUXKgSIcjlZujgVl6uAf339yvQX1ZLE68p04cES6/ZEdeWTR1mw=
X-Gm-Message-State: AOJu0YxUv4iBr404LlQBwuZqvCNxVHMVSd5VY0y5K8z3Wpz3lD3anHE2
 wGTs4H5Mb7dyC7wFtNpcYDIObYHgezup4Vu5h/nsTHF3mj7cKsKFnAD+aHze/R8=
X-Google-Smtp-Source: AGHT+IEQcYg68Qze1b6fmlEwHVOjH6XGTUMEzgnnOuOd0pL+HEDtAB/zaOeGXuvdRuzTLxpjMXiMWA==
X-Received: by 2002:a05:6a00:1821:b0:6e4:908c:613b with SMTP id
 y33-20020a056a00182100b006e4908c613bmr8024469pfa.8.1709729416599; 
 Wed, 06 Mar 2024 04:50:16 -0800 (PST)
Received: from [192.168.68.110] ([177.94.15.159])
 by smtp.gmail.com with ESMTPSA id
 r16-20020a62e410000000b006e46047fe04sm10706966pfh.204.2024.03.06.04.50.13
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 06 Mar 2024 04:50:16 -0800 (PST)
Message-ID: <7c39bea9-c57b-410b-b63a-ea7eb7440ac8@ventanamicro.com>
Date: Wed, 6 Mar 2024 09:50:11 -0300
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/2] hw/intc/riscv_aplic: Fix setipnum_le write emulation
 for APLIC MSI-mode
Content-Language: en-US
To: Anup Patel <apatel@ventanamicro.com>,
 Peter Maydell <peter.maydell@linaro.org>, Palmer Dabbelt
 <palmer@dabbelt.com>, Alistair Francis <Alistair.Francis@wdc.com>,
 Sagar Karandikar <sagark@eecs.berkeley.edu>
Cc: Richard Henderson <richard.henderson@linaro.org>,
 Atish Patra <atishp@atishpatra.org>, Anup Patel <anup@brainfault.org>,
 qemu-riscv@nongnu.org, qemu-devel@nongnu.org
References: <20240306095722.463296-1-apatel@ventanamicro.com>
 <20240306095722.463296-2-apatel@ventanamicro.com>
From: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
In-Reply-To: <20240306095722.463296-2-apatel@ventanamicro.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::42e;
 envelope-from=dbarboza@ventanamicro.com; helo=mail-pf1-x42e.google.com
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



On 3/6/24 06:57, Anup Patel wrote:
> The writes to setipnum_le register in APLIC MSI-mode have special
> consideration for level-triggered interrupts as-per section "4.9.2
> Special consideration for level-sensitive interrupt sources" of the
> RISC-V AIA specification.
> 
> Particularly, the below text from the RISC-V specification defines
> the behaviour of writes to setipnum_le for level-triggered interrupts:
> 
> "A second option is for the interrupt service routine to write the
> APLIC’s source identity number for the interrupt to the domain’s
> setipnum register just before exiting. This will cause the interrupt’s
> pending bit to be set to one again if the source is still asserting
> an interrupt, but not if the source is not asserting an interrupt."
> 
> Fix setipnum_le write emulation for APLIC MSI-mode by implementing
> the above behaviour in riscv_aplic_set_pending() function.
> 
> Fixes: e8f79343cfc8 ("hw/intc: Add RISC-V AIA APLIC device emulation")
> Signed-off-by: Anup Patel <apatel@ventanamicro.com>
> ---


Reviewed-by: Daniel Henrique Barboza <dbarboza@ventanamicro.com>

>   hw/intc/riscv_aplic.c | 20 ++++++++++++++++----
>   1 file changed, 16 insertions(+), 4 deletions(-)
> 
> diff --git a/hw/intc/riscv_aplic.c b/hw/intc/riscv_aplic.c
> index e98e258deb..775bb96164 100644
> --- a/hw/intc/riscv_aplic.c
> +++ b/hw/intc/riscv_aplic.c
> @@ -218,13 +218,25 @@ static void riscv_aplic_set_pending(RISCVAPLICState *aplic,
>       }
>   
>       sm = sourcecfg & APLIC_SOURCECFG_SM_MASK;
> -    if ((sm == APLIC_SOURCECFG_SM_INACTIVE) ||
> -        ((!aplic->msimode || (aplic->msimode && !pending)) &&
> -         ((sm == APLIC_SOURCECFG_SM_LEVEL_HIGH) ||
> -          (sm == APLIC_SOURCECFG_SM_LEVEL_LOW)))) {
> +    if (sm == APLIC_SOURCECFG_SM_INACTIVE) {
>           return;
>       }
>   
> +    if ((sm == APLIC_SOURCECFG_SM_LEVEL_HIGH) ||
> +        (sm == APLIC_SOURCECFG_SM_LEVEL_LOW)) {
> +        if (!aplic->msimode || (aplic->msimode && !pending)) {
> +            return;
> +        }
> +        if ((aplic->state[irq] & APLIC_ISTATE_INPUT) &&
> +            (sm == APLIC_SOURCECFG_SM_LEVEL_LOW)) {
> +            return;
> +        }
> +        if (!(aplic->state[irq] & APLIC_ISTATE_INPUT) &&
> +            (sm == APLIC_SOURCECFG_SM_LEVEL_HIGH)) {
> +            return;
> +        }
> +    }
> +
>       riscv_aplic_set_pending_raw(aplic, irq, pending);
>   }
>   

