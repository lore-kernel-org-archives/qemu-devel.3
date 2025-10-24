Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3FA89CCF9E0
	for <qemu-devel@archiver.kernel.org>; Fri, 24 Oct 2025 18:51:42 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vCMsc-0005z7-D3; Fri, 24 Oct 2025 14:51:14 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mark.cave-ayland@ilande.co.uk>)
 id 1vCMsZ-0005x1-Ky; Fri, 24 Oct 2025 14:51:11 -0400
Received: from mail.ilande.co.uk ([2001:41c9:1:41f::167])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mark.cave-ayland@ilande.co.uk>)
 id 1vCMsX-0003mU-Le; Fri, 24 Oct 2025 14:51:11 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=ilande.co.uk; s=20220518; h=Subject:Content-Transfer-Encoding:Content-Type:
 In-Reply-To:From:References:Cc:To:MIME-Version:Date:Message-ID:Sender:
 Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender
 :Resent-To:Resent-Cc:Resent-Message-ID;
 bh=sisQzolJPTdubEX7W/qvFv42/OZgStnF2J5ERyw41fI=; b=NNf+WXlDK6661vehtmOYi3cuEb
 zUsZOFiOx6byukXHqGC+N/uI3u5JZOODnKYsWG3eHhJZ2iorWwq3TM0kkxeSg4wvwDqK+479WPO2+
 LBk4LLFEaRZ8knBtEUjFRxRk3Fd3PbNfTHhznrIOsbDcTKqCp3CghGp4xarEd9YLMW2HO6DHkHBa5
 BwPHKUDA+Zwt3s+jDbxa2K5zJHF/2mff3s/a5bpd5qnWy86Wvd5IzfwnxKgNNPrKsYkie99jldvTp
 Ba0Mg+QJV2y0x0vVcjTfej0v1z/I+rKhGnNspyGK7hBHDAgrbGYcDksUrDsCqIEVSrENrvmTpeTdL
 7JW7Pv2Qt4uUoQ1WBqMQoHZkbL3j6yUmWdCXDrAu50/y8HkiwLrDezwv7ArujbWpUbDg4epgS6KsH
 oxOG7mwH1+K4WD+hHKzsmHKndJrY9pdL1lsIbTrkpaRyPyULkIAUn91NjLyN80/jbWaUVMQfftTBs
 hUS0vsAWkbfptrKvTUhFw8HL5pYF/TrlOAdFSIbu4m8caRy78FfsD+535xezkyNbsPI9pIyZzOySz
 nSryzId8l8Y2PDg+FGBmxPllFuiZuWT8P5LedkbYIyktP1bvh7HZiteQtICUnofjuVTkiHS3aODXI
 qnTFA3at+wV6DU8BJrV7ao04lL3iBh02Sy9Wb6bNc=;
Received: from [2a02:8012:2f01:0:521c:3ef:78b8:2419]
 by mail.ilande.co.uk with esmtpsa (TLS1.3:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.92) (envelope-from <mark.cave-ayland@ilande.co.uk>)
 id 1vCMqH-000B5i-8O; Fri, 24 Oct 2025 19:48:53 +0100
Message-ID: <bbbf39fc-f6cc-4988-8f59-e49fa2e153a9@ilande.co.uk>
Date: Fri, 24 Oct 2025 19:51:00 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: BALATON Zoltan <balaton@eik.bme.hu>, qemu-devel@nongnu.org,
 qemu-ppc@nongnu.org
Cc: =?UTF-8?Q?Herv=C3=A9_Poussineau?= <hpoussin@reactos.org>,
 Artyom Tarasenko <atar4qemu@gmail.com>, Nicholas Piggin <npiggin@gmail.com>,
 Markus Armbruster <armbru@redhat.com>,
 Harsh Prateek Bora <harshpb@linux.ibm.com>
References: <cover.1761232472.git.balaton@eik.bme.hu>
 <3c4cb144c24a2a729669549c4c0e6e47d230e68e.1761232472.git.balaton@eik.bme.hu>
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
In-Reply-To: <3c4cb144c24a2a729669549c4c0e6e47d230e68e.1761232472.git.balaton@eik.bme.hu>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-SA-Exim-Connect-IP: 2a02:8012:2f01:0:521c:3ef:78b8:2419
X-SA-Exim-Mail-From: mark.cave-ayland@ilande.co.uk
Subject: Re: [PATCH v5 02/13] hw/pci-host/raven: Simplify PCI facing part
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

> The raven PCI device does not need a state struct as it has no data to
> store there any more, so we can remove that to simplify code.
> 
> Signed-off-by: BALATON Zoltan <balaton@eik.bme.hu>
> ---
>   hw/pci-host/raven.c | 19 -------------------
>   1 file changed, 19 deletions(-)
> 
> diff --git a/hw/pci-host/raven.c b/hw/pci-host/raven.c
> index c0492d1456..fa76e5170c 100644
> --- a/hw/pci-host/raven.c
> +++ b/hw/pci-host/raven.c
> @@ -31,7 +31,6 @@
>   #include "hw/pci/pci_bus.h"
>   #include "hw/pci/pci_host.h"
>   #include "hw/qdev-properties.h"
> -#include "migration/vmstate.h"
>   #include "hw/intc/i8259.h"
>   #include "hw/irq.h"
>   #include "hw/or-irq.h"
> @@ -40,12 +39,6 @@
>   #define TYPE_RAVEN_PCI_DEVICE "raven"
>   #define TYPE_RAVEN_PCI_HOST_BRIDGE "raven-pcihost"
>   
> -OBJECT_DECLARE_SIMPLE_TYPE(RavenPCIState, RAVEN_PCI_DEVICE)
> -
> -struct RavenPCIState {
> -    PCIDevice dev;
> -};
> -
>   typedef struct PRePPCIState PREPPCIState;
>   DECLARE_INSTANCE_CHECKER(PREPPCIState, RAVEN_PCI_HOST_BRIDGE,
>                            TYPE_RAVEN_PCI_HOST_BRIDGE)
> @@ -312,16 +305,6 @@ static void raven_realize(PCIDevice *d, Error **errp)
>       d->config[PCI_CAPABILITY_LIST] = 0x00;
>   }
>   
> -static const VMStateDescription vmstate_raven = {
> -    .name = "raven",
> -    .version_id = 0,
> -    .minimum_version_id = 0,
> -    .fields = (const VMStateField[]) {
> -        VMSTATE_PCI_DEVICE(dev, RavenPCIState),
> -        VMSTATE_END_OF_LIST()
> -    },
> -};
> -
>   static void raven_class_init(ObjectClass *klass, const void *data)
>   {
>       PCIDeviceClass *k = PCI_DEVICE_CLASS(klass);
> @@ -333,7 +316,6 @@ static void raven_class_init(ObjectClass *klass, const void *data)
>       k->revision = 0x00;
>       k->class_id = PCI_CLASS_BRIDGE_HOST;
>       dc->desc = "PReP Host Bridge - Motorola Raven";
> -    dc->vmsd = &vmstate_raven;
>       /*
>        * Reason: PCI-facing part of the host bridge, not usable without
>        * the host-facing part, which can't be device_add'ed, yet.
> @@ -344,7 +326,6 @@ static void raven_class_init(ObjectClass *klass, const void *data)
>   static const TypeInfo raven_info = {
>       .name = TYPE_RAVEN_PCI_DEVICE,
>       .parent = TYPE_PCI_DEVICE,
> -    .instance_size = sizeof(RavenPCIState),
>       .class_init = raven_class_init,
>       .interfaces = (const InterfaceInfo[]) {
>           { INTERFACE_CONVENTIONAL_PCI_DEVICE },

Reviewed-by: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>


ATB,

Mark.


