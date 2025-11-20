Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DE92FCF8860
	for <qemu-devel@archiver.kernel.org>; Thu, 20 Nov 2025 14:27:45 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vM5ca-0007As-BX; Thu, 20 Nov 2025 09:26:52 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1vM5cY-0007A6-7y; Thu, 20 Nov 2025 09:26:50 -0500
Received: from mgamail.intel.com ([192.198.163.19])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1vM5cW-0005gH-B0; Thu, 20 Nov 2025 09:26:49 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1763648808; x=1795184808;
 h=date:from:to:cc:subject:message-id:references:
 mime-version:in-reply-to;
 bh=ykhT5gy+36T80ZBPebaRSAxIa86CBnNAierAR1qmek4=;
 b=ImXDUTtB8LwnV75EF8lDlP9D+J8r7RU0/pPeROS3UFXdHv+mDRsx+bT1
 fehbS9cJCfOcKxepUblic1NUm4+6BFTgkoVuE10rBOO3aNAKZzvaR5iRB
 ZmRRD9ey3jxBLkuKSrpaWLeC71x1//DwAF80wtE7sU8KoH+jYJgPkQgDd
 GtS2zU/FSuZ7w09QLnECvK71HPfmy+Ao2s5zhLS9kABy7eEXkpROXgZ+u
 xNZZhqhHO+ABb047rhVFgQrhnwYFKqxasaMsqBAvchLtoVpR7a6eOmyyV
 dCnx6gnula/aWV7sMgbwdF5S6gckAtJRZZVYLlC4lb67ZZSpStKYcifUx g==;
X-CSE-ConnectionGUID: 8446eRjOTMO6iGsEGWn0yg==
X-CSE-MsgGUID: 7NKWeadOTvWuQyPDtnVKlQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11619"; a="64725568"
X-IronPort-AV: E=Sophos;i="6.20,213,1758610800"; d="scan'208";a="64725568"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
 by fmvoesa113.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 20 Nov 2025 06:26:45 -0800
X-CSE-ConnectionGUID: IwPCd6B3Qh+J1yLP1sE9Kw==
X-CSE-MsgGUID: rqutV1yaQnCScar0hEuD0A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.20,213,1758610800"; d="scan'208";a="222313220"
Received: from liuzhao-optiplex-7080.sh.intel.com (HELO localhost)
 ([10.239.160.39])
 by fmviesa001.fm.intel.com with ESMTP; 20 Nov 2025 06:26:43 -0800
Date: Thu, 20 Nov 2025 22:49:04 +0800
From: Zhao Liu <zhao1.liu@intel.com>
To: Stefan Hajnoczi <stefanha@redhat.com>
Cc: qemu-devel@nongnu.org,
 Philippe =?iso-8859-1?Q?Mathieu-Daud=E9?= <philmd@linaro.org>,
 qemu-rust@nongnu.org, Mads Ynddal <mads@ynddal.dk>,
 Thomas Huth <thuth@redhat.com>,
 Manos Pitsidianakis <manos.pitsidianakis@linaro.org>,
 Alex =?iso-8859-1?Q?Benn=E9e?= <alex.bennee@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>, Josh Stone <jistone@redhat.com>
Subject: Re: [PATCH v2 2/4] rust/hpet: add trace events
Message-ID: <aR8qYPwzsuCfTliL@intel.com>
References: <20251119205200.173170-1-stefanha@redhat.com>
 <20251119205200.173170-3-stefanha@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251119205200.173170-3-stefanha@redhat.com>
Received-SPF: pass client-ip=192.198.163.19; envelope-from=zhao1.liu@intel.com;
 helo=mgamail.intel.com
X-Spam_score_int: -43
X-Spam_score: -4.4
X-Spam_bar: ----
X-Spam_report: (-4.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
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

On Wed, Nov 19, 2025 at 03:51:58PM -0500, Stefan Hajnoczi wrote:
> Date: Wed, 19 Nov 2025 15:51:58 -0500
> From: Stefan Hajnoczi <stefanha@redhat.com>
> Subject: [PATCH v2 2/4] rust/hpet: add trace events
> 
> Implement the same trace events as the C implementation.
> 
> Notes:
> - Keep order of hpet_ram_write_invalid_tn_cmp and hpet_ram_write_tn_cmp
>   the same as the C implementation.
> - Put hpet_ram_write_timer_id in HPETTimer::write() instead of
>   HPETState::decode() so that reads can be excluded.

Yes, these changes are accurate and clear.

> Signed-off-by: Stefan Hajnoczi <stefanha@redhat.com>
> ---
>  rust/hw/timer/hpet/Cargo.toml    |  1 +
>  rust/hw/timer/hpet/meson.build   |  1 +
>  rust/hw/timer/hpet/src/device.rs | 45 +++++++++++++++++++-------------
>  3 files changed, 29 insertions(+), 18 deletions(-)

Reviewed-by: Zhao Liu <zhao1.liu@intel.com>


