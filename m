Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C4229C61DD3
	for <qemu-devel@archiver.kernel.org>; Tue,  1 Sep 2026 07:01:15 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x1ITO-0003Ic-6a; Tue, 01 Sep 2026 02:59:58 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@kaod.org>) id 1x1ITM-0003Dq-AI
 for qemu-devel@nongnu.org; Tue, 01 Sep 2026 02:59:56 -0400
Received: from smtpout2.mo539.mail-out.ovh.net ([51.210.91.41])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@kaod.org>) id 1x1ITJ-0001b5-Ls
 for qemu-devel@nongnu.org; Tue, 01 Sep 2026 02:59:55 -0400
Received: from director1.derp.mail-out.ovh.net
 (director1.derp.mail-out.ovh.net [79.137.60.221])
 by mo539.mail-out.ovh.net (Postfix) with ESMTPS id 4hYxYy3Vhyz4FDD;
 Tue,  1 Sep 2026 06:59:50 +0000 (UTC)
Received: from director1.derp.mail-out.ovh.net
 (director1.derp.mail-out.ovh.net. [127.0.0.1])
 by director1.derp.mail-out.ovh.net (inspect_sender_mail_agent) with SMTP
 for <jamin_lin@aspeedtech.com>; Tue,  1 Sep 2026 06:59:50 +0000 (UTC)
Received: from mta6.priv.ovhmail-u2.ea.mail.ovh.net (unknown [10.110.168.224])
 by director1.derp.mail-out.ovh.net (Postfix) with ESMTPS id
 4hYxYy2HqMz6GrV; Tue,  1 Sep 2026 06:59:50 +0000 (UTC)
Received: from kaod.org (unknown [10.1.6.1])
 (Authenticated sender: clg@kaod.org)
 by mta6.priv.ovhmail-u2.ea.mail.ovh.net (Postfix) with ESMTPSA id 5C7FD1B43FCB;
 Tue,  1 Sep 2026 06:59:48 +0000 (UTC)
Authentication-Results: garm.ovh; auth=pass
 (GARM-104R0054e55f8f5-8d26-4ae8-9a84-8fd98189256d,
 60FF1D1BA71F1148B3CBA6CDBAED02576558214C) smtp.auth=clg@kaod.org
X-OVh-ClientIp: 82.64.250.170
Message-ID: <dd62d0e6-e4f5-45b8-8e55-e848577e76ef@kaod.org>
Date: Tue, 1 Sep 2026 08:59:47 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 09/25] tests/qtest: tmp105: cover the TMP75, TMP175 and
 LM75B variants
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
 <20260731-sanmiguel-bmc-locator-v2-9-1266926ba769@free.fr>
From: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@kaod.org>
Content-Language: en-US, fr
Autocrypt: addr=clg@kaod.org; keydata=
 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
In-Reply-To: <20260731-sanmiguel-bmc-locator-v2-9-1266926ba769@free.fr>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
x-ovh-tracer-id: 8639592935238642733
X-VR-SPAMSTATE: OK
X-VR-SPAMSCORE: -100
X-VR-SPAMCAUSE: dmFkZTFCz8ENcifGGc7lwMsh5Km2xuR+xdVhCLoxl+J2tovlCADjZE+WbMnanW7kgYgQe1Xb30hsAtuy6Zdh3JAhi6x2xIv0v1XCEdPl3zPVRXVt5hjCmOq/ZpuqEhKYNf8xVymhh8KyRxc6vTjsgFENdi6tszQlEq8FCwobqBFX8MEKZhFbq1M/+xzqMFrMBrJxefSUfZ2mAx/Mmj98zFs8rSYoGmSYa8hp4Qmxm+k7rl1SKe4/Mp3afxzMeOZDjd8oBqNZM63rfKRRkKDccYy/hmCmI66unOknYfrD9bhs8c9qkAUt7fGjDSuiUibfBtFU5ZtXhyuCJ/gU1dRq45DzfQKyUXgkuWtJceSFO9jNKZ0SoPcTT9XsKSc4QKJ4N12pZluKScrD80yfty5IDcibyv9NTmibb4KXHYPVukh2aJPekbuEb4u/06l0Agz1K0gRjBsWj27ikbQoQ+z0haB9dAzUPeOoMSir5JaWQc+aWmQyta48cOKxoM9o4/I0nTlgMrAuC3JOCau1oe72u8hXm2e91uasH6xpNJZJzqpr8YCRmaxr1YA1E4SdDTjnI92TOoAp2VF4BVC+gG80pS44JKrhJ3oUSsqSdNWHuBLPITr9Qe8M+xpwU1Dj8kvz9QfSC/jEy6KSMrSYEPvMyJ5omx3yXI5migv3t51q+8QzwCS31g
DKIM-Signature: a=rsa-sha256; bh=BnDJqKSZvB+kjp0NfSaw8RudomSh4IT/fBsoWKvCU6U=; 
 c=relaxed/relaxed; d=kaod.org; h=From; s=ovhmo393970-selector1;
 t=1788245991; v=1;
 b=Kdl7xsK0hm1ZN1Y1v23r0ei6s5v/Shn4FCc9L1OGyQRg0HAj0DCz7nGAFAzGJoymQBzaFzxz
 TcLXpSOFRH+5XsuDqxYU0gURAXWwAT9MKsuBVHyTBZiLZi+BtqhlyT4wBtHAzFkFuATWqB7w9mO
 eR7u3Oh0vRThwc3wT+BhTnI1wg3y/4BdNcOb3EG5D9tafTluOefw1z6qqhET2J/A2Z+pmCr5DTM
 PwovmLc7p2ZnGo3vcSTkHUbovfJwsvtaEgKq3z49gl22QL/BOpN2BNktAqX2xI6A5IU12uh3kiU
 xijOc8yBK0MBoUqw5IaRrFkgJp2eJ2csQ/q+AnEiFO8cA==
Received-SPF: pass client-ip=51.210.91.41; envelope-from=clg@kaod.org;
 helo=smtpout2.mo539.mail-out.ovh.net
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
> Exercise the per-variant differences added to the model: the TMP75 and
> TMP175 fault-queue depths, the TMP75 alert-clear on thermostat-mode
> change, and the LM75B's reserved config bits and fixed set-point and
> temperature resolutions.
> 
> Signed-off-by: Emmanuel Blot <emmanuel.blot@free.fr>
> ---
>   tests/qtest/tmp105-test.c | 138 ++++++++++++++++++++++++++++++++++++++++++++++
>   1 file changed, 138 insertions(+)
> 
> diff --git a/tests/qtest/tmp105-test.c b/tests/qtest/tmp105-test.c
> index 29a031fb7b..ea6803715a 100644
> --- a/tests/qtest/tmp105-test.c
> +++ b/tests/qtest/tmp105-test.c
> @@ -19,9 +19,20 @@
>   #define TMP105_TEST_ADDR 0x49
>   #define TMP105_TEST_PATH "/machine/peripheral/" TMP105_TEST_ID
>   
> +#define TMP75_TEST_ID    "tmp75-test"
> +#define TMP75_TEST_PATH  "/machine/peripheral/" TMP75_TEST_ID
> +
> +#define TMP175_TEST_ID   "tmp175-test"
> +#define TMP175_TEST_PATH "/machine/peripheral/" TMP175_TEST_ID
> +
> +#define LM75B_TEST_ID    "lm75b-test"
> +#define LM75B_TEST_PATH  "/machine/peripheral/" LM75B_TEST_ID
> +
>   #define TMP105_CONFIG_POL   (1 << 2)   /* ALERT active-high when set */
> +#define TMP105_CONFIG_TM    (1 << 1)   /* interrupt (thermostat) mode */
>   #define TMP105_CONFIG_FQ_1  (0 << 3)   /* fault queue: 1 consecutive fault */
>   #define TMP105_CONFIG_FQ_4  (2 << 3)   /* fault queue: 4 consecutive faults */
> +#define TMP105_CONFIG_FQ(f) ((f) << 3) /* raw F1:F0 fault-queue field value */
>   
>   static int qmp_tmp105_get_temperature(const char *id)
>   {
> @@ -166,6 +177,98 @@ static void test_fault_queue(void *obj, void *data, QGuestAllocator *alloc)
>       g_assert_false(get_irq(0));
>   }
>   
> +/*
> + * Drive @need consecutive over-limit conversions and check that the ALERT pin
> + * only asserts on the last one. This exercises the fault-queue length.
> + */
> +static void check_fault_queue(QI2CDevice *i2cdev, const char *id,
> +                              const char *path, uint8_t fq_field, int need)
> +{
> +    int i;
> +
> +    qtest_irq_intercept_out(global_qtest, path);
> +
> +    i2c_set8(i2cdev, TMP105_REG_CONFIG,
> +             TMP105_CONFIG_POL | TMP105_CONFIG_FQ(fq_field));
> +    g_assert_false(get_irq(0));
> +
> +    for (i = 0; i < need - 1; i++) {
> +        qmp_tmp105_set_temperature(id, 85000);
> +        g_assert_false(get_irq(0));
> +    }
> +    qmp_tmp105_set_temperature(id, 85000);
> +    g_assert_true(get_irq(0));
> +}
> +
> +/* The TMP75 maps F1:F0 = 10b to 3 consecutive faults. */
> +static void test_tmp75_fault_queue(void *obj, void *data,
> +                                   QGuestAllocator *alloc)
> +{
> +    check_fault_queue(obj, TMP75_TEST_ID, TMP75_TEST_PATH, 2, 3);
> +}
> +
> +/* The TMP175 keeps the TMP105 mapping: F1:F0 = 10b means 4 faults. */
> +static void test_tmp175_fault_queue(void *obj, void *data,
> +                                    QGuestAllocator *alloc)
> +{
> +    check_fault_queue(obj, TMP175_TEST_ID, TMP175_TEST_PATH, 2, 4);
> +}
> +
> +/*
> + * Toggling the thermostat mode (TM) bit clears any active alert on the TMP75.
> + */
> +static void test_tmp75_tm_clears_alert(void *obj, void *data,
> +                                       QGuestAllocator *alloc)
> +{
> +    QI2CDevice *i2cdev = (QI2CDevice *)obj;
> +    int i;
> +
> +    qtest_irq_intercept_out(global_qtest, TMP75_TEST_PATH);
> +
> +    i2c_set8(i2cdev, TMP105_REG_CONFIG,
> +             TMP105_CONFIG_POL | TMP105_CONFIG_FQ(3));
> +    for (i = 0; i < 4; i++) {
> +        qmp_tmp105_set_temperature(TMP75_TEST_ID, 85000);
> +    }
> +    g_assert_true(get_irq(0));
> +
> +    i2c_set8(i2cdev, TMP105_REG_CONFIG,
> +             TMP105_CONFIG_POL | TMP105_CONFIG_FQ(3) | TMP105_CONFIG_TM);
> +    g_assert_false(get_irq(0));
> +}
> +
> +/*
> + * The LM75B has a fixed 11-bit (0.125 C) converter: the resolution and one-shot
> + * Config bits are reserved (read/write as zero) and the temperature register is
> + * always masked to 11 bits regardless of what is written to Config.
> + */
> +static void test_lm75b_resolution(void *obj, void *data,
> +                                  QGuestAllocator *alloc)
> +{
> +    QI2CDevice *i2cdev = (QI2CDevice *)obj;
> +    uint16_t value;
> +
> +    i2c_set8(i2cdev, TMP105_REG_CONFIG, 0x60);
> +    g_assert_cmphex(i2c_get8(i2cdev, TMP105_REG_CONFIG), ==, 0x00);
> +
> +    qmp_tmp105_set_temperature(LM75B_TEST_ID, 20938);
> +    value = i2c_get16(i2cdev, TMP105_REG_TEMPERATURE);
> +    g_assert_cmphex(value, ==, 0x14e0);
> +}
> +
> +/* The LM75B set-point registers store only 9 bits. */
> +static void test_lm75b_limits(void *obj, void *data,
> +                              QGuestAllocator *alloc)
> +{
> +    QI2CDevice *i2cdev = (QI2CDevice *)obj;
> +
> +    i2c_set16(i2cdev, TMP105_REG_T_HIGH, 0x4231);
> +    g_assert_cmphex(i2c_get16(i2cdev, TMP105_REG_T_HIGH), ==, 0x4200);
> +
> +    i2c_set16(i2cdev, TMP105_REG_T_LOW, 0x12b4);
> +    g_assert_cmphex(i2c_get16(i2cdev, TMP105_REG_T_LOW), ==, 0x1280);
> +}
> +
>   static void tmp105_register_nodes(void)
>   {
>       QOSGraphEdgeOptions opts = {
> @@ -179,5 +282,40 @@ static void tmp105_register_nodes(void)
>       qos_add_test("tx-rx", "tmp105", send_and_receive, NULL);
>       qos_add_test("alert-single-fault", "tmp105", test_alert_single_fault, NULL);
>       qos_add_test("fault-queue", "tmp105", test_fault_queue, NULL);
> +
> +    /* TMP75: register-compatible, but with a 1/2/3/4 fault queue. */
> +    QOSGraphEdgeOptions tmp75_opts = {
> +        .extra_device_opts = "id=" TMP75_TEST_ID ",address=0x48"
> +    };
> +    add_qi2c_address(&tmp75_opts, &(QI2CAddress) { 0x48 });
> +
> +    qos_node_create_driver("tmp75", i2c_device_create);
> +    qos_node_consumes("tmp75", "i2c-bus", &tmp75_opts);
> +
> +    qos_add_test("fault-queue", "tmp75", test_tmp75_fault_queue, NULL);
> +    qos_add_test("tm-clears-alert", "tmp75", test_tmp75_tm_clears_alert, NULL);
> +
> +    /* TMP175: like the TMP105, with a 1/2/4/6 fault queue. */
> +    QOSGraphEdgeOptions tmp175_opts = {
> +        .extra_device_opts = "id=" TMP175_TEST_ID ",address=0x4a"
> +    };
> +    add_qi2c_address(&tmp175_opts, &(QI2CAddress) { 0x4a });
> +
> +    qos_node_create_driver("tmp175", i2c_device_create);
> +    qos_node_consumes("tmp175", "i2c-bus", &tmp175_opts);
> +
> +    qos_add_test("fault-queue", "tmp175", test_tmp175_fault_queue, NULL);
> +
> +    /* LM75B: fixed 11-bit conversion and 9-bit set-point registers. */
> +    QOSGraphEdgeOptions lm75b_opts = {
> +        .extra_device_opts = "id=" LM75B_TEST_ID ",address=0x4c"
> +    };
> +    add_qi2c_address(&lm75b_opts, &(QI2CAddress) { 0x4c });
> +
> +    qos_node_create_driver("lm75b", i2c_device_create);
> +    qos_node_consumes("lm75b", "i2c-bus", &lm75b_opts);
> +
> +    qos_add_test("resolution", "lm75b", test_lm75b_resolution, NULL);
> +    qos_add_test("limits", "lm75b", test_lm75b_limits, NULL);
>   }
>   libqos_init(tmp105_register_nodes);
> 

Reviewed-by: Cédric Le Goater <clg@redhat.com>

Thanks,

C.


