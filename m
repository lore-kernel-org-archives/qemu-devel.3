Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 20656C83F1A
	for <qemu-devel@archiver.kernel.org>; Thu, 17 Jul 2025 13:33:43 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ucOj2-0004PC-7Y; Thu, 17 Jul 2025 09:32:40 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mark.cave-ayland@ilande.co.uk>)
 id 1ucNqV-0007Uw-HG; Thu, 17 Jul 2025 08:36:22 -0400
Received: from mail.ilande.co.uk ([2001:41c9:1:41f::167])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mark.cave-ayland@ilande.co.uk>)
 id 1ucNqT-0006W9-6R; Thu, 17 Jul 2025 08:36:18 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=ilande.co.uk; s=20220518; h=Subject:Content-Transfer-Encoding:Content-Type:
 In-Reply-To:From:References:To:MIME-Version:Date:Message-ID:Sender:Reply-To:
 Cc:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID;
 bh=8mtVf8T8pboHjWq1RK2EyQxzADd6v0v6YVt3iUWOK4U=; b=LkGBiP+q6M+XmCZCPmAtMXAU3N
 0eYofu5g75+e4gkc2lL2F/GmAI0hBWAUvp3qFZLRMrj0PGjFQQNafvFcMEPJsPzl5D1Cb3rGjHZAB
 s7d+hiyVFGpdilmJaMvJPWn2YSFxqNpl4wqZsUqnEptmW2RdBfbA5YupLckwRFUkMW8HKHvx1a6iv
 lLgsY3kNuYkDIeBgNrbyyREHRayVAegIrNNWLOuWd68TFDA7xa1dOvZWOMc3avoSboPSFgdwcRNyW
 0bfkDUDq00DFbbjMRvy/3LBhB5/z0uJboZ3UGR12TGQ1z1y8JhUG9QHxtp8Hq+Pojj+VTd/c8YXqG
 8TDvNAibzpaF9GELO0YaJVyUvQC0lp5lyHbRbSdn/Gwyvr5VfQP74IztkdmwlZ4lPAAO/m+Jq7dYH
 smWKNx1lDP+eoQeKCY6eYm0WqX2a3H8D1vPhaxV0vQFrFJptAmnW3KUfK6zpVvVuRX9AroATf2OSU
 32eN32ILloZG/FctVaUczwHbyfe+9CTftlPwl2U+z9MRZgc9omMK3U+vsEEP/7uoHsuFZjwP8cuyr
 aKiUzbjWEuTwkNv70fN46JROUcyHSPIsYbk/GTPc9Y67vBhLgYsaXL9+zmf2c6lNGtzYFCFK/Jdbp
 W5IJu9b+88/PZN+gv/EnZ3aI4ySD+Sd7RSmGpO5WQ=;
Received: from [2a02:8012:c93d:0:260e:bf57:a4e9:8142]
 by mail.ilande.co.uk with esmtpsa (TLS1.3:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.92) (envelope-from <mark.cave-ayland@ilande.co.uk>)
 id 1ucNof-0003nQ-Ho; Thu, 17 Jul 2025 13:34:25 +0100
Message-ID: <6e801e63-143d-42ee-b7e3-04156f7940e0@ilande.co.uk>
Date: Thu, 17 Jul 2025 13:35:56 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: Michael Tokarev <mjt@tls.msk.ru>, pbonzini@redhat.com, fam@euphon.net,
 qemu-devel@nongnu.org, qemu-stable <qemu-stable@nongnu.org>
References: <20250711204636.542964-1-mark.cave-ayland@ilande.co.uk>
 <f8ebf601-d6b4-47fa-b7b5-008c4fa8711d@tls.msk.ru>
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
In-Reply-To: <f8ebf601-d6b4-47fa-b7b5-008c4fa8711d@tls.msk.ru>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 2a02:8012:c93d:0:260e:bf57:a4e9:8142
X-SA-Exim-Mail-From: mark.cave-ayland@ilande.co.uk
Subject: Re: [PATCH v3 0/7] esp.c: only allow ESP commands permitted in the
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

On 16/07/2025 16:13, Michael Tokarev wrote:

> On 11.07.2025 23:46, Mark Cave-Ayland wrote:
>> This series contains a few minor tidy-ups along with an implementation of the
>> logic to only allow ESP commands permitted in the current mode. The motivation
>> is to fix GitLab issue #2464 which causes Windows NT MIPS to bluescreen on
>> boot.
>>
>> Patches 1 to 5 are simple tidy-ups from investigating the issue. Patch 6 adds
>> a new asc_mode variable to indicate the current ESP mode, whilst patch 7 implements
>> the feature which fixes GitLab issue #2464.
>>
>> Note: this series is being reposted as both the SeaBIOS and SeaBIOS hppa binaries
>> currently distributed with QEMU have now been fixed so that they do not use an
>> illegal ESP command sequence.
>>
>> Signed-off-by: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
>>
>> v3:
>> - Fix typo in comments for patches 4 and 5 as pointed out by Phil
>> - Add R-B tags from Phil
>>
>> v2:
>> - Rebase onto master
>> - Add patches 4 and 5 to avoid calling the DMA functions for zero-length transfers
>>
>>
>> Mark Cave-Ayland (7):
>>    esp.c: only raise IRQ in esp_transfer_data() for CMD_SEL, CMD_SELATN
>>      and CMD_TI commands
>>    esp.c: improve comment in esp_transfer_data()
>>    esp.h: remove separate ESPState typedef
>>    esp.c: only call dma_memory_read function if transfer length is
>>      non-zero
>>    esp.c: only call dma_memory_write function if transfer length is
>>      non-zero
>>    esp.c: add asc_mode property to indicate the current ESP mode
>>    esp.c: only allow ESP commands permitted in the current asc_mode
>>
>>   hw/scsi/esp.c         | 94 +++++++++++++++++++++++++++++++++++++------
>>   hw/scsi/trace-events  |  1 +
>>   include/hw/scsi/esp.h | 15 ++++++-
>>   3 files changed, 96 insertions(+), 14 deletions(-)
> 
> I wonder if we can pick this up for qemu-stable (10.0).  It's a large
> change, but a fairy focused one..  What do you think?
> 
> (10.0 is expected to be long-term support series).

Probably not in this case, because during testing I found that the drivers in 
SeaBIOS/OpenBIOS also used commands in the wrong ASC mode and needed corresponding 
updates first.


ATB,

Mark.


