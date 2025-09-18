Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E47C3CAC597
	for <qemu-devel@archiver.kernel.org>; Thu, 18 Sep 2025 20:35:39 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uzLKy-0003S0-3e; Thu, 18 Sep 2025 16:34:40 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mark.cave-ayland@ilande.co.uk>)
 id 1uzLKv-0003Rl-D4; Thu, 18 Sep 2025 16:34:37 -0400
Received: from mail.ilande.co.uk ([2001:41c9:1:41f::167])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mark.cave-ayland@ilande.co.uk>)
 id 1uzLKt-00056R-SY; Thu, 18 Sep 2025 16:34:37 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=ilande.co.uk; s=20220518; h=Subject:Content-Transfer-Encoding:Content-Type:
 In-Reply-To:From:References:Cc:To:MIME-Version:Date:Message-ID:Sender:
 Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender
 :Resent-To:Resent-Cc:Resent-Message-ID;
 bh=FCNvMheAuBSEdDsi1h387swkMoYJ6nGpugDfRenIdmY=; b=c7Yeb4HsKmd/n+BkKUoYDid9r2
 L09I6e/Ur/yrv/7zWb9G5MX008zQHawk4z7eBULJGIHICa8+GSK7ZCDNOrJPG3sy/isjsbZ8w2vm5
 dcZB3Jx0nw2fdlJ7TIcCYel1k4WCwrf8O9UZSKHzjnahmcfTWBNFdd0Y0EBavNY60p8pYl4rfx+CB
 2U/Oz1cWrQ4ze8fGk8Kb7qB9X4llRPv6EqYYpr0lE+J/JeDxWNpjHBh7nxLH6+Eqkjh0W0aDoAqcF
 gIowNVKBrp33eioTBq4ZPLdU5lnn/AehGe5DIY4EBMTtdMZ80DdvL8s58guMAe0mwcDlvN21UgaTu
 edPiuNuwvvb58Lzo7TeG3thsNGBDCA6sGhSAWz5M+Z5r0R4v3SM9bAZKoN4cSPUysvS9zVVe6XFns
 GESx/KGvole3wA2/Bht2Wz1LqooeWkM8MU1uAURTHQuKEzjVcL7+fkqnfRswYrT5vHarrXsNdUxbB
 RYnpbWdwl03KfGWFf4EI2fQkJxIl6ufqTtVeOegEuanTlRBpivrnpiAI0OzLFtHk8wY1rMDPRMjSs
 LM52gMQ7+NIPB4rR5AEtO5DU+ajxwpZI86VQgzRQsPnFG6+ZXDFHsKZVIanWFekxHzewJRk7bVCkr
 37qlhoSrnlEV8QQJjmfj7wnmr0Eyn/+wtkUqkTzJw=;
Received: from [2a02:8012:2f01:0:4825:8e53:bc9c:58e6]
 by mail.ilande.co.uk with esmtpsa (TLS1.3:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.92) (envelope-from <mark.cave-ayland@ilande.co.uk>)
 id 1uzLIq-0006py-Cb; Thu, 18 Sep 2025 21:32:28 +0100
Message-ID: <0a242c0d-8f6d-49e9-b766-16c9ace4800c@ilande.co.uk>
Date: Thu, 18 Sep 2025 21:34:30 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: BALATON Zoltan <balaton@eik.bme.hu>, qemu-devel@nongnu.org,
 qemu-ppc@nongnu.org
Cc: =?UTF-8?Q?Herv=C3=A9_Poussineau?= <hpoussin@reactos.org>,
 Artyom Tarasenko <atar4qemu@gmail.com>, Nicholas Piggin <npiggin@gmail.com>
References: <cover.1758219840.git.balaton@eik.bme.hu>
 <5e0b69e9fe3d36486a629b6c322a5eb2962f6972.1758219840.git.balaton@eik.bme.hu>
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
In-Reply-To: <5e0b69e9fe3d36486a629b6c322a5eb2962f6972.1758219840.git.balaton@eik.bme.hu>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-SA-Exim-Connect-IP: 2a02:8012:2f01:0:4825:8e53:bc9c:58e6
X-SA-Exim-Mail-From: mark.cave-ayland@ilande.co.uk
Subject: Re: [PATCH v3 09/14] hw/pci-host/raven: Do not use parent object for
 mmcfg region
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

> The mmcfg field in PCIHostState is only used by raven for the PCI
> config direct access but is not actually needed as the memory region
> lifetime can be managed by the object given during init so use that
> and remove the unused field from PCIHostState.
> 
> Signed-off-by: BALATON Zoltan <balaton@eik.bme.hu>
> ---
>   hw/pci-host/raven.c       | 7 ++++---
>   include/hw/pci/pci_host.h | 1 -
>   2 files changed, 4 insertions(+), 4 deletions(-)
> 
> diff --git a/hw/pci-host/raven.c b/hw/pci-host/raven.c
> index 2057a1869f..23020fd09f 100644
> --- a/hw/pci-host/raven.c
> +++ b/hw/pci-host/raven.c
> @@ -216,7 +216,7 @@ static void raven_pcihost_realizefn(DeviceState *d, Error **errp)
>       SysBusDevice *dev = SYS_BUS_DEVICE(d);
>       PCIHostState *h = PCI_HOST_BRIDGE(dev);
>       PREPPCIState *s = RAVEN_PCI_HOST_BRIDGE(dev);
> -    MemoryRegion *address_space_mem = get_system_memory();
> +    MemoryRegion *mr, *address_space_mem = get_system_memory();
>   
>       qdev_init_gpio_in(d, raven_change_gpio, 1);
>   
> @@ -233,9 +233,10 @@ static void raven_pcihost_realizefn(DeviceState *d, Error **errp)
>                             "pci-conf-data", 4);
>       memory_region_add_subregion(&s->pci_io, 0xcfc, &h->data_mem);
>   
> -    memory_region_init_io(&h->mmcfg, OBJECT(h), &raven_mmcfg_ops, h->bus,
> +    mr = g_new0(MemoryRegion, 1);
> +    memory_region_init_io(mr, OBJECT(h), &raven_mmcfg_ops, h->bus,
>                             "pci-mmcfg", 0x00400000);
> -    memory_region_add_subregion(address_space_mem, 0x80800000, &h->mmcfg);
> +    memory_region_add_subregion(address_space_mem, 0x80800000, mr);
>   
>       memory_region_init_io(&s->pci_intack, OBJECT(s), &raven_intack_ops, s,
>                             "pci-intack", 1);
> diff --git a/include/hw/pci/pci_host.h b/include/hw/pci/pci_host.h
> index 954dd446fa..a13f879872 100644
> --- a/include/hw/pci/pci_host.h
> +++ b/include/hw/pci/pci_host.h
> @@ -41,7 +41,6 @@ struct PCIHostState {
>   
>       MemoryRegion conf_mem;
>       MemoryRegion data_mem;
> -    MemoryRegion mmcfg;
>       uint32_t config_reg;
>       bool mig_enabled;
>       PCIBus *bus;

Is there any reason that the lifetime of the MemoryRegion needs to be separate from 
that of the device itself? If not, I'm struggling to understand why this needs to be 
changed.


ATB,

Mark.


