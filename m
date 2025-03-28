Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3CEB7C28B20
	for <qemu-devel@archiver.kernel.org>; Fri, 28 Mar 2025 07:45:37 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ty4O6-0005xG-Mh; Fri, 28 Mar 2025 03:44:22 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <SRS0=v09i=WP=kaod.org=clg@ozlabs.org>)
 id 1ty4O4-0005wJ-3L; Fri, 28 Mar 2025 03:44:20 -0400
Received: from gandalf.ozlabs.org ([150.107.74.76] helo=mail.ozlabs.org)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <SRS0=v09i=WP=kaod.org=clg@ozlabs.org>)
 id 1ty4O0-0004JC-8h; Fri, 28 Mar 2025 03:44:19 -0400
Received: from mail.ozlabs.org (mail.ozlabs.org [IPv6:2404:9400:2221:ea00::3])
 by gandalf.ozlabs.org (Postfix) with ESMTP id 4ZPCG134v3z4x3d;
 Fri, 28 Mar 2025 18:44:09 +1100 (AEDT)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits))
 (Client did not present a certificate)
 by mail.ozlabs.org (Postfix) with ESMTPSA id 4ZPCFt2TQrz4wcr;
 Fri, 28 Mar 2025 18:44:02 +1100 (AEDT)
Message-ID: <f20a4de2-e231-4fa6-88fc-4dd594d4e03b@kaod.org>
Date: Fri, 28 Mar 2025 08:44:00 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] tests/functional: Remove semicolons at the end of lines
To: Thomas Huth <thuth@redhat.com>
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Steven Lee <steven_lee@aspeedtech.com>, Troy Lee <leetroy@gmail.com>,
 Jamin Lin <jamin_lin@aspeedtech.com>,
 Andrew Jeffery <andrew@codeconstruct.com.au>, Joel Stanley <joel@jms.id.au>,
 Beniamino Galvani <b.galvani@gmail.com>,
 Strahinja Jankovic <strahinja.p.jankovic@gmail.com>,
 Niek Linnenbank <nieklinnenbank@gmail.com>,
 Nina Schoetterl-Glausch <nsg@linux.ibm.com>,
 Halil Pasic <pasic@linux.ibm.com>,
 Christian Borntraeger <borntraeger@linux.ibm.com>,
 Eric Farman <farman@linux.ibm.com>, qemu-arm@nongnu.org,
 qemu-devel@nongnu.org, qemu-s390x@nongnu.org,
 =?UTF-8?Q?Daniel_P_=2E_Berrang=C3=A9?= <berrange@redhat.com>,
 John Snow <jsnow@redhat.com>
References: <20250327201305.996241-1-thuth@redhat.com>
Content-Language: en-US, fr
From: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@kaod.org>
Autocrypt: addr=clg@kaod.org; keydata=
 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
In-Reply-To: <20250327201305.996241-1-thuth@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=150.107.74.76;
 envelope-from=SRS0=v09i=WP=kaod.org=clg@ozlabs.org; helo=mail.ozlabs.org
X-Spam_score_int: -40
X-Spam_score: -4.1
X-Spam_bar: ----
X-Spam_report: (-4.1 / 5.0 requ) BAYES_00=-1.9,
 HEADER_FROM_DIFFERENT_DOMAINS=0.083, RCVD_IN_DNSWL_MED=-2.3,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

On 3/27/25 21:13, Thomas Huth wrote:
> From: Thomas Huth <thuth@redhat.com>
> 
> Yes, we are all C coders who try to write Python code for testing...

nah, we just anticipated rust functional tests :)
  
> but still, let's better avoid semicolons at the end of the lines
> to keep "pylint" happy!
> 
> Signed-off-by: Thomas Huth <thuth@redhat.com>


Reviewed-by: Cédric Le Goater <clg@redhat.com>

Thanks,

C.

> ---
>   tests/functional/aspeed.py                    |  2 +-
>   tests/functional/test_aarch64_aspeed.py       |  2 +-
>   tests/functional/test_arm_aspeed_ast2500.py   |  6 ++--
>   tests/functional/test_arm_aspeed_ast2600.py   | 36 +++++++++----------
>   tests/functional/test_arm_aspeed_bletchley.py |  4 +--
>   tests/functional/test_arm_aspeed_palmetto.py  |  4 +--
>   tests/functional/test_arm_aspeed_romulus.py   |  4 +--
>   .../functional/test_arm_aspeed_witherspoon.py |  4 +--
>   tests/functional/test_arm_bpim2u.py           |  2 +-
>   tests/functional/test_arm_cubieboard.py       |  2 +-
>   tests/functional/test_arm_orangepi.py         |  2 +-
>   tests/functional/test_s390x_topology.py       | 12 +++----
>   12 files changed, 40 insertions(+), 40 deletions(-)
> 
> diff --git a/tests/functional/aspeed.py b/tests/functional/aspeed.py
> index 77dc8930fa4..7a40d5dda73 100644
> --- a/tests/functional/aspeed.py
> +++ b/tests/functional/aspeed.py
> @@ -44,7 +44,7 @@ def do_test_arm_aspeed_buildroot_start(self, image, cpu_id, pattern='Aspeed EVB'
>   
>       def do_test_arm_aspeed_buildroot_poweroff(self):
>           exec_command_and_wait_for_pattern(self, 'poweroff',
> -                                          'System halted');
> +                                          'System halted')
>   
>       def do_test_arm_aspeed_sdk_start(self, image):
>           self.require_netdev('user')
> diff --git a/tests/functional/test_aarch64_aspeed.py b/tests/functional/test_aarch64_aspeed.py
> index c25c9662782..c7f3b3b319f 100755
> --- a/tests/functional/test_aarch64_aspeed.py
> +++ b/tests/functional/test_aarch64_aspeed.py
> @@ -85,7 +85,7 @@ def start_ast2700_test(self, name):
>   
>           exec_command_and_wait_for_pattern(self,
>               'echo lm75 0x4d > /sys/class/i2c-dev/i2c-1/device/new_device ',
> -            'i2c i2c-1: new_device: Instantiated device lm75 at 0x4d');
> +            'i2c i2c-1: new_device: Instantiated device lm75 at 0x4d')
>           exec_command_and_wait_for_pattern(self,
>               'cat /sys/bus/i2c/devices/1-004d/hwmon/hwmon*/temp1_input', '0')
>           self.vm.cmd('qom-set', path='/machine/peripheral/tmp-test',
> diff --git a/tests/functional/test_arm_aspeed_ast2500.py b/tests/functional/test_arm_aspeed_ast2500.py
> index 1ffba6c9953..ddc6459f710 100755
> --- a/tests/functional/test_arm_aspeed_ast2500.py
> +++ b/tests/functional/test_arm_aspeed_ast2500.py
> @@ -22,17 +22,17 @@ def test_arm_ast2500_evb_buildroot(self):
>           image_path = self.ASSET_BR2_202411_AST2500_FLASH.fetch()
>   
>           self.vm.add_args('-device',
> -                         'tmp105,bus=aspeed.i2c.bus.3,address=0x4d,id=tmp-test');
> +                         'tmp105,bus=aspeed.i2c.bus.3,address=0x4d,id=tmp-test')
>           self.do_test_arm_aspeed_buildroot_start(image_path, '0x0',
>                                                   'ast2500-evb login:')
>   
>           exec_command_and_wait_for_pattern(self,
>                'echo lm75 0x4d > /sys/class/i2c-dev/i2c-3/device/new_device',
> -             'i2c i2c-3: new_device: Instantiated device lm75 at 0x4d');
> +             'i2c i2c-3: new_device: Instantiated device lm75 at 0x4d')
>           exec_command_and_wait_for_pattern(self,
>                                'cat /sys/class/hwmon/hwmon1/temp1_input', '0')
>           self.vm.cmd('qom-set', path='/machine/peripheral/tmp-test',
> -                    property='temperature', value=18000);
> +                    property='temperature', value=18000)
>           exec_command_and_wait_for_pattern(self,
>                                'cat /sys/class/hwmon/hwmon1/temp1_input', '18000')
>   
> diff --git a/tests/functional/test_arm_aspeed_ast2600.py b/tests/functional/test_arm_aspeed_ast2600.py
> index 6ae4ed636ac..5ef52f06595 100755
> --- a/tests/functional/test_arm_aspeed_ast2600.py
> +++ b/tests/functional/test_arm_aspeed_ast2600.py
> @@ -27,38 +27,38 @@ def test_arm_ast2600_evb_buildroot(self):
>           image_path = self.ASSET_BR2_202411_AST2600_FLASH.fetch()
>   
>           self.vm.add_args('-device',
> -                         'tmp105,bus=aspeed.i2c.bus.3,address=0x4d,id=tmp-test');
> +                         'tmp105,bus=aspeed.i2c.bus.3,address=0x4d,id=tmp-test')
>           self.vm.add_args('-device',
> -                         'ds1338,bus=aspeed.i2c.bus.3,address=0x32');
> +                         'ds1338,bus=aspeed.i2c.bus.3,address=0x32')
>           self.vm.add_args('-device',
> -                         'i2c-echo,bus=aspeed.i2c.bus.3,address=0x42');
> +                         'i2c-echo,bus=aspeed.i2c.bus.3,address=0x42')
>           self.do_test_arm_aspeed_buildroot_start(image_path, '0xf00',
>                                                   'ast2600-evb login:')
>   
>           exec_command_and_wait_for_pattern(self,
>                'echo lm75 0x4d > /sys/class/i2c-dev/i2c-3/device/new_device',
> -             'i2c i2c-3: new_device: Instantiated device lm75 at 0x4d');
> +             'i2c i2c-3: new_device: Instantiated device lm75 at 0x4d')
>           exec_command_and_wait_for_pattern(self,
>                                'cat /sys/class/hwmon/hwmon1/temp1_input', '0')
>           self.vm.cmd('qom-set', path='/machine/peripheral/tmp-test',
> -                    property='temperature', value=18000);
> +                    property='temperature', value=18000)
>           exec_command_and_wait_for_pattern(self,
>                                'cat /sys/class/hwmon/hwmon1/temp1_input', '18000')
>   
>           exec_command_and_wait_for_pattern(self,
>                'echo ds1307 0x32 > /sys/class/i2c-dev/i2c-3/device/new_device',
> -             'i2c i2c-3: new_device: Instantiated device ds1307 at 0x32');
> +             'i2c i2c-3: new_device: Instantiated device ds1307 at 0x32')
>           year = time.strftime("%Y")
> -        exec_command_and_wait_for_pattern(self, 'hwclock -f /dev/rtc1', year);
> +        exec_command_and_wait_for_pattern(self, 'hwclock -f /dev/rtc1', year)
>   
>           exec_command_and_wait_for_pattern(self,
>                'echo slave-24c02 0x1064 > /sys/bus/i2c/devices/i2c-3/new_device',
> -             'i2c i2c-3: new_device: Instantiated device slave-24c02 at 0x64');
> +             'i2c i2c-3: new_device: Instantiated device slave-24c02 at 0x64')
>           exec_command_and_wait_for_pattern(self,
> -             'i2cset -y 3 0x42 0x64 0x00 0xaa i', '#');
> +             'i2cset -y 3 0x42 0x64 0x00 0xaa i', '#')
>           exec_command_and_wait_for_pattern(self,
>                'hexdump /sys/bus/i2c/devices/3-1064/slave-eeprom',
> -             '0000000 ffaa ffff ffff ffff ffff ffff ffff ffff');
> +             '0000000 ffaa ffff ffff ffff ffff ffff ffff ffff')
>           self.do_test_arm_aspeed_buildroot_poweroff()
>   
>       ASSET_BR2_202302_AST2600_TPM_FLASH = Asset(
> @@ -90,10 +90,10 @@ def test_arm_ast2600_evb_buildroot_tpm(self):
>   
>           exec_command_and_wait_for_pattern(self,
>               'echo tpm_tis_i2c 0x2e > /sys/bus/i2c/devices/i2c-12/new_device',
> -            'tpm_tis_i2c 12-002e: 2.0 TPM (device-id 0x1, rev-id 1)');
> +            'tpm_tis_i2c 12-002e: 2.0 TPM (device-id 0x1, rev-id 1)')
>           exec_command_and_wait_for_pattern(self,
>               'cat /sys/class/tpm/tpm0/pcr-sha256/0',
> -            'B804724EA13F52A9072BA87FE8FDCC497DFC9DF9AA15B9088694639C431688E0');
> +            'B804724EA13F52A9072BA87FE8FDCC497DFC9DF9AA15B9088694639C431688E0')
>   
>           self.do_test_arm_aspeed_buildroot_poweroff()
>   
> @@ -107,9 +107,9 @@ def test_arm_ast2600_evb_sdk(self):
>           self.archive_extract(self.ASSET_SDK_V806_AST2600_A2)
>   
>           self.vm.add_args('-device',
> -            'tmp105,bus=aspeed.i2c.bus.5,address=0x4d,id=tmp-test');
> +            'tmp105,bus=aspeed.i2c.bus.5,address=0x4d,id=tmp-test')
>           self.vm.add_args('-device',
> -            'ds1338,bus=aspeed.i2c.bus.5,address=0x32');
> +            'ds1338,bus=aspeed.i2c.bus.5,address=0x32')
>           self.do_test_arm_aspeed_sdk_start(
>               self.scratch_file("ast2600-a2", "image-bmc"))
>   
> @@ -120,20 +120,20 @@ def test_arm_ast2600_evb_sdk(self):
>   
>           exec_command_and_wait_for_pattern(self,
>               'echo lm75 0x4d > /sys/class/i2c-dev/i2c-5/device/new_device',
> -            'i2c i2c-5: new_device: Instantiated device lm75 at 0x4d');
> +            'i2c i2c-5: new_device: Instantiated device lm75 at 0x4d')
>           exec_command_and_wait_for_pattern(self,
>                'cat /sys/class/hwmon/hwmon19/temp1_input', '0')
>           self.vm.cmd('qom-set', path='/machine/peripheral/tmp-test',
> -                    property='temperature', value=18000);
> +                    property='temperature', value=18000)
>           exec_command_and_wait_for_pattern(self,
>                'cat /sys/class/hwmon/hwmon19/temp1_input', '18000')
>   
>           exec_command_and_wait_for_pattern(self,
>                'echo ds1307 0x32 > /sys/class/i2c-dev/i2c-5/device/new_device',
> -             'i2c i2c-5: new_device: Instantiated device ds1307 at 0x32');
> +             'i2c i2c-5: new_device: Instantiated device ds1307 at 0x32')
>           year = time.strftime("%Y")
>           exec_command_and_wait_for_pattern(self,
> -             '/sbin/hwclock -f /dev/rtc1', year);
> +             '/sbin/hwclock -f /dev/rtc1', year)
>   
>   if __name__ == '__main__':
>       AspeedTest.main()
> diff --git a/tests/functional/test_arm_aspeed_bletchley.py b/tests/functional/test_arm_aspeed_bletchley.py
> index 0da856c5ed4..5a60b24b3d2 100644
> --- a/tests/functional/test_arm_aspeed_bletchley.py
> +++ b/tests/functional/test_arm_aspeed_bletchley.py
> @@ -12,14 +12,14 @@ class BletchleyMachine(AspeedTest):
>   
>       ASSET_BLETCHLEY_FLASH = Asset(
>           'https://github.com/legoater/qemu-aspeed-boot/raw/master/images/bletchley-bmc/openbmc-20250128071329/obmc-phosphor-image-bletchley-20250128071329.static.mtd.xz',
> -        'db21d04d47d7bb2a276f59d308614b4dfb70b9c7c81facbbca40a3977a2d8844');
> +        'db21d04d47d7bb2a276f59d308614b4dfb70b9c7c81facbbca40a3977a2d8844')
>   
>       def test_arm_ast2600_bletchley_openbmc(self):
>           image_path = self.uncompress(self.ASSET_BLETCHLEY_FLASH)
>   
>           self.do_test_arm_aspeed_openbmc('bletchley-bmc', image=image_path,
>                                           uboot='2019.04', cpu_id='0xf00',
> -                                        soc='AST2600 rev A3');
> +                                        soc='AST2600 rev A3')
>   
>   if __name__ == '__main__':
>       AspeedTest.main()
> diff --git a/tests/functional/test_arm_aspeed_palmetto.py b/tests/functional/test_arm_aspeed_palmetto.py
> index 35d832bc98e..ff0b821be65 100755
> --- a/tests/functional/test_arm_aspeed_palmetto.py
> +++ b/tests/functional/test_arm_aspeed_palmetto.py
> @@ -12,14 +12,14 @@ class PalmettoMachine(AspeedTest):
>   
>       ASSET_PALMETTO_FLASH = Asset(
>           'https://github.com/legoater/qemu-aspeed-boot/raw/master/images/palmetto-bmc/openbmc-20250128071432/obmc-phosphor-image-palmetto-20250128071432.static.mtd',
> -        'bce7c392eec75c707a91cfc8fad7ca9a69d7e4f10df936930d65c1cb9897ac81');
> +        'bce7c392eec75c707a91cfc8fad7ca9a69d7e4f10df936930d65c1cb9897ac81')
>   
>       def test_arm_ast2400_palmetto_openbmc(self):
>           image_path = self.ASSET_PALMETTO_FLASH.fetch()
>   
>           self.do_test_arm_aspeed_openbmc('palmetto-bmc', image=image_path,
>                                           uboot='2019.04', cpu_id='0x0',
> -                                        soc='AST2400 rev A1');
> +                                        soc='AST2400 rev A1')
>   
>   if __name__ == '__main__':
>       AspeedTest.main()
> diff --git a/tests/functional/test_arm_aspeed_romulus.py b/tests/functional/test_arm_aspeed_romulus.py
> index b97ed951b1f..0447212bbf0 100755
> --- a/tests/functional/test_arm_aspeed_romulus.py
> +++ b/tests/functional/test_arm_aspeed_romulus.py
> @@ -12,14 +12,14 @@ class RomulusMachine(AspeedTest):
>   
>       ASSET_ROMULUS_FLASH = Asset(
>           'https://github.com/legoater/qemu-aspeed-boot/raw/master/images/romulus-bmc/openbmc-20250128071340/obmc-phosphor-image-romulus-20250128071340.static.mtd',
> -        '6d031376440c82ed9d087d25e9fa76aea75b42f80daa252ec402c0bc3cf6cf5b');
> +        '6d031376440c82ed9d087d25e9fa76aea75b42f80daa252ec402c0bc3cf6cf5b')
>   
>       def test_arm_ast2500_romulus_openbmc(self):
>           image_path = self.ASSET_ROMULUS_FLASH.fetch()
>   
>           self.do_test_arm_aspeed_openbmc('romulus-bmc', image=image_path,
>                                           uboot='2019.04', cpu_id='0x0',
> -                                        soc='AST2500 rev A1');
> +                                        soc='AST2500 rev A1')
>   
>   if __name__ == '__main__':
>       AspeedTest.main()
> diff --git a/tests/functional/test_arm_aspeed_witherspoon.py b/tests/functional/test_arm_aspeed_witherspoon.py
> index ea1ce89b05c..51a2d47af28 100644
> --- a/tests/functional/test_arm_aspeed_witherspoon.py
> +++ b/tests/functional/test_arm_aspeed_witherspoon.py
> @@ -12,14 +12,14 @@ class WitherspoonMachine(AspeedTest):
>   
>       ASSET_WITHERSPOON_FLASH = Asset(
>           'https://github.com/legoater/qemu-aspeed-boot/raw/master/images/witherspoon-bmc/openbmc-20240618035022/obmc-phosphor-image-witherspoon-20240618035022.ubi.mtd',
> -        '937d9ed449ea6c6cbed983519088a42d0cafe276bcfe4fce07772ca6673f9213');
> +        '937d9ed449ea6c6cbed983519088a42d0cafe276bcfe4fce07772ca6673f9213')
>   
>       def test_arm_ast2500_witherspoon_openbmc(self):
>           image_path = self.ASSET_WITHERSPOON_FLASH.fetch()
>   
>           self.do_test_arm_aspeed_openbmc('witherspoon-bmc', image=image_path,
>                                           uboot='2016.07', cpu_id='0x0',
> -                                        soc='AST2500 rev A1');
> +                                        soc='AST2500 rev A1')
>   
>   if __name__ == '__main__':
>       AspeedTest.main()
> diff --git a/tests/functional/test_arm_bpim2u.py b/tests/functional/test_arm_bpim2u.py
> index 8de6ccba881..8bed64b702f 100755
> --- a/tests/functional/test_arm_bpim2u.py
> +++ b/tests/functional/test_arm_bpim2u.py
> @@ -163,7 +163,7 @@ def test_arm_bpim2u_openwrt_22_03_3(self):
>                   self, 'Hit any key to stop autoboot:', '=>')
>           exec_command_and_wait_for_pattern(self, "setenv extraargs '" +
>                                                   kernel_command_line + "'", '=>')
> -        exec_command_and_wait_for_pattern(self, 'boot', 'Starting kernel ...');
> +        exec_command_and_wait_for_pattern(self, 'boot', 'Starting kernel ...')
>   
>           self.wait_for_console_pattern(
>               'Please press Enter to activate this console.')
> diff --git a/tests/functional/test_arm_cubieboard.py b/tests/functional/test_arm_cubieboard.py
> index b87a28154da..1eaca0272bb 100755
> --- a/tests/functional/test_arm_cubieboard.py
> +++ b/tests/functional/test_arm_cubieboard.py
> @@ -128,7 +128,7 @@ def test_arm_cubieboard_openwrt_22_03_2(self):
>                   self, 'Hit any key to stop autoboot:', '=>')
>           exec_command_and_wait_for_pattern(self, "setenv extraargs '" +
>                                                   kernel_command_line + "'", '=>')
> -        exec_command_and_wait_for_pattern(self, 'boot', 'Starting kernel ...');
> +        exec_command_and_wait_for_pattern(self, 'boot', 'Starting kernel ...')
>   
>           self.wait_for_console_pattern(
>               'Please press Enter to activate this console.')
> diff --git a/tests/functional/test_arm_orangepi.py b/tests/functional/test_arm_orangepi.py
> index 1815f56e027..f9bfa8c78d9 100755
> --- a/tests/functional/test_arm_orangepi.py
> +++ b/tests/functional/test_arm_orangepi.py
> @@ -174,7 +174,7 @@ def test_arm_orangepi_armbian(self):
>           exec_command_and_wait_for_pattern(self, ' ', '=>')
>           exec_command_and_wait_for_pattern(self, "setenv extraargs '" +
>                                                   kernel_command_line + "'", '=>')
> -        exec_command_and_wait_for_pattern(self, 'boot', 'Starting kernel ...');
> +        exec_command_and_wait_for_pattern(self, 'boot', 'Starting kernel ...')
>   
>           self.wait_for_console_pattern('systemd[1]: Hostname set ' +
>                                         'to <orangepipc>')
> diff --git a/tests/functional/test_s390x_topology.py b/tests/functional/test_s390x_topology.py
> index eefd9729cb2..1b5dc651353 100755
> --- a/tests/functional/test_s390x_topology.py
> +++ b/tests/functional/test_s390x_topology.py
> @@ -217,12 +217,12 @@ def test_polarization(self):
>           self.assertEqual(res['return']['polarization'], 'horizontal')
>           self.check_topology(0, 0, 0, 0, 'medium', False)
>   
> -        self.guest_set_dispatching('1');
> +        self.guest_set_dispatching('1')
>           res = self.vm.qmp('query-s390x-cpu-polarization')
>           self.assertEqual(res['return']['polarization'], 'vertical')
>           self.check_topology(0, 0, 0, 0, 'medium', False)
>   
> -        self.guest_set_dispatching('0');
> +        self.guest_set_dispatching('0')
>           res = self.vm.qmp('query-s390x-cpu-polarization')
>           self.assertEqual(res['return']['polarization'], 'horizontal')
>           self.check_topology(0, 0, 0, 0, 'medium', False)
> @@ -283,7 +283,7 @@ def test_entitlement(self):
>           self.check_polarization('vertical:high')
>           self.check_topology(0, 0, 0, 0, 'high', False)
>   
> -        self.guest_set_dispatching('0');
> +        self.guest_set_dispatching('0')
>           self.check_polarization("horizontal")
>           self.check_topology(0, 0, 0, 0, 'high', False)
>   
> @@ -310,11 +310,11 @@ def test_dedicated(self):
>           self.check_topology(0, 0, 0, 0, 'high', True)
>           self.check_polarization("horizontal")
>   
> -        self.guest_set_dispatching('1');
> +        self.guest_set_dispatching('1')
>           self.check_topology(0, 0, 0, 0, 'high', True)
>           self.check_polarization("vertical:high")
>   
> -        self.guest_set_dispatching('0');
> +        self.guest_set_dispatching('0')
>           self.check_topology(0, 0, 0, 0, 'high', True)
>           self.check_polarization("horizontal")
>   
> @@ -360,7 +360,7 @@ def test_dedicated_error(self):
>   
>           self.check_topology(0, 0, 0, 0, 'high', True)
>   
> -        self.guest_set_dispatching('1');
> +        self.guest_set_dispatching('1')
>   
>           self.check_topology(0, 0, 0, 0, 'high', True)
>   


