Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1E59BC48BF6
	for <qemu-devel@archiver.kernel.org>; Mon, 26 Feb 2024 09:16:33 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1reX5v-000671-Df; Mon, 26 Feb 2024 04:16:19 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1reX5o-0005YD-7x
 for qemu-devel@nongnu.org; Mon, 26 Feb 2024 04:16:13 -0500
Received: from mgamail.intel.com ([198.175.65.18])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1reX5l-0005Ed-GK
 for qemu-devel@nongnu.org; Mon, 26 Feb 2024 04:16:10 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1708938970; x=1740474970;
 h=date:from:to:cc:subject:message-id:references:
 mime-version:content-transfer-encoding:in-reply-to;
 bh=D3VCQcSIYtmJo33WujhjaN36kDnBJPCB3R1M3Sh3ntE=;
 b=XYxY2ILO8uU1EybSd6sJo+bA0tMaUA1ReG8zOjv5F5XWcYVWJXd7UKlH
 ykYIHq2y+V29vSvkjEOsG7V7IbS3vYcDYIjLcbh2Q5FdKXeXwZhCj5zgg
 RTuDR/yRhBVc/rQHWf/utFBQE1modtG+BpUX3F253lcTd3nmP0iAHGCzT
 9sE3MK1aexE4Cz29QODt/YHF2YR/xpjj4oUtTBzixDiES02YIyZZKoLIG
 I/Oh/EZbGhCynxaAGuujgkA72GOsmR75BE4dRkX/ocMyR+G9SfXYzYbDj
 gJs2Zp2/xo+FSbKP3DUYZllDZXCOmE+y6z7C8gtRSPRaiIb0zbt/oTQLi w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10995"; a="3330817"
X-IronPort-AV: E=Sophos;i="6.06,185,1705392000"; 
   d="scan'208";a="3330817"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
 by orvoesa110.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 26 Feb 2024 01:16:08 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.06,185,1705392000"; 
   d="scan'208";a="6749314"
Received: from liuzhao-optiplex-7080.sh.intel.com (HELO localhost)
 ([10.239.160.36])
 by fmviesa008.fm.intel.com with ESMTP; 26 Feb 2024 01:16:05 -0800
Date: Mon, 26 Feb 2024 17:29:47 +0800
From: Zhao Liu <zhao1.liu@intel.com>
To: Philippe =?iso-8859-1?Q?Mathieu-Daud=E9?= <philmd@linaro.org>
Cc: qemu-devel@nongnu.org, Richard Henderson <richard.henderson@linaro.org>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Igor Mammedov <imammedo@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Ani Sinha <anisinha@redhat.com>, Eduardo Habkost <eduardo@habkost.net>,
 "Michael S. Tsirkin" <mst@redhat.com>
Subject: Re: [PATCH v2 1/2] hw/acpi/ich9: Include missing headers
Message-ID: <ZdxaC8aTdbo5hh9A@intel.com>
References: <20240226090600.31952-1-philmd@linaro.org>
 <20240226090600.31952-2-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20240226090600.31952-2-philmd@linaro.org>
Received-SPF: pass client-ip=198.175.65.18; envelope-from=zhao1.liu@intel.com;
 helo=mgamail.intel.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.097,
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

On Mon, Feb 26, 2024 at 10:05:59AM +0100, Philippe Mathieu-Daudé wrote:
> Date: Mon, 26 Feb 2024 10:05:59 +0100
> From: Philippe Mathieu-Daudé <philmd@linaro.org>
> Subject: [PATCH v2 1/2] hw/acpi/ich9: Include missing headers
> X-Mailer: git-send-email 2.41.0
> 
> The ICH9LPCPMRegs structure has MemoryRegion and
> Notifier fields, so requires the "qemu/notify.h"

Just nit ;-)

s/requires/it requires/

> and "exec/memory.h" headers.
> 
> However nothing from "hw/acpi/acpi_dev_interface.h"
> is required, so reduce its inclusion to hw/acpi/ich9.c
> source file where it is used.
> 
> Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
> ---
>  include/hw/acpi/ich9.h | 3 ++-
>  hw/acpi/ich9.c         | 2 +-
>  2 files changed, 3 insertions(+), 2 deletions(-)

Thanks!

Reviewed-by: Zhao Liu <zhao1.liu@intel.com>

> 
> diff --git a/include/hw/acpi/ich9.h b/include/hw/acpi/ich9.h
> index 2faf7f0cae..215de3c91f 100644
> --- a/include/hw/acpi/ich9.h
> +++ b/include/hw/acpi/ich9.h
> @@ -21,12 +21,13 @@
>  #ifndef HW_ACPI_ICH9_H
>  #define HW_ACPI_ICH9_H
>  
> +#include "qemu/notify.h"
> +#include "exec/memory.h"
>  #include "hw/acpi/acpi.h"
>  #include "hw/acpi/cpu_hotplug.h"
>  #include "hw/acpi/cpu.h"
>  #include "hw/acpi/pcihp.h"
>  #include "hw/acpi/memory_hotplug.h"
> -#include "hw/acpi/acpi_dev_interface.h"
>  #include "hw/acpi/ich9_tco.h"
>  
>  #define ACPI_PCIHP_ADDR_ICH9 0x0cc0
> diff --git a/hw/acpi/ich9.c b/hw/acpi/ich9.c
> index 573d032e8e..6205de6046 100644
> --- a/hw/acpi/ich9.c
> +++ b/hw/acpi/ich9.c
> @@ -34,8 +34,8 @@
>  #include "sysemu/reset.h"
>  #include "sysemu/runstate.h"
>  #include "hw/acpi/acpi.h"
> +#include "hw/acpi/acpi_dev_interface.h"
>  #include "hw/acpi/ich9_tco.h"
> -
>  #include "hw/southbridge/ich9.h"
>  #include "hw/mem/pc-dimm.h"
>  #include "hw/mem/nvdimm.h"
> -- 
> 2.41.0
> 

