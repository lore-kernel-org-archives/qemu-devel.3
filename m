Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9EF65606A31E
	for <qemu-devel@archiver.kernel.org>; Wed, 25 Nov 2026 03:34:25 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xW3lZ-0003OW-EI; Tue, 24 Nov 2026 22:33:54 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <maobibo@loongson.cn>)
 id 1xW3lR-0003LN-SX
 for qemu-devel@nongnu.org; Tue, 24 Nov 2026 22:33:45 -0500
Received: from mail.loongson.cn ([114.242.206.163])
 by eggs.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <maobibo@loongson.cn>) id 1xW3lP-0001dg-9z
 for qemu-devel@nongnu.org; Tue, 24 Nov 2026 22:33:45 -0500
Received: from loongson.cn (unknown [10.20.42.62])
 by gateway (Coremail) with SMTP id _____8Cxf9MNVwZrJssiAA--.33416S3;
 Wed, 25 Nov 2026 11:33:33 +0800 (CST)
Received: from [127.0.0.1] (unknown [127.0.0.1])
 by front1 (Coremail) with SMTP id qMiowJBx5cwIVwZrFjE3AA--.17493S2;
 Wed, 25 Nov 2026 11:33:30 +0800 (CST)
Subject: Re: [PATCH v6 19/26] target/loongarch: add LVZ migration state
To: SignKirigami <prcups@krgm.moe>, qemu-devel@nongnu.org
Cc: Hengyu Yu <yuhengyu25@mails.ucas.ac.cn>
References: <cover.1794558695.git.prcups@krgm.moe>
 <97749e38af511e28277e784125b2b159a8e50320.1794558695.git.prcups@krgm.moe>
From: Bibo Mao <maobibo@loongson.cn>
Message-ID: <8756c318-31d6-7123-bf54-1f4a1f8aa0a2@loongson.cn>
Date: Wed, 25 Nov 2026 11:34:41 +0800
User-Agent: Mozilla/5.0 (X11; Linux loongarch64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
In-Reply-To: <97749e38af511e28277e784125b2b159a8e50320.1794558695.git.prcups@krgm.moe>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: qMiowJBx5cwIVwZrFjE3AA--.17493S2
X-CM-SenderInfo: xpdruxter6z05rqj20fqof0/
X-Coremail-Antispam: 1Uk129KBj93XoW3Ww1xtF47tFW8Gw48tF45CFX_yoWxur4DpF
 90qF17KF9Fk3yfua1xGF45CFsxWF17W3W7uFWYkwnrKF1kGr409rsayr48Ja1kJwnIgw17
 Ar4UGrZrG3y3AwcCm3ZEXasCq-sJn29KB7ZKAUJUUUU8529EdanIXcx71UUUUU7KY7ZEXa
 sCq-sGcSsGvfJ3Ic02F40EFcxC0VAKzVAqx4xG6I80ebIjqfuFe4nvWSU5nxnvy29KBjDU
 0xBIdaVrnRJUUUvFb4IE77IF4wAFF20E14v26r1j6r4UM7CY07I20VC2zVCF04k26cxKx2
 IYs7xG6rWj6s0DM7CIcVAFz4kK6r1Y6r17M28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48v
 e4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Jr0_JF4l84ACjcxK6xIIjxv20xvEc7CjxVAFwI
 0_Jr0_Gr1l84ACjcxK6I8E87Iv67AKxVWxJVW8Jr1l84ACjcxK6I8E87Iv6xkF7I0E14v2
 6r4UJVWxJr1le2I262IYc4CY6c8Ij28IcVAaY2xG8wAqjxCEc2xF0cIa020Ex4CE44I27w
 Aqx4xG64xvF2IEw4CE5I8CrVC2j2WlYx0E2Ix0cI8IcVAFwI0_JrI_JrylYx0Ex4A2jsIE
 14v26r1j6r4UMcvjeVCFs4IE7xkEbVWUJVW8JwACjcxG0xvEwIxGrwCYjI0SjxkI62AI1c
 AE67vIY487MxAIw28IcxkI7VAKI48JMxC20s026xCaFVCjc4AY6r1j6r4UMI8I3I0E5I8C
 rVAFwI0_Jr0_Jr4lx2IqxVCjr7xvwVAFwI0_JrI_JrWlx4CE17CEb7AF67AKxVWUXVWUAw
 CIc40Y0x0EwIxGrwCI42IY6xIIjxv20xvE14v26r1j6r1xMIIF0xvE2Ix0cI8IcVCY1x02
 67AKxVWUJVW8JwCI42IY6xAIw20EY4v20xvaj40_Jr0_JF4lIxAIcVC2z280aVAFwI0_Jr
 0_Gr1lIxAIcVC2z280aVCY1x0267AKxVWUJVW8JbIYCTnIWIevJa73UjIFyTuYvjxU70Pf
 DUUUU
Received-SPF: pass client-ip=114.242.206.163; envelope-from=maobibo@loongson.cn;
 helo=mail.loongson.cn
X-Spam_score_int: -35
X-Spam_score: -3.6
X-Spam_bar: ---
X-Spam_report: (-3.6 / 5.0 requ) BAYES_00=-1.9, NICE_REPLY_A=-1.724,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
X-Spam-Status: No, score=-17.0 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_PASS,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1



On 2026/11/13 下午4:45, SignKirigami wrote:
> Migrate the host LVZ controls, guest CSR and TLB banks, and restore the
> active VM level, guest timer and interrupt request after loading state.
> 
> Signed-off-by: SignKirigami <prcups@krgm.moe>
> Signed-off-by: Hengyu Yu <yuhengyu25@mails.ucas.ac.cn>
> ---
>   target/loongarch/machine.c | 139 +++++++++++++++++++++++++++++++++++++
>   1 file changed, 139 insertions(+)
> 
> diff --git a/target/loongarch/machine.c b/target/loongarch/machine.c
> index 4acab2a4a3..10dfdbd202 100644
> --- a/target/loongarch/machine.c
> +++ b/target/loongarch/machine.c
> @@ -7,6 +7,7 @@
>   
>   #include "qemu/osdep.h"
>   #include "cpu.h"
> +#include "internals.h"
>   #include "migration/vmstate.h"
>   #include "system/tcg.h"
>   #include "vec.h"
> @@ -175,11 +176,145 @@ static const VMStateDescription vmstate_pmu = {
>       },
>   };
>   
> +#if defined(CONFIG_TCG) && !defined(CONFIG_USER_ONLY)
> +static bool tlb_needed(void *opaque)
> +{
> +    return tcg_enabled();
> +}
> +
> +/* TLB state */
> +static const VMStateDescription vmstate_tlb_entry = {
> +    .name = "cpu/tlb_entry",
> +    .version_id = 0,
> +    .minimum_version_id = 0,
> +    .fields = (const VMStateField[]) {
> +        VMSTATE_UINT64(tlb_misc, LoongArchTLB),
> +        VMSTATE_UINT64(tlb_entry0, LoongArchTLB),
> +        VMSTATE_UINT64(tlb_entry1, LoongArchTLB),
> +        VMSTATE_END_OF_LIST()
> +    }
> +};
> +
> +static const VMStateDescription vmstate_tlb = {
> +    .name = "cpu/tlb",
> +    .version_id = 0,
> +    .minimum_version_id = 0,
> +    .needed = tlb_needed,
> +    .fields = (const VMStateField[]) {
> +        VMSTATE_STRUCT_ARRAY(env.tlb, LoongArchCPU, LOONGARCH_TLB_MAX,
> +                             0, vmstate_tlb_entry, LoongArchTLB),
> +        VMSTATE_END_OF_LIST()
> +    }
> +};
> +
> +static const VMStateDescription vmstate_lvz_sys = {
> +    .name = "cpu/lvz-sys",
> +    .version_id = 1,
> +    .minimum_version_id = 1,
> +    .fields = (const VMStateField[]) {
> +        VMSTATE_UINT64(CSR_CRMD, CPUSysState),
> +        VMSTATE_UINT64(CSR_PRMD, CPUSysState),
> +        VMSTATE_UINT64(CSR_EUEN, CPUSysState),
> +        VMSTATE_UINT64(CSR_MISC, CPUSysState),
> +        VMSTATE_UINT64(CSR_ECFG, CPUSysState),
> +        VMSTATE_UINT64(CSR_ESTAT, CPUSysState),
> +        VMSTATE_UINT64(CSR_ERA, CPUSysState),
> +        VMSTATE_UINT64(CSR_BADV, CPUSysState),
> +        VMSTATE_UINT64(CSR_BADI, CPUSysState),
> +        VMSTATE_UINT64(CSR_EENTRY, CPUSysState),
> +        VMSTATE_UINT64(CSR_TLBIDX, CPUSysState),
> +        VMSTATE_UINT64(CSR_TLBEHI, CPUSysState),
> +        VMSTATE_UINT64(CSR_TLBELO0, CPUSysState),
> +        VMSTATE_UINT64(CSR_TLBELO1, CPUSysState),
> +        VMSTATE_UINT64(CSR_ASID, CPUSysState),
> +        VMSTATE_UINT64(CSR_PGDL, CPUSysState),
> +        VMSTATE_UINT64(CSR_PGDH, CPUSysState),
> +        VMSTATE_UINT64(CSR_PGD, CPUSysState),
> +        VMSTATE_UINT64(CSR_PWCL, CPUSysState),
> +        VMSTATE_UINT64(CSR_PWCH, CPUSysState),
> +        VMSTATE_UINT64(CSR_STLBPS, CPUSysState),
> +        VMSTATE_UINT64(CSR_RVACFG, CPUSysState),
> +        VMSTATE_UINT64(CSR_CPUID, CPUSysState),
> +        VMSTATE_UINT64(CSR_PRCFG1, CPUSysState),
> +        VMSTATE_UINT64(CSR_PRCFG2, CPUSysState),
> +        VMSTATE_UINT64(CSR_PRCFG3, CPUSysState),
> +        VMSTATE_UINT64_ARRAY(CSR_SAVE, CPUSysState, 16),
> +        VMSTATE_UINT64(CSR_TID, CPUSysState),
> +        VMSTATE_UINT64(CSR_TCFG, CPUSysState),
> +        VMSTATE_UINT64(CSR_TVAL, CPUSysState),
> +        VMSTATE_UINT64(CSR_CNTC, CPUSysState),
> +        VMSTATE_UINT64(CSR_TICLR, CPUSysState),
> +        VMSTATE_UINT64(CSR_LLBCTL, CPUSysState),
> +        VMSTATE_UINT64(CSR_IMPCTL1, CPUSysState),
> +        VMSTATE_UINT64(CSR_IMPCTL2, CPUSysState),
> +        VMSTATE_UINT64(CSR_TLBRENTRY, CPUSysState),
> +        VMSTATE_UINT64(CSR_TLBRBADV, CPUSysState),
> +        VMSTATE_UINT64(CSR_TLBRERA, CPUSysState),
> +        VMSTATE_UINT64(CSR_TLBRSAVE, CPUSysState),
> +        VMSTATE_UINT64(CSR_TLBRELO0, CPUSysState),
> +        VMSTATE_UINT64(CSR_TLBRELO1, CPUSysState),
> +        VMSTATE_UINT64(CSR_TLBREHI, CPUSysState),
> +        VMSTATE_UINT64(CSR_TLBRPRMD, CPUSysState),
...
> +        VMSTATE_UINT64(CSR_MERRCTL, CPUSysState),
> +        VMSTATE_UINT64(CSR_MERRINFO1, CPUSysState),
> +        VMSTATE_UINT64(CSR_MERRINFO2, CPUSysState),
> +        VMSTATE_UINT64(CSR_MERRENTRY, CPUSysState),
> +        VMSTATE_UINT64(CSR_MERRERA, CPUSysState),
> +        VMSTATE_UINT64(CSR_MERRSAVE, CPUSysState),
> +        VMSTATE_UINT64(CSR_CTAG, CPUSysState),
CSR registers for CTRAG and MERR are not supported in VMLEVEL1, I think 
it can be removed. It is for compatibility in host mode.

> +        VMSTATE_UINT64_ARRAY(CSR_DMW, CPUSysState, 4),
> +        VMSTATE_UINT64(CSR_DBG, CPUSysState),
> +        VMSTATE_UINT64(CSR_DERA, CPUSysState),
> +        VMSTATE_UINT64(CSR_DSAVE, CPUSysState),
...
> +        VMSTATE_UINT64(CSR_GSTAT, CPUSysState),
> +        VMSTATE_UINT64(CSR_GCFG, CPUSysState),
> +        VMSTATE_UINT64(CSR_GINTC, CPUSysState),
> +        VMSTATE_UINT64(CSR_GCNTC, CPUSysState),
> +        VMSTATE_UINT64(CSR_GTLBC, CPUSysState),
It is not necessary to save CSR_GSTAT-CSR_GTLBC for VMLEVEL1, only host 
has these CSR registers.

Regards
Bibo Mao
> +        VMSTATE_END_OF_LIST()
> +    },
> +};
> +
> +static bool lvz_needed(void *opaque)
> +{
> +    LoongArchCPU *cpu = opaque;
> +    return FIELD_EX64(cpu->env.cpucfg[2], CPUCFG2, LVZ);
> +}
> +
> +static const VMStateDescription vmstate_lvz = {
> +    .name = "cpu/lvz",
> +    .version_id = 1,
> +    .minimum_version_id = 1,
> +    .needed = lvz_needed,
> +    .fields = (const VMStateField[]) {
> +        VMSTATE_UINT64(env.sys_states[0].CSR_GSTAT, LoongArchCPU),
> +        VMSTATE_UINT64(env.sys_states[0].CSR_GCFG, LoongArchCPU),
> +        VMSTATE_UINT64(env.sys_states[0].CSR_GINTC, LoongArchCPU),
> +        VMSTATE_UINT64(env.sys_states[0].CSR_GCNTC, LoongArchCPU),
> +        VMSTATE_UINT64(env.sys_states[0].CSR_GTLBC, LoongArchCPU),
> +        VMSTATE_STRUCT(env.sys_states[1], LoongArchCPU, 0,
> +                       vmstate_lvz_sys, CPUSysState),
> +        VMSTATE_END_OF_LIST()
> +    },
> +};
> +#endif
> +
> +static int loongarch_cpu_post_load(void *opaque, int version_id)
> +{
> +    LoongArchCPU *cpu = opaque;
> +    CPULoongArchState *env = &cpu->env;
> +    CPUSysState *host = get_sys(env, VM_LEVEL0);
> +    bool guest = FIELD_EX64(host->CSR_GSTAT, CSR_GSTAT, VM);
> +    set_sys(env, guest);
> +    return 0;
> +}
> +
>   /* LoongArch CPU state */
>   const VMStateDescription vmstate_loongarch_cpu = {
>       .name = "cpu",
>       .version_id = 4,
>       .minimum_version_id = 4,
> +    .post_load = loongarch_cpu_post_load,
>       .fields = (const VMStateField[]) {
>           VMSTATE_UINT64_ARRAY(env.gpr, LoongArchCPU, 32),
>           VMSTATE_UINT64(env.pc, LoongArchCPU),
> @@ -251,6 +386,10 @@ const VMStateDescription vmstate_loongarch_cpu = {
>           &vmstate_fpu,
>           &vmstate_lsx,
>           &vmstate_lasx,
> +#if defined(CONFIG_TCG) && !defined(CONFIG_USER_ONLY)
> +        &vmstate_tlb,
> +        &vmstate_lvz,
> +#endif
>           &vmstate_lbt,
>           &vmstate_msgint,
>           &vmstate_pmu,
> 


