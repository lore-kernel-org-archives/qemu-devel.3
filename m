Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 533CBCAC597
	for <qemu-devel@archiver.kernel.org>; Thu, 18 Sep 2025 19:45:26 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uzKYn-00071t-A8; Thu, 18 Sep 2025 15:44:54 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mark.cave-ayland@ilande.co.uk>)
 id 1uzKYj-00070j-Gk; Thu, 18 Sep 2025 15:44:50 -0400
Received: from mail.ilande.co.uk ([2001:41c9:1:41f::167])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mark.cave-ayland@ilande.co.uk>)
 id 1uzKYh-0005cA-L9; Thu, 18 Sep 2025 15:44:48 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=ilande.co.uk; s=20220518; h=Subject:Content-Transfer-Encoding:Content-Type:
 In-Reply-To:From:References:Cc:To:MIME-Version:Date:Message-ID:Sender:
 Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender
 :Resent-To:Resent-Cc:Resent-Message-ID;
 bh=CmGms4tFDncgCt6dDzPCY3VL81IIsvZmUlOzYIgpriY=; b=Rjzh+Hz7tCxug/0rLYGHRfjtog
 SHTu2QJDp3S6ar+6tKFyDZe4sKGuVBWDfewsohgh000xbomxIoJNt+SwsqG7WOOZvoe9dtbSKJEDl
 +Q6p7SqIMwjWUSmJqRvat4tw4Xl77QxuAtgFB1dBxICvhwIIVTG5S2trRidMgFLBAm6HH6Og3TZ9A
 BLHSTbAoJeNTiRQo/G6Q7zDI4P04+0NjII81LI3b02D8vi5ohfQwmQlVILtpEEfkRSgTrRG7h3Gte
 j3xXYDq/nAv0PDZ+kFioXq9JmTQh4nQ354Jo7PSk533Ag1wjwqNeYI0rBZrGspfa9EBdtvl7ddJUH
 ufa4A+hoxBeqmC/aFPDJLSDFwd7JOzcMRa0+CXrxyHSynJtox6NfMaABAAs64LrqAEt8L1c2XrRqO
 JXourPtoulKwQaH36cbcF99mWu3X+dxWnIgRvDwlkJrirXyCYCJRAejhs4GoDdouZcbeckcpqg8L9
 4k+QyOonImOIqLqQ5isPivP84uLtLsyLJQXk2b9z4/Ll0pxMajwGyXQ1wBi1gEnU/qqeF0sd3cfx9
 k/7VIA6sv9MmoODVLH8FwW36Yt/MasxaLJRRFp2+qT3UoQoPCKR/1cLs+MzWmParuPK4A6KE8yx8A
 E38W9ibqteVz3Bsr9bKCoUSNhcTu0D60A7zCqZo5Q=;
Received: from [2a02:8012:2f01:0:4825:8e53:bc9c:58e6]
 by mail.ilande.co.uk with esmtpsa (TLS1.3:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.92) (envelope-from <mark.cave-ayland@ilande.co.uk>)
 id 1uzKWh-0006Qi-KT; Thu, 18 Sep 2025 20:42:43 +0100
Message-ID: <0046fad8-9136-40bf-bd65-3500e73ba3e1@ilande.co.uk>
Date: Thu, 18 Sep 2025 20:44:45 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: BALATON Zoltan <balaton@eik.bme.hu>, qemu-devel@nongnu.org,
 qemu-ppc@nongnu.org
Cc: =?UTF-8?Q?Herv=C3=A9_Poussineau?= <hpoussin@reactos.org>,
 Artyom Tarasenko <atar4qemu@gmail.com>, Nicholas Piggin <npiggin@gmail.com>
References: <cover.1758219840.git.balaton@eik.bme.hu>
 <07eaef3ca91a8d7c9a4c71fe144ded6e9c4f9211.1758219840.git.balaton@eik.bme.hu>
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
In-Reply-To: <07eaef3ca91a8d7c9a4c71fe144ded6e9c4f9211.1758219840.git.balaton@eik.bme.hu>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-SA-Exim-Connect-IP: 2a02:8012:2f01:0:4825:8e53:bc9c:58e6
X-SA-Exim-Mail-From: mark.cave-ayland@ilande.co.uk
Subject: Re: [PATCH v3 07/14] hw/pci-host/raven: Rename direct config access
 ops
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

> Rename memory io ops implementing PCI configuration direct access to
> mmcfg which describes better what these are for.
> 
> Signed-off-by: BALATON Zoltan <balaton@eik.bme.hu>
> ---
>   hw/pci-host/raven.c | 17 ++++++++---------
>   1 file changed, 8 insertions(+), 9 deletions(-)
> 
> diff --git a/hw/pci-host/raven.c b/hw/pci-host/raven.c
> index 66dab28a29..d7a0bde382 100644
> --- a/hw/pci-host/raven.c
> +++ b/hw/pci-host/raven.c
> @@ -62,25 +62,24 @@ static inline uint32_t raven_idsel_to_addr(hwaddr addr)
>       return (ctz16(addr >> 11) << 11) | (addr & 0x7ff);
>   }
>   
> -static void raven_pci_io_write(void *opaque, hwaddr addr,
> -                               uint64_t val, unsigned int size)
> +static void raven_mmcfg_write(void *opaque, hwaddr addr, uint64_t val,
> +                              unsigned int size)
>   {
>       PREPPCIState *s = opaque;
>       PCIHostState *phb = PCI_HOST_BRIDGE(s);
>       pci_data_write(phb->bus, raven_idsel_to_addr(addr), val, size);
>   }
>   
> -static uint64_t raven_pci_io_read(void *opaque, hwaddr addr,
> -                                  unsigned int size)
> +static uint64_t raven_mmcfg_read(void *opaque, hwaddr addr, unsigned int size)
>   {
>       PREPPCIState *s = opaque;
>       PCIHostState *phb = PCI_HOST_BRIDGE(s);
>       return pci_data_read(phb->bus, raven_idsel_to_addr(addr), size);
>   }
>   
> -static const MemoryRegionOps raven_pci_io_ops = {
> -    .read = raven_pci_io_read,
> -    .write = raven_pci_io_write,
> +static const MemoryRegionOps raven_mmcfg_ops = {
> +    .read = raven_mmcfg_read,
> +    .write = raven_mmcfg_write,
>       .endianness = DEVICE_LITTLE_ENDIAN,
>   };
>   
> @@ -234,8 +233,8 @@ static void raven_pcihost_realizefn(DeviceState *d, Error **errp)
>                             "pci-conf-data", 4);
>       memory_region_add_subregion(&s->pci_io, 0xcfc, &h->data_mem);
>   
> -    memory_region_init_io(&h->mmcfg, OBJECT(s), &raven_pci_io_ops, s,
> -                          "pciio", 0x00400000);
> +    memory_region_init_io(&h->mmcfg, OBJECT(s), &raven_mmcfg_ops, s,
> +                          "pci-mmcfg", 0x00400000);
>       memory_region_add_subregion(address_space_mem, 0x80800000, &h->mmcfg);
>   
>       memory_region_init_io(&s->pci_intack, OBJECT(s), &raven_intack_ops, s,

Reviewed-by: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>


ATB,

Mark.


