Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3140EC021B2
	for <qemu-devel@archiver.kernel.org>; Thu, 20 Feb 2025 11:14:55 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tl4VQ-0006Dt-62; Thu, 20 Feb 2025 06:14:12 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mark.cave-ayland@ilande.co.uk>)
 id 1tl4VN-0006Cy-FM; Thu, 20 Feb 2025 06:14:09 -0500
Received: from mail.ilande.co.uk ([2001:41c9:1:41f::167])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mark.cave-ayland@ilande.co.uk>)
 id 1tl4VL-0003mv-SO; Thu, 20 Feb 2025 06:14:09 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=ilande.co.uk; s=20220518; h=Subject:Content-Transfer-Encoding:Content-Type:
 In-Reply-To:From:References:Cc:To:MIME-Version:Date:Message-ID:Sender:
 Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender
 :Resent-To:Resent-Cc:Resent-Message-ID;
 bh=1TjiGVeDa5KTorfSUvsBfSobpdd/BWE/X/TfHQaoyqw=; b=gsgl4IKhUeSN0p8MN7MOpEYe/y
 nlwfEoLepGGz9F8+XkcETtyaWs0Rx8s1+3NlMXVOI6Yxpyefbw/iFyNB9bW+ezEmiXFnYdksvaL3D
 sZY2fEBU6zoGrhWW5lHrd7MIdsIm6X8XiiXUqX4ylAw7lf7rbRvzLQOVG2UMRfUmNHt1quNHJp8pw
 mUq52HKQ2p3HxgDB7MQsdFWKxzs/6qMY2W4MjrtysIDq573c+dsGOemtivITF1Ue5RiLg83y0/c3k
 wgjIwe243uxW34r2GYiZp/FeudSH5brH+SgriwLhudIMORnnuKxkMdOwBh4FH0FfXMS9ChB+qkjir
 Mkp7wDB1VyiYqfXw3adSKT5TEhQ490rjF2Gt+BGo/3rYL+o8LMnxk+Ejn8i4Qfq3Ny+i1Dytqnq0I
 pKXb786D0fxEs5eUEbuVyMr7qdmtmgvKqzy5t0PKBtpBO5EW7IW9JN8rXko7hqEl9tEvRg8LOBomk
 Xo5kk7QxTSZbLlWGdx8KmmSOz9EPfzSfqfAgKveGA/Kwz5UwwFTz2j3TmMO/+WXznviNR2XVxZsWV
 xveszWftZ0J+tyQqqv0HwdF+9HIrqJMXarW/fM+HLuxWtVr72CUk/ERxnFEqEL+SzGhOtoQobX9K8
 d4dAef+sY0L2aDvR23mSvN8zeKipUGBkzxifB3x0w=;
Received: from [2a02:8012:c93d:0:260e:bf57:a4e9:8142]
 by mail.ilande.co.uk with esmtpsa (TLS1.3:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.92) (envelope-from <mark.cave-ayland@ilande.co.uk>)
 id 1tl4UN-00042y-SD; Thu, 20 Feb 2025 11:13:08 +0000
Message-ID: <96e05cf9-057d-465c-a411-24bfb592b736@ilande.co.uk>
Date: Thu, 20 Feb 2025 11:13:58 +0000
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 QEMU Developers <qemu-devel@nongnu.org>
Cc: Laurent Vivier <laurent@vivier.eu>,
 Daniel Henrique Barboza <danielhb413@gmail.com>,
 Markus Armbruster <armbru@redhat.com>,
 =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Peter Maydell
 <peter.maydell@linaro.org>, qemu-ppc@nongnu.org,
 Artyom Tarasenko <atar4qemu@gmail.com>, =?UTF-8?Q?Alex_Benn=C3=A9e?=
 <alex.bennee@linaro.org>
References: <97e66ba5-488f-4246-b4d9-466d29a86dff@linaro.org>
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
In-Reply-To: <97e66ba5-488f-4246-b4d9-466d29a86dff@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 2a02:8012:c93d:0:260e:bf57:a4e9:8142
X-SA-Exim-Mail-From: mark.cave-ayland@ilande.co.uk
Subject: Re: Any plan for command line '-g' option (graphical resolution and
 depth)?
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

On 20/02/2025 09:20, Philippe Mathieu-Daudé wrote:

> Hi,
> 
> QEMU provides the global '-g' CLI option:
> 
> $ qemu-system-foo --help
> 
>    -g WxH[xDEPTH]  Set the initial graphical resolution and depth
> 
> This option is used to pass resolution/depth information to guest
> firmwares in the machines defined in the following files:
> 
>    hw/ppc/mac_newworld.c
>    hw/ppc/mac_oldworld.c
>    hw/ppc/prep.c
>    hw/ppc/spapr.c
>    hw/sparc/sun4m.c
>    hw/sparc64/sun4u.c
> 
> Examples:
> 
> - hw/ppc/spapr.c:1102:
> 
>    _FDT(fdt_setprop_cell(fdt, c, "qemu,graphic-width", graphic_width));
> 
> - hw/sparc64/sun4u.c:716:
> 
>    fw_cfg_add_i16(fw_cfg, FW_CFG_SPARC64_WIDTH, graphic_width);
> 
> 
> Obviously we have default values, which are different per architecture!
> Clearly these ought to be machine properties.

At least for VGA it is possible to use VGA via the width and height properties to set 
the initial values i.e. on the command line with -device VGA,width=1024,height=768 
and then use an EDID parser to get the information in the firmware. But then we hit 
the same problem of how to set these properties from the command line on in-built 
devices again.

> It is also used to set TYPE_NUBUS_MACFB properties in hw/m68k/q800.c.
> Here i suppose we could directly use '-global nubus-macfb.width=value'
> etc. although I'm not sure it is the recommended way.

This approach should work, however -global feels more like a big hammer as opposed to 
a proper solution. In particular it doesn't work if you have e.g. multiple screens 
that you want set to different resolutions.

> Should we start deprecating '-g' as a whole?

I think there should be a better way to consolidate the default resolution selection 
on display devices (particularly in the case of multiple displays), so yes.


ATB,

Mark.


