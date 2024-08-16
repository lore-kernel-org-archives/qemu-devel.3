Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 00DACC52D7D
	for <qemu-devel@archiver.kernel.org>; Fri, 16 Aug 2024 12:50:58 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sewPp-0007YY-SE; Fri, 16 Aug 2024 08:50:49 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dorjoychy111@gmail.com>)
 id 1sewPn-0007QA-La
 for qemu-devel@nongnu.org; Fri, 16 Aug 2024 08:50:47 -0400
Received: from mail-vk1-xa33.google.com ([2607:f8b0:4864:20::a33])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <dorjoychy111@gmail.com>)
 id 1sewPj-0002us-Ss
 for qemu-devel@nongnu.org; Fri, 16 Aug 2024 08:50:47 -0400
Received: by mail-vk1-xa33.google.com with SMTP id
 71dfb90a1353d-4f521a22d74so638761e0c.2
 for <qemu-devel@nongnu.org>; Fri, 16 Aug 2024 05:50:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1723812642; x=1724417442; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Pp7hJ8KOVHlV3CMJinrVPr5fzR94KZTmwyL07MABLFY=;
 b=mxIyRAAXTAPt+puI7wFA+aU3GgavNZLq3jMtBkUC+onaC6X1hczQleKx9q2FXNStQS
 ncJ6J2M3z9chZhlq9p9bmpOOQK4WvhZqRLnOv3WCqv0K8BvqIc2DzKvndaT/1UmsQnpZ
 R/18RIoHOb5TWzsJWZ+BWFgPWdo0Hlc7aGjJJ7jp9ZCS+FGSAVcYwVBEoJ5Nz8eQpDks
 JuWjTrOaHX7Z4AQpMJLYqOyo/lUCu+rxec6W4eEpNZiwyoSBVLVoUYkStMQOJcgX7G6+
 d4OEqRRaOWtGNhUvH7ORJg6O5mdZaq+4oXMDtoUQJu/Yh9vLam7fvoULpEUOPJrfGEuM
 ZRhg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1723812642; x=1724417442;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Pp7hJ8KOVHlV3CMJinrVPr5fzR94KZTmwyL07MABLFY=;
 b=vE6EXSMxOgJWN+H2iu1HpIXPBSliMdbUME402JWfdQx6ZSd0dUHRpXjdx0xNchkjDB
 zIEyriKwMcqX2UJrtD4IpFg99P16QTUeGFdbdjOkXXUypjZHn+7qe7mHL5BTjNhiov4F
 u0sMDc3/N+I72lmvKm+VfbK2Mk7JQQ1cFtCueo47m/S/RbnZhE9rN6yPO5l+z3vLlG7l
 pvQWq3qPpeyj4trY51HOquRVV8QH4QAAKeaWEgT/wnYONsPCa/sxbxWQYK6+19M4SwHT
 fUnPrtx1vP8IP/pRf5Oq60MHcyJ4SZpb7bOmjImttYU5WxxS4Vz6O/3ZzrLVq9kkSmic
 cN0g==
X-Gm-Message-State: AOJu0YxU7gOpX0yvPoi+AFSQiBivqar6/9ONzEBcon28bYAnPeFi9ZbU
 eAaW6s+2V+GyL04kLlNwfquEoqmhQMiUPPM4m+h8yD7JsuuXTSrwIsLSsaIVYZt8S6Snh7YEKLS
 /aiIZUarg3xl+73mC/tszXTJsxgk=
X-Google-Smtp-Source: AGHT+IG/xxc1lBd+hNDfV8fMXfwCRWVlK92BVpUUbl5CrczeCgrR4uOREtmzZQkzaPx4ukMbGy2HyElblEo9O7egPvE=
X-Received: by 2002:a05:6122:2911:b0:4f6:b160:3806 with SMTP id
 71dfb90a1353d-4fc6c9dac60mr3316164e0c.11.1723812641892; Fri, 16 Aug 2024
 05:50:41 -0700 (PDT)
MIME-Version: 1.0
References: <20240810164502.19693-1-dorjoychy111@gmail.com>
 <20240810164502.19693-5-dorjoychy111@gmail.com> <ZroXDY3YulpB4SCt@redhat.com>
In-Reply-To: <ZroXDY3YulpB4SCt@redhat.com>
From: Dorjoy Chowdhury <dorjoychy111@gmail.com>
Date: Fri, 16 Aug 2024 18:50:34 +0600
Message-ID: <CAFfO_h48q9Lkt1BmtoPxtZ1a8HJsoQCTTdBMTFkB568+v6B0Sw@mail.gmail.com>
Subject: Re: [PATCH v3 4/5] machine/nitro-enclave: Add built-in Nitro Secure
 Module device
To: =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>
Cc: qemu-devel@nongnu.org, graf@amazon.com, agraf@csgraf.de, 
 stefanha@redhat.com, pbonzini@redhat.com, slp@redhat.com, 
 richard.henderson@linaro.org, eduardo@habkost.net, mst@redhat.com, 
 marcel.apfelbaum@gmail.com, philmd@linaro.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::a33;
 envelope-from=dorjoychy111@gmail.com; helo=mail-vk1-xa33.google.com
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

Hi Daniel,

On Mon, Aug 12, 2024 at 8:07=E2=80=AFPM Daniel P. Berrang=C3=A9 <berrange@r=
edhat.com> wrote:
>
> On Sat, Aug 10, 2024 at 10:45:01PM +0600, Dorjoy Chowdhury wrote:
> > AWS Nitro Enclaves have built-in Nitro Secure Module (NSM) device which
> > is used for stripped down TPM functionality like attestation. This comm=
it
> > adds the built-in NSM device in the nitro-enclave machine type.
> >
> > In Nitro Enclaves, all the PCRs start in a known zero state and the fir=
st
> > 16 PCRs are locked from boot and reserved. The PCR0, PCR1, PCR2 and PCR=
8
> > contain the SHA384 hashes related to the EIF file used to boot the
> > VM for validation.
> >
> > A new optional nitro-enclave machine option 'id' has been added which w=
ill
> > be the enclave identifier reflected in the module-id of the NSM device.
> > Otherwise, the device will have a default id set.
> >
> > Signed-off-by: Dorjoy Chowdhury <dorjoychy111@gmail.com>
> > ---
> >  hw/core/eif.c                   | 205 +++++++++++++++++++++++++++++++-
> >  hw/core/eif.h                   |   5 +-
> >  hw/core/meson.build             |   4 +-
> >  hw/i386/Kconfig                 |   1 +
> >  hw/i386/nitro_enclave.c         |  85 ++++++++++++-
> >  include/hw/i386/nitro_enclave.h |  19 +++
> >  6 files changed, 310 insertions(+), 9 deletions(-)
> >
> > diff --git a/hw/core/eif.c b/hw/core/eif.c
> > index 5558879a96..d2c65668ef 100644
> > --- a/hw/core/eif.c
> > +++ b/hw/core/eif.c
> > @@ -12,6 +12,9 @@
> >  #include "qemu/bswap.h"
> >  #include "qapi/error.h"
> >  #include <zlib.h> /* for crc32 */
> > +#include <cbor.h>
> > +#include <gnutls/gnutls.h>
> > +#include <gnutls/x509.h>
> >
> >  #include "hw/core/eif.h"
> >
>
> > @@ -269,6 +284,125 @@ static bool read_eif_ramdisk(FILE *eif, FILE *ini=
trd, uint64_t size,
> >      return false;
> >  }
> >
> > +static bool get_fingerprint_sha384_from_cert(uint8_t *cert, size_t siz=
e,
> > +                                             uint8_t *sha384, Error **=
errp)
> > +{
> > +    gnutls_x509_crt_t crt;
> > +    size_t hash_size =3D 48;
> > +    gnutls_datum_t datum =3D {.data =3D cert, .size =3D size};
> > +
> > +    gnutls_global_init();
> > +    gnutls_x509_crt_init(&crt);
> > +
> > +    if (gnutls_x509_crt_import(crt, &datum, GNUTLS_X509_FMT_PEM) !=3D =
0) {
> > +        error_setg(errp, "Failed to import certificate");
> > +        goto cleanup;
> > +    }
> > +
> > +    if (gnutls_x509_crt_get_fingerprint(crt, GNUTLS_DIG_SHA384, sha384=
,
> > +                                        &hash_size) !=3D 0) {
> > +        error_setg(errp, "Failed to compute SHA384 fingerprint");
> > +        goto cleanup;
> > +    }
> > +
> > +    return true;
> > +
> > + cleanup:
> > +    gnutls_x509_crt_deinit(crt);
> > +    gnutls_global_deinit();
> > +    return false;
> > +}
>
> I'd suggest this go into  qcrypto/x509-utils.c & include/qcrypto/x509-uti=
ls.h,
> as:
>
>     int qcrypto_get_x509_cert_fingerprint(uint8_t *cert,
>                                           size_t size,
>                                           QCryptoHashAlgorith hash,
>                                           Error **errp);
>
> there's no need to be calling gnutls_global_init() / deinit() either.
>
>
> > @@ -299,7 +433,9 @@ static long get_file_size(FILE *f, Error **errp)
> >   */
> >  bool read_eif_file(const char *eif_path, const char *machine_initrd,
> >                     char **kernel_path, char **initrd_path, char **cmdl=
ine,
> > -                   Error **errp)
> > +                   uint8_t *image_sha384, uint8_t *bootstrap_sha384,
> > +                   uint8_t *app_sha384, uint8_t *fingerprint_sha384,
> > +                   bool *signature_found, Error **errp)
> >  {
> >      FILE *f =3D NULL;
> >      FILE *machine_initrd_f =3D NULL;
> > @@ -308,9 +444,33 @@ bool read_eif_file(const char *eif_path, const cha=
r *machine_initrd,
> >      uint32_t crc =3D 0;
> >      EifHeader eif_header;
> >      bool seen_sections[EIF_SECTION_MAX] =3D {false};
> > -
> > +    /* kernel + ramdisks + cmdline sha384 hash */
> > +    GChecksum *image_hasher =3D NULL;
> > +    /* kernel + boot ramdisk + cmdline sha384 hash */
> > +    GChecksum *bootstrap_hasher =3D NULL;
> > +    /* application ramdisk(s) hash */
> > +    GChecksum *app_hasher =3D NULL;
> > +    size_t digest_len;
> > +
> > +    *signature_found =3D false;
> >      *kernel_path =3D *initrd_path =3D *cmdline =3D NULL;
> >
> > +    image_hasher =3D g_checksum_new(G_CHECKSUM_SHA384);
> > +    if (image_hasher =3D=3D NULL) {
> > +        error_setg(errp, "Failed to initialize sha384 hash for image")=
;
> > +        goto cleanup;
> > +    }
> > +    bootstrap_hasher =3D g_checksum_new(G_CHECKSUM_SHA384);
> > +    if (bootstrap_hasher =3D=3D NULL) {
> > +        error_setg(errp, "Failed to initialize sha384 hash for bootstr=
ap");
> > +        goto cleanup;
> > +    }
> > +    app_hasher =3D g_checksum_new(G_CHECKSUM_SHA384);
> > +    if (app_hasher =3D=3D NULL) {
> > +        error_setg(errp, "Failed to initialize sha384 hash for app");
> > +        goto cleanup;
> > +    }
>
> Don't use GChecksum APIs please, use the qcrypto hash APIs instead,
> as we need all code to be using the designated QEMU crypto backend.
>

Thanks for the reviews. I was looking into replacing the GChecksum
uses with qcrypto apis and was able to do it in the extendPCR function
but I need some help with how I can do this in the eif.c file. For
example, the "image_hash" needs to be a SHA384 hash of the kernel,
cmdline, ramdisks sections' data as they appear in the order that is
in the EIF file. Using GChecksum it was easy as I was able to just
pass the hashers to the "read_eif_kernel", "read_eif_ramdisk" etc
functions and call "update" on them. But the qcrypto apis are
stateless i.e., I would need to pass all the buffers in a single api
call so it wouldn't work right now out of the box. Do you have any
suggestions how I should modify/create qcrypto apis so that I can
easily do this (considering that I would need to implement for
different qcrypto backends)? Thanks!

Regards,
Dorjoy

