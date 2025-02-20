Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6FC3FC021B1
	for <qemu-devel@archiver.kernel.org>; Thu, 20 Feb 2025 11:07:35 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tl4Oi-0004TU-KS; Thu, 20 Feb 2025 06:07:22 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1tl4OR-0004LD-29
 for qemu-devel@nongnu.org; Thu, 20 Feb 2025 06:06:59 -0500
Received: from mgamail.intel.com ([198.175.65.18])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1tl4ON-0002tp-Ei
 for qemu-devel@nongnu.org; Thu, 20 Feb 2025 06:06:58 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1740049616; x=1771585616;
 h=date:from:to:cc:subject:message-id:references:
 mime-version:in-reply-to;
 bh=ajeAZBlPYk2/mVr6+dIxx2jF+Qx8akOXbX7dEAQPtyY=;
 b=eVCas2dq5bxBxFXlTFHXHBTYVaidh+RWzgAQ7/sj0dVdL6Y8yvnID1cJ
 B/uPRr7A+rkhWxaAwKYnCM1mMh5AoexW63wNcEM5ojVGzj0rVylYdbSaF
 0XGw9I+hAdANbcIjbA4t7OEO4Bw0I5KcDSrr4tHHQGgdiXQDoqFk0611C
 JOH/mcL95dg8viN01wvknQnhzYSv5YuCOuAXH9Y4B5rq0KymX6T7Nxnpe
 6o3LhKg6Me3tjXyBwrQo7+tRf7Qaaf9CdCe81UmYMv6n583ztKKLbm4Ze
 LATbCfsGVmFp5UNpRmM7w277AIV4QMNeXXTZs3p5Lcoey42qq1t6VGXoE w==;
X-CSE-ConnectionGUID: AYEJ7UJDRvuDhi2EXVQmLA==
X-CSE-MsgGUID: DkTV8VYjRXu0pqY/uuSpcQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11314"; a="41027807"
X-IronPort-AV: E=Sophos;i="6.12,310,1728975600"; d="scan'208";a="41027807"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
 by orvoesa110.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 20 Feb 2025 03:06:52 -0800
X-CSE-ConnectionGUID: 1RVwLXHETwqFtWo0m7PmjQ==
X-CSE-MsgGUID: Z5ptAAJuSYa5jaFwSbyzTA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.13,301,1732608000"; d="scan'208";a="114989214"
Received: from liuzhao-optiplex-7080.sh.intel.com (HELO localhost)
 ([10.239.160.39])
 by fmviesa007.fm.intel.com with ESMTP; 20 Feb 2025 03:06:50 -0800
Date: Thu, 20 Feb 2025 19:26:25 +0800
From: Zhao Liu <zhao1.liu@intel.com>
To: Babu Moger <babu.moger@amd.com>
Cc: pbonzini@redhat.com, qemu-devel@nongnu.org, kvm@vger.kernel.org,
 davydov-max@yandex-team.ru
Subject: Re: [PATCH v5 3/6] target/i386: Update EPYC-Milan CPU model for
 Cache property, RAS, SVM feature bits
Message-ID: <Z7cRYbhxviv1wNyD@intel.com>
References: <cover.1738869208.git.babu.moger@amd.com>
 <e1aeb2a8d03cd47da7b9684183df06ec73136f87.1738869208.git.babu.moger@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <e1aeb2a8d03cd47da7b9684183df06ec73136f87.1738869208.git.babu.moger@amd.com>
Received-SPF: pass client-ip=198.175.65.18; envelope-from=zhao1.liu@intel.com;
 helo=mgamail.intel.com
X-Spam_score_int: -45
X-Spam_score: -4.6
X-Spam_bar: ----
X-Spam_report: (-4.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.191,
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

> +static const CPUCaches epyc_milan_v3_cache_info = {
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


