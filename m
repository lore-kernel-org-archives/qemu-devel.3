Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 17238EE6B44
	for <qemu-devel@archiver.kernel.org>; Fri,  6 Feb 2026 17:57:45 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1voQ4p-00044Z-2y; Fri, 06 Feb 2026 12:57:07 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alifm@linux.ibm.com>)
 id 1voQ4j-00043n-0W; Fri, 06 Feb 2026 12:57:02 -0500
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alifm@linux.ibm.com>)
 id 1voQ4h-0007OB-8y; Fri, 06 Feb 2026 12:57:00 -0500
Received: from pps.filterd (m0356517.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 61666b1H025324;
 Fri, 6 Feb 2026 17:56:56 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=pp1; bh=UUnmz8
 vUIuPV+RZpavxWbmI6zGgMXyl7pA7qxI6R9b4=; b=VEuWKFP8Ejls8YroTNmFSu
 b0LK4tlclqP6/RyYslzsupahyXWelNMEEA/OvFhO43b24jgUXNhCqg/fpgAThoBw
 blQQpCErgOwsOzdsVnRVYPNjyJoFb9LMf3tyUf3ziJb2Qzz6+BG55Z9EH6dOE3CK
 RmGKACJB4lHFKwUqHAHtF5UpLV7VY+OxL0RYMaTvmhEfnTMmOv3Vk00lyx1h9No8
 7iuiL75+gNx7/SekvVi59QSZGQJh2DYDEqMn4kMXwkU9BizMlBOx6K01JtrZRbs/
 uV/HfZov4dux3/oJBI0glMobhQiPuqaVwN9BrZrg5cpkPcP1H+cLR3HOPFQBBbWQ
 ==
Received: from ppma13.dal12v.mail.ibm.com
 (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4c19f6vvqe-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Fri, 06 Feb 2026 17:56:55 +0000 (GMT)
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
 by ppma13.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 616HDuNX005928;
 Fri, 6 Feb 2026 17:56:54 GMT
Received: from smtprelay02.wdc07v.mail.ibm.com ([172.16.1.69])
 by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 4c1x9jpy1e-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Fri, 06 Feb 2026 17:56:54 +0000
Received: from smtpav05.wdc07v.mail.ibm.com (smtpav05.wdc07v.mail.ibm.com
 [10.39.53.232])
 by smtprelay02.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 616HurMU30868140
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Fri, 6 Feb 2026 17:56:53 GMT
Received: from smtpav05.wdc07v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 4C63958059;
 Fri,  6 Feb 2026 17:56:53 +0000 (GMT)
Received: from smtpav05.wdc07v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 36C6E58053;
 Fri,  6 Feb 2026 17:56:52 +0000 (GMT)
Received: from [9.61.245.175] (unknown [9.61.245.175])
 by smtpav05.wdc07v.mail.ibm.com (Postfix) with ESMTP;
 Fri,  6 Feb 2026 17:56:52 +0000 (GMT)
Message-ID: <316b9567-8c75-4047-938e-4f39d9ae3186@linux.ibm.com>
Date: Fri, 6 Feb 2026 09:56:51 -0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1] s390x/pci: Fix endianness for zPCI BAR values.
To: Jaehoon Kim <jhkim@linux.ibm.com>, qemu-devel@nongnu.org,
 qemu-s390x@nongnu.org
Cc: mjrosato@linux.ibm.com, farman@linux.ibm.com, pasic@linux.ibm.com,
 borntraeger@linux.ibm.com, thuth@redhat.com,
 richard.henderson@linaro.org, david@redhat.com, iii@linux.ibm.com
References: <20260206164645.1845366-1-jhkim@linux.ibm.com>
Content-Language: en-US
From: Farhan Ali <alifm@linux.ibm.com>
In-Reply-To: <20260206164645.1845366-1-jhkim@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: keQMfavUem-Ey2vIMuAaT3Gs-fb4Dqe-
X-Authority-Analysis: v=2.4 cv=drTWylg4 c=1 sm=1 tr=0 ts=69862b68 cx=c_pps
 a=AfN7/Ok6k8XGzOShvHwTGQ==:117 a=AfN7/Ok6k8XGzOShvHwTGQ==:17
 a=IkcTkHD0fZMA:10 a=HzLeVaNsDn8A:10 a=VkNPw1HP01LnGYTKEx00:22
 a=Mpw57Om8IfrbqaoTuvik:22 a=GgsMoib0sEa3-_RKJdDe:22 a=VnNF1IyMAAAA:8
 a=5dwcVOLGD4cZohy6t3cA:9 a=lqcHg5cX4UMA:10 a=3ZKOabzyN94A:10
 a=QEXdDO2ut3YA:10
X-Proofpoint-ORIG-GUID: keQMfavUem-Ey2vIMuAaT3Gs-fb4Dqe-
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMjA2MDEzMSBTYWx0ZWRfX9BU5X+PW4LcW
 OCLgcE9Wo3o1pvujIkMvsap4OFjAs2h83Xt1zXRTAgM2YLWl5cYf9KJccGfnixbj+1boysxEVRD
 /VZqnuWQTTFAAY5k8QBaXnvXdn17a2i4e8xhj8+W4SGSPbxq9L7j2OE5UEh3bKS819TZZxucqjQ
 i/iKnIOASJshdgpc+FulWowXUAWWWjaXs2tBx/qIIXfTj2E7AY+mB7VkQYdxEqkPPUOv4MFbOMN
 CLLuq6H4ipZfGEDBENECvEX+sh/ipaoH3YptVfsMwkYN3xO8ylu/KwZ6Z30f51Vlgb36O4gtFTo
 baXKUApFX778vhEASOT9qzGkAlHq/p5ZxYZujYKVjJkQnniyomdfCknTx/T8kkFoEkAYM5bUopD
 XVgUAYj+aTPR2KAgsQtfzBwFokIQGUse0B2bob95gDMr+mWWDDKUyBxiBwF9ewbZkVcnPtUDD0O
 yZbI2msw+2wtBhSXwGg==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-02-06_05,2026-02-05_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 clxscore=1015 spamscore=0 malwarescore=0 bulkscore=0
 phishscore=0 adultscore=0 lowpriorityscore=0 impostorscore=0
 priorityscore=1501 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2601150000
 definitions=main-2602060131
Received-SPF: pass client-ip=148.163.156.1; envelope-from=alifm@linux.ibm.com;
 helo=mx0a-001b2d01.pphosted.com
X-Spam_score_int: -19
X-Spam_score: -2.0
X-Spam_bar: --
X-Spam_report: (-2.0 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, RCVD_IN_DNSWL_NONE=-0.0001,
 RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
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


On 2/6/2026 8:46 AM, Jaehoon Kim wrote:
> During zPCI scan, BAR configuration data retrieved via CLP Query was
> misinterpreted due to an endianness mismatch between QEMU and the guest
> kernel.
>
> The guest kernel's clp_store_query_pci_fn() expects BAR values in
> little-endian format and converts them with le32_to_cpu(). However, QEMU
> was incorrectly sending them in big-endian format, not following the
> architecture specification. This caused incorrect bit-swapping in the
> kernel, leading zpci_setup_bus_resources() to perform registration checks
> against invalid flags, making the process ineffective.
>
> Observation values for zPCI device (NVMe passthrough):
> LPAR from real CLP:
> [    0.865595] Resource: PCI Bus 0000:00 -> zdev->bar[0].val: 0x4
> [    0.865597]  start: 0x4000000000000000
> [    0.865598]  end:   0x4000000000003fff
> [    0.865600]  flags: 0x100200
>
> QEMU before fix (wrong):
> [    0.601083] Resource: PCI Bus 0001:00 -> zdev->bar[0].val: 0x4000000
> [    0.601085]  start: 0x4003000000000000
> [    0.601086]  end:   0x4003000000003fff
> [    0.601087]  flags: 0x200
>
> QEMU after fix (correct):
> [    0.601116] Resource: PCI Bus 0001:00 -> zdev->bar[0].val: 0x4
> [    0.601117]  start: 0x4003000000000000
> [    0.601118]  end:   0x4003000000003fff
> [    0.601119]  flags: 0x100200
>
> Signed-off-by: Jaehoon Kim <jhkim@linux.ibm.com>
> ---
>   hw/s390x/s390-pci-inst.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/hw/s390x/s390-pci-inst.c b/hw/s390x/s390-pci-inst.c
> index 6b67c3c109..10066ca618 100644
> --- a/hw/s390x/s390-pci-inst.c
> +++ b/hw/s390x/s390-pci-inst.c
> @@ -307,7 +307,7 @@ int clp_service_call(S390CPU *cpu, uint8_t r2, uintptr_t ra)
>               uint32_t data = pci_get_long(pbdev->pdev->config +
>                   PCI_BASE_ADDRESS_0 + (i * 4));
>   
> -            stl_be_p(&resquery->bar[i], data);
> +            stl_le_p(&resquery->bar[i], data);
>               resquery->bar_size[i] = pbdev->pdev->io_regions[i].size ?
>                                       ctz64(pbdev->pdev->io_regions[i].size) : 0;
>               trace_s390_pci_bar(i,


This is indeed correct architecturally, thanks for fixing this.

Reviewed-by: Farhan Ali <alifm@linux.ibm.com> <mailto:alifm@linux.ibm.com>


