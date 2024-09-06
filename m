Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 13B2DCE7B1B
	for <qemu-devel@archiver.kernel.org>; Fri,  6 Sep 2024 14:08:48 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1smZd6-0002dB-8C; Fri, 06 Sep 2024 10:08:04 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dorjoychy111@gmail.com>)
 id 1smZd4-0002ca-LP
 for qemu-devel@nongnu.org; Fri, 06 Sep 2024 10:08:02 -0400
Received: from mail-qt1-x82c.google.com ([2607:f8b0:4864:20::82c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <dorjoychy111@gmail.com>)
 id 1smZd3-0004UH-24
 for qemu-devel@nongnu.org; Fri, 06 Sep 2024 10:08:02 -0400
Received: by mail-qt1-x82c.google.com with SMTP id
 d75a77b69052e-45812fdcd0aso3639751cf.0
 for <qemu-devel@nongnu.org>; Fri, 06 Sep 2024 07:08:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1725631680; x=1726236480; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=vi2bKU8LcPKnL2romqfoJiBW82+Rkx3HFGln65yYKgU=;
 b=bWZ1mFuJgMh5WGviJQKO0PhPftDz2OG8SaiaxxefX4HnrrZD2SpPY4FOCppNUL/0M6
 +d93Ba3efbTKqQik2IkCLDIzqh/XroozGOFbavhdE781+dGrCZ6/Yry78rY9fOhjgCHu
 oLh6Ay2Pxy7GDRqtus9THXhgYrL2JY9CfbvINL5twIKZvOeQ2Ol4feIbKg2KlCeNQfdo
 4fBEvUPz1/PUZQbVESc7RowL1lLQDteUJSXv5z9tW6i/d/A5biLYohbUndc/wgxzkZeg
 gs3m6U5QSYxFIpb3f7JlTdUqqxqywLNZbIH7oLhzLKIixa/GuQk9HqC3jqtmFjIEh2Q0
 b++A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1725631680; x=1726236480;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=vi2bKU8LcPKnL2romqfoJiBW82+Rkx3HFGln65yYKgU=;
 b=GG/CaiA+GKi+FNnWURGxCUU+asysi48iMVCGItSr+2ygH2FHZZCBKOSiz3Y7D+8ns9
 4L0UzujKQfRjVf4MxU05M8JUEdPiibufa5Z58svY+LVpYcxcCEeBYq0XPxHiKNAujk2R
 KufSkICC0bj5UtJs1iyHvEUkdI+5XUDC8bI4qmS2N+Tu7XqcENaaMQPzgtB3PjcY49UK
 VLp7vuY6AF+czsYqL85ReNBbl+CvF15e7rAZ/j1ZVJbH+IvxnizVrzM53/lScDP0DsM0
 PDo5KNcQhP1WexWkrv2++IsREH5QX75VFfCdzY9Mqjp1vMg8+YB+ZkMhEkxyheKH3wGO
 KiOA==
X-Gm-Message-State: AOJu0YyfeW9c8XgGnORv1S8fq5Vc/nyF8W7LYc9JfpAwFyyahL5oQa5V
 Xok52v1DNYU6BRGSHkBgUiO7YYDU/e8Q6y3uvua4vetrbtZjufceqyF1GJoK5orvUhjmEZBpxJr
 LT3LmeRUnn1pO6+KQc0WhcVvONuA=
X-Google-Smtp-Source: AGHT+IHUukHsv8uAoQPeKoLVVOSzqfQxALfapqV/GJ0Fz8QjwJ0HMO657A88hE8k6VPzzM9hufP3TeooDKreqByLEYM=
X-Received: by 2002:a05:622a:1646:b0:444:d42a:c522 with SMTP id
 d75a77b69052e-457f8b4700cmr150533451cf.4.1725631679623; Fri, 06 Sep 2024
 07:07:59 -0700 (PDT)
MIME-Version: 1.0
References: <20240905195735.16911-1-dorjoychy111@gmail.com>
 <20240905195735.16911-4-dorjoychy111@gmail.com> <ZtsImlL43_dzUTp9@redhat.com>
In-Reply-To: <ZtsImlL43_dzUTp9@redhat.com>
From: Dorjoy Chowdhury <dorjoychy111@gmail.com>
Date: Fri, 6 Sep 2024 20:07:54 +0600
Message-ID: <CAFfO_h7sTmXiZT6AsC-_Lp6=kwBRP01-p6+kcD=n2ts6r2JKFg@mail.gmail.com>
Subject: Re: [PATCH v6 3/8] crypto: Introduce x509 utils
To: =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>
Cc: qemu-devel@nongnu.org, graf@amazon.com, agraf@csgraf.de, 
 stefanha@redhat.com, pbonzini@redhat.com, slp@redhat.com, 
 richard.henderson@linaro.org, eduardo@habkost.net, mst@redhat.com, 
 marcel.apfelbaum@gmail.com, philmd@linaro.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::82c;
 envelope-from=dorjoychy111@gmail.com; helo=mail-qt1-x82c.google.com
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FREEMAIL_ENVFROM_END_DIGIT=0.25, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

On Fri, Sep 6, 2024 at 7:50=E2=80=AFPM Daniel P. Berrang=C3=A9 <berrange@re=
dhat.com> wrote:
>
> On Fri, Sep 06, 2024 at 01:57:30AM +0600, Dorjoy Chowdhury wrote:
> > An utility function for getting fingerprint from X.509 certificate
> > has been introduced. Implementation only provided using gnutls.
> >
> > Signed-off-by: Dorjoy Chowdhury <dorjoychy111@gmail.com>
> > ---
> >  crypto/meson.build          |  4 ++
> >  crypto/x509-utils.c         | 75 +++++++++++++++++++++++++++++++++++++
> >  include/crypto/x509-utils.h | 22 +++++++++++
> >  3 files changed, 101 insertions(+)
> >  create mode 100644 crypto/x509-utils.c
> >  create mode 100644 include/crypto/x509-utils.h
>
>
> > +int qcrypto_get_x509_cert_fingerprint(uint8_t *cert, size_t size,
> > +                                      QCryptoHashAlgorithm alg,
> > +                                      uint8_t *result,
> > +                                      size_t *resultlen,
> > +                                      Error **errp)
> > +{
> > +    int ret;
> > +    gnutls_x509_crt_t crt;
> > +    gnutls_datum_t datum =3D {.data =3D cert, .size =3D size};
> > +
> > +    if (alg >=3D G_N_ELEMENTS(qcrypto_to_gnutls_hash_alg_map)) {
> > +        error_setg(errp, "Unknown hash algorithm");
> > +        return -1;
> > +    }
> > +
> > +    if (result =3D=3D NULL) {
> > +        error_setg(errp, "No valid buffer given");
> > +        return -1;
> > +    }
> > +
> > +    gnutls_x509_crt_init(&crt);
> > +
> > +    if (gnutls_x509_crt_import(crt, &datum, GNUTLS_X509_FMT_PEM) !=3D =
0) {
> > +        error_setg(errp, "Failed to import certificate");
> > +        goto cleanup;
> > +    }
> > +
> > +    ret =3D gnutls_hash_get_len(qcrypto_to_gnutls_hash_alg_map[alg]);
> > +    if (*resultlen < ret) {
> > +        error_setg(errp,
> > +                   "Result buffer size %zu is smaller than hash %d",
> > +                   *resultlen, ret);
> > +        goto cleanup;
> > +    }
> > +
> > +    if (gnutls_x509_crt_get_fingerprint(crt,
> > +                                        qcrypto_to_gnutls_hash_alg_map=
[alg],
> > +                                        result, resultlen) !=3D 0) {
> > +        error_setg(errp, "Failed to get fingerprint from certificate")=
;
> > +        goto cleanup;
> > +    }
> > +
> > +    return 0;
> > +
> > + cleanup:
> > +    gnutls_x509_crt_deinit(crt);
> > +    return -1;
> > +}
>
> This fails to call gnutls_x509_crt_deinit in the success path.
>
> I'm going to squash in the following change:
>
>
> diff --git a/crypto/x509-utils.c b/crypto/x509-utils.c
> index 593eb8968b..6e157af76b 100644
> --- a/crypto/x509-utils.c
> +++ b/crypto/x509-utils.c
> @@ -31,7 +31,8 @@ int qcrypto_get_x509_cert_fingerprint(uint8_t *cert, si=
ze_t size,
>                                        size_t *resultlen,
>                                        Error **errp)
>  {
> -    int ret;
> +    int ret =3D -1;
> +    int hlen;
>      gnutls_x509_crt_t crt;
>      gnutls_datum_t datum =3D {.data =3D cert, .size =3D size};
>
> @@ -52,11 +53,11 @@ int qcrypto_get_x509_cert_fingerprint(uint8_t *cert, =
size_t size,
>          goto cleanup;
>      }
>
> -    ret =3D gnutls_hash_get_len(qcrypto_to_gnutls_hash_alg_map[alg]);
> -    if (*resultlen < ret) {
> +    hlen =3D gnutls_hash_get_len(qcrypto_to_gnutls_hash_alg_map[alg]);
> +    if (*resultlen < hlen) {
>          error_setg(errp,
>                     "Result buffer size %zu is smaller than hash %d",
> -                   *resultlen, ret);
> +                   *resultlen, hlen);
>          goto cleanup;
>      }
>
> @@ -67,9 +68,9 @@ int qcrypto_get_x509_cert_fingerprint(uint8_t *cert, si=
ze_t size,
>          goto cleanup;
>      }
>
> -    return 0;
> +    ret =3D 0;
>
>   cleanup:
>      gnutls_x509_crt_deinit(crt);
> -    return -1;
> +    return ret;
>  }
>
>

Thanks! The change looks good.

Regards,
Dorjoy

