Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 26073C4345F
	for <qemu-devel@archiver.kernel.org>; Fri, 19 Apr 2024 05:39:47 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rxgxr-00016q-FD; Fri, 19 Apr 2024 01:39:11 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mark.cave-ayland@ilande.co.uk>)
 id 1rxgxo-00016D-JC
 for qemu-devel@nongnu.org; Fri, 19 Apr 2024 01:39:09 -0400
Received: from mail.ilande.co.uk ([2001:41c9:1:41f::167])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mark.cave-ayland@ilande.co.uk>)
 id 1rxgxk-0005yT-ET
 for qemu-devel@nongnu.org; Fri, 19 Apr 2024 01:39:08 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=ilande.co.uk; s=20220518; h=Subject:Content-Transfer-Encoding:Content-Type:
 In-Reply-To:From:References:Cc:To:MIME-Version:Date:Message-ID:Sender:
 Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender
 :Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=ACxgmyBw3FKiwNBNk5R/XaVi9kSoroW1EBB1ATDf11E=; b=e7EiqBbm0EoG3xHWnsxoXvoDcC
 tSKhLGtC2BqwLNasYx9gK8HbZEvL2VzIrrGynChn/MiLuNIp3+8XHD81c32HIsu01LnhvwSCF57n0
 AUT1YvD1AN9UH5yCzCc5fDaC1FGcF09ZPncgOwozR765vH/MEYM9+pNz2cArxSLklWbbPeEOvgafi
 QullumKNJ0FLhRDobXTsjfrOPN3MiJU3PD+W9w82le79Yoz6GVGJeA3cO+pMainE4tJ12hKZgJR7m
 5w74bTNNZxAH5WpyL1ORvHKAsYprFHkBUj2fvBIXYGW39ZFK4MkaKXdaqiMzEvL5fXhMFKBI6zJIa
 wT5uDQ8gbljzZI8FRvJwjR0dRFFS0S87IfGgXa52uDdbmvU++fD7Q+DJ4zTvoyT/5Xim/z2yKUYIo
 dv39kfQi53d5U8VHRkMe3ijRv9Xxhbys6tk5T/YpzD4Hvpj4aD7t/d/w2gPMvV577HMChlc2pcdBB
 f4rkI93dmedw2WJkU1moLLhpa11j0OnN8wV18NwmLYTFI1SCAzCzmBRRC/mfZOb05gGpRBbVpCtrP
 RtmivLPFdZHZ5nJOCZYuwFeuJyWYSmqtGOci9I+i1bibHHqk+BSAf8+gra7sZ+duE1lSPXwrxGwVY
 H/7ReMppkUBOD7BBYlRwEokzj+C9ZHTEWdhweix7A=;
Received: from [2a00:23c4:8bb4:4000:aae1:b0e7:6998:7ece]
 by mail.ilande.co.uk with esmtpsa (TLS1.3:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.92) (envelope-from <mark.cave-ayland@ilande.co.uk>)
 id 1rxgwj-000CWv-4b; Fri, 19 Apr 2024 06:38:01 +0100
Message-ID: <bfcad1f0-c03a-40d7-a50f-ffb32130170a@ilande.co.uk>
Date: Fri, 19 Apr 2024 06:38:59 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: Thomas Huth <thuth@redhat.com>, qemu-devel@nongnu.org,
 Artyom Tarasenko <atar4qemu@gmail.com>
Cc: Eduardo Habkost <eduardo@habkost.net>,
 =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>
References: <20240307174334.130407-1-thuth@redhat.com>
 <20240307174334.130407-5-thuth@redhat.com>
 <529ece4e-1de6-4941-bb75-c10997aad13c@ilande.co.uk>
 <ee98c81b-0b07-4469-9135-ac3be7dc7564@redhat.com>
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
In-Reply-To: <ee98c81b-0b07-4469-9135-ac3be7dc7564@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 2a00:23c4:8bb4:4000:aae1:b0e7:6998:7ece
X-SA-Exim-Mail-From: mark.cave-ayland@ilande.co.uk
Subject: Re: [PATCH 4/5] docs/system/target-sparc: Improve the Sparc
 documentation
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

On 19/04/2024 05:59, Thomas Huth wrote:

> On 18/04/2024 22.27, Mark Cave-Ayland wrote:
>> On 07/03/2024 17:43, Thomas Huth wrote:
>>
>>> Add some words about how to enable or disable boolean features,
>>> and remove the note about a Linux kernel being available on the
>>> QEMU website (they have been removed long ago already).
>>>
>>> Signed-off-by: Thomas Huth <thuth@redhat.com>
>>> ---
>>>   docs/system/target-sparc.rst | 8 ++++++--
>>>   1 file changed, 6 insertions(+), 2 deletions(-)
>>>
>>> diff --git a/docs/system/target-sparc.rst b/docs/system/target-sparc.rst
>>> index 9ec8c90c14..9f418b9d3e 100644
>>> --- a/docs/system/target-sparc.rst
>>> +++ b/docs/system/target-sparc.rst
>>> @@ -27,6 +27,11 @@ architecture machines:
>>>   The emulation is somewhat complete. SMP up to 16 CPUs is supported, but
>>>   Linux limits the number of usable CPUs to 4.
>>> +The list of available CPUs can be viewed by starting QEMU with ``-cpu help``.
>>> +Optional boolean features can be added with a "+" in front of the feature name,
>>> +or disabled with a "-" in front of the name, for example
>>> +``-cpu TI-SuperSparc-II,+float128``.
>>> +
>>>   QEMU emulates the following sun4m peripherals:
>>>   -  IOMMU
>>> @@ -55,8 +60,7 @@ OpenBIOS is a free (GPL v2) portable firmware implementation. 
>>> The goal
>>>   is to implement a 100% IEEE 1275-1994 (referred to as Open Firmware)
>>>   compliant firmware.
>>> -A sample Linux 2.6 series kernel and ram disk image are available on the
>>> -QEMU web site. There are still issues with NetBSD and OpenBSD, but most
>>> +There are still issues with NetBSD and OpenBSD, but most
>>>   kernel versions work. Please note that currently older Solaris kernels
>>>   don't work probably due to interface issues between OpenBIOS and
>>>   Solaris.
>>
>> Just curious as to what current issues exist with NetBSD and OpenBSD? At least both 
>> my NetBSD and OpenBSD test images survive a casual boot test here with latest git.
> 
> Maybe it's also about a long fixed bug ... shall I remove that sentence while I'm at it?

Yeah, I don't believe that has been true about NetBSD/OpenBSD for quite some time :) 
Please do keep the wording about Solaris since I get asked that often (and it's a 
task that will be quite difficult and time-consuming to do).


ATB,

Mark.


