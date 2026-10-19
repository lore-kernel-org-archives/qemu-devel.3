Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5442D606A319
	for <qemu-devel@archiver.kernel.org>; Mon, 19 Oct 2026 19:34:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=qzOrNqkb
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xIt7f-0008KN-99; Mon, 19 Oct 2026 15:34:15 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <oelghoul@linux.ibm.com>)
 id 1xIt7Y-0008Hz-EG; Mon, 19 Oct 2026 15:34:10 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <oelghoul@linux.ibm.com>)
 id 1xIt7W-0004D8-KA; Mon, 19 Oct 2026 15:34:08 -0400
Received: from pps.filterd (m0360072.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 69JJEb0t450032; Mon, 19 Oct 2026 19:34:04 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=pp1; bh=Xd/934
 HG/giV+9uQkJHCGycpfj4IDOl6+5vOBCwuX74=; b=qzOrNqkbgNBGGrPiqgZONj
 fOoj6ojEWE0Lq6KEjDGMArNfs9J2GYaMxs07kpvW14IdzdCK3vTPnGJ2wJMPl9Z/
 8XAxcnxkta/q0yq0kC4MtvhV/MBGXgIhFjSqPVkwnRHEaryIohtTnqXTkcq8V0jU
 gijqQxUuauypcSC/URBOTNGuV//5a/e303OxFTaoLZUtSgmx6f4q6zRVMKge0S2+
 YUvVPddVvGgmjsPsfzcj8xqeAH74czY+9WtQBYIvaSpqzFEVGKuBuwwocsh7mhrV
 wJ4yiF/Pieh35eqq+K9RBhcfAkMtLbB6y7WG32Ma3BP16oEKPc4I65GcVglOSnJg
 ==
Received: from ppma12.dal12v.mail.ibm.com
 (dc.9e.1632.ip4.static.sl-reverse.com [50.22.158.220])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4hc0nvvap1-1
 (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
 Mon, 19 Oct 2026 19:34:04 +0000 (GMT)
Received: from pps.filterd (ppma12.dal12v.mail.ibm.com [127.0.0.1])
 by ppma12.dal12v.mail.ibm.com (8.18.1.11/8.18.1.11) with ESMTP id
 69JJKFBv374338; Mon, 19 Oct 2026 19:34:03 GMT
Received: from smtprelay05.dal12v.mail.ibm.com ([172.16.1.7])
 by ppma12.dal12v.mail.ibm.com (PPS) with ESMTPS id 4hckbq7bbx-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Mon, 19 Oct 2026 19:34:03 +0000 (GMT)
Received: from smtpav04.dal12v.mail.ibm.com (smtpav04.dal12v.mail.ibm.com
 [10.241.53.103])
 by smtprelay05.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 69JJY2kA31457866
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Mon, 19 Oct 2026 19:34:02 GMT
Received: from smtpav04.dal12v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 943C158056;
 Mon, 19 Oct 2026 19:34:02 +0000 (GMT)
Received: from smtpav04.dal12v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 0019A5805A;
 Mon, 19 Oct 2026 19:34:01 +0000 (GMT)
Received: from [9.61.242.107] (unknown [9.61.242.107])
 by smtpav04.dal12v.mail.ibm.com (Postfix) with ESMTPS;
 Mon, 19 Oct 2026 19:34:01 +0000 (GMT)
Message-ID: <81412620-9c0f-4539-bc1e-371538ef1da4@linux.ibm.com>
Date: Mon, 19 Oct 2026 15:34:01 -0400
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] s390x/pci: re-fetch DMA slot shadow count from VFIO
 upon IOMMU disable
To: Matthew Rosato <mjrosato@linux.ibm.com>, qemu-devel@nongnu.org,
 qemu-s390x@nongnu.org
Cc: alifm@linux.ibm.com, cam@linux.ibm.com, farman@linux.ibm.com,
 qemu-stable@nongnu.org
References: <20261019153729.40823-1-oelghoul@linux.ibm.com>
 <5e9b8aa7-c157-43cd-99b1-7afecda27cd1@linux.ibm.com>
Content-Language: en-US
From: Omar Elghoul <oelghoul@linux.ibm.com>
In-Reply-To: <5e9b8aa7-c157-43cd-99b1-7afecda27cd1@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDE5MDA3NiBTYWx0ZWRfX/SOZuc77bxiK
 frAXxsHEHe/kSkV0d/sdyK9yW4wBs8IgwBMKm6ggfqmxSHBvMDvL116vpCdWgb5NAm//eIlJtVU
 ms4XawRX4wE6E2XC+r4SZad2YsThKwM=
X-Proofpoint-ORIG-GUID: RyRJUM7GONIs-sQ9gcb2zpAzrJSK8jIY
X-Proofpoint-GUID: RyRJUM7GONIs-sQ9gcb2zpAzrJSK8jIY
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDE5MDA3NiBTYWx0ZWRfXxyoXgN0O2tcA
 q5dw98T19gVMIUk5u9+aKq2ZP1rjCD7qVXLIs03gAg2cHgZurESawAo7jy3FiEiubWfXAJVfdLB
 Wt7SeVYKE/o78NRhd019wWr/myvVFNnImcirvwmh/2unCEEyQmzi1up96zIng2Uy3cxeiR37H5c
 lwCrj8GlEsMFb8UHhYXTakjicaFz93p8XpT7+5VmXwfmhx6bpiB2vAZwv6P4VoCNm2a+iVo9NhH
 jO1q65DVL4JBbVZ/SM//WraZrbH3jcPa/koIKb52ppCQDCcphmaJQ2EZE24GHb81Y3FRPVmziwk
 apg0a9jUkXnsl8lG93w4HSHLZQCDHjS4ps9ZcELDqSfyWlK6MP7VFEIYsqbfcn1hy3vsCvHsSKz
 lF8EqFP2FhqX6BM+ZF6tAOgpsZ8FodikHwolWv6lsmjNkGp2GZMcT/rmGQWksd+gFZW02KJKJW+
 OVXbRS3gv5MCU584Dwg==
X-Authority-Analysis: v=2.4 cv=MY35KJ/f c=1 sm=1 tr=0 ts=6ad670ac cx=c_pps
 a=bLidbwmWQ0KltjZqbj+ezA==:117 a=bLidbwmWQ0KltjZqbj+ezA==:17
 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=RzCfie-kr_QcCd8fBx8p:22 a=69wJf7TsAAAA:8
 a=VnNF1IyMAAAA:8 a=L8ZlNmyXYivIpPH0CNMA:9 a=QEXdDO2ut3YA:10
 a=Fg1AiH1G6rFz08G2ETeA:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-19_05,2026-10-19_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 adultscore=0 suspectscore=0 malwarescore=0 lowpriorityscore=0
 clxscore=1015 impostorscore=0 bulkscore=0 priorityscore=1501 spamscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2610080000 definitions=main-2610190076
Received-SPF: pass client-ip=148.163.158.5;
 envelope-from=oelghoul@linux.ibm.com; helo=mx0b-001b2d01.pphosted.com
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

On 10/19/26 3:18 PM, Matthew Rosato wrote:
> On 10/19/26 11:37 AM, Omar Elghoul wrote:
>> s390_pci_iommu_disable() destroys the I/O TLB and unpins the host's
>> mappings, but it doesn't reset the available DMA slot counter back to
>> the VFIO-advertised limit. This is problematic when an IOMMU is disabled
>> and re-enabled while reusing the container (e.g. during a guest reboot),
>> which may cause the RPCIT path to fail with DMA slot exhaustion errors,
>> manifesting as unexplained ENOMEMs in the guest.
>>
>> Fix it by refactoring s390_pci_update_dma_avail() to take a pointer to
>> S390PCIBusDevice instead of the plain file descriptor. Call it in
>> s390_pci_iommu_disable() after the host mappings have been unpinned.
>>
>> Further print a warning if the VFIO-advertised counter doesn't match the
>> in-use shadow counter, to reduce the likelihood of introducing new
> 
> Maybe something like 'doesn't match the previously-stashed limit' ?

Sure.

> 
>> similar DMA accounting bugs in the future.
>>
>> Cc: qemu-stable@nongnu.org
>> Fixes: 37fa32de7073 ("s390x/pci: Honor DMA limits set by vfio")
>> Signed-off-by: Omar Elghoul <oelghoul@linux.ibm.com>
>> ---
>> v1 -> v2: rebase on latest master, ensure that the device is a vfio-pci
>> device before calling vfio-specific code.
>> ---
>>   hw/s390x/s390-pci-bus.c          | 21 +++++++++++++++++++++
>>   hw/s390x/s390-pci-vfio-stubs.c   |  2 +-
>>   hw/s390x/s390-pci-vfio.c         | 18 ++++++++++++------
>>   include/hw/s390x/s390-pci-vfio.h |  2 +-
>>   4 files changed, 35 insertions(+), 8 deletions(-)
>>
>> diff --git a/hw/s390x/s390-pci-bus.c b/hw/s390x/s390-pci-bus.c
>> index 2724b27ec2..9938191c4d 100644
>> --- a/hw/s390x/s390-pci-bus.c
>> +++ b/hw/s390x/s390-pci-bus.c
>> @@ -825,6 +825,8 @@ void s390_pci_iommu_direct_map_enable(S390PCIBusDevice *pbdev)
>>   void s390_pci_iommu_disable(S390PCIBusDevice *pbdev)
>>   {
>>       S390PCIIOMMU *iommu = pbdev->iommu;
>> +    unsigned int dma_avail;
>> +
>>       pbdev->iommu_enabled = false;
>>       g_hash_table_remove_all(pbdev->iotlb);
>>       if (pbdev->dm_mr) {
>> @@ -837,6 +839,25 @@ void s390_pci_iommu_disable(S390PCIBusDevice *pbdev)
>>                                       MEMORY_REGION(&pbdev->iommu_mr));
>>           object_unparent(OBJECT(&pbdev->iommu_mr));
>>       }
>> +
>> +    /*
>> +     * update shadow counter from vfio after having unpinned all host mappings.
>> +     * if this value mismatches our previous shadow count, then we likely have
>> +     * DMA remapping, unmapping, or accounting bugs
> 
> comment nit: This is related to the commit message -- we aren't looking
> at the previous shadow count here (dma_limit->avail) but rather at the
> previously stashed limit (max_dma_limit) to make sure the vfio count got
> back to the value we expected.
> 
>> +     */
>> +    if (object_dynamic_cast(OBJECT(pbdev->pdev), "vfio-pci")) {
> 
> Could you just check for if (pbev->dma_avail) here?
> 
> We should only have that if s390_pci_start_dma_count() was called
> successfully, and that should only happen for a vfio-pci device.

That works too, I just thought it'd make sense to explicitly check for
the "vfio-pci" cast since the same file already does that in another
place.

> 
>> +        if (s390_pci_update_dma_avail(pbdev, &dma_avail)) {
>> +            if (pbdev->max_dma_limit != dma_avail) {
>> +                warn_report("DMA limit %u from vfio != %" PRIu64 " shadowed",
>> +                            dma_avail, pbdev->max_dma_limit);
>> +                pbdev->max_dma_limit = dma_avail;
>> +            }
>> +
>> +            if (pbdev->dma_limit) {
> 
> Then you also don't need this check.
> 
>> +                pbdev->dma_limit->avail = dma_avail;
>> +            }
>> +        }
>> +    }
>>   }


