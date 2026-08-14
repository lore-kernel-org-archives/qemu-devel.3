Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 481D2C5B572
	for <qemu-devel@archiver.kernel.org>; Fri, 14 Aug 2026 08:30:24 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wunIR-0004QJ-68; Fri, 14 Aug 2026 04:29:47 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <rathc@linux.ibm.com>)
 id 1wunIO-0004PZ-V7; Fri, 14 Aug 2026 04:29:44 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <rathc@linux.ibm.com>)
 id 1wunIN-0000Yc-6J; Fri, 14 Aug 2026 04:29:44 -0400
Received: from pps.filterd (m0360083.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 67E81UUM533064; Fri, 14 Aug 2026 08:29:33 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=pp1; bh=wGclLx
 NLR81W/GFe44T9ZvOwhrQVejY809r+cJxNaLI=; b=K56LX9iZRcuinTkmxuMbjg
 xGrJQjpmKB/UZSLcuFkY/ckJYb1UfhgXw+7gkL1uU/t0NFLG0uQJIv4hhBAqHpfP
 1rpyHFiSN3RvxaT3IVKHo3jvxF0rHUaWNaWOHZwtMavtp2XI3pRXuPfqBayT8w2S
 cuHtc4TEWYCa542t8YZ9tUbFAeyDynq7QgtMNF6sIOIPjmQByggd/SI5xyR6CTUI
 mq5IUbikvA5/mdb0fDNRcMbbvP4yiE+10MMexQ8Q/inZpSB4WiGsA1TB/quKEa7L
 kFa3upKSq1mCrqunq13DRgNbk02FH6zMgXAMTDtAfx7J4ksU0BQ8ZlSTakHB7t9Q
 ==
Received: from ppma11.dal12v.mail.ibm.com
 (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4fwvq9uw2q-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Fri, 14 Aug 2026 08:29:32 +0000 (GMT)
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
 by ppma11.dal12v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 67E8QJqh018847;
 Fri, 14 Aug 2026 08:29:31 GMT
Received: from smtprelay07.wdc07v.mail.ibm.com ([172.16.1.74])
 by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 4g1rpv9a0b-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Fri, 14 Aug 2026 08:29:31 +0000 (GMT)
Received: from smtpav02.wdc07v.mail.ibm.com (smtpav02.wdc07v.mail.ibm.com
 [10.39.53.229])
 by smtprelay07.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 67E8TUb414746142
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Fri, 14 Aug 2026 08:29:30 GMT
Received: from smtpav02.wdc07v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 2848358058;
 Fri, 14 Aug 2026 08:29:30 +0000 (GMT)
Received: from smtpav02.wdc07v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 2549C58059;
 Fri, 14 Aug 2026 08:29:25 +0000 (GMT)
Received: from [9.124.210.243] (unknown [9.124.210.243])
 by smtpav02.wdc07v.mail.ibm.com (Postfix) with ESMTP;
 Fri, 14 Aug 2026 08:29:24 +0000 (GMT)
Message-ID: <7008e3bc-bc35-49b9-88d8-755217563e88@linux.ibm.com>
Date: Fri, 14 Aug 2026 13:59:22 +0530
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] target/ppc: Validate HTABMASK and reserved bits in SDR1
 for 32-bit mode
To: sesame_h@qq.com, qemu-devel@nongnu.org, qemu-ppc@nongnu.org
Cc: npiggin@gmail.com, adityag@linux.ibm.com, milesg@linux.vnet.ibm.com,
 harshpb@linux.ibm.com, Minhang Zhang <zhangminhang@kylinos.cn>,
 ritesh.list@gmail.com, dhruvb@linux.ibm.com
References: <8611cad6-bfc9-4d3d-9fe2-322fdb34e1ca@linux.ibm.com>
 <tencent_1240029E1F2CBA785372451BC8D2A7869409@qq.com>
Content-Language: en-US
From: Chinmay Rath <rathc@linux.ibm.com>
In-Reply-To: <tencent_1240029E1F2CBA785372451BC8D2A7869409@qq.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Proofpoint-GUID: tt_u-c6QVH9UF9xh3HqT86btMdeLYARx
X-Authority-Analysis: v=2.4 cv=PbDPQChd c=1 sm=1 tr=0 ts=6a7ed1ed cx=c_pps
 a=aDMHemPKRhS1OARIsFnwRA==:117 a=aDMHemPKRhS1OARIsFnwRA==:17
 a=IkcTkHD0fZMA:10 a=Sv0fKeRqtYgA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=iQ6ETzBq9ecOQQE5vZCe:22 a=NLiCwHATAAAA:8
 a=dZbOZ2KzAAAA:8 a=SyfNM_HIZ7VAkFkMWyMA:9 a=QEXdDO2ut3YA:10
 a=F9tHCgz3TLBaZgltkx5D:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODE0MDA2MSBTYWx0ZWRfXxZI47sFnW45U
 +efrQdIhqsQRwRQnci7eIEki9Bc1iwmC873yYTHSUchA6VgTSFO5y3+2X+6SyXQsRalZNUZ2QWx
 2YOIn3ziNMXWzqbDfFSg4gd+D87J03lkfIK1uujeRq/oenKJLEPwEEB5gAETdq1wQCP12OK4DYh
 1eu1a9F6lLnplFjuASDEkDCx66h79S/csCJv+euGApOY9Q+qimoiAi7ErnThLun7eOLsnPd9LRl
 3xXZ1ouX2mHImK4aZQHqBQru0JGO00rC8cmEks+c22ahJ9hKYUc1VxjvjT/LOpDzGA1MRMh1gT5
 3pBXDQ0tqzWVMwt+l/57OTJ8dozYEZX2ZiexHp6IzVxBYu/zd8nkfhbbsNpM9/QC0CVvZpeSgog
 paG6y4iTLQk+3efbCmTxQwckbGN66R/rtoTaG4vqUOoiYVG4RmdZwuyi7qf1HhCB8p/utDd71AT
 gGfp4vYUj3WFkHERTfw==
X-Proofpoint-ORIG-GUID: 6MhwIGmZSZJtZ_Dc6WRpduMk39XTpdFu
X-Proofpoint-Spam-Info: AW1haW4tMjYwODE0MDA2MSBTYWx0ZWRfX83RMCgtyT4Du
 I0bWCRkatsUMZKUH+7NA2tFV4Hz/dtF9UVIB+RkePAbhZaJxZOkaeRjriflwfpAA3FuFPW69lC2
 1iEyByFJtamtF1g1JOaykFHm/gQUxHw=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-14_03,2026-08-12_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 bulkscore=0 impostorscore=0 malwarescore=0 adultscore=0
 clxscore=1015 priorityscore=1501 suspectscore=0 phishscore=0
 lowpriorityscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2608140061
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


On 8/14/26 08:36, sesame_h@qq.com wrote:
> From: Minhang Zhang <zhangminhang@kylinos.cn>
>
> ppc_store_sdr1() had validation for 64-bit SDR1 values but lacked
> corresponding checks for the 32-bit case.  According to the Power ISA,
> in 32-bit mode SDR1 bits 16-22 are reserved (must be zero) and
> HTABMASK (bits 23-31) must consist of a consecutive string of
> 1-bits starting from the LSB, i.e., be of the form 2^n-1.
>
> Add checks to reject invalid HTABMASK values and log a guest error
> for non-zero reserved bits, following the same pattern used by the
> existing 64-bit validation.
>
> Signed-off-by: Minhang Zhang <zhangminhang@kylinos.cn>
>
> Hi Chinmay,
>
> Thanks a lot for your careful review and pointing out these issues.
>
> You are absolutely right, I messed up the reserved-bits mask. I misread
> the Power ISA bit numbering: the correct reserved-bits mask should be
> 0x0000FE00, not 0x007F0000.
>
> I also agree with your suggestion to avoid hard-coded magic numbers, so
> I constructed the mask using the existing SDR_32_HTABORG and
> SDR_32_HTABMASK macros from mmu-hash32.h, following the same pattern as
> the 64-bit implementation in ppc_store_sdr1().
>
> Both issues are fixed in the v2 patch below.
Hi Minhang,
Thanks for the v2. Could you please send this as a separate patch in the 
list rather than as a reply to this thread ? This will help the 
maintainer pull in the patch easily :)
Plus I had a nit below, sorry I didn't notice it in the v1 :
>
> Regards,
> Minhang Zhang
> ---
>   target/ppc/mmu_common.c | 20 ++++++++++++++++++--
>   1 file changed, 18 insertions(+), 2 deletions(-)
>
> diff --git a/target/ppc/mmu_common.c b/target/ppc/mmu_common.c
> index 2499e61..31a221d 100644
> --- a/target/ppc/mmu_common.c
> +++ b/target/ppc/mmu_common.c
> @@ -57,9 +57,25 @@ void ppc_store_sdr1(CPUPPCState *env, target_ulong value)
>                        " stored in SDR1", htabsize);
>               return;
>           }
> -    }
> +    } else
>   #endif /* defined(TARGET_PPC64) */
> -    /* FIXME: Should check for valid HTABMASK values in 32-bit case */
> +    {
Qemu coding style 
(https://qemu-project.gitlab.io/qemu/devel/style.html#block-structure) ,
discourages having '{' in the next line after the else.
If you could fix that by using #elif instead of #endif here or keeping 
the entire #if defined(TARGET_PPC64)..#endif within the if 
(mmu_is_64bit(env->mmu_model)) block, that'd be great.

Regards,
Chinmay
> +        target_ulong sdr_mask = SDR_32_HTABORG | SDR_32_HTABMASK;
> +        target_ulong htabmask = value & SDR_32_HTABMASK;
> +
> +        if (value & ~sdr_mask) {
> +            qemu_log_mask(LOG_GUEST_ERROR,
> +                          "Invalid bits 0x" TARGET_FMT_lx
> +                          " set in SDR1\n", value & ~sdr_mask);
> +            value &= sdr_mask;
> +        }
> +        if ((htabmask & (htabmask + 1)) != 0) {
> +            qemu_log_mask(LOG_GUEST_ERROR,
> +                          "Invalid HTABMASK 0x" TARGET_FMT_lx
> +                          " in SDR1 (must be of form 2^n-1)\n", htabmask);
> +            return;
> +        }
> +    }
>       env->spr[SPR_SDR1] = value;
>   }
>   

