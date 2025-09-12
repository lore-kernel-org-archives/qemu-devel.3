Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0ACA5CA101F
	for <qemu-devel@archiver.kernel.org>; Fri, 12 Sep 2025 08:20:06 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uwz0I-0000Z2-7a; Fri, 12 Sep 2025 04:19:34 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1uwz0E-0000YS-Nf
 for qemu-devel@nongnu.org; Fri, 12 Sep 2025 04:19:32 -0400
Received: from mgamail.intel.com ([192.198.163.17])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1uwz05-00021O-Dq
 for qemu-devel@nongnu.org; Fri, 12 Sep 2025 04:19:29 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1757665161; x=1789201161;
 h=date:from:to:cc:subject:message-id:references:
 mime-version:content-transfer-encoding:in-reply-to;
 bh=F9dwolXm7ev4WKYI5/cnJl2moTLGP6uLtxJ+jGXk5fI=;
 b=fblBE2nOjzelsIle2hcpDy5nvJfIxu8cTtUlcLmGzIgI3s+ESVi21ktN
 XzTuQAo08bUbZ5oN9wbNBr6D+/kA1sqsItZsuF9wSPyRh6mz0ykuJsn4v
 MGtU9l/emYhhTlgnVO2vcQPJ7h2iEUcoiW6sufZ2ck2ogVNZjEO06ouwB
 NuGpCJqNcZIyeqkJjx7eHplJHNwonm+AunheSaYPpYcNoQKD6qJ4jlIka
 qxuNbvR8d46HhQ5DP42BPvh4M76FG0nzlKgNO444+OGe1mAXSph29fLEb
 +KSJq6TruX/8Ywvby2lnbVzuA7iFuGrlrG4AaKg84lLROu+uxMzAM336+ w==;
X-CSE-ConnectionGUID: d9L3XVMvR2m+vP5J5nR7DQ==
X-CSE-MsgGUID: omzO1+KmQ320A1ezwOf56A==
X-IronPort-AV: E=McAfee;i="6800,10657,11550"; a="59944306"
X-IronPort-AV: E=Sophos;i="6.18,259,1751266800"; d="scan'208";a="59944306"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
 by fmvoesa111.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 12 Sep 2025 01:19:18 -0700
X-CSE-ConnectionGUID: SsK2h4NjQGGjwhmUh7loZA==
X-CSE-MsgGUID: P62uAlEgTiSvZ8rGFDG+Eg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.18,259,1751266800"; d="scan'208";a="211063791"
Received: from liuzhao-optiplex-7080.sh.intel.com (HELO localhost)
 ([10.239.160.39])
 by orviesa001.jf.intel.com with ESMTP; 12 Sep 2025 01:19:17 -0700
Date: Fri, 12 Sep 2025 16:41:09 +0800
From: Zhao Liu <zhao1.liu@intel.com>
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: qemu-devel@nongnu.org,
 =?iso-8859-1?Q?Marc-Andr=E9?= Lureau <marcandre.lureau@redhat.com>
Subject: Re: [PATCH 24/33] rust: split "hwcore" crate
Message-ID: <aMPcpQYduMcftJjG@intel.com>
References: <20250908105005.2119297-1-pbonzini@redhat.com>
 <20250908105005.2119297-25-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20250908105005.2119297-25-pbonzini@redhat.com>
Received-SPF: pass client-ip=192.198.163.17; envelope-from=zhao1.liu@intel.com;
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

On Mon, Sep 08, 2025 at 12:49:56PM +0200, Paolo Bonzini wrote:
> Date: Mon,  8 Sep 2025 12:49:56 +0200
> From: Paolo Bonzini <pbonzini@redhat.com>
> Subject: [PATCH 24/33] rust: split "hwcore" crate
> X-Mailer: git-send-email 2.51.0
> 
> From: Marc-André Lureau <marcandre.lureau@redhat.com>
> 
> Signed-off-by: Marc-André Lureau <marcandre.lureau@redhat.com>
> Link: https://lore.kernel.org/r/20250827104147.717203-16-marcandre.lureau@redhat.com
> Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
> ---
>  MAINTAINERS                               |  1 +
>  rust/hw/core/wrapper.h                    | 32 +++++++++
>  rust/qemu-api/wrapper.h                   |  6 --
>  rust/Cargo.lock                           | 17 +++++
>  rust/Cargo.toml                           |  1 +
>  rust/bindings/src/lib.rs                  | 64 ++++++++++++++++++
>  rust/hw/char/pl011/Cargo.toml             |  1 +
>  rust/hw/char/pl011/meson.build            |  1 +
>  rust/hw/char/pl011/src/device.rs          | 10 ++-
>  rust/hw/core/Cargo.toml                   | 26 ++++++++
>  rust/hw/core/build.rs                     |  1 +
>  rust/hw/core/meson.build                  | 80 +++++++++++++++++++++++
>  rust/hw/core/src/bindings.rs              | 41 ++++++++++++
>  rust/{qemu-api => hw/core}/src/irq.rs     |  0
>  rust/hw/core/src/lib.rs                   | 14 ++++
>  rust/{qemu-api => hw/core}/src/qdev.rs    |  2 +-
>  rust/{qemu-api => hw/core}/src/sysbus.rs  |  0
>  rust/{qemu-api => hw/core}/tests/tests.rs |  7 +-
>  rust/hw/timer/hpet/Cargo.toml             |  1 +
>  rust/hw/timer/hpet/meson.build            |  1 +
>  rust/hw/timer/hpet/src/device.rs          | 26 ++++----
>  rust/meson.build                          |  1 +
>  rust/qemu-api-macros/src/lib.rs           | 10 +--
>  rust/qemu-api-macros/src/tests.rs         | 20 +++---
>  rust/qemu-api/Cargo.toml                  |  1 +
>  rust/qemu-api/meson.build                 | 17 +----
>  rust/qemu-api/src/bindings.rs             | 10 ---
>  rust/qemu-api/src/lib.rs                  |  4 --
>  rust/qemu-api/src/prelude.rs              |  4 --
>  29 files changed, 318 insertions(+), 81 deletions(-)
>  create mode 100644 rust/hw/core/wrapper.h
>  create mode 100644 rust/bindings/src/lib.rs
>  create mode 100644 rust/hw/core/Cargo.toml
>  create mode 120000 rust/hw/core/build.rs
>  create mode 100644 rust/hw/core/meson.build
>  create mode 100644 rust/hw/core/src/bindings.rs
>  rename rust/{qemu-api => hw/core}/src/irq.rs (100%)
>  create mode 100644 rust/hw/core/src/lib.rs
>  rename rust/{qemu-api => hw/core}/src/qdev.rs (99%)
>  rename rust/{qemu-api => hw/core}/src/sysbus.rs (100%)
>  rename rust/{qemu-api => hw/core}/tests/tests.rs (97%)

Reviewed-by: Zhao Liu <zhao1.liu@intel.com>


