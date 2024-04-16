Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 173CCC4345F
	for <qemu-devel@archiver.kernel.org>; Tue, 16 Apr 2024 09:55:38 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rwfWt-0006dV-1c; Tue, 16 Apr 2024 05:55:07 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <yuri.benditovich@daynix.com>)
 id 1rwfWp-0006d7-HO
 for qemu-devel@nongnu.org; Tue, 16 Apr 2024 05:55:04 -0400
Received: from mail-qk1-x732.google.com ([2607:f8b0:4864:20::732])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <yuri.benditovich@daynix.com>)
 id 1rwfWn-0005dy-Gd
 for qemu-devel@nongnu.org; Tue, 16 Apr 2024 05:55:03 -0400
Received: by mail-qk1-x732.google.com with SMTP id
 af79cd13be357-78d57b9f3caso261703185a.3
 for <qemu-devel@nongnu.org>; Tue, 16 Apr 2024 02:55:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=daynix-com.20230601.gappssmtp.com; s=20230601; t=1713261299; x=1713866099;
 darn=nongnu.org; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=bjHtK/lZ2J39VqDcjOkMw5T5JI97jtSHrL6cTuPhQqo=;
 b=I8cu7v9MnpIAWQC6Me5ynhFT95KA3WW8soBaFGq9nB09Nm5vR+cdKeu81fRUl6V5di
 JAAi6Vl4MklUMh9JMnwPMQP158zhEDtNcY0qKE//GllW3H2aO8zHC2g3K0tNB2KkpM3X
 FVOcCpeBdXCx/bvfCqYtcN6SymP2OGsqKenQ5NSPwm+5xzebU1ZtS1AHdvCIb0duBBPD
 wfQLXoyLhP/UaVycL4tnMibw2ebhDCzGHQp1MPTuebXvQQMrIE1dzZtZfbS5D0tjAkub
 ELL5JtdBto4jK48cJnf+kAjCQHXd+UnDXZknmf6oyFTr/nPPiiOjKZKE4r0cmua6/JYL
 BoMg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1713261299; x=1713866099;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=bjHtK/lZ2J39VqDcjOkMw5T5JI97jtSHrL6cTuPhQqo=;
 b=pAiJai3uomsHyQl+pV3kW0XE9IY9p+MQtIcRbBzkj+qcCw64Dtw10QS5T7u2ng/Ao6
 APfnw2NHF+EiijaH2eA2T73wY3zu0mJvpy8otDa6aH+vv2fST2rINAoy8j7wQTqORBmM
 kSoEq9yNvYVGmYdg5KKsujD1kDW89jX/F8CUIaaaRZ4IYiR2ynsY16/YCZ/JZKAha4cQ
 YNjjboyJ4t+Z33obIm1Be/3oQTuuZHN81ASQ4zM80crETDxm/H3SLeV1r9ETxl0eRtZE
 RcU8FaaE+hS58E8Y9xfxfOECdYxHSKyZgGwNMiwo/edO+C2p04Y0QKvHmrYhG8pzONyd
 uCAQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCU/kirK3Z/8N5eObAkR/JMZC4e0qEJsNiszLZRxJZ5LW1KeBmKVOHie10kkY9lUMiE6+0KuaVQpCcSFrG8CN2W4NHsh+rQ=
X-Gm-Message-State: AOJu0YwH8WyJRIYZSpaZjDKih8v6hiQp/PXKLVIEqVFpE/zvoHXj5uHg
 hfDM0CSVe30iINJeYqFiGPKr2iS6VTABE65JJ4lyFvUl+ygvme8FbwZrfXfW7UrR+5R5t646SmK
 8P0dsfhk/eYbYFbIa6V6y9sko6uyjhDy9sX1TOw==
X-Google-Smtp-Source: AGHT+IG8VYYTCo7SXr6KO1374N0StcD/fm4uu85+1X3gb/frQKdxSJZcd05wMvcEVdCAxG7Qth6UNWyFxBdP4VP6UtM=
X-Received: by 2002:a05:622a:15d4:b0:432:e65e:bacc with SMTP id
 d20-20020a05622a15d400b00432e65ebaccmr14290986qty.58.1713261299710; Tue, 16
 Apr 2024 02:54:59 -0700 (PDT)
MIME-Version: 1.0
References: <20240403-rss-v9-0-c6d87e69d38b@daynix.com>
 <20240403-rss-v9-13-c6d87e69d38b@daynix.com>
In-Reply-To: <20240403-rss-v9-13-c6d87e69d38b@daynix.com>
From: Yuri Benditovich <yuri.benditovich@daynix.com>
Date: Tue, 16 Apr 2024 12:54:48 +0300
Message-ID: <CAOEp5OdWg-YeKwVt+UPLGANNpDx9OVvvEVsC3EPo+_ftoXrsDg@mail.gmail.com>
Subject: Re: [PATCH v9 13/20] virtio-net: Return an error when vhost cannot
 enable RSS
To: Akihiko Odaki <akihiko.odaki@daynix.com>
Cc: Jason Wang <jasowang@redhat.com>,
 Dmitry Fleytman <dmitry.fleytman@gmail.com>, 
 "Michael S. Tsirkin" <mst@redhat.com>, Luigi Rizzo <rizzo@iet.unipi.it>, 
 Giuseppe Lettieri <g.lettieri@iet.unipi.it>,
 Vincenzo Maffione <v.maffione@gmail.com>, 
 Andrew Melnychenko <andrew@daynix.com>, qemu-devel@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: none client-ip=2607:f8b0:4864:20::732;
 envelope-from=yuri.benditovich@daynix.com; helo=mail-qk1-x732.google.com
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
> +        !virtio_net_load_ebpf(n) && get_vhost_net(nc->peer)) {
> +        virtio_net_device_unrealize(dev);
> +        error_setg(errp, "Can't load eBPF RSS for vhost");

One more thing:
In case of failure the message (it will be visible to the user, if I'm
not mistaken)
should be more clear, with a suggestion to disable the 'rss' feature.

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

