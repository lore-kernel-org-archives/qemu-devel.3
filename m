Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 74942CA0EDC
	for <qemu-devel@archiver.kernel.org>; Thu, 14 Aug 2025 09:06:13 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1umTtb-0008J0-2C; Thu, 14 Aug 2025 05:05:15 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <leiyang@redhat.com>)
 id 1umTtZ-0008Ih-EU
 for qemu-devel@nongnu.org; Thu, 14 Aug 2025 05:05:13 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <leiyang@redhat.com>)
 id 1umTtU-0001eE-1y
 for qemu-devel@nongnu.org; Thu, 14 Aug 2025 05:05:13 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1755162304;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=JpLlnMPh7MVvYOIPdWX8tm/I/4YZEY+nuGC4e8hfRFM=;
 b=HcQIAWD+UHLO79lCO0gC08is8tt3JZpv/xjpTTJlNXW4Nmqs6aI+cq7FXVKc3R2jNDHrAf
 yuSzwHMrR5IcPgTRIpmvwMPUOgaWwnlfNSpyqj4KXkwbSIez06RRJXBiFDAm/hUY29VjAG
 rlNtqkkD0ItwcGSlEw/Z2H20BctQppM=
Received: from mail-ej1-f71.google.com (mail-ej1-f71.google.com
 [209.85.218.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-477-_fcLb1fLOJ-Ez9PaazXK-A-1; Thu, 14 Aug 2025 05:05:03 -0400
X-MC-Unique: _fcLb1fLOJ-Ez9PaazXK-A-1
X-Mimecast-MFC-AGG-ID: _fcLb1fLOJ-Ez9PaazXK-A_1755162302
Received: by mail-ej1-f71.google.com with SMTP id
 a640c23a62f3a-afcb7ae03ebso60471266b.3
 for <qemu-devel@nongnu.org>; Thu, 14 Aug 2025 02:05:03 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1755162302; x=1755767102;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=JpLlnMPh7MVvYOIPdWX8tm/I/4YZEY+nuGC4e8hfRFM=;
 b=TwmhEiOYJsHZxc2hW/PtwYZyTL+6C8Ioj5RdLUafCSpu2u2MGAaZanWBxicExq8J1G
 302BW7JFuRQnxIodZii5G3MJvrdDD8k3Nlpb0CNZZUgvQ0Hv1/CgjDIwhvhpwKf2KE/+
 dUkC1HioH7XxJOGDxA02sVpQzkdY73eS5hs7ksRMe792dD8/SdU+StIHoLTp5ogAdhY5
 eR1lppr4VcLfJBrVHFePYkq3L4kSzMTIQd9KDHElxOjFqtipKfnS4XhoFn4QwpwDSidF
 ehnR46NVCx4BAOdx6lIMKM9KU2Ah/6Ih8L+UNu6dgSK1xABIO99c1IUjqEVcENJu8zxE
 0qiQ==
X-Gm-Message-State: AOJu0YzWYCzZvHmj2n/DmBG95OXNgZu33ei7zs76f3rfyxUbL+Pcb4Iu
 cLNfXEH/COfrnF4eXuIe+SDu55yEHZMS1GOKo0Jm9KV85EDgx6gBo+fhWP5pfsvDnI9WGJP1zLm
 916DE5FtXp/q3cW1Tg5P++L6QI/Y0AxNBfw3FldwvoTk3YT9dwfdyiOIBRvAX7yu7uqQEHA5Qqt
 ZbKdP74FGtpb9jBBuSDVJibOvn+8E17OQ=
X-Gm-Gg: ASbGnctLNfp80RB5Til0P6to7t2VDtgug0e7cWwzdSxyiX8NmwAMWFqABcaM8L15UuK
 KLhdMs8Po/MKC1hqbaxqlmD9FVaoaWfPIK02xEJPvHbTbJgEYKFuwwscEjfgDG+B6G6WdmtbOlH
 5E3avFL85Xu0HMJ1cGOlQBQg==
X-Received: by 2002:a17:907:2d2c:b0:af9:5260:9ed6 with SMTP id
 a640c23a62f3a-afcb93988cemr226051266b.3.1755162301888; 
 Thu, 14 Aug 2025 02:05:01 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFnXYhqxX0Q5DLHiH99TlMYyIsenI7Ataf9liRzxnDghtsomSOFAMb+AbF23CrBcTkPoiNA3OyZGWon+U/jjwY=
X-Received: by 2002:a17:907:2d2c:b0:af9:5260:9ed6 with SMTP id
 a640c23a62f3a-afcb93988cemr226045866b.3.1755162301315; Thu, 14 Aug 2025
 02:05:01 -0700 (PDT)
MIME-Version: 1.0
References: <9d71108d7de139dd4f4e6efe6837cabb32bf5616.1755078918.git.pabeni@redhat.com>
In-Reply-To: <9d71108d7de139dd4f4e6efe6837cabb32bf5616.1755078918.git.pabeni@redhat.com>
From: Lei Yang <leiyang@redhat.com>
Date: Thu, 14 Aug 2025 17:04:23 +0800
X-Gm-Features: Ac12FXzj0bHKqj4lxkyszRnDkMzgRlEFTk9bBMhixqRVYAWJbvn88pUgRdBLuls
Message-ID: <CAPpAL=wTXUoR_YMETsGEWDi764e7OFXi7v_ehpT4FgiAN1gpNQ@mail.gmail.com>
Subject: Re: [PATCH v5] net: bundle all offloads in a single struct
To: Paolo Abeni <pabeni@redhat.com>
Cc: qemu-devel@nongnu.org, Dmitry Fleytman <dmitry.fleytman@gmail.com>, 
 Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>, Jason Wang <jasowang@redhat.com>,
 Sriram Yagnaraman <sriram.yagnaraman@ericsson.com>,
 "Michael S. Tsirkin" <mst@redhat.com>, 
 Luigi Rizzo <rizzo@iet.unipi.it>, Giuseppe Lettieri <g.lettieri@iet.unipi.it>, 
 Vincenzo Maffione <v.maffione@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=170.10.129.124; envelope-from=leiyang@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
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

Tested this patch with virtio-net regression tests, everything works fine.

Tested-by: Lei Yang <leiyang@redhat.com>

On Wed, Aug 13, 2025 at 6:28=E2=80=AFPM Paolo Abeni <pabeni@redhat.com> wro=
te:
>
> The set_offload() argument list is already pretty long and
> we are going to introduce soon a bunch of additional offloads.
>
> Replace the offload arguments with a single struct and update
> all the relevant call-sites.
>
> No functional changes intended.
>
> Signed-off-by: Paolo Abeni <pabeni@redhat.com>
> ---
> v4 -> v5:
>   - sent as standalone patch
>
> v3 -> v4:
>   - style fix for NetOffloads init
>
> v1 -> v2:
>   - drop unneeded 'struct' keywords
>   - moved to series start
> ---
>  hw/net/e1000e_core.c |  5 +++--
>  hw/net/igb_core.c    |  5 +++--
>  hw/net/virtio-net.c  | 19 +++++++++++--------
>  hw/net/vmxnet3.c     | 13 +++++--------
>  include/net/net.h    | 15 ++++++++++++---
>  net/net.c            |  5 ++---
>  net/netmap.c         |  3 +--
>  net/tap-bsd.c        |  3 +--
>  net/tap-linux.c      | 21 ++++++++++++---------
>  net/tap-solaris.c    |  4 ++--
>  net/tap-stub.c       |  3 +--
>  net/tap.c            |  8 ++++----
>  net/tap_int.h        |  4 ++--
>  13 files changed, 59 insertions(+), 49 deletions(-)
>
> diff --git a/hw/net/e1000e_core.c b/hw/net/e1000e_core.c
> index 2413858790..abc626a969 100644
> --- a/hw/net/e1000e_core.c
> +++ b/hw/net/e1000e_core.c
> @@ -2827,8 +2827,9 @@ e1000e_update_rx_offloads(E1000ECore *core)
>      trace_e1000e_rx_set_cso(cso_state);
>
>      if (core->has_vnet) {
> -        qemu_set_offload(qemu_get_queue(core->owner_nic)->peer,
> -                         cso_state, 0, 0, 0, 0, 0, 0);
> +        NetOffloads ol =3D { .csum =3D cso_state };
> +
> +        qemu_set_offload(qemu_get_queue(core->owner_nic)->peer, &ol);
>      }
>  }
>
> diff --git a/hw/net/igb_core.c b/hw/net/igb_core.c
> index 39e3ce1c8f..45d8fd795b 100644
> --- a/hw/net/igb_core.c
> +++ b/hw/net/igb_core.c
> @@ -3058,8 +3058,9 @@ igb_update_rx_offloads(IGBCore *core)
>      trace_e1000e_rx_set_cso(cso_state);
>
>      if (core->has_vnet) {
> -        qemu_set_offload(qemu_get_queue(core->owner_nic)->peer,
> -                         cso_state, 0, 0, 0, 0, 0, 0);
> +        NetOffloads ol =3D {.csum =3D cso_state };
> +
> +        qemu_set_offload(qemu_get_queue(core->owner_nic)->peer, &ol);
>      }
>  }
>
> diff --git a/hw/net/virtio-net.c b/hw/net/virtio-net.c
> index 6b5b5dace3..b86ba1fd27 100644
> --- a/hw/net/virtio-net.c
> +++ b/hw/net/virtio-net.c
> @@ -773,14 +773,17 @@ static uint64_t virtio_net_bad_features(VirtIODevic=
e *vdev)
>
>  static void virtio_net_apply_guest_offloads(VirtIONet *n)
>  {
> -    qemu_set_offload(qemu_get_queue(n->nic)->peer,
> -            !!(n->curr_guest_offloads & (1ULL << VIRTIO_NET_F_GUEST_CSUM=
)),
> -            !!(n->curr_guest_offloads & (1ULL << VIRTIO_NET_F_GUEST_TSO4=
)),
> -            !!(n->curr_guest_offloads & (1ULL << VIRTIO_NET_F_GUEST_TSO6=
)),
> -            !!(n->curr_guest_offloads & (1ULL << VIRTIO_NET_F_GUEST_ECN)=
),
> -            !!(n->curr_guest_offloads & (1ULL << VIRTIO_NET_F_GUEST_UFO)=
),
> -            !!(n->curr_guest_offloads & (1ULL << VIRTIO_NET_F_GUEST_USO4=
)),
> -            !!(n->curr_guest_offloads & (1ULL << VIRTIO_NET_F_GUEST_USO6=
)));
> +    NetOffloads ol =3D {
> +       .csum =3D !!(n->curr_guest_offloads & (1ULL << VIRTIO_NET_F_GUEST=
_CSUM)),
> +       .tso4 =3D !!(n->curr_guest_offloads & (1ULL << VIRTIO_NET_F_GUEST=
_TSO4)),
> +       .tso6 =3D !!(n->curr_guest_offloads & (1ULL << VIRTIO_NET_F_GUEST=
_TSO6)),
> +       .ecn  =3D !!(n->curr_guest_offloads & (1ULL << VIRTIO_NET_F_GUEST=
_ECN)),
> +       .ufo  =3D !!(n->curr_guest_offloads & (1ULL << VIRTIO_NET_F_GUEST=
_UFO)),
> +       .uso4 =3D !!(n->curr_guest_offloads & (1ULL << VIRTIO_NET_F_GUEST=
_USO4)),
> +       .uso6 =3D !!(n->curr_guest_offloads & (1ULL << VIRTIO_NET_F_GUEST=
_USO6)),
> +    };
> +
> +    qemu_set_offload(qemu_get_queue(n->nic)->peer, &ol);
>  }
>
>  static uint64_t virtio_net_guest_offloads_by_features(uint64_t features)
> diff --git a/hw/net/vmxnet3.c b/hw/net/vmxnet3.c
> index af73aa8ef2..03732375a7 100644
> --- a/hw/net/vmxnet3.c
> +++ b/hw/net/vmxnet3.c
> @@ -1322,14 +1322,11 @@ static void vmxnet3_update_features(VMXNET3State =
*s)
>                s->lro_supported, rxcso_supported,
>                s->rx_vlan_stripping);
>      if (s->peer_has_vhdr) {
> -        qemu_set_offload(qemu_get_queue(s->nic)->peer,
> -                         rxcso_supported,
> -                         s->lro_supported,
> -                         s->lro_supported,
> -                         0,
> -                         0,
> -                         0,
> -                         0);
> +        NetOffloads ol =3D { .csum =3D rxcso_supported,
> +                           .tso4 =3D s->lro_supported,
> +                           .tso6 =3D s->lro_supported };
> +
> +        qemu_set_offload(qemu_get_queue(s->nic)->peer, &ol);
>      }
>  }
>
> diff --git a/include/net/net.h b/include/net/net.h
> index 84ee18e0f9..48ba333d02 100644
> --- a/include/net/net.h
> +++ b/include/net/net.h
> @@ -35,6 +35,16 @@ typedef struct NICConf {
>      int32_t bootindex;
>  } NICConf;
>
> +typedef struct NetOffloads {
> +    bool csum;
> +    bool tso4;
> +    bool tso6;
> +    bool ecn;
> +    bool ufo;
> +    bool uso4;
> +    bool uso6;
> +} NetOffloads;
> +
>  #define DEFINE_NIC_PROPERTIES(_state, _conf)                            =
\
>      DEFINE_PROP_MACADDR("mac",   _state, _conf.macaddr),                =
\
>      DEFINE_PROP_NETDEV("netdev", _state, _conf.peers)
> @@ -57,7 +67,7 @@ typedef bool (HasUfo)(NetClientState *);
>  typedef bool (HasUso)(NetClientState *);
>  typedef bool (HasVnetHdr)(NetClientState *);
>  typedef bool (HasVnetHdrLen)(NetClientState *, int);
> -typedef void (SetOffload)(NetClientState *, int, int, int, int, int, int=
, int);
> +typedef void (SetOffload)(NetClientState *, const NetOffloads *);
>  typedef int (GetVnetHdrLen)(NetClientState *);
>  typedef void (SetVnetHdrLen)(NetClientState *, int);
>  typedef bool (GetVnetHashSupportedTypes)(NetClientState *, uint32_t *);
> @@ -189,8 +199,7 @@ bool qemu_has_ufo(NetClientState *nc);
>  bool qemu_has_uso(NetClientState *nc);
>  bool qemu_has_vnet_hdr(NetClientState *nc);
>  bool qemu_has_vnet_hdr_len(NetClientState *nc, int len);
> -void qemu_set_offload(NetClientState *nc, int csum, int tso4, int tso6,
> -                      int ecn, int ufo, int uso4, int uso6);
> +void qemu_set_offload(NetClientState *nc, const NetOffloads *ol);
>  int qemu_get_vnet_hdr_len(NetClientState *nc);
>  void qemu_set_vnet_hdr_len(NetClientState *nc, int len);
>  bool qemu_get_vnet_hash_supported_types(NetClientState *nc, uint32_t *ty=
pes);
> diff --git a/net/net.c b/net/net.c
> index da275db86e..63872b6855 100644
> --- a/net/net.c
> +++ b/net/net.c
> @@ -540,14 +540,13 @@ bool qemu_has_vnet_hdr_len(NetClientState *nc, int =
len)
>      return nc->info->has_vnet_hdr_len(nc, len);
>  }
>
> -void qemu_set_offload(NetClientState *nc, int csum, int tso4, int tso6,
> -                          int ecn, int ufo, int uso4, int uso6)
> +void qemu_set_offload(NetClientState *nc, const NetOffloads *ol)
>  {
>      if (!nc || !nc->info->set_offload) {
>          return;
>      }
>
> -    nc->info->set_offload(nc, csum, tso4, tso6, ecn, ufo, uso4, uso6);
> +    nc->info->set_offload(nc, ol);
>  }
>
>  int qemu_get_vnet_hdr_len(NetClientState *nc)
> diff --git a/net/netmap.c b/net/netmap.c
> index 297510e190..6cd8f2bdc5 100644
> --- a/net/netmap.c
> +++ b/net/netmap.c
> @@ -366,8 +366,7 @@ static void netmap_set_vnet_hdr_len(NetClientState *n=
c, int len)
>      }
>  }
>
> -static void netmap_set_offload(NetClientState *nc, int csum, int tso4, i=
nt tso6,
> -                               int ecn, int ufo, int uso4, int uso6)
> +static void netmap_set_offload(NetClientState *nc, const NetOffloads *ol=
)
>  {
>      NetmapState *s =3D DO_UPCAST(NetmapState, nc, nc);
>
> diff --git a/net/tap-bsd.c b/net/tap-bsd.c
> index b4c84441ba..86b6edee94 100644
> --- a/net/tap-bsd.c
> +++ b/net/tap-bsd.c
> @@ -231,8 +231,7 @@ int tap_fd_set_vnet_be(int fd, int is_be)
>      return -EINVAL;
>  }
>
> -void tap_fd_set_offload(int fd, int csum, int tso4,
> -                        int tso6, int ecn, int ufo, int uso4, int uso6)
> +void tap_fd_set_offload(int fd, const NetOffloads *ol)
>  {
>  }
>
> diff --git a/net/tap-linux.c b/net/tap-linux.c
> index 22ec2f45d2..a1c58f74f5 100644
> --- a/net/tap-linux.c
> +++ b/net/tap-linux.c
> @@ -239,8 +239,7 @@ int tap_fd_set_vnet_be(int fd, int is_be)
>      abort();
>  }
>
> -void tap_fd_set_offload(int fd, int csum, int tso4,
> -                        int tso6, int ecn, int ufo, int uso4, int uso6)
> +void tap_fd_set_offload(int fd, const NetOffloads *ol)
>  {
>      unsigned int offload =3D 0;
>
> @@ -249,20 +248,24 @@ void tap_fd_set_offload(int fd, int csum, int tso4,
>          return;
>      }
>
> -    if (csum) {
> +    if (ol->csum) {
>          offload |=3D TUN_F_CSUM;
> -        if (tso4)
> +        if (ol->tso4) {
>              offload |=3D TUN_F_TSO4;
> -        if (tso6)
> +        }
> +        if (ol->tso6) {
>              offload |=3D TUN_F_TSO6;
> -        if ((tso4 || tso6) && ecn)
> +        }
> +        if ((ol->tso4 || ol->tso6) && ol->ecn) {
>              offload |=3D TUN_F_TSO_ECN;
> -        if (ufo)
> +        }
> +        if (ol->ufo) {
>              offload |=3D TUN_F_UFO;
> -        if (uso4) {
> +        }
> +        if (ol->uso4) {
>              offload |=3D TUN_F_USO4;
>          }
> -        if (uso6) {
> +        if (ol->uso6) {
>              offload |=3D TUN_F_USO6;
>          }
>      }
> diff --git a/net/tap-solaris.c b/net/tap-solaris.c
> index 51b7830bef..833c066bee 100644
> --- a/net/tap-solaris.c
> +++ b/net/tap-solaris.c
> @@ -27,6 +27,7 @@
>  #include "tap_int.h"
>  #include "qemu/ctype.h"
>  #include "qemu/cutils.h"
> +#include "net/net.h"
>
>  #include <sys/ethernet.h>
>  #include <sys/sockio.h>
> @@ -235,8 +236,7 @@ int tap_fd_set_vnet_be(int fd, int is_be)
>      return -EINVAL;
>  }
>
> -void tap_fd_set_offload(int fd, int csum, int tso4,
> -                        int tso6, int ecn, int ufo, int uso4, int uso6)
> +void tap_fd_set_offload(int fd, const NetOffloads *ol)
>  {
>  }
>
> diff --git a/net/tap-stub.c b/net/tap-stub.c
> index 38673434cb..67d14ad4d5 100644
> --- a/net/tap-stub.c
> +++ b/net/tap-stub.c
> @@ -66,8 +66,7 @@ int tap_fd_set_vnet_be(int fd, int is_be)
>      return -EINVAL;
>  }
>
> -void tap_fd_set_offload(int fd, int csum, int tso4,
> -                        int tso6, int ecn, int ufo, int uso4, int uso6)
> +void tap_fd_set_offload(int fd, const NetOffloads *ol)
>  {
>  }
>
> diff --git a/net/tap.c b/net/tap.c
> index f7df702f97..72046a43aa 100644
> --- a/net/tap.c
> +++ b/net/tap.c
> @@ -285,15 +285,14 @@ static int tap_set_vnet_be(NetClientState *nc, bool=
 is_be)
>      return tap_fd_set_vnet_be(s->fd, is_be);
>  }
>
> -static void tap_set_offload(NetClientState *nc, int csum, int tso4,
> -                     int tso6, int ecn, int ufo, int uso4, int uso6)
> +static void tap_set_offload(NetClientState *nc, const NetOffloads *ol)
>  {
>      TAPState *s =3D DO_UPCAST(TAPState, nc, nc);
>      if (s->fd < 0) {
>          return;
>      }
>
> -    tap_fd_set_offload(s->fd, csum, tso4, tso6, ecn, ufo, uso4, uso6);
> +    tap_fd_set_offload(s->fd, ol);
>  }
>
>  static void tap_exit_notify(Notifier *notifier, void *data)
> @@ -391,6 +390,7 @@ static TAPState *net_tap_fd_init(NetClientState *peer=
,
>                                   int fd,
>                                   int vnet_hdr)
>  {
> +    NetOffloads ol =3D {};
>      NetClientState *nc;
>      TAPState *s;
>
> @@ -404,7 +404,7 @@ static TAPState *net_tap_fd_init(NetClientState *peer=
,
>      s->has_ufo =3D tap_probe_has_ufo(s->fd);
>      s->has_uso =3D tap_probe_has_uso(s->fd);
>      s->enabled =3D true;
> -    tap_set_offload(&s->nc, 0, 0, 0, 0, 0, 0, 0);
> +    tap_set_offload(&s->nc, &ol);
>      /*
>       * Make sure host header length is set correctly in tap:
>       * it might have been modified by another instance of qemu.
> diff --git a/net/tap_int.h b/net/tap_int.h
> index 8857ff299d..f8bbe1cb0c 100644
> --- a/net/tap_int.h
> +++ b/net/tap_int.h
> @@ -27,6 +27,7 @@
>  #define NET_TAP_INT_H
>
>  #include "qapi/qapi-types-net.h"
> +#include "net/net.h"
>
>  int tap_open(char *ifname, int ifname_size, int *vnet_hdr,
>               int vnet_hdr_required, int mq_required, Error **errp);
> @@ -37,8 +38,7 @@ void tap_set_sndbuf(int fd, const NetdevTapOptions *tap=
, Error **errp);
>  int tap_probe_vnet_hdr(int fd, Error **errp);
>  int tap_probe_has_ufo(int fd);
>  int tap_probe_has_uso(int fd);
> -void tap_fd_set_offload(int fd, int csum, int tso4, int tso6, int ecn, i=
nt ufo,
> -                        int uso4, int uso6);
> +void tap_fd_set_offload(int fd, const NetOffloads *ol);
>  void tap_fd_set_vnet_hdr_len(int fd, int len);
>  int tap_fd_set_vnet_le(int fd, int vnet_is_le);
>  int tap_fd_set_vnet_be(int fd, int vnet_is_be);
> --
> 2.50.1
>
>


