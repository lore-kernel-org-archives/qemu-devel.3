Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 87ECFE6F07D
	for <qemu-devel@archiver.kernel.org>; Fri,  1 Nov 2024 19:00:13 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t6wsS-0003n4-2M; Fri, 01 Nov 2024 15:00:08 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mark.cave-ayland@ilande.co.uk>)
 id 1t6wsO-0003kQ-7C
 for qemu-devel@nongnu.org; Fri, 01 Nov 2024 15:00:05 -0400
Received: from mail.ilande.co.uk ([2001:41c9:1:41f::167])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mark.cave-ayland@ilande.co.uk>)
 id 1t6wsL-0000km-Tm
 for qemu-devel@nongnu.org; Fri, 01 Nov 2024 15:00:03 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=ilande.co.uk; s=20220518; h=Subject:Content-Transfer-Encoding:Content-Type:
 In-Reply-To:From:References:Cc:To:MIME-Version:Date:Message-ID:Sender:
 Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender
 :Resent-To:Resent-Cc:Resent-Message-ID;
 bh=0Shx2gLTe/gGSbhHc7daOZmLB6DlS+sLcuNWvON50Ew=; b=B/guIJbY7Mb0Vxwx16OOyGFVHK
 pKX/ZwLRYTDUQmuWYOIketkORjEbymXlg3uUqKzKP8Tx6iQ8EapnvWj/Po4eN0ZiNX4CzqipQeMWt
 4jCNijAdQWeT1mlsxLvc8N1xeWuQcg+5Dgtg1pLpzK/sWj4a+DWL4ouqd4r0OBJR8vSYfxgSOcvHT
 DhQUKFuHQgZMpDALrzf493zGV7oiZnM4U/g9ovn7VnZPDyWbfEfsMQ2EnMPJmwuZsDHWFnH1ZOlQZ
 KEX0GYEZ0pIoxdb0sIt4qklDbNKpm1RIfl0Q9T41V19Wtvcgawtc14EdxXdAcK6mKC1H0DG4FTs82
 xKnwlC5OGR6s2yGLg/EtdzA3KBViD95esDY81Jzr8ODePhWzRkrWykIW6wLcM0AHCGn/bDq0PkzVw
 Zo0g6c15LzmTiFXBrAzEYGUomql252r5wmxNp4mMp6vcSX/YkuZsPHsqx/BlIyJIxiC3SiHvF/RZK
 Pae1AEZXvDBVCoYPRWbL3Cw/ey8aJ0kLaj6duVI9O/mQWe3lEYuSiTFnF3BcVdXXA6YudCptfnMfd
 OCXqSIGQPm/zBkHZrFYdAXEX9skMw/aSmSNA6hOUVdyWGbG8eK18NGiVHOPRmT9akLSOZHgsuIPqo
 Pd96Ww1w2QiQTUiBxWdf0WXP+9sMduX+OhpdJ/M0Y=;
Received: from [2a00:23c4:8bb8:f600:91a1:336d:3931:745]
 by mail.ilande.co.uk with esmtpsa (TLS1.3:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.92) (envelope-from <mark.cave-ayland@ilande.co.uk>)
 id 1t6wrt-0001q4-GF; Fri, 01 Nov 2024 18:59:37 +0000
Message-ID: <df8254a1-cd81-41f5-ad8b-6229dce2678d@ilande.co.uk>
Date: Fri, 1 Nov 2024 18:59:47 +0000
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: Thomas Huth <huth@tuxfamily.org>
Cc: peter.maydell@linaro.org, qemu-devel@nongnu.org
References: <20241030091803.1315752-1-mark.cave-ayland@ilande.co.uk>
 <20241101102647.75bedfe2@tpx1>
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
In-Reply-To: <20241101102647.75bedfe2@tpx1>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-SA-Exim-Connect-IP: 2a00:23c4:8bb8:f600:91a1:336d:3931:745
X-SA-Exim-Mail-From: mark.cave-ayland@ilande.co.uk
Subject: Re: [PATCH] next-kbd: convert to use qemu_input_handler_register()
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

On 01/11/2024 09:26, Thomas Huth wrote:

> Am Wed, 30 Oct 2024 09:18:03 +0000
> schrieb Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>:
> 
>> Convert the next-kbd device from the legacy UI qemu_add_kbd_event_handler()
>> function to use qemu_input_handler_register().
>>
>> Signed-off-by: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
>> ---
>>   hw/m68k/next-kbd.c | 158 +++++++++++++++++++++++++++++----------------
>>   1 file changed, 103 insertions(+), 55 deletions(-)
>>
>> diff --git a/hw/m68k/next-kbd.c b/hw/m68k/next-kbd.c
>> index bc67810f31..85ef784491 100644
>> --- a/hw/m68k/next-kbd.c
>> +++ b/hw/m68k/next-kbd.c
>> @@ -68,7 +68,6 @@ struct NextKBDState {
>>       uint16_t shift;
>>   };
>>   
>> -static void queue_code(void *opaque, int code);
>>   
>>   /* lots of magic numbers here */
>>   static uint32_t kbd_read_byte(void *opaque, hwaddr addr)
>> @@ -166,68 +165,79 @@ static const MemoryRegionOps kbd_ops = {
>>       .endianness = DEVICE_NATIVE_ENDIAN,
>>   };
>>   
>> -static void nextkbd_event(void *opaque, int ch)
>> -{
>> -    /*
>> -     * Will want to set vars for caps/num lock
>> -     * if (ch & 0x80) -> key release
>> -     * there's also e0 escaped scancodes that might need to be handled
>> -     */
>> -    queue_code(opaque, ch);
>> -}
>> -
>> -static const unsigned char next_keycodes[128] = {
>> -    0x00, 0x49, 0x4A, 0x4B, 0x4C, 0x4D, 0x50, 0x4F,
>> -    0x4E, 0x1E, 0x1F, 0x20, 0x1D, 0x1C, 0x1B, 0x00,
>> -    0x42, 0x43, 0x44, 0x45, 0x48, 0x47, 0x46, 0x06,
>> -    0x07, 0x08, 0x00, 0x00, 0x2A, 0x00, 0x39, 0x3A,
>> -    0x3B, 0x3C, 0x3D, 0x40, 0x3F, 0x3E, 0x2D, 0x2C,
>> -    0x2B, 0x26, 0x00, 0x00, 0x31, 0x32, 0x33, 0x34,
>> -    0x35, 0x37, 0x36, 0x2e, 0x2f, 0x30, 0x00, 0x00,
>> -    0x00, 0x38, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,
>> -    0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
>> -    0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
>> -    0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
>> -    0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0
>> +#define NEXTKDB_NO_KEY 0xff
>> +
>> +static const int qcode_to_nextkbd_keycode[] = {
>> +    /* Make sure future additions are automatically set to NEXTKDB_NO_KEY */
>> +    [0 ... 0xff]               = NEXTKDB_NO_KEY,
> 
> I think it would be better to use Q_KEY_CODE__MAX here instead of 0xff ?

Ah I wasn't aware of that, but it makes sense - I ended up using adb-kbd.c as a guide 
which is where the (NEXTKBD_)NO_KEY constant comes from.

>> +    [Q_KEY_CODE_ESC]           = 0x49,
>> +    [Q_KEY_CODE_1]             = 0x4a,
>> +    [Q_KEY_CODE_2]             = 0x4b,
>> +    [Q_KEY_CODE_3]             = 0x4c,
>> +    [Q_KEY_CODE_4]             = 0x4d,
>> +    [Q_KEY_CODE_5]             = 0x50,
>> +    [Q_KEY_CODE_6]             = 0x4f,
>> +    [Q_KEY_CODE_7]             = 0x4e,
>> +    [Q_KEY_CODE_8]             = 0x1e,
>> +    [Q_KEY_CODE_9]             = 0x1f,
>> +    [Q_KEY_CODE_0]             = 0x20,
>> +    [Q_KEY_CODE_MINUS]         = 0x1d,
>> +    [Q_KEY_CODE_EQUAL]         = 0x1c,
>> +    [Q_KEY_CODE_BACKSPACE]     = 0x1b,
>> +    [Q_KEY_CODE_TAB]           = 0x00,
>> +
>> +    [Q_KEY_CODE_Q]             = 0x42,
>> +    [Q_KEY_CODE_W]             = 0x43,
>> +    [Q_KEY_CODE_E]             = 0x44,
>> +    [Q_KEY_CODE_R]             = 0x45,
>> +    [Q_KEY_CODE_T]             = 0x48,
>> +    [Q_KEY_CODE_Y]             = 0x47,
>> +    [Q_KEY_CODE_U]             = 0x46,
>> +    [Q_KEY_CODE_I]             = 0x06,
>> +    [Q_KEY_CODE_O]             = 0x07,
>> +    [Q_KEY_CODE_P]             = 0x08,
>> +    [Q_KEY_CODE_RET]           = 0x2a,
>> +    [Q_KEY_CODE_A]             = 0x39,
>> +    [Q_KEY_CODE_S]             = 0x3a,
>> +
>> +    [Q_KEY_CODE_D]             = 0x3b,
>> +    [Q_KEY_CODE_F]             = 0x3c,
>> +    [Q_KEY_CODE_G]             = 0x3d,
>> +    [Q_KEY_CODE_H]             = 0x40,
>> +    [Q_KEY_CODE_J]             = 0x3f,
>> +    [Q_KEY_CODE_K]             = 0x3e,
>> +    [Q_KEY_CODE_L]             = 0x2d,
>> +    [Q_KEY_CODE_SEMICOLON]     = 0x2c,
>> +    [Q_KEY_CODE_APOSTROPHE]    = 0x2b,
>> +    [Q_KEY_CODE_GRAVE_ACCENT]  = 0x26,
>> +    [Q_KEY_CODE_SHIFT]         = 0x00,
>> +    [Q_KEY_CODE_BACKSLASH]     = 0x00,
>> +    [Q_KEY_CODE_Z]             = 0x31,
>> +    [Q_KEY_CODE_X]             = 0x32,
>> +    [Q_KEY_CODE_C]             = 0x33,
>> +    [Q_KEY_CODE_V]             = 0x34,
>> +
>> +    [Q_KEY_CODE_B]             = 0x35,
>> +    [Q_KEY_CODE_N]             = 0x37,
>> +    [Q_KEY_CODE_M]             = 0x36,
>> +    [Q_KEY_CODE_COMMA]         = 0x2e,
>> +    [Q_KEY_CODE_DOT]           = 0x2f,
>> +    [Q_KEY_CODE_SLASH]         = 0x30,
>> +    [Q_KEY_CODE_SHIFT_R]       = 0x00,
>> +
>> +    [Q_KEY_CODE_SPC]           = 0x38,
>>   };
>>   
>> -static void queue_code(void *opaque, int code)
>> +static void nextkbd_put_keycode(NextKBDState *s, int keycode)
>>   {
>> -    NextKBDState *s = NEXTKBD(opaque);
>>       KBDQueue *q = &s->queue;
>> -    int key = code & KD_KEYMASK;
>> -    int release = code & 0x80;
>> -    static int ext;
>> -
>> -    if (code == 0xE0) {
>> -        ext = 1;
>> -    }
>> -
>> -    if (code == 0x2A || code == 0x1D || code == 0x36) {
>> -        if (code == 0x2A) {
>> -            s->shift = KD_LSHIFT;
>> -        } else if (code == 0x36) {
>> -            s->shift = KD_RSHIFT;
>> -            ext = 0;
>> -        } else if (code == 0x1D && !ext) {
>> -            s->shift = KD_LCOMM;
>> -        } else if (code == 0x1D && ext) {
>> -            ext = 0;
>> -            s->shift = KD_RCOMM;
>> -        }
>> -        return;
>> -    } else if (code == (0x2A | 0x80) || code == (0x1D | 0x80) ||
>> -               code == (0x36 | 0x80)) {
>> -        s->shift = 0;
>> -        return;
>> -    }
>>   
>>       if (q->count >= KBD_QUEUE_SIZE) {
>>           return;
>>       }
>>   
>> -    q->data[q->wptr] = next_keycodes[key] | release;
>> -
>> +    q->data[q->wptr] = keycode;
>>       if (++q->wptr == KBD_QUEUE_SIZE) {
>>           q->wptr = 0;
>>       }
>> @@ -241,6 +251,44 @@ static void queue_code(void *opaque, int code)
>>       /* s->update_irq(s->update_arg, 1); */
>>   }
>>   
>> +static void nextkbd_event(DeviceState *dev, QemuConsole *src, InputEvent *evt)
>> +{
>> +    NextKBDState *s = NEXTKBD(dev);
>> +    int qcode, keycode;
>> +    bool key_down = evt->u.key.data->down;
>> +
>> +    qcode = qemu_input_key_value_to_qcode(evt->u.key.data->key);
>> +    if (qcode >= ARRAY_SIZE(qcode_to_nextkbd_keycode)) {
>> +        return;
>> +    }
>> +
>> +    keycode = qcode_to_nextkbd_keycode[qcode];
>> +    if (keycode == NEXTKDB_NO_KEY) {
>> +        return;
>> +    }
>> +
>> +    if (qcode == Q_KEY_CODE_SHIFT) {
>> +        s->shift = key_down ? KD_LSHIFT : 0;
>> +    }
>> +
>> +    if (qcode == Q_KEY_CODE_SHIFT_R) {
>> +        s->shift = key_down ? KD_RSHIFT : 0;
>> +    }
> 
> This does not work properly when you press both shift keys together, e.g.
> press the left shift key first and keep it pressed, then shortly press the
> right shift key and release it, then type some letters while you still hold
> down the left shift key.
> 
> I think you should rather treat the shift value like a bitfield here, e.g.:
> 
>      if (qcode == Q_KEY_CODE_SHIFT) {
>          if (key_down) {
>              s->shift |= KD_LSHIFT;
>          } else {
>              s->shift &= ~KD_LSHIFT;
>          }
>      }
> 
>      if (qcode == Q_KEY_CODE_SHIFT_R) {
>          if (key_down) {
>              s->shift |= KD_RSHIFT;
>          } else {
>              s->shift &= ~KD_RSHIFT;
>          }
>      }

Thanks for this! I mistook the checks for !ext and ext in the current version as 
being part of the scancode state machine, but as you point out they are in fact 
needed for the shift key logic to work correctly.

I prefer your version of the logic above using a bitfield, and making the change is 
easy since the device is currently marked as non-migratable.

I'll go ahead and make both these changes for v3.

>   Thomas
> 
>> +    /* If key release event, create keyboard break code */
>> +    if (!key_down) {
>> +        keycode = keycode | 0x80;
>> +    }
>> +
>> +    nextkbd_put_keycode(s, keycode);
>> +}
>> +
>> +static const QemuInputHandler nextkbd_handler = {
>> +    .name  = "QEMU NeXT Keyboard",
>> +    .mask  = INPUT_EVENT_MASK_KEY,
>> +    .event = nextkbd_event,
>> +};
>> +
>>   static void nextkbd_reset(DeviceState *dev)
>>   {
>>       NextKBDState *nks = NEXTKBD(dev);
>> @@ -256,7 +304,7 @@ static void nextkbd_realize(DeviceState *dev, Error **errp)
>>       memory_region_init_io(&s->mr, OBJECT(dev), &kbd_ops, s, "next.kbd", 0x1000);
>>       sysbus_init_mmio(SYS_BUS_DEVICE(dev), &s->mr);
>>   
>> -    qemu_add_kbd_event_handler(nextkbd_event, s);
>> +    qemu_input_handler_register(dev, &nextkbd_handler);
>>   }
>>   
>>   static const VMStateDescription nextkbd_vmstate = {


ATB,

Mark.


