Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 985FDCCD1AB
	for <qemu-devel@archiver.kernel.org>; Wed, 22 Oct 2025 19:44:53 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vBekw-0005m7-LA; Wed, 22 Oct 2025 15:44:22 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jrossi@linux.ibm.com>)
 id 1vBekv-0005lr-Hl; Wed, 22 Oct 2025 15:44:21 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jrossi@linux.ibm.com>)
 id 1vBekt-0003X8-Q0; Wed, 22 Oct 2025 15:44:21 -0400
Received: from pps.filterd (m0360083.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 59MINjcf018780;
 Wed, 22 Oct 2025 19:44:17 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=pp1; bh=k+zR8T
 5mBVTJxBUL/WoQBq9nQr6eqZ0VyqQAjKgO1kg=; b=C/OekOmIlJjpr1RDYoYdvU
 cLJFXjYD6KN+E++QJnjbG3V+yy6RQnQPag2y9z2rIjw8kk1XC6hlllvck8WBd6pY
 1MzRfuGFCYQAv8HoFTQ5ASlUwWGCEbcrlLOLYBPhln67r7TKGSAOoKubRi0BzFW1
 9nuocxIpjvNzRcFiSB9EyaIAIH6jXXzpfgxL0brZL9RKPTGtwunqvb8EzmZCVVOs
 45PgVkAtj54V5PzBrKB6q2rgcN+aK0j6HOsxAwdYSVBZzESnng6NMB4UvKSDihDu
 o8ICkBpBZSTH5BCJlSyfjf5Vu8cDzaxfesm78i0wA/RJ5r9YpWJ5WiAbkRFIy/7A
 ==
Received: from ppma22.wdc07v.mail.ibm.com
 (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 49v326xqwq-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Wed, 22 Oct 2025 19:44:17 +0000 (GMT)
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
 by ppma22.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 59MH1oDh017052;
 Wed, 22 Oct 2025 19:44:16 GMT
Received: from smtprelay03.wdc07v.mail.ibm.com ([172.16.1.70])
 by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 49vnky2bu1-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Wed, 22 Oct 2025 19:44:16 +0000
Received: from smtpav01.dal12v.mail.ibm.com (smtpav01.dal12v.mail.ibm.com
 [10.241.53.100])
 by smtprelay03.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 59MJi20T29295320
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Wed, 22 Oct 2025 19:44:02 GMT
Received: from smtpav01.dal12v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 9038258061;
 Wed, 22 Oct 2025 19:44:14 +0000 (GMT)
Received: from smtpav01.dal12v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id EC4A05805D;
 Wed, 22 Oct 2025 19:44:13 +0000 (GMT)
Received: from [9.61.130.101] (unknown [9.61.130.101])
 by smtpav01.dal12v.mail.ibm.com (Postfix) with ESMTPS;
 Wed, 22 Oct 2025 19:44:13 +0000 (GMT)
Message-ID: <9e8c6518-e959-481d-b72f-28676d83486c@linux.ibm.com>
Date: Wed, 22 Oct 2025 15:44:13 -0400
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/7] pc-bios/s390-ccw: Split virtio-ccw and generic virtio
To: Thomas Huth <thuth@redhat.com>, qemu-devel@nongnu.org,
 qemu-s390x@nongnu.org
Cc: jjherne@linux.ibm.com, alifm@linux.ibm.com, farman@linux.ibm.com,
 mjrosato@linux.ibm.com, zycai@linux.ibm.com
References: <20251020162023.3649165-1-jrossi@linux.ibm.com>
 <20251020162023.3649165-3-jrossi@linux.ibm.com>
 <da4df4ea-91b6-4dbc-9588-15db3f55b802@redhat.com>
Content-Language: en-US
From: Jared Rossi <jrossi@linux.ibm.com>
In-Reply-To: <da4df4ea-91b6-4dbc-9588-15db3f55b802@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Authority-Analysis: v=2.4 cv=EJELElZC c=1 sm=1 tr=0 ts=68f93411 cx=c_pps
 a=5BHTudwdYE3Te8bg5FgnPg==:117 a=5BHTudwdYE3Te8bg5FgnPg==:17
 a=IkcTkHD0fZMA:10 a=x6icFKpwvdMA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=VnNF1IyMAAAA:8 a=ROpxtOYYleRM3WZ7RPoA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMDE4MDAyMiBTYWx0ZWRfX+9fS9PDjAHD1
 +girV9zmdbwi1mj55IGrq8bAMad3lrxoMAYY9tstCpxwPS+QWnT7PmGv9JkAQCzwbTj7gdCRito
 s4ABuYIfUV+K+zkAgqSYDDRzCOC7ryFmeLF9F5eJfyM/d0XWTLdPi4rEn9dFxiKu/TKE2nOwEhG
 zA9Irj3du3kzfDwbyuS9WWufHcuN0IpP/Kyaj+mFMS31TzijhJpPQ/7qyHcz8JWgOv4vYxuj0Dc
 4PEQbKVpik/OXoM/q3/6FHlPFopU5zsUCoxRgfX87a2pgIUMAl7W9Yjjfpwy2vr/sBQ67Bccw2I
 8VktI2JfB6r7HNVsaDVzABXNwqBiguMJJ0+B7ed53BqNvDblVve+SyaSG2Ygp0rMae7HCR65nvp
 1tomyDX1DpbCcKuCeeSpyuk7/7CgNg==
X-Proofpoint-GUID: fGAdAgjoDwlZfKCnwF2Tlgiq04mxenc6
X-Proofpoint-ORIG-GUID: fGAdAgjoDwlZfKCnwF2Tlgiq04mxenc6
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-10-22_08,2025-10-22_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 priorityscore=1501 suspectscore=0 bulkscore=0 spamscore=0
 malwarescore=0 phishscore=0 adultscore=0 lowpriorityscore=0 clxscore=1015
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2510020000 definitions=main-2510180022
Received-SPF: pass client-ip=148.163.156.1; envelope-from=jrossi@linux.ibm.com;
 helo=mx0a-001b2d01.pphosted.com
X-Spam_score_int: -26
X-Spam_score: -2.7
X-Spam_bar: --
X-Spam_report: (-2.7 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, RCVD_IN_DNSWL_LOW=-0.7,
 RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
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

Hi Thomas,

Thanks for your comments...

On 10/21/25 5:23 AM, Thomas Huth wrote:
>  Hi Jared!
>
> On 20/10/2025 18.20, jrossi@linux.ibm.com wrote:
>> From: Jared Rossi <jrossi@linux.ibm.com>
>>
>> Separate the CCW specific virtio routines and create generic wrappers 
>> for easier
>> reuse of existing virtio functions with non-CCW devices.
>>
>> Signed-off-by: Jared Rossi <jrossi@linux.ibm.com>
>> ---
>>   hw/s390x/ipl.h                   |   5 -
>>   include/hw/s390x/ipl/qipl.h      |   6 +
>>   pc-bios/s390-ccw/iplb.h          |   4 -
>>   pc-bios/s390-ccw/virtio-ccw.h    |  25 ++++
>>   pc-bios/s390-ccw/virtio-scsi.h   |   2 +-
>>   pc-bios/s390-ccw/virtio.h        |  11 +-
>>   pc-bios/s390-ccw/main.c          |  13 +-
>>   pc-bios/s390-ccw/virtio-blkdev.c |  57 +++++---
>>   pc-bios/s390-ccw/virtio-ccw.c    | 240 +++++++++++++++++++++++++++++++
>>   pc-bios/s390-ccw/virtio-net.c    |   5 +-
>>   pc-bios/s390-ccw/virtio-scsi.c   |   7 +-
>>   pc-bios/s390-ccw/virtio.c        | 209 +++++----------------------
>>   pc-bios/s390-ccw/Makefile        |   3 +-
>>   13 files changed, 367 insertions(+), 220 deletions(-)
>>   create mode 100644 pc-bios/s390-ccw/virtio-ccw.h
>>   create mode 100644 pc-bios/s390-ccw/virtio-ccw.c
>>
> This patch is doing quite a bit of different changes at once, making 
> it hard to review ... It would be nice if you could at least move the 
> "S390_IPL_TYPE_*" movement into a separate patch.
Sure, I can break this up.  I think your suggestions about removing the 
global variables by storing them in the VDev struct make sense. I'll 
split it into smaller patches and clean up the things you mentioned.

Thanks,
Jared Rossi

