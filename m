Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6EDA9CCF9E0
	for <qemu-devel@archiver.kernel.org>; Mon, 27 Oct 2025 06:01:43 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vDGII-0000dB-7X; Mon, 27 Oct 2025 02:01:26 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1vDGIA-0000cZ-H0; Mon, 27 Oct 2025 02:01:18 -0400
Received: from mgamail.intel.com ([192.198.163.13])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1vDGI8-0003UJ-Ek; Mon, 27 Oct 2025 02:01:18 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1761544876; x=1793080876;
 h=date:from:to:cc:subject:message-id:references:
 mime-version:in-reply-to;
 bh=5GcIoUEbVLn4r+3U/67dMJ9YrkF59pGKydiph58TFY8=;
 b=DfTieBzVvornEUmXTDmpxfjirvWiOmxF/lJQ6iPl6ccTvG6M44DHe08t
 piOErBONLcDWOR9OwVb+b0RB/DI1gsFCo4ngDRgE5MNdrD+dgq/z+vxGB
 nkbCVzaRF7AZcndUL6qLUoR20oHvBwxTAtuqGgmsORre9DUtMa+gWHv4M
 l4IuRDIIfRgMgyH6+OUgIAaA3OY4sM0nfH3GPzyPGwIRBDkct9wMt0clU
 2oTdP5SVAPb17HgSFywdbuvrEPIZLYS8UWAaAxIwRhFRFU46N+QzfNpZT
 6oeNU2qjs5qgLETFMZyuDW9h/2CQ4jCSq+lWqBAwB34+MHyukAli0UfjX w==;
X-CSE-ConnectionGUID: IADjHUOKQ2OciG76INq6BQ==
X-CSE-MsgGUID: 7zQhILgGRr+uphxlUdxmkQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11586"; a="66233881"
X-IronPort-AV: E=Sophos;i="6.19,258,1754982000"; d="scan'208";a="66233881"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
 by fmvoesa107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 26 Oct 2025 23:01:13 -0700
X-CSE-ConnectionGUID: 6VkfQLnMTGir/KE97NJcTQ==
X-CSE-MsgGUID: c8GKq0NzSsK5HQMCJryC3g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.19,258,1754982000"; d="scan'208";a="184570122"
Received: from liuzhao-optiplex-7080.sh.intel.com (HELO localhost)
 ([10.239.160.39])
 by orviesa009.jf.intel.com with ESMTP; 26 Oct 2025 23:01:11 -0700
Date: Mon, 27 Oct 2025 14:23:20 +0800
From: Zhao Liu <zhao1.liu@intel.com>
To: chenmiao <chenmiao@openatom.club>
Cc: pbonzini@redhat.com, manos.pitsidianakis@linaro.org,
 richard.henderson@linaro.org, philmd@linaro.org,
 qemu-rust@nongnu.org, qemu-devel@nongnu.org,
 hust-os-kernel-patches@googlegroups.com
Subject: Re: [RFC 1/5] rust: hw: core: Add the BusState of rust version
Message-ID: <aP8P2H0qk0yJMPe3@intel.com>
References: <20251025123853.63139-2-chenmiao@openatom.club>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251025123853.63139-2-chenmiao@openatom.club>
Received-SPF: pass client-ip=192.198.163.13; envelope-from=zhao1.liu@intel.com;
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

On Sat, Oct 25, 2025 at 12:38:49PM +0000, chenmiao wrote:
> Date: Sat, 25 Oct 2025 12:38:49 +0000
> From: chenmiao <chenmiao@openatom.club>
> Subject: [RFC 1/5] rust: hw: core: Add the BusState of rust version
> X-Mailer: git-send-email 2.43.0
> 
> A Rust version implementation has been designed for BusState,
> which will be used for the subsequent I2CBus implementation.
> 
> Signed-off-by: chenmiao <chenmiao@openatom.club>
> ---
>  rust/hw/core/meson.build |  1 +
>  rust/hw/core/src/bus.rs  | 51 ++++++++++++++++++++++++++++++++++++++++
>  rust/hw/core/src/lib.rs  |  3 +++
>  3 files changed, 55 insertions(+)
>  create mode 100644 rust/hw/core/src/bus.rs

After a quick glance, I think this BusState is implemented quite well.

Only a few minor nits inline:

...

> +pub trait BusStateImpl: DeviceImpl + IsA<BusState> {}
> +
> +impl BusClass {
> +    pub fn class_init<T: BusStateImpl>(self: &mut BusClass) {
> +        self.parent_class.class_init::<T>();
> +    }
> +}
> +
> +pub trait BusStateMethods: ObjectDeref

This can be named BusMethods - just like DeviceMethods did.

> +where
> +    Self::Target: IsA<BusState>,
> +{
> +    fn bus_realize(&self) {

"bus_" prefix is not needed:

dummy_bus.realize() is clear and enough.

> +        assert!(bql::is_locked());

It's better to add safety comment from beginning (// SAFETY: xxx).

> +        unsafe {
> +            bindings::qbus_realize(
> +                self.upcast().as_mut_ptr(),
> +                addr_of_mut!(util::bindings::error_fatal),
> +            );
> +        }
> +    }
> +}

Regards,
Zhao



