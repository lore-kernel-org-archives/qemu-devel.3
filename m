Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2899BC2BA1A
	for <qemu-devel@archiver.kernel.org>; Thu, 20 Jun 2024 19:53:55 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sKNqp-0003FL-B1; Thu, 20 Jun 2024 15:53:43 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dbarboza@ventanamicro.com>)
 id 1sKNqo-0003Ed-3F
 for qemu-devel@nongnu.org; Thu, 20 Jun 2024 15:53:42 -0400
Received: from mail-pf1-x42c.google.com ([2607:f8b0:4864:20::42c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <dbarboza@ventanamicro.com>)
 id 1sKNqm-0000no-2C
 for qemu-devel@nongnu.org; Thu, 20 Jun 2024 15:53:41 -0400
Received: by mail-pf1-x42c.google.com with SMTP id
 d2e1a72fcca58-7024d571d8eso1062321b3a.0
 for <qemu-devel@nongnu.org>; Thu, 20 Jun 2024 12:53:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=ventanamicro.com; s=google; t=1718913219; x=1719518019; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=rLMGZM9Enc4S0XlMeHwoXRLW/oXE+m890jZ8hysVtEE=;
 b=MhqBx5YcRYY0lZQMJYwa1O21/SXPCu2OMpT3LiIiuMsf0Wt7SxbNmPNCAmPQgfT5Gi
 FMgZYUQZ9xH8wPdGVDCcNrf2VYEbb8oPOYJT6HwIyQrfFLB55RO2cK5sTJGu5x96taW/
 pe/tWBAa8i8JqCGrJlP53881hb0ijy/2wnMAu6ysl6adYi+bh+n6cqOUFwXziMHjwhAr
 gyuC6+ymNw+NqKKS9xn6hHpNEtVOAemHQAf+uY+FRYrH6BNALkZG2wV1OkHsv0+1I06V
 5yenw39dX98h9VEDItaaAwHzZeinkcEjF/0UMXNwka/9ZwdbOJKI0SFM+ZrEPL/3jHPl
 CBvA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1718913219; x=1719518019;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=rLMGZM9Enc4S0XlMeHwoXRLW/oXE+m890jZ8hysVtEE=;
 b=jeSf3tnJg6BU+V9+sbCXoLAKf2rtSuIF5HPE45ldK5aS0LUn63jhPibsV6tfv7fCkS
 yb9KrVN1VBak4pMl0R4W3nmqv6b4AcBsdGO11N9JZpdm5mFn5WbMmVBCXmuVITon497D
 akh6QzGPn7ayLDNW/FOZqqVNI255pMLQN/jeOcOexlCgDsjvyotuylX3T5ApO2l8qBpz
 TCWt4ucLr458SoI+hsDP+0Lml3DDbiro5ca+GmAlGC1qdwXX5BXfvKp1yNjJ8ytyh49g
 belaGSm6iPHUA+lpsUQoMLeP0KiqHs6jEtzVBdQl8xhG5qrLx/bpO2daBxok2ZfbhpXL
 aaWQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCVRIMZDT5Ij0qCgb1C0qPxMFtCku9cp8SlvWLFdMXgyAza8xnpEzCgCkGDvc6gnTEm3O0NjQMiXn+dQ0xowpCZ3O149tOs=
X-Gm-Message-State: AOJu0YzV2PciLt4fS1QpyOZFVXdBtWWFY0p/bLepUfY+wf2mN6BmDiO0
 2P5RvQgSSY23zjASTTmM/ZWuNtlBeCGkcgmGbNi/FgYao6wv27frqFAIvv9HTAk+8ejTnOIdQTP
 R
X-Google-Smtp-Source: AGHT+IGcKltdnGd4uqSIu+9thbmkQcD4RMDnc8ueyRnqTWPx6dn8EfXzXv/NZwOtUEsGzkbIg1XesA==
X-Received: by 2002:a05:6a00:1401:b0:705:97b3:4605 with SMTP id
 d2e1a72fcca58-70629cb8f0amr8270563b3a.25.1718913218591; 
 Thu, 20 Jun 2024 12:53:38 -0700 (PDT)
Received: from ?IPV6:2804:7f0:bdcd:fb00:6501:2693:db52:c621?
 ([2804:7f0:bdcd:fb00:6501:2693:db52:c621])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-7065119f2bfsm30612b3a.81.2024.06.20.12.53.34
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 20 Jun 2024 12:53:37 -0700 (PDT)
Message-ID: <06793da0-e0ad-4dfd-a3ca-9242463e37b2@ventanamicro.com>
Date: Thu, 20 Jun 2024 16:53:32 -0300
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 4/6] target/riscv: Add standard extension implied rules
To: frank.chang@sifive.com, qemu-devel@nongnu.org
Cc: Palmer Dabbelt <palmer@dabbelt.com>,
 Alistair Francis <alistair.francis@wdc.com>, Bin Meng <bmeng.cn@gmail.com>,
 Weiwei Li <liwei1518@gmail.com>, Liu Zhiwei <zhiwei_liu@linux.alibaba.com>,
 "open list:RISC-V TCG CPUs" <qemu-riscv@nongnu.org>,
 Jerry Zhang Jian <jerry.zhangjian@sifive.com>, Max Chou <max.chou@sifive.com>
References: <20240616024657.17948-1-frank.chang@sifive.com>
 <20240616024657.17948-5-frank.chang@sifive.com>
Content-Language: en-US
From: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
In-Reply-To: <20240616024657.17948-5-frank.chang@sifive.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::42c;
 envelope-from=dbarboza@ventanamicro.com; helo=mail-pf1-x42c.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01,
 UPPERCASE_50_75=0.008 autolearn=no autolearn_force=no
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
> Add standard extension implied rules to enable the implied extensions of
> the standard extension recursively.
> 
> Signed-off-by: Frank Chang <frank.chang@sifive.com>
> Reviewed-by: Jerry Zhang Jian <jerry.zhangjian@sifive.com>
> Tested-by: Max Chou <max.chou@sifive.com>
> Acked-by: Alistair Francis <alistair.francis@wdc.com>
> ---

Reviewed-by: Daniel Henrique Barboza <dbarboza@ventanamicro.com>


>   target/riscv/cpu.c | 340 +++++++++++++++++++++++++++++++++++++++++++++
>   1 file changed, 340 insertions(+)
> 
> diff --git a/target/riscv/cpu.c b/target/riscv/cpu.c
> index d09b5e9e62..1a3b1387e1 100644
> --- a/target/riscv/cpu.c
> +++ b/target/riscv/cpu.c
> @@ -2297,12 +2297,352 @@ static RISCVCPUImpliedExtsRule RVV_IMPLIED = {
>       },
>   };
>   
> +static RISCVCPUImpliedExtsRule ZCB_IMPLIED = {
> +    .ext = CPU_CFG_OFFSET(ext_zcb),
> +    .implied_exts = {
> +        CPU_CFG_OFFSET(ext_zca),
> +
> +        RISCV_IMPLIED_EXTS_RULE_END
> +    },
> +};
> +
> +static RISCVCPUImpliedExtsRule ZCD_IMPLIED = {
> +    .ext = CPU_CFG_OFFSET(ext_zcd),
> +    .implied_misas = RVD,
> +    .implied_exts = {
> +        CPU_CFG_OFFSET(ext_zca),
> +
> +        RISCV_IMPLIED_EXTS_RULE_END
> +    },
> +};
> +
> +static RISCVCPUImpliedExtsRule ZCE_IMPLIED = {
> +    .ext = CPU_CFG_OFFSET(ext_zce),
> +    .implied_exts = {
> +        CPU_CFG_OFFSET(ext_zcb), CPU_CFG_OFFSET(ext_zcmp),
> +        CPU_CFG_OFFSET(ext_zcmt),
> +
> +        RISCV_IMPLIED_EXTS_RULE_END
> +    },
> +};
> +
> +static RISCVCPUImpliedExtsRule ZCF_IMPLIED = {
> +    .ext = CPU_CFG_OFFSET(ext_zcf),
> +    .implied_misas = RVF,
> +    .implied_exts = {
> +        CPU_CFG_OFFSET(ext_zca),
> +
> +        RISCV_IMPLIED_EXTS_RULE_END
> +    },
> +};
> +
> +static RISCVCPUImpliedExtsRule ZCMP_IMPLIED = {
> +    .ext = CPU_CFG_OFFSET(ext_zcmp),
> +    .implied_exts = {
> +        CPU_CFG_OFFSET(ext_zca),
> +
> +        RISCV_IMPLIED_EXTS_RULE_END
> +    },
> +};
> +
> +static RISCVCPUImpliedExtsRule ZCMT_IMPLIED = {
> +    .ext = CPU_CFG_OFFSET(ext_zcmt),
> +    .implied_exts = {
> +        CPU_CFG_OFFSET(ext_zca), CPU_CFG_OFFSET(ext_zicsr),
> +
> +        RISCV_IMPLIED_EXTS_RULE_END
> +    },
> +};
> +
> +static RISCVCPUImpliedExtsRule ZDINX_IMPLIED = {
> +    .ext = CPU_CFG_OFFSET(ext_zdinx),
> +    .implied_exts = {
> +        CPU_CFG_OFFSET(ext_zfinx),
> +
> +        RISCV_IMPLIED_EXTS_RULE_END
> +    },
> +};
> +
> +static RISCVCPUImpliedExtsRule ZFA_IMPLIED = {
> +    .ext = CPU_CFG_OFFSET(ext_zfa),
> +    .implied_misas = RVF,
> +    .implied_exts = { RISCV_IMPLIED_EXTS_RULE_END },
> +};
> +
> +static RISCVCPUImpliedExtsRule ZFBFMIN_IMPLIED = {
> +    .ext = CPU_CFG_OFFSET(ext_zfbfmin),
> +    .implied_misas = RVF,
> +    .implied_exts = { RISCV_IMPLIED_EXTS_RULE_END },
> +};
> +
> +static RISCVCPUImpliedExtsRule ZFH_IMPLIED = {
> +    .ext = CPU_CFG_OFFSET(ext_zfh),
> +    .implied_exts = {
> +        CPU_CFG_OFFSET(ext_zfhmin),
> +
> +        RISCV_IMPLIED_EXTS_RULE_END
> +    },
> +};
> +
> +static RISCVCPUImpliedExtsRule ZFHMIN_IMPLIED = {
> +    .ext = CPU_CFG_OFFSET(ext_zfhmin),
> +    .implied_misas = RVF,
> +    .implied_exts = { RISCV_IMPLIED_EXTS_RULE_END },
> +};
> +
> +static RISCVCPUImpliedExtsRule ZFINX_IMPLIED = {
> +    .ext = CPU_CFG_OFFSET(ext_zfinx),
> +    .implied_exts = {
> +        CPU_CFG_OFFSET(ext_zicsr),
> +
> +        RISCV_IMPLIED_EXTS_RULE_END
> +    },
> +};
> +
> +static RISCVCPUImpliedExtsRule ZHINX_IMPLIED = {
> +    .ext = CPU_CFG_OFFSET(ext_zhinx),
> +    .implied_exts = {
> +        CPU_CFG_OFFSET(ext_zhinxmin),
> +
> +        RISCV_IMPLIED_EXTS_RULE_END
> +    },
> +};
> +
> +static RISCVCPUImpliedExtsRule ZHINXMIN_IMPLIED = {
> +    .ext = CPU_CFG_OFFSET(ext_zhinxmin),
> +    .implied_exts = {
> +        CPU_CFG_OFFSET(ext_zfinx),
> +
> +        RISCV_IMPLIED_EXTS_RULE_END
> +    },
> +};
> +
> +static RISCVCPUImpliedExtsRule ZICNTR_IMPLIED = {
> +    .ext = CPU_CFG_OFFSET(ext_zicntr),
> +    .implied_exts = {
> +        CPU_CFG_OFFSET(ext_zicsr),
> +
> +        RISCV_IMPLIED_EXTS_RULE_END
> +    },
> +};
> +
> +static RISCVCPUImpliedExtsRule ZIHPM_IMPLIED = {
> +    .ext = CPU_CFG_OFFSET(ext_zihpm),
> +    .implied_exts = {
> +        CPU_CFG_OFFSET(ext_zicsr),
> +
> +        RISCV_IMPLIED_EXTS_RULE_END
> +    },
> +};
> +
> +static RISCVCPUImpliedExtsRule ZK_IMPLIED = {
> +    .ext = CPU_CFG_OFFSET(ext_zk),
> +    .implied_exts = {
> +        CPU_CFG_OFFSET(ext_zkn), CPU_CFG_OFFSET(ext_zkr),
> +        CPU_CFG_OFFSET(ext_zkt),
> +
> +        RISCV_IMPLIED_EXTS_RULE_END
> +    },
> +};
> +
> +static RISCVCPUImpliedExtsRule ZKN_IMPLIED = {
> +    .ext = CPU_CFG_OFFSET(ext_zkn),
> +    .implied_exts = {
> +        CPU_CFG_OFFSET(ext_zbkb), CPU_CFG_OFFSET(ext_zbkc),
> +        CPU_CFG_OFFSET(ext_zbkx), CPU_CFG_OFFSET(ext_zkne),
> +        CPU_CFG_OFFSET(ext_zknd), CPU_CFG_OFFSET(ext_zknh),
> +
> +        RISCV_IMPLIED_EXTS_RULE_END
> +    },
> +};
> +
> +static RISCVCPUImpliedExtsRule ZKS_IMPLIED = {
> +    .ext = CPU_CFG_OFFSET(ext_zks),
> +    .implied_exts = {
> +        CPU_CFG_OFFSET(ext_zbkb), CPU_CFG_OFFSET(ext_zbkc),
> +        CPU_CFG_OFFSET(ext_zbkx), CPU_CFG_OFFSET(ext_zksed),
> +        CPU_CFG_OFFSET(ext_zksh),
> +
> +        RISCV_IMPLIED_EXTS_RULE_END
> +    },
> +};
> +
> +static RISCVCPUImpliedExtsRule ZVBB_IMPLIED = {
> +    .ext = CPU_CFG_OFFSET(ext_zvbb),
> +    .implied_exts = {
> +        CPU_CFG_OFFSET(ext_zvkb),
> +
> +        RISCV_IMPLIED_EXTS_RULE_END
> +    },
> +};
> +
> +static RISCVCPUImpliedExtsRule ZVE32F_IMPLIED = {
> +    .ext = CPU_CFG_OFFSET(ext_zve32f),
> +    .implied_misas = RVF,
> +    .implied_exts = {
> +        CPU_CFG_OFFSET(ext_zve32x),
> +
> +        RISCV_IMPLIED_EXTS_RULE_END
> +    },
> +};
> +
> +static RISCVCPUImpliedExtsRule ZVE32X_IMPLIED = {
> +    .ext = CPU_CFG_OFFSET(ext_zve32x),
> +    .implied_exts = {
> +        CPU_CFG_OFFSET(ext_zicsr),
> +
> +        RISCV_IMPLIED_EXTS_RULE_END
> +    },
> +};
> +
> +static RISCVCPUImpliedExtsRule ZVE64D_IMPLIED = {
> +    .ext = CPU_CFG_OFFSET(ext_zve64d),
> +    .implied_misas = RVD,
> +    .implied_exts = {
> +        CPU_CFG_OFFSET(ext_zve64f),
> +
> +        RISCV_IMPLIED_EXTS_RULE_END
> +    },
> +};
> +
> +static RISCVCPUImpliedExtsRule ZVE64F_IMPLIED = {
> +    .ext = CPU_CFG_OFFSET(ext_zve64f),
> +    .implied_misas = RVF,
> +    .implied_exts = {
> +        CPU_CFG_OFFSET(ext_zve32f), CPU_CFG_OFFSET(ext_zve64x),
> +
> +        RISCV_IMPLIED_EXTS_RULE_END
> +    },
> +};
> +
> +static RISCVCPUImpliedExtsRule ZVE64X_IMPLIED = {
> +    .ext = CPU_CFG_OFFSET(ext_zve64x),
> +    .implied_exts = {
> +        CPU_CFG_OFFSET(ext_zve32x),
> +
> +        RISCV_IMPLIED_EXTS_RULE_END
> +    },
> +};
> +
> +static RISCVCPUImpliedExtsRule ZVFBFMIN_IMPLIED = {
> +    .ext = CPU_CFG_OFFSET(ext_zvfbfmin),
> +    .implied_exts = {
> +        CPU_CFG_OFFSET(ext_zve32f),
> +
> +        RISCV_IMPLIED_EXTS_RULE_END
> +    },
> +};
> +
> +static RISCVCPUImpliedExtsRule ZVFBFWMA_IMPLIED = {
> +    .ext = CPU_CFG_OFFSET(ext_zvfbfwma),
> +    .implied_exts = {
> +        CPU_CFG_OFFSET(ext_zvfbfmin), CPU_CFG_OFFSET(ext_zfbfmin),
> +
> +        RISCV_IMPLIED_EXTS_RULE_END
> +    },
> +};
> +
> +static RISCVCPUImpliedExtsRule ZVFH_IMPLIED = {
> +    .ext = CPU_CFG_OFFSET(ext_zvfh),
> +    .implied_exts = {
> +        CPU_CFG_OFFSET(ext_zvfhmin), CPU_CFG_OFFSET(ext_zfhmin),
> +
> +        RISCV_IMPLIED_EXTS_RULE_END
> +    },
> +};
> +
> +static RISCVCPUImpliedExtsRule ZVFHMIN_IMPLIED = {
> +    .ext = CPU_CFG_OFFSET(ext_zvfhmin),
> +    .implied_exts = {
> +        CPU_CFG_OFFSET(ext_zve32f),
> +
> +        RISCV_IMPLIED_EXTS_RULE_END
> +    },
> +};
> +
> +static RISCVCPUImpliedExtsRule ZVKN_IMPLIED = {
> +    .ext = CPU_CFG_OFFSET(ext_zvkn),
> +    .implied_exts = {
> +        CPU_CFG_OFFSET(ext_zvkned), CPU_CFG_OFFSET(ext_zvknhb),
> +        CPU_CFG_OFFSET(ext_zvkb), CPU_CFG_OFFSET(ext_zvkt),
> +
> +        RISCV_IMPLIED_EXTS_RULE_END
> +    },
> +};
> +
> +static RISCVCPUImpliedExtsRule ZVKNC_IMPLIED = {
> +    .ext = CPU_CFG_OFFSET(ext_zvknc),
> +    .implied_exts = {
> +        CPU_CFG_OFFSET(ext_zvkn), CPU_CFG_OFFSET(ext_zvbc),
> +
> +        RISCV_IMPLIED_EXTS_RULE_END
> +    },
> +};
> +
> +static RISCVCPUImpliedExtsRule ZVKNG_IMPLIED = {
> +    .ext = CPU_CFG_OFFSET(ext_zvkng),
> +    .implied_exts = {
> +        CPU_CFG_OFFSET(ext_zvkn), CPU_CFG_OFFSET(ext_zvkg),
> +
> +        RISCV_IMPLIED_EXTS_RULE_END
> +    },
> +};
> +
> +static RISCVCPUImpliedExtsRule ZVKNHB_IMPLIED = {
> +    .ext = CPU_CFG_OFFSET(ext_zvknhb),
> +    .implied_exts = {
> +        CPU_CFG_OFFSET(ext_zve64x),
> +
> +        RISCV_IMPLIED_EXTS_RULE_END
> +    },
> +};
> +
> +static RISCVCPUImpliedExtsRule ZVKS_IMPLIED = {
> +    .ext = CPU_CFG_OFFSET(ext_zvks),
> +    .implied_exts = {
> +        CPU_CFG_OFFSET(ext_zvksed), CPU_CFG_OFFSET(ext_zvksh),
> +        CPU_CFG_OFFSET(ext_zvkb), CPU_CFG_OFFSET(ext_zvkt),
> +
> +        RISCV_IMPLIED_EXTS_RULE_END
> +    },
> +};
> +
> +static RISCVCPUImpliedExtsRule ZVKSC_IMPLIED = {
> +    .ext = CPU_CFG_OFFSET(ext_zvksc),
> +    .implied_exts = {
> +        CPU_CFG_OFFSET(ext_zvks), CPU_CFG_OFFSET(ext_zvbc),
> +
> +        RISCV_IMPLIED_EXTS_RULE_END
> +    },
> +};
> +
> +static RISCVCPUImpliedExtsRule ZVKSG_IMPLIED = {
> +    .ext = CPU_CFG_OFFSET(ext_zvksg),
> +    .implied_exts = {
> +        CPU_CFG_OFFSET(ext_zvks), CPU_CFG_OFFSET(ext_zvkg),
> +
> +        RISCV_IMPLIED_EXTS_RULE_END
> +    },
> +};
> +
>   RISCVCPUImpliedExtsRule *riscv_misa_implied_rules[] = {
>       &RVA_IMPLIED, &RVD_IMPLIED, &RVF_IMPLIED,
>       &RVM_IMPLIED, &RVV_IMPLIED, NULL
>   };
>   
>   RISCVCPUImpliedExtsRule *riscv_ext_implied_rules[] = {
> +    &ZCB_IMPLIED, &ZCD_IMPLIED, &ZCE_IMPLIED,
> +    &ZCF_IMPLIED, &ZCMP_IMPLIED, &ZCMT_IMPLIED,
> +    &ZDINX_IMPLIED, &ZFA_IMPLIED, &ZFBFMIN_IMPLIED,
> +    &ZFH_IMPLIED, &ZFHMIN_IMPLIED, &ZFINX_IMPLIED,
> +    &ZHINX_IMPLIED, &ZHINXMIN_IMPLIED, &ZICNTR_IMPLIED,
> +    &ZIHPM_IMPLIED, &ZK_IMPLIED, &ZKN_IMPLIED,
> +    &ZKS_IMPLIED, &ZVBB_IMPLIED, &ZVE32F_IMPLIED,
> +    &ZVE32X_IMPLIED, &ZVE64D_IMPLIED, &ZVE64F_IMPLIED,
> +    &ZVE64X_IMPLIED, &ZVFBFMIN_IMPLIED, &ZVFBFWMA_IMPLIED,
> +    &ZVFH_IMPLIED, &ZVFHMIN_IMPLIED, &ZVKN_IMPLIED,
> +    &ZVKNC_IMPLIED, &ZVKNG_IMPLIED, &ZVKNHB_IMPLIED,
> +    &ZVKS_IMPLIED,  &ZVKSC_IMPLIED, &ZVKSG_IMPLIED,
>       NULL
>   };
>   

