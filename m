Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1DC59C54E49
	for <qemu-devel@archiver.kernel.org>; Mon, 26 Feb 2024 09:17:31 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1reX6R-0001N5-0w; Mon, 26 Feb 2024 04:16:51 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1reX6O-000180-Vr
 for qemu-devel@nongnu.org; Mon, 26 Feb 2024 04:16:49 -0500
Received: from mgamail.intel.com ([192.198.163.17])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1reX6N-0005Ia-2x
 for qemu-devel@nongnu.org; Mon, 26 Feb 2024 04:16:48 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1708939007; x=1740475007;
 h=date:from:to:cc:subject:message-id:references:
 mime-version:content-transfer-encoding:in-reply-to;
 bh=qo09Acd2MIkytaUm6uMem8Jq45c+4/AqxqE1ouSNAc4=;
 b=NhY7zba2YRq0DgTREsCir06oywfr5HPaj6No7eTtrmeilwNninsMn7Jg
 6c05qPAQOIadVy6AbH75XSvgvBeaX45x7Bp0k/56koZD2S29vdtbyYRuY
 YIVY4cc53Aef21I/+AAkF9CzDJYPjIlHj0ONnHII4w+Hdv+UW7KMau7GN
 hwM968g7kG1X+88jDhLGVSNr91wpSnFGhFxhZdZ5twzD2UQDf1YdgHF10
 NlSuih0T8nrEsvR+WAu9ayQa5EP9+xt5QWf0YEmLWkC6iCYzxPZ6ee4IR
 6bYD8vGF59y+18FXK+o2k1b96Zpt5jEWPk/X+oFgD4aJQsmhtMDg61IAE g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10995"; a="3053290"
X-IronPort-AV: E=Sophos;i="6.06,185,1705392000"; 
   d="scan'208";a="3053290"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
 by fmvoesa111.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 26 Feb 2024 01:16:42 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.06,185,1705392000"; d="scan'208";a="11248675"
Received: from liuzhao-optiplex-7080.sh.intel.com (HELO localhost)
 ([10.239.160.36])
 by fmviesa004.fm.intel.com with ESMTP; 26 Feb 2024 01:16:40 -0800
Date: Mon, 26 Feb 2024 17:30:22 +0800
From: Zhao Liu <zhao1.liu@intel.com>
To: Philippe =?iso-8859-1?Q?Mathieu-Daud=E9?= <philmd@linaro.org>
Cc: qemu-devel@nongnu.org, Richard Henderson <richard.henderson@linaro.org>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Igor Mammedov <imammedo@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Ani Sinha <anisinha@redhat.com>, Eduardo Habkost <eduardo@habkost.net>,
 "Michael S. Tsirkin" <mst@redhat.com>
Subject: Re: [PATCH v2 2/2] hw/i386/q35: Include missing 'hw/acpi/acpi.h'
 header
Message-ID: <ZdxaLk24J/2ol+Ch@intel.com>
References: <20240226090600.31952-1-philmd@linaro.org>
 <20240226090600.31952-3-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20240226090600.31952-3-philmd@linaro.org>
Received-SPF: pass client-ip=192.198.163.17; envelope-from=zhao1.liu@intel.com;
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

On Mon, Feb 26, 2024 at 10:06:00AM +0100, Philippe Mathieu-Daudé wrote:
> Date: Mon, 26 Feb 2024 10:06:00 +0100
> From: Philippe Mathieu-Daudé <philmd@linaro.org>
> Subject: [PATCH v2 2/2] hw/i386/q35: Include missing 'hw/acpi/acpi.h' header
> X-Mailer: git-send-email 2.41.0
> 
> "hw/acpi/acpi.h" is implicitly included. Include it
> explicitly to avoid the following error when refactoring
> headers:
> 
> hw/i386/pc_q35.c:209:43: error: use of undeclared identifier 'ACPI_PM_PROP_ACPI_PCIHP_BRIDGE'
>                               ACPI_PM_PROP_ACPI_PCIHP_BRIDGE,
>                               ^
> 
> Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
> ---
>  hw/i386/pc_q35.c | 1 +
>  1 file changed, 1 insertion(+)

Thanks!

Reviewed-by: Zhao Liu <zhao1.liu@intel.com>

> 
> diff --git a/hw/i386/pc_q35.c b/hw/i386/pc_q35.c
> index e0b3f55a02..45a4102e75 100644
> --- a/hw/i386/pc_q35.c
> +++ b/hw/i386/pc_q35.c
> @@ -30,6 +30,7 @@
>  
>  #include "qemu/osdep.h"
>  #include "qemu/units.h"
> +#include "hw/acpi/acpi.h"
>  #include "hw/char/parallel-isa.h"
>  #include "hw/loader.h"
>  #include "hw/i2c/smbus_eeprom.h"
> -- 
> 2.41.0
> 

