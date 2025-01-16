Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 08073C02180
	for <qemu-devel@archiver.kernel.org>; Thu, 16 Jan 2025 13:31:32 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tYPwx-0003ah-4s; Thu, 16 Jan 2025 08:30:19 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dbarboza@ventanamicro.com>)
 id 1tYPwv-0003Zt-HI
 for qemu-devel@nongnu.org; Thu, 16 Jan 2025 08:30:17 -0500
Received: from mail-ot1-x332.google.com ([2607:f8b0:4864:20::332])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <dbarboza@ventanamicro.com>)
 id 1tYPwt-0008M4-4C
 for qemu-devel@nongnu.org; Thu, 16 Jan 2025 08:30:17 -0500
Received: by mail-ot1-x332.google.com with SMTP id
 46e09a7af769-71e565708beso498136a34.1
 for <qemu-devel@nongnu.org>; Thu, 16 Jan 2025 05:30:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=ventanamicro.com; s=google; t=1737034214; x=1737639014; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=bHxBa2xfZvbihfAA6QyeR46fsyRPSN5Ld2JlW25a7Mw=;
 b=FxEJNTCp7T9YKsHrZjbNxt7zDEkxCFt1amKyjrXjbAeyW+DDFc26oljflU0XoEkRqN
 c9fzuYFHm4B0vFfXQQhDPuP+sPNdPEOlO+zhJ39NPflvhUSjZKoDcIfpoeFTH2dmS5WM
 W+P8+JHSA8zReHVq61e7fP0Y2FLGnUHYzseE95C6TkPdc5fyY6NRRAsWxBJqNzDch4Ka
 5KEmDwY+e4Ta8bOZDEyvFCK41HMj/BAia7LIhTA7QJAO/ek7FkgPW4A/SWCsxCFR3q/Z
 3TovKNoznwoRVgpjb+XMVF0mrB/P0kO9VakYx9TFnoAEofGBQ8qDF7i6EeonDMVaEgoV
 HrYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1737034214; x=1737639014;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=bHxBa2xfZvbihfAA6QyeR46fsyRPSN5Ld2JlW25a7Mw=;
 b=E3j5NZ4dkj8rEreUmgTNpX6kRkm6N9WhlSMUDfOgYeDL0kJGtZVlUNXdAf+NtFCSOc
 PilxEHToLNJyDX0gsNWsRAaP6QsvwYHuf2/UQsUHZ2I71FFvSU+gdjMH1bjxMtZL2DYg
 0UsxjZQKrwlNXQQO+3fdFaVhq9+KfgNE1vs4X+gPZhNQ2mV6hsDz0lxk6guKe979f3im
 UFOdsemTi8dhohVV9uYKMwct8cNJmsPwXEsIc1zNiiTy/+s70XI3JiNN/x6f5BozcJ8y
 OON32TfnYL0PWew0jZwWQdjQyBitjkf+iQu+uI2KNHL6SL6qmoRREgaHD/93KWyaR/3S
 6k7g==
X-Forwarded-Encrypted: i=1;
 AJvYcCW333egAV5jjmNW5sHg+fDfFxrpS7qglBt80yvztwgR2H7hZinH0TMRTZAlWh6HIKv4b0X33cSJkMjK@nongnu.org
X-Gm-Message-State: AOJu0Yz8AbtsOWPPJ1BipVbegwHEnU9tSnewxwwjXcLdnTNPhEKxBGdd
 zEclxQpVFE/6SWMeBpdn27clIep8WTDw01wmGnjLmSV/VgcBoPn+bBI6n77DTQI=
X-Gm-Gg: ASbGncu9be8r/geRCfyvmMneq/+zX66YL842vn3C92jdqanHIkU3jtWltVB/vSdZUEt
 WY5rv1B+KUGA7g5cHY0z4abQa6PkbzcuPwjt9cHuTh+cmrfLfmgV2WJxbnF2SIZjGFcUzgUktUz
 yIPrON0ki48uxbgnNuZhA3CQe5XgSpOpOUuKGq7I8f2dhwWKWE+0S9RV7X1Jc59TV0P2mjfcTFi
 fomPMNsyZyJixzO8SKFku2dUFHQlCEAfE/t1uEJ5hvSyfZ+3dp9tI7DD/94bAy5Pq5lPao=
X-Google-Smtp-Source: AGHT+IHWa8/mP2xE6AtrUquPL6sIveL9paRPolcaO+IUC3OgxT0sqPC6cQDqtFmwnANNESSNGPvV4w==
X-Received: by 2002:a05:6830:4989:b0:718:ab4:8b70 with SMTP id
 46e09a7af769-721e2eff7eamr21568785a34.22.1737034213721; 
 Thu, 16 Jan 2025 05:30:13 -0800 (PST)
Received: from [192.168.68.110] ([191.202.238.10])
 by smtp.gmail.com with ESMTPSA id
 006d021491bc7-5f882624fa3sm5982128eaf.6.2025.01.16.05.30.09
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 16 Jan 2025 05:30:12 -0800 (PST)
Message-ID: <7d3df2ef-14b0-47ad-a843-668f146e26de@ventanamicro.com>
Date: Thu, 16 Jan 2025 10:30:07 -0300
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v9] target/riscv: Add Smdbltrp ISA extension enable switch
To: =?UTF-8?B?Q2zDqW1lbnQgTMOpZ2Vy?= <cleger@rivosinc.com>,
 qemu-riscv@nongnu.org, Palmer Dabbelt <palmer@dabbelt.com>,
 Alistair Francis <alistair.francis@wdc.com>,
 Bin Meng <bin.meng@windriver.com>
Cc: Ved Shanbhogue <ved@rivosinc.com>, Atish Patra <atishp@rivosinc.com>,
 qemu-devel@nongnu.org
References: <20250116131539.2475785-1-cleger@rivosinc.com>
Content-Language: en-US
From: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
In-Reply-To: <20250116131539.2475785-1-cleger@rivosinc.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::332;
 envelope-from=dbarboza@ventanamicro.com; helo=mail-ot1-x332.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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



On 1/16/25 10:15 AM, Clément Léger wrote:
> Add the switch to enable the Smdbltrp ISA extension and disable it for
> the max cpu. Indeed, OpenSBI when Smdbltrp is present, M-mode double
> trap is enabled by default and MSTATUS.MDT needs to be cleared to avoid
> taking a double trap. OpenSBI does not currently support it so disable
> it for the max cpu to avoid breaking regression tests.
> 
> Signed-off-by: Clément Léger <cleger@rivosinc.com>
> ---

Tested by removing:

drop  0b443cba0d target/riscv: Add Smdbltrp ISA extension enable switch

 From riscv-to-apply.next, applying this patch in its place.

'make check-functional' is working again, i.e. there's no problems in
booting the 'max' CPU.


Reviewed-by: Daniel Henrique Barboza <dbarboza@ventanamicro.com>

> Note: this is a resend of patch 9/9 from the double trap series which
> disables this extension for the max cpu. It can be cherry-picked as a
> direct replacement of previous commit.
> 
>   target/riscv/cpu.c         |  2 ++
>   target/riscv/tcg/tcg-cpu.c | 10 ++++++++++
>   2 files changed, 12 insertions(+)
> 
> diff --git a/target/riscv/cpu.c b/target/riscv/cpu.c
> index e3ed11b0fd..bddf1ba75e 100644
> --- a/target/riscv/cpu.c
> +++ b/target/riscv/cpu.c
> @@ -194,6 +194,7 @@ const RISCVIsaExtData isa_edata_arr[] = {
>       ISA_EXT_DATA_ENTRY(smcdeleg, PRIV_VERSION_1_13_0, ext_smcdeleg),
>       ISA_EXT_DATA_ENTRY(smcntrpmf, PRIV_VERSION_1_12_0, ext_smcntrpmf),
>       ISA_EXT_DATA_ENTRY(smcsrind, PRIV_VERSION_1_13_0, ext_smcsrind),
> +    ISA_EXT_DATA_ENTRY(smdbltrp, PRIV_VERSION_1_13_0, ext_smdbltrp),
>       ISA_EXT_DATA_ENTRY(smepmp, PRIV_VERSION_1_12_0, ext_smepmp),
>       ISA_EXT_DATA_ENTRY(smrnmi, PRIV_VERSION_1_12_0, ext_smrnmi),
>       ISA_EXT_DATA_ENTRY(smmpm, PRIV_VERSION_1_13_0, ext_smmpm),
> @@ -1626,6 +1627,7 @@ const RISCVCPUMultiExtConfig riscv_cpu_extensions[] = {
>       MULTI_EXT_CFG_BOOL("ssnpm", ext_ssnpm, false),
>   
>       MULTI_EXT_CFG_BOOL("smaia", ext_smaia, false),
> +    MULTI_EXT_CFG_BOOL("smdbltrp", ext_smdbltrp, false),
>       MULTI_EXT_CFG_BOOL("smepmp", ext_smepmp, false),
>       MULTI_EXT_CFG_BOOL("smrnmi", ext_smrnmi, false),
>       MULTI_EXT_CFG_BOOL("smmpm", ext_smmpm, false),
> diff --git a/target/riscv/tcg/tcg-cpu.c b/target/riscv/tcg/tcg-cpu.c
> index 48be24bbbe..0a137281de 100644
> --- a/target/riscv/tcg/tcg-cpu.c
> +++ b/target/riscv/tcg/tcg-cpu.c
> @@ -1439,6 +1439,16 @@ static void riscv_init_max_cpu_extensions(Object *obj)
>           isa_ext_update_enabled(cpu, CPU_CFG_OFFSET(ext_smrnmi), false);
>           qemu_log("Smrnmi is disabled in the 'max' type CPU\n");
>       }
> +
> +    /*
> +     * ext_smdbltrp requires the firmware to clear MSTATUS.MDT on startup to
> +     * avoid generating a double trap. OpenSBI does not currently support it,
> +     * disable it for now.
> +     */
> +    if (cpu->cfg.ext_smdbltrp) {
> +        isa_ext_update_enabled(cpu, CPU_CFG_OFFSET(ext_smdbltrp), false);
> +        qemu_log("Smdbltrp is disabled in the 'max' type CPU\n");
> +    }
>   }
>   
>   static bool riscv_cpu_has_max_extensions(Object *cpu_obj)


