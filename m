Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AECF4CD6E4A
	for <qemu-devel@archiver.kernel.org>; Tue,  2 Jun 2026 06:35:25 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wUIi3-00060O-Bh; Tue, 02 Jun 2026 02:34:44 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <adityag@linux.ibm.com>)
 id 1wUIhW-0005hP-7E; Tue, 02 Jun 2026 02:34:11 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <adityag@linux.ibm.com>)
 id 1wUIhU-0004d0-0N; Tue, 02 Jun 2026 02:34:09 -0400
Received: from pps.filterd (m0360072.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 651HeKIm2242832; Tue, 2 Jun 2026 06:34:04 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=pp1; bh=iRfhCz
 hzJsflV+KNA4eZG62H4QjSDmf+whkdXyxZ8XQ=; b=JDYwzKIE1zizV229RPOW1z
 uMaPUbE6PD2A/ixzIH9v5KMSvZ5lXM1UBBWFmBKq5UPqzXD3agy+mhfSb3/HjN7R
 X37D7rK/pqmn/jvYY1+FrR8cSnnWnSZLBKh4GyjKcrcA8pg5KBbWhQexB7VclFYV
 Jj2k4aj6yMmN8/JkcQpXyrap6Qzb85hke6MEnj1XBgTyoanvsnCub76ANtuJR5OI
 9O9IgYke23NXeM2PqRP3cE8JUdaaPIJydwxHigsooyTsUTM/t/kSBZkHltQ9ZVHO
 uJ4KNYmd0YXx1DZhvpLCF73L4U9qc2KLqvzO1umPht27e3nG+QROhBFyLEY6+KJA
 ==
Received: from ppma13.dal12v.mail.ibm.com
 (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4efqht4301-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 02 Jun 2026 06:34:03 +0000 (GMT)
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
 by ppma13.dal12v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 6526OAlm031407;
 Tue, 2 Jun 2026 06:34:03 GMT
Received: from smtprelay04.fra02v.mail.ibm.com ([9.218.2.228])
 by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 4egceghntf-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 02 Jun 2026 06:34:02 +0000 (GMT)
Received: from smtpav06.fra02v.mail.ibm.com (smtpav06.fra02v.mail.ibm.com
 [10.20.54.105])
 by smtprelay04.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 6526Xx5h14418352
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Tue, 2 Jun 2026 06:33:59 GMT
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 5B63C20040;
 Tue,  2 Jun 2026 06:33:59 +0000 (GMT)
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 4025C20049;
 Tue,  2 Jun 2026 06:33:57 +0000 (GMT)
Received: from [9.123.10.203] (unknown [9.123.10.203])
 by smtpav06.fra02v.mail.ibm.com (Postfix) with ESMTP;
 Tue,  2 Jun 2026 06:33:57 +0000 (GMT)
Message-ID: <86373bf5-15d0-437b-820f-c4f1ac72a2db@linux.ibm.com>
Date: Tue, 2 Jun 2026 12:03:55 +0530
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] hw/pci-host: Split PowerNV PHB5 code from PHB4 files
To: Jishnu Warrier <jishnuvw@linux.ibm.com>, qemu-devel@nongnu.org,
 qemu-ppc@nongnu.org
Cc: Nicholas Piggin <npiggin@gmail.com>,
 Harsh Prateek Bora <harshpb@linux.ibm.com>,
 Glenn Miles <milesg@linux.ibm.com>,
 Mahesh Salgaonkar <mahesh@linux.ibm.com>
References: <20260601161802.202512-1-jishnuvw@linux.ibm.com>
Content-Language: en-US
From: Aditya Gupta <adityag@linux.ibm.com>
In-Reply-To: <20260601161802.202512-1-jishnuvw@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Proofpoint-GUID: eMj3-wxtRCmBrKiwBu8ESndrRB61kCYk
X-Authority-Analysis: v=2.4 cv=fv/sol4f c=1 sm=1 tr=0 ts=6a1e795c cx=c_pps
 a=AfN7/Ok6k8XGzOShvHwTGQ==:117 a=AfN7/Ok6k8XGzOShvHwTGQ==:17
 a=IkcTkHD0fZMA:10 a=FelO9ux0wxsA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=RzCfie-kr_QcCd8fBx8p:22 a=VnNF1IyMAAAA:8
 a=IOlkZWXo4gXxfCjJdxkA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjAyMDA1NCBTYWx0ZWRfX2TBJobt3/3qG
 v4YoElYLkujO8sTrvbXkMDE8kpd6tnAUeVacCMLlKoFk0gXAKFE0mgvEC5leLkN1XJZ0ZOf24gz
 GtjPADURnVTbz6BB68bWvH/FYYfHZih6wNwyrRAfIiR5InokH7Ane8ztKSCErm3/rkgmOGbcD3G
 TbELC2qf9OeYstfABURkk9yIeWjUQFY70uaMkDYueDTfCLXttQcpzHdZzPKdRMexEm/uVbSBpXs
 swVjyXFnVGUD0rBx+zrkB65XG84OempCkZ0TSWwDwIlE2aPpti33jSDeLLZ3BW760e37H3FYc7l
 /Ij1aPac+dpeaXOxXQiuMyeNSX/GHxTC7GqwCnq/bB/TOTd8ibRfig5gp8t6ZhvVBIKbTYoo4m2
 7pYqKv46e0WHE5GTE4nGln0drpVZg9q1YNgijWMSLLhwZPE3DSmqlBTJvu3DO2AfiKapkqc0Q+F
 n3UaGtUUpbNx8cZXvdA==
X-Proofpoint-ORIG-GUID: ZE-QPzwvbB9mWZv1vChwPhJtbjFJ5u6K
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-01_07,2026-05-28_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 priorityscore=1501 spamscore=0 phishscore=0 clxscore=1015
 impostorscore=0 suspectscore=0 bulkscore=0 lowpriorityscore=0 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2605210000 definitions=main-2606020054
Received-SPF: pass client-ip=148.163.158.5; envelope-from=adityag@linux.ibm.com;
 helo=mx0b-001b2d01.pphosted.com
X-Spam_score_int: -26
X-Spam_score: -2.7
X-Spam_bar: --
X-Spam_report: (-2.7 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, RCVD_IN_DNSWL_LOW=-0.7,
 RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

Thanks for this patch jishnu

On 01/06/26 21:48, Jishnu Warrier wrote:
> Separate Power10/11 PHB5 implementation from Power9 PHB4 code for
> better maintainability and clarity. This is a pure code movement
> with no functional changes.
>
> Signed-off-by: Jishnu Warrier <jishnuvw@linux.ibm.com>
> <...snip...>
>
> +/*
> + * SPDX-License-Identifier: GPL-2.0-or-later
> + *
> + * QEMU PowerPC PowerNV (POWER10) PHB5 model
> + *
> + * Copyright (c) 2018-2026, IBM Corporation.
> + */
minor nit: generally the file description is at the top, SPDX line can 
go at the end of comment
> +#include "qemu/osdep.h"
> +#include "hw/pci-host/pnv_phb4.h"
> +#include "qom/object.h"
> +
> +static const TypeInfo pnv_phb5_type_info = {
> +    .name          = TYPE_PNV_PHB5,
> +    .parent        = TYPE_PNV_PHB4,
> +    .instance_size = sizeof(PnvPHB4),
> +};
> +
> +static void pnv_phb5_register_types(void)
> +{
> +    type_register_static(&pnv_phb5_type_info);
> +}
> +
> +type_init(pnv_phb5_register_types);
> diff --git a/hw/pci-host/pnv_phb5_pec.c b/hw/pci-host/pnv_phb5_pec.c
> new file mode 100644
> index 0000000000..d48bc09b8b
> --- /dev/null
> +++ b/hw/pci-host/pnv_phb5_pec.c
> @@ -0,0 +1,89 @@
> +/*
> + * SPDX-License-Identifier: GPL-2.0-or-later
> + *
> + * QEMU PowerPC PowerNV (POWER10) PHB5 PEC model
> + *
> + * Copyright (c) 2018-2026, IBM Corporation.
> + */
> +#include "qemu/osdep.h"
> +#include "qapi/error.h"
> +#include "qemu/log.h"
> +#include "target/ppc/cpu.h"
> +#include "hw/ppc/fdt.h"
> +#include "hw/pci-host/pnv_phb4_regs.h"
> +#include "hw/pci-host/pnv_phb4.h"
> +#include "hw/ppc/pnv_xscom.h"
> +#include "hw/pci/pci_bridge.h"
> +#include "hw/pci/pci_bus.h"
> +#include "hw/ppc/pnv.h"
> +#include "hw/ppc/pnv_chip.h"
> +#include "hw/core/qdev-properties.h"
> +#include "system/system.h"
> +
> +#include <libfdt.h>

nit: fdt related and other headers are not required, for me, below 
includes look enough:

     #include "qemu/osdep.h"
     #include "hw/pci-host/pnv_phb4.h"
     #include "hw/ppc/pnv_xscom.h"

similarly qom/object.h isn't required in pnv_phb5.c

rest of the code looks good to me.


Thanks,

- Aditya G


