Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 94E69CAC5A5
	for <qemu-devel@archiver.kernel.org>; Wed, 24 Sep 2025 06:19:17 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v1IpP-000561-Rm; Wed, 24 Sep 2025 02:18:12 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhiwei_liu@linux.alibaba.com>)
 id 1v1IpJ-0004zd-N9; Wed, 24 Sep 2025 02:18:07 -0400
Received: from [115.124.30.133] (helo=out30-133.freemail.mail.aliyun.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhiwei_liu@linux.alibaba.com>)
 id 1v1IpC-0003rY-1B; Wed, 24 Sep 2025 02:18:03 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linux.alibaba.com; s=default;
 t=1758694656; h=Message-ID:Date:MIME-Version:Subject:To:From:Content-Type;
 bh=zpFy2rrI0u3nMzZ64SL+VCErq3Wx8F13UUH8rpps4us=;
 b=j76HZsz2DFLHtcnFrgNerFXZrU8H+Fnf8JKIBcXtPHYTKbmXRJh2crwcUJ/laJFlIDRWc8WMlImN0hHa5Z5kcAeHn5RH2SuU9kBD50zNVccID1FD+CCEuvo0jITc1bN0ApuJMWzvECh+5OkueKtY7vUcTmbNWCda/79idvsFJA0=
Received: from 30.166.65.12(mailfrom:zhiwei_liu@linux.alibaba.com
 fp:SMTPD_---0WoiYPIw_1758694655 cluster:ay36) by smtp.aliyun-inc.com;
 Wed, 24 Sep 2025 14:17:36 +0800
Message-ID: <90c4f1ab-2e50-4e05-bb6b-f682e2caafb1@linux.alibaba.com>
Date: Wed, 24 Sep 2025 14:17:35 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 04/12] target/riscv: Record misa_ext in
 TCGTBCPUState.cs_base
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
Cc: Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 Alistair Francis <alistair.francis@wdc.com>, Weiwei Li
 <liwei1518@gmail.com>, Daniel Henrique Barboza <dbarboza@ventanamicro.com>,
 qemu-riscv@nongnu.org
References: <20250923023922.3102471-1-richard.henderson@linaro.org>
 <20250923023922.3102471-5-richard.henderson@linaro.org>
Content-Language: en-US
From: LIU Zhiwei <zhiwei_liu@linux.alibaba.com>
In-Reply-To: <20250923023922.3102471-5-richard.henderson@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Host-Lookup-Failed: Reverse DNS lookup failed for 115.124.30.133 (deferred)
Received-SPF: pass client-ip=115.124.30.133;
 envelope-from=zhiwei_liu@linux.alibaba.com;
 helo=out30-133.freemail.mail.aliyun.com
X-Spam_score_int: -166
X-Spam_score: -16.7
X-Spam_bar: ----------------
X-Spam_report: (-16.7 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, ENV_AND_HDR_SPF_MATCH=-0.5,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001, RDNS_NONE=0.793, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001, UNPARSEABLE_RELAY=0.001, USER_IN_DEF_DKIM_WL=-7.5,
 USER_IN_DEF_SPF_WL=-7.5 autolearn=no autolearn_force=no
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


On 9/23/25 10:39 AM, Richard Henderson wrote:
> The tb_flush within write_misa was incorrect.  It assumed
> that we could adjust the ISA of the current processor and
> discard all TB and all would be well.  But MISA is per vcpu,
> so globally flushing TB does not mean that the TB matches
> the MISA of any given vcpu.
>
> By recording misa in the tb state, we ensure that the code
> generated matches the vcpu.
>
> Reviewed-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
> Cc: Alistair Francis <alistair.francis@wdc.com>
> Cc: Weiwei Li <liwei1518@gmail.com>
> Cc: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
> Cc: Liu Zhiwei <zhiwei_liu@linux.alibaba.com>
> Cc: qemu-riscv@nongnu.org
> ---
>   target/riscv/csr.c         | 3 ---
>   target/riscv/tcg/tcg-cpu.c | 3 ++-
>   2 files changed, 2 insertions(+), 4 deletions(-)
>
> diff --git a/target/riscv/csr.c b/target/riscv/csr.c
> index 8842e07a73..3c8989f522 100644
> --- a/target/riscv/csr.c
> +++ b/target/riscv/csr.c
> @@ -25,7 +25,6 @@
>   #include "pmu.h"
>   #include "time_helper.h"
>   #include "exec/cputlb.h"
> -#include "exec/tb-flush.h"
>   #include "exec/icount.h"
>   #include "accel/tcg/getpc.h"
>   #include "qemu/guest-random.h"
> @@ -2173,8 +2172,6 @@ static RISCVException write_misa(CPURISCVState *env, int csrno,
>           env->mstatus &= ~MSTATUS_FS;
>       }
>   
> -    /* flush translation cache */
> -    tb_flush(env_cpu(env));
>       env->xl = riscv_cpu_mxl(env);
>       return RISCV_EXCP_NONE;
>   }
> diff --git a/target/riscv/tcg/tcg-cpu.c b/target/riscv/tcg/tcg-cpu.c
> index 78fb279184..143ab079d4 100644
> --- a/target/riscv/tcg/tcg-cpu.c
> +++ b/target/riscv/tcg/tcg-cpu.c
> @@ -191,7 +191,8 @@ static TCGTBCPUState riscv_get_tb_cpu_state(CPUState *cs)
>   
>       return (TCGTBCPUState){
>           .pc = env->xl == MXL_RV32 ? env->pc & UINT32_MAX : env->pc,
> -        .flags = flags
> +        .flags = flags,
> +        .cs_base = env->misa_ext,
>       };

I hope reserve some tb flags for custom use in the future. As 
env->misa_ext is 32 bit and cs_base is 64 bit, I think the other fields 
are enough for custom use.

As we have move misa_ext to tb flags, I think we should also modify the 
riscv_tr_init_disas_context for ctx->misa_ext assignment.

-ctx->misa_ext = env->misa_ext;

+ctx->misa_ext = (uint32_t)ctx->base.tb->cflags;

to make it explicitly we should not use variable status in env.

Otherwise,

Reviewed-by: LIU Zhiwei <zhiwei_liu@linux.alibaba.com>

Zhiwei

>   }
>   

