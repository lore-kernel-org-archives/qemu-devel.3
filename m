Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 589AECCA476
	for <qemu-devel@archiver.kernel.org>; Tue,  7 Oct 2025 07:57:01 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v62YT-0001if-5e; Tue, 07 Oct 2025 03:56:17 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1v62YR-0001hJ-BS
 for qemu-devel@nongnu.org; Tue, 07 Oct 2025 03:56:15 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1v62YO-00084G-He
 for qemu-devel@nongnu.org; Tue, 07 Oct 2025 03:56:15 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1759823771;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=0o2RNBCLlf17vuCId3pPw+3los7yYP8fRyh6lWUrdAM=;
 b=MxkcarYokO/Nli/9LZj2bRVnkPaLXhuNHSXkITcA3sXEPjB3H/8eF+Bwg0FVOMqLyqEe9T
 UbeVSBSlOHJfFFCQs5AyxwN4iDjycNgfQn4/TOhLIW084E7OSEZ28vAUUMV7C93hf8niFi
 IIpTShYAzp2Taa1sLKfWflfj6Y+VCdc=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-26-nCw8PjpkPySnwYdYb9kzUw-1; Tue, 07 Oct 2025 03:56:09 -0400
X-MC-Unique: nCw8PjpkPySnwYdYb9kzUw-1
X-Mimecast-MFC-AGG-ID: nCw8PjpkPySnwYdYb9kzUw_1759823768
Received: by mail-wm1-f69.google.com with SMTP id
 5b1f17b1804b1-46e4cb3e4deso16737085e9.1
 for <qemu-devel@nongnu.org>; Tue, 07 Oct 2025 00:56:09 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1759823768; x=1760428568;
 h=content-transfer-encoding:in-reply-to:autocrypt:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=0o2RNBCLlf17vuCId3pPw+3los7yYP8fRyh6lWUrdAM=;
 b=ebRZ7dvdzr2ZvDLEaQ01LB8ymj9/rJujALekBkQPgu09+ooMplj4S55eSBXn/IHcAy
 TZxLrE11BMf+SnzBb3s/h55ZeaVKlr7PRPpMiODovjvgm/2v9bV7YSGgYJb0R9BoxOiW
 2MBaN5ZkuijKM8a+SR89UhUX7bDs3+zRdSaEyH1FgThEBrZxi9lEnolZzHf6CNs+3q8q
 XT6DQU6kkU3Xv+BfhSUWNo1dNTg9TpQ3YXpiYRiff61G3VQYJBnXbg4TlMrmQrQuy807
 awGKW1YtnKziP4DGEJ+KdUmbhEgS+3P2Y6JnRipGGVSUQlbCeR1OGNPYbfh2bPdpz8pU
 qMqg==
X-Forwarded-Encrypted: i=1;
 AJvYcCWTGcgEhQABQKJLCrwp4N6SMJVJ1Wl342nfYXfIxyvyXdFeUzKJKmHtVr3CYfKQHaWpjR5BW+KqZbZx@nongnu.org
X-Gm-Message-State: AOJu0Yz1eQMfESGE9WsW7cD9Ay6Fkfr0Qpz9BS9tjw/PYW+mxMS0P95x
 LekSdG730q3S22ibCYe9j3mwFTKuMdoJAeCRXD1Ma6q7a/2kDWjqMC7dLosIlNQm4w32V0BWVvm
 7fwGJEQlEwLmRX9IXRFdfnd/691ifDRt3Vzzw33cx/9JUne5Zeqpbhz0O
X-Gm-Gg: ASbGncu+hrauKJeayK1lw/K8qVSpZ90jdTP6vClRJ7iAc3KHI3kfhdxbV5wuRox3EEk
 bYNgW9+4yr4oyqvVzk7yPt/WKRNm92+ALdW194L6uR+YJDhFRXJ0ZaSH+RKCizzFHIAJkEZsQBd
 RiMlLCzx+A/pcKzeQtDtml0asjtzbMv0R++BNUkpmuA/xcdim2tFzfFQ5Zn/QsW50Fe6jBmPQJl
 8j4LuvRwJN3piRMEUGy5yI1HOvJeCKgemer11aa4rg4PYKqKjtM0iogjd3aQstYRyPP2w/NSmu5
 ZFVwEJ6wIj12mqSAejIbyAc6F5GeSmJivjiJ5Us70ILgzF9uaf8VtwnADlNyPt7s6Dx7oaQ=
X-Received: by 2002:a05:600c:83cf:b0:46e:5302:7751 with SMTP id
 5b1f17b1804b1-46fa29aa731mr15499625e9.9.1759823768146; 
 Tue, 07 Oct 2025 00:56:08 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFTSbyqAZKzeWKWXzNQ/8N9uwEViXRgYejX7EDgtUUZIJTUIJk/NyWoT4qcvhVf+JPn1PbFrQ==
X-Received: by 2002:a05:600c:83cf:b0:46e:5302:7751 with SMTP id
 5b1f17b1804b1-46fa29aa731mr15499435e9.9.1759823767714; 
 Tue, 07 Oct 2025 00:56:07 -0700 (PDT)
Received: from [10.33.192.176] (nat-pool-str-t.redhat.com. [149.14.88.106])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-46e78c5d290sm153134895e9.0.2025.10.07.00.56.06
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 07 Oct 2025 00:56:07 -0700 (PDT)
Message-ID: <7908cb21-785f-48ba-899d-d02fb8bb73b6@redhat.com>
Date: Tue, 7 Oct 2025 09:56:06 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] test/functional/arm: Split the ast2600 tests in two files
To: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@redhat.com>,
 qemu-devel@nongnu.org, qemu-arm@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Steven Lee <steven_lee@aspeedtech.com>, Troy Lee <leetroy@gmail.com>,
 Jamin Lin <jamin_lin@aspeedtech.com>,
 Andrew Jeffery <andrew@codeconstruct.com.au>, Joel Stanley <joel@jms.id.au>
References: <20251006173451.528310-1-clg@redhat.com>
From: Thomas Huth <thuth@redhat.com>
Content-Language: en-US
Autocrypt: addr=thuth@redhat.com; keydata=
 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
In-Reply-To: <20251006173451.528310-1-clg@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=thuth@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.441,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
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

On 06/10/2025 19.34, Cédric Le Goater wrote:
> The ast2600 test file currently includes tests for both the Buildroot
> and SDK images. Since the SDK image tests can take long to run, split
> them into a separate file to clearly distinguish the two sets of
> tests, improve parallelism and allow for different CI timeouts.
> 
> Signed-off-by: Cédric Le Goater <clg@redhat.com>
> ---
>   tests/functional/arm/meson.build              |  6 +-
>   ...00.py => test_aspeed_ast2600_buildroot.py} | 74 --------------
>   .../functional/arm/test_aspeed_ast2600_sdk.py | 96 +++++++++++++++++++
>   3 files changed, 100 insertions(+), 76 deletions(-)
>   rename tests/functional/arm/{test_aspeed_ast2600.py => test_aspeed_ast2600_buildroot.py} (57%)
>   create mode 100755 tests/functional/arm/test_aspeed_ast2600_sdk.py
> 
> diff --git a/tests/functional/arm/meson.build b/tests/functional/arm/meson.build
> index e4e7dba8d087..d1ed076a6aa8 100644
> --- a/tests/functional/arm/meson.build
> +++ b/tests/functional/arm/meson.build
> @@ -5,7 +5,8 @@ test_arm_timeouts = {
>     'aspeed_romulus' : 120,
>     'aspeed_witherspoon' : 120,
>     'aspeed_ast2500' : 720,
> -  'aspeed_ast2600' : 1200,
> +  'aspeed_ast2600_buildroot' : 720,
> +  'aspeed_ast2600_sdk' : 1200,
>     'aspeed_bletchley' : 480,
>     'aspeed_catalina' : 480,
>     'aspeed_gb200nvl_bmc' : 480,
> @@ -31,7 +32,8 @@ tests_arm_system_thorough = [
>     'aspeed_romulus',
>     'aspeed_witherspoon',
>     'aspeed_ast2500',
> -  'aspeed_ast2600',
> +  'aspeed_ast2600_buildroot',
> +  'aspeed_ast2600_sdk',
>     'aspeed_bletchley',
>     'aspeed_catalina',
>     'aspeed_gb200nvl_bmc',
> diff --git a/tests/functional/arm/test_aspeed_ast2600.py b/tests/functional/arm/test_aspeed_ast2600_buildroot.py
> similarity index 57%
> rename from tests/functional/arm/test_aspeed_ast2600.py
> rename to tests/functional/arm/test_aspeed_ast2600_buildroot.py
> index 0127913cfb65..51f2676c9061 100755
> --- a/tests/functional/arm/test_aspeed_ast2600.py
> +++ b/tests/functional/arm/test_aspeed_ast2600_buildroot.py
> @@ -97,80 +97,6 @@ def test_arm_ast2600_evb_buildroot_tpm(self):
>   
>           self.do_test_arm_aspeed_buildroot_poweroff()
>   
> -    ASSET_SDK_V908_AST2600 = Asset(
> -        'https://github.com/AspeedTech-BMC/openbmc/releases/download/v09.08/ast2600-default-obmc.tar.gz',
> -        'a0414f14ad696550efe083c2156dbeda855c08cc9ae7f40fe1b41bf292295f82')
> -
> -    def do_ast2600_pcie_test(self):
> -        exec_command_and_wait_for_pattern(self,
> -            'lspci -s 80:00.0',
> -            '80:00.0 Host bridge: '
> -            'ASPEED Technology, Inc. Device 2600')
> -        exec_command_and_wait_for_pattern(self,
> -            'lspci -s 80:08.0',
> -            '80:08.0 PCI bridge: '
> -            'ASPEED Technology, Inc. AST1150 PCI-to-PCI Bridge')
> -        exec_command_and_wait_for_pattern(self,
> -            'lspci -s 81:00.0',
> -            '81:00.0 Ethernet controller: '
> -            'Intel Corporation 82574L Gigabit Network Connection')
> -        exec_command_and_wait_for_pattern(self,
> -            'ip addr show dev eth4',
> -            'inet 10.0.2.15/24')
> -
> -    def test_arm_ast2600_evb_sdk(self):
> -        self.set_machine('ast2600-evb')
> -        self.require_netdev('user')
> -
> -        self.archive_extract(self.ASSET_SDK_V908_AST2600)
> -
> -        self.vm.add_args('-device',
> -            'tmp105,bus=aspeed.i2c.bus.5,address=0x4d,id=tmp-test')
> -        self.vm.add_args('-device',
> -            'ds1338,bus=aspeed.i2c.bus.5,address=0x32')
> -        self.vm.add_args('-device', 'e1000e,netdev=net1,bus=pcie.0')
> -        self.vm.add_args('-netdev', 'user,id=net1')
> -        self.do_test_arm_aspeed_sdk_start(
> -            self.scratch_file("ast2600-default", "image-bmc"))
> -
> -        self.wait_for_console_pattern('ast2600-default login:')
> -
> -        exec_command_and_wait_for_pattern(self, 'root', 'Password:')
> -        exec_command_and_wait_for_pattern(self, '0penBmc',
> -                                          'root@ast2600-default:~#')
> -
> -        exec_command_and_wait_for_pattern(self,
> -            'echo lm75 0x4d > /sys/class/i2c-dev/i2c-5/device/new_device',
> -            'i2c i2c-5: new_device: Instantiated device lm75 at 0x4d')
> -        exec_command_and_wait_for_pattern(self,
> -             'cat /sys/class/hwmon/hwmon19/temp1_input', '0')
> -        self.vm.cmd('qom-set', path='/machine/peripheral/tmp-test',
> -                    property='temperature', value=18000)
> -        exec_command_and_wait_for_pattern(self,
> -             'cat /sys/class/hwmon/hwmon19/temp1_input', '18000')
> -
> -        exec_command_and_wait_for_pattern(self,
> -             'echo ds1307 0x32 > /sys/class/i2c-dev/i2c-5/device/new_device',
> -             'i2c i2c-5: new_device: Instantiated device ds1307 at 0x32')
> -        year = time.strftime("%Y")
> -        exec_command_and_wait_for_pattern(self,
> -             '/sbin/hwclock -f /dev/rtc1', year)
> -        self.do_ast2600_pcie_test()
> -
> -    def test_arm_ast2600_otp_blockdev_device(self):
> -        self.vm.set_machine("ast2600-evb")
> -
> -        image_path = self.archive_extract(self.ASSET_SDK_V908_AST2600)
> -        otp_img = self.generate_otpmem_image()
> -
> -        self.vm.set_console()
> -        self.vm.add_args(
> -            "-blockdev", f"driver=file,filename={otp_img},node-name=otp",
> -            "-global", "aspeed-otp.drive=otp",
> -        )
> -        self.do_test_arm_aspeed_sdk_start(
> -            self.scratch_file("ast2600-default", "image-bmc"))
> -        self.wait_for_console_pattern("ast2600-default login:")
>   
>   if __name__ == '__main__':
>       AspeedTest.main()
> diff --git a/tests/functional/arm/test_aspeed_ast2600_sdk.py b/tests/functional/arm/test_aspeed_ast2600_sdk.py
> new file mode 100755
> index 000000000000..735a20b8df0e
> --- /dev/null
> +++ b/tests/functional/arm/test_aspeed_ast2600_sdk.py
> @@ -0,0 +1,96 @@
> +#!/usr/bin/env python3
> +#
> +# Functional test that boots the ASPEED machines
> +#
> +# SPDX-License-Identifier: GPL-2.0-or-later
> +
> +import os
> +import time
> +import tempfile
> +import subprocess
> +
> +from qemu_test import Asset
> +from aspeed import AspeedTest
> +from qemu_test import exec_command_and_wait_for_pattern, skipIfMissingCommands

Nit: Please drop the import of tempfile, subprocess, skipIfMissingCommands 
and os in the new sdk file.

  Thanks,
   Thomas


