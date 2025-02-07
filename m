Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CF52EC02192
	for <qemu-devel@archiver.kernel.org>; Fri,  7 Feb 2025 06:52:58 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tgIDw-0003IU-1y; Fri, 07 Feb 2025 01:52:24 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1tgIDl-0003Gd-43; Fri, 07 Feb 2025 01:52:13 -0500
Received: from mgamail.intel.com ([198.175.65.21])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1tgIDi-0000ob-Ep; Fri, 07 Feb 2025 01:52:12 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1738911131; x=1770447131;
 h=date:from:to:cc:subject:message-id:references:
 mime-version:content-transfer-encoding:in-reply-to;
 bh=egq0cYWfPaMnTx9wXuN6RsRl60d8z95BLAdDihuuI2s=;
 b=BCh+FP1RpBuHVd8GHB9Am90dvrmyocEP80/fUsw9GFI4MIrid6Vj/jbf
 72PUegme/z8r2f9Xs0HAQEt5t0iVKAsOHXYqysWoXKgxO4su5GOs7XEA0
 tkM4IGxbqB38ylJVu67U8tDEZUcOG5Ak4fcjKkTbTzjk40c3jDKrBdNDi
 zuAEj/nl9y9e+uaz3ZYk2hFbNI5EAqG5ISxwvJMRIoqAf5RZfcRyfzPd3
 bTPrv1SKwP+mkxfs3ct+aZIGEu+gbreLM9DVoeC882YqDdgd8ZVg5+Fx7
 5KbhM0NSRKMjrFuDGJmntAWM3NZSikwG66vDyLARGZSrxwfLzGfCypD5p A==;
X-CSE-ConnectionGUID: EHX586YqS3+BNwUI28PCdA==
X-CSE-MsgGUID: a3GDB3qPQiynIaAG5mLxxg==
X-IronPort-AV: E=McAfee;i="6700,10204,11336"; a="39451552"
X-IronPort-AV: E=Sophos;i="6.13,266,1732608000"; d="scan'208";a="39451552"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
 by orvoesa113.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 06 Feb 2025 22:51:27 -0800
X-CSE-ConnectionGUID: GMOoCvHZTJiGXcznNZfSjQ==
X-CSE-MsgGUID: EcjCImYFQAmhYL4kRVooeQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.13,266,1732608000"; d="scan'208";a="111639499"
Received: from liuzhao-optiplex-7080.sh.intel.com (HELO localhost)
 ([10.239.160.39])
 by fmviesa008.fm.intel.com with ESMTP; 06 Feb 2025 22:51:24 -0800
Date: Fri, 7 Feb 2025 15:10:53 +0800
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
Subject: Re: [PATCH 03/10] rust/irq: Add a helper to convert
 [InterruptSource] to [*mut IRQState]
Message-ID: <Z6Wx/RGBIElMaeZy@intel.com>
References: <20250125125137.1223277-1-zhao1.liu@intel.com>
 <20250125125137.1223277-4-zhao1.liu@intel.com>
 <17907481-89d6-457c-bcd3-66a444b1325d@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <17907481-89d6-457c-bcd3-66a444b1325d@redhat.com>
Received-SPF: pass client-ip=198.175.65.21; envelope-from=zhao1.liu@intel.com;
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

On Wed, Jan 29, 2025 at 11:51:02AM +0100, Paolo Bonzini wrote:
> Date: Wed, 29 Jan 2025 11:51:02 +0100
> From: Paolo Bonzini <pbonzini@redhat.com>
> Subject: Re: [PATCH 03/10] rust/irq: Add a helper to convert
>  [InterruptSource] to [*mut IRQState]
> 
> On Sat, Jan 25, 2025 at 1:32 PM Zhao Liu <zhao1.liu@intel.com> wrote:
> > 
> > This is useful to hanlde InterruptSource slice and pass it to C
> > bindings.
> > 
> > Suggested-by: Paolo Bonzini <pbonzini@redhat.com>
> 
> This may be a bad suggestion, after all. clippy complains that you're
> casting &[*mut IRQState] to mutable (https://rust-lang.github.io/rust-
> clippy/master/#as_ptr_cast_mut).
> 
> I can think of two solutions:
> 
> 1) add #[allow(clippy::as_ptr_cast_mut)] and explain with a comment
> 
>     // Casting to *mut *mut IRQState is valid, because
>     // the source slice `pins` uses interior mutability.
> 
> 2) drop as_slice_of_qemu_irq() and replace it with something like
> 
>     pub(crate) const fn slice_as_ptr(slice: &[Self]) -> *mut *mut IRQState {
>         slice[0].as_ptr()
>     }
> 
> You choose.
>

:) I choose the second way, which goes back to the initial codes.

Though an empty slice w/o any check would cause a runtime error like:

"thread '<unnamed>' panicked at 'index out of bounds: the len is 0 but the index is 0'"

Adding an assert to ensure a non-empty slice is better.

Thanks,
Zhao


