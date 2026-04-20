Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 88843F588CE
	for <qemu-devel@archiver.kernel.org>; Mon, 20 Apr 2026 13:53:57 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wEp3t-0000s0-5C; Mon, 20 Apr 2026 09:53:17 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jhkim@linux.ibm.com>)
 id 1wEp3r-0000rU-Ad; Mon, 20 Apr 2026 09:53:15 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jhkim@linux.ibm.com>)
 id 1wEp3p-0006Es-Iy; Mon, 20 Apr 2026 09:53:15 -0400
Received: from pps.filterd (m0356516.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 63K2RG3h4096139; Mon, 20 Apr 2026 13:53:07 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=pp1; bh=iMY3Vs
 wAZKHETJwPP+gIk/aU/+yed2tUxozW34aUkPc=; b=pJ3K5xZ5kbfcFcLdfITV1t
 qMLrLNyZzKU/lVAMncVWkegCEBwtw28ZHol/m37HY4RjJaEtlWgMIIMXaYKrFTrw
 OpqqwdoI7QpN+rjxgJ5bST8kM2KeJKnkDZAotE8uLZskUwXBP8gaoQYzt8morLxY
 33EjYaWQHndTfuNbS0Ifl97elnZD5VTiuA1kVoeHxFeotaRFea9Mc/qwOmTjSSjU
 erQigv0vY6tgv8FIMMc2oYI1rEY1QVnUHBLp+x04/vvuTo3VL1ehbQH1QbJ5j1v0
 WkjoCUjCAeTYXeDLwHXBJypvsmpOLZ5vZABWSKYGBsn5ZYZnu3pVEk1xXfgeB4EA
 ==
Received: from ppma12.dal12v.mail.ibm.com
 (dc.9e.1632.ip4.static.sl-reverse.com [50.22.158.220])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4dm2h9fcjx-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Mon, 20 Apr 2026 13:53:07 +0000 (GMT)
Received: from pps.filterd (ppma12.dal12v.mail.ibm.com [127.0.0.1])
 by ppma12.dal12v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 63KDoL2s000418;
 Mon, 20 Apr 2026 13:53:06 GMT
Received: from smtprelay06.wdc07v.mail.ibm.com ([172.16.1.73])
 by ppma12.dal12v.mail.ibm.com (PPS) with ESMTPS id 4dmm9pw47v-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Mon, 20 Apr 2026 13:53:06 +0000 (GMT)
Received: from smtpav04.dal12v.mail.ibm.com (smtpav04.dal12v.mail.ibm.com
 [10.241.53.103])
 by smtprelay06.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 63KDr4rM27918998
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Mon, 20 Apr 2026 13:53:05 GMT
Received: from smtpav04.dal12v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 9A43C5805E;
 Mon, 20 Apr 2026 13:53:04 +0000 (GMT)
Received: from smtpav04.dal12v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 6951358052;
 Mon, 20 Apr 2026 13:53:04 +0000 (GMT)
Received: from [9.16.58.46] (unknown [9.16.58.46])
 by smtpav04.dal12v.mail.ibm.com (Postfix) with ESMTP;
 Mon, 20 Apr 2026 13:53:04 +0000 (GMT)
Message-ID: <bb1bfa0e-127f-46dd-866d-6e2599f22e22@linux.ibm.com>
Date: Mon, 20 Apr 2026 08:53:03 -0500
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH RFC v1 1/1] hw/s390x/ccw: Disable legacy virtio-pci by
 default (v11.1+)
To: Cornelia Huck <cohuck@redhat.com>, Matthew Rosato
 <mjrosato@linux.ibm.com>, qemu-devel@nongnu.org, qemu-s390x@nongnu.org
Cc: richard.henderson@linaro.org, iii@linux.ibm.com, david@kernel.org,
 pasic@linux.ibm.com, borntraeger@linux.ibm.com, farman@linux.ibm.com
References: <20260417154332.849664-1-jhkim@linux.ibm.com>
 <20260417154332.849664-2-jhkim@linux.ibm.com> <877bq2szx1.fsf@redhat.com>
 <530e4dc5-3a3f-4556-bfd6-d6e9e5b5da0e@linux.ibm.com>
 <874il5u7bb.fsf@redhat.com>
Content-Language: en-US
From: JAEHOON KIM <jhkim@linux.ibm.com>
In-Reply-To: <874il5u7bb.fsf@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: WN3rz-I_5Vk5GQG1II-DixI1QFX9orPP
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDIwMDEzNCBTYWx0ZWRfX58WFs1P3daOF
 lBAkmeJUNhgG2xmf27+AUMXgv7ubjfy2cYAdfDvct8tNMyUkWEaEXAzj0flVVfMRzB37m7xq5kM
 x1k8Qc6ITGgFWoGhacqOvUVfRfhXrwGWAX+ld/JV9J5TKhjerH2ioQGdI0JG94opr7khCGFjNPq
 AtW22mhbKLH0wg0fj1ODSdilgYUia2MbKBW6wEWExdGkEoGBVpbnak2CAFQKS62oHOTYfRr2pao
 8SCSgs7CjQVsOCsi+kYBlO4jvGy/sOg0CNDmSDcDeGvB0IY4XyuQC3DgCjT1MQE2Xjblfop4kLm
 qzp+vClgtSTY/GjMlWgnRmr8FgQNgz6RDXJTCaikSub5bHcBZmCDeU4NdFurpcPwcnnsg6DmwVb
 176OHmRDZsLVsRQdl2EZpko/AGNfZwHBbI/YG6drz7SND8V3fX/NUGRgOOJXX14LjHuv4T6B1F5
 WrzEARuoftrJCw9E2ww==
X-Authority-Analysis: v=2.4 cv=XLYAjwhE c=1 sm=1 tr=0 ts=69e62fc3 cx=c_pps
 a=bLidbwmWQ0KltjZqbj+ezA==:117 a=bLidbwmWQ0KltjZqbj+ezA==:17
 a=IkcTkHD0fZMA:10 a=A5OVakUREuEA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=Y2IxJ9c9Rs8Kov3niI8_:22 a=VnNF1IyMAAAA:8
 a=IO8lvPEN2e6-r-GbVtsA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-GUID: WN3rz-I_5Vk5GQG1II-DixI1QFX9orPP
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-04-20_03,2026-04-17_04,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 bulkscore=0 impostorscore=0 spamscore=0 adultscore=0
 priorityscore=1501 phishscore=0 lowpriorityscore=0 malwarescore=0
 suspectscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2604070000
 definitions=main-2604200134
Received-SPF: pass client-ip=148.163.158.5; envelope-from=jhkim@linux.ibm.com;
 helo=mx0b-001b2d01.pphosted.com
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

On 4/20/2026 7:47 AM, Cornelia Huck wrote:
> On Mon, Apr 20 2026, Matthew Rosato <mjrosato@linux.ibm.com> wrote:
>
>> On 4/20/26 6:12 AM, Cornelia Huck wrote:
>>> On Fri, Apr 17 2026, Jaehoon Kim <jhkim@linux.ibm.com> wrote:
>>>
>>>> On the s390 Linux kernel, IO_SPACE_LIMIT has been 0 since the initial
>>>> zPCI implementation (commit cd24834130ac "s390/pci: base support"),
>>>> making I/O BARs unusable.
>>>>
>>>> However, when virtio-pci devices operate in transitional mode, QEMU
>>>> unconditionally exposes the legacy interface via BAR0. This results in
>>>> firmware warnings during PCI enumeration, such as:
>>>>
>>>>    pci 0005:00:00.0: [Firmware Bug]: BAR 0: invalid; can't size
>>>>
>>>> even though BAR0 is never usable on the s390 kernel.
>>>>
>>>> Close this gap by disabling legacy virtio-pci support starting from
>>>> machine version 11.1. This effectively makes virtio-pci devices
>>>> non-transitional and prevents the creation of the unusable legacy I/O
>>>> BAR.
>>>>
>>>> This introduces s390x-specific global compatibility properties that
>>>> set disable-legacy=on as the default for virtio-pci devices. Machine
>>>> versions v11.0 and earlier set disable-legacy=off to maintain their
>>>> original default behavior (legacy support enabled), ensuring VMs
>>>> created with those versions continue to work identically.
>>>>
>>>> Users can override the default on the command line if needed:
>>>>    - On v11.1+: -global virtio-pci.disable-legacy=off (to enable legacy)
>>>>    - On v11.0-: -global virtio-pci.disable-legacy=on (to disable legacy)
>>> Makes sense to disable legacy virtio-pci devices, if they cannot work
>>> anyway. I'm wondering if we want to have a generic "no legacy" switch as
>>> well. I remember a patch from some time ago, but that was concerned with
>>> endianness IIRC.
>> Thanks Connie, I was hoping to get your input on this idea.
>>
>> By generic, do you mean disabling legacy virtio-pci (and legacy
>> virtio-ccw?) across QEMU for all platforms vs only disabling it for s390x?
> If we are moving towards multi-arch binaries, it would need to be the
> latter; another benefit would be removing legacy bits from the virtio
> core. But I think we'd still need quite some time before we get there
> (virtio-pci switched to modern by default later than virtio-ccw.)
>
>>> Anyway, we cannot turn off pre-1.0 for virtio-ccw at the moment, because
>>> the bios still uses legacy virtio. Would be a bit of an effort to change
>>> that, but still sounds like a good idea to me.
>>>
>> Good point, hadn't thought about that and I guess it would be a pre-req
>> if you really wanted to disable legacy virtio everywhere; we can
>> certainly put this on our todo list for later, but I'd still like a
>> patch like this one to fix the awkward s390x virtio-pci situation now.
> Yep, this patch is fine for the current situation, I guess legacy
> virtio-ccw will stay around for a bit longer (and there's no urgent need
> to remove support for it as long as the virtio core still supports
> legacy easily.)
>
Thank you Connie and Matt for the discussion and feedback.
I'm glad this approach make sense for the current situation.
That's why I'll prepare a V2 with the suggested comment updates.

Regards,
Jaehoon Kim.


