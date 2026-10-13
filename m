Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 883D6CC6B0E
	for <qemu-devel@archiver.kernel.org>; Tue, 13 Oct 2026 06:24:19 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xGVvM-0002L5-5N; Tue, 13 Oct 2026 02:23:44 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@kaod.org>) id 1xGVvL-0002Kj-Ah
 for qemu-devel@nongnu.org; Tue, 13 Oct 2026 02:23:43 -0400
Received: from smtpout2.mo538.mail-out.ovh.net ([51.210.91.31])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@kaod.org>) id 1xGVvG-0003D9-Eh
 for qemu-devel@nongnu.org; Tue, 13 Oct 2026 02:23:43 -0400
Received: from director4.derp.mail-out.ovh.net
 (director4.derp.mail-out.ovh.net [79.137.60.37])
 by mo538.mail-out.ovh.net (Postfix) with ESMTPS id 4j3kmj3Q7Zz6DMm;
 Tue, 13 Oct 2026 06:23:33 +0000 (UTC)
Received: from director4.derp.mail-out.ovh.net
 (director4.derp.mail-out.ovh.net. [127.0.0.1])
 by director4.derp.mail-out.ovh.net (inspect_sender_mail_agent) with SMTP
 for <jamin_lin@aspeedtech.com>; Tue, 13 Oct 2026 06:23:33 +0000 (UTC)
Received: from mta3.priv.ovhmail-u2.ea.mail.ovh.net (unknown [10.110.43.121])
 by director4.derp.mail-out.ovh.net (Postfix) with ESMTPS id
 4j3kmj2VVkz1xsg; Tue, 13 Oct 2026 06:23:33 +0000 (UTC)
Received: from kaod.org (unknown [10.1.6.6])
 (Authenticated sender: clg@kaod.org)
 by mta3.priv.ovhmail-u2.ea.mail.ovh.net (Postfix) with ESMTPSA id 0AA3A12E2CA5;
 Tue, 13 Oct 2026 06:23:30 +0000 (UTC)
Authentication-Results: garm.ovh; auth=pass
 (GARM-95G001101991f0-76b3-4923-a3c7-3bd7c9a9549c,
 3B5152602AE6D76A7CF2E50DC6ABDDC767F0B630) smtp.auth=clg@kaod.org
X-OVh-ClientIp: 82.64.250.170
Message-ID: <d7da10db-04a0-4699-8a96-44e98170f863@kaod.org>
Date: Tue, 13 Oct 2026 08:23:30 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 00/50] Aspeed: I2C device models and the Minerva BMC
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
 Glenn Miles <milesg@linux.ibm.com>
References: <20261012-bmc-minerva-v2-0-4c3dff084ec9@free.fr>
From: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@kaod.org>
Content-Language: en-US, fr
Autocrypt: addr=clg@kaod.org; keydata=
 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
In-Reply-To: <20261012-bmc-minerva-v2-0-4c3dff084ec9@free.fr>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
x-ovh-tracer-id: 14872293346313219117
X-VR-SPAMSTATE: OK
X-VR-SPAMSCORE: -100
X-VR-SPAMCAUSE: dmFkZTGsR1SnRACytQc0NGF7FSqE9sZNU8A81DgnygkAPZaCGromvBWRrw8xfYYlSnPAdGRMRykuQb8PuTZeTuDxdu725vWpM5azDf3or+/Hh9DLwR8Fjb2ViNBkiC9dQIsUjbdgyyUX8lxKIU0KBpho1+IYpTdnKZkXOTkLZX0/Fx45An4bZ25ovKvHaj40UUQCWlV9XsGXxxCuZB7eqai2ff0XV1R/+L7+fJzlheBm1/lFQ7uiLNdo7btyQ9SD4DxjsezIqqFHDjVDFMh4fiaLwKWPFXoWsgoKss/Woty3r/5NqVeV26jkg3eLK3f6Wp4jiMuRt/iqAIKQrSFK94DhU9hdrmo9ZUC3DVYQp2wN7KYjB8S586avGwPyv7LKotnu68ZfPhUPJgd3BVb7PeWm3vLJC3STVOiYBDGVerBPFHDNzbJDSrDHFytDaOedAVVZK0gr/vL6vxe9EglOu9nnf06+mIRsarzBzBDfmJADfDdswpjrkDQYJGpq0GqzNiQPRZJODrCOhYTGOpcIkZt3kny/35g0Ld484c7sWi6cnVIkMTDlqV/tN/hNlb6BSVi3ykTloKEGzvmIonzAYCRviiM6lPj6qmvsFckTeCsjdqjNaIgUqydNh+xpVraW8d0h6PdD0iJlcM/rqBZyL/RpukAI/rsmizmHRF/FgBPTAsgDeQ
DKIM-Signature: a=rsa-sha256; bh=xIpNob5sMR/aTwPuzB73gteOWDRrzriqP5CypP/2sJc=; 
 c=relaxed/relaxed; d=kaod.org; h=From; s=ovhmo393970-selector1;
 t=1791872615; v=1;
 b=ZHFDqIeJpIr7jkVAe0T4euQ24lLWQyChEcNnz2xPOgOeUPsgrhOuNS13ly4Yxzhw6Yh/EAz8
 wZY8gaRJN127E2P8gKGIv4vu22FESmiyPkTmByrDo504ykTxDio5hK0wERfltFJTWrR2W+c57Fs
 8p9AZJwxruPXEDDWqBkLfl+P+euQoPAhcqaF/o2grJGiZImx5VB+HU8mBUvFUgILDzaJwf541tg
 J1PI4b+Nu0YkZEZGyrTaWGSeiMTkWo0qx96cYc769K+QoTvkX9gw8eTYfHsrF53D2IU6Xw7TjW/
 ghnceGwJTISiZqw3kbfYlfcuRLAEWsh3wWN1Z6fGwHBqA==
Received-SPF: pass client-ip=51.210.91.31; envelope-from=clg@kaod.org;
 helo=smtpout2.mo538.mail-out.ovh.net
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

Jamin, Glenn,

Could you please help reviewing some patches of this series ?

Thanks,

C.



On 10/12/26 16:31, Emmanuel Blot wrote:
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


