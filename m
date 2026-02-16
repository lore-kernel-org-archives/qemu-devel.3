Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BE0DBE83835
	for <qemu-devel@archiver.kernel.org>; Mon, 16 Feb 2026 21:03:18 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vs5kB-0005GF-LI; Mon, 16 Feb 2026 16:03:00 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mark.cave-ayland@ilande.co.uk>)
 id 1vs5k0-0005Fq-1p; Mon, 16 Feb 2026 16:02:48 -0500
Received: from mail.ilande.co.uk ([2001:41c9:1:41f::167])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mark.cave-ayland@ilande.co.uk>)
 id 1vs5jy-0004EK-Gg; Mon, 16 Feb 2026 16:02:47 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=ilande.co.uk; s=20220518; h=Subject:Content-Transfer-Encoding:Content-Type:
 In-Reply-To:From:References:Cc:To:MIME-Version:Date:Message-ID:Sender:
 Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender
 :Resent-To:Resent-Cc:Resent-Message-ID;
 bh=CAkzSoL0ZjHkhFLJjjLL6QsxICsgIr1E5kdFcdvhEVo=; b=ZRIFSRQ8NdJ+ut13TWcXRnWUAK
 9Qv5/zDvXvouzsch8Frrhg8YhyqL1CGnjxolbiM0aJDMvtN4+4L3AppSd0Pmp3ICFG4PGOaDV/Pl5
 Ye02oRLzwg6cu94rnIxqWflR8J9s3hJJIUlGAW0n/d3vjou7bj4ZgUE+Q3VCQbRJryweoQq+8b1hU
 oS5skg4UalLPLRpz9tDa7C5la6aoE2RwASYjcdU8Io6rUkhu6BdGbQK6S1gSRcFLY9m8us+XwzLVA
 +PiQ/VHpn18C87gxAdzEWhTFqX1G8APLdWh9bgRMZpOFRqLo+SF/augUqXPdXKMyPpaeS6/B48FHu
 5NgAnG0fVo+ftR4N/SznPyXcY0CcjOMm712gtdpv8gY1FlRjSIj/IWOM8e+MiLGJMo19coTUV3L/R
 5hulyGfjL+RGQUD0l9n3g7wnmWCJx3D0jHE4jK7MsHnfFZbXqk7HY0ne/ApE0tYo6spNMSssVVfqm
 Nm4n4+Ceb0xIOl7U2qjlMoBfwH5YFZKr3KQX3YrfJpV9RXTgiJmS4cFUh+PYOEqEAsCPmERn3XF/f
 qSnK8cqehSsD0f30tlmMHqpIbULU0DPMMS2q6pEKLxeEZ9+nygttz8IjVa0tBa/u4cRbOgtXTskEp
 qqSx2RnSg9auqBVOTbTIN+qkQmgQY6NPabdCwEMY0=;
Received: from [2a02:8012:2f01:0:f01d:4e0f:6874:3706]
 by mail.ilande.co.uk with esmtpsa (TLS1.3:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.92) (envelope-from <mark.cave-ayland@ilande.co.uk>)
 id 1vs5h4-000CcB-3s; Mon, 16 Feb 2026 20:59:49 +0000
Message-ID: <9ba89ff7-187d-452c-a264-5c0a698beb63@ilande.co.uk>
Date: Mon, 16 Feb 2026 21:02:36 +0000
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 qemu-devel@nongnu.org
Cc: Chinmay Rath <rathc@linux.ibm.com>,
 =?UTF-8?Q?Herv=C3=A9_Poussineau?= <hpoussin@reactos.org>,
 Harsh Prateek Bora <harshpb@linux.ibm.com>,
 Nicholas Piggin <npiggin@gmail.com>, Artyom Tarasenko <atar4qemu@gmail.com>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>, qemu-ppc@nongnu.org,
 Laurent Vivier <laurent@vivier.eu>
References: <20260214021240.58657-1-philmd@linaro.org>
 <20260214021240.58657-6-philmd@linaro.org>
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
In-Reply-To: <20260214021240.58657-6-philmd@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 2a02:8012:2f01:0:f01d:4e0f:6874:3706
X-SA-Exim-Mail-From: mark.cave-ayland@ilande.co.uk
Subject: Re: [PATCH 5/8] hw/m68k: Set graphic display dimensions generically
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

On 14/02/2026 02:12, Philippe Mathieu-Daudé wrote:

> If a dimension is not set, have the machine init code
> (q800_machine_init) set the default value.
> 
> Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
> ---
>   hw/m68k/q800.c          | 6 +++---
>   system/globals-target.c | 6 +++---
>   2 files changed, 6 insertions(+), 6 deletions(-)
> 
> diff --git a/hw/m68k/q800.c b/hw/m68k/q800.c
> index ba32da2fa45..ded531394e6 100644
> --- a/hw/m68k/q800.c
> +++ b/hw/m68k/q800.c
> @@ -560,9 +560,9 @@ static void q800_machine_init(MachineState *machine)
>                               TYPE_NUBUS_MACFB);
>       dev = DEVICE(&m->macfb);
>       qdev_prop_set_uint32(dev, "slot", 9);
> -    qdev_prop_set_uint32(dev, "width", graphic_width);
> -    qdev_prop_set_uint32(dev, "height", graphic_height);
> -    qdev_prop_set_uint8(dev, "depth", graphic_depth);
> +    qdev_prop_set_uint32(dev, "width", graphic_width ?: 800);
> +    qdev_prop_set_uint32(dev, "height", graphic_height ?: 600);
> +    qdev_prop_set_uint8(dev, "depth", graphic_depth ?: 8);
>       qdev_realize(dev, BUS(nubus), &error_fatal);
>   
>       macfb_mode = (NUBUS_MACFB(dev)->macfb).mode;
> diff --git a/system/globals-target.c b/system/globals-target.c
> index 989720591e7..e3f7d846ac0 100644
> --- a/system/globals-target.c
> +++ b/system/globals-target.c
> @@ -14,9 +14,9 @@ int graphic_width = 1024;
>   int graphic_height = 768;
>   int graphic_depth = 8;
>   #elif defined(TARGET_M68K)
> -int graphic_width = 800;
> -int graphic_height = 600;
> -int graphic_depth = 8;
> +int graphic_width;
> +int graphic_height;
> +int graphic_depth;
>   #else
>   int graphic_width = 800;
>   int graphic_height = 600;

Reviewed-by: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>


ATB,

Mark.


