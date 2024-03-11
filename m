Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 03D6DC5475B
	for <qemu-devel@archiver.kernel.org>; Mon, 11 Mar 2024 15:31:55 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rjhcG-0004Im-8p; Mon, 11 Mar 2024 11:31:04 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@linux.intel.com>)
 id 1rjhcB-0004Hj-VD
 for qemu-devel@nongnu.org; Mon, 11 Mar 2024 11:31:01 -0400
Received: from mgamail.intel.com ([198.175.65.14])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@linux.intel.com>)
 id 1rjhc8-0005f8-Ll
 for qemu-devel@nongnu.org; Mon, 11 Mar 2024 11:30:59 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1710171056; x=1741707056;
 h=date:from:to:cc:subject:message-id:references:
 mime-version:content-transfer-encoding:in-reply-to;
 bh=2p4rg6EVYAvyHflbUz0DDkb4ZOH34bOHun5RAo/d9Dg=;
 b=ZH5pNeeqirGgQ0R+lgf+z41CFRtZuJ+cf3mRnpc73F/kf/KcLA9M+zI/
 kK26s2d//vInNU0ZQjY8Z6K1dZ7Gi5MufDaRTbUWGCuYnibz45Nci5KJL
 okyEfJuX6GP3/b5/0FImredzSvHBxjnxOk7dnARGrKZFOew7d6tBAsGgL
 O2/75El9KQHm7rvp4XshWUKn+mipIjjptjqpM0n+O1pHrqlcLvi2jdaHt
 wTQrXZUrjQ4l1zCF3FSsPUBhCGFYVB6oD4DuZfHsmbPrC+2Yw/Ta0IRr5
 x9nAXLROOFqODXXSZkx4AvvyDynYdF+pSDCQCoPNXEmDk3ScuTdEAKMEF A==;
X-IronPort-AV: E=McAfee;i="6600,9927,11010"; a="8655522"
X-IronPort-AV: E=Sophos;i="6.07,117,1708416000"; 
   d="scan'208";a="8655522"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
 by orvoesa106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 11 Mar 2024 08:30:46 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,117,1708416000"; d="scan'208";a="42116766"
Received: from liuzhao-optiplex-7080.sh.intel.com (HELO localhost)
 ([10.239.160.36])
 by orviesa002.jf.intel.com with ESMTP; 11 Mar 2024 08:30:45 -0700
Date: Mon, 11 Mar 2024 23:44:33 +0800
From: Zhao Liu <zhao1.liu@linux.intel.com>
To: Philippe =?iso-8859-1?Q?Mathieu-Daud=E9?= <philmd@linaro.org>
Cc: Eduardo Habkost <eduardo@habkost.net>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Yanan Wang <wangyanan55@huawei.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 Thomas Huth <thuth@redhat.com>, qemu-devel@nongnu.org,
 Zhao Liu <zhao1.liu@intel.com>
Subject: Re: [PATCH v3 1/3] hw/core: Cleanup unused included headers in
 cpu-common.c
Message-ID: <Ze8m4YvRQrWFlFpN@intel.com>
References: <20240311075621.3224684-1-zhao1.liu@linux.intel.com>
 <20240311075621.3224684-2-zhao1.liu@linux.intel.com>
 <752e3d2b-1834-4f6d-9764-3d7e951409c4@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <752e3d2b-1834-4f6d-9764-3d7e951409c4@linaro.org>
Received-SPF: none client-ip=198.175.65.14;
 envelope-from=zhao1.liu@linux.intel.com; helo=mgamail.intel.com
X-Spam_score_int: -29
X-Spam_score: -3.0
X-Spam_bar: ---
X-Spam_report: (-3.0 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.029,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_NONE=0.001,
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

On Mon, Mar 11, 2024 at 12:40:23PM +0100, Philippe Mathieu-Daudé wrote:
> Date: Mon, 11 Mar 2024 12:40:23 +0100
> From: Philippe Mathieu-Daudé <philmd@linaro.org>
> Subject: Re: [PATCH v3 1/3] hw/core: Cleanup unused included headers in
>  cpu-common.c
> 
> On 11/3/24 08:56, Zhao Liu wrote:
> > From: Zhao Liu <zhao1.liu@intel.com>
> > 
> > Remove unused headers in cpu-common.c:
> > * qemu/notify.h
> > * exec/cpu-common.h
> > * qemu/error-report.h
> > * qemu/qemu-print.h
> > 
> > Tested by "./configure" and then "make".
> 
> This isn't often enough. The safest way to catch implicit
> includes is to add #error in them and compile the source.
> 
> > 
> > Signed-off-by: Zhao Liu <zhao1.liu@intel.com>
> > ---
> >   hw/core/cpu-common.c | 4 ----
> >   1 file changed, 4 deletions(-)
> > 
> > diff --git a/hw/core/cpu-common.c b/hw/core/cpu-common.c
> > index 0108fb11dbc8..4bd9c70a83f1 100644
> > --- a/hw/core/cpu-common.c
> > +++ b/hw/core/cpu-common.c
> > @@ -22,14 +22,10 @@
> >   #include "qapi/error.h"
> >   #include "hw/core/cpu.h"
> >   #include "sysemu/hw_accel.h"
> > -#include "qemu/notify.h"
> >   #include "qemu/log.h"
> >   #include "qemu/main-loop.h"
> >   #include "exec/log.h"
> > -#include "exec/cpu-common.h"
> 
> Watch out, "exec/cpu-common.h" is implicitly included:
> 
> $ git diff -U0
> diff --git a/include/exec/cpu-common.h b/include/exec/cpu-common.h
> index 6346df17ce..27961bacc6 100644
> --- a/include/exec/cpu-common.h
> +++ b/include/exec/cpu-common.h
> @@ -2,0 +3 @@
> +#error
> 
> $ ninja libcommon.fa.p/hw_core_cpu-common.c.o
> In file included from ../../hw/core/cpu-common.c:34:
> In file included from include/hw/boards.h:6:
> In file included from include/exec/memory.h:19:
> include/exec/cpu-common.h:3:2: error:
> #error

Thanks for helpping me verify this!!

EMM, but I'm still not understanding how this approach distinguishes
whether hw/core/cpu-common.c needs the header (include/exec/cpu-common.h)
directly or just include/exec/memory.h needs that header? For the latter,
the header needn't be included in .c file.

Thanks,
Zhao


