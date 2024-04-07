Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DB272CD1292
	for <qemu-devel@archiver.kernel.org>; Sun,  7 Apr 2024 21:47:28 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rtaLX-0002yn-FM; Sun, 07 Apr 2024 17:46:39 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <yuri.benditovich@daynix.com>)
 id 1rtaLU-0002yL-Vk
 for qemu-devel@nongnu.org; Sun, 07 Apr 2024 17:46:36 -0400
Received: from mail-oi1-x22a.google.com ([2607:f8b0:4864:20::22a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <yuri.benditovich@daynix.com>)
 id 1rtaLS-00088K-VL
 for qemu-devel@nongnu.org; Sun, 07 Apr 2024 17:46:36 -0400
Received: by mail-oi1-x22a.google.com with SMTP id
 5614622812f47-3c5d940525fso2364319b6e.0
 for <qemu-devel@nongnu.org>; Sun, 07 Apr 2024 14:46:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=daynix-com.20230601.gappssmtp.com; s=20230601; t=1712526393; x=1713131193;
 darn=nongnu.org; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=55gRFYkUAxzZ0ZdtapLHxw0Idv4ECpSQk27Q4TANbcE=;
 b=FXOu2j3Agj8zSI292gSfb0OV5OrMvzCZ/J1FjubTOVp2+1wlv5KJx7+Er+ou0z+GQk
 Dsn3cilRGHuEzuvuf60HhkVI4Thmg88kGHuk4v+rFgdARZU8QtQ+WV+KLQbN1nSxDKnC
 bSkmIL9ZxgY9oflsVYaNoKMjUAlhVoKddYroihLT7ryxGMneg0w5yogCShx28BOrbUNK
 WR1hXztX4DEIaXrUMKqQwmXUH60wZ5EqYDJqNeABh1Lzl5NMy7hHQlpk8Ko2ed+Y9J6v
 1nuGy2Pf4uARfwWmA8ktY5YLV0zk/mlTcMpJGsJJF0Y2BUQ2STYtqo1NZ8ekLoxOXJCk
 ngUg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1712526393; x=1713131193;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=55gRFYkUAxzZ0ZdtapLHxw0Idv4ECpSQk27Q4TANbcE=;
 b=dM3WCzYneWerg0nhPLcbaVah5VOYI139w8S0FZyKcAOcpQKD4ALnf9nX/jEuoCUmqs
 4jin0fr5MrfqXd8BqXid7fABJYh+c37mPIacLe+dtozV2bp6pN0Zs3QsNJdZZ+yNyyxy
 GTVzCAUldusM0srxQDbvbmUgwr29T8a73x0yFbYET5hf8kZYCZ67YCgxdWYkuD4AnFVT
 F5BDXynYfmz2waoPM3Nqm8mj78d147jXDPNCb1hKBp6PZ1eoiHr+W/NolxHeBNt1e4SJ
 WBjZXIbRzp6mnECpHinPyadVKobqCqjlsh2DAbzX26d3X9dPAx+e4lfg3hsawCdN6uAJ
 GGyA==
X-Forwarded-Encrypted: i=1;
 AJvYcCV6iITAV8xp4vIUQDXuNyaKABSBQ0lKHBYqtUgkHdQ4GueVvDcH/AM7zr0tBzfRPQoJmiu7S9QUo1eKJEhd/oLSwPZfDJc=
X-Gm-Message-State: AOJu0YzFAiGyu6L9UkyVHvn4n5qZ49ipa+6tmEbh95HPWmx4sAfcgkHW
 BK1jn04vtZVSFtrRRwhgIIzp3hwiMEPHzwC1YzCZLaMvJ2vpCYUlVauxd03C1zQ+Nzxkx/MArA5
 kY6OXLywGEgA6Vq86tiYNSjsvHYYHJGThKIbHOw==
X-Google-Smtp-Source: AGHT+IET6fJjXLfgcxOBlgVkwedXFfDR3SDXa4OhBromOeyS2taq8I2yybrMfNidR19GyqIkXJSRYcCo6ZCvj82TQA0=
X-Received: by 2002:a05:6808:f94:b0:3c5:f628:a434 with SMTP id
 o20-20020a0568080f9400b003c5f628a434mr817569oiw.39.1712526393008; Sun, 07 Apr
 2024 14:46:33 -0700 (PDT)
MIME-Version: 1.0
References: <20240403-rss-v9-0-c6d87e69d38b@daynix.com>
 <20240403-rss-v9-13-c6d87e69d38b@daynix.com>
In-Reply-To: <20240403-rss-v9-13-c6d87e69d38b@daynix.com>
From: Yuri Benditovich <yuri.benditovich@daynix.com>
Date: Mon, 8 Apr 2024 00:46:21 +0300
Message-ID: <CAOEp5OdKAsUoJnLMXTM3RxbPT3c9Sob-7QRexCSqMNX10Enoug@mail.gmail.com>
Subject: Re: [PATCH v9 13/20] virtio-net: Return an error when vhost cannot
 enable RSS
To: Akihiko Odaki <akihiko.odaki@daynix.com>
Cc: Jason Wang <jasowang@redhat.com>,
 Dmitry Fleytman <dmitry.fleytman@gmail.com>, 
 Sriram Yagnaraman <sriram.yagnaraman@est.tech>,
 "Michael S. Tsirkin" <mst@redhat.com>, 
 Luigi Rizzo <rizzo@iet.unipi.it>, Giuseppe Lettieri <g.lettieri@iet.unipi.it>, 
 Vincenzo Maffione <v.maffione@gmail.com>,
 Andrew Melnychenko <andrew@daynix.com>, qemu-devel@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: none client-ip=2607:f8b0:4864:20::22a;
 envelope-from=yuri.benditovich@daynix.com; helo=mail-oi1-x22a.google.com
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_NONE=0.001 autolearn=ham autolearn_force=no
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

On Wed, Apr 3, 2024 at 2:11=E2=80=AFPM Akihiko Odaki <akihiko.odaki@daynix.=
com> wrote:
>
> vhost requires eBPF for RSS. When eBPF is not available, virtio-net
> implicitly disables RSS even if the user explicitly requests it. Return
> an error instead of implicitly disabling RSS if RSS is requested but not
> available.
>
> Signed-off-by: Akihiko Odaki <akihiko.odaki@daynix.com>
> ---
>  hw/net/virtio-net.c | 97 ++++++++++++++++++++++++++---------------------=
------
>  1 file changed, 48 insertions(+), 49 deletions(-)
>
> diff --git a/hw/net/virtio-net.c b/hw/net/virtio-net.c
> index 61b49e335dea..3d53eba88cfc 100644
> --- a/hw/net/virtio-net.c
> +++ b/hw/net/virtio-net.c
> @@ -793,9 +793,6 @@ static uint64_t virtio_net_get_features(VirtIODevice =
*vdev, uint64_t features,
>          return features;
>      }
>
> -    if (!ebpf_rss_is_loaded(&n->ebpf_rss)) {
> -        virtio_clear_feature(&features, VIRTIO_NET_F_RSS);
> -    }
>      features =3D vhost_net_get_features(get_vhost_net(nc->peer), feature=
s);
>      vdev->backend_features =3D features;
>
> @@ -3591,6 +3588,50 @@ static bool failover_hide_primary_device(DeviceLis=
tener *listener,
>      return qatomic_read(&n->failover_primary_hidden);
>  }
>
> +static void virtio_net_device_unrealize(DeviceState *dev)
> +{
> +    VirtIODevice *vdev =3D VIRTIO_DEVICE(dev);
> +    VirtIONet *n =3D VIRTIO_NET(dev);
> +    int i, max_queue_pairs;
> +
> +    if (virtio_has_feature(n->host_features, VIRTIO_NET_F_RSS)) {
> +        virtio_net_unload_ebpf(n);
> +    }
> +
> +    /* This will stop vhost backend if appropriate. */
> +    virtio_net_set_status(vdev, 0);
> +
> +    g_free(n->netclient_name);
> +    n->netclient_name =3D NULL;
> +    g_free(n->netclient_type);
> +    n->netclient_type =3D NULL;
> +
> +    g_free(n->mac_table.macs);
> +    g_free(n->vlans);
> +
> +    if (n->failover) {
> +        qobject_unref(n->primary_opts);
> +        device_listener_unregister(&n->primary_listener);
> +        migration_remove_notifier(&n->migration_state);
> +    } else {
> +        assert(n->primary_opts =3D=3D NULL);
> +    }
> +
> +    max_queue_pairs =3D n->multiqueue ? n->max_queue_pairs : 1;
> +    for (i =3D 0; i < max_queue_pairs; i++) {
> +        virtio_net_del_queue(n, i);
> +    }
> +    /* delete also control vq */
> +    virtio_del_queue(vdev, max_queue_pairs * 2);
> +    qemu_announce_timer_del(&n->announce_timer, false);
> +    g_free(n->vqs);
> +    qemu_del_nic(n->nic);
> +    virtio_net_rsc_cleanup(n);
> +    g_free(n->rss_data.indirections_table);
> +    net_rx_pkt_uninit(n->rx_pkt);
> +    virtio_cleanup(vdev);
> +}
> +
>  static void virtio_net_device_realize(DeviceState *dev, Error **errp)
>  {
>      VirtIODevice *vdev =3D VIRTIO_DEVICE(dev);
> @@ -3760,53 +3801,11 @@ static void virtio_net_device_realize(DeviceState=
 *dev, Error **errp)
>
>      net_rx_pkt_init(&n->rx_pkt);
>
> -    if (virtio_has_feature(n->host_features, VIRTIO_NET_F_RSS)) {
> -        virtio_net_load_ebpf(n);
> -    }
> -}
> -
> -static void virtio_net_device_unrealize(DeviceState *dev)
> -{
> -    VirtIODevice *vdev =3D VIRTIO_DEVICE(dev);
> -    VirtIONet *n =3D VIRTIO_NET(dev);
> -    int i, max_queue_pairs;
> -
> -    if (virtio_has_feature(n->host_features, VIRTIO_NET_F_RSS)) {
> -        virtio_net_unload_ebpf(n);
> +    if (virtio_has_feature(n->host_features, VIRTIO_NET_F_RSS) &&

I disagree with this change of qemu behavior.
From my point of view:
- this is not a major problem and it should not be a reason to stop VM exec=
ution
- it is enough to disable the RSS feature and continue working. Depending o=
n
  other qemu parameters (number of queues, number of cpus) this might be ju=
st
  suboptimal. might be a minor problem and might be not a problem at all
- this change defines rss as _only_ feature whose absence breaks the VM sta=
rt,
  _all_ other features are dropped silently and only rss is not. Why??
- the series has a title 'Fixes and improvements' . This is not a fix and n=
ot an
  improvement, this is significant behavioral change that should be discuss=
ed in
  light of future plans regarding rss
- I suggest to remove this change from the series, submit it separately
  and discuss from all the sides




> +        !virtio_net_load_ebpf(n) && get_vhost_net(nc->peer)) {
> +        virtio_net_device_unrealize(dev);
> +        error_setg(errp, "Can't load eBPF RSS for vhost");
>      }
> -
> -    /* This will stop vhost backend if appropriate. */
> -    virtio_net_set_status(vdev, 0);
> -
> -    g_free(n->netclient_name);
> -    n->netclient_name =3D NULL;
> -    g_free(n->netclient_type);
> -    n->netclient_type =3D NULL;
> -
> -    g_free(n->mac_table.macs);
> -    g_free(n->vlans);
> -
> -    if (n->failover) {
> -        qobject_unref(n->primary_opts);
> -        device_listener_unregister(&n->primary_listener);
> -        migration_remove_notifier(&n->migration_state);
> -    } else {
> -        assert(n->primary_opts =3D=3D NULL);
> -    }
> -
> -    max_queue_pairs =3D n->multiqueue ? n->max_queue_pairs : 1;
> -    for (i =3D 0; i < max_queue_pairs; i++) {
> -        virtio_net_del_queue(n, i);
> -    }
> -    /* delete also control vq */
> -    virtio_del_queue(vdev, max_queue_pairs * 2);
> -    qemu_announce_timer_del(&n->announce_timer, false);
> -    g_free(n->vqs);
> -    qemu_del_nic(n->nic);
> -    virtio_net_rsc_cleanup(n);
> -    g_free(n->rss_data.indirections_table);
> -    net_rx_pkt_uninit(n->rx_pkt);
> -    virtio_cleanup(vdev);
>  }
>
>  static void virtio_net_reset(VirtIODevice *vdev)
>
> --
> 2.44.0
>

