Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5690ACD4F25
	for <qemu-devel@archiver.kernel.org>; Fri, 15 May 2026 16:32:24 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wNvRg-0005y9-3b; Fri, 15 May 2026 12:31:28 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@kaod.org>) id 1wNvRe-0005us-Il
 for qemu-devel@nongnu.org; Fri, 15 May 2026 12:31:26 -0400
Received: from smtpout4.mo533.mail-out.ovh.net ([46.105.32.238])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@kaod.org>) id 1wNvRc-0002RY-IJ
 for qemu-devel@nongnu.org; Fri, 15 May 2026 12:31:26 -0400
Received: from director2.derp.mail-out.ovh.net
 (director2.derp.mail-out.ovh.net [79.137.60.36])
 by mo533.mail-out.ovh.net (Postfix) with ESMTPS id 4gHCPl1CkTz5wpN;
 Fri, 15 May 2026 16:31:23 +0000 (UTC)
Received: from director2.derp.mail-out.ovh.net
 (director2.derp.mail-out.ovh.net. [127.0.0.1])
 by director2.derp.mail-out.ovh.net (inspect_sender_mail_agent) with SMTP
 for <alexander.hansen@9elements.com>; Fri, 15 May 2026 16:31:23 +0000 (UTC)
Received: from mta3.priv.ovhmail-u2.ea.mail.ovh.net (unknown [10.109.254.188])
 by director2.derp.mail-out.ovh.net (Postfix) with ESMTPS id
 4gHCPl0819z1xpG; Fri, 15 May 2026 16:31:23 +0000 (UTC)
Received: from kaod.org (unknown [10.1.6.1])
 (Authenticated sender: clg@kaod.org)
 by mta3.priv.ovhmail-u2.ea.mail.ovh.net (Postfix) with ESMTPSA id A7F8512E3598;
 Fri, 15 May 2026 16:31:21 +0000 (UTC)
Authentication-Results: garm.ovh; auth=pass
 (GARM-102R004aaf97d14-17fc-4e30-9f6a-eddfb572b3a5,
 EA554B2574883C805624521E1FD22DE9D7B94BA5) smtp.auth=clg@kaod.org
X-OVh-ClientIp: 90.14.253.154
Message-ID: <5caa0cbb-1026-4b35-a439-7063a7f533f9@kaod.org>
Date: Fri, 15 May 2026 18:31:21 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 2/5] ast2600: yosemite4 functional test
To: Alexander Hansen <alexander.hansen@9elements.com>, qemu-devel@nongnu.org
Cc: Titus Rwantare <titusr@google.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 Steven Lee <steven_lee@aspeedtech.com>, Troy Lee <leetroy@gmail.com>,
 Jamin Lin <jamin_lin@aspeedtech.com>, Kane Chen <kane_chen@aspeedtech.com>,
 Andrew Jeffery <andrew@codeconstruct.com.au>, Joel Stanley <joel@jms.id.au>,
 qemu-arm@nongnu.org
References: <20260515150610.381066-1-alexander.hansen@9elements.com>
 <20260515150610.381066-3-alexander.hansen@9elements.com>
Content-Language: en-US, fr
From: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@kaod.org>
Autocrypt: addr=clg@kaod.org; keydata=
 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
In-Reply-To: <20260515150610.381066-3-alexander.hansen@9elements.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
x-ovh-tracer-id: 5357876183776406539
X-VR-SPAMSTATE: OK
X-VR-SPAMSCORE: -100
X-VR-SPAMCAUSE: dmFkZTESX7LLP6HJoy/mY35uOn0GAxlaohNKM2fWZsTuCrPUpFYuiTvHqbwAHOM1IwQqk3WkVHxLx8sNSlW4sHRnUL91/GDDni5l2DKPJo06yK4LZoURl2wlC1CXZuOWxpcxocZnPKoE1wxvRHlZSzSdB0JnksRO9a77PZP5a5LSWX9dUTZhd92HTm0DJad5ydn0hYQ/xFLC7m0S1DZviVZKsyDAYbc2DFZFUzQ9ScEd4NNfpAsEf1dqw2fCqAHmcGY0XUGw6Tz2X89EEH2wsGLL+/XK6ShOcXUls1uWxDrkg+qYa8rsqPKXJuDhC5llgjif77uOqOeRuLClq9073tDjXSQPQzHYiqlsSmtJHe+voS0k8Qt1O8GZlVHoItpjrdUn+68vNgC8KGPy9Tpf6blQh5CldYL9YbC46dlwt90eFIOx+cCEyqiCAtgxR8+mcEjugppHcZUAy9bbq/XLC/rbTTvWF+mYDupP68RsF95J0CYgg+2Ija9/qxDzE2xsLDk1IZKuHJB1FCHIndFFTFp6AjtNEnf2oTiR/tA3i097AD10wm4jamuu/oEmDel0POe1zaY18pXNTdyxOAADr4lQbCYzvp4wYk9kKnE8KYuI9+e0yZv645dB10OVf2lwYY7YilYojsS0Eaq6GxZDlQDOjlQf3HruV7u+0chNuzgJptOtZQ
DKIM-Signature: a=rsa-sha256; bh=7223dbm/lsnGZfFELJRzumyxlmnTx1n543xIz0XVVHU=; 
 c=relaxed/relaxed; d=kaod.org; h=From; s=ovhmo393970-selector1;
 t=1778862683; v=1;
 b=TmdrDHXgeZ9m4jX6FgJprS7lwG7Hfkb4mqHjIK9dbVxXyt+GCqqR6lQwlfU5YaCHoV4qTqeF
 ezlkI7ncBruHru7bt/ujQ3dGOCJQddQDQxZTSlk/Ib079lNTg+dbutmTjI0U+nclUOQ6PE4ATHJ
 HNgu904TuG3w/iw+XwsAiZqxzn4fm4jnhzOpx4M/LQ41+lct3Y9v0cuex9hheaDXsEgwhu8PlbK
 //tkKaVg5ZR77f/ge/Qj6/1hCwJWzF/XW2dYKvEiw3ep5SJ41Ety27f4NnPjBfn3YAm9LH2HHza
 8QRSGXqwMurjAVmdXnWdhcWk3+MRgWAjydmXv0+ODUTgA==
Received-SPF: pass client-ip=46.105.32.238; envelope-from=clg@kaod.org;
 helo=smtpout4.mo533.mail-out.ovh.net
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
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

On 5/15/26 16:57, Alexander Hansen wrote:
> Add a functional test for the Yosemite V4 (fby4-bmc) machine
> that validates:
> - U-Boot initialization and kernel boot sequence
> 
> The test uses an OpenBMC image built for the yosemite4 board and
> validates console output through the boot process.
> 
> Cc: Titus Rwantare <titusr@google.com>
> Cc: "Cédric Le Goater" <clg@kaod.org> (maintainer:ASPEED BMCs)
> Cc: Peter Maydell <peter.maydell@linaro.org> (maintainer:ASPEED BMCs)
> Cc: Steven Lee <steven_lee@aspeedtech.com> (reviewer:ASPEED BMCs)
> Cc: Troy Lee <leetroy@gmail.com> (reviewer:ASPEED BMCs)
> Cc: Jamin Lin <jamin_lin@aspeedtech.com> (reviewer:ASPEED BMCs)
> Cc: Kane Chen <kane_chen@aspeedtech.com> (reviewer:ASPEED BMCs)
> Cc: Andrew Jeffery <andrew@codeconstruct.com.au> (reviewer:ASPEED BMCs)
> Cc: Joel Stanley <joel@jms.id.au> (reviewer:ASPEED BMCs)
> Cc: qemu-arm@nongnu.org (open list:ASPEED BMCs)
> Cc: qemu-devel@nongnu.org (open list:All patches CC here)
> Signed-off-by: Alexander Hansen <alexander.hansen@9elements.com>
> ---
>   tests/functional/arm/meson.build         |  2 ++
>   tests/functional/arm/test_aspeed_fby4.py | 44 ++++++++++++++++++++++++
>   2 files changed, 46 insertions(+)
>   create mode 100755 tests/functional/arm/test_aspeed_fby4.py
> 
> diff --git a/tests/functional/arm/meson.build b/tests/functional/arm/meson.build
> index 2f538f29a2..10c0006f22 100644
> --- a/tests/functional/arm/meson.build
> +++ b/tests/functional/arm/meson.build
> @@ -14,6 +14,7 @@ test_arm_timeouts = {
>     'aspeed_ast2600_sdk_otp' : 720,
>     'aspeed_bletchley' : 480,
>     'aspeed_catalina' : 480,
> +  'aspeed_fby4': 480,
>     'aspeed_gb200nvl_bmc' : 480,
>     'aspeed_rainier' : 480,
>     'bpim2u' : 500,
> @@ -47,6 +48,7 @@ tests_arm_system_thorough = [
>     'aspeed_ast2600_sdk_otp',
>     'aspeed_bletchley',
>     'aspeed_catalina',
> +  'aspeed_fby4',
>     'aspeed_gb200nvl_bmc',
>     'aspeed_rainier',
>     'bpim2u',
> diff --git a/tests/functional/arm/test_aspeed_fby4.py b/tests/functional/arm/test_aspeed_fby4.py
> new file mode 100755
> index 0000000000..a3124c240f
> --- /dev/null
> +++ b/tests/functional/arm/test_aspeed_fby4.py
> @@ -0,0 +1,44 @@
> +#!/usr/bin/env python3
> +#
> +# Functional test that boots the ASPEED machines
> +#
> +# SPDX-License-Identifier: GPL-2.0-or-later
> +
> +from qemu_test import Asset
> +from aspeed import AspeedTest
> +
> +
> +class YosemiteV4Machine(AspeedTest):
> +
> +    ASSET_YOSEMITE_V4_FLASH = Asset(
> +        'https://github.com/legoater/qemu-aspeed-boot/raw/refs/heads/master/images/yosemite4-bmc/openbmc-20260505132843/obmc-phosphor-image-yosemite4-20260505132843.static.mtd.xz',
> +        'dff6946363b41f952b15cfc3156482b89fcfc1b0ecfc3ec8b3ed496a5f001ef9')
> +
> +    def do_test_arm_aspeed_openbmc_no_network(self, machine, image, uboot,
> +                                   cpu_id, soc):
> +
> +        self.set_machine(machine)
> +        self.vm.set_console()
> +        self.vm.add_args('-drive', f'file={image},if=mtd,format=raw',
> +                         '-snapshot')
> +        self.vm.launch()
> +
> +        self.wait_for_console_pattern(f'U-Boot {uboot}')
> +        self.wait_for_console_pattern('## Loading kernel from FIT Image')
> +        self.wait_for_console_pattern('Starting kernel ...')
> +        self.wait_for_console_pattern(f'Booting Linux on physical CPU {cpu_id}')
> +        self.wait_for_console_pattern(f'ASPEED {soc}')
> +        self.wait_for_console_pattern('/init as init process')
> +        # yosemite v4 does not emit the hostname log which is
> +        # different from the other machines.
> +        self.wait_for_console_pattern('yosemite4 login:')
> +
> +    def test_arm_ast2600_yosemitev4_openbmc(self):
> +        image_path = self.uncompress(self.ASSET_YOSEMITE_V4_FLASH)
> +
> +        self.do_test_arm_aspeed_openbmc_no_network('fby4-bmc', image=image_path,
> +                                        uboot='2019.04', cpu_id='0xf00',
> +                                        soc='AST2600 rev A3')
> +
> +if __name__ == '__main__':
> +    AspeedTest.main()


Reviewed-by: Cédric Le Goater <clg@redhat.com>

Thanks,

C.


