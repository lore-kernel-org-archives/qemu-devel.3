Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 72BEEC021A9
	for <qemu-devel@archiver.kernel.org>; Tue, 18 Feb 2025 08:48:06 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tkJFv-0006gP-Se; Tue, 18 Feb 2025 03:47:03 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1tkJFt-0006gB-S6; Tue, 18 Feb 2025 03:47:02 -0500
Received: from mgamail.intel.com ([192.198.163.7])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1tkJFn-0003ux-VE; Tue, 18 Feb 2025 03:47:01 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1739868416; x=1771404416;
 h=date:from:to:cc:subject:message-id:references:
 mime-version:in-reply-to;
 bh=eMV5RPJdeZ8TDoE8SJj+rx4fHDaDQmoZb5bL3AP27zM=;
 b=CMb8qj8fyUUYNBT4gF0uPIc9gw72smHbMEqLZhgWsnQomCLvkrI9eWky
 6oyxwaq8qs9MmezdWKBkq0chZhNwAkpnFBFmDnEFezyve9qtE2Mr0YkTi
 DRcYu8Pnw9AWjK+nHbxu2VXaOzv8opMGcxauQ/nyIBfFRjyj5EhU08J1j
 5aNq3TGc+tqnUc2w13+9pjHF9vtA2Ve0sgFZzN5xjQpbr30JwLxJV94gc
 dbVzaAK4xrxxuXGogVH8ZAxL6C6Q1J5cpQHp35StVleVhBurjj/xYKSJE
 0hnKoW4pj081y0x71R/xPVdFfq0supHvUeA1A1arWpcx93Mq3hjF6G8vN A==;
X-CSE-ConnectionGUID: 4vb0A9sQRxWRya9mHdgw0Q==
X-CSE-MsgGUID: MH9ay/G7RUWiQdPqWKrbIw==
X-IronPort-AV: E=McAfee;i="6700,10204,11348"; a="65908362"
X-IronPort-AV: E=Sophos;i="6.13,295,1732608000"; d="scan'208";a="65908362"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
 by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 18 Feb 2025 00:46:48 -0800
X-CSE-ConnectionGUID: 67+msNwVRnKYPzf4mwnxoQ==
X-CSE-MsgGUID: qD2pBaOxTjOwkPAmHbn6Lw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,224,1728975600"; d="scan'208";a="118971340"
Received: from liuzhao-optiplex-7080.sh.intel.com (HELO localhost)
 ([10.239.160.39])
 by fmviesa005.fm.intel.com with ESMTP; 18 Feb 2025 00:46:47 -0800
Date: Tue, 18 Feb 2025 17:06:21 +0800
From: Zhao Liu <zhao1.liu@intel.com>
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: qemu-devel@nongnu.org, qemu-rust@nongnu.org
Subject: Re: [PATCH] docs: rust: update description of crates
Message-ID: <Z7RNjYCRHScpJtdy@intel.com>
References: <20250218080455.426383-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250218080455.426383-1-pbonzini@redhat.com>
Received-SPF: pass client-ip=192.198.163.7; envelope-from=zhao1.liu@intel.com;
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

On Tue, Feb 18, 2025 at 09:04:55AM +0100, Paolo Bonzini wrote:
> Date: Tue, 18 Feb 2025 09:04:55 +0100
> From: Paolo Bonzini <pbonzini@redhat.com>
> Subject: [PATCH] docs: rust: update description of crates
> X-Mailer: git-send-email 2.48.1
> 
> Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
> ---
>  docs/devel/rust.rst | 14 ++++++++++----
>  1 file changed, 10 insertions(+), 4 deletions(-)
> 
> diff --git a/docs/devel/rust.rst b/docs/devel/rust.rst
> index 7964e1fd327..e3f9e16aacb 100644
> --- a/docs/devel/rust.rst
> +++ b/docs/devel/rust.rst
> @@ -139,16 +139,22 @@ anymore.
>  Writing Rust code in QEMU
>  -------------------------
>  
> -Right now QEMU includes three crates:
> +Right now QEMU includes four crates:

Maybe we can avoid the words - "Right now"?

(It has been pointed out before that this type of wording is a bit too
vague. But, it's up to you.)

>  * ``qemu_api`` for bindings to C code and useful functionality
>  
>  * ``qemu_api_macros`` defines several procedural macros that are useful when
>    writing C code
>  
> -* ``pl011`` (under ``rust/hw/char/pl011``) is the sample device that is being
> -  used to further develop ``qemu_api`` and ``qemu_api_macros``.  It is a functional
> -  replacement for the ``hw/char/pl011.c`` file.
> +* ``pl011`` (under ``rust/hw/char/pl011``) and ``hpet`` (under ``rust/hw/timer/hpet``)
> +  are sample device that demonstrate ``qemu_api`` and ``qemu_api_macros``, and are

s/device/devices/

> +  used to further develop them.  These two crates are functional\ [#issues]_ replacements
> +  for the ``hw/char/pl011.c`` and ``hw/timer/hpet.c`` files.
> +
> +.. [#issues] The ``pl011`` crate is synchronized with ``hw/char/pl011.c``
> +   as of commit 02b1f7f61928.  The ``hpet`` crate is synchronized as of
> +   commit f32352ff9e.  Both are lacking tracing functionality; ``hpet``
> +   is also lacking support for migration.

An additional question, should I add the RUST HPET entry in MAINTAINERS file
under "PC Chipset" or add the new section like "ARM PL011 Rust device"?

I feel as if the former makes more sense?

>  This section explains how to work with them.
>

Overall, LGTM and thanks a lot,

Reviewed-by: Zhao Liu <zhao1.liu@intel.com>

Regards,
Zhao


