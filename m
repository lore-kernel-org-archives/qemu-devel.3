Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6360DC02196
	for <qemu-devel@archiver.kernel.org>; Thu,  6 Feb 2025 10:42:50 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tfzLK-00040B-DZ; Thu, 06 Feb 2025 05:42:46 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1tfzLH-0003zz-8Y; Thu, 06 Feb 2025 05:42:43 -0500
Received: from mgamail.intel.com ([192.198.163.15])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1tfzLE-0003aW-Nb; Thu, 06 Feb 2025 05:42:42 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1738838561; x=1770374561;
 h=date:from:to:cc:subject:message-id:references:
 mime-version:in-reply-to;
 bh=0TuoMBuUpu/g96bN1tn3TkdHhKsGnYB6JKQpBFhrVBI=;
 b=S6qEg6lgHlLWAFzHpDo+WLzjpkQEJ9Hbp8lMVO08CEAw9vZaNPsRxSjy
 DiKlA/qjDACsDsZFBZadaM2/FeTdE2au8W4gGfZe8dHOjqPixv3Gcs0Sl
 EGzceG2WwIhXxjXVM+4zpsFTn0Mth2Yy3TmLPJCdhpcQ5lXWB43E+xqiQ
 M3wyJc3CZIXKPkZeF8gbF2U2+DG//lfieWROA7jMwJCVI+tRfFDpWyFMR
 uNhCZ1E+ISzPSGvAn9LHSy3+o3KHqyvw7/Uc6ug9F0HWZbqUjp8jXpLvb
 kWFWgMg+VwM5yafnJAHgAZ1EC1lYcJxBDe1umPuBdIPhvpiJmFDNjmP3C Q==;
X-CSE-ConnectionGUID: XYOQCyxhSHivGz7vxjuAGg==
X-CSE-MsgGUID: slrd2L+7TWyne6NhdXO2yA==
X-IronPort-AV: E=McAfee;i="6700,10204,11336"; a="39592858"
X-IronPort-AV: E=Sophos;i="6.13,264,1732608000"; d="scan'208";a="39592858"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
 by fmvoesa109.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 06 Feb 2025 02:42:37 -0800
X-CSE-ConnectionGUID: DIGNoqYEQJOQoh3SrxxVTg==
X-CSE-MsgGUID: r7OEm/5XTLOp7U9ER5tb6g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,224,1728975600"; d="scan'208";a="148384471"
Received: from liuzhao-optiplex-7080.sh.intel.com (HELO localhost)
 ([10.239.160.39])
 by orviesa001.jf.intel.com with ESMTP; 06 Feb 2025 02:42:36 -0800
Date: Thu, 6 Feb 2025 19:02:05 +0800
From: Zhao Liu <zhao1.liu@intel.com>
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: qemu-devel@nongnu.org, qemu-rust@nongnu.org
Subject: Re: [PATCH 2/2] rust: include rust_version in Cargo.toml
Message-ID: <Z6SWrSZ1HSyIc52q@intel.com>
References: <20250129083705.1321407-1-pbonzini@redhat.com>
 <20250129083705.1321407-3-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250129083705.1321407-3-pbonzini@redhat.com>
Received-SPF: pass client-ip=192.198.163.15; envelope-from=zhao1.liu@intel.com;
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

> diff --git a/rust/hw/char/pl011/src/device_class.rs b/rust/hw/char/pl011/src/device_class.rs
> index 8a157a663fb..dbef93f6cb3 100644
> --- a/rust/hw/char/pl011/src/device_class.rs
> +++ b/rust/hw/char/pl011/src/device_class.rs
> @@ -12,7 +12,6 @@
>  
>  use crate::device::{PL011Registers, PL011State};
>  
> -#[allow(clippy::missing_const_for_fn)]

It seems like a rebase nit since the commit 7d0520398f7f ("rust: prefer
NonNull::new to assertions"), which is not worth an extra commit either.

>  extern "C" fn pl011_clock_needed(opaque: *mut c_void) -> bool {
>      let state = NonNull::new(opaque).unwrap().cast::<PL011State>();
>      unsafe { state.as_ref().migrate_clock }

Reviewed-by: Zhao Liu <zhao1.liu@intel.com>


