Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7DDD3C87FCA
	for <qemu-devel@archiver.kernel.org>; Fri, 25 Jul 2025 16:36:36 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ufLOe-0002g2-RJ; Fri, 25 Jul 2025 12:35:48 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dave.jiang@intel.com>)
 id 1ufLOW-0002d6-RX
 for qemu-devel@nongnu.org; Fri, 25 Jul 2025 12:35:41 -0400
Received: from mgamail.intel.com ([198.175.65.9])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dave.jiang@intel.com>)
 id 1ufLOT-0005LB-Ki
 for qemu-devel@nongnu.org; Fri, 25 Jul 2025 12:35:40 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1753461338; x=1784997338;
 h=message-id:date:mime-version:subject:to:cc:references:
 from:in-reply-to:content-transfer-encoding;
 bh=d9jWZHAUAB3ilhRyQwasHrf8/j931YewnAlfeo/ZYtw=;
 b=LGEuOz7kBUuUzb4O7YtYL2MqNNJo/FALjMZomqgdSyaPuVdkS46WFvg4
 zO5byfIOgQFMtK6TpVbUJRPXUDjwBSF1XBzkY198BPTc4xHEr16HKJwqH
 GYLjs+x6z5Dplpf1PyXUN9UivmGaQv1+itBhTUuOCjvNFNWJAL3H3iZ3F
 254/aWaYdRaOmgaj/z8VxA/dAaWK9369SJxcO5WbRXfOB6/s9HcwQ4pbb
 03hTrGOcxWVgZ3j5iyB/bQeNVXJbK4iNA4BKlBfIIRkL38fCOMSHo4pPh
 NcrVlV7w59OZybiXx5aDypTNik8p6SDeGBY4jISiMaUtOPKPTmquqzHsz w==;
X-CSE-ConnectionGUID: 5xZ3R6JaTeaF21yo6jn43Q==
X-CSE-MsgGUID: vwitdfWbT2O9FT/grp451g==
X-IronPort-AV: E=McAfee;i="6800,10657,11503"; a="78350828"
X-IronPort-AV: E=Sophos;i="6.16,339,1744095600"; d="scan'208";a="78350828"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
 by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 25 Jul 2025 09:32:50 -0700
X-CSE-ConnectionGUID: 6RaQ1+gFQLKcKJzHlk+TYw==
X-CSE-MsgGUID: gy5IyvLWSQm7gV9qOdWDdQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,339,1744095600"; d="scan'208";a="161333497"
Received: from bvivekan-mobl1.gar.corp.intel.com (HELO [10.247.118.216])
 ([10.247.118.216])
 by fmviesa009-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 25 Jul 2025 09:32:42 -0700
Message-ID: <86a015d5-7b49-4b23-8a26-2155871bd08e@intel.com>
Date: Fri, 25 Jul 2025 09:32:41 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH v3 0/2] cxl: Support creation of a new CXL Host Bridge
To: wangyuquan <wangyuquan1236@phytium.com.cn>, jonathan.cameron@huawei.com,
 fan.ni@samsung.com, mst@redhat.com, marcel.apfelbaum@gmail.com
Cc: qemu-devel@nongnu.org, linux-cxl@vger.kernel.org
References: <20250617040649.81303-1-wangyuquan1236@phytium.com.cn>
Content-Language: en-US
From: Dave Jiang <dave.jiang@intel.com>
In-Reply-To: <20250617040649.81303-1-wangyuquan1236@phytium.com.cn>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=198.175.65.9; envelope-from=dave.jiang@intel.com;
 helo=mgamail.intel.com
X-Spam_score_int: -45
X-Spam_score: -4.6
X-Spam_bar: ----
X-Spam_report: (-4.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.175,
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



On 6/16/25 9:06 PM, wangyuquan wrote:
> v2 -> v3:
> - Update the commit message
> - Fix some alignment and space problems
> - Add a SPDX header for the new file
> - Remove unnecessary comments
> - Add CXL_HOST_BRIDGE config
> v1 -> v2:
> - Move the code of new bridge to hw/pci-host/cxl.c
> - Fix and simplify some logic on handling the different bridge types

Hi Yuquan, can you please add qemu to your patch subject prefix in the future? i.e. [QEMU PATCH v4 0/2]. It would help the maintainers on linux-cxl to know they are not kernel patches. Thank you!

> 
> Background
> ==========
> Currently the base CXL support for arm platforms is only on Jonathan's
> patches[1]. Some platform like SBSA-REF can be more like a real machine,
> thus the support of CXL could be meaningful. However, the pxb-cxl-host
> realization on this platform seems not satisfying their requirements[2].
> 
> New CXL HOST design
> ===================
> Defines a new CXL host bridge type (TYPE_CXL_HOST). This is an
> independent CXL host bridge which combined GPEX features (ECAM, MMIO
> windows and irq) and CXL Host Bridge Component Registers (CHBCR).
> 
> The root bus path of CXL_HOST is "0001:00", that would not affect the
> original pcie host topology. In the previous, the pxb-cxl-host with
> any CXL root ports and CXL endpoint devices would occupy the BDF
> number of the original pcie domain. This new type provide a solution
> to resolve the problem.
> 
> Remaining problems
> ==================
> I tried to use 'object_resolve_path' but it could not work in
> 'cxl_fmws_link_targets', so I used 'TYPE_DEVICE' to match that.
> 
> Link:
> [1]: https://lore.kernel.org/linux-cxl/20220616141950.23374-1-Jonathan.Cameron@huawei.com/
> [2]: https://lists.nongnu.org/archive/html/qemu-arm/2024-11/msg00522.html
> 
> Yuquan Wang (2):
>   pci-host/cxl: Support creation of a new CXL Host Bridge
>   hw/pxb-cxl: Rename the pxb cxl host bridge
> 
>  hw/cxl/cxl-host-stubs.c               |   3 +
>  hw/cxl/cxl-host.c                     |  64 ++++++++---
>  hw/pci-bridge/pci_expander_bridge.c   |   8 +-
>  hw/pci-host/Kconfig                   |   4 +
>  hw/pci-host/cxl.c                     | 152 ++++++++++++++++++++++++++
>  hw/pci-host/meson.build               |   1 +
>  include/hw/cxl/cxl.h                  |   7 +-
>  include/hw/cxl/cxl_host.h             |   3 +
>  include/hw/pci-host/cxl_host_bridge.h |  23 ++++
>  9 files changed, 244 insertions(+), 21 deletions(-)
>  create mode 100644 hw/pci-host/cxl.c
>  create mode 100644 include/hw/pci-host/cxl_host_bridge.h
> 


