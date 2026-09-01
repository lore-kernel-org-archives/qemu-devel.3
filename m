Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 40247C61DD6
	for <qemu-devel@archiver.kernel.org>; Tue,  1 Sep 2026 07:01:15 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x1ITD-000369-8r; Tue, 01 Sep 2026 02:59:47 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@kaod.org>) id 1x1ITB-00034h-QS
 for qemu-devel@nongnu.org; Tue, 01 Sep 2026 02:59:45 -0400
Received: from smtpout10.mo536.mail-out.ovh.net ([51.210.91.19])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@kaod.org>) id 1x1IT9-0001Zn-Qf
 for qemu-devel@nongnu.org; Tue, 01 Sep 2026 02:59:45 -0400
Received: from director2.derp.mail-out.ovh.net
 (director2.derp.mail-out.ovh.net [79.137.60.36])
 by mo536.mail-out.ovh.net (Postfix) with ESMTPS id 4hYxYm3ZJwz87dR;
 Tue,  1 Sep 2026 06:59:40 +0000 (UTC)
Received: from director2.derp.mail-out.ovh.net
 (director2.derp.mail-out.ovh.net. [127.0.0.1])
 by director2.derp.mail-out.ovh.net (inspect_sender_mail_agent) with SMTP
 for <jamin_lin@aspeedtech.com>; Tue,  1 Sep 2026 06:59:40 +0000 (UTC)
Received: from mta10.priv.ovhmail-u2.ea.mail.ovh.net (unknown [10.110.101.100])
 by director2.derp.mail-out.ovh.net (Postfix) with ESMTPS id 4hYxYm2WRnz1xq6;
 Tue,  1 Sep 2026 06:59:40 +0000 (UTC)
Received: from kaod.org (unknown [10.1.6.5])
 (Authenticated sender: clg@kaod.org)
 by mta10.priv.ovhmail-u2.ea.mail.ovh.net (Postfix) with ESMTPSA id
 3825A1923FA2; Tue,  1 Sep 2026 06:59:38 +0000 (UTC)
Authentication-Results: garm.ovh; auth=pass
 (GARM-100R0035c116a25-54b9-453f-bf23-e0d14f7205b7,
 60FF1D1BA71F1148B3CBA6CDBAED02576558214C) smtp.auth=clg@kaod.org
X-OVh-ClientIp: 82.64.250.170
Message-ID: <e96a08fc-c5e3-4be5-b8c1-d272482d5a1a@kaod.org>
Date: Tue, 1 Sep 2026 08:59:37 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 08/25] tests/qtest: tmp105: cover the ALERT fault queue
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
 <20260731-sanmiguel-bmc-locator-v2-8-1266926ba769@free.fr>
From: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@kaod.org>
Content-Language: en-US, fr
Autocrypt: addr=clg@kaod.org; keydata=
 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
In-Reply-To: <20260731-sanmiguel-bmc-locator-v2-8-1266926ba769@free.fr>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
x-ovh-tracer-id: 8636778188131511341
X-VR-SPAMSTATE: OK
X-VR-SPAMSCORE: -100
X-VR-SPAMCAUSE: dmFkZTFCz8ENcifGGc7lwMsh5Km2xuR+xdVhCLoxl+J2tovlCADjZE+WbMnanW7kgYgQe1Xb30hsAtuy6Zdh3JAhi6x2xIv0v1XCEdPl3zPVRXVt5hjCmOq/ZpuqEhKYNf8xVymhh8KyRxc6vTjsgFENdi6tszQlEq8FCwobqBFX8MEKZhFbq1M/+xzqMFrMBrJxefSUfZ2mAx/Mmj98zFs8rSYoGmSYa8hp4Qmxm+k7rl1SKe4/Mp3afxzMeOZDjd8oBqNZM63rfKRRkKDccYy/hmCmI66unOknYfrD9bhs8c9qkAUt7fGjDSuiUibfBtFU5ZtXhyuCJ/gU1dRq45DzfQKyroO4gcpvJ8XpieQwc+OOTtOSfy7KB1SaUe7ca1MDarlxQxUUj2iQmE3KCXkMD4b4fAQ5C47xaTb/UDu/uucpQijj7MoGZ2Ad6A0SUMDnFRXMbIUmry05AR6tj0eADeaBE1Y+80wRWe5CZcVy8PFTczpksRGXfXZt2fhXejzKY/qkPkZ8QP8shAiEwMk51bOFFEqV00LQGueFx/OYuix/WtI7guml+eepPXACzJYGRHPbd6zQrp+kOiz9kY7q2+amQ+10Z692JQHWbScY/mgZfvSYuuXVAUMId/XvOI6TesK8R5CtfN5eidJkH9YQPGEf3E3mgwb1uDxcK9HMSAy8LA
DKIM-Signature: a=rsa-sha256; bh=27YtBnDLxDkzapQMmBtMiVM61SOf4Z4DemFZomkIcwY=; 
 c=relaxed/relaxed; d=kaod.org; h=From; s=ovhmo393970-selector1;
 t=1788245981; v=1;
 b=lYn2yAFvslKqaLG3W8Xa87ZRzHWUD4tm/EAdxqRtQ5WQWSDZW3vYRyOjHFFeuLe0Py7Y4RBG
 7NcZiYKMQLOnvO4I9cLksaX/JXqzDqfAczbunhbfWXjdtigjjl1XEQvLQSP+XL3agHA8qeg2rfR
 yUWeNLPSon4gQCJA/kZLbb3BdfJsylPtju7FRvNsTGl3T1lr5vVafN3VQ0eW2HmoJqf5rvEzahZ
 azLtdiAYwf//+gGt7vebIqgcjRNWtz9YeU3MoyHCHnNNYvMREFj/9YA8W0iF9bGlnj3I2uRIDbZ
 ZUh6ao34lJrPe7f8dElBK5xj6tQOhep+9ecwTKLAW8WQA==
Received-SPF: pass client-ip=51.210.91.19; envelope-from=clg@kaod.org;
 helo=smtpout10.mo536.mail-out.ovh.net
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
> Add two qgraph tests exercising the ALERT pin, the only way the TMP105
> exposes its alarm state. One checks the default single-fault behaviour;
> the other checks a deeper fault queue, including the running-count reset
> on an in-range conversion and its effect on both asserting and releasing
> the alarm.
> 
> Signed-off-by: Emmanuel Blot <emmanuel.blot@free.fr>
> ---
>   tests/qtest/tmp105-test.c | 63 +++++++++++++++++++++++++++++++++++++++++++++++
>   1 file changed, 63 insertions(+)
> 
> diff --git a/tests/qtest/tmp105-test.c b/tests/qtest/tmp105-test.c
> index 3b114a50f55..29a031fb7bf 100644
> --- a/tests/qtest/tmp105-test.c
> +++ b/tests/qtest/tmp105-test.c
> @@ -17,6 +17,11 @@
>   
>   #define TMP105_TEST_ID   "tmp105-test"
>   #define TMP105_TEST_ADDR 0x49
> +#define TMP105_TEST_PATH "/machine/peripheral/" TMP105_TEST_ID
> +
> +#define TMP105_CONFIG_POL   (1 << 2)   /* ALERT active-high when set */
> +#define TMP105_CONFIG_FQ_1  (0 << 3)   /* fault queue: 1 consecutive fault */
> +#define TMP105_CONFIG_FQ_4  (2 << 3)   /* fault queue: 4 consecutive faults */
>   
>   static int qmp_tmp105_get_temperature(const char *id)
>   {
> @@ -105,6 +110,62 @@ static void send_and_receive(void *obj, void *data, QGuestAllocator *alloc)
>       g_assert_cmphex(i2c_get16(i2cdev, TMP105_REG_T_HIGH), ==, 0x4230);
>   }
>   
> +/*
> + * The TMP105 exposes its alarm state only through the ALERT pin.
> + */
> +static void test_alert_single_fault(void *obj, void *data,
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
> +    qmp_tmp105_set_temperature(TMP105_TEST_ID, 70000);
> +    g_assert_false(get_irq(0));
> +}
> +
> +static void test_fault_queue(void *obj, void *data, QGuestAllocator *alloc)
> +{
> +    QI2CDevice *i2cdev = (QI2CDevice *)obj;
> +    int i;
> +
> +    qtest_irq_intercept_out(global_qtest, TMP105_TEST_PATH);
> +
> +    /* Comparator mode, active-high ALERT, fault queue of four. */
> +    i2c_set8(i2cdev, TMP105_REG_CONFIG, TMP105_CONFIG_POL | TMP105_CONFIG_FQ_4);
> +    g_assert_false(get_irq(0));
> +
> +    for (i = 0; i < 3; i++) {
> +        qmp_tmp105_set_temperature(TMP105_TEST_ID, 85000);
> +        g_assert_false(get_irq(0));
> +    }
> +
> +    qmp_tmp105_set_temperature(TMP105_TEST_ID, 25000);
> +    g_assert_false(get_irq(0));
> +
> +    for (i = 0; i < 3; i++) {
> +        qmp_tmp105_set_temperature(TMP105_TEST_ID, 85000);
> +        g_assert_false(get_irq(0));
> +    }
> +
> +    qmp_tmp105_set_temperature(TMP105_TEST_ID, 85000);
> +    g_assert_true(get_irq(0));
> +
> +    for (i = 0; i < 3; i++) {
> +        qmp_tmp105_set_temperature(TMP105_TEST_ID, 70000);
> +        g_assert_true(get_irq(0));
> +    }
> +
> +    qmp_tmp105_set_temperature(TMP105_TEST_ID, 70000);
> +    g_assert_false(get_irq(0));
> +}
> +
>   static void tmp105_register_nodes(void)
>   {
>       QOSGraphEdgeOptions opts = {
> @@ -116,5 +177,7 @@ static void tmp105_register_nodes(void)
>       qos_node_consumes("tmp105", "i2c-bus", &opts);
>   
>       qos_add_test("tx-rx", "tmp105", send_and_receive, NULL);
> +    qos_add_test("alert-single-fault", "tmp105", test_alert_single_fault, NULL);
> +    qos_add_test("fault-queue", "tmp105", test_fault_queue, NULL);
>   }
>   libqos_init(tmp105_register_nodes);
> 

Reviewed-by: Cédric Le Goater <clg@redhat.com>

Thanks,

C.


