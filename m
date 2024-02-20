Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7AADCC48BF8
	for <qemu-devel@archiver.kernel.org>; Tue, 20 Feb 2024 02:32:26 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rcFvD-0003h4-U2; Mon, 19 Feb 2024 21:31:52 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1rcFv8-0003gb-8S; Mon, 19 Feb 2024 21:31:46 -0500
Received: from mgamail.intel.com ([198.175.65.11])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1rcFv4-0004lU-2y; Mon, 19 Feb 2024 21:31:45 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1708396302; x=1739932302;
 h=date:from:to:cc:subject:message-id:references:
 mime-version:content-transfer-encoding:in-reply-to;
 bh=lupXvcMC5x30SUwTP4I8Mb7Ore8HGeqzgojVyTH4XrQ=;
 b=S8CHn3NCmmykug92TVOeXQuS8pwRrhpcGXTdJ3585hlpQ4rziIXBBilg
 pD8tfs3N2lKkh1DeRkAu64YTXwrlicifwcOLRsbn1k/9d5YTS0SpbCuxd
 Q7VOq4c/STph2NNxEQWWG+Sa0GaVTXaRSnx4XdUpD9sdPJkbjJwKxSK/L
 v3A5hxX+T41LD8J72u+5/XFyxDU2WVkimEA+fxoJM+rMZsJaGLF6qN2MZ
 Ftr6orFkiTUjh2Pp4rZGRyK9jft8Jsi47XriebMQUp9C0m5f6ZFoKnE7M
 k7NJxtn3Xyek3HODWvAqwtm6ib+Fda3iYZnj9xf5MjHBIZFiJqFedOLhW w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10989"; a="13035178"
X-IronPort-AV: E=Sophos;i="6.06,171,1705392000"; d="scan'208";a="13035178"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
 by orvoesa103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 19 Feb 2024 18:31:38 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.06,171,1705392000"; 
   d="scan'208";a="4608640"
Received: from liuzhao-optiplex-7080.sh.intel.com (HELO localhost)
 ([10.239.160.36])
 by fmviesa009.fm.intel.com with ESMTP; 19 Feb 2024 18:31:35 -0800
Date: Tue, 20 Feb 2024 10:45:14 +0800
From: Zhao Liu <zhao1.liu@intel.com>
To: Philippe =?iso-8859-1?Q?Mathieu-Daud=E9?= <philmd@linaro.org>
Cc: qemu-devel@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Igor Mammedov <imammedo@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>,
 Ani Sinha <anisinha@redhat.com>, Bernhard Beschow <shentey@gmail.com>,
 Eduardo Habkost <eduardo@habkost.net>, qemu-trivial@nongnu.org
Subject: Re: [PATCH 5/5] hw/i386/q35: Include missing 'hw/acpi/acpi.h' header
Message-ID: <ZdQSOiQiRxoEoR58@intel.com>
References: <20240219141412.71418-1-philmd@linaro.org>
 <20240219141412.71418-6-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20240219141412.71418-6-philmd@linaro.org>
Received-SPF: pass client-ip=198.175.65.11; envelope-from=zhao1.liu@intel.com;
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

On Mon, Feb 19, 2024 at 03:14:11PM +0100, Philippe Mathieu-Daudé wrote:
> Date: Mon, 19 Feb 2024 15:14:11 +0100
> From: Philippe Mathieu-Daudé <philmd@linaro.org>
> Subject: [PATCH 5/5] hw/i386/q35: Include missing 'hw/acpi/acpi.h' header
> X-Mailer: git-send-email 2.41.0
> 
> "hw/acpi/acpi.h" is implicitly included.
> Included it

I'm guessing it's an imperative and shouldn't be in passive form. ;-) So,

s/Included/Include/

> explicitly to avoid when refactoring headers:

s/to avoid/to avoid the following error/

> 
> hw/i386/pc_q35.c:209:43: error: use of undeclared identifier 'ACPI_PM_PROP_ACPI_PCIHP_BRIDGE'
>                               ACPI_PM_PROP_ACPI_PCIHP_BRIDGE,
>                               ^
> 
> Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
> ---
>  hw/i386/pc_q35.c | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/hw/i386/pc_q35.c b/hw/i386/pc_q35.c
> index d346fa3b1d..a91f414922 100644
> --- a/hw/i386/pc_q35.c
> +++ b/hw/i386/pc_q35.c
> @@ -58,6 +58,7 @@
>  #include "hw/hyperv/vmbus-bridge.h"
>  #include "hw/mem/nvdimm.h"
>  #include "hw/i386/acpi-build.h"
> +#include "hw/acpi/acpi.h"
>  #include "target/i386/cpu.h"

Here it is unordered, and similarly, does it need to be sorted
alphabetically here?

Regards,
Zhao

>  
>  /* ICH9 AHCI has 6 ports */
> -- 
> 2.41.0
> 
> 

