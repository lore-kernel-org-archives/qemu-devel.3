Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 70F55C98314
	for <qemu-devel@archiver.kernel.org>; Thu, 24 Sep 2026 07:40:50 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x9e3w-0008PX-MM; Thu, 24 Sep 2026 03:40:12 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <borntraeger@linux.ibm.com>)
 id 1x9e3u-0008PD-JT; Thu, 24 Sep 2026 03:40:10 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <borntraeger@linux.ibm.com>)
 id 1x9e3s-0001R6-DR; Thu, 24 Sep 2026 03:40:10 -0400
Received: from pps.filterd (m0353725.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 68O5bjCd160510; Thu, 24 Sep 2026 07:40:02 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=pp1; bh=eazG8m
 p1Ym36SDOkZZGGXMEJXmza56Gt1RntxXo2660=; b=BC5ZkcDUwR1ror7l8Ir7mB
 O0t+VpRzZR+F5JFhkynPmaK8rkx1FKKgImeQvVZVnPvY3lx0gNjIDRPQzcn3QPzq
 j34A8Ra5yo+32q3tNmc1vgW5keAw92C0+WsPgUTYRve6wsYVmFxBH2nXMc1eSJS9
 QjEKbLDEFARx/YzN/7wHRoTdWMCz9w/1Cmi4qKeNEquv26iItD+dTcXDnDsl4f56
 5yAltfV1NABnrvwIdDrxSmCk7yyKJG/LgbglS6Xw7Ed8jNUO1LEKE1yN3uuB3oYF
 X9OQzhJf5GBbh+46HO2j/c/erAffykpQuRHPHg2JYLoTESWDsENYUUGnrEuTennA
 ==
Received: from ppma22.wdc07v.mail.ibm.com
 (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4gskgqpxj3-1
 (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
 Thu, 24 Sep 2026 07:40:02 +0000 (GMT)
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
 by ppma22.wdc07v.mail.ibm.com (8.18.1.11/8.18.1.11) with ESMTP id
 68O5lkBw1497480; Thu, 24 Sep 2026 07:40:02 GMT
Received: from smtprelay01.fra02v.mail.ibm.com ([9.218.2.227])
 by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4gvbu8vhk4-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 24 Sep 2026 07:40:01 +0000 (GMT)
Received: from smtpav07.fra02v.mail.ibm.com (smtpav07.fra02v.mail.ibm.com
 [10.20.54.106])
 by smtprelay01.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 68O7dvaC44892586
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Thu, 24 Sep 2026 07:39:58 GMT
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id E2BF820043;
 Thu, 24 Sep 2026 07:39:57 +0000 (GMT)
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id ABBFB20040;
 Thu, 24 Sep 2026 07:39:57 +0000 (GMT)
Received: from [9.224.77.173] (unknown [9.224.77.173])
 by smtpav07.fra02v.mail.ibm.com (Postfix) with ESMTP;
 Thu, 24 Sep 2026 07:39:57 +0000 (GMT)
Message-ID: <475a2156-1e65-4dbd-a2a5-39ef820370b0@linux.ibm.com>
Date: Thu, 24 Sep 2026 09:39:57 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v10 00/16] s390x/pci: Implement migration for emulated
 devices
To: Konstantin Shkolnyy <kshk@linux.ibm.com>, mjrosato@linux.ibm.com
Cc: alifm@linux.ibm.com, farman@linux.ibm.com, richard.henderson@linaro.org,
 iii@linux.ibm.com, david@kernel.org, cohuck@redhat.com,
 pasic@linux.ibm.com, qemu-s390x@nongnu.org, qemu-devel@nongnu.org
References: <20260923141518.960364-1-kshk@linux.ibm.com>
Content-Language: en-US
From: Christian Borntraeger <borntraeger@linux.ibm.com>
In-Reply-To: <20260923141518.960364-1-kshk@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Authority-Analysis: v=2.4 cv=G+OJgNk5 c=1 sm=1 tr=0 ts=6ab4d3d2 cx=c_pps
 a=5BHTudwdYE3Te8bg5FgnPg==:117 a=5BHTudwdYE3Te8bg5FgnPg==:17
 a=IkcTkHD0fZMA:10 a=VdqzKS8jKosA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=V8glGbnc2Ofi9Qvn3v5h:22 a=OScUsQlh_P5aP4YHqXgA:9
 a=QEXdDO2ut3YA:10
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTI0MDAzMiBTYWx0ZWRfX3Ude4B3y6kRm
 f6grYo5/7WkfJRCo0Y0GzIMpAA34nc7KlTquo89sEwt3155RHsfiQBYFGAa7vzPEs3zApxotzNH
 F8dPyTpCWNlqDwgvprzOwScPZsw1pjfoyx9f/W2tnwfX2RwIvPMkd39SmGbHcq5on/1crZHgYM9
 hS+/mcD9TbNi6cFvUyxLF9TLg3DJkBPS5Mi9otl6AuW6UJicCvjPqW4t8943y/7pR4i8Gb6VX4Y
 05hq6Lq/Wjgh4g2/sCChfoHXLDE8J0urc/INskjimKsmkED7NYC4kZGvkXMQlQ/d1+6SvBsKw3o
 IE2hMg+5u7QGK2yTsxBOhAwM7puc2OfJ8r7KdahJ4KyiWtpfwjz+Rexg1g8foPuReYyutnV6gQ9
 Rg56mmzxSMc0524PefYIfEtqSl64psNYEp+opjFQG1cCogBrc6r5ZDL2bDq5iTmFc1i1FxSnZHf
 FC9xJro68Ai40JANIZw==
X-Proofpoint-ORIG-GUID: pSBrOqJwOgKgjFwy7R8S03bS1ksXPjZC
X-Proofpoint-GUID: pSBrOqJwOgKgjFwy7R8S03bS1ksXPjZC
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTI0MDAzMiBTYWx0ZWRfX6TfiULZJ0X5k
 T4thqYoHWxM710dx/PRZ01RS673Q+5+FdELUdfPEYCF1GXuSz/jWtSvm9ady/IFNeoweIe7JNFW
 KaJY5/cEMwscXX8p+xF7K6kSVaON3Z8=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-24_02,2026-09-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 adultscore=0 phishscore=0 lowpriorityscore=0 impostorscore=0
 bulkscore=0 priorityscore=1501 clxscore=1015 spamscore=0 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2609040000 definitions=main-2609240032
Received-SPF: pass client-ip=148.163.158.5;
 envelope-from=borntraeger@linux.ibm.com; helo=mx0b-001b2d01.pphosted.com
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


m 23.09.26 um 16:15 schrieb Konstantin Shkolnyy:
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

Did you rebase the series on top of master? (does not look like)

> 
> Changes in v9:
v10?


In general the series looks pretty good to me but I am not that deep into pci.




>   - patch 1: update "Reviewed-by".
>   - patch 14: Fix NULL dereference on error path after s390_pci_ioat_validate().
>   - patch 15:
>     - add .needed to vmstate_s390_pcihost,
>     - add missing destruction steps after err_unlink_pbdev label.
> 
> Konstantin Shkolnyy (15):
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
>    s390x/pci: Factor ioat sanity checks into a separate function
>    s390x/pci: Implement migration for emulated devices
>    s390x/pci: Create function to contain fmb_timer start
> 
> Matthew Rosato (1):
>    s390x/pci: implement IOMMU replay
> 
>   hw/s390x/s390-pci-bus.c          | 463 +++++++++++++++++++++++++++----
>   hw/s390x/s390-pci-inst.c         | 164 ++++++-----
>   hw/s390x/s390-pci-vfio.c         |   4 +-
>   hw/s390x/s390-virtio-ccw.c       |   4 +
>   include/hw/s390x/s390-pci-bus.h  |  47 +++-
>   include/hw/s390x/s390-pci-inst.h |   7 +-
>   6 files changed, 546 insertions(+), 143 deletions(-)
> 


