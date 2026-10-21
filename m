Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 51D21606A31A
	for <qemu-devel@archiver.kernel.org>; Wed, 21 Oct 2026 05:51:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=gbNDg/eq
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xJPE7-0004vQ-Fp; Wed, 21 Oct 2026 01:51:04 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <uverma@linux.ibm.com>)
 id 1xJPDu-0004ur-LT
 for qemu-devel@nongnu.org; Wed, 21 Oct 2026 01:50:51 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <uverma@linux.ibm.com>)
 id 1xJPDs-00011X-6i
 for qemu-devel@nongnu.org; Wed, 21 Oct 2026 01:50:50 -0400
Received: from pps.filterd (m0360072.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 69L5iJ4I357956; Wed, 21 Oct 2026 05:50:36 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=pp1; bh=jZg4bd
 FcdcT5G6kqYBh/XrphjCrMEmbvod49rbLprx4=; b=gbNDg/eqIW3PG6qc6ErEAQ
 Q4pvSQZCGDD0GOE6wW8uXoZPp6E/ic/FnsQ5wrAOj3e2jBKc5Z0ocuWIB+zcVswC
 sUNwC/OleHlmfXzzmrrHGqimeT0YxGyRyF4/NzhI/d+4djBmY7yeflL1UJ4gayGl
 6h73C35rIVgVe1deaQ3/v6+44qXncKajZehFcdeOPIBpQ3881/kLJSWIgSUpyzHr
 QhAuFmBiJBeuNjXsWK8ubwuDfPepOBPTTaHHhlHxJRQ4nYkHFQBnYLyWpznVqYn4
 k6U7FJ/P28WOnLXP3JtF6qqE0ktQKKTX95NNP4Ec4IxfjqR06ekoRRTEjA+dDI5g
 ==
Received: from ppma22.wdc07v.mail.ibm.com
 (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4hdw59xx0a-1
 (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
 Wed, 21 Oct 2026 05:50:35 +0000 (GMT)
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
 by ppma22.wdc07v.mail.ibm.com (8.18.1.11/8.18.1.11) with ESMTP id
 69L2YoAS2411414; Wed, 21 Oct 2026 05:50:35 GMT
Received: from smtprelay05.wdc07v.mail.ibm.com ([172.16.1.72])
 by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4hekdg8suj-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Wed, 21 Oct 2026 05:50:35 +0000 (GMT)
Received: from smtpav05.dal12v.mail.ibm.com (smtpav05.dal12v.mail.ibm.com
 [10.241.53.104])
 by smtprelay05.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 69L5oYTG1507974
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Wed, 21 Oct 2026 05:50:34 GMT
Received: from smtpav05.dal12v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id E434458056;
 Wed, 21 Oct 2026 05:50:33 +0000 (GMT)
Received: from smtpav05.dal12v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 1EB1A58052;
 Wed, 21 Oct 2026 05:50:29 +0000 (GMT)
Received: from [9.43.53.243] (unknown [9.43.53.243])
 by smtpav05.dal12v.mail.ibm.com (Postfix) with ESMTP;
 Wed, 21 Oct 2026 05:50:28 +0000 (GMT)
Message-ID: <8067b1be-fe2f-4f4d-b124-fa95f46a12ba@linux.ibm.com>
Date: Wed, 21 Oct 2026 11:22:24 +0530
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6 04/10] tests/qtest: Enable spapr dma with linear iommu
 map
To: Fabiano Rosas <farosas@suse.de>, Jishnu Warrier <jishnuvw@linux.ibm.com>, 
 qemu-devel@nongnu.org
Cc: npiggin@gmail.com, philmd@linaro.org, akihiko.odaki@daynix.com,
 mst@redhat.com, marcel.apfelbaum@gmail.com,
 david@gibson.dropbear.id.au, adityag@linux.ibm.com,
 harshpb@linux.ibm.com, amachhiw@linux.ibm.com
References: <20260817185539.376740-1-jishnuvw@linux.ibm.com>
 <20260817185539.376740-5-jishnuvw@linux.ibm.com> <875x17mcmh.fsf@suse.de>
Content-Language: en-US, en-ZM
From: Utkarsh Verma <uverma@linux.ibm.com>
In-Reply-To: <875x17mcmh.fsf@suse.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDIxMDAyMiBTYWx0ZWRfXwzORR55pV6rE
 ps4NVZZ103OqcQ2/9O1RhFPMeGLGa/MLoSwbLXbnIXI1lTsl75ZbdbxJwNOCwLo+Ae41q8PMIAd
 YKrLP+z4Ghlj94koqLYfW0QE25xzBE/bWIM0ohIt4PRhvPTPEAz63XFrLPXcKPRnRTgMc5U+tyS
 YjB0zdR5jCjVY2r2IZJpwrQXdWWg3gK0/kVuyqI5vXAXgFrJFrBL9F/JfPSzlQC7Kjeh6olaFIW
 vropy41i0K9FTa9Z+bTy3V7eXGCaQ2aXj/JKD5So3Ur7phM/NdfYuj5LJ2MaUxFOJPaxDUekDdh
 JypXe36OHN0l17mqVBAgv74hTLy7zpZaKFy1BLLHxi1Ys6B/0jJrqzftThyKHoWzpgyYyoglAAg
 DmisVz+yBU5yv0MLwJYGblsdK0H/C0qUU5woKngSORVgCZWHNqxC6fd7MvpdcuEdhdx7/NQeKOQ
 2ylaY0qqzZ9rxbuQtWA==
X-Proofpoint-ORIG-GUID: YU1I6XM1rj7g3eT7Nf-syWhji7GEDdQb
X-Proofpoint-GUID: gweM3sHX1nmX_OKNK2zAsTEfZuZaIvZp
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDIxMDAyMiBTYWx0ZWRfX04I7iYmybYUn
 JE3MifZ8Hc+yws1SJVkQ+TNZw3xikEr9anxyt75n5/t/4jH+vEvWz91hEKP/NozKoqf9+X37Iuq
 /fU9L3dmazaVcjLB22s/kIxB7U1hbWg=
X-Authority-Analysis: v=2.4 cv=ZfSIpcVA c=1 sm=1 tr=0 ts=6ad852ac cx=c_pps
 a=5BHTudwdYE3Te8bg5FgnPg==:117 a=5BHTudwdYE3Te8bg5FgnPg==:17
 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=RzCfie-kr_QcCd8fBx8p:22 a=VnNF1IyMAAAA:8
 a=pGLkceISAAAA:8 a=oF-HAATtKNVF3yOwGx8A:9 a=QEXdDO2ut3YA:10
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-21_02,2026-10-19_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 impostorscore=0 malwarescore=0 spamscore=0 suspectscore=0
 clxscore=1011 phishscore=0 bulkscore=0 lowpriorityscore=0 adultscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2610190000 definitions=main-2610210022
Received-SPF: pass client-ip=148.163.158.5; envelope-from=uverma@linux.ibm.com;
 helo=mx0b-001b2d01.pphosted.com
X-Spam_score_int: -26
X-Spam_score: -2.7
X-Spam_bar: --
X-Spam_report: (-2.7 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, RCVD_IN_DNSWL_LOW=-0.7,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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



On 8/19/26 1:20 AM, Fabiano Rosas wrote:
> Jishnu Warrier <jishnuvw@linux.ibm.com> writes:
> 
>> From: Nicholas Piggin <npiggin@gmail.com>
>>
>> qtests spapr dma was broken because the iommu was not set up.
>>
>> spapr requires hypercalls to set up the iommu (TCE tables), but
>> there is no support for that or a side-channel to the iommu in
>> qtests at the moment, so add a quick workaround in QEMU to have
>> the spapr iommu provide a linear map to memory when running
>> qtests.
>>
>> The buggy msix checks can all be removed since the tests all work
>> now.
>>
>> Reviewed-by: Fabiano Rosas <farosas@suse.de>
>> Signed-off-by: Nicholas Piggin <npiggin@gmail.com>
>> ---
>>   hw/ppc/spapr_iommu.c                 | 10 +++++++++-
>>   tests/qtest/e1000e-test.c            | 21 ---------------------
>>   tests/qtest/igb-test.c               | 21 ---------------------
>>   tests/qtest/libqos/generic-pcihost.c |  1 -
>>   tests/qtest/libqos/pci-pc.c          |  3 ---
>>   tests/qtest/libqos/pci-spapr.c       |  7 ++++---
>>   tests/qtest/libqos/pci.c             | 14 --------------
>>   tests/qtest/libqos/pci.h             |  4 ----
>>   tests/qtest/nvme-test.c              |  4 ----
>>   tests/qtest/vhost-user-blk-test.c    |  6 ------
>>   tests/qtest/virtio-blk-test.c        | 12 ------------
>>   11 files changed, 13 insertions(+), 90 deletions(-)
>>
>> diff --git a/hw/ppc/spapr_iommu.c b/hw/ppc/spapr_iommu.c
>> index e6264b07..5470602e 100644
>> --- a/hw/ppc/spapr_iommu.c
>> +++ b/hw/ppc/spapr_iommu.c
>> @@ -22,6 +22,8 @@
>>   #include "qemu/log.h"
>>   #include "qemu/module.h"
>>   #include "system/kvm.h"
>> +#include "system/qtest.h"
>> +#include "exec/target_page.h"
>>   #include "kvm_ppc.h"
>>   #include "migration/vmstate.h"
>>   #include "system/dma.h"
>> @@ -125,7 +127,13 @@ static IOMMUTLBEntry spapr_tce_translate_iommu(IOMMUMemoryRegion *iommu,
>>           .perm = IOMMU_NONE,
>>       };
>>   
>> -    if ((addr >> tcet->page_shift) < tcet->nb_table) {
>> +    if (qtest_enabled()) {
>> +        /* spapr qtests does not set up the IOMMU, shortcut a linear map */
>> +        ret.iova = addr & TARGET_PAGE_MASK;
>> +        ret.translated_addr = addr & TARGET_PAGE_MASK;
>> +        ret.addr_mask = ~TARGET_PAGE_MASK;
>> +        ret.perm = IOMMU_RW;
>> +    } else if ((addr >> tcet->page_shift) < tcet->nb_table) {
>>           /* Check if we are in bound */
>>           hwaddr page_mask = IOMMU_PAGE_MASK(tcet->page_shift);
>>   
>> diff --git a/tests/qtest/e1000e-test.c b/tests/qtest/e1000e-test.c
>> index de9738fd..8300bf5a 100644
>> --- a/tests/qtest/e1000e-test.c
>> +++ b/tests/qtest/e1000e-test.c
>> @@ -139,13 +139,6 @@ static void test_e1000e_tx(void *obj, void *data, QGuestAllocator * alloc)
>>   {
>>       QE1000E_PCI *e1000e = obj;
>>       QE1000E *d = &e1000e->e1000e;
>> -    QOSGraphObject *e_object = obj;
>> -    QPCIDevice *dev = e_object->get_driver(e_object, "pci-device");
>> -
>> -    /* FIXME: add spapr support */
>> -    if (qpci_check_buggy_msi(dev)) {
>> -        return;
>> -    }
>>   
>>       e1000e_send_verify(d, data, alloc);
>>   }
>> @@ -154,13 +147,6 @@ static void test_e1000e_rx(void *obj, void *data, QGuestAllocator * alloc)
>>   {
>>       QE1000E_PCI *e1000e = obj;
>>       QE1000E *d = &e1000e->e1000e;
>> -    QOSGraphObject *e_object = obj;
>> -    QPCIDevice *dev = e_object->get_driver(e_object, "pci-device");
>> -
>> -    /* FIXME: add spapr support */
>> -    if (qpci_check_buggy_msi(dev)) {
>> -        return;
>> -    }
>>   
>>       e1000e_receive_verify(d, data, alloc);
>>   }
>> @@ -173,13 +159,6 @@ static void test_e1000e_multiple_transfers(void *obj, void *data,
>>   
>>       QE1000E_PCI *e1000e = obj;
>>       QE1000E *d = &e1000e->e1000e;
>> -    QOSGraphObject *e_object = obj;
>> -    QPCIDevice *dev = e_object->get_driver(e_object, "pci-device");
>> -
>> -    /* FIXME: add spapr support */
>> -    if (qpci_check_buggy_msi(dev)) {
>> -        return;
>> -    }
>>   
>>       for (i = 0; i < iterations; i++) {
>>           e1000e_send_verify(d, data, alloc);
>> diff --git a/tests/qtest/igb-test.c b/tests/qtest/igb-test.c
>> index 3d397ea6..1b3b5aa6 100644
>> --- a/tests/qtest/igb-test.c
>> +++ b/tests/qtest/igb-test.c
>> @@ -142,13 +142,6 @@ static void test_igb_tx(void *obj, void *data, QGuestAllocator * alloc)
>>   {
>>       QE1000E_PCI *e1000e = obj;
>>       QE1000E *d = &e1000e->e1000e;
>> -    QOSGraphObject *e_object = obj;
>> -    QPCIDevice *dev = e_object->get_driver(e_object, "pci-device");
>> -
>> -    /* FIXME: add spapr support */
>> -    if (qpci_check_buggy_msi(dev)) {
>> -        return;
>> -    }
>>   
>>       igb_send_verify(d, data, alloc);
>>   }
>> @@ -157,13 +150,6 @@ static void test_igb_rx(void *obj, void *data, QGuestAllocator * alloc)
>>   {
>>       QE1000E_PCI *e1000e = obj;
>>       QE1000E *d = &e1000e->e1000e;
>> -    QOSGraphObject *e_object = obj;
>> -    QPCIDevice *dev = e_object->get_driver(e_object, "pci-device");
>> -
>> -    /* FIXME: add spapr support */
>> -    if (qpci_check_buggy_msi(dev)) {
>> -        return;
>> -    }
>>   
>>       igb_receive_verify(d, data, alloc);
>>   }
>> @@ -176,13 +162,6 @@ static void test_igb_multiple_transfers(void *obj, void *data,
>>   
>>       QE1000E_PCI *e1000e = obj;
>>       QE1000E *d = &e1000e->e1000e;
>> -    QOSGraphObject *e_object = obj;
>> -    QPCIDevice *dev = e_object->get_driver(e_object, "pci-device");
>> -
>> -    /* FIXME: add spapr support */
>> -    if (qpci_check_buggy_msi(dev)) {
>> -        return;
>> -    }
>>   
>>       for (i = 0; i < iterations; i++) {
>>           igb_send_verify(d, data, alloc);
>> diff --git a/tests/qtest/libqos/generic-pcihost.c b/tests/qtest/libqos/generic-pcihost.c
>> index b7761752..93cc3b85 100644
>> --- a/tests/qtest/libqos/generic-pcihost.c
>> +++ b/tests/qtest/libqos/generic-pcihost.c
>> @@ -182,7 +182,6 @@ void qpci_init_generic(QGenericPCIBus *qpci, QTestState *qts,
>>   
>>       qpci->gpex_pio_base = 0x3eff0000;
>>       qpci->bus.not_hotpluggable = !hotpluggable;
>> -    qpci->bus.has_buggy_msi = false;
>>   
>>       qpci->bus.pio_readb = qpci_generic_pio_readb;
>>       qpci->bus.pio_readw = qpci_generic_pio_readw;
>> diff --git a/tests/qtest/libqos/pci-pc.c b/tests/qtest/libqos/pci-pc.c
>> index 147009f4..8b79d858 100644
>> --- a/tests/qtest/libqos/pci-pc.c
>> +++ b/tests/qtest/libqos/pci-pc.c
>> @@ -124,9 +124,6 @@ void qpci_init_pc(QPCIBusPC *qpci, QTestState *qts, QGuestAllocator *alloc)
>>   {
>>       assert(qts);
>>   
>> -    /* tests can use pci-bus */
>> -    qpci->bus.has_buggy_msi = false;
>> -
>>       qpci->bus.pio_readb = qpci_pc_pio_readb;
>>       qpci->bus.pio_readw = qpci_pc_pio_readw;
>>       qpci->bus.pio_readl = qpci_pc_pio_readl;
>> diff --git a/tests/qtest/libqos/pci-spapr.c b/tests/qtest/libqos/pci-spapr.c
>> index 3723cbb3..b58cc1b5 100644
>> --- a/tests/qtest/libqos/pci-spapr.c
>> +++ b/tests/qtest/libqos/pci-spapr.c
>> @@ -20,6 +20,10 @@
>>    * PCI devices are always little-endian
>>    * SPAPR by default is big-endian
>>    * so PCI accessors need to swap data endianness
>> + *
>> + * The spapr iommu model has a qtest_enabled() check that short-cuts
>> + * the TCE table and provides a linear map for DMA, since qtests does
>> + * not have a way to make hcalls to set up the TCE table.
>>    */
>>   
>>   static uint8_t qpci_spapr_pio_readb(QPCIBus *bus, uint32_t addr)
>> @@ -155,9 +159,6 @@ void qpci_init_spapr(QPCIBusSPAPR *qpci, QTestState *qts,
>>   {
>>       assert(qts);
>>   
>> -    /* tests cannot use spapr, needs to be fixed first */
>> -    qpci->bus.has_buggy_msi = true;
>> -
>>       qpci->alloc = alloc;
>>   
>>       qpci->bus.pio_readb = qpci_spapr_pio_readb;
>> diff --git a/tests/qtest/libqos/pci.c b/tests/qtest/libqos/pci.c
>> index 986ce31d..76b13ade 100644
>> --- a/tests/qtest/libqos/pci.c
>> +++ b/tests/qtest/libqos/pci.c
>> @@ -53,20 +53,6 @@ void qpci_device_foreach(QPCIBus *bus, int vendor_id, int device_id,
>>       }
>>   }
>>   
>> -bool qpci_has_buggy_msi(QPCIDevice *dev)
>> -{
>> -    return dev->bus->has_buggy_msi;
>> -}
>> -
>> -bool qpci_check_buggy_msi(QPCIDevice *dev)
>> -{
>> -    if (qpci_has_buggy_msi(dev)) {
>> -        g_test_skip("Skipping due to incomplete support for MSI");
>> -        return true;
>> -    }
>> -    return false;
>> -}
>> -
>>   static void qpci_device_set(QPCIDevice *dev, QPCIBus *bus, int devfn)
>>   {
>>       g_assert(dev);
>> diff --git a/tests/qtest/libqos/pci.h b/tests/qtest/libqos/pci.h
>> index 9f8f154c..ef40a691 100644
>> --- a/tests/qtest/libqos/pci.h
>> +++ b/tests/qtest/libqos/pci.h
>> @@ -51,7 +51,6 @@ struct QPCIBus {
>>       QTestState *qts;
>>       uint64_t pio_alloc_ptr, pio_limit;
>>       uint64_t mmio_alloc_ptr, mmio_limit;
>> -    bool has_buggy_msi; /* TRUE for spapr, FALSE for pci */
>>       bool not_hotpluggable; /* TRUE if devices cannot be hotplugged */
>>   
>>   };
>> @@ -83,9 +82,6 @@ QPCIDevice *qpci_device_find(QPCIBus *bus, int devfn);
>>   void qpci_device_init(QPCIDevice *dev, QPCIBus *bus, QPCIAddress *addr);
>>   int qpci_secondary_buses_init(QPCIBus *bus);
>>   
>> -bool qpci_has_buggy_msi(QPCIDevice *dev);
>> -bool qpci_check_buggy_msi(QPCIDevice *dev);
>> -
>>   void qpci_device_enable(QPCIDevice *dev);
>>   uint8_t qpci_find_capability(QPCIDevice *dev, uint8_t id, uint8_t start_addr);
>>   void qpci_msix_enable(QPCIDevice *dev);
>> diff --git a/tests/qtest/nvme-test.c b/tests/qtest/nvme-test.c
>> index f9395cc2..388011be 100644
>> --- a/tests/qtest/nvme-test.c
>> +++ b/tests/qtest/nvme-test.c
>> @@ -492,10 +492,6 @@ static void test_migrate(void *obj, void *data, QGuestAllocator *alloc)
>>           { 333, false }
>>       };
>>   
>> -    if (qpci_check_buggy_msi(pdev)) {
>> -        return;
>> -    }
>> -
> 
> The nvme-test now fails with:
> 
> # starting QEMU: exec ./qemu-system-ppc64 -qtest
>    unix:/tmp/qtest-1116322.sock -qtest-log /dev/null -chardev
>    socket,path=/tmp/qtest-1116322.qmp,id=char0 -object
>    monitor-qmp,id=qmp0,chardev=char0 -display none -audio none -run-with
>    exit-with-parent=on -M pseries -drive
>    id=drv0,if=none,file=null-co://,file.read-zeroes=on,format=raw -object
>    memory-backend-ram,id=pmr0,share=on,size=16 -device
>    nvme,addr=04.0,drive=drv0,serial=foo -accel qtest
> 
> # nvme_wait_ready: csts 0
> #  q 0x561957dedaa8 db_idx 1 doorbell 0x1004
> # cq 0x561957dedaa8 db_idx 1 cqe 0x100000
> #  q 0x561957deda78 db_idx 0 doorbell 0x1000
> # sq 0x561957deda78 db_idx 0 sqe 0x101000
> # nvme_wait_ready: csts 1
> # sending req cid 123 no_wait 0
> # sq 0x561957deda78 next_sqe 0 sqe 0x101000
> # sq 0x561957deda78 commit sqe tail 0
> **
> ERROR:../tests/qtest/nvme-test.c:281:nvme_wait: assertion failed: (ready)
> 
> not ok
> /ppc64/pseries/spapr-pci-host-bridge/pci-bus-spapr/pci-bus/nvme/nvme-tests/migrate
> - ERROR:../tests/qtest/nvme-test.c:281:nvme_wait: assertion failed: (ready)
> 
> 

Hi Jishnu,

The NVMe migrate test is failing because of these 2 issues:
1. The NVMe SQ/CQ entries are little-endian. The endian conversions are 
missing at few places like the nvme_cqe_pending() and in other helper 
functions in nvme-test.c which is causing the above failure.
2. Once endian issue is fixed, the test still fails later in the series, 
after applying the [PATCH v6 08/10] qtest/libqos/pci: Enforce balanced 
iomap/unmap, the qpci_iounmap() writes 0xFFFFFFFF to the BAR. The 
test_migrate() calls the qpci_iounmap() before migration which resets 
the BAR, and that reset state gets migrated to the destination VM. So, 
instead of calling qpci_iounmap() and qpci_iomap() sequence during 
migration, direct call to qpci_migrate_fixup() before migration fixes 
this issue.

Are you planning to work on this series? Otherwise, I'm happy to send a 
new revision with these fixes.

Regards,
Utkarsh


