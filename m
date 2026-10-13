Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8313ACC6B12
	for <qemu-devel@archiver.kernel.org>; Tue, 13 Oct 2026 16:28:35 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xGfLf-0005JQ-Nw; Tue, 13 Oct 2026 12:27:31 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@kaod.org>) id 1xGfL5-00053L-TS
 for qemu-devel@nongnu.org; Tue, 13 Oct 2026 12:26:56 -0400
Received: from smtpout7.mo540.mail-out.ovh.net ([51.210.91.56])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@kaod.org>) id 1xGfL2-00054G-Qa
 for qemu-devel@nongnu.org; Tue, 13 Oct 2026 12:26:55 -0400
Received: from director6.derp.mail-out.ovh.net
 (director6.derp.mail-out.ovh.net [79.137.60.226])
 by mo540.mail-out.ovh.net (Postfix) with ESMTPS id 4j408m4Nvcz45Gs;
 Tue, 13 Oct 2026 16:26:48 +0000 (UTC)
Received: from director6.derp.mail-out.ovh.net
 (director6.derp.mail-out.ovh.net. [127.0.0.1])
 by director6.derp.mail-out.ovh.net (inspect_sender_mail_agent) with SMTP
 for <jamin_lin@aspeedtech.com>; Tue, 13 Oct 2026 16:26:48 +0000 (UTC)
Received: from mta3.priv.ovhmail-u2.ea.mail.ovh.net (unknown [10.110.58.233])
 by director6.derp.mail-out.ovh.net (Postfix) with ESMTPS id
 4j408m3j5yz46ZX; Tue, 13 Oct 2026 16:26:48 +0000 (UTC)
Received: from kaod.org (unknown [10.1.6.5])
 (Authenticated sender: clg@kaod.org)
 by mta3.priv.ovhmail-u2.ea.mail.ovh.net (Postfix) with ESMTPSA id 2010912E2CA5;
 Tue, 13 Oct 2026 16:26:46 +0000 (UTC)
Authentication-Results: garm.ovh; auth=pass
 (GARM-114S008f6c41d8d-4abb-4f4b-ba2c-d03962947c14,
 3B5152602AE6D76A7CF2E50DC6ABDDC767F0B630) smtp.auth=clg@kaod.org
X-OVh-ClientIp: 82.64.250.170
Message-ID: <bc0899bb-734b-4288-903c-994ed648d6d2@kaod.org>
Date: Tue, 13 Oct 2026 18:26:45 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 07/50] tests/qtest: pca9545: add mux test
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
 <20261012-bmc-minerva-v2-7-4c3dff084ec9@free.fr>
From: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@kaod.org>
Content-Language: en-US, fr
Autocrypt: addr=clg@kaod.org; keydata=
 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
In-Reply-To: <20261012-bmc-minerva-v2-7-4c3dff084ec9@free.fr>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
x-ovh-tracer-id: 6613536055656361005
X-VR-SPAMSTATE: OK
X-VR-SPAMSCORE: -100
X-VR-SPAMCAUSE: dmFkZTFJAA0Cff5mZHzxjOMf3vpdM/VfvcU3tzZqy3rh935Ggo91wXIdpJWVeOQBh0BtkSvpcDXPndRPnQDJ5NOOH3LTp7Nq6TOnz5gH/2/VElRGGUCKt+RHqpbTAnEaoqBeRCSlmVGALEzjKJy8O9LWHZZjTH8ta/3/Ns1/1dAtkg32q9bqR3JeX4KZeQ1ExBk2Xzh+zVJ5kZP+auzj5MEVRHRs1/p1H1NscUbI9FzfTnG2Wu2R/8O+EDjBsjafLViuNUeh8OdAkwN79Q2U1dqkbzpYq8JzfkLY8NR63te0LErTTbLj6jB1xH/iwK5utVdtxSHGcYHKT6mU1lwv9nag/pmKuA3kpvf+jJrll13BeptMffQ5vNb9ZnSDeGijfJSaTipHGBGuda8NuHxCIYuPzIqoLps5JXuUlq8QnrQXRvQGzCSPPgk2u1j6MzsyIwRHSMDG3/c6h6fMREFVUWMWBBnFkbKaQm0HPJgSfjVobPyJ1iKtS33AdLbaemHAchaLrsUhWLp/jK7fmA62cvK9xG6mXqoYl3gaCFgCep/CYT+9hZYzD9PeGLaABgH/PK2d7G9WQVD9t60xDnJ26M8foH/SCLQ+fMp6Jp4wTretCeNOC82BHVnOpZD+kXFtjngRoVly0TO+eRzITwWg9uZiQ3jEn4q3wQ5itvxNk1paQHvRBg
DKIM-Signature: a=rsa-sha256; bh=ql+Rk2SNqQWeVFWzZaZUk3bFhljYo4dbSHtZ+KFTYsw=; 
 c=relaxed/relaxed; d=kaod.org; h=From; s=ovhmo393970-selector1;
 t=1791908809; v=1;
 b=PyeoR5vRzPVeGhUBG58xPF3/YsySIpdU2xTm/aIt+zx78nxnLGNBHPCTNeJf9ftf5aQgMRbh
 0hH6G782oQpmCcJBQGf8J0VFTSkuEt6t0U22/0IBXJCWL2L+rIGBS21GotnPU0EYT0tNGyIqnWd
 LCalMT01iQI1EHvuD2uPH9cOtSlaYShc+BQQ5OU/rfJu4RLGUq8iiKM4qAhelto/lQX2hSOolNQ
 cU0vvkWtfdyWOwPc6ZiWl+GSMW5oE7YYf0nOndLsEkFhXC7H882MAJfZEo/yPeDyt4pIowIAVYg
 vT5KV4RbW/g4qJGfAMCmpYKCUZ9G7Y4IIZCFEb7yyOaIw==
Received-SPF: pass client-ip=51.210.91.56; envelope-from=clg@kaod.org;
 helo=smtpout7.mo540.mail-out.ovh.net
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

On 10/12/26 16:32, Emmanuel Blot wrote:
> Exercise the PCA9545 4-channel I2C mux: channel selection through the
> control byte, upper-nibble read-back, and interrupt logic.
> 
> Signed-off-by: Emmanuel Blot <emmanuel.blot@free.fr>
> ---
>   tests/qtest/meson.build    |   1 +
>   tests/qtest/pca9545-test.c | 116 +++++++++++++++++++++++++++++++++++++++++++++
>   2 files changed, 117 insertions(+)
> 
> diff --git a/tests/qtest/meson.build b/tests/qtest/meson.build
> index 200abf6f36..e05d8a07b9 100644
> --- a/tests/qtest/meson.build
> +++ b/tests/qtest/meson.build
> @@ -336,6 +336,7 @@ qos_test_ss.add(
>     'ne2000-test.c',
>     'tulip-test.c',
>     'nvme-test.c',
> +  'pca9545-test.c',
>     'pca9552-test.c',
>     'pca9554-test.c',
>     'pca9555-test.c',
> diff --git a/tests/qtest/pca9545-test.c b/tests/qtest/pca9545-test.c
> new file mode 100644
> index 0000000000..91f56db92f
> --- /dev/null
> +++ b/tests/qtest/pca9545-test.c
> @@ -0,0 +1,116 @@
> +/*
> + * QTest testcase for the PCA9545 4-channel I2C switch with interrupt logic
> + *
> + * Copyright (c) 2026 Meta Platforms, Inc. and affiliates.
> + *
> + * SPDX-License-Identifier: GPL-2.0-or-later
> + */
> +
> +#include "qemu/osdep.h"
> +#include "libqtest-single.h"
> +#include "libqos/qgraph.h"
> +#include "libqos/i2c.h"
> +
> +#define PCA9545_TEST_ID   "pca9545-test"
> +#define PCA9545_TEST_ADDR 0x70
> +#define PCA9545_TEST_PATH "/machine/peripheral/" PCA9545_TEST_ID
> +
> +/* INTn and INT are active low: level 0 is asserted. */
> +#define INT_ASSERTED   0
> +#define INT_RELEASED   1
> +
> +/* The mux has no register pointer: a read/write moves a single control byte. */
> +static uint8_t pca9545_get(QI2CDevice *dev)
> +{
> +    uint8_t val;
> +
> +    qi2c_recv(dev, &val, 1);
> +    return val;
> +}
> +
> +static void pca9545_set(QI2CDevice *dev, uint8_t val)
> +{
> +    qi2c_send(dev, &val, 1);
> +}
> +
> +static void pca9545_set_int(unsigned chan, int level)
> +{
> +    qtest_set_irq_in(global_qtest, PCA9545_TEST_PATH, "interrupt", chan, level);
> +}
> +
> +/* Channel selection is the lower nibble; the upper nibble reads back 0. */
> +static void test_channel_select(void *obj, void *data, QGuestAllocator *alloc)
> +{
> +    QI2CDevice *dev = (QI2CDevice *)obj;
> +
> +    g_assert_cmphex(pca9545_get(dev), ==, 0x00);
> +
> +    pca9545_set(dev, 0x05); /* channels 0 and 2 */
> +    g_assert_cmphex(pca9545_get(dev), ==, 0x05);
> +
> +    pca9545_set(dev, 0x0f); /* all channels */
> +    g_assert_cmphex(pca9545_get(dev), ==, 0x0f);
> +
> +    pca9545_set(dev, 0x00);
> +    g_assert_cmphex(pca9545_get(dev), ==, 0x00);
> +}
> +
> +/*
> + * The interrupt status is reported in the upper nibble (INT3..INT0) and is
> + * latched regardless of which channels are selected (PCA9545A Table 5).
> + */
> +static void test_interrupt_status(void *obj, void *data, QGuestAllocator *alloc)
> +{
> +    QI2CDevice *dev = (QI2CDevice *)obj;
> +
> +    pca9545_set_int(1, INT_ASSERTED);
> +    g_assert_cmphex(pca9545_get(dev), ==, 0x20);
> +
> +    pca9545_set(dev, 0x01);
> +    pca9545_set_int(3, INT_ASSERTED);
> +    g_assert_cmphex(pca9545_get(dev), ==, 0xa1); /* INT3 | INT1 | channel 0 */
> +
> +    pca9545_set_int(1, INT_RELEASED);
> +    g_assert_cmphex(pca9545_get(dev), ==, 0x81); /* INT3 | channel 0 */
> +}
> +
> +/* The INT output is pulled low while any channel interrupt is active. */
> +static void test_interrupt_output(void *obj, void *data, QGuestAllocator *alloc)
> +{
> +    qtest_irq_intercept_out_named(global_qtest, PCA9545_TEST_PATH,
> +                                  "interrupt-out");
> +
> +    /*
> +     * Interception starts with no recorded level, so drive an idle input
> +     * first to make the mux publish the released state of its output.
> +     */
> +    pca9545_set_int(0, INT_RELEASED);
> +    g_assert_true(get_irq(0));
> +
> +    pca9545_set_int(0, INT_ASSERTED);
> +    g_assert_false(get_irq(0));
> +
> +    pca9545_set_int(2, INT_ASSERTED);
> +    g_assert_false(get_irq(0));
> +
> +    pca9545_set_int(0, INT_RELEASED);
> +    g_assert_false(get_irq(0));
> +    pca9545_set_int(2, INT_RELEASED);
> +    g_assert_true(get_irq(0));
> +}
> +
> +static void pca9545_register_nodes(void)
> +{
> +    QOSGraphEdgeOptions opts = {
> +        .extra_device_opts = "id=" PCA9545_TEST_ID ",address=0x70"
> +    };
> +    add_qi2c_address(&opts, &(QI2CAddress) { PCA9545_TEST_ADDR });
> +
> +    qos_node_create_driver("pca9545", i2c_device_create);
> +    qos_node_consumes("pca9545", "i2c-bus", &opts);
> +
> +    qos_add_test("channel-select", "pca9545", test_channel_select, NULL);
> +    qos_add_test("interrupt-status", "pca9545", test_interrupt_status, NULL);
> +    qos_add_test("interrupt-output", "pca9545", test_interrupt_output, NULL);
> +}
> +libqos_init(pca9545_register_nodes);
> 

Reviewed-by: Cédric Le Goater <clg@redhat.com>

Thanks,

C.


