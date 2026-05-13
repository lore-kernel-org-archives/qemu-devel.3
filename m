Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 04740CD4851
	for <qemu-devel@archiver.kernel.org>; Wed, 13 May 2026 14:57:04 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wNB0T-0003ua-TO; Wed, 13 May 2026 10:56:17 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1wNB0N-0003u7-8j; Wed, 13 May 2026 10:56:11 -0400
Received: from mgamail.intel.com ([198.175.65.10])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1wNB0K-0007vl-SI; Wed, 13 May 2026 10:56:10 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1778684169; x=1810220169;
 h=date:from:to:cc:subject:message-id:references:
 mime-version:content-transfer-encoding:in-reply-to;
 bh=eFDkngCr6PJxUkPIzXh+oXkJrbgAkB7APfnrW/D4P1Y=;
 b=Baa0JYlgA3zROAGYyGwEmzNiu67AEr4W2cLhyWSQUmx8+coTwNmh5grD
 dmHq9SyZWfwq+QzlkOCfmdmoZcGkvyng53NyoU4D9gOsUWTjIC/92sg3j
 7bSSAC1+QYPJjGBrcD00NumbP14QyMHytdgVyKR2OA1f8Pnfv81aIeaAl
 kVHknKZtEnwKK1OjSq8LCjQPkfN+rYRdZrRgIUozY5Ly4oSSCCE/Mp1Gq
 U2//WRM5W9SSX1lSsQz7m11BS9C+dRyAoG+zamX8khU20mt3n2qxJTvjA
 LC+E/ih+fpVFVN6KwSa0xOdVoMlxU3bSwt0mh51eKPF7Fuvg3wuVrm6Lr A==;
X-CSE-ConnectionGUID: d0rKM4beRd2nNs6AREORpg==
X-CSE-MsgGUID: Or/sSkjNTGWe+VPCDCayoA==
X-IronPort-AV: E=McAfee;i="6800,10657,11785"; a="97039420"
X-IronPort-AV: E=Sophos;i="6.23,232,1770624000"; d="scan'208";a="97039420"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
 by orvoesa102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 13 May 2026 07:56:05 -0700
X-CSE-ConnectionGUID: kJvyDbeqQU2kkUoHdThAPw==
X-CSE-MsgGUID: nAk0a65VQ9mv2W05zsVXPw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,232,1770624000"; d="scan'208";a="242113328"
Received: from liuzhao-optiplex-7080.sh.intel.com (HELO localhost)
 ([10.239.160.39])
 by orviesa003.jf.intel.com with ESMTP; 13 May 2026 07:56:02 -0700
Date: Wed, 13 May 2026 23:23:47 +0800
From: Zhao Liu <zhao1.liu@intel.com>
To: Igor Mammedov <imammedo@redhat.com>
Cc: qemu-devel@nongnu.org, mst@redhat.com, anisinha@redhat.com,
 pbonzini@redhat.com, peter.maydell@linaro.org,
 shannon.zhaosl@gmail.com, philmd@linaro.org, rad@semihalf.com,
 leif.lindholm@oss.qualcomm.com, qemu-arm@nongnu.org
Subject: Re: [PATCH v2 01/21] acpi: add API to build WDAT instructions
Message-ID: <agSXg/yEbRzD9V+F@intel.com>
References: <20260303092532.2410177-1-imammedo@redhat.com>
 <20260303092532.2410177-2-imammedo@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260303092532.2410177-2-imammedo@redhat.com>
Received-SPF: pass client-ip=198.175.65.10; envelope-from=zhao1.liu@intel.com;
 helo=mgamail.intel.com
X-Spam_score_int: -47
X-Spam_score: -4.8
X-Spam_bar: ----
X-Spam_report: (-4.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.445,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_MED=-2.3, SPF_HELO_NONE=0.001,
 SPF_NONE=0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

On Tue, Mar 03, 2026 at 10:25:12AM +0100, Igor Mammedov wrote:
> Date: Tue,  3 Mar 2026 10:25:12 +0100
> From: Igor Mammedov <imammedo@redhat.com>
> Subject: [PATCH v2 01/21] acpi: add API to build WDAT instructions
> 
> Add definitions for WDAT[1] actions/instructions
> and build_append_wdat_ins() API to build table entries.
> 
> 1)
> "Hardware Watchdog Timers Design Specification"
>   https://uefi.org/acpi 'Watchdog Action Table (WDAT)'
> 
> Signed-off-by: Igor Mammedov <imammedo@redhat.com>
> Reviewed-by: Ani Sinha <anisinha@redhat.com>
> ---
>  include/hw/acpi/wdat.h | 118 +++++++++++++++++++++++++++++++++++++++++
>  hw/acpi/aml-build.c    |  14 +++++
>  2 files changed, 132 insertions(+)
>  create mode 100644 include/hw/acpi/wdat.h

Reviewed-by: Zhao Liu <zhao1.liu@intel.com>


