Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AC24DE7717F
	for <qemu-devel@archiver.kernel.org>; Tue, 17 Dec 2024 16:08:55 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tNa3s-0001Hf-90; Tue, 17 Dec 2024 11:04:44 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1tNa38-00019Q-0D
 for qemu-devel@nongnu.org; Tue, 17 Dec 2024 11:04:02 -0500
Received: from mgamail.intel.com ([192.198.163.15])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1tNa31-0002TZ-7V
 for qemu-devel@nongnu.org; Tue, 17 Dec 2024 11:03:53 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1734451427; x=1765987427;
 h=date:from:to:cc:subject:message-id:references:
 mime-version:content-transfer-encoding:in-reply-to;
 bh=TZgosjBYR9y1uV0i86b2LUmldcCKBeHWtXQ+IUnVzHI=;
 b=iUTbOzQ6g08ZvGch/j1dL+jXIUxm2tWBAkgSFGareN51GyQHTBwyiBni
 vp4n6Pb1i/Xyjfl8W+PaTm2aVCdYmOZYV3hSSaZESonTH4JSJy0/xSOdv
 fhNvTLTTSCmyMkpIfV2Ggauaj5dnAHBSQ8O4Y/C6URwAr9Uk6elI0EKNT
 +z0V1lMu3dAMIZ5KKQmfiDH174HB00nfJ8sx+w04NcsMrojnCt89/2fij
 qodmNZZoizbNBuBVKEdOx9J5sFZfTGj4jzNZIgUdkITGOKzTGlCioucMz
 I7j69qtxGAB0Q0RhN1kg94qrpPI9ZBzcKNbByW1D2NYRsFadVsV8jmp99 Q==;
X-CSE-ConnectionGUID: MtFO4SF/TQ6dVD6QWLq+NA==
X-CSE-MsgGUID: 11/UF6yXQk2+lRWFxzHUrA==
X-IronPort-AV: E=McAfee;i="6700,10204,11288"; a="35038703"
X-IronPort-AV: E=Sophos;i="6.12,242,1728975600"; d="scan'208";a="35038703"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
 by fmvoesa109.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 17 Dec 2024 08:03:45 -0800
X-CSE-ConnectionGUID: WDSSOHGXSqyEmnqsys0ufQ==
X-CSE-MsgGUID: vriFYFVBRV2y5UsKlcv87w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,224,1728975600"; d="scan'208";a="101715615"
Received: from liuzhao-optiplex-7080.sh.intel.com (HELO localhost)
 ([10.239.160.39])
 by fmviesa003.fm.intel.com with ESMTP; 17 Dec 2024 08:03:43 -0800
Date: Wed, 18 Dec 2024 00:22:17 +0800
From: Zhao Liu <zhao1.liu@intel.com>
To: Philippe =?iso-8859-1?Q?Mathieu-Daud=E9?= <philmd@linaro.org>
Cc: qemu-devel@nongnu.org, Stefano Stabellini <sstabellini@kernel.org>,
 "Edgar E. Iglesias" <edgar.iglesias@gmail.com>,
 Paul Durrant <paul@xen.org>,
 Richard Henderson <richard.henderson@linaro.org>,
 Yanan Wang <wangyanan55@huawei.com>, Anton Johansson <anjo@rev.ng>,
 Anthony PERARD <anthony@xenproject.org>, xen-devel@lists.xenproject.org
Subject: Re: [PATCH 1/3] hw/xen: Remove unnecessary 'exec/cpu-common.h' header
Message-ID: <Z2GlOSMl3+me/IHX@intel.com>
References: <20241217151305.29196-1-philmd@linaro.org>
 <20241217151305.29196-2-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20241217151305.29196-2-philmd@linaro.org>
Received-SPF: pass client-ip=192.198.163.15; envelope-from=zhao1.liu@intel.com;
 helo=mgamail.intel.com
X-Spam_score_int: -43
X-Spam_score: -4.4
X-Spam_bar: ----
X-Spam_report: (-4.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_MED=-2.3, RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001,
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

On Tue, Dec 17, 2024 at 04:13:03PM +0100, Philippe Mathieu-Daudé wrote:
> Date: Tue, 17 Dec 2024 16:13:03 +0100
> From: Philippe Mathieu-Daudé <philmd@linaro.org>
> Subject: [PATCH 1/3] hw/xen: Remove unnecessary 'exec/cpu-common.h' header
> X-Mailer: git-send-email 2.45.2
> 
> Nothing requires definitions from "exec/cpu-common.h",
> do not include this header.
> 
> Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
> ---
>  include/hw/xen/xen.h | 2 --
>  1 file changed, 2 deletions(-)
> 

Reviewed-by: Zhao Liu <zhao1.liu@intel.com>


