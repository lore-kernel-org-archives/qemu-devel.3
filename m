Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B555BC021BB
	for <qemu-devel@archiver.kernel.org>; Mon, 24 Feb 2025 15:05:51 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tma1J-0007j7-V8; Mon, 24 Feb 2025 10:05:21 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1tma1I-0007ik-6g; Mon, 24 Feb 2025 10:05:20 -0500
Received: from mgamail.intel.com ([192.198.163.15])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1tma1F-0002o0-TE; Mon, 24 Feb 2025 10:05:19 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1740409518; x=1771945518;
 h=date:from:to:cc:subject:message-id:references:
 mime-version:in-reply-to;
 bh=hn+d1SF1sS5LNxK/SwJAWUQQr/kYEgOjic0BVV7zukY=;
 b=YVn8JqW1LMlapQdj4Zh7zW1WF/weON7cof/6SmtmAEbvBJm9E6Do6edj
 Ibd1IPoV0oFe2k8mkr0SoWqru306FVnRLFHxVInyt3Eb3a+Rg/MeFnee6
 BAuCtHzuLy7krW4ho6TlYJBERR/3X/044DaWvUgVx6CoD8wz9+kGsQO3N
 dh/+99bzF29g89cpQwxGYdPvWpuVDuSXNM74KG/GZOTAkNZ/if7bQRVoQ
 EwU3+ZzTImDpkcrZnGACerdQEiy19uQcanNKczatVEcvw5TaThu1xJUqU
 4BFo0/B6dCa/iYuqMTnaZX+c2Hx27hcg5GBb5ydyPGaU0Bo0cpHHsYQ9F A==;
X-CSE-ConnectionGUID: prhHQkfeTzeDbrVCMtvfFQ==
X-CSE-MsgGUID: 1PJWS1BiQQqdR29U0eS4AA==
X-IronPort-AV: E=McAfee;i="6700,10204,11355"; a="41304032"
X-IronPort-AV: E=Sophos;i="6.13,309,1732608000"; d="scan'208";a="41304032"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
 by fmvoesa109.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 24 Feb 2025 07:05:14 -0800
X-CSE-ConnectionGUID: mkL8r++5S8yarANs7fjT+w==
X-CSE-MsgGUID: kMxAupz2Qw6ZtjDb9k5LzA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.13,309,1732608000"; d="scan'208";a="120995143"
Received: from liuzhao-optiplex-7080.sh.intel.com (HELO localhost)
 ([10.239.160.39])
 by orviesa003.jf.intel.com with ESMTP; 24 Feb 2025 07:05:13 -0800
Date: Mon, 24 Feb 2025 23:24:49 +0800
From: Zhao Liu <zhao1.liu@intel.com>
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: qemu-devel@nongnu.org, qemu-rust@nongnu.org
Subject: Re: [PATCH 05/15] rust: qom: get rid of ClassInitImpl
Message-ID: <Z7yPQcjfJ/nYb9hK@intel.com>
References: <20250221170342.63591-1-pbonzini@redhat.com>
 <20250221170342.63591-6-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250221170342.63591-6-pbonzini@redhat.com>
Received-SPF: pass client-ip=192.198.163.15; envelope-from=zhao1.liu@intel.com;
 helo=mgamail.intel.com
X-Spam_score_int: -47
X-Spam_score: -4.8
X-Spam_bar: ----
X-Spam_report: (-4.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.442,
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

On Fri, Feb 21, 2025 at 06:03:32PM +0100, Paolo Bonzini wrote:
> Date: Fri, 21 Feb 2025 18:03:32 +0100
> From: Paolo Bonzini <pbonzini@redhat.com>
> Subject: [PATCH 05/15] rust: qom: get rid of ClassInitImpl
> X-Mailer: git-send-email 2.48.1
> 
> Complete the conversion from the ClassInitImpl trait to class_init() methods.
> This will provide more freedom to split the qemu_api crate in separate parts.
> 
> Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
> ---
>  rust/hw/char/pl011/src/device.rs |   6 +-
>  rust/hw/timer/hpet/src/hpet.rs   |   4 +-
>  rust/qemu-api/src/qdev.rs        |  38 ++++---
>  rust/qemu-api/src/qom.rs         | 164 +++++++++++++------------------
>  rust/qemu-api/src/sysbus.rs      |  15 ++-
>  rust/qemu-api/tests/tests.rs     |   4 +-
>  6 files changed, 101 insertions(+), 130 deletions(-)

Reviewed-by: Zhao Liu <zhao1.liu@intel.com>


