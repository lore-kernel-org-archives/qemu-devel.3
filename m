Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5044FCF9C64
	for <qemu-devel@archiver.kernel.org>; Sun, 22 Sep 2024 12:45:18 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ssLwv-0004o0-0E; Sun, 22 Sep 2024 08:44:25 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mark.cave-ayland@ilande.co.uk>)
 id 1ssLwt-0004nR-HH
 for qemu-devel@nongnu.org; Sun, 22 Sep 2024 08:44:23 -0400
Received: from mail.ilande.co.uk ([2001:41c9:1:41f::167])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mark.cave-ayland@ilande.co.uk>)
 id 1ssLwr-0007is-Mz
 for qemu-devel@nongnu.org; Sun, 22 Sep 2024 08:44:23 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=ilande.co.uk; s=20220518; h=Subject:Content-Transfer-Encoding:Content-Type:
 In-Reply-To:From:References:Cc:To:MIME-Version:Date:Message-ID:Sender:
 Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender
 :Resent-To:Resent-Cc:Resent-Message-ID;
 bh=88Ku+xzJp+s2JUCdl87cjJjwqKBmN77zB8CURmOlaXo=; b=KtIQ+stMAkmFqmAF8aiCl0wkmf
 ISzLibGBgHWaZNNvVxG9xIxpnkfT/VnbRHZ454EkFSdm9wCA4fmJ+urEkjTKXlo9PjoP0pXFj3pOa
 WwtCAGHXhOsc62zSlR6y0RvytxmypcW6KvDrdocBJH7GbXenlVvHBUFcEm7Uj4LsHw9ajWa1n1dZy
 +o+fnNVL+hcoIFq92Q70udd2Wev62+undpwtQfgJfRjOkSYXflsrvJtlLGc6bhwpumu3i+rS87sZ6
 9S2XIcReFkwcTqWqu4nmc/ub7FqvrgSLKW0dnW8BI1Ewk933XYYzyvWPZpTBQs7bJ1VK9JKs5RAFq
 KZ/VSoQXmRQEqtPdXxxjALAtbSXW7DqZq/tx4YlaSLOZPWhMyQEvJk+1657JzwB+JTUlnC+NB3e1x
 Ye45E31LKntWTTmu0hSj9oFwpdM2DLCafkI3BZvuMIx7GzBmwZuk+N4RlR6L2KZj9HwVsQVpzL5Cj
 Vcgqi/KaVJTXP734shb4lasq9atAYblUPnX6jlR6xvuVhWUPuBcuFJhKSh+ESIR7ZcweIxNNnfLdU
 A4kvIAlAyOu70BpqW6zTyaOhZ8SjsgYMWYAZepGmBh4LVqKytuXTvTWID6scJy6VTsVqQVy9wpjp9
 R9VdwNnNUVLhPC6zTWfBJLHyABm0EC0Zxm53Xmuuk=;
Received: from [2a00:23c4:8bb8:7000:41b:8fca:3a2a:2286]
 by mail.ilande.co.uk with esmtpsa (TLS1.3:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.92) (envelope-from <mark.cave-ayland@ilande.co.uk>)
 id 1ssLwe-0009Iq-JZ; Sun, 22 Sep 2024 13:44:12 +0100
Message-ID: <11610cb4-ad33-46ec-b5c1-f57a9cd8dd3c@ilande.co.uk>
Date: Sun, 22 Sep 2024 13:44:11 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: Thomas Huth <thuth@redhat.com>, qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Yoshinori Sato <ysato@users.sourceforge.jp>,
 Magnus Damm <magnus.damm@gmail.com>, Max Filippov <jcmvbkbc@gmail.com>
References: <20240919185749.71222-1-thuth@redhat.com>
 <20240919185749.71222-5-thuth@redhat.com>
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
In-Reply-To: <20240919185749.71222-5-thuth@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-SA-Exim-Connect-IP: 2a00:23c4:8bb8:7000:41b:8fca:3a2a:2286
X-SA-Exim-Mail-From: mark.cave-ayland@ilande.co.uk
Subject: Re: [PATCH 4/7] tests/functional: Convert the SPARCStation Avocado
 test
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

On 19/09/2024 19:57, Thomas Huth wrote:

> Use the new launch_kernel function to convert this test in a simple way.
> 
> Signed-off-by: Thomas Huth <thuth@redhat.com>
> ---
>   MAINTAINERS                          |  1 +
>   tests/avocado/boot_linux_console.py  |  8 --------
>   tests/functional/meson.build         |  4 ++++
>   tests/functional/test_sparc_sun4m.py | 25 +++++++++++++++++++++++++
>   4 files changed, 30 insertions(+), 8 deletions(-)
>   create mode 100755 tests/functional/test_sparc_sun4m.py
> 
> diff --git a/MAINTAINERS b/MAINTAINERS
> index a75d6ba7d2..b85a3fc529 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -1693,6 +1693,7 @@ F: include/hw/nvram/sun_nvram.h
>   F: include/hw/sparc/sparc32_dma.h
>   F: include/hw/sparc/sun4m_iommu.h
>   F: pc-bios/openbios-sparc32
> +F: tests/functional/test_sparc_sun4m.py
>   
>   Sun4u
>   M: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
> diff --git a/tests/avocado/boot_linux_console.py b/tests/avocado/boot_linux_console.py
> index cf58499c84..900af67412 100644
> --- a/tests/avocado/boot_linux_console.py
> +++ b/tests/avocado/boot_linux_console.py
> @@ -1019,11 +1019,3 @@ def test_sh4_r2d(self):
>           tar_hash = 'fe06a4fd8ccbf2e27928d64472939d47829d4c7e'
>           self.vm.add_args('-append', 'console=ttySC1')
>           self.do_test_advcal_2018('09', tar_hash, 'zImage', console=1)
> -
> -    def test_sparc_ss20(self):
> -        """
> -        :avocado: tags=arch:sparc
> -        :avocado: tags=machine:SS-20
> -        """
> -        tar_hash = 'b18550d5d61c7615d989a06edace051017726a9f'
> -        self.do_test_advcal_2018('11', tar_hash, 'zImage.elf')
> diff --git a/tests/functional/meson.build b/tests/functional/meson.build
> index 8fd852f4ab..8aacd15cf3 100644
> --- a/tests/functional/meson.build
> +++ b/tests/functional/meson.build
> @@ -125,6 +125,10 @@ tests_s390x_system_thorough = [
>     's390x_topology',
>   ]
>   
> +tests_sparc_system_thorough = [
> +  'sparc_sun4m',
> +]
> +
>   tests_sparc64_system_thorough = [
>     'sparc64_sun4u',
>   ]
> diff --git a/tests/functional/test_sparc_sun4m.py b/tests/functional/test_sparc_sun4m.py
> new file mode 100755
> index 0000000000..b334375820
> --- /dev/null
> +++ b/tests/functional/test_sparc_sun4m.py
> @@ -0,0 +1,25 @@
> +#!/usr/bin/env python3
> +#
> +# Functional test that boots a Linux kernel on a sparc sun4m machine
> +# and checks the console
> +#
> +# SPDX-License-Identifier: GPL-2.0-or-later
> +
> +from qemu_test import LinuxKernelTest, Asset
> +from qemu_test.utils import archive_extract
> +
> +class Sun4mTest(LinuxKernelTest):
> +
> +    ASSET_DAY11 = Asset(
> +        'https://www.qemu-advent-calendar.org/2018/download/day11.tar.xz',
> +        'c776533ba756bf4dd3f1fc4c024fb50ef0d853e05c5f5ddf0900a32d1eaa49e0')
> +
> +    def test_sparc_ss20(self):
> +        self.set_machine('SS-20')
> +        file_path = self.ASSET_DAY11.fetch()
> +        archive_extract(file_path, self.workdir)
> +        self.launch_kernel(self.workdir + '/day11/zImage.elf',
> +                           wait_for='QEMU advent calendar')
> +
> +if __name__ == '__main__':
> +    LinuxKernelTest.main()

Acked-by: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>


ATB,

Mark.


