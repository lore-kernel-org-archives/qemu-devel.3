Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1DC73606A683
	for <qemu-devel@archiver.kernel.org>; Mon, 23 Nov 2026 20:55:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (4096-bit key, unprotected) header.d=ilande.co.uk header.i=@ilande.co.uk header.a=rsa-sha256 header.s=20220518 header.b=qfTNokND
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xVb3f-0005dV-VF; Mon, 23 Nov 2026 15:54:43 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mark.cave-ayland@ilande.co.uk>)
 id 1xVb34-0005X7-WF
 for qemu-devel@nongnu.org; Mon, 23 Nov 2026 15:54:06 -0500
Received: from mail.ilande.co.uk ([2001:41c9:1:41f::167])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mark.cave-ayland@ilande.co.uk>)
 id 1xVb33-0000sO-E2
 for qemu-devel@nongnu.org; Mon, 23 Nov 2026 15:54:02 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=ilande.co.uk; s=20220518; h=Subject:Content-Transfer-Encoding:Content-Type:
 In-Reply-To:From:References:Cc:To:MIME-Version:Date:Message-ID:Sender:
 Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender
 :Resent-To:Resent-Cc:Resent-Message-ID;
 bh=9g6pRF6KXSST3/2GqZjlETd4yle8erGq3khcyj1SsoY=; b=qfTNokNDccIChmRvq2qUFADkBY
 Qjd9dKkZYvRwinEO+MiSI/tK9CDuBwnKLmfoenKMJlhPh5LBgVo0z3dUcE0vagxOXmtJmdenAfon0
 fGT0iLyZ6CKcxthGYcoBvxXm6o7tSiVfM61NQh8tVfobrgq42jzD7yb4gIrSK4Elg4IrxNvbDCVe3
 DmJxxNZj76eIGe92ajKHg559nqeZgMpMeJ8fWS9duV6Cxcwn0lqsyzoYyyibu9DLby//KyT9RPQKY
 J2RrgVjCuJxn9ZEbj99Xx9uzYZUn0qmlRra/kPlnsSjXdysRG/P1uzgoG7AnOPBy3SpDtw2kWU6Bn
 EdhW9U78s1FbYhmB6MVkg6Yuc4iGFPqoO7AKzDxH0DwxDJ6luZufYcV17HTK9njaV+ChgW1gnIlGH
 FrupwKsaaLMGAiYk5KxCaXOythU+yfcJC7fZAvXRlYqZXaGrpX9lfG+kBFNgedSvoNy9d2kvAbjQI
 1jmgzHYLxtRYHivyRJBj+bRjBpxeME4VrwEg+Ycheg0lqeZHRmXFTHcX7eKK4c1ejDV3hQcJM0FTU
 RGsiQ8Hlnj6DzHtvmbHCMs2ogEQ8jxpUSwDJmdqwqrmAneaoLvjW8O4T+9d307nK7gaNPunFTlWwX
 XWw4h1mSnv4Aiv3uhzRmIVcpmXwkYW2vITmriaSbc=;
Received: from [2a02:8012:2f01:0:fe49:60b9:9856:b8ef]
 by mail.ilande.co.uk with esmtpsa (TLS1.3) tls
 TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256 (Exim 4.94.2)
 (envelope-from <mark.cave-ayland@ilande.co.uk>)
 id 1xVb2A-0099je-Gt; Mon, 23 Nov 2026 20:53:06 +0000
Message-ID: <c0a78f85-0fa8-462e-bf10-3e8332c4bcfe@ilande.co.uk>
Date: Mon, 23 Nov 2026 20:53:58 +0000
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>,
 qemu-devel@nongnu.org
Cc: Laurent Vivier <laurent@vivier.eu>, "Michael S. Tsirkin"
 <mst@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>
References: <20261119220838.52034-1-philmd@oss.qualcomm.com>
 <20261119220838.52034-4-philmd@oss.qualcomm.com>
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
In-Reply-To: <20261119220838.52034-4-philmd@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 2a02:8012:2f01:0:fe49:60b9:9856:b8ef
X-SA-Exim-Mail-From: mark.cave-ayland@ilande.co.uk
Subject: Re: [PATCH 3/3] hw/dma/i8257: Honor the command register
 group-disable bit
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

On 19/11/2026 22:08, Philippe Mathieu-Daudé wrote:

> Command bit 2 of the 82C37-compatible DMA controller disables
> the channel group (PIIX3 datasheet, section 2.5.1.1). The model
> accepted but ignored it.
> Gate servicing on that bit and re-run the engine after a command
> write so re-enabling resumes pending requests.
> 
> Fixes: 27503323968 ("Soundblaster 16 support")
> Signed-off-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>
> ---
>   hw/dma/i8257.c | 7 +++++++
>   1 file changed, 7 insertions(+)
> 
> diff --git a/hw/dma/i8257.c b/hw/dma/i8257.c
> index ade8609ff438..42143ca57dd6 100644
> --- a/hw/dma/i8257.c
> +++ b/hw/dma/i8257.c
> @@ -195,6 +195,8 @@ static void i8257_write_cont(void *opaque, hwaddr nport, uint64_t data,
>               return;
>           }
>           d->command = data;
> +        /* A pending request may be serviced once the group is enabled. */
> +        i8257_dma_run(d);
>           break;
>   
>       case 0x01:
> @@ -355,6 +357,11 @@ static void i8257_dma_run(void *opaque)
>       int ichan;
>       int rearm = 0;
>   
> +    /* PIIX3 DCOM bit 2 disables the channel group. */
> +    if (d->command & CMD_BLOCK_CONTROLLER) {
> +        return;
> +    }
> +

Minor nit: the comment specifically mentions PIIX3 however this seems to be the 
expected behaviour of the standard i8257 chip as per 
https://wiki.osdev.org/ISA_DMA#The_Other_Registers.

>       if (d->running) {
>           rearm = 1;
>           goto out;

Otherwise:

Reviewed-by: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>


ATB,

Mark.


