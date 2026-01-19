Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F0651D29C2A
	for <qemu-devel@archiver.kernel.org>; Mon, 19 Jan 2026 14:14:47 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vhq1E-0001oS-Vu; Mon, 19 Jan 2026 09:14:13 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <hbathini@linux.ibm.com>)
 id 1vhk3O-0007ou-KB; Mon, 19 Jan 2026 02:52:04 -0500
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <hbathini@linux.ibm.com>)
 id 1vhk3L-00042i-Fi; Mon, 19 Jan 2026 02:52:02 -0500
Received: from pps.filterd (m0360083.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 60INkqud012605;
 Mon, 19 Jan 2026 07:51:58 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=pp1; bh=+BCcdZ
 mfnQBcvBawJxKVGDg42lliYU9j3L15LX3vK8A=; b=TlonmpU6mDsDIkig4/iWFQ
 Fv8jOk0Yt6BnCamMN5GojXoa9gSiHa3QFIkKhO3IUcA0Y+DRW8yujEEdGOFk4pVU
 8sSGzLsyGKAFe+wGn/GcsCv10jmUS+VgWl5tDM1teytpe78/ImZIAmjNG0i5EQkr
 hD4yFp/t7GONFlIcGAPnLaj7XrW85pvbz3NC4E1en5kQ0u7Swa18jOYfrnfLddxz
 0AArm8Py784Y5IS063Uy8g5ExKRF9kZOkIi93r1k3sYPz2ADLCcNkPxIA4TyuxmA
 8ja++1gTVD9+ChiIqk45YWqfPFxNBlbqlQUDHwM3q8AKkgVvr6v10xLzQ0eIeyaA
 ==
Received: from ppma21.wdc07v.mail.ibm.com
 (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4br1x4y0y2-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Mon, 19 Jan 2026 07:51:57 +0000 (GMT)
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
 by ppma21.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 60J747QN027382;
 Mon, 19 Jan 2026 07:51:56 GMT
Received: from smtprelay01.fra02v.mail.ibm.com ([9.218.2.227])
 by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4brnrmnex0-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Mon, 19 Jan 2026 07:51:56 +0000
Received: from smtpav06.fra02v.mail.ibm.com (smtpav06.fra02v.mail.ibm.com
 [10.20.54.105])
 by smtprelay01.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 60J7pqBK40304956
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Mon, 19 Jan 2026 07:51:52 GMT
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 7253D20049;
 Mon, 19 Jan 2026 07:51:52 +0000 (GMT)
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 7CB1520040;
 Mon, 19 Jan 2026 07:51:51 +0000 (GMT)
Received: from [9.43.98.125] (unknown [9.43.98.125])
 by smtpav06.fra02v.mail.ibm.com (Postfix) with ESMTP;
 Mon, 19 Jan 2026 07:51:51 +0000 (GMT)
Message-ID: <f67681eb-d2b2-48cd-995c-a889550cdba4@linux.ibm.com>
Date: Mon, 19 Jan 2026 13:21:50 +0530
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 8/9] pnv/mpipl: Enable MPIPL support
To: Aditya Gupta <adityag@linux.ibm.com>, qemu-devel@nongnu.org
Cc: qemu-ppc@nongnu.org, Sourabh Jain <sourabhjain@linux.ibm.com>,
 Harsh Prateek Bora <harshpb@linux.ibm.com>
References: <20251206055648.1908734-1-adityag@linux.ibm.com>
 <20251206055648.1908734-9-adityag@linux.ibm.com>
Content-Language: en-US
From: Hari Bathini <hbathini@linux.ibm.com>
In-Reply-To: <20251206055648.1908734-9-adityag@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Authority-Analysis: v=2.4 cv=R8AO2NRX c=1 sm=1 tr=0 ts=696de29d cx=c_pps
 a=GFwsV6G8L6GxiO2Y/PsHdQ==:117 a=GFwsV6G8L6GxiO2Y/PsHdQ==:17
 a=IkcTkHD0fZMA:10 a=vUbySO9Y5rIA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=VnNF1IyMAAAA:8 a=e90L0FevrDqDP2QLzzAA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-ORIG-GUID: tSNGiOJ6AUk2i2HFa0QOo9DiyoFh3dkT
X-Proofpoint-GUID: tSNGiOJ6AUk2i2HFa0QOo9DiyoFh3dkT
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMTE5MDA2MyBTYWx0ZWRfX48/Vo/QXObPC
 Lvf+SAqFA+d1/t/LYr78DFxeYpVUlqFawzcCccevqx+EJXrlyLOSk+XMdH2yVtAaOvVTd65cq32
 w9XTGigfQNC0GGDm35+/zPcoLWeNsiLsTlHjVq4Aie6gx0HC+aAYPyzPduFzVaxE0uhY07aY6zA
 sQf4YJG+dGq6M4I4+OlCwXKL8eBeJC/MA99IfkneKD2pBDHQmMFPAdwP1datWJ8DXBqj4X3iRqo
 fOQCd75QDhdWjyYRA1N9syq3FU5DzYczYaaBelYX6ao7D3bvb4vLmgFfZTghjQSIWMF0IPFf+jT
 V7M0QwTJ2DwdD7tUTgyedBMIz6IC9NfZE889IhAbWHGqKL0gYxe8cyJS4WZjBUcWltO0aVbbYIj
 h6dpF0q7ErGCR0Lbg7LotCKQtqt9p/kTtAgk787t+E4wX3EFZETIWd8yxX4POk3EKrJJSQVH0aN
 w//ttXNXoF6vlq3/Sug==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2026-01-19_01,2026-01-19_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 priorityscore=1501 bulkscore=0 lowpriorityscore=0 adultscore=0
 spamscore=0 phishscore=0 malwarescore=0 suspectscore=0 impostorscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2601150000 definitions=main-2601190063
Received-SPF: pass client-ip=148.163.156.1;
 envelope-from=hbathini@linux.ibm.com; helo=mx0a-001b2d01.pphosted.com
X-Spam_score_int: -26
X-Spam_score: -2.7
X-Spam_bar: --
X-Spam_report: (-2.7 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, RCVD_IN_DNSWL_LOW=-0.7,
 RCVD_IN_MSPIKE_H4=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-Mailman-Approved-At: Mon, 19 Jan 2026 09:14:03 -0500
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



On 06/12/25 11:26 am, Aditya Gupta wrote:
> With all MPIPL support in place, export a "dump" node in device tree,
> signifying that PowerNV QEMU platform supports MPIPL
> 
> Signed-off-by: Aditya Gupta <adityag@linux.ibm.com>
> ---
>   hw/ppc/pnv.c | 37 +++++++++++++++++++++++++++++++++++++
>   1 file changed, 37 insertions(+)
> 
> diff --git a/hw/ppc/pnv.c b/hw/ppc/pnv.c
> index 7c36f3a00e90..8a62b0ee1074 100644
> --- a/hw/ppc/pnv.c
> +++ b/hw/ppc/pnv.c
> @@ -54,6 +54,7 @@
>   #include "hw/ppc/pnv_chip.h"
>   #include "hw/ppc/pnv_xscom.h"
>   #include "hw/ppc/pnv_pnor.h"
> +#include "hw/ppc/pnv_mpipl.h"
>   
>   #include "hw/isa/isa.h"
>   #include "hw/char/serial-isa.h"
> @@ -671,6 +672,39 @@ static void pnv_dt_power_mgt(PnvMachineState *pnv, void *fdt)
>       _FDT(fdt_setprop_cell(fdt, off, "ibm,enabled-stop-levels", 0xc0000000));
>   }
>   
> +static void pnv_dt_mpipl_dump(PnvMachineState *pnv, void *fdt)
> +{
> +    int off;
> +
> +    /*
> +     * Add "dump" node so kernel knows MPIPL (aka fadump) is supported
> +     *
> +     * Note: This is only needed to be done since we are passing device tree to
> +     * opal
> +     *
> +     * In case HDAT is supported in future, then opal can add these nodes by
> +     * itself based on system attribute having MPIPL_SUPPORTED bit set
> +     */
> +    off = fdt_add_subnode(fdt, 0, "ibm,opal");
> +    if (off == -FDT_ERR_EXISTS) {
> +        off = fdt_path_offset(fdt, "/ibm,opal");
> +    }
> +
> +    _FDT(off);
> +    off = fdt_add_subnode(fdt, off, "dump");
> +    _FDT(off);
> +    _FDT((fdt_setprop_string(fdt, off, "compatible", "ibm,opal-dump")));
> +

> +    /* Add kernel and initrd as fw-load-area */
> +    uint64_t fw_load_area[4] = {
> +        cpu_to_be64(KERNEL_LOAD_ADDR), cpu_to_be64(KERNEL_MAX_SIZE),
> +        cpu_to_be64(INITRD_LOAD_ADDR), cpu_to_be64(INITRD_MAX_SIZE)
> +    };
> +
> +    _FDT((fdt_setprop(fdt, off, "fw-load-area",
> +                    fw_load_area, sizeof(fw_load_area))));
> +}
> +

While the changelog only talks about dump node, fw-load-area is
exported too. A comment explaining what and why it is used helps..

- Hari

