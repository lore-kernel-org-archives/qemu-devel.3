Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AEB9DCD1284
	for <qemu-devel@archiver.kernel.org>; Fri,  5 Apr 2024 01:37:56 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rsYVw-0003zp-Fp; Thu, 04 Apr 2024 21:37:08 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhiwei_liu@linux.alibaba.com>)
 id 1rsYVt-0003zH-Qp; Thu, 04 Apr 2024 21:37:05 -0400
Received: from out30-118.freemail.mail.aliyun.com ([115.124.30.118])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhiwei_liu@linux.alibaba.com>)
 id 1rsYVq-00079G-SR; Thu, 04 Apr 2024 21:37:05 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linux.alibaba.com; s=default;
 t=1712281000; h=Message-ID:Date:MIME-Version:Subject:To:From:Content-Type;
 bh=K38f60f1dzgtPcD5oPcE2YWE0y00Yk6z0l0L+x59nr0=;
 b=lrmwH8zyv7ZUIxKkj2Zbqd8UPzMFP7nZorTg10rU2xUFiPYBgxnkSko7GXi4USykrhLHIw5F1kPObiIz1dStx7vhWVgwbTpp+j1olVpulgDfZ4AoCwGICIW/fYl9AC9YinoXgkHyDzg4LQ2iQqVoNUggdoslaBnAoiISkPGqOqw=
X-Alimail-AntiSpam: AC=PASS; BC=-1|-1; BR=01201311R161e4; CH=green; DM=||false|;
 DS=||; FP=0|-1|-1|-1|0|-1|-1|-1; HT=ay29a033018045192;
 MF=zhiwei_liu@linux.alibaba.com; NM=1; PH=DS; RN=17; SR=0;
 TI=SMTPD_---0W3va4ET_1712280997; 
Received: from 30.0.150.57(mailfrom:zhiwei_liu@linux.alibaba.com
 fp:SMTPD_---0W3va4ET_1712280997) by smtp.aliyun-inc.com;
 Fri, 05 Apr 2024 09:36:38 +0800
Message-ID: <4e07e450-9b79-42d9-9ac1-dc59849e175d@linux.alibaba.com>
Date: Fri, 5 Apr 2024 09:36:30 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] riscv: thead: Add th.sxstatus CSR emulation
To: =?UTF-8?Q?Christoph_M=C3=BCllner?= <christoph.muellner@vrull.eu>,
 qemu-riscv@nongnu.org, qemu-devel@nongnu.org,
 Alistair Francis <alistair.francis@wdc.com>,
 Bin Meng <bin.meng@windriver.com>, Philipp Tomsich
 <philipp.tomsich@vrull.eu>, Palmer Dabbelt <palmer@dabbelt.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Cooper Qu <cooper.qu@linux.alibaba.com>,
 Huang Tao <eric.huang@linux.alibaba.com>, Conor Dooley <conor@kernel.org>,
 Andrew Jones <ajones@ventanamicro.com>,
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>,
 Vivian Wang <uwu@dram.page>, Qingfang Deng <dqfext@gmail.com>,
 Alexandre Ghiti <alex@ghiti.fr>
Cc: Weiwei Li <liwei1518@gmail.com>
References: <20240329120427.684677-1-christoph.muellner@vrull.eu>
Content-Language: en-US
From: LIU Zhiwei <zhiwei_liu@linux.alibaba.com>
In-Reply-To: <20240329120427.684677-1-christoph.muellner@vrull.eu>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
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


On 2024/3/29 20:04, Christoph Müllner wrote:
> The th.sxstatus CSR can be used to identify available custom extension
> on T-Head CPUs. The CSR is documented here:
>    https://github.com/T-head-Semi/thead-extension-spec/pull/46
>
> An important property of this patch is, that the th.sxstatus MAEE field
> is not set (indicating that XTheadMaee is not available).
> XTheadMaee is a memory attribute extension (similar to Svpbmt) which is
> implemented in many T-Head CPUs (C906, C910, etc.) and utilizes bits
> in PTEs that are marked as reserved. QEMU maintainers prefer to not
> implement XTheadMaee, so we need give kernels a mechanism to identify
> if XTheadMaee is available in a system or not. And this patch introduces
> this mechanism in QEMU in a way that's compatible with real HW
> (i.e., probing the th.sxstatus.MAEE bit).
>
> Further context can be found on the list:
> https://lists.gnu.org/archive/html/qemu-devel/2024-02/msg00775.html
>
> Signed-off-by: Christoph Müllner <christoph.muellner@vrull.eu>
> ---
>   target/riscv/cpu.c       |  1 +
>   target/riscv/cpu.h       |  3 ++
>   target/riscv/meson.build |  1 +
>   target/riscv/th_csr.c    | 78 ++++++++++++++++++++++++++++++++++++++++
>   4 files changed, 83 insertions(+)
>   create mode 100644 target/riscv/th_csr.c
>
> diff --git a/target/riscv/cpu.c b/target/riscv/cpu.c
> index 36e3e5fdaf..b82ba95ae6 100644
> --- a/target/riscv/cpu.c
> +++ b/target/riscv/cpu.c
> @@ -545,6 +545,7 @@ static void rv64_thead_c906_cpu_init(Object *obj)
>       cpu->cfg.mvendorid = THEAD_VENDOR_ID;
>   #ifndef CONFIG_USER_ONLY
>       set_satp_mode_max_supported(cpu, VM_1_10_SV39);
> +    th_register_custom_csrs(cpu);
>   #endif
>   
>       /* inherited from parent obj via riscv_cpu_init() */
> diff --git a/target/riscv/cpu.h b/target/riscv/cpu.h
> index 3b1a02b944..c9f8f06751 100644
> --- a/target/riscv/cpu.h
> +++ b/target/riscv/cpu.h
> @@ -824,4 +824,7 @@ void riscv_cpu_register_gdb_regs_for_features(CPUState *cs);
>   uint8_t satp_mode_max_from_map(uint32_t map);
>   const char *satp_mode_str(uint8_t satp_mode, bool is_32_bit);
>   
> +/* Implemented in th_csr.c */
> +void th_register_custom_csrs(RISCVCPU *cpu);
> +
>   #endif /* RISCV_CPU_H */
> diff --git a/target/riscv/meson.build b/target/riscv/meson.build
> index a5e0734e7f..a4bd61e52a 100644
> --- a/target/riscv/meson.build
> +++ b/target/riscv/meson.build
> @@ -33,6 +33,7 @@ riscv_system_ss.add(files(
>     'monitor.c',
>     'machine.c',
>     'pmu.c',
> +  'th_csr.c',
>     'time_helper.c',
>     'riscv-qmp-cmds.c',
>   ))
> diff --git a/target/riscv/th_csr.c b/target/riscv/th_csr.c
> new file mode 100644
> index 0000000000..66d260cabd
> --- /dev/null
> +++ b/target/riscv/th_csr.c
> @@ -0,0 +1,78 @@
> +/*
> + * T-Head-specific CSRs.
> + *
> + * Copyright (c) 2024 VRULL GmbH
> + *
> + * This program is free software; you can redistribute it and/or modify it
> + * under the terms and conditions of the GNU General Public License,
> + * version 2 or later, as published by the Free Software Foundation.
> + *
> + * This program is distributed in the hope it will be useful, but WITHOUT
> + * ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or
> + * FITNESS FOR A PARTICULAR PURPOSE.  See the GNU General Public License for
> + * more details.
> + *
> + * You should have received a copy of the GNU General Public License along with
> + * this program.  If not, see <http://www.gnu.org/licenses/>.
> + */
> +
> +#include "qemu/osdep.h"
> +#include "cpu.h"
> +#include "cpu_vendorid.h"
> +
> +#define CSR_TH_SXSTATUS 0x5c0
> +
> +/* TH_SXSTATUS bits */
> +#define TH_SXSTATUS_UCME        BIT(16)
> +#define TH_SXSTATUS_MAEE        BIT(21)
> +#define TH_SXSTATUS_THEADISAEE  BIT(22)
> +
> +typedef struct {
> +    int csrno;
> +    int (*insertion_test)(RISCVCPU *cpu);
> +    riscv_csr_operations csr_ops;
> +} riscv_csr;
> +
> +static RISCVException s_mode_csr(CPURISCVState *env, int csrno)
> +{
> +    if (env->debugger)
> +        return RISCV_EXCP_NONE;
> +
> +    if (env->priv >= PRV_S)
> +        return RISCV_EXCP_NONE;
This will be checked by riscv_csrrw_check.
> +
> +    return RISCV_EXCP_ILLEGAL_INST;
> +}
Insteadly, reuse the smode in csr.c, where it checks iscv_has_ext(env, RVS).
> +
> +static int test_thead_mvendorid(RISCVCPU *cpu)
> +{
> +    if (cpu->cfg.mvendorid != THEAD_VENDOR_ID)
> +        return -1;
> +    return 0;
> +}
> +
> +static RISCVException read_th_sxstatus(CPURISCVState *env, int csrno,
> +                                       target_ulong *val)
> +{
> +    /* We don't set MAEE here, because QEMU does not implement MAEE. */
> +    *val = TH_SXSTATUS_UCME | TH_SXSTATUS_THEADISAEE;
> +    return RISCV_EXCP_NONE;
> +}
> +
> +static riscv_csr th_csr_list[] = {
> +    {
> +        .csrno = CSR_TH_SXSTATUS,
> +        .insertion_test = test_thead_mvendorid,
> +        .csr_ops = { "th.sxstatus", s_mode_csr, read_th_sxstatus }
> +    }
> +};
> +
> +void th_register_custom_csrs(RISCVCPU *cpu)
> +{
> +    for (size_t i = 0; i < ARRAY_SIZE(th_csr_list); i++) {
> +        int csrno = th_csr_list[i].csrno;
> +        riscv_csr_operations *csr_ops = &th_csr_list[i].csr_ops;
> +        if (!th_csr_list[i].insertion_test(cpu))
> +            riscv_set_csr_ops(csrno, csr_ops);
> +    }
> +}

Otherwise,

Reviewed-by: LIU Zhiwei <zhiwe_liu@linux.alibaba.com>

Zhiwei


