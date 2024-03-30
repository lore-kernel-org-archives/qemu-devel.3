Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E053FCD1283
	for <qemu-devel@archiver.kernel.org>; Sat, 30 Mar 2024 01:43:36 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rqNkV-0004eK-0w; Fri, 29 Mar 2024 21:43:11 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ruanjinjie@huawei.com>)
 id 1rqNkS-0004dV-Ra; Fri, 29 Mar 2024 21:43:08 -0400
Received: from szxga07-in.huawei.com ([45.249.212.35])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ruanjinjie@huawei.com>)
 id 1rqNkO-0007Nz-Up; Fri, 29 Mar 2024 21:43:08 -0400
Received: from mail.maildlp.com (unknown [172.19.163.17])
 by szxga07-in.huawei.com (SkyGuard) with ESMTP id 4V60MX468Qz1R8y5;
 Sat, 30 Mar 2024 09:40:08 +0800 (CST)
Received: from kwepemi500008.china.huawei.com (unknown [7.221.188.139])
 by mail.maildlp.com (Postfix) with ESMTPS id 88F141A0172;
 Sat, 30 Mar 2024 09:42:50 +0800 (CST)
Received: from [10.67.109.254] (10.67.109.254) by
 kwepemi500008.china.huawei.com (7.221.188.139) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Sat, 30 Mar 2024 09:42:49 +0800
Message-ID: <88013343-6734-272b-c5c1-a12878b8a9b7@huawei.com>
Date: Sat, 30 Mar 2024 09:42:49 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.2.0
Subject: Re: [PATCH v10 14/23] hw/intc/arm_gicv3: Add irq non-maskable property
To: Peter Maydell <peter.maydell@linaro.org>
CC: <eduardo@habkost.net>, <marcel.apfelbaum@gmail.com>, <philmd@linaro.org>, 
 <wangyanan55@huawei.com>, <richard.henderson@linaro.org>,
 <qemu-devel@nongnu.org>, <qemu-arm@nongnu.org>
References: <20240325084854.3010562-1-ruanjinjie@huawei.com>
 <20240325084854.3010562-15-ruanjinjie@huawei.com>
 <CAFEAcA9go1xe+UOBjH64nsRx-n6Tz3sp71qjb0Je=9r8nHBbuA@mail.gmail.com>
Content-Language: en-US
In-Reply-To: <CAFEAcA9go1xe+UOBjH64nsRx-n6Tz3sp71qjb0Je=9r8nHBbuA@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.67.109.254]
X-ClientProxiedBy: dggems701-chm.china.huawei.com (10.3.19.178) To
 kwepemi500008.china.huawei.com (7.221.188.139)
Received-SPF: pass client-ip=45.249.212.35; envelope-from=ruanjinjie@huawei.com;
 helo=szxga07-in.huawei.com
X-Spam_score_int: -70
X-Spam_score: -7.1
X-Spam_bar: -------
X-Spam_report: (-7.1 / 5.0 requ) BAYES_00=-1.9, NICE_REPLY_A=-2.913,
 RCVD_IN_DNSWL_MED=-2.3, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Reply-to:  Jinjie Ruan <ruanjinjie@huawei.com>
From:  Jinjie Ruan via <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org



On 2024/3/28 22:54, Peter Maydell wrote:
> On Mon, 25 Mar 2024 at 08:52, Jinjie Ruan <ruanjinjie@huawei.com> wrote:
>>
>> A SPI, PPI or SGI interrupt can have non-maskable property. So maintain
>> non-maskable property in PendingIrq and GICR/GICD. Since add new device
>> state, it also needs to be migrated, so also save NMI info in
>> vmstate_gicv3_cpu and vmstate_gicv3.
>>
>> Signed-off-by: Jinjie Ruan <ruanjinjie@huawei.com>
>> Acked-by: Richard Henderson <richard.henderson@linaro.org>
>> ---
>> v10:
>> - superprio -> nmi, gicr_isuperprio -> gicr_inmir0.
>> - Save NMI state in vmstate_gicv3_cpu and vmstate_gicv3.
>> - Update the commit message.
>> v3:
>> - Place this ahead of implement GICR_INMIR.
>> - Add Acked-by.
>> ---
>>  hw/intc/arm_gicv3_common.c         | 44 ++++++++++++++++++++++++++++++
>>  include/hw/intc/arm_gicv3_common.h |  4 +++
>>  2 files changed, 48 insertions(+)
>>
>> diff --git a/hw/intc/arm_gicv3_common.c b/hw/intc/arm_gicv3_common.c
>> index 2d2cea6858..be76ae0be6 100644
>> --- a/hw/intc/arm_gicv3_common.c
>> +++ b/hw/intc/arm_gicv3_common.c
>> @@ -164,6 +164,24 @@ const VMStateDescription vmstate_gicv3_gicv4 = {
>>      }
>>  };
>>
>> +static bool nmi_needed(void *opaque)
>> +{
>> +    GICv3CPUState *cs = opaque;
>> +
>> +    return cs->gic->nmi_support != 0;
> 
> nmi_support is already a bool, so you can
>        return cs->gic_nmi_support;
> 
> 
>> +}
>> +
>> +static const VMStateDescription vmstate_gicv3_cpu_nmi = {
>> +    .name = "arm_gicv3_cpu/nmi",
>> +    .version_id = 1,
>> +    .minimum_version_id = 1,
>> +    .needed = nmi_needed,
>> +    .fields = (const VMStateField[]) {
>> +        VMSTATE_UINT32(gicr_inmir0, GICv3CPUState),
>> +        VMSTATE_END_OF_LIST()
>> +    }
>> +};
>> +
>>  static const VMStateDescription vmstate_gicv3_cpu = {
>>      .name = "arm_gicv3_cpu",
>>      .version_id = 1,
>> @@ -197,6 +215,10 @@ static const VMStateDescription vmstate_gicv3_cpu = {
>>          &vmstate_gicv3_cpu_sre_el1,
>>          &vmstate_gicv3_gicv4,
>>          NULL
>> +    },
>> +    .subsections = (const VMStateDescription * const []) {
>> +        &vmstate_gicv3_cpu_nmi,
>> +        NULL
> 
> You add your subsection to the existing .subsections[] list.
> Otherwise this field initializer overwrites the previous one.
> 
>>      }
>>  };
>>
>> @@ -238,6 +260,24 @@ const VMStateDescription vmstate_gicv3_gicd_no_migration_shift_bug = {
>>      }
>>  };
>>
>> +static bool needed_nmi(void *opaque)
>> +{
>> +    GICv3State *cs = opaque;
>> +
>> +    return cs->nmi_support != 0;
>> +}
> 
> You already have nmi_needed() above, so you can use it
> as the .needed function for both vmstate struct definitions.

The input opaque pointer seems not same, one is "GICv3CPUState *", but
another is "GICv3State *"

> 
>> +
>> +const VMStateDescription vmstate_gicv3_gicd_nmi = {
>> +    .name = "arm_gicv3/gicd_nmi",
>> +    .version_id = 1,
>> +    .minimum_version_id = 1,
>> +    .needed = needed_nmi,
>> +    .fields = (const VMStateField[]) {
>> +        VMSTATE_UINT32_ARRAY(nmi, GICv3State, GICV3_BMP_SIZE),
>> +        VMSTATE_END_OF_LIST()
>> +    }
>> +};
>> +
>>  static const VMStateDescription vmstate_gicv3 = {
>>      .name = "arm_gicv3",
>>      .version_id = 1,
>> @@ -267,6 +307,10 @@ static const VMStateDescription vmstate_gicv3 = {
>>      .subsections = (const VMStateDescription * const []) {
>>          &vmstate_gicv3_gicd_no_migration_shift_bug,
>>          NULL
>> +    },
>> +    .subsections = (const VMStateDescription * const []) {
>> +        &vmstate_gicv3_gicd_nmi,
>> +        NULL
> 
> Similarly here this must be added to the existing list.
> 
>>      }
>>  };
>>
>> diff --git a/include/hw/intc/arm_gicv3_common.h b/include/hw/intc/arm_gicv3_common.h
>> index 4358c5319c..88533749eb 100644
>> --- a/include/hw/intc/arm_gicv3_common.h
>> +++ b/include/hw/intc/arm_gicv3_common.h
>> @@ -146,6 +146,7 @@ typedef struct {
>>      int irq;
>>      uint8_t prio;
>>      int grp;
>> +    bool nmi;
>>  } PendingIrq;
>>
>>  struct GICv3CPUState {
>> @@ -172,6 +173,7 @@ struct GICv3CPUState {
>>      uint32_t gicr_ienabler0;
>>      uint32_t gicr_ipendr0;
>>      uint32_t gicr_iactiver0;
>> +    uint32_t gicr_inmir0;
>>      uint32_t edge_trigger; /* ICFGR0 and ICFGR1 even bits */
>>      uint32_t gicr_igrpmodr0;
>>      uint32_t gicr_nsacr;
>> @@ -275,6 +277,7 @@ struct GICv3State {
>>      GIC_DECLARE_BITMAP(active);       /* GICD_ISACTIVER */
>>      GIC_DECLARE_BITMAP(level);        /* Current level */
>>      GIC_DECLARE_BITMAP(edge_trigger); /* GICD_ICFGR even bits */
>> +    GIC_DECLARE_BITMAP(nmi);          /* GICD_INMIR */
>>      uint8_t gicd_ipriority[GICV3_MAXIRQ];
>>      uint64_t gicd_irouter[GICV3_MAXIRQ];
>>      /* Cached information: pointer to the cpu i/f for the CPUs specified
>> @@ -314,6 +317,7 @@ GICV3_BITMAP_ACCESSORS(pending)
>>  GICV3_BITMAP_ACCESSORS(active)
>>  GICV3_BITMAP_ACCESSORS(level)
>>  GICV3_BITMAP_ACCESSORS(edge_trigger)
>> +GICV3_BITMAP_ACCESSORS(nmi)
>>
>>  #define TYPE_ARM_GICV3_COMMON "arm-gicv3-common"
>>  typedef struct ARMGICv3CommonClass ARMGICv3CommonClass;
>> --
>> 2.34.1
> 
> thanks
> -- PMM

