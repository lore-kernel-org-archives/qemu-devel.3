Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6E9ADC282C5
	for <qemu-devel@archiver.kernel.org>; Mon,  3 Mar 2025 10:31:39 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tp34h-00063r-Q2; Mon, 03 Mar 2025 05:31:03 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tp34d-000631-SV
 for qemu-devel@nongnu.org; Mon, 03 Mar 2025 05:31:00 -0500
Received: from mail-wr1-x435.google.com ([2a00:1450:4864:20::435])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tp34b-0006n8-E0
 for qemu-devel@nongnu.org; Mon, 03 Mar 2025 05:30:59 -0500
Received: by mail-wr1-x435.google.com with SMTP id
 ffacd0b85a97d-390dd3403fdso3710927f8f.0
 for <qemu-devel@nongnu.org>; Mon, 03 Mar 2025 02:30:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1740997855; x=1741602655; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id:from
 :to:cc:subject:date:message-id:reply-to;
 bh=XV1RybOtjxLxbZTmijCMzJ8W1tdjocf8fQljGYEqavs=;
 b=gfokitjTlfR/Jwabni0Yb9+6B+22zXA3OoZlILKUGfsz3UmSU4yEJezfpPFP0LcH22
 eajsTffqbNDpRNX3EzMIx4ACyFA7AEOay97Po7Ro3yY36j6D2BjVQ7qMbYuaq9+7+VJt
 /fwkMrcPlFNRrGAdldyMa83QnkRN7ExnX11inbT/sCOf62wSgqosdLoDWPIO3OsMIzcm
 ltBTpw+OTKRwl7SAt4kn895xg4+ofTPEVtNymVLkO7BKGQEoQWO5sDPCdoPiCTWPgns6
 B70GravicuumrfcfCNTyrcOgKo5aHfQiS5nTPG19V3nV/9dTCy87u7BTmkomd75FcIQ6
 aNWA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1740997855; x=1741602655;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=XV1RybOtjxLxbZTmijCMzJ8W1tdjocf8fQljGYEqavs=;
 b=Vp2kJy86RzhqZ9XlFG4kSM2ewgNYM3LBqj6FjrAyg/Lt0D09nU/PWNHzTTHgMhMlrN
 gvS81//fKyKS9KD50TId9V0WHXQEUIA5p7TCo5aXbqqFyg6esLJymElhWsQVK4ByiiVz
 BgLkhkfrR0DpV1ehSeDz/sIdJKgrzK8vpyzG7OSkIBsySxL7YLgs/0C/eLZ3cSF8gUlJ
 KBlQsHBKAVt8Y29xFrhK9ZFg/11dcDWGXn7GhDV9cVySGuBtYSheRepYDmQMtAVcPpvN
 OE3CIyGptSFnaj04ra2FO+jozvn90AG3ReE5cCBawEV/EwyrdS47kL8Prs+1u9bEDGRD
 2MnQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCVC8RHPaf5GJrSSaPwnIqjOsUeZDcapmqjY5yb9sQyCwidMfWqZ6RvcaMxuHG1zRHoI0qFsgLPLW2Q6@nongnu.org
X-Gm-Message-State: AOJu0YwjYf+SR++sUxCrmJFEpUiyix/5gbVeDVbKio7sY8gHUY5ZXeAd
 DZlQuPHyDIS0gjj0WAbKqbNQ6bPMpzAz0MrXUzIkOO0d+PtXeuVwJkYOC76VsqTIL0A/xrI4RVj
 AcSYiyw==
X-Gm-Gg: ASbGncs/SgqHEbpkp1dHNtjbGXt0BReHAp0n+nHbH2BzJL++bqpTdVWRO32ovGQMWL6
 7W/NN3+ehmOzZtXPwfwBNYmZkK7DO4zsSrNS0RYLtCanNwZhFqG4k+6rfVTQhSC4OPMr+6IHbCM
 dvIegiHgOQD+j0AMtbelR6uvfoRQA5BPZL9ou+yaT01AFh6flqsb902stQqaOTx58/BAuyosf4G
 C2/KKK+hLJG+1c/NomMkSAPlEPhzwQ4QDl9tdlxOpqo9nQjVz8+exwA2yvzoyD0Jp3kn0/xQi+G
 zgSmIrB2D56VMa7aZO3nAZNUVdep7+rajaNxQJrkiowQMruKFXaz4J9YknVtivuRqT5jfxg9YAb
 EBgxN7BhFFiQi
X-Google-Smtp-Source: AGHT+IFfwUKF5Vyur2NrIN9PNDhGStSqdbz002BTrH9OCfn4SpIxHe34Z4wPeWcH0c01r8kWqBrEIg==
X-Received: by 2002:a5d:6d0d:0:b0:38f:4f64:8a22 with SMTP id
 ffacd0b85a97d-390eca807b3mr10672841f8f.52.1740997855124; 
 Mon, 03 Mar 2025 02:30:55 -0800 (PST)
Received: from [192.168.69.199] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-390e47b6f22sm13784651f8f.47.2025.03.03.02.30.54
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 03 Mar 2025 02:30:54 -0800 (PST)
Message-ID: <d8e06d97-a65a-4278-aebc-360d4332a7ea@linaro.org>
Date: Mon, 3 Mar 2025 11:30:53 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 038/162] tcg: Convert mulsh to TCGOutOpBinary
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
References: <20250216231012.2808572-1-richard.henderson@linaro.org>
 <20250216231012.2808572-39-richard.henderson@linaro.org>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20250216231012.2808572-39-richard.henderson@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::435;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x435.google.com
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

On 17/2/25 00:08, Richard Henderson wrote:
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>   tcg/aarch64/tcg-target-has.h     |  2 --
>   tcg/arm/tcg-target-has.h         |  1 -
>   tcg/i386/tcg-target-has.h        |  2 --
>   tcg/loongarch64/tcg-target-has.h |  2 --
>   tcg/mips/tcg-target-has.h        |  2 --
>   tcg/ppc/tcg-target-has.h         |  2 --
>   tcg/riscv/tcg-target-has.h       |  2 --
>   tcg/s390x/tcg-target-has.h       |  2 --
>   tcg/sparc64/tcg-target-has.h     |  2 --
>   tcg/tcg-has.h                    |  1 -
>   tcg/tci/tcg-target-has.h         |  2 --
>   tcg/tcg-op.c                     |  4 ++--
>   tcg/tcg.c                        |  8 +++----
>   tcg/aarch64/tcg-target.c.inc     | 17 ++++++++++-----
>   tcg/arm/tcg-target.c.inc         |  4 ++++
>   tcg/i386/tcg-target.c.inc        |  4 ++++
>   tcg/loongarch64/tcg-target.c.inc | 24 +++++++++++++--------
>   tcg/mips/tcg-target.c.inc        | 37 ++++++++++++++++++--------------
>   tcg/ppc/tcg-target.c.inc         | 21 ++++++++++--------
>   tcg/riscv/tcg-target.c.inc       | 19 ++++++++++------
>   tcg/s390x/tcg-target.c.inc       |  4 ++++
>   tcg/sparc64/tcg-target.c.inc     |  4 ++++
>   tcg/tci/tcg-target.c.inc         |  4 ++++
>   23 files changed, 98 insertions(+), 72 deletions(-)


> diff --git a/tcg/mips/tcg-target.c.inc b/tcg/mips/tcg-target.c.inc
> index ad62d877c7..08d98f49f7 100644
> --- a/tcg/mips/tcg-target.c.inc
> +++ b/tcg/mips/tcg-target.c.inc
> @@ -1743,6 +1743,27 @@ static const TCGOutOpBinary outop_mul = {
>       .out_rrr = tgen_mul,
>   };
>   
> +static void tgen_mulsh(TCGContext *s, TCGType type,
> +                       TCGReg a0, TCGReg a1, TCGReg a2)
> +{

Maybe for style consistency:

        MIPSInsn insn;

> +    if (use_mips32r6_instructions) {

            insn = type == TCG_TYPE_I32 ? OPC_MUH : OPC_DMUH;

> +        if (type == TCG_TYPE_I32) {
> +            tcg_out_opc_reg(s, OPC_MUH, a0, a1, a2);
> +        } else {
> +            tcg_out_opc_reg(s, OPC_DMUH, a0, a1, a2);
> +        }
> +    } else {
> +        MIPSInsn insn = type == TCG_TYPE_I32 ? OPC_MULT : OPC_DMULT;
> +        tcg_out_opc_reg(s, insn, 0, a1, a2);
> +        tcg_out_opc_reg(s, OPC_MFHI, a0, 0, 0);
> +    }
> +}

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>


