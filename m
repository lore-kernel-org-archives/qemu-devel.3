Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 50B07C28B30
	for <qemu-devel@archiver.kernel.org>; Thu, 20 Mar 2025 15:27:12 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tvHmO-0005qU-RK; Thu, 20 Mar 2025 11:25:56 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1tvHlx-0005l1-Ve; Thu, 20 Mar 2025 11:25:33 -0400
Received: from mgamail.intel.com ([198.175.65.16])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1tvHlr-0001Gu-RC; Thu, 20 Mar 2025 11:25:26 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1742484324; x=1774020324;
 h=date:from:to:cc:subject:message-id:references:
 mime-version:in-reply-to;
 bh=dAWOaP+0FbLf9uH4qvwuCLfmXr3QhrjyHbQfnvFQ/wA=;
 b=gHXgBX/T34Y/WQS+86qGt4JKxyuVp7Kr5IyhZqNk/RUOvyMVKoAMOlnt
 2qBHwcHVIBXD/Ikr8bpKCSiiB1CWdAWB9WFy3MHzRC29kBTQ0+LjTJ1j5
 O0mAav0nYo0qhHu6/tMOgFiEPpcrh/d8ZkF8LdqoWvJV874Jl2ULgS2/j
 hc11Fb5c0rAsfq3CHqwrQ61/tz7+zvQ4jZpnOq0hGodLRKwnuCLv9MCta
 9heN14zybUX+8B46XOW/jZEp8H5RgMPJguM/NWWtgoQEQQi25xn+Akekf
 l4Tl8NgTvWmfGSH4K3Drw9HhW7FmMr2NbilbiLLN4ujNyhz5mYrXJo+/U w==;
X-CSE-ConnectionGUID: MQ6rG2G3TaWG++V7HWvIIQ==
X-CSE-MsgGUID: xYqmbuLlSLmSc6GpURIr4Q==
X-IronPort-AV: E=McAfee;i="6700,10204,11379"; a="43839711"
X-IronPort-AV: E=Sophos;i="6.14,262,1736841600"; d="scan'208";a="43839711"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
 by orvoesa108.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 20 Mar 2025 08:25:17 -0700
X-CSE-ConnectionGUID: W2aHOjWmQR+YpemcmgSlIA==
X-CSE-MsgGUID: pQ1MAg9VTZ+92rWx8HeCgQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.14,262,1736841600"; d="scan'208";a="128226883"
Received: from liuzhao-optiplex-7080.sh.intel.com (HELO localhost)
 ([10.239.160.39])
 by fmviesa004.fm.intel.com with ESMTP; 20 Mar 2025 08:25:16 -0700
Date: Thu, 20 Mar 2025 23:45:30 +0800
From: Zhao Liu <zhao1.liu@intel.com>
To: Peter Maydell <peter.maydell@linaro.org>
Cc: qemu-arm@nongnu.org, qemu-devel@nongnu.org, qemu-rust@nongnu.org,
 Paolo Bonzini <pbonzini@redhat.com>
Subject: Re: [PATCH 3/3] rust: pl011: Check size of state struct at compile
 time
Message-ID: <Z9w4Gttv8QeBRKfZ@intel.com>
References: <20250320133248.1679485-1-peter.maydell@linaro.org>
 <20250320133248.1679485-4-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250320133248.1679485-4-peter.maydell@linaro.org>
Received-SPF: pass client-ip=198.175.65.16; envelope-from=zhao1.liu@intel.com;
 helo=mgamail.intel.com
X-Spam_score_int: -46
X-Spam_score: -4.7
X-Spam_bar: ----
X-Spam_report: (-4.7 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.332,
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

> -use std::{ffi::CStr, ptr::addr_of_mut};
> +use std::{ffi::CStr, mem, ptr::addr_of_mut};

maybe mem::size_of (since there're 2 use cases :-))? 

>  
>  use qemu_api::{
> +    bindings,
>      chardev::{CharBackend, Chardev, Event},
> +    static_assert,

This one looks like it breaks the alphabetical ordering (this nit can be
checked and fixed by "cargo +nightly fmt" under rust directory, which is
like checkpatch.pl).

>      impl_vmstate_forward,
>      irq::{IRQState, InterruptSource},
>      memory::{hwaddr, MemoryRegion, MemoryRegionOps, MemoryRegionOpsBuilder},
> @@ -124,6 +126,12 @@ pub struct PL011State {
>      pub migrate_clock: bool,
>  }
>  
> +// Some C users of this device embed its state struct into their own
> +// structs, so the size of the Rust version must not be any larger
> +// than the size of the C one. If this assert triggers you need to
> +// expand the padding_for_rust[] array in the C PL011State struct.
> +static_assert!(mem::size_of::<PL011State>() <= mem::size_of::<bindings::PL011State>());
> +

maybe use qemu_api::bindings::PL011State directly? Because bindings
contains native C structures/functions and their use should not be
encouraged, I think it's better to 'hide' bindings (not list it at the
beginning of the file).

Otherwise,

Reviewed-by: Zhao Liu <zhao1.liu@intel.com>


