Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F4053CAC5BB
	for <qemu-devel@archiver.kernel.org>; Wed,  8 Oct 2025 16:04:57 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v6WeI-0003sw-NJ; Wed, 08 Oct 2025 12:04:18 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1v6We6-0003mU-Hq; Wed, 08 Oct 2025 12:04:07 -0400
Received: from mgamail.intel.com ([198.175.65.10])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1v6WdO-0002YB-DI; Wed, 08 Oct 2025 12:04:06 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1759939402; x=1791475402;
 h=date:from:to:cc:subject:message-id:references:
 mime-version:content-transfer-encoding:in-reply-to;
 bh=e55a8QXCQGSYqbY/djQCfDfsHqvtC7EocpTiLBH3zI8=;
 b=lVseb1qxq5FKKsHzaOyAas+7rG7he0vtvoyCRuIEH2NcplV9N5Gsbdy5
 g+4XwJefKcAwJvrTWQX+uJPtvhtbxkguSyVDBiXVRlnVsyjSV8V0MeQYY
 9esrc83x6s+Tqak2QywWK79grb5FiYAHVuGkBhXzMN2U3fCG66Ms7/p9Y
 Ke2o0GC3TWvX5A99VckDO8cKND6tC+F8n9MJwBiXVdS2jf+okABXyUVP2
 tJ99QYyUEuDD59hDc9rD88eCDJkVkH0FdRGfA4Y8ZZClxz68eP4tBNDc3
 HqPWmfB/27XWTrNZo9xxNpKvuc1NR2eUiY3WeF3povMXdeyS2GVLwLjVZ g==;
X-CSE-ConnectionGUID: YSOcSwYCTtGUUDl9Cw/0CA==
X-CSE-MsgGUID: p9vvBNSsT+OIpD3hu9/uXA==
X-IronPort-AV: E=McAfee;i="6800,10657,11576"; a="79575313"
X-IronPort-AV: E=Sophos;i="6.19,213,1754982000"; d="scan'208";a="79575313"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
 by orvoesa102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 08 Oct 2025 09:03:05 -0700
X-CSE-ConnectionGUID: 7IzIit4qTxCpOSXBMBV8jw==
X-CSE-MsgGUID: /UlXEHqPQ/S5JIefN/FRnw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.19,213,1754982000"; d="scan'208";a="179600673"
Received: from liuzhao-optiplex-7080.sh.intel.com (HELO localhost)
 ([10.239.160.39])
 by orviesa006.jf.intel.com with ESMTP; 08 Oct 2025 09:03:02 -0700
Date: Thu, 9 Oct 2025 00:25:05 +0800
From: Zhao Liu <zhao1.liu@intel.com>
To: Philippe =?iso-8859-1?Q?Mathieu-Daud=E9?= <philmd@linaro.org>
Cc: qemu-devel@nongnu.org, qemu-arm@nongnu.org, qemu-s390x@nongnu.org,
 Richard Henderson <richard.henderson@linaro.org>,
 qemu-riscv@nongnu.org, Peter Maydell <peter.maydell@linaro.org>,
 qemu-ppc@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 Peter Xu <peterx@redhat.com>, Eduardo Habkost <eduardo@habkost.net>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Yanan Wang <wangyanan55@huawei.com>
Subject: Re: [PATCH 21/22] exec/cpu: Declare cpu_memory_rw_debug() in
 'hw/core/cpu.h' and document
Message-ID: <aOaQYd12ShXmDw0V@intel.com>
References: <20251001150529.14122-1-philmd@linaro.org>
 <20251001150529.14122-22-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20251001150529.14122-22-philmd@linaro.org>
Received-SPF: pass client-ip=198.175.65.10; envelope-from=zhao1.liu@intel.com;
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

On Wed, Oct 01, 2025 at 05:05:26PM +0200, Philippe Mathieu-Daudé wrote:
> Date: Wed,  1 Oct 2025 17:05:26 +0200
> From: Philippe Mathieu-Daudé <philmd@linaro.org>
> Subject: [PATCH 21/22] exec/cpu: Declare cpu_memory_rw_debug() in
>  'hw/core/cpu.h' and document
> X-Mailer: git-send-email 2.51.0
> 
> cpu_memory_rw_debug() dispatches to CPUClass::memory_rw_debug(),
> move its declaration closer to the CPU API. Document.
> 
> Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
> ---
>  include/exec/cpu-common.h |  4 ----
>  include/hw/core/cpu.h     | 20 ++++++++++++++++++++
>  2 files changed, 20 insertions(+), 4 deletions(-)

Reviewed-by: Zhao Liu <zhao1.liu@intel.com>


