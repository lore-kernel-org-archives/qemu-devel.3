Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 21C2BC54E58
	for <qemu-devel@archiver.kernel.org>; Tue, 12 Mar 2024 18:14:50 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rk6dl-0007wg-Le; Tue, 12 Mar 2024 14:14:17 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1rk6dd-0007wJ-O0
 for qemu-devel@nongnu.org; Tue, 12 Mar 2024 14:14:09 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1rk6db-0005NP-LF
 for qemu-devel@nongnu.org; Tue, 12 Mar 2024 14:14:09 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1710267246;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=2jFL53gD1grVi0huVfTLBc35cIFB9ACIvHpPLh7BuHU=;
 b=ZmbdmdAcv1gXghDJ0hfrNhX+uNDbi7g9GNaZFleGuD4e1yDghmKYiU5X/5sjwytbMj9nJu
 8gKm0OdpNkYsz7vNluf5wC/K1ih/kvW1IkfUwgxEl3NVKoItk8VTE1T+QvzM1eEROGJZ08
 N7UGQvHAR0tHVxn/O3/X3IELOdKs9Ks=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-417-J_br6K6YOIi4RKlBLSFS8w-1; Tue, 12 Mar 2024 14:14:03 -0400
X-MC-Unique: J_br6K6YOIi4RKlBLSFS8w-1
Received: by mail-wr1-f70.google.com with SMTP id
 ffacd0b85a97d-33e67c6b7bdso3032054f8f.2
 for <qemu-devel@nongnu.org>; Tue, 12 Mar 2024 11:14:03 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1710267242; x=1710872042;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=2jFL53gD1grVi0huVfTLBc35cIFB9ACIvHpPLh7BuHU=;
 b=dDz8R8uwKULmDvk6vjxl/Bs4NyKD1I39mj9I8CDqsjzuuWr2VZMKkMSPVTMfBv7EY5
 SWPgBmL122GzPQk21NTH0tP9HgDntvOOyCTeqs/ymRcXY3THPOH71TXKlivEBM11eoVA
 psLyQqMATx+SHJJo6QowZnckkdekv7Uj0mmZG1jKI9Cv9E8VDsVzmEeTa2n1LJ94kzIl
 RpNA3TBVyAy8uXfA/5KVDv1Av5VKSZl/rYjzbjYBMI0nvn1I2ls/dLp2CHi7PfnuL6GK
 MENk43JU/I1XGp9rMAH1prPueT578y8JUrHOZxAZQqIyA2Hew234r4ch9+y7110KQR1g
 BjLw==
X-Gm-Message-State: AOJu0YymsajmzFI30Y0IjyHITTn49T/1OOvag390ORsz3mRQxzFlg25O
 894UqUjhPsgtEH57483xC8a3Wu10/f83OU+T/ydUcP5RypNJ8ECUGFqY9jScNwOr4Bq6tLif/NI
 Tynz22uzIwvZPSkRTPufTVDH09aYomUllLmkjuD4o0cYwZaRoZrOD
X-Received: by 2002:a5d:480e:0:b0:33e:69db:bf8a with SMTP id
 l14-20020a5d480e000000b0033e69dbbf8amr143111wrq.59.1710267241948; 
 Tue, 12 Mar 2024 11:14:01 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGmTShtoZ/GNr3EtRLTsOS06w9sCMGaheLdxpjuZN5cViplb7BqsSnJcH2awBI/ZvG3Aq9+5Q==
X-Received: by 2002:a5d:480e:0:b0:33e:69db:bf8a with SMTP id
 l14-20020a5d480e000000b0033e69dbbf8amr143096wrq.59.1710267241432; 
 Tue, 12 Mar 2024 11:14:01 -0700 (PDT)
Received: from redhat.com ([2a02:14f:1f0:532c:5ae4:fce6:76e1:fa1a])
 by smtp.gmail.com with ESMTPSA id
 bn5-20020a056000060500b0033e8c2476fesm7705184wrb.5.2024.03.12.11.13.58
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 12 Mar 2024 11:14:00 -0700 (PDT)
Date: Tue, 12 Mar 2024 14:13:56 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Albert Esteve <aesteve@redhat.com>
Cc: qemu-devel@nongnu.org, stefanha@gmail.com, alex.bennee@linaro.org,
 philmd@linaro.org, kraxel@redhat.com, marcandre.lureau@gmail.com,
 Stefan Hajnoczi <stefanha@redhat.com>
Subject: Re: [PATCH v4 4/5] hw/virtio: cleanup shared resources
Message-ID: <20240312141103-mutt-send-email-mst@kernel.org>
References: <20240219143423.272012-1-aesteve@redhat.com>
 <20240219143423.272012-5-aesteve@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240219143423.272012-5-aesteve@redhat.com>
Received-SPF: pass client-ip=170.10.129.124; envelope-from=mst@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.687,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
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

On Mon, Feb 19, 2024 at 03:34:22PM +0100, Albert Esteve wrote:
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
>  hw/display/virtio-dmabuf.c        | 21 ++++++++++++++++++++
>  hw/virtio/vhost.c                 |  3 +++
>  include/hw/virtio/virtio-dmabuf.h | 10 ++++++++++
>  tests/unit/test-virtio-dmabuf.c   | 33 +++++++++++++++++++++++++++++++
>  4 files changed, 67 insertions(+)
> 
> diff --git a/hw/display/virtio-dmabuf.c b/hw/display/virtio-dmabuf.c
> index 961094a561..703b5bd979 100644
> --- a/hw/display/virtio-dmabuf.c
> +++ b/hw/display/virtio-dmabuf.c
> @@ -141,6 +141,27 @@ SharedObjectType virtio_object_type(const QemuUUID *uuid)
>      return vso->type;
>  }
>  
> +static bool virtio_dmabuf_resource_is_owned(gpointer key,
> +                                            gpointer value,
> +                                            gpointer dev)
> +{
> +    VirtioSharedObject *vso;
> +
> +    vso = (VirtioSharedObject *) value;
> +    return vso->type == TYPE_VHOST_DEV && vso->value.dev == dev;
> +}
> +
> +int virtio_dmabuf_vhost_cleanup(struct vhost_dev *dev)
> +{
> +    int num_removed;
> +
> +    WITH_QEMU_LOCK_GUARD(&lock) {


If I don't apply previous patch I can not apply this one either.


> +        num_removed = g_hash_table_foreach_remove(
> +            resource_uuids, (GHRFunc) virtio_dmabuf_resource_is_owned, dev);
> +    }
> +    return num_removed;
> +}
> +
>  void virtio_free_resources(void)
>  {
>      WITH_QEMU_LOCK_GUARD(&lock) {
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
> diff --git a/include/hw/virtio/virtio-dmabuf.h b/include/hw/virtio/virtio-dmabuf.h
> index 627d84dce9..950cd24967 100644
> --- a/include/hw/virtio/virtio-dmabuf.h
> +++ b/include/hw/virtio/virtio-dmabuf.h
> @@ -119,6 +119,16 @@ struct vhost_dev *virtio_lookup_vhost_device(const QemuUUID *uuid);
>   */
>  SharedObjectType virtio_object_type(const QemuUUID *uuid);
>  
> +/**
> + * virtio_dmabuf_vhost_cleanup() - Destroys all entries of the shared
> + * resources lookup table that are owned by the vhost backend
> + * @dev: the pointer to the vhost device that owns the entries. Data is owned
> + *       by the called of the function.
> + * 

trailing space here

> + * Return: the number of resource entries removed.
> + */
> +int virtio_dmabuf_vhost_cleanup(struct vhost_dev *dev);
> +
>  /**
>   * virtio_free_resources() - Destroys all keys and values of the shared
>   * resources lookup table, and frees them
> diff --git a/tests/unit/test-virtio-dmabuf.c b/tests/unit/test-virtio-dmabuf.c
> index 20213455ee..e5cf7ee19f 100644
> --- a/tests/unit/test-virtio-dmabuf.c
> +++ b/tests/unit/test-virtio-dmabuf.c
> @@ -107,6 +107,38 @@ static void test_add_invalid_resource(void)
>      }
>  }
>  
> +static void test_cleanup_res(void)
> +{
> +    QemuUUID uuids[20], uuid_alt;
> +    struct vhost_dev *dev = g_new0(struct vhost_dev, 1);
> +    struct vhost_dev *dev_alt = g_new0(struct vhost_dev, 1);
> +    int i, num_removed;
> +
> +    for (i = 0; i < ARRAY_SIZE(uuids); ++i) {
> +        qemu_uuid_generate(&uuids[i]);
> +        virtio_add_vhost_device(&uuids[i], dev);
> +        /* vhost device is found */
> +        g_assert(virtio_lookup_vhost_device(&uuids[i]) != NULL);
> +    }
> +    qemu_uuid_generate(&uuid_alt);
> +    virtio_add_vhost_device(&uuid_alt, dev_alt);
> +    /* vhost device is found */
> +    g_assert(virtio_lookup_vhost_device(&uuid_alt) != NULL);
> +    /* cleanup all dev resources */
> +    num_removed = virtio_dmabuf_vhost_cleanup(dev);
> +    g_assert_cmpint(num_removed, ==, ARRAY_SIZE(uuids));
> +    for (i = 0; i < ARRAY_SIZE(uuids); ++i) {
> +        /* None of the dev resources is found after free'd */
> +        g_assert_cmpint(virtio_lookup_dmabuf(&uuids[i]), ==, -1);
> +    }
> +    /* uuid_alt is still in the hash table */
> +    g_assert(virtio_lookup_vhost_device(&uuid_alt) != NULL);
> +
> +    virtio_free_resources();
> +    g_free(dev);
> +    g_free(dev_alt);
> +}
> +
>  static void test_free_resources(void)
>  {
>      QemuUUID uuids[20];
> @@ -136,6 +168,7 @@ int main(int argc, char **argv)
>                      test_remove_invalid_resource);
>      g_test_add_func("/virtio-dmabuf/add_invalid_res",
>                      test_add_invalid_resource);
> +    g_test_add_func("/virtio-dmabuf/cleanup_dev", test_cleanup_res);
>      g_test_add_func("/virtio-dmabuf/free_res", test_free_resources);
>  
>      return g_test_run();
> -- 
> 2.43.1


