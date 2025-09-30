Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6CCF2CCA472
	for <qemu-devel@archiver.kernel.org>; Tue, 30 Sep 2025 20:15:41 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v3gkW-0005zY-RC; Tue, 30 Sep 2025 16:15:00 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@kaod.org>) id 1v3gkT-0005zA-Iy
 for qemu-devel@nongnu.org; Tue, 30 Sep 2025 16:14:57 -0400
Received: from 1.mo552.mail-out.ovh.net ([178.32.96.117])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@kaod.org>) id 1v3gkI-0004Lo-So
 for qemu-devel@nongnu.org; Tue, 30 Sep 2025 16:14:57 -0400
Received: from mxplan5.mail.ovh.net (unknown [10.110.43.55])
 by mo552.mail-out.ovh.net (Postfix) with ESMTPS id 4cbq641CR6z6SpT;
 Tue, 30 Sep 2025 20:14:36 +0000 (UTC)
Received: from kaod.org (37.59.142.98) by DAG8EX2.mxp5.local (172.16.2.72)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.59; Tue, 30 Sep
 2025 22:14:35 +0200
Authentication-Results: garm.ovh; auth=pass
 (GARM-98R002505451f8-9179-48be-b3c2-ff00e255ac66,
 012DEA80DA8F652C9231DB37D1304F33C12A2C6A) smtp.auth=clg@kaod.org
X-OVh-ClientIp: 82.64.250.170
Message-ID: <8850fa0e-90c2-44ee-8871-4df46c740cdf@kaod.org>
Date: Tue, 30 Sep 2025 22:14:34 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/2] hw/arm: add eeproms to quanta-q7l1 board
To: Yubin Zou <yubinz@google.com>
CC: <qemu-devel@nongnu.org>, Peter Maydell <peter.maydell@linaro.org>, Steven
 Lee <steven_lee@aspeedtech.com>, Troy Lee <leetroy@gmail.com>, Jamin Lin
 <jamin_lin@aspeedtech.com>, Andrew Jeffery <andrew@codeconstruct.com.au>,
 Joel Stanley <joel@jms.id.au>, <qemu-arm@nongnu.org>, Patrick Venture
 <venture@google.com>
References: <20250916-quanta-q71l-eeproms-v1-0-3648692cc441@google.com>
 <20250916-quanta-q71l-eeproms-v1-1-3648692cc441@google.com>
 <37f60533-8e6b-496c-850b-16aff7fb7be3@kaod.org>
 <CABU_6B+PVUAxc8HLNvP8ym=hRM27StXjhJcc+e1j6i8OkEDwxQ@mail.gmail.com>
From: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@kaod.org>
Content-Language: en-US, fr
Autocrypt: addr=clg@kaod.org; keydata=
 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
In-Reply-To: <CABU_6B+PVUAxc8HLNvP8ym=hRM27StXjhJcc+e1j6i8OkEDwxQ@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-Originating-IP: [37.59.142.98]
X-ClientProxiedBy: DAG3EX2.mxp5.local (172.16.2.22) To DAG8EX2.mxp5.local
 (172.16.2.72)
X-Ovh-Tracer-GUID: 3a0c4bbb-d028-4072-8cc5-840a6a4182ba
X-Ovh-Tracer-Id: 4191725356499372978
X-VR-SPAMSTATE: OK
X-VR-SPAMSCORE: -100
X-VR-SPAMCAUSE: dmFkZTFMOZFcGmOjD6PI8LVBJsWoZ283zV+8p7OnX1K+UakkchumJC10xh/VyhR63cl2WAK5rEzSLUorINeLCbfJnfifHxqssjAOI2oJnqcNfuzn90o0PaYOWx3ltslZHps1HB5mJxCopnhYWVfyPFrYVP/PQTdOIwYh/b2Mg8wcdwR9KZwl2H5nTqhEG9msMBXgdxGFUngSSO9mw+YicNa+TUeopJFxv8dIz7yFbKqS0W2LaqX67dX4p+SZKdUfhS1katPch64c1MgjyOYM9oJhGR6c6Yq1/RRzW6tTYfQAxi3CCel3My/z1CsGhp1ewE943PKKFo2xoFkRzjd+9uP8wD7slZFLJg5LwIxJV3YIQUzS4A7MpdC8ThXqO4yXvw9bwDeBhMkIQLDNwIOLZ9+yKYkRG3ZpQKb1yDQiqjF2iP5Qqb01UpVXCULZsHRdhi3y1ukojgFDxyIAPdLwsog6bioql2cL4uPuSAXV3HNySynHAmue0xt5/rN0odNwvPieMAqmzx1zHl9cgR7CWVdf8UCks+P7t8lU1rCnhgDPUYLYp43SkaZGBQY2zSUEyvG//kjTCOcK9VMXxJ3rhWQVF8rSoiiPB6Ge78PytSfYhahUSYLqR3lgwZJKRJMKMSHv63ruuqJzJ+uJvWeJp4J/QeJPOE7mPbOywoaE3Xq6IUpawg
DKIM-Signature: a=rsa-sha256; bh=M+o+K22gf3v2n6dg2VF6VVYW/h/oGmxUAjYQDjTYlBQ=; 
 c=relaxed/relaxed; d=kaod.org; h=From; s=ovhmo393970-selector1;
 t=1759263278; v=1;
 b=apHUGOgmYnMj3NmTLZCnB+BPZqa7rgd8B9JOLU5bovU/xUyuP9MIFTNh8bPhxY/NJm896MBF
 rOjFO4EcAcrQJ/L4lr9gVZKUk2INgQ2lh7tViiyg2eiUVDKFUyuyClvqNQoAgSHTrmTvsHoldV4
 AwhHnUTOTVKD+LO0/lWi5jBqxn/Sbbm9fen7dbPeGiONW1fQy/rVXDkPMve8nBiWPX8O8uyzyFs
 CGyngg+p1eQUl2UHvEHv+Wi+vy3vtAYeaGyy8xMoornTsYHJzTaZIRcsAHeO9aMxZvvaXDlcNNU
 lY963UCm/biyfkzeopkpn1LitlbyPqVZGLqiq++bhrBRA==
Received-SPF: pass client-ip=178.32.96.117; envelope-from=clg@kaod.org;
 helo=1.mo552.mail-out.ovh.net
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001, SPF_HELO_NONE=0.001,
 T_SPF_TEMPERROR=0.01 autolearn=ham autolearn_force=no
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

Hello Yubin,

On 9/30/25 21:25, Yubin Zou wrote:
> Hi Cedric
> 
> Could you clarify what functional test you are referring to?


It's a small python test downloading a FW image and booting
the machine, possibly also testing that expected services are
up and running, network, I2C devices, etc. This last part is
optional.

See the test_aspeed_*.py files under :

   https://gitlab.com/qemu-project/qemu/-/tree/master/tests/functional/arm?ref_type=heads

test_aspeed_bletchley.py is minimum
test_aspeed_ast2600.py is complex

Thanks,

C.


> 
> Thanks
> Yubin
> 
> On Tue, Sep 16, 2025 at 11:10 PM Cédric Le Goater <clg@kaod.org <mailto:clg@kaod.org>> wrote:
> 
>     Hi,
> 
>     On 9/16/25 19:50, Yubin Zou wrote:
>      > From: Patrick Venture <venture@google.com <mailto:venture@google.com>>
>      >
>      > Adds eeprom init for aspeed helper method and adds 24c64 eeproms to the
>      > quanta-q71l bmc board.
>      >
>      > Tested: Booted quanta-q71l bmc firmware to userspace.
> 
>     Could you please provide a FW image and functional test for the
>     quanta-q7l1 board ?
> 
>     Thanks,
> 
>     C.
> 
> 
>      > Signed-off-by: Patrick Venture <venture@google.com <mailto:venture@google.com>>
>      > ---
>      >   hw/arm/aspeed.c | 15 ++++++++++-----
>      >   1 file changed, 10 insertions(+), 5 deletions(-)
>      >
>      > diff --git a/hw/arm/aspeed.c b/hw/arm/aspeed.c
>      > index c31bbe7701381f6980e874f9fca51805ff9fb9b4..bae59ae7394882e3fc93863049a37ff5a8737ff8 100644
>      > --- a/hw/arm/aspeed.c
>      > +++ b/hw/arm/aspeed.c
>      > @@ -561,14 +561,17 @@ static void quanta_q71l_bmc_i2c_init(AspeedMachineState *bmc)
>      >       i2c_slave_create_simple(aspeed_i2c_get_bus(&soc->i2c, 1), "tmp105", 0x4e);
>      >       i2c_slave_create_simple(aspeed_i2c_get_bus(&soc->i2c, 1), "tmp105", 0x4f);
>      >
>      > -    /* TODO: i2c-1: Add baseboard FRU eeprom@54 24c64 */
>      > -    /* TODO: i2c-1: Add Frontpanel FRU eeprom@57 24c64 */
>      > +    /* Baseboard FRU */
>      > +    at24c_eeprom_init(aspeed_i2c_get_bus(&soc->i2c, 1), 0x54, 8192);
>      > +    /* Frontpanel FRU */
>      > +    at24c_eeprom_init(aspeed_i2c_get_bus(&soc->i2c, 1), 0x57, 8192);
>      >       /* TODO: Add Memory Riser i2c mux and eeproms. */
>      >
>      >       i2c_slave_create_simple(aspeed_i2c_get_bus(&soc->i2c, 2), "pca9546", 0x74);
>      >       i2c_slave_create_simple(aspeed_i2c_get_bus(&soc->i2c, 2), "pca9548", 0x77);
>      >
>      > -    /* TODO: i2c-3: Add BIOS FRU eeprom@56 24c64 */
>      > +    /* Add BIOS FRU */
>      > +    at24c_eeprom_init(aspeed_i2c_get_bus(&soc->i2c, 3), 0x56, 8192);
>      >
>      >       /* i2c-7 */
>      >       i2c_slave_create_simple(aspeed_i2c_get_bus(&soc->i2c, 7), "pca9546", 0x70);
>      > @@ -577,8 +580,10 @@ static void quanta_q71l_bmc_i2c_init(AspeedMachineState *bmc)
>      >       /*        - i2c@2: pmbus@58 */
>      >       /*        - i2c@3: pmbus@59 */
>      >
>      > -    /* TODO: i2c-7: Add PDB FRU eeprom@52 */
>      > -    /* TODO: i2c-8: Add BMC FRU eeprom@50 */
>      > +    /* PDB FRU */
>      > +    at24c_eeprom_init(aspeed_i2c_get_bus(&soc->i2c, 7), 0x52, 8192);
>      > +    /* BMC FRU */
>      > +    at24c_eeprom_init(aspeed_i2c_get_bus(&soc->i2c, 8), 0x50, 8192);
>      >   }
>      >
>      >   static void ast2500_evb_i2c_init(AspeedMachineState *bmc)
>      >
> 


