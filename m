Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CF76FC04FFE
	for <qemu-devel@archiver.kernel.org>; Sat, 11 May 2024 14:43:59 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s5nw5-0000Un-Gu; Sat, 11 May 2024 10:42:53 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <liwei1518@gmail.com>)
 id 1s5nvT-0000Qc-7e; Sat, 11 May 2024 10:42:16 -0400
Received: from mail-pf1-x42b.google.com ([2607:f8b0:4864:20::42b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <liwei1518@gmail.com>)
 id 1s5nvQ-0002vB-4G; Sat, 11 May 2024 10:42:13 -0400
Received: by mail-pf1-x42b.google.com with SMTP id
 d2e1a72fcca58-6f47787a0c3so2703862b3a.0; 
 Sat, 11 May 2024 07:42:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1715438529; x=1716043329; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=v4o7IfUNDFyqh1Ty4pyWiw8cej2kMpp85wO2vbWdQdU=;
 b=RMXGvWl9G8YWWI8bXIQHBN0NF6FtLQ4vKNhMlMhablzrZgBLZvargOpMZ0GgI1WHmp
 YJvQtYpCsmJEWCVgTP95dguXciggE0qgtQesLEyGvDqJFXszlbiykgmRYvAvdRD6xrWi
 yVO6venn7CC1i5BDkDopfj98wJOISNELgWdPABGPS50aHktsM/J6jYKIPxCbiWHk9yBH
 fZrmTBLZAY2iVbWEaxV4+9ZzGGu98l+89+JnsP7Ijq7Y3O1YL8XTiPju9W2jFY/kmhqr
 K8nk5Mdzzm6u8rADMQ6ExiqnW/ZIpoBMqa0ed4jqbHAY50EuX+H4jikfx6YJTYfuEksS
 b0ZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1715438529; x=1716043329;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=v4o7IfUNDFyqh1Ty4pyWiw8cej2kMpp85wO2vbWdQdU=;
 b=CFOMN6P7pERkbNfREzDBLhpqTDbbTRepoUrRN2pfeyIyQ2e+wHKOENC3Afl8GU6Lth
 dk3yf3Eimz/IbD3TAPqushEoT1eL/fvTTYEZvelqcH9rEf6ZEqDCz7c9bXW0nOXHqle9
 kxIrOftmid5AWMOLhiJ6M2/zD5o4s4uZu/vGDYJEzabrpIsa8/+hj2n2p4Gu4UxI/Qi2
 87NTL0X0LnriMyN9b6R7bRP9Zsj+if5mEmvOG9FkEoPixvVHsW0a9TAhxvhWVOsaxBvi
 pS6FtQ2WcBal8jgsXmTozfYnumU0XvTPNwxtAq62p62j37mC8hlrvxXlwH+PZNJpUbrg
 eTiA==
X-Forwarded-Encrypted: i=1;
 AJvYcCUvgaEkts3Za/apLKDejynof2RoCw9QBdR+/lWgD3Wx6MtLkg7LT4iKm6/nCLa8PC4xWSSnW3pcB38hr2MdsixBU5U7tDCy/875kjzOyyYDDAKPGRBsNUM3VVghAw==
X-Gm-Message-State: AOJu0Yxy8pUHNDiPEeohmQ6o8ikS1zt6HL70oyM+IWnUxdruKO0eiI9j
 nfEIJKwlAXNH7h9RfbxU7LKnXKiqd9xBo0lFrCvB3IB18kP+I1km
X-Google-Smtp-Source: AGHT+IFZAa6gH72e8YlZVWDS3KTFu/Len4k2D7gRBbDKbS3DFyJ+6IJIU5nG0zirkmjx4m0kkqEYVw==
X-Received: by 2002:a05:6a00:1383:b0:6f3:ee9a:f38b with SMTP id
 d2e1a72fcca58-6f4e026b626mr7021353b3a.6.1715438529152; 
 Sat, 11 May 2024 07:42:09 -0700 (PDT)
Received: from [192.168.0.120] ([114.95.238.28])
 by smtp.gmail.com with ESMTPSA id
 41be03b00d2f7-6340c99b41dsm4786343a12.52.2024.05.11.07.42.05
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sat, 11 May 2024 07:42:08 -0700 (PDT)
Message-ID: <70a1c826-7ff3-4079-abb2-d3c2b042a88f@gmail.com>
Date: Sat, 11 May 2024 22:42:04 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/5] target/riscv: Support the version for ss1p13
To: "Fea.Wang" <fea.wang@sifive.com>, qemu-devel@nongnu.org,
 qemu-riscv@nongnu.org
Cc: Frank Chang <frank.chang@sifive.com>, Palmer Dabbelt
 <palmer@dabbelt.com>, Alistair Francis <alistair.francis@wdc.com>,
 Bin Meng <bin.meng@windriver.com>, Weiwei Li <liwei1518@gmail.com>,
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>,
 Liu Zhiwei <zhiwei_liu@linux.alibaba.com>,
 Andrew Jones <ajones@ventanamicro.com>, Max Chou <max.chou@sifive.com>
References: <20240510065856.2436870-1-fea.wang@sifive.com>
 <20240510065856.2436870-3-fea.wang@sifive.com>
Content-Language: en-US
From: liwei <liwei1518@gmail.com>
In-Reply-To: <20240510065856.2436870-3-fea.wang@sifive.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::42b;
 envelope-from=liwei1518@gmail.com; helo=mail-pf1-x42b.google.com
X-Spam_score_int: -17
X-Spam_score: -1.8
X-Spam_bar: -
X-Spam_report: (-1.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FREEMAIL_ENVFROM_END_DIGIT=0.25, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-Mailman-Approved-At: Sat, 11 May 2024 10:42:47 -0400
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


On 2024/5/10 14:58, Fea.Wang wrote:
> Add RISC-V privilege 1.13 support.
>
> Signed-off-by: Fea.Wang <fea.wang@sifive.com>
> Reviewed-by: Frank Chang <frank.chang@sifive.com>
> ---
>   target/riscv/cpu.c         | 6 +++++-
>   target/riscv/cpu.h         | 4 +++-
>   target/riscv/cpu_cfg.h     | 1 +
>   target/riscv/tcg/tcg-cpu.c | 4 ++++
>   4 files changed, 13 insertions(+), 2 deletions(-)
Reviewed-by:  Weiwei Li <liwei1518@gmail.com>

Weiwei Li
>
> diff --git a/target/riscv/cpu.c b/target/riscv/cpu.c
> index b6b48e5620..a6298c3298 100644
> --- a/target/riscv/cpu.c
> +++ b/target/riscv/cpu.c
> @@ -1773,7 +1773,9 @@ int priv_spec_from_str(const char *priv_spec_str)
>   {
>       int priv_version = -1;
>   
> -    if (!g_strcmp0(priv_spec_str, PRIV_VER_1_12_0_STR)) {
> +    if (!g_strcmp0(priv_spec_str, PRIV_VER_1_13_0_STR)) {
> +        priv_version = PRIV_VERSION_1_13_0;
> +    } else if (!g_strcmp0(priv_spec_str, PRIV_VER_1_12_0_STR)) {
>           priv_version = PRIV_VERSION_1_12_0;
>       } else if (!g_strcmp0(priv_spec_str, PRIV_VER_1_11_0_STR)) {
>           priv_version = PRIV_VERSION_1_11_0;
> @@ -1793,6 +1795,8 @@ const char *priv_spec_to_str(int priv_version)
>           return PRIV_VER_1_11_0_STR;
>       case PRIV_VERSION_1_12_0:
>           return PRIV_VER_1_12_0_STR;
> +    case PRIV_VERSION_1_13_0:
> +        return PRIV_VER_1_13_0_STR;
>       default:
>           return NULL;
>       }
> diff --git a/target/riscv/cpu.h b/target/riscv/cpu.h
> index 7696102697..776939b56b 100644
> --- a/target/riscv/cpu.h
> +++ b/target/riscv/cpu.h
> @@ -96,12 +96,14 @@ extern RISCVCPUProfile *riscv_profiles[];
>   #define PRIV_VER_1_10_0_STR "v1.10.0"
>   #define PRIV_VER_1_11_0_STR "v1.11.0"
>   #define PRIV_VER_1_12_0_STR "v1.12.0"
> +#define PRIV_VER_1_13_0_STR "v1.13.0"
>   enum {
>       PRIV_VERSION_1_10_0 = 0,
>       PRIV_VERSION_1_11_0,
>       PRIV_VERSION_1_12_0,
> +    PRIV_VERSION_1_13_0,
>   
> -    PRIV_VERSION_LATEST = PRIV_VERSION_1_12_0,
> +    PRIV_VERSION_LATEST = PRIV_VERSION_1_13_0,
>   };
>   
>   #define VEXT_VERSION_1_00_0 0x00010000
> diff --git a/target/riscv/cpu_cfg.h b/target/riscv/cpu_cfg.h
> index e1e4f32698..fb7eebde52 100644
> --- a/target/riscv/cpu_cfg.h
> +++ b/target/riscv/cpu_cfg.h
> @@ -136,6 +136,7 @@ struct RISCVCPUConfig {
>        * TCG always implement/can't be user disabled,
>        * based on spec version.
>        */
> +    bool has_priv_1_13;
>       bool has_priv_1_12;
>       bool has_priv_1_11;
>   
> diff --git a/target/riscv/tcg/tcg-cpu.c b/target/riscv/tcg/tcg-cpu.c
> index faa8de9b83..a9d188a9fd 100644
> --- a/target/riscv/tcg/tcg-cpu.c
> +++ b/target/riscv/tcg/tcg-cpu.c
> @@ -320,6 +320,10 @@ static void riscv_cpu_update_named_features(RISCVCPU *cpu)
>           cpu->cfg.has_priv_1_12 = true;
>       }
>   
> +    if (cpu->env.priv_ver >= PRIV_VERSION_1_13_0) {
> +        cpu->cfg.has_priv_1_13 = true;
> +    }
> +
>       /* zic64b is 1.12 or later */
>       cpu->cfg.ext_zic64b = cpu->cfg.cbom_blocksize == 64 &&
>                             cpu->cfg.cbop_blocksize == 64 &&

