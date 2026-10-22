Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9C13A606A319
	for <qemu-devel@archiver.kernel.org>; Thu, 22 Oct 2026 21:02:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (4096-bit key, unprotected) header.d=ilande.co.uk header.i=@ilande.co.uk header.a=rsa-sha256 header.s=20220518 header.b=n7cx4FhG
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xJzv9-0001yF-QY; Thu, 22 Oct 2026 17:01:55 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mark.cave-ayland@ilande.co.uk>)
 id 1xJzv1-0001v3-AE
 for qemu-devel@nongnu.org; Thu, 22 Oct 2026 17:01:47 -0400
Received: from mail.ilande.co.uk ([2001:41c9:1:41f::167])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mark.cave-ayland@ilande.co.uk>)
 id 1xJzuz-0002LF-Nl
 for qemu-devel@nongnu.org; Thu, 22 Oct 2026 17:01:47 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=ilande.co.uk; s=20220518; h=Subject:Content-Transfer-Encoding:Content-Type:
 In-Reply-To:From:References:Cc:To:MIME-Version:Date:Message-ID:Sender:
 Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender
 :Resent-To:Resent-Cc:Resent-Message-ID;
 bh=t7nE6YLE6CRE/lAkkeueoecddrHIE8UUfh6CewXnx2A=; b=n7cx4FhG3j9CzR3q9Vxmh4E946
 gs3P5astRjU/tsSlNi/XyLXIU/pTsdH/xOGDzGyCWmZsAheqCSvxdQtVABCbFsqYdzZP/aWha0D/0
 Rr+0KPq5NofrghrTCJYg4vHMjNgj9fLp8QXz94UnKPXpiDcUu7k9rex/guJ37Ov5wB6oeuLSLAWzq
 bQQxOFTZEawM6pz672HAgUERFbdVaSeWB4+PM+XNbj5f9Sj/5MQ3k2QQ0JsAYriuYbFEooZhEcddE
 LEtLfKlbNrh2qNGb2FepBEiVWwOLOL9aJ+8nrfBP9xdIAaR83Ckp48UfqLOb+hiX9xA7YbWNv7DkK
 UXalWqtn8cH8VCz0X8m5tMFZUT+M8ia0zHOuoH+Rs8H1CzieYAOYyEKCIWqTAhToa8xpjGZsbqiUI
 j6AEY8qhbYh57m4O98faREm+YR8Za4dszkbwuIaCM7cMKk5vbNxE/HXK+T0EZCPkNtR8in9OzTGmr
 qfKgP+p620zyfwzUAllPDfTxk+9IBp3PnDDL8fbeOzyPt+DviG0dn86BJzmDX61bQskyiHIXsHzu/
 ZUpzydCtFG7rX9uvD8aNdGn4imbDzY+dwVujiCjH0PUdGMkL4doiVwZ05riJlYWuz4Le9r1Midrmv
 byokjpyaK68km/PU5peRBPjfOCcSwbZLzLdpuhR3c=;
Received: from [2a02:8012:2f01:0:fe49:60b9:9856:b8ef]
 by mail.ilande.co.uk with esmtpsa (TLS1.3) tls
 TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256 (Exim 4.94.2)
 (envelope-from <mark.cave-ayland@ilande.co.uk>)
 id 1xJzuH-003Fb2-7D; Thu, 22 Oct 2026 22:01:01 +0100
Message-ID: <6dd0a00a-eeb6-4680-b1e5-a2518b604fdc@ilande.co.uk>
Date: Thu, 22 Oct 2026 22:01:42 +0100
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
 <20261022070059.3861291-8-stian@itx.no>
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
In-Reply-To: <20261022070059.3861291-8-stian@itx.no>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-SA-Exim-Connect-IP: 2a02:8012:2f01:0:fe49:60b9:9856:b8ef
X-SA-Exim-Mail-From: mark.cave-ayland@ilande.co.uk
Subject: Re: [PATCH v3 7/8] target/sparc: Allow block-init stores when the CPU
 has the crypto feature
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

> The next patch reports HWCAP_SPARC_CRYPTO to linux-user guests.
> A multiarch glibc then picks its niagara4 memcpy/memset, which
> store with ASI 0xe2. QEMU only allows that store on CPUs with
> HYPV, so every dynamically linked program dies with SIGILL.
> 
> The crypto opcodes exist only on T4 and later, and all of those
> have the block-init ASIs.
> 
> Reproduced with Gentoo sparc64 stage3 sysroot:
> qemu-sparc64 -L <stage3 root> -cpu \
> TI-UltraSparc-IIi,+crypto <stage3 root>/usr/bin/dd --version
> 
> Signed-off-by: Stian Halseth <stian@itx.no>
> ---
>   target/sparc/translate.c | 8 ++++++--
>   1 file changed, 6 insertions(+), 2 deletions(-)
> 
> diff --git a/target/sparc/translate.c b/target/sparc/translate.c
> index 921ffd2d1b..931fc006ce 100644
> --- a/target/sparc/translate.c
> +++ b/target/sparc/translate.c
> @@ -1863,8 +1863,12 @@ static void gen_st_asi(DisasContext *dc, DisasASI *da, TCGv src, TCGv addr)
>           if (TARGET_LONG_BITS == 32) {
>               gen_exception(dc, TT_ILL_INSN);
>               break;
> -        } else if (!(dc->def->features & CPU_FEATURE_HYPV)) {
> -            /* Pre OpenSPARC CPUs don't have these */
> +        } else if (!(dc->def->features &
> +                    (CPU_FEATURE_HYPV | CPU_FEATURE_CRYPTO))) {
> +            /*
> +             * Pre-OpenSPARC CPUs lack block-init stores. Crypto instructions
> +             * imply T4 or later, which supports them.
> +             */
>               gen_exception(dc, TT_ILL_INSN);
>               break;
>           }

Hmmm. Feels like we're getting a bit blurred here between the crypto feature and 
other sun4v features, however I think we're just going to have to go with this for 
now. Presumably no other interesting ASIs have showed up in your tests so far?

Reviewed-by: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>


ATB,

Mark.


