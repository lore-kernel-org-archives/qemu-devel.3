Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D7967C83F22
	for <qemu-devel@archiver.kernel.org>; Thu, 17 Jul 2025 13:38:07 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ucOnv-000774-SA; Thu, 17 Jul 2025 09:37:43 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mark.cave-ayland@ilande.co.uk>)
 id 1ucNrt-00081J-2d
 for qemu-devel@nongnu.org; Thu, 17 Jul 2025 08:38:00 -0400
Received: from mail.ilande.co.uk ([2001:41c9:1:41f::167])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mark.cave-ayland@ilande.co.uk>)
 id 1ucNrr-0006mC-4r
 for qemu-devel@nongnu.org; Thu, 17 Jul 2025 08:37:44 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=ilande.co.uk; s=20220518; h=Subject:Content-Transfer-Encoding:Content-Type:
 In-Reply-To:From:References:Cc:To:MIME-Version:Date:Message-ID:Sender:
 Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender
 :Resent-To:Resent-Cc:Resent-Message-ID;
 bh=T7mBhhY6YdkepIcvcVqC7B99HpfUf/AMTKL+AEmOKrI=; b=o37jDckhG0RpnvxO2+8R6Kc/bD
 b6f7PAG5F7X6VTs68m5mYLO7PZxfMBVW3mK5ZOFP69JQDMduJNpHCoAEYYjmiD3vpSXt10020Cke+
 oj9wXU5ozAOfZ5UF+Cfu+M/FBXFvoRicHx4jfj2yhBlYyRMovqdh26X1VIwMIqugg8HokT7bVqDwm
 pfOwH1qkQZQuh1cfKVqO+SJVwnhMht3wZ3+yVxUE/WR5r9RmXPWgj7ezxGKRX4z+nRIdLXe98p6Md
 Sqavpgp67e8iI0DP4RKvSF5zmeyT4iRWOChl0fNxk/NyPHWAwANUJ2v0XTZKXnZlGK8MUVtDZa/3/
 M6r/6VthlokiwPA+kykTHjtUkSpYakGs0iuBHcfm3YdQ+DUWoPER0ehvKWQBK+DGzZYh9/Ok5NUaD
 gDNTOj5uppLQR3/FqmRpHE44a2Yxj7EBkcFX1LwLqyY8jxKXXVQsH6+f1NFDOUZD8LP3fnCrCvkV/
 QureB9ZIEhly/HswRTswa/QgBrbBzG/MjsTbZ4+kWZAMdxMeqSBdgOSJHjS9rgfRn1xvFAHxMnpE6
 Dkv0AUwJ2FAoX+D93PQAGru6brHJOJebgR6IuJV+rO7gQPHEoMEG5GOOb5iI0XuxWoVRQ/LAF9trk
 U3VRmds/2W0+7+z2uwbGQkb2hOQiwDtmUXwnlLeIo=;
Received: from [2a02:8012:c93d:0:260e:bf57:a4e9:8142]
 by mail.ilande.co.uk with esmtpsa (TLS1.3:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.92) (envelope-from <mark.cave-ayland@ilande.co.uk>)
 id 1ucNqD-0003ny-5C; Thu, 17 Jul 2025 13:36:01 +0100
Message-ID: <66ff0189-ade8-46fa-b8d5-903ebbf9091d@ilande.co.uk>
Date: Thu, 17 Jul 2025 13:37:34 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: Peter Maydell <peter.maydell@linaro.org>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Cc: qemu-devel@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>,
 Fam Zheng <fam@euphon.net>
References: <20250715061918.44971-1-philmd@linaro.org>
 <20250715061918.44971-15-philmd@linaro.org>
 <4319b447-5e85-4e14-8146-b8615d497171@linaro.org>
 <CAFEAcA_C16Ta0HT1i10RErmSOMJNuecHuDX=JDALn701+9YtpA@mail.gmail.com>
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
In-Reply-To: <CAFEAcA_C16Ta0HT1i10RErmSOMJNuecHuDX=JDALn701+9YtpA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 2a02:8012:c93d:0:260e:bf57:a4e9:8142
X-SA-Exim-Mail-From: mark.cave-ayland@ilande.co.uk
Subject: Re: [PULL 14/17] esp.c: only call dma_memory_read function if
 transfer length is non-zero
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

On 17/07/2025 12:58, Peter Maydell wrote:

> On Thu, 17 Jul 2025 at 12:51, Philippe Mathieu-Daudé <philmd@linaro.org> wrote:
>>
>> Hi Mark,
>>
>> On 15/7/25 08:19, Philippe Mathieu-Daudé wrote:
>>> From: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
>>>
>>> In the cases where mixed DMA/non-DMA transfers are used or no data is
>>> available, it is possible for the calculated transfer length to be zero.
>>> Only call the dma_memory_read function where the transfer length is
>>> non-zero to avoid invoking the DMA engine for a zero length transfer
>>> which can have side-effects (along with generating additional tracing
>>> noise).
>>>
>>> Signed-off-by: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
>>> Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
>>> Tested-by: Philippe Mathieu-Daudé <philmd@linaro.org>
>>> Message-ID: <20250711204636.542964-5-mark.cave-ayland@ilande.co.uk>
>>> Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
>>> ---
>>>    hw/scsi/esp.c | 20 +++++++++++++-------
>>>    1 file changed, 13 insertions(+), 7 deletions(-)
>>>
>>> diff --git a/hw/scsi/esp.c b/hw/scsi/esp.c
>>> index 62ba4061492..ec9fcbeddf4 100644
>>> --- a/hw/scsi/esp.c
>>> +++ b/hw/scsi/esp.c
>>> @@ -487,8 +487,10 @@ static void esp_do_dma(ESPState *s)
>>>        case STAT_MO:
>>>            if (s->dma_memory_read) {
>>>                len = MIN(len, fifo8_num_free(&s->cmdfifo));
>>> -            s->dma_memory_read(s->dma_opaque, buf, len);
>>> -            esp_set_tc(s, esp_get_tc(s) - len);
>>> +            if (len) {
>>> +                s->dma_memory_read(s->dma_opaque, buf, len);
>>> +                esp_set_tc(s, esp_get_tc(s) - len);
>>> +            }
>>>            } else {
>>>                len = esp_fifo_pop_buf(s, buf, fifo8_num_used(&s->fifo));
>>>                len = MIN(fifo8_num_free(&s->cmdfifo), len);
>>               }
>>               fifo8_push_all(&s->cmdfifo, buf, len);
>>
>> Coverity reported access to uninitialized buf[]:
>>
>>   >>>     CID 1612373:         Uninitialized variables  (UNINIT)
>>   >>>     Using uninitialized value "*buf" when calling "fifo8_push_all".
>>
>> Do you mind having a look?
> 
> I think this is a false positive (and marked it that way in
> the Coverity Scan UI). Coverity is complaining that
> we might access buf[] uninitialized, but in the code path
> it is complaining about we know that len is zero. The
> fifo8_push_all() does a "memcpy(&fifo->data[start], data, num)"
> and if num is 0 that is valid and won't access anything in buf[].
> 
> We could I suppose make fifo8_push_all() return early for the
> num == 0 case, just to make it clearer that it's supposed to work.

Thanks both!

I can certainly look to update fifo8_push_all() if you think it would be a better 
solution?


ATB,

Mark.


