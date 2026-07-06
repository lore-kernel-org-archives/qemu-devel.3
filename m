Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C181BC43458
	for <qemu-devel@archiver.kernel.org>; Mon,  6 Jul 2026 08:47:55 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wgez6-0004WV-Hd; Mon, 06 Jul 2026 04:47:24 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <rathc@linux.ibm.com>)
 id 1wgeyg-0004N3-0T; Mon, 06 Jul 2026 04:47:00 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <rathc@linux.ibm.com>)
 id 1wgeyd-0004t4-Qs; Mon, 06 Jul 2026 04:46:57 -0400
Received: from pps.filterd (m0356517.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 665MICUx2197646; Mon, 6 Jul 2026 08:46:53 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=pp1; bh=Ie1+he
 nrbuBUITEqyhb/C1jsytJ2vCrz2vuo1jXwDn0=; b=dEe23vV0/mPm4SJQ7z66Xh
 5D/kq97M0NaDo5/t1BcU92jrKpb9X1uEPVqukB6uXsL/o4RC0ezLC1lLd6WL3BV5
 y8qXtRn0yt74qukIYWs36fH9tC7I8B1WyDRRfOKcBcR/nOuXm/VWyQ2TbsOZ56ws
 GMsxIMemUxVd0sZahJituIev5lfuC0FCp4pF3vvMedopIlYnMPTDGGTHAP468gOu
 1IrbxylQIL05A5TqGsc4M8+uTGhSMyQyKQMuAIJl1IFvkX7+3bYYxWvn9FKG3CCA
 FfXd0l9MEFEdZBRNeP7DrztcMdSqVLMAiWt95gzhdn5d1tfNun0pFTxm/z9rfiTA
 ==
Received: from ppma23.wdc07v.mail.ibm.com
 (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4f6sw4ggny-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Mon, 06 Jul 2026 08:46:52 +0000 (GMT)
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
 by ppma23.wdc07v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 6668Yah7007089;
 Mon, 6 Jul 2026 08:46:51 GMT
Received: from smtprelay03.dal12v.mail.ibm.com ([172.16.1.5])
 by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4f7e0h4psm-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Mon, 06 Jul 2026 08:46:51 +0000 (GMT)
Received: from smtpav03.wdc07v.mail.ibm.com (smtpav03.wdc07v.mail.ibm.com
 [10.39.53.230])
 by smtprelay03.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 6668koH220775466
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Mon, 6 Jul 2026 08:46:50 GMT
Received: from smtpav03.wdc07v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 4E1335805A;
 Mon,  6 Jul 2026 08:46:50 +0000 (GMT)
Received: from smtpav03.wdc07v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id BD90C58054;
 Mon,  6 Jul 2026 08:46:47 +0000 (GMT)
Received: from [9.123.8.229] (unknown [9.123.8.229])
 by smtpav03.wdc07v.mail.ibm.com (Postfix) with ESMTPS;
 Mon,  6 Jul 2026 08:46:47 +0000 (GMT)
Message-ID: <b75abeab-969d-4866-ae5c-4ac424394adf@linux.ibm.com>
Date: Mon, 6 Jul 2026 14:15:26 +0530
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH 02/28] target/ppc: Migrate atomic loads to decodetree
To: qemu-devel@nongnu.org, qemu-ppc@nongnu.org, nikhilks@linux.ibm.com
Cc: milesg@linux.ibm.com, shivangu@linux.ibm.com, harshpb@linux.ibm.com,
 adityag@linux.ibm.com
References: <20260520160728.2283628-1-rathc@linux.ibm.com>
 <20260520160728.2283628-3-rathc@linux.ibm.com>
Content-Language: en-US
From: Chinmay Rath <rathc@linux.ibm.com>
In-Reply-To: <20260520160728.2283628-3-rathc@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: tU6uTSiFU2AyBMugMuHr09UAOXzIvVWI
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzA2MDA4MyBTYWx0ZWRfXyfA/SH02+i9D
 cqp/9GB3Nby/PwSzIe7MIDZKDlR2zHdHL2PnOrTCwmw9sjmcuNFD270g3Tgv3PbLEgJAEO11xKI
 B9hHw4x5SW1+jQrPo72wYnT7JVtUPaoNcY2LMaMmUCu8lVH2JKlPT48QXilSEAYecaQl9VU4nXv
 tGQweepkVBWrunD7PhSqi5X2fAQx8/q2+7yzZA35oVeGgrn75kqNerQ+8TzJ08P3ZP7FCdlQv24
 umX2bMtHPml62CAUtGL0zEzkvGBfEG3WCVxXc/7Mq6HqhAMt363m0+K0dPKJ4DnsK5b/oF7wyg5
 ihQofryi6u5TUUe2pjpAfgSIRIEaDa53uv2SQ3pqaj1yHLYB9eESPOlnxhlgFuY7D0SPDYLVtrg
 7JmBvfpRxADqmqwqakgZQr5RbmeBLS345GB2Njl9cKioYfQfts2CeW6QdFXb9P228UjBI6DFjhF
 mqEZl6UBSbeKBfBtz7w==
X-Proofpoint-ORIG-GUID: tU6uTSiFU2AyBMugMuHr09UAOXzIvVWI
X-Authority-Analysis: v=2.4 cv=FqQ1OWrq c=1 sm=1 tr=0 ts=6a4b6b7c cx=c_pps
 a=3Bg1Hr4SwmMryq2xdFQyZA==:117 a=3Bg1Hr4SwmMryq2xdFQyZA==:17
 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=U7nrCbtTmkRpXpFmAIza:22 a=VnNF1IyMAAAA:8
 a=JGJutt_2QnLkHhJhs3YA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzA2MDA4MyBTYWx0ZWRfX8t/UfRWwE5X7
 LPjRTDM1PDcZ/H+PtUpaqhd+n4QDLPTQagFh3GLAe8A8CQRF2ivemzF+8i0Z9lBd3YH3eI7wxcI
 nQsUGi3lbJLqWxvEZwWrTLGPvgXr+XU=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-07-05_02,2026-07-03_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 impostorscore=0 clxscore=1015 malwarescore=0 lowpriorityscore=0
 priorityscore=1501 bulkscore=0 suspectscore=0 spamscore=0 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607060083
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


On 5/20/26 21:37, Chinmay Rath wrote:
> From: Nikhil Kumar Singh <nikhilks@linux.ibm.com>
>
> Migrate load-and-reserve instructions (lbarx, lharx, lwarx, ldarx,
> lqarx) to decodetree using the X-form layout.
>
> A shared helper (do_load_locked) is introduced for standard-width
> variants, while LQARX is handled separately due to its 128-bit
> semantics and register pairing constraints.
>
> The implementation preserves legacy behavior, including:
>    - Reservation granularity and overwrite semantics
>    - Alignment requirements
>    - Invalid instruction cases for LQARX
>
> Testing:
>    - Verified TCG equivalence with legacy implementation
>
> Signed-off-by: Nikhil Kumar Singh <nikhilks@linux.ibm.com>
> Signed-off-by: Chinmay Rath <rathc@linux.ibm.com>
> [cr: ppc32 build fix, using @X_rc for decode]
> ---
>   target/ppc/insn32.decode |   7 ++
>   target/ppc/translate.c   | 142 ++++++++++++++++++++++-----------------
>   2 files changed, 87 insertions(+), 62 deletions(-)
>
> diff --git a/target/ppc/insn32.decode b/target/ppc/insn32.decode
> index 342e65dadf..26948e08a7 100644
> --- a/target/ppc/insn32.decode
> +++ b/target/ppc/insn32.decode
> @@ -1309,6 +1309,13 @@ XVF64GERNN      111011 ... -- .... 0 ..... 11111010 ..-  @XX3_at xa=%xx_xa_pair
>   ##Extend Sign Word and Shift Left Immediate XS-form
>   EXTSWSLI         011111 ..... ..... ..... 110111101 . .         @XS
>   
> +## Load and Reserve Instructions
> +LBARX           011111 ..... ..... ..... 0000110100 .   @X_rc
> +LHARX           011111 ..... ..... ..... 0001110100 .   @X_rc
> +LWARX           011111 ..... ..... ..... 0000010100 .   @X_rc
> +LDARX           011111 ..... ..... ..... 0001010100 .   @X_rc
> +LQARX           011111 ..... ..... ..... 0100010100 .   @X_rc
> +
>   ## Vector Division Instructions
>   
>   VDIVSW          000100 ..... ..... ..... 00110001011    @VX
> diff --git a/target/ppc/translate.c b/target/ppc/translate.c
> index e802414fca..3f009cd9ca 100644
> --- a/target/ppc/translate.c
> +++ b/target/ppc/translate.c
> @@ -2947,30 +2947,6 @@ static void gen_isync(DisasContext *ctx)
>       ctx->base.is_jmp = DISAS_EXIT_UPDATE;
>   }
>   
> -static void gen_load_locked(DisasContext *ctx, MemOp memop)
> -{
> -    TCGv gpr = cpu_gpr[rD(ctx->opcode)];
> -    TCGv t0 = tcg_temp_new();
> -
> -    gen_set_access_type(ctx, ACCESS_RES);
> -    gen_addr_reg_index(ctx, t0);
> -    tcg_gen_qemu_ld_tl(gpr, t0, ctx->mem_idx, DEF_MEMOP(memop) | MO_ALIGN);
> -    tcg_gen_mov_tl(cpu_reserve, t0);
> -    tcg_gen_movi_tl(cpu_reserve_length, memop_size(memop));
> -    tcg_gen_mov_tl(cpu_reserve_val, gpr);
> -}
> -
> -#define LARX(name, memop)                  \
> -static void gen_##name(DisasContext *ctx)  \
> -{                                          \
> -    gen_load_locked(ctx, memop);           \
> -}
> -
> -/* lwarx */
> -LARX(lbarx, MO_UB)
> -LARX(lharx, MO_UW)
> -LARX(lwarx, MO_UL)
> -
>   static void gen_fetch_inc_conditional(DisasContext *ctx, MemOp memop,
>                                         TCGv EA, TCGCond cond, int addend)
>   {
> @@ -3219,42 +3195,9 @@ STCX(sthcx_, MO_UW)
>   STCX(stwcx_, MO_UL)
>   
>   #if defined(TARGET_PPC64)
> -/* ldarx */
> -LARX(ldarx, MO_UQ)
>   /* stdcx. */
>   STCX(stdcx_, MO_UQ)
>   
> -/* lqarx */
> -static void gen_lqarx(DisasContext *ctx)
> -{
> -    int rd = rD(ctx->opcode);
> -    TCGv EA, hi, lo;
> -    TCGv_i128 t16;
> -
> -    if (unlikely((rd & 1) || (rd == rA(ctx->opcode)) ||
> -                 (rd == rB(ctx->opcode)))) {
> -        gen_inval_exception(ctx, POWERPC_EXCP_INVAL_INVAL);
> -        return;
> -    }
> -
> -    gen_set_access_type(ctx, ACCESS_RES);
> -    EA = tcg_temp_new();
> -    gen_addr_reg_index(ctx, EA);
> -
> -    /* Note that the low part is always in RD+1, even in LE mode.  */
> -    lo = cpu_gpr[rd + 1];
> -    hi = cpu_gpr[rd];
> -
> -    t16 = tcg_temp_new_i128();
> -    tcg_gen_qemu_ld_i128(t16, EA, ctx->mem_idx, DEF_MEMOP(MO_128 | MO_ALIGN));
> -    tcg_gen_extr_i128_i64(lo, hi, t16);
> -
> -    tcg_gen_mov_tl(cpu_reserve, EA);
> -    tcg_gen_movi_tl(cpu_reserve_length, 16);
> -    tcg_gen_st_tl(hi, tcg_env, offsetof(CPUPPCState, reserve_val));
> -    tcg_gen_st_tl(lo, tcg_env, offsetof(CPUPPCState, reserve_val2));
> -}
> -
>   /* stqcx. */
>   static void gen_stqcx_(DisasContext *ctx)
>   {
> @@ -5741,6 +5684,86 @@ static bool trans_EXTSWSLI(DisasContext *ctx, arg_XS *a)
>       return true;
>   }
>   
> +/*
> + * Load-and-reserve core
> + */
> +static bool do_load_locked(DisasContext *ctx, arg_X_rc *a, MemOp memop)
> +{
> +    TCGv EA = do_ea_calc(ctx, a->ra, cpu_gpr[a->rb]);
> +    TCGv gpr = cpu_gpr[a->rt];
> +
> +    gen_set_access_type(ctx, ACCESS_RES);
> +
> +    tcg_gen_qemu_ld_tl(gpr, EA, ctx->mem_idx, memop | MO_ALIGN);
> +
> +    tcg_gen_mov_tl(cpu_reserve, EA);
> +    tcg_gen_movi_tl(cpu_reserve_length, memop_size(memop));
> +
> +    tcg_gen_mov_tl(cpu_reserve_val, gpr);
> +
> +    return true;
> +}
> +
> +static bool trans_LBARX(DisasContext *ctx, arg_LBARX *a)
> +{
> +    REQUIRE_INSNS_FLAGS2(ctx, ATOMIC_ISA206);
> +    return do_load_locked(ctx, a, DEF_MEMOP(MO_UB));
> +}
> +
> +static bool trans_LHARX(DisasContext *ctx, arg_LHARX *a)
> +{
> +    REQUIRE_INSNS_FLAGS2(ctx, ATOMIC_ISA206);
> +    return do_load_locked(ctx, a, DEF_MEMOP(MO_UW));
> +}
> +
> +static bool trans_LWARX(DisasContext *ctx, arg_LWARX *a)
> +{
> +    return do_load_locked(ctx, a, DEF_MEMOP(MO_UL));
> +}
> +
> +static bool trans_LDARX(DisasContext *ctx, arg_LDARX *a)
> +{
> +    REQUIRE_64BIT(ctx);
> +    return do_load_locked(ctx, a, DEF_MEMOP(MO_UQ));
> +}
For the above 4 trans_XXX() handlers making use of do_load_locked(), 
please use TRANS, TRANS64, TRANS_FLAGS, etc macros.

Thanks,
Chinmay
> +
> +static bool trans_LQARX(DisasContext *ctx, arg_LQARX *a)
> +{
> +    REQUIRE_64BIT(ctx);
> +    REQUIRE_INSNS_FLAGS2(ctx, ISA207S);
> +#if defined(TARGET_PPC64)
> +    TCGv EA;
> +    TCGv_i128 t16;
> +    /* Must use even register and avoid overlap */
> +    if (unlikely((a->rt & 1) || (a->rt == a->ra) || (a->rt == a->rb))) {
> +        gen_inval_exception(ctx, POWERPC_EXCP_INVAL_INVAL);
> +        return true;
> +    }
> +
> +    gen_set_access_type(ctx, ACCESS_RES);
> +    EA = do_ea_calc(ctx, a->ra, cpu_gpr[a->rb]);
> +    t16 = tcg_temp_new_i128();
> +
> +    tcg_gen_qemu_ld_i128(t16, EA, ctx->mem_idx,
> +                         DEF_MEMOP(MO_128 | MO_ALIGN));
> +
> +    tcg_gen_extr_i128_i64(cpu_gpr[a->rt + 1],
> +                         cpu_gpr[a->rt],
> +                         t16);
> +
> +    tcg_gen_mov_tl(cpu_reserve, EA);
> +    tcg_gen_movi_tl(cpu_reserve_length, 16);
> +
> +    tcg_gen_st_i64(cpu_gpr[a->rt],
> +                   tcg_env, offsetof(CPUPPCState, reserve_val));
> +    tcg_gen_st_i64(cpu_gpr[a->rt + 1],
> +                   tcg_env, offsetof(CPUPPCState, reserve_val2));
> +#else
> +    qemu_build_not_reached();
> +#endif
> +    return true;
> +}
> +
>   #include "translate/fixedpoint-impl.c.inc"
>   
>   #include "translate/fp-impl.c.inc"
> @@ -5853,9 +5876,6 @@ GEN_HANDLER(lswx, 0x1F, 0x15, 0x10, 0x00000001, PPC_STRING),
>   GEN_HANDLER(stswi, 0x1F, 0x15, 0x16, 0x00000001, PPC_STRING),
>   GEN_HANDLER(stswx, 0x1F, 0x15, 0x14, 0x00000001, PPC_STRING),
>   GEN_HANDLER(isync, 0x13, 0x16, 0x04, 0x03FFF801, PPC_MEM),
> -GEN_HANDLER_E(lbarx, 0x1F, 0x14, 0x01, 0, PPC_NONE, PPC2_ATOMIC_ISA206),
> -GEN_HANDLER_E(lharx, 0x1F, 0x14, 0x03, 0, PPC_NONE, PPC2_ATOMIC_ISA206),
> -GEN_HANDLER(lwarx, 0x1F, 0x14, 0x00, 0x00000000, PPC_RES),
>   GEN_HANDLER_E(lwat, 0x1F, 0x06, 0x12, 0x00000001, PPC_NONE, PPC2_ISA300),
>   GEN_HANDLER_E(stwat, 0x1F, 0x06, 0x16, 0x00000001, PPC_NONE, PPC2_ISA300),
>   GEN_HANDLER_E(stbcx_, 0x1F, 0x16, 0x15, 0, PPC_NONE, PPC2_ATOMIC_ISA206),
> @@ -5864,8 +5884,6 @@ GEN_HANDLER2(stwcx_, "stwcx.", 0x1F, 0x16, 0x04, 0x00000000, PPC_RES),
>   #if defined(TARGET_PPC64)
>   GEN_HANDLER_E(ldat, 0x1F, 0x06, 0x13, 0x00000001, PPC_NONE, PPC2_ISA300),
>   GEN_HANDLER_E(stdat, 0x1F, 0x06, 0x17, 0x00000001, PPC_NONE, PPC2_ISA300),
> -GEN_HANDLER(ldarx, 0x1F, 0x14, 0x02, 0x00000000, PPC_64B),
> -GEN_HANDLER_E(lqarx, 0x1F, 0x14, 0x08, 0, PPC_NONE, PPC2_LSQ_ISA207),
>   GEN_HANDLER2(stdcx_, "stdcx.", 0x1F, 0x16, 0x06, 0x00000000, PPC_64B),
>   GEN_HANDLER_E(stqcx_, 0x1F, 0x16, 0x05, 0, PPC_NONE, PPC2_LSQ_ISA207),
>   #endif

