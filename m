Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 711A1C27C53
	for <qemu-devel@archiver.kernel.org>; Sat,  8 Jun 2024 00:17:55 +0000 (UTC)
Received: from [::1] (helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sFaZm-0002rr-Dw; Fri, 07 Jun 2024 10:28:18 -0400
Received: from [2001:470:142:3::10] (helo=eggs.gnu.org)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1sFaZk-0002r4-7Q
 for qemu-devel@nongnu.org; Fri, 07 Jun 2024 10:28:16 -0400
Received: from mail-lf1-x134.google.com ([2a00:1450:4864:20::134])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1sFaZi-0001gz-Kb
 for qemu-devel@nongnu.org; Fri, 07 Jun 2024 10:28:15 -0400
Received: by mail-lf1-x134.google.com with SMTP id
 2adb3069b0e04-52bc335e49aso335323e87.3
 for <qemu-devel@nongnu.org>; Fri, 07 Jun 2024 07:28:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1717770491; x=1718375291; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=sIHXcyplGCyuaTcYN2ALHANulZfiRs5AdM6IBKq+3DU=;
 b=FS3TVtSA88VuuUOP/SsDJM5AITLbe5LSpqG1TNgGWBYzRWCJ6JVyeD0P96vAu3bJZ2
 G7bB9FJueG2eAdYf9ZvK0KgU6Y9DpsCr1CpYy1+GU0FdgygSu+gsC9oQDvcK1BwCahzB
 bHDl0tBEYIcUo+gh5zc73qrVFn1oAajWM8/+oxG8NyANQsTeYNgJSN/pw8HsUYAb1XrK
 zQWHOyiZoye9DN7UHfI84/QWjj+wTwiOcuhY3y8dfr0IRKEdI5mqAlFPQIlHRUHdmIrB
 yo7Spn+2SVgVKkw7VYK7CBQBr8ASJpGu5NQl0X+U2+gK5m7i+dihb77+2/KaFtytBXco
 Rc6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1717770491; x=1718375291;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=sIHXcyplGCyuaTcYN2ALHANulZfiRs5AdM6IBKq+3DU=;
 b=syenUrXICwNf+X174n5KaCgz9mJSUbTVRmZs6QFDkawKxqluz3/FB6L3h+ZsB7g85C
 kbXDCJBhXXPXABJ0/DID8AFpOz9GdK2JppgGgRQ21ZwATCoBK7jFWrnFKSPhWTHdEMia
 shy/cT/N96bnE9tpneRbn7uif12/y2Y6UN3QP1cSEM0zq2gx8Ga5LPSMtgbaSHZsffT7
 qQLLu56Si9i2fhJqJV/Ng4t3nOZUwuHgARFzwmv8xiw4sD2o7HJJ+AVBvLbz4gWcSyPF
 UEIkKsHP3B3UyjazhywlJCNhQxfLIA7Nai/0TdmnnPKK8hOM3UDNuVpclC2Qm9oPzp8T
 foEw==
X-Gm-Message-State: AOJu0YzsDoKyLIFeGVvoLyt3fSyuqiXhcBhK4nxkQb6V8068CFP9vwGs
 6nF1l1oVdf+lKDoyVgVFN8zK5MLVxitBOnI/DNuAC15U8Lg2QmbefyUwIcG9ZKsIkN8PO4yMXKl
 BfTtMlx4XfsbqL/aIsAs9hi8p9FDkjftmVdq2Lw==
X-Google-Smtp-Source: AGHT+IHUAmjhsfJs/bp5+aVqMtzrV3im2oG7sbfAN1K9TPKs2bMalQci6QAaXnGm5i5bC/sVnQLi9xyjo450vwNcUK0=
X-Received: by 2002:a2e:720f:0:b0:2eb:447:25af with SMTP id
 38308e7fff4ca-2eb044769dfmr2511801fa.13.1717770491303; Fri, 07 Jun 2024
 07:28:11 -0700 (PDT)
MIME-Version: 1.0
References: <20240209140505.2536635-1-berrange@redhat.com>
 <20240209140505.2536635-3-berrange@redhat.com>
In-Reply-To: <20240209140505.2536635-3-berrange@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 7 Jun 2024 15:27:59 +0100
Message-ID: <CAFEAcA-qZ9fb=s7hLCcRnH6w6DjDnpSJuGKWbY-Lyne-yJkCVg@mail.gmail.com>
Subject: Re: [PULL 02/17] crypto: Introduce SM4 symmetric cipher algorithm
To: =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>
Cc: qemu-devel@nongnu.org, Hanna Reitz <hreitz@redhat.com>, 
 Gerd Hoffmann <kraxel@redhat.com>,
 =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@redhat.com>, 
 Markus Armbruster <armbru@redhat.com>, Cleber Rosa <crosa@redhat.com>, 
 Paolo Bonzini <pbonzini@redhat.com>, Eric Blake <eblake@redhat.com>, 
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@linaro.org>, 
 Eduardo Habkost <eduardo@habkost.net>, Stefan Weil <sw@weilnetz.de>,
 Kevin Wolf <kwolf@redhat.com>, 
 Thomas Huth <thuth@redhat.com>, Hyman Huang <yong.huang@smartx.com>, 
 Richard Henderson <richard.henderson@linaro.org>, John Snow <jsnow@redhat.com>,
 qemu-block@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::134;
 envelope-from=peter.maydell@linaro.org; helo=mail-lf1-x134.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=unavailable autolearn_force=no
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

On Fri, 9 Feb 2024 at 14:07, Daniel P. Berrang=C3=A9 <berrange@redhat.com> =
wrote:
>
> From: Hyman Huang <yong.huang@smartx.com>
>
> Introduce the SM4 cipher algorithms (OSCCA GB/T 32907-2016).
>
> SM4 (GBT.32907-2016) is a cryptographic standard issued by the
> Organization of State Commercial Administration of China (OSCCA)
> as an authorized cryptographic algorithms for the use within China.
>
> Detect the SM4 cipher algorithms and enable the feature silently
> if it is available.
>
> Signed-off-by: Hyman Huang <yong.huang@smartx.com>
> Reviewed-by: Philippe Mathieu-Daud=C3=A9 <philmd@linaro.org>
> Reviewed-by: Daniel P. Berrang=C3=A9 <berrange@redhat.com>
> Signed-off-by: Daniel P. Berrang=C3=A9 <berrange@redhat.com>

Hi; Coverity points out an issue in this code (CID 1546884):


> @@ -701,6 +731,25 @@ static QCryptoCipher *qcrypto_cipher_ctx_new(QCrypto=
CipherAlgorithm alg,
>
>              return &ctx->base;
>          }
> +#ifdef CONFIG_CRYPTO_SM4
> +    case QCRYPTO_CIPHER_ALG_SM4:
> +        {
> +            QCryptoNettleSm4 *ctx =3D g_new0(QCryptoNettleSm4, 1);

Here we allocate memory...

> +
> +            switch (mode) {
> +            case QCRYPTO_CIPHER_MODE_ECB:
> +                ctx->base.driver =3D &qcrypto_nettle_sm4_driver_ecb;
> +                break;
> +            default:
> +                goto bad_cipher_mode;

...but here we may jump to bad_cipher_mode, resulting in
the memory being leaked, because we never free it.

> +            }
> +

This could be fixed by not doing the g_new0() until this
point when we know we aren't going to fail. This is what we
do for the other cipher cases in this file that have a switch
where the default for mode is a jump to bad_cipher_mode.

(PS: is it intentional that for some of these ciphers
an unknown mode value is an error returned to the caller
via bad_cipher_mode, and for others it is a g_assert_not_reached()?)

> +            sm4_set_encrypt_key(&ctx->key[0], key);
> +            sm4_set_decrypt_key(&ctx->key[1], key);
> +
> +            return &ctx->base;
> +        }
> +#endif

thanks
-- PMM

