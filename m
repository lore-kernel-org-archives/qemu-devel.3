Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EEA4EE77188
	for <qemu-devel@archiver.kernel.org>; Wed,  8 Jan 2025 22:14:38 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tVeJ9-0002SZ-CD; Wed, 08 Jan 2025 17:13:47 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <deller@gmx.de>) id 1tVeJ7-0002SL-EE
 for qemu-devel@nongnu.org; Wed, 08 Jan 2025 17:13:45 -0500
Received: from mout.gmx.net ([212.227.17.22])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <deller@gmx.de>) id 1tVeJ5-0000GI-Ds
 for qemu-devel@nongnu.org; Wed, 08 Jan 2025 17:13:45 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
 s=s31663417; t=1736374416; x=1736979216; i=deller@gmx.de;
 bh=Eb1MKDhCL5fFfdSHU6bsMMdirvNL1pcv48maTCfDgqk=;
 h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:Cc:
 References:From:In-Reply-To:Content-Type:
 Content-Transfer-Encoding:cc:content-transfer-encoding:
 content-type:date:from:message-id:mime-version:reply-to:subject:
 to;
 b=lBr/UtSsSa9ExCmHcGoPJuEBi3VX8RTu4NmemSZWKilvSiKIuK9IaxFisMaqzb5Q
 SaZ2ekdwheGzp8oFbcCHzoPshzZrP3rP5pf16aVWY/fDBOT4gP+4GP035AMtABsmT
 vN8iGRc7funRvkJkvfEkXXHIDjKw2UHIUpep0ioTp189bdeSvgGAP+v9DgjVh5Nd4
 wTRSAi0dixWbWUzOQmwrH3nw57nuMeO+AKNhBECZpL8xNl8p8jJITjbljWywLhNP2
 Wua/y87X/FzxgY40IyLhfn50v0pouwdX73lNK+abZ+GrhOgskkseUQA8g/E7gbKoM
 93WiDOnmFEz9x/SB7A==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [192.168.20.172] ([83.135.220.169]) by mail.gmx.net (mrgmx104
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1Mof9F-1tpWf33IhV-00blbV; Wed, 08
 Jan 2025 23:13:36 +0100
Message-ID: <3744588b-7fbc-4b38-8572-3e07678c4fc3@gmx.de>
Date: Wed, 8 Jan 2025 23:13:38 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 1/6] tests: Add functional tests for HPPA machines
To: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 qemu-devel@nongnu.org
Cc: Richard Henderson <richard.henderson@linaro.org>
References: <20241231190620.24442-1-philmd@linaro.org>
 <20241231190620.24442-2-philmd@linaro.org>
Content-Language: en-US
From: Helge Deller <deller@gmx.de>
Autocrypt: addr=deller@gmx.de; keydata=
 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
In-Reply-To: <20241231190620.24442-2-philmd@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:vAaxx/j5nzp8aR3qbd2z9yORTsFfMIlPBCe9lmJCm8+2yr4YcWf
 FcgE0duxRU01/ZsFvYdN37oAubV6LDg7uTExCNmDbgVAvghzbjAMatRiUWV7zecafCLKK0z
 lSMKqds6Ov+p7N/BO+ridx6zGl/faCyqfU55+gbjehZOE2ihNCupODG4RnNtgHjuVJISHYr
 PZYAK3Utuc8JvvDgwR3xQ==
UI-OutboundReport: notjunk:1;M01:P0:nq5XWcGsiFw=;rButCy01Cf4kvTrxGI4pErJnq+S
 PmVsTLDW0+DIv3/9rbt8tHejGrPl8n/j+CS/yiGnexl5Q+TYYhNKfp5Jl+QqdsSyfar33KI8l
 Sj7DTeJY3EJLxpkOfG4J9wm7D9f71zilQkj1G7YwyKEa6K0pnwp2Xq+pYcGQdxk+wpGNMeqat
 qu0X9UOT+1UywS88nbA55g8xR8Frx4RgJwh5Bc1mZgPcqg1n5dKSatqTaMqSeMVY7y0XeW7AY
 TnSoSqD/qS1crpUEpc0hmLAh7p6SKmJshduwScM8v4O6tMGyE7P8lfbBP1y60IlEdswlppGm+
 UTKlBrAJpzs4fBO5PIjMHnYpjGhvLUadBMGy0SW0+KXkkE0/fXPugM17rNLLITDUGqorj5n4H
 OZ6ze1BQwv1BOrITutRP4O5FFYYpHgss0Z5ohB/TlRa9+VNmJdO3eqOeup7hr1Ov2v13v+Zzz
 MzZ0UYlkGboLNKgxfBTG8dzW4RKnZgENLBZ7xgQO2fsS/bQ7uYa5TZtWFUFI2kErITuzGDxZb
 0V23vsSjwru7e1YWnJI2DgUHMvKg4cUtjkvv+bJ3L8ouk9zEY9fHkLquL/Hrljsg/3rH+5kOF
 RPLfL/qliHY4qQwUE3v4+gc4Jn9XmnuKgZFLNrrtidICPMsucWBugxIfz6L1iuCtEN2L8l4J8
 nv2wvZRutKDiMWIdFQaCl5GmvHqiZsUZiC0nGJPtp6rHFYfRgPnEFrZlkx83J+YOumYYxkYjm
 mw/tUmz9LVqAYXAEJb99VwG4dlBVdUUjQUicCxiZx4ScqYcnjS/1mOpxLnVOcT1c0lAz+d/vM
 mqlJOrTzHbGWuBvM+BhbhAitp7fdckz55oiYccofnzcsN20fl7fQh257zHS8AK88QonEzyhfz
 FrYQu0evgtXd9S54FB/R5r0F0zxKgsPeYp6Mb+AceL41lUy/Vvih+FbG651pkt2lOET/+YDUe
 rghVY6KN10kFHFW5/VvuXvl1SB3+0038SrIjepaVnQL6S9eSLjwltq2NEopCL7bo9V3LaV6na
 NKaZiDye8toEkIuKteywWMaqYaS/1l5IVtTX+gFXsYuHhDQnUgMyjA1RQPPf+a1nNGLO1NKI9
 y0I9/6y0twMz3TlAmMkg3JzymT1E69
Received-SPF: pass client-ip=212.227.17.22; envelope-from=deller@gmx.de;
 helo=mout.gmx.net
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

On 12/31/24 20:06, Philippe Mathieu-Daud=C3=A9 wrote:
> Add quick firmware boot tests (less than 1sec) for the
> B160L (32-bit) and C3700 (64-bit) HPPA machines:
>
>    $ make check-functional-hppa
>    1/4 qemu:func-quick+func-hppa / func-hppa-empty_cpu_model OK 0.13s 1 =
subtests passed
>    2/4 qemu:func-quick+func-hppa / func-hppa-version         OK 0.14s 1 =
subtests passed
>    3/4 qemu:func-quick+func-hppa / func-hppa-info_usernet    OK 0.22s 1 =
subtests passed
>    4/4 qemu:func-quick+func-hppa / func-hppa-hppa_seabios    OK 0.22s 2 =
subtests passed
>
> Suggested-by: Helge Deller <deller@gmx.de>
> Signed-off-by: Philippe Mathieu-Daud=C3=A9 <philmd@linaro.org>

Reviewed-by: Helge Deller <deller@gmx.de>

> ---
>   MAINTAINERS                           |  1 +
>   tests/functional/meson.build          |  4 +++
>   tests/functional/test_hppa_seabios.py | 35 +++++++++++++++++++++++++++
>   3 files changed, 40 insertions(+)
>   create mode 100755 tests/functional/test_hppa_seabios.py
>
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 38a290e9c2c..17c720dd2b9 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -1201,6 +1201,7 @@ F: include/hw/pci-host/astro.h
>   F: include/hw/pci-host/dino.h
>   F: pc-bios/hppa-firmware.img
>   F: roms/seabios-hppa/
> +F: tests/functional/test_hppa_seabios.py
>
>   LoongArch Machines
>   ------------------
> diff --git a/tests/functional/meson.build b/tests/functional/meson.build
> index 24f7f8f2f1c..71810a3aa82 100644
> --- a/tests/functional/meson.build
> +++ b/tests/functional/meson.build
> @@ -104,6 +104,10 @@ tests_avr_system_thorough =3D [
>     'avr_mega2560',
>   ]
>
> +tests_hppa_system_quick =3D [
> +  'hppa_seabios',
> +]
> +
>   tests_i386_system_thorough =3D [
>     'i386_tuxrun',
>   ]
> diff --git a/tests/functional/test_hppa_seabios.py b/tests/functional/te=
st_hppa_seabios.py
> new file mode 100755
> index 00000000000..a44d1a3eebe
> --- /dev/null
> +++ b/tests/functional/test_hppa_seabios.py
> @@ -0,0 +1,35 @@
> +#!/usr/bin/env python3
> +#
> +# SeaBIOS boot test for HPPA machines
> +#
> +# Copyright (c) 2024 Linaro, Ltd
> +#
> +# SPDX-License-Identifier: GPL-2.0-or-later
> +
> +from qemu_test import QemuSystemTest
> +from qemu_test import wait_for_console_pattern
> +
> +class HppaSeabios(QemuSystemTest):
> +
> +    timeout =3D 5
> +    MACH_BITS =3D {'B160L': 32, 'C3700': 64}
> +
> +    def boot_seabios(self):
> +        mach =3D self.machine
> +        bits =3D self.MACH_BITS[mach]
> +        self.vm.set_console()
> +        self.vm.launch()
> +        self.machine
> +        wait_for_console_pattern(self, f'SeaBIOS PA-RISC {bits}-bit Fir=
mware')
> +        wait_for_console_pattern(self, f'Emulated machine:     HP {mach=
} ({bits}-bit')
> +
> +    def test_hppa_32(self):
> +        self.set_machine('B160L')
> +        self.boot_seabios()
> +
> +    def test_hppa_64(self):
> +        self.set_machine('C3700')
> +        self.boot_seabios()
> +
> +if __name__ =3D=3D '__main__':
> +    QemuSystemTest.main()


