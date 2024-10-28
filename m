Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 159DBD5B156
	for <qemu-devel@archiver.kernel.org>; Mon, 28 Oct 2024 21:24:02 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t5XCz-0006S4-RS; Mon, 28 Oct 2024 17:23:29 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mark.cave-ayland@ilande.co.uk>)
 id 1t5XCy-0006RT-0Z; Mon, 28 Oct 2024 17:23:28 -0400
Received: from mail.ilande.co.uk ([2001:41c9:1:41f::167])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mark.cave-ayland@ilande.co.uk>)
 id 1t5XCw-0005JH-10; Mon, 28 Oct 2024 17:23:27 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=ilande.co.uk; s=20220518; h=Subject:Content-Transfer-Encoding:Content-Type:
 In-Reply-To:From:References:To:MIME-Version:Date:Message-ID:Sender:Reply-To:
 Cc:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID;
 bh=Fx2CfJgiVDT8TX3SECiCRggfwHVTGEYZGsiHQKo/ve4=; b=QiVS8gQZfQITpDuPPHvWKRfNQC
 r9Hlp7qzAAutQrZ0Gar5wmx/rbfygyALNtn4sXEQ3dhbbjyNjw7kQY1YpqxVHux53bOpY8E7tgS8y
 +YRqQb2gqYsAvka0OitqDPe8Xy+fUMvb+Dnmo/w5pV3QwE0iAXBAD6VZcIiOqZOZNlNeuAI2czCvo
 C9n7a/3+48rKH+61MTE+bT7HoMonSoKVRZp5LA9fdmjj+mjiOaZCHGeGc0HXl/cep0TrKf/NBRsc+
 O4c6NnjRUbB1emU7YRnXiUUEVbCTZvtQlyd/tA2eXxEEx3ak78jJ5Z5vfzi59/6ZgBxDHG1mEp/IP
 evdarfKdtB8/CkmKwVbmLOFtSUQd+jdm0gGfg5vryL2b0TceCSv55pSSQKZhV9ySq26V2quvyPHy1
 UEsPA7BBplcdJs0QlNxS4+iDX0DJQO5U4c4wS6Z+egGfLeG6zK72eVjBx98a08cSldGZPGZ5meeY3
 RZsj7eWHAVlYGsm+2WMKaJl0/yG0n7nok6Goii+qcDrdIzNl6979LzXYM90Blo29KOX9fjKEtEPlx
 f1qjvna7CEaoR4o7dcBNwNL2ZjjjesbQgHHLYy10L+P30g//Mb+TCDhKcgXIY0O3vCDQYDm8/pRdM
 yUf0+BQZrgdow3B5AliIsQVVmDzJNbyQKx6rxM610=;
Received: from [2a00:23c4:8bb8:f600:b5e6:5818:bcfd:7571]
 by mail.ilande.co.uk with esmtpsa (TLS1.3:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.92) (envelope-from <mark.cave-ayland@ilande.co.uk>)
 id 1t5XCZ-0005xk-0Q; Mon, 28 Oct 2024 21:23:07 +0000
Message-ID: <585870ac-e84c-4de7-9a61-3e3d3a8cb4f4@ilande.co.uk>
Date: Mon, 28 Oct 2024 21:23:18 +0000
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: David Gibson <david@gibson.dropbear.id.au>,
 Nicholas Piggin <npiggin@gmail.com>, qemu-ppc@nongnu.org,
 qemu-devel@nongnu.org
References: <20241028095109.1611019-1-david@gibson.dropbear.id.au>
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
In-Reply-To: <20241028095109.1611019-1-david@gibson.dropbear.id.au>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-SA-Exim-Connect-IP: 2a00:23c4:8bb8:f600:b5e6:5818:bcfd:7571
X-SA-Exim-Mail-From: mark.cave-ayland@ilande.co.uk
Subject: Re: [PATCH] MAINTAINERS: Remove myself as reviewer
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

On 28/10/2024 09:51, David Gibson wrote:

> I've now well and truly moved on from ppc and qemu maintenance.  I'm
> occupied with other things and am pretty much just ignoring mails on these
> topics I'm CCed on.  Time to remove myself.
> 
> I'm still listed as a reviewer for Device Tree, I'll keep this for now,
> since I do have some interest and it's lower volume.
> 
> Signed-off-by: David Gibson <david@gibson.dropbear.id.au>
> ---
>   MAINTAINERS | 2 --
>   1 file changed, 2 deletions(-)
> 
> diff --git a/MAINTAINERS b/MAINTAINERS
> index bcaf36e525..5cc9873861 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -1465,7 +1465,6 @@ F: tests/functional/test_ppc_40p.py
>   sPAPR (pseries)
>   M: Nicholas Piggin <npiggin@gmail.com>
>   R: Daniel Henrique Barboza <danielhb413@gmail.com>
> -R: David Gibson <david@gibson.dropbear.id.au>
>   R: Harsh Prateek Bora <harshpb@linux.ibm.com>
>   L: qemu-ppc@nongnu.org
>   S: Odd Fixes
> @@ -1555,7 +1554,6 @@ F: tests/functional/test_ppc_amiga.py
>   
>   Virtual Open Firmware (VOF)
>   M: Alexey Kardashevskiy <aik@ozlabs.ru>
> -R: David Gibson <david@gibson.dropbear.id.au>
>   L: qemu-ppc@nongnu.org
>   S: Odd Fixes
>   F: hw/ppc/spapr_vof*

Hi David,

Thanks for all your support over the years with the Macintosh machines - your help 
and advice will be greatly missed.


ATB,

Mark.


