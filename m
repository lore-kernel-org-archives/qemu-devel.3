Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8122ED2AB3B
	for <qemu-devel@archiver.kernel.org>; Tue, 29 Oct 2024 12:52:28 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t5lhl-00006o-Ce; Tue, 29 Oct 2024 08:52:13 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mark.cave-ayland@ilande.co.uk>)
 id 1t5lhU-0008RU-20
 for qemu-devel@nongnu.org; Tue, 29 Oct 2024 08:52:01 -0400
Received: from mail.ilande.co.uk ([2001:41c9:1:41f::167])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mark.cave-ayland@ilande.co.uk>)
 id 1t5lhS-0003SV-8F
 for qemu-devel@nongnu.org; Tue, 29 Oct 2024 08:51:55 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=ilande.co.uk; s=20220518; h=Subject:Content-Transfer-Encoding:Content-Type:
 In-Reply-To:From:References:Cc:To:MIME-Version:Date:Message-ID:Sender:
 Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender
 :Resent-To:Resent-Cc:Resent-Message-ID;
 bh=OAyJepC+e7zGhnl0SDdF9d0gegPEtcKzCQRlT4wx1mk=; b=bvJq+Rus0ZhB+DwgybzweUjpAp
 98mogO9980w72nTHG+kFNHV/8r4WAsjVIMPfe3sdZkgyecZzdBpBx2WsgV4AdKpLCd+37oyJfuQ7T
 UJ0tESsNJZlnuZFfgFTlBWBF4aCvyKeaSIP615Nu2EHxq0AA3+GQdg+IcVRZXvgKPvRK9GApsSkqn
 mTKinfQnHpiVioGQJW0u9V8e1axOqmYqEn1Z8yqmVA/9DpPVvpG5aqTl+v39eNNF5/eVUMmgHnX4M
 tV/nJgQONs6JYVok0/lJZ9K2pwpUQd6W9ecdss9EC8s58vCCzjzh5C5Q2a0fbS+gP4scEQflQ7Dbj
 RVeMlLL6Swuf8jCe5aSa30zmW98stQRcWUefSi+ZGl+z+clau4DfwTmsB6VHrvLWIqQ7frXPTDAQi
 uAV20+fe9Yk21tiJKWVCkv+L/7mV1DfmIjKewHsP5hbf8wevobC4ebvyvQsFS2P17aLVapAl5su7D
 kpHRxl0f0xaDtXnHCfWXyzoY9/QYYltcaPU+FrK2A6zEiwmaVrf392wi9bsvj9KLraGnRErFEjSAI
 8XxWBCawaFhacyqzhb/m76WCmAm+Nmm7oQsRzN1vAOhOFPMcxbSteZeZ73JbcOIAPOSP6ZaGFeuoP
 8EP41mRVfjCMjAlIu53GTJ9sNNC5DkHqhUihN1m2g=;
Received: from [2a02:8012:c93d:0:260e:bf57:a4e9:8142]
 by mail.ilande.co.uk with esmtpsa (TLS1.3:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.92) (envelope-from <mark.cave-ayland@ilande.co.uk>)
 id 1t5lh3-0000Qd-4C; Tue, 29 Oct 2024 12:51:33 +0000
Message-ID: <74b53c6c-d239-42fe-97ce-93f52c10c1cf@ilande.co.uk>
Date: Tue, 29 Oct 2024 12:51:42 +0000
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: Peter Maydell <peter.maydell@linaro.org>
Cc: huth@tuxfamily.org, qemu-devel@nongnu.org
References: <20241023085852.1061031-1-mark.cave-ayland@ilande.co.uk>
 <CAFEAcA9XK85TBHmty5WJRtwTtX-0--bgNKXitTpxs6t7jpqj0A@mail.gmail.com>
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
In-Reply-To: <CAFEAcA9XK85TBHmty5WJRtwTtX-0--bgNKXitTpxs6t7jpqj0A@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-SA-Exim-Connect-IP: 2a02:8012:c93d:0:260e:bf57:a4e9:8142
X-SA-Exim-Mail-From: mark.cave-ayland@ilande.co.uk
Subject: Re: [PATCH 00/36] next-cube: more tidy-ups and improvements
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

On 29/10/2024 11:22, Peter Maydell wrote:

> On Wed, 23 Oct 2024 at 09:59, Mark Cave-Ayland
> <mark.cave-ayland@ilande.co.uk> wrote:
>>
>> This series contains a number of tidy-ups and improvements to the NeXTCube machine
>> which include:
>>
>>    - Bringing the code up-to-date with our latest coding standards/APIs, in particular
>>      related to the board configuration and IRQ wiring
>>
>>    - Remove the remaining overlapping memory regions and consolidating multiple
>>      register implementations into a single place
>>
>>    - Add a new next-scsi device containing the ESP device and its associated
>>      CSRs
>>
>>    - Adding the empty_slot device to fill unimplemented devices and removing
>>      the "catch-all" next.scr memory region
>>
>>    - QOMifying the next-rtc device and wiring it up with gpios as required
>>
>> The next-cube machine looks in fairly good shape now, the main remaining work is to
>> create a separate device for the DMA controller and update the wiring of the IRQs
>> (including to the CPU) accordingly.
> 
> Would you have time to consider updating hw/m68k/next-kbd.c
> to stop using qemu_add_kbd_event_handler()? It's the only
> user left in the codebase of that input-legacy.c API.
> Generally using qemu_input_handler_register() should simplify
> the code because it will no longer need to decode multi-byte
> PS2 code sequences back into "what is the single key event
> that this corresponds to?". Commit ff7888dcc6c701 is an
> example of the conversion (though that input device
> is somewhat simpler than a full real keyboard).

Sure, I'll have a look and see if I can manage it - removing legacy APIs is always a 
good thing :)


ATB,

Mark.


