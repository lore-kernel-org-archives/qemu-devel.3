Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 87EAAC2BD09
	for <qemu-devel@archiver.kernel.org>; Wed,  3 Jul 2024 09:19:33 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sOw8e-0005Rm-ES; Wed, 03 Jul 2024 05:18:56 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <SRS0=dfZQ=OD=kaod.org=clg@ozlabs.org>)
 id 1sOw8b-0005QY-Bh; Wed, 03 Jul 2024 05:18:53 -0400
Received: from mail.ozlabs.org ([2404:9400:2221:ea00::3])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <SRS0=dfZQ=OD=kaod.org=clg@ozlabs.org>)
 id 1sOw8Z-0008US-6Y; Wed, 03 Jul 2024 05:18:53 -0400
Received: from mail.ozlabs.org (mail.ozlabs.org [IPv6:2404:9400:2221:ea00::3])
 by gandalf.ozlabs.org (Postfix) with ESMTP id 4WDZ2s1c1mz4x0w;
 Wed,  3 Jul 2024 19:18:45 +1000 (AEST)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by mail.ozlabs.org (Postfix) with ESMTPSA id 4WDZ2k5gFzz4wxs;
 Wed,  3 Jul 2024 19:18:19 +1000 (AEST)
Message-ID: <153d7e87-28d6-403c-9d84-786c52cd6acb@kaod.org>
Date: Wed, 3 Jul 2024 11:18:16 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 5/5] test/avocado/machine_aspeed.py: update to test
 network for AST2700
To: Jamin Lin <jamin_lin@aspeedtech.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 Steven Lee <steven_lee@aspeedtech.com>, Troy Lee <leetroy@gmail.com>,
 Andrew Jeffery <andrew@codeconstruct.com.au>, Joel Stanley <joel@jms.id.au>,
 Alistair Francis <alistair@alistair23.me>, Kevin Wolf <kwolf@redhat.com>,
 Hanna Reitz <hreitz@redhat.com>, Jason Wang <jasowang@redhat.com>,
 Cleber Rosa <crosa@redhat.com>, =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?=
 <philmd@linaro.org>, Wainer dos Santos Moschetta <wainersm@redhat.com>,
 Beraldo Leal <bleal@redhat.com>, "open list:ASPEED BMCs"
 <qemu-arm@nongnu.org>, "open list:All patches CC here"
 <qemu-devel@nongnu.org>, "open list:Block layer core" <qemu-block@nongnu.org>
Cc: troy_lee@aspeedtech.com, yunlin.tang@aspeedtech.com
References: <20240703081623.2740862-1-jamin_lin@aspeedtech.com>
 <20240703081623.2740862-6-jamin_lin@aspeedtech.com>
Content-Language: en-US, fr
From: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@kaod.org>
In-Reply-To: <20240703081623.2740862-6-jamin_lin@aspeedtech.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2404:9400:2221:ea00::3;
 envelope-from=SRS0=dfZQ=OD=kaod.org=clg@ozlabs.org; helo=mail.ozlabs.org
X-Spam_score_int: -41
X-Spam_score: -4.2
X-Spam_bar: ----
X-Spam_report: (-4.2 / 5.0 requ) BAYES_00=-1.9,
 HEADER_FROM_DIFFERENT_DOMAINS=0.001, RCVD_IN_DNSWL_MED=-2.3,
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

On 7/3/24 10:16 AM, Jamin Lin wrote:
> Update a test case to test network connection via ssh and
> changes to test Aspeed OpenBMC SDK v09.02 for AST2700.
> 
> ASPEED fixed TX mask issue from linux/drivers/ftgmac100.c.
> It is required to use ASPEED SDK image since v09.02
> for AST2700 QEMU network testing.
> 
> A test image is downloaded from the ASPEED Forked OpenBMC GitHub
> release repository :
> https://github.com/AspeedTech-BMC/openbmc/releases/
> 
> Test command:
> ```
> cd build
> pyvenv/bin/avocado run ../qemu/tests/avocado/machine_aspeed.py:AST2x00MachineSDK.test_aarch64_ast2700_evb_sdk_v09_02
> ```
> 
> Signed-off-by: Jamin Lin <jamin_lin@aspeedtech.com>

Could you please split the patch ? The change of SDK should be
a standalone patch.


Thanks,

C.


> ---
>   tests/avocado/machine_aspeed.py | 13 +++++++------
>   1 file changed, 7 insertions(+), 6 deletions(-)
> 
> diff --git a/tests/avocado/machine_aspeed.py b/tests/avocado/machine_aspeed.py
> index 3a20644fb2..855da805ae 100644
> --- a/tests/avocado/machine_aspeed.py
> +++ b/tests/avocado/machine_aspeed.py
> @@ -313,14 +313,14 @@ def do_test_arm_aspeed_sdk_start(self, image):
>   
>       def do_test_aarch64_aspeed_sdk_start(self, image):
>           self.vm.set_console()
> -        self.vm.add_args('-drive', 'file=' + image + ',if=mtd,format=raw')
> +        self.vm.add_args('-drive', 'file=' + image + ',if=mtd,format=raw',
> +                         '-net', 'nic', '-net', 'user,hostfwd=:127.0.0.1:0-:22')
>   
>           self.vm.launch()
>   
>           self.wait_for_console_pattern('U-Boot 2023.10')
>           self.wait_for_console_pattern('## Loading kernel from FIT Image')
>           self.wait_for_console_pattern('Starting kernel ...')
> -        self.wait_for_console_pattern("systemd[1]: Hostname set to")
>   
>       @skipUnless(os.getenv('QEMU_TEST_FLAKY_TESTS'), 'Test is unstable on GitLab')
>   
> @@ -387,15 +387,15 @@ def test_arm_ast2600_evb_sdk(self):
>           year = time.strftime("%Y")
>           self.ssh_command_output_contains('/sbin/hwclock -f /dev/rtc1', year);
>   
> -    def test_aarch64_ast2700_evb_sdk_v09_01(self):
> +    def test_aarch64_ast2700_evb_sdk_v09_02(self):
>           """
>           :avocado: tags=arch:aarch64
>           :avocado: tags=machine:ast2700-evb
>           """
>   
>           image_url = ('https://github.com/AspeedTech-BMC/openbmc/releases/'
> -                     'download/v09.01/ast2700-default-obmc.tar.gz')
> -        image_hash = 'b1cc0fd73c7650d34c9c8459a243f52a91e9e27144b8608b2645ab19461d1e07'
> +                     'download/v09.02/ast2700-default-obmc.tar.gz')
> +        image_hash = 'ac969c2602f4e6bdb69562ff466b89ae3fe1d86e1f6797bb7969d787f82116a7'
>           image_path = self.fetch_asset(image_url, asset_hash=image_hash,
>                                         algorithm='sha256')
>           archive.extract(image_path, self.workdir)
> @@ -436,4 +436,5 @@ def test_aarch64_ast2700_evb_sdk_v09_01(self):
>   
>           self.vm.add_args('-smp', str(num_cpu))
>           self.do_test_aarch64_aspeed_sdk_start(image_dir + 'image-bmc')
> -
> +        self.wait_for_console_pattern('nodistro.0 ast2700-default ttyS12')
> +        self.ssh_connect('root', '0penBmc', False)


