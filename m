Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1B633D73EB8
	for <qemu-devel@archiver.kernel.org>; Fri, 30 Jan 2026 03:49:57 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vlfVm-0002Um-48; Thu, 29 Jan 2026 22:49:34 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <tangtao1634@phytium.com.cn>)
 id 1vlfVi-0002DR-CF; Thu, 29 Jan 2026 22:49:31 -0500
Received: from sgoci-sdnproxy-4.icoremail.net ([129.150.39.64])
 by eggs.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <tangtao1634@phytium.com.cn>)
 id 1vlfVg-00081e-0I; Thu, 29 Jan 2026 22:49:30 -0500
Received: from prodtpl.icoremail.net (unknown [10.12.1.20])
 by hzbj-icmmx-7 (Coremail) with SMTP id AQAAfwBXcqg7Knxpn6aNBg--.87S2;
 Fri, 30 Jan 2026 11:49:15 +0800 (CST)
Received: from [10.31.62.13] (unknown [218.76.62.144])
 by mail (Coremail) with SMTP id AQAAfwB3z+w3KnxpRLYXAA--.42069S2;
 Fri, 30 Jan 2026 11:49:12 +0800 (CST)
Message-ID: <47268fe5-32cd-4d97-bdcd-2d349d3bfc2a@phytium.com.cn>
Date: Fri, 30 Jan 2026 11:49:11 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH v2 2/2] tests/qtest: Add RISC-V IOMMU bare-metal test
To: Chao Liu <chao.liu.zevorn@gmail.com>,
 Alistair Francis <alistair.francis@wdc.com>,
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>,
 Palmer Dabbelt <palmer@dabbelt.com>, Weiwei Li <liwei1518@gmail.com>,
 Liu Zhiwei <zhiwei_liu@linux.alibaba.com>, Fabiano Rosas <farosas@suse.de>,
 Laurent Vivier <lvivier@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>
Cc: qemu-devel@nongnu.org, qemu-riscv@nongnu.org,
 hust-os-kernel-patches@googlegroups.com
References: <cover.1769678103.git.chao.liu.zevorn@gmail.com>
 <7cc1e085432336463dd19e11212cda516b97a33e.1769678103.git.chao.liu.zevorn@gmail.com>
From: Tao Tang <tangtao1634@phytium.com.cn>
In-Reply-To: <7cc1e085432336463dd19e11212cda516b97a33e.1769678103.git.chao.liu.zevorn@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CM-TRANSID: AQAAfwB3z+w3KnxpRLYXAA--.42069S2
X-CM-SenderInfo: pwdqw3tdrrljuu6sx5pwlxzhxfrphubq/1tbiAQAKBWl6bYMGHQACsq
Authentication-Results: hzbj-icmmx-7; spf=neutral smtp.mail=tangtao163
 4@phytium.com.cn;
X-Coremail-Antispam: 1Uk129KBjvJXoW7Cr1DCF13tr18Cr4kKw15Jwb_yoW5JF1rpa
 4kCr1Skr4vyr1xW3WfXr1ayF1rWa1kCF4j9rW2qr15ZrWaqr40yrnFg348W3s7Jay8Xr4F
 kas2kF4fCr4FvrJanT9S1TB71UUUUUJqnTZGkaVYY2UrUUUUj1kv1TuYvTs0mT0YCTnIWj
 DUYxn0WfASr-VFAU7a7-sFnT9fnUUIcSsGvfJ3UbIYCTnIWIevJa73UjIFyTuYvj4RJUUU
 UUUUU
Received-SPF: pass client-ip=129.150.39.64;
 envelope-from=tangtao1634@phytium.com.cn; helo=sgoci-sdnproxy-4.icoremail.net
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, RCVD_IN_MSPIKE_H3=0.001,
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

Hi Chao,

On 2026/1/29 17:39, Chao Liu wrote:
> Add a qtest suite for the RISC-V IOMMU PCI device on the virt machine.
> The test exercises bare, S-stage, G-stage, and nested translation paths
> using iommu-testdev and the qos-riscv-iommu helpers.
>
> The test validates:
> - Device context (DC) configuration
> - SV39 page table walks for S-stage translation
> - SV39x4 page table walks for G-stage translation
> - Nested translation combining both stages
> - FCTL register constraints
>
> This provides regression coverage for the RISC-V IOMMU implementation
> without requiring a full guest OS boot.
>
> Signed-off-by: Chao Liu <chao.liu.zevorn@gmail.com>
> ---
>   MAINTAINERS                    |   1 +
>   tests/qtest/iommu-riscv-test.c | 279 +++++++++++++++++++++++++++++++++
>   tests/qtest/meson.build        |   5 +-
>   3 files changed, 284 insertions(+), 1 deletion(-)
>   create mode 100644 tests/qtest/iommu-riscv-test.c
>
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 830f56376b..73daaad841 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -349,6 +349,7 @@ F: common-user/host/riscv*
>   F: tests/functional/riscv32
>   F: tests/functional/riscv64
>   F: tests/tcg/riscv64/
> +F: tests/qtest/iommu-riscv-test.c
>   
>   RISC-V XThead* extensions
>   M: Christoph Muellner <christoph.muellner@vrull.eu>
> diff --git a/tests/qtest/iommu-riscv-test.c b/tests/qtest/iommu-riscv-test.c
> new file mode 100644
> index 0000000000..5a86b18db9
> --- /dev/null
> +++ b/tests/qtest/iommu-riscv-test.c
> @@ -0,0 +1,279 @@
> +/*
> + * QTest testcase for RISC-V IOMMU with iommu-testdev
> + *
> + * This QTest file is used to test the RISC-V IOMMU with iommu-testdev so that
> + * we can test RISC-V IOMMU without any guest kernel or firmware.
> + *
> + * Copyright (c) 2026 Chao Liu <chao.liu.zevorn@gmail.com>
> + *
> + * SPDX-License-Identifier: GPL-2.0-or-later
> + */
> +
> +#include "qemu/osdep.h"
> +#include "libqtest.h"
> +#include "libqos/pci.h"


libqtest.h and libqos/pci.h are redundant because they are already 
pulled in by libqos/generic-pcihost.h (libqos/pci.h itself includes 
libqtest.h)


Besides

Reviewed-by: Tao Tang <tangtao1634@phytium.com.cn>


Thanks,

Tao

> +#include "libqos/generic-pcihost.h"
> +#include "hw/pci/pci_regs.h"
> +#include "hw/misc/iommu-testdev.h"
> +#include "hw/riscv/riscv-iommu-bits.h"
> +#include "libqos/qos-riscv-iommu.h"
> +#include "libqos/riscv-iommu.h"
> +
> +#define DMA_LEN           4


