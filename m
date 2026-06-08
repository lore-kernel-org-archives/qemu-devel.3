Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5D31FCD8CA7
	for <qemu-devel@archiver.kernel.org>; Mon,  8 Jun 2026 21:30:00 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wWhX7-0003xH-1k; Mon, 08 Jun 2026 17:29:21 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mark.cave-ayland@ilande.co.uk>)
 id 1wWhX5-0003x5-Ri; Mon, 08 Jun 2026 17:29:19 -0400
Received: from mail.ilande.co.uk ([2001:41c9:1:41f::167])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mark.cave-ayland@ilande.co.uk>)
 id 1wWhX4-0006C9-7a; Mon, 08 Jun 2026 17:29:19 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=ilande.co.uk; s=20220518; h=Subject:Content-Transfer-Encoding:Content-Type:
 In-Reply-To:From:References:Cc:To:MIME-Version:Date:Message-ID:Sender:
 Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender
 :Resent-To:Resent-Cc:Resent-Message-ID;
 bh=XfU+tBGOxhN/VzYCnFsTWUk482L4U4Qtz8x8+n2cXnA=; b=uafrgGiruVccSmCr2rFKOHQC6x
 ah2FZxVbMBD9PwDnUHT1sbhiUKLxc4PvVhg2+IlHdm0tFCzFv/bbRzXYXVSXB3QFBnIyu+kTcgyPh
 wIBM0XHLjpXVXFm/a8AfLG6NazwYKU0e0z1nC3If5kx28n+hhIiFgqV+tQQuq9F/8ArttUO/IX8fr
 sl7VR62L88eyPgBzGo8UodrxYtdg9Q3JqQWxI3v1PhA9U7n6xjCgWjR2n1X1yaxCRqsAT5qVbwunl
 nGV9KUJCBlbxDBqq9XUPcEOVnKmp4FvXae9lr5p8Kf3L8oc5fT8t2V7WMtbrZq+1gF9lo/f++VAJR
 R8Wu+KULUFIoTHqoBfwCf2pIO/rqNl3LNp9PG3gJaakfMh2yhiiR3qr7OF8Mr09yl+GUm8EHMjz1S
 0o2AXfCdnkpc9ReNGa3K/mtHtSw0DRxZWpuLw+/ccL60c21qtf4OMM4AvnZnRdE4phOmPVO1Z/LSN
 wpddvNXFK14ZYEb4dqOSqFAMeJAE9yaVM/UI+NHG03gS7A7/e466W2uMOBzayELe5SgbanzpGMVT9
 n4QnmVglCzPY2rCpOSFK5Ej3sw3A+8S2ptRP4kGugrD2PgpLjHUBTmw3GLB+35RyydLDd7jq0NpQK
 ohAgz2qqW2ALf0hnHgEl5oHGlM2g+WtOawVzRCMZA=;
Received: from [2a02:8012:2f01:0:a345:6f5f:6224:aa51]
 by mail.ilande.co.uk with esmtpsa (TLS1.3:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.92) (envelope-from <mark.cave-ayland@ilande.co.uk>)
 id 1wWhTX-0004Us-R7; Mon, 08 Jun 2026 22:25:40 +0100
Message-ID: <fcbe3d7f-64d4-4b13-b930-a81e77db4784@ilande.co.uk>
Date: Mon, 8 Jun 2026 22:29:04 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: Michael Tokarev <mjt@tls.msk.ru>, Thomas Huth <thuth@redhat.com>,
 qemu-devel@nongnu.org
Cc: Artyom Tarasenko <atar4qemu@gmail.com>,
 QEMU Trivial <qemu-trivial@nongnu.org>
References: <20260309181452.83702-1-thuth@redhat.com>
 <00c4ab4b-a58b-4de4-8e41-566b2cb7f920@redhat.com>
 <124bd918-f2ab-43e2-bd2d-fc824de62c40@tls.msk.ru>
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
In-Reply-To: <124bd918-f2ab-43e2-bd2d-fc824de62c40@tls.msk.ru>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 2a02:8012:2f01:0:a345:6f5f:6224:aa51
X-SA-Exim-Mail-From: mark.cave-ayland@ilande.co.uk
Subject: Re: [PATCH v2] hw/sparc64/sun4u: Mark unusable PCI busses as full to
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

On 08/06/2026 09:26, Michael Tokarev wrote:

> On 30.04.2026 12:50, Thomas Huth wrote:
>> On 09/03/2026 19.14, Thomas Huth wrote:
>>> From: Thomas Huth <thuth@redhat.com>
>>>
>>> When trying to plug a PCI device to a Sparc64 machine, you currently
>>> have to specify the right bus ("bus=pciB"), otherwise you get this error:
>>>
>>>   $ qemu-system-sparc64 -device virtio-scsi-pci
>>>   qemu-system-sparc64: -device virtio-scsi-pci: PCI: no slot/function
>>>   available for virtio-scsi-pci, all in use or reserved
>>>
>>> This is quite annoying for the unexperienced users, and it also breaks
>>> e.g. the iotests ("make check-block") when running with qemu-system- sparc64.
>>>
>>> Mark the non-usable PCI busses as full now, so that QEMU can automatically
>>> plug new PCI devices to the right "pciB" bus.
>>>
>>> Signed-off-by: Thomas Huth <thuth@redhat.com>
>>> ---
>>>   v2: Do the change in the machine code, not in the sabre device
>>>
>>>   hw/sparc64/sun4u.c | 7 +++++++
>>>   1 file changed, 7 insertions(+)
>>>
>>> diff --git a/hw/sparc64/sun4u.c b/hw/sparc64/sun4u.c
>>> index b8bda1eb816..37539535c6c 100644
>>> --- a/hw/sparc64/sun4u.c
>>> +++ b/hw/sparc64/sun4u.c
>>> @@ -723,6 +723,13 @@ static void sun4uv_init(MemoryRegion *address_space_mem,
>>>       fw_cfg_add_i16(fw_cfg, FW_CFG_SPARC64_DEPTH, graphic_depth);
>>>       qemu_register_boot_set(fw_cfg_boot_set, fw_cfg);
>>> +
>>> +    /*
>>> +     * Mark internal PCI busses as full so that the plugging of additional
>>> +     * PCI devices happens on the right bus that still has free slots:
>>> +     */
>>> +    qbus_mark_full(&pci_bus->qbus);
>>> +    qbus_mark_full(&pci_busA->qbus);
>>>   }
>>>   enum {
>>
>> Friendly ping!
> 
> This, being a simple change, somehow has not been reviewed still, so
> it's sitting in the queue...

Yes, apologies - I've been absolutely flat out recently, and I've got a note to take 
a look at this and Peter's patch as soon as I can.

Is this fixing an urgent issue with "make check-block" or similar?


ATB,

Mark.


