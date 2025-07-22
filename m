Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9D0DBC83F1A
	for <qemu-devel@archiver.kernel.org>; Tue, 22 Jul 2025 14:22:43 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ueDsb-0006tp-5a; Tue, 22 Jul 2025 10:22:06 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1ueDoL-0003Uj-Vj; Tue, 22 Jul 2025 10:17:45 -0400
Received: from mgamail.intel.com ([192.198.163.18])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1ueDoH-0002vI-WB; Tue, 22 Jul 2025 10:17:40 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1753193858; x=1784729858;
 h=date:from:to:cc:subject:message-id:references:
 mime-version:in-reply-to;
 bh=QpA7Auk83yejgin4enzPJ97PcNK0/rjrjfBAnFYKpGs=;
 b=RyItNvuW4DcGX8FFS+g8bCm00k1RbL3YpLuD6huAIx0sLr6M2wjoRUN7
 W2YieLMOcxSwsB6yH4xJAz97F9bnybxYJCLG+HrA/m+L18haK2Any+vBc
 MnWmiMULZ3QwUImxPl8Rd9f7NHgUTuKkdYVoSewrFtcIvJ8ZLkDWWoq7/
 +Anw/lZ7dHMAAUy8M/BicmZspjYrhhz/3hGmQu2J0prpbpQTxyqmJVh9v
 yL5Ds6cQsva4w5kEOjNkilPJiNjh5mxDtNaXk+BXG8NyTP1h4YMvNVNxn
 UAw4JSxiuNl1d0Q3UJhW+w/kAX6yP9gLIpKmfNA4ca07mGQEtb1xLBKsk A==;
X-CSE-ConnectionGUID: CUILMJnMQrae05K6bF8GpQ==
X-CSE-MsgGUID: Lf03q2cJTPSP7Blb4Rxb7w==
X-IronPort-AV: E=McAfee;i="6800,10657,11500"; a="54664477"
X-IronPort-AV: E=Sophos;i="6.16,331,1744095600"; d="scan'208";a="54664477"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
 by fmvoesa112.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 22 Jul 2025 07:17:32 -0700
X-CSE-ConnectionGUID: SVRQ4+PJTqyl7YK4D8A+Xw==
X-CSE-MsgGUID: uyt1hJsfTKuQSjMNzR+bdw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,331,1744095600"; d="scan'208";a="163397282"
Received: from liuzhao-optiplex-7080.sh.intel.com (HELO localhost)
 ([10.239.160.39])
 by orviesa003.jf.intel.com with ESMTP; 22 Jul 2025 07:17:30 -0700
Date: Tue, 22 Jul 2025 22:39:03 +0800
From: Zhao Liu <zhao1.liu@intel.com>
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: qemu-devel@nongnu.org, qemu-rust@nongnu.org
Subject: Re: [PATCH] rust: devices are not staticlibs
Message-ID: <aH+ih+Nd5yiQH2lr@intel.com>
References: <20250721105238.461477-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250721105238.461477-1-pbonzini@redhat.com>
Received-SPF: pass client-ip=192.198.163.18; envelope-from=zhao1.liu@intel.com;
 helo=mgamail.intel.com
X-Spam_score_int: -49
X-Spam_score: -5.0
X-Spam_bar: -----
X-Spam_report: (-5.0 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.633,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_MED=-2.3, RCVD_IN_MSPIKE_H2=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

On Mon, Jul 21, 2025 at 12:52:38PM +0200, Paolo Bonzini wrote:
> Date: Mon, 21 Jul 2025 12:52:38 +0200
> From: Paolo Bonzini <pbonzini@redhat.com>
> Subject: [PATCH] rust: devices are not staticlibs
> X-Mailer: git-send-email 2.50.1
> 
> This is only cosmetic for now, but hopefully later on Meson will parse more
> of Cargo.toml.  Devices are linked into a staticlib but are not staticlibs
> themselves.
> 
> Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
> ---
>  rust/hw/char/pl011/Cargo.toml | 3 ---
>  rust/hw/timer/hpet/Cargo.toml | 3 ---
>  2 files changed, 6 deletions(-)

Reviewed-by: Zhao Liu <zhao1.liu@intel.com>


