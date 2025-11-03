Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AA1A9CCFA06
	for <qemu-devel@archiver.kernel.org>; Mon,  3 Nov 2025 15:28:22 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vFwT0-0007Ya-3L; Mon, 03 Nov 2025 10:27:35 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1vFwSw-0007XF-7W; Mon, 03 Nov 2025 10:27:30 -0500
Received: from mgamail.intel.com ([192.198.163.7])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1vFwSk-0007Bi-G6; Mon, 03 Nov 2025 10:27:28 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1762183638; x=1793719638;
 h=date:from:to:cc:subject:message-id:references:
 mime-version:in-reply-to;
 bh=1EQRA88T7+SJIF44x+uBVTrcOrLtgpuyxTiyxq/nfwM=;
 b=lO3YhzbEmXjlXvuA3wRvTbaRm8FBO/gN0rPUnIX+RY1g682cdws/dM6h
 EJGoGHKKJZ6bZFQZ/GJj994iqK9WNbFm/rbd9Ha0G/AxzY+V24xMI4F7h
 r16jg2pq8LJ6L62F7tOEiK8aX7JOKX8VZggopk7VpDsLOMjiGaa6W48dI
 pqdcLVrCdQx710/WDYrZMqMslz7S4dH0G/jvt6bgdv66K/lw2SmwZs1JL
 VrPeBugbqNtl3GPX5mE2SlihtHTIlm28CyG5idTBKe5RL41kf6OOCGgAI
 p5PiRFiD+qcdrzIUnYN23jzNFSIamKLFtu68Dt13dgUA/ozn/VBUNVZu+ Q==;
X-CSE-ConnectionGUID: xyQUPfmmQuOFPJ1fot2fmw==
X-CSE-MsgGUID: PNL4rttBQvGFZbiQFyrtXA==
X-IronPort-AV: E=McAfee;i="6800,10657,11602"; a="89722157"
X-IronPort-AV: E=Sophos;i="6.19,276,1754982000"; d="scan'208";a="89722157"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
 by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 03 Nov 2025 07:27:09 -0800
X-CSE-ConnectionGUID: sOu/pFrXSL+lUba+0KdK8A==
X-CSE-MsgGUID: FNeK619xSZ+qB1mh9L9Z7Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.19,276,1754982000"; d="scan'208";a="192051694"
Received: from liuzhao-optiplex-7080.sh.intel.com (HELO localhost)
 ([10.239.160.39])
 by orviesa005.jf.intel.com with ESMTP; 03 Nov 2025 07:27:09 -0800
Date: Mon, 3 Nov 2025 23:49:22 +0800
From: Zhao Liu <zhao1.liu@intel.com>
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: qemu-devel@nongnu.org, qemu-rust@nongnu.org
Subject: Re: [PATCH 08/11] rust: qemu-macros: add ToMigrationState derive macro
Message-ID: <aQjPApAmM2Hma3Rm@intel.com>
References: <20251001075005.1041833-1-pbonzini@redhat.com>
 <20251001075210.1042479-8-pbonzini@redhat.com>
 <aQiDFo0Yv6sIZsH5@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aQiDFo0Yv6sIZsH5@intel.com>
Received-SPF: pass client-ip=192.198.163.7; envelope-from=zhao1.liu@intel.com;
 helo=mgamail.intel.com
X-Spam_score_int: -39
X-Spam_score: -4.0
X-Spam_bar: ----
X-Spam_report: (-4.0 / 5.0 requ) BAYES_00=-1.9, DKIM_INVALID=0.1,
 DKIM_SIGNED=0.1, RCVD_IN_DNSWL_MED=-2.3,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

On Mon, Nov 03, 2025 at 06:25:26PM +0800, Zhao Liu wrote:
> Date: Mon, 3 Nov 2025 18:25:26 +0800
> From: Zhao Liu <zhao1.liu@intel.com>
> Subject: Re: [PATCH 08/11] rust: qemu-macros: add ToMigrationState derive
>  macro
> 
> Hi Paolo,
> 
> >  /// # use std::sync::Mutex;
> > -/// # use migration::Migratable;
> > +/// # use migration::{Migratable, ToMigrationState, VMState, VMStateField};
> >  ///
> > +/// #[derive(ToMigrationState)]
> >  /// pub struct DeviceRegs {
> >  ///     status: u32,
> >  /// }
> > +/// # unsafe impl VMState for DeviceRegsMigration {
> > +/// #     const BASE: VMStateField = ::common::Zeroable::ZERO;
> > +/// # }
> 
> did you miss something like the following?
> 
> 
> diff --git a/rust/qemu-macros/src/migration_state.rs b/rust/qemu-macros/src/migration_state.rs
> index 5edf0efe687f..2064bb73a6f0 100644
> --- a/rust/qemu-macros/src/migration_state.rs
> +++ b/rust/qemu-macros/src/migration_state.rs
> @@ -236,6 +236,16 @@ pub struct #name {
>          }
>      }
> 
> +    fn generate_vmstate_impl(&self) -> TokenStream {
> +        let name = self.migration_state_name();
> +
> +        quote! {
> +            unsafe impl ::migration::VMState for #name {
> +                const BASE: ::migration::VMStateField = ::common::Zeroable::ZERO;

It seems the generated migration_state_struct needs a complete VMSD:
collect all its fields and build a VMSD.

And then apply impl_vmstate_struct! to this  migration_state_struct.

If we zero the BASE, then `vmstate_of!(Self, migration_state)` seems
can't migrate its fields.

Thanks,
Zhao


