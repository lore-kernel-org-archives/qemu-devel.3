Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E930ED73E87
	for <qemu-devel@archiver.kernel.org>; Thu, 29 Jan 2026 22:55:23 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vlauK-0003oF-Lv; Thu, 29 Jan 2026 17:54:36 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alifm@linux.ibm.com>)
 id 1vlauF-0003hm-Nt; Thu, 29 Jan 2026 17:54:31 -0500
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alifm@linux.ibm.com>)
 id 1vlauE-0001RZ-2O; Thu, 29 Jan 2026 17:54:31 -0500
Received: from pps.filterd (m0356516.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 60TEPYEL022812;
 Thu, 29 Jan 2026 22:54:28 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=pp1; bh=+LbFa3
 d6uPQerJugAAIhVuStUwJwRW9Ak6bnaC5NYPo=; b=GmZYwPX/7FLGv3xMxfQHt4
 5RkCWzRvOiHJ5jgxF25pIOexwG9utL79mYE2Du24FYTgZBcev6ckOfM9rLDjUorX
 OVpiYPri31AwHU7G+Qw5abRhi9S/fYSDLFOpL7eQM6+CP5e6JQHzLo8xdKyS3trD
 SfFi9Qgdp5o1Ni/p4coOU9CjDW5YzDYbxdmV/C1o81G+l9C9KxQdGyZCUGdQNX73
 Y9LuJgoZv6Fz8Vt6dh02TU59LheLUEXeS7Po6eJ6YVVVsUi7DmNNoiV/cY/Kaze1
 OubXC764Q3HqGyB/PN77Df6yAivnzokc45O29j+PzzSFpqO3w1j34biugwUL586Q
 ==
Received: from ppma23.wdc07v.mail.ibm.com
 (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4bvkgn0nfw-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 29 Jan 2026 22:54:28 +0000 (GMT)
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
 by ppma23.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 60TJV2GY026805;
 Thu, 29 Jan 2026 22:54:27 GMT
Received: from smtprelay06.wdc07v.mail.ibm.com ([172.16.1.73])
 by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4bw9wkkxy1-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 29 Jan 2026 22:54:27 +0000
Received: from smtpav05.dal12v.mail.ibm.com (smtpav05.dal12v.mail.ibm.com
 [10.241.53.104])
 by smtprelay06.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 60TMsQBv30475000
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Thu, 29 Jan 2026 22:54:26 GMT
Received: from smtpav05.dal12v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 1A7D458052;
 Thu, 29 Jan 2026 22:54:26 +0000 (GMT)
Received: from smtpav05.dal12v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 62FB758056;
 Thu, 29 Jan 2026 22:54:25 +0000 (GMT)
Received: from [9.61.243.220] (unknown [9.61.243.220])
 by smtpav05.dal12v.mail.ibm.com (Postfix) with ESMTP;
 Thu, 29 Jan 2026 22:54:25 +0000 (GMT)
Message-ID: <2494fe74-23bb-429c-b750-4fa674a67712@linux.ibm.com>
Date: Thu, 29 Jan 2026 14:54:24 -0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 07/14] pc-bios/s390-ccw: Introduce CLP Architecture
To: jrossi@linux.ibm.com, qemu-devel@nongnu.org, qemu-s390x@nongnu.org,
 thuth@redhat.com, mst@redhat.com
Cc: jjherne@linux.ibm.com, farman@linux.ibm.com, mjrosato@linux.ibm.com,
 zycai@linux.ibm.com
References: <20260127161547.459443-1-jrossi@linux.ibm.com>
 <20260127161547.459443-8-jrossi@linux.ibm.com>
Content-Language: en-US
From: Farhan Ali <alifm@linux.ibm.com>
In-Reply-To: <20260127161547.459443-8-jrossi@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Authority-Analysis: v=2.4 cv=Gr1PO01C c=1 sm=1 tr=0 ts=697be524 cx=c_pps
 a=3Bg1Hr4SwmMryq2xdFQyZA==:117 a=3Bg1Hr4SwmMryq2xdFQyZA==:17
 a=IkcTkHD0fZMA:10 a=vUbySO9Y5rIA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=VnNF1IyMAAAA:8 a=0cF1dDw_mijGlTfD0moA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-GUID: d36h3kiQaxwOSnqFl-2wfbNwVlwHqD2r
X-Proofpoint-ORIG-GUID: d36h3kiQaxwOSnqFl-2wfbNwVlwHqD2r
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMTI5MDE2NyBTYWx0ZWRfX7RrawalqWfjh
 QHbJEX2eXpIBhliAou1165fuJGo5km9Qb8+btRELmom+pvi54SqB0QP3+mR302jBuDmA3WWPc3Y
 bUx3YN7io4S2LjKekrCIvns3XN/z3FXNpun0a1jKW0uzHIoW5FxozIGhOSEkvQ5r8Bj3+9yZ5cF
 46XXcgEgVq2rVU7kLwX4vacAwrIFOd/zHofVztg70kw2H2ryb3Yjk7qe6kP/XB6QeRZykn/np00
 KZiHTB7guhCiU6kGi+u3GxcT0u7qTMqJ+L5pW3ti7nV4caXc+7/4c5bjFHhoQIzrgEN8YuOhMTZ
 sqaMJhvK6Cx5phNJonhexzibI49aoEaKjh/66F0cgPT7ZvgzlDb2mO/tbWQmt5dzmDZW1uh9+3y
 3WT/4UWdHdSXMgLOeK4WDjW0KdvUVriJoyaVgILz7Rqbp5BCIb7w+e7KNG+G4zs7sboj10dE3Z1
 UfGcxVr29q3NV6MwpBA==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-01-29_03,2026-01-29_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 clxscore=1015 lowpriorityscore=0 suspectscore=0
 impostorscore=0 phishscore=0 malwarescore=0 adultscore=0 spamscore=0
 bulkscore=0 classifier=typeunknown authscore=0 authtc= authcc= route=outbound
 adjust=0 reason=mlx scancount=1 engine=8.19.0-2601150000
 definitions=main-2601290167
Received-SPF: pass client-ip=148.163.158.5; envelope-from=alifm@linux.ibm.com;
 helo=mx0b-001b2d01.pphosted.com
X-Spam_score_int: -19
X-Spam_score: -2.0
X-Spam_bar: --
X-Spam_report: (-2.0 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, RCVD_IN_DNSWL_NONE=-0.0001,
 RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
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


On 1/27/2026 8:15 AM, jrossi@linux.ibm.com wrote:
> From: Jared Rossi <jrossi@linux.ibm.com>
>
> Call Logical Processor (CLP) Architecture is used for managing PCI functions on
> s390x. Define and include the structures and routines needed to interact with
> PCI devices during IPL.
>
> Signed-off-by: Jared Rossi <jrossi@linux.ibm.com>
> ---
>   pc-bios/s390-ccw/Makefile |  2 +-
>   pc-bios/s390-ccw/clp.c    | 96 +++++++++++++++++++++++++++++++++++++++
>   pc-bios/s390-ccw/clp.h    | 24 ++++++++++
>   3 files changed, 121 insertions(+), 1 deletion(-)
>   create mode 100644 pc-bios/s390-ccw/clp.c
>   create mode 100644 pc-bios/s390-ccw/clp.h
>
> diff --git a/pc-bios/s390-ccw/Makefile b/pc-bios/s390-ccw/Makefile
> index 259cff09db..9c29548f84 100644
> --- a/pc-bios/s390-ccw/Makefile
> +++ b/pc-bios/s390-ccw/Makefile
> @@ -35,7 +35,7 @@ QEMU_DGFLAGS = -MMD -MP -MT $@ -MF $(@D)/$(*F).d
>   
>   OBJECTS = start.o main.o bootmap.o jump2ipl.o sclp.o menu.o netmain.o \
>   	  virtio.o virtio-net.o virtio-scsi.o virtio-blkdev.o cio.o dasd-ipl.o \
> -	  virtio-ccw.o
> +	  virtio-ccw.o clp.o
>   
>   SLOF_DIR := $(SRC_PATH)/../../roms/SLOF
>   
> diff --git a/pc-bios/s390-ccw/clp.c b/pc-bios/s390-ccw/clp.c
> new file mode 100644
> index 0000000000..2a14bb9b73
> --- /dev/null
> +++ b/pc-bios/s390-ccw/clp.c
> @@ -0,0 +1,96 @@
> +/*
> + * Call Logical Processor (CLP) architecture
> + *
> + * Copyright 2025 IBM Corp.
> + * Author(s): Jared Rossi <jrossi@linux.ibm.com>
> + *
> + * SPDX-License-Identifier: GPL-2.0-or-later
> + */
> +
> +#include "clp.h"
> +#include <stdio.h>
> +#include <string.h>
> +
> +int clp_pci(void *data)
> +{
> +    struct { uint8_t _[2048]; } *req = data;

The architecture specifies that size of the request + response block 
size can be maximum of 8192 bytes. If I understand correctly I think 
QEMU (similar to kernel) uses CLP_BLK_SIZE when calculating the 
CLP_FH_LIST_NR_ENTRIES, so it assumes that the request + response block 
is 4096. So we can return more than 2048 bytes here and overflow.

I think we should use at least CLP_BLK_SIZE here instead of 2048 or set 
this to the maximum possible value of 8192.

Thanks

Farhan

> +    int cc = 3;
> +
> +    asm volatile (
> +        "     .insn   rrf,0xb9a00000,0,%[req],0,2\n"
> +        "     ipm     %[cc]\n"
> +        "     srl     %[cc],28\n"
> +        : [cc] "+d" (cc), "+m" (*req)
> +        : [req] "a" (req)
> +        : "cc");
> +    return cc;
> +}
> +
>

