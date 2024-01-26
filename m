Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 95929C47422
	for <qemu-devel@archiver.kernel.org>; Fri, 26 Jan 2024 15:27:47 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rTO7E-0001fs-RG; Fri, 26 Jan 2024 10:27:37 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1rTO7C-0001bl-UN; Fri, 26 Jan 2024 10:27:34 -0500
Received: from mgamail.intel.com ([198.175.65.14])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1rTO7B-00050t-4I; Fri, 26 Jan 2024 10:27:34 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1706282853; x=1737818853;
 h=date:from:to:cc:subject:message-id:references:
 mime-version:in-reply-to;
 bh=HSIXVUMH2mtjboSNzNtc9GiwOdmX9t1cg5ZooTkHW30=;
 b=DkNySx1sAuSMtvJoPpSqCLhmm0grAma3UDgbOfNcW0D2vvIuyiiW/o+5
 k007YIUb6NgU3SPAz/D9h+GqndV1yn79zC79oBVYCb7CwjTVJ3BrL+CyA
 r4BnMDKwDQQAAS0pauKxRIvasDIumZvUpT35YfRLIhkOUtZCi2eOkv5FX
 BSO/AADy4EoflFW4Hc9/AupYjBGO55dC2tFVubF5keGJRUvuBuBAW8biJ
 54E82tYjtfYzXI0hpDnFty+MVlKos3Sn1HT+0nwyIfZ3DHPapvlRP9tFs
 CVQoxgw2jrmS11siyJQMMfzGnkHVXMMLzhHhpN8BxjFstOm2cpJF8NZWw Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10964"; a="2383052"
X-IronPort-AV: E=Sophos;i="6.05,216,1701158400"; 
   d="scan'208";a="2383052"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
 by orvoesa106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 26 Jan 2024 07:27:30 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.05,216,1701158400"; 
   d="scan'208";a="2624602"
Received: from liuzhao-optiplex-7080.sh.intel.com (HELO localhost)
 ([10.239.160.36])
 by fmviesa005.fm.intel.com with ESMTP; 26 Jan 2024 07:27:29 -0800
Date: Fri, 26 Jan 2024 23:40:32 +0800
From: Zhao Liu <zhao1.liu@intel.com>
To: Peter Maydell <peter.maydell@linaro.org>
Cc: qemu-devel@nongnu.org, qemu-trivial@nongnu.org
Subject: Re: [PATCH 05/10] acpi: Clean up includes
Message-ID: <ZbPScIxKDQhKqWS8@intel.com>
References: <20240125163408.1595135-1-peter.maydell@linaro.org>
 <20240125163408.1595135-6-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240125163408.1595135-6-peter.maydell@linaro.org>
Received-SPF: pass client-ip=198.175.65.14; envelope-from=zhao1.liu@intel.com;
 helo=mgamail.intel.com
X-Spam_score_int: -33
X-Spam_score: -3.4
X-Spam_bar: ---
X-Spam_report: (-3.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.313,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
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

On Thu, Jan 25, 2024 at 04:34:03PM +0000, Peter Maydell wrote:
> Date: Thu, 25 Jan 2024 16:34:03 +0000
> From: Peter Maydell <peter.maydell@linaro.org>
> Subject: [PATCH 05/10] acpi: Clean up includes
> X-Mailer: git-send-email 2.34.1
> 
> This commit was created with scripts/clean-includes:
>  ./scripts/clean-includes --git acpi include/hw/*/*acpi.h hw/*/*acpi.c
> 
> All .c should include qemu/osdep.h first.  The script performs three
> related cleanups:
> 
> * Ensure .c files include qemu/osdep.h first.
> * Including it in a .h is redundant, since the .c  already includes
>   it.  Drop such inclusions.
> * Likewise, including headers qemu/osdep.h includes is redundant.
>   Drop these, too.
> 
> Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
> ---
>  include/hw/nvram/fw_cfg_acpi.h  | 1 -
>  include/hw/virtio/virtio-acpi.h | 1 -
>  hw/nvram/fw_cfg-acpi.c          | 1 +
>  hw/virtio/virtio-acpi.c         | 1 +
>  4 files changed, 2 insertions(+), 2 deletions(-)

Reviewed-by: Zhao Liu <zhao1.liu@intel.com>

> 
> diff --git a/include/hw/nvram/fw_cfg_acpi.h b/include/hw/nvram/fw_cfg_acpi.h
> index b6553d86fcb..b39eb0490ff 100644
> --- a/include/hw/nvram/fw_cfg_acpi.h
> +++ b/include/hw/nvram/fw_cfg_acpi.h
> @@ -7,7 +7,6 @@
>  #ifndef FW_CFG_ACPI_H
>  #define FW_CFG_ACPI_H
>  
> -#include "qemu/osdep.h"
>  #include "exec/hwaddr.h"
>  
>  void fw_cfg_acpi_dsdt_add(Aml *scope, const MemMapEntry *fw_cfg_memmap);
> diff --git a/include/hw/virtio/virtio-acpi.h b/include/hw/virtio/virtio-acpi.h
> index 844e102569e..cace2a315f4 100644
> --- a/include/hw/virtio/virtio-acpi.h
> +++ b/include/hw/virtio/virtio-acpi.h
> @@ -6,7 +6,6 @@
>  #ifndef VIRTIO_ACPI_H
>  #define VIRTIO_ACPI_H
>  
> -#include "qemu/osdep.h"
>  #include "exec/hwaddr.h"
>  
>  void virtio_acpi_dsdt_add(Aml *scope, const hwaddr virtio_mmio_base,
> diff --git a/hw/nvram/fw_cfg-acpi.c b/hw/nvram/fw_cfg-acpi.c
> index 4e48baeaa01..58cdcd3121c 100644
> --- a/hw/nvram/fw_cfg-acpi.c
> +++ b/hw/nvram/fw_cfg-acpi.c
> @@ -4,6 +4,7 @@
>   *
>   */
>  
> +#include "qemu/osdep.h"
>  #include "hw/nvram/fw_cfg_acpi.h"
>  #include "hw/acpi/aml-build.h"
>  
> diff --git a/hw/virtio/virtio-acpi.c b/hw/virtio/virtio-acpi.c
> index e18cb38bdbe..230a6695001 100644
> --- a/hw/virtio/virtio-acpi.c
> +++ b/hw/virtio/virtio-acpi.c
> @@ -4,6 +4,7 @@
>   *
>   */
>  
> +#include "qemu/osdep.h"
>  #include "hw/virtio/virtio-acpi.h"
>  #include "hw/acpi/aml-build.h"
>  
> -- 
> 2.34.1
> 
> 

