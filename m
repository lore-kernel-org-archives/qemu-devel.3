Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B8C28CF9C64
	for <qemu-devel@archiver.kernel.org>; Sun, 22 Sep 2024 12:45:45 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ssLxw-0006V7-8Q; Sun, 22 Sep 2024 08:45:29 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mark.cave-ayland@ilande.co.uk>)
 id 1ssLxm-0006A4-LX
 for qemu-devel@nongnu.org; Sun, 22 Sep 2024 08:45:23 -0400
Received: from mail.ilande.co.uk ([2001:41c9:1:41f::167])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mark.cave-ayland@ilande.co.uk>)
 id 1ssLxk-00083b-6K
 for qemu-devel@nongnu.org; Sun, 22 Sep 2024 08:45:18 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=ilande.co.uk; s=20220518; h=Subject:Content-Transfer-Encoding:Content-Type:
 In-Reply-To:From:References:Cc:To:MIME-Version:Date:Message-ID:Sender:
 Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender
 :Resent-To:Resent-Cc:Resent-Message-ID;
 bh=5WVnwRGu8BwurXaS+SJHD3hG2ZS7Cmbx1a5BK4FlQCY=; b=wbwg+orxjZuJGeK383OwtpMfN6
 4GHXLG3OR6TdcLp/iZKzMgc7LbnY6yZeU2xmZDmiykBFARQc4HtiajOxDmAnLBc3hJUuCeaNG0Ps3
 wz7B/gUhgtMYSf+d3WvJV+vSFh5bQFkivrX6G49IyaFJluBTqLJZTMZF4LQvFd5dgVWJPNMsu6Zke
 RfcJ5ju9v+QGfGczwfivI3ZqEzPxyHM1Vyoj64aVNH2foeqh9d96L5BAciZ3DLs+NJ4UsTmcCAuZA
 elsrf4KDwnWLAIzEHrrS3MK7S08E1XMoopKetc3kH0PfX5fn/6FP+LWLf2VsyQfgQnl/ZlNZqmrrs
 DdEUgrNrRIk5qcJpKKlsd7iGX7oSUY3g2pxVPJZGoQi8IuptAUGg4F5LN/TDKMkokuFA9g2zxFSNk
 Qry9fQIaWFRN8XDNdzYWdra1IUFRYUSJnhbFt6BXiZWrd1yYQL2flcsep/EbG++6GwzcUPoPuVT9q
 8I/WK08ETGaSUORPJG1WErcY8iKCQ3Ei/23Zn0zldszvn0Tec3oTeF28bmeApRlSD0aSbrdEZWXRG
 zcam6Koj158Y86H3kiwfLPgoQ0MCeirDsT3/XRz3e/eOWUlNINko3S8TnMdp12cnRRGE8QSqHQjiv
 /h9U0pJEgB51vCbHCTR/kEd2ZyPRsWmzi6i1+957o=;
Received: from [2a00:23c4:8bb8:7000:41b:8fca:3a2a:2286]
 by mail.ilande.co.uk with esmtpsa (TLS1.3:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.92) (envelope-from <mark.cave-ayland@ilande.co.uk>)
 id 1ssLxZ-0009JW-8k; Sun, 22 Sep 2024 13:45:09 +0100
Message-ID: <bfa1201f-5e2a-4454-a145-1d17711af2b7@ilande.co.uk>
Date: Sun, 22 Sep 2024 13:45:08 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: Thomas Huth <thuth@redhat.com>, qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Yoshinori Sato <ysato@users.sourceforge.jp>,
 Magnus Damm <magnus.damm@gmail.com>, Max Filippov <jcmvbkbc@gmail.com>
References: <20240919185749.71222-1-thuth@redhat.com>
 <20240919185749.71222-7-thuth@redhat.com>
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
In-Reply-To: <20240919185749.71222-7-thuth@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 2a00:23c4:8bb8:7000:41b:8fca:3a2a:2286
X-SA-Exim-Mail-From: mark.cave-ayland@ilande.co.uk
Subject: Re: [PATCH 6/7] tests/functional: Convert the mac ppc Avocado tests
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

> The g3beige and mac99 tests use the same asset, so put them together
> in a new test_ppc_mac.py file.
> 
> Signed-off-by: Thomas Huth <thuth@redhat.com>
> ---
>   MAINTAINERS                         |  2 ++
>   tests/avocado/boot_linux_console.py | 30 -----------------------
>   tests/functional/meson.build        |  1 +
>   tests/functional/test_ppc_mac.py    | 38 +++++++++++++++++++++++++++++
>   4 files changed, 41 insertions(+), 30 deletions(-)
>   create mode 100755 tests/functional/test_ppc_mac.py
> 
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 3dd80a0138..63eb306d6e 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -1474,6 +1474,7 @@ F: include/hw/ppc/mac_dbdma.h
>   F: include/hw/pci-host/uninorth.h
>   F: include/hw/input/adb*
>   F: pc-bios/qemu_vga.ndrv
> +F: tests/functional/test_ppc_mac.py
>   
>   Old World (g3beige)
>   M: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
> @@ -1489,6 +1490,7 @@ F: include/hw/intc/heathrow_pic.h
>   F: include/hw/input/adb*
>   F: include/hw/pci-host/grackle.h
>   F: pc-bios/qemu_vga.ndrv
> +F: tests/functional/test_ppc_mac.py
>   
>   PReP
>   M: Hervé Poussineau <hpoussin@reactos.org>
> diff --git a/tests/avocado/boot_linux_console.py b/tests/avocado/boot_linux_console.py
> index 344c7835a2..f5dc9e9cfa 100644
> --- a/tests/avocado/boot_linux_console.py
> +++ b/tests/avocado/boot_linux_console.py
> @@ -965,36 +965,6 @@ def test_ppc_powernv10(self):
>           """
>           self.do_test_ppc64_powernv('P10')
>   
> -    def test_ppc_g3beige(self):
> -        """
> -        :avocado: tags=arch:ppc
> -        :avocado: tags=machine:g3beige
> -        :avocado: tags=accel:tcg
> -        """
> -        # TODO: g3beige works with kvm_pr but we don't have a
> -        # reliable way ATM (e.g. looking at /proc/modules) to detect
> -        # whether we're running kvm_hv or kvm_pr. For now let's
> -        # disable this test if we don't have TCG support.
> -        self.require_accelerator("tcg")
> -        tar_hash = 'e0b872a5eb8fdc5bed19bd43ffe863900ebcedfc'
> -        self.vm.add_args('-M', 'graphics=off')
> -        self.do_test_advcal_2018('15', tar_hash, 'invaders.elf')
> -
> -    def test_ppc_mac99(self):
> -        """
> -        :avocado: tags=arch:ppc
> -        :avocado: tags=machine:mac99
> -        :avocado: tags=accel:tcg
> -        """
> -        # TODO: mac99 works with kvm_pr but we don't have a
> -        # reliable way ATM (e.g. looking at /proc/modules) to detect
> -        # whether we're running kvm_hv or kvm_pr. For now let's
> -        # disable this test if we don't have TCG support.
> -        self.require_accelerator("tcg")
> -        tar_hash = 'e0b872a5eb8fdc5bed19bd43ffe863900ebcedfc'
> -        self.vm.add_args('-M', 'graphics=off')
> -        self.do_test_advcal_2018('15', tar_hash, 'invaders.elf')
> -
>       # This test has a 6-10% failure rate on various hosts that look
>       # like issues with a buggy kernel. As a result we don't want it
>       # gating releases on Gitlab.
> diff --git a/tests/functional/meson.build b/tests/functional/meson.build
> index bc33332313..449c6a95ea 100644
> --- a/tests/functional/meson.build
> +++ b/tests/functional/meson.build
> @@ -106,6 +106,7 @@ tests_ppc_system_thorough = [
>     'ppc_40p',
>     'ppc_amiga',
>     'ppc_bamboo',
> +  'ppc_mac',
>     'ppc_mpc8544ds',
>     'ppc_virtex_ml507',
>   ]
> diff --git a/tests/functional/test_ppc_mac.py b/tests/functional/test_ppc_mac.py
> new file mode 100755
> index 0000000000..a6b1ca2d4c
> --- /dev/null
> +++ b/tests/functional/test_ppc_mac.py
> @@ -0,0 +1,38 @@
> +#!/usr/bin/env python3
> +#
> +# Boot Linux kernel on a mac99 and g3beige ppc machine and check the console
> +#
> +# SPDX-License-Identifier: GPL-2.0-or-later
> +
> +from qemu_test import LinuxKernelTest, Asset
> +from qemu_test.utils import archive_extract
> +
> +class MacTest(LinuxKernelTest):
> +
> +    ASSET_DAY15 = Asset(
> +        'https://www.qemu-advent-calendar.org/2018/download/day15.tar.xz',
> +        '03e0757c131d2959decf293a3572d3b96c5a53587165bf05ce41b2818a2bccd5')
> +
> +    def do_day15_test(self):
> +        # mac99 also works with kvm_pr but we don't have a reliable way at
> +        # the moment (e.g. by looking at /proc/modules) to detect whether
> +        # we're running kvm_hv or kvm_pr. For now let's disable this test
> +        # if we don't have TCG support.
> +        self.require_accelerator("tcg")
> +
> +        file_path = self.ASSET_DAY15.fetch()
> +        archive_extract(file_path, self.workdir)
> +        self.vm.add_args('-M', 'graphics=off')
> +        self.launch_kernel(self.workdir + '/day15/invaders.elf',
> +                           wait_for='QEMU advent calendar')
> +
> +    def test_ppc_g3beige(self):
> +        self.set_machine('g3beige')
> +        self.do_day15_test()
> +
> +    def test_ppc_mac99(self):
> +        self.set_machine('mac99')
> +        self.do_day15_test()
> +
> +if __name__ == '__main__':
> +    LinuxKernelTest.main()

Acked-by: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>


ATB,

Mark.


