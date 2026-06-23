Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1C5F6CDB471
	for <qemu-devel@archiver.kernel.org>; Tue, 23 Jun 2026 18:42:55 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wc64k-0001ep-GQ; Tue, 23 Jun 2026 14:42:22 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@kaod.org>)
 id 1wc64c-0001cx-Th; Tue, 23 Jun 2026 14:42:15 -0400
Received: from smtpout6.mo540.mail-out.ovh.net ([51.210.91.55])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@kaod.org>)
 id 1wc64Z-0000mP-0K; Tue, 23 Jun 2026 14:42:14 -0400
Received: from director4.derp.mail-out.ovh.net
 (director4.derp.mail-out.ovh.net [79.137.60.37])
 by mo540.mail-out.ovh.net (Postfix) with ESMTPS id 4glDST1Vqjz430D;
 Tue, 23 Jun 2026 18:42:01 +0000 (UTC)
Received: from director4.derp.mail-out.ovh.net
 (director4.derp.mail-out.ovh.net. [127.0.0.1])
 by director4.derp.mail-out.ovh.net (inspect_sender_mail_agent) with SMTP
 for <alexander.hansen@9elements.com>; Tue, 23 Jun 2026 18:42:01 +0000 (UTC)
Received: from mta7.priv.ovhmail-u2.ea.mail.ovh.net (unknown [10.110.58.197])
 by director4.derp.mail-out.ovh.net (Postfix) with ESMTPS id
 4glDST07nFz1xsy; Tue, 23 Jun 2026 18:42:01 +0000 (UTC)
Received: from kaod.org (unknown [10.1.6.5])
 (Authenticated sender: clg@kaod.org)
 by mta7.priv.ovhmail-u2.ea.mail.ovh.net (Postfix) with ESMTPSA id 21040203CC9; 
 Tue, 23 Jun 2026 18:41:59 +0000 (UTC)
Authentication-Results: garm.ovh; auth=pass
 (GARM-97G002f4622ca0-0daf-49a3-a5b7-2599f5dbd64e,
 0AE77E709300274C99BF9881F83903E4D0D493D9) smtp.auth=clg@kaod.org
X-OVh-ClientIp: 90.14.253.154
Message-ID: <3627ea09-2ce0-45cf-a5b9-8e7ff5f2a721@kaod.org>
Date: Tue, 23 Jun 2026 20:41:53 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 2/4] tests/qtest: adc128d818: add test suite
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
References: <20260617-i2c-adc128d818-anacapa-v2-0-fd38764f0465@meta.com>
 <20260617-i2c-adc128d818-anacapa-v2-2-fd38764f0465@meta.com>
Content-Language: en-US, fr
From: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@kaod.org>
Autocrypt: addr=clg@kaod.org; keydata=
 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
In-Reply-To: <20260617-i2c-adc128d818-anacapa-v2-2-fd38764f0465@meta.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
x-ovh-tracer-id: 15238210818431757357
X-VR-SPAMSTATE: OK
X-VR-SPAMSCORE: -100
X-VR-SPAMCAUSE: dmFkZTEi07Ul3Mj64JVHqNRhq6r52MukU0e4IEbXOwVC5sbJR42a2ToFoeNw+izWhGgCkZYw9BbvDkejNC2b3DlwC0T2wpLemFvTYV2DwOQeBkJQBcj5PzWrMNUgSYeuxqGrHoddv4gDE7oqJQ6eKtlRW/o7bmFl5b3vIbBmT7gKj8dwCqtIUEy/SYa+QJjkmNV9CNcqgy9/apSkF5r1C5V96VfU9N76EA/Y+BD0wI4Z6gi0t4/R7Lf2tViBaxixsjA2eEAnlqEFsYQdIRQqXOT5Mz/7srfRULjuSfGESOWSCi905EsEfWJoYay36JdFERtn5+ZyM1CbY3g+2Rsi4eY5YtNDt2N3ObNOjebbAzRNVIhEVbp2hgPA6U2U3fCqI8wG8KhhodbrtEybx6yGi1zuUbTx+YPw7QljG9kfmWgNsRIXwn+SZKvZmitAbQgkeuIgAriI+EdG0rDc/o9iM9EJxC/RLWGHEmU5psMh57SIDTXECX9Ngk1XtuWgEeZelUNSgWw9J7WCwdhuaBWVv2/2TCSFIzwiUmRsFcDlyQO4tVjGEGqITzKnje4j8tkHmLd4Uei2Qds3bRGUqWRQz1EfX1Lk8nlkq/r4Xl4IAqpdEIB+tsV80qwm0AgG/e706wrtpuNgm8aliQ29QprWeOwyL7MUGc2OSQ1KCGPorptuIRQ8Wg
DKIM-Signature: a=rsa-sha256; bh=35XMLzLbH0o2al/s6RwuGSVCVYT/vJyCw2czmIZtaDo=; 
 c=relaxed/relaxed; d=kaod.org; h=From; s=ovhmo393970-selector1;
 t=1782240122; v=1;
 b=hXEslzIvKNARuxk2W5kg3+//jor2192UF+Z6VR/6c72hSkI/Q/vRk1F/LtIDTWfhrN86YdVD
 nSZzNiz0LwZhf5E6NFQjdguk8mJuj47jge1iLmuAQx64QOP4VFdjJBdmw+RpYeBBkWilPDdczG3
 +XP0IFK+642q7V/7Jb7E+tx7eng7y7tilLzCqh0yOZ07Ue8JgHoWqZkBky2JP6JDN2idGdXt8w5
 jd5dwAYBG87ftMvrcrJsQAhkIM9/5MLQmFLePonS0NRWbPmUfUhimSzK+1/1PnvzqWdGeGQtqHK
 V62X8TS7Z0d8b1Wh0IMSsknK7BJ+e5BdYnKEZY9iVC+KA==
Received-SPF: pass client-ip=51.210.91.55; envelope-from=clg@kaod.org;
 helo=smtpout6.mo540.mail-out.ovh.net
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

On 6/17/26 12:26, Emmanuel Blot wrote:
> Add QOS-based QTest coverage for the ADC128D818:
> 
>   - manufacturer and revision ID registers
>   - power-on-reset defaults
>   - software reset
>   - voltage conversion and edge cases
>   - all channels with distinct values simultaneously
>   - temperature conversion and edge cases
>   - external voltage reference
>   - per-channel interrupt status
>   - INT_CLEAR bit suppresses interrupt assertion
>   - channel disable prevents conversion
>   - one-shot conversion in shutdown mode
>   - deep shutdown blocks conversion
>   - BUSY_STATUS NOT_READY flag lifecycle
>   - operating mode selection
>   - mode 2 pseudo-differential pairs
>   - mode 3 mixed single-ended and differential
>   - mode-change reset of readings and interrupt status
>   - QOM-triggered reconversion
> 
> Signed-off-by: Emmanuel Blot <eblot@meta.com>
> ---
>   tests/qtest/adc128d818-test.c | 849 ++++++++++++++++++++++++++++++++++++++++++
>   tests/qtest/meson.build       |   1 +
>   2 files changed, 850 insertions(+)
> 
> diff --git a/tests/qtest/adc128d818-test.c b/tests/qtest/adc128d818-test.c
> new file mode 100644
> index 0000000000..f8a4ba1f50
> --- /dev/null
> +++ b/tests/qtest/adc128d818-test.c
> @@ -0,0 +1,849 @@
> +/*
> + * QTest testcase for the ADC128D818 ADC
> + *
> + * SPDX-License-Identifier: GPL-2.0-or-later
> + */
> +
> +#include "qemu/osdep.h"
> +#include "qemu/bitops.h"
> +#include "libqos/i2c.h"
> +#include "libqos/qgraph.h"
> +#include "libqtest-single.h"
> +#include "qobject/qdict.h"
> +
> +#define ADC128D818_TEST_ID      "adc128d818-test"
> +#define ADC128D818_TEST_ADDR    0x1F
> +
> +/* Register addresses */
> +#define REG_CONFIG              0x00u
> +#define REG_INT_STATUS          0x01u
> +#define REG_INT_MASK            0x03u
> +#define REG_CONV_RATE           0x07u
> +#define REG_CH_DISABLE          0x08u
> +#define REG_ONE_SHOT            0x09u
> +#define REG_DEEP_SHUTDOWN       0x0Au
> +#define REG_ADV_CONFIG          0x0Bu
> +#define REG_BUSY_STATUS         0x0Cu
> +
> +/* Channel Reading Registers (16-bit, read-only) */
> +#define REG_CH_READING_BASE     0x20u
> +
> +/* Limit Registers (8-bit, read/write) */
> +#define REG_LIMIT_BASE          0x2Au
> +
> +/* ID Registers (read-only) */
> +#define REG_MANUFACTURER_ID     0x3Eu
> +#define REG_REVISION_ID         0x3Fu
> +
> +/* Configuration Register (0x00) bitfields */
> +#define CONFIG_START            BIT(0)
> +#define CONFIG_INT_ENABLE       BIT(1)
> +#define CONFIG_INT_CLEAR        BIT(3)
> +#define CONFIG_INITIALIZATION   BIT(7)
> +
> +/* Advanced Configuration Register (0x0B) bitfields */
> +#define ADV_CONFIG_EXT_REF_EN   BIT(0)
> +#define ADV_CONFIG_MODE_1       (1u << 1u)
> +#define ADV_CONFIG_MODE_2       (2u << 1u)
> +#define ADV_CONFIG_MODE_3       (3u << 1u)
> +
> +/* Number of channels */
> +#define NUM_CHANNELS            8u
> +
> +/* Internal VREF in mV */
> +#define INTERNAL_VREF_MV        2560u
> +
> +/* TAP-compatible diagnostic output (g_test_message is silent in TAP mode) */
> +#define test_log(fmt, ...) \
> +    fprintf(stderr, "# " fmt "\n", ## __VA_ARGS__)


g_test_message() should be preferred

Thanks,

C.


