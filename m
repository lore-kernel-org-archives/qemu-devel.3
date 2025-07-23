Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 51FC3C83F25
	for <qemu-devel@archiver.kernel.org>; Wed, 23 Jul 2025 05:48:40 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ueSKO-0006WR-SH; Wed, 23 Jul 2025 01:47:45 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jasowang@redhat.com>)
 id 1ueSKM-0006Rr-6D
 for qemu-devel@nongnu.org; Wed, 23 Jul 2025 01:47:42 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jasowang@redhat.com>)
 id 1ueSKI-0000dM-By
 for qemu-devel@nongnu.org; Wed, 23 Jul 2025 01:47:41 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1753249655;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=7XPlWz2nidpU4R9aD9ci9hHbWVZ2vxTRoTM4EsN6oqw=;
 b=Pt48+kBcbNaZs9MeL4BQE3J86Da0TSDveOJDKFQsgbEskTP3/rHrtBGfr92xMsj+GRiuo0
 Vpazj4VMdGSbFyAn+U26FwCPIxFd4kp12/2DyFOmwdu+Ld5rpIWsmwWRGqiLThbCQMAAt+
 lnTyuLbqMppBOGRk000xfUxexaLg21Q=
Received: from mail-pj1-f71.google.com (mail-pj1-f71.google.com
 [209.85.216.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-685-7d76aY-nPHK2XZVyhE3drg-1; Wed, 23 Jul 2025 01:47:33 -0400
X-MC-Unique: 7d76aY-nPHK2XZVyhE3drg-1
X-Mimecast-MFC-AGG-ID: 7d76aY-nPHK2XZVyhE3drg_1753249652
Received: by mail-pj1-f71.google.com with SMTP id
 98e67ed59e1d1-313fb0ec33bso6783361a91.2
 for <qemu-devel@nongnu.org>; Tue, 22 Jul 2025 22:47:33 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1753249652; x=1753854452;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=7XPlWz2nidpU4R9aD9ci9hHbWVZ2vxTRoTM4EsN6oqw=;
 b=KFB8ggr2IjH7gYS+AXoKoZ3aE9yYuDIEnGx1+clfKZfiIAipQynZ9YZVgVNWeGEcPj
 iuQ02LumNwgUK6wV0IIJnsPismTsxW/uJmQqN9rBJtbM9bMqjZdx2PUvnLJ9CYD7XOhQ
 ssyIm7x4/FqSjV1P21GaVBySy2e/Jyi5G03wUN0TiMh6gPeMAQoAtmcFmxfH3Gr7yvty
 nm7GqwuOEPNfjxyjLuP+d1R08yQAFuBqYnlHqLHA+v2foFU8eapy1TCVjIvhSELv7to7
 BEaZ3GjLlAfRBDDyuDTZHmKWI1N7wcsuUTHMK5SnQyTydj+PXQPvJPRjYSO3kldUq72e
 Nyzw==
X-Gm-Message-State: AOJu0YwqM26GeeZkP0aB7hIdTnrEqzwURP2uG6Dafe9vMp1cJhu+kpt3
 dDQVFCteco2X7glJZR/mbdd22+KPI+3tPUD2hkCN7sonOeCAj340e7t9b1asHjMH526bGJXIZqI
 VIc/AwRfiRQfCTaImg7YQo0e6uhmQPNm3aMq06681m/1MCO/2S1GjDviCkducRolraWVlxe4teA
 ghS8PkL7ldVf7RI+wvMKuM7cbzpwnwU8Y=
X-Gm-Gg: ASbGnctOSMqLNK0+mT1w4UuQhmJo12vXTNymVYffPSTcmHxTY004z3T74gW1i9djet5
 EA3wGoZImWwzFAS7//lesnNwak1PFUN6svt2tJAQUxaJJ+78EYiI4Q9y4GfMkgC4kCyesUEaQIL
 m+yQfeIUlOX6V7ZPK6ssc=
X-Received: by 2002:a17:90b:3e89:b0:312:1dc9:9f67 with SMTP id
 98e67ed59e1d1-31e506ee417mr2760787a91.2.1753249652169; 
 Tue, 22 Jul 2025 22:47:32 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHU4qSbF8n7Om8fRQwOHgwCNrtn899pVVvYSeRTc4pOgGT7wx3/ySvgpcLm/VeIAuE86VSqmQmWOfI+yrYsqqk=
X-Received: by 2002:a17:90b:3e89:b0:312:1dc9:9f67 with SMTP id
 98e67ed59e1d1-31e506ee417mr2760752a91.2.1753249651715; Tue, 22 Jul 2025
 22:47:31 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1752828082.git.pabeni@redhat.com>
 <6ec36a1cc2497f827b9e024acc6adb2515dd9335.1752828082.git.pabeni@redhat.com>
 <CACGkMEunxuooL+z=Oz1FsNabNuh=QwfMbzG0k0S+avL3LxEV7w@mail.gmail.com>
 <b865db9f-725f-4ca7-9101-caf4b3caa430@redhat.com>
In-Reply-To: <b865db9f-725f-4ca7-9101-caf4b3caa430@redhat.com>
From: Jason Wang <jasowang@redhat.com>
Date: Wed, 23 Jul 2025 13:47:20 +0800
X-Gm-Features: Ac12FXxKQ8ZdfFc6muzMeGE7v5NrLxnvnO6X-MxZC4ZkUSBRcQcg8hW9mlZU-CY
Message-ID: <CACGkMEv4yh8H9eKcRAr59mxYNmUuGOxzwf8Xae1h8g2r4gmEhQ@mail.gmail.com>
Subject: Re: [PATCH RFC v3 12/13] net: implement tunnel probing
To: Paolo Abeni <pabeni@redhat.com>
Cc: qemu-devel@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>, 
 Dmitry Fleytman <dmitry.fleytman@gmail.com>,
 Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>, 
 Sriram Yagnaraman <sriram.yagnaraman@ericsson.com>,
 "Michael S. Tsirkin" <mst@redhat.com>, 
 Stefano Garzarella <sgarzare@redhat.com>, Cornelia Huck <cohuck@redhat.com>,
 Luigi Rizzo <lrizzo@google.com>, 
 Giuseppe Lettieri <g.lettieri@iet.unipi.it>,
 Vincenzo Maffione <v.maffione@gmail.com>, 
 Eric Blake <eblake@redhat.com>, Markus Armbruster <armbru@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=170.10.129.124; envelope-from=jasowang@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -26
X-Spam_score: -2.7
X-Spam_bar: --
X-Spam_report: (-2.7 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.633,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

On Tue, Jul 22, 2025 at 3:33=E2=80=AFPM Paolo Abeni <pabeni@redhat.com> wro=
te:
>
> On 7/22/25 5:50 AM, Jason Wang wrote:
> > On Fri, Jul 18, 2025 at 4:54=E2=80=AFPM Paolo Abeni <pabeni@redhat.com>=
 wrote:
> >> Tap devices support GSO over UDP tunnel offload. Probe for such
> >> feature in a similar manner to other offloads.
> >>
> >> GSO over UDP tunnel needs to be enabled in addition to a "plain"
> >> offload (TSO or USO).
> >>
> >> No need to check separately for the outer header checksum offload:
> >> the kernel is going to support both of them or none.
> >>
> >> Signed-off-by: Paolo Abeni <pabeni@redhat.com>
> >> ---
> >> v2 -> v3:
> >>   - use bool type for tap_probe_has_tunnel()
> >>   - rebased on top of 2deec9ab7d ("virtio-net: Move
> >>         virtio_net_get_features() down")
> >>   - _array -> _ex
> >>
> >> v1 -> v2:
> >>   - peer_has_tunnel return a bool
> >>   - move TUN_F definition in net/tun-linux.h
> >> ---
> >>  hw/net/virtio-net.c | 37 +++++++++++++++++++++++++++++++++++++
> >>  include/net/net.h   |  3 +++
> >>  net/net.c           |  9 +++++++++
> >>  net/tap-bsd.c       |  5 +++++
> >>  net/tap-linux.c     | 11 +++++++++++
> >>  net/tap-linux.h     |  9 +++++++++
> >>  net/tap-solaris.c   |  5 +++++
> >>  net/tap-stub.c      |  5 +++++
> >>  net/tap.c           | 11 +++++++++++
> >>  net/tap_int.h       |  1 +
> >>  10 files changed, 96 insertions(+)
> >>
> >> diff --git a/hw/net/virtio-net.c b/hw/net/virtio-net.c
> >> index 53413ec4d5..70c85f7f77 100644
> >> --- a/hw/net/virtio-net.c
> >> +++ b/hw/net/virtio-net.c
> >> @@ -649,6 +649,15 @@ static int peer_has_uso(VirtIONet *n)
> >>      return qemu_has_uso(qemu_get_queue(n->nic)->peer);
> >>  }
> >>
> >> +static bool peer_has_tunnel(VirtIONet *n)
> >
> > Nit: it looks better to use peer_has_udp_gso_tunnel().
> >
> >> +{
> >> +    if (!peer_has_vnet_hdr(n)) {
> >> +        return false;
> >> +    }
> >> +
> >> +    return qemu_has_tunnel(qemu_get_queue(n->nic)->peer);
> >> +}
> >> +
> >>  static void virtio_net_set_mrg_rx_bufs(VirtIONet *n, int mergeable_rx=
_bufs,
> >>                                         int version_1, int hash_report=
)
> >>  {
> >> @@ -3070,6 +3079,13 @@ static void virtio_net_get_features(VirtIODevic=
e *vdev, uint64_t *features,
> >>          virtio_clear_feature_ex(features, VIRTIO_NET_F_GUEST_USO4);
> >>          virtio_clear_feature_ex(features, VIRTIO_NET_F_GUEST_USO6);
> >>
> >> +        virtio_clear_feature_ex(features, VIRTIO_NET_F_GUEST_UDP_TUNN=
EL_GSO);
> >> +        virtio_clear_feature_ex(features, VIRTIO_NET_F_HOST_UDP_TUNNE=
L_GSO);
> >> +        virtio_clear_feature_ex(features,
> >> +                                VIRTIO_NET_F_GUEST_UDP_TUNNEL_GSO_CSU=
M);
> >> +        virtio_clear_feature_ex(features,
> >> +                                VIRTIO_NET_F_HOST_UDP_TUNNEL_GSO_CSUM=
);
> >> +
> >>          virtio_clear_feature_ex(features, VIRTIO_NET_F_HASH_REPORT);
> >>      }
> >>
> >> @@ -3083,6 +3099,15 @@ static void virtio_net_get_features(VirtIODevic=
e *vdev, uint64_t *features,
> >>          virtio_clear_feature_ex(features, VIRTIO_NET_F_GUEST_USO6);
> >>      }
> >>
> >> +    if (!peer_has_tunnel(n)) {
> >> +        virtio_clear_feature_ex(features, VIRTIO_NET_F_GUEST_UDP_TUNN=
EL_GSO);
> >> +        virtio_clear_feature_ex(features, VIRTIO_NET_F_HOST_UDP_TUNNE=
L_GSO);
> >> +        virtio_clear_feature_ex(features,
> >> +                                VIRTIO_NET_F_GUEST_UDP_TUNNEL_GSO_CSU=
M);
> >> +        virtio_clear_feature_ex(features,
> >> +                                VIRTIO_NET_F_HOST_UDP_TUNNEL_GSO_CSUM=
);
> >> +    }
> >> +
> >>      if (!get_vhost_net(nc->peer)) {
> >>          if (!use_own_hash) {
> >>              virtio_clear_feature_ex(features, VIRTIO_NET_F_HASH_REPOR=
T);
> >> @@ -4137,6 +4162,10 @@ static const VMStateDescription vmstate_virtio_=
net =3D {
> >>      .dev_unplug_pending =3D dev_unplug_pending,
> >>  };
> >>
> >> +#define DEFINE_PROP_FEATURE(_name, _state, _field, _bit, _defval)   \
> >> +    DEFINE_PROP_BIT64(_name, _state, _field[VIRTIO_DWORD(_bit)],    \
> >> +                      (_bit) % 64, _defval)
> >> +
> >>  static const Property virtio_net_properties[] =3D {
> >>      DEFINE_PROP_BIT64("csum", VirtIONet, host_features,
> >>                      VIRTIO_NET_F_CSUM, true),
> >> @@ -4245,6 +4274,14 @@ static const Property virtio_net_properties[] =
=3D {
> >>                                    rss_data.specified_hash_types,
> >>                                    VIRTIO_NET_HASH_REPORT_UDPv6_EX - 1=
,
> >>                                    ON_OFF_AUTO_AUTO),
> >> +    DEFINE_PROP_FEATURE("host_tunnel", VirtIONet, host_features_ex,
> >> +                        VIRTIO_NET_F_HOST_UDP_TUNNEL_GSO, true),
> >> +    DEFINE_PROP_FEATURE("host_tunnel_csum", VirtIONet, host_features_=
ex,
> >> +                        VIRTIO_NET_F_HOST_UDP_TUNNEL_GSO_CSUM, true),
> >> +    DEFINE_PROP_FEATURE("guest_tunnel", VirtIONet, host_features_ex,
> >> +                        VIRTIO_NET_F_GUEST_UDP_TUNNEL_GSO, true),
> >> +    DEFINE_PROP_FEATURE("guest_tunnel_csum", VirtIONet, host_features=
_ex,
> >> +                        VIRTIO_NET_F_GUEST_UDP_TUNNEL_GSO_CSUM, true)=
,
> >>  };
> >
> > Need compatibility work like:
> >
> > d83f46d189 ("virtio-pci: compat page aligned ATS")
>
> If I read correctly the only missing pieces are the hw_compat_10_1
> entries, am I correct?
>
> If so, as mentioned here:
>
> https://lists.gnu.org/archive/html/qemu-devel/2025-07/msg05032.html

Exactly.

>
> I'll add the needed entries after that the hw_compat_10_1 will be created=
.
>
> Thanks,
>
> Paolo

Thanks

>


