Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C30C8CC6B1C
	for <qemu-devel@archiver.kernel.org>; Tue, 13 Oct 2026 16:29:44 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xGfMo-0006gH-5h; Tue, 13 Oct 2026 12:28:42 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@kaod.org>)
 id 1xGfLj-0005Oz-HR; Tue, 13 Oct 2026 12:27:35 -0400
Received: from smtpout5.mo536.mail-out.ovh.net ([51.210.91.14])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@kaod.org>)
 id 1xGfLh-0005FY-Rj; Tue, 13 Oct 2026 12:27:35 -0400
Received: from director4.derp.mail-out.ovh.net
 (director4.derp.mail-out.ovh.net [79.137.60.37])
 by mo536.mail-out.ovh.net (Postfix) with ESMTPS id 4j409Z58Y0z89Kf;
 Tue, 13 Oct 2026 16:27:30 +0000 (UTC)
Received: from director4.derp.mail-out.ovh.net
 (director4.derp.mail-out.ovh.net. [127.0.0.1])
 by director4.derp.mail-out.ovh.net (inspect_sender_mail_agent) with SMTP
 for <jamin_lin@aspeedtech.com>; Tue, 13 Oct 2026 16:27:30 +0000 (UTC)
Received: from mta2.priv.ovhmail-u2.ea.mail.ovh.net (unknown [10.110.101.31])
 by director4.derp.mail-out.ovh.net (Postfix) with ESMTPS id
 4j409Z422Sz1xsk; Tue, 13 Oct 2026 16:27:30 +0000 (UTC)
Received: from kaod.org (unknown [10.1.6.1])
 (Authenticated sender: clg@kaod.org)
 by mta2.priv.ovhmail-u2.ea.mail.ovh.net (Postfix) with ESMTPSA id BDCAE941FD8; 
 Tue, 13 Oct 2026 16:27:27 +0000 (UTC)
Authentication-Results: garm.ovh; auth=pass
 (GARM-110S004d16a47f7-ec1f-41f7-8a85-442b1ad3f3c6,
 3B5152602AE6D76A7CF2E50DC6ABDDC767F0B630) smtp.auth=clg@kaod.org
X-OVh-ClientIp: 82.64.250.170
Message-ID: <d7e8e7ce-5ceb-4ebe-8585-d8b7e2bcffcf@kaod.org>
Date: Tue, 13 Oct 2026 18:27:27 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 03/50] hw/arm: sanmiguel: remove the second SPI flash
 controller
To: Emmanuel Blot <emmanuel.blot@free.fr>, qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Steven Lee <steven_lee@aspeedtech.com>, Troy Lee <leetroy@gmail.com>,
 Jamin Lin <jamin_lin@aspeedtech.com>, Kane Chen <kane_chen@aspeedtech.com>,
 Andrew Jeffery <andrew@codeconstruct.com.au>, Joel Stanley <joel@jms.id.au>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>, qemu-arm@nongnu.org,
 Patrick Leis <venture@google.com>, Fabiano Rosas <farosas@suse.de>,
 Laurent Vivier <lvivier@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 qemu-ppc@nongnu.org, qemu-riscv@nongnu.org,
 =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
References: <20261012-bmc-minerva-v2-0-4c3dff084ec9@free.fr>
 <20261012-bmc-minerva-v2-3-4c3dff084ec9@free.fr>
From: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@kaod.org>
Content-Language: en-US, fr
Autocrypt: addr=clg@kaod.org; keydata=
 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
In-Reply-To: <20261012-bmc-minerva-v2-3-4c3dff084ec9@free.fr>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
x-ovh-tracer-id: 6625358004107979821
X-VR-SPAMSTATE: OK
X-VR-SPAMSCORE: -100
X-VR-SPAMCAUSE: dmFkZTFJAA0Cff5mZHzxjOMf3vpdM/VfvcU3tzZqy3rh935Ggo91wXIdpJWVeOQBh0BtkSvpcDXPndRPnQDJ5NOOH3LTp7Nq6TOnz5gH/2/VElRGGUCKt+RHqpbTAnEaoqBeRCSlmVGALEzjKJy8O9LWHZZjTH8ta/3/Ns1/1dAtkg32q9bqR3JeX4KZeQ1ExBk2Xzh+zVJ5kZP+auzj5MEVRHRs1/p1H1NscUbI9FzfTnG2Wu2R/8O+EDjBsjafLViuNUeh8OdAkwN79Q2U1dqkbzpYq8JzfkLY8NR63te0LErTTbLj6jB1xH/iwK5utVdtxSHGcYHKT6mU1lwv9nag/pmKD07+aPSumqruOXe6qXcQMMEEGtsLKsp8wvlr/vWPePk4NuE2i5ovU0lLD8N/ANlk4sMcoy8DkcUavxUCznBB4L40P5EVLovIu3N6PV0SshheTLcwaUMYgAQqXL+kZQcxAVFknIIulxgugeB3KULnYj7w3hQqhAYXws5IE1vLv+mGxuQPUGHe8GLsYIfnlbmKvXzpXjzVO7Km1IsitopwwzN8NVcEKzxhLh+Z/w0FihmcnkzVOwHIZANihOq/nTedIzxk+c0ZlyncwSDDIP/Z8JsasJ40l/g2+51jQnEIiW2ZbrjRagkyel2/5zMWe2MiiKo2LfK5x7vIm6x657v5lg
DKIM-Signature: a=rsa-sha256; bh=QVstO6Vk1+VBByl0ay6fm1fjhvzXar4mpMc1qwmgIdU=; 
 c=relaxed/relaxed; d=kaod.org; h=From; s=ovhmo393970-selector1;
 t=1791908850; v=1;
 b=sG4aCGBhg/+Go9DV28mb7/BDO2DvKNJ3d3Kl+e1InQZPAFw2TojWubkgW/1cup0LD0EKNu3m
 Yv4rKDhqL3v3V812Ln+rzqdE6z3CVmR/GJe3HEIFYlYfSVU0WzrKploM1yT2+9x5k1OgGP2fGit
 frxr3U4thT+OoDiNxj0j+hHjclGQW53bfwxnv615Ut9RnoqoEJ6PSk7dnO6JGIv6dmA4Itedd4L
 2yoNJH/Ss0EjuZ8q7PNGU0a3VD2uqhF/JHYUKvvfZaFd1gBcMjpzGVoDlCBcSw//3bkzhCKOjQn
 s55lhbei1iSB/nMlk9oW2Ms8Wikol/NpoUVzzsCPLh7yg==
Received-SPF: pass client-ip=51.210.91.14; envelope-from=clg@kaod.org;
 helo=smtpout5.mo536.mail-out.ovh.net
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
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

On 10/12/26 16:31, Emmanuel Blot wrote:
> The board only populates the flash device attached to the FMC
> controller; the SoC SPI controllers are left unused. Advertising a
> part there presents the guest with a flash device the hardware does
> not have.
> 
> While here, add the missing year to the copyright line.
> 
> Signed-off-by: Emmanuel Blot <emmanuel.blot@free.fr>
> ---
>   hw/arm/aspeed_ast2600_sanmiguel.c | 4 ++--
>   1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/hw/arm/aspeed_ast2600_sanmiguel.c b/hw/arm/aspeed_ast2600_sanmiguel.c
> index 345a9c9416..ac2aef740a 100644
> --- a/hw/arm/aspeed_ast2600_sanmiguel.c
> +++ b/hw/arm/aspeed_ast2600_sanmiguel.c
> @@ -1,7 +1,7 @@
>   /*
>    * Facebook SanMiguel BMC
>    *
> - * Copyright (c) Meta Platforms, Inc. and affiliates.
> + * Copyright (c) 2026 Meta Platforms, Inc. and affiliates.
>    *
>    * SPDX-License-Identifier: GPL-2.0-or-later
>    */
> @@ -384,7 +384,7 @@ static void aspeed_machine_sanmiguel_class_init(ObjectClass *oc,
>       amc->hw_strap1 = SANMIGUEL_BMC_HW_STRAP1;
>       amc->hw_strap2 = SANMIGUEL_BMC_HW_STRAP2;
>       amc->fmc_model = "mx66l1g45g";
> -    amc->spi_model = "mx66l1g45g";
> +    amc->spi_model = NULL;
>       amc->num_cs    = 2;
>       amc->macs_mask = ASPEED_MAC0_ON;
>       amc->i2c_init  = sanmiguel_bmc_i2c_init;
> 

Reviewed-by: Cédric Le Goater <clg@redhat.com>

Thanks,

C.


