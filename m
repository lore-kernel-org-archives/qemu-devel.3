Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 62AB1606A31C
	for <qemu-devel@archiver.kernel.org>; Wed, 18 Nov 2026 11:29:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=Hb7gZaYJ
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xTdqO-0001a0-9I; Wed, 18 Nov 2026 06:28:52 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <rathc@linux.ibm.com>)
 id 1xTdqM-0001Zm-41; Wed, 18 Nov 2026 06:28:50 -0500
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <rathc@linux.ibm.com>)
 id 1xTdqK-0000xF-Aj; Wed, 18 Nov 2026 06:28:49 -0500
Received: from pps.filterd (m0353729.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 6AIBQgu53533235; Wed, 18 Nov 2026 11:28:45 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=pp1; bh=ObSQQ5
 oZhwpykEt9eODJgLd347hczCFEemRSdNKjH3E=; b=Hb7gZaYJf7GPSQwkbmaoy3
 Yjt8BEF2vIKNCztgnrBenvS62APrz/VT80cv0UC8A9pE/b2Hz2sAFlZYHXlBCOUF
 EHn14BoSUMS+CUsFqQz0dFOf7r2bDZTUzXKOkFG1MCq4RYdjLOVzpMMBzHJGL6ml
 Zx5MdX0KOX8H9DHca8Co97FwB7bb3Z4a3+fG+oWtpuA3K0cMW6DtpUPtuE6njHvR
 VIZCdHfoKKm9LHVHHjLwsbHNaFFJjXOrzr7jwTHq6o5AQxfpHh60u8U5AUT4aCkb
 mwIfCa42A10k1UxZ/7msoVFRBNtIFu6Khn3FyUL8W6oW+q3SIp+721fy3AT//5cA
 ==
Received: from ppma21.wdc07v.mail.ibm.com
 (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4j105rj59k-1
 (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
 Wed, 18 Nov 2026 11:28:44 +0000 (GMT)
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
 by ppma21.wdc07v.mail.ibm.com (8.18.1.11/8.18.1.11) with ESMTP id
 6AIBJtPm3324490; Wed, 18 Nov 2026 11:28:44 GMT
Received: from smtprelay02.dal12v.mail.ibm.com ([172.16.1.4])
 by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4hyxwt87gb-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Wed, 18 Nov 2026 11:28:44 +0000 (GMT)
Received: from smtpav05.dal12v.mail.ibm.com (smtpav05.dal12v.mail.ibm.com
 [10.241.53.104])
 by smtprelay02.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 6AIBSghO26280536
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Wed, 18 Nov 2026 11:28:42 GMT
Received: from smtpav05.dal12v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id BAB7A58068;
 Wed, 18 Nov 2026 11:28:42 +0000 (GMT)
Received: from smtpav05.dal12v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id EB13D58065;
 Wed, 18 Nov 2026 11:28:39 +0000 (GMT)
Received: from [9.111.1.121] (unknown [9.111.1.121])
 by smtpav05.dal12v.mail.ibm.com (Postfix) with ESMTP;
 Wed, 18 Nov 2026 11:28:39 +0000 (GMT)
Message-ID: <97ba694e-756a-4e6f-93d4-85fb316149d5@linux.ibm.com>
Date: Wed, 18 Nov 2026 16:58:38 +0530
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] target/ppc: Test CF_NO_GOTO_PTR in cflags, not in TB flags
To: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>,
 qemu-devel@nongnu.org
Cc: qemu-ppc@nongnu.org, Glenn Miles <milesg@linux.ibm.com>,
 Harsh Prateek Bora <harshpb@linux.ibm.com>, mattst88@gmail.com,
 Anton Johansson <anjo@rev.ng>,
 Richard Henderson <richard.henderson@linaro.org>
References: <20261117080843.8314-1-philmd@oss.qualcomm.com>
Content-Language: en-US
From: Chinmay Rath <rathc@linux.ibm.com>
In-Reply-To: <20261117080843.8314-1-philmd@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Proofpoint-GUID: dNl5opanVHY2Zi-D2oijcA6Aoo6BQXD6
X-Authority-Analysis: v=2.4 cv=e8uT2qp/ c=1 sm=1 tr=0 ts=6afd8bed cx=c_pps
 a=GFwsV6G8L6GxiO2Y/PsHdQ==:117 a=GFwsV6G8L6GxiO2Y/PsHdQ==:17
 a=IkcTkHD0fZMA:10 a=zJRp6_cAMcgA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=uAbxVGIbfxUO_5tXvNgY:22 a=VwQbUJbxAAAA:8
 a=KKAkSRfTAAAA:8 a=EUspDBNiAAAA:8 a=JsepMA0FrfH1NqDOvd8A:9 a=3ZKOabzyN94A:10
 a=QEXdDO2ut3YA:10 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTE4MDA0NSBTYWx0ZWRfX9WqfUOnoFr8e
 rqz5PXdt97RdMpW3c7HOEg6PXSmSvbgjyMM9/CsOqscQHdSSjUdVQmrBNMLbN8BOr9L1JbZMt4n
 HOFHI90cecuh1HL5whGY5sGS1CRBN98=
X-Proofpoint-ORIG-GUID: ZTyl_qQVPIDNLeSgD0yfsB8UrwPbPaGH
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTE4MDA0NSBTYWx0ZWRfX5Okr8UNswPn+
 QemerupQ80bXVbuxAHGWn/Kp/yhh0QHMqLySc1V35bLGWRbIKsxuH+ebYdKRMiHI7MoHPYpO1w1
 rPtqjmq+u58vg+zMyIsj7vCqFEd0Yx9ZptZJ+GaEWUHkp+usr7NdXnoES9JHrZzFchnKrWpjTYb
 d/XYNrD/iTzST/UhwLELEvjYm/gK0yQkjmzD64k6Dho3OoaG0Jg+88Pv0aX9rc42srbua4EqAIr
 GIsudNbn/WJO9Kgyp9l6gwW6BQPIh/pDVdraQSC5rXPUDW57cmTLWOoC7fxZvI4f1/etLrLKMq9
 A+wjhV/cJtEaDb0jJJsW1kwY9ml8SpImPCLJGzuBRQTG9ngSGBnCVK7j7L890np7Fh7dflwyBFW
 QRUPl8LWl5JQ73wzdLsN2y0MM3jk5jXBJg7FvFHNwrP0UxC86OyuOmOLW2IblKgII9CIqqzda0c
 /mCta/wmcreCiAhDqhg==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-18_03,2026-11-16_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1011 priorityscore=1501 suspectscore=0 phishscore=0
 lowpriorityscore=0 adultscore=0 spamscore=0 bulkscore=0 malwarescore=0
 impostorscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2611040001
 definitions=main-2611180045
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
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
X-Spam-Status: No, score=-15.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1


On 11/17/26 13:38, Philippe Mathieu-Daudé wrote:
> CF_NO_GOTO_PTR is a TB cflags bit, but it was tested against
> tb->flags, where bit 10 is HFLAGS_SE. Use tb_cflags().
>
> Fixes: 46d396bde988 ("target/ppc: enable PMU instruction count")
> Signed-off-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>
> ---
>   target/ppc/translate.c | 4 ++--
>   1 file changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/target/ppc/translate.c b/target/ppc/translate.c
> index 467b8f3d4ec2..dccae25bb4ec 100644
> --- a/target/ppc/translate.c
> +++ b/target/ppc/translate.c
> @@ -2645,7 +2645,7 @@ static void gen_lookup_and_goto_ptr(DisasContext *ctx)
>            * tcg_gen_lookup_and_goto_ptr will exit the TB if
>            * CF_NO_GOTO_PTR is set. Count insns now.
>            */
> -        if (ctx->base.tb->flags & CF_NO_GOTO_PTR) {
> +        if (tb_cflags(ctx->base.tb) & CF_NO_GOTO_PTR) {
>               pmu_count_insns(ctx);
>           }
>   
> @@ -5160,7 +5160,7 @@ static void ppc_tr_tb_stop(DisasContextBase *dcbase, CPUState *cs)
>            * tcg_gen_lookup_and_goto_ptr will exit the TB if
>            * CF_NO_GOTO_PTR is set. Count insns now.
>            */
> -        if (ctx->base.tb->flags & CF_NO_GOTO_PTR) {
> +        if (tb_cflags(ctx->base.tb) & CF_NO_GOTO_PTR) {
>               pmu_count_insns(ctx);
>           }
Hi Philippe,
Thanks for addressing the review comments brought up by Anton and Matt 
on the original patch :
https://lore.kernel.org/qemu-devel/20261104163854.87398-1-richard.henderson@linaro.org/

I think it'd be correct to include the original "Reported-by" and 
"Reviewed-by"s from the above mentioned patch as well.

+cc : Matt and Anton

Regards,
Chinmay
>   

