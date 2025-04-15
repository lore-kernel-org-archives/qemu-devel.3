Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 97C21C369AB
	for <qemu-devel@archiver.kernel.org>; Tue, 15 Apr 2025 16:10:59 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u4irQ-0005Nq-0O; Tue, 15 Apr 2025 12:10:08 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alifm@linux.ibm.com>)
 id 1u4iqJ-0004rp-Vo; Tue, 15 Apr 2025 12:09:11 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alifm@linux.ibm.com>)
 id 1u4iqI-0003Sy-59; Tue, 15 Apr 2025 12:08:59 -0400
Received: from pps.filterd (m0356517.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 53F9dDjJ020615;
 Tue, 15 Apr 2025 16:08:41 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=pp1; bh=G2TzsR
 +1GJc6en4aS+AYtUrPdq/9Wirl//4ZJPilOmg=; b=ZUwPZtRfA0tmosmqexMh0F
 F0Z7xgWufaoBN08FN/+eM5E86I51j6bAIFH1F6SVyMwWpw+YBim3kuLAlWSaxMqh
 lP5G8qh9T0lEdT+YputMMzzyezhgTvpOVXFMDSQN4oBD+kSOLzVcxa4eOrw/BbqY
 ZBYG9UGmqHgAmvqhh3fwCw39HwNyPspa+Z5J1IXnxXvZpctMGnLHMDtYbASr8PsY
 pBrlA0aSsNbdgGwGctVIvGfkrRab3V5O5ullVCUS5A+M9xj8Z7YlxxENdXRH3n2q
 KroJoNTlm0VlOqxbOjFjgngF5VGhct+Jyry/D3UEJoJE0/RS5EUXZfXTrf06ffeA
 ==
Received: from ppma23.wdc07v.mail.ibm.com
 (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 461af54p5j-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 15 Apr 2025 16:08:41 +0000 (GMT)
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
 by ppma23.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 53FEb2PK017183;
 Tue, 15 Apr 2025 16:08:40 GMT
Received: from smtprelay06.dal12v.mail.ibm.com ([172.16.1.8])
 by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 46040kurmy-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 15 Apr 2025 16:08:40 +0000
Received: from smtpav04.dal12v.mail.ibm.com (smtpav04.dal12v.mail.ibm.com
 [10.241.53.103])
 by smtprelay06.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 53FG8dtD31064638
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Tue, 15 Apr 2025 16:08:39 GMT
Received: from smtpav04.dal12v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 2597858052;
 Tue, 15 Apr 2025 16:08:39 +0000 (GMT)
Received: from smtpav04.dal12v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 4B5DD58056;
 Tue, 15 Apr 2025 16:08:38 +0000 (GMT)
Received: from [9.61.251.12] (unknown [9.61.251.12])
 by smtpav04.dal12v.mail.ibm.com (Postfix) with ESMTP;
 Tue, 15 Apr 2025 16:08:38 +0000 (GMT)
Message-ID: <b8829a9d-8518-4531-ab5a-e46965183398@linux.ibm.com>
Date: Tue, 15 Apr 2025 09:08:32 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 2/3] include: Add a header to define host PCI MMIO
 functions
To: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 qemu-devel@nongnu.org
Cc: qemu-s390x@nongnu.org, mjrosato@linux.ibm.com, schnelle@linux.ibm.com,
 stefanha@redhat.com, kwolf@redhat.com, hreitz@redhat.com,
 thuth@redhat.com, fam@euphon.net, alex.williamson@redhat.com
References: <20250414213616.2675-1-alifm@linux.ibm.com>
 <20250414213616.2675-3-alifm@linux.ibm.com>
 <71997461-7470-452b-9df1-3efa6d6f68c4@linaro.org>
Content-Language: en-US
From: Farhan Ali <alifm@linux.ibm.com>
In-Reply-To: <71997461-7470-452b-9df1-3efa6d6f68c4@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: hWWSFaJlILTWlATnJiQF1hkd3T7hqxPl
X-Proofpoint-GUID: hWWSFaJlILTWlATnJiQF1hkd3T7hqxPl
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1095,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-04-15_06,2025-04-15_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 impostorscore=0
 priorityscore=1501 mlxscore=0 clxscore=1015 adultscore=0 bulkscore=0
 lowpriorityscore=0 suspectscore=0 mlxlogscore=999 spamscore=0
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2502280000 definitions=main-2504150112
Received-SPF: pass client-ip=148.163.156.1; envelope-from=alifm@linux.ibm.com;
 helo=mx0a-001b2d01.pphosted.com
X-Spam_score_int: -26
X-Spam_score: -2.7
X-Spam_bar: --
X-Spam_report: (-2.7 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, RCVD_IN_DNSWL_LOW=-0.7,
 RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
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


On 4/14/2025 11:43 PM, Philippe Mathieu-Daudé wrote:
> Hi,
>
> On 14/4/25 23:36, Farhan Ali wrote:
>> Add a generic API for host PCI MMIO reads/writes
>> (e.g. Linux VFIO BAR accesses). The functions access
>> little endian memory and returns the result in
>> host cpu endianness.
>>
>> Signed-off-by: Farhan Ali <alifm@linux.ibm.com>
>> ---
>>   include/qemu/host-pci-mmio.h | 141 +++++++++++++++++++++++++++++++++++
>>   1 file changed, 141 insertions(+)
>>   create mode 100644 include/qemu/host-pci-mmio.h
>>
>> diff --git a/include/qemu/host-pci-mmio.h b/include/qemu/host-pci-mmio.h
>> new file mode 100644
>> index 0000000000..de17d67e3a
>> --- /dev/null
>> +++ b/include/qemu/host-pci-mmio.h
>> @@ -0,0 +1,141 @@
>> +/*
>> + * API for host PCI MMIO accesses (e.g. Linux VFIO BARs)
>> + *
>> + * Copyright 2025 IBM Corp.
>> + * Author(s): Farhan Ali <alifm@linux.ibm.com>
>> + *
>> + * SPDX-License-Identifier: GPL-2.0-or-later
>> + */
>> +
>> +#ifndef HOST_PCI_MMIO_H
>> +#define HOST_PCI_MMIO_H
>> +
>> +#include "qemu/bswap.h"
>> +#include "qemu/s390x_pci_mmio.h"
>> +
>> +
>> +static inline uint8_t host_pci_ldub_p(const void *ioaddr)
>
> Is it really worth inlining?
>
Hi Philippe,

I think so, we inline the ld/st generic helper functions in bswap.h. 
Curious, why do you think its not necessary?

Thanks

Farhan

>> +{
>> +    uint8_t ret = 0;
>> +#ifdef __s390x__
>> +    ret = s390x_pci_mmio_read_8(ioaddr);
>> +#else
>> +    ret = ldub_he_p(ioaddr);
>> +#endif
>> +
>> +    return ret;
>> +}
>
>

