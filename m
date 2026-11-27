Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B3BB4606A32A
	for <qemu-devel@archiver.kernel.org>; Fri, 27 Nov 2026 07:59:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=hOwlIkDT
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xWqqR-000448-Kz; Fri, 27 Nov 2026 02:58:11 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <rathc@linux.ibm.com>)
 id 1xWqq6-0003se-EO; Fri, 27 Nov 2026 02:57:50 -0500
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <rathc@linux.ibm.com>)
 id 1xWqq4-000474-Q3; Fri, 27 Nov 2026 02:57:50 -0500
Received: from pps.filterd (m0356516.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 6AR7Yekq2458177; Fri, 27 Nov 2026 07:57:41 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=pp1; bh=chTF8k
 LgdJqxHCG5j0elQLiNDTQHPpBtWYkQHfJ6hlo=; b=hOwlIkDTZlpmGqYdfjVTFc
 c6fK4zQ11P2MmiLbNbizIK7AiSyDNXclRWyUqsdPP/oj1biND7Gv7kscIAxYnZ2E
 RqgzRvVBV9GkVz9kr8YMkt1sS5WHIlxb+7baOpLuASd9qdLHKgW78JawzTMFHjGC
 P5ClFSGc24LL+oieGCzKmHjqK4c1JQO/sUP67veSiU94j4SGAkk6qbXschOzdSOd
 pTvP6PAS4BlVO71SwiQev8EczguLfaSAJF0YR8mJCpKAanXntBIt+HnUG1vJX7i0
 0A4BEY7nMdAKdPBVtPAAIyDaS+3YM+KA4KZAYZr9ts0RpumycVaIY4cRqe2WoBtQ
 ==
Received: from ppma13.dal12v.mail.ibm.com
 (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4j34gvm4vc-1
 (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
 Fri, 27 Nov 2026 07:57:41 +0000 (GMT)
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
 by ppma13.dal12v.mail.ibm.com (8.18.1.11/8.18.1.11) with ESMTP id
 6AR7K20l2385215; Fri, 27 Nov 2026 07:57:40 GMT
Received: from smtprelay03.wdc07v.mail.ibm.com ([172.16.1.70])
 by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 4j5kfa9dmf-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Fri, 27 Nov 2026 07:57:40 +0000 (GMT)
Received: from smtpav02.dal12v.mail.ibm.com (smtpav02.dal12v.mail.ibm.com
 [10.241.53.101])
 by smtprelay03.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 6AR7ukkb17302078
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Fri, 27 Nov 2026 07:56:47 GMT
Received: from smtpav02.dal12v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 64B1B5805C;
 Fri, 27 Nov 2026 07:57:38 +0000 (GMT)
Received: from smtpav02.dal12v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 1A9A258051;
 Fri, 27 Nov 2026 07:57:34 +0000 (GMT)
Received: from [9.111.0.137] (unknown [9.111.0.137])
 by smtpav02.dal12v.mail.ibm.com (Postfix) with ESMTP;
 Fri, 27 Nov 2026 07:57:33 +0000 (GMT)
Message-ID: <60270254-3b7e-4d83-8549-7b8f64845adf@linux.ibm.com>
Date: Fri, 27 Nov 2026 13:27:32 +0530
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 15/24] target/ppc: Use 64-bit TB flags
To: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>,
 qemu-devel@nongnu.org
Cc: Richard Henderson <richard.henderson@linaro.org>, qemu-riscv@nongnu.org,
 qemu-s390x@nongnu.org, qemu-arm@nongnu.org, qemu-ppc@nongnu.org,
 Anton Johansson <anjo@rev.ng>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 Nicholas Piggin <npiggin@gmail.com>, Glenn Miles <milesg@linux.ibm.com>,
 Harsh Prateek Bora <harshpb@linux.ibm.com>
References: <20261126233604.67722-1-philmd@oss.qualcomm.com>
 <20261126233604.67722-16-philmd@oss.qualcomm.com>
Content-Language: en-US
From: Chinmay Rath <rathc@linux.ibm.com>
In-Reply-To: <20261126233604.67722-16-philmd@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Authority-Analysis: v=2.4 cv=CYCdd7rl c=1 sm=1 tr=0 ts=6b0937f5 cx=c_pps
 a=AfN7/Ok6k8XGzOShvHwTGQ==:117 a=AfN7/Ok6k8XGzOShvHwTGQ==:17
 a=IkcTkHD0fZMA:10 a=zJRp6_cAMcgA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=Y2IxJ9c9Rs8Kov3niI8_:22 a=EUspDBNiAAAA:8
 a=VnNF1IyMAAAA:8 a=g5kLG7U5x2I9u7WagioA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTI3MDAzMCBTYWx0ZWRfX7NoTpgTb4MFp
 YBB8GAe5YMwNPzCLt5uowWRcxEVOJDpsGaT/R4KzRHAa1AoeMiWuNmNyLMA/m4CLmr79GuM9ItD
 S7W1ZVxXksDkceeOA/wsIHV0AIbbDpE=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTI3MDAzMCBTYWx0ZWRfX2H2fHjwSsceI
 Pq1O+PQsV98vJt2WudkgtSOKfaSAAjb2IajRgtHzbSyWLZf1i+cJb09qwM9HpP0iVf/jKORvEeM
 p6kiqEWD153V7SXkZpV7UVsEgcgPV7HS2gGaUAxkxXkPYG6E9VttlQMYcImsuOXlzU/B6wqmnw/
 GpHGofCWEXy5a97H06+QA6ygb05Mr2g93zdYCmNdWYO3ZQDRLJhnsm7mvlCMIWiL2NbM2oZlqPa
 CAgrBOo2OyTu2LA6Sf0gvXm4TYReG1HI+tL5RY9HzLqTzgIBw6IU1S21COOJRtPH6S+SULDLRN+
 4fNsiGUtM90mSgrff+xU1v1MS3Uv60d7b9SCKdkThih6FoaN3ozNrvD6qQ5TR2CEa0XsUpk775g
 hybCbq5TQeA9qre6+XhGhG++t3yxJlE0HXeszwCHkJjV7346dGC+jgLIM4UfK0n0Wg0C6F0BjT7
 GbacEPLUUyOPJTvR+lw==
X-Proofpoint-ORIG-GUID: omwIiMNtYamDerThTfKL_Ol42WerOnVY
X-Proofpoint-GUID: qUa1LPpo45OCo4LMTfdua5pcPNFB0ZzD
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-27_01,2026-11-26_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 malwarescore=0 priorityscore=1501 lowpriorityscore=0
 clxscore=1011 spamscore=0 bulkscore=0 impostorscore=0 adultscore=0
 suspectscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2611040001
 definitions=main-2611270030
Received-SPF: pass client-ip=148.163.158.5; envelope-from=rathc@linux.ibm.com;
 helo=mx0b-001b2d01.pphosted.com
X-Spam_score_int: -26
X-Spam_score: -2.7
X-Spam_bar: --
X-Spam_report: (-2.7 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, RCVD_IN_DNSWL_LOW=-0.7,
 RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
X-Spam-Status: No, score=-15.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1


On 11/27/26 05:05, Philippe Mathieu-Daudé wrote:
> TranslationBlock::flags and TCGTBCPUState::flags are now
> 64-bit, use matching types for the values derived from them.
>
> Signed-off-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>
Hi Philippe,
Few months back I was wondering why cs_base was used as an extension 
instead of extending flags to 64 bits. With this series, now I 
understand that it was to support 32 bit hosts. Thanks for that!

I was wondering if PPC env's internal hflags should also be extended to 
64 bits with this, but I guess that can wait for when we actually have 
more than 32 bits needed there.
With that,

Reviewed-by: Chinmay Rath <rathc@linux.ibm.com>
> ---
>   target/ppc/translate.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/target/ppc/translate.c b/target/ppc/translate.c
> index dccae25bb4ec..e7bb0e4d4667 100644
> --- a/target/ppc/translate.c
> +++ b/target/ppc/translate.c
> @@ -4996,7 +4996,7 @@ static void ppc_tr_init_disas_context(DisasContextBase *dcbase, CPUState *cs)
>   {
>       DisasContext *ctx = container_of(dcbase, DisasContext, base);
>       CPUPPCState *env = cpu_env(cs);
> -    uint32_t hflags = ctx->base.tb->flags;
> +    uint64_t hflags = ctx->base.tb->flags;
>   
>       ctx->spr_cb = env->spr_cb;
>       ctx->pr = (hflags >> HFLAGS_PR) & 1;

