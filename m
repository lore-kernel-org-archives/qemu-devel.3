Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 968D5C54E58
	for <qemu-devel@archiver.kernel.org>; Thu, 14 Mar 2024 03:18:13 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rkbap-0001D8-9p; Wed, 13 Mar 2024 23:17:19 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jasowang@redhat.com>)
 id 1rkbao-0001Cx-1i
 for qemu-devel@nongnu.org; Wed, 13 Mar 2024 23:17:18 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jasowang@redhat.com>)
 id 1rkbam-0004O4-By
 for qemu-devel@nongnu.org; Wed, 13 Mar 2024 23:17:17 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1710386235;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=vIRm92YhYpNm+QdRridioRsN+lBAYV/KCrGfaUe0z4A=;
 b=N/pYqqDUZrEuYPkYnDIfxJYgTukbIAMx3RAuPC4hpjAeyVndbbr6IuTr2WMrbn2LOh4EIQ
 I25RUELDvDPXQyR7Vjt4970XLatYefV6bdjGAeJcDGSrZ+wLIXev3WrpFJXNfwgmJfmplP
 BKLJoVVsX0GlUfi2SpYU/nQBblwTLtg=
Received: from mail-pg1-f198.google.com (mail-pg1-f198.google.com
 [209.85.215.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-35-HAJcfe-yMo-adZFlsKZ4pQ-1; Wed, 13 Mar 2024 23:17:13 -0400
X-MC-Unique: HAJcfe-yMo-adZFlsKZ4pQ-1
Received: by mail-pg1-f198.google.com with SMTP id
 41be03b00d2f7-5e4a072ce28so429677a12.0
 for <qemu-devel@nongnu.org>; Wed, 13 Mar 2024 20:17:13 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1710386232; x=1710991032;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=vIRm92YhYpNm+QdRridioRsN+lBAYV/KCrGfaUe0z4A=;
 b=V+8DRPxT78ov838SyQtEY2Jk1L0rrQQznErDqsHXOsBOr8zWMY9yNTAe03vNBGsci4
 x52227kwtVhBBEv4d+zs2GPfSoxopqL2EpppJEbMw/Fwy1PTUy2cpnNp8HNbssN9tiyN
 Hmg6N7O4/Y3cyXOjVGbXj8WGPhoQzlE593hPTK99/Vj0FAhWl2E4B5SKrx5pz9OC0Yci
 RSU35SQ/UPwnLVl2uW4bFxhVjGYHdc4CMd7Vi3KtnZkwIuR7/80bL/gH+FXIyPn7ll3c
 EKnNOPhNqiBDeKaIvE9CP42NO8lxsCw+Gr8PIYmkXAiCxc8Z5sGX5PmgVp27sHk5IOSE
 9rOw==
X-Gm-Message-State: AOJu0Yx/cXNLQkZJWHgWDGIQKFCIgoy2cnB7kZpr6AMV2x7On3ev7hfS
 oWaDV4Xh3H0rX1T1bR40ZX/b0UNKNtXookPIlxnKpY9TiF1UsKt72VCwya7g8kieh2tA4gSdYNh
 +3OXPXX94rMJ3XOzQYz2lYdes/nuVJvlnl9w2+92+c8YsSqs0v0uCoXNX+Xh02GEghcKYT2R5aJ
 IHIhq0MPFFRkvdt8Y5fewRWfq0GLA=
X-Received: by 2002:a05:6a20:e07:b0:1a1:4c48:5ca0 with SMTP id
 ej7-20020a056a200e0700b001a14c485ca0mr725225pzb.42.1710386232629; 
 Wed, 13 Mar 2024 20:17:12 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHLjIs/ZlMhWwympvqImj06yPMBgPKTtnjlzM3T6o1Wg9ZwQN9e8P4luNff4JCq5KghC/AOWDwdLyKgFBduc7w=
X-Received: by 2002:a05:6a20:e07:b0:1a1:4c48:5ca0 with SMTP id
 ej7-20020a056a200e0700b001a14c485ca0mr725212pzb.42.1710386232295; Wed, 13 Mar
 2024 20:17:12 -0700 (PDT)
MIME-Version: 1.0
References: <20240207092702.25242-1-sgarzare@redhat.com>
In-Reply-To: <20240207092702.25242-1-sgarzare@redhat.com>
From: Jason Wang <jasowang@redhat.com>
Date: Thu, 14 Mar 2024 11:17:01 +0800
Message-ID: <CACGkMEvRizRGOjOz_AVQw8wsGU3g8+-yHtnKM=yn=3RtY-Hayg@mail.gmail.com>
Subject: Re: [PATCH] vhost-vdpa: check vhost_vdpa_set_vring_ready() return
 value
To: Stefano Garzarella <sgarzare@redhat.com>
Cc: qemu-devel@nongnu.org, mst@redhat.com, lulu@redhat.com, kwolf@redhat.com, 
 eperezma@redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=170.10.129.124; envelope-from=jasowang@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -30
X-Spam_score: -3.1
X-Spam_bar: ---
X-Spam_report: (-3.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.971,
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

On Wed, Feb 7, 2024 at 5:27=E2=80=AFPM Stefano Garzarella <sgarzare@redhat.=
com> wrote:
>
> vhost_vdpa_set_vring_ready() could already fail, but if Linux's
> patch [1] will be merged, it may fail with more chance if
> userspace does not activate virtqueues before DRIVER_OK when
> VHOST_BACKEND_F_ENABLE_AFTER_DRIVER_OK is not negotiated.

I wonder what happens if we just leave it as is.

VHOST_BACKEND_F_ENABLE_AFTER_DRIVER_OK: We do know enabling could be
done after driver_ok.
Without VHOST_BACKEND_F_ENABLE_AFTER_DRIVER_OK: We don't know whether
enabling could be done after driver_ok or not.

Thanks

>
> So better check its return value anyway.
>
> [1] https://lore.kernel.org/virtualization/20240206145154.118044-1-sgarza=
re@redhat.com/T/#u
>
> Signed-off-by: Stefano Garzarella <sgarzare@redhat.com>
> ---
> Note: This patch conflicts with [2], but the resolution is simple,
> so for now I sent a patch for the current master, but I'll rebase
> this patch if we merge the other one first.
>
> [2] https://lore.kernel.org/qemu-devel/20240202132521.32714-1-kwolf@redha=
t.com/
> ---
>  hw/virtio/vdpa-dev.c |  8 +++++++-
>  net/vhost-vdpa.c     | 15 ++++++++++++---
>  2 files changed, 19 insertions(+), 4 deletions(-)
>
> diff --git a/hw/virtio/vdpa-dev.c b/hw/virtio/vdpa-dev.c
> index eb9ecea83b..d57cd76c18 100644
> --- a/hw/virtio/vdpa-dev.c
> +++ b/hw/virtio/vdpa-dev.c
> @@ -259,7 +259,11 @@ static int vhost_vdpa_device_start(VirtIODevice *vde=
v, Error **errp)
>          goto err_guest_notifiers;
>      }
>      for (i =3D 0; i < s->dev.nvqs; ++i) {
> -        vhost_vdpa_set_vring_ready(&s->vdpa, i);
> +        ret =3D vhost_vdpa_set_vring_ready(&s->vdpa, i);
> +        if (ret < 0) {
> +            error_setg_errno(errp, -ret, "Error starting vring %d", i);
> +            goto err_dev_stop;
> +        }
>      }
>      s->started =3D true;
>
> @@ -274,6 +278,8 @@ static int vhost_vdpa_device_start(VirtIODevice *vdev=
, Error **errp)
>
>      return ret;
>
> +err_dev_stop:
> +    vhost_dev_stop(&s->dev, vdev, false);
>  err_guest_notifiers:
>      k->set_guest_notifiers(qbus->parent, s->dev.nvqs, false);
>  err_host_notifiers:
> diff --git a/net/vhost-vdpa.c b/net/vhost-vdpa.c
> index 3726ee5d67..e3d8036479 100644
> --- a/net/vhost-vdpa.c
> +++ b/net/vhost-vdpa.c
> @@ -381,7 +381,10 @@ static int vhost_vdpa_net_data_load(NetClientState *=
nc)
>      }
>
>      for (int i =3D 0; i < v->dev->nvqs; ++i) {
> -        vhost_vdpa_set_vring_ready(v, i + v->dev->vq_index);
> +        int ret =3D vhost_vdpa_set_vring_ready(v, i + v->dev->vq_index);
> +        if (ret < 0) {
> +            return ret;
> +        }
>      }
>      return 0;
>  }
> @@ -1213,7 +1216,10 @@ static int vhost_vdpa_net_cvq_load(NetClientState =
*nc)
>
>      assert(nc->info->type =3D=3D NET_CLIENT_DRIVER_VHOST_VDPA);
>
> -    vhost_vdpa_set_vring_ready(v, v->dev->vq_index);
> +    r =3D vhost_vdpa_set_vring_ready(v, v->dev->vq_index);
> +    if (unlikely(r < 0)) {
> +        return r;
> +    }
>
>      if (v->shadow_vqs_enabled) {
>          n =3D VIRTIO_NET(v->dev->vdev);
> @@ -1252,7 +1258,10 @@ static int vhost_vdpa_net_cvq_load(NetClientState =
*nc)
>      }
>
>      for (int i =3D 0; i < v->dev->vq_index; ++i) {
> -        vhost_vdpa_set_vring_ready(v, i);
> +        r =3D vhost_vdpa_set_vring_ready(v, i);
> +        if (unlikely(r < 0)) {
> +            return r;
> +        }
>      }
>
>      return 0;
> --
> 2.43.0
>


