Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 65DFCE6FE4C
	for <qemu-devel@archiver.kernel.org>; Sat,  7 Sep 2024 13:27:54 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1smvT9-000501-Nh; Sat, 07 Sep 2024 09:27:15 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mark.cave-ayland@ilande.co.uk>)
 id 1smvT8-0004yt-42; Sat, 07 Sep 2024 09:27:14 -0400
Received: from mail.ilande.co.uk ([2001:41c9:1:41f::167])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mark.cave-ayland@ilande.co.uk>)
 id 1smvT6-0003g1-AS; Sat, 07 Sep 2024 09:27:13 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=ilande.co.uk; s=20220518; h=Subject:Content-Transfer-Encoding:Content-Type:
 In-Reply-To:From:References:To:MIME-Version:Date:Message-ID:Sender:Reply-To:
 Cc:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID;
 bh=IotkzAljVAcCglNUgbdKyKjHmvrps/QohU3NiamGhvY=; b=sZLE6iFXyluupqqwTF3O2MQ+yz
 GlXp+TLTaHJsi0fTO0HkpGQaUHoGR+LaTepfbtJpHIDOjIjRmIpi+TYuH2i6XnvNaqRIhHQVhTyDX
 i5RV5xSUaZFNktb1IwBH0cRYoIGQE8SLkrIntev4sj52uWJIX1/KUpNx+wyVITtpCVfD0+ozoL80w
 asCCICnjGNWj535CYFY8H7W2rA9V2tLSjIH6Os2BAiEpXRjPXxFd6NBL3Pg2FHCpZgyi6Kxm3vBEf
 Nc966kxieLPwqzGH5LiviHYcI/le2bolsjyuQrkjQj/h1Mrj6EtpNwj5VTCDfvIdYhf9mvdFzXaQt
 Z24OCc1A9+nLCp1bEeN60UXkKg4jvi6w9N/vBxmMHBTfjuFRKLK03nFeY82y5bHNIo9qes3pXzmp4
 oY4gCiFXMPHkW6fkazcVLiOycgACnlL2T6FJXNY5EST3RPW9hie3XSdzUmv2x35yEGEEBg2ytTlgx
 QCWdvzqBPW+DL4oA05pgnRNKkFqNGDVIOkmee5vsQsDSsKj26EFd4lFelffmD2UB7zzbYExEbLXlf
 ZgbkYkaq3dacdDVaN5x0MaUTkPDAEXFJ/bH6c8D40k1BoeBii8/io5m/Q5Pq3/JC1jhzrwhkdQ/ns
 uRjDDGpGtaBHAz3meUpZqRQ4Vc2c1wFrCnGpFwPHE=;
Received: from [2a00:23c4:8bb8:1400:c2c8:7829:48cd:7400]
 by mail.ilande.co.uk with esmtpsa (TLS1.3:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.92) (envelope-from <mark.cave-ayland@ilande.co.uk>)
 id 1smvSx-0004FY-Hg; Sat, 07 Sep 2024 14:27:07 +0100
Message-ID: <fa03b234-1759-4759-ad55-0f5b31af02f1@ilande.co.uk>
Date: Sat, 7 Sep 2024 14:27:00 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 qemu-devel@nongnu.org, qemu-ppc@nongnu.org, hsp.cat7@gmail.com
References: <20240904104007.177239-1-mark.cave-ayland@ilande.co.uk>
 <5f68f72e-9449-4cf3-82df-47c912b2c0c3@linaro.org>
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
In-Reply-To: <5f68f72e-9449-4cf3-82df-47c912b2c0c3@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 2a00:23c4:8bb8:1400:c2c8:7829:48cd:7400
X-SA-Exim-Mail-From: mark.cave-ayland@ilande.co.uk
Subject: Re: [PATCH] adb-mouse: convert to use QemuInputHandler
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

On 07/09/2024 06:40, Philippe Mathieu-Daudé wrote:

> Hi Mark,
> 
> On 4/9/24 12:40, Mark Cave-Ayland wrote:
>> Update the ADB mouse implementation to use QemuInputHandler instead of the
>> legacy qemu_add_mouse_event_handler() function.
>>
>> Signed-off-by: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
>> ---
>>   hw/input/adb-mouse.c | 56 ++++++++++++++++++++++++++++++++++++--------
>>   1 file changed, 46 insertions(+), 10 deletions(-)
>>
>> diff --git a/hw/input/adb-mouse.c b/hw/input/adb-mouse.c
>> index 144a0ccce7..7aa36caf2f 100644
>> --- a/hw/input/adb-mouse.c
>> +++ b/hw/input/adb-mouse.c
>> @@ -38,6 +38,7 @@ struct MouseState {
>>       ADBDevice parent_obj;
>>       /*< private >*/
>> +    QemuInputHandlerState *hs;
>>       int buttons_state, last_buttons_state;
>>       int dx, dy, dz;
>>   };
>> @@ -51,17 +52,52 @@ struct ADBMouseClass {
>>       DeviceRealize parent_realize;
>>   };
>> -static void adb_mouse_event(void *opaque,
>> -                            int dx1, int dy1, int dz1, int buttons_state)
>> +#define ADB_MOUSE_BUTTON_LEFT   0x01
>> +#define ADB_MOUSE_BUTTON_RIGHT  0x02
>> +
>> +static void adb_mouse_handle_event(DeviceState *dev, QemuConsole *src,
>> +                                   InputEvent *evt)
>>   {
>> -    MouseState *s = opaque;
>> +    MouseState *s = (MouseState *)dev;
>> +    InputMoveEvent *move;
>> +    InputBtnEvent *btn;
>> +    static const int bmap[INPUT_BUTTON__MAX] = {
>> +        [INPUT_BUTTON_LEFT]   = ADB_MOUSE_BUTTON_LEFT,
>> +        [INPUT_BUTTON_RIGHT]  = ADB_MOUSE_BUTTON_RIGHT,
>> +    };
>> +
>> +    switch (evt->type) {
>> +    case INPUT_EVENT_KIND_REL:
>> +        move = evt->u.rel.data;
>> +        if (move->axis == INPUT_AXIS_X) {
>> +            s->dx += move->value;
>> +        } else if (move->axis == INPUT_AXIS_Y) {
>> +            s->dy += move->value;
>> +        }
>> +        break;
>> +
>> +    case INPUT_EVENT_KIND_BTN:
>> +        btn = evt->u.btn.data;
>> +        if (bmap[btn->button]) {
>> +            if (btn->down) {
>> +                s->buttons_state |= bmap[btn->button];
>> +            } else {
>> +                s->buttons_state &= ~bmap[btn->button];
>> +            }
>> +        }
>> +        break;
>> -    s->dx += dx1;
>> -    s->dy += dy1;
>> -    s->dz += dz1;
>> -    s->buttons_state = buttons_state;
>> +    default:
>> +        /* keep gcc happy */
>> +        break;
>> +    }
>>   }
>> +static const QemuInputHandler adb_mouse_handler = {
>> +    .name  = "QEMU ADB Mouse",
>> +    .mask  = INPUT_EVENT_MASK_BTN | INPUT_EVENT_MASK_REL,
>> +    .event = adb_mouse_handle_event,
> 
> Don't we need adb_mouse_handle_sync()?

I'm not convinced that implementing .sync would work well here, since unlike e.g. 
PS/2 where async mouse events are sent over the serial port, an ADB mouse is 
constantly polled by the host via the adb_mouse_poll() callback.

You may be able to add a .sync function that generates the next set of mouse 
coordinates to be returned by adb_mouse_poll(), but then you still have to wait for 
the next ADB packet to be sent back to the host which feels like it would introduce 
extra latency.

>> +};
>>   static int adb_mouse_poll(ADBDevice *d, uint8_t *obuf)
>>   {
>> @@ -94,10 +130,10 @@ static int adb_mouse_poll(ADBDevice *d, uint8_t *obuf)
>>       dx &= 0x7f;
>>       dy &= 0x7f;
>> -    if (!(s->buttons_state & MOUSE_EVENT_LBUTTON)) {
>> +    if (!(s->buttons_state & ADB_MOUSE_BUTTON_LEFT)) {
>>           dy |= 0x80;
>>       }
>> -    if (!(s->buttons_state & MOUSE_EVENT_RBUTTON)) {
>> +    if (!(s->buttons_state & ADB_MOUSE_BUTTON_RIGHT)) {
>>           dx |= 0x80;
>>       }
>> @@ -236,7 +272,7 @@ static void adb_mouse_realizefn(DeviceState *dev, Error **errp)
>>       amc->parent_realize(dev, errp);
>> -    qemu_add_mouse_event_handler(adb_mouse_event, s, 0, "QEMU ADB Mouse");
>> +    s->hs = qemu_input_handler_register((DeviceState *)s, &adb_mouse_handler);
> 
> Simply:
> 
>         s->hs = qemu_input_handler_register(dev, &adb_mouse_handler);

Ah yes, that should work here.

>>   }
>>   static void adb_mouse_initfn(Object *obj)
> 
> Waiting for clarification on QemuInputHandler::sync, otherwise LGTM.

Hopefully explained above :)  I'll send a v2 later this evening.


ATB,

Mark.


