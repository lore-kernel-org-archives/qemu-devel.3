Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 66F27606A323
	for <qemu-devel@archiver.kernel.org>; Mon,  9 Nov 2026 13:22:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=G5rsquX9
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xQPJn-0003DM-AW; Mon, 09 Nov 2026 08:21:51 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <borntraeger@linux.ibm.com>)
 id 1xQPJc-0003CL-Bm; Mon, 09 Nov 2026 08:21:43 -0500
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <borntraeger@linux.ibm.com>)
 id 1xQPJY-0003eC-Vp; Mon, 09 Nov 2026 08:21:39 -0500
Received: from pps.filterd (m0356517.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 6A9DEuME3498708; Mon, 9 Nov 2026 13:21:32 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=pp1; bh=4nrj84
 ikXUcEvqKxg/cWknDJIKQyqvv08y8fkZJwHyY=; b=G5rsquX95V+WYcuP6LMhOF
 +7P7stjfkxbcYKarG+/Oe6rt2MQU38vy1HFqd/fAusMNKEkwry4KUJa6P1cbUqKw
 4LT6v3tTTeal589XQF30hA5jR66qXswe+kpmDRshV/h02Xo48KFRiZoch90ZJ42a
 tUMCrUDoOfw7V+PfHwcsmsMec9NPhxlnRypQdKCXZGG8PLGr5j3vxXVHY/CDUV3v
 hHHLj+ZzESAWM5AB6VpDqhJs4jApcmmaS2x83bEyQjHJ61sYF0d6UsWjYIiMoiNU
 W7zsk2f/gPVpv4dpe2BqqHe60o7Gmw38sfS7Th+oZetHyRLaUq/eaKunBQejyfmQ
 ==
Received: from ppma13.dal12v.mail.ibm.com
 (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4hsuq6n8w1-1
 (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
 Mon, 09 Nov 2026 13:21:31 +0000 (GMT)
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
 by ppma13.dal12v.mail.ibm.com (8.18.1.11/8.18.1.11) with ESMTP id
 6A9DK3oW3151421; Mon, 9 Nov 2026 13:21:31 GMT
Received: from smtprelay05.fra02v.mail.ibm.com ([9.218.2.225])
 by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 4htghfyk9n-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Mon, 09 Nov 2026 13:21:30 +0000 (GMT)
Received: from smtpav03.fra02v.mail.ibm.com (smtpav03.fra02v.mail.ibm.com
 [10.20.54.102])
 by smtprelay05.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 6A9DLTth50463182
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Mon, 9 Nov 2026 13:21:29 GMT
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 25D9D2004D;
 Mon,  9 Nov 2026 13:21:29 +0000 (GMT)
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id C8E0E2004B;
 Mon,  9 Nov 2026 13:21:28 +0000 (GMT)
Received: from [9.68.16.159] (unknown [9.68.16.159])
 by smtpav03.fra02v.mail.ibm.com (Postfix) with ESMTP;
 Mon,  9 Nov 2026 13:21:28 +0000 (GMT)
Message-ID: <259057b5-d900-4388-a4fc-b698860ba158@linux.ibm.com>
Date: Mon, 9 Nov 2026 14:21:28 +0100
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 0/4] virtio-blk: Deprecate silent truncation of serial
To: Kevin Wolf <kwolf@redhat.com>, qemu-block@nongnu.org
Cc: hreitz@redhat.com, stefanha@redhat.com, mst@redhat.com,
 devel@lists.libvirt.org, qemu-devel@nongnu.org
References: <20261029231001.194240-1-kwolf@redhat.com>
Content-Language: en-US
From: Christian Borntraeger <borntraeger@linux.ibm.com>
In-Reply-To: <20261029231001.194240-1-kwolf@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTA5MDA1MiBTYWx0ZWRfX2C79xBCPz96J
 ABggpokBWspN/dyCIE9QiX4YN/kT5cnVX1wHMi0n8heGiv/yh+sjUwaRL2hcd9Y6n54HLH1/hRI
 Ekt5L9+FXvdhYSPGwQKeV5s4xGGIvkc=
X-Authority-Analysis: v=2.4 cv=HbCB3SE8 c=1 sm=1 tr=0 ts=6af1c8db cx=c_pps
 a=AfN7/Ok6k8XGzOShvHwTGQ==:117 a=AfN7/Ok6k8XGzOShvHwTGQ==:17
 a=IkcTkHD0fZMA:10 a=zJRp6_cAMcgA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=U7nrCbtTmkRpXpFmAIza:22 a=fMhMjI8JUBvsDdDXyzIA:9
 a=QEXdDO2ut3YA:10
X-Proofpoint-ORIG-GUID: cmxOy97iPMdq3yDgMvjUtUlysfknwJwi
X-Proofpoint-GUID: cmxOy97iPMdq3yDgMvjUtUlysfknwJwi
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTA5MDA1MiBTYWx0ZWRfX1eGgA+wiGuo/
 m+eUPv+TY81l/zNvh+VZ1n2kl12vCmmXHvVfQb9tyKS7NT5JJaEvqp12y1sAnG1v8lqAwZIDnNx
 E7WjIfWcVGQ33hyBspXJ8C73oPO384rwnoY29E+i5GDa4CSAezmGMFsMVZswQP8PoJejzvLtEZS
 TaYpYZNtn+DVeNtcTkzwI5gaYjb2OIZPE377Fcc+r4DUvO4lI40XN4wESZgGGfa0KoMruwo//lg
 yG0D1Wxx120Vbuc7XefDuAGeDEE3IzwJuTOlczS6ZAww0w298P+0mKrITnQCyUvrEf7WTjO2lg4
 ef3jby2kerD/jsPiyTStN3jJ0wWNH/lRdRbO+raVSllXHvXWFwypgtLgwj7iviu+q0MHsuDhG0C
 /VqWYEwyAs+msRJFamk5bO6jgrD9u646V/P9o+780AP/5RGjCZIGtOWXGV5ohV3svlvJvJRMCug
 dMTqPRtD1nm5AJYmHgg==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-09_05,2026-11-06_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 adultscore=0 spamscore=0 bulkscore=0 phishscore=0
 impostorscore=0 priorityscore=1501 clxscore=1011 lowpriorityscore=0
 suspectscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2611040001
 definitions=main-2611090052
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
X-Spam-Status: No, score=-10.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_PASS,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Am 30.10.26 um 00:09 schrieb Kevin Wolf via Devel:
> QEMU has allowed the user to specify serials of arbitrary length for
> virtio-blk devices, even though the virtio-blk protocol can only
> communicate 20 characters of the serial to the guest. This means that a
> longer serial number on the command line is silently truncated to 20
> characters from the guest perspective.
> 
> As a first step to fix this, deprecate the silent truncation and turn it
> into a warning; we can later make this a hard error. While touching
> GET_ID, let's make it more spec compliant and clean up the internal
> state.
> 
> Another part is planned that will actually enable users to use longer
> serials and additional device identifiers. This will need spec changes
> and would take more time than we have until the QEMU 11.2 freeze anyway,
> so I'll address this later. For now, the important thing is to get the
> deprecation period started.

Consider me interested for future extensions.
Additional information via virtio-blk would be really helpful. e.g. when
forwarding a scsi LUN having the WWID visible for virtio-blk would be really
nice. One usecase is that the guest visible WWID can be used to talk to
the storage server to create snapshots without having to have a translation
table from guest virtio-blk device to WWID. This was actually a real ask from
a customer.
virtio SCSI LUN passthru has that but it is significantly slower (factors)
and that was also real feedback from that customer.



> 
> v2:
> - Drop truncation of qdev property for now [Stefan]
> - Add test case for exactly 20 characters [Stefan]
> - Fix missing guest_free() [Stefan]
> - Pass pattern_byte to get_id_request() instead of hardcoding it
>    [Stefan]
> 
> Kevin Wolf (4):
>    virtio-blk: Implement full NUL padding for GET_ID
>    virtio-blk-test: Add a basic GET_ID test case
>    virtio-blk: Deprecate silent truncation of serial
>    virtio-blk-test: Test truncated serial
> 
>   docs/about/deprecated.rst     |  13 ++++
>   hw/block/virtio-blk.c         |  18 +++--
>   tests/qtest/virtio-blk-test.c | 119 ++++++++++++++++++++++++++++++++++
>   3 files changed, 146 insertions(+), 4 deletions(-)
> 


