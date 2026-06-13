Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E0177CD98C5
	for <qemu-devel@archiver.kernel.org>; Sat, 13 Jun 2026 17:08:40 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wYRph-000307-A4; Sat, 13 Jun 2026 13:07:45 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@kaod.org>)
 id 1wYRpe-0002zY-U5; Sat, 13 Jun 2026 13:07:42 -0400
Received: from smtpout1.mo2.mail-out.ovh.net ([79.137.123.219])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@kaod.org>)
 id 1wYRpb-0002zK-UM; Sat, 13 Jun 2026 13:07:42 -0400
Received: from director6.derp.mail-out.ovh.net
 (director6.derp.mail-out.ovh.net [51.255.22.22])
 by mo2.mail-out.ovh.net (Postfix) with ESMTPS id 4gd2qy3rTqz3xm6;
 Sat, 13 Jun 2026 17:07:26 +0000 (UTC)
Received: from director6.derp.mail-out.ovh.net
 (director6.derp.mail-out.ovh.net. [127.0.0.1])
 by director6.derp.mail-out.ovh.net (inspect_sender_mail_agent) with SMTP
 for <alexander.hansen@9elements.com>; Sat, 13 Jun 2026 17:07:26 +0000 (UTC)
Received: from mta2.priv.ovhmail-u2.ea.mail.ovh.net (unknown [10.110.113.201])
 by director6.derp.mail-out.ovh.net (Postfix) with ESMTPS id
 4gd2qy1l0Wz7tfx; Sat, 13 Jun 2026 17:07:26 +0000 (UTC)
Received: from kaod.org (unknown [10.1.6.1])
 (Authenticated sender: clg@kaod.org)
 by mta2.priv.ovhmail-u2.ea.mail.ovh.net (Postfix) with ESMTPSA id 5AEB494185B; 
 Sat, 13 Jun 2026 17:07:24 +0000 (UTC)
Authentication-Results: garm.ovh; auth=pass
 (GARM-104R005d77942aa-0a88-40ea-a392-85870eee6b07,
 E2CD3F290BDA47254B2896B828795FC85CEB7E2E) smtp.auth=clg@kaod.org
X-OVh-ClientIp: 82.64.250.170
Message-ID: <cce4022e-70dc-4da4-9a9f-b234f1cc0484@kaod.org>
Date: Sat, 13 Jun 2026 19:07:23 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/4] hw/sensor: Add new device emulation for TI ADC128D818
To: Emmanuel Blot <eblot@meta.com>, qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@mailo.com>,
 Fabiano Rosas <farosas@suse.de>, Laurent Vivier <lvivier@redhat.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 Steven Lee <steven_lee@aspeedtech.com>, Troy Lee <leetroy@gmail.com>,
 Jamin Lin <jamin_lin@aspeedtech.com>, Kane Chen <kane_chen@aspeedtech.com>,
 Andrew Jeffery <andrew@codeconstruct.com.au>, Joel Stanley <joel@jms.id.au>,
 Alexander Hansen <alexander.hansen@9elements.com>,
 William de Abreu Pinho <williampinho@meta.com>, qemu-arm@nongnu.org
References: <20260612-i2c-adc128d818-anacapa-v1-0-9e4640cd164b@meta.com>
Content-Language: en-US, fr
From: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@kaod.org>
Autocrypt: addr=clg@kaod.org; keydata=
 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
In-Reply-To: <20260612-i2c-adc128d818-anacapa-v1-0-9e4640cd164b@meta.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
x-ovh-tracer-id: 10254133401682750509
X-VR-SPAMSTATE: OK
X-VR-SPAMSCORE: -100
X-VR-SPAMCAUSE: dmFkZTEvfIt8JwNSuJsJRvAgT7fgBGMqTYkK8E1YP7+yrlZyGOV6sorhbcE9Wz+GKJeMWTMjoGqkopc5jNG6Yxww+NCnKFgZdCasGW+eFmj4OEq+Z3npa6XyBQWJRbrdQjPYu1pXYJqEgNju1sjDtt2n2d5pX/LVIM67ltJYdSPsv7+Arf/BV1gH7lqGfCw9qnvmrpp4wyQuKwgcd89SS5gIYvp/dAOWwkc4mxxxc999qFfCOnuOljwVp/LU4nQAzmDXh4KoxJeHiUImKCn6M0GdLQqDRzAC8JIDi+lCuTwbVgQdDlpTUddbL9Vw3x+zuGWYwQGNMr95b8CXVOnbzjgRgLijDoKiZtsbdBkQIh4pjYTe4TBARCGF/I+Tlx8H/36xUZhtmXPJXK3ebhCbgnVhmfA4JdJrLF68SaUgJ12miHdP9Y2knZF9I1pvFDha1hgU4hUCpjqqEqemgGhLaQYjCRpYPaRkPkzqpfkcHud0eC4vlBzTomEbc4csvuBaibDbbpvG2pFqF7GnbuG62g6UfjtFSppXhBXTvCshA7sYVGuqcU+OBCELqjG/W8G6KGCNwpaIBhHarWO03MWqIyd3+MPet0DRHLaR2iL/IGrT7lhoMpQF6Y0svAWspHaSJQuxZ6MiD1ZJuJbPM2NaRUI/epsH80giZs4VHzqEFImFrAe+HA
DKIM-Signature: a=rsa-sha256; bh=qQWMHGRvyy8EOIr9NWl6O7EzYWwdnhLtEe/Oof+w2L8=; 
 c=relaxed/relaxed; d=kaod.org; h=From; s=ovhmo393970-selector1;
 t=1781370448; v=1;
 b=bICKJOSZJdeMWwqGEyyrwBM1ltJaOYoaGXBD9jAHrmtVfPZqJHT1E6UmHA/Nzq651+lh8QaD
 JPlhYhokVJVfOsbCjlgpV7+qljpeoMrUZWsCFfWwLNruTlCRJRJCKF7yv5Tq/xqniwIsX5+cn/6
 AKSFGGqGJXFg3QwIhLGEg8IFQ45znGiw5GV3vzuBuL916Z10CdDLkO+OR7hcwjXo7+03/XZyR9V
 A7+VaW8CLEfLMxFoE+vm2DkNoOgi7QHrHbxLzplLp+B/rTJt6hrzlp+J/w55oeGhQkMvzKA6FWx
 5SWcFFbUxM942wrz+uDtGQTi7b4tctPkbkvoWMwO5IpSw==
Received-SPF: pass client-ip=79.137.123.219; envelope-from=clg@kaod.org;
 helo=smtpout1.mo2.mail-out.ovh.net
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

On 6/12/26 18:46, Emmanuel Blot wrote:
> This is a 12-bit, 8-channel ADC I2C device, which is used on several
> OpenBMC platforms.
> 
> QOM properties can be used to change input ADC values and external VREF at
> run time.
> 
> Add it to AST2600-based Anacapa machine, along with some functional tests
> that use QOM properties to inject voltage values into analog inputs.
> 
> Datasheet: https://www.ti.com/lit/gpn/ADC128D818
> 
> Signed-off-by: Emmanuel Blot <eblot@meta.com>
> ---
> Emmanuel Blot (4):
>        hw/sensor: adc128d818: add 12-bit 8-channel ADC device
>        tests/qtest: adc128d818: add test suite
>        hw/arm: anacapa: add ADC128D818 devices
>        test/functional: anacapa: test ADC128D818
> 
>   hw/arm/Kconfig                              |   1 +
>   hw/arm/aspeed_ast2600_anacapa.c             |  19 +-
>   hw/sensor/Kconfig                           |   4 +
>   hw/sensor/adc128d818.c                      | 703 +++++++++++++++++++++++
>   hw/sensor/meson.build                       |   1 +
>   hw/sensor/trace-events                      |   8 +
>   include/hw/sensor/adc128d818.h              |  12 +
>   tests/functional/arm/test_aspeed_anacapa.py |  92 ++-
>   tests/qtest/adc128d818-test.c               | 855 ++++++++++++++++++++++++++++
>   tests/qtest/meson.build                     |   1 +
>   10 files changed, 1688 insertions(+), 8 deletions(-)
> ---
> base-commit: 193963218accbcf65f28ab1efa773ac6d1cc634c
> change-id: 20260612-i2c-adc128d818-anacapa-13c63e97fbd0
> 
> Best regards,
> --
> Emmanuel Blot <eblot@meta.com>
Alexander,

This proposal offers significant advantages over your v6.

  - instead of adc128d818_init_with_values, it uses QOM properties for
    run time values.
  - reset is better
  - unit tests

This implementation seems a better foundation. If you agree, could
you please take some time to review it ? Given your expertise, you
seem to be the best person for it.


Thanks,

C.


