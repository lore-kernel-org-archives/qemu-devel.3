Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4F624E65298
	for <qemu-devel@archiver.kernel.org>; Sun,  1 Feb 2026 22:02:00 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vmfVE-0001uE-5c; Sun, 01 Feb 2026 17:01:08 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jrossi@linux.ibm.com>)
 id 1vmfVC-0001tf-3B; Sun, 01 Feb 2026 17:01:06 -0500
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jrossi@linux.ibm.com>)
 id 1vmfVA-00023R-HU; Sun, 01 Feb 2026 17:01:05 -0500
Received: from pps.filterd (m0353729.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 611IlSnq015766;
 Sun, 1 Feb 2026 22:01:03 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=pp1; bh=uQ+Syv
 LPdbUU4e4xDKW1JllUo3y9D4qgr5JqNy6OlX8=; b=i1vIPvGNVoNJ9jSpOgl7qC
 tv1FMqO2V6y/CObury+RtGrp5tl0+t8q+NtRWEMjj6mxzJRbotHFL9GoVQ0pKyDk
 SPiDJ4aQVMzBisfpur+gwQspmL2CJnfteyRtVwty0528lKt11urD4waBe+DBKX3S
 rBrOrquct4QXj7gL9PKMuby1rLiJObFSUaokEhVUWy0KNxJBRUEU9UxVK7SKQpU6
 Q7qYYPAHKt5TjdSOtNdcyhRWHSS2N51BlXdH+gIeQcv9C8QYXRPre0I2wpeFUnoa
 W/jo1oU2V2TGn9iWo2sxu7hpGW6FLwpFVOFw/uaBJsIv9UOH8LFtsXewqzWmSCYw
 ==
Received: from ppma13.dal12v.mail.ibm.com
 (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4c19dswnaj-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Sun, 01 Feb 2026 22:01:02 +0000 (GMT)
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
 by ppma13.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 611GPwUr005938;
 Sun, 1 Feb 2026 22:01:01 GMT
Received: from smtprelay01.wdc07v.mail.ibm.com ([172.16.1.68])
 by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 4c1x9j2fyx-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Sun, 01 Feb 2026 22:01:01 +0000
Received: from smtpav05.wdc07v.mail.ibm.com (smtpav05.wdc07v.mail.ibm.com
 [10.39.53.232])
 by smtprelay01.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 611M0xhL54853892
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Sun, 1 Feb 2026 22:01:00 GMT
Received: from smtpav05.wdc07v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id E6FBD58053;
 Sun,  1 Feb 2026 22:00:59 +0000 (GMT)
Received: from smtpav05.wdc07v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 0F71758043;
 Sun,  1 Feb 2026 22:00:59 +0000 (GMT)
Received: from [9.61.23.27] (unknown [9.61.23.27])
 by smtpav05.wdc07v.mail.ibm.com (Postfix) with ESMTPS;
 Sun,  1 Feb 2026 22:00:58 +0000 (GMT)
Message-ID: <f3f24a73-a351-4c16-826f-953338ea78f0@linux.ibm.com>
Date: Sun, 1 Feb 2026 17:00:58 -0500
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 07/14] pc-bios/s390-ccw: Introduce CLP Architecture
To: Farhan Ali <alifm@linux.ibm.com>, qemu-devel@nongnu.org,
 qemu-s390x@nongnu.org, thuth@redhat.com, mst@redhat.com
Cc: jjherne@linux.ibm.com, farman@linux.ibm.com, mjrosato@linux.ibm.com,
 zycai@linux.ibm.com
References: <20260127161547.459443-1-jrossi@linux.ibm.com>
 <20260127161547.459443-8-jrossi@linux.ibm.com>
 <2494fe74-23bb-429c-b750-4fa674a67712@linux.ibm.com>
Content-Language: en-US
From: Jared Rossi <jrossi@linux.ibm.com>
In-Reply-To: <2494fe74-23bb-429c-b750-4fa674a67712@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMjAxMDE4OCBTYWx0ZWRfXxiou5H/XMgt2
 W6imgbv8dAYui6nA4OKSeS+4vPkr1GNtF6MSiI0nYhuGI6mjnJWHM3FbsFkZH13DT85SY4ovR07
 BIHmXjzQagAOsxvfeY/XO4kVYg1VNh3N/nY3HjUjhNvOQs48Gvju1/+VzojTxRVA/xJgYCEWOWX
 0lt2oSnYPEJveSbWZRgbN95XGIspw+JqjtYuMbrhmkSZQ1nhZLfxz39IpNm/eTmwCtVjOewCTXQ
 kV7U4p00yjma2q7c+6nh1Gd7JuDWbuo9o8k6neBR0uy7Yvd9XLjNWcoHbMGDKqWLnUQNoL9sx6f
 mu8pynexKHlcF9tpAqxsZ5cUmMsZ29K1OPmH3qW8akuURag4TY+vTF9ZPWKnoOlbHixs3UxJ59G
 dv6WdSKx2Caa74vuDY6QYDln7UAZ+mztKoeP31rnyUUL1MXhwayjZYcL0AoEplvJ5ZfjRBnwbok
 KA0/P3SfXCtxVw/xu5g==
X-Proofpoint-GUID: vNtCvRmEtkXtnuAP4aN1dlXjOk6SX_E4
X-Proofpoint-ORIG-GUID: vNtCvRmEtkXtnuAP4aN1dlXjOk6SX_E4
X-Authority-Analysis: v=2.4 cv=LesxKzfi c=1 sm=1 tr=0 ts=697fcd1e cx=c_pps
 a=AfN7/Ok6k8XGzOShvHwTGQ==:117 a=AfN7/Ok6k8XGzOShvHwTGQ==:17
 a=IkcTkHD0fZMA:10 a=HzLeVaNsDn8A:10 a=VkNPw1HP01LnGYTKEx00:22
 a=VnNF1IyMAAAA:8 a=7SZO-i-8Y9BoiA70XX8A:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-02-01_07,2026-01-30_04,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 impostorscore=0 spamscore=0 lowpriorityscore=0 clxscore=1015
 adultscore=0 suspectscore=0 priorityscore=1501 phishscore=0 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2601150000 definitions=main-2602010188
Received-SPF: pass client-ip=148.163.156.1; envelope-from=jrossi@linux.ibm.com;
 helo=mx0a-001b2d01.pphosted.com
X-Spam_score_int: -19
X-Spam_score: -2.0
X-Spam_bar: --
X-Spam_report: (-2.0 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, RCVD_IN_DNSWL_NONE=-0.0001,
 RCVD_IN_MSPIKE_H4=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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



On 1/29/26 5:54 PM, Farhan Ali wrote:
>
> On 1/27/2026 8:15 AM, jrossi@linux.ibm.com wrote:
>> From: Jared Rossi <jrossi@linux.ibm.com>
>>
>> Call Logical Processor (CLP) Architecture is used for managing PCI 
>> functions on
>> s390x. Define and include the structures and routines needed to 
>> interact with
>> PCI devices during IPL.
>>
>> Signed-off-by: Jared Rossi <jrossi@linux.ibm.com>
>> ---
>>   pc-bios/s390-ccw/Makefile |  2 +-
>>   pc-bios/s390-ccw/clp.c    | 96 +++++++++++++++++++++++++++++++++++++++
>>   pc-bios/s390-ccw/clp.h    | 24 ++++++++++
>>   3 files changed, 121 insertions(+), 1 deletion(-)
>>   create mode 100644 pc-bios/s390-ccw/clp.c
>>   create mode 100644 pc-bios/s390-ccw/clp.h
>>
>> diff --git a/pc-bios/s390-ccw/Makefile b/pc-bios/s390-ccw/Makefile
>> index 259cff09db..9c29548f84 100644
>> --- a/pc-bios/s390-ccw/Makefile
>> +++ b/pc-bios/s390-ccw/Makefile
>> @@ -35,7 +35,7 @@ QEMU_DGFLAGS = -MMD -MP -MT $@ -MF $(@D)/$(*F).d
>>     OBJECTS = start.o main.o bootmap.o jump2ipl.o sclp.o menu.o 
>> netmain.o \
>>         virtio.o virtio-net.o virtio-scsi.o virtio-blkdev.o cio.o 
>> dasd-ipl.o \
>> -      virtio-ccw.o
>> +      virtio-ccw.o clp.o
>>     SLOF_DIR := $(SRC_PATH)/../../roms/SLOF
>>   diff --git a/pc-bios/s390-ccw/clp.c b/pc-bios/s390-ccw/clp.c
>> new file mode 100644
>> index 0000000000..2a14bb9b73
>> --- /dev/null
>> +++ b/pc-bios/s390-ccw/clp.c
>> @@ -0,0 +1,96 @@
>> +/*
>> + * Call Logical Processor (CLP) architecture
>> + *
>> + * Copyright 2025 IBM Corp.
>> + * Author(s): Jared Rossi <jrossi@linux.ibm.com>
>> + *
>> + * SPDX-License-Identifier: GPL-2.0-or-later
>> + */
>> +
>> +#include "clp.h"
>> +#include <stdio.h>
>> +#include <string.h>
>> +
>> +int clp_pci(void *data)
>> +{
>> +    struct { uint8_t _[2048]; } *req = data;
>
> The architecture specifies that size of the request + response block 
> size can be maximum of 8192 bytes. If I understand correctly I think 
> QEMU (similar to kernel) uses CLP_BLK_SIZE when calculating the 
> CLP_FH_LIST_NR_ENTRIES, so it assumes that the request + response 
> block is 4096. So we can return more than 2048 bytes here and overflow.
>
> I think we should use at least CLP_BLK_SIZE here instead of 2048 or 
> set this to the maximum possible value of 8192.
>
> Thanks
>
> Farhan

Thanks for pointing that out, I'll fix it.

Regards,
Jared Rossi

>
>> +    int cc = 3;
>> +
>> +    asm volatile (
>> +        "     .insn   rrf,0xb9a00000,0,%[req],0,2\n"
>> +        "     ipm     %[cc]\n"
>> +        "     srl     %[cc],28\n"
>> +        : [cc] "+d" (cc), "+m" (*req)
>> +        : [req] "a" (req)
>> +        : "cc");
>> +    return cc;
>> +}
>> +
>>


