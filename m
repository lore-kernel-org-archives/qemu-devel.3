Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C6553D29C2A
	for <qemu-devel@archiver.kernel.org>; Mon, 19 Jan 2026 14:15:04 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vhq21-0003GP-Pa; Mon, 19 Jan 2026 09:15:02 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <hbathini@linux.ibm.com>)
 id 1vhk1S-0006Gd-GY; Mon, 19 Jan 2026 02:50:02 -0500
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <hbathini@linux.ibm.com>)
 id 1vhk1Q-0003eO-GC; Mon, 19 Jan 2026 02:50:02 -0500
Received: from pps.filterd (m0360083.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 60J6011F017259;
 Mon, 19 Jan 2026 07:49:58 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=pp1; bh=Tat5tM
 JcsWcMqf9u9U/mrzZ5gT7dFq2fXJa6cr0y3lM=; b=phD46pAumBeaI9K94GQPPk
 UiDyJxAsDl6aQV1j3doWOUQIBRdsN8bt4VoD6dvPJBAiK7+fUCREwSySnJCNEjpU
 n85/otxY+Q/o02OW0mI6h8eJwRXlpm/Iy1NSpSwEg/+Yb2ey+kEG7HU/I0D3YNso
 mIW0ffFoRckCRfs5rJn9vHq7vNFo6xpNygmZKD21ofaBAqVvDlqkFu1kHW9PgFBa
 MC0VPfR/624Te3yUMG1TknEewORBA7+RMacy50ND1jxVuhCOCFvsEBkNF32M+gyA
 47G3ZUzgctNmyKmCIxdmLDif5tyIkniRtpPCaXlxLCCUc1vrcvMdsRLNMmQB1nhQ
 ==
Received: from ppma13.dal12v.mail.ibm.com
 (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4br1x4y0rr-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Mon, 19 Jan 2026 07:49:58 +0000 (GMT)
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
 by ppma13.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 60J7jYhG001168;
 Mon, 19 Jan 2026 07:49:57 GMT
Received: from smtprelay01.fra02v.mail.ibm.com ([9.218.2.227])
 by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 4brpyjd80t-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Mon, 19 Jan 2026 07:49:57 +0000
Received: from smtpav06.fra02v.mail.ibm.com (smtpav06.fra02v.mail.ibm.com
 [10.20.54.105])
 by smtprelay01.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 60J7nrqQ41288080
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Mon, 19 Jan 2026 07:49:53 GMT
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 59DAF2004D;
 Mon, 19 Jan 2026 07:49:53 +0000 (GMT)
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 6677B20040;
 Mon, 19 Jan 2026 07:49:52 +0000 (GMT)
Received: from [9.43.98.125] (unknown [9.43.98.125])
 by smtpav06.fra02v.mail.ibm.com (Postfix) with ESMTP;
 Mon, 19 Jan 2026 07:49:52 +0000 (GMT)
Message-ID: <4d47c1b4-47d3-44a4-b189-2401b5176b93@linux.ibm.com>
Date: Mon, 19 Jan 2026 13:19:51 +0530
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 5/9] pnv/mpipl: Preserve CPU registers after crash
From: Hari Bathini <hbathini@linux.ibm.com>
To: Aditya Gupta <adityag@linux.ibm.com>, qemu-devel@nongnu.org
Cc: qemu-ppc@nongnu.org, Sourabh Jain <sourabhjain@linux.ibm.com>,
 Harsh Prateek Bora <harshpb@linux.ibm.com>
References: <20251206055648.1908734-1-adityag@linux.ibm.com>
 <20251206055648.1908734-6-adityag@linux.ibm.com>
 <b35e15b0-6677-4fda-b687-50affe40c678@linux.ibm.com>
Content-Language: en-US
In-Reply-To: <b35e15b0-6677-4fda-b687-50affe40c678@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Authority-Analysis: v=2.4 cv=R8AO2NRX c=1 sm=1 tr=0 ts=696de226 cx=c_pps
 a=AfN7/Ok6k8XGzOShvHwTGQ==:117 a=AfN7/Ok6k8XGzOShvHwTGQ==:17
 a=IkcTkHD0fZMA:10 a=vUbySO9Y5rIA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=VnNF1IyMAAAA:8 a=rG3VIasqSrK247d_m50A:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
X-Proofpoint-ORIG-GUID: CGQpw5Zff73BaKxlSItluTY47KQNt1E5
X-Proofpoint-GUID: CGQpw5Zff73BaKxlSItluTY47KQNt1E5
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMTE5MDA2MyBTYWx0ZWRfX9eF2yUGUQSry
 DuxzxNJCzcanwndlmzgNYKytQzF3P0cdrtZyqnvZebVRoWuhWDGz0AUyEWBY3iOzmm1tfjyJ0xh
 ATUcB94LlbDrghWBbsk6bGRvRkAnIL7yHYP+6bfzBjhy0mRIeI4d+GncEovjtOhAHWohxXXDGmJ
 gyfvpIm1CIGgql1VGF4X4+4xERLJJKYWabr8qXpW1hwbFbTVcJhZJy9XdnxNw691fnAWv4+2Jfh
 +oxKGaHWGqL7ktM8pEyZdC1Lel5fHCPg+He4xf3tBpbAN9sUgkuAI+RoNuUkJ5sXXqUqMskZLlC
 T+a+z1K3gI0wZiY8X6bUvmKZyR/9PkWyP4nKUR6l7V/CmdbdVgrzXmPJ+i++ScgEFKrMVPQvotm
 rpXcCGS6lFIxZllCR+0EL15JzSuWLoN9fOlbEweNFEyKyesFTtTEZhEAfvDazqBRMgb5VJS1bJG
 TfPP90EdJ0+yFwb0/9A==
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



On 19/01/26 1:17 pm, Hari Bathini wrote:
> 
> 
> On 06/12/25 11:26 am, Aditya Gupta wrote:
>> Kernel expects the platform to provide CPU registers after pausing
>> execution of the CPUs.
>>
>> Currently only exporting the registers, used by Linux, for generating
>> the /proc/vmcore
>>
>> Signed-off-by: Aditya Gupta <adityag@linux.ibm.com>
>> ---
>>   hw/ppc/pnv_mpipl.c         | 102 +++++++++++++++++++++++++++++++++++++
>>   include/hw/ppc/pnv_mpipl.h |  62 ++++++++++++++++++++++
>>   2 files changed, 164 insertions(+)
>>
>> diff --git a/hw/ppc/pnv_mpipl.c b/hw/ppc/pnv_mpipl.c
>> index a4f7113a44fd..8b41938c2e87 100644
>> --- a/hw/ppc/pnv_mpipl.c
>> +++ b/hw/ppc/pnv_mpipl.c
>> @@ -8,6 +8,8 @@
>>   #include "qemu/log.h"
>>   #include "qemu/units.h"
>>   #include "system/address-spaces.h"
>> +#include "system/cpus.h"
>> +#include "system/hw_accel.h"
>>   #include "system/runstate.h"
>>   #include "hw/ppc/pnv.h"
>>   #include "hw/ppc/pnv_mpipl.h"
>> @@ -17,6 +19,8 @@
>>       (pnv->mpipl_state.skiboot_base + MDST_TABLE_OFF)
>>   #define MDDT_TABLE_RELOCATED                            \
>>       (pnv->mpipl_state.skiboot_base + MDDT_TABLE_OFF)
>> +#define PROC_DUMP_RELOCATED                             \
>> +    (pnv->mpipl_state.skiboot_base + PROC_DUMP_AREA_OFF)
>>   /*
>>    * Preserve the memory regions as pointed by MDST table
>> @@ -164,9 +168,107 @@ static bool 
>> pnv_mpipl_preserve_mem(PnvMachineState *pnv)
>>       return true;
>>   }
>> +static void do_store_cpu_regs(CPUState *cpu, MpiplPreservedCPUState 
>> *state)
>> +{
>> +    CPUPPCState *env = cpu_env(cpu);
>> +    MpiplRegDataHdr *regs_hdr = &state->hdr;
>> +    MpiplRegEntry *reg_entries = state->reg_entries;
>> +    MpiplRegEntry *curr_reg_entry;
>> +    uint32_t num_saved_regs = 0;
>> +
>> +    cpu_synchronize_state(cpu);
>> +
>> +    regs_hdr->pir = cpu_to_be32(env->spr[SPR_PIR]);
>> +
>> +    /* QEMU CPUs are not in Power Saving Mode */
>> +    regs_hdr->core_state = 0xff;
>> +
>> +    regs_hdr->off_regentries = 0;
>> +    regs_hdr->num_regentries = cpu_to_be32(NUM_REGS_PER_CPU);
>> +
>> +    regs_hdr->alloc_size = cpu_to_be32(sizeof(MpiplRegEntry));
>> +    regs_hdr->act_size   = cpu_to_be32(sizeof(MpiplRegEntry));
>> +
>> +#define REG_TYPE_GPR  0x1
>> +#define REG_TYPE_SPR  0x2
>> +#define REG_TYPE_TIMA 0x3
>> +
>> +/*
>> + * ID numbers used by f/w while populating certain registers
>> + *
>> + * Copied these defines from the linux kernel
>> + */
>> +#define REG_ID_NIP          0x7D0
>> +#define REG_ID_MSR          0x7D1
>> +#define REG_ID_CCR          0x7D2
>> +
>> +    curr_reg_entry = reg_entries;
>> +
>> +#define REG_ENTRY(type, num, val)                          \
>> +    do {                                               \
>> +        curr_reg_entry->reg_type = cpu_to_be32(type);  \
>> +        curr_reg_entry->reg_num  = cpu_to_be32(num);   \
>> +        curr_reg_entry->reg_val  = cpu_to_be64(val);   \
>> +        ++curr_reg_entry;                              \
>> +        ++num_saved_regs;                            \
>> +    } while (0)
>> +
>> +    /* Save the GPRs */
>> +    for (int gpr_id = 0; gpr_id < 32; ++gpr_id) {
>> +        REG_ENTRY(REG_TYPE_GPR, gpr_id, env->gpr[gpr_id]);
>> +    }
>> +
>> +    REG_ENTRY(REG_TYPE_SPR, REG_ID_NIP, env->nip);
>> +    REG_ENTRY(REG_TYPE_SPR, REG_ID_MSR, env->msr);
>> +
>> +    /*
>> +     * Ensure the number of registers saved match the number of
>> +     * registers per cpu
>> +     *
>> +     * This will help catch an error if in future a new register entry
>> +     * is added/removed while not modifying NUM_PER_CPU_REGS
>> +     */
>> +    assert(num_saved_regs == NUM_REGS_PER_CPU);
>> +}
>> +
>> +static void pnv_mpipl_preserve_cpu_state(PnvMachineState *pnv)
>> +{
>> +    MachineState *machine = MACHINE(pnv);
>> +    uint32_t num_cpus = machine->smp.cpus;
>> +    MpiplPreservedCPUState *state;
>> +    CPUState *cpu;
>> +
>> +    if (pnv->mpipl_state.cpu_states) {
>> +        /*
>> +         * CPU States might have been allocated from some past crash, 
>> free the
>> +         * memory to preven memory leak
>> +         */
>> +        g_free(pnv->mpipl_state.cpu_states);
>> +        pnv->mpipl_state.num_cpu_states = 0;
>> +    }
>> +
>> +    pnv->mpipl_state.cpu_states = g_malloc_n(num_cpus,
>> +            sizeof(MpiplPreservedCPUState));
>> +    pnv->mpipl_state.num_cpu_states = num_cpus;
>> +
>> +    state = pnv->mpipl_state.cpu_states;
>> +
>> +    /* Preserve the Processor Dump Area */
>> +    cpu_physical_memory_read(PROC_DUMP_RELOCATED, &pnv- 
>> >mpipl_state.proc_area,
>> +            sizeof(MpiplProcDumpArea));
>> +
>> +    CPU_FOREACH(cpu) {
>> +        do_store_cpu_regs(cpu, state);
>> +        ++state;
>> +    }
>> +}
>> +
>>   void do_mpipl_preserve(PnvMachineState *pnv)
>>   {
>> +    pause_all_vcpus();
>> +
>>       pnv_mpipl_preserve_mem(pnv);
>> +    pnv_mpipl_preserve_cpu_state(pnv);
>>       /* Mark next boot as Memory-preserving boot */
>>       pnv->mpipl_state.is_next_boot_mpipl = true;
>> diff --git a/include/hw/ppc/pnv_mpipl.h b/include/hw/ppc/pnv_mpipl.h
>> index ec173ba8268e..d85970bba039 100644
>> --- a/include/hw/ppc/pnv_mpipl.h
>> +++ b/include/hw/ppc/pnv_mpipl.h
>> @@ -16,6 +16,12 @@ typedef struct MdstTableEntry MdstTableEntry;
>>   typedef struct MdrtTableEntry MdrtTableEntry;

>>   typedef struct MpiplPreservedState MpiplPreservedState;

>> +typedef struct MpiplRegDataHdr MpiplRegDataHdr;
>> +typedef struct MpiplRegEntry MpiplRegEntry;
>> +typedef struct MpiplProcDumpArea MpiplProcDumpArea;

>> +typedef struct MpiplPreservedState MpiplPreservedState;

btw, the above typedef is already available from a previous patch..

>> +typedef struct MpiplPreservedCPUState MpiplPreservedCPUState;
>> +
>>   /* Following offsets are copied from skiboot source code */
>>   /* Use 768 bytes for SPIRAH */
>>   #define SPIRAH_OFF      0x00010000
>> @@ -46,6 +52,8 @@ typedef struct MpiplPreservedState MpiplPreservedState;
>>   #define __packed             __attribute__((packed))
> 
>> +#define NUM_REGS_PER_CPU 34 /*(32 GPRs, NIP, MSR)*/
>> +
> 
> Any limitation with saving the other SPRs? At least, LR is one other
> relevant SPR that needs to be saved for some meaningful context..

- Hari

