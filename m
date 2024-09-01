Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 78B9ACA101E
	for <qemu-devel@archiver.kernel.org>; Sun,  1 Sep 2024 12:14:51 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1skjSr-0002BI-K0; Sun, 01 Sep 2024 08:13:53 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mark.cave-ayland@ilande.co.uk>)
 id 1skjSo-0002Ae-L7
 for qemu-devel@nongnu.org; Sun, 01 Sep 2024 08:13:50 -0400
Received: from mail.ilande.co.uk ([2001:41c9:1:41f::167])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mark.cave-ayland@ilande.co.uk>)
 id 1skjSl-0001r4-S4
 for qemu-devel@nongnu.org; Sun, 01 Sep 2024 08:13:49 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=ilande.co.uk; s=20220518; h=Subject:Content-Transfer-Encoding:Content-Type:
 In-Reply-To:From:References:Cc:To:MIME-Version:Date:Message-ID:Sender:
 Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender
 :Resent-To:Resent-Cc:Resent-Message-ID;
 bh=lUIvVvJ59NgPyCR28QUL5EbSWTpRRsf0iPCdPr7AGjU=; b=mJ5n4fx66UdKpp0GklMKhrkcv4
 SU2sLR56vaUbXHrUdGpR5g/pcpIQm9EoRhfSFoK/VGnQw/wosrL6Oq+hEzdxIFSmsw1bsyK3ROEUA
 emAPxdkHoIJy7Z+EW5U4ib0rZxvFaJbR6LXaUq1ukphP0u9+bngOvFn2ME/3YIJsPAUrrSAlyotmA
 T1mYWGHChxyVN0yyAybFKxP3gnV61vXJaPpNQKpTlkWkZVTgQH9+RQW+sV6Nwwly9Yw8dkkIl3ANw
 xaVfqkhK3ZJ1IkbhhvTVXvjAVCespO8DQekFwFnRxEC6PAjwAnKlH0rAVF78qHX2a1fn//efGhrHa
 yDNXOnwIEO/Xorst0y5zgLu9vH4zwqQNbIQOx+Aqrsm5Og671pdO737A/8ogupl2mkq7ebDIY1Nhf
 D9mzXWbhO+zlZxsoW2u1UgNktVuvwizi/NQzM4HTypKUVoW5QN4pqrYWwM4ghgsR6qnbISGXHo9AJ
 e7nglWH2a8IFSl4oOH38e+vksbeW7eBUHHRiRhEk4LBbCYRZ3TcoqQ38QVWXx4/Lo5PT7LlSMgdM7
 iiPYq93u/wWEqAxP3YrrPLi+SC/PxBJ6pJQFkIMAA97vihTOPiC59Nsj2gQ7aIWx9ucZYELTrQfxn
 YNPk9sOkqZglT7rtQ3FKJEP08gfkWpWFprWC1JfyY=;
Received: from [2a00:23c4:8bb4:4000:ad5:9c31:686a:e195]
 by mail.ilande.co.uk with esmtpsa (TLS1.3:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.92) (envelope-from <mark.cave-ayland@ilande.co.uk>)
 id 1skjSQ-000BP1-8P; Sun, 01 Sep 2024 13:13:30 +0100
Message-ID: <1dbcc1f6-95b1-4d55-a1da-7a8dcc1abf81@ilande.co.uk>
Date: Sun, 1 Sep 2024 13:13:33 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: Peter Maydell <peter.maydell@linaro.org>, qemu-devel@nongnu.org
Cc: Thomas Huth <huth@tuxfamily.org>, Laurent Vivier <laurent@vivier.eu>
References: <20240830173452.2086140-1-peter.maydell@linaro.org>
 <20240830173452.2086140-4-peter.maydell@linaro.org>
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
In-Reply-To: <20240830173452.2086140-4-peter.maydell@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-SA-Exim-Connect-IP: 2a00:23c4:8bb4:4000:ad5:9c31:686a:e195
X-SA-Exim-Mail-From: mark.cave-ayland@ilande.co.uk
Subject: Re: [PATCH 3/3] hw/nubus/nubus-device: Range check 'slot' property
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

On 30/08/2024 18:34, Peter Maydell wrote:

> The TYPE_NUBUS_DEVICE class lets the user specify the nubus slot
> using an int32 "slot" QOM property.  Its realize method doesn't do
> any range checking on this value, which Coverity notices by way of
> the possibility that 'nd->slot * NUBUS_SUPER_SLOT_SIZE' might
> overflow the 32-bit arithmetic it is using.
> 
> Constrain the slot value to be less than NUBUS_SLOT_NB (16).
> 
> Resolves: Coverity CID 1464070
> Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
> ---
>   hw/nubus/nubus-device.c | 7 +++++++
>   1 file changed, 7 insertions(+)
> 
> diff --git a/hw/nubus/nubus-device.c b/hw/nubus/nubus-device.c
> index be4cb246966..26fbcf29a2b 100644
> --- a/hw/nubus/nubus-device.c
> +++ b/hw/nubus/nubus-device.c
> @@ -35,6 +35,13 @@ static void nubus_device_realize(DeviceState *dev, Error **errp)
>       uint8_t *rom_ptr;
>       int ret;
>   
> +    if (nd->slot < 0 || nd->slot >= NUBUS_SLOT_NB) {
> +        error_setg(errp,
> +                   "'slot' value %d out of range (must be between 0 and %d)",
> +                   nd->slot, NUBUS_SLOT_NB - 1);
> +        return;
> +    }
> +
>       /* Super */
>       slot_offset = nd->slot * NUBUS_SUPER_SLOT_SIZE;

Reviewed-by: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>


ATB,

Mark.


