Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 976F6D5C0F3
	for <qemu-devel@archiver.kernel.org>; Fri,  8 Nov 2024 15:49:16 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t9RBT-0008Jf-DM; Fri, 08 Nov 2024 10:46:04 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1t9RBN-0007zv-Vj
 for qemu-devel@nongnu.org; Fri, 08 Nov 2024 10:45:59 -0500
Received: from mail-wm1-x334.google.com ([2a00:1450:4864:20::334])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1t9RBM-00066f-1I
 for qemu-devel@nongnu.org; Fri, 08 Nov 2024 10:45:57 -0500
Received: by mail-wm1-x334.google.com with SMTP id
 5b1f17b1804b1-4316e9f4a40so19310315e9.2
 for <qemu-devel@nongnu.org>; Fri, 08 Nov 2024 07:45:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1731080754; x=1731685554; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=0jQ1jQxcDa8HVMKjrRDqFM9Txr21FbFDj+5TaHe2ie4=;
 b=Acnj4JLYUUVeNiTOAPlrQS9qIIjWn+m8rqVFmBD7VBQ0u/dItLCKtbuyOnE509ofj7
 NTs16JN+d5NIhUfWpq1ixQrWOgvfPI8A3h9b0D4kzAoqpgaq+2FZtpt70fsH65dwcuJ1
 lFWCAoIhUgQ++Kion57jhDg5GbVzpn0X92KzTYuTVoWyDDd06dOt//3+sLA6xMi1AoDY
 KR8vIZ1kVkQQss+GQgOOCKWhEssPzoDEZOcfXGGqTTOablbyXSkNLdLEmhmznEVdbSId
 QeR0ewe2miXsR01y2MI4YymAIC5zWfyaB50FnoIGR+V1ldi5jCoMV4yn+fxM9in9eJWz
 pa1w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1731080754; x=1731685554;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=0jQ1jQxcDa8HVMKjrRDqFM9Txr21FbFDj+5TaHe2ie4=;
 b=B+aSqZKLYjvRJMUm8P1lfgjXWLliFxQf/3wLkiT+ypqtC83T5vaNFOCA8coWu/5Jfj
 DFSMagb4C/C1rE1nIh/a+aOX/6toO8+640MN7lfi2/6eZMpg/wi2AD3sHtd7Drou6eu/
 +teQINWmdnuPAxxwWVfM1P9CFon+SquqXrPLFUNuIdrgZTVe/hWOHcNloDcwLqgvRsDG
 sbz1vwqwF5A6PwcHplFCjK5G5jaaYCrvD4u4oaYtdLiYKuLkSUhugYrOl4rLUUKzHUkA
 s3WX+/R0eWUI83W3Ftck40Ze96G4WgyZWbYiHPDM1DlP2cXpoeclzCxCGGkhn5iQCNOT
 WgXA==
X-Forwarded-Encrypted: i=1;
 AJvYcCW+NBlB7Z13jLZU6O/d3/jDfsmYvOaknz4VOPJKFa0UQGIZI3w2pjQDO3134EVct5rF6aGIfpwYJqkg@nongnu.org
X-Gm-Message-State: AOJu0Yx0fTCE10x/qdYrJTl7YbIvAYINt8tCza2npthOJylJOlG9zpRT
 4S6dU2zNBqDhw85RLmRvsXyEjTI4Rb57+HMfV/AYxTIc/AxJShvETJ262USBjN0=
X-Google-Smtp-Source: AGHT+IFV0Zyt6lCU9v22K2HEZLDGHLS6Xp4CU3X2l1wE7zb0UU1SJ9bqWSII856SBNAg/Y3s2FntpA==
X-Received: by 2002:a05:600c:19c8:b0:42f:7ed4:4c26 with SMTP id
 5b1f17b1804b1-432b75002b7mr29111995e9.12.1731080754559; 
 Fri, 08 Nov 2024 07:45:54 -0800 (PST)
Received: from [172.16.22.241] ([89.101.241.141])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-432aa6b35c0sm115152705e9.16.2024.11.08.07.45.53
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 08 Nov 2024 07:45:53 -0800 (PST)
Message-ID: <38fe1add-39d8-424d-b504-e6b5b11ef281@linaro.org>
Date: Fri, 8 Nov 2024 15:45:52 +0000
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 1/2] next-kbd: convert to use
 qemu_input_handler_register()
To: BALATON Zoltan <balaton@eik.bme.hu>, Thomas Huth <th.huth@posteo.de>
Cc: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>,
 peter.maydell@linaro.org, huth@tuxfamily.org, berrange@redhat.com,
 qemu-devel@nongnu.org
References: <20241106120928.242443-1-mark.cave-ayland@ilande.co.uk>
 <20241106120928.242443-2-mark.cave-ayland@ilande.co.uk>
 <4c127d3c-3610-e6b7-9358-3d88d28477a0@eik.bme.hu>
 <13995544-2d94-4b35-a7c2-f11e0599170f@linaro.org>
 <872fd077-b870-f910-88a5-a045787aa681@eik.bme.hu>
 <c3b996b4-d128-4830-94d4-5c9448ca003d@posteo.de>
 <5c992398-718d-9445-7122-053c8169bb5b@eik.bme.hu>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <5c992398-718d-9445-7122-053c8169bb5b@eik.bme.hu>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::334;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x334.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
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

On 8/11/24 13:13, BALATON Zoltan wrote:
> On Fri, 8 Nov 2024, Thomas Huth wrote:
>> On 06/11/2024 21.32, BALATON Zoltan wrote:
>>> On Wed, 6 Nov 2024, Philippe Mathieu-Daudé wrote:
>>>> On 6/11/24 13:00, BALATON Zoltan wrote:
>>>>> On Wed, 6 Nov 2024, Mark Cave-Ayland wrote:
>>>>>> Convert the next-kbd device from the legacy UI 
>>>>>> qemu_add_kbd_event_handler()
>>>>>> function to use qemu_input_handler_register().
>>>>>>
>>>>>> Signed-off-by: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
>>>>>> Reviewed-by: Thomas Huth <huth@tuxfamily.org>
>>>>>> ---
>>>>>> hw/m68k/next-kbd.c | 163 
>>>>>> ++++++++++++++++++++++++++++++---------------
>>>>>> 1 file changed, 108 insertions(+), 55 deletions(-)
>>>>
>>>>
>>>>>> -static const unsigned char next_keycodes[128] = {
>>>>>> -    0x00, 0x49, 0x4A, 0x4B, 0x4C, 0x4D, 0x50, 0x4F,
>>>>>> -    0x4E, 0x1E, 0x1F, 0x20, 0x1D, 0x1C, 0x1B, 0x00,
>>>>>> -    0x42, 0x43, 0x44, 0x45, 0x48, 0x47, 0x46, 0x06,
>>>>>> -    0x07, 0x08, 0x00, 0x00, 0x2A, 0x00, 0x39, 0x3A,
>>>>>> -    0x3B, 0x3C, 0x3D, 0x40, 0x3F, 0x3E, 0x2D, 0x2C,
>>>>>> -    0x2B, 0x26, 0x00, 0x00, 0x31, 0x32, 0x33, 0x34,
>>>>>> -    0x35, 0x37, 0x36, 0x2e, 0x2f, 0x30, 0x00, 0x00,
>>>>>> -    0x00, 0x38, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,
>>>>>> -    0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
>>>>>> -    0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
>>>>>> -    0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
>>>>>> -    0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0
>>>>>> +#define NEXTKBD_NO_KEY 0xff
>>>>>
>>>>> Now you don't need this 0xff define any more because you can use 0 
>>>>> as no key value then the [0 ... Q_KEY_CODE__MAX] init below can 
>>>>> also be dropped because static variables are 0 init automatically.
>>>>
>>>> Whether 0 or 0xff is best for NO_KEY, I don't know.
>>>> However, definitions are useful when reviewing ...
>>>>
>>>>>
>>>>> Regards,
>>>>> BALATON Zoltan
>>>>>
>>>>>> +static const int qcode_to_nextkbd_keycode[] = {
>>>>>> +    /* Make sure future additions are automatically set to 
>>>>>> NEXTKBD_NO_KEY */
>>>>>> +    [0 ... Q_KEY_CODE__MAX]    = NEXTKBD_NO_KEY,
>>>>>> +
>>>>>> +    [Q_KEY_CODE_ESC]           = 0x49,
>>>>>> +    [Q_KEY_CODE_1]             = 0x4a,
>>>>>> +    [Q_KEY_CODE_2]             = 0x4b,
>>>>>> +    [Q_KEY_CODE_3]             = 0x4c,
>>>>>> +    [Q_KEY_CODE_4]             = 0x4d,
>>>> [...]
>>>>
>>>>>> +static void nextkbd_event(DeviceState *dev, QemuConsole *src, 
>>>>>> InputEvent *evt)
>>>>>> +{
>>>>>> +    NextKBDState *s = NEXTKBD(dev);
>>>>>> +    int qcode, keycode;
>>>>>> +    bool key_down = evt->u.key.data->down;
>>>>>> +
>>>>>> +    qcode = qemu_input_key_value_to_qcode(evt->u.key.data->key);
>>>>>> +    if (qcode >= ARRAY_SIZE(qcode_to_nextkbd_keycode)) {
>>>>>> +        return;
>>>>>> +    }
>>>>>> +
>>>>>> +    /* Shift key currently has no keycode, so handle separately */
>>>>>> +    if (qcode == Q_KEY_CODE_SHIFT) {
>>>>>> +        if (key_down) {
>>>>>> +            s->shift |= KD_LSHIFT;
>>>>>> +        } else {
>>>>>> +            s->shift &= ~KD_LSHIFT;
>>>>>> +        }
>>>>>> +    }
>>>>>> +
>>>>>> +    if (qcode == Q_KEY_CODE_SHIFT_R) {
>>>>>> +        if (key_down) {
>>>>>> +            s->shift |= KD_RSHIFT;
>>>>>> +        } else {
>>>>>> +            s->shift &= ~KD_RSHIFT;
>>>>>> +        }
>>>>>> +    }
>>>>>> +
>>>>>> +    keycode = qcode_to_nextkbd_keycode[qcode];
>>>>>> +    if (keycode == NEXTKBD_NO_KEY) {
>>>>
>>>> ... here ^
>>>
>>> I this case !keycode is pretty self explanatory IMO.
>>
>> Ok, I'll pick up the patch with this change added on top:
>>
>> diff --git a/hw/m68k/next-kbd.c b/hw/m68k/next-kbd.c
>> --- a/hw/m68k/next-kbd.c
>> +++ b/hw/m68k/next-kbd.c
>> @@ -165,12 +165,7 @@ static const MemoryRegionOps kbd_ops = {
>>     .endianness = DEVICE_NATIVE_ENDIAN,
>> };
>> -#define NEXTKBD_NO_KEY 0xff
>> -
>> static const int qcode_to_nextkbd_keycode[] = {
>> -    /* Make sure future additions are automatically set to 
>> NEXTKBD_NO_KEY */
>> -    [0 ... Q_KEY_CODE__MAX]    = NEXTKBD_NO_KEY,
> 
> Thinking about it more, removing this may make the array smaller so we'd 
> either need some max value define (or get it something like 
> qcode_to_nextkbd_keycode[ARRAY_SIZE(qcode_to_nextkbd_keycode) - 1] or 
> so) and check if qcode is not > than that or declare the array as 
> [Q_KEY_CODE__MAX] to make sure we're not trying to access values after 
> the end.  Maybe it's simplest to do 
> qcode_to_nextkbd_keycode[Q_KEY_CODE__MAX] as this is not much wasted 
> space, unless this can't overflow for some other reason I don't know about.

Agreed, qcode_to_nextkbd_keycode[Q_KEY_CODE__MAX] is future-proof.

> 
> Regards,
> BALATON Zoltan
> 
>> -
>>     [Q_KEY_CODE_ESC]           = 0x49,
>>     [Q_KEY_CODE_1]             = 0x4a,
>>     [Q_KEY_CODE_2]             = 0x4b,
>> @@ -276,7 +271,7 @@ static void nextkbd_event(DeviceState *dev, 
>> QemuConsole *src, InputEvent *evt)
>>     }
>>      keycode = qcode_to_nextkbd_keycode[qcode];
>> -    if (keycode == NEXTKBD_NO_KEY) {
>> +    if (!keycode) {
>>         return;
>>     }
>>  Thomas
>>
>>


