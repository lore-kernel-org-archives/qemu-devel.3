Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 224E3C021B8
	for <qemu-devel@archiver.kernel.org>; Tue,  4 Mar 2025 16:45:09 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tpVNX-00032V-Ue; Tue, 04 Mar 2025 11:44:24 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1tpVNH-00031D-Dk; Tue, 04 Mar 2025 11:44:09 -0500
Received: from mgamail.intel.com ([198.175.65.14])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1tpVNE-0002Zv-EF; Tue, 04 Mar 2025 11:44:07 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1741106645; x=1772642645;
 h=date:from:to:cc:subject:message-id:references:
 mime-version:in-reply-to;
 bh=auieZzgOTOCYKBrvQYZJmSQkHiOvD/6ruV0hO5lxmYs=;
 b=oHmtzP1WFdzMDpP7aekvKyWy2N6nJU3g3tqUr2o5xtTGB5CAvrzNBB8y
 e2NwVdZ0mVm3od7nUEpmDID+McKmXRNym7z3jF6A0etIYbIAaWM268wim
 XH+eVUPEX+38EaZV4PD8bdUjco7Z6+c0RpabJFl8HNF657YQXlSMOhwZL
 qqkLXeQmtoTLvxxFYDTm6Kcg/FWPqnfcfbKz9Qmd6QJeAXzs9D0gIrEYf
 02k98boAY21manBkX6VtwwIpnrOuhmplXoKqZ39gXAeJ+VSfxOYswiUTE
 XIKymAzAf73bd8l/oUW7OH53SG+EjkdGQjiC3Ny+uPNbg1SvtPojqG1Jw A==;
X-CSE-ConnectionGUID: 6y8FR2wLSjWbMYxRVty3TA==
X-CSE-MsgGUID: 3+piKya1QAGI61F/oM2v1Q==
X-IronPort-AV: E=McAfee;i="6700,10204,11363"; a="45811462"
X-IronPort-AV: E=Sophos;i="6.14,220,1736841600"; d="scan'208";a="45811462"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
 by orvoesa106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 04 Mar 2025 08:44:00 -0800
X-CSE-ConnectionGUID: FmpUDhfUSYG1peJLfa4GMA==
X-CSE-MsgGUID: XAI/oKgXRq+UWzYm8BPQxA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,224,1728975600"; d="scan'208";a="155615156"
Received: from liuzhao-optiplex-7080.sh.intel.com (HELO localhost)
 ([10.239.160.39])
 by orviesa001.jf.intel.com with ESMTP; 04 Mar 2025 08:43:58 -0800
Date: Wed, 5 Mar 2025 01:04:05 +0800
From: Zhao Liu <zhao1.liu@intel.com>
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: qemu-devel@nongnu.org, qemu-rust@nongnu.org
Subject: Re: [PATCH] rust: cell: add full example of declaring a SysBusDevice
Message-ID: <Z8cyhSfdeTufVzaj@intel.com>
References: <20250228085506.846381-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250228085506.846381-1-pbonzini@redhat.com>
Received-SPF: pass client-ip=198.175.65.14; envelope-from=zhao1.liu@intel.com;
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

> +//! ### Example
> +//!
> +//! ```
> +//! # use qemu_api::prelude::*;
> +//! # use qemu_api::{c_str, cell::BqlRefCell, irq::InterruptSource, irq::IRQState};
> +//! # use qemu_api::{sysbus::SysBusDevice, qom::Owned, qom::ParentField};
> +//! # const N_GPIOS: usize = 8;
> +//! # struct PL061Registers { /* ... */ }
> +//! # unsafe impl ObjectType for PL061Device {
> +//! #     type Class = <SysBusDevice as ObjectType>::Class;
> +//! #     const TYPE_NAME: &'static std::ffi::CStr = c_str!("pl061");
> +//! # }
> +//! struct PL061Device {

Maybe PL061State?

> +//!     parent_obj: ParentField<SysBusDevice>,
> +//!
> +//!     // Configuration is read-only after initialization
> +//!     pullups: u32,
> +//!     pulldowns: u32,
> +//!
> +//!     // Same for sub-objects of the device
> +//!     out: [Owned<IRQState>; N_GPIOS],

Should this be InterruptSource type?

Just have a quick look at pl061.c:

qdev_init_gpio_out(dev, s->out, N_GPIOS);

So in Rust side, `out` would be initialized by
DeviceMethods::init_gpio_out().


Others are fine for me ~ with above nits fixed,

Reviewed-by: Zhao Liu <zhao1.liu@intel.com>


