Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E2A80FD0057
	for <qemu-devel@archiver.kernel.org>; Sun,  1 Mar 2026 14:51:43 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vwi8e-00011J-Fz; Sun, 01 Mar 2026 09:51:20 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dg@treblig.org>) id 1vwi8c-000116-Dj
 for qemu-devel@nongnu.org; Sun, 01 Mar 2026 09:51:18 -0500
Received: from mx.treblig.org ([2a00:1098:5b::1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dg@treblig.org>) id 1vwi8a-0006fy-Dc
 for qemu-devel@nongnu.org; Sun, 01 Mar 2026 09:51:18 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=treblig.org
 ; s=bytemarkmx;
 h=Content-Type:MIME-Version:Message-ID:Subject:From:Date:From
 :Subject; bh=cM31RwFvWnKv3KgpYPW2esnRxSyZFPXm0mO3WRlc3Ro=; b=SwJ/k0pq9H1qt9Jv
 ucNr4NlvIyCUx6OsHI9aY5sNZh6QjCmHUPlDczV00cCCGnJ3S4f/E1sVx2uCOFpuOOTawxD2yyR+T
 5de2Gqfi1FFvDzF/7MPyyCbe8GCJYmwatf9q4sHU3xa24wUni+RWx6NXVQC7m+lH0i4QyfPn5p9qo
 HPqUAUVf3F0ntcItm+W0jGDM+nrfWLpvlL4I9cZYLd0HXhiCuXXSa0fYVyfL0xrBZPDLDlOEHA0XB
 kLt/+CWkt3g5AX2skXve682Ltvx54iiq0qXs1uZ/t15BWHMdagPRMiD7GvsmRouBp3Dd6WDgvuAQl
 4NImKwGdHpQBd7vu9Q==;
Received: from dg by mx.treblig.org with local (Exim 4.98.2)
 (envelope-from <dg@treblig.org>) id 1vwi8V-00000006KFd-2U30;
 Sun, 01 Mar 2026 14:51:11 +0000
Date: Sun, 1 Mar 2026 14:51:11 +0000
From: "Dr. David Alan Gilbert" <dave@treblig.org>
To: Philippe =?iso-8859-1?Q?Mathieu-Daud=E9?= <philmd@linaro.org>
Cc: qemu-devel@nongnu.org
Subject: Re: [PULL 02/16] target/alpha: Use explicit little-endian LD/ST API
Message-ID: <aaRSXzwmZBoRD0e7@gallifrey>
References: <20260202212019.94205-1-philmd@linaro.org>
 <20260202212019.94205-3-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260202212019.94205-3-philmd@linaro.org>
X-Chocolate: 70 percent or better cocoa solids preferably
X-Operating-System: Linux/6.12.48+deb13-amd64 (x86_64)
X-Uptime: 14:50:22 up 125 days, 14:26,  4 users,  load average: 0.00, 0.00,
 0.00
User-Agent: Mutt/2.2.13 (2024-03-09)
Received-SPF: pass client-ip=2a00:1098:5b::1; envelope-from=dg@treblig.org;
 helo=mx.treblig.org
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

* Philippe Mathieu-Daudé (philmd@linaro.org) wrote:
> The Alpha architecture uses little endianness. Directly

Wasn't there one, odd case of the T3E running it big-endian?
(I have no idea how that worked in practice).

Dave

> use the little-endian LD/ST API.
> 
> Mechanical change running:
> 
>   $ for a in uw w l q; do \
>       sed -i -e "s/ld${a}_p(/ld${a}_le_p(/" \
>         $(git grep -wlE '(ld|st)u?[wlq]_p' target/alpha/);
>     done
> 
> Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
> Reviewed-by: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>
> Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
> Message-Id: <20251224160040.88612-2-philmd@linaro.org>
> ---
>  target/alpha/helper.c | 11 ++++++-----
>  1 file changed, 6 insertions(+), 5 deletions(-)
> 
> diff --git a/target/alpha/helper.c b/target/alpha/helper.c
> index a9af52a928f..80542cb0665 100644
> --- a/target/alpha/helper.c
> +++ b/target/alpha/helper.c
> @@ -214,17 +214,18 @@ static int get_physical_address(CPUAlphaState *env, target_ulong addr,
>  
>      pt = env->ptbr;
>  
> -    /* TODO: rather than using ldq_phys() to read the page table we should
> +    /*
> +     * TODO: rather than using ldq_phys_le() to read the page table we should
>       * use address_space_ldq() so that we can handle the case when
>       * the page table read gives a bus fault, rather than ignoring it.
> -     * For the existing code the zero data that ldq_phys will return for
> +     * For the existing code the zero data that ldq_phys_le will return for
>       * an access to invalid memory will result in our treating the page
>       * table as invalid, which may even be the right behaviour.
>       */
>  
>      /* L1 page table read.  */
>      index = (addr >> (TARGET_PAGE_BITS + 20)) & 0x3ff;
> -    L1pte = ldq_phys(cs->as, pt + index*8);
> +    L1pte = ldq_phys_le(cs->as, pt + index * 8);
>  
>      if (unlikely((L1pte & PTE_VALID) == 0)) {
>          ret = MM_K_TNV;
> @@ -237,7 +238,7 @@ static int get_physical_address(CPUAlphaState *env, target_ulong addr,
>  
>      /* L2 page table read.  */
>      index = (addr >> (TARGET_PAGE_BITS + 10)) & 0x3ff;
> -    L2pte = ldq_phys(cs->as, pt + index*8);
> +    L2pte = ldq_phys_le(cs->as, pt + index * 8);
>  
>      if (unlikely((L2pte & PTE_VALID) == 0)) {
>          ret = MM_K_TNV;
> @@ -250,7 +251,7 @@ static int get_physical_address(CPUAlphaState *env, target_ulong addr,
>  
>      /* L3 page table read.  */
>      index = (addr >> TARGET_PAGE_BITS) & 0x3ff;
> -    L3pte = ldq_phys(cs->as, pt + index*8);
> +    L3pte = ldq_phys_le(cs->as, pt + index * 8);
>  
>      phys = L3pte >> 32 << TARGET_PAGE_BITS;
>      if (unlikely((L3pte & PTE_VALID) == 0)) {
> -- 
> 2.52.0
> 
> 
-- 
 -----Open up your eyes, open up your mind, open up your code -------   
/ Dr. David Alan Gilbert    |       Running GNU/Linux       | Happy  \ 
\        dave @ treblig.org |                               | In Hex /
 \ _________________________|_____ http://www.treblig.org   |_______/

