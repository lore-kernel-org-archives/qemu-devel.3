Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 56D0BCCA490
	for <qemu-devel@archiver.kernel.org>; Sun, 18 Oct 2026 09:26:07 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xIN9P-0003Oz-9N; Sun, 18 Oct 2026 05:25:55 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mark.cave-ayland@ilande.co.uk>)
 id 1xIN9L-0003OS-2O
 for qemu-devel@nongnu.org; Sun, 18 Oct 2026 05:25:52 -0400
Received: from mail.ilande.co.uk ([2001:41c9:1:41f::167])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mark.cave-ayland@ilande.co.uk>)
 id 1xIN9H-0003Za-5X
 for qemu-devel@nongnu.org; Sun, 18 Oct 2026 05:25:50 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=ilande.co.uk; s=20220518; h=Subject:Content-Transfer-Encoding:Content-Type:
 In-Reply-To:From:References:Cc:To:MIME-Version:Date:Message-ID:Sender:
 Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender
 :Resent-To:Resent-Cc:Resent-Message-ID;
 bh=5FOXH990qWfzOAhWdU/N7mHiHb/OsolU1Dpk6ZxzOao=; b=oe+P4xeHRKJlxkpZL2dWRYBFzv
 22e8gHpvndT3x8Qxu3rPNkTgaD91vFWJVQmrn7Hrb+JZVhdJFkh3acNhc75rpsXwq28Er9V+z24PE
 9n9rUZ0PDin3lh9L0KQ4H86Wbv1RpyblJYhnjVZPxPXIxV+ghhC3u4hN1b7uW+HvJ2U3ZPrIDhIV0
 VF0g2tp2p9IbfXbPMr9+RKdjpETEhoOJzmNI0+CXxXu37zg5BTI2Vxm2HBhzCJg9SyLgVBOtgkL72
 W+CsLUxI22Exxj7nVXDJPpMfGLcsmN5HvPX2dn6Xtih0De2qvBWBHnvrWfWElgsqFZZTomZX/1UWF
 U3QCPVw5UmGF2sVpYys+Bjaj49S4OMygp2gQMgSGtY+aLJBhdfMPCXF6opEJ2QYjigf/fJY9+gvYb
 rbIBGagMKtb0HnyEL2leb5t4tBTt8XVzICTOPhfEs4qth4qiZVBz6RvMPoMvUncFS8+YlVxuFiwDW
 tlEushpdkWQ1MxhEJzYTwv6lBMGJxWMtMpJ3o+iwJz/DIb4bLHSpKPzJj4hQ1W3CftzIqtOpPAHL8
 fGMaFKEpNTgNnnUrSSIDE/IW9cNC/SrqvKjmxNA3iWOgisfOh6NszUv31wt6383jSPM9YBD4qoZ3Q
 zGtXxqlBA3yiLbGpHiw01ldD9T2fkGqTRGEfjFI4g=;
Received: from [2a02:8012:2f01:0:7620:997c:c9a4:6fba]
 by mail.ilande.co.uk with esmtpsa (TLS1.3) tls
 TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256 (Exim 4.94.2)
 (envelope-from <mark.cave-ayland@ilande.co.uk>)
 id 1xIN8Z-002N3r-RO; Sun, 18 Oct 2026 10:25:04 +0100
Message-ID: <4d098749-fc9d-46c8-99f8-67d6414279e9@ilande.co.uk>
Date: Sun, 18 Oct 2026 10:25:43 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: =?UTF-8?Q?Frode_Tenneb=C3=B8?= <frode@tennebo.com>, qemu-devel@nongnu.org
Cc: Artyom Tarasenko <atar4qemu@gmail.com>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
References: <20260919-add_hostid_sub-properties-v1-0-cc1667c0a8ad@tennebo.com>
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
In-Reply-To: <20260919-add_hostid_sub-properties-v1-0-cc1667c0a8ad@tennebo.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 2a02:8012:2f01:0:7620:997c:c9a4:6fba
X-SA-Exim-Mail-From: mark.cave-ayland@ilande.co.uk
Subject: Re: [PATCH 0/3] hw/sparc, hw/sparc64: add hostid=/machineid= -machine
 properties
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
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

On 19/09/2026 15:56, Frode Tennebø wrote:

> This series adds "hostid" and "machineid" as -machine sub-properties
> for the sun4m and sun4u/sun4v machine families:
> 
>      qemu-system-sparc  -machine SS-20,hostid=0x352e09,machineid=0x80
>      qemu-system-sparc64 -machine sun4u,hostid=0x352e09,machineid=0x72
> 
> Background: these machines report a classic 32-bit Sun "hostid" to
> the guest OS (as read by hostid(1), and historically use by some
> software for license checks), built from two independent pieces stored
> in the emulated NVRAM/IDPROM - a fixed per-model machine-type byte, and
> the low 24 bits of the machine's Ethernet MAC address. QEMU already
> reproduces this scheme, but until now neither half was settable from
> the command line: the machine-type byte was fixed per hwdef, and the
> low 24 bits always tracked whatever MAC ended up on the emulated NIC.
> Both properties default to that existing behaviour when left unset,
> so this series is fully backward compatible.
> 
> Patch 1 adds a small shared helper (hw/sparc/sun_hostid.c) rather
> than duplicating the property getter/setter logic between the two
> machine families: a generic SunHostIDProps struct that a machine's
> own instance struct embeds anywhere, located via byte offset, plus
> two functions to register the properties on a class and initialise
> an instance.
> 
> Patch 2 wires this into sun4m, via the existing sun4m-common
> abstract machine class.
> 
> Patch 3 wires it into sun4u/sun4v. Since sun4u.c had no shared
> abstract machine class before this series, patch 3 introduces one
> (sun4u-common) as the parent of both "sun4u" and "sun4v", and
> registers the properties on it once - both machines pick them up
> through QOM's class-hierarchy property lookup. The "niagara" machine
> (hw/sparc64/niagara.c) is a separate machine family that does not
> use this NVRAM/IDPROM hostid mechanism and is unaffected.
> 
> PS: This is my first patch set for QEMU.
> 
> ---
> Frode Tennebø (3):
>        hw/sparc: add shared sun_hostid helper for hostid/machineid properties
>        hw/sparc: add hostid= and machineid= -machine sub-properties
>        hw/sparc64: add hostid= and machineid= -machine sub-properties
> 
>   docs/system/target-sparc.rst   | 23 +++++++++++
>   docs/system/target-sparc64.rst | 22 +++++++++++
>   hw/sparc/meson.build           |  1 +
>   hw/sparc/sun4m.c               | 55 ++++++++++++++++++++++----
>   hw/sparc/sun_hostid.c          | 88 ++++++++++++++++++++++++++++++++++++++++++
>   hw/sparc64/meson.build         |  1 +
>   hw/sparc64/sun4u.c             | 74 +++++++++++++++++++++++++++++++----
>   include/hw/nvram/sun_nvram.h   | 11 ++++--
>   include/hw/sparc/sun_hostid.h  | 48 +++++++++++++++++++++++
>   9 files changed, 306 insertions(+), 17 deletions(-)
> ---
> base-commit: f8296b816fabd370307cd22b0270b610fc0fa279
> change-id: 20260917-add_hostid_sub-properties-473a0d2ea35e
> 
> Best regards,

Thanks for the series. Just out of curiosity, what is the use case for this? Normally 
people want to change the hostid for licensing reasons (i.e. so that the virtual 
machine matches a real one), but I'd expect that to be already possible?


ATB,

Mark.


