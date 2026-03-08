Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 857E4EA8549
	for <qemu-devel@archiver.kernel.org>; Sun,  8 Mar 2026 23:07:27 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vzNCs-00075J-2Q; Sun, 08 Mar 2026 19:06:42 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mark.cave-ayland@ilande.co.uk>)
 id 1vzNCr-000757-BW
 for qemu-devel@nongnu.org; Sun, 08 Mar 2026 19:06:41 -0400
Received: from mail.ilande.co.uk ([2001:41c9:1:41f::167])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mark.cave-ayland@ilande.co.uk>)
 id 1vzNCp-00086S-KF
 for qemu-devel@nongnu.org; Sun, 08 Mar 2026 19:06:41 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=ilande.co.uk; s=20220518; h=Subject:Content-Transfer-Encoding:Content-Type:
 In-Reply-To:From:References:To:MIME-Version:Date:Message-ID:Sender:Reply-To:
 Cc:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID;
 bh=hU+Cy+ZOmhnX74B/J0TaXJ7GVGAmh/MTt+tR3EKJcVI=; b=IZMOFa9kpu0qs5dRbhqKxWJm9J
 ZhcXTpjkkWD/utFghHY/QZvzeUcqGfjwFNYST/pXwzSGBtX4873n1qAiDEQtF/9K3G7nGie3/3VbF
 UCY7D8TMgO52MAf++ugg2Y1VTpwWE0ew3F4feb6QR3IFxXwK8VdylvS0DZav0ZTFvo32kEnmnd+w0
 lmuIVxnHRpc7ZyRFVo8VCZY1GpR/m9MNxlW8CfJF74JVeK8qG3nls94X+tnESFR/HMNPyNkAt1ePq
 ta5PtD0CnyLPnJg+Nexnf9N/BhclSOL4bcey4wuCiHez0XoejX7OVPVhQRp+B6FUs0uVxFEZ/6O3W
 1KIw8o7hzo2aeC7XrTXNSQt4vNp3erpkJDaiKuwuizTsoOvVq9Hh98wH47MddsHSQrd+aZG+z+g+K
 mv3Uy9NzujO3is8MSOSpZHziNQ+JQcEE3yxQZFkwk7bCzja6vfh2vJJbccZbTchgJuzaDsg7watAt
 rELGWQ7iUe60Cp3ZhgTuK9Dug0z7qodFUJSTNOd2rHgw+1t2Lw3Ik6Zj2euTbWpxXvt08BDnMzIJp
 D3+cUe6W4iu5yGV44TLrBAfCX5GHyvJMrRYLxa9ANBlJ38VCtoHounH4gVvT61hTU22CvqBpj0RMf
 GboNUnUWjIDfYIcRHW1HOWhojhUnh8nbARmDVa+ZY=;
Received: from [2a02:8012:2f01:0:853d:6c6b:2689:bc0e]
 by mail.ilande.co.uk with esmtpsa (TLS1.3:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.92) (envelope-from <mark.cave-ayland@ilande.co.uk>)
 id 1vzN9t-0004kw-2L; Sun, 08 Mar 2026 23:03:37 +0000
Message-ID: <7ac11fc9-a672-45b9-a0b9-c95b8bc65cc8@ilande.co.uk>
Date: Sun, 8 Mar 2026 23:06:32 +0000
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: Thomas Huth <thuth@redhat.com>, qemu-devel@nongnu.org
References: <20260216154901.602613-1-thuth@redhat.com>
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
In-Reply-To: <20260216154901.602613-1-thuth@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-SA-Exim-Connect-IP: 2a02:8012:2f01:0:853d:6c6b:2689:bc0e
X-SA-Exim-Mail-From: mark.cave-ayland@ilande.co.uk
Subject: Re: [PATCH] hw/pci-host/sabre: Mark unusable PCI busses as full to
 ease device plugging
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
List-Id: qemu development <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

On 16/02/2026 15:49, Thomas Huth wrote:

> From: Thomas Huth <thuth@redhat.com>
> 
> When trying to plug a PCI device to a Sparc64 machine, you currently
> have to specify the right bus ("bus=pciB"), otherwise you get this error:
> 
>   $ qemu-system-sparc64 -device virtio-scsi-pci
>   qemu-system-sparc64: -device virtio-scsi-pci: PCI: no slot/function
>    available for virtio-scsi-pci, all in use or reserved
> 
> This is quite annoying for the unexperienced users, and it also breaks
> e.g. the iotests ("make check-block") when running with qemu-system-sparc64.
> 
> Mark the non-usable PCI busses as full now, so that QEMU can automatically
> plug new PCI devices to the right "pciB" bus.
> 
> Signed-off-by: Thomas Huth <thuth@redhat.com>
> ---
>   Note: Only lightly tested, it seems to work fine for me at a first glance,
>   but maybe I missed something...
> 
>   hw/pci-host/sabre.c | 2 ++
>   1 file changed, 2 insertions(+)
> 
> diff --git a/hw/pci-host/sabre.c b/hw/pci-host/sabre.c
> index cd2328ad53f..9c8519f3849 100644
> --- a/hw/pci-host/sabre.c
> +++ b/hw/pci-host/sabre.c
> @@ -382,6 +382,7 @@ static void sabre_realize(DeviceState *dev, Error **errp)
>                                        &s->pci_mmio,
>                                        &s->pci_ioport,
>                                        0, 0x40, TYPE_PCI_BUS);
> +    qbus_mark_full(&phb->bus->qbus);
>   
>       pci_create_simple(phb->bus, 0, TYPE_SABRE_PCI_DEVICE);
>   
> @@ -400,6 +401,7 @@ static void sabre_realize(DeviceState *dev, Error **errp)
>       s->bridgeA = PCI_BRIDGE(pci_dev);
>       pci_bridge_map_irq(s->bridgeA, "pciA", pci_simbaA_map_irq);
>       pci_realize_and_unref(pci_dev, phb->bus, &error_fatal);
> +    qbus_mark_full(&s->bridgeA->sec_bus.qbus);
>   }
>   
>   static void sabre_init(Object *obj)

Apologies for the delay on this: I think the patch makes logical sense, however the 
existing logic to manage the available PCI slots is handled in sun4uv_init(). Do you 
think it makes sense to move the qbus_mark_full() calls to the same place?


ATB,

Mark.


