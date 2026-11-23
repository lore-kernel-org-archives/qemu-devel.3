Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9CC96607150E
	for <qemu-devel@archiver.kernel.org>; Mon, 23 Nov 2026 08:06:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.a=rsa-sha256 header.s=dkim header.b=jgbtdDdR
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xVP41-0006a7-8q; Mon, 23 Nov 2026 03:06:13 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ruanjinjie@huawei.com>)
 id 1xVP3y-0006Zi-2E; Mon, 23 Nov 2026 03:06:10 -0500
Received: from canpmsgout06.his.huawei.com ([113.46.200.221])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ruanjinjie@huawei.com>)
 id 1xVP3t-0004F3-RI; Mon, 23 Nov 2026 03:06:09 -0500
dkim-signature: v=1; a=rsa-sha256; d=huawei.com; s=dkim;
 c=relaxed/relaxed; q=dns/txt; h=From;
 bh=c01I33I+83vMc753z973gwZ1aF8sMhxFCCFQwV1PCmw=;
 b=jgbtdDdRGZR41Yim0FJYS/4BiK5SskAceHe7MLkIgw18WHjGgH01fIiYuaJJ0XsxejL/8+J9L
 UcvTFRfoH3X5s3bign1OFq/8T0A03Vy8ksIC2cRt6Y1/ynJa2w8M2F7oaWmZ0FNgmpswLSWPkPl
 dSEB5fFP0nXbkymWaNbHnmU=
Received: from mail.maildlp.com (unknown [172.19.162.223])
 by canpmsgout06.his.huawei.com (SkyGuard) with ESMTPS id 4jXz5J2tntzRhRC;
 Mon, 23 Nov 2026 16:05:24 +0800 (CST)
Received: from kwepemk200008.china.huawei.com (unknown [7.202.194.74])
 by mail.maildlp.com (Postfix) with ESMTPS id D39CD40575;
 Mon, 23 Nov 2026 16:05:41 +0800 (CST)
Received: from [10.67.110.68] (10.67.110.68) by kwepemk200008.china.huawei.com
 (7.202.194.74) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.45; Mon, 23 Nov
 2026 16:05:41 +0800
Message-ID: <ce20db62-82ea-45bd-b758-94c9e9a35c8c@huawei.com>
Date: Mon, 23 Nov 2026 16:05:40 +0800
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 05/37] hw/arm/mpam: Add MPAM MSC register map
To: Jonathan Cameron <jic23@kernel.org>, Jinjie Ruan <2118537295@qq.com>
CC: <anisinha@redhat.com>, <armbru@redhat.com>, <eblake@redhat.com>,
 <imammedo@redhat.com>, <michael.roth@amd.com>, <mst@redhat.com>,
 <pbonzini@redhat.com>, <peter.maydell@linaro.org>, <qemu-devel@nongnu.org>,
 <qemu-arm@nongnu.org>
References: <20261016094733.1898485-1-2118537295@qq.com>
 <tencent_25A9B619D0E3909582B4CF096744805B6107@qq.com>
 <20261103003352.42e05890@jic23-hlaptop>
From: Jinjie Ruan <ruanjinjie@huawei.com>
In-Reply-To: <20261103003352.42e05890@jic23-hlaptop>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: kwepems100002.china.huawei.com (7.221.188.206) To
 kwepemk200008.china.huawei.com (7.202.194.74)
Received-SPF: pass client-ip=113.46.200.221;
 envelope-from=ruanjinjie@huawei.com; helo=canpmsgout06.his.huawei.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, SPF_HELO_NONE=0.001,
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



在 2026/11/3 8:33, Jonathan Cameron 写道:
> On Fri, 16 Oct 2026 17:46:59 +0800
> Jinjie Ruan <2118537295@qq.com> wrote:
> 
>> From: Jonathan Cameron <Jonathan.Cameron@huawei.com>
>>
>> Add the MMIO register map of an MPAM 1.1 Memory System Component
>> (IHI 0099 sections 4-6) as registerfields definitions:
>> - The feature IDRs (MPAMF_IDR, IIDR/AIDR, CPOR/CCAP/MBW/PRI/PARTID_NRW,
>>   MSMON family)
>> - The error registers (ERR_MSI block, ECR, ESR)
>> - The configuration registers (PART_SEL, CMAX/CMIN/CASSOC,
>>   MBW_MIN/MAX/PBM/PROP, PRI, INTPARTID, CPBM/MBW_PBM arrays) and their
>>   write masks
>> - The portion-width constants of this model.
>>
>> Based on an RFC series by Jonathan Cameron.
> 
> Maybe a link tag to that old piece of garbage - might be more useful
> than referring to it like this.

Yes, you are right! A link will be more clear.

> 
> A few typos in here that should be tidied up. I clearly
> didn't check this closely enough at the time. Nothing major
> but need tidying up.
> 
> Also, an LLM pointed out that some of the write masks are more
> complex that this implies as depend on other register values.
> Maybe add comments where that is true as enforcement will be
> needed in the writing code - what we have here just acts as
> some sort of worst case masking.  I guess you could define
> some macros to create the masks here.
> 
> Thanks,
> 
> Jonathan
> 
>>
>> Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
>> Signed-off-by: Jinjie Ruan <ruanjinjie@huawei.com>
> 
>> diff --git a/hw/arm/meson.build b/hw/arm/meson.build
>> index bcc068d..42ca75b 100644
>> --- a/hw/arm/meson.build
>> +++ b/hw/arm/meson.build
>> @@ -106,6 +106,7 @@ arm_common_ss.add(when: 'CONFIG_NETDUINO2', if_true: files('netduino2.c'))
>>  arm_common_ss.add(when: 'CONFIG_RASPI', if_true: files('bcm2835_peripherals.c'))
>>  arm_common_ss.add(when: 'CONFIG_RASPI', if_true: files('bcm2838_peripherals.c'))
>>  arm_common_ss.add(when: 'CONFIG_STRONGARM', if_true: files('strongarm.c'))
>> +arm_common_ss.add(when: 'CONFIG_MPAM', if_true: files('mpam.c'))
>>  arm_common_ss.add(when: 'CONFIG_SX1', if_true: files('omap_sx1.c'))
>>  arm_common_ss.add(when: 'CONFIG_VERSATILE', if_true: files('versatilepb.c'))
>>  arm_common_ss.add(when: 'CONFIG_VEXPRESS', if_true: files('vexpress.c'))
>> diff --git a/hw/arm/mpam.c b/hw/arm/mpam.c
>> new file mode 100644
>> index 0000000..772a120
>> --- /dev/null
>> +++ b/hw/arm/mpam.c
>> @@ -0,0 +1,223 @@
>> +/*
>> + * ARM MPAM emulation
>> + *
>> + * Copyright (c) 2023 Huawei
>> + *
>> + * SPDX-License-Identifier: GPL-2.0-or-later
>> + */
>> +#include "qemu/osdep.h"
>> +#include "qapi/error.h"
>> +#include "qemu/log.h"
>> +#include "hw/core/irq.h"
>> +#include "hw/core/qdev-properties.h"
>> +#include "hw/core/registerfields.h"
>> +#include "hw/core/sysbus.h"
>> +#include "qom/object.h"
>> +#include "hw/arm/mpam.h"
>> +
>> +REG64(MPAMF_IDR, 0)
>> +    FIELD(MPAMF_IDR, PART_ID_MAX, 0, 16)
> 
> Maybe call it PARTID_MAX given spec naming.

Yes, the spec naming is PARTID_MAX.

> 
>> +    FIELD(MPAMF_IDR, PMG_MAX, 16, 8)
>> +    FIELD(MPAMF_IDR, HAS_CCAP_PART, 24, 1)
>> +    FIELD(MPAMF_IDR, HAS_CPOR_PART, 25, 1)
>> +    FIELD(MPAMF_IDR, HAS_MBW_PART, 26, 1)
>> +    FIELD(MPAMF_IDR, HAS_PRI_PART, 27, 1)
>> +    FIELD(MPAMF_IDR, EXT, 28, 1)
>> +    FIELD(MPAMF_IDR, HAS_IMPL_IDR, 29, 1)
>> +    FIELD(MPAMF_IDR, HAS_MSMON, 30, 1)
>> +    FIELD(MPAMF_IDR, HAS_PARTID_NRW, 31, 1)
>> +    FIELD(MPAMF_IDR, HAS_RIS, 32, 1)
>> +    FIELD(MPAMF_IDR, NO_IMPL_PART, 36, 1)
>> +    FIELD(MPAMF_IDR, NO_IMPL_MSMON, 37, 1)
>> +    FIELD(MPAMF_IDR, HAS_EXTD_ESR, 38, 1)
>> +    FIELD(MPAMF_IDR, HAS_ESR, 39, 1)
>> +    FIELD(MPAMF_IDR, HAS_ERR_MS, 40, 1)
>> +    FIELD(MPAMF_IDR, SP4, 41, 1)
>> +    FIELD(MPAMF_IDR, HAS_ENDIS, 42, 1)
>> +    FIELD(MPAMF_IDR, HAS_NFU, 43, 1)
>> +    FIELD(MPAMF_IDR, RIS_MAX, 56, 4)
> 
> 
> 
>> +
>> +REG32(MPAMF_MSMON_IDR, 0x080)
> 
> An LLM pointed out I was really inconsistent in numbers of
> digits.  0x0080

Yes, it is 0x0080 in the spec.

> Ah the heady days of copying typing specs.
> 
>> +    FIELD(MPAMF_MSMON_IDR, MSMON_CSU, 16, 1)
>> +    FIELD(MPAMF_MSMON_IDR, MSMON_MBWU, 17, 1)
>> +    FIELD(MPAMF_MSMON_IDR, HAS_OFLOW_SR, 28, 1)
>> +    FIELD(MPAMF_MSMON_IDR, HAS_OFLW_MS, 29, 1)
> _MSI

Right, will fix them.

> 
>> +    FIELD(MPAMF_MSMON_IDR, NO_OFLW_INTR, 30, 1)
>> +    FIELD(MPAMF_MSMON_IDR, HAS_LOCAL_CAPT_EVNT, 31, 1)
> ...
> 
>> +REG32(MPAMF_MPAMCFG_WINWD, 0x0220)
>> +    FIELD(MPAMF_MPAMCFG_WINWD, US_FRAC, 0, 8)
>> +    FIELD(MPAMF_MPAMCFG_WINWD, US_INT, 8, 16)
>> +#define MPAMF_MPAMCFG_WINWD_WRITE_MASK ( \
>> +    R_MPAMF_MPAMCFG_WINWD_US_FRAC | \
>> +    R_MPAMF_MPAMCFG_WINWD_US_INT)
> 
> Those need _MASK suffix.
> 
>> +
>> +REG32(MPAMF_MPAMCFG_EN, 0x0300)
>> +    FIELD(MPAMF_MPAMCFG_EN, PARTID, 0, 16)
>> +#define MPAMF_MPAMCFG_EN_WRITE_MASK ( \
>> +    R_MPAMF_MPAMCFG_EN_PARTID_MASK)
>> +
>> +REG32(MPAMF_MPAMCFG_DIS, 0x0310) /* WHat is this for? */
>> +    FIELD(MPAMF_MPAMCFG_DIS, PARTID, 0, 16)
>> +    FIELD(MPAMF_MPAMCFG_DIS, NFU, 31, 1)
>> +#define MPAMF_MPAMCFG_DIS_WRITE_MASK ( \
>> +    R_MPAMF_MPAMCFG_DIS_PARTID_MASK | \
>> +    R_MPAMF_MPAMCFG_DIS_NFU)
> 
> Needs a _MASK suffic.

OK

> 
>> +
>> +REG32(MPAMF_MPAMCFG_EN_FLAGS, 0x320)
> 
> Lots of 3 digit addresses scattered through here that
> should all be 4 digits.

Will fix them all.

> 
>> +
>> +#define TYPE_MPAM_MSC "mpam-msc"
>> +/*
>> + * Max number of portions this model exposes for the cache-portion (CPOR)
>> + * bitmap and the memory-bandwidth-portion (MBW_PBM) bitmap.  IHI 0099
>> + * dimensions CPBM_WD/BWPBM_WD by these widths (see MPAMF_CPOR/MBW_IDR).
>> + */
>> +#define MPAM_MBW_PART 4
>> +#define MPAM_CACHE_PART 32
>> +/* MPAMF_IIDR.IMPLEMENTER: ARM JEP106 code for Huawei (0x736). */
>> +#define MPAM_IIDR_IMPLEMENTER 0x736
>> diff --git a/include/hw/arm/mpam.h b/include/hw/arm/mpam.h
>> new file mode 100644
>> index 0000000..e7557a9
>> --- /dev/null
>> +++ b/include/hw/arm/mpam.h
>> @@ -0,0 +1,20 @@
>> +/*
>> + * QEMU MPAM emulation
> Come to think of it, why have QEMU in a QEMU header.
> 
> MPAM emulation.

OK.

> 
>> + *
>> + * SPDX-License-Identifier: GPL-2.0-or-later
>> + */
>> +#ifndef _MPAM_H_
>> +#define _MPAM_H_
>> +
>> +#include "qom/object.h"
>> +
>> +#define TYPE_MPAM_MSC_MEM "mpam-msc-mem"
>> +#define TYPE_MPAM_MSC_CACHE "mpam-msc-cache"
>> +
>> +/*
>> + * MMIO window of one MSC: IHI 0099 places the register block in a 16 KiB
>> + * region (0x4000).  The virt board reserves a 1 MiB slot for up to 256 MSCs.
>> + */
>> +#define MPAM_SIZE 0x4000
>> +
>> +#endif /* _MPAM_H_ */
> 


