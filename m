Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7787BC83F1A
	for <qemu-devel@archiver.kernel.org>; Fri, 18 Jul 2025 09:26:45 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uchMP-0001fl-Io; Fri, 18 Jul 2025 05:26:33 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1uchMM-0001b2-SK
 for qemu-devel@nongnu.org; Fri, 18 Jul 2025 05:26:30 -0400
Received: from mgamail.intel.com ([192.198.163.16])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1uchMJ-0006lG-NU
 for qemu-devel@nongnu.org; Fri, 18 Jul 2025 05:26:30 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1752830788; x=1784366788;
 h=date:from:to:cc:subject:message-id:references:
 mime-version:content-transfer-encoding:in-reply-to;
 bh=GW+AL4x4ENDUeXruYQ+ZTUR+nsFwEcHn9yHMU+jPduY=;
 b=WEBUSPRuSnQuoyoubXyr0p0ifmvQsHhFRflZTWJprnDJV5AT9eIVfovZ
 3sAtSIR6WVDCd4YurcQ/+6V9FJCipLtqtixny/lZtLbbRc4cDUMABrgzD
 QGNpHf3Owfhk3rvHB+PYTBeINHxwfx/Yu2IT3LP+v53CgG/pndWuYEV7T
 bK8Xc6bYXbgQGMVFjVKv3/EvqTj0WbtX6npxaEXUnZqFHwxz0UPsNCAza
 aHYU4hCCLTwuvMmFBsw09VMYEkwc4j0CGdTo/XVY5kdONJ7caLZDsFxNS
 u2DLxiMGAuOP9fHT7U/oWDlnAD3hvUPnPsYce0/GfehiZUY2jIdvqSLaA Q==;
X-CSE-ConnectionGUID: Jpe1VeFUReySimrqkwmyTQ==
X-CSE-MsgGUID: gNkz7Lm9TnmDnMMA5kPc/Q==
X-IronPort-AV: E=McAfee;i="6800,10657,11495"; a="42744842"
X-IronPort-AV: E=Sophos;i="6.16,321,1744095600"; d="scan'208";a="42744842"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
 by fmvoesa110.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 18 Jul 2025 02:26:23 -0700
X-CSE-ConnectionGUID: LhNBuI3TT1udqEq8/UyTxA==
X-CSE-MsgGUID: ytt4pM4YS4KKikWO+4v8tQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,321,1744095600"; d="scan'208";a="158093928"
Received: from liuzhao-optiplex-7080.sh.intel.com (HELO localhost)
 ([10.239.160.39])
 by orviesa007.jf.intel.com with ESMTP; 18 Jul 2025 02:26:21 -0700
Date: Fri, 18 Jul 2025 17:47:52 +0800
From: Zhao Liu <zhao1.liu@intel.com>
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: qemu-devel@nongnu.org, Alexandre Chartre <alexandre.chartre@oracle.com>,
 Daniel =?iso-8859-1?Q?P=2E_Berrang=E9?= <berrange@redhat.com>
Subject: Re: [PATCH] target/i386: do not expose ARCH_CAPABILITIES on AMD CPU
Message-ID: <aHoYSBDZmSliPQJL@intel.com>
References: <20250717103448.331037-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20250717103448.331037-1-pbonzini@redhat.com>
Received-SPF: pass client-ip=192.198.163.16; envelope-from=zhao1.liu@intel.com;
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

On Thu, Jul 17, 2025 at 12:34:48PM +0200, Paolo Bonzini wrote:
> Date: Thu, 17 Jul 2025 12:34:48 +0200
> From: Paolo Bonzini <pbonzini@redhat.com>
> Subject: [PATCH] target/i386: do not expose ARCH_CAPABILITIES on AMD CPU
> X-Mailer: git-send-email 2.50.1
> 
> KVM emulates the ARCH_CAPABILITIES on x86 for both Intel and AMD
> cpus, although the IA32_ARCH_CAPABILITIES MSR is an Intel-specific
> MSR and it makes no sense to emulate it on AMD.
> 
> As a consequence, VMs created on AMD with qemu -cpu host and using
> KVM will advertise the ARCH_CAPABILITIES feature and provide the
> IA32_ARCH_CAPABILITIES MSR. This can cause issues (like Windows BSOD)
> as the guest OS might not expect this MSR to exist on such cpus (the
> AMD documentation specifies that ARCH_CAPABILITIES feature and MSR
> are not defined on the AMD architecture).
> 
> A fix was proposed in KVM code, however KVM maintainers don't want to
> change this behavior that exists for 6+ years and suggest changes to be
> done in QEMU instead.  Therefore, hide the bit from "-cpu host":
> migration of -cpu host guests is only possible between identical host
> kernel and QEMU versions, therefore this is not a problematic breakage.
> 
> If a future AMD machine does include the MSR, that would re-expose the
> Windows guest bug; but it would not be KVM/QEMU's problem at that
> point, as we'd be following a genuine physical CPU impl.

Make sense.

> Reported-by: Alexandre Chartre <alexandre.chartre@oracle.com>
> Suggested-by: Daniel P. Berrangé <berrange@redhat.com>
> Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
> ---
>  target/i386/kvm/kvm.c | 6 +++++-
>  1 file changed, 5 insertions(+), 1 deletion(-)

Good to see this fix. Late but,

Reviewed-by: Zhao Liu <zhao1.liu@intel.com>



