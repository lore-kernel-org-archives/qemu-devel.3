Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C0A58C83F09
	for <qemu-devel@archiver.kernel.org>; Tue,  8 Jul 2025 20:56:07 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uZFIs-0006Ve-7K; Tue, 08 Jul 2025 16:52:40 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1uZEBZ-00058q-L8; Tue, 08 Jul 2025 15:41:01 -0400
Received: from mgamail.intel.com ([192.198.163.19])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1uZEBW-0005kz-Kp; Tue, 08 Jul 2025 15:41:01 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1752003659; x=1783539659;
 h=date:from:to:cc:subject:message-id:references:
 mime-version:in-reply-to;
 bh=5AZWABFqRA/e1BTlrZFpszmALf+OAszQvzV4qh0dUfY=;
 b=TzPvB+3dR1b7RmitEBIlo57o5mtW/mWsT2VMf0+cZf0akG1d2U77pM5N
 4XnnqjBuQlO6SLkVFiW8A/PcDwCebrW+xMBQXx5fUshie/TXmEMp/F4y9
 1hiQ6rhTqC0iiI1SiyUQRY9nbyHz7ZhbkjahFH1sy3a5DLc9tG/89mOMZ
 rdpOdM/mvycODRVeu4MkF9Tsfb5rYfJREWKvjyNo3ZIixEIgqyopfQOd7
 yhh672xFjq1sSjcmG2VFF/0KNVewhHsXAK9LStD0j8Wmiy9kSa7TWo0c/
 hLfqGi/K5O3wiLXo8TJT0H0WVQwX+nOs9zb6VQbJAzSt4N/djDYosxX7w w==;
X-CSE-ConnectionGUID: L0wEZ3xwSmysXoHYQygbow==
X-CSE-MsgGUID: WS4KlgpsT6aVkxx5b816/g==
X-IronPort-AV: E=McAfee;i="6800,10657,11487"; a="53311535"
X-IronPort-AV: E=Sophos;i="6.16,296,1744095600"; d="scan'208";a="53311535"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
 by fmvoesa113.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 08 Jul 2025 01:21:45 -0700
X-CSE-ConnectionGUID: vsi4EEyiTwWmBnFmq9Gkog==
X-CSE-MsgGUID: HGXqK56tQG+5Dvf97isWgg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,296,1744095600"; d="scan'208";a="186392298"
Received: from liuzhao-optiplex-7080.sh.intel.com (HELO localhost)
 ([10.239.160.39])
 by fmviesa001.fm.intel.com with ESMTP; 08 Jul 2025 01:21:43 -0700
Date: Tue, 8 Jul 2025 16:43:11 +0800
From: Zhao Liu <zhao1.liu@intel.com>
To: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>
Cc: qemu-devel@nongnu.org, qemu-rust@nongnu.org,
 Paolo Bonzini <pbonzini@redhat.com>
Subject: Re: [PATCH 2/3] memattrs.h: make MemTxAttrs into enum
Message-ID: <aGzaH7repxHkRRXQ@intel.com>
References: <20250703-rust-mem-api-v1-0-cd5314bdf580@linaro.org>
 <20250703-rust-mem-api-v1-2-cd5314bdf580@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250703-rust-mem-api-v1-2-cd5314bdf580@linaro.org>
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

On Thu, Jul 03, 2025 at 04:58:12PM +0300, Manos Pitsidianakis wrote:
> Date: Thu, 03 Jul 2025 16:58:12 +0300
> From: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>
> Subject: [PATCH 2/3] memattrs.h: make MemTxAttrs into enum
> X-Mailer: b4 0.14.2
> 
> Convert MemTxResult defines into an enum. This will allow bindgen to
> generate a bitflag using the enum variants as its domain of values.
> 
> Signed-off-by: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>
> ---
>  include/exec/memattrs.h | 11 ++++++-----
>  1 file changed, 6 insertions(+), 5 deletions(-)

Reviewed-by: Zhao Liu <zhao1.liu@intel.com>


