Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8AF15CD3445
	for <qemu-devel@archiver.kernel.org>; Fri,  8 May 2026 15:38:30 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wLNH5-0006l9-81; Fri, 08 May 2026 11:37:59 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <adityag@linux.ibm.com>)
 id 1wLNH4-0006kw-6V; Fri, 08 May 2026 11:37:58 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <adityag@linux.ibm.com>)
 id 1wLNH2-0001jE-2S; Fri, 08 May 2026 11:37:57 -0400
Received: from pps.filterd (m0353725.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 648FMtRi3674687; Fri, 8 May 2026 15:37:53 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=pp1; bh=E/LsO/
 j5z3kaTTMG8vU4fuL0uZclJvuJTi/KFt80g+E=; b=GhlowSEOjqu+cTNrOkfKhz
 XpxixqhSY40qWhJD6xnyzBGBGYoCoATlEvwqRTDW0B8J/Il3CXxuUUeVPQGsHebx
 OrleYTgkFID2Sb2EJ2xHH7F1VJLb/XFgweTt/ZSfQJQE6e5eiW79ZXc40w1Gk0AS
 NuFYz+k30DJG1R9A+gk8REAnaV5YAhNV/7/R6ipXADZPvQoNjo0qiuOmvPACHdhx
 ZVA5lTim46It/sT8QSUw3njU2ZyoO2RJrHyqQMOPMG90Lu8F20NRviU7fg1d7w2K
 lDw80hTJlgyhFJ2lMhNlzivd3H3MZNLSW4gzSEH3siTz4zs3PIhQuB2YXlsTCPjw
 ==
Received: from ppma12.dal12v.mail.ibm.com
 (dc.9e.1632.ip4.static.sl-reverse.com [50.22.158.220])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4dw9xy314n-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Fri, 08 May 2026 15:37:53 +0000 (GMT)
Received: from pps.filterd (ppma12.dal12v.mail.ibm.com [127.0.0.1])
 by ppma12.dal12v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 648FOXDI004077;
 Fri, 8 May 2026 15:37:52 GMT
Received: from smtprelay05.fra02v.mail.ibm.com ([9.218.2.225])
 by ppma12.dal12v.mail.ibm.com (PPS) with ESMTPS id 4e10073ubg-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Fri, 08 May 2026 15:37:52 +0000 (GMT)
Received: from smtpav03.fra02v.mail.ibm.com (smtpav03.fra02v.mail.ibm.com
 [10.20.54.102])
 by smtprelay05.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 648FbnNb44892446
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Fri, 8 May 2026 15:37:49 GMT
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 296B72004D;
 Fri,  8 May 2026 15:37:49 +0000 (GMT)
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 9F5802004E;
 Fri,  8 May 2026 15:37:46 +0000 (GMT)
Received: from [9.124.210.83] (unknown [9.124.210.83])
 by smtpav03.fra02v.mail.ibm.com (Postfix) with ESMTP;
 Fri,  8 May 2026 15:37:45 +0000 (GMT)
Message-ID: <73894a74-732d-4912-989b-ddc37567ae74@linux.ibm.com>
Date: Fri, 8 May 2026 21:07:44 +0530
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] ppc/pnv: Fix uninitialized MpiplProcDumpArea struct
To: Shivang Upadhyay <shivangu@linux.ibm.com>, qemu-ppc@nongnu.org,
 qemu-devel@nongnu.org
Cc: Harsh Prateek Bora <harshpb@linux.ibm.com>,
 Peter Maydell <peter.maydell@linaro.org>
References: <20260508142029.624039-1-shivangu@linux.ibm.com>
Content-Language: en-US
From: Aditya Gupta <adityag@linux.ibm.com>
In-Reply-To: <20260508142029.624039-1-shivangu@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTA4MDE1NiBTYWx0ZWRfXyeUhrg9xDFR0
 3IaoX8/g+kOwKNcT0F+5Yn/FOQFJdo2GrmgLwp1caIxj9sotgq1ptWXgWxc89OU+83fIki8QIbC
 lCZCpZLWmpBO9xlq37BMoa29Hfxh5+cjTwf2bt+bpriJiNZb0xBAb8mJsd07/Gid/NX/ewmmKbc
 S98D0zjKIkiqBr78wUt8M3wnCIINQi/pcVEhTdrC2KXMq4vNuPhASxqSqTf+BHohzJLeiR4OZfu
 bn7vzwzUhEPjD+HXwVACqX/JSrqy4VjB5ic8tBzvM+iShWUlIV1l0LHSNQMDG9rzI361AE6Dc9K
 GER8Sv2TqKsQM9XGq3efVDzqVBHSEV6FnqNa4ewtAIt8yb+H4ukUsWvNLFybvVygj6I8o2/uf7j
 dpa+bWgvw1nwrqZSisO31oClS25CYyYj7Qaqcvb+8uYv3Aqrc6X15AyV9Z8UNi1GqjhsZnWvj0A
 FvvrOCfeBUPgd1zlGew==
X-Proofpoint-ORIG-GUID: x3jJaM5BlrSBzWthP1qUZZ_RCZXTqNUh
X-Proofpoint-GUID: x3jJaM5BlrSBzWthP1qUZZ_RCZXTqNUh
X-Authority-Analysis: v=2.4 cv=ctWrVV4i c=1 sm=1 tr=0 ts=69fe0351 cx=c_pps
 a=bLidbwmWQ0KltjZqbj+ezA==:117 a=bLidbwmWQ0KltjZqbj+ezA==:17
 a=IkcTkHD0fZMA:10 a=NGcC8JguVDcA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=V8glGbnc2Ofi9Qvn3v5h:22 a=VnNF1IyMAAAA:8
 a=KKAkSRfTAAAA:8 a=TSnCBYswgAEdwioKZoAA:9 a=QEXdDO2ut3YA:10
 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-05-07_02,2026-05-08_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 lowpriorityscore=0 adultscore=0 clxscore=1015
 suspectscore=0 impostorscore=0 spamscore=0 malwarescore=0 phishscore=0
 bulkscore=0 classifier=typeunknown authscore=0 authtc= authcc= route=outbound
 adjust=0 reason=mlx scancount=1 engine=8.22.0-2604200000
 definitions=main-2605080156
Received-SPF: pass client-ip=148.163.158.5; envelope-from=adityag@linux.ibm.com;
 helo=mx0b-001b2d01.pphosted.com
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

On 08/05/26 19:50, Shivang Upadhyay wrote:

> Fix Coverity CID 1658041 by using designated initializers to prevent
> uninitialized memory from being written to guest.
>
> Cc: Aditya Gupta <adityag@linux.ibm.com>
> Cc: Harsh Prateek Bora <harshpb@linux.ibm.com>
> Reported-by: Peter Maydell <peter.maydell@linaro.org>
> Suggested-by: Peter Maydell <peter.maydell@linaro.org>
> Signed-off-by: Shivang Upadhyay <shivangu@linux.ibm.com>"
> ---
>   hw/ppc/pnv.c | 16 ++++------------
>   1 file changed, 4 insertions(+), 12 deletions(-)
>
> diff --git a/hw/ppc/pnv.c b/hw/ppc/pnv.c
> index 9ed918fa6a..c0afef8197 100644
> --- a/hw/ppc/pnv.c
> +++ b/hw/ppc/pnv.c
> @@ -838,18 +838,10 @@ static void pnv_reset(MachineState *machine, ResetType type)
>            * crash
>            */
>   
> -        MpiplProcDumpArea proc_area;
> -
> -        proc_area.version = PROC_DUMP_AREA_VERSION_P9;
> -        proc_area.thread_size = cpu_to_be32(sizeof(MpiplPreservedCPUState));
> -
> -        /* These are to be allocated & assigned by the firmware */
> -        proc_area.alloc_addr = 0;
> -        proc_area.alloc_size = 0;
> -
> -        /* These get assigned after crash, when QEMU preserves the registers */
> -        proc_area.dest_addr = 0;
> -        proc_area.act_size = 0;
> +        MpiplProcDumpArea proc_area = {
> +            .version = PROC_DUMP_AREA_VERSION_P9,
> +            .thread_size = cpu_to_be32(sizeof(MpiplPreservedCPUState)),
> +        };
>   

Thanks for the fix, shivang.

Reviewed-by: Aditya Gupta <adityag@linux.ibm.com>


- Aditya G


