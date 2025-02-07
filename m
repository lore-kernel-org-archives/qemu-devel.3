Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AA129C02192
	for <qemu-devel@archiver.kernel.org>; Fri,  7 Feb 2025 08:25:31 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tgJfF-0003it-2p; Fri, 07 Feb 2025 03:24:41 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1tgJfC-0003i5-Il; Fri, 07 Feb 2025 03:24:38 -0500
Received: from mgamail.intel.com ([198.175.65.17])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1tgJfA-0001s5-Av; Fri, 07 Feb 2025 03:24:38 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1738916676; x=1770452676;
 h=date:from:to:cc:subject:message-id:references:
 mime-version:content-transfer-encoding:in-reply-to;
 bh=alS5qVhFCCybRfyInaLelXojIz7gLZOiCl97klrBBE8=;
 b=e54iWr0GsQdBOuPwKsJI4s48VWeQTCvo/7OM2rTX8SBmGYYlF28nNRe+
 DXo0w+LNrqm9SF0wTdAm12otet7n2z+1lDMJxeeC85hPVC2WFKXZ4nXmI
 Pum8rH/XWNy22D+AjxPA2/v6YoTVx5CtT/fyXNTmxPV+GXSxbPDY+BQWY
 hgm5+y5puZexCUkZFzd30QFXsFx1Irs8ac9jSXxhCnUb5KklXmVEO6olv
 Qowpqp2UuY7gOo92cRgfbuPMRG0tvI7yOF4BRc5u2RmhmQgZSf0ZKqabm
 tuyovEtqKIAVf1aWPvscr5MRkMzggJ90ucpHlhVH3Bt7DeRvLxHZufEAN A==;
X-CSE-ConnectionGUID: kBi1SM2KSNmwBlHZXOOUGQ==
X-CSE-MsgGUID: VVshjRorShKjcUPRbPNRxw==
X-IronPort-AV: E=McAfee;i="6700,10204,11336"; a="39579024"
X-IronPort-AV: E=Sophos;i="6.13,266,1732608000"; d="scan'208";a="39579024"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
 by orvoesa109.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 07 Feb 2025 00:24:30 -0800
X-CSE-ConnectionGUID: AzF9DddJT86IrAN5uvi0Bg==
X-CSE-MsgGUID: 7rtJ+DWuR+yo+0b4rH2SFg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.13,266,1732608000"; d="scan'208";a="111388339"
Received: from liuzhao-optiplex-7080.sh.intel.com (HELO localhost)
 ([10.239.160.39])
 by fmviesa007.fm.intel.com with ESMTP; 07 Feb 2025 00:24:28 -0800
Date: Fri, 7 Feb 2025 16:43:57 +0800
From: Zhao Liu <zhao1.liu@intel.com>
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>,
 Junjie Mao <junjie.mao@hotmail.com>,
 Alex =?iso-8859-1?Q?Benn=E9e?= <alex.bennee@linaro.org>,
 Philippe =?iso-8859-1?Q?Mathieu-Daud=E9?= <philmd@linaro.org>,
 Richard Henderson <richard.henderson@linaro.org>,
 Peter Maydell <peter.maydell@linaro.org>,
 Daniel P =?iso-8859-1?Q?=2E_Berrang=E9?= <berrange@redhat.com>,
 qemu-devel@nongnu.org, qemu-rust@nongnu.org
Subject: Re: [PATCH 04/10] rust: add bindings for gpio_{in|out} initialization
Message-ID: <Z6XHzXwoIklPZQ/I@intel.com>
References: <20250125125137.1223277-1-zhao1.liu@intel.com>
 <20250125125137.1223277-5-zhao1.liu@intel.com>
 <5a19e7d2-9d69-45fe-812f-84145229876f@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <5a19e7d2-9d69-45fe-812f-84145229876f@redhat.com>
Received-SPF: pass client-ip=198.175.65.17; envelope-from=zhao1.liu@intel.com;
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

On Wed, Jan 29, 2025 at 11:59:04AM +0100, Paolo Bonzini wrote:
> Date: Wed, 29 Jan 2025 11:59:04 +0100
> From: Paolo Bonzini <pbonzini@redhat.com>
> Subject: Re: [PATCH 04/10] rust: add bindings for gpio_{in|out}
>  initialization
> 
> 
> 
> On Sat, Jan 25, 2025 at 1:32 PM Zhao Liu <zhao1.liu@intel.com> wrote:
> > +    fn init_gpio_in<F: for<'a> FnCall<(&'a Self::Target, u32, u32)>>(&self, num_lines: u32, _f: F) {
> > +        unsafe extern "C" fn rust_irq_handler<T, F: for<'a> FnCall<(&'a T, u32, u32)>>(
> > +            opaque: *mut c_void,
> > +            line: c_int,
> > +            level: c_int,
> > +        ) {
> > +            // SAFETY: the opaque was passed as a reference to `T`
> > +            F::call((unsafe { &*(opaque.cast::<T>()) }, line as u32, level as u32))
> > +        }
> > +
> > +        let gpio_in_cb: unsafe extern "C" fn(*mut c_void, c_int, c_int) =
> > +            rust_irq_handler::<Self::Target, F>;
> 
> Please add "let _: () = F::ASSERT_IS_SOME;", which is added by the
> qdev_init_clock_in() patch.
> 

Okay.

I would add `assert!(F::is_some());` at the beginning of init_gpio_in().

There's a difference with origianl C version:

In C side, qdev_get_gpio_in() family could accept a NULL handler, but
there's no such case in current QEMU:

* qdev_get_gpio_in
* qdev_init_gpio_in_named
* qdev_init_gpio_in_named_with_opaque

And from code logic view, creating an input GPIO line but doing nothing
on input, sounds also unusual.

So, for simplicity, in the Rust version I make the handler non-optional.



