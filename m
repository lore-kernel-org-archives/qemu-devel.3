Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 92876606A883
	for <qemu-devel@archiver.kernel.org>; Tue, 17 Nov 2026 07:33:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.a=rsa-sha256 header.s=dkim header.b=DqCtG7hq
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xTDgu-0005w9-72; Tue, 17 Nov 2026 02:33:20 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ruanjinjie@huawei.com>)
 id 1xTDgr-0005vj-IP; Tue, 17 Nov 2026 02:33:18 -0500
Received: from canpmsgout02.his.huawei.com ([113.46.200.217])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ruanjinjie@huawei.com>)
 id 1xTDgo-00046Q-OG; Tue, 17 Nov 2026 02:33:17 -0500
dkim-signature: v=1; a=rsa-sha256; d=huawei.com; s=dkim;
 c=relaxed/relaxed; q=dns/txt; h=From;
 bh=gA0ZgtAJ8oXmGSPuDjrVpuafdDYhvArAj3DhVBD8quY=;
 b=DqCtG7hqgLzq29WvjCd0yic8giwGTicFxAUwbqUEqF8iDXEVcwNGb9YNB9xcV9+YZHA4J6lwO
 yNm4fQ7w+T/5v3KmWkV39jKORs2vONh8adQhTG4a+t8v6bq9UOcihhfo11h5VRPzIMukeANBSMd
 WPVoDcDHAQLRwxBhj/JcjzQ=
Received: from mail.maildlp.com (unknown [172.19.162.144])
 by canpmsgout02.his.huawei.com (SkyGuard) with ESMTPS id 4jTGdl5BLszcbPS;
 Tue, 17 Nov 2026 15:32:11 +0800 (CST)
Received: from kwepemk200008.china.huawei.com (unknown [7.202.194.74])
 by mail.maildlp.com (Postfix) with ESMTPS id 50A1D40685;
 Tue, 17 Nov 2026 15:33:02 +0800 (CST)
Received: from [10.67.110.68] (10.67.110.68) by kwepemk200008.china.huawei.com
 (7.202.194.74) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.45; Tue, 17 Nov
 2026 15:33:01 +0800
Message-ID: <4bcf10e0-23bf-4d1a-9ef7-1dbf98f78931@huawei.com>
Date: Tue, 17 Nov 2026 15:33:00 +0800
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 01/37] target/arm: Add support for MPAM CPU registers
To: Jonathan Cameron <jic23@kernel.org>, Jinjie Ruan <2118537295@qq.com>
CC: <anisinha@redhat.com>, <armbru@redhat.com>, <eblake@redhat.com>,
 <imammedo@redhat.com>, <michael.roth@amd.com>, <mst@redhat.com>,
 <pbonzini@redhat.com>, <peter.maydell@linaro.org>, <qemu-devel@nongnu.org>,
 <qemu-arm@nongnu.org>
References: <20261016094733.1898485-1-2118537295@qq.com>
 <tencent_0D8D61C20611EC56598A6F86E7B869052E05@qq.com>
 <20261103000316.150d658d@jic23-hlaptop>
From: Jinjie Ruan <ruanjinjie@huawei.com>
In-Reply-To: <20261103000316.150d658d@jic23-hlaptop>
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



在 2026/11/3 8:03, Jonathan Cameron 写道:
> On Fri, 16 Oct 2026 17:46:55 +0800
> Jinjie Ruan <2118537295@qq.com> wrote:
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
> 
> Definitely wouldn't trust this guy :)  He took a few naughty short cuts.
> 
>> Signed-off-by: Jinjie Ruan <ruanjinjie@huawei.com>
> 
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
> 
> Similar to patch 2 (I reviewed them backwards) not sure why 
> I ever set this to ARM_CP_ALIAS.
> 
>> +              .accessfn = access_tid3,
> 
> Never trust code I bodged years ago :( Wrong trap. Now you
> have the appropriate EL2 registers in next patch should use a trap
> on the relevant bits being set there.  Will want to swap the patches
> around for that to work I think.  Also possibly needs the EL3 trap
> register defined.

Maybe we can first implement only EL2 to reduce the workload?

I believe that achieving EL1 and EL2 functions is basically sufficient.

> 
> 
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


