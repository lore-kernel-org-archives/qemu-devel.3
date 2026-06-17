Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 85350CD98EE
	for <qemu-devel@archiver.kernel.org>; Wed, 17 Jun 2026 06:23:53 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wZjgZ-0002BE-Kl; Wed, 17 Jun 2026 02:23:39 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <saif.abrar@linux.ibm.com>)
 id 1wZjd1-000119-Rp; Wed, 17 Jun 2026 02:19:59 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <saif.abrar@linux.ibm.com>)
 id 1wZjcz-0003C7-Tw; Wed, 17 Jun 2026 02:19:59 -0400
Received: from pps.filterd (m0353729.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 65GLmUbj2894168; Wed, 17 Jun 2026 06:19:47 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=pp1; bh=MqNnpQ
 okgrbQkDmvFZLm1C3mSxkbqrQjk26kPXQibOI=; b=jGxfuypHTelLDuWTKN95Q+
 afj7WoQAGdM/nNm/SZTxUSVhRo4NhLFLaroW6/htLGSCSraIVSp+E0GwMbRZ8Aov
 j4wIt7ALr7uqc7gPOphFq5NoCDxOo8PZweyCu7q6LfX7A/kaWLvSnbRqPE3rwePH
 aX7EelqARJOory/iqJJeOP0m4pazL0Q2MCRJ7eTyx/oWvmJUvzHSqumq21Uf8jKL
 yrA655lafKsCbezTOFxMpSmH6KuYxwtw+MXbFeFCVMK5hwrTBFF5zvyWyvkFWMQs
 9d/sP2xW86V6PMzwsYzDD7uLYTwqfbQqQi6MKZVKyegiUF4LgN5xXU5EQilbJ6rw
 ==
Received: from ppma12.dal12v.mail.ibm.com
 (dc.9e.1632.ip4.static.sl-reverse.com [50.22.158.220])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4euequ1gjq-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Wed, 17 Jun 2026 06:19:46 +0000 (GMT)
Received: from pps.filterd (ppma12.dal12v.mail.ibm.com [127.0.0.1])
 by ppma12.dal12v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 65H6JjCS029631;
 Wed, 17 Jun 2026 06:19:45 GMT
Received: from smtprelay07.wdc07v.mail.ibm.com ([172.16.1.74])
 by ppma12.dal12v.mail.ibm.com (PPS) with ESMTPS id 4eudva1tuj-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Wed, 17 Jun 2026 06:19:45 +0000 (GMT)
Received: from smtpav03.dal12v.mail.ibm.com (smtpav03.dal12v.mail.ibm.com
 [10.241.53.102])
 by smtprelay07.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 65H6Jid119006078
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Wed, 17 Jun 2026 06:19:44 GMT
Received: from smtpav03.dal12v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id ED4195805A;
 Wed, 17 Jun 2026 06:19:43 +0000 (GMT)
Received: from smtpav03.dal12v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 380675803F;
 Wed, 17 Jun 2026 06:19:39 +0000 (GMT)
Received: from [9.43.52.172] (unknown [9.43.52.172])
 by smtpav03.dal12v.mail.ibm.com (Postfix) with ESMTP;
 Wed, 17 Jun 2026 06:19:38 +0000 (GMT)
Message-ID: <f59fbc84-f80e-4674-8be2-8c6f4dba941a@linux.ibm.com>
Date: Wed, 17 Jun 2026 11:49:37 +0530
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 2/9] pnv/phb4: Add reset logic to PHB4
To: Aditya Gupta <adityag@linux.ibm.com>
Cc: qemu-ppc@nongnu.org, qemu-devel@nongnu.org, clg@kaod.org,
 npiggin@gmail.com, fbarrat@linux.ibm.com, mst@redhat.com,
 marcel.apfelbaum@gmail.com, cohuck@redhat.com, pbonzini@redhat.com,
 thuth@redhat.com, lvivier@redhat.com, danielhb413@gmail.com,
 Harsh Prateek Bora <harshpb@linux.ibm.com>, jishnuvw@linux.ibm.com
References: <20260210134110.1515322-1-saif.abrar@linux.vnet.ibm.com>
 <20260305060923.3753402-1-saif.abrar@linux.vnet.ibm.com>
 <20260305060923.3753402-3-saif.abrar@linux.vnet.ibm.com>
 <af9F84KcjdZsb0_y@li-3c92a0cc-27cf-11b2-a85c-b804d9ca68fa.ibm.com>
Content-Language: en-US
From: Saif Abrar <saif.abrar@linux.ibm.com>
In-Reply-To: <af9F84KcjdZsb0_y@li-3c92a0cc-27cf-11b2-a85c-b804d9ca68fa.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Proofpoint-Spam-Info: AW1haW4tMjYwNjE3MDA1NyBTYWx0ZWRfX3SQEtJpZYL+u
 VWFCk38XQpm/41yizwYKTd9G1mNhL7Ak6+ZAAJibbPJCjbAI0ZC6lrV9zKmg1hv4u8GmLhhiKfM
 tQR+XvgmvBeVGZrffg6NXcqCkRiHiZ8=
X-Proofpoint-ORIG-GUID: CdTR9dvD7wOM80MmgN0ANgQyJmLw12PK
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjE3MDA1NyBTYWx0ZWRfX/HidgDpf8CgP
 efHTZ8xP+zfA3enBrejz7c2Mdp+WA56u2v/GUhmEcwvcsiPJbIOs3kRR5kS6DoWzlVqf19S1lqi
 KhYRptsL59h7iXGn2ygdGwO8WNCxVTeM0LiGCBMG0ikiT49Xd9umfbB5RqmJ2L9l9Pv7/hVvDq+
 9DSnru0di4nN2RoAi9ZGCX8ZGK1C3uIp0YIuul7nkYIcWfhM0r08OC+lscUs0NTKu2mQ/J4aHwz
 IjAL9ejrqFG3NuVjNENo31Jqf598XGVGnym8SIAHlUCu0x2dO4+zPrY/0wgYbdJQGrkwlzyB0CE
 IFDpePPSIhPATZmX6QdNVow3wzyG5iwehi1KkL6EGbdF+qGI8A/D6nvCnLn06VF+2txhs67BEoI
 AQxivZYLHiBU147tjGQi1nGsNLaxh6zGbiG8Q7dvim4PSxrkyv9qpSjKMtbOI9KF4G6177sjPCN
 oQBogCCYac/bfHaR06Q==
X-Proofpoint-GUID: 0VDQi9mxxoi8BUQqCLhDGXNGWADwFUxa
X-Authority-Analysis: v=2.4 cv=L9gtheT8 c=1 sm=1 tr=0 ts=6a323c83 cx=c_pps
 a=bLidbwmWQ0KltjZqbj+ezA==:117 a=bLidbwmWQ0KltjZqbj+ezA==:17
 a=IkcTkHD0fZMA:10 a=FelO9ux0wxsA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=uAbxVGIbfxUO_5tXvNgY:22 a=VnNF1IyMAAAA:8
 a=aow-egSQAAAA:8 a=20KFwNOVAAAA:8 a=jn0RShxQS5WRXkzcl74A:9 a=3ZKOabzyN94A:10
 a=QEXdDO2ut3YA:10 a=gFNbaldVC-z-bsjSTzMo:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-16_05,2026-06-16_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 impostorscore=0 malwarescore=0 clxscore=1015 adultscore=0
 phishscore=0 lowpriorityscore=0 suspectscore=0 priorityscore=1501 spamscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2606170057
Received-SPF: pass client-ip=148.163.156.1;
 envelope-from=saif.abrar@linux.ibm.com; helo=mx0a-001b2d01.pphosted.com
X-Spam_score_int: -26
X-Spam_score: -2.7
X-Spam_bar: --
X-Spam_report: (-2.7 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, RCVD_IN_DNSWL_LOW=-0.7,
 RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-Mailman-Approved-At: Wed, 17 Jun 2026 02:23:38 -0400
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


On 09-05-2026 20:12, Aditya Gupta wrote:
> On 26/03/05 12:09AM, Saif Abrar wrote:
>> Add a method to be invoked on QEMU reset.
>> Also add CFG and PBL core-blocks reset logic using
>> appropriate bits of PHB_PCIE_CRESET register.
>>
>> Tested by reading the reset value of a register.
>>
>> Signed-off-by: Saif Abrar <saif.abrar@linux.vnet.ibm.com>
>> Reviewed-by: Cédric Le Goater <clg@kaod.org>
>> Reviewed-by: Michael S. Tsirkin <mst@redhat.com>
>> ---
>> v3: Updates for coding guidelines.
>> v2:
>> - Using the ResettableClass.
>> - Reset of the root complex registers done in pnv_phb_root_port_reset_hold().
>>
>>   hw/pci-host/pnv_phb.c               |   1 +
>>   hw/pci-host/pnv_phb4.c              | 103 +++++++++++++++++++++++++++-
>>   include/hw/pci-host/pnv_phb4.h      |   1 +
>>   include/hw/pci-host/pnv_phb4_regs.h |  16 ++++-
>>   tests/qtest/pnv-phb4-test.c         |  28 +++++++-
>>   5 files changed, 145 insertions(+), 4 deletions(-)
>>
>> diff --git a/hw/pci-host/pnv_phb.c b/hw/pci-host/pnv_phb.c
>> index 0b556d1bf5..d4f452d7b2 100644
>> --- a/hw/pci-host/pnv_phb.c
>> +++ b/hw/pci-host/pnv_phb.c
>> @@ -232,6 +232,7 @@ static void pnv_phb_root_port_reset_hold(Object *obj, ResetType type)
>>       pci_set_long(conf + PCI_PREF_BASE_UPPER32, 0x1); /* Hack */
>>       pci_set_long(conf + PCI_PREF_LIMIT_UPPER32, 0xffffffff);
>>       pci_config_set_interrupt_pin(conf, 0);
>> +    pnv_phb4_cfg_core_reset(d);
> seems these are common steps for phb4/5 now, if that's the case, do you
> think this small change makes sense ?
>
>      diff --git a/hw/pci-host/pnv_phb.c b/hw/pci-host/pnv_phb.c
>      index d4f452d7b2fe..0432466b249f 100644
>      --- a/hw/pci-host/pnv_phb.c
>      +++ b/hw/pci-host/pnv_phb.c
>      @@ -220,7 +220,7 @@ static void pnv_phb_root_port_reset_hold(Object *obj, ResetType type)
>               return;
>           }
>       
>      -    /* PHB4 and later requires these extra reset steps */
>      +    /* PHB4/5 and later requires these extra reset steps */
>           pci_byte_test_and_set_mask(conf + PCI_IO_BASE,
>                                      PCI_IO_RANGE_MASK & 0xff);
>           pci_byte_test_and_clear_mask(conf + PCI_IO_LIMIT,


Comment 'PHB4 and later' covers PHB5 as well, hence not really required.


>
>>   }
>>   
>> <...snip...>
>> +void pnv_phb4_cfg_core_reset(PCIDevice *d)
>> +{
>> +    uint8_t *conf = d->config;
>> +    uint32_t exp_offset = get_exp_offset(d);
>> +
>> +    pci_set_word(conf + PCI_COMMAND, PCI_COMMAND_SERR);
>> +    pci_set_word(conf + PCI_STATUS, PCI_STATUS_CAP_LIST);
>> +    pci_set_long(conf + PCI_CLASS_REVISION, 0x06040000);
>> +    pci_set_long(conf + PCI_CACHE_LINE_SIZE, BIT(16));
>> +    pci_set_word(conf + PCI_MEMORY_BASE, BIT(4));
>> +    pci_set_word(conf + PCI_PREF_MEMORY_BASE, BIT(0) | BIT(4));
>> +    pci_set_word(conf + PCI_PREF_MEMORY_LIMIT, PCI_PREF_RANGE_TYPE_64);
> Above 3 configs are set twice, in this function as well as the callee


This method 'pnv_phb4_cfg_core_reset()' is also called for core blocks 
reset using PHB_PCIE_CRESET.

>
> Also, these were set to different values before this patch, such as
> PCI_MEMORY_BASE being set to BIT(0) in 'pnv_phb_root_port_reset_hold'.
>
> Can this cause any issues ?


These are taken from the PHB5 spec, as follows:
03:00 CFG_PCI20_MEM_BASE[03:00] RO 0 Memory Base Register[03:00] 
Hard-coded to '0'.
15:04 CFG_PCI20_MEM_BASE[15:04]RO 0x001 Memory Base Register[15:04] 
Hard-coded to a value of 0x001 so that the Base > Limit.


>
> Also, can you help me find which section in spec contains the sequence
> for core/pbl core reset ?


PHB5 sections '5.8.1 PHB Initialization Sequence' and '5.9.1 Hot-Reset 
Sequences' have the details.

>
>> +    pci_set_long(conf + PCI_CAPABILITY_LIST, BIT(6));
>> +    pci_set_long(conf + PCI_CAPABILITY_LIST, BIT(6));
> nit: duplicates


Duplicate removed.


>
>> <...snip...>
>> +    pci_set_long(conf + PHB_DLF_ECAP, 0x1F410025);
>> +    pci_set_long(conf + PHB_DLF_CAP,  0x80000001);
>> +    pci_set_long(conf + P16_ECAP, 0x22410026);
>> +    pci_set_long(conf + P32_ECAP, 0x1002A);
>> +    pci_set_long(conf + P32_CAP,  0x103);
> the current patch has lots of hardcoded values (above ones and below
> this line too), does it make sense to have macros or ppc_bitmasks for
> some of them ?


These hardcoded values are taken from the PHB5 spec.

I've kept them as-is so that it's easier to refer them back in the spec.


>
>> +}
>> +
>> +static void pnv_phb4_pbl_core_reset(PnvPHB4 *phb)
>> +{
>> +    /* Zero all registers initially */
>> +    for (int i = PHB_PBL_CONTROL ; i <= PHB_PBL_ERR1_STATUS_MASK ; i += 8) {
>> +        phb->regs[i >> 3] = 0x0;
>> +    }
>> +
>> +    /* Set specific register values */
>> +    phb->regs[PHB_PBL_CONTROL       >> 3] = 0xC009000000000000;
>> +    phb->regs[PHB_PBL_TIMEOUT_CTRL  >> 3] = 0x2020000000000000;
>> +    phb->regs[PHB_PBL_NPTAG_ENABLE  >> 3] = 0xFFFFFFFF00000000;
>> +    phb->regs[PHB_PBL_SYS_LINK_INIT >> 3] = 0x80088B4642473000;
>> +}
>> +
>> <...snip...>
>> @@ -72,8 +95,6 @@ static void phb_version_test(const void *data)
>>       /* PHB Version register bits [24:31] */
>>       ver = ver >> (63 - 31);
>>       g_assert_cmpuint(ver, ==, expected_ver);
>> -
>> -    qtest_quit(qts);
> qtest_quit is removed here, won't it cause issues where QTestState is
> not terminated properly ?


Added it back.


> Thanks,
> - Aditya G


Thanks,

Saif



