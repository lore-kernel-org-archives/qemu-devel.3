Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6931DC4828D
	for <qemu-devel@archiver.kernel.org>; Mon,  5 Feb 2024 23:12:28 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rX87o-0003HP-6Y; Mon, 05 Feb 2024 18:11:40 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1rX87m-0003HG-O6
 for qemu-devel@nongnu.org; Mon, 05 Feb 2024 18:11:38 -0500
Received: from mail-wr1-x433.google.com ([2a00:1450:4864:20::433])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1rX87W-0008Ta-MK
 for qemu-devel@nongnu.org; Mon, 05 Feb 2024 18:11:37 -0500
Received: by mail-wr1-x433.google.com with SMTP id
 ffacd0b85a97d-33b4437e132so314582f8f.2
 for <qemu-devel@nongnu.org>; Mon, 05 Feb 2024 15:11:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1707174680; x=1707779480; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:user-agent
 :references:in-reply-to:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=2K0trFprKI7hWdF8JDMO7UUNF5H3lbegdlNjhmhUVoE=;
 b=fPhTn3cZe5yFqTzXr0GbR18ZmtclZmyEGmQd6S2jr30yQbJGkJrt99AQYwLAMaurjE
 q7e3hoy2efkBy6tk0EZwV1eznlBBzHLPeh7H4nkQZGQrM+PNhDfQS8IoO9sEBHMTXTDj
 2g7cvBgqV1HxXi6TL4JMKxM6cLowz3I6fEaxR8Rw736AErjwILWxtC77mrnHp+8E8fsd
 bqgb8hrWibzg/reHSxQsm7yTZS5VDHejKYDOtzar0dnIBlw9VBvKqjWac7aJRt0iGeNA
 dtr8BJLMKZe7dCCcWmOMB5rPsdy5nz/qntrQkU0FZd61LN7wDOHMhX+F4T8M4g4u6m0f
 rqsw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1707174680; x=1707779480;
 h=content-transfer-encoding:mime-version:message-id:date:user-agent
 :references:in-reply-to:subject:cc:to:from:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=2K0trFprKI7hWdF8JDMO7UUNF5H3lbegdlNjhmhUVoE=;
 b=ZE3rY90VbVfORjDhyp56nG64qRqPxenEDLvFF7Dy8AhizJqi5czQIuy7MDzXAGqciR
 jXFs31C9ngzAhcsuKeeZ/TRs4jexZ1DsyvD0jsoqh//ALszSNH4UoXj77xeFxSpnru1Y
 i2PU5CWWf0+qvIwIHNvUW3jdmit8Si2okdCgLMDeI/K1w1TXDCMNRKHjhYXITkC/6eyF
 oWcwfol1SvEMxkvYo4aKNLY8P95NroRd1fZt5tZjhPW8FBTI1dAr0uu1igjWxjg2crEU
 s/1Tuen7LBBztOPkUagflOS9OaOx4zbLQ7v83OvO8ZOljYljGRRZR2d/Mh7Th+rjWgxM
 bGew==
X-Gm-Message-State: AOJu0YwLHapO0r2lM3X/2AdX/o5wQa8jGLMPIWBEOj+Y9+soRrnedu6p
 1lXJQWlpgmKcG2ovawU/Yqvl/MxPYPJ63glbyn7VfN120IdZZcyeUEUgwvgIOMk=
X-Google-Smtp-Source: AGHT+IHTf1GueAZpPLCt7b/KGqrONNf/Y921virbJHTt+ODsRDwCU79TCWt9sBtLdbJEOgSmSWAIHA==
X-Received: by 2002:a5d:4209:0:b0:33b:34c5:4bb2 with SMTP id
 n9-20020a5d4209000000b0033b34c54bb2mr590292wrq.40.1707174680387; 
 Mon, 05 Feb 2024 15:11:20 -0800 (PST)
X-Forwarded-Encrypted: i=1;
 AJvYcCUr8C/hCYHF5BPM5/FSJ3Mh44r7sOOr4v0THbmTm2Qk+uCDInQAJ2fj5jJkQK/ENfYex728waKS9ZdD4Mo53SRByhk6eL3VJy3HjFE6u+clZewqXThuth91t/bEJZ8OKdO+qJnv+qWTpDEM1NsRrC26uhXZE4OS5lkjvHToHtyv3HzTX3bFU4hsMMOKi1L5mL0wIUSExYo=
Received: from draig.lan ([85.9.250.243]) by smtp.gmail.com with ESMTPSA id
 n5-20020a05600c4f8500b0040fdc645beesm30850wmq.20.2024.02.05.15.11.20
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 05 Feb 2024 15:11:20 -0800 (PST)
Received: from draig (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id 8C1435F888;
 Mon,  5 Feb 2024 23:11:19 +0000 (GMT)
From: =?utf-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>
To: Albert Esteve <aesteve@redhat.com>
Cc: qemu-devel@nongnu.org,  stefanha@gmail.com,  "Michael S. Tsirkin"
 <mst@redhat.com>,  marcandre.lureau@gmail.com,  kraxel@redhat.com,  Stefan
 Hajnoczi <stefanha@redhat.com>
Subject: Re: [PATCH v3 2/3] hw/virtio: cleanup shared resources
In-Reply-To: <20240109125614.220293-3-aesteve@redhat.com> (Albert Esteve's
 message of "Tue, 9 Jan 2024 13:56:13 +0100")
References: <20240109125614.220293-1-aesteve@redhat.com>
 <20240109125614.220293-3-aesteve@redhat.com>
User-Agent: mu4e 1.11.27; emacs 29.1
Date: Mon, 05 Feb 2024 23:11:19 +0000
Message-ID: <87le7ymrqg.fsf@draig.linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::433;
 envelope-from=alex.bennee@linaro.org; helo=mail-wr1-x433.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01,
 T_SPF_HELO_TEMPERROR=0.01 autolearn=ham autolearn_force=no
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

Albert Esteve <aesteve@redhat.com> writes:

> Ensure that we cleanup all virtio shared
> resources when the vhost devices is cleaned
> up (after a hot unplug, or a crash).
>
> To do so, we add a new function to the virtio_dmabuf
> API called `virtio_dmabuf_vhost_cleanup`, which
> loop through the table and removes all
> resources owned by the vhost device parameter.
>
> Also, add a test to verify that the new
> function in the API behaves as expected.
>
> Signed-off-by: Albert Esteve <aesteve@redhat.com>
> Acked-by: Stefan Hajnoczi <stefanha@redhat.com>
> ---
>  hw/display/virtio-dmabuf.c        | 22 +++++++++++++++++++++
>  hw/virtio/vhost.c                 |  3 +++
>  include/hw/virtio/virtio-dmabuf.h | 10 ++++++++++
>  tests/unit/test-virtio-dmabuf.c   | 33 +++++++++++++++++++++++++++++++
>  4 files changed, 68 insertions(+)
>
> diff --git a/hw/display/virtio-dmabuf.c b/hw/display/virtio-dmabuf.c
> index 3dba4577ca..6688809777 100644
> --- a/hw/display/virtio-dmabuf.c
> +++ b/hw/display/virtio-dmabuf.c
> @@ -136,6 +136,28 @@ SharedObjectType virtio_object_type(const QemuUUID *=
uuid)
>      return vso->type;
>  }
>=20=20
> +static bool virtio_dmabuf_resource_is_owned(gpointer key,
> +                                            gpointer value,
> +                                            gpointer dev)
> +{
> +    VirtioSharedObject *vso;
> +
> +    vso =3D (VirtioSharedObject *) value;
> +    return vso->type =3D=3D TYPE_VHOST_DEV && vso->value =3D=3D dev;

It's a bit surprising to see vso->value being an anonymous gpointer
rather than the proper type and a bit confusing between value and
vso->value.

> +}
> +
> +int virtio_dmabuf_vhost_cleanup(struct vhost_dev *dev)
> +{
> +    int num_removed;
> +
> +    g_mutex_lock(&lock);
> +    num_removed =3D g_hash_table_foreach_remove(
> +        resource_uuids, (GHRFunc) virtio_dmabuf_resource_is_owned, dev);
> +    g_mutex_unlock(&lock);

I'll note if we used a QemuMutex for the lock we could:

  - use WITH_QEMU_LOCK_GUARD(&lock) { }
  - enable QSP porfiling for the lock

> +
> +    return num_removed;
> +}
> +
>  void virtio_free_resources(void)
>  {
>      g_mutex_lock(&lock);
> diff --git a/hw/virtio/vhost.c b/hw/virtio/vhost.c
> index 2c9ac79468..c5622eac14 100644
> --- a/hw/virtio/vhost.c
> +++ b/hw/virtio/vhost.c
> @@ -16,6 +16,7 @@
>  #include "qemu/osdep.h"
>  #include "qapi/error.h"
>  #include "hw/virtio/vhost.h"
> +#include "hw/virtio/virtio-dmabuf.h"
>  #include "qemu/atomic.h"
>  #include "qemu/range.h"
>  #include "qemu/error-report.h"
> @@ -1599,6 +1600,8 @@ void vhost_dev_cleanup(struct vhost_dev *hdev)
>      migrate_del_blocker(&hdev->migration_blocker);
>      g_free(hdev->mem);
>      g_free(hdev->mem_sections);
> +    /* free virtio shared objects */
> +    virtio_dmabuf_vhost_cleanup(hdev);
>      if (hdev->vhost_ops) {
>          hdev->vhost_ops->vhost_backend_cleanup(hdev);
>      }
> diff --git a/include/hw/virtio/virtio-dmabuf.h b/include/hw/virtio/virtio=
-dmabuf.h
> index 627c3b6db7..73f70fb482 100644
> --- a/include/hw/virtio/virtio-dmabuf.h
> +++ b/include/hw/virtio/virtio-dmabuf.h
> @@ -91,6 +91,16 @@ struct vhost_dev *virtio_lookup_vhost_device(const Qem=
uUUID *uuid);
>   */
>  SharedObjectType virtio_object_type(const QemuUUID *uuid);
>=20=20
> +/**
> + * virtio_dmabuf_vhost_cleanup() - Destroys all entries of the shared
> + * resources lookup table that are owned by the vhost backend
> + * @dev: the pointer to the vhost device that owns the entries. Data is =
owned
> + *       by the called of the function.
> + *=20
> + * Return: the number of resource entries removed.
> + */
> +int virtio_dmabuf_vhost_cleanup(struct vhost_dev *dev);
> +
>  /**
>   * virtio_free_resources() - Destroys all keys and values of the shared
>   * resources lookup table, and frees them
> diff --git a/tests/unit/test-virtio-dmabuf.c b/tests/unit/test-virtio-dma=
buf.c
> index a45ec52f42..1c8123c2d2 100644
> --- a/tests/unit/test-virtio-dmabuf.c
> +++ b/tests/unit/test-virtio-dmabuf.c
> @@ -103,6 +103,38 @@ static void test_add_invalid_resource(void)
>      }
>  }
>=20=20
> +static void test_cleanup_res(void)
> +{
> +    QemuUUID uuids[20], uuid_alt;
> +    struct vhost_dev *dev =3D g_new0(struct vhost_dev, 1);
> +    struct vhost_dev *dev_alt =3D g_new0(struct vhost_dev, 1);
> +    int i, num_removed;
> +
> +    for (i =3D 0; i < ARRAY_SIZE(uuids); ++i) {
> +        qemu_uuid_generate(&uuids[i]);
> +        virtio_add_vhost_device(&uuids[i], dev);
> +        /* vhost device is found */
> +        g_assert(virtio_lookup_vhost_device(&uuids[i]) !=3D NULL);
> +    }
> +    qemu_uuid_generate(&uuid_alt);
> +    virtio_add_vhost_device(&uuid_alt, dev_alt);
> +    /* vhost device is found */
> +    g_assert(virtio_lookup_vhost_device(&uuid_alt) !=3D NULL);
> +    /* cleanup all dev resources */
> +    num_removed =3D virtio_dmabuf_vhost_cleanup(dev);
> +    g_assert_cmpint(num_removed, =3D=3D, ARRAY_SIZE(uuids));
> +    for (i =3D 0; i < ARRAY_SIZE(uuids); ++i) {
> +        /* None of the dev resources is found after free'd */
> +        g_assert_cmpint(virtio_lookup_dmabuf(&uuids[i]), =3D=3D, -1);
> +    }
> +    /* uuid_alt is still in the hash table */
> +    g_assert(virtio_lookup_vhost_device(&uuid_alt) !=3D NULL);
> +
> +    virtio_free_resources();
> +    g_free(dev);
> +    g_free(dev_alt);
> +}
> +
>  static void test_free_resources(void)
>  {
>      QemuUUID uuids[20];
> @@ -131,6 +163,7 @@ int main(int argc, char **argv)
>                      test_remove_invalid_resource);
>      g_test_add_func("/virtio-dmabuf/add_invalid_res",
>                      test_add_invalid_resource);
> +    g_test_add_func("/virtio-dmabuf/cleanup_dev", test_cleanup_res);
>      g_test_add_func("/virtio-dmabuf/free_res", test_free_resources);
>=20=20
>      return g_test_run();

--=20
Alex Benn=C3=A9e
Virtualisation Tech Lead @ Linaro

