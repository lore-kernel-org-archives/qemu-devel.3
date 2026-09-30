Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 43763CA5FB1
	for <qemu-devel@archiver.kernel.org>; Wed, 30 Sep 2026 11:53:49 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xBssU-0004Vf-4y; Wed, 30 Sep 2026 07:53:39 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@kaod.org>) id 1xBsro-00048p-6w
 for qemu-devel@nongnu.org; Wed, 30 Sep 2026 07:52:57 -0400
Received: from smtpout3.mo540.mail-out.ovh.net ([51.210.91.52])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@kaod.org>) id 1xBsrk-0006h1-UM
 for qemu-devel@nongnu.org; Wed, 30 Sep 2026 07:52:54 -0400
Received: from director6.derp.mail-out.ovh.net
 (director6.derp.mail-out.ovh.net [79.137.60.226])
 by mo540.mail-out.ovh.net (Postfix) with ESMTPS id 4hvthd5qm6z41tq;
 Wed, 30 Sep 2026 11:52:49 +0000 (UTC)
Received: from director6.derp.mail-out.ovh.net
 (director6.derp.mail-out.ovh.net. [127.0.0.1])
 by director6.derp.mail-out.ovh.net (inspect_sender_mail_agent) with SMTP
 for <jamin_lin@aspeedtech.com>; Wed, 30 Sep 2026 11:52:49 +0000 (UTC)
Received: from mta7.priv.ovhmail-u2.ea.mail.ovh.net (unknown [10.110.54.159])
 by director6.derp.mail-out.ovh.net (Postfix) with ESMTPS id
 4hvthd10Vrz46XQ; Wed, 30 Sep 2026 11:52:49 +0000 (UTC)
Received: from kaod.org (unknown [10.1.6.4])
 (Authenticated sender: clg@kaod.org)
 by mta7.priv.ovhmail-u2.ea.mail.ovh.net (Postfix) with ESMTPSA id 1C333202C0C; 
 Wed, 30 Sep 2026 11:52:47 +0000 (UTC)
Authentication-Results: garm.ovh; auth=pass
 (GARM-102R004828929d8-f1a6-4c56-9460-b5c9f813f6e0,
 845F429D393748294ED5D50D12AC6EB9B2213B76) smtp.auth=clg@kaod.org
X-OVh-ClientIp: 82.64.250.170
Message-ID: <8f869f80-0fc4-4956-819d-a84642f6abdb@kaod.org>
Date: Wed, 30 Sep 2026 13:52:46 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 03/50] hw/arm: sanmiguel: remove the second SPI flash
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
References: <20260907-bmc-minerva-v1-0-0d83ad610c3b@free.fr>
 <20260907-bmc-minerva-v1-3-0d83ad610c3b@free.fr>
From: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@kaod.org>
Content-Language: en-US, fr
Autocrypt: addr=clg@kaod.org; keydata=
 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
In-Reply-To: <20260907-bmc-minerva-v1-3-0d83ad610c3b@free.fr>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
x-ovh-tracer-id: 17875068397565815853
X-VR-SPAMSTATE: OK
X-VR-SPAMSCORE: -100
X-VR-SPAMCAUSE: dmFkZTEWqrGEjnw5BvXROALZMjHDKS+3timBiobYK4pHUp11pasmZyxiyORZkmOCQFBgppGPXybXnuvIvnJ9hXSB1m0sxRhuZokDa9d6rOpt50P04FLje/MOJgY7S+SmVCeBOuqTbaWjwpR+j7RS9BnrqL7ryKtJlT3XSD8AK0rOwoaesYC4SssXK7wKq3aZ028P0x5xkM2923yJv97zkVCymb7mBlnU7CwTShNQ42QzmCBSjYV0CGx/u0/7EVI7exoD/4WwsIRSpb7YOTi1/VTUVJy07j6A8s/swIMcdw6juDeyfTfezDo4eU8mdBhtVFNY1ZTBAhA9DYCFaGDtSzQhvfL1eErFPckqRTsR3kxXNLP3eGFh/dFAuubTUGHDHUuptnkqwxVU51h9JK5jR5B0eoE9JbUii8FEgP8uK4mQX1oxBAgvb9NwcfrlQiPSw9axOwJEHZYjISF70aWIAsCUtXTKOCJM9bTNIF4Of/48vTqY/cqKGQSox+Lf96iusnTHCtUi+DxQMx/zfn4A09So6R+cQQ6651Cze36ZOU85RaJDspO1E2oYrapw6/i33XJhFqdMVZBxf/60f1GcQXbeYxqajaNnCxUTRCrD+s7j/HOS6ZiSadQ0ltuK9jnUciZ6W5KzX6k+djiAVTxGkLXGF9XbPvP3ILLElM5JeE04aTErdA
DKIM-Signature: a=rsa-sha256; bh=2CmrnJUkMizc61yKTOYZ1Bw/s9zBikl4YKKo9c2bYTE=; 
 c=relaxed/relaxed; d=kaod.org; h=From; s=ovhmo393970-selector1;
 t=1790769170; v=1;
 b=E7brEjFdsm/pxCjZEwHXuSTdyCLLuGVKLm63iqRdhKnjhr0Y60480K6R4r6Rur8Ribh8zaPt
 /mrcrGaIZFRcjf4GI0m6QiI/KCCTPB3CV2ucrj07gFI+Tw4bI3eNIdwuMYyQovpDoo295Pcvnuk
 5wiWo7zpGtyf3Q9XfA7J4+mx2o8F9PLwCmpOblbj9aOMrRhtCR9BQ9C8EiJPoNnwBWkPtaYmm91
 pvriNMB4oM85rICWlY2JlsYB58KcuNkQNZEM90j/c/W4br+/oqUXLWKI0ZuwQrLR8VRjpl8SkZ9
 3IIWy9TwmbrWLdEdmlAK2gt7/bo7teYq7yV6ll1LohMQw==
Received-SPF: pass client-ip=51.210.91.52; envelope-from=clg@kaod.org;
 helo=smtpout3.mo540.mail-out.ovh.net
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

On 9/7/26 18:41, Emmanuel Blot wrote:
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
> index 599ef1701f..1dbbef11f2 100644
> --- a/hw/arm/aspeed_ast2600_sanmiguel.c
> +++ b/hw/arm/aspeed_ast2600_sanmiguel.c
> @@ -1,7 +1,7 @@
>   /*
>    * Facebook SanMiguel BMC
>    *
> - * Copyright (c) Meta Platforms, Inc. and affiliates.
> + * Copyright (c) 2026 Meta Platforms, Inc. and affiliates.

usually this is a range.

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

anyhow,

Reviewed-by: Cédric Le Goater <clg@redhat.com>

Thanks,

C.


