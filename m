Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2D885E77187
	for <qemu-devel@archiver.kernel.org>; Wed, 18 Dec 2024 14:51:39 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tNvOY-0001GN-Eo; Wed, 18 Dec 2024 09:51:26 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1tNvOW-0001Ce-E1; Wed, 18 Dec 2024 09:51:24 -0500
Received: from mgamail.intel.com ([192.198.163.16])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1tNvOT-0002j3-VJ; Wed, 18 Dec 2024 09:51:24 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1734533482; x=1766069482;
 h=date:from:to:cc:subject:message-id:references:
 mime-version:in-reply-to;
 bh=l3HZTrZ+0p1cuZlAvihWKKHeIlgkeQ3WncjZpuEJROY=;
 b=aSWnFYTOdLX35+RtrkBmJemgk/vqUkR/wsRz87wotCTLmXJHZXJxx0hy
 B/W5O/3x9+SAPq9iTYsN4I7S25eM0J8Eq/mBCcm5C+HsMcavFrr9/Jhbe
 2i+PgwPmTFIuoMc3teFUsrz4xFXCYXuNrxZc4UXHkgXM6CG0qchyyIy2z
 aMkPFaTm351DpC5Z5cBhhe7Q3nuPXrxbrEwy4dqXiw2W+Hm3qvfDjHpYi
 I3MSsGsbzUhGNFw/HigoHSWYpyhwOF395BndJwFT1dK69ZeCKTZt4Iclx
 q+gnuoM7AaqcpdAutc2f7U2300VEYVO1idIBptOwyg5+EratSurrx0aS4 w==;
X-CSE-ConnectionGUID: sLlhATyBQheMvy1d1x3kgw==
X-CSE-MsgGUID: Mq5ouA4MT26XqpH1nlnaOA==
X-IronPort-AV: E=McAfee;i="6700,10204,11290"; a="22599420"
X-IronPort-AV: E=Sophos;i="6.12,244,1728975600"; d="scan'208";a="22599420"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
 by fmvoesa110.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 18 Dec 2024 06:51:17 -0800
X-CSE-ConnectionGUID: kLRSAmeCSu2ZJuwCsBY6Og==
X-CSE-MsgGUID: y8P7Ir/3RUadcA9+MWXBqw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,199,1725346800"; d="scan'208";a="102976666"
Received: from liuzhao-optiplex-7080.sh.intel.com (HELO localhost)
 ([10.239.160.39])
 by orviesa003.jf.intel.com with ESMTP; 18 Dec 2024 06:51:16 -0800
Date: Wed, 18 Dec 2024 23:09:55 +0800
From: Zhao Liu <zhao1.liu@intel.com>
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: qemu-devel <qemu-devel@nongnu.org>, qemu-rust@nongnu.org,
 Junjie Mao <junjie.mao@hotmail.com>
Subject: Re: [PATCH 26/26] rust: callbacks: allow passing optional callbacks
 as ()
Message-ID: <Z2Llw0dHB6SpGMwr@intel.com>
References: <20241209123717.99077-1-pbonzini@redhat.com>
 <20241209123717.99077-27-pbonzini@redhat.com>
 <Z2GjLOppRcHFBpAT@intel.com>
 <CABgObfYE8z5QeVSWT7odaPcZYNfW0Ox1gNmGyCvj0YRTsDEGrg@mail.gmail.com>
 <Z2J1EI+R51GqPhVA@intel.com>
 <CABgObfZJNC2EWsYYSZfTYF8mebRzAmiYwD=d6bdG=10oQ3tQBg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CABgObfZJNC2EWsYYSZfTYF8mebRzAmiYwD=d6bdG=10oQ3tQBg@mail.gmail.com>
Received-SPF: pass client-ip=192.198.163.16; envelope-from=zhao1.liu@intel.com;
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

On Wed, Dec 18, 2024 at 08:32:59AM +0100, Paolo Bonzini wrote:
> Date: Wed, 18 Dec 2024 08:32:59 +0100
> From: Paolo Bonzini <pbonzini@redhat.com>
> Subject: Re: [PATCH 26/26] rust: callbacks: allow passing optional
>  callbacks as ()
> 
> Il mer 18 dic 2024, 07:50 Zhao Liu <zhao1.liu@intel.com> ha scritto:
> 
> > Am I using the wrong terminology? Function pointers in a structure should
> > be called a vtable, rather than callbacks (for example, methods in
> > TypeInfo,
> > read/write methods in MemoryRegionOps). Callbacks are typically function
> > pointers used as function parameters (for example, timer/gpio). So, is the
> > callback implementation here only used for the latter case?
> >
> 
> The callback implementation is not used for QOM indeed. In that case, using
> FnCall would require something like
> 
> const UNPARENT: impl FnCall((&Self,));
> 
> which does not exist as far as I know?

Yes, it's incorrect. (I know you have some magic, so I have this question
to see your idea.)

> MemoryRegionOps is a mix of callbacks and a vtable.  From the Rust point of
> view, with the API that uses the builder pattern, MemoryRegionOps (and
> VMStateDescription too) would be closer to callbacks. Instead when you use
> traits and fill in the class object, that's clearly a vtable.
> 
> But in this sense MemoryRegionOps do not need optional callbacks. You just
> don't call the ops.read() method if you don't need to set a read callback
> for example. So I am not sure if anything that is planned right now needs
> the optional callbacks. It's good to have the patch for the future but it's
> not necessary right now.

Thanks for your explaination. I agree your plan. I also think it will be
useful in the future.

Regards,
Zhao


