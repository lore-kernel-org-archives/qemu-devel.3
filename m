Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7F690CA0FF0
	for <qemu-devel@archiver.kernel.org>; Mon,  1 Sep 2025 08:29:48 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uszuI-00017F-2X; Mon, 01 Sep 2025 04:28:54 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <SRS0=6z4c=3M=kaod.org=clg@ozlabs.org>)
 id 1uszu4-00012I-UB; Mon, 01 Sep 2025 04:28:44 -0400
Received: from mail.ozlabs.org ([2404:9400:2221:ea00::3])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <SRS0=6z4c=3M=kaod.org=clg@ozlabs.org>)
 id 1usztx-0002Bp-DS; Mon, 01 Sep 2025 04:28:38 -0400
Received: from mail.ozlabs.org (mail.ozlabs.org [IPv6:2404:9400:2221:ea00::3])
 by gandalf.ozlabs.org (Postfix) with ESMTP id 4cFhpY1PtNz4w9g;
 Mon,  1 Sep 2025 18:28:21 +1000 (AEST)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (Client did not present a certificate)
 by mail.ozlabs.org (Postfix) with ESMTPSA id 4cFhpS6FMnz4w9d;
 Mon,  1 Sep 2025 18:28:16 +1000 (AEST)
Message-ID: <a735659a-5a1c-460d-826c-4978dc22a865@kaod.org>
Date: Mon, 1 Sep 2025 10:28:12 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [SPAM] [PATCH v1 1/4] hw/arm: Remove ast2700a0-evb machine
To: Jamin Lin <jamin_lin@aspeedtech.com>,
 "reviewer:Incompatible changes" <devel@lists.libvirt.org>,
 Peter Maydell <peter.maydell@linaro.org>,
 Steven Lee <steven_lee@aspeedtech.com>, Troy Lee <leetroy@gmail.com>,
 Andrew Jeffery <andrew@codeconstruct.com.au>, Joel Stanley <joel@jms.id.au>,
 "open list:All patches CC here" <qemu-devel@nongnu.org>,
 "open list:ASPEED BMCs" <qemu-arm@nongnu.org>
Cc: troy_lee@aspeedtech.com, kane_chen@aspeedtech.com
References: <20250901040808.1454742-1-jamin_lin@aspeedtech.com>
 <20250901040808.1454742-2-jamin_lin@aspeedtech.com>
From: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@kaod.org>
Content-Language: en-US, fr
Autocrypt: addr=clg@kaod.org; keydata=
 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
In-Reply-To: <20250901040808.1454742-2-jamin_lin@aspeedtech.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2404:9400:2221:ea00::3;
 envelope-from=SRS0=6z4c=3M=kaod.org=clg@ozlabs.org; helo=mail.ozlabs.org
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

Hello Jamin,

On 9/1/25 06:08, Jamin Lin wrote:
> The ast2700a0-evb machine represents the first revision of the AST2700 and
> serves as the initial engineering sample rather than a production version.
> A newer revision, A1, is now supported, and the ast2700a1-evb should replace
> the older A0 version.
> 
> Signed-off-by: Jamin Lin <jamin_lin@aspeedtech.com>
> ---
>   docs/about/deprecated.rst                     |  8 ------
>   hw/arm/aspeed.c                               | 28 +------------------
>   .../functional/aarch64/test_aspeed_ast2700.py | 12 --------
>   3 files changed, 1 insertion(+), 47 deletions(-)
> 
> diff --git a/docs/about/deprecated.rst b/docs/about/deprecated.rst
> index 5d1579dcf8..8a273e019a 100644
> --- a/docs/about/deprecated.rst
> +++ b/docs/about/deprecated.rst
> @@ -305,14 +305,6 @@ deprecated; use the new name ``dtb-randomness`` instead. The new name
>   better reflects the way this property affects all random data within
>   the device tree blob, not just the ``kaslr-seed`` node.
>   
> -Arm ``ast2700a0-evb`` machine (since 10.1)
> -''''''''''''''''''''''''''''''''''''''''''

We need to wait *two* releases after deprecation before removing a
machine or any other feature. So removal of the ast2700a0-evb machine
will be possible for QEMU 11.0 (next after QEMU 10.2).

> -
> -The ``ast2700a0-evb`` machine represents the first revision of the AST2700
> -and serves as the initial engineering sample rather than a production version.
> -A newer revision, A1, is now supported, and the ``ast2700a1-evb`` should
> -replace the older A0 version.
> -

File docs/about/removed-features.rst should be updated too.

>   Mips ``mipssim`` machine (since 10.0)
>   '''''''''''''''''''''''''''''''''''''
>   
> diff --git a/hw/arm/aspeed.c b/hw/arm/aspeed.c
> index c31bbe7701..e729edfe13 100644
> --- a/hw/arm/aspeed.c
> +++ b/hw/arm/aspeed.c
> @@ -1989,35 +1989,13 @@ static void ast2700_evb_i2c_init(AspeedMachineState *bmc)
>                               TYPE_TMP105, 0x4d);
>   }
>   
> -static void aspeed_machine_ast2700a0_evb_class_init(ObjectClass *oc,
> -                                                    const void *data)
> -{
> -    MachineClass *mc = MACHINE_CLASS(oc);
> -    AspeedMachineClass *amc = ASPEED_MACHINE_CLASS(oc);
> -
> -    mc->alias = "ast2700-evb";

The "ast2700-evb" alias should be moved first to the ast2700a1_evb machine.
This can be done in this QEMU cycle


Thanks,

C.




> -    mc->desc = "Aspeed AST2700 A0 EVB (Cortex-A35)";
> -    amc->soc_name  = "ast2700-a0";
> -    amc->hw_strap1 = AST2700_EVB_HW_STRAP1;
> -    amc->hw_strap2 = AST2700_EVB_HW_STRAP2;
> -    amc->fmc_model = "w25q01jvq";
> -    amc->spi_model = "w25q512jv";
> -    amc->num_cs    = 2;
> -    amc->macs_mask = ASPEED_MAC0_ON | ASPEED_MAC1_ON | ASPEED_MAC2_ON;
> -    amc->uart_default = ASPEED_DEV_UART12;
> -    amc->i2c_init  = ast2700_evb_i2c_init;
> -    amc->vbootrom = true;
> -    mc->auto_create_sdcard = true;
> -    mc->default_ram_size = 1 * GiB;
> -    aspeed_machine_class_init_cpus_defaults(mc);
> -}
> -
>   static void aspeed_machine_ast2700a1_evb_class_init(ObjectClass *oc,
>                                                       const void *data)
>   {
>       MachineClass *mc = MACHINE_CLASS(oc);
>       AspeedMachineClass *amc = ASPEED_MACHINE_CLASS(oc);
>   
> +    mc->alias = "ast2700-evb";
>       mc->desc = "Aspeed AST2700 A1 EVB (Cortex-A35)";
>       amc->soc_name  = "ast2700-a1";
>       amc->hw_strap1 = AST2700_EVB_HW_STRAP1;
> @@ -2166,10 +2144,6 @@ static const TypeInfo aspeed_machine_types[] = {
>           .class_init     = aspeed_minibmc_machine_ast1030_evb_class_init,
>   #ifdef TARGET_AARCH64
>       }, {
> -        .name          = MACHINE_TYPE_NAME("ast2700a0-evb"),
> -        .parent        = TYPE_ASPEED_MACHINE,
> -        .class_init    = aspeed_machine_ast2700a0_evb_class_init,
> -        }, {
>           .name          = MACHINE_TYPE_NAME("ast2700a1-evb"),
>           .parent        = TYPE_ASPEED_MACHINE,
>           .class_init    = aspeed_machine_ast2700a1_evb_class_init,
> diff --git a/tests/functional/aarch64/test_aspeed_ast2700.py b/tests/functional/aarch64/test_aspeed_ast2700.py
> index d02dc7991c..063d9e572c 100755
> --- a/tests/functional/aarch64/test_aspeed_ast2700.py
> +++ b/tests/functional/aarch64/test_aspeed_ast2700.py
> @@ -46,10 +46,6 @@ def verify_openbmc_boot_and_login(self, name):
>           exec_command_and_wait_for_pattern(self, 'root', 'Password:')
>           exec_command_and_wait_for_pattern(self, '0penBmc', f'root@{name}:~#')
>   
> -    ASSET_SDK_V906_AST2700 = Asset(
> -            'https://github.com/AspeedTech-BMC/openbmc/releases/download/v09.06/ast2700-a0-default-obmc.tar.gz',
> -            '7247b6f19dbfb700686f8d9f723ac23f3eb229226c0589cb9b06b80d1b61f3cb')
> -
>       ASSET_SDK_V906_AST2700A1 = Asset(
>               'https://github.com/AspeedTech-BMC/openbmc/releases/download/v09.06/ast2700-default-obmc.tar.gz',
>               'f1d53e0be8a404ecce3e105f72bc50fa4e090ad13160ffa91b10a6e0233a9dc6')
> @@ -111,14 +107,6 @@ def start_ast2700_test_vbootrom(self, name):
>           self.do_test_aarch64_aspeed_sdk_start(
>                   self.scratch_file(name, 'image-bmc'))
>   
> -    def test_aarch64_ast2700_evb_sdk_v09_06(self):
> -        self.set_machine('ast2700-evb')
> -
> -        self.archive_extract(self.ASSET_SDK_V906_AST2700)
> -        self.start_ast2700_test('ast2700-a0-default')
> -        self.verify_openbmc_boot_and_login('ast2700-a0-default')
> -        self.do_ast2700_i2c_test()
> -
>       def test_aarch64_ast2700a1_evb_sdk_v09_06(self):
>           self.set_machine('ast2700a1-evb')
>   


