Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7E764C531DC
	for <qemu-devel@archiver.kernel.org>; Fri, 16 Aug 2024 13:35:37 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sex6p-0003OY-0D; Fri, 16 Aug 2024 09:35:15 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dorjoychy111@gmail.com>)
 id 1sex6m-0003H0-S7
 for qemu-devel@nongnu.org; Fri, 16 Aug 2024 09:35:12 -0400
Received: from mail-vk1-xa33.google.com ([2607:f8b0:4864:20::a33])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <dorjoychy111@gmail.com>)
 id 1sex6j-00016t-PE
 for qemu-devel@nongnu.org; Fri, 16 Aug 2024 09:35:12 -0400
Received: by mail-vk1-xa33.google.com with SMTP id
 71dfb90a1353d-4f8dbdbba98so1082258e0c.0
 for <qemu-devel@nongnu.org>; Fri, 16 Aug 2024 06:35:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1723815308; x=1724420108; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=mF9cJRUo+GfHxvzd0gOKBxB/iMn4ag039sowfbSB+8E=;
 b=ePrrDXryFoN2FwRLd0sTWKYjPwGqp0a0U3AcOsJ6S7G5g8Axo3RcnBzRambPIQJlQh
 1APpP/4zdhzNiNoe9lJLXsZhs13nWaHulrFSK1lQlyT/n5AIOS4ZIoVtX3r7dmA2GDaK
 LX9t7CFDSHw63iMjsb7Pjip3wUlQcDp9iQMP8V0DwJz1CzEAChRz+koCmHCSDNm6XS5N
 hr2ZPAv8XZSZktTS4ZYMDC96GmjngI5EdunegTtD0j2IFnBwJgznII3hzkZa6A5MBd9J
 MjFkxmiNhXX2YBw3b6mO7C1xtSL98vduxkv6P6b+aC1kI5FNis/G7QCM4T9cZLUOtq9/
 l6wA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1723815308; x=1724420108;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=mF9cJRUo+GfHxvzd0gOKBxB/iMn4ag039sowfbSB+8E=;
 b=CxtnmOyK0JuPzQ/nGiPdGLwAKotnpdXx3YDZLjxmhT15/SlegSSbqNP9YCxib/geZY
 kbfLzitl6WOugw8OQYVTkiHcQc6Zkll9gBIHMoXWJsH35v0L3gQopzgPRjwjm6Jr+wq8
 +u8UVHFf1K8nOrI2nhjPPDt0Lcauzf/FXYMkhpP2dh8C+tdXuSyNOd5W3//Ph0tTUnj5
 2xlCD1RQ7MrmfWeRH/S/ZZi/zaf44DwU19xRFvDZdOpEWzpyKEY3hNeg/lb44OFk4+6/
 S+DIOB5o9JQso1IXVXin3gdvDKs0Bqzdlf2CBK5/PkigUjTALIIyoCUGdYm8Gx18vOxI
 aPrw==
X-Gm-Message-State: AOJu0Yx2/5ihI8cqs+eoW2YNfpF8aK+qFyHNCN4be49TPfxXfKCB99WY
 wMDebznwAcd8z8N271TkERaZ93FoppaEYKVGCBXMBtNm++Rkr7vtH/V5+xbEskGX+sfvnscIe6g
 xwMiZV+Fpxb4JIQBFnqP80WUKNPo=
X-Google-Smtp-Source: AGHT+IHEaxIbrwhVz/FMiHdcU9miC1pt9fmZmZO3Y7YmSxwARr15Q2+N3kamjwbssU1eC2CSl/YE7vvjagH/e5mx0oI=
X-Received: by 2002:a05:6122:3b06:b0:4f5:1f34:15d5 with SMTP id
 71dfb90a1353d-4fc59134ccemr4133539e0c.5.1723815307735; Fri, 16 Aug 2024
 06:35:07 -0700 (PDT)
MIME-Version: 1.0
References: <20240810164502.19693-1-dorjoychy111@gmail.com>
 <20240810164502.19693-5-dorjoychy111@gmail.com> <ZroXDY3YulpB4SCt@redhat.com>
 <CAFfO_h48q9Lkt1BmtoPxtZ1a8HJsoQCTTdBMTFkB568+v6B0Sw@mail.gmail.com>
 <Zr9M0BqDEdF5D5xJ@redhat.com>
In-Reply-To: <Zr9M0BqDEdF5D5xJ@redhat.com>
From: Dorjoy Chowdhury <dorjoychy111@gmail.com>
Date: Fri, 16 Aug 2024 19:34:59 +0600
Message-ID: <CAFfO_h40N3n-uErpb9AXAi_hEqW7-UaD2ZSHFYO0BKfpw7dBOg@mail.gmail.com>
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

On Fri, Aug 16, 2024 at 6:58=E2=80=AFPM Daniel P. Berrang=C3=A9 <berrange@r=
edhat.com> wrote:
>
> On Fri, Aug 16, 2024 at 06:50:34PM +0600, Dorjoy Chowdhury wrote:
> > Hi Daniel,
> >
> > On Mon, Aug 12, 2024 at 8:07=E2=80=AFPM Daniel P. Berrang=C3=A9 <berran=
ge@redhat.com> wrote:
> > >
> > > On Sat, Aug 10, 2024 at 10:45:01PM +0600, Dorjoy Chowdhury wrote:
> > > > AWS Nitro Enclaves have built-in Nitro Secure Module (NSM) device w=
hich
> > > > is used for stripped down TPM functionality like attestation. This =
commit
> > > > adds the built-in NSM device in the nitro-enclave machine type.
> > > >
> > > > In Nitro Enclaves, all the PCRs start in a known zero state and the=
 first
> > > > 16 PCRs are locked from boot and reserved. The PCR0, PCR1, PCR2 and=
 PCR8
> > > > contain the SHA384 hashes related to the EIF file used to boot the
> > > > VM for validation.
> > > >
> > > > A new optional nitro-enclave machine option 'id' has been added whi=
ch will
> > > > be the enclave identifier reflected in the module-id of the NSM dev=
ice.
> > > > Otherwise, the device will have a default id set.
> > > >
> > > > Signed-off-by: Dorjoy Chowdhury <dorjoychy111@gmail.com>
> > > > ---
> > > >  hw/core/eif.c                   | 205 ++++++++++++++++++++++++++++=
+++-
> > > >  hw/core/eif.h                   |   5 +-
> > > >  hw/core/meson.build             |   4 +-
> > > >  hw/i386/Kconfig                 |   1 +
> > > >  hw/i386/nitro_enclave.c         |  85 ++++++++++++-
> > > >  include/hw/i386/nitro_enclave.h |  19 +++
> > > >  6 files changed, 310 insertions(+), 9 deletions(-)
> > > >
> > > > diff --git a/hw/core/eif.c b/hw/core/eif.c
> > > > index 5558879a96..d2c65668ef 100644
> > > > --- a/hw/core/eif.c
> > > > +++ b/hw/core/eif.c
> > > > @@ -12,6 +12,9 @@
> > > >  #include "qemu/bswap.h"
> > > >  #include "qapi/error.h"
> > > >  #include <zlib.h> /* for crc32 */
> > > > +#include <cbor.h>
> > > > +#include <gnutls/gnutls.h>
> > > > +#include <gnutls/x509.h>
> > > >
> > > >  #include "hw/core/eif.h"
> > > >
> > >
> > > > @@ -269,6 +284,125 @@ static bool read_eif_ramdisk(FILE *eif, FILE =
*initrd, uint64_t size,
> > > >      return false;
> > > >  }
> > > >
> > > > +static bool get_fingerprint_sha384_from_cert(uint8_t *cert, size_t=
 size,
> > > > +                                             uint8_t *sha384, Erro=
r **errp)
> > > > +{
> > > > +    gnutls_x509_crt_t crt;
> > > > +    size_t hash_size =3D 48;
> > > > +    gnutls_datum_t datum =3D {.data =3D cert, .size =3D size};
> > > > +
> > > > +    gnutls_global_init();
> > > > +    gnutls_x509_crt_init(&crt);
> > > > +
> > > > +    if (gnutls_x509_crt_import(crt, &datum, GNUTLS_X509_FMT_PEM) !=
=3D 0) {
> > > > +        error_setg(errp, "Failed to import certificate");
> > > > +        goto cleanup;
> > > > +    }
> > > > +
> > > > +    if (gnutls_x509_crt_get_fingerprint(crt, GNUTLS_DIG_SHA384, sh=
a384,
> > > > +                                        &hash_size) !=3D 0) {
> > > > +        error_setg(errp, "Failed to compute SHA384 fingerprint");
> > > > +        goto cleanup;
> > > > +    }
> > > > +
> > > > +    return true;
> > > > +
> > > > + cleanup:
> > > > +    gnutls_x509_crt_deinit(crt);
> > > > +    gnutls_global_deinit();
> > > > +    return false;
> > > > +}
> > >
> > > I'd suggest this go into  qcrypto/x509-utils.c & include/qcrypto/x509=
-utils.h,
> > > as:
> > >
> > >     int qcrypto_get_x509_cert_fingerprint(uint8_t *cert,
> > >                                           size_t size,
> > >                                           QCryptoHashAlgorith hash,
> > >                                           Error **errp);
> > >
> > > there's no need to be calling gnutls_global_init() / deinit() either.
> > >
> > >
> > > > @@ -299,7 +433,9 @@ static long get_file_size(FILE *f, Error **errp=
)
> > > >   */
> > > >  bool read_eif_file(const char *eif_path, const char *machine_initr=
d,
> > > >                     char **kernel_path, char **initrd_path, char **=
cmdline,
> > > > -                   Error **errp)
> > > > +                   uint8_t *image_sha384, uint8_t *bootstrap_sha38=
4,
> > > > +                   uint8_t *app_sha384, uint8_t *fingerprint_sha38=
4,
> > > > +                   bool *signature_found, Error **errp)
> > > >  {
> > > >      FILE *f =3D NULL;
> > > >      FILE *machine_initrd_f =3D NULL;
> > > > @@ -308,9 +444,33 @@ bool read_eif_file(const char *eif_path, const=
 char *machine_initrd,
> > > >      uint32_t crc =3D 0;
> > > >      EifHeader eif_header;
> > > >      bool seen_sections[EIF_SECTION_MAX] =3D {false};
> > > > -
> > > > +    /* kernel + ramdisks + cmdline sha384 hash */
> > > > +    GChecksum *image_hasher =3D NULL;
> > > > +    /* kernel + boot ramdisk + cmdline sha384 hash */
> > > > +    GChecksum *bootstrap_hasher =3D NULL;
> > > > +    /* application ramdisk(s) hash */
> > > > +    GChecksum *app_hasher =3D NULL;
> > > > +    size_t digest_len;
> > > > +
> > > > +    *signature_found =3D false;
> > > >      *kernel_path =3D *initrd_path =3D *cmdline =3D NULL;
> > > >
> > > > +    image_hasher =3D g_checksum_new(G_CHECKSUM_SHA384);
> > > > +    if (image_hasher =3D=3D NULL) {
> > > > +        error_setg(errp, "Failed to initialize sha384 hash for ima=
ge");
> > > > +        goto cleanup;
> > > > +    }
> > > > +    bootstrap_hasher =3D g_checksum_new(G_CHECKSUM_SHA384);
> > > > +    if (bootstrap_hasher =3D=3D NULL) {
> > > > +        error_setg(errp, "Failed to initialize sha384 hash for boo=
tstrap");
> > > > +        goto cleanup;
> > > > +    }
> > > > +    app_hasher =3D g_checksum_new(G_CHECKSUM_SHA384);
> > > > +    if (app_hasher =3D=3D NULL) {
> > > > +        error_setg(errp, "Failed to initialize sha384 hash for app=
");
> > > > +        goto cleanup;
> > > > +    }
> > >
> > > Don't use GChecksum APIs please, use the qcrypto hash APIs instead,
> > > as we need all code to be using the designated QEMU crypto backend.
> > >
> >
> > Thanks for the reviews. I was looking into replacing the GChecksum
> > uses with qcrypto apis and was able to do it in the extendPCR function
> > but I need some help with how I can do this in the eif.c file. For
> > example, the "image_hash" needs to be a SHA384 hash of the kernel,
> > cmdline, ramdisks sections' data as they appear in the order that is
> > in the EIF file. Using GChecksum it was easy as I was able to just
> > pass the hashers to the "read_eif_kernel", "read_eif_ramdisk" etc
> > functions and call "update" on them. But the qcrypto apis are
> > stateless i.e., I would need to pass all the buffers in a single api
> > call so it wouldn't work right now out of the box. Do you have any
> > suggestions how I should modify/create qcrypto apis so that I can
> > easily do this (considering that I would need to implement for
> > different qcrypto backends)? Thanks!
>
> Looking at the read_eif_* methods:
>
> @ -213,6 +218,8 @@ static bool read_eif_kernel(FILE *f, uint64_t size, ch=
ar **kernel_path,
>      }
>
>      *crc =3D crc32(*crc, kernel, size);
> +    g_checksum_update(image_hasher, kernel, size);
> +    g_checksum_update(bootstrap_hasher, kernel, size);
>      g_free(kernel);
>      fclose(tmp_file);
>
> @@ -230,6 +237,8 @@ static bool read_eif_kernel(FILE *f, uint64_t size, c=
har **kernel_path,
>  }
>
>  static bool read_eif_cmdline(FILE *f, uint64_t size, char *cmdline,
> +                             GChecksum *image_hasher,
> +                             GChecksum *bootstrap_hasher,
>                               uint32_t *crc, Error **errp)
>  {
>      size_t got =3D fread(cmdline, 1, size, f);
> @@ -239,10 +248,14 @@ static bool read_eif_cmdline(FILE *f, uint64_t size=
, char *cmdline,
>      }
>
>      *crc =3D crc32(*crc, (uint8_t *)cmdline, size);
> +    g_checksum_update(image_hasher, (uint8_t *)cmdline, size);
> +    g_checksum_update(bootstrap_hasher, (uint8_t *)cmdline, size);
>      return true;
>  }
>
>  static bool read_eif_ramdisk(FILE *eif, FILE *initrd, uint64_t size,
> +                             GChecksum *image_hasher,
> +                             GChecksum *bootstrap_or_app_hasher,
>                               uint32_t *crc, Error **errp)
>  {
>      size_t got;
> @@ -261,6 +274,8 @@ static bool read_eif_ramdisk(FILE *eif, FILE *initrd,=
 uint64_t size,
>      }
>
>      *crc =3D crc32(*crc, ramdisk, size);
> +    g_checksum_update(image_hasher, ramdisk, size);
> +    g_checksum_update(bootstrap_or_app_hasher, ramdisk, size);
>      g_free(ramdisk);
>      return true;
>
>
> For the kernel + ramdisk, these methods are freeing the buffer.
> For the cmdline, the pointer is held by the caller.
>
> I'd suggest that read_eif_kernel+ramddisk are changed to return
> the data pointer instead of free'ing it.
>
> The caller can then stash the kernl+cmdline+ramdisk into an iovec
> and calc the hash in a single stateless operation.
>
>
>
> If you really don't want to do that, then you'll have to wait for
> this series to be finalized & merged next dev cycle:
>
>   https://lists.nongnu.org/archive/html/qemu-devel/2024-08/msg01173.html
>
> It is getting close to ready, so might not be too long, but I can't
> guarantee a timeframe.
>

Thanks Daniel! It looks like returning the buffers is the way to move
forward for now.

Regards,
Dorjoy

