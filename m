Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8FA56CA5FFC
	for <qemu-devel@archiver.kernel.org>; Wed,  7 Oct 2026 17:36:06 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xEVYX-0001CO-PH; Wed, 07 Oct 2026 13:35:53 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <farman@linux.ibm.com>)
 id 1xEVYW-0001Bm-7C; Wed, 07 Oct 2026 13:35:52 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <farman@linux.ibm.com>)
 id 1xEVYU-0004Ed-EW; Wed, 07 Oct 2026 13:35:51 -0400
Received: from pps.filterd (m0353725.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 697F5d2r1633855; Wed, 7 Oct 2026 17:35:46 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=pp1; bh=n5AxeT
 xoxb9IQrBdlOflYdoSCyu+CvSkRXvw65+6z/Q=; b=nQvAfRwsq6RbWvq7B9WhM8
 A0K0rIiQWSuOz5IL1ZBC1gZxg3OIGvC29OcinJWrKoXtpq3eWuraXmf0xspJ4QzU
 jw6xsCXdp72jpvVeMtWVhOg6iqbMeCZbstF6MpEbncpRMqnJCCDdmFttKJaUANAf
 YRxmIrd1cN1mi6C25yIWhpoy9B2Pm7d+vNmu5RMesjvbfKiXXjua+5FhINnWFiH6
 eodC6NG51WJmjM0KeXz/DbzgMa9P86iMhBu3chufn9VzWSj97TN5e2bEgQLjry5u
 T1otLsBsxQwn8g5NBq9GSEGW/USOUxrRFD6+BwIs6TAlzVUrhcVtWVNo6VkGYSVQ
 ==
Received: from ppma21.wdc07v.mail.ibm.com
 (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4h2r4g625p-1
 (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
 Wed, 07 Oct 2026 17:35:46 +0000 (GMT)
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
 by ppma21.wdc07v.mail.ibm.com (8.18.1.11/8.18.1.11) with ESMTP id
 697F2YqP2022581; Wed, 7 Oct 2026 17:35:46 GMT
Received: from smtprelay04.dal12v.mail.ibm.com ([172.16.1.6])
 by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4h58d5kw63-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Wed, 07 Oct 2026 17:35:46 +0000 (GMT)
Received: from smtpav01.dal12v.mail.ibm.com (smtpav01.dal12v.mail.ibm.com
 [10.241.53.100])
 by smtprelay04.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 697HZjRJ32244240
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Wed, 7 Oct 2026 17:35:45 GMT
Received: from smtpav01.dal12v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id E9D4B58057;
 Wed,  7 Oct 2026 17:35:44 +0000 (GMT)
Received: from smtpav01.dal12v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 1FF8658058;
 Wed,  7 Oct 2026 17:35:44 +0000 (GMT)
Received: from [9.61.5.156] (unknown [9.61.5.156])
 by smtpav01.dal12v.mail.ibm.com (Postfix) with ESMTP;
 Wed,  7 Oct 2026 17:35:44 +0000 (GMT)
Message-ID: <3eb02742-7eaa-4b6e-921d-5df0bd5b74a6@linux.ibm.com>
Date: Wed, 7 Oct 2026 13:35:43 -0400
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v12 00/17] s390x/pci: Implement migration for emulated
 devices
To: Konstantin Shkolnyy <kshk@linux.ibm.com>, mjrosato@linux.ibm.com
Cc: alifm@linux.ibm.com, richard.henderson@linaro.org, iii@linux.ibm.com,
 david@kernel.org, cohuck@redhat.com, pasic@linux.ibm.com,
 borntraeger@linux.ibm.com, qemu-s390x@nongnu.org, qemu-devel@nongnu.org
References: <20261006001643.420929-1-kshk@linux.ibm.com>
Content-Language: en-US
From: Eric Farman <farman@linux.ibm.com>
Autocrypt: addr=farman@linux.ibm.com; keydata=
 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
 y8m0x6unNti2MZIUMy0m2gcE
In-Reply-To: <20261006001643.420929-1-kshk@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Authority-Analysis: v=2.4 cv=TOPQ2Fla c=1 sm=1 tr=0 ts=6ac682f2 cx=c_pps
 a=GFwsV6G8L6GxiO2Y/PsHdQ==:117 a=GFwsV6G8L6GxiO2Y/PsHdQ==:17
 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=V8glGbnc2Ofi9Qvn3v5h:22 a=p0WdMEafAAAA:8
 a=VhT55RRkC2X4mMkaRA8A:9 a=QEXdDO2ut3YA:10
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDA3MDA3MCBTYWx0ZWRfXyOoFNst1LDpv
 vS5hUQ9q17qV+uoY4iys1uUjNv2n/zQI7BzvhYCH4lg/xDUVUGPAgGlnxOFIJ/qB+AHL+243lhq
 16F+VtJNyn8UGgu0Z+WlrtJvCvG6dZa8+7heDFKMf+nAMmcYI+zhcw/ZBtAqrOt261cVVYgG0F+
 AQxxUEpn+YziZdVoDmUPyuHr+k5WTzXI0ReCFzL06AL7HlZ1Rl2k0J5Loyfq6zMWhXocc2AhYlU
 ylH4gTncewbUiRIWWh7g5/wHXtvjrMt/xWTD4KelSnXw/XZePiPWFhhuO9Iaz82oLmZ3sAgm/JP
 grVHYXz9WPIs15Xv5o78UlkMb/yjG7waPIx5A1dx1aNP8n5LmWuWfpSeRnozYlE9egQ532LNyV3
 2LsmdUKxrgQ+haEs88JUdtsaXyuzuVVsx6OGTtjI/roSFDJ80u4rCdB80KoqqQ1gC3CJfmZAO0n
 SvgNhwsHLFbLuEcx7Sw==
X-Proofpoint-GUID: ctmJk6YRo0QWO8Bjhhun7PngUpIlqDDi
X-Proofpoint-ORIG-GUID: ctmJk6YRo0QWO8Bjhhun7PngUpIlqDDi
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDA3MDA3MCBTYWx0ZWRfX3kD7xJCspdEW
 d+M74sSVMLzc0r89ag/TvQqoRmd3wXl+aYr4xgl4K/yJyLlx8y7/EARdAQLd2p5j+2xA5tJh1Ym
 Ms9TxB1MtgNp74cWd04hbyQfcu8cyaY=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-07_05,2026-10-06_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 priorityscore=1501 spamscore=0 adultscore=0 clxscore=1015
 lowpriorityscore=0 impostorscore=0 bulkscore=0 phishscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2609040000 definitions=main-2610070070
Received-SPF: pass client-ip=148.163.158.5; envelope-from=farman@linux.ibm.com;
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



On 10/5/26 8:16 PM, Konstantin Shkolnyy wrote:
> ATTENTION! This series is built to apply on top of https://gitlab.com/efarman/qemu/-/tree/s390-next.
> 
> Up until now QEMU marked any zPCI device as "unmigratable."
> 
> This patch series adds support for migrating emulated devices, which are
> simpler to migrate. It leaves VFIO devices still unmigratable.
> 
> To enable migration, the device state needs to be saved/restored to/from
> the migration stream.
> 
> There are 2 kinds of emulated devices - those that use the zPCI IOMMU page
> table emulation in QEMU (e.g., Intel IGB NIC), and those that don't (virtio).
> This is important to note for testing purposes.
> 
> This change was tested on IGB, virtio-net and virtio-blk devices by running
> I/O on them while performing "virsh managedsave, virsh start" and also live
> migration to another host and back.
> 
> Changes in v12:
>   - patch 14: Add a message to an error path that didn't have it.
>   - patch 15: New. Extract here an isolated change from the next patch to make it smaller.
>   - patch 16 (formerly 15):
>     - Simplify error handling on s390_pci_ioat_validate() failure,
>     - Put an assert() with a comment into unreacheable branch.
> 
> Konstantin Shkolnyy (16):
>    s390x/pci: Create function to contain translation status check
>    s390x/pci: Move iommu_mr from S390PCIIOMMU to S390PCIBusDevice
>    s390x/pci: Move dm_mr from S390PCIIOMMU to S390PCIBusDevice
>    s390x/pci: Move iotlb from S390PCIIOMMU to S390PCIBusDevice
>    s390x/pci: Remove a ptr to S390PCIBusDevice from S390PCIIOMMU
>    s390x/pci: Move/rename enabled from S390PCIIOMMU to S390PCIBusDevice
>    s390x/pci: Move dma_limit from S390PCIIOMMU to S390PCIBusDevice
>    s390x/pci: Move g_iota from S390PCIIOMMU to S390PCIBusDevice
>    s390x/pci: Move pba from S390PCIIOMMU to S390PCIBusDevice
>    s390x/pci: Move pal from S390PCIIOMMU to S390PCIBusDevice
>    s390x/pci: Move max_dma_limit from S390PCIIOMMU to S390PCIBusDevice
>    s390x/pci: Add a comment explaining S390PCIIOMMU purpose
>    s390x/pci: Move ioat sanity checks into new function, add error
>      message
>    s390x/pci: Provide each zpci device with a unique stable bus "path"
>    s390x/pci: Implement migration for emulated devices
>    s390x/pci: Create function to contain fmb_timer start
> 
> Matthew Rosato (1):
>    s390x/pci: implement IOMMU replay
> 
>   hw/s390x/s390-pci-bus.c          | 528 +++++++++++++++++++++++++++----
>   hw/s390x/s390-pci-inst.c         | 174 +++++-----
>   hw/s390x/s390-pci-vfio.c         |   4 +-
>   hw/s390x/s390-virtio-ccw.c       |   4 +
>   include/hw/s390x/s390-pci-bus.h  |  43 ++-
>   include/hw/s390x/s390-pci-inst.h |   7 +-
>   6 files changed, 611 insertions(+), 149 deletions(-)
> 

Applied to the s390x queue for 11.2; thank you!

