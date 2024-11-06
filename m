Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 48E89D44D57
	for <qemu-devel@archiver.kernel.org>; Wed,  6 Nov 2024 11:58:57 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t8efo-0002Vi-1X; Wed, 06 Nov 2024 06:58:08 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mark.cave-ayland@ilande.co.uk>)
 id 1t8efm-0002VZ-VF
 for qemu-devel@nongnu.org; Wed, 06 Nov 2024 06:58:06 -0500
Received: from mail.ilande.co.uk ([2001:41c9:1:41f::167])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mark.cave-ayland@ilande.co.uk>)
 id 1t8efl-0003rQ-7g
 for qemu-devel@nongnu.org; Wed, 06 Nov 2024 06:58:06 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=ilande.co.uk; s=20220518; h=Subject:Content-Transfer-Encoding:Content-Type:
 In-Reply-To:From:References:To:MIME-Version:Date:Message-ID:Sender:Reply-To:
 Cc:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID;
 bh=NrbAYUvFaz6ziaQvB5Q+ADf9wdcc6sEOPxr1GlMCtuk=; b=v5pKny1Mu4mcyR5hd0Xx7NYb4d
 mc7Vj8PKQMyA534NT3mDQ76IGoPks/6NIh+lZReo57mU92HF7obo9HP1OzGMpyXySf1Z77+KeJJ7i
 uW1EjWWLlpvKOPeedLIxw7dr6JU6P2vVtmAdef5Tm/Fa9g0OZtKE7wJGQ3lRGwDVj+XnWbPL7AHmz
 Vy8KsucqKo4WOCXJT3ks0KATt7YHveKRELlA/5LxyeRlWlS/hlk1wxl1qsOq9aZz8gi/TsEPbj/+I
 hI3nHggscdR1AMj9Ji1onALRcITRuY1vRY3QPWrY8k/4pXFZgfgdDagceq3TBA3FbdCoASTEyic6b
 jssDzlaaCmtUerY9NGMemTHaHq36P5J2iZT534sp/d+tVkTjbOwhZeRO6CdyadPJwYaj5EsNU9QZm
 wJnzH+1awVaPZ6vZg08VgJc81bSho6y6tUf9V5MN1hGWmZS1lPj4q4xc5I053+/KOZ3n2uG56Taa6
 zOf9VSRyDxVG8jG9epPXXrpev48nGl0iHd+LHThr3xOLKkayVuWeETXsnK+B+IJYDnx8XOTG/KQWb
 73Fgk+8zZ4YL2AiP0cnT0pYSkhGPkt9yx88+7idYgavT1nnvBzJTlwIrVeZbOlJf2Djg+6nv/FKxw
 d39OvsSpENwkWzdFpgGRnpym307zIcQddOaivCwHE=;
Received: from [2a00:23c4:8bb8:f600:73fa:5593:d3ba:8410]
 by mail.ilande.co.uk with esmtpsa (TLS1.3:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.92) (envelope-from <mark.cave-ayland@ilande.co.uk>)
 id 1t8efL-0008mg-0N; Wed, 06 Nov 2024 11:57:43 +0000
Message-ID: <dae49b9c-0d47-4811-bd48-fdd401594609@ilande.co.uk>
Date: Wed, 6 Nov 2024 11:57:57 +0000
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: Peter Maydell <peter.maydell@linaro.org>, qemu-devel@nongnu.org
References: <20241105180205.3074071-1-peter.maydell@linaro.org>
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
In-Reply-To: <20241105180205.3074071-1-peter.maydell@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-SA-Exim-Connect-IP: 2a00:23c4:8bb8:f600:73fa:5593:d3ba:8410
X-SA-Exim-Mail-From: mark.cave-ayland@ilande.co.uk
Subject: Re: [PATCH] hw/intc/openpic: Avoid taking address of out-of-bounds
 array index
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

On 05/11/2024 18:02, Peter Maydell wrote:

> The clang sanitizer complains about the code in the EOI handling
> of openpic_cpu_write_internal():
> 
> UBSAN_OPTIONS=halt_on_error=1:abort_on_error=1 ./build/clang/qemu-system-ppc -M mac99,graphics=off -display none -kernel day15/invaders.elf
> ../../hw/intc/openpic.c:1034:16: runtime error: index -1 out of bounds for type 'IRQSource[264]' (aka 'struct IRQSource[264]')
> SUMMARY: UndefinedBehaviorSanitizer: undefined-behavior ../../hw/intc/openpic.c:1034:16 in
> 
> This is because we do
>    src = &opp->src[n_IRQ];$

Extra $ symbol at the end of the line here?

> when n_IRQ may be -1.  This is in practice harmless because if n_IRQ
> is -1 then we don't do anything with the src pointer, but it is
> undefined behaviour. (This has been present since this device
> was first added to QEMU.)
> 
> Rearrange the code so we only do the array index when n_IRQ is not -1.
> 
> Cc: qemu-stable@nongnu.org
> Fixes: e9df014c0b ("Implement embedded IRQ controller for PowerPC 6xx/740 & 75")
> Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
> ---
> Arguable whether it's worth the stable backport or not...
> ---
>   hw/intc/openpic.c | 15 ++++++++-------
>   1 file changed, 8 insertions(+), 7 deletions(-)
> 
> diff --git a/hw/intc/openpic.c b/hw/intc/openpic.c
> index cd3d87768e0..2ead4b9ba00 100644
> --- a/hw/intc/openpic.c
> +++ b/hw/intc/openpic.c
> @@ -1031,13 +1031,14 @@ static void openpic_cpu_write_internal(void *opaque, hwaddr addr,
>           s_IRQ = IRQ_get_next(opp, &dst->servicing);
>           /* Check queued interrupts. */
>           n_IRQ = IRQ_get_next(opp, &dst->raised);
> -        src = &opp->src[n_IRQ];
> -        if (n_IRQ != -1 &&
> -            (s_IRQ == -1 ||
> -             IVPR_PRIORITY(src->ivpr) > dst->servicing.priority)) {
> -            DPRINTF("Raise OpenPIC INT output cpu %d irq %d",
> -                    idx, n_IRQ);
> -            qemu_irq_raise(opp->dst[idx].irqs[OPENPIC_OUTPUT_INT]);
> +        if (n_IRQ != -1) {
> +            src = &opp->src[n_IRQ];
> +            if (s_IRQ == -1 ||
> +                IVPR_PRIORITY(src->ivpr) > dst->servicing.priority) {
> +                DPRINTF("Raise OpenPIC INT output cpu %d irq %d",
> +                        idx, n_IRQ);
> +                qemu_irq_raise(opp->dst[idx].irqs[OPENPIC_OUTPUT_INT]);
> +            }
>           }
>           break;
>       default:

Reviewed-by: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>


ATB,

Mark.


