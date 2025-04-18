Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0650EC369AB
	for <qemu-devel@archiver.kernel.org>; Fri, 18 Apr 2025 08:56:56 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u5hWH-0005NC-Ii; Fri, 18 Apr 2025 04:56:21 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1u5hWF-0005Md-3B
 for qemu-devel@nongnu.org; Fri, 18 Apr 2025 04:56:19 -0400
Received: from mgamail.intel.com ([198.175.65.18])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1u5hWC-000215-4y
 for qemu-devel@nongnu.org; Fri, 18 Apr 2025 04:56:18 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1744966576; x=1776502576;
 h=date:from:to:cc:subject:message-id:references:
 mime-version:in-reply-to;
 bh=XehJxbPdg0skVSErLYE1GcCJ+KIFga/7FMCMnsnkByA=;
 b=MSA7USAv6dl6S/aoMSUYBFmzfARHl2jVqSUs2/FImqiWwsOACEa3G63H
 aPP0TEUzxbiyG8vaEEwKzOaOdevmpin4wqcISxZazmOiaoKfq1UdwfK9R
 dEw2iMUSDT+qMvQrN3Y9w9Gnu+lbj7yWum+3/yeiHYU2iixdqYeExmrSL
 5jK6Z8VGgMHZiIs2PtYFarIAN14ghrqSyGBzB3mwOiWBAp7rbWZMd+gu6
 vI3EdkbxjMsRLzrnpJCvlaTuRe9bYMq3ucwPJciczuJ/WtB+NzE2P2Xgb
 /YX0XlJ+2DzA5pQU1zhMiTpyKikTX6fI7Jmd8AqPz2BzVrwLRyFWmhZtR Q==;
X-CSE-ConnectionGUID: tHPY5qLFRRmaUeWiWGfExw==
X-CSE-MsgGUID: n9dmqmtXSR2SnlUcW0lZOA==
X-IronPort-AV: E=McAfee;i="6700,10204,11406"; a="46713229"
X-IronPort-AV: E=Sophos;i="6.15,221,1739865600"; d="scan'208";a="46713229"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
 by orvoesa110.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 18 Apr 2025 01:56:11 -0700
X-CSE-ConnectionGUID: rNRRvyG5QbGeec+fIuXHWQ==
X-CSE-MsgGUID: PK0zP6YUTJeWQ2gGEEAcMA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,221,1739865600"; d="scan'208";a="131371536"
Received: from liuzhao-optiplex-7080.sh.intel.com (HELO localhost)
 ([10.239.160.39])
 by fmviesa008.fm.intel.com with ESMTP; 18 Apr 2025 01:56:09 -0700
Date: Fri, 18 Apr 2025 17:17:02 +0800
From: Zhao Liu <zhao1.liu@intel.com>
To: Xiaoyao Li <xiaoyao.li@intel.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>,
 Daniel =?iso-8859-1?Q?P=2E_Berrang=E9?= <berrange@redhat.com>,
 "Michael S. Tsirkin" <mst@redhat.com>,
 Markus Armbruster <armbru@redhat.com>,
 Francesco Lavra <francescolavra.fl@gmail.com>,
 Marcelo Tosatti <mtosatti@redhat.com>, qemu-devel@nongnu.org,
 Philippe =?iso-8859-1?Q?Mathieu-Daud=E9?= <philmd@linaro.org>,
 Rick Edgecombe <rick.p.edgecombe@intel.com>
Subject: Re: [PATCH v8 02/55] i386: Introduce tdx-guest object
Message-ID: <aAIYjpetyP9LKW6L@intel.com>
References: <20250401130205.2198253-1-xiaoyao.li@intel.com>
 <20250401130205.2198253-3-xiaoyao.li@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250401130205.2198253-3-xiaoyao.li@intel.com>
Received-SPF: pass client-ip=198.175.65.18; envelope-from=zhao1.liu@intel.com;
 helo=mgamail.intel.com
X-Spam_score_int: -43
X-Spam_score: -4.4
X-Spam_bar: ----
X-Spam_report: (-4.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_MED=-2.3, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

>  configs/devices/i386-softmmu/default.mak |  1 +
>  hw/i386/Kconfig                          |  5 +++
>  qapi/qom.json                            | 15 +++++++++
>  target/i386/kvm/meson.build              |  2 ++
>  target/i386/kvm/tdx.c                    | 43 ++++++++++++++++++++++++
>  target/i386/kvm/tdx.h                    | 21 ++++++++++++

SEV.* and confidential-guest.* are all placed in target/i386/.
It's best if all of these can be in the same place.

>  6 files changed, 87 insertions(+)
>  create mode 100644 target/i386/kvm/tdx.c
>  create mode 100644 target/i386/kvm/tdx.h

...

> diff --git a/target/i386/kvm/tdx.h b/target/i386/kvm/tdx.h
> new file mode 100644
> index 000000000000..f3b725336161
> --- /dev/null
> +++ b/target/i386/kvm/tdx.h
> @@ -0,0 +1,21 @@
> +/* SPDX-License-Identifier: GPL-2.0-or-later */
> +
> +#ifndef QEMU_I386_TDX_H
> +#define QEMU_I386_TDX_H

I386_TDX_H is enough... the QEMU prefix is rarely seen in the whole
project.

Others look good,

Reviewed-by: Zhao Liu <zhao1.liu@intel.com>


