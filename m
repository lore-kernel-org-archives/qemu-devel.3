Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5B6BBC46CD2
	for <qemu-devel@archiver.kernel.org>; Sat, 27 Jan 2024 14:26:26 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rTjd8-0003nu-73; Sat, 27 Jan 2024 09:25:58 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1rTjd7-0003na-7I
 for qemu-devel@nongnu.org; Sat, 27 Jan 2024 09:25:57 -0500
Received: from mgamail.intel.com ([192.55.52.120])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1rTjd5-0007td-H0
 for qemu-devel@nongnu.org; Sat, 27 Jan 2024 09:25:56 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1706365555; x=1737901555;
 h=date:from:to:cc:subject:message-id:references:
 mime-version:in-reply-to;
 bh=/tGA8SoGWh1rlKKvs8NqnvMqY063S6ravU6bzAk/Kss=;
 b=fEK3/y6WFQ8lF3rixs51YRqhtKQa+AlIvrcK/gIdgno2BbJqfY7oGAxq
 h2F2p3mBPqn96+BaAVonf41Y8l5WXRctwA4butUHVfY+tS8k53cujkbam
 xpmbYnUU3q37eQTzpPvQ9koTAMO58lDyGRP7UEJFlu4qvyxM+r1p7Xdsk
 Oz9F8yJ35ymRtsvtndFX/JYjRY502UvTNjjzof++oFSqVX+sjAMfSZENH
 VxiyXq4Bi78ift6gXidjBcmqEiMdBE+cegJlNH0iEhrAS2g7o8nXy/v7k
 vFAW5v1VkYBxG6V6EmAotDZFjRyPnYMOLeXrnQWatySDJAmlRRHYS6Wsb w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10964"; a="401547138"
X-IronPort-AV: E=Sophos;i="6.05,220,1701158400"; d="scan'208";a="401547138"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
 by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 27 Jan 2024 06:25:53 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.05,220,1701158400"; d="scan'208";a="29358161"
Received: from liuzhao-optiplex-7080.sh.intel.com (HELO localhost)
 ([10.239.160.36])
 by fmviesa001.fm.intel.com with ESMTP; 27 Jan 2024 06:25:52 -0800
Date: Sat, 27 Jan 2024 22:38:56 +0800
From: Zhao Liu <zhao1.liu@intel.com>
To: Peter Maydell <peter.maydell@linaro.org>
Cc: qemu-devel@nongnu.org
Subject: Re: [PATCH 2/2] meson: Enable -Wvla
Message-ID: <ZbUVgLsK4yI+Blcx@intel.com>
References: <20240125173211.1786196-1-peter.maydell@linaro.org>
 <20240125173211.1786196-3-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240125173211.1786196-3-peter.maydell@linaro.org>
Received-SPF: pass client-ip=192.55.52.120; envelope-from=zhao1.liu@intel.com;
 helo=mgamail.intel.com
X-Spam_score_int: -56
X-Spam_score: -5.7
X-Spam_bar: -----
X-Spam_report: (-5.7 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.282,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_MED=-2.3, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
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

On Thu, Jan 25, 2024 at 05:32:11PM +0000, Peter Maydell wrote:
> Date: Thu, 25 Jan 2024 17:32:11 +0000
> From: Peter Maydell <peter.maydell@linaro.org>
> Subject: [PATCH 2/2] meson: Enable -Wvla
> X-Mailer: git-send-email 2.34.1
> 
> QEMU has historically used variable length arrays only very rarely.
> Variable length arrays are a potential security issue where an
> on-stack dynamic allocation isn't correctly size-checked, especially
> when the size comes from the guest.  (An example problem of this kind
> from the past is CVE-2021-3527).  Forbidding them entirely is a
> defensive measure against further bugs of this kind.
> 
> Enable -Wvla to prevent any new uses from sneaking into the codebase.
> 
> Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
> ---
>  meson.build | 1 +
>  1 file changed, 1 insertion(+)

Reviewed-by: Zhao Liu <zhao1.liu@intel.com>

> 
> diff --git a/meson.build b/meson.build
> index d0329966f1b..385b8247073 100644
> --- a/meson.build
> +++ b/meson.build
> @@ -601,6 +601,7 @@ warn_flags = [
>    '-Wno-psabi',
>    '-Wno-gnu-variable-sized-type-not-at-end',
>    '-Wshadow=local',
> +  '-Wvla',
>  ]
>  
>  if host_os != 'darwin'
> -- 
> 2.34.1
> 
> 

