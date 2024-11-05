Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3D971D3E77E
	for <qemu-devel@archiver.kernel.org>; Tue,  5 Nov 2024 22:55:44 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t8SSY-0004SL-Jf; Tue, 05 Nov 2024 17:55:39 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mark.cave-ayland@ilande.co.uk>)
 id 1t8SSA-00046F-AW
 for qemu-devel@nongnu.org; Tue, 05 Nov 2024 17:55:17 -0500
Received: from mail.ilande.co.uk ([2001:41c9:1:41f::167])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mark.cave-ayland@ilande.co.uk>)
 id 1t8SS7-00067e-SP
 for qemu-devel@nongnu.org; Tue, 05 Nov 2024 17:55:13 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=ilande.co.uk; s=20220518; h=Subject:Content-Transfer-Encoding:Content-Type:
 In-Reply-To:From:References:Cc:To:MIME-Version:Date:Message-ID:Sender:
 Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender
 :Resent-To:Resent-Cc:Resent-Message-ID;
 bh=jxLKK1uuAOV2nzNtzzSG6I3MhJcU3L2MdPz4hfmB14g=; b=OapPC6DMaj6vMsmUFfqiAl+FmJ
 nqoE035tq40tl3YlvZ8naPrNfJ9QRPAIR3mAtXsC396kKz7WvSAI7l7fiBy/phCmwgOWI3inT2BEv
 F1Uj838LVehOJFzF7QSUK/BghwfOCWvPOmCdEYDU47KslpRolPqyynSqNlXs7DQWiq9JlQiRn0qzc
 ZWxfaDW59ehpv+dEBLpxJ8aY2CvXrVx1mS6Sz4y1b0ot8+P5Jy0GYBX0gxRkXbWcTGYMSvxqwCea6
 htsOOOqX6HIrRqRz3RcaNxVONTRCPiTFN9/jPh7X5QXgrp930E4xmCa0UMRhr23q8NiLPzqAHvhxJ
 4vY2Y1dS01tal9NUJNx+6ECE91bdzuT4NpGcx4EHeqBo8M4ftMlG5Dco9y3VK6MJ3dkls/7/AC3A8
 9pv0EZ99Mr//Kc9hDJ03djAIePGMJJovwMFmMGXpt2JtNAPZNIv414PnIgNkhqVhld/tzhaOJkhdb
 obRK3bKPwvsJZ/y0oGAhrr517mx2/72cuVlIOJOUsxrR9X9uqc7pPj1bT9mzIyh11OXevwQaDTWje
 eit4y4bva+ZsGpDoi0A+uUhWrlAt6UJKYK05uemPtulp74ztW6si0qK0YALOH6Yr486xEJAFT7dVK
 tkHXuNuBg/MTVIFI64tySrJqYMoLwtkCo6wKHCvK4=;
Received: from [2a00:23c4:8bb8:f600:73fa:5593:d3ba:8410]
 by mail.ilande.co.uk with esmtpsa (TLS1.3:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.92) (envelope-from <mark.cave-ayland@ilande.co.uk>)
 id 1t8SRe-0003qk-L2; Tue, 05 Nov 2024 22:54:46 +0000
Message-ID: <cc832858-9161-466e-ab52-9909f120fb12@ilande.co.uk>
Date: Tue, 5 Nov 2024 22:54:58 +0000
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: Alexander Graf <graf@amazon.com>, qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Eduardo Habkost <eduardo@habkost.net>, Jan Kiszka <jan.kiszka@siemens.com>,
 Eduard Vlad <evlad@amazon.de>
References: <20240921085712.28902-1-graf@amazon.com>
Content-Language: en-US
From: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
Autocrypt: addr=mark.cave-ayland@ilande.co.uk; keydata=
 xsBNBFQJuzwBCADAYvxrwUh1p/PvUlNFwKosVtVHHplgWi5p29t58QlOUkceZG0DBYSNqk93
 3JzBTbtd4JfFcSupo6MNNOrCzdCbCjZ64ik8ycaUOSzK2tKbeQLEXzXoaDL1Y7vuVO7nL9bG
 E5Ru3wkhCFc7SkoypIoAUqz8EtiB6T89/D9TDEyjdXUacc53R5gu8wEWiMg5MQQuGwzbQy9n
 PFI+mXC7AaEUqBVc2lBQVpAYXkN0EyqNNT12UfDLdxaxaFpUAE2pCa2LTyo5vn5hEW+i3VdN
 PkmjyPvL6DdY03fvC01PyY8zaw+UI94QqjlrDisHpUH40IUPpC/NB0LwzL2aQOMkzT2NABEB
 AAHNME1hcmsgQ2F2ZS1BeWxhbmQgPG1hcmsuY2F2ZS1heWxhbmRAaWxhbmRlLmNvLnVrPsLA
 eAQTAQIAIgUCVAm7PAIbAwYLCQgHAwIGFQgCCQoLBBYCAwECHgECF4AACgkQW8LFb64PMh9f
 NAgAuc3ObOEY8NbZko72AGrg2tWKdybcMVITxmcor4hb9155o/OWcA4IDbeATR6cfiDL/oxU
 mcmtXVgPqOwtW3NYAKr5g/FrZZ3uluQ2mtNYAyTFeALy8YF7N3yhs7LOcpbFP7tEbkSzoXNG
 z8iYMiYtKwttt40WaheWuRs0ZOLbs6yoczZBDhna3Nj0LA3GpeJKlaV03O4umjKJgACP1c/q
 T2Pkg+FCBHHFP454+waqojHp4OCBo6HyK+8I4wJRa9Z0EFqXIu8lTDYoggeX0Xd6bWeCFHK3
 DhD0/Xi/kegSW33unsp8oVcM4kcFxTkpBgj39dB4KwAUznhTJR0zUHf63M7ATQRUCbs8AQgA
 y7kyevA4bpetM/EjtuqQX4U05MBhEz/2SFkX6IaGtTG2NNw5wbcAfhOIuNNBYbw6ExuaJ3um
 2uLseHnudmvN4VSJ5Hfbd8rhqoMmmO71szgT/ZD9MEe2KHzBdmhmhxJdp+zQNivy215j6H27
 14mbC2dia7ktwP1rxPIX1OOfQwPuqlkmYPuVwZP19S4EYnCELOrnJ0m56tZLn5Zj+1jZX9Co
 YbNLMa28qsktYJ4oU4jtn6V79H+/zpERZAHmH40IRXdR3hA+Ye7iC/ZpWzT2VSDlPbGY9Yja
 Sp7w2347L5G+LLbAfaVoejHlfy/msPeehUcuKjAdBLoEhSPYzzdvEQARAQABwsBfBBgBAgAJ
 BQJUCbs8AhsMAAoJEFvCxW+uDzIfabYIAJXmBepHJpvCPiMNEQJNJ2ZSzSjhic84LTMWMbJ+
 opQgr5cb8SPQyyb508fc8b4uD8ejlF/cdbbBNktp3BXsHlO5BrmcABgxSP8HYYNsX0n9kERv
 NMToU0oiBuAaX7O/0K9+BW+3+PGMwiu5ml0cwDqljxfVN0dUBZnQ8kZpLsY+WDrIHmQWjtH+
 Ir6VauZs5Gp25XLrL6bh/SL8aK0BX6y79m5nhfKI1/6qtzHAjtMAjqy8ChPvOqVVVqmGUzFg
 KPsrrIoklWcYHXPyMLj9afispPVR8e0tMKvxzFBWzrWX1mzljbBlnV2n8BIwVXWNbgwpHSsj
 imgcU9TTGC5qd9g=
In-Reply-To: <20240921085712.28902-1-graf@amazon.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-SA-Exim-Connect-IP: 2a00:23c4:8bb8:f600:73fa:5593:d3ba:8410
X-SA-Exim-Mail-From: mark.cave-ayland@ilande.co.uk
Subject: Re: [PATCH v3] target-i386: Walk NPT in guest real mode
X-SA-Exim-Version: 4.2.1 (built Wed, 08 May 2019 21:11:16 +0000)
X-SA-Exim-Scanned: Yes (on mail.ilande.co.uk)
Received-SPF: pass client-ip=2001:41c9:1:41f::167;
 envelope-from=mark.cave-ayland@ilande.co.uk; helo=mail.ilande.co.uk
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

On 21/09/2024 09:57, Alexander Graf wrote:

> When translating virtual to physical address with a guest CPU that
> supports nested paging (NPT), we need to perform every page table walk
> access indirectly through the NPT, which we correctly do.
> 
> However, we treat real mode (no page table walk) special: In that case,
> we currently just skip any walks and translate VA -> PA. With NPT
> enabled, we also need to then perform NPT walk to do GVA -> GPA -> HPA
> which we fail to do so far.
> 
> The net result of that is that TCG VMs with NPT enabled that execute
> real mode code (like SeaBIOS) end up with GPA==HPA mappings which means
> the guest accesses host code and data. This typically shows as failure
> to boot guests.
> 
> This patch changes the page walk logic for NPT enabled guests so that we
> always perform a GVA -> GPA translation and then skip any logic that
> requires an actual PTE.
> 
> That way, all remaining logic to walk the NPT stays and we successfully
> walk the NPT in real mode.
> 
> Fixes: fe441054bb3f0 ("target-i386: Add NPT support")
> 
> Signed-off-by: Alexander Graf <graf@amazon.com>
> Reported-by: Eduard Vlad <evlad@amazon.de>
> Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
> 
> ---
> 
> v1 -> v2:
> 
>    - Remove hack where we fake a PTE and instead just set the
>      corresponding resolved variables and jump straight to the
>      stage2 code.
> 
> v2 -> v3:
> 
>    - Fix comment
> ---
>   target/i386/tcg/sysemu/excp_helper.c | 14 ++++++++++++--
>   1 file changed, 12 insertions(+), 2 deletions(-)
> 
> diff --git a/target/i386/tcg/sysemu/excp_helper.c b/target/i386/tcg/sysemu/excp_helper.c
> index 8fb05b1f53..24dd6935f9 100644
> --- a/target/i386/tcg/sysemu/excp_helper.c
> +++ b/target/i386/tcg/sysemu/excp_helper.c
> @@ -298,7 +298,7 @@ static bool mmu_translate(CPUX86State *env, const TranslateParams *in,
>           /* combine pde and pte nx, user and rw protections */
>           ptep &= pte ^ PG_NX_MASK;
>           page_size = 4096;
> -    } else {
> +    } else if (pg_mode) {
>           /*
>            * Page table level 2
>            */
> @@ -343,6 +343,15 @@ static bool mmu_translate(CPUX86State *env, const TranslateParams *in,
>           ptep &= pte | PG_NX_MASK;
>           page_size = 4096;
>           rsvd_mask = 0;
> +    } else {
> +        /*
> +         * No paging (real mode), let's tentatively resolve the address as 1:1
> +         * here, but conditionally still perform an NPT walk on it later.
> +         */
> +        page_size = 0x40000000;
> +        paddr = in->addr;
> +        prot = PAGE_READ | PAGE_WRITE | PAGE_EXEC;
> +        goto stage2;
>       }
>   
>   do_check_protect:
> @@ -420,6 +429,7 @@ do_check_protect_pse36:
>   
>       /* merge offset within page */
>       paddr = (pte & PG_ADDRESS_MASK & ~(page_size - 1)) | (addr & (page_size - 1));
> +stage2:
>   
>       /*
>        * Note that NPT is walked (for both paging structures and final guest
> @@ -562,7 +572,7 @@ static bool get_physical_address(CPUX86State *env, vaddr addr,
>               addr = (uint32_t)addr;
>           }
>   
> -        if (likely(env->cr[0] & CR0_PG_MASK)) {
> +        if (likely(env->cr[0] & CR0_PG_MASK || use_stage2)) {
>               in.cr3 = env->cr[3];
>               in.mmu_idx = mmu_idx;
>               in.ptw_idx = use_stage2 ? MMU_NESTED_IDX : MMU_PHYS_IDX;

Hi Alex,

This commit appears to break my WinXP boot test: with this patch applied, attempting 
to boot WinXP from CDROM fails with SeaBIOS getting stuck early in a boot loop. It is 
possible to reproduce the issue easily with:

   ./build/qemu-system-x86_64 -cdrom winxp.iso -boot d


ATB,

Mark.


