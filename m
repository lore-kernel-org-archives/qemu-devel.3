Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4D7B3C48BF8
	for <qemu-devel@archiver.kernel.org>; Tue, 20 Feb 2024 02:20:26 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rcFjw-0000Qv-Pj; Mon, 19 Feb 2024 21:20:12 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1rcFjv-0000Qj-Ul; Mon, 19 Feb 2024 21:20:11 -0500
Received: from mgamail.intel.com ([192.198.163.16])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1rcFjt-0002cB-Ek; Mon, 19 Feb 2024 21:20:11 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1708395609; x=1739931609;
 h=date:from:to:cc:subject:message-id:references:
 mime-version:content-transfer-encoding:in-reply-to;
 bh=eIxhzRNIhpXSQjjzS7oPfx/F2HmtZfaZ6GhUtvFpXHs=;
 b=bHmhORv2GoUHgr4hkX14ORKW5O9pxBQTKft99FbwSe3C4uU6L7HVZwzZ
 byVAqZPONibDtiDe7wkd6EO/gzPuF3HRXHAk4hA4lMoPX0v21Y2nirrIs
 9QZ4RFXTR7mYHhBjQ04IZHhFn4Ha1qccqDyEmjnCq+7/6hTOnv7N32Mad
 VAtALDTZaNzdigwoedsfKrBEPOYFNxmAxiZZn8f8wWe9hA8+rb5VPpeMn
 H3/Ew7vvT60XbDkxIiEmyxmWM+OJjYtNPRn8jHGHOVYe9v/UYdNJ7ec8x
 fph50nmjWZNsP8+uKbXl9jfOzZgeNW72LVe90sbnIf+P20B7PV4m1+zym g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10989"; a="2938170"
X-IronPort-AV: E=Sophos;i="6.06,171,1705392000"; 
   d="scan'208";a="2938170"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
 by fmvoesa110.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 19 Feb 2024 18:20:06 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10989"; a="827086514"
X-IronPort-AV: E=Sophos;i="6.06,171,1705392000"; d="scan'208";a="827086514"
Received: from liuzhao-optiplex-7080.sh.intel.com (HELO localhost)
 ([10.239.160.36])
 by orsmga001.jf.intel.com with ESMTP; 19 Feb 2024 18:20:02 -0800
Date: Tue, 20 Feb 2024 10:33:41 +0800
From: Zhao Liu <zhao1.liu@intel.com>
To: Philippe =?iso-8859-1?Q?Mathieu-Daud=E9?= <philmd@linaro.org>
Cc: qemu-devel@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Igor Mammedov <imammedo@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>,
 Ani Sinha <anisinha@redhat.com>, Bernhard Beschow <shentey@gmail.com>,
 Eduardo Habkost <eduardo@habkost.net>, qemu-trivial@nongnu.org
Subject: Re: [PATCH 3/5] hw/acpi/ich9: Include missing headers
Message-ID: <ZdQPhcB28MsDdFfu@intel.com>
References: <20240219141412.71418-1-philmd@linaro.org>
 <20240219141412.71418-4-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20240219141412.71418-4-philmd@linaro.org>
Received-SPF: pass client-ip=192.198.163.16; envelope-from=zhao1.liu@intel.com;
 helo=mgamail.intel.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.072,
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

Hi Philippe,

On Mon, Feb 19, 2024 at 03:14:09PM +0100, Philippe Mathieu-Daudé wrote:
> Date: Mon, 19 Feb 2024 15:14:09 +0100
> From: Philippe Mathieu-Daudé <philmd@linaro.org>
> Subject: [PATCH 3/5] hw/acpi/ich9: Include missing headers
> X-Mailer: git-send-email 2.41.0
> 
> The ICH9LPCPMRegs structure has MemoryRegion and
> Notifier fields, so requires the "qemu/notify.h"
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
> index 573d032e8e..be375a8b9d 100644
> --- a/hw/acpi/ich9.c
> +++ b/hw/acpi/ich9.c
> @@ -35,7 +35,7 @@
>  #include "sysemu/runstate.h"
>  #include "hw/acpi/acpi.h"
>  #include "hw/acpi/ich9_tco.h"
> -
> +#include "hw/acpi/acpi_dev_interface.h"

Do we have the requirement for included header ordering?
If so, it would be better to put it before "hw/acpi/ich9_tco.h".

-Zhao

>  #include "hw/southbridge/ich9.h"
>  #include "hw/mem/pc-dimm.h"
>  #include "hw/mem/nvdimm.h"
> -- 
> 2.41.0
> 
> 

