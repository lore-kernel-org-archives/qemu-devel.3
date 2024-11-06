Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D6AF8D59F7F
	for <qemu-devel@archiver.kernel.org>; Wed,  6 Nov 2024 22:56:08 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t8ow1-0007Go-Mg; Wed, 06 Nov 2024 17:55:33 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mark.cave-ayland@ilande.co.uk>)
 id 1t8ow0-0007G3-BK; Wed, 06 Nov 2024 17:55:32 -0500
Received: from mail.ilande.co.uk ([2001:41c9:1:41f::167])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mark.cave-ayland@ilande.co.uk>)
 id 1t8ovy-0002UW-Nt; Wed, 06 Nov 2024 17:55:32 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=ilande.co.uk; s=20220518; h=Subject:Content-Transfer-Encoding:Content-Type:
 In-Reply-To:From:References:Cc:To:MIME-Version:Date:Message-ID:Sender:
 Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender
 :Resent-To:Resent-Cc:Resent-Message-ID;
 bh=7zmiKWqxLhVTrE310twB6jPlyzzM5mQySRnKBJKboww=; b=nOR0vakk0J4hiHltHCNYYxeX9J
 fL4Y5ASNNkCJQgHrTTlYHIyxb4ANFvqF7CmIT1sKJMIAcMOnTTEg6zBcNNrXhcWABTRJJeSq0Leno
 zAlns5oVSYUzDEvA53/Q/I6E6ltyfIWdLJx1o6PI1XkMFqNCsuHSPW+tFoQaQndEva3eSz85QsWOI
 zbxusZk2uauEV4/lIO6zIVtOfsQqY4Ckm8vZrFIFaa9I3ShWMXCK7eTjyTx8aHwyFv2C65LfVDRXy
 cpqB0J9YWMj8QJwveMwmH8WdY3wqpS6YtbFHzB7nnZ9A1joKhc4gzC19QgcYA/ZJP68TsYAAGaTbs
 HmCpF4ZEe8wscldFtPZtvTYUZlmc8o8MxtinaFFFV1k1pyeHwVAdiJGi0AhG8/h0f2wJE5/UX5ax9
 AWnwgYOjE18P2EUUxI6vEWz2qJ8OTZvfxeKeu9QrIM1TQRuR/ry4Q35rN168Of6GCr84w5lhnkCsV
 YVxKj5WVG/1yCUFHGlfXNWvS5cVht8bB1WGgHZmu2gUqNAms8D2AW0kuAwrKiyl+n98A/wjl/3avk
 gs8b+MHyGEYEBXkMfl9Yj0/o36yd3aT6GujPE+5l6UWVUAVKVTHl8aTk43Erp6/R2UlljsKNcNpb9
 jBHb/K1NLGohqCWFiE3Yez6SQ9SkIV8pBa3uiOmV4=;
Received: from [2a00:23c4:8bb8:f600:5c84:8fbb:e5d9:991a]
 by mail.ilande.co.uk with esmtpsa (TLS1.3:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.92) (envelope-from <mark.cave-ayland@ilande.co.uk>)
 id 1t8ovR-0005po-6K; Wed, 06 Nov 2024 22:55:01 +0000
Message-ID: <d577b608-9494-4041-84a0-a59ae5ba9702@ilande.co.uk>
Date: Wed, 6 Nov 2024 22:55:13 +0000
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: Alexander Graf <graf@amazon.com>, qemu-devel@nongnu.org
Cc: Eduardo Habkost <eduardo@habkost.net>,
 Richard Henderson <richard.henderson@linaro.org>,
 Zhao Liu <zhao1.liu@intel.com>, Paolo Bonzini <pbonzini@redhat.com>,
 qemu-stable@nongnu.org
References: <20241106154329.67218-1-graf@amazon.com>
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
In-Reply-To: <20241106154329.67218-1-graf@amazon.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-SA-Exim-Connect-IP: 2a00:23c4:8bb8:f600:5c84:8fbb:e5d9:991a
X-SA-Exim-Mail-From: mark.cave-ayland@ilande.co.uk
Subject: Re: [PATCH] target/i386: Fix legacy page table walk
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

On 06/11/2024 15:43, Alexander Graf wrote:

> Commit b56617bbcb4 ("target/i386: Walk NPT in guest real mode") added
> logic to run the page table walker even in real mode if we are in NPT
> mode.  That function then determined whether real mode or paging is
> active based on whether the pg_mode variable was 0.
> 
> Unfortunately pg_mode is 0 in two situations:
> 
>    1) Paging is disabled (real mode)
>    2) Paging is in 2-level paging mode (32bit without PAE)
> 
> That means the walker now assumed that 2-level paging mode was real
> mode, breaking NetBSD as well as Windows XP.
> 
> To fix that, this patch adds a new PG flag to pg_mode which indicates
> whether paging is active at all and uses that to determine whether we
> are in real mode or not.
> 
> Cc: qemu-stable@nongnu.org
> Resolves: https://gitlab.com/qemu-project/qemu/-/issues/2654
> Fixes: b56617bbcb4 ("target/i386: Walk NPT in guest real mode")
> Signed-off-by: Alexander Graf <graf@amazon.com>
> Reported-by: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
> ---
>   target/i386/cpu.h                    | 1 +
>   target/i386/tcg/seg_helper.c         | 2 +-
>   target/i386/tcg/sysemu/excp_helper.c | 2 +-
>   3 files changed, 3 insertions(+), 2 deletions(-)
> 
> diff --git a/target/i386/cpu.h b/target/i386/cpu.h
> index c24d81bf31..99d4805ac1 100644
> --- a/target/i386/cpu.h
> +++ b/target/i386/cpu.h
> @@ -346,6 +346,7 @@ typedef enum X86Seg {
>   #define PG_MODE_PKE      (1 << 17)
>   #define PG_MODE_PKS      (1 << 18)
>   #define PG_MODE_SMEP     (1 << 19)
> +#define PG_MODE_PG       (1 << 20)
>   
>   #define MCG_CTL_P       (1ULL<<8)   /* MCG_CAP register available */
>   #define MCG_SER_P       (1ULL<<24) /* MCA recovery/new status bits */
> diff --git a/target/i386/tcg/seg_helper.c b/target/i386/tcg/seg_helper.c
> index 02ae6a0d1f..71962113fb 100644
> --- a/target/i386/tcg/seg_helper.c
> +++ b/target/i386/tcg/seg_helper.c
> @@ -94,7 +94,7 @@ static uint32_t popl(StackAccess *sa)
>   
>   int get_pg_mode(CPUX86State *env)
>   {
> -    int pg_mode = 0;
> +    int pg_mode = PG_MODE_PG;
>       if (!(env->cr[0] & CR0_PG_MASK)) {
>           return 0;
>       }
> diff --git a/target/i386/tcg/sysemu/excp_helper.c b/target/i386/tcg/sysemu/excp_helper.c
> index da187c8792..02d3486421 100644
> --- a/target/i386/tcg/sysemu/excp_helper.c
> +++ b/target/i386/tcg/sysemu/excp_helper.c
> @@ -298,7 +298,7 @@ static bool mmu_translate(CPUX86State *env, const TranslateParams *in,
>           /* combine pde and pte nx, user and rw protections */
>           ptep &= pte ^ PG_NX_MASK;
>           page_size = 4096;
> -    } else if (pg_mode) {
> +    } else if (pg_mode & PG_MODE_PG) {
>           /*
>            * Page table level 2
>            */

Thanks Alex! This patch fixes the issue for me, so:

Tested-by: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>


ATB,

Mark.


