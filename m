Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5899FC61DC4
	for <qemu-devel@archiver.kernel.org>; Thu, 27 Aug 2026 14:56:48 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wzbWQ-0002DE-CN; Thu, 27 Aug 2026 10:56:06 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jrossi@linux.ibm.com>)
 id 1wzbWN-0002CP-Us; Thu, 27 Aug 2026 10:56:03 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jrossi@linux.ibm.com>)
 id 1wzbWM-0007pW-9G; Thu, 27 Aug 2026 10:56:03 -0400
Received: from pps.filterd (m0360083.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 67REWRar3253831; Thu, 27 Aug 2026 14:56:00 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=pp1; bh=c9IA+8
 CACeGTkhuFBNuRHSwAazkO1BF2VNrTHZemy2g=; b=ltOarTFg/SIsZOrEkKQIIO
 l91j7IQWFoKRheYkrlYv1Qsgj+g4vwtbSw+aVas/n+lqOjIRWp6rdy0j+ipPFW1w
 MZgeEV6sCwecFKOegy+6sRszo4RZzNINIqMizPAc0fkVTTRyXtpkYCnOnKE5ElLC
 BqqdFmYQIpjsCecAEit8KbGCP60eIzL8j7o4EGzhQSv7KRRXuiS3yUP6JPKjGRJ1
 tElsto+GceCzLhpkzrwGZVHMD7BxuwF6hvVtmyH7NRq6/Gfr4MLz9Hagy4cSNauK
 rRLffii7u218ot3HQRiziASd04SBUVYoZbMRhhisZM0P7rrS/dGU7GQY3O8bhzcQ
 ==
Received: from ppma13.dal12v.mail.ibm.com
 (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4g7394e3gm-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 27 Aug 2026 14:55:59 +0000 (GMT)
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
 by ppma13.dal12v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 67REfGwa024289;
 Thu, 27 Aug 2026 14:55:58 GMT
Received: from smtprelay06.wdc07v.mail.ibm.com ([172.16.1.73])
 by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 4g7ragrfdr-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 27 Aug 2026 14:55:58 +0000 (GMT)
Received: from smtpav06.dal12v.mail.ibm.com (smtpav06.dal12v.mail.ibm.com
 [10.241.53.105])
 by smtprelay06.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 67REtvru24052240
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Thu, 27 Aug 2026 14:55:57 GMT
Received: from smtpav06.dal12v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id E5E1458059;
 Thu, 27 Aug 2026 14:55:56 +0000 (GMT)
Received: from smtpav06.dal12v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 0E2DD5805F;
 Thu, 27 Aug 2026 14:55:56 +0000 (GMT)
Received: from [9.61.69.254] (unknown [9.61.69.254])
 by smtpav06.dal12v.mail.ibm.com (Postfix) with ESMTPS;
 Thu, 27 Aug 2026 14:55:55 +0000 (GMT)
Message-ID: <24067aa8-d388-42a7-8f99-ef9ff67c21c8@linux.ibm.com>
Date: Thu, 27 Aug 2026 10:55:55 -0400
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 6/8] pc-bios/s390-ccw: Add support for virtio-scsi-pci
 IPL
To: Eric Farman <farman@linux.ibm.com>, qemu-devel@nongnu.org,
 qemu-s390x@nongnu.org, cohuck@redhat.com, mjrosato@linux.ibm.com
Cc: zycai@linux.ibm.com
References: <20260811144629.866641-1-jrossi@linux.ibm.com>
 <20260811144629.866641-7-jrossi@linux.ibm.com>
 <4bbbb758-45bb-4b98-b782-966bfdf4e544@linux.ibm.com>
Content-Language: en-US
From: Jared Rossi <jrossi@linux.ibm.com>
In-Reply-To: <4bbbb758-45bb-4b98-b782-966bfdf4e544@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: 4Xfn_zPpL5yuPCC2KARGD9wtUz2lol77
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODI3MDEyMiBTYWx0ZWRfXxMB/DTyEKst6
 ccCuLin1dPMVXPl5fa5VvqF66xeJdO6rrgXwMyZjVAl2iSnrB1a+0X+/8i/ocSfECaNRgS3ePR1
 I+VWYWi//cMwjKCxmbMwLO3/nAysYK2J2tKhcufIgEutwDTsjynndD4VNXO2uJatKKeEGOd4Rki
 iKNnSYpWhEfSrTWFMdw7bMeijr/34VnASAIdRwGdtOkEFGon0umd4oWtKL4CkSVKsceZKfs3qgs
 dJph/RCI5QCip8GLLejwEQAvo+7e7U7XZoAJzh5rzB2SXD2bOuo0fE2k//51ZZpd1NsjHK+oZDc
 +WJoIuLzDrYgGPZvi670maapXIBX/VMObP/ydGKnzdxT7in38zeSFWfjWOEnJc6Eo+am/c4WZaW
 waNcz48UzT8xR1tT+/1JYHizBr8HvwgkK3ZgyPl+HoaZ+ZbDEgGu36CnhAx7r8zwHRydvnAPaiM
 YTVr6GC1EVRkOfmuYYQ==
X-Authority-Analysis: v=2.4 cv=Y/nIdBeN c=1 sm=1 tr=0 ts=6a904fff cx=c_pps
 a=AfN7/Ok6k8XGzOShvHwTGQ==:117 a=AfN7/Ok6k8XGzOShvHwTGQ==:17
 a=IkcTkHD0fZMA:10 a=Sv0fKeRqtYgA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=iQ6ETzBq9ecOQQE5vZCe:22 a=VnNF1IyMAAAA:8
 a=ZEU_LyBYAoiLnEfqniIA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
X-Proofpoint-Spam-Info: AW1haW4tMjYwODI3MDEyMiBTYWx0ZWRfX6U1EenBCyTZs
 B9L2H0xasx+cR0aZY1kg8lOivGQQ9upETyEKvtinBNBwhy7xsVpEhUra0rBDKd1ozwwbHosMCZ9
 dMIJcpEkapvRYD+owAuD7rQfiZEBkFk=
X-Proofpoint-ORIG-GUID: 4Xfn_zPpL5yuPCC2KARGD9wtUz2lol77
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-27_05,2026-08-27_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 impostorscore=0 priorityscore=1501 adultscore=0 bulkscore=0
 suspectscore=0 malwarescore=0 clxscore=1015 lowpriorityscore=0 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2608270122
Received-SPF: pass client-ip=148.163.156.1; envelope-from=jrossi@linux.ibm.com;
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



On 8/26/26 5:11 PM, Eric Farman wrote:
>
>
> On 8/11/26 10:46 AM, jrossi@linux.ibm.com wrote:
>> From: Jared Rossi <jrossi@linux.ibm.com>
>>
[...]
>> diff --git a/pc-bios/s390-ccw/virtio-scsi.c 
>> b/pc-bios/s390-ccw/virtio-scsi.c
>> index 9ea00c6fe6..095d7ac430 100644
>> --- a/pc-bios/s390-ccw/virtio-scsi.c
>> +++ b/pc-bios/s390-ccw/virtio-scsi.c
>> @@ -16,6 +16,7 @@
>>   #include "scsi.h"
>>   #include "virtio-scsi.h"
>>   #include "virtio-ccw.h"
>> +#include "virtio-pci.h"
>>   #include "s390-time.h"
>>   #include "helper.h"
>>   @@ -479,7 +480,16 @@ static int virtio_scsi_setup(VDev *vdev)
>>     int virtio_scsi_setup_device(VDev *vdev)
>>   {
>> -    virtio_ccw_setup(vdev);
>> +    switch (vdev->ipl_type) {
>> +    case S390_IPL_TYPE_CCW:
>> +        virtio_ccw_setup(vdev);
>> +        break;
>> +    case S390_IPL_TYPE_PCI:
>> +        virtio_pci_setup(vdev);
>> +        break;
>
> Why was/is the return code from virtio_*_setup discarded? Shouldn't we 
> do -something- if it's nonzero instead of continuing on?
>
> Besides that, this looks good to me.
>

Unfortunately I don’t have a good answer for that.  That is just how it has
always been and so I didn’t change it; however, in the same vein as the
discussion with Matt about clarifying the IPLB length definitions from the
other day, now would be a good time to update it rather than continuing
existing bad practices.

I’ll propagate the return code on error in the next version.

Regards,
Jared Rossi

