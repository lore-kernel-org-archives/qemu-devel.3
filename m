Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C8F9CC47DDB
	for <qemu-devel@archiver.kernel.org>; Tue, 23 Jan 2024 16:37:44 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rSJm0-0006eb-6d; Tue, 23 Jan 2024 11:37:16 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dbarboza@ventanamicro.com>)
 id 1rSJlw-0006dr-AE
 for qemu-devel@nongnu.org; Tue, 23 Jan 2024 11:37:14 -0500
Received: from mail-pl1-x630.google.com ([2607:f8b0:4864:20::630])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <dbarboza@ventanamicro.com>)
 id 1rSJlu-0002Z1-9q
 for qemu-devel@nongnu.org; Tue, 23 Jan 2024 11:37:11 -0500
Received: by mail-pl1-x630.google.com with SMTP id
 d9443c01a7336-1d6ff29293dso29084545ad.0
 for <qemu-devel@nongnu.org>; Tue, 23 Jan 2024 08:37:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=ventanamicro.com; s=google; t=1706027829; x=1706632629; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=2zg5s9867QUffmRR+tZvS4ta7Mlc0s02/jJEDnvLZeE=;
 b=kVR9xM/8k6aT1D7V1WovDDvVtaEqUuIgXgso1R5jHzR/p45zLVwtEGwTWXHO8WOqmB
 ESJbrMwVx2XI2h5qrtnhC35DCGFBlHtbPdZpFzS5LGKsfCEO0kS2Eote3qPJrSsZV0ta
 pKiPHwuKSc2voNJhJzZw2eGG/rB1ucuIQIWdzObU8uQUN02BzT/RO1UqNJVo76AQ5pVi
 LMKs41+H9c2pdFJNfkVQ6ZAj61Ifg3IJIQkhInn8yrU2tP9DwjVZRzHGdlhAZwqE/fdq
 kXZW3pJmBwlqCFf5YNsIbisbg0n4/TaT9GQ82ObI6YCZrjTzEoSRju7DGZMOh3hkU+SE
 zHEg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1706027829; x=1706632629;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=2zg5s9867QUffmRR+tZvS4ta7Mlc0s02/jJEDnvLZeE=;
 b=ivf34FpbH+TlOOM0Bk5KcdPJngLiqo4Gn7fKITp4MlnlzQZ/xb5uq8F6EWRX/DhLIL
 XLP8f+pyWGhO66uBveVXpLL2Rwru2T2PW7CoW5LbiTZisSSoiGlrr68kzJvP5JSf3M49
 hR/h+KvCFyQPxz8VvIyd0EF6zEZBFXdqeC9B4KUmIxskve0Cb4B8f905AdnDFrMkPKIK
 sccGBVbgzWRdSBOdSxsyZdmkVA5VIrAIqH4sCxK5H8jocWSHjLLdi2np3W8HyxQyma0K
 2o64wqOH4li15iNWrkSnQ6OusD2dErnuF9llh/GKrtcMIbXWJm+wuBlg84Rmd1GuRaOb
 q7nA==
X-Gm-Message-State: AOJu0Yyg8fjOhiuoN5zBRKRAyArxsaXcTJ08wCzGvzHhSqUcMJKsSeA4
 abLQs/KgJXFR8RI4jJY03N/LT/ZhRdAbUyjSKrraAGIwuRCYVYnlTJQDOmft+Rc=
X-Google-Smtp-Source: AGHT+IHOnUVa0a1iuWsEsA+4Ds6+BIq4a9nep2vax6+Tz8Avac3BoVlabsa2suUJZAcI4hZ1cU0Hgg==
X-Received: by 2002:a17:902:c402:b0:1d7:2b7e:cbd with SMTP id
 k2-20020a170902c40200b001d72b7e0cbdmr3391633plk.129.1706027828857; 
 Tue, 23 Jan 2024 08:37:08 -0800 (PST)
Received: from [192.168.68.110] ([152.234.127.94])
 by smtp.gmail.com with ESMTPSA id
 u19-20020a170903305300b001d714a6eff7sm8031626pla.80.2024.01.23.08.37.06
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 23 Jan 2024 08:37:08 -0800 (PST)
Message-ID: <8c76c139-5f97-48d6-967a-7a65ea89391d@ventanamicro.com>
Date: Tue, 23 Jan 2024 13:37:06 -0300
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 3/3] target/riscv: Expose Zaamo and Zalrsc extensions
Content-Language: en-US
To: Rob Bradford <rbradford@rivosinc.com>, qemu-devel@nongnu.org
Cc: qemu-riscv@nongnu.org, atishp@rivosinc.com, palmer@dabbelt.com,
 alistair.francis@wdc.com, bin.meng@windriver.com, liwei1518@gmail.com,
 zhiwei_liu@linux.alibaba.com
References: <20240123111030.15074-1-rbradford@rivosinc.com>
 <20240123111030.15074-4-rbradford@rivosinc.com>
From: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
In-Reply-To: <20240123111030.15074-4-rbradford@rivosinc.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::630;
 envelope-from=dbarboza@ventanamicro.com; helo=mail-pl1-x630.google.com
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



On 1/23/24 08:10, Rob Bradford wrote:
> Expose the newly added extensions to the guest and allow their control
> through the CPU properties.
> 
> Signed-off-by: Rob Bradford <rbradford@rivosinc.com>
> ---

Reviewed-by: Daniel Henrique Barboza <dbarboza@ventanamicro.com>

>   target/riscv/cpu.c | 5 +++++
>   1 file changed, 5 insertions(+)
> 
> diff --git a/target/riscv/cpu.c b/target/riscv/cpu.c
> index 8d3ec74a1c..604baf53c8 100644
> --- a/target/riscv/cpu.c
> +++ b/target/riscv/cpu.c
> @@ -103,7 +103,9 @@ const RISCVIsaExtData isa_edata_arr[] = {
>       ISA_EXT_DATA_ENTRY(zihintpause, PRIV_VERSION_1_10_0, ext_zihintpause),
>       ISA_EXT_DATA_ENTRY(zihpm, PRIV_VERSION_1_12_0, ext_zihpm),
>       ISA_EXT_DATA_ENTRY(zmmul, PRIV_VERSION_1_12_0, ext_zmmul),
> +    ISA_EXT_DATA_ENTRY(zaamo, PRIV_VERSION_1_12_0, ext_zaamo),
>       ISA_EXT_DATA_ENTRY(zacas, PRIV_VERSION_1_12_0, ext_zacas),
> +    ISA_EXT_DATA_ENTRY(zalrsc, PRIV_VERSION_1_12_0, ext_zalrsc),
>       ISA_EXT_DATA_ENTRY(zawrs, PRIV_VERSION_1_12_0, ext_zawrs),
>       ISA_EXT_DATA_ENTRY(zfa, PRIV_VERSION_1_12_0, ext_zfa),
>       ISA_EXT_DATA_ENTRY(zfbfmin, PRIV_VERSION_1_12_0, ext_zfbfmin),
> @@ -1491,6 +1493,9 @@ const RISCVCPUMultiExtConfig riscv_cpu_experimental_exts[] = {
>       MULTI_EXT_CFG_BOOL("x-smaia", ext_smaia, false),
>       MULTI_EXT_CFG_BOOL("x-ssaia", ext_ssaia, false),
>   
> +    MULTI_EXT_CFG_BOOL("x-zaamo", ext_zaamo, false),
> +    MULTI_EXT_CFG_BOOL("x-zalrsc", ext_zalrsc, false),
> +
>       MULTI_EXT_CFG_BOOL("x-zvfh", ext_zvfh, false),
>       MULTI_EXT_CFG_BOOL("x-zvfhmin", ext_zvfhmin, false),
>   

