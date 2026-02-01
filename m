Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D09B2D172A9
	for <qemu-devel@archiver.kernel.org>; Sun,  1 Feb 2026 22:02:00 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vmfV7-0001t0-Rl; Sun, 01 Feb 2026 17:01:01 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jrossi@linux.ibm.com>)
 id 1vmfV6-0001sO-Cl; Sun, 01 Feb 2026 17:01:00 -0500
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jrossi@linux.ibm.com>)
 id 1vmfV4-00022Z-Ei; Sun, 01 Feb 2026 17:01:00 -0500
Received: from pps.filterd (m0356517.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 611JHld0016214;
 Sun, 1 Feb 2026 22:00:54 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=pp1; bh=SXIYTq
 rqGaomMMOo6jyulMHOvKR7gJTC+yij01pk3a4=; b=Zux9SA1lU9IJZAAyi2esHf
 SoKO3+qGvylb3J2gOBy+NF1fYE3FhiF6IwMfqmRFibpbQ9dt0tZTrgxmJaMG9wlM
 jRLk0q86GtH4CS27h/mmBHdo/3P/KtlU4k4aiUyouzrSRSn2Jg7FrvrWfFvp/i/O
 kUGVQjoQaD0QuEXeRuKhHOk8baKXDnv701zM5Nd1YaX1BOzEjmqssYfgcEtXPrEK
 BLT6CDPs6CDXuqya12MVf6ciXAmcRmvmo1Rsg0DXF+D3wZHXqnFd2K4N393sUmAU
 /Z6SjI1GsnViqAzN1pxjmgH1cywZFrUJzab//y+oqmepGARzW9ISGa99UnOAEMRQ
 ==
Received: from ppma23.wdc07v.mail.ibm.com
 (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4c19f65p2n-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Sun, 01 Feb 2026 22:00:54 +0000 (GMT)
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
 by ppma23.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 611M0iJD004437;
 Sun, 1 Feb 2026 22:00:53 GMT
Received: from smtprelay05.wdc07v.mail.ibm.com ([172.16.1.72])
 by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4c1wjjjm2n-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Sun, 01 Feb 2026 22:00:53 +0000
Received: from smtpav05.wdc07v.mail.ibm.com (smtpav05.wdc07v.mail.ibm.com
 [10.39.53.232])
 by smtprelay05.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 611M0pia33686244
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Sun, 1 Feb 2026 22:00:51 GMT
Received: from smtpav05.wdc07v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 8D31858059;
 Sun,  1 Feb 2026 22:00:51 +0000 (GMT)
Received: from smtpav05.wdc07v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id A479958043;
 Sun,  1 Feb 2026 22:00:50 +0000 (GMT)
Received: from [9.61.23.27] (unknown [9.61.23.27])
 by smtpav05.wdc07v.mail.ibm.com (Postfix) with ESMTPS;
 Sun,  1 Feb 2026 22:00:50 +0000 (GMT)
Message-ID: <bdf95a6f-2595-4456-ad8d-340352d979c6@linux.ibm.com>
Date: Sun, 1 Feb 2026 17:00:49 -0500
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 07/14] pc-bios/s390-ccw: Introduce CLP Architecture
To: Eric Farman <farman@linux.ibm.com>, qemu-devel@nongnu.org,
 qemu-s390x@nongnu.org, thuth@redhat.com, mst@redhat.com
Cc: jjherne@linux.ibm.com, alifm@linux.ibm.com, mjrosato@linux.ibm.com,
 zycai@linux.ibm.com
References: <20260127161547.459443-1-jrossi@linux.ibm.com>
 <20260127161547.459443-8-jrossi@linux.ibm.com>
 <0ac34654614bc76112ebab10bd4d610443dfdcc0.camel@linux.ibm.com>
Content-Language: en-US
From: Jared Rossi <jrossi@linux.ibm.com>
In-Reply-To: <0ac34654614bc76112ebab10bd4d610443dfdcc0.camel@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: UjjLzcrY-zetA-7SA0s13e3MqGKvanP2
X-Authority-Analysis: v=2.4 cv=drTWylg4 c=1 sm=1 tr=0 ts=697fcd16 cx=c_pps
 a=3Bg1Hr4SwmMryq2xdFQyZA==:117 a=3Bg1Hr4SwmMryq2xdFQyZA==:17
 a=IkcTkHD0fZMA:10 a=HzLeVaNsDn8A:10 a=VkNPw1HP01LnGYTKEx00:22
 a=VnNF1IyMAAAA:8 a=-Sy3nGRZguIjOQMJe-IA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-ORIG-GUID: UjjLzcrY-zetA-7SA0s13e3MqGKvanP2
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMjAxMDE4OCBTYWx0ZWRfXyZnDNwP1fBl1
 S5rRzg+2vOLXMTs9oCvH6gJaTuQkcLqSu1/HEOADElvPDEmc3bj6VgfKkbMBCVYJoPqzAdqfeKZ
 1c6INJ/WgMjloT4WjEK8tZ0Ep91Qcdd4Phz3VIJ1FzeGFHgRDml4Q+sDCeT8tmTQz+eQI9jHSzw
 Y/uVz/pBn1FQy+5bBr4iNUCLbHqkfuQksBInBCoGaec0yjMgociW1TpuMHrFxWJaIeTlmvGsEVr
 3mUOIbkQhHOOtNi9rnK0zR+h6qe9109xGtRxbJhbLuj+e6IeI3JsMqsnbJBhO7uZ50PaUo1K4O7
 uz0L1ZBP9z98cDyTzmmbBJHc7N5dFWURJLeswapq4540XKq10kVynAECa65Y6cRYXBWdWybjFbH
 vxqfeW82+PfshOA4tNPoOkEhq0Er6aMiViGpHH/uxM8uxa0FfrDZrTL40IC+IHfrHOmJ378HT1J
 oFuXDtWtIR+f+EZCXHA==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-02-01_07,2026-01-30_04,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 clxscore=1015 spamscore=0 malwarescore=0 bulkscore=0
 phishscore=0 adultscore=0 lowpriorityscore=0 impostorscore=0
 priorityscore=1501 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2601150000
 definitions=main-2602010188
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



On 1/29/26 4:52 PM, Eric Farman wrote:
> On Tue, 2026-01-27 at 11:15 -0500, jrossi@linux.ibm.com wrote:
>> From: Jared Rossi <jrossi@linux.ibm.com>
>>
>> Call Logical Processor (CLP) Architecture is used for managing PCI functions on
>> s390x. Define and include the structures and routines needed to interact with
>> PCI devices during IPL.
>>
>> Signed-off-by: Jared Rossi <jrossi@linux.ibm.com>
>> ---
>>   pc-bios/s390-ccw/Makefile |  2 +-
>>   pc-bios/s390-ccw/clp.c    | 96 +++++++++++++++++++++++++++++++++++++++
>>   pc-bios/s390-ccw/clp.h    | 24 ++++++++++
>>   3 files changed, 121 insertions(+), 1 deletion(-)
>>   create mode 100644 pc-bios/s390-ccw/clp.c
>>   create mode 100644 pc-bios/s390-ccw/clp.h
> First off, this looks like correct according to my reading.
>
> My only question is whether we need any breadcrumbs in case things fail? Dumping the requested FID
> in case of an enable, or the response code in either case? (I haven't gotten to the later patches
> yet, just looking at the puts here has me wondering if that's enough of a clue.)

Improving the logging makes sense; I'll add more useful output.

Thanks,
Jared Rossi

>
>> diff --git a/pc-bios/s390-ccw/Makefile b/pc-bios/s390-ccw/Makefile
>> index 259cff09db..9c29548f84 100644
>> --- a/pc-bios/s390-ccw/Makefile
>> +++ b/pc-bios/s390-ccw/Makefile
>> @@ -35,7 +35,7 @@ QEMU_DGFLAGS = -MMD -MP -MT $@ -MF $(@D)/$(*F).d
>>   
>>   OBJECTS = start.o main.o bootmap.o jump2ipl.o sclp.o menu.o netmain.o \
>>   	  virtio.o virtio-net.o virtio-scsi.o virtio-blkdev.o cio.o dasd-ipl.o \
>> -	  virtio-ccw.o
>> +	  virtio-ccw.o clp.o
>>   
>>   SLOF_DIR := $(SRC_PATH)/../../roms/SLOF
>>   
>> diff --git a/pc-bios/s390-ccw/clp.c b/pc-bios/s390-ccw/clp.c
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
>> +    struct { uint8_t _[2048]; } *req = data;
>> +    int cc = 3;
>> +
>> +    asm volatile (
>> +        "     .insn   rrf,0xb9a00000,0,%[req],0,2\n"
>> +        "     ipm     %[cc]\n"
>> +        "     srl     %[cc],28\n"
>> +        : [cc] "+d" (cc), "+m" (*req)
>> +        : [req] "a" (req)
>> +        : "cc");
>> +    return cc;
>> +}
>> +
>> +/*
>> + * Get the PCI function entry for a given function ID
>> + * Return 0 on success, 1 if the FID is not found, or a negative RC on error
>> + */
>> +int find_pci_function(uint32_t fid, ClpFhListEntry *entry)
>> +{
>> +    int count = 0;
>> +    int limit = PCI_MAX_FUNCTIONS;
>> +    ClpReqRspListPci rrb;
>> +
>> +    rrb.request.hdr.len = 32;
>> +    rrb.request.hdr.cmd = 0x02;
>> +    rrb.request.resume_token = 0;
>> +    rrb.response.hdr.len = sizeof(ClpRspListPci);
>> +
>> +    do {
>> +        if (clp_pci(&rrb) || rrb.response.hdr.rsp != 0x0010) {
>> +            puts("Failed to list PCI functions");
>> +            return -1;
>> +        }
>> +
>> +        /* Resume token set when max enteries are returned */
>> +        if (rrb.response.resume_token) {
>> +            count = CLP_FH_LIST_NR_ENTRIES;
>> +            rrb.request.resume_token = rrb.response.resume_token;
>> +        } else {
>> +            count = (rrb.response.hdr.len - 32) / sizeof(ClpFhListEntry);
>> +        }
>> +
>> +        limit -= count;
>> +
>> +        for (int i = 0; i < count; i++) {
>> +            if (rrb.response.fh_list[i].fid == fid) {
>> +                memcpy(entry, &rrb.response.fh_list[i], sizeof(ClpFhListEntry));
>> +                return 0;
>> +            }
>> +        }
>> +
>> +    } while (rrb.request.resume_token && limit > 0);
>> +
>> +    puts("No function entry found for FID!");
>> +
>> +    return 1;
>> +}
>> +
>> +/*
>> + * Enable the PCI function associated with a given handle
>> + * Return 0 on success or a negative RC on error
>> + */
>> +int enable_pci_function(uint32_t *fhandle)
>> +{
>> +    ClpReqRspSetPci rrb;
>> +
>> +    rrb.request.hdr.len = 32;
>> +    rrb.request.hdr.cmd = 0x05;
>> +    rrb.request.fh = *fhandle;
>> +    rrb.request.oc = 0;
>> +    rrb.request.ndas = 1;
>> +    rrb.response.hdr.len = 32;
>> +
>> +    if (clp_pci(&rrb) || rrb.response.hdr.rsp != 0x0010) {
>> +        puts("Failed to enable PCI function");
>> +        return -1;
>> +    }
>> +
>> +    *fhandle = rrb.response.fh;
>> +    return 0;
>> +}
>> diff --git a/pc-bios/s390-ccw/clp.h b/pc-bios/s390-ccw/clp.h
>> new file mode 100644
>> index 0000000000..1ac2f8c177
>> --- /dev/null
>> +++ b/pc-bios/s390-ccw/clp.h
>> @@ -0,0 +1,24 @@
>> +/*
>> + * Call Logical Processor (CLP) architecture definitions
>> + *
>> + * Copyright 2025 IBM Corp.
>> + * Author(s): Jared Rossi <jrossi@linux.ibm.com>
>> + *
>> + * SPDX-License-Identifier: GPL-2.0-or-later
>> + */
>> +
>> +#ifndef CLP_H
>> +#define CLP_H
>> +
>> +#ifndef QEMU_PACKED
>> +#define QEMU_PACKED __attribute__((packed))
>> +#endif
>> +
>> +#include <stdint.h>
>> +#include <s390-pci-clp.h>
>> +
>> +int clp_pci(void *data);
>> +int find_pci_function(uint32_t fid, ClpFhListEntry *entry);
>> +int enable_pci_function(uint32_t *fhandle);
>> +
>> +#endif


