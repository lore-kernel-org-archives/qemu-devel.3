Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5DF68C04FFE
	for <qemu-devel@archiver.kernel.org>; Sat, 11 May 2024 14:46:25 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s5nzN-0004ed-0n; Sat, 11 May 2024 10:46:17 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <liwei1518@gmail.com>)
 id 1s5nzJ-0004e1-HH; Sat, 11 May 2024 10:46:15 -0400
Received: from mail-pl1-x631.google.com ([2607:f8b0:4864:20::631])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <liwei1518@gmail.com>)
 id 1s5nzF-0003PY-QU; Sat, 11 May 2024 10:46:12 -0400
Received: by mail-pl1-x631.google.com with SMTP id
 d9443c01a7336-1ed96772f92so25285825ad.0; 
 Sat, 11 May 2024 07:46:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1715438768; x=1716043568; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=4mHeM8v46H5GqBx8ufyPG6XyaVrl3itP3tCb1h5Q0Hk=;
 b=KawPyY0X+cRG0QrG8tAzxJEbRrP1cL5H10nPYs7aZXa/3fH5MweHroSRpntrvR3GZb
 lXOrwgs8+tZZEzCOojUuAAE73Dy1lmbWe8USgHvEVQCm7W6gCDe0j0LZaJI2LLScyHO6
 eybNI8tHAacMJPLKEbor962UeFAG1fYYjW/Zx228N82qHEAxeOAvL2gzU+LPmDN3OpAD
 tyPUEZLrVAZWKEqmPpxeq+HLwhN60IB7RqnVJW1CU4ZS6WwRC47CG6Y1AHDJyoIQoqxx
 VLQ9co0VHwQ2N22rK8zSLpmhlc4+yYkMR7dFRSyBu/53Gd3sOUHaUxFs/N8qVSsz4MCU
 68JA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1715438768; x=1716043568;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=4mHeM8v46H5GqBx8ufyPG6XyaVrl3itP3tCb1h5Q0Hk=;
 b=BfUT6TXNLe24OpxX+BYT/HpKNIPKH8dTTKjTaxvatI+mjITaG47ug7kwi9PVgg4RBN
 mHbRI8gea5gER5EzNxHh0Rn/Pzk2rsm2Jo7Xr0lhr0ODbOWKrRkUKhH9738OSD+ohY6f
 e5irEnaYWKVooqIC/xda/t6BlkVTgZCUBmgA04QWeoKoCadhgsgc3C9MQPTbs41Kmc/l
 P8y000AZSjIuOt1UgT/V8Fu/bJJNchRqdrWi6D7aSLsc3qPI6xfgZxBIsgyzSP88GZQE
 q9T794BgYhIC2boQoFrgWf6vjHxwEqs4t0Oy5ihawwefYP3SSL0asczHBT/Jv+glUQfY
 N7+w==
X-Forwarded-Encrypted: i=1;
 AJvYcCXHR5JiTI9uvSOGqsMjbcUfg/7YCpoGixfS4LWfvQLmObX8SY2I53b2swJoDxAayFo6qkKXSQ8GpNwv44cMjwZ5T9UzsSW/it5oPd8BGxTt30fkzuf9A4CZNdKxAg==
X-Gm-Message-State: AOJu0YznpL66e2tXQZvd6yoyx8gK8nlJYGyctCW6Q0U2Iy2MW/dls997
 c//SIpafVgoNJU6PePVDvUcFrKQxaCDfs3ZNCd62dDrC77pFcdh6
X-Google-Smtp-Source: AGHT+IHUD/rFfTgTMwuGDaZ34AgDLv8VRvMRr3bleX168NoEA5Mj8AI+q/RsY0oaNu2a8daLVntsTA==
X-Received: by 2002:a17:902:6e01:b0:1eb:51a4:3685 with SMTP id
 d9443c01a7336-1ef4404944emr54609265ad.52.1715438767864; 
 Sat, 11 May 2024 07:46:07 -0700 (PDT)
Received: from [192.168.0.120] ([114.95.238.28])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-1ef0c264e68sm49708435ad.302.2024.05.11.07.46.04
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sat, 11 May 2024 07:46:07 -0700 (PDT)
Message-ID: <fa17c12e-18d9-42b9-a58f-df05fae294fa@gmail.com>
Date: Sat, 11 May 2024 22:46:02 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 3/5] target/riscv: Add 'P1P13' bit in SMSTATEEN0
To: "Fea.Wang" <fea.wang@sifive.com>, qemu-devel@nongnu.org,
 qemu-riscv@nongnu.org
Cc: Frank Chang <frank.chang@sifive.com>, Palmer Dabbelt
 <palmer@dabbelt.com>, Alistair Francis <alistair.francis@wdc.com>,
 Bin Meng <bin.meng@windriver.com>, Weiwei Li <liwei1518@gmail.com>,
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>,
 Liu Zhiwei <zhiwei_liu@linux.alibaba.com>
References: <20240510065856.2436870-1-fea.wang@sifive.com>
 <20240510065856.2436870-4-fea.wang@sifive.com>
Content-Language: en-US
From: liwei <liwei1518@gmail.com>
In-Reply-To: <20240510065856.2436870-4-fea.wang@sifive.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::631;
 envelope-from=liwei1518@gmail.com; helo=mail-pl1-x631.google.com
X-Spam_score_int: -17
X-Spam_score: -1.8
X-Spam_bar: -
X-Spam_report: (-1.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FREEMAIL_ENVFROM_END_DIGIT=0.25, FREEMAIL_FROM=0.001,
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


On 2024/5/10 14:58, Fea.Wang wrote:
> Based on privilege 1.13 spec, there should be a bit56 for 'P1P13' in
> SMSTATEEN0 that controls access to the hedeleg.
>
> Signed-off-by: Fea.Wang <fea.wang@sifive.com>
> Reviewed-by: Frank Chang <frank.chang@sifive.com>
> ---
>   target/riscv/cpu_bits.h |  1 +
>   target/riscv/csr.c      | 10 ++++++++++
>   2 files changed, 11 insertions(+)
Reviewed-by:  Weiwei Li <liwei1518@gmail.com>

Weiwei Li
>
> diff --git a/target/riscv/cpu_bits.h b/target/riscv/cpu_bits.h
> index 74318a925c..28bd3fb0b4 100644
> --- a/target/riscv/cpu_bits.h
> +++ b/target/riscv/cpu_bits.h
> @@ -315,6 +315,7 @@
>   #define SMSTATEEN0_CS       (1ULL << 0)
>   #define SMSTATEEN0_FCSR     (1ULL << 1)
>   #define SMSTATEEN0_JVT      (1ULL << 2)
> +#define SMSTATEEN0_P1P13    (1ULL << 56)
>   #define SMSTATEEN0_HSCONTXT (1ULL << 57)
>   #define SMSTATEEN0_IMSIC    (1ULL << 58)
>   #define SMSTATEEN0_AIA      (1ULL << 59)
> diff --git a/target/riscv/csr.c b/target/riscv/csr.c
> index 6b460ee0e8..d844ce770e 100644
> --- a/target/riscv/csr.c
> +++ b/target/riscv/csr.c
> @@ -2248,6 +2248,11 @@ static RISCVException write_mstateen0(CPURISCVState *env, int csrno,
>           wr_mask |= SMSTATEEN0_FCSR;
>       }
>   
> +    RISCVCPU *cpu = env_archcpu(env);
> +    if (cpu->env.priv_ver >= PRIV_VERSION_1_13_0) {
> +        wr_mask |= SMSTATEEN0_P1P13;
> +    }
> +
>       return write_mstateen(env, csrno, wr_mask, new_val);
>   }
>   
> @@ -2283,6 +2288,11 @@ static RISCVException write_mstateen0h(CPURISCVState *env, int csrno,
>   {
>       uint64_t wr_mask = SMSTATEEN_STATEEN | SMSTATEEN0_HSENVCFG;
>   
> +    RISCVCPU *cpu = env_archcpu(env);
> +    if (cpu->env.priv_ver >= PRIV_VERSION_1_13_0) {
> +            wr_mask |= SMSTATEEN0_P1P13;
> +    }
> +
>       return write_mstateenh(env, csrno, wr_mask, new_val);
>   }
>   

