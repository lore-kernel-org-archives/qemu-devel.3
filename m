Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CB950C61DD6
	for <qemu-devel@archiver.kernel.org>; Tue,  1 Sep 2026 07:01:02 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x1IU2-00048v-ER; Tue, 01 Sep 2026 03:00:38 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@kaod.org>) id 1x1ITd-0003vk-T2
 for qemu-devel@nongnu.org; Tue, 01 Sep 2026 03:00:18 -0400
Received: from smtpout7.mo538.mail-out.ovh.net ([51.210.91.36])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@kaod.org>) id 1x1ITb-0001fY-6t
 for qemu-devel@nongnu.org; Tue, 01 Sep 2026 03:00:13 -0400
Received: from director4.derp.mail-out.ovh.net
 (director4.derp.mail-out.ovh.net [79.137.60.37])
 by mo538.mail-out.ovh.net (Postfix) with ESMTPS id 4hYxZJ1DlQz6GSZ;
 Tue,  1 Sep 2026 07:00:08 +0000 (UTC)
Received: from director4.derp.mail-out.ovh.net
 (director4.derp.mail-out.ovh.net. [127.0.0.1])
 by director4.derp.mail-out.ovh.net (inspect_sender_mail_agent) with SMTP
 for <jamin_lin@aspeedtech.com>; Tue,  1 Sep 2026 07:00:08 +0000 (UTC)
Received: from mta6.priv.ovhmail-u2.ea.mail.ovh.net (unknown [10.110.101.225])
 by director4.derp.mail-out.ovh.net (Postfix) with ESMTPS id
 4hYxZJ0KtMz1xv6; Tue,  1 Sep 2026 07:00:08 +0000 (UTC)
Received: from kaod.org (unknown [10.1.6.1])
 (Authenticated sender: clg@kaod.org)
 by mta6.priv.ovhmail-u2.ea.mail.ovh.net (Postfix) with ESMTPSA id BBCF41B43FDB;
 Tue,  1 Sep 2026 07:00:05 +0000 (UTC)
Authentication-Results: garm.ovh; auth=pass
 (GARM-107S0019227cd69-faca-4207-a5c9-2288793db19a,
 60FF1D1BA71F1148B3CBA6CDBAED02576558214C) smtp.auth=clg@kaod.org
X-OVh-ClientIp: 82.64.250.170
Message-ID: <8cb28170-cd27-492d-bfa1-ebf41b5722b0@kaod.org>
Date: Tue, 1 Sep 2026 09:00:04 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 11/25] tests/qtest: tmp105: cover shutdown clearing the
 ALERT across variants
To: Emmanuel Blot <emmanuel.blot@free.fr>, qemu-devel@nongnu.org
Cc: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@mailo.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 Steven Lee <steven_lee@aspeedtech.com>, Jamin Lin
 <jamin_lin@aspeedtech.com>, Kane Chen <kane_chen@aspeedtech.com>,
 Andrew Jeffery <andrew@codeconstruct.com.au>, Joel Stanley <joel@jms.id.au>,
 qemu-arm@nongnu.org, Fabiano Rosas <farosas@suse.de>,
 Laurent Vivier <lvivier@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Thomas Huth <th.huth+qemu@posteo.eu>,
 =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>,
 Emmanuel Blot <eblot@meta.com>
References: <20260731-sanmiguel-bmc-locator-v2-0-1266926ba769@free.fr>
 <20260731-sanmiguel-bmc-locator-v2-11-1266926ba769@free.fr>
From: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@kaod.org>
Content-Language: en-US, fr
Autocrypt: addr=clg@kaod.org; keydata=
 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
In-Reply-To: <20260731-sanmiguel-bmc-locator-v2-11-1266926ba769@free.fr>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
x-ovh-tracer-id: 8644659488825912365
X-VR-SPAMSTATE: OK
X-VR-SPAMSCORE: -100
X-VR-SPAMCAUSE: dmFkZTFHVfaQohwO2gOZTGBWAr034ZOQ6WA+OPtkDEPPaBhfLyUCEFWOCwM0xPJVmepDWgBOm9f9+EVRnZwmjSuaDMAQo0qZQ+SdSr5jGmVP0mwMx5DNa/Q7I+0RpCOfZHfbITk44lStSjo3hEJXcTNQA8G/FBZoLs6V5QF4IZWERSF3YT/yicKdb2dnvYRBJI5aUTfsYONU3Ha6KgdW63hRrn7YVQ3pqvrmMmjTQAx7+WgaOn+DRfJeCi9XVRfC8qHBTx6KhINnk2Fi0WL1yfeR3QjSYN/AI9jrvRGcoP1mervhO81ex1B4w5s6CC7dftAVcjU0iKW3/f5fvoSf/Al6f+1bdjTm1LQOjwZZN2KxapsGupQvuEprwiObabJMlKvCYhrtJF6rCaLLilMbqwesfroxdfVuTrkxr4CtLzL8OqN93fyIm64i6S6E8871x3sA+b73ErAFPBfYqWfUWG6kiGLCFQNR/bpKnalks5OgvebPgQiDvKSw5iI+7vq5oWbx7VsDpcu00uOYdXH/I5hw3D/TlJu5BX8B0QMLIgAKiCV38rmVl8T4CqO4xuUJEvTxI2KRC9l22OP6X2I8IjGAHf2tO6I5tccQPvcMvyl/DbiKA4iDqqPC5oOr2sPcNHfT83+QU80qAURqUeBnaWrpAQGBVIF/xXCglioOji/8aJLGVA
DKIM-Signature: a=rsa-sha256; bh=ZxXPKQcES5jYlMdM6cx2hgvx2Yl+brShXmw8IFfKfN0=; 
 c=relaxed/relaxed; d=kaod.org; h=From; s=ovhmo393970-selector1;
 t=1788246008; v=1;
 b=ucN0bNdDNJxKqF4M5OOdmjLN+sYpUBPdeClr1quHbCC/BGOOjtIOb5t/IxQWOVk+nNLAvEDy
 p7kg8e0qPSRF9e414MrkzyL5rqIue8PFkqDBpUzrqmWZP/1dDh9LDKa0m9AV/bfGwz47tcZvvkk
 nXMHt3XHFIqVhl7hiURrCis7XtDTnuCgRveGqRbTUW89NX8Bpt7pSw6+XHNNHFL6pOhUNtgs79t
 3kRGxFvo6H2ePvbt8Z7wdKvNDNbzAhw48R2g1l3Y7kDeKcKL5kUY87kFtE/aVJpBGq0E/Cqg0gV
 G2sfrEg7qrif46+aUsseD/re3uDjxqYFQRQPlacCHf3SA==
Received-SPF: pass client-ip=51.210.91.36; envelope-from=clg@kaod.org;
 helo=smtpout7.mo538.mail-out.ovh.net
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_NONE=0.001,
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

On 7/31/26 12:45, Emmanuel Blot wrote:
> Verify that entering shutdown clears the ALERT/OS output in interrupt
> mode but leaves it asserted in comparator mode, for both the TMP75 and
> the LM75B.
> 
> Signed-off-by: Emmanuel Blot <emmanuel.blot@free.fr>
> ---
>   tests/qtest/tmp105-test.c | 56 +++++++++++++++++++++++++++++++++++++++++++++++
>   1 file changed, 56 insertions(+)
> 
> diff --git a/tests/qtest/tmp105-test.c b/tests/qtest/tmp105-test.c
> index e586a634d8..504f6b7202 100644
> --- a/tests/qtest/tmp105-test.c
> +++ b/tests/qtest/tmp105-test.c
> @@ -335,6 +335,41 @@ static void test_tmp75_tm_clears_alert(void *obj, void *data,
>       g_assert_false(get_irq(0));
>   }
>   
> +/*
> + * Entering shutdown clears the ALERT in interrupt mode but leaves it asserted
> + * in comparator mode.
> + */
> +static void test_tmp75_shutdown_clears_alert(void *obj, void *data,
> +                                             QGuestAllocator *alloc)
> +{
> +    QI2CDevice *i2cdev = (QI2CDevice *)obj;
> +    int i;
> +
> +    qtest_irq_intercept_out(global_qtest, TMP75_TEST_PATH);
> +
> +    i2c_set8(i2cdev, TMP105_REG_CONFIG,
> +             TMP105_CONFIG_POL | TMP105_CONFIG_TM | TMP105_CONFIG_FQ(3));
> +    for (i = 0; i < 4; i++) {
> +        qmp_tmp105_set_temperature(TMP75_TEST_ID, 85000);
> +    }
> +    g_assert_true(get_irq(0));
> +
> +    i2c_set8(i2cdev, TMP105_REG_CONFIG,
> +             TMP105_CONFIG_POL | TMP105_CONFIG_TM | TMP105_CONFIG_FQ(3) |
> +             TMP105_CONFIG_SD);
> +    g_assert_false(get_irq(0));
> +
> +    i2c_set8(i2cdev, TMP105_REG_CONFIG,
> +             TMP105_CONFIG_POL | TMP105_CONFIG_FQ(3));
> +    for (i = 0; i < 4; i++) {
> +        qmp_tmp105_set_temperature(TMP75_TEST_ID, 85000);
> +    }
> +    g_assert_true(get_irq(0));
> +    i2c_set8(i2cdev, TMP105_REG_CONFIG,
> +             TMP105_CONFIG_POL | TMP105_CONFIG_FQ(3) | TMP105_CONFIG_SD);
> +    g_assert_true(get_irq(0));
> +}
> +
>   /*
>    * The LM75B has a fixed 11-bit (0.125 C) converter: the resolution and one-shot
>    * Config bits are reserved (read/write as zero) and the temperature register is
> @@ -367,6 +402,23 @@ static void test_lm75b_limits(void *obj, void *data,
>       g_assert_cmphex(i2c_get16(i2cdev, TMP105_REG_T_LOW), ==, 0x1280);
>   }
>   
> +/* The LM75B likewise resets its OS output on shutdown in interrupt mode. */
> +static void test_lm75b_shutdown_clears_alert(void *obj, void *data,
> +                                             QGuestAllocator *alloc)
> +{
> +    QI2CDevice *i2cdev = (QI2CDevice *)obj;
> +
> +    qtest_irq_intercept_out(global_qtest, LM75B_TEST_PATH);
> +
> +    i2c_set8(i2cdev, TMP105_REG_CONFIG, TMP105_CONFIG_POL | TMP105_CONFIG_TM);
> +    qmp_tmp105_set_temperature(LM75B_TEST_ID, 85000);
> +    g_assert_true(get_irq(0));
> +
> +    i2c_set8(i2cdev, TMP105_REG_CONFIG,
> +             TMP105_CONFIG_POL | TMP105_CONFIG_TM | TMP105_CONFIG_SD);
> +    g_assert_false(get_irq(0));
> +}
> +
>   static void tmp105_register_nodes(void)
>   {
>       QOSGraphEdgeOptions opts = {
> @@ -396,6 +448,8 @@ static void tmp105_register_nodes(void)
>   
>       qos_add_test("fault-queue", "tmp75", test_tmp75_fault_queue, NULL);
>       qos_add_test("tm-clears-alert", "tmp75", test_tmp75_tm_clears_alert, NULL);
> +    qos_add_test("shutdown-clears-alert", "tmp75",
> +                 test_tmp75_shutdown_clears_alert, NULL);
>   
>       /* TMP175: like the TMP105, with a 1/2/4/6 fault queue. */
>       QOSGraphEdgeOptions tmp175_opts = {
> @@ -419,5 +473,7 @@ static void tmp105_register_nodes(void)
>   
>       qos_add_test("resolution", "lm75b", test_lm75b_resolution, NULL);
>       qos_add_test("limits", "lm75b", test_lm75b_limits, NULL);
> +    qos_add_test("shutdown-clears-alert", "lm75b",
> +                 test_lm75b_shutdown_clears_alert, NULL);
>   }
>   libqos_init(tmp105_register_nodes);
> 

Reviewed-by: Cédric Le Goater <clg@redhat.com>

Thanks,

C.


