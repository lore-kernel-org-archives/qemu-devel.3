Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EBB19C36008
	for <qemu-devel@archiver.kernel.org>; Sat, 29 Mar 2025 06:03:47 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tyPHz-0000hw-Fv; Sat, 29 Mar 2025 02:03:27 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alifm@linux.ibm.com>)
 id 1tyPHs-0000h5-PN; Sat, 29 Mar 2025 02:03:21 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alifm@linux.ibm.com>)
 id 1tyPHp-00064e-8r; Sat, 29 Mar 2025 02:03:18 -0400
Received: from pps.filterd (m0356517.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 52T310uw017466;
 Sat, 29 Mar 2025 06:03:10 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=pp1; bh=ZOKmDM
 8nE9PQNbn+yjJ/6diRq8WC/9AQ5VEt0rvSIYQ=; b=COsS3qxX4yAee1cKl2hb/W
 TtZ8U6D7L9jZDBhFT3E3xM5Mkp8uASf8wxfB5uC25eacgJUmZRv2E+mbGzwNOgD7
 tElaJ+3gZ75oBYRQNFRCSsa8Q6KCTcsI8sQB8+yKZ7ngH30iFrKhXig8YRdW3qvZ
 VEtwJbPF0Aqudd9q3CQ6ehKWEyrGjfBIlzo0sj97tlMial9/sUzrR5I3rVMu0BRC
 q8LsUdd9RmtyYUvMC529WOrmHxNZR8PY9YWHlY9I+kV6e6rjgXJulNrl0ydTz4XX
 2LAcHkWLlOyclXa/cxvksyT/QME95wKIc1PwpXQH3DRfETn/FiHZS6d5RKVjhXfQ
 ==
Received: from ppma11.dal12v.mail.ibm.com
 (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 45p8k90muw-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Sat, 29 Mar 2025 06:03:09 +0000 (GMT)
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
 by ppma11.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 52T5N6sI005865;
 Sat, 29 Mar 2025 06:03:08 GMT
Received: from smtprelay02.dal12v.mail.ibm.com ([172.16.1.4])
 by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 45ja82x67w-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Sat, 29 Mar 2025 06:03:08 +0000
Received: from smtpav03.dal12v.mail.ibm.com (smtpav03.dal12v.mail.ibm.com
 [10.241.53.102])
 by smtprelay02.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 52T638L73605224
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Sat, 29 Mar 2025 06:03:08 GMT
Received: from smtpav03.dal12v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 18F455803F;
 Sat, 29 Mar 2025 06:03:08 +0000 (GMT)
Received: from smtpav03.dal12v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 3B15A5805A;
 Sat, 29 Mar 2025 06:03:07 +0000 (GMT)
Received: from [9.61.241.221] (unknown [9.61.241.221])
 by smtpav03.dal12v.mail.ibm.com (Postfix) with ESMTP;
 Sat, 29 Mar 2025 06:03:07 +0000 (GMT)
Message-ID: <e6d49082-4808-4d68-970f-7cd6bc23a9c5@linux.ibm.com>
Date: Fri, 28 Mar 2025 23:03:04 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 2/3] include: Add a header to define PCI MMIO functions
To: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 qemu-devel@nongnu.org
Cc: mjrosato@linux.ibm.com, schnelle@linux.ibm.com, qemu-block@nongnu.org,
 qemu-s390x@nongnu.org, stefanha@redhat.com, fam@euphon.net,
 kwolf@redhat.com, hreitz@redhat.com, thuth@redhat.com
References: <20250328190627.3025-1-alifm@linux.ibm.com>
 <20250328190627.3025-3-alifm@linux.ibm.com>
 <b6b45e60-026e-4228-a5a1-451bbccdd7dc@linaro.org>
Content-Language: en-US
From: Farhan Ali <alifm@linux.ibm.com>
In-Reply-To: <b6b45e60-026e-4228-a5a1-451bbccdd7dc@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: jfNwWZsITgUtdmdtsvrQBfAOWxShXByy
X-Proofpoint-ORIG-GUID: jfNwWZsITgUtdmdtsvrQBfAOWxShXByy
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1095,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-03-29_01,2025-03-27_02,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 adultscore=0
 lowpriorityscore=0 mlxlogscore=861 bulkscore=0 impostorscore=0 mlxscore=0
 malwarescore=0 priorityscore=1501 phishscore=0 spamscore=0 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.19.0-2502280000
 definitions=main-2503290040
Received-SPF: pass client-ip=148.163.156.1; envelope-from=alifm@linux.ibm.com;
 helo=mx0a-001b2d01.pphosted.com
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


On 3/28/2025 1:44 PM, Philippe Mathieu-Daudé wrote:
> On 28/3/25 20:06, Farhan Ali wrote:
>> Add a generic QEMU API for PCI MMIO reads/writes.
>> The functions access little endian memory and returns
>> the result in host cpu endianness.
>>
>> Signed-off-by: Farhan Ali <alifm@linux.ibm.com>
>> ---
>>   include/qemu/pci-mmio.h | 116 ++++++++++++++++++++++++++++++++++++++++
>>   1 file changed, 116 insertions(+)
>>   create mode 100644 include/qemu/pci-mmio.h
>>
>> diff --git a/include/qemu/pci-mmio.h b/include/qemu/pci-mmio.h
>> new file mode 100644
>> index 0000000000..2ef92455b1
>> --- /dev/null
>> +++ b/include/qemu/pci-mmio.h
>> @@ -0,0 +1,116 @@
>> +/*
>> + * QEMU PCI MMIO API
>> + *
>> + * Copyright 2025 IBM Corp.
>> + * Author(s): Farhan Ali <alifm@linux.ibm.com>
>> + *
>> + * SPDX-License-Identifier: GPL-2.0-or-later
>> + */
>> +
>> +#ifndef QEMU_PCI_MMIO_H
>> +#define QEMU_PCI_MMIO_H
>> +
>> +#ifdef __s390x__
> > +#include "s390x_pci_mmio.h"
>
> Does this ifdef belong to the header instead?
> Otherwise remove?

Just to clarify, are you suggesting to move this ifdef to the 
s390x_pci_mmio.h header file? so we can include s390x_pci_mmio.h file 
here without any ifdef?


>
>> +#endif
>

