Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 201F2CCF9E3
	for <qemu-devel@archiver.kernel.org>; Fri, 24 Oct 2025 18:51:04 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vCMrd-0005db-Hz; Fri, 24 Oct 2025 14:50:13 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mark.cave-ayland@ilande.co.uk>)
 id 1vCMrb-0005dH-Em; Fri, 24 Oct 2025 14:50:11 -0400
Received: from mail.ilande.co.uk ([2001:41c9:1:41f::167])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mark.cave-ayland@ilande.co.uk>)
 id 1vCMrZ-0003hh-AI; Fri, 24 Oct 2025 14:50:11 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=ilande.co.uk; s=20220518; h=Subject:Content-Transfer-Encoding:Content-Type:
 In-Reply-To:From:References:Cc:To:MIME-Version:Date:Message-ID:Sender:
 Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender
 :Resent-To:Resent-Cc:Resent-Message-ID;
 bh=T6f/Wb0rJA+ZjSfZQBNbJyUWta3KDccIAnOnrcPexZM=; b=PDl85yebiS1IinpdHx1Z05Ip2A
 Efi/pJhOzApHjJmw4TfNYqu1KrxxENxA0epHqatV6cctmpvoBtx0cT3GQ1T+bFcs6V+8TbtjyDKim
 ycooz0OFm2Z75w5/dBQwFTiTR/lFv/bnC3Bj3wCT/4bjivzlaS2lK6ZW4+a2PFU0q0QnKiK9sKjSb
 KGQzItY4g00Jsc3XvBG20TTo5rgYJuxgBTyD951c5bf0rBfwfl7uAvKEwnB7vs4gC0Xw4zUyQ4WyN
 OcDp+sD6Oomt7YRQPer3dDj/H0pXketzeSAnXoHuPNFT+dV9LwE+vWHMABJZVHdFqJxKhW1YbJe/U
 l6ej+/BPo/vrXXlIk5tIings/8VT0bLkEGPHafKPMWFP2DSm85Ev1gR7/seU3N0Hjv9Gy28QldkuU
 lm8rP5a7byr6RDiiNGq2oz5fvJMzrOawbos4GD16+5WfbzVFiT+Q07JtpYB2h9EO+XHREuBdAh4g3
 0NDg6QUbQon9jQcMn+f1erx2LGWiWra+ACOht37DMUA62v1URNi56kQ1HVu5bDFjiNCCh3qcCM+BY
 weQdQV2FKJwPmEOSV4CvMBkSEHquhhn8G0S8yh80fELNYMnCzbrd4aQ/yK9AKU+MrLPRYIHn4DiSg
 rNpDJLDou40wMJTYRAit1FHYSG01CsHOgVxq8BlNg=;
Received: from [2a02:8012:2f01:0:521c:3ef:78b8:2419]
 by mail.ilande.co.uk with esmtpsa (TLS1.3:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.92) (envelope-from <mark.cave-ayland@ilande.co.uk>)
 id 1vCMpF-000B57-Rp; Fri, 24 Oct 2025 19:47:49 +0100
Message-ID: <663659f9-62a9-4943-bc75-c61990e6dc11@ilande.co.uk>
Date: Fri, 24 Oct 2025 19:49:45 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: BALATON Zoltan <balaton@eik.bme.hu>, qemu-devel@nongnu.org,
 qemu-ppc@nongnu.org
Cc: =?UTF-8?Q?Herv=C3=A9_Poussineau?= <hpoussin@reactos.org>,
 Artyom Tarasenko <atar4qemu@gmail.com>, Nicholas Piggin <npiggin@gmail.com>,
 Markus Armbruster <armbru@redhat.com>,
 Harsh Prateek Bora <harshpb@linux.ibm.com>
References: <cover.1761232472.git.balaton@eik.bme.hu>
 <5a60e395d72e5eb4d01093434fbb645d72ac567a.1761232472.git.balaton@eik.bme.hu>
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
In-Reply-To: <5a60e395d72e5eb4d01093434fbb645d72ac567a.1761232472.git.balaton@eik.bme.hu>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-SA-Exim-Connect-IP: 2a02:8012:2f01:0:521c:3ef:78b8:2419
X-SA-Exim-Mail-From: mark.cave-ayland@ilande.co.uk
Subject: Re: [PATCH v5 01/13] hw/pci-host/raven: Simplify creating PCI facing
 part
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

On 23/10/2025 16:26, BALATON Zoltan wrote:

> There is no need to init and realize the PCI facing part of the host
> bridge separately as it does not expose any properties that need to be
> available before realize. It can be simpilfied using pci_create_simple.
> 
> Signed-off-by: BALATON Zoltan <balaton@eik.bme.hu>
> ---
>   hw/pci-host/raven.c | 11 +----------
>   1 file changed, 1 insertion(+), 10 deletions(-)
> 
> diff --git a/hw/pci-host/raven.c b/hw/pci-host/raven.c
> index eacffc86d8..c0492d1456 100644
> --- a/hw/pci-host/raven.c
> +++ b/hw/pci-host/raven.c
> @@ -65,7 +65,6 @@ struct PRePPCIState {
>       MemoryRegion bm_ram_alias;
>       MemoryRegion bm_pci_memory_alias;
>       AddressSpace bm_as;
> -    RavenPCIState pci_dev;
>   
>       int contiguous_map;
>   };
> @@ -260,8 +259,7 @@ static void raven_pcihost_realizefn(DeviceState *d, Error **errp)
>                             "pci-intack", 1);
>       memory_region_add_subregion(address_space_mem, 0xbffffff0, &s->pci_intack);
>   
> -    /* TODO Remove once realize propagates to child devices. */
> -    qdev_realize(DEVICE(&s->pci_dev), BUS(&s->pci_bus), errp);
> +    pci_create_simple(&s->pci_bus, PCI_DEVFN(0, 0), TYPE_RAVEN_PCI_DEVICE);
>   }
>   
>   static void raven_pcihost_initfn(Object *obj)
> @@ -269,7 +267,6 @@ static void raven_pcihost_initfn(Object *obj)
>       PCIHostState *h = PCI_HOST_BRIDGE(obj);
>       PREPPCIState *s = RAVEN_PCI_HOST_BRIDGE(obj);
>       MemoryRegion *address_space_mem = get_system_memory();
> -    DeviceState *pci_dev;
>   
>       memory_region_init(&s->pci_io, obj, "pci-io", 0x3f800000);
>       memory_region_init_io(&s->pci_io_non_contiguous, obj, &raven_io_ops, s,
> @@ -306,12 +303,6 @@ static void raven_pcihost_initfn(Object *obj)
>       pci_setup_iommu(&s->pci_bus, &raven_iommu_ops, s);
>   
>       h->bus = &s->pci_bus;
> -
> -    object_initialize(&s->pci_dev, sizeof(s->pci_dev), TYPE_RAVEN_PCI_DEVICE);
> -    pci_dev = DEVICE(&s->pci_dev);
> -    object_property_set_int(OBJECT(&s->pci_dev), "addr", PCI_DEVFN(0, 0),
> -                            NULL);
> -    qdev_prop_set_bit(pci_dev, "multifunction", false);
>   }
>   
>   static void raven_realize(PCIDevice *d, Error **errp)

Reviewed-by: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>


ATB,

Mark.


