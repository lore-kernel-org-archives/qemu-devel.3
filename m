Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2A52BCA0EE8
	for <qemu-devel@archiver.kernel.org>; Wed, 17 Sep 2025 06:52:41 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uym1T-000070-CZ; Wed, 17 Sep 2025 02:52:11 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1uym1R-00006b-FZ; Wed, 17 Sep 2025 02:52:09 -0400
Received: from mgamail.intel.com ([192.198.163.12])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1uym1P-0002KT-RD; Wed, 17 Sep 2025 02:52:09 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1758091928; x=1789627928;
 h=date:from:to:cc:subject:message-id:references:
 mime-version:content-transfer-encoding:in-reply-to;
 bh=ObfKbsDxmaNSjBL1MUOnF6C1AbsnVQYIZd53wwnhIDw=;
 b=edt7mrsdifX8vmtFqT5eVOVyR08wbbGbkwgQxyWqwE1hu7MbcdUUjpGK
 Ph6WXQiphbgXSPsV3qhi6KZAVi2sF43+Ag37122k8GAIVzevGNrobObwN
 yrqcK3WQmLU0/2tZ/N9/R4ccXCu8zpFIcOisOpIBhZ3tzM01SLLa5vEaI
 1ovIcGa5l6Bmg4w3LH9D4FZZJANyQ+bSc+TBm2FpLD4sE1guvWt2Ewv04
 gPCFyAEBt6xp7148NkE4XCPik9tAUu2oq1CU0e7FYkj/QzcvBqAwF8/yL
 Io1LEGsvaLNsXgAl50aEfvQMTISknDooJ8MD0N9HA85f0P+/4ZBhBnMIb A==;
X-CSE-ConnectionGUID: 4y5kFv/cQ66bCKz7kt1ljg==
X-CSE-MsgGUID: 4xTHB1c5QEe9uOjL3R+vUQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11555"; a="64205854"
X-IronPort-AV: E=Sophos;i="6.18,271,1751266800"; d="scan'208";a="64205854"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
 by fmvoesa106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 16 Sep 2025 23:52:04 -0700
X-CSE-ConnectionGUID: nWdxAy/oRPSICiUSZXrpbg==
X-CSE-MsgGUID: kGHS4K15R1albMUj9qO1vA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.18,271,1751266800"; d="scan'208";a="179166137"
Received: from liuzhao-optiplex-7080.sh.intel.com (HELO localhost)
 ([10.239.160.39])
 by orviesa003.jf.intel.com with ESMTP; 16 Sep 2025 23:52:03 -0700
Date: Wed, 17 Sep 2025 15:13:57 +0800
From: Zhao Liu <zhao1.liu@intel.com>
To: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>
Cc: Paolo Bonzini <pbonzini@redhat.com>, qemu-devel@nongnu.org,
 qemu-rust@nongnu.org
Subject: Re: [PATCH 08/12] rust/qdev: Support property info for more common
 types
Message-ID: <aMpftVa00OfVc1Cw@intel.com>
References: <20250916085557.2008344-1-zhao1.liu@intel.com>
 <20250916085557.2008344-9-zhao1.liu@intel.com>
 <CAAjaMXaVavbhgF49iCy-kgXB3uk06d=mShK_WrVJu9Bd3HUz0g@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAAjaMXaVavbhgF49iCy-kgXB3uk06d=mShK_WrVJu9Bd3HUz0g@mail.gmail.com>
Received-SPF: pass client-ip=192.198.163.12; envelope-from=zhao1.liu@intel.com;
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

On Tue, Sep 16, 2025 at 01:13:28PM +0300, Manos Pitsidianakis wrote:
> Date: Tue, 16 Sep 2025 13:13:28 +0300
> From: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>
> Subject: Re: [PATCH 08/12] rust/qdev: Support property info for more common
>  types
> 
> On Tue, Sep 16, 2025 at 11:34 AM Zhao Liu <zhao1.liu@intel.com> wrote:
> >
> > Add a helper macro to implement QDevProp trait for u8/u16/u32/usize/i32
> > /i64.
> >
> > Signed-off-by: Zhao Liu <zhao1.liu@intel.com>
> > ---
> 
> Reviewed-by: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>

Thanks!

> You can do something like this btw:
> 
> macro_rules! impl_qdev_prop {
>     ($($type:ty => $info:ident),*$(,)?) => {
>         $(unsafe impl $crate::qdev::QDevProp for $type {
>             const BASE_INFO: *const $crate::bindings::PropertyInfo =
>                 addr_of!($crate::bindings::$info);
>         })*
>     };
>  }
> 
> impl_qdev_prop!(
>     bool => qdev_prop_bool,
>     u8 => qdev_prop_uint8,
>     ...
> );
> 

Yes, this can work! But a benefit of non-repetitive macro is that it
can also be exposed for use by other crates if necessary.

Regards,
Zhao


