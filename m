Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1078BC021B2
	for <qemu-devel@archiver.kernel.org>; Tue, 25 Feb 2025 23:01:02 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tn3uX-0005Y8-M0; Tue, 25 Feb 2025 18:00:21 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mark.cave-ayland@ilande.co.uk>)
 id 1tn3uW-0005XT-1o; Tue, 25 Feb 2025 18:00:20 -0500
Received: from mail.ilande.co.uk ([2001:41c9:1:41f::167])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mark.cave-ayland@ilande.co.uk>)
 id 1tn3uU-0001iz-HC; Tue, 25 Feb 2025 18:00:19 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=ilande.co.uk; s=20220518; h=Subject:Content-Transfer-Encoding:Content-Type:
 In-Reply-To:From:References:Cc:To:MIME-Version:Date:Message-ID:Sender:
 Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender
 :Resent-To:Resent-Cc:Resent-Message-ID;
 bh=OWpLD21RQDUGppEC1QJ4WufmJfCVg/TYzxSV6bseKN0=; b=h7WTeIwXpHQmUNIgaLd/ioq0iI
 Sn11coao7EpMW5ItyH2nxbehcmqmS7wXy+aGLN3MvmFxW9j3OPRI9SCh6NtPLlJZ746Sssoh1mS/u
 bsTr7hR5VYI/sPQUNJhd5zRD/xJnSgoST0UPy4JZlHa7iSB7psqN6KpDT5JbnRAeew4WIFvSL7OrT
 VyO6CmrI4Z1onkvy20ouZ0GRlDYXXNwXzmmB07mGzi8z01WQTfYecEXni/dazwQL9b/CgvBsmCjI0
 HM4eDAeC2ncA0/icQOZeUo4R22FBoeWzfe7ouK1hDJPeXG0LWnr5mKAWdrMl3cyxqaKs8as+WXCqt
 vdfEXDU/7NI8ng99geaAb0f2daJ7the8pc7SaxXcY89wrjqp9ssNcx4Yxz18E4qAUOYKMN78le7j6
 HM9vmbE029IzPl4nZbELMUR6+Ud4fP3U2dKrCB53PhGVSxz8hSugHz2WsoA2FMij5J1rD3MdXF5t2
 nPRqyxEMvw/PcmQh7rsCAvnrScZ9ls7HModHjZh5mDXAzWMcNfDN8VBLUQLtl5NCx4t2wMSBhGHxe
 4lpHC7jn5Qz7DEmiGCUZHiPwiswz5RuGRehwNbgjmie3M5t7aFyjBKm9MEWRbZVzsbLHnduD8Dlsu
 MR9iDu+UMgaQU2FQ7tDdYSSyVr4KO124BjXZmypV0=;
Received: from [2a02:8012:2f01:0:bfa1:1a8d:fd43:3eec]
 by mail.ilande.co.uk with esmtpsa (TLS1.3:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.92) (envelope-from <mark.cave-ayland@ilande.co.uk>)
 id 1tn3tW-00069C-Nn; Tue, 25 Feb 2025 22:59:22 +0000
Message-ID: <46dc11e7-ae37-45d2-9032-7afbf6e6a7f6@ilande.co.uk>
Date: Tue, 25 Feb 2025 23:00:11 +0000
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: BALATON Zoltan <balaton@eik.bme.hu>, qemu-devel@nongnu.org,
 qemu-ppc@nongnu.org
Cc: philmd@linaro.org
References: <20250224141026.3B36C4E6010@zero.eik.bme.hu>
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
In-Reply-To: <20250224141026.3B36C4E6010@zero.eik.bme.hu>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 2a02:8012:2f01:0:bfa1:1a8d:fd43:3eec
X-SA-Exim-Mail-From: mark.cave-ayland@ilande.co.uk
Subject: Re: [PATCH v2] hw/misc/macio/gpio.c: Add constants for register bits
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

On 24/02/2025 14:10, BALATON Zoltan wrote:

> Add named constants for register bit values that should make it easier
> to understand what these mean.
> 
> Signed-off-by: BALATON Zoltan <balaton@eik.bme.hu>
> Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
> ---
>   hw/misc/macio/gpio.c | 19 ++++++++++++-------
>   1 file changed, 12 insertions(+), 7 deletions(-)
> 
> diff --git a/hw/misc/macio/gpio.c b/hw/misc/macio/gpio.c
> index 4364afc84a..e87bfca1f5 100644
> --- a/hw/misc/macio/gpio.c
> +++ b/hw/misc/macio/gpio.c
> @@ -34,6 +34,11 @@
>   #include "qemu/module.h"
>   #include "trace.h"
>   
> +enum MacioGPIORegisterBits {
> +    OUT_DATA   = 1,
> +    IN_DATA    = 2,
> +    OUT_ENABLE = 4,
> +};
>   
>   void macio_set_gpio(MacIOGPIOState *s, uint32_t gpio, bool state)
>   {
> @@ -41,14 +46,14 @@ void macio_set_gpio(MacIOGPIOState *s, uint32_t gpio, bool state)
>   
>       trace_macio_set_gpio(gpio, state);
>   
> -    if (s->gpio_regs[gpio] & 4) {
> +    if (s->gpio_regs[gpio] & OUT_ENABLE) {
>           qemu_log_mask(LOG_GUEST_ERROR,
>                         "GPIO: Setting GPIO %d while it's an output\n", gpio);
>       }
>   
> -    new_reg = s->gpio_regs[gpio] & ~2;
> +    new_reg = s->gpio_regs[gpio] & ~IN_DATA;
>       if (state) {
> -        new_reg |= 2;
> +        new_reg |= IN_DATA;
>       }
>   
>       if (new_reg == s->gpio_regs[gpio]) {
> @@ -107,12 +112,12 @@ static void macio_gpio_write(void *opaque, hwaddr addr, uint64_t value,
>   
>       addr -= 8;
>       if (addr < 36) {
> -        value &= ~2;
> +        value &= ~IN_DATA;
>   
> -        if (value & 4) {
> -            ibit = (value & 1) << 1;
> +        if (value & OUT_ENABLE) {
> +            ibit = (value & OUT_DATA) << 1;
>           } else {
> -            ibit = s->gpio_regs[addr] & 2;
> +            ibit = s->gpio_regs[addr] & IN_DATA;
>           }
>   
>           s->gpio_regs[addr] = value | ibit;

Reviewed-by: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>


ATB,

Mark.


