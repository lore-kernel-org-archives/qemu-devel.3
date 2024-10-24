Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 08635D0BB72
	for <qemu-devel@archiver.kernel.org>; Thu, 24 Oct 2024 08:46:19 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t3tTQ-0000Uk-7L; Thu, 24 Oct 2024 04:45:40 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mark.cave-ayland@ilande.co.uk>)
 id 1t3tTO-0000Ub-Ix
 for qemu-devel@nongnu.org; Thu, 24 Oct 2024 04:45:38 -0400
Received: from mail.ilande.co.uk ([2001:41c9:1:41f::167])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mark.cave-ayland@ilande.co.uk>)
 id 1t3tTK-00036o-2p
 for qemu-devel@nongnu.org; Thu, 24 Oct 2024 04:45:38 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=ilande.co.uk; s=20220518; h=Subject:Content-Transfer-Encoding:Content-Type:
 In-Reply-To:References:To:From:MIME-Version:Date:Message-ID:Sender:Reply-To:
 Cc:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID;
 bh=VykfFFYAAVIOqIct83z2B8O/sMHuVJVtOFHOHArRaEU=; b=WH8N5Z6DlyFTD+PAINRuz08goQ
 /wy9ZMCMqyQ87JRcNTZ7eD/wgFRTDXDaZQCiiA2/ewqNdsKFaRk7oT48Tz/Mpc2BvYZpPixJF1UUb
 OUvlEzbDRFKv3K5aUAESJuTobdEEQpgbETquWZOCTFnIyaBZ8Di+QY0EHE2fflDP7gvprgXgnxJ+D
 MXsxvuZO0LBmMxWpQJcoEH8BTW4qqXADVmbs1OHrNUhjTvbrmD5lPaNG+f9hfoOGykxnxkP/GTNyB
 bDLzogzJtxEVP8fZu66ofEcskhbCBTCZyIe9lCN7IsB47j3Fj6F71qLNbWWOCLvMFZjF00wEJoUOx
 8IEcvHt+CvgrPHDVCcC7Y/EsRevCQbHTcN00T1oDKH2D1W7GZg9rH8OLKYDPq8qoPGcjR+fiPEaa3
 JWEru3tStKHWJ7OvcmcRR48y0piLUHFLYbtY4ZnGOADtFMYKeDqLVvb+lV15jtu4gbwARtD3k7sbp
 b9dfR30ZAdQetFgtleGqnJcd+O823gc57o+84/5QsXBMQXQ33pS8hhuRplPG9w4tDMmlDX/9+S7wZ
 Wc1YEY5Z7yulAZZ5PrxjWYU7cgETRiTmTXQ6ukgnnuAKA4FK6VxhxQyVIg/X9O07pD67E6L3bHFFk
 vaqvPUe+l230wiOrDDJIfa6UYds1XY63eO2mK9c8o=;
Received: from [2a02:8012:c93d:0:260e:bf57:a4e9:8142]
 by mail.ilande.co.uk with esmtpsa (TLS1.3:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.92) (envelope-from <mark.cave-ayland@ilande.co.uk>)
 id 1t3tSw-000Ch4-8X; Thu, 24 Oct 2024 09:45:14 +0100
Message-ID: <903d5d62-88d9-4462-8ded-df73cb3c1450@ilande.co.uk>
Date: Thu, 24 Oct 2024 09:45:23 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
To: huth@tuxfamily.org, qemu-devel@nongnu.org
References: <20241023085852.1061031-1-mark.cave-ayland@ilande.co.uk>
 <20241023085852.1061031-33-mark.cave-ayland@ilande.co.uk>
Content-Language: en-US
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
In-Reply-To: <20241023085852.1061031-33-mark.cave-ayland@ilande.co.uk>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-SA-Exim-Connect-IP: 2a02:8012:c93d:0:260e:bf57:a4e9:8142
X-SA-Exim-Mail-From: mark.cave-ayland@ilande.co.uk
Subject: Re: [PATCH 32/36] next-cube: add rtc-power-out named gpio to reset
 the rtc state machine
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

On 23/10/2024 09:58, Mark Cave-Ayland wrote:

> This allows us to decouple the next-pc and next-rtc devices from each
> other in next_rtc_data_in_irq().
> 
> Signed-off-by: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
> ---
>   hw/m68k/next-cube.c | 10 ++++++----
>   1 file changed, 6 insertions(+), 4 deletions(-)
> 
> diff --git a/hw/m68k/next-cube.c b/hw/m68k/next-cube.c
> index 16b16e9956..0a8b899515 100644
> --- a/hw/m68k/next-cube.c
> +++ b/hw/m68k/next-cube.c
> @@ -58,6 +58,7 @@ struct NeXTRTC {
>       uint8_t retval;
>   
>       qemu_irq data_out_irq;
> +    qemu_irq power_irq;
>   };
>   
>   #define TYPE_NEXT_SCSI "next-scsi"
> @@ -106,7 +107,6 @@ struct NeXTPC {
>       ESCCState escc;
>   
>       NeXTRTC rtc;
> -    qemu_irq rtc_power_irq;
>       qemu_irq rtc_data_irq;
>       qemu_irq rtc_cmd_reset_irq;
>   };
> @@ -184,7 +184,6 @@ static bool next_rtc_cmd_is_write(uint8_t cmd)
>   static void next_rtc_data_in_irq(void *opaque, int n, int level)
>   {
>       NeXTRTC *rtc = NEXT_RTC(opaque);
> -    NeXTPC *s = NEXT_PC(container_of(rtc, NeXTPC, rtc));
>   
>       if (rtc->phase < 8) {
>           rtc->command = (rtc->command << 1) | level;
> @@ -256,7 +255,7 @@ static void next_rtc_data_in_irq(void *opaque, int n, int level)
>               if (rtc->value & 0x04) {
>                   /* clear FTU */
>                   rtc->status = rtc->status & (~0x18);
> -                qemu_irq_lower(s->rtc_power_irq);
> +                qemu_irq_lower(rtc->power_irq);
>               }
>           }
>       }
> @@ -1044,6 +1043,8 @@ static void next_rtc_init(Object *obj)
>                                "rtc-data-out", 1);
>       qdev_init_gpio_in_named(DEVICE(obj), next_rtc_cmd_reset_irq,
>                               "rtc-cmd-reset", 1);
> +    qdev_init_gpio_out_named(DEVICE(obj), &rtc->power_irq,
> +                             "rtc-power-out", 1);
>   }
>   
>   static const VMStateDescription next_rtc_vmstate = {
> @@ -1156,6 +1157,8 @@ static void next_pc_realize(DeviceState *dev, Error **errp)
>                                                          "rtc-data-in", 0));
>       qdev_connect_gpio_out_named(dev, "rtc-cmd-reset", 0,
>                                   qdev_get_gpio_in_named(d, "rtc-cmd-reset", 0));
> +    qdev_connect_gpio_out_named(d, "rtc-power-out", 0,
> +                                qdev_get_gpio_in(dev, NEXT_PWR_I));
>   }
>   
>   static void next_pc_init(Object *obj)
> @@ -1191,7 +1194,6 @@ static void next_pc_init(Object *obj)
>   
>       object_initialize_child(obj, "rtc", &s->rtc, TYPE_NEXT_RTC);
>   
> -    s->rtc_power_irq = qdev_get_gpio_in(DEVICE(obj), NEXT_PWR_I);
>       qdev_init_gpio_in_named(DEVICE(obj), next_pc_rtc_data_in_irq,
>                               "rtc-data-in", 1);
>       qdev_init_gpio_out_named(DEVICE(obj), &s->rtc_data_irq,

(replying to myself)

I've just noticed the headline summary is wrong and should instead read: "next-cube: 
add rtc-power-out named gpio to trigger the NEXT_PWR_I interrupt".


ATB,

Mark.


