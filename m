Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9D0A1F3D5F5
	for <qemu-devel@archiver.kernel.org>; Sun, 29 Mar 2026 07:10:10 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w6kGw-0006Jj-Qk; Sun, 29 Mar 2026 03:09:22 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <adityag@linux.ibm.com>)
 id 1w6kGu-0006GK-RQ; Sun, 29 Mar 2026 03:09:20 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <adityag@linux.ibm.com>)
 id 1w6kGt-0006mi-4L; Sun, 29 Mar 2026 03:09:20 -0400
Received: from pps.filterd (m0353729.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 62T3jWBQ2309463; Sun, 29 Mar 2026 07:09:15 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=pp1; bh=Mlrwss
 SOH7o2ZeSQtO+O6lEwboSGgQI8XvKiMOjoGbs=; b=Us/uh/KfV1V7amnBfrcenR
 4U9j8jYrU5h3139hGuT3HoDBSAHBbdTQ3muOcRYjG3O252G3iUQ/RlojvVTUzLzM
 EznzcXO5fD2EHtIIbh/UZoL2gUY0mbgP+FRgm3ebTi4n4zjfobxrVYXghBu37I9Z
 U7FlWx/nYNZQ7iy+LHJtQfhw+iyqWJYHlYoqtQ+KdGANJ9k9USJAj5DwJEXifWlj
 P3A64sJiX65/d+6TrZXIc0PFqfPnPXWMTi1nUBAN0ug7X/pvEO3z2MatDZd+F/z7
 JdXbMkUeMRp7rIRxwu7MgjJpHqOUmRktU/vbywvs74/ZYpJAZJ3FqjU8myiXk4eQ
 ==
Received: from ppma11.dal12v.mail.ibm.com
 (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4d66nnauvk-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Sun, 29 Mar 2026 07:09:15 +0000 (GMT)
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
 by ppma11.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 62T3FL5f008698;
 Sun, 29 Mar 2026 07:09:14 GMT
Received: from smtprelay05.fra02v.mail.ibm.com ([9.218.2.225])
 by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 4d6v118ejh-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Sun, 29 Mar 2026 07:09:14 +0000
Received: from smtpav02.fra02v.mail.ibm.com (smtpav02.fra02v.mail.ibm.com
 [10.20.54.101])
 by smtprelay05.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 62T79CHi46727534
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Sun, 29 Mar 2026 07:09:13 GMT
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id E7E582004B;
 Sun, 29 Mar 2026 07:09:12 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 8AB4620043;
 Sun, 29 Mar 2026 07:09:09 +0000 (GMT)
Received: from [9.124.221.238] (unknown [9.124.221.238])
 by smtpav02.fra02v.mail.ibm.com (Postfix) with ESMTP;
 Sun, 29 Mar 2026 07:09:09 +0000 (GMT)
Message-ID: <4b9c7a13-e4e9-4450-9f0a-c5ea212fa9c0@linux.ibm.com>
Date: Sun, 29 Mar 2026 12:39:07 +0530
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] ppc/pnv: generate dtb after machine initialization is
 complete
To: Shivang Upadhyay <shivangu@linux.ibm.com>, qemu-ppc@nongnu.org,
 qemu-devel@nongnu.org
Cc: npiggin@gmail.com, milesg@linux.ibm.com,
 Harsh Prateek Bora <harshpb@linux.ibm.com>,
 BALATON Zoltan <balaton@eik.bme.hu>, qemu-stable@nongnu.org,
 Nathan Chancellor <nathan@kernel.org>,
 Peter Maydell <peter.maydell@linaro.org>
References: <20260327124136.983955-1-shivangu@linux.ibm.com>
Content-Language: en-US
From: Aditya Gupta <adityag@linux.ibm.com>
In-Reply-To: <20260327124136.983955-1-shivangu@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: kVU_tcNRbl5-8FOj7YrioLDm3C7f7jGw
X-Authority-Analysis: v=2.4 cv=KslAGGWN c=1 sm=1 tr=0 ts=69c8d01b cx=c_pps
 a=aDMHemPKRhS1OARIsFnwRA==:117 a=aDMHemPKRhS1OARIsFnwRA==:17
 a=IkcTkHD0fZMA:10 a=Yq5XynenixoA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=uAbxVGIbfxUO_5tXvNgY:22 a=VwQbUJbxAAAA:8
 a=VnNF1IyMAAAA:8 a=69wJf7TsAAAA:8 a=KKAkSRfTAAAA:8 a=Uen4MsYpUT-fPAyVx_8A:9
 a=QEXdDO2ut3YA:10 a=Fg1AiH1G6rFz08G2ETeA:22 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzI5MDA1MCBTYWx0ZWRfX9B8eEkoATU+T
 PUbuJpaRsKpmq/S/BSWpK34j38f4YEVBnkgXyX5fwl9rr1yky+OAgcJhtfKPQ50SZOf36I+J104
 z4p6UWbHrq8fpD4JPRlsMCfg73KX2pmXMROxTBdjI/toIPE2BYBNsf+GK+HjJQBxE2D2A02b4F3
 l+7xHlD/tbVHqsAaebuehVSf7FDGvOLU8+1pbFZoO4o+sJtbR3y9KCbQ9UropXnGNcn1kYFvEOS
 Hs0VNG0g31yT1IPuDyx01KfvaqwCw9DomstgcSyCiEBdKHcLrQUtNiBu99pM9Tr7u8up8trTXbv
 htdzQaQypE55tb15eLjZoVTKuYAVEnMVTQoSnAdvXKbQyntw3XTPa3IIg5/+jMLWYOBnyRYrzyy
 kfM/Wk63poLBDt+dK++6TA0Pwban4exhSMTOwkaF6jkdZkqT9sLFQsZp/i4NHi5dSF2l7C/MoBC
 m7YIkJ4YWreNwe6nVmw==
X-Proofpoint-ORIG-GUID: kVU_tcNRbl5-8FOj7YrioLDm3C7f7jGw
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-03-29_01,2026-03-28_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 lowpriorityscore=0 priorityscore=1501 suspectscore=0
 phishscore=0 adultscore=0 bulkscore=0 impostorscore=0 clxscore=1015
 spamscore=0 classifier=typeunknown authscore=0 authtc= authcc= route=outbound
 adjust=0 reason=mlx scancount=1 engine=8.22.0-2603050001
 definitions=main-2603290050
Received-SPF: pass client-ip=148.163.156.1; envelope-from=adityag@linux.ibm.com;
 helo=mx0a-001b2d01.pphosted.com
X-Spam_score_int: -26
X-Spam_score: -2.7
X-Spam_bar: --
X-Spam_report: (-2.7 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, RCVD_IN_DNSWL_LOW=-0.7,
 RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

On 27/03/26 18:11, Shivang Upadhyay wrote:

> Currently, the machine dtb is generated in pnv_init(), before all devices
> are fully initialized. This can result in an incomplete dtb for the system,
> as seen in bug [1].
>
> Fix this by deferring dtb generation until machine initialization is complete,
> using the machine_init_done_notifier hook.
>
> [1] https://lore.kernel.org/all/20260323231612.GA2637687@ax162/
>
> Cc: Aditya Gupta <adityag@linux.ibm.com>
> Cc: Harsh Prateek Bora <harshpb@linux.ibm.com>
> Cc: BALATON Zoltan <balaton@eik.bme.hu>
> Cc: qemu-stable@nongnu.org
> Reported-by: Nathan Chancellor <nathan@kernel.org>
> Suggested-by: Peter Maydell <peter.maydell@linaro.org>
> Fixes: a16d4c2f162a86d ("ppc/pnv: fix dumpdtb option")
> Signed-off-by: Shivang Upadhyay <shivangu@linux.ibm.com>
>
> ---
> Changes:
>
> v2:
> * moved pnv->bmc initialization to pnv_machine_init_done.
>
> v1:
> * https://lore.kernel.org/all/20260324135026.247418-1-shivangu@linux.ibm.com/
> ---
>   hw/ppc/pnv.c         | 58 +++++++++++++++++++++++++-------------------
>   include/hw/ppc/pnv.h |  2 ++
>   2 files changed, 35 insertions(+), 25 deletions(-)


Reviewed-by: Aditya Gupta <adityag@linux.ibm.com>


Thanks,

- Aditya G


