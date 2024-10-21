Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 68C0CD3C53F
	for <qemu-devel@archiver.kernel.org>; Mon, 21 Oct 2024 06:17:32 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t2lib-0007YL-W1; Mon, 21 Oct 2024 02:16:42 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1t2lia-0007Xp-AI
 for qemu-devel@nongnu.org; Mon, 21 Oct 2024 02:16:40 -0400
Received: from mgamail.intel.com ([192.198.163.18])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1t2liX-0007D2-8Z
 for qemu-devel@nongnu.org; Mon, 21 Oct 2024 02:16:40 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1729491397; x=1761027397;
 h=date:from:to:cc:subject:message-id:references:
 mime-version:in-reply-to;
 bh=d4ZFc5YyiXoplA/55/LQMCKBH9InbCA6Z2QZJgKewDE=;
 b=gHcq/mmaarKvhb1KQII8OSjDdOP/uEK3IZ6tuL8RGlI/eyIpPqEy/dau
 c/OciX6xk1Zdt2LQQwdanMisnUPjpwfI8bKpgBeOKcjKNsghsx/h7EFkg
 n9yFengaRucviVWy560DPfUN9bvbQC9mK3cYn4HeFPZn7lsqBLyhjCGMh
 VOrQAiDAgOlKp+g8ktF4BUIKDPPkTV/yIhdKWizlr1ZQBJUhQRfyGwMAC
 Y2+Z2WD2f8hWzKhaP+ve/wbHqW2rou0yZ1WHG9wgmjNlg0OhTHsQNNXUn
 0sEP1XNnfrGMzZONIMAJAyKipGaSZK94xIM0YivRh1FOV+IXZyKaPAwRt A==;
X-CSE-ConnectionGUID: qatdqHirReyhQe+5FXGmYg==
X-CSE-MsgGUID: 6dQjJuX3QCyqPRH485kxTg==
X-IronPort-AV: E=McAfee;i="6700,10204,11231"; a="28394230"
X-IronPort-AV: E=Sophos;i="6.11,220,1725346800"; d="scan'208";a="28394230"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
 by fmvoesa112.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 20 Oct 2024 23:16:30 -0700
X-CSE-ConnectionGUID: U4nxoHdCQ9+xyv/eyPdSHw==
X-CSE-MsgGUID: Q+NU8eNaRqWonhR3OaqlNg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,220,1725346800"; d="scan'208";a="110268341"
Received: from liuzhao-optiplex-7080.sh.intel.com (HELO localhost)
 ([10.239.160.36])
 by orviesa002.jf.intel.com with ESMTP; 20 Oct 2024 23:16:28 -0700
Date: Mon, 21 Oct 2024 14:32:45 +0800
From: Zhao Liu <zhao1.liu@intel.com>
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: qemu-devel@nongnu.org
Subject: Re: [PATCH 03/16] rust: pass rustc_args when building all crates
Message-ID: <ZxX1jSkJ3Muk11zC@intel.com>
References: <20241015131735.518771-1-pbonzini@redhat.com>
 <20241015131735.518771-4-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241015131735.518771-4-pbonzini@redhat.com>
Received-SPF: pass client-ip=192.198.163.18; envelope-from=zhao1.liu@intel.com;
 helo=mgamail.intel.com
X-Spam_score_int: -48
X-Spam_score: -4.9
X-Spam_bar: ----
X-Spam_report: (-4.9 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.527,
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

On Tue, Oct 15, 2024 at 03:17:21PM +0200, Paolo Bonzini wrote:
> Date: Tue, 15 Oct 2024 15:17:21 +0200
> From: Paolo Bonzini <pbonzini@redhat.com>
> Subject: [PATCH 03/16] rust: pass rustc_args when building all crates
> X-Mailer: git-send-email 2.46.2
> 
> rustc_args is needed to smooth the difference in warnings between the various
> versions of rustc.  Always include those arguments.
> 
> Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
> ---
>  meson.build                       | 18 +++++++++++-------
>  rust/qemu-api/meson.build         |  2 +-
>  rust/qemu-api/src/device_class.rs | 10 ++++++----
>  3 files changed, 18 insertions(+), 12 deletions(-)

LGTM (with one trivial comment inline)

Reviewed-by: Zhao Liu <zhao1.liu@intel.com>

> diff --git a/rust/qemu-api/src/device_class.rs b/rust/qemu-api/src/device_class.rs
> index 1ea95beb78d..b6b68cf9ce2 100644
> --- a/rust/qemu-api/src/device_class.rs
> +++ b/rust/qemu-api/src/device_class.rs
> @@ -16,10 +16,12 @@ macro_rules! device_class_init {
>          ) {
>              let mut dc =
>                  ::core::ptr::NonNull::new(klass.cast::<$crate::bindings::DeviceClass>()).unwrap();
> -            dc.as_mut().realize = $realize_fn;
> -            dc.as_mut().vmsd = &$vmsd;
> -            $crate::bindings::device_class_set_legacy_reset(dc.as_mut(), $legacy_reset_fn);
> -            $crate::bindings::device_class_set_props(dc.as_mut(), $props.as_mut_ptr());
> +            unsafe {
> +                dc.as_mut().realize = $realize_fn;
> +                dc.as_mut().vmsd = &$vmsd;
> +                $crate::bindings::device_class_set_legacy_reset(dc.as_mut(), $legacy_reset_fn);
> +                $crate::bindings::device_class_set_props(dc.as_mut(), $props.as_mut_ptr());
> +            }

The issue exists because the unsafe_op_in_unsafe_fn is allowed in
rust/qemu-api/src/lib.rs. So should we wrap the bindings in a separate
lib (similar to the rust/bindings in the Linux kernel)?

This way, the special lint settings can be applied only to the binding
files, while the default lint checks can cover the other user
development code.

In addition, another thing that confuses me is why bindgen still
generates code that does not follow the unsafe_op_in_unsafe_fn
requirement. It seems that bindgen has supported unsafe_op_in_unsafe_fn
since v0.62 [1, 2], but binding code we generated still violates
unsafe_op_in_unsafe_fn. Is this a bug of bindgen?

[1]: https://github.com/rust-lang/rust-bindgen/pull/2266 
[2]: https://github.com/rust-lang/rust-bindgen/blob/main/CHANGELOG.md#changed-12

Regards,
Zhao



