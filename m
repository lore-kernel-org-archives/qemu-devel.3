Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AC963CD37AC
	for <qemu-devel@archiver.kernel.org>; Thu, 14 May 2026 18:36:27 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wNauR-0001Ja-Ss; Thu, 14 May 2026 14:35:47 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <anushree.mathur@linux.ibm.com>)
 id 1wNauO-0001JC-CN; Thu, 14 May 2026 14:35:44 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <anushree.mathur@linux.ibm.com>)
 id 1wNauL-0000dZ-NK; Thu, 14 May 2026 14:35:44 -0400
Received: from pps.filterd (m0353725.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 64E7nc3O3775960; Thu, 14 May 2026 18:35:38 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=pp1; bh=y5iupl
 K0ILfPrDSeZjiMBMkoUEKxIg08iyGSUXvf5C8=; b=YpLPnvIBemd2fKTsMEaVSl
 0AsgQxEmLu0IZdzLACquQbtVwnH3mKFMs15FRJitz7h1w4vZlygCsWgOmNEr6wR9
 nbqgDcJy8O4LyMXKDBPmItV/uFpndEfbvjLddSSoQOBP+hvHE4i05KbAq9gnIzQs
 4F1GvJdCDI82ucPO0cV+IwFUFCAj4uVtRhI5JEp0a/lCkpo3w3UHgBr+KwUOoofx
 EPeqrithUnHGb0FPWDuHaNlnsyc9GYr22ldA3u1AxVqK10pWA2fyX/pJueQcFbJz
 g1+3vgDTSPCjOcNVhBxjVr5abIwKIEWt8UomgI9kjrbnPASY461dG0Ohuys7+qng
 ==
Received: from ppma22.wdc07v.mail.ibm.com
 (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4e3nv6wabs-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 14 May 2026 18:35:38 +0000 (GMT)
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
 by ppma22.wdc07v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 64EIOdTh030163;
 Thu, 14 May 2026 18:35:37 GMT
Received: from smtprelay02.dal12v.mail.ibm.com ([172.16.1.4])
 by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4e3nfh5r13-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 14 May 2026 18:35:37 +0000 (GMT)
Received: from smtpav04.wdc07v.mail.ibm.com (smtpav04.wdc07v.mail.ibm.com
 [10.39.53.231])
 by smtprelay02.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 64EIZZ6p20251214
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Thu, 14 May 2026 18:35:36 GMT
Received: from smtpav04.wdc07v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id AA1ED58060;
 Thu, 14 May 2026 18:35:34 +0000 (GMT)
Received: from smtpav04.wdc07v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id B1FAC58050;
 Thu, 14 May 2026 18:35:31 +0000 (GMT)
Received: from [9.61.254.25] (unknown [9.61.254.25])
 by smtpav04.wdc07v.mail.ibm.com (Postfix) with ESMTP;
 Thu, 14 May 2026 18:35:31 +0000 (GMT)
Message-ID: <baf613df-3139-48e0-9311-11d5f1bcc28f@linux.ibm.com>
Date: Fri, 15 May 2026 00:05:29 +0530
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] ppc/spapr: make fadump collect regs for maxcpus
To: Shivang Upadhyay <shivangu@linux.ibm.com>, qemu-ppc@nongnu.org,
 qemu-devel@nongnu.org, Harsh Prateek Bora <harshpb@linux.ibm.com>
Cc: Aditya Gupta <adityag@linux.ibm.com>,
 Sourabh Jain <sourabhjain@linux.ibm.com>,
 Mahesh J Salgaonkar <mahesh@linux.ibm.com>,
 Harsh Prateek Bora <harshpb@linux.ibm.com>,
 Anushree Mathur <anushree.mathur@linux.vnet.ibm.com>
References: <20260429065127.366813-1-shivangu@linux.ibm.com>
Content-Language: en-US
From: Anushree Mathur <anushree.mathur@linux.ibm.com>
In-Reply-To: <20260429065127.366813-1-shivangu@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Authority-Analysis: v=2.4 cv=KbvidwYD c=1 sm=1 tr=0 ts=6a0615fa cx=c_pps
 a=5BHTudwdYE3Te8bg5FgnPg==:117 a=5BHTudwdYE3Te8bg5FgnPg==:17
 a=IkcTkHD0fZMA:10 a=NGcC8JguVDcA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=V8glGbnc2Ofi9Qvn3v5h:22 a=VnNF1IyMAAAA:8
 a=WfXqtFiRZ4o9JsUZ7OMA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTE0MDE4MSBTYWx0ZWRfX+m/CGEy0rmcf
 UrQdihnqirpaxuJw6wlQEnfxuc9VlizpqDza2ldfIPWKBEKnkinRXjgB6ed/I8Dgm2m3apBiMnn
 kvReIHVxKZ8mcbK5xy6OwUkP/p/UIPmLIuVzTIDQCZ0hRt3IP1YHhDnUbiCk2JiZPg4MHpSNuE7
 dk0D/Llx9fxFaVZ/wx4/hQPMRECH/ndUulJ2j96MM/J9RQ40Dxn/KuFZon/mByV5145khpA1lCE
 ROztW5RkApoE+PPUwgm0QWy32ijXpwvKYhH0Ey3X6uaGbbG0li+QkmC5ai8tu1sILgoJxw9Jrlx
 6C13Y3fEO6ViPLF4NG8St1qdsoHHLkGdYnbGhgHzvovRPOeJ/QBFSh0RWRd12lMewQnEmcSk4en
 hHHfX409UxPXxoYaRwFURdiNsYPsR70o7iN0Ntb3t4Hml6YUf9r+2N1LmyuLdamN5Cooj9E9W1I
 CkelS4E2yuDd5JUPdFA==
X-Proofpoint-GUID: 6L1LyWpwOoqOw6q17idHWc0scR9XX4qW
X-Proofpoint-ORIG-GUID: 6L1LyWpwOoqOw6q17idHWc0scR9XX4qW
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-05-14_04,2026-05-13_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 bulkscore=0 impostorscore=0 malwarescore=0
 lowpriorityscore=0 phishscore=0 spamscore=0 suspectscore=0 clxscore=1015
 adultscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2605050000
 definitions=main-2605140181
Received-SPF: pass client-ip=148.163.158.5;
 envelope-from=anushree.mathur@linux.ibm.com; helo=mx0b-001b2d01.pphosted.com
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



On 29/04/26 12:21 PM, Shivang Upadhyay wrote:
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


Hi Shivang,
Thanks for working on it, but patch is fixing the issue only for thread 
as 1 for guest topology but breaking for 2 or 4 or 8 as threads in guest.

Putting the details about the issue here.

As I reported when maxcpus tag is present, fadump is resulting
into multiple Kernel OOPS along with rtas error message "rtas fadump: 
Dump taken by platform is incomplete (0)".

Kernel OOPS are like following. Some kernel OOPS are for vmalloc memory, 
some are for cpu alloc etc in continuous loops and in the end guest crashed.

[    7.976103][  T775] BUG: Unable to handle kernel data access at 
0x629cb8ee54efc16f
[    7.976260][  T775] Faulting instruction address: 0xc000000000643e7c
[    7.976357][  T775] Oops: Kernel access of bad area, sig: 11 [#1]

[    7.978143][  T775] GPR28: 0000000000010000 629cb8ee54efc16f 
0000000000000008 c000000002e56a00
[    7.979257][  T775] NIP [c000000000643e7c] 
__kmalloc_node_noprof+0x21c/0x650
[    7.979402][  T775] LR [c000000000643e64] 
__kmalloc_node_noprof+0x204/0x650
[    7.979504][  T775] Call Trace:
[    7.979565][  T775] [c0000003fee5b620] [c008000000000000] 
0xc008000000000000 (unreliable)
[    7.979688][  T775] [c0000003fee5b6b0] [c000000000614ae8] 
__vmalloc_node_range_noprof+0x208/0x990
[    7.979831][  T775] [c0000003fee5b830] [c000000000615564] 
__vmalloc_noprof+0x54/0x70
[    7.979956][  T775] [c0000003fee5b8a0] [c000000000494cec] 
bpf_prog_alloc_no_stats+0x5c/0x2c0
[    7.980098][  T775] [c0000003fee5b8f0] [c000000000495028] 
bpf_prog_alloc+0xd8/0x120
[    7.980220][  T775] [c0000003fee5b930] [c000000000eff194] 
bpf_prog_create_from_user+0x74/0x190
[    7.980378][  T775] [c0000003fee5b9a0] [c0000000003dd770] 
seccomp_set_mode_filter+0x190/0xd20
[    7.980524][  T775] [c0000003fee5ba40] [c00000000002e410] 
system_call_exception+0x130/0x2a0
[    7.980649][  T775] [c0000003fee5be50] [c00000000000cfdc] 
system_call_vectored_common+0x15c/0x2ec
[    7.980791][  T775] ---- interrupt: 3000 at 0x7fffb6d6b3e4



[    7.805704][    C1] BUG: Unable to handle kernel instruction fetch 
(NULL pointer?)
[    7.805866][    C1] Faulting instruction address: 0x00000000
[    7.805976][    C1] Oops: Kernel access of bad area, sig: 7 [#1]
[    7.811066][    C1] [c000000003f9bd40] [c0000000012262c0] 
cpuidle_enter_state+0x440/0x6f8
[    7.811069][    C1] [c000000003f9bde0] [c000000000e1ab80] 
cpuidle_enter+0x50/0x80
[    7.811074][    C1] [c000000003f9be20] [c0000000002a3d28] 
call_cpuidle+0x48/0x90
[    7.811077][    C1] [c000000003f9be40] [c0000000002ab8d0] 
do_idle+0x2f0/0x3a0
[    7.811080][    C1] [c000000003f9beb0] [c0000000002abc4c] 
cpu_startup_entry+0x4c/0x50
[    7.811082][    C1] [c000000003f9bee0] [c000000000058dbc] 
start_secondary+0x6bc/0xe30
[    7.811086][    C1] [c000000003f9bfe0] [c00000000000e158] 
start_secondary_prolog+0x10/0x14
[    7.811089][    C1] Code: XXXXXXXX XXXXXXXX XXXXXXXX XXXXXXXX 
XXXXXXXX XXXXXXXX XXXXXXXX XXXXXXXX XXXXXXXX XXXXXXXX XXXXXXXX XXXXXXXX 
XXXXXXXX XXXXXXXX XXXXXXXX XXXXXXXX
[    7.813545][    C1] ---[ end trace 0000000000000000 ]---
[    7.818134][    C1] pstore: backend (nvram) writing error (-1)




After applying the patch the issue is getting fixed only for the 
scenario where topology is having thread "1" for the guest,
but when I give threads as 2 or 4 or 8 for the guest topology it is 
still crashing same as above mentioned. So the patch is
fixing the issue for partial scenarios. Some scenarios are still breaking.

Here I changed threads to 2 or 4 or 8 (-smp 
8,maxcpus=64,sockets=2,dies=1,clusters=1,cores=32,threads=1)

Thanks,
Anushree Mathur

