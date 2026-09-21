Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F2C60C982E6
	for <qemu-devel@archiver.kernel.org>; Mon, 21 Sep 2026 15:13:15 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x8fhO-0007ME-0H; Mon, 21 Sep 2026 11:12:54 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kshk@linux.ibm.com>)
 id 1x8fhE-0007Iz-4e; Mon, 21 Sep 2026 11:12:46 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kshk@linux.ibm.com>)
 id 1x8fhC-0005Lj-Bv; Mon, 21 Sep 2026 11:12:43 -0400
Received: from pps.filterd (m0356517.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 68LF8ERn1869530; Mon, 21 Sep 2026 15:12:37 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=pp1; bh=T9x7ho
 IiPODg3K70CQ50jliDhrkk53SzD7DA5qMvEz0=; b=ibCSeLvZ0bz5CBsAvlQ7fY
 uPJMoRTQ6tDC4OxVsHu+kfD8MFs9vjMUp54M/FMvlAaw5LZyfr3nykWENmqEq6/W
 KRgQBbz01vIqzgGM/7H5oQ9Phok9ZGQhHrNMismXOEDO2pUxEX/ngez83XumPlok
 xs1B0ZL9d8WBSX8tMS5baN6vTkM25Uf9sy2NyZvdgUTGgZJG4vdWsQaqVhMg4XAq
 cpFy1deN02QVgwYoSYfB/j7J9yBVRqxvguQV4+Jl0DaQBL6tCseF+EkP/x+XUX/l
 Uege6eULJFMgDb+Pwwy/Mwv1rnvBJn1cNXRvhwyel/s4lx8vb+lC/0N7Fzn89N2w
 ==
Received: from ppma23.wdc07v.mail.ibm.com
 (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4gskgs19as-1
 (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
 Mon, 21 Sep 2026 15:12:36 +0000 (GMT)
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
 by ppma23.wdc07v.mail.ibm.com (8.18.1.11/8.18.1.11) with ESMTP id
 68LEIrd71371085; Mon, 21 Sep 2026 15:12:35 GMT
Received: from smtprelay05.dal12v.mail.ibm.com ([172.16.1.7])
 by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4gt67gns70-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Mon, 21 Sep 2026 15:12:35 +0000 (GMT)
Received: from smtpav02.dal12v.mail.ibm.com (smtpav02.dal12v.mail.ibm.com
 [10.241.53.101])
 by smtprelay05.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 68LFCYvg25559660
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Mon, 21 Sep 2026 15:12:34 GMT
Received: from smtpav02.dal12v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 778EF5805A;
 Mon, 21 Sep 2026 15:12:34 +0000 (GMT)
Received: from smtpav02.dal12v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 477A358051;
 Mon, 21 Sep 2026 15:12:34 +0000 (GMT)
Received: from [9.16.60.171] (unknown [9.16.60.171])
 by smtpav02.dal12v.mail.ibm.com (Postfix) with ESMTP;
 Mon, 21 Sep 2026 15:12:34 +0000 (GMT)
Message-ID: <0e59d36a-4757-4dc6-a72d-a2f185db835c@linux.ibm.com>
Date: Mon, 21 Sep 2026 10:12:34 -0500
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v8 15/16] s390x/pci: Implement migration for emulated
 devices
Content-Language: en-US
To: =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>,
 Farhan Ali <alifm@linux.ibm.com>
Cc: mjrosato@linux.ibm.com, farman@linux.ibm.com, richard.henderson@linaro.org,
 iii@linux.ibm.com, david@kernel.org, cohuck@redhat.com,
 pasic@linux.ibm.com, borntraeger@linux.ibm.com, qemu-s390x@nongnu.org,
 qemu-devel@nongnu.org
References: <20260911152137.676602-1-kshk@linux.ibm.com>
 <20260911152137.676602-16-kshk@linux.ibm.com>
 <7a2ec98c-6756-4c9f-8f86-1b0db94c8053@linux.ibm.com>
 <aqwkyvY8mxIEqDyH@redhat.com>
From: Konstantin Shkolnyy <kshk@linux.ibm.com>
In-Reply-To: <aqwkyvY8mxIEqDyH@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Authority-Analysis: v=2.4 cv=V/XoQuni c=1 sm=1 tr=0 ts=6ab14964 cx=c_pps
 a=3Bg1Hr4SwmMryq2xdFQyZA==:117 a=3Bg1Hr4SwmMryq2xdFQyZA==:17
 a=IkcTkHD0fZMA:10 a=VdqzKS8jKosA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=U7nrCbtTmkRpXpFmAIza:22 a=Mfe6H1zzADjr63ZobY0A:9
 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
X-Proofpoint-ORIG-GUID: f7kGE9NeZTBMmvlRU-sUOZFYxgZ2R-ty
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTIxMDIyMCBTYWx0ZWRfX6oaZI1jFz4sv
 E2SCXr7ZC32zbOvQJgYu7AhDYPaouz/kSR/nQfUfOaZvtj0blpt95RMPkPJge7lzdUtw6l5DWCZ
 4Ucj9fz4CYi3berUfQjMhOPnAffcnigB19uabShce22/NPH3ZUuQy/Q5y2Oba0pPbp+rdsLbwK5
 Cpnkx1SWFSCArE67d8T1seKNYY1PqmaDKTJrvVpPx+LPSmWlDk4gPndKzVaFyhrgH40rrzjT2aA
 JpdL+XTZ617CMso91jGO2XHD6XhB4w+gJkqjZVKrR0CoBgvW1uyI5TOJygHJH2EkDxAAVAqbGPx
 5tyOlvP6MQZP6lpjQlfPIkl3LpydgLEhV9s2XA8wNp8SGGqoSgC5VkPG4ThzmErv2fj/ZurUYcY
 uQCEiGGjSjnr9D9yv60t/2X6VpAnmyT+V7s4DWIrFbXL1/mzZnxxxM6c0MgFcgtyXf9Z81+M7MP
 2w3WSChpnZS3Co/o/RA==
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTIxMDIyMCBTYWx0ZWRfX6JpZy8gE4Gim
 YUkL746ftAo/75p6ll3joALOrjopW83MSJp8FY+w2SXl87Yt8WdGOgdJA6aGU9PXdoCrHl1BeMG
 G3RActBv9A9XsuvT6M0SPBBRcjKS7XM=
X-Proofpoint-GUID: f7kGE9NeZTBMmvlRU-sUOZFYxgZ2R-ty
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-21_05,2026-09-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 spamscore=0 malwarescore=0 clxscore=1011 phishscore=0
 bulkscore=0 adultscore=0 lowpriorityscore=0 impostorscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2609040000 definitions=main-2609210220
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

On 260917 12:35, Daniel P. Berrangé wrote:
> On Thu, Sep 17, 2026 at 10:25:32AM -0700, Farhan Ali wrote:
>>
>> On 9/11/2026 8:21 AM, Konstantin Shkolnyy wrote:
>>> @@ -1303,11 +1380,22 @@ static void s390_pcihost_unplug(HotplugHandler *hotplug_dev, DeviceState *dev,
>>>            pbdev = S390_PCI_DEVICE(dev);
>>>            pbdev->fid = 0;
>>>            QTAILQ_REMOVE(&s->zpci_devs, pbdev, link);
>>> -        g_hash_table_remove(s->zpci_table, &pbdev->idx);
>>> +        /*
>>> +         * If this QEMU is running a migrated guest, and was configured with
>>> +         * more zpci devices than the source QEMU, extra zpci devices could be
>>> +         * excluded from zpci_table and invisible to the guest and have
>>> +         * pbdev->idx values duplicating those of active devices. If the
>>> +         * pbdev being unplugged is such, the zpci_table entry for pbdev->idx
>>> +         * can find a different pbdev which we must not remove.
>>> +         */
>>> +        if (g_hash_table_lookup(s->zpci_table, &pbdev->idx) == pbdev) {
>>> +            g_hash_table_remove(s->zpci_table, &pbdev->idx);
>>> +        }
>>
>> If we are migrating, won't we re-create the exact same state and devices on
>> the target host? Is it possible that the target QEMU can have more devices
>> than source?
> 
> It is expected that the source and dest QEMU processes have identical
> virtual hardware configuration, and also no attempts should be made to
> hot-add/remove devices while migration is running.

Do you suggest to completely delete this hunk, or keep as "defensive 
tactic" and correct the comment?

> 
>>
>>
>>>            if (pbdev->dma_limit) {
>>>                s390_pci_end_dma_count(s, pbdev->dma_limit);
>>>            }
>>>            g_hash_table_destroy(pbdev->iotlb);
>>> +        s390_clear_zpci_migration_blocker(pbdev);
>>>            qdev_unrealize(dev);
>>>        }
>>
> 
> With regards,
> Daniel


