Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EEF41CCF2D6
	for <qemu-devel@archiver.kernel.org>; Mon, 19 Oct 2026 09:22:23 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xIjZA-0007on-3r; Mon, 19 Oct 2026 05:22:00 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ruanjinjie@huawei.com>)
 id 1xIjYT-0007fw-ID; Mon, 19 Oct 2026 05:21:18 -0400
Received: from canpmsgout01.his.huawei.com ([113.46.200.216])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ruanjinjie@huawei.com>)
 id 1xIjYO-0002gE-9n; Mon, 19 Oct 2026 05:21:16 -0400
dkim-signature: v=1; a=rsa-sha256; d=huawei.com; s=dkim;
 c=relaxed/relaxed; q=dns/txt; h=From;
 bh=OkmmPPljI3VcwdyG8WRGz3u42sl+95Rfw5ao3MurFFw=;
 b=PcNkYxou9wyJ571RWOFE6sTMBD1/Sq2GFoJAXHwOGCNuAfsvXIryY9XTCCN/374iXAMdO/xo9
 3Zz+9OOV4A86tgmQIK++IGQ+9vS3PWbNROX27gACC+lThsmXg23J2aqEfTcUSGdhnFONozCbRx1
 jQcyUqSKK8wlIOKciR1+plw=
Received: from mail.maildlp.com (unknown [172.19.163.104])
 by canpmsgout01.his.huawei.com (SkyGuard) with ESMTPS id 4j7VQc4rdsz1T4FX;
 Mon, 19 Oct 2026 17:20:56 +0800 (CST)
Received: from kwepemk200008.china.huawei.com (unknown [7.202.194.74])
 by mail.maildlp.com (Postfix) with ESMTPS id C67624056E;
 Mon, 19 Oct 2026 17:21:01 +0800 (CST)
Received: from [10.67.110.68] (10.67.110.68) by kwepemk200008.china.huawei.com
 (7.202.194.74) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.45; Mon, 19 Oct
 2026 17:21:01 +0800
Message-ID: <bbdf0c72-b842-4c06-b4d8-85c6613fb64f@huawei.com>
Date: Mon, 19 Oct 2026 17:21:00 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 01/37] target/arm: Add support for MPAM CPU registers
To: =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>, Jinjie Ruan
 <2118537295@qq.com>
CC: <anisinha@redhat.com>, <armbru@redhat.com>, <eblake@redhat.com>,
 <imammedo@redhat.com>, <michael.roth@amd.com>, <mst@redhat.com>,
 <pbonzini@redhat.com>, <peter.maydell@linaro.org>, <qemu-devel@nongnu.org>,
 <qemu-arm@nongnu.org>
References: <20261016094733.1898485-1-2118537295@qq.com>
 <tencent_0D8D61C20611EC56598A6F86E7B869052E05@qq.com>
 <87fqy23vag.fsf@draig.linaro.org>
From: Jinjie Ruan <ruanjinjie@huawei.com>
In-Reply-To: <87fqy23vag.fsf@draig.linaro.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.67.110.68]
X-ClientProxiedBy: kwepems100001.china.huawei.com (7.221.188.238) To
 kwepemk200008.china.huawei.com (7.202.194.74)
Received-SPF: pass client-ip=113.46.200.216;
 envelope-from=ruanjinjie@huawei.com; helo=canpmsgout01.his.huawei.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_NONE=0.001,
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



在 2026/10/19 17:16, Alex Bennée 写道:
> Jinjie Ruan <2118537295@qq.com> writes:
> 
>> From: Jonathan Cameron <Jonathan.Cameron@huawei.com>
>>
>> Add the MPAM system registers for TCG: MPAMIDR_EL1 (RO) reporting 64
>> PARTIDs and 4 PMGs, and MPAM0_EL1/MPAM1_EL1 (RW, of which only
>> MPAM1_EL1.MPAMEN is architecturally reset). Advertise FEAT_MPAM via
>> ID_AA64PFR0.MPAM for TCG CPUs.
>>
>> It is common to support MPAM on CPU cores, but not in the rest of the
>> system, so there is little disadvantage in always enabling these.
>>
>> Based on an RFC series by Jonathan Cameron, adapted to the current
>> idregs[] storage and access_tid3() naming.
>>
>> Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
>> Signed-off-by: Jinjie Ruan <ruanjinjie@huawei.com>
> 
> Something is wrong with this thread, when I was reading the cover letter
> I couldn't find the rest of the thread. How did you post this series? It
> looks like the cover letter, first 16 and remaining patches where sent
> in separate batches?

Hi Alex,

Sorry, due to SMTP rate limiting, this series has been split into
multiple threads. The complete 37 patches are as follows:

- cover letter:
https://lore.kernel.org/all/tencent_22E95650AA60C6E59860452C0D61A21F1105@qq.com/

- patch 1 ~ 16:
https://lore.kernel.org/all/tencent_0D8D61C20611EC56598A6F86E7B869052E05@qq.com/


- patch 17 ~ 37:
https://lore.kernel.org/all/tencent_88B063FC15FDB4BD89164484DB67A9B61907@qq.com/#t

> 
>> ---
>>  target/arm/cpu-features.h | 11 +++++++++++
>>  target/arm/cpu.c          | 10 +++++++++-
>>  target/arm/cpu.h          |  3 +++
>>  target/arm/helper.c       | 17 +++++++++++++++++
>>  4 files changed, 40 insertions(+), 1 deletion(-)
>>
>> diff --git a/target/arm/cpu-features.h b/target/arm/cpu-features.h
>> index a9eebb4..4b7d47b 100644
>> --- a/target/arm/cpu-features.h
>> +++ b/target/arm/cpu-features.h
>> @@ -459,6 +459,17 @@ FIELD(DBGDEVID, DOUBLELOCK, 20, 4)
>>  FIELD(DBGDEVID, AUXREGS, 24, 4)
>>  FIELD(DBGDEVID, CIDMASK, 28, 4)
>>  
>> +FIELD(MPAMIDR, PARTID_MAX, 0, 16)
>> +FIELD(MPAMIDR, HAS_HCR, 17, 1)
>> +FIELD(MPAMIDR, VMR_MAX, 18, 3)
>> +FIELD(MPAMIDR, PMG_MAX, 32, 8)
>> +FIELD(MPAMIDR, HAS_ALTSP, 57, 1)
>> +FIELD(MPAMIDR, HAS_TIDR, 58, 1)
>> +FIELD(MPAMIDR, SP4, 59, 1)
>> +FIELD(MPAMIDR, HAS_FORCE_NS, 60, 1)
>> +FIELD(MPAMIDR, HAS_SDEFLT, 61, 1)
>> +FIELD(MPAM1_EL1, MPAMEN, 63, 1)
>> +
>>  FIELD(DBGDEVID1, PCSROFFSET, 0, 4)
>>  
>>  FIELD(MVFR0, SIMDREG, 0, 4)
>> diff --git a/target/arm/cpu.c b/target/arm/cpu.c
>> index 10ac6c9..e7529d5 100644
>> --- a/target/arm/cpu.c
>> +++ b/target/arm/cpu.c
>> @@ -439,6 +439,8 @@ static void arm_cpu_reset_hold(Object *obj, ResetType type)
>>          /* Sample rvbar at reset.  */
>>          env->cp15.rvbar = cpu->rvbar_prop;
>>          env->pc = env->cp15.rvbar;
>> +
>> +        env->mpam1_el1 = R_MPAM1_EL1_MPAMEN_MASK;
>>  #endif
>>      } else {
>>  #if defined(CONFIG_USER_ONLY)
>> @@ -452,6 +454,8 @@ static void arm_cpu_reset_hold(Object *obj, ResetType type)
>>              env->cp15.rvbar = cpu->rvbar_prop;
>>              env->regs[15] = cpu->rvbar_prop;
>>          }
>> +
>> +        env->mpam1_el1 = R_MPAM1_EL1_MPAMEN_MASK;
>>      }
>>  
>>  #if defined(CONFIG_USER_ONLY)
>> @@ -2333,7 +2337,11 @@ static void arm_cpu_realizefn(DeviceState *dev, Error **errp)
>>          FIELD_DP64_IDREG(isar, ID_AA64PFR0, AMU, 0);
>>          FIELD_DP32_IDREG(isar, ID_PFR0, AMU, 0);
>>          /* FEAT_MPAM (Memory Partitioning and Monitoring Extension) */
>> -        FIELD_DP64_IDREG(isar, ID_AA64PFR0, MPAM, 0);
>> +        FIELD_DP64_IDREG(isar, ID_AA64PFR0, MPAM, 1);
>> +        cpu->isar.mpamidr_el1 =
>> +            FIELD_DP64(cpu->isar.mpamidr_el1, MPAMIDR, PARTID_MAX, 63);
>> +        cpu->isar.mpamidr_el1 =
>> +            FIELD_DP64(cpu->isar.mpamidr_el1, MPAMIDR, PMG_MAX, 3);
>>      }
>>  
>>      /* MPU can be configured out of a PMSA CPU either by setting has-mpu
>> diff --git a/target/arm/cpu.h b/target/arm/cpu.h
>> index 06ebed4..51a36fa 100644
>> --- a/target/arm/cpu.h
>> +++ b/target/arm/cpu.h
>> @@ -757,6 +757,8 @@ typedef struct CPUArchState {
>>      struct CPUBreakpoint *cpu_breakpoint[16];
>>      struct CPUWatchpoint *cpu_watchpoint[16];
>>  
>> +    uint64_t mpam0_el1;
>> +    uint64_t mpam1_el1;
>>      /* Optional fault info across tlb lookup. */
>>      ARMMMUFaultInfo *tlb_fi;
>>  
>> @@ -1121,6 +1123,7 @@ struct ArchCPU {
>>          uint32_t dbgdevid;
>>          uint32_t dbgdevid1;
>>          uint64_t reset_pmcr_el0;
>> +        uint64_t mpamidr_el1;
>>          uint64_t idregs[NUM_ID_IDX];
>>      } isar;
>>      uint64_t midr;
>> diff --git a/target/arm/helper.c b/target/arm/helper.c
>> index ff0b766..896ac0e 100644
>> --- a/target/arm/helper.c
>> +++ b/target/arm/helper.c
>> @@ -6907,6 +6907,23 @@ void register_cp_regs_for_features(ARMCPU *cpu)
>>                .access = PL1_R, .type = ARM_CP_CONST,
>>                .accessfn = access_tid3,
>>                .resetvalue = cpu->isar.mvfr0 },
>> +            { .name = "MPAMIDR_EL1", .state = ARM_CP_STATE_AA64,
>> +              .opc0 = 3, .opc1 = 0, .crn = 0xa, .crm = 4, .opc2 = 4,
>> +              .access = PL1_R, .type = ARM_CP_CONST,
>> +              .accessfn = access_tid3,
>> +              .resetvalue = cpu->isar.mpamidr_el1 },
>> +            { .name = "MPAM0_EL1", .state = ARM_CP_STATE_AA64,
>> +              .opc0 = 3, .opc1 = 0, .crn = 0xa, .crm = 5, .opc2 = 1,
>> +              .access = PL1_RW, .type = ARM_CP_ALIAS,
>> +              .accessfn = access_tid3,
>> +              .fieldoffset = offsetof(CPUARMState, mpam0_el1),
>> +            },
>> +            { .name = "MPAM1_EL1", .state = ARM_CP_STATE_AA64,
>> +              .opc0 = 3, .opc1 = 0, .crn = 0xa, .crm = 5, .opc2 = 0,
>> +              .access = PL1_RW, .type = ARM_CP_ALIAS,
>> +              .accessfn = access_tid3,
>> +              .fieldoffset = offsetof(CPUARMState, mpam1_el1),
>> +            },
>>              { .name = "MVFR1_EL1", .state = ARM_CP_STATE_AA64,
>>                .opc0 = 3, .opc1 = 0, .crn = 0, .crm = 3, .opc2 = 1,
>>                .access = PL1_R, .type = ARM_CP_CONST,
> 

-- 
Best regards,
Jinjie


