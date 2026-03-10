Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5B1E8EB1049
	for <qemu-devel@archiver.kernel.org>; Tue, 10 Mar 2026 11:02:19 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vzuqX-0000z0-Og; Tue, 10 Mar 2026 07:01:55 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <sourabhjain@linux.ibm.com>)
 id 1vzuqC-0000xK-97; Tue, 10 Mar 2026 07:01:33 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <sourabhjain@linux.ibm.com>)
 id 1vzuq9-0003si-DE; Tue, 10 Mar 2026 07:01:31 -0400
Received: from pps.filterd (m0353725.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 62A4dVs8661980; Tue, 10 Mar 2026 11:01:15 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=pp1; bh=nRSzBN
 1cnLZc3ZRZVqJviC37BuQuY+FK+RY3jhwDK58=; b=g0cixMpOB5uwfMCoDC+kkO
 AYvzSAXZtIEOEykot5YCQ+8iNKz46vmg485lgFDoipMMdAwSl4ZPdX2jOF/0usJt
 nCdCiwG4IfsMx6y7OdurGEz4SV5Fz3irfYanKYUcPyuSYx6AzH22G/2SrtRTjOnX
 kQs2GY/Fiq2cHYTNoVXeKqmx+/VBzflwvty+CVApdB4m742PSxseyqytVi9ghR6k
 Y6y45ljEjfXcCSm1CzXZdIXds3zUcM6ZzizQXQHc4hrzoadzKQMKRpnD/rWtSLPd
 tH3wRwUiViz3v5SQz008psImW9ZIgEXmYxRHV4dnNeZzWH26CYcqtGAqyawYBnuw
 ==
Received: from ppma11.dal12v.mail.ibm.com
 (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4crd1mj4xw-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 10 Mar 2026 11:01:14 +0000 (GMT)
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
 by ppma11.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 62A81sPq015771;
 Tue, 10 Mar 2026 11:01:13 GMT
Received: from smtprelay01.fra02v.mail.ibm.com ([9.218.2.227])
 by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 4cs1220fd9-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 10 Mar 2026 11:01:13 +0000
Received: from smtpav07.fra02v.mail.ibm.com (smtpav07.fra02v.mail.ibm.com
 [10.20.54.106])
 by smtprelay01.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 62AB17Vd62062960
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Tue, 10 Mar 2026 11:01:07 GMT
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 225DE2004B;
 Tue, 10 Mar 2026 11:01:07 +0000 (GMT)
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 3D55220043;
 Tue, 10 Mar 2026 11:01:05 +0000 (GMT)
Received: from [9.109.204.116] (unknown [9.109.204.116])
 by smtpav07.fra02v.mail.ibm.com (Postfix) with ESMTP;
 Tue, 10 Mar 2026 11:01:05 +0000 (GMT)
Message-ID: <75cc39a2-2327-461d-9ca8-ed240b1a6e2e@linux.ibm.com>
Date: Tue, 10 Mar 2026 16:31:04 +0530
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 07/10] pnv/mpipl: Write the preserved CPU and MDRT state
To: Aditya Gupta <adityag@linux.ibm.com>, qemu-devel@nongnu.org
Cc: qemu-ppc@nongnu.org, Hari Bathini <hbathini@linux.ibm.com>,
 Harsh Prateek Bora <harshpb@linux.ibm.com>,
 Nicholas Piggin <npiggin@gmail.com>,
 Miles Glenn <milesg@linux.ibm.com>, Chinmay Rath <rathc@linux.ibm.com>,
 Shivang Upadhyay <shivangu@linux.ibm.com>
References: <20260309072001.3136261-1-adityag@linux.ibm.com>
 <20260309072001.3136261-8-adityag@linux.ibm.com>
Content-Language: en-US
From: Sourabh Jain <sourabhjain@linux.ibm.com>
In-Reply-To: <20260309072001.3136261-8-adityag@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Authority-Analysis: v=2.4 cv=ds3Wylg4 c=1 sm=1 tr=0 ts=69aff9fa cx=c_pps
 a=aDMHemPKRhS1OARIsFnwRA==:117 a=aDMHemPKRhS1OARIsFnwRA==:17
 a=IkcTkHD0fZMA:10 a=Yq5XynenixoA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=V8glGbnc2Ofi9Qvn3v5h:22 a=VnNF1IyMAAAA:8
 a=OCuGa67OR13ycClGfpMA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzEwMDA5MCBTYWx0ZWRfX1EzDv1Y6sBXd
 Fac82wp/SQcChnc2fJ5RlCw0XC51y2GjA8AGw2W8EWqV48VVt2IxZcLi9MV7Ln/6YDkfDtfH7gf
 BJRxSdTVEkKRxhed56oI5NUtR5ZwUoRf1//3w1jNGSPaqXl2xsDlp88zbXq1vo3tzXLbHN1Ryeg
 5CMSBhAzwKN7ceXC1klJkoRskLYdgqYWWxsmA1Pj7sA9yYIRYk6K9v3TwfSt1pS0tirAi5XC4lQ
 HCD2qJBi3Vp0v45PuV9ryKBxPpHgiF3VZuDnj0AZG4VsNwypTiOtf1C/S2gZEjuh8da8RHD1ZqW
 17zqHaJPPip9JTcXDVqOpxoUbdnFeSq0Pv+PM8w7d/HIoYQMby1jZEix+peI4TUzxnAtqo7ow0h
 oG/sE7ypHWaJL9ksfGorU9WpWDhPYIi96ivbmsccbG4YQRxJOBmi3xPcCQQhB7Gf7aL2wOz9tbM
 Sq9z3v3rm810M+oT6/w==
X-Proofpoint-GUID: t9rUM8mHyD_oWnvL2d6ShOy8S1mbT0lS
X-Proofpoint-ORIG-GUID: zYOo3iNjCeR3tQGetI-dMhx0kO0_8ebU
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-03-10_02,2026-03-09_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 phishscore=0 clxscore=1015 impostorscore=0 suspectscore=0
 priorityscore=1501 lowpriorityscore=0 malwarescore=0 adultscore=0 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2602130000 definitions=main-2603100090
Received-SPF: pass client-ip=148.163.158.5;
 envelope-from=sourabhjain@linux.ibm.com; helo=mx0b-001b2d01.pphosted.com
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



On 09/03/26 12:49, Aditya Gupta wrote:
> Logic for preserving the CPU registers and memory regions has been done
> in previous patches.
>
> Write those data at the relevant memory address, such as PROC_DUMP_AREA
> for CPU registers, and MDRT for preserved memory regions.
>
> Also export "mpipl-boot" device tree node, for kernel to know that it's
> a 'dump active' boot
>
> Reviewed-by: Hari Bathini <hbathini@linux.ibm.com>
> Signed-off-by: Aditya Gupta <adityag@linux.ibm.com>
> ---
>   hw/ppc/pnv.c         |  45 +++++++++++++-
>   hw/ppc/pnv_mpipl.c   | 140 +++++++++++++++++++++++++++++++++++++++++++
>   include/hw/ppc/pnv.h |   1 +
>   3 files changed, 185 insertions(+), 1 deletion(-)
>
> diff --git a/hw/ppc/pnv.c b/hw/ppc/pnv.c
> index 3038b1626c54..0b94e0c7a19b 100644
> --- a/hw/ppc/pnv.c
> +++ b/hw/ppc/pnv.c
> @@ -751,6 +751,8 @@ static void pnv_reset(MachineState *machine, ResetType type)
>       PnvMachineState *pnv = PNV_MACHINE(machine);
>       IPMIBmc *bmc;
>       void *fdt;
> +    int node_offset;
> +    bool is_next_boot_mpipl = false;
>   
>       qemu_devices_reset(type);
>   
> @@ -781,7 +783,48 @@ static void pnv_reset(MachineState *machine, ResetType type)
>           _FDT((fdt_pack(fdt)));
>       }
>   
> -    if (!pnv->mpipl_state.is_next_boot_mpipl) {
> +    /*
> +     * Only on success of writing MPIPL data will the next boot be provided
> +     * "mpipl-boot" property in device tree
> +     * Otherwise boot like a normal non-MPIPL boot
> +     */
> +    if (pnv->mpipl_state.is_next_boot_mpipl) {
> +        /* Write the preserved MDRT and CPU State Data */
> +        bool mpipl_write_succeeded = do_mpipl_write(pnv);

do_mpipl_write returns bool and mpipl_write_succeeded is of type boot yet
is_next_boot_mpipl is assigned under if-else condition. Is it really needed?

> +
> +        if (!mpipl_write_succeeded) {
> +            is_next_boot_mpipl = false;
> +        } else {
> +            is_next_boot_mpipl = true;
> +        }
> +    }
> +
> +    /*
> +     * If it's a MPIPL boot, add the "mpipl-boot" property, and reset the
> +     * boolean for MPIPL boot for next boot
> +     */
> +    if (is_next_boot_mpipl) {
> +        void *fdt_copy = g_malloc0(FDT_MAX_SIZE);
> +
> +        /* Create a writable copy of the fdt */
> +        _FDT((fdt_open_into(fdt, fdt_copy, FDT_MAX_SIZE)));
> +
> +        node_offset = fdt_path_offset(fdt_copy, "/ibm,opal/dump");
> +        _FDT((fdt_appendprop_u64(fdt_copy, node_offset, "mpipl-boot", 1)));

What if node_offset is not valid? What is expected here?

> +
> +        /* Update the fdt, and free the original fdt */
> +        if (fdt != machine->fdt) {
> +            /*
> +             * Only free the fdt if it's not machine->fdt, to prevent
> +             * double free, since we already free machine->fdt later
> +             */
> +            g_free(fdt);
> +        }
> +        fdt = fdt_copy;
> +
> +        /* This boot is an MPIPL, reset the boolean for next boot */
> +        pnv->mpipl_state.is_next_boot_mpipl = false;
> +    } else {
>           /*
>            * Set the "Thread Register State Entry Size", so that firmware can
>            * allocate enough memory to capture CPU state in the event of a
> diff --git a/hw/ppc/pnv_mpipl.c b/hw/ppc/pnv_mpipl.c
> index 37f498051254..2cf54a8ec306 100644
> --- a/hw/ppc/pnv_mpipl.c
> +++ b/hw/ppc/pnv_mpipl.c
> @@ -20,6 +20,8 @@
>       (pnv->mpipl_state.skiboot_base + MDST_TABLE_OFF)
>   #define MDDT_TABLE_RELOCATED                            \
>       (pnv->mpipl_state.skiboot_base + MDDT_TABLE_OFF)
> +#define MDRT_TABLE_RELOCATED                            \
> +    (pnv->mpipl_state.skiboot_base + MDRT_TABLE_OFF)
>   #define PROC_DUMP_RELOCATED                             \
>       (pnv->mpipl_state.skiboot_base + PROC_DUMP_AREA_OFF)
>   
> @@ -319,6 +321,139 @@ static bool pnv_mpipl_preserve_cpu_state(PnvMachineState *pnv)
>       return true;
>   }
>   
> +/*
> + * Write the preserved CPU state data in Processor Dump Area (PROC_DUMP_AREA)
> + *
> + * Returns true if everything went fine, else false for any error
> + */
> +static bool pnv_mpipl_write_cpu_state(PnvMachineState *pnv)
> +{
> +    MpiplProcDumpArea *proc_area = &pnv->mpipl_state.proc_area;
> +    MpiplPreservedCPUState *cpu_state = pnv->mpipl_state.cpu_states;
> +    const uint32_t num_cpu_states = pnv->mpipl_state.num_cpu_states;
> +    hwaddr next_regentries_hdr;
> +    AddressSpace *default_as = &address_space_memory;
> +    MemTxResult io_result;
> +    MemTxAttrs attrs;
> +
> +    /* Mark the memory transactions as privileged memory access */
> +    attrs.user = 0;
> +    attrs.memory = 1;
> +
> +    if (be32_to_cpu(proc_area->alloc_size) <
> +       (num_cpu_states * sizeof(MpiplPreservedCPUState))) {
> +        qemu_log_mask(LOG_GUEST_ERROR,
> +            "MPIPL: Size of buffer allocate by skiboot (%u bytes) is not"
> +            "enough to save all CPUs registers needed (%zu bytes)",
> +            be32_to_cpu(proc_area->alloc_size),
> +            num_cpu_states * sizeof(MpiplPreservedCPUState));
> +
> +        return false;
> +    }
> +
> +    proc_area->version = PROC_DUMP_AREA_VERSION_P9;
> +
> +    /*
> +     * This is the stride kernel/firmware should use to jump from a
> +     * register entries header to next CPU's header
> +     */
> +    proc_area->thread_size = cpu_to_be32(sizeof(MpiplPreservedCPUState));
> +
> +    /* Write the header and register entries for each CPU */
> +    next_regentries_hdr = be64_to_cpu(proc_area->alloc_addr) & (~HRMOR_BIT);
> +    for (int i = 0; i < num_cpu_states; ++i) {
> +        io_result = address_space_write(default_as, next_regentries_hdr, attrs,
> +            &cpu_state->hdr, sizeof(MpiplRegDataHdr));
> +        if (io_result != MEMTX_OK) {
> +            qemu_log_mask(LOG_GUEST_ERROR,
> +                "MPIPL: Failed to write RegEntries Header\n");
> +            return false;
> +        }
> +
> +        io_result = address_space_write(default_as,
> +            next_regentries_hdr + sizeof(MpiplRegDataHdr), attrs,
> +            &cpu_state->reg_entries,
> +            NUM_REGS_PER_CPU * (sizeof(MpiplRegEntry)));
> +        if (io_result != MEMTX_OK) {
> +            qemu_log_mask(LOG_GUEST_ERROR,
> +                "MPIPL: Failed to write Register Entries\n");
> +            return false;
> +        }
> +
> +        /*
> +         * According to HDAT section:
> +         *  "15.3.1.5 Architected Register Data content":
> +         *
> +         * The next register entries header will be at current header +
> +         * "Thread Register State Entry size"
> +         *
> +         * Note: proc_area.thread_size == sizeof(MpiplPreservedCPUState)
> +         */
> +        next_regentries_hdr += sizeof(MpiplPreservedCPUState);
> +        ++cpu_state;
> +    }
> +
> +    /* Point the destination address to the preserved memory region */
> +    proc_area->dest_addr = proc_area->alloc_addr;
> +    proc_area->act_size  = cpu_to_be32(num_cpu_states *
> +            sizeof(MpiplPreservedCPUState));
> +
> +    io_result = address_space_write(default_as, PROC_DUMP_AREA_OFF, attrs,
> +        proc_area, sizeof(MpiplProcDumpArea));
> +    if (io_result != MEMTX_OK) {
> +        qemu_log_mask(LOG_GUEST_ERROR,
> +            "MPIPL: Failed to write Register Entries\n");
> +        return false;
> +    }
> +
> +    return true;
> +}
> +
> +/*
> + * Write the preserved MDRT table, representing preserved memory regions
> + *
> + * Returns true if everything went fine, else false for any error
> + */
> +static bool pnv_mpipl_write_mdrt(PnvMachineState *pnv)
> +{
> +    MpiplPreservedState *state = &pnv->mpipl_state;
> +    AddressSpace *default_as = &address_space_memory;
> +    MemTxResult io_result;
> +    MemTxAttrs attrs;
> +
> +    /* Mark the memory transactions as privileged memory access */
> +    attrs.user = 0;
> +    attrs.memory = 1;
> +
> +    /*
> +     * Generally writes from platform during MPIPL don't go to a relocated
> +     * skiboot address
> +     *
> +     * Though for MDRT we are doing so, as this is the address skiboot
> +     * considers by default for MDRT
> +     *
> +     * MDRT/MDST/MDDT base addresses are actually meant to be shared by
> +     * platform in SPIRA structures.
> +     *
> +     * Not implementing SPIRA as it increases complexity for no gains.
> +     * Using the default address skiboot expects for MDRT, which is the
> +     * relocated MDRT, hence writing to it
> +     *
> +     * Other tables like MDST/MDDT should not be written to relocated
> +     * addresses, as skiboot will overwrite anything from SKIBOOT_BASE till
> +     * SKIBOOT_BASE+SKIBOOT_SIZE (which is 0x30000000-0x31c00000 by default)
> +     */
> +    io_result = address_space_write(default_as, MDRT_TABLE_RELOCATED, attrs,
> +            state->mdrt_table,
> +            state->num_mdrt_entries * sizeof(MdrtTableEntry));
> +    if (io_result != MEMTX_OK) {
> +        qemu_log_mask(LOG_GUEST_ERROR, "MPIPL: Failed to write MDRT table\n");
> +        return false;
> +    }
> +
> +    return true;
> +}
> +
>   void do_mpipl_preserve(PnvMachineState *pnv)
>   {
>       pause_all_vcpus();
> @@ -339,3 +474,8 @@ void do_mpipl_preserve(PnvMachineState *pnv)
>        */
>       qemu_system_reset_request(SHUTDOWN_CAUSE_GUEST_RESET);
>   }
> +
> +bool do_mpipl_write(PnvMachineState *pnv)
> +{
> +    return pnv_mpipl_write_mdrt(pnv) && pnv_mpipl_write_cpu_state(pnv);
> +}
> diff --git a/include/hw/ppc/pnv.h b/include/hw/ppc/pnv.h
> index 7d73629f112a..98fe10fb4f2e 100644
> --- a/include/hw/ppc/pnv.h
> +++ b/include/hw/ppc/pnv.h
> @@ -295,5 +295,6 @@ void pnv_bmc_set_pnor(IPMIBmc *bmc, PnvPnor *pnor);
>   
>   /* MPIPL helpers */
>   void do_mpipl_preserve(PnvMachineState *pnv);
> +bool do_mpipl_write(PnvMachineState *pnv);
>   
>   #endif /* PPC_PNV_H */


