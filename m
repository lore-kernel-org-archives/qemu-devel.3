Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E020AC61DE2
	for <qemu-devel@archiver.kernel.org>; Mon, 31 Aug 2026 11:46:54 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x10Sr-0001CU-H6; Mon, 31 Aug 2026 07:46:13 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@kaod.org>) id 1x10Sb-0001BH-UB
 for qemu-devel@nongnu.org; Mon, 31 Aug 2026 07:46:01 -0400
Received: from smtpout8.mo538.mail-out.ovh.net ([51.210.91.37])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@kaod.org>) id 1x10SY-000884-1w
 for qemu-devel@nongnu.org; Mon, 31 Aug 2026 07:45:57 -0400
Received: from director4.derp.mail-out.ovh.net
 (director4.derp.mail-out.ovh.net [79.137.60.37])
 by mo538.mail-out.ovh.net (Postfix) with ESMTPS id 4hYRyQ0mKFz62Wh;
 Mon, 31 Aug 2026 11:45:50 +0000 (UTC)
Received: from director4.derp.mail-out.ovh.net
 (director4.derp.mail-out.ovh.net. [127.0.0.1])
 by director4.derp.mail-out.ovh.net (inspect_sender_mail_agent) with SMTP
 for <jamin_lin@aspeedtech.com>; Mon, 31 Aug 2026 11:45:49 +0000 (UTC)
Received: from mta10.priv.ovhmail-u2.ea.mail.ovh.net (unknown [10.110.101.67])
 by director4.derp.mail-out.ovh.net (Postfix) with ESMTPS id
 4hYRyP6m9Wz1xsy; Mon, 31 Aug 2026 11:45:49 +0000 (UTC)
Received: from kaod.org (unknown [10.1.6.1])
 (Authenticated sender: clg@kaod.org)
 by mta10.priv.ovhmail-u2.ea.mail.ovh.net (Postfix) with ESMTPSA id
 176AB1923F98; Mon, 31 Aug 2026 11:45:48 +0000 (UTC)
Authentication-Results: garm.ovh; auth=pass
 (GARM-102R00434a8d306-0cef-45e6-8cbc-c502fbc21640,
 20713A92955D5A277E4AF24F7FE8A47CC1774BFC) smtp.auth=clg@kaod.org
X-OVh-ClientIp: 82.64.250.170
Message-ID: <deb3454c-a74a-4fa6-9c60-cf5103ebc52a@kaod.org>
Date: Mon, 31 Aug 2026 13:45:47 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1] tests/qtest/aspeed-hace-utils: Replace g_printerr()
 with g_test_skip()
To: Jamin Lin <jamin_lin@aspeedtech.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 Steven Lee <steven_lee@aspeedtech.com>, Troy Lee <leetroy@gmail.com>,
 Kane Chen <kane_chen@aspeedtech.com>,
 Andrew Jeffery <andrew@codeconstruct.com.au>, Joel Stanley <joel@jms.id.au>,
 Fabiano Rosas <farosas@suse.de>, Laurent Vivier <lvivier@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 "open list:ASPEED BMCs" <qemu-arm@nongnu.org>,
 "open list:All patches CC here" <qemu-devel@nongnu.org>
Cc: Troy Lee <troy_lee@aspeedtech.com>
References: <20260831050213.381443-1-jamin_lin@aspeedtech.com>
From: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@kaod.org>
Content-Language: en-US, fr
Autocrypt: addr=clg@kaod.org; keydata=
 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
In-Reply-To: <20260831050213.381443-1-jamin_lin@aspeedtech.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
x-ovh-tracer-id: 7596728149991664685
X-VR-SPAMSTATE: OK
X-VR-SPAMSCORE: -100
X-VR-SPAMCAUSE: dmFkZTFSylR9U6RzDL+/Pmk8UZvNT0Pk1+M0P8txBfcMzrQmBrTQygKhNqS184VgwOqXI8ghPxLoOkQKKnEkDCn6zUc9xt1caCqp2C3EDtwb77UwQoqy9QynnEKh36w+PqAAGCsk+E0e1SohiSTUxhHPZjdEIWYcBVddKQEzInt4RxeUNb2nzzJFC5cgBln6bqZT6mYGuMkLaJqnb7sUikMuuiHW0+F1VMuEpsBivRpDu8XJXC9CDG2L39MF1oKhPuNKHvGTUNg2VOvKjnhAo2sKru25VQAk7eVg4jNfVnqwDK6Bl3nUuU9m1fdV5PXuzhSdaePHqg6O8Bhjzo2WYUNRMKE8eBOvznpwEFJJSf2tLl2OM1Wasg03FlQewlhoNpPpzNErHabVChYAhkMZbm3+neNxETFmvPNPJbZjzNkV1XT1U/DbajW1AVsS2reF/+dqJjP4G45QMkL38ZSDG/f3doSxHFv3z1IX9l5Bzdmjdup0B+SmyxSlBBMkZ5NF0+/6Z3axqvSbf4U8hOTuc5Fsr5erFjrLTYRoM40MLXD3bYQMe+zW7juEQCBnzwenuorBIk2oh+PLTy0Db2bD2rxMo/o2cEyqI5tLzfec40hnDNSvTbhYbmsTOO6sDkg36juiTZm4Y6k6MccilYjKSaE8qX58NqT23Dp0/t2mD/e9j7dPcw
DKIM-Signature: a=rsa-sha256; bh=lHrvGmkHcGr3+k3wbc1rkwEpvVNOzyEXUoGY0R6D5BY=; 
 c=relaxed/relaxed; d=kaod.org; h=From; s=ovhmo393970-selector1;
 t=1788176751; v=1;
 b=ZDUBm9jF+Lmwcg98Ph4atYww39JjMRjXihD87e8ddflcEN2nLNBnbXCwF0mnM/xPGUNbpO2k
 l7hLcXuUPLRLYlGMJ5RwoRCBQDzADJeGhyUr08WoJiUYIbNHMJsSLFltkiHA97Nql8e4m26Ltkh
 bIpt+qB3sYszM6TPyi9tgrLrUER1JHg/d1ghGYo/zCqmIXQ0R+ynMay5qj2pKzALOaUp1eX5Ukf
 sFGuOkaXXjaqs7Gi8+BvUuV/lwRPyekNV5nu6WQeag3m/5BAu+FY0g1WlbIa2iuQobPuio+M1kg
 HodstJOjXvi8+UwBaavgPFMuDKugumTVJ0qqByCzxVj6Q==
Received-SPF: pass client-ip=51.210.91.37; envelope-from=clg@kaod.org;
 helo=smtpout8.mo538.mail-out.ovh.net
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

On 8/31/26 07:02, Jamin Lin wrote:
> Skip a cipher unsupported by the crypto backend with g_test_skip() from
> the test, instead of not registering it and printing a TAP "# skip" line,
> so the qtest does not assume TAP output.
> 
> Signed-off-by: Jamin Lin <jamin_lin@aspeedtech.com>
> ---
>   tests/qtest/aspeed-hace-utils.c | 24 ++++++++++++++++--------
>   1 file changed, 16 insertions(+), 8 deletions(-)
> 
> diff --git a/tests/qtest/aspeed-hace-utils.c b/tests/qtest/aspeed-hace-utils.c
> index 260eec043c..d20562fac9 100644
> --- a/tests/qtest/aspeed-hace-utils.c
> +++ b/tests/qtest/aspeed-hace-utils.c
> @@ -1248,11 +1248,18 @@ static void aspeed_test_crypto(const void *data)
>   {
>       const AspeedCryptoTest *c = data;
>       const CryptTest *t = &crypt_tests[c->index];
> -    QTestState *s = qtest_init(c->machine);
> +    QTestState *s;
>       uint8_t out[64];
>       uint8_t iv[16];
>       size_t iv_off;
>   
> +    if (!qcrypto_cipher_supports(t->alg, t->mode)) {
> +        g_test_skip("cipher not supported by the crypto backend");
> +        return;
> +    }
> +
> +    s = qtest_init(c->machine);
> +
>       g_assert_cmpuint(t->len, <=, sizeof(out));
>   
>       /* Encrypt: ptext -> ctext */
> @@ -1284,10 +1291,17 @@ static void aspeed_test_crypto_gcm(const void *data)
>   {
>       const AspeedCryptoTest *c = data;
>       const CryptTest *t = &crypt_tests[c->index];
> -    QTestState *s = qtest_init(c->machine);
> +    QTestState *s;
>       uint8_t out[64];
>       uint8_t tag[16];
>   
> +    if (!qcrypto_cipher_supports(t->alg, t->mode)) {
> +        g_test_skip("cipher not supported by the crypto backend");
> +        return;
> +    }
> +
> +    s = qtest_init(c->machine);
> +
>       g_assert_cmpuint(t->len, <=, sizeof(out));
>   
>       /* Encrypt: ptext -> ctext, then check the authentication tag. */
> @@ -1318,12 +1332,6 @@ void aspeed_add_crypto_tests(const char *prefix, const char *machine,
>               continue;
>           }
>   
> -        if (!qcrypto_cipher_supports(crypt_tests[i].alg,
> -                                     crypt_tests[i].mode)) {
> -            g_printerr("# skip unsupported %s\n", crypt_tests[i].name);
> -            continue;
> -        }
> -
>           path = g_strdup_printf("%s/hace/crypto/%s", prefix,
>                                  crypt_tests[i].name);
>           t = g_new0(AspeedCryptoTest, 1);

Applied to

     https://github.com/legoater/qemu aspeed-next

Thanks,

C.


