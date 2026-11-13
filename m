Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D0578606A33F
	for <qemu-devel@archiver.kernel.org>; Fri, 13 Nov 2026 16:40:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=ccgmvIAW
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xRuJg-0003vi-KP; Fri, 13 Nov 2026 11:39:58 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <borntraeger@linux.ibm.com>)
 id 1xRuJY-0003r6-S5; Fri, 13 Nov 2026 11:39:49 -0500
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <borntraeger@linux.ibm.com>)
 id 1xRuJW-0001IG-TZ; Fri, 13 Nov 2026 11:39:48 -0500
Received: from pps.filterd (m0356517.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 6ADFiNIY3452903; Fri, 13 Nov 2026 16:39:42 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=pp1; bh=aNBZts
 2vVNY97XFKqrYMGIsAM6G8mEK9vPCtQMfK+vs=; b=ccgmvIAWOKsl3cUvKsHMGi
 fvtHZQzvkPac0CR6c3DRH0vopn9cz9EAZN4upn4+5MthesZt0DAkUh1G4T8iHaQZ
 73GaFACglAExMraZ8sswHZuQiSdeqNt4HSeiJIBL8zoa2xcV73f1d2QGQIqeEf7f
 BuUsXyNwUO9TkKxtsAivkPrthsKP0y46VRUsQ1sdO8AkZOuJO99wLW2KPNdNSq60
 a7PiiNn2Wzez0x8YvXNyAcHIgsrPle3iBH1vvJ3Shl0Kx/RjCqa6jhHow9QEWr6J
 YmXZLiDYv1uGcpUydyIT52bWewWLv58hfPvpWY9hbdggvZDZZH0TI4zImfdzV5VQ
 ==
Received: from ppma12.dal12v.mail.ibm.com
 (dc.9e.1632.ip4.static.sl-reverse.com [50.22.158.220])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4hsuq7ckkp-1
 (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
 Fri, 13 Nov 2026 16:39:42 +0000 (GMT)
Received: from pps.filterd (ppma12.dal12v.mail.ibm.com [127.0.0.1])
 by ppma12.dal12v.mail.ibm.com (8.18.1.11/8.18.1.11) with ESMTP id
 6ADFZF492483814; Fri, 13 Nov 2026 16:39:41 GMT
Received: from smtprelay04.fra02v.mail.ibm.com ([9.218.2.228])
 by ppma12.dal12v.mail.ibm.com (PPS) with ESMTPS id 4hwd85cup6-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Fri, 13 Nov 2026 16:39:41 +0000 (GMT)
Received: from smtpav03.fra02v.mail.ibm.com (smtpav03.fra02v.mail.ibm.com
 [10.20.54.102])
 by smtprelay04.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 6ADGddmF7405982
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Fri, 13 Nov 2026 16:39:39 GMT
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id A7ED320040;
 Fri, 13 Nov 2026 16:39:39 +0000 (GMT)
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 5B4B120043;
 Fri, 13 Nov 2026 16:39:38 +0000 (GMT)
Received: from [9.111.64.12] (unknown [9.111.64.12])
 by smtpav03.fra02v.mail.ibm.com (Postfix) with ESMTP;
 Fri, 13 Nov 2026 16:39:38 +0000 (GMT)
Message-ID: <c853e800-00a8-4cea-afe9-dd00777bceeb@linux.ibm.com>
Date: Fri, 13 Nov 2026 09:39:37 -0700
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 0/4] virtio-blk: Deprecate silent truncation of serial
To: Kevin Wolf <kwolf@redhat.com>
Cc: qemu-block@nongnu.org, hreitz@redhat.com, stefanha@redhat.com,
 mst@redhat.com, devel@lists.libvirt.org, qemu-devel@nongnu.org
References: <20261029231001.194240-1-kwolf@redhat.com>
 <259057b5-d900-4388-a4fc-b698860ba158@linux.ibm.com>
 <avcRG6PtcXbB0KvJ@redhat.com>
Content-Language: en-US
From: Christian Borntraeger <borntraeger@linux.ibm.com>
In-Reply-To: <avcRG6PtcXbB0KvJ@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTEzMDA2NSBTYWx0ZWRfX2j7hYy+WUs4+
 aFCaNNYYTlqEnTJmMiH6xyqxkexkpMO10L97w17NEaDKuWpLSjj0XCeqBUQXeITiegRxzZVVUzA
 qin+e4QqP47PEGuoDhAhm54RuTQnELU=
X-Authority-Analysis: v=2.4 cv=HbCB3SE8 c=1 sm=1 tr=0 ts=6af73d4e cx=c_pps
 a=bLidbwmWQ0KltjZqbj+ezA==:117 a=bLidbwmWQ0KltjZqbj+ezA==:17
 a=IkcTkHD0fZMA:10 a=zJRp6_cAMcgA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=U7nrCbtTmkRpXpFmAIza:22 a=iW4lf9acZbQJq8buDm8A:9
 a=QEXdDO2ut3YA:10
X-Proofpoint-ORIG-GUID: JcgwL7FgdQTXpPdBsz2SBwlYuxZQHDHL
X-Proofpoint-GUID: JcgwL7FgdQTXpPdBsz2SBwlYuxZQHDHL
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTEzMDA2NSBTYWx0ZWRfX5i85bT7xIrYf
 pZr1KlO30saMF32Fu8vlsvCi5KwUbbTcvOJk7sD9Vzx1MIKY3blTV+71PaecxveH4bJXfvRXlaJ
 QktkVXa9Uujr5p4n4UUX7QJaor9BJIaxMoDl6/dqdXtjo55yvot3yaAwKSx6OcvyaXj7+bInVFa
 aNnNFQ3geV948NCD8ztPxjNEb+ucxAFwNqAf1qL1cHCmXWW+DEsYPPW72WRaDlNAQR0N+JgGAdg
 ZR+v8L4f36yVHImiqf29M+3G6im8W3JKef3rrIGHzfg3nDMj+19VAonVuhoNAt7FLhqX+AY6roT
 mViv0QjDqlRDGm0kUfW9SI+aIbHUVRrPAJPqkC1h48Z0PRZWnWYyvrWa6Ue2SJL+u76wJCMQS+Z
 vgf98hQfhpvAEUkK6yNhOeAeU8Uh+/451Eg/OGTLIWT9biVyozwdF30BmeaPBTf3IhYtqbC8k9I
 hpENJJ87spnjRdQnPFg==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-13_05,2026-11-11_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 adultscore=0 spamscore=0 bulkscore=0 phishscore=0
 impostorscore=0 priorityscore=1501 clxscore=1015 lowpriorityscore=0
 suspectscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2611040001
 definitions=main-2611130065
Received-SPF: pass client-ip=148.163.156.1;
 envelope-from=borntraeger@linux.ibm.com; helo=mx0a-001b2d01.pphosted.com
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
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
X-Spam-Status: No, score=-5.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_PASS,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1



Am 13.11.26 um 06:31 schrieb Kevin Wolf:
> Am 09.11.2026 um 14:21 hat Christian Borntraeger geschrieben:
>> Am 30.10.26 um 00:09 schrieb Kevin Wolf via Devel:
>>> QEMU has allowed the user to specify serials of arbitrary length for
>>> virtio-blk devices, even though the virtio-blk protocol can only
>>> communicate 20 characters of the serial to the guest. This means that a
>>> longer serial number on the command line is silently truncated to 20
>>> characters from the guest perspective.
>>>
>>> As a first step to fix this, deprecate the silent truncation and turn it
>>> into a warning; we can later make this a hard error. While touching
>>> GET_ID, let's make it more spec compliant and clean up the internal
>>> state.
>>>
>>> Another part is planned that will actually enable users to use longer
>>> serials and additional device identifiers. This will need spec changes
>>> and would take more time than we have until the QEMU 11.2 freeze anyway,
>>> so I'll address this later. For now, the important thing is to get the
>>> deprecation period started.
>>
>> Consider me interested for future extensions.
>> Additional information via virtio-blk would be really helpful. e.g. when
>> forwarding a scsi LUN having the WWID visible for virtio-blk would be really
>> nice. One usecase is that the guest visible WWID can be used to talk to
>> the storage server to create snapshots without having to have a translation
>> table from guest virtio-blk device to WWID. This was actually a real ask from
>> a customer.
> 
> So let's talk about what specific information to add while we touch the
> spec. My first thought was adding whatever two or three things scsi-disk
> offers in qdev, but after actually looking at the code and the spec I'm
> not so sure any more. We seem to have:
> 
> - vendor, product (standard INQUIRY data)
> - serial (VPD page 0x80)
> - device_id (VPD page 0x83, vendor-specific descriptor for LUN)
> - wwn (VPD page 0x83, 64 bit NAA descriptor for LUN)
> - port_wwn (VPD page 0x83, 64 bit NAA descriptor for SAS target port)
> - port_index (VPD page 0x83, relative target port identifier for SAS target port)
> 
> For comparison, IDE seems to have:
> 
> - serial
> - model
> - wwn (64 bit NAA descriptor)
> 
> As virtio-blk is a single-disk device, it probably makes sense to leave
> out the non-LUN descriptors from SCSI.
> 
> It's also unclear to me that serial vs. device_id is something that
> would make sense in the context of virtio-blk. I don't really know how
> to explain an additional device_id in the spec and what would make it
> different from serial.
> 
> Maybe something like vendor/product/model would make sense where we
> would return "QEMU" and other implementations can return a different
> string (e.g. if guest drivers have to work around bugs in a specific
> implementation). Probably just a single field.
> 
> And then finally the WWID, where scsi-hd and ide-hd agree that it's a
> 64 bit number, but the SCSI spec is a lot more complicated. I think we
> want to have this, but the exact format to use in the virtio spec isn't
> entirely obvious. I've been thinking of maybe just referencing the SPC
> and adding the SCSI name string to the spec, which can represent the
> 64 bit NAA identifiers supported by scsi-hd and ide-hd, but can also
> express a few more things.
> 
> Any thoughts on all of this?
So I think the wwn is the most critical one.
For example
So the KVM host has scsi disks that appear in the guest as
/dev/disk/by-id/wwn-0x6005076307ffd72c0000000000002079
/dev/disk/by-id/dm-uuid-mpath-36005076307ffd72c0000000000002179

passing that through via virtio-blk does not provide this number in the guest.
passing it along via virtio-scsi as lun I have the same udev device in the
guest. Having the same for virtio-blk (maybe optionally) would be awesome.


> 
>> virtio SCSI LUN passthru has that but it is significantly slower
>> (factors) and that was also real feedback from that customer.
> 
> Does this mean that what the emulated scsi-hd offers is actually not
> good enough, but you have to use passthrough to enable this use case?
> What is the additional information they need?

It does mean that virtio-blk seems good enough (bandwidth and cpu wise) to
consolidate database workloads in KVM and virtio-scsi is not. Just try
fio on the same host nvme with virtio-blk, scsi disk and scsi lun. Its getting
slower with each step. And only the last variant (lun) uses SG_IO to pass along
then wwn.

