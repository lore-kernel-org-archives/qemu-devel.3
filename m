Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C00CBCCD1BF
	for <qemu-devel@archiver.kernel.org>; Fri, 24 Oct 2025 19:36:59 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vCNac-0004Il-Ux; Fri, 24 Oct 2025 15:36:43 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mark.cave-ayland@ilande.co.uk>)
 id 1vCNaV-00045H-E0; Fri, 24 Oct 2025 15:36:38 -0400
Received: from mail.ilande.co.uk ([2001:41c9:1:41f::167])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mark.cave-ayland@ilande.co.uk>)
 id 1vCNaS-0002NA-GV; Fri, 24 Oct 2025 15:36:34 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=ilande.co.uk; s=20220518; h=Subject:Content-Transfer-Encoding:Content-Type:
 In-Reply-To:From:References:Cc:To:MIME-Version:Date:Message-ID:Sender:
 Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender
 :Resent-To:Resent-Cc:Resent-Message-ID;
 bh=eo1dk2tx3086i0W8IyPvybA0Gbb9DmdcnA+KZqXoMNw=; b=PttdZ42PxMN1LzDxe0ciXQ2UYB
 j58IwH6SV7ZHoHMC1ApaMK9ZIucYBurr+niEjBKTCO6xmv7SWRaSfqG4Dyl4BStUt6+cFxWck791K
 uNV10vRnST70WWqLvIXxnm9MTdNyA9G2Nv29PxC92jFhzlDk5eG2CjJnDy+xuO8jZYuppAm/6wjdG
 oVU4pMbWU61eVgHrmCQKjPVHKcx2JPEunpnasNCm7imYHZ8Lz3aku7KYCGf5qB/3zksBqGw2d6XAX
 fjUwGIv9QhQ4qI1Z83jgwW2f7tBb6chOx4ZFndzXO1nx+D7yErZofG7alKGqQQ9WCnhRl7ttPgM4M
 SBCMWmkYgQfJvianmhE3A6XzCFxZYDV1/R74zlZxPm+hVAD/T1Q2WyUkZ8H7J3GXmN4hjah8JsTS8
 LSmaFIX1smTgAh4J8wk6VtKbDIbPN/WT8Hauu25OgKy2NQMoBaH8a045RGe9TPmvDJ3A/jaQRmPnJ
 Zh1wXEDAyK109xAypBadcTN0Wemlt4PxIx+RXHgOIx+MAZML22UYfkB63k0vC4telUeSAeFjOHre/
 y+0G5frmeMgrXIm3PBWa+SS7L3gQ2Tt/RSsEZCpGU0dezGn5nCQtNZC2EU3xPHRxQ0anZnmkGeiF4
 /WU/aRnuBq7WLRgbNp2/m5hRrMV7yohEEzOXSUBxQ=;
Received: from [2a02:8012:2f01:0:521c:3ef:78b8:2419]
 by mail.ilande.co.uk with esmtpsa (TLS1.3:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.92) (envelope-from <mark.cave-ayland@ilande.co.uk>)
 id 1vCNYB-000BNQ-V1; Fri, 24 Oct 2025 20:34:15 +0100
Message-ID: <acaf33e9-380c-4d0b-9156-30b670d4fa37@ilande.co.uk>
Date: Fri, 24 Oct 2025 20:36:25 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org, qemu-riscv@nongnu.org, qemu-block@nongnu.org,
 Paolo Bonzini <pbonzini@redhat.com>, =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?=
 <berrange@redhat.com>, Eduardo Habkost <eduardo@habkost.net>
References: <20251024190416.8803-1-philmd@linaro.org>
 <20251024190416.8803-3-philmd@linaro.org>
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
In-Reply-To: <20251024190416.8803-3-philmd@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 2a02:8012:2f01:0:521c:3ef:78b8:2419
X-SA-Exim-Mail-From: mark.cave-ayland@ilande.co.uk
Subject: Re: [PATCH 02/27] hw/sysbus: Have various helpers take a const
 SysBusDevice argument
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

On 24/10/2025 20:03, Philippe Mathieu-Daudé wrote:

> These getters don't update any SysBusDevice internal fields,
> make the argument const.
> 
> Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
> ---
>   include/hw/sysbus.h | 10 +++++-----
>   hw/core/sysbus.c    | 10 +++++-----
>   2 files changed, 10 insertions(+), 10 deletions(-)
> 
> diff --git a/include/hw/sysbus.h b/include/hw/sysbus.h
> index 18fde8a7b48..69eb62e29c8 100644
> --- a/include/hw/sysbus.h
> +++ b/include/hw/sysbus.h
> @@ -70,17 +70,17 @@ struct SysBusDevice {
>   typedef void FindSysbusDeviceFunc(SysBusDevice *sbdev, void *opaque);
>   
>   void sysbus_init_mmio(SysBusDevice *dev, MemoryRegion *memory);
> -MemoryRegion *sysbus_mmio_get_region(SysBusDevice *dev, int n);
> +MemoryRegion *sysbus_mmio_get_region(const SysBusDevice *dev, int n);
>   void sysbus_init_irq(SysBusDevice *dev, qemu_irq *p);
>   void sysbus_pass_irq(SysBusDevice *dev, SysBusDevice *target);
>   void sysbus_init_ioports(SysBusDevice *dev, uint32_t ioport, uint32_t size);
>   
>   
> -bool sysbus_has_irq(SysBusDevice *dev, int n);
> -bool sysbus_has_mmio(SysBusDevice *dev, unsigned int n);
> +bool sysbus_has_irq(const SysBusDevice *dev, int n);
> +bool sysbus_has_mmio(const SysBusDevice *dev, unsigned int n);
>   void sysbus_connect_irq(SysBusDevice *dev, int n, qemu_irq irq);
> -bool sysbus_is_irq_connected(SysBusDevice *dev, int n);
> -qemu_irq sysbus_get_connected_irq(SysBusDevice *dev, int n);
> +bool sysbus_is_irq_connected(const SysBusDevice *dev, int n);
> +qemu_irq sysbus_get_connected_irq(const SysBusDevice *dev, int n);
>   void sysbus_mmio_map(SysBusDevice *dev, int n, hwaddr addr);
>   int sysbus_mmio_map_name(SysBusDevice *dev, const char*name, hwaddr addr);
>   void sysbus_mmio_map_overlap(SysBusDevice *dev, int n, hwaddr addr,
> diff --git a/hw/core/sysbus.c b/hw/core/sysbus.c
> index ec69e877a2c..ae447c1196a 100644
> --- a/hw/core/sysbus.c
> +++ b/hw/core/sysbus.c
> @@ -80,7 +80,7 @@ static void system_bus_class_init(ObjectClass *klass, const void *data)
>   }
>   
>   /* Check whether an IRQ source exists */
> -bool sysbus_has_irq(SysBusDevice *dev, int n)
> +bool sysbus_has_irq(const SysBusDevice *dev, int n)
>   {
>       char *prop = g_strdup_printf("%s[%d]", SYSBUS_DEVICE_GPIO_IRQ, n);
>       ObjectProperty *r;
> @@ -91,12 +91,12 @@ bool sysbus_has_irq(SysBusDevice *dev, int n)
>       return (r != NULL);
>   }
>   
> -bool sysbus_is_irq_connected(SysBusDevice *dev, int n)
> +bool sysbus_is_irq_connected(const SysBusDevice *dev, int n)
>   {
>       return !!sysbus_get_connected_irq(dev, n);
>   }
>   
> -qemu_irq sysbus_get_connected_irq(SysBusDevice *dev, int n)
> +qemu_irq sysbus_get_connected_irq(const SysBusDevice *dev, int n)
>   {
>       DeviceState *d = DEVICE(dev);
>       return qdev_get_gpio_out_connector(d, SYSBUS_DEVICE_GPIO_IRQ, n);
> @@ -114,7 +114,7 @@ void sysbus_connect_irq(SysBusDevice *dev, int n, qemu_irq irq)
>   }
>   
>   /* Check whether an MMIO region exists */
> -bool sysbus_has_mmio(SysBusDevice *dev, unsigned int n)
> +bool sysbus_has_mmio(const SysBusDevice *dev, unsigned int n)
>   {
>       return (n < dev->num_mmio);
>   }
> @@ -190,7 +190,7 @@ void sysbus_init_mmio(SysBusDevice *dev, MemoryRegion *memory)
>       dev->mmio[n].memory = memory;
>   }
>   
> -MemoryRegion *sysbus_mmio_get_region(SysBusDevice *dev, int n)
> +MemoryRegion *sysbus_mmio_get_region(const SysBusDevice *dev, int n)
>   {
>       assert(n >= 0 && n < QDEV_MAX_MMIO);
>       return dev->mmio[n].memory;

Reviewed-by: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>


ATB,

Mark.


