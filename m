Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 59058CD1284
	for <qemu-devel@archiver.kernel.org>; Wed, 27 Mar 2024 12:56:31 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rpSoc-00045A-Hn; Wed, 27 Mar 2024 08:55:38 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1rpSoa-00043B-5f
 for qemu-devel@nongnu.org; Wed, 27 Mar 2024 08:55:36 -0400
Received: from mgamail.intel.com ([198.175.65.18])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1rpSoX-0006Xb-DB
 for qemu-devel@nongnu.org; Wed, 27 Mar 2024 08:55:35 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1711544134; x=1743080134;
 h=date:from:to:cc:subject:message-id:references:
 mime-version:content-transfer-encoding:in-reply-to;
 bh=ZbffO2sdXK5gNW6Pqv0vknSa4PPdfD2lGofGIRE/emw=;
 b=MJSZwP3z+Gq3KHP+2JKdToL/lyj0GSasA5yHeu1848jXDJQzLXSL1mZv
 VOlqFiJmXa+S/JGxwYYvSphLAfmHVeebFhuZ9226WzbNnCxxro6ikz76Q
 bljpdhMM1UTPqnPKWuZS1wuOHkNycdNaukEwq0ssVgvzofvK1YmZrlGIn
 u+yZ8yQEblGFX9BUV/NH7wCa/koSslkNJAoM7PNTCoBdymLr/B+f6seFi
 s82jNgBIA6FKNmPM3zWFP49m8xLzTJlS1dz3isFPcUwH7BJhf5qe22wW2
 +ZLWvkqZPU11zbOQ8usTo9x0ZXbh4xG9SsiV1fS8kRKEpAtcisgDTUygx g==;
X-CSE-ConnectionGUID: l6+AXrmhQGOyVg2ezMODrw==
X-CSE-MsgGUID: QLdaQSOuR0aH1TXaLaRUwQ==
X-IronPort-AV: E=McAfee;i="6600,9927,11025"; a="6774538"
X-IronPort-AV: E=Sophos;i="6.07,158,1708416000"; 
   d="scan'208";a="6774538"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
 by orvoesa110.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 27 Mar 2024 05:55:30 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,158,1708416000"; d="scan'208";a="20770523"
Received: from liuzhao-optiplex-7080.sh.intel.com (HELO localhost)
 ([10.239.160.36])
 by fmviesa005.fm.intel.com with ESMTP; 27 Mar 2024 05:55:27 -0700
Date: Wed, 27 Mar 2024 21:09:22 +0800
From: Zhao Liu <zhao1.liu@intel.com>
To: Philippe =?iso-8859-1?Q?Mathieu-Daud=E9?= <philmd@linaro.org>
Cc: Thomas Huth <thuth@redhat.com>, qemu-devel@nongnu.org,
 Igor Mammedov <imammedo@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>, devel@lists.libvirt.org,
 Gerd Hoffmann <kraxel@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>,
 Ani Sinha <anisinha@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Eduardo Habkost <eduardo@habkost.net>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>
Subject: Re: [PATCH-for-9.1 v2 01/21] hw/i386/pc: Remove deprecated
 pc-i440fx-2.0 machine
Message-ID: <ZgQagqzF8tuUxVDX@intel.com>
References: <20240327095124.73639-1-philmd@linaro.org>
 <20240327095124.73639-2-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20240327095124.73639-2-philmd@linaro.org>
Received-SPF: pass client-ip=198.175.65.18; envelope-from=zhao1.liu@intel.com;
 helo=mgamail.intel.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
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

On Wed, Mar 27, 2024 at 10:51:03AM +0100, Philippe Mathieu-Daudé wrote:
> Date: Wed, 27 Mar 2024 10:51:03 +0100
> From: Philippe Mathieu-Daudé <philmd@linaro.org>
> Subject: [PATCH-for-9.1 v2 01/21] hw/i386/pc: Remove deprecated
>  pc-i440fx-2.0 machine
> X-Mailer: git-send-email 2.41.0
> 
> The pc-i440fx-2.0 machine was deprecated for the 8.2
> release (see commit c7437f0ddb "docs/about: Mark the
> old pc-i440fx-2.0 - 2.3 machine types as deprecated"),
> time to remove it.
> 
> Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
> Reviewed-by: Thomas Huth <thuth@redhat.com>
> Message-Id: <20240305134221.30924-2-philmd@linaro.org>
> ---
>  docs/about/deprecated.rst       |  2 +-
>  docs/about/removed-features.rst |  2 +-
>  include/hw/i386/pc.h            |  3 ---
>  hw/i386/pc.c                    | 15 -------------
>  hw/i386/pc_piix.c               | 37 ---------------------------------
>  5 files changed, 2 insertions(+), 57 deletions(-)

Reviewed-by: Zhao Liu <zhao1.liu@intel.com>


