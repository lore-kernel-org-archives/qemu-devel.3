Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C012DC982CC
	for <qemu-devel@archiver.kernel.org>; Thu, 17 Sep 2026 01:46:48 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x71CE-0001U4-Ey; Wed, 16 Sep 2026 21:45:54 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjrosato@linux.ibm.com>)
 id 1x71CC-0001TI-2r; Wed, 16 Sep 2026 21:45:52 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjrosato@linux.ibm.com>)
 id 1x71CA-000818-BZ; Wed, 16 Sep 2026 21:45:51 -0400
Received: from pps.filterd (m0360072.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 68GG1pIM046283; Thu, 17 Sep 2026 01:45:48 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=pp1; bh=x/MQ34
 DWYhGmx51vGRd2MxbJjMIzR34kSsc6DRj3rUs=; b=oqHcNuAJ2Y7sp6KK1rMTso
 QsTZLur85TVMm/7Cq/RILfGJcX25hZ+yOkgzFacQTiWhHWvpoOudq9iZCYdZ+OFS
 /EwQ599SZeo5C8dcK09Y4XGpeiKoccPuP02b4mELRW604aQdJD96rrfMt1jGTJPs
 +8UxF36Id6kPjvn7QLCOeb99IhSjfxdmj0LphQmfQBzFbmhPDEkZrJP0Jm+vuYj4
 jqpgZ+xO6PkV/o2gx5jWPmPWV638xy9VIGxyhHiz86KdANEsUhD+OJqmujDC7QNX
 ndgneIv7zpfzwDRA2uWKQBtCRMZoOdVmRkC7WW5myGXKY2Ols5rSh8tfoHnjCzTQ
 ==
Received: from ppma23.wdc07v.mail.ibm.com
 (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4gmxcv7ctp-1
 (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
 Thu, 17 Sep 2026 01:45:48 +0000 (GMT)
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
 by ppma23.wdc07v.mail.ibm.com (8.18.1.11/8.18.1.11) with ESMTP id
 68H0iRPb2316401; Thu, 17 Sep 2026 01:45:47 GMT
Received: from smtprelay05.wdc07v.mail.ibm.com ([172.16.1.72])
 by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4gr5xa05kh-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 17 Sep 2026 01:45:47 +0000 (GMT)
Received: from smtpav04.wdc07v.mail.ibm.com (smtpav04.wdc07v.mail.ibm.com
 [10.39.53.231])
 by smtprelay05.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 68H1jkP03277446
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Thu, 17 Sep 2026 01:45:46 GMT
Received: from smtpav04.wdc07v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 86DE758052;
 Thu, 17 Sep 2026 01:45:46 +0000 (GMT)
Received: from smtpav04.wdc07v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id BD31358050;
 Thu, 17 Sep 2026 01:45:45 +0000 (GMT)
Received: from [9.61.177.109] (unknown [9.61.177.109])
 by smtpav04.wdc07v.mail.ibm.com (Postfix) with ESMTP;
 Thu, 17 Sep 2026 01:45:45 +0000 (GMT)
Message-ID: <139ec7b4-b467-4ef4-8832-9437f5047767@linux.ibm.com>
Date: Wed, 16 Sep 2026 21:45:45 -0400
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1] s390x/pci: fix DMA slot leak on I/O TLB entry
 replacement
To: Farhan Ali <alifm@linux.ibm.com>, Omar Elghoul <oelghoul@linux.ibm.com>,
 qemu-devel@nongnu.org, qemu-s390x@nongnu.org
Cc: farman@linux.ibm.com, cohuck@redhat.com, qemu-stable@nongnu.org
References: <20260910132408.12707-1-oelghoul@linux.ibm.com>
 <9aded4ae-512f-4b54-9421-02cb1f973ec0@linux.ibm.com>
Content-Language: en-US
From: Matthew Rosato <mjrosato@linux.ibm.com>
In-Reply-To: <9aded4ae-512f-4b54-9421-02cb1f973ec0@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTE3MDAxOCBTYWx0ZWRfXxwyGskWAnqWj
 RQdlQSSexQ/1kGFWxQBODlUh4wCwfbl/cAZEnTy82viax+zZccZcjoXR8CYbIFRTzx8egBDLo5M
 Z5EQjfhtjX+vnqQMuh9WiYA226UUlo4=
X-Proofpoint-ORIG-GUID: 7fWpW4R5x4VP39u7z7JQjap6hDd_IaGX
X-Proofpoint-GUID: 7fWpW4R5x4VP39u7z7JQjap6hDd_IaGX
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTE3MDAxOCBTYWx0ZWRfXwsQq8wi3oVKe
 6RSxouyeSNOQb5n3CQWm9oE+ieo38EZzAfoF1YGYpGcFElwKw0MHk0RdoTy0z36vvneQ8asi3ZN
 kw8Ow4TyCrPVZdvhoMS642N1dEwMK/D2AWr7j67Os7cy8XuvlJZFjr6ughWXrT1fo3TUpFxtFch
 UP98anl4U9zW2XAYd5qXdit2TIwclWFqXAYmaDbmpv+cFdqfqbpwju0zX6kFVX1MWwq1Lkmd8Vg
 4dyIymdQH46RCog/AUGtKe7fRUfi+xKREpGKL6JO9HzBhg556sHV3C/rq4VxmUcoWxVA0utPMpN
 NCjS5qmHwT1VAb5UUxd09uKkCMC29jtlh5EwcKIP5xEvUxD9hrvQA0tlO9ZYMfJHFtKKBIoRb3c
 YbMp6iV87OQeh6SFajcSmBhTgLPZq2VHQZkHoOUACPKK6QLAd/CfoOqdQpbJAiRKEwlZtZlSJHy
 2L+aoggmeMRfcBferYA==
X-Authority-Analysis: v=2.4 cv=F+7C5ahN c=1 sm=1 tr=0 ts=6aab464c cx=c_pps
 a=3Bg1Hr4SwmMryq2xdFQyZA==:117 a=3Bg1Hr4SwmMryq2xdFQyZA==:17
 a=IkcTkHD0fZMA:10 a=VdqzKS8jKosA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=RzCfie-kr_QcCd8fBx8p:22 a=69wJf7TsAAAA:8
 a=VnNF1IyMAAAA:8 a=qsyVNPzcmnk0oqjtYO4A:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=Fg1AiH1G6rFz08G2ETeA:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-16_03,2026-09-16_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 suspectscore=0 phishscore=0 clxscore=1015 malwarescore=0
 lowpriorityscore=0 bulkscore=0 spamscore=0 impostorscore=0 adultscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2609040000 definitions=main-2609170018
Received-SPF: pass client-ip=148.163.158.5;
 envelope-from=mjrosato@linux.ibm.com; helo=mx0b-001b2d01.pphosted.com
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

On 9/14/26 5:27 PM, Farhan Ali wrote:
> 
> On 9/10/2026 6:24 AM, Omar Elghoul wrote:
>> When s390_pci_update_iotlb() does a mapping update for an IOVA that has
>> an already-existing TLB entry with different permissions or translated
>> address, it unmaps then remaps it. However, at the end of the map path,
>> it unconditionally decrements the available DMA slot counter without a
>> corresponding increment in the intermediate unmap branch.
>>
>> This causes the DMA slot count to be decremented on every remapping of
>> an active IOVA, leading to a permanent DMA slot leak. This remapping
>> without a prior invalidation and sync is not seen today in well-behaved
>> guests but is allowed by the architecture. Fix it by only decrementing
>> available DMA slots when inserting a brand new mapping.
>>
>> Cc: qemu-stable@nongnu.org
>> Fixes: 37fa32de70 ("s390x/pci: Honor DMA limits set by vfio")
>> Signed-off-by: Omar Elghoul <oelghoul@linux.ibm.com>
>> ---
>>   hw/s390x/s390-pci-inst.c | 4 +++-
>>   1 file changed, 3 insertions(+), 1 deletion(-)
>>
>> diff --git a/hw/s390x/s390-pci-inst.c b/hw/s390x/s390-pci-inst.c
>> index b7de23c7d2..5840675aba 100644
>> --- a/hw/s390x/s390-pci-inst.c
>> +++ b/hw/s390x/s390-pci-inst.c
>> @@ -665,6 +665,9 @@ static uint32_t s390_pci_update_iotlb(S390PCIIOMMU
>> *iommu,
>>               memory_region_notify_iommu(&iommu->iommu_mr, 0, event);
>>               event.type = IOMMU_NOTIFIER_MAP;
>>               event.entry.perm = entry->perm;
>> +        } else {
>> +            /* only new mappings consume DMA slots */
>> +            dec_dma_avail(iommu);
>>           }
> To me the else statement here makes it a little more confusing. I think
> it would be easier to read, if we increment above when do the unmap in
> the intermediate step. That way we associate incrementing the available
> entries with unmap and decrementing it with map operation. But I guess
> this avoids an additional function call for the same result.

So first, for the code itself:

Reviewed-by: Matthew Rosato <mjrosato@linux.ibm.com>

As to the readability vs adding an intermediate increment -- maybe if
you add another small comment it would help with readability?

Something like:

if (cache) {
    /* valid->valid transitions re-use a DMA slot */
    ...
} else {
    /* invalid->valid transitions consume a new DMA slot */
    ...
}

Note I did tweak your wording a little bit.

You could even add a comment in the straight unmap case if you think it
would also be helpful e.g.

/* valid->invalid transitions will release a DMA slot */

I think this makes it very clear when the counter should be going
up/down/neutral.

Thanks,
Matt

