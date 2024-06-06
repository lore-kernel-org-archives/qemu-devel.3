Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 93741C27C52
	for <qemu-devel@archiver.kernel.org>; Thu,  6 Jun 2024 17:35:52 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sFH0m-0000FX-5G; Thu, 06 Jun 2024 13:34:52 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mark.cave-ayland@ilande.co.uk>)
 id 1sFH0j-0000F8-Ts
 for qemu-devel@nongnu.org; Thu, 06 Jun 2024 13:34:50 -0400
Received: from mail.ilande.co.uk ([2001:41c9:1:41f::167])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mark.cave-ayland@ilande.co.uk>)
 id 1sFH0i-0002dp-CS
 for qemu-devel@nongnu.org; Thu, 06 Jun 2024 13:34:49 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=ilande.co.uk; s=20220518; h=Subject:Content-Transfer-Encoding:Content-Type:
 In-Reply-To:From:References:Cc:To:MIME-Version:Date:Message-ID:Sender:
 Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender
 :Resent-To:Resent-Cc:Resent-Message-ID;
 bh=oyY72cTSEbMY5VrOYKGwVhbODT3zHFwaw3viguj02NI=; b=vCHtEFcQ/Ni7z2Q5VKaCkgyB1K
 B2TwXWirMmWVDLtKUWHVouHgAaswMcW7i1DPE2sR8FeU9hjgxMo61F/cLlORNO0rj0/W55VSuQSqo
 oAy6J4PfKHT3kH0KZOOKrXdcMuaHPm4jT4F8+5zhDG/ib7t2nA1IiDrTb6DG9z4r7S/mqBWfUGn8j
 vDEzi6p8qVIH+a0DwawmAO9P5ZdIHx4RshpI7ezVuPxC1s/FVn1Nlgx8hFRcPBuLoYN2wivmDzXT1
 tPJh8qE+sxBjg2nngHKyvHSOikYjz28DtJb/ycqAu+OGgJYEpq00WrY7Di1wc7A4ai/6uSW73BsUa
 GoMbsnDEgRaBzVRS29NuFjZEBzYPfYW4Gt0S//urY0XllPNr7pSqaTXXe/sfxewMhlEzwV+GlGDXK
 I3VN33tmQOZurJk+nM7/1VFiPS+p75aErHiMVS8WaZjfTkpzVusgkTdOqExnk9n8FVRxL0VbjykO7
 2SJiijZE6y5ubBktALgXaLh1+MhEgslw83V9C9Ksg254ZN0iEu11EVQz/0icQx44Sqyll89H3SbvG
 XoI6a8YR4gVLF4HIysTPMLOiPW0SakTZX0BWsJT4Jrc9QUgB1QH49KHBaWwuV2OrXBNKrNMlv+140
 911Y+RXMwNIOyvAmwL1wyp8hFVcOzlQUdrZQGrei4=;
Received: from [2a00:23c4:8bb4:4000:f93e:c223:cb35:c914]
 by mail.ilande.co.uk with esmtpsa (TLS1.3:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.92) (envelope-from <mark.cave-ayland@ilande.co.uk>)
 id 1sFGzN-0008ML-AH; Thu, 06 Jun 2024 18:33:29 +0100
Message-ID: <1bf470d4-71a7-4690-9d3c-0c7b0873dcaf@ilande.co.uk>
Date: Thu, 6 Jun 2024 18:34:29 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: =?UTF-8?Q?Cl=C3=A9ment_Chigot?= <chigot@adacore.com>, qemu-devel@nongnu.org
Cc: richard.henderson@linaro.org
References: <20240606144331.698361-1-chigot@adacore.com>
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
In-Reply-To: <20240606144331.698361-1-chigot@adacore.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 2a00:23c4:8bb4:4000:f93e:c223:cb35:c914
X-SA-Exim-Mail-From: mark.cave-ayland@ilande.co.uk
Subject: Re: [PATCH] target/sparc: use signed denominator in sdiv helper
X-SA-Exim-Version: 4.2.1 (built Wed, 08 May 2019 21:11:16 +0000)
X-SA-Exim-Scanned: Yes (on mail.ilande.co.uk)
Received-SPF: pass client-ip=2001:41c9:1:41f::167;
 envelope-from=mark.cave-ayland@ilande.co.uk; helo=mail.ilande.co.uk
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001, T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

On 06/06/2024 15:43, Clément Chigot wrote:

> The result has to be done with the signed denominator (b32) instead of
> the unsigned value passed in argument (b).
> 
> Fixes: 1326010322d6 ("target/sparc: Remove CC_OP_DIV")
> Signed-off-by: Clément Chigot <chigot@adacore.com>
> ---
>   target/sparc/helper.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/target/sparc/helper.c b/target/sparc/helper.c
> index 2247e243b5..7846ddd6f6 100644
> --- a/target/sparc/helper.c
> +++ b/target/sparc/helper.c
> @@ -121,7 +121,7 @@ uint64_t helper_sdiv(CPUSPARCState *env, target_ulong a, target_ulong b)
>           return (uint32_t)(b32 < 0 ? INT32_MAX : INT32_MIN) | (-1ull << 32);
>       }
>   
> -    a64 /= b;
> +    a64 /= b32;
>       r = a64;
>       if (unlikely(r != a64)) {
>           return (uint32_t)(a64 < 0 ? INT32_MIN : INT32_MAX) | (-1ull << 32);

Thanks for the patch! I think this might also be:

Resolves: https://gitlab.com/qemu-project/qemu/-/issues/2319


ATB,

Mark.


