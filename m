Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 68E2BC83F1B
	for <qemu-devel@archiver.kernel.org>; Fri, 11 Jul 2025 20:32:45 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uaKPt-0005EF-2Y; Fri, 11 Jul 2025 16:32:21 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mark.cave-ayland@ilande.co.uk>)
 id 1uaKFx-0000A3-5w
 for qemu-devel@nongnu.org; Fri, 11 Jul 2025 16:22:05 -0400
Received: from mail.ilande.co.uk ([2001:41c9:1:41f::167])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mark.cave-ayland@ilande.co.uk>)
 id 1uaKFv-0006N2-Dq
 for qemu-devel@nongnu.org; Fri, 11 Jul 2025 16:22:04 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=ilande.co.uk; s=20220518; h=Subject:Content-Transfer-Encoding:Content-Type:
 In-Reply-To:From:References:To:MIME-Version:Date:Message-ID:Sender:Reply-To:
 Cc:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID;
 bh=VCofH/j+GYRl4YFlbd5iGZi4kBubhZv0QsPoqVNXCdQ=; b=RW1PHjpqZUX+kexcZTY9IwJjdo
 i2mDQpXtsSrGAJc3zr/eIB52lvfVtgDVvmO0IItMOdrDWJxj/ppn0C3l0W5Zfb3fglbE8mnrPuv/e
 2MJgBnCwvgMlXXq4CR1i/8vmdTIJfJtAQ7udtS38139KojY4XhViM3FaW9J97uq4nNZsYaYP1Isav
 u0zb5lNwFog/M1sbOE2BLDggmufMh0QT92oYBINrBYpYdwsw3Zbd9xxCX0twLDNvLs7rH+I+Lk5R3
 gmxZSPeW0ccQdrOxMv80ymjPbvJ/ztIwvzRLHlpz+D/CrcWZFZkQq8+24LgW4pjUmTZH9hxdiRq0s
 8Fdn1KZDlwPHJxYZ2DJ6WFRQGnG9kTgmZf+Z945eLKRT+7Xas6+J6g50e+ogGeRaIxASD8PNSKzJm
 amgNxUIXIldeltWdg4wy0JgDbdUaypUZ7oRcl1MuSZkEejUHi9zNvbmiK+JXTojOVESgKRNI41TuY
 v2WneNBeEAP+zcUJSSFe6yQjgfANDrTDXRQTTusmaMWd/WMZv8p91QgXo/EtYfzQrX4iMXos1Q3SM
 4gkirw2P0oQaad0Ijea7kmx0cMgsElhSfml0nLez2QOHvPSe1eFQRVYVaF0scUq0rGu07Q2uEssDc
 jUjDIlAJ8jvl4CGiK4rnTHkKCs0LOyDJCfbCBIpXc=;
Received: from [2a02:8012:2f01:0:d1ff:478a:c096:2d0c]
 by mail.ilande.co.uk with esmtpsa (TLS1.3:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.92) (envelope-from <mark.cave-ayland@ilande.co.uk>)
 id 1uaKEH-000Bao-UA; Fri, 11 Jul 2025 21:20:22 +0100
Message-ID: <fe2518b0-6d2c-44c2-bc32-a166fa85133b@ilande.co.uk>
Date: Fri, 11 Jul 2025 21:21:58 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 pbonzini@redhat.com, fam@euphon.net, qemu-devel@nongnu.org
References: <20250618061249.743897-1-mark.cave-ayland@ilande.co.uk>
 <30d03eef-c0d8-4864-87d9-a3674d8f64a1@ilande.co.uk>
 <a515b6ad-b10d-4a78-9960-f75f3189adaf@linaro.org>
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
In-Reply-To: <a515b6ad-b10d-4a78-9960-f75f3189adaf@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 2a02:8012:2f01:0:d1ff:478a:c096:2d0c
X-SA-Exim-Mail-From: mark.cave-ayland@ilande.co.uk
Subject: Re: [PATCH v2 0/7] esp.c: only allow ESP commands permitted in the
 current mode
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

On 09/07/2025 12:16, Philippe Mathieu-Daudé wrote:

> Hi Mark,
> 
> On 9/7/25 09:50, Mark Cave-Ayland wrote:
>> On 18/06/2025 07:12, Mark Cave-Ayland wrote:
>>
>>> This series contains a few minor tidy-ups along with an implementation of the
>>> logic to only allow ESP commands permitted in the current mode. The motivation
>>> is to fix GitLab issue #2464 which causes Windows NT MIPS to bluescreen on
>>> boot.
>>>
>>> Patches 1 to 5 are simple tidy-ups from investigating the issue. Patch 6 adds
>>> a new asc_mode variable to indicate the current ESP mode, whilst patch 7 implements
>>> the feature which fixes GitLab issue #2464.
>>>
>>> Note: this series is being reposted as both the SeaBIOS and SeaBIOS hppa binaries
>>> currently distributed with QEMU have now been fixed so that they do not use an
>>> illegal ESP command sequence.
> 
> 
>>> Mark Cave-Ayland (7):
> 
>>>    esp.c: add asc_mode property to indicate the current ESP mode
>>>    esp.c: only allow ESP commands permitted in the current asc_mode
>>>
>>>   hw/scsi/esp.c         | 94 +++++++++++++++++++++++++++++++++++++------
>>>   hw/scsi/trace-events  |  1 +
>>>   include/hw/scsi/esp.h | 15 ++++++-
>>>   3 files changed, 96 insertions(+), 14 deletions(-)
>>
>> Ping?
> 
> I reviewed 1-5 but don't have sufficient knowledge for 6-7 so
> will defer these to Paolo.

Thanks Phil, I really appreciate your effort to help out here.


ATB,

Mark.


