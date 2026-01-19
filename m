Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 999A5D29C2A
	for <qemu-devel@archiver.kernel.org>; Mon, 19 Jan 2026 14:15:42 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vhq1q-0002Ny-7Y; Mon, 19 Jan 2026 09:14:51 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <hbathini@linux.ibm.com>)
 id 1vhjxC-0002b4-E9; Mon, 19 Jan 2026 02:45:42 -0500
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <hbathini@linux.ibm.com>)
 id 1vhjx8-0003Bk-Fr; Mon, 19 Jan 2026 02:45:36 -0500
Received: from pps.filterd (m0353729.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 60J4omgu001545;
 Mon, 19 Jan 2026 07:45:33 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=pp1; bh=d5sN+V
 599iPvwMQjrv/5fGxAtFZ2AVSkt88m+olERqM=; b=Cru3kbUJhdurzyYYhq7rJo
 sz49J4uchDMc8RlMaubuZCXSk6G16zObg6ildiXvjKErQFJadB7cXN6Q1bp5QXoR
 NYNrZjDNWJqZWvvy1W+fdppLwiE8uPRhQzDtqhTYGcFiNVUw9Sh7+3DAy1riSfsS
 AJ5yF2vNFixk4ca0oc90tf4wrW+65lx1eAw3Gx1F40Cb06EoVkx+Ed2eAw+vxVaW
 xgNFaFuNyFkCgD3kkf8IiYI1bYDE/XPElIaLj+O0IicKh0UX+K0KJBQ+l2D8+Pm4
 Fu/iwe3GC+T+SmOYZHqwHtHRHn8wLj+9qyQEvde+SuqucoV5aWoYlCbvQtrG5v0A
 ==
Received: from ppma11.dal12v.mail.ibm.com
 (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4br23rq0yn-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Mon, 19 Jan 2026 07:45:32 +0000 (GMT)
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
 by ppma11.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 60J4qmBC006394;
 Mon, 19 Jan 2026 07:45:31 GMT
Received: from smtprelay03.fra02v.mail.ibm.com ([9.218.2.224])
 by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 4brqf154nm-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Mon, 19 Jan 2026 07:45:31 +0000
Received: from smtpav06.fra02v.mail.ibm.com (smtpav06.fra02v.mail.ibm.com
 [10.20.54.105])
 by smtprelay03.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 60J7jSEc57016720
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Mon, 19 Jan 2026 07:45:28 GMT
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 0EB772004B;
 Mon, 19 Jan 2026 07:45:28 +0000 (GMT)
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 164EC20049;
 Mon, 19 Jan 2026 07:45:27 +0000 (GMT)
Received: from [9.43.98.125] (unknown [9.43.98.125])
 by smtpav06.fra02v.mail.ibm.com (Postfix) with ESMTP;
 Mon, 19 Jan 2026 07:45:26 +0000 (GMT)
Message-ID: <eb079c05-2ff9-4dde-a82d-31d3f37951d8@linux.ibm.com>
Date: Mon, 19 Jan 2026 13:15:26 +0530
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 4/9] pnv/mpipl: Preserve memory regions as per
 MDST/MDDT tables
To: Aditya Gupta <adityag@linux.ibm.com>, qemu-devel@nongnu.org
Cc: qemu-ppc@nongnu.org, Sourabh Jain <sourabhjain@linux.ibm.com>,
 Harsh Prateek Bora <harshpb@linux.ibm.com>
References: <20251206055648.1908734-1-adityag@linux.ibm.com>
 <20251206055648.1908734-5-adityag@linux.ibm.com>
Content-Language: en-US
From: Hari Bathini <hbathini@linux.ibm.com>
In-Reply-To: <20251206055648.1908734-5-adityag@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: _y-dZq98iI7qXqRNvr1UEbJ4HTjxaw_h
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMTE5MDA1OSBTYWx0ZWRfXxQpS6u46zNgA
 mGz8mdloVrPnfiZzYd/r3+Q0diM+dRY/dju3y4/bhGHcM4zZUblOamtZl/p6mDPyojhtjEreRyh
 LQK/4W56MIvXWZyUopPswjifWQtNlg7BpOsUIaYvSu3e2vXnrpYNMdRogBDrBhLWPtJRKEOFlHo
 Q/0LbqJTh4+lBrhxZzzotxSW22ClOL1cBjGMTYXwx65GOkiLXQKDVIwwad947hELY+tuOhSEAMc
 jTAecCh//4mjoyEZD8bpUP/0JM2GillfPCvHG8LYmHFhey6iaAxw90zFf+FNehi0/T2ZBFaXxDL
 qhOPX5AcE+lxTl03UqiNPeIB89Cf4qzs1TjUVbSJcH/beAGHgiLTq+pXyAT//rAj3QVrK85de3c
 7ii2xus7XyZ3Dm2Vq6QdZY7/nm7mAVaXZ6xdtXKjbN7XpcZ8oHVLDpFTuOvgMed4p1DEWL80ee6
 QmzPQaPJ7APhofkfmlQ==
X-Authority-Analysis: v=2.4 cv=J9SnLQnS c=1 sm=1 tr=0 ts=696de11c cx=c_pps
 a=aDMHemPKRhS1OARIsFnwRA==:117 a=aDMHemPKRhS1OARIsFnwRA==:17
 a=IkcTkHD0fZMA:10 a=vUbySO9Y5rIA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=VnNF1IyMAAAA:8 a=sXdiNxlIhFd3OQyGzZcA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-ORIG-GUID: _y-dZq98iI7qXqRNvr1UEbJ4HTjxaw_h
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2026-01-19_01,2026-01-19_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 impostorscore=0 adultscore=0 suspectscore=0 spamscore=0
 lowpriorityscore=0 malwarescore=0 clxscore=1015 bulkscore=0 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2601150000 definitions=main-2601190059
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
> Implement copying of memory region, as mentioned by MDST and MDDT
> tables.
> 
> Copy the memory regions from source to destination in chunks of 32MB
> 
> Note, qemu can fail preserving a particular entry due to any reason,
> such as:
>    * region length mis-matching in MDST & MDDT
>    * failed copy due to access/decode/etc memory issues
> 
> HDAT doesn't specify any field in MDRT to notify host about such errors.
> 

> Though HDAT section "15.3.1.3 Memory Dump Results Table (MDRT)" says:
>      The Memory Dump Results Table is a list of the memory ranges that
>      have been included in the dump
> 
> Based on above statement, it looks like MDRT should include only those
> regions which are successfully captured in the dump, hence, regions
> which qemu fails to dump, just get skipped, and will not have a
> corresponding entry in MDRT

Yeah. No error status is looked for by kernel. It tries to export
/proc/vmcore with how much ever firmware succeeds in preserving..

> 
> Signed-off-by: Aditya Gupta <adityag@linux.ibm.com>
> ---
>   hw/ppc/pnv_mpipl.c         | 157 +++++++++++++++++++++++++++++++++++++
>   include/hw/ppc/pnv_mpipl.h |  83 ++++++++++++++++++++
>   2 files changed, 240 insertions(+)
> 
> diff --git a/hw/ppc/pnv_mpipl.c b/hw/ppc/pnv_mpipl.c
> index d8c9b7a428b7..a4f7113a44fd 100644
> --- a/hw/ppc/pnv_mpipl.c
> +++ b/hw/ppc/pnv_mpipl.c
> @@ -5,12 +5,169 @@
>    */
>   
>   #include "qemu/osdep.h"
> +#include "qemu/log.h"
> +#include "qemu/units.h"
> +#include "system/address-spaces.h"
>   #include "system/runstate.h"
>   #include "hw/ppc/pnv.h"
>   #include "hw/ppc/pnv_mpipl.h"
> +#include <math.h>
> +
> +#define MDST_TABLE_RELOCATED                            \
> +    (pnv->mpipl_state.skiboot_base + MDST_TABLE_OFF)
> +#define MDDT_TABLE_RELOCATED                            \
> +    (pnv->mpipl_state.skiboot_base + MDDT_TABLE_OFF)
> +
> +/*
> + * Preserve the memory regions as pointed by MDST table
> + *
> + * During this, the memory region pointed by entries in MDST, are 'copied'
> + * as it is to the memory region pointed by corresponding entry in MDDT
> + *
> + * Notes: All reads should consider data coming from skiboot as bigendian,
> + *        and data written should also be in big-endian
> + */
> +static bool pnv_mpipl_preserve_mem(PnvMachineState *pnv)
> +{
> +    g_autofree MdstTableEntry *mdst = g_malloc(MDST_TABLE_SIZE);
> +    g_autofree MddtTableEntry *mddt = g_malloc(MDDT_TABLE_SIZE);
> +    g_autofree MdrtTableEntry *mdrt = g_malloc0(MDRT_TABLE_SIZE);
> +    AddressSpace *default_as = &address_space_memory;
> +    MemTxResult io_result;
> +    MemTxAttrs attrs;
> +    uint64_t src_addr, dest_addr;
> +    uint32_t src_len;
> +    uint64_t num_chunks;
> +    int mdrt_idx = 0;
> +
> +    /* Mark the memory transactions as privileged memory access */
> +    attrs.user = 0;
> +    attrs.memory = 1;
> +
> +    if (pnv->mpipl_state.mdrt_table) {
> +        /*
> +         * MDRT table allocated from some past crash, free the memory to
> +         * prevent memory leak
> +         */
> +        g_free(pnv->mpipl_state.mdrt_table);
> +        pnv->mpipl_state.num_mdrt_entries = 0;
> +    }
> +
> +    io_result = address_space_read(default_as, MDST_TABLE_RELOCATED, attrs,
> +            mdst, MDST_TABLE_SIZE);
> +    if (io_result != MEMTX_OK) {
> +        qemu_log_mask(LOG_GUEST_ERROR,
> +            "MPIPL: Failed to read MDST table at: 0x%lx\n",
> +            MDST_TABLE_RELOCATED);
> +
> +        return false;
> +    }
> +
> +    io_result = address_space_read(default_as, MDDT_TABLE_RELOCATED, attrs,
> +            mddt, MDDT_TABLE_SIZE);
> +    if (io_result != MEMTX_OK) {
> +        qemu_log_mask(LOG_GUEST_ERROR,
> +            "MPIPL: Failed to read MDDT table at: 0x%lx\n",
> +            MDDT_TABLE_RELOCATED);
> +
> +        return false;
> +    }
> +
> +    /* Try to read all entries */
> +    for (int i = 0; i < MDST_MAX_ENTRIES; ++i) {
> +        g_autofree uint8_t *copy_buffer = NULL;
> +        bool is_copy_failed = false;
> +
> +        /* Considering entry with address and size as 0, as end of table */
> +        if ((mdst[i].addr == 0) && (mdst[i].size == 0)) {
> +            break;
> +        }
> +
> +        if (mdst[i].size != mddt[i].size) {
> +            qemu_log_mask(LOG_TRACE,
> +                    "Warning: Invalid entry, size mismatch in MDST & MDDT\n");
> +            continue;
> +        }
> +
> +        if (mdst[i].data_region != mddt[i].data_region) {
> +            qemu_log_mask(LOG_TRACE,
> +                    "Warning: Invalid entry, region mismatch in MDST & MDDT\n");
> +            continue;
> +        }
> +
> +        src_addr  = be64_to_cpu(mdst[i].addr) & ~HRMOR_BIT;
> +        dest_addr = be64_to_cpu(mddt[i].addr) & ~HRMOR_BIT;

> +        src_len   = be32_to_cpu(mddt[i].size);

data_len sounds more appropriate instead of src_len here, especially
as we are using mddt length..

- Hari

