Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 277DCC5DF97
	for <qemu-devel@archiver.kernel.org>; Wed, 26 Aug 2026 12:31:00 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wzCmD-0006y2-09; Wed, 26 Aug 2026 08:30:46 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <rathc@linux.ibm.com>)
 id 1wzClz-0006tT-Th; Wed, 26 Aug 2026 08:30:32 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <rathc@linux.ibm.com>)
 id 1wzClt-0002sb-Op; Wed, 26 Aug 2026 08:30:29 -0400
Received: from pps.filterd (m0360083.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 67QAVRSX3714354; Wed, 26 Aug 2026 12:30:20 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=
 content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=pp1; bh=2eFv+J
 MapZhlcBo6xAtZSqCUnrNbURrvJxXPmOni0vs=; b=edma1XdB4prHGrGDBMoMSf
 b5wsXn9Sa80wSqniBz3y2IWbisljYPXhfZ6hCZTQ6LMhqKMFL8OHJjPXvDgXFqMm
 BK2nrlIhOtrDbNmWgaDEz9CARm4J+pUXoRN7PnZkECvXbXg7u7zTf16vUI2W90cC
 yPuBsDpcKjtVkutBDb+qzBYZws+YFaB17umrB+7D/1NAySshpP0F5R8Q9hY31FtT
 VKSA8NlKLMsHf5h8PqDrA4J6VDdEPmLK96wDcq/3j3ULGLSz9KJRHQWsD89aL3iP
 kk8ayhVfgUZh3hsY/fK8tK1HqfdC4Vwl0SUuOtE6bnM0Zpnzs85l+BJcSTiAWMXg
 ==
Received: from ppma13.dal12v.mail.ibm.com
 (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4g73946k1q-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Wed, 26 Aug 2026 12:30:19 +0000 (GMT)
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
 by ppma13.dal12v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 67QCQHbw032335;
 Wed, 26 Aug 2026 12:30:19 GMT
Received: from smtprelay01.wdc07v.mail.ibm.com ([172.16.1.68])
 by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 4g7raghqe6-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Wed, 26 Aug 2026 12:30:19 +0000 (GMT)
Received: from smtpav01.dal12v.mail.ibm.com (smtpav01.dal12v.mail.ibm.com
 [10.241.53.100])
 by smtprelay01.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 67QCUHk463111578
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Wed, 26 Aug 2026 12:30:17 GMT
Received: from smtpav01.dal12v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 4BA3558059;
 Wed, 26 Aug 2026 12:30:17 +0000 (GMT)
Received: from smtpav01.dal12v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 5BBB258061;
 Wed, 26 Aug 2026 12:30:14 +0000 (GMT)
Received: from [9.111.28.250] (unknown [9.111.28.250])
 by smtpav01.dal12v.mail.ibm.com (Postfix) with ESMTP;
 Wed, 26 Aug 2026 12:30:13 +0000 (GMT)
Message-ID: <b581b4f5-1d2b-4347-b85a-55f745d6f803@linux.ibm.com>
Date: Wed, 26 Aug 2026 18:00:12 +0530
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 02/37] target/ppc: Migrate atomic loads to decodetree
From: Chinmay Rath <rathc@linux.ibm.com>
To: qemu-devel@nongnu.org, qemu-ppc@nongnu.org, harshpb@linux.ibm.com,
 Amit Machhiwal <amachhiw@linux.ibm.com>
References: <20260826050923.74756-1-rathc@linux.ibm.com>
 <20260826050923.74756-3-rathc@linux.ibm.com>
 <20260826140945.286298f2-fa-amachhiw@linux.ibm.com>
 <2bdd4d82-49ec-4de6-8868-31a6e0c377da@linux.ibm.com>
Content-Language: en-US
In-Reply-To: <2bdd4d82-49ec-4de6-8868-31a6e0c377da@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: BF0u7xGtDqyOjBQK34w7d38M_bggJfDd
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODI2MDEwMCBTYWx0ZWRfX0w05+B+CzExk
 QU7wrGkRTskXvMw7HFjraZpBahxeDlF26pMxcxRJrsYr2PZbF+X38XTBo1L583Td+onBw9nUofY
 63mG+f7asaF+12OV5M2Fo9Ou8qLQ5eOxoaEFOzndRALEq542gvfaGpTvDjKPB3zutaLG5Q5Z5L4
 9I1ZcGrbi8z0WNZati+eFYeqLD/PhKHhNDWd6V/7s7FHBcNuVJ10Ub/93wHsMVyfjfSiR3lZtEm
 /yspsUdVKc5vklFUpzU14J49aiekOR911hMe/LKrphAyUCoMTfF0Yutl0AwrCI6mq9le+BHzwz0
 zIwdWfVf/Q37ClP3FPR5QkmTOkg0RmLYMc2cWm+x2NynBZVbN2/3QzThaSknqcKqfzVedeAesWi
 yRnfL2GxSAl6a8o2rr7/2jFC3XAfCYZUx9WWt0IoQ62xuQG06qRnPGwcFEZkIMydJ/lT+BgJ3Kt
 /aAp1X9n2mYR15e8p/g==
X-Authority-Analysis: v=2.4 cv=Y/nIdBeN c=1 sm=1 tr=0 ts=6a8edc5b cx=c_pps
 a=AfN7/Ok6k8XGzOShvHwTGQ==:117 a=AfN7/Ok6k8XGzOShvHwTGQ==:17
 a=IkcTkHD0fZMA:10 a=Sv0fKeRqtYgA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=iQ6ETzBq9ecOQQE5vZCe:22 a=VnNF1IyMAAAA:8
 a=SffLF5zTtkxgmh5VmTEA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
X-Proofpoint-Spam-Info: AW1haW4tMjYwODI2MDEwMCBTYWx0ZWRfX60bgtI+2MN28
 Hmx1abXReSog2XiM5htaVZvEyd8hzL39s2Yx4orJxW2DHT9Duv1GxL/QmlUocIZ1hTAtvq3StCz
 hJafXu1G/zSySGUoR/1K10X0VyjrD/M=
X-Proofpoint-ORIG-GUID: BF0u7xGtDqyOjBQK34w7d38M_bggJfDd
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-26_03,2026-08-26_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 impostorscore=0 priorityscore=1501 adultscore=0 bulkscore=0
 suspectscore=0 malwarescore=0 clxscore=1015 lowpriorityscore=0 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2608260100
Received-SPF: pass client-ip=148.163.156.1; envelope-from=rathc@linux.ibm.com;
 helo=mx0a-001b2d01.pphosted.com
X-Spam_score_int: -26
X-Spam_score: -2.7
X-Spam_bar: --
X-Spam_report: (-2.7 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, RCVD_IN_DNSWL_LOW=-0.7,
 RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001, SPF_HELO_NONE=0.001,
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


On 8/26/26 17:58, Chinmay Rath wrote:
>
> On 8/26/26 14:50, Amit Machhiwal wrote:
>> On 2026/08/26 10:38 AM, Chinmay Rath wrote:
>>> From: Nikhil Kumar Singh <nikhilks@linux.ibm.com>
>>>
>>> Migrate load-and-reserve instructions (lbarx, lharx, lwarx, ldarx,
>>> lqarx) to decodetree using the X-form layout.
>>>
>>> A shared helper (do_load_locked) is introduced for standard-width
>>> variants, while LQARX is handled separately due to its 128-bit
>>> semantics and register pairing constraints.
>>>
>>> The implementation preserves legacy behavior, including:
>>>    - Reservation granularity and overwrite semantics
>>>    - Alignment requirements
>>>    - Invalid instruction cases for LQARX
>>>
>>> Testing:
>>>    - Verified TCG equivalence with legacy implementation
>>>
>>> Signed-off-by: Nikhil Kumar Singh <nikhilks@linux.ibm.com>
>>> Reviewed-by: Glenn Miles <milesg@linux.ibm.com>
>>> Signed-off-by: Chinmay Rath <rathc@linux.ibm.com>
>>> ---
>>>   target/ppc/insn32.decode |   7 +++
>>>   target/ppc/translate.c   | 124 
>>> +++++++++++++++++++--------------------
>>>   2 files changed, 69 insertions(+), 62 deletions(-)
>>>
>>> diff --git a/target/ppc/insn32.decode b/target/ppc/insn32.decode
>>> index 342e65dadf..26948e08a7 100644
>>> --- a/target/ppc/insn32.decode
>>> +++ b/target/ppc/insn32.decode
>>> @@ -1309,6 +1309,13 @@ XVF64GERNN      111011 ... -- .... 0 ..... 
>>> 11111010 ..-  @XX3_at xa=%xx_xa_pair
>>>   ##Extend Sign Word and Shift Left Immediate XS-form
>>>   EXTSWSLI         011111 ..... ..... ..... 110111101 . .         @XS
>>>   +## Load and Reserve Instructions
>>> +LBARX           011111 ..... ..... ..... 0000110100 .   @X_rc
>>> +LHARX           011111 ..... ..... ..... 0001110100 .   @X_rc
>>> +LWARX           011111 ..... ..... ..... 0000010100 .   @X_rc
>>> +LDARX           011111 ..... ..... ..... 0001010100 .   @X_rc
>>> +LQARX           011111 ..... ..... ..... 0100010100 .   @X_rc
>>> +
>>>   ## Vector Division Instructions
>>>     VDIVSW          000100 ..... ..... ..... 00110001011 @VX
>>> diff --git a/target/ppc/translate.c b/target/ppc/translate.c
>>> index e627f48f9e..cc9287dcc5 100644
>>> --- a/target/ppc/translate.c
>>> +++ b/target/ppc/translate.c
>>> @@ -2947,30 +2947,6 @@ static void gen_isync(DisasContext *ctx)
>>>       ctx->base.is_jmp = DISAS_EXIT_UPDATE;
>>>   }
>>>   -static void gen_load_locked(DisasContext *ctx, MemOp memop)
>>> -{
>>> -    TCGv gpr = cpu_gpr[rD(ctx->opcode)];
>>> -    TCGv t0 = tcg_temp_new();
>>> -
>>> -    gen_set_access_type(ctx, ACCESS_RES);
>>> -    gen_addr_reg_index(ctx, t0);
>>> -    tcg_gen_qemu_ld_tl(gpr, t0, ctx->mem_idx, DEF_MEMOP(memop) | 
>>> MO_ALIGN);
>>> -    tcg_gen_mov_tl(cpu_reserve, t0);
>>> -    tcg_gen_movi_tl(cpu_reserve_length, memop_size(memop));
>>> -    tcg_gen_mov_tl(cpu_reserve_val, gpr);
>>> -}
>>> -
>>> -#define LARX(name, memop)                  \
>>> -static void gen_##name(DisasContext *ctx)  \
>>> -{                                          \
>>> -    gen_load_locked(ctx, memop);           \
>>> -}
>>> -
>>> -/* lwarx */
>>> -LARX(lbarx, MO_UB)
>>> -LARX(lharx, MO_UW)
>>> -LARX(lwarx, MO_UL)
>>> -
>>>   static void gen_fetch_inc_conditional(DisasContext *ctx, MemOp memop,
>>>                                         TCGv EA, TCGCond cond, int 
>>> addend)
>>>   {
>>> @@ -3219,42 +3195,9 @@ STCX(sthcx_, MO_UW)
>>>   STCX(stwcx_, MO_UL)
>>>     #if defined(TARGET_PPC64)
>>> -/* ldarx */
>>> -LARX(ldarx, MO_UQ)
>>>   /* stdcx. */
>>>   STCX(stdcx_, MO_UQ)
>>>   -/* lqarx */
>>> -static void gen_lqarx(DisasContext *ctx)
>>> -{
>>> -    int rd = rD(ctx->opcode);
>>> -    TCGv EA, hi, lo;
>>> -    TCGv_i128 t16;
>>> -
>>> -    if (unlikely((rd & 1) || (rd == rA(ctx->opcode)) ||
>>> -                 (rd == rB(ctx->opcode)))) {
>>> -        gen_inval_exception(ctx, POWERPC_EXCP_INVAL_INVAL);
>>> -        return;
>>> -    }
>>> -
>>> -    gen_set_access_type(ctx, ACCESS_RES);
>>> -    EA = tcg_temp_new();
>>> -    gen_addr_reg_index(ctx, EA);
>>> -
>>> -    /* Note that the low part is always in RD+1, even in LE mode.  */
>>> -    lo = cpu_gpr[rd + 1];
>>> -    hi = cpu_gpr[rd];
>>> -
>>> -    t16 = tcg_temp_new_i128();
>>> -    tcg_gen_qemu_ld_i128(t16, EA, ctx->mem_idx, DEF_MEMOP(MO_128 | 
>>> MO_ALIGN));
>>> -    tcg_gen_extr_i128_i64(lo, hi, t16);
>>> -
>>> -    tcg_gen_mov_tl(cpu_reserve, EA);
>>> -    tcg_gen_movi_tl(cpu_reserve_length, 16);
>>> -    tcg_gen_st_tl(hi, tcg_env, offsetof(CPUPPCState, reserve_val));
>>> -    tcg_gen_st_tl(lo, tcg_env, offsetof(CPUPPCState, reserve_val2));
>>> -}
>>> -
>>>   /* stqcx. */
>>>   static void gen_stqcx_(DisasContext *ctx)
>>>   {
>>> @@ -5741,6 +5684,68 @@ static bool trans_EXTSWSLI(DisasContext *ctx, 
>>> arg_XS *a)
>>>       return true;
>>>   }
>>>   +/*
>>> + * Load-and-reserve core
>>> + */
>>> +static bool do_load_locked(DisasContext *ctx, arg_X_rc *a, MemOp 
>>> memop)
>>> +{
>>> +    TCGv EA = do_ea_calc(ctx, a->ra, cpu_gpr[a->rb]);
>>> +    TCGv gpr = cpu_gpr[a->rt];
>>> +
>>> +    gen_set_access_type(ctx, ACCESS_RES);
>>> +
>>> +    tcg_gen_qemu_ld_tl(gpr, EA, ctx->mem_idx, memop | MO_ALIGN);
>>> +
>>> +    tcg_gen_mov_tl(cpu_reserve, EA);
>>> +    tcg_gen_movi_tl(cpu_reserve_length, memop_size(memop));
>>> +
>>> +    tcg_gen_mov_tl(cpu_reserve_val, gpr);
>>> +
>>> +    return true;
>>> +}
>>> +
>>> +TRANS_FLAGS2(ATOMIC_ISA206, LBARX, do_load_locked, DEF_MEMOP(MO_UB))
>>> +TRANS_FLAGS2(ATOMIC_ISA206, LHARX, do_load_locked, DEF_MEMOP(MO_UW))
>>> +TRANS(LWARX, do_load_locked, DEF_MEMOP(MO_UL))
>>> +TRANS64(LDARX, do_load_locked, DEF_MEMOP(MO_UQ))
>>> +
>>> +static bool trans_LQARX(DisasContext *ctx, arg_LQARX *a)
>>> +{
>>> +    REQUIRE_64BIT(ctx);
>>> +    REQUIRE_INSNS_FLAGS2(ctx, ISA207S);
>> The old GEN_HANDLER_E used PPC2_LSQ_ISA207, but the new code uses
>> PPC2_ISA207S . In the current QEMU CPU model set this makes no practical
>> difference — every CPU that sets PPC2_ISA207S also sets PPC2_LSQ_ISA207.
>> However, PPC2_LSQ_ISA207 is the precise flag for this feature and keeps
>> lqarx symmetric with its companion stqcx_ (line 5870) which correctly
>> continues to use PPC2_LSQ_ISA207. Please use REQUIRE_INSNS_FLAGS2(ctx,
>> LSQ_ISA207) for consistency and to guard against future CPU models that
>> may set these flags independently
>
> Hi Amit,
>
> Nice catch ! Thanks !
> In the later patches 32 and 34 in this series, I have consolidated all 
> ISA 2.07 flags into a single flag. Hence both PPC2_LSQ_ISA207 and 
> PPC2_ISA207S are replaced by PPC2_ISA207, hence this is automatically 
> taken care of.
>
> Regards,
> Chinmay
++ Amit, IDK how Thunderbird omitted you out of the sent list.
>
>>
>>> +#if defined(TARGET_PPC64)
>>> +    TCGv EA;
>>> +    TCGv_i128 t16;
>>> +    /* Must use even register and avoid overlap */
>>> +    if (unlikely((a->rt & 1) || (a->rt == a->ra) || (a->rt == 
>>> a->rb))) {
>>> +        gen_inval_exception(ctx, POWERPC_EXCP_INVAL_INVAL);
>>> +        return true;
>>> +    }
>>> +
>>> +    gen_set_access_type(ctx, ACCESS_RES);
>>> +    EA = do_ea_calc(ctx, a->ra, cpu_gpr[a->rb]);
>>> +    t16 = tcg_temp_new_i128();
>>> +
>>> +    tcg_gen_qemu_ld_i128(t16, EA, ctx->mem_idx,
>>> +                         DEF_MEMOP(MO_128 | MO_ALIGN));
>>> +
>>> +    tcg_gen_extr_i128_i64(cpu_gpr[a->rt + 1],
>>> +                         cpu_gpr[a->rt],
>>> +                         t16);
>>> +
>>> +    tcg_gen_mov_tl(cpu_reserve, EA);
>>> +    tcg_gen_movi_tl(cpu_reserve_length, 16);
>>> +
>>> +    tcg_gen_st_i64(cpu_gpr[a->rt],
>>> +                   tcg_env, offsetof(CPUPPCState, reserve_val));
>> All these multi-line calls can be collapsed to single lines — they are
>> within 80 characters respectively and fit within the 80-column limit.
>> The only exception is tcg_gen_st_i64(..., reserve_val2) at 85 chars,
>> which legitimately needs wrapping. The unnecessary line splits add
>> visual noise without any readability benefit.
>>
>>> +    tcg_gen_st_i64(cpu_gpr[a->rt + 1],
>>> +                   tcg_env, offsetof(CPUPPCState, reserve_val2));
>>> +#else
>>> +    qemu_build_not_reached();
>>> +#endif
>>> +    return true;
>>> +}
>>> +
>>>   #include "translate/fixedpoint-impl.c.inc"
>>>     #include "translate/fp-impl.c.inc"
>>> @@ -5853,9 +5858,6 @@ GEN_HANDLER(lswx, 0x1F, 0x15, 0x10, 
>>> 0x00000001, PPC_STRING),
>>>   GEN_HANDLER(stswi, 0x1F, 0x15, 0x16, 0x00000001, PPC_STRING),
>>>   GEN_HANDLER(stswx, 0x1F, 0x15, 0x14, 0x00000001, PPC_STRING),
>>>   GEN_HANDLER(isync, 0x13, 0x16, 0x04, 0x03FFF801, PPC_MEM),
>>> -GEN_HANDLER_E(lbarx, 0x1F, 0x14, 0x01, 0, PPC_NONE, 
>>> PPC2_ATOMIC_ISA206),
>>> -GEN_HANDLER_E(lharx, 0x1F, 0x14, 0x03, 0, PPC_NONE, 
>>> PPC2_ATOMIC_ISA206),
>>> -GEN_HANDLER(lwarx, 0x1F, 0x14, 0x00, 0x00000000, PPC_RES),
>>>   GEN_HANDLER_E(lwat, 0x1F, 0x06, 0x12, 0x00000001, PPC_NONE, 
>>> PPC2_ISA300),
>>>   GEN_HANDLER_E(stwat, 0x1F, 0x06, 0x16, 0x00000001, PPC_NONE, 
>>> PPC2_ISA300),
>>>   GEN_HANDLER_E(stbcx_, 0x1F, 0x16, 0x15, 0, PPC_NONE, 
>>> PPC2_ATOMIC_ISA206),
>>> @@ -5864,8 +5866,6 @@ GEN_HANDLER2(stwcx_, "stwcx.", 0x1F, 0x16, 
>>> 0x04, 0x00000000, PPC_RES),
>>>   #if defined(TARGET_PPC64)
>>>   GEN_HANDLER_E(ldat, 0x1F, 0x06, 0x13, 0x00000001, PPC_NONE, 
>>> PPC2_ISA300),
>>>   GEN_HANDLER_E(stdat, 0x1F, 0x06, 0x17, 0x00000001, PPC_NONE, 
>>> PPC2_ISA300),
>>> -GEN_HANDLER(ldarx, 0x1F, 0x14, 0x02, 0x00000000, PPC_64B),
>>> -GEN_HANDLER_E(lqarx, 0x1F, 0x14, 0x08, 0, PPC_NONE, PPC2_LSQ_ISA207),
>>>   GEN_HANDLER2(stdcx_, "stdcx.", 0x1F, 0x16, 0x06, 0x00000000, 
>>> PPC_64B),
>>>   GEN_HANDLER_E(stqcx_, 0x1F, 0x16, 0x05, 0, PPC_NONE, 
>>> PPC2_LSQ_ISA207),
>>>   #endif
>>> -- 
>>> 2.55.0
>>>

