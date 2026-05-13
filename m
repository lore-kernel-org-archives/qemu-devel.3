Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4810ACD4851
	for <qemu-devel@archiver.kernel.org>; Wed, 13 May 2026 14:33:23 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wNAdG-0005JR-Df; Wed, 13 May 2026 10:32:18 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1wNAcm-0005Gp-E6; Wed, 13 May 2026 10:31:53 -0400
Received: from mgamail.intel.com ([192.198.163.12])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1wNAcP-0004We-N6; Wed, 13 May 2026 10:31:43 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1778682686; x=1810218686;
 h=date:from:to:cc:subject:message-id:references:
 mime-version:in-reply-to;
 bh=gz2Uo7DN26CdPDBWOHlAvyg9gcml/bM2joxaunqaRms=;
 b=g+Ho+CLCgsSk899TvBYvdqqetPJgI1IJahsGGoXnkBRHgeZKPprnJdZ5
 NZQozfiGv3/AemS84q8wKzPC7yj2rexwDUzqDiXcMwtBM/t+u6Jzm+iAd
 glNEgEqLJiWQNNmBPWS46LJQKlSqYT0EGUms1mZHWB8oBY3n8y51T2pd0
 hZiiw90SNwRwikArLP7vZaiDulci5+YA47FbADlBbWd6k9C69y22xCP6L
 0oJ0Vxr4vfEHNAqLmyuo+Xk7r0B/gFcIsHVoc1of3NHGf8iB7t36MU/Ns
 UcWZLeuiHkVTZKboYpxmzXAtqaHqhRVGbvnhlcHx1cgaDgF/UxIXJ5CKA Q==;
X-CSE-ConnectionGUID: Rn5CnqHeTN2Vkn3fKBIgMQ==
X-CSE-MsgGUID: OGWFMUsMQN+YZiWb8et1jQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11784"; a="83464104"
X-IronPort-AV: E=Sophos;i="6.23,232,1770624000"; d="scan'208";a="83464104"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
 by fmvoesa106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 13 May 2026 07:31:16 -0700
X-CSE-ConnectionGUID: LhtCSqA/T/eNbZDreP0PWw==
X-CSE-MsgGUID: 0Sk+hQYMSAmbFrDKmpxzeA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,232,1770624000"; d="scan'208";a="235037411"
Received: from liuzhao-optiplex-7080.sh.intel.com (HELO localhost)
 ([10.239.160.39])
 by fmviesa007.fm.intel.com with ESMTP; 13 May 2026 07:31:13 -0700
Date: Wed, 13 May 2026 22:58:58 +0800
From: Zhao Liu <zhao1.liu@intel.com>
To: Igor Mammedov <imammedo@redhat.com>
Cc: qemu-devel@nongnu.org, mst@redhat.com, anisinha@redhat.com,
 pbonzini@redhat.com, peter.maydell@linaro.org,
 shannon.zhaosl@gmail.com, philmd@linaro.org, rad@semihalf.com,
 leif.lindholm@oss.qualcomm.com, qemu-arm@nongnu.org
Subject: Re: [PATCH v2 02/21] x86: q35: add 'wdat' property
Message-ID: <agSRsqaRsGBBwewT@intel.com>
References: <20260303092532.2410177-1-imammedo@redhat.com>
 <20260303092532.2410177-3-imammedo@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260303092532.2410177-3-imammedo@redhat.com>
Received-SPF: pass client-ip=192.198.163.12; envelope-from=zhao1.liu@intel.com;
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

On Tue, Mar 03, 2026 at 10:25:13AM +0100, Igor Mammedov wrote:
> Date: Tue,  3 Mar 2026 10:25:13 +0100
> From: Igor Mammedov <imammedo@redhat.com>
> Subject: [PATCH v2 02/21] x86: q35: add 'wdat' property
> 
> Used for enabling WDAT based watchdog for builtin iTCO watchdog.
> Usage:
>     -M q35,wdat={on|off}
> By default it is disabled.
> 
> Signed-off-by: Igor Mammedov <imammedo@redhat.com>
> ---
>  include/hw/i386/pc.h |  1 +
>  hw/i386/pc_q35.c     | 18 ++++++++++++++++++
>  2 files changed, 19 insertions(+)

Reviewed-by: Zhao Liu <zhao1.liu@intel.com>


