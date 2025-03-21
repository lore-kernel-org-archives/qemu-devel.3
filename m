Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A76CFC35FF3
	for <qemu-devel@archiver.kernel.org>; Fri, 21 Mar 2025 04:12:50 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tvTji-0004AA-G2; Fri, 21 Mar 2025 00:11:58 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1tvTje-00049K-Qo; Fri, 21 Mar 2025 00:11:55 -0400
Received: from mgamail.intel.com ([192.198.163.13])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1tvTjb-0006kX-3q; Fri, 21 Mar 2025 00:11:54 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1742530311; x=1774066311;
 h=date:from:to:cc:subject:message-id:references:
 mime-version:content-transfer-encoding:in-reply-to;
 bh=uKqMiHfxqUU1QswsJ9itCG+7AgcaEQycIrOEAhAxPZk=;
 b=Kd3sYT64WngYnFLpJYDmxCx2CedyYOwY54rTEzUfCfiJ0c1O1cFMwGup
 hIZCPMoJ5Mt4Q/ZgYwEvHxrvOrbeqEDicyR2z4AlryA0202IAsaZwoH5H
 pC0jlk6GMB/S+cr/meJoC1ky0F5QQQfOjSyzE6pca8vT8Td2DB0Xs2AGE
 IIsf1Z4COQh9xeFKfa1Pn6KSI6AXcztQRtjnW1e7ViPs49C1qzKa5cvY0
 VP8KzqTOhyFI7bY68zSYZSsv1efavmjHZfPBpdtOk6LhtSF0cgCM/HNVJ
 X4n+W7Rrl1X4k/NJLB5aDQVvDwqIG/mU78d2hQqwiWf2ToAd6+l+0Cn8g Q==;
X-CSE-ConnectionGUID: UWV4MoydTpStqlaH5dnbcg==
X-CSE-MsgGUID: Af/wUMvqTdu5kgV8vnkFOg==
X-IronPort-AV: E=McAfee;i="6700,10204,11379"; a="46540737"
X-IronPort-AV: E=Sophos;i="6.14,263,1736841600"; d="scan'208";a="46540737"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
 by fmvoesa107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 20 Mar 2025 21:11:43 -0700
X-CSE-ConnectionGUID: xerjebGDRV2wYEFT342WjA==
X-CSE-MsgGUID: 4N5o0sOBR8m4U3UlG84R5A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.14,263,1736841600"; d="scan'208";a="123741185"
Received: from liuzhao-optiplex-7080.sh.intel.com (HELO localhost)
 ([10.239.160.39])
 by fmviesa010.fm.intel.com with ESMTP; 20 Mar 2025 21:11:42 -0700
Date: Fri, 21 Mar 2025 12:31:56 +0800
From: Zhao Liu <zhao1.liu@intel.com>
To: Peter Maydell <peter.maydell@linaro.org>
Cc: qemu-arm@nongnu.org, qemu-devel@nongnu.org, qemu-rust@nongnu.org,
 Paolo Bonzini <pbonzini@redhat.com>
Subject: Re: [PATCH 3/3] rust: pl011: Check size of state struct at compile
 time
Message-ID: <Z9zrvF7qRoykMupa@intel.com>
References: <20250320133248.1679485-1-peter.maydell@linaro.org>
 <20250320133248.1679485-4-peter.maydell@linaro.org>
 <Z9w4Gttv8QeBRKfZ@intel.com>
 <CAFEAcA_BQOtzugW31ke=sit1mKnvxieGC_GXLOG4=MK_O2mKqw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=gb2312
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAFEAcA_BQOtzugW31ke=sit1mKnvxieGC_GXLOG4=MK_O2mKqw@mail.gmail.com>
Received-SPF: pass client-ip=192.198.163.13; envelope-from=zhao1.liu@intel.com;
 helo=mgamail.intel.com
X-Spam_score_int: -46
X-Spam_score: -4.7
X-Spam_bar: ----
X-Spam_report: (-4.7 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.332,
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

> > > +// Some C users of this device embed its state struct into their own
> > > +// structs, so the size of the Rust version must not be any larger
> > > +// than the size of the C one. If this assert triggers you need to
> > > +// expand the padding_for_rust[] array in the C PL011State struct.
> > > +static_assert!(mem::size_of::<PL011State>() <= mem::size_of::<bindings::PL011State>());
> > > +
> >
> > maybe use qemu_api::bindings::PL011State directly? Because bindings
> > contains native C structures/functions and their use should not be
> > encouraged, I think it's better to 'hide' bindings (not list it at the
> > beginning of the file).
> 
> Yeah, I wasn't sure what our preferred style approach is here
> regarding what we "use" and what we just directly reference
> (and the same in the other direction for mem::size_of vs
> size_of). Is there a "normal" pattern to follow here ?

There seems no clear doc on when to list use statements, but it's common
to list as clearly as possible to make it easier to sort out dependencies.

About bindings, I think it's better to clearly point out the specific
members in bindings, so ¡®use qemu_api::bindings¡¯ looks vague. Alternatively,
the qemu_api::bindings::PL011State could also be listed at the beginning of
the file, similar to a previous clean up: 06a1cfb5550a ("rust/pl011: Avoid
bindings::*") and another patch [1].

[1]: https://lore.kernel.org/qemu-devel/20250318130219.1799170-16-zhao1.liu@intel.com/

> Speaking of size_of, I noticed that Rust provides both
> core::mem::size_of and std::mem::size_of, and in rust/ at
> the moment we have uses of both. What's the difference?

They're the same (a simple proof of this is that the "source" option of
the std::mem page [2] points to the core::mem repo). `core` is
self-contained without OS dependency, and `std` is the superset of `core`
with extra OS dependency. And there's a previous cleanup to consolidate
`std::ptr` (commit c48700e86d, "rust: prefer importing std::ptr over
core::ptr"). So I think we can prefer std::mem as well.

[2]: https://doc.rust-lang.org/std/mem/index.html

Regards,
Zhao


