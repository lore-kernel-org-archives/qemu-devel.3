Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 569D2C5DF6D
	for <qemu-devel@archiver.kernel.org>; Wed, 19 Aug 2026 10:01:12 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wwd6N-0003Vx-30; Wed, 19 Aug 2026 06:00:55 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <rathc@linux.ibm.com>)
 id 1wwd6B-0003Ru-Mo; Wed, 19 Aug 2026 06:00:46 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <rathc@linux.ibm.com>)
 id 1wwd6A-0000PB-6x; Wed, 19 Aug 2026 06:00:43 -0400
Received: from pps.filterd (m0353725.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 67J6W5hd1544784; Wed, 19 Aug 2026 10:00:40 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=pp1; bh=MLAkW5
 LkKDPhKqfLPLLB5kZEUTlqos/WZjGaSdkIobc=; b=NnE4wZpD40UUGUN4Dr0yjb
 VztEVhJ2yLLmNXpzn4bQZeAyEwMAzlxLa+iGuYS3V0Of6eJVxgnRXfWs3Y7D07mX
 PzGltPy1cr260SSXXi7P943mYt7ADehwu0e9vIgsqemShoId6D0enPXtzFkud2Xf
 68MSIzVUGBWckZ5eV/u5EH4/oNpPetsXgrUUO0vnbAXzs05ZB9Az02RhTHsbi1zu
 aOFWivVERWiUBYWNErgVexvq9qxxtyftsyp9ZB+uusz2vPC+wGzoGQGIh5nfwV0g
 EsjqWcp/1IFJeiqTYanRD0Z/+2wi+gllwwBpikuwXWc70FqwEaCsr/MMXuNzI9kQ
 ==
Received: from ppma11.dal12v.mail.ibm.com
 (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4g4yu22vpx-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Wed, 19 Aug 2026 10:00:39 +0000 (GMT)
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
 by ppma11.dal12v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 67J9uRiq024309;
 Wed, 19 Aug 2026 10:00:39 GMT
Received: from smtprelay07.wdc07v.mail.ibm.com ([172.16.1.74])
 by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 4g354yg19a-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Wed, 19 Aug 2026 10:00:39 +0000 (GMT)
Received: from smtpav02.wdc07v.mail.ibm.com (smtpav02.wdc07v.mail.ibm.com
 [10.39.53.229])
 by smtprelay07.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 67JA0bdp64749956
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Wed, 19 Aug 2026 10:00:37 GMT
Received: from smtpav02.wdc07v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 5C6E65805E;
 Wed, 19 Aug 2026 10:00:37 +0000 (GMT)
Received: from smtpav02.wdc07v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id B8F645805D;
 Wed, 19 Aug 2026 10:00:33 +0000 (GMT)
Received: from [9.39.17.179] (unknown [9.39.17.179])
 by smtpav02.wdc07v.mail.ibm.com (Postfix) with ESMTP;
 Wed, 19 Aug 2026 10:00:33 +0000 (GMT)
Message-ID: <b46ce266-848d-453e-b84b-2cc2c5a3f53d@linux.ibm.com>
Date: Wed, 19 Aug 2026 15:30:31 +0530
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] MAINTAINERS: Add myself as a reviewer for PPC KVM and
 sPAPR
To: Amit Machhiwal <amachhiw@linux.ibm.com>, qemu-ppc@nongnu.org,
 qemu-devel@nongnu.org, Harsh Prateek Bora <harshpb@linux.ibm.com>
Cc: Nicholas Piggin <npiggin@gmail.com>, Gautam Menghani <gautam@linux.ibm.com>
References: <20260819050545.21232-1-amachhiw@linux.ibm.com>
Content-Language: en-US
From: Chinmay Rath <rathc@linux.ibm.com>
In-Reply-To: <20260819050545.21232-1-amachhiw@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Authority-Analysis: v=2.4 cv=AdqB2XXG c=1 sm=1 tr=0 ts=6a857ec8 cx=c_pps
 a=aDMHemPKRhS1OARIsFnwRA==:117 a=aDMHemPKRhS1OARIsFnwRA==:17
 a=IkcTkHD0fZMA:10 a=Sv0fKeRqtYgA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=V8glGbnc2Ofi9Qvn3v5h:22 a=VnNF1IyMAAAA:8
 a=pGLkceISAAAA:8 a=69wJf7TsAAAA:8 a=kcJ0IuGOz4MQWM4fTz8A:9 a=QEXdDO2ut3YA:10
 a=Fg1AiH1G6rFz08G2ETeA:22
X-Proofpoint-GUID: fvOTjmisdjhfeWeegdU1hiI3ZAH6znPf
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODE5MDA3MiBTYWx0ZWRfX/5cKhA3+/fp5
 FKhUxJezbvPQr0zPV4ickIpWbofRkKByhSe3k777hhz2DNg1LC6lw5LdC6ag79vTam5VlBUsvhU
 Qhrfynk0VPi24tOrvbUw62wDV4rsW8IGhHC5n6dzB9c65xhmb74y8JATWLFO8OMH5JD1zmTEs5W
 TVc/tSzoUayewbWktGDgpXYdqR3FDxFhcEQ31KH13dRLEeo/nj23Q5JGCqisDYPEVtO9kDff0GU
 PMregBCwa+UCtgI20ljTTGPtghfjadK9RNyzojBbMKTJkIqQmOU6SCOkQ+KuqWDMJvXF9GK3oGr
 XJJposb+WNwZXcJgwPwOoTUwYiiR47Mph4GDTfjwOWU9Fr9K1/sKvwchUff5HIE/CecPACgipEg
 +7BBIa2ekXnWb1ov6yqmO3IXaHVcgjQ62dUz4ikR4H9o4wHpi88jQJ8n9IbewLEPqyhz4zSmV+y
 t5B9DnamzEa9TeCpirA==
X-Proofpoint-Spam-Info: AW1haW4tMjYwODE5MDA3MiBTYWx0ZWRfX6fffwltS2ljJ
 e0+MBi0jXS7NZHubmjguGmzYOI+UZkHzap52Z3Ur/2UN4Ho+4AOb2Znel5G11ewjDvoPHue/gbw
 0shBjrFxbcTgbDErKg+M7PDtOwMVLt4=
X-Proofpoint-ORIG-GUID: 0oGiKLgWS0tV5I4C53TZ0KGYZ1rtBlu5
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-19_02,2026-08-18_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 priorityscore=1501 suspectscore=0 malwarescore=0
 impostorscore=0 adultscore=0 bulkscore=0 lowpriorityscore=0 phishscore=0
 spamscore=0 classifier=typeunknown authscore=0 authtc= authcc= route=outbound
 adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2608190072
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


On 8/19/26 10:35, Amit Machhiwal wrote:
> I have been contributing to PPC KVM and sPAPR (pseries) for some time now and
> would like to get notified of incoming changes to help with code reviews.
>
> Signed-off-by: Amit Machhiwal <amachhiw@linux.ibm.com>
> ---
>   MAINTAINERS | 2 ++
>   1 file changed, 2 insertions(+)
>
> diff --git a/MAINTAINERS b/MAINTAINERS
> index b51f5c3e6022..1a1c77285d3d 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -497,6 +497,7 @@ F: tests/functional/aarch64/test_kvm.py
>   PPC KVM CPUs
>   M: Nicholas Piggin <npiggin@gmail.com>
>   R: Harsh Prateek Bora <harshpb@linux.ibm.com>
> +R: Amit Machhiwal <amachhiw@linux.ibm.com>
>   S: Odd Fixes
>   F: target/ppc/kvm.c
>   
> @@ -1661,6 +1662,7 @@ F: tests/functional/ppc/test_40p.py
>   sPAPR (pseries)
>   M: Nicholas Piggin <npiggin@gmail.com>
>   M: Harsh Prateek Bora <harshpb@linux.ibm.com>
> +R: Amit Machhiwal <amachhiw@linux.ibm.com>
>   L: qemu-ppc@nongnu.org
>   S: Odd Fixes
>   F: hw/*/spapr*
>
> base-commit: fa19879df1658f96ac07365fca8835b7decd6995
Thanks for taking this up !

Acked-by: Chinmay Rath <rathc@linux.ibm.com>

