Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D3EA7CF11F4
	for <qemu-devel@archiver.kernel.org>; Thu, 10 Oct 2024 13:18:54 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1syt3y-0008Jc-VF; Thu, 10 Oct 2024 09:18:42 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alexei.filippov@syntacore.com>)
 id 1sys0F-0002NF-OQ; Thu, 10 Oct 2024 08:10:47 -0400
Received: from mta-03.yadro.com ([89.207.88.253])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alexei.filippov@syntacore.com>)
 id 1sys0B-0007xE-Su; Thu, 10 Oct 2024 08:10:47 -0400
DKIM-Filter: OpenDKIM Filter v2.11.0 mta-03.yadro.com 5509BE0025
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yadro.com; s=mta-04;
 t=1728562239; bh=5ldrKwiDs77wuenUZ9504d6+wAiq19PndC1ktBl9WBc=;
 h=Message-ID:Date:MIME-Version:Subject:To:From:Content-Type:From;
 b=KzyVNUP3ZlwY2F2K6sIsuNgP9AHRTlO5uVPdPXdEAPhGX4+PHLmDGB2WsHTcFCgGu
 1p+fz1TEz5CRixC7dIkU5NFN1jd0n40BtqbOEFCMH7pwOcH7f7RTknsK5tztU0e2QO
 NVVX3QkWX3W4ksssMQAjcHYV4sn5A1n/IfWRv5Q8Gh/ZkcFdZXBfn50YTEMCi0Yf13
 IICgyp9A8WYYh2ymGJEwKSixEOrj89+SwjRwYMWlMWhvI+PQfyIGO+kGamZc6B8riV
 D4F0MXUsiNs3OlVjGU3uPRMkJ29qEt3Gu9ICDquFk+tuq2CFYbIj6WF/8ZmTq+7Jcs
 qdeHZgQm8TNUw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yadro.com; s=mta-03;
 t=1728562239; bh=5ldrKwiDs77wuenUZ9504d6+wAiq19PndC1ktBl9WBc=;
 h=Message-ID:Date:MIME-Version:Subject:To:From:Content-Type:From;
 b=RISEzklm81HpBAn7B+D2wjJcAjzjV+j64yI5AB7SBJQzLxANOdFmTwhYK8mkejllz
 f9Fc0IwUWjLz+tdoFM+qpwUOUIDE6BYmztW3zuJerNwWWog1CUjBTv2wHtQ/BZaUyx
 +4TjQLhuX4rqbQHHV/UjCk3R/szG8uEbewmypUE0dDs7QP44XIXnnnUN4TXaVRcp3x
 HeqIFqkdzkD4pEbrX87UCVgLmbu49eEPLvYe+i1AGGxIl/2OE2Kc0deVeZPmgKQWCP
 DjBkt9xvobs3kjT2Orkun23LDAvRMvTaHBkh6A/OebxImHFRbNG6YFgtgD3JbEJRY+
 CUg5OarnjLY0w==
Message-ID: <3746b775-0fa1-4eca-a25c-b961cf083451@yadro.com>
Date: Thu, 10 Oct 2024 15:10:37 +0300
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH RFC 05/10] target/riscv: Rename the PMU events
To: Atish Patra <atishp@rivosinc.com>, <qemu-riscv@nongnu.org>,
 <qemu-devel@nongnu.org>
CC: <alexei.filippov@syntacore.com>, <palmer@dabbelt.com>,
 <liwei1518@gmail.com>, <zhiwei_liu@linux.alibaba.com>,
 <bin.meng@windriver.com>, <dbarboza@ventanamicro.com>,
 <alistair.francis@wdc.com>
References: <20241009-pmu_event_machine-v1-0-dcbd7a60e3ba@rivosinc.com>
 <20241009-pmu_event_machine-v1-5-dcbd7a60e3ba@rivosinc.com>
Content-Language: en-US
From: Alexei Filippov <alexei.filippov@yadro.com>
In-Reply-To: <20241009-pmu_event_machine-v1-5-dcbd7a60e3ba@rivosinc.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: T-EXCH-08.corp.yadro.com (172.17.11.58) To
 T-EXCH-12.corp.yadro.com (172.17.11.143)
Received-SPF: permerror client-ip=89.207.88.253;
 envelope-from=alexei.filippov@syntacore.com; helo=mta-03.yadro.com
X-Spam_score_int: -16
X-Spam_score: -1.7
X-Spam_bar: -
X-Spam_report: (-1.7 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, HEADER_FROM_DIFFERENT_DOMAINS=0.25,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, T_SPF_PERMERROR=0.01 autolearn=no autolearn_force=no
X-Spam_action: no action
X-Mailman-Approved-At: Thu, 10 Oct 2024 09:18:36 -0400
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



On 10.10.2024 02:09, Atish Patra wrote:
> The current PMU events are defined by SBI PMU
> specification.  As there is no standard event encoding
> scheme, Virt machine chooses to use the SBI PMU encoding.
> A platform may choose to implement a different event
> encoding scheme completely.
> 
> Rename the event names to reflect the reality.
> 
> No functional changes introduced.
> 
> Signed-off-by: Atish Patra <atishp@rivosinc.com>
> ---
>   target/riscv/cpu.h        | 26 +++++++++++++++-----
>   target/riscv/cpu_helper.c |  8 +++---
>   target/riscv/pmu.c        | 62 ++++++++++++++++++-----------------------------
>   target/riscv/pmu.h        |  2 +-
>   4 files changed, 48 insertions(+), 50 deletions(-)
> 
> diff --git a/target/riscv/cpu.h b/target/riscv/cpu.h
> index 97e408b91219..2ac391a7cf74 100644
> --- a/target/riscv/cpu.h
> +++ b/target/riscv/cpu.h
> @@ -820,14 +820,28 @@ enum {
>   /*
>    * The event id are encoded based on the encoding specified in the
>    * SBI specification v0.3
> + *
> + * The event encoding is specified in the SBI specification
> + * Event idx is a 20bits wide number encoded as follows:
> + * event_idx[19:16] = type
> + * event_idx[15:0] = code
> + * The code field in cache events are encoded as follows:
> + * event_idx.code[15:3] = cache_id
> + * event_idx.code[2:1] = op_id
> + * event_idx.code[0:0] = result_id
>    */
>   
> -enum riscv_pmu_event_idx {
> -    RISCV_PMU_EVENT_HW_CPU_CYCLES = 0x01,
> -    RISCV_PMU_EVENT_HW_INSTRUCTIONS = 0x02,
> -    RISCV_PMU_EVENT_CACHE_DTLB_READ_MISS = 0x10019,
> -    RISCV_PMU_EVENT_CACHE_DTLB_WRITE_MISS = 0x1001B,
> -    RISCV_PMU_EVENT_CACHE_ITLB_PREFETCH_MISS = 0x10021,
> +enum virt_pmu_event_idx {
> +    /* SBI_PMU_HW_CPU_CYCLES: 0x01 : type(0x00) */
> +    VIRT_PMU_EVENT_HW_CPU_CYCLES = 0x01,
> +    /* SBI_PMU_HW_INSTRUCTIONS: 0x02 : type(0x00) */
> +    VIRT_PMU_EVENT_HW_INSTRUCTIONS = 0x02,
> +    /* SBI_PMU_HW_CACHE_DTLB : 0x03 READ : 0x00 MISS : 0x00 type(0x01) */
> +    VIRT_PMU_EVENT_CACHE_DTLB_READ_MISS = 0x10019,
> +    /* SBI_PMU_HW_CACHE_DTLB : 0x03 WRITE : 0x01 MISS : 0x00 type(0x01) */
> +    VIRT_PMU_EVENT_CACHE_DTLB_WRITE_MISS = 0x1001B,
> +    /* SBI_PMU_HW_CACHE_ITLB : 0x04 READ : 0x00 MISS : 0x00 type(0x01) */
> +    VIRT_PMU_EVENT_CACHE_ITLB_PREFETCH_MISS = 0x10021,
Pretty sure, this is not a good idea to rename them since the generic 
event even do not include TLB_* events as far as I know. It's acctually 
better to just leave generic naming as is and let the machine handle 
machine specific events separatly.
>   };
>   
>   /* used by tcg/tcg-cpu.c*/
> diff --git a/target/riscv/cpu_helper.c b/target/riscv/cpu_helper.c
> index 203c0a92ab75..0f1655a221bd 100644
> --- a/target/riscv/cpu_helper.c
> +++ b/target/riscv/cpu_helper.c
> @@ -1295,17 +1295,17 @@ void riscv_cpu_do_unaligned_access(CPUState *cs, vaddr addr,
>   
>   static void pmu_tlb_fill_incr_ctr(RISCVCPU *cpu, MMUAccessType access_type)
>   {
> -    enum riscv_pmu_event_idx pmu_event_type;
> +    enum virt_pmu_event_idx pmu_event_type;
>   
>       switch (access_type) {
>       case MMU_INST_FETCH:
> -        pmu_event_type = RISCV_PMU_EVENT_CACHE_ITLB_PREFETCH_MISS;
> +        pmu_event_type = VIRT_PMU_EVENT_CACHE_ITLB_PREFETCH_MISS;
>           break;
>       case MMU_DATA_LOAD:
> -        pmu_event_type = RISCV_PMU_EVENT_CACHE_DTLB_READ_MISS;
> +        pmu_event_type = VIRT_PMU_EVENT_CACHE_DTLB_READ_MISS;
>           break;
>       case MMU_DATA_STORE:
> -        pmu_event_type = RISCV_PMU_EVENT_CACHE_DTLB_WRITE_MISS;
> +        pmu_event_type = VIRT_PMU_EVENT_CACHE_DTLB_WRITE_MISS;
>           break;
>       default:
>           return;
> diff --git a/target/riscv/pmu.c b/target/riscv/pmu.c
> index 2531d4f1a9c1..c436b08d1043 100644
> --- a/target/riscv/pmu.c
> +++ b/target/riscv/pmu.c
> @@ -38,40 +38,24 @@ void riscv_pmu_generate_fdt_node(void *fdt, uint32_t cmask, char *pmu_name)
>   {
>       uint32_t fdt_event_ctr_map[15] = {};
>   
> -   /*
> -    * The event encoding is specified in the SBI specification
> -    * Event idx is a 20bits wide number encoded as follows:
> -    * event_idx[19:16] = type
> -    * event_idx[15:0] = code
> -    * The code field in cache events are encoded as follows:
> -    * event_idx.code[15:3] = cache_id
> -    * event_idx.code[2:1] = op_id
> -    * event_idx.code[0:0] = result_id
> -    */
> -
> -   /* SBI_PMU_HW_CPU_CYCLES: 0x01 : type(0x00) */
> -   fdt_event_ctr_map[0] = cpu_to_be32(0x00000001);
> -   fdt_event_ctr_map[1] = cpu_to_be32(0x00000001);
> +   fdt_event_ctr_map[0] = cpu_to_be32(VIRT_PMU_EVENT_HW_CPU_CYCLES);
> +   fdt_event_ctr_map[1] = cpu_to_be32(VIRT_PMU_EVENT_HW_CPU_CYCLES);
>      fdt_event_ctr_map[2] = cpu_to_be32(cmask | 1 << 0);
>   
> -   /* SBI_PMU_HW_INSTRUCTIONS: 0x02 : type(0x00) */
> -   fdt_event_ctr_map[3] = cpu_to_be32(0x00000002);
> -   fdt_event_ctr_map[4] = cpu_to_be32(0x00000002);
> +   fdt_event_ctr_map[3] = cpu_to_be32(VIRT_PMU_EVENT_HW_INSTRUCTIONS);
> +   fdt_event_ctr_map[4] = cpu_to_be32(VIRT_PMU_EVENT_HW_INSTRUCTIONS);
>      fdt_event_ctr_map[5] = cpu_to_be32(cmask | 1 << 2);
>   
> -   /* SBI_PMU_HW_CACHE_DTLB : 0x03 READ : 0x00 MISS : 0x00 type(0x01) */
> -   fdt_event_ctr_map[6] = cpu_to_be32(0x00010019);
> -   fdt_event_ctr_map[7] = cpu_to_be32(0x00010019);
> +   fdt_event_ctr_map[6] = cpu_to_be32(VIRT_PMU_EVENT_CACHE_DTLB_READ_MISS);
> +   fdt_event_ctr_map[7] = cpu_to_be32(VIRT_PMU_EVENT_CACHE_DTLB_READ_MISS);
>      fdt_event_ctr_map[8] = cpu_to_be32(cmask);
>   
> -   /* SBI_PMU_HW_CACHE_DTLB : 0x03 WRITE : 0x01 MISS : 0x00 type(0x01) */
> -   fdt_event_ctr_map[9] = cpu_to_be32(0x0001001B);
> -   fdt_event_ctr_map[10] = cpu_to_be32(0x0001001B);
> +   fdt_event_ctr_map[9] = cpu_to_be32(VIRT_PMU_EVENT_CACHE_DTLB_WRITE_MISS);
> +   fdt_event_ctr_map[10] = cpu_to_be32(VIRT_PMU_EVENT_CACHE_DTLB_WRITE_MISS);
>      fdt_event_ctr_map[11] = cpu_to_be32(cmask);
>   
> -   /* SBI_PMU_HW_CACHE_ITLB : 0x04 READ : 0x00 MISS : 0x00 type(0x01) */
> -   fdt_event_ctr_map[12] = cpu_to_be32(0x00010021);
> -   fdt_event_ctr_map[13] = cpu_to_be32(0x00010021);
> +   fdt_event_ctr_map[12] = cpu_to_be32(VIRT_PMU_EVENT_CACHE_ITLB_PREFETCH_MISS);
> +   fdt_event_ctr_map[13] = cpu_to_be32(VIRT_PMU_EVENT_CACHE_ITLB_PREFETCH_MISS);
>      fdt_event_ctr_map[14] = cpu_to_be32(cmask);
Ok, I guess it's time to do smthng generic to this function, cz if 
number of supported machines will go up it's going to be a problem I guess.
>   
>      /* This a OpenSBI specific DT property documented in OpenSBI docs */
> @@ -290,7 +274,7 @@ void riscv_pmu_update_fixed_ctrs(CPURISCVState *env, target_ulong newpriv,
>       riscv_pmu_icount_update_priv(env, newpriv, new_virt);
>   }
>   
> -int riscv_pmu_incr_ctr(RISCVCPU *cpu, enum riscv_pmu_event_idx event_idx)
> +int riscv_pmu_incr_ctr(RISCVCPU *cpu, enum virt_pmu_event_idx event_idx)
>   {
>       uint32_t ctr_idx;
>       int ret;
> @@ -329,7 +313,7 @@ bool riscv_pmu_ctr_monitor_instructions(CPURISCVState *env,
>       }
>   
>       cpu = env_archcpu(env);
> -    if (!riscv_pmu_htable_lookup(cpu, RISCV_PMU_EVENT_HW_INSTRUCTIONS,
> +    if (!riscv_pmu_htable_lookup(cpu, VIRT_PMU_EVENT_HW_INSTRUCTIONS,
>                                    &ctr_idx)) {
>           return false;
>       }
> @@ -348,7 +332,7 @@ bool riscv_pmu_ctr_monitor_cycles(CPURISCVState *env, uint32_t target_ctr)
>       }
>   
>       cpu = env_archcpu(env);
> -    if (!riscv_pmu_htable_lookup(cpu, RISCV_PMU_EVENT_HW_CPU_CYCLES,
> +    if (!riscv_pmu_htable_lookup(cpu, VIRT_PMU_EVENT_HW_CPU_CYCLES,
>                                   &ctr_idx)) {
>           return false;
>       }
> @@ -406,11 +390,11 @@ int riscv_pmu_update_event_map(CPURISCVState *env, uint64_t value,
>       }
>   
>       switch (event_idx) {
> -    case RISCV_PMU_EVENT_HW_CPU_CYCLES:
> -    case RISCV_PMU_EVENT_HW_INSTRUCTIONS:
> -    case RISCV_PMU_EVENT_CACHE_DTLB_READ_MISS:
> -    case RISCV_PMU_EVENT_CACHE_DTLB_WRITE_MISS:
> -    case RISCV_PMU_EVENT_CACHE_ITLB_PREFETCH_MISS:
> +    case VIRT_PMU_EVENT_HW_CPU_CYCLES:
> +    case VIRT_PMU_EVENT_HW_INSTRUCTIONS:
> +    case VIRT_PMU_EVENT_CACHE_DTLB_READ_MISS:
> +    case VIRT_PMU_EVENT_CACHE_DTLB_WRITE_MISS:
> +    case VIRT_PMU_EVENT_CACHE_ITLB_PREFETCH_MISS:
>           break;
>       default:
>           /* We don't support any raw events right now */
> @@ -464,7 +448,7 @@ static bool pmu_hpmevent_set_of_if_clear(CPURISCVState *env, uint32_t ctr_idx)
>   }
>   
>   static void pmu_timer_trigger_irq(RISCVCPU *cpu,
> -                                  enum riscv_pmu_event_idx evt_idx)
> +                                  enum virt_pmu_event_idx evt_idx)
>   {
>       uint32_t ctr_idx;
>       CPURISCVState *env = &cpu->env;
> @@ -473,8 +457,8 @@ static void pmu_timer_trigger_irq(RISCVCPU *cpu,
>       uint64_t curr_ctr_val, curr_ctrh_val;
>       uint64_t ctr_val;
>   
> -    if (evt_idx != RISCV_PMU_EVENT_HW_CPU_CYCLES &&
> -        evt_idx != RISCV_PMU_EVENT_HW_INSTRUCTIONS) {
> +    if (evt_idx != VIRT_PMU_EVENT_HW_CPU_CYCLES &&
> +        evt_idx != VIRT_PMU_EVENT_HW_INSTRUCTIONS) {
>           return;
>       }
>   
> @@ -533,8 +517,8 @@ void riscv_pmu_timer_cb(void *priv)
>       RISCVCPU *cpu = priv;
>   
>       /* Timer event was triggered only for these events */
> -    pmu_timer_trigger_irq(cpu, RISCV_PMU_EVENT_HW_CPU_CYCLES);
> -    pmu_timer_trigger_irq(cpu, RISCV_PMU_EVENT_HW_INSTRUCTIONS);
> +    pmu_timer_trigger_irq(cpu, VIRT_PMU_EVENT_HW_CPU_CYCLES);
> +    pmu_timer_trigger_irq(cpu, VIRT_PMU_EVENT_HW_INSTRUCTIONS);
>   }
>   
>   int riscv_pmu_setup_timer(CPURISCVState *env, uint64_t value, uint32_t ctr_idx)
> diff --git a/target/riscv/pmu.h b/target/riscv/pmu.h
> index 3853d0e2629e..75a22d596b69 100644
> --- a/target/riscv/pmu.h
> +++ b/target/riscv/pmu.h
> @@ -30,7 +30,7 @@ void riscv_pmu_timer_cb(void *priv);
>   void riscv_pmu_init(RISCVCPU *cpu, Error **errp);
>   int riscv_pmu_update_event_map(CPURISCVState *env, uint64_t value,
>                                  uint32_t ctr_idx);
> -int riscv_pmu_incr_ctr(RISCVCPU *cpu, enum riscv_pmu_event_idx event_idx);
> +int riscv_pmu_incr_ctr(RISCVCPU *cpu, enum virt_pmu_event_idx event_idx);
>   void riscv_pmu_generate_fdt_node(void *fdt, uint32_t cmask, char *pmu_name);
>   int riscv_pmu_setup_timer(CPURISCVState *env, uint64_t value,
>                             uint32_t ctr_idx);
> 

