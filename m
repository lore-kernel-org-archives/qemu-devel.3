Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3E96BCA5FF0
	for <qemu-devel@archiver.kernel.org>; Mon,  5 Oct 2026 22:32:07 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xDrDg-00076p-3k; Mon, 05 Oct 2026 18:31:42 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kshk@linux.ibm.com>)
 id 1xDrDc-00076T-Lq; Mon, 05 Oct 2026 18:31:37 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kshk@linux.ibm.com>)
 id 1xDrDb-0001if-32; Mon, 05 Oct 2026 18:31:36 -0400
Received: from pps.filterd (m0353729.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 695Ha5rS3659545; Mon, 5 Oct 2026 22:31:29 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=pp1; bh=gxzA62
 YjceOkssD0Fi86ZZ5Nj0Cpn81yjD5+OY/0d50=; b=QxNk/WDqQXoVkNQSoN32r4
 FmXanYozSriTO0ZA3B4TdaTntgbFSHsTWN1wb/exMXT5ajg/N2MWTXzJ08s+PwKv
 Uu0d+qtCuRraAdbDKMwVt1U9cTSe8xAGJtyuV/NHP/Gw2MPkeav7LWh8ceEoYu3X
 itPD6DpcemRPSIy2yzO09hMXaUFXIIj+oCeaD1Y/Owc7qDXMGo7jjvecUoslgvC0
 fHEj/9S0m1uA9oWMqaDZCiS04cgiZlzf1CBhOcyLYwyPkWiMRkPFw7JIgVff47EK
 BS7lvz1ZVUvB9xF/jUCQjLqqNzeB9SlUZELMtzvNOG/SfUu1quaZJ6kO5PBaNAxA
 ==
Received: from ppma21.wdc07v.mail.ibm.com
 (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4h2scrcrm6-1
 (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
 Mon, 05 Oct 2026 22:31:29 +0000 (GMT)
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
 by ppma21.wdc07v.mail.ibm.com (8.18.1.11/8.18.1.11) with ESMTP id
 695LtO653214683; Mon, 5 Oct 2026 22:31:28 GMT
Received: from smtprelay06.wdc07v.mail.ibm.com ([172.16.1.73])
 by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4h3d1jqdu3-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Mon, 05 Oct 2026 22:31:28 +0000 (GMT)
Received: from smtpav01.dal12v.mail.ibm.com (smtpav01.dal12v.mail.ibm.com
 [10.241.53.100])
 by smtprelay06.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 695MVQTV64225684
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Mon, 5 Oct 2026 22:31:27 GMT
Received: from smtpav01.dal12v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id A6A5E58069;
 Mon,  5 Oct 2026 22:31:26 +0000 (GMT)
Received: from smtpav01.dal12v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 79CDC5806D;
 Mon,  5 Oct 2026 22:31:26 +0000 (GMT)
Received: from [9.61.249.221] (unknown [9.61.249.221])
 by smtpav01.dal12v.mail.ibm.com (Postfix) with ESMTP;
 Mon,  5 Oct 2026 22:31:26 +0000 (GMT)
Message-ID: <356bb71f-30a3-4bfd-b559-069dc377f415@linux.ibm.com>
Date: Mon, 5 Oct 2026 17:31:26 -0500
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v11 15/16] s390x/pci: Implement migration for emulated
 devices
Content-Language: en-US
To: Farhan Ali <alifm@linux.ibm.com>, mjrosato@linux.ibm.com
Cc: farman@linux.ibm.com, richard.henderson@linaro.org, iii@linux.ibm.com,
 david@kernel.org, cohuck@redhat.com, pasic@linux.ibm.com,
 borntraeger@linux.ibm.com, qemu-s390x@nongnu.org, qemu-devel@nongnu.org
References: <20260930145255.140164-1-kshk@linux.ibm.com>
 <20260930145255.140164-16-kshk@linux.ibm.com>
 <16c455c2-6f42-4041-9580-eb7292647759@linux.ibm.com>
From: Konstantin Shkolnyy <kshk@linux.ibm.com>
In-Reply-To: <16c455c2-6f42-4041-9580-eb7292647759@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDA1MDA4NyBTYWx0ZWRfX2832Vwnnmn8x
 LgcSUtVkb9TK8Y5fufPG0omI+aXDwvkNcCMJzja1DFYpvg8Od+g9xA5+AY9MuPMI7sobsO/Z9Nq
 BAGyArAl41iiXni/CnZwkkY2wy4BwQ4=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDA1MDA4NyBTYWx0ZWRfX6ly11n+igdkS
 Uht8Xg77cv7pmgqzHdyqWq6KQ82MUugrkjG7zN4e7y6BHKWHlIxVffrzRahpOKFiJskPIXIV6cP
 3YHR8QtZtwF8u4svQuKeGuGZemkeOV2OjrBwk96JLrVNPoR4oVqAkWa8tMUFzMdELOf+KPHwrBV
 qQgyhd/3am/8sKxWvplK9zPxYzVOCX/wAmgeHQlFN/2JJFoQ0yVlj5mt8hrzRb/SIFdoM660HTO
 k0byteKnLLxXub7xPYnd1g2c7OTmvcX4rVN7QeLEk7NPYub53rOb1td7c9nxkcXFUYxV+MWQw9e
 LN56l1EhafZcdXRk6/DZClM6ANTYFtzKZqVLxCIOqhtBC8j3/FIIb5N79lX+fbq5kW1UxKDVSFw
 YZNE/3jg4SLGr1CdVwSkN6ez+c0U+NkS7qO0G33OtaNzvcFZ/+YzwQ57QwdNQiFoGAj6v5oajBY
 uFGTCkEJBex9pNMid0w==
X-Proofpoint-GUID: 3Y9-oIX0bwpHr0yHROtApPqCTP6xvsKS
X-Proofpoint-ORIG-GUID: 3Y9-oIX0bwpHr0yHROtApPqCTP6xvsKS
X-Authority-Analysis: v=2.4 cv=B7osQ+tM c=1 sm=1 tr=0 ts=6ac42541 cx=c_pps
 a=GFwsV6G8L6GxiO2Y/PsHdQ==:117 a=GFwsV6G8L6GxiO2Y/PsHdQ==:17
 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=uAbxVGIbfxUO_5tXvNgY:22 a=KcSuzNGMq5mVtTIlaKgA:9
 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-05_05,2026-10-05_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 bulkscore=0 malwarescore=0 impostorscore=0 phishscore=0
 clxscore=1015 spamscore=0 adultscore=0 lowpriorityscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2609040000 definitions=main-2610050087
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

On 261005 17:20, Farhan Ali wrote:
> <..snip..>
> 
> On 9/30/2026 7:52 AM, Konstantin Shkolnyy wrote:
>> +/*
>> + * When pending_sei load is executed, pending_sei can already contain 
>> SEIs
>> + * generated here in the target QEMU, for example, by state loads of 
>> zpci
>> + * devices. A dumb load here would place the older SEIs from the 
>> source QEMU
>> + * after the new SEIs. To fix this, we have pre_load() stash the new 
>> SEIs from
>> + * pending_sei and post_load() unstash them after the old ones.
>> + */
>> +static void s390_pci_move_sei_list(SeiContainerList *dst, 
>> SeiContainerList *src)
>> +{
>> +    SeiContainer *sei_cont;
>> +
>> +    while ((sei_cont = QTAILQ_FIRST(src))) {
>> +        QTAILQ_REMOVE(src, sei_cont, link);
>> +        QTAILQ_INSERT_TAIL(dst, sei_cont, link);
>> +    }
>> +}
>> +
>> +static int s390_pcihost_pending_sei_vmstate_pre_load(void *opaque)
>> +{
>> +    S390pciState *s = S390_PCI_HOST_BRIDGE(opaque);
>> +
>> +    QTAILQ_INIT(&s->pending_sei_stash);
>> +    s390_pci_move_sei_list(&s->pending_sei_stash, &s->pending_sei);
>> +    return 0;
>> +}
> 
> Does this mean we can append SEIs to the list while we are still 
> migrating? In that case do we need any form of synchronization here when 
> accessing the pending_sei list?

SEIs can be generated the migration process itself - by 
s390_pci_ioat_replay() called from s390_pci_device_post_load_errp().
That happens before the migration process comes here to load 
s390_pcihost state (with old SEIs).

Since the migration process is single-threaded I don't think we need to 
synchronize between its stages.

> 
> Thanks
> 
> Farhan
> 
>> +
>> +static int s390_pcihost_pending_sei_vmstate_post_load(void *opaque,
>> +                                                      int version_id)
>> +{
>> +    S390pciState *s = S390_PCI_HOST_BRIDGE(opaque);
>> +
>> +    s390_pci_move_sei_list(&s->pending_sei, &s->pending_sei_stash);
>> +    return 0;
>> +}
>> +
>> +static const VMStateDescription s390_pcihost_pending_sei_vmstate = {
>> +    .name = TYPE_S390_PCI_HOST_BRIDGE "/pending-sei",
>> +    .version_id = 1,
>> +    .minimum_version_id = 1,
>> +    .needed = s390_pcihost_pending_sei_vmstate_needed,
>> +    .pre_load = s390_pcihost_pending_sei_vmstate_pre_load,
>> +    .post_load = s390_pcihost_pending_sei_vmstate_post_load,
>> +    .fields = (const VMStateField[]) {
>> +        VMSTATE_QTAILQ_V(pending_sei, S390pciState, 1,
>> +                         vmstate_sei_container, SeiContainer, link),
>> +        VMSTATE_END_OF_LIST()
>> +    }
>> +};
>> +


