Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 535BDEF8FEF
	for <qemu-devel@archiver.kernel.org>; Wed,  4 Mar 2026 14:39:17 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vxnNU-0004q6-EI; Wed, 04 Mar 2026 09:39:08 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jrossi@linux.ibm.com>)
 id 1vxnNS-0004pI-QC; Wed, 04 Mar 2026 09:39:06 -0500
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jrossi@linux.ibm.com>)
 id 1vxnNR-0002qU-5y; Wed, 04 Mar 2026 09:39:06 -0500
Received: from pps.filterd (m0356517.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 6243MWpX613117; Wed, 4 Mar 2026 14:39:03 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=pp1; bh=I/emfc
 DfQEdyi4PCDzS0ho/68iyMxH47JWbIFVQpC8Q=; b=PebXAOpBIJn/rvqGeQV+nz
 bk25HcNQfZ8UTnY7QYFJaLs21eyBWhC3B4/YillI8C6RoqURm7+gPqEfwzWmruCR
 x5KJgSwSVKRMgDarDnT2zBZPj2ScEdGREIaP/d9UC7E+8uxiRtFiTBX0eXet7rBQ
 8acxnrG5MsXMKbvrPXDfnbpP/j0cMA7gDNSQ5M1hEvWcPZHEcnjR/LHrQSIBs6Y4
 CO5npiPs2wdaMIJprzhOBL91Ur8cZlbd9qLPs+5LlEuuM1cOTAv1oHYjNifP9Ogf
 q1pKq4Ce4JG2UuD5nSUOn1U8AlNbmNFxV+Dd2FimYKy8jYB92cmgo4/RH6FFVUDw
 ==
Received: from ppma22.wdc07v.mail.ibm.com
 (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4cksjdfr74-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Wed, 04 Mar 2026 14:39:03 +0000 (GMT)
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
 by ppma22.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 624E81BE003266;
 Wed, 4 Mar 2026 14:39:02 GMT
Received: from smtprelay05.dal12v.mail.ibm.com ([172.16.1.7])
 by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4cmb2y75d7-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Wed, 04 Mar 2026 14:39:02 +0000
Received: from smtpav02.wdc07v.mail.ibm.com (smtpav02.wdc07v.mail.ibm.com
 [10.39.53.229])
 by smtprelay05.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 624Ed0Nd66191684
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Wed, 4 Mar 2026 14:39:00 GMT
Received: from smtpav02.wdc07v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 8429058058;
 Wed,  4 Mar 2026 14:39:00 +0000 (GMT)
Received: from smtpav02.wdc07v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 43B4A5805B;
 Wed,  4 Mar 2026 14:38:59 +0000 (GMT)
Received: from [9.61.180.105] (unknown [9.61.180.105])
 by smtpav02.wdc07v.mail.ibm.com (Postfix) with ESMTPS;
 Wed,  4 Mar 2026 14:38:59 +0000 (GMT)
Message-ID: <f2d88cdf-843f-4d23-a288-43056e383e59@linux.ibm.com>
Date: Wed, 4 Mar 2026 09:38:53 -0500
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 11/15] pc-bios/s390-ccw: Introduce virtio-pci functions
To: Thomas Huth <thuth@redhat.com>, qemu-devel@nongnu.org,
 qemu-s390x@nongnu.org, mst@redhat.com
Cc: jjherne@linux.ibm.com, alifm@linux.ibm.com, farman@linux.ibm.com,
 mjrosato@linux.ibm.com, zycai@linux.ibm.com
References: <20260304025917.2157032-1-jrossi@linux.ibm.com>
 <20260304025917.2157032-12-jrossi@linux.ibm.com>
 <5f8d78a4-175d-49fc-b397-b699c49cf0a6@redhat.com>
Content-Language: en-US
From: Jared Rossi <jrossi@linux.ibm.com>
In-Reply-To: <5f8d78a4-175d-49fc-b397-b699c49cf0a6@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Authority-Analysis: v=2.4 cv=M9BA6iws c=1 sm=1 tr=0 ts=69a84407 cx=c_pps
 a=5BHTudwdYE3Te8bg5FgnPg==:117 a=5BHTudwdYE3Te8bg5FgnPg==:17
 a=IkcTkHD0fZMA:10 a=Yq5XynenixoA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=U7nrCbtTmkRpXpFmAIza:22 a=VnNF1IyMAAAA:8
 a=y7DE19vXhTpJ5KtiWeAA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
X-Proofpoint-ORIG-GUID: -fFoNtcUzoGxpJ1mazMatxOHsZU4ZyyM
X-Proofpoint-GUID: -fFoNtcUzoGxpJ1mazMatxOHsZU4ZyyM
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzA0MDExOCBTYWx0ZWRfX9SOLYk7M4o2r
 lo5h/SHStSS3IIOosbWzcmMnOMqShXsRQZPBs/dCsIMcKwRcgyikP0ltgR/vpNkJaZSx0w/jQDj
 tpwkQEaxBUGlvpEGbmAWZFIxTtKVrz4vaX3wGydjj4ebJkmTJR71MfcOGsXdEGd3/73ZYwhFclN
 23YmRVZOxv60qhwhnagFgLf0SIGl2vwE63mxn11sxpAktLzqQ7mShOtYsUL1yOrRLoV6K+FKzZn
 stHbWWIa1pjXc6FLrnn1DY927mixdTzuEtxAzuvUn1ExvRfqIuss3IZQVJg6x5hAYNrsFVHchEJ
 AONzUoP392dfLoxmikxOAcE+vCMc7ET3cpd29zNwKfAK1vJ5E4krSzB5ZdQsQstCsOdpQLDaPlW
 h781ByidI9Qdjh+Q+bEV59KdgXwtV4OOhGuRKQavTb4nVhbTNcCFEbJb8xS1cxBWU91fzxjMYI8
 lW8r0PO9ZaYa2OLUr4A==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-03-04_06,2026-03-03_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 priorityscore=1501 spamscore=0 adultscore=0 malwarescore=0
 bulkscore=0 lowpriorityscore=0 impostorscore=0 phishscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2602130000 definitions=main-2603040118
Received-SPF: pass client-ip=148.163.156.1; envelope-from=jrossi@linux.ibm.com;
 helo=mx0a-001b2d01.pphosted.com
X-Spam_score_int: -5
X-Spam_score: -0.6
X-Spam_bar: /
X-Spam_report: (-0.6 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, RCVD_IN_DNSWL_LOW=-0.7,
 RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.703, RCVD_IN_VALIDITY_SAFE_BLOCKED=1.386,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=no autolearn_force=no
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



On 3/4/26 4:18 AM, Thomas Huth wrote:
> On 04/03/2026 03.59, jrossi@linux.ibm.com wrote:
>> From: Jared Rossi <jrossi@linux.ibm.com>
>>
>> Define common functionality for interacting with virtio-pci devices.
>>
>> Signed-off-by: Jared Rossi <jrossi@linux.ibm.com>
>> ---
> ...
>> diff --git a/pc-bios/s390-ccw/virtio-pci.c 
>> b/pc-bios/s390-ccw/virtio-pci.c
>> new file mode 100644
>> index 0000000000..2cfb84bf66
>> --- /dev/null
>> +++ b/pc-bios/s390-ccw/virtio-pci.c
>> @@ -0,0 +1,167 @@
>> +/*
>> + * Functionality for virtio-pci
>> + *
>> + * Copyright 2025 IBM Corp.
>> + * Author(s): Jared Rossi <jrossi@linux.ibm.com>
>> + *
>> + * SPDX-License-Identifier: GPL-2.0-or-later
>> + */
>> +
>> +#include "clp.h"
>> +#include "pci.h"
>> +#include "helper.h"
>> +#include "virtio.h"
>> +#include "bswap.h"
>> +#include "virtio-pci.h"
>> +#include "s390-time.h"
>> +#include <stdio.h>
>> +
>> +/* Variable offsets used for reads/writes to modern memory regions */
>> +VirtioPciCap c_cap; /* Common capabilities  */
>> +VirtioPciCap d_cap; /* Device capabilities  */
>> +VirtioPciCap n_cap; /* Notify capabilities  */
>> +uint32_t notify_mult;
>> +uint16_t q_notify_offset;
>> +
>> +static int virtio_pci_set_status(uint8_t status)
>> +{
>> +    int rc = vpci_write_byte(c_cap.off + VPCI_C_OFFSET_STATUS, 
>> c_cap.bar, status);
>> +    if (rc) {
>> +        puts("Failed to write virtio-pci status");
>> +        return -EIO;
>> +    }
>> +
>> +    return 0;
>> +}
>> +
>> +static int virtio_pci_get_status(uint8_t *status)
>> +{
>> +    int rc = vpci_read_byte(c_cap.off + VPCI_C_OFFSET_STATUS, 
>> c_cap.bar, status);
>> +    if (rc) {
>> +        puts("Failed to read virtio-pci status");
>> +        return -EIO;
>> +    }
>> +
>> +    return 0;
>> +}
>> +
>> +/* virtio spec v1.3 section 4.1.2.1 */
>> +void virtio_pci_id2type(VDev *vdev, uint16_t device_id)
>> +{
>> +    switch (device_id) {
>> +    case 0x1402:
>
> I think it's 0x1042, not 0x1402 ?

Good catch.  You are correct.  I'll fix it.

Thanks again,
Jared Rossi

