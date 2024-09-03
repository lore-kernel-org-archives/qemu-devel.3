Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 07C12CD13CF
	for <qemu-devel@archiver.kernel.org>; Tue,  3 Sep 2024 12:16:26 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1slSRs-0003eq-Qk; Tue, 03 Sep 2024 08:15:52 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mark.cave-ayland@ilande.co.uk>)
 id 1slSRq-0003eB-Cj
 for qemu-devel@nongnu.org; Tue, 03 Sep 2024 08:15:50 -0400
Received: from mail.ilande.co.uk ([2001:41c9:1:41f::167])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mark.cave-ayland@ilande.co.uk>)
 id 1slSRo-00047P-IN
 for qemu-devel@nongnu.org; Tue, 03 Sep 2024 08:15:50 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=ilande.co.uk; s=20220518; h=Subject:Content-Transfer-Encoding:Content-Type:
 In-Reply-To:From:References:Cc:To:MIME-Version:Date:Message-ID:Sender:
 Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender
 :Resent-To:Resent-Cc:Resent-Message-ID;
 bh=Q2ByrsNmFU8JiBfegcpIeER8NacelVBDe7SzgH5y/Fg=; b=mmfzkABB8ET3OwwteQnpmotEHi
 SzrbIMO+JQ0DoYYRrUwPdmOppzgbReB15T13NBmsREoU3wFQRUAvHNlceg6Ew6zaQGTaivbbO4Ev4
 zcq3VJcThoM+GhmF13DZTxZREXmM6khT0yRQf2bVG/uVSyWTG7kRFI4BfCmfHtElI8hjtwNugrX7J
 NF9ka7a95/hh3VBmvfQZ0nSmICVWBi6Z/vrA9HYwlDHxxCr8M+tYLZojjzAa5iHrbchnhIl4T9pc7
 RO86gdA26qtAkjW9G7wQ8Xolc8GZNmbjdxD5kCB+oujrtQLigTZ5JCEWiUGUUCu/OeWbrog7UvhXy
 LNLGPHyvPAoS8CM3PsDXCKhaLsP0RjKAvXQFUiXbaQb7KO8CN4xCJnK3u/7o9lh2gOWHiYqv7hxSd
 AAgk5uKReKEDIprVnQnqI6vzpWONmkvXi/xzOdzAgiUiTWTmb4OSs7bu7MvG26RGidQ2LH9HuoOwt
 kZzOBu4sRWljqY5wPN9wwDQ0JohdXwlE7UpVVa5nq/XtsvohsFRIC6uMoJaQI0xAf+L725VFQZT3I
 g9+qSY+93BufTU4NKYVxPTrkSsp5rRdCtlButAylBwPvVHXmZ/9Ddp5aV/ifJOU+i07cHTERmbHSW
 PXzzdbp51nJe3GKswzyQzqx8oEYQsiAdUm1uOwLsA=;
Received: from [2a02:8012:c93d:0:260e:bf57:a4e9:8142]
 by mail.ilande.co.uk with esmtpsa (TLS1.3:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.92) (envelope-from <mark.cave-ayland@ilande.co.uk>)
 id 1slRrM-0004ts-NC; Tue, 03 Sep 2024 12:38:09 +0100
Message-ID: <5e447f9d-3517-4af9-a382-a0a44f24adf9@ilande.co.uk>
Date: Tue, 3 Sep 2024 12:38:04 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: Carl Hauser <chauser@pullman.com>
Cc: marcandre.lureau@redhat.com, pbonzini@redhat.com, qemu-devel@nongnu.org
References: <20240902213816.89071-1-mark.cave-ayland@ilande.co.uk>
 <CABJXFgUxPWkbynMWZW_i20KDSetu1ucWWMFha7vk5+=GE9_vYA@mail.gmail.com>
 <CABJXFgWEL0M+1UuyTX6UajwMMzLjhKD+qBkTDG20BudakKPcmw@mail.gmail.com>
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
In-Reply-To: <CABJXFgWEL0M+1UuyTX6UajwMMzLjhKD+qBkTDG20BudakKPcmw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-SA-Exim-Connect-IP: 2a02:8012:c93d:0:260e:bf57:a4e9:8142
X-SA-Exim-Mail-From: mark.cave-ayland@ilande.co.uk
Subject: Re: [PATCH] escc: convert Sun mouse to use QemuInputHandler
X-SA-Exim-Version: 4.2.1 (built Wed, 08 May 2019 21:11:16 +0000)
X-SA-Exim-Scanned: Yes (on mail.ilande.co.uk)
Received-SPF: pass client-ip=2001:41c9:1:41f::167;
 envelope-from=mark.cave-ayland@ilande.co.uk; helo=mail.ilande.co.uk
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=unavailable autolearn_force=no
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

On 03/09/2024 02:33, Carl Hauser via wrote:

> Well, I was wrong -- it is sending a duplicate mouse packets when the mouse wheel is 
> rotated. The packets correctly represent the mouse buttons state. I just now 
> discovered that one of my Logitech mice sends continuous mouse events when the wheel 
> is rotated half a notch and held there. Another Logitech mouse doesn't do that but 
> does send multiple (6-10) events per notch. A Microsoft mouse sends 2 events per notch.
> 
> I don't know where these should be suppressed. Mouse wheel rotation of a host mouse 
> shouldn't send anything to the emulated Sun mouse. I suspect that the unwanted host 
> events are propagating down to escc via calls to sunmouse_sync. So is sunmouse_sync 
> where they should be filtered out? Probably, because the calling code is not specific 
> to sunmouse and for other mice those calls are needed.

Ah so it's from the events generated by the mouse wheel? I think we can safely assume 
that Sun never produced any wheeled serial mice, in which case it should be possible 
to filter those events out before they get to the guest.

I should have a bit of time later today to make the relevant changes and send out a 
v2 patch.


ATB,

Mark.


