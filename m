Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AAAA4C02182
	for <qemu-devel@archiver.kernel.org>; Thu, 23 Jan 2025 03:26:20 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tanqT-0001yO-Ff; Wed, 22 Jan 2025 22:25:29 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1tanqN-0001xM-Jz; Wed, 22 Jan 2025 22:25:24 -0500
Received: from mgamail.intel.com ([192.198.163.16])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1tanqK-0007oh-El; Wed, 22 Jan 2025 22:25:22 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1737602721; x=1769138721;
 h=date:from:to:cc:subject:message-id:references:
 mime-version:in-reply-to;
 bh=hIuggwS8LttmgUG+c9Sg/8e9bPRYZ5hol/G0goAP4Ws=;
 b=NzFul1n94+WCzDsFjGOvLAVZP4f7Y6YuHIOwILWhkL5ObgjVK6wNcIlo
 E83zD4hO8c0/4CmsbCuiyji8aUwcNOvsfdNxEBpB0Nr7s5HgZHSeaz1A1
 c5DZ/lAsz39Y+LtVZ6zQiOIse/dhFnm2chNoxHLrN3dNxUtf1W1vFF1VK
 aAsQrEzypqX+y0J6T/spqAaHTeSK96xWwItaCWUOqJt29U9rV83jVjJm4
 s/XOzZPF3kP9xKV7i3zxw+jsygsdDjoiAtuchTchVxrhsE4TeBK7HB+tX
 XKjzquJqwyyan6IniVx50YI26NjPBCfn36s/5qVAn6CxBOnIu6bvsv+xI w==;
X-CSE-ConnectionGUID: zojbp44CRbiy7S7pAsEMRA==
X-CSE-MsgGUID: oBlCFFTmQFOpDfu6MeYmwg==
X-IronPort-AV: E=McAfee;i="6700,10204,11323"; a="25687667"
X-IronPort-AV: E=Sophos;i="6.13,227,1732608000"; d="scan'208";a="25687667"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
 by fmvoesa110.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 22 Jan 2025 19:25:16 -0800
X-CSE-ConnectionGUID: 6DnP22rGR52bfR9yqUbNlA==
X-CSE-MsgGUID: 30HWyjWeTbSbIuPFBBvgUw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,224,1728975600"; d="scan'208";a="111352544"
Received: from liuzhao-optiplex-7080.sh.intel.com (HELO localhost)
 ([10.239.160.39])
 by fmviesa003.fm.intel.com with ESMTP; 22 Jan 2025 19:25:06 -0800
Date: Thu, 23 Jan 2025 11:44:28 +0800
From: Zhao Liu <zhao1.liu@intel.com>
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: qemu-devel@nongnu.org, qemu-rust@nongnu.org
Subject: Re: [PATCH 06/10] rust: pl011: extract PL011Registers
Message-ID: <Z5G7HOjOfvE9+810@intel.com>
References: <20250117092657.1051233-1-pbonzini@redhat.com>
 <20250117092657.1051233-7-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250117092657.1051233-7-pbonzini@redhat.com>
Received-SPF: pass client-ip=192.198.163.16; envelope-from=zhao1.liu@intel.com;
 helo=mgamail.intel.com
X-Spam_score_int: -73
X-Spam_score: -7.4
X-Spam_bar: -------
X-Spam_report: (-7.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-2.996,
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

> --- a/rust/hw/char/pl011/src/device_class.rs
> +++ b/rust/hw/char/pl011/src/device_class.rs
> @@ -6,11 +6,11 @@
>  use std::os::raw::{c_int, c_void};
>  
>  use qemu_api::{
> -    bindings::*, c_str, vmstate_clock, vmstate_fields, vmstate_of, vmstate_subsections,
> -    vmstate_unused, zeroable::Zeroable,
> +    bindings::*, c_str, vmstate_clock, vmstate_fields, vmstate_of, vmstate_struct,

Oops, I forgot to clean up this bindings::*.

> +    vmstate_subsections, vmstate_unused, zeroable::Zeroable,
>  };
>  

Very good example!

Reviewed-by: Zhao Liu <zhao1.liu@intel.com>


