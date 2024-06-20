Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C6F56C27C79
	for <qemu-devel@archiver.kernel.org>; Thu, 20 Jun 2024 19:52:32 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sKNp9-0001Om-RL; Thu, 20 Jun 2024 15:51:59 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dbarboza@ventanamicro.com>)
 id 1sKNp8-0001OY-5c
 for qemu-devel@nongnu.org; Thu, 20 Jun 2024 15:51:58 -0400
Received: from mail-pg1-x52d.google.com ([2607:f8b0:4864:20::52d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <dbarboza@ventanamicro.com>)
 id 1sKNp6-0000fa-8A
 for qemu-devel@nongnu.org; Thu, 20 Jun 2024 15:51:57 -0400
Received: by mail-pg1-x52d.google.com with SMTP id
 41be03b00d2f7-6e3741519d7so912457a12.2
 for <qemu-devel@nongnu.org>; Thu, 20 Jun 2024 12:51:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=ventanamicro.com; s=google; t=1718913114; x=1719517914; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=LSxGBdJYjDP1z70ffrUgVwSpLwGoO0OVbPB+vyGFz1U=;
 b=MFWCughYpqjFcvyUReLgjB/2BiGMSV7ilrF2oBRCycX4gt5HX0xeZe5mUvS5FH+NqY
 43L2mqx5ylKddHdT8Ul+QaxHTFuk+GF/UQy9skmIoXFPSOIBo5eeFXC/k93wUsn3Ga53
 NHKaxYdsOQ9ufeWG8JMnSzgde4TcC5xTkoO8IMELLY0RKbGEIpFGkU1bIIQu7rN7aE8R
 ynbxh6/Vy5Bv0U9nlhMmtVBYZfqA8vj81WfuRKtPSvCHTA71Y7iKPeLyq9yPWI8CzBxE
 iUtQPOEFmTvTkN09ntxrlLhdwJ/fx/E/T4X+MT2W7ncTt0iWVbAq1JlWZ5/ey29lC6xd
 1VKg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1718913114; x=1719517914;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=LSxGBdJYjDP1z70ffrUgVwSpLwGoO0OVbPB+vyGFz1U=;
 b=Wiou9sumHgizuLtLsSInZe3UkgJpBL/EwH0DcVnINJGu9+IPsqTp95iZE+HsmYTJ1Q
 GBNT3e5wRiVjhApDsA0ZHuOOLHbKGtf1QN+C8edtzbCNTQKKLZQdYWWsaZgc8yUkw+Ix
 CK7aP6/Y590BID3uerNnMSkYBLSqmAls8lFGo6xfnbpA0WtbAKre0GYgA2bcgaauUuWc
 3OrbEUyIzLlck5fMFWqfiqdA1Q+dz5F5q/NOf10GqvCi/1RI66ri2GwGiF461sMoCIf9
 eV8WbJXYKLThbXFmRWKUVJyQ4hqHdhH2waSZrPECEou4K7UqxhK2gkInCC4f2YUqFhwQ
 4HIg==
X-Forwarded-Encrypted: i=1;
 AJvYcCVzR/Kri+sc4UXtGsov6YJiacXXGV1N11xpgrotXnS//UaFZyiGgZ9/SHrfuaYbmGg4yzBBDDGIFaa+mnd+zhLcNCTbp64=
X-Gm-Message-State: AOJu0YxHAOoHKQ99Gc6hRtuQb6rflx6Zph5LgzOWZNAKHDTh1WoShlJ0
 3DavjiOgr5fT7V2GWi+/6TsWZAAv+TDW5TmzB9Cr+lfFSFfxfAdZi0iiAMF1pvU=
X-Google-Smtp-Source: AGHT+IEZITwCD0hSfb+zfPzmVI2fAS+VtJ7DqpCu03XNxRz6GUDM80hlc3S+tnpr6Ng4nU/YE5JnMQ==
X-Received: by 2002:a05:6a21:818a:b0:1b5:ad0b:50bf with SMTP id
 adf61e73a8af0-1bcbb61cb46mr5847157637.51.1718913114506; 
 Thu, 20 Jun 2024 12:51:54 -0700 (PDT)
Received: from ?IPV6:2804:7f0:bdcd:fb00:6501:2693:db52:c621?
 ([2804:7f0:bdcd:fb00:6501:2693:db52:c621])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-7065124dee3sm25572b3a.134.2024.06.20.12.51.50
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 20 Jun 2024 12:51:54 -0700 (PDT)
Message-ID: <48f21345-f029-4930-9030-8986c7ba57a9@ventanamicro.com>
Date: Thu, 20 Jun 2024 16:51:49 -0300
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 1/6] target/riscv: Introduce extension implied rules
 definition
To: frank.chang@sifive.com, qemu-devel@nongnu.org
Cc: Palmer Dabbelt <palmer@dabbelt.com>,
 Alistair Francis <alistair.francis@wdc.com>, Bin Meng <bmeng.cn@gmail.com>,
 Weiwei Li <liwei1518@gmail.com>, Liu Zhiwei <zhiwei_liu@linux.alibaba.com>,
 "open list:RISC-V TCG CPUs" <qemu-riscv@nongnu.org>,
 Jerry Zhang Jian <jerry.zhangjian@sifive.com>, Max Chou <max.chou@sifive.com>
References: <20240616024657.17948-1-frank.chang@sifive.com>
 <20240616024657.17948-2-frank.chang@sifive.com>
Content-Language: en-US
From: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
In-Reply-To: <20240616024657.17948-2-frank.chang@sifive.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::52d;
 envelope-from=dbarboza@ventanamicro.com; helo=mail-pg1-x52d.google.com
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
> RISCVCPUImpliedExtsRule is created to store the implied rules.
> 'is_misa' flag is used to distinguish whether the rule is derived
> from the MISA or other extensions.
> 'ext' stores the MISA bit if 'is_misa' is true. Otherwise, it stores
> the offset of the extension defined in RISCVCPUConfig. 'ext' will also
> serve as the key of the hash tables to look up the rule in the following
> commit.
> 
> Signed-off-by: Frank Chang <frank.chang@sifive.com>
> Reviewed-by: Jerry Zhang Jian <jerry.zhangjian@sifive.com>
> Tested-by: Max Chou <max.chou@sifive.com>
> ---

Reviewed-by: Daniel Henrique Barboza <dbarboza@ventanamicro.com>

>   target/riscv/cpu.c |  8 ++++++++
>   target/riscv/cpu.h | 25 +++++++++++++++++++++++++
>   2 files changed, 33 insertions(+)
> 
> diff --git a/target/riscv/cpu.c b/target/riscv/cpu.c
> index 4760cb2cc1..bacbb32120 100644
> --- a/target/riscv/cpu.c
> +++ b/target/riscv/cpu.c
> @@ -2250,6 +2250,14 @@ RISCVCPUProfile *riscv_profiles[] = {
>       NULL,
>   };
>   
> +RISCVCPUImpliedExtsRule *riscv_misa_implied_rules[] = {
> +    NULL
> +};
> +
> +RISCVCPUImpliedExtsRule *riscv_ext_implied_rules[] = {
> +    NULL
> +};
> +
>   static Property riscv_cpu_properties[] = {
>       DEFINE_PROP_BOOL("debug", RISCVCPU, cfg.debug, true),
>   
> diff --git a/target/riscv/cpu.h b/target/riscv/cpu.h
> index 90b8f1b08f..6b31731fa8 100644
> --- a/target/riscv/cpu.h
> +++ b/target/riscv/cpu.h
> @@ -124,6 +124,31 @@ typedef enum {
>       EXT_STATUS_DIRTY,
>   } RISCVExtStatus;
>   
> +typedef struct riscv_cpu_implied_exts_rule RISCVCPUImpliedExtsRule;
> +
> +struct riscv_cpu_implied_exts_rule {
> +#ifndef CONFIG_USER_ONLY
> +    /*
> +     * Bitmask indicates the rule enabled status for the harts.
> +     * This enhancement is only available in system-mode QEMU,
> +     * as we don't have a good way (e.g. mhartid) to distinguish
> +     * the SMP cores in user-mode QEMU.
> +     */
> +    uint64_t enabled;
> +#endif
> +    /* True if this is a MISA implied rule. */
> +    bool is_misa;
> +    /* ext is MISA bit if is_misa flag is true, else extension offset. */
> +    const uint32_t ext;
> +    const uint32_t implied_misas;
> +    const uint32_t implied_exts[];
> +};
> +
> +extern RISCVCPUImpliedExtsRule *riscv_misa_implied_rules[];
> +extern RISCVCPUImpliedExtsRule *riscv_ext_implied_rules[];
> +
> +#define RISCV_IMPLIED_EXTS_RULE_END -1
> +
>   #define MMU_USER_IDX 3
>   
>   #define MAX_RISCV_PMPS (16)

