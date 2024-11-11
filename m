Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AE52DD3ABF4
	for <qemu-devel@archiver.kernel.org>; Mon, 11 Nov 2024 21:38:09 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tAc65-0000zW-Vu; Mon, 11 Nov 2024 16:37:22 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mark.cave-ayland@ilande.co.uk>)
 id 1tAc64-0000zD-59
 for qemu-devel@nongnu.org; Mon, 11 Nov 2024 16:37:20 -0500
Received: from mail.ilande.co.uk ([2001:41c9:1:41f::167])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mark.cave-ayland@ilande.co.uk>)
 id 1tAc62-0001Vj-DZ
 for qemu-devel@nongnu.org; Mon, 11 Nov 2024 16:37:19 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=ilande.co.uk; s=20220518; h=Subject:Content-Transfer-Encoding:Content-Type:
 In-Reply-To:From:References:Cc:To:MIME-Version:Date:Message-ID:Sender:
 Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender
 :Resent-To:Resent-Cc:Resent-Message-ID;
 bh=YxOh92KehrULBwI0SBU7ou4NqUkR9jYnGitC9fcQhjU=; b=iHA+l9UwoeIgecd5lwmOt8vnY0
 75TiLZCkefSLQm78GS50ArTUei0ouSsB/IO+mBUs2rZdAWn3UivqRu/pjgFt2fTHQ3aoULRCtGRHX
 DNBmJFVXi4qGX+Em3rVQWRdiqeSNiJZm2zaomecICgjq+IU+mXTkDh+nj1WwZhJgOc+3MgSaR+4fr
 2tKrl0ZMEW1GMFG1WTwmouMd/B8CljrNOUyDru5sRNcTvosTslT0u8jmOY2ncxrACvJ+R/2gEyoQm
 FxLXOPH7IJzj5/fAPPn1Gz77bRfiKgjjEdyfFUHJSTL7HUz1/0GdrS7VLvqIpd9E0+0sJ21/t+xQ/
 V3W7ncsCqlQv5QVcmrm9voeIXoCD6r/Kv8kpSLAU5tdgf/jMFqNJSUHDbZn7gblF/zGVFICl3WN5e
 O9JP31yXPT3vLKMrw0CF2gQSywiBfck+2ZhuJuOBrk5WERRRy3ME0Vx/HBOkBhDETh7EwcGiSB1MK
 stSi0MeQaKRonNhq12yHYmMCXNizDphtkgsFQcM049/sHscSrL9ue70H+uLhd1r6ov5WclbAxs4jt
 ADIlgsYzLnu2nxUnwbMSKgte9XdKLZ/m1GlvocfOMQGLjGvv1bM/OeUGsTCuucpAbYDnlHPchh2XX
 Pyg0RTqaPyXiaLd9AeqWTHcQYIrete8P28PZfOU1Y=;
Received: from [2a00:23c4:8bb8:f600:4d41:7cfb:3f13:ce94]
 by mail.ilande.co.uk with esmtpsa (TLS1.3:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.92) (envelope-from <mark.cave-ayland@ilande.co.uk>)
 id 1tAc5a-0004wN-9n; Mon, 11 Nov 2024 21:36:54 +0000
Message-ID: <eacde215-1a30-47b8-ba03-aba863f5adcb@ilande.co.uk>
Date: Mon, 11 Nov 2024 21:37:10 +0000
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: Thomas Huth <huth@tuxfamily.org>
Cc: qemu-devel@nongnu.org
References: <20241023085852.1061031-1-mark.cave-ayland@ilande.co.uk>
 <20241023085852.1061031-32-mark.cave-ayland@ilande.co.uk>
 <20241109092411.5ced24d0@tpx1>
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
In-Reply-To: <20241109092411.5ced24d0@tpx1>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-SA-Exim-Connect-IP: 2a00:23c4:8bb8:f600:4d41:7cfb:3f13:ce94
X-SA-Exim-Mail-From: mark.cave-ayland@ilande.co.uk
Subject: Re: [PATCH 31/36] next-cube: add rtc-cmd-reset named gpio to reset
 the rtc state machine
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

On 09/11/2024 08:24, Thomas Huth wrote:

> Am Wed, 23 Oct 2024 09:58:47 +0100
> schrieb Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>:
> 
>> This allows us to decouple the next-pc and next-rtc devices from each
>> other in next_scr2_rtc_update().
>>
>> Signed-off-by: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
>> ---
>>   hw/m68k/next-cube.c | 23 +++++++++++++++++++----
>>   1 file changed, 19 insertions(+), 4 deletions(-)
>>
>> diff --git a/hw/m68k/next-cube.c b/hw/m68k/next-cube.c
>> index bd24359913..16b16e9956 100644
>> --- a/hw/m68k/next-cube.c
>> +++ b/hw/m68k/next-cube.c
>> @@ -108,6 +108,7 @@ struct NeXTPC {
>>       NeXTRTC rtc;
>>       qemu_irq rtc_power_irq;
>>       qemu_irq rtc_data_irq;
>> +    qemu_irq rtc_cmd_reset_irq;
>>   };
>>   
>>   typedef struct next_dma {
>> @@ -264,7 +265,6 @@ static void next_rtc_data_in_irq(void *opaque, int n, int level)
>>   static void next_scr2_rtc_update(NeXTPC *s)
>>   {
>>       uint8_t old_scr2, scr2_2;
>> -    NeXTRTC *rtc = &s->rtc;
>>   
>>       old_scr2 = extract32(s->old_scr2, 8, 8);
>>       scr2_2 = extract32(s->scr2, 8, 8);
>> @@ -282,9 +282,7 @@ static void next_scr2_rtc_update(NeXTPC *s)
>>           }
>>       } else {
>>           /* else end or abort */
>> -        rtc->phase = 0;
>> -        rtc->command = 0;
>> -        rtc->value = 0;
>> +        qemu_irq_raise(s->rtc_cmd_reset_irq);
>>       }
>>   }
> 
> Don't we also need a spot where the gpio gets lowered again?

It's not strictly necessary in this particular case because the IRQ handler 
implements the reset directly when the gpio is raised, as opposed to it being a 
stateful signal like the others.


ATB,

Mark.


