Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E2083E77188
	for <qemu-devel@archiver.kernel.org>; Wed,  8 Jan 2025 10:12:32 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tVT2F-0004g5-HR; Wed, 08 Jan 2025 05:11:35 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <lvivier@redhat.com>)
 id 1tVT2D-0004fW-Io
 for qemu-devel@nongnu.org; Wed, 08 Jan 2025 05:11:33 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <lvivier@redhat.com>)
 id 1tVT2B-00014B-Ke
 for qemu-devel@nongnu.org; Wed, 08 Jan 2025 05:11:33 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1736331089;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=e77Ece6etWtzOg1gK7UCw7Gyfl/8UqQgZZWy33QyONM=;
 b=fCnLN8WRXnrlAYf3Zi9LQQ6h5uwoEOzUXvPRDqCjKOU40KtNCFPmTux7u9Rjd5Pf/Z0rQr
 zDU1yYGQpleezNptAwQ+Gtq92AKAyQ3N6Cl562ttPk4IHmLqqbzv0M4EbXFCxsiGEqt3bV
 I28X6SDq7uvD34T4CvwNEC4q+b5dU6o=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-553-alwIyooKOJG0QGHJjxmlMg-1; Wed, 08 Jan 2025 05:11:28 -0500
X-MC-Unique: alwIyooKOJG0QGHJjxmlMg-1
X-Mimecast-MFC-AGG-ID: alwIyooKOJG0QGHJjxmlMg
Received: by mail-wr1-f69.google.com with SMTP id
 ffacd0b85a97d-386321c8f4bso8546664f8f.0
 for <qemu-devel@nongnu.org>; Wed, 08 Jan 2025 02:11:27 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1736331086; x=1736935886;
 h=content-transfer-encoding:in-reply-to:autocrypt:content-language
 :references:cc:to:from:subject:user-agent:mime-version:date
 :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=e77Ece6etWtzOg1gK7UCw7Gyfl/8UqQgZZWy33QyONM=;
 b=pvE5evj6pFOtlc30KjK0VqfgXW07fEANn/IXnC1QF9aEuf6WLKbTqwPGol1H3ZpiHN
 QSPvIUT9SlEgc5lTED2/hZ6FPZgYO9m1NKzRB59avPUtgqNKN9WA/JCG6Gkbw3ceE/OR
 zILpsU2NlKnqI0bLJE7H9my0TrXSqQwOK1fqdswbD0SGoi8wnz75MnLc6yAMvRDrTh8J
 AMFsFIerKSszrPEvT4hNKnq1wEf+lJxPWDXGRIfz3jtOmK0CvSNH5FO44fNElCV/NGN2
 1aGRFzGmT/UT8ZDD7gkyNt0BneX9q1R/Xcr7kjxh8WRSyEWx9PT9ha0/LIhA5sf3afIt
 lpew==
X-Gm-Message-State: AOJu0Yz2DP6dTm2zp4ZJ7cFMaFHE8Y6S021gAeVxbYE3wBsVcKGqEiBG
 6kgclKAruYU7sq48U6ZOnkI3FI/frNXjcdLdzu/ybyJCn33YdD87DjQ12JXrjy5p5l0dkHc99Bw
 FWfPsQIpHQqknKlIiZhmXLATKjeHKJE66oSTIrVEsTmtzP+7UNpfObcz8uSTF59Uotudl0gZ6Kg
 YZSmuZ6/wbFFEHrbu7/E7ljQPoawYtDp16PHA=
X-Gm-Gg: ASbGncs7wQZ/gbBnUxXar/ME73qTQEZ8wSZz1R2Ovf/ASg5M/752W5fX9JYbO2MeycR
 wC99n48r3UgsPYBO8sWWLqitFhNsXaXHxh5qMWEtka16EgA5n7JrcY0XM56X4Vmlm3h5DRppJgR
 +Cy6F9uke2swwU0k+bjo5RWsASasdNi4uukQmbw95xdV2eKlz7F0bAj6P7/LeGBEhuKCegNm5VU
 sH9a0DxL5ieQlDg6s1MU9ahdyZ4kzfMsFVuDvTvB9dDbAmLTb7mF0fLipWKk2USD0mQ7Ie4xT1w
 rSo2sWWTydiM9MoCXSE=
X-Received: by 2002:a5d:6da4:0:b0:386:3356:f3ac with SMTP id
 ffacd0b85a97d-38a8730cf2cmr1769157f8f.26.1736331086567; 
 Wed, 08 Jan 2025 02:11:26 -0800 (PST)
X-Google-Smtp-Source: AGHT+IEfORZfHHGLsNTV5cci60Y3bm+h0/NGuHfxVNXsTRSZ0lUs9GRN+tgntDhI/m6EcYLha5yXQA==
X-Received: by 2002:a5d:6da4:0:b0:386:3356:f3ac with SMTP id
 ffacd0b85a97d-38a8730cf2cmr1769120f8f.26.1736331086087; 
 Wed, 08 Jan 2025 02:11:26 -0800 (PST)
Received: from ?IPV6:2a01:e0a:e10:ef90:343a:68f:2e91:95c?
 ([2a01:e0a:e10:ef90:343a:68f:2e91:95c])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-436dcceb8c6sm25125345e9.0.2025.01.08.02.11.25
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 08 Jan 2025 02:11:25 -0800 (PST)
Message-ID: <57b5ce09-1c44-4142-a22b-4ef7c33cd004@redhat.com>
Date: Wed, 8 Jan 2025 11:11:24 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] virtio-net: vhost-user: Implement internal migration
From: Laurent Vivier <lvivier@redhat.com>
To: qemu-devel@nongnu.org
Cc: Hanna Czenczek <hreitz@redhat.com>, Jason Wang <jasowang@redhat.com>,
 "Michael S. Tsirkin" <mst@redhat.com>
References: <20241218143453.1573185-1-lvivier@redhat.com>
Content-Language: en-US
Autocrypt: addr=lvivier@redhat.com; keydata=
 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
In-Reply-To: <20241218143453.1573185-1-lvivier@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=lvivier@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.437,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001, SPF_HELO_NONE=0.001,
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

On 18/12/2024 15:34, Laurent Vivier wrote:
> Add support of VHOST_USER_PROTOCOL_F_DEVICE_STATE in virtio-net
> with vhost-user backend.
> 
> Cc: Hanna Czenczek <hreitz@redhat.com>
> Signed-off-by: Laurent Vivier <lvivier@redhat.com>
> ---
>   hw/net/virtio-net.c | 135 ++++++++++++++++++++++++++++++++++++--------
>   1 file changed, 112 insertions(+), 23 deletions(-)
> 
> diff --git a/hw/net/virtio-net.c b/hw/net/virtio-net.c
> index 6e8c51a2dbce..b4d9e96dc0d7 100644
> --- a/hw/net/virtio-net.c
> +++ b/hw/net/virtio-net.c
> @@ -3337,6 +3337,117 @@ static const VMStateDescription vmstate_virtio_net_rss = {
>       },
>   };
>   
> +static struct vhost_dev *virtio_net_get_vhost(VirtIODevice *vdev)
> +{
> +    VirtIONet *n = VIRTIO_NET(vdev);
> +    NetClientState *nc;
> +    struct vhost_net *net;
> +
> +    if (!n->nic) {
> +        return NULL;
> +    }
> +
> +    nc = qemu_get_queue(n->nic);
> +    if (!nc) {
> +        return NULL;
> +    }
> +
> +    net = get_vhost_net(nc->peer);
> +    if (!net) {
> +        return NULL;
> +    }
> +
> +    return &net->dev;
> +}
> +
> +static int vhost_user_net_save_state(QEMUFile *f, void *pv, size_t size,
> +                                     const VMStateField *field,
> +                                     JSONWriter *vmdesc)
> +{
> +    VirtIONet *n = pv;
> +    VirtIODevice *vdev = VIRTIO_DEVICE(n);
> +    struct vhost_dev *vhdev;
> +    Error *local_error = NULL;
> +    int ret;
> +
> +    vhdev = virtio_net_get_vhost(vdev);
> +    if (vhdev == NULL) {
> +        error_reportf_err(local_error,
> +                          "Error getting vhost back-end of %s device %s: ",
> +                          vdev->name, vdev->parent_obj.canonical_path);
> +        return -1;
> +    }
> +
> +    ret = vhost_save_backend_state(vhdev, f, &local_error);
> +    if (ret < 0) {
> +        error_reportf_err(local_error,
> +                          "Error saving back-end state of %s device %s: ",
> +                          vdev->name, vdev->parent_obj.canonical_path);
> +        return ret;
> +    }
> +
> +    return 0;
> +}
> +
> +static int vhost_user_net_load_state(QEMUFile *f, void *pv, size_t size,
> +                                     const VMStateField *field)
> +{
> +    VirtIONet *n = pv;
> +    VirtIODevice *vdev = VIRTIO_DEVICE(n);
> +    struct vhost_dev *vhdev;
> +    Error *local_error = NULL;
> +    int ret;
> +
> +    vhdev = virtio_net_get_vhost(vdev);
> +    if (vhdev == NULL) {
> +        error_reportf_err(local_error,
> +                          "Error getting vhost back-end of %s device %s: ",
> +                          vdev->name, vdev->parent_obj.canonical_path);
> +        return -1;
> +    }
> +
> +    ret = vhost_load_backend_state(vhdev, f, &local_error);
> +    if (ret < 0) {
> +        error_reportf_err(local_error,
> +                          "Error loading  back-end state of %s device %s: ",
> +                          vdev->name, vdev->parent_obj.canonical_path);
> +        return ret;
> +    }
> +
> +    return 0;
> +}
> +
> +static bool vhost_user_net_is_internal_migration(void *opaque)
> +{
> +    VirtIONet *n = opaque;
> +    VirtIODevice *vdev = VIRTIO_DEVICE(n);
> +    struct vhost_dev *vhdev;
> +
> +    vhdev = virtio_net_get_vhost(vdev);
> +    if (vhdev == NULL) {
> +        return false;
> +    }
> +
> +    return vhost_supports_device_state(vhdev);
> +}
> +
> +static const VMStateDescription vhost_user_net_backend_state = {
> +    .name = "virtio-net-device/backend",
> +    .version_id = 0,
> +    .needed = vhost_user_net_is_internal_migration,
> +    .fields = (const VMStateField[]) {
> +        {
> +            .name = "backend",
> +            .info = &(const VMStateInfo) {
> +                .name = "virtio-net vhost-user backend state",
> +                .get = vhost_user_net_load_state,
> +                .put = vhost_user_net_save_state,
> +            },
> +         },
> +         VMSTATE_END_OF_LIST()
> +    }
> +};
> +
>   static const VMStateDescription vmstate_virtio_net_device = {
>       .name = "virtio-net-device",
>       .version_id = VIRTIO_NET_VM_VERSION,
> @@ -3389,6 +3500,7 @@ static const VMStateDescription vmstate_virtio_net_device = {
>       },
>       .subsections = (const VMStateDescription * const []) {
>           &vmstate_virtio_net_rss,
> +        &vhost_user_net_backend_state,
>           NULL
>       }
>   };
> @@ -3950,29 +4062,6 @@ static bool dev_unplug_pending(void *opaque)
>       return vdc->primary_unplug_pending(dev);
>   }
>   
> -static struct vhost_dev *virtio_net_get_vhost(VirtIODevice *vdev)
> -{
> -    VirtIONet *n = VIRTIO_NET(vdev);
> -    NetClientState *nc;
> -    struct vhost_net *net;
> -
> -    if (!n->nic) {
> -        return NULL;
> -    }
> -
> -    nc = qemu_get_queue(n->nic);
> -    if (!nc) {
> -        return NULL;
> -    }
> -
> -    net = get_vhost_net(nc->peer);
> -    if (!net) {
> -        return NULL;
> -    }
> -
> -    return &net->dev;
> -}
> -
>   static const VMStateDescription vmstate_virtio_net = {
>       .name = "virtio-net",
>       .minimum_version_id = VIRTIO_NET_VM_VERSION,

Any comment on this patch?
This is roughly what we already have for vhost-user-fs in
bca3e2a13814 ("vhost-user-fs: Implement internal migration")

Thanks,
Laurent


