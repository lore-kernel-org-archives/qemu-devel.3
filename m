Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2B803CD98F2
	for <qemu-devel@archiver.kernel.org>; Thu, 18 Jun 2026 06:39:05 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wa6OG-0001Bd-Ru; Thu, 18 Jun 2026 02:38:16 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@kaod.org>)
 id 1wa6OE-0001Aa-K2; Thu, 18 Jun 2026 02:38:14 -0400
Received: from smtpout2.mo537.mail-out.ovh.net ([51.210.91.21])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@kaod.org>)
 id 1wa6OA-0008Dw-RK; Thu, 18 Jun 2026 02:38:13 -0400
Received: from director3.derp.mail-out.ovh.net
 (director3.derp.mail-out.ovh.net [152.228.215.222])
 by mo537.mail-out.ovh.net (Postfix) with ESMTPS id 4ggrdL30Tjz3yV4;
 Thu, 18 Jun 2026 06:37:58 +0000 (UTC)
Received: from director3.derp.mail-out.ovh.net
 (director3.derp.mail-out.ovh.net. [127.0.0.1])
 by director3.derp.mail-out.ovh.net (inspect_sender_mail_agent) with SMTP
 for <alexander.hansen@9elements.com>; Thu, 18 Jun 2026 06:37:58 +0000 (UTC)
Received: from mta7.priv.ovhmail-u2.ea.mail.ovh.net (unknown [10.110.43.33])
 by director3.derp.mail-out.ovh.net (Postfix) with ESMTPS id 4ggrdL1mN7z5vbq;
 Thu, 18 Jun 2026 06:37:58 +0000 (UTC)
Received: from kaod.org (unknown [10.1.6.4])
 (Authenticated sender: clg@kaod.org)
 by mta7.priv.ovhmail-u2.ea.mail.ovh.net (Postfix) with ESMTPSA id 21D622034A7; 
 Thu, 18 Jun 2026 06:37:56 +0000 (UTC)
Authentication-Results: garm.ovh; auth=pass
 (GARM-111S0053c474989-3c2b-4f79-a5c5-fdbc970d24f2,
 A2996BA223552B7951DE2AB9C59D4C10FAA35807) smtp.auth=clg@kaod.org
X-OVh-ClientIp: 82.64.250.170
Message-ID: <af558d78-d1f4-4ce8-930d-20bda67a5d09@kaod.org>
Date: Thu, 18 Jun 2026 08:37:55 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 4/4] test/functional: anacapa: test ADC128D818
To: Emmanuel Blot <eblot@meta.com>, qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@mailo.com>,
 Fabiano Rosas <farosas@suse.de>, Laurent Vivier <lvivier@redhat.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 Steven Lee <steven_lee@aspeedtech.com>, Troy Lee <leetroy@gmail.com>,
 Jamin Lin <jamin_lin@aspeedtech.com>, Kane Chen <kane_chen@aspeedtech.com>,
 Andrew Jeffery <andrew@codeconstruct.com.au>, Joel Stanley <joel@jms.id.au>,
 Alexander Hansen <alexander.hansen@9elements.com>,
 William de Abreu Pinho <williampinho@meta.com>, qemu-arm@nongnu.org
References: <20260617-i2c-adc128d818-anacapa-v2-0-fd38764f0465@meta.com>
 <20260617-i2c-adc128d818-anacapa-v2-4-fd38764f0465@meta.com>
Content-Language: en-US, fr
From: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@kaod.org>
Autocrypt: addr=clg@kaod.org; keydata=
 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
In-Reply-To: <20260617-i2c-adc128d818-anacapa-v2-4-fd38764f0465@meta.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
x-ovh-tracer-id: 10540111980452031533
X-VR-SPAMSTATE: OK
X-VR-SPAMSCORE: -100
X-VR-SPAMCAUSE: dmFkZTFn6e50n+QTTHnL26ZpHAhHWoZfADHV55MlwECKXYZoJtT3Qeij8HpbOzJ1TZRqgkuvRm7qRxpEQo3hzcLyO3XhTNSSoKabztssSiURkLYZvIzUYvoHPTIhKcvxo0gEm8M5fh93rWjJtl62feNnhBvhA2cElNK0GjtDXl1E0Xo5+JfmrEWXDr7OYVP/+MJp5tYdEDy2nYQj5y8pd6FOYy92eq1D2VpNZYObQQ3IvVKJQDUUpvw/zJSw1vRrYvnBg7dOGA+NCNDh5jxKETzQ+it32uTFGg859q6yG9E27wVvA9AH8cOS0Na/gEz8e1i/Cg1r4mjNrmivYZpR+NXBbnlENDlyfj1LU7GQCYiQGBrIPRSczQdfcAE4tt+yqSN0mIaoRKwKSwEiGH0Bl/nFduJ6fKbf4erCqT6eog/OGtEylo4VFbm4r1FYR/J9E+01Uv93zZJGSU5ApV7no53p2ibMpC3QIqnnPFcibxA2UfDkJHcLS+n/vx2SxGdhSqIcizAvYnsiuGRJiq6+iVab+e71dW9an/F9ycmV6QvJPsDbF+FxEmrGygYr6BgKlm44nrfVfIaaI3UojyjzEQSBuimTmq+N4+3JsMOvrywSNQ4hLL2f7MUdSckBOakm3oi43hllRcYfiGYGBEEr2FhBK6IcPYFZzv7zBn8vzYthPTC3bA
DKIM-Signature: a=rsa-sha256; bh=roceGX//SfcJZVtu/t89sVtu4bgMPZzsOQyHajW1jWQ=; 
 c=relaxed/relaxed; d=kaod.org; h=From; s=ovhmo393970-selector1;
 t=1781764678; v=1;
 b=BYJWnkH7NC4rmyJiSa+f33KdchQhHdvqWdZTIlm0/xCD29qou3J172xxGJuj0zd9SdWrPZj7
 0jwtaDeakx6u6p7Ph3oxxWerinh9QOX0CgNLYTAtJ6zAM7cphquXwLhHjvq1LGvHSRV/YqcRB4y
 b4sUG1xYhT7zu2fOnCPK9Cu6WAytxO4AtJWwYvviQ+i04Y9g8BGxETm6fs9rWXoIkB2pQNdw6y4
 hmEcNNf/jrxIq8Ljr10claZ0S0U8VbwNx6DhBV+aTwNFWjs72FNlG9xG8u6MmBoCXfC5bKen2lQ
 d1JDVh/oeBh4W5xEhc29LyAqRzmYbbx9mIec9FKah0tDw==
Received-SPF: pass client-ip=51.210.91.21; envelope-from=clg@kaod.org;
 helo=smtpout2.mo537.mail-out.ovh.net
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

On 6/17/26 12:26, Emmanuel Blot wrote:
> Verify the ADC128D818 on the Anacapa R-PDB (i2c8 mux channel 0): two
> channels are driven with distinct voltages and each is checked to be
> reported back independently through the kernel hwmon interface, and the
> channel 0 limit registers are validated.
> 
> Signed-off-by: Emmanuel Blot <eblot@meta.com>
> ---
>   tests/functional/arm/test_aspeed_anacapa.py | 92 +++++++++++++++++++++++++++--
>   1 file changed, 86 insertions(+), 6 deletions(-)
> 
> diff --git a/tests/functional/arm/test_aspeed_anacapa.py b/tests/functional/arm/test_aspeed_anacapa.py
> index 27f8bd8b56..003d6dfb17 100644
> --- a/tests/functional/arm/test_aspeed_anacapa.py
> +++ b/tests/functional/arm/test_aspeed_anacapa.py
> @@ -4,22 +4,102 @@
>   #
>   # SPDX-License-Identifier: GPL-2.0-or-later
>   
> +import re
> +import time
> +
>   from qemu_test import Asset
> +from qemu_test import exec_command
> +from qemu_test import exec_command_and_wait_for_pattern
> +from qemu_test import wait_for_console_pattern
>   from aspeed import FacebookAspeedTest
>   
>   
>   class AnacapaMachine(FacebookAspeedTest):
>   
>       ASSET_ANACAPA_FLASH = Asset(
> -        'https://github.com/legoater/qemu-aspeed-boot/raw/3fa3212827b04be4034d43b5adeef57c27d6ab18/images/anacapa-bmc/openbmc-20260512025228/obmc-phosphor-image-anacapa-20260512025228.static.mtd.xz',
> -        '2232e241abcfb6d4f6b82cb6c378ce5ce05e364aac6d118785c2b6cc33fe43f3')
> +        "https://github.com/legoater/qemu-aspeed-boot/raw/3fa3212827b04be4034d43b5adeef57c27d6ab18/images/anacapa-bmc/openbmc-20260512025228/obmc-phosphor-image-anacapa-20260512025228.static.mtd.xz",
> +        "2232e241abcfb6d4f6b82cb6c378ce5ce05e364aac6d118785c2b6cc33fe43f3",
> +    )
> +
> +    # ADC128D818 on i2c8 mux (PCA9546 @0x72) channel 0, address 0x1f.
> +    ADC128D818_HWMON = "/sys/bus/i2c/devices/*-001f/hwmon/hwmon*"
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

These look like unnecessary changes

> -if __name__ == '__main__':
> +        # perform login
> +        exec_command_and_wait_for_pattern(self, "root", "Password:")
> +        exec_command_and_wait_for_pattern(self, "0penBmc", "#")
> +
> +        # ADC128D818 test
> +        #
> +        # The current Anacapa OpenBMC device tree is the AST2600 EVB one, and
> +        # therefore does not declare the i2c8 mux nor the ADC128D818 behind it,
> +        # so bind the emulated PCA9546 (@0x72) and then the ADC128D818 (@0x1f,
> +        # mux channel 0) from userspace before probing.
> +        # This should not longer be useful once the Anacapa DT is updated.

Is it the case now with :

   https://github.com/legoater/qemu-aspeed-boot/pull/7
   https://github.com/legoater/qemu-aspeed-boot/raw/refs/heads/master/images/anacapa-bmc/openbmc-20260616025349/obmc-phosphor-image-anacapa-20260616025349.static.mtd.xz

?

> +        exec_command_and_wait_for_pattern(
> +            self,
> +            "echo pca9546 0x72 > /sys/bus/i2c/devices/i2c-8/new_device",
> +            "root@anacapa",
> +        )
> +        exec_command_and_wait_for_pattern(
> +            self,
> +            "bus=$(basename $(readlink /sys/bus/i2c/devices/8-0072/channel-0)); "
> +            "echo adc128d818 0x1f > /sys/bus/i2c/devices/$bus/new_device",
> +            "root@anacapa",
> +        )
> +        exec_command_and_wait_for_pattern(
> +            self, f"cat {self.ADC128D818_HWMON}/name", "adc128d818"
> +        )
> +
> +        adc = self.find_adc128d818_qom_path()
> +        for ch0_mv, ch1_mv in ((108, 2000), (1280, 500)):
> +            self.vm.cmd("qom-set", path=adc, property="ain0", value=ch0_mv)
> +            self.vm.cmd("qom-set", path=adc, property="ain1", value=ch1_mv)
> +            self.wait_adc128d818_value("in0_input", ch0_mv)
> +            self.wait_adc128d818_value("in1_input", ch1_mv)
> +
> +        self.assertEqual(self.read_adc128d818_value("in0_min"), 0)
> +        self.assertEqual(self.read_adc128d818_value("in0_max"), 2551)
> +
> +    def find_adc128d818_qom_path(self):
> +        unattached = "/machine/unattached"
> +        devices = [
> +            child["name"]
> +            for child in self.vm.cmd("qom-list", path=unattached)
> +            if "adc128d818" in child["type"]
> +        ]
> +        devices.sort(key=lambda name: int(name[len("device[") : -1]))
> +        return f"{unattached}/{devices[0]}"

This will return the first adc128d818 device. I guess that's fine.

The issue is that i2c devices created with i2c_slave_create_simple()
have no QOM parent and are placed under "unattached", which makes
them difficult to locate.

May be something like below parenting the device to the I2C bus
would help ?

in hw/i2c/core.c :

@@ -381,6 +382,9 @@ bool i2c_slave_realize_and_unref(I2CSlav
  I2CSlave *i2c_slave_create_simple(I2CBus *bus, const char *name, uint8_t addr)
  {
      I2CSlave *dev = i2c_slave_new(name, addr);
+    g_autofree char *childname = g_strdup_printf("0x%02x", addr);
+
+    object_property_add_child(OBJECT(bus), childname, OBJECT(dev));
  
      i2c_slave_realize_and_unref(dev, bus, &error_abort);
  

> +
> +    def read_adc128d818_value(self, attr):
> +        # split the marker via $m so it only appears in the output, not echo
> +        path = f"{self.ADC128D818_HWMON}/{attr}"
> +        exec_command(self, f'm=END; cat {path}; echo "ADC$m"')
> +        out = wait_for_console_pattern(self, "ADCEND")
> +        match = re.search(rb"(-?\d+)\s+ADCEND", out)
> +        self.assertIsNotNone(match, f"could not read {attr}")
> +        return int(match.group(1))
> +
> +    def wait_adc128d818_value(self, attr, expected, timeout=20):
> +        deadline = time.monotonic() + timeout
> +        value = None
> +        while time.monotonic() < deadline:
> +            value = self.read_adc128d818_value(attr)
> +            if value == expected:
> +                return
> +            time.sleep(2)
> +        self.fail(f"{attr} did not reach {expected} (last read {value})")

This looks overly complex for a 'qom-set' followed by a
'cat /sys/class/hwmon/hwmon1/...'

Why don't you do something like test_aspeed_ast2500_buildroot.py ?

Thanks,

C.

> +
> +if __name__ == "__main__":
>       FacebookAspeedTest.main()
> 


