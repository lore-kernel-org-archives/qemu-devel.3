Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8877AC624D0
	for <qemu-devel@archiver.kernel.org>; Wed,  2 Sep 2026 12:39:15 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x1kEX-00028L-1i; Wed, 02 Sep 2026 08:38:29 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1x1kEV-000285-SI
 for qemu-devel@nongnu.org; Wed, 02 Sep 2026 08:38:27 -0400
Received: from mgamail.intel.com ([192.198.163.15])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1x1kET-0007DN-KX
 for qemu-devel@nongnu.org; Wed, 02 Sep 2026 08:38:27 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1788352705; x=1819888705;
 h=date:from:to:cc:subject:message-id:references:
 mime-version:in-reply-to;
 bh=VYTDI0Cbmrk40gL72Y5WMRcp2ljGL2Rq1jc5jYQa2yA=;
 b=dGi2y9/MgNsuxCXi6M7vHr7d3PiJOEOfpO853dUUrwv1DuIlQ1iYIljD
 2czxp0UgS/VUFw+quTJhdmkGmoG7YA87GRsOoNUsHIhiH7n9l8FNGpbYA
 arDXDJAPUuB+hjM1FQWdEmTvkb8N9NOmEanGvVOXCyFHHb5vmvPS+e5dZ
 bAiWkPToroDyzYROT8vw5z7ymnA1VNADIKDmlHKcx7OojZ/7RKl9Dg4Vj
 ZCK/dwx3HYsyGqvG8NRCxYTCVtpsg8mXlGo++gLv5Y4llXcFHj7kx+Pz9
 WlhBIe0WlSAWBPStO0mVPaM4OwuMr+rknspngkL0v235o1+lb2DFFsF+3 w==;
X-CSE-ConnectionGUID: fXYJrHLqQ++fm8NLsmLmxA==
X-CSE-MsgGUID: 6h6iiHwqTKa9eK4BM8rm9Q==
X-IronPort-AV: E=McAfee;i="6800,10657,11893"; a="88932704"
X-IronPort-AV: E=Sophos;i="6.25,257,1779174000"; d="scan'208";a="88932704"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
 by fmvoesa109.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 02 Sep 2026 05:38:21 -0700
X-CSE-ConnectionGUID: 2wFWxBQ1SpSqPCJVQ6KEkw==
X-CSE-MsgGUID: 2F9VIYSjRnSF66kKwCJi+Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,257,1779174000"; d="scan'208";a="266789249"
Received: from zhaoliu1-desk.sh.intel.com (HELO localhost) ([10.238.208.118])
 by fmviesa008.fm.intel.com with ESMTP; 02 Sep 2026 05:38:20 -0700
Date: Wed, 2 Sep 2026 20:38:19 +0800
From: Zhao Liu <zhao1.liu@intel.com>
To: Ewan Hai-oc <ewanhai-oc@zhaoxin.com>
Cc: qemu-devel@nongnu.org, pbonzini@redhat.com, ewanhai@zhaoxin.com,
 cobechen@zhaoxin.com
Subject: Re: [PATCH v4 2/4] target/i386: Add Zhaoxin cryptographic CPUID
 features
Message-ID: <apgYu+CPOLjrx5G0@intel.com>
References: <20260826084838.2107629-1-ewanhai-oc@zhaoxin.com>
 <20260826084838.2107629-3-ewanhai-oc@zhaoxin.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260826084838.2107629-3-ewanhai-oc@zhaoxin.com>
Received-SPF: pass client-ip=192.198.163.15; envelope-from=zhao1.liu@intel.com;
 helo=mgamail.intel.com
X-Spam_score_int: -43
X-Spam_score: -4.4
X-Spam_bar: ----
X-Spam_report: (-4.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_MED=-2.3, SPF_HELO_NONE=0.001,
 SPF_NONE=0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

On Wed, Aug 26, 2026 at 04:48:36PM +0800, Ewan Hai-oc wrote:
> Date: Wed, 26 Aug 2026 16:48:36 +0800
> From: Ewan Hai-oc <ewanhai-oc@zhaoxin.com>
> Subject: [PATCH v4 2/4] target/i386: Add Zhaoxin cryptographic CPUID
>  features
> X-Mailer: git-send-email 2.34.1
> 
> Add QEMU feature names and masks for the SM2, CCS, RNG2, PHE2 and RSA
> feature pairs in CPUID 0xC0000001 EDX. The matching KVM support exposes
> these bits through KVM_GET_SUPPORTED_CPUID.
> 
> TCG does not currently implement these instructions. Keep
> TCG_EXT4_FEATURES at zero so QEMU filters the bits from realized TCG
> CPUs.
> 
> Link: https://lore.kernel.org/all/20260610023512.3690734-1-ewanhai-oc@zhaoxin.com/
> Signed-off-by: Ewan Hai <ewanhai-oc@zhaoxin.com>
> ---
>  target/i386/cpu.c | 10 +++++-----
>  target/i386/cpu.h | 20 ++++++++++++++++++++
>  2 files changed, 25 insertions(+), 5 deletions(-)

Reviewed-by: Zhao Liu <zhao1.liu@intel.com>


