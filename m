Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8D407C3ABA6
	for <qemu-devel@archiver.kernel.org>; Sun, 15 Sep 2024 19:47:56 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1spvDC-0005g1-RT; Sun, 15 Sep 2024 15:47:10 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dorjoychy111@gmail.com>)
 id 1spvDA-0005eo-VD
 for qemu-devel@nongnu.org; Sun, 15 Sep 2024 15:47:09 -0400
Received: from mail-vk1-xa33.google.com ([2607:f8b0:4864:20::a33])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <dorjoychy111@gmail.com>)
 id 1spvD7-0003xJ-0U
 for qemu-devel@nongnu.org; Sun, 15 Sep 2024 15:47:08 -0400
Received: by mail-vk1-xa33.google.com with SMTP id
 71dfb90a1353d-5010861905bso2263716e0c.1
 for <qemu-devel@nongnu.org>; Sun, 15 Sep 2024 12:47:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1726429624; x=1727034424; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=ZN+Md7gV8MIDy/4+GJcTm5N5jSgqAdy7zJdKrXT/WFU=;
 b=iAL8WjEQx8B0tm5HWn3snY9rdOeLSpyf+XtAjHIFZG7lH8F3sSfNBA5/0wnzvHTnCi
 hb2iuVkrbCwhn7v+SmcZ9r03EWZbnJELZg/nD4HNqgRpym109qH6pg9Fls8pU1WQEh4m
 VxTc1QhtENd8TZ5zQm+qyfcJOLPA6t+ORLvcFgaYyZS+s8YBeomJ3p9HqAtHA3XDwxlO
 8gsnQgwGLnChXx7N2rE4f8pr9V+ApnEPCd75HpZgIWr1uxHpv9oCvn/qoyHEYTX1fOyw
 J3bkHqyn5t6B7t0C9UPoabGegyjeWcTrO/ft2M3KaBgnFQcvDYB+ahWPW/gDyScHeLj/
 e3zg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1726429624; x=1727034424;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=ZN+Md7gV8MIDy/4+GJcTm5N5jSgqAdy7zJdKrXT/WFU=;
 b=jvXJfwfcWa18+tZGyTy/pQJBOjtWO8LHfpvxo9QLBwkgTRhBlgWt5OK8jH0gwru7Ao
 4iVzW2RTrNiOPFBldVgM/s+RGWsb0G3B77CuaQBkLLVN0WjaABnG9DeajVLM8svtnhA+
 nU7aBiDjdQcjJWPv7spw+GqlI9cNARNyetwbTCHIJp1qMOFtdc/IV8mIwnLlBhCZhsgh
 A50+FKQkrvEo39btIs318z/qE6qdJ28aGzogNVSioBUeut/oxCVsr120Winen7Ssw6pD
 hXwDqiYMdlXhylrikVOA8Gl25y9rcjU6dc+pAlBvviyn4ZqMqU1CBBJ3cTE7Md4tBFjE
 u/tw==
X-Gm-Message-State: AOJu0YzRkxGYqVG/2lFG15B/uz/AIEZevtIHHi6oDJ39WmRfvICa6fR+
 k6mGSbmcdpH8w7U/5Ya5q7GBBbLJjaWRb9FsQIxWoRus4hA+OpBdLsO7c22x89qbD58EiMa6YTW
 qjdT6j59hGOPc319nmyKyqwLgUyc=
X-Google-Smtp-Source: AGHT+IHnIGl+RCmdYMwPrT99GMiLWbRErR8I7ROaKgV55KMEY5gR4EvVIY2QLDYI+E8axR5IYyEOqtLGXwDh4Kl4Rqc=
X-Received: by 2002:a05:6122:1da7:b0:502:b69c:b239 with SMTP id
 71dfb90a1353d-502f76ba9e2mr18583707e0c.4.1726429623804; Sun, 15 Sep 2024
 12:47:03 -0700 (PDT)
MIME-Version: 1.0
References: <20240905195735.16911-1-dorjoychy111@gmail.com>
 <20240905195735.16911-6-dorjoychy111@gmail.com>
 <20240915152546-mutt-send-email-mst@kernel.org>
In-Reply-To: <20240915152546-mutt-send-email-mst@kernel.org>
From: Dorjoy Chowdhury <dorjoychy111@gmail.com>
Date: Mon, 16 Sep 2024 01:46:52 +0600
Message-ID: <CAFfO_h4pcz=2n+r5FzpDU1+hvjLRkQXFzLtuEkTQnu5csnyi=Q@mail.gmail.com>
Subject: Re: [PATCH v6 5/8] device/virtio-nsm: Support for Nitro Secure Module
 device
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: qemu-devel@nongnu.org, Alexander Graf <graf@amazon.com>, 
 Alexander Graf <agraf@csgraf.de>, stefanha@redhat.com,
 Paolo Bonzini <pbonzini@redhat.com>, 
 slp@redhat.com, Richard Henderson <richard.henderson@linaro.org>,
 eduardo@habkost.net, marcel.apfelbaum@gmail.com,
 =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>, 
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@linaro.org>
Content-Type: multipart/alternative; boundary="00000000000074edea06222db8d3"
Received-SPF: pass client-ip=2607:f8b0:4864:20::a33;
 envelope-from=dorjoychy111@gmail.com; helo=mail-vk1-xa33.google.com
X-Spam_score_int: -17
X-Spam_score: -1.8
X-Spam_bar: -
X-Spam_report: (-1.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FREEMAIL_ENVFROM_END_DIGIT=0.25, FREEMAIL_FROM=0.001, HTML_MESSAGE=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

--00000000000074edea06222db8d3
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Sep 16, 2024, 1:26 AM Michael S. Tsirkin <mst@redhat.com> wrote:

> On Fri, Sep 06, 2024 at 01:57:32AM +0600, Dorjoy Chowdhury wrote:
> > Nitro Secure Module (NSM)[1] device is used in AWS Nitro Enclaves[2]
> > for stripped down TPM functionality like cryptographic attestation.
> > The requests to and responses from NSM device are CBOR[3] encoded.
> >
> > This commit adds support for NSM device in QEMU. Although related to
> > AWS Nitro Enclaves, the virito-nsm device is independent and can be
> > used in other machine types as well. The libcbor[4] library has been
> > used for the CBOR encoding and decoding functionalities.
> >
> > [1]
> https://lists.oasis-open.org/archives/virtio-comment/202310/msg00387.html
> > [2] https://docs.aws.amazon.com/enclaves/latest/user/nitro-enclave.html
> > [3] http://cbor.io/
> > [4] https://libcbor.readthedocs.io/en/latest/
> >
> > Signed-off-by: Dorjoy Chowdhury <dorjoychy111@gmail.com>
> > ---
> >  MAINTAINERS                      |   10 +
> >  hw/virtio/Kconfig                |    5 +
> >  hw/virtio/cbor-helpers.c         |  326 ++++++
> >  hw/virtio/meson.build            |    6 +
> >  hw/virtio/virtio-nsm-pci.c       |   73 ++
> >  hw/virtio/virtio-nsm.c           | 1665 ++++++++++++++++++++++++++++++
> >  include/hw/virtio/cbor-helpers.h |   46 +
> >  include/hw/virtio/virtio-nsm.h   |   59 ++
> >  meson.build                      |    2 +
> >  9 files changed, 2192 insertions(+)
> >  create mode 100644 hw/virtio/cbor-helpers.c
> >  create mode 100644 hw/virtio/virtio-nsm-pci.c
> >  create mode 100644 hw/virtio/virtio-nsm.c
> >  create mode 100644 include/hw/virtio/cbor-helpers.h
> >  create mode 100644 include/hw/virtio/virtio-nsm.h
> >
> > diff --git a/MAINTAINERS b/MAINTAINERS
> > index c14ac014e2..b371c24747 100644
> > --- a/MAINTAINERS
> > +++ b/MAINTAINERS
> > @@ -2342,6 +2342,16 @@ F: include/sysemu/rng*.h
> >  F: backends/rng*.c
> >  F: tests/qtest/virtio-rng-test.c
> >
> > +virtio-nsm
> > +M: Alexander Graf <graf@amazon.com>
> > +M: Dorjoy Chowdhury <dorjoychy111@gmail.com>
> > +S: Maintained
> > +F: hw/virtio/cbor-helpers.c
> > +F: hw/virtio/virtio-nsm.c
> > +F: hw/virtio/virtio-nsm-pci.c
> > +F: include/hw/virtio/cbor-helpers.h
> > +F: include/hw/virtio/virtio-nsm.h
> > +
> >  vhost-user-stubs
> >  M: Alex Benn=C3=A9e <alex.bennee@linaro.org>
> >  S: Maintained
> > diff --git a/hw/virtio/Kconfig b/hw/virtio/Kconfig
> > index aa63ff7fd4..29fee32035 100644
> > --- a/hw/virtio/Kconfig
> > +++ b/hw/virtio/Kconfig
> > @@ -6,6 +6,11 @@ config VIRTIO_RNG
> >      default y
> >      depends on VIRTIO
> >
> > +config VIRTIO_NSM
> > +   bool
> > +   default y
> > +   depends on VIRTIO
> > +
> >  config VIRTIO_IOMMU
> >      bool
> >      default y
> > diff --git a/hw/virtio/cbor-helpers.c b/hw/virtio/cbor-helpers.c
> > new file mode 100644
> > index 0000000000..a0e58d6862
> > --- /dev/null
> > +++ b/hw/virtio/cbor-helpers.c
> > @@ -0,0 +1,326 @@
> > +/*
> > + * QEMU CBOR helpers
> > + *
> > + * Copyright (c) 2024 Dorjoy Chowdhury <dorjoychy111@gmail.com>
> > + *
> > + * This work is licensed under the terms of the GNU GPL, version 2 or
> > + * (at your option) any later version.  See the COPYING file in the
> > + * top-level directory.
> > + */
> > +
> > +#include "hw/virtio/cbor-helpers.h"
> > +
> > +bool qemu_cbor_map_add(cbor_item_t *map, cbor_item_t *key, cbor_item_t
> *value)
> > +{
> > +    bool success =3D false;
> > +    struct cbor_pair pair =3D (struct cbor_pair) {
> > +        .key =3D cbor_move(key),
> > +        .value =3D cbor_move(value)
> > +    };
> > +
> > +    success =3D cbor_map_add(map, pair);
> > +    if (!success) {
> > +        cbor_incref(pair.key);
> > +        cbor_incref(pair.value);
> > +    }
> > +
> > +    return success;
> > +}
> > +
> > +bool qemu_cbor_array_push(cbor_item_t *array, cbor_item_t *value)
> > +{
> > +    bool success =3D false;
> > +
> > +    success =3D cbor_array_push(array, cbor_move(value));
> > +    if (!success) {
> > +        cbor_incref(value);
> > +    }
> > +
> > +    return success;
> > +}
> > +
> > +bool qemu_cbor_add_bool_to_map(cbor_item_t *map, const char *key, bool
> value)
> > +{
> > +    cbor_item_t *key_cbor =3D NULL;
> > +    cbor_item_t *value_cbor =3D NULL;
> > +
> > +    key_cbor =3D cbor_build_string(key);
> > +    if (!key_cbor) {
> > +        goto cleanup;
> > +    }
> > +    value_cbor =3D cbor_build_bool(value);
> > +    if (!value_cbor) {
> > +        goto cleanup;
> > +    }
> > +    if (!qemu_cbor_map_add(map, key_cbor, value_cbor)) {
> > +        goto cleanup;
> > +    }
> > +
> > +    return true;
> > +
> > + cleanup:
> > +    if (key_cbor) {
> > +        cbor_decref(&key_cbor);
> > +    }
> > +    if (value_cbor) {
> > +        cbor_decref(&value_cbor);
> > +    }
> > +    return false;
> > +}
> > +
> > +bool qemu_cbor_add_uint8_to_map(cbor_item_t *map, const char *key,
> > +                                uint8_t value)
> > +{
> > +    cbor_item_t *key_cbor =3D NULL;
> > +    cbor_item_t *value_cbor =3D NULL;
> > +
> > +    key_cbor =3D cbor_build_string(key);
> > +    if (!key_cbor) {
> > +        goto cleanup;
> > +    }
> > +    value_cbor =3D cbor_build_uint8(value);
> > +    if (!value_cbor) {
> > +        goto cleanup;
> > +    }
> > +    if (!qemu_cbor_map_add(map, key_cbor, value_cbor)) {
> > +        goto cleanup;
> > +    }
> > +
> > +    return true;
> > +
> > + cleanup:
> > +    if (key_cbor) {
> > +        cbor_decref(&key_cbor);
> > +    }
> > +    if (value_cbor) {
> > +        cbor_decref(&value_cbor);
> > +    }
> > +    return false;
> > +}
> > +
> > +bool qemu_cbor_add_map_to_map(cbor_item_t *map, const char *key,
> > +                              size_t nested_map_size,
> > +                              cbor_item_t **nested_map)
> > +{
> > +    cbor_item_t *key_cbor =3D NULL;
> > +    cbor_item_t *value_cbor =3D NULL;
> > +
> > +    key_cbor =3D cbor_build_string(key);
> > +    if (!key_cbor) {
> > +        goto cleanup;
> > +    }
> > +    value_cbor =3D cbor_new_definite_map(nested_map_size);
> > +    if (!value_cbor) {
> > +        goto cleanup;
> > +    }
> > +    if (!qemu_cbor_map_add(map, key_cbor, value_cbor)) {
> > +        goto cleanup;
> > +    }
> > +    *nested_map =3D value_cbor;
> > +
> > +    return true;
> > +
> > + cleanup:
> > +    if (key_cbor) {
> > +        cbor_decref(&key_cbor);
> > +    }
> > +    if (value_cbor) {
> > +        cbor_decref(&value_cbor);
> > +    }
> > +    return false;
> > +}
> > +
> > +bool qemu_cbor_add_bytestring_to_map(cbor_item_t *map, const char *key=
,
> > +                                     uint8_t *arr, size_t len)
> > +{
> > +    cbor_item_t *key_cbor =3D NULL;
> > +    cbor_item_t *value_cbor =3D NULL;
> > +
> > +    key_cbor =3D cbor_build_string(key);
> > +    if (!key_cbor) {
> > +        goto cleanup;
> > +    }
> > +    value_cbor =3D cbor_build_bytestring(arr, len);
> > +    if (!value_cbor) {
> > +        goto cleanup;
> > +    }
> > +    if (!qemu_cbor_map_add(map, key_cbor, value_cbor)) {
> > +        goto cleanup;
> > +    }
> > +
> > +    return true;
> > +
> > + cleanup:
> > +    if (key_cbor) {
> > +        cbor_decref(&key_cbor);
> > +    }
> > +    if (value_cbor) {
> > +        cbor_decref(&value_cbor);
> > +    }
> > +    return false;
> > +}
> > +
> > +bool qemu_cbor_add_bytestring_or_null_to_map(cbor_item_t *map, const
> char *key,
> > +                                             uint8_t *arr, size_t len)
> > +{
> > +    cbor_item_t *key_cbor =3D NULL;
> > +    cbor_item_t *value_cbor =3D NULL;
> > +
> > +    key_cbor =3D cbor_build_string(key);
> > +    if (!key_cbor) {
> > +        goto cleanup;
> > +    }
> > +    if (len) {
> > +        value_cbor =3D cbor_build_bytestring(arr, len);
> > +    } else {
> > +        value_cbor =3D cbor_new_null();
> > +    }
> > +    if (!value_cbor) {
> > +        goto cleanup;
> > +    }
> > +    if (!qemu_cbor_map_add(map, key_cbor, value_cbor)) {
> > +        goto cleanup;
> > +    }
> > +
> > +    return true;
> > +
> > + cleanup:
> > +    if (key_cbor) {
> > +        cbor_decref(&key_cbor);
> > +    }
> > +    if (value_cbor) {
> > +        cbor_decref(&value_cbor);
> > +    }
> > +    return false;
> > +}
> > +
> > +bool qemu_cbor_add_string_to_map(cbor_item_t *map, const char *key,
> > +                                 const char *value)
> > +{
> > +    cbor_item_t *key_cbor =3D NULL;
> > +    cbor_item_t *value_cbor =3D NULL;
> > +
> > +    key_cbor =3D cbor_build_string(key);
> > +    if (!key_cbor) {
> > +        goto cleanup;
> > +    }
> > +    value_cbor =3D cbor_build_string(value);
> > +    if (!value_cbor) {
> > +        goto cleanup;
> > +    }
> > +    if (!qemu_cbor_map_add(map, key_cbor, value_cbor)) {
> > +        goto cleanup;
> > +    }
> > +
> > +    return true;
> > +
> > + cleanup:
> > +    if (key_cbor) {
> > +        cbor_decref(&key_cbor);
> > +    }
> > +    if (value_cbor) {
> > +        cbor_decref(&value_cbor);
> > +    }
> > +    return false;
> > +}
> > +
> > +bool qemu_cbor_add_uint8_array_to_map(cbor_item_t *map, const char *ke=
y,
> > +                                      uint8_t *arr, size_t len)
> > +{
> > +    cbor_item_t *key_cbor =3D NULL;
> > +    cbor_item_t *value_cbor =3D NULL;
> > +
> > +    key_cbor =3D cbor_build_string(key);
> > +    if (!key_cbor) {
> > +        goto cleanup;
> > +    }
> > +    value_cbor =3D cbor_new_definite_array(len);
> > +    if (!value_cbor) {
> > +        goto cleanup;
> > +    }
> > +
> > +    for (int i =3D 0; i < len; ++i) {
> > +        cbor_item_t *tmp =3D cbor_build_uint8(arr[i]);
> > +        if (!tmp) {
> > +            goto cleanup;
> > +        }
> > +        if (!qemu_cbor_array_push(value_cbor, tmp)) {
> > +            cbor_decref(&tmp);
> > +            goto cleanup;
> > +        }
> > +    }
> > +    if (!qemu_cbor_map_add(map, key_cbor, value_cbor)) {
> > +        goto cleanup;
> > +    }
> > +
> > +    return true;
> > +
> > + cleanup:
> > +    if (key_cbor) {
> > +        cbor_decref(&key_cbor);
> > +    }
> > +    if (value_cbor) {
> > +        cbor_decref(&value_cbor);
> > +    }
> > +    return false;
> > +}
> > +
> > +bool qemu_cbor_add_uint8_key_bytestring_to_map(cbor_item_t *map,
> uint8_t key,
> > +                                               uint8_t *buf, size_t le=
n)
> > +{
> > +    cbor_item_t *key_cbor =3D NULL;
> > +    cbor_item_t *value_cbor =3D NULL;
> > +
> > +    key_cbor =3D cbor_build_uint8(key);
> > +    if (!key_cbor) {
> > +        goto cleanup;
> > +    }
> > +    value_cbor =3D cbor_build_bytestring(buf, len);
> > +    if (!value_cbor) {
> > +        goto cleanup;
> > +    }
> > +    if (!qemu_cbor_map_add(map, key_cbor, value_cbor)) {
> > +        goto cleanup;
> > +    }
> > +
> > +    return true;
> > +
> > + cleanup:
> > +    if (key_cbor) {
> > +        cbor_decref(&key_cbor);
> > +    }
> > +    if (value_cbor) {
> > +        cbor_decref(&value_cbor);
> > +    }
> > +    return false;
> > +}
> > +
> > +bool qemu_cbor_add_uint64_to_map(cbor_item_t *map, const char *key,
> > +                                 uint64_t value)
> > +{
> > +    cbor_item_t *key_cbor =3D NULL;
> > +    cbor_item_t *value_cbor =3D NULL;
> > +
> > +    key_cbor =3D cbor_build_string(key);
> > +    if (!key_cbor) {
> > +        goto cleanup;
> > +    }
> > +    value_cbor =3D cbor_build_uint64(value);
> > +    if (!value_cbor) {
> > +        goto cleanup;
> > +    }
> > +    if (!qemu_cbor_map_add(map, key_cbor, value_cbor)) {
> > +        goto cleanup;
> > +    }
> > +
> > +    return true;
> > +
> > + cleanup:
> > +    if (key_cbor) {
> > +        cbor_decref(&key_cbor);
> > +    }
> > +    if (value_cbor) {
> > +        cbor_decref(&value_cbor);
> > +    }
> > +    return false;
> > +}
> > diff --git a/hw/virtio/meson.build b/hw/virtio/meson.build
> > index 621fc65454..1fe7cb4d72 100644
> > --- a/hw/virtio/meson.build
> > +++ b/hw/virtio/meson.build
> > @@ -54,6 +54,9 @@ specific_virtio_ss.add(when: 'CONFIG_VIRTIO_PMEM',
> if_true: files('virtio-pmem.c
> >  specific_virtio_ss.add(when: 'CONFIG_VHOST_VSOCK', if_true:
> files('vhost-vsock.c'))
> >  specific_virtio_ss.add(when: 'CONFIG_VHOST_USER_VSOCK', if_true:
> files('vhost-user-vsock.c'))
> >  specific_virtio_ss.add(when: 'CONFIG_VIRTIO_RNG', if_true:
> files('virtio-rng.c'))
> > +if libcbor.found()
> > +  specific_virtio_ss.add(when: 'CONFIG_VIRTIO_NSM', if_true:
> [files('virtio-nsm.c', 'cbor-helpers.c'), libcbor])
> > +endif
> >  specific_virtio_ss.add(when: 'CONFIG_VIRTIO_MEM', if_true:
> files('virtio-mem.c'))
> >  specific_virtio_ss.add(when: 'CONFIG_VHOST_USER_SCMI', if_true:
> files('vhost-user-scmi.c'))
> >  specific_virtio_ss.add(when: ['CONFIG_VIRTIO_PCI',
> 'CONFIG_VHOST_USER_SCMI'], if_true: files('vhost-user-scmi-pci.c'))
> > @@ -70,6 +73,9 @@ virtio_pci_ss.add(when: 'CONFIG_VIRTIO_CRYPTO',
> if_true: files('virtio-crypto-pc
> >  virtio_pci_ss.add(when: 'CONFIG_VIRTIO_INPUT_HOST', if_true:
> files('virtio-input-host-pci.c'))
> >  virtio_pci_ss.add(when: 'CONFIG_VIRTIO_INPUT', if_true:
> files('virtio-input-pci.c'))
> >  virtio_pci_ss.add(when: 'CONFIG_VIRTIO_RNG', if_true:
> files('virtio-rng-pci.c'))
> > +if libcbor.found()
> > +  virtio_pci_ss.add(when: 'CONFIG_VIRTIO_NSM', if_true:
> [files('virtio-nsm-pci.c', 'cbor-helpers.c'), libcbor])
> > +endif
> >  virtio_pci_ss.add(when: 'CONFIG_VIRTIO_BALLOON', if_true:
> files('virtio-balloon-pci.c'))
> >  virtio_pci_ss.add(when: 'CONFIG_VIRTIO_9P', if_true:
> files('virtio-9p-pci.c'))
> >  virtio_pci_ss.add(when: 'CONFIG_VIRTIO_SCSI', if_true:
> files('virtio-scsi-pci.c'))
> > diff --git a/hw/virtio/virtio-nsm-pci.c b/hw/virtio/virtio-nsm-pci.c
> > new file mode 100644
> > index 0000000000..dca797315a
> > --- /dev/null
> > +++ b/hw/virtio/virtio-nsm-pci.c
> > @@ -0,0 +1,73 @@
> > +/*
> > + * AWS Nitro Secure Module (NSM) device
> > + *
> > + * Copyright (c) 2024 Dorjoy Chowdhury <dorjoychy111@gmail.com>
> > + *
> > + * This work is licensed under the terms of the GNU GPL, version 2 or
> > + * (at your option) any later version.  See the COPYING file in the
> > + * top-level directory.
> > + */
> > +
> > +#include "qemu/osdep.h"
> > +
> > +#include "hw/virtio/virtio-pci.h"
> > +#include "hw/virtio/virtio-nsm.h"
> > +#include "hw/qdev-properties.h"
> > +#include "qapi/error.h"
> > +#include "qemu/module.h"
> > +#include "qom/object.h"
> > +
> > +typedef struct VirtIONsmPCI VirtIONsmPCI;
> > +
> > +#define TYPE_VIRTIO_NSM_PCI "virtio-nsm-pci-base"
> > +DECLARE_INSTANCE_CHECKER(VirtIONsmPCI, VIRTIO_NSM_PCI,
> > +                         TYPE_VIRTIO_NSM_PCI)
> > +
> > +struct VirtIONsmPCI {
> > +    VirtIOPCIProxy parent_obj;
> > +    VirtIONSM vdev;
> > +};
> > +
> > +static void virtio_nsm_pci_realize(VirtIOPCIProxy *vpci_dev, Error
> **errp)
> > +{
> > +    VirtIONsmPCI *vnsm =3D VIRTIO_NSM_PCI(vpci_dev);
> > +    DeviceState *vdev =3D DEVICE(&vnsm->vdev);
> > +
> > +    virtio_pci_force_virtio_1(vpci_dev);
> > +
> > +    if (!qdev_realize(vdev, BUS(&vpci_dev->bus), errp)) {
> > +        return;
> > +    }
> > +}
> > +
> > +static void virtio_nsm_pci_class_init(ObjectClass *klass, void *data)
> > +{
> > +    DeviceClass *dc =3D DEVICE_CLASS(klass);
> > +    VirtioPCIClass *k =3D VIRTIO_PCI_CLASS(klass);
> > +
> > +    k->realize =3D virtio_nsm_pci_realize;
> > +    set_bit(DEVICE_CATEGORY_MISC, dc->categories);
> > +}
> > +
> > +static void virtio_nsm_initfn(Object *obj)
> > +{
> > +    VirtIONsmPCI *dev =3D VIRTIO_NSM_PCI(obj);
> > +
> > +    virtio_instance_init_common(obj, &dev->vdev, sizeof(dev->vdev),
> > +                                TYPE_VIRTIO_NSM);
> > +}
> > +
> > +static const VirtioPCIDeviceTypeInfo virtio_nsm_pci_info =3D {
> > +    .base_name             =3D TYPE_VIRTIO_NSM_PCI,
> > +    .generic_name          =3D "virtio-nsm-pci",
> > +    .instance_size =3D sizeof(VirtIONsmPCI),
> > +    .instance_init =3D virtio_nsm_initfn,
> > +    .class_init    =3D virtio_nsm_pci_class_init,
> > +};
> > +
> > +static void virtio_nsm_pci_register(void)
> > +{
> > +    virtio_pci_types_register(&virtio_nsm_pci_info);
> > +}
> > +
> > +type_init(virtio_nsm_pci_register)
> > diff --git a/hw/virtio/virtio-nsm.c b/hw/virtio/virtio-nsm.c
> > new file mode 100644
> > index 0000000000..0f4edd92ff
> > --- /dev/null
> > +++ b/hw/virtio/virtio-nsm.c
> > @@ -0,0 +1,1665 @@
> > +/*
> > + * AWS Nitro Secure Module (NSM) device
> > + *
> > + * Copyright (c) 2024 Dorjoy Chowdhury <dorjoychy111@gmail.com>
> > + *
> > + * This work is licensed under the terms of the GNU GPL, version 2 or
> > + * (at your option) any later version.  See the COPYING file in the
> > + * top-level directory.
> > + */
> > +
> > +#include "qemu/osdep.h"
> > +#include "qemu/iov.h"
> > +#include "qemu/guest-random.h"
> > +#include "qapi/error.h"
> > +
> > +#include "crypto/hash.h"
> > +#include "hw/virtio/virtio.h"
> > +#include "hw/virtio/virtio-nsm.h"
> > +#include "hw/virtio/cbor-helpers.h"
> > +#include "standard-headers/linux/virtio_ids.h"
> > +
> > +#define NSM_RESPONSE_BUF_SIZE     0x3000
> > +#define NSM_PCR_DATA_REQ_MAX_SIZE 512
> > +
> > +enum NSMResponseTypes {
> > +    NSM_SUCCESS =3D 0,
> > +    NSM_INVALID_ARGUMENT =3D 1,
> > +    NSM_INVALID_INDEX =3D 2,
> > +    NSM_READONLY_INDEX =3D 3,
> > +    NSM_INVALID_OPERATION =3D 4,
> > +    NSM_BUFFER_TOO_SMALL =3D 5,
> > +    NSM_INPUT_TOO_LARGE =3D 6,
> > +    NSM_INTERNAL_ERROR =3D 7,
> > +};
> > +
> > +static const char *error_string(enum NSMResponseTypes type)
> > +{
> > +    const char *str;
> > +    switch (type) {
> > +    case NSM_INVALID_ARGUMENT:
> > +        str =3D "InvalidArgument";
> > +        break;
> > +    case NSM_INVALID_INDEX:
> > +        str =3D "InvalidIndex";
> > +        break;
> > +    case NSM_READONLY_INDEX:
> > +        str =3D "ReadOnlyIndex";
> > +        break;
> > +    case NSM_INVALID_OPERATION:
> > +        str =3D "InvalidOperation";
> > +        break;
> > +    case NSM_BUFFER_TOO_SMALL:
> > +        str =3D "BufferTooSmall";
> > +        break;
> > +    case NSM_INPUT_TOO_LARGE:
> > +        str =3D "InputTooLarge";
> > +        break;
> > +    default:
> > +        str =3D "InternalError";
> > +        break;
> > +    }
> > +
> > +    return str;
> > +}
> > +
> > +/*
> > + * Error response structure:
> > + *
> > + * {
> > + *   Map(1) {
> > + *     key =3D String("Error"),
> > + *     value =3D String(error_name)
> > + *   }
> > + * }
> > + *
> > + * where error_name can be one of the following:
> > + *   InvalidArgument
> > + *   InvalidIndex
> > + *   InvalidResponse
> > + *   ReadOnlyIndex
> > + *   InvalidOperation
> > + *   BufferTooSmall
> > + *   InputTooLarge
> > + *   InternalError
> > + */
> > +
> > +static bool error_response(struct iovec *response, enum
> NSMResponseTypes error,
> > +                           Error **errp)
> > +{
> > +    cbor_item_t *root;
> > +    size_t len;
> > +    bool r =3D false;
> > +
> > +    root =3D cbor_new_definite_map(1);
> > +    if (!root) {
> > +        goto err;
> > +    }
> > +
> > +    if (!qemu_cbor_add_string_to_map(root, "Error",
> error_string(error))) {
> > +        goto err;
> > +    }
> > +
> > +    len =3D cbor_serialize(root, response->iov_base, response->iov_len=
);
>
> As far as I can tell, all these also need to be switched to use
> iov_from_buf.
>

Sorry I didn't understand this. The iovecs passed in these functions are
not the iovecs from virtqueue. We make an iovec for the response and then
pass it down. We do the "iov_from_buf" after calling
"get_nsm_request_response" in "handle_input" function. Am I missing
something?

Regards,
Dorjoy

--00000000000074edea06222db8d3
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"auto"><div><br><br><div class=3D"gmail_quote"><div dir=3D"ltr" =
class=3D"gmail_attr">On Mon, Sep 16, 2024, 1:26 AM Michael S. Tsirkin &lt;<=
a href=3D"mailto:mst@redhat.com" target=3D"_blank" rel=3D"noreferrer">mst@r=
edhat.com</a>&gt; wrote:<br></div><blockquote class=3D"gmail_quote" style=
=3D"margin:0 0 0 .8ex;border-left:1px #ccc solid;padding-left:1ex">On Fri, =
Sep 06, 2024 at 01:57:32AM +0600, Dorjoy Chowdhury wrote:<br>
&gt; Nitro Secure Module (NSM)[1] device is used in AWS Nitro Enclaves[2]<b=
r>
&gt; for stripped down TPM functionality like cryptographic attestation.<br=
>
&gt; The requests to and responses from NSM device are CBOR[3] encoded.<br>
&gt; <br>
&gt; This commit adds support for NSM device in QEMU. Although related to<b=
r>
&gt; AWS Nitro Enclaves, the virito-nsm device is independent and can be<br=
>
&gt; used in other machine types as well. The libcbor[4] library has been<b=
r>
&gt; used for the CBOR encoding and decoding functionalities.<br>
&gt; <br>
&gt; [1] <a href=3D"https://lists.oasis-open.org/archives/virtio-comment/20=
2310/msg00387.html" rel=3D"noreferrer noreferrer noreferrer" target=3D"_bla=
nk">https://lists.oasis-open.org/archives/virtio-comment/202310/msg00387.ht=
ml</a><br>
&gt; [2] <a href=3D"https://docs.aws.amazon.com/enclaves/latest/user/nitro-=
enclave.html" rel=3D"noreferrer noreferrer noreferrer" target=3D"_blank">ht=
tps://docs.aws.amazon.com/enclaves/latest/user/nitro-enclave.html</a><br>
&gt; [3] <a href=3D"http://cbor.io/" rel=3D"noreferrer noreferrer noreferre=
r" target=3D"_blank">http://cbor.io/</a><br>
&gt; [4] <a href=3D"https://libcbor.readthedocs.io/en/latest/" rel=3D"noref=
errer noreferrer noreferrer" target=3D"_blank">https://libcbor.readthedocs.=
io/en/latest/</a><br>
&gt; <br>
&gt; Signed-off-by: Dorjoy Chowdhury &lt;<a href=3D"mailto:dorjoychy111@gma=
il.com" rel=3D"noreferrer noreferrer" target=3D"_blank">dorjoychy111@gmail.=
com</a>&gt;<br>
&gt; ---<br>
&gt;=C2=A0 MAINTAINERS=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 |=C2=A0 =C2=A010 +<br>
&gt;=C2=A0 hw/virtio/Kconfig=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 |=C2=A0 =C2=A0 5 +<br>
&gt;=C2=A0 hw/virtio/cbor-helpers.c=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0|=C2=
=A0 326 ++++++<br>
&gt;=C2=A0 hw/virtio/meson.build=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 |=
=C2=A0 =C2=A0 6 +<br>
&gt;=C2=A0 hw/virtio/virtio-nsm-pci.c=C2=A0 =C2=A0 =C2=A0 =C2=A0|=C2=A0 =C2=
=A073 ++<br>
&gt;=C2=A0 hw/virtio/virtio-nsm.c=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0|=
 1665 ++++++++++++++++++++++++++++++<br>
&gt;=C2=A0 include/hw/virtio/cbor-helpers.h |=C2=A0 =C2=A046 +<br>
&gt;=C2=A0 include/hw/virtio/virtio-nsm.h=C2=A0 =C2=A0|=C2=A0 =C2=A059 ++<b=
r>
&gt;=C2=A0 meson.build=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 |=C2=A0 =C2=A0 2 +<br>
&gt;=C2=A0 9 files changed, 2192 insertions(+)<br>
&gt;=C2=A0 create mode 100644 hw/virtio/cbor-helpers.c<br>
&gt;=C2=A0 create mode 100644 hw/virtio/virtio-nsm-pci.c<br>
&gt;=C2=A0 create mode 100644 hw/virtio/virtio-nsm.c<br>
&gt;=C2=A0 create mode 100644 include/hw/virtio/cbor-helpers.h<br>
&gt;=C2=A0 create mode 100644 include/hw/virtio/virtio-nsm.h<br>
&gt; <br>
&gt; diff --git a/MAINTAINERS b/MAINTAINERS<br>
&gt; index c14ac014e2..b371c24747 100644<br>
&gt; --- a/MAINTAINERS<br>
&gt; +++ b/MAINTAINERS<br>
&gt; @@ -2342,6 +2342,16 @@ F: include/sysemu/rng*.h<br>
&gt;=C2=A0 F: backends/rng*.c<br>
&gt;=C2=A0 F: tests/qtest/virtio-rng-test.c<br>
&gt;=C2=A0 <br>
&gt; +virtio-nsm<br>
&gt; +M: Alexander Graf &lt;<a href=3D"mailto:graf@amazon.com" rel=3D"noref=
errer noreferrer" target=3D"_blank">graf@amazon.com</a>&gt;<br>
&gt; +M: Dorjoy Chowdhury &lt;<a href=3D"mailto:dorjoychy111@gmail.com" rel=
=3D"noreferrer noreferrer" target=3D"_blank">dorjoychy111@gmail.com</a>&gt;=
<br>
&gt; +S: Maintained<br>
&gt; +F: hw/virtio/cbor-helpers.c<br>
&gt; +F: hw/virtio/virtio-nsm.c<br>
&gt; +F: hw/virtio/virtio-nsm-pci.c<br>
&gt; +F: include/hw/virtio/cbor-helpers.h<br>
&gt; +F: include/hw/virtio/virtio-nsm.h<br>
&gt; +<br>
&gt;=C2=A0 vhost-user-stubs<br>
&gt;=C2=A0 M: Alex Benn=C3=A9e &lt;<a href=3D"mailto:alex.bennee@linaro.org=
" rel=3D"noreferrer noreferrer" target=3D"_blank">alex.bennee@linaro.org</a=
>&gt;<br>
&gt;=C2=A0 S: Maintained<br>
&gt; diff --git a/hw/virtio/Kconfig b/hw/virtio/Kconfig<br>
&gt; index aa63ff7fd4..29fee32035 100644<br>
&gt; --- a/hw/virtio/Kconfig<br>
&gt; +++ b/hw/virtio/Kconfig<br>
&gt; @@ -6,6 +6,11 @@ config VIRTIO_RNG<br>
&gt;=C2=A0 =C2=A0 =C2=A0 default y<br>
&gt;=C2=A0 =C2=A0 =C2=A0 depends on VIRTIO<br>
&gt;=C2=A0 <br>
&gt; +config VIRTIO_NSM<br>
&gt; +=C2=A0 =C2=A0bool<br>
&gt; +=C2=A0 =C2=A0default y<br>
&gt; +=C2=A0 =C2=A0depends on VIRTIO<br>
&gt; +<br>
&gt;=C2=A0 config VIRTIO_IOMMU<br>
&gt;=C2=A0 =C2=A0 =C2=A0 bool<br>
&gt;=C2=A0 =C2=A0 =C2=A0 default y<br>
&gt; diff --git a/hw/virtio/cbor-helpers.c b/hw/virtio/cbor-helpers.c<br>
&gt; new file mode 100644<br>
&gt; index 0000000000..a0e58d6862<br>
&gt; --- /dev/null<br>
&gt; +++ b/hw/virtio/cbor-helpers.c<br>
&gt; @@ -0,0 +1,326 @@<br>
&gt; +/*<br>
&gt; + * QEMU CBOR helpers<br>
&gt; + *<br>
&gt; + * Copyright (c) 2024 Dorjoy Chowdhury &lt;<a href=3D"mailto:dorjoych=
y111@gmail.com" rel=3D"noreferrer noreferrer" target=3D"_blank">dorjoychy11=
1@gmail.com</a>&gt;<br>
&gt; + *<br>
&gt; + * This work is licensed under the terms of the GNU GPL, version 2 or=
<br>
&gt; + * (at your option) any later version.=C2=A0 See the COPYING file in =
the<br>
&gt; + * top-level directory.<br>
&gt; + */<br>
&gt; +<br>
&gt; +#include &quot;hw/virtio/cbor-helpers.h&quot;<br>
&gt; +<br>
&gt; +bool qemu_cbor_map_add(cbor_item_t *map, cbor_item_t *key, cbor_item_=
t *value)<br>
&gt; +{<br>
&gt; +=C2=A0 =C2=A0 bool success =3D false;<br>
&gt; +=C2=A0 =C2=A0 struct cbor_pair pair =3D (struct cbor_pair) {<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 .key =3D cbor_move(key),<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 .value =3D cbor_move(value)<br>
&gt; +=C2=A0 =C2=A0 };<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 success =3D cbor_map_add(map, pair);<br>
&gt; +=C2=A0 =C2=A0 if (!success) {<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 cbor_incref(pair.key);<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 cbor_incref(pair.value);<br>
&gt; +=C2=A0 =C2=A0 }<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 return success;<br>
&gt; +}<br>
&gt; +<br>
&gt; +bool qemu_cbor_array_push(cbor_item_t *array, cbor_item_t *value)<br>
&gt; +{<br>
&gt; +=C2=A0 =C2=A0 bool success =3D false;<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 success =3D cbor_array_push(array, cbor_move(value));<b=
r>
&gt; +=C2=A0 =C2=A0 if (!success) {<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 cbor_incref(value);<br>
&gt; +=C2=A0 =C2=A0 }<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 return success;<br>
&gt; +}<br>
&gt; +<br>
&gt; +bool qemu_cbor_add_bool_to_map(cbor_item_t *map, const char *key, boo=
l value)<br>
&gt; +{<br>
&gt; +=C2=A0 =C2=A0 cbor_item_t *key_cbor =3D NULL;<br>
&gt; +=C2=A0 =C2=A0 cbor_item_t *value_cbor =3D NULL;<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 key_cbor =3D cbor_build_string(key);<br>
&gt; +=C2=A0 =C2=A0 if (!key_cbor) {<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 goto cleanup;<br>
&gt; +=C2=A0 =C2=A0 }<br>
&gt; +=C2=A0 =C2=A0 value_cbor =3D cbor_build_bool(value);<br>
&gt; +=C2=A0 =C2=A0 if (!value_cbor) {<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 goto cleanup;<br>
&gt; +=C2=A0 =C2=A0 }<br>
&gt; +=C2=A0 =C2=A0 if (!qemu_cbor_map_add(map, key_cbor, value_cbor)) {<br=
>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 goto cleanup;<br>
&gt; +=C2=A0 =C2=A0 }<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 return true;<br>
&gt; +<br>
&gt; + cleanup:<br>
&gt; +=C2=A0 =C2=A0 if (key_cbor) {<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 cbor_decref(&amp;key_cbor);<br>
&gt; +=C2=A0 =C2=A0 }<br>
&gt; +=C2=A0 =C2=A0 if (value_cbor) {<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 cbor_decref(&amp;value_cbor);<br>
&gt; +=C2=A0 =C2=A0 }<br>
&gt; +=C2=A0 =C2=A0 return false;<br>
&gt; +}<br>
&gt; +<br>
&gt; +bool qemu_cbor_add_uint8_to_map(cbor_item_t *map, const char *key,<br=
>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 uint8_t value)<br>
&gt; +{<br>
&gt; +=C2=A0 =C2=A0 cbor_item_t *key_cbor =3D NULL;<br>
&gt; +=C2=A0 =C2=A0 cbor_item_t *value_cbor =3D NULL;<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 key_cbor =3D cbor_build_string(key);<br>
&gt; +=C2=A0 =C2=A0 if (!key_cbor) {<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 goto cleanup;<br>
&gt; +=C2=A0 =C2=A0 }<br>
&gt; +=C2=A0 =C2=A0 value_cbor =3D cbor_build_uint8(value);<br>
&gt; +=C2=A0 =C2=A0 if (!value_cbor) {<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 goto cleanup;<br>
&gt; +=C2=A0 =C2=A0 }<br>
&gt; +=C2=A0 =C2=A0 if (!qemu_cbor_map_add(map, key_cbor, value_cbor)) {<br=
>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 goto cleanup;<br>
&gt; +=C2=A0 =C2=A0 }<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 return true;<br>
&gt; +<br>
&gt; + cleanup:<br>
&gt; +=C2=A0 =C2=A0 if (key_cbor) {<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 cbor_decref(&amp;key_cbor);<br>
&gt; +=C2=A0 =C2=A0 }<br>
&gt; +=C2=A0 =C2=A0 if (value_cbor) {<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 cbor_decref(&amp;value_cbor);<br>
&gt; +=C2=A0 =C2=A0 }<br>
&gt; +=C2=A0 =C2=A0 return false;<br>
&gt; +}<br>
&gt; +<br>
&gt; +bool qemu_cbor_add_map_to_map(cbor_item_t *map, const char *key,<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 size_t nested_map_size,<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 cbor_item_t **nested_map)<br>
&gt; +{<br>
&gt; +=C2=A0 =C2=A0 cbor_item_t *key_cbor =3D NULL;<br>
&gt; +=C2=A0 =C2=A0 cbor_item_t *value_cbor =3D NULL;<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 key_cbor =3D cbor_build_string(key);<br>
&gt; +=C2=A0 =C2=A0 if (!key_cbor) {<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 goto cleanup;<br>
&gt; +=C2=A0 =C2=A0 }<br>
&gt; +=C2=A0 =C2=A0 value_cbor =3D cbor_new_definite_map(nested_map_size);<=
br>
&gt; +=C2=A0 =C2=A0 if (!value_cbor) {<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 goto cleanup;<br>
&gt; +=C2=A0 =C2=A0 }<br>
&gt; +=C2=A0 =C2=A0 if (!qemu_cbor_map_add(map, key_cbor, value_cbor)) {<br=
>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 goto cleanup;<br>
&gt; +=C2=A0 =C2=A0 }<br>
&gt; +=C2=A0 =C2=A0 *nested_map =3D value_cbor;<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 return true;<br>
&gt; +<br>
&gt; + cleanup:<br>
&gt; +=C2=A0 =C2=A0 if (key_cbor) {<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 cbor_decref(&amp;key_cbor);<br>
&gt; +=C2=A0 =C2=A0 }<br>
&gt; +=C2=A0 =C2=A0 if (value_cbor) {<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 cbor_decref(&amp;value_cbor);<br>
&gt; +=C2=A0 =C2=A0 }<br>
&gt; +=C2=A0 =C2=A0 return false;<br>
&gt; +}<br>
&gt; +<br>
&gt; +bool qemu_cbor_add_bytestring_to_map(cbor_item_t *map, const char *ke=
y,<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0uint8_t *arr=
, size_t len)<br>
&gt; +{<br>
&gt; +=C2=A0 =C2=A0 cbor_item_t *key_cbor =3D NULL;<br>
&gt; +=C2=A0 =C2=A0 cbor_item_t *value_cbor =3D NULL;<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 key_cbor =3D cbor_build_string(key);<br>
&gt; +=C2=A0 =C2=A0 if (!key_cbor) {<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 goto cleanup;<br>
&gt; +=C2=A0 =C2=A0 }<br>
&gt; +=C2=A0 =C2=A0 value_cbor =3D cbor_build_bytestring(arr, len);<br>
&gt; +=C2=A0 =C2=A0 if (!value_cbor) {<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 goto cleanup;<br>
&gt; +=C2=A0 =C2=A0 }<br>
&gt; +=C2=A0 =C2=A0 if (!qemu_cbor_map_add(map, key_cbor, value_cbor)) {<br=
>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 goto cleanup;<br>
&gt; +=C2=A0 =C2=A0 }<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 return true;<br>
&gt; +<br>
&gt; + cleanup:<br>
&gt; +=C2=A0 =C2=A0 if (key_cbor) {<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 cbor_decref(&amp;key_cbor);<br>
&gt; +=C2=A0 =C2=A0 }<br>
&gt; +=C2=A0 =C2=A0 if (value_cbor) {<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 cbor_decref(&amp;value_cbor);<br>
&gt; +=C2=A0 =C2=A0 }<br>
&gt; +=C2=A0 =C2=A0 return false;<br>
&gt; +}<br>
&gt; +<br>
&gt; +bool qemu_cbor_add_bytestring_or_null_to_map(cbor_item_t *map, const =
char *key,<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0uint8_t *arr, size_t len)<br>
&gt; +{<br>
&gt; +=C2=A0 =C2=A0 cbor_item_t *key_cbor =3D NULL;<br>
&gt; +=C2=A0 =C2=A0 cbor_item_t *value_cbor =3D NULL;<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 key_cbor =3D cbor_build_string(key);<br>
&gt; +=C2=A0 =C2=A0 if (!key_cbor) {<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 goto cleanup;<br>
&gt; +=C2=A0 =C2=A0 }<br>
&gt; +=C2=A0 =C2=A0 if (len) {<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 value_cbor =3D cbor_build_bytestring(arr,=
 len);<br>
&gt; +=C2=A0 =C2=A0 } else {<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 value_cbor =3D cbor_new_null();<br>
&gt; +=C2=A0 =C2=A0 }<br>
&gt; +=C2=A0 =C2=A0 if (!value_cbor) {<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 goto cleanup;<br>
&gt; +=C2=A0 =C2=A0 }<br>
&gt; +=C2=A0 =C2=A0 if (!qemu_cbor_map_add(map, key_cbor, value_cbor)) {<br=
>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 goto cleanup;<br>
&gt; +=C2=A0 =C2=A0 }<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 return true;<br>
&gt; +<br>
&gt; + cleanup:<br>
&gt; +=C2=A0 =C2=A0 if (key_cbor) {<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 cbor_decref(&amp;key_cbor);<br>
&gt; +=C2=A0 =C2=A0 }<br>
&gt; +=C2=A0 =C2=A0 if (value_cbor) {<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 cbor_decref(&amp;value_cbor);<br>
&gt; +=C2=A0 =C2=A0 }<br>
&gt; +=C2=A0 =C2=A0 return false;<br>
&gt; +}<br>
&gt; +<br>
&gt; +bool qemu_cbor_add_string_to_map(cbor_item_t *map, const char *key,<b=
r>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0const char *value)<br>
&gt; +{<br>
&gt; +=C2=A0 =C2=A0 cbor_item_t *key_cbor =3D NULL;<br>
&gt; +=C2=A0 =C2=A0 cbor_item_t *value_cbor =3D NULL;<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 key_cbor =3D cbor_build_string(key);<br>
&gt; +=C2=A0 =C2=A0 if (!key_cbor) {<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 goto cleanup;<br>
&gt; +=C2=A0 =C2=A0 }<br>
&gt; +=C2=A0 =C2=A0 value_cbor =3D cbor_build_string(value);<br>
&gt; +=C2=A0 =C2=A0 if (!value_cbor) {<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 goto cleanup;<br>
&gt; +=C2=A0 =C2=A0 }<br>
&gt; +=C2=A0 =C2=A0 if (!qemu_cbor_map_add(map, key_cbor, value_cbor)) {<br=
>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 goto cleanup;<br>
&gt; +=C2=A0 =C2=A0 }<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 return true;<br>
&gt; +<br>
&gt; + cleanup:<br>
&gt; +=C2=A0 =C2=A0 if (key_cbor) {<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 cbor_decref(&amp;key_cbor);<br>
&gt; +=C2=A0 =C2=A0 }<br>
&gt; +=C2=A0 =C2=A0 if (value_cbor) {<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 cbor_decref(&amp;value_cbor);<br>
&gt; +=C2=A0 =C2=A0 }<br>
&gt; +=C2=A0 =C2=A0 return false;<br>
&gt; +}<br>
&gt; +<br>
&gt; +bool qemu_cbor_add_uint8_array_to_map(cbor_item_t *map, const char *k=
ey,<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 uint8_t *ar=
r, size_t len)<br>
&gt; +{<br>
&gt; +=C2=A0 =C2=A0 cbor_item_t *key_cbor =3D NULL;<br>
&gt; +=C2=A0 =C2=A0 cbor_item_t *value_cbor =3D NULL;<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 key_cbor =3D cbor_build_string(key);<br>
&gt; +=C2=A0 =C2=A0 if (!key_cbor) {<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 goto cleanup;<br>
&gt; +=C2=A0 =C2=A0 }<br>
&gt; +=C2=A0 =C2=A0 value_cbor =3D cbor_new_definite_array(len);<br>
&gt; +=C2=A0 =C2=A0 if (!value_cbor) {<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 goto cleanup;<br>
&gt; +=C2=A0 =C2=A0 }<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 for (int i =3D 0; i &lt; len; ++i) {<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 cbor_item_t *tmp =3D cbor_build_uint8(arr=
[i]);<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 if (!tmp) {<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 goto cleanup;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 }<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 if (!qemu_cbor_array_push(value_cbor, tmp=
)) {<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 cbor_decref(&amp;tmp);<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 goto cleanup;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 }<br>
&gt; +=C2=A0 =C2=A0 }<br>
&gt; +=C2=A0 =C2=A0 if (!qemu_cbor_map_add(map, key_cbor, value_cbor)) {<br=
>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 goto cleanup;<br>
&gt; +=C2=A0 =C2=A0 }<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 return true;<br>
&gt; +<br>
&gt; + cleanup:<br>
&gt; +=C2=A0 =C2=A0 if (key_cbor) {<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 cbor_decref(&amp;key_cbor);<br>
&gt; +=C2=A0 =C2=A0 }<br>
&gt; +=C2=A0 =C2=A0 if (value_cbor) {<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 cbor_decref(&amp;value_cbor);<br>
&gt; +=C2=A0 =C2=A0 }<br>
&gt; +=C2=A0 =C2=A0 return false;<br>
&gt; +}<br>
&gt; +<br>
&gt; +bool qemu_cbor_add_uint8_key_bytestring_to_map(cbor_item_t *map, uint=
8_t key,<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0uint8_t *buf, size_t len)<br>
&gt; +{<br>
&gt; +=C2=A0 =C2=A0 cbor_item_t *key_cbor =3D NULL;<br>
&gt; +=C2=A0 =C2=A0 cbor_item_t *value_cbor =3D NULL;<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 key_cbor =3D cbor_build_uint8(key);<br>
&gt; +=C2=A0 =C2=A0 if (!key_cbor) {<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 goto cleanup;<br>
&gt; +=C2=A0 =C2=A0 }<br>
&gt; +=C2=A0 =C2=A0 value_cbor =3D cbor_build_bytestring(buf, len);<br>
&gt; +=C2=A0 =C2=A0 if (!value_cbor) {<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 goto cleanup;<br>
&gt; +=C2=A0 =C2=A0 }<br>
&gt; +=C2=A0 =C2=A0 if (!qemu_cbor_map_add(map, key_cbor, value_cbor)) {<br=
>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 goto cleanup;<br>
&gt; +=C2=A0 =C2=A0 }<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 return true;<br>
&gt; +<br>
&gt; + cleanup:<br>
&gt; +=C2=A0 =C2=A0 if (key_cbor) {<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 cbor_decref(&amp;key_cbor);<br>
&gt; +=C2=A0 =C2=A0 }<br>
&gt; +=C2=A0 =C2=A0 if (value_cbor) {<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 cbor_decref(&amp;value_cbor);<br>
&gt; +=C2=A0 =C2=A0 }<br>
&gt; +=C2=A0 =C2=A0 return false;<br>
&gt; +}<br>
&gt; +<br>
&gt; +bool qemu_cbor_add_uint64_to_map(cbor_item_t *map, const char *key,<b=
r>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0uint64_t value)<br>
&gt; +{<br>
&gt; +=C2=A0 =C2=A0 cbor_item_t *key_cbor =3D NULL;<br>
&gt; +=C2=A0 =C2=A0 cbor_item_t *value_cbor =3D NULL;<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 key_cbor =3D cbor_build_string(key);<br>
&gt; +=C2=A0 =C2=A0 if (!key_cbor) {<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 goto cleanup;<br>
&gt; +=C2=A0 =C2=A0 }<br>
&gt; +=C2=A0 =C2=A0 value_cbor =3D cbor_build_uint64(value);<br>
&gt; +=C2=A0 =C2=A0 if (!value_cbor) {<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 goto cleanup;<br>
&gt; +=C2=A0 =C2=A0 }<br>
&gt; +=C2=A0 =C2=A0 if (!qemu_cbor_map_add(map, key_cbor, value_cbor)) {<br=
>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 goto cleanup;<br>
&gt; +=C2=A0 =C2=A0 }<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 return true;<br>
&gt; +<br>
&gt; + cleanup:<br>
&gt; +=C2=A0 =C2=A0 if (key_cbor) {<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 cbor_decref(&amp;key_cbor);<br>
&gt; +=C2=A0 =C2=A0 }<br>
&gt; +=C2=A0 =C2=A0 if (value_cbor) {<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 cbor_decref(&amp;value_cbor);<br>
&gt; +=C2=A0 =C2=A0 }<br>
&gt; +=C2=A0 =C2=A0 return false;<br>
&gt; +}<br>
&gt; diff --git a/hw/virtio/meson.build b/hw/virtio/meson.build<br>
&gt; index 621fc65454..1fe7cb4d72 100644<br>
&gt; --- a/hw/virtio/meson.build<br>
&gt; +++ b/hw/virtio/meson.build<br>
&gt; @@ -54,6 +54,9 @@ specific_virtio_ss.add(when: &#39;CONFIG_VIRTIO_PMEM=
&#39;, if_true: files(&#39;virtio-pmem.c<br>
&gt;=C2=A0 specific_virtio_ss.add(when: &#39;CONFIG_VHOST_VSOCK&#39;, if_tr=
ue: files(&#39;vhost-vsock.c&#39;))<br>
&gt;=C2=A0 specific_virtio_ss.add(when: &#39;CONFIG_VHOST_USER_VSOCK&#39;, =
if_true: files(&#39;vhost-user-vsock.c&#39;))<br>
&gt;=C2=A0 specific_virtio_ss.add(when: &#39;CONFIG_VIRTIO_RNG&#39;, if_tru=
e: files(&#39;virtio-rng.c&#39;))<br>
&gt; +if libcbor.found()<br>
&gt; +=C2=A0 specific_virtio_ss.add(when: &#39;CONFIG_VIRTIO_NSM&#39;, if_t=
rue: [files(&#39;virtio-nsm.c&#39;, &#39;cbor-helpers.c&#39;), libcbor])<br=
>
&gt; +endif<br>
&gt;=C2=A0 specific_virtio_ss.add(when: &#39;CONFIG_VIRTIO_MEM&#39;, if_tru=
e: files(&#39;virtio-mem.c&#39;))<br>
&gt;=C2=A0 specific_virtio_ss.add(when: &#39;CONFIG_VHOST_USER_SCMI&#39;, i=
f_true: files(&#39;vhost-user-scmi.c&#39;))<br>
&gt;=C2=A0 specific_virtio_ss.add(when: [&#39;CONFIG_VIRTIO_PCI&#39;, &#39;=
CONFIG_VHOST_USER_SCMI&#39;], if_true: files(&#39;vhost-user-scmi-pci.c&#39=
;))<br>
&gt; @@ -70,6 +73,9 @@ virtio_pci_ss.add(when: &#39;CONFIG_VIRTIO_CRYPTO&#3=
9;, if_true: files(&#39;virtio-crypto-pc<br>
&gt;=C2=A0 virtio_pci_ss.add(when: &#39;CONFIG_VIRTIO_INPUT_HOST&#39;, if_t=
rue: files(&#39;virtio-input-host-pci.c&#39;))<br>
&gt;=C2=A0 virtio_pci_ss.add(when: &#39;CONFIG_VIRTIO_INPUT&#39;, if_true: =
files(&#39;virtio-input-pci.c&#39;))<br>
&gt;=C2=A0 virtio_pci_ss.add(when: &#39;CONFIG_VIRTIO_RNG&#39;, if_true: fi=
les(&#39;virtio-rng-pci.c&#39;))<br>
&gt; +if libcbor.found()<br>
&gt; +=C2=A0 virtio_pci_ss.add(when: &#39;CONFIG_VIRTIO_NSM&#39;, if_true: =
[files(&#39;virtio-nsm-pci.c&#39;, &#39;cbor-helpers.c&#39;), libcbor])<br>
&gt; +endif<br>
&gt;=C2=A0 virtio_pci_ss.add(when: &#39;CONFIG_VIRTIO_BALLOON&#39;, if_true=
: files(&#39;virtio-balloon-pci.c&#39;))<br>
&gt;=C2=A0 virtio_pci_ss.add(when: &#39;CONFIG_VIRTIO_9P&#39;, if_true: fil=
es(&#39;virtio-9p-pci.c&#39;))<br>
&gt;=C2=A0 virtio_pci_ss.add(when: &#39;CONFIG_VIRTIO_SCSI&#39;, if_true: f=
iles(&#39;virtio-scsi-pci.c&#39;))<br>
&gt; diff --git a/hw/virtio/virtio-nsm-pci.c b/hw/virtio/virtio-nsm-pci.c<b=
r>
&gt; new file mode 100644<br>
&gt; index 0000000000..dca797315a<br>
&gt; --- /dev/null<br>
&gt; +++ b/hw/virtio/virtio-nsm-pci.c<br>
&gt; @@ -0,0 +1,73 @@<br>
&gt; +/*<br>
&gt; + * AWS Nitro Secure Module (NSM) device<br>
&gt; + *<br>
&gt; + * Copyright (c) 2024 Dorjoy Chowdhury &lt;<a href=3D"mailto:dorjoych=
y111@gmail.com" rel=3D"noreferrer noreferrer" target=3D"_blank">dorjoychy11=
1@gmail.com</a>&gt;<br>
&gt; + *<br>
&gt; + * This work is licensed under the terms of the GNU GPL, version 2 or=
<br>
&gt; + * (at your option) any later version.=C2=A0 See the COPYING file in =
the<br>
&gt; + * top-level directory.<br>
&gt; + */<br>
&gt; +<br>
&gt; +#include &quot;qemu/osdep.h&quot;<br>
&gt; +<br>
&gt; +#include &quot;hw/virtio/virtio-pci.h&quot;<br>
&gt; +#include &quot;hw/virtio/virtio-nsm.h&quot;<br>
&gt; +#include &quot;hw/qdev-properties.h&quot;<br>
&gt; +#include &quot;qapi/error.h&quot;<br>
&gt; +#include &quot;qemu/module.h&quot;<br>
&gt; +#include &quot;qom/object.h&quot;<br>
&gt; +<br>
&gt; +typedef struct VirtIONsmPCI VirtIONsmPCI;<br>
&gt; +<br>
&gt; +#define TYPE_VIRTIO_NSM_PCI &quot;virtio-nsm-pci-base&quot;<br>
&gt; +DECLARE_INSTANCE_CHECKER(VirtIONsmPCI, VIRTIO_NSM_PCI,<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0TYPE_VIRTIO_NSM_PCI)<br>
&gt; +<br>
&gt; +struct VirtIONsmPCI {<br>
&gt; +=C2=A0 =C2=A0 VirtIOPCIProxy parent_obj;<br>
&gt; +=C2=A0 =C2=A0 VirtIONSM vdev;<br>
&gt; +};<br>
&gt; +<br>
&gt; +static void virtio_nsm_pci_realize(VirtIOPCIProxy *vpci_dev, Error **=
errp)<br>
&gt; +{<br>
&gt; +=C2=A0 =C2=A0 VirtIONsmPCI *vnsm =3D VIRTIO_NSM_PCI(vpci_dev);<br>
&gt; +=C2=A0 =C2=A0 DeviceState *vdev =3D DEVICE(&amp;vnsm-&gt;vdev);<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 virtio_pci_force_virtio_1(vpci_dev);<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 if (!qdev_realize(vdev, BUS(&amp;vpci_dev-&gt;bus), err=
p)) {<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 return;<br>
&gt; +=C2=A0 =C2=A0 }<br>
&gt; +}<br>
&gt; +<br>
&gt; +static void virtio_nsm_pci_class_init(ObjectClass *klass, void *data)=
<br>
&gt; +{<br>
&gt; +=C2=A0 =C2=A0 DeviceClass *dc =3D DEVICE_CLASS(klass);<br>
&gt; +=C2=A0 =C2=A0 VirtioPCIClass *k =3D VIRTIO_PCI_CLASS(klass);<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 k-&gt;realize =3D virtio_nsm_pci_realize;<br>
&gt; +=C2=A0 =C2=A0 set_bit(DEVICE_CATEGORY_MISC, dc-&gt;categories);<br>
&gt; +}<br>
&gt; +<br>
&gt; +static void virtio_nsm_initfn(Object *obj)<br>
&gt; +{<br>
&gt; +=C2=A0 =C2=A0 VirtIONsmPCI *dev =3D VIRTIO_NSM_PCI(obj);<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 virtio_instance_init_common(obj, &amp;dev-&gt;vdev, siz=
eof(dev-&gt;vdev),<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 TYPE_VIRTIO_NSM);<br>
&gt; +}<br>
&gt; +<br>
&gt; +static const VirtioPCIDeviceTypeInfo virtio_nsm_pci_info =3D {<br>
&gt; +=C2=A0 =C2=A0 .base_name=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0=3D TYPE_VIRTIO_NSM_PCI,<br>
&gt; +=C2=A0 =C2=A0 .generic_name=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =3D &qu=
ot;virtio-nsm-pci&quot;,<br>
&gt; +=C2=A0 =C2=A0 .instance_size =3D sizeof(VirtIONsmPCI),<br>
&gt; +=C2=A0 =C2=A0 .instance_init =3D virtio_nsm_initfn,<br>
&gt; +=C2=A0 =C2=A0 .class_init=C2=A0 =C2=A0 =3D virtio_nsm_pci_class_init,=
<br>
&gt; +};<br>
&gt; +<br>
&gt; +static void virtio_nsm_pci_register(void)<br>
&gt; +{<br>
&gt; +=C2=A0 =C2=A0 virtio_pci_types_register(&amp;virtio_nsm_pci_info);<br=
>
&gt; +}<br>
&gt; +<br>
&gt; +type_init(virtio_nsm_pci_register)<br>
&gt; diff --git a/hw/virtio/virtio-nsm.c b/hw/virtio/virtio-nsm.c<br>
&gt; new file mode 100644<br>
&gt; index 0000000000..0f4edd92ff<br>
&gt; --- /dev/null<br>
&gt; +++ b/hw/virtio/virtio-nsm.c<br>
&gt; @@ -0,0 +1,1665 @@<br>
&gt; +/*<br>
&gt; + * AWS Nitro Secure Module (NSM) device<br>
&gt; + *<br>
&gt; + * Copyright (c) 2024 Dorjoy Chowdhury &lt;<a href=3D"mailto:dorjoych=
y111@gmail.com" rel=3D"noreferrer noreferrer" target=3D"_blank">dorjoychy11=
1@gmail.com</a>&gt;<br>
&gt; + *<br>
&gt; + * This work is licensed under the terms of the GNU GPL, version 2 or=
<br>
&gt; + * (at your option) any later version.=C2=A0 See the COPYING file in =
the<br>
&gt; + * top-level directory.<br>
&gt; + */<br>
&gt; +<br>
&gt; +#include &quot;qemu/osdep.h&quot;<br>
&gt; +#include &quot;qemu/iov.h&quot;<br>
&gt; +#include &quot;qemu/guest-random.h&quot;<br>
&gt; +#include &quot;qapi/error.h&quot;<br>
&gt; +<br>
&gt; +#include &quot;crypto/hash.h&quot;<br>
&gt; +#include &quot;hw/virtio/virtio.h&quot;<br>
&gt; +#include &quot;hw/virtio/virtio-nsm.h&quot;<br>
&gt; +#include &quot;hw/virtio/cbor-helpers.h&quot;<br>
&gt; +#include &quot;standard-headers/linux/virtio_ids.h&quot;<br>
&gt; +<br>
&gt; +#define NSM_RESPONSE_BUF_SIZE=C2=A0 =C2=A0 =C2=A00x3000<br>
&gt; +#define NSM_PCR_DATA_REQ_MAX_SIZE 512<br>
&gt; +<br>
&gt; +enum NSMResponseTypes {<br>
&gt; +=C2=A0 =C2=A0 NSM_SUCCESS =3D 0,<br>
&gt; +=C2=A0 =C2=A0 NSM_INVALID_ARGUMENT =3D 1,<br>
&gt; +=C2=A0 =C2=A0 NSM_INVALID_INDEX =3D 2,<br>
&gt; +=C2=A0 =C2=A0 NSM_READONLY_INDEX =3D 3,<br>
&gt; +=C2=A0 =C2=A0 NSM_INVALID_OPERATION =3D 4,<br>
&gt; +=C2=A0 =C2=A0 NSM_BUFFER_TOO_SMALL =3D 5,<br>
&gt; +=C2=A0 =C2=A0 NSM_INPUT_TOO_LARGE =3D 6,<br>
&gt; +=C2=A0 =C2=A0 NSM_INTERNAL_ERROR =3D 7,<br>
&gt; +};<br>
&gt; +<br>
&gt; +static const char *error_string(enum NSMResponseTypes type)<br>
&gt; +{<br>
&gt; +=C2=A0 =C2=A0 const char *str;<br>
&gt; +=C2=A0 =C2=A0 switch (type) {<br>
&gt; +=C2=A0 =C2=A0 case NSM_INVALID_ARGUMENT:<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 str =3D &quot;InvalidArgument&quot;;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 break;<br>
&gt; +=C2=A0 =C2=A0 case NSM_INVALID_INDEX:<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 str =3D &quot;InvalidIndex&quot;;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 break;<br>
&gt; +=C2=A0 =C2=A0 case NSM_READONLY_INDEX:<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 str =3D &quot;ReadOnlyIndex&quot;;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 break;<br>
&gt; +=C2=A0 =C2=A0 case NSM_INVALID_OPERATION:<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 str =3D &quot;InvalidOperation&quot;;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 break;<br>
&gt; +=C2=A0 =C2=A0 case NSM_BUFFER_TOO_SMALL:<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 str =3D &quot;BufferTooSmall&quot;;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 break;<br>
&gt; +=C2=A0 =C2=A0 case NSM_INPUT_TOO_LARGE:<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 str =3D &quot;InputTooLarge&quot;;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 break;<br>
&gt; +=C2=A0 =C2=A0 default:<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 str =3D &quot;InternalError&quot;;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 break;<br>
&gt; +=C2=A0 =C2=A0 }<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 return str;<br>
&gt; +}<br>
&gt; +<br>
&gt; +/*<br>
&gt; + * Error response structure:<br>
&gt; + *<br>
&gt; + * {<br>
&gt; + *=C2=A0 =C2=A0Map(1) {<br>
&gt; + *=C2=A0 =C2=A0 =C2=A0key =3D String(&quot;Error&quot;),<br>
&gt; + *=C2=A0 =C2=A0 =C2=A0value =3D String(error_name)<br>
&gt; + *=C2=A0 =C2=A0}<br>
&gt; + * }<br>
&gt; + *<br>
&gt; + * where error_name can be one of the following:<br>
&gt; + *=C2=A0 =C2=A0InvalidArgument<br>
&gt; + *=C2=A0 =C2=A0InvalidIndex<br>
&gt; + *=C2=A0 =C2=A0InvalidResponse<br>
&gt; + *=C2=A0 =C2=A0ReadOnlyIndex<br>
&gt; + *=C2=A0 =C2=A0InvalidOperation<br>
&gt; + *=C2=A0 =C2=A0BufferTooSmall<br>
&gt; + *=C2=A0 =C2=A0InputTooLarge<br>
&gt; + *=C2=A0 =C2=A0InternalError<br>
&gt; + */<br>
&gt; +<br>
&gt; +static bool error_response(struct iovec *response, enum NSMResponseTy=
pes error,<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0Error **errp)<br>
&gt; +{<br>
&gt; +=C2=A0 =C2=A0 cbor_item_t *root;<br>
&gt; +=C2=A0 =C2=A0 size_t len;<br>
&gt; +=C2=A0 =C2=A0 bool r =3D false;<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 root =3D cbor_new_definite_map(1);<br>
&gt; +=C2=A0 =C2=A0 if (!root) {<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 goto err;<br>
&gt; +=C2=A0 =C2=A0 }<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 if (!qemu_cbor_add_string_to_map(root, &quot;Error&quot=
;, error_string(error))) {<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 goto err;<br>
&gt; +=C2=A0 =C2=A0 }<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 len =3D cbor_serialize(root, response-&gt;iov_base, res=
ponse-&gt;iov_len);<br>
<br>
As far as I can tell, all these also need to be switched to use iov_from_bu=
f.<br></blockquote></div></div><div dir=3D"auto"><br></div><div dir=3D"auto=
">Sorry I didn&#39;t understand this. The iovecs passed in these functions =
are not the iovecs from virtqueue. We make an iovec for the response and th=
en pass it down. We do the &quot;iov_from_buf&quot; after calling &quot;get=
_nsm_request_response&quot; in &quot;handle_input&quot; function. Am I miss=
ing something?</div><div dir=3D"auto"><br></div><div dir=3D"auto">Regards,<=
/div><div dir=3D"auto">Dorjoy</div></div>

--00000000000074edea06222db8d3--

