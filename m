Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 52D62606A31A
	for <qemu-devel@archiver.kernel.org>; Wed, 28 Oct 2026 09:10:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kaod.org header.i=@kaod.org header.a=rsa-sha256 header.s=ovhmo393970-selector1 header.b=UJKy+g5E
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xLzfI-0003ub-Gr; Wed, 28 Oct 2026 05:09:48 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@kaod.org>) id 1xLzfG-0003tk-GV
 for qemu-devel@nongnu.org; Wed, 28 Oct 2026 05:09:46 -0400
Received: from smtpout6.mo538.mail-out.ovh.net ([51.210.91.35])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@kaod.org>) id 1xLzfB-0004qr-UD
 for qemu-devel@nongnu.org; Wed, 28 Oct 2026 05:09:46 -0400
Received: from director3.derp.mail-out.ovh.net
 (director3.derp.mail-out.ovh.net [79.137.60.223])
 by mo538.mail-out.ovh.net (Postfix) with ESMTPS id 4jF1lP1zzhz5vWr;
 Wed, 28 Oct 2026 09:09:37 +0000 (UTC)
Received: from director3.derp.mail-out.ovh.net
 (director3.derp.mail-out.ovh.net. [127.0.0.1])
 by director3.derp.mail-out.ovh.net (inspect_sender_mail_agent) with SMTP
 for <jamin_lin@aspeedtech.com>; Wed, 28 Oct 2026 09:09:37 +0000 (UTC)
Received: from mta2.priv.ovhmail-u2.ea.mail.ovh.net (unknown [10.110.96.187])
 by director3.derp.mail-out.ovh.net (Postfix) with ESMTPS id
 4jF1lP0frzz1xpV; Wed, 28 Oct 2026 09:09:37 +0000 (UTC)
Received: from kaod.org (unknown [10.1.6.0])
 (Authenticated sender: clg@kaod.org)
 by mta2.priv.ovhmail-u2.ea.mail.ovh.net (Postfix) with ESMTPSA id 8CD8494207E; 
 Wed, 28 Oct 2026 09:09:34 +0000 (UTC)
Authentication-Results: garm.ovh; auth=pass
 (GARM-95G00188092313-06f7-458f-85c8-eb28ff4bc8c5,
 E08929C5676352A1F51837021B168DD299C323AB) smtp.auth=clg@kaod.org
X-OVh-ClientIp: 82.66.77.115
Message-ID: <f2a1f964-2cb1-4136-8780-3c2f7c4a2ef9@kaod.org>
Date: Wed, 28 Oct 2026 10:09:33 +0100
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 00/50] Aspeed: I2C device models and the Minerva BMC
 machine
To: Emmanuel Blot <emmanuel.blot@free.fr>, qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Steven Lee <steven_lee@aspeedtech.com>, Troy Lee <leetroy@gmail.com>,
 Jamin Lin <jamin_lin@aspeedtech.com>, Kane Chen <kane_chen@aspeedtech.com>,
 Andrew Jeffery <andrew@codeconstruct.com.au>, Joel Stanley <joel@jms.id.au>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>, qemu-arm@nongnu.org,
 Patrick Leis <venture@google.com>, Fabiano Rosas <farosas@suse.de>,
 Laurent Vivier <lvivier@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 qemu-ppc@nongnu.org, qemu-riscv@nongnu.org,
 =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>,
 Jamin Lin <jaminlin1207@gmail.com>, =?UTF-8?Q?C=C3=A9dric_Le_Goater?=
 <clg@redhat.com>, Bernhard Beschow <sgentey@gmail.com>,
 Glenn Miles <milesg@linux.ibm.com>
References: <20261015-bmc-minerva-v3-0-7d50c8a108e5@free.fr>
From: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@kaod.org>
Content-Language: en-US, fr
Autocrypt: addr=clg@kaod.org; keydata=
 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
In-Reply-To: <20261015-bmc-minerva-v3-0-7d50c8a108e5@free.fr>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
x-ovh-tracer-id: 13533598359034440749
X-VR-SPAMSTATE: OK
X-VR-SPAMSCORE: -100
X-VR-SPAMCAUSE: dmFkZTGO4L+nPAgUyPcWMUjPhnEuXZM1YgSrsutwEM5QNFwZxCPRgpKnKrdKrcKfXsVSTML4cbEP9NYAt+s1LB/wQtfZpT26aYf9JMANzlT2G2UEI/3y9mMnVXCcJjNuOCDFn7hd5KZGwG+SODhviAQkAxVmrQ4Rr30ZnlqwXwR0HP24jvLKc3axJTyNOJfUswg5FfX7LYg8pCK43wYAA2bwHluAvlyg6KszMErcH9xRiBAKAa2q9Dl3khPJwjRoE7IYT2xwxblaF6Qsn12lfLEjhbHAmfP0vQrOQIgQLeye1E8ioRrd5lm9WtC4UxDeFcJ5b60Fuz4NHtZmwl7f/ktHo5MKXVOOhGQbDIGcPo36cXfP8pN+Ivz4Afp6N0EHJmhSwcnV1Ma53M9b4PERS5Jmg9ThfOib+MfPGItRw1/U+F2wq8zbY1gizPbbGWrYS2rlG25efOJF4GiuvVmpUXtGXKVhDnp/mIIvG6OnWW2UJhKfIGXItLYUW/L8Vz+Lo1XryYb1fL+1ffiOHvLVZHl7GOpY9uLQ6RfJcCmc2moF75WTh/x1fLWz2ejAv5tSVbTasjdiw8BoPFMo/Pa0Nsf89ywAqSlavFwtodvf9wofARzupC1LKsgrqoRVeqG5qWo+XVAprGPimhDqz7kFlw1uydEE3pCzOf5EBDtbAYeFkr4Tqw
DKIM-Signature: a=rsa-sha256; bh=gs20Jp2jCCQ/ACrPHCq/82qaCTJOHplSBrcAzqQKr3o=; 
 c=relaxed/relaxed; d=kaod.org; h=From; s=ovhmo393970-selector1;
 t=1793178578; v=1;
 b=UJKy+g5EvkZVN7G2DVg67lp0XbifQ6sYdPutDkcDgbgdaEgdWFe7j5bP/+HazhQLfCcRcuS+
 7mWDR4oTo0X7runsC6jdJVBcVLkyKpCsos/2sbRdimwd1oh8cv0v8zEy1/1bNy/nB9wVNgNG61I
 Lm+E0qCnFk6Rn51ccutVZFkV/62ewcVVc+lqni2Oa9KoScuJjkTxcDttM+QXugzWVdr4xgj4DkB
 5u5670oEM0+pR82cb0rGdXhJoMabNmtiYEb2hR+bi39feA+Q+/SQmw3lw4n89EYv8m/bGzlFdu+
 Xb4RTROqot59TuKCP0xhb0ZEeIS8rZ31uo2obaJ50Xklg==
Received-SPF: pass client-ip=51.210.91.35; envelope-from=clg@kaod.org;
 helo=smtpout6.mo538.mail-out.ovh.net
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
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
X-Spam-Status: No, score=-22.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_PASS,SPF_PASS,USER_AGENT_SANE_1
	autolearn=unavailable autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On 10/15/26 11:27, Emmanuel Blot wrote:
> Add the minerva-bmc machine and the I2C device models it needs.
> 
> Based on master, at:
>    615ece3c40 ("Merge tag 'for-upstream' of
>    https://gitlab.com/bonzini/qemu into staging")
> 
> New models:
> 
>    INA230   TI 36V current-shunt and power monitor
>    INA238   TI 85V current-shunt, power and temperature monitor
>    DS1339   RTC, a DS1338 variant
>    PCA9545  4-channel I2C mux with per-channel interrupt inputs
> 
> The INA devices derive current and power from the shunt voltage and
> their calibration registers. ALERT output is supported. Measurements
> come in through QOM properties; however, conversion delay is not
> modelled.
> 
> Introduce a device class to manage different variants of the DS1338
> register map, such as the DS1339. Improve the DS1338 implementation
> with a Resettable reset, support for the clock-halt bit, and a
> "persist-on-reset" property keeping the registers across a reset.
> 
> The minerva-bmc machine is derived from the platform device tree and
> instantiates every device that is supported in QEMU. FRU EEPROMs are
> sanitised images taken from real hardware.
> 
> New qtests for the DS1339, INA230, INA238 and PCA9545, plus DS1338
> cases for the register map, and a functional test booting OpenBMC on
> minerva-bmc.
> 
> The docs now mention the previously missing catalina-bmc and
> sanmiguel-bmc machines, and the title has been simplified.
> 
> One thing worth a second opinion: the PCA954x muxes now have a
> VMStateDescription, which changes the migration stream for the
> existing PCA9546 and PCA9548. The DS1338 vmstate also goes from
> version 2 to 3, but older streams still load fine.
> 
> Signed-off-by: Emmanuel Blot <emmanuel.blot@free.fr>
> ---
> Changes in v3:
> - ina230: drop a stray comment in the operating-modes test.
> - Link to v2: https://lore.kernel.org/qemu-devel/20261012-bmc-minerva-v2-0-4c3dff084ec9@free.fr
> 
> Changes in v2:
> - Rebase onto master, which now contains the v1 base.
> - minerva: drop ASPEED_RAM_SIZE, removed upstream.
> - No other changes; v1 received no review comments.
> - Link to v1: https://lore.kernel.org/qemu-devel/20260907-bmc-minerva-v1-0-0d83ad610c3b@free.fr
> 
> ---
> Emmanuel Blot (50):
>        docs/system/arm/aspeed: add the catalina-bmc machine
>        docs/system/arm/aspeed: add the sanmiguel-bmc machine
>        hw/arm: sanmiguel: remove the second SPI flash controller
>        hw/i2c: pca954x: drop unused header inclusions
>        hw/i2c: pca954x: add PCA9545 4-channel mux model
>        hw/i2c: pca954x: migrate mux state
>        tests/qtest: pca9545: add mux test
>        hw/rtc: ds1338: move TYPE_DS1338 to a public header
>        hw: ds1338: use the TYPE_DS1338 constant instead of the "ds1338" string
>        hw/rtc: ds1338: implement Resettable reset
>        hw/rtc: ds1338: prefix the file-local helpers with ds1338_
>        hw/rtc: ds1338: parameterise the register map via a device class

Applied 1-12 to

     https://github.com/legoater/qemu aspeed-next


The rest still needs review.

Thanks,

C.



>        hw/rtc: ds1338: program the clock from the time registers
>        hw/rtc: ds1338: implement the DS1338 clock-halt bit
>        hw/rtc: ds1338: refresh the user registers on a read rollover only
>        hw/rtc: ds1338: add a persist-on-reset property
>        tests/qtest: ds1338: cover the DS1338-specific register map
>        tests/qtest: ds1338: cover the power-on register defaults
>        tests/qtest: ds1338: cover the clock-halt bit
>        tests/qtest: ds1338: cover persist-on-reset
>        tests/qtest: ds1338: cover the reserved bits of the time registers
>        hw/rtc: ds1338: add DS1339 variant
>        tests/qtest: ds1339: add RTC test
>        tests/qtest: ds1339: cover power-on defaults and reserved-bit masking
>        tests/qtest: ds1339: cover oscillator stop/restart and time programming
>        tests/qtest: ds1339: cover the Century bit
>        tests/qtest: ds1339: cover the end-of-month rollover
>        tests/qtest: ds1339: cover the 12-hour format
>        tests/qtest: ds1339: cover the day-of-week counter
>        tests/qtest: ds1339: cover persist-on-reset
>        tests/qtest: ds1339: cover the migration round trip
>        hw/sensor: ina230: add current/voltage/power monitor
>        tests/qtest: ina230: add current/voltage/power monitor test
>        tests/qtest: ina230: cover voltage injection and power derivation
>        tests/qtest: ina230: cover the ALERT limit functions and CVRF
>        tests/qtest: ina230: cover the injection-property limits
>        tests/qtest: ina230: cover operating modes and triggered conversions
>        tests/qtest: ina230: cover ALERT latch persistence
>        tests/qtest: ina230: cover a cleared calibration per channel
>        hw/sensor: ina238: add current/voltage/power monitor
>        tests/qtest: ina238: add current/voltage/power monitor test
>        tests/qtest: ina238: cover voltage/temperature injection and derivation
>        tests/qtest: ina238: cover the ALERT path and conversion-ready flag
>        tests/qtest: ina238: cover the injection-property limits
>        tests/qtest: ina238: cover the operating modes
>        tests/qtest: ina238: cover conversion-ready and alert-latch semantics
>        tests/qtest: ina238: cover a cleared calibration per channel
>        hw/arm: minerva: add Facebook BMC machine
>        hw/arm: minerva: populate EEPROM data
>        tests/functional/arm: minerva: add BMC boot test
> 
>   docs/system/arm/aspeed.rst                  |   7 +-
>   hw/arm/Kconfig                              |   2 +
>   hw/arm/aspeed_ast2400_palmetto.c            |   4 +-
>   hw/arm/aspeed_ast2400_supermicrox11.c       |   4 +-
>   hw/arm/aspeed_ast2500_romulus.c             |   4 +-
>   hw/arm/aspeed_ast2500_supermicro-x11spi.c   |   4 +-
>   hw/arm/aspeed_ast2500_witherspoon.c         |   4 +-
>   hw/arm/aspeed_ast2600_bletchley.c           |   3 +-
>   hw/arm/aspeed_ast2600_catalina.c            |   2 +-
>   hw/arm/aspeed_ast2600_minerva.c             | 856 ++++++++++++++++++++++++++++
>   hw/arm/aspeed_ast2600_sanmiguel.c           |   7 +-
>   hw/arm/meson.build                          |   1 +
>   hw/arm/realview.c                           |   3 +-
>   hw/arm/versatilepb.c                        |   3 +-
>   hw/i2c/i2c_mux_pca954x.c                    |  98 +++-
>   hw/ppc/e500.c                               |   3 +-
>   hw/riscv/tt_atlantis.c                      |   3 +-
>   hw/rtc/ds1338.c                             | 427 +++++++++++---
>   hw/sensor/Kconfig                           |   8 +
>   hw/sensor/ina230.c                          | 597 +++++++++++++++++++
>   hw/sensor/ina238.c                          | 802 ++++++++++++++++++++++++++
>   hw/sensor/meson.build                       |   2 +
>   hw/sensor/trace-events                      |  14 +
>   include/hw/i2c/i2c_mux_pca954x.h            |   1 +
>   include/hw/rtc/ds1338.h                     |  21 +
>   include/hw/sensor/ina230.h                  |  14 +
>   include/hw/sensor/ina238.h                  |  14 +
>   tests/functional/arm/meson.build            |   2 +
>   tests/functional/arm/test_aspeed_minerva.py |  30 +
>   tests/qtest/ds1338-test.c                   | 191 ++++++-
>   tests/qtest/ds1339-test.c                   | 581 +++++++++++++++++++
>   tests/qtest/ina230-test.c                   | 602 +++++++++++++++++++
>   tests/qtest/ina238-test.c                   | 806 ++++++++++++++++++++++++++
>   tests/qtest/meson.build                     |   4 +
>   tests/qtest/pca9545-test.c                  | 116 ++++
>   35 files changed, 5125 insertions(+), 115 deletions(-)
> ---
> base-commit: 615ece3c406b262996e569f29ea6eed0d81c4d8d
> change-id: 20260907-bmc-minerva-cd13a718c90b
> 
> Best regards,
> --
> Emmanuel Blot <emmanuel.blot@free.fr>


