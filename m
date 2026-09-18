Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 52F24C982DC
	for <qemu-devel@archiver.kernel.org>; Fri, 18 Sep 2026 13:15:04 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x7YQ0-0002Rk-BU; Fri, 18 Sep 2026 09:14:20 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mark.cave-ayland@ilande.co.uk>)
 id 1x7YPw-0002NZ-2v
 for qemu-devel@nongnu.org; Fri, 18 Sep 2026 09:14:16 -0400
Received: from mail.ilande.co.uk ([2001:41c9:1:41f::167])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mark.cave-ayland@ilande.co.uk>)
 id 1x7YPu-0007QZ-Hx
 for qemu-devel@nongnu.org; Fri, 18 Sep 2026 09:14:15 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=ilande.co.uk; s=20220518; h=Subject:Content-Transfer-Encoding:Content-Type:
 In-Reply-To:From:References:Cc:To:MIME-Version:Date:Message-ID:Sender:
 Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender
 :Resent-To:Resent-Cc:Resent-Message-ID;
 bh=pwdyAXfFVGlvU9ZA0REa18Omo7zr+jP9VZyHpJ/oDno=; b=e7BWlNE6bCYvwQkxs6IyUvAnAb
 rLZtEFA09xnnoWoBdlWUnOQn16IdlWD+m9S/Fj0eupHAfwBcP4JFL83/51ks+y7d8pNlVqkEwoadW
 k/z6EsDAMC0v/14mE7O4dcYDGiNonYY+bvdJshY1YqPVkY9hzsWKDrjZGhCESAT43LVsVxmnmC9Qx
 vdxhQ/JXj7X85eBpyvGDguIYIvurlLdoQHSSf43rxqkXBPJKU9xZ+/QY1S6gzWNGKuofhxTF9oigy
 medgqHV0p86nZFXBcJiSzeOxGQbMwE8QOQoKecxmoumZLdI7e4SxNxU7rTpGP1nCEEclT/+nJesz+
 +9l+8X5DVsV7z9oy9Q3iszioQwa8djBPNHW3InwFGhvRgqgBwOQh20zf803NMA2i3eIYp4FRCo8i3
 1XyFACciU7JK76EcX6lWZkthV2Brh0A4VdvwzGKOUom40PWWPP47az2lkhb17dxPrs7eZC2NofJoj
 IZAqHM085HXyE0XKNdMg/7RCM5qZSo0G5vPqTeg4CqZqjhG/xjS1zS8ToalpkERhrca4Era9HqUSW
 7eUSTmm3Ac4I/yFXiOjWrcXEEGa3O2N9jVqnHxO6h3Fqicq02Pp1HCdBontkQ8WEyAfTA+sfFE5kS
 mVnwGTWEFghLr222y3W2RLEdvcoPttZzUXHmmH9eA=;
Received: from [217.155.175.48] (helo=[10.8.0.6])
 by mail.ilande.co.uk with esmtpsa (TLS1.3) tls
 TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256 (Exim 4.94.2)
 (envelope-from <mark.cave-ayland@ilande.co.uk>)
 id 1x7YPL-00EgP4-Df; Fri, 18 Sep 2026 14:13:39 +0100
Message-ID: <e85c4b98-1bb6-441f-8a25-e418ba8e417f@ilande.co.uk>
Date: Fri, 18 Sep 2026 14:14:05 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: =?UTF-8?B?0J3QuNC60L7Qu9Cw0Lkg0JfQvtGA0LjQvQ==?= <zorin@swemel.ru>,
 qemu-devel@nongnu.org
Cc: thuth@redhat.com, mst@redhat.com, stefanha@redhat.com, kwolf@redhat.com,
 marcandre.lureau@redhat.com
References: <da75d0f0-d98e-4e27-ac6c-c575a2d382ff@swemel.ru>
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
In-Reply-To: <da75d0f0-d98e-4e27-ac6c-c575a2d382ff@swemel.ru>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 217.155.175.48
X-SA-Exim-Mail-From: mark.cave-ayland@ilande.co.uk
Subject: Re: [PATCH] hw/display/tcx: use memmove instead of memcpy for
 overlapping blit memory regions
X-SA-Exim-Version: 4.2.1 (built Sat, 13 Feb 2021 17:57:42 +0000)
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

On 15/09/2026 17:20, Николай Зорин wrote:

> SWSA#34e3af79-c6c2-4ad2-986f-313c1ce28e5a

I guess this is from something else?

> In `tcx_blit_writel()`, memory copying occurs within the same video RAM
> buffers (`vram` and `vram24`) using source and destination offsets that
> can potentially overlap during blit operations.
> 
> Using `memcpy()` on overlapping memory regions triggers undefined behavior
> according to the C standard. Depending on compiler optimizations, this
> can lead to graphical artifacts, memory corruption, or unexpected
> behavior in the guest system.

I would hope that this is just graphical artifacts given that this is just video RAM...

> Fix this by replacing `memcpy()` with `memmove()`, which explicitly
> guarantees safe and correct behavior when memory regions overlap.

Do you have a specific test case? I can see that this would make sense in some cases, 
e.g. sideways scrolling.

> Signed-off-by: Nikolay N Zorin <zorin@swemel.ru>
> ---
>   hw/display/tcx.c | 4 ++--
>   1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/hw/display/tcx.c b/hw/display/tcx.c
> index 2cfc1e8f..fb48a199 100644
> --- a/hw/display/tcx.c
> +++ b/hw/display/tcx.c
> @@ -587,9 +587,9 @@ static void tcx_blit_writel(void *opaque, hwaddr addr,
>                   }
>               }
>           } else {
> -            memcpy(&s->vram[addr], &s->vram[adsr], len);
> +            memmove(&s->vram[addr], &s->vram[adsr], len);
>               if (s->depth == 24) {
> -                memcpy(&s->vram24[addr], &s->vram24[adsr], len * 4);
> +                memmove(&s->vram24[addr], &s->vram24[adsr], len * 4);
>               }
>           }
>           tcx_set_dirty(s, addr, len);

Please can you can send a v2 with the commit message updated, then if it looks good 
I'll queue it in my qemu-sparc branch.


ATB,

Mark.


