Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B525BC43458
	for <qemu-devel@archiver.kernel.org>; Tue, 14 Jul 2026 21:44:32 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wjkuz-0000Ff-SH; Tue, 14 Jul 2026 17:43:57 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mark.cave-ayland@ilande.co.uk>)
 id 1wjkux-0000FS-T4
 for qemu-devel@nongnu.org; Tue, 14 Jul 2026 17:43:55 -0400
Received: from mail.ilande.co.uk ([2001:41c9:1:41f::167])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mark.cave-ayland@ilande.co.uk>)
 id 1wjkuw-00007P-1s
 for qemu-devel@nongnu.org; Tue, 14 Jul 2026 17:43:55 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=ilande.co.uk; s=20220518; h=Subject:Content-Transfer-Encoding:Content-Type:
 In-Reply-To:From:References:Cc:To:MIME-Version:Date:Message-ID:Sender:
 Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender
 :Resent-To:Resent-Cc:Resent-Message-ID;
 bh=oyNP+TMz9Rg5rPnY5RpnXoU3d2NpBRzPjMH+K9lsAJc=; b=AMW/LEkMwdSdrCrHh1eTC8p4xT
 VUkBVb8ynI38K8NrNmCiOqYfRko6rhzyE8dW8Yc1yXSqFm6FSFRBt3XUpEs87hiNsobyAy+UV2694
 Edi+Iseoti8xBlGAr7vmtx2cJ2ZJFxYDxaCG3S0c9SkWYssf5cMEYE/qv1AVzoT+pS4OckWXh2r4O
 kHSHugRthSvPoPONVQe1vPp4k5TT0qbAyJn2ATuR8ZsdnbT9B2feIXj5XiSDI/7ZMioZzPa6EO/qm
 iaM/sXkOOJHwT5FYP1RCPTVpApuQH8GRl33lmRQXFXzBtVdGDBOGT8f6IGFhsFO8VyuSLUvgsjacZ
 1RiB4ZK+8PxiVqyT3Us86lNdNpw+ploUM5ltC+JrRN5OhCAOpy8qyA6mt5qz8lm1omJOiNj2zPFU8
 HElCjEXoCAZ+YmvruoZAma25tBgK1cE2SksA3ZjNzJNLLgWhzcE8I1bDcT4fdO2AWooskX6ThcZra
 bvuwOi5ErpnwodAMgUznqeoRSiqFgm0mCrOzVkq1nvws/2URa+U6aeOCg/jGt0sirZX5kQVDWSPpf
 Q74muQllXTR4dKY9ivjSYLZVBOInE35cHMGp9Ua3ymMQqvHfcxMkxoWv97+Q8VY3TLeJcpeATp3Lq
 0AOBjmDyZlvZRj98oEjF5EV8YyJk7gUp1RaPZefOE=;
Received: from [2a02:8012:2f01:0:15be:353c:5920:3156]
 by mail.ilande.co.uk with esmtpsa (TLS1.3) tls
 TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256 (Exim 4.94.2)
 (envelope-from <mark.cave-ayland@ilande.co.uk>)
 id 1wjkuk-002fYC-Pl; Tue, 14 Jul 2026 22:43:43 +0100
Message-ID: <648c72c6-48bd-4725-b9d9-862c0dd95e73@ilande.co.uk>
Date: Tue, 14 Jul 2026 22:43:45 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: Keith Monahan <keith@techtravels.org>,
 Peter Maydell <peter.maydell@linaro.org>
Cc: qemu-devel@nongnu.org, Richard Henderson <richard.henderson@linaro.org>,
 Helge Deller <deller@gmx.de>, Paolo Bonzini <pbonzini@redhat.com>,
 Fam Zheng <fam@euphon.net>, BALATON Zoltan <balaton@eik.bme.hu>
References: <20260701213359.1855870-1-keith@techtravels.org>
 <20260701213359.1855870-4-keith@techtravels.org>
 <CAFEAcA_3vf5vrwoO0cGcdTsykU8uTf8386oyWki3iQ3Bje9Trw@mail.gmail.com>
 <8d3f679a-3039-404e-879d-b97e1b58e090@techtravels.org>
 <CAFEAcA-s2xYKG5PiUqFufdgJgMxD1OccbHO9zcCH2+aXwkK70Q@mail.gmail.com>
 <74e5958d-58d8-4519-82dc-52e598eb6d68@techtravels.org>
 <da5290cf-f695-4107-abb6-63d435fefc9f@techtravels.org>
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
In-Reply-To: <da5290cf-f695-4107-abb6-63d435fefc9f@techtravels.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-SA-Exim-Connect-IP: 2a02:8012:2f01:0:15be:353c:5920:3156
X-SA-Exim-Mail-From: mark.cave-ayland@ilande.co.uk
Subject: Re: [PATCH v2 3/4] hw/scsi/ncr53c710: rewrite the SCRIPTS engine
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

On 04/07/2026 18:17, Keith Monahan wrote:

> Can I get some eyes on this approach please?
> 
> Here's my proposal to break up this large rewrite in reviewable sized chunks:
> 
> 1. lasi_ncr710: remove dead and shadowing defines
> 2. lasi_ncr710: compute hw identifiers instead of caching them
> 3. ncr53c710: remove the redundant standalone SysBus device
> 4. ncr53c710: prepare state, register names and tracepoints
> 5. ncr53c710: rewrite the status and message phase handlers
> 6. ncr53c710: rewrite reselection, queueing and the data completion path
> 7. ncr53c710: rewrite the register read path
> 8. ncr53c710: rewrite the register write path and soft reset
> 9. ncr53c710: rewrite the SCRIPTS execution engine
> 10. ncr53c710: complete cached-backend transfers asynchronously
> 11. ncr53c710: support HP-UX overlapped tagged commands
> 12. ncr53c710: extend MESSAGE REJECT handling for HP-UX
> 
> To be clear, I will be modifying ncr53c710.c in place. And, of course, modifying the 
> other files as necessary. Those changes are minimal.
> 
> Every patch will buildable. There is a non-booting window between patches 5-8 as the 
> new helpers must land before the new loop that matches them, so the device compiles 
> but can't drive I/O until they reconverge.
> 
> How does this sound?
> 
> Keith

Hi Keith,

Thank you for your contribution to QEMU. I found myself in a similar situation a 
couple of years back when I ended up reworking a large part of the ESP SCSI emulation 
to fix some fairly obscure edge cases booting Classic MacOS, so I understand how 
difficult a task this can be.

If you would like to take a look at my series and cover letter then you can find it 
at https://patchew.org/QEMU/20240112125420.514425-1-mark.cave-ayland@ilande.co.uk/, 
but I've summarised some thoughts below based upon my experience:

   - I focused on using a small set of reference images and made sure they would
     boot upon every commit. This was really helpful as sometimes even a subtle code
     movement would cause something to break unexpectedly, and helped me to find
     extra edge cases I had missed.

   - Keep changes to individual devices in separate commits where possible, and also
     the same goes for refactoring/renaming commits and changes to the device
     logic/functionality. Often these commits can be merged earlier than later
     patches in the series where the reviewer may have more questions.

   - Not all reviewers are familiar with SCSI, so writing a good cover letter
     explaining each part of the series will help reviewers understand the changes
     during review.

   - Run your local tests in both a normal and --enable-debug build, and also with
     asan (--enable-asan) to catch any memory errors

   - Adding a functional test if possible would help prevent future regressions.

Similarly for reviewers I should note that the LSI SCRIPTS engine is quite complex: 
in effect it is almost like a separate processor executing its own programs (SCRIPTS) 
to perform I/O.

As I remarked in my ESP series cover letter, it is almost impossible for someone to 
perform a comprehensive review without being very familiar with the controller and 
its datasheet, so when attempting to review the series, I would probably focus on 
looking how it compares with the existing lsi53c895a code which is mature and working 
well. For me this would mean that adding notes explaining any unusual differences 
between the two devices on the commit message would be extremely helpful during review.

You mentioned above the problem with implementing new helpers causing boot to break 
between patches 5 and 8: is it possible to bring in the new logic/helpers a phase at 
a time (like I did with ESP) to help keep things working? Perhaps a temporary lock to 
enable the async helpers to work in a sync manner temporarily could also help?


ATB,

Mark.


