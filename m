Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 16196C43458
	for <qemu-devel@archiver.kernel.org>; Sat, 11 Jul 2026 10:54:58 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wiVLk-0006M6-Lz; Sat, 11 Jul 2026 06:54:24 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <harshpb@linux.ibm.com>)
 id 1wiVLj-0006Le-5F; Sat, 11 Jul 2026 06:54:23 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <harshpb@linux.ibm.com>)
 id 1wiVLg-0004n2-Nb; Sat, 11 Jul 2026 06:54:22 -0400
Received: from pps.filterd (m0353729.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 66B7C2DE338248; Sat, 11 Jul 2026 10:54:09 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=pp1; bh=1bY6K3
 UqPRO4dAUO+HpvCp1rtWfs40kUevSQqr93Ag4=; b=H4bYNHAxW8wgK5c3hQvVR8
 8UMx5t34qOCVU2zXIyD0+s8jYiDMZVRc/n8KduXgSm/m6Pj2vJd+l/vsA5gHjWlX
 Sofk0mu1OWdA0bkWYMBBbKwD0wx77BeMbUzxDD79JY86EABX/ch1JmKFnjPoPo7R
 ckoEiNEkNLeYn2YKmry0g+UYjqasdLufrwGOdCHSH4eVBrDn1PymBvrFC9EAiASm
 Gqwi84WqL9hwalRLIGADrnALTIaL7iOV6bUaGnjs5XMZ2zgUXlNTW7QSoX9v88/2
 qdOD5RJFT81Auy7cV72krQXtBcIDa7XoWKepBh46jX7tjTQPu2ERhDnWFIiu3bEw
 ==
Received: from ppma12.dal12v.mail.ibm.com
 (dc.9e.1632.ip4.static.sl-reverse.com [50.22.158.220])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4fber80uw3-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Sat, 11 Jul 2026 10:54:08 +0000 (GMT)
Received: from pps.filterd (ppma12.dal12v.mail.ibm.com [127.0.0.1])
 by ppma12.dal12v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 66BAo8NJ014999;
 Sat, 11 Jul 2026 10:54:07 GMT
Received: from smtprelay03.dal12v.mail.ibm.com ([172.16.1.5])
 by ppma12.dal12v.mail.ibm.com (PPS) with ESMTPS id 4f7cgqpap8-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Sat, 11 Jul 2026 10:54:07 +0000 (GMT)
Received: from smtpav04.wdc07v.mail.ibm.com (smtpav04.wdc07v.mail.ibm.com
 [10.39.53.231])
 by smtprelay03.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 66BAs6Rw64684502
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Sat, 11 Jul 2026 10:54:07 GMT
Received: from smtpav04.wdc07v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id BA22E58052;
 Sat, 11 Jul 2026 10:54:06 +0000 (GMT)
Received: from smtpav04.wdc07v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 936AA5805E;
 Sat, 11 Jul 2026 10:54:02 +0000 (GMT)
Received: from [9.124.217.8] (unknown [9.124.217.8])
 by smtpav04.wdc07v.mail.ibm.com (Postfix) with ESMTP;
 Sat, 11 Jul 2026 10:54:02 +0000 (GMT)
Message-ID: <bf1b73da-919c-4b02-8b46-78b939077610@linux.ibm.com>
Date: Sat, 11 Jul 2026 16:24:00 +0530
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 33/51] target/ppc: Simplify
 ppc_cpu_debug_check_watchpoint
Content-Language: en-GB
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org,
 Shivaprasad G Bhat <sbhat@linux.ibm.com>
Cc: qemu-arm@nongnu.org, qemu-ppc@nongnu.org, qemu-riscv@nongnu.org,
 qemu-s390x@nongnu.org, jcmvbkbc@gmail.com,
 =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@kaod.org>
References: <20260710205401.836304-1-richard.henderson@linaro.org>
 <20260710205401.836304-34-richard.henderson@linaro.org>
From: Harsh Prateek Bora <harshpb@linux.ibm.com>
In-Reply-To: <20260710205401.836304-34-richard.henderson@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzExMDEwMyBTYWx0ZWRfXxmWsMFLwdcsX
 uhz3GHAULuMgWSOBO7Au8D/bFxpOSbEpJFTgnzDqTLIwUIQC4wbOI7SvphKl7Uu3egmUVc8Blzj
 Gdugmj4t+J4cgQw4fFZSizW+0qQlGAnCAI2oln7NTEqe0zakdeEdFKcogCwXgeurh4iSqp1FsEk
 NYrs94FLiagHFD02QH/qAJGbJ6ECkOkqOkukv2dLzjcs50ytScxaYk4MgtodMrq5V7NyLj3ATKz
 yeTaxboijTd0s7J0M7oTvJHsWBvRYDkhJ6+OtJZlhglRG1WYru3c2rAydSSxB7KFmvU2TTUu0aM
 Gn1xfUs8N++am9lLdCxE30riB2xLwcfVUc5w1x3qNCjuatx5Y7Vn2m1Ay0RxGhMZBspQspDHUAH
 wBStOFnfSzogeQBMb0uAWLhV8x/l+tb35Rk4M8Qk2gZosdzAoZXA1XEQ+mfuHimA8HYD+auup0u
 dQkHCyYRDnlSl1dDjmg==
X-Proofpoint-ORIG-GUID: iWJg-ygSVRxyX3VOYnyDnMidPbtqxkMb
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzExMDEwMyBTYWx0ZWRfX+GeqnUHqSLse
 6oljsSK4ZnFCXQTzA3rZrQ8lUlI8Y7RPzLZfAEtpoUrLkLp2AMe9259thXoTE/cIfjGGaQ4sl2q
 UW/fPUSDG3ZPSMFlcoDuXjmC4q4gCJk=
X-Authority-Analysis: v=2.4 cv=TpzWQjXh c=1 sm=1 tr=0 ts=6a5220d0 cx=c_pps
 a=bLidbwmWQ0KltjZqbj+ezA==:117 a=bLidbwmWQ0KltjZqbj+ezA==:17
 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10 a=f7IdgyKtn90A:10
 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22 a=uAbxVGIbfxUO_5tXvNgY:22
 a=KKAkSRfTAAAA:8 a=Y4SOClW3IRnDOyVZwr4A:9 a=QEXdDO2ut3YA:10
 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-GUID: devqyiRefFQzmcR5m3z8-QfZgPqT59HE
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-11_02,2026-07-10_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 priorityscore=1501 impostorscore=0 malwarescore=0 bulkscore=0
 lowpriorityscore=0 adultscore=0 spamscore=0 clxscore=1011 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607110103
Received-SPF: pass client-ip=148.163.156.1; envelope-from=harshpb@linux.ibm.com;
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

+ Cedric, Shiva

On 11/07/26 2:23 am, Richard Henderson wrote:
> We don't need to check either ISA bit, because that's already
> done starting with SPR registration.  Replace target_ulong with
> uint64_t, as we're under TARGET_PPC64.
> 
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>   target/ppc/tcg-excp_helper.c | 30 +++++++++---------------------
>   1 file changed, 9 insertions(+), 21 deletions(-)
> 
> diff --git a/target/ppc/tcg-excp_helper.c b/target/ppc/tcg-excp_helper.c
> index 99ffe4a820..4065440949 100644
> --- a/target/ppc/tcg-excp_helper.c
> +++ b/target/ppc/tcg-excp_helper.c
> @@ -353,35 +353,23 @@ bool ppc_cpu_debug_check_watchpoint(CPUState *cs, CPUBreakpoint *wp)
>   {
>   #if defined(TARGET_PPC64)
>       CPUPPCState *env = cpu_env(cs);
> -    bool wt, wti, hv, sv, pr;
> -    uint32_t dawrx;
> +    uint32_t dawrx = env->spr[wp->id ? SPR_DAWRX1 : SPR_DAWRX0];
> +    bool wt = extract32(dawrx, PPC_BIT_NR(59), 1);
> +    bool wti = extract32(dawrx, PPC_BIT_NR(60), 1);
> +    bool hv = extract32(dawrx, PPC_BIT_NR(61), 1);
> +    bool sv = extract32(dawrx, PPC_BIT_NR(62), 1);
> +    bool pr = extract32(dawrx, PPC_BIT_NR(62), 1);
>   
> -    if ((env->insns_flags2 & PPC2_ISA207S) &&
> -        (wp == env->dawr_watchpoint[0])) {
> -        dawrx = env->spr[SPR_DAWRX0];
> -    } else if ((env->insns_flags2 & PPC2_ISA310) &&
> -               (wp == env->dawr_watchpoint[1])) {
> -        dawrx = env->spr[SPR_DAWRX1];
> -    } else {

Previously, there were different ISA version checks resulting in 
different behaviour, now with this change we are allowing for both ISA 
versions. Not sure if this would be an expected behaviour?

Shiva, Could you also please check and confirm?

Also, there seems to be a copy-paste mistake in existing code as 
identified in another thread, may be we can fix along?

bool pr = extract32(dawrx, PPC_BIT_NR(63), 1);

regards,
Harsh
> +    if ((env->msr & (1ull << MSR_PR)) && !pr) {
>           return false;
> -    }
> -
> -    wt = extract32(dawrx, PPC_BIT_NR(59), 1);
> -    wti = extract32(dawrx, PPC_BIT_NR(60), 1);
> -    hv = extract32(dawrx, PPC_BIT_NR(61), 1);
> -    sv = extract32(dawrx, PPC_BIT_NR(62), 1);
> -    pr = extract32(dawrx, PPC_BIT_NR(62), 1);
> -
> -    if ((env->msr & ((target_ulong)1 << MSR_PR)) && !pr) {
> -        return false;
> -    } else if ((env->msr & ((target_ulong)1 << MSR_HV)) && !hv) {
> +    } else if ((env->msr & (1ull << MSR_HV)) && !hv) {
>           return false;
>       } else if (!sv) {
>           return false;
>       }
>   
>       if (!wti) {
> -        if (env->msr & ((target_ulong)1 << MSR_DR)) {
> +        if (env->msr & (1ull << MSR_DR)) {
>               return wt;
>           } else {
>               return !wt;


