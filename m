Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A9814606A32A
	for <qemu-devel@archiver.kernel.org>; Wed, 25 Nov 2026 16:27:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256 header.s=google header.b=rRG1VB8l
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xWFpv-0007i7-06; Wed, 25 Nov 2026 11:27:11 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1xWFpc-0007ZD-TX
 for qemu-devel@nongnu.org; Wed, 25 Nov 2026 11:26:57 -0500
Received: from mail-pg1-x530.google.com ([2607:f8b0:4864:20::530])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1xWFpb-0006HO-EO
 for qemu-devel@nongnu.org; Wed, 25 Nov 2026 11:26:52 -0500
Received: by mail-pg1-x530.google.com with SMTP id
 41be03b00d2f7-cd60c5da24cso3607804a12.0
 for <qemu-devel@nongnu.org>; Wed, 25 Nov 2026 08:26:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1795624010; x=1796228810; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=OknOQA8nQHnp8B0PYDh7ryFZQ6iDDsqbRZQCAUfO8es=;
 b=rRG1VB8l/FybqOkF3G19DnqcYNXw3bRS/FuUA+5/RVjHBJAKcg+K/A2q8rG9QzBPvT
 y/4FsRnEw+gxY+Xkhlk/93S8ob6oWTeNXj2/C8SZ/3M3LM23S8aAhREBlSF3KHms1VDQ
 0qmUwdzzS0PW3T7TTiVCMzyQiqasJnZ2OZfQxFUyz6KQ4Y6K4/h0rGdhDyUrn7nXeCGH
 Yybp4ZmiCbomARLYqOnwcW+70sGz0OhoSMHBeAlMBL6wPOeb/HSsexJ2gSub0HTKQFfX
 XqFdzrdn86WAzARE8oWE2k+CNWIhuJqJUqUitxjR567h683u9yB+NO2rCEo4Hq/mSqWr
 +k4g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1795624010; x=1796228810;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:to:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=OknOQA8nQHnp8B0PYDh7ryFZQ6iDDsqbRZQCAUfO8es=;
 b=ZC6P0QqJvfxEVO7AoARJEzuP1JorPP19hH7sSv3SQFuM9C7kg/xgQJpNQij5rsgrRI
 vLetOzpr7NGPinBKlA5Auy4SmTz09Pd7rfDqnWIulyJGRePgY/DRFGPH3tBv5uPLrcT9
 1U0sY9jW6kaTS16e+3vuruYUCBakXUDrypvvzDXcb9bLrU+plrXqTXMh82jFkfscha+e
 1x5Pv781nYx89Ga35MGT1WzTSgY4/G8aUwnKM/i6PddPaPZllZjdUxCYHWgdqSc+BBah
 2BaC3K6jCm+wY86/PoYSIc0idxlICSOsGCvksUTuH7l0KwrGRvuF5D4YfywSlq200Erh
 AU5g==
X-Forwarded-Encrypted: i=1;
 AL+hErFnTn6Nf9gnzjp5N7uRDnrizjzBL+0YedhyLBORoG8UNmCgqZZT+5RVJ6M6QMvA0yskpSzO8w+/vMbi@nongnu.org
X-Gm-Message-State: APuU4Z9nHQD9AkIVoX18ApoRyLEofBAq6W70fzghX3FWa7ABWHRCLSll
 A5m7LNrfgS6F1YjDperOrs1mNmT3JwInsZ7kNQz0/V2TKekG6SL+XcEOtS38Xm56r2bw8FpUU75
 E98sD
X-Gm-Gg: AZFdTZfV1Fbn5qg9h2wUG1pGy3jlra4UFTiybuxarfJPrVOQrNwuBIBYyhD/MceijC/
 SyE4l+py31nIh2JnsQd9TpxfRuimH35hEK1Sv+g/qZLRDmAQVJh8P2/sLIvqtGBcOOwFv+IuT3b
 J/8Fxg5D98NMKUp7iItB/bTGv5777YUS3y8ol+qEe3etef3YmHMVE7Z1Kc8YT/v6VpnNHiS4/C1
 PgxMXf8fxTKA1IFqAMzzq/EAV7NFGHeX0kNqr+eUFTwsloA1F/zNbHGWQ5zfUx9V9C+oi57DuGO
 GW+98635kPwPoJMxz7v0P3gaitNr0oY5bNYl/SNXKjBvUAgSaUVgw26KMWj+jRiy2DB/YcNuYh/
 jn2LK07eA1TX6LslBQILVhD2KlEOgCylAdZrl9Rqx21BPJ9OAEDqtFNKR6denm3f804KQQgG2c8
 RaOvAKqOnfynx0PCXTRHdGy139Fo57xZ1DhUb1IZw6RKhzRj3FhXxfYyP5ws/HP1PYUfDf/mcVS
 avt5T0xPykELu1y6RDhcYP/zMti+qwtydpd9vIfvSFOKwrVpNUqytULF69dt1fTTUNnWHwrLC56
 ws2AlCJR6S415gAxoFOcjCnGI53g0XQ1bUWnmivVUTA=
X-Received: by 2002:a17:90b:57cc:b0:3a8:185:cf40 with SMTP id
 98e67ed59e1d1-3b41c9b2d2emr18859090a91.10.1795624008956; 
 Wed, 25 Nov 2026 08:26:48 -0800 (PST)
Received: from [172.20.3.121] ([156.19.246.27])
 by smtp.gmail.com with ESMTPSA id
 41be03b00d2f7-cde6c9c7dcbsm9488216a12.0.2026.11.25.08.26.47
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 25 Nov 2026 08:26:48 -0800 (PST)
Message-ID: <b3f0cfe3-9c18-4834-9067-bf5780b98d96@linaro.org>
Date: Wed, 25 Nov 2026 08:26:46 -0800
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PULL 00/18] Mist target patches for 2026-11-24
To: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>,
 qemu-devel@nongnu.org
References: <20261124232722.90234-1-philmd@oss.qualcomm.com>
From: Richard Henderson <richard.henderson@linaro.org>
Content-Language: en-US
In-Reply-To: <20261124232722.90234-1-philmd@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::530;
 envelope-from=richard.henderson@linaro.org; helo=mail-pg1-x530.google.com
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
List-Id: qemu development <qemu-devel.nongnu.org>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
X-Spam-Status: No, score=-17.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PULL_REQUEST,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_PASS,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On 11/24/26 15:27, Philippe Mathieu-Daudé wrote:
> The following changes since commit 6bf90d4fc5027567cb704d7888f5ec792b4ed75a:
> 
>    Merge tag 'pull-target-arm-20261124' ofhttps://gitlab.com/pm215/qemu into staging (2026-11-24 07:09:41 -0800)
> 
> are available in the Git repository at:
> 
>    https://github.com/philmd/qemu.git tags/target-misc-20261124
> 
> for you to fetch changes up to fd25fe89996688623717b485654e26a0d7f46c62:
> 
>    target/mips: Do not sign-extend partial LWR results on Octeon (2026-11-25 00:22:48 +0100)
> 
> ----------------------------------------------------------------
> Misc fixes for 11.2
> 
> - TCG flags (M68k, PPC) & icount (ARM)
> - MIPS opcodes and exceptions

Applied, thanks.

r~

