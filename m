Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B1848E6FE48
	for <qemu-devel@archiver.kernel.org>; Fri,  6 Sep 2024 20:40:16 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1smfjv-0000X8-0p; Fri, 06 Sep 2024 16:39:31 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mark.cave-ayland@ilande.co.uk>)
 id 1smfjt-0000Vz-0S
 for qemu-devel@nongnu.org; Fri, 06 Sep 2024 16:39:29 -0400
Received: from mail.ilande.co.uk ([2001:41c9:1:41f::167])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mark.cave-ayland@ilande.co.uk>)
 id 1smfjr-0001np-IH
 for qemu-devel@nongnu.org; Fri, 06 Sep 2024 16:39:28 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=ilande.co.uk; s=20220518; h=Subject:Content-Transfer-Encoding:Content-Type:
 In-Reply-To:References:To:From:MIME-Version:Date:Message-ID:Sender:Reply-To:
 Cc:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID;
 bh=gitRUxcSOxSKGqibfbRrrmQlsGxMl44/KszdnJFNMVo=; b=DMVcF3RdeCY1YBZAvwCzWpDuow
 1Ag654ZqHahTCCnXanOdC3DJYS4G4VBFGEJzb7vUAS6UrMcoH7qxfC7BDxTWDvLbDStcG2pyu6qoG
 LCU6Yqo50b4/hmYwjwovdnD9rDfVKOeRU7MDQ5dQfpZ26Q67gP2pk6/+ctJ8X+RJyf457iwgAcrvb
 jYEXjCTrlgIU3jJkvIWrpUPDop1aUWXd9M+/b8WC0BjyMa0KjSEZjvhvdxVKnHwXQSfaJ5rndt7P/
 quZo35tk1ydo7ec6Savfx2QXTmClnBzdXpOp6vGrw877ie/AyMvz53qh4zk+6/u4NHrlhhkauEn2s
 lsympMvGaVBYrFvJk7gc9FIiHL5F67CdXLY2sbUMKqkjkgEizZFWaOwJpEYC7/zy6yfqABY0fRrIt
 pqLXBeCPU8huQhgk2UpUuYZ5N59h759IABz7G0E6Os5IpDMEYuQxvEMIJupoaZHChd9821qcg3D/J
 YhTAQvTefvrsml3Yc6GxB/y6bg7WLFopIMTPFas3vfTe0oPjTaccp7LgM4DLfliB68Il5p+qjiFmc
 MI7qk68VWnlM4D0woJLKcHth+11Zi/c+cg3eTCmIcIWEazesVXSmA0xeY75yVdH40uAo9lzbda4mC
 PGYMT1FohCfK0ooDi9nqaX43010UjV8wniSnrJ6ts=;
Received: from [2a00:23c4:8bb8:1400:c2c8:7829:48cd:7400]
 by mail.ilande.co.uk with esmtpsa (TLS1.3:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.92) (envelope-from <mark.cave-ayland@ilande.co.uk>)
 id 1smfjg-000BLx-Vk; Fri, 06 Sep 2024 21:39:21 +0100
Message-ID: <2404c13b-3cc5-4365-abc9-afade6895e48@ilande.co.uk>
Date: Fri, 6 Sep 2024 21:39:14 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
To: philmd@linaro.org, Alistair.Francis@wdc.com, tavip@google.com,
 qemu-devel@nongnu.org
References: <20240828122258.928947-1-mark.cave-ayland@ilande.co.uk>
 <20240828122258.928947-8-mark.cave-ayland@ilande.co.uk>
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
In-Reply-To: <20240828122258.928947-8-mark.cave-ayland@ilande.co.uk>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-SA-Exim-Connect-IP: 2a00:23c4:8bb8:1400:c2c8:7829:48cd:7400
X-SA-Exim-Mail-From: mark.cave-ayland@ilande.co.uk
Subject: Re: [PATCH 7/9] fifo8: add fifo8_peek_buf() function
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

On 28/08/2024 13:22, Mark Cave-Ayland wrote:

> This is a wrapper function around fifo8_peekpop_buf() that allows the caller to
> peek into FIFO, including handling the case where there is a wraparound of the

peek into the FIFO

Looks like I missed a "the" out in the commit message above.

> internal FIFO buffer.
> 
> Signed-off-by: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
> ---
>   include/qemu/fifo8.h | 14 ++++++++++++++
>   util/fifo8.c         |  5 +++++
>   2 files changed, 19 insertions(+)
> 
> diff --git a/include/qemu/fifo8.h b/include/qemu/fifo8.h
> index d1d06754d8..d09984b146 100644
> --- a/include/qemu/fifo8.h
> +++ b/include/qemu/fifo8.h
> @@ -76,6 +76,20 @@ uint8_t fifo8_pop(Fifo8 *fifo);
>    */
>   uint32_t fifo8_pop_buf(Fifo8 *fifo, uint8_t *dest, uint32_t destlen);
>   
> +/**
> + * fifo8_peek_buf:
> + * @fifo: FIFO to read from
> + * @dest: the buffer to write the data into (can be NULL)
> + * @destlen: size of @dest and maximum number of bytes to peek
> + *
> + * Peek a number of elements from the FIFO up to a maximum of @destlen.
> + * The peeked data is copied into the @dest buffer.
> + * Care is taken when the data wraps around in the ring buffer.
> + *
> + * Returns: number of bytes peeked.
> + */
> +uint32_t fifo8_peek_buf(Fifo8 *fifo, uint8_t *dest, uint32_t destlen);
> +
>   /**
>    * fifo8_pop_bufptr:
>    * @fifo: FIFO to pop from
> diff --git a/util/fifo8.c b/util/fifo8.c
> index 1031ffbe7e..a8f5cea158 100644
> --- a/util/fifo8.c
> +++ b/util/fifo8.c
> @@ -140,6 +140,11 @@ uint32_t fifo8_pop_buf(Fifo8 *fifo, uint8_t *dest, uint32_t destlen)
>       return fifo8_peekpop_buf(fifo, dest, destlen, true);
>   }
>   
> +uint32_t fifo8_peek_buf(Fifo8 *fifo, uint8_t *dest, uint32_t destlen)
> +{
> +    return fifo8_peekpop_buf(fifo, dest, destlen, false);
> +}
> +
>   void fifo8_drop(Fifo8 *fifo, uint32_t len)
>   {
>       len -= fifo8_pop_buf(fifo, NULL, len);


ATB,

Mark.


