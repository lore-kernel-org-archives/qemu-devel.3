Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 254F7C43458
	for <qemu-devel@archiver.kernel.org>; Wed,  8 Jul 2026 12:12:02 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1whR7s-0006FL-4S; Wed, 08 Jul 2026 08:11:40 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <rathc@linux.ibm.com>)
 id 1whR7q-0006F8-Lo; Wed, 08 Jul 2026 08:11:38 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <rathc@linux.ibm.com>)
 id 1whR7k-000658-J3; Wed, 08 Jul 2026 08:11:38 -0400
Received: from pps.filterd (m0360072.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 668BmIPK2271889; Wed, 8 Jul 2026 12:11:23 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=pp1; bh=ItuTgi
 CT1HvT/weKDLiWVxwvL9fWS+PXHQYZ76yUxiY=; b=d/hABNAnZe6qasbFIYgLPo
 R068ZDy+0xx27mKJRf9NXsx+kQlHilJGGNatSVOLGGzUta7Pc3nMK9iwHzBNIsaS
 pU82UghmhmqUJGKlw8hs+bWiJKeXYd27BbNZb6+MRUM/5QaJlAhTudWn/rPyu+Fs
 tQD/zWVRb5MI72YmtpevfYl951yHaVEuH8554RbG+xxEZBl6C4eU13XkzAIKqQ8w
 STE43rknYgTw6ELIk5QL9TY/DmGa7itGDO8/xqHPDiI3r08OSbp+u05E0VyOppxs
 +NoIdRKiM9qPKq6+Yuz8+aBu77IgP0FotSEKkFM2LE7DGaGLT3iiUvBs9CyIWx6w
 ==
Received: from ppma11.dal12v.mail.ibm.com
 (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4f6stsvmp3-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Wed, 08 Jul 2026 12:11:23 +0000 (GMT)
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
 by ppma11.dal12v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 668BnebJ026366;
 Wed, 8 Jul 2026 12:11:22 GMT
Received: from smtprelay06.dal12v.mail.ibm.com ([172.16.1.8])
 by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 4f7f6y7k8e-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Wed, 08 Jul 2026 12:11:22 +0000 (GMT)
Received: from smtpav02.wdc07v.mail.ibm.com (smtpav02.wdc07v.mail.ibm.com
 [10.39.53.229])
 by smtprelay06.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 668CBLrb28705316
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Wed, 8 Jul 2026 12:11:21 GMT
Received: from smtpav02.wdc07v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 019925805E;
 Wed,  8 Jul 2026 12:11:21 +0000 (GMT)
Received: from smtpav02.wdc07v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 8CFB05805C;
 Wed,  8 Jul 2026 12:11:17 +0000 (GMT)
Received: from [9.39.26.49] (unknown [9.39.26.49])
 by smtpav02.wdc07v.mail.ibm.com (Postfix) with ESMTP;
 Wed,  8 Jul 2026 12:11:17 +0000 (GMT)
Message-ID: <200dc51d-c524-4944-9d82-86e6ee3c7312@linux.ibm.com>
Date: Wed, 8 Jul 2026 17:41:14 +0530
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH v2] target/ppc: Convert cache instructions to
 decodetree
To: Nikhil Kumar Singh <nikhilks@linux.ibm.com>, qemu-devel@nongnu.org,
 qemu-ppc@nongnu.org
Cc: shivangu@linux.ibm.com, Harsh Prateek Bora <harshpb@linux.ibm.com>,
 adityag@linux.ibm.com, Richard Henderson <richard.henderson@linaro.org>
References: <20260520160728.2283628-4-rathc@linux.ibm.com>
 <20260630144210.148159-1-nikhilks@linux.ibm.com>
Content-Language: en-US
From: Chinmay Rath <rathc@linux.ibm.com>
In-Reply-To: <20260630144210.148159-1-nikhilks@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: ly8r74LOfTpGxGO-_jwZ9H5wkmVwdkn3
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzA4MDExNSBTYWx0ZWRfX1J/m8Vd4KgZZ
 Lg5JVa8/A1h7keZO91eYjEyuvIpP7fHpXSo7xJy4DszmHykk/NmXiGCKKI1TfZcIrmKqx1iN4k7
 KbiXWxw+j18xly8MJehP7vxfEYGNm0c=
X-Authority-Analysis: v=2.4 cv=DKW/JSNb c=1 sm=1 tr=0 ts=6a4e3e6b cx=c_pps
 a=aDMHemPKRhS1OARIsFnwRA==:117 a=aDMHemPKRhS1OARIsFnwRA==:17
 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=RzCfie-kr_QcCd8fBx8p:22 a=VnNF1IyMAAAA:8
 a=iIC4HEkgwtlvEg7tCS8A:9 a=QEXdDO2ut3YA:10
X-Proofpoint-GUID: ly8r74LOfTpGxGO-_jwZ9H5wkmVwdkn3
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzA4MDExNSBTYWx0ZWRfX6808LugOXugX
 NNNd34wIVJsAzYhx6b8yZNpDs5wuEIlePMZohxz6dFQFGSq5N1mMKBem6Slni6cwDag/VXbx8cI
 YQ9nVcG/hU3ZNLbhW5zT9Abmd0++UI2wHP1a9WZ0kUyHmW8LAHVRcgXF9sGxDXM/mJCKY1Ew5OZ
 MnbMywWOlHOUsXLAqVR9K5TzAMFO9cbx+FSyq/4lWxhRhp/ZaJeA1afMkxvf4NEd2aztMiYXpkZ
 KxYFb9Mj8Y1vaziYPPBj46gjT5X6J2Q5gzYcLhSx+DvKYmtZTc8VAagU98BPH0IjiXwJD2jS4qn
 Fx26PSFhkzfir/5Z7b8cngLienGFCMxFh5BXoiVDVs/lmQNfnbB1o3qpe/7afMMd2ZdEK0ePbuo
 CHLVzmVQC11A/D7yERdHmwn0NUXvqFK3+mztkUG17qknxhCF90cqKr2xA7oNgqAL5+dvfvedmyv
 o8sra7vxfyE8zeouZ8w==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-08_01,2026-07-08_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 bulkscore=0 clxscore=1015 phishscore=0 impostorscore=0
 priorityscore=1501 adultscore=0 lowpriorityscore=0 suspectscore=0
 malwarescore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2607080115
Received-SPF: pass client-ip=148.163.158.5; envelope-from=rathc@linux.ibm.com;
 helo=mx0b-001b2d01.pphosted.com
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


On 6/30/26 20:12, Nikhil Kumar Singh wrote:
> Convert cache management instructions to decodetree using the X-form
> layout and dedicated translation functions.
>
> Legacy GEN_HANDLER-based implementations are removed.
>
> The implementation preserves legacy semantics, including:
>    - MMU-visible accesses for instructions treated as loads
>      (e.g. dcbt, dcbtst, dcbtep, dcbtstep)
>    - Supervisor and BookE-specific constraints
>    - Effective address computation via do_ea_calc()
>
> Instructions that were defined as no-ops in the legacy implementation
> remain no-ops here.
>
> Testing:
>    - Verified TCG equivalence for all cache operations
>
> Signed-off-by: Nikhil Kumar Singh <nikhilks@linux.ibm.com>
> Signed-off-by: Chinmay Rath <rathc@linux.ibm.com>
> [cr: linux user build, flag check, helper function fixes]
> ---
>   target/ppc/helper.h      |   8 +-
>   target/ppc/insn32.decode |  25 ++
>   target/ppc/mem_helper.c  |   8 +-
>   target/ppc/translate.c   | 495 +++++++++++++++++++++------------------
>   4 files changed, 299 insertions(+), 237 deletions(-)
>
> diff --git a/target/ppc/helper.h b/target/ppc/helper.h
> index e99c8c824b..37803ebb17 100644
> --- a/target/ppc/helper.h
> +++ b/target/ppc/helper.h
> @@ -48,12 +48,12 @@ DEF_HELPER_FLAGS_3(stmw, TCG_CALL_NO_WG, void, env, tl, i32)
>   DEF_HELPER_4(lsw, void, env, tl, i32, i32)
>   DEF_HELPER_5(lswx, void, env, tl, i32, i32, i32)
>   DEF_HELPER_FLAGS_4(stsw, TCG_CALL_NO_WG, void, env, tl, i32, i32)
> -DEF_HELPER_FLAGS_3(dcbz, TCG_CALL_NO_WG, void, env, tl, int)
> +DEF_HELPER_FLAGS_3(DCBZ, TCG_CALL_NO_WG, void, env, tl, int)
>   #ifdef TARGET_PPC64
> -DEF_HELPER_FLAGS_2(dcbzl, TCG_CALL_NO_WG, void, env, tl)
> +DEF_HELPER_FLAGS_2(DCBZL, TCG_CALL_NO_WG, void, env, tl)
>   #endif
> -DEF_HELPER_FLAGS_2(icbi, TCG_CALL_NO_WG, void, env, tl)
> -DEF_HELPER_FLAGS_2(icbiep, TCG_CALL_NO_WG, void, env, tl)
> +DEF_HELPER_FLAGS_2(ICBI, TCG_CALL_NO_WG, void, env, tl)
> +DEF_HELPER_FLAGS_2(ICBIEP, TCG_CALL_NO_WG, void, env, tl)
>   DEF_HELPER_5(lscbx, tl, env, tl, i32, i32, i32)
>   
>   #if defined(TARGET_PPC64)
> diff --git a/target/ppc/insn32.decode b/target/ppc/insn32.decode
> index 26948e08a7..0fbabefba9 100644
> --- a/target/ppc/insn32.decode
> +++ b/target/ppc/insn32.decode
> @@ -1306,6 +1306,31 @@ XVF64GERPN      111011 ... -- .... 0 ..... 10111010 ..-  @XX3_at xa=%xx_xa_pair
>   XVF64GERNP      111011 ... -- .... 0 ..... 01111010 ..-  @XX3_at xa=%xx_xa_pair
>   XVF64GERNN      111011 ... -- .... 0 ..... 11111010 ..-  @XX3_at xa=%xx_xa_pair
>   
> +## Cache Management Instructions
> +DCBF            011111 ..... ..... ..... 0001010110 -   @X
> +DCBFEP          011111 ..... ..... ..... 0001111111 -   @X
> +DCBI            011111 ..... ..... ..... 0111010110 -   @X
> +DCBST           011111 ..... ..... ..... 0000110110 -   @X
> +DCBSTEP         011111 ..... ..... ..... 0000111111 -   @X
> +DCBA            011111 ..... ..... ..... 1011110110 -   @X
> +
> +DCBT            011111 ..... ..... ..... 0100010110 -   @X
> +DCBTEP          011111 ..... ..... ..... 0100111111 -   @X
> +DCBTST          011111 ..... ..... ..... 0011110110 -   @X
> +DCBTSTEP        011111 ..... ..... ..... 0011111111 -   @X
> +
> +DCBTLS          011111 ..... ..... ..... 0010100110 -   @X
> +DCBLC           011111 ..... ..... ..... 0110000110 -   @X
> +
> +DCBZ            011111 ..... ..... ..... 1111110110 -   @X
> +DCBZEP          011111 ..... ..... ..... 1111111111 -   @X
> +ICBI            011111 ..... ..... ..... 1111010110 -   @X
> +ICBIEP          011111 ..... ..... ..... 1111011111 -   @X
> +
> +DST             011111 ..... ..... ..... 0101010110 -   @X
> +DSTST           011111 ..... ..... ..... 0101110110 -   @X
> +DSS             011111 ..... ..... ..... 1100110110 -   @X
Just noticed that many of the instructions above do not accurately 
represent the reserved bits, and take them as part of the rt field in 
the arg_X struct.
Eg, as per ISA 3.1C :
For DCBF : Bits 6-7 are reserved and bits 8-10 are L field. In your 
patch, you are including the reserved bits as part of the L field, which 
is misleading IMO and could be a recipe for wrong emulation if the 
reserved bits are given meaning at some point.
For DCBZ: Bits 6-10 are reserved which is not represented here.

I have not checked individually for all the 20 odd instructions but I 
guess one would expect the instructions to be represented correctly in 
the spec.

-Chinmay
> +
>   ##Extend Sign Word and Shift Left Immediate XS-form
>   EXTSWSLI         011111 ..... ..... ..... 110111101 . .         @XS
>   
> diff --git a/target/ppc/mem_helper.c b/target/ppc/mem_helper.c
> index 119dc1df23..5d3d377261 100644
> --- a/target/ppc/mem_helper.c
> +++ b/target/ppc/mem_helper.c
> @@ -319,13 +319,13 @@ static void dcbz_common(CPUPPCState *env, target_ulong addr,
>       clear_helper_retaddr();
>   }
>   
> -void helper_dcbz(CPUPPCState *env, target_ulong addr, int mmu_idx)
> +void helper_DCBZ(CPUPPCState *env, target_ulong addr, int mmu_idx)
>   {
>       dcbz_common(env, addr, mmu_idx, env->dcache_line_size, GETPC());
>   }
>   
>   #ifdef TARGET_PPC64
> -void helper_dcbzl(CPUPPCState *env, target_ulong addr)
> +void helper_DCBZL(CPUPPCState *env, target_ulong addr)
>   {
>       int dcbz_size = env->dcache_line_size;
>   
> @@ -341,7 +341,7 @@ void helper_dcbzl(CPUPPCState *env, target_ulong addr)
>   }
>   #endif
>   
> -void helper_icbi(CPUPPCState *env, target_ulong addr)
> +void helper_ICBI(CPUPPCState *env, target_ulong addr)
>   {
>       unsigned mmu_idx = cpu_mmu_index(env_cpu(env), false);
>       MemOpIdx oi = make_memop_idx(MO_UL | MO_UNALN, mmu_idx);
> @@ -357,7 +357,7 @@ void helper_icbi(CPUPPCState *env, target_ulong addr)
>       cpu_ldl_mmu(env, addr, oi, GETPC());
>   }
>   
> -void helper_icbiep(CPUPPCState *env, target_ulong addr)
> +void helper_ICBIEP(CPUPPCState *env, target_ulong addr)
>   {
>   #if !defined(CONFIG_USER_ONLY)
>       MemOpIdx oi = make_memop_idx(MO_UL | MO_UNALN, PPC_TLB_EPID_LOAD);
> diff --git a/target/ppc/translate.c b/target/ppc/translate.c
> index 3f009cd9ca..98712b343b 100644
> --- a/target/ppc/translate.c
> +++ b/target/ppc/translate.c
> @@ -4296,216 +4296,6 @@ static void gen_setb(DisasContext *ctx)
>   }
>   #endif
>   
> -/***                         Cache management                              ***/
> -
> -/* dcbf */
> -static void gen_dcbf(DisasContext *ctx)
> -{
> -    /* XXX: specification says this is treated as a load by the MMU */
> -    TCGv t0;
> -    gen_set_access_type(ctx, ACCESS_CACHE);
> -    t0 = tcg_temp_new();
> -    gen_addr_reg_index(ctx, t0);
> -    gen_qemu_ld8u(ctx, t0, t0);
> -}
> -
> -/* dcbfep (external PID dcbf) */
> -static void gen_dcbfep(DisasContext *ctx)
> -{
> -    /* XXX: specification says this is treated as a load by the MMU */
> -    TCGv t0;
> -    CHK_SV(ctx);
> -    gen_set_access_type(ctx, ACCESS_CACHE);
> -    t0 = tcg_temp_new();
> -    gen_addr_reg_index(ctx, t0);
> -    tcg_gen_qemu_ld_tl(t0, t0, PPC_TLB_EPID_LOAD, DEF_MEMOP(MO_UB));
> -}
> -
> -/* dcbi (Supervisor only) */
> -static void gen_dcbi(DisasContext *ctx)
> -{
> -#if defined(CONFIG_USER_ONLY)
> -    GEN_PRIV(ctx);
> -#else
> -    TCGv EA, val;
> -
> -    CHK_SV(ctx);
> -    EA = tcg_temp_new();
> -    gen_set_access_type(ctx, ACCESS_CACHE);
> -    gen_addr_reg_index(ctx, EA);
> -    val = tcg_temp_new();
> -    /* XXX: specification says this should be treated as a store by the MMU */
> -    gen_qemu_ld8u(ctx, val, EA);
> -    gen_qemu_st8(ctx, val, EA);
> -#endif /* defined(CONFIG_USER_ONLY) */
> -}
> -
> -/* dcdst */
> -static void gen_dcbst(DisasContext *ctx)
> -{
> -    /* XXX: specification say this is treated as a load by the MMU */
> -    TCGv t0;
> -    gen_set_access_type(ctx, ACCESS_CACHE);
> -    t0 = tcg_temp_new();
> -    gen_addr_reg_index(ctx, t0);
> -    gen_qemu_ld8u(ctx, t0, t0);
> -}
> -
> -/* dcbstep (dcbstep External PID version) */
> -static void gen_dcbstep(DisasContext *ctx)
> -{
> -    /* XXX: specification say this is treated as a load by the MMU */
> -    TCGv t0;
> -    gen_set_access_type(ctx, ACCESS_CACHE);
> -    t0 = tcg_temp_new();
> -    gen_addr_reg_index(ctx, t0);
> -    tcg_gen_qemu_ld_tl(t0, t0, PPC_TLB_EPID_LOAD, DEF_MEMOP(MO_UB));
> -}
> -
> -/* dcbt */
> -static void gen_dcbt(DisasContext *ctx)
> -{
> -    /*
> -     * interpreted as no-op
> -     * XXX: specification say this is treated as a load by the MMU but
> -     *      does not generate any exception
> -     */
> -}
> -
> -/* dcbtep */
> -static void gen_dcbtep(DisasContext *ctx)
> -{
> -    /*
> -     * interpreted as no-op
> -     * XXX: specification say this is treated as a load by the MMU but
> -     *      does not generate any exception
> -     */
> -}
> -
> -/* dcbtst */
> -static void gen_dcbtst(DisasContext *ctx)
> -{
> -    /*
> -     * interpreted as no-op
> -     * XXX: specification say this is treated as a load by the MMU but
> -     *      does not generate any exception
> -     */
> -}
> -
> -/* dcbtstep */
> -static void gen_dcbtstep(DisasContext *ctx)
> -{
> -    /*
> -     * interpreted as no-op
> -     * XXX: specification say this is treated as a load by the MMU but
> -     *      does not generate any exception
> -     */
> -}
> -
> -/* dcbtls */
> -static void gen_dcbtls(DisasContext *ctx)
> -{
> -    /* Always fails locking the cache */
> -    TCGv t0 = tcg_temp_new();
> -    gen_load_spr(t0, SPR_Exxx_L1CSR0);
> -    tcg_gen_ori_tl(t0, t0, L1CSR0_CUL);
> -    gen_store_spr(SPR_Exxx_L1CSR0, t0);
> -}
> -
> -/* dcblc */
> -static void gen_dcblc(DisasContext *ctx)
> -{
> -    /*
> -     * interpreted as no-op
> -     */
> -}
> -
> -/* dcbz */
> -static void gen_dcbz(DisasContext *ctx)
> -{
> -    TCGv tcgv_addr = tcg_temp_new();
> -
> -    gen_set_access_type(ctx, ACCESS_CACHE);
> -    gen_addr_reg_index(ctx, tcgv_addr);
> -
> -#ifdef TARGET_PPC64
> -    if (ctx->excp_model == POWERPC_EXCP_970 && !(ctx->opcode & 0x00200000)) {
> -        gen_helper_dcbzl(tcg_env, tcgv_addr);
> -        return;
> -    }
> -#endif
> -
> -    gen_helper_dcbz(tcg_env, tcgv_addr, tcg_constant_i32(ctx->mem_idx));
> -}
> -
> -/* dcbzep */
> -static void gen_dcbzep(DisasContext *ctx)
> -{
> -    TCGv tcgv_addr = tcg_temp_new();
> -
> -    gen_set_access_type(ctx, ACCESS_CACHE);
> -    gen_addr_reg_index(ctx, tcgv_addr);
> -    gen_helper_dcbz(tcg_env, tcgv_addr, tcg_constant_i32(PPC_TLB_EPID_STORE));
> -}
> -
> -/* dst / dstt */
> -static void gen_dst(DisasContext *ctx)
> -{
> -    if (rA(ctx->opcode) == 0) {
> -        gen_inval_exception(ctx, POWERPC_EXCP_INVAL_INVAL);
> -    } else {
> -        /* interpreted as no-op */
> -    }
> -}
> -
> -/* dstst /dststt */
> -static void gen_dstst(DisasContext *ctx)
> -{
> -    if (rA(ctx->opcode) == 0) {
> -        gen_inval_exception(ctx, POWERPC_EXCP_INVAL_INVAL);
> -    } else {
> -        /* interpreted as no-op */
> -    }
> -
> -}
> -
> -/* dss / dssall */
> -static void gen_dss(DisasContext *ctx)
> -{
> -    /* interpreted as no-op */
> -}
> -
> -/* icbi */
> -static void gen_icbi(DisasContext *ctx)
> -{
> -    TCGv t0;
> -    gen_set_access_type(ctx, ACCESS_CACHE);
> -    t0 = tcg_temp_new();
> -    gen_addr_reg_index(ctx, t0);
> -    gen_helper_icbi(tcg_env, t0);
> -}
> -
> -/* icbiep */
> -static void gen_icbiep(DisasContext *ctx)
> -{
> -    TCGv t0;
> -    gen_set_access_type(ctx, ACCESS_CACHE);
> -    t0 = tcg_temp_new();
> -    gen_addr_reg_index(ctx, t0);
> -    gen_helper_icbiep(tcg_env, t0);
> -}
> -
> -/* Optional: */
> -/* dcba */
> -static void gen_dcba(DisasContext *ctx)
> -{
> -    /*
> -     * interpreted as no-op
> -     * XXX: specification say this is treated as a store by the MMU
> -     *      but does not generate any exception
> -     */
> -}
> -
>   /***                    Segment register manipulation                      ***/
>   /* Supervisor only: */
>   
> @@ -5764,6 +5554,272 @@ static bool trans_LQARX(DisasContext *ctx, arg_LQARX *a)
>       return true;
>   }
>   
> +/*
> + * Cache Management Instructions (decodetree)
> + */
> +
> +static bool trans_DCBA(DisasContext *ctx, arg_X *a)
> +{
> +    REQUIRE_INSNS_FLAGS(ctx, CACHE_DCBA);
> +    return true;
> +}
> +
> +static bool trans_DCBT(DisasContext *ctx, arg_X *a)
> +{
> +    REQUIRE_INSNS_FLAGS(ctx, CACHE);
> +    return true;
> +}
> +
> +static bool trans_DCBTEP(DisasContext *ctx, arg_X *a)
> +{
> +    REQUIRE_INSNS_FLAGS2(ctx, BOOKE206);
> +    return true;
> +}
> +
> +static bool trans_DCBTST(DisasContext *ctx, arg_X *a)
> +{
> +    REQUIRE_INSNS_FLAGS(ctx, CACHE);
> +    return true;
> +}
> +
> +static bool trans_DCBTSTEP(DisasContext *ctx, arg_X *a)
> +{
> +    REQUIRE_INSNS_FLAGS2(ctx, BOOKE206);
> +    return true;
> +}
> +
> +static bool trans_DCBLC(DisasContext *ctx, arg_X *a)
> +{
> +    /* Requires either PPC_BOOKE or PPC2_BOOKE206 */
> +    if (!(ctx->insns_flags & PPC_BOOKE) &&
> +        !(ctx->insns_flags2 & PPC2_BOOKE206)) {
> +        return false;
> +    }
> +    return true;
> +}
> +
> +static bool trans_DSS(DisasContext *ctx, arg_X *a)
> +{
> +    REQUIRE_INSNS_FLAGS(ctx, ALTIVEC);
> +    return true;
> +}
> +
> +static bool trans_DCBTLS(DisasContext *ctx, arg_X *a)
> +{
> +    TCGv t0 = tcg_temp_new();
> +
> +    /* Requires either PPC_BOOKE or PPC2_BOOKE206 */
> +    if (!(ctx->insns_flags & PPC_BOOKE) &&
> +        !(ctx->insns_flags2 & PPC2_BOOKE206)) {
> +        return false;
> +    }
> +
> +    gen_load_spr(t0, SPR_Exxx_L1CSR0);
> +    tcg_gen_ori_tl(t0, t0, L1CSR0_CUL);
> +    gen_store_spr(SPR_Exxx_L1CSR0, t0);
> +
> +    return true;
> +}
> +
> +static bool trans_DST(DisasContext *ctx, arg_X *a)
> +{
> +    REQUIRE_INSNS_FLAGS(ctx, ALTIVEC);
> +
> +    if (a->ra == 0) {
> +        gen_inval_exception(ctx, POWERPC_EXCP_INVAL_INVAL);
> +    }
> +
> +    return true;
> +}
> +
> +static bool trans_DSTST(DisasContext *ctx, arg_X *a)
> +{
> +    REQUIRE_INSNS_FLAGS(ctx, ALTIVEC);
> +
> +    if (a->ra == 0) {
> +        gen_inval_exception(ctx, POWERPC_EXCP_INVAL_INVAL);
> +    }
> +
> +    return true;
> +}
> +
> +static bool trans_DCBF(DisasContext *ctx, arg_X *a)
> +{
> +    TCGv EA;
> +
> +    REQUIRE_INSNS_FLAGS(ctx, CACHE);
> +
> +    /*
> +     * As per PowerISA v3.1, the L field (mapped to a->rt in X-form)
> +     * can have values 0, 1, 3, 4, or 6. Other values are Undefined Behavior (UB).
> +     */
> +    switch (a->rt) {
> +    case 0: /* dcbf */
> +    case 1: /* dcbfl */
> +    case 3: /* dcbflp */
> +    case 4: /* dcbfps */
> +    case 6: /* dcbstps */
> +        break;
> +    default:
> +        gen_inval_exception(ctx, POWERPC_EXCP_INVAL_INVAL);
> +        return true;
> +    }
> +
> +    gen_set_access_type(ctx, ACCESS_CACHE);
> +    EA = do_ea_calc(ctx, a->ra, cpu_gpr[a->rb]);
> +    gen_qemu_ld8u(ctx, EA, EA);
> +
> +    return true;
> +}
> +
> +static bool trans_DCBST(DisasContext *ctx, arg_X *a)
> +{
> +
> +    if (a->rt != 0) {
> +        gen_inval_exception(ctx, POWERPC_EXCP_INVAL_INVAL);
> +        return true;
> +    }
> +
> +    /* Flags check overlaps with trans_DCBF */
> +    return trans_DCBF(ctx, a);
> +}
> +
> +static bool trans_DCBFEP(DisasContext *ctx, arg_X *a)
> +{
> +    TCGv EA;
> +
> +    REQUIRE_INSNS_FLAGS2(ctx, BOOKE206);
> +
> +    /* Per ISA: RT must be zero for cache management instructions */
> +    if (a->rt != 0) {
> +        gen_inval_exception(ctx, POWERPC_EXCP_INVAL_INVAL);
> +        return true;
> +    }
> +
> +    REQUIRE_SV(ctx);
> +
> +    gen_set_access_type(ctx, ACCESS_CACHE);
> +    EA = do_ea_calc(ctx, a->ra, cpu_gpr[a->rb]);
> +
> +    tcg_gen_qemu_ld_tl(EA, EA, PPC_TLB_EPID_LOAD, DEF_MEMOP(MO_UB));
> +
> +    return true;
> +}
> +
> +static bool trans_DCBSTEP(DisasContext *ctx, arg_X *a)
> +{
> +    /* Flags check overlaps with trans_DCBFEP */
> +    return trans_DCBFEP(ctx, a);
> +}
> +
> +static bool trans_DCBI(DisasContext *ctx, arg_X *a)
> +{
> +#if defined(CONFIG_USER_ONLY)
> +    gen_priv_opc(ctx);
> +    return true;
> +#else
> +    TCGv EA, val;
> +    REQUIRE_INSNS_FLAGS(ctx, CACHE);
> +
> +    if (a->rt != 0) {
> +        gen_inval_exception(ctx, POWERPC_EXCP_INVAL_INVAL);
> +        return true;
> +    }
> +
> +    REQUIRE_SV(ctx);
> +    gen_set_access_type(ctx, ACCESS_CACHE);
> +    EA = do_ea_calc(ctx, a->ra, cpu_gpr[a->rb]);
> +    val = tcg_temp_new();
> +
> +    gen_qemu_ld8u(ctx, val, EA);
> +    gen_qemu_st8(ctx, val, EA);
> +
> +    return true;
> +#endif
> +}
> +
> +static bool trans_ICBI(DisasContext *ctx, arg_X *a)
> +{
> +    TCGv EA;
> +
> +    REQUIRE_INSNS_FLAGS(ctx, CACHE_ICBI);
> +
> +    if (a->rt != 0) {
> +        gen_inval_exception(ctx, POWERPC_EXCP_INVAL_INVAL);
> +        return true;
> +    }
> +
> +
> +    gen_set_access_type(ctx, ACCESS_CACHE);
> +
> +    EA = do_ea_calc(ctx, a->ra, cpu_gpr[a->rb]);
> +    gen_helper_ICBI(tcg_env, EA);
> +
> +    return true;
> +}
> +
> +static bool trans_ICBIEP(DisasContext *ctx, arg_X *a)
> +{
> +    TCGv EA;
> +
> +    REQUIRE_INSNS_FLAGS2(ctx, BOOKE206);
> +    REQUIRE_SV(ctx);
> +
> +    gen_set_access_type(ctx, ACCESS_CACHE);
> +    EA = do_ea_calc(ctx, a->ra, cpu_gpr[a->rb]);
> +
> +    gen_helper_ICBIEP(tcg_env, EA);
> +    return true;
> +}
> +
> +static bool trans_DCBZ(DisasContext *ctx, arg_X *a)
> +{
> +    TCGv EA;
> +
> +    REQUIRE_INSNS_FLAGS(ctx, CACHE_DCBZ);
> +
> +    if (a->rt != 0) {
> +        gen_inval_exception(ctx, POWERPC_EXCP_INVAL_INVAL);
> +        return true;
> +    }
> +
> +
> +    gen_set_access_type(ctx, ACCESS_CACHE);
> +
> +    EA = do_ea_calc(ctx, a->ra, cpu_gpr[a->rb]);
> +
> +#if defined(TARGET_PPC64)
> +    if (ctx->excp_model == POWERPC_EXCP_970 &&
> +        !(ctx->opcode & 0x00200000)) {
> +        gen_helper_DCBZL(tcg_env, EA);
> +        return true;
> +    }
> +#endif
> +
> +    gen_helper_DCBZ(tcg_env, EA, tcg_constant_i32(ctx->mem_idx));
> +    return true;
> +}
> +
> +static bool trans_DCBZEP(DisasContext *ctx, arg_X *a)
> +{
> +    TCGv EA;
> +
> +    REQUIRE_INSNS_FLAGS2(ctx, BOOKE206);
> +
> +    if (a->rt != 0) {
> +        gen_inval_exception(ctx, POWERPC_EXCP_INVAL_INVAL);
> +        return true;
> +    }
> +
> +    REQUIRE_SV(ctx);
> +
> +    gen_set_access_type(ctx, ACCESS_CACHE);
> +    EA = do_ea_calc(ctx, a->ra, cpu_gpr[a->rb]);
> +
> +    gen_helper_DCBZ(tcg_env, EA, tcg_constant_i32(PPC_TLB_EPID_STORE));
> +    return true;
> +}
> +
>   #include "translate/fixedpoint-impl.c.inc"
>   
>   #include "translate/fp-impl.c.inc"
> @@ -5928,25 +5984,6 @@ GEN_HANDLER_E(mcrxrx, 0x1F, 0x00, 0x12, 0x007FF801, PPC_NONE, PPC2_ISA300),
>   #endif
>   GEN_HANDLER(mtmsr, 0x1F, 0x12, 0x04, 0x001EF801, PPC_MISC),
>   GEN_HANDLER(mtspr, 0x1F, 0x13, 0x0E, 0x00000000, PPC_MISC),
> -GEN_HANDLER(dcbf, 0x1F, 0x16, 0x02, 0x03C00001, PPC_CACHE),
> -GEN_HANDLER_E(dcbfep, 0x1F, 0x1F, 0x03, 0x03C00001, PPC_NONE, PPC2_BOOKE206),
> -GEN_HANDLER(dcbi, 0x1F, 0x16, 0x0E, 0x03E00001, PPC_CACHE),
> -GEN_HANDLER(dcbst, 0x1F, 0x16, 0x01, 0x03E00001, PPC_CACHE),
> -GEN_HANDLER_E(dcbstep, 0x1F, 0x1F, 0x01, 0x03E00001, PPC_NONE, PPC2_BOOKE206),
> -GEN_HANDLER(dcbt, 0x1F, 0x16, 0x08, 0x00000001, PPC_CACHE),
> -GEN_HANDLER_E(dcbtep, 0x1F, 0x1F, 0x09, 0x00000001, PPC_NONE, PPC2_BOOKE206),
> -GEN_HANDLER(dcbtst, 0x1F, 0x16, 0x07, 0x00000001, PPC_CACHE),
> -GEN_HANDLER_E(dcbtstep, 0x1F, 0x1F, 0x07, 0x00000001, PPC_NONE, PPC2_BOOKE206),
> -GEN_HANDLER_E(dcbtls, 0x1F, 0x06, 0x05, 0x02000001, PPC_BOOKE, PPC2_BOOKE206),
> -GEN_HANDLER_E(dcblc, 0x1F, 0x06, 0x0c, 0x02000001, PPC_BOOKE, PPC2_BOOKE206),
> -GEN_HANDLER(dcbz, 0x1F, 0x16, 0x1F, 0x03C00001, PPC_CACHE_DCBZ),
> -GEN_HANDLER_E(dcbzep, 0x1F, 0x1F, 0x1F, 0x03C00001, PPC_NONE, PPC2_BOOKE206),
> -GEN_HANDLER(dst, 0x1F, 0x16, 0x0A, 0x01800001, PPC_ALTIVEC),
> -GEN_HANDLER(dstst, 0x1F, 0x16, 0x0B, 0x01800001, PPC_ALTIVEC),
> -GEN_HANDLER(dss, 0x1F, 0x16, 0x19, 0x019FF801, PPC_ALTIVEC),
> -GEN_HANDLER(icbi, 0x1F, 0x16, 0x1E, 0x03E00001, PPC_CACHE_ICBI),
> -GEN_HANDLER_E(icbiep, 0x1F, 0x1F, 0x1E, 0x03E00001, PPC_NONE, PPC2_BOOKE206),
> -GEN_HANDLER(dcba, 0x1F, 0x16, 0x17, 0x03E00001, PPC_CACHE_DCBA),
>   GEN_HANDLER(mfsr, 0x1F, 0x13, 0x12, 0x0010F801, PPC_SEGMENT),
>   GEN_HANDLER(mfsrin, 0x1F, 0x13, 0x14, 0x001F0001, PPC_SEGMENT),
>   GEN_HANDLER(mtsr, 0x1F, 0x12, 0x06, 0x0010F801, PPC_SEGMENT),

