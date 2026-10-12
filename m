Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C63F3CA9ED0
	for <qemu-devel@archiver.kernel.org>; Mon, 12 Oct 2026 20:58:03 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xGN41-0004Se-M7; Mon, 12 Oct 2026 16:56:05 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mark.cave-ayland@ilande.co.uk>)
 id 1xGN3D-0003sR-BP; Mon, 12 Oct 2026 16:55:15 -0400
Received: from mail.ilande.co.uk ([2001:41c9:1:41f::167])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mark.cave-ayland@ilande.co.uk>)
 id 1xGN3B-0006Wd-0X; Mon, 12 Oct 2026 16:55:14 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=ilande.co.uk; s=20220518; h=Subject:Content-Transfer-Encoding:Content-Type:
 In-Reply-To:From:References:To:MIME-Version:Date:Message-ID:Sender:Reply-To:
 Cc:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID;
 bh=ipgsKY2Shmfrw7hQyu9AObRAmoU59Q5iI9FYpvZtX9A=; b=TQlsqdJ6es/xyMMTA6s9oKLHpV
 y2qJm1pHCIwKeB2Wxc6jZwvRW/UrWoGlHC13TxllCF4of/z3Iyh0MkmJFd3l1Yt8mGC/89ItzvXsM
 3qmjTLYmaVEVlY0MvjarryHZMLcjSFsY0cDY06DrDD9q0ffXvTAvYHAOUsG9dEGWx4LfcFrf34yiK
 MqMWgxcEbJRJ44gaTZlvSIRut/OIqcUgLKW3dykxqSX3quSW3hdA+Ju0AFLClXkkpaf/cWcBit9S2
 cIF8GKS8T+109RihheeeGj1MfOOumxfnkKTg/lRxejrvzZ7dMN+bi+OibMO8lsyKw9UaXHLJi5Cjo
 fwRKD4YEfwbj0zed0tyKU/MULZGfpGlqWAr/WW9V6zD1ficAEhO2uzOuENkDyuobFl5lgAtmirIeu
 FNOD0QmyogIMqObNwVyZFtfVgdemrF9DbLoLTXs7fvKWYJb+HkvcIMDvGi+TrtKqJ/X/lr9rs+v9p
 nDF6RzA3enYhMdWQ/RfAMVHW+0UFS52uBv4MFudDURGJ5u18kr5NqC1c7z5Q1Wozh6z5cw43Mxc5H
 kT80Xa6RFJb/AdtmMNv9JWII2Dq0UY7TFkGls62ue2vk65A1yMU0yZxW/jqypwKME+GVc0kilZDys
 PfYb2Co7UL7dl2dgD6B7DkVBGUDRTUTEA3rryH0Fo=;
Received: from [2a02:8012:2f01:0:8476:43c8:da7d:456]
 by mail.ilande.co.uk with esmtpsa (TLS1.3) tls
 TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256 (Exim 4.94.2)
 (envelope-from <mark.cave-ayland@ilande.co.uk>)
 id 1xGN2R-001PKa-3k; Mon, 12 Oct 2026 21:54:31 +0100
Message-ID: <e5c0b66a-0c1c-4369-837f-04f8562eeec3@ilande.co.uk>
Date: Mon, 12 Oct 2026 21:55:01 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: "Kirill A. Korinsky" <kirill@korins.ky>,
 Harsh Prateek Bora <harshpb@linux.ibm.com>,
 Chinmay Rath <rathc@linux.ibm.com>, Nicholas Piggin <npiggin@gmail.com>,
 qemu-devel@nongnu.org, qemu-ppc@nongnu.org,
 Anushree Mathur <anushree.mathur@linux.ibm.com>,
 BALATON Zoltan <balaton@eik.bme.hu>, Miles Glenn <milesg@linux.ibm.com>
References: <20261001230058.11465-1-kirill@korins.ky>
 <20261001230058.11465-6-kirill@korins.ky>
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
In-Reply-To: <20261001230058.11465-6-kirill@korins.ky>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-SA-Exim-Connect-IP: 2a02:8012:2f01:0:8476:43c8:da7d:456
X-SA-Exim-Mail-From: mark.cave-ayland@ilande.co.uk
Subject: Re: [PATCH v3 5/5] tests/functional: Boot OpenBSD on mac99
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

On 01/10/2026 23:59, Kirill A. Korinsky wrote:

> From: "Kirill A. Korinsky" <kirill@korins.ky>
> 
> OpenBSD device discovery exercises CTPR masking, zero decrementer
> writes, and CUDA reply timing and layout; regressions in any of these
> paths stall the guest before the installer starts.
> 
> Signed-off-by: Kirill A. Korinsky <kirill@korins.ky>
> Tested-by: Anushree Mathur <anushree.mathur@linux.ibm.com>
> Tested-by: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
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
> index 0000000000..73fa328b1f
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
> +                         '-global', 'cuda.x-sr-delay-ns=0',
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

Reviewed-by: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>


ATB,

Mark.


