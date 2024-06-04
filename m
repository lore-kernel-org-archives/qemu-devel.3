Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 912A0C25B7E
	for <qemu-devel@archiver.kernel.org>; Tue,  4 Jun 2024 06:51:54 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sEO0Z-00079w-Vx; Tue, 04 Jun 2024 02:51:01 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mark.cave-ayland@ilande.co.uk>)
 id 1sEO0M-00072K-Li
 for qemu-devel@nongnu.org; Tue, 04 Jun 2024 02:50:48 -0400
Received: from mail.ilande.co.uk ([2001:41c9:1:41f::167])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mark.cave-ayland@ilande.co.uk>)
 id 1sEO0K-0000by-My
 for qemu-devel@nongnu.org; Tue, 04 Jun 2024 02:50:46 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=ilande.co.uk; s=20220518; h=Subject:Content-Transfer-Encoding:Content-Type:
 In-Reply-To:From:References:Cc:To:MIME-Version:Date:Message-ID:Sender:
 Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender
 :Resent-To:Resent-Cc:Resent-Message-ID;
 bh=yuBtWfTkrnTAZrU7XfC2/Et6fnWohchYjwJ9hrsrIig=; b=OIHDbB3uEzSnU+C+HMYwMp7g0I
 sy8y7NGR+gUlkaO5GSAB9Iy5h43qK8eTI9MFy+uvof8Ng9U+F+wmqNanAfq42DyL56Hm0dhpk5KVV
 qLtQfByiKfcLGXnYVlDsPRK5EdkM2Hu7I9PFh21BUVwSsX85sdDJEQR/idQrKWYteJl+RD3QajUof
 Rmd1ZdNtYRkwCf27SrHfKWW6VVq524i0k772tf3Cym5SYNDk4JJnNxlAG1iPn4SuII/xEt1p9eEGn
 GBruN61OVuNSsMOJ3LaDT4X6QYVCmihOZghy/J9tICBBCTpFvqatZzqJZxHtHjIiluVUqD/cH6L0I
 VK04kqkC+Gt3lVMk1978VD6erVJYnltklpF6IIhwbiQIAEcLxHMP2K46u+Cg7VnIXbxNfwn8VdokZ
 8Iw67cYjJl4+Mva+p3eiwVD17xJEj6CWSb+f963e+fDxCTBDEJMjBQ8sOCq8pgj1ZXU0TDGHsujNx
 hSRblVe4P9mwTaAglh/vRpQYhqkZR+AuLmVKTcc+bmZtXNQbb6MskhrPERYLpIZMPwH9ascVwd2K0
 xIqKi5MPST0DRr4cpRcXQHIFEIvahzMXZR0uR0R3tdNCQbH2qh9YpX3EhOqZCphqUEfTMRUt+oytq
 LtNqj4TrhkH/iNpkhm0iWjxKcMHEjbH1C91XwJtno=;
Received: from [2a00:23c4:8bb4:4000:ce26:7186:74ad:2d8c]
 by mail.ilande.co.uk with esmtpsa (TLS1.3:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.92) (envelope-from <mark.cave-ayland@ilande.co.uk>)
 id 1sENz2-00078t-W7; Tue, 04 Jun 2024 07:49:25 +0100
Message-ID: <b3a2ae5f-a6d1-4d13-a7e3-35f4b1417b88@ilande.co.uk>
Date: Tue, 4 Jun 2024 07:50:38 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>
Cc: BALATON Zoltan <balaton@eik.bme.hu>, Gerd Hoffmann <kraxel@redhat.com>,
 qemu-devel@nongnu.org, Eduardo Habkost <eduardo@habkost.net>,
 Eric Blake <eblake@redhat.com>, Markus Armbruster <armbru@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>
References: <20240530112718.1752905-1-kraxel@redhat.com>
 <20240530112718.1752905-5-kraxel@redhat.com>
 <3efcf132-dec1-3765-e77e-3fd207224eeb@eik.bme.hu>
 <c928e9e7-21b2-4017-be45-b0a4b91f1d06@ilande.co.uk>
 <Zl2rxIYdohROHXbg@redhat.com>
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
In-Reply-To: <Zl2rxIYdohROHXbg@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 2a00:23c4:8bb4:4000:ce26:7186:74ad:2d8c
X-SA-Exim-Mail-From: mark.cave-ayland@ilande.co.uk
Subject: Re: [PATCH v2 4/4] vga/cirrus: deprecate, don't build by default
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

On 03/06/2024 12:40, Daniel P. Berrangé wrote:

> On Thu, May 30, 2024 at 01:22:11PM +0100, Mark Cave-Ayland wrote:
>> On 30/05/2024 12:40, BALATON Zoltan wrote:
>>
>>> On Thu, 30 May 2024, Gerd Hoffmann wrote:
>>>> stdvga is the much better option.
>>>>
>>>> Signed-off-by: Gerd Hoffmann <kraxel@redhat.com>
>>>> ---
>>>> hw/display/cirrus_vga.c     | 1 +
>>>> hw/display/cirrus_vga_isa.c | 1 +
>>>> hw/display/Kconfig          | 1 -
>>>> 3 files changed, 2 insertions(+), 1 deletion(-)
>>>>
>>>> diff --git a/hw/display/cirrus_vga.c b/hw/display/cirrus_vga.c
>>>> index 150883a97166..81421be1f89d 100644
>>>> --- a/hw/display/cirrus_vga.c
>>>> +++ b/hw/display/cirrus_vga.c
>>>> @@ -3007,6 +3007,7 @@ static void cirrus_vga_class_init(ObjectClass
>>>> *klass, void *data)
>>>>      dc->vmsd = &vmstate_pci_cirrus_vga;
>>>>      device_class_set_props(dc, pci_vga_cirrus_properties);
>>>>      dc->hotpluggable = false;
>>>> +    klass->deprecation_note = "use stdvga instead";
>>>> }
>>>>
>>>> static const TypeInfo cirrus_vga_info = {
>>>> diff --git a/hw/display/cirrus_vga_isa.c b/hw/display/cirrus_vga_isa.c
>>>> index 84be51670ed8..3abbf4dddd90 100644
>>>> --- a/hw/display/cirrus_vga_isa.c
>>>> +++ b/hw/display/cirrus_vga_isa.c
>>>> @@ -85,6 +85,7 @@ static void isa_cirrus_vga_class_init(ObjectClass
>>>> *klass, void *data)
>>>>      dc->realize = isa_cirrus_vga_realizefn;
>>>>      device_class_set_props(dc, isa_cirrus_vga_properties);
>>>>      set_bit(DEVICE_CATEGORY_DISPLAY, dc->categories);
>>>> +    klass->deprecation_note = "use stdvga instead";
>>>
>>> Excepr some old OSes work better with this than stdvga so could this be
>>> left and not removed? Does it cause a lot of work to keep this device? I
>>> thought it's stable already and were not many changes for it lately. If
>>> something works why drop it?
>>
>> Seconded: whilst stdvga is preferred, there are a lot of older OSs that work
>> well in QEMU using the Cirrus emulation. I appreciate that the code could do
>> with a bit of work, but is there a more specific reason that it should be
>> deprecated?
> 
> I think there's different answers here for upstream vs downstream.
> 
> Upstream QEMU's scope is to emulate pretty much arbitrary hardware that
> may have existed at any point in time. Emulating Cirrus is very much
> in scope upstream, and even if there are other better VGA devices, that
> doesn't make emulation of Cirrus redundant.
> 
> Downstream is a different matter - if a downstream vendor wants to be
> opinionated and limit the scope of devices they ship to customers, it
> is totally valid to cull Cirrus.

The concern for me is that if someone such as RedHat decided not to ship Cirrus then 
we'd end up in a place where command lines for some legacy OSs would work on an 
upstream build, but if someone was using RHEL then they would fail due to the device 
not being present. I can see this causing confusion for users since they would report 
that a command line doesn't work whilst others would shrug and report back that it 
works for them.

I do wonder if a solution for this would be to add a blocklist file in /etc that 
prevents the listed QOM types from being instantiated. The file could contain also 
contain a machine regex to match and a reason that can be reported to the user e.g.

# QEMU QOM type blocklist
#
# QOM type regex, machine regex list, reason
"cirrus*","pc*,machine*","contains insecure blitter routines"
"fdc","pc*","may not be completely secure"

This feels like a better solution because:

- It's easy to add a message that reports "The requested QOM type <foo> cannot be 
instantiated because <reason>" for specific machine types. The machine regex also 
fixes the problem where usb-ohci should be allowed for PPC machines, but not 
generally for PC machines.

- Downstream can ship with a secure policy for production environments but also a 
less restrictive policy for more casual users

- If someone really needs a device that is not enabled by default, a privileged user 
can simply edit the blocklist file and allow it

- It should work both with or without modules


ATB,

Mark.


