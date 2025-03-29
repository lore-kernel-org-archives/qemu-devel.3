Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 452ADC36008
	for <qemu-devel@archiver.kernel.org>; Sat, 29 Mar 2025 05:59:44 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tyPDU-0008E9-HJ; Sat, 29 Mar 2025 01:58:48 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alifm@linux.ibm.com>)
 id 1tyPDR-0008Dk-L9; Sat, 29 Mar 2025 01:58:45 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alifm@linux.ibm.com>)
 id 1tyPDP-0005PX-SF; Sat, 29 Mar 2025 01:58:45 -0400
Received: from pps.filterd (m0356517.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 52T316C2017588;
 Sat, 29 Mar 2025 05:58:31 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=pp1; bh=L1MU0P
 VmS8MSsNQaFkimzXUI6P8JlXkrZAg6FFnAujw=; b=FlDJk3G3SWHQsZAotO2J6M
 elH03MxXm1PGd2Y0rCP7CWy2GfFlcTAhYu4sJtj2RjkfpMD02pzCZKDVDQZCbja0
 bptGHwtKYgjqvCvYcGLaALNgTbsRv4ji6drLAZtag8N9lT6yXTCQE9Xne0J7wIEJ
 INTPceVmAtPPUJW46/i22q9ApboHkiKX53NxazC8EZJz9mjWE35R5ZN7o3K7627V
 mqtaFQ1ZsT+cOTYVikt0oKulCVeB+HfYEMirdvKf1+dmQYTfMyF54yZMf6chDF54
 tREP0u6MAhcOlU02puWP28jN+QRDvJ2R97S1YSJoDcXk01lU2Ty+UliVEWhcsR+A
 ==
Received: from ppma13.dal12v.mail.ibm.com
 (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 45p8k90m9n-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Sat, 29 Mar 2025 05:58:30 +0000 (GMT)
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
 by ppma13.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 52T4nNU6009694;
 Sat, 29 Mar 2025 05:58:29 GMT
Received: from smtprelay03.dal12v.mail.ibm.com ([172.16.1.5])
 by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 45j9rm67w2-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Sat, 29 Mar 2025 05:58:29 +0000
Received: from smtpav03.dal12v.mail.ibm.com (smtpav03.dal12v.mail.ibm.com
 [10.241.53.102])
 by smtprelay03.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 52T5wSOK31064794
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Sat, 29 Mar 2025 05:58:28 GMT
Received: from smtpav03.dal12v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id D6B1058056;
 Sat, 29 Mar 2025 05:58:28 +0000 (GMT)
Received: from smtpav03.dal12v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id EE7615803F;
 Sat, 29 Mar 2025 05:58:27 +0000 (GMT)
Received: from [9.61.241.221] (unknown [9.61.241.221])
 by smtpav03.dal12v.mail.ibm.com (Postfix) with ESMTP;
 Sat, 29 Mar 2025 05:58:27 +0000 (GMT)
Message-ID: <9a5dca15-47db-485e-a847-99f1d4b895d4@linux.ibm.com>
Date: Fri, 28 Mar 2025 22:58:25 -0700
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
 <26acd91e-e9d2-4b04-8158-fe0fd0c530e9@linaro.org>
Content-Language: en-US
From: Farhan Ali <alifm@linux.ibm.com>
In-Reply-To: <26acd91e-e9d2-4b04-8158-fe0fd0c530e9@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: buRox8L5sRu7cDlco2JYWkVfp8qH4Mat
X-Proofpoint-ORIG-GUID: buRox8L5sRu7cDlco2JYWkVfp8qH4Mat
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1095,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-03-29_01,2025-03-27_02,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 adultscore=0
 lowpriorityscore=0 mlxlogscore=999 bulkscore=0 impostorscore=0 mlxscore=0
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


On 3/28/2025 1:38 PM, Philippe Mathieu-Daudé wrote:
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
>
> Missing:
>
> #include "qemu/bswap.h"
>
Thanks, will add this. Though I didn't have any issue compiling, but i 
think we should add this.


>> +#ifdef __s390x__
>> +#include "s390x_pci_mmio.h"
>> +#endif
>> +
>> +static inline uint8_t qemu_pci_mmio_read_8(const void *ioaddr)
>> +{
>> +    uint8_t ret = 0;
>> +#ifdef __s390x__
>> +    ret = s390x_pci_mmio_read_8(ioaddr);
>> +#else
>> +    /* Prevent the compiler from optimizing away the load */
>> +    ret = *((volatile uint8_t *)ioaddr);
>> +#endif
>> +
>> +    return ret;
>> +}
>> +
>> +static inline uint16_t qemu_pci_mmio_read_16(const void *ioaddr)
>> +{
>> +    uint16_t ret = 0;
>> +#ifdef __s390x__
>> +    ret = s390x_pci_mmio_read_16(ioaddr);
>> +#else
>> +    /* Prevent the compiler from optimizing away the load */
>> +    ret = *((volatile uint16_t *)ioaddr);
>> +#endif
>> +
>> +    return le16_to_cpu(ret);
>> +}
>
> Otherwise:
> Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
>
>

