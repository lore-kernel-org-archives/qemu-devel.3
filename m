Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4328DC48BF8
	for <qemu-devel@archiver.kernel.org>; Tue, 20 Feb 2024 02:22:49 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rcFlt-0001H2-Hh; Mon, 19 Feb 2024 21:22:13 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1rcFlr-0001Go-Lh; Mon, 19 Feb 2024 21:22:11 -0500
Received: from mgamail.intel.com ([192.198.163.19])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1rcFlm-0002zk-Rr; Mon, 19 Feb 2024 21:22:11 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1708395726; x=1739931726;
 h=date:from:to:cc:subject:message-id:references:
 mime-version:content-transfer-encoding:in-reply-to;
 bh=wdKso9Yyh0fncbmY2mtBksRKA7a9Lr0g7IJql9iDKwc=;
 b=PtlFNVh4uoycgfgGrE0d49eITEhR5vfwVjYiIq+RjzqpuIBhIHi9Uhw8
 PpPNns67477uvt0HwxKKl0ecxws/yKAzvZml7UAIOfDX9EQsyvD0Ztz/v
 E1HNtS2I7eh1tM+ZPmNF1xqlP05EEAL8J39dDJmA5lPn70TbJkTpDK4QM
 5wZLffNHvo+6GcpswMKF0u0STAl0XVj8DXldapmRElkkdAy/mm+pNM64U
 OhCi9IFk50zIZ6kru3ibMZ+EnIHhWh+UGyOB2cgFXHt/2wi1qQEQRT7GR
 ZJSafIc8N6HdD/gisbw3dvTwS3YtjcEMOTO4cymdGcWySrA0T38XXo03A g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10989"; a="2346405"
X-IronPort-AV: E=Sophos;i="6.06,171,1705392000"; 
   d="scan'208";a="2346405"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
 by fmvoesa113.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 19 Feb 2024 18:22:04 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.06,171,1705392000"; 
   d="scan'208";a="9305282"
Received: from liuzhao-optiplex-7080.sh.intel.com (HELO localhost)
 ([10.239.160.36])
 by orviesa004.jf.intel.com with ESMTP; 19 Feb 2024 18:22:01 -0800
Date: Tue, 20 Feb 2024 10:35:40 +0800
From: Zhao Liu <zhao1.liu@intel.com>
To: Philippe =?iso-8859-1?Q?Mathieu-Daud=E9?= <philmd@linaro.org>
Cc: qemu-devel@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Igor Mammedov <imammedo@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>,
 Ani Sinha <anisinha@redhat.com>, Bernhard Beschow <shentey@gmail.com>,
 Eduardo Habkost <eduardo@habkost.net>, qemu-trivial@nongnu.org
Subject: Re: [PATCH 4/5] hw/acpi/ich9_tco: Include missing
 'migration/vmstate.h' header
Message-ID: <ZdQP/HaBa1MfRgIP@intel.com>
References: <20240219141412.71418-1-philmd@linaro.org>
 <20240219141412.71418-5-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20240219141412.71418-5-philmd@linaro.org>
Received-SPF: pass client-ip=192.198.163.19; envelope-from=zhao1.liu@intel.com;
 helo=mgamail.intel.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.072,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 SPF_HELO_NONE=0.001, T_SCC_BODY_TEXT_LINE=-0.01,
 T_SPF_TEMPERROR=0.01 autolearn=ham autolearn_force=no
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

On Mon, Feb 19, 2024 at 03:14:10PM +0100, Philippe Mathieu-Daudé wrote:
> Date: Mon, 19 Feb 2024 15:14:10 +0100
> From: Philippe Mathieu-Daudé <philmd@linaro.org>
> Subject: [PATCH 4/5] hw/acpi/ich9_tco: Include missing
>  'migration/vmstate.h' header
> X-Mailer: git-send-email 2.41.0
> 
> We need the VMStateDescription structure definition from
> "migration/vmstate.h" in order to declare vmstate_tco_io_sts.
> 
> Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
> ---
>  include/hw/acpi/ich9_tco.h | 1 +
>  1 file changed, 1 insertion(+)

Reviewed-by: Zhao Liu <zhao1.liu@intel.com>

> 
> diff --git a/include/hw/acpi/ich9_tco.h b/include/hw/acpi/ich9_tco.h
> index c4393caee0..2562a7cf39 100644
> --- a/include/hw/acpi/ich9_tco.h
> +++ b/include/hw/acpi/ich9_tco.h
> @@ -11,6 +11,7 @@
>  #define HW_ACPI_TCO_H
>  
>  #include "exec/memory.h"
> +#include "migration/vmstate.h"
>  
>  /* As per ICH9 spec, the internal timer has an error of ~0.6s on every tick */
>  #define TCO_TICK_NSEC 600000000LL
> -- 
> 2.41.0
> 
> 

