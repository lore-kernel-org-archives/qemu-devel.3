Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 50021F01827
	for <qemu-devel@archiver.kernel.org>; Fri,  6 Mar 2026 10:53:20 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vySo1-0006gv-T4; Fri, 06 Mar 2026 05:53:17 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <hbathini@linux.ibm.com>)
 id 1vySnu-0006ef-3W; Fri, 06 Mar 2026 05:53:10 -0500
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <hbathini@linux.ibm.com>)
 id 1vySnr-0008MD-9j; Fri, 06 Mar 2026 05:53:08 -0500
Received: from pps.filterd (m0360072.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 6264OjQe1528090; Fri, 6 Mar 2026 10:53:06 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=pp1; bh=3ICnYf
 U5ozG0J8GiAIefUELUqOrkIQ9au71ROCMmxxA=; b=pN9jffH/NOoFg7A8GQC3LF
 +0RjnLy00HJeyUZv7nPeL6opaYtGNkiVKlm+NkvM4ASeZND7JgNxDBjMBL1J5Vly
 0VrlECJ7dADeyfp07/iaqnZ8iAVTAv3LM5cX6T80TNRqmd/xW4JezIU28V3s9v40
 c0zT+7B3WHJ2HDsW1A2hwEGPb3IpWvYvZauV2xU5KPYBpHpa0sc79z36eFTNJw0n
 wYiKWOldmdgTwUMu5dYfDebytWlJOZjmJVWG8xCiUqBNhfBngRvH936tIyucmMoX
 MaMNkJzRT92HOqxbRkSRzASYF2gMzXZuwmkh9JJJkuqzr/hAgkVNKjm/2N0YLqYQ
 ==
Received: from ppma13.dal12v.mail.ibm.com
 (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4ckssmyjwr-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Fri, 06 Mar 2026 10:53:05 +0000 (GMT)
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
 by ppma13.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 626ApmTq027733;
 Fri, 6 Mar 2026 10:53:04 GMT
Received: from smtprelay06.fra02v.mail.ibm.com ([9.218.2.230])
 by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 4cmcwjq77x-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Fri, 06 Mar 2026 10:53:04 +0000
Received: from smtpav01.fra02v.mail.ibm.com (smtpav01.fra02v.mail.ibm.com
 [10.20.54.100])
 by smtprelay06.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 626Ar1wU29819148
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Fri, 6 Mar 2026 10:53:01 GMT
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 170CD20040;
 Fri,  6 Mar 2026 10:53:01 +0000 (GMT)
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 7880220063;
 Fri,  6 Mar 2026 10:52:59 +0000 (GMT)
Received: from [9.78.106.17] (unknown [9.78.106.17])
 by smtpav01.fra02v.mail.ibm.com (Postfix) with ESMTP;
 Fri,  6 Mar 2026 10:52:59 +0000 (GMT)
Message-ID: <ff24299d-d95b-4376-8b75-84cb7269bf62@linux.ibm.com>
Date: Fri, 6 Mar 2026 16:22:58 +0530
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 07/10] pnv/mpipl: Write the preserved CPU and MDRT state
To: Aditya Gupta <adityag@linux.ibm.com>, qemu-devel@nongnu.org
Cc: qemu-ppc@nongnu.org, Sourabh Jain <sourabhjain@linux.ibm.com>,
 Harsh Prateek Bora <harshpb@linux.ibm.com>,
 Nicholas Piggin <npiggin@gmail.com>,
 Miles Glenn <milesg@linux.ibm.com>, Chinmay Rath <rathc@linux.ibm.com>,
 Shivang Upadhyay <shivangu@linux.ibm.com>
References: <20260225124633.1841222-1-adityag@linux.ibm.com>
 <20260225124633.1841222-8-adityag@linux.ibm.com>
Content-Language: en-US
From: Hari Bathini <hbathini@linux.ibm.com>
In-Reply-To: <20260225124633.1841222-8-adityag@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzA2MDEwMSBTYWx0ZWRfX+DP72Osuotii
 dTbs3Qk5AM/5nBiWKkBU4HlO0jylRcC0N2OZ5b5loFwROOp+9PPWLYn591ju9lP6Ml7qMoT05Pm
 nnk37B0V/zv54TsY7Gs1XB73D3+hT8CUxdQURgh0ZLBhTqazSlULjJO5jYMx9mCzVtoSGDSrhZk
 kRY+FEseh0B+nHKFcxk7U8V6I8cCmTyf+v1v43FedCIgcXu27H4RmiH0LlNFulE6iLKpPxlT6H5
 QoP+hPvs/8Mt2FC3RIKxXBbG6Oup8myTcTdRlNujWEVTrbs+f1KSp5RX9vENFdU5DcL828EYbbm
 sLCid5IuBv6tH/r4FZQIhLIM5pn3YxGK4euI6wkVtew/E8SvWMbW7GPo934NWO8BSUNPd1e9c2I
 vUvkHjZgrxPKD874GGPtmUcxjTwEc+pxE43kM84Sd4gxJu5nZTyTZ/ssj7S807lZzu2XJMbKuld
 MLFUAcXCaJkj5U5wtMw==
X-Proofpoint-ORIG-GUID: fdzs2_WeSp2xENNvoNTDx4ImjklGs7Sc
X-Proofpoint-GUID: tI1ItnGrfOM3fD5l1Shr2hBL_kxMfg7S
X-Authority-Analysis: v=2.4 cv=AobjHe9P c=1 sm=1 tr=0 ts=69aab212 cx=c_pps
 a=AfN7/Ok6k8XGzOShvHwTGQ==:117 a=AfN7/Ok6k8XGzOShvHwTGQ==:17
 a=IkcTkHD0fZMA:10 a=Yq5XynenixoA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=RzCfie-kr_QcCd8fBx8p:22 a=VnNF1IyMAAAA:8
 a=J9v9EyAk_XTl8f_c-twA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-03-06_03,2026-03-04_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 lowpriorityscore=0 bulkscore=0 impostorscore=0 malwarescore=0
 spamscore=0 clxscore=1015 suspectscore=0 adultscore=0 priorityscore=1501
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2602130000 definitions=main-2603060101
Received-SPF: pass client-ip=148.163.158.5;
 envelope-from=hbathini@linux.ibm.com; helo=mx0b-001b2d01.pphosted.com
X-Spam_score_int: -11
X-Spam_score: -1.2
X-Spam_bar: -
X-Spam_report: (-1.2 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, RCVD_IN_DNSWL_LOW=-0.7,
 RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.892, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.622,
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



On 25/02/26 6:16 pm, Aditya Gupta wrote:
> Logic for preserving the CPU registers and memory regions has been done
> in previous patches.
> 
> Write those data at the relevant memory address, such as PROC_DUMP_AREA
> for CPU registers, and MDRT for preserved memory regions.
> 
> Also export "mpipl-boot" device tree node, for kernel to know that it's
> a 'dump active' boot
> 
> Signed-off-by: Aditya Gupta <adityag@linux.ibm.com>
> ---
>   hw/ppc/pnv.c         |  45 +++++++++++++-
>   hw/ppc/pnv_mpipl.c   | 141 +++++++++++++++++++++++++++++++++++++++++++
>   include/hw/ppc/pnv.h |   1 +
>   3 files changed, 186 insertions(+), 1 deletion(-)
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
> index 37f498051254..d10ff5bc922d 100644
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
> @@ -339,3 +474,9 @@ void do_mpipl_preserve(PnvMachineState *pnv)
>        */
>       qemu_system_reset_request(SHUTDOWN_CAUSE_GUEST_RESET);
>   }
> +
> +bool do_mpipl_write(PnvMachineState *pnv)
> +{
> +    return pnv_mpipl_write_mdrt(pnv) && pnv_mpipl_write_cpu_state(pnv);
> +}

Another minor nit..

> +

blank line at EOF.


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


