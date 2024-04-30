Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5496DC4345F
	for <qemu-devel@archiver.kernel.org>; Tue, 30 Apr 2024 15:04:00 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s1p0n-0007zr-D8; Tue, 30 Apr 2024 11:03:17 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <yuri.benditovich@daynix.com>)
 id 1s1p0E-0007rE-9p
 for qemu-devel@nongnu.org; Tue, 30 Apr 2024 11:02:44 -0400
Received: from mail-qt1-x835.google.com ([2607:f8b0:4864:20::835])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <yuri.benditovich@daynix.com>)
 id 1s1p0B-0007fE-AW
 for qemu-devel@nongnu.org; Tue, 30 Apr 2024 11:02:41 -0400
Received: by mail-qt1-x835.google.com with SMTP id
 d75a77b69052e-434d0a63151so33616661cf.3
 for <qemu-devel@nongnu.org>; Tue, 30 Apr 2024 08:02:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=daynix-com.20230601.gappssmtp.com; s=20230601; t=1714489358; x=1715094158;
 darn=nongnu.org; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=pJQrjBlp3iIMviMUeas3jBSpCXrhdT1bR2IKUC/GpKY=;
 b=Ql3LcZIAesG/iOSS3vn+8IFWD2c6TJ7KjSul2VisUkOkLKRpKX7BefKKBWr1FzJ3Mt
 vUbCIks8D/A+EJAdJ9h3zz7eyoMq5E4aq2ld6pc/3Yfm7udq8tDbet9SUv21DfCjrptP
 olQy0KnRAypvj+5LptIESSfEmgR43p6eCuep9+wbOUaUmaJgt63KN4FaCPa1UHgGQNf1
 5e/dJgCD9RXS+1WeG+ega7YvGV6HG0Uo1nkERNktg618ZM0tdr11TmNEitScO3vx8kHV
 r77ZL8SyK0JEKf5cazdok9tgvg2Xe8Y2tW4PKzCrhqIjotb4JGu2sAfn016tplI8FIOD
 Z9zw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1714489358; x=1715094158;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=pJQrjBlp3iIMviMUeas3jBSpCXrhdT1bR2IKUC/GpKY=;
 b=YKoq3wRxAr/5HS66pXSHAWftXI1e+El66mRsehVHuvq0iQ3jP4xpgad2eGfL3Wyfcq
 sN9haf2CVQclqMv6wgmpGbmYN3F1YSgbb2nOFHheSdcx6jYczt6s4xqkRMmXI5pZNonn
 wh2bRWFF9yToZT6IfkfluAl284ow+9HzEBSLikA5L5IH0ErfEGlvFK0dAgjmQRMTUzeK
 +KYkApQGAZg8voHCiw5+tF5UEqOABFFxci2b0Ew5oqzYheHsb8njBTpiV8nwiuMIS5t7
 BB08iTt99rqU40NqQ2ib12Zp7dvZkgKkTB0Cj/rUvorkf1TguPh3AvLIbjSTJvIN99wn
 ikvw==
X-Forwarded-Encrypted: i=1;
 AJvYcCXj4widLrmPEVZuKGC2MjKzuCxLv3GY5uV0SykBP5yGv0sNiZqrVMUlx/SLt5p5eoaZuBXlarvQcL/Z2xTqMiUUr20hwbM=
X-Gm-Message-State: AOJu0Yz2MaKd02HW6B1FEvvboBlYILN7kunrHjK8PLT6R27vWgZzEmCc
 9wFLnuznkzF092XIqVXkN7gLnf/1MqZnbzUTYaibFufN8XHnvBdowRi1NNKCHiipP85eY+EMF6R
 SIw5LULIYFpz1gf8+ERlELNdrT/WEcIKxvpwX1A==
X-Google-Smtp-Source: AGHT+IEqG5ZvWdbrez4BD6b72+YvpsKzZNiM5mz2at5VeY/rUhpF/ZsVqNCAYdXRl1lZhfUMFGYoLOyq1Kqi6BadrdA=
X-Received: by 2002:a05:622a:4b15:b0:439:e95e:5bc0 with SMTP id
 et21-20020a05622a4b1500b00439e95e5bc0mr12159070qtb.40.1714489353133; Tue, 30
 Apr 2024 08:02:33 -0700 (PDT)
MIME-Version: 1.0
References: <20240428-auto-v1-0-7b012216a120@daynix.com>
 <20240428-auto-v1-2-7b012216a120@daynix.com>
In-Reply-To: <20240428-auto-v1-2-7b012216a120@daynix.com>
From: Yuri Benditovich <yuri.benditovich@daynix.com>
Date: Tue, 30 Apr 2024 18:02:22 +0300
Message-ID: <CAOEp5OcvLRvCVsGcC=8Y-P1tzJ4Tn+21Y6rJe_2ZVK-cDzePxw@mail.gmail.com>
Subject: Re: [PATCH 2/3] virtio-net: Convert feature properties to OnOffAuto
To: Akihiko Odaki <akihiko.odaki@daynix.com>
Cc: Jason Wang <jasowang@redhat.com>,
 Dmitry Fleytman <dmitry.fleytman@gmail.com>, 
 Sriram Yagnaraman <sriram.yagnaraman@ericsson.com>,
 "Michael S. Tsirkin" <mst@redhat.com>, 
 Luigi Rizzo <rizzo@iet.unipi.it>, Giuseppe Lettieri <g.lettieri@iet.unipi.it>, 
 Vincenzo Maffione <v.maffione@gmail.com>,
 Andrew Melnychenko <andrew@daynix.com>, 
 Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>, 
 Eduardo Habkost <eduardo@habkost.net>, qemu-devel@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: none client-ip=2607:f8b0:4864:20::835;
 envelope-from=yuri.benditovich@daynix.com; helo=mail-qt1-x835.google.com
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

Question:
How will libvirt (as an example) work with this change. In the
existing semantic of libvirt profile the "on" means "on if possible"
and using existing profile after qemu update will still use "on" with
meaning "force"?
Typically this is solved by machine type - if libvirt uses
'machine=3D'pc-q35-8.1'' this will be backward-compatible.
How will this change be accepted?

On Sun, Apr 28, 2024 at 10:21=E2=80=AFAM Akihiko Odaki <akihiko.odaki@dayni=
x.com> wrote:
>
> Some features are not always available, and virtio-net used to disable
> them when not available even if the corresponding properties were
> explicitly set to "on".
>
> Convert feature properties to OnOffAuto so that the user can explicitly
> tell QEMU to automatically select the value by setting them "auto".
> QEMU will give an error if they are set "on".
>
> Signed-off-by: Akihiko Odaki <akihiko.odaki@daynix.com>
> ---
>  include/hw/virtio/virtio-net.h |   2 +-
>  hw/net/virtio-net.c            | 247 +++++++++++++++++++++++++----------=
------
>  2 files changed, 152 insertions(+), 97 deletions(-)
>
> diff --git a/include/hw/virtio/virtio-net.h b/include/hw/virtio/virtio-ne=
t.h
> index 060c23c04d2d..ff32e30f001b 100644
> --- a/include/hw/virtio/virtio-net.h
> +++ b/include/hw/virtio/virtio-net.h
> @@ -178,7 +178,7 @@ struct VirtIONet {
>      uint32_t has_vnet_hdr;
>      size_t host_hdr_len;
>      size_t guest_hdr_len;
> -    uint64_t host_features;
> +    OnOffAutoBit64 host_features;
>      uint32_t rsc_timeout;
>      uint8_t rsc4_enabled;
>      uint8_t rsc6_enabled;
> diff --git a/hw/net/virtio-net.c b/hw/net/virtio-net.c
> index c8059dc99bd4..5b6c901915a9 100644
> --- a/hw/net/virtio-net.c
> +++ b/hw/net/virtio-net.c
> @@ -750,58 +750,96 @@ static void virtio_net_set_queue_pairs(VirtIONet *n=
)
>
>  static void virtio_net_set_multiqueue(VirtIONet *n, int multiqueue);
>
> +static bool virtio_net_clear_features(OnOffAutoBit64 *features,
> +                                      uint64_t clear_bits,
> +                                      const char *reason, Error **errp)
> +{
> +    if (features->on_bits & clear_bits) {
> +        error_setg(errp, "%s", reason);
> +        return false;
> +    }
> +
> +    features->auto_bits &=3D ~clear_bits;
> +
> +    return true;
> +}
> +
>  static uint64_t virtio_net_get_features(VirtIODevice *vdev, uint64_t fea=
tures,
>                                          Error **errp)
>  {
>      VirtIONet *n =3D VIRTIO_NET(vdev);
>      NetClientState *nc =3D qemu_get_queue(n->nic);
> -
> -    /* Firstly sync all virtio-net possible supported features */
> -    features |=3D n->host_features;
> -
> -    virtio_add_feature(&features, VIRTIO_NET_F_MAC);
> -
> -    if (!peer_has_vnet_hdr(n)) {
> -        virtio_clear_feature(&features, VIRTIO_NET_F_CSUM);
> -        virtio_clear_feature(&features, VIRTIO_NET_F_HOST_TSO4);
> -        virtio_clear_feature(&features, VIRTIO_NET_F_HOST_TSO6);
> -        virtio_clear_feature(&features, VIRTIO_NET_F_HOST_ECN);
> -
> -        virtio_clear_feature(&features, VIRTIO_NET_F_GUEST_CSUM);
> -        virtio_clear_feature(&features, VIRTIO_NET_F_GUEST_TSO4);
> -        virtio_clear_feature(&features, VIRTIO_NET_F_GUEST_TSO6);
> -        virtio_clear_feature(&features, VIRTIO_NET_F_GUEST_ECN);
> -
> -        virtio_clear_feature(&features, VIRTIO_NET_F_HOST_USO);
> -        virtio_clear_feature(&features, VIRTIO_NET_F_GUEST_USO4);
> -        virtio_clear_feature(&features, VIRTIO_NET_F_GUEST_USO6);
> -
> -        virtio_clear_feature(&features, VIRTIO_NET_F_HASH_REPORT);
> -    }
> -
> -    if (!peer_has_vnet_hdr(n) || !peer_has_ufo(n)) {
> -        virtio_clear_feature(&features, VIRTIO_NET_F_GUEST_UFO);
> -        virtio_clear_feature(&features, VIRTIO_NET_F_HOST_UFO);
> -    }
> -
> -    if (!peer_has_uso(n)) {
> -        virtio_clear_feature(&features, VIRTIO_NET_F_HOST_USO);
> -        virtio_clear_feature(&features, VIRTIO_NET_F_GUEST_USO4);
> -        virtio_clear_feature(&features, VIRTIO_NET_F_GUEST_USO6);
> +    OnOffAutoBit64 on_off_auto_features =3D n->host_features;
> +
> +    on_off_auto_features.on_bits |=3D features;
> +    virtio_add_feature(&on_off_auto_features.auto_bits, VIRTIO_NET_F_MAC=
);
> +
> +    if (!((peer_has_vnet_hdr(n) ||
> +           virtio_net_clear_features(&on_off_auto_features,
> +                                     BIT_ULL(VIRTIO_NET_F_CSUM) |
> +                                     BIT_ULL(VIRTIO_NET_F_HOST_TSO4) |
> +                                     BIT_ULL(VIRTIO_NET_F_HOST_TSO6) |
> +                                     BIT_ULL(VIRTIO_NET_F_HOST_ECN) |
> +                                     BIT_ULL(VIRTIO_NET_F_GUEST_UFO) |
> +                                     BIT_ULL(VIRTIO_NET_F_GUEST_CSUM) |
> +                                     BIT_ULL(VIRTIO_NET_F_GUEST_TSO4) |
> +                                     BIT_ULL(VIRTIO_NET_F_GUEST_TSO6) |
> +                                     BIT_ULL(VIRTIO_NET_F_GUEST_ECN) |
> +                                     BIT_ULL(VIRTIO_NET_F_HOST_UFO) |
> +                                     BIT_ULL(VIRTIO_NET_F_HOST_USO) |
> +                                     BIT_ULL(VIRTIO_NET_F_GUEST_USO4) |
> +                                     BIT_ULL(VIRTIO_NET_F_GUEST_USO6) |
> +                                     BIT_ULL(VIRTIO_NET_F_HASH_REPORT),
> +                                     "A requested feature requires the p=
eer to support virtio-net headers.",
> +                                     errp)) &&
> +          (peer_has_ufo(n) ||
> +           virtio_net_clear_features(&on_off_auto_features,
> +                                     BIT_ULL(VIRTIO_NET_F_GUEST_UFO) |
> +                                     BIT_ULL(VIRTIO_NET_F_HOST_UFO),
> +                                     "UFO is on but the peer does not su=
pport it.",
> +                                     errp)) &&
> +          (peer_has_uso(n) ||
> +           virtio_net_clear_features(&on_off_auto_features,
> +                                     BIT_ULL(VIRTIO_NET_F_HOST_USO) |
> +                                     BIT_ULL(VIRTIO_NET_F_GUEST_USO4) |
> +                                     BIT_ULL(VIRTIO_NET_F_GUEST_USO6),
> +                                     "USO is on but the peer does not su=
pport it.",
> +                                     errp)) &&
> +          (virtio_has_feature(on_off_auto_features.on_bits |
> +                              on_off_auto_features.auto_bits,
> +                              VIRTIO_NET_F_CTRL_VQ) ||
> +           virtio_net_clear_features(&on_off_auto_features,
> +                                     BIT_ULL(VIRTIO_NET_F_GUEST_ANNOUNCE=
),
> +                                     "guest_announce is on but ctrl_vq i=
s off.",
> +                                     errp)))) {
> +        return 0;
>      }
>
>      if (!get_vhost_net(nc->peer)) {
> -        return features;
> +        if (!ebpf_rss_is_loaded(&n->ebpf_rss)) {
> +            virtio_clear_feature(&on_off_auto_features.auto_bits,
> +                                 VIRTIO_NET_F_RSS);
> +        }
> +
> +        return on_off_auto_features.on_bits | on_off_auto_features.auto_=
bits;
>      }
>
> -    if (!ebpf_rss_is_loaded(&n->ebpf_rss)) {
> -        virtio_clear_feature(&features, VIRTIO_NET_F_RSS);
> +    if (!ebpf_rss_is_loaded(&n->ebpf_rss) &&
> +        !virtio_net_clear_features(&on_off_auto_features,
> +                                   BIT_ULL(VIRTIO_NET_F_RSS),
> +                                   "Both RSS and vhost are on but eBPF i=
s unavailable; fix eBPF or disable RSS.",
> +                                   errp)) {
> +        return 0;
>      }
> -    features =3D vhost_net_get_features(get_vhost_net(nc->peer), feature=
s);
> +    features =3D vhost_net_get_features(get_vhost_net(nc->peer),
> +                                      on_off_auto_features.on_bits |
> +                                      on_off_auto_features.auto_bits);
>      vdev->backend_features =3D features;
>
>      if (n->mtu_bypass_backend &&
> -            (n->host_features & 1ULL << VIRTIO_NET_F_MTU)) {
> +        virtio_has_feature(on_off_auto_features.on_bits |
> +                           on_off_auto_features.auto_bits,
> +                           VIRTIO_NET_F_MTU)) {
>          features |=3D (1ULL << VIRTIO_NET_F_MTU);
>      }
>
> @@ -820,6 +858,12 @@ static uint64_t virtio_net_get_features(VirtIODevice=
 *vdev, uint64_t features,
>          virtio_clear_feature(&features, VIRTIO_NET_F_GUEST_ANNOUNCE);
>      }
>
> +    if ((features & on_off_auto_features.on_bits) !=3D
> +        on_off_auto_features.on_bits) {
> +        error_setg(errp, "A requested feature is incompatible with vhost=
.");
> +        return 0;
> +    }
> +
>      return features;
>  }
>
> @@ -3598,7 +3642,7 @@ static void virtio_net_device_realize(DeviceState *=
dev, Error **errp)
>      int i;
>
>      if (n->net_conf.mtu) {
> -        n->host_features |=3D (1ULL << VIRTIO_NET_F_MTU);
> +        n->host_features.on_bits |=3D (1ULL << VIRTIO_NET_F_MTU);
>      }
>
>      if (n->net_conf.duplex_str) {
> @@ -3610,7 +3654,7 @@ static void virtio_net_device_realize(DeviceState *=
dev, Error **errp)
>              error_setg(errp, "'duplex' must be 'half' or 'full'");
>              return;
>          }
> -        n->host_features |=3D (1ULL << VIRTIO_NET_F_SPEED_DUPLEX);
> +        n->host_features.on_bits |=3D (1ULL << VIRTIO_NET_F_SPEED_DUPLEX=
);
>      } else {
>          n->net_conf.duplex =3D DUPLEX_UNKNOWN;
>      }
> @@ -3620,7 +3664,7 @@ static void virtio_net_device_realize(DeviceState *=
dev, Error **errp)
>          return;
>      }
>      if (n->net_conf.speed >=3D 0) {
> -        n->host_features |=3D (1ULL << VIRTIO_NET_F_SPEED_DUPLEX);
> +        n->host_features.on_bits |=3D (1ULL << VIRTIO_NET_F_SPEED_DUPLEX=
);
>      }
>
>      if (n->failover) {
> @@ -3629,10 +3673,12 @@ static void virtio_net_device_realize(DeviceState=
 *dev, Error **errp)
>          device_listener_register(&n->primary_listener);
>          migration_add_notifier(&n->migration_state,
>                                 virtio_net_migration_state_notifier);
> -        n->host_features |=3D (1ULL << VIRTIO_NET_F_STANDBY);
> +        n->host_features.on_bits |=3D (1ULL << VIRTIO_NET_F_STANDBY);
>      }
>
> -    virtio_net_set_config_size(n, n->host_features);
> +    virtio_net_set_config_size(n,
> +                               n->host_features.on_bits |
> +                               n->host_features.auto_bits);
>      virtio_init(vdev, VIRTIO_ID_NET, n->config_size);
>
>      /*
> @@ -3759,7 +3805,9 @@ static void virtio_net_device_realize(DeviceState *=
dev, Error **errp)
>
>      net_rx_pkt_init(&n->rx_pkt);
>
> -    if (virtio_has_feature(n->host_features, VIRTIO_NET_F_RSS)) {
> +    if (virtio_has_feature(n->host_features.on_bits |
> +                           n->host_features.auto_bits,
> +                           VIRTIO_NET_F_RSS)) {
>          virtio_net_load_ebpf(n);
>      }
>  }
> @@ -3770,7 +3818,9 @@ static void virtio_net_device_unrealize(DeviceState=
 *dev)
>      VirtIONet *n =3D VIRTIO_NET(dev);
>      int i, max_queue_pairs;
>
> -    if (virtio_has_feature(n->host_features, VIRTIO_NET_F_RSS)) {
> +    if (virtio_has_feature(n->host_features.on_bits |
> +                           n->host_features.auto_bits,
> +                           VIRTIO_NET_F_RSS)) {
>          virtio_net_unload_ebpf(n);
>      }
>
> @@ -3914,53 +3964,58 @@ static const VMStateDescription vmstate_virtio_ne=
t =3D {
>  };
>
>  static Property virtio_net_properties[] =3D {
> -    DEFINE_PROP_BIT64("csum", VirtIONet, host_features,
> -                    VIRTIO_NET_F_CSUM, true),
> -    DEFINE_PROP_BIT64("guest_csum", VirtIONet, host_features,
> -                    VIRTIO_NET_F_GUEST_CSUM, true),
> -    DEFINE_PROP_BIT64("gso", VirtIONet, host_features, VIRTIO_NET_F_GSO,=
 true),
> -    DEFINE_PROP_BIT64("guest_tso4", VirtIONet, host_features,
> -                    VIRTIO_NET_F_GUEST_TSO4, true),
> -    DEFINE_PROP_BIT64("guest_tso6", VirtIONet, host_features,
> -                    VIRTIO_NET_F_GUEST_TSO6, true),
> -    DEFINE_PROP_BIT64("guest_ecn", VirtIONet, host_features,
> -                    VIRTIO_NET_F_GUEST_ECN, true),
> -    DEFINE_PROP_BIT64("guest_ufo", VirtIONet, host_features,
> -                    VIRTIO_NET_F_GUEST_UFO, true),
> -    DEFINE_PROP_BIT64("guest_announce", VirtIONet, host_features,
> -                    VIRTIO_NET_F_GUEST_ANNOUNCE, true),
> -    DEFINE_PROP_BIT64("host_tso4", VirtIONet, host_features,
> -                    VIRTIO_NET_F_HOST_TSO4, true),
> -    DEFINE_PROP_BIT64("host_tso6", VirtIONet, host_features,
> -                    VIRTIO_NET_F_HOST_TSO6, true),
> -    DEFINE_PROP_BIT64("host_ecn", VirtIONet, host_features,
> -                    VIRTIO_NET_F_HOST_ECN, true),
> -    DEFINE_PROP_BIT64("host_ufo", VirtIONet, host_features,
> -                    VIRTIO_NET_F_HOST_UFO, true),
> -    DEFINE_PROP_BIT64("mrg_rxbuf", VirtIONet, host_features,
> -                    VIRTIO_NET_F_MRG_RXBUF, true),
> -    DEFINE_PROP_BIT64("status", VirtIONet, host_features,
> -                    VIRTIO_NET_F_STATUS, true),
> -    DEFINE_PROP_BIT64("ctrl_vq", VirtIONet, host_features,
> -                    VIRTIO_NET_F_CTRL_VQ, true),
> -    DEFINE_PROP_BIT64("ctrl_rx", VirtIONet, host_features,
> -                    VIRTIO_NET_F_CTRL_RX, true),
> -    DEFINE_PROP_BIT64("ctrl_vlan", VirtIONet, host_features,
> -                    VIRTIO_NET_F_CTRL_VLAN, true),
> -    DEFINE_PROP_BIT64("ctrl_rx_extra", VirtIONet, host_features,
> -                    VIRTIO_NET_F_CTRL_RX_EXTRA, true),
> -    DEFINE_PROP_BIT64("ctrl_mac_addr", VirtIONet, host_features,
> -                    VIRTIO_NET_F_CTRL_MAC_ADDR, true),
> -    DEFINE_PROP_BIT64("ctrl_guest_offloads", VirtIONet, host_features,
> -                    VIRTIO_NET_F_CTRL_GUEST_OFFLOADS, true),
> -    DEFINE_PROP_BIT64("mq", VirtIONet, host_features, VIRTIO_NET_F_MQ, f=
alse),
> -    DEFINE_PROP_BIT64("rss", VirtIONet, host_features,
> -                    VIRTIO_NET_F_RSS, false),
> -    DEFINE_PROP_BIT64("hash", VirtIONet, host_features,
> -                    VIRTIO_NET_F_HASH_REPORT, false),
> +    DEFINE_PROP_ON_OFF_AUTO_BIT64("csum", VirtIONet, host_features,
> +                                  VIRTIO_NET_F_CSUM, ON_OFF_AUTO_AUTO),
> +    DEFINE_PROP_ON_OFF_AUTO_BIT64("guest_csum", VirtIONet, host_features=
,
> +                                  VIRTIO_NET_F_GUEST_CSUM, ON_OFF_AUTO_A=
UTO),
> +    DEFINE_PROP_ON_OFF_AUTO_BIT64("gso", VirtIONet, host_features,
> +                                  VIRTIO_NET_F_GSO, ON_OFF_AUTO_AUTO),
> +    DEFINE_PROP_ON_OFF_AUTO_BIT64("guest_tso4", VirtIONet, host_features=
,
> +                                  VIRTIO_NET_F_GUEST_TSO4, ON_OFF_AUTO_A=
UTO),
> +    DEFINE_PROP_ON_OFF_AUTO_BIT64("guest_tso6", VirtIONet, host_features=
,
> +                                  VIRTIO_NET_F_GUEST_TSO6, ON_OFF_AUTO_A=
UTO),
> +    DEFINE_PROP_ON_OFF_AUTO_BIT64("guest_ecn", VirtIONet, host_features,
> +                                  VIRTIO_NET_F_GUEST_ECN, ON_OFF_AUTO_AU=
TO),
> +    DEFINE_PROP_ON_OFF_AUTO_BIT64("guest_ufo", VirtIONet, host_features,
> +                                  VIRTIO_NET_F_GUEST_UFO, ON_OFF_AUTO_AU=
TO),
> +    DEFINE_PROP_ON_OFF_AUTO_BIT64("guest_announce", VirtIONet, host_feat=
ures,
> +                                  VIRTIO_NET_F_GUEST_ANNOUNCE,
> +                                  ON_OFF_AUTO_AUTO),
> +    DEFINE_PROP_ON_OFF_AUTO_BIT64("host_tso4", VirtIONet, host_features,
> +                                  VIRTIO_NET_F_HOST_TSO4, ON_OFF_AUTO_AU=
TO),
> +    DEFINE_PROP_ON_OFF_AUTO_BIT64("host_tso6", VirtIONet, host_features,
> +                                  VIRTIO_NET_F_HOST_TSO6, ON_OFF_AUTO_AU=
TO),
> +    DEFINE_PROP_ON_OFF_AUTO_BIT64("host_ecn", VirtIONet, host_features,
> +                                  VIRTIO_NET_F_HOST_ECN, ON_OFF_AUTO_AUT=
O),
> +    DEFINE_PROP_ON_OFF_AUTO_BIT64("host_ufo", VirtIONet, host_features,
> +                                  VIRTIO_NET_F_HOST_UFO, ON_OFF_AUTO_AUT=
O),
> +    DEFINE_PROP_ON_OFF_AUTO_BIT64("mrg_rxbuf", VirtIONet, host_features,
> +                                  VIRTIO_NET_F_MRG_RXBUF, ON_OFF_AUTO_AU=
TO),
> +    DEFINE_PROP_ON_OFF_AUTO_BIT64("status", VirtIONet, host_features,
> +                                  VIRTIO_NET_F_STATUS, ON_OFF_AUTO_AUTO)=
,
> +    DEFINE_PROP_ON_OFF_AUTO_BIT64("ctrl_vq", VirtIONet, host_features,
> +                                  VIRTIO_NET_F_CTRL_VQ, ON_OFF_AUTO_AUTO=
),
> +    DEFINE_PROP_ON_OFF_AUTO_BIT64("ctrl_rx", VirtIONet, host_features,
> +                                  VIRTIO_NET_F_CTRL_RX, ON_OFF_AUTO_AUTO=
),
> +    DEFINE_PROP_ON_OFF_AUTO_BIT64("ctrl_vlan", VirtIONet, host_features,
> +                                  VIRTIO_NET_F_CTRL_VLAN, ON_OFF_AUTO_AU=
TO),
> +    DEFINE_PROP_ON_OFF_AUTO_BIT64("ctrl_rx_extra", VirtIONet, host_featu=
res,
> +                                  VIRTIO_NET_F_CTRL_RX_EXTRA, ON_OFF_AUT=
O_AUTO),
> +    DEFINE_PROP_ON_OFF_AUTO_BIT64("ctrl_mac_addr", VirtIONet, host_featu=
res,
> +                                  VIRTIO_NET_F_CTRL_MAC_ADDR, ON_OFF_AUT=
O_AUTO),
> +    DEFINE_PROP_ON_OFF_AUTO_BIT64("ctrl_guest_offloads", VirtIONet,
> +                                  host_features,
> +                                  VIRTIO_NET_F_CTRL_GUEST_OFFLOADS,
> +                                  ON_OFF_AUTO_AUTO),
> +    DEFINE_PROP_ON_OFF_AUTO_BIT64("mq", VirtIONet, host_features,
> +                                  VIRTIO_NET_F_MQ, ON_OFF_AUTO_OFF),

Probably for 'mq' there is no difference between 'auto' and 'on' ?

> +    DEFINE_PROP_ON_OFF_AUTO_BIT64("rss", VirtIONet, host_features,
> +                                  VIRTIO_NET_F_RSS, ON_OFF_AUTO_OFF),
> +    DEFINE_PROP_ON_OFF_AUTO_BIT64("hash", VirtIONet, host_features,
> +                                  VIRTIO_NET_F_HASH_REPORT, ON_OFF_AUTO_=
OFF),
>      DEFINE_PROP_ARRAY("ebpf-rss-fds", VirtIONet, nr_ebpf_rss_fds,
>                        ebpf_rss_fds, qdev_prop_string, char*),
> -    DEFINE_PROP_BIT64("guest_rsc_ext", VirtIONet, host_features,
> +    DEFINE_PROP_BIT64("guest_rsc_ext", VirtIONet, host_features.on_bits,
>                      VIRTIO_NET_F_RSC_EXT, false),
>      DEFINE_PROP_UINT32("rsc_interval", VirtIONet, rsc_timeout,
>                         VIRTIO_NET_RSC_DEFAULT_INTERVAL),
> @@ -3979,12 +4034,12 @@ static Property virtio_net_properties[] =3D {
>      DEFINE_PROP_INT32("speed", VirtIONet, net_conf.speed, SPEED_UNKNOWN)=
,
>      DEFINE_PROP_STRING("duplex", VirtIONet, net_conf.duplex_str),
>      DEFINE_PROP_BOOL("failover", VirtIONet, failover, false),
> -    DEFINE_PROP_BIT64("guest_uso4", VirtIONet, host_features,
> -                      VIRTIO_NET_F_GUEST_USO4, true),
> -    DEFINE_PROP_BIT64("guest_uso6", VirtIONet, host_features,
> -                      VIRTIO_NET_F_GUEST_USO6, true),
> -    DEFINE_PROP_BIT64("host_uso", VirtIONet, host_features,
> -                      VIRTIO_NET_F_HOST_USO, true),
> +    DEFINE_PROP_ON_OFF_AUTO_BIT64("guest_uso4", VirtIONet, host_features=
,
> +                                  VIRTIO_NET_F_GUEST_USO4, ON_OFF_AUTO_A=
UTO),
> +    DEFINE_PROP_ON_OFF_AUTO_BIT64("guest_uso6", VirtIONet, host_features=
,
> +                                  VIRTIO_NET_F_GUEST_USO6, ON_OFF_AUTO_A=
UTO),
> +    DEFINE_PROP_ON_OFF_AUTO_BIT64("host_uso", VirtIONet, host_features,
> +                                  VIRTIO_NET_F_HOST_USO, ON_OFF_AUTO_AUT=
O),
>      DEFINE_PROP_END_OF_LIST(),
>  };
>
>
> --
> 2.44.0
>

