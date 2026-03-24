Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6EA72F532D0
	for <qemu-devel@archiver.kernel.org>; Tue, 24 Mar 2026 04:14:08 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w4t8r-0003XL-RA; Tue, 24 Mar 2026 00:13:21 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <tangtao1634@phytium.com.cn>)
 id 1w4t8p-0003XA-Hp
 for qemu-devel@nongnu.org; Tue, 24 Mar 2026 00:13:19 -0400
Received: from zg8tmja5ljk3lje4ms43mwaa.icoremail.net ([209.97.181.73])
 by eggs.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <tangtao1634@phytium.com.cn>) id 1w4t8g-0006Oe-IG
 for qemu-devel@nongnu.org; Tue, 24 Mar 2026 00:13:19 -0400
Received: from prodtpl.icoremail.net (unknown [10.12.1.20])
 by hzbj-icmmx-6 (Coremail) with SMTP id AQAAfwAHDqJID8JpZ_YZAA--.8836S2;
 Tue, 24 Mar 2026 12:12:56 +0800 (CST)
Received: from [10.31.91.158] (unknown [218.76.62.144])
 by mail (Coremail) with SMTP id AQAAf8DwfpFED8Jp394EAA--.3190S2;
 Tue, 24 Mar 2026 12:12:52 +0800 (CST)
Message-ID: <baefd7cd-3a4c-41cf-892e-a6002bc6418a@phytium.com.cn>
Date: Tue, 24 Mar 2026 12:12:51 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 1/2] tests/qtest/libqos: Add Intel IOMMU helper library
To: Fengyuan Yu <15fengyuan@gmail.com>, "Michael S. Tsirkin"
 <mst@redhat.com>, Jason Wang <jasowang@redhat.com>,
 Yi Liu <yi.l.liu@intel.com>,
 =?UTF-8?Q?Cl=C3=A9ment_Mathieu--Drif?= <clement.mathieu--drif@bull.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Zhao Liu <zhao1.liu@intel.com>,
 Fabiano Rosas <farosas@suse.de>, Laurent Vivier <lvivier@redhat.com>
Cc: qemu-devel@nongnu.org, Chao Liu <chao.liu.zevorn@gmail.com>
References: <cover.1773450180.git.15fengyuan@gmail.com>
 <75efb1c5f4088f449754ac05d0aaff4e70e8329f.1773450180.git.15fengyuan@gmail.com>
From: Tao Tang <tangtao1634@phytium.com.cn>
In-Reply-To: <75efb1c5f4088f449754ac05d0aaff4e70e8329f.1773450180.git.15fengyuan@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: AQAAf8DwfpFED8Jp394EAA--.3190S2
X-CM-SenderInfo: pwdqw3tdrrljuu6sx5pwlxzhxfrphubq/1tbiAQAEBWnBk3gB+AAAs6
Authentication-Results: hzbj-icmmx-6; spf=neutral smtp.mail=tangtao163
 4@phytium.com.cn;
X-Coremail-Antispam: 1Uk129KBjvJXoWxXF13Cw45KFW3GFy8Kr45Wrg_yoWrGF4kpF
 18ua9Yk3yfGF1xWrnxGF42yF1rKFs2kF47uFy3tw15Jr9Iyr47JrnrKryjvr9xW3yDXr4S
 vw4qqFn3Wr1YqrJanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUj1kv1TuYvTs0mT0YCTnIWj
 DUYxn0WfASr-VFAU7a7-sFnT9fnUUIcSsGvfJ3UbIYCTnIWIevJa73UjIFyTuYvj4RJUUU
 UUUUU
Received-SPF: pass client-ip=209.97.181.73;
 envelope-from=tangtao1634@phytium.com.cn;
 helo=zg8tmja5ljk3lje4ms43mwaa.icoremail.net
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, RCVD_IN_MSPIKE_H5=0.001,
 RCVD_IN_MSPIKE_WL=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001, SPF_HELO_NONE=0.001,
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

Hi Fengyuan,

On 2026/3/14 09:11, Fengyuan Yu wrote:
> Signed-off-by: Fengyuan Yu <15fengyuan@gmail.com>
> ---
>   MAINTAINERS                          |   6 +
>   tests/qtest/libqos/meson.build       |   3 +
>   tests/qtest/libqos/qos-intel-iommu.c | 454 +++++++++++++++++++++++++++
>   tests/qtest/libqos/qos-intel-iommu.h | 191 +++++++++++
>   4 files changed, 654 insertions(+)
>   create mode 100644 tests/qtest/libqos/qos-intel-iommu.c
>   create mode 100644 tests/qtest/libqos/qos-intel-iommu.h
>
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 247799c817..876e00ff77 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -151,6 +151,9 @@ F: target/i386/meson.build
>   F: tools/i386/
>   F: tests/functional/i386/
>   F: tests/functional/x86_64/
> +F: tests/qtest/intel-iommu-test.c
> +F: tests/qtest/libqos/qos-intel-iommu*
> +F: tests/qtest/iommu-intel-test.c
>   
>   X86 VM file descriptor change on reset test
>   M: Ani Sinha <anisinha@redhat.com>
> @@ -4026,6 +4029,9 @@ F: hw/i386/intel_iommu_accel.*
>   F: include/hw/i386/intel_iommu.h
>   F: tests/functional/x86_64/test_intel_iommu.py
>   F: tests/qtest/intel-iommu-test.c
> +F: tests/qtest/libqos/qos-intel-iommu*
> +F: tests/qtest/iommu-intel-test.c
> +
>   
>   AMD-Vi Emulation
>   M: Alejandro Jimenez <alejandro.j.jimenez@oracle.com>
> diff --git a/tests/qtest/libqos/meson.build b/tests/qtest/libqos/meson.build
> index 4a69acad0d..96f2fc48b4 100644
> --- a/tests/qtest/libqos/meson.build
> +++ b/tests/qtest/libqos/meson.build
> @@ -73,6 +73,9 @@ endif
>   if config_all_devices.has_key('CONFIG_RISCV_IOMMU')
>     libqos_srcs += files('riscv-iommu.c', 'qos-riscv-iommu.c')
>   endif
> +if config_all_devices.has_key('CONFIG_VTD')
> +  libqos_srcs += files('qos-intel-iommu.c')
> +endif
>   if config_all_devices.has_key('CONFIG_TPCI200')
>     libqos_srcs += files('tpci200.c')
>   endif
> diff --git a/tests/qtest/libqos/qos-intel-iommu.c b/tests/qtest/libqos/qos-intel-iommu.c
> new file mode 100644
> index 0000000000..b1baf5ea7c
> --- /dev/null
> +++ b/tests/qtest/libqos/qos-intel-iommu.c
> @@ -0,0 +1,454 @@
> +/*
> + * QOS Intel IOMMU (VT-d) Module Implementation
> + *
> + * This module provides Intel IOMMU-specific helper functions for libqos tests.
> + *
> + * Copyright (c) 2026 Fengyuan Yu <15fengyuan@gmail.com>
> + *
> + * SPDX-License-Identifier: GPL-2.0-or-later
> + */
> +
> +#include "qemu/osdep.h"
> +#include "hw/i386/intel_iommu_internal.h"
> +#include "tests/qtest/libqos/pci.h"
> +#include "qos-iommu-testdev.h"
> +#include "qos-intel-iommu.h"
> +
> +#define QVTD_AW_48BIT_ENCODING    2
> +
> +uint32_t qvtd_expected_dma_result(QVTDTestContext *ctx)
> +{
> +    return ctx->config.expected_result;
> +}
> +
> +uint32_t qvtd_build_dma_attrs(void)
> +{
> +    /*
> +     * VT-d obtains the Requester ID (Source ID) from PCI bus/devfn routing
> +     * via pci_device_iommu_address_space(), not from DMA attributes.
> +     *
> +     * For scalable mode, QEMU maps MemTxAttrs.pid==0 to PCI_NO_PASID,
> +     * then remaps PCI_NO_PASID to PASID_0 when root_scalable is set.
> +     * So returning 0 here implicitly selects PASID=0, which matches
> +     * the PASID entry we configure in qvtd_build_pasid_table_entry().
> +     *
> +     */
> +    return 0;
> +}

The comment is partially misleading.

The SID part is correct. But iommu-testdev does not program 
MemTxAttrs.pid( only program .secure and .space now), so returning 0 
here does not explicitly select PASID=0. PASID_0 is reached implicitly 
via VT-d’s no-PASID handling fallback, not via DMA_ATTRS.

I think the comment should be clarified to reflect this.  You may need 
check whether the related logic runs as your expectations. Expanding the 
DMA_ATTRS in iommu-testdev is open if you really need it.


Thanks,

Tao


