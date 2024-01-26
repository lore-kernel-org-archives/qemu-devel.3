Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4C918C47422
	for <qemu-devel@archiver.kernel.org>; Fri, 26 Jan 2024 15:30:45 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rTOA1-0006mx-6J; Fri, 26 Jan 2024 10:30:29 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1rTO9y-0006iD-9A; Fri, 26 Jan 2024 10:30:26 -0500
Received: from mgamail.intel.com ([198.175.65.11])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1rTO9w-0005XU-Ii; Fri, 26 Jan 2024 10:30:26 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1706283024; x=1737819024;
 h=date:from:to:cc:subject:message-id:references:
 mime-version:in-reply-to;
 bh=McUKHkMlnU0JiR7+M/tnoNjT6O5GTPjhOSszx7cJHEI=;
 b=T0wlDbl8l+yt2X8MCALzSAsIAo4+B+CioK1ZvNnjrqMGBn5zyPRRsL1z
 dIG+4gh4QZL8wQ0y5pgofcM1Sgmh4DRdpWLymf7t9HeGvpwukMgPNfjIR
 KVPOChqZKbliM6i3tx5LgFG5astDHpx0M45pVz5CjE05Qqq5ZRJmP0jms
 0lk/HyqHXJS78mH2aPQHO9H4/mVZHrpAnR5PnzmU0GV7LQqgzax0nBuMQ
 D0hrYHeNIbQlXweN2EgtRzNehgWoiDj9fX9nFvCu9KqfKWO53u9Iy/d+z
 VsWRvh/aQ/4m6xzusSAWy8IRiGCREXYNLFw+ScaSmPbim+WstpOzcNiXF A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10964"; a="9153735"
X-IronPort-AV: E=Sophos;i="6.05,216,1701158400"; 
   d="scan'208";a="9153735"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
 by orvoesa103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 26 Jan 2024 07:30:22 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10964"; a="821174498"
X-IronPort-AV: E=Sophos;i="6.05,216,1701158400"; d="scan'208";a="821174498"
Received: from liuzhao-optiplex-7080.sh.intel.com (HELO localhost)
 ([10.239.160.36])
 by orsmga001.jf.intel.com with ESMTP; 26 Jan 2024 07:30:21 -0800
Date: Fri, 26 Jan 2024 23:43:24 +0800
From: Zhao Liu <zhao1.liu@intel.com>
To: Peter Maydell <peter.maydell@linaro.org>
Cc: qemu-devel@nongnu.org, qemu-trivial@nongnu.org
Subject: Re: [PATCH 07/10] include: Clean up includes
Message-ID: <ZbPTHGpHIf0JKepg@intel.com>
References: <20240125163408.1595135-1-peter.maydell@linaro.org>
 <20240125163408.1595135-8-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240125163408.1595135-8-peter.maydell@linaro.org>
Received-SPF: pass client-ip=198.175.65.11; envelope-from=zhao1.liu@intel.com;
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

On Thu, Jan 25, 2024 at 04:34:05PM +0000, Peter Maydell wrote:
> Date: Thu, 25 Jan 2024 16:34:05 +0000
> From: Peter Maydell <peter.maydell@linaro.org>
> Subject: [PATCH 07/10] include: Clean up includes
> X-Mailer: git-send-email 2.34.1
> 
> This commit was created with scripts/clean-includes:
>  ./scripts/clean-includes --git include include/*/*.h include/*/*/*.h
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
> I hand-checked that all these headers are included only by .c
> files which already have osdep.h included.
> ---
>  include/hw/arm/raspberrypi-fw-defs.h | 1 -
>  include/hw/mem/memory-device.h       | 1 -
>  include/hw/ppc/spapr_nested.h        | 1 -
>  include/hw/xen/xen-hvm-common.h      | 1 -
>  include/qemu/qtree.h                 | 1 -
>  include/ui/rect.h                    | 2 --
>  6 files changed, 7 deletions(-)

Reviewed-by: Zhao Liu <zhao1.liu@intel.com>

> 
> diff --git a/include/hw/arm/raspberrypi-fw-defs.h b/include/hw/arm/raspberrypi-fw-defs.h
> index 4551fe7450d..579cf0d5546 100644
> --- a/include/hw/arm/raspberrypi-fw-defs.h
> +++ b/include/hw/arm/raspberrypi-fw-defs.h
> @@ -10,7 +10,6 @@
>  #ifndef INCLUDE_HW_MISC_RASPBERRYPI_FW_DEFS_H_
>  #define INCLUDE_HW_MISC_RASPBERRYPI_FW_DEFS_H_
>  
> -#include "qemu/osdep.h"
>  
>  enum rpi_firmware_property_tag {
>      RPI_FWREQ_PROPERTY_END =                           0,
> diff --git a/include/hw/mem/memory-device.h b/include/hw/mem/memory-device.h
> index a1d62cc551a..e0571c8a319 100644
> --- a/include/hw/mem/memory-device.h
> +++ b/include/hw/mem/memory-device.h
> @@ -14,7 +14,6 @@
>  #define MEMORY_DEVICE_H
>  
>  #include "hw/qdev-core.h"
> -#include "qemu/typedefs.h"
>  #include "qapi/qapi-types-machine.h"
>  #include "qom/object.h"
>  
> diff --git a/include/hw/ppc/spapr_nested.h b/include/hw/ppc/spapr_nested.h
> index d3834864764..d312a5d61da 100644
> --- a/include/hw/ppc/spapr_nested.h
> +++ b/include/hw/ppc/spapr_nested.h
> @@ -1,7 +1,6 @@
>  #ifndef HW_SPAPR_NESTED_H
>  #define HW_SPAPR_NESTED_H
>  
> -#include "qemu/osdep.h"
>  #include "target/ppc/cpu.h"
>  
>  /*
> diff --git a/include/hw/xen/xen-hvm-common.h b/include/hw/xen/xen-hvm-common.h
> index 4e9904f1a65..4b1d728f35c 100644
> --- a/include/hw/xen/xen-hvm-common.h
> +++ b/include/hw/xen/xen-hvm-common.h
> @@ -1,7 +1,6 @@
>  #ifndef HW_XEN_HVM_COMMON_H
>  #define HW_XEN_HVM_COMMON_H
>  
> -#include "qemu/osdep.h"
>  #include "qemu/units.h"
>  
>  #include "cpu.h"
> diff --git a/include/qemu/qtree.h b/include/qemu/qtree.h
> index 69fe74b50d0..dc2b14d2582 100644
> --- a/include/qemu/qtree.h
> +++ b/include/qemu/qtree.h
> @@ -42,7 +42,6 @@
>  #ifndef QEMU_QTREE_H
>  #define QEMU_QTREE_H
>  
> -#include "qemu/osdep.h"
>  
>  #ifdef HAVE_GLIB_WITH_SLICE_ALLOCATOR
>  
> diff --git a/include/ui/rect.h b/include/ui/rect.h
> index 68f05d78a8e..7ebf47ebcdc 100644
> --- a/include/ui/rect.h
> +++ b/include/ui/rect.h
> @@ -4,8 +4,6 @@
>  #ifndef QEMU_RECT_H
>  #define QEMU_RECT_H
>  
> -#include <stdint.h>
> -#include <stdbool.h>
>  
>  typedef struct QemuRect {
>      int16_t x;
> -- 
> 2.34.1
> 
> 

