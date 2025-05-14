Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C250CC3ABC5
	for <qemu-devel@archiver.kernel.org>; Wed, 14 May 2025 05:19:43 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uF4WQ-0006Au-Pv; Wed, 14 May 2025 01:19:14 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1uF4WO-0006AN-TO; Wed, 14 May 2025 01:19:12 -0400
Received: from mgamail.intel.com ([198.175.65.18])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1uF4WN-0008Ru-3u; Wed, 14 May 2025 01:19:12 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1747199951; x=1778735951;
 h=date:from:to:cc:subject:message-id:references:
 mime-version:in-reply-to;
 bh=6zomk3sFt4QtvNq57+RYkY3xRlT29j5oGWLO4m5y1tA=;
 b=HytES9t3dTy0fCDNA+OFrVll+8xtLBleWkKAUrhoutgDv7GJ+FNzr7va
 zUdx9WVhjbsAdO+Vw3NBNzjBLVXBIlVpf5ApUI/0ikx8Fzvxl1vt8E6Ap
 Zwa7nVg10iPX/4HgUeNyw85mibKAgijSKGJgCrw1hN1FJjuQRS8ze9fhi
 8dfHOpnYIaHgr9eEzUS9O4q7LMhYBxDyAhocqRwiTRfAqVjDbG4jaTvNG
 dqMl5Y9K9GwPGihtWiLdfl/lAsM8aNF8rwQ/xAHsIJlwGS1JfMsuX/eSK
 Vynbe/Ifxyzzqrry/cibryLQvKrIMgkutgS5y03GV9CCfF32kA0K81H+o g==;
X-CSE-ConnectionGUID: 2padfDf5ShuX5Be77AWKyg==
X-CSE-MsgGUID: g4t4FF7jSvGZ/uYHWoRyDw==
X-IronPort-AV: E=McAfee;i="6700,10204,11432"; a="49240908"
X-IronPort-AV: E=Sophos;i="6.15,287,1739865600"; d="scan'208";a="49240908"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
 by orvoesa110.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 13 May 2025 22:19:06 -0700
X-CSE-ConnectionGUID: B0lnw62MTW6aAlML4DjK7A==
X-CSE-MsgGUID: OTZ3NEphTxiim+bi69aV7w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,287,1739865600"; d="scan'208";a="138452853"
Received: from liuzhao-optiplex-7080.sh.intel.com (HELO localhost)
 ([10.239.160.39])
 by orviesa007.jf.intel.com with ESMTP; 13 May 2025 22:19:06 -0700
Date: Wed, 14 May 2025 13:40:09 +0800
From: Zhao Liu <zhao1.liu@intel.com>
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: qemu-devel@nongnu.org, qemu-rust@nongnu.org
Subject: Re: [PATCH] rust: hpet: rename hpet module to "device"
Message-ID: <aCQsuYde31M+L+b6@intel.com>
References: <20250514035405.295861-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250514035405.295861-1-pbonzini@redhat.com>
Received-SPF: pass client-ip=198.175.65.18; envelope-from=zhao1.liu@intel.com;
 helo=mgamail.intel.com
X-Spam_score_int: -58
X-Spam_score: -5.9
X-Spam_bar: -----
X-Spam_report: (-5.9 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.549,
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

On Wed, May 14, 2025 at 05:54:05AM +0200, Paolo Bonzini wrote:
> Date: Wed, 14 May 2025 05:54:05 +0200
> From: Paolo Bonzini <pbonzini@redhat.com>
> Subject: [PATCH] rust: hpet: rename hpet module to "device"
> X-Mailer: git-send-email 2.49.0
> 
> Follow a similar convention as pl011.
> 
> Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
> ---
>  rust/hw/timer/hpet/src/{hpet.rs => device.rs} | 0
>  rust/hw/timer/hpet/src/lib.rs                 | 2 +-
>  2 files changed, 1 insertion(+), 1 deletion(-)
>  rename rust/hw/timer/hpet/src/{hpet.rs => device.rs} (100%)

Reviewed-by: Zhao Liu <zhao1.liu@intel.com>


