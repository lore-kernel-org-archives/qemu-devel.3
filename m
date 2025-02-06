Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3F0F0C0219C
	for <qemu-devel@archiver.kernel.org>; Thu,  6 Feb 2025 07:30:25 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tfwKn-00040M-B9; Thu, 06 Feb 2025 02:30:01 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1tfwKl-000404-EE; Thu, 06 Feb 2025 02:30:00 -0500
Received: from mgamail.intel.com ([192.198.163.16])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1tfwKi-0000Je-Dw; Thu, 06 Feb 2025 02:29:59 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1738826996; x=1770362996;
 h=date:from:to:cc:subject:message-id:references:
 mime-version:in-reply-to;
 bh=2Dl8CD4CEiWIJhHmA5uHRjIfr53pL/pZCraNq9eCULU=;
 b=a4OhdmPHBHN9fF6een2z6fyo5i3rJ5QsmxUS3Pw0bZzmE5MKsqNB/6Jz
 Nl3FsF5gUa7Q4I5gxah1omz+Fk62sRQPFq6uFAx6yuGhVIPvNB2UB797/
 TlJWevn2D+6se8xsWx7syPYUuuktpNt4IfqO7j44BAY0459YQmxHNKSqU
 Dl1bqQUc/h/jx59Btxt4tk+kNiIKAzi4FZ4VI9WEzQ6t0GLoSwF66NpGm
 ex8fhZ7j0SGdVcoM2fyLyMKqnsrlqKUBgoZMY8+GHXE0hnDkV3bMTvRv+
 7RQ50snweV2IT8XV6w8Pj7cKKhPqziXNMZ9L1cFta6ma+QlxFiG8YqZZj g==;
X-CSE-ConnectionGUID: ytRHnIpQQWCnsVISJ3nsmQ==
X-CSE-MsgGUID: bBKTbCpeTwmO1ct9VI5rwQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11336"; a="27019599"
X-IronPort-AV: E=Sophos;i="6.13,263,1732608000"; d="scan'208";a="27019599"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
 by fmvoesa110.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 05 Feb 2025 23:29:51 -0800
X-CSE-ConnectionGUID: wGte8rsKQfOJ+Gyiyvu+rA==
X-CSE-MsgGUID: C3qOvC2mRI+Zt16D1EfUBg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,199,1725346800"; d="scan'208";a="116090642"
Received: from liuzhao-optiplex-7080.sh.intel.com (HELO localhost)
 ([10.239.160.39])
 by orviesa003.jf.intel.com with ESMTP; 05 Feb 2025 23:29:49 -0800
Date: Thu, 6 Feb 2025 15:49:18 +0800
From: Zhao Liu <zhao1.liu@intel.com>
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: qemu-devel@nongnu.org, qemu-rust@nongnu.org
Subject: Re: [PATCH 03/10] rust: qom: add object creation functionality
Message-ID: <Z6RpfkKHEjsQowOW@intel.com>
References: <20250117194003.1173231-1-pbonzini@redhat.com>
 <20250117194003.1173231-4-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250117194003.1173231-4-pbonzini@redhat.com>
Received-SPF: pass client-ip=192.198.163.16; envelope-from=zhao1.liu@intel.com;
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

On Fri, Jan 17, 2025 at 08:39:56PM +0100, Paolo Bonzini wrote:
> Date: Fri, 17 Jan 2025 20:39:56 +0100
> From: Paolo Bonzini <pbonzini@redhat.com>
> Subject: [PATCH 03/10] rust: qom: add object creation functionality
> X-Mailer: git-send-email 2.47.1
> 
> The basic object lifecycle test can now be implemented using safe code!
> 
> Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
> ---
>  rust/hw/char/pl011/src/device.rs | 13 ++++++++-----
>  rust/qemu-api/src/prelude.rs     |  1 +
>  rust/qemu-api/src/qom.rs         | 23 +++++++++++++++++++++--
>  rust/qemu-api/tests/tests.rs     | 30 +++++++++++-------------------
>  4 files changed, 41 insertions(+), 26 deletions(-)
> 
> diff --git a/rust/hw/char/pl011/src/device.rs b/rust/hw/char/pl011/src/device.rs
> index 27563700665..d8409f3d310 100644
> --- a/rust/hw/char/pl011/src/device.rs
> +++ b/rust/hw/char/pl011/src/device.rs
> @@ -690,15 +690,18 @@ pub fn post_load(&self, _version_id: u32) -> Result<(), ()> {
>      irq: qemu_irq,
>      chr: *mut Chardev,
>  ) -> *mut DeviceState {
> +    let pl011 = PL011State::new();
>      unsafe {
> -        let dev: *mut DeviceState = qdev_new(PL011State::TYPE_NAME.as_ptr());
> -        let sysbus: *mut SysBusDevice = dev.cast::<SysBusDevice>();
> -
> +        let dev = pl011.as_mut_ptr::<DeviceState>();
>          qdev_prop_set_chr(dev, c_str!("chardev").as_ptr(), chr);
> -        sysbus_realize_and_unref(sysbus, addr_of_mut!(error_fatal));
> +
> +        let sysbus = pl011.as_mut_ptr::<SysBusDevice>();
> +        sysbus_realize(sysbus, addr_of_mut!(error_fatal));
>          sysbus_mmio_map(sysbus, 0, addr);
>          sysbus_connect_irq(sysbus, 0, irq);
> -        dev
> +
> +        // return the pointer, which is kept alive by the QOM tree; drop owned ref
> +        pl011.as_mut_ptr()

The ref count of Owned<> is decreased on exit, so we need to use
sysbus_realize() instead of sysbus_realize_and_unref() to ensure ref
count is correct at C side.

Initially, I hesitated here for an entire morning because this didn't
seem to conform to the usual usage of sysbus_realize_and_unref() (or,
further, qdev_realize_and_unref()).

But now I realize that qdev_realize() is used for embedded objects,
while qdev_realize_and_unref() is used for non-embedded cases. Therefore,
moving forward, perhaps qdev_realize_and_unref() should not exist on the
Rust side.

Owned<> will automatically drop and thus automatically unref, while
Child<> will not unref. Based on this consideration, I am now convincing
myself that this change (using sysbus_realize()) is reasonable. :-)

In the future, maybe we need some wrappers on qdev_realize()/sysbus_realize().

>      }
>  }

Overall, still fine for me,

Reviewed-by: Zhao Liu <zhao1.liu@intel.com>


