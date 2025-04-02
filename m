Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 77120C36010
	for <qemu-devel@archiver.kernel.org>; Wed,  2 Apr 2025 02:44:52 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tzo5L-0003m0-FQ; Tue, 01 Apr 2025 22:44:11 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brian.cain@oss.qualcomm.com>)
 id 1tzo5K-0003lq-6u
 for qemu-devel@nongnu.org; Tue, 01 Apr 2025 22:44:10 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brian.cain@oss.qualcomm.com>)
 id 1tzo5H-0002bc-Ac
 for qemu-devel@nongnu.org; Tue, 01 Apr 2025 22:44:09 -0400
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 531MR4Xd030885
 for <qemu-devel@nongnu.org>; Wed, 2 Apr 2025 02:44:04 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 f1OEdo3F6hFNGJNOVlQJNbY6S2BLbh2WoL3Qh7lcAL4=; b=SK0GZqMaqG8ZPg6m
 kU3M/7j6Qdsy6lQ0CHMI+4LP/be+23ixkdNZlbwF8r81Mi+jPsVDoGmPWHe9anSq
 MbqXSxU/CRwyCXGtBzcOKz6bybpgtF1S37E0PkQsJleWapLE4OwR5aYVGbR9JQNp
 vZmFDv72Kae+KG0vvHipTyr/EKxT6Gd+cuTJf1zwpx2r+Rps52Eu162rhytPivdN
 p41P9YL3CZIGOlUHx6RlFq73XUmyaCy742qU4VJ0XWGxmxShFw06883zxTa46XW3
 Ode24pgXPV9TrC7snNdTMmccocy6u+l35rfsNdZmev8znLwNOQg0hKyVwgH3WFeI
 6sPlfQ==
Received: from mail-pl1-f197.google.com (mail-pl1-f197.google.com
 [209.85.214.197])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 45recpj7tr-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Wed, 02 Apr 2025 02:44:04 +0000 (GMT)
Received: by mail-pl1-f197.google.com with SMTP id
 d9443c01a7336-2240c997059so142625725ad.0
 for <qemu-devel@nongnu.org>; Tue, 01 Apr 2025 19:44:04 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1743561843; x=1744166643;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=f1OEdo3F6hFNGJNOVlQJNbY6S2BLbh2WoL3Qh7lcAL4=;
 b=ZicnaSgX74Ek2N1vcnKG/u48bvdtAoKRTQzoyNTOzFyiJsGFK5rYGec3orusnUkoxa
 CXOm/hDQ/JXFfR+H5q4FIPnGU8uo0oA5NvE9/MNa4xRTQUkPKaY3CaA0XPiEhbo2/MXJ
 xywwL6FS4qGFqx54CzQvCeF2a0TvecU6Yev9XJluuTfW/rJC7OO3axY5x6S9cIgHh1qB
 YLvUv6bBntGwiF1KXFohKNTTiPVNhCkdVYJMzE9v5OUgoR4yaoT0Q9Pms2Yp+2tBb01q
 u9j1mKgz6THncI6HfR+P+3z9O2bG8EUVXjd286wGTNd7hJHxKmzhXTgUimxQG/U31r4c
 wGAA==
X-Forwarded-Encrypted: i=1;
 AJvYcCXnVcpaW0qrIMoqRSuXDlyeWuJ142td+FM6QnsQjZPDcp0eahwAg2RDB9W0shSBJxSRB983koZA+7U6@nongnu.org
X-Gm-Message-State: AOJu0YyvIF2ie+gWtGy7x3wYYHJETr7yqdTOTZj2V5hHjV4dgMkq4k2k
 KfbZafD2vIJ0ml3CIxqbYgW3kjyoxQx4FGAqvS9bUNyZoR/BcTlrSj9nzW8CnLmwM8GODL38Fnj
 VAUgZxvSiJg6JgB1y7DEfXVkrY5VFXh9PfGPWutif9pNXxDTkFilfCQ==
X-Gm-Gg: ASbGncumcpz/BlqEAquU6+r+SMSFwY/WI4q17bvNA0O8LSX4A9rUaPSxYV0PXyjNoqj
 3VXkiz3TJW+mVM6EBpKb5NZUsqptdis0zrrClcHDjokD3kHMu6c165BSkjbgRHqymrLekOBKA8P
 oH7dOL6o70134HBWJ1hvRffSTHSwxNS1Wf6oGKNOLcTPOD6ZyxRquBoP36qdHiz6ovNBI1+CoZ3
 WC+1eSjVr4DNz6sEXgR0HJ36A6Z3I2+v8SEZKRrH5VRzUmSgrDVkbxpHhumFwDLHZJSq1OcKJHi
 yCpgf448+xlWwck2sJJTv95U7dpUy3aRX4AsTILVsNjv7qGkIqBgI3h3+92uzV01RIaL+3DGcnb
 PkRmnQ1JYjJqrHRbb
X-Received: by 2002:a17:902:d542:b0:224:8bf:6d81 with SMTP id
 d9443c01a7336-2296c87a26cmr10508395ad.46.1743561843442; 
 Tue, 01 Apr 2025 19:44:03 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IE+O8fTQrdj+Mz3vGU3fueM+WA6R9Ip/M88gi2rVCi0J/f0q+G35HHH6CA9nZ7gpn8uA2wMtQ==
X-Received: by 2002:a17:902:d542:b0:224:8bf:6d81 with SMTP id
 d9443c01a7336-2296c87a26cmr10508155ad.46.1743561843080; 
 Tue, 01 Apr 2025 19:44:03 -0700 (PDT)
Received: from [192.168.1.157] (104-54-226-75.lightspeed.austtx.sbcglobal.net.
 [104.54.226.75]) by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2291eedc988sm97656485ad.59.2025.04.01.19.44.01
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 01 Apr 2025 19:44:02 -0700 (PDT)
Message-ID: <a94b130f-ef9c-4400-b7e3-10a4d72068bc@oss.qualcomm.com>
Date: Tue, 1 Apr 2025 21:44:00 -0500
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 12/39] target/hexagon: Add implementation of cycle counters
To: ltaylorsimpson@gmail.com, qemu-devel@nongnu.org
Cc: richard.henderson@linaro.org, philmd@linaro.org, quic_mathbern@quicinc.com,
 ale@rev.ng, anjo@rev.ng, quic_mliebel@quicinc.com,
 alex.bennee@linaro.org, quic_mburton@quicinc.com, sidneym@quicinc.com,
 'Brian Cain' <bcain@quicinc.com>
References: <20250301052845.1012069-1-brian.cain@oss.qualcomm.com>
 <20250301052845.1012069-13-brian.cain@oss.qualcomm.com>
 <02d401db9908$2e3d77d0$8ab86770$@gmail.com>
Content-Language: en-US
From: Brian Cain <brian.cain@oss.qualcomm.com>
In-Reply-To: <02d401db9908$2e3d77d0$8ab86770$@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Proofpoint-GUID: X_E8TPMCWfmswW_qY9KFNgM1FO5XKO1x
X-Proofpoint-ORIG-GUID: X_E8TPMCWfmswW_qY9KFNgM1FO5XKO1x
X-Authority-Analysis: v=2.4 cv=J4Sq7BnS c=1 sm=1 tr=0 ts=67eca474 cx=c_pps
 a=cmESyDAEBpBGqyK7t0alAg==:117 a=x6rl1zRT+JsLSO7OGbGBKQ==:17
 a=IkcTkHD0fZMA:10 a=XR8D0OoHHMoA:10 a=pGLkceISAAAA:8 a=EUspDBNiAAAA:8
 a=69wJf7TsAAAA:8 a=KKAkSRfTAAAA:8 a=COk6AnOGAAAA:8
 a=gZb75l4ZuB9Def_CkEwA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=1OuFwYUASf3TG4hYMiVC:22 a=Fg1AiH1G6rFz08G2ETeA:22 a=cvBusfyB2V15izCimMoJ:22
 a=TjNXssC_j7lpFel5tvFf:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1095,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-04-02_01,2025-04-01_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501
 clxscore=1015 bulkscore=0 mlxlogscore=999 malwarescore=0 mlxscore=0
 spamscore=0 phishscore=0 suspectscore=0 impostorscore=0 lowpriorityscore=0
 adultscore=0 classifier=spam authscore=0 authtc=n/a authcc= route=outbound
 adjust=0 reason=mlx scancount=1 engine=8.19.0-2502280000
 definitions=main-2504020016
Received-SPF: pass client-ip=205.220.168.131;
 envelope-from=brian.cain@oss.qualcomm.com; helo=mx0a-0031df01.pphosted.com
X-Spam_score_int: -26
X-Spam_score: -2.7
X-Spam_bar: --
X-Spam_report: (-2.7 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, RCVD_IN_DNSWL_LOW=-0.7,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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


On 3/19/2025 2:50 PM, ltaylorsimpson@gmail.com wrote:
>
>> -----Original Message-----
>> From: Brian Cain <brian.cain@oss.qualcomm.com>
>> Sent: Friday, February 28, 2025 11:28 PM
>> To: qemu-devel@nongnu.org
>> Cc: brian.cain@oss.qualcomm.com; richard.henderson@linaro.org;
>> philmd@linaro.org; quic_mathbern@quicinc.com; ale@rev.ng; anjo@rev.ng;
>> quic_mliebel@quicinc.com; ltaylorsimpson@gmail.com;
>> alex.bennee@linaro.org; quic_mburton@quicinc.com;
>> sidneym@quicinc.com; Brian Cain <bcain@quicinc.com>
>> Subject: [PATCH 12/39] target/hexagon: Add implementation of cycle
>> counters
>>
>> From: Brian Cain <bcain@quicinc.com>
>>
>> Co-authored-by: Sid Manning <sidneym@quicinc.com>
>> Signed-off-by: Brian Cain <brian.cain@oss.qualcomm.com>
>> ---
>>   target/hexagon/cpu.h        | 25 ++++++++++++++++++++++---
>>   target/hexagon/translate.h  |  2 ++
>>   target/hexagon/cpu_helper.c | 12 +++++++++---
>> target/hexagon/translate.c  | 27 +++++++++++++++++++++++++++
>>   4 files changed, 60 insertions(+), 6 deletions(-)
>>
>> diff --git a/target/hexagon/cpu.h b/target/hexagon/cpu.h index
>> 4b9c9873dc..7e2ea838c5 100644
>> --- a/target/hexagon/cpu.h
>> +++ b/target/hexagon/cpu.h
>> @@ -27,11 +27,15 @@
>>
>>   #include "cpu-qom.h"
>>   #include "exec/cpu-defs.h"
>> +#include "exec/cpu-common.h"
>>   #include "hex_regs.h"
>>   #include "mmvec/mmvec.h"
>>   #include "hw/registerfields.h"
>>
>> +#ifndef CONFIG_USER_ONLY
>> +#include "reg_fields.h"
>>   typedef struct CPUHexagonTLBContext CPUHexagonTLBContext;
>> +#endif
> Why is reg_fields.h guarded by #ifndef CONFIG_USER_ONLY?


It's to get syscfg field definitions like "SYSCFG_PCYCLEEN".  We can 
move it to a more general place, though.


> Also, why wasn't the CPUHexagonTLBContext guarded when it was first inserted?


It should have been.  I will fix this.


>>   #define NUM_PREGS 4
>>   #define TOTAL_PER_THREAD_REGS 64
>> @@ -188,6 +192,7 @@ struct ArchCPU {
>>
>>   FIELD(TB_FLAGS, IS_TIGHT_LOOP, 0, 1)
>>   FIELD(TB_FLAGS, MMU_INDEX, 1, 3)
>> +FIELD(TB_FLAGS, PCYCLE_ENABLED, 4, 1)
>>
>>   G_NORETURN void hexagon_raise_exception_err(CPUHexagonState *env,
>>                                               uint32_t exception, @@ -201,6 +206,11 @@ void
>> hexagon_cpu_soft_reset(CPUHexagonState *env);  #endif
>>
>>   #include "exec/cpu-all.h"
>> +
>> +#ifndef CONFIG_USER_ONLY
>> +#include "cpu_helper.h"
>> +#endif
>> +
>>   static inline void cpu_get_tb_cpu_state(CPUHexagonState *env, vaddr *pc,
>>                                           uint64_t *cs_base, uint32_t *flags)  { @@ -210,16
>> +220,27 @@ static inline void cpu_get_tb_cpu_state(CPUHexagonState
>> *env, vaddr *pc,
>>       if (*pc == env->gpr[HEX_REG_SA0]) {
>>           hex_flags = FIELD_DP32(hex_flags, TB_FLAGS, IS_TIGHT_LOOP, 1);
>>       }
>> -    *flags = hex_flags;
>>       if (*pc & PCALIGN_MASK) {
>>           hexagon_raise_exception_err(env, HEX_CAUSE_PC_NOT_ALIGNED, 0);
>>       }
>>   #ifndef CONFIG_USER_ONLY
>> +    target_ulong syscfg = arch_get_system_reg(env, HEX_SREG_SYSCFG);
>> +
>> +    bool pcycle_enabled = extract32(syscfg,
>> +                                    reg_field_info[SYSCFG_PCYCLEEN].offset,
>> +
>> + reg_field_info[SYSCFG_PCYCLEEN].width);
>> +
>>       hex_flags = FIELD_DP32(hex_flags, TB_FLAGS, MMU_INDEX,
>>                              cpu_mmu_index(env_cpu(env), false));
>> +
>> +    if (pcycle_enabled) {
>> +        hex_flags = FIELD_DP32(hex_flags, TB_FLAGS, PCYCLE_ENABLED, 1);
>> +    }
>>   #else
>> +    hex_flags = FIELD_DP32(hex_flags, TB_FLAGS, PCYCLE_ENABLED, true);
> Are pcycles exposed in linux-user mode?  If not, make this flag system-mode only.


Yes, they are (for the "upcycle" registers).


>>       hex_flags = FIELD_DP32(hex_flags, TB_FLAGS, MMU_INDEX,
>> MMU_USER_IDX);  #endif
>> +    *flags = hex_flags;
>>   }
>>
>>   typedef HexagonCPU ArchCPU;
>> @@ -228,6 +249,4 @@ void hexagon_translate_init(void);  void
>> hexagon_translate_code(CPUState *cs, TranslationBlock *tb,
>>                               int *max_insns, vaddr pc, void *host_pc);
>>
>> -#include "exec/cpu-all.h"
>> -
>>   #endif /* HEXAGON_CPU_H */
>> diff --git a/target/hexagon/translate.h b/target/hexagon/translate.h index
>> 0eaa3db03e..9bc4b3ce8b 100644
>> --- a/target/hexagon/translate.h
>> +++ b/target/hexagon/translate.h
>> @@ -83,6 +83,8 @@ typedef struct DisasContext {
>>       TCGv new_pred_value[NUM_PREGS];
>>       TCGv branch_taken;
>>       TCGv dczero_addr;
>> +    bool pcycle_enabled;
> Guard with #ifndef CONFIG_USER_ONLY
>
>> +    uint32_t num_cycles;
>>   } DisasContext;
>>
>>   bool is_gather_store_insn(DisasContext *ctx); diff --git
>> a/target/hexagon/cpu_helper.c b/target/hexagon/cpu_helper.c index
>> 0b0802bfb9..1d9b9f8bef 100644
>> --- a/target/hexagon/cpu_helper.c
>> +++ b/target/hexagon/cpu_helper.c
>> @@ -48,17 +48,23 @@ uint32_t arch_get_system_reg(CPUHexagonState
>> *env, uint32_t reg)
>>
>>   uint64_t hexagon_get_sys_pcycle_count(CPUHexagonState *env)  {
>> -    g_assert_not_reached();
> Do we need a lock here?


I didn't think we did.  But now that you mention it, we may indeed.


>> +    uint64_t cycles = 0;
>> +    CPUState *cs;
>> +    CPU_FOREACH(cs) {
>> +        CPUHexagonState *env_ = cpu_env(cs);
>> +        cycles += env_->t_cycle_count;
>> +    }
>> +    return *(env->g_pcycle_base) + cycles;
>>   }
>>
>>   uint32_t hexagon_get_sys_pcycle_count_high(CPUHexagonState *env)  {
>> -    g_assert_not_reached();
>> +    return hexagon_get_sys_pcycle_count(env) >> 32;
>>   }
>>
>>   uint32_t hexagon_get_sys_pcycle_count_low(CPUHexagonState *env)  {
>> -    g_assert_not_reached();
>> +    return extract64(hexagon_get_sys_pcycle_count(env), 0, 32);
>>   }
>>
>>   void hexagon_set_sys_pcycle_count_high(CPUHexagonState *env, diff --git
>> a/target/hexagon/translate.c b/target/hexagon/translate.c index
>> 9119e42ff7..060df6e5eb 100644
>> --- a/target/hexagon/translate.c
>> +++ b/target/hexagon/translate.c
>> @@ -57,6 +57,7 @@ TCGv_i64 hex_store_val64[STORES_MAX];  TCGv
>> hex_llsc_addr;  TCGv hex_llsc_val;
>>   TCGv_i64 hex_llsc_val_i64;
>> +TCGv_i64 hex_cycle_count;
> Guard with #ifndef CONFIG_USER_ONLY


This feature belongs to both usermode and system emulation.


>>   TCGv hex_vstore_addr[VSTORES_MAX];
>>   TCGv hex_vstore_size[VSTORES_MAX];
>>   TCGv hex_vstore_pending[VSTORES_MAX];
>> @@ -125,6 +126,22 @@ static void gen_exception_raw(int excp)
>>       gen_helper_raise_exception(tcg_env, tcg_constant_i32(excp));  }
>>
>> +#ifndef CONFIG_USER_ONLY
>> +static inline void gen_precise_exception(int excp, target_ulong PC) {
>> +    tcg_gen_movi_tl(hex_cause_code, excp);
>> +    gen_exception(HEX_EVENT_PRECISE, PC); }
> Belongs in a different patch.


I will fix this.


>> +
>> +static inline void gen_pcycle_counters(DisasContext *ctx) {
>> +    if (ctx->pcycle_enabled) {
>> +        tcg_gen_addi_i64(hex_cycle_count, hex_cycle_count, ctx-
>>> num_cycles);
>> +        ctx->num_cycles = 0;
>> +    }
>> +}
>> +#endif
>> +
>>   static void gen_exec_counters(DisasContext *ctx)  {
>>       tcg_gen_addi_tl(hex_gpr[HEX_REG_QEMU_PKT_CNT],
>> @@ -133,6 +150,10 @@ static void gen_exec_counters(DisasContext *ctx)
>>                       hex_gpr[HEX_REG_QEMU_INSN_CNT], ctx->num_insns);
>>       tcg_gen_addi_tl(hex_gpr[HEX_REG_QEMU_HVX_CNT],
>>                       hex_gpr[HEX_REG_QEMU_HVX_CNT], ctx->num_hvx_insns);
>> +
>> +#ifndef CONFIG_USER_ONLY
>> +   gen_pcycle_counters(ctx);
>> +#endif
>>   }
>>
>>   static bool use_goto_tb(DisasContext *ctx, target_ulong dest) @@ -785,6
>> +806,7 @@ static void gen_commit_hvx(DisasContext *ctx)
>>       }
>>   }
>>
>> +static const int PCYCLES_PER_PACKET = 3;
>>   static void update_exec_counters(DisasContext *ctx)  {
>>       Packet *pkt = ctx->pkt;
>> @@ -804,6 +826,7 @@ static void update_exec_counters(DisasContext *ctx)
>>       }
>>
>>       ctx->num_packets++;
>> +    ctx->num_cycles += PCYCLES_PER_PACKET;
> Guard
>
>>       ctx->num_insns += num_real_insns;
>>       ctx->num_hvx_insns += num_hvx_insns;  } @@ -946,11 +969,13 @@ static
>> void hexagon_tr_init_disas_context(DisasContextBase *dcbase,
>>
>>       ctx->mem_idx = FIELD_EX32(hex_flags, TB_FLAGS, MMU_INDEX);
>>       ctx->num_packets = 0;
>> +    ctx->num_cycles = 0;
> Guard
>
>>       ctx->num_insns = 0;
>>       ctx->num_hvx_insns = 0;
>>       ctx->branch_cond = TCG_COND_NEVER;
>>       ctx->is_tight_loop = FIELD_EX32(hex_flags, TB_FLAGS, IS_TIGHT_LOOP);
>>       ctx->short_circuit = hex_cpu->short_circuit;
>> +    ctx->pcycle_enabled = FIELD_EX32(hex_flags, TB_FLAGS,
>> + PCYCLE_ENABLED);
> Guard
>
>>   }
>>
>>   static void hexagon_tr_tb_start(DisasContextBase *db, CPUState *cpu) @@
>> -1077,6 +1102,8 @@ void hexagon_translate_init(void)
>>           offsetof(CPUHexagonState, llsc_val), "llsc_val");
>>       hex_llsc_val_i64 = tcg_global_mem_new_i64(tcg_env,
>>           offsetof(CPUHexagonState, llsc_val_i64), "llsc_val_i64");
>> +    hex_cycle_count = tcg_global_mem_new_i64(tcg_env,
>> +            offsetof(CPUHexagonState, t_cycle_count), "t_cycle_count");
> Guard


These will remain unguarded as referenced above - it's a general feature.


>>       for (i = 0; i < STORES_MAX; i++) {
>>           snprintf(store_addr_names[i], NAME_LEN, "store_addr_%d", i);
>>           hex_store_addr[i] = tcg_global_mem_new(tcg_env,
>> --
>> 2.34.1
>

