Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CBC91606A31B
	for <qemu-devel@archiver.kernel.org>; Thu, 22 Oct 2026 20:28:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (4096-bit key, unprotected) header.d=ilande.co.uk header.i=@ilande.co.uk header.a=rsa-sha256 header.s=20220518 header.b=yaVO29N+
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xJzOf-0002A5-9d; Thu, 22 Oct 2026 16:28:23 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mark.cave-ayland@ilande.co.uk>)
 id 1xJzOX-00029T-47
 for qemu-devel@nongnu.org; Thu, 22 Oct 2026 16:28:13 -0400
Received: from mail.ilande.co.uk ([2001:41c9:1:41f::167])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mark.cave-ayland@ilande.co.uk>)
 id 1xJzOV-0007Wg-Cc
 for qemu-devel@nongnu.org; Thu, 22 Oct 2026 16:28:12 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=ilande.co.uk; s=20220518; h=Subject:Content-Transfer-Encoding:Content-Type:
 In-Reply-To:From:References:Cc:To:MIME-Version:Date:Message-ID:Sender:
 Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender
 :Resent-To:Resent-Cc:Resent-Message-ID;
 bh=QJYBrjPg2EmxcmgZ5Ez6UEqkMctp8pRouF/qqrVA6po=; b=yaVO29N+nfGOO23s51byHRY6HS
 0HHC/eWuPC1k3DzFEf6LDquLhp2miOkD3WelSqoqNyczRPiqIgfYOQ//xJ/of90B963cj2Xt4Gi9s
 J0T4gFGbr/AP8eXHvRQ0W98HoIqskOBQaMPhS0TZXW+6VlYq24zxZCg/XY8QGdJVVlyZIbfrAl5aS
 Rx1sj/XOVzjDMyt8maD+acxPZYzRqX6U1c1hEpX4K5WC7tgZLj+AfxfslnjfJwRV73OtcMRJH0Aa/
 hhWnFLDzSw5+gGhClxJtYd8SlSkC3G+g2QeFluO5lsgmjNCewMtugMLb8Gxj/SuZITl2cjyP+mokT
 gKRPd9YAAtv9cOHkBkV6S5Qx+HZiRrjcocPqF7J93vHhq2nuXEpC08h0J8d9cmiRHswhcvZw9CCW1
 gGfzOkIpRYjDxA/KrvfoPOVubddEbb6SUUGQ6/H31ZW5qfwsWnLtB0Ax3GRzJC55DCE1IcHbV0rKb
 f5Mq5l6vqHAjwGwzr0m8jN8uCD3U8xRLL94hAYXQak9K7CVeZiiak3PSx4k1tZVV/I5Mx0bZl7cHW
 Ioz4H+rQrW+OQkv/+N432HW7wXoHh9CR4hy/pEce0QGYWmBbCkflgP1itBhTye238/tZ5oV3uBGvZ
 7Va0ap0JeVNSb3gQNRpbUQog0CA7JRZNWMWBKKpWA=;
Received: from [2a02:8012:2f01:0:fe49:60b9:9856:b8ef]
 by mail.ilande.co.uk with esmtpsa (TLS1.3) tls
 TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256 (Exim 4.94.2)
 (envelope-from <mark.cave-ayland@ilande.co.uk>)
 id 1xJzNm-003FMM-1f; Thu, 22 Oct 2026 21:27:26 +0100
Message-ID: <97036385-c3ab-4067-a9a6-6bce79cf9066@ilande.co.uk>
Date: Thu, 22 Oct 2026 21:28:07 +0100
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: Stian Halseth <stian@itx.no>, qemu-devel@nongnu.org
Cc: Artyom Tarasenko <atar4qemu@gmail.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>,
 Laurent Vivier <laurent@vivier.eu>, Helge Deller <deller@gmx.de>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 Eric Biggers <ebiggers@kernel.org>
References: <20261022070059.3861291-1-stian@itx.no>
 <20261022070059.3861291-3-stian@itx.no>
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
In-Reply-To: <20261022070059.3861291-3-stian@itx.no>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 2a02:8012:2f01:0:fe49:60b9:9856:b8ef
X-SA-Exim-Mail-From: mark.cave-ayland@ilande.co.uk
Subject: Re: [PATCH v3 2/8] target/sparc: Return CFR when crypto feature is
 enabled
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
X-Spam-Status: No, score=-15.1 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On 22/10/2026 08:00, Stian Halseth wrote:

> ASR 26 returns a Compatibility Feature Register (CFR) when the
> crypto feature is on. Without the crypto feature, a read keeps
> strand status as before.
> 
> Return an empty CFR. Each instruction patch sets its bit.
> Guests can read the CFR before using each crypto instruction.
> 
> Based on OSA (Oracle SPARC Architecture) 2011:
> - 5.5 (Ancillary State Registers), table 5-8
> - 5.5.11 Compatibility Feature Register (CFR), table 5-15
> 
> Reviewed-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>
> Signed-off-by: Stian Halseth <stian@itx.no>
> ---
>   target/sparc/insns.decode |  5 ++++-
>   target/sparc/translate.c  | 14 ++++++++++++++
>   2 files changed, 18 insertions(+), 1 deletion(-)
> 
> diff --git a/target/sparc/insns.decode b/target/sparc/insns.decode
> index 242ec42016..55f8528ffe 100644
> --- a/target/sparc/insns.decode
> +++ b/target/sparc/insns.decode
> @@ -106,7 +106,10 @@ CALL    01 i:s30
>       RDTICK_CMPR     10 rd:5  101000 10111 0 0000000000000
>       RDSTICK         10 rd:5  101000 11000 0 0000000000000
>       RDSTICK_CMPR    10 rd:5  101000 11001 0 0000000000000
> -    RDSTRAND_STATUS 10 rd:5  101000 11010 0 0000000000000
> +    {
> +      RDCFR           10 rd:5  101000 11010 0 0000000000000
> +      RDSTRAND_STATUS 10 rd:5  101000 11010 0 0000000000000
> +    }
>     ]
>   
>     # The v8 manual, section B.30 STBAR instruction, says
> diff --git a/target/sparc/translate.c b/target/sparc/translate.c
> index b93feb074b..a1562f5047 100644
> --- a/target/sparc/translate.c
> +++ b/target/sparc/translate.c
> @@ -3022,6 +3022,20 @@ static TCGv do_rdstrand_status(DisasContext *dc, TCGv dst)
>   
>   TRANS(RDSTRAND_STATUS, HYPV, do_rd_special, true, a->rd, do_rdstrand_status)
>   
> +/* CFR bits (OSA 2011, 5.5.11) */
> +#define CFR_AES         (1 << 0)
> +#define CFR_SHA1        (1 << 5)
> +#define CFR_SHA256      (1 << 6)
> +#define CFR_SHA512      (1 << 7)
> +#define CFR_CRC32C      (1 << 11)
> +
> +static TCGv do_rdcfr(DisasContext *dc, TCGv dst)
> +{
> +    return tcg_constant_tl(0);
> +}
> +
> +TRANS(RDCFR, CRYPTO, do_rd_special, true, a->rd, do_rdcfr)
> +
>   static TCGv do_rdpsr(DisasContext *dc, TCGv dst)
>   {
>       gen_helper_rdpsr(dst, tcg_env);

Reviewed-by: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>


ATB,

Mark.


