Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7C620C43458
	for <qemu-devel@archiver.kernel.org>; Tue,  7 Jul 2026 04:57:56 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wgxsQ-0005GI-Dw; Tue, 07 Jul 2026 00:57:46 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <nikhilks@linux.ibm.com>)
 id 1wgxsO-0005Fe-G0; Tue, 07 Jul 2026 00:57:44 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <nikhilks@linux.ibm.com>)
 id 1wgxsM-000091-NX; Tue, 07 Jul 2026 00:57:44 -0400
Received: from pps.filterd (m0356517.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 6674IKsT2286263; Tue, 7 Jul 2026 04:57:39 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=pp1; bh=vxHBG6
 sphuUQErzN28fUfuIYnkA+EnZqxmrpR8U6hYg=; b=cW97+SsQfhFKanJaQ7L44Z
 Sd0sE5S44oZ8OaLv9dd6HVbkSFg2lQlXrkfO0Mjb1d5M0Z3BUg7no8Njg9K39SWO
 Mkt7U/lK7lZQ40lwjpKjm/mxiqVBFRhzIbFJRfzchQVKFJ2e2UbKQVMR+PENvtVw
 js1xDjF61EYyT1CgdQ78TFadC2sRM001tCMQ8SHwOyWtqpqNFi9oO/VlizNXMJk/
 RepBMJ4pvS8cUzCFasobRTENuqStK105QfhgM+yFFFQ4CTYkuXNr9RvaOirx6FqA
 3jGYsvROhzdbdJr1qNFz/Kr3DSDFRbcxxnzX4Ri/l4BtZXHHR+LPiqH1o8wAc+gA
 ==
Received: from ppma12.dal12v.mail.ibm.com
 (dc.9e.1632.ip4.static.sl-reverse.com [50.22.158.220])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4f6sw4n476-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 07 Jul 2026 04:57:38 +0000 (GMT)
Received: from pps.filterd (ppma12.dal12v.mail.ibm.com [127.0.0.1])
 by ppma12.dal12v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 6674nbd9022729;
 Tue, 7 Jul 2026 04:57:37 GMT
Received: from smtprelay07.fra02v.mail.ibm.com ([9.218.2.229])
 by ppma12.dal12v.mail.ibm.com (PPS) with ESMTPS id 4f7cgq1556-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 07 Jul 2026 04:57:37 +0000 (GMT)
Received: from smtpav06.fra02v.mail.ibm.com (smtpav06.fra02v.mail.ibm.com
 [10.20.54.105])
 by smtprelay07.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 6674vYCk44695924
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Tue, 7 Jul 2026 04:57:34 GMT
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 27E9020049;
 Tue,  7 Jul 2026 04:57:34 +0000 (GMT)
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id D809920040;
 Tue,  7 Jul 2026 04:57:25 +0000 (GMT)
Received: from [9.67.174.189] (unknown [9.67.174.189])
 by smtpav06.fra02v.mail.ibm.com (Postfix) with ESMTP;
 Tue,  7 Jul 2026 04:57:25 +0000 (GMT)
Message-ID: <5113c50d-91b1-4fe7-ba71-6771a0303781@linux.ibm.com>
Date: Tue, 7 Jul 2026 10:27:23 +0530
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH 13/28] target/ppc: Move isync instruction to
 decodetree.
To: Chinmay Rath <rathc@linux.ibm.com>, qemu-devel@nongnu.org,
 qemu-ppc@nongnu.org, npiggin@gmail.com, harshpb@linux.ibm.com,
 richard.henderson@linaro.org, peter.maydell@linaro.org, stefanha@redhat.com
Cc: milesg@linux.ibm.com, vishalc@linux.ibm.com, tshah@linux.ibm.com,
 shivangu@linux.ibm.com, ojaswin@linux.ibm.com, aboorvad@linux.ibm.com,
 amachhiw@linux.ibm.com, sv@linux.ibm.com, shivani@linux.ibm.com,
 mkchauras@gmail.com, uverma@linux.ibm.com
References: <20260520160728.2283628-1-rathc@linux.ibm.com>
 <20260520160728.2283628-14-rathc@linux.ibm.com>
Content-Language: en-US
From: Nikhil Kumar Singh <nikhilks@linux.ibm.com>
In-Reply-To: <20260520160728.2283628-14-rathc@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Proofpoint-GUID: S7csifuL8yDcaeGHlGQKzUXxbjj1PmiU
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzA3MDA0MyBTYWx0ZWRfX3OzHXojzXuKe
 drkeN8Kg6l3Uu2GNtTCEJz+QRwEdZReiWNgCsozGeaJxIzthKmhNR+u91Ai3H5L77OIz/14ZXHa
 ZYMT9qaxwXD6P5H9xtX6oD5wWlPQjS9M4r1CQMjz8TQI6/fE6aneBWe0djr+WPjHR7kU57dKr5u
 1cuGVjmQ8rMUKvc5uWSGDDLfmpEtcViS26Ps4nMsoHeoFT9NzLUMje7wU+e9/4XzyDdJZqpX9BO
 IlyJqCAsHC34WOXCmBoykKKW331OqavQkr2Imbzz553uAzKd3bBUL1ejF5idL4R71dHI5Foa7j8
 EBMASs4hFOI4NFIt1Pl7Hgn49Jd21IxY7GhsuVP5TGaRtocZgoQ+e4ZwYLo4mMBzf7lgDutzOIJ
 vxehJdOaVSZxYDKBGr3UYqc+8CgJRHWKa4v4f/jcowdJuolrFZ8R7fOJ7Bt4eIqo2UiGlgjoVSN
 9MKCJhFhk4avDFpkkRw==
X-Proofpoint-ORIG-GUID: CUjMbgdiGnUE1eUOqOZ_sHGlWlbVRgB5
X-Authority-Analysis: v=2.4 cv=FqQ1OWrq c=1 sm=1 tr=0 ts=6a4c8743 cx=c_pps
 a=bLidbwmWQ0KltjZqbj+ezA==:117 a=bLidbwmWQ0KltjZqbj+ezA==:17
 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=U7nrCbtTmkRpXpFmAIza:22 a=VnNF1IyMAAAA:8
 a=gIVu_BG64Y15aQVwIEYA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzA3MDA0MyBTYWx0ZWRfX+8kKByVPO3mL
 qFz/BrqyqsfIdNRsSF3UqAq7+yqWh3De4dFCvhkt/7QuVlGLGw9GDGKNyise9Pq0B4HuR71iaO7
 sTN/1x1utS58y9wkRxxErpWmptQhEQs=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-07_01,2026-07-06_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 impostorscore=0 clxscore=1015 malwarescore=0 lowpriorityscore=0
 priorityscore=1501 bulkscore=0 suspectscore=0 spamscore=0 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607070043
Received-SPF: pass client-ip=148.163.156.1;
 envelope-from=nikhilks@linux.ibm.com; helo=mx0a-001b2d01.pphosted.com
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

Reviewed-by: Nikhil Kumar Singh <nikhilks@linux.ibm.com>

Thanks,
~ Nikhil

On 20/05/26 21:37, Chinmay Rath wrote:
> From: Ojaswin Mujoo <ojaswin@linux.ibm.com>
>
> Moving the following instructions to decodetree specification :
> isync
>
> The changes were verified by validating that the tcg ops generated by
> those instructions remain the same, which were captured with the '-d
> in_asm,op' flag.
>
> Signed-off-by: Ojaswin Mujoo <ojaswin@linux.ibm.com>
> Signed-off-by: Chinmay Rath <rathc@linux.ibm.com>
> ---
>   target/ppc/insn32.decode                     |  1 +
>   target/ppc/translate.c                       | 15 ---------------
>   target/ppc/translate/storage-ctrl-impl.c.inc | 17 +++++++++++++++++
>   3 files changed, 18 insertions(+), 15 deletions(-)
>
> diff --git a/target/ppc/insn32.decode b/target/ppc/insn32.decode
> index f35f7113a0..cbb7a2ed51 100644
> --- a/target/ppc/insn32.decode
> +++ b/target/ppc/insn32.decode
> @@ -1462,6 +1462,7 @@ MSGSYNC         011111 ----- ----- ----- 1101110110 -
>   @X_sync         ...... .. l:3 ... sc:2 ..... .......... .           &X_sync
>   SYNC            011111 -- ... --- ..   ----- 1001010110 -           @X_sync
>   EIEIO           011111 ----- ----- ----- 1101010110 -
> +ISYNC           010011 ----- ----- ----- 0010010110 -
>   
>   # Condition Register Field Instruction
>   
> diff --git a/target/ppc/translate.c b/target/ppc/translate.c
> index 2345bf8867..770f52e7d4 100644
> --- a/target/ppc/translate.c
> +++ b/target/ppc/translate.c
> @@ -2727,20 +2727,6 @@ static inline void gen_check_tlb_flush(DisasContext *ctx, bool global)
>   static inline void gen_check_tlb_flush(DisasContext *ctx, bool global) { }
>   #endif
>   
> -/* isync */
> -static void gen_isync(DisasContext *ctx)
> -{
> -    /*
> -     * We need to check for a pending TLB flush. This can only happen in
> -     * kernel mode however so check MSR_PR
> -     */
> -    if (!ctx->pr) {
> -        gen_check_tlb_flush(ctx, false);
> -    }
> -    tcg_gen_mb(TCG_MO_ALL | TCG_BAR_SC);
> -    ctx->base.is_jmp = DISAS_EXIT_UPDATE;
> -}
> -
>   /* wait */
>   static void gen_wait(DisasContext *ctx)
>   {
> @@ -5401,7 +5387,6 @@ GEN_HANDLER(lswi, 0x1F, 0x15, 0x12, 0x00000001, PPC_STRING),
>   GEN_HANDLER(lswx, 0x1F, 0x15, 0x10, 0x00000001, PPC_STRING),
>   GEN_HANDLER(stswi, 0x1F, 0x15, 0x16, 0x00000001, PPC_STRING),
>   GEN_HANDLER(stswx, 0x1F, 0x15, 0x14, 0x00000001, PPC_STRING),
> -GEN_HANDLER(isync, 0x13, 0x16, 0x04, 0x03FFF801, PPC_MEM),
>   /* ISA v3.0 changed the extended opcode from 62 to 30 */
>   GEN_HANDLER(wait, 0x1F, 0x1E, 0x01, 0x039FF801, PPC_WAIT),
>   GEN_HANDLER_E(wait, 0x1F, 0x1E, 0x00, 0x039CF801, PPC_NONE, PPC2_ISA300),
> diff --git a/target/ppc/translate/storage-ctrl-impl.c.inc b/target/ppc/translate/storage-ctrl-impl.c.inc
> index b8b4454663..943229c438 100644
> --- a/target/ppc/translate/storage-ctrl-impl.c.inc
> +++ b/target/ppc/translate/storage-ctrl-impl.c.inc
> @@ -155,6 +155,23 @@ static bool trans_SLBFEE(DisasContext *ctx, arg_SLBFEE *a)
>       return true;
>   }
>   
> +static bool trans_ISYNC(DisasContext *ctx, arg_ISYNC *a)
> +{
> +    REQUIRE_INSNS_FLAGS(ctx, MEM);
> +
> +    /*
> +     * We need to check for a pending TLB flush. This can only happen in
> +     * kernel mode however so check MSR_PR
> +     */
> +    if (!ctx->pr) {
> +        gen_check_tlb_flush(ctx, false);
> +    }
> +    tcg_gen_mb(TCG_MO_ALL | TCG_BAR_SC);
> +    ctx->base.is_jmp = DISAS_EXIT_UPDATE;
> +
> +    return true;
> +}
> +
>   static bool trans_SLBSYNC(DisasContext *ctx, arg_SLBSYNC *a)
>   {
>       REQUIRE_64BIT(ctx);

