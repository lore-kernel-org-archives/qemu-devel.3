Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B2600C3601B
	for <qemu-devel@archiver.kernel.org>; Thu,  3 Apr 2025 20:34:17 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u0RFq-0004Zo-10; Thu, 03 Apr 2025 16:33:39 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alifm@linux.ibm.com>)
 id 1u0RFj-0004SY-9g; Thu, 03 Apr 2025 16:33:31 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alifm@linux.ibm.com>)
 id 1u0RFh-00045h-25; Thu, 03 Apr 2025 16:33:30 -0400
Received: from pps.filterd (m0360072.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 533HBcJa007394;
 Thu, 3 Apr 2025 20:33:22 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=pp1; bh=Ad5X7i
 yZcdKdfZDZgzgC3EvVAEElX+tmxjwceYlrqxc=; b=S8JS8/tAmiC04UWhctFiUL
 yfdcJw5yaIMNEnOb7/z+hxRIbD30P1kUAAYMoPeFfdbt+q0y5XsTDlt31NfJRjQY
 9dV8TcqSDXDa94u5JHiRdCPa01LpDvQQfviLcaCqKudFzK2EjxVH9AchL1T0LcDR
 UnxIBbdju5atXFIu6AmrABl2qLKSNj9JB6kJEHxDEYz7ocP5cIh/KshGjwPCtZZt
 URVXo601pO/TPpjrtuAQba9+zwfQbvshRhaFayIQYW6VAEsEuwFZwLiRKPgGz8Xg
 QCwceqw3Wy0wqlV4MRDzNpBRTRK0o0JeGjrZsj21ZsvfEExfu5kmgB18hHI7XO1Q
 ==
Received: from ppma12.dal12v.mail.ibm.com
 (dc.9e.1632.ip4.static.sl-reverse.com [50.22.158.220])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 45sxgxgxv9-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 03 Apr 2025 20:33:22 +0000 (GMT)
Received: from pps.filterd (ppma12.dal12v.mail.ibm.com [127.0.0.1])
 by ppma12.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 533KLx6M019413;
 Thu, 3 Apr 2025 20:33:21 GMT
Received: from smtprelay06.wdc07v.mail.ibm.com ([172.16.1.73])
 by ppma12.dal12v.mail.ibm.com (PPS) with ESMTPS id 45pu6texw2-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 03 Apr 2025 20:33:21 +0000
Received: from smtpav03.wdc07v.mail.ibm.com (smtpav03.wdc07v.mail.ibm.com
 [10.39.53.230])
 by smtprelay06.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 533KXK5F27263506
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Thu, 3 Apr 2025 20:33:20 GMT
Received: from smtpav03.wdc07v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 077CC5805C;
 Thu,  3 Apr 2025 20:33:20 +0000 (GMT)
Received: from smtpav03.wdc07v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id A431658054;
 Thu,  3 Apr 2025 20:33:18 +0000 (GMT)
Received: from [9.61.240.223] (unknown [9.61.240.223])
 by smtpav03.wdc07v.mail.ibm.com (Postfix) with ESMTP;
 Thu,  3 Apr 2025 20:33:18 +0000 (GMT)
Message-ID: <d9e4feb3-351c-4c0b-8c8e-a5141e80ed5e@linux.ibm.com>
Date: Thu, 3 Apr 2025 13:33:17 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 0/3] Enable QEMU NVMe userspace driver on s390x
To: Alex Williamson <alex.williamson@redhat.com>
Cc: Stefan Hajnoczi <stefanha@redhat.com>,
 Niklas Schnelle <schnelle@linux.ibm.com>, qemu-devel@nongnu.org,
 qemu-block@nongnu.org, qemu-s390x@nongnu.org, fam@euphon.net,
 philmd@linaro.org, kwolf@redhat.com, hreitz@redhat.com,
 thuth@redhat.com, mjrosato@linux.ibm.com,
 =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@redhat.com>
References: <20250401172246.2688-1-alifm@linux.ibm.com>
 <20250402155152.GE304512@fedora>
 <2c11a602415f0780030d4e68a28eee7ffcdd8cb7.camel@linux.ibm.com>
 <20250403154442.GA349582@fedora>
 <20250403102704.7e1f4452.alex.williamson@redhat.com>
 <2c244588-b37b-4e86-863e-ef462343edad@linux.ibm.com>
 <20250403120504.2f660171.alex.williamson@redhat.com>
Content-Language: en-US
From: Farhan Ali <alifm@linux.ibm.com>
In-Reply-To: <20250403120504.2f660171.alex.williamson@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: z8WtcjLwPxUtDZ0V0D-1UM7IdkWM7qHa
X-Proofpoint-GUID: z8WtcjLwPxUtDZ0V0D-1UM7IdkWM7qHa
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1095,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-04-03_09,2025-04-03_03,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 mlxscore=0
 lowpriorityscore=0 spamscore=0 malwarescore=0 suspectscore=0 clxscore=1015
 adultscore=0 phishscore=0 bulkscore=0 impostorscore=0 mlxlogscore=999
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.19.0-2502280000
 definitions=main-2504030108
Received-SPF: pass client-ip=148.163.158.5; envelope-from=alifm@linux.ibm.com;
 helo=mx0b-001b2d01.pphosted.com
X-Spam_score_int: -26
X-Spam_score: -2.7
X-Spam_bar: --
X-Spam_report: (-2.7 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, RCVD_IN_DNSWL_LOW=-0.7,
 RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org


On 4/3/2025 11:05 AM, Alex Williamson wrote:
> On Thu, 3 Apr 2025 10:33:52 -0700
> Farhan Ali <alifm@linux.ibm.com> wrote:
>
>> On 4/3/2025 9:27 AM, Alex Williamson wrote:
>>> On Thu, 3 Apr 2025 11:44:42 -0400
>>> Stefan Hajnoczi <stefanha@redhat.com> wrote:
>>>   
>>>> On Thu, Apr 03, 2025 at 09:47:26AM +0200, Niklas Schnelle wrote:
>>>>> On Wed, 2025-04-02 at 11:51 -0400, Stefan Hajnoczi wrote:
>>>>>> On Tue, Apr 01, 2025 at 10:22:43AM -0700, Farhan Ali wrote:
>>>>>>> Hi,
>>>>>>>
>>>>>>> Recently on s390x we have enabled mmap support for vfio-pci devices [1].
>>>>>> Hi Alex,
>>>>>> I wanted to bring this to your attention. Feel free to merge it through
>>>>>> the VFIO tree, otherwise I will merge it once you have taken a look.
>>>>>>
>>>>>> Thanks,
>>>>>> Stefan
>>>>>>       
>>>>>>> This allows us to take advantage and use userspace drivers on s390x. However,
>>>>>>> on s390x we have special instructions for MMIO access. Starting with z15
>>>>>>> (and newer platforms) we have new PCI Memory I/O (MIO) instructions which
>>>>>>> operate on virtually mapped PCI memory spaces, and can be used from userspace.
>>>>>>> On older platforms we would fallback to using existing system calls for MMIO access.
>>>>>>>
>>>>>>> This patch series introduces support the PCI MIO instructions, and enables s390x
>>>>>>> support for the userspace NVMe driver on s390x. I would appreciate any review/feedback
>>>>>>> on the patches.
>>>>>>>
>>>>>>> Thanks
>>>>>>> Farhan
>>>>> Hi Stefan,
>>>>>
>>>>> the kernel patch actually made it into Linus' tree for v6.15 already as
>>>>> commit aa9f168d55dc ("s390/pci: Support mmap() of PCI resources except
>>>>> for ISM devices") plus prerequisites. This went via the PCI tree
>>>>> because they included a change to struct pci_dev and also enabled
>>>>> mmap() on PCI resource files. Alex reviewed an earlier version and was
>>>>> the one who suggested to also enable mmap() on PCI resources.
>>>> The introduction of a new QEMU API for accessing MMIO BARs in this
>>>> series is something Alex might be interested in as QEMU VFIO maintainer.
>>>> That wouldn't have been part of the kernel patch review.
>>>>
>>>> If he's aware of the new API he can encourage other VFIO users to use it
>>>> in the future so that you won't need to convert them to work on s390x
>>>> again.
>>> I don't claim any jurisdiction over the vfio-nvme driver.  In general
>>> vfio users should be using either vfio_region_ops, ram_device_mem_ops,
>>> or directly mapping MMIO into the VM address space.  The first uses
>>> pread/write through the region offset, irrespective of the type of
>>> memory, the second provides the type of access used here where we're
>>> dereferencing into an mmap, and the last if of course the preferred
>>> mechanism where available.
>>>
>>> It is curious that the proposal here doesn't include any changes to
>>> ram_device_mem_ops for more generically enabling MMIO access on s390x.
>>> Thanks,
>>>
>>> Alex
>>
>> Hi Alex,
>>   From my understanding the ram_device_mem_ops sets up the BAR access for
>> a guest passthrough device. Unfortunately today an s390x KVM guest
>> doesn't use and have support for these MIO instructions. We wanted to
>> use this series as an initial test vehicle of the mmap support.
> Right, ram_device_mem_ops is what we'll use to access a BAR that
> supports mmap but for whatever reason we're accessing it directly
> through the mmap.  For instance if an overlapping quirk prevents the
> page from being mapped to the VM or we have some back channel mechanism
> where the VMM is interacting with the BAR.
>
> I bring it up here because it's effectively the same kind of access
> you're adding with these helpers and would need to be addressed if this
> were generically enabling vfio mmap access on s390x.

On s390x the use of the MIO instructions is limited to only PCI access. 
So i am not sure if we should generically apply this to all vfio mmap 
access (for non PCI devices).


>
> Prior to commit 2b8fe81b3c2e ("system/memory: use ldn_he_p/stn_he_p")
> the mmio helpers here might have been a drop-in replacement for the
> dereferencing of mmap offsets, but something would need to be done
> about the explicit PCI assumption introduced here and the possibility
> of unaligned accesses that the noted commit tries to resolve.  Thanks,
>
> Alex

AFAICT in qemu today the ram_device_mem_ops is used for non PCI vfio 
mmap cases. For s390x these helpers should be restricted to PCI 
accesses. For the unaligned accesses (thanks for pointing out that 
commmit!), are you suggesting we use the ld*_he_p/st*_he_p functions in 
the helpers i defined? Though those functions don't seem to be doing 
volatile accesses.

Thanks

Farhan



