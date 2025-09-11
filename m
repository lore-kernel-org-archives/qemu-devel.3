Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0DAB8CA101F
	for <qemu-devel@archiver.kernel.org>; Thu, 11 Sep 2025 02:56:15 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uwXTZ-0003PB-Do; Wed, 10 Sep 2025 22:55:57 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1uwXTX-0003OO-HF
 for qemu-devel@nongnu.org; Wed, 10 Sep 2025 22:55:55 -0400
Received: from mgamail.intel.com ([198.175.65.11])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1uwXTU-00017C-RO
 for qemu-devel@nongnu.org; Wed, 10 Sep 2025 22:55:54 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1757559353; x=1789095353;
 h=date:from:to:cc:subject:message-id:references:
 mime-version:in-reply-to;
 bh=rWpAln5448NTyCPYDhCqvibameAA4XtkFo1WVT5EAdo=;
 b=RSe4nh2WHju3TAkKV/9jJW/j6RLZkSFlUxBSUeAtIcnCa7Rbky8xq/S8
 oxcVdw5TT4mqq5HUsOen8PlPwiaGiT6denyM9DCRWzjTzdn44RNoig2g1
 U2MaWOZqLXsMwX7IgvwiHdttNrFKm9PGm18EJ8qs+iDTTn6ATold1jpeG
 599w63aI5FxcWPekab5QAC/i+Ses58R8zEVhwPP62eaR16NQ4xyZxfYP4
 o7yH+RMP4bDdKCg7z3CI1BJbYIjGnaHKXHEEDgoqd6+H6ICI5tkx0A3Un
 4udTuHBfmTMWa0bEKCY3HaSuf21puNx46eGyI/32e7gtmG6JtfTAcCTbO g==;
X-CSE-ConnectionGUID: fpVV8GCUTnuPXPzI3MSI0Q==
X-CSE-MsgGUID: ewKIc8VqTwyvqtNWuaYy1w==
X-IronPort-AV: E=McAfee;i="6800,10657,11549"; a="70137924"
X-IronPort-AV: E=Sophos;i="6.18,256,1751266800"; d="scan'208";a="70137924"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
 by orvoesa103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 10 Sep 2025 19:55:51 -0700
X-CSE-ConnectionGUID: Vg4rFbkBQFmswGfTc9G8/w==
X-CSE-MsgGUID: 2GK6aAh1RuKOPZABOfv1JA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.18,256,1751266800"; d="scan'208";a="173466700"
Received: from liuzhao-optiplex-7080.sh.intel.com (HELO localhost)
 ([10.239.160.39])
 by fmviesa006.fm.intel.com with ESMTP; 10 Sep 2025 19:55:49 -0700
Date: Thu, 11 Sep 2025 11:17:42 +0800
From: Zhao Liu <zhao1.liu@intel.com>
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: qemu-devel@nongnu.org
Subject: Re: [PATCH 02/33] configure: bump Meson to 1.9.0 for use with Rust
Message-ID: <aMI/Vry9FIlEUgBR@intel.com>
References: <20250908105005.2119297-1-pbonzini@redhat.com>
 <20250908105005.2119297-3-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250908105005.2119297-3-pbonzini@redhat.com>
Received-SPF: pass client-ip=198.175.65.11; envelope-from=zhao1.liu@intel.com;
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

On Mon, Sep 08, 2025 at 12:49:34PM +0200, Paolo Bonzini wrote:
> Date: Mon,  8 Sep 2025 12:49:34 +0200
> From: Paolo Bonzini <pbonzini@redhat.com>
> Subject: [PATCH 02/33] configure: bump Meson to 1.9.0 for use with Rust
> X-Mailer: git-send-email 2.51.0
> 
> Meson 1.9.0 provides mixed linking of Rust and C objects.  As a side effect,
> this also allows adding dependencies with "sources: ..." files to Rust crates
> that use structured_sources().
> 
> It can also clean up up the meson.build files for Rust noticeably, but due
> to an issue with doctests (see https://github.com/mesonbuild/meson/pull/14973)
> that will have to wait for 1.9.1.
> 
> Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
> ---
>  configure                                  |   4 ++--
>  python/scripts/vendor.py                   |   4 ++--
>  python/wheels/meson-1.8.1-py3-none-any.whl | Bin 1013001 -> 0 bytes
>  python/wheels/meson-1.9.0-py3-none-any.whl | Bin 0 -> 1029634 bytes
>  pythondeps.toml                            |   4 ++--
>  5 files changed, 6 insertions(+), 6 deletions(-)
>  delete mode 100644 python/wheels/meson-1.8.1-py3-none-any.whl
>  create mode 100644 python/wheels/meson-1.9.0-py3-none-any.whl

Reviewed-by: Zhao Liu <zhao1.liu@intel.com>


