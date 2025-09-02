Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B18B9CA1007
	for <qemu-devel@archiver.kernel.org>; Tue,  2 Sep 2025 04:24:38 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1utIZL-0003fK-26; Tue, 02 Sep 2025 00:24:33 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brian.cain@oss.qualcomm.com>)
 id 1utIZ8-0003NW-Ap
 for qemu-devel@nongnu.org; Tue, 02 Sep 2025 00:24:20 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brian.cain@oss.qualcomm.com>)
 id 1utIZ3-00017p-Er
 for qemu-devel@nongnu.org; Tue, 02 Sep 2025 00:24:18 -0400
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5822S6ia010341
 for <qemu-devel@nongnu.org>; Tue, 2 Sep 2025 04:24:10 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 XXisP9Ojr0pi03h/m1vCe1K9epswAKHSd+srE15gBc0=; b=HtPyZPjsOAY+wQo1
 Ms+hx5Q8ZMPGs2ckpjkegur8Gk94m1rA5Zc0XX8cfykYwNK8JbEKUTP8hu9QF9ff
 nk7wpJlGzx1uvzptczAhb5pAcvstGr3zwFsej+EtbVMmL70g4Bv0ycaPPhdxCGx8
 vdVuDqXpAqrb5Eyqn3sl5jsJ+rL0sMu52HMYbvDvaHBVKPQyvnmbyYtMfUAik6wo
 gDMcM9yWsstrYRlUrtnyQAqy5vW4mubPSdJCgFgIf1mV/03MXXnjYAMRsEMivcMI
 A237a89MniYdFfS0EdWF9gfDGkHIV0/i1R8RT1HjDtOcb3XIRZkSXrWUd9BO1atg
 zDPd+w==
Received: from mail-qv1-f72.google.com (mail-qv1-f72.google.com
 [209.85.219.72])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 48urmjefjg-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Tue, 02 Sep 2025 04:24:10 +0000 (GMT)
Received: by mail-qv1-f72.google.com with SMTP id
 6a1803df08f44-70dfcc589d8so32840586d6.3
 for <qemu-devel@nongnu.org>; Mon, 01 Sep 2025 21:24:10 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1756787050; x=1757391850;
 h=content-transfer-encoding:in-reply-to:content-language:references
 :cc:to:from:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=XXisP9Ojr0pi03h/m1vCe1K9epswAKHSd+srE15gBc0=;
 b=Z1cZW5usDpRaLvSTVbHv3+68x95icU19Kq0xFFqkAVGM2IzGcN3lINkqySqcTM+ZMQ
 7xlv5G4pWwNXzGrrALNXpfJGa3SmIfn3qhxvTtjiKnXe+GnFNL6h/7g5QWF4SsOU5EAa
 DILvOHZMK+0YMK4KZJIigjYK6VZ1YoLqRC/tGumpEXUv8wQlUbb8z5wqIbggyxnV0EBa
 c7Jxuc5qbayOitVDfFu6keC9yZ9X65X+jkprnr9x9kfBlj68D43KFSPcOR+VYBk57baW
 SSLkpXhKfJPT8kFaf2FFW2SCw5BCihHw6NGJnVTAlECIIzNGfvaDB7+T0cFyCJW4jhMM
 rw2w==
X-Forwarded-Encrypted: i=1;
 AJvYcCUtHBsixaz6ZxgCA6/H7DgETQOnEtZ0vSKS88IkrWJ+2Yix/KemlR0P32H59OZ61KdFSNoLtCozLsgb@nongnu.org
X-Gm-Message-State: AOJu0YwCG+Bv4mPi3e1xA90XaoO1kwPD2WaESerlAF+eMurztAnn4pn/
 FkAfTXTWBJboWjaenhIOphCFB6NuahXza0irMDW1QAoLEt/A1dq/WNNkfdvXLhOcJFssHYJ/YXa
 yYnXlv00fEP26ly7S17rPc5EYpyHVzrPvVDzR75y6hv2ms7BMEvGHXHrfSg==
X-Gm-Gg: ASbGncuTNx1IIOwPXHXk+I2tKiilt9e0Wel1pj8cF6xwRW6yMf1P2driZbyTre6Ynnt
 ToGran1hT9vvafiCiWluFTq2SYe67apBXewfqRpECEOBtzHUJPfND5VA1VNxSeLEUbMZBSVuVvg
 WA21T3GbE+FABiRGMTBidVt3It7ll603A8JQT23WV5X8aH1cvlJI36i/LnDVrR2UUmTc30u4rgN
 uVj+zTo9lAflNfyXMBSjR9w4sx0KP+c7j6zaVpsVR5ZVrKPHYRKw2pH9pMxo13CZS2gFE9U5prg
 3JD0iLAG25zOdlZJ1aSgrczXuCpQV+Ch9aVtNKhgszH6rCJUN/CrsXl/RpW4Uw==
X-Received: by 2002:a05:622a:98e:b0:4b3:39e:2d15 with SMTP id
 d75a77b69052e-4b31dd4fe01mr137494831cf.71.1756787049422; 
 Mon, 01 Sep 2025 21:24:09 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IELYTjoarJiv0Wjd3H0eJUhzjVKsf/9ljBffwhL2edXrLSW4yXWso1+z4FIN00JKDtPlCVpBw==
X-Received: by 2002:a05:622a:98e:b0:4b3:39e:2d15 with SMTP id
 d75a77b69052e-4b31dd4fe01mr137494631cf.71.1756787048877; 
 Mon, 01 Sep 2025 21:24:08 -0700 (PDT)
Received: from [172.19.248.181] ([80.149.170.9])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3cf276d5e5fsm17958390f8f.27.2025.09.01.21.23.58
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 01 Sep 2025 21:24:08 -0700 (PDT)
Message-ID: <4e1939b7-bb4c-4fa2-99b6-87da873ea043@oss.qualcomm.com>
Date: Mon, 1 Sep 2025 20:56:21 -0500
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 12/39] target/hexagon: Add implementation of cycle counters
From: Brian Cain <brian.cain@oss.qualcomm.com>
To: ltaylorsimpson@gmail.com, qemu-devel@nongnu.org
Cc: richard.henderson@linaro.org, philmd@linaro.org, quic_mathbern@quicinc.com,
 ale@rev.ng, anjo@rev.ng, quic_mliebel@quicinc.com,
 alex.bennee@linaro.org, quic_mburton@quicinc.com, sidneym@quicinc.com,
 'Brian Cain' <bcain@quicinc.com>
References: <20250301052845.1012069-1-brian.cain@oss.qualcomm.com>
 <20250301052845.1012069-13-brian.cain@oss.qualcomm.com>
 <02d401db9908$2e3d77d0$8ab86770$@gmail.com>
 <7274cd69-f4e7-40b5-b850-cbd9099ed8ac@oss.qualcomm.com>
Content-Language: en-US
In-Reply-To: <7274cd69-f4e7-40b5-b850-cbd9099ed8ac@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Authority-Analysis: v=2.4 cv=OemYDgTY c=1 sm=1 tr=0 ts=68b6716a cx=c_pps
 a=7E5Bxpl4vBhpaufnMqZlrw==:117 a=oqm+nZh+PgUSu2IGv/nVbQ==:17
 a=IkcTkHD0fZMA:10 a=yJojWOMRYYMA:10 a=pGLkceISAAAA:8 a=EUspDBNiAAAA:8
 a=69wJf7TsAAAA:8 a=KKAkSRfTAAAA:8 a=COk6AnOGAAAA:8 a=aRSJYkXxKalRXPYYifwA:9
 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10 a=pJ04lnu7RYOZP9TFuWaZ:22
 a=Fg1AiH1G6rFz08G2ETeA:22 a=cvBusfyB2V15izCimMoJ:22 a=TjNXssC_j7lpFel5tvFf:22
X-Proofpoint-GUID: Wzxy0l9EQW2R67wyOLCkBU9-qjHeX7v4
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwODMwMDAyNCBTYWx0ZWRfX0+gWdbt5pqAU
 rgJo3E/6SuYmkalK/yRHKKRVcWG1LiJcHfiLjYKItw8nHSB80XzUeVcyRAG6gIbKujv9NVzTldT
 BIDabDLkISv++gX0BthLzj+v5iJadNes8v+1vTWITu7a3/D6jnJ7otSozsOjzRZbpOtM0hL8REb
 5Cs6k14M2ld/Y4+roxz3TxKrvFrPmCtrbNfAtkNTe/kayqK2CothV9IBzm0R8IQDj0wX3rZ+G2W
 LfnD/Iwsf0s090NXbBfDetMXSCX4LovD0+u/1Vz7McCEjNkuP4zTE1szAQ5tWOUmMpeN7L0gRbn
 gQKc5fzKj8n0oV6vaB69QAuj0rEgu6q3F+JTC0gNcg6GcE5LdlIXLmiU9XyCnXJa26kHkFT6Q/b
 nRCb3a4+
X-Proofpoint-ORIG-GUID: Wzxy0l9EQW2R67wyOLCkBU9-qjHeX7v4
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-09-02_01,2025-08-28_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 suspectscore=0 spamscore=0 bulkscore=0 priorityscore=1501
 adultscore=0 clxscore=1015 phishscore=0 impostorscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2507300000 definitions=main-2508300024
Received-SPF: pass client-ip=205.220.180.131;
 envelope-from=brian.cain@oss.qualcomm.com; helo=mx0b-0031df01.pphosted.com
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


On 4/1/2025 9:42 PM, Brian Cain wrote:
>
>
> On 3/19/2025 2:50 PM, ltaylorsimpson@gmail.com wrote:
>>> -----Original Message-----
>>> From: Brian Cain<brian.cain@oss.qualcomm.com>
>>> Sent: Friday, February 28, 2025 11:28 PM
>>> To:qemu-devel@nongnu.org
>>> Cc:brian.cain@oss.qualcomm.com;richard.henderson@linaro.org;
>>> philmd@linaro.org;quic_mathbern@quicinc.com;ale@rev.ng;anjo@rev.ng;
>>> quic_mliebel@quicinc.com;ltaylorsimpson@gmail.com;
>>> alex.bennee@linaro.org;quic_mburton@quicinc.com;
>>> sidneym@quicinc.com; Brian Cain<bcain@quicinc.com>
>>> Subject: [PATCH 12/39] target/hexagon: Add implementation of cycle
>>> counters
>>>
>>> From: Brian Cain<bcain@quicinc.com>
>>>
>>> Co-authored-by: Sid Manning<sidneym@quicinc.com>
>>> Signed-off-by: Brian Cain<brian.cain@oss.qualcomm.com>
>>> ---
>>>   target/hexagon/cpu.h        | 25 ++++++++++++++++++++++---
>>>   target/hexagon/translate.h  |  2 ++
>>>   target/hexagon/cpu_helper.c | 12 +++++++++---
>>> target/hexagon/translate.c  | 27 +++++++++++++++++++++++++++
>>>   4 files changed, 60 insertions(+), 6 deletions(-)
>>>
>>> diff --git a/target/hexagon/cpu.h b/target/hexagon/cpu.h index
>>> 4b9c9873dc..7e2ea838c5 100644
>>> --- a/target/hexagon/cpu.h
>>> +++ b/target/hexagon/cpu.h
>>> @@ -27,11 +27,15 @@
>>>
>>>   #include "cpu-qom.h"
>>>   #include "exec/cpu-defs.h"
>>> +#include "exec/cpu-common.h"
>>>   #include "hex_regs.h"
>>>   #include "mmvec/mmvec.h"
>>>   #include "hw/registerfields.h"
>>>
>>> +#ifndef CONFIG_USER_ONLY
>>> +#include "reg_fields.h"
>>>   typedef struct CPUHexagonTLBContext CPUHexagonTLBContext;
>>> +#endif
>> Why is reg_fields.h guarded by #ifndef CONFIG_USER_ONLY?
>
>
> It's to get syscfg field definitions like "SYSCFG_PCYCLEEN". We can 
> move it to a more general place, though.
>
>
>> Also, why wasn't the CPUHexagonTLBContext guarded when it was first inserted?
>
>
> It should have been.  I will fix this.
>
>
Fixed in v2.

>>>   #define NUM_PREGS 4
>>>   #define TOTAL_PER_THREAD_REGS 64
>>> @@ -188,6 +192,7 @@ struct ArchCPU {
>>>
>>>   FIELD(TB_FLAGS, IS_TIGHT_LOOP, 0, 1)
>>>   FIELD(TB_FLAGS, MMU_INDEX, 1, 3)
>>> +FIELD(TB_FLAGS, PCYCLE_ENABLED, 4, 1)
>>>
>>>   G_NORETURN void hexagon_raise_exception_err(CPUHexagonState *env,
>>>                                               uint32_t exception, @@ -201,6 +206,11 @@ void
>>> hexagon_cpu_soft_reset(CPUHexagonState *env);  #endif
>>>
>>>   #include "exec/cpu-all.h"
>>> +
>>> +#ifndef CONFIG_USER_ONLY
>>> +#include "cpu_helper.h"
>>> +#endif
>>> +
>>>   static inline void cpu_get_tb_cpu_state(CPUHexagonState *env, vaddr *pc,
>>>                                           uint64_t *cs_base, uint32_t *flags)  { @@ -210,16
>>> +220,27 @@ static inline void cpu_get_tb_cpu_state(CPUHexagonState
>>> *env, vaddr *pc,
>>>       if (*pc == env->gpr[HEX_REG_SA0]) {
>>>           hex_flags = FIELD_DP32(hex_flags, TB_FLAGS, IS_TIGHT_LOOP, 1);
>>>       }
>>> -    *flags = hex_flags;
>>>       if (*pc & PCALIGN_MASK) {
>>>           hexagon_raise_exception_err(env, HEX_CAUSE_PC_NOT_ALIGNED, 0);
>>>       }
>>>   #ifndef CONFIG_USER_ONLY
>>> +    target_ulong syscfg = arch_get_system_reg(env, HEX_SREG_SYSCFG);
>>> +
>>> +    bool pcycle_enabled = extract32(syscfg,
>>> +                                    reg_field_info[SYSCFG_PCYCLEEN].offset,
>>> +
>>> + reg_field_info[SYSCFG_PCYCLEEN].width);
>>> +
>>>       hex_flags = FIELD_DP32(hex_flags, TB_FLAGS, MMU_INDEX,
>>>                              cpu_mmu_index(env_cpu(env), false));
>>> +
>>> +    if (pcycle_enabled) {
>>> +        hex_flags = FIELD_DP32(hex_flags, TB_FLAGS, PCYCLE_ENABLED, 1);
>>> +    }
>>>   #else
>>> +    hex_flags = FIELD_DP32(hex_flags, TB_FLAGS, PCYCLE_ENABLED, true);
>> Are pcycles exposed in linux-user mode?  If not, make this flag system-mode only.
>
>
> Yes, they are (for the "upcycle" registers).
>
>
>>>       hex_flags = FIELD_DP32(hex_flags, TB_FLAGS, MMU_INDEX,
>>> MMU_USER_IDX);  #endif
>>> +    *flags = hex_flags;
>>>   }
>>>
>>>   typedef HexagonCPU ArchCPU;
>>> @@ -228,6 +249,4 @@ void hexagon_translate_init(void);  void
>>> hexagon_translate_code(CPUState *cs, TranslationBlock *tb,
>>>                               int *max_insns, vaddr pc, void *host_pc);
>>>
>>> -#include "exec/cpu-all.h"
>>> -
>>>   #endif /* HEXAGON_CPU_H */
>>> diff --git a/target/hexagon/translate.h b/target/hexagon/translate.h index
>>> 0eaa3db03e..9bc4b3ce8b 100644
>>> --- a/target/hexagon/translate.h
>>> +++ b/target/hexagon/translate.h
>>> @@ -83,6 +83,8 @@ typedef struct DisasContext {
>>>       TCGv new_pred_value[NUM_PREGS];
>>>       TCGv branch_taken;
>>>       TCGv dczero_addr;
>>> +    bool pcycle_enabled;
>> Guard with #ifndef CONFIG_USER_ONLY
>>
>>> +    uint32_t num_cycles;
>>>   } DisasContext;
>>>
>>>   bool is_gather_store_insn(DisasContext *ctx); diff --git
>>> a/target/hexagon/cpu_helper.c b/target/hexagon/cpu_helper.c index
>>> 0b0802bfb9..1d9b9f8bef 100644
>>> --- a/target/hexagon/cpu_helper.c
>>> +++ b/target/hexagon/cpu_helper.c
>>> @@ -48,17 +48,23 @@ uint32_t arch_get_system_reg(CPUHexagonState
>>> *env, uint32_t reg)
>>>
>>>   uint64_t hexagon_get_sys_pcycle_count(CPUHexagonState *env)  {
>>> -    g_assert_not_reached();
>> Do we need a lock here?
>>
>>> +    uint64_t cycles = 0;
>>> +    CPUState *cs;
>>> +    CPU_FOREACH(cs) {
>>> +        CPUHexagonState *env_ = cpu_env(cs);
>>> +        cycles += env_->t_cycle_count;
>>> +    }
>>> +    return *(env->g_pcycle_base) + cycles;
>>>   }
>>>
>>>   uint32_t hexagon_get_sys_pcycle_count_high(CPUHexagonState *env)  {
>>> -    g_assert_not_reached();
>>> +    return hexagon_get_sys_pcycle_count(env) >> 32;
>>>   }
>>>
>>>   uint32_t hexagon_get_sys_pcycle_count_low(CPUHexagonState *env)  {
>>> -    g_assert_not_reached();
>>> +    return extract64(hexagon_get_sys_pcycle_count(env), 0, 32);
>>>   }
>>>
>>>   void hexagon_set_sys_pcycle_count_high(CPUHexagonState *env, diff --git
>>> a/target/hexagon/translate.c b/target/hexagon/translate.c index
>>> 9119e42ff7..060df6e5eb 100644
>>> --- a/target/hexagon/translate.c
>>> +++ b/target/hexagon/translate.c
>>> @@ -57,6 +57,7 @@ TCGv_i64 hex_store_val64[STORES_MAX];  TCGv
>>> hex_llsc_addr;  TCGv hex_llsc_val;
>>>   TCGv_i64 hex_llsc_val_i64;
>>> +TCGv_i64 hex_cycle_count;
>> Guard with #ifndef CONFIG_USER_ONLY
>
>
> This feature belongs to both usermode and system emulation.
>
>
>>>   TCGv hex_vstore_addr[VSTORES_MAX];
>>>   TCGv hex_vstore_size[VSTORES_MAX];
>>>   TCGv hex_vstore_pending[VSTORES_MAX];
>>> @@ -125,6 +126,22 @@ static void gen_exception_raw(int excp)
>>>       gen_helper_raise_exception(tcg_env, tcg_constant_i32(excp));  }
>>>
>>> +#ifndef CONFIG_USER_ONLY
>>> +static inline void gen_precise_exception(int excp, target_ulong PC) {
>>> +    tcg_gen_movi_tl(hex_cause_code, excp);
>>> +    gen_exception(HEX_EVENT_PRECISE, PC); }
>> Belongs in a different patch.
>
>
> I will fix this.
>

Tsk!  I did *not* fix it in v2.  Sorry, will address it in v3.


>
>>> +
>>> +static inline void gen_pcycle_counters(DisasContext *ctx) {
>>> +    if (ctx->pcycle_enabled) {
>>> +        tcg_gen_addi_i64(hex_cycle_count, hex_cycle_count, ctx-
>>>> num_cycles);
>>> +        ctx->num_cycles = 0;
>>> +    }
>>> +}
>>> +#endif
>>> +
>>>   static void gen_exec_counters(DisasContext *ctx)  {
>>>       tcg_gen_addi_tl(hex_gpr[HEX_REG_QEMU_PKT_CNT],
>>> @@ -133,6 +150,10 @@ static void gen_exec_counters(DisasContext *ctx)
>>>                       hex_gpr[HEX_REG_QEMU_INSN_CNT], ctx->num_insns);
>>>       tcg_gen_addi_tl(hex_gpr[HEX_REG_QEMU_HVX_CNT],
>>>                       hex_gpr[HEX_REG_QEMU_HVX_CNT], ctx->num_hvx_insns);
>>> +
>>> +#ifndef CONFIG_USER_ONLY
>>> +   gen_pcycle_counters(ctx);
>>> +#endif
>>>   }
>>>
>>>   static bool use_goto_tb(DisasContext *ctx, target_ulong dest) @@ -785,6
>>> +806,7 @@ static void gen_commit_hvx(DisasContext *ctx)
>>>       }
>>>   }
>>>
>>> +static const int PCYCLES_PER_PACKET = 3;
>>>   static void update_exec_counters(DisasContext *ctx)  {
>>>       Packet *pkt = ctx->pkt;
>>> @@ -804,6 +826,7 @@ static void update_exec_counters(DisasContext *ctx)
>>>       }
>>>
>>>       ctx->num_packets++;
>>> +    ctx->num_cycles += PCYCLES_PER_PACKET;
>> Guard
>>
>>>       ctx->num_insns += num_real_insns;
>>>       ctx->num_hvx_insns += num_hvx_insns;  } @@ -946,11 +969,13 @@ static
>>> void hexagon_tr_init_disas_context(DisasContextBase *dcbase,
>>>
>>>       ctx->mem_idx = FIELD_EX32(hex_flags, TB_FLAGS, MMU_INDEX);
>>>       ctx->num_packets = 0;
>>> +    ctx->num_cycles = 0;
>> Guard
>>
>>>       ctx->num_insns = 0;
>>>       ctx->num_hvx_insns = 0;
>>>       ctx->branch_cond = TCG_COND_NEVER;
>>>       ctx->is_tight_loop = FIELD_EX32(hex_flags, TB_FLAGS, IS_TIGHT_LOOP);
>>>       ctx->short_circuit = hex_cpu->short_circuit;
>>> +    ctx->pcycle_enabled = FIELD_EX32(hex_flags, TB_FLAGS,
>>> + PCYCLE_ENABLED);
>> Guard
>>
>>>   }
>>>
>>>   static void hexagon_tr_tb_start(DisasContextBase *db, CPUState *cpu) @@
>>> -1077,6 +1102,8 @@ void hexagon_translate_init(void)
>>>           offsetof(CPUHexagonState, llsc_val), "llsc_val");
>>>       hex_llsc_val_i64 = tcg_global_mem_new_i64(tcg_env,
>>>           offsetof(CPUHexagonState, llsc_val_i64), "llsc_val_i64");
>>> +    hex_cycle_count = tcg_global_mem_new_i64(tcg_env,
>>> +            offsetof(CPUHexagonState, t_cycle_count), "t_cycle_count");
>> Guard
>
>
> These will remain unguarded as referenced above.
>
>
>>>       for (i = 0; i < STORES_MAX; i++) {
>>>           snprintf(store_addr_names[i], NAME_LEN, "store_addr_%d", i);
>>>           hex_store_addr[i] = tcg_global_mem_new(tcg_env,
>>> --
>>> 2.34.1

