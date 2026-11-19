Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C0A35606A320
	for <qemu-devel@archiver.kernel.org>; Thu, 19 Nov 2026 11:27:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=Nqnwf2Mx
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xU0Hs-0001sM-7h; Thu, 19 Nov 2026 06:26:44 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <xiaoyao.li@intel.com>)
 id 1xU0Hq-0001ry-KU
 for qemu-devel@nongnu.org; Thu, 19 Nov 2026 06:26:42 -0500
Received: from mgamail.intel.com ([198.175.65.21])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <xiaoyao.li@intel.com>)
 id 1xU0Ho-0005U7-4L
 for qemu-devel@nongnu.org; Thu, 19 Nov 2026 06:26:42 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1795087600; x=1826623600;
 h=message-id:date:mime-version:subject:to:cc:references:
 from:in-reply-to:content-transfer-encoding;
 bh=7qp6mXY4uBN64wocdfmZyVFiUDF/uInskR8tFBsrVnY=;
 b=Nqnwf2Mx9UzC3PokRPfsCZH9wL7GaaSx/4fJiMU8rkb7YPV+5+FIJfEn
 1aY0xq0+l7NgkDS342kuk5U/n7s1DjTKM7iHE50XD9RuG7o/wwqP9Uu/m
 OTdngAUNPORb4CYs/p0iAa+0G7TeK0t3Z1KN0ZY+1CozYQsa2nAisb4ri
 qD0NHhqouGZXWlHFnN4L0t3WXWBV+sWoFPVn9PkrBVHr7ruGcSktu4OdT
 DHtRZeXYIjZSyw1awtRig0Oc6IILp1V5FiMn6l2Ok5BL/OXIQb8e/v0Tw
 sFySFQXp/ZhK42OkVD/VGhD4xMVo5QS3N86+sA4MiUYmwNUfL/8ggWi6J w==;
X-CSE-ConnectionGUID: kw7DZDEPS4+L5KdbDNMhjw==
X-CSE-MsgGUID: 52DgTFNgRI6aEhzpVZ427g==
X-IronPort-AV: E=McAfee;i="6800,10657,11971"; a="4011971"
X-IronPort-AV: E=Sophos;i="6.27,220,1787036400"; 
   d="scan'208";a="4011971"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
 by orvoesa113.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 19 Nov 2026 03:26:33 -0800
X-CSE-ConnectionGUID: eC8om2IKS+esoMkw+62xZg==
X-CSE-MsgGUID: bTpxFuOBQV6VaO8qGfLIdQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,220,1787036400"; d="scan'208";a="10274076"
Received: from unknown (HELO [10.238.0.68]) ([10.238.0.68])
 by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 19 Nov 2026 03:26:32 -0800
Message-ID: <6bc5ddb8-50f1-4087-8591-57b542d1b5c2@intel.com>
Date: Thu, 19 Nov 2026 19:26:29 +0800
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH for-11.2] hostmem: allow building without KVM support
To: Michael Tokarev <mjt@tls.msk.ru>, qemu-devel@nongnu.org
Cc: David Hildenbrand <david@kernel.org>, Igor Mammedov
 <imammedo@redhat.com>, Peter Xu <peterx@redhat.com>,
 Fabiano Rosas <farosas@suse.de>
References: <20261119111050.1203459-1-mjt@tls.msk.ru>
Content-Language: en-US
From: Xiaoyao Li <xiaoyao.li@intel.com>
In-Reply-To: <20261119111050.1203459-1-mjt@tls.msk.ru>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=198.175.65.21; envelope-from=xiaoyao.li@intel.com;
 helo=mgamail.intel.com
X-Spam_score_int: -23
X-Spam_score: -2.4
X-Spam_bar: --
X-Spam_report: (-2.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 HK_RANDOM_ENVFROM=0.993, HK_RANDOM_FROM=1, RCVD_IN_DNSWL_MED=-2.3,
 SPF_HELO_NONE=0.001, SPF_NONE=0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
X-Spam-Status: No, score=-16.3 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	HK_RANDOM_FROM,INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_PASS,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On 11/19/2026 7:10 PM, Michael Tokarev wrote:
> On architectures where KVM is not available and so including <linux/kvm.h>
> does not work, buildnig backends/hostmem-memfd.c fails since 7ca43d7ad02f:
> 
>  In file included from backends/hostmem-memfd.c:23:
>  linux-headers/linux/kvm.h:16:10: fatal error: asm/kvm.h: No such file or directory
>    16 | #include <asm/kvm.h>
> 
> Do not include <linux/kvm.h> because "system/kvm.h" already includes it for us
> when KVM is enabled, and guard the actual code using memfd definitions with

It reads the sentence doesn't finish...

> Fixes: 7ca43d7ad02f ("hostmem: Support fully shared guest memfd to back a VM")
> Signed-off-by: Michael Tokarev <mjt@tls.msk.ru>
> ---
>  backends/hostmem-memfd.c | 6 +++++-
>  1 file changed, 5 insertions(+), 1 deletion(-)
> 
> diff --git a/backends/hostmem-memfd.c b/backends/hostmem-memfd.c
> index 46489212a23..3164dd6198c 100644
> --- a/backends/hostmem-memfd.c
> +++ b/backends/hostmem-memfd.c
> @@ -20,7 +20,6 @@
>  #include "qom/object.h"
>  #include "migration/cpr.h"
>  #include "system/kvm.h"
> -#include <linux/kvm.h>
>  #include "qapi/qapi-type-infos-common.h"
>  
>  OBJECT_DECLARE_SIMPLE_TYPE(HostMemoryBackendMemfd, MEMORY_BACKEND_MEMFD)
> @@ -71,10 +70,15 @@ memfd_backend_memory_alloc(HostMemoryBackend *backend, Error **errp)
>              return false;
>          }
>  
> +#ifdef CONFIG_KVM
>          fd = kvm_create_guest_memfd(backend->size,
>                                      GUEST_MEMFD_FLAG_MMAP |
>                                      GUEST_MEMFD_FLAG_INIT_SHARED,
>                                      errp);
> +#else
> +        error_setg(errp, "guest-memfd=on requires KVM which is not enabled");
> +        fd = -ENOSYS;
> +#endif

There is stub implemented in kvm-stub.c. Doesn't it work?

>      } else {
>          fd = qemu_memfd_create(TYPE_MEMORY_BACKEND_MEMFD, backend->size,
>                                 m->hugetlb, m->hugetlbsize, m->seal ?


