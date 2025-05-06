Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id ED782C3ABBC
	for <qemu-devel@archiver.kernel.org>; Tue,  6 May 2025 15:36:14 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uCKKz-0007Br-In; Tue, 06 May 2025 11:36:05 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1uCKKx-00073X-1D; Tue, 06 May 2025 11:36:03 -0400
Received: from mgamail.intel.com ([192.198.163.8])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1uCKKu-00035P-3n; Tue, 06 May 2025 11:36:02 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1746545760; x=1778081760;
 h=date:from:to:cc:subject:message-id:references:
 mime-version:in-reply-to;
 bh=mkJbEeRb1ENEByJ2b2sfLaOckdBgjLYuUO8APjrIq+8=;
 b=mRxdK/6vwYB9/+XkLT4vVavjL9YrYANUw874zMFt8kE97SAHr+kScGws
 PNXCYpIDUQ6IIkX/ZQDjFv1boPDcZU0cikG7g/ZQKy5zysgoEhimu0m9r
 pcgjqNx5NMuIwv+kGuKsuBrMl2ldyyiDGy2MR/MLDsBdDElpBkDGV6FAK
 5rzeO0UKYYKxEZBU+lmnNsTyZGSOieg38aBhJATqiwbzHjDDKQfI2jp1t
 raQyP9S0WKvo9LtGOS/iL5tzF10EnoZ5z4HDhMNcX+4rIHkoj+RLdY6bf
 tLOKe7kmoxxs/N1AwzfhocASajnyO4mdDB16R48H6FKFRltDqN/ivu+r5 Q==;
X-CSE-ConnectionGUID: C0oNv97NRPmSB1eXeC6n2w==
X-CSE-MsgGUID: x0xMebhnRvW+WcoaNxm3tg==
X-IronPort-AV: E=McAfee;i="6700,10204,11425"; a="65756130"
X-IronPort-AV: E=Sophos;i="6.15,266,1739865600"; d="scan'208";a="65756130"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
 by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 06 May 2025 08:35:55 -0700
X-CSE-ConnectionGUID: QxeGqo/cSNmWUph0tfhNsw==
X-CSE-MsgGUID: KxiJiujIRl66Nuy3vNfHEg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,266,1739865600"; d="scan'208";a="140499994"
Received: from liuzhao-optiplex-7080.sh.intel.com (HELO localhost)
 ([10.239.160.39])
 by fmviesa005.fm.intel.com with ESMTP; 06 May 2025 08:35:54 -0700
Date: Tue, 6 May 2025 23:56:55 +0800
From: Zhao Liu <zhao1.liu@intel.com>
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: Daniel =?iso-8859-1?Q?P=2E_Berrang=E9?= <berrange@redhat.com>,
 qemu-devel@nongnu.org, qemu-rust@nongnu.org
Subject: Re: [PATCH preview 0/5] rust: allow minimum version of 1.83
Message-ID: <aBoxR2PXsaeNe1sF@intel.com>
References: <20250505100854.73936-1-pbonzini@redhat.com>
 <aBnOyhMawDaY9yyR@intel.com>
 <CABgObfYDOAGKdRNO91bfXQ4MPjbc0wNZSrDfpDiQZsOkrL53RQ@mail.gmail.com>
 <aBnVtNgdjQ9DlugK@intel.com> <aBnbC4-hov9gY3MF@redhat.com>
 <CABgObfbzWDnntjLcshsBPfdEdbx-6iqxd6FxUDbQa--VOqan=A@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CABgObfbzWDnntjLcshsBPfdEdbx-6iqxd6FxUDbQa--VOqan=A@mail.gmail.com>
Received-SPF: pass client-ip=192.198.163.8; envelope-from=zhao1.liu@intel.com;
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

> > If we're re-writing C devices in Rust, we need to be able to promptly
> > drop the C impl once the Rust impl is feature complete. Keeping 2 impls
> > is a general maint burden, as well as an ongoing vmstate compatibility
> > danger if a change in one impl is not matched by an identical change
> > in the other impl.
> 
> I agree. One more reason why "Let's Rewrite It In Rust" is more of a
> necessary evil to bootstrap the creation of bindings, and not a good
> idea in general.

Hi Paolo and Daniel, about this point, what things can be done to help
the community move towards dropping duplicate impl?

For example, about HPET, add test cases (similar to tests/qtest/m48t59-test.c)
to check register read/write to prove that the two impls are consistent?

Thanks,
Zhao


