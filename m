Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E8820C3DA4A
	for <qemu-devel@archiver.kernel.org>; Wed, 21 Aug 2024 01:07:39 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sgZo4-00067R-It; Tue, 20 Aug 2024 21:06:37 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <sstabellini@kernel.org>)
 id 1sgZns-00063U-GN; Tue, 20 Aug 2024 21:06:25 -0400
Received: from dfw.source.kernel.org ([139.178.84.217])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <sstabellini@kernel.org>)
 id 1sgZno-0004Kx-Vf; Tue, 20 Aug 2024 21:06:22 -0400
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by dfw.source.kernel.org (Postfix) with ESMTP id DCE9260F8B;
 Wed, 21 Aug 2024 01:06:18 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B7532C4AF09;
 Wed, 21 Aug 2024 01:06:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1724202378;
 bh=BH13lVKJeuyYp6L1+dnUtBn/qLzJxA6G2U25oUKFM4I=;
 h=Date:From:To:cc:Subject:In-Reply-To:References:From;
 b=ZxYLv8Q6Y3WJJSFg30UoNe13lZII8LCgE6umdvgR6zt6BDmswGS45cenceElKsTmQ
 CPNB49rZ21GTH0S1NK8rCAQpWowBtU66rWXV2yhPk9tM7uedSMzanFk8lXN0Xp3tPS
 vJEGax8nAJQ0AKB83On5f/M1SxFJEdoInu7p6qKjwTOobZaUTrlXYC45TqD7IDr0Km
 8De3/KVo2yNGF9NWWG6jNUnB6eY6+EuAN2hece54HuzRlkoCQFUMpMsosC/++QwxZB
 AFutFtDqqve8dJOHx+sIywc+UPI6OcvBZG6HIDUkoHs5P1/lJm9iKH6dIR+dkOWGL0
 qqELwFAvYsUYQ==
Date: Tue, 20 Aug 2024 18:06:15 -0700 (PDT)
From: Stefano Stabellini <sstabellini@kernel.org>
X-X-Sender: sstabellini@ubuntu-linux-20-04-desktop
To: "Edgar E. Iglesias" <edgar.iglesias@gmail.com>
cc: qemu-devel@nongnu.org, sstabellini@kernel.org, anthony@xenproject.org, 
 paul@xen.org, peter.maydell@linaro.org, alex.bennee@linaro.org, 
 xenia.ragiadakou@amd.com, jason.andryuk@amd.com, edgar.iglesias@amd.com, 
 xen-devel@lists.xenproject.org, qemu-arm@nongnu.org
Subject: Re: [PATCH v2 06/12] hw/arm: xenpvh: Move stubbed functions to
 xen-stubs.c
In-Reply-To: <20240820142949.533381-7-edgar.iglesias@gmail.com>
Message-ID: <alpine.DEB.2.22.394.2408201806100.298534@ubuntu-linux-20-04-desktop>
References: <20240820142949.533381-1-edgar.iglesias@gmail.com>
 <20240820142949.533381-7-edgar.iglesias@gmail.com>
User-Agent: Alpine 2.22 (DEB 394 2020-01-19)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Received-SPF: pass client-ip=139.178.84.217;
 envelope-from=sstabellini@kernel.org; helo=dfw.source.kernel.org
X-Spam_score_int: -72
X-Spam_score: -7.3
X-Spam_bar: -------
X-Spam_report: (-7.3 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.144,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_HI=-5, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

On Tue, 20 Aug 2024, Edgar E. Iglesias wrote:
> From: "Edgar E. Iglesias" <edgar.iglesias@amd.com>
> 
> Signed-off-by: Edgar E. Iglesias <edgar.iglesias@amd.com>


Reviewed-by: Stefano Stabellini <sstabellini@kernel.org>


> ---
>  hw/arm/meson.build |  5 ++++-
>  hw/arm/xen-stubs.c | 32 ++++++++++++++++++++++++++++++++
>  hw/arm/xen_arm.c   | 20 --------------------
>  3 files changed, 36 insertions(+), 21 deletions(-)
>  create mode 100644 hw/arm/xen-stubs.c
> 
> diff --git a/hw/arm/meson.build b/hw/arm/meson.build
> index 0c07ab522f..074612b40c 100644
> --- a/hw/arm/meson.build
> +++ b/hw/arm/meson.build
> @@ -59,7 +59,10 @@ arm_ss.add(when: 'CONFIG_FSL_IMX7', if_true: files('fsl-imx7.c', 'mcimx7d-sabre.
>  arm_ss.add(when: 'CONFIG_ARM_SMMUV3', if_true: files('smmuv3.c'))
>  arm_ss.add(when: 'CONFIG_FSL_IMX6UL', if_true: files('fsl-imx6ul.c', 'mcimx6ul-evk.c'))
>  arm_ss.add(when: 'CONFIG_NRF51_SOC', if_true: files('nrf51_soc.c'))
> -arm_ss.add(when: 'CONFIG_XEN', if_true: files('xen_arm.c'))
> +arm_ss.add(when: 'CONFIG_XEN', if_true: files(
> +  'xen-stubs.c',
> +  'xen_arm.c',
> +))
>  
>  system_ss.add(when: 'CONFIG_ARM_SMMUV3', if_true: files('smmu-common.c'))
>  system_ss.add(when: 'CONFIG_CHEETAH', if_true: files('palm.c'))
> diff --git a/hw/arm/xen-stubs.c b/hw/arm/xen-stubs.c
> new file mode 100644
> index 0000000000..4ac6a56a96
> --- /dev/null
> +++ b/hw/arm/xen-stubs.c
> @@ -0,0 +1,32 @@
> +/*
> + * Stubs for unimplemented Xen functions for ARM.
> + *
> + * SPDX-License-Identifier: MIT
> + */
> +
> +#include "qemu/osdep.h"
> +#include "qemu/error-report.h"
> +#include "qapi/qapi-commands-migration.h"
> +#include "hw/boards.h"
> +#include "sysemu/sysemu.h"
> +#include "hw/xen/xen-hvm-common.h"
> +#include "hw/xen/arch_hvm.h"
> +
> +void arch_handle_ioreq(XenIOState *state, ioreq_t *req)
> +{
> +    hw_error("Invalid ioreq type 0x%x\n", req->type);
> +    return;
> +}
> +
> +void arch_xen_set_memory(XenIOState *state, MemoryRegionSection *section,
> +                         bool add)
> +{
> +}
> +
> +void xen_hvm_modified_memory(ram_addr_t start, ram_addr_t length)
> +{
> +}
> +
> +void qmp_xen_set_global_dirty_log(bool enable, Error **errp)
> +{
> +}
> diff --git a/hw/arm/xen_arm.c b/hw/arm/xen_arm.c
> index 16b3f00992..f0868e7be5 100644
> --- a/hw/arm/xen_arm.c
> +++ b/hw/arm/xen_arm.c
> @@ -115,26 +115,6 @@ static void xen_init_ram(MachineState *machine)
>      memory_region_add_subregion(sysmem, XEN_GRANT_ADDR_OFF, &xen_grants);
>  }
>  
> -void arch_handle_ioreq(XenIOState *state, ioreq_t *req)
> -{
> -    hw_error("Invalid ioreq type 0x%x\n", req->type);
> -
> -    return;
> -}
> -
> -void arch_xen_set_memory(XenIOState *state, MemoryRegionSection *section,
> -                         bool add)
> -{
> -}
> -
> -void xen_hvm_modified_memory(ram_addr_t start, ram_addr_t length)
> -{
> -}
> -
> -void qmp_xen_set_global_dirty_log(bool enable, Error **errp)
> -{
> -}
> -
>  #ifdef CONFIG_TPM
>  static void xen_enable_tpm(XenArmState *xam)
>  {
> -- 
> 2.43.0
> 

