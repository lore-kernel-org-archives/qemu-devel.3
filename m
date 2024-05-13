Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DC157C25B10
	for <qemu-devel@archiver.kernel.org>; Mon, 13 May 2024 12:15:38 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s6Ua1-0006jV-IO; Mon, 13 May 2024 08:14:57 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhiwei_liu@linux.alibaba.com>)
 id 1s6UZz-0006il-Gk; Mon, 13 May 2024 08:14:56 -0400
Received: from out30-118.freemail.mail.aliyun.com ([115.124.30.118])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhiwei_liu@linux.alibaba.com>)
 id 1s6UZw-0000sk-PB; Mon, 13 May 2024 08:14:55 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linux.alibaba.com; s=default;
 t=1715602488; h=Message-ID:Date:MIME-Version:Subject:To:From:Content-Type;
 bh=LrcHvHPIyppc1Q6BtBKhiT4eE60/hxFLh8TTRdFWio4=;
 b=c0HMduSEmShloWG0XYPaU9mTAiFx+pmw8QBoO0hTY4V1hz69hNL9btf/cb0TGFI3ucjmOsO7rkYImhptkeXaYbmMU8C+zDKuRvDBRcpsjgnotegrWZpOCqN8TAMkiyvTgXZcLJRZjRMgR3YIogD3RJCyyDv8qfWISudmEFcodnA=
X-Alimail-AntiSpam: AC=PASS; BC=-1|-1; BR=01201311R131e4; CH=green; DM=||false|;
 DS=||; FP=0|-1|-1|-1|0|-1|-1|-1; HT=maildocker-contentspam033032014031;
 MF=zhiwei_liu@linux.alibaba.com; NM=1; PH=DS; RN=9; SR=0;
 TI=SMTPD_---0W6QXVUA_1715602485; 
Received: from 30.198.0.184(mailfrom:zhiwei_liu@linux.alibaba.com
 fp:SMTPD_---0W6QXVUA_1715602485) by smtp.aliyun-inc.com;
 Mon, 13 May 2024 20:14:46 +0800
Message-ID: <6a56f942-f346-4737-9ec9-03bf3023d78c@linux.alibaba.com>
Date: Mon, 13 May 2024 20:13:59 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v9 4/6] target/riscv: Add pointer masking tb flags
To: Alexey Baturo <baturo.alexey@gmail.com>
Cc: richard.henderson@linaro.org, space.monkey.delivers@gmail.com,
 palmer@dabbelt.com, Alistair.Francis@wdc.com, sagark@eecs.berkeley.edu,
 kbastian@mail.uni-paderborn.de, qemu-devel@nongnu.org, qemu-riscv@nongnu.org
References: <20240511101053.1875596-1-me@deliversmonkey.space>
 <20240511101053.1875596-5-me@deliversmonkey.space>
Content-Language: en-US
From: LIU Zhiwei <zhiwei_liu@linux.alibaba.com>
In-Reply-To: <20240511101053.1875596-5-me@deliversmonkey.space>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=115.124.30.118;
 envelope-from=zhiwei_liu@linux.alibaba.com;
 helo=out30-118.freemail.mail.aliyun.com
X-Spam_score_int: -174
X-Spam_score: -17.5
X-Spam_bar: -----------------
X-Spam_report: (-17.5 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, ENV_AND_HDR_SPF_MATCH=-0.5,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 UNPARSEABLE_RELAY=0.001, USER_IN_DEF_DKIM_WL=-7.5,
 USER_IN_DEF_SPF_WL=-7.5 autolearn=ham autolearn_force=no
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


On 2024/5/11 18:10, Alexey Baturo wrote:
> From: Alexey Baturo <baturo.alexey@gmail.com>
>
> Signed-off-by: Alexey Baturo <baturo.alexey@gmail.com>
>
> Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
> Reviewed-by: Alistair Francis <alistair.francis@wdc.com>
> ---
>   target/riscv/cpu.h        | 3 +++
>   target/riscv/cpu_helper.c | 3 +++
>   target/riscv/translate.c  | 5 +++++
>   3 files changed, 11 insertions(+)
>
> diff --git a/target/riscv/cpu.h b/target/riscv/cpu.h
> index 9cac723b19..bbf3a0f64e 100644
> --- a/target/riscv/cpu.h
> +++ b/target/riscv/cpu.h
> @@ -564,6 +564,9 @@ FIELD(TB_FLAGS, ITRIGGER, 20, 1)
>   FIELD(TB_FLAGS, VIRT_ENABLED, 21, 1)
>   FIELD(TB_FLAGS, PRIV, 22, 2)
>   FIELD(TB_FLAGS, AXL, 24, 2)
> +/* If pointer masking should be applied and address sign extended */
> +FIELD(TB_FLAGS, PM_PMM, 26, 2)
> +FIELD(TB_FLAGS, PM_SIGNEXTEND, 28, 1)
>   
>   #ifdef TARGET_RISCV32
>   #define riscv_cpu_mxl(env)  ((void)(env), MXL_RV32)
> diff --git a/target/riscv/cpu_helper.c b/target/riscv/cpu_helper.c
> index e4a127ca84..3f2473bd73 100644
> --- a/target/riscv/cpu_helper.c
> +++ b/target/riscv/cpu_helper.c
> @@ -68,6 +68,7 @@ void cpu_get_tb_cpu_state(CPURISCVState *env, vaddr *pc,
>       RISCVCPU *cpu = env_archcpu(env);
>       RISCVExtStatus fs, vs;
>       uint32_t flags = 0;
> +    bool pm_signext = riscv_cpu_virt_mem_enabled(env);
>   
>       *pc = env->xl == MXL_RV32 ? env->pc & UINT32_MAX : env->pc;
>       *cs_base = 0;
> @@ -138,6 +139,8 @@ void cpu_get_tb_cpu_state(CPURISCVState *env, vaddr *pc,
>       flags = FIELD_DP32(flags, TB_FLAGS, VS, vs);
>       flags = FIELD_DP32(flags, TB_FLAGS, XL, env->xl);
>       flags = FIELD_DP32(flags, TB_FLAGS, AXL, cpu_address_xl(env));
> +    flags = FIELD_DP32(flags, TB_FLAGS, PM_PMM, riscv_pm_get_pmm(env));
> +    flags = FIELD_DP32(flags, TB_FLAGS, PM_SIGNEXTEND, pm_signext);
>   
>       *pflags = flags;
>   }
> diff --git a/target/riscv/translate.c b/target/riscv/translate.c
> index e5b339b1fa..3f578d6dd8 100644
> --- a/target/riscv/translate.c
> +++ b/target/riscv/translate.c
> @@ -103,6 +103,9 @@ typedef struct DisasContext {
>       bool vl_eq_vlmax;
>       CPUState *cs;
>       TCGv zero;
> +    /* actual address width */
> +    uint8_t addr_width;
> +    bool addr_signed;
>       /* Ztso */
>       bool ztso;
>       /* Use icount trigger for native debug */
> @@ -1185,6 +1188,8 @@ static void riscv_tr_init_disas_context(DisasContextBase *dcbase, CPUState *cs)
>       ctx->xl = FIELD_EX32(tb_flags, TB_FLAGS, XL);
>       ctx->address_xl = FIELD_EX32(tb_flags, TB_FLAGS, AXL);
>       ctx->cs = cs;
> +    ctx->addr_width = 0;
> +    ctx->addr_signed = false;

Reviewed-by: LIU Zhiwei <zhiwei_liu@linux.alibaba.com>

Zhiwei

>       ctx->ztso = cpu->cfg.ext_ztso;
>       ctx->itrigger = FIELD_EX32(tb_flags, TB_FLAGS, ITRIGGER);
>       ctx->zero = tcg_constant_tl(0);

