Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1E479C5B543
	for <qemu-devel@archiver.kernel.org>; Wed,  4 Jun 2025 10:16:10 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uMl9z-0000lw-OW; Wed, 04 Jun 2025 06:15:51 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1uMl9v-0000hx-Hd
 for qemu-devel@nongnu.org; Wed, 04 Jun 2025 06:15:49 -0400
Received: from mgamail.intel.com ([192.198.163.7])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1uMl9t-0004bw-2T
 for qemu-devel@nongnu.org; Wed, 04 Jun 2025 06:15:46 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1749032145; x=1780568145;
 h=date:from:to:cc:subject:message-id:references:
 mime-version:in-reply-to;
 bh=2RdfKTnWP8tzglJrgzc8owlLYeWp1Q5Ocy4HZjK7H20=;
 b=mYLFq6Q2lUKFJTYFDK9GrZGUSfe+m0+BEtJHMltPhQH9yvAICzRw14mk
 kdTPetGHIDc07xs1ZZdqsJ4ozTg1ckfqpuV4VlG7pWETTuczfjx60y1vu
 T45cPdnQS4FLFHVvLiun6jLnP1PSxnJU6d5bXVM08kO3EshT/4I1fAQIv
 Yfx4DbvGJfAWFGDqpYZwkUqAkHSrKEe+ViN7gHlv5dT/yCIIH7dZS1Pjw
 7ucMc9N3cHznaS+DduErHiEiNExjBVZU/VwqqY9+TssN9koaDt1iY4vxs
 bFC/e9HPg0j7cpBf+6yogR2Js6ZkefUEQ9ZXyQNtstUq8X7b9TCCtih1x A==;
X-CSE-ConnectionGUID: XFMsu9OSTtWoZ4VM9MBwdg==
X-CSE-MsgGUID: sD1lZFZET2uQybUYCK8MTA==
X-IronPort-AV: E=McAfee;i="6700,10204,11453"; a="76491369"
X-IronPort-AV: E=Sophos;i="6.16,208,1744095600"; d="scan'208";a="76491369"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
 by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 04 Jun 2025 03:15:43 -0700
X-CSE-ConnectionGUID: yXw3aVNLTNG8/bZeGbso2Q==
X-CSE-MsgGUID: n0+l91kBSSKQ4OPjG5lRtA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,208,1744095600"; d="scan'208";a="145109216"
Received: from liuzhao-optiplex-7080.sh.intel.com (HELO localhost)
 ([10.239.160.39])
 by fmviesa007.fm.intel.com with ESMTP; 04 Jun 2025 03:15:41 -0700
Date: Wed, 4 Jun 2025 18:36:55 +0800
From: Zhao Liu <zhao1.liu@intel.com>
To: Xiaoyao Li <xiaoyao.li@intel.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>, Igor Mammedov <imammedo@redhat.com>,
 Daniel P =?iso-8859-1?Q?=2E_Berrang=E9?= <berrange@redhat.com>,
 qemu-devel@nongnu.org
Subject: Re: [PATCH 2/3] i386/tdx: Fix the typo of the comment of struct
 TdxGuest
Message-ID: <aEAhx93WzqBle54a@intel.com>
References: <20250603050305.1704586-1-xiaoyao.li@intel.com>
 <20250603050305.1704586-3-xiaoyao.li@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250603050305.1704586-3-xiaoyao.li@intel.com>
Received-SPF: pass client-ip=192.198.163.7; envelope-from=zhao1.liu@intel.com;
 helo=mgamail.intel.com
X-Spam_score_int: -44
X-Spam_score: -4.5
X-Spam_bar: ----
X-Spam_report: (-4.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.128,
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

On Tue, Jun 03, 2025 at 01:03:04AM -0400, Xiaoyao Li wrote:
> Date: Tue,  3 Jun 2025 01:03:04 -0400
> From: Xiaoyao Li <xiaoyao.li@intel.com>
> Subject: [PATCH 2/3] i386/tdx: Fix the typo of the comment of struct
>  TdxGuest
> X-Mailer: git-send-email 2.43.0
> 
> Change sha348 to sha384.
> 
> Signed-off-by: Xiaoyao Li <xiaoyao.li@intel.com>
> ---
>  target/i386/kvm/tdx.h | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)

Reviewed-by: Zhao Liu <zhao1.liu@intel.com>


