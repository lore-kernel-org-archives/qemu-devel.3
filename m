Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 00CB4CE8372
	for <qemu-devel@archiver.kernel.org>; Mon, 30 Sep 2024 16:49:27 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1svJa9-0004Yr-Dj; Mon, 30 Sep 2024 12:49:10 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <SRS0=qSCK=Q4=kaod.org=clg@ozlabs.org>)
 id 1svJa7-0004RG-F3; Mon, 30 Sep 2024 12:49:07 -0400
Received: from gandalf.ozlabs.org ([150.107.74.76] helo=mail.ozlabs.org)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <SRS0=qSCK=Q4=kaod.org=clg@ozlabs.org>)
 id 1svJa3-0007On-Ef; Mon, 30 Sep 2024 12:49:07 -0400
Received: from mail.ozlabs.org (mail.ozlabs.org [IPv6:2404:9400:2221:ea00::3])
 by gandalf.ozlabs.org (Postfix) with ESMTP id 4XHRqD6V6Xz4wd0;
 Tue,  1 Oct 2024 02:48:56 +1000 (AEST)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (Client did not present a certificate)
 by mail.ozlabs.org (Postfix) with ESMTPSA id 4XHRpm4Fqrz4wbr;
 Tue,  1 Oct 2024 02:48:32 +1000 (AEST)
Message-ID: <2d7ef0e9-02ba-4a93-91c5-f6101c64b576@kaod.org>
Date: Mon, 30 Sep 2024 18:48:25 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6 8/8] hw/gpio/aspeed: Add test case for AST2700
To: Thomas Huth <thuth@redhat.com>, Jamin Lin <jamin_lin@aspeedtech.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 Steven Lee <steven_lee@aspeedtech.com>, Troy Lee <leetroy@gmail.com>,
 Andrew Jeffery <andrew@codeconstruct.com.au>, Joel Stanley <joel@jms.id.au>,
 Laurent Vivier <lvivier@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 "open list:ASPEED BMCs" <qemu-arm@nongnu.org>,
 "open list:All patches CC here" <qemu-devel@nongnu.org>
Cc: troy_lee@aspeedtech.com, yunlin.tang@aspeedtech.com
References: <20240930085239.3089901-1-jamin_lin@aspeedtech.com>
 <20240930085239.3089901-9-jamin_lin@aspeedtech.com>
 <e3f31190-85fb-41c9-9ecb-eefdaa8c5c49@redhat.com>
Content-Language: en-US, fr
From: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@kaod.org>
In-Reply-To: <e3f31190-85fb-41c9-9ecb-eefdaa8c5c49@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=150.107.74.76;
 envelope-from=SRS0=qSCK=Q4=kaod.org=clg@ozlabs.org; helo=mail.ozlabs.org
X-Spam_score_int: -39
X-Spam_score: -4.0
X-Spam_bar: ----
X-Spam_report: (-4.0 / 5.0 requ) BAYES_00=-1.9,
 HEADER_FROM_DIFFERENT_DOMAINS=0.249, RCVD_IN_DNSWL_MED=-2.3,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

On 9/30/24 18:36, Thomas Huth wrote:
> On 30/09/2024 10.52, Jamin Lin wrote:
>> Add test case to test GPIO output and input pins from A0 to D7 for AST2700.
>>
>> Signed-off-by: Jamin Lin <jamin_lin@aspeedtech.com>
>> ---
>>   tests/qtest/aspeed_gpio-test.c | 77 ++++++++++++++++++++++++++++++++--
>>   tests/qtest/meson.build        |  3 ++
>>   2 files changed, 76 insertions(+), 4 deletions(-)
>>
>> diff --git a/tests/qtest/aspeed_gpio-test.c b/tests/qtest/aspeed_gpio-test.c
>> index d38f51d719..03b3b1c2b2 100644
>> --- a/tests/qtest/aspeed_gpio-test.c
>> +++ b/tests/qtest/aspeed_gpio-test.c
>> @@ -33,6 +33,10 @@
>>   #define GPIO_ABCD_DATA_VALUE 0x000
>>   #define GPIO_ABCD_DIRECTION  0x004
>> +/* AST2700 */
>> +#define AST2700_GPIO_BASE 0x14C0B000
>> +#define GPIOA0_CONTROL 0x180
>> +
>>   static void test_set_colocated_pins(const void *data)
>>   {
>>       QTestState *s = (QTestState *)data;
>> @@ -72,17 +76,82 @@ static void test_set_input_pins(const void *data)
>>       g_assert_cmphex(value, ==, 0xffffffff);
>>   }
>> +static void test_2700_output_pins(const void *data)
>> +{
>> +    QTestState *s = (QTestState *)data;
>> +    uint32_t offset = 0;
>> +    uint32_t value = 0;
>> +    uint32_t pin = 0;
>> +
>> +    for (char c = 'A'; c <= 'D'; c++) {
>> +        for (int i = 0; i < 8; i++) {
>> +            offset = AST2700_GPIO_BASE + GPIOA0_CONTROL + (pin * 4);
>> +
>> +            /* output direction and output hi */
>> +            qtest_writel(s, offset, 0x00000003);
>> +            value = qtest_readl(s, offset);
>> +            g_assert_cmphex(value, ==, 0x00000003);
>> +
>> +            /* output direction and output low */
>> +            qtest_writel(s, offset, 0x00000002);
>> +            value = qtest_readl(s, offset);
>> +            g_assert_cmphex(value, ==, 0x00000002);
>> +            pin++;
>> +        }
>> +    }
>> +}
>> +
>> +static void test_2700_input_pins(const void *data)
>> +{
>> +    QTestState *s = (QTestState *)data;
>> +    char name[16];
>> +    uint32_t offset = 0;
>> +    uint32_t value = 0;
>> +    uint32_t pin = 0;
>> +
>> +    for (char c = 'A'; c <= 'D'; c++) {
>> +        for (int i = 0; i < 8; i++) {
>> +            sprintf(name, "gpio%c%d", c, i);
>> +            offset = AST2700_GPIO_BASE + GPIOA0_CONTROL + (pin * 4);
>> +            /* input direction */
>> +            qtest_writel(s, offset, 0);
>> +
>> +            /* set input */
>> +            qtest_qom_set_bool(s, "/machine/soc/gpio", name, true);
>> +            value = qtest_readl(s, offset);
>> +            g_assert_cmphex(value, ==, 0x00002000);
>> +
>> +            /* clear input */
>> +            qtest_qom_set_bool(s, "/machine/soc/gpio", name, false);
>> +            value = qtest_readl(s, offset);
>> +            g_assert_cmphex(value, ==, 0);
>> +            pin++;
>> +        }
>> +    }
>> +}
> 
> As far as I can see, there is nothing in these two functions that requires any of the other code in this file ...
> 
>> +
>>   int main(int argc, char **argv)
>>   {
>> +    const char *arch = qtest_get_arch();
>>       QTestState *s;
>>       int r;
>>       g_test_init(&argc, &argv, NULL);
>> -    s = qtest_init("-machine ast2600-evb");
>> -    qtest_add_data_func("/ast2600/gpio/set_colocated_pins", s,
>> -                        test_set_colocated_pins);
>> -    qtest_add_data_func("/ast2600/gpio/set_input_pins", s, test_set_input_pins);
>> +    if (strcmp(arch, "aarch64") == 0) {
>> +        s = qtest_init("-machine ast2700-evb");
>> +        qtest_add_data_func("/ast2700/gpio/input_pins",
>> +                            s, test_2700_input_pins);
>> +        qtest_add_data_func("/ast2700/gpio/out_pins", s, test_2700_output_pins);
>> +    } else {
>> +        s = qtest_init("-machine ast2600-evb");
>> +        qtest_add_data_func("/ast2600/gpio/set_colocated_pins", s,
>> +                            test_set_colocated_pins);
>> +        qtest_add_data_func("/ast2600/gpio/set_input_pins", s,
>> +                            test_set_input_pins);
>> +    }
> 
> ... so the more I look at this, the more I think your new test should reside in a separate file that only gets executed for aarch64, while this file here should stay for arm 32-bit. Or is there a real compelling reason for putting your code in this file here?

Because it is related to the Aspeed GPIO controllers. Unless we
want to introduce a new set of test files for 64-bit Aspeed SoC
controllers ? why not.

I am ok with both options. Option 1 is simpler to implement, but
there may be reasons to separate the tests based on architecture,
although I'm not aware of any at the moment. Would you rather prefer
option 2 ? How should we name the test file ?


Thanks,

C.





>   Thomas
> 
> 
>>       r = g_test_run();
>>       qtest_quit(s);
>> diff --git a/tests/qtest/meson.build b/tests/qtest/meson.build
>> index 310865e49c..292980e3ad 100644
>> --- a/tests/qtest/meson.build
>> +++ b/tests/qtest/meson.build
>> @@ -209,6 +209,8 @@ qtests_aspeed = \
>>     ['aspeed_hace-test',
>>      'aspeed_smc-test',
>>      'aspeed_gpio-test']
>> +qtests_aspeed64 = \
>> +  ['aspeed_gpio-test']
>>   qtests_stm32l4x5 = \
>>     ['stm32l4x5_exti-test',
>> @@ -247,6 +249,7 @@ qtests_aarch64 = \
>>     (config_all_devices.has_key('CONFIG_RASPI') ? ['bcm2835-dma-test', 'bcm2835-i2c-test'] : []) +  \
>>     (config_all_accel.has_key('CONFIG_TCG') and                                            \
>>      config_all_devices.has_key('CONFIG_TPM_TIS_I2C') ? ['tpm-tis-i2c-test'] : []) + \
>> +  (config_all_devices.has_key('CONFIG_ASPEED_SOC') ? qtests_aspeed64 : []) + \
>>     ['arm-cpu-features',
>>      'numa-test',
>>      'boot-serial-test',
> 


