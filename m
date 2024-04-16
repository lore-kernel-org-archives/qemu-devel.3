Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A2468C4345F
	for <qemu-devel@archiver.kernel.org>; Tue, 16 Apr 2024 05:44:45 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rwbbe-0007g7-QJ; Tue, 16 Apr 2024 01:43:47 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <yuri.benditovich@daynix.com>)
 id 1rwbba-0007fd-VX
 for qemu-devel@nongnu.org; Tue, 16 Apr 2024 01:43:43 -0400
Received: from mail-qk1-x72c.google.com ([2607:f8b0:4864:20::72c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <yuri.benditovich@daynix.com>)
 id 1rwbbX-0005zR-KT
 for qemu-devel@nongnu.org; Tue, 16 Apr 2024 01:43:42 -0400
Received: by mail-qk1-x72c.google.com with SMTP id
 af79cd13be357-78d683c469dso407193585a.1
 for <qemu-devel@nongnu.org>; Mon, 15 Apr 2024 22:43:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=daynix-com.20230601.gappssmtp.com; s=20230601; t=1713246218; x=1713851018;
 darn=nongnu.org; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=gL4j7xRI6oHxjuMHXpqqRJPQzp3c+HhkfgDFFNAGhOY=;
 b=KkuUe6SYErdxwRTFXnrwUrUQg/X7grmQqQcr0uG9GvjBGCbweBPUDupBDiZCRlO5J9
 cUohAMLu4v8sJHca2IswAZRY1wVXqW4pMqUXcV1cKVxO4OXjHxMdDtNxoOeR6mGFpRNL
 SjLeiykoUP3+FzKuGJVyC3LuxFbii3d0Lkdvk8W6MXPFQbBKCJJff6SI141L1xJ2eQqQ
 8Wz1SDdR6rUvNlB24RNovfbG5IkwnMlBm0s1ZT5kIN0azvtBWt3AzI7EfGM1CwanSpBq
 XZmv+KooRLYdOZ3QxbH3i9M2F/FrH2jcSRYe9l9pwusN0BdSdm9WZQMEEu/XB8pMfK75
 o3eA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1713246218; x=1713851018;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=gL4j7xRI6oHxjuMHXpqqRJPQzp3c+HhkfgDFFNAGhOY=;
 b=lr2SDB5R4j2d83JKJuDxUkL9OeLONBwvJIZ6KRxuNCC1kXRA7LxkUZdOUO3dth/j4c
 Q6X1RObeBADOAcX8GNfk/IbOu1G1hHBrq+68UTGeYgc0dpvEe8Nl5fNJUFUiwiMZDhJO
 gk2SDSTGg8fvTevqA7KO4gwYmAcW7Uzy45hi3SvTkT3fe/ymI19ymYbgFgiut78b3yTK
 S91sm92wPkZ+EgI2gwAqs7MUSaf3aPnurZwgU7E7OgbBjooLee/iMSYtG2VJg5FXO/cn
 +yISvbm/YrDKI2MfMtZx9s+M4NZ1QMTn4OGNEzlXMezfNDTxybMqsx298evuO2+FzILb
 yxzQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCW1veWP4w23LVcKsm6phpYD2DIjyL2fL2URtXIYj/8piGMd4b5fwlZDBOwmMQLlE87G7boFCHDErn2yOzTAu4XuMxXra/4=
X-Gm-Message-State: AOJu0YzXlSAh4rn5WQVmjKZ0/EDQGtJ4vcaOY8Dp+ywlZIefbeFpaBhD
 3WebkWI5nXG36JJfDQqhI3k4pC6PlZELhwkKXlUdwLDqwj2RrChvt9sqRKyzDWzJRDwbXglcD5y
 L69DrHAVL3XGBUz2rS7N7ftdH/218Fn8/PNY29w==
X-Google-Smtp-Source: AGHT+IHT2SrcbkUylHV20jEU2jLfKNxDr2lDPTGTagBMWUjInEu6NltKqKJfa3F+dX4wEHubmCsEBoh4ungiFI/xR4I=
X-Received: by 2002:a05:620a:4048:b0:78e:d99b:ca7c with SMTP id
 i8-20020a05620a404800b0078ed99bca7cmr11588822qko.43.1713246218347; Mon, 15
 Apr 2024 22:43:38 -0700 (PDT)
MIME-Version: 1.0
References: <20240403-rss-v9-0-c6d87e69d38b@daynix.com>
 <20240403-rss-v9-13-c6d87e69d38b@daynix.com>
 <CAOEp5OeXLFTUsH5egdMfsEPACM0O2XODOeYbpggD0T2Zv6ceYQ@mail.gmail.com>
 <CACGkMEuG5mDzU-UwHvrZ3TWvZ9rpDWN-Vuw0GPE+_9nEkr6jdw@mail.gmail.com>
In-Reply-To: <CACGkMEuG5mDzU-UwHvrZ3TWvZ9rpDWN-Vuw0GPE+_9nEkr6jdw@mail.gmail.com>
From: Yuri Benditovich <yuri.benditovich@daynix.com>
Date: Tue, 16 Apr 2024 08:43:27 +0300
Message-ID: <CAOEp5OcsP+-wtbJcinAXE=We_52HwmpHxX93FUsAFrjVNPge_Q@mail.gmail.com>
Subject: Re: [PATCH v9 13/20] virtio-net: Return an error when vhost cannot
 enable RSS
To: Jason Wang <jasowang@redhat.com>
Cc: Akihiko Odaki <akihiko.odaki@daynix.com>,
 Dmitry Fleytman <dmitry.fleytman@gmail.com>, 
 Sriram Yagnaraman <sriram.yagnaraman@est.tech>,
 "Michael S. Tsirkin" <mst@redhat.com>, 
 Luigi Rizzo <rizzo@iet.unipi.it>, Giuseppe Lettieri <g.lettieri@iet.unipi.it>, 
 Vincenzo Maffione <v.maffione@gmail.com>,
 Andrew Melnychenko <andrew@daynix.com>, qemu-devel@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: none client-ip=2607:f8b0:4864:20::72c;
 envelope-from=yuri.benditovich@daynix.com; helo=mail-qk1-x72c.google.com
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

On Tue, Apr 16, 2024 at 7:00=E2=80=AFAM Jason Wang <jasowang@redhat.com> wr=
ote:
>
> On Mon, Apr 15, 2024 at 10:05=E2=80=AFPM Yuri Benditovich
> <yuri.benditovich@daynix.com> wrote:
> >
> > On Wed, Apr 3, 2024 at 2:11=E2=80=AFPM Akihiko Odaki <akihiko.odaki@day=
nix.com> wrote:
> > >
> > > vhost requires eBPF for RSS. When eBPF is not available, virtio-net
> > > implicitly disables RSS even if the user explicitly requests it. Retu=
rn
> > > an error instead of implicitly disabling RSS if RSS is requested but =
not
> > > available.
> > >
> > > Signed-off-by: Akihiko Odaki <akihiko.odaki@daynix.com>
> > > ---
> > >  hw/net/virtio-net.c | 97 ++++++++++++++++++++++++++-----------------=
----------
> > >  1 file changed, 48 insertions(+), 49 deletions(-)
> > >
> > > diff --git a/hw/net/virtio-net.c b/hw/net/virtio-net.c
> > > index 61b49e335dea..3d53eba88cfc 100644
> > > --- a/hw/net/virtio-net.c
> > > +++ b/hw/net/virtio-net.c
> > > @@ -793,9 +793,6 @@ static uint64_t virtio_net_get_features(VirtIODev=
ice *vdev, uint64_t features,
> > >          return features;
> > >      }
> > >
> > > -    if (!ebpf_rss_is_loaded(&n->ebpf_rss)) {
> > > -        virtio_clear_feature(&features, VIRTIO_NET_F_RSS);
> > > -    }
> > >      features =3D vhost_net_get_features(get_vhost_net(nc->peer), fea=
tures);
> > >      vdev->backend_features =3D features;
> > >
> > > @@ -3591,6 +3588,50 @@ static bool failover_hide_primary_device(Devic=
eListener *listener,
> > >      return qatomic_read(&n->failover_primary_hidden);
> > >  }
> > >
> > > +static void virtio_net_device_unrealize(DeviceState *dev)
> > > +{
> > > +    VirtIODevice *vdev =3D VIRTIO_DEVICE(dev);
> > > +    VirtIONet *n =3D VIRTIO_NET(dev);
> > > +    int i, max_queue_pairs;
> > > +
> > > +    if (virtio_has_feature(n->host_features, VIRTIO_NET_F_RSS)) {
> > > +        virtio_net_unload_ebpf(n);
> > > +    }
> > > +
> > > +    /* This will stop vhost backend if appropriate. */
> > > +    virtio_net_set_status(vdev, 0);
> > > +
> > > +    g_free(n->netclient_name);
> > > +    n->netclient_name =3D NULL;
> > > +    g_free(n->netclient_type);
> > > +    n->netclient_type =3D NULL;
> > > +
> > > +    g_free(n->mac_table.macs);
> > > +    g_free(n->vlans);
> > > +
> > > +    if (n->failover) {
> > > +        qobject_unref(n->primary_opts);
> > > +        device_listener_unregister(&n->primary_listener);
> > > +        migration_remove_notifier(&n->migration_state);
> > > +    } else {
> > > +        assert(n->primary_opts =3D=3D NULL);
> > > +    }
> > > +
> > > +    max_queue_pairs =3D n->multiqueue ? n->max_queue_pairs : 1;
> > > +    for (i =3D 0; i < max_queue_pairs; i++) {
> > > +        virtio_net_del_queue(n, i);
> > > +    }
> > > +    /* delete also control vq */
> > > +    virtio_del_queue(vdev, max_queue_pairs * 2);
> > > +    qemu_announce_timer_del(&n->announce_timer, false);
> > > +    g_free(n->vqs);
> > > +    qemu_del_nic(n->nic);
> > > +    virtio_net_rsc_cleanup(n);
> > > +    g_free(n->rss_data.indirections_table);
> > > +    net_rx_pkt_uninit(n->rx_pkt);
> > > +    virtio_cleanup(vdev);
> > > +}
> > > +
> > >  static void virtio_net_device_realize(DeviceState *dev, Error **errp=
)
> > >  {
> > >      VirtIODevice *vdev =3D VIRTIO_DEVICE(dev);
> > > @@ -3760,53 +3801,11 @@ static void virtio_net_device_realize(DeviceS=
tate *dev, Error **errp)
> > >
> > >      net_rx_pkt_init(&n->rx_pkt);
> > >
> > > -    if (virtio_has_feature(n->host_features, VIRTIO_NET_F_RSS)) {
> > > -        virtio_net_load_ebpf(n);
> > > -    }
> > > -}
> > > -
> > > -static void virtio_net_device_unrealize(DeviceState *dev)
> > > -{
> > > -    VirtIODevice *vdev =3D VIRTIO_DEVICE(dev);
> > > -    VirtIONet *n =3D VIRTIO_NET(dev);
> > > -    int i, max_queue_pairs;
> > > -
> > > -    if (virtio_has_feature(n->host_features, VIRTIO_NET_F_RSS)) {
> > > -        virtio_net_unload_ebpf(n);
> > > +    if (virtio_has_feature(n->host_features, VIRTIO_NET_F_RSS) &&
> > > +        !virtio_net_load_ebpf(n) && get_vhost_net(nc->peer)) {
> > > +        virtio_net_device_unrealize(dev);
> > > +        error_setg(errp, "Can't load eBPF RSS for vhost");
> > >      }
> >
> > As I already mentioned, I think this is an extremely bad idea to
> > fail to run qemu due to such a reason as .absence of one feature.
> > What I suggest is:
> > 1. Redefine rss as tri-state (off|auto|on)
> > 2. Fail to run only if rss is on and not available via ebpf
> > 3. On auto - silently drop it
>
> "Auto" might be promatic for migration compatibility which is hard to
> be used by management layers like libvirt. The reason is that there's
> no way for libvirt to know if it is supported by device or not.

In terms of migration every feature that somehow depends on the kernel
is problematic, not only RSS. Last time we added the USO feature - is
it different?
And in terms of migration "rss=3Don" is problematic the same way as "rss=3D=
auto".
Can you please show one scenario of migration where they will behave
differently? And in terms of regular experience there is a big advantage.


>
> Thanks
>
> > 4. The same with 'hash' option - it is not compatible with vhost (at
> > least at the moment)
> > 5. Reformat the patch as it is hard to review it due to replacing
> > entire procedures, i.e. one patch with replacing without changes,
> > another one - with real changes.
> > If this is hard to review only for me - please ignore that.
> >
> > > -
> > > -    /* This will stop vhost backend if appropriate. */
> > > -    virtio_net_set_status(vdev, 0);
> > > -
> > > -    g_free(n->netclient_name);
> > > -    n->netclient_name =3D NULL;
> > > -    g_free(n->netclient_type);
> > > -    n->netclient_type =3D NULL;
> > > -
> > > -    g_free(n->mac_table.macs);
> > > -    g_free(n->vlans);
> > > -
> > > -    if (n->failover) {
> > > -        qobject_unref(n->primary_opts);
> > > -        device_listener_unregister(&n->primary_listener);
> > > -        migration_remove_notifier(&n->migration_state);
> > > -    } else {
> > > -        assert(n->primary_opts =3D=3D NULL);
> > > -    }
> > > -
> > > -    max_queue_pairs =3D n->multiqueue ? n->max_queue_pairs : 1;
> > > -    for (i =3D 0; i < max_queue_pairs; i++) {
> > > -        virtio_net_del_queue(n, i);
> > > -    }
> > > -    /* delete also control vq */
> > > -    virtio_del_queue(vdev, max_queue_pairs * 2);
> > > -    qemu_announce_timer_del(&n->announce_timer, false);
> > > -    g_free(n->vqs);
> > > -    qemu_del_nic(n->nic);
> > > -    virtio_net_rsc_cleanup(n);
> > > -    g_free(n->rss_data.indirections_table);
> > > -    net_rx_pkt_uninit(n->rx_pkt);
> > > -    virtio_cleanup(vdev);
> > >  }
> > >
> > >  static void virtio_net_reset(VirtIODevice *vdev)
> > >
> > > --
> > > 2.44.0
> > >
> >
>

