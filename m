Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 086F5CAC598
	for <qemu-devel@archiver.kernel.org>; Wed, 17 Sep 2025 07:04:41 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uymCo-0003UH-O2; Wed, 17 Sep 2025 03:03:54 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1uymCm-0003Tx-Rz; Wed, 17 Sep 2025 03:03:53 -0400
Received: from mgamail.intel.com ([192.198.163.10])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1uymCk-0003lF-EY; Wed, 17 Sep 2025 03:03:52 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1758092631; x=1789628631;
 h=date:from:to:cc:subject:message-id:references:
 mime-version:content-transfer-encoding:in-reply-to;
 bh=0q28p77Qq5v1KDJWMsr+duTDqBpEjMz1jM2vdaMPLA0=;
 b=T9GH2wKeVMU8QVmfquYSLlP0etng6O1bcNry2iziCiplDv+wTAPMuJC6
 NTokNt8loWziVP2bZzvY+bE9/lj8EFziNacT/db9wjjAs3QxFbPMCZpIx
 POJ1W/yupqG5FWntD0NU3dhdh6wc1ThMkExnCP5dcaCGOEQ0aAEhhW/U4
 xa/P5rwZoKFSzDfA7le4ACjnqlDmDEVBYkg8Yo+R572x9nsXDz9iJeiIe
 R6Ec/bAK+diIEyKgUvsKy0D/kpuUkvJYPzkrysLT0fai3sLR4GCsuJoIi
 q61jzuhnQOSYyZF+6yhkm0V3+P0K96iRWOWIh/psgJdfIY8dSCkcUXeEP Q==;
X-CSE-ConnectionGUID: daLGsJgETzapR+igWRJjvA==
X-CSE-MsgGUID: fAqUQkfwSpGljUQ27InrrA==
X-IronPort-AV: E=McAfee;i="6800,10657,11555"; a="71754147"
X-IronPort-AV: E=Sophos;i="6.18,271,1751266800"; d="scan'208";a="71754147"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
 by fmvoesa104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 17 Sep 2025 00:03:46 -0700
X-CSE-ConnectionGUID: ToE+U/3qQROuk17Sa1nB/Q==
X-CSE-MsgGUID: ljXmjpbMSZyGHaTKp7tlwg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.18,271,1751266800"; d="scan'208";a="180304309"
Received: from liuzhao-optiplex-7080.sh.intel.com (HELO localhost)
 ([10.239.160.39])
 by orviesa005.jf.intel.com with ESMTP; 17 Sep 2025 00:03:44 -0700
Date: Wed, 17 Sep 2025 15:25:38 +0800
From: Zhao Liu <zhao1.liu@intel.com>
To: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>
Cc: Paolo Bonzini <pbonzini@redhat.com>, qemu-devel@nongnu.org,
 qemu-rust@nongnu.org
Subject: Re: [PATCH 09/12] rust/qdev: Support bit property in #property macro
Message-ID: <aMpicpXtVu/4lK63@intel.com>
References: <20250916085557.2008344-1-zhao1.liu@intel.com>
 <20250916085557.2008344-10-zhao1.liu@intel.com>
 <CAAjaMXYkJno=nAcAGPWQJMCjcSkePJwjmZgFkPAkX2N3tQoSCQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAAjaMXYkJno=nAcAGPWQJMCjcSkePJwjmZgFkPAkX2N3tQoSCQ@mail.gmail.com>
Received-SPF: pass client-ip=192.198.163.10; envelope-from=zhao1.liu@intel.com;
 helo=mgamail.intel.com
X-Spam_score_int: -43
X-Spam_score: -4.4
X-Spam_bar: ----
X-Spam_report: (-4.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.009,
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

On Tue, Sep 16, 2025 at 01:16:25PM +0300, Manos Pitsidianakis wrote:
> Date: Tue, 16 Sep 2025 13:16:25 +0300
> From: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>
> Subject: Re: [PATCH 09/12] rust/qdev: Support bit property in #property
>  macro
> 
> On Tue, Sep 16, 2025 at 11:34 AM Zhao Liu <zhao1.liu@intel.com> wrote:
> >
> > Add BIT_INFO to QDevProp trait, so that bit related property info could
> > be bound to u32 & u64.
> >
> > Then add "bit=*" field in #property attributes macro to allow device to
> > configure bit property.
> >
> > In addtion, convert the #property field parsing from `if-else` pattern
> > to `match` pattern, to help readability. And note, the `bitnr` member of
> > `Property` struct is generated by manual TokenStream construction,
> > instead of conditional repetition (like #(bitnr: #bitnr,)?) since
> > `quote` doesn't support this.
> >
> > Signed-off-by: Zhao Liu <zhao1.liu@intel.com>
> > ---
> >  rust/hw/core/src/qdev.rs    | 15 +++++---
> >  rust/qemu-macros/src/lib.rs | 77 +++++++++++++++++++++++++------------
> >  2 files changed, 62 insertions(+), 30 deletions(-)
> >
> > diff --git a/rust/hw/core/src/qdev.rs b/rust/hw/core/src/qdev.rs
> > index b57dc05ebb0e..a8cd9e3c2fd5 100644
> > --- a/rust/hw/core/src/qdev.rs
> > +++ b/rust/hw/core/src/qdev.rs
> > @@ -109,8 +109,8 @@ pub trait ResettablePhasesImpl {
> >  ///
> >  /// # Safety
> >  ///
> > -/// This trait is marked as `unsafe` because `BASE_INFO` must be a valid raw
> > -/// reference to a [`bindings::PropertyInfo`].
> > +/// This trait is marked as `unsafe` because `BASE_INFO` and `BIT_INFO` must be
> > +/// the valid raw references to [`bindings::PropertyInfo`].
> 
> s/the //

Okay.

> >  ///
> >  /// Note we could not use a regular reference:
> >  ///
> > @@ -132,13 +132,18 @@ pub trait ResettablePhasesImpl {
> >  /// [`bindings::PropertyInfo`] pointer for the trait implementation to be safe.
> >  pub unsafe trait QDevProp {
> >      const BASE_INFO: *const bindings::PropertyInfo;
> > +    const BIT_INFO: *const bindings::PropertyInfo = {
> > +        panic!("invalid type for bit property");
> > +    };
> 
> Why is this needed?

Only 3 types supports bit:

u32: qdev_prop_bit
u64: qdev_prop_bit64
OnOffAuto: qdev_prop_on_off_auto_bit64 (not support yet)

So for other types don't support bit, they need default BIT_INFO item,
otherwise, we will meet the error:

 not all trait items implemented, missing: `BIT_INFO`


And this panic can provide richer info about why a type can't support
bit property. (I just refer the implementation of `trait VMState`).

Thanks,
Zhao


