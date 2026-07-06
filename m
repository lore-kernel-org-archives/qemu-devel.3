Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 81226C43458
	for <qemu-devel@archiver.kernel.org>; Mon,  6 Jul 2026 08:07:23 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wgeM4-0007Fk-VG; Mon, 06 Jul 2026 04:07:04 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@kaod.org>) id 1wgeM2-0007E2-TZ
 for qemu-devel@nongnu.org; Mon, 06 Jul 2026 04:07:03 -0400
Received: from smtpout8.mo536.mail-out.ovh.net ([51.210.91.17])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@kaod.org>) id 1wgeLz-000267-Nw
 for qemu-devel@nongnu.org; Mon, 06 Jul 2026 04:07:02 -0400
Received: from director5.derp.mail-out.ovh.net
 (director5.derp.mail-out.ovh.net [57.128.106.70])
 by mo536.mail-out.ovh.net (Postfix) with ESMTPS id 4gtxlf3VZDz826P;
 Mon,  6 Jul 2026 08:06:54 +0000 (UTC)
Received: from director5.derp.mail-out.ovh.net
 (director5.derp.mail-out.ovh.net. [127.0.0.1])
 by director5.derp.mail-out.ovh.net (inspect_sender_mail_agent) with SMTP
 for <alexander.hansen@9elements.com>; Mon,  6 Jul 2026 08:06:54 +0000 (UTC)
Received: from mta6.priv.ovhmail-u2.ea.mail.ovh.net (unknown [10.110.101.74])
 by director5.derp.mail-out.ovh.net (Postfix) with ESMTPS id
 4gtxlf0Ksqz7t8l; Mon,  6 Jul 2026 08:06:54 +0000 (UTC)
Received: from kaod.org (unknown [10.1.6.0])
 (Authenticated sender: clg@kaod.org)
 by mta6.priv.ovhmail-u2.ea.mail.ovh.net (Postfix) with ESMTPSA id 393361B436D6;
 Mon,  6 Jul 2026 08:06:51 +0000 (UTC)
Authentication-Results: garm.ovh; auth=pass
 (GARM-110S00453dc6de7-f585-4933-9ae3-c9a8cdbae867,
 85E5B3372E37D114A8148E0C2423338A4BE4238A) smtp.auth=clg@kaod.org
X-OVh-ClientIp: 82.64.250.170
Message-ID: <1ad9b0b5-e98f-4552-bc2d-6db76dfcd1ee@kaod.org>
Date: Mon, 6 Jul 2026 10:06:49 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 8/8] test/functional: anacapa: test ADC128D818
To: Emmanuel Blot <emmanuel.blot@free.fr>, qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@mailo.com>,
 Fabiano Rosas <farosas@suse.de>, Laurent Vivier <lvivier@redhat.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 Steven Lee <steven_lee@aspeedtech.com>, Troy Lee <leetroy@gmail.com>,
 Jamin Lin <jamin_lin@aspeedtech.com>, Kane Chen <kane_chen@aspeedtech.com>,
 Andrew Jeffery <andrew@codeconstruct.com.au>, Joel Stanley <joel@jms.id.au>,
 Alexander Hansen <alexander.hansen@9elements.com>,
 William de Abreu Pinho <williampinho@meta.com>,
 Emmanuel Blot <eblot@meta.com>, qemu-arm@nongnu.org,
 Corey Minyard <cminyard@mvista.com>
References: <20260701-i2c-adc128d818-anacapa-v5-0-fe8292d86b38@free.fr>
 <20260701-i2c-adc128d818-anacapa-v5-8-fe8292d86b38@free.fr>
Content-Language: en-US, fr
From: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@kaod.org>
Autocrypt: addr=clg@kaod.org; keydata=
 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
In-Reply-To: <20260701-i2c-adc128d818-anacapa-v5-8-fe8292d86b38@free.fr>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
x-ovh-tracer-id: 7070088465244859437
X-VR-SPAMSTATE: OK
X-VR-SPAMSCORE: -100
X-VR-SPAMCAUSE: dmFkZTFeh+gB3y7VoxEN0SzBgfPMPMnPkNg4RTltI45OCkWIVWWAP5nGfbrH8vlIrvQVC8fhOIinNTHY0c5Qgjragv0OG0g2NYTZfBkkcIzEIE4Cc3A7s6YzBShCKMovz7tDwv4tx67oa7LBbw8gN//w9MeI8HnPu7xfc4+bLtLyGE2Rh/dTmAsB64MR9wQ2Fao6Z7x/JxxnhEVBmhTN6ybVD5UW3k8ojHkScUp8l2BMHUvufxsC/TqTSKFDJ5r2q0QTXh+deilWn9IW0wqejuW5lOlCR3jp0rIP0a9PNs0wR238/EViNq6RCMfdWkD7+zs4+xQUb8OaJNe03h/gAPL49weBrHanbFCmAv8uB79ViYOgBNxegGavRihiySzFjtc4emhHue/OAnTDfkoznsrwAGZPB5V3Kspe3VpUofAalrVInbZt8Jr9fQ84eIdZ4S4QYJkWotr+IW1mzxtnFsIGyw+Hqw6FrwVDIPzwGQK9ihM4WJN1/6PuWoxNpZwvjkGlHCbZ9crsgOJBEOBtS9WW/vmInEbgq1YQQFHszp5HfTI88wbqFK9YYzhWB3icL6KTfs5WiNSqKGNNT6/f8/t6PQPbrJjCku3GJXDege/yLu1090I/UrsWkiU5imwyd106f8nRt7XOkGH422baaWbHli/yWJRI2ixtR5jfM6OdbACYaw
DKIM-Signature: a=rsa-sha256; bh=WAjn3amkZVXFmC+tRxqujawMsxmiAYugBResNjLb4xA=; 
 c=relaxed/relaxed; d=kaod.org; h=From; s=ovhmo393970-selector1;
 t=1783325216; v=1;
 b=MBUIaITTNCg4n7x4Zq7HGxhPmfQ5hVxb6uIGo7bKTFoG2A7B+hgpKcsC1H6I24rmkixfV3VM
 7uSR5X0Ur4DY8GrruZ4UMFxgq3hyxrhzbeQbB99V92mz0I+8du+hctVa+xfUhW4cy5vS3F6OCdZ
 etwSrj1hQOaqmTSOdTVzWy0XnrK5wm6OCz5ULiJZl66ieOOLWOwBWEbADzfEHKuSrH5znq8G2He
 Kon0+Wtjxbd/aYBhY1yWO0OI8XUUQO4Lcgz9T1icmpV18/DKwHpVhIC1OQi4vXo91aop3/bR9yD
 3/FO4hA/Hs+ePBd8H8rJ+N+mVUP00nvRldKpGg5vRLIcw==
Received-SPF: pass client-ip=51.210.91.17; envelope-from=clg@kaod.org;
 helo=smtpout8.mo536.mail-out.ovh.net
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

On 7/1/26 19:28, Emmanuel Blot wrote:
> Verify the ADC128D818 on the Anacapa R-PDB (i2c8 mux channel 0): two
> channels are driven with distinct voltages and each is checked to be
> reported back independently through the kernel hwmon interface, and the
> channel 0 limit registers are validated.
> 
> Signed-off-by: Emmanuel Blot <emmanuel.blot@free.fr>
> ---
>   tests/functional/arm/test_aspeed_anacapa.py | 69 ++++++++++++++++++++++++++---
>   1 file changed, 63 insertions(+), 6 deletions(-)
> 
> diff --git a/tests/functional/arm/test_aspeed_anacapa.py b/tests/functional/arm/test_aspeed_anacapa.py
> index 2b72e46b0e..49fab7ad09 100644
> --- a/tests/functional/arm/test_aspeed_anacapa.py
> +++ b/tests/functional/arm/test_aspeed_anacapa.py
> @@ -2,24 +2,81 @@
>   #
>   # Functional test that boots the ASPEED machines
>   #
> +# Copyright (c) 2026 Meta Platforms, Inc. and affiliates.
> +#
>   # SPDX-License-Identifier: GPL-2.0-or-later
>   
> +import re
> +import time
> +
>   from qemu_test import Asset
> +from qemu_test import exec_command_and_wait_for_pattern
>   from aspeed import FacebookAspeedTest
>   
>   
>   class AnacapaMachine(FacebookAspeedTest):
>   
>       ASSET_ANACAPA_FLASH = Asset(
> -        'https://github.com/legoater/qemu-aspeed-boot/raw/c5f585f9f57843c0dc95e3865a57d92ec39cbb0b/images/anacapa-bmc/openbmc-20260616025349/obmc-phosphor-image-anacapa-20260616025349.static.mtd.xz',
> -        'de3841fb6ed3085aec6424358ee6efc4b8ee85688361e5aa1987fd1acb7d3fb4')
> +        "https://github.com/legoater/qemu-aspeed-boot/raw/c5f585f9f57843c0dc95e3865a57d92ec39cbb0b/images/anacapa-bmc/openbmc-20260616025349/obmc-phosphor-image-anacapa-20260616025349.static.mtd.xz",
> +        "de3841fb6ed3085aec6424358ee6efc4b8ee85688361e5aa1987fd1acb7d3fb4",
> +    )
> +
> +    ADC128D818_QOM_PATH = \
> +        "/machine/soc/i2c/bus[8]/aspeed.i2c.bus.8/0x72/i2c.0/0x1f"
> +    ADC128D818_MUX_CHANNEL = "/sys/bus/i2c/devices/8-0072/channel-0"
> +    PROMPT = "root@anacapa:~#"
>   
>       def test_arm_ast2600_anacapa_openbmc(self):
>           image_path = self.uncompress(self.ASSET_ANACAPA_FLASH)
>   
> -        self.do_test_arm_aspeed_openbmc('anacapa-bmc', image=image_path,
> -                                        uboot='2019.04', cpu_id='0xf00',
> -                                        soc='AST2600 rev A3')
> +        self.do_test_arm_aspeed_openbmc(
> +            "anacapa-bmc",
> +            image=image_path,
> +            uboot="2019.04",
> +            cpu_id="0xf00",
> +            soc="AST2600 rev A3",
> +        )
>   
> -if __name__ == '__main__':
> +        exec_command_and_wait_for_pattern(self, "root", "Password:")
> +        exec_command_and_wait_for_pattern(self, "0penBmc", "#")
> +
> +        self.adc_hwmon = self.resolve_adc128d818_hwmon()
> +        self.assertIn(b"adc128d818", self.read_adc128d818("name"))
> +
> +        adc = self.ADC128D818_QOM_PATH
> +        for ch0_mv, ch1_mv in ((108, 2000), (1280, 500)):
> +            self.vm.cmd("qom-set", path=adc, property="ain0", value=ch0_mv)
> +            self.vm.cmd("qom-set", path=adc, property="ain1", value=ch1_mv)
> +            self.wait_adc128d818_value("in0_input", ch0_mv)
> +            self.wait_adc128d818_value("in1_input", ch1_mv)
> +
> +        self.assertIn(b"2551", self.read_adc128d818("in0_max"))
> +        self.assertRegex(self.read_adc128d818("in0_min"), rb"(?m)^0\r*$")
> +
> +    def resolve_adc128d818_hwmon(self):
> +        out = self.read_adc128d818_console(
> +            f"basename $(readlink {self.ADC128D818_MUX_CHANNEL})"
> +        )
> +        match = re.search(rb"i2c-(\d+)", out)
> +        self.assertIsNotNone(match, "could not resolve ADC128D818 i2c bus")
> +        bus = int(match.group(1))
> +        return f"/sys/bus/i2c/devices/{bus}-001f/hwmon/hwmon*"
> +
> +    def read_adc128d818_console(self, command):
> +        return exec_command_and_wait_for_pattern(self, command, self.PROMPT)
> +
> +    def read_adc128d818(self, attr):
> +        return self.read_adc128d818_console(f"cat {self.adc_hwmon}/{attr}")
> +
> +    def wait_adc128d818_value(self, attr, expected, timeout=20):

20s ...

> +        needle = str(expected).encode()
> +        deadline = time.monotonic() + timeout
> +        while time.monotonic() < deadline:
> +            if needle in self.read_adc128d818(attr):
> +                return
> +            time.sleep(2)

The first read of hwmon should already trigger a fresh read. If a sleep
is required, which I doubt, please do it once and then assert.

Thanks,

C.

> +        self.fail(f"{attr} did not reach {expected}")
> +
> +
> +if __name__ == "__main__":
>       FacebookAspeedTest.main()
> 


