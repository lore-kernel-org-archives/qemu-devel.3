Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 19CE5C3ABBF
	for <qemu-devel@archiver.kernel.org>; Tue,  6 May 2025 08:36:25 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uCDmN-0008B6-Hk; Tue, 06 May 2025 04:35:55 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1uCDmH-0008Ad-Pg; Tue, 06 May 2025 04:35:49 -0400
Received: from mgamail.intel.com ([198.175.65.15])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1uCDmE-0005FE-Le; Tue, 06 May 2025 04:35:49 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1746520547; x=1778056547;
 h=date:from:to:cc:subject:message-id:references:
 mime-version:in-reply-to;
 bh=Jb1RRhleGPIZe3nJwLfwOBtdZ6gcQwVxPCoj7j8/H2I=;
 b=IJdrRtfNg4Z3Hn2Qn0QMJOZwA4N48brYRbF+h5/6nENOuoxTmcwqHYSe
 BfU7sUFnGApSPWjjYK4x1m6CgIVyD8KLdBK4VRp12uZDvPHn9Aq/ywRYY
 2DvFc6i9CV5fi57qGqYGW6E4rOYVrNl2uw8cK5A1bfRrzBeLki9Wd69qZ
 7dxTFYDv+MnRPaJRRBrRH7n5j/aq6sestjws2iPv55lSwu4WAcKQDFall
 VvVXt3KoGoSzjhpPzjhGEqlnio144iwxnkuPqlNZUbt1qAPYzQ8A1qKhi
 6nSI8P0b30a+5zTi/6MC7NyiKU9Qr4UT4uF4he86oUFl21RraGacJ0SXt Q==;
X-CSE-ConnectionGUID: Ab3ft/hhS9yPAPmuww75cw==
X-CSE-MsgGUID: nHkYgciXT6GJLeipnYBbaA==
X-IronPort-AV: E=McAfee;i="6700,10204,11424"; a="51824250"
X-IronPort-AV: E=Sophos;i="6.15,265,1739865600"; d="scan'208";a="51824250"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
 by orvoesa107.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 06 May 2025 01:35:42 -0700
X-CSE-ConnectionGUID: u8ILFuOiSwynrNnIaJDs8Q==
X-CSE-MsgGUID: gj5pK1CfTcuUhWypPgnJIQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,265,1739865600"; d="scan'208";a="140504277"
Received: from liuzhao-optiplex-7080.sh.intel.com (HELO localhost)
 ([10.239.160.39])
 by orviesa004.jf.intel.com with ESMTP; 06 May 2025 01:35:42 -0700
Date: Tue, 6 May 2025 16:56:42 +0800
From: Zhao Liu <zhao1.liu@intel.com>
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: qemu-devel@nongnu.org, qemu-rust@nongnu.org
Subject: Re: [PATCH preview 0/5] rust: allow minimum version of 1.83
Message-ID: <aBnOyhMawDaY9yyR@intel.com>
References: <20250505100854.73936-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250505100854.73936-1-pbonzini@redhat.com>
Received-SPF: pass client-ip=198.175.65.15; envelope-from=zhao1.liu@intel.com;
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

> This series does not cover enabling the newer compiler in CI because,
> while both Debian and Ubuntu have a new-enough Rust compiler to support
> 1.77, they pose problems for this further bump.  For Debian, the bookworm
> release probably will not have new compilers and is supported by QEMU
> for roughly two more years.  For Ubuntu, the situation is a bit weird
> because while Ubuntu 22.04 had new Rust compilers added until the summer
> of 2024, Ubuntu 24.04 is not adding packages for new versions.
> 
> A possible plan here is to split the configuration between "enable Rust"
> and "enable all devices written in Rust" as soon as new devices are
> contributed that are written in Rust.  This way, the C versions of
> the pl011 and HPET devices can be used but the new boards/devices would
> only be available on Debian or Ubuntu by using rustup.

"enable Rust" supports v1.77 and "enable all devices written in Rust"
supports v1.83, correct?

If so, do we need two versions of vmstate? one is for v1.77 (that HPET &
pl011 can use), and another one is for v1.83 (newer devices based on
v1.83 can use).

The current vmstate builder is excellent, but I'm concerned it might not
land soon. Can we find a compromise?

Thanks,
Zhao


