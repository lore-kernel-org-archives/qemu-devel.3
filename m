Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 29865606A31B
	for <qemu-devel@archiver.kernel.org>; Tue, 27 Oct 2026 09:42:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=BIQAnf6k
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xLdgm-0007dl-4o; Tue, 27 Oct 2026 05:41:53 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <saif.abrar@linux.vnet.ibm.com>)
 id 1xLdgb-0007ba-E8; Tue, 27 Oct 2026 05:41:43 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <saif.abrar@linux.vnet.ibm.com>)
 id 1xLdgZ-00014o-JM; Tue, 27 Oct 2026 05:41:40 -0400
Received: from pps.filterd (m0356516.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 69R5iREw1441392; Tue, 27 Oct 2026 09:41:29 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=pp1; bh=SYtSON
 Zybx+6sOzSVtb0JdIi5X5v/oWUDuvP3ANBAAw=; b=BIQAnf6kq+bz6x8OHoaZ+8
 vmuTqfHD9yiDY/FtuGLH2F3QTm0wL4MZ1qjO884Fa5zu/ld7XnHxjpBcFgHfnnbQ
 p6J3J/iXEUs2l+03jkXtTFWJAkJTLxqGQknH1x55wYU2/XOjM0gFok6CzHjStka+
 Ccke2uR6lg5Hgf+1ud/FGAkvYx+xeFYzm4jscPbeozSghI33SgC41ERDuUflPYnn
 4M9XfEcxFBbMW9vrZ/JN8JKLlMloUjUk652NlqkmtxEzN+YU4feWOGH3zeoyQ9x8
 G6M1XUzunEi1OvmkYBRigxeC4QRMHaBylrzqEn2XTeX8z6XqvLD72MsPprvuyj/A
 ==
Received: from ppma22.wdc07v.mail.ibm.com
 (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4hgj3m6t5q-1
 (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
 Tue, 27 Oct 2026 09:41:28 +0000 (GMT)
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
 by ppma22.wdc07v.mail.ibm.com (8.18.1.11/8.18.1.11) with ESMTP id
 69R5nseG3687831; Tue, 27 Oct 2026 09:41:28 GMT
Received: from smtprelay03.wdc07v.mail.ibm.com ([172.16.1.70])
 by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4hh7cvj84x-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 27 Oct 2026 09:41:28 +0000 (GMT)
Received: from smtpav05.dal12v.mail.ibm.com (smtpav05.dal12v.mail.ibm.com
 [10.241.53.104])
 by smtprelay03.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 69R9ecs621496548
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Tue, 27 Oct 2026 09:40:39 GMT
Received: from smtpav05.dal12v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 8F54D5806A;
 Tue, 27 Oct 2026 09:41:26 +0000 (GMT)
Received: from smtpav05.dal12v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id D9C1A58065;
 Tue, 27 Oct 2026 09:41:19 +0000 (GMT)
Received: from [9.43.105.244] (unknown [9.43.105.244])
 by smtpav05.dal12v.mail.ibm.com (Postfix) with ESMTP;
 Tue, 27 Oct 2026 09:41:19 +0000 (GMT)
Message-ID: <c0b7bcb1-ee56-4381-9143-2bd033dd0689@linux.vnet.ibm.com>
Date: Tue, 27 Oct 2026 15:11:16 +0530
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6 1/9] qtest/phb5: Add testbench for PHB
To: Aditya Gupta <adityag@linux.ibm.com>, Saif Abrar <saif.abrar@linux.ibm.com>
Cc: qemu-ppc@nongnu.org, qemu-devel@nongnu.org, harshpb@linux.ibm.com,
 clg@kaod.org, npiggin@gmail.com, fbarrat@linux.ibm.com, mst@redhat.com,
 marcel.apfelbaum@gmail.com, cohuck@redhat.com, pbonzini@redhat.com,
 thuth@redhat.com, lvivier@redhat.com, danielhb413@gmail.com,
 kowal@linux.ibm.com, chalapathi.v@linux.ibm.com, calebs@linux.ibm.com,
 milesg@linux.ibm.com, jishnuvw@linux.ibm.com, amachhiw@linux.ibm.com
References: <20260831123005.1485518-1-saif.abrar@linux.ibm.com>
 <20260831123005.1485518-2-saif.abrar@linux.ibm.com>
 <aqVG7Lwttp09t6iC@li-3c92a0cc-27cf-11b2-a85c-b804d9ca68fa.ibm.com>
Content-Language: en-US
From: Saif Abrar <saif.abrar@linux.vnet.ibm.com>
In-Reply-To: <aqVG7Lwttp09t6iC@li-3c92a0cc-27cf-11b2-a85c-b804d9ca68fa.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDI3MDAzNiBTYWx0ZWRfX16jardNQLrxA
 jN1pf4k9DJNzThJ8BzXySPWQdS8cG5o4MF4knfWAagVJu5oFmqpLLMsVfAP77nkCv0rzpffC+bo
 ZeB4d8uYBxXfNguEpEqBu/7pnsXG03E=
X-Proofpoint-ORIG-GUID: GH_L7ClTLluPN1LICUxRq9bpH0tZ4Yf2
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDI3MDAzNiBTYWx0ZWRfX6IGEc+kUQyum
 txeKZAoCKNW7CtghNAMBkEAeMSDWzJefrapEVm0FbTLAWQaDQG3w0p4FB7fWonmO75595g56Rjz
 hTqwzPGVfasnu64OpI2jO6C5FE58Fva0y4xLY/HvHCyr/gNsOfHg5mwi1TYt0JUpJuKA0AgpfLi
 3O4Wg9U+hfuxZ4DPg0M2beRrBY2mIjQ4JZOOZ7VTcGz0G81t35yvyl3uYZlQhA523TJTbFpW+tU
 WLhjW6OjieZwsE+e+WaZUf/+jOyqsMSReSrmjdkKpBeOxWp5oYyb5MVy//9XJxY2LKxwYAsIGu+
 Ow3DtOWtKU9kCjwUgcb2DNGfrH8TXnY2baD6goE0KDc2D5+Q4g/+yLN1bcuV9opqaH20JItmnlW
 NuGTdyd4qY+PmDg9oETm0Vnc1Zz/c9Ke25BzjRoRZWN+01Y9dnP4DICU7dFIkxdDScnVoVabvia
 bScNUEsbh4+7e3YVLDQ==
X-Authority-Analysis: v=2.4 cv=G7uJgNk5 c=1 sm=1 tr=0 ts=6ae071c9 cx=c_pps
 a=5BHTudwdYE3Te8bg5FgnPg==:117 a=5BHTudwdYE3Te8bg5FgnPg==:17
 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=Y2IxJ9c9Rs8Kov3niI8_:22 a=VnNF1IyMAAAA:8
 a=ug61Not0SAhTC34dxX0A:9 a=QEXdDO2ut3YA:10
X-Proofpoint-GUID: NwuloVkkMSPCgliCCQNi6G9teFaDgFac
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-10-27_02,2026-10-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 adultscore=0 impostorscore=0 suspectscore=0 clxscore=1011
 phishscore=0 spamscore=0 malwarescore=0 lowpriorityscore=0 priorityscore=1501
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2610190000 definitions=main-2610270036
Received-SPF: none client-ip=148.163.158.5;
 envelope-from=saif.abrar@linux.vnet.ibm.com; helo=mx0b-001b2d01.pphosted.com
X-Spam_score_int: -26
X-Spam_score: -2.7
X-Spam_bar: --
X-Spam_report: (-2.7 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, RCVD_IN_DNSWL_LOW=-0.7,
 RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001, SPF_HELO_NONE=0.001,
 SPF_NONE=0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
X-Spam-Status: No, score=-15.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Thanks Aditya, updated in v7.


Regards,

Saif


On 12-09-2026 18:07, Aditya Gupta wrote:
> On 26/08/31 07:29AM, Saif Abrar wrote:
>> From: Saif Abrar <saif.abrar@linux.vnet.ibm.com>
>>> <...snip...>
>> --- /dev/null
>> +++ b/tests/qtest/pnv-phb-test.c
>> @@ -0,0 +1,100 @@
>> +/*
>> + * QTest testcase for PowerNV PHB
>> + *
>> + * Copyright (c) 2026, IBM Corporation.
>> + *
>> + * SPDX-License-Identifier: GPL-2.0-or-later
>> + *
>> + */
>> +
>> +#include "qemu/osdep.h"
>> +#include "libqtest.h"
>> +#include "hw/pci-host/pnv_phb4_regs.h"
>> +#include "pnv-xscom.h"
>> +#include "pnv-qtest-common.h"
>> +
>> +#define PHB3_PBCQ_SPCI_ASB_ADDR      0x0
>> +#define PHB3_PBCQ_SPCI_ASB_DATA      0x2
>> +
>> +/* Index of PNV_CHIP_POWER10 in pnv_chips[] within "pnv-xscom.h" */
> minor nit: seems like a leftover comment from patch #3
>
> please feel free to retain the rb with above removed:
>
> Reviewed-by: Aditya Gupta <adityag@linux.ibm.com>
>
> Thanks,
> - Aditya G

