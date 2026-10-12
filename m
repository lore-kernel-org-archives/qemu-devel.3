Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BFF05CA9ED1
	for <qemu-devel@archiver.kernel.org>; Mon, 12 Oct 2026 11:42:56 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xGEQ7-0007gM-E6; Mon, 12 Oct 2026 07:42:21 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mark.cave-ayland@ilande.co.uk>)
 id 1xGEPq-0007fj-1h
 for qemu-devel@nongnu.org; Mon, 12 Oct 2026 07:42:02 -0400
Received: from mail.ilande.co.uk ([2001:41c9:1:41f::167])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mark.cave-ayland@ilande.co.uk>)
 id 1xGEPo-00089g-CE
 for qemu-devel@nongnu.org; Mon, 12 Oct 2026 07:42:01 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=ilande.co.uk; s=20220518; h=Subject:Content-Transfer-Encoding:Content-Type:
 In-Reply-To:References:To:From:MIME-Version:Date:Message-ID:Sender:Reply-To:
 Cc:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID;
 bh=OO/dYltJHqi4ZHeZGkV6NgTgrizZa4ZVFZxcVu0w5Zs=; b=F4fIYHmEFJMDv4JnJOeh92/pXN
 TDs1m2AHICy/jLvIO8CVrxJhzTm9gg638E7YkS/Od44X4kfQkJzWS0hhekWyzyB/Mi0Tv/J0DQ4xF
 CRXh0pBl4Iorq7AR9dScVfqKR+mbQJP8O2H7rN5F6OwnRwfMRtvB3+acNFNv3UqFyj1ULan9DVVYp
 mRB+AtR6g043I0up1CthNLiBL1bk72IeBDhLUWdAo8j3zPN5bAtSZ7FAAka3fZoyVG3sOBwEFcDz7
 j6YJrzaGiqrXv4F6GhltiySHnHWnGFljWy408hVzZlaaUsU7HPlq2fz40Tg1uRjjv7yDTbDObbEKh
 aw/r2q8zx2eTzL2Jo2x3/TK54U3ztdBIQesd5Sgta+qfKwVLSQLhbMvYkI/P7GzUeL2bO5oXuWLiz
 8wNAF4SaKwB7+KDog1xxn+2mC5w5hdLeHQ0azV29/DHfEMfhBRH4pAlc2qEUQRBiNDyIdiRKoNo/H
 IJg3oY8YmPLBlxRdA9VvBHncH2uHF+1On8A7rJmBJMiU07nyGc/gYTDFnu1PY5AlsAQ0dx1XtEVMu
 5XvmTImm8cZtB0RLxP69TXCFMV7ZiuM7omGWSS7wLChrDD2aHGSg/mYnMCXm+Hlfar+fq93l9mQpo
 f9ByDJA3YLYabNpyOciCs7MpjGcE0k4s20HO2+J3E=;
Received: from [217.155.175.48] (helo=[10.8.0.6])
 by mail.ilande.co.uk with esmtpsa (TLS1.3) tls
 TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256 (Exim 4.94.2)
 (envelope-from <mark.cave-ayland@ilande.co.uk>)
 id 1xGEP6-001Kvg-0J; Mon, 12 Oct 2026 12:41:16 +0100
Message-ID: <bc4e105a-d2f4-4a4c-84e8-1ab0c5a3a2a5@ilande.co.uk>
Date: Mon, 12 Oct 2026 12:41:50 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
To: pbonzini@redhat.com, richard.henderson@linaro.org, qemu-devel@nongnu.org
References: <20260927123807.492352-1-mark.cave-ayland@ilande.co.uk>
Content-Language: en-US
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
In-Reply-To: <20260927123807.492352-1-mark.cave-ayland@ilande.co.uk>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-SA-Exim-Connect-IP: 217.155.175.48
X-SA-Exim-Mail-From: mark.cave-ayland@ilande.co.uk
Subject: Re: [PATCH] target/i386/tcg: fix lea address calculation for CS
 register
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

On 27/09/2026 13:36, Mark Cave-Ayland wrote:

> When the effective address calculation was simplified in commit 55a15eb3504
> ("target/i386/tcg: simplify effective address calculation") the refactoring
> accidentally introduced the ADDSEG() macro into the CS base address inclusion
> test.
> 
> Fix the logic in gen_lea_v_seg_dest() to use CODE64() instead of ADDSEG() for
> the CS base address inclusion test, and at the same time split it into a switch
> statement to make the logic easier to follow.
> 
> Fixes: 55a15eb3504 ("target/i386/tcg: simplify effective address calculation")
> Signed-off-by: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
> ---
>   target/i386/tcg/translate.c | 20 +++++++++++++++++++-
>   1 file changed, 19 insertions(+), 1 deletion(-)
> 
> diff --git a/target/i386/tcg/translate.c b/target/i386/tcg/translate.c
> index 192cf43215e..2d3fffeab7b 100644
> --- a/target/i386/tcg/translate.c
> +++ b/target/i386/tcg/translate.c
> @@ -605,7 +605,25 @@ static void gen_lea_v_seg_dest(DisasContext *s, MemOp aflag, TCGv dest, TCGv a0,
>           ovr_seg = def_seg;
>       }
>   
> -    has_base = ovr_seg >= R_FS || (ovr_seg >= 0 && ADDSEG(s));
> +    switch (ovr_seg) {
> +    case R_DS:
> +    case R_ES:
> +    case R_SS:
> +        has_base = ADDSEG(s);
> +        break;
> +    case R_CS:
> +        has_base = !CODE64(s);
> +        break;
> +    case R_FS:
> +    case R_GS:
> +        has_base = true;
> +        break;
> +    default:
> +        assert(ovr_seg < 0);
> +        has_base = false;
> +        break;
> +    }
> +
>       easize = CODE64(s) ? MO_64 : MO_32;
>   
>       if (has_base) {

Paolo/Richard - is one of you able to take this patch via either the TCG or x86 queue?


ATB,

Mark.


