Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7958DC48297
	for <qemu-devel@archiver.kernel.org>; Fri,  9 Feb 2024 21:39:34 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rYYaL-0000ql-F1; Fri, 09 Feb 2024 16:39:01 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mark.cave-ayland@ilande.co.uk>)
 id 1rYYaJ-0000qH-Ln; Fri, 09 Feb 2024 16:38:59 -0500
Received: from mail.ilande.co.uk ([2001:41c9:1:41f::167])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mark.cave-ayland@ilande.co.uk>)
 id 1rYYaE-0002I3-V2; Fri, 09 Feb 2024 16:38:59 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=ilande.co.uk; s=20220518; h=Subject:Content-Transfer-Encoding:Content-Type:
 In-Reply-To:From:References:Cc:To:MIME-Version:Date:Message-ID:Sender:
 Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender
 :Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=AvVbmzAG2BhmrU38btIAGDRBGC786Ivr8o9yGLAbyy4=; b=SPrZoKvSsSNitTeXs2F4iy66jE
 V39dyXcRGrfkfZFrcjt3gHMZ1e0eQnVkqOMWbLPkSOSHg61rfbkQPSdRAEKh2qjB6WqYrHYRDf+oY
 LduHWLRWuPUYiX5vxdqACpg3m7IMQWw/mGcr3DFVQuL6EA/wEnbgC+4cfJ8gp/Vg928LdluzcTgVz
 zu+RP2uP6z2oc7aovMgVxCNpqB1ecmztoAOCeX55j+FiPE1evTdkdI50J7uViTNH8wvPazqyV8UoK
 6lIwXGcgiRQL9iBAchJfOUgDXeRhwZkFV/hqDMuKT8nd8rEw91keqzTtbbcJII46GxeIuzg6kobk1
 cPe5TshF91t3CvOD5rhz0qPfBNELBlTl728lN2cQsj/fJ9SU3n5ntvEUbvdmvGrndiQeR6DjBsPZD
 gQ/QjbJ3HaA1ZmFzPfSQz58Hrf/rE2Z5AWY/EeHlTJuNFivyQkeAn6iD/wL0oHv3u6m8xNxkf7+iG
 5xfA9H5czKbMWHZx3objzINjdW1fEa5h39fb9F9Y8QsGVU20BgX2X4em/QslLjYBUljsBQfdMEd6e
 kSJuh/pDvaPDOgfQZ9oCMQfet1W+FfUElXvPHjcLH/GWWpzbi14IA9Ob/7J+nDDXSAp5a6OQ+iLoy
 TP7kUgYRG5bEURi8chnPJSMmrM3nI/EJxttbWfzB0=;
Received: from [2a00:23c4:8bb2:1300:1032:5a09:fd17:2b9e]
 by mail.ilande.co.uk with esmtpsa (TLS1.3:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.92) (envelope-from <mark.cave-ayland@ilande.co.uk>)
 id 1rYYZT-0002ST-Er; Fri, 09 Feb 2024 21:38:11 +0000
Message-ID: <f3bbf021-b245-4588-8b73-bcf668c29fea@ilande.co.uk>
Date: Fri, 9 Feb 2024 21:38:44 +0000
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Content-Language: en-US
To: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 qemu-devel@nongnu.org
Cc: Zhao Liu <zhao1.liu@linux.intel.com>, Paolo Bonzini
 <pbonzini@redhat.com>, qemu-block@nongnu.org, John Snow <jsnow@redhat.com>,
 qemu-ppc@nongnu.org, Eduardo Habkost <eduardo@habkost.net>,
 Richard Henderson <richard.henderson@linaro.org>,
 Markus Armbruster <armbru@redhat.com>, Artyom Tarasenko <atar4qemu@gmail.com>
References: <20240208181245.96617-1-philmd@linaro.org>
 <20240208181245.96617-9-philmd@linaro.org>
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
In-Reply-To: <20240208181245.96617-9-philmd@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 2a00:23c4:8bb2:1300:1032:5a09:fd17:2b9e
X-SA-Exim-Mail-From: mark.cave-ayland@ilande.co.uk
Subject: Re: [PATCH v3 08/11] hw/sparc/sun4m: Realize DMA controller before
 accessing it
X-SA-Exim-Version: 4.2.1 (built Wed, 08 May 2019 21:11:16 +0000)
X-SA-Exim-Scanned: Yes (on mail.ilande.co.uk)
Received-SPF: pass client-ip=2001:41c9:1:41f::167;
 envelope-from=mark.cave-ayland@ilande.co.uk; helo=mail.ilande.co.uk
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_NONE=0.001,
 T_SCC_BODY_TEXT_LINE=-0.01,
 T_SPF_TEMPERROR=0.01 autolearn=ham autolearn_force=no
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

On 08/02/2024 18:12, Philippe Mathieu-Daudé wrote:

> We should not wire IRQs on unrealized device.
> 
> Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
> ---
>   hw/sparc/sun4m.c | 7 +++++--
>   1 file changed, 5 insertions(+), 2 deletions(-)
> 
> diff --git a/hw/sparc/sun4m.c b/hw/sparc/sun4m.c
> index e782c8ec7a..d52e6a7213 100644
> --- a/hw/sparc/sun4m.c
> +++ b/hw/sparc/sun4m.c
> @@ -312,13 +312,11 @@ static void *sparc32_dma_init(hwaddr dma_base,
>       dma = qdev_new(TYPE_SPARC32_DMA);
>       espdma = SPARC32_ESPDMA_DEVICE(object_resolve_path_component(
>                                      OBJECT(dma), "espdma"));
> -    sysbus_connect_irq(SYS_BUS_DEVICE(espdma), 0, espdma_irq);
>   
>       esp = SYSBUS_ESP(object_resolve_path_component(OBJECT(espdma), "esp"));
>   
>       ledma = SPARC32_LEDMA_DEVICE(object_resolve_path_component(
>                                    OBJECT(dma), "ledma"));
> -    sysbus_connect_irq(SYS_BUS_DEVICE(ledma), 0, ledma_irq);
>   
>       lance = SYSBUS_PCNET(object_resolve_path_component(
>                            OBJECT(ledma), "lance"));
> @@ -332,6 +330,11 @@ static void *sparc32_dma_init(hwaddr dma_base,
>       }
>   
>       sysbus_realize_and_unref(SYS_BUS_DEVICE(dma), &error_fatal);
> +
> +    sysbus_connect_irq(SYS_BUS_DEVICE(espdma), 0, espdma_irq);
> +
> +    sysbus_connect_irq(SYS_BUS_DEVICE(ledma), 0, ledma_irq);
> +
>       sysbus_mmio_map(SYS_BUS_DEVICE(dma), 0, dma_base);
>   
>       sysbus_mmio_map(SYS_BUS_DEVICE(esp), 0, esp_base);

Reviewed-by: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>


ATB,

Mark.


