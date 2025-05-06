Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 53516C3ABAC
	for <qemu-devel@archiver.kernel.org>; Tue,  6 May 2025 08:12:47 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uCDPO-00031d-09; Tue, 06 May 2025 04:12:10 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1uCDPL-0002xV-Fg; Tue, 06 May 2025 04:12:07 -0400
Received: from mgamail.intel.com ([192.198.163.7])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1uCDPG-0002NI-Q4; Tue, 06 May 2025 04:12:07 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1746519123; x=1778055123;
 h=date:from:to:cc:subject:message-id:references:
 mime-version:in-reply-to;
 bh=Yd1/abJpO3rjSefg7BT4LMzLo4Y1N46ZWXlD7sWCN9Y=;
 b=lfxHnuxN3dTuYoWZEnyq9gDqd8/3PH0eYd4MbmKh4g/w7v5Mo+q0UPD3
 dpNskWKRYLcs06K/YfPDT3Cq3MC7GEDjgoojW8aFu53iobdlfNiH/Vxpz
 YF8IaF8fk966b3ya+kITtI6bLM0iaWTpF9AKj1uRai7UwngTCkAKDHBdJ
 72zEy/VX41HMoxnsNXg3cb2PR2Kum7QR4odkV3SmDiaeugkyk3eh38C5b
 FtVU9Db0adKBV/nO41amJBpITTu9bdH29OHVM/6D8vO0Z/DSRwgOTrUPE
 bqRRQMmPoCalKPPGvB0QkNtcfbJPMRz2OWN7q9n4uKH3mVj7c6R2Weysr w==;
X-CSE-ConnectionGUID: lZZSCY2WT+KwoT067E8dWQ==
X-CSE-MsgGUID: qpKVUMUtR1CJcq+Xlcsyzw==
X-IronPort-AV: E=McAfee;i="6700,10204,11424"; a="73571275"
X-IronPort-AV: E=Sophos;i="6.15,265,1739865600"; d="scan'208";a="73571275"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
 by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 06 May 2025 01:11:58 -0700
X-CSE-ConnectionGUID: s+6Cp41rQRiBLEvB85E8vA==
X-CSE-MsgGUID: X2DUpjw+Q2Ka3bUyXwqjkw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,265,1739865600"; d="scan'208";a="158794703"
Received: from liuzhao-optiplex-7080.sh.intel.com (HELO localhost)
 ([10.239.160.39])
 by fmviesa002.fm.intel.com with ESMTP; 06 May 2025 01:11:57 -0700
Date: Tue, 6 May 2025 16:32:58 +0800
From: Zhao Liu <zhao1.liu@intel.com>
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: qemu-devel@nongnu.org, manos.pitsidianakis@linaro.org, qemu-rust@nongnu.org
Subject: Re: [PATCH 09/11] rust: remove offset_of replacement
Message-ID: <aBnJOiX5o6Cl0KNB@intel.com>
References: <20250505090438.24992-1-pbonzini@redhat.com>
 <20250505090438.24992-10-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250505090438.24992-10-pbonzini@redhat.com>
Received-SPF: pass client-ip=192.198.163.7; envelope-from=zhao1.liu@intel.com;
 helo=mgamail.intel.com
X-Spam_score_int: -57
X-Spam_score: -5.8
X-Spam_bar: -----
X-Spam_report: (-5.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.414,
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

On Mon, May 05, 2025 at 11:04:34AM +0200, Paolo Bonzini wrote:
> Date: Mon,  5 May 2025 11:04:34 +0200
> From: Paolo Bonzini <pbonzini@redhat.com>
> Subject: [PATCH 09/11] rust: remove offset_of replacement
> X-Mailer: git-send-email 2.49.0
> 
> ---
>  docs/devel/rust.rst                  |   6 -
>  rust/Cargo.lock                      |   1 -
>  rust/Cargo.toml                      |   2 +-
>  rust/hw/char/pl011/src/device.rs     |   4 +-
>  rust/hw/timer/hpet/src/hpet.rs       |   4 +-
>  rust/qemu-api-macros/src/lib.rs      |  29 +----
>  rust/qemu-api/Cargo.toml             |   3 -
>  rust/qemu-api/build.rs               |   7 --
>  rust/qemu-api/meson.build            |   4 -
>  rust/qemu-api/src/lib.rs             |   4 -
>  rust/qemu-api/src/offset_of.rs       | 168 ---------------------------
>  rust/qemu-api/src/qdev.rs            |   6 +-
>  rust/qemu-api/src/vmstate.rs         |  10 +-
>  rust/qemu-api/tests/tests.rs         |   2 -
>  rust/qemu-api/tests/vmstate_tests.rs |   5 +-
>  15 files changed, 16 insertions(+), 239 deletions(-)
>  delete mode 100644 rust/qemu-api/src/offset_of.rs

Reviewed-by: Zhao Liu <zhao1.liu@intel.com>


