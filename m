Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D54D8E7717F
	for <qemu-devel@archiver.kernel.org>; Tue, 17 Dec 2024 14:45:49 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tNYpD-0003Vx-1t; Tue, 17 Dec 2024 09:45:27 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1tNYp8-0003VT-Gt; Tue, 17 Dec 2024 09:45:22 -0500
Received: from mgamail.intel.com ([198.175.65.21])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1tNYp6-0007Ju-DA; Tue, 17 Dec 2024 09:45:22 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1734446721; x=1765982721;
 h=date:from:to:cc:subject:message-id:references:
 mime-version:in-reply-to;
 bh=iptoBTJPS9MacQBKezLAbV1jlTY3hrIeBNktHV6LGMo=;
 b=HyY8A7+LYJxmT0kZjEAiypayb3hZRxgp/3pAT1yVW/fu4fucsNiaS4sV
 vg1T6UIt0FqUb4RABhFr7BR/VjsXFCRxYKaT4unOjbyoLbygc62GPzULu
 z9kVEP2b9u8K85j1HRhDnMuSiCF/4qUbWAdNR/xjZS/2Jgg2ExjK0lePF
 wv8zN7ykCY3Gz7llRxA8den2VEGIM7wKvsyTYby71sse2gyCfIgsDpDdD
 Ny7Kw43AxB9BBXiENisuVjbfh/cmsXQyXwiMRjy+8BsVw6zMvJwE/sqJY
 kbnePF/l1P8jDEPh/uM6V2XyTn8s+Njr2wPq21IntRXqqYpeJh8Tj35MT w==;
X-CSE-ConnectionGUID: NAIFhPhhRz28qybmw1KHIQ==
X-CSE-MsgGUID: bTcF9utXQfy7Pr025ttVpg==
X-IronPort-AV: E=McAfee;i="6700,10204,11288"; a="34783776"
X-IronPort-AV: E=Sophos;i="6.12,242,1728975600"; d="scan'208";a="34783776"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
 by orvoesa113.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 17 Dec 2024 06:45:16 -0800
X-CSE-ConnectionGUID: 9KKPAgOgQB+rv6A2Dnmp1Q==
X-CSE-MsgGUID: H9DEf4S8Qou+Pimnv8X20Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,224,1728975600"; d="scan'208";a="97404397"
Received: from liuzhao-optiplex-7080.sh.intel.com (HELO localhost)
 ([10.239.160.39])
 by orviesa010.jf.intel.com with ESMTP; 17 Dec 2024 06:45:15 -0800
Date: Tue, 17 Dec 2024 23:03:54 +0800
From: Zhao Liu <zhao1.liu@intel.com>
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: qemu-devel@nongnu.org, qemu-rust@nongnu.org,
 Junjie Mao <junjie.mao@hotmail.com>
Subject: Re: [PATCH 25/26] rust: qemu-api: add a module to wrap functions and
 zero-sized closures
Message-ID: <Z2GS2vs/eGfQ/lhL@intel.com>
References: <20241209123717.99077-1-pbonzini@redhat.com>
 <20241209123717.99077-26-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241209123717.99077-26-pbonzini@redhat.com>
Received-SPF: pass client-ip=198.175.65.21; envelope-from=zhao1.liu@intel.com;
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

> +pub unsafe trait FnCall<Args, R = ()>: 'static + Sync + Sized {
> +    /// Referring to this internal constant asserts that the `Self` type is
> +    /// zero-sized.  Can be replaced by an inline const expression in
> +    /// Rust 1.79.0+.
> +    const ASSERT_ZERO_SIZED: () = { assert!(mem::size_of::<Self>() == 0) };
> +
> +    /// Call the function with the arguments in args.
> +    fn call(a: Args) -> R;
> +}
> +
> +macro_rules! impl_call {
> +    ($($args:ident,)* ) => (
> +        // SAFETY: because each function is treated as a separate type,
> +        // accessing `FnCall` is only possible in code that would be
> +        // allowed to call the function.
> +        unsafe impl<F, $($args,)* R> FnCall<($($args,)*), R> for F
> +        where
> +            F: 'static + Sync + Sized + Fn($($args, )*) -> R,
> +        {
> +            #[inline(always)]
> +            fn call(a: ($($args,)*)) -> R {
> +                let _: () = Self::ASSERT_ZERO_SIZED;
> +
> +                // SAFETY: the safety of this method is the condition for implementing
> +                // `FnCall`.  As to the `NonNull` idiom to create a zero-sized type,
> +                // see https://github.com/rust-lang/libs-team/issues/292.
> +                let f: &'static F = unsafe { &*NonNull::<Self>::dangling().as_ptr() };

Awesome! The definition of FnCall and this trick are both very elegant!
I've learned a lot.

> +                let ($($args,)*) = a;
> +                f($($args,)*)
> +            }
> +        }
> +    )
> +}
> +

The examples and test both show the power of this callback pattern,

Reviewed-by: Zhao Liu <zhao1.liu@intel.com>


