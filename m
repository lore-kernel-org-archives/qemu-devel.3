Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C6169CAC58F
	for <qemu-devel@archiver.kernel.org>; Thu, 11 Sep 2025 02:59:41 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uwXWT-00057h-1q; Wed, 10 Sep 2025 22:58:57 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1uwXWR-00057V-7R
 for qemu-devel@nongnu.org; Wed, 10 Sep 2025 22:58:55 -0400
Received: from mgamail.intel.com ([198.175.65.19])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1uwXWP-0001GM-A9
 for qemu-devel@nongnu.org; Wed, 10 Sep 2025 22:58:54 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1757559533; x=1789095533;
 h=date:from:to:cc:subject:message-id:references:
 mime-version:in-reply-to;
 bh=DWNZHvrWSRyEi0cL03P3qbkv+mObJceq9qbJC4nzGYA=;
 b=Vrygz+cRH+7pEG6lF+k9Ke6ChEPVyYk1ulzgaVpzgBaEc+ENpPD87SN6
 W7iO6ZRT8VN/PsJMYs/9uvuQTzZvmwPd1aJKH73rOl/O7gPcbyzAn2InC
 hv6npI6r8XcZp5b6ijR6K73yngKF73KMGJNpr72hpm8oQzLXv2EvzKiT4
 MdXpvE4jmNhaJ5f6LLioGnKjZC0+rxXB3AF2D2iuHTJTDrqHgSlP3hVxY
 p1YgtziCbvzsTkKag+CUaMVSIZdifI59EvezSCM58Bjk2Mqp2D48TN5Dd
 HB4ZWG726FPOtkJHrFf3Kt6PqoRs/9L+fwuExMyABbshE4fhZ0A2SwnSP g==;
X-CSE-ConnectionGUID: VedSNUCvR1avSMe3lyLc1w==
X-CSE-MsgGUID: yy0wS0Z1QjqJKNB4Nc+FiQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11549"; a="59737811"
X-IronPort-AV: E=Sophos;i="6.18,256,1751266800"; d="scan'208";a="59737811"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
 by orvoesa111.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 10 Sep 2025 19:58:51 -0700
X-CSE-ConnectionGUID: ZCujuDahSxqMaEu80ftf8g==
X-CSE-MsgGUID: o+n/+m9FSmy9qccqOdrZyQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.18,256,1751266800"; d="scan'208";a="173132692"
Received: from liuzhao-optiplex-7080.sh.intel.com (HELO localhost)
 ([10.239.160.39])
 by orviesa009.jf.intel.com with ESMTP; 10 Sep 2025 19:58:51 -0700
Date: Thu, 11 Sep 2025 11:20:42 +0800
From: Zhao Liu <zhao1.liu@intel.com>
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: qemu-devel@nongnu.org
Subject: Re: [PATCH 04/33] rust: add missing const markers for MSRV==1.83.0
Message-ID: <aMJACsvE1WFL3l0/@intel.com>
References: <20250908105005.2119297-1-pbonzini@redhat.com>
 <20250908105005.2119297-5-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250908105005.2119297-5-pbonzini@redhat.com>
Received-SPF: pass client-ip=198.175.65.19; envelope-from=zhao1.liu@intel.com;
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

On Mon, Sep 08, 2025 at 12:49:36PM +0200, Paolo Bonzini wrote:
> Date: Mon,  8 Sep 2025 12:49:36 +0200
> From: Paolo Bonzini <pbonzini@redhat.com>
> Subject: [PATCH 04/33] rust: add missing const markers for MSRV==1.83.0
> X-Mailer: git-send-email 2.51.0
> 
> Rust 1.83 allows more functions to be marked const.
> Fix clippy with bumped minimum supported Rust version.
> 
> Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
> ---
>  rust/bits/src/lib.rs            | 6 +++---
>  rust/qemu-api/src/assertions.rs | 4 ++--
>  rust/qemu-api/src/cell.rs       | 6 ++----
>  rust/qemu-api/src/qom.rs        | 6 +++---
>  rust/qemu-api/src/timer.rs      | 2 +-
>  rust/qemu-api/src/uninit.rs     | 6 +++---
>  6 files changed, 14 insertions(+), 16 deletions(-)

Reviewed-by: Zhao Liu <zhao1.liu@intel.com>


