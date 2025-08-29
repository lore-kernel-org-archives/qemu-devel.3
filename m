Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 703D7CA0EFF
	for <qemu-devel@archiver.kernel.org>; Sat, 30 Aug 2025 15:32:28 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1usNBb-0006SW-Gk; Sat, 30 Aug 2025 11:08:11 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1uruc3-0005wa-4t; Fri, 29 Aug 2025 04:37:35 -0400
Received: from mgamail.intel.com ([192.198.163.16])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1uruc0-0007v3-6l; Fri, 29 Aug 2025 04:37:34 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1756456652; x=1787992652;
 h=date:from:to:cc:subject:message-id:references:
 mime-version:content-transfer-encoding:in-reply-to;
 bh=8MEwvMA5vWesPqUlof2mHDRU5hI6F3MzUmiUPKTMc2w=;
 b=HIsEgfp1Go/hDO3tu/U2onEWeLqA65sQ0z6AEJe9in9AREA2ERzH0dba
 2t2NXNW4BHxC8pgxaAWk5m+mQZVppb+7p4n4x2/fpQtLQCqIcD7ZOObpB
 f6dEYKYJNvIeHKkI53mWwIr34lTEIJoOWrV7M2MQ8q0mCKaH+TRgY6MZd
 SXW6UHCoHEBQkbf/EiO/88xhbTgSUpvnwUYiU29nYLlQ2PkfYSDS3u6sc
 xCfK3ILArvPEbvAr0xJrlGKuIXij5Fcij4Q2GPDVOpaE7GvWtn/QY43Qg
 c/2g9qKBgKQPqImrW48/6rq2UcaK8WP79p7CbxxweVPWzMVY8o7JGneDX Q==;
X-CSE-ConnectionGUID: rtumsdV7TUeypL5xK0KwDQ==
X-CSE-MsgGUID: GU90eCCpSr6IL5+I/o0vsg==
X-IronPort-AV: E=McAfee;i="6800,10657,11536"; a="46308778"
X-IronPort-AV: E=Sophos;i="6.18,221,1751266800"; d="scan'208";a="46308778"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
 by fmvoesa110.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 29 Aug 2025 01:37:25 -0700
X-CSE-ConnectionGUID: yNyV1i/RRbCTfXHCc77mNw==
X-CSE-MsgGUID: m8WXClvBTLinjLXFgRmqwg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.18,221,1751266800"; d="scan'208";a="170718644"
Received: from liuzhao-optiplex-7080.sh.intel.com (HELO localhost)
 ([10.239.160.39])
 by fmviesa008.fm.intel.com with ESMTP; 29 Aug 2025 01:37:23 -0700
Date: Fri, 29 Aug 2025 16:59:10 +0800
From: Zhao Liu <zhao1.liu@intel.com>
To: marcandre.lureau@redhat.com
Cc: qemu-devel@nongnu.org, qemu-rust@nongnu.org,
 Daniel =?iso-8859-1?Q?P=2E_Berrang=E9?= <berrange@redhat.com>,
 Philippe =?iso-8859-1?Q?Mathieu-Daud=E9?= <philmd@linaro.org>,
 pbonzini@redhat.com, Manos Pitsidianakis <manos.pitsidianakis@linaro.org>
Subject: Re: [PATCH 10/22] rust: split "migration" crate
Message-ID: <aLFr3u+r8P5GGZRJ@intel.com>
References: <20250827104147.717203-1-marcandre.lureau@redhat.com>
 <20250827104147.717203-11-marcandre.lureau@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20250827104147.717203-11-marcandre.lureau@redhat.com>
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

Hi Marc-Andre,

On Wed, Aug 27, 2025 at 02:41:32PM +0400, marcandre.lureau@redhat.com wrote:
> Date: Wed, 27 Aug 2025 14:41:32 +0400
> From: marcandre.lureau@redhat.com
> Subject: [PATCH 10/22] rust: split "migration" crate
> 
> From: Marc-André Lureau <marcandre.lureau@redhat.com>
> 
> Signed-off-by: Marc-André Lureau <marcandre.lureau@redhat.com>
> ---

...

> @@ -0,0 +1,51 @@
> +/*
> + * QEMU System Emulator
> + *
> + * Copyright (c) 2024 Linaro Ltd.
> + *
> + * Authors: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>
> + *
> + * Permission is hereby granted, free of charge, to any person obtaining a copy
> + * of this software and associated documentation files (the "Software"), to deal
> + * in the Software without restriction, including without limitation the rights
> + * to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
> + * copies of the Software, and to permit persons to whom the Software is
> + * furnished to do so, subject to the following conditions:
> + *
> + * The above copyright notice and this permission notice shall be included in
> + * all copies or substantial portions of the Software.
> + *
> + * THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
> + * IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
> + * FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL
> + * THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
> + * LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
> + * OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
> + * THE SOFTWARE.
> + */

Could we use /* SPDX-License-Identifier: GPL-2.0-or-later */ directly ?

[snip]

> +// using extension traits would be nicer, unfortunately it doesn't allow const
> +// fn yet
> +pub struct VMStateFieldHelper(pub VMStateField);
>
>  // Add a couple builder-style methods to VMStateField, allowing
>  // easy derivation of VMStateField constants from other types.

A question: Sorry I didn't get your point about why we need
VMStateFieldHelper?

For its use case:

> -        vmstate_struct!(FooB, arr_a[0 .. num_a], &VMSTATE_FOOA, FooA).with_version_id(1),
> -        vmstate_struct!(FooB, arr_a_mul[0 .. num_a_mul * 32], &VMSTATE_FOOA, FooA).with_version_id(2),
> +        VMStateFieldHelper(vmstate_struct!(FooB, arr_a[0 .. num_a], &VMSTATE_FOOA, FooA)).with_version_id(1).0,
> +        VMStateFieldHelper(vmstate_struct!(FooB, arr_a_mul[0 .. num_a_mul * 32], &VMSTATE_FOOA, FooA)).with_version_id(2).0,

It seems VMStateFieldHelper add another wrapper around vmstate_struct
(and vmstate_of).

The builder pattern is good, but I'm afraid this builder makes the use of
vmstate_struct! more complex.

> -impl VMStateField {
> +impl VMStateFieldHelper {
>      #[must_use]
>      pub const fn with_version_id(mut self, version_id: i32) -> Self {
>          assert!(version_id >= 0);
> -        self.version_id = version_id;
> +        self.0.version_id = version_id;
>          self
>      }

If we could have a build() method then user doesn't need to write ".0"
at the end.

>  }

And there's another VMStateDescriptionBuilder:

https://lore.kernel.org/qemu-devel/20250505100854.73936-4-pbonzini@redhat.com/#t

I think Paolo has the plan to merge it with v1.83 support. So if this
VMStateFieldHelper is necessary, it's better seperate this into another
patch and base it over VMStateDescriptionBuilder if possible.

Thanks,
Zhao


