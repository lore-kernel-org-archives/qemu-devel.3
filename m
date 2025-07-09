Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E679DC83F03
	for <qemu-devel@archiver.kernel.org>; Wed,  9 Jul 2025 07:58:31 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uZPfY-0007tH-NF; Wed, 09 Jul 2025 03:56:44 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mark.cave-ayland@ilande.co.uk>)
 id 1uZPaE-0004CM-FL
 for qemu-devel@nongnu.org; Wed, 09 Jul 2025 03:51:15 -0400
Received: from mail.ilande.co.uk ([2001:41c9:1:41f::167])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mark.cave-ayland@ilande.co.uk>)
 id 1uZPaA-0001bg-BN
 for qemu-devel@nongnu.org; Wed, 09 Jul 2025 03:51:12 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=ilande.co.uk; s=20220518; h=Subject:Content-Transfer-Encoding:Content-Type:
 In-Reply-To:References:To:From:MIME-Version:Date:Message-ID:Sender:Reply-To:
 Cc:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID;
 bh=92IQ5KRHQ1RZafcUYS/wNRvOiBaEPmNoP6kd4lDjab0=; b=BReDG7JszW357crfBvBjLJSlzF
 YyJKC21xnd9k/uIbdku4bRGJyhjAJkuvkV4D9C6FFjgKJFPTZ1NSn8fSF6gOHB1m36/oGcQZ5Rh53
 LsaOZxBpEwZe1OYPi+6Klm67dF4NelBocJvJKiPfAfg1rSxCnUMH8BQwg3k9h8WQ8yhKdwxoiuC3o
 mSkd5m6CsW1MSS/Zuo2MwY99gPrzoFckOSUY0oYuevxpNJHS53zzkZjH7CxzXUf7M3+HwKrYxdTge
 XgbCivihYDCjeIy+n9bs3zya0oCR7D2mCnuiu4bIrzshUOaj8d1fBzpfTKJEgKSWO4xncC+4AEtv7
 EcewzSKdyOkhegfMbr+4OQQvarMLv4CwxVh6vjBjVdzB2qlgqkHSdlfxbpugN1Hggx+NhRYqZOkpS
 udn7rq08ERUm2RrK1zd2ysJc/lOLCdF7vkrV/EvRrtGQNCUA1dZL0a65+1pTO5Eg6YsHSkuhdoJec
 hcNLdNl5XISCYOcbCga+grcAqPgKJHNcT+aFEECzeB5DjMpvkvn4oQxSGkrND3C6gfPCZ2vaCIDJU
 3FMfrG6yy8priMXzFjssYJGhWZCserNajrq7a9fLyGe/y6p8OB0CvEw0R+dpklJ0l1+QMF+QpWoiW
 ux1aKEihUVhbBU6qgoiu4VlVeVq5jtSF5+AXAATdg=;
Received: from [2a02:8012:c93d:0:260e:bf57:a4e9:8142]
 by mail.ilande.co.uk with esmtpsa (TLS1.3:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.92) (envelope-from <mark.cave-ayland@ilande.co.uk>)
 id 1uZPYS-0009AV-U7; Wed, 09 Jul 2025 08:49:25 +0100
Message-ID: <30d03eef-c0d8-4864-87d9-a3674d8f64a1@ilande.co.uk>
Date: Wed, 9 Jul 2025 08:50:58 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
To: pbonzini@redhat.com, fam@euphon.net, qemu-devel@nongnu.org
References: <20250618061249.743897-1-mark.cave-ayland@ilande.co.uk>
Content-Language: en-US
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
In-Reply-To: <20250618061249.743897-1-mark.cave-ayland@ilande.co.uk>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-SA-Exim-Connect-IP: 2a02:8012:c93d:0:260e:bf57:a4e9:8142
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

On 18/06/2025 07:12, Mark Cave-Ayland wrote:

> This series contains a few minor tidy-ups along with an implementation of the
> logic to only allow ESP commands permitted in the current mode. The motivation
> is to fix GitLab issue #2464 which causes Windows NT MIPS to bluescreen on
> boot.
> 
> Patches 1 to 5 are simple tidy-ups from investigating the issue. Patch 6 adds
> a new asc_mode variable to indicate the current ESP mode, whilst patch 7 implements
> the feature which fixes GitLab issue #2464.
> 
> Note: this series is being reposted as both the SeaBIOS and SeaBIOS hppa binaries
> currently distributed with QEMU have now been fixed so that they do not use an
> illegal ESP command sequence.
> 
> Signed-off-by: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
> 
> v2:
> - Rebase onto master
> - Add patches 4 and 5 to avoid calling the DMA functions for zero-length transfers
> 
> 
> Mark Cave-Ayland (7):
>    esp.c: only raise IRQ in esp_transfer_data() for CMD_SEL, CMD_SELATN
>      and CMD_TI commands
>    esp.c: improve comment in esp_transfer_data()
>    esp.h: remove separate ESPState typedef
>    esp.c: only call dma_memory_read function if transfer length is
>      non-zero
>    esp.c: only call dma_memory_write function if transfer length is
>      non-zero
>    esp.c: add asc_mode property to indicate the current ESP mode
>    esp.c: only allow ESP commands permitted in the current asc_mode
> 
>   hw/scsi/esp.c         | 94 +++++++++++++++++++++++++++++++++++++------
>   hw/scsi/trace-events  |  1 +
>   include/hw/scsi/esp.h | 15 ++++++-
>   3 files changed, 96 insertions(+), 14 deletions(-)

Ping?


ATB,

Mark.


