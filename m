Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7469FCA0FED
	for <qemu-devel@archiver.kernel.org>; Tue,  9 Sep 2025 07:15:46 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uvsYg-0004dQ-DK; Tue, 09 Sep 2025 03:14:30 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <SRS0=ZSe1=3U=kaod.org=clg@ozlabs.org>)
 id 1uvsYe-0004cf-9m; Tue, 09 Sep 2025 03:14:28 -0400
Received: from gandalf.ozlabs.org ([150.107.74.76] helo=mail.ozlabs.org)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <SRS0=ZSe1=3U=kaod.org=clg@ozlabs.org>)
 id 1uvsYR-0000WM-1T; Tue, 09 Sep 2025 03:14:26 -0400
Received: from mail.ozlabs.org (mail.ozlabs.org [IPv6:2404:9400:2221:ea00::3])
 by gandalf.ozlabs.org (Postfix) with ESMTP id 4cLZnF0kdRz4w9k;
 Tue,  9 Sep 2025 17:14:09 +1000 (AEST)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits))
 (Client did not present a certificate)
 by mail.ozlabs.org (Postfix) with ESMTPSA id 4cLZnB6r1Wz4w8w;
 Tue,  9 Sep 2025 17:14:06 +1000 (AEST)
Message-ID: <abdb5b47-a450-4fc3-b5cd-b170ebb8271a@kaod.org>
Date: Tue, 9 Sep 2025 09:14:04 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/5] tests/qtest: Add qtest for for ASPEED GPIO gpio-set
 property
To: Coco Li <lixiaoyan@google.com>, peter.maydell@linaro.org
Cc: qemu-arm@nongnu.org, qemu-devel@nongnu.org, Felix Wu <flwu@google.com>,
 'Andrew Jeffery' <andrew@codeconstruct.com.au>
References: <20250903213809.3779860-1-lixiaoyan@google.com>
 <20250903213809.3779860-3-lixiaoyan@google.com>
From: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@kaod.org>
Content-Language: en-US, fr
Autocrypt: addr=clg@kaod.org; keydata=
 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
In-Reply-To: <20250903213809.3779860-3-lixiaoyan@google.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=150.107.74.76;
 envelope-from=SRS0=ZSe1=3U=kaod.org=clg@ozlabs.org; helo=mail.ozlabs.org
X-Spam_score_int: -41
X-Spam_score: -4.2
X-Spam_bar: ----
X-Spam_report: (-4.2 / 5.0 requ) BAYES_00=-1.9,
 HEADER_FROM_DIFFERENT_DOMAINS=0.001, RCVD_IN_DNSWL_MED=-2.3,
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

+Andrew for awareness

On 9/3/25 23:38, Coco Li wrote:
> From: Felix Wu <flwu@google.com>
> 
>   - Added qtests to test gpio-set property for ASPEED.
>   - Added function to get uint in qdict.
> 
> Signed-off-by: Felix Wu <flwu@google.com>
> ---
>   include/qobject/qdict.h        |   1 +
>   qobject/qdict.c                |  13 ++++
>   tests/qtest/aspeed_gpio-test.c | 105 ++++++++++++++++++++++++++++++---
>   3 files changed, 110 insertions(+), 9 deletions(-)
> 
> diff --git a/include/qobject/qdict.h b/include/qobject/qdict.h
> index 903e6e5462..861996f08d 100644
> --- a/include/qobject/qdict.h
> +++ b/include/qobject/qdict.h
> @@ -57,6 +57,7 @@ void qdict_put_str(QDict *qdict, const char *key, const char *value);
>   
>   double qdict_get_double(const QDict *qdict, const char *key);
>   int64_t qdict_get_int(const QDict *qdict, const char *key);
> +uint64_t qdict_get_uint(const QDict *qdict, const char *key);
>   bool qdict_get_bool(const QDict *qdict, const char *key);
>   QList *qdict_get_qlist(const QDict *qdict, const char *key);
>   QDict *qdict_get_qdict(const QDict *qdict, const char *key);
> diff --git a/qobject/qdict.c b/qobject/qdict.c
> index a90ac9ae2f..0dafe6d421 100644
> --- a/qobject/qdict.c
> +++ b/qobject/qdict.c
> @@ -209,6 +209,19 @@ int64_t qdict_get_int(const QDict *qdict, const char *key)
>       return qnum_get_int(qobject_to(QNum, qdict_get(qdict, key)));
>   }
>   
> +/**
> + * qdict_get_uint(): Get an unsigned integer mapped by 'key'
> + *
> + * This function assumes that 'key' exists and it stores a
> + * QNum representable as uint.
> + *
> + * Return unsigned integer mapped by 'key'.
> + */
> +uint64_t qdict_get_uint(const QDict *qdict, const char *key)
> +{
> +    return qnum_get_uint(qobject_to(QNum, qdict_get(qdict, key)));
> +}
> +
>   /**
>    * qdict_get_bool(): Get a bool mapped by 'key'
>    *
> diff --git a/tests/qtest/aspeed_gpio-test.c b/tests/qtest/aspeed_gpio-test.c
> index 12675d4cbb..c2f9ca2298 100644
> --- a/tests/qtest/aspeed_gpio-test.c
> +++ b/tests/qtest/aspeed_gpio-test.c
> @@ -27,28 +27,115 @@
>   #include "qemu/timer.h"
>   #include "qobject/qdict.h"
>   #include "libqtest-single.h"
> +#include "qemu/typedefs.h"
>   
>   #define AST2600_GPIO_BASE 0x1E780000
>   
>   #define GPIO_ABCD_DATA_VALUE 0x000
>   #define GPIO_ABCD_DIRECTION  0x004
>   
> +static uint32_t qtest_qom_get_uint32(QTestState *s, const char *path,
> +                                     const char *property)
> +{
> +    QDict *r;
> +
> +    uint32_t res;
> +    r = qtest_qmp(s, "{ 'execute': 'qom-get', 'arguments': "
> +                     "{ 'path': %s, 'property': %s } }", path, property);
> +    res = qdict_get_uint(r, "return");
> +    qobject_unref(r);
> +
> +    return res;
> +}
> +
> +static void qtest_qom_set_uint32(QTestState *s, const char *path,
> +                                 const char *property, uint32_t value)
> +{
> +    QDict *r;
> +
> +    r = qtest_qmp(s, "{ 'execute': 'qom-set', 'arguments': "
> +                     "{ 'path': %s, 'property': %s, 'value': %" PRIu32 " } }",
> +                     path, property, value);
> +    qobject_unref(r);
> +}
> +
> +static const char *resp_get_error(QDict *r, const char* error_key)
> +{
> +    QDict *qdict;
> +
> +    g_assert(r);
> +
> +    qdict = qdict_get_qdict(r, "error");
> +    if (qdict) {
> +        return qdict_get_str(qdict, error_key);
> +    }
> +
> +    return NULL;
> +}
> +
> +static bool qtest_qom_check_error(QTestState *s, const char *path,
> +                                  const char *property, const char *error_msg,
> +                                  const char *error_msg_key)
> +{
> +    QDict *r;
> +    bool b;
> +
> +    r = qtest_qmp(s, "{ 'execute': 'qom-get', 'arguments': "
> +                     "{ 'path': %s, 'property': %s } }", path, property);
> +    b = g_str_equal(resp_get_error(r, error_msg_key), error_msg);
> +    qobject_unref(r);
> +
> +    return b;
> +}
> +
>   static void test_set_colocated_pins(const void *data)
>   {
>       QTestState *s = (QTestState *)data;
> -
> +    const char path[] = "/machine/soc/gpio";
>       /*
>        * gpioV4-7 occupy bits within a single 32-bit value, so we want to make
>        * sure that modifying one doesn't affect the other.
>        */
> -    qtest_qom_set_bool(s, "/machine/soc/gpio", "gpioV4", true);
> -    qtest_qom_set_bool(s, "/machine/soc/gpio", "gpioV5", false);
> -    qtest_qom_set_bool(s, "/machine/soc/gpio", "gpioV6", true);
> -    qtest_qom_set_bool(s, "/machine/soc/gpio", "gpioV7", false);
> -    g_assert(qtest_qom_get_bool(s, "/machine/soc/gpio", "gpioV4"));
> -    g_assert(!qtest_qom_get_bool(s, "/machine/soc/gpio", "gpioV5"));
> -    g_assert(qtest_qom_get_bool(s, "/machine/soc/gpio", "gpioV6"));
> -    g_assert(!qtest_qom_get_bool(s, "/machine/soc/gpio", "gpioV7"));
> +    qtest_qom_set_bool(s, path, "gpioV4", true);
> +    qtest_qom_set_bool(s, path, "gpioV5", false);
> +    qtest_qom_set_bool(s, path, "gpioV6", true);
> +    qtest_qom_set_bool(s, path, "gpioV7", false);
> +    g_assert(qtest_qom_get_bool(s, path, "gpioV4"));
> +    g_assert(!qtest_qom_get_bool(s, path, "gpioV5"));
> +    g_assert(qtest_qom_get_bool(s, path, "gpioV6"));
> +    g_assert(!qtest_qom_get_bool(s, path, "gpioV7"));
> +
> +    /*
> +     * Testing the gpio-set[%d] properties, using individual gpio boolean
> +     * properties to do cross check.
> +     * We use gpioR4-7 for test, Setting them to be 0b1010.
> +     */
> +    qtest_qom_set_uint32(s, path, "gpio-set[4]", 0x0);
> +    g_assert(qtest_qom_get_uint32(s, path, "gpio-set[4]") == 0x0);
> +    qtest_qom_set_uint32(s, path, "gpio-set[4]", 0xa000);
> +    g_assert(qtest_qom_get_uint32(s, path, "gpio-set[4]") == 0xa000);
> +
> +    g_assert(!qtest_qom_get_bool(s, path, "gpioR4"));
> +    g_assert(qtest_qom_get_bool(s, path, "gpioR5"));
> +    g_assert(!qtest_qom_get_bool(s, path, "gpioR6"));
> +    g_assert(qtest_qom_get_bool(s, path, "gpioR7"));
> +
> +    /*
> +     * Testing the invalid indexing, the response info should contain following
> +     * info:
> +     * {key: "class", value: "GenericError"}
> +     *
> +     * For pins, it should follow "gpio%2[A-Z]%1d" or "gpio%3[18A-E]%1d" format.
> +     */
> +    const char error_msg[] = "GenericError";
> +    const char error_msg_key[] = "class";
> +
> +    g_assert(qtest_qom_check_error(s, path, "gpioR+1", error_msg,
> +                                   error_msg_key));
> +    g_assert(qtest_qom_check_error(s, path, "gpio-set[99]", error_msg,
> +                                   error_msg_key));
> +    g_assert(qtest_qom_check_error(s, path, "gpio-set[-3]", error_msg,
> +                                   error_msg_key));
>   }
>   
>   static void test_set_input_pins(const void *data)


