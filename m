Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 150BBF4181F
	for <qemu-devel@archiver.kernel.org>; Mon,  9 Mar 2026 17:09:56 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vze6w-0002Lj-AO; Mon, 09 Mar 2026 13:09:42 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alifm@linux.ibm.com>)
 id 1vze6t-0002KO-OK; Mon, 09 Mar 2026 13:09:40 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alifm@linux.ibm.com>)
 id 1vze6r-0004Le-Gj; Mon, 09 Mar 2026 13:09:39 -0400
Received: from pps.filterd (m0360072.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 629EXJDq1273637; Mon, 9 Mar 2026 17:09:34 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=pp1; bh=KRZJSa
 3HIkLDeIEZv5wO9fUvTwGxwUmugPB8Vblb97U=; b=p51gd/J5YmboHkFTuLSq81
 VO2xFd432mqlzNo7vG/JgN0dqylW5/21uXmJa9aU2p0NPz5nKgxheWOgDaLPL7DS
 p30IHRTGvig7420QonQolgvko3fhwDi86gxkz48Z4miz2UMzNZ7m6lYGXYcXWmqO
 6GCF7iUq/s6Pp9PfLj5u+/NiKm6hTukmlY8LLMehIc2njfG2zFp5YDA8Yf88lSoa
 zhWq6nTMp3Bov/DVJwwWb7Zpp1mEdkEuxF0fsf/wNQoAKYKI8+3NhJegnZs/Qk88
 uMectYGVSDAck8Skmtcr9P3GblBDHTyrfDmw0gE3EqJSUOzLZHJ3zQabITMYkRdg
 ==
Received: from ppma12.dal12v.mail.ibm.com
 (dc.9e.1632.ip4.static.sl-reverse.com [50.22.158.220])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4crcvr7dp6-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Mon, 09 Mar 2026 17:09:34 +0000 (GMT)
Received: from pps.filterd (ppma12.dal12v.mail.ibm.com [127.0.0.1])
 by ppma12.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 629EBi0a021150;
 Mon, 9 Mar 2026 17:09:33 GMT
Received: from smtprelay06.dal12v.mail.ibm.com ([172.16.1.8])
 by ppma12.dal12v.mail.ibm.com (PPS) with ESMTPS id 4crxbsp0fe-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Mon, 09 Mar 2026 17:09:33 +0000
Received: from smtpav02.wdc07v.mail.ibm.com (smtpav02.wdc07v.mail.ibm.com
 [10.39.53.229])
 by smtprelay06.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 629H9WJ454985106
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Mon, 9 Mar 2026 17:09:32 GMT
Received: from smtpav02.wdc07v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 2D01B58058;
 Mon,  9 Mar 2026 17:09:32 +0000 (GMT)
Received: from smtpav02.wdc07v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 39FB55805B;
 Mon,  9 Mar 2026 17:09:31 +0000 (GMT)
Received: from [9.61.251.111] (unknown [9.61.251.111])
 by smtpav02.wdc07v.mail.ibm.com (Postfix) with ESMTP;
 Mon,  9 Mar 2026 17:09:31 +0000 (GMT)
Message-ID: <cfc79e1c-9a5c-4217-9038-b2617931bb88@linux.ibm.com>
Date: Mon, 9 Mar 2026 10:09:30 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 10/15] pc-bios/s390-ccw: Introduce PCI device
To: jrossi@linux.ibm.com, qemu-devel@nongnu.org, qemu-s390x@nongnu.org,
 thuth@redhat.com, mst@redhat.com
Cc: jjherne@linux.ibm.com, farman@linux.ibm.com, mjrosato@linux.ibm.com,
 zycai@linux.ibm.com
References: <20260309003601.242634-1-jrossi@linux.ibm.com>
 <20260309003601.242634-11-jrossi@linux.ibm.com>
Content-Language: en-US
From: Farhan Ali <alifm@linux.ibm.com>
In-Reply-To: <20260309003601.242634-11-jrossi@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzA5MDE1MyBTYWx0ZWRfX2QrDhIyFjwUt
 b7GrG4Is0JTuX/mcSe5auX0LMt5WTK/k4qnJ42IJ0C+ACAU/6NMRN6EVkZvpFDc12ELU2sH/Ep3
 OP/t/+4ND2kUnztKbjpmg9vGO6GT4TY/l+vxlbU2berqnRnRjfGw0EipEFHJwZrjB0ySteUQ2b+
 b5S81LY5z4lrM+US5THZs+XMk1MKJXHSiumvw2stGuwrz5hCvkIETvp8dplfyfUsx8yXcGkRni4
 CtV60pK7GUr9oJ40v1nlGL9DChegtpmSwFc7UT0eYFqmIGLXonZY5tOvzuBFxvrPfXPkr0q2D1A
 nT7HzNrC0djKlvbMumagZB1oqTLYzXyFrzcDuMBxTddecpWQC2mhw0BKTaWuLSPBslMyzxLHZgc
 BesKw3v5Rj1BBgVIMHKHIDpDUFl1ilS/T1RIaPQWyNs4edSHkzMggCDIPjGpj+gulzV3uPNJ72g
 WE+ZpguGXcp2bg/5/3A==
X-Proofpoint-GUID: 3j1vd748ZoemjN0_6CGAS7RjqROB62FT
X-Proofpoint-ORIG-GUID: 3j1vd748ZoemjN0_6CGAS7RjqROB62FT
X-Authority-Analysis: v=2.4 cv=QoFTHFyd c=1 sm=1 tr=0 ts=69aefece cx=c_pps
 a=bLidbwmWQ0KltjZqbj+ezA==:117 a=bLidbwmWQ0KltjZqbj+ezA==:17
 a=IkcTkHD0fZMA:10 a=Yq5XynenixoA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=RzCfie-kr_QcCd8fBx8p:22 a=VnNF1IyMAAAA:8
 a=DTgVIiggviyzEEToKV0A:9 a=QEXdDO2ut3YA:10
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-03-09_04,2026-03-09_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 spamscore=0 priorityscore=1501 phishscore=0
 lowpriorityscore=0 adultscore=0 clxscore=1015 malwarescore=0 suspectscore=0
 bulkscore=0 classifier=typeunknown authscore=0 authtc= authcc= route=outbound
 adjust=0 reason=mlx scancount=1 engine=8.22.0-2602130000
 definitions=main-2603090153
Received-SPF: pass client-ip=148.163.158.5; envelope-from=alifm@linux.ibm.com;
 helo=mx0b-001b2d01.pphosted.com
X-Spam_score_int: -9
X-Spam_score: -1.0
X-Spam_bar: -
X-Spam_report: (-1.0 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, RCVD_IN_DNSWL_LOW=-0.7,
 RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.819, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.903,
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


On 3/8/2026 5:35 PM, jrossi@linux.ibm.com wrote:
> diff --git a/pc-bios/s390-ccw/pci.h b/pc-bios/s390-ccw/pci.h
> new file mode 100644
> index 0000000000..40a0bf9dcb
> --- /dev/null
> +++ b/pc-bios/s390-ccw/pci.h
> @@ -0,0 +1,39 @@
> +/*
> + * s390x PCI definitions
> + *
> + * Copyright 2025 IBM Corp.
> + * Author(s): Jared Rossi<jrossi@linux.ibm.com>
> + *
> + * SPDX-License-Identifier: GPL-2.0-or-later
> + */
> +
> +#ifndef PCI_H
> +#define PCI_H
> +
> +#include <stdint.h>
> +#include <stdbool.h>
> +#include "clp.h"
> +
> +#define ZPCI_CREATE_REQ(handle, space, len)                    \
> +    ((uint64_t) handle << 32 | space << 16 | len)
> +
> +union register_pair {
> +    unsigned __int128 pair;
> +    struct {
> +        unsigned long even;
> +        unsigned long odd;
> +    };
> +};
> +
> +#define PCIST_DISABLED         0x0
> +#define PCIST_ENABLED          0x1

Where are we using these #defines? I couldn't find it in the code. So 
maybe we should remove them? Apart from this the patch looks good to me.

Reviewed-by: Farhan Ali<alifm@linux.ibm.com>


Thanks

Farhan


> +
> +#define PCI_CFGBAR             0xF  /* Base Address Register for config space */
> +#define PCI_CAPABILITY_LIST    0x34 /* Offset of first capability list entry */
> +
> +int pci_write(uint32_t fhandle, uint64_t offset, uint8_t pcias, uint64_t data,
> +              uint8_t len);
> +int pci_read(uint32_t fhandle, uint64_t offset, uint8_t pcias, void *buf,
> +             uint8_t len);
> +
> +#endif

