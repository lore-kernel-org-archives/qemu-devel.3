Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D75C8CD3427
	for <qemu-devel@archiver.kernel.org>; Thu,  7 May 2026 08:55:31 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wKuVX-0005Q4-RZ; Thu, 07 May 2026 04:54:59 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <sourabhjain@linux.ibm.com>)
 id 1wKuVM-0005OK-BW; Thu, 07 May 2026 04:54:49 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <sourabhjain@linux.ibm.com>)
 id 1wKuVI-0000ho-FL; Thu, 07 May 2026 04:54:47 -0400
Received: from pps.filterd (m0353725.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 64703ZMD3486157; Thu, 7 May 2026 08:54:40 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=pp1; bh=QnhkwK
 OgazJAMNjLoI38VworoBI22GyH5rbJuwTqngM=; b=BaKcSoZST9qawY8uXmmWzN
 OZCorRS/xjESAwCnqQUPHgKpIruRtQpORs/bOkMr5kmj8HIB5R5SKU4Hd1n/ZEiN
 FT/8qntvTpniuX44vYdyqw6g415862iFfglt1bO9oplCOuMQO1HqmkAIGQJm3xn3
 YW9JG+LjD9C3HSjCZzfCg/TQvtv1q3UbDQflktfK5XAmJnQUIpkp5aMyRIlbDPmh
 hEE1V5IapQ8JiSNNlBFoqr8vmu193AOaAzVpnF68b1vzv8uW9ZKXnn+S+IxlURAz
 X6OFAa2lT7xx1Jf/nITqnKAmvg4Dm2J8M/kspPK2bWYUIVgokvtFBgqPqH6eN07A
 ==
Received: from ppma11.dal12v.mail.ibm.com
 (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4dw9xxv5jd-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 07 May 2026 08:54:39 +0000 (GMT)
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
 by ppma11.dal12v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 6478sSO8004572;
 Thu, 7 May 2026 08:54:38 GMT
Received: from smtprelay07.fra02v.mail.ibm.com ([9.218.2.229])
 by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 4dwx9yj1c5-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 07 May 2026 08:54:38 +0000 (GMT)
Received: from smtpav06.fra02v.mail.ibm.com (smtpav06.fra02v.mail.ibm.com
 [10.20.54.105])
 by smtprelay07.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 6478sXST48693728
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Thu, 7 May 2026 08:54:34 GMT
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id F04EC2004D;
 Thu,  7 May 2026 08:54:32 +0000 (GMT)
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 7F27420040;
 Thu,  7 May 2026 08:54:30 +0000 (GMT)
Received: from [9.39.23.70] (unknown [9.39.23.70])
 by smtpav06.fra02v.mail.ibm.com (Postfix) with ESMTP;
 Thu,  7 May 2026 08:54:30 +0000 (GMT)
Message-ID: <7e00f36d-f38d-4532-a763-cc4025a303d3@linux.ibm.com>
Date: Thu, 7 May 2026 14:24:28 +0530
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] ppc/spapr: make fadump collect regs for maxcpus
To: Shivang Upadhyay <shivangu@linux.ibm.com>, qemu-ppc@nongnu.org,
 qemu-devel@nongnu.org
Cc: Aditya Gupta <adityag@linux.ibm.com>,
 Mahesh J Salgaonkar <mahesh@linux.ibm.com>,
 Harsh Prateek Bora <harshpb@linux.ibm.com>,
 Anushree Mathur <anushree.mathur@linux.vnet.ibm.com>
References: <20260429065127.366813-1-shivangu@linux.ibm.com>
Content-Language: en-US
From: Sourabh Jain <sourabhjain@linux.ibm.com>
In-Reply-To: <20260429065127.366813-1-shivangu@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTA3MDA4NCBTYWx0ZWRfXw1fHJMHs0z4h
 /BKoRav2dgLwPJsd+r5I1G8+1KmbwmeFK/WpICwxEHwbyEn3G8QgG7W157jjQeNWlOL9yv64fBV
 +uyVsUikUvg4gETWHZ+vqCZSYtHttJ+ZdMfsWyCxDExsE6AuhItidoKMdW+j7qTmMNccvMcJtWv
 /5c2jEW+MWLIdkTVqAMDLgKjm0mFSz6MD3jn5mOVjb8M47HUQfTb9xfCSENaJRK8QuXgmbT4aJe
 YsJ+MLmJz3WRCJSqjMC9JLlAnfHY1obeyYOuRGM3pgYusZrnQmPwwCZYguduzCM4DfVndfzHnE/
 amsI2ZfxOqmGGPjnIUJNNieKdZddGARlE16NlV/ABz4/RE0tMpSQ8avqwVtyesuqSMHpWg5ieHV
 ZbtOvP1BAyF9ENjFNj+Dr95EAPDllrej076MLznxD9Eb2TR+R3pf+JHn9DaZZ9uS57Dv/ZkK2Vg
 g3Mgws9iNx3ceFWvQ2A==
X-Proofpoint-ORIG-GUID: mlXoEtdXtqEz4fq6Pup9qfeBxNViulM8
X-Proofpoint-GUID: mlXoEtdXtqEz4fq6Pup9qfeBxNViulM8
X-Authority-Analysis: v=2.4 cv=ctWrVV4i c=1 sm=1 tr=0 ts=69fc534f cx=c_pps
 a=aDMHemPKRhS1OARIsFnwRA==:117 a=aDMHemPKRhS1OARIsFnwRA==:17
 a=IkcTkHD0fZMA:10 a=NGcC8JguVDcA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=V8glGbnc2Ofi9Qvn3v5h:22 a=VnNF1IyMAAAA:8
 a=VT-HELRw552j8u3lF-8A:9 a=QEXdDO2ut3YA:10
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-05-06_02,2026-05-06_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 lowpriorityscore=0 adultscore=0 clxscore=1011
 suspectscore=0 impostorscore=0 spamscore=0 malwarescore=0 phishscore=0
 bulkscore=0 classifier=typeunknown authscore=0 authtc= authcc= route=outbound
 adjust=0 reason=mlx scancount=1 engine=8.22.0-2604200000
 definitions=main-2605070084
Received-SPF: pass client-ip=148.163.158.5;
 envelope-from=sourabhjain@linux.ibm.com; helo=mx0b-001b2d01.pphosted.com
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



On 29/04/26 12:21, Shivang Upadhyay wrote:
> When a ppc machine is started with maxcpus greater than the number of
> present CPUs (e.g., -smp cpus=2,maxcpus=8), firmware allocates the CPU
> state data buffer based on maxcpus and advertises this size to the
> kernel during fadump registration.
>
> However, fadump currently fails to generate a vmcore during the
> rebooted kernel because:

It would be good if we can include the error log printed by the
kernel while processing the CPU state buffer in the commit message.
It may help others in the future.

The rest of the things look good to me.

Feel free to add:
Reviewed-by: Sourabh Jain <sourabhjain@linux.ibm.com>

- Sourabh Jain

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
>   hw/ppc/spapr_fadump.c | 57 +++++++++++++++++++++++++++++++++----------
>   1 file changed, 44 insertions(+), 13 deletions(-)
>
> diff --git a/hw/ppc/spapr_fadump.c b/hw/ppc/spapr_fadump.c
> index 13cab0cfe1..b1a21ff115 100644
> --- a/hw/ppc/spapr_fadump.c
> +++ b/hw/ppc/spapr_fadump.c
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
> @@ -450,7 +474,7 @@ static FadumpRegEntry *populate_cpu_reg_entries(CPUState *cpu,
>    * callers), and sets the size of this buffer in the argument
>    * 'cpu_state_len'
>    */
> -static void *get_cpu_state_data(uint64_t *cpu_state_len)
> +static void *get_cpu_state_data(uint64_t *cpu_state_len, MachineState *ms)
>   {
>       FadumpRegSaveAreaHeader reg_save_hdr;
>       g_autofree FadumpRegEntry *reg_entries = NULL;
> @@ -459,15 +483,11 @@ static void *get_cpu_state_data(uint64_t *cpu_state_len)
>   
>       uint32_t num_reg_entries;
>       uint32_t reg_entries_size;
> -    uint32_t num_cpus = 0;
> +    uint32_t num_cpus = ms->smp.max_cpus;
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
> @@ -484,10 +504,20 @@ static void *get_cpu_state_data(uint64_t *cpu_state_len)
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
> @@ -526,7 +556,7 @@ static void *get_cpu_state_data(uint64_t *cpu_state_len)
>    * such as invalid destination address or non-fatal error errors likely
>    * caused due to invalid parameters, return true and set region->error_flags
>    */
> -static bool do_populate_cpu_state(FadumpSection *region)
> +static bool do_populate_cpu_state(FadumpSection *region, MachineState *ms)
>   {
>       uint64_t dest_addr = be64_to_cpu(region->destination_address);
>       uint64_t cpu_state_len = 0;
> @@ -541,7 +571,7 @@ static bool do_populate_cpu_state(FadumpSection *region)
>       attrs.user = 0;
>       attrs.memory = 1;
>   
> -    cpu_state_buffer  = get_cpu_state_data(&cpu_state_len);
> +    cpu_state_buffer  = get_cpu_state_data(&cpu_state_len, ms);
>   
>       io_result = address_space_write(default_as, dest_addr, attrs,
>               cpu_state_buffer, cpu_state_len);
> @@ -597,6 +627,7 @@ static bool do_populate_cpu_state(FadumpSection *region)
>   static bool fadump_preserve_mem(SpaprMachineState *spapr)
>   {
>       FadumpMemStruct *fdm = &spapr->registered_fdm;
> +    MachineState *ms = MACHINE(spapr);
>       uint16_t dump_num_sections, data_type;
>   
>       assert(spapr->fadump_registered);
> @@ -627,7 +658,7 @@ static bool fadump_preserve_mem(SpaprMachineState *spapr)
>   
>           switch (data_type) {
>           case FADUMP_CPU_STATE_DATA:
> -            if (!do_populate_cpu_state(&fdm->rgn[i])) {
> +            if (!do_populate_cpu_state(&fdm->rgn[i], ms)) {
>                   qemu_log_mask(LOG_GUEST_ERROR,
>                       "FADump: Failed to store CPU State Data");
>                   fdm->header.dump_status_flag |=


