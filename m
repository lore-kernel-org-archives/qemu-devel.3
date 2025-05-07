Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1C8CDC369DC
	for <qemu-devel@archiver.kernel.org>; Wed,  7 May 2025 06:36:12 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uCYNc-0000wc-E0; Wed, 07 May 2025 02:35:44 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <wei.liu@kernel.org>)
 id 1uCYNa-0000tp-Ku
 for qemu-devel@nongnu.org; Wed, 07 May 2025 02:35:42 -0400
Received: from nyc.source.kernel.org ([147.75.193.91])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <wei.liu@kernel.org>)
 id 1uCYNZ-0001GD-5C
 for qemu-devel@nongnu.org; Wed, 07 May 2025 02:35:42 -0400
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by nyc.source.kernel.org (Postfix) with ESMTP id 2D59EA4D49D;
 Wed,  7 May 2025 06:35:33 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A51E0C4CEE7;
 Wed,  7 May 2025 06:35:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1746599732;
 bh=l1J+yu/udDUI/mMMp6c3ZkSHRSKvfdoXZZ+RGOaCt3o=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=eASQR1m0eTvttMBVnnIz/iUqpE5yZ+aPjDBVyurrHVAMOOySgLp5kj8tMkSv6hkbh
 8z2CG1dXaZkqs1bhxGC8/Tvr2+WIj41LgN36LUTCaa+GdqpDjrSWJG0H8WKzyVQjr1
 yLPWofImyMa9uJkdQmC6Vy/5D2tMgNdQsLt79pxdqR9rZ1dws/tRKjS0TzO80VpKfl
 KW5beXBP7BvmLXo/pag6qF5ughUY2cHC0fyAFRrvyyIQQCS8br0yJd6hPKApvdT5Yc
 0//6ab7cdu2B6ztRpCSCfgPBssvAFKeokUEzDjZzvl5oPlPjTAj6EhFeu+nG0C7Knr
 SWq3rkqwucC+w==
Date: Wed, 7 May 2025 06:35:31 +0000
From: Wei Liu <wei.liu@kernel.org>
To: Philippe =?iso-8859-1?Q?Mathieu-Daud=E9?= <philmd@linaro.org>
Cc: qemu-devel@nongnu.org, Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 Wei Liu <wei.liu@kernel.org>
Subject: Re: [PULL 05/22] target/i386/hvf: Include missing
 'exec/target_page.h' header
Message-ID: <aBr_MzqaoGwN7gpQ@liuwe-devbox-ubuntu-v2.tail21d00.ts.net>
References: <20250506143512.4315-1-philmd@linaro.org>
 <20250506143512.4315-6-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20250506143512.4315-6-philmd@linaro.org>
Received-SPF: pass client-ip=147.75.193.91; envelope-from=wei.liu@kernel.org;
 helo=nyc.source.kernel.org
X-Spam_score_int: -57
X-Spam_score: -5.8
X-Spam_bar: -----
X-Spam_report: (-5.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.414,
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

On Tue, May 06, 2025 at 04:34:54PM +0200, Philippe Mathieu-Daudé wrote:
> Include "exec/target_page.h" to be able to compile HVF on x86_64:
> 
>   ../target/i386/hvf/hvf.c:139:49: error: use of undeclared identifier 'TARGET_PAGE_SIZE'
>               uint64_t dirty_page_start = gpa & ~(TARGET_PAGE_SIZE - 1u);
>                                                 ^
>   ../target/i386/hvf/hvf.c:141:45: error: use of undeclared identifier 'TARGET_PAGE_SIZE'
>               hv_vm_protect(dirty_page_start, TARGET_PAGE_SIZE,
> 
> Fixes: 9c2ff9cdc9b ("exec/cpu-all: remove exec/target_page include")
> Reported-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
> Reported-by: Wei Liu <wei.liu@kernel.org>
> Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
> Message-Id: <20250425174310.70890-1-philmd@linaro.org>
> Reviewed-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>

FYI Paolo merged a patch from me that does the same thing. My patch is
already in the master branch.

Wei.

> ---
>  target/i386/hvf/hvf.c | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/target/i386/hvf/hvf.c b/target/i386/hvf/hvf.c
> index 99e37a33e50..b16fb066758 100644
> --- a/target/i386/hvf/hvf.c
> +++ b/target/i386/hvf/hvf.c
> @@ -50,6 +50,7 @@
>  #include "qemu/error-report.h"
>  #include "qemu/memalign.h"
>  #include "qapi/error.h"
> +#include "exec/target_page.h"
>  #include "migration/blocker.h"
>  
>  #include "system/hvf.h"
> -- 
> 2.47.1
> 

