Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3266EC5DF81
	for <qemu-devel@archiver.kernel.org>; Tue, 18 Aug 2026 21:20:30 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wwREK-0001qD-8Z; Tue, 18 Aug 2026 17:20:22 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@kaod.org>)
 id 1wwRED-0001oH-3h; Tue, 18 Aug 2026 17:20:13 -0400
Received: from smtpout1.mo528.mail-out.ovh.net ([46.105.34.251])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@kaod.org>)
 id 1wwREB-00087H-7A; Tue, 18 Aug 2026 17:20:12 -0400
Received: from director5.derp.mail-out.ovh.net
 (director5.derp.mail-out.ovh.net [79.137.60.225])
 by mo528.mail-out.ovh.net (Postfix) with ESMTPS id 4hPjK30rkFz67jr;
 Tue, 18 Aug 2026 21:20:06 +0000 (UTC)
Received: from director5.derp.mail-out.ovh.net
 (director5.derp.mail-out.ovh.net. [127.0.0.1])
 by director5.derp.mail-out.ovh.net (inspect_sender_mail_agent) with SMTP
 for <jamin_lin@aspeedtech.com>; Tue, 18 Aug 2026 21:20:06 +0000 (UTC)
Received: from mta3.priv.ovhmail-u2.ea.mail.ovh.net (unknown [10.109.249.61])
 by director5.derp.mail-out.ovh.net (Postfix) with ESMTPS id
 4hPjK2343Lz6SRH; Tue, 18 Aug 2026 21:20:06 +0000 (UTC)
Received: from kaod.org (unknown [10.1.6.4])
 (Authenticated sender: clg@kaod.org)
 by mta3.priv.ovhmail-u2.ea.mail.ovh.net (Postfix) with ESMTPSA id DD7AD12E3F45;
 Tue, 18 Aug 2026 21:20:04 +0000 (UTC)
Authentication-Results: garm.ovh; auth=pass
 (GARM-112S0063c8cd60a-aa77-4e91-9bc5-39e59f2d0929,
 89C2A8DA583E85FD8389CCC5514D70A45810139E) smtp.auth=clg@kaod.org
X-OVh-ClientIp: 2.10.174.70
Message-ID: <98572f2f-cb08-45c5-aaf6-749db2a2611b@kaod.org>
Date: Tue, 18 Aug 2026 23:20:03 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] hw/misc/aspeed_scu: Set both AST2600 protection key
 registers on reset
To: Andrew Jeffery <andrew@codeconstruct.com.au>, qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Steven Lee <steven_lee@aspeedtech.com>, Troy Lee <leetroy@gmail.com>,
 Jamin Lin <jamin_lin@aspeedtech.com>, Kane Chen <kane_chen@aspeedtech.com>,
 Joel Stanley <joel@jms.id.au>, qemu-arm@nongnu.org
References: <20260818-dev-ast2600-hw-prot-key-reset-v1-1-5dc3de64c247@codeconstruct.com.au>
From: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@kaod.org>
Content-Language: en-US, fr
Autocrypt: addr=clg@kaod.org; keydata=
 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
In-Reply-To: <20260818-dev-ast2600-hw-prot-key-reset-v1-1-5dc3de64c247@codeconstruct.com.au>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
x-ovh-tracer-id: 14737466831206591499
X-VR-SPAMSTATE: OK
X-VR-SPAMSCORE: -100
X-VR-SPAMCAUSE: dmFkZTELJvD+FVxDEMW7Z8CL6uwqhNDmvvHzsliPpPh+5wHTAqCrNealCNUzU9DC0KCgltmnJmDJVfMX7kx+SriEA77PDwU90JoIofKRJ8n2Js8InD7IarpWcJ4nbW99M22m95FOOn6knS4j/CxhIX/ibLm2y7+sXRZhRne6+ncwzul8mcYhYUsnAcDDgGCs2/bbZPsWjuVbcQCLjCCZBJc0AXzqyTjLjpx4GOnNxGfnizUsv87ACQdtOUlrZJ8wBSWy0oWpRU+xJ+i0w5uHZ9UfH+9ux/GsyiNdxGmfEURhmut2nhzfH+MmcIMhkbGqnkoFQD4m32ltVNBvZzqZT6XpBJ3stRp4wg7rd62DsOuZ4xB9ncA4q16cBrJQp3JqEBKtBqHrlSIToT5IRgZP2McS8QJ2sNFl/ZocvrkPNtFxprifNvadLBrdUjZ+gc64VXqY9gYsjq2DtRb0CVmosP4IjT7Mjm8otCf8ybQPqLKrUK8vZCDofN+IPA92CSsGcMfzbldpFmSpnIBkJqLlZXk7L4dgBov9vxppqd2H2TTh+raOgXU8+90V9OPivL8eV0SRg6SHqFHjr8WXaol2q+Vv9PAGwjwaMam2x5i+v23Idfgf2qz0AuMB/a51QTeDJHPaWubKuX+hEy19EhZo7o9akePPiEleSG1/kAkZ2cUdNgBJEw
DKIM-Signature: a=rsa-sha256; bh=p+L2ajg1xUrdluobNOOq4K7x3rgArvI8DhxUMJed7Ds=; 
 c=relaxed/relaxed; d=kaod.org; h=From; s=ovhmo393970-selector1;
 t=1787088008; v=1;
 b=bonPdVgEVP8MNMcNLQmUfsqE4dPernZdb6Oh0L8no5PzBU4+UavUtDJ1PxVzOnC72fJy+TPd
 WcaAIV+OZCI0CQwa/bgnl3emtsIWtbe6INn3aYBPFcQT7V3kKpyt6tUr2Mcmv+/zeDWLOYh6DTF
 x4dSMSHy+d5zbrURmEnk22WaGnKNDPisZYSIdcbPZgnv9LqlxYg0LacsfQghx6tGhHOANDngCYZ
 MZoNtxP+uU2npU80OJqb/0PIuKRpPlxvJ6lRS4H9PrTx0xvurgE13cIqpb7YINMM5+a0AOJ7wkB
 haQ28eKH1AQ3E5dU4i3CFLw4ZYzvvco++4u6K8mTDes0w==
Received-SPF: pass client-ip=46.105.34.251; envelope-from=clg@kaod.org;
 helo=smtpout1.mo528.mail-out.ovh.net
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

On 8/18/26 03:43, Andrew Jeffery wrote:
> Currently, booting Linux on the ast2600-evb machine via -kernel results
> in a lot of warnings about failing to apply pinmux configuration when
> binding drivers:
> 
>      [    7.339307][    T1] Creating 5 MTD partitions on "bmc":
>      [    7.340402][    T1] 0x000000000000-0x0000000e0000 : "u-boot"
>      [    7.513755][    T1] 0x0000000e0000-0x000000100000 : "u-boot-env"
>      [    7.664219][    T1] 0x000000100000-0x000000a00000 : "kernel"
>      [    7.826974][    T1] 0x000000a00000-0x000002a00000 : "rofs"
>      [    8.026666][    T1] 0x000002a00000-0x000004000000 : "rwfs"
>      [    8.201612][    T1] spi-aspeed-smc 1e630000.spi: error -EPERM: Error applying setting, reverse things back
>      [    8.370835][    T1] spi-aspeed-smc 1e630000.spi: Calibration area too uniform, using low speed
>      [    8.371131][    T1] spi-aspeed-smc 1e630000.spi: Force to dts configuration 100000kHz.
>      [    8.371500][    T1] spi-aspeed-smc 1e630000.spi: CE0 read buswidth:4 [0x406c0741]
>      [    8.766797][    T1] mdio-aspeed 1e650000.mdio: error -EPERM: Error applying setting, reverse things back
>      [    8.906008][    T1] mdio-aspeed 1e650008.mdio: error -EPERM: Error applying setting, reverse things back
>      [    9.039240][    T1] mdio-aspeed 1e650010.mdio: error -EPERM: Error applying setting, reverse things back
>      [    9.147942][    T1] mdio-aspeed 1e650018.mdio: error -EPERM: Error applying setting, reverse things back
> 
> The pinmux configuration fails because the SCU is not unlocked.
> 
> Set both SCU protection keys for the AST2600. Further, set them
> such that they behave accordance with the read value documented
> by the datasheet. The new arrangement now upholds the comment in
> hw/arm/aspeed.c regarding passing -kernel on the qemu command-line.
> 
>      [    7.568170][    T1] Creating 5 MTD partitions on "bmc":
>      [    7.569330][    T1] 0x000000000000-0x0000000e0000 : "u-boot"
>      [    7.740372][    T1] 0x0000000e0000-0x000000100000 : "u-boot-env"
>      [    7.883570][    T1] 0x000000100000-0x000000a00000 : "kernel"
>      [    8.041004][    T1] 0x000000a00000-0x000002a00000 : "rofs"
>      [    8.196824][    T1] 0x000002a00000-0x000004000000 : "rwfs"
>      [    8.547037][    T1] spi-aspeed-smc 1e630000.spi: Calibration area too uniform, using low speed
>      [    8.547320][    T1] spi-aspeed-smc 1e630000.spi: Force to dts configuration 100000kHz.
>      [    8.547642][    T1] spi-aspeed-smc 1e630000.spi: CE0 read buswidth:4 [0x406c0741]
>      [    9.494235][    T1] ftgmac100 1e660000.ethernet: Read MAC address 52:54:00:12:34:56 from chip
>      [    9.531186][    T1] RTL8211E Gigabit Ethernet 1e650000.mdio-1:00: attached PHY driver (mii_bus:phy_addr=1e650000.mdio-1:00,
> 
> Fixes: e09cf36321f6 ("hw: aspeed_scu: Add AST2600 support")
> Signed-off-by: Andrew Jeffery <andrew@codeconstruct.com.au>
> ---
> I ran into this issue while improving test coverage in my patch review
> process.
> ---
>   hw/misc/aspeed_scu.c | 3 ++-
>   1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/hw/misc/aspeed_scu.c b/hw/misc/aspeed_scu.c
> index ca93c3699d81..1e3db6d03f91 100644
> --- a/hw/misc/aspeed_scu.c
> +++ b/hw/misc/aspeed_scu.c
> @@ -821,7 +821,8 @@ static void aspeed_ast2600_scu_reset_hold(Object *obj, ResetType type)
>       s->regs[AST2600_SILICON_REV2] = s->silicon_rev;
>       s->regs[AST2600_HW_STRAP1] = s->hw_strap1;
>       s->regs[AST2600_HW_STRAP2] = s->hw_strap2;
> -    s->regs[PROT_KEY] = s->hw_prot_key;
> +    s->regs[AST2600_PROT_KEY] = s->hw_prot_key == ASPEED_SCU_PROT_KEY;
> +    s->regs[AST2600_PROT_KEY2] = s->hw_prot_key == ASPEED_SCU_PROT_KEY;
>   }
>   
>   static void aspeed_2600_scu_class_init(ObjectClass *klass, const void *data)
> 
> ---
> base-commit: 9696bf5dc5a5bf0b4a9d05b6cdfe5f13990f97aa
> change-id: 20260818-dev-ast2600-hw-prot-key-reset-e68eb9f49ee9
> 
> Best regards,
> --
> Andrew Jeffery <andrew@codeconstruct.com.au>
> 

Applied to

     https://github.com/legoater/qemu aspeed-next

Thanks,

C.



