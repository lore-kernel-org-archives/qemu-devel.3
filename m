Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2387B606A33B
	for <qemu-devel@archiver.kernel.org>; Thu, 19 Nov 2026 13:46:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=qiNm0FXH
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xU2Sn-0000zI-Ti; Thu, 19 Nov 2026 08:46:10 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <borntraeger@linux.ibm.com>)
 id 1xU2ST-0000yP-Ic; Thu, 19 Nov 2026 08:45:51 -0500
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <borntraeger@linux.ibm.com>)
 id 1xU2SR-0003Sr-CY; Thu, 19 Nov 2026 08:45:49 -0500
Received: from pps.filterd (m0353725.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 6AJBu9Vs2870886; Thu, 19 Nov 2026 13:45:42 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=pp1; bh=ONr4qM
 jCVEwcCCYQAcxxORvJQxl+3VTb0Sr7kxHw3/M=; b=qiNm0FXHy5on7uNtOCwOFQ
 Z19XyYEZqWgG0OJISQd52AQOzG7TB9S2aZQgM+cfeBS/+G1m4FYpxtu9KtSAUYe/
 OFb6QkdiKa0zlzLhz6rANUI8JemVnHK2BW5TMx1rZq9OPoMGaKb57rNIPoqqSf5A
 PCanScwjZE4a+mlkfwOCXu4QZ3Vrvj3SA3Tg8NQeL0DYFU2G+MlpRFwly0PAxYej
 gHYzPtEVnNmiGzwKIGQM01PaZnSgM3p/tjKPL2nQ3djjURbACb9hzgKenEii4k7+
 HMrJESFs/T8O2Regl1PGcMomjzjkaIjTtj7Dd8jcA+82WMMZuckdWwxcb9gR1Dvg
 ==
Received: from ppma13.dal12v.mail.ibm.com
 (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4j105w13n2-1
 (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
 Thu, 19 Nov 2026 13:45:42 +0000 (GMT)
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
 by ppma13.dal12v.mail.ibm.com (8.18.1.11/8.18.1.11) with ESMTP id
 6AJBo0m02498589; Thu, 19 Nov 2026 13:45:41 GMT
Received: from smtprelay02.fra02v.mail.ibm.com ([9.218.2.226])
 by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 4j1v9x9wb7-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 19 Nov 2026 13:45:41 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (smtpav02.fra02v.mail.ibm.com
 [10.20.54.101])
 by smtprelay02.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 6AJDjdqO49938772
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Thu, 19 Nov 2026 13:45:39 GMT
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id CD9092004E;
 Thu, 19 Nov 2026 13:45:39 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 7619A20040;
 Thu, 19 Nov 2026 13:45:39 +0000 (GMT)
Received: from [9.68.16.159] (unknown [9.68.16.159])
 by smtpav02.fra02v.mail.ibm.com (Postfix) with ESMTP;
 Thu, 19 Nov 2026 13:45:39 +0000 (GMT)
Message-ID: <661210fb-a40e-4e92-ad13-07e0238ed6b4@linux.ibm.com>
Date: Thu, 19 Nov 2026 14:45:39 +0100
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
X-Proofpoint-GUID: IsRm81-7XNBqsBLqGD6oB3uU1MUykx-W
X-Authority-Analysis: v=2.4 cv=Z8x5j3RA c=1 sm=1 tr=0 ts=6afefd86 cx=c_pps
 a=AfN7/Ok6k8XGzOShvHwTGQ==:117 a=AfN7/Ok6k8XGzOShvHwTGQ==:17
 a=IkcTkHD0fZMA:10 a=zJRp6_cAMcgA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=V8glGbnc2Ofi9Qvn3v5h:22 a=iW4lf9acZbQJq8buDm8A:9
 a=QEXdDO2ut3YA:10
X-Proofpoint-ORIG-GUID: IsRm81-7XNBqsBLqGD6oB3uU1MUykx-W
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTE5MDA1MyBTYWx0ZWRfXzeeQ3iFB/a28
 +VQzyyrmXlM0nB6vxeLfDyPX60CYSuavD7fiuKJBjO74y2KiMuwcBNywiKjVXf0Nz5l3DHOfZ7N
 NS2SCJLHxcGl2tq/18e3C7ndLkcPJm0=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTE5MDA1MyBTYWx0ZWRfXz1G5Yo4+xXf4
 atwAdF0y83vA/KqzjdYbv+zDM0kGUBoWQKepd/KVKgANDJ4GXwUebF+UeEwZ9lyHnSE/Y3U9spy
 rfgw6K576ZDFNh1rvrJEE4gUPumoLtaS9LQLAMIDGKP8kai4wt2sBG0k4JMzeNUcD4XTkywmxv8
 IdomdbBVQ6xbZFPSVBwWwo5kbsqV+R2kO7NVEfzcWsHfNaBgEN8MKF8ygHro2jd9Ladddowg4Mq
 sWbdb2uNal3E42Yb0xwp7LlZN1gXTrFiMXmAx0AQtavfnwKau2B64yTKVxZyviiKB3rVHTU0mMg
 f6RhA/q7R2GmdiaqXS6FbC1gXZibn1dhnqWcAWTiWeBFxk7bcwNFLocLOFOPpk+0MqvBf5y8QCE
 8Hc/Q5hbuzjlOHUJ9z6yvaPLdCKG5mfCbgFTob4/L9N4OIkG77jMcUd0je1Xo/VvO9RpwvO4Pq0
 4MhKmgmYYjReuAgKOFQ==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-19_03,2026-11-19_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 phishscore=0 lowpriorityscore=0 spamscore=0 malwarescore=0
 adultscore=0 bulkscore=0 clxscore=1015 impostorscore=0 priorityscore=1501
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2611040001 definitions=main-2611190053
Received-SPF: pass client-ip=148.163.158.5;
 envelope-from=borntraeger@linux.ibm.com; helo=mx0b-001b2d01.pphosted.com
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
X-Spam-Status: No, score=-5.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_PASS,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Am 13.11.26 um 14:31 schrieb Kevin Wolf:
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


Sorry for the delay, so this seems to be the following on my system.
/dev/disk/by-id/scsi-360050768108285159000000000000110

- scsi-3: Prefix indicating SCSI-3 device identification method
- 6: NAA (Network Address Authority) identifier type 6 (IEEE Registered Extended)
- 0050768108285159000000000000110: The actual 128-bit identifier (32 hex digits)

WWN vs WWID:
1. WWN (World Wide Name):
- Typically 64-bit (16 hex characters)
- Used for Fibre Channel devices
- Format: NAA identifier (4 bits) + vendor/device specific data

2. WWID (World Wide Identifier):
- Can be 64-bit, 128-bit, or even longer
- More generic term encompassing various identification schemes
- Includes SCSI device identifiers, which can use extended formats


NAA Type 6 (IEEE Registered Extended):
- Uses 128 bits instead of 64 bits
- Structure: 4-bit NAA (6) + 24-bit IEEE Company ID + 100-bit vendor-specific identifier
- In this example: 60050768 is IBM
- 108285159000000000000110 = IBM's vendor-specific 100-bit identifier (LUN number, array serial, etc.)
For the example the 110 is the LUN number.

and IF we define something new, we should be able to cover case like this
as well. How is not clear yet, I am just asking to not rush but rather have
something that is flexible enough.


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
> 
>> virtio SCSI LUN passthru has that but it is significantly slower
>> (factors) and that was also real feedback from that customer.
> 
> Does this mean that what the emulated scsi-hd offers is actually not
> good enough, but you have to use passthrough to enable this use case?
> What is the additional information they need?

for the 128 bit case yes.

