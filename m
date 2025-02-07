Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 81E18C02196
	for <qemu-devel@archiver.kernel.org>; Fri,  7 Feb 2025 07:25:49 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tgIkD-0005JH-65; Fri, 07 Feb 2025 02:25:47 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1tgIjq-0004x8-FG; Fri, 07 Feb 2025 02:25:23 -0500
Received: from mgamail.intel.com ([192.198.163.19])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1tgIjo-0007ni-7o; Fri, 07 Feb 2025 02:25:22 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1738913120; x=1770449120;
 h=date:from:to:cc:subject:message-id:references:
 mime-version:content-transfer-encoding:in-reply-to;
 bh=hYxTtbnYvDndJpJUwjiU7VHXzZNkmmW/xe8XNc4Zcpc=;
 b=ep52DSVPjeVeArRPnFCH/BPrHtePzrmGw+0VZ6l/OkYP+k3aeeoY+4Em
 mBz4qVyc6JtunwvFJL1kPocTX9XFlpNJMhrKhfSmsfzsAd4q9kjC3tGRK
 k0rG8JUrQ69bJZ8gwYBykeBhINuVra8BKk05gIWOl427j7EsVK3RQsmvQ
 pZYvL6lhtoALB0pXLByBpqZnihrnknpJICSHNvw/hm1Tc6uChxPUCNZmB
 3DiIx0qnq1YUDwkiBB/HYP4a6phjXV8Mgg+pXrh8O9xpPLx676JwUtA4R
 HHXll4q7rZQIfFGeCw1rpWKgo/ZB7hWTzaBBmwo/BTQhfOpa3ib/aX8Xq A==;
X-CSE-ConnectionGUID: A/dvwY/jTyaOAM+uInAkkw==
X-CSE-MsgGUID: U6+g3cllTOySyGzjRTv4uw==
X-IronPort-AV: E=McAfee;i="6700,10204,11336"; a="38749094"
X-IronPort-AV: E=Sophos;i="6.13,266,1732608000"; d="scan'208";a="38749094"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
 by fmvoesa113.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 06 Feb 2025 23:25:17 -0800
X-CSE-ConnectionGUID: NMGhLfdaST2jZz4+30a0Yg==
X-CSE-MsgGUID: IeGjMfwSSr2HBuzB1nAzFw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.13,266,1732608000"; d="scan'208";a="111275797"
Received: from liuzhao-optiplex-7080.sh.intel.com (HELO localhost)
 ([10.239.160.39])
 by fmviesa006.fm.intel.com with ESMTP; 06 Feb 2025 23:25:11 -0800
Date: Fri, 7 Feb 2025 15:44:40 +0800
From: Zhao Liu <zhao1.liu@intel.com>
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>,
 Junjie Mao <junjie.mao@hotmail.com>,
 Alex =?utf-8?B?QmVubu+/vWU=?= <alex.bennee@linaro.org>,
 Philippe =?utf-8?B?TWF0aGlldS1EYXVk77+9?= <philmd@linaro.org>,
 Richard Henderson <richard.henderson@linaro.org>,
 Peter Maydell <peter.maydell@linaro.org>,
 Daniel P =?utf-8?B?LiBCZXJyYW5n77+9?= <berrange@redhat.com>,
 qemu-devel@nongnu.org, qemu-rust@nongnu.org
Subject: Re: [PATCH 03/10] rust/irq: Add a helper to convert
 [InterruptSource] to [*mut IRQState]
Message-ID: <Z6W56AH3J1qOx18m@intel.com>
References: <20250125125137.1223277-1-zhao1.liu@intel.com>
 <20250125125137.1223277-4-zhao1.liu@intel.com>
 <17907481-89d6-457c-bcd3-66a444b1325d@redhat.com>
 <Z6Wx/RGBIElMaeZy@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <Z6Wx/RGBIElMaeZy@intel.com>
Received-SPF: pass client-ip=192.198.163.19; envelope-from=zhao1.liu@intel.com;
 helo=mgamail.intel.com
X-Spam_score_int: -15
X-Spam_score: -1.6
X-Spam_bar: -
X-Spam_report: (-1.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RAZOR2_CF_RANGE_51_100=1.886, RAZOR2_CHECK=0.922, RCVD_IN_DNSWL_MED=-2.3,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

On Fri, Feb 07, 2025 at 03:10:53PM +0800, Zhao Liu wrote:
> Date: Fri, 7 Feb 2025 15:10:53 +0800
> From: Zhao Liu <zhao1.liu@intel.com>
> Subject: Re: [PATCH 03/10] rust/irq: Add a helper to convert
>  [InterruptSource] to [*mut IRQState]
> 
> On Wed, Jan 29, 2025 at 11:51:02AM +0100, Paolo Bonzini wrote:
> > Date: Wed, 29 Jan 2025 11:51:02 +0100
> > From: Paolo Bonzini <pbonzini@redhat.com>
> > Subject: Re: [PATCH 03/10] rust/irq: Add a helper to convert
> >  [InterruptSource] to [*mut IRQState]
> > 
> > On Sat, Jan 25, 2025 at 1:32 PM Zhao Liu <zhao1.liu@intel.com> wrote:
> > > 
> > > This is useful to hanlde InterruptSource slice and pass it to C
> > > bindings.
> > > 
> > > Suggested-by: Paolo Bonzini <pbonzini@redhat.com>
> > 
> > This may be a bad suggestion, after all. clippy complains that you're
> > casting &[*mut IRQState] to mutable (https://rust-lang.github.io/rust-
> > clippy/master/#as_ptr_cast_mut).
> > 
> > I can think of two solutions:
> > 
> > 1) add #[allow(clippy::as_ptr_cast_mut)] and explain with a comment
> > 
> >     // Casting to *mut *mut IRQState is valid, because
> >     // the source slice `pins` uses interior mutability.
> >

I agree it's the best to use interior mutability.

Just to confirm, I check with `cargo +nightly clippy` but it doesn't
complain about this case. Should I switch to another version of clippy
when I do such check? (currently I'm using v0.1.63 clippy as well, to
match rustc.)

Thanks,
Zhao


