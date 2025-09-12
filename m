Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C10F7CA101F
	for <qemu-devel@archiver.kernel.org>; Fri, 12 Sep 2025 08:24:27 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uwz4O-0003vD-P1; Fri, 12 Sep 2025 04:23:48 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1uwz4M-0003uP-E5
 for qemu-devel@nongnu.org; Fri, 12 Sep 2025 04:23:46 -0400
Received: from mgamail.intel.com ([192.198.163.9])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1uwz4A-0002fv-MD
 for qemu-devel@nongnu.org; Fri, 12 Sep 2025 04:23:45 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1757665414; x=1789201414;
 h=date:from:to:cc:subject:message-id:references:
 mime-version:content-transfer-encoding:in-reply-to;
 bh=b1FRdYibeORJ7kbknxdslAGcYtGOj3HJFaXPxqH9tNE=;
 b=Xr6LA6SQtn6tHzz9Hqcm7ysJe3bfMb1zp3Lv6WAzZk8kFOnQ9/DMkWdl
 KFD61ItFFV6VvpDR0z/t/nkc7X6QlKsGWQfShx4LjTgBKMQEF/L5p22ix
 +2DO8XqvKxI8Gm4EOe6bOWITz8M1Sucv/Zhn/lqLqGPgWaIK0IxFjKDZF
 cKyz/+YtY+kDdl6cbp0wZNZWE1YzVOQoPmnCcKgUtSmH/+mIQLvc8q1VH
 PVeZIs4aDhRCYiCNGo5kNFt1W38bvcQ2iqPoohJ4RVTz3IN86l50wDMGG
 yztSubmH/lmwWK9OmZGVUGuySC/YpL5Rz3td4pRYoPoH2vZXSffJ0mIbD A==;
X-CSE-ConnectionGUID: kpC0wLVmQdO921HW+rdtdQ==
X-CSE-MsgGUID: 3B3Ta9t2TMGk2gJVy4Pp2w==
X-IronPort-AV: E=McAfee;i="6800,10657,11550"; a="70692144"
X-IronPort-AV: E=Sophos;i="6.18,259,1751266800"; d="scan'208";a="70692144"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
 by fmvoesa103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 12 Sep 2025 01:23:31 -0700
X-CSE-ConnectionGUID: 2GkG5WQdTwyx8w185q4ndg==
X-CSE-MsgGUID: PoOB+y2URmqI5OSOXG8CGQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.18,259,1751266800"; d="scan'208";a="173820211"
Received: from liuzhao-optiplex-7080.sh.intel.com (HELO localhost)
 ([10.239.160.39])
 by fmviesa006.fm.intel.com with ESMTP; 12 Sep 2025 01:23:29 -0700
Date: Fri, 12 Sep 2025 16:45:22 +0800
From: Zhao Liu <zhao1.liu@intel.com>
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: qemu-devel@nongnu.org,
 =?iso-8859-1?Q?Marc-Andr=E9?= Lureau <marcandre.lureau@redhat.com>
Subject: Re: [PATCH 27/33] rust/pl011: drop dependency on qemu_api
Message-ID: <aMPdopN1knMfofrM@intel.com>
References: <20250908105005.2119297-1-pbonzini@redhat.com>
 <20250908105005.2119297-28-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20250908105005.2119297-28-pbonzini@redhat.com>
Received-SPF: pass client-ip=192.198.163.9; envelope-from=zhao1.liu@intel.com;
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

On Mon, Sep 08, 2025 at 12:49:59PM +0200, Paolo Bonzini wrote:
> Date: Mon,  8 Sep 2025 12:49:59 +0200
> From: Paolo Bonzini <pbonzini@redhat.com>
> Subject: [PATCH 27/33] rust/pl011: drop dependency on qemu_api
> X-Mailer: git-send-email 2.51.0
> 
> From: Marc-André Lureau <marcandre.lureau@redhat.com>
> 
> Signed-off-by: Marc-André Lureau <marcandre.lureau@redhat.com>
> Link: https://lore.kernel.org/r/20250827104147.717203-19-marcandre.lureau@redhat.com
> Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
> ---
>  rust/hw/char/pl011/wrapper.h       | 51 ++++++++++++++++++++++++++++++
>  rust/Cargo.lock                    |  1 -
>  rust/hw/char/pl011/Cargo.toml      |  1 -
>  rust/hw/char/pl011/build.rs        |  1 +
>  rust/hw/char/pl011/meson.build     | 27 ++++++++++++++--
>  rust/hw/char/pl011/src/bindings.rs | 27 ++++++++++++++++
>  rust/hw/char/pl011/src/device.rs   |  2 +-
>  rust/hw/char/pl011/src/lib.rs      |  1 +
>  8 files changed, 106 insertions(+), 5 deletions(-)
>  create mode 100644 rust/hw/char/pl011/wrapper.h
>  create mode 120000 rust/hw/char/pl011/build.rs
>  create mode 100644 rust/hw/char/pl011/src/bindings.rs
> 
> diff --git a/rust/hw/char/pl011/wrapper.h b/rust/hw/char/pl011/wrapper.h
> new file mode 100644
> index 00000000000..87a5a589c8e
> --- /dev/null
> +++ b/rust/hw/char/pl011/wrapper.h
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

nit: missing SPDX-License-Identifier.

Reviewed-by: Zhao Liu <zhao1.liu@intel.com>



