Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2C6EFC41513
	for <qemu-devel@archiver.kernel.org>; Thu, 20 Jun 2024 19:53:55 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sKNqK-0002QC-MU; Thu, 20 Jun 2024 15:53:12 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dbarboza@ventanamicro.com>)
 id 1sKNqI-0002Kw-5E
 for qemu-devel@nongnu.org; Thu, 20 Jun 2024 15:53:10 -0400
Received: from mail-pl1-x631.google.com ([2607:f8b0:4864:20::631])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <dbarboza@ventanamicro.com>)
 id 1sKNqG-0000mF-GF
 for qemu-devel@nongnu.org; Thu, 20 Jun 2024 15:53:09 -0400
Received: by mail-pl1-x631.google.com with SMTP id
 d9443c01a7336-1f9c6e59d34so11451865ad.2
 for <qemu-devel@nongnu.org>; Thu, 20 Jun 2024 12:53:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=ventanamicro.com; s=google; t=1718913187; x=1719517987; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=wFoZDjLPNvluNfbI2zyXB5VSH57oUmsYsJGjFtiTLI0=;
 b=DrrWarpYNifqnkyEXypq7VauZNHNq0X0eq7k6AQqs0qKCdv1eiPOIsL99S/vS4ioC+
 huaO9tFyMDtsN0Q/HwWd7s4/fw3oMS4xl3t40nJYvo5oyYlG2gcG8bRq+uVJ9KIuE5n+
 apZhcJjsSt4xDIRSuYhmr6u7KT/cDzF3OkgN6KTPyc0NQ0fKG0WJ3+PhcGPl/wcbs4uB
 1HMhpC6POp4+saoP8CBuLnG5vwMtDnsI/ZKlYZmnyZQEqYBYp7iE8uYcysx6dGwjYC8X
 gaCmVgW/IXkFHy6T5/svbkCWk43YsXivOy5VTwl2Sm2PRo1IUZBNtPoVLU/GBZ+DgFnu
 8f3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1718913187; x=1719517987;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=wFoZDjLPNvluNfbI2zyXB5VSH57oUmsYsJGjFtiTLI0=;
 b=xELPildefECJvNNi2/MQ/IqIrFWsjip24lXxLZJpm8SLJqKZCY8+4G8IdVgNr1mr4m
 F8AHsAMH4XDUDEoWq8GtnNEKDavF6uYrAafUtnCg44e/YTUjtz8RMWiq23lkx8uy4ZdL
 kwBCzWkGw+RCitBFcgD0R0gZMiW5yv2QELHeYpJkSdUBv6MGU0TJ8e2BjqZh6zw1Uzb5
 /gffsthxICjkflbApWk7/gIpF8k13PhiVAO/f8KNjdRie6GdP+CDM+ylpqJFXdnpuFjN
 cV6fNaMJ2sARsvta0aeT/IuTbQ4JL4JYt+i+0Znlnp1OmbZ87vLSlqMZMOWcRPpDD2Fu
 L2jQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCWzT6Lttf5+QzWJ77CsL8c4O9JpPJKWhHuALh7DtkjJbPNvpY0sEj3+XpGJv9JvhJoxd510OeZDP8RKoiPACY9nh/k3frA=
X-Gm-Message-State: AOJu0YxB7/ZbawhPU/tLdqbB9mm2/aT9Z4rA9y04Eco8m8Y4NpEOqfwa
 O5ys0mv31KiDZ0j3NZJpd3nsu27QSPJsqfVd7BeVZvSCL44/sUUbtweNrpQTNzs=
X-Google-Smtp-Source: AGHT+IFQyNvySIOczJSsLmMaoc9/9e66g4aZoVCFJI5CnpHRfSHmIBMcKBl/zPInF1CHMfJWWvfQdQ==
X-Received: by 2002:a17:902:f549:b0:1f9:e5fb:3336 with SMTP id
 d9443c01a7336-1f9e5fb3573mr5526755ad.40.1718913186849; 
 Thu, 20 Jun 2024 12:53:06 -0700 (PDT)
Received: from ?IPV6:2804:7f0:bdcd:fb00:6501:2693:db52:c621?
 ([2804:7f0:bdcd:fb00:6501:2693:db52:c621])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-1f9eb3219b1sm50485ad.94.2024.06.20.12.53.03
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 20 Jun 2024 12:53:06 -0700 (PDT)
Message-ID: <759edf09-fb88-4e54-83f1-ac91756df78d@ventanamicro.com>
Date: Thu, 20 Jun 2024 16:53:00 -0300
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 3/6] target/riscv: Add MISA implied rules
To: frank.chang@sifive.com, qemu-devel@nongnu.org
Cc: Palmer Dabbelt <palmer@dabbelt.com>,
 Alistair Francis <alistair.francis@wdc.com>, Bin Meng <bmeng.cn@gmail.com>,
 Weiwei Li <liwei1518@gmail.com>, Liu Zhiwei <zhiwei_liu@linux.alibaba.com>,
 "open list:RISC-V TCG CPUs" <qemu-riscv@nongnu.org>,
 Jerry Zhang Jian <jerry.zhangjian@sifive.com>, Max Chou <max.chou@sifive.com>
References: <20240616024657.17948-1-frank.chang@sifive.com>
 <20240616024657.17948-4-frank.chang@sifive.com>
Content-Language: en-US
From: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
In-Reply-To: <20240616024657.17948-4-frank.chang@sifive.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::631;
 envelope-from=dbarboza@ventanamicro.com; helo=mail-pl1-x631.google.com
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



On 6/15/24 11:46 PM, frank.chang@sifive.com wrote:
> From: Frank Chang <frank.chang@sifive.com>
> 
> Add MISA extension implied rules to enable the implied extensions
> of MISA recursively.
> 
> Signed-off-by: Frank Chang <frank.chang@sifive.com>
> Reviewed-by: Jerry Zhang Jian <jerry.zhangjian@sifive.com>
> Tested-by: Max Chou <max.chou@sifive.com>
> Reviewed-by: Alistair Francis <alistair.francis@wdc.com>
> ---

Reviewed-by: Daniel Henrique Barboza <dbarboza@ventanamicro.com>

>   target/riscv/cpu.c | 50 +++++++++++++++++++++++++++++++++++++++++++++-
>   1 file changed, 49 insertions(+), 1 deletion(-)
> 
> diff --git a/target/riscv/cpu.c b/target/riscv/cpu.c
> index bacbb32120..d09b5e9e62 100644
> --- a/target/riscv/cpu.c
> +++ b/target/riscv/cpu.c
> @@ -2250,8 +2250,56 @@ RISCVCPUProfile *riscv_profiles[] = {
>       NULL,
>   };
>   
> +static RISCVCPUImpliedExtsRule RVA_IMPLIED = {
> +    .is_misa = true,
> +    .ext = RVA,
> +    .implied_exts = {
> +        CPU_CFG_OFFSET(ext_zalrsc), CPU_CFG_OFFSET(ext_zaamo),
> +
> +        RISCV_IMPLIED_EXTS_RULE_END
> +    },
> +};
> +
> +static RISCVCPUImpliedExtsRule RVD_IMPLIED = {
> +    .is_misa = true,
> +    .ext = RVD,
> +    .implied_misas = RVF,
> +    .implied_exts = { RISCV_IMPLIED_EXTS_RULE_END },
> +};
> +
> +static RISCVCPUImpliedExtsRule RVF_IMPLIED = {
> +    .is_misa = true,
> +    .ext = RVF,
> +    .implied_exts = {
> +        CPU_CFG_OFFSET(ext_zicsr),
> +
> +        RISCV_IMPLIED_EXTS_RULE_END
> +    },
> +};
> +
> +static RISCVCPUImpliedExtsRule RVM_IMPLIED = {
> +    .is_misa = true,
> +    .ext = RVM,
> +    .implied_exts = {
> +        CPU_CFG_OFFSET(ext_zmmul),
> +
> +        RISCV_IMPLIED_EXTS_RULE_END
> +    },
> +};
> +
> +static RISCVCPUImpliedExtsRule RVV_IMPLIED = {
> +    .is_misa = true,
> +    .ext = RVV,
> +    .implied_exts = {
> +        CPU_CFG_OFFSET(ext_zve64d),
> +
> +        RISCV_IMPLIED_EXTS_RULE_END
> +    },
> +};
> +
>   RISCVCPUImpliedExtsRule *riscv_misa_implied_rules[] = {
> -    NULL
> +    &RVA_IMPLIED, &RVD_IMPLIED, &RVF_IMPLIED,
> +    &RVM_IMPLIED, &RVV_IMPLIED, NULL
>   };
>   
>   RISCVCPUImpliedExtsRule *riscv_ext_implied_rules[] = {

