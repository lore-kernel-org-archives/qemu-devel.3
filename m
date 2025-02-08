Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7AD9DC02198
	for <qemu-devel@archiver.kernel.org>; Sat,  8 Feb 2025 10:56:15 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tgiUk-0003QZ-3h; Sat, 08 Feb 2025 05:55:30 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1tgiUh-0003Pj-QM; Sat, 08 Feb 2025 05:55:27 -0500
Received: from mgamail.intel.com ([198.175.65.19])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1tgiUf-0001fm-Rt; Sat, 08 Feb 2025 05:55:27 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1739012126; x=1770548126;
 h=date:from:to:cc:subject:message-id:references:
 mime-version:content-transfer-encoding:in-reply-to;
 bh=bpHfQoqEkdxhjobtTG8rJewexyyXdUtlbHZZgYIXbV8=;
 b=GmKO5YEus53rYwEUIHVbtJ1xg5YPFm8Hr6iHNskpCCDIiC/p0bBcccGF
 YPJ73lLPTxg4D+ALhI8TDKLJZrL7WA6H9kC6GTAYe++C3G29YUWRA2EDL
 30NMVdfBt1PnsBueHv3Q8FzYSOktqQhVBBlylA+7LKixzxa/tpF0ZvLuQ
 fy36WmtENiKi9Truco5VnyC8d34PjO0u+wdNQecjmLgbmdNDVw5LOhBHv
 BnWjITLn7AvWdxhUXRMGuXofCOKES6OT9yaXOZ46s0rOYNsJqgxT4rUrC
 5dTgoAk/nPgzrM57UhaomUx6MpwQt8owubrQVLjx9dwk/PcEmVThu3WrF Q==;
X-CSE-ConnectionGUID: lo1DU0VOSYCzBBTD/XsueA==
X-CSE-MsgGUID: +21WjFYnSYOtNgh1vBf6dw==
X-IronPort-AV: E=McAfee;i="6700,10204,11338"; a="39519728"
X-IronPort-AV: E=Sophos;i="6.13,269,1732608000"; d="scan'208";a="39519728"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
 by orvoesa111.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 08 Feb 2025 02:55:23 -0800
X-CSE-ConnectionGUID: HGvXpS3XRe2n4BUQQiipGA==
X-CSE-MsgGUID: 87Lfi/NtS+uu+TnARP6Wyw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,224,1728975600"; d="scan'208";a="116356226"
Received: from liuzhao-optiplex-7080.sh.intel.com (HELO localhost)
 ([10.239.160.39])
 by fmviesa005.fm.intel.com with ESMTP; 08 Feb 2025 02:55:20 -0800
Date: Sat, 8 Feb 2025 19:14:50 +0800
From: Zhao Liu <zhao1.liu@intel.com>
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>,
 Junjie Mao <junjie.mao@hotmail.com>,
 Alex =?utf-8?B?QmVubu+/vWU=?= <alex.bennee@linaro.org>,
 Philippe =?utf-8?B?TWF0aGlldS1EYXVk77+9?= <philmd@linaro.org>,
 Richard Henderson <richard.henderson@linaro.org>,
 Peter Maydell <peter.maydell@linaro.org>,
 Daniel P =?utf-8?B?LiBCZXJyYW5n77+9?= <berrange@redhat.com>,
 qemu-devel <qemu-devel@nongnu.org>, qemu-rust@nongnu.org
Subject: Re: [PATCH 03/10] rust/irq: Add a helper to convert
 [InterruptSource] to [*mut IRQState]
Message-ID: <Z6c8qju9IJaKM6rK@intel.com>
References: <20250125125137.1223277-1-zhao1.liu@intel.com>
 <20250125125137.1223277-4-zhao1.liu@intel.com>
 <17907481-89d6-457c-bcd3-66a444b1325d@redhat.com>
 <Z6Wx/RGBIElMaeZy@intel.com> <Z6W56AH3J1qOx18m@intel.com>
 <CABgObfa+_VVQWvrGWf6fJjf39O0AkoNB5aoptDrhk7dDx_SNXQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CABgObfa+_VVQWvrGWf6fJjf39O0AkoNB5aoptDrhk7dDx_SNXQ@mail.gmail.com>
Received-SPF: pass client-ip=198.175.65.19; envelope-from=zhao1.liu@intel.com;
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

On Fri, Feb 07, 2025 at 10:57:11AM +0100, Paolo Bonzini wrote:
> Date: Fri, 7 Feb 2025 10:57:11 +0100
> From: Paolo Bonzini <pbonzini@redhat.com>
> Subject: Re: [PATCH 03/10] rust/irq: Add a helper to convert
>  [InterruptSource] to [*mut IRQState]
> 
> Il ven 7 feb 2025, 08:25 Zhao Liu <zhao1.liu@intel.com> ha scritto:
> 
> > Just to confirm, I check with `cargo +nightly clippy` but it doesn't
> > complain about this case. Should I switch to another version of clippy
> > when I do such check? (currently I'm using v0.1.63 clippy as well, to
> > match rustc.)
> >
> 
> I don't remember exactly how I noticed it—I am pretty sure it broke in CI
> though. Maybe the change to add rust_version hid it.
> 
> To answer your question, generally the idea is that we use the latest
> version of the developer tools (cargo, rustfmt, clippy). In particular old
> versions of cargo don't support retrieving clippy settings from Cargo.toml.

This one inspired me. I'm thinking that even though we deleted the
README of pl011, a gneral guide or doc section (at somewhere, e.g.,
docs/devel/style.rst or docs/devel/submitting-a-patch.rst) would be
helpful.

At least, that could remind contributor to check patches with latest
toolchain instead of letting the maintainer's CI smoking fail.

Thanks,
Zhao


