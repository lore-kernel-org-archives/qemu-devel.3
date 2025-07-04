Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6A8B2C8303D
	for <qemu-devel@archiver.kernel.org>; Fri,  4 Jul 2025 10:05:51 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uXdI1-0002Zj-0i; Fri, 04 Jul 2025 06:05:05 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1uXdHy-0002ZL-CO
 for qemu-devel@nongnu.org; Fri, 04 Jul 2025 06:05:02 -0400
Received: from mgamail.intel.com ([198.175.65.13])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1uXdHu-0002r4-T4
 for qemu-devel@nongnu.org; Fri, 04 Jul 2025 06:05:01 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1751623499; x=1783159499;
 h=date:from:to:cc:subject:message-id:references:
 mime-version:content-transfer-encoding:in-reply-to;
 bh=VqW+7j3bGYH4APv86Bf1CmsVe7ytoRtcuouJ718vSyw=;
 b=fjepuq3CALBElr44/AnmNwLNiDwleWSE8rEe2SXGU+cc1ddmM8XPVo1n
 FG+TSS3BRvmwbJH8zy4blDeZeKlw58/Ytrh8dm0dQUujPhGI+anKJ+jbM
 q/wGvQEPPLAgw8X3s0CqYNU7HXKJ21qrvVPSEMzIj9dLWUQeLVc5zhbDx
 l6WcOebhaJ62XLfbveGlp4vKsF7bjdWMYGL1TrBAm30yauWKdaix3LYPT
 OiclVPp9imNjZAI6kt3Wkpv34tqk/ll63rqKewHy/JATMfBG8WHGO6SYI
 OxOhQM9f1VQYsH7k5Qpw21bUDdJ0p1qOw1FLdwqXdIhGCgDpy1vzrBJPJ w==;
X-CSE-ConnectionGUID: UE5Lj05cSMeUT5WRbibtIw==
X-CSE-MsgGUID: XC2FZwGMT6+Zgx4xtjukJA==
X-IronPort-AV: E=McAfee;i="6800,10657,11483"; a="65012684"
X-IronPort-AV: E=Sophos;i="6.16,287,1744095600"; d="scan'208";a="65012684"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
 by orvoesa105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 04 Jul 2025 03:04:56 -0700
X-CSE-ConnectionGUID: 7UhI5mpzTGC6qwuwfeNB3g==
X-CSE-MsgGUID: P/e7tWGRS0GAYdwCji6LGQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,287,1744095600"; d="scan'208";a="178276246"
Received: from liuzhao-optiplex-7080.sh.intel.com (HELO localhost)
 ([10.239.160.39])
 by fmviesa002.fm.intel.com with ESMTP; 04 Jul 2025 03:04:55 -0700
Date: Fri, 4 Jul 2025 18:26:20 +0800
From: Zhao Liu <zhao1.liu@intel.com>
To: Philippe =?iso-8859-1?Q?Mathieu-Daud=E9?= <philmd@linaro.org>
Cc: qemu-devel@nongnu.org
Subject: Re: [PATCH v6 24/39] accel/nvmm: Expose nvmm_enabled() to common code
Message-ID: <aGesTBLuw4WsGG56@intel.com>
References: <20250703173248.44995-1-philmd@linaro.org>
 <20250703173248.44995-25-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20250703173248.44995-25-philmd@linaro.org>
Received-SPF: pass client-ip=198.175.65.13; envelope-from=zhao1.liu@intel.com;
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

On Thu, Jul 03, 2025 at 07:32:30PM +0200, Philippe Mathieu-Daudé wrote:
> Date: Thu,  3 Jul 2025 19:32:30 +0200
> From: Philippe Mathieu-Daudé <philmd@linaro.org>
> Subject: [PATCH v6 24/39] accel/nvmm: Expose nvmm_enabled() to common code
> X-Mailer: git-send-email 2.49.0
> 
> Currently nvmm_enabled() is restricted to target-specific code.
> By defining CONFIG_NVMM_IS_POSSIBLE we allow its use anywhere.
> 
> Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
> Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>  include/system/nvmm.h       | 23 ++++++++++++-----------
>  accel/stubs/nvmm-stub.c     | 12 ++++++++++++
>  target/i386/nvmm/nvmm-all.c |  8 +-------
>  accel/stubs/meson.build     |  1 +
>  4 files changed, 26 insertions(+), 18 deletions(-)
>  create mode 100644 accel/stubs/nvmm-stub.c

With header file fixed,

Reviewed-by: Zhao Liu <zhao1.liu@intel.com>


