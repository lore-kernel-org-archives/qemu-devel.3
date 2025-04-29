Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5A789C369DC
	for <qemu-devel@archiver.kernel.org>; Tue, 29 Apr 2025 14:09:56 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u9le5-0001kV-Bi; Tue, 29 Apr 2025 10:09:13 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjrosato@linux.ibm.com>)
 id 1u9le2-0001fw-Sp; Tue, 29 Apr 2025 10:09:11 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjrosato@linux.ibm.com>)
 id 1u9le0-0006M1-Pq; Tue, 29 Apr 2025 10:09:10 -0400
Received: from pps.filterd (m0353729.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 53TE6rHp028151;
 Tue, 29 Apr 2025 14:09:05 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=pp1; bh=5nydxt
 aZDcw5q2n0MXjbyI/knMJUwOtNSMWt4e0/3wg=; b=eUZJdRvDRgnTKblx9dgsK2
 xf9nChTEDJIk3iQpuDRfs1/Y5yj35TYM7mVF7+w6jRvRwKhxtuYhbBOGlTuQoK97
 xyLyBUtk6w2VocPMytnsEDpS6TWGgrV54dYTQWq+6r9YswzGZ09nxH0VRcKh3i7p
 hyM58vN2wXIic0wo82A1t2WGZgAp0+Ms0E2mdVtI/thepcM8yuzBZjMxE30u/CyI
 kv2U9lV8nv7yHnzZmuD3Pzx2rTYpTyUkRtxEWgxYJRxzbK0PBggjIFU1IwhboSkO
 tvYcaBSn398uUjKiyUc4lW1euiMvfqFB9/1xWWuigMQMGLCnlH6aO9LUP4E24pMg
 ==
Received: from ppma11.dal12v.mail.ibm.com
 (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 46ah8mbksh-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 29 Apr 2025 14:09:04 +0000 (GMT)
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
 by ppma11.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 53TB1di2008542;
 Tue, 29 Apr 2025 14:09:04 GMT
Received: from smtprelay05.dal12v.mail.ibm.com ([172.16.1.7])
 by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 469ch33783-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 29 Apr 2025 14:09:04 +0000
Received: from smtpav04.dal12v.mail.ibm.com (smtpav04.dal12v.mail.ibm.com
 [10.241.53.103])
 by smtprelay05.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 53TE93jJ20054684
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Tue, 29 Apr 2025 14:09:03 GMT
Received: from smtpav04.dal12v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id EE79658066;
 Tue, 29 Apr 2025 14:09:02 +0000 (GMT)
Received: from smtpav04.dal12v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 35DA358056;
 Tue, 29 Apr 2025 14:09:02 +0000 (GMT)
Received: from [9.61.85.22] (unknown [9.61.85.22])
 by smtpav04.dal12v.mail.ibm.com (Postfix) with ESMTP;
 Tue, 29 Apr 2025 14:09:02 +0000 (GMT)
Message-ID: <27d5d332-bc7c-4036-a3d9-d4666411bd4a@linux.ibm.com>
Date: Tue, 29 Apr 2025 10:09:01 -0400
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] s390x: Clear RAM on diag308 subcode 3 reset
To: Christian Borntraeger <borntraeger@linux.ibm.com>,
 David Hildenbrand <david@redhat.com>,
 Nicholas Miehlbradt <nicholas@linux.ibm.com>, thuth@redhat.com,
 richard.henderson@linaro.org, iii@linux.ibm.com, pasic@linux.ibm.com,
 farman@linux.ibm.com, qemu-s390x@nongnu.org
Cc: qemu-devel@nongnu.org
References: <20250429052021.10789-1-nicholas@linux.ibm.com>
 <489d0473-579a-4850-a6d5-be38bf2954b9@redhat.com>
 <5863e80e-8296-4f63-bf7d-783b2a9aca0a@linux.ibm.com>
Content-Language: en-US
From: Matthew Rosato <mjrosato@linux.ibm.com>
In-Reply-To: <5863e80e-8296-4f63-bf7d-783b2a9aca0a@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: e3JCedogs6VyMwM4QsOp_zqnNJKghNmz
X-Proofpoint-GUID: e3JCedogs6VyMwM4QsOp_zqnNJKghNmz
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNDI5MDEwNSBTYWx0ZWRfX31q8XMMT03X/
 QIaX9jZR7EMruV6nYO+h9g+Q8TRGKBigU39JgC3arLj+A83TS/6Q2JTrXcw5XG6/Ud0/ilUCUEF
 zGbXczCygfGTzdg7gkBKM7pw4cRJQm6HPYeI65P225apI003RitqnaT8UUxHheVLj6q/FQTy2Dv
 bneizvJfah2h/ECVDo528KMaao3D4nGjugcQfBtLYfUYwCcDpXnIfmOLG9U8fW5T/cM6U/zz77j
 rS/n5WodXrJEdmAhmbZ3opb2sUhoafKhlQ26iRkxn/yU/pCL8hziRIcAr+Mcfv67WkNFMhNZxWD
 lmuUEg6Pe4DyJjU1oxnUzmcv8z9H94X4RpDRboZd5jOhsc5qchhZ7i8QqWcuTe4nzf6MAB4Eo+9
 kF/6OR6FxoExARZt6NuM1Ix+sl39r4gZBBdc2frtRhl7JSan5LT5AN4uk5D593IZVG1PpFbx
X-Authority-Analysis: v=2.4 cv=QNRoRhLL c=1 sm=1 tr=0 ts=6810dd80 cx=c_pps
 a=aDMHemPKRhS1OARIsFnwRA==:117 a=aDMHemPKRhS1OARIsFnwRA==:17
 a=IkcTkHD0fZMA:10 a=XR8D0OoHHMoA:10 a=VwQbUJbxAAAA:8 a=VnNF1IyMAAAA:8
 a=pFZH5SylCiH5rCbaQB4A:9 a=QEXdDO2ut3YA:10
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-04-29_05,2025-04-24_02,2025-02-21_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 suspectscore=0
 mlxlogscore=954 spamscore=0 clxscore=1011 mlxscore=0 malwarescore=0
 bulkscore=0 priorityscore=1501 phishscore=0 impostorscore=0
 lowpriorityscore=0 classifier=spam authscore=0 authtc=n/a authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2504070000
 definitions=main-2504290105
Received-SPF: pass client-ip=148.163.156.1;
 envelope-from=mjrosato@linux.ibm.com; helo=mx0a-001b2d01.pphosted.com
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

On 4/29/25 3:45 AM, Christian Borntraeger wrote:
> Am 29.04.25 um 09:37 schrieb David Hildenbrand:
> [...]
>> The only problem I see is with vfio devices is the new "memory pinned" mode. [1]
>>
>> There, we'd have to check if any such device is around (discarding of ram is disabled?), and fallback to actual zeroing of memory.
> 
> CC Matt to double check.

When triggering the "relaxed translation" mode via iommu.passthrough in the guest, we now take the default (for other platforms) memory_region_is_ram() path in vfio_listener_region_add/del() which handles the pin/unpin from vfio common code.  As for ram discarding, we then also use the vfio common path and only uncoordinated discards are disabled via:

vfio_ram_block_discard_disable() -> ram_block_uncoordinated_discard_disable()


> 
>>
>> [1] https://lkml.kernel.org/r/20250226210013.238349-1-mjrosato@linux.ibm.com
> 


