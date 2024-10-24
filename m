Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4B434CE8E97
	for <qemu-devel@archiver.kernel.org>; Thu, 24 Oct 2024 17:11:52 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t41MY-0002V8-9h; Thu, 24 Oct 2024 13:11:06 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1t41MW-0002Nv-Bc
 for qemu-devel@nongnu.org; Thu, 24 Oct 2024 13:11:04 -0400
Received: from mgamail.intel.com ([192.198.163.16])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1t41MP-0005Bn-PZ
 for qemu-devel@nongnu.org; Thu, 24 Oct 2024 13:11:02 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1729789858; x=1761325858;
 h=date:from:to:cc:subject:message-id:references:
 mime-version:in-reply-to;
 bh=O2ZNMy9Y9IiaYrhs1yGTsX5VnUyHDrH1DZJ9cJnUBAo=;
 b=dy+Xis5VAASST3CPefqU3mUq4vMdhb1Cdrm4yelUR833hHw8Bc/C4bcW
 AFLQdyRTjictKKo+WLJcFZVMF82zaYjyF3eMyt3rOU6sctlEzRfQERDuU
 BiTD8NEwnSqbdAygNJnKrtXFnkaVaXmIoMXaP9ovrixeSd1dAc4ZsdBBp
 mPwafU4bVH4qiyZQXKFmfzPjUhZ42z4if2ueH7q6cnD8UZsMux5zQG5IH
 54/POquoXrV0N3Tf0FwzvWQ0SFqWwsxeA38H4VqOIj3l3FkthDMhlhHNY
 4wMKcZEB0XdUlGV5lGfNBXDq8l3RzcMhST1xafEdlNanDkWYyQSZXO9IY Q==;
X-CSE-ConnectionGUID: PuJ8SCo+SEmnlty8JLm1PQ==
X-CSE-MsgGUID: +TG49pAmR+iZk962KleAkA==
X-IronPort-AV: E=McAfee;i="6700,10204,11235"; a="17063780"
X-IronPort-AV: E=Sophos;i="6.11,229,1725346800"; d="scan'208";a="17063780"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
 by fmvoesa110.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 24 Oct 2024 10:10:55 -0700
X-CSE-ConnectionGUID: R72qKFlpSJe9eqWLUukpnQ==
X-CSE-MsgGUID: qFrt4v4tQBOYhn5+OJE/pg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,229,1725346800"; d="scan'208";a="118121548"
Received: from liuzhao-optiplex-7080.sh.intel.com (HELO localhost)
 ([10.239.160.36])
 by orviesa001.jf.intel.com with ESMTP; 24 Oct 2024 10:10:51 -0700
Date: Fri, 25 Oct 2024 01:27:08 +0800
From: Zhao Liu <zhao1.liu@intel.com>
To: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>
Cc: qemu-devel@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 =?iso-8859-1?Q?Marc-Andr=E9?= Lureau <marcandre.lureau@redhat.com>,
 Daniel =?iso-8859-1?Q?P=2E_Berrang=E9?= <berrange@redhat.com>,
 Philippe =?iso-8859-1?Q?Mathieu-Daud=E9?= <philmd@linaro.org>,
 Alex =?iso-8859-1?Q?Benn=E9e?= <alex.bennee@linaro.org>,
 Thomas Huth <thuth@redhat.com>, Junjie Mao <junjie.mao@hotmail.com>,
 Junjie Mao <junjie.mao@intel.com>, Kevin Wolf <kwolf@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Gustavo Romero <gustavo.romero@linaro.org>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>
Subject: Re: [PATCH 06/11] rust/pl011: add TYPE_PL011_LUMINARY device
Message-ID: <ZxqDbLfd+ACnvDgr@intel.com>
References: <20241024-rust-round-2-v1-0-051e7a25b978@linaro.org>
 <20241024-rust-round-2-v1-6-051e7a25b978@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241024-rust-round-2-v1-6-051e7a25b978@linaro.org>
Received-SPF: pass client-ip=192.198.163.16; envelope-from=zhao1.liu@intel.com;
 helo=mgamail.intel.com
X-Spam_score_int: -46
X-Spam_score: -4.7
X-Spam_bar: ----
X-Spam_report: (-4.7 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.263,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_MED=-2.3, RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, SPF_HELO_NONE=0.001,
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

On Thu, Oct 24, 2024 at 05:03:04PM +0300, Manos Pitsidianakis wrote:
> Date: Thu, 24 Oct 2024 17:03:04 +0300
> From: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>
> Subject: [PATCH 06/11] rust/pl011: add TYPE_PL011_LUMINARY device
> X-Mailer: b4 0.15-dev-12fc5
> 
> Add a device specialization for the Luminary UART device.
> 
> This commit adds a DeviceId enum that utilizes the Index trait to return
> different bytes depending on what device id the UART has (Arm -default-
> or Luminary)
> 
> Signed-off-by: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>
> ---
>  rust/hw/char/pl011/src/device.rs | 59 ++++++++++++++++++++++++++++++++++++++--
>  rust/hw/char/pl011/src/lib.rs    |  1 +
>  2 files changed, 57 insertions(+), 3 deletions(-)
> 

This device type is required by qtest-arm/qom-test & qtest-aarch64/qom-test!
I will pick it up for testing on my side.


