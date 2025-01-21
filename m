Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C8E54C02182
	for <qemu-devel@archiver.kernel.org>; Tue, 21 Jan 2025 12:22:34 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1taDGp-0007KX-Cq; Tue, 21 Jan 2025 07:22:15 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1taDGf-0007Jy-BO
 for qemu-devel@nongnu.org; Tue, 21 Jan 2025 07:22:05 -0500
Received: from mgamail.intel.com ([198.175.65.10])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1taDGY-0000iN-SM
 for qemu-devel@nongnu.org; Tue, 21 Jan 2025 07:22:05 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1737462119; x=1768998119;
 h=date:from:to:cc:subject:message-id:references:
 mime-version:in-reply-to;
 bh=Ll2ySsYDbodELsc9t9biOQu3moAcTzskpAu1V2V3rds=;
 b=S+V1YoSMYVlyzD/a+DGow06CBb7yiMUpoxV4KGpHVKTVnnXsnVuPAeX/
 h/mYzDhZl05hynE2Ce97mFe8OI+4humbqTsHH7DiVpGHmDJbJ9aSEYktg
 hFg/bPvCgOdy4PuTL2SqdB6Is4hIJkwAGSkqiYsbmaR3ZvhYwHYV2FcQj
 kBhNmGb9q2vtykNpTQp06VDc3NSUCWgdlPvimp6Gzg+rgPQVSftHo71fR
 2vuSBjcMJ/lS+BXQ+0ZFF0srXsGpDcOlsFNgXwIYJvFYDwv0QnIuSaKIJ
 BC3eqTYjvFZr3WE90fCJKf7f4DcCAuKGicKOaMZtDtDg3srqElKchDQi6 w==;
X-CSE-ConnectionGUID: PYf+FcyfQf225XPnbUUR1A==
X-CSE-MsgGUID: DklQ/zJGReKHQxMJEw+6qQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11321"; a="55281439"
X-IronPort-AV: E=Sophos;i="6.13,222,1732608000"; d="scan'208";a="55281439"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
 by orvoesa102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 21 Jan 2025 04:21:57 -0800
X-CSE-ConnectionGUID: JiH520sJQgapEubXeb+l5w==
X-CSE-MsgGUID: URxp/DCuR0af2KrowJjgZg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,224,1728975600"; d="scan'208";a="111409665"
Received: from liuzhao-optiplex-7080.sh.intel.com (HELO localhost)
 ([10.239.160.39])
 by fmviesa005.fm.intel.com with ESMTP; 21 Jan 2025 04:21:55 -0800
Date: Tue, 21 Jan 2025 20:41:17 +0800
From: Zhao Liu <zhao1.liu@intel.com>
To: Tao Su <tao1.su@linux.intel.com>
Cc: qemu-devel@nongnu.org, pbonzini@redhat.com, imammedo@redhat.com,
 xiaoyao.li@intel.com, zhao1.liu@linux.intel.com, xuelian.guo@intel.com
Subject: Re: [PATCH 2/4] target/i386: Export BHI_NO bit to guests
Message-ID: <Z4+V7e8KObBRCctM@intel.com>
References: <20250121020650.1899618-1-tao1.su@linux.intel.com>
 <20250121020650.1899618-3-tao1.su@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250121020650.1899618-3-tao1.su@linux.intel.com>
Received-SPF: pass client-ip=198.175.65.10; envelope-from=zhao1.liu@intel.com;
 helo=mgamail.intel.com
X-Spam_score_int: -73
X-Spam_score: -7.4
X-Spam_bar: -------
X-Spam_report: (-7.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-3,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_MED=-2.3, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001, SPF_HELO_NONE=0.001,
 T_SPF_TEMPERROR=0.01 autolearn=ham autolearn_force=no
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

On Tue, Jan 21, 2025 at 10:06:48AM +0800, Tao Su wrote:
> Date: Tue, 21 Jan 2025 10:06:48 +0800
> From: Tao Su <tao1.su@linux.intel.com>
> Subject: [PATCH 2/4] target/i386: Export BHI_NO bit to guests
> X-Mailer: git-send-email 2.34.1
> 
> Branch History Injection (BHI) is a CPU side-channel vulnerability, where
> an attacker may manipulate branch history before transitioning from user
> to supervisor mode or from VMX non-root/guest to root mode. CPUs that set
> BHI_NO bit in MSR IA32_ARCH_CAPABILITIES to indicate no additional
> mitigation is required to prevent BHI.
> 
> Make BHI_NO bit available to guests.
> 
> Tested-by: Xuelian Guo <xuelian.guo@intel.com>
> Signed-off-by: Tao Su <tao1.su@linux.intel.com>
> ---
>  target/i386/cpu.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 

Reviewed-by: Zhao Liu <zhao1.liu@intel.com>


