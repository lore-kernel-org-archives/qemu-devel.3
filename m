Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8D408CA1013
	for <qemu-devel@archiver.kernel.org>; Thu, 18 Sep 2025 19:17:17 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uzK7w-0004nl-Tv; Thu, 18 Sep 2025 15:17:09 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mark.cave-ayland@ilande.co.uk>)
 id 1uzK7s-0004n6-2Y; Thu, 18 Sep 2025 15:17:04 -0400
Received: from mail.ilande.co.uk ([2001:41c9:1:41f::167])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mark.cave-ayland@ilande.co.uk>)
 id 1uzK7o-0000tM-U9; Thu, 18 Sep 2025 15:17:03 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=ilande.co.uk; s=20220518; h=Subject:Content-Transfer-Encoding:Content-Type:
 In-Reply-To:From:References:Cc:To:MIME-Version:Date:Message-ID:Sender:
 Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender
 :Resent-To:Resent-Cc:Resent-Message-ID;
 bh=LRRbEX3yfQLkEf3KZItrZNYlItPMxSHb4/WdvEuK2R8=; b=qTV4JwSZC8JIxWQhqsISCET7uZ
 V1fRI2oL3n1nhEJfe8UQR7ZdaBkQgq4M6n+j1nK4NC+NNpfKUpXDybFAVS0tdItz8EvbxcfdMSwgS
 jBtliVp6eC8B0AiAkNKt9rwrNW6IDavKDRrxXAO64QaUUb1S6n//OwN5JTVADjbIykqyJN6r+ZMne
 dgh4rAk4NWvamaBmdqADrbTYlbcMFqI5BUwbBaNlC98tXHbhpSfOnU+WKUttczTxTIVRrz7MehDlJ
 KyDimM70b7COqbPYTUiW5Jfs7X9lzR1/pWW0tV8NvrgB+XLZcRi0ULk9Slr+T0llXJnhPNHMRPXNN
 jXQxdrCpSldUVxZ6AZG1XnIqF3z1n7tV2MEwa3mS0OMbHQDW8h/rBX5k/0GJl4PObwgMUKKYOeydC
 L83sJVqYNyzv7WQRusj1spIANynR4Ug0+Qex4f+/jy76o6kZIrlDVv803631uttyGnoeeWaFR4UdP
 phEyqW4bWk99MbJfldmz+xO0NN23+Xaax/bxnxX8vFk6tAw3MgQOk3/I6Vob2iz9qLsLBk+AdGIJc
 LCZS9ofxa1FkihSUXOQmT0f9kmqW8vKuloiRpxfE6nIFTpF2exouLk+yznj4x8Aj6h51KJcep18rl
 fthQDJEAIB0GIIU5h50VRoT6w5jl/4Mfy0YJ8DPRI=;
Received: from [2a02:8012:2f01:0:4825:8e53:bc9c:58e6]
 by mail.ilande.co.uk with esmtpsa (TLS1.3:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.92) (envelope-from <mark.cave-ayland@ilande.co.uk>)
 id 1uzK5o-0006Eu-BA; Thu, 18 Sep 2025 20:14:56 +0100
Message-ID: <32705f40-917f-4fe5-8203-f8a3fe7739e4@ilande.co.uk>
Date: Thu, 18 Sep 2025 20:16:57 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: BALATON Zoltan <balaton@eik.bme.hu>, qemu-devel@nongnu.org,
 qemu-ppc@nongnu.org
Cc: =?UTF-8?Q?Herv=C3=A9_Poussineau?= <hpoussin@reactos.org>,
 Artyom Tarasenko <atar4qemu@gmail.com>, Nicholas Piggin <npiggin@gmail.com>
References: <cover.1758219840.git.balaton@eik.bme.hu>
 <967c2416f25efd0162df32f43f8b2d048fe28b8d.1758219840.git.balaton@eik.bme.hu>
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
In-Reply-To: <967c2416f25efd0162df32f43f8b2d048fe28b8d.1758219840.git.balaton@eik.bme.hu>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 2a02:8012:2f01:0:4825:8e53:bc9c:58e6
X-SA-Exim-Mail-From: mark.cave-ayland@ilande.co.uk
Subject: Re: [PATCH v3 03/14] hw/pci-host/raven: Use DEFINE_TYPES macro
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

On 18/09/2025 19:50, BALATON Zoltan wrote:

> Convert to using DEFINE_TYPES macro and move raven_pcihost_class_init
> so methods of each object are grouped together.
> 
> Signed-off-by: BALATON Zoltan <balaton@eik.bme.hu>
> Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
> ---
>   hw/pci-host/raven.c | 57 +++++++++++++++++++++------------------------
>   1 file changed, 26 insertions(+), 31 deletions(-)
> 
> diff --git a/hw/pci-host/raven.c b/hw/pci-host/raven.c
> index 878c915de5..e0f98afebf 100644
> --- a/hw/pci-host/raven.c
> +++ b/hw/pci-host/raven.c
> @@ -304,6 +304,15 @@ static void raven_pcihost_initfn(Object *obj)
>       h->bus = &s->pci_bus;
>   }
>   
> +static void raven_pcihost_class_init(ObjectClass *klass, const void *data)
> +{
> +    DeviceClass *dc = DEVICE_CLASS(klass);
> +
> +    set_bit(DEVICE_CATEGORY_BRIDGE, dc->categories);
> +    dc->realize = raven_pcihost_realizefn;
> +    dc->fw_name = "pci";
> +}
> +
>   static void raven_realize(PCIDevice *d, Error **errp)
>   {
>       d->config[PCI_CACHE_LINE_SIZE] = 0x08;
> @@ -329,37 +338,23 @@ static void raven_class_init(ObjectClass *klass, const void *data)
>       dc->user_creatable = false;
>   }
>   
> -static const TypeInfo raven_info = {
> -    .name = TYPE_RAVEN_PCI_DEVICE,
> -    .parent = TYPE_PCI_DEVICE,
> -    .class_init = raven_class_init,
> -    .interfaces = (const InterfaceInfo[]) {
> -        { INTERFACE_CONVENTIONAL_PCI_DEVICE },
> -        { },
> +static const TypeInfo raven_types[] = {
> +    {
> +        .name = TYPE_RAVEN_PCI_HOST_BRIDGE,
> +        .parent = TYPE_PCI_HOST_BRIDGE,
> +        .instance_size = sizeof(PREPPCIState),
> +        .instance_init = raven_pcihost_initfn,
> +        .class_init = raven_pcihost_class_init,
> +    },
> +    {
> +        .name = TYPE_RAVEN_PCI_DEVICE,
> +        .parent = TYPE_PCI_DEVICE,
> +        .class_init = raven_class_init,
> +        .interfaces = (const InterfaceInfo[]) {
> +            { INTERFACE_CONVENTIONAL_PCI_DEVICE },
> +            { },
> +        },
>       },
>   };
>   
> -static void raven_pcihost_class_init(ObjectClass *klass, const void *data)
> -{
> -    DeviceClass *dc = DEVICE_CLASS(klass);
> -
> -    set_bit(DEVICE_CATEGORY_BRIDGE, dc->categories);
> -    dc->realize = raven_pcihost_realizefn;
> -    dc->fw_name = "pci";
> -}
> -
> -static const TypeInfo raven_pcihost_info = {
> -    .name = TYPE_RAVEN_PCI_HOST_BRIDGE,
> -    .parent = TYPE_PCI_HOST_BRIDGE,
> -    .instance_size = sizeof(PREPPCIState),
> -    .instance_init = raven_pcihost_initfn,
> -    .class_init = raven_pcihost_class_init,
> -};
> -
> -static void raven_register_types(void)
> -{
> -    type_register_static(&raven_pcihost_info);
> -    type_register_static(&raven_info);
> -}
> -
> -type_init(raven_register_types)
> +DEFINE_TYPES(raven_types)

Reviewed-by: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>


ATB,

Mark.


