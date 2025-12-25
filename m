Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AAD41E784BD
	for <qemu-devel@archiver.kernel.org>; Thu, 25 Dec 2025 03:25:58 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vYbyK-0002rw-2a; Wed, 24 Dec 2025 22:25:04 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1vYbyI-0002qv-Dr; Wed, 24 Dec 2025 22:25:02 -0500
Received: from mgamail.intel.com ([198.175.65.16])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1vYbyF-0006Lk-QU; Wed, 24 Dec 2025 22:25:02 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1766633100; x=1798169100;
 h=date:from:to:cc:subject:message-id:references:
 mime-version:content-transfer-encoding:in-reply-to;
 bh=iD6gf1fOpbn3EsLCUQ3ZiOGMijTZzv6KZ/dDuT8xccA=;
 b=UdxtiqkRkQo3icCdEtBdMJIRmwHHUUadSi7q7UMgedraRxNXRTr4T3TS
 DtN6B3Xj5ca1ig81V4Mwb+O3DD/gWofnDffBJtgys1/IgtMihI5trR+sR
 LGAzE/AezymYhz9cW3riYD8cvT5lW4/xUw4Lb+e6Z4bZKhaOr7W9KW6lI
 AQcwVLzzYtqodFJSPY9Es97OZpZTeGRTQ7qiHNj1IgcyeUuo6IBlu7twW
 ASl9iim6qM0msyCeZVIZ6gIZ+DSgJ/Yu1vFbfrVxNXsXtNWax2wEunDPF
 a29KglERy2okBxKVwRm6mNZn39CqYpBx+WfRB3xZenHis4dG9MxJlH5lH w==;
X-CSE-ConnectionGUID: vVetLhcZSF2Kwj/XCrS0/g==
X-CSE-MsgGUID: DkxZSEE4SgOn6ZPeEVBrkA==
X-IronPort-AV: E=McAfee;i="6800,10657,11652"; a="68609230"
X-IronPort-AV: E=Sophos;i="6.21,175,1763452800"; d="scan'208";a="68609230"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
 by orvoesa108.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 24 Dec 2025 19:24:54 -0800
X-CSE-ConnectionGUID: o5WG9iVSSbClKdZtLwd2Mg==
X-CSE-MsgGUID: JV37ixU4ScitSqEayNyWoA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,175,1763452800"; d="scan'208";a="199890956"
Received: from liuzhao-optiplex-7080.sh.intel.com (HELO localhost)
 ([10.239.160.39])
 by orviesa009.jf.intel.com with ESMTP; 24 Dec 2025 19:24:50 -0800
Date: Thu, 25 Dec 2025 11:49:43 +0800
From: Zhao Liu <zhao1.liu@intel.com>
To: Philippe =?iso-8859-1?Q?Mathieu-Daud=E9?= <philmd@linaro.org>
Cc: qemu-devel@nongnu.org, Jason Wang <jasowang@redhat.com>,
 qemu-rust@nongnu.org, Peter Maydell <peter.maydell@linaro.org>,
 Anton Johansson <anjo@rev.ng>, Max Filippov <jcmvbkbc@gmail.com>,
 "Michael S. Tsirkin" <mst@redhat.com>,
 =?iso-8859-1?Q?Marc-Andr=E9?= Lureau <marcandre.lureau@redhat.com>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 Brian Cain <brian.cain@oss.qualcomm.com>,
 Manos Pitsidianakis <manos.pitsidianakis@linaro.org>,
 qemu-arm@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>
Subject: Re: [PATCH v2 5/8] hw/timer/hpet: Mark implementation as being
 little-endian
Message-ID: <aUy0V0bAjbU1Br1k@intel.com>
References: <20251224134644.85582-1-philmd@linaro.org>
 <20251224134644.85582-6-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20251224134644.85582-6-philmd@linaro.org>
Received-SPF: pass client-ip=198.175.65.16; envelope-from=zhao1.liu@intel.com;
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

On Wed, Dec 24, 2025 at 02:46:41PM +0100, Philippe Mathieu-Daudé wrote:
> Date: Wed, 24 Dec 2025 14:46:41 +0100
> From: Philippe Mathieu-Daudé <philmd@linaro.org>
> Subject: [PATCH v2 5/8] hw/timer/hpet: Mark implementation as being
>  little-endian
> X-Mailer: git-send-email 2.52.0
> 
> The HPET component is only built / used by X86 targets, which
> are only built in little endianness. Thus we only ever built
> as little endian, never testing the big-endian possibility of
> the DEVICE_NATIVE_ENDIAN definition. Simplify by only keeping
> the little endian variant.
> 
> Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
> Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>  hw/timer/hpet.c                  | 2 +-
>  rust/hw/timer/hpet/src/device.rs | 2 +-
>  2 files changed, 2 insertions(+), 2 deletions(-)

Reviewed-by: Zhao Liu <zhao1.liu@intel.com>


