Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 79679CAC597
	for <qemu-devel@archiver.kernel.org>; Thu, 18 Sep 2025 20:54:58 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uzLeL-0003t5-HZ; Thu, 18 Sep 2025 16:54:41 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mark.cave-ayland@ilande.co.uk>)
 id 1uzLeI-0003sg-Hb; Thu, 18 Sep 2025 16:54:38 -0400
Received: from mail.ilande.co.uk ([2001:41c9:1:41f::167])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mark.cave-ayland@ilande.co.uk>)
 id 1uzLeG-0008B9-Q0; Thu, 18 Sep 2025 16:54:38 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=ilande.co.uk; s=20220518; h=Subject:Content-Transfer-Encoding:Content-Type:
 In-Reply-To:From:References:Cc:To:MIME-Version:Date:Message-ID:Sender:
 Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender
 :Resent-To:Resent-Cc:Resent-Message-ID;
 bh=H+hhYuVxEh/qDXcQ9aPT0Hdel6pUxp6c48U+M9edRuA=; b=wZ3ixeXblz2/6FFh2/50qF5woj
 HHX8/6izW+LW/iSQC510m7Id/kbc2K0ALM5FlxrwoOKtcJ5VkQSYPv0eVFm8k+bHfsMhsxWaZqzpp
 0TT9cASa3DvWyDPuqT1AJ5dKQ80lbbnZwVeYKJynaQymfquB6c0AENktB68lAJdh4sXx5jBigQn1/
 2ZjSM2nXc5KjSW3OhmmtTKeG5Q6RHCkfPU4OuVCso2OXFvlZlbo6gXpDAZzTWG9YqjxOy1Bocn2BJ
 +iotXepz+utb67wUD6qJ/fpOoLQkBRr2y9a/prAhmETygUut+AHJvSa9jYL/vSjUE8ZptsYcpQt4v
 rdTVGMwY/mI9NEyc0nBRavKfyr/5VmME34XZshGZNK86K/Aov5G+h8ZmUKV3F6hBUxsCDFCYImYMY
 NpqbXvJMajzTUUcyW2Z7/b7CZGnkaiPelnI9rv2uOknJp0gEn19LCGdC5Kk7hOTQl1yj8wViGpfT3
 kHTAKmqQpynKF9nwLw9zP3s8KL4NHXlKRje+q9qMxydO2619oYU3f5TmTkPpkajE9UnfhCFG7GjpV
 wt9vmf0A63TqoDC2MLXRgyFnlqqKM26bXxxFQ59UTcYu0AcWQ7BIH57a8o1XIzKYT+ODTgT0M27sA
 RxA6xAH3Vgi2swnuZDwPrbe8CxKEd71ysNtmKW3o0=;
Received: from [2a02:8012:2f01:0:4825:8e53:bc9c:58e6]
 by mail.ilande.co.uk with esmtpsa (TLS1.3:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.92) (envelope-from <mark.cave-ayland@ilande.co.uk>)
 id 1uzLcE-0006xs-Cj; Thu, 18 Sep 2025 21:52:30 +0100
Message-ID: <5a080c36-4907-4902-a3ce-e8391de6334f@ilande.co.uk>
Date: Thu, 18 Sep 2025 21:54:32 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: BALATON Zoltan <balaton@eik.bme.hu>, qemu-devel@nongnu.org,
 qemu-ppc@nongnu.org
Cc: =?UTF-8?Q?Herv=C3=A9_Poussineau?= <hpoussin@reactos.org>,
 Artyom Tarasenko <atar4qemu@gmail.com>, Nicholas Piggin <npiggin@gmail.com>
References: <cover.1758219840.git.balaton@eik.bme.hu>
 <1bad5670230f769170a05d6fbc79957d30b61ff8.1758219840.git.balaton@eik.bme.hu>
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
In-Reply-To: <1bad5670230f769170a05d6fbc79957d30b61ff8.1758219840.git.balaton@eik.bme.hu>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-SA-Exim-Connect-IP: 2a02:8012:2f01:0:4825:8e53:bc9c:58e6
X-SA-Exim-Mail-From: mark.cave-ayland@ilande.co.uk
Subject: Re: [PATCH v3 12/14] hw/pci-host/raven: Move bus master address space
 creation to one place
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

> Move the lines related to creating the bus master address space
> together and reduce the number of memory regions stored in the device
> state. These are used once to create the address space and can be
> tracked with their owner object so no need to keep track of them in
> the device state. Keep only the address space that is used later in a
> callback.
> 
> Signed-off-by: BALATON Zoltan <balaton@eik.bme.hu>
> ---
>   hw/pci-host/raven.c | 37 ++++++++++++++++++-------------------
>   1 file changed, 18 insertions(+), 19 deletions(-)
> 
> diff --git a/hw/pci-host/raven.c b/hw/pci-host/raven.c
> index bf4f4b7f71..ebf0c511dc 100644
> --- a/hw/pci-host/raven.c
> +++ b/hw/pci-host/raven.c
> @@ -46,9 +46,6 @@ struct PREPPCIState {
>       MemoryRegion pci_discontiguous_io;
>       MemoryRegion pci_memory;
>       MemoryRegion pci_intack;
> -    MemoryRegion bm;
> -    MemoryRegion bm_ram_alias;
> -    MemoryRegion bm_pci_memory_alias;
>       AddressSpace bm_as;
>   };
>   
> @@ -178,7 +175,8 @@ static void raven_pcihost_realizefn(DeviceState *d, Error **errp)
>       SysBusDevice *dev = SYS_BUS_DEVICE(d);
>       PCIHostState *h = PCI_HOST_BRIDGE(dev);
>       PREPPCIState *s = RAVEN_PCI_HOST_BRIDGE(dev);
> -    MemoryRegion *mr, *address_space_mem = get_system_memory();
> +    Object *o = OBJECT(d);
> +    MemoryRegion *mr, *bm, *address_space_mem = get_system_memory();
>   
>       qdev_init_gpio_in(d, raven_change_gpio, 1);
>   
> @@ -187,26 +185,37 @@ static void raven_pcihost_realizefn(DeviceState *d, Error **errp)
>                                      &s->irq, &s->pci_memory, &s->pci_io, 0, 1,
>                                      TYPE_PCI_BUS);
>   
> -    memory_region_init_io(&h->conf_mem, OBJECT(h), &pci_host_conf_le_ops, s,
> +    memory_region_init_io(&h->conf_mem, o, &pci_host_conf_le_ops, s,
>                             "pci-conf-idx", 4);
>       memory_region_add_subregion(&s->pci_io, 0xcf8, &h->conf_mem);
>   
> -    memory_region_init_io(&h->data_mem, OBJECT(h), &pci_host_data_le_ops, s,
> +    memory_region_init_io(&h->data_mem, o, &pci_host_data_le_ops, s,
>                             "pci-conf-data", 4);
>       memory_region_add_subregion(&s->pci_io, 0xcfc, &h->data_mem);
>   
>       mr = g_new0(MemoryRegion, 1);
> -    memory_region_init_io(mr, OBJECT(h), &raven_mmcfg_ops, h->bus,
> +    memory_region_init_io(mr, o, &raven_mmcfg_ops, h->bus,
>                             "pci-mmcfg", 8 * MiB);
>       memory_region_add_subregion(&s->pci_io, 0x800000, mr);
>   
> -    memory_region_init_io(&s->pci_intack, OBJECT(s), &raven_intack_ops, s,
> +    memory_region_init_io(&s->pci_intack, o, &raven_intack_ops, s,
>                             "pci-intack", 1);
>       memory_region_add_subregion(address_space_mem, 0xbffffff0, &s->pci_intack);
>   
>       pci_create_simple(h->bus, PCI_DEVFN(0, 0), TYPE_RAVEN_PCI_DEVICE);
>   
> -    address_space_init(&s->bm_as, &s->bm, "raven-bm");
> +    /* Bus master address space */
> +    bm = g_new0(MemoryRegion, 1);
> +    memory_region_init(bm, o, "raven-bm", 4 * GiB);
> +    mr = g_new0(MemoryRegion, 1);
> +    memory_region_init_alias(mr, o, "bm-pci-memory", &s->pci_memory, 0,
> +                             memory_region_size(&s->pci_memory));
> +    memory_region_add_subregion(bm, 0, mr);
> +    mr = g_new0(MemoryRegion, 1);
> +    memory_region_init_alias(mr, o, "bm-system", get_system_memory(),
> +                             0, 0x80000000);
> +    memory_region_add_subregion(bm, 0x80000000, mr);
> +    address_space_init(&s->bm_as, bm, "raven-bm-as");
>       pci_setup_iommu(h->bus, &raven_iommu_ops, s);
>   }
>   
> @@ -228,16 +237,6 @@ static void raven_pcihost_initfn(Object *obj)
>                                           &s->pci_discontiguous_io, 1);
>       memory_region_set_enabled(&s->pci_discontiguous_io, false);
>       memory_region_add_subregion(address_space_mem, 0xc0000000, &s->pci_memory);
> -
> -    /* Bus master address space */
> -    memory_region_init(&s->bm, obj, "bm-raven", 4 * GiB);
> -    memory_region_init_alias(&s->bm_pci_memory_alias, obj, "bm-pci-memory",
> -                             &s->pci_memory, 0,
> -                             memory_region_size(&s->pci_memory));
> -    memory_region_init_alias(&s->bm_ram_alias, obj, "bm-system",
> -                             get_system_memory(), 0, 0x80000000);
> -    memory_region_add_subregion(&s->bm, 0         , &s->bm_pci_memory_alias);
> -    memory_region_add_subregion(&s->bm, 0x80000000, &s->bm_ram_alias);
>   }
>   
>   static void raven_pcihost_class_init(ObjectClass *klass, const void *data)

Same comment here for patch 9: what is the advantage of changing this if the 
lifetimes are not different?


ATB,

Mark.


