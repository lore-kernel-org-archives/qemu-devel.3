Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AFCA9C3271E
	for <qemu-devel@archiver.kernel.org>; Tue,  9 Jul 2024 02:34:15 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sR0fq-0007DU-JX; Mon, 08 Jul 2024 22:33:46 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jasowang@redhat.com>)
 id 1sR0fp-0007Cx-GP
 for qemu-devel@nongnu.org; Mon, 08 Jul 2024 22:33:45 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jasowang@redhat.com>)
 id 1sR0fh-0001KF-1D
 for qemu-devel@nongnu.org; Mon, 08 Jul 2024 22:33:38 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1720492415;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=rDTFiGu7X53bMxl1gplh9ckclSOljYBTnS3jGb0oL+s=;
 b=jM6kUxitBysEUQ0K47gsSZWtZsoPfUDsKiBd0+yCS3kmIzvzGQGQXR8tf+l704J4k3JVXk
 CtYBr5EPsk/+Vz+i0KZqpYss5Z4LKa+JYpA6B6WayCQ/dL4qPeBwyJO3NkYLqE85FwPklH
 8ly1oS5F6nj/vU748eCJfnAqr/TSAkc=
Received: from mail-pg1-f197.google.com (mail-pg1-f197.google.com
 [209.85.215.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-674-6xWYVIrfOWuXManu1tUOdA-1; Mon, 08 Jul 2024 22:33:34 -0400
X-MC-Unique: 6xWYVIrfOWuXManu1tUOdA-1
Received: by mail-pg1-f197.google.com with SMTP id
 41be03b00d2f7-7633a1f50b5so3741888a12.2
 for <qemu-devel@nongnu.org>; Mon, 08 Jul 2024 19:33:33 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1720492413; x=1721097213;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=rDTFiGu7X53bMxl1gplh9ckclSOljYBTnS3jGb0oL+s=;
 b=I4iXghf5PzXElvA3sHwOa7bO39NpgKfXWfIsiMKVNwIRR+m/4Zq2WHblUqzbbpCdoA
 aCrVCz0Tr+MaeMiWOQ74yFBAq5eDwfUmF8vyb+3mU/kC5+h6CbjklYZiNFWD2MVwLvOF
 pEg1bV7Nl8gVQgzHOPAvD0+gc1aKPOfqv/JG/1dzV/ePXRpkwXUFoVqO4xlWX9Ck46Lm
 /2XPz6vLF1p7m8X2cyOL2vtntSfihSNJltiZ7SxoU0gwi1HX50FwhHCDhFHcM49QJJn7
 MOqoz072+KKOcsLb9/KkwYMWnL1MLp8DLl3GM7E+ozhm/N7ROntOqhcC+aHLgRzQN8wc
 QhDA==
X-Forwarded-Encrypted: i=1;
 AJvYcCVKag7N7FZg4j9nU2AEjgynZXvwHrhbntecf1hcmD6PnPEXScXznacp7gjSQh1pbNwuAIkeRk+SdbhXyYXor+aoZIm1dGk=
X-Gm-Message-State: AOJu0Yyl//694KI1MVQmYoMxCN3FD7gmUywGYRQcOYwxBRW+susPHza+
 dR9105kwDensHB/9V+m2ACxiBdYu+Tbjy3w5ZwCLNhM3jvbYjOR0o1ax3U6uhulAWzCtalGU4o4
 9YFzjuJmeC/XA39FCoSZeu9XSwwKHpUxyI0huFW7fHhVsNIAkzfxtsnEGmHy9wvSFopv2yTsb5g
 1+SniIbnAnrRFs60/oWg0b7KtvmZI=
X-Received: by 2002:a05:6a20:7346:b0:1c1:879:9f5e with SMTP id
 adf61e73a8af0-1c2984d8d2emr1536720637.53.1720492413014; 
 Mon, 08 Jul 2024 19:33:33 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHcMvpavo+e7yHyRczI6CWodgP76kydGISS/2vK6DH1FqY9S/pWTe2/t/gZp1iwwirrdJr+JeLllDWVgATDOlI=
X-Received: by 2002:a05:6a20:7346:b0:1c1:879:9f5e with SMTP id
 adf61e73a8af0-1c2984d8d2emr1536701637.53.1720492412549; Mon, 08 Jul 2024
 19:33:32 -0700 (PDT)
MIME-Version: 1.0
References: <20240709022707.579474-1-lulu@redhat.com>
In-Reply-To: <20240709022707.579474-1-lulu@redhat.com>
From: Jason Wang <jasowang@redhat.com>
Date: Tue, 9 Jul 2024 10:33:21 +0800
Message-ID: <CACGkMEt9ixHst2P++YZ5qkA6tjSTCm+9WvJcv4=jW4ST=PiwMw@mail.gmail.com>
Subject: Re: [RFC] virtio-net: check the mac address for vdpa device
To: Cindy Lu <lulu@redhat.com>
Cc: dtatulea@nvidia.com, mst@redhat.com, parav@nvidia.com, 
 qemu-devel@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=170.10.133.124; envelope-from=jasowang@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.142,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

On Tue, Jul 9, 2024 at 10:27=E2=80=AFAM Cindy Lu <lulu@redhat.com> wrote:
>
> When using VDPA device, we should verify whether the MAC address in the
> hardware matches the MAC address from the QEMU command line. If not,
> we will need to update the related information.
>
> Signed-off-by: Cindy Lu <lulu@redhat.com>

This seems to be a workaround, for example it means the mac address
set from the qemu command line has the higher priority compared to the
one that is provisioned by the host?

At least we need to have a warning here?

Thanks

> ---
>  hw/net/virtio-net.c | 15 +++++++++++----
>  1 file changed, 11 insertions(+), 4 deletions(-)
>
> diff --git a/hw/net/virtio-net.c b/hw/net/virtio-net.c
> index 9c7e85caea..db04331b82 100644
> --- a/hw/net/virtio-net.c
> +++ b/hw/net/virtio-net.c
> @@ -3739,10 +3739,17 @@ static void virtio_net_device_realize(DeviceState=
 *dev, Error **errp)
>      nc->rxfilter_notify_enabled =3D 1;
>
>     if (nc->peer && nc->peer->info->type =3D=3D NET_CLIENT_DRIVER_VHOST_V=
DPA) {
> -        struct virtio_net_config netcfg =3D {};
> -        memcpy(&netcfg.mac, &n->nic_conf.macaddr, ETH_ALEN);
> -        vhost_net_set_config(get_vhost_net(nc->peer),
> -            (uint8_t *)&netcfg, 0, ETH_ALEN, VHOST_SET_CONFIG_TYPE_FRONT=
END);
> +     struct virtio_net_config netcfg =3D {};
> +     static const MACAddr zero =3D {.a =3D {0, 0, 0, 0, 0, 0}};
> +     vhost_net_get_config(get_vhost_net(nc->peer), (uint8_t *)&netcfg,
> +                          ETH_ALEN);
> +     if ((memcmp(&netcfg.mac, &n->nic_conf.macaddr, sizeof(MACAddr)) !=
=3D 0) &&
> +         memcmp(&netcfg.mac, &zero, sizeof(zero) !=3D 0)) {
> +       memcpy(&n->nic_conf.macaddr, &netcfg.mac, sizeof(MACAddr));
> +       memcpy(&n->mac[0], &netcfg.mac, sizeof(MACAddr));
> +     }
> +     vhost_net_set_config(get_vhost_net(nc->peer), (uint8_t *)&netcfg, 0=
,
> +                          ETH_ALEN, VHOST_SET_CONFIG_TYPE_FRONTEND);
>      }
>      QTAILQ_INIT(&n->rsc_chains);
>      n->qdev =3D dev;
> --
> 2.45.0
>


