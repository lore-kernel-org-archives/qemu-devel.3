Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 978F7D65C7B
	for <qemu-devel@archiver.kernel.org>; Thu, 14 Nov 2024 11:30:18 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tBY2M-0001Om-HY; Thu, 14 Nov 2024 06:29:22 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mark.cave-ayland@ilande.co.uk>)
 id 1tBY2K-0001OR-Sq; Thu, 14 Nov 2024 06:29:20 -0500
Received: from mail.ilande.co.uk ([2001:41c9:1:41f::167])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mark.cave-ayland@ilande.co.uk>)
 id 1tBY2J-0005x7-96; Thu, 14 Nov 2024 06:29:20 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=ilande.co.uk; s=20220518; h=Subject:Content-Transfer-Encoding:Content-Type:
 In-Reply-To:From:References:Cc:To:MIME-Version:Date:Message-ID:Sender:
 Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender
 :Resent-To:Resent-Cc:Resent-Message-ID;
 bh=W3AI7IS9qrTP42Lc1laGrFqKyvmg4qp8sIK1zuixVsY=; b=ZA9lXTc8WuKUS766F/thIQhNz/
 YW1PZb0rf1rHHvO/OMYBtYBgladQK3eu3nBR3rmDDGk9yrGIdtFFsCFZ7VlPh0REPt5pqpPyDiTcH
 24QNYsNNDm3fTvDdAPHyEb2EZsN4f6KLC1lTw2lSuknp3KZoFPF0gJz9iX1Si9LWg2lepVgoFgz+3
 D861cGZIsgzcCfRqRpHpzRwhC+aH91Hcd87EF/IAN55u4ZsnP5zeq0az48vibwv8+gB1YMMI0YIZB
 X0qDi1r9gB6PQ5EKcmZCsCvJSc0cvh+5MZ3qVJx4Fv42m80spNenh4lWZVw8cOOSOPl++ytT7l4aW
 rHNrSMbJBg+wMc1+qAQiCK01ZhGHTqByo6cFqbhczsRDb6siq0Q4YKF/WC8PI95BVaHQ3KHK8Ffqp
 skGz29MDAZW2CVRguXepNnT0ObRtQi9Q5rRSDylWJvpN4zWFb1L6tJ5n8UcNRJzIVB0GDD6MAZL6j
 liehM/grkdsB8Jj0aCr+YSOJRThWmi+jGZSuY/mLGbvwq6ESZO88I2h1EEie50W5WBnTIw+NxlII/
 pXpV5XID28BVYuQRD8sg43LEvB4x0Wy5m+grqqxOuJ137VN9Joppt8/Voi7gQgsU4oMNQtr115tFB
 KfEDfpmUqEKd/VGrMZjYGsVdFTj36MKSHk5KYcUYc=;
Received: from [2a00:23c4:8bb8:f600:5ed9:3847:b293:b96]
 by mail.ilande.co.uk with esmtpsa (TLS1.3:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.92) (envelope-from <mark.cave-ayland@ilande.co.uk>)
 id 1tBY1o-0002lv-Er; Thu, 14 Nov 2024 11:28:52 +0000
Message-ID: <2b8a7ab4-3295-4b9a-b383-5be680e9d5df@ilande.co.uk>
Date: Thu, 14 Nov 2024 11:29:07 +0000
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: Thomas Huth <thuth@redhat.com>, qemu-devel@nongnu.org,
 Laurent Vivier <laurent@vivier.eu>
Cc: qemu-ppc@nongnu.org, qemu-stable@nongnu.org
References: <20241114104653.963812-1-thuth@redhat.com>
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
In-Reply-To: <20241114104653.963812-1-thuth@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-SA-Exim-Connect-IP: 2a00:23c4:8bb8:f600:5ed9:3847:b293:b96
X-SA-Exim-Mail-From: mark.cave-ayland@ilande.co.uk
Subject: Re: [PATCH] hw/misc/mos6522: Fix bad class definition of the MOS6522
 device
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

On 14/11/2024 10:46, Thomas Huth wrote:

> When compiling QEMU with --enable-cfi, the "q800" m68k machine
> currently crashes very early, when the q800_machine_init() function
> tries to wire the interrupts of the "via1" device.
> This happens because TYPE_MOS6522_Q800_VIA1 is supposed to be a
> proper SysBus device, but its parent (TYPE_MOS6522) has a mistake
> in its class definition where it is only derived from DeviceClass,
> and not from SysBusDeviceClass, so we end up in funny memory access
> issues here. Using the right class hierarchy for the MOS6522 device
> fixes the problem.
> 
> Resolves: https://gitlab.com/qemu-project/qemu/-/issues/2675
> Signed-off-by: Thomas Huth <thuth@redhat.com>
> ---
>   include/hw/misc/mos6522.h | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/include/hw/misc/mos6522.h b/include/hw/misc/mos6522.h
> index fba45668ab..920871a598 100644
> --- a/include/hw/misc/mos6522.h
> +++ b/include/hw/misc/mos6522.h
> @@ -154,7 +154,7 @@ struct MOS6522State {
>   OBJECT_DECLARE_TYPE(MOS6522State, MOS6522DeviceClass, MOS6522)
>   
>   struct MOS6522DeviceClass {
> -    DeviceClass parent_class;
> +    SysBusDeviceClass parent_class;
>   
>       ResettablePhases parent_phases;
>       void (*portB_write)(MOS6522State *dev);

Ooof. I suspect I started using DeviceClass first before switching to 
SysBusDeviceClass later to implement reset functionality. Anyhow the patch looks 
good: thanks Thomas!

Reviewed-by: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>


ATB,

Mark.


