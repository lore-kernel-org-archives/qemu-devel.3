Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 658C7C531C9
	for <qemu-devel@archiver.kernel.org>; Fri, 24 Jul 2026 19:38:25 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wnLiU-0006wV-9k; Fri, 24 Jul 2026 15:37:54 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjrosato@linux.ibm.com>)
 id 1wnLiP-0006vZ-21; Fri, 24 Jul 2026 15:37:49 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjrosato@linux.ibm.com>)
 id 1wnLiN-0002iP-4W; Fri, 24 Jul 2026 15:37:48 -0400
Received: from pps.filterd (m0356517.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 66OHBpkZ2448951; Fri, 24 Jul 2026 19:37:43 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=pp1; bh=c+lxGg
 SW6GS8GbBIdMUmwjkj+SuNRo5PBhhJSPx0ZJE=; b=BJAKVGhzpo7mydE/I5O9yy
 OKExSLFs6CDNjezYy0NsAzGt/NbYemBsuhu9Uk4sFATitH+VPDCSYHzPB7hMrYgv
 ecQWoV1hecYFBUIaIsP/NtHHFghUIPZdPcPlJSvEQe6xVSTJnWunwOCVTZP55lga
 d0L/Q9zNCkgWt8blzHkToSAaGUUN8q88ibAo5sXtXIjTtOcylbwSuixQ0iZRxb3F
 J/EMYI0XbRftdITUbXwQKqMMpoM5Ujo2Tb4lU4GdPP3l1J/f43+IseR4ZcxhyakA
 KlUXlW7ZgA3Mn+MchahpPbDR4ElPKejVwjEJfNk0nz5L3V1RP52Z/kyXlFFytlQQ
 ==
Received: from ppma23.wdc07v.mail.ibm.com
 (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4fm8h01n18-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Fri, 24 Jul 2026 19:37:42 +0000 (GMT)
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
 by ppma23.wdc07v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 66OJYkS4026283;
 Fri, 24 Jul 2026 19:37:41 GMT
Received: from smtprelay02.wdc07v.mail.ibm.com ([172.16.1.69])
 by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4fgnahjb36-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Fri, 24 Jul 2026 19:37:41 +0000 (GMT)
Received: from smtpav04.wdc07v.mail.ibm.com (smtpav04.wdc07v.mail.ibm.com
 [10.39.53.231])
 by smtprelay02.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 66OJbeM63146416
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Fri, 24 Jul 2026 19:37:40 GMT
Received: from smtpav04.wdc07v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 4DE6558050;
 Fri, 24 Jul 2026 19:37:40 +0000 (GMT)
Received: from smtpav04.wdc07v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 3EDC558045;
 Fri, 24 Jul 2026 19:37:39 +0000 (GMT)
Received: from [9.61.177.4] (unknown [9.61.177.4])
 by smtpav04.wdc07v.mail.ibm.com (Postfix) with ESMTP;
 Fri, 24 Jul 2026 19:37:39 +0000 (GMT)
Message-ID: <ac601753-088a-4412-bc4f-ef6e38dc381e@linux.ibm.com>
Date: Fri, 24 Jul 2026 15:37:38 -0400
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 01/15] s390x/pci: implement IOMMU replay
To: Farhan Ali <alifm@linux.ibm.com>, Konstantin Shkolnyy <kshk@linux.ibm.com>
Cc: richard.henderson@linaro.org, iii@linux.ibm.com, david@kernel.org,
 cohuck@redhat.com, pasic@linux.ibm.com, borntraeger@linux.ibm.com,
 qemu-s390x@nongnu.org, qemu-devel@nongnu.org
References: <20260724030919.123733-1-kshk@linux.ibm.com>
 <20260724030919.123733-2-kshk@linux.ibm.com>
 <74c3efe9-41e4-4db1-a1b3-f0ceb48809a3@linux.ibm.com>
Content-Language: en-US
From: Matthew Rosato <mjrosato@linux.ibm.com>
In-Reply-To: <74c3efe9-41e4-4db1-a1b3-f0ceb48809a3@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Authority-Analysis: v=2.4 cv=LdcMLDfi c=1 sm=1 tr=0 ts=6a63bf06 cx=c_pps
 a=3Bg1Hr4SwmMryq2xdFQyZA==:117 a=3Bg1Hr4SwmMryq2xdFQyZA==:17
 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=U7nrCbtTmkRpXpFmAIza:22 a=VnNF1IyMAAAA:8
 a=wPmpbpISL6QTYvSmE8QA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
X-Proofpoint-ORIG-GUID: jxjP4_iQ4zbv9cgNLc6-JCM1y4sTMGOE
X-Proofpoint-GUID: jxjP4_iQ4zbv9cgNLc6-JCM1y4sTMGOE
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzI0MDE3MyBTYWx0ZWRfXzuSbfxG+RGJb
 XRSR4VF6HeCcuygW2PpsESD/tZNwruj6T1Pz/1TtdvzXo7u0HIpD1M7iQOSjRw3g9CqTNGCxaSJ
 pLnbFRUKAIKp3RfZ+pBEJ0xulfvEvjaLasA0GV3cA8mi80bEEalSiLzOUvsp5z9H8AjH+UKWEi+
 wSDqJO77MP883TSqEAnO38qiD3LjCCTdnK1XCs3IhQGbl6yDa6DYFp10Wwk3av+//pkhOfVpMaA
 2yMrt8Fg0SPYnPgI5in+WE8iq0iBOjrDzEdfvR9Y9FItXFRI8NSAVM1bYn0HDvqv+RCE+gFXLsE
 NCj7cT9Z2USsDXd0VfiMvVE0ILQ9TGXmpALgwRA843n0x0setxqinDApCQ97C9inqxE4/79Ybh+
 uJZteo3NVoOTvw5CJLjOJFfigP3Fg7V2EV0b7sgriIildlm+G14cjpiN3FN5IcQltpJPir7BuBM
 F7qqIcFhma7pVB+R+tQ==
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzI0MDE3MyBTYWx0ZWRfX6NGELaU9j7UH
 6YmM/FnTXqIzAi/HKZSRWUJSp6zqzOGTdChU9dI4BvTDK1lQY571ILuF580Lx+Ko6kNxyyQ5mFz
 gdks/+/GnQ0fekqWKIWWN1nIARKLo2g=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-24_04,2026-07-24_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 suspectscore=0 lowpriorityscore=0 spamscore=0 malwarescore=0
 clxscore=1015 adultscore=0 priorityscore=1501 phishscore=0 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607240173
Received-SPF: pass client-ip=148.163.156.1;
 envelope-from=mjrosato@linux.ibm.com; helo=mx0a-001b2d01.pphosted.com
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

On 7/24/26 3:10 PM, Farhan Ali wrote:
> 
> On 7/23/2026 8:09 PM, Konstantin Shkolnyy wrote:
>> From: Matthew Rosato <mjrosato@linux.ibm.com>
>>
>> There are a few scenarios where IOMMU replay can potentially be needed
>> for zPCI device, namely VFIO device reset scenarios where the guest
>> continues running and expects the contents of its IOMMU to be replayed
>> upon IOAT re-registration and migration scenarios where the destination
>> must reconstruct the IOMMU on the destination.
>>
>> zPCI migration is not supported yet, but the IOMMU replay function is
>> implemented so that it can be called both from IOMMUMemoryRegionClass
>> now and migration post_load later.
>>
>> Signed-off-by: Matthew Rosato <mjrosato@linux.ibm.com>
>> Signed-off-by: Konstantin Shkolnyy <kshk@linux.ibm.com>
>> ---
>>   hw/s390x/s390-pci-bus.c          | 62 ++++++++++++++++++++++++++++----
>>   hw/s390x/s390-pci-inst.c         |  4 +--
>>   include/hw/s390x/s390-pci-inst.h |  1 +
>>   3 files changed, 59 insertions(+), 8 deletions(-)
>>
>> diff --git a/hw/s390x/s390-pci-bus.c b/hw/s390x/s390-pci-bus.c
>> index eff980fdfe..511926c151 100644
>> --- a/hw/s390x/s390-pci-bus.c
>> +++ b/hw/s390x/s390-pci-bus.c
>> @@ -593,14 +593,64 @@ err:
>>       return ret;
>>   }
>>   -static void s390_pci_iommu_replay(IOMMUMemoryRegion *iommu,
>> +static void s390_pci_ioat_replay(S390PCIIOMMU *iommu)
>> +{
>> +    S390IOTLBEntry entry;
>> +    uint16_t error = 0;
>> +    uint32_t dma_avail;
>> +    hwaddr curr, end;
>> +
>> +    curr = iommu->pba;
>> +    end = iommu->pal;
>> +
>> +    if (iommu->dm_mr) {
>> +        /* If direct mapping is used, there are no guest tables to
>> replay */
>> +        return;
>> +    }
>> +
>> +    if (iommu->dma_limit) {
>> +        dma_avail = iommu->dma_limit->avail;
>> +    } else {
>> +        dma_avail = 1;
>> +    }
>> +
>> +    while (curr < end) {
>> +        error = s390_guest_io_table_walk(iommu->g_iota, curr, &entry);
>> +        if (error) {
>> +            pbdev->state = ZPCI_FS_ERROR;
> 
> This patch doesn't compile on its own. Trying to compile with just this
> patch gives the error:
> 
> i-bus.c.o -c ../hw/s390x/s390-pci-bus.c
> ../hw/s390x/s390-pci-bus.c: In function ‘s390_pci_ioat_replay’:
> ../hw/s390x/s390-pci-bus.c:620:13: error: ‘pbdev’ undeclared (first use
> in this function)
>   620 |             pbdev->state = ZPCI_FS_ERROR;
>       |             ^~~~~
> ../hw/s390x/s390-pci-bus.c:620:13: note: each undeclared identifier is
> reported only once for each function it appears in
> 
> This should be fixed to avoid breaking git bisectability.
> 
Oh, thanks for pointing this out.  Not sure what happened here, I
thought I wrote the new version and tested it independent of this
series, but maybe I did it on top where we get pbdev as an input to
s390_pci_ioat_replay() and then botched the rebase.  That sounds most
likely, but I can't find my working branch at this point.

In any event, doing a S390PCIBusDevice *pbdev = iommu->pbdev; upfront
would be the most straightforward solution, and then it will go away in
patch 3 to instead be replaced by S390PCIIOMMU *iommu = pbdev->iommu;

Konstantin, I can send you another version or you can do that yourself,
up to you.

Here's a diff against this patch of what I mean, with a little extra
defensive programming:

diff --git a/hw/s390x/s390-pci-bus.c b/hw/s390x/s390-pci-bus.c
index 511926c151..21bca4d787 100644
--- a/hw/s390x/s390-pci-bus.c
+++ b/hw/s390x/s390-pci-bus.c
@@ -595,6 +595,7 @@ err:

 static void s390_pci_ioat_replay(S390PCIIOMMU *iommu)
 {
+    S390PCIBusDevice *pbdev = iommu->pbdev;
     S390IOTLBEntry entry;
     uint16_t error = 0;
     uint32_t dma_avail;
@@ -603,7 +604,7 @@ static void s390_pci_ioat_replay(S390PCIIOMMU *iommu)
     curr = iommu->pba;
     end = iommu->pal;

-    if (iommu->dm_mr) {
+    if (iommu->dm_mr || !pbdev) {
         /* If direct mapping is used, there are no guest tables to
replay */
         return;
     }


