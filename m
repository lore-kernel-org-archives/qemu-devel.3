Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9CD09C2BD09
	for <qemu-devel@archiver.kernel.org>; Mon,  1 Jul 2024 20:50:18 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sONxs-0007ct-7V; Mon, 01 Jul 2024 16:49:32 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mark.cave-ayland@ilande.co.uk>)
 id 1sONxn-0007cX-15
 for qemu-devel@nongnu.org; Mon, 01 Jul 2024 16:49:27 -0400
Received: from mail.ilande.co.uk ([2001:41c9:1:41f::167])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mark.cave-ayland@ilande.co.uk>)
 id 1sONxl-00084K-3i
 for qemu-devel@nongnu.org; Mon, 01 Jul 2024 16:49:26 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=ilande.co.uk; s=20220518; h=Subject:Content-Transfer-Encoding:Content-Type:
 In-Reply-To:From:References:Cc:To:MIME-Version:Date:Message-ID:Sender:
 Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender
 :Resent-To:Resent-Cc:Resent-Message-ID;
 bh=zUAWeZFdRjb5vEOyCQB7solSdNTkQvfQGG7LSUisZQE=; b=nMHP0ch7VHsby8WJh3vaSLBUKn
 ECN2JdWEeTrKJBEmpG9sdTRjWX8s14/pfabOajRd6l8cWfESpm12dk9jT297dLjDcBkThHjKUYUw7
 66+o0LTF8uD7EdpNwIQDu64MELgyUbcEMcZbNoNP8tCTi35yLYTVWIrG8lNR0ISiW0l9WKJO0SnvK
 ZWCXEFcCDE7HIAIRma8D4ayDExxMoJZ/MvQiuxw9p2GMeqb06qyrYrqNwC/fi/pnJqnaT0pmfDfB6
 CCaxloy2Xn5qebajBmMWi9qxJi0+P9TwxuAJxtWPP6Wr/PudHzc3sfXT1Ute0HIHi2vx6VwgFD4rs
 pNU6ustSBvS2eQcPf6hSScfBa5X0fu7dHL0D1njdmdZAvP6V4HrVQrbIs4nJ0xhEVv8rzSPj0Xl/h
 pOeAMgn6K+wqSktQlGj2uWC8qwiLTXo4b0bWZm1lnhu1hCRnfEty7kAUcsUSna+9PmOzX980o7UOx
 yLtDwl3l1Vf6Veyu2Y5hBcD6Ok8ovtFdUplMZpqqdruE2vzBCliEuY41+1bB+8q2z3wpsooRH3VZ+
 +Q0cgDhmWub0XIIidrRSYpmgPgZvJ6qlzO8NsAFKLZ4XXkEPMnwVcw5NqTjlL5UiOqUTr8wFSIJOC
 1CiVsh4x7ma+w8iaoobFGXMEYn0krktnBf8Y9iubM=;
Received: from [2a00:23c4:8bb4:4000:a4da:be8a:f5f6:663]
 by mail.ilande.co.uk with esmtpsa (TLS1.3:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.92) (envelope-from <mark.cave-ayland@ilande.co.uk>)
 id 1sONwK-0005zo-PB; Mon, 01 Jul 2024 21:47:57 +0100
Message-ID: <e9072d75-06e2-4439-bc47-668d921e3202@ilande.co.uk>
Date: Mon, 1 Jul 2024 21:49:16 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: Zheyu Ma <zheyuma97@gmail.com>
Cc: qemu-devel@nongnu.org
References: <20240630130426.2966539-1-zheyuma97@gmail.com>
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
In-Reply-To: <20240630130426.2966539-1-zheyuma97@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-SA-Exim-Connect-IP: 2a00:23c4:8bb4:4000:a4da:be8a:f5f6:663
X-SA-Exim-Mail-From: mark.cave-ayland@ilande.co.uk
Subject: Re: [PATCH] hw/display/tcx: Fix out-of-bounds access in
 tcx_blit_writel
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

On 30/06/2024 14:04, Zheyu Ma wrote:

> This patch addresses a potential out-of-bounds memory access issue in the
> tcx_blit_writel function. It adds bounds checking to ensure that memory
> accesses do not exceed the allocated VRAM size. If an out-of-bounds access
> is detected, an error is logged using qemu_log_mask.
> 
> ASAN log:
> ==2960379==ERROR: AddressSanitizer: SEGV on unknown address 0x7f524752fd01 (pc 0x7f525c2c4881 bp 0x7ffdaf87bfd0 sp 0x7ffdaf87b788 T0)
> ==2960379==The signal is caused by a READ memory access.
>      #0 0x7f525c2c4881 in memcpy string/../sysdeps/x86_64/multiarch/memmove-vec-unaligned-erms.S:222
>      #1 0x55aa782bd5b1 in __asan_memcpy llvm/compiler-rt/lib/asan/asan_interceptors_memintrinsics.cpp:22:3
>      #2 0x55aa7854dedd in tcx_blit_writel hw/display/tcx.c:590:13
> 
> Reproducer:
> cat << EOF | qemu-system-sparc -display none \
> -machine accel=qtest, -m 512M -machine LX -m 256 -qtest stdio
> writel 0x562e98c4 0x3d92fd01
> EOF
> 
> Signed-off-by: Zheyu Ma <zheyuma97@gmail.com>
> ---
>   hw/display/tcx.c | 9 +++++++++
>   1 file changed, 9 insertions(+)
> 
> diff --git a/hw/display/tcx.c b/hw/display/tcx.c
> index 99507e7638..af43bea7f2 100644
> --- a/hw/display/tcx.c
> +++ b/hw/display/tcx.c
> @@ -33,6 +33,7 @@
>   #include "migration/vmstate.h"
>   #include "qemu/error-report.h"
>   #include "qemu/module.h"
> +#include "qemu/log.h"
>   #include "qom/object.h"
>   
>   #define TCX_ROM_FILE "QEMU,tcx.bin"
> @@ -577,6 +578,14 @@ static void tcx_blit_writel(void *opaque, hwaddr addr,
>           addr = (addr >> 3) & 0xfffff;
>           adsr = val & 0xffffff;
>           len = ((val >> 24) & 0x1f) + 1;
> +
> +        if (addr + len > s->vram_size || adsr + len > s->vram_size) {
> +            qemu_log_mask(LOG_GUEST_ERROR,
> +                          "%s: VRAM access out of bounds. addr: 0x%lx, adsr: 0x%x, len: %u\n",
> +                          __func__, addr, adsr, len);
> +            return;
> +        }
> +
>           if (adsr == 0xffffff) {
>               memset(&s->vram[addr], s->tmpblit, len);
>               if (s->depth == 24) {

What would happen if the source data plus length goes beyond the end of the 
framebuffer but the destination lies completely within it? Presumably the length of 
the data copy should be restricted to the length of the source data rather than the 
entire copy being ignored?


ATB,

Mark.


