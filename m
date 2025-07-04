Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 78C15C83030
	for <qemu-devel@archiver.kernel.org>; Fri,  4 Jul 2025 08:31:30 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uXbp3-000434-6e; Fri, 04 Jul 2025 04:31:05 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1uXbp1-00042u-Uz
 for qemu-devel@nongnu.org; Fri, 04 Jul 2025 04:31:04 -0400
Received: from mgamail.intel.com ([198.175.65.20])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1uXboy-00085r-CT
 for qemu-devel@nongnu.org; Fri, 04 Jul 2025 04:31:03 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1751617861; x=1783153861;
 h=date:from:to:cc:subject:message-id:references:
 mime-version:content-transfer-encoding:in-reply-to;
 bh=qSKFJqr0Qywi0iAlGlIkKfjQJIEPf0LTXkikDjrW5KU=;
 b=MVDxaWwguu9BVT0MToQmnqo60Y3W1/pgx96WqymyUsyKlAAUTb/CM/mX
 E94di1pBZisb4XOH2eZYHy6TrWMfvngq18YVOFdmqTpD9/tr2Eq1hqk47
 qilq++5u16wcajAUFT65Sn+C3RTMZLJgbn4QMT+UfmmNN+PSWlX9+zome
 pB3OgPCWYX4RVC3/zsSNK6JGzXo6AuqlWwoQwRYJcbHV8us5UOBTDGHZI
 2MhquRVVQUXhyz3Qjdv7Ndf2HBazq8q6nA5SSo51NVcpZ86JolplfU2HE
 00Hv65cUhdoACTjJOijPHdtAGRhUufK2IVkjdoyKCI39+WmW+b8tJB2/X Q==;
X-CSE-ConnectionGUID: HsY6dws2RYeq9wd9j/U3Bg==
X-CSE-MsgGUID: 6Do2P/AlQAKb8COk+e245g==
X-IronPort-AV: E=McAfee;i="6800,10657,11483"; a="53671789"
X-IronPort-AV: E=Sophos;i="6.16,286,1744095600"; d="scan'208";a="53671789"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
 by orvoesa112.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 04 Jul 2025 01:30:57 -0700
X-CSE-ConnectionGUID: GBBpck5FRFWey8H+f0UU4g==
X-CSE-MsgGUID: 7U0brTSvSf+E4dFTzF06GA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,286,1744095600"; d="scan'208";a="154233853"
Received: from liuzhao-optiplex-7080.sh.intel.com (HELO localhost)
 ([10.239.160.39])
 by fmviesa007.fm.intel.com with ESMTP; 04 Jul 2025 01:30:52 -0700
Date: Fri, 4 Jul 2025 16:52:18 +0800
From: Zhao Liu <zhao1.liu@intel.com>
To: Philippe =?iso-8859-1?Q?Mathieu-Daud=E9?= <philmd@linaro.org>
Cc: qemu-devel@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 Alex =?iso-8859-1?Q?Benn=E9e?= <alex.bennee@linaro.org>,
 Cameron Esfahani <dirty@apple.com>, Roman Bolshakov <rbolshakov@ddn.com>,
 Phil Dennis-Jordan <phil@philjordan.eu>,
 Mads Ynddal <mads@ynddal.dk>, Fabiano Rosas <farosas@suse.de>,
 Laurent Vivier <lvivier@redhat.com>,
 Stefano Stabellini <sstabellini@kernel.org>,
 Anthony PERARD <anthony@xenproject.org>, Paul Durrant <paul@xen.org>,
 "Edgar E. Iglesias" <edgar.iglesias@gmail.com>,
 Reinoud Zandijk <reinoud@netbsd.org>,
 Sunil Muthuswamy <sunilmut@microsoft.com>, kvm@vger.kernel.org,
 xen-devel@lists.xenproject.org
Subject: Re: [PATCH v6 37/39] accel: Rename 'system/accel-ops.h' ->
 'accel/accel-cpu-ops.h'
Message-ID: <aGeWQu8iYlzuPYQ+@intel.com>
References: <20250703173248.44995-1-philmd@linaro.org>
 <20250703173248.44995-38-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20250703173248.44995-38-philmd@linaro.org>
Received-SPF: pass client-ip=198.175.65.20; envelope-from=zhao1.liu@intel.com;
 helo=mgamail.intel.com
X-Spam_score_int: -41
X-Spam_score: -4.2
X-Spam_bar: ----
X-Spam_report: (-4.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_MED=-2.3, RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.237,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, SPF_HELO_NONE=0.001,
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

On Thu, Jul 03, 2025 at 07:32:43PM +0200, Philippe Mathieu-Daudé wrote:
> Date: Thu,  3 Jul 2025 19:32:43 +0200
> From: Philippe Mathieu-Daudé <philmd@linaro.org>
> Subject: [PATCH v6 37/39] accel: Rename 'system/accel-ops.h' ->
>  'accel/accel-cpu-ops.h'
> X-Mailer: git-send-email 2.49.0
> 
> Unfortunately "system/accel-ops.h" handlers are not only
> system-specific. For example, the cpu_reset_hold() hook
> is part of the vCPU creation, after it is realized.
> 
> Mechanical rename to drop 'system' using:
> 
>   $ sed -i -e s_system/accel-ops.h_accel/accel-cpu-ops.h_g \
>               $(git grep -l system/accel-ops.h)
> 
> Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
> ---
>  include/{system/accel-ops.h => accel/accel-cpu-ops.h} | 8 ++++----
>  accel/accel-common.c                                  | 2 +-
>  accel/accel-system.c                                  | 2 +-
>  accel/hvf/hvf-accel-ops.c                             | 2 +-
>  accel/kvm/kvm-accel-ops.c                             | 2 +-
>  accel/qtest/qtest.c                                   | 2 +-
>  accel/tcg/tcg-accel-ops.c                             | 2 +-
>  accel/xen/xen-all.c                                   | 2 +-
>  cpu-target.c                                          | 2 +-
>  gdbstub/system.c                                      | 2 +-
>  system/cpus.c                                         | 2 +-
>  target/i386/nvmm/nvmm-accel-ops.c                     | 2 +-
>  target/i386/whpx/whpx-accel-ops.c                     | 2 +-
>  13 files changed, 16 insertions(+), 16 deletions(-)
>  rename include/{system/accel-ops.h => accel/accel-cpu-ops.h} (96%)

...

> -#ifndef ACCEL_OPS_H
> -#define ACCEL_OPS_H
> +#ifndef ACCEL_CPU_OPS_H
> +#define ACCEL_CPU_OPS_H

Daniel mentioned "QEMU_" prefix is "best practice":

https://lore.kernel.org/qemu-devel/aAdSMExEAy45NIeB@redhat.com/

But I also think there's no need to change anything here for now. If
you agree, we can move in this direction in the future. So

Reviewed-by: Zhao Liu <zhao1.liu@intel.com>


