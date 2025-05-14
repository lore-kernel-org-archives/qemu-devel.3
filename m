Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D4C10C3ABC3
	for <qemu-devel@archiver.kernel.org>; Wed, 14 May 2025 00:04:25 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uEzav-00052H-Rc; Tue, 13 May 2025 20:03:33 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <sstabellini@kernel.org>)
 id 1uEzat-00051a-9D; Tue, 13 May 2025 20:03:31 -0400
Received: from dfw.source.kernel.org ([139.178.84.217])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <sstabellini@kernel.org>)
 id 1uEzar-0001nD-Ix; Tue, 13 May 2025 20:03:31 -0400
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by dfw.source.kernel.org (Postfix) with ESMTP id 592015C4A49;
 Wed, 14 May 2025 00:01:09 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AFE4EC4CEE4;
 Wed, 14 May 2025 00:03:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1747181006;
 bh=V9r0H4FFmFHRbUIuzb5awbyVY/AV8w/CNxahp6ppDzw=;
 h=Date:From:To:cc:Subject:In-Reply-To:References:From;
 b=cak51oBcWts0nQZvhmBIFOTpaWUvxUBJUukktKF/Pke+GX7qiEBMl9OtrF26/jE3T
 xxH0V9yTBAa6HjEtyvj0+SDps7B82kg1+pbxHUStpgQ0RfvA3CyRtjZ2XMZvSz6jIg
 TaSBywL2pzpArbM25+PQrp0oPQKd5i9JSv1eKgelZPG/nq2A0BbraLlFWMA/eZKOvj
 aQ71KQx9MjcBGTxhJMksqsGBGLMtF+Haky1ODud96RoOZVx9HacHLPEqUiBdIt3FY/
 r59yBQV6f9KD83wbK+Lprqyd8gYrEaDCRaiZVEuE/yYhR0pl5RyWwYx4KMvOtBuqiR
 qra2z5ZoKrqvw==
Date: Tue, 13 May 2025 17:03:23 -0700 (PDT)
From: Stefano Stabellini <sstabellini@kernel.org>
X-X-Sender: sstabellini@ubuntu-linux-20-04-desktop
To: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
cc: qemu-devel@nongnu.org, Richard Henderson <richard.henderson@linaro.org>, 
 xen-devel@lists.xenproject.org, Anthony PERARD <anthony@xenproject.org>, 
 David Woodhouse <dwmw@amazon.co.uk>, 
 "Edgar E. Iglesias" <edgar.iglesias@gmail.com>, qemu-arm@nongnu.org, 
 Stefano Stabellini <sstabellini@kernel.org>, Paul Durrant <paul@xen.org>, 
 Pierrick Bouvier <pierrick.bouvier@linaro.org>, 
 Peter Maydell <peter.maydell@linaro.org>
Subject: Re: [PATCH] hw/xen/arch_hvm: Unify x86 and ARM variants
In-Reply-To: <20250513171737.74386-1-philmd@linaro.org>
Message-ID: <alpine.DEB.2.22.394.2505131703140.368682@ubuntu-linux-20-04-desktop>
References: <20250513171737.74386-1-philmd@linaro.org>
User-Agent: Alpine 2.22 (DEB 394 2020-01-19)
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="8323329-946740503-1747181006=:368682"
Received-SPF: pass client-ip=139.178.84.217;
 envelope-from=sstabellini@kernel.org; helo=dfw.source.kernel.org
X-Spam_score_int: -85
X-Spam_score: -8.6
X-Spam_bar: --------
X-Spam_report: (-8.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.549,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_HI=-5, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
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

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323329-946740503-1747181006=:368682
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT

On Tue, 13 May 2025, Philippe Mathieu-Daudé wrote:
> As each target declares the same prototypes, we can
> use a single header, removing the TARGET_XXX uses.
> 
> Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>

Reviewed-by: Stefano Stabellini <sstabellini@kernel.org>


> ---
>  include/hw/arm/xen_arch_hvm.h  |  9 ---------
>  include/hw/i386/xen_arch_hvm.h | 11 -----------
>  include/hw/xen/arch_hvm.h      | 14 ++++++++++----
>  hw/arm/xen-pvh.c               |  1 -
>  4 files changed, 10 insertions(+), 25 deletions(-)
>  delete mode 100644 include/hw/arm/xen_arch_hvm.h
>  delete mode 100644 include/hw/i386/xen_arch_hvm.h
> 
> diff --git a/include/hw/arm/xen_arch_hvm.h b/include/hw/arm/xen_arch_hvm.h
> deleted file mode 100644
> index 8fd645e7232..00000000000
> --- a/include/hw/arm/xen_arch_hvm.h
> +++ /dev/null
> @@ -1,9 +0,0 @@
> -#ifndef HW_XEN_ARCH_ARM_HVM_H
> -#define HW_XEN_ARCH_ARM_HVM_H
> -
> -#include <xen/hvm/ioreq.h>
> -void arch_handle_ioreq(XenIOState *state, ioreq_t *req);
> -void arch_xen_set_memory(XenIOState *state,
> -                         MemoryRegionSection *section,
> -                         bool add);
> -#endif
> diff --git a/include/hw/i386/xen_arch_hvm.h b/include/hw/i386/xen_arch_hvm.h
> deleted file mode 100644
> index 1000f8f5433..00000000000
> --- a/include/hw/i386/xen_arch_hvm.h
> +++ /dev/null
> @@ -1,11 +0,0 @@
> -#ifndef HW_XEN_ARCH_I386_HVM_H
> -#define HW_XEN_ARCH_I386_HVM_H
> -
> -#include <xen/hvm/ioreq.h>
> -#include "hw/xen/xen-hvm-common.h"
> -
> -void arch_handle_ioreq(XenIOState *state, ioreq_t *req);
> -void arch_xen_set_memory(XenIOState *state,
> -                         MemoryRegionSection *section,
> -                         bool add);
> -#endif
> diff --git a/include/hw/xen/arch_hvm.h b/include/hw/xen/arch_hvm.h
> index df39c819c8f..8bacaa4ec41 100644
> --- a/include/hw/xen/arch_hvm.h
> +++ b/include/hw/xen/arch_hvm.h
> @@ -1,5 +1,11 @@
> -#if defined(TARGET_I386) || defined(TARGET_X86_64)
> -#include "hw/i386/xen_arch_hvm.h"
> -#elif defined(TARGET_ARM) || defined(TARGET_AARCH64)
> -#include "hw/arm/xen_arch_hvm.h"
> +#ifndef HW_XEN_ARCH_HVM_H
> +#define HW_XEN_ARCH_HVM_H
> +
> +#include <xen/hvm/ioreq.h>
> +#include "hw/xen/xen-hvm-common.h"
> +
> +void arch_handle_ioreq(XenIOState *state, ioreq_t *req);
> +void arch_xen_set_memory(XenIOState *state,
> +                         MemoryRegionSection *section,
> +                         bool add);
>  #endif
> diff --git a/hw/arm/xen-pvh.c b/hw/arm/xen-pvh.c
> index 4b26bcff7a5..1a9eeb01c8e 100644
> --- a/hw/arm/xen-pvh.c
> +++ b/hw/arm/xen-pvh.c
> @@ -10,7 +10,6 @@
>  #include "hw/boards.h"
>  #include "system/system.h"
>  #include "hw/xen/xen-pvh-common.h"
> -#include "hw/xen/arch_hvm.h"
>  
>  #define TYPE_XEN_ARM  MACHINE_TYPE_NAME("xenpvh")
>  
> -- 
> 2.47.1
> 
--8323329-946740503-1747181006=:368682--

