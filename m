Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 743AEC021B2
	for <qemu-devel@archiver.kernel.org>; Tue, 25 Feb 2025 06:27:26 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tmoPB-00079s-Az; Tue, 25 Feb 2025 01:26:57 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1tmoP2-00079N-Pg; Tue, 25 Feb 2025 01:26:48 -0500
Received: from mgamail.intel.com ([192.198.163.8])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1tmoOy-0001FC-6y; Tue, 25 Feb 2025 01:26:47 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1740464804; x=1772000804;
 h=date:from:to:cc:subject:message-id:references:
 mime-version:in-reply-to;
 bh=gcnnrlfbep+3n+TB3ISdH1THmG3D+qNZIJZlMekACzU=;
 b=dewLFsTkOLOjK+Am0leJChEGEQjGBEohQzN0v+sE2MvZbRpTQZo3Kmut
 H9sev64XT18qgiSYCqLq+SBwInARGkyT5NtNYvjaVHGKK81nxYdqYxWW4
 l36W5kB8yHEfVdzxZZACmgZNMdFNJHUEe/ImyeXvFg8mQeMUkZOp2z2nL
 iY4ILw5TD3SA3tDkbRHouYASQjXg0YtHQ+MKEB+NJhCBv6V6nKrywsWTU
 DVWCIRq/UTkMJer57uWpw5cBptQYJqz8hLEYdTTj3rsgo8Yuwc4qZqqo0
 q5WLsJK4cdzwP7zK23kbpVlenhMZuhNxfvAlc4d+a0Zzo0DBkBbF7M1ji w==;
X-CSE-ConnectionGUID: LDM/YHplQ6CAGY0+Dsulsg==
X-CSE-MsgGUID: pi/tzc8iQT24LKXi/dXZ/A==
X-IronPort-AV: E=McAfee;i="6700,10204,11355"; a="58796535"
X-IronPort-AV: E=Sophos;i="6.13,313,1732608000"; d="scan'208";a="58796535"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
 by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 24 Feb 2025 22:26:35 -0800
X-CSE-ConnectionGUID: SkpgLxr4QA+0WPx418/9xA==
X-CSE-MsgGUID: Bk8iHQveTZ67NcWAQK1e+Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.13,313,1732608000"; d="scan'208";a="116065015"
Received: from liuzhao-optiplex-7080.sh.intel.com (HELO localhost)
 ([10.239.160.39])
 by orviesa009.jf.intel.com with ESMTP; 24 Feb 2025 22:26:33 -0800
Date: Tue, 25 Feb 2025 14:46:10 +0800
From: Zhao Liu <zhao1.liu@intel.com>
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: qemu-devel@nongnu.org, qemu-rust@nongnu.org
Subject: Re: [PATCH 06/15] rust: cell: add wrapper for FFI types
Message-ID: <Z71nMnJ3StEnFx/b@intel.com>
References: <20250221170342.63591-1-pbonzini@redhat.com>
 <20250221170342.63591-7-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250221170342.63591-7-pbonzini@redhat.com>
Received-SPF: pass client-ip=192.198.163.8; envelope-from=zhao1.liu@intel.com;
 helo=mgamail.intel.com
X-Spam_score_int: -47
X-Spam_score: -4.8
X-Spam_bar: ----
X-Spam_report: (-4.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.442,
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

> +    /// Creates a new opaque object with zeroed contents.
> +    ///
> +    /// # Safety
> +    ///
> +    /// Ultimately the pointer to the returned value will be dereferenced
> +    /// in another unsafe block, for example when passing it to a C function.
> +    /// However, this function is unsafe to "force" documenting whether a
> +    /// zero value is safe.
> +    pub const unsafe fn zeroed() -> Self {
> +        Self {
> +            value: UnsafeCell::new(MaybeUninit::uninit()),

typo? MaybeUninit::zeroed()

> +            _pin: PhantomPinned,
> +        }
> +    }
> +
> +    /// Returns a raw pointer to the opaque data.

Maybe "a raw mutable pointer".

> +    pub const fn as_mut_ptr(&self) -> *mut T {
> +        UnsafeCell::get(&self.value).cast()
> +    }
> +
> +    /// Returns a raw pointer to the opaque data.
> +    pub const fn as_ptr(&self) -> *const T {
> +        self.as_mut_ptr() as *const _
> +    }
> +
> +    /// Returns a raw pointer to the opaque data.

What about "Returns a raw c_void type pointer"?

(Because the descriptions of these three helpers are exactly the same!
We can make them different.)
zeroed
> +    pub const fn as_void_ptr(&self) -> *mut std::ffi::c_void {
> +        UnsafeCell::get(&self.value).cast()
> +    }
> +}

The whole idea is great! With the nit of zeroed fixed,

Reviewed-by: Zhao Liu <zhao1.liu@intel.com>


