Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 70B03C61DD3
	for <qemu-devel@archiver.kernel.org>; Tue,  1 Sep 2026 07:00:43 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x1ITU-0003Lx-2Y; Tue, 01 Sep 2026 03:00:04 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@kaod.org>) id 1x1ITS-0003LY-Sc
 for qemu-devel@nongnu.org; Tue, 01 Sep 2026 03:00:02 -0400
Received: from smtpout3.mo536.mail-out.ovh.net ([51.210.91.12])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@kaod.org>) id 1x1ITQ-0001d2-Tu
 for qemu-devel@nongnu.org; Tue, 01 Sep 2026 03:00:02 -0400
Received: from director3.derp.mail-out.ovh.net
 (director3.derp.mail-out.ovh.net [79.137.60.223])
 by mo536.mail-out.ovh.net (Postfix) with ESMTPS id 4hYxZ71kFBz87dR;
 Tue,  1 Sep 2026 06:59:59 +0000 (UTC)
Received: from director3.derp.mail-out.ovh.net
 (director3.derp.mail-out.ovh.net. [127.0.0.1])
 by director3.derp.mail-out.ovh.net (inspect_sender_mail_agent) with SMTP
 for <jamin_lin@aspeedtech.com>; Tue,  1 Sep 2026 06:59:59 +0000 (UTC)
Received: from mta11.priv.ovhmail-u2.ea.mail.ovh.net (unknown [10.110.58.197])
 by director3.derp.mail-out.ovh.net (Postfix) with ESMTPS id
 4hYxZ70CB8z1xrd; Tue,  1 Sep 2026 06:59:59 +0000 (UTC)
Received: from kaod.org (unknown [10.1.6.4])
 (Authenticated sender: clg@kaod.org)
 by mta11.priv.ovhmail-u2.ea.mail.ovh.net (Postfix) with ESMTPSA id
 9D91A2403FDA; Tue,  1 Sep 2026 06:59:56 +0000 (UTC)
Authentication-Results: garm.ovh; auth=pass
 (GARM-99G003a9514f60-3c75-43cb-9300-e752095463b6,
 60FF1D1BA71F1148B3CBA6CDBAED02576558214C) smtp.auth=clg@kaod.org
X-OVh-ClientIp: 82.64.250.170
Message-ID: <e09fc3a4-17bf-4ccc-a28e-4516350fa956@kaod.org>
Date: Tue, 1 Sep 2026 08:59:55 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 10/25] tests/qtest: tmp105: cover one-shot and
 fault-queue write immunity
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
 <20260731-sanmiguel-bmc-locator-v2-10-1266926ba769@free.fr>
From: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@kaod.org>
Content-Language: en-US, fr
Autocrypt: addr=clg@kaod.org; keydata=
 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
In-Reply-To: <20260731-sanmiguel-bmc-locator-v2-10-1266926ba769@free.fr>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
x-ovh-tracer-id: 8642126210817567789
X-VR-SPAMSTATE: OK
X-VR-SPAMSCORE: -100
X-VR-SPAMCAUSE: dmFkZTFHVfaQohwO2gOZTGBWAr034ZOQ6WA+OPtkDEPPaBhfLyUCEFWOCwM0xPJVmepDWgBOm9f9+EVRnZwmjSuaDMAQo0qZQ+SdSr5jGmVP0mwMx5DNa/Q7I+0RpCOfZHfbITk44lStSjo3hEJXcTNQA8G/FBZoLs6V5QF4IZWERSF3YT/yicKdb2dnvYRBJI5aUTfsYONU3Ha6KgdW63hRrn7YVQ3pqvrmMmjTQAx7+WgaOn+DRfJeCi9XVRfC8qHBTx6KhINnk2Fi0WL1yfeR3QjSYN/AI9jrvRGcoP1mervhO81ex1B4w5s6CC7dftAVcjU0iKW3/f5fvoSf/Al6f+1bRvxWwkrfaeEikPqbflFMib1pAfBa6ntcPwH31oS+GHnHulBH0xvpl//lmQ5CMrNX98NnKayRwbo9usG9CjatF0FW+sDOGGSwFFtfvyGqNVAMUMrpLx+owaA1IFpDI2ambzdLihj5PoDq0x1os+gQMAVDkznxEe3QfBHrWDUyn3xRNffvaI2pK40UYQa2Hx+xdnp5+KEHR0i78Z8aXo82rZbBxI1etx15AW1h5vZRozlinQeaj1kJcnoJ5O6dZhXBf5RNueXD8gvIK5xZVsi5VPiiTj8KqZjUbpl9Ocp60UiOI4bsLkZRXj/1UFHrYfbG+cnzbl9EWnprVXhviJU+nA
DKIM-Signature: a=rsa-sha256; bh=ulXqxwwi0aIjBUkeA/RzmZil93WChO4FsVpNz1akQs8=; 
 c=relaxed/relaxed; d=kaod.org; h=From; s=ovhmo393970-selector1;
 t=1788245999; v=1;
 b=o9LVf4yPCegSgXs1yqzsXUiw/wq25bvzA3Jpaf+EywAIGXxNDYX1JF5MfI+c51tYm2GcI6Ir
 E5aTOdWcd45ermiXIA8khxzY/F1BnaOf7cE3lECJ7ovdGBhz4FSovsEUCo8EGyPEmnKEZD0avK7
 jasfNQ2AyIlgiChokRiCk/VL6i8Z2jZB5U7WIFVgtmS7MtPJVLExD+WRLLRBbyrya1JvxI0cQ6N
 DDaTrpwuuPTempxoot6YKyBnyg67po3T/UNf+jEktpaU/JFoPZL4d5y6TgLgEm5ZMbw84U9ALgM
 v2ymUjtoFLLCyR5HvZy+h62QiuV+3PbUudCe7mpuyMuqg==
Received-SPF: pass client-ip=51.210.91.12; envelope-from=clg@kaod.org;
 helo=smtpout3.mo536.mail-out.ovh.net
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

On 7/31/26 12:45, Emmanuel Blot wrote:
> Verify that the one-shot (OS) bit triggers a conversion only in shutdown
> mode and is ignored in continuous mode, and that
> configuration/limit-register writes never advance the fault queue — only
> real conversions do.
> 
> Signed-off-by: Emmanuel Blot <emmanuel.blot@free.fr>
> ---
>   tests/qtest/tmp105-test.c | 102 ++++++++++++++++++++++++++++++++++++++++++++++
>   1 file changed, 102 insertions(+)
> 
> diff --git a/tests/qtest/tmp105-test.c b/tests/qtest/tmp105-test.c
> index ea6803715a..e586a634d8 100644
> --- a/tests/qtest/tmp105-test.c
> +++ b/tests/qtest/tmp105-test.c
> @@ -33,6 +33,8 @@
>   #define TMP105_CONFIG_FQ_1  (0 << 3)   /* fault queue: 1 consecutive fault */
>   #define TMP105_CONFIG_FQ_4  (2 << 3)   /* fault queue: 4 consecutive faults */
>   #define TMP105_CONFIG_FQ(f) ((f) << 3) /* raw F1:F0 fault-queue field value */
> +#define TMP105_CONFIG_SD    (1 << 0)   /* shutdown mode */
> +#define TMP105_CONFIG_OS    (1 << 7)   /* one-shot conversion */
>   
>   static int qmp_tmp105_get_temperature(const char *id)
>   {
> @@ -200,6 +202,102 @@ static void check_fault_queue(QI2CDevice *i2cdev, const char *id,
>       g_assert_true(get_irq(0));
>   }
>   
> +/*
> + * The one-shot (OS) bit starts a conversion only in shutdown mode. In
> + * continuous mode it is ignored, so writing it must not advance the fault
> + * queue; in shutdown each OS write performs one conversion that does.
> + */
> +static void test_one_shot(void *obj, void *data, QGuestAllocator *alloc)
> +{
> +    QI2CDevice *i2cdev = (QI2CDevice *)obj;
> +    int i;
> +
> +    qtest_irq_intercept_out(global_qtest, TMP105_TEST_PATH);
> +
> +    i2c_set8(i2cdev, TMP105_REG_CONFIG, TMP105_CONFIG_POL | TMP105_CONFIG_FQ_4);
> +    qmp_tmp105_set_temperature(TMP105_TEST_ID, 85000);
> +    g_assert_false(get_irq(0));
> +
> +    for (i = 0; i < 8; i++) {
> +        i2c_set8(i2cdev, TMP105_REG_CONFIG,
> +                 TMP105_CONFIG_POL | TMP105_CONFIG_FQ_4 | TMP105_CONFIG_OS);
> +        g_assert_false(get_irq(0));
> +    }
> +
> +    i2c_set8(i2cdev, TMP105_REG_CONFIG,
> +             TMP105_CONFIG_POL | TMP105_CONFIG_FQ_4 | TMP105_CONFIG_SD);
> +    for (i = 0; i < 2; i++) {
> +        i2c_set8(i2cdev, TMP105_REG_CONFIG, TMP105_CONFIG_POL |
> +                 TMP105_CONFIG_FQ_4 | TMP105_CONFIG_SD | TMP105_CONFIG_OS);
> +        g_assert_false(get_irq(0));
> +    }
> +    i2c_set8(i2cdev, TMP105_REG_CONFIG, TMP105_CONFIG_POL |
> +             TMP105_CONFIG_FQ_4 | TMP105_CONFIG_SD | TMP105_CONFIG_OS);
> +    g_assert_true(get_irq(0));
> +}
> +
> +/*
> + * Configuration and limit-register writes are not conversions and must not
> + * advance the fault queue.
> + */
> +static void test_fault_queue_ignores_writes(void *obj, void *data,
> +                                            QGuestAllocator *alloc)
> +{
> +    QI2CDevice *i2cdev = (QI2CDevice *)obj;
> +    int i;
> +
> +    qtest_irq_intercept_out(global_qtest, TMP105_TEST_PATH);
> +
> +    i2c_set8(i2cdev, TMP105_REG_CONFIG, TMP105_CONFIG_POL | TMP105_CONFIG_FQ_4);
> +    g_assert_false(get_irq(0));
> +
> +    qmp_tmp105_set_temperature(TMP105_TEST_ID, 85000);
> +    g_assert_false(get_irq(0));
> +
> +    for (i = 0; i < 8; i++) {
> +        i2c_set8(i2cdev, TMP105_REG_CONFIG,
> +                 TMP105_CONFIG_POL | TMP105_CONFIG_FQ_4);
> +        i2c_set16(i2cdev, TMP105_REG_T_HIGH, 0x5000);
> +        i2c_set16(i2cdev, TMP105_REG_T_LOW, 0x4b00);
> +        g_assert_false(get_irq(0));
> +    }
> +
> +    for (i = 0; i < 2; i++) {
> +        qmp_tmp105_set_temperature(TMP105_TEST_ID, 85000);
> +        g_assert_false(get_irq(0));
> +    }
> +    qmp_tmp105_set_temperature(TMP105_TEST_ID, 85000);
> +    g_assert_true(get_irq(0));
> +}
> +
> +/*
> + * Leaving shutdown (SD 1->0) resumes continuous conversion, which must
> + * re-evaluate the current temperature against the limits.
> + */
> +static void test_wake_from_shutdown(void *obj, void *data,
> +                                    QGuestAllocator *alloc)
> +{
> +    QI2CDevice *i2cdev = (QI2CDevice *)obj;
> +
> +    qtest_irq_intercept_out(global_qtest, TMP105_TEST_PATH);
> +
> +    i2c_set8(i2cdev, TMP105_REG_CONFIG, TMP105_CONFIG_POL | TMP105_CONFIG_FQ_1);
> +    g_assert_false(get_irq(0));
> +
> +    qmp_tmp105_set_temperature(TMP105_TEST_ID, 85000);
> +    g_assert_true(get_irq(0));
> +
> +    i2c_set8(i2cdev, TMP105_REG_CONFIG,
> +             TMP105_CONFIG_POL | TMP105_CONFIG_FQ_1 | TMP105_CONFIG_SD);
> +    g_assert_true(get_irq(0));
> +
> +    qmp_tmp105_set_temperature(TMP105_TEST_ID, 70000);
> +    g_assert_true(get_irq(0));
> +
> +    i2c_set8(i2cdev, TMP105_REG_CONFIG, TMP105_CONFIG_POL | TMP105_CONFIG_FQ_1);
> +    g_assert_false(get_irq(0));
> +}
> +
>   /* The TMP75 maps F1:F0 = 10b to 3 consecutive faults. */
>   static void test_tmp75_fault_queue(void *obj, void *data,
>                                      QGuestAllocator *alloc)
> @@ -282,6 +380,10 @@ static void tmp105_register_nodes(void)
>       qos_add_test("tx-rx", "tmp105", send_and_receive, NULL);
>       qos_add_test("alert-single-fault", "tmp105", test_alert_single_fault, NULL);
>       qos_add_test("fault-queue", "tmp105", test_fault_queue, NULL);
> +    qos_add_test("fault-queue-ignores-writes", "tmp105",
> +                 test_fault_queue_ignores_writes, NULL);
> +    qos_add_test("one-shot", "tmp105", test_one_shot, NULL);
> +    qos_add_test("wake-from-shutdown", "tmp105", test_wake_from_shutdown, NULL);
>   
>       /* TMP75: register-compatible, but with a 1/2/3/4 fault queue. */
>       QOSGraphEdgeOptions tmp75_opts = {
> 

Reviewed-by: Cédric Le Goater <clg@redhat.com>

Thanks,

C.


