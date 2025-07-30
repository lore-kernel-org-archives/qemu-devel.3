Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2E22DC87FC9
	for <qemu-devel@archiver.kernel.org>; Wed, 30 Jul 2025 08:31:55 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uh2Dn-0001ng-So; Wed, 30 Jul 2025 04:31:38 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1uh1qW-0003Aq-Dv; Wed, 30 Jul 2025 04:07:32 -0400
Received: from mgamail.intel.com ([192.198.163.11])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1uh1qU-0008Qm-Ed; Wed, 30 Jul 2025 04:07:32 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1753862851; x=1785398851;
 h=date:from:to:cc:subject:message-id:references:
 mime-version:in-reply-to;
 bh=/B21S4ncBoB5+WmK3DLxCfYKt3FEo1x8DXT3apgobf0=;
 b=ItQtz0jq+sI0grXiWYkJDInrG/IIDL9TDRxx3dsvEh6rUYsZagFATDI4
 9NmGPHUBqhzYUoziBH4EcSR8lAKOsGAID5YeJHGViiADeAryoLGSXE1cA
 M+P/VNnT1obn1YA/4f0w0DD6KipV18Ka6/czTrGTaCGMCizwd8R3dHAn9
 sDcuiASVdNc+1rK9q7g2JOqJsb7XfjrVJH/UFo7F6ahq4Hd/hQ3zqXPM6
 0tF2Knpx/V7QBwdKHqflvDKY4SqQSPNG9N9RI+EmUGL42Yf7w9PD4B6F3
 oSI1/vogqKwvvG8oAnnQ43ixK2qA9RBbGoZ3oVe5OLK7HoomxMECf4ld8 w==;
X-CSE-ConnectionGUID: ZTI/1zGhTVac2XsfSa8R0w==
X-CSE-MsgGUID: 3OtUcW9GQ8uVy2hIQgA+qg==
X-IronPort-AV: E=McAfee;i="6800,10657,11506"; a="66721522"
X-IronPort-AV: E=Sophos;i="6.16,350,1744095600"; d="scan'208";a="66721522"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
 by fmvoesa105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 30 Jul 2025 01:07:27 -0700
X-CSE-ConnectionGUID: hDcRCRqSS+u3LzNLKJjF4A==
X-CSE-MsgGUID: vtCC4fUcQzKZicpdNM8ZRg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,350,1744095600"; d="scan'208";a="186600364"
Received: from liuzhao-optiplex-7080.sh.intel.com (HELO localhost)
 ([10.239.160.39])
 by fmviesa002.fm.intel.com with ESMTP; 30 Jul 2025 01:07:25 -0700
Date: Wed, 30 Jul 2025 16:29:01 +0800
From: Zhao Liu <zhao1.liu@intel.com>
To: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>
Cc: qemu-devel@nongnu.org, qemu-rust@nongnu.org
Subject: Re: [PATCH] rust: declare self as qemu_api for proc-macros
Message-ID: <aInXzUamULqelELf@intel.com>
References: <20250728-self-as-qemu_api-v1-1-001c339cccc8@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250728-self-as-qemu_api-v1-1-001c339cccc8@linaro.org>
Received-SPF: pass client-ip=192.198.163.11; envelope-from=zhao1.liu@intel.com;
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

> diff --git a/rust/qemu-api/src/lib.rs b/rust/qemu-api/src/lib.rs
> index 86dcd8ef17a9ecd040742a99e4b0421e19ec88f6..44d995cfdb990e0d17e7216cf4d1f04a5a980a1f 100644
> --- a/rust/qemu-api/src/lib.rs
> +++ b/rust/qemu-api/src/lib.rs
> @@ -32,6 +32,9 @@
>  pub mod vmstate;
>  pub mod zeroable;
>  
> +// Allow proc-macros to refer to `::qemu_api` inside the `qemu_api` crate (this crate).
> +extern crate self as qemu_api;
> +
>  use std::{
>      alloc::{GlobalAlloc, Layout},
>      ffi::c_void,

I've learned something new as well. Though late,

Reviewed-by: Zhao Liu <zhao1.liu@intel.com>


