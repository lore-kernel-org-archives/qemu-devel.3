Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AF503CCFA04
	for <qemu-devel@archiver.kernel.org>; Tue,  4 Nov 2025 14:55:32 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vGIR8-00070j-Py; Tue, 04 Nov 2025 09:55:06 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1vGIR7-0006z9-KN; Tue, 04 Nov 2025 09:55:05 -0500
Received: from mgamail.intel.com ([192.198.163.13])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1vGIR4-0006nm-AZ; Tue, 04 Nov 2025 09:55:04 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1762268102; x=1793804102;
 h=date:from:to:cc:subject:message-id:references:
 mime-version:in-reply-to;
 bh=UHXQA57NYh2LnGk/aGlDAcKR0v/Pbs6y2zU90VC71tU=;
 b=d4bMlYpq0hEVUuwl5F8L55CeFXvj1hzE7i6TZpnO3Ukd06FMk50GOmU/
 TysN+LTUf1MsT5rxuUusgeF6CrjiTm69wFMmfS2eIeYI1H1QXu672B81h
 txDABSnFSoNJ9aP3YM5LD7Z1uNBbPyxDFsMp0LwlVFvWihh7LrVMQB8FB
 rWayupksfH85q1wY5JGvHB2AyJZCloJVplp6OLrZUcy47zkrRVHU26BeI
 T9vIgofOLBiP5Ohf/MFRaR55JLzD5t+224dEF26GEFEz4JqA1W4/Mi7qD
 cWYmboV/vES5e4JMqftOYGEPOcB4+cQGCgetT6sNmi94FUorXmwn2Pei/ A==;
X-CSE-ConnectionGUID: YmHwl/3FT52tVZ8cNsl4UA==
X-CSE-MsgGUID: baruhOpXQHC5dq9YcWD05A==
X-IronPort-AV: E=McAfee;i="6800,10657,11602"; a="66978370"
X-IronPort-AV: E=Sophos;i="6.19,279,1754982000"; d="scan'208";a="66978370"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
 by fmvoesa107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 04 Nov 2025 06:54:59 -0800
X-CSE-ConnectionGUID: yvI8qxDJRcOFWjLJKxEHUw==
X-CSE-MsgGUID: X1bXNLKuQN2X16akIm4OBg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.19,279,1754982000"; d="scan'208";a="186416781"
Received: from liuzhao-optiplex-7080.sh.intel.com (HELO localhost)
 ([10.239.160.39])
 by orviesa006.jf.intel.com with ESMTP; 04 Nov 2025 06:54:58 -0800
Date: Tue, 4 Nov 2025 23:17:11 +0800
From: Zhao Liu <zhao1.liu@intel.com>
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: qemu-devel@nongnu.org, qemu-rust@nongnu.org
Subject: Re: [PATCH 1/4] rust/util: add ensure macro
Message-ID: <aQoY9zEKNPKQhV5J@intel.com>
References: <20251031152540.293293-1-pbonzini@redhat.com>
 <20251031152540.293293-2-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251031152540.293293-2-pbonzini@redhat.com>
Received-SPF: pass client-ip=192.198.163.13; envelope-from=zhao1.liu@intel.com;
 helo=mgamail.intel.com
X-Spam_score_int: -51
X-Spam_score: -5.2
X-Spam_bar: -----
X-Spam_report: (-5.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.788,
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

On Fri, Oct 31, 2025 at 04:25:36PM +0100, Paolo Bonzini wrote:
> Date: Fri, 31 Oct 2025 16:25:36 +0100
> From: Paolo Bonzini <pbonzini@redhat.com>
> Subject: [PATCH 1/4] rust/util: add ensure macro
> X-Mailer: git-send-email 2.51.1
> 
> The macro is similar to anyhow::ensure but uses QEMU's variation
> on anyhow::Error.  It can be used to easily check a condition
> and format an error message.
> 
> Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
> ---
>  rust/hw/timer/hpet/src/device.rs | 21 ++++++----
>  rust/hw/timer/hpet/src/fw_cfg.rs |  7 ++--
>  rust/util/src/error.rs           | 71 ++++++++++++++++++++++++++++++++
>  3 files changed, 86 insertions(+), 13 deletions(-)

Good!

Reviewed-by: Zhao Liu <zhao1.liu@intel.com>


