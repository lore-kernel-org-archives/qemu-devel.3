Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 556D0C021BB
	for <qemu-devel@archiver.kernel.org>; Mon, 24 Feb 2025 14:27:25 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tmZPt-0002mS-MF; Mon, 24 Feb 2025 09:26:41 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1tmZPq-0002lj-W9; Mon, 24 Feb 2025 09:26:39 -0500
Received: from mgamail.intel.com ([198.175.65.15])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1tmZPp-00057R-6i; Mon, 24 Feb 2025 09:26:38 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1740407197; x=1771943197;
 h=date:from:to:cc:subject:message-id:references:
 mime-version:in-reply-to;
 bh=M2hMqIx2O/FVqVzobD2PWmi+jxZJbgUVouYOZ+iLYm0=;
 b=XovN96e7gWCf0wix+IfjPbPM0aIl3hQLTT7DGYgvJqIXOwwvQNXSHvNy
 ZpHnEf91kLe7v0rSJ93GMViItlxEub9+79IIlZft2eoYqKRABKfvOTQme
 ni45S2UFRcIm7ZnAPCw2guj+tdav5a9wRYTnx/yYHJQsrNslcqkMs4Yxd
 XQn/bekn3ysAaBxG0q1GeeBt7fh2/8MDQW+1UdWtKFWQG5v6druCjH6M0
 5sGNk4glP87JOMI+3LQX2qDaZqp8vlkSq8pV8vZgGgLKOiG0yCjrWqbv0
 S9FnN9zqWE5CmEh2AckcYlO5ihEqi7ERbaQg+wt71gKECualy2SysV8yw w==;
X-CSE-ConnectionGUID: ReYfWgnaQh2rByAiJiePTg==
X-CSE-MsgGUID: w8EtwFVxTEShNb4Qurx/qw==
X-IronPort-AV: E=McAfee;i="6700,10204,11355"; a="44816395"
X-IronPort-AV: E=Sophos;i="6.13,309,1732608000"; d="scan'208";a="44816395"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
 by orvoesa107.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 24 Feb 2025 06:26:35 -0800
X-CSE-ConnectionGUID: +Imv1xRzRX28VbGWArQRKg==
X-CSE-MsgGUID: r+kryvleT7ueGqE4y9Zxcw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,224,1728975600"; d="scan'208";a="116978761"
Received: from liuzhao-optiplex-7080.sh.intel.com (HELO localhost)
 ([10.239.160.39])
 by orviesa008.jf.intel.com with ESMTP; 24 Feb 2025 06:26:34 -0800
Date: Mon, 24 Feb 2025 22:46:10 +0800
From: Zhao Liu <zhao1.liu@intel.com>
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: qemu-devel@nongnu.org, qemu-rust@nongnu.org
Subject: Re: [PATCH 02/15] rust: add SysBusDeviceImpl
Message-ID: <Z7yGMo5rqJ5FTP8q@intel.com>
References: <20250221170342.63591-1-pbonzini@redhat.com>
 <20250221170342.63591-3-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250221170342.63591-3-pbonzini@redhat.com>
Received-SPF: pass client-ip=198.175.65.15; envelope-from=zhao1.liu@intel.com;
 helo=mgamail.intel.com
X-Spam_score_int: -47
X-Spam_score: -4.8
X-Spam_bar: ----
X-Spam_report: (-4.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.442,
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

On Fri, Feb 21, 2025 at 06:03:29PM +0100, Paolo Bonzini wrote:
> Date: Fri, 21 Feb 2025 18:03:29 +0100
> From: Paolo Bonzini <pbonzini@redhat.com>
> Subject: [PATCH 02/15] rust: add SysBusDeviceImpl
> X-Mailer: git-send-email 2.48.1
> 
> The only function, right now, is to ensure that anything with a
> SysBusDeviceClass class is a SysBusDevice.
> 
> Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
> ---
>  rust/hw/char/pl011/src/device.rs | 5 ++++-
>  rust/hw/timer/hpet/src/hpet.rs   | 4 +++-
>  rust/qemu-api/src/sysbus.rs      | 8 +++++---
>  3 files changed, 12 insertions(+), 5 deletions(-)>

Reviewed-by: Zhao Liu <zhao1.liu@intel.com>


