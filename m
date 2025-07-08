Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 678DBC83F09
	for <qemu-devel@archiver.kernel.org>; Tue,  8 Jul 2025 21:06:57 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uZFBQ-00051M-Ev; Tue, 08 Jul 2025 16:45:00 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1uZDni-0004j4-Tk; Tue, 08 Jul 2025 15:16:27 -0400
Received: from mgamail.intel.com ([192.198.163.17])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1uZDnd-0007GK-PL; Tue, 08 Jul 2025 15:16:22 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1752002178; x=1783538178;
 h=date:from:to:cc:subject:message-id:references:
 mime-version:in-reply-to;
 bh=N/B0waXGR1+AYWDTmdwJXCaIX7SFi98IDWZXromxe4M=;
 b=n26F9xu8DyS+CxOOyhDSsAjuwfsMTMPBC1zbyqTqPziMZTJW7ctuAl7V
 PFE5W/ukKOzvB23i1k7RbK7H7q4iznSX+nv2um0sWrgqGdytSl3gdnaJ1
 HvISj6QAMe/8uK2l7UCdEgxcgtwDXrdL8gsRfAi2fO/E8GNYVJBN3/jhK
 WkwA5RSLUv5XnoXZf4UojK1ihn/4bXJmPBHkRPspuc7WH6Mf5JPNiHTtT
 uw6GborPYda+hxUqQ/MW2fEuydgI7yZNxaRDLIt4VoYLmVRchm9j2j9Sk
 TEeAGaRtd1nIElgOZSli41RhMUfwZKRJ0bwGakU5v9bjnYtCXTWTza5F+ Q==;
X-CSE-ConnectionGUID: GmTTY8gPTU20OylbhJdeIg==
X-CSE-MsgGUID: K4ViRzgISZmplRFVc/EJvQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11487"; a="54121445"
X-IronPort-AV: E=Sophos;i="6.16,296,1744095600"; d="scan'208";a="54121445"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
 by fmvoesa111.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 08 Jul 2025 01:21:09 -0700
X-CSE-ConnectionGUID: TO26K1+JQsie8pMIyl+emQ==
X-CSE-MsgGUID: eJEkqlUhTzevZsldzYR0lg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,296,1744095600"; d="scan'208";a="159704654"
Received: from liuzhao-optiplex-7080.sh.intel.com (HELO localhost)
 ([10.239.160.39])
 by fmviesa005.fm.intel.com with ESMTP; 08 Jul 2025 01:21:08 -0700
Date: Tue, 8 Jul 2025 16:42:35 +0800
From: Zhao Liu <zhao1.liu@intel.com>
To: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>
Cc: qemu-devel@nongnu.org, qemu-rust@nongnu.org,
 Paolo Bonzini <pbonzini@redhat.com>
Subject: Re: [PATCH 3/3] rust: add *_with_attrs methods to MemoryRegionOps
Message-ID: <aGzZ+yue4jbvxLxo@intel.com>
References: <20250703-rust-mem-api-v1-0-cd5314bdf580@linaro.org>
 <20250703-rust-mem-api-v1-3-cd5314bdf580@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250703-rust-mem-api-v1-3-cd5314bdf580@linaro.org>
Received-SPF: pass client-ip=192.198.163.17; envelope-from=zhao1.liu@intel.com;
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

On Thu, Jul 03, 2025 at 04:58:13PM +0300, Manos Pitsidianakis wrote:
> Date: Thu, 03 Jul 2025 16:58:13 +0300
> From: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>
> Subject: [PATCH 3/3] rust: add *_with_attrs methods to MemoryRegionOps
> X-Mailer: b4 0.14.2
> 
> MemoryRegionOps (and its builder type) only support read/write
> callbacks.
> 
> Add the ability to define {read,write}_with_attrs callbacks for devices
> that need them.
> 
> Signed-off-by: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>
> ---
>  rust/qemu-api/meson.build   |  1 +
>  rust/qemu-api/src/memory.rs | 52 ++++++++++++++++++++++++++++++++++++++++++++-
>  2 files changed, 52 insertions(+), 1 deletion(-)

Fine for me,

Reviewed-by: Zhao Liu <zhao1.liu@intel.com>


