Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6508AD767D8
	for <qemu-devel@archiver.kernel.org>; Thu, 31 Oct 2024 14:43:07 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t6WNN-0000iG-5h; Thu, 31 Oct 2024 10:42:17 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1t6WNK-0000hs-TK
 for qemu-devel@nongnu.org; Thu, 31 Oct 2024 10:42:15 -0400
Received: from mgamail.intel.com ([192.198.163.14])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1t6WNI-0006jE-7X
 for qemu-devel@nongnu.org; Thu, 31 Oct 2024 10:42:14 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1730385732; x=1761921732;
 h=date:from:to:cc:subject:message-id:references:
 mime-version:in-reply-to;
 bh=KRXxxUtsXLtlaP7XhwfUMjqSa8q2H5R35Nxxu/rLzw8=;
 b=PLWlSmYhsSrWwODIhZvOCJcSsnZptlMjocXmL6p9F/NreL1o2XE7ulQk
 w5EPJwiPdG58DYC5GIqxeqMM73jd8vPHJ7PbG0BUsLfRMTRggzt5zAPp8
 fuEkPJEP0BzVRYUuvXi2PhSU/P2nwkAquR65sKzRrb82ZXPENMn489NeH
 OvCZjIatqeoje1NsUNyRUPUoD7TcuiC0Xka/k3iKJVYYF7VY2qxbUxBOb
 0y7pxJHK+D5c4idK3FiX73C5zSsAkvO2keKd49xncGWDaCkDpzEutRab5
 dvUjGU7Po4DXyphrUrGZoB+bYazNULxU0lSTlHavNzSd/cS6I/BjMgp9V g==;
X-CSE-ConnectionGUID: WxuR/dJfQq2yZoJmmJm81A==
X-CSE-MsgGUID: LtrfOvPJTJSPvVrIBt+a+g==
X-IronPort-AV: E=McAfee;i="6700,10204,11242"; a="30343517"
X-IronPort-AV: E=Sophos;i="6.11,247,1725346800"; d="scan'208";a="30343517"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
 by fmvoesa108.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 31 Oct 2024 07:42:09 -0700
X-CSE-ConnectionGUID: PlrwYunITtGMtmRRx+6L2w==
X-CSE-MsgGUID: 0jFFnuJnRc6UoJxTHxAqmg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,247,1725346800"; d="scan'208";a="86564427"
Received: from liuzhao-optiplex-7080.sh.intel.com (HELO localhost)
 ([10.239.160.36])
 by fmviesa003.fm.intel.com with ESMTP; 31 Oct 2024 07:42:07 -0700
Date: Thu, 31 Oct 2024 22:58:28 +0800
From: Zhao Liu <zhao1.liu@intel.com>
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: qemu-devel@nongnu.org, manos.pitsidianakis@linaro.org,
 junjie.mao@hotmail.com, berrange@redhat.com
Subject: Re: [PATCH 05/23] rust/pl011: add TYPE_PL011_LUMINARY device
Message-ID: <ZyObFKPfEaaDrxrS@intel.com>
References: <20241025160209.194307-1-pbonzini@redhat.com>
 <20241025160209.194307-6-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241025160209.194307-6-pbonzini@redhat.com>
Received-SPF: pass client-ip=192.198.163.14; envelope-from=zhao1.liu@intel.com;
 helo=mgamail.intel.com
X-Spam_score_int: -47
X-Spam_score: -4.8
X-Spam_bar: ----
X-Spam_report: (-4.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.366,
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

On Fri, Oct 25, 2024 at 06:01:50PM +0200, Paolo Bonzini wrote:
> Date: Fri, 25 Oct 2024 18:01:50 +0200
> From: Paolo Bonzini <pbonzini@redhat.com>
> Subject: [PATCH 05/23] rust/pl011: add TYPE_PL011_LUMINARY device
> X-Mailer: git-send-email 2.47.0
> 
> From: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>
> 
> Add a device specialization for the Luminary UART device.
> 
> This commit adds a DeviceId enum that utilizes the Index trait to return
> different bytes depending on what device id the UART has (Arm -default-
> or Luminary)
> 
> Signed-off-by: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>
> Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
> Link: https://lore.kernel.org/r/20241024-rust-round-2-v1-6-051e7a25b978@linaro.org
> ---
>  rust/hw/char/pl011/src/device.rs | 77 ++++++++++++++++++++++++++++++--
>  rust/hw/char/pl011/src/lib.rs    |  1 +
>  2 files changed, 75 insertions(+), 3 deletions(-)

Great! All tests passed on my side (x86 platform).

Tested-by: Zhao Liu <zhao1.liu@intel.com>


