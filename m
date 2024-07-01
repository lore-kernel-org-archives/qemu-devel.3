Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2613EC2BD09
	for <qemu-devel@archiver.kernel.org>; Mon,  1 Jul 2024 19:11:20 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sOMQ2-0001rh-F4; Mon, 01 Jul 2024 15:10:30 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dbarboza@ventanamicro.com>)
 id 1sOMPx-0001p7-BY
 for qemu-devel@nongnu.org; Mon, 01 Jul 2024 15:10:26 -0400
Received: from mail-pg1-x52a.google.com ([2607:f8b0:4864:20::52a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <dbarboza@ventanamicro.com>)
 id 1sOMPv-0003Q9-CM
 for qemu-devel@nongnu.org; Mon, 01 Jul 2024 15:10:25 -0400
Received: by mail-pg1-x52a.google.com with SMTP id
 41be03b00d2f7-7178ba1c24bso2130224a12.3
 for <qemu-devel@nongnu.org>; Mon, 01 Jul 2024 12:10:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=ventanamicro.com; s=google; t=1719861022; x=1720465822; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=Uyr7j7Rxd8N5WDLLp+EDYwGLVgGjDjqXEyTHR0rHrSc=;
 b=Gb0pd8Vx0U7oSJrWlHWyGgV2U/sgDShiCj2gxMdMfNM101cIQMmQ7K3/1taMq8OsWv
 7D0IJtvyWvUIK9bR4y0snqFnCC8efRR9ub2tEq0O7FaepxoiAlr3oMluab6WezIEtwBF
 8IzZ6vfjZiq7r6TLsPP8aGEj6uOqzrxbuFSvgLWU/auyHGnev/lXyX6U6EUw0ENpq2mP
 nAbN6a0qzV4FH8fA5kdVHmPnojRYWDKlor7QBOJC4E31d1rlNJRfN77e+12WPMJ1k5l2
 qtesDq0B29Nv7HhTVwFH1jrnXg6CQW1LyUGRlTV1GZ2LS517ckQEu77nyoCZFMaLghcB
 kVCQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1719861022; x=1720465822;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=Uyr7j7Rxd8N5WDLLp+EDYwGLVgGjDjqXEyTHR0rHrSc=;
 b=ROTT55EAbstY4ofgEsxK+6v6kmCD5gb3/5Tgyj6Q4KtJwPaqtL1G0KondemVsx9zYG
 ldAuqbnqBHnENYzecDT8SFsohLLICQIAPw5J6m7+NcZNWXD7GrWmPJ9zadfTUrUfK/Sk
 RhI2N0i8h2U0QJ/ORoiAMM2xR70NTmiOgQLw+FgPHCpWMqOh97sSTOjDC/bZMtn2s/tX
 ufv7FQoJeeZBBAAiyYLnnVNjdvoa+cZ+jemnBqC6MLxM4VqQSvcHi8Wqs2Ce9KJKuCTa
 FLqNvDHBoiYEkKBFCJWVjDJ/y+ef1FL2xo2R/BHANKCMYGWcsLdnc14nxjXSOMLXwLuq
 BTWA==
X-Forwarded-Encrypted: i=1;
 AJvYcCU1JyVpbZ9rAPsjGJSIlrDJOmSruGlZePDyD1bypd3z/Zg1mKQhdXCUcwgEhi2l+veXyw5GBfk5dPhjxEYZGHOUmJDcsCQ=
X-Gm-Message-State: AOJu0Yw5pnw5rbfFGnwC/OhWQPeMLBqTsZLF2STPwX13XDAisaHM1L/Q
 Vh4bPvCJYy9RyCcbfs8++gaou0/bO8rrwGyr0BU1WnkznDW0+UO+GiEqx2ktaXa9ie/fc7jCWzm
 X
X-Google-Smtp-Source: AGHT+IGkA79NCV9l9DeLcC6QNXgGy4pRPSrxzfAR0lYrE/fItJxdO3YtY2tp92pP0B+tcqScu0Wxbg==
X-Received: by 2002:a05:6a20:3ca2:b0:1be:c965:2567 with SMTP id
 adf61e73a8af0-1bef620cdc4mr11298102637.47.1719861021682; 
 Mon, 01 Jul 2024 12:10:21 -0700 (PDT)
Received: from ?IPV6:2804:7f0:bcc0:1aea:63a7:288e:eb77:fe54?
 ([2804:7f0:bcc0:1aea:63a7:288e:eb77:fe54])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-1fac10d1ec1sm68583705ad.2.2024.07.01.12.10.17
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 01 Jul 2024 12:10:21 -0700 (PDT)
Message-ID: <547e1e49-bc17-44f8-8288-fe96fb2ebe1b@ventanamicro.com>
Date: Mon, 1 Jul 2024 16:10:15 -0300
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v7 03/11] target/riscv: Add cycle & instret privilege mode
 filtering properties
To: Atish Patra <atishp@rivosinc.com>, qemu-riscv@nongnu.org,
 qemu-devel@nongnu.org
Cc: Rajnesh Kanwal <rkanwal@rivosinc.com>, palmer@dabbelt.com,
 liwei1518@gmail.com, zhiwei_liu@linux.alibaba.com, bin.meng@windriver.com,
 alistair.francis@wdc.com, Kaiwen Xue <kaiwenx@rivosinc.com>
References: <20240626-smcntrpmf_v7-v7-0-bb0f10af7fa9@rivosinc.com>
 <20240626-smcntrpmf_v7-v7-3-bb0f10af7fa9@rivosinc.com>
Content-Language: en-US
From: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
In-Reply-To: <20240626-smcntrpmf_v7-v7-3-bb0f10af7fa9@rivosinc.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::52a;
 envelope-from=dbarboza@ventanamicro.com; helo=mail-pg1-x52a.google.com
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



On 6/26/24 8:57 PM, Atish Patra wrote:
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
> index 4760cb2cc17f..ef50130a91e7 100644
> --- a/target/riscv/cpu.c
> +++ b/target/riscv/cpu.c
> @@ -178,6 +178,7 @@ const RISCVIsaExtData isa_edata_arr[] = {
>       ISA_EXT_DATA_ENTRY(zhinx, PRIV_VERSION_1_12_0, ext_zhinx),
>       ISA_EXT_DATA_ENTRY(zhinxmin, PRIV_VERSION_1_12_0, ext_zhinxmin),
>       ISA_EXT_DATA_ENTRY(smaia, PRIV_VERSION_1_12_0, ext_smaia),
> +    ISA_EXT_DATA_ENTRY(smcntrpmf, PRIV_VERSION_1_12_0, ext_smcntrpmf),
>       ISA_EXT_DATA_ENTRY(smepmp, PRIV_VERSION_1_12_0, ext_smepmp),
>       ISA_EXT_DATA_ENTRY(smstateen, PRIV_VERSION_1_12_0, ext_smstateen),
>       ISA_EXT_DATA_ENTRY(ssaia, PRIV_VERSION_1_12_0, ext_ssaia),
> @@ -1467,6 +1468,7 @@ const char *riscv_get_misa_ext_description(uint32_t bit)
>   const RISCVCPUMultiExtConfig riscv_cpu_extensions[] = {
>       /* Defaults for standard extensions */
>       MULTI_EXT_CFG_BOOL("sscofpmf", ext_sscofpmf, false),
> +    MULTI_EXT_CFG_BOOL("smcntrpmf", ext_smcntrpmf, false),
>       MULTI_EXT_CFG_BOOL("zifencei", ext_zifencei, true),
>       MULTI_EXT_CFG_BOOL("zicsr", ext_zicsr, true),
>       MULTI_EXT_CFG_BOOL("zihintntl", ext_zihintntl, true),
> diff --git a/target/riscv/cpu_cfg.h b/target/riscv/cpu_cfg.h
> index fb7eebde523b..b1376beb1dab 100644
> --- a/target/riscv/cpu_cfg.h
> +++ b/target/riscv/cpu_cfg.h
> @@ -74,6 +74,7 @@ struct RISCVCPUConfig {
>       bool ext_ztso;
>       bool ext_smstateen;
>       bool ext_sstc;
> +    bool ext_smcntrpmf;
>       bool ext_svadu;
>       bool ext_svinval;
>       bool ext_svnapot;
> 

