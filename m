Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 82800E77187
	for <qemu-devel@archiver.kernel.org>; Wed, 18 Dec 2024 15:01:34 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tNvXp-0001I0-OK; Wed, 18 Dec 2024 10:01:01 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1tNvXX-0001Ak-W9
 for qemu-devel@nongnu.org; Wed, 18 Dec 2024 10:00:46 -0500
Received: from mgamail.intel.com ([198.175.65.12])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1tNvXV-0006TU-Tg
 for qemu-devel@nongnu.org; Wed, 18 Dec 2024 10:00:43 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1734534042; x=1766070042;
 h=date:from:to:cc:subject:message-id:references:
 mime-version:in-reply-to;
 bh=gU1wcuNxzoR0iDze/5LwFb4r6HeYjGhk7ReuMp6aa6w=;
 b=IQjZVEIffLvBT0tC2Q8WZYOrAg18JzVLnEFkA1RdzT/EVHnQf6kXFW8m
 PQ1rzqzoMWKYKIOxMDotwyUvvX1yDGCdq1qCGcUvCWCEdLFkY+liT3rph
 EuurSTTf5szEezD2rMMsdWHh107lCbExUJ09s3tw2YXc9VLb69F6k/k8x
 3RoMFiKMB0fU5qzEG1ZtzF+TdxMNlsVu9KGgpq/SONJyTlO6bIU1Wf2fC
 MfmUtbTlMASUsSyFBGKwZjUlSW+lV1Ny2mhOGxnqz91HEWa/1rfbMfFlx
 7VN0eeHItNzjhT2Teo2gsei9sKUhDrIWV4dtV48+I8ow+7q+JRK9RvbJ8 A==;
X-CSE-ConnectionGUID: 1WK3ozT/SxenoHOWbXVpxQ==
X-CSE-MsgGUID: GRGz8JElQp+4NvGMw7Lg6A==
X-IronPort-AV: E=McAfee;i="6700,10204,11290"; a="46402271"
X-IronPort-AV: E=Sophos;i="6.12,244,1728975600"; d="scan'208";a="46402271"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
 by orvoesa104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 18 Dec 2024 07:00:39 -0800
X-CSE-ConnectionGUID: TJ9Fq0BMQGilvjUe7PifNw==
X-CSE-MsgGUID: M8hmWQNVTKaBu2KPsz4FBw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,244,1728975600"; d="scan'208";a="97952845"
Received: from liuzhao-optiplex-7080.sh.intel.com (HELO localhost)
 ([10.239.160.39])
 by orviesa006.jf.intel.com with ESMTP; 18 Dec 2024 07:00:38 -0800
Date: Wed, 18 Dec 2024 23:19:17 +0800
From: Zhao Liu <zhao1.liu@intel.com>
To: Richard Henderson <richard.henderson@linaro.org>
Cc: qemu-devel@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>
Subject: Re: [PATCH 04/71] target/i386: Constify all Property
Message-ID: <Z2Ln9Q/OTIcUjKLb@intel.com>
References: <20241213190750.2513964-1-richard.henderson@linaro.org>
 <20241213190750.2513964-8-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241213190750.2513964-8-richard.henderson@linaro.org>
Received-SPF: pass client-ip=198.175.65.12; envelope-from=zhao1.liu@intel.com;
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

On Fri, Dec 13, 2024 at 01:06:37PM -0600, Richard Henderson wrote:
> Date: Fri, 13 Dec 2024 13:06:37 -0600
> From: Richard Henderson <richard.henderson@linaro.org>
> Subject: [PATCH 04/71] target/i386: Constify all Property
> X-Mailer: git-send-email 2.43.0
> 
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>  target/i386/cpu.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 

Reviewed-by: Zhao Liu <zhao1.liu@intel.com>


