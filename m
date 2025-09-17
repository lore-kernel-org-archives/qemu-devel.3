Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4B112CAC59A
	for <qemu-devel@archiver.kernel.org>; Wed, 17 Sep 2025 20:28:53 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uyylV-0000Sd-8v; Wed, 17 Sep 2025 16:28:33 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mark.cave-ayland@ilande.co.uk>)
 id 1uyylJ-0000Qq-7b
 for qemu-devel@nongnu.org; Wed, 17 Sep 2025 16:28:23 -0400
Received: from mail.ilande.co.uk ([2001:41c9:1:41f::167])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mark.cave-ayland@ilande.co.uk>)
 id 1uyylH-00046z-Jv
 for qemu-devel@nongnu.org; Wed, 17 Sep 2025 16:28:20 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=ilande.co.uk; s=20220518; h=Subject:Content-Transfer-Encoding:Content-Type:
 In-Reply-To:From:References:Cc:To:MIME-Version:Date:Message-ID:Sender:
 Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender
 :Resent-To:Resent-Cc:Resent-Message-ID;
 bh=SyESfQ3RPp8eYi1P8pxNtA8MDcnQRhuremuAHp4zGW0=; b=hQYlxL5cs2Lbn4wQcRnGQEZwP0
 ssxy9zT/V6bdzs/V3cjkoCAtp/prONPDwsMH9KGYY5wf7V7vCLOyF/5IqkzLjcpu+Zk10f/Thv8Hb
 /aqm3TApi8+UjvFX0ru0LhcsA/EQFO3U7ANEb3JtrC50cc/vfD1SdVFbFdRgG0VzjuJhSuQBj2FhQ
 dQFg/R7uYZjjE87pxEWkOBZVOux2LZcFxSksIVOhUsDPlaLcITdPmidqiq+D0+dEKXqrrdGn6vVOr
 XI+rkAJpJ4KgrN+N46Xj7bDbJpyz4TPLne7tV5+d4/NoaeTSBezhWIId8bKF8UyCPVqmQE8gAv1U7
 5+yzSoQbiAbYRP0sR6r5VYeJhmmP1Pp+q3RM7tLzysJoCH6ZlHrGlTa6ui+Ow+pTeuQDdS3D51i3e
 ryWX0pmOAlaGczMRVp0KmwVVXfGmdfHZWbQuQnzje+aCe5UypyxsHL12FUNHmHttkDUKFwcWKvGJQ
 N4YkiNmBOVqyqWKtEW1Juc1O4SwmS6GAg4PCb2muggWWv7kuUFYn3gK3vBp18afm6vcQm9lIukrjx
 r8EoCuuMLREUocR6/yYthwzF203kf8EvtLocav0aVZ3MYe5bIXz7YfMOba78nkQDnd1KcIQ8laGEF
 yj259tXQiWh+6br+moCtxAiqCvoo2BqxIOCAhC2d0=;
Received: from [2a02:8012:2f01:0:ff11:26c7:ce3f:b269]
 by mail.ilande.co.uk with esmtpsa (TLS1.3:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.92) (envelope-from <mark.cave-ayland@ilande.co.uk>)
 id 1uyyjG-000ANK-Rr; Wed, 17 Sep 2025 21:26:15 +0100
Message-ID: <a571b7dc-c42b-42b0-b5e9-fe7b766594a6@ilande.co.uk>
Date: Wed, 17 Sep 2025 21:28:16 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
Cc: atar4qemu@gmail.com
References: <20250905115128.376295-1-richard.henderson@linaro.org>
 <20250905115128.376295-6-richard.henderson@linaro.org>
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
In-Reply-To: <20250905115128.376295-6-richard.henderson@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-SA-Exim-Connect-IP: 2a02:8012:2f01:0:ff11:26c7:ce3f:b269
X-SA-Exim-Mail-From: mark.cave-ayland@ilande.co.uk
Subject: Re: [PATCH v2 5/7] target/sparc: Loosen decode of RDWIM for v7
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

On 05/09/2025 12:51, Richard Henderson wrote:

> For v7, bits [18:0] are ignored.
> For v8, bits [18:14] are reserved and bits [13:0] are ignored.
> 
> Fixes: 5d617bfba07 ("target/sparc: Move RDWIM, RDPR to decodetree")
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>   target/sparc/insns.decode | 40 ++++++++++++++++++++-------------------
>   1 file changed, 21 insertions(+), 19 deletions(-)
> 
> diff --git a/target/sparc/insns.decode b/target/sparc/insns.decode
> index 1c6403ad8a..77b2f54fdf 100644
> --- a/target/sparc/insns.decode
> +++ b/target/sparc/insns.decode
> @@ -180,26 +180,28 @@ RESTORED            10 00001 110001 00000 0 0000000000000
>   # UA2005 INVALW
>   
>   {
> -  RDWIM             10 rd:5  101010 00000 0 0000000000000
> -  RDPR_tpc          10 rd:5  101010 00000 0 0000000000000
> +  [
> +    RDPR_tpc            10 rd:5  101010 00000 0 0000000000000
> +    RDPR_tnpc           10 rd:5  101010 00001 0 0000000000000
> +    RDPR_tstate         10 rd:5  101010 00010 0 0000000000000
> +    RDPR_tt             10 rd:5  101010 00011 0 0000000000000
> +    RDPR_tick           10 rd:5  101010 00100 0 0000000000000
> +    RDPR_tba            10 rd:5  101010 00101 0 0000000000000
> +    RDPR_pstate         10 rd:5  101010 00110 0 0000000000000
> +    RDPR_tl             10 rd:5  101010 00111 0 0000000000000
> +    RDPR_pil            10 rd:5  101010 01000 0 0000000000000
> +    RDPR_cwp            10 rd:5  101010 01001 0 0000000000000
> +    RDPR_cansave        10 rd:5  101010 01010 0 0000000000000
> +    RDPR_canrestore     10 rd:5  101010 01011 0 0000000000000
> +    RDPR_cleanwin       10 rd:5  101010 01100 0 0000000000000
> +    RDPR_otherwin       10 rd:5  101010 01101 0 0000000000000
> +    RDPR_wstate         10 rd:5  101010 01110 0 0000000000000
> +    RDPR_gl             10 rd:5  101010 10000 0 0000000000000
> +    RDPR_strand_status  10 rd:5  101010 11010 0 0000000000000
> +    RDPR_ver            10 rd:5  101010 11111 0 0000000000000
> +  ]
> +  RDWIM                 10 rd:5  101010 ----- - -------------
>   }
> -RDPR_tnpc           10 rd:5  101010 00001 0 0000000000000
> -RDPR_tstate         10 rd:5  101010 00010 0 0000000000000
> -RDPR_tt             10 rd:5  101010 00011 0 0000000000000
> -RDPR_tick           10 rd:5  101010 00100 0 0000000000000
> -RDPR_tba            10 rd:5  101010 00101 0 0000000000000
> -RDPR_pstate         10 rd:5  101010 00110 0 0000000000000
> -RDPR_tl             10 rd:5  101010 00111 0 0000000000000
> -RDPR_pil            10 rd:5  101010 01000 0 0000000000000
> -RDPR_cwp            10 rd:5  101010 01001 0 0000000000000
> -RDPR_cansave        10 rd:5  101010 01010 0 0000000000000
> -RDPR_canrestore     10 rd:5  101010 01011 0 0000000000000
> -RDPR_cleanwin       10 rd:5  101010 01100 0 0000000000000
> -RDPR_otherwin       10 rd:5  101010 01101 0 0000000000000
> -RDPR_wstate         10 rd:5  101010 01110 0 0000000000000
> -RDPR_gl             10 rd:5  101010 10000 0 0000000000000
> -RDPR_strand_status  10 rd:5  101010 11010 0 0000000000000
> -RDPR_ver            10 rd:5  101010 11111 0 0000000000000
>   
>   {
>     WRWIM             10 00000 110010 ..... . .............  @n_r_ri

Reviewed-by: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>


ATB,

Mark.


