Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C9B25E83833
	for <qemu-devel@archiver.kernel.org>; Mon, 16 Feb 2026 21:02:03 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vs5im-0004nf-5f; Mon, 16 Feb 2026 16:01:34 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mark.cave-ayland@ilande.co.uk>)
 id 1vs5ib-0004mv-Eu; Mon, 16 Feb 2026 16:01:22 -0500
Received: from mail.ilande.co.uk ([2001:41c9:1:41f::167])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mark.cave-ayland@ilande.co.uk>)
 id 1vs5iZ-0003ZQ-70; Mon, 16 Feb 2026 16:01:21 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=ilande.co.uk; s=20220518; h=Subject:Content-Transfer-Encoding:Content-Type:
 In-Reply-To:From:References:Cc:To:MIME-Version:Date:Message-ID:Sender:
 Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender
 :Resent-To:Resent-Cc:Resent-Message-ID;
 bh=8/9Y9fAiOzjduTgumU1a5QqpXjiNc6KQbz9Cc8Rum4o=; b=dEjKJH+VDSeBdd2isNKmB471hJ
 9xPjlX0xyQJcgg4HnC9iejxgqJlwpnlTniiEALtBdyv/tppizzgq56yPcvP7ng9bK4KdsYRjaqsN2
 37L839PeOKsn8M2vpIxqjqu5kx2eIP0+dyYoLcVpLNyR5JmDcku7y9dzCN+WU1GMpoRltbKGAuz4g
 afj3LZq5vzMYr/nNoooZ36hj47ORM3bHdOUnpwxRj9j5oHIUI5O1pjMLwOpxycwNx6ZwkGeZDQdIW
 tw2duPr3ToP/YAkBZRUe0w7tHGnxKtZhhYSyM0jwh77F0lbUm1/R1I10iAcxtefnaNMv+HRrT1ov5
 N/DVzyO410L86goHgsDre1SvJxjwttKFdaFDavLj6RFYyGKmql4vkyMkoY2E2aGYjqE3Yxg32H2Lq
 FEgzB6vjdUlub82oozWb69SHawxn5nEimyJyse2Wl6kHle+zi/9AOtCInIZCgWTpqGFkxn4ptdhrW
 K0Eblkc8LWZIgBRXwgRORnY7M67gndBcqhWDFHElQSGLXzpDEePWCNEEqpT2POp52Z0tdBjxTiF3/
 SmtZXaYKZwlXrGOttNHR8tbLPqGsyB0hYe/NaiEjipIb6Lm0qGiYT2QG1hTCyHPI69kLOdmZrAK40
 4wOduDDTUKUUTtvSECov0DpmMMGRa/8zhac4C81q4=;
Received: from [2a02:8012:2f01:0:f01d:4e0f:6874:3706]
 by mail.ilande.co.uk with esmtpsa (TLS1.3:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.92) (envelope-from <mark.cave-ayland@ilande.co.uk>)
 id 1vs5fe-000Cb2-QP; Mon, 16 Feb 2026 20:58:22 +0000
Message-ID: <238264ec-0632-42e3-b5a5-4ba1dba7a20e@ilande.co.uk>
Date: Mon, 16 Feb 2026 21:01:09 +0000
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 qemu-devel@nongnu.org
Cc: Chinmay Rath <rathc@linux.ibm.com>,
 =?UTF-8?Q?Herv=C3=A9_Poussineau?= <hpoussin@reactos.org>,
 Harsh Prateek Bora <harshpb@linux.ibm.com>,
 Nicholas Piggin <npiggin@gmail.com>, Artyom Tarasenko <atar4qemu@gmail.com>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>, qemu-ppc@nongnu.org,
 Laurent Vivier <laurent@vivier.eu>
References: <20260214021240.58657-1-philmd@linaro.org>
 <20260214021240.58657-5-philmd@linaro.org>
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
In-Reply-To: <20260214021240.58657-5-philmd@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 2a02:8012:2f01:0:f01d:4e0f:6874:3706
X-SA-Exim-Mail-From: mark.cave-ayland@ilande.co.uk
Subject: Re: [PATCH 4/8] hw/m68k/q800: Set MACFB_DISPLAY_APPLE_21_COLOR within
 MacFrameBuffer
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

On 14/02/2026 02:12, Philippe Mathieu-Daudé wrote:

> The MACFB_DISPLAY_APPLE_21_COLOR mode is not specific to the Q800
> machine. Check and set it once in the MacFB DeviceRealize handler.
> 
> Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
> ---
>   hw/display/macfb.c | 4 ++++
>   hw/m68k/q800.c     | 5 -----
>   2 files changed, 4 insertions(+), 5 deletions(-)
> 
> diff --git a/hw/display/macfb.c b/hw/display/macfb.c
> index 8ef174dc6df..b8115c2be13 100644
> --- a/hw/display/macfb.c
> +++ b/hw/display/macfb.c
> @@ -645,6 +645,10 @@ static bool macfb_common_realize(DeviceState *dev, MacfbState *s, Error **errp)
>   {
>       DisplaySurface *surface;
>   
> +    if (s->width == 1152 && s->height == 870) {
> +        s->type = MACFB_DISPLAY_APPLE_21_COLOR;
> +    }
> +
>       s->mode = macfb_find_mode(s->type, s->width, s->height, s->depth);
>       if (!s->mode) {
>           gchar *list;
> diff --git a/hw/m68k/q800.c b/hw/m68k/q800.c
> index b55c03a90bf..ba32da2fa45 100644
> --- a/hw/m68k/q800.c
> +++ b/hw/m68k/q800.c
> @@ -563,11 +563,6 @@ static void q800_machine_init(MachineState *machine)
>       qdev_prop_set_uint32(dev, "width", graphic_width);
>       qdev_prop_set_uint32(dev, "height", graphic_height);
>       qdev_prop_set_uint8(dev, "depth", graphic_depth);
> -    if (graphic_width == 1152 && graphic_height == 870) {
> -        qdev_prop_set_uint8(dev, "display", MACFB_DISPLAY_APPLE_21_COLOR);
> -    } else {
> -        qdev_prop_set_uint8(dev, "display", MACFB_DISPLAY_VGA);

I was going to ask about what happened to MACFB_DISPLAY_VGA, but it seems to be the 
default for the macfb device so no problem there.

> -    }
>       qdev_realize(dev, BUS(nubus), &error_fatal);
>   
>       macfb_mode = (NUBUS_MACFB(dev)->macfb).mode;

I'm not sure if 1152x870 is available on all macfb devices (as opposed to just that 
used on the Quadra), but still for now:

Reviewed-by: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>


ATB,

Mark.


