Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 97415C021B3
	for <qemu-devel@archiver.kernel.org>; Thu, 20 Feb 2025 11:53:14 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tl56S-000198-MT; Thu, 20 Feb 2025 06:52:28 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1tl56Q-00018Z-Ut
 for qemu-devel@nongnu.org; Thu, 20 Feb 2025 06:52:26 -0500
Received: from mgamail.intel.com ([192.198.163.7])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1tl56O-0002z3-Qa
 for qemu-devel@nongnu.org; Thu, 20 Feb 2025 06:52:26 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1740052345; x=1771588345;
 h=date:from:to:cc:subject:message-id:references:
 mime-version:in-reply-to;
 bh=fla4TsChoauH/FZHbft2/awrwcbSsmH9YvqhF93NDck=;
 b=mlwdqkrvovFUq85wSN8s8827wAq3AFGwbx6KrF5q/c8P84mWkRU0rzEX
 FxoFCuuMFrBLZyXucGnAsRfmyTbOYFy5ai1sBX0OCnY/JtCcZgjGeWSft
 cTqane5mnQSybX83+YotRJJ2k2A3nL1/DTXvwYhtGGQMDjZSlLeIWq6Sd
 R4AAsBz3EGAJ1OF1HX035CHX87E4lJkFfZKv+D/2bJD4ww+0fESMSH/rz
 IBqei2GYwHkJksPTl8x3eNRcoctiQCRqL1LAtxfHBlbVldcP8ObzJp2eb
 ACR6Q5pH1uNYfKyypKbjn+0c6Tdvb2jSTkQIKkAGKFX9Iii5Zjhy1Rk4y A==;
X-CSE-ConnectionGUID: A8D1+r/cTcagzQZ4X4COYA==
X-CSE-MsgGUID: G87aNCxPSmO2MZ1NWApdyg==
X-IronPort-AV: E=McAfee;i="6700,10204,11350"; a="66184858"
X-IronPort-AV: E=Sophos;i="6.13,301,1732608000"; d="scan'208";a="66184858"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
 by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 20 Feb 2025 03:52:21 -0800
X-CSE-ConnectionGUID: A0Leyr2BTzuvfTBz+ciupQ==
X-CSE-MsgGUID: gwEu5mGZQcSCfMOZta6ZEA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,224,1728975600"; d="scan'208";a="114872142"
Received: from liuzhao-optiplex-7080.sh.intel.com (HELO localhost)
 ([10.239.160.39])
 by orviesa010.jf.intel.com with ESMTP; 20 Feb 2025 03:52:20 -0800
Date: Thu, 20 Feb 2025 20:11:54 +0800
From: Zhao Liu <zhao1.liu@intel.com>
To: Babu Moger <babu.moger@amd.com>
Cc: pbonzini@redhat.com, qemu-devel@nongnu.org, kvm@vger.kernel.org,
 davydov-max@yandex-team.ru
Subject: Re: [PATCH v5 6/6] target/i386: Add support for EPYC-Turin model
Message-ID: <Z7ccCtbPPuRRdGUN@intel.com>
References: <cover.1738869208.git.babu.moger@amd.com>
 <3d918a6327885d867f89aa2ae4b4a19f0d5fb074.1738869208.git.babu.moger@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3d918a6327885d867f89aa2ae4b4a19f0d5fb074.1738869208.git.babu.moger@amd.com>
Received-SPF: pass client-ip=192.198.163.7; envelope-from=zhao1.liu@intel.com;
 helo=mgamail.intel.com
X-Spam_score_int: -48
X-Spam_score: -4.9
X-Spam_bar: ----
X-Spam_report: (-4.9 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.457,
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

> +static const CPUCaches epyc_turin_cache_info = {
> +    .l1d_cache = &(CPUCacheInfo) {
> +        .type = DATA_CACHE,
> +        .level = 1,
> +        .size = 48 * KiB,
> +        .line_size = 64,
> +        .associativity = 12,
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

(And it would be better to add a Turin entry in docs/system/cpu-models-x86.rst.inc
later :-).)

Thanks,
Zhao



