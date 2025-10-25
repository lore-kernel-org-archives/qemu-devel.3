Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 85BA3CCD1BF
	for <qemu-devel@archiver.kernel.org>; Sat, 25 Oct 2025 08:31:23 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vCZfo-0005Sx-3B; Sat, 25 Oct 2025 04:30:53 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1vCZfZ-0005PE-Bk; Sat, 25 Oct 2025 04:30:38 -0400
Received: from mgamail.intel.com ([192.198.163.15])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1vCZfR-0005NK-B8; Sat, 25 Oct 2025 04:30:32 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1761381029; x=1792917029;
 h=date:from:to:cc:subject:message-id:references:
 mime-version:in-reply-to;
 bh=ES1nI8th0/0ldH3aqAwXeLgU68F0dfZwicYy4qewdBI=;
 b=Cv3YE25Dgs6MIdCl5n3KejESaHKUvms2nGS1IMKANTrmcL3d8ScksImj
 NEh0fp4SwBH3oj8rfzMVP1N61RPmIMQL0f4WXkX2WR20W01NB7pElnPXA
 mXrFRR573DmyeFk1JKc5NHW2D1o2xQsffyh0OR0qxCeDaYXa/8JUUIUeA
 xZvJu3d7+eL7BIliFSOcSf2dfYeCTyatWRPlr+Rj7guCp6NZ037qqf4QL
 IDXT+0CSLQF/C24Jj4FbaDZzkgVvr1TMiiom+av+fHQJVcQZjLxEXLz8v
 u7dbcE+js7+n7E79N2Vpl9+np0E7RCLCxRkwn/wDUgQqGyZFoXj6GHnyu g==;
X-CSE-ConnectionGUID: tD7ZBRxgQrq9xnU6zA0dlg==
X-CSE-MsgGUID: SIsFF1wuTWatW5GKZkT8gQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11586"; a="63641143"
X-IronPort-AV: E=Sophos;i="6.19,254,1754982000"; d="scan'208";a="63641143"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
 by fmvoesa109.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 25 Oct 2025 01:30:18 -0700
X-CSE-ConnectionGUID: TWw3h7OQT+yRd9lnV13LzA==
X-CSE-MsgGUID: GjFwbR+fQzWcKLeJQ8d0nA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.19,254,1754982000"; d="scan'208";a="208258318"
Received: from liuzhao-optiplex-7080.sh.intel.com (HELO localhost)
 ([10.239.160.39])
 by fmviesa002.fm.intel.com with ESMTP; 25 Oct 2025 01:30:17 -0700
Date: Sat, 25 Oct 2025 16:52:26 +0800
From: Zhao Liu <zhao1.liu@intel.com>
To: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>
Cc: Paolo Bonzini <pbonzini@redhat.com>, qemu-devel@nongnu.org,
 qemu-rust@nongnu.org
Subject: Re: [PATCH v2] rust/qemu-macros: Convert bit value to u8 within
 #[property]
Message-ID: <aPyPyvvb+G6Df6Qw@intel.com>
References: <20251024041344.1389488-1-zhao1.liu@intel.com>
 <t4mjqw.dx8x6zfu0m3i@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <t4mjqw.dx8x6zfu0m3i@linaro.org>
Received-SPF: pass client-ip=192.198.163.15; envelope-from=zhao1.liu@intel.com;
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

> >+                quote! {
> >+                    {
> >+                        const {
> >+                            assert!(#bitval >= 0 && #bitval < #field_ty::BITS as _,
> >+                                    "bit number exceeds type bits 
> >range");
> 
> Const panic messages cannot use formatting parameters yet, but.
> Can we interpolate the type (e.g u32) in the compile-time panic message? 

Good idea! `concat!` with `stringify!(#field_ty)` should work.

> Not important but would make the error message friendlier.

Yeah, let me refresh a v3.

> Reviewed-by: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>

Thanks!

Regards,
Zhao

