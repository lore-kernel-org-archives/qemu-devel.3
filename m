Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3791E606D826
	for <qemu-devel@archiver.kernel.org>; Tue,  3 Nov 2026 23:46:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (4096-bit key, unprotected) header.d=ilande.co.uk header.i=@ilande.co.uk header.a=rsa-sha256 header.s=20220518 header.b=Hr9jSZJg
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xOOCL-0002XS-86; Tue, 03 Nov 2026 18:45:49 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mark.cave-ayland@ilande.co.uk>)
 id 1xOOCI-0002Wt-5E
 for qemu-devel@nongnu.org; Tue, 03 Nov 2026 18:45:46 -0500
Received: from mail.ilande.co.uk ([2001:41c9:1:41f::167])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mark.cave-ayland@ilande.co.uk>)
 id 1xOOCG-00009z-6V
 for qemu-devel@nongnu.org; Tue, 03 Nov 2026 18:45:45 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=ilande.co.uk; s=20220518; h=Subject:Content-Transfer-Encoding:Content-Type:
 In-Reply-To:From:References:To:MIME-Version:Date:Message-ID:Sender:Reply-To:
 Cc:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID;
 bh=iFQwzfoVUAoJD63ZZ0Dvh7apjaNskI6Q0kVHzF3CX9Q=; b=Hr9jSZJgTMArxHFwbOqPoVcdXS
 LkRCY4Wtw5yObx90Qsu2duVatozGOnk2n5mWTqvMGdyyB4Rb6FDw6cZni9w71HMHz5MZLSMEy15sE
 uPRlQkalsNZGXkU2YdIqbUm4rxR+2gB/Q9jlKWEwME1Rk/0vkaKZlYC4giVf3ErhEyl4z6oxw3/pd
 4HnZTowws03DfjgTZ7UWiLcgcIZODS4TSeR1VQ2RZJsuJ7VVdPCSF3T4P5KGEYPPadWr1ckHjCahj
 eRqeHDDDskFSBhydor8TC7Lhd3TBH3CIVRbL04b68pAS0Y3t0gd2kcuOBGEmY9E1t5Uq7tnhN1dIe
 ev4stSgz6dLPDznPfQiHkQSNmfiLZBgdFcQL4dX58ttm0vGOTXCurv9PxfG4nUJLg3xhT149Ecevf
 rgjgSUKCdGsVc80qzbxVCzWyQbxgWrWWQCR1ydPDHEODwjoMFw4jCgxxGZqXuI22cwdRXlqOFaCBw
 GM7DfeE7KYmQ4HE02+A7n8sZsAZG8OkPriN3tRgrsboritd+NOcbie22DqJyNRW3K6UoYXbl0F1Zt
 K38wI63C8ahj0nlEmxFHvcBIHgKKkghlb89RPLsfuAJDucxEKfOLEdba7fGGZ8KOlo6nysQPUWOA1
 H5lNa2GVdFki2/NZBx71zx/ZXBCVvD7WCLE7QPhkI=;
Received: from [2a02:8012:2f01:0:fe49:60b9:9856:b8ef]
 by mail.ilande.co.uk with esmtpsa (TLS1.3) tls
 TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256 (Exim 4.94.2)
 (envelope-from <mark.cave-ayland@ilande.co.uk>)
 id 1xOOBS-005Ze6-GL; Tue, 03 Nov 2026 23:44:54 +0000
Message-ID: <3aa138a5-0f50-450f-a46f-a449a754c96b@ilande.co.uk>
Date: Tue, 3 Nov 2026 23:45:39 +0000
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: Paul Sheer <paulsheer@gmail.com>, qemu-devel@nongnu.org
References: <CABxOuY-6JxS1+HcR0t-yteY2+S7saB8ogjxkqa7bedwKu2Xw+Q@mail.gmail.com>
 <CABxOuY8+YibOXCTTkcAQKHLVsTP_1twb0tNxmRss_Se56=amiw@mail.gmail.com>
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
In-Reply-To: <CABxOuY8+YibOXCTTkcAQKHLVsTP_1twb0tNxmRss_Se56=amiw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 2a02:8012:2f01:0:fe49:60b9:9856:b8ef
X-SA-Exim-Mail-From: mark.cave-ayland@ilande.co.uk
Subject: Re: Solaris 10 on SPARC 64 running, but not stable
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
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
X-Spam-Status: No, score=-10.1 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_PASS,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On 30/10/2026 16:38, Paul Sheer wrote:

> Update:
> 
> I put my changes in these two forked repos:
> 
> https://github.com/paulsheer/qemu/ <https://github.com/paulsheer/qemu/>
> https://github.com/paulsheer/openbios/ <https://github.com/paulsheer/openbios/>
> 
> I don't have more time to try get this stable, so I will be unsubscribing.
> 
> Happy to answer any questions on my private email.
> 
> Paul
>  
> On Mon, Oct 26, 2026 at 12:25 AM Paul Sheer <paulsheer@gmail.com 
> <mailto:paulsheer@gmail.com>> wrote:
> 
> 
>     Hello,
> 
>     I dumped the entire disk of a real Solaris 10 V210/V240 box into a qcow2 image on
>     Linux,
>     and then tried to boot it with qemu.
> 
>     The list of patches/fixes I needed to apply is very long --- beside a bunch of
>     code changes, there is also changing from SCSI to IDE and from hme0 to e1000,
>     getting the device mappings to work, and so on.
> 
>     It finally boots all the way through and starts its services and I can ssh into it.
> 
>     However it doesn't seem to be stable. Within an hour it silently stops.
> 
>     Is anyone interested in this kind of work?
> 
>     Has anyone got this to run stable and under load?
> 
>     [[The only reason I keep this V210 around is to occasionally test some software
>     big-endian (not that easy these days with big-end boxes disappearing 😂). But I
>     panicked when I had to replace the motherboard last week "...what if this box
>     one-day becomes unrepairable?" -- hence my experimenting with qemu.]]
> 
>     If anyone is interested then contact me directly on paulsheer@gmail.com
>     <mailto:paulsheer@gmail.com> and I will share all the changes I made.
> 
>     Kind regards,
> 
>     Paul
Hi Paul,

Thanks for this interesting work! I currently don't have the bandwidth myself to take 
on a project of this size, however I can see that at the very least this is an 
excellent reference to have available. And of course, if someone else would like to 
resolve the outstanding issues and submit the patches on your behalf then that is 
always an option too :)


ATB,

Mark.


