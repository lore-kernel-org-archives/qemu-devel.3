Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6E252CD8CB9
	for <qemu-devel@archiver.kernel.org>; Wed, 10 Jun 2026 16:52:33 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wXM9Z-0007As-LA; Wed, 10 Jun 2026 12:51:45 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <anushree.mathur@linux.ibm.com>)
 id 1wXM9Y-00079n-2d; Wed, 10 Jun 2026 12:51:44 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <anushree.mathur@linux.ibm.com>)
 id 1wXM9V-0003mc-Vn; Wed, 10 Jun 2026 12:51:43 -0400
Received: from pps.filterd (m0353729.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 65A3Si9M1596687; Wed, 10 Jun 2026 16:51:39 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=pp1; bh=mt1w6m
 tt6Ep1zBb3sVh9MSDaZP+VX3PCo3Xlz5urN5E=; b=N2rxngDDDF1iZzzFwk01BZ
 20VXWpOv63SsYs7FnAbXJjYyQ8oIt5rSyYcJ5I5vVv8C1ceFJJG7cjHIttpLmTW7
 3ANtdgk80E5IdakZkX3Mir/WaDbBvPXQx5Q0fdZCyV+DQmiyBMK9EMDi30M5P/e9
 xVgrKu301zwU9I07NCvNvPDdPltWucR/5/bkRaB/B2tQHVb9rlPPRIyN1RxU2l9Z
 pfvfVXgRiCCEV1wFwpIC+sENkOpI3f2EIXBUMEtDwuL+MUy2ghDUOTsoukbIUId/
 EkzOFG5+MC5aUzVM9MRBRHfzhdHmQGppOSkQd+y8oHK/PcpRkhoQnZm7u7NyNSpA
 ==
Received: from ppma22.wdc07v.mail.ibm.com
 (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4emb7qt4ck-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Wed, 10 Jun 2026 16:51:38 +0000 (GMT)
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
 by ppma22.wdc07v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 65AGnex9022275;
 Wed, 10 Jun 2026 16:51:37 GMT
Received: from smtprelay05.dal12v.mail.ibm.com ([172.16.1.7])
 by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4emx8w7mjm-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Wed, 10 Jun 2026 16:51:37 +0000 (GMT)
Received: from smtpav05.wdc07v.mail.ibm.com (smtpav05.wdc07v.mail.ibm.com
 [10.39.53.232])
 by smtprelay05.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 65AGpZDT23986714
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Wed, 10 Jun 2026 16:51:35 GMT
Received: from smtpav05.wdc07v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 4896158053;
 Wed, 10 Jun 2026 16:51:35 +0000 (GMT)
Received: from smtpav05.wdc07v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 132C258043;
 Wed, 10 Jun 2026 16:51:32 +0000 (GMT)
Received: from [9.61.247.186] (unknown [9.61.247.186])
 by smtpav05.wdc07v.mail.ibm.com (Postfix) with ESMTP;
 Wed, 10 Jun 2026 16:51:31 +0000 (GMT)
Message-ID: <30eec232-336c-46a4-95a8-5da49a9b6288@linux.ibm.com>
Date: Wed, 10 Jun 2026 22:21:30 +0530
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] ppc/spapr: make fadump collect regs for maxcpus
To: Shivang Upadhyay <shivangu@linux.ibm.com>, qemu-devel@nongnu.org,
 qemu-ppc@nongnu.org
Cc: adityag@linux.ibm.com, anushree.mathur@linux.vnet.ibm.com,
 harshpb@linux.ibm.com, mahesh@linux.ibm.com, sourabhjain@linux.ibm.com
References: <20260429065127.366813-1-shivangu@linux.ibm.com>
 <20260520092857.1079193-1-shivangu@linux.ibm.com>
Content-Language: en-US
From: Anushree Mathur <anushree.mathur@linux.ibm.com>
In-Reply-To: <20260520092857.1079193-1-shivangu@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Authority-Analysis: v=2.4 cv=HppG3UTS c=1 sm=1 tr=0 ts=6a29961a cx=c_pps
 a=5BHTudwdYE3Te8bg5FgnPg==:117 a=5BHTudwdYE3Te8bg5FgnPg==:17
 a=IkcTkHD0fZMA:10 a=FelO9ux0wxsA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=uAbxVGIbfxUO_5tXvNgY:22 a=VwQbUJbxAAAA:8
 a=VnNF1IyMAAAA:8 a=LN4uOt-VkPGlo72ylhkA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-GUID: eJZCdLCS4-gM_l2oQ_vVmM4fhPnG7-fF
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjEwMDE1NiBTYWx0ZWRfX1hkXXEwmr0ob
 YdTXt9hQ5+NZbRAXG8JSaUPUVLL0ZeFQKNmQceWjj2sRa6+/XEVaoat+6XcehuLrN1c2Qi3UzNV
 h3gOhX6PkvSnqTBK4chzGzzh0GFffNhlP2N4QpoNAqC04L+f4Q94LEjDba8uZf4OBPh3AE9RJyw
 f49eWPJXMcwaBTw+Pc6AoDmakFV+XKnNlTNJz2lN4bPj6DKXuv03vWD3qK5ulrz/7MN+nvEN9C7
 ZMqnveIEvmYPta27A/yq2QCz5fqL6L0dYycun1y3vZEBfReQ68jNs0uVE8DtVHKg7+c7cYboBSl
 XNAEatNkvQEJOOFEtKSEyBQdi9pYknrjsv0HEFfBGlyfa8H2XaA4PQ+m5BsgHWTRkcz2cpgIUnu
 zG35jSyJF4l1RodHpofB8jlmTFxt4xUlMi1+mDi9hnDhnw1d+ni46PVvdxR0YK54C+VQWj84HxJ
 lWQ77QW+gvC6fkbXkfw==
X-Proofpoint-ORIG-GUID: eJZCdLCS4-gM_l2oQ_vVmM4fhPnG7-fF
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-10_03,2026-06-09_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 adultscore=0 phishscore=0 malwarescore=0 impostorscore=0
 priorityscore=1501 clxscore=1015 bulkscore=0 spamscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2605210000 definitions=main-2606100156
Received-SPF: pass client-ip=148.163.156.1;
 envelope-from=anushree.mathur@linux.ibm.com; helo=mx0a-001b2d01.pphosted.com
X-Spam_score_int: -26
X-Spam_score: -2.7
X-Spam_bar: --
X-Spam_report: (-2.7 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, RCVD_IN_DNSWL_LOW=-0.7,
 RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001, SPF_HELO_NONE=0.001,
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

Hi Shivang,

I have tested this patch again for different smt values as 1/2/4/8 and 
this patch is working totally fine for all the scenarios now! Now it is 
not failing as I mentioned earlier 
https://lore.kernel.org/qemu-devel/baf613df-3139-48e0-9311-11d5f1bcc28f@linux.ibm.com/

Thanks for working on the issue again.

Please feel free to add:

Tested-by: Anushree Mathur <anushree.mathur@linux.ibm.com>


Previously it was working only with thread value as 1 and failing for 
other smt values as mentioned here 
https://lore.kernel.org/qemu-devel/baf613df-3139-48e0-9311-11d5f1bcc28f@linux.ibm.com/


On 20/05/26 2:58 PM, Shivang Upadhyay wrote:
> When a ppc machine is started with maxcpus greater than the number of
> present CPUs (e.g., -smp cpus=2,maxcpus=8), firmware allocates the CPU
> state data buffer based on maxcpus and advertises this size to the
> kernel during fadump registration.
>
> However, fadump currently fails to generate a vmcore during the
> rebooted kernel because:
>
> 1. The CPU state buffer length does not match what firmware advertised
>     (QEMU only populates entries for present CPUs, not maxcpus)
> 2. The kernel cannot find CPU data for all maxcpus slots
>
> This patch adds placeholder entries for the unrealized cpus.
> The placeholder entries contain only the CPUSTRT and CPUEND markers
> with the CPU ID, which is sufficient for the kernel to recognize the
> CPU slot exists even though the CPU was never realized.
>
> This ensures the CPU state buffer size and structure matches what
> firmware advertised to the kernel, allowing fadump to successfully
> generate vmcore.
>
> Cc: Aditya Gupta <adityag@linux.ibm.com>
> Cc: Sourabh Jain <sourabhjain@linux.ibm.com>
> Cc: Mahesh J Salgaonkar <mahesh@linux.ibm.com>
> Cc: Harsh Prateek Bora <harshpb@linux.ibm.com>
> Reported-by: Anushree Mathur <anushree.mathur@linux.vnet.ibm.com>
> Signed-off-by: Shivang Upadhyay <shivangu@linux.ibm.com>
> ---
>
> Changelog:
> V2:
>   * change reservation size from maxcpus to possible_cpu_arch_ids. (Thanks Anushree for test case).
>   * added a small change regarding interger ceil calculation.
>
> V1:
>   * link: https://lore.kernel.org/all/20260429065127.366813-1-shivangu@linux.ibm.com/
>
> ---
>   hw/ppc/spapr_fadump.c | 60 +++++++++++++++++++++++++++++++++----------
>   1 file changed, 46 insertions(+), 14 deletions(-)
>
> diff --git a/hw/ppc/spapr_fadump.c b/hw/ppc/spapr_fadump.c
> index 13cab0cfe1..77339129ed 100644
> --- a/hw/ppc/spapr_fadump.c
> +++ b/hw/ppc/spapr_fadump.c
> @@ -237,7 +237,7 @@ static bool do_preserve_region(FadumpSection *region)
>           return false;
>       }
>   
> -    num_chunks = ceil((src_len * 1.0f) / FADUMP_CHUNK_SIZE);
> +    num_chunks = ((src_len + FADUMP_CHUNK_SIZE - 1) / FADUMP_CHUNK_SIZE);
>       for (uint64_t chunk_id = 0; chunk_id < num_chunks; ++chunk_id) {
>           /* Take minimum of bytes left to copy, and chunk size */
>           uint64_t copy_len = MIN(
> @@ -309,6 +309,30 @@ static bool do_preserve_region(FadumpSection *region)
>       return true;
>   }
>   
> +/*
> + * Populate placeholder register entries for an unrealized CPU
> + *
> + * For CPUs that are not realized (cpu_index < maxcpus), we need to
> + * create minimal register entries containing only CPUSTRT and CPUEND
> + * markers to maintain the expected buffer structure.
> + *
> + * Returns pointer just past the placeholder entries, which can be used
> + * as the start address for the next CPU's register entries
> + */
> +static FadumpRegEntry *populate_cpu_reg_entries_placeholder(int cpu_id,
> +                                                             FadumpRegEntry *curr_reg_entry)
> +{
> +    curr_reg_entry->reg_id = cpu_to_be64(fadump_str_to_u64("CPUSTRT"));
> +    curr_reg_entry->reg_value = cpu_to_be64(cpu_id & FADUMP_CPU_ID_MASK);
> +    ++curr_reg_entry;
> +
> +    curr_reg_entry->reg_id = cpu_to_be64(fadump_str_to_u64("CPUEND"));
> +    curr_reg_entry->reg_value = cpu_to_be64(cpu_id & FADUMP_CPU_ID_MASK);
> +    ++curr_reg_entry;
> +
> +    return curr_reg_entry;
> +}
> +
>   /*
>    * Populate the passed CPUs register entries, in the buffer starting at
>    * the argument 'curr_reg_entry'
> @@ -450,24 +474,21 @@ static FadumpRegEntry *populate_cpu_reg_entries(CPUState *cpu,
>    * callers), and sets the size of this buffer in the argument
>    * 'cpu_state_len'
>    */
> -static void *get_cpu_state_data(uint64_t *cpu_state_len)
> +static void *get_cpu_state_data(uint64_t *cpu_state_len, MachineState *ms)
>   {
>       FadumpRegSaveAreaHeader reg_save_hdr;
>       g_autofree FadumpRegEntry *reg_entries = NULL;
>       FadumpRegEntry *curr_reg_entry;
>       CPUState *cpu;
> +    MachineClass *mc = MACHINE_GET_CLASS(ms);
>   
>       uint32_t num_reg_entries;
>       uint32_t reg_entries_size;
> -    uint32_t num_cpus = 0;
> +    uint32_t num_cpus = mc->possible_cpu_arch_ids(ms)->len;
>   
>       void *cpu_state_buffer = NULL;
>       uint64_t offset = 0;
>   
> -    CPU_FOREACH(cpu) {
> -        ++num_cpus;
> -    }
> -
>       reg_save_hdr.version = cpu_to_be32(0);
>       reg_save_hdr.magic_number =
>           cpu_to_be64(fadump_str_to_u64("REGSAVE"));
> @@ -484,10 +505,20 @@ static void *get_cpu_state_data(uint64_t *cpu_state_len)
>       /* Pointer to current CPU's registers */
>       curr_reg_entry = reg_entries;
>   
> -    /* Populate register entries for all CPUs */
> -    CPU_FOREACH(cpu) {
> -        cpu_synchronize_state(cpu);
> -        curr_reg_entry = populate_cpu_reg_entries(cpu, curr_reg_entry);
> +    /*
> +     * Populate register entries for all CPU slots (0 to maxcpus-1)
> +     */
> +    for (int i = 0; i < num_cpus; i++) {
> +        cpu = qemu_get_cpu(i);
> +        if (cpu) {
> +            /* CPU is realized - populate full register entries */
> +            cpu_synchronize_state(cpu);
> +            curr_reg_entry = populate_cpu_reg_entries(cpu, curr_reg_entry);
> +        } else {
> +            /* CPU slot is empty - populate placeholder entries */
> +            curr_reg_entry = populate_cpu_reg_entries_placeholder(i,
> +                                                                   curr_reg_entry);
> +        }
>       }
>   
>       *cpu_state_len = 0;
> @@ -526,7 +557,7 @@ static void *get_cpu_state_data(uint64_t *cpu_state_len)
>    * such as invalid destination address or non-fatal error errors likely
>    * caused due to invalid parameters, return true and set region->error_flags
>    */
> -static bool do_populate_cpu_state(FadumpSection *region)
> +static bool do_populate_cpu_state(FadumpSection *region, MachineState *ms)
>   {
>       uint64_t dest_addr = be64_to_cpu(region->destination_address);
>       uint64_t cpu_state_len = 0;
> @@ -541,7 +572,7 @@ static bool do_populate_cpu_state(FadumpSection *region)
>       attrs.user = 0;
>       attrs.memory = 1;
>   
> -    cpu_state_buffer  = get_cpu_state_data(&cpu_state_len);
> +    cpu_state_buffer  = get_cpu_state_data(&cpu_state_len, ms);
>   
>       io_result = address_space_write(default_as, dest_addr, attrs,
>               cpu_state_buffer, cpu_state_len);
> @@ -597,6 +628,7 @@ static bool do_populate_cpu_state(FadumpSection *region)
>   static bool fadump_preserve_mem(SpaprMachineState *spapr)
>   {
>       FadumpMemStruct *fdm = &spapr->registered_fdm;
> +    MachineState *ms = MACHINE(spapr);
>       uint16_t dump_num_sections, data_type;
>   
>       assert(spapr->fadump_registered);
> @@ -627,7 +659,7 @@ static bool fadump_preserve_mem(SpaprMachineState *spapr)
>   
>           switch (data_type) {
>           case FADUMP_CPU_STATE_DATA:
> -            if (!do_populate_cpu_state(&fdm->rgn[i])) {
> +            if (!do_populate_cpu_state(&fdm->rgn[i], ms)) {
>                   qemu_log_mask(LOG_GUEST_ERROR,
>                       "FADump: Failed to store CPU State Data");
>                   fdm->header.dump_status_flag |=


