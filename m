Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DD3F3CA101F
	for <qemu-devel@archiver.kernel.org>; Fri, 12 Sep 2025 07:40:03 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uwyN0-000313-8N; Fri, 12 Sep 2025 03:38:58 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1uwyMy-00030j-2v
 for qemu-devel@nongnu.org; Fri, 12 Sep 2025 03:38:56 -0400
Received: from mgamail.intel.com ([198.175.65.14])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1uwyMt-0003KA-R1
 for qemu-devel@nongnu.org; Fri, 12 Sep 2025 03:38:55 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1757662732; x=1789198732;
 h=date:from:to:cc:subject:message-id:references:
 mime-version:content-transfer-encoding:in-reply-to;
 bh=fMRMqqULwu9RxptKoTgJ1FhKAD0OlWTG55BCL7bpncE=;
 b=ktsVSmz8GN3pxG1fX3Qknly3n6SbLw3LBOrSq6Dwd2yPm0N1yr3hQNmO
 8mrMPkHQuJAxAH3ARYsj1CTjxQJIjtjanD9U+B+oXYG+TUld4laj4aoZg
 owMiw+FaltIgOv46U3DxSmMi11s0BDW7b0WGwasi7WvlevNCvsO3bj1qa
 uMIQcgzgomPsdKfHAywCW7sZzePfS8/6l/948l2SBNkd4e5DzWh3woWj7
 WhEy93x6wrjtjJG0z4GM9Fx2tTuzaSNAu13eWO2iI4HqyYdvqKBk/JOfA
 l0Z0HhLnONEFmdkQF/+q2VpuvbF+eFqbzItrhCyzt1GxZpnMdy53/MaBG g==;
X-CSE-ConnectionGUID: V2os9WvoStaaFrIBo8D0vw==
X-CSE-MsgGUID: i2g8d+xBSCihF3HOzIJ5Sg==
X-IronPort-AV: E=McAfee;i="6800,10657,11531"; a="63828185"
X-IronPort-AV: E=Sophos;i="6.17,312,1747724400"; d="scan'208";a="63828185"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
 by orvoesa106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 12 Sep 2025 00:38:47 -0700
X-CSE-ConnectionGUID: AUIatZJaQL2ydH3PY3enJA==
X-CSE-MsgGUID: bEZxZdP4TlaAxEMRR+lp8A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.18,259,1751266800"; d="scan'208";a="179123342"
Received: from liuzhao-optiplex-7080.sh.intel.com (HELO localhost)
 ([10.239.160.39])
 by fmviesa004.fm.intel.com with ESMTP; 12 Sep 2025 00:38:46 -0700
Date: Fri, 12 Sep 2025 16:00:38 +0800
From: Zhao Liu <zhao1.liu@intel.com>
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: qemu-devel@nongnu.org,
 =?iso-8859-1?Q?Marc-Andr=E9?= Lureau <marcandre.lureau@redhat.com>
Subject: Re: [PATCH 18/33] rust: split "util" crate
Message-ID: <aMPTJvgE6NELtvCq@intel.com>
References: <20250908105005.2119297-1-pbonzini@redhat.com>
 <20250908105005.2119297-19-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20250908105005.2119297-19-pbonzini@redhat.com>
Received-SPF: pass client-ip=198.175.65.14; envelope-from=zhao1.liu@intel.com;
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

On Mon, Sep 08, 2025 at 12:49:50PM +0200, Paolo Bonzini wrote:
> Date: Mon,  8 Sep 2025 12:49:50 +0200
> From: Paolo Bonzini <pbonzini@redhat.com>
> Subject: [PATCH 18/33] rust: split "util" crate
> X-Mailer: git-send-email 2.51.0
> 
> From: Marc-André Lureau <marcandre.lureau@redhat.com>
> 
> Signed-off-by: Marc-André Lureau <marcandre.lureau@redhat.com>
> Link: https://lore.kernel.org/r/20250827104147.717203-7-marcandre.lureau@redhat.com
> Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
> ---
>  MAINTAINERS                           |  1 +
>  rust/qemu-api/wrapper.h               |  6 ---
>  rust/util/wrapper.h                   | 32 ++++++++++++++++
>  rust/Cargo.lock                       | 17 +++++++--
>  rust/Cargo.toml                       |  5 +--
>  rust/hw/char/pl011/Cargo.toml         |  1 +
>  rust/hw/char/pl011/meson.build        |  1 +
>  rust/hw/char/pl011/src/device.rs      |  7 ++--
>  rust/hw/timer/hpet/Cargo.toml         |  1 +
>  rust/hw/timer/hpet/meson.build        |  1 +
>  rust/hw/timer/hpet/src/device.rs      |  6 +--
>  rust/meson.build                      |  1 +
>  rust/qemu-api-macros/src/lib.rs       |  2 +-
>  rust/qemu-api-macros/src/tests.rs     |  2 +-
>  rust/qemu-api/Cargo.toml              |  4 +-
>  rust/qemu-api/build.rs                | 50 +-----------------------
>  rust/qemu-api/meson.build             | 14 ++-----
>  rust/qemu-api/src/bindings.rs         |  1 +
>  rust/qemu-api/src/lib.rs              |  6 ---
>  rust/qemu-api/src/prelude.rs          |  2 -
>  rust/qemu-api/src/qdev.rs             |  4 +-
>  rust/qemu-api/src/sysbus.rs           |  2 +-
>  rust/qemu-api/src/vmstate.rs          |  2 +-
>  rust/qemu-api/tests/tests.rs          |  2 +-
>  rust/util/Cargo.toml                  | 23 +++++++++++
>  rust/util/build.rs                    | 49 ++++++++++++++++++++++++
>  rust/util/meson.build                 | 55 +++++++++++++++++++++++++++
>  rust/util/src/bindings.rs             | 25 ++++++++++++
>  rust/{qemu-api => util}/src/error.rs  |  5 +--
>  rust/util/src/lib.rs                  |  9 +++++
>  rust/{qemu-api => util}/src/log.rs    | 12 +++---
>  rust/{qemu-api => util}/src/module.rs |  2 +-
>  rust/{qemu-api => util}/src/timer.rs  |  0
>  33 files changed, 243 insertions(+), 107 deletions(-)
>  create mode 100644 rust/util/wrapper.h
>  mode change 100644 => 120000 rust/qemu-api/build.rs
>  create mode 100644 rust/util/Cargo.toml
>  create mode 100644 rust/util/build.rs
>  create mode 100644 rust/util/meson.build
>  create mode 100644 rust/util/src/bindings.rs
>  rename rust/{qemu-api => util}/src/error.rs (98%)
>  create mode 100644 rust/util/src/lib.rs
>  rename rust/{qemu-api => util}/src/log.rs (93%)
>  rename rust/{qemu-api => util}/src/module.rs (97%)
>  rename rust/{qemu-api => util}/src/timer.rs (100%)

Reviewed-by: Zhao Liu <zhao1.liu@intel.com>


