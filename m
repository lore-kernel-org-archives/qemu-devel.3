Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8C19CC5478A
	for <qemu-devel@archiver.kernel.org>; Wed, 21 Feb 2024 15:38:43 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rcoaa-0000US-Kx; Wed, 21 Feb 2024 10:32:52 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mark.cave-ayland@ilande.co.uk>)
 id 1rcoTC-0006J0-6D; Wed, 21 Feb 2024 10:25:14 -0500
Received: from mail.ilande.co.uk ([2001:41c9:1:41f::167])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mark.cave-ayland@ilande.co.uk>)
 id 1rclBo-0000vP-U5; Wed, 21 Feb 2024 06:55:06 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=ilande.co.uk; s=20220518; h=Subject:Content-Transfer-Encoding:Content-Type:
 In-Reply-To:From:References:Cc:To:MIME-Version:Date:Message-ID:Sender:
 Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender
 :Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=1YhoWONXIpaW9qGOk56UkNXIr6FA0V3YLLDDXHffgU4=; b=OPJDJLgTMiqd4d236CMFfYV4gQ
 DqytrWx+T3aLLi9zsVWplxKprUyKN1KUxISsl654A6lVR6zdGn2fpNzLIWbMGlmUDvwf9zc5BWAgd
 IByju33mpDWF6RNDIul+kek06EGdxlHH5KAwbLOjZbuDCDwy9TG0Wjbhi6V9dJ6p0VdBTpjI9+IW3
 mKTjhTU3n6yWYYHEr+oCnSHA8ldnNtkBx4ZP5qXJiQIW+iEsqsMbKp69qE9n6TUpQ6hHQDqOzO5fM
 87VCPk+xPg6sUq2PnAMpo7JYkmeEyddNTIG7qvK2aFiHoLUY7f0qb2Fjg0FkUk1fk9a8eIkcPUGhv
 WTUxvfbc1imqcpIaEGxpSuRn2LjZGzTBalVrTDvPQ57+60BqkvRW6VgwBbGAZRDm5D2mTep9BPgzw
 G1zU3+iznvC/FiXr4DKWFW5hKB43UH6bd5+Pc9941z/3mJDLAEBdaGz3ZdyN1H7hD/SqfPLqN2Pvm
 S6B3vDADVt77SuB5wZdor7bpqpfVPdyp0xCQf3yN6wsz0R0aL2B6eYzSnXxwN79hQ9YXlwqzfX1yL
 snaTW7SQhYIkJhhW64Lhd155/fLQPHdGadlKaZK1rNG70T0YvIosVI5iI2v9fJOmgQVFvfnOEVJeX
 f83yc7qQZH7HK9YAp9NxfqZWKavGIRB66J6tsAeHU=;
Received: from [2a02:8012:c93d:0:260e:bf57:a4e9:8142]
 by mail.ilande.co.uk with esmtpsa (TLS1.3:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.92) (envelope-from <mark.cave-ayland@ilande.co.uk>)
 id 1rclB0-0008MU-MH; Wed, 21 Feb 2024 11:54:18 +0000
Message-ID: <a468ae40-8d53-4048-9692-a9eb15f1fbd9@ilande.co.uk>
Date: Wed, 21 Feb 2024 11:54:56 +0000
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Content-Language: en-US
To: Thomas Huth <thuth@redhat.com>, John Snow <jsnow@redhat.com>,
 qemu-devel@nongnu.org
Cc: BALATON Zoltan <balaton@eik.bme.hu>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 qemu-block@nongnu.org
References: <20240220085505.30255-1-thuth@redhat.com>
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
In-Reply-To: <20240220085505.30255-1-thuth@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-SA-Exim-Connect-IP: 2a02:8012:c93d:0:260e:bf57:a4e9:8142
X-SA-Exim-Mail-From: mark.cave-ayland@ilande.co.uk
Subject: Re: [PATCH v2 0/7] hw/ide: Clean up hw/ide/qdev.c and
 include/hw/ide/internal.h
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

On 20/02/2024 08:54, Thomas Huth wrote:

> While trying to make it possible to compile-out the CompactFlash IDE device
> in downstream distributions (first patch), we noticed that there are more
> things in the IDE code that could use a proper clean up:
> 
> First, hw/ide/qdev.c is quite a mix between IDE BUS specific functions
> and (disk) device specific functions. Thus the second patch splits qdev.c
> into two new separate files to make it more obvious which part belongs
> to which kind of devices.
> 
> The remaining patches unentangle include/hw/ide/internal.h, which is meant
> as a header that should only be used internally to the IDE subsystem, but
> which is currently exposed to the world since include/hw/ide/pci.h includes
> this header, too. Thus we move the definitions that are also required for
> non-IDE code to other new header files, so we can finally change pci.h to
> stop including internal.h. After these changes, internal.h is only included
> by files in hw/ide/ as it should be.
> 
> v2:
> - Change the order of the DMA patch and move typedef struct IDEDMAOps
>    and typedef struct IDEDMA IDEDMA into ide-dma.h, too
> - Make sure that the headers are self-contained (i.e. #include the
>    right other headers)
> - Remove some more remnants of include/hw/ide.h
> 
> Thomas Huth (7):
>    hw/ide: Add the possibility to disable the CompactFlash device in the
>      build
>    hw/ide: Split qdev.c into ide-bus.c and ide-dev.c
>    hw/ide: Move IDE DMA related definitions to a separate header
>      ide-dma.h
>    hw/ide: Move IDE device related definitions to ide-dev.h
>    hw/ide: Move IDE bus related definitions to a new header ide-bus.h
>    hw/ide: Remove the include/hw/ide.h legacy file
>    hw/ide: Stop exposing internal.h to non-IDE files
> 
>   MAINTAINERS                  |   1 -
>   include/hw/ide.h             |   9 --
>   include/hw/ide/ide-bus.h     |  42 +++++++
>   include/hw/ide/ide-dev.h     | 184 ++++++++++++++++++++++++++++++
>   include/hw/ide/ide-dma.h     |  37 ++++++
>   include/hw/ide/internal.h    | 211 +----------------------------------
>   include/hw/ide/pci.h         |   2 +-
>   hw/i386/pc.c                 |   2 +-
>   hw/ide/cf.c                  |  58 ++++++++++
>   hw/ide/cmd646.c              |   1 +
>   hw/ide/ide-bus.c             | 111 ++++++++++++++++++
>   hw/ide/{qdev.c => ide-dev.c} | 137 +----------------------
>   hw/ide/pci.c                 |   1 +
>   hw/ide/piix.c                |   1 +
>   hw/ide/sii3112.c             |   1 +
>   hw/ide/via.c                 |   1 +
>   hw/arm/Kconfig               |   2 +
>   hw/ide/Kconfig               |  32 ++++--
>   hw/ide/meson.build           |   4 +-
>   19 files changed, 470 insertions(+), 367 deletions(-)
>   delete mode 100644 include/hw/ide.h
>   create mode 100644 include/hw/ide/ide-bus.h
>   create mode 100644 include/hw/ide/ide-dev.h
>   create mode 100644 include/hw/ide/ide-dma.h
>   create mode 100644 hw/ide/cf.c
>   create mode 100644 hw/ide/ide-bus.c
>   rename hw/ide/{qdev.c => ide-dev.c} (67%)

I've had a quick skim of this series, and it looks like a good tidy-up to me so:

Acked-by: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>


ATB,

Mark.


