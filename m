Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 898B2C44501
	for <qemu-devel@archiver.kernel.org>; Thu, 16 Jul 2026 06:47:08 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wkFri-0002dD-Hr; Thu, 16 Jul 2026 02:46:38 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@kaod.org>)
 id 1wkFrg-0002cd-7u; Thu, 16 Jul 2026 02:46:36 -0400
Received: from smtpout8.mo540.mail-out.ovh.net ([51.210.91.57])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@kaod.org>)
 id 1wkFre-00044Z-Cs; Thu, 16 Jul 2026 02:46:36 -0400
Received: from director6.derp.mail-out.ovh.net
 (director6.derp.mail-out.ovh.net [51.255.22.22])
 by mo540.mail-out.ovh.net (Postfix) with ESMTPS id 4h13VH2NL8z44kN;
 Thu, 16 Jul 2026 06:46:31 +0000 (UTC)
Received: from director6.derp.mail-out.ovh.net
 (director6.derp.mail-out.ovh.net. [127.0.0.1])
 by director6.derp.mail-out.ovh.net (inspect_sender_mail_agent) with SMTP
 for <jamin_lin@aspeedtech.com>; Thu, 16 Jul 2026 06:46:31 +0000 (UTC)
Received: from mta6.priv.ovhmail-u2.ea.mail.ovh.net (unknown [10.110.101.119])
 by director6.derp.mail-out.ovh.net (Postfix) with ESMTPS id
 4h13VH1HfTz7tKG; Thu, 16 Jul 2026 06:46:31 +0000 (UTC)
Received: from kaod.org (unknown [10.1.6.4])
 (Authenticated sender: clg@kaod.org)
 by mta6.priv.ovhmail-u2.ea.mail.ovh.net (Postfix) with ESMTPSA id 3C0E41B43DCE;
 Thu, 16 Jul 2026 06:46:29 +0000 (UTC)
Authentication-Results: garm.ovh; auth=pass
 (GARM-103G005abea7d08-9de3-4a43-8ff8-02b4d7d8a0f9,
 816DE1EE18DD2826DFD8B9EE289546F56902E1FE) smtp.auth=clg@kaod.org
X-OVh-ClientIp: 82.64.250.170
Message-ID: <70dd891e-0701-4cec-8710-c5f1ece0d2b1@kaod.org>
Date: Thu, 16 Jul 2026 08:46:28 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 00/29] hw/arm: improve Aspeed Catalina BMC emulation
To: Emmanuel Blot <emmanuel.blot@free.fr>, qemu-devel@nongnu.org
Cc: Glenn Miles <milesg@linux.ibm.com>, qemu-ppc@nongnu.org,
 qemu-arm@nongnu.org, Fabiano Rosas <farosas@suse.de>,
 Laurent Vivier <lvivier@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 Steven Lee <steven_lee@aspeedtech.com>, Troy Lee <leetroy@gmail.com>,
 Jamin Lin <jamin_lin@aspeedtech.com>, Kane Chen <kane_chen@aspeedtech.com>,
 Andrew Jeffery <andrew@codeconstruct.com.au>, Joel Stanley <joel@jms.id.au>,
 Corey Minyard <cminyard@mvista.com>
References: <20260709-catalina-upgrade-v1-0-814575bc076b@free.fr>
Content-Language: en-US, fr
From: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@kaod.org>
Autocrypt: addr=clg@kaod.org; keydata=
 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
In-Reply-To: <20260709-catalina-upgrade-v1-0-814575bc076b@free.fr>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
x-ovh-tracer-id: 9099241575135554605
X-VR-SPAMSTATE: OK
X-VR-SPAMSCORE: -100
X-VR-SPAMCAUSE: dmFkZTFUSO232/WH9w2OrNVjlUP33UX4h8SCSm/+y3x8WR3xanN/Pqll+ek/o3UnBw1Jcvv8uUiEREd2N2gjF13l1ZWiU39BfGygK/PSMNB/FlgRnqA6Ri7y90DOatxxi9tvkCqZAnupELzQvn2x/ifKlbyzzqltXcx1ddXIEYMRb4t0H4y6CN6/DPsH0LvMfU/sVsfSefd4qCrWtmpeldSCFA9fzpGuNXrf0thc1sJwToWtkJo0zQre2qLe5kw3lOJIWHGIKxXEjuDfXKGQ/gTOxnXSi6IxBBm859Ayj+WLafYjdeRZtZ7ud9Ec02kVn2sEl7DWtADz4C0LbadOY9z7BVmVEgCo9BgTCLTopaQhJmKguGMgmR0a9T41zrlVvwMnw4OSOlE0S4WB/1ZjukVSG7ahIhlurNRubDcGZSwv2kfzbCTxE6TaFDxQHOIcsM08I2O4j/8JsjCvvsn74bW1UPZ/9TpvBku5/8u+pPV591B+taQ67LyBNOwNqyBl31PMWswEVxVsLZ5PGXf7Nz1F4+ZNCHSb/xpGHm1UAACek4g0jj30hThY3lsBk8Tw/n94Ywt6kfLFSyPub5XT0eE+1adbUhqoZOZo69GpLgHER8WaAjycKI2yYQ125TryTCBoQLzRQYGFWTdPWaaNGOfgKbBLN/+9rbF1WWcXXfRRJ1RVZw
DKIM-Signature: a=rsa-sha256; bh=o8qYxlK/9HiS52/lu8XY1aRVbbwnLk/FMetVZnL/RSw=; 
 c=relaxed/relaxed; d=kaod.org; h=From; s=ovhmo393970-selector1;
 t=1784184391; v=1;
 b=Yf5mE/U9wdv7lbPJqJ1vNcuH4g1VAFkzUwvo+Avs6dfqrFLzJtRkQzIKJLYld1cQJCdl/RHM
 MGt7hDZH0I7O0l/3T0COIImyjLZRVxXpxgn8PdxqZdSLjMao5yDV10jVY4gJrXof4zLfUYbt5Mm
 tg2BExgRk/6QVLcae7YzKtw5PB7VPiGCjOBAwO6zLBwusNTjZQ1Xwa6I1oaFCX4xAtH05CgA1E8
 9VQxFOC6ToN6i3Hvkxv4wTxJkw6ZxU3HKAbJoJIa7qPBA4krLjqIosP23IKpxbvwi98xvceKQy5
 aj+CtakvbMSnjuCyk5dCpKAs9gxFQ68HC855A/Mo1GoNQ==
Received-SPF: pass client-ip=51.210.91.57; envelope-from=clg@kaod.org;
 helo=smtpout8.mo540.mail-out.ovh.net
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

Hello Glenn

Could you please help reviewing the pca changes ?

Thanks,

C.

On 7/9/26 17:23, Emmanuel Blot wrote:
> This series improves emulation of the Aspeed-based Catalina BMC machine,
> mostly around its I2C buses: the GPIO expanders the board relies on and
> the temperature sensors sitting next to them.
> 
> The bulk of the work is on the PCA95xx I/O expander models. The existing
> PCA9552 and PCA9554 drivers only really covered the exact parts a couple
> of boards happened to use, and some of their register and pin behaviour
> did not match the datasheets. Catalina needs a few more variants and
> expects them to act like the real chips, so:
> 
>   - the PCA9552 driver now provides proper PCA9555/PCA9535 types, applies
>     input polarity inversion on reads, and handles the command register
>     as the datasheet describes (auto-increment and wrapping);
> 
>   - the PCA9554 driver gains the 4-bit PCA9536 variant, reflects
> push-pull
>     outputs back into the input register, and grows an opt-in mode that
>     honours the configured pin direction instead of forcing pins to
>     outputs;
> 
>   - both drivers expose each line as a "pinN" QOM property, which lets an
>     external actor drive an input pin. The property also allows reading
>     the value driven onto an output-configured pin, which is the more
>     useful capability, but nothing exercises it yet.
> 
> Along the way both models get a fair bit of cleanup (DEFINE_TYPES, the
> Resettable interface, state moved out of the headers, default
> descriptions derived from the instantiated type).
> 
> On the machine itself, Catalina now instantiates its PCA9555 expanders
> as their own type, gains the NIC and FIO temperature sensors present on
> real hardware, and drives the pca9554 expander input pins from outside
> the guest.
> 
> Finally, the register-level behaviour of both expanders is covered by
> new qtests, and the functional test that boots the OpenBMC image now
> exercises the expanders end to end, both through QOM and through the
> guest's gpio tooling.
> 
> Note that the "hw/i2c: parent slaves created with
> i2c_slave_create_simple"
> patch is only a temporary dependency here: it already belongs to the
> separate ADC128D818 series currently under review, and will be dropped
> from this series before it is submitted for final review.
> 
> Signed-off-by: Emmanuel Blot <emmanuel.blot@free.fr>
> ---
> Emmanuel Blot (29):
>        hw/gpio: pca9552: register types with DEFINE_TYPES()
>        hw/gpio: pca9552: move PCA955xState definition out of the header
>        hw/gpio: pca9552: rename I2CSlave member to parent_obj
>        hw/gpio: pca9552: default description to the instantiated type name
>        hw/gpio: pca9552: declare pca9555 device as an alias of pca9535 device
>        hw/gpio: pca9552: use the Resettable interface instead of legacy reset
>        hw/gpio: pca9552: apply input polarity inversion on read
>        hw/gpio: pca9552: conform GPIO command handling to the datasheet
>        hw/gpio: pca9552: expose GPIO pins as pin%d QOM properties
>        tests/qtest: add PCA9555 register access tests
>        tests/qtest: pca9555: test output-to-input reflection and pull-ups
>        tests/qtest: pca9555: test polarity inversion
>        tests/qtest: pca9555: test auto-increment and command wrapping
>        tests/qtest: pca9552: test behaviour specific to the LED variant
>        hw/gpio: pca9554: add PCA9536 support
>        hw/gpio: pca9554: add hw-dir property honoring the configured pin direction
>        hw/gpio: pca9554: reflect push-pull outputs in the input register
>        hw/gpio: pca9554: expose pin%d as a string property
>        tests/qtest: add PCA9554 register access tests
>        tests/qtest: pca9554: test output-to-input reflection and pull-ups
>        tests/qtest: pca9554: test polarity inversion
>        tests/qtest: pca9554: test absence of command auto-increment
>        tests/qtest: pca9554: test the PCA9536 4-bit variant
>        hw/arm: catalina: model PCA9555 IO expanders with their own type
>        hw/arm: catalina: add NIC and FIO temperature sensors
>        hw/i2c: parent slaves created with i2c_slave_create_simple
>        test/functional: catalina: test PCA9555 IO expander via QOM
>        hw/arm: catalina: drive pca9554 io expander input pins externally
>        test/functional: catalina: test PCA9554 IO expander via QOM
> 
>   hw/arm/aspeed_ast2600_catalina.c             |  67 ++++---
>   hw/gpio/pca9552.c                            | 256 ++++++++++++++++++++-------
>   hw/gpio/pca9554.c                            | 175 ++++++++++--------
>   hw/i2c/core.c                                |   3 +
>   include/hw/gpio/pca9552.h                    |  31 +---
>   include/hw/gpio/pca9554.h                    |   3 +
>   include/hw/i2c/i2c.h                         |   7 +-
>   tests/functional/arm/test_aspeed_catalina.py |  81 +++++++++
>   tests/qtest/meson.build                      |   2 +
>   tests/qtest/pca9552-test.c                   |  76 ++++++++
>   tests/qtest/pca9554-test.c                   | 223 +++++++++++++++++++++++
>   tests/qtest/pca9555-test.c                   | 251 ++++++++++++++++++++++++++
>   12 files changed, 994 insertions(+), 181 deletions(-)
> ---
> base-commit: f893c46c3931b3684d235d221bf8b7844ddbf1d7
> change-id: 20260703-catalina-upgrade-3eae7d9d7289
> 
> Best regards,
> --
> Emmanuel Blot <emmanuel.blot@free.fr>
> 


