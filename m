Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EE790C88E73
	for <qemu-devel@archiver.kernel.org>; Mon, 14 Sep 2026 21:28:02 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x6EDR-0000CV-6o; Mon, 14 Sep 2026 17:27:53 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alifm@linux.ibm.com>)
 id 1x6EDH-0000C0-KW; Mon, 14 Sep 2026 17:27:45 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alifm@linux.ibm.com>)
 id 1x6EDG-0004kR-19; Mon, 14 Sep 2026 17:27:43 -0400
Received: from pps.filterd (m0353725.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 68EK1ZOM1837062; Mon, 14 Sep 2026 21:27:40 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=pp1; bh=RAwxwA
 3wOo7JnRaHQo/luItbcRXBzcaf9/mx4T7ikPE=; b=q76mMJhov6OP7JgSYmIteq
 4t9X3tKhLyh1zscEmmjB9vkfQlkx8hC7+qvCf4vf/G7QvY7vZrYRzVf8JE7reW2A
 pc6MBpBrW8V40YcdW/ExbLsGjTr21RyclySC/rcEdeAYiMg7FXvEEvS9oq0/ENc3
 Px3f/f1lxJnFJ9LuTXXr+vdz3GBsEIZihgH6TlKG3uKH6P/wdoALy5JUMVckMXWy
 xSOQ1g6WAhHER8gwrGw70L/niXTZ+2V0ldEQFUqU3J/0Z1IsYcpmidryh0z86ndx
 /De68kRdwtyn7IziteHsFlhIjr81lvA4hKylYiOvcArZOz9CVMCuOdjpLmyAlkwg
 ==
Received: from ppma12.dal12v.mail.ibm.com
 (dc.9e.1632.ip4.static.sl-reverse.com [50.22.158.220])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4gmw5duymv-1
 (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
 Mon, 14 Sep 2026 21:27:40 +0000 (GMT)
Received: from pps.filterd (ppma12.dal12v.mail.ibm.com [127.0.0.1])
 by ppma12.dal12v.mail.ibm.com (8.18.1.11/8.18.1.11) with ESMTP id
 68EJc9B42848914; Mon, 14 Sep 2026 21:27:39 GMT
Received: from smtprelay05.dal12v.mail.ibm.com ([172.16.1.7])
 by ppma12.dal12v.mail.ibm.com (PPS) with ESMTPS id 4gnh2q0ecq-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Mon, 14 Sep 2026 21:27:39 +0000 (GMT)
Received: from smtpav04.wdc07v.mail.ibm.com (smtpav04.wdc07v.mail.ibm.com
 [10.39.53.231])
 by smtprelay05.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 68ELRcGr5833244
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Mon, 14 Sep 2026 21:27:38 GMT
Received: from smtpav04.wdc07v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 5FE1058050;
 Mon, 14 Sep 2026 21:27:38 +0000 (GMT)
Received: from smtpav04.wdc07v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 7689658045;
 Mon, 14 Sep 2026 21:27:37 +0000 (GMT)
Received: from [9.61.249.108] (unknown [9.61.249.108])
 by smtpav04.wdc07v.mail.ibm.com (Postfix) with ESMTP;
 Mon, 14 Sep 2026 21:27:37 +0000 (GMT)
Message-ID: <9aded4ae-512f-4b54-9421-02cb1f973ec0@linux.ibm.com>
Date: Mon, 14 Sep 2026 14:27:36 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1] s390x/pci: fix DMA slot leak on I/O TLB entry
 replacement
To: Omar Elghoul <oelghoul@linux.ibm.com>, qemu-devel@nongnu.org,
 qemu-s390x@nongnu.org
Cc: mjrosato@linux.ibm.com, farman@linux.ibm.com, cohuck@redhat.com,
 qemu-stable@nongnu.org
References: <20260910132408.12707-1-oelghoul@linux.ibm.com>
Content-Language: en-US
From: Farhan Ali <alifm@linux.ibm.com>
In-Reply-To: <20260910132408.12707-1-oelghoul@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTE0MDMwMSBTYWx0ZWRfX4XjWGqvUCjfm
 ymtm7lyTggG8nKC8Ctio+amR86iGLYk//YB3HfFTmA3zINr2DvrQoPZAtRIR6nbs/VkHwdNFFF4
 5yFDNxuxv9mEGZdgkhZ6TmMQQGPoQ+go2dnHRVsH3AOzE8Dhy0ecGhpLoq7bNaBzNz2SPJglab6
 0j4Iax4XSR4WiAJGJQe0BaxaKlFGuI8QOvphHiw+gtOiKTOvvePdqqVVscYP7dZEU0t8wTTEN2M
 CP4g/AYRMKSKO847ZwoqVyUnI0jj4FCFdbfk9u6nefQNd3LC8MREvYNz9F8FDRGKfnvUg4U+Ns1
 kMm7oq19vTQ9SucyGEWMN/m4mvjzFtZju8UH0U5fPUBZvWTqy4XHTntOQjkF4nYJRwvX+ieRAPI
 eTnzWcsN7FdUtA8zU1N42lHsy00ui19ERtGz2KyxM0Ruzr/6bfUsWxbDvBsgAgQ3Y21mMV2U+q3
 BA1lwhDSwxBOaBvvNlA==
X-Authority-Analysis: v=2.4 cv=E/NYNqdl c=1 sm=1 tr=0 ts=6aa866cc cx=c_pps
 a=bLidbwmWQ0KltjZqbj+ezA==:117 a=bLidbwmWQ0KltjZqbj+ezA==:17
 a=IkcTkHD0fZMA:10 a=VdqzKS8jKosA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=V8glGbnc2Ofi9Qvn3v5h:22 a=69wJf7TsAAAA:8
 a=VnNF1IyMAAAA:8 a=XR-q1PLIzIBSuUykN8wA:9 a=QEXdDO2ut3YA:10
 a=Fg1AiH1G6rFz08G2ETeA:22
X-Proofpoint-ORIG-GUID: 8_lFbTiaF8RFdTAp1PHGF7CWwhJnGStt
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTE0MDMwMSBTYWx0ZWRfX+3wPOFevz7NG
 Y2FhaL1Tc7fBivzEFvOhP9z+jE9gch5F1GGlOai5p48g2dpFllLSCDv/Ifb2xrm8F/ycxPCnns4
 gbdWReiwLk8sY/YLfo0fQk8vzrJXqr4=
X-Proofpoint-GUID: 8_lFbTiaF8RFdTAp1PHGF7CWwhJnGStt
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-14_04,2026-09-14_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 lowpriorityscore=0 priorityscore=1501 spamscore=0
 adultscore=0 clxscore=1015 bulkscore=0 malwarescore=0 suspectscore=0
 phishscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2609040000
 definitions=main-2609140301
Received-SPF: pass client-ip=148.163.158.5; envelope-from=alifm@linux.ibm.com;
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


On 9/10/2026 6:24 AM, Omar Elghoul wrote:
> When s390_pci_update_iotlb() does a mapping update for an IOVA that has
> an already-existing TLB entry with different permissions or translated
> address, it unmaps then remaps it. However, at the end of the map path,
> it unconditionally decrements the available DMA slot counter without a
> corresponding increment in the intermediate unmap branch.
>
> This causes the DMA slot count to be decremented on every remapping of
> an active IOVA, leading to a permanent DMA slot leak. This remapping
> without a prior invalidation and sync is not seen today in well-behaved
> guests but is allowed by the architecture. Fix it by only decrementing
> available DMA slots when inserting a brand new mapping.
>
> Cc: qemu-stable@nongnu.org
> Fixes: 37fa32de70 ("s390x/pci: Honor DMA limits set by vfio")
> Signed-off-by: Omar Elghoul <oelghoul@linux.ibm.com>
> ---
>   hw/s390x/s390-pci-inst.c | 4 +++-
>   1 file changed, 3 insertions(+), 1 deletion(-)
>
> diff --git a/hw/s390x/s390-pci-inst.c b/hw/s390x/s390-pci-inst.c
> index b7de23c7d2..5840675aba 100644
> --- a/hw/s390x/s390-pci-inst.c
> +++ b/hw/s390x/s390-pci-inst.c
> @@ -665,6 +665,9 @@ static uint32_t s390_pci_update_iotlb(S390PCIIOMMU *iommu,
>               memory_region_notify_iommu(&iommu->iommu_mr, 0, event);
>               event.type = IOMMU_NOTIFIER_MAP;
>               event.entry.perm = entry->perm;
> +        } else {
> +            /* only new mappings consume DMA slots */
> +            dec_dma_avail(iommu);
>           }
To me the else statement here makes it a little more confusing. I think 
it would be easier to read, if we increment above when do the unmap in 
the intermediate step. That way we associate incrementing the available 
entries with unmap and decrementing it with map operation. But I guess 
this avoids an additional function call for the same result.

Reviewed-by: Farhan Ali <alifm@linux.ibm.com>

>   
>           cache = g_new(S390IOTLBEntry, 1);
> @@ -673,7 +676,6 @@ static uint32_t s390_pci_update_iotlb(S390PCIIOMMU *iommu,
>           cache->len = TARGET_PAGE_SIZE;
>           cache->perm = entry->perm;
>           g_hash_table_replace(iommu->iotlb, &cache->iova, cache);
> -        dec_dma_avail(iommu);
>       }
>   
>       /*

