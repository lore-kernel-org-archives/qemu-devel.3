Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 92505D5C0C1
	for <qemu-devel@archiver.kernel.org>; Fri,  8 Nov 2024 12:27:41 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t9O4a-0007Fc-7W; Fri, 08 Nov 2024 07:26:44 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mark.cave-ayland@ilande.co.uk>)
 id 1t9O4Y-0007FS-Qy
 for qemu-devel@nongnu.org; Fri, 08 Nov 2024 07:26:42 -0500
Received: from mail.ilande.co.uk ([2001:41c9:1:41f::167])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mark.cave-ayland@ilande.co.uk>)
 id 1t9O4W-0001Kf-Tb
 for qemu-devel@nongnu.org; Fri, 08 Nov 2024 07:26:42 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=ilande.co.uk; s=20220518; h=Subject:Content-Transfer-Encoding:Content-Type:
 In-Reply-To:From:References:Cc:To:MIME-Version:Date:Message-ID:Sender:
 Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender
 :Resent-To:Resent-Cc:Resent-Message-ID;
 bh=sCnW4EKzpGd9/1Me0M262YXbZaoRSEOO0nYKARZUdXQ=; b=ufQxor2zPpVmxzb8D6C6jxvgWY
 zmSdSKLYx8dAwF33EjspKsibUXnAxqRjIWIaE4hBka4E43i36WhWpBLnGIJkPCxkjZARrXBMStr4H
 o9vvckS4yG3QXlVtVtXRV4TRjDw8hmYNVSapJ+V8wt3LahBrF4i5vOd7nRZjYcd7mQDJ24okkJaGn
 D0+vC7Ge+KwfpAn6V9cIxihnS7fHGy79oSb19bGvwj/TkMuIng3gLmt2q2ZeiYe/gu1OAK3oww78n
 iDnOeXmp7F/QuyFeqdkQ+m9JwuvyGGc0T5YGkRYKZrEQ3bJiZCfzQwAWnWeHPy+1dKff3eEZCtMUH
 VGiXYehVNyNrLZaCWIZacqXvCGIf2fDYIMpGDZLDCFFOzEMXGTdDzmaGVONRNYgRydLMVYbRtZkF4
 WsTMVt/x+AgvV62+38fGUWA2OysZDJrUAUY5AYBPLiUFJGfQc/arYjFqWZdR39oVkvmzesSRAT8B/
 mLiFI6k1/lVKaiihuzdydRTb9lTMjvEgKQsLi5V/z8Jeff9tiJ5Ikk0IyfYFWRvmmGNXRRWiyxPiF
 WFFQ2DCXbyjal7Ct3P+VNxli6S5ABQSETz3kKPtUGF+cgEFlMuATH0D6UTwT75C49yPOXYgnQcRu5
 UGd+YBSOOMGVtsuRHmZedI43Ng7RRapZkrExzjQms=;
Received: from [2a00:23c4:8bb8:f600:d2e5:4749:372d:7d6a]
 by mail.ilande.co.uk with esmtpsa (TLS1.3:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.92) (envelope-from <mark.cave-ayland@ilande.co.uk>)
 id 1t9O3s-00069E-Sw; Fri, 08 Nov 2024 12:26:05 +0000
Message-ID: <3563eeab-b342-48bd-8138-21ed08294a69@ilande.co.uk>
Date: Fri, 8 Nov 2024 12:26:18 +0000
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: Thomas Huth <th.huth@posteo.de>, BALATON Zoltan <balaton@eik.bme.hu>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Cc: peter.maydell@linaro.org, huth@tuxfamily.org, berrange@redhat.com,
 qemu-devel@nongnu.org
References: <20241106120928.242443-1-mark.cave-ayland@ilande.co.uk>
 <20241106120928.242443-2-mark.cave-ayland@ilande.co.uk>
 <4c127d3c-3610-e6b7-9358-3d88d28477a0@eik.bme.hu>
 <13995544-2d94-4b35-a7c2-f11e0599170f@linaro.org>
 <872fd077-b870-f910-88a5-a045787aa681@eik.bme.hu>
 <c3b996b4-d128-4830-94d4-5c9448ca003d@posteo.de>
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
In-Reply-To: <c3b996b4-d128-4830-94d4-5c9448ca003d@posteo.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 2a00:23c4:8bb8:f600:d2e5:4749:372d:7d6a
X-SA-Exim-Mail-From: mark.cave-ayland@ilande.co.uk
Subject: Re: [PATCH v4 1/2] next-kbd: convert to use
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

On 08/11/2024 10:05, Thomas Huth wrote:

> On 06/11/2024 21.32, BALATON Zoltan wrote:
>> On Wed, 6 Nov 2024, Philippe Mathieu-Daudé wrote:
>>> On 6/11/24 13:00, BALATON Zoltan wrote:
>>>> On Wed, 6 Nov 2024, Mark Cave-Ayland wrote:
>>>>> Convert the next-kbd device from the legacy UI qemu_add_kbd_event_handler()
>>>>> function to use qemu_input_handler_register().
>>>>>
>>>>> Signed-off-by: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
>>>>> Reviewed-by: Thomas Huth <huth@tuxfamily.org>
>>>>> ---
>>>>> hw/m68k/next-kbd.c | 163 ++++++++++++++++++++++++++++++---------------
>>>>> 1 file changed, 108 insertions(+), 55 deletions(-)
>>>
>>>
>>>>> -static const unsigned char next_keycodes[128] = {
>>>>> -    0x00, 0x49, 0x4A, 0x4B, 0x4C, 0x4D, 0x50, 0x4F,
>>>>> -    0x4E, 0x1E, 0x1F, 0x20, 0x1D, 0x1C, 0x1B, 0x00,
>>>>> -    0x42, 0x43, 0x44, 0x45, 0x48, 0x47, 0x46, 0x06,
>>>>> -    0x07, 0x08, 0x00, 0x00, 0x2A, 0x00, 0x39, 0x3A,
>>>>> -    0x3B, 0x3C, 0x3D, 0x40, 0x3F, 0x3E, 0x2D, 0x2C,
>>>>> -    0x2B, 0x26, 0x00, 0x00, 0x31, 0x32, 0x33, 0x34,
>>>>> -    0x35, 0x37, 0x36, 0x2e, 0x2f, 0x30, 0x00, 0x00,
>>>>> -    0x00, 0x38, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,
>>>>> -    0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
>>>>> -    0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
>>>>> -    0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
>>>>> -    0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0
>>>>> +#define NEXTKBD_NO_KEY 0xff
>>>>
>>>> Now you don't need this 0xff define any more because you can use 0 as no key 
>>>> value then the [0 ... Q_KEY_CODE__MAX] init below can also be dropped because 
>>>> static variables are 0 init automatically.
>>>
>>> Whether 0 or 0xff is best for NO_KEY, I don't know.
>>> However, definitions are useful when reviewing ...
>>>
>>>>
>>>> Regards,
>>>> BALATON Zoltan
>>>>
>>>>> +static const int qcode_to_nextkbd_keycode[] = {
>>>>> +    /* Make sure future additions are automatically set to NEXTKBD_NO_KEY */
>>>>> +    [0 ... Q_KEY_CODE__MAX]    = NEXTKBD_NO_KEY,
>>>>> +
>>>>> +    [Q_KEY_CODE_ESC]           = 0x49,
>>>>> +    [Q_KEY_CODE_1]             = 0x4a,
>>>>> +    [Q_KEY_CODE_2]             = 0x4b,
>>>>> +    [Q_KEY_CODE_3]             = 0x4c,
>>>>> +    [Q_KEY_CODE_4]             = 0x4d,
>>> [...]
>>>
>>>>> +static void nextkbd_event(DeviceState *dev, QemuConsole *src, InputEvent *evt)
>>>>> +{
>>>>> +    NextKBDState *s = NEXTKBD(dev);
>>>>> +    int qcode, keycode;
>>>>> +    bool key_down = evt->u.key.data->down;
>>>>> +
>>>>> +    qcode = qemu_input_key_value_to_qcode(evt->u.key.data->key);
>>>>> +    if (qcode >= ARRAY_SIZE(qcode_to_nextkbd_keycode)) {
>>>>> +        return;
>>>>> +    }
>>>>> +
>>>>> +    /* Shift key currently has no keycode, so handle separately */
>>>>> +    if (qcode == Q_KEY_CODE_SHIFT) {
>>>>> +        if (key_down) {
>>>>> +            s->shift |= KD_LSHIFT;
>>>>> +        } else {
>>>>> +            s->shift &= ~KD_LSHIFT;
>>>>> +        }
>>>>> +    }
>>>>> +
>>>>> +    if (qcode == Q_KEY_CODE_SHIFT_R) {
>>>>> +        if (key_down) {
>>>>> +            s->shift |= KD_RSHIFT;
>>>>> +        } else {
>>>>> +            s->shift &= ~KD_RSHIFT;
>>>>> +        }
>>>>> +    }
>>>>> +
>>>>> +    keycode = qcode_to_nextkbd_keycode[qcode];
>>>>> +    if (keycode == NEXTKBD_NO_KEY) {
>>>
>>> ... here ^
>>
>> I this case !keycode is pretty self explanatory IMO.
> 
> Ok, I'll pick up the patch with this change added on top:
> 
> diff --git a/hw/m68k/next-kbd.c b/hw/m68k/next-kbd.c
> --- a/hw/m68k/next-kbd.c
> +++ b/hw/m68k/next-kbd.c
> @@ -165,12 +165,7 @@ static const MemoryRegionOps kbd_ops = {
>       .endianness = DEVICE_NATIVE_ENDIAN,
>   };
> 
> -#define NEXTKBD_NO_KEY 0xff
> -
>   static const int qcode_to_nextkbd_keycode[] = {
> -    /* Make sure future additions are automatically set to NEXTKBD_NO_KEY */
> -    [0 ... Q_KEY_CODE__MAX]    = NEXTKBD_NO_KEY,
> -
>       [Q_KEY_CODE_ESC]           = 0x49,
>       [Q_KEY_CODE_1]             = 0x4a,
>       [Q_KEY_CODE_2]             = 0x4b,
> @@ -276,7 +271,7 @@ static void nextkbd_event(DeviceState *dev, QemuConsole *src, 
> InputEvent *evt)
>       }
> 
>       keycode = qcode_to_nextkbd_keycode[qcode];
> -    if (keycode == NEXTKBD_NO_KEY) {
> +    if (!keycode) {
>           return;
>       }
> 
>   Thomas

Thank you Thomas, greatly appreciated!


ATB,

Mark.


