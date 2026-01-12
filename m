Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F3992CF45C2
	for <qemu-devel@archiver.kernel.org>; Mon, 12 Jan 2026 18:29:14 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vfMf7-0000vu-Vl; Mon, 12 Jan 2026 13:29:10 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dbarboza@ventanamicro.com>)
 id 1vfMf6-0000sq-7C
 for qemu-devel@nongnu.org; Mon, 12 Jan 2026 13:29:08 -0500
Received: from mail-qt1-x82b.google.com ([2607:f8b0:4864:20::82b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <dbarboza@ventanamicro.com>)
 id 1vfMf4-0002j0-IP
 for qemu-devel@nongnu.org; Mon, 12 Jan 2026 13:29:07 -0500
Received: by mail-qt1-x82b.google.com with SMTP id
 d75a77b69052e-4ffb41c1efaso41636391cf.0
 for <qemu-devel@nongnu.org>; Mon, 12 Jan 2026 10:28:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=ventanamicro.com; s=google; t=1768242531; x=1768847331; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=W7cIlmBBTH+hM8Dvds0KAl1A/MV6enXgzbc5V1ShsYM=;
 b=DKSFET09EyVI8A0apsxu8kg/nJnEDtKAw6g7TTzuyZzbqQQ0TlWCPINXR6fZYjXZXC
 Wzz89oLKiRtg4wjBdgpImPjoWFB9XnF1nvrHVfnnnaikuq8xXdfIWAItqROHJROxPqVX
 GYtvyYpP0rl34z4Jo7wJj35huLttNOej+mcegIAKaw2/Nrn10AHY1/2xjfCAUMTQqFK3
 FjvSQAjDygo+LeDOcPmmlsOx8WbKtrjo1kcSOxZmr6J5WDbTQLwe+feJM0ajNuB14LOa
 9I1z+ZQEzdXajA2iW5x9uCMQr/stHShLDZ3VrkJhCo+ERq43qsqfO5VahaZ8NZbGmJRy
 uMmg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1768242531; x=1768847331;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=W7cIlmBBTH+hM8Dvds0KAl1A/MV6enXgzbc5V1ShsYM=;
 b=o3twXcfOF6IDp2CtdiaEQUx6290LUjNCcfNnDLNt+vyYhGwst/ssTugQj7LlZ6eKBC
 ShmXV9kIL6ewY8F7VomhfuMZUbuLUOSBMXdrxilmsd/8yzs5MRvkgTb0/qVi/wC5NWl/
 TCOYtWVHSwNbBrVUVqi12hzUGU2yczJrDpJU+nWApi9vm2pQjaAc0j8/+0okOr3CSUx7
 piwTpMKFP/23bPYXDzgvi7EgdPK2D5lpuAYERa3T2vu9/5xWMy+pMAKKJZm9roiN6nTG
 mUtcK1mQrEiWnOux7yzy/rcwaj5f0zv66EoRNsKVwEQAJlfKipw141+ENmnMR9+NjyNb
 l2UA==
X-Forwarded-Encrypted: i=1;
 AJvYcCXElY7taGQ14/gBKvq/QGkZrR6PvzxpJz9VKg7EV7KowtUymCuTkHViN+BJvAWt88g8M7RrNdbtugFl@nongnu.org
X-Gm-Message-State: AOJu0YzA0QoDOirvZrfmiq4vvcr8V8TWs/mEYrf5TJ28OpxIcYdRfYT2
 Ov3aCI4jUxWalhPLNvbf3tnaYH9+X/6YaVHzx1k2pAEKd0mCc29L6iywauhthwQWxpE=
X-Gm-Gg: AY/fxX4XFARBwIHGSY5D5TNUhUdG0RI26JpbZF7NwjUqW0k9fHaZ5aALv+b4tqWRkXg
 mGpaEh/x8N/3D7xpoOrFLLRCi8k/9BDU6Oww99rY+ofVATEud7bRq6rgv9wVGs6Abstx9r9IH/r
 BFdFGHNAk2bR6OBFtiBDJgouZjuLMoH21SD2hL1rgKhbVrL1K7FI6BRMp9oqwKyBKcyhTHeZiZL
 +6SzRJGbYzXW7mIxyq4ocwsk/1df1NyFuUcW5MpkoJrpi5XGAFkvOq4QFsOTpUCr2CKZqtzidE0
 8gJ9pEgeD7Ersau1Lj+oP6EVxfkb/Iabbk2+H100uhD3yb9M9bPPCuUA2fM6iCWgVUywpqp41nS
 sXSO9wIgH9fuzHtPJg7MxpH6mcHA0wA8kela7lcdPZEhNberxg6cUlYpNQhWNRpo1MIH5ogcgIf
 PpnDQXl5acJSMzmjA2tOEA3cUiNRKc5ufCMsxZTwvi
X-Google-Smtp-Source: AGHT+IF40YtGjmUWqM+kb/BARA/ZWtQcJh32cnmxwabPSk9W7ot8LExkX2dELsIOXvOAiOtqjGudRw==
X-Received: by 2002:ac8:584b:0:b0:4f4:c104:9519 with SMTP id
 d75a77b69052e-4ffb499a9fdmr270597631cf.42.1768242530906; 
 Mon, 12 Jan 2026 10:28:50 -0800 (PST)
Received: from [192.168.68.103] ([152.234.121.223])
 by smtp.gmail.com with ESMTPSA id
 d75a77b69052e-4ffa8e5d4c8sm129667611cf.28.2026.01.12.10.28.48
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 12 Jan 2026 10:28:49 -0800 (PST)
Message-ID: <ade8a525-c12c-4de8-9d24-9851181e04fb@ventanamicro.com>
Date: Mon, 12 Jan 2026 15:28:46 -0300
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 5/9] target/riscv: Use the tb->cs_bqse as the extend tb
 flags.
To: Max Chou <max.chou@sifive.com>, qemu-devel@nongnu.org,
 qemu-riscv@nongnu.org
Cc: Palmer Dabbelt <palmer@dabbelt.com>,
 Alistair Francis <alistair.francis@wdc.com>, Weiwei Li
 <liwei1518@gmail.com>, Liu Zhiwei <zhiwei_liu@linux.alibaba.com>
References: <20260108132631.9429-1-max.chou@sifive.com>
 <20260108132631.9429-6-max.chou@sifive.com>
From: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
Content-Language: en-US
In-Reply-To: <20260108132631.9429-6-max.chou@sifive.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::82b;
 envelope-from=dbarboza@ventanamicro.com; helo=mail-qt1-x82b.google.com
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
List-Id: qemu development <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

Note: typo in commit title: 'cs->bqse'

On 1/8/2026 10:26 AM, Max Chou wrote:
> We have more than 32-bits worth of state per TB, so use the
> tb->cs_base, which is otherwise unused for RISC-V, as the extend flag.
> 
> Signed-off-by: Max Chou <max.chou@sifive.com>
> ---

That's a neat idea. I'll use it in my e-trace series in case this series
is merged first.


Reviewed-by: Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>


>   include/exec/translation-block.h | 1 +
>   target/riscv/cpu.h               | 3 +++
>   target/riscv/tcg/tcg-cpu.c       | 7 ++++++-
>   3 files changed, 10 insertions(+), 1 deletion(-)
> 
> diff --git a/include/exec/translation-block.h b/include/exec/translation-block.h
> index 4f83d5bec9..40cc699031 100644
> --- a/include/exec/translation-block.h
> +++ b/include/exec/translation-block.h
> @@ -65,6 +65,7 @@ struct TranslationBlock {
>        * arm: an extension of tb->flags,
>        * s390x: instruction data for EXECUTE,
>        * sparc: the next pc of the instruction queue (for delay slots).
> +     * riscv: an extension of tb->flags,
>        */
>       uint64_t cs_base;
>   
> diff --git a/target/riscv/cpu.h b/target/riscv/cpu.h
> index 962cc45073..4c0676ed53 100644
> --- a/target/riscv/cpu.h
> +++ b/target/riscv/cpu.h
> @@ -703,6 +703,9 @@ FIELD(TB_FLAGS, BCFI_ENABLED, 28, 1)
>   FIELD(TB_FLAGS, PM_PMM, 29, 2)
>   FIELD(TB_FLAGS, PM_SIGNEXTEND, 31, 1)
>   
> +FIELD(EXT_TB_FLAGS, MISA_EXT, 0, 32)
> +FIELD(EXT_TB_FLAGS, ALTFMT, 32, 1)
> +
>   #ifdef TARGET_RISCV32
>   #define riscv_cpu_mxl(env)  ((void)(env), MXL_RV32)
>   #else
> diff --git a/target/riscv/tcg/tcg-cpu.c b/target/riscv/tcg/tcg-cpu.c
> index 720ff0c2a3..378b298886 100644
> --- a/target/riscv/tcg/tcg-cpu.c
> +++ b/target/riscv/tcg/tcg-cpu.c
> @@ -104,6 +104,7 @@ static TCGTBCPUState riscv_get_tb_cpu_state(CPUState *cs)
>       RISCVCPU *cpu = env_archcpu(env);
>       RISCVExtStatus fs, vs;
>       uint32_t flags = 0;
> +    uint64_t ext_flags = 0;
>       bool pm_signext = riscv_cpu_virt_mem_enabled(env);
>   
>       if (cpu->cfg.ext_zve32x) {
> @@ -118,6 +119,7 @@ static TCGTBCPUState riscv_get_tb_cpu_state(CPUState *cs)
>   
>           /* lmul encoded as in DisasContext::lmul */
>           int8_t lmul = sextract32(FIELD_EX64(env->vtype, VTYPE, VLMUL), 0, 3);
> +        uint8_t altfmt = FIELD_EX64(env->vtype, VTYPE, ALTFMT);
>           uint32_t vsew = FIELD_EX64(env->vtype, VTYPE, VSEW);
>           uint32_t vlmax = vext_get_vlmax(cpu->cfg.vlenb, vsew, lmul);
>           uint32_t maxsz = vlmax << vsew;
> @@ -133,6 +135,7 @@ static TCGTBCPUState riscv_get_tb_cpu_state(CPUState *cs)
>           flags = FIELD_DP32(flags, TB_FLAGS, VMA,
>                              FIELD_EX64(env->vtype, VTYPE, VMA));
>           flags = FIELD_DP32(flags, TB_FLAGS, VSTART_EQ_ZERO, env->vstart == 0);
> +        ext_flags = FIELD_DP64(ext_flags, EXT_TB_FLAGS, ALTFMT, altfmt);
>       } else {
>           flags = FIELD_DP32(flags, TB_FLAGS, VILL, 1);
>       }
> @@ -189,10 +192,12 @@ static TCGTBCPUState riscv_get_tb_cpu_state(CPUState *cs)
>       flags = FIELD_DP32(flags, TB_FLAGS, PM_PMM, riscv_pm_get_pmm(env));
>       flags = FIELD_DP32(flags, TB_FLAGS, PM_SIGNEXTEND, pm_signext);
>   
> +    ext_flags = FIELD_DP64(ext_flags, EXT_TB_FLAGS, MISA_EXT, env->misa_ext);
> +
>       return (TCGTBCPUState){
>           .pc = env->xl == MXL_RV32 ? env->pc & UINT32_MAX : env->pc,
>           .flags = flags,
> -        .cs_base = env->misa_ext,
> +        .cs_base = ext_flags,
>       };
>   }
>   


