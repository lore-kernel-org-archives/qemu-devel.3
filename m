Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A4CA4C982DA
	for <qemu-devel@archiver.kernel.org>; Fri, 18 Sep 2026 13:29:17 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x7Ydz-00080G-FM; Fri, 18 Sep 2026 09:28:47 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mark.cave-ayland@ilande.co.uk>)
 id 1x7Ydx-0007zV-BM; Fri, 18 Sep 2026 09:28:45 -0400
Received: from mail.ilande.co.uk ([2001:41c9:1:41f::167])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mark.cave-ayland@ilande.co.uk>)
 id 1x7Ydv-000179-3z; Fri, 18 Sep 2026 09:28:45 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=ilande.co.uk; s=20220518; h=Subject:Content-Transfer-Encoding:Content-Type:
 In-Reply-To:From:References:To:MIME-Version:Date:Message-ID:Sender:Reply-To:
 Cc:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID;
 bh=vuYlT8WGLbo+IjimnuqnwM+iXb7QV7uAeYbZVPXsSKM=; b=xdO7mNMgl/MvjW3tZotjBijEhx
 wDzOS1qeqqmw+YY6RNtCgW07fI6xeP8zbcVAxNtKEHojSBKle/ZR/JJDD6vRwO7C0wPa9EI2X08nr
 H9iXSLt+JfcsoYFSc+8xE5WvcgUgMi5XI64BaH30nlW6LIOwdKBJk9+QMk1c8BJlzblUCYIBtRtFn
 hDkGxxxnZzjsZiH4LW+dWJHK35iLj6EWUgWJr8A6eQ5bnJBlfUPIzKkNFMBdqLW6/gQyvsqih1Ne1
 AT6iQHnzLuHiruul4y4Bxm50+HXJNoGrmXxTiWUYEYIm4cffofeIS2nNL0QzHiRykM0WOQxI8viim
 0MVerVrRzkwZjQ8W0soZ94jxUdoCfbld3flGrrkUdW34l4w4VFU9IjQ88kcR4zRBRrNP8kTKQmEiT
 TkZL+Zm7SCUih17p66XObrx4X42MntQVmCswX5hAKBTiQCPflnWXX2xAVNfEA6GTM3/tNnNHvNmpF
 jlO9l38Kef8z8NzlbxApDN7vOJhnf6lMfHQ37gJBDzPmwWM4rTkTp2MdIOIm0EhN/H/ftFxT6u1rq
 6xygplbn3fXL5rh7EfEhWMJnjmWWG1sCxZewePc9lmQW4yZ/av2h48lSyG7MCbr24ufKF/CJjQcTz
 xhB6DY5kRXhHEMd7yxU1nW65m8QN0u6GqwWmyC8BA=;
Received: from [217.155.175.48] (helo=[10.8.0.6])
 by mail.ilande.co.uk with esmtpsa (TLS1.3) tls
 TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256 (Exim 4.94.2)
 (envelope-from <mark.cave-ayland@ilande.co.uk>)
 id 1x7YdO-00EgVY-8p; Fri, 18 Sep 2026 14:28:10 +0100
Message-ID: <7b782da8-5424-4c6c-b9b7-7ca50fc6749b@ilande.co.uk>
Date: Fri, 18 Sep 2026 14:28:39 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: "Kirill A. Korinsky" <kirill@korins.ky>,
 Chinmay Rath <rathc@linux.ibm.com>, Nicholas Piggin <npiggin@gmail.com>,
 Glenn Miles <milesg@linux.ibm.com>,
 Harsh Prateek Bora <harshpb@linux.ibm.com>, qemu-devel@nongnu.org,
 qemu-ppc@nongnu.org
References: <20260903115229.95811-1-kirill@korins.ky>
 <20260903115229.95811-6-kirill@korins.ky>
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
In-Reply-To: <20260903115229.95811-6-kirill@korins.ky>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-SA-Exim-Connect-IP: 217.155.175.48
X-SA-Exim-Mail-From: mark.cave-ayland@ilande.co.uk
Subject: Re: [PATCH 5/5] tests/functional: Boot OpenBSD on mac99
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

On 03/09/2026 12:50, Kirill A. Korinsky wrote:

> OpenBSD device discovery exercises CTPR masking, zero decrementer
> writes, and CUDA reply timing and layout; regressions in any of these
> paths stall the guest before the installer starts.
> 
> Signed-off-by: Kirill A. Korinsky <kirill@korins.ky>
> ---
>   tests/functional/ppc/meson.build     |  2 ++
>   tests/functional/ppc/test_openbsd.py | 46 ++++++++++++++++++++++++++++
>   2 files changed, 48 insertions(+)
>   create mode 100755 tests/functional/ppc/test_openbsd.py
> 
> diff --git a/tests/functional/ppc/meson.build b/tests/functional/ppc/meson.build
> index ae061fe5a6..1055cdaa17 100644
> --- a/tests/functional/ppc/meson.build
> +++ b/tests/functional/ppc/meson.build
> @@ -2,6 +2,7 @@
>   
>   test_ppc_timeouts = {
>     '40p' : 240,
> +  'openbsd' : 240,
>   }
>   
>   tests_ppc_system_quick = [
> @@ -15,6 +16,7 @@ tests_ppc_system_thorough = [
>     'bamboo',
>     'mac',
>     'mpc8544ds',
> +  'openbsd',
>     'ppe42',
>     'replay',
>     'sam460ex',
> diff --git a/tests/functional/ppc/test_openbsd.py b/tests/functional/ppc/test_openbsd.py
> new file mode 100755
> index 0000000000..cf45930a7c
> --- /dev/null
> +++ b/tests/functional/ppc/test_openbsd.py
> @@ -0,0 +1,46 @@
> +#!/usr/bin/env python3
> +#
> +# Test that OpenBSD boots on mac99 and reaches the installer.
> +#
> +# SPDX-License-Identifier: GPL-2.0-or-later
> +
> +from qemu_test import QemuSystemTest, Asset
> +from qemu_test import wait_for_console_pattern
> +
> +
> +class OpenBSDMac99(QemuSystemTest):
> +
> +    ASSET_CD = Asset(
> +        'https://ftp.eu.openbsd.org/pub/OpenBSD/7.9/macppc/cd79.iso',
> +        '227fef3d5089d56ce8376d8bfa28181ce5b19f0eceef0a6d82d58d8e52832b24')
> +
> +    def test_openbsd_79_installer(self):
> +        self.set_machine('mac99')
> +        self.require_accelerator('tcg')
> +        cdrom_path = self.ASSET_CD.fetch()
> +
> +        self.vm.set_console()
> +        self.vm.add_args('-M', 'via=cuda,graphics=off,usb=off',
> +                         '-cpu', '7400',
> +                         '-accel', 'tcg,thread=single',
> +                         '-smp', '1',
> +                         '-m', '2g',
> +                         '-nic', 'none',
> +                         '-device', 'VGA',
> +                         '-global', 'cuda.sr-delay-ns=0',
> +                         '-prom-env', 'input-device=ttya',
> +                         '-prom-env', 'output-device=ttya',
> +                         '-cdrom', cdrom_path,
> +                         '-boot', 'd',
> +                         '-no-reboot')
> +        self.vm.launch()
> +
> +        wait_for_console_pattern(self, 'OpenBSD 7.9 (RAMDISK)', 'panic:')
> +        wait_for_console_pattern(
> +            self,
> +            '(I)nstall, (U)pgrade, (A)utoinstall or (S)hell?',
> +            'panic:')
> +
> +
> +if __name__ == '__main__':
> +    QemuSystemTest.main()

LGTM, although I'm curious as to why you need to set usb=off - given that USB is 
mandatory for mac99 machines, presumably this means there is a bug somewhere in our 
OHCI emulation somewhere being tickled by OpenBSD?


ATB,

Mark.


