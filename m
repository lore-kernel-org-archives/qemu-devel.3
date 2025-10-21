Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B4E61CCD184
	for <qemu-devel@archiver.kernel.org>; Tue, 21 Oct 2025 11:14:07 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vBAJG-0005a0-PI; Tue, 21 Oct 2025 07:13:47 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dbarboza@ventanamicro.com>)
 id 1vBAIv-0005Yl-FW
 for qemu-devel@nongnu.org; Tue, 21 Oct 2025 07:13:28 -0400
Received: from mail-pj1-x1030.google.com ([2607:f8b0:4864:20::1030])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <dbarboza@ventanamicro.com>)
 id 1vBAIt-000516-9y
 for qemu-devel@nongnu.org; Tue, 21 Oct 2025 07:13:25 -0400
Received: by mail-pj1-x1030.google.com with SMTP id
 98e67ed59e1d1-339d7c403b6so5078680a91.2
 for <qemu-devel@nongnu.org>; Tue, 21 Oct 2025 04:13:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=ventanamicro.com; s=google; t=1761045201; x=1761650001; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=isaywI8wwFAVg96R8DoWDFc1d+n9gu7Omb7H2i8/yJo=;
 b=pjbTfJMnYhK0yR1C6EYIcCy1sgDzkkGDad8+jQ6yU62YEN9oDArJ7ezyJ5SKYf7xR2
 dnsLhGRgI8cpnseKU524VJIIb6XKKp2oyqv1jDmh8mD54B3QLqiKVDENTdUu+Up5Ql7z
 AWdBW7MwVLdiFzX4Nf0oqMV8TzA4Bfqs6gUcoD+MhVvZTRsUIcPfCKdxiuAW8v0VifbP
 19EkS2q9D2NHFJCa5ViAyXztFOOs/6maluSXf21FALc3dzuVwdVlMMbLVRg930Hpnc67
 eMTyrs3xiKSCwESEv7QenctMO4uVgXVvM0AGBTgB4ZvmgG9PzwFQtJp0MZUOq1zSIIoy
 7Vww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1761045201; x=1761650001;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=isaywI8wwFAVg96R8DoWDFc1d+n9gu7Omb7H2i8/yJo=;
 b=EaSxN42TW4VG2L+hsg8o/nQqwMhYNz7XN77AnCy/cLRm+VP8X+Tb5uH4HgNph6G3O0
 veW0q6K41HbwSt02T7GMna8Qd8+X7eRSDhPmbltZeOMui6oO+3CXPFbO6OLIzmO7FRrx
 2wWcKk0ihV1HnkbgqrEg8jMo7LBVTK0ttgtQvmmGGLSTWtsrwgwHq2+2gkP42r9nSKq7
 Ugarty6RK78ZDjDS5doGFhVirPs93wdrtoh8mkNIWs3AdPOICLsgSMWD7NERdkuGGkIB
 mGwszpXVmykRLuxdmx+xoP0vnStGlH5XACUAp5nUCkAxQG2cYTKddzMTt9PULYnLUqYF
 LvcQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCXt+Gx2GnARZCY+baPFwyL8qUwm8+a782GQpQ7jVjC689yYun3me/y3P8yHvCM9n1KgfIHB+JfRBOiJ@nongnu.org
X-Gm-Message-State: AOJu0YxfTiJRLNLzWtLOcxOs1PuNWO7Gr2+Bg9/4bVEiEucmwJurcgWa
 IiLVafBvNSvfbqeKVpJ5cTICkGJ86KDf2r5DhQI8/eTvCNckdszZCCk1R4fYUxzNX7LRGBWx5+g
 JYB8MWQM=
X-Gm-Gg: ASbGncvkaGy8eOIYZsK6xPwkLnHRs1gTqkvYAUy5h8Ap52VmuT5f+zVdkPsWylyNn3O
 74O+/rk/z310fnJUSm74+W/pwHuYajbuCs1qRdVNiusr+5LJK5AmB2CLkOaXUMcOGDkdF2tL8j9
 Vbpz9mmiPX3byrXIwql4ze1JhroRqPw0o8m7iN4HJzX3ZYy33b+YtZQ/g4ioKCZq5NBQXEc/lsQ
 b7V1A83goR4kDdEyT9hK6n34FAAHxPAl7BZYg3jdBlrc75E6Ohs/jmNLV7UCggio5E+SBLdPSXQ
 +g5+gujt/CPSBSmQu+WVKXEWo/li7Qea3Cgt/wjPRVNW9gVp45xRfSQuOrVCGMBDyVrP0SN0zcf
 1zF19WL/VfGeuaCxdcdNzzPURUGvXXboF8G8iKm26b72xJa0n1F3/xu4wV01RO8g2G+6BNDANc1
 N1LkEtK97zcwQ9
X-Google-Smtp-Source: AGHT+IGQkiiuz4XhZXiu5WxkhqFVxIRgQ6YyOURrx11oOZquPCiexJIkP43HpAQ8roEBRBPBEUk6/A==
X-Received: by 2002:a17:90b:5291:b0:32e:859:c79 with SMTP id
 98e67ed59e1d1-33bcec1ab25mr21011080a91.0.1761045201025; 
 Tue, 21 Oct 2025 04:13:21 -0700 (PDT)
Received: from [192.168.68.110] ([189.38.141.22])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-33d5ddf16bcsm10703503a91.4.2025.10.21.04.13.18
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 21 Oct 2025 04:13:20 -0700 (PDT)
Message-ID: <90a3f6d0-3249-4f7a-9426-8aaf0146621a@ventanamicro.com>
Date: Tue, 21 Oct 2025 08:13:15 -0300
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] target/riscv: Fix a uninitialized variable warning
To: Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>, qemu-devel@nongnu.org
Cc: Palmer Dabbelt <palmer@dabbelt.com>,
 Alistair Francis <alistair.francis@wdc.com>, Weiwei Li
 <liwei1518@gmail.com>, Liu Zhiwei <zhiwei_liu@linux.alibaba.com>,
 qemu-riscv@nongnu.org
References: <20251021-vlen-v2-1-1fb581d4c6bf@rsg.ci.i.u-tokyo.ac.jp>
From: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
Content-Language: en-US
In-Reply-To: <20251021-vlen-v2-1-1fb581d4c6bf@rsg.ci.i.u-tokyo.ac.jp>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::1030;
 envelope-from=dbarboza@ventanamicro.com; helo=mail-pj1-x1030.google.com
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



On 10/21/25 2:07 AM, Akihiko Odaki wrote:
> riscv_cpu_validate_v() left its variable, min_vlen, uninitialized if
> no vector extension is available, causing a compiler warning.
> 
> Re-define riscv_cpu_validate_v() as no-op when no vector extension is
> available to prevent the scenario that will read the unintialized
> variable by construction. It also simplifies its caller as a bonus.
> 
> Signed-off-by: Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>
> ---

Reviewed-by: Daniel Henrique Barboza <dbarboza@ventanamicro.com>


> Changes in v2:
> - De-duplicated zve32f checks as suggested by Daniel Henrique Barboza.
> - Link to v1: https://lore.kernel.org/qemu-devel/20251019-vlen-v1-1-f7352a402f06@rsg.ci.i.u-tokyo.ac.jp
> ---
>   target/riscv/tcg/tcg-cpu.c | 12 ++++++------
>   1 file changed, 6 insertions(+), 6 deletions(-)
> 
> diff --git a/target/riscv/tcg/tcg-cpu.c b/target/riscv/tcg/tcg-cpu.c
> index 1150bd14697c..d3968251fad5 100644
> --- a/target/riscv/tcg/tcg-cpu.c
> +++ b/target/riscv/tcg/tcg-cpu.c
> @@ -426,6 +426,8 @@ static void riscv_cpu_validate_v(CPURISCVState *env, RISCVCPUConfig *cfg,
>           min_vlen = 64;
>       } else if (cfg->ext_zve32x) {
>           min_vlen = 32;
> +    } else {
> +        return;
>       }
>   
>       if (vlen > RV_VLEN_MAX || vlen < min_vlen) {
> @@ -676,12 +678,10 @@ void riscv_cpu_validate_set_extensions(RISCVCPU *cpu, Error **errp)
>           return;
>       }
>   
> -    if (cpu->cfg.ext_zve32x) {
> -        riscv_cpu_validate_v(env, &cpu->cfg, &local_err);
> -        if (local_err != NULL) {
> -            error_propagate(errp, local_err);
> -            return;
> -        }
> +    riscv_cpu_validate_v(env, &cpu->cfg, &local_err);
> +    if (local_err != NULL) {
> +        error_propagate(errp, local_err);
> +        return;
>       }
>   
>       /* The Zve64d extension depends on the Zve64f extension */
> 
> ---
> base-commit: c85ba2d7a4056595166689890285105579db446a
> change-id: 20251019-vlen-30a57c03bd93
> 
> Best regards,
> --
> Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>
> 


