Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B628AC982D8
	for <qemu-devel@archiver.kernel.org>; Fri, 18 Sep 2026 13:33:36 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x7YiA-0000Xm-4i; Fri, 18 Sep 2026 09:33:06 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mark.cave-ayland@ilande.co.uk>)
 id 1x7Yi6-0000XN-Gz
 for qemu-devel@nongnu.org; Fri, 18 Sep 2026 09:33:03 -0400
Received: from mail.ilande.co.uk ([2001:41c9:1:41f::167])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mark.cave-ayland@ilande.co.uk>)
 id 1x7Yi4-0001y2-VZ
 for qemu-devel@nongnu.org; Fri, 18 Sep 2026 09:33:02 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=ilande.co.uk; s=20220518; h=Subject:Content-Transfer-Encoding:Content-Type:
 In-Reply-To:From:References:Cc:To:MIME-Version:Date:Message-ID:Sender:
 Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender
 :Resent-To:Resent-Cc:Resent-Message-ID;
 bh=ILNWnfSal2kmuc9DNxkb4v4FlbYAEIDaLZt18RgQVBE=; b=QCIcNIlATpN21Y6WivhDbEsPjP
 jHGqNuR44kddkhYYK5tTf0Y3U0ecnHC+F7zMHoLYf0cTvGhc6NSC4lxY0vGhKrNa/AKJlACxMMS9P
 4uFV8Zuz9ekbxpxwjV6mqblwz7Jxh8uhIZPFvrW40LSSwoZfjQS1g4NyDCRYp0fV7QGwc7SviN5ZG
 P0JtFZzqBHFxH4LN4WR2HcUCoWUcprK1DEQLa+hykXRAQZ7nTTKDxqoQyEbS0TZcfgSfGjBvLX0t1
 KsysCiwP0VzMNvnwgxOXKxkY3Shk2GldyG4pHkOM2lxbNKmzBXxudkcf0QEl0M2gMEoJs8z9pS8fv
 B7sSAeXcGquh8MVpeqtJeH2NG8yW112jWg2vT+MlsqGVY90WUjGuVw5h5HkR/15qDPH81QNE+r6O5
 TRK+X6Xt9cWx9OAiayqKsR/rmcQ3wm/uLfDRssLOVzHGkF+gvIzO5twsi6EkL8Epmn7TF4BeIp8YW
 /+FABeujRY4L53AqxZSu8kXciCqw9/CWIFMqHTv7/oGCysMamV0QqzT/y2Kz2NjZHescW2tEJ8EPs
 HA0HUXaYdQ12pcf94Df0LfCCVtGoqmGo7Vl6z4vTOqqY8e3AdUXCGuK4KBTNPWM0Od7VoaiIbnV0a
 NvjmbXUXFMNUan3gJgrqonAuEjbd0rFI3zHpTZk9o=;
Received: from [217.155.175.48] (helo=[10.8.0.6])
 by mail.ilande.co.uk with esmtpsa (TLS1.3) tls
 TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256 (Exim 4.94.2)
 (envelope-from <mark.cave-ayland@ilande.co.uk>)
 id 1x7YhY-00EgWx-Sy; Fri, 18 Sep 2026 14:32:29 +0100
Message-ID: <8310b400-544e-4ed5-8eb6-e0797a924a8d@ilande.co.uk>
Date: Fri, 18 Sep 2026 14:32:58 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: Purr Box <54weasels@gmail.com>, qemu-devel@nongnu.org
Cc: laurent@vivier.eu, BALATON Zoltan <balaton@eik.bme.hu>
References: <20260903044626.24453-1-54weasels@gmail.com>
 <CAFWf6u8rjCECp+cdP21kfB7QUYff3crQiE1v5DnHXcMVzWan9w@mail.gmail.com>
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
In-Reply-To: <CAFWf6u8rjCECp+cdP21kfB7QUYff3crQiE1v5DnHXcMVzWan9w@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 217.155.175.48
X-SA-Exim-Mail-From: mark.cave-ayland@ilande.co.uk
Subject: Re: [PATCH v5 0/6] Implement missing functionality and hooks in m68k
 to support upcoming Sun-3 implementation
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

On 09/09/2026 19:54, Purr Box wrote:

> Gentle ping on this series. v5 addresses Zoltan's review feedback from v4 (fsave 
> simplification, NMI edge-trigger rationale, added Signed-off-by). Would appreciate 
> any review when you have a chance.

Apologies for the delay: I will have quick look through the series over the next few 
days, although I suspect I'd need to defer to Laurent's greater 68k knowledge here.

> Dan.
> 
> On Wed, Sep 2, 2026 at 9:46 PM 54weasels <54weasels@gmail.com 
> <mailto:54weasels@gmail.com>> wrote:
> 
>     This series adds M68020/030-specific features to the m68k target that
>     are required by the Sun-3 machine (series C) and its PROM/SunOS guests:
> 
>        1/6: CAAR register stub for 68020/030 cache control
>        2/6: fsave/frestore fix for 68881 (non-68040) FPU frames
>        3/6: Edge-triggered NMI semantics for Level 7 interrupts
>        4/6: Function code extraction during TLB fills
>        5/6: Custom MMU intercept hook for Sun-3 transparent translation
>        6/6: Physical Bus Error and M68020 Format 0xB stack frames
> 
>     Changes since v4:
>        - Added Signed-off-by to all patches.
>        - Patch 2/6 (fsave): Addressed Zoltan's review — replaced redundant
>          M68040||FPU check with just M68K_FEATURE_FPU, removed unnecessary
>          if/else in frestore, moved Context: below --- separator.
>        - Patch 3/6 (NMI): Addressed Zoltan's review — nmi_pending cannot be
>          replaced by testing pending_level == 7. The flag captures the edge
>          transition (level < 7 → 7) required by Motorola's NMI specification,
>          while pending_level only reflects the current interrupt level.
>          Testing pending_level alone would produce level-triggered behavior,
>          firing on every interrupt check rather than once per edge.
>        - Rebased on current master.
> 
>     54weasels (6):
>        target/m68k: Add dummy CAAR register
>        target/m68k: Fix fsave/frestore for 68881 FPU
>        target/m68k: Fix NMI pending for Level 7 interrupts
>        target/m68k: Extract Function Codes during TLB fills
>        target/m68k: Implement custom MMU intercept hook
>        target/m68k: Implement Physical Bus Error and Stack
> 
>       target/m68k/cpu.c       |   4 +-
>       target/m68k/cpu.h       |  21 ++++-
>       target/m68k/helper.c    | 130 ++++++++++++++++++++++++++++-
>       target/m68k/op_helper.c | 175 ++++++++++++++++++++++++++--------------
>       target/m68k/translate.c |  30 ++++---
>       5 files changed, 280 insertions(+), 80 deletions(-)
> 
>     -- 
>     2.50.1 (Apple Git-155)


ATB,

Mark.


