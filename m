Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DE808C3ABAC
	for <qemu-devel@archiver.kernel.org>; Tue,  6 May 2025 08:51:29 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uCE1H-0000y9-Tq; Tue, 06 May 2025 04:51:19 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1uCE1G-0000xj-4b; Tue, 06 May 2025 04:51:18 -0400
Received: from mgamail.intel.com ([198.175.65.18])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1uCE1D-00077t-59; Tue, 06 May 2025 04:51:17 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1746521476; x=1778057476;
 h=date:from:to:cc:subject:message-id:references:
 mime-version:in-reply-to;
 bh=Djs4jVAOPrcwAvadisn9NVIjusJaYuoQTEmuwm3eE7Q=;
 b=Wrf6BaZIRFJM5UqhHINPWPPPAvDmIgFd+z+8SHMmVQVyFJaI4MVANQ4u
 YwlCzGEQ72CRYkHjYhNR9iFh96CFwrqyh4B9eVUeBm20P512lQnm5b1ej
 HtgJp3+qffplh6l6vT3o9sBJ1xY18c4oMr/oRMYRUJeGY33kFLNecFORK
 8JJ6CSCM/sjYcggdQ++BchUMG2zGUL0dFeEzrU85N6uIZEJcIq90WWS/p
 8Ro6yvPGerRfPb3qnLg/vzP7si66+j5RiHswEggiiECSshRyFkv8nhfhG
 ehhccGjgHRJ1bkpIyxeTvGrl3SQmq+VOGoziLnCiVEpUK5cH95gmtH/Ax g==;
X-CSE-ConnectionGUID: FLdQN27QRFKB0GPkdhDj3g==
X-CSE-MsgGUID: F8jAnlKtSJ6tfw6HPmTs5g==
X-IronPort-AV: E=McAfee;i="6700,10204,11424"; a="48323340"
X-IronPort-AV: E=Sophos;i="6.15,265,1739865600"; d="scan'208";a="48323340"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
 by orvoesa110.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 06 May 2025 01:50:49 -0700
X-CSE-ConnectionGUID: xnEAyIVETry4hwAlwe13yQ==
X-CSE-MsgGUID: 9Ko7F7stQP6gj1kuuvVgRA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,265,1739865600"; d="scan'208";a="136495547"
Received: from liuzhao-optiplex-7080.sh.intel.com (HELO localhost)
 ([10.239.160.39])
 by orviesa008.jf.intel.com with ESMTP; 06 May 2025 01:50:47 -0700
Date: Tue, 6 May 2025 17:11:47 +0800
From: Zhao Liu <zhao1.liu@intel.com>
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: qemu-devel@nongnu.org, qemu-rust@nongnu.org
Subject: Re: [PATCH 2/5] rust: use inline const expressions
Message-ID: <aBnSUzH1RuYp123b@intel.com>
References: <20250505100854.73936-1-pbonzini@redhat.com>
 <20250505100854.73936-3-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250505100854.73936-3-pbonzini@redhat.com>
Received-SPF: pass client-ip=198.175.65.18; envelope-from=zhao1.liu@intel.com;
 helo=mgamail.intel.com
X-Spam_score_int: -57
X-Spam_score: -5.8
X-Spam_bar: -----
X-Spam_report: (-5.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.414,
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

On Mon, May 05, 2025 at 12:08:51PM +0200, Paolo Bonzini wrote:
> Date: Mon,  5 May 2025 12:08:51 +0200
> From: Paolo Bonzini <pbonzini@redhat.com>
> Subject: [PATCH 2/5] rust: use inline const expressions
> X-Mailer: git-send-email 2.49.0
> 
> They were stabilized in Rust 1.79.0.
> 
> Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
> ---
>  docs/devel/rust.rst            |  9 +++------
>  rust/qemu-api/src/callbacks.rs | 27 +--------------------------
>  rust/qemu-api/src/chardev.rs   |  2 +-
>  rust/qemu-api/src/qdev.rs      |  2 +-
>  rust/qemu-api/src/timer.rs     |  2 +-
>  rust/qemu-api/src/vmstate.rs   |  2 +-
>  6 files changed, 8 insertions(+), 36 deletions(-)

...

> diff --git a/rust/qemu-api/src/chardev.rs b/rust/qemu-api/src/chardev.rs
> index 6e0590d758e..cb27be52569 100644
> --- a/rust/qemu-api/src/chardev.rs
> +++ b/rust/qemu-api/src/chardev.rs
> @@ -138,7 +138,7 @@ pub fn enable_handlers<
>              F::call((owner, event))
>          }
>  
> -        let _: () = CanReceiveFn::ASSERT_IS_SOME;
> +        const { assert!(CanReceiveFn::IS_SOME) };

Do you think it's a good idea to warp this as a helper for easy
callback calls?

>          let receive_cb: Option<unsafe extern "C" fn(*mut c_void, *const u8, c_int)> =
>              if ReceiveFn::is_some() {
>                  Some(rust_receive_cb::<T, ReceiveFn>)

Thanks,
Zhao


