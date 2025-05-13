Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A121FC3ABC3
	for <qemu-devel@archiver.kernel.org>; Tue, 13 May 2025 06:51:41 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uEjTs-0002iG-Rq; Tue, 13 May 2025 02:51:12 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <borntraeger@linux.ibm.com>)
 id 1uEjTp-0002hA-Dj; Tue, 13 May 2025 02:51:09 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <borntraeger@linux.ibm.com>)
 id 1uEjTm-0004Bh-9b; Tue, 13 May 2025 02:51:09 -0400
Received: from pps.filterd (m0356516.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 54D0K2bg005028;
 Tue, 13 May 2025 06:50:38 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=pp1; bh=RNfCmR
 x9NO47/r3D3wcvaaroKqlVv2Uuz0WNzRJlAbs=; b=MfbP4Fuy7L40QXnzfEFsCg
 kuT2O5VJ3pfT+05J4HqAcRdog5GbZgDk5Rnsyi0xQ3OCgsGQAYcI7aJAp/X2T+k6
 g8x6P8JQKkZfdi2mL/QiYzWBKxeEBmICvkziTqtnNky4ivC+9WUDaQOmvWIBGGpA
 MDYZzPt74Il2J5veHmOCVFfpGGofS3kA9m6ImUQaUPp84ASiopnLse3EcugzuMjX
 57zwuq7NAC7GbwkAUBPupNzEDRrdkDkY+seIRPuLF3rWs/WrdykVynGj94eggVP5
 Brs7fl41+V1kyf+E2qAT1y6QYo+wC+fGdGdNU/uQH6ciq/Xc/utPmBR6g1uKyhDQ
 ==
Received: from ppma13.dal12v.mail.ibm.com
 (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 46kuephatr-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 13 May 2025 06:50:38 +0000 (GMT)
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
 by ppma13.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 54D3NNeq003606;
 Tue, 13 May 2025 06:50:37 GMT
Received: from smtprelay01.fra02v.mail.ibm.com ([9.218.2.227])
 by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 46jkbkhjqu-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 13 May 2025 06:50:37 +0000
Received: from smtpav04.fra02v.mail.ibm.com (smtpav04.fra02v.mail.ibm.com
 [10.20.54.103])
 by smtprelay01.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 54D6oY2754723054
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Tue, 13 May 2025 06:50:34 GMT
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id EE127201CF;
 Tue, 13 May 2025 06:50:33 +0000 (GMT)
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 93FE3201CC;
 Tue, 13 May 2025 06:50:33 +0000 (GMT)
Received: from [9.152.224.40] (unknown [9.152.224.40])
 by smtpav04.fra02v.mail.ibm.com (Postfix) with ESMTP;
 Tue, 13 May 2025 06:50:33 +0000 (GMT)
Message-ID: <14b9b607-c88a-4691-9872-cc6a51834c95@linux.ibm.com>
Date: Tue, 13 May 2025 08:50:33 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] s390x: Clear RAM on diag308 subcode 3 reset
To: Matthew Rosato <mjrosato@linux.ibm.com>,
 David Hildenbrand <david@redhat.com>,
 Nicholas Miehlbradt <nicholas@linux.ibm.com>, thuth@redhat.com,
 richard.henderson@linaro.org, iii@linux.ibm.com, pasic@linux.ibm.com,
 farman@linux.ibm.com, qemu-s390x@nongnu.org
Cc: qemu-devel@nongnu.org
References: <20250429052021.10789-1-nicholas@linux.ibm.com>
 <489d0473-579a-4850-a6d5-be38bf2954b9@redhat.com>
 <5863e80e-8296-4f63-bf7d-783b2a9aca0a@linux.ibm.com>
 <27d5d332-bc7c-4036-a3d9-d4666411bd4a@linux.ibm.com>
Content-Language: en-US
From: Christian Borntraeger <borntraeger@linux.ibm.com>
In-Reply-To: <27d5d332-bc7c-4036-a3d9-d4666411bd4a@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: o0ZzgkByD79XdfSB9jfxwu9W3Gz4MQ2_
X-Authority-Analysis: v=2.4 cv=e4gGSbp/ c=1 sm=1 tr=0 ts=6822ebbe cx=c_pps
 a=AfN7/Ok6k8XGzOShvHwTGQ==:117 a=AfN7/Ok6k8XGzOShvHwTGQ==:17
 a=IkcTkHD0fZMA:10 a=dt9VzEwgFbYA:10 a=SUMUnBiYsSFdsSyGjGkA:9
 a=QEXdDO2ut3YA:10
X-Proofpoint-ORIG-GUID: o0ZzgkByD79XdfSB9jfxwu9W3Gz4MQ2_
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNTEzMDA1NiBTYWx0ZWRfXyu95meOZZSKS
 FemxNVxc4FcDZZVqC5RIXIy3UwjDEFmeHXQWgcyP21IRIkjw/XLeAm18KUsqYvntz5Q0uRg0Y5k
 bSKZicKY0Wjt4hvsff5JJAf/R9/gLXbZI8hnnqpePrpXzm3c9eLZGVZgifG+rMAfQ+UlA3AfjwT
 +MY2RLqqTfNci4U0VGVGufNg/u5XbIFwEAnrCLJd3IB53RpVDU8KC9JusJj/UKP0aDv+SeQfjFd
 0qoMpNCOeLtqlmdHm5WRjVtxO8dKXwesK8R5GfeR+rAcLkOlWYy0T9Iy82ne0vzuDSYIRk2vHer
 TVHVX8oJmhWVgLl1e+Zp8z7/IKEM2+NPdkcqGUPPGZT/O2HAYP8OEPMuCkKIuGr4Fwv8KDnAgCt
 /YZM2ymyZZ2zbIWX4EktLIfXFzQVVftU7Wyee5sLkVgngAZObszctvjaCZb70gL7Zg3Gdf0n
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-05-12_07,2025-05-09_01,2025-02-21_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 mlxscore=0 phishscore=0
 spamscore=0 suspectscore=0 impostorscore=0 priorityscore=1501
 lowpriorityscore=0 clxscore=1015 mlxlogscore=823 adultscore=0
 malwarescore=0 bulkscore=0 classifier=spam authscore=0 authtc=n/a authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2504070000
 definitions=main-2505130056
Received-SPF: pass client-ip=148.163.158.5;
 envelope-from=borntraeger@linux.ibm.com; helo=mx0b-001b2d01.pphosted.com
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

Am 29.04.25 um 16:09 schrieb Matthew Rosato:
> On 4/29/25 3:45 AM, Christian Borntraeger wrote:
>> Am 29.04.25 um 09:37 schrieb David Hildenbrand:
>> [...]
>>> The only problem I see is with vfio devices is the new "memory pinned" mode. [1]
>>>
>>> There, we'd have to check if any such device is around (discarding of ram is disabled?), and fallback to actual zeroing of memory.
>>
>> CC Matt to double check.
> 
> When triggering the "relaxed translation" mode via iommu.passthrough in the guest, we now take the default (for other platforms) memory_region_is_ram() path in vfio_listener_region_add/del() which handles the pin/unpin from vfio common code.  As for ram discarding, we then also use the vfio common path and only uncoordinated discards are disabled via:
> 
> vfio_ram_block_discard_disable() -> ram_block_uncoordinated_discard_disable()

So this patch is good?


