Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AC156606A326
	for <qemu-devel@archiver.kernel.org>; Tue,  3 Nov 2026 00:35:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=daiSYPvv
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xO2TV-0003up-0V; Mon, 02 Nov 2026 19:34:05 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jic23@kernel.org>)
 id 1xO2TT-0003uU-Ug; Mon, 02 Nov 2026 19:34:03 -0500
Received: from tor.source.kernel.org ([172.105.4.254])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jic23@kernel.org>)
 id 1xO2TR-0006aG-U6; Mon, 02 Nov 2026 19:34:03 -0500
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 61016601EF;
 Tue,  3 Nov 2026 00:34:00 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 754C81F000C1;
 Tue,  3 Nov 2026 00:33:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1793666040;
 bh=Z+EHhHyZ6RHjzIc/mJT8DEszW81XI3MpPYFNVlmzgKI=;
 h=Date:From:To:Cc:Subject:In-Reply-To:References;
 b=daiSYPvvtPNawopq5lBvQhvBbUuqY+nx8+Ir1cSBEJBcjj5JYmniU94VnSgydGCcO
 A+CNU7vhpkZw1Exp/uEX29uR/h6+9pPWRYzNPTlwZiKtjPN0Fdwb3yE1Onwh8XM9DN
 BI0jSYTQH5AAjchuCQyJOZhv2uZlWONbYXhnIS7S3yVnhHQxKp068R40Ze8jpeDU2z
 IYXJRLOMUg2051fUM5HOeKlTv8wRqc9DcmVyd+muOBgHvG4SS0SqpStoErswAT+rNQ
 v83mmzxcCfPztcVyWBXMQojvz+/pkHgsv6IVFiq6SqqOB1Fd4o9Q/HoooOnlrq6qNP
 xmqo+q26Dtxbg==
Date: Tue, 3 Nov 2026 00:33:52 +0000
From: Jonathan Cameron <jic23@kernel.org>
To: Jinjie Ruan <2118537295@qq.com>
Cc: anisinha@redhat.com, armbru@redhat.com, eblake@redhat.com,
 imammedo@redhat.com, michael.roth@amd.com, mst@redhat.com,
 pbonzini@redhat.com, peter.maydell@linaro.org, qemu-devel@nongnu.org,
 qemu-arm@nongnu.org, ruanjinjie@huawei.com
Subject: Re: [PATCH 05/37] hw/arm/mpam: Add MPAM MSC register map
Message-ID: <20261103003352.42e05890@jic23-hlaptop>
In-Reply-To: <tencent_25A9B619D0E3909582B4CF096744805B6107@qq.com>
References: <20261016094733.1898485-1-2118537295@qq.com>
 <tencent_25A9B619D0E3909582B4CF096744805B6107@qq.com>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.52; x86_64-pc-linux-gnu)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=172.105.4.254; envelope-from=jic23@kernel.org;
 helo=tor.source.kernel.org
X-Spam_score_int: -43
X-Spam_score: -4.4
X-Spam_bar: ----
X-Spam_report: (-4.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_MED=-2.3, SPF_HELO_NONE=0.001,
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
X-Spam-Status: No, score=-17.3 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,
	SPF_PASS,USER_AGENT_SANE_2 autolearn=unavailable autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On Fri, 16 Oct 2026 17:46:59 +0800
Jinjie Ruan <2118537295@qq.com> wrote:

> From: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> 
> Add the MMIO register map of an MPAM 1.1 Memory System Component
> (IHI 0099 sections 4-6) as registerfields definitions:
> - The feature IDRs (MPAMF_IDR, IIDR/AIDR, CPOR/CCAP/MBW/PRI/PARTID_NRW,
>   MSMON family)
> - The error registers (ERR_MSI block, ECR, ESR)
> - The configuration registers (PART_SEL, CMAX/CMIN/CASSOC,
>   MBW_MIN/MAX/PBM/PROP, PRI, INTPARTID, CPBM/MBW_PBM arrays) and their
>   write masks
> - The portion-width constants of this model.
> 
> Based on an RFC series by Jonathan Cameron.

Maybe a link tag to that old piece of garbage - might be more useful
than referring to it like this.

A few typos in here that should be tidied up. I clearly
didn't check this closely enough at the time. Nothing major
but need tidying up.

Also, an LLM pointed out that some of the write masks are more
complex that this implies as depend on other register values.
Maybe add comments where that is true as enforcement will be
needed in the writing code - what we have here just acts as
some sort of worst case masking.  I guess you could define
some macros to create the masks here.

Thanks,

Jonathan

> 
> Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> Signed-off-by: Jinjie Ruan <ruanjinjie@huawei.com>

> diff --git a/hw/arm/meson.build b/hw/arm/meson.build
> index bcc068d..42ca75b 100644
> --- a/hw/arm/meson.build
> +++ b/hw/arm/meson.build
> @@ -106,6 +106,7 @@ arm_common_ss.add(when: 'CONFIG_NETDUINO2', if_true: files('netduino2.c'))
>  arm_common_ss.add(when: 'CONFIG_RASPI', if_true: files('bcm2835_peripherals.c'))
>  arm_common_ss.add(when: 'CONFIG_RASPI', if_true: files('bcm2838_peripherals.c'))
>  arm_common_ss.add(when: 'CONFIG_STRONGARM', if_true: files('strongarm.c'))
> +arm_common_ss.add(when: 'CONFIG_MPAM', if_true: files('mpam.c'))
>  arm_common_ss.add(when: 'CONFIG_SX1', if_true: files('omap_sx1.c'))
>  arm_common_ss.add(when: 'CONFIG_VERSATILE', if_true: files('versatilepb.c'))
>  arm_common_ss.add(when: 'CONFIG_VEXPRESS', if_true: files('vexpress.c'))
> diff --git a/hw/arm/mpam.c b/hw/arm/mpam.c
> new file mode 100644
> index 0000000..772a120
> --- /dev/null
> +++ b/hw/arm/mpam.c
> @@ -0,0 +1,223 @@
> +/*
> + * ARM MPAM emulation
> + *
> + * Copyright (c) 2023 Huawei
> + *
> + * SPDX-License-Identifier: GPL-2.0-or-later
> + */
> +#include "qemu/osdep.h"
> +#include "qapi/error.h"
> +#include "qemu/log.h"
> +#include "hw/core/irq.h"
> +#include "hw/core/qdev-properties.h"
> +#include "hw/core/registerfields.h"
> +#include "hw/core/sysbus.h"
> +#include "qom/object.h"
> +#include "hw/arm/mpam.h"
> +
> +REG64(MPAMF_IDR, 0)
> +    FIELD(MPAMF_IDR, PART_ID_MAX, 0, 16)

Maybe call it PARTID_MAX given spec naming.

> +    FIELD(MPAMF_IDR, PMG_MAX, 16, 8)
> +    FIELD(MPAMF_IDR, HAS_CCAP_PART, 24, 1)
> +    FIELD(MPAMF_IDR, HAS_CPOR_PART, 25, 1)
> +    FIELD(MPAMF_IDR, HAS_MBW_PART, 26, 1)
> +    FIELD(MPAMF_IDR, HAS_PRI_PART, 27, 1)
> +    FIELD(MPAMF_IDR, EXT, 28, 1)
> +    FIELD(MPAMF_IDR, HAS_IMPL_IDR, 29, 1)
> +    FIELD(MPAMF_IDR, HAS_MSMON, 30, 1)
> +    FIELD(MPAMF_IDR, HAS_PARTID_NRW, 31, 1)
> +    FIELD(MPAMF_IDR, HAS_RIS, 32, 1)
> +    FIELD(MPAMF_IDR, NO_IMPL_PART, 36, 1)
> +    FIELD(MPAMF_IDR, NO_IMPL_MSMON, 37, 1)
> +    FIELD(MPAMF_IDR, HAS_EXTD_ESR, 38, 1)
> +    FIELD(MPAMF_IDR, HAS_ESR, 39, 1)
> +    FIELD(MPAMF_IDR, HAS_ERR_MS, 40, 1)
> +    FIELD(MPAMF_IDR, SP4, 41, 1)
> +    FIELD(MPAMF_IDR, HAS_ENDIS, 42, 1)
> +    FIELD(MPAMF_IDR, HAS_NFU, 43, 1)
> +    FIELD(MPAMF_IDR, RIS_MAX, 56, 4)



> +
> +REG32(MPAMF_MSMON_IDR, 0x080)

An LLM pointed out I was really inconsistent in numbers of
digits.  0x0080
Ah the heady days of copying typing specs.

> +    FIELD(MPAMF_MSMON_IDR, MSMON_CSU, 16, 1)
> +    FIELD(MPAMF_MSMON_IDR, MSMON_MBWU, 17, 1)
> +    FIELD(MPAMF_MSMON_IDR, HAS_OFLOW_SR, 28, 1)
> +    FIELD(MPAMF_MSMON_IDR, HAS_OFLW_MS, 29, 1)
_MSI

> +    FIELD(MPAMF_MSMON_IDR, NO_OFLW_INTR, 30, 1)
> +    FIELD(MPAMF_MSMON_IDR, HAS_LOCAL_CAPT_EVNT, 31, 1)
...

> +REG32(MPAMF_MPAMCFG_WINWD, 0x0220)
> +    FIELD(MPAMF_MPAMCFG_WINWD, US_FRAC, 0, 8)
> +    FIELD(MPAMF_MPAMCFG_WINWD, US_INT, 8, 16)
> +#define MPAMF_MPAMCFG_WINWD_WRITE_MASK ( \
> +    R_MPAMF_MPAMCFG_WINWD_US_FRAC | \
> +    R_MPAMF_MPAMCFG_WINWD_US_INT)

Those need _MASK suffix.

> +
> +REG32(MPAMF_MPAMCFG_EN, 0x0300)
> +    FIELD(MPAMF_MPAMCFG_EN, PARTID, 0, 16)
> +#define MPAMF_MPAMCFG_EN_WRITE_MASK ( \
> +    R_MPAMF_MPAMCFG_EN_PARTID_MASK)
> +
> +REG32(MPAMF_MPAMCFG_DIS, 0x0310) /* WHat is this for? */
> +    FIELD(MPAMF_MPAMCFG_DIS, PARTID, 0, 16)
> +    FIELD(MPAMF_MPAMCFG_DIS, NFU, 31, 1)
> +#define MPAMF_MPAMCFG_DIS_WRITE_MASK ( \
> +    R_MPAMF_MPAMCFG_DIS_PARTID_MASK | \
> +    R_MPAMF_MPAMCFG_DIS_NFU)

Needs a _MASK suffic.

> +
> +REG32(MPAMF_MPAMCFG_EN_FLAGS, 0x320)

Lots of 3 digit addresses scattered through here that
should all be 4 digits.

> +
> +#define TYPE_MPAM_MSC "mpam-msc"
> +/*
> + * Max number of portions this model exposes for the cache-portion (CPOR)
> + * bitmap and the memory-bandwidth-portion (MBW_PBM) bitmap.  IHI 0099
> + * dimensions CPBM_WD/BWPBM_WD by these widths (see MPAMF_CPOR/MBW_IDR).
> + */
> +#define MPAM_MBW_PART 4
> +#define MPAM_CACHE_PART 32
> +/* MPAMF_IIDR.IMPLEMENTER: ARM JEP106 code for Huawei (0x736). */
> +#define MPAM_IIDR_IMPLEMENTER 0x736
> diff --git a/include/hw/arm/mpam.h b/include/hw/arm/mpam.h
> new file mode 100644
> index 0000000..e7557a9
> --- /dev/null
> +++ b/include/hw/arm/mpam.h
> @@ -0,0 +1,20 @@
> +/*
> + * QEMU MPAM emulation
Come to think of it, why have QEMU in a QEMU header.

MPAM emulation.

> + *
> + * SPDX-License-Identifier: GPL-2.0-or-later
> + */
> +#ifndef _MPAM_H_
> +#define _MPAM_H_
> +
> +#include "qom/object.h"
> +
> +#define TYPE_MPAM_MSC_MEM "mpam-msc-mem"
> +#define TYPE_MPAM_MSC_CACHE "mpam-msc-cache"
> +
> +/*
> + * MMIO window of one MSC: IHI 0099 places the register block in a 16 KiB
> + * region (0x4000).  The virt board reserves a 1 MiB slot for up to 256 MSCs.
> + */
> +#define MPAM_SIZE 0x4000
> +
> +#endif /* _MPAM_H_ */


