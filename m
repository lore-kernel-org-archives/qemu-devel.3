Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 03164C48BF8
	for <qemu-devel@archiver.kernel.org>; Tue, 20 Feb 2024 02:16:59 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rcFg3-0007nA-FM; Mon, 19 Feb 2024 21:16:11 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1rcFg0-0007mq-MR; Mon, 19 Feb 2024 21:16:08 -0500
Received: from mgamail.intel.com ([192.198.163.18])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1rcFfx-00021q-0P; Mon, 19 Feb 2024 21:16:08 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1708395365; x=1739931365;
 h=date:from:to:cc:subject:message-id:references:
 mime-version:content-transfer-encoding:in-reply-to;
 bh=ggnvvpenWnRJJSu7Lbk4AM/jasmBCktKWjwiohXzcA8=;
 b=aeelmX9qdFVoWXGWqpdSY+VcoxZCaZRaYPmEkeF6fOEVbMzpx7L+B/Bu
 B5+llWBdYYmxkDOkqg40JHxrrF9kMXQ8yu23pB6l0Ric6n9ieLXcmVg2t
 AtAOgBFTD+ysO9U8nj8ty9oaS7658MFnBRBa6XNGQs2ubKfv990BtHBXJ
 OnxggiNjLazn18/NiEz9mW5JS6R0IFJeKjxFpP7mZ8RzrfTcfI7STEtTx
 pdg/IzpPtn7Jbvqc9tVj0OaYbA6uvSaPhtL7yx1OSxHYsCGzNbOrP09C/
 dRmhzOO/6HtzzxN3OFfQA4Ydnafw3eJ0OIfaOjTloWMBHxbUpA8aGrOcO A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10989"; a="2356332"
X-IronPort-AV: E=Sophos;i="6.06,171,1705392000"; 
   d="scan'208";a="2356332"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
 by fmvoesa112.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 19 Feb 2024 18:16:00 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10989"; a="912982943"
X-IronPort-AV: E=Sophos;i="6.06,171,1705392000"; d="scan'208";a="912982943"
Received: from liuzhao-optiplex-7080.sh.intel.com (HELO localhost)
 ([10.239.160.36])
 by fmsmga002.fm.intel.com with ESMTP; 19 Feb 2024 18:15:56 -0800
Date: Tue, 20 Feb 2024 10:29:36 +0800
From: Zhao Liu <zhao1.liu@intel.com>
To: Philippe =?iso-8859-1?Q?Mathieu-Daud=E9?= <philmd@linaro.org>
Cc: qemu-devel@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Igor Mammedov <imammedo@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>,
 Ani Sinha <anisinha@redhat.com>, Bernhard Beschow <shentey@gmail.com>,
 Eduardo Habkost <eduardo@habkost.net>, qemu-trivial@nongnu.org
Subject: Re: [PATCH 1/5] hw/acpi: Include missing 'qapi/qapi-types-acpi.h'
 generated header
Message-ID: <ZdQOkDgFMJ8nEEPi@intel.com>
References: <20240219141412.71418-1-philmd@linaro.org>
 <20240219141412.71418-2-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20240219141412.71418-2-philmd@linaro.org>
Received-SPF: pass client-ip=192.198.163.18; envelope-from=zhao1.liu@intel.com;
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

On Mon, Feb 19, 2024 at 03:14:07PM +0100, Philippe Mathieu-Daudé wrote:
> Date: Mon, 19 Feb 2024 15:14:07 +0100
> From: Philippe Mathieu-Daudé <philmd@linaro.org>
> Subject: [PATCH 1/5] hw/acpi: Include missing 'qapi/qapi-types-acpi.h'
>  generated header
> X-Mailer: git-send-email 2.41.0
> 
> ACPIOSTInfo is a QAPI generated structure:
> 
>   $ git grep -w ACPIOSTInfo
>   qapi/acpi.json:81:# @ACPIOSTInfo:
>   qapi/acpi.json:99:{ 'struct': 'ACPIOSTInfo',
>   qapi/acpi.json:109:# Return a list of ACPIOSTInfo for devices that support status
> 
> Include the "qapi/qapi-types-acpi.h" header to avoid the following
> errors when including "hw/acpi/cpu.h" or "hw/acpi/memory_hotplug.h"
> elsewhere:
> 
>   include/hw/acpi/cpu.h:67:52: error: unknown type name 'ACPIOSTInfoList'
>   void acpi_cpu_ospm_status(CPUHotplugState *cpu_st, ACPIOSTInfoList ***list);
>                                                      ^
>   include/hw/acpi/memory_hotplug.h:51:55: error: unknown type name 'ACPIOSTInfoList'
>   void acpi_memory_ospm_status(MemHotplugState *mem_st, ACPIOSTInfoList ***list);
>                                                         ^
> 
> Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
> ---
>  include/hw/acpi/cpu.h            | 1 +
>  include/hw/acpi/memory_hotplug.h | 1 +
>  2 files changed, 2 insertions(+)

Reviewed-by: Zhao Liu <zhao1.liu@intel.com>

> 
> diff --git a/include/hw/acpi/cpu.h b/include/hw/acpi/cpu.h
> index bc901660fb..e011d01adf 100644
> --- a/include/hw/acpi/cpu.h
> +++ b/include/hw/acpi/cpu.h
> @@ -12,6 +12,7 @@
>  #ifndef ACPI_CPU_H
>  #define ACPI_CPU_H
>  
> +#include "qapi/qapi-types-acpi.h"
>  #include "hw/qdev-core.h"
>  #include "hw/acpi/acpi.h"
>  #include "hw/acpi/aml-build.h"
> diff --git a/include/hw/acpi/memory_hotplug.h b/include/hw/acpi/memory_hotplug.h
> index dfe9cf3fde..38841d7b06 100644
> --- a/include/hw/acpi/memory_hotplug.h
> +++ b/include/hw/acpi/memory_hotplug.h
> @@ -1,6 +1,7 @@
>  #ifndef QEMU_HW_ACPI_MEMORY_HOTPLUG_H
>  #define QEMU_HW_ACPI_MEMORY_HOTPLUG_H
>  
> +#include "qapi/qapi-types-acpi.h"
>  #include "hw/qdev-core.h"
>  #include "hw/acpi/acpi.h"
>  #include "hw/acpi/aml-build.h"
> -- 
> 2.41.0
> 
> 

