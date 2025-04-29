Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C6DACC369DC
	for <qemu-devel@archiver.kernel.org>; Tue, 29 Apr 2025 06:15:35 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u9eFG-0006R8-Ds; Tue, 29 Apr 2025 02:15:12 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1u9eEq-00062Q-E2
 for qemu-devel@nongnu.org; Tue, 29 Apr 2025 02:14:41 -0400
Received: from mgamail.intel.com ([192.198.163.10])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1u9eEo-0005X2-Bg
 for qemu-devel@nongnu.org; Tue, 29 Apr 2025 02:14:40 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1745907278; x=1777443278;
 h=date:from:to:cc:subject:message-id:references:
 mime-version:in-reply-to;
 bh=fCLdotT6bURVj9gCNLeH4nbEqElkHKkxS9MvYqpe4fo=;
 b=nHnNt9acgQA9BpGJtlPw6pGz8HXWxKt4Edqckr58dEwdnw9N03qc6LI7
 sbhWv5XtF0Vw/fxG4J69Kfo/rv7UkD9ylFJD3IK8BJ4glAmG+NU0k9cN0
 yWWS6Xoa4B1cb2hx/imWpGX167oMsSGOIRuBACiV4yqqyN3zO/lEc3iSt
 jOczMDKJNhSvSTQjmOIkla/wBXgHR7fYOZjXrtwi2VCVFRpOjVrbnUR7Y
 Hymd5L94W0Qt6gpvam/PnesPnPsp2jEnvxUjGG5R9KUyPCclUi7f6IKaq
 BudFTp2V7sAIr2xvjZMZZi1DvCcGBOwQyTUI229BqGyI1b/j7A1IjE8qi Q==;
X-CSE-ConnectionGUID: QFFjS9zQQCquut0LFuc47A==
X-CSE-MsgGUID: WP7+b0C5RfmotD5Uxo7gRw==
X-IronPort-AV: E=McAfee;i="6700,10204,11417"; a="58882324"
X-IronPort-AV: E=Sophos;i="6.15,248,1739865600"; d="scan'208";a="58882324"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
 by fmvoesa104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 28 Apr 2025 23:14:36 -0700
X-CSE-ConnectionGUID: z15DZUfVQuy3v5W6Ec8UeQ==
X-CSE-MsgGUID: dl7Q9jSuSESCrDlTbIQaLg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,248,1739865600"; d="scan'208";a="164828823"
Received: from liuzhao-optiplex-7080.sh.intel.com (HELO localhost)
 ([10.239.160.39])
 by fmviesa001.fm.intel.com with ESMTP; 28 Apr 2025 23:14:34 -0700
Date: Tue, 29 Apr 2025 14:35:31 +0800
From: Zhao Liu <zhao1.liu@intel.com>
To: Xiaoyao Li <xiaoyao.li@intel.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>,
 Daniel =?iso-8859-1?Q?P=2E_Berrang=E9?= <berrange@redhat.com>,
 "Michael S. Tsirkin" <mst@redhat.com>,
 Markus Armbruster <armbru@redhat.com>,
 Francesco Lavra <francescolavra.fl@gmail.com>,
 Marcelo Tosatti <mtosatti@redhat.com>, qemu-devel@nongnu.org,
 Philippe =?iso-8859-1?Q?Mathieu-Daud=E9?= <philmd@linaro.org>,
 Rick Edgecombe <rick.p.edgecombe@intel.com>
Subject: Re: [PATCH v8 31/55] i386/cpu: introduce
 x86_confidential_guest_cpu_instance_init()
Message-ID: <aBBzM4uitvFOb0Nn@intel.com>
References: <20250401130205.2198253-1-xiaoyao.li@intel.com>
 <20250401130205.2198253-32-xiaoyao.li@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250401130205.2198253-32-xiaoyao.li@intel.com>
Received-SPF: pass client-ip=192.198.163.10; envelope-from=zhao1.liu@intel.com;
 helo=mgamail.intel.com
X-Spam_score_int: -48
X-Spam_score: -4.9
X-Spam_bar: ----
X-Spam_report: (-4.9 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.484,
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

On Tue, Apr 01, 2025 at 09:01:41AM -0400, Xiaoyao Li wrote:
> Date: Tue,  1 Apr 2025 09:01:41 -0400
> From: Xiaoyao Li <xiaoyao.li@intel.com>
> Subject: [PATCH v8 31/55] i386/cpu: introduce
>  x86_confidential_guest_cpu_instance_init()
> X-Mailer: git-send-email 2.34.1
> 
> To allow execute confidential guest specific cpu init operations.
> 
> Signed-off-by: Xiaoyao Li <xiaoyao.li@intel.com>
> ---
> Changes in v6:
>  - new patch;
> ---
>  target/i386/confidential-guest.h | 11 +++++++++++
>  target/i386/cpu.c                | 10 ++++++++++
>  2 files changed, 21 insertions(+)
> 
> diff --git a/target/i386/confidential-guest.h b/target/i386/confidential-guest.h
> index 164be7633a20..a86c42a47558 100644
> --- a/target/i386/confidential-guest.h
> +++ b/target/i386/confidential-guest.h
> @@ -39,6 +39,7 @@ struct X86ConfidentialGuestClass {
>  
>      /* <public> */
>      int (*kvm_type)(X86ConfidentialGuest *cg);
> +    void (*cpu_instance_init)(X86ConfidentialGuest *cg, CPUState *cpu);
>      uint32_t (*mask_cpuid_features)(X86ConfidentialGuest *cg, uint32_t feature, uint32_t index,
>                                      int reg, uint32_t value);
>  };
> @@ -59,6 +60,16 @@ static inline int x86_confidential_guest_kvm_type(X86ConfidentialGuest *cg)
>      }
>  }
>  
> +static inline void x86_confidential_guest_cpu_instance_init(X86ConfidentialGuest *cg,
> +                                                            CPUState *cpu)

Well, it's a so long function name.

Or maybe we can call it as "x86_confidential_guest_cpu_init" and rename
the hook as "cpu_init"?

> +{
> +    X86ConfidentialGuestClass *klass = X86_CONFIDENTIAL_GUEST_GET_CLASS(cg);
> +
> +    if (klass->cpu_instance_init) {
> +        klass->cpu_instance_init(cg, cpu);
> +    }
> +}
> +
>  /**
>   * x86_confidential_guest_mask_cpuid_features:
>   *
> diff --git a/target/i386/cpu.c b/target/i386/cpu.c
> index add6430f7edd..5c69d1489365 100644
> --- a/target/i386/cpu.c
> +++ b/target/i386/cpu.c
> @@ -36,6 +36,7 @@
>  #include "hw/qdev-properties.h"
>  #include "hw/i386/topology.h"
>  #ifndef CONFIG_USER_ONLY
> +#include "confidential-guest.h"
>  #include "system/reset.h"
>  #include "qapi/qapi-commands-machine-target.h"
>  #include "exec/address-spaces.h"
> @@ -8504,6 +8505,15 @@ static void x86_cpu_post_initfn(Object *obj)
>      }
>  
>      accel_cpu_instance_init(CPU(obj));
> +
> +#ifndef CONFIG_USER_ONLY
> +    MachineState *ms = MACHINE(object_dynamic_cast(qdev_get_machine(),
> +                                                   TYPE_MACHINE));

There's no need to use object_dynamic_cast(), to cast to the basic machine
type.

MACHINE(qdev_get_machine()) is enough.

> +    if (ms && ms->cgs) {
> +        x86_confidential_guest_cpu_instance_init(X86_CONFIDENTIAL_GUEST(ms->cgs),
> +                                                 (CPU(obj)));
> +    }
> +#endif
>  }
>

Others are fine for me,

Reviewed-by: Zhao Liu <zhao1.liu@intel.com>



