Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2CC30C43458
	for <qemu-devel@archiver.kernel.org>; Mon,  6 Jul 2026 18:10:18 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wgnlH-0001Cb-Q0; Mon, 06 Jul 2026 14:09:43 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <nikhilks@linux.ibm.com>)
 id 1wgnlA-0001Ba-Ph; Mon, 06 Jul 2026 14:09:36 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <nikhilks@linux.ibm.com>)
 id 1wgnl8-0005Tz-IN; Mon, 06 Jul 2026 14:09:36 -0400
Received: from pps.filterd (m0356516.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 666FIqxX756889; Mon, 6 Jul 2026 18:09:31 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=pp1; bh=i50L/y
 LnXQB+MNtcUaDzYke8OAk/eOwbziA8V/DDwlQ=; b=qR3UfGoH0BdkTbFXA7eJy8
 Nz0s1zV0tHL00q+WaMxVuB1I/gyq2RKzKDV2tR0UYamFnw20l8FEPB+Aivb1Akqm
 aZVMcIH0bk1Fuiakg9gpxNziYP+yxsgtf7uJTPjhXXgLazQMAU6F72hntPivoHt1
 7Fh8i9icZjz5sz+nLFS8NomNuVMB0wB4MGZRniFmxGGjiRuJWEOkw7QiWId1XvXK
 Wp17k6qfjLesOCHQYuK8W9R994x7Xc1z+64V+7vwbnjCUcGS18PYNJtWGVV+tPu7
 vgJDxofJxU1zJaafouL7gf0y5HMyIN2v3YW3kwPLvUPCMleCZW5HtVw9dhMgozbg
 ==
Received: from ppma22.wdc07v.mail.ibm.com
 (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4f6qknauuc-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Mon, 06 Jul 2026 18:09:30 +0000 (GMT)
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
 by ppma22.wdc07v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 666I4nTI027443;
 Mon, 6 Jul 2026 18:09:30 GMT
Received: from smtprelay07.fra02v.mail.ibm.com ([9.218.2.229])
 by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4f7cvvxuk5-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Mon, 06 Jul 2026 18:09:29 +0000 (GMT)
Received: from smtpav06.fra02v.mail.ibm.com (smtpav06.fra02v.mail.ibm.com
 [10.20.54.105])
 by smtprelay07.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 666I9PGl44826898
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Mon, 6 Jul 2026 18:09:25 GMT
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id B38F320049;
 Mon,  6 Jul 2026 18:09:25 +0000 (GMT)
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 6BBB820040;
 Mon,  6 Jul 2026 18:09:17 +0000 (GMT)
Received: from [9.67.146.25] (unknown [9.67.146.25])
 by smtpav06.fra02v.mail.ibm.com (Postfix) with ESMTP;
 Mon,  6 Jul 2026 18:09:16 +0000 (GMT)
Message-ID: <85806173-0fb8-46d2-a69b-6743de12b2c5@linux.ibm.com>
Date: Mon, 6 Jul 2026 23:39:15 +0530
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH 22/28] target/ppc: Move Fixed-Point Load/Store String
 instructions to decodetree.
To: Chinmay Rath <rathc@linux.ibm.com>, qemu-devel@nongnu.org,
 qemu-ppc@nongnu.org, npiggin@gmail.com, harshpb@linux.ibm.com,
 richard.henderson@linaro.org, peter.maydell@linaro.org, stefanha@redhat.com
Cc: milesg@linux.ibm.com, vishalc@linux.ibm.com, tshah@linux.ibm.com,
 shivangu@linux.ibm.com, ojaswin@linux.ibm.com, aboorvad@linux.ibm.com,
 amachhiw@linux.ibm.com, sv@linux.ibm.com, shivani@linux.ibm.com,
 mkchauras@gmail.com, uverma@linux.ibm.com
References: <20260520160728.2283628-1-rathc@linux.ibm.com>
 <20260520160728.2283628-23-rathc@linux.ibm.com>
Content-Language: en-US
From: Nikhil Kumar Singh <nikhilks@linux.ibm.com>
In-Reply-To: <20260520160728.2283628-23-rathc@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Authority-Analysis: v=2.4 cv=Q/XiJY2a c=1 sm=1 tr=0 ts=6a4bef5b cx=c_pps
 a=5BHTudwdYE3Te8bg5FgnPg==:117 a=5BHTudwdYE3Te8bg5FgnPg==:17
 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=Y2IxJ9c9Rs8Kov3niI8_:22 a=VnNF1IyMAAAA:8
 a=S40DjwmI8Mk8vhn0oP0A:9 a=QEXdDO2ut3YA:10
X-Proofpoint-GUID: VSKKtTwMwk8CpILL55PIlI6Z69KOQxEw
X-Proofpoint-ORIG-GUID: j1V8jAtDLgKGF6V6ZuAtIFZ9GW0qpcqj
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzA2MDE4MCBTYWx0ZWRfX8QvpmI41up7O
 XKdJ/ClIHqDhyqyxgxGv1TTBuI2OtQNPuVJKmjdTh7xCHEli8+uro5OLHrMntT36M35JZ7Ok23P
 BG0H7n+bioVkrD6GREVEJokGEfLOvj4=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzA2MDE4MCBTYWx0ZWRfXywiSwGgWGAkB
 rAaPtR6fY0bdMRTGwOmejFurWT78zDkItDDEymCkuPaEz07F4X5wpvV/1Z8SZGh924zr75KrUcN
 HFB1qIyGbt8q7z2K9viIhNFjLODtb21DtqL4zHy5tiGfRa5fohJ2XrQ8O4tmWMpoxuDSHkuehOt
 Q9X6geDeFQ4vAoZNb1vrHTw0V4Q1Vt6nn9NpQ1xvdImZLBCMrheADoXIo5Fv4dv2cpVA0vu46iI
 fVd+cTr62qmrGjy/fEIs/hxWLC2fs41OXqFaK56Z3WNdL9M4RIBPrCMf43ru9HrwWZOyqN7yNFf
 FX5/JprCc6P5QX8836+akCGqcvYDlBPynKArPQ9RqXwBoU/MxksT+1Ap0u4/nNJxCdMESGyolm/
 upT6uG47nHOKdep6Nk2fa3QPOMcW4/XmCeD0M+OAjbGveavaJB0YicLTYHCMSPAQtwD2BeLU82g
 u2pIzKaSTw3Hr2c9gpA==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-06_02,2026-07-06_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 impostorscore=0 spamscore=0 phishscore=0 priorityscore=1501
 bulkscore=0 clxscore=1015 lowpriorityscore=0 suspectscore=0 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607060180
Received-SPF: pass client-ip=148.163.158.5;
 envelope-from=nikhilks@linux.ibm.com; helo=mx0b-001b2d01.pphosted.com
X-Spam_score_int: -26
X-Spam_score: -2.7
X-Spam_bar: --
X-Spam_report: (-2.7 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, RCVD_IN_DNSWL_LOW=-0.7,
 RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001, SPF_HELO_NONE=0.001,
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


On 20/05/26 21:37, Chinmay Rath wrote:
> From: Shivang Upadhyay <shivangu@linux.ibm.com>
>
> Move below instructions to decodetree specification :
>
>          lsw{i, x},
>          stsw{i, x}                       : X-form
>
> The changes were verified by validating that the tcg ops generated by
> those instructions remain the same, which were captured with the '-d
> in_asm,op' flag.
>
> Signed-off-by: Shivang Upadhyay <shivangu@linux.ibm.com>
> Signed-off-by: Chinmay Rath <rathc@linux.ibm.com>
> ---
>   target/ppc/helper.h                        |   6 +-
>   target/ppc/insn32.decode                   |   7 ++
>   target/ppc/mem_helper.c                    |   6 +-
>   target/ppc/translate.c                     | 102 --------------------
>   target/ppc/translate/fixedpoint-impl.c.inc | 103 +++++++++++++++++++++
>   5 files changed, 116 insertions(+), 108 deletions(-)
>
> diff --git a/target/ppc/helper.h b/target/ppc/helper.h
> index dacc4e223e..50493a72a5 100644
> --- a/target/ppc/helper.h
> +++ b/target/ppc/helper.h
> @@ -45,9 +45,9 @@ DEF_HELPER_1(check_tlb_flush_global, void, env)
>   
>   DEF_HELPER_3(lmw, void, env, tl, i32)
>   DEF_HELPER_FLAGS_3(stmw, TCG_CALL_NO_WG, void, env, tl, i32)
> -DEF_HELPER_4(lsw, void, env, tl, i32, i32)
> -DEF_HELPER_5(lswx, void, env, tl, i32, i32, i32)
> -DEF_HELPER_FLAGS_4(stsw, TCG_CALL_NO_WG, void, env, tl, i32, i32)
> +DEF_HELPER_4(LSW, void, env, tl, i32, i32)
> +DEF_HELPER_5(LSWX, void, env, tl, i32, i32, i32)
> +DEF_HELPER_FLAGS_4(STSW, TCG_CALL_NO_WG, void, env, tl, i32, i32)
>   DEF_HELPER_FLAGS_3(DCBZ, TCG_CALL_NO_WG, void, env, tl, int)
>   #ifdef TARGET_PPC64
>   DEF_HELPER_FLAGS_2(DCBZL, TCG_CALL_NO_WG, void, env, tl)
> diff --git a/target/ppc/insn32.decode b/target/ppc/insn32.decode
> index f3a1f7970e..0ec9a4d5de 100644
> --- a/target/ppc/insn32.decode
> +++ b/target/ppc/insn32.decode
> @@ -527,6 +527,13 @@ CREQV           010011 ..... ..... ..... 0100100001 -  @X
>   CRANDC          010011 ..... ..... ..... 0010000001 -  @X
>   CRORC           010011 ..... ..... ..... 0110100001 -  @X
>   
> +# Fixed Point Move Assist Instructions
> +
> +LSWI            011111 ..... ..... ..... 1 001010101 -  @X
> +LSWX            011111 ..... ..... ..... 1 000010101 -  @X
> +STSWI           011111 ..... ..... ..... 1 011010101 -  @X
> +STSWX           011111 ..... ..... ..... 1 010010101 -  @X
> +
>   # Fixed-Point Hash Instructions
>   
>   HASHST          011111 ..... ..... ..... 1011010010 .   @X_DW
> diff --git a/target/ppc/mem_helper.c b/target/ppc/mem_helper.c
> index 5d3d377261..303eec4ee5 100644
> --- a/target/ppc/mem_helper.c
> +++ b/target/ppc/mem_helper.c
> @@ -190,7 +190,7 @@ static void do_lsw(CPUPPCState *env, target_ulong addr, uint32_t nb,
>       env->gpr[reg] = val;
>   }
>   
> -void helper_lsw(CPUPPCState *env, target_ulong addr,
> +void helper_LSW(CPUPPCState *env, target_ulong addr,
>                   uint32_t nb, uint32_t reg)
>   {
>       do_lsw(env, addr, nb, reg, GETPC());
> @@ -202,7 +202,7 @@ void helper_lsw(CPUPPCState *env, target_ulong addr,
>    * this is valid, but rA won't be loaded.  For now, I'll follow the
>    * spec...
>    */
> -void helper_lswx(CPUPPCState *env, target_ulong addr, uint32_t reg,
> +void helper_LSWX(CPUPPCState *env, target_ulong addr, uint32_t reg,
>                    uint32_t ra, uint32_t rb)
>   {
>       if (likely(xer_bc != 0)) {
> @@ -218,7 +218,7 @@ void helper_lswx(CPUPPCState *env, target_ulong addr, uint32_t reg,
>       }
>   }
>   
> -void helper_stsw(CPUPPCState *env, target_ulong addr, uint32_t nb,
> +void helper_STSW(CPUPPCState *env, target_ulong addr, uint32_t nb,
>                    uint32_t reg)
>   {
>       uintptr_t raddr = GETPC();
> diff --git a/target/ppc/translate.c b/target/ppc/translate.c
> index 85bdb7deab..fc107399db 100644
> --- a/target/ppc/translate.c
> +++ b/target/ppc/translate.c
> @@ -2597,104 +2597,6 @@ static void gen_stmw(DisasContext *ctx)
>       gen_helper_stmw(tcg_env, t0, t1);
>   }
>   
> -/***                    Integer load and store strings                     ***/
> -
> -/* lswi */
> -/*
> - * PowerPC32 specification says we must generate an exception if rA is
> - * in the range of registers to be loaded.  In an other hand, IBM says
> - * this is valid, but rA won't be loaded.  For now, I'll follow the
> - * spec...
> - */
> -static void gen_lswi(DisasContext *ctx)
> -{
> -    TCGv t0;
> -    TCGv_i32 t1, t2;
> -    int nb = NB(ctx->opcode);
> -    int start = rD(ctx->opcode);
> -    int ra = rA(ctx->opcode);
> -    int nr;
> -
> -    if (ctx->le_mode) {
> -        gen_align_no_le(ctx);
> -        return;
> -    }
> -    if (nb == 0) {
> -        nb = 32;
> -    }
> -    nr = DIV_ROUND_UP(nb, 4);
> -    if (unlikely(lsw_reg_in_range(start, nr, ra))) {
> -        gen_inval_exception(ctx, POWERPC_EXCP_INVAL_LSWX);
> -        return;
> -    }
> -    gen_set_access_type(ctx, ACCESS_INT);
> -    t0 = tcg_temp_new();
> -    gen_addr_register(ctx, t0);
> -    t1 = tcg_constant_i32(nb);
> -    t2 = tcg_constant_i32(start);
> -    gen_helper_lsw(tcg_env, t0, t1, t2);
> -}
> -
> -/* lswx */
> -static void gen_lswx(DisasContext *ctx)
> -{
> -    TCGv t0;
> -    TCGv_i32 t1, t2, t3;
> -
> -    if (ctx->le_mode) {
> -        gen_align_no_le(ctx);
> -        return;
> -    }
> -    gen_set_access_type(ctx, ACCESS_INT);
> -    t0 = tcg_temp_new();
> -    gen_addr_reg_index(ctx, t0);
> -    t1 = tcg_constant_i32(rD(ctx->opcode));
> -    t2 = tcg_constant_i32(rA(ctx->opcode));
> -    t3 = tcg_constant_i32(rB(ctx->opcode));
> -    gen_helper_lswx(tcg_env, t0, t1, t2, t3);
> -}
> -
> -/* stswi */
> -static void gen_stswi(DisasContext *ctx)
> -{
> -    TCGv t0;
> -    TCGv_i32 t1, t2;
> -    int nb = NB(ctx->opcode);
> -
> -    if (ctx->le_mode) {
> -        gen_align_no_le(ctx);
> -        return;
> -    }
> -    gen_set_access_type(ctx, ACCESS_INT);
> -    t0 = tcg_temp_new();
> -    gen_addr_register(ctx, t0);
> -    if (nb == 0) {
> -        nb = 32;
> -    }
> -    t1 = tcg_constant_i32(nb);
> -    t2 = tcg_constant_i32(rS(ctx->opcode));
> -    gen_helper_stsw(tcg_env, t0, t1, t2);
> -}
> -
> -/* stswx */
> -static void gen_stswx(DisasContext *ctx)
> -{
> -    TCGv t0;
> -    TCGv_i32 t1, t2;
> -
> -    if (ctx->le_mode) {
> -        gen_align_no_le(ctx);
> -        return;
> -    }
> -    gen_set_access_type(ctx, ACCESS_INT);
> -    t0 = tcg_temp_new();
> -    gen_addr_reg_index(ctx, t0);
> -    t1 = tcg_temp_new_i32();
> -    tcg_gen_trunc_tl_i32(t1, cpu_xer);
> -    tcg_gen_andi_i32(t1, t1, 0x7F);
> -    t2 = tcg_constant_i32(rS(ctx->opcode));
> -    gen_helper_stsw(tcg_env, t0, t1, t2);
> -}
>   
>   #if !defined(CONFIG_USER_ONLY)
>   static inline void gen_check_tlb_flush(DisasContext *ctx, bool global)
> @@ -4940,10 +4842,6 @@ GEN_HANDLER_E(dform39, 0x39, 0xFF, 0xFF, 0x00000000, PPC_NONE, PPC2_ISA205),
>   GEN_HANDLER_E(dform3D, 0x3D, 0xFF, 0xFF, 0x00000000, PPC_NONE, PPC2_ISA205),
>   GEN_HANDLER(lmw, 0x2E, 0xFF, 0xFF, 0x00000000, PPC_INTEGER),
>   GEN_HANDLER(stmw, 0x2F, 0xFF, 0xFF, 0x00000000, PPC_INTEGER),
> -GEN_HANDLER(lswi, 0x1F, 0x15, 0x12, 0x00000001, PPC_STRING),
> -GEN_HANDLER(lswx, 0x1F, 0x15, 0x10, 0x00000001, PPC_STRING),
> -GEN_HANDLER(stswi, 0x1F, 0x15, 0x16, 0x00000001, PPC_STRING),
> -GEN_HANDLER(stswx, 0x1F, 0x15, 0x14, 0x00000001, PPC_STRING),
>   /* ISA v3.0 changed the extended opcode from 62 to 30 */
>   GEN_HANDLER(rfi, 0x13, 0x12, 0x01, 0x03FF8001, PPC_FLOW),
>   #if defined(TARGET_PPC64)
> diff --git a/target/ppc/translate/fixedpoint-impl.c.inc b/target/ppc/translate/fixedpoint-impl.c.inc
> index 26b308e435..76b1011fad 100644
> --- a/target/ppc/translate/fixedpoint-impl.c.inc
> +++ b/target/ppc/translate/fixedpoint-impl.c.inc
> @@ -585,6 +585,109 @@ TRANS(CRANDC, cr_logic_common, tcg_gen_andc_i32);
>   TRANS(CREQV, cr_logic_common, tcg_gen_eqv_i32);
>   TRANS(CRORC, cr_logic_common, tcg_gen_orc_i32);
>   
> +
> +/***                    Integer load and store strings                     ***/
> +
> +/* lswi */
> +static bool trans_LSWI(DisasContext *ctx, arg_LSWI *a)
> +{
> +    TCGv t0;
> +    TCGv_i32 t1, t2;
> +    int nb = a->rb;
> +    int start = a->rt;
> +    int ra = a->ra;
> +    int nr;
> +
> +    if (ctx->le_mode) {
> +        gen_align_no_le(ctx);
> +        return true;
> +    }
> +    if (nb == 0) {
> +        nb = 32;
> +    }
> +    nr = DIV_ROUND_UP(nb, 4);
> +    if (unlikely(lsw_reg_in_range(start, nr, ra))) {
> +        gen_inval_exception(ctx, POWERPC_EXCP_INVAL_LSWX);
> +        return true;
> +    }
> +    gen_set_access_type(ctx, ACCESS_INT);
> +    t0 = tcg_temp_new();
> +    gen_addr_register(ctx, t0);
> +    t1 = tcg_constant_i32(nb);
> +    t2 = tcg_constant_i32(start);
> +    gen_helper_LSW(tcg_env, t0, t1, t2);
> +
> +    return true;
> +}
> +
> +/* lswx */
> +static bool trans_LSWX(DisasContext *ctx, arg_LSWX *a)
> +{
> +    TCGv t0;
> +    TCGv_i32 t1, t2, t3;
> +
> +    if (ctx->le_mode) {
> +        gen_align_no_le(ctx);
> +        return true;
> +    }
> +
> +    gen_set_access_type(ctx, ACCESS_INT);
> +    t0 = tcg_temp_new();
> +    gen_addr_reg_index(ctx, t0);
> +    t1 = tcg_constant_i32(a->rt);
> +    t2 = tcg_constant_i32(a->ra);
> +    t3 = tcg_constant_i32(a->rb);
> +    gen_helper_LSWX(tcg_env, t0, t1, t2, t3);
> +
> +    return true;
> +}
> +
> +/* stswi */
> +static bool trans_STSWI(DisasContext *ctx, arg_STSWI *a)
> +{
> +    TCGv t0;
> +    TCGv_i32 t1, t2;
> +    int nb = a->rb;
> +
> +    if (ctx->le_mode) {
> +        gen_align_no_le(ctx);
> +        return true;
> +    }
> +    gen_set_access_type(ctx, ACCESS_INT);
> +    t0 = tcg_temp_new();
> +    gen_addr_register(ctx, t0);
> +    if (nb == 0) {
> +        nb = 32;
> +    }
> +    t1 = tcg_constant_i32(nb);
> +    t2 = tcg_constant_i32(a->rt);
> +    gen_helper_STSW(tcg_env, t0, t1, t2);
> +
> +    return true;
> +}
> +
> +/* stswx */
> +static bool trans_STSWX(DisasContext *ctx, arg_STSWX *a)
> +{
> +    TCGv t0;
> +    TCGv_i32 t1, t2;
> +
> +    if (ctx->le_mode) {
> +        gen_align_no_le(ctx);
> +        return true;
> +    }
> +    gen_set_access_type(ctx, ACCESS_INT);
> +    t0 = tcg_temp_new();
> +    gen_addr_reg_index(ctx, t0);
> +    t1 = tcg_temp_new_i32();
> +    tcg_gen_trunc_tl_i32(t1, cpu_xer);
> +    tcg_gen_andi_i32(t1, t1, 0x7F);
> +    t2 = tcg_constant_i32(a->rt);
> +    gen_helper_STSW(tcg_env, t0, t1, t2);
> +
> +    return true;
> +}
> +

You are using gen_addr_register and gen_addr_reg_index, do_ea_calc instead.

Thanks
~ Nikhil

