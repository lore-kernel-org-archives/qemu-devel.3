Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 52BDAD1CA07
	for <qemu-devel@archiver.kernel.org>; Mon,  4 Nov 2024 22:52:52 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t85vj-0000NZ-AB; Mon, 04 Nov 2024 17:52:15 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mark.cave-ayland@ilande.co.uk>)
 id 1t85vg-0000N6-Jo
 for qemu-devel@nongnu.org; Mon, 04 Nov 2024 17:52:12 -0500
Received: from mail.ilande.co.uk ([2001:41c9:1:41f::167])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mark.cave-ayland@ilande.co.uk>)
 id 1t85ve-0006zn-S8
 for qemu-devel@nongnu.org; Mon, 04 Nov 2024 17:52:12 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=ilande.co.uk; s=20220518; h=Subject:Content-Transfer-Encoding:Content-Type:
 In-Reply-To:From:References:To:MIME-Version:Date:Message-ID:Sender:Reply-To:
 Cc:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID;
 bh=qD84fLYq35QmJ+D+jLVLCabuRRjre3myGT2YyxrZ1ww=; b=WcIFE1H1HsILpONilR9wD8NNXV
 YqlvTJsjZOy3R5ta2edy8vXFLak1TrtTaycEPKlay4mUbLAR09y58TTja2gtzAOThe7+cfdogpC+h
 zqk6Qijwe+34bDoZRpORWKmoRU1b7GVXmDXL6YXzUusYiagxP1vx9NtDWVvj6sbNYHjkwzlrkR/GO
 PFh+k3GJwOSdPunJ8SiMZy5yS2Q4rtklFtOt7NuRni4wLY/WILzpGJMjvbApBk+2ZvC8uNO3DtXgk
 gqBuQhCVXhW1A908pAS0BP1YUACm9pyIrz4w4cHCQOBpu9v01TNrGByxrk/cr8F2fKdeaWPIAKv8O
 QsuloyBfUg8I1CYAElSpETr0H2MPpYldZOiRfWdVrQO6zHS7Os8pIl7ZIF8nyLE0YvxTmM1PlPxqL
 Q+Ioun56UCfS+AhZoOtcedb3cFoZjWd1nHQ2RpmceBKOdSkSPBxky73t9gR73bkAOmymjWYz5uSyM
 qknvptPypSZT4L/XL7THGaZ5d0S7w7wqyNFwFZk2wfUeN+fcXbCOonqDHlt+TOQG72A2hN0w+fVU/
 HnE043RbqeeluwvLnSYvzs+I43Onsc4bZyZt/3JEj0hjnCJ6bDlP/h9mOzPclVgt0l5dZfhWRxnC1
 oo0FdNbT0y70A2bdY4ZYDZoXwwyZYI/x2dquRLoAs=;
Received: from [2a00:23c4:8bb8:f600:b478:1422:fb0f:30d5]
 by mail.ilande.co.uk with esmtpsa (TLS1.3:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.92) (envelope-from <mark.cave-ayland@ilande.co.uk>)
 id 1t85v6-00044V-EY; Mon, 04 Nov 2024 22:51:48 +0000
Message-ID: <c186391e-ed40-4058-ba6a-22e69f123b8f@ilande.co.uk>
Date: Mon, 4 Nov 2024 22:51:53 +0000
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>,
 peter.maydell@linaro.org, huth@tuxfamily.org, qemu-devel@nongnu.org
References: <20241101201106.1432336-1-mark.cave-ayland@ilande.co.uk>
 <20241101201106.1432336-2-mark.cave-ayland@ilande.co.uk>
 <ZyicQT4eKlN07AHz@redhat.com> <ZyizniWmccEjAQBq@redhat.com>
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
In-Reply-To: <ZyizniWmccEjAQBq@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 2a00:23c4:8bb8:f600:b478:1422:fb0f:30d5
X-SA-Exim-Mail-From: mark.cave-ayland@ilande.co.uk
Subject: Re: [PATCH v3 1/2] next-kbd: convert to use
 qemu_input_handler_register()
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

On 04/11/2024 11:44, Daniel P. Berrangé wrote:

> On Mon, Nov 04, 2024 at 10:04:49AM +0000, Daniel P. Berrangé wrote:
>> On Fri, Nov 01, 2024 at 08:11:05PM +0000, Mark Cave-Ayland wrote:
>>> Convert the next-kbd device from the legacy UI qemu_add_kbd_event_handler()
>>> function to use qemu_input_handler_register().
>>>
>>> Signed-off-by: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
>>> ---
>>>   hw/m68k/next-kbd.c | 166 ++++++++++++++++++++++++++++++---------------
>>>   1 file changed, 111 insertions(+), 55 deletions(-)
>>>
>>> diff --git a/hw/m68k/next-kbd.c b/hw/m68k/next-kbd.c
>>> index bc67810f31..283e98e9eb 100644
>>> --- a/hw/m68k/next-kbd.c
>>> +++ b/hw/m68k/next-kbd.c
>   
>> Finding a reliable reference for the NeXT scancodes is very hard
>> in my googling so far. The best I've come across so far is
>>
>> https://github.com/spenczar/usb-next/blob/main/keymap.h
>>
>> who has defined a mapping to USB HID codes, which seems to
>> broadly match what's above here, plus has many of the gaps
>> fixed.
>>
>> Do you know of any other decent references for scancodes ?
>>
>> I'm going to see about adding NeXT scancodes to the giant
>> database of keycodes at:
>>
>>    https://gitlab.com/keycodemap/keycodemapdb
>>
>> then we can auto-generate this table as we do for most of
>> the other QEMU keyboard drivers.
> 
> FYI, I've opened this:
> 
> https://gitlab.com/keycodemap/keycodemapdb/-/merge_requests/21
> 
> if someone wants to sanity-check it, please comment there. Otherwise I'll
> merge it after a short while if no one points out mistakes.

Nice!

> To use this from QEMU we would need:
> 
>   * update ui/keycodemapdb submodule hash to point to the above (once
>     merged)
>   * update ui/meson.build  'keymaps' list to add ['qcode', 'next'] to
>     the generated map list
>   * import the new generated "ui/input-keymap-qcode-to-next.c.inc" from
>     next-kbd.c

What would you recommend would be the best way forward for 9.2? To issue a v4 with 
just the erroneous 0x00 values removed, or to try and use keycodemapdb?


ATB,

Mark.


