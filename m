Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 70B7CC25B78
	for <qemu-devel@archiver.kernel.org>; Tue, 28 May 2024 21:41:55 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sC4ZA-0002ah-Is; Tue, 28 May 2024 17:41:08 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mark.cave-ayland@ilande.co.uk>)
 id 1sC4Z7-0002Z6-HH; Tue, 28 May 2024 17:41:05 -0400
Received: from mail.ilande.co.uk ([2001:41c9:1:41f::167])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mark.cave-ayland@ilande.co.uk>)
 id 1sC4Z1-0004e6-Ua; Tue, 28 May 2024 17:41:05 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=ilande.co.uk; s=20220518; h=Subject:Content-Transfer-Encoding:Content-Type:
 In-Reply-To:From:References:Cc:To:MIME-Version:Date:Message-ID:Sender:
 Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender
 :Resent-To:Resent-Cc:Resent-Message-ID;
 bh=su9804s1CmgfrqGS+sPnXmO8RKsK7NVunbL4EELLd18=; b=zY+4DHnP+jprS5sVB7EdCrLOO+
 JrHjK1P5TdVOnqVhgJjCPzO/ObUvwq2aJ70Ec9B7HQXeBnFmfYvAM6JTnr/YIrCMqVTM5tlZOREJF
 BFcwFRBvh+Fv0QFmkC/RVOcIh249q1dv2894b9oZ/AwIumCiadG1dXsYx0oxQG033UroGhCwWVCdJ
 vU3kiWuyxFkDqsaPAIk+PK9moj4cB/awEjW9lDuN3nxvU5qL5nzYRrzFoBKgJJnE7ekkGYXLmc8NE
 PcvbZ+Vkc1UWeDwXwVPZCPMn9GPHOQvY0pgtUfezSxpZG/OrXl+mOmBUvg9+qanXMfxS1bZqOH0DC
 gFOInzlCS+OJpVpsNAmeK+lFRN6cL5dhGVcd9xbqd10bi9gGbZiaCHP9cMuDNfpydIp7Noj/r98fC
 Mb7RaJIheIARFQliiyVWonUwJI3lVVWlpp2GnqeiIMqHr6hc5cwLOWJVT7Rtau+DMFUzHnu8BrXZ8
 RhKI4dOY4uLyz/dDIEUhoWYWjGFTntOjJQ1ii1eNyTkPyVy/85YXVAt+1DJPayHz2pVCarCYLyi/O
 jbvnu7l6SbjeeCjnBQr0mk1hdsnkULuHW2RTrRT77Wfya0XSpyB6MVNdwETKECMjT7YjSjYWBNvAH
 GkfOZLKhq53pWPs+0ck6vL0bz8jeXH3Ljc6W7Lddw=;
Received: from [2a00:23c4:8bb4:4000:7888:3a1b:7ac1:9da2]
 by mail.ilande.co.uk with esmtpsa (TLS1.3:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.92) (envelope-from <mark.cave-ayland@ilande.co.uk>)
 id 1sC4Xk-0001js-3W; Tue, 28 May 2024 22:39:40 +0100
Message-ID: <f8337cd4-ecc1-4483-a2e7-4dc0ec7b65ca@ilande.co.uk>
Date: Tue, 28 May 2024 22:40:51 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: Thomas Huth <thuth@redhat.com>, Gerd Hoffmann <kraxel@redhat.com>,
 qemu-devel@nongnu.org
Cc: Markus Armbruster <armbru@redhat.com>, Paolo Bonzini
 <pbonzini@redhat.com>, Eric Blake <eblake@redhat.com>,
 Eduardo Habkost <eduardo@habkost.net>,
 =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <f4bug@amsat.org>,
 "qemu-ppc@nongnu.org" <qemu-ppc@nongnu.org>,
 Nicholas Piggin <npiggin@gmail.com>, Helge Deller <deller@gmx.de>,
 Huacai Chen <chenhuacai@kernel.org>, Jiaxun Yang <jiaxun.yang@flygoat.com>
References: <20240528095459.896594-1-kraxel@redhat.com>
 <20240528095459.896594-4-kraxel@redhat.com>
 <8fa84896-f534-4d2e-8b00-057514a7de03@redhat.com>
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
In-Reply-To: <8fa84896-f534-4d2e-8b00-057514a7de03@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 2a00:23c4:8bb4:4000:7888:3a1b:7ac1:9da2
X-SA-Exim-Mail-From: mark.cave-ayland@ilande.co.uk
Subject: Re: [PATCH 3/4] usb/ohci-pci: deprecate, don't build by default
X-SA-Exim-Version: 4.2.1 (built Wed, 08 May 2019 21:11:16 +0000)
X-SA-Exim-Scanned: Yes (on mail.ilande.co.uk)
Received-SPF: pass client-ip=2001:41c9:1:41f::167;
 envelope-from=mark.cave-ayland@ilande.co.uk; helo=mail.ilande.co.uk
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001, T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

On 28/05/2024 11:35, Thomas Huth wrote:

> On 28/05/2024 11.54, Gerd Hoffmann wrote:
>> The xhci host adapter is the much better choice.
>>
>> Signed-off-by: Gerd Hoffmann <kraxel@redhat.com>
>> ---
>>   hw/usb/hcd-ohci-pci.c | 1 +
>>   hw/usb/Kconfig        | 1 -
>>   2 files changed, 1 insertion(+), 1 deletion(-)
>>
>> diff --git a/hw/usb/hcd-ohci-pci.c b/hw/usb/hcd-ohci-pci.c
>> index 33ed9b6f5a52..88de657def71 100644
>> --- a/hw/usb/hcd-ohci-pci.c
>> +++ b/hw/usb/hcd-ohci-pci.c
>> @@ -143,6 +143,7 @@ static void ohci_pci_class_init(ObjectClass *klass, void *data)
>>       dc->hotpluggable = false;
>>       dc->vmsd = &vmstate_ohci;
>>       dc->reset = usb_ohci_reset_pci;
>> +    klass->deprecation_note = "use qemu-xhci instead";
>>   }
>>   static const TypeInfo ohci_pci_info = {
>> diff --git a/hw/usb/Kconfig b/hw/usb/Kconfig
>> index 84bc7fbe36cd..c4a6ea5a687f 100644
>> --- a/hw/usb/Kconfig
>> +++ b/hw/usb/Kconfig
>> @@ -17,7 +17,6 @@ config USB_OHCI_SYSBUS
>>   config USB_OHCI_PCI
>>       bool
>> -    default y if PCI_DEVICES
>>       depends on PCI
>>       select USB_OHCI
> 
> Not sure whether we should disable it by default just because it is deprecated. We 
> don't do that for any other devices as far as I know.
> 
> Anyway, you should add the device to docs/about/deprecated.rst to really mark it as 
> deprecated, since that's our official list (AFAIK).
> 
> Also, there are still some machines that use this device:
> 
> $ grep -r USB_OHCI_PCI *
> hw/hppa/Kconfig:    imply USB_OHCI_PCI
> hw/mips/Kconfig:    imply USB_OHCI_PCI
> hw/ppc/Kconfig:    imply USB_OHCI_PCI
> hw/ppc/Kconfig:    imply USB_OHCI_PCI
> 
> pseries could certainly continue without OHCI AFAICT, but the others? Maybe this 
> needs some discussion first... (thus putting some more people on CC:)
> 
>   Thomas

The mac99 machine has an in-built OHCI PCI interface so I don't think this device 
should be marked as deprecated. Normally in these cases isn't it just a matter of 
updating documentation to recommend XHCI over OHCI for particular uses?


ATB,

Mark.


