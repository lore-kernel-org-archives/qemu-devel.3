Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2F9ACC4345F
	for <qemu-devel@archiver.kernel.org>; Thu, 25 Apr 2024 07:25:06 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rztSt-0006Wn-U1; Thu, 25 Apr 2024 03:24:19 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <anjo@rev.ng>)
 id 1rztSq-0006U9-HY; Thu, 25 Apr 2024 03:24:16 -0400
Received: from rev.ng ([5.9.113.41])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <anjo@rev.ng>)
 id 1rztSn-0005MZ-TB; Thu, 25 Apr 2024 03:24:15 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=rev.ng;
 s=dkim; h=In-Reply-To:Content-Transfer-Encoding:Content-Type:MIME-Version:
 References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive:List-Unsubscribe:List-Unsubscribe-Post:
 List-Help; bh=F7BKNHiMAlNocT2U24LEjGIdXTZ+ds4ooqhTuWSUoyc=; b=jrnrPfiQot4CQI9
 TyacJxS+Y+Uk34YSOGfa58MCeyKl/bmnEkHuJ5b6N86w9zkuxeQ1hI0fZt46iPL43e+aGBP8y+jmo
 Z7vBMXe/rrPDGz/bECXMt+dyF2Ex+tK4IO7yBPIqq7Nb3BzLoIOsJVC1CsxgvPNr+dXT7SVC8tCPo
 38=;
Date: Thu, 25 Apr 2024 09:25:20 +0200
To: Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Cc: qemu-devel@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>, 
 Richard Henderson <richard.henderson@linaro.org>, qemu-arm@nongnu.org,
 qemu-ppc@nongnu.org, qemu-riscv@nongnu.org, 
 David Hildenbrand <david@redhat.com>,
 Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>, 
 Peter Xu <peterx@redhat.com>
Subject: Re: [PATCH 11/24] exec: Move tlb_reset_dirty*() declarations to
 'exec/cputlb.h'
Message-ID: <ie74e7uxd4dovk4afk6o2r7pbc7rfwqomncla2pgprr34u3q3k@mwmdrjzxzsuz>
References: <20240418192525.97451-1-philmd@linaro.org>
 <20240418192525.97451-12-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20240418192525.97451-12-philmd@linaro.org>
Received-SPF: pass client-ip=5.9.113.41; envelope-from=anjo@rev.ng; helo=rev.ng
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_PASS=-0.001,
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
Reply-to:  Anton Johansson <anjo@rev.ng>
From:  Anton Johansson via <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

On 18/04/24, Philippe Mathieu-Daudé wrote:
> Declare tlb_reset_dirty() and tlb_reset_dirty_range_all()
> in "exec/cputlb.h". Restrict tlb_reset_dirty_range_all()
> to TCG accel.
> 
> Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
> ---
>  include/exec/cputlb.h   | 12 +++++++++++-
>  include/exec/exec-all.h |  3 ---
>  include/exec/ram_addr.h |  1 +
>  system/physmem.c        |  2 ++
>  4 files changed, 14 insertions(+), 4 deletions(-)
> 
> diff --git a/include/exec/cputlb.h b/include/exec/cputlb.h
> index 3594f904b4..dc92befb93 100644
> --- a/include/exec/cputlb.h
> +++ b/include/exec/cputlb.h
> @@ -49,6 +49,9 @@ void *tlb_vaddr_to_host(CPUArchState *env, abi_ptr addr,
>  void tlb_protect_code(ram_addr_t ram_addr);
>  void tlb_unprotect_code(ram_addr_t ram_addr);
>  
> +void tlb_reset_dirty(CPUState *cpu, ram_addr_t start1, ram_addr_t length);
> +void tlb_reset_dirty_range_all(ram_addr_t start, ram_addr_t length);
> +
>  /**
>   * iotlb_to_section:
>   * @cpu: CPU performing the access
> @@ -69,6 +72,13 @@ hwaddr memory_region_section_get_iotlb(CPUState *cpu,
>  
>  #endif /* CONFIG_USER_ONLY */
>  
> -#endif /* CONFIG_TCG */
> +#else /* !CONFIG_TCG */
> +
> +static inline void tlb_reset_dirty_range_all(ram_addr_t start,
> +                                             ram_addr_t length)
> +{
> +}
> +
> +#endif /* !CONFIG_TCG */

The only use of tlb_reset_dirty_range_all() is in
cpu_physical_memory_dirty_bits_cleared() surrounded by an
if (tcg_enabled()).  Would stubbing the latter function be better?

>  
>  #endif
> diff --git a/include/exec/exec-all.h b/include/exec/exec-all.h
> index 778c82ba8e..6f46015ab4 100644
> --- a/include/exec/exec-all.h
> +++ b/include/exec/exec-all.h
> @@ -640,9 +640,6 @@ static inline void mmap_lock(void) {}
>  static inline void mmap_unlock(void) {}
>  #define WITH_MMAP_LOCK_GUARD()
>  
> -void tlb_reset_dirty(CPUState *cpu, ram_addr_t start1, ram_addr_t length);
> -void tlb_reset_dirty_range_all(ram_addr_t start, ram_addr_t length);
> -
>  #endif
>  
>  #endif
> diff --git a/include/exec/ram_addr.h b/include/exec/ram_addr.h
> index 3fc83587c0..f06ae9b516 100644
> --- a/include/exec/ram_addr.h
> +++ b/include/exec/ram_addr.h
> @@ -26,6 +26,7 @@
>  #include "exec/ramlist.h"
>  #include "exec/ramblock.h"
>  #include "exec/exec-all.h"
> +#include "cputlb.h"
>  #include "qemu/rcu.h"
>  
>  extern uint64_t total_dirty_pages;
> diff --git a/system/physmem.c b/system/physmem.c
> index 38d3ede9f9..7a7876a375 100644
> --- a/system/physmem.c
> +++ b/system/physmem.c
> @@ -850,6 +850,7 @@ found:
>      return block;
>  }
>  
> +#ifdef CONFIG_TCG
>  void tlb_reset_dirty_range_all(ram_addr_t start, ram_addr_t length)
>  {
>      CPUState *cpu;
> @@ -869,6 +870,7 @@ void tlb_reset_dirty_range_all(ram_addr_t start, ram_addr_t length)
>          tlb_reset_dirty(cpu, start1, length);
>      }
>  }
> +#endif

This function only depends on qemu_get_ramblock which is statically
defined in physmem.c although it doesnt depend on anything in physmem.c
as far as I can tell. Thoughts on moving qemu_get_ramblock to a common
.c or .h and moving the tlb_reset_dirty_range_all definition to
cputlb.c?

