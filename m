Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6CDABC48BF6
	for <qemu-devel@archiver.kernel.org>; Mon,  4 Mar 2024 17:25:16 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rhC3C-0005kG-5m; Mon, 04 Mar 2024 12:24:30 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dbarboza@ventanamicro.com>)
 id 1rhC3A-0005jS-SM
 for qemu-devel@nongnu.org; Mon, 04 Mar 2024 12:24:28 -0500
Received: from mail-pf1-x436.google.com ([2607:f8b0:4864:20::436])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <dbarboza@ventanamicro.com>)
 id 1rhC38-0007QR-TG
 for qemu-devel@nongnu.org; Mon, 04 Mar 2024 12:24:28 -0500
Received: by mail-pf1-x436.google.com with SMTP id
 d2e1a72fcca58-6e57a3bf411so2731568b3a.0
 for <qemu-devel@nongnu.org>; Mon, 04 Mar 2024 09:24:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=ventanamicro.com; s=google; t=1709573065; x=1710177865; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=ujQZlVzwEouRsoAxeY1MiVCw9haUba1/ifiQupfzP88=;
 b=Nv7dQc2FFA7gc+dddu8seEd6QLcIrj67q8Uc4mTStcPyGDwLKKWYQ/gYIuMpREzA6x
 olgqf4qfiGfjMvnL2yoNy4GbInySuGnt/X77iklOP6gbl/9oX8faeCbXnIhhe2dDaO5Y
 P2MCLWa7mXZF2yTH1w/4DTUOOHfCyVm/p3ULX5QInmFN5H+MSLMDmuQF+/SSkS3pVgZj
 l4w1yB8ZwuL5rLZ/ZB4Ur+Sa7VZGwbMmFBND/vqRgF3o/r+6UQ2W9Q1UpQUCfGzsYsWC
 nHxhRnWZnoFYJcxp/9OJDSUNE81ht/XdEAvD2tjlXKB6qN6kXRRrAqNUiSKYXERJHPtR
 JKbw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1709573065; x=1710177865;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=ujQZlVzwEouRsoAxeY1MiVCw9haUba1/ifiQupfzP88=;
 b=hcMTpzqKJTpxpjSuRPo13valt9veI+kEB9pwDV5sH7clo5LpcRCvwvjV25vI7rfwYm
 mp/PWo+Qc9WBhr7E4GygZZE6tx+WLGAIX9LopevXoHEcfRpl5NLn1Kcwa7EEzrcayavN
 aqOZxeSmUBiYe2C4Xtm6pLUZH/joctLbWV8Ps3ol6Fz5TeYmzRGTQYiMq9rXJuR9cF3S
 9kcU4nzREfKO72BkC/TEvr3QVJiecK1EVzVAhq0qdYdOyUREWfQ7/tehdGtReufVtMmH
 9Ix1Eg8f7BhFxBVVzmIMHA/ZgCDuKbX+DRJkn79GiA4g4AtN6WNlmNYRcyykoA8m3dZr
 2Lug==
X-Forwarded-Encrypted: i=1;
 AJvYcCWQaWVQxgP/Oc2UMNKDT7Tprx2NV71X0JbTAItGGHXzVVYsXrK5gxTp1H7bt/vzNBO0y29UbslrjsO4Ajh3zszPuufjALo=
X-Gm-Message-State: AOJu0YxabU+8L6fqZAdJgbRW+zeJ4Ca+z3Hc3fdVTHTHcDt3ZgPFHtEN
 hm5nBcVOUn0++j3n3BVoHX5V3l8nczl1Sxa2KLhaB3EJm2pNdll8vht7gxI92kA=
X-Google-Smtp-Source: AGHT+IFrkuXw/iiN1aUxFBGZEApPu2LibaAmsW/EyACllCghD6kYY0sliQFSvPO1DPB5QjUty8sOEQ==
X-Received: by 2002:a05:6a00:9084:b0:6e5:dadd:6e11 with SMTP id
 jo4-20020a056a00908400b006e5dadd6e11mr11946711pfb.33.1709573064784; 
 Mon, 04 Mar 2024 09:24:24 -0800 (PST)
Received: from [192.168.68.110] ([177.94.15.159])
 by smtp.gmail.com with ESMTPSA id
 c2-20020a62e802000000b006e1463c18f8sm7558556pfi.37.2024.03.04.09.24.21
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 04 Mar 2024 09:24:24 -0800 (PST)
Message-ID: <23cdc593-c394-4f45-ab83-07b6aae44047@ventanamicro.com>
Date: Mon, 4 Mar 2024 14:24:19 -0300
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 2/5] target/riscv: Add cycle & instret privilege mode
 filtering properties
To: Atish Patra <atishp@rivosinc.com>
Cc: Alistair Francis <alistair.francis@wdc.com>,
 Bin Meng <bin.meng@windriver.com>, Liu Zhiwei
 <zhiwei_liu@linux.alibaba.com>, Palmer Dabbelt <palmer@dabbelt.com>,
 qemu-devel@nongnu.org, qemu-riscv@nongnu.org, Weiwei Li
 <liwei1518@gmail.com>, kaiwenxue1@gmail.com
References: <20240228185116.1321730-1-atishp@rivosinc.com>
 <20240228185116.1321730-3-atishp@rivosinc.com>
Content-Language: en-US
From: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
In-Reply-To: <20240228185116.1321730-3-atishp@rivosinc.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::436;
 envelope-from=dbarboza@ventanamicro.com; helo=mail-pf1-x436.google.com
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



On 2/28/24 15:51, Atish Patra wrote:
> From: Kaiwen Xue <kaiwenx@rivosinc.com>
> 
> This adds the properties for ISA extension smcntrpmf. Patches
> implementing it will follow.
> 
> Signed-off-by: Atish Patra <atishp@rivosinc.com>
> Signed-off-by: Kaiwen Xue <kaiwenx@rivosinc.com>
> ---

Reviewed-by: Daniel Henrique Barboza <dbarboza@ventanamicro.com>

>   target/riscv/cpu.c     | 2 ++
>   target/riscv/cpu_cfg.h | 1 +
>   2 files changed, 3 insertions(+)
> 
> diff --git a/target/riscv/cpu.c b/target/riscv/cpu.c
> index 1b8d001d237f..f9d3c80597fc 100644
> --- a/target/riscv/cpu.c
> +++ b/target/riscv/cpu.c
> @@ -169,6 +169,7 @@ const RISCVIsaExtData isa_edata_arr[] = {
>       ISA_EXT_DATA_ENTRY(zhinx, PRIV_VERSION_1_12_0, ext_zhinx),
>       ISA_EXT_DATA_ENTRY(zhinxmin, PRIV_VERSION_1_12_0, ext_zhinxmin),
>       ISA_EXT_DATA_ENTRY(smaia, PRIV_VERSION_1_12_0, ext_smaia),
> +    ISA_EXT_DATA_ENTRY(smcntrpmf, PRIV_VERSION_1_12_0, ext_smcntrpmf),
>       ISA_EXT_DATA_ENTRY(smepmp, PRIV_VERSION_1_12_0, ext_smepmp),
>       ISA_EXT_DATA_ENTRY(smstateen, PRIV_VERSION_1_12_0, ext_smstateen),
>       ISA_EXT_DATA_ENTRY(ssaia, PRIV_VERSION_1_12_0, ext_ssaia),
> @@ -1447,6 +1448,7 @@ const char *riscv_get_misa_ext_description(uint32_t bit)
>   const RISCVCPUMultiExtConfig riscv_cpu_extensions[] = {
>       /* Defaults for standard extensions */
>       MULTI_EXT_CFG_BOOL("sscofpmf", ext_sscofpmf, false),
> +    MULTI_EXT_CFG_BOOL("smcntrpmf", ext_smcntrpmf, false),
>       MULTI_EXT_CFG_BOOL("zifencei", ext_zifencei, true),
>       MULTI_EXT_CFG_BOOL("zicsr", ext_zicsr, true),
>       MULTI_EXT_CFG_BOOL("zihintntl", ext_zihintntl, true),
> diff --git a/target/riscv/cpu_cfg.h b/target/riscv/cpu_cfg.h
> index 833bf5821708..0828841445c5 100644
> --- a/target/riscv/cpu_cfg.h
> +++ b/target/riscv/cpu_cfg.h
> @@ -73,6 +73,7 @@ struct RISCVCPUConfig {
>       bool ext_zihpm;
>       bool ext_smstateen;
>       bool ext_sstc;
> +    bool ext_smcntrpmf;
>       bool ext_svadu;
>       bool ext_svinval;
>       bool ext_svnapot;

