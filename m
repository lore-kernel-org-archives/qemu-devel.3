Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 027F7C5DF7A
	for <qemu-devel@archiver.kernel.org>; Mon, 17 Aug 2026 12:59:20 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wvwvM-0002aG-EZ; Mon, 17 Aug 2026 08:58:44 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <tasmiya@linux.ibm.com>)
 id 1wvwWu-00036M-P1; Mon, 17 Aug 2026 08:33:28 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <tasmiya@linux.ibm.com>)
 id 1wvwWq-0008Ux-5U; Mon, 17 Aug 2026 08:33:28 -0400
Received: from pps.filterd (m0353729.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 67HCVi1l3721923; Mon, 17 Aug 2026 12:33:21 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-type:date:from:in-reply-to:message-id:mime-version
 :references:subject:to; s=pp1; bh=66yEhGDgK+J9bVqfyHOKZmxmNVb74G
 69PDm0mI6/3G4=; b=EPh5YpJ1GWw3L3uR6T7BnJO0nO+REFKD32ay+vlpaENzoA
 PxUe+8qIoQdnicM+Ww4pxfiIKJt0pHOb5dS9IpUt5sBXs+gKFmr0Zco/bJiuXKPM
 46gugx+WQB1N+D85PYKF31hCM6ehNiy/zasN+WJC8YsD8/UHc5RjnRI2F3zlJAQz
 7OYnK6valTw7TEaVPRsbGomfTAtKocSkAIVoHEXOAtNLNOJC4PIOOvWCrTyRRB68
 Edn8Bw+sH1ttfCGswS/0S+s8nMxZ3jXtLw9rizJJdx3khscQluTPWe9d7TSY9dhp
 8S425mal0DJVNre5MJQW80A5WFB/NYP4OJ9GBsxA==
Received: from ppma12.dal12v.mail.ibm.com
 (dc.9e.1632.ip4.static.sl-reverse.com [50.22.158.220])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4g2fsqj6vc-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Mon, 17 Aug 2026 12:33:20 +0000 (GMT)
Received: from pps.filterd (ppma12.dal12v.mail.ibm.com [127.0.0.1])
 by ppma12.dal12v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 67HCQH91013014;
 Mon, 17 Aug 2026 12:33:19 GMT
Received: from smtprelay07.fra02v.mail.ibm.com ([9.218.2.229])
 by ppma12.dal12v.mail.ibm.com (PPS) with ESMTPS id 4g32epx5vv-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Mon, 17 Aug 2026 12:33:19 +0000 (GMT)
Received: from smtpav06.fra02v.mail.ibm.com (smtpav06.fra02v.mail.ibm.com
 [10.20.54.105])
 by smtprelay07.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 67HCXF8J46399836
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Mon, 17 Aug 2026 12:33:15 GMT
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 22FEE20049;
 Mon, 17 Aug 2026 12:33:15 +0000 (GMT)
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id A4A3920040;
 Mon, 17 Aug 2026 12:33:10 +0000 (GMT)
Received: from [9.61.253.76] (unknown [9.61.253.76])
 by smtpav06.fra02v.mail.ibm.com (Postfix) with ESMTP;
 Mon, 17 Aug 2026 12:33:10 +0000 (GMT)
Content-Type: multipart/alternative;
 boundary="------------W0kvT0WUxMGmaFts0yMDy34n"
Message-ID: <b86e0a89-9b46-4315-bca5-e8560e83d48b@linux.ibm.com>
Date: Mon, 17 Aug 2026 18:03:08 +0530
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH v2] target/ppc: Convert cache instructions to
 decodetree
To: Chinmay Rath <rathc@linux.ibm.com>,
 Nikhil Kumar Singh <nikhilks@linux.ibm.com>, qemu-devel@nongnu.org,
 qemu-ppc@nongnu.org
Cc: shivangu@linux.ibm.com, Harsh Prateek Bora <harshpb@linux.ibm.com>,
 adityag@linux.ibm.com, Richard Henderson <richard.henderson@linaro.org>
References: <20260520160728.2283628-4-rathc@linux.ibm.com>
 <20260630144210.148159-1-nikhilks@linux.ibm.com>
 <200dc51d-c524-4944-9d82-86e6ee3c7312@linux.ibm.com>
Content-Language: en-US
From: tasmiya <tasmiya@linux.ibm.com>
In-Reply-To: <200dc51d-c524-4944-9d82-86e6ee3c7312@linux.ibm.com>
X-TM-AS-GCONF: 00
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODE3MDA5NSBTYWx0ZWRfX3qL0ZUvefHeS
 v3SiiuRjCQrpKPrB57simhkm5hyyqVFx63vbAOmLpNzzcFSoNeE1Ftvmrnvw8lrM+ZBNkerIUtH
 VwketwQyU6w8j7mwOd0lu0CJdIxhPrHl36u53ckoMD8uOH+zTI0J6RblW+OggRnhI+QqPVFeO3h
 FNcTdvPovb+cL6rAmZr4BD6oMAALrERJVhAPK09TvifDDwCDVgbq4MuPymwGX631aJq+GAzol7o
 C0so25JdaJo/VCu9DBude8ES5ge8VRh8ZN9oVwDnrLPhoj3t7AwPjSwchsG+DoHzIHCzBH6X+oE
 RGOvx5ZP+fk0ddH9NczFvrfyzJBKM5QUnV/FZkUixIbctA8uuQQeCnSyZkEmdkWgXM3mqK3lvtL
 DVzXW6i2gaoUUGjfHnWAHwnKEyq2jpJKbj4Pf/0HAz80QoDwFJnEzcjQWvbPPIHFxNFLAkclRXt
 JpVa8xdMPEyfSv12D5A==
X-Proofpoint-ORIG-GUID: T565tekbNonmLrimdhYIAAvCXbIlQEyW
X-Proofpoint-Spam-Info: AW1haW4tMjYwODE3MDA5NSBTYWx0ZWRfX3ACrul6gHss5
 9NiU3JXE8Ywk+N/lLpYXxUt3q5g0JpfRAFRaFo+KgZSvXDeXOqeofzUfsO0KpFz7r7DEmCDiU7G
 dufpnocUXirqJmz+xMAg44T8XJ3M2k0=
X-Authority-Analysis: v=2.4 cv=DJe/JSNb c=1 sm=1 tr=0 ts=6a82ff90 cx=c_pps
 a=bLidbwmWQ0KltjZqbj+ezA==:117 a=bLidbwmWQ0KltjZqbj+ezA==:17
 a=Sv0fKeRqtYgA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=uAbxVGIbfxUO_5tXvNgY:22 a=r77TgQKjGQsHNAKrUKIA:9 a=VnNF1IyMAAAA:8
 a=PWhKtFgNB0oMTnZPRkQA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=aOwBGZeKFw4utvHsNGwA:9 a=ghaolerBAgufbfk3:21 a=_W_S_7VecoQA:10
 a=lqcHg5cX4UMA:10
X-Proofpoint-GUID: T565tekbNonmLrimdhYIAAvCXbIlQEyW
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-17_01,2026-08-12_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 impostorscore=0 spamscore=0 clxscore=1015 bulkscore=0
 suspectscore=0 malwarescore=0 phishscore=0 adultscore=0 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2608170095
Received-SPF: pass client-ip=148.163.156.1; envelope-from=tasmiya@linux.ibm.com;
 helo=mx0a-001b2d01.pphosted.com
X-Spam_score_int: -26
X-Spam_score: -2.7
X-Spam_bar: --
X-Spam_report: (-2.7 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, HTML_MESSAGE=0.001,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-Mailman-Approved-At: Mon, 17 Aug 2026 08:58:42 -0400
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

This is a multi-part message in MIME format.
--------------W0kvT0WUxMGmaFts0yMDy34n
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Tested-by: Tasmiya Nalatwad <tasmiya@linux.ibm.com>

I tested the patch on my setup and can confirm it fixes the "illegal 
instruction" issue I was seeing with HTX mdt.all on a KVM guest.

*Issue observed (before patch) :*
With HTX mdt.all running on the guest, hxecpu would crash with:

/"hxecpu[7487]: illegal instruction (4) at 7fffbc401054 nip 7fffbc401054 
lr 7fffbc400adc code 1"/

*After applying this patch:*
The illegal instruction errors are no longer seen in dmesg, and hxecpu 
runs cleanly through HTX.



On 08/07/26 5:41 pm, Chinmay Rath wrote:
>
> On 6/30/26 20:12, Nikhil Kumar Singh wrote:
>> Convert cache management instructions to decodetree using the X-form
>> layout and dedicated translation functions.
>>
>> Legacy GEN_HANDLER-based implementations are removed.
>>
>> The implementation preserves legacy semantics, including:
>>    - MMU-visible accesses for instructions treated as loads
>>      (e.g. dcbt, dcbtst, dcbtep, dcbtstep)
>>    - Supervisor and BookE-specific constraints
>>    - Effective address computation via do_ea_calc()
>>
>> Instructions that were defined as no-ops in the legacy implementation
>> remain no-ops here.
>>
>> Testing:
>>    - Verified TCG equivalence for all cache operations
>>
>> Signed-off-by: Nikhil Kumar Singh <nikhilks@linux.ibm.com>
>> Signed-off-by: Chinmay Rath <rathc@linux.ibm.com>
>> [cr: linux user build, flag check, helper function fixes]
>> ---
>>   target/ppc/helper.h      |   8 +-
>>   target/ppc/insn32.decode |  25 ++
>>   target/ppc/mem_helper.c  |   8 +-
>>   target/ppc/translate.c   | 495 +++++++++++++++++++++------------------
>>   4 files changed, 299 insertions(+), 237 deletions(-)
>>
>> diff --git a/target/ppc/helper.h b/target/ppc/helper.h
>> index e99c8c824b..37803ebb17 100644
>> --- a/target/ppc/helper.h
>> +++ b/target/ppc/helper.h
>> @@ -48,12 +48,12 @@ DEF_HELPER_FLAGS_3(stmw, TCG_CALL_NO_WG, void, 
>> env, tl, i32)
>>   DEF_HELPER_4(lsw, void, env, tl, i32, i32)
>>   DEF_HELPER_5(lswx, void, env, tl, i32, i32, i32)
>>   DEF_HELPER_FLAGS_4(stsw, TCG_CALL_NO_WG, void, env, tl, i32, i32)
>> -DEF_HELPER_FLAGS_3(dcbz, TCG_CALL_NO_WG, void, env, tl, int)
>> +DEF_HELPER_FLAGS_3(DCBZ, TCG_CALL_NO_WG, void, env, tl, int)
>>   #ifdef TARGET_PPC64
>> -DEF_HELPER_FLAGS_2(dcbzl, TCG_CALL_NO_WG, void, env, tl)
>> +DEF_HELPER_FLAGS_2(DCBZL, TCG_CALL_NO_WG, void, env, tl)
>>   #endif
>> -DEF_HELPER_FLAGS_2(icbi, TCG_CALL_NO_WG, void, env, tl)
>> -DEF_HELPER_FLAGS_2(icbiep, TCG_CALL_NO_WG, void, env, tl)
>> +DEF_HELPER_FLAGS_2(ICBI, TCG_CALL_NO_WG, void, env, tl)
>> +DEF_HELPER_FLAGS_2(ICBIEP, TCG_CALL_NO_WG, void, env, tl)
>>   DEF_HELPER_5(lscbx, tl, env, tl, i32, i32, i32)
>>     #if defined(TARGET_PPC64)
>> diff --git a/target/ppc/insn32.decode b/target/ppc/insn32.decode
>> index 26948e08a7..0fbabefba9 100644
>> --- a/target/ppc/insn32.decode
>> +++ b/target/ppc/insn32.decode
>> @@ -1306,6 +1306,31 @@ XVF64GERPN      111011 ... -- .... 0 ..... 
>> 10111010 ..-  @XX3_at xa=%xx_xa_pair
>>   XVF64GERNP      111011 ... -- .... 0 ..... 01111010 ..- @XX3_at 
>> xa=%xx_xa_pair
>>   XVF64GERNN      111011 ... -- .... 0 ..... 11111010 ..- @XX3_at 
>> xa=%xx_xa_pair
>>   +## Cache Management Instructions
>> +DCBF            011111 ..... ..... ..... 0001010110 -   @X
>> +DCBFEP          011111 ..... ..... ..... 0001111111 -   @X
>> +DCBI            011111 ..... ..... ..... 0111010110 -   @X
>> +DCBST           011111 ..... ..... ..... 0000110110 -   @X
>> +DCBSTEP         011111 ..... ..... ..... 0000111111 -   @X
>> +DCBA            011111 ..... ..... ..... 1011110110 -   @X
>> +
>> +DCBT            011111 ..... ..... ..... 0100010110 -   @X
>> +DCBTEP          011111 ..... ..... ..... 0100111111 -   @X
>> +DCBTST          011111 ..... ..... ..... 0011110110 -   @X
>> +DCBTSTEP        011111 ..... ..... ..... 0011111111 -   @X
>> +
>> +DCBTLS          011111 ..... ..... ..... 0010100110 -   @X
>> +DCBLC           011111 ..... ..... ..... 0110000110 -   @X
>> +
>> +DCBZ            011111 ..... ..... ..... 1111110110 -   @X
>> +DCBZEP          011111 ..... ..... ..... 1111111111 -   @X
>> +ICBI            011111 ..... ..... ..... 1111010110 -   @X
>> +ICBIEP          011111 ..... ..... ..... 1111011111 -   @X
>> +
>> +DST             011111 ..... ..... ..... 0101010110 -   @X
>> +DSTST           011111 ..... ..... ..... 0101110110 -   @X
>> +DSS             011111 ..... ..... ..... 1100110110 -   @X
> Just noticed that many of the instructions above do not accurately 
> represent the reserved bits, and take them as part of the rt field in 
> the arg_X struct.
> Eg, as per ISA 3.1C :
> For DCBF : Bits 6-7 are reserved and bits 8-10 are L field. In your 
> patch, you are including the reserved bits as part of the L field, 
> which is misleading IMO and could be a recipe for wrong emulation if 
> the reserved bits are given meaning at some point.
> For DCBZ: Bits 6-10 are reserved which is not represented here.
>
> I have not checked individually for all the 20 odd instructions but I 
> guess one would expect the instructions to be represented correctly in 
> the spec.
>
> -Chinmay
>> +
>>   ##Extend Sign Word and Shift Left Immediate XS-form
>>   EXTSWSLI         011111 ..... ..... ..... 110111101 . .         @XS
>>   diff --git a/target/ppc/mem_helper.c b/target/ppc/mem_helper.c
>> index 119dc1df23..5d3d377261 100644
>> --- a/target/ppc/mem_helper.c
>> +++ b/target/ppc/mem_helper.c
>> @@ -319,13 +319,13 @@ static void dcbz_common(CPUPPCState *env, 
>> target_ulong addr,
>>       clear_helper_retaddr();
>>   }
>>   -void helper_dcbz(CPUPPCState *env, target_ulong addr, int mmu_idx)
>> +void helper_DCBZ(CPUPPCState *env, target_ulong addr, int mmu_idx)
>>   {
>>       dcbz_common(env, addr, mmu_idx, env->dcache_line_size, GETPC());
>>   }
>>     #ifdef TARGET_PPC64
>> -void helper_dcbzl(CPUPPCState *env, target_ulong addr)
>> +void helper_DCBZL(CPUPPCState *env, target_ulong addr)
>>   {
>>       int dcbz_size = env->dcache_line_size;
>>   @@ -341,7 +341,7 @@ void helper_dcbzl(CPUPPCState *env, 
>> target_ulong addr)
>>   }
>>   #endif
>>   -void helper_icbi(CPUPPCState *env, target_ulong addr)
>> +void helper_ICBI(CPUPPCState *env, target_ulong addr)
>>   {
>>       unsigned mmu_idx = cpu_mmu_index(env_cpu(env), false);
>>       MemOpIdx oi = make_memop_idx(MO_UL | MO_UNALN, mmu_idx);
>> @@ -357,7 +357,7 @@ void helper_icbi(CPUPPCState *env, target_ulong 
>> addr)
>>       cpu_ldl_mmu(env, addr, oi, GETPC());
>>   }
>>   -void helper_icbiep(CPUPPCState *env, target_ulong addr)
>> +void helper_ICBIEP(CPUPPCState *env, target_ulong addr)
>>   {
>>   #if !defined(CONFIG_USER_ONLY)
>>       MemOpIdx oi = make_memop_idx(MO_UL | MO_UNALN, PPC_TLB_EPID_LOAD);
>> diff --git a/target/ppc/translate.c b/target/ppc/translate.c
>> index 3f009cd9ca..98712b343b 100644
>> --- a/target/ppc/translate.c
>> +++ b/target/ppc/translate.c
>> @@ -4296,216 +4296,6 @@ static void gen_setb(DisasContext *ctx)
>>   }
>>   #endif
>>   -/***                         Cache 
>> management                              ***/
>> -
>> -/* dcbf */
>> -static void gen_dcbf(DisasContext *ctx)
>> -{
>> -    /* XXX: specification says this is treated as a load by the MMU */
>> -    TCGv t0;
>> -    gen_set_access_type(ctx, ACCESS_CACHE);
>> -    t0 = tcg_temp_new();
>> -    gen_addr_reg_index(ctx, t0);
>> -    gen_qemu_ld8u(ctx, t0, t0);
>> -}
>> -
>> -/* dcbfep (external PID dcbf) */
>> -static void gen_dcbfep(DisasContext *ctx)
>> -{
>> -    /* XXX: specification says this is treated as a load by the MMU */
>> -    TCGv t0;
>> -    CHK_SV(ctx);
>> -    gen_set_access_type(ctx, ACCESS_CACHE);
>> -    t0 = tcg_temp_new();
>> -    gen_addr_reg_index(ctx, t0);
>> -    tcg_gen_qemu_ld_tl(t0, t0, PPC_TLB_EPID_LOAD, DEF_MEMOP(MO_UB));
>> -}
>> -
>> -/* dcbi (Supervisor only) */
>> -static void gen_dcbi(DisasContext *ctx)
>> -{
>> -#if defined(CONFIG_USER_ONLY)
>> -    GEN_PRIV(ctx);
>> -#else
>> -    TCGv EA, val;
>> -
>> -    CHK_SV(ctx);
>> -    EA = tcg_temp_new();
>> -    gen_set_access_type(ctx, ACCESS_CACHE);
>> -    gen_addr_reg_index(ctx, EA);
>> -    val = tcg_temp_new();
>> -    /* XXX: specification says this should be treated as a store by 
>> the MMU */
>> -    gen_qemu_ld8u(ctx, val, EA);
>> -    gen_qemu_st8(ctx, val, EA);
>> -#endif /* defined(CONFIG_USER_ONLY) */
>> -}
>> -
>> -/* dcdst */
>> -static void gen_dcbst(DisasContext *ctx)
>> -{
>> -    /* XXX: specification say this is treated as a load by the MMU */
>> -    TCGv t0;
>> -    gen_set_access_type(ctx, ACCESS_CACHE);
>> -    t0 = tcg_temp_new();
>> -    gen_addr_reg_index(ctx, t0);
>> -    gen_qemu_ld8u(ctx, t0, t0);
>> -}
>> -
>> -/* dcbstep (dcbstep External PID version) */
>> -static void gen_dcbstep(DisasContext *ctx)
>> -{
>> -    /* XXX: specification say this is treated as a load by the MMU */
>> -    TCGv t0;
>> -    gen_set_access_type(ctx, ACCESS_CACHE);
>> -    t0 = tcg_temp_new();
>> -    gen_addr_reg_index(ctx, t0);
>> -    tcg_gen_qemu_ld_tl(t0, t0, PPC_TLB_EPID_LOAD, DEF_MEMOP(MO_UB));
>> -}
>> -
>> -/* dcbt */
>> -static void gen_dcbt(DisasContext *ctx)
>> -{
>> -    /*
>> -     * interpreted as no-op
>> -     * XXX: specification say this is treated as a load by the MMU but
>> -     *      does not generate any exception
>> -     */
>> -}
>> -
>> -/* dcbtep */
>> -static void gen_dcbtep(DisasContext *ctx)
>> -{
>> -    /*
>> -     * interpreted as no-op
>> -     * XXX: specification say this is treated as a load by the MMU but
>> -     *      does not generate any exception
>> -     */
>> -}
>> -
>> -/* dcbtst */
>> -static void gen_dcbtst(DisasContext *ctx)
>> -{
>> -    /*
>> -     * interpreted as no-op
>> -     * XXX: specification say this is treated as a load by the MMU but
>> -     *      does not generate any exception
>> -     */
>> -}
>> -
>> -/* dcbtstep */
>> -static void gen_dcbtstep(DisasContext *ctx)
>> -{
>> -    /*
>> -     * interpreted as no-op
>> -     * XXX: specification say this is treated as a load by the MMU but
>> -     *      does not generate any exception
>> -     */
>> -}
>> -
>> -/* dcbtls */
>> -static void gen_dcbtls(DisasContext *ctx)
>> -{
>> -    /* Always fails locking the cache */
>> -    TCGv t0 = tcg_temp_new();
>> -    gen_load_spr(t0, SPR_Exxx_L1CSR0);
>> -    tcg_gen_ori_tl(t0, t0, L1CSR0_CUL);
>> -    gen_store_spr(SPR_Exxx_L1CSR0, t0);
>> -}
>> -
>> -/* dcblc */
>> -static void gen_dcblc(DisasContext *ctx)
>> -{
>> -    /*
>> -     * interpreted as no-op
>> -     */
>> -}
>> -
>> -/* dcbz */
>> -static void gen_dcbz(DisasContext *ctx)
>> -{
>> -    TCGv tcgv_addr = tcg_temp_new();
>> -
>> -    gen_set_access_type(ctx, ACCESS_CACHE);
>> -    gen_addr_reg_index(ctx, tcgv_addr);
>> -
>> -#ifdef TARGET_PPC64
>> -    if (ctx->excp_model == POWERPC_EXCP_970 && !(ctx->opcode & 
>> 0x00200000)) {
>> -        gen_helper_dcbzl(tcg_env, tcgv_addr);
>> -        return;
>> -    }
>> -#endif
>> -
>> -    gen_helper_dcbz(tcg_env, tcgv_addr, 
>> tcg_constant_i32(ctx->mem_idx));
>> -}
>> -
>> -/* dcbzep */
>> -static void gen_dcbzep(DisasContext *ctx)
>> -{
>> -    TCGv tcgv_addr = tcg_temp_new();
>> -
>> -    gen_set_access_type(ctx, ACCESS_CACHE);
>> -    gen_addr_reg_index(ctx, tcgv_addr);
>> -    gen_helper_dcbz(tcg_env, tcgv_addr, 
>> tcg_constant_i32(PPC_TLB_EPID_STORE));
>> -}
>> -
>> -/* dst / dstt */
>> -static void gen_dst(DisasContext *ctx)
>> -{
>> -    if (rA(ctx->opcode) == 0) {
>> -        gen_inval_exception(ctx, POWERPC_EXCP_INVAL_INVAL);
>> -    } else {
>> -        /* interpreted as no-op */
>> -    }
>> -}
>> -
>> -/* dstst /dststt */
>> -static void gen_dstst(DisasContext *ctx)
>> -{
>> -    if (rA(ctx->opcode) == 0) {
>> -        gen_inval_exception(ctx, POWERPC_EXCP_INVAL_INVAL);
>> -    } else {
>> -        /* interpreted as no-op */
>> -    }
>> -
>> -}
>> -
>> -/* dss / dssall */
>> -static void gen_dss(DisasContext *ctx)
>> -{
>> -    /* interpreted as no-op */
>> -}
>> -
>> -/* icbi */
>> -static void gen_icbi(DisasContext *ctx)
>> -{
>> -    TCGv t0;
>> -    gen_set_access_type(ctx, ACCESS_CACHE);
>> -    t0 = tcg_temp_new();
>> -    gen_addr_reg_index(ctx, t0);
>> -    gen_helper_icbi(tcg_env, t0);
>> -}
>> -
>> -/* icbiep */
>> -static void gen_icbiep(DisasContext *ctx)
>> -{
>> -    TCGv t0;
>> -    gen_set_access_type(ctx, ACCESS_CACHE);
>> -    t0 = tcg_temp_new();
>> -    gen_addr_reg_index(ctx, t0);
>> -    gen_helper_icbiep(tcg_env, t0);
>> -}
>> -
>> -/* Optional: */
>> -/* dcba */
>> -static void gen_dcba(DisasContext *ctx)
>> -{
>> -    /*
>> -     * interpreted as no-op
>> -     * XXX: specification say this is treated as a store by the MMU
>> -     *      but does not generate any exception
>> -     */
>> -}
>> -
>>   /***                    Segment register 
>> manipulation                      ***/
>>   /* Supervisor only: */
>>   @@ -5764,6 +5554,272 @@ static bool trans_LQARX(DisasContext *ctx, 
>> arg_LQARX *a)
>>       return true;
>>   }
>>   +/*
>> + * Cache Management Instructions (decodetree)
>> + */
>> +
>> +static bool trans_DCBA(DisasContext *ctx, arg_X *a)
>> +{
>> +    REQUIRE_INSNS_FLAGS(ctx, CACHE_DCBA);
>> +    return true;
>> +}
>> +
>> +static bool trans_DCBT(DisasContext *ctx, arg_X *a)
>> +{
>> +    REQUIRE_INSNS_FLAGS(ctx, CACHE);
>> +    return true;
>> +}
>> +
>> +static bool trans_DCBTEP(DisasContext *ctx, arg_X *a)
>> +{
>> +    REQUIRE_INSNS_FLAGS2(ctx, BOOKE206);
>> +    return true;
>> +}
>> +
>> +static bool trans_DCBTST(DisasContext *ctx, arg_X *a)
>> +{
>> +    REQUIRE_INSNS_FLAGS(ctx, CACHE);
>> +    return true;
>> +}
>> +
>> +static bool trans_DCBTSTEP(DisasContext *ctx, arg_X *a)
>> +{
>> +    REQUIRE_INSNS_FLAGS2(ctx, BOOKE206);
>> +    return true;
>> +}
>> +
>> +static bool trans_DCBLC(DisasContext *ctx, arg_X *a)
>> +{
>> +    /* Requires either PPC_BOOKE or PPC2_BOOKE206 */
>> +    if (!(ctx->insns_flags & PPC_BOOKE) &&
>> +        !(ctx->insns_flags2 & PPC2_BOOKE206)) {
>> +        return false;
>> +    }
>> +    return true;
>> +}
>> +
>> +static bool trans_DSS(DisasContext *ctx, arg_X *a)
>> +{
>> +    REQUIRE_INSNS_FLAGS(ctx, ALTIVEC);
>> +    return true;
>> +}
>> +
>> +static bool trans_DCBTLS(DisasContext *ctx, arg_X *a)
>> +{
>> +    TCGv t0 = tcg_temp_new();
>> +
>> +    /* Requires either PPC_BOOKE or PPC2_BOOKE206 */
>> +    if (!(ctx->insns_flags & PPC_BOOKE) &&
>> +        !(ctx->insns_flags2 & PPC2_BOOKE206)) {
>> +        return false;
>> +    }
>> +
>> +    gen_load_spr(t0, SPR_Exxx_L1CSR0);
>> +    tcg_gen_ori_tl(t0, t0, L1CSR0_CUL);
>> +    gen_store_spr(SPR_Exxx_L1CSR0, t0);
>> +
>> +    return true;
>> +}
>> +
>> +static bool trans_DST(DisasContext *ctx, arg_X *a)
>> +{
>> +    REQUIRE_INSNS_FLAGS(ctx, ALTIVEC);
>> +
>> +    if (a->ra == 0) {
>> +        gen_inval_exception(ctx, POWERPC_EXCP_INVAL_INVAL);
>> +    }
>> +
>> +    return true;
>> +}
>> +
>> +static bool trans_DSTST(DisasContext *ctx, arg_X *a)
>> +{
>> +    REQUIRE_INSNS_FLAGS(ctx, ALTIVEC);
>> +
>> +    if (a->ra == 0) {
>> +        gen_inval_exception(ctx, POWERPC_EXCP_INVAL_INVAL);
>> +    }
>> +
>> +    return true;
>> +}
>> +
>> +static bool trans_DCBF(DisasContext *ctx, arg_X *a)
>> +{
>> +    TCGv EA;
>> +
>> +    REQUIRE_INSNS_FLAGS(ctx, CACHE);
>> +
>> +    /*
>> +     * As per PowerISA v3.1, the L field (mapped to a->rt in X-form)
>> +     * can have values 0, 1, 3, 4, or 6. Other values are Undefined 
>> Behavior (UB).
>> +     */
>> +    switch (a->rt) {
>> +    case 0: /* dcbf */
>> +    case 1: /* dcbfl */
>> +    case 3: /* dcbflp */
>> +    case 4: /* dcbfps */
>> +    case 6: /* dcbstps */
>> +        break;
>> +    default:
>> +        gen_inval_exception(ctx, POWERPC_EXCP_INVAL_INVAL);
>> +        return true;
>> +    }
>> +
>> +    gen_set_access_type(ctx, ACCESS_CACHE);
>> +    EA = do_ea_calc(ctx, a->ra, cpu_gpr[a->rb]);
>> +    gen_qemu_ld8u(ctx, EA, EA);
>> +
>> +    return true;
>> +}
>> +
>> +static bool trans_DCBST(DisasContext *ctx, arg_X *a)
>> +{
>> +
>> +    if (a->rt != 0) {
>> +        gen_inval_exception(ctx, POWERPC_EXCP_INVAL_INVAL);
>> +        return true;
>> +    }
>> +
>> +    /* Flags check overlaps with trans_DCBF */
>> +    return trans_DCBF(ctx, a);
>> +}
>> +
>> +static bool trans_DCBFEP(DisasContext *ctx, arg_X *a)
>> +{
>> +    TCGv EA;
>> +
>> +    REQUIRE_INSNS_FLAGS2(ctx, BOOKE206);
>> +
>> +    /* Per ISA: RT must be zero for cache management instructions */
>> +    if (a->rt != 0) {
>> +        gen_inval_exception(ctx, POWERPC_EXCP_INVAL_INVAL);
>> +        return true;
>> +    }
>> +
>> +    REQUIRE_SV(ctx);
>> +
>> +    gen_set_access_type(ctx, ACCESS_CACHE);
>> +    EA = do_ea_calc(ctx, a->ra, cpu_gpr[a->rb]);
>> +
>> +    tcg_gen_qemu_ld_tl(EA, EA, PPC_TLB_EPID_LOAD, DEF_MEMOP(MO_UB));
>> +
>> +    return true;
>> +}
>> +
>> +static bool trans_DCBSTEP(DisasContext *ctx, arg_X *a)
>> +{
>> +    /* Flags check overlaps with trans_DCBFEP */
>> +    return trans_DCBFEP(ctx, a);
>> +}
>> +
>> +static bool trans_DCBI(DisasContext *ctx, arg_X *a)
>> +{
>> +#if defined(CONFIG_USER_ONLY)
>> +    gen_priv_opc(ctx);
>> +    return true;
>> +#else
>> +    TCGv EA, val;
>> +    REQUIRE_INSNS_FLAGS(ctx, CACHE);
>> +
>> +    if (a->rt != 0) {
>> +        gen_inval_exception(ctx, POWERPC_EXCP_INVAL_INVAL);
>> +        return true;
>> +    }
>> +
>> +    REQUIRE_SV(ctx);
>> +    gen_set_access_type(ctx, ACCESS_CACHE);
>> +    EA = do_ea_calc(ctx, a->ra, cpu_gpr[a->rb]);
>> +    val = tcg_temp_new();
>> +
>> +    gen_qemu_ld8u(ctx, val, EA);
>> +    gen_qemu_st8(ctx, val, EA);
>> +
>> +    return true;
>> +#endif
>> +}
>> +
>> +static bool trans_ICBI(DisasContext *ctx, arg_X *a)
>> +{
>> +    TCGv EA;
>> +
>> +    REQUIRE_INSNS_FLAGS(ctx, CACHE_ICBI);
>> +
>> +    if (a->rt != 0) {
>> +        gen_inval_exception(ctx, POWERPC_EXCP_INVAL_INVAL);
>> +        return true;
>> +    }
>> +
>> +
>> +    gen_set_access_type(ctx, ACCESS_CACHE);
>> +
>> +    EA = do_ea_calc(ctx, a->ra, cpu_gpr[a->rb]);
>> +    gen_helper_ICBI(tcg_env, EA);
>> +
>> +    return true;
>> +}
>> +
>> +static bool trans_ICBIEP(DisasContext *ctx, arg_X *a)
>> +{
>> +    TCGv EA;
>> +
>> +    REQUIRE_INSNS_FLAGS2(ctx, BOOKE206);
>> +    REQUIRE_SV(ctx);
>> +
>> +    gen_set_access_type(ctx, ACCESS_CACHE);
>> +    EA = do_ea_calc(ctx, a->ra, cpu_gpr[a->rb]);
>> +
>> +    gen_helper_ICBIEP(tcg_env, EA);
>> +    return true;
>> +}
>> +
>> +static bool trans_DCBZ(DisasContext *ctx, arg_X *a)
>> +{
>> +    TCGv EA;
>> +
>> +    REQUIRE_INSNS_FLAGS(ctx, CACHE_DCBZ);
>> +
>> +    if (a->rt != 0) {
>> +        gen_inval_exception(ctx, POWERPC_EXCP_INVAL_INVAL);
>> +        return true;
>> +    }
>> +
>> +
>> +    gen_set_access_type(ctx, ACCESS_CACHE);
>> +
>> +    EA = do_ea_calc(ctx, a->ra, cpu_gpr[a->rb]);
>> +
>> +#if defined(TARGET_PPC64)
>> +    if (ctx->excp_model == POWERPC_EXCP_970 &&
>> +        !(ctx->opcode & 0x00200000)) {
>> +        gen_helper_DCBZL(tcg_env, EA);
>> +        return true;
>> +    }
>> +#endif
>> +
>> +    gen_helper_DCBZ(tcg_env, EA, tcg_constant_i32(ctx->mem_idx));
>> +    return true;
>> +}
>> +
>> +static bool trans_DCBZEP(DisasContext *ctx, arg_X *a)
>> +{
>> +    TCGv EA;
>> +
>> +    REQUIRE_INSNS_FLAGS2(ctx, BOOKE206);
>> +
>> +    if (a->rt != 0) {
>> +        gen_inval_exception(ctx, POWERPC_EXCP_INVAL_INVAL);
>> +        return true;
>> +    }
>> +
>> +    REQUIRE_SV(ctx);
>> +
>> +    gen_set_access_type(ctx, ACCESS_CACHE);
>> +    EA = do_ea_calc(ctx, a->ra, cpu_gpr[a->rb]);
>> +
>> +    gen_helper_DCBZ(tcg_env, EA, tcg_constant_i32(PPC_TLB_EPID_STORE));
>> +    return true;
>> +}
>> +
>>   #include "translate/fixedpoint-impl.c.inc"
>>     #include "translate/fp-impl.c.inc"
>> @@ -5928,25 +5984,6 @@ GEN_HANDLER_E(mcrxrx, 0x1F, 0x00, 0x12, 
>> 0x007FF801, PPC_NONE, PPC2_ISA300),
>>   #endif
>>   GEN_HANDLER(mtmsr, 0x1F, 0x12, 0x04, 0x001EF801, PPC_MISC),
>>   GEN_HANDLER(mtspr, 0x1F, 0x13, 0x0E, 0x00000000, PPC_MISC),
>> -GEN_HANDLER(dcbf, 0x1F, 0x16, 0x02, 0x03C00001, PPC_CACHE),
>> -GEN_HANDLER_E(dcbfep, 0x1F, 0x1F, 0x03, 0x03C00001, PPC_NONE, 
>> PPC2_BOOKE206),
>> -GEN_HANDLER(dcbi, 0x1F, 0x16, 0x0E, 0x03E00001, PPC_CACHE),
>> -GEN_HANDLER(dcbst, 0x1F, 0x16, 0x01, 0x03E00001, PPC_CACHE),
>> -GEN_HANDLER_E(dcbstep, 0x1F, 0x1F, 0x01, 0x03E00001, PPC_NONE, 
>> PPC2_BOOKE206),
>> -GEN_HANDLER(dcbt, 0x1F, 0x16, 0x08, 0x00000001, PPC_CACHE),
>> -GEN_HANDLER_E(dcbtep, 0x1F, 0x1F, 0x09, 0x00000001, PPC_NONE, 
>> PPC2_BOOKE206),
>> -GEN_HANDLER(dcbtst, 0x1F, 0x16, 0x07, 0x00000001, PPC_CACHE),
>> -GEN_HANDLER_E(dcbtstep, 0x1F, 0x1F, 0x07, 0x00000001, PPC_NONE, 
>> PPC2_BOOKE206),
>> -GEN_HANDLER_E(dcbtls, 0x1F, 0x06, 0x05, 0x02000001, PPC_BOOKE, 
>> PPC2_BOOKE206),
>> -GEN_HANDLER_E(dcblc, 0x1F, 0x06, 0x0c, 0x02000001, PPC_BOOKE, 
>> PPC2_BOOKE206),
>> -GEN_HANDLER(dcbz, 0x1F, 0x16, 0x1F, 0x03C00001, PPC_CACHE_DCBZ),
>> -GEN_HANDLER_E(dcbzep, 0x1F, 0x1F, 0x1F, 0x03C00001, PPC_NONE, 
>> PPC2_BOOKE206),
>> -GEN_HANDLER(dst, 0x1F, 0x16, 0x0A, 0x01800001, PPC_ALTIVEC),
>> -GEN_HANDLER(dstst, 0x1F, 0x16, 0x0B, 0x01800001, PPC_ALTIVEC),
>> -GEN_HANDLER(dss, 0x1F, 0x16, 0x19, 0x019FF801, PPC_ALTIVEC),
>> -GEN_HANDLER(icbi, 0x1F, 0x16, 0x1E, 0x03E00001, PPC_CACHE_ICBI),
>> -GEN_HANDLER_E(icbiep, 0x1F, 0x1F, 0x1E, 0x03E00001, PPC_NONE, 
>> PPC2_BOOKE206),
>> -GEN_HANDLER(dcba, 0x1F, 0x16, 0x17, 0x03E00001, PPC_CACHE_DCBA),
>>   GEN_HANDLER(mfsr, 0x1F, 0x13, 0x12, 0x0010F801, PPC_SEGMENT),
>>   GEN_HANDLER(mfsrin, 0x1F, 0x13, 0x14, 0x001F0001, PPC_SEGMENT),
>>   GEN_HANDLER(mtsr, 0x1F, 0x12, 0x06, 0x0010F801, PPC_SEGMENT),
>
--------------W0kvT0WUxMGmaFts0yMDy34n
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: 8bit

<!DOCTYPE html>
<html>
  <head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
  </head>
  <body>
    <p><font face="Arial">Tested-by: Tasmiya Nalatwad <a
          class="moz-txt-link-rfc2396E"
          href="mailto:tasmiya@linux.ibm.com">&lt;tasmiya@linux.ibm.com&gt;</a></font></p>
    <p><font face="Arial">I tested the patch on my setup and can confirm
        it fixes the "illegal instruction" issue I was seeing with HTX
        mdt.all on a KVM guest.</font></p>
    <p><font face="Arial"><b>Issue observed (before patch) :</b><br>
        With HTX mdt.all running on the guest, hxecpu would crash with:<br>
      </font> <font face="Arial"><br>
        <i>"hxecpu[7487]: illegal instruction (4) at 7fffbc401054 nip
          7fffbc401054 lr 7fffbc400adc code 1"</i></font></p>
    <p><font face="Arial"><b>After applying this patch:</b><br>
        The illegal instruction errors are no longer seen in dmesg, and
        hxecpu runs cleanly through HTX. </font></p>
    <p><br>
    </p>
    <p><br>
    </p>
    <div class="moz-cite-prefix">On 08/07/26 5:41 pm, Chinmay Rath
      wrote:<br>
    </div>
    <blockquote type="cite"
      cite="mid:200dc51d-c524-4944-9d82-86e6ee3c7312@linux.ibm.com">
      <br>
      On 6/30/26 20:12, Nikhil Kumar Singh wrote:
      <br>
      <blockquote type="cite">Convert cache management instructions to
        decodetree using the X-form
        <br>
        layout and dedicated translation functions.
        <br>
        <br>
        Legacy GEN_HANDLER-based implementations are removed.
        <br>
        <br>
        The implementation preserves legacy semantics, including:
        <br>
           - MMU-visible accesses for instructions treated as loads
        <br>
             (e.g. dcbt, dcbtst, dcbtep, dcbtstep)
        <br>
           - Supervisor and BookE-specific constraints
        <br>
           - Effective address computation via do_ea_calc()
        <br>
        <br>
        Instructions that were defined as no-ops in the legacy
        implementation
        <br>
        remain no-ops here.
        <br>
        <br>
        Testing:
        <br>
           - Verified TCG equivalence for all cache operations
        <br>
        <br>
        Signed-off-by: Nikhil Kumar Singh <a class="moz-txt-link-rfc2396E" href="mailto:nikhilks@linux.ibm.com">&lt;nikhilks@linux.ibm.com&gt;</a>
        <br>
        Signed-off-by: Chinmay Rath <a class="moz-txt-link-rfc2396E" href="mailto:rathc@linux.ibm.com">&lt;rathc@linux.ibm.com&gt;</a>
        <br>
        [cr: linux user build, flag check, helper function fixes]
        <br>
        ---
        <br>
          target/ppc/helper.h      |   8 +-
        <br>
          target/ppc/insn32.decode |  25 ++
        <br>
          target/ppc/mem_helper.c  |   8 +-
        <br>
          target/ppc/translate.c   | 495
        +++++++++++++++++++++------------------
        <br>
          4 files changed, 299 insertions(+), 237 deletions(-)
        <br>
        <br>
        diff --git a/target/ppc/helper.h b/target/ppc/helper.h
        <br>
        index e99c8c824b..37803ebb17 100644
        <br>
        --- a/target/ppc/helper.h
        <br>
        +++ b/target/ppc/helper.h
        <br>
        @@ -48,12 +48,12 @@ DEF_HELPER_FLAGS_3(stmw, TCG_CALL_NO_WG,
        void, env, tl, i32)
        <br>
          DEF_HELPER_4(lsw, void, env, tl, i32, i32)
        <br>
          DEF_HELPER_5(lswx, void, env, tl, i32, i32, i32)
        <br>
          DEF_HELPER_FLAGS_4(stsw, TCG_CALL_NO_WG, void, env, tl, i32,
        i32)
        <br>
        -DEF_HELPER_FLAGS_3(dcbz, TCG_CALL_NO_WG, void, env, tl, int)
        <br>
        +DEF_HELPER_FLAGS_3(DCBZ, TCG_CALL_NO_WG, void, env, tl, int)
        <br>
          #ifdef TARGET_PPC64
        <br>
        -DEF_HELPER_FLAGS_2(dcbzl, TCG_CALL_NO_WG, void, env, tl)
        <br>
        +DEF_HELPER_FLAGS_2(DCBZL, TCG_CALL_NO_WG, void, env, tl)
        <br>
          #endif
        <br>
        -DEF_HELPER_FLAGS_2(icbi, TCG_CALL_NO_WG, void, env, tl)
        <br>
        -DEF_HELPER_FLAGS_2(icbiep, TCG_CALL_NO_WG, void, env, tl)
        <br>
        +DEF_HELPER_FLAGS_2(ICBI, TCG_CALL_NO_WG, void, env, tl)
        <br>
        +DEF_HELPER_FLAGS_2(ICBIEP, TCG_CALL_NO_WG, void, env, tl)
        <br>
          DEF_HELPER_5(lscbx, tl, env, tl, i32, i32, i32)
        <br>
            #if defined(TARGET_PPC64)
        <br>
        diff --git a/target/ppc/insn32.decode b/target/ppc/insn32.decode
        <br>
        index 26948e08a7..0fbabefba9 100644
        <br>
        --- a/target/ppc/insn32.decode
        <br>
        +++ b/target/ppc/insn32.decode
        <br>
        @@ -1306,6 +1306,31 @@ XVF64GERPN      111011 ... -- .... 0
        ..... 10111010 ..-  @XX3_at xa=%xx_xa_pair
        <br>
          XVF64GERNP      111011 ... -- .... 0 ..... 01111010 ..- 
        @XX3_at xa=%xx_xa_pair
        <br>
          XVF64GERNN      111011 ... -- .... 0 ..... 11111010 ..- 
        @XX3_at xa=%xx_xa_pair
        <br>
          +## Cache Management Instructions
        <br>
        +DCBF            011111 ..... ..... ..... 0001010110 -   @X
        <br>
        +DCBFEP          011111 ..... ..... ..... 0001111111 -   @X
        <br>
        +DCBI            011111 ..... ..... ..... 0111010110 -   @X
        <br>
        +DCBST           011111 ..... ..... ..... 0000110110 -   @X
        <br>
        +DCBSTEP         011111 ..... ..... ..... 0000111111 -   @X
        <br>
        +DCBA            011111 ..... ..... ..... 1011110110 -   @X
        <br>
        +
        <br>
        +DCBT            011111 ..... ..... ..... 0100010110 -   @X
        <br>
        +DCBTEP          011111 ..... ..... ..... 0100111111 -   @X
        <br>
        +DCBTST          011111 ..... ..... ..... 0011110110 -   @X
        <br>
        +DCBTSTEP        011111 ..... ..... ..... 0011111111 -   @X
        <br>
        +
        <br>
        +DCBTLS          011111 ..... ..... ..... 0010100110 -   @X
        <br>
        +DCBLC           011111 ..... ..... ..... 0110000110 -   @X
        <br>
        +
        <br>
        +DCBZ            011111 ..... ..... ..... 1111110110 -   @X
        <br>
        +DCBZEP          011111 ..... ..... ..... 1111111111 -   @X
        <br>
        +ICBI            011111 ..... ..... ..... 1111010110 -   @X
        <br>
        +ICBIEP          011111 ..... ..... ..... 1111011111 -   @X
        <br>
        +
        <br>
        +DST             011111 ..... ..... ..... 0101010110 -   @X
        <br>
        +DSTST           011111 ..... ..... ..... 0101110110 -   @X
        <br>
        +DSS             011111 ..... ..... ..... 1100110110 -   @X
        <br>
      </blockquote>
      Just noticed that many of the instructions above do not accurately
      represent the reserved bits, and take them as part of the rt field
      in the arg_X struct.
      <br>
      Eg, as per ISA 3.1C :
      <br>
      For DCBF : Bits 6-7 are reserved and bits 8-10 are L field. In
      your patch, you are including the reserved bits as part of the L
      field, which is misleading IMO and could be a recipe for wrong
      emulation if the reserved bits are given meaning at some point.
      <br>
      For DCBZ: Bits 6-10 are reserved which is not represented here.
      <br>
      <br>
      I have not checked individually for all the 20 odd instructions
      but I guess one would expect the instructions to be represented
      correctly in the spec.
      <br>
      <br>
      -Chinmay
      <br>
      <blockquote type="cite">+
        <br>
          ##Extend Sign Word and Shift Left Immediate XS-form
        <br>
          EXTSWSLI         011111 ..... ..... ..... 110111101 .
        .         @XS
        <br>
          diff --git a/target/ppc/mem_helper.c b/target/ppc/mem_helper.c
        <br>
        index 119dc1df23..5d3d377261 100644
        <br>
        --- a/target/ppc/mem_helper.c
        <br>
        +++ b/target/ppc/mem_helper.c
        <br>
        @@ -319,13 +319,13 @@ static void dcbz_common(CPUPPCState *env,
        target_ulong addr,
        <br>
              clear_helper_retaddr();
        <br>
          }
        <br>
          -void helper_dcbz(CPUPPCState *env, target_ulong addr, int
        mmu_idx)
        <br>
        +void helper_DCBZ(CPUPPCState *env, target_ulong addr, int
        mmu_idx)
        <br>
          {
        <br>
              dcbz_common(env, addr, mmu_idx, env-&gt;dcache_line_size,
        GETPC());
        <br>
          }
        <br>
            #ifdef TARGET_PPC64
        <br>
        -void helper_dcbzl(CPUPPCState *env, target_ulong addr)
        <br>
        +void helper_DCBZL(CPUPPCState *env, target_ulong addr)
        <br>
          {
        <br>
              int dcbz_size = env-&gt;dcache_line_size;
        <br>
          @@ -341,7 +341,7 @@ void helper_dcbzl(CPUPPCState *env,
        target_ulong addr)
        <br>
          }
        <br>
          #endif
        <br>
          -void helper_icbi(CPUPPCState *env, target_ulong addr)
        <br>
        +void helper_ICBI(CPUPPCState *env, target_ulong addr)
        <br>
          {
        <br>
              unsigned mmu_idx = cpu_mmu_index(env_cpu(env), false);
        <br>
              MemOpIdx oi = make_memop_idx(MO_UL | MO_UNALN, mmu_idx);
        <br>
        @@ -357,7 +357,7 @@ void helper_icbi(CPUPPCState *env,
        target_ulong addr)
        <br>
              cpu_ldl_mmu(env, addr, oi, GETPC());
        <br>
          }
        <br>
          -void helper_icbiep(CPUPPCState *env, target_ulong addr)
        <br>
        +void helper_ICBIEP(CPUPPCState *env, target_ulong addr)
        <br>
          {
        <br>
          #if !defined(CONFIG_USER_ONLY)
        <br>
              MemOpIdx oi = make_memop_idx(MO_UL | MO_UNALN,
        PPC_TLB_EPID_LOAD);
        <br>
        diff --git a/target/ppc/translate.c b/target/ppc/translate.c
        <br>
        index 3f009cd9ca..98712b343b 100644
        <br>
        --- a/target/ppc/translate.c
        <br>
        +++ b/target/ppc/translate.c
        <br>
        @@ -4296,216 +4296,6 @@ static void gen_setb(DisasContext *ctx)
        <br>
          }
        <br>
          #endif
        <br>
          -/***                         Cache
        management                              ***/
        <br>
        -
        <br>
        -/* dcbf */
        <br>
        -static void gen_dcbf(DisasContext *ctx)
        <br>
        -{
        <br>
        -    /* XXX: specification says this is treated as a load by the
        MMU */
        <br>
        -    TCGv t0;
        <br>
        -    gen_set_access_type(ctx, ACCESS_CACHE);
        <br>
        -    t0 = tcg_temp_new();
        <br>
        -    gen_addr_reg_index(ctx, t0);
        <br>
        -    gen_qemu_ld8u(ctx, t0, t0);
        <br>
        -}
        <br>
        -
        <br>
        -/* dcbfep (external PID dcbf) */
        <br>
        -static void gen_dcbfep(DisasContext *ctx)
        <br>
        -{
        <br>
        -    /* XXX: specification says this is treated as a load by the
        MMU */
        <br>
        -    TCGv t0;
        <br>
        -    CHK_SV(ctx);
        <br>
        -    gen_set_access_type(ctx, ACCESS_CACHE);
        <br>
        -    t0 = tcg_temp_new();
        <br>
        -    gen_addr_reg_index(ctx, t0);
        <br>
        -    tcg_gen_qemu_ld_tl(t0, t0, PPC_TLB_EPID_LOAD,
        DEF_MEMOP(MO_UB));
        <br>
        -}
        <br>
        -
        <br>
        -/* dcbi (Supervisor only) */
        <br>
        -static void gen_dcbi(DisasContext *ctx)
        <br>
        -{
        <br>
        -#if defined(CONFIG_USER_ONLY)
        <br>
        -    GEN_PRIV(ctx);
        <br>
        -#else
        <br>
        -    TCGv EA, val;
        <br>
        -
        <br>
        -    CHK_SV(ctx);
        <br>
        -    EA = tcg_temp_new();
        <br>
        -    gen_set_access_type(ctx, ACCESS_CACHE);
        <br>
        -    gen_addr_reg_index(ctx, EA);
        <br>
        -    val = tcg_temp_new();
        <br>
        -    /* XXX: specification says this should be treated as a
        store by the MMU */
        <br>
        -    gen_qemu_ld8u(ctx, val, EA);
        <br>
        -    gen_qemu_st8(ctx, val, EA);
        <br>
        -#endif /* defined(CONFIG_USER_ONLY) */
        <br>
        -}
        <br>
        -
        <br>
        -/* dcdst */
        <br>
        -static void gen_dcbst(DisasContext *ctx)
        <br>
        -{
        <br>
        -    /* XXX: specification say this is treated as a load by the
        MMU */
        <br>
        -    TCGv t0;
        <br>
        -    gen_set_access_type(ctx, ACCESS_CACHE);
        <br>
        -    t0 = tcg_temp_new();
        <br>
        -    gen_addr_reg_index(ctx, t0);
        <br>
        -    gen_qemu_ld8u(ctx, t0, t0);
        <br>
        -}
        <br>
        -
        <br>
        -/* dcbstep (dcbstep External PID version) */
        <br>
        -static void gen_dcbstep(DisasContext *ctx)
        <br>
        -{
        <br>
        -    /* XXX: specification say this is treated as a load by the
        MMU */
        <br>
        -    TCGv t0;
        <br>
        -    gen_set_access_type(ctx, ACCESS_CACHE);
        <br>
        -    t0 = tcg_temp_new();
        <br>
        -    gen_addr_reg_index(ctx, t0);
        <br>
        -    tcg_gen_qemu_ld_tl(t0, t0, PPC_TLB_EPID_LOAD,
        DEF_MEMOP(MO_UB));
        <br>
        -}
        <br>
        -
        <br>
        -/* dcbt */
        <br>
        -static void gen_dcbt(DisasContext *ctx)
        <br>
        -{
        <br>
        -    /*
        <br>
        -     * interpreted as no-op
        <br>
        -     * XXX: specification say this is treated as a load by the
        MMU but
        <br>
        -     *      does not generate any exception
        <br>
        -     */
        <br>
        -}
        <br>
        -
        <br>
        -/* dcbtep */
        <br>
        -static void gen_dcbtep(DisasContext *ctx)
        <br>
        -{
        <br>
        -    /*
        <br>
        -     * interpreted as no-op
        <br>
        -     * XXX: specification say this is treated as a load by the
        MMU but
        <br>
        -     *      does not generate any exception
        <br>
        -     */
        <br>
        -}
        <br>
        -
        <br>
        -/* dcbtst */
        <br>
        -static void gen_dcbtst(DisasContext *ctx)
        <br>
        -{
        <br>
        -    /*
        <br>
        -     * interpreted as no-op
        <br>
        -     * XXX: specification say this is treated as a load by the
        MMU but
        <br>
        -     *      does not generate any exception
        <br>
        -     */
        <br>
        -}
        <br>
        -
        <br>
        -/* dcbtstep */
        <br>
        -static void gen_dcbtstep(DisasContext *ctx)
        <br>
        -{
        <br>
        -    /*
        <br>
        -     * interpreted as no-op
        <br>
        -     * XXX: specification say this is treated as a load by the
        MMU but
        <br>
        -     *      does not generate any exception
        <br>
        -     */
        <br>
        -}
        <br>
        -
        <br>
        -/* dcbtls */
        <br>
        -static void gen_dcbtls(DisasContext *ctx)
        <br>
        -{
        <br>
        -    /* Always fails locking the cache */
        <br>
        -    TCGv t0 = tcg_temp_new();
        <br>
        -    gen_load_spr(t0, SPR_Exxx_L1CSR0);
        <br>
        -    tcg_gen_ori_tl(t0, t0, L1CSR0_CUL);
        <br>
        -    gen_store_spr(SPR_Exxx_L1CSR0, t0);
        <br>
        -}
        <br>
        -
        <br>
        -/* dcblc */
        <br>
        -static void gen_dcblc(DisasContext *ctx)
        <br>
        -{
        <br>
        -    /*
        <br>
        -     * interpreted as no-op
        <br>
        -     */
        <br>
        -}
        <br>
        -
        <br>
        -/* dcbz */
        <br>
        -static void gen_dcbz(DisasContext *ctx)
        <br>
        -{
        <br>
        -    TCGv tcgv_addr = tcg_temp_new();
        <br>
        -
        <br>
        -    gen_set_access_type(ctx, ACCESS_CACHE);
        <br>
        -    gen_addr_reg_index(ctx, tcgv_addr);
        <br>
        -
        <br>
        -#ifdef TARGET_PPC64
        <br>
        -    if (ctx-&gt;excp_model == POWERPC_EXCP_970 &amp;&amp;
        !(ctx-&gt;opcode &amp; 0x00200000)) {
        <br>
        -        gen_helper_dcbzl(tcg_env, tcgv_addr);
        <br>
        -        return;
        <br>
        -    }
        <br>
        -#endif
        <br>
        -
        <br>
        -    gen_helper_dcbz(tcg_env, tcgv_addr,
        tcg_constant_i32(ctx-&gt;mem_idx));
        <br>
        -}
        <br>
        -
        <br>
        -/* dcbzep */
        <br>
        -static void gen_dcbzep(DisasContext *ctx)
        <br>
        -{
        <br>
        -    TCGv tcgv_addr = tcg_temp_new();
        <br>
        -
        <br>
        -    gen_set_access_type(ctx, ACCESS_CACHE);
        <br>
        -    gen_addr_reg_index(ctx, tcgv_addr);
        <br>
        -    gen_helper_dcbz(tcg_env, tcgv_addr,
        tcg_constant_i32(PPC_TLB_EPID_STORE));
        <br>
        -}
        <br>
        -
        <br>
        -/* dst / dstt */
        <br>
        -static void gen_dst(DisasContext *ctx)
        <br>
        -{
        <br>
        -    if (rA(ctx-&gt;opcode) == 0) {
        <br>
        -        gen_inval_exception(ctx, POWERPC_EXCP_INVAL_INVAL);
        <br>
        -    } else {
        <br>
        -        /* interpreted as no-op */
        <br>
        -    }
        <br>
        -}
        <br>
        -
        <br>
        -/* dstst /dststt */
        <br>
        -static void gen_dstst(DisasContext *ctx)
        <br>
        -{
        <br>
        -    if (rA(ctx-&gt;opcode) == 0) {
        <br>
        -        gen_inval_exception(ctx, POWERPC_EXCP_INVAL_INVAL);
        <br>
        -    } else {
        <br>
        -        /* interpreted as no-op */
        <br>
        -    }
        <br>
        -
        <br>
        -}
        <br>
        -
        <br>
        -/* dss / dssall */
        <br>
        -static void gen_dss(DisasContext *ctx)
        <br>
        -{
        <br>
        -    /* interpreted as no-op */
        <br>
        -}
        <br>
        -
        <br>
        -/* icbi */
        <br>
        -static void gen_icbi(DisasContext *ctx)
        <br>
        -{
        <br>
        -    TCGv t0;
        <br>
        -    gen_set_access_type(ctx, ACCESS_CACHE);
        <br>
        -    t0 = tcg_temp_new();
        <br>
        -    gen_addr_reg_index(ctx, t0);
        <br>
        -    gen_helper_icbi(tcg_env, t0);
        <br>
        -}
        <br>
        -
        <br>
        -/* icbiep */
        <br>
        -static void gen_icbiep(DisasContext *ctx)
        <br>
        -{
        <br>
        -    TCGv t0;
        <br>
        -    gen_set_access_type(ctx, ACCESS_CACHE);
        <br>
        -    t0 = tcg_temp_new();
        <br>
        -    gen_addr_reg_index(ctx, t0);
        <br>
        -    gen_helper_icbiep(tcg_env, t0);
        <br>
        -}
        <br>
        -
        <br>
        -/* Optional: */
        <br>
        -/* dcba */
        <br>
        -static void gen_dcba(DisasContext *ctx)
        <br>
        -{
        <br>
        -    /*
        <br>
        -     * interpreted as no-op
        <br>
        -     * XXX: specification say this is treated as a store by the
        MMU
        <br>
        -     *      but does not generate any exception
        <br>
        -     */
        <br>
        -}
        <br>
        -
        <br>
          /***                    Segment register
        manipulation                      ***/
        <br>
          /* Supervisor only: */
        <br>
          @@ -5764,6 +5554,272 @@ static bool trans_LQARX(DisasContext
        *ctx, arg_LQARX *a)
        <br>
              return true;
        <br>
          }
        <br>
          +/*
        <br>
        + * Cache Management Instructions (decodetree)
        <br>
        + */
        <br>
        +
        <br>
        +static bool trans_DCBA(DisasContext *ctx, arg_X *a)
        <br>
        +{
        <br>
        +    REQUIRE_INSNS_FLAGS(ctx, CACHE_DCBA);
        <br>
        +    return true;
        <br>
        +}
        <br>
        +
        <br>
        +static bool trans_DCBT(DisasContext *ctx, arg_X *a)
        <br>
        +{
        <br>
        +    REQUIRE_INSNS_FLAGS(ctx, CACHE);
        <br>
        +    return true;
        <br>
        +}
        <br>
        +
        <br>
        +static bool trans_DCBTEP(DisasContext *ctx, arg_X *a)
        <br>
        +{
        <br>
        +    REQUIRE_INSNS_FLAGS2(ctx, BOOKE206);
        <br>
        +    return true;
        <br>
        +}
        <br>
        +
        <br>
        +static bool trans_DCBTST(DisasContext *ctx, arg_X *a)
        <br>
        +{
        <br>
        +    REQUIRE_INSNS_FLAGS(ctx, CACHE);
        <br>
        +    return true;
        <br>
        +}
        <br>
        +
        <br>
        +static bool trans_DCBTSTEP(DisasContext *ctx, arg_X *a)
        <br>
        +{
        <br>
        +    REQUIRE_INSNS_FLAGS2(ctx, BOOKE206);
        <br>
        +    return true;
        <br>
        +}
        <br>
        +
        <br>
        +static bool trans_DCBLC(DisasContext *ctx, arg_X *a)
        <br>
        +{
        <br>
        +    /* Requires either PPC_BOOKE or PPC2_BOOKE206 */
        <br>
        +    if (!(ctx-&gt;insns_flags &amp; PPC_BOOKE) &amp;&amp;
        <br>
        +        !(ctx-&gt;insns_flags2 &amp; PPC2_BOOKE206)) {
        <br>
        +        return false;
        <br>
        +    }
        <br>
        +    return true;
        <br>
        +}
        <br>
        +
        <br>
        +static bool trans_DSS(DisasContext *ctx, arg_X *a)
        <br>
        +{
        <br>
        +    REQUIRE_INSNS_FLAGS(ctx, ALTIVEC);
        <br>
        +    return true;
        <br>
        +}
        <br>
        +
        <br>
        +static bool trans_DCBTLS(DisasContext *ctx, arg_X *a)
        <br>
        +{
        <br>
        +    TCGv t0 = tcg_temp_new();
        <br>
        +
        <br>
        +    /* Requires either PPC_BOOKE or PPC2_BOOKE206 */
        <br>
        +    if (!(ctx-&gt;insns_flags &amp; PPC_BOOKE) &amp;&amp;
        <br>
        +        !(ctx-&gt;insns_flags2 &amp; PPC2_BOOKE206)) {
        <br>
        +        return false;
        <br>
        +    }
        <br>
        +
        <br>
        +    gen_load_spr(t0, SPR_Exxx_L1CSR0);
        <br>
        +    tcg_gen_ori_tl(t0, t0, L1CSR0_CUL);
        <br>
        +    gen_store_spr(SPR_Exxx_L1CSR0, t0);
        <br>
        +
        <br>
        +    return true;
        <br>
        +}
        <br>
        +
        <br>
        +static bool trans_DST(DisasContext *ctx, arg_X *a)
        <br>
        +{
        <br>
        +    REQUIRE_INSNS_FLAGS(ctx, ALTIVEC);
        <br>
        +
        <br>
        +    if (a-&gt;ra == 0) {
        <br>
        +        gen_inval_exception(ctx, POWERPC_EXCP_INVAL_INVAL);
        <br>
        +    }
        <br>
        +
        <br>
        +    return true;
        <br>
        +}
        <br>
        +
        <br>
        +static bool trans_DSTST(DisasContext *ctx, arg_X *a)
        <br>
        +{
        <br>
        +    REQUIRE_INSNS_FLAGS(ctx, ALTIVEC);
        <br>
        +
        <br>
        +    if (a-&gt;ra == 0) {
        <br>
        +        gen_inval_exception(ctx, POWERPC_EXCP_INVAL_INVAL);
        <br>
        +    }
        <br>
        +
        <br>
        +    return true;
        <br>
        +}
        <br>
        +
        <br>
        +static bool trans_DCBF(DisasContext *ctx, arg_X *a)
        <br>
        +{
        <br>
        +    TCGv EA;
        <br>
        +
        <br>
        +    REQUIRE_INSNS_FLAGS(ctx, CACHE);
        <br>
        +
        <br>
        +    /*
        <br>
        +     * As per PowerISA v3.1, the L field (mapped to a-&gt;rt in
        X-form)
        <br>
        +     * can have values 0, 1, 3, 4, or 6. Other values are
        Undefined Behavior (UB).
        <br>
        +     */
        <br>
        +    switch (a-&gt;rt) {
        <br>
        +    case 0: /* dcbf */
        <br>
        +    case 1: /* dcbfl */
        <br>
        +    case 3: /* dcbflp */
        <br>
        +    case 4: /* dcbfps */
        <br>
        +    case 6: /* dcbstps */
        <br>
        +        break;
        <br>
        +    default:
        <br>
        +        gen_inval_exception(ctx, POWERPC_EXCP_INVAL_INVAL);
        <br>
        +        return true;
        <br>
        +    }
        <br>
        +
        <br>
        +    gen_set_access_type(ctx, ACCESS_CACHE);
        <br>
        +    EA = do_ea_calc(ctx, a-&gt;ra, cpu_gpr[a-&gt;rb]);
        <br>
        +    gen_qemu_ld8u(ctx, EA, EA);
        <br>
        +
        <br>
        +    return true;
        <br>
        +}
        <br>
        +
        <br>
        +static bool trans_DCBST(DisasContext *ctx, arg_X *a)
        <br>
        +{
        <br>
        +
        <br>
        +    if (a-&gt;rt != 0) {
        <br>
        +        gen_inval_exception(ctx, POWERPC_EXCP_INVAL_INVAL);
        <br>
        +        return true;
        <br>
        +    }
        <br>
        +
        <br>
        +    /* Flags check overlaps with trans_DCBF */
        <br>
        +    return trans_DCBF(ctx, a);
        <br>
        +}
        <br>
        +
        <br>
        +static bool trans_DCBFEP(DisasContext *ctx, arg_X *a)
        <br>
        +{
        <br>
        +    TCGv EA;
        <br>
        +
        <br>
        +    REQUIRE_INSNS_FLAGS2(ctx, BOOKE206);
        <br>
        +
        <br>
        +    /* Per ISA: RT must be zero for cache management
        instructions */
        <br>
        +    if (a-&gt;rt != 0) {
        <br>
        +        gen_inval_exception(ctx, POWERPC_EXCP_INVAL_INVAL);
        <br>
        +        return true;
        <br>
        +    }
        <br>
        +
        <br>
        +    REQUIRE_SV(ctx);
        <br>
        +
        <br>
        +    gen_set_access_type(ctx, ACCESS_CACHE);
        <br>
        +    EA = do_ea_calc(ctx, a-&gt;ra, cpu_gpr[a-&gt;rb]);
        <br>
        +
        <br>
        +    tcg_gen_qemu_ld_tl(EA, EA, PPC_TLB_EPID_LOAD,
        DEF_MEMOP(MO_UB));
        <br>
        +
        <br>
        +    return true;
        <br>
        +}
        <br>
        +
        <br>
        +static bool trans_DCBSTEP(DisasContext *ctx, arg_X *a)
        <br>
        +{
        <br>
        +    /* Flags check overlaps with trans_DCBFEP */
        <br>
        +    return trans_DCBFEP(ctx, a);
        <br>
        +}
        <br>
        +
        <br>
        +static bool trans_DCBI(DisasContext *ctx, arg_X *a)
        <br>
        +{
        <br>
        +#if defined(CONFIG_USER_ONLY)
        <br>
        +    gen_priv_opc(ctx);
        <br>
        +    return true;
        <br>
        +#else
        <br>
        +    TCGv EA, val;
        <br>
        +    REQUIRE_INSNS_FLAGS(ctx, CACHE);
        <br>
        +
        <br>
        +    if (a-&gt;rt != 0) {
        <br>
        +        gen_inval_exception(ctx, POWERPC_EXCP_INVAL_INVAL);
        <br>
        +        return true;
        <br>
        +    }
        <br>
        +
        <br>
        +    REQUIRE_SV(ctx);
        <br>
        +    gen_set_access_type(ctx, ACCESS_CACHE);
        <br>
        +    EA = do_ea_calc(ctx, a-&gt;ra, cpu_gpr[a-&gt;rb]);
        <br>
        +    val = tcg_temp_new();
        <br>
        +
        <br>
        +    gen_qemu_ld8u(ctx, val, EA);
        <br>
        +    gen_qemu_st8(ctx, val, EA);
        <br>
        +
        <br>
        +    return true;
        <br>
        +#endif
        <br>
        +}
        <br>
        +
        <br>
        +static bool trans_ICBI(DisasContext *ctx, arg_X *a)
        <br>
        +{
        <br>
        +    TCGv EA;
        <br>
        +
        <br>
        +    REQUIRE_INSNS_FLAGS(ctx, CACHE_ICBI);
        <br>
        +
        <br>
        +    if (a-&gt;rt != 0) {
        <br>
        +        gen_inval_exception(ctx, POWERPC_EXCP_INVAL_INVAL);
        <br>
        +        return true;
        <br>
        +    }
        <br>
        +
        <br>
        +
        <br>
        +    gen_set_access_type(ctx, ACCESS_CACHE);
        <br>
        +
        <br>
        +    EA = do_ea_calc(ctx, a-&gt;ra, cpu_gpr[a-&gt;rb]);
        <br>
        +    gen_helper_ICBI(tcg_env, EA);
        <br>
        +
        <br>
        +    return true;
        <br>
        +}
        <br>
        +
        <br>
        +static bool trans_ICBIEP(DisasContext *ctx, arg_X *a)
        <br>
        +{
        <br>
        +    TCGv EA;
        <br>
        +
        <br>
        +    REQUIRE_INSNS_FLAGS2(ctx, BOOKE206);
        <br>
        +    REQUIRE_SV(ctx);
        <br>
        +
        <br>
        +    gen_set_access_type(ctx, ACCESS_CACHE);
        <br>
        +    EA = do_ea_calc(ctx, a-&gt;ra, cpu_gpr[a-&gt;rb]);
        <br>
        +
        <br>
        +    gen_helper_ICBIEP(tcg_env, EA);
        <br>
        +    return true;
        <br>
        +}
        <br>
        +
        <br>
        +static bool trans_DCBZ(DisasContext *ctx, arg_X *a)
        <br>
        +{
        <br>
        +    TCGv EA;
        <br>
        +
        <br>
        +    REQUIRE_INSNS_FLAGS(ctx, CACHE_DCBZ);
        <br>
        +
        <br>
        +    if (a-&gt;rt != 0) {
        <br>
        +        gen_inval_exception(ctx, POWERPC_EXCP_INVAL_INVAL);
        <br>
        +        return true;
        <br>
        +    }
        <br>
        +
        <br>
        +
        <br>
        +    gen_set_access_type(ctx, ACCESS_CACHE);
        <br>
        +
        <br>
        +    EA = do_ea_calc(ctx, a-&gt;ra, cpu_gpr[a-&gt;rb]);
        <br>
        +
        <br>
        +#if defined(TARGET_PPC64)
        <br>
        +    if (ctx-&gt;excp_model == POWERPC_EXCP_970 &amp;&amp;
        <br>
        +        !(ctx-&gt;opcode &amp; 0x00200000)) {
        <br>
        +        gen_helper_DCBZL(tcg_env, EA);
        <br>
        +        return true;
        <br>
        +    }
        <br>
        +#endif
        <br>
        +
        <br>
        +    gen_helper_DCBZ(tcg_env, EA,
        tcg_constant_i32(ctx-&gt;mem_idx));
        <br>
        +    return true;
        <br>
        +}
        <br>
        +
        <br>
        +static bool trans_DCBZEP(DisasContext *ctx, arg_X *a)
        <br>
        +{
        <br>
        +    TCGv EA;
        <br>
        +
        <br>
        +    REQUIRE_INSNS_FLAGS2(ctx, BOOKE206);
        <br>
        +
        <br>
        +    if (a-&gt;rt != 0) {
        <br>
        +        gen_inval_exception(ctx, POWERPC_EXCP_INVAL_INVAL);
        <br>
        +        return true;
        <br>
        +    }
        <br>
        +
        <br>
        +    REQUIRE_SV(ctx);
        <br>
        +
        <br>
        +    gen_set_access_type(ctx, ACCESS_CACHE);
        <br>
        +    EA = do_ea_calc(ctx, a-&gt;ra, cpu_gpr[a-&gt;rb]);
        <br>
        +
        <br>
        +    gen_helper_DCBZ(tcg_env, EA,
        tcg_constant_i32(PPC_TLB_EPID_STORE));
        <br>
        +    return true;
        <br>
        +}
        <br>
        +
        <br>
          #include "translate/fixedpoint-impl.c.inc"
        <br>
            #include "translate/fp-impl.c.inc"
        <br>
        @@ -5928,25 +5984,6 @@ GEN_HANDLER_E(mcrxrx, 0x1F, 0x00, 0x12,
        0x007FF801, PPC_NONE, PPC2_ISA300),
        <br>
          #endif
        <br>
          GEN_HANDLER(mtmsr, 0x1F, 0x12, 0x04, 0x001EF801, PPC_MISC),
        <br>
          GEN_HANDLER(mtspr, 0x1F, 0x13, 0x0E, 0x00000000, PPC_MISC),
        <br>
        -GEN_HANDLER(dcbf, 0x1F, 0x16, 0x02, 0x03C00001, PPC_CACHE),
        <br>
        -GEN_HANDLER_E(dcbfep, 0x1F, 0x1F, 0x03, 0x03C00001, PPC_NONE,
        PPC2_BOOKE206),
        <br>
        -GEN_HANDLER(dcbi, 0x1F, 0x16, 0x0E, 0x03E00001, PPC_CACHE),
        <br>
        -GEN_HANDLER(dcbst, 0x1F, 0x16, 0x01, 0x03E00001, PPC_CACHE),
        <br>
        -GEN_HANDLER_E(dcbstep, 0x1F, 0x1F, 0x01, 0x03E00001, PPC_NONE,
        PPC2_BOOKE206),
        <br>
        -GEN_HANDLER(dcbt, 0x1F, 0x16, 0x08, 0x00000001, PPC_CACHE),
        <br>
        -GEN_HANDLER_E(dcbtep, 0x1F, 0x1F, 0x09, 0x00000001, PPC_NONE,
        PPC2_BOOKE206),
        <br>
        -GEN_HANDLER(dcbtst, 0x1F, 0x16, 0x07, 0x00000001, PPC_CACHE),
        <br>
        -GEN_HANDLER_E(dcbtstep, 0x1F, 0x1F, 0x07, 0x00000001, PPC_NONE,
        PPC2_BOOKE206),
        <br>
        -GEN_HANDLER_E(dcbtls, 0x1F, 0x06, 0x05, 0x02000001, PPC_BOOKE,
        PPC2_BOOKE206),
        <br>
        -GEN_HANDLER_E(dcblc, 0x1F, 0x06, 0x0c, 0x02000001, PPC_BOOKE,
        PPC2_BOOKE206),
        <br>
        -GEN_HANDLER(dcbz, 0x1F, 0x16, 0x1F, 0x03C00001,
        PPC_CACHE_DCBZ),
        <br>
        -GEN_HANDLER_E(dcbzep, 0x1F, 0x1F, 0x1F, 0x03C00001, PPC_NONE,
        PPC2_BOOKE206),
        <br>
        -GEN_HANDLER(dst, 0x1F, 0x16, 0x0A, 0x01800001, PPC_ALTIVEC),
        <br>
        -GEN_HANDLER(dstst, 0x1F, 0x16, 0x0B, 0x01800001, PPC_ALTIVEC),
        <br>
        -GEN_HANDLER(dss, 0x1F, 0x16, 0x19, 0x019FF801, PPC_ALTIVEC),
        <br>
        -GEN_HANDLER(icbi, 0x1F, 0x16, 0x1E, 0x03E00001,
        PPC_CACHE_ICBI),
        <br>
        -GEN_HANDLER_E(icbiep, 0x1F, 0x1F, 0x1E, 0x03E00001, PPC_NONE,
        PPC2_BOOKE206),
        <br>
        -GEN_HANDLER(dcba, 0x1F, 0x16, 0x17, 0x03E00001,
        PPC_CACHE_DCBA),
        <br>
          GEN_HANDLER(mfsr, 0x1F, 0x13, 0x12, 0x0010F801, PPC_SEGMENT),
        <br>
          GEN_HANDLER(mfsrin, 0x1F, 0x13, 0x14, 0x001F0001,
        PPC_SEGMENT),
        <br>
          GEN_HANDLER(mtsr, 0x1F, 0x12, 0x06, 0x0010F801, PPC_SEGMENT),
        <br>
      </blockquote>
      <br>
    </blockquote>
  </body>
</html>

--------------W0kvT0WUxMGmaFts0yMDy34n--


