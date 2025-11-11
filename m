Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 35916CCFA18
	for <qemu-devel@archiver.kernel.org>; Tue, 11 Nov 2025 18:27:17 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vIt4h-0002H9-TH; Tue, 11 Nov 2025 13:26:39 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@kaod.org>) id 1vIt4f-0002D3-SA
 for qemu-devel@nongnu.org; Tue, 11 Nov 2025 13:26:37 -0500
Received: from 5.mo552.mail-out.ovh.net ([188.165.45.220])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@kaod.org>) id 1vIt4d-0007OQ-3X
 for qemu-devel@nongnu.org; Tue, 11 Nov 2025 13:26:36 -0500
Received: from mxplan5.mail.ovh.net (unknown [10.109.254.74])
 by mo552.mail-out.ovh.net (Postfix) with ESMTPS id 4d5Zk03D07z5xHY;
 Tue, 11 Nov 2025 18:26:32 +0000 (UTC)
Received: from kaod.org (37.59.142.111) by DAG8EX2.mxp5.local (172.16.2.72)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.61; Tue, 11 Nov
 2025 19:26:31 +0100
Authentication-Results: garm.ovh; auth=pass
 (GARM-111S0052f381235-30e2-4440-9971-7f1797af687b,
 FED24A3CA347B2ADB49E2A92EE4521FA9BC47B0E) smtp.auth=clg@kaod.org
X-OVh-ClientIp: 82.64.250.170
Message-ID: <660f1bfc-383f-4681-98e7-19aa4555b5fe@kaod.org>
Date: Tue, 11 Nov 2025 19:26:30 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/2] hw/arm: enable eeproms for quanta-q71l
To: Yubin Zou <yubinz@google.com>
CC: <qemu-devel@nongnu.org>, Peter Maydell <peter.maydell@linaro.org>, Steven
 Lee <steven_lee@aspeedtech.com>, Troy Lee <leetroy@gmail.com>, Jamin Lin
 <jamin_lin@aspeedtech.com>, Andrew Jeffery <andrew@codeconstruct.com.au>,
 Joel Stanley <joel@jms.id.au>, <qemu-arm@nongnu.org>, Patrick Venture
 <venture@google.com>
References: <20250916-quanta-q71l-eeproms-v1-0-3648692cc441@google.com>
 <20250916-quanta-q71l-eeproms-v1-2-3648692cc441@google.com>
 <08b6e571-bf4f-4e51-8a70-8c2c5c675277@kaod.org>
 <CABU_6BJ5zZ2VWHo4pS7r815RtTjdv5iZj=wYbXm5xc=X0+dh9w@mail.gmail.com>
From: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@kaod.org>
Content-Language: en-US, fr
Autocrypt: addr=clg@kaod.org; keydata=
 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
In-Reply-To: <CABU_6BJ5zZ2VWHo4pS7r815RtTjdv5iZj=wYbXm5xc=X0+dh9w@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-Originating-IP: [37.59.142.111]
X-ClientProxiedBy: DAG7EX1.mxp5.local (172.16.2.61) To DAG8EX2.mxp5.local
 (172.16.2.72)
X-Ovh-Tracer-GUID: 03eaf675-1893-473c-96a4-151a1da819ad
X-Ovh-Tracer-Id: 9212113041593174962
X-VR-SPAMSTATE: OK
X-VR-SPAMSCORE: -100
X-VR-SPAMCAUSE: dmFkZTF8x/K3hG6UpYUo/OpzLMK6i/V4Uo+nf0BAUh4LR8ybaY4Lv9va95h4EL4U5qS3P6kd4eEM9ETzGSM+aJ8aD4u35fwx4Fa7ldD6LMxrKHAZ0x7vTg7rEs+Oi5ldGgPKh1Am/KAg2ZVYhDMypdDVXtF91QdcHytMEBOaOHqe9X/5aVNLjLnf8AIge9fOxDfmDvPGi8CfQRCxJzrqTai4iKpHCeCL/st5xaLA1+XVO+IxHTa7ZMx2TQbh0UJ2If40s34BsTYdye8ac+G1cmYU5ZssSNLwULf+qnKGayil9uqVW85W7KLhSihUUUMFGFJngKbc5UtjE4mRUsnIM91R/BFaaY/0xYnIGAMiBt2CCOxycs/Kmb6i8cQv8kKzm2ozKsClUracFvEJpHtRDSx1587paS/0Q9Ds4KX6YRafuR3r59g8bb07waMxeKNEZptDGZuE1MmXuAZOaM2SbD/R5dlX6gaDvqCziii8Lx0G6zyvBp5CMcT+cSPDk4ULLxACXgMlWG3yh2BVjfwRBpDs74M5areneLE6S5uIsmfnVuT9DcWGGfn4ArIENFNAJn7KwQrZVDiiHDfX65d/QtK3pBqvlVGyW6d8K0ZzRXwHNKW7bVtBQJgAVnGAprMx+5ZKIwoOgOyWH7PmoYIhI5o4a4lX6d8++RglQs5/1mXPyPOnZw
DKIM-Signature: a=rsa-sha256; bh=xzuxq2wN24eLC3GyXfKKyr/bCaZ2uoa++HmwNnN5nJU=; 
 c=relaxed/relaxed; d=kaod.org; h=From; s=ovhmo393970-selector1;
 t=1762885592; v=1;
 b=UG+2ttptFajJTAlzl76qnG8fvVWYQbbzcJWWJVy4LgsyQ6wkfoXNWUE1YgvE7km/7rlmIG8H
 zpl0d6Smy1FV4CdaTTwWGXD8Mqx8La1g8cO2JOWXnK93BwtbeM9wu2NMP28ifg6Sf9zEEK7F3RW
 TxnT7n3oIcNbpnQnhvSIkOq3guEM/ZbNy9RAa2Dv8YyJ4AOab1x+lx51TOom5h6AVF3vrlF0BhP
 +4jZYHWfa8NsW0x+CwbCbKcrxMJycJkTdoCZMLKnOESJ3guuCIbyEENhGbNu3do3Jva5kGZLW/B
 xA4BkSRGZo0S4l0z60a+mOEDyetYPvqsb3AXOH+RHzdDA==
Received-SPF: pass client-ip=188.165.45.220; envelope-from=clg@kaod.org;
 helo=5.mo552.mail-out.ovh.net
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

Hi,

On 10/1/25 00:17, Yubin Zou wrote:
> Yes, I will include the patch containing the utility function of at24c_eeprom_init_one.

Will you send an update or have you given up on the idea ?


Thanks,

C.


> 
> Yubin
> 
> On Tue, Sep 16, 2025 at 11:07 PM Cédric Le Goater <clg@kaod.org <mailto:clg@kaod.org>> wrote:
> 
>     Hi,
> 
>     On 9/16/25 19:50, Yubin Zou wrote:
>      > From: Patrick Venture <venture@google.com <mailto:venture@google.com>>
>      >
>      > Tested: Quanta-q71l firmware booted to login and was populated via the
>      > -drives for the corresponding eeproms.
>      > Signed-off-by: Patrick Venture <venture@google.com <mailto:venture@google.com>>
>      > ---
>      >   hw/arm/aspeed.c | 10 +++++-----
>      >   1 file changed, 5 insertions(+), 5 deletions(-)
>      >
>      > diff --git a/hw/arm/aspeed.c b/hw/arm/aspeed.c
>      > index bae59ae7394882e3fc93863049a37ff5a8737ff8..8cef387a0b431576a873553704920886222cca86 100644
>      > --- a/hw/arm/aspeed.c
>      > +++ b/hw/arm/aspeed.c
>      > @@ -562,16 +562,16 @@ static void quanta_q71l_bmc_i2c_init(AspeedMachineState *bmc)
>      >       i2c_slave_create_simple(aspeed_i2c_get_bus(&soc->i2c, 1), "tmp105", 0x4f);
>      >
>      >       /* Baseboard FRU */
>      > -    at24c_eeprom_init(aspeed_i2c_get_bus(&soc->i2c, 1), 0x54, 8192);
>      > +    at24c_eeprom_init_one(aspeed_i2c_get_bus(&soc->i2c, 1), 1, 0x54, 8192, 0);
> 
>     Where is at24c_eeprom_init_one() implementation ?
> 
> 
>     Thanks,
> 
>     C.
> 
> 
>      >       /* Frontpanel FRU */
>      > -    at24c_eeprom_init(aspeed_i2c_get_bus(&soc->i2c, 1), 0x57, 8192);
>      > +    at24c_eeprom_init_one(aspeed_i2c_get_bus(&soc->i2c, 1), 1, 0x57, 8192, 1);
>      >       /* TODO: Add Memory Riser i2c mux and eeproms. */
>      >
>      >       i2c_slave_create_simple(aspeed_i2c_get_bus(&soc->i2c, 2), "pca9546", 0x74);
>      >       i2c_slave_create_simple(aspeed_i2c_get_bus(&soc->i2c, 2), "pca9548", 0x77);
>      >
>      >       /* Add BIOS FRU */
>      > -    at24c_eeprom_init(aspeed_i2c_get_bus(&soc->i2c, 3), 0x56, 8192);
>      > +    at24c_eeprom_init_one(aspeed_i2c_get_bus(&soc->i2c, 3), 3, 0x56, 8192, 2);
>      >
>      >       /* i2c-7 */
>      >       i2c_slave_create_simple(aspeed_i2c_get_bus(&soc->i2c, 7), "pca9546", 0x70);
>      > @@ -581,9 +581,9 @@ static void quanta_q71l_bmc_i2c_init(AspeedMachineState *bmc)
>      >       /*        - i2c@3: pmbus@59 */
>      >
>      >       /* PDB FRU */
>      > -    at24c_eeprom_init(aspeed_i2c_get_bus(&soc->i2c, 7), 0x52, 8192);
>      > +    at24c_eeprom_init_one(aspeed_i2c_get_bus(&soc->i2c, 7), 7, 0x52, 8192, 3);
>      >       /* BMC FRU */
>      > -    at24c_eeprom_init(aspeed_i2c_get_bus(&soc->i2c, 8), 0x50, 8192);
>      > +    at24c_eeprom_init_one(aspeed_i2c_get_bus(&soc->i2c, 8), 8, 0x50, 8192, 4);
>      >   }
>      >
>      >   static void ast2500_evb_i2c_init(AspeedMachineState *bmc)
>      >
> 


