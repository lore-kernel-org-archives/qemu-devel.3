Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B184AC43458
	for <qemu-devel@archiver.kernel.org>; Tue,  7 Jul 2026 22:23:47 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1whECV-0007CI-Ly; Tue, 07 Jul 2026 18:23:35 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mark.cave-ayland@ilande.co.uk>)
 id 1whECT-0007Bf-By; Tue, 07 Jul 2026 18:23:33 -0400
Received: from mail.ilande.co.uk ([2001:41c9:1:41f::167])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mark.cave-ayland@ilande.co.uk>)
 id 1whECR-0001CL-NV; Tue, 07 Jul 2026 18:23:33 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=ilande.co.uk; s=20220518; h=Subject:Content-Transfer-Encoding:Content-Type:
 In-Reply-To:From:References:Cc:To:MIME-Version:Date:Message-ID:Sender:
 Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender
 :Resent-To:Resent-Cc:Resent-Message-ID;
 bh=76Z81uhRLsrpjl8+/vnICIpAk5DzTqC8ctyUuSuZ1sE=; b=Y8telTnyeuJfTXLcCRKCouKdQY
 W/3l0CgqT+Ggm4ozvbejUi2+tkedVmD1CC+gWLpbLSRo1v7Oo61xfrGfWnIKB3hGIzVzbh/hcW5V3
 NGLSc+ePrJbEFrtXj8MRXh4EuR7434cn7VnDeiztA03jwZDB+2qZHPR4oNii126TLpmGQdhuJHXYP
 /QO/2soPVkn/7Y6gh/geO2/DDMOA7y31j+GaGDxDqP+voIP0kVAvFkirSQLfkUf4fikenLKw1Y07I
 fM593tQN0NKFY6iMaqAqPRC0SQzhmlp5oOc9gPKEQj18alnQEvtwS2i4nlW4v2yPgEA9sETTgcsWs
 pwYYW8Pqyq8fHmVmzTWqH7Zj8edMRRPU4uOkssj+Diq5B/5ENYvDcsocgMaAzqY2vFIjJGM46fzVg
 zTO6bSQtI3rGJHXx6GhrMXCGyRW4200wkKSsBS5ef5b9XkZ47YoyTsfHNeKgcTw3NuzTBRRt8fPbY
 Qzyiq+tD2JRttIoZuydwLek0mF9cLT/WgzmfATJhgRjUdnn4Lxr01Ys5MLb13l6qclgW8q4FwsIJl
 omHkiVyyOiNVeCSwdSAOnpoRURXGuzgPlCd1FRx1LuLEOWGuUs9wHhEjZHLqWvgaqbqV7poEVviHW
 WeCoUIjA+FwMSfDuow8qGXW3zUDteupKmEc9sT4xU=;
Received: from [2a02:8012:2f01:0:c7db:c036:80a0:714]
 by mail.ilande.co.uk with esmtpsa (TLS1.3) tls
 TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256 (Exim 4.94.2)
 (envelope-from <mark.cave-ayland@ilande.co.uk>)
 id 1whECG-001a7Z-RE; Tue, 07 Jul 2026 23:23:21 +0100
Message-ID: <4e74e45a-f152-4d89-bb22-1591f431daad@ilande.co.uk>
Date: Tue, 7 Jul 2026 23:23:23 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>,
 Thomas Huth <thuth@redhat.com>, qemu-devel@nongnu.org,
 Peter Maydell <peter.maydell@linaro.org>
Cc: Artyom Tarasenko <atar4qemu@gmail.com>,
 QEMU Trivial <qemu-trivial@nongnu.org>, Michael Tokarev <mjt@tls.msk.ru>
References: <20260309181452.83702-1-thuth@redhat.com>
 <00c4ab4b-a58b-4de4-8e41-566b2cb7f920@redhat.com>
 <124bd918-f2ab-43e2-bd2d-fc824de62c40@tls.msk.ru>
 <fcbe3d7f-64d4-4b13-b930-a81e77db4784@ilande.co.uk>
 <df7a091c-a8a1-416a-acf3-28a0cbd8dd2f@redhat.com>
 <c7d6b801-449e-4f55-9c1d-ebec7a0e9595@redhat.com>
 <c0cd50bd-e054-48b6-af54-1050e13bb720@ilande.co.uk>
 <baf0b727-d53c-4717-b4e8-9c8603b2fa75@oss.qualcomm.com>
 <a60309be-c514-4b22-8970-ecfcf2b4fde7@oss.qualcomm.com>
 <c7b0d42c-4243-4f52-88ec-7f1deac160fc@ilande.co.uk>
 <fdb45ef0-a709-413a-bc55-1bfcab648033@oss.qualcomm.com>
 <e89903bb-d866-45ed-b5f5-fa0a6ef1a0c7@oss.qualcomm.com>
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
In-Reply-To: <e89903bb-d866-45ed-b5f5-fa0a6ef1a0c7@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 2a02:8012:2f01:0:c7db:c036:80a0:714
X-SA-Exim-Mail-From: mark.cave-ayland@ilande.co.uk
Subject: Re: [PATCH v2] hw/sparc64/sun4u: Mark unusable PCI busses as full to
 ease device plugging
X-SA-Exim-Version: 4.2.1 (built Sat, 13 Feb 2021 17:57:42 +0000)
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

On 07/07/2026 09:42, Philippe Mathieu-Daudé wrote:

> On 6/7/26 23:19, Philippe Mathieu-DaudÃ© wrote:
>> On 6/7/26 23:16, Mark Cave-Ayland wrote:
>>> On 06/07/2026 21:29, Philippe Mathieu-Daudé wrote:
>>>
> 
>>>>> -    pci_bus = PCI_HOST_BRIDGE(sabre)->bus;
>>>>>       pci_busA = pci_bridge_get_sec_bus(sabre->bridgeA);
>>>>>       pci_busB = pci_bridge_get_sec_bus(sabre->bridgeB);
>>>>>
>>>>> -    /* Only in-built Simba APBs can exist on the root bus, slot 0 on busA is
>>>>> -       reserved (leaving no slots free after on-board devices) however slots
>>>>> -       0-3 are free on busB */
>>>>> -    pci_bus_set_slot_reserved_mask(pci_bus, 0xfffffffc);
>>>>> +    /*
>>>>> +     * Slot 0 on busA is reserved (leaving no slots free after on- board
>>>>> +     * devices) however slots 0-3 are free on busB
>>>>> +     */
>>>>>       pci_bus_set_slot_reserved_mask(pci_busA, 0xfffffff1);
>>>>>       pci_bus_set_slot_reserved_mask(pci_busB, 0xfffffff0);
>>>>>
>>>>> ---
>>>>>
>>>>> I'm still looking at the 2nd part, the reserved slots.
>>>>
>>>> (Because with this patch, the test passes as we can plug devices from
>>>> the command line, but they end plugged on pciA instead of pciB -- thus
>>>> the 2nd part missing).
>>>
>>> Thanks for taking a look, Phil. IIRC the reason I added slot_reserved_mask was so 
>>> that it was possible to populate pciA programatically in sun4uv_init(), and then 
>>> enable the mask so that specifying an additional PCI device using -device on the 
>>> command line without an explict PCI bus would cause the automatic allocation to 
>>> place the device on pciB.
>>
>> The slot_reserved_mask calls make sense, but AFAICT they don't work as
>> expected, since CLI devices are added on pciA. If you want to have a
>> look on top of this snippet, be my guest! Otherwise I'll continue
>> debugging that tomorrow, long day and late here :\
> 
> Generic PCI fix posted here:
> https://lore.kernel.org/qemu-devel/20260707084050.32137-1-philmd@oss.qualcomm.com/

Thanks Phil! I can confirm that this solves the issue for me.


ATB,

Mark.


