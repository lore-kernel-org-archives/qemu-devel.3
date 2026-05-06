Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BAA38CD342C
	for <qemu-devel@archiver.kernel.org>; Wed,  6 May 2026 11:16:40 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wKaEy-0006Ov-Fc; Wed, 06 May 2026 07:16:32 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <rathc@linux.ibm.com>)
 id 1wKaEs-0006NX-8k; Wed, 06 May 2026 07:16:28 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <rathc@linux.ibm.com>)
 id 1wKaEq-0003Wj-91; Wed, 06 May 2026 07:16:26 -0400
Received: from pps.filterd (m0360083.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 645IVETA3066719; Wed, 6 May 2026 11:16:21 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=pp1; bh=vJf0sM
 rvwSRUBgFcf9dezS+s5tqzDwOspM/8QRn1Sgg=; b=DF8OnQmRVxu0odKUWabvXj
 1RmHWOvhD2KGPmqIaAfy+RB0hVzB4JosSeEmTuW8moes4ahZ7nUGtFlq8dsAkCET
 1JZWjfs+Or3/gffCR8b4BgDx3we81KxCZwQkXWY0Ne81msbFSxy4Z3/2a2sGobdO
 m/h4SU5rWFhalrC+GzI5olFrx9fGChlEtfX4R5hhauIibr9UivYaRvaa3n2mBIy5
 LeSI/fuGDLnE3ZtkaFCTwK3BIhznea45FRHlbjtt3yS0QBGWoMGw0l9ujsCNxS+b
 /DxuYxUv8IIN8k6iDhzfN04tOk5eHS1O41sTl2RlvdJSLuB9rEEztfI2KaMh3Vtg
 ==
Received: from ppma21.wdc07v.mail.ibm.com
 (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4dw9v7gbtr-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Wed, 06 May 2026 11:16:20 +0000 (GMT)
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
 by ppma21.wdc07v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 646B9QWS007965;
 Wed, 6 May 2026 11:16:19 GMT
Received: from smtprelay03.wdc07v.mail.ibm.com ([172.16.1.70])
 by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4dwvkjwx7j-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Wed, 06 May 2026 11:16:19 +0000 (GMT)
Received: from smtpav04.wdc07v.mail.ibm.com (smtpav04.wdc07v.mail.ibm.com
 [10.39.53.231])
 by smtprelay03.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 646BFo8o28377850
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Wed, 6 May 2026 11:15:51 GMT
Received: from smtpav04.wdc07v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 75C8858045;
 Wed,  6 May 2026 11:16:18 +0000 (GMT)
Received: from smtpav04.wdc07v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 3860C58050;
 Wed,  6 May 2026 11:16:16 +0000 (GMT)
Received: from [9.123.8.229] (unknown [9.123.8.229])
 by smtpav04.wdc07v.mail.ibm.com (Postfix) with ESMTPS;
 Wed,  6 May 2026 11:16:15 +0000 (GMT)
Message-ID: <4110074f-d7a4-4b00-9932-3ea9ecd2d942@linux.ibm.com>
Date: Wed, 6 May 2026 16:45:29 +0530
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] MAINTAINERS: add self as reviewer for PowerNV and PPC TCG
To: Harsh Prateek Bora <harshpb@linux.ibm.com>, qemu-ppc@nongnu.org,
 qemu-devel@nongnu.org
Cc: npiggin@gmail.com, milesg@linux.ibm.com, adityag@linux.ibm.com
References: <20260501144558.24491-1-harshpb@linux.ibm.com>
Content-Language: en-US
From: Chinmay Rath <rathc@linux.ibm.com>
In-Reply-To: <20260501144558.24491-1-harshpb@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTA2MDEwOSBTYWx0ZWRfXxLVqkf4RFcSz
 yksaTp1PYmABk6PwMdFy4MYH8Ybi35uQAF08QHhDEu0TpQnhMmn/PgngH1FAZt7ERkLrUHow1bF
 i9iTyoaU/5/qpT75Bsl9TwLOXv0XYhh65CZ6Qkdt8vaEpD1iUEegLOSSQJfaRBexCX7Q/K0I+Yg
 RzJjRJmTbqMSiNLtFNIosmptQ368ed7yy80WPUBy6tWHk3OM0Raqwj3yErVWoZcvtTMABVLD/Rc
 ofUdXm6v3KJh50mCs1m1VPBv/1JrFUNMDgb5yavPFAHqVYTeQOxlEzGV1d/xF/oLPAFLOthrDq5
 FE6YEjioZeTIpr1aJuQyxPAwKxidwaRJ/qji41vcgJD3EtIHcb3frl5LTZsvnfqXTnNkiwdSnJu
 8miohGJ14ui6E2X/wgVNG/fY1jOAG3AauRmIwY+S+K+soUpOWFzZL7DWMFPXwW7L2csWZ6N0hl2
 u7uurkUP2CSYVM7BJxw==
X-Proofpoint-GUID: uXJ_sdfjV3j2pVVCQBpmhnQ6gDtwM8Zr
X-Proofpoint-ORIG-GUID: OTW4dg7vbWddx1NmYF6lBtg6LgcNLI0g
X-Authority-Analysis: v=2.4 cv=eu/vCIpX c=1 sm=1 tr=0 ts=69fb2305 cx=c_pps
 a=GFwsV6G8L6GxiO2Y/PsHdQ==:117 a=GFwsV6G8L6GxiO2Y/PsHdQ==:17
 a=IkcTkHD0fZMA:10 a=NGcC8JguVDcA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=iQ6ETzBq9ecOQQE5vZCe:22 a=VnNF1IyMAAAA:8
 a=pGLkceISAAAA:8 a=69wJf7TsAAAA:8 a=rOkwGLQlSJAGMj3WhNgA:9 a=QEXdDO2ut3YA:10
 a=Fg1AiH1G6rFz08G2ETeA:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-05-05_03,2026-04-30_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 phishscore=0 lowpriorityscore=0 clxscore=1015 adultscore=0
 suspectscore=0 malwarescore=0 bulkscore=0 impostorscore=0 spamscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2604200000 definitions=main-2605060109
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


On 5/1/26 20:15, Harsh Prateek Bora wrote:
> Also remove the redundant entry for pseries.
>
> Signed-off-by: Harsh Prateek Bora <harshpb@linux.ibm.com>
> ---
>   MAINTAINERS | 3 ++-
>   1 file changed, 2 insertions(+), 1 deletion(-)
>
> diff --git a/MAINTAINERS b/MAINTAINERS
> index e41f0eb92c..0ad8770fa0 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -323,6 +323,7 @@ PowerPC TCG CPUs
>   M: Nicholas Piggin <npiggin@gmail.com>
>   R: Chinmay Rath <rathc@linux.ibm.com>
>   R: Glenn Miles <milesg@linux.ibm.com>
> +R: Harsh Prateek Bora <harshpb@linux.ibm.com>
>   L: qemu-ppc@nongnu.org
>   S: Odd Fixes
>   F: target/ppc/
> @@ -1617,7 +1618,6 @@ F: tests/functional/ppc/test_40p.py
>   sPAPR (pseries)
>   M: Nicholas Piggin <npiggin@gmail.com>
>   M: Harsh Prateek Bora <harshpb@linux.ibm.com>
> -R: Harsh Prateek Bora <harshpb@linux.ibm.com>
>   L: qemu-ppc@nongnu.org
>   S: Odd Fixes
>   F: hw/*/spapr*
> @@ -1643,6 +1643,7 @@ PowerNV (Non-Virtualized)
>   M: Nicholas Piggin <npiggin@gmail.com>
>   R: Aditya Gupta <adityag@linux.ibm.com>
>   R: Glenn Miles <milesg@linux.ibm.com>
> +R: Harsh Prateek Bora <harshpb@linux.ibm.com>
>   L: qemu-ppc@nongnu.org
>   S: Odd Fixes
>   F: docs/system/ppc/powernv.rst
Thanks for taking this up.
Reviewed-by: Chinmay Rath <rathc@linux.ibm.com>

