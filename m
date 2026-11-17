Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B3469606A31C
	for <qemu-devel@archiver.kernel.org>; Tue, 17 Nov 2026 09:19:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.a=rsa-sha256 header.s=dkim header.b=abiS9bjD
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xTFLC-0000X3-Hf; Tue, 17 Nov 2026 04:19:02 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ruanjinjie@huawei.com>)
 id 1xTFLA-0000WL-3K; Tue, 17 Nov 2026 04:19:00 -0500
Received: from canpmsgout02.his.huawei.com ([113.46.200.217])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ruanjinjie@huawei.com>)
 id 1xTFL7-0007Uk-2S; Tue, 17 Nov 2026 04:18:59 -0500
dkim-signature: v=1; a=rsa-sha256; d=huawei.com; s=dkim;
 c=relaxed/relaxed; q=dns/txt; h=From;
 bh=fhW1GFCVO1kUvNCcM4G6GtecSnQg9Q6t4y5t7PIEJNc=;
 b=abiS9bjDp2CDnR6oDoTNqM6dETzQpIUwGjGEaenhhjmIYuK6PFTOtNV/EUZRnnRqWH+IgfEcw
 R+iuVVEuyGkuJTnir6H0nhbb8OFGpDZB3MA/T76B7RNu5gh1Pew7dhIJwG4qINagAw0BS4Jw6fo
 bfzMe2P4h4C6pR5r0vC/jOg=
Received: from mail.maildlp.com (unknown [172.19.163.0])
 by canpmsgout02.his.huawei.com (SkyGuard) with ESMTPS id 4jTJzp4fqpzcbPh;
 Tue, 17 Nov 2026 17:17:58 +0800 (CST)
Received: from kwepemk200008.china.huawei.com (unknown [7.202.194.74])
 by mail.maildlp.com (Postfix) with ESMTPS id 6093040537;
 Tue, 17 Nov 2026 17:18:49 +0800 (CST)
Received: from [10.67.110.68] (10.67.110.68) by kwepemk200008.china.huawei.com
 (7.202.194.74) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.45; Tue, 17 Nov
 2026 17:18:48 +0800
Message-ID: <f218f25e-d4ed-4327-91d8-3ddd73c6f199@huawei.com>
Date: Tue, 17 Nov 2026 17:18:48 +0800
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 03/37] target/arm: Add MPAMSM_EL1 register
To: Jonathan Cameron <jic23@kernel.org>, Jinjie Ruan <2118537295@qq.com>
CC: <anisinha@redhat.com>, <armbru@redhat.com>, <eblake@redhat.com>,
 <imammedo@redhat.com>, <michael.roth@amd.com>, <mst@redhat.com>,
 <pbonzini@redhat.com>, <peter.maydell@linaro.org>, <qemu-devel@nongnu.org>,
 <qemu-arm@nongnu.org>
References: <20261016094733.1898485-1-2118537295@qq.com>
 <tencent_83B7D852163320C7882BE1690E1334883308@qq.com>
 <20261103000550.1c2ae1f0@jic23-hlaptop>
From: Jinjie Ruan <ruanjinjie@huawei.com>
In-Reply-To: <20261103000550.1c2ae1f0@jic23-hlaptop>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: kwepems100002.china.huawei.com (7.221.188.206) To
 kwepemk200008.china.huawei.com (7.202.194.74)
Received-SPF: pass client-ip=113.46.200.217;
 envelope-from=ruanjinjie@huawei.com; helo=canpmsgout02.his.huawei.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
X-Spam-Status: No, score=-17.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1



在 2026/11/3 8:05, Jonathan Cameron 写道:
> On Fri, 16 Oct 2026 17:46:57 +0800
> Jinjie Ruan <2118537295@qq.com> wrote:
> 
>> From: Jinjie Ruan <ruanjinjie@huawei.com>
>>
>> FEAT_MPAM_SMS's MPAMSM_EL1 (S3_0_C10_C5_3) was missing, so a v7.x
>> guest with SME enabled took an UNDEFINED instruction in
>> cpu_enable_mpam(), which writes the register unconditionally when
>> ARM64_SME is present. Register it backed by CPU state like the other
>> MPAM registers, letting linux v7.x boot with -cpu max unmodified.
>>
>> Signed-off-by: Jinjie Ruan <ruanjinjie@huawei.com>
>> ---
>>  target/arm/cpu.h    | 1 +
>>  target/arm/helper.c | 6 ++++++
>>  2 files changed, 7 insertions(+)
>>
>> diff --git a/target/arm/cpu.h b/target/arm/cpu.h
>> index 218923a..c60ec62 100644
>> --- a/target/arm/cpu.h
>> +++ b/target/arm/cpu.h
>> @@ -761,6 +761,7 @@ typedef struct CPUArchState {
>>      uint64_t mpam1_el1;
>>      uint64_t mpam2_el2;
>>      uint64_t mpamhcr_el2;
>> +    uint64_t mpamsm_el1;
>>      /* Optional fault info across tlb lookup. */
>>      ARMMMUFaultInfo *tlb_fi;
>>  
>> diff --git a/target/arm/helper.c b/target/arm/helper.c
>> index d5d96d5..a9b1521 100644
>> --- a/target/arm/helper.c
>> +++ b/target/arm/helper.c
>> @@ -6912,6 +6912,12 @@ void register_cp_regs_for_features(ARMCPU *cpu)
>>                .access = PL1_R, .type = ARM_CP_CONST,
>>                .accessfn = access_tid3,
>>                .resetvalue = cpu->isar.mpamidr_el1 },
>> +            { .name = "MPAMSM_EL1", .state = ARM_CP_STATE_AA64,
>> +              .opc0 = 3, .opc1 = 0, .crn = 0xa, .crm = 5, .opc2 = 3,
>> +              .access = PL1_RW, .type = ARM_CP_ALIAS,
>> +              .accessfn = access_tid3,
> Same as previous.  Wrong trap. Also depends on SME being present, otherwise
> this register needs hiding.  

Have fixed them, thank you!

> 
> FWIW claude at least is really good at giving at poking holes in these entries.
> Other LLMs might be too.  Bunch of RES0 in this one as well.
> 
> 
>> +              .fieldoffset = offsetof(CPUARMState, mpamsm_el1),
>> +            },
>>              { .name = "MPAM0_EL1", .state = ARM_CP_STATE_AA64,
>>                .opc0 = 3, .opc1 = 0, .crn = 0xa, .crm = 5, .opc2 = 1,
>>                .access = PL1_RW, .type = ARM_CP_ALIAS,
> 


