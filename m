Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 08C2BC25B7A
	for <qemu-devel@archiver.kernel.org>; Tue, 14 May 2024 11:39:01 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s6qUC-0001bA-QS; Tue, 14 May 2024 07:38:25 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dbarboza@ventanamicro.com>)
 id 1s6qU6-0001XA-6I
 for qemu-devel@nongnu.org; Tue, 14 May 2024 07:38:18 -0400
Received: from mail-pf1-x42e.google.com ([2607:f8b0:4864:20::42e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <dbarboza@ventanamicro.com>)
 id 1s6qU4-0005Ds-Dv
 for qemu-devel@nongnu.org; Tue, 14 May 2024 07:38:17 -0400
Received: by mail-pf1-x42e.google.com with SMTP id
 d2e1a72fcca58-6f44ed6e82fso4803371b3a.3
 for <qemu-devel@nongnu.org>; Tue, 14 May 2024 04:38:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=ventanamicro.com; s=google; t=1715686693; x=1716291493; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=FrzDCx43i5qrfoF8ZQBGM6dCXoPMP+hOh7VEm4+Fl/E=;
 b=Gt5U4hDXDeHBK0v+FWSgSXQahT7eolmJVwB0RlW1Psi3eZln2y4rLPHV6dOLAVV4Fp
 14N773TbUPN/Ilf8+z3vjAeUjRnajpkAOnsc/D7aVT6M135rVLK7UUgOyXvTD9HLvYW8
 Pxh88zQIh10uiTp+OeWqhgDjErKeqE9nIRUK5bnUCO/HUODwJA6U6NfzmX9PYCs7qGDn
 33uGkN/Y08xLw1uswp5WrsHeYHZOJJfr1ZssEZXq28rzj2l/Jxa9pANDl/I25GBbt24N
 I+MYmbLppg0N7ipda/CPSB/i3Quym9G/8Ni4a8OHytcElO1jbBEqghHM6lx1gbEOZ50i
 Y3WA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1715686693; x=1716291493;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=FrzDCx43i5qrfoF8ZQBGM6dCXoPMP+hOh7VEm4+Fl/E=;
 b=rhDK1eTvk0LBd4M5YURe6ieMnQY+cMlblNXU9sC8nFpt7/UQqSP7+yEjNSNkiydDfm
 EYwL6wawl2XEcbZoMQT9TY7soxc8VXLiVbTXsw3VEWYdZ45Z9AJIJGTK9l64ZaObmB0A
 uLsSXL7QD+GF6Rfr2CijG1fsi9ppvIEfnqe0eCxWgfuEGk3EDLKYZ7fpBLmGErflFDBU
 8SWlAwLkALHD2TmIrEZtJzdesK3YvMafaLoVo7LIkX9xIwNHWkUBHJlah2AXXWRCk6LQ
 kdpCcRWtVrK7dkPHLD1Js5IFGQnFupD2ulwq97fr+dW2ke5Wrpd7o2G1ZTM2MK8wHQu4
 GbZQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCWyBHDZWptRKWhacKjlOiqPpMMUHZnreeT5jt2QyfxKvNkHz7ALtqnRMozANKnK115cSYtiUNLCQgekQ3s/08rgweNSfF8=
X-Gm-Message-State: AOJu0YxyiEgd8HVyeUad5Dgqz4ul/qqMwlOVVwJsviPsXwAh09k/ga40
 oca+x9b0UvHXhnCwxoAvygabtAKMbrbyHA3HM9Fb7T9USBELga7LHrdzb7mfPKY=
X-Google-Smtp-Source: AGHT+IE8oNVzpUbS1StVIIOyM+KaraW3XtkMTRWY0dgZVGO+1Ho6IiiiHVxCp5vhaeCSxuC+W9WcQA==
X-Received: by 2002:a05:6a21:150b:b0:1af:e3f1:9af7 with SMTP id
 adf61e73a8af0-1afe3f1ba98mr14157719637.36.1715686693485; 
 Tue, 14 May 2024 04:38:13 -0700 (PDT)
Received: from [192.168.68.110] ([177.94.42.57])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-1ef0badcdfcsm95322465ad.104.2024.05.14.04.38.10
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 14 May 2024 04:38:13 -0700 (PDT)
Message-ID: <2dda41cc-0d43-445f-b96b-38fbb799bf45@ventanamicro.com>
Date: Tue, 14 May 2024 08:38:08 -0300
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] target/riscv: Remove experimental prefix from "B"
 extension
To: Rob Bradford <rbradford@rivosinc.com>, qemu-devel@nongnu.org
Cc: Andrew Jones <ajones@ventanamicro.com>,
 Palmer Dabbelt <palmer@dabbelt.com>,
 Alistair Francis <alistair.francis@wdc.com>, Bin Meng <bmeng.cn@gmail.com>,
 Weiwei Li <liwei1518@gmail.com>, Liu Zhiwei <zhiwei_liu@linux.alibaba.com>,
 "open list:RISC-V TCG CPUs" <qemu-riscv@nongnu.org>
References: <20240514110217.22516-1-rbradford@rivosinc.com>
Content-Language: en-US
From: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
In-Reply-To: <20240514110217.22516-1-rbradford@rivosinc.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::42e;
 envelope-from=dbarboza@ventanamicro.com; helo=mail-pf1-x42e.google.com
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



On 5/14/24 08:02, Rob Bradford wrote:
> This extension has now been ratified:
> https://jira.riscv.org/browse/RVS-2006 so the "x-" prefix can be
> removed.
> 
> Since this is now a ratified extension add it to the list of extensions
> included in the "max" CPU variant.
> 
> Signed-off-by: Rob Bradford <rbradford@rivosinc.com>
> Reviewed-by: Andrew Jones <ajones@ventanamicro.com>
> ---

Reviewed-by: Daniel Henrique Barboza <dbarboza@ventanamicro.com>

>   target/riscv/cpu.c         | 2 +-
>   target/riscv/tcg/tcg-cpu.c | 2 +-
>   2 files changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/target/riscv/cpu.c b/target/riscv/cpu.c
> index eb1a2e7d6d..861d9f4350 100644
> --- a/target/riscv/cpu.c
> +++ b/target/riscv/cpu.c
> @@ -1396,7 +1396,7 @@ static const MISAExtInfo misa_ext_info_arr[] = {
>       MISA_EXT_INFO(RVJ, "x-j", "Dynamic translated languages"),
>       MISA_EXT_INFO(RVV, "v", "Vector operations"),
>       MISA_EXT_INFO(RVG, "g", "General purpose (IMAFD_Zicsr_Zifencei)"),
> -    MISA_EXT_INFO(RVB, "x-b", "Bit manipulation (Zba_Zbb_Zbs)")
> +    MISA_EXT_INFO(RVB, "b", "Bit manipulation (Zba_Zbb_Zbs)")
>   };
>   
>   static void riscv_cpu_validate_misa_mxl(RISCVCPUClass *mcc)
> diff --git a/target/riscv/tcg/tcg-cpu.c b/target/riscv/tcg/tcg-cpu.c
> index 40054a391a..164a13ad0f 100644
> --- a/target/riscv/tcg/tcg-cpu.c
> +++ b/target/riscv/tcg/tcg-cpu.c
> @@ -1281,7 +1281,7 @@ static void riscv_init_max_cpu_extensions(Object *obj)
>       const RISCVCPUMultiExtConfig *prop;
>   
>       /* Enable RVG, RVJ and RVV that are disabled by default */
> -    riscv_cpu_set_misa_ext(env, env->misa_ext | RVG | RVJ | RVV);
> +    riscv_cpu_set_misa_ext(env, env->misa_ext | RVB | RVG | RVJ | RVV);
>   
>       for (prop = riscv_cpu_extensions; prop && prop->name; prop++) {
>           isa_ext_update_enabled(cpu, prop->offset, true);

