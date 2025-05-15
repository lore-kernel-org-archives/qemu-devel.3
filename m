Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B7536C2D0CD
	for <qemu-devel@archiver.kernel.org>; Thu, 15 May 2025 20:58:01 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uFfdt-0004di-2M; Thu, 15 May 2025 16:57:25 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mark.cave-ayland@ilande.co.uk>)
 id 1uFfdr-0004cy-Na
 for qemu-devel@nongnu.org; Thu, 15 May 2025 16:57:23 -0400
Received: from mail.ilande.co.uk ([2001:41c9:1:41f::167])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mark.cave-ayland@ilande.co.uk>)
 id 1uFfdp-0008DZ-UL
 for qemu-devel@nongnu.org; Thu, 15 May 2025 16:57:23 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=ilande.co.uk; s=20220518; h=Subject:Content-Transfer-Encoding:Content-Type:
 In-Reply-To:From:References:Cc:To:MIME-Version:Date:Message-ID:Sender:
 Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender
 :Resent-To:Resent-Cc:Resent-Message-ID;
 bh=qiNZiQRUQ2ja0Lc/c78MXCO3CMw6EOFd5NIjapJUHaM=; b=BeFrc2iEAA6fyuCHRnqmUTFRB0
 MolrtscFflS2OaI5CV8RnoRPEVr042fVaPPC/Tn6vIqs5SUSY42u9iluEuk73oKjhmXIRDwSKuKzH
 iHwgRZt2XkyJWaU80JQtF7Uodgv6y8m2V5Q0oDxECdYFGAkWWkjyKHspdFdCJ7Qw/5n8SjS8C65mV
 WntwBXDPhVsc9amy+GEse9+OPHh/E5FU6FlprBJ60slC4efh7H7jzTq2p/+GgyGaiOSTzl9V/VrjG
 q0v1FCBcMnjpicKLy7AD1/Vme80LZs8MXf6ZWqzenjJS+mlMWx0wJ41x8/pMzdwG3aoJUGrNQ9ZRd
 KxFKfPyxeCMZGmzXS5+1XLnJkMI8t26DVjmfKmIvA1TOiY83btQVNpTlfFc5cRVQV8h/GpCZpbUZd
 oouBN3d44e0B1eSO8/l63l0xohApPQYMAx2wGGNlF6Ma0/BZT16Yvb1Cvg/0miuvO1DEpzKv07mSE
 82E8d4HjP7WFzj6KTTyiy5ezNbe6kCRX6ZcwpuvyZ9rBFXzH6tCuY+KGdECkdjsF9u2mU5Dtbzi44
 zcSRcVTPi4ctfFk6vf/rUsENAKXFwO1raLu/JFqdMa4S/NDrJ9U6q+T1ySfQIxMh3ZbLHDL2Si0G9
 7XIEDeUGFjMMx3J2ZInyF1IRgiUU5JDKe9MOogZRg=;
Received: from [2a02:8012:2f01:0:aa9f:6066:67ff:432a]
 by mail.ilande.co.uk with esmtpsa (TLS1.3:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.92) (envelope-from <mark.cave-ayland@ilande.co.uk>)
 id 1uFfcQ-0009ji-LV; Thu, 15 May 2025 21:55:58 +0100
Message-ID: <f93dad3a-970c-46a0-8eea-8aa9e827739b@ilande.co.uk>
Date: Thu, 15 May 2025 21:57:09 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: =?UTF-8?Q?Volker_R=C3=BCmelin?= <vr_qemu@t-online.de>,
 Gerd Hoffmann <kraxel@redhat.com>,
 =?UTF-8?Q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>,
 Laurent Vivier <laurent@vivier.eu>, Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>
Cc: qemu-devel@nongnu.org, Richard Henderson <richard.henderson@linaro.org>,
 Thomas Huth <thuth@redhat.com>
References: <0bb1a55e-70f1-410b-8b59-78eed7f4c8f7@t-online.de>
 <20250515054429.7385-4-vr_qemu@t-online.de>
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
In-Reply-To: <20250515054429.7385-4-vr_qemu@t-online.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 2a02:8012:2f01:0:aa9f:6066:67ff:432a
X-SA-Exim-Mail-From: mark.cave-ayland@ilande.co.uk
Subject: Re: [PATCH v2 4/7] hw/audio/asc: fix SIGSEGV in asc_realize()
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

On 15/05/2025 06:44, Volker Rümelin wrote:

> AUD_open_out() may fail and return NULL. This may then lead to
> a segmentation fault in memset() below. The memset() behaviour
> is undefined if the pointer to the destination object is a null
> pointer.
> 
> Add the missing error handling code.
> 
> Reviewed-by: Marc-André Lureau <marcandre.lureau@redhat.com>
> Signed-off-by: Volker Rümelin <vr_qemu@t-online.de>
> ---
>   hw/audio/asc.c | 7 +++++++
>   1 file changed, 7 insertions(+)
> 
> diff --git a/hw/audio/asc.c b/hw/audio/asc.c
> index 18382ccf6a..6721c0d9fb 100644
> --- a/hw/audio/asc.c
> +++ b/hw/audio/asc.c
> @@ -12,6 +12,7 @@
>   
>   #include "qemu/osdep.h"
>   #include "qemu/timer.h"
> +#include "qapi/error.h"
>   #include "hw/sysbus.h"
>   #include "hw/irq.h"
>   #include "audio/audio.h"
> @@ -653,6 +654,12 @@ static void asc_realize(DeviceState *dev, Error **errp)
>   
>       s->voice = AUD_open_out(&s->card, s->voice, "asc.out", s, asc_out_cb,
>                               &as);
> +    if (!s->voice) {
> +        AUD_remove_card(&s->card);
> +        error_setg(errp, "Initializing audio stream failed");
> +        return;
> +    }
> +
>       s->shift = 1;
>       s->samples = AUD_get_buffer_size_out(s->voice) >> s->shift;
>       s->mixbuf = g_malloc0(s->samples << s->shift);

Reviewed-by: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>


ATB,

Mark.


