Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BC9A6C282DE
	for <qemu-devel@archiver.kernel.org>; Thu,  6 Mar 2025 15:33:41 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tqDDV-0000JU-3b; Thu, 06 Mar 2025 10:32:57 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1tqDDO-0000HS-I1
 for qemu-devel@nongnu.org; Thu, 06 Mar 2025 10:32:51 -0500
Received: from mgamail.intel.com ([192.198.163.12])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1tqDDG-00047F-Mt
 for qemu-devel@nongnu.org; Thu, 06 Mar 2025 10:32:50 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1741275163; x=1772811163;
 h=date:from:to:cc:subject:message-id:references:
 mime-version:in-reply-to;
 bh=8IbWBk90gCRP+4kQBU6NytfndqycKjzSCYZCFDwIvzI=;
 b=Q9Ari9YTER9sJF7gQWoZV9GD6zcNLiuqh1fHTCXdazzIDkZBvU/6oZGL
 ktQIyMSp+ZJ+tUtnnaKdUyy3C/pRzj4WQ/iQtw4X2h8dvXictaaio398j
 48RM/o21vfvHdYS94TRS2+4HYkvJryAdcHPCjN0HbW57ntQDudrLm7/Xh
 keCM5NQwFhZ9R1N1i0J0LaHYHuYtJAxc/R9qV4Pns5ed5FrbNKYLzSfE9
 D5TlwSUtr8v/QPToXMBGzhpfUhQCYh+8v5BosAWpDdass+GOhx4HUqq3c
 p7+wAlSnv/LSh4xF54zX0DsBMia/CNJXcmDQdyuaspq3aot7Mj0dJns55 Q==;
X-CSE-ConnectionGUID: kbP7Oo02TdG5ZP+9iNi2OQ==
X-CSE-MsgGUID: 8S7Ro3KsTxe2OfLb6k76LQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11365"; a="46216709"
X-IronPort-AV: E=Sophos;i="6.14,226,1736841600"; d="scan'208";a="46216709"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
 by fmvoesa106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 06 Mar 2025 07:32:40 -0800
X-CSE-ConnectionGUID: 5e1WRCINQz+Eb3Ku2t+MYw==
X-CSE-MsgGUID: nniOMBtUR3qHebqNAmJK6w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.14,226,1736841600"; d="scan'208";a="124000026"
Received: from liuzhao-optiplex-7080.sh.intel.com (HELO localhost)
 ([10.239.160.39])
 by orviesa003.jf.intel.com with ESMTP; 06 Mar 2025 07:32:38 -0800
Date: Thu, 6 Mar 2025 23:52:46 +0800
From: Zhao Liu <zhao1.liu@intel.com>
To: Xiaoyao Li <xiaoyao.li@intel.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>, qemu-devel@nongnu.org,
 Dongli Zhang <dongli.zhang@oracle.com>
Subject: Re: [PATCH 2/2] i386/cpu: Warn about why CPUID_EXT_PDCM is not
 available
Message-ID: <Z8nEzq+P7HlcxM1W@intel.com>
References: <20250304052450.465445-1-xiaoyao.li@intel.com>
 <20250304052450.465445-3-xiaoyao.li@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250304052450.465445-3-xiaoyao.li@intel.com>
Received-SPF: pass client-ip=192.198.163.12; envelope-from=zhao1.liu@intel.com;
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

On Tue, Mar 04, 2025 at 12:24:50AM -0500, Xiaoyao Li wrote:
> Date: Tue, 4 Mar 2025 00:24:50 -0500
> From: Xiaoyao Li <xiaoyao.li@intel.com>
> Subject: [PATCH 2/2] i386/cpu: Warn about why CPUID_EXT_PDCM is not
>  available
> X-Mailer: git-send-email 2.34.1
> 
> When user requests PDCM explicitly via "+pdcm" without PMU enabled, emit
> a warning to inform the user.
> 
> Signed-off-by: Xiaoyao Li <xiaoyao.li@intel.com>
> ---
>  target/i386/cpu.c | 3 +++
>  1 file changed, 3 insertions(+)

Reviewed-by: Zhao Liu <zhao1.liu@intel.com>


