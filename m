Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E2B9EC25B76
	for <qemu-devel@archiver.kernel.org>; Tue, 11 Jun 2024 09:39:19 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sGxxW-0008Vy-Ua; Tue, 11 Jun 2024 05:38:30 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1sGxxT-0008VQ-4Z
 for qemu-devel@nongnu.org; Tue, 11 Jun 2024 05:38:27 -0400
Received: from mgamail.intel.com ([198.175.65.11])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1sGxxQ-0000vR-7W
 for qemu-devel@nongnu.org; Tue, 11 Jun 2024 05:38:26 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1718098704; x=1749634704;
 h=date:from:to:cc:subject:message-id:references:
 mime-version:content-transfer-encoding:in-reply-to;
 bh=rqk4oOToLzOJgWVnnrihVv/vZpY+222F98+waiK9O5M=;
 b=nMeFb+rsc9JyvK5M4ldZk2C9D8UVkn9JiwsQZC0sGRMmUhEj48sGrvzT
 4ImZDyVMNYwyd8usQ4x0Zv2r/fUSUhLMNtklfKJ+zJfCFtfZTyXKWKz6G
 t1Dn6hgunPRnNX35bnn/XsppnlwXDZwt3g0YhOwuvWsAbCGeG/AV2mCvK
 9/A87lTF7KXwFQiAi27XhhBVeC6XEYs2JODG/OKkQ3m0lJwRO6SI3LjPs
 5aQhiOu4yWT5xm48NYjEOFgyir8tuAj0NnvyCZpyNzihQIRn5i5ciDQc6
 KiMU7SvIzjapDbGNlMGmak/7xCKf9G22Er8dlmfRyIwAmutg9HpYYzEUO Q==;
X-CSE-ConnectionGUID: aM0e7bCvTJmKgRx/TcW4Iw==
X-CSE-MsgGUID: 3IhnP8DzSK+PIdj+gLMUzA==
X-IronPort-AV: E=McAfee;i="6600,9927,11099"; a="25375376"
X-IronPort-AV: E=Sophos;i="6.08,229,1712646000"; d="scan'208";a="25375376"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
 by orvoesa103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 11 Jun 2024 02:38:19 -0700
X-CSE-ConnectionGUID: gCruLSKPTKiT2y+uA1dshA==
X-CSE-MsgGUID: BwYEmZMpR56jrm+7ogWhUQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,229,1712646000"; d="scan'208";a="39458063"
Received: from liuzhao-optiplex-7080.sh.intel.com (HELO localhost)
 ([10.239.160.36])
 by orviesa009.jf.intel.com with ESMTP; 11 Jun 2024 02:38:16 -0700
Date: Tue, 11 Jun 2024 17:53:45 +0800
From: Zhao Liu <zhao1.liu@intel.com>
To: Daniel =?iso-8859-1?Q?P=2E_Berrang=E9?= <berrange@redhat.com>
Cc: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>,
 qemu-devel@nongnu.org, Stefan Hajnoczi <stefanha@redhat.com>,
 Mads Ynddal <mads@ynddal.dk>, Paolo Bonzini <pbonzini@redhat.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 Alex =?iso-8859-1?Q?Benn=E9e?= <alex.bennee@linaro.org>,
 =?iso-8859-1?Q?Marc-Andr=E9?= Lureau <marcandre.lureau@redhat.com>,
 Thomas Huth <thuth@redhat.com>, Markus Armbruster <armbru@redhat.com>,
 Philippe =?iso-8859-1?Q?Mathieu-Daud=E9?= <philmd@linaro.org>,
 Gustavo Romero <gustavo.romero@linaro.org>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>
Subject: Re: [RFC PATCH v1 0/6] Implement ARM PL011 in Rust
Message-ID: <ZmgeqY3Vkax7yfPw@intel.com>
References: <cover.rust-pl011-rfc-v1.git.manos.pitsidianakis@linaro.org>
 <ZmgIUfqDjJuw2Chl@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=gb2312
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <ZmgIUfqDjJuw2Chl@redhat.com>
Received-SPF: pass client-ip=198.175.65.11; envelope-from=zhao1.liu@intel.com;
 helo=mgamail.intel.com
X-Spam_score_int: -45
X-Spam_score: -4.6
X-Spam_bar: ----
X-Spam_report: (-4.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.143,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_MED=-2.3, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

On Tue, Jun 11, 2024 at 09:18:25AM +0100, Daniel P. Berrang¨¦ wrote:
> Date: Tue, 11 Jun 2024 09:18:25 +0100
> From: "Daniel P. Berrang¨¦" <berrange@redhat.com>
> Subject: Re: [RFC PATCH v1 0/6] Implement ARM PL011 in Rust
> 
> On Mon, Jun 10, 2024 at 09:22:35PM +0300, Manos Pitsidianakis wrote:
> > What are the issues with not using the compiler, rustc, directly?
> > -----------------------------------------------------------------
> > [whataretheissueswith] Back to [TOC]
> > 
> > 1. Tooling
> >    Mostly writing up the build-sys tooling to do so. Ideally we'd 
> >    compile everything without cargo but rustc directly.
> > 
> >    If we decide we need Rust's `std` library support, we could 
> >    investigate whether building it from scratch is a good solution. This 
> >    will only build the bits we need in our devices.
> 
> Re-building 'std' for QEMU would be a no-go for many distros who
> will expect QEMU to use the distro provided 'std' package. So at
> most that would have to be an optional feature.
> 
> > 2. Rust dependencies
> >    We could go without them completely. I chose deliberately to include 
> >    one dependency in my UART implementation, `bilge`[0], because it has 
> >    an elegant way of representing typed bitfields for the UART's 
> >    registers.
> > 
> > [0]: Article: https://hecatia-elegua.github.io/blog/no-more-bit-fiddling/
> >      Crates.io page: https://crates.io/crates/bilge
> >      Repository: https://github.com/hecatia-elegua/bilge
> > 
> > Should QEMU use third-party dependencies?
> > -----------------------------------------
> > [shouldqemuusethirdparty] Back to [TOC]
> > 
> > In my personal opinion, if we need a dependency we need a strong 
> > argument for it. A dependency needs a trusted upstream source, a QEMU 
> > maintainer to make sure it us up-to-date in QEMU etc.
> 
> "strong" is a rather fuzzy term. In C we already have a huge number
> of build dependencies
> 
>  $ wc -l tests/lcitool/projects/qemu.yml 
>  127 tests/lcitool/projects/qemu.yml
> 
> we would have many more than that except that we're conservative
> about adding deps on things because getting new libraries into
> distros is quite painful, or we lag behind where we would want
> to be to stick with compat for old distro versions.
> 
> In terms of Rust dependancies, I'd expect us to have fairly arbitrary
> dependancies used. If the dep avoids QEMU maintainers having to
> re-invent the wheel for something there is already a common crate
> for, then it is a good thing to use it. I'd almost go as far as
> encouraging use of external crates. Our maintainers should focus tmie
> on writing code that's delivers compelling features to QEMU, rather
> than re-creating common APIs that already have good crates.

So should a base lib be introduced to import and wrap all external
dependencies?

Sort of like osdep.h, so that specific Rust implementations can't import
external third-party libraries directly, but only through the base lib.

The advantage of this is that we can unify the management of external
dependencies and avoid ¡°potentially/overly arbitrary¡± importing of
specific Rust implementations.


