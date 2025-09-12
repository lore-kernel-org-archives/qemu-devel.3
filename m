Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 40071CA101F
	for <qemu-devel@archiver.kernel.org>; Fri, 12 Sep 2025 07:48:59 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uwyVi-0005sO-JO; Fri, 12 Sep 2025 03:47:58 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1uwyVh-0005sC-HL
 for qemu-devel@nongnu.org; Fri, 12 Sep 2025 03:47:57 -0400
Received: from mgamail.intel.com ([192.198.163.8])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1uwyVc-0005BK-K1
 for qemu-devel@nongnu.org; Fri, 12 Sep 2025 03:47:57 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1757663273; x=1789199273;
 h=date:from:to:cc:subject:message-id:references:
 mime-version:content-transfer-encoding:in-reply-to;
 bh=T2FZULKL/GNF3SxCQJQxlMyKY6n+HqbRFC970p3zX7Y=;
 b=gdFmBeq7GvEoomJt1y0mgv0WEwgUnkKLnComsJUzkjs5my7gWj5w2cdq
 0D9biFR6tOErl0IDkuvZD2xIHIgz7brXxej7VBrHQWcdw1C4Wf59t3CCf
 ViTaVSwMORUT0IXoK5/ntp+4HBc6fx4/ddMJt3SMC7w06STmNypXm7DIW
 xhvEIeymzhya6aqEiU1/vGn8ECsCdcmI5Ivj65/3oktuRVEPRtRkhuEAl
 ouCr7R2tWm8C614f1ZsFwSSAHuNpZ9UAgI3Mh68Ro57Q0gBajEUw3Zes/
 RHfN9mdVQK5Q2WpHR3hxf692GDFeojCXpXOVPDY/wdclvh2cOUHb3tF+f w==;
X-CSE-ConnectionGUID: FRzfU1tmQ8iC9aiDS+wvZQ==
X-CSE-MsgGUID: zgVtxddMTVWiZyZ+WL3/Hw==
X-IronPort-AV: E=McAfee;i="6800,10657,11550"; a="77614671"
X-IronPort-AV: E=Sophos;i="6.18,259,1751266800"; d="scan'208";a="77614671"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
 by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 12 Sep 2025 00:47:49 -0700
X-CSE-ConnectionGUID: 4kvLHRJjTliy5dSLmuyGfw==
X-CSE-MsgGUID: 9CFjKn4VQkuhhBWk9xn9uw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.18,259,1751266800"; d="scan'208";a="197595086"
Received: from liuzhao-optiplex-7080.sh.intel.com (HELO localhost)
 ([10.239.160.39])
 by fmviesa002.fm.intel.com with ESMTP; 12 Sep 2025 00:47:48 -0700
Date: Fri, 12 Sep 2025 16:09:41 +0800
From: Zhao Liu <zhao1.liu@intel.com>
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: qemu-devel@nongnu.org,
 =?iso-8859-1?Q?Marc-Andr=E9?= Lureau <marcandre.lureau@redhat.com>
Subject: Re: [PATCH 19/33] rust: split "migration" crate
Message-ID: <aMPVRZZ5uF/q7XQ4@intel.com>
References: <20250908105005.2119297-1-pbonzini@redhat.com>
 <20250908105005.2119297-20-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20250908105005.2119297-20-pbonzini@redhat.com>
Received-SPF: pass client-ip=192.198.163.8; envelope-from=zhao1.liu@intel.com;
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

On Mon, Sep 08, 2025 at 12:49:51PM +0200, Paolo Bonzini wrote:
> Date: Mon,  8 Sep 2025 12:49:51 +0200
> From: Paolo Bonzini <pbonzini@redhat.com>
> Subject: [PATCH 19/33] rust: split "migration" crate
> X-Mailer: git-send-email 2.51.0
> 
> From: Marc-André Lureau <marcandre.lureau@redhat.com>
> 
> Signed-off-by: Marc-André Lureau <marcandre.lureau@redhat.com>
> Link: https://lore.kernel.org/r/20250827104147.717203-11-marcandre.lureau@redhat.com
> Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
> ---
>  MAINTAINERS                                 |  1 +
>  rust/migration/wrapper.h                    | 51 ++++++++++++++++++++
>  rust/qemu-api/wrapper.h                     |  1 -
>  rust/Cargo.lock                             | 12 +++++
>  rust/Cargo.toml                             |  1 +
>  rust/hw/char/pl011/Cargo.toml               |  1 +
>  rust/hw/char/pl011/meson.build              |  1 +
>  rust/hw/char/pl011/src/device.rs            | 13 ++---
>  rust/hw/char/pl011/src/registers.rs         |  2 +-
>  rust/hw/timer/hpet/Cargo.toml               |  1 +
>  rust/hw/timer/hpet/meson.build              |  1 +
>  rust/hw/timer/hpet/src/device.rs            | 11 +++--
>  rust/meson.build                            |  1 +
>  rust/migration/Cargo.toml                   | 21 ++++++++
>  rust/migration/build.rs                     |  1 +
>  rust/migration/meson.build                  | 53 +++++++++++++++++++++
>  rust/migration/src/bindings.rs              | 48 +++++++++++++++++++
>  rust/migration/src/lib.rs                   |  6 +++
>  rust/{qemu-api => migration}/src/vmstate.rs | 42 +++++++++-------
>  rust/qemu-api/Cargo.toml                    |  1 +
>  rust/qemu-api/meson.build                   | 12 ++---
>  rust/qemu-api/src/bindings.rs               | 21 +-------
>  rust/qemu-api/src/cell.rs                   |  4 +-
>  rust/qemu-api/src/lib.rs                    |  1 -
>  rust/qemu-api/src/prelude.rs                |  2 -
>  rust/qemu-api/src/qdev.rs                   |  3 +-
>  rust/qemu-api/src/qom.rs                    |  2 +-
>  rust/qemu-api/tests/tests.rs                |  2 +-
>  rust/qemu-api/tests/vmstate_tests.rs        |  4 +-
>  29 files changed, 252 insertions(+), 68 deletions(-)
>  create mode 100644 rust/migration/wrapper.h
>  create mode 100644 rust/migration/Cargo.toml
>  create mode 120000 rust/migration/build.rs
>  create mode 100644 rust/migration/meson.build
>  create mode 100644 rust/migration/src/bindings.rs
>  create mode 100644 rust/migration/src/lib.rs
>  rename rust/{qemu-api => migration}/src/vmstate.rs (95%)

...

> diff --git a/rust/migration/wrapper.h b/rust/migration/wrapper.h
> new file mode 100644
> index 00000000000..daf316aed41
> --- /dev/null
> +++ b/rust/migration/wrapper.h
> @@ -0,0 +1,51 @@

nit: this file misses SPDX-License-Identifier

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

Reviewed-by: Zhao Liu <zhao1.liu@intel.com>


