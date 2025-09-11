Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E9604CAC58D
	for <qemu-devel@archiver.kernel.org>; Thu, 11 Sep 2025 10:22:55 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uweRn-0007Zk-Bb; Thu, 11 Sep 2025 06:22:35 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1uweRb-0007Wl-Ig
 for qemu-devel@nongnu.org; Thu, 11 Sep 2025 06:22:26 -0400
Received: from mgamail.intel.com ([198.175.65.15])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1uweRU-0000Mj-AW
 for qemu-devel@nongnu.org; Thu, 11 Sep 2025 06:22:21 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1757586137; x=1789122137;
 h=date:from:to:cc:subject:message-id:references:
 mime-version:content-transfer-encoding:in-reply-to;
 bh=1x79j2Kqg8nPF49BSzIXy261x7pdpLDo8WzH3odKgbo=;
 b=Rik82+0n1LJ/OYmdx8ih8T5AYgFMVCFlX3x7udWsBQKc76nBoUaVD1kW
 dAVqe1gRxUVUEyiPPc3afqOykTNfcwoxYXX1pYQdHv0eVSFxOXfvpgBTk
 DlXMpf0XtZNYK7/dFmDwUwBVs4+LycVHLucCpB8uT240w4QxhVq5kx/1u
 AW16mtCnXyxmmoFKHf15gfGvDn2bqR9TRtYgyCQ80SecURy6oAyC7agUq
 AE+1RyQY9JTlCaX6Hj44NOYvhhhFoJo2j/1ax0uBrA0nxI2Cwlf2Y+PM8
 5OGOoU1l/r4yx9J0xcafLi59aMhj7AdXFZ0kqEGQclDrVPh379xZ3xE6g A==;
X-CSE-ConnectionGUID: f33Z53kNR22Dk1AKr1aOQQ==
X-CSE-MsgGUID: vgph4+bRQYmSFbh2l5ZzOg==
X-IronPort-AV: E=McAfee;i="6800,10657,11549"; a="63547332"
X-IronPort-AV: E=Sophos;i="6.18,257,1751266800"; d="scan'208";a="63547332"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
 by orvoesa107.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 11 Sep 2025 03:22:12 -0700
X-CSE-ConnectionGUID: +QL9tGmXRhadwBNyuQF0FQ==
X-CSE-MsgGUID: lHb1Y1sZSNG/sZRH7+CTJw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.18,257,1751266800"; d="scan'208";a="177963996"
Received: from liuzhao-optiplex-7080.sh.intel.com (HELO localhost)
 ([10.239.160.39])
 by orviesa004.jf.intel.com with ESMTP; 11 Sep 2025 03:22:11 -0700
Date: Thu, 11 Sep 2025 18:44:03 +0800
From: Zhao Liu <zhao1.liu@intel.com>
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: qemu-devel@nongnu.org,
 =?iso-8859-1?Q?Marc-Andr=E9?= Lureau <marcandre.lureau@redhat.com>
Subject: Re: [PATCH 16/33] rust: split Rust-only "common" crate
Message-ID: <aMKn89O0lEC9AIPa@intel.com>
References: <20250908105005.2119297-1-pbonzini@redhat.com>
 <20250908105005.2119297-17-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20250908105005.2119297-17-pbonzini@redhat.com>
Received-SPF: pass client-ip=198.175.65.15; envelope-from=zhao1.liu@intel.com;
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

On Mon, Sep 08, 2025 at 12:49:48PM +0200, Paolo Bonzini wrote:
> Date: Mon,  8 Sep 2025 12:49:48 +0200
> From: Paolo Bonzini <pbonzini@redhat.com>
> Subject: [PATCH 16/33] rust: split Rust-only "common" crate
> X-Mailer: git-send-email 2.51.0
> 
> From: Marc-André Lureau <marcandre.lureau@redhat.com>
> 
> Signed-off-by: Marc-André Lureau <marcandre.lureau@redhat.com>
> Link: https://lore.kernel.org/r/20250827104147.717203-6-marcandre.lureau@redhat.com
> Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
> ---
>  MAINTAINERS                                 |   1 +
>  rust/Cargo.lock                             |  10 +
>  rust/Cargo.toml                             |   1 +
>  rust/common/Cargo.toml                      |  19 ++
>  rust/common/meson.build                     |  34 +++
>  rust/{qemu-api => common}/src/assertions.rs |  16 +-
>  rust/{qemu-api => common}/src/bitops.rs     |   1 -
>  rust/{qemu-api => common}/src/callbacks.rs  |  10 +-
>  rust/{qemu-api => common}/src/errno.rs      |   8 +-
>  rust/common/src/lib.rs                      |  20 ++
>  rust/common/src/opaque.rs                   | 238 ++++++++++++++++++++
>  rust/{qemu-api => common}/src/uninit.rs     |   2 +-
>  rust/common/src/zeroable.rs                 |  18 ++
>  rust/hw/char/pl011/Cargo.toml               |   1 +
>  rust/hw/char/pl011/meson.build              |   3 +-
>  rust/hw/char/pl011/src/device.rs            |   3 +-
>  rust/hw/timer/hpet/Cargo.toml               |   1 +
>  rust/hw/timer/hpet/meson.build              |   3 +-
>  rust/hw/timer/hpet/src/device.rs            |   2 +-
>  rust/hw/timer/hpet/src/fw_cfg.rs            |   3 +-
>  rust/meson.build                            |   1 +
>  rust/qemu-api-macros/src/lib.rs             |  16 +-
>  rust/qemu-api-macros/src/tests.rs           |   6 +-
>  rust/qemu-api/Cargo.toml                    |   1 +
>  rust/qemu-api/meson.build                   |  14 +-
>  rust/qemu-api/src/bindings.rs               |  21 ++
>  rust/qemu-api/src/cell.rs                   | 235 +------------------
>  rust/qemu-api/src/chardev.rs                |   5 +-
>  rust/qemu-api/src/error.rs                  |   3 +-
>  rust/qemu-api/src/irq.rs                    |   3 +-
>  rust/qemu-api/src/lib.rs                    |   6 -
>  rust/qemu-api/src/log.rs                    |   4 +-
>  rust/qemu-api/src/memory.rs                 |   5 +-
>  rust/qemu-api/src/prelude.rs                |   6 +-
>  rust/qemu-api/src/qdev.rs                   |  10 +-
>  rust/qemu-api/src/qom.rs                    |   3 +-
>  rust/qemu-api/src/sysbus.rs                 |   3 +-
>  rust/qemu-api/src/timer.rs                  |   8 +-
>  rust/qemu-api/src/vmstate.rs                |  23 +-
>  rust/qemu-api/src/zeroable.rs               |  37 ---
>  rust/qemu-api/tests/vmstate_tests.rs        |   3 +-
>  41 files changed, 448 insertions(+), 359 deletions(-)
>  create mode 100644 rust/common/Cargo.toml
>  create mode 100644 rust/common/meson.build
>  rename rust/{qemu-api => common}/src/assertions.rs (92%)
>  rename rust/{qemu-api => common}/src/bitops.rs (98%)
>  rename rust/{qemu-api => common}/src/callbacks.rs (97%)
>  rename rust/{qemu-api => common}/src/errno.rs (98%)
>  create mode 100644 rust/common/src/lib.rs
>  create mode 100644 rust/common/src/opaque.rs
>  rename rust/{qemu-api => common}/src/uninit.rs (98%)
>  create mode 100644 rust/common/src/zeroable.rs
>  delete mode 100644 rust/qemu-api/src/zeroable.rs

...

> +/// Stores an opaque value that is shared with C code.
> +///
> +/// Often, C structs can changed when calling a C function even if they are

nit typo (found in kvm forum :) ): s/can changed/can be changed/

> +/// behind a shared Rust reference, or they can be initialized lazily and have
> +/// invalid bit patterns (e.g. `3` for a [`bool`]).  This goes against Rust's
> +/// strict aliasing rules, which normally prevent mutation through shared
> +/// references.
> +///
> +/// Wrapping the struct with `Opaque<T>` ensures that the Rust compiler does not
> +/// assume the usual constraints that Rust structs require, and allows using
> +/// shared references on the Rust side.
> +///
> +/// `Opaque<T>` is `#[repr(transparent)]`, so that it matches the memory layout
> +/// of `T`.
> +#[repr(transparent)]
> +pub struct Opaque<T> {
> +    value: UnsafeCell<MaybeUninit<T>>,
> +    // PhantomPinned also allows multiple references to the `Opaque<T>`, i.e.
> +    // one `&mut Opaque<T>` can coexist with a `&mut T` or any number of `&T`;
> +    // see https://docs.rs/pinned-aliasable/latest/pinned_aliasable/.
> +    _pin: PhantomPinned,
> +}

Reviewed-by: Zhao Liu <zhao1.liu@intel.com>



