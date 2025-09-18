Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 83296CAC597
	for <qemu-devel@archiver.kernel.org>; Thu, 18 Sep 2025 18:53:56 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uzJkm-0000AC-Iu; Thu, 18 Sep 2025 14:53:15 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mark.cave-ayland@ilande.co.uk>)
 id 1uzJkc-0008TM-3t; Thu, 18 Sep 2025 14:53:02 -0400
Received: from mail.ilande.co.uk ([2001:41c9:1:41f::167])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mark.cave-ayland@ilande.co.uk>)
 id 1uzJkZ-0003fn-0H; Thu, 18 Sep 2025 14:53:01 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=ilande.co.uk; s=20220518; h=Subject:Content-Transfer-Encoding:Content-Type:
 In-Reply-To:From:References:Cc:To:MIME-Version:Date:Message-ID:Sender:
 Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender
 :Resent-To:Resent-Cc:Resent-Message-ID;
 bh=IE3enuZ7tV8Xv6TR4mpxwdWVz3O/BeteZwLyMM07Uvs=; b=gs5bnnpczOGEMVBPZoq4BM8Fhl
 Pc4y62inWiGB2xYAEGtBgU5zFU166s4a1fCo1Q0XFSLdDjr14ySEgCqh4Kb6YSZWvar92ai+vgICK
 Omd80nUlrsz+3GWXlBFBomiC/r5jsBsL4dl6bC1yk4wupB8uV6xvYXd8rw3kyyZhN70cylVYzG/1J
 /+PqMf70cw86Xu2wyNFylqRzVK4SGf0vvMXU8yywiBFd4TI1cd3upJDyPHJ1OjLe7kSFJSXxouBoS
 wWB9MaCoqo6pi4jTGbHd0WGvjwVtCQrGUQqjBFUM0YpLu+sbMrUIB+Gtx3g7+GIKgVxH1RlbbtYYc
 +x8VNPrlFb3Ax8PkkqMjKqHLf4ilRT77TRjt1phGAcwzyBDyVL2+w9flih61IrAT88HWL1saf2+w/
 riokmLztVCNrqi9M1PRz4LmsBxaUpa1/UnpFfCeQ6+YuqRGpeHBFBYkskHWqNpBuLecdE61KkQaaD
 pK4ZURcelHlKSX6OswfAECrUYbMUOZhGwDISX19p3b/Q9MFGWMRkZ2fKTpxWR2I4x/bHu3wzidbsQ
 7vu6IaaqHXwxRdoLWLaivwIczNkL2K8HST2/O6YKoYgeddIvtfG70QPozO9IQ/A2IP/Gz3m1ulhwQ
 1CcsA8hnL9rSgxA89vJb6CvYmzd40SS65tH4Yvt6U=;
Received: from [2a02:8012:2f01:0:4825:8e53:bc9c:58e6]
 by mail.ilande.co.uk with esmtpsa (TLS1.3:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.92) (envelope-from <mark.cave-ayland@ilande.co.uk>)
 id 1uzJiW-00066B-9A; Thu, 18 Sep 2025 19:50:53 +0100
Message-ID: <ab4c89df-f3bc-4e4a-b514-b77516479d53@ilande.co.uk>
Date: Thu, 18 Sep 2025 19:52:51 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: BALATON Zoltan <balaton@eik.bme.hu>, qemu-devel@nongnu.org,
 qemu-ppc@nongnu.org
Cc: =?UTF-8?Q?Herv=C3=A9_Poussineau?= <hpoussin@reactos.org>,
 Artyom Tarasenko <atar4qemu@gmail.com>, Nicholas Piggin <npiggin@gmail.com>
References: <cover.1751493467.git.balaton@eik.bme.hu>
 <6b16ad7b-2538-55b5-e512-4faf735f0b41@eik.bme.hu>
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
In-Reply-To: <6b16ad7b-2538-55b5-e512-4faf735f0b41@eik.bme.hu>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 2a02:8012:2f01:0:4825:8e53:bc9c:58e6
X-SA-Exim-Mail-From: mark.cave-ayland@ilande.co.uk
Subject: Re: [PATCH v2 00/14] hw/pci-host/raven clean ups
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

On 17/09/2025 12:19, BALATON Zoltan wrote:

> On Thu, 3 Jul 2025, BALATON Zoltan wrote:
>> Hello,
> 
> Ping? Do we have hw/ppc maintainers who can look at this and merge it?

Apologies for the delay, things have been quite hectic here. I'll take a look now.

> Regards,
> BALATON Zoltan
> 
>> This series cleans up and simplifies the raven model which does some
>> strange stuff that no other pci-host is doing and does it in a
>> convoluted way and also has some legacy bits that can be removed.
>> Apart from making the model much more readable this also fixes the
>> non-contiguous IO control bit which was there but did not work as it
>> was not connected but apparently it's not really used by any guest so
>> that wasn't noticed.
>>
>> Regards,
>> BALATON Zoltan
>>
>> v2:
>> - rebase on master
>> - add R-b tags from Philippe
>>
>> BALATON Zoltan (14):
>>  hw/pci-host/raven: Simplify PCI facing part
>>  hw/pci-host/raven: Simplify host bridge type declaration
>>  hw/pci-host/raven: Use DEFINE_TYPES macro
>>  hw/pci-host/raven: Simplify PCI bus creation
>>  hw/pci-host/raven: Simplify PCI interrupt routing
>>  hw/pci-host/raven: Simplify direct config access address decoding
>>  hw/pci-host/raven: Rename direct config access ops
>>  hw/pci-host/raven: Use correct parameter in direct access ops
>>  hw/pci-host/raven: Do not use parent object for mmcfg region
>>  hw/pci-host/raven: Fix PCI config direct access region
>>  hw/pci-host/raven: Simpify discontiguous IO access
>>  hw/pci-host/raven: Move bus master address space creation to one place
>>  hw/pci-host/raven: Do not map regions in init method
>>  hw/ppc/prep: Fix non-contiguous IO control bit
>>
>> hw/pci-host/raven.c       | 328 ++++++++++++--------------------------
>> hw/ppc/prep.c             |  19 ++-
>> hw/ppc/prep_systemio.c    |  14 +-
>> include/hw/pci/pci_host.h |   1 -
>> 4 files changed, 127 insertions(+), 235 deletions(-)


ATB,

Mark.


