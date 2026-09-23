Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A9373C98312
	for <qemu-devel@archiver.kernel.org>; Wed, 23 Sep 2026 20:23:52 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x9TUq-0003pl-Gy; Wed, 23 Sep 2026 16:23:16 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mark.cave-ayland@ilande.co.uk>)
 id 1x9TUp-0003p1-0D; Wed, 23 Sep 2026 16:23:15 -0400
Received: from mail.ilande.co.uk ([2001:41c9:1:41f::167])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mark.cave-ayland@ilande.co.uk>)
 id 1x9TUn-00042G-EF; Wed, 23 Sep 2026 16:23:14 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=ilande.co.uk; s=20220518; h=Subject:Content-Transfer-Encoding:Content-Type:
 In-Reply-To:From:References:To:MIME-Version:Date:Message-ID:Sender:Reply-To:
 Cc:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID;
 bh=AWszdhNscdtrj4UAGp+nwiNXDzOk+Qqv7jM3T+042IQ=; b=yCBTnmh8aJuqdsyZMWKCsATT8l
 8DKxr9itwDZejI9ui0cwa2FbOTHVHgwKTr8h2IH3rH8x6e1rBu3wa477Y2vnIGIaqYDDbJDP0sUMl
 hEn8ZaywfpxjF3h0nKubjLqWbgSYui9fNePe7n7lYXPAG2WUSp4njaNJAIk7jDTsCIS5VWISkYIKp
 LriwBphjn7mRueIhsmrTxC3UyYBkQsbk5p7+U4AjX+b2aQGBCgwRChHVDJjVgyTr45YQn/yoVBV+C
 GbOvX/Bacv2TPKAXtRRJ0k9z5tJtvbLRrOck6NL2YuJWLIXHlenlIP6ywmMBD7mOb6hvvcGVqRXkp
 OPM2mc0uGexfD62LS6X8ZBGwjoKqipy1KoOlvFqKiQJ9trA0Yrs78g4e6aoFqO//mqPUccUrPjEUU
 ii2yKtsS6NU51x7C+ZyRuzNUD9M7hSfVDGhiXkL0W4A+c2oDnQoDJsM1+NVKKGPfur4m34zljL5yH
 geS0ytXEBieDvve/D3hUqPO9hEARjEY7sJb75Bpji2DUhwHEy7PAjGkVeOJXDvipybvip5Aug3xqz
 j5UTIyjKaJUdzoO3FGjMyK5ch3S4ZwAcruuA3cXqUio/8UKAY9kwiTo3vaVgOLxIxd6yZwlzT9Csx
 DssmxjxZRa29OjdPH7xPadrvMxhO1mCPoyMqTDKr4=;
Received: from [2a02:8012:2f01:0:fe49:60b9:9856:b8ef]
 by mail.ilande.co.uk with esmtpsa (TLS1.3) tls
 TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256 (Exim 4.94.2)
 (envelope-from <mark.cave-ayland@ilande.co.uk>)
 id 1x9TUC-00FQWv-96; Wed, 23 Sep 2026 21:22:36 +0100
Message-ID: <48a6f19b-525d-487c-a40b-b9f4120e51ab@ilande.co.uk>
Date: Wed, 23 Sep 2026 21:23:05 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: rathc@linux.ibm.com, npiggin@gmail.com, milesg@linux.ibm.com,
 harshpb@linux.ibm.com, qemu-devel@nongnu.org, qemu-ppc@nongnu.org,
 "Kirill A. Korinsky" <kirill@korins.ky>
References: <20260903115229.95811-1-kirill@korins.ky>
 <20260903115229.95811-5-kirill@korins.ky>
 <71fb85ee-3cb8-4201-b470-d481a5b24fb4@ilande.co.uk>
 <87fqz6uyb6.wl-kirill@korins.ky>
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
In-Reply-To: <87fqz6uyb6.wl-kirill@korins.ky>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-SA-Exim-Connect-IP: 2a02:8012:2f01:0:fe49:60b9:9856:b8ef
X-SA-Exim-Mail-From: mark.cave-ayland@ilande.co.uk
Subject: Re: [PATCH 4/5] cuda: Make shift register delay configurable
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

On 18/09/2026 20:58, Kirill A. Korinsky wrote:

> On Fri, 18 Sep 2026 15:27:09 +0200,
> Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk> wrote:
>>
>> On 03/09/2026 12:50, Kirill A. Korinsky wrote:
>>
>>> The CUDA model assumes a 20 microsecond delay before each shift
>>> register interrupt. OpenBSD times out during device discovery with that
>>> timing, so retain the existing default but allow an override.
>>
>> This is curious: 20us is effectively nothing, but we need a slight delay
>> otherwise MacOS 9 fails to read from the CUDA device (maybe one day I
>> will analyse the code to understand why this is the case).
>>
>> Can you explain a bit more why 20us is enough to cause a timeout but only for OpenBSD?
>>
> 
> If I recall right it right, it ends that I run Qemu on OpenBSD host and here
> hz=100 and ppoll() sleep in host's timeout between ticks. What makes it that
> sleep something like 10 or 20 ms.
> 
> so, 20us is nothing, but on OpenBSD host it turns to larger value 20-40 ms,
> and it was enough to reach a timeout.
> 
> This is why I added a way to switch off that delay.

I'm still surprised why this only occurs on an OpenBSD host, but I think the way 
forward is to mark the property name as experimental by adding an x- prefix so people 
are aware that it may disappear in future when we really figure out what is going on.

I see that Anushree has a comment and a suggested change for your decrementer patch: 
if that works, please send out a v2 series and if it looks good, I'll queue it via my 
qemu-macppc branch.


ATB,

Mark.


