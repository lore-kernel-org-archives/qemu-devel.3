Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 87FDAC02183
	for <qemu-devel@archiver.kernel.org>; Wed, 15 Jan 2025 10:11:32 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tY0Mi-0002Yl-Qf; Wed, 15 Jan 2025 05:11:14 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1tY0Md-0002YV-It
 for qemu-devel@nongnu.org; Wed, 15 Jan 2025 05:11:07 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1tY0Mb-0001i6-FC
 for qemu-devel@nongnu.org; Wed, 15 Jan 2025 05:11:07 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1736935861;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=KttIDvyP+RV3kkfHwY0usvyICQCJUzxJj5b8Ofm21U4=;
 b=IcDFgrceEFuIRxSXpHpfoYsicDaNre/+8J81WWfL9GxLRPvvx7Fvmnr8sld2G6JrwY92C3
 CdvCjfTDGdP3rYoEdBYq42xA7c4FExRqBOTqHwMANO+mrZtgX1poJOIP49fglJh4ZdGC0f
 xLZPQmRDO4+zEtH2gmRgNK09aOV+OzI=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-86-U8qSoOHQOYK3fO1wqmqy8w-1; Wed, 15 Jan 2025 05:10:59 -0500
X-MC-Unique: U8qSoOHQOYK3fO1wqmqy8w-1
X-Mimecast-MFC-AGG-ID: U8qSoOHQOYK3fO1wqmqy8w
Received: by mail-wm1-f70.google.com with SMTP id
 5b1f17b1804b1-436379713baso30668575e9.2
 for <qemu-devel@nongnu.org>; Wed, 15 Jan 2025 02:10:58 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1736935858; x=1737540658;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=KttIDvyP+RV3kkfHwY0usvyICQCJUzxJj5b8Ofm21U4=;
 b=Er/hTVbkiCgbBs2dReQQ9kzYlBsEjX/0APG/NyLDrjtZzQDEiJTyBOevCEzHX9N0Bm
 EFqxULeWbKzdj1uHSmovLb59XP3jJiKGJw1xF0ZP7ZEeXBmjJzMfR9My8cYEViLb3KW2
 LoSOFZkaCeUQyumgdz6ocZXL/j4TbcXpJyQAKrStY53VyAfwzTK/YXMtwhSMJwdiTG07
 sLb1+0l+cnrYYR97+nrqtXF3k1ayIW+hflLJPSd/iDyaBsyQVKuaeQii5d7g3fzONEWF
 JeiZUJskIs8Kq1GuLKgMsJHi7npkbyew8cUnH5kmxspNgi353Eaxnh8KMFKWpq+G6lN1
 vSOQ==
X-Gm-Message-State: AOJu0Yy8qM3JFDgqgzx2D0KNvZ/VNRWQSo08bAz/U3/gQa7UkDDgssUq
 l4Gbf0LoSDtO0iTjEMeJxnM11rMqsfCzRU0U4DVdhGGQoex7vqmAt4jNYeFptVzpnNRVlRYxRyy
 k03t0o+klLiqmvmV5KYWuwJyW0nGiR8opsX8ZmHyBJDSfJ0nbFWDO
X-Gm-Gg: ASbGncuOaRqS/pybCU6iJr3TIA6UZNl800FbDuV14UhxWTgWVbA10ZXGSYnSf3S1Ma4
 c1f4wdOAbNBkygtFAf7QbsBbxcSuF0Noxs1Hg1GHvkO26tWVOZHp5G7Vbe/nHH6A/6tzXIOhvqO
 yxSUPCRCQzGqSEVgGofsczBcfL87KGD9kBJmdgjCxZb3mrSebCAd0stbOKoGXkmx805fXhomEvr
 DxiUgqDinLTFZ+gwJGh8wnDlhyktQhHhBxBBBygKRyTdHoWdQ==
X-Received: by 2002:a05:600c:3514:b0:434:f623:9fe3 with SMTP id
 5b1f17b1804b1-436e26a80a0mr305157245e9.16.1736935857777; 
 Wed, 15 Jan 2025 02:10:57 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHGrPqg3wWKu1xKI/vJdSoRm2s2amcLm2meNyk20YiaQWO5TWX/IofvbVGv721jNuFnlSqJNg==
X-Received: by 2002:a05:600c:3514:b0:434:f623:9fe3 with SMTP id
 5b1f17b1804b1-436e26a80a0mr305156955e9.16.1736935857416; 
 Wed, 15 Jan 2025 02:10:57 -0800 (PST)
Received: from redhat.com ([2a02:14f:1f5:8f43:2a76:9f8c:65e8:ce7])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-437c7499965sm17995565e9.5.2025.01.15.02.10.55
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 15 Jan 2025 02:10:56 -0800 (PST)
Date: Wed, 15 Jan 2025 05:10:53 -0500
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Laurent Vivier <lvivier@redhat.com>
Cc: qemu-devel@nongnu.org, Hanna Czenczek <hreitz@redhat.com>,
 Jason Wang <jasowang@redhat.com>
Subject: Re: [PATCH] virtio-net: vhost-user: Implement internal migration
Message-ID: <20250115051039-mutt-send-email-mst@kernel.org>
References: <20241218143453.1573185-1-lvivier@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241218143453.1573185-1-lvivier@redhat.com>
Received-SPF: pass client-ip=170.10.133.124; envelope-from=mst@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -39
X-Spam_score: -4.0
X-Spam_bar: ----
X-Spam_report: (-4.0 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.063,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-1.794,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

On Wed, Dec 18, 2024 at 03:34:53PM +0100, Laurent Vivier wrote:
> Add support of VHOST_USER_PROTOCOL_F_DEVICE_STATE in virtio-net
> with vhost-user backend.
> 
> Cc: Hanna Czenczek <hreitz@redhat.com>
> Signed-off-by: Laurent Vivier <lvivier@redhat.com>


Breaks windows builds:

https://gitlab.com/mstredhat/qemu/-/jobs/8855973625

> ---
>  hw/net/virtio-net.c | 135 ++++++++++++++++++++++++++++++++++++--------
>  1 file changed, 112 insertions(+), 23 deletions(-)
> 
> diff --git a/hw/net/virtio-net.c b/hw/net/virtio-net.c
> index 6e8c51a2dbce..b4d9e96dc0d7 100644
> --- a/hw/net/virtio-net.c
> +++ b/hw/net/virtio-net.c
> @@ -3337,6 +3337,117 @@ static const VMStateDescription vmstate_virtio_net_rss = {
>      },
>  };
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
>  static const VMStateDescription vmstate_virtio_net_device = {
>      .name = "virtio-net-device",
>      .version_id = VIRTIO_NET_VM_VERSION,
> @@ -3389,6 +3500,7 @@ static const VMStateDescription vmstate_virtio_net_device = {
>      },
>      .subsections = (const VMStateDescription * const []) {
>          &vmstate_virtio_net_rss,
> +        &vhost_user_net_backend_state,
>          NULL
>      }
>  };
> @@ -3950,29 +4062,6 @@ static bool dev_unplug_pending(void *opaque)
>      return vdc->primary_unplug_pending(dev);
>  }
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
>  static const VMStateDescription vmstate_virtio_net = {
>      .name = "virtio-net",
>      .minimum_version_id = VIRTIO_NET_VM_VERSION,
> -- 
> 2.47.1


