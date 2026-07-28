Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F307BC53219
	for <qemu-devel@archiver.kernel.org>; Tue, 28 Jul 2026 20:59:39 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wootZ-0002RY-56; Tue, 28 Jul 2026 16:59:25 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kshk@linux.ibm.com>)
 id 1wootW-0002Qz-L0; Tue, 28 Jul 2026 16:59:22 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kshk@linux.ibm.com>)
 id 1wootU-0002zh-Lh; Tue, 28 Jul 2026 16:59:22 -0400
Received: from pps.filterd (m0360083.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 66SIHhP51927416; Tue, 28 Jul 2026 20:59:17 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=pp1; bh=B47Yo8
 WtHQcriGJkrdr8MGxCKy2MH1Oo6ZXUnyIChgk=; b=SohuS0oMGUOo06aL/nrgsT
 fvQN42uCwWvuMjna7uSDLd4w7jqoAHuIfrFHwONmjw5K+T9B5bIfi3CyPvzaTts6
 n9Pabe3eyhQhDsPdtu0gQ1fNnrdAoxKpzB7MY1jTU52OuQLrR3H+lrkLqnt7RkYi
 AVw8nMZcoJJ1abk5tj1UpIe2g+aJWnm3idzj7gK7hr2kJbJvFTU/urZN50zEBI9I
 4w2u/i4HG2sKlC9dY/K094EbjnHENgVacaF0I0ZI4+y5hugN8Q+u4DZZsQuUwSPN
 jihWylGUtVBVMB1cZSMWr0F/rK35qgiZEZcaf7acZPnJvvGx9GF0tMBByDWqiwew
 ==
Received: from ppma13.dal12v.mail.ibm.com
 (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4fmuw7fh56-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 28 Jul 2026 20:59:16 +0000 (GMT)
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
 by ppma13.dal12v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 66SKuFLX010935;
 Tue, 28 Jul 2026 20:59:15 GMT
Received: from smtprelay03.dal12v.mail.ibm.com ([172.16.1.5])
 by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 4fn9pgbnye-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 28 Jul 2026 20:59:15 +0000 (GMT)
Received: from smtpav05.dal12v.mail.ibm.com (smtpav05.dal12v.mail.ibm.com
 [10.241.53.104])
 by smtprelay03.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 66SKxEBL26870490
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Tue, 28 Jul 2026 20:59:14 GMT
Received: from smtpav05.dal12v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 7732C58056;
 Tue, 28 Jul 2026 20:59:14 +0000 (GMT)
Received: from smtpav05.dal12v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 4950458052;
 Tue, 28 Jul 2026 20:59:14 +0000 (GMT)
Received: from [9.61.240.100] (unknown [9.61.240.100])
 by smtpav05.dal12v.mail.ibm.com (Postfix) with ESMTP;
 Tue, 28 Jul 2026 20:59:14 +0000 (GMT)
Message-ID: <bd784407-06a3-47fc-8c13-4e3d70e856b5@linux.ibm.com>
Date: Tue, 28 Jul 2026 15:59:14 -0500
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 14/15] s390x/pci: Implement migration for emulated
 devices
Content-Language: en-US
To: Farhan Ali <alifm@linux.ibm.com>, mjrosato@linux.ibm.com
Cc: richard.henderson@linaro.org, iii@linux.ibm.com, david@kernel.org,
 cohuck@redhat.com, pasic@linux.ibm.com, borntraeger@linux.ibm.com,
 qemu-s390x@nongnu.org, qemu-devel@nongnu.org
References: <20260724030919.123733-1-kshk@linux.ibm.com>
 <20260724030919.123733-15-kshk@linux.ibm.com>
 <6390365c-018e-4ac9-96fd-7dba63736a2c@linux.ibm.com>
 <403c57ad-107a-4d59-ad4a-874d2c3a5f2d@linux.ibm.com>
 <992b35d7-5a7d-4f16-9409-1b2d3e2c2416@linux.ibm.com>
From: Konstantin Shkolnyy <kshk@linux.ibm.com>
In-Reply-To: <992b35d7-5a7d-4f16-9409-1b2d3e2c2416@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: jYBBzLKdJEUEhgavK10OtcpGmeVA-I1d
X-Proofpoint-ORIG-GUID: jYBBzLKdJEUEhgavK10OtcpGmeVA-I1d
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzI4MDE3OCBTYWx0ZWRfX8sHe9oInlMWh
 GVsJmhPSW2Iz6Mlu0ZWwCl4mBODXQQl7PIVKkULIEU5lBmJhkw+/G5ht3+hlY7s1UENyUXUmxjE
 T1pvHkdaytaRsA9+39YSwDhNizp+AOxMDk6/3ADOv7cE1wktf4kGkaqbgB8DR9Ta9ytxCjcW19x
 IByPImawEGWccRPLMlIpiPBu7sp/StSy3QQzOR+PojfktI6hMypTvTfPazrJUyv14l9gCR9RTMH
 haMHg9Hx2MYFzQzjGhdbeKlretmyU3s+T0ciRq/PJyS4nkst6ONQsH2S0p5W0wGDVDn/WITTNJF
 H0E0kIKn+fr6+GSbBYPmznqM7l06QGGlF0rLfItrKup4R27ecZpBH7h4/UxP/Q6a6De4vi60gkh
 h6s8zgw4V4ijSQ+LTTvuh409m9RvGEMR79wA30RDhYpv2NnwakVrZ/0KHyJnjfJU8K0sZ0vChxT
 qvX8L2voDC5Ee6gA9kQ==
X-Authority-Analysis: v=2.4 cv=SKFykuvH c=1 sm=1 tr=0 ts=6a691824 cx=c_pps
 a=AfN7/Ok6k8XGzOShvHwTGQ==:117 a=AfN7/Ok6k8XGzOShvHwTGQ==:17
 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=iQ6ETzBq9ecOQQE5vZCe:22 a=l6FR2L8gatnKI5GcOpQA:9
 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzI4MDE3OCBTYWx0ZWRfX2d/IvDqNazPS
 QUFy7+oaSL7v47TfoiqlGAlmwyFDISyDWNTOy4IqcZPkY0rhsS4uXkRc1END6ruqH4rapvblDsH
 bg/6MWHWBs0vZ3fd6iI5Ty82uEM+OjM=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-28_05,2026-07-28_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 malwarescore=0 clxscore=1015 adultscore=0
 lowpriorityscore=0 bulkscore=0 impostorscore=0 phishscore=0 spamscore=0
 suspectscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2607280178
Received-SPF: pass client-ip=148.163.156.1; envelope-from=kshk@linux.ibm.com;
 helo=mx0a-001b2d01.pphosted.com
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

On 260728 12:46, Farhan Ali wrote:
> 
> On 7/27/2026 4:23 PM, Konstantin Shkolnyy wrote:
>>>> +static int s390_pci_device_pre_load(void *opaque)
>>>> +{
>>>> +    S390PCIBusDevice *pbdev = S390_PCI_DEVICE(opaque);
>>>> +    S390PCIBusDevice *found_pbdev;
>>>> +
>>>> +    /*
>>>> +     * Make sure pbdev is removed from the table before state load. 
>>>> The change
>>>> +     * of pbdev->idx means it needs to be moved to a different 
>>>> position anyway,
>>>> +     * and is illegal while in the table. But be careful to not remove
>>>> +     * instead another pbdev whose state might have been loaded 
>>>> earlier and
>>>
>>> I think "instead" is not needed in the statement above.
>>>
>>> Maybe I am missing something, but could you help me understand why do 
>>> we need to remove the pbdev if we found at a particular idx? If there 
>>> is a collision with idx, ie on destination we have a different device 
>>> with the same idx, are we removing a valid device?
>>
>> I see that this is not the best comment. How about this variant:
>>
>>     * State loading can change pbdev->idx. Therefore, make sure pbdev 
>> is removed
>>     * from the table before that happens. The table type used stores a 
>> pointer
>>     * to pbdev->idx and becomes corrupt if idx is changed from 
>> outside. But be
>>     * careful to not remove instead another pbdev whose state might 
>> have been
>>     * loaded earlier and that got assigned this idx value and had 
>> therefore
>>     * already replaced our pbdev in the table. post_load() will 
>> reinsert our
>>     * pbdev into the table.
>>
> So pbdev->idx is autogenerated when we create the device at destination, 
> since we are migrating the idx from source this could change on 
> destination and corrupt the hash table?

Exactly.

  Then do we need to migrate the idx?
> 

idx is part of "function handle". So, it should remain unchanged after 
migration.

> 
>>>
>>>> +     * that has then replaced our pbdev. (post_load() will put our 
>>>> pbdev back.)
>>>> +     */
>>>> +    found_pbdev = g_hash_table_lookup(s390_get_phb()->zpci_table, 
>>>> &pbdev->idx);
>>>> +    assert(found_pbdev); 
> AFAIU the pbdev->idx at pre_load() would be what we assign automatically 
> at the destination. In that case wouldn't this assert always be true?

Yes. This assert documents that a pbdev is always expected to be found 
for this "autogenerated when we create the device at destination" 
pbdev->idx - either the pbdev we are currently processing, or another 
pbdev that was "loaded" earlier with the same idx value (which came from 
the source) and inserted by post_load() into zpci_table.
> 
> 
>>>> +    if (found_pbdev == pbdev) {
> 
> similarly this should also be true?

No always true, as described above.

> 
> 
>>>> + g_hash_table_remove(s390_get_phb()->zpci_table, &pbdev->idx);
> 
> Don't we have to free this idx now? so reverse of s390_pci_alloc_idx()?

AFA I can see, simply removing pbdev->idx from zpci_table already 
"frees" the idx value for reuse. s390_pci_alloc_idx() interprets 
s->next_idx as the "next mostly likely free" idx value. It then checks 
if zpci_table has this idx; if it does, it checks idx+1, etc. until it 
doesn't.

It seems, we could add "s->next_idx = pbdev->idx;" here to make it pick 
this idx next time instead of larger values, but it's not strictly 
necessary. Do you think we should do it?

> 
> 
>>>> +    }
>>>> +
>>>> +    return 0;
>>>> +}
>>>> +
>>>> +static int s390_pci_device_post_load(void *opaque, int version_id)
>>>> +{
>>>> +    S390PCIBusDevice *pbdev = S390_PCI_DEVICE(opaque);
>>>> +
>>>>       /*
>>>> -     * TODO: add state handling here, so migration works at least with
>>>> -     * emulated pci devices on s390x
>>>> +     * Now that pbdev->idx has been loaded, use it to place pbdev 
>>>> back into
>>>> +     * the table. This may replace a different not-yet-state-loaded 
>>>> pbdev,
>>>> +     * but pre_load() handles this case.
>>>>        */
>>>> -    .unmigratable = 1,
>>>> +    g_hash_table_replace(s390_get_phb()->zpci_table, &pbdev->idx, 
>>>> pbdev);
>>>> +
>>>> +    /*
>>>> +     * Regenerate IOMMU state, including IOTLB contents and QEMU 
>>>> memory regions.
>>>> +     */
>>>> +    if (pbdev->iommu_enabled) {
>>>> +        assert(pbdev->iommu);
>>>> +        if (s390_pci_is_translation_enabled(pbdev->g_iota)) {
>>>> +            s390_pci_iommu_enable(pbdev);
>>>> +            s390_pci_ioat_replay(pbdev);
>>>> +        } else {
>>>> +            s390_pci_iommu_direct_map_enable(pbdev);
>>>> +        }
>>>> +    }
>>>> +
>>>> +    /*
>>>> +     * Guest sets fmb_addr by mpcifc.ZPCI_MOD_FC_SET_MEASURE 
>>>> instruction,
>>>> +     * whose handler consequently starts fmb_timer. We may need to 
>>>> restart it.
>>>> +     */
>>>> +    if (pbdev->fmb_addr) {
>>>> +        assert(!pbdev->fmb_timer);
>>>> +        assert(pbdev->pci_group);
>>>> +        pbdev->fmb_timer = timer_new_ms(QEMU_CLOCK_VIRTUAL,
>>>> +                                        fmb_update, pbdev);
>>>> +        timer_mod(pbdev->fmb_timer,
>>>> +                  qemu_clock_get_ms(QEMU_CLOCK_VIRTUAL) +
>>>> + pbdev->pci_group->zpci_group.mui);
>>>> +    }
>>>> +    return 0;
>>>> +} 


