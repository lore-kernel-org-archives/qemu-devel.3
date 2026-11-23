Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B8770606A31E
	for <qemu-devel@archiver.kernel.org>; Mon, 23 Nov 2026 20:49:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (4096-bit key, unprotected) header.d=ilande.co.uk header.i=@ilande.co.uk header.a=rsa-sha256 header.s=20220518 header.b=hsGLpbZ7
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xVaxr-0003RU-NK; Mon, 23 Nov 2026 15:48:39 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mark.cave-ayland@ilande.co.uk>)
 id 1xVaxi-0003Qr-OA
 for qemu-devel@nongnu.org; Mon, 23 Nov 2026 15:48:32 -0500
Received: from mail.ilande.co.uk ([2001:41c9:1:41f::167])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mark.cave-ayland@ilande.co.uk>)
 id 1xVaxh-0001Q8-3J
 for qemu-devel@nongnu.org; Mon, 23 Nov 2026 15:48:30 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=ilande.co.uk; s=20220518; h=Subject:Content-Transfer-Encoding:Content-Type:
 In-Reply-To:From:References:Cc:To:MIME-Version:Date:Message-ID:Sender:
 Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender
 :Resent-To:Resent-Cc:Resent-Message-ID;
 bh=bBZ40O7Bd+6WuR5XW4EcbDOG8PhNU1mYmLW8Auws02E=; b=hsGLpbZ7/MpLUKwWM8+Dajlmqh
 Z4YRK6Nap+LG1hVV1RnW/JgoYO4aRV5VG4mfrjW5A3IK4viddw5paYkBKYUbxF6vcLRYFt8npMPOn
 VAvGEGmQHoDKrLL3EZRdcM5MqNTOszPOivezraDlV0ALKy8j/AHfF/7fklaqZzzVIiqAuAlSe3+yJ
 L4ipDoKDwqOo1l65tbjeoOyKHr81H/TB3PfZiDmSSv7qv3dVr892m9Bv7lbfw9BLNbvtKoCQgOjeF
 BmzKxUSgjy27RN2f1b813SSelEcQhMb6Pt1aWCujFPYPL71iqafOdxyuHhywR5d95ztuHDPD1UI3C
 J6ZAAOeyIp4SjY2y24ySecsJfyQ3e8BP1eFTqXDmuIm0lc084o8adNX0KlW64yAhpp/xo5SHW/AKk
 waQpgvVxqK34cR39Ta3bCuBZAGrbRXmEDQMXz/6cQItFlPYZ3E23x4ITVv38rBO76B8DGpAY4b18U
 4ML6R/ZZ0Pxa+VJTHIMkqewsgWQ4Y4nBSuK4W5MjEZuSbIj3WVWH9jy0Ju+2wJRYsZVLoyLgAGYGz
 g/fFDDvX3x0IOguj24gEG7JMxjDNR2CYMrpEccpRm9mpfTM7F1J0ffIqUQx05FVhJiKI4gIb4v3p3
 rz7y2OpIbcEBIRNfGVG3xvZ+q1JwvBpw5e3RDZyIU=;
Received: from [2a02:8012:2f01:0:fe49:60b9:9856:b8ef]
 by mail.ilande.co.uk with esmtpsa (TLS1.3) tls
 TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256 (Exim 4.94.2)
 (envelope-from <mark.cave-ayland@ilande.co.uk>)
 id 1xVawn-0099ew-Kr; Mon, 23 Nov 2026 20:47:33 +0000
Message-ID: <c2927ef9-3a99-4fa0-b708-474d7cdb34f2@ilande.co.uk>
Date: Mon, 23 Nov 2026 20:48:25 +0000
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>,
 qemu-devel@nongnu.org
Cc: Laurent Vivier <laurent@vivier.eu>, "Michael S. Tsirkin"
 <mst@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>
References: <20261119220838.52034-1-philmd@oss.qualcomm.com>
 <20261119220838.52034-3-philmd@oss.qualcomm.com>
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
In-Reply-To: <20261119220838.52034-3-philmd@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 2a02:8012:2f01:0:fe49:60b9:9856:b8ef
X-SA-Exim-Mail-From: mark.cave-ayland@ilande.co.uk
Subject: Re: [PATCH 2/3] hw/dma/i8257: Zero the reserved bits of the mask
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

> The 82C37-compatible read/write-all-mask register has four
> channel-mask bits; the upper nibble is reserved and reads as
> zero (PIIX3 datasheet, section 2.5.1.5).
> The model reset it to all ones and exposed the reserved nibble.
> Keep only bits [3:0] in reset, write and read paths.
> 
> Fixes: 27503323968 ("Soundblaster 16 support")
> Signed-off-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>

Out of interest, does this solve a bug in that a guest OS functions incorrectly 
without the top nibble being all zero? Or is it just bring the emulated device in 
line with the behaviour described in the datasheet?

> ---
>   hw/dma/i8257.c | 7 ++++---
>   1 file changed, 4 insertions(+), 3 deletions(-)
> 
> diff --git a/hw/dma/i8257.c b/hw/dma/i8257.c
> index f44632de3db0..ade8609ff438 100644
> --- a/hw/dma/i8257.c
> +++ b/hw/dma/i8257.c
> @@ -242,7 +242,8 @@ static void i8257_write_cont(void *opaque, hwaddr nport, uint64_t data,
>   
>       case 0x05:                  /* reset */
>           d->flip_flop = 0;
> -        d->mask = ~0;
> +        /* bits [3:0] mask the four channels; bits [7:4] are reserved 0 */
> +        d->mask = 0x0f;
>           d->status = 0;
>           d->command = 0;
>           break;
> @@ -253,7 +254,7 @@ static void i8257_write_cont(void *opaque, hwaddr nport, uint64_t data,
>           break;
>   
>       case 0x07:                  /* write mask for all channels */
> -        d->mask = data;
> +        d->mask = data & 0x0f;
>           i8257_dma_run(d);
>           break;
>   
> @@ -282,7 +283,7 @@ static uint64_t i8257_read_cont(void *opaque, hwaddr nport, unsigned size)
>           d->status &= 0xf0;
>           break;
>       case 0x07:                  /* read all mask bits (RWAMB) */
> -        val = d->mask;
> +        val = d->mask & 0x0f;

Is this one actually needed if the above hunks guarantee that all writes only affect 
bits 0-3?

>           break;
>       default:
>           val = 0;


ATB,

Mark.


