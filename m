Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4BC29CAC5A7
	for <qemu-devel@archiver.kernel.org>; Thu, 25 Sep 2025 15:48:54 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v1oBy-00072k-Qe; Thu, 25 Sep 2025 11:47:35 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1v1oBw-00072Z-H0
 for qemu-devel@nongnu.org; Thu, 25 Sep 2025 11:47:33 -0400
Received: from mgamail.intel.com ([192.198.163.12])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1v1oBn-0005gs-3J
 for qemu-devel@nongnu.org; Thu, 25 Sep 2025 11:47:31 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1758815243; x=1790351243;
 h=date:from:to:cc:subject:message-id:references:
 mime-version:in-reply-to;
 bh=9/AVPuFkvUBGeKQmJQgZbDIYUtnCf3Wh9O9tr/ojy/A=;
 b=Sh1WnASZO/JNbll3L8i9daDurXAH0xftNQhqg+3ildjvPMisBsDL9Npe
 rjnYcmia2oKaIAhZecxqWLtsmJybFv2s2dmbcWsu9tQa6a8tiU8y1L/gT
 S41grZ6B4ndlTzEP01kfCrimLyiecbKtYsW9fT/99DZYg2NdQozCM961k
 PERnaRUHS1jcD1nuPbBLIkPyoo0s7uX29Ufr+5TCS2lSU+8Uh8GSvgyHE
 IzZKT3Zel0SK8Wvf6YwmSgGoZjEnDujaIXR4+pxBxScvrUWpxsTUIEe5h
 Gyrg8NdMZvdGRFfqMLSIN2GqqDnZb6K+ZrUUm1edMNH/0xv86nfYHhLq+ g==;
X-CSE-ConnectionGUID: uJbseF7HQ/SKTEai4GotBg==
X-CSE-MsgGUID: eVoa3LKoSBOGxcBG7pjycw==
X-IronPort-AV: E=McAfee;i="6800,10657,11564"; a="64983741"
X-IronPort-AV: E=Sophos;i="6.18,292,1751266800"; d="scan'208";a="64983741"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
 by fmvoesa106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 25 Sep 2025 08:47:08 -0700
X-CSE-ConnectionGUID: Ok/5XTLoQNyLo/nJd7iPZg==
X-CSE-MsgGUID: JImgq4qQTiCIujaGrJmWEQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.18,292,1751266800"; d="scan'208";a="176981055"
Received: from liuzhao-optiplex-7080.sh.intel.com (HELO localhost)
 ([10.239.160.39])
 by fmviesa007.fm.intel.com with ESMTP; 25 Sep 2025 08:47:07 -0700
Date: Fri, 26 Sep 2025 00:09:05 +0800
From: Zhao Liu <zhao1.liu@intel.com>
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: qemu-devel@nongnu.org, hector.cao@canonical.com, lk@c--e.de,
 berrange@redhat.com
Subject: Re: [RFT PATCH v2 1/2] target/i386: add compatibility property for
 arch_capabilities
Message-ID: <aNVpIUbUphccLW4K@intel.com>
References: <20250923104136.133875-1-pbonzini@redhat.com>
 <20250923104136.133875-2-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250923104136.133875-2-pbonzini@redhat.com>
Received-SPF: pass client-ip=192.198.163.12; envelope-from=zhao1.liu@intel.com;
 helo=mgamail.intel.com
X-Spam_score_int: -47
X-Spam_score: -4.8
X-Spam_bar: ----
X-Spam_report: (-4.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.445,
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

On Tue, Sep 23, 2025 at 12:41:35PM +0200, Paolo Bonzini wrote:
> Date: Tue, 23 Sep 2025 12:41:35 +0200
> From: Paolo Bonzini <pbonzini@redhat.com>
> Subject: [RFT PATCH v2 1/2] target/i386: add compatibility property for
>  arch_capabilities
> X-Mailer: git-send-email 2.51.0
> 
> Prior to v10.1, if requested by user, arch-capabilities is always on
> despite the fact that CPUID advertises it to be off/unvailable.
> This causes a migration issue for VMs that are run on a machine
> without arch-capabilities and expect this feature to be present
> on the destination host with QEMU 10.1.
> 
> Add a compatibility property to restore the legacy behavior for all
> machines with version prior to 10.1.
> 
> Co-authored-by: Hector Cao <hector.cao@canonical.com>
> Signed-off-by: Hector Cao <hector.cao@canonical.com>
> Fixes: d3a24134e37 ("target/i386: do not expose ARCH_CAPABILITIES on AMD CPU", 2025-07-17)
> Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
> ---
>  target/i386/cpu.h     |  6 ++++++
>  hw/i386/pc.c          |  1 +
>  target/i386/cpu.c     | 17 +++++++++++++++++
>  target/i386/kvm/kvm.c |  6 +-----
>  4 files changed, 25 insertions(+), 5 deletions(-)

Reviewed-by: Zhao Liu <zhao1.liu@intel.com>


