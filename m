Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E6688CAC595
	for <qemu-devel@archiver.kernel.org>; Fri, 12 Sep 2025 08:20:23 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uwz0o-0000k1-Ru; Fri, 12 Sep 2025 04:20:06 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1uwz0m-0000ga-LH
 for qemu-devel@nongnu.org; Fri, 12 Sep 2025 04:20:04 -0400
Received: from mgamail.intel.com ([192.198.163.15])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1uwz0f-00023m-L6
 for qemu-devel@nongnu.org; Fri, 12 Sep 2025 04:20:03 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1757665198; x=1789201198;
 h=date:from:to:cc:subject:message-id:references:
 mime-version:content-transfer-encoding:in-reply-to;
 bh=0ubPEREbi88+asZUUvKAS0MbqLy+Lqj81bVcOQP1LbM=;
 b=NGf3YlFnwTjqg8i6MWCKNbkbS5eonpZ9buHi4bebfP7xwaoMHPYSB3/O
 MWSrQrey/nM15eRXhasDfD0ZaDXgDGyTtwFiPrD1Kevrw2pDMjSCffgry
 JZdmkbvEGuKj8lJgaQiRgjBss7YUMNCZY/kLAwOUaN2VmpUHkr95RhO2Z
 86uBNIcfIxpnJ5c99pArV7i5XVMUqzJsxOzKbHO17kbuGljWy7kcgJJ+l
 h0Z55ewSzGz8Sy+0a0NTYSnFr+5eHIqSB+LDBYSo52RUmMSPwN2gLlaJW
 kwQqK5BLL/irXO5/u2dmgful4La05X43VJEr25XEV8zhOu2POGB/cK2Px Q==;
X-CSE-ConnectionGUID: RBMAfL4CR3OYGqR/lf9HuA==
X-CSE-MsgGUID: zXEbyrvBR5mWiBfAWcZB3Q==
X-IronPort-AV: E=McAfee;i="6800,10657,11550"; a="60116038"
X-IronPort-AV: E=Sophos;i="6.18,259,1751266800"; d="scan'208";a="60116038"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
 by fmvoesa109.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 12 Sep 2025 01:19:54 -0700
X-CSE-ConnectionGUID: xWhZ7pWhTUyV85mzn7KhUg==
X-CSE-MsgGUID: LCbefePRQaK807CbjSKZUA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.18,259,1751266800"; d="scan'208";a="173734397"
Received: from liuzhao-optiplex-7080.sh.intel.com (HELO localhost)
 ([10.239.160.39])
 by orviesa007.jf.intel.com with ESMTP; 12 Sep 2025 01:19:53 -0700
Date: Fri, 12 Sep 2025 16:41:46 +0800
From: Zhao Liu <zhao1.liu@intel.com>
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: qemu-devel@nongnu.org,
 =?iso-8859-1?Q?Marc-Andr=E9?= Lureau <marcandre.lureau@redhat.com>
Subject: Re: [PATCH 25/33] rust: rename qemu_api_macros -> qemu_macros
Message-ID: <aMPcynSYGQxSqCAm@intel.com>
References: <20250908105005.2119297-1-pbonzini@redhat.com>
 <20250908105005.2119297-26-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20250908105005.2119297-26-pbonzini@redhat.com>
Received-SPF: pass client-ip=192.198.163.15; envelope-from=zhao1.liu@intel.com;
 helo=mgamail.intel.com
X-Spam_score_int: -43
X-Spam_score: -4.4
X-Spam_bar: ----
X-Spam_report: (-4.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_MED=-2.3, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

On Mon, Sep 08, 2025 at 12:49:57PM +0200, Paolo Bonzini wrote:
> Date: Mon,  8 Sep 2025 12:49:57 +0200
> From: Paolo Bonzini <pbonzini@redhat.com>
> Subject: [PATCH 25/33] rust: rename qemu_api_macros -> qemu_macros
> X-Mailer: git-send-email 2.51.0
> 
> From: Marc-André Lureau <marcandre.lureau@redhat.com>
> 
> Since "qemu_api" is no longer the unique crate to provide APIs.
> 
> Signed-off-by: Marc-André Lureau <marcandre.lureau@redhat.com>
> Link: https://lore.kernel.org/r/20250827104147.717203-17-marcandre.lureau@redhat.com
> Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
> ---
>  MAINTAINERS                                   |  2 +-
>  rust/Cargo.lock                               | 22 +++++++++----------
>  rust/Cargo.toml                               |  2 +-
>  rust/bits/Cargo.toml                          |  2 +-
>  rust/bits/meson.build                         |  2 +-
>  rust/bits/src/lib.rs                          |  4 ++--
>  rust/chardev/Cargo.toml                       |  2 +-
>  rust/chardev/meson.build                      |  4 ++--
>  rust/chardev/src/chardev.rs                   |  2 +-
>  rust/common/src/opaque.rs                     |  4 ++--
>  rust/hw/char/pl011/Cargo.toml                 |  2 +-
>  rust/hw/char/pl011/meson.build                |  4 ++--
>  rust/hw/char/pl011/src/device.rs              |  4 ++--
>  rust/hw/char/pl011/src/registers.rs           |  2 +-
>  rust/hw/core/Cargo.toml                       |  2 +-
>  rust/hw/core/meson.build                      |  4 ++--
>  rust/hw/core/src/irq.rs                       |  2 +-
>  rust/hw/core/src/qdev.rs                      |  6 ++---
>  rust/hw/core/src/sysbus.rs                    |  2 +-
>  rust/hw/core/tests/tests.rs                   |  4 ++--
>  rust/hw/timer/hpet/Cargo.toml                 |  2 +-
>  rust/hw/timer/hpet/meson.build                |  4 ++--
>  rust/hw/timer/hpet/src/device.rs              |  6 ++---
>  rust/meson.build                              |  2 +-
>  rust/migration/Cargo.toml                     |  2 +-
>  rust/qemu-api/Cargo.toml                      |  2 +-
>  rust/qemu-api/meson.build                     |  4 ++--
>  .../Cargo.toml                                |  2 +-
>  .../meson.build                               | 10 ++++-----
>  .../src/bits.rs                               |  0
>  .../src/lib.rs                                |  0
>  .../src/tests.rs                              |  0
>  rust/qom/Cargo.toml                           |  2 +-
>  rust/qom/meson.build                          |  4 ++--
>  rust/qom/src/qom.rs                           |  4 ++--
>  rust/system/Cargo.toml                        |  2 +-
>  rust/system/meson.build                       |  4 ++--
>  rust/system/src/memory.rs                     |  2 +-
>  rust/util/Cargo.toml                          |  2 +-
>  rust/util/meson.build                         |  2 +-
>  rust/util/src/timer.rs                        |  4 ++--
>  41 files changed, 69 insertions(+), 69 deletions(-)
>  rename rust/{qemu-api-macros => qemu-macros}/Cargo.toml (94%)
>  rename rust/{qemu-api-macros => qemu-macros}/meson.build (63%)
>  rename rust/{qemu-api-macros => qemu-macros}/src/bits.rs (100%)
>  rename rust/{qemu-api-macros => qemu-macros}/src/lib.rs (100%)
>  rename rust/{qemu-api-macros => qemu-macros}/src/tests.rs (100%)

Reviewed-by: Zhao Liu <zhao1.liu@intel.com>


