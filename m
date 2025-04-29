Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 65678C369DC
	for <qemu-devel@archiver.kernel.org>; Tue, 29 Apr 2025 09:46:26 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u9hXP-0003tQ-3n; Tue, 29 Apr 2025 05:46:03 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1u9hXN-0003tE-Rd
 for qemu-devel@nongnu.org; Tue, 29 Apr 2025 05:46:01 -0400
Received: from mgamail.intel.com ([198.175.65.9])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1u9hXK-0000OB-Af
 for qemu-devel@nongnu.org; Tue, 29 Apr 2025 05:46:01 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1745919959; x=1777455959;
 h=date:from:to:cc:subject:message-id:references:
 mime-version:in-reply-to;
 bh=ybQ6MXTaC9u5GAw+pRA0IDHgxXcC0Q6fkGX2s0d0DVk=;
 b=JvGR0kos8EgZ/Njc7mDi5Sko5YRF8fgygNAxDCRtaxaORAfRYv6VZ0ii
 Nl3/Bp37Zk0QElZglbmR16XpQcmdFqVpF971kGhDQNXP8LeGD99BwLCUM
 VBQ9m6N2qG5jnH3414dx+FtgEWrE16IU79x4E7MJZqDO97rKkXrQxcbYI
 eOp7DKNvQwAR9vMfx7Lay7vignmJ4dOwAQ8t4XT49+zWqwF++7M8F6edC
 bgN0e1FVLTehtIANpBohcracT5boAxs6Kz2LuRhz2XiR8OL9f+LOXWJ9R
 ZtWcZvoeANUgSYU1QeijFCaHZeI3i6x1YkW+PbWnoUuRilb3M3i6HobIV A==;
X-CSE-ConnectionGUID: IV6UCNLpSz2XZ/HxVL1X3g==
X-CSE-MsgGUID: +N3TzMMvRs6d2PHLMA8/dg==
X-IronPort-AV: E=McAfee;i="6700,10204,11417"; a="70037247"
X-IronPort-AV: E=Sophos;i="6.15,248,1739865600"; d="scan'208";a="70037247"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
 by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 29 Apr 2025 02:45:53 -0700
X-CSE-ConnectionGUID: jHPRLZ5pSKGXzPUY4XolRQ==
X-CSE-MsgGUID: uihAElyxTcum9WWGPLJHpQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,248,1739865600"; d="scan'208";a="171012490"
Received: from liuzhao-optiplex-7080.sh.intel.com (HELO localhost)
 ([10.239.160.39])
 by orviesa001.jf.intel.com with ESMTP; 29 Apr 2025 02:45:50 -0700
Date: Tue, 29 Apr 2025 18:06:47 +0800
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
Message-ID: <aBCkt7bI1o+x8MWk@intel.com>
References: <20250401130205.2198253-1-xiaoyao.li@intel.com>
 <20250401130205.2198253-32-xiaoyao.li@intel.com>
 <884fdc77-94f8-41f5-a579-aa70fa652eb9@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <884fdc77-94f8-41f5-a579-aa70fa652eb9@intel.com>
Received-SPF: pass client-ip=198.175.65.9; envelope-from=zhao1.liu@intel.com;
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

On Thu, Apr 24, 2025 at 01:51:55PM +0800, Xiaoyao Li wrote:
> Date: Thu, 24 Apr 2025 13:51:55 +0800
> From: Xiaoyao Li <xiaoyao.li@intel.com>
> Subject: Re: [PATCH v8 31/55] i386/cpu: introduce
>  x86_confidential_guest_cpu_instance_init()
> 
> Hi Paolo,
> 
> On 4/1/2025 9:01 PM, Xiaoyao Li wrote:
> ...
> > diff --git a/target/i386/cpu.c b/target/i386/cpu.c
> > index add6430f7edd..5c69d1489365 100644
> > --- a/target/i386/cpu.c
> > +++ b/target/i386/cpu.c
> > @@ -36,6 +36,7 @@
> >   #include "hw/qdev-properties.h"
> >   #include "hw/i386/topology.h"
> >   #ifndef CONFIG_USER_ONLY
> > +#include "confidential-guest.h"
> >   #include "system/reset.h"
> >   #include "qapi/qapi-commands-machine-target.h"
> >   #include "exec/address-spaces.h"
> > @@ -8504,6 +8505,15 @@ static void x86_cpu_post_initfn(Object *obj)
> >       }
> >       accel_cpu_instance_init(CPU(obj));
> > +
> > +#ifndef CONFIG_USER_ONLY
> > +    MachineState *ms = MACHINE(object_dynamic_cast(qdev_get_machine(),
> > +                                                   TYPE_MACHINE));
> 
> It leads to
> 
>   qemu-system-x86_64: ../hw/core/qdev.c:824: qdev_get_machine: Assertion
> `dev' failed.
>   Aborted (core dumped)
> 
> for the case of "-cpu help" due to the assert(dev) in qdev_get_machine().
> 
> How do you want to resolve it? I can think of two:
> 1. remove the assert() in qdev_get_machine(). or
> 2. drop the callback introduce by this patch. Instead just do
> 
>    if (is_tdx_vm()) {
> 	tdx_cpu_instance_init();
>    }

Sorry I missed this mail when review this patch.

What about checking `current_machine`?

@@ -8541,10 +8541,8 @@ static void x86_cpu_post_initfn(Object *obj)
     accel_cpu_instance_init(CPU(obj));

 #ifndef CONFIG_USER_ONLY
-    MachineState *ms = MACHINE(object_dynamic_cast(qdev_get_machine(),
-                                                   TYPE_MACHINE));
-    if (ms && ms->cgs) {
-        x86_confidential_guest_cpu_instance_init(X86_CONFIDENTIAL_GUEST(ms->cgs),
+    if (current_machine && current_machine->cgs) {
+        x86_confidential_guest_cpu_instance_init(X86_CONFIDENTIAL_GUEST(current_machine->cgs),
                                                  (CPU(obj)));
     }
 #endif
---

"-cpu help" is processed before machine creation. The cpu-core
(cpu_core_instance_init) also checks current_machine to avoid similar
issue.

Regards,
Zhao



