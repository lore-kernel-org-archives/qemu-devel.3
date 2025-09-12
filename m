Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 99D7FCA101F
	for <qemu-devel@archiver.kernel.org>; Fri, 12 Sep 2025 08:52:28 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uwzVd-0007Kn-9w; Fri, 12 Sep 2025 04:51:57 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1uwzVa-0007KX-9D
 for qemu-devel@nongnu.org; Fri, 12 Sep 2025 04:51:54 -0400
Received: from mgamail.intel.com ([198.175.65.9])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1uwzVV-0007B0-Tb
 for qemu-devel@nongnu.org; Fri, 12 Sep 2025 04:51:53 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1757667110; x=1789203110;
 h=date:from:to:cc:subject:message-id:references:
 mime-version:content-transfer-encoding:in-reply-to;
 bh=Cr1sJAUUC+426LZPnSzW9yUdgdNYF3mQazgzTWxyKz0=;
 b=B3F8NJhrMHRpMPG9g9UZ+v/kRxgcA8kDi7KnVHwt1AcsBTXDZSwrdKMW
 S83FPCfithdTVCc6ERbiQ7/zj4btPIQfn78EZZWAVvm4702MMtpRCHf2l
 KYTwGMfBC+BCud0en+H7r/PBo2jwTSamNsYcBJh/Th110+e2KFLlzPR1D
 SXXF9uNnrklFFo6MlpX26k+TiU85O8VL56CP7d7F14O+Dffn/TgRVyl2K
 2fHEeCb7Y4UN2CIyRNWh6hcKOVVWnUfPEArB1gyn6NH2rLLPMQvCjtSn9
 XpLK77tyLOgwtx9EgH1+y9P5coEAzsH531FpyecwptbXRJa8PjcSXP77M w==;
X-CSE-ConnectionGUID: 8H9md8H9Twe5zpOf3RdiYw==
X-CSE-MsgGUID: 5fUSgO57T3CJM2YtbucmZw==
X-IronPort-AV: E=McAfee;i="6800,10657,11531"; a="82598443"
X-IronPort-AV: E=Sophos;i="6.17,312,1747724400"; d="scan'208";a="82598443"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
 by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 12 Sep 2025 01:51:46 -0700
X-CSE-ConnectionGUID: p+lFy+CMRS+WKBd0UySoLg==
X-CSE-MsgGUID: 9UYNbv2lROCKlI9ZzrKq9A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.18,259,1751266800"; d="scan'208";a="197604742"
Received: from liuzhao-optiplex-7080.sh.intel.com (HELO localhost)
 ([10.239.160.39])
 by fmviesa002.fm.intel.com with ESMTP; 12 Sep 2025 01:51:44 -0700
Date: Fri, 12 Sep 2025 17:13:37 +0800
From: Zhao Liu <zhao1.liu@intel.com>
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: qemu-devel@nongnu.org,
 =?iso-8859-1?Q?Marc-Andr=E9?= Lureau <marcandre.lureau@redhat.com>
Subject: Re: [PATCH 31/33] docs: update rust.rst
Message-ID: <aMPkQcWynOtf8LS2@intel.com>
References: <20250908105005.2119297-1-pbonzini@redhat.com>
 <20250908105005.2119297-32-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20250908105005.2119297-32-pbonzini@redhat.com>
Received-SPF: pass client-ip=198.175.65.9; envelope-from=zhao1.liu@intel.com;
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

On Mon, Sep 08, 2025 at 12:50:03PM +0200, Paolo Bonzini wrote:
> Date: Mon,  8 Sep 2025 12:50:03 +0200
> From: Paolo Bonzini <pbonzini@redhat.com>
> Subject: [PATCH 31/33] docs: update rust.rst
> X-Mailer: git-send-email 2.51.0
> 
> From: Marc-André Lureau <marcandre.lureau@redhat.com>
> 
> Signed-off-by: Marc-André Lureau <marcandre.lureau@redhat.com>
> Link: https://lore.kernel.org/r/20250827104147.717203-23-marcandre.lureau@redhat.com
> Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
> ---
>  docs/devel/rust.rst | 61 ++++++++++++++++++++++++---------------------
>  1 file changed, 32 insertions(+), 29 deletions(-)

...

>  The status of the modules is as follows:
>  
> -================ ======================
> -module           status
> -================ ======================
> -``assertions``   stable
> -``bitops``       complete
> -``callbacks``    complete
> -``cell``         stable
> -``errno``        complete
> -``error``        stable
> -``irq``          complete
> -``log``          proof of concept
> -``memory``       stable
> -``module``       complete
> -``qdev``         stable
> -``qom``          stable
> -``sysbus``       stable
> -``timer``        stable
> -``vmstate``      stable
> -``zeroable``     stable
> -================ ======================
> +========================== ======================
> +module                     status
> +========================== ======================

Missing bits (complete)?

> +``bql::cell``              stable

Missing chardev (stable)?

> +``common::assertions``     stable
> +``common::bitops``         complete
> +``common::callbacks``      complete
> +``common::errno``          complete

Missing opaque (complete) & unint (complete)?

> +``common::zeroable``       stable
> +``hwcore::irq``            complete
> +``hwcore::qdev``           stable
> +``hwcore::sysbus``         stable

Maybe hw::core::...? Because this "modele" seems to reflect the path.

> +``migration::vmstate``     stable
> +``qom``                    stable
> +``system::memory``         stable
> +``util::error``            stable
> +``util::log``              proof of concept
> +``util::module``           complete
> +``util::timer``            stable
> +========================== ======================

Others LGTM,

Reviewed-by: Zhao Liu <zhao1.liu@intel.com>



