Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8C14AC83F1D
	for <qemu-devel@archiver.kernel.org>; Tue, 15 Jul 2025 09:46:24 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ubcEY-00066r-A0; Tue, 15 Jul 2025 05:46:01 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jonathan.cameron@huawei.com>)
 id 1ubcEH-00063m-FF; Tue, 15 Jul 2025 05:45:47 -0400
Received: from [185.176.79.56] (helo=frasgout.his.huawei.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jonathan.cameron@huawei.com>)
 id 1ubcE7-0002Gx-VJ; Tue, 15 Jul 2025 05:45:41 -0400
Received: from mail.maildlp.com (unknown [172.18.186.231])
 by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4bhDjY6l1Kz6L5CL;
 Tue, 15 Jul 2025 17:41:53 +0800 (CST)
Received: from frapeml500008.china.huawei.com (unknown [7.182.85.71])
 by mail.maildlp.com (Postfix) with ESMTPS id 63AA21402EB;
 Tue, 15 Jul 2025 17:45:23 +0800 (CST)
Received: from localhost (10.203.177.66) by frapeml500008.china.huawei.com
 (7.182.85.71) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.39; Tue, 15 Jul
 2025 11:45:22 +0200
Date: Tue, 15 Jul 2025 10:45:20 +0100
To: Shameer Kolothum <shameerali.kolothum.thodi@huawei.com>,
 <linuxarm@huawei.com>
CC: <qemu-arm@nongnu.org>, <qemu-devel@nongnu.org>, <eric.auger@redhat.com>,
 <peter.maydell@linaro.org>, <jgg@nvidia.com>, <nicolinc@nvidia.com>,
 <ddutile@redhat.com>, <berrange@redhat.com>, <nathanc@nvidia.com>,
 <mochs@nvidia.com>, <smostafa@google.com>, <wangzhou1@hisilicon.com>,
 <jiangkunkun@huawei.com>, <jonathan.cameron@huawei.com>,
 <zhangfei.gao@linaro.org>, <zhenzhong.duan@intel.com>,
 <shameerkolothum@gmail.com>
Subject: Re: [RFC PATCH v3 05/15] hw/arm/smmuv3-accel: Introduce smmuv3
 accel device
Message-ID: <20250715104520.00000c37@huawei.com>
In-Reply-To: <20250714155941.22176-6-shameerali.kolothum.thodi@huawei.com>
References: <20250714155941.22176-1-shameerali.kolothum.thodi@huawei.com>
 <20250714155941.22176-6-shameerali.kolothum.thodi@huawei.com>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.42; x86_64-w64-mingw32)
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.203.177.66]
X-ClientProxiedBy: lhrpeml500002.china.huawei.com (7.191.160.78) To
 frapeml500008.china.huawei.com (7.182.85.71)
X-Host-Lookup-Failed: Reverse DNS lookup failed for 185.176.79.56 (deferred)
Received-SPF: pass client-ip=185.176.79.56;
 envelope-from=jonathan.cameron@huawei.com; helo=frasgout.his.huawei.com
X-Spam_score_int: -33
X-Spam_score: -3.4
X-Spam_bar: ---
X-Spam_report: (-3.4 / 5.0 requ) BAYES_00=-1.9, RCVD_IN_DNSWL_MED=-2.3,
 RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 RDNS_NONE=0.793, SPF_HELO_NONE=0.001,
 T_SPF_TEMPERROR=0.01 autolearn=ham autolearn_force=no
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
Reply-to:  Jonathan Cameron <Jonathan.Cameron@huawei.com>
From:  Jonathan Cameron via <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

On Mon, 14 Jul 2025 16:59:31 +0100
Shameer Kolothum <shameerali.kolothum.thodi@huawei.com> wrote:

> Also setup specific PCIIOMMUOps for accel SMMUv3 as accel
> SMMUv3 will have different handling for those ops callbacks
> in subsequent patches.
> 
> The "accel" property is not yet added, so users cannot set it at this
> point. It will be introduced in a subsequent patch once the necessary
> support is in place.
> 
> Signed-off-by: Shameer Kolothum <shameerali.kolothum.thodi@huawei.com>

> diff --git a/hw/arm/smmuv3-accel.c b/hw/arm/smmuv3-accel.c
> new file mode 100644
> index 0000000000..2eac9c6ff4
> --- /dev/null
> +++ b/hw/arm/smmuv3-accel.c
> @@ -0,0 +1,66 @@
> +/*
> + * Copyright (c) 2025 Huawei Technologies R & D (UK) Ltd
> + * Copyright (C) 2025 NVIDIA
> + * Written by Nicolin Chen, Shameer Kolothum
> + *
> + * SPDX-License-Identifier: GPL-2.0-or-later
> + */
> +
> +#include "qemu/osdep.h"
> +
> +#include "hw/arm/smmuv3.h"
> +#include "smmuv3-accel.h"
> +
> +static SMMUv3AccelDevice *smmuv3_accel_get_dev(SMMUState *bs, SMMUPciBus *sbus,
> +                                                PCIBus *bus, int devfn)
> +{
> +    SMMUDevice *sdev = sbus->pbdev[devfn];
> +    SMMUv3AccelDevice *accel_dev;
> +
> +    if (sdev) {
> +        accel_dev = container_of(sdev, SMMUv3AccelDevice, sdev);

Nicolin made good point on early return being nicer here.

> +    } else {
> +        accel_dev = g_new0(SMMUv3AccelDevice, 1);
> +        sdev = &accel_dev->sdev;
> +
> +        sbus->pbdev[devfn] = sdev;
> +        smmu_init_sdev(bs, sdev, bus, devfn);
> +    }
> +
> +    return accel_dev;
> +}
> +
> +static AddressSpace *smmuv3_accel_find_add_as(PCIBus *bus, void *opaque,
> +                                              int devfn)
> +{
> +    SMMUState *bs = opaque;

Why bs? (other than for giggles)  If that is standard naming already then
fair enough.

> +    SMMUPciBus *sbus;
> +    SMMUv3AccelDevice *accel_dev;
> +    SMMUDevice *sdev;

Maybe tidy up the ordering to some scheme. 

> +
> +    sbus = smmu_get_sbus(bs, bus);
> +    accel_dev = smmuv3_accel_get_dev(bs, sbus, bus, devfn);
> +    sdev = &accel_dev->sdev;
> +
> +    return &sdev->as;

Not a lot of point in having local sdev unless you add more
stuff here that uses it later.

> +}

> diff --git a/hw/arm/smmuv3-accel.h b/hw/arm/smmuv3-accel.h
> new file mode 100644
> index 0000000000..4cf30b1291
> --- /dev/null
> +++ b/hw/arm/smmuv3-accel.h
> @@ -0,0 +1,19 @@
> +/*
> + * Copyright (c) 2025 Huawei Technologies R & D (UK) Ltd
> + * Copyright (C) 2025 NVIDIA
> + * Written by Nicolin Chen, Shameer Kolothum
> + *
> + * SPDX-License-Identifier: GPL-2.0-or-later
> + */
> +
> +#ifndef HW_ARM_SMMUV3_ACCEL_H
> +#define HW_ARM_SMMUV3_ACCEL_H
> +
> +#include "hw/arm/smmu-common.h"
> +#include CONFIG_DEVICES
> +
> +typedef struct SMMUv3AccelDevice {
> +    SMMUDevice  sdev;

Bonus space.

> +} SMMUv3AccelDevice;
> +
> +#endif /* HW_ARM_SMMUV3_ACCEL_H */



