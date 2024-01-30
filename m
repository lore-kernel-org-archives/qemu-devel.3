Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 94438C46CD2
	for <qemu-devel@archiver.kernel.org>; Tue, 30 Jan 2024 07:15:03 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rUiKB-0004X4-Ki; Tue, 30 Jan 2024 02:14:27 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <xiaoyao.li@intel.com>)
 id 1rUiK4-0004UV-SK; Tue, 30 Jan 2024 02:14:21 -0500
Received: from mgamail.intel.com ([198.175.65.15])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <xiaoyao.li@intel.com>)
 id 1rUiK1-0006kJ-Tk; Tue, 30 Jan 2024 02:14:19 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1706598858; x=1738134858;
 h=message-id:date:mime-version:subject:to:cc:references:
 from:in-reply-to:content-transfer-encoding;
 bh=7HeyAl8U6Av9QcAqXGTlJE8NwCV64+o/r9gIwN9MZck=;
 b=grPzOD6S9O/xReE3q/JX3V2vM0RjoJO/2Wj+Ddt4OZu8UxNbWd0gy/pv
 4qI/XMIkSlGLzww5bdvTKGtPRn9YggbaCqc6djHq1Lvr+CX+gAYWakZCu
 /NTIfrqoBuYdugEmfgrZPNvk7uqX9cc7bVFTC89ckBa1Rh4Eq4lpn6TrD
 YV5svhMXr+Ul4h8Q6xiDpOQnQ/vKDMXzZ+S+eP4FjnInHBrvUxctuLycF
 9yxDrdL18hjnQADvd4pUbaQjQP8sZbvEdjZZq05fu0G0tr57FOHZaGfSr
 NNNXajYpP+yoXNc7bIhn+pMKlL+rEOcRnsntR1h6AYHutwspnm4yldJZm Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10968"; a="3048905"
X-IronPort-AV: E=Sophos;i="6.05,707,1701158400"; 
   d="scan'208";a="3048905"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
 by orvoesa107.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 29 Jan 2024 23:14:13 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.05,707,1701158400"; 
   d="scan'208";a="3619717"
Received: from xiaoyaol-hp-g830.ccr.corp.intel.com (HELO [10.93.33.17])
 ([10.93.33.17])
 by fmviesa003-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 29 Jan 2024 23:14:11 -0800
Message-ID: <bf98c2d0-297c-443d-8339-30d24dda109e@intel.com>
Date: Tue, 30 Jan 2024 15:14:07 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] backends/hostmem: Fix block comments style (checkpatch.pl
 warnings)
Content-Language: en-US
To: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 qemu-devel@nongnu.org
Cc: qemu-trivial@nongnu.org, David Hildenbrand <david@redhat.com>,
 Igor Mammedov <imammedo@redhat.com>
References: <20240129183130.97447-1-philmd@linaro.org>
From: Xiaoyao Li <xiaoyao.li@intel.com>
In-Reply-To: <20240129183130.97447-1-philmd@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=198.175.65.15; envelope-from=xiaoyao.li@intel.com;
 helo=mgamail.intel.com
X-Spam_score_int: -13
X-Spam_score: -1.4
X-Spam_bar: -
X-Spam_report: (-1.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.29,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 HK_RANDOM_ENVFROM=0.998, HK_RANDOM_FROM=0.999, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001, T_SCC_BODY_TEXT_LINE=-0.01 autolearn=no autolearn_force=no
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

On 1/30/2024 2:31 AM, Philippe Mathieu-Daudé wrote:
> While re-indenting code in host_memory_backend_memory_complete(),
> we triggered various "Block comments use a leading /* on a separate
> line" warnings from checkpatch.pl. Correct the comments style.
> 
> Fixes: e199f7ad4d ("backends: Simplify host_memory_backend_memory_complete()")
> Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>

Reviewed-by: Xiaoyao Li <xiaoyao.li@intel.com>

> ---
>   backends/hostmem.c | 12 ++++++++----
>   1 file changed, 8 insertions(+), 4 deletions(-)
> 
> diff --git a/backends/hostmem.c b/backends/hostmem.c
> index 30f69b2cb5..987f6f591e 100644
> --- a/backends/hostmem.c
> +++ b/backends/hostmem.c
> @@ -344,9 +344,11 @@ host_memory_backend_memory_complete(UserCreatable *uc, Error **errp)
>       unsigned long lastbit = find_last_bit(backend->host_nodes, MAX_NODES);
>       /* lastbit == MAX_NODES means maxnode = 0 */
>       unsigned long maxnode = (lastbit + 1) % (MAX_NODES + 1);
> -    /* ensure policy won't be ignored in case memory is preallocated
> +    /*
> +     * Ensure policy won't be ignored in case memory is preallocated
>        * before mbind(). note: MPOL_MF_STRICT is ignored on hugepages so
> -     * this doesn't catch hugepage case. */
> +     * this doesn't catch hugepage case.
> +     */
>       unsigned flags = MPOL_MF_STRICT | MPOL_MF_MOVE;
>       int mode = backend->policy;
>   
> @@ -363,7 +365,8 @@ host_memory_backend_memory_complete(UserCreatable *uc, Error **errp)
>           return;
>       }
>   
> -    /* We can have up to MAX_NODES nodes, but we need to pass maxnode+1
> +    /*
> +     * We can have up to MAX_NODES nodes, but we need to pass maxnode+1
>        * as argument to mbind() due to an old Linux bug (feature?) which
>        * cuts off the last specified node. This means backend->host_nodes
>        * must have MAX_NODES+1 bits available.
> @@ -391,7 +394,8 @@ host_memory_backend_memory_complete(UserCreatable *uc, Error **errp)
>           }
>       }
>   #endif
> -    /* Preallocate memory after the NUMA policy has been instantiated.
> +    /*
> +     * Preallocate memory after the NUMA policy has been instantiated.
>        * This is necessary to guarantee memory is allocated with
>        * specified NUMA policy in place.
>        */


