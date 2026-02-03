Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0509FE87852
	for <qemu-devel@archiver.kernel.org>; Tue,  3 Feb 2026 18:49:06 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vnLRw-0004do-He; Tue, 03 Feb 2026 13:48:32 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alifm@linux.ibm.com>)
 id 1vnLRj-0004d3-2W; Tue, 03 Feb 2026 13:48:20 -0500
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alifm@linux.ibm.com>)
 id 1vnLRf-0000yX-MZ; Tue, 03 Feb 2026 13:48:17 -0500
Received: from pps.filterd (m0353729.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 613A8TDX017607;
 Tue, 3 Feb 2026 18:48:12 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=pp1; bh=2xipie
 ocgcAs9CUQMhLzOA/qgx9GBKaOqkR3jEP4kKY=; b=MSX9P3OditLbXQsblMCBbl
 hOY3Fvi4JrRqRvodUEDSR3eFsMo8f4iel+uwG+NiF9q+SWbztwrr5TNLhQo9wyah
 a48Kvii347+ZRm7Ny9OfX65MD1gMyZxZ36/991KVDnnOu837ev7mLrlc2DoD4ipp
 vdhhRWj0M7laD6ADpL8z62CUMYnLYpeTMwujZR9HSd0sht9reV4HY3e/zQwfaDu/
 VMXxACnOUJCAzqkrKLnr9/7XOWfFByGLpadWayY7Wx0VGfud/0Fm6FSDVXyztRcA
 utgq/2mqJ/lObiAUZwnQoTdMv1nX6qal1CcsnkGBlR7Bo46hqVWo3yZi2DyBt4jQ
 ==
Received: from ppma13.dal12v.mail.ibm.com
 (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4c19dt6rd2-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 03 Feb 2026 18:48:12 +0000 (GMT)
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
 by ppma13.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 613Ghcce005921;
 Tue, 3 Feb 2026 18:48:11 GMT
Received: from smtprelay04.wdc07v.mail.ibm.com ([172.16.1.71])
 by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 4c1x9ja1jt-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 03 Feb 2026 18:48:11 +0000
Received: from smtpav05.wdc07v.mail.ibm.com (smtpav05.wdc07v.mail.ibm.com
 [10.39.53.232])
 by smtprelay04.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 613Im90o38732326
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Tue, 3 Feb 2026 18:48:09 GMT
Received: from smtpav05.wdc07v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id CA7B55805D;
 Tue,  3 Feb 2026 18:48:09 +0000 (GMT)
Received: from smtpav05.wdc07v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id D403358059;
 Tue,  3 Feb 2026 18:48:08 +0000 (GMT)
Received: from [9.61.249.4] (unknown [9.61.249.4])
 by smtpav05.wdc07v.mail.ibm.com (Postfix) with ESMTP;
 Tue,  3 Feb 2026 18:48:08 +0000 (GMT)
Message-ID: <3ddb6f91-4308-420d-b057-d26c1c727015@linux.ibm.com>
Date: Tue, 3 Feb 2026 10:48:08 -0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 09/14] pc-bios/s390-ccw: Introduce PCI device
To: jrossi@linux.ibm.com, qemu-devel@nongnu.org, qemu-s390x@nongnu.org,
 thuth@redhat.com, mst@redhat.com
Cc: jjherne@linux.ibm.com, farman@linux.ibm.com, mjrosato@linux.ibm.com,
 zycai@linux.ibm.com
References: <20260127161547.459443-1-jrossi@linux.ibm.com>
 <20260127161547.459443-10-jrossi@linux.ibm.com>
Content-Language: en-US
From: Farhan Ali <alifm@linux.ibm.com>
In-Reply-To: <20260127161547.459443-10-jrossi@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMjAzMDE0NyBTYWx0ZWRfX86pF59huPQCV
 5oYvEaXF7u5BdHgAz1Lp6QX4c40wdPyjwCEv3bGRLgn3jcVJmxDkjHypxZgLmYJ4pLt2uCLkFv8
 hE0Y9ZLvOihTqCBMCw7hWnDxEh1iLQI/5qjZDjrhNe5Xg404gt+YD8WsGmnq/6EsLqGm0f8c/H6
 sXTVLFMt4LOKZQAt+6ZkDrdImpz0eBQD948SsMSv9X7bWL2ZC6OJRZk6Xnpn0yxrgmMlVBTXJZQ
 8BoiUGCVdcZfql5SqUO9opARuLrCTS9LX2kMwIv2bj9QQHDjC9pMM4WHOmqRebqi4Jzo7FCCKKd
 1iHyu13l+3ACMCQK9JfCCB7TpsDRvnMlVzF5TLVxKEDNOLGU5LVPIjnJfmW6nepCqUa+yGrlVm0
 oHzzEOt8hJao3twGPLbZsLcNm7c803DBN3Vn0jttGbdlulIVAA8OMJ6SGFcRV+oUA31VmmUHN/F
 OoH1wN6Jfai3ucC4rVQ==
X-Proofpoint-GUID: 2OnJDnpHsvldT_Nn5qgOTOflajrQucRH
X-Proofpoint-ORIG-GUID: 2OnJDnpHsvldT_Nn5qgOTOflajrQucRH
X-Authority-Analysis: v=2.4 cv=LesxKzfi c=1 sm=1 tr=0 ts=698242ec cx=c_pps
 a=AfN7/Ok6k8XGzOShvHwTGQ==:117 a=AfN7/Ok6k8XGzOShvHwTGQ==:17
 a=IkcTkHD0fZMA:10 a=HzLeVaNsDn8A:10 a=VkNPw1HP01LnGYTKEx00:22
 a=VnNF1IyMAAAA:8 a=VH4ka7d8O3_K94elNbEA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-02-03_05,2026-02-02_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 impostorscore=0 spamscore=0 lowpriorityscore=0 clxscore=1015
 adultscore=0 suspectscore=0 priorityscore=1501 phishscore=0 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2601150000 definitions=main-2602030147
Received-SPF: pass client-ip=148.163.156.1; envelope-from=alifm@linux.ibm.com;
 helo=mx0a-001b2d01.pphosted.com
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
> Define selected s390x PCI instructions.
>
> Signed-off-by: Jared Rossi <jrossi@linux.ibm.com>
> ---
>   pc-bios/s390-ccw/Makefile |   2 +-
>   pc-bios/s390-ccw/pci.c    | 194 ++++++++++++++++++++++++++++++++++++++
>   pc-bios/s390-ccw/pci.h    |  80 ++++++++++++++++
>   3 files changed, 275 insertions(+), 1 deletion(-)
>   create mode 100644 pc-bios/s390-ccw/pci.c
>   create mode 100644 pc-bios/s390-ccw/pci.h
>
> diff --git a/pc-bios/s390-ccw/Makefile b/pc-bios/s390-ccw/Makefile
> index 9c29548f84..a62fc9d766 100644
> --- a/pc-bios/s390-ccw/Makefile
> +++ b/pc-bios/s390-ccw/Makefile
> @@ -35,7 +35,7 @@ QEMU_DGFLAGS = -MMD -MP -MT $@ -MF $(@D)/$(*F).d
>   
>   OBJECTS = start.o main.o bootmap.o jump2ipl.o sclp.o menu.o netmain.o \
>   	  virtio.o virtio-net.o virtio-scsi.o virtio-blkdev.o cio.o dasd-ipl.o \
> -	  virtio-ccw.o clp.o
> +	  virtio-ccw.o clp.o pci.o
>   
>   SLOF_DIR := $(SRC_PATH)/../../roms/SLOF
>   
> diff --git a/pc-bios/s390-ccw/pci.c b/pc-bios/s390-ccw/pci.c
> new file mode 100644
> index 0000000000..9656be45ca
> --- /dev/null
> +++ b/pc-bios/s390-ccw/pci.c
> @@ -0,0 +1,194 @@
> +/*
> + * s390x PCI funcionality
> + *
> + * Copyright 2025 IBM Corp.
> + * Author(s): Jared Rossi <jrossi@linux.ibm.com>
> + *
> + * SPDX-License-Identifier: GPL-2.0-or-later
> + */
> +
> +#include "clp.h"
> +#include "pci.h"
> +#include "bswap.h"
> +#include <stdio.h>
> +#include <stdbool.h>
> +
> +/* PCI load */
> +static inline int pcilg(uint64_t *data, uint64_t req, uint64_t offset,
> +                        uint8_t *status)
> +{
> +    union register_pair req_off = {.even = req, .odd = offset};
> +    int cc = -1;

Nit: Setting cc = -1 doesn't make any difference since the cc gets 
overwritten and the pcilg will return cc > 0.


> +    uint64_t __data;
> +
> +    asm volatile (
> +        "     .insn   rre,0xb9d20000,%[data],%[req_off]\n"
> +        "     ipm     %[cc]\n"
> +        "     srl     %[cc],28\n"
> +        : [cc] "+d" (cc), [data] "=d" (__data),
> +          [req_off] "+d" (req_off.pair) :: "cc");
> +    *status = req_off.even >> 24 & 0xff;
> +    *data = __data;
> +    return cc;
> +}
> +
> +/* PCI store */
> +static inline int pcistg(uint64_t data, uint64_t req, uint64_t offset,
> +                         uint8_t *status)
> +{
> +    union register_pair req_off = {.even = req, .odd = offset};
> +    int cc = -1;

Nit: Same as pcilg.


> +
> +    asm volatile (
> +        "     .insn   rre,0xb9d00000,%[data],%[req_off]\n"
> +        "     ipm     %[cc]\n"
> +        "     srl     %[cc],28\n"
> +        : [cc] "+d" (cc), [req_off] "+d" (req_off.pair)
> +        : [data] "d" (data)
> +        : "cc");
> +    *status = req_off.even >> 24 & 0xff;
> +    return cc;
> +}
> +
> +/* store PCI function controls */
> +static inline int stpcifc(uint64_t req, PciFib *fib, uint8_t *status)
> +{
> +    uint8_t cc;
> +
> +    asm volatile (
> +        "     .insn   rxy,0xe300000000d4,%[req],%[fib]\n"
> +        "     ipm     %[cc]\n"
> +        "     srl     %[cc],28\n"
> +        : [cc] "=d" (cc), [req] "+d" (req), [fib] "+Q" (*fib)
> +        : : "cc");
> +    *status = req >> 24 & 0xff;
> +    return cc;
> +}
> +
> +/* modify PCI function controls */
> +static inline int mpcifc(uint64_t req, PciFib *fib, uint8_t *status)
> +{
> +    uint8_t cc;
> +
> +    asm volatile (
> +        "     .insn   rxy,0xe300000000d0,%[req],%[fib]\n"
> +        "     ipm     %[cc]\n"
> +        "     srl     %[cc],28\n"
> +        : [cc] "=d" (cc), [req] "+d" (req), [fib] "+Q" (*fib)
> +        : : "cc");
> +    *status = req >> 24 & 0xff;
> +    return cc;
> +}
> +
> +int pci_write(uint32_t fhandle, uint64_t offset, uint8_t pcias, uint64_t data,
> +              uint8_t len)
> +{
> +
> +    uint64_t req = ZPCI_CREATE_REQ(fhandle, pcias, len);
> +    uint8_t status;
> +    int rc;
> +
> +    /* len must be non-zero power of 2 with a maximum of 8 bytes per write */
> +    switch (len) {
> +    case 1:
> +    case 2:
> +    case 4:
> +    case 8:
> +        rc = pcistg(data, req, offset, &status);
> +        break;
> +    default:
> +        rc = -1;
> +    }
> +
> +    /* Error condition detected */
> +    if (rc == 1) {

According to the architecture a return code of 0 would indicate normal 
completion. But we do have error scenarios that can return error code > 
1. For example an error code of 3 would indicate 'Unrecognized handle'. 
May we should check for non-zero rc in this if condition...


> +        printf("PCI store failed with status condition %d\n", status);

... and print both the rc and status here.


> +        return -1;
> +    }
> +
> +    return rc ? -1 : 0;
> +}
> +
> +int pci_read(uint32_t fhandle, uint64_t offset, uint8_t pcias, void *buf,
> +             uint8_t len)
> +{
> +    uint64_t req, data;
> +    uint8_t status;
> +    int rc;
> +
> +    req = ZPCI_CREATE_REQ(fhandle, pcias, len);
> +    rc = pcilg(&data, req, offset, &status);
> +
> +    /* Error condition detected */
> +    if (rc == 1) {

Similar to pci_write we should check for non-zero return code here? And 
should do the same in pci_get_fib (stpcifc) and pci_set_fib (mpcifc)?


> +        printf("PCI load failed with status condition %d\n", status);
> +        return -1;
> +    }
> +
> +    switch (len) {
> +    case 1:
> +        *(uint8_t *)buf = data;
> +        break;
> +    case 2:
> +        *(uint16_t *)buf = data;
> +        break;
> +    case 4:
> +        *(uint32_t *)buf = data;
> +        break;
> +    case 8:
> +        *(uint64_t *)buf = data;
> +        break;
> +    default:
> +        return -1;
> +    }
> +
> +    return rc ? -1 : 0;
> +}
> +

<...snip...>


