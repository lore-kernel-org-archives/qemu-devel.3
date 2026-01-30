Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5881ED73EB7
	for <qemu-devel@archiver.kernel.org>; Fri, 30 Jan 2026 03:47:43 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vlfTO-0005Dy-Rn; Thu, 29 Jan 2026 22:47:06 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <tangtao1634@phytium.com.cn>)
 id 1vlfTK-000569-RD; Thu, 29 Jan 2026 22:47:04 -0500
Received: from zg8tmty1ljiyny4xntqumjca.icoremail.net ([165.227.154.27])
 by eggs.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <tangtao1634@phytium.com.cn>)
 id 1vlfTI-0007sZ-Hh; Thu, 29 Jan 2026 22:47:02 -0500
Received: from prodtpl.icoremail.net (unknown [10.12.1.20])
 by hzbj-icmmx-6 (Coremail) with SMTP id AQAAfwAXHCSpKXxpkdZ_Aw--.36154S2;
 Fri, 30 Jan 2026 11:46:49 +0800 (CST)
Received: from [10.31.62.13] (unknown [218.76.62.144])
 by mail (Coremail) with SMTP id AQAAfwCX7eqiKXxpF7YXAA--.26907S2;
 Fri, 30 Jan 2026 11:46:43 +0800 (CST)
Message-ID: <2bb4ad3f-790f-438f-b2b3-60a8c91837e3@phytium.com.cn>
Date: Fri, 30 Jan 2026 11:46:42 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH v2 1/2] tests/qtest/libqos: Add RISC-V IOMMU helper
 library
To: Chao Liu <chao.liu.zevorn@gmail.com>,
 Alistair Francis <alistair.francis@wdc.com>,
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>,
 Palmer Dabbelt <palmer@dabbelt.com>, Weiwei Li <liwei1518@gmail.com>,
 Liu Zhiwei <zhiwei_liu@linux.alibaba.com>, Fabiano Rosas <farosas@suse.de>,
 Laurent Vivier <lvivier@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>
Cc: qemu-devel@nongnu.org, qemu-riscv@nongnu.org,
 hust-os-kernel-patches@googlegroups.com
References: <cover.1769678103.git.chao.liu.zevorn@gmail.com>
 <fff44d1db25e4a727c40048357059a58fcc58097.1769678103.git.chao.liu.zevorn@gmail.com>
From: Tao Tang <tangtao1634@phytium.com.cn>
In-Reply-To: <fff44d1db25e4a727c40048357059a58fcc58097.1769678103.git.chao.liu.zevorn@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CM-TRANSID: AQAAfwCX7eqiKXxpF7YXAA--.26907S2
X-CM-SenderInfo: pwdqw3tdrrljuu6sx5pwlxzhxfrphubq/1tbiAQAKBWl6bYMGHQABsp
Authentication-Results: hzbj-icmmx-6; spf=neutral smtp.mail=tangtao163
 4@phytium.com.cn;
X-Coremail-Antispam: 1Uk129KBjvJXoWxGF43JF43KFWxKr4xuFWDCFg_yoW5CryxpF
 1FkanYkayxt3WSqrnxWw12kF1rtan2kF1Uury3AF15Zryavr4jqFnrt340vrn3XaykXr4S
 vwsYgrn3Wr1Yqr7anT9S1TB71UUUUUDqnTZGkaVYY2UrUUUUj1kv1TuYvTs0mT0YCTnIWj
 DUYxn0WfASr-VFAU7a7-sFnT9fnUUIcSsGvfJ3UbIYCTnIWIevJa73UjIFyTuYvj4RJUUU
 UUUUU
Received-SPF: pass client-ip=165.227.154.27;
 envelope-from=tangtao1634@phytium.com.cn;
 helo=zg8tmty1ljiyny4xntqumjca.icoremail.net
X-Spam_score_int: -25
X-Spam_score: -2.6
X-Spam_bar: --
X-Spam_report: (-2.6 / 5.0 requ) BAYES_00=-1.9, RCVD_IN_DNSWL_LOW=-0.7,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

Hi Chao,

On 2026/1/29 17:39, Chao Liu wrote:
> Introduce a libqos helper module for RISC-V IOMMU testing with
> iommu-testdev. The helper provides routines to:
>
> - Build device contexts (DC) and 3-level page tables for SV39/SV39x4
> - Program command queue (CQ), fault queue (FQ), and DDTP registers
>    following the RISC-V IOMMU specification
> - Execute DMA translations and verify results
>
> The current implementation supports SV39 for S-stage and SV39x4 for
> G-stage translation. Support for SV48/SV48x4/SV57/SV57x4 can be added
> in future patches.
>
> Signed-off-by: Chao Liu <chao.liu.zevorn@gmail.com>
> ---
>   MAINTAINERS                          |   1 +
>   tests/qtest/libqos/meson.build       |   2 +-
>   tests/qtest/libqos/qos-riscv-iommu.c | 405 +++++++++++++++++++++++++++
>   tests/qtest/libqos/qos-riscv-iommu.h | 164 +++++++++++
>   4 files changed, 571 insertions(+), 1 deletion(-)
>   create mode 100644 tests/qtest/libqos/qos-riscv-iommu.c
>   create mode 100644 tests/qtest/libqos/qos-riscv-iommu.h
>
> diff --git a/MAINTAINERS b/MAINTAINERS
> index dccdf47888..830f56376b 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -3584,6 +3584,7 @@ M: Tao Tang <tangtao1634@phytium.com.cn>
>   S: Maintained
>   F: tests/qtest/libqos/qos-iommu*
>   F: tests/qtest/libqos/qos-smmuv3*
> +F: tests/qtest/libqos/qos-riscv-iommu*
>   
>   Device Fuzzing
>   M: Alexander Bulekov <alxndr@bu.edu>
> diff --git a/tests/qtest/libqos/meson.build b/tests/qtest/libqos/meson.build
> index b4daec808f..4a69acad0d 100644
> --- a/tests/qtest/libqos/meson.build
> +++ b/tests/qtest/libqos/meson.build
> @@ -71,7 +71,7 @@ if have_virtfs
>   endif
>   
>   if config_all_devices.has_key('CONFIG_RISCV_IOMMU')
> -  libqos_srcs += files('riscv-iommu.c')
> +  libqos_srcs += files('riscv-iommu.c', 'qos-riscv-iommu.c')
>   endif
>   if config_all_devices.has_key('CONFIG_TPCI200')
>     libqos_srcs += files('tpci200.c')
> diff --git a/tests/qtest/libqos/qos-riscv-iommu.c b/tests/qtest/libqos/qos-riscv-iommu.c
> new file mode 100644
> index 0000000000..6c60889eeb
> --- /dev/null
> +++ b/tests/qtest/libqos/qos-riscv-iommu.c
> @@ -0,0 +1,405 @@
> +/*
> + * QOS RISC-V IOMMU Module
> + *
> + * This module provides RISC-V IOMMU-specific helper functions for libqos tests,
> + * encapsulating RISC-V IOMMU setup, and assertions.
> + *
> + * Copyright (c) 2026 Chao Liu <chao.liu.zevorn@gmail.com>
> + *
> + * SPDX-License-Identifier: GPL-2.0-or-later
> + */
> +
> +#include "qemu/osdep.h"
> +#include "qemu/bitops.h"


This include is unnecessary: hw/misc/iommu-testdev.h (pulled in by 
qos-riscv-iommu.h) already includes hw/pci/pci.h, and hw/pci/pci.h 
itself includes bitops.h.

> +#include "hw/riscv/riscv-iommu-bits.h"
> +#include "tests/qtest/libqos/pci.h"

Same. qos-iommu-testdev.h has included tests/qtest/libqos/pci.h.


Besides

Reviewed-by: Tao Tang <tangtao1634@phytium.com.cn>


Thanks,

Tao


> +#include "qos-iommu-testdev.h"
> +#include "qos-riscv-iommu.h"
> +


