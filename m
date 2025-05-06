Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DD848C3ABAC
	for <qemu-devel@archiver.kernel.org>; Tue,  6 May 2025 08:14:17 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uCDR7-0006sI-Tj; Tue, 06 May 2025 04:13:57 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1uCDR4-0006mY-3I; Tue, 06 May 2025 04:13:54 -0400
Received: from mgamail.intel.com ([192.198.163.9])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1uCDR2-0002Vp-BJ; Tue, 06 May 2025 04:13:53 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1746519232; x=1778055232;
 h=date:from:to:cc:subject:message-id:references:
 mime-version:in-reply-to;
 bh=dE7zz7MA21loKwGBXqqSeiRszbbsWdpQQdjUHiCm7r0=;
 b=l7+/tgiXdLmaAt+4CWPInYfHkUTxsITvbIiNTgEp9a//Yxa2AdaShn+I
 eTNE3osqEKpUdpCSo1NO23+h9vz+xPAiDno/iuwLDQyStC0H7d87fkQrx
 wTy4nB9kaI8lXXz3A7AHpxSdAErALtSY1w/DOjluoh7gHWQ7KDFvxLUH1
 iWqlcanJbjCJ8fuBnePMn0XriXUcB2fIDPvUw/iJMWNGLfU+Moqdovg+D
 2680mRzFoEe1/ukrPp+LVf8S4jfDdqHs0e5LCsZBd/W/0CJlbXYAAZLQC
 aptB3sOcm67UXaLjzxtjd5xZ/47nierQE2aI/QIOafrhof4Y3oI4r0/09 w==;
X-CSE-ConnectionGUID: +m5NfzSMR/6CDCr+gqcO0Q==
X-CSE-MsgGUID: e3OOSahMQGiCvnbPRda4og==
X-IronPort-AV: E=McAfee;i="6700,10204,11424"; a="58833466"
X-IronPort-AV: E=Sophos;i="6.15,265,1739865600"; d="scan'208";a="58833466"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
 by fmvoesa103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 06 May 2025 01:13:50 -0700
X-CSE-ConnectionGUID: WA7vYq6BQOS1xjUs/t7EVw==
X-CSE-MsgGUID: nC88bKa2RSul+U+ZXIP3RA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,265,1739865600"; d="scan'208";a="135533716"
Received: from liuzhao-optiplex-7080.sh.intel.com (HELO localhost)
 ([10.239.160.39])
 by fmviesa007.fm.intel.com with ESMTP; 06 May 2025 01:13:48 -0700
Date: Tue, 6 May 2025 16:34:49 +0800
From: Zhao Liu <zhao1.liu@intel.com>
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: qemu-devel@nongnu.org, manos.pitsidianakis@linaro.org, qemu-rust@nongnu.org
Subject: Re: [PATCH 10/11] rust: replace c_str! with c"" literals
Message-ID: <aBnJqXXCjMZVPLRa@intel.com>
References: <20250505090438.24992-1-pbonzini@redhat.com>
 <20250505090438.24992-11-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250505090438.24992-11-pbonzini@redhat.com>
Received-SPF: pass client-ip=192.198.163.9; envelope-from=zhao1.liu@intel.com;
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

On Mon, May 05, 2025 at 11:04:35AM +0200, Paolo Bonzini wrote:
> Date: Mon,  5 May 2025 11:04:35 +0200
> From: Paolo Bonzini <pbonzini@redhat.com>
> Subject: [PATCH 10/11] rust: replace c_str! with c"" literals
> X-Mailer: git-send-email 2.49.0
> 
> Reviewed-by: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>
> Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
> ---
>  docs/devel/rust.rst                    |  6 +--
>  rust/hw/char/pl011/src/device_class.rs | 11 +++--
>  rust/hw/char/pl011/src/lib.rs          |  6 +--
>  rust/hw/timer/hpet/src/hpet.rs         | 19 ++++----
>  rust/hw/timer/hpet/src/lib.rs          |  4 +-
>  rust/qemu-api/meson.build              |  1 -
>  rust/qemu-api/src/c_str.rs             | 61 --------------------------
>  rust/qemu-api/src/cell.rs              |  4 +-
>  rust/qemu-api/src/lib.rs               |  1 -
>  rust/qemu-api/src/vmstate.rs           |  2 +-
>  rust/qemu-api/tests/tests.rs           |  9 ++--
>  rust/qemu-api/tests/vmstate_tests.rs   | 15 +++----
>  12 files changed, 32 insertions(+), 107 deletions(-)
>  delete mode 100644 rust/qemu-api/src/c_str.rs

Reviewed-by: Zhao Liu <zhao1.liu@intel.com>


