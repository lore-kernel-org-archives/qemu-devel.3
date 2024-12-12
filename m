Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B763FE77180
	for <qemu-devel@archiver.kernel.org>; Thu, 12 Dec 2024 09:35:08 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tLfaw-00031C-Ks; Thu, 12 Dec 2024 04:34:54 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1tLfav-00030x-Jj; Thu, 12 Dec 2024 04:34:53 -0500
Received: from mgamail.intel.com ([198.175.65.9])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1tLfap-0006cQ-Vq; Thu, 12 Dec 2024 04:34:53 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1733996088; x=1765532088;
 h=date:from:to:cc:subject:message-id:references:
 mime-version:in-reply-to;
 bh=Ciluf764JPJfsHq9Nkh6FmiN6HvdYzCFWGzi8reLiRo=;
 b=Zln6SXBLa6q25Ku65+xvAiQ5SOvHWgUMi0oIjuW+bExF+El9FKNvTLPL
 ruFUkJX1S5mXchwG18YNypO/hF9kICvjDjbCBlBHy9P8Z5GPzbO1wVE0B
 P14CkBp0qEQirnKADVL+GUGwHi23HrRWaS16KbruCmbA6DymWxYVtFtYL
 3ZWvHWzdLWa1+uScXkliGkUtFXvCVGamf+DGRzgsvSuKpKSQ8D00nNHvN
 qImvd1WbceSgS6U1FXrunJO4AtJD7T1yQAIr+qiKpvLs+f6xkj0QFjQ1X
 lb8ZyH0J66ZLHWVfY3nZU/cDAJZe0mwXRT9mxiEwzxJExMu7uDjCToZlS w==;
X-CSE-ConnectionGUID: sbjZHNI5TGeyJ+iyciQa3g==
X-CSE-MsgGUID: +hSpe/V9S2uqHugjgf0fug==
X-IronPort-AV: E=McAfee;i="6700,10204,11283"; a="56878431"
X-IronPort-AV: E=Sophos;i="6.12,228,1728975600"; d="scan'208";a="56878431"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
 by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 12 Dec 2024 01:34:43 -0800
X-CSE-ConnectionGUID: lPuDF8y3TICo5WlQaN0dGA==
X-CSE-MsgGUID: 41l9TdpJSdCnUDOhQpoPXQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,228,1728975600"; d="scan'208";a="96070015"
Received: from liuzhao-optiplex-7080.sh.intel.com (HELO localhost)
 ([10.239.160.36])
 by orviesa009.jf.intel.com with ESMTP; 12 Dec 2024 01:34:43 -0800
Date: Thu, 12 Dec 2024 17:52:57 +0800
From: Zhao Liu <zhao1.liu@intel.com>
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: qemu-devel@nongnu.org, qemu-rust@nongnu.org,
 Junjie Mao <junjie.mao@hotmail.com>
Subject: Re: [PATCH 19/26] rust: rename qemu-api modules to follow C code a
 bit more
Message-ID: <Z1qyeThRA8yJMMoM@intel.com>
References: <20241209123717.99077-1-pbonzini@redhat.com>
 <20241209123717.99077-20-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241209123717.99077-20-pbonzini@redhat.com>
Received-SPF: pass client-ip=198.175.65.9; envelope-from=zhao1.liu@intel.com;
 helo=mgamail.intel.com
X-Spam_score_int: -48
X-Spam_score: -4.9
X-Spam_bar: ----
X-Spam_report: (-4.9 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.472,
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

On Mon, Dec 09, 2024 at 01:37:10PM +0100, Paolo Bonzini wrote:
> Date: Mon,  9 Dec 2024 13:37:10 +0100
> From: Paolo Bonzini <pbonzini@redhat.com>
> Subject: [PATCH 19/26] rust: rename qemu-api modules to follow C code a bit
>  more
> X-Mailer: git-send-email 2.47.1
> 
> A full match would mean calling them qom::object and hw::core::qdev.  For now,
> keep the names shorter but still a bit easier to find.
> 
> Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
> ---
>  rust/hw/char/pl011/src/device.rs              |  4 +-
>  rust/qemu-api-macros/src/lib.rs               |  2 +-
>  rust/qemu-api/meson.build                     |  5 +-
>  rust/qemu-api/src/lib.rs                      |  5 +-
>  rust/qemu-api/src/module.rs                   | 43 +++++++++++
>  rust/qemu-api/src/prelude.rs                  |  2 +-
>  .../qemu-api/src/{device_class.rs => qdev.rs} |  4 +-
>  rust/qemu-api/src/{definitions.rs => qom.rs}  | 74 +++++++++----------
>  rust/qemu-api/src/sysbus.rs                   |  2 +-
>  rust/qemu-api/tests/tests.rs                  |  5 +-
>  10 files changed, 92 insertions(+), 54 deletions(-)
>  create mode 100644 rust/qemu-api/src/module.rs
>  rename rust/qemu-api/src/{device_class.rs => qdev.rs} (97%)
>  rename rust/qemu-api/src/{definitions.rs => qom.rs} (83%)
> 
> --- a/rust/qemu-api/src/definitions.rs
> +++ b/rust/qemu-api/src/qom.rs
> @@ -2,7 +2,37 @@
>  // Author(s): Manos Pitsidianakis <manos.pitsidianakis@linaro.org>
>  // SPDX-License-Identifier: GPL-2.0-or-later
>  
> -//! Definitions required by QEMU when registering a device.
> +//! Bindings to access QOM functionality from Rust.
> +//!
> +//! This module provides automatic creation and registration of `TypeInfo`
> +//! for classes that are written in Rust, and mapping between Rust traits
> +//! and QOM vtables.
> +//!
> +//! # Structure of a class
> +//!
> +//! A concrete class only needs a struct holding instance state. The struct must
> +//! implement the [`ObjectType`] and [`IsA`] traits, as well as any `*Impl`
> +//! traits provided by its superclasses.

In this commit, this comment is a bit ahead, but I think it's okay.

qom and qdev are both good names. In addition, we can rename the files
of PL011 as well. Perhaps device_class.rs could be merged into device.rs
(and eventually renamed to pl011.rs). I guess you might be planning to
keep it until the cleanup of vmstate and property is done.

Reviewed-by: Zhao Liu <zhao1.liu@intel.com>


