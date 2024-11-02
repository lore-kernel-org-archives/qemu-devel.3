Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9BF55E67802
	for <qemu-devel@archiver.kernel.org>; Sat,  2 Nov 2024 15:04:05 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t7Fen-0000SS-Gv; Sat, 02 Nov 2024 11:03:19 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <SRS0=uVOK=R5=kaod.org=clg@ozlabs.org>)
 id 1t7FeU-0000Cd-IH; Sat, 02 Nov 2024 11:02:59 -0400
Received: from mail.ozlabs.org ([2404:9400:2221:ea00::3])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <SRS0=uVOK=R5=kaod.org=clg@ozlabs.org>)
 id 1t7FeR-0004aK-Fk; Sat, 02 Nov 2024 11:02:56 -0400
Received: from mail.ozlabs.org (mail.ozlabs.org [IPv6:2404:9400:2221:ea00::3])
 by gandalf.ozlabs.org (Postfix) with ESMTP id 4XggvZ68n4z4x8R;
 Sun,  3 Nov 2024 02:02:50 +1100 (AEDT)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits))
 (Client did not present a certificate)
 by mail.ozlabs.org (Postfix) with ESMTPSA id 4XggvV3Z8Tz4wxf;
 Sun,  3 Nov 2024 02:02:46 +1100 (AEDT)
Message-ID: <de5b9cd4-ed9f-4398-86d8-b4ad15849223@kaod.org>
Date: Sat, 2 Nov 2024 16:02:46 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [SPAM] [PATCH v1 8/8] aspeed: Support create flash devices via
 command line for AST1030
To: Jamin Lin <jamin_lin@aspeedtech.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 Steven Lee <steven_lee@aspeedtech.com>, Troy Lee <leetroy@gmail.com>,
 Andrew Jeffery <andrew@codeconstruct.com.au>, Joel Stanley <joel@jms.id.au>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Bin Meng <bmeng.cn@gmail.com>, "open list:ASPEED BMCs"
 <qemu-arm@nongnu.org>, "open list:All patches CC here"
 <qemu-devel@nongnu.org>, "open list:SD (Secure Card)" <qemu-block@nongnu.org>
Cc: troy_lee@aspeedtech.com, yunlin.tang@aspeedtech.com
References: <20241029091729.3317512-1-jamin_lin@aspeedtech.com>
 <20241029091729.3317512-9-jamin_lin@aspeedtech.com>
Content-Language: en-US, fr
From: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@kaod.org>
In-Reply-To: <20241029091729.3317512-9-jamin_lin@aspeedtech.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2404:9400:2221:ea00::3;
 envelope-from=SRS0=uVOK=R5=kaod.org=clg@ozlabs.org; helo=mail.ozlabs.org
X-Spam_score_int: -39
X-Spam_score: -4.0
X-Spam_bar: ----
X-Spam_report: (-4.0 / 5.0 requ) BAYES_00=-1.9,
 HEADER_FROM_DIFFERENT_DOMAINS=0.249, RCVD_IN_DNSWL_MED=-2.3,
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

On 10/29/24 10:17, Jamin Lin wrote:
> Add a "if-statement" in aspeed_minibmc_machine_init function. If users add
> "-nodefaults" in command line, the flash devices should be created by users
> setting. Otherwise, the flash devices are created at machine init.
> 
> Signed-off-by: Jamin Lin <jamin_lin@aspeedtech.com>



Reviewed-by: Cédric Le Goater <clg@redhat.com>

Thanks,

C.

> ---
>   hw/arm/aspeed.c | 22 ++++++++++++----------
>   1 file changed, 12 insertions(+), 10 deletions(-)
> 
> diff --git a/hw/arm/aspeed.c b/hw/arm/aspeed.c
> index 0468602d95..e161e6b1c5 100644
> --- a/hw/arm/aspeed.c
> +++ b/hw/arm/aspeed.c
> @@ -1602,18 +1602,20 @@ static void aspeed_minibmc_machine_init(MachineState *machine)
>       connect_serial_hds_to_uarts(bmc);
>       qdev_realize(DEVICE(bmc->soc), NULL, &error_abort);
>   
> -    aspeed_board_init_flashes(&bmc->soc->fmc,
> -                              bmc->fmc_model ? bmc->fmc_model : amc->fmc_model,
> -                              amc->num_cs,
> -                              0);
> +    if (defaults_enabled()) {
> +        aspeed_board_init_flashes(&bmc->soc->fmc,
> +                            bmc->fmc_model ? bmc->fmc_model : amc->fmc_model,
> +                            amc->num_cs,
> +                            0);
>   
> -    aspeed_board_init_flashes(&bmc->soc->spi[0],
> -                              bmc->spi_model ? bmc->spi_model : amc->spi_model,
> -                              amc->num_cs, amc->num_cs);
> +        aspeed_board_init_flashes(&bmc->soc->spi[0],
> +                            bmc->spi_model ? bmc->spi_model : amc->spi_model,
> +                            amc->num_cs, amc->num_cs);
>   
> -    aspeed_board_init_flashes(&bmc->soc->spi[1],
> -                              bmc->spi_model ? bmc->spi_model : amc->spi_model,
> -                              amc->num_cs, (amc->num_cs * 2));
> +        aspeed_board_init_flashes(&bmc->soc->spi[1],
> +                            bmc->spi_model ? bmc->spi_model : amc->spi_model,
> +                            amc->num_cs, (amc->num_cs * 2));
> +    }
>   
>       if (amc->i2c_init) {
>           amc->i2c_init(bmc);


