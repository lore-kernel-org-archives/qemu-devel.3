Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7106F606A329
	for <qemu-devel@archiver.kernel.org>; Thu,  5 Nov 2026 12:16:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=Et215M7Z
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xOwNI-00026f-KO; Thu, 05 Nov 2026 07:15:25 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <uverma@linux.ibm.com>)
 id 1xOwNE-00026I-JS; Thu, 05 Nov 2026 07:15:20 -0500
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <uverma@linux.ibm.com>)
 id 1xOwNC-00012X-48; Thu, 05 Nov 2026 07:15:20 -0500
Received: from pps.filterd (m0356516.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 6A5AEBHu3166372; Thu, 5 Nov 2026 12:15:13 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=pp1; bh=reRQ8l
 BRZmcvm37FnVkLjeS1AKSjMvBKl8lKCKeasi8=; b=Et215M7ZEJ33/dazLivBZ6
 kKdgGmBf4hmZ5P6T/rl3jHlUaMKuoND0cQ3MQNjxvSpvarnfZPQDrZW9MeWdXTci
 C2DoxCN8Xf215fm//beyA5tg4U5WsR3VMBxOgrM3Cd7labMgq2i+mSfAT0qOaFf8
 dt8xr2qHYfXwjlKwuLRdSZPnortMkwH8EI5ZYt0deyBWcNgTatcej0eGOwpPHCac
 QQYTq1je83obDTCf7JNhdEOG6Jic9mDHu2tzErUhldIIxAlYlB1FpcK4JmAKKpgo
 1qhJFQrrf++4D6BS9JgcXolPqELtmCNyT8SMrS+YSoQ6XvFCkZpKZJhkB/zEYcQg
 ==
Received: from ppma12.dal12v.mail.ibm.com
 (dc.9e.1632.ip4.static.sl-reverse.com [50.22.158.220])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4hn5rj1s06-1
 (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
 Thu, 05 Nov 2026 12:15:12 +0000 (GMT)
Received: from pps.filterd (ppma12.dal12v.mail.ibm.com [127.0.0.1])
 by ppma12.dal12v.mail.ibm.com (8.18.1.11/8.18.1.11) with ESMTP id
 6A5A51fG1425295; Thu, 5 Nov 2026 12:15:11 GMT
Received: from smtprelay01.wdc07v.mail.ibm.com ([172.16.1.68])
 by ppma12.dal12v.mail.ibm.com (PPS) with ESMTPS id 4hrk9mhpvb-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 05 Nov 2026 12:15:11 +0000 (GMT)
Received: from smtpav04.dal12v.mail.ibm.com (smtpav04.dal12v.mail.ibm.com
 [10.241.53.103])
 by smtprelay01.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 6A5CF9aA7799680
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Thu, 5 Nov 2026 12:15:09 GMT
Received: from smtpav04.dal12v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 626475805E;
 Thu,  5 Nov 2026 12:15:09 +0000 (GMT)
Received: from smtpav04.dal12v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id DB00958062;
 Thu,  5 Nov 2026 12:15:04 +0000 (GMT)
Received: from [9.123.12.1] (unknown [9.123.12.1])
 by smtpav04.dal12v.mail.ibm.com (Postfix) with ESMTP;
 Thu,  5 Nov 2026 12:15:04 +0000 (GMT)
Message-ID: <2f5493aa-f70b-4561-8990-919234b6f257@linux.ibm.com>
Date: Thu, 5 Nov 2026 17:45:03 +0530
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v7 08/10] qtest/libqos/pci: Enforce balanced iomap/unmap
To: Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>, qemu-ppc@nongnu.org,
 qemu-devel@nongnu.org
Cc: npiggin@gmail.com, jishnuvw@linux.ibm.com, harshpb@linux.ibm.com,
 amachhiw@linux.ibm.com, jsnow@redhat.com, farosas@suse.de,
 lvivier@redhat.com, pbonzini@redhat.com,
 aleksandr.mikhalitsyn@futurfusion.io,
 "Michael S. Tsirkin" <mst@redhat.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Akihiko Odaki <akihiko.odaki@daynix.com>
References: <20261102035306.2291147-1-uverma@linux.ibm.com>
 <20261102035306.2291147-9-uverma@linux.ibm.com>
 <09566fd1-7eb6-4dc1-a721-f15e4948e143@rsg.ci.i.u-tokyo.ac.jp>
Content-Language: en-US, en-ZM
From: Utkarsh Verma <uverma@linux.ibm.com>
In-Reply-To: <09566fd1-7eb6-4dc1-a721-f15e4948e143@rsg.ci.i.u-tokyo.ac.jp>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Proofpoint-ORIG-GUID: l2KZvJ8ygnBLbU2Opcc_hpUdZCgEsK2Q
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTA1MDA0OCBTYWx0ZWRfX8VChnfMNJdGB
 KBleMKw3Wmh45N/bV1bguTqGDbzr7qKpt2lJMujfOpgGD+pzSGh7fq8hUQGQckACpbrY5jpcH9l
 QN55IaohKGaWMt7QUsVr200bJFuwaQo=
X-Authority-Analysis: v=2.4 cv=LokHWXdc c=1 sm=1 tr=0 ts=6aec7350 cx=c_pps
 a=bLidbwmWQ0KltjZqbj+ezA==:117 a=bLidbwmWQ0KltjZqbj+ezA==:17
 a=IkcTkHD0fZMA:10 a=zJRp6_cAMcgA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=Y2IxJ9c9Rs8Kov3niI8_:22 a=VnNF1IyMAAAA:8
 a=pGLkceISAAAA:8 a=20KFwNOVAAAA:8 a=z4glEzOvAAAA:8 a=69XwJtq8K36NyF0Nym0A:9
 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10 a=92dS5hN0c3Q7EetK7xW5:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTA1MDA0OCBTYWx0ZWRfX98CN/S7jqEU/
 n9AAuaqJ2kbC2sNiH8VUbrdA7OoOuHORfaFclo55xReSQznYjTR+yiWb6RbFe/NolH6vLJkeOpY
 OTAHA7vBU9mCTdGewYLj2uKGk3e2/z5cvMkl/lBMQb8e75NxVD9JZslErJr7si5/kj4eAfkFQ8J
 Ts1euP3QO2UzygM4N47xYJl4QD3bnFSCn/XGh8B1wJHK1a49ZaEPHzTapDgHlZ46ON72X7DYPuf
 UqgdnEM+yhR1a8xtrP+U4ybYT4QAdJbYw5g/Kn+IR5TEUTyV7NKwwV4GwVmuQrphUcJQXwwdd5t
 EtZE8VCfHwLW3IsqCkfX5HR9eR//t/FwfUCDMV8UygqieehZmdpQY395qq6tmy2mbyMPVLF/n17
 Un+DJmdN/d7JaWdUQGzeVvENXirCtRsHpE2Zyb4ewytgkCbltbQZ2RrmN/vX0SVoyN1XthvUW83
 BbZ4wGQC0k7WO343hrw==
X-Proofpoint-GUID: 6Zc4A1d31v1nMHQIuxl6LqRe2uSIY9NK
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-05_03,2026-11-04_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 lowpriorityscore=0 clxscore=1015 impostorscore=0
 priorityscore=1501 suspectscore=0 phishscore=0 malwarescore=0 bulkscore=0
 adultscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2610300000
 definitions=main-2611050048
Received-SPF: pass client-ip=148.163.158.5; envelope-from=uverma@linux.ibm.com;
 helo=mx0b-001b2d01.pphosted.com
X-Spam_score_int: -26
X-Spam_score: -2.7
X-Spam_bar: --
X-Spam_report: (-2.7 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, RCVD_IN_DNSWL_LOW=-0.7,
 RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001, SPF_HELO_NONE=0.001,
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

On 11/3/26 7:36 PM, Akihiko Odaki wrote:
> On 2026/11/02 12:53, uverma@linux.ibm.com wrote:
>> From: Nicholas Piggin <npiggin@gmail.com>
>>
>> Add assertions to ensure a BAR is not mapped twice, and that only
>> previously mapped BARs are unmapped. This can help catch bugs and
>> fragile coding.
>>
>> Cc: Michael S. Tsirkin <mst@redhat.com>
>> Cc: Marcel Apfelbaum <marcel.apfelbaum@gmail.com>
>> Reviewed-by: Akihiko Odaki <akihiko.odaki@daynix.com>
>> Reviewed-by: Fabiano Rosas <farosas@suse.de>
>> Signed-off-by: Nicholas Piggin <npiggin@gmail.com>
>> Signed-off-by: Jishnu Warrier <jishnuvw@linux.ibm.com>
>> Signed-off-by: Utkarsh Verma <uverma@linux.ibm.com>
>> ---
>>   tests/qtest/libqos/ahci.c |  3 ++-
>>   tests/qtest/libqos/pci.c  | 57 +++++++++++++++++++++++++++++++++++----
>>   tests/qtest/libqos/pci.h  | 10 +++++++
>>   3 files changed, 64 insertions(+), 6 deletions(-)
>>
>> diff --git a/tests/qtest/libqos/ahci.c b/tests/qtest/libqos/ahci.c
>> index a709558aac..53a98bd6cb 100644
>> --- a/tests/qtest/libqos/ahci.c
>> +++ b/tests/qtest/libqos/ahci.c
>> @@ -225,7 +225,7 @@ void start_ahci_device(AHCIQState *ahci)
>>   void stop_ahci_device(AHCIQState *ahci)
>>   {
>> -    /* Unmap AHCI's ABAR */
>> +    /* Unmap AHCI's ABAR (no-op if not mapped) */
>>       qpci_iounmap(ahci->dev, ahci->hba_bar);
>>   }
>> @@ -250,6 +250,7 @@ void ahci_hba_enable(AHCIQState *ahci)
>>       uint8_t num_cmd_slots;
>>       g_assert(ahci != NULL);
>> +    g_assert(ahci->hba_bar.mapped);
>>       /* Set GHC.AE to 1 */
>>       ahci_set(ahci, AHCI_GHC, AHCI_GHC_AE);
>> diff --git a/tests/qtest/libqos/pci.c b/tests/qtest/libqos/pci.c
>> index e78dd4d4c7..365fde1fb9 100644
>> --- a/tests/qtest/libqos/pci.c
>> +++ b/tests/qtest/libqos/pci.c
>> @@ -79,12 +79,17 @@ QPCIDevice *qpci_device_find(QPCIBus *bus, int devfn)
>>   void qpci_device_init(QPCIDevice *dev, QPCIBus *bus, QPCIAddress *addr)
>>   {
>>       uint16_t vendor_id, device_id;
>> +    int i;
>>       qpci_device_set(dev, bus, addr->devfn);
>>       vendor_id = qpci_config_readw(dev, PCI_VENDOR_ID);
>>       device_id = qpci_config_readw(dev, PCI_DEVICE_ID);
>>       g_assert(!addr->vendor_id || vendor_id == addr->vendor_id);
>>       g_assert(!addr->device_id || device_id == addr->device_id);
>> +
>> +    for (i = 0; i < QPCI_NUM_REGIONS; i++) {
>> +        g_assert(!dev->bars_mapped[i]);
>> +    }
>>   }
>>   static uint8_t qpci_find_resource_reserve_capability(QPCIDevice *dev)
>> @@ -554,21 +559,31 @@ void qpci_memwrite(QPCIDevice *dev, QPCIBar 
>> token, uint64_t off,
>>       dev->bus->memwrite(dev->bus, token.addr + off, buf, len);
>>   }
>> -QPCIBar qpci_iomap(QPCIDevice *dev, int barno, uint64_t *sizeptr)
>> +static uint8_t qpci_bar_reg(int barno)
>>   {
>> -    QPCIBus *bus = dev->bus;
>>       static const int bar_reg_map[] = {
>>           PCI_BASE_ADDRESS_0, PCI_BASE_ADDRESS_1, PCI_BASE_ADDRESS_2,
>>           PCI_BASE_ADDRESS_3, PCI_BASE_ADDRESS_4, PCI_BASE_ADDRESS_5,
>>       };
>> +
>> +    g_assert(barno >= 0 && barno < QPCI_NUM_REGIONS);
>> +
>> +    return bar_reg_map[barno];
>> +}
>> +
>> +QPCIBar qpci_iomap(QPCIDevice *dev, int barno, uint64_t *sizeptr)
>> +{
>> +    QPCIBus *bus = dev->bus;
>>       QPCIBar bar;
>>       int bar_reg;
>>       uint32_t addr, size;
>>       uint32_t io_type;
>>       uint64_t loc;
>> -    g_assert(barno >= 0 && barno <= 5);
>> -    bar_reg = bar_reg_map[barno];
>> +    g_assert(barno >= 0 && barno < QPCI_NUM_REGIONS);
>> +    g_assert(!dev->bars_mapped[barno]);
>> +
>> +    bar_reg = qpci_bar_reg(barno);
>>       qpci_config_writel(dev, bar_reg, 0xFFFFFFFF);
>>       addr = qpci_config_readl(dev, bar_reg);
>> @@ -611,12 +626,40 @@ QPCIBar qpci_iomap(QPCIDevice *dev, int barno, 
>> uint64_t *sizeptr)
>>       }
>>       bar.addr = loc;
>> +    bar.mapped = true;
>> +
>> +    dev->bars_mapped[barno] = true;
>> +    dev->bars[barno] = bar;
>> +
>>       return bar;
>>   }
>>   void qpci_iounmap(QPCIDevice *dev, QPCIBar bar)
>>   {
>> -    /* FIXME */
>> +    int bar_reg;
>> +    int i;
>> +
>> +    if (!bar.mapped) {
>> +        return; /* bar was never mapped; no-op */
>> +    }
>> +
>> +    for (i = 0; i < QPCI_NUM_REGIONS; i++) {
>> +        if (!dev->bars_mapped[i]) {
>> +            continue;
>> +        }
>> +        if (dev->bars[i].addr == bar.addr) {
>> +            dev->bars_mapped[i] = false;
>> +            dev->bars[i].mapped = false;
>> +            bar_reg = qpci_bar_reg(i);
>> +            qpci_config_writel(dev, bar_reg, 0xFFFFFFFF);
> 
> I found that this is actually dangerous: the BAR may be 64-bit, and in 
> that case, this won't unmap it. On x86, the BIOS is mapped around that 
> area, and the mapped BAR will shadow it.
> 
> Regards,
> Akihiko Odaki
> 
Agree, writing all 0xFF's to a single BAR will map the PCIe device to 
4GB-size address, which can overlap with the BIOS area on x86 system.
The problem is that since qtest work directly with guest physical 
addresses, writing any address to the BAR for unmapping purpose will map 
that address to the PCIe device.
The false mapping is not the 32 bit limitation, even with full 64 bit 
BAR support, writing any address to both the BARs in qpci_iounmap() 
would result in the mapping of the address to the PCIe device. Also, 
full 64 bit BAR supoort would require implementation in the qpci_iomap() 
and other functions as well.

For now we can completely remove this BAR write, so the BAR would be 
mapped to it's original address for the rest of the qemu process (memory 
leak) but should be safe as other allocations won't use that same 
address again. Also, since these qtests launch new qemu instances so the 
memory leak only exists in that current qemu process and new tests 
create new instances, so it shouldn't be a big problem.
Do you have any other approach for this, or does the above look good?

Regards,
Utkarsh

>> +            /* FIXME: the address space is leaked */> +            
>> return;
>> +        }
>> +    }
>> +    /*
>> +     * bar was not iomap()ed; treat as no-op for callers that may
>> +     * call iounmap unconditionally during cleanup paths.
>> +     */
>>   }
>>   QPCIBar qpci_legacy_iomap(QPCIDevice *dev, uint16_t addr)
>> @@ -627,6 +670,10 @@ QPCIBar qpci_legacy_iomap(QPCIDevice *dev, 
>> uint16_t addr)
>>   void qpci_migrate_fixup(QPCIDevice *to, QPCIDevice *from)
>>   {
>> +    memcpy(to->bars_mapped, from->bars_mapped, sizeof(from- 
>> >bars_mapped));
>> +    memset(from->bars_mapped, 0, sizeof(from->bars_mapped));
>> +    memcpy(to->bars, from->bars, sizeof(from->bars));
>> +    memset(from->bars, 0, sizeof(from->bars));
>>   }
>>   void add_qpci_address(QOSGraphEdgeOptions *opts, QPCIAddress *addr)
>> diff --git a/tests/qtest/libqos/pci.h b/tests/qtest/libqos/pci.h
>> index cfb7c17dd3..2f9555ae4e 100644
>> --- a/tests/qtest/libqos/pci.h
>> +++ b/tests/qtest/libqos/pci.h
>> @@ -58,12 +58,22 @@ struct QPCIBus {
>>   struct QPCIBar {
>>       uint64_t addr;
>>       bool is_io;
>> +    bool mapped;
>>   };
>> +/*
>> + * hw/pci permits 7 (PCI_NUM_REGIONS) regions, the last for 
>> PCI_ROM_SLOT.
>> + * libqos does not implement PCI_ROM_SLOT at the moment, and as such it
>> + * permits 6.
>> + */
>> +#define QPCI_NUM_REGIONS 6
>> +
>>   struct QPCIDevice
>>   {
>>       QPCIBus *bus;
>>       int devfn;
>> +    bool bars_mapped[QPCI_NUM_REGIONS];
>> +    QPCIBar bars[QPCI_NUM_REGIONS];
>>       bool msix_enabled;
>>       QPCIBar msix_table_bar, msix_pba_bar;
>>       uint64_t msix_table_off, msix_pba_off;
> 
> 


