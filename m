Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9BD1CC982DA
	for <qemu-devel@archiver.kernel.org>; Fri, 18 Sep 2026 13:18:35 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x7YTn-0003VG-8q; Fri, 18 Sep 2026 09:18:15 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mark.cave-ayland@ilande.co.uk>)
 id 1x7YTP-0003S1-1B; Fri, 18 Sep 2026 09:17:53 -0400
Received: from mail.ilande.co.uk ([2001:41c9:1:41f::167])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mark.cave-ayland@ilande.co.uk>)
 id 1x7YTN-0008AF-G4; Fri, 18 Sep 2026 09:17:50 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=ilande.co.uk; s=20220518; h=Subject:Content-Transfer-Encoding:Content-Type:
 In-Reply-To:From:References:To:MIME-Version:Date:Message-ID:Sender:Reply-To:
 Cc:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID;
 bh=8QeWgOLWciIRqnF/OqA+rDP7NOpOgBUUfhIian4kPhk=; b=rvAzpG6GlPnqjPwVzsVr1gluj4
 VhSxSJDK2v2DRSwilPPzVVZiYFGPzzu4eFmKtG+4NrDUXldA9PbR0U1EzOStOJt0dEvyjUTBTRpym
 ChLsjBMHZSPCDDdneO0ocRxt+BPJhEf1mmGW3iv9KbgdqPsuOimI2tLxvKx88HL03pCeQ/DQIyTtd
 BkNQ17UG2YtWb6+1T5Il0aKdPmrIXEt1LSuQuwQ94iFM02E8WaTno64g+uwLJBDV8BdUVbb6J34k3
 86fhr8f+Vsq3yyu3tE4E9qNPcPl5hxseevhBKG7q0h3jRJx7aFjy3U9l6RDQ8bXMVZTbh1Ww0TC1Y
 dkLvD9SaK1WFpfsog2JF/4r2SnfVoOtKhugFh6Fx4VBfvBQCDkkR4IiONCIaP4qxP8fZl4FsMMFJx
 V1YyKt5u0sGpVOoVNKrdNdsGp0pf7iTCDMLSkut0cghO8JYgPRJaeQPd8RjtmeBkOB6q7MpkN5kSG
 yhRzKoELME9s93tJkRbai9hu8Zp7OyqrPQYKoivnQcwKIlTawibupbMiYnkw3oWO5oJkI6T+hJGhc
 +rARf2Fj604nVaONltAvPM4HD+N0FE1cnkjYMULwi8w/BluBrrmsmhqry2EpDkFOouR4iTyqTCoar
 LI5Pf2EJfOppzCV6uqXs/y72YdFaEWub1hxSSmeOo=;
Received: from [217.155.175.48] (helo=[10.8.0.6])
 by mail.ilande.co.uk with esmtpsa (TLS1.3) tls
 TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256 (Exim 4.94.2)
 (envelope-from <mark.cave-ayland@ilande.co.uk>)
 id 1x7YSr-00EgRI-2D; Fri, 18 Sep 2026 14:17:17 +0100
Message-ID: <c3fedfcf-2644-4b64-a9ec-2566aef30db5@ilande.co.uk>
Date: Fri, 18 Sep 2026 14:17:46 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: "Kirill A. Korinsky" <kirill@korins.ky>,
 Chinmay Rath <rathc@linux.ibm.com>, Nicholas Piggin <npiggin@gmail.com>,
 Glenn Miles <milesg@linux.ibm.com>,
 Harsh Prateek Bora <harshpb@linux.ibm.com>, qemu-devel@nongnu.org,
 qemu-ppc@nongnu.org
References: <20260903115229.95811-1-kirill@korins.ky>
 <20260903115229.95811-2-kirill@korins.ky>
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
In-Reply-To: <20260903115229.95811-2-kirill@korins.ky>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-SA-Exim-Connect-IP: 217.155.175.48
X-SA-Exim-Mail-From: mark.cave-ayland@ilande.co.uk
Subject: Re: [PATCH 1/5] openpic: Preserve IRQs masked by CTPR
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

On 03/09/2026 12:50, Kirill A. Korinsky wrote:

> OpenBSD exposes this by raising CTPR while handling interrupts. If an
> edge remains pending when EOI lowers the servicing priority, QEMU
> reasserts INT without checking CTPR; IACK then returns the spurious
> vector and consumes the masked edge before CTPR permits delivery.
> 
> Signed-off-by: Kirill A. Korinsky <kirill@korins.ky>
> ---
>   hw/intc/openpic.c | 10 ++++++----
>   1 file changed, 6 insertions(+), 4 deletions(-)
> 
> diff --git a/hw/intc/openpic.c b/hw/intc/openpic.c
> index 99d2a1e65e..6f9a562163 100644
> --- a/hw/intc/openpic.c
> +++ b/hw/intc/openpic.c
> @@ -1033,8 +1033,9 @@ static void openpic_cpu_write_internal(void *opaque, hwaddr addr,
>           n_IRQ = IRQ_get_next(opp, &dst->raised);
>           if (n_IRQ != -1) {
>               src = &opp->src[n_IRQ];
> -            if (s_IRQ == -1 ||
> -                IVPR_PRIORITY(src->ivpr) > dst->servicing.priority) {
> +            if (IVPR_PRIORITY(src->ivpr) > dst->ctpr &&
> +                (s_IRQ == -1 ||
> +                 IVPR_PRIORITY(src->ivpr) > dst->servicing.priority)) {
>                   DPRINTF("Raise OpenPIC INT output cpu %d irq %d",
>                           idx, n_IRQ);
>                   qemu_irq_raise(opp->dst[idx].irqs[OPENPIC_OUTPUT_INT]);
> @@ -1070,12 +1071,13 @@ static uint32_t openpic_iack(OpenPICState *opp, IRQDest *dst, int cpu)
>       }
>   
>       src = &opp->src[irq];
> -    if (!(src->ivpr & IVPR_ACTIVITY_MASK) ||
> -            !(IVPR_PRIORITY(src->ivpr) > dst->ctpr)) {
> +    if (!(src->ivpr & IVPR_ACTIVITY_MASK)) {
>           error_report("%s: bad raised IRQ %d ctpr %d ivpr 0x%08x",
>                   __func__, irq, dst->ctpr, src->ivpr);
>           openpic_update_irq(opp, irq);
>           retval = opp->spve;
> +    } else if (IVPR_PRIORITY(src->ivpr) <= dst->ctpr) {
> +        return opp->spve;
>       } else {
>           /* IRQ enter servicing state */
>           IRQ_setbit(&dst->servicing, irq);

Getting hold of the OpenPIC datasheet was a little tricky, however from what I can 
tell this matches the expected behaviour.

Reviewed-by: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>


ATB,

Mark.


