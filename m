Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DFFB1D2E008
	for <qemu-devel@archiver.kernel.org>; Fri,  5 Dec 2025 06:05:50 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vROwg-0000iP-NG; Fri, 05 Dec 2025 01:05:34 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1vROwX-0000dq-Cb; Fri, 05 Dec 2025 01:05:26 -0500
Received: from mgamail.intel.com ([198.175.65.13])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1vROwU-0003hm-WA; Fri, 05 Dec 2025 01:05:25 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1764914723; x=1796450723;
 h=date:from:to:cc:subject:message-id:references:
 mime-version:in-reply-to;
 bh=6hK2yJ3ej5c9kSN5m5/VeTFATwCnDQwtzLFWqdLNsf4=;
 b=k+M7inteHO+mCp+ORe7Q63kfffK5J26nb3N3NiM+6Hw8rRBV2P4Y+1vS
 y/SCeQKxadnMtj/siHoKJlJPggXgemjMS4I6WqUC+fCu7r3vWSnjhaSi4
 zUiWrRt5XyJ66qBy/UmSeAso4VjrSyi2Pd0j4Q1BJgsy7pw2jhm0duKes
 IG1YjSCcV2hQFMeVwd6kHsYfHalNtZ83vblPbStlhzkqdo/YwiwXApubH
 eJHQ7PsttjX0bnaaFQrTwjJfcTe1Uiy612zWM2BrcCmEuz50UgmhpWZC5
 k8nrXdfyj8hcTvsQCrvVO3Vdtbl70tW3UOvVLMkF3oPP9AwAqY9Ij41w0 w==;
X-CSE-ConnectionGUID: XdSpDPU6S+WSBIiRBZSZ7A==
X-CSE-MsgGUID: h1THoOCXSrCdkZr3qJWrHA==
X-IronPort-AV: E=McAfee;i="6800,10657,11632"; a="78057197"
X-IronPort-AV: E=Sophos;i="6.20,251,1758610800"; d="scan'208";a="78057197"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
 by orvoesa105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 04 Dec 2025 22:05:18 -0800
X-CSE-ConnectionGUID: 2qzI66wVQ4KyATTWdidQUA==
X-CSE-MsgGUID: MR56snghS/qz3UolNHY3eQ==
X-ExtLoop1: 1
Received: from liuzhao-optiplex-7080.sh.intel.com (HELO localhost)
 ([10.239.160.39])
 by fmviesa003.fm.intel.com with ESMTP; 04 Dec 2025 22:05:17 -0800
Date: Fri, 5 Dec 2025 14:30:01 +0800
From: Zhao Liu <zhao1.liu@intel.com>
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: qemu-devel@nongnu.org, qemu-rust@nongnu.org, armbru@redhat.com,
 marcandre.lureau@redhat.com
Subject: Re: [PATCH 02/14] rust: add basic QObject bindings
Message-ID: <aTJ76Ufe0vs3aKPL@intel.com>
References: <20251001075005.1041833-1-pbonzini@redhat.com>
 <20251001080051.1043944-3-pbonzini@redhat.com>
 <aTGXmfbzug5cQAbV@intel.com>
 <382ef69e-50b7-4a7f-aa9d-63c076a737f3@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <382ef69e-50b7-4a7f-aa9d-63c076a737f3@redhat.com>
Received-SPF: pass client-ip=198.175.65.13; envelope-from=zhao1.liu@intel.com;
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

> > > +pub struct QObject(&'static UnsafeCell<bindings::QObject>);
> > 
> > It seems Opaque<> feels more natural than UnsafeCell<>.
> > 
> > Opaque::from_raw() requires *mut T, but QObject::from_raw() and
> > QObject::clone_from_raw() mainly play with C bindings which usually use
> > *mut pointer. So it seems unnecessary to convert *mut to *const in the
> > middle.
> > 
> > And furthermore, I think QObject(Opaque<bindings::QObject>) is better
> > than QObject(&'static Opaque<bindings::QObject>). From a semantic view,
> > C's QObject is a struct, while Rust's QObject is a reference, which seems
> > somewhat mismatched.
> > 
> > I'm not sure yet if there may be gaps when remove &'static, but it
> > looks like using &'static Opaque<> instead of &'static UnsafeCell<> is
> > Okay in code?
> 
> I am using UnsafeCell because the QObject here is always valid, i.e.
> MaybeUninit is explicitly not necessary.  Opaque explicitly allows it to be
> invalid, here instead the API is "create via C code or FFI and only then
> create the QObject".

Just want to clarify the use for Opaque, we've already used Opaque<>::from_raw()
for the case "create via C code or FFI and only then create the" something? In
DeviceState::init_clock_[in|out](), and ObjectClassMethods::new().

But I also agree, for this case MaybeUninit is not necessary. And PhantomPinned
is simply replaced by &'static.

> However, while it is possible to use Opaque<> instead of UnsafeCell<>, it is
> not possible to make this a simple wrapper because QObject is unmovable and
> reference counted.  That is, QObject is the equivalent of (for example)
> Owned<DeviceState>.

Got it, if Rust owns data by QObject(Opaque<>) but without Owned<>, this
can't work since it's no way to handle refcnt.

So &'static UnsafeCell<> is the simplest way to meet both unmovable &
refcnt rquirements.

I'm good with this design. Thanks!

Regards,
Zhao


