Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5883EC021B2
	for <qemu-devel@archiver.kernel.org>; Thu, 20 Feb 2025 11:46:15 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tl4zx-0007mn-T0; Thu, 20 Feb 2025 06:45:45 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1tl4zu-0007mL-Nx
 for qemu-devel@nongnu.org; Thu, 20 Feb 2025 06:45:44 -0500
Received: from mgamail.intel.com ([198.175.65.15])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1tl4zs-0001wC-PP
 for qemu-devel@nongnu.org; Thu, 20 Feb 2025 06:45:42 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1740051941; x=1771587941;
 h=date:from:to:cc:subject:message-id:references:
 mime-version:in-reply-to;
 bh=Yrzr6RlKTrfVfuylJCFKjN7TwC2IIN9gmHbRTx+OEfk=;
 b=aPbqoU/yGFTeFei+PT7CjTttG/aAB42Y9uOBlTMudHvEDRlAylNJL0XV
 0/xVLuUXe3xK5NJhmHJ7UZyn+aJj8lydV5inyQ33c9/nhsbAMI7Y6acuH
 2QRJ7Jc5+I8iTsbNfyue4leCmUbHcWvARuE5lxFSK+95OzAhTHMS63HCH
 PlFmzaPd8AvBZqDrXkRMHwnKui+Oooe7kH+oNP/CS3PWQrg9i+MerXhMU
 CVm4+twvgE4N5tZ8D1N6WlAh8C1VDgpF24ch30HGB+Ub9iNekaYD7TN0d
 EnZ/sE10RS+uhsnJLJBacI8eiRgXxhElUbo/rV3wG+hoj2HmBV66N4MBC w==;
X-CSE-ConnectionGUID: fDge5J2SSRi8k8w13mzoRA==
X-CSE-MsgGUID: h04EefEhTlCE1HPvFy8Pmg==
X-IronPort-AV: E=McAfee;i="6700,10204,11350"; a="44474593"
X-IronPort-AV: E=Sophos;i="6.13,301,1732608000"; d="scan'208";a="44474593"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
 by orvoesa107.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 20 Feb 2025 03:45:37 -0800
X-CSE-ConnectionGUID: sQ5KWKyHSfm7Xasg2I/RmA==
X-CSE-MsgGUID: 4zLxPxTbTM2sIWbZgSx64w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,224,1728975600"; d="scan'208";a="119116496"
Received: from liuzhao-optiplex-7080.sh.intel.com (HELO localhost)
 ([10.239.160.39])
 by fmviesa003.fm.intel.com with ESMTP; 20 Feb 2025 03:45:36 -0800
Date: Thu, 20 Feb 2025 20:05:11 +0800
From: Zhao Liu <zhao1.liu@intel.com>
To: Babu Moger <babu.moger@amd.com>
Cc: pbonzini@redhat.com, qemu-devel@nongnu.org, kvm@vger.kernel.org,
 davydov-max@yandex-team.ru
Subject: Re: [PATCH v5 5/6] target/i386: Update EPYC-Genoa for Cache
 property, perfmon-v2, RAS and SVM feature bits
Message-ID: <Z7cad1GabzGG1pAp@intel.com>
References: <cover.1738869208.git.babu.moger@amd.com>
 <ded4e65f9c9109f0863d1a00888b1ba48fab1549.1738869208.git.babu.moger@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ded4e65f9c9109f0863d1a00888b1ba48fab1549.1738869208.git.babu.moger@amd.com>
Received-SPF: pass client-ip=198.175.65.15; envelope-from=zhao1.liu@intel.com;
 helo=mgamail.intel.com
X-Spam_score_int: -48
X-Spam_score: -4.9
X-Spam_bar: ----
X-Spam_report: (-4.9 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.457,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_MED=-2.3, RCVD_IN_MSPIKE_H2=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

> +static const CPUCaches epyc_genoa_v2_cache_info = {
> +    .l1d_cache = &(CPUCacheInfo) {
> +        .type = DATA_CACHE,
> +        .level = 1,
> +        .size = 32 * KiB,
> +        .line_size = 64,
> +        .associativity = 8,
> +        .partitions = 1,
> +        .sets = 64,
> +        .lines_per_tag = 1,
> +        .self_init = 1,

true.

> +        .share_level = CPU_TOPOLOGY_LEVEL_CORE,
> +    },
> +    .l1i_cache = &(CPUCacheInfo) {
> +        .type = INSTRUCTION_CACHE,
> +        .level = 1,
> +        .size = 32 * KiB,
> +        .line_size = 64,
> +        .associativity = 8,
> +        .partitions = 1,
> +        .sets = 64,
> +        .lines_per_tag = 1,
> +        .self_init = 1,

true.

Reviewed-by: Zhao Liu <zhao1.liu@intel.com>


