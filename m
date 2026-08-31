Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E623FC61DD3
	for <qemu-devel@archiver.kernel.org>; Mon, 31 Aug 2026 07:58:22 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x0wtU-0000H7-FM; Mon, 31 Aug 2026 03:57:28 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@kaod.org>) id 1x0wtT-0000GN-4k
 for qemu-devel@nongnu.org; Mon, 31 Aug 2026 03:57:27 -0400
Received: from smtpout9.mo539.mail-out.ovh.net ([51.210.91.48])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@kaod.org>) id 1x0wtQ-0000to-0n
 for qemu-devel@nongnu.org; Mon, 31 Aug 2026 03:57:26 -0400
Received: from director2.derp.mail-out.ovh.net
 (director2.derp.mail-out.ovh.net [79.137.60.36])
 by mo539.mail-out.ovh.net (Postfix) with ESMTPS id 4hYLtk24fJz4F7S;
 Mon, 31 Aug 2026 07:57:17 +0000 (UTC)
Received: from director2.derp.mail-out.ovh.net
 (director2.derp.mail-out.ovh.net. [127.0.0.1])
 by director2.derp.mail-out.ovh.net (inspect_sender_mail_agent) with SMTP
 for <jamin_lin@aspeedtech.com>; Mon, 31 Aug 2026 07:57:17 +0000 (UTC)
Received: from mta7.priv.ovhmail-u2.ea.mail.ovh.net (unknown [10.110.37.168])
 by director2.derp.mail-out.ovh.net (Postfix) with ESMTPS id
 4hYLtj4TPTz1xnN; Mon, 31 Aug 2026 07:57:17 +0000 (UTC)
Received: from kaod.org (unknown [10.1.6.3])
 (Authenticated sender: clg@kaod.org)
 by mta7.priv.ovhmail-u2.ea.mail.ovh.net (Postfix) with ESMTPSA id A8F6A203FD3; 
 Mon, 31 Aug 2026 07:57:15 +0000 (UTC)
Authentication-Results: garm.ovh; auth=pass
 (GARM-107S00164f2186c-1d60-4a4f-b47e-0324a5c9cf67,
 20713A92955D5A277E4AF24F7FE8A47CC1774BFC) smtp.auth=clg@kaod.org
X-OVh-ClientIp: 82.64.250.170
Message-ID: <80360ed9-9e56-406b-b318-6b198445f4ec@kaod.org>
Date: Mon, 31 Aug 2026 09:57:15 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 3/9] crypto/akcipher: Support ECDSA sign/verify with
 nettle
To: Jamin Lin <jamin_lin@aspeedtech.com>,
 =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 Steven Lee <steven_lee@aspeedtech.com>, Troy Lee <leetroy@gmail.com>,
 Kane Chen <kane_chen@aspeedtech.com>,
 Andrew Jeffery <andrew@codeconstruct.com.au>, Joel Stanley <joel@jms.id.au>,
 Eric Blake <eblake@redhat.com>, Markus Armbruster <armbru@redhat.com>,
 Fabiano Rosas <farosas@suse.de>, Laurent Vivier <lvivier@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 "open list:All patches CC here" <qemu-devel@nongnu.org>,
 "open list:ASPEED BMCs" <qemu-arm@nongnu.org>
Cc: Troy Lee <troy_lee@aspeedtech.com>
References: <20260831034153.192916-1-jamin_lin@aspeedtech.com>
 <20260831034153.192916-4-jamin_lin@aspeedtech.com>
From: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@kaod.org>
Content-Language: en-US, fr
Autocrypt: addr=clg@kaod.org; keydata=
 xsFNBFu8o3UBEADP+oJVJaWm5vzZa/iLgpBAuzxSmNYhURZH+guITvSySk30YWfLYGBWQgeo
 8NzNXBY3cH7JX3/a0jzmhDc0U61qFxVgrPqs1PQOjp7yRSFuDAnjtRqNvWkvlnRWLFq4+U5t
 yzYe4SFMjFb6Oc0xkQmaK2flmiJNnnxPttYwKBPd98WfXMmjwAv7QfwW+OL3VlTPADgzkcqj
 53bfZ4VblAQrq6Ctbtu7JuUGAxSIL3XqeQlAwwLTfFGrmpY7MroE7n9Rl+hy/kuIrb/TO8n0
 ZxYXvvhT7OmRKvbYuc5Jze6o7op/bJHlufY+AquYQ4dPxjPPVUT/DLiUYJ3oVBWFYNbzfOrV
 RxEwNuRbycttMiZWxgflsQoHF06q/2l4ttS3zsV4TDZudMq0TbCH/uJFPFsbHUN91qwwaN/+
 gy1j7o6aWMz+Ib3O9dK2M/j/O/Ube95mdCqN4N/uSnDlca3YDEWrV9jO1mUS/ndOkjxa34ia
 70FjwiSQAsyIwqbRO3CGmiOJqDa9qNvd2TJgAaS2WCw/TlBALjVQ7AyoPEoBPj31K74Wc4GS
 Rm+FSch32ei61yFu6ACdZ12i5Edt+To+hkElzjt6db/UgRUeKfzlMB7PodK7o8NBD8outJGS
 tsL2GRX24QvvBuusJdMiLGpNz3uqyqwzC5w0Fd34E6G94806fwARAQABzSBDw6lkcmljIExl
 IEdvYXRlciA8Y2xnQGthb2Qub3JnPsLBeAQTAQIAIgUCW7yjdQIbAwYLCQgHAwIGFQgCCQoL
 BBYCAwECHgECF4AACgkQUaNDx8/77KGRSxAAuMJJMhJdj7acTcFtwof7CDSfoVX0owE2FJdd
 M43hNeTwPWlV5oLCj1BOQo0MVilIpSd9Qu5wqRD8KnN2Bv/rllKPqK2+i8CXymi9hsuzF56m
 76wiPwbsX54jhv/VYY9Al7NBknh6iLYJiC/pgacRCHtSj/wofemSCM48s61s1OleSPSSvJE/
 jYRa0jMXP98N5IEn8rEbkPua/yrm9ynHqi4dKEBCq/F7WDQ+FfUaFQb4ey47A/aSHstzpgsl
 TSDTJDD+Ms8y9x2X5EPKXnI3GRLaCKXVNNtrvbUd9LsKymK3WSbADaX7i0gvMFq7j51P/8yj
 neaUSKSkktHauJAtBNXHMghWm/xJXIVAW8xX5aEiSK7DNp5AM478rDXn9NZFUdLTAScVf7LZ
 VzMFKR0jAVG786b/O5vbxklsww+YXJGvCUvHuysEsz5EEzThTJ6AC5JM2iBn9/63PKiS3ptJ
 QAqzasT6KkZ9fKLdK3qtc6yPaSm22C5ROM3GS+yLy6iWBkJ/nEYh/L/du+TLw7YNbKejBr/J
 ml+V3qZLfuhDjW0GbeJVPzsENuxiNiBbyzlSnAvKlzda/sBDvxmvWhC+nMRQCf47mFr8Xx3w
 WtDSQavnz3zTa0XuEucpwfBuVdk4RlPzNPri6p2KTBhPEvRBdC9wNOdRBtsP9rAPjd52d73O
 wU0EW7yjdQEQALyDNNMw/08/fsyWEWjfqVhWpOOrX2h+z4q0lOHkjxi/FRIRLfXeZjFfNQNL
 SoL8j1y2rQOs1j1g+NV3K5hrZYYcMs0xhmrZKXAHjjDx7FW3sG3jcGjFW5Xk4olTrZwFsZVU
 cP8XZlArLmkAX3UyrrXEWPSBJCXxDIW1hzwpbV/nVbo/K9XBptT/wPd+RPiOTIIRptjypGY+
 S23HYBDND3mtfTz/uY0Jytaio9GETj+fFis6TxFjjbZNUxKpwftu/4RimZ7qL+uM1rG1lLWc
 9SPtFxRQ8uLvLOUFB1AqHixBcx7LIXSKZEFUCSLB2AE4wXQkJbApye48qnZ09zc929df5gU6
 hjgqV9Gk1rIfHxvTsYltA1jWalySEScmr0iSYBZjw8Nbd7SxeomAxzBv2l1Fk8fPzR7M616d
 tb3Z3HLjyvwAwxtfGD7VnvINPbzyibbe9c6gLxYCr23c2Ry0UfFXh6UKD83d5ybqnXrEJ5n/
 t1+TLGCYGzF2erVYGkQrReJe8Mld3iGVldB7JhuAU1+d88NS3aBpNF6TbGXqlXGF6Yua6n1c
 OY2Yb4lO/mDKgjXd3aviqlwVlodC8AwI0SdujWryzL5/AGEU2sIDQCHuv1QgzmKwhE58d475
 KdVX/3Vt5I9kTXpvEpfW18TjlFkdHGESM/JxIqVsqvhAJkalABEBAAHCwV8EGAECAAkFAlu8
 o3UCGwwACgkQUaNDx8/77KEhwg//WqVopd5k8hQb9VVdk6RQOCTfo6wHhEqgjbXQGlaxKHoX
 ywEQBi8eULbeMQf5l4+tHJWBxswQ93IHBQjKyKyNr4FXseUI5O20XVNYDJZUrhA4yn0e/Af0
 IX25d94HXQ5sMTWr1qlSK6Zu79lbH3R57w9jhQm9emQEp785ui3A5U2Lqp6nWYWXz0eUZ0Ta
 d2zC71Gg9VazU9MXyWn749s0nXbVLcLS0yops302Gf3ZmtgfXTX/W+M25hiVRRKCH88yr6it
 +OMJBUndQVAA/fE9hYom6t/zqA248j0QAV/pLHH3hSirE1mv+7jpQnhMvatrwUpeXrOiEw1n
 HzWCqOJUZ4SY+HmGFW0YirWV2mYKoaGO2YBUwYF7O9TI3GEEgRMBIRT98fHa0NPwtlTktVIS
 l73LpgVscdW8yg9Gc82oe8FzU1uHjU8b10lUXOMHpqDDEV9//r4ZhkKZ9C4O+YZcTFu+mvAY
 3GlqivBNkmYsHYSlFsbxc37E1HpTEaSWsGfAHQoPn9qrDJgsgcbBVc1gkUT6hnxShKPp4Pls
 ZVMNjvPAnr5TEBgHkk54HQRhhwcYv1T2QumQizDiU6iOrUzBThaMhZO3i927SG2DwWDVzZlt
 KrCMD1aMPvb3NU8FOYRhNmIFR3fcalYr+9gDuVKe8BVz4atMOoktmt0GWTOC8P4=
In-Reply-To: <20260831034153.192916-4-jamin_lin@aspeedtech.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
x-ovh-tracer-id: 3737143266393762861
X-VR-SPAMSTATE: OK
X-VR-SPAMSCORE: -100
X-VR-SPAMCAUSE: dmFkZTGrmlXgbFH/MLMZPHHkPGKJ+YsojUGlvIS2+NpTNHX4Eror7DUPTav7rr65oiWJLd+em5748IMufoIk6ZzPWnZrJQ4zwSsbxJlQ9V/0lBi0Rc5NZCzQr+AK0HMDBg7t/4JU15dkcLJQZwOVRqXuhQxP2fkYePk9Pu126Ic6oHIHHoB3EjscNjgfUIJtcNIFszQG6kxWQ2VEDJkn5uyshF5MoxIWAHpiUNTfz2TCz7cOVQ/Ews1ecXpS1GbQVFezOuiOMa7MOXfVM1AocYPgeTEJPJFSLom0slac5uulnYryqIHWNma0GQdkD45fGXsadpGsQDdrRWQqJzLvTigYyYVgidBeR9jUwcXSKnz/0S9wLh1tqFhYJU5ABV9HBl/sdT1ie1HdlV5JIvHv1tT2F2yN0RNJqk5fd8LluI1oqFFMH0EofapHQL4LVsXhW8lrKFsLwEYIeHza1TIW1LV7PsZcgrn1Sen2nwjDBbRtXlkj9dkkCXGVwf4/ptJvCE5ntdIbzmg7+dqZt/eoOG9tBvWC3MI6xFSp4BNRRCHT41XiMTQ1V9eJBV9ZfBxBO4RS0wTSCBbfnDvKSvWevtYNoo1ujbkuwInE0epBgyYxTVdQ3G8P+AliNZrLMb9cXT3+Fyx2cjzcU9ehmWvwDiKYyMARsu8D0bLE+WOyyjNxKQPg8A
DKIM-Signature: a=rsa-sha256; bh=qfES9bTL+DCn1ictHqU4249eLxbYM1odNz1zynqpgjw=; 
 c=relaxed/relaxed; d=kaod.org; h=From; s=ovhmo393970-selector1;
 t=1788163039; v=1;
 b=TQ1pquto7bUxqpQPDlIfDGblSbieX2Y3ZrWUaa3XGlRYar1qvs7t1WnCId76hs5M51Fja3Io
 oaYWZW4rNLvq2MhgzJSHmIAh2V2D6HgawTkH6EGdjOWfv9VuYewhNA57r52DyVxS/9EwZ3ovKow
 O3CW0nDviBjMe1hCplAT8NmHAplkN2/cWO7umuAleoFZiPMPfl9QTAw5g+/NxGjIVi7G4HyilpP
 ev39Mfu2A8g+DFtA2173j0P125Mj2FsAWy0xx0wqY+clj1rUQRlHYW7ME8lIUIBUmW040LwQUi+
 kWGkPL5lKPSnm+KGEpmCHFAAdQjwAXtiMsJ9e6LHPbllQ==
Received-SPF: pass client-ip=51.210.91.48; envelope-from=clg@kaod.org;
 helo=smtpout9.mo539.mail-out.ovh.net
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

On 8/31/26 05:41, Jamin Lin wrote:
> Implement ECDSA signing and verification for the nettle/hogweed backend,
> for the prime256v1 (NIST P-256) and secp384r1 (NIST P-384) curves.
> A public key (Qx || Qy) is loaded into an ecc_point for verify;
> a private key (the scalar d) into an ecc_scalar for sign,
> using nettle's ecdsa_sign() / ecdsa_verify().
> 
> The encrypt/decrypt driver ops return an error.
> 
> Signed-off-by: Jamin Lin <jamin_lin@aspeedtech.com>
> Reviewed-by: Daniel P. Berrangé <berrange@redhat.com>
> ---
>   crypto/akcipher-nettle.c.inc | 267 +++++++++++++++++++++++++++++++++++
>   1 file changed, 267 insertions(+)
> 
> diff --git a/crypto/akcipher-nettle.c.inc b/crypto/akcipher-nettle.c.inc
> index 1d4bd6960e..34bdc3de27 100644
> --- a/crypto/akcipher-nettle.c.inc
> +++ b/crypto/akcipher-nettle.c.inc
> @@ -20,6 +20,10 @@
>    */
>   
>   #include <nettle/rsa.h>
> +#include <nettle/ecdsa.h>
> +#include <nettle/ecc-curve.h>
> +#include <nettle/ecc.h>
> +#include <nettle/bignum.h>
>   
>   #include "qemu/osdep.h"
>   #include "qemu/host-utils.h"
> @@ -55,6 +59,12 @@ static QCryptoAkCipher *qcrypto_nettle_rsa_new(
>       const uint8_t *key,  size_t keylen,
>       Error **errp);
>   
> +static QCryptoAkCipher *qcrypto_nettle_ecdsa_new(
> +    const QCryptoAkCipherOptionsECDSA *opt,
> +    QCryptoAkCipherKeyType type,
> +    const uint8_t *key,  size_t keylen,
> +    Error **errp);
> +
>   QCryptoAkCipher *qcrypto_akcipher_new(const QCryptoAkCipherOptions *opts,
>                                         QCryptoAkCipherKeyType type,
>                                         const uint8_t *key, size_t keylen,
> @@ -64,6 +74,10 @@ QCryptoAkCipher *qcrypto_akcipher_new(const QCryptoAkCipherOptions *opts,
>       case QCRYPTO_AK_CIPHER_ALGO_RSA:
>           return qcrypto_nettle_rsa_new(&opts->u.rsa, type, key, keylen, errp);
>   
> +    case QCRYPTO_AK_CIPHER_ALGO_ECDSA:
> +        return qcrypto_nettle_ecdsa_new(&opts->u.ecdsa, type, key, keylen,
> +                                        errp);
> +
>       default:
>           error_setg(errp, "Unsupported algorithm: %u", opts->alg);
>           return NULL;
> @@ -422,6 +436,249 @@ error:
>   }
>   
>   
> +/*
> + * ECDSA support (sign and verify)
> + *
> + * Keys and signatures use raw big-endian formats:
> + *   - public key: Qx || Qy, each 'coord_len' bytes
> + *   - private key: the scalar d, 'coord_len' bytes
> + *   - signature: r || s, each 'coord_len' bytes
> + *   - the input to sign/verify is a raw message digest
> + */
> +typedef struct QCryptoNettleECDSA {
> +    QCryptoAkCipher akcipher;
> +    QCryptoAkCipherKeyType type;
> +    struct ecc_point pub;
> +    struct ecc_scalar priv;
> +    QCryptoCurveID curve_id;
> +} QCryptoNettleECDSA;
> +
> +static const struct ecc_curve *qcrypto_nettle_ecdsa_curve(
> +    QCryptoCurveID curve_id)
> +{
> +    switch (curve_id) {
> +    case QCRYPTO_CURVE_ID_PRIME256V1:
> +        return nettle_get_secp_256r1();
> +
> +    case QCRYPTO_CURVE_ID_SECP384R1:
> +        return nettle_get_secp_384r1();
> +
> +    default:
> +        return NULL;
> +    }
> +}
> +
> +static size_t qcrypto_nettle_ecdsa_coord_len(QCryptoCurveID curve_id)
> +{
> +    switch (curve_id) {
> +    case QCRYPTO_CURVE_ID_PRIME256V1:
> +        return 32;
> +
> +    case QCRYPTO_CURVE_ID_SECP384R1:
> +        return 48;
> +
> +    default:
> +        return 0;
> +    }
> +}
> +
> +static void qcrypto_nettle_ecdsa_free(QCryptoAkCipher *akcipher)
> +{
> +    QCryptoNettleECDSA *ecdsa = (QCryptoNettleECDSA *)akcipher;
> +    if (!ecdsa) {
> +        return;
> +    }
> +
> +    if (ecdsa->type == QCRYPTO_AK_CIPHER_KEY_TYPE_PRIVATE) {
> +        ecc_scalar_clear(&ecdsa->priv);
> +    } else {
> +        ecc_point_clear(&ecdsa->pub);
> +    }
> +    g_free(ecdsa);
> +}
> +
> +static int qcrypto_nettle_ecdsa_encrypt(QCryptoAkCipher *akcipher,
> +                                        const void *in, size_t in_len,
> +                                        void *out, size_t out_len,
> +                                        Error **errp)
> +{
> +    error_setg(errp, "ECDSA does not support encryption");
> +    return -1;
> +}
> +
> +static int qcrypto_nettle_ecdsa_decrypt(QCryptoAkCipher *akcipher,
> +                                        const void *in, size_t in_len,
> +                                        void *out, size_t out_len,
> +                                        Error **errp)
> +{
> +    error_setg(errp, "ECDSA does not support decryption");
> +    return -1;
> +}
> +
> +static int qcrypto_nettle_ecdsa_sign(QCryptoAkCipher *akcipher,
> +                                     const void *in, size_t in_len,
> +                                     void *out, size_t out_len,
> +                                     Error **errp)
> +{
> +    QCryptoNettleECDSA *ecdsa = (QCryptoNettleECDSA *)akcipher;
> +    size_t coord_len = qcrypto_nettle_ecdsa_coord_len(ecdsa->curve_id);
> +    struct dsa_signature sig;
> +
> +    if (ecdsa->type != QCRYPTO_AK_CIPHER_KEY_TYPE_PRIVATE) {
> +        error_setg(errp, "ECDSA sign requires a private key");
> +        return -1;
> +    }
> +
> +    if (in_len == 0 || in_len > akcipher->max_dgst_len) {
> +        error_setg(errp, "Invalid digest length %zu", in_len);
> +        return -1;
> +    }
> +
> +    if (out_len < coord_len * 2) {
> +        error_setg(errp, "Signature buffer length %zu is less than %zu",
> +                   out_len, coord_len * 2);
> +        return -1;
> +    }
> +
> +    dsa_signature_init(&sig);
> +    ecdsa_sign(&ecdsa->priv, NULL, wrap_nettle_random_func, in_len, in, &sig);
> +
> +    /* output is r || s, each zero-padded to the curve size */
> +    nettle_mpz_get_str_256(coord_len, out, sig.r);
> +    nettle_mpz_get_str_256(coord_len, (uint8_t *)out + coord_len, sig.s);
> +
> +    dsa_signature_clear(&sig);
> +    return coord_len * 2;
> +}
> +
> +static int qcrypto_nettle_ecdsa_verify(QCryptoAkCipher *akcipher,
> +                                       const void *in, size_t in_len,
> +                                       const void *in2, size_t in2_len,
> +                                       Error **errp)
> +{
> +    QCryptoNettleECDSA *ecdsa = (QCryptoNettleECDSA *)akcipher;
> +    size_t coord_len = qcrypto_nettle_ecdsa_coord_len(ecdsa->curve_id);
> +    struct dsa_signature sig;
> +    int ret = -1;

Should we have a guard here, like in qcrypto_nettle_ecdsa_sign() ?

     if (ecdsa->type != QCRYPTO_AK_CIPHER_KEY_TYPE_PUBLIC) {
         error_setg(errp, "ECDSA verify requires a public key");
         return -1;
     }

Just asking.

Thanks,

C.

> +    /* signature is r || s */
> +    if (in_len != coord_len * 2) {
> +        error_setg(errp, "Signature length %zu is not %zu",
> +                   in_len, coord_len * 2);
> +        return ret;
> +    }
> +
> +    if (in2_len == 0 || in2_len > akcipher->max_dgst_len) {
> +        error_setg(errp, "Invalid digest length %zu", in2_len);
> +        return ret;
> +    }
> +
> +    dsa_signature_init(&sig);
> +    nettle_mpz_set_str_256_u(sig.r, coord_len, in);
> +    nettle_mpz_set_str_256_u(sig.s, coord_len, (const uint8_t *)in + coord_len);
> +
> +    if (ecdsa_verify(&ecdsa->pub, in2_len, in2, &sig) == 1) {
> +        ret = 0;
> +    } else {
> +        error_setg(errp, "Failed to verify signature");
> +    }
> +
> +    dsa_signature_clear(&sig);
> +    return ret;
> +}
> +
> +QCryptoAkCipherDriver nettle_ecdsa = {
> +    .encrypt = qcrypto_nettle_ecdsa_encrypt,
> +    .decrypt = qcrypto_nettle_ecdsa_decrypt,
> +    .sign = qcrypto_nettle_ecdsa_sign,
> +    .verify = qcrypto_nettle_ecdsa_verify,
> +    .free = qcrypto_nettle_ecdsa_free,
> +};
> +
> +static QCryptoAkCipher *qcrypto_nettle_ecdsa_new(
> +    const QCryptoAkCipherOptionsECDSA *opt,
> +    QCryptoAkCipherKeyType type,
> +    const uint8_t *key, size_t keylen,
> +    Error **errp)
> +{
> +    QCryptoNettleECDSA *ecdsa;
> +    const struct ecc_curve *curve = qcrypto_nettle_ecdsa_curve(opt->curve_id);
> +    size_t coord_len = qcrypto_nettle_ecdsa_coord_len(opt->curve_id);
> +    mpz_t x;
> +    mpz_t y;
> +
> +    if (!curve || coord_len == 0) {
> +        error_setg(errp, "Unsupported curve id: %u", opt->curve_id);
> +        return NULL;
> +    }
> +
> +    switch (type) {
> +    case QCRYPTO_AK_CIPHER_KEY_TYPE_PUBLIC:
> +        if (keylen != coord_len * 2) {
> +            error_setg(errp, "Public key length %zu is not %zu",
> +                       keylen, coord_len * 2);
> +            return NULL;
> +        }
> +        break;
> +
> +    case QCRYPTO_AK_CIPHER_KEY_TYPE_PRIVATE:
> +        if (keylen != coord_len) {
> +            error_setg(errp, "Private key length %zu is not %zu",
> +                       keylen, coord_len);
> +            return NULL;
> +        }
> +        break;
> +
> +    default:
> +        error_setg(errp, "Unknown akcipher key type %d", type);
> +        return NULL;
> +    }
> +
> +    ecdsa = g_new0(QCryptoNettleECDSA, 1);
> +    ecdsa->akcipher.driver = &nettle_ecdsa;
> +    ecdsa->type = type;
> +    ecdsa->curve_id = opt->curve_id;
> +    ecdsa->akcipher.max_dgst_len = coord_len;
> +    ecdsa->akcipher.max_signature_len = coord_len * 2;
> +
> +    if (type == QCRYPTO_AK_CIPHER_KEY_TYPE_PUBLIC) {
> +        /* public key: Qx || Qy */
> +        ecc_point_init(&ecdsa->pub, curve);
> +        mpz_init(x);
> +        mpz_init(y);
> +        nettle_mpz_set_str_256_u(x, coord_len, key);
> +        nettle_mpz_set_str_256_u(y, coord_len,
> +                                 (const uint8_t *)key + coord_len);
> +
> +        if (!ecc_point_set(&ecdsa->pub, x, y)) {
> +            error_setg(errp, "Invalid ECDSA public key (not on curve)");
> +            mpz_clear(x);
> +            mpz_clear(y);
> +            qcrypto_nettle_ecdsa_free((QCryptoAkCipher *)ecdsa);
> +            return NULL;
> +        }
> +
> +        mpz_clear(x);
> +        mpz_clear(y);
> +    } else {
> +        /* private key: the scalar d */
> +        ecc_scalar_init(&ecdsa->priv, curve);
> +        mpz_init(x);
> +        nettle_mpz_set_str_256_u(x, coord_len, key);
> +
> +        if (!ecc_scalar_set(&ecdsa->priv, x)) {
> +            error_setg(errp, "Invalid ECDSA private key");
> +            mpz_clear(x);
> +            qcrypto_nettle_ecdsa_free((QCryptoAkCipher *)ecdsa);
> +            return NULL;
> +        }
> +
> +        mpz_clear(x);
> +    }
> +
> +    return (QCryptoAkCipher *)ecdsa;
> +}
> +
>   bool qcrypto_akcipher_supports(QCryptoAkCipherOptions *opts)
>   {
>       switch (opts->alg) {
> @@ -445,6 +702,16 @@ bool qcrypto_akcipher_supports(QCryptoAkCipherOptions *opts)
>           }
>           break;
>   
> +    case QCRYPTO_AK_CIPHER_ALGO_ECDSA:
> +        switch (opts->u.ecdsa.curve_id) {
> +        case QCRYPTO_CURVE_ID_PRIME256V1:
> +        case QCRYPTO_CURVE_ID_SECP384R1:
> +            return true;
> +
> +        default:
> +            return false;
> +        }
> +
>       default:
>           return false;
>       }


