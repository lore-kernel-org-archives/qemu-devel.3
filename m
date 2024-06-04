Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 59F32C25B78
	for <qemu-devel@archiver.kernel.org>; Tue,  4 Jun 2024 17:20:33 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sEXpN-0007IX-M4; Tue, 04 Jun 2024 13:20:05 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jason.chien@sifive.com>)
 id 1sEXpK-0007Hf-Tu
 for qemu-devel@nongnu.org; Tue, 04 Jun 2024 13:20:02 -0400
Received: from mail-pl1-x634.google.com ([2607:f8b0:4864:20::634])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <jason.chien@sifive.com>)
 id 1sEXpI-00067V-Sg
 for qemu-devel@nongnu.org; Tue, 04 Jun 2024 13:20:02 -0400
Received: by mail-pl1-x634.google.com with SMTP id
 d9443c01a7336-1f4a0050b9aso39419145ad.2
 for <qemu-devel@nongnu.org>; Tue, 04 Jun 2024 10:20:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sifive.com; s=google; t=1717521599; x=1718126399; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=jf8V2G+zkH1Eh0z+TMRohmsd+ubQzWHLlUMuLjBGtXU=;
 b=lTdhDxXvrG635tVKqD/T3fkgkYOaTczssmmy9U24LRYmgeumD7cvjTGjy1mF/SfQ20
 Xanx/4QZyi4HL9bVW+NVaYfUxJ8/dLicsIkll5U87REMW29XkCqQZfkcPxVvXoOQXsLD
 VqBK19XSQ3GzfrmkufnDEZ7fFsmvXD52GjnQZ5eyWPZ/6E7jN6YbqMVT7PuGomWHWwFQ
 +r/6ClvVwXsLQ2nvzHU8jg3E2BtQhXBzW/jORiyu8SYI7l1/vffrIHJGlotF1u0jIDSN
 dLUuQEIQKUlB595iQDWklrTD8OtnIN75CVn1yV/NxohEaDBSNLSH+XLjTKNoQhl1qglt
 Vdsw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1717521599; x=1718126399;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=jf8V2G+zkH1Eh0z+TMRohmsd+ubQzWHLlUMuLjBGtXU=;
 b=Z3JMyUcu8fRCI5Mb0HzZvPHL4/8uM6UMalod9Kosfy2bZJlV/oSJi3HpkUDiP3+0o0
 o/7LWa7fz/8MOTBu0Fs6J/kJ6CMCjdPSlYbMLDMBeIHM2xKEsm33+XmmBdoaU+fChVex
 7PsJF9HzYQse8HVJ86SjpI2g066rYd083Tqv21Hvd5ZS4H0oOt460rg8Yc7/hED2W0rp
 etzODUuImWjihrqCMkp1ZVAEJE6l6Us0oq1yTZXazhMR/UE5z1AKhgXV5vS30TBf5oiC
 v2a++EvpT8bIOmDNamMRnjIjieziNxCpw4I4s5xlprvfOJJujndYnjfhFo92aQAqLJfV
 7yvg==
X-Forwarded-Encrypted: i=1;
 AJvYcCUe51LBL/Wn5F/Fk5r/bkmmeyq/rTTC+8vqvLtbr2OU5cEwpjUzgeuD1vFFHv8Ke8IpHKJ8chKkG1XzMJyWGKCwrbmVnL8=
X-Gm-Message-State: AOJu0YwlQZcFreRySH7/Cis9/QuzK7ZeQmDxaVG7DHo7+fUuJSV8g6oh
 eRaCh4qQq7XfjkzxDbQBL0/BKCIiLzi9EbEhf+KmpIlfltJRQk9AApT6Zm/9dbIZ8P3t1dn+CiM
 7ga0=
X-Google-Smtp-Source: AGHT+IHbUyudy0a5/6qpBIHQlTQ2bcF79JpU0zFp++LJRpHceaHvaq3eL2iXj6Sv2IXVzqeqRfMibA==
X-Received: by 2002:a17:902:e5ca:b0:1f6:7e02:6af2 with SMTP id
 d9443c01a7336-1f6a5a0e77fmr1854685ad.22.1717521598920; 
 Tue, 04 Jun 2024 10:19:58 -0700 (PDT)
Received: from [192.168.100.252] (59-124-168-89.hinet-ip.hinet.net.
 [59.124.168.89]) by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-1f63235f88dsm87118515ad.88.2024.06.04.10.19.56
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 04 Jun 2024 10:19:58 -0700 (PDT)
Message-ID: <71bc36b9-cc17-4036-91b2-e7ddd81f0c07@sifive.com>
Date: Wed, 5 Jun 2024 01:19:55 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 5/6] target/riscv: Add CTR sctrclr instruction.
To: Rajnesh Kanwal <rkanwal@rivosinc.com>, qemu-riscv@nongnu.org,
 qemu-devel@nongnu.org
Cc: alistair.francis@wdc.com, bin.meng@windriver.com, liweiwei@iscas.ac.cn,
 dbarboza@ventanamicro.com, zhiwei_liu@linux.alibaba.com,
 atishp@rivosinc.com, apatel@ventanamicro.com, beeman@rivosinc.com,
 tech-control-transfer-records@lists.riscv.org
References: <20240529160950.132754-1-rkanwal@rivosinc.com>
 <20240529160950.132754-6-rkanwal@rivosinc.com>
Content-Language: en-US
From: Jason Chien <jason.chien@sifive.com>
In-Reply-To: <20240529160950.132754-6-rkanwal@rivosinc.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::634;
 envelope-from=jason.chien@sifive.com; helo=mail-pl1-x634.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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


Rajnesh Kanwal 於 2024/5/30 上午 12:09 寫道:
> CTR extension adds a new instruction sctrclr to quickly
> clear the recorded entries buffer.
>
> Signed-off-by: Rajnesh Kanwal <rkanwal@rivosinc.com>
> ---
>   target/riscv/cpu.h                             |  1 +
>   target/riscv/cpu_helper.c                      |  7 +++++++
>   target/riscv/insn32.decode                     |  1 +
>   target/riscv/insn_trans/trans_privileged.c.inc | 10 ++++++++++
>   target/riscv/op_helper.c                       |  5 +++++
>   5 files changed, 24 insertions(+)
>
> diff --git a/target/riscv/cpu.h b/target/riscv/cpu.h
> index a294a5372a..fade71aa09 100644
> --- a/target/riscv/cpu.h
> +++ b/target/riscv/cpu.h
> @@ -572,6 +572,7 @@ void riscv_cpu_set_mode(CPURISCVState *env, target_ulong newpriv, bool virt_en);
>   void riscv_ctr_freeze(CPURISCVState *env, uint64_t freeze_mask);
>   void riscv_ctr_add_entry(CPURISCVState *env, target_long src, target_long dst,
>                            uint64_t type, target_ulong prev_priv, bool prev_virt);
> +void riscv_ctr_clear(CPURISCVState *env);
>   
>   void riscv_translate_init(void);
>   G_NORETURN void riscv_raise_exception(CPURISCVState *env,
> diff --git a/target/riscv/cpu_helper.c b/target/riscv/cpu_helper.c
> index e064a7306e..45502f50a7 100644
> --- a/target/riscv/cpu_helper.c
> +++ b/target/riscv/cpu_helper.c
> @@ -704,6 +704,13 @@ void riscv_ctr_freeze(CPURISCVState *env, uint64_t freeze_mask)
>       }
>   }
>   
> +void riscv_ctr_clear(CPURISCVState *env)
> +{
> +    memset(env->ctr_src, 0x0, sizeof(env->ctr_src));
> +    memset(env->ctr_dst, 0x0, sizeof(env->ctr_dst));
> +    memset(env->ctr_data, 0x0, sizeof(env->ctr_data));
> +}
> +
>   static uint64_t riscv_ctr_priv_to_mask(target_ulong priv, bool virt)
>   {
>       switch (priv) {
> diff --git a/target/riscv/insn32.decode b/target/riscv/insn32.decode
> index 9cb1a1b4ec..d3d38c7c68 100644
> --- a/target/riscv/insn32.decode
> +++ b/target/riscv/insn32.decode
> @@ -107,6 +107,7 @@
>   # *** Privileged Instructions ***
>   ecall       000000000000     00000 000 00000 1110011
>   ebreak      000000000001     00000 000 00000 1110011
> +sctrclr     000100000100     00000 000 00000 1110011
>   uret        0000000    00010 00000 000 00000 1110011
>   sret        0001000    00010 00000 000 00000 1110011
>   mret        0011000    00010 00000 000 00000 1110011
> diff --git a/target/riscv/insn_trans/trans_privileged.c.inc b/target/riscv/insn_trans/trans_privileged.c.inc
> index 339d659151..dd9da8651f 100644
> --- a/target/riscv/insn_trans/trans_privileged.c.inc
> +++ b/target/riscv/insn_trans/trans_privileged.c.inc
> @@ -69,6 +69,16 @@ static bool trans_ebreak(DisasContext *ctx, arg_ebreak *a)
>       return true;
>   }
>   
> +static bool trans_sctrclr(DisasContext *ctx, arg_sctrclr *a)
> +{
> +#ifndef CONFIG_USER_ONLY
If both of smctr and ssctr are not enabled, it is an illegal instruction.
> +    gen_helper_ctr_clear(tcg_env);
> +    return true;
> +#else
> +    return false;
> +#endif
> +}
> +
>   static bool trans_uret(DisasContext *ctx, arg_uret *a)
>   {
>       return false;
> diff --git a/target/riscv/op_helper.c b/target/riscv/op_helper.c
> index c8053d9c2f..89423c04b3 100644
> --- a/target/riscv/op_helper.c
> +++ b/target/riscv/op_helper.c
> @@ -461,6 +461,11 @@ void helper_ctr_branch(CPURISCVState *env, target_ulong src, target_ulong dest,
>       }
>   }
>   
> +void helper_ctr_clear(CPURISCVState *env)
> +{

There should be some checks here.
The spec states:
SCTRCLR raises an illegal-instruction exception in U-mode, and a 
virtual-instruction exception in VU-mode, unless CTR state enable access 
restrictions apply.

I don't quite understand "unless CTR state enable access restrictions 
apply" though.

> +    riscv_ctr_clear(env);
> +}
> +
>   void helper_wfi(CPURISCVState *env)
>   {
>       CPUState *cs = env_cpu(env);

