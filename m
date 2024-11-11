Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CF2D7D3ABD3
	for <qemu-devel@archiver.kernel.org>; Mon, 11 Nov 2024 17:44:24 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tAYRZ-0006nb-Ul; Mon, 11 Nov 2024 12:43:17 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dbarboza@ventanamicro.com>)
 id 1tAYRW-0006mt-78
 for qemu-devel@nongnu.org; Mon, 11 Nov 2024 12:43:14 -0500
Received: from mail-pl1-x629.google.com ([2607:f8b0:4864:20::629])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <dbarboza@ventanamicro.com>)
 id 1tAYRS-0003DF-4b
 for qemu-devel@nongnu.org; Mon, 11 Nov 2024 12:43:13 -0500
Received: by mail-pl1-x629.google.com with SMTP id
 d9443c01a7336-20cf3e36a76so48879135ad.0
 for <qemu-devel@nongnu.org>; Mon, 11 Nov 2024 09:43:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=ventanamicro.com; s=google; t=1731346979; x=1731951779; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=YMPIY50XhnFA62zxJqZgs8OUE0v6135TnZmIse/sfdI=;
 b=Eo/xzDfQlIPj/Rfl4i8ixWWllOj4CcaP2Qgzr6pHLvYm0eqOVUPBrOf9iDD+eo/Kvq
 261fxxjoHhAdbRCFDISz4LLUqZjIzzaaHTX7PH8Um31ktDkTOpha9yPlaT7LiRypeABU
 zuhgXmRgdiYtz3SZ0dCCcbljf87i5oJD+xfRkbFtxacg3oFg9PS1Xur21us78llzpSOR
 XtZYC9Ia02mczpOp9HxQRllAIb7/qQDmpOqBK9xgjaFPr6PCArXOInW0OTwlnXxDDm6y
 mNmnGLnhRsnTtSeCiLieAHYeZ3OvkJRDXwfrVXJiqJJmbgFmuzOAmAbuhj7H1AX0HOSV
 KBhw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1731346979; x=1731951779;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=YMPIY50XhnFA62zxJqZgs8OUE0v6135TnZmIse/sfdI=;
 b=GFxYXzQ50A5BNaNw5MjsGfVbEa3XvraYdYpBgC5ohKgA+gWA20Wl0csQPMYDmLvdGe
 AyT3m2jreDc1Tc81CP294dxRbMU4OHncZXchhvU/1cmSi07Pral1dOmRrYUROdbX5oc6
 Mw38hfWNd2lfC7HI6NBfdlRO9vfe4csAwEGbCj+26mUQRG6IyLFwlIIzxUKN78mUO3P0
 20F+nIYzVZKYG+eDXb922ubEpvOnbm1yHGMBbftupnwNIzz9GXhwppCTKcMLa6PwUXBH
 635JaCqoq7otWJEVvLTGx6tlMeiVIMTp6esSdkOP/ZjS/zw6csdWtCpb/JiZ3CFSm8Cr
 ciiA==
X-Forwarded-Encrypted: i=1;
 AJvYcCWdpZHLgago82OdSWvPKPBGHIeHQSVQMtenwQs7WDKqQ3u2u3uf43sEDAGx2c6rCeAT38FQWU0CFa0e@nongnu.org
X-Gm-Message-State: AOJu0YzZdu0x8lgo96a9iafoJlsS2u+u3WPVcJYhbjVeJJOkXkSrz5OM
 c7xNQObRrOBA537pqM5COpfQkiG9udjdzgJvPGzm6DBnnlh33n8G/AE++PtbeUM=
X-Google-Smtp-Source: AGHT+IHXFugUuXXpRWyM9oM4lzbFfp3w+vlviWW+vh4U46R+nVUZUc+0eWYiphrGiibJkqcJuJwESg==
X-Received: by 2002:a17:902:ea12:b0:20b:8ef3:67a with SMTP id
 d9443c01a7336-211834f39acmr210100645ad.7.1731346979340; 
 Mon, 11 Nov 2024 09:42:59 -0800 (PST)
Received: from [192.168.68.110] ([189.79.22.174])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-21177e68960sm78780525ad.220.2024.11.11.09.42.46
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 11 Nov 2024 09:42:58 -0800 (PST)
Message-ID: <364835b0-40a3-43be-a2c0-a60c27ac14cd@ventanamicro.com>
Date: Mon, 11 Nov 2024 14:42:45 -0300
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 2/5] target/riscv: Support senvcfg[UKTE] bit when
 svukte extension is enabled
To: "Fea.Wang" <fea.wang@sifive.com>, qemu-devel@nongnu.org,
 qemu-riscv@nongnu.org
Cc: Palmer Dabbelt <palmer@dabbelt.com>,
 Alistair Francis <alistair.francis@wdc.com>, Bin Meng <bmeng.cn@gmail.com>,
 Weiwei Li <liwei1518@gmail.com>, Liu Zhiwei <zhiwei_liu@linux.alibaba.com>,
 Frank Chang <frank.chang@sifive.com>, Jim Shu <jim.shu@sifive.com>
References: <20241108085239.2927152-1-fea.wang@sifive.com>
 <20241108085239.2927152-3-fea.wang@sifive.com>
Content-Language: en-US
From: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
In-Reply-To: <20241108085239.2927152-3-fea.wang@sifive.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::629;
 envelope-from=dbarboza@ventanamicro.com; helo=mail-pl1-x629.google.com
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



On 11/8/24 5:52 AM, Fea.Wang wrote:
> Svukte extension add UKTE bit, bit[8] in senvcfg CSR. The bit will be
> supported when the svukte extension is enabled.
> 
> When senvcfg[UKTE] bit is set, the memory access from U-mode should do
> the svukte check only except HLV/HLVX/HSV H-mode instructions which
> depend on hstatus[HUKTE].
> 
> Signed-off-by: Fea.Wang <fea.wang@sifive.com>
> Reviewed-by: Frank Chang <frank.chang@sifive.com>
> Reviewed-by: Jim Shu <jim.shu@sifive.com>
> ---

Reviewed-by: Daniel Henrique Barboza <dbarboza@ventanamicro.com>

>   target/riscv/cpu_bits.h | 1 +
>   target/riscv/csr.c      | 4 ++++
>   2 files changed, 5 insertions(+)
> 
> diff --git a/target/riscv/cpu_bits.h b/target/riscv/cpu_bits.h
> index 385a2c67c2..4b9f899217 100644
> --- a/target/riscv/cpu_bits.h
> +++ b/target/riscv/cpu_bits.h
> @@ -785,6 +785,7 @@ typedef enum RISCVException {
>   #define SENVCFG_CBIE                       MENVCFG_CBIE
>   #define SENVCFG_CBCFE                      MENVCFG_CBCFE
>   #define SENVCFG_CBZE                       MENVCFG_CBZE
> +#define SENVCFG_UKTE                       BIT(8)
>   
>   #define HENVCFG_FIOM                       MENVCFG_FIOM
>   #define HENVCFG_LPE                        MENVCFG_LPE
> diff --git a/target/riscv/csr.c b/target/riscv/csr.c
> index 9846770820..1936a6f32a 100644
> --- a/target/riscv/csr.c
> +++ b/target/riscv/csr.c
> @@ -2453,6 +2453,10 @@ static RISCVException write_senvcfg(CPURISCVState *env, int csrno,
>           mask |= SENVCFG_SSE;
>       }
>   
> +    if (env_archcpu(env)->cfg.ext_svukte) {
> +        mask |= SENVCFG_UKTE;
> +    }
> +
>       env->senvcfg = (env->senvcfg & ~mask) | (val & mask);
>       return RISCV_EXCP_NONE;
>   }

