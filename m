Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B5731CA101F
	for <qemu-devel@archiver.kernel.org>; Fri, 12 Sep 2025 08:42:14 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uwzLv-0003F9-D3; Fri, 12 Sep 2025 04:41:56 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1uwzLt-0003DE-Nr
 for qemu-devel@nongnu.org; Fri, 12 Sep 2025 04:41:53 -0400
Received: from mgamail.intel.com ([192.198.163.10])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1uwzLm-0005ng-Hk
 for qemu-devel@nongnu.org; Fri, 12 Sep 2025 04:41:53 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1757666506; x=1789202506;
 h=date:from:to:cc:subject:message-id:references:
 mime-version:content-transfer-encoding:in-reply-to;
 bh=pK9/RmQ45I/orVNIrfXiuX7JcAnEUbP22pfAL6gHrR8=;
 b=FW9R8kOgiHYU2z5i5vZS4p4pchIf+f5xrc3AJe/OQ53GKh3I3G7IZYhy
 3d4Vy4TJt2Uo40h2Y5bSoljTnPiP5vghkLKbwmnFNDW1wbcVLKteIA0z6
 6ggQRH7OcAxeaQz1xIvQDItFL2gxlNGI9m5lyqBoUm6va6heYIH9rSCBN
 6dGWQxvDjS7olaJQs/7jeWsHdG1Yb3TF3q5tCgorApLpJMRBjlDX2NADF
 2c+XRlcxd3e7CZtut5YFGQQ4I5DYSiUga6/h/dUw5Lh6yXGGo72UIugvL
 +krSNkHf3Al0DaDEQbr65h8fZhZ8V7Ic42XU+uyO+AGD188PBNnWERh+6 g==;
X-CSE-ConnectionGUID: O7M7ORnkSVenUS1Mj+Z1rg==
X-CSE-MsgGUID: 9FTqqyHMSDSW0TIEAU6g5w==
X-IronPort-AV: E=McAfee;i="6800,10657,11550"; a="71383702"
X-IronPort-AV: E=Sophos;i="6.18,259,1751266800"; d="scan'208";a="71383702"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
 by fmvoesa104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 12 Sep 2025 01:41:43 -0700
X-CSE-ConnectionGUID: LupIMWjnQnqGwbIpE+Rxbw==
X-CSE-MsgGUID: 8bodE9PqSnORnLSJdKeK7w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.18,259,1751266800"; d="scan'208";a="173825325"
Received: from liuzhao-optiplex-7080.sh.intel.com (HELO localhost)
 ([10.239.160.39])
 by fmviesa006.fm.intel.com with ESMTP; 12 Sep 2025 01:41:42 -0700
Date: Fri, 12 Sep 2025 17:03:35 +0800
From: Zhao Liu <zhao1.liu@intel.com>
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: qemu-devel@nongnu.org,
 =?iso-8859-1?Q?Marc-Andr=E9?= Lureau <marcandre.lureau@redhat.com>
Subject: Re: [PATCH 30/33] rust: re-export qemu macros from common/qom/hwcore
Message-ID: <aMPh55+U45gsNK6G@intel.com>
References: <20250908105005.2119297-1-pbonzini@redhat.com>
 <20250908105005.2119297-31-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20250908105005.2119297-31-pbonzini@redhat.com>
Received-SPF: pass client-ip=192.198.163.10; envelope-from=zhao1.liu@intel.com;
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

On Mon, Sep 08, 2025 at 12:50:02PM +0200, Paolo Bonzini wrote:
> Date: Mon,  8 Sep 2025 12:50:02 +0200
> From: Paolo Bonzini <pbonzini@redhat.com>
> Subject: [PATCH 30/33] rust: re-export qemu macros from common/qom/hwcore
> X-Mailer: git-send-email 2.51.0
> 
> From: Marc-André Lureau <marcandre.lureau@redhat.com>
> 
> This is just a bit nicer.
> 
> Signed-off-by: Marc-André Lureau <marcandre.lureau@redhat.com>
> Link: https://lore.kernel.org/r/20250827104147.717203-22-marcandre.lureau@redhat.com
> Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
> ---
>  docs/devel/rust.rst                 | 2 +-
>  rust/Cargo.lock                     | 8 +-------
>  rust/chardev/Cargo.toml             | 1 -
>  rust/chardev/meson.build            | 2 +-
>  rust/chardev/src/chardev.rs         | 2 +-
>  rust/common/Cargo.toml              | 1 +
>  rust/common/meson.build             | 2 +-
>  rust/common/src/lib.rs              | 2 ++
>  rust/common/src/opaque.rs           | 4 +---
>  rust/hw/char/pl011/Cargo.toml       | 1 -
>  rust/hw/char/pl011/meson.build      | 1 -
>  rust/hw/char/pl011/src/device.rs    | 4 ++--
>  rust/hw/char/pl011/src/registers.rs | 2 +-
>  rust/hw/core/Cargo.toml             | 2 +-
>  rust/hw/core/meson.build            | 2 +-
>  rust/hw/core/src/irq.rs             | 2 +-
>  rust/hw/core/src/lib.rs             | 1 +
>  rust/hw/core/src/qdev.rs            | 4 ++--
>  rust/hw/core/src/sysbus.rs          | 2 +-
>  rust/hw/core/tests/tests.rs         | 4 ++--
>  rust/hw/timer/hpet/Cargo.toml       | 1 -
>  rust/hw/timer/hpet/meson.build      | 1 -
>  rust/hw/timer/hpet/src/device.rs    | 6 +++---
>  rust/meson.build                    | 3 ++-
>  rust/migration/Cargo.toml           | 1 -
>  rust/qom/src/lib.rs                 | 2 ++
>  rust/qom/src/qom.rs                 | 4 ++--
>  rust/system/Cargo.toml              | 1 -
>  rust/system/meson.build             | 2 +-
>  rust/system/src/memory.rs           | 2 +-
>  rust/tests/Cargo.toml               | 1 -
>  rust/util/Cargo.toml                | 1 -
>  rust/util/meson.build               | 2 +-
>  rust/util/src/timer.rs              | 4 ++--
>  34 files changed, 35 insertions(+), 45 deletions(-)

Good cleanup!

Reviewed-by: Zhao Liu <zhao1.liu@intel.com>


