Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 687E5CED628
	for <qemu-devel@archiver.kernel.org>; Wed,  9 Oct 2024 08:41:58 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sySG8-0004sC-B5; Wed, 09 Oct 2024 04:41:28 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mark.cave-ayland@ilande.co.uk>)
 id 1sySG3-0004rl-2f; Wed, 09 Oct 2024 04:41:23 -0400
Received: from mail.ilande.co.uk ([2001:41c9:1:41f::167])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mark.cave-ayland@ilande.co.uk>)
 id 1sySG1-0001gc-M2; Wed, 09 Oct 2024 04:41:22 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=ilande.co.uk; s=20220518; h=Subject:Content-Transfer-Encoding:Content-Type:
 In-Reply-To:From:References:Cc:To:MIME-Version:Date:Message-ID:Sender:
 Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender
 :Resent-To:Resent-Cc:Resent-Message-ID;
 bh=SQJmJ7gCi0nmN7oos+CcdHoJLAwgIy/4udl7e5kb3IE=; b=quhDT7suu0/KBt+gwLJZT0iXKI
 4oyT641+LMTqMBMY9S8wWhiA2Vtb9jvSKZP2wRnduvDTu0AmE66k1PZru7rcodOTU7FYBdKmpEUdG
 UVYnQaOQkwARVbB0HcqYBOyG/5mJ/ElJWswwGDkUfvcDfh88+IGsZXolrjLpMzVu+/Ylah5LEiabf
 KnFmeiX4+sFwr4BtHUZ129ZEzR7Ymp1wdLc3jQaki5AWzYrgd0kswuzCtypq7k+chC5XRycmHFaSP
 I8wcWbPTdtoGLr/vTdchcPLJmfRiSl8Mbjb4N3sm993iKwgTIcxC1sDZNOfRtlOg42mjs0PWf/STg
 VDwS3sj5hBXVS4kzVQUIATrzZhW0i6TsQD0sBGslOhMll27UEaFOJlCcYyjkHhONq6SaRxJ39xhef
 wxh3rYINQjdjmX84wLHMpW5bHuHsXriOul9X8qVXrX++bnFWmuC0gNkMwvKg+ze/7VuMdJ4dbP6Du
 U7H8B3imJaf+BcS5UHoHcu8+YsjAX8rEHoErYtbczhvzGk5MbjqpGxzxsVxXTAfZqNDIK8T8bxehL
 5iWRLuhhJZ3B2UU/q3JGAWRRBUrwkA0EO4hSc3lY1Hf8XdNnBfDJAxS9dBCrNUs9kXU+1MEIMtAM1
 7zpA7lJQRqaAYvslHSW7feSjIJ/a8XJbAF/0bWk20=;
Received: from [2a00:23c4:8bb8:7000:6d0:70a6:da7e:f9a3]
 by mail.ilande.co.uk with esmtpsa (TLS1.3:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.92) (envelope-from <mark.cave-ayland@ilande.co.uk>)
 id 1sySFk-00098L-IJ; Wed, 09 Oct 2024 09:41:08 +0100
Message-ID: <ea96f1e9-8bb2-4547-8835-a8ed2d0ab298@ilande.co.uk>
Date: Wed, 9 Oct 2024 09:41:11 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: Octavian Purdila <tavip@google.com>
Cc: qemu-devel@nongnu.org, qemu-arm@nongnu.org, stefanst@google.com,
 pbonzini@redhat.com, peter.maydell@linaro.org, marcandre.lureau@redhat.com,
 berrange@redhat.com, eduardo@habkost.net, luc@lmichel.fr,
 damien.hedde@dahe.fr, alistair@alistair23.me, thuth@redhat.com,
 philmd@linaro.org, jsnow@redhat.com, crosa@redhat.com, lvivier@redhat.com
References: <20241008011852.1439154-1-tavip@google.com>
 <20241008011852.1439154-2-tavip@google.com>
 <7994769f-efed-4eff-aac7-aa3828f603b7@ilande.co.uk>
 <CAGWr4cT=UWvk_v=908bhdbrg61tz8pgpa14_K+vps0d0sTZTJQ@mail.gmail.com>
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
In-Reply-To: <CAGWr4cT=UWvk_v=908bhdbrg61tz8pgpa14_K+vps0d0sTZTJQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 2a00:23c4:8bb8:7000:6d0:70a6:da7e:f9a3
X-SA-Exim-Mail-From: mark.cave-ayland@ilande.co.uk
Subject: Re: [PATCH v2 01/25] fifo32: add peek function
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

On 08/10/2024 18:25, Octavian Purdila wrote:

> On Tue, Oct 8, 2024 at 4:27 AM Mark Cave-Ayland
> <mark.cave-ayland@ilande.co.uk> wrote:
>>
>> On 08/10/2024 02:18, Octavian Purdila wrote:
>>
>>> Add fifo32_peek() that returns the first element from the queue
>>> without popping it.
>>>
>>> Signed-off-by: Octavian Purdila <tavip@google.com>
>>> ---
>>>    include/qemu/fifo32.h | 28 ++++++++++++++++++++++++++++
>>>    1 file changed, 28 insertions(+)
>>>
>>> diff --git a/include/qemu/fifo32.h b/include/qemu/fifo32.h
>>> index 4e9fd1b5ef..9de1807375 100644
>>> --- a/include/qemu/fifo32.h
>>> +++ b/include/qemu/fifo32.h
>>> @@ -140,6 +140,34 @@ static inline uint32_t fifo32_pop(Fifo32 *fifo)
>>>        return ret;
>>>    }
>>>
>>> +/**
>>> + * fifo32_peek:
>>> + * @fifo: fifo to peek at
>>> + *
>>> + * Returns the value from the FIFO's head without poping it. Behaviour
>>> + * is undefined if the FIFO is empty. Clients are responsible for
>>> + * checking for emptiness using fifo32_is_empty().
>>> + *
>>> + * Returns: the value from the FIFO's head
>>> + */
>>> +
>>> +static inline uint32_t fifo32_peek(Fifo32 *fifo)
>>> +{
>>> +    uint32_t ret = 0, num;
>>> +    const uint8_t *buf;
>>> +
>>> +    buf = fifo8_peek_bufptr(&fifo->fifo, 4, &num);
>>
>> Are you sure that you want to use fifo8_peek_bufptr() as opposed to fifo8_peek_buf()
>> here? The reason for using the latter function (and why fifo8_*_bufptr() functions
>> are not generally recommended) is that they will correctly handle the FIFO wraparound
>> caused by the drifting head pointer which can occur if you don't empty the entire
>> FIFO contents in a single *_pop() or *_pop_buf() operation.
>>
> 
> I don't think that it matters in this case because the size of the
> FIFO is always going to be a multiple of 4 and all push and pop
> operations happen with 4 bytes as well. Am I missing something?
> 
> In any case, if it makes things more clear / consistent I can switch
> to fifo8_peek_buf.

I'm guess I'm just a little bit wary of the Fifo32 API since it appears that 
fifo32_num_used(), fifo32_num_free() and fifo32_is_full() are written in a way that 
suggests unaligned accesses can occur.

Given that fifo8_push() and fifo8_pop() should assert() upon failure I don't think 
that's possible for Fifo32, but then all my test cases use Fifo8.

If you're confident from your tests that this can't happen then we can leave it as-is.


ATB,

Mark.


