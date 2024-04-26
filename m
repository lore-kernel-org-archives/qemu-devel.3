Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E9294C4345F
	for <qemu-devel@archiver.kernel.org>; Fri, 26 Apr 2024 21:26:00 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s0T3u-00033P-DU; Fri, 26 Apr 2024 17:24:54 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zide.chen@intel.com>)
 id 1s0PIM-0003Ue-Kc
 for qemu-devel@nongnu.org; Fri, 26 Apr 2024 13:23:35 -0400
Received: from mgamail.intel.com ([198.175.65.19])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zide.chen@intel.com>)
 id 1s0PIJ-0003lv-W5
 for qemu-devel@nongnu.org; Fri, 26 Apr 2024 13:23:33 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1714152212; x=1745688212;
 h=message-id:date:mime-version:subject:to:cc:references:
 from:in-reply-to:content-transfer-encoding;
 bh=KnYbAszjZrxr8PTiejoIwc2DTVTVf+JChhwgv7diWtU=;
 b=NyXjsynTFloJeGMeq5Tfcl16Qsli+1Lznigtzahsx/bL7tf+8m5MI6DD
 m10NpfEX4JODiR+InLP/dCT0J/wW8W2A5nGlFpd9nAohEmQpTr+Qrm8JR
 85Mn/QtFzyHHXG02jrryO5t59kYnoSqa7JIiOIVmRRqpn4y41Dr47lXHP
 MCrpeCpw3+tm2eZEMSKzWrnXvZ/+9EP5kDag0xj+ZdmJiyDniKQnTYbCI
 A1lrsmHHPCd+jc5OUD+0MUsxggpfPefAsIeAtNpSZL/gWlfW7laavQshy
 hHxd2nBJbdZvuK5K8Fgkpoosqi53hyGFHGZfjAQ3B4sw7vyNXHUrC1dJp Q==;
X-CSE-ConnectionGUID: wWDyaqS6QAi75SUWIfobKg==
X-CSE-MsgGUID: UrDsF4CvRwOmDe+APsbnbA==
X-IronPort-AV: E=McAfee;i="6600,9927,11056"; a="9759079"
X-IronPort-AV: E=Sophos;i="6.07,233,1708416000"; 
   d="scan'208";a="9759079"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
 by orvoesa111.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 26 Apr 2024 10:23:27 -0700
X-CSE-ConnectionGUID: z7sUbiCGSFmKd5rsK5d8Zg==
X-CSE-MsgGUID: /IxMH9VbTjmblPTzfqH4oQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,233,1708416000"; d="scan'208";a="26116258"
Received: from soc-cp83kr3.jf.intel.com (HELO [10.24.10.50]) ([10.24.10.50])
 by orviesa008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 26 Apr 2024 10:23:27 -0700
Message-ID: <04d827f7-fb18-4c93-b223-91dd5e190421@intel.com>
Date: Fri, 26 Apr 2024 10:23:27 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/6] target/i386/kvm: Add feature bit definitions for KVM
 CPUID
To: Zhao Liu <zhao1.liu@intel.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Eduardo Habkost <eduardo@habkost.net>, "Michael S . Tsirkin"
 <mst@redhat.com>, Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Marcelo Tosatti <mtosatti@redhat.com>
Cc: Xiaoyao Li <xiaoyao.li@intel.com>, qemu-devel@nongnu.org,
 kvm@vger.kernel.org
References: <20240426100716.2111688-1-zhao1.liu@intel.com>
 <20240426100716.2111688-2-zhao1.liu@intel.com>
Content-Language: en-US
From: "Chen, Zide" <zide.chen@intel.com>
In-Reply-To: <20240426100716.2111688-2-zhao1.liu@intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=198.175.65.19; envelope-from=zide.chen@intel.com;
 helo=mgamail.intel.com
X-Spam_score_int: -50
X-Spam_score: -5.1
X-Spam_bar: -----
X-Spam_report: (-5.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.669,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_MED=-2.3, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-Mailman-Approved-At: Fri, 26 Apr 2024 17:24:51 -0400
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



On 4/26/2024 3:07 AM, Zhao Liu wrote:
> Add feature definiations for KVM_CPUID_FEATURES in CPUID (
> CPUID[4000_0001].EAX and CPUID[4000_0001].EDX), to get rid of lots of
> offset calculations.
> 
> Signed-off-by: Zhao Liu <zhao1.liu@intel.com>
> ---
> v2: Changed the prefix from CPUID_FEAT_KVM_* to CPUID_KVM_*. (Xiaoyao)
> ---
>  hw/i386/kvm/clock.c   |  5 ++---
>  target/i386/cpu.h     | 23 +++++++++++++++++++++++
>  target/i386/kvm/kvm.c | 28 ++++++++++++++--------------
>  3 files changed, 39 insertions(+), 17 deletions(-)
> 
> diff --git a/hw/i386/kvm/clock.c b/hw/i386/kvm/clock.c
> index 40aa9a32c32c..ce416c05a3d0 100644
> --- a/hw/i386/kvm/clock.c
> +++ b/hw/i386/kvm/clock.c
> @@ -27,7 +27,6 @@
>  #include "qapi/error.h"
>  
>  #include <linux/kvm.h>
> -#include "standard-headers/asm-x86/kvm_para.h"
>  #include "qom/object.h"
>  
>  #define TYPE_KVM_CLOCK "kvmclock"
> @@ -334,8 +333,8 @@ void kvmclock_create(bool create_always)
>  
>      assert(kvm_enabled());
>      if (create_always ||
> -        cpu->env.features[FEAT_KVM] & ((1ULL << KVM_FEATURE_CLOCKSOURCE) |
> -                                       (1ULL << KVM_FEATURE_CLOCKSOURCE2))) {
> +        cpu->env.features[FEAT_KVM] & (CPUID_KVM_CLOCK |
> +                                       CPUID_KVM_CLOCK2)) {

To achieve this purpose, how about doing the alternative to define an
API similar to KVM's guest_pv_has()?

xxxx_has() is simpler and clearer than "features[] & CPUID_xxxxx",
additionally, this helps to keep the definitions identical to KVM, more
readable and easier for future maintenance.

