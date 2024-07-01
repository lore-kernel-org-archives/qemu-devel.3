Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0ABC4C2BD09
	for <qemu-devel@archiver.kernel.org>; Mon,  1 Jul 2024 23:46:36 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sOQie-0000U4-FC; Mon, 01 Jul 2024 19:46:00 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <east.moutain.yang@gmail.com>)
 id 1sOQiV-0000Ox-NA; Mon, 01 Jul 2024 19:45:54 -0400
Received: from mail-wr1-x42a.google.com ([2a00:1450:4864:20::42a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <east.moutain.yang@gmail.com>)
 id 1sOQiS-0003YP-6f; Mon, 01 Jul 2024 19:45:51 -0400
Received: by mail-wr1-x42a.google.com with SMTP id
 ffacd0b85a97d-35f06861ae6so2135354f8f.2; 
 Mon, 01 Jul 2024 16:45:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1719877543; x=1720482343; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=BQ2OitxSVplLZMIRK7pWKaMDOGNLABztVrQyc8FneMM=;
 b=Tg8vRuyLG1wxNgdBYRj0ZIZsPsLTBjvSYkUGRcOsh7eZ4g4m5PKl5cvyAI+v4E8Vws
 QbCOgYHvjXQ0cuuu5KpiUVwzC7l2yYU3cAcActsmGAUx2PD0Xnmhlj9vV1+REUJ29w2Y
 yhvAI4lxNKuvQLUzh5x64ejJ9QMqz//bLknI3hGEBW9yosBr2kwGHxqRkHTMjaUM2cuO
 nZAlCvwz7afYIYrFp7WnfIS5BurPuAFjuamxmSXejz8F11zRkffs7kZhNbhFlH8GTvP0
 Y/HZoMYokfcaXIdjwVWYSztg/b+Nh3UY6nSzkOtOyVpe/nOrKhoKAYxgGNcTYcR42zcg
 QBQQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1719877543; x=1720482343;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=BQ2OitxSVplLZMIRK7pWKaMDOGNLABztVrQyc8FneMM=;
 b=vgk+IId/rw7SX2pRhCiH/Bu/V4RuBXMRlA7X/KkyF7JKnI24qxVbOPD+pFLudlC8Hi
 oYDWWORqiwToYGXZtI/x9cBq/SGxOMKEYyvs6FmUbOtbLF3oinzdSam40l45SKH1LqB8
 S3MykI917upJHaUk5QAoj9H8h8hyRzFNo8PqVx1ZvLcN6l+WeFeTtL35tY7sgNTP6HsV
 oUHorP4wQHzgagwLt0aNzOKRTE8jSu5Wvm7Wc5WETJkodEXSqML1UvosPvJAZ997BTX6
 cqrE5ioV8gRWHKv5UC7ldsMDEHhGHU2Cw1ZOgC6NaQawk1K5bPhVG6Vx6vkbJOJuLnSV
 MQug==
X-Forwarded-Encrypted: i=1;
 AJvYcCV9kEmZbl2uD088NhUqM2zVejtz1NJ2wW/cRUjRnPgSscJbNIaSZbsamOaDH+c7cbjT4YCHhpDtsLnmWOLs6ncqqRK0byNn
X-Gm-Message-State: AOJu0YyPATHr8ruytrDikSRBSqAbkwbNUXag02bRSJuoLalqJq5SvAcE
 Ln4nj3fyVbCxGd8gqF2HGgNds1eVyLqv+3CnKMGwGAlJWE5kXErZQr2MnYylEC3o7znjee6BvTt
 70Cixr6lboKKw9nVYnosnqb8O8WY=
X-Google-Smtp-Source: AGHT+IEAXIO7wqifplMxAxIFeJXY5bn7jYM1Eyt3PEMjXlceXIAKwopH5QJtnIyY2XF7472U7I7nvA7m8Axs04YM+OE=
X-Received: by 2002:a05:6000:1fab:b0:367:4e05:bb7b with SMTP id
 ffacd0b85a97d-36775721674mr5270634f8f.53.1719877542927; Mon, 01 Jul 2024
 16:45:42 -0700 (PDT)
MIME-Version: 1.0
References: <20240701140017.49223-1-east.moutain.yang@gmail.com>
 <20240701105110-mutt-send-email-mst@kernel.org>
 <CALrP2iW7VRLnNmyyM451OiiE3serP1ViT8wvsNCK1CadqKU09Q@mail.gmail.com>
 <20240701144507-mutt-send-email-mst@kernel.org>
In-Reply-To: <20240701144507-mutt-send-email-mst@kernel.org>
From: Yang Dongshan <east.moutain.yang@gmail.com>
Date: Tue, 2 Jul 2024 07:45:31 +0800
Message-ID: <CALrP2iVVFzrP_zy5g1Noh0Mo0OgdFSLO=Ruan_5ZHuZxt6EhFQ@mail.gmail.com>
Subject: Re: [PATCH v7] virtio-net: Fix network stall at the host side waiting
 for kick
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: qemu-devel@nongnu.org, jasowang@redhat.com, stefanha@redhat.com, 
 kwolf@redhat.com, hreitz@redhat.com, qemu-stable@nongnu.org
Content-Type: multipart/alternative; boundary="00000000000000e363061c383251"
Received-SPF: pass client-ip=2a00:1450:4864:20::42a;
 envelope-from=east.moutain.yang@gmail.com; helo=mail-wr1-x42a.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 HTML_MESSAGE=0.001, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
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

--00000000000000e363061c383251
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

> what does "changed" mean here? changed compared to what?
For a split queue, if the shadow_avail_idx synced from avail ring idx
by *vring_avail_idx(vq) last time doesn't equal the current value of avail
ring idx.*

*vq->shadow_avail_idx **!=3D vring_avail_idx(vq);*

For packed queue, the logic is similar, if vq->shadow_avail_idx

becomes available, it means the guest has added buf at the slot.

*vring_packed_desc_read(vq->vdev, &desc, &caches->desc,*

                        *vq->shadow_avail_idx, true);*

*if (is_desc_avail(desc.flags, vq-> **shadow_avail_wrap_counter))*

*    return true;*



On Tue, Jul 2, 2024 at 2:46=E2=80=AFAM Michael S. Tsirkin <mst@redhat.com> =
wrote:

> On Tue, Jul 02, 2024 at 01:18:15AM +0800, Yang Dongshan wrote:
> > > Please document what this does.
> > okay, i will.
> >
> > > So this will return false if ring has any available buffers?
> > > Equivalent to:
> > >
> > > bool virtio_queue_set_notification_and_check(VirtQueue *vq, int enabl=
e)
> > > {
> > >        virtio_queue_packed_set_notification(vq, enable);
> > >         return virtio_queue_empty(vq);
> > > }
> >
> > No, only when the shadow_avail_idx is changed shall the function return
> true,
>
>
> what does "changed" mean here? changed compared to what?
>
> > compared with the value seen by the host last time, else return false
> even if
> > there are some buffers available in the queue, as the total size of the
> > available
> > buffers in the queue can't satisfy the request.
> >
> > It maybe better to pass only one arg to the function like this:
> > bool virtio_queue_set_notification_and_check(VirtQueue *vq)
> > {
> >        virtio_queue_packed_set_notification(vq, true);
> >
> >        return shadow_avail_idx_changed()? true: false;
> > }
> >
> > Thanks Michael a lot!
> >
> > On Mon, Jul 1, 2024 at 11:05=E2=80=AFPM Michael S. Tsirkin <mst@redhat.=
com>
> wrote:
> >
> >     On Mon, Jul 01, 2024 at 10:00:17PM +0800, Wencheng Yang wrote:
> >     > From: thomas <east.moutain.yang@gmail.com>
> >     >
> >     > Patch 06b12970174 ("virtio-net: fix network stall under load")
> >     > added double-check to test whether the available buffer size
> >     > can satisfy the request or not, in case the guest has added
> >     > some buffers to the avail ring simultaneously after the first
> >     > check. It will be lucky if the available buffer size becomes
> >     > okay after the double-check, then the host can send the packet
> >     > to the guest. If the buffer size still can't satisfy the request,
> >     > even if the guest has added some buffers, viritio-net would
> >     > stall at the host side forever.
> >     >
> >     > The patch checks whether the guest has added some buffers
> >     > after last check of avail idx when the available buffers are
> >     > not sufficient, if so then recheck the available buffers
> >     > in the loop.
> >     >
> >     > The patch also reverts patch "06b12970174".
> >     >
> >     > The case below can reproduce the stall.
> >     >
> >     >                                        Guest 0
> >     >                                      +--------+
> >     >                                      | iperf  |
> >     >                     ---------------> | server |
> >     >          Host       |                +--------+
> >     >        +--------+   |                    ...
> >     >        | iperf  |----
> >     >        | client |----                  Guest n
> >     >        +--------+   |                +--------+
> >     >                     |                | iperf  |
> >     >                     ---------------> | server |
> >     >                                      +--------+
> >     >
> >     > Boot many guests from qemu with virtio network:
> >     >  qemu ... -netdev tap,id=3Dnet_x \
> >     >     -device virtio-net-pci-non-transitional,\
> >     >     iommu_platform=3Don,mac=3Dxx:xx:xx:xx:xx:xx,netdev=3Dnet_x
> >     >
> >     > Each guest acts as iperf server with commands below:
> >     >  iperf3 -s -D -i 10 -p 8001
> >     >  iperf3 -s -D -i 10 -p 8002
> >     >
> >     > The host as iperf client:
> >     >  iperf3 -c guest_IP -p 8001 -i 30 -w 256k -P 20 -t 40000
> >     >  iperf3 -c guest_IP -p 8002 -i 30 -w 256k -P 20 -t 40000
> >     >
> >     > After some time, the host loses connection to the guest,
> >     > the guest can send packet to the host, but can't receive
> >     > packet from host.
> >     >
> >     > It's more likely to happen if SWIOTLB is enabled in the guest,
> >     > allocating and freeing bounce buffer takes some CPU ticks,
> >     > copying from/to bounce buffer takes more CPU ticks, compared
> >     > with that there is no bounce buffer in the guest.
> >     > Once the rate of producing packets from the host approximates
> >     > the rate of receiveing packets in the guest, the guest would
> >     > loop in NAPI.
> >     >
> >     >          receive packets    ---
> >     >                |             |
> >     >                v             |
> >     >            free buf      virtnet_poll
> >     >                |             |
> >     >                v             |
> >     >      add buf to avail ring  ---
> >     >                |
> >     >                |  need kick the host?
> >     >                |  NAPI continues
> >     >                v
> >     >          receive packets    ---
> >     >                |             |
> >     >                v             |
> >     >            free buf      virtnet_poll
> >     >                |             |
> >     >                v             |
> >     >      add buf to avail ring  ---
> >     >                |
> >     >                v
> >     >               ...           ...
> >     >
> >     > On the other hand, the host fetches free buf from avail
> >     > ring, if the buf in the avail ring is not enough, the
> >     > host notifies the guest the event by writing the avail
> >     > idx read from avail ring to the event idx of used ring,
> >     > then the host goes to sleep, waiting for the kick signal
> >     > from the guest.
> >     >
> >     > Once the guest finds the host is waiting for kick singal
> >     > (in virtqueue_kick_prepare_split()), it kicks the host.
> >     >
> >     > The host may stall forever at the sequences below:
> >     >
> >     >          Host                        Guest
> >     >      ------------                 -----------
> >     >  fetch buf, send packet           receive packet ---
> >     >          ...                          ...         |
> >     >  fetch buf, send packet             add buf       |
> >     >          ...                        add buf   virtnet_poll
> >     >     buf not enough      avail idx-> add buf       |
> >     >     read avail idx                  add buf       |
> >     >                                     add buf      ---
> >     >                                   receive packet ---
> >     >     write event idx                   ...         |
> >     >     wait for kick                   add buf   virtnet_poll
> >     >                                       ...         |
> >     >                                                  ---
> >     >                                  no more packet, exit NAPI
> >     >
> >     > In the first loop of NAPI above, indicated in the range of
> >     > virtnet_poll above, the host is sending packets while the
> >     > guest is receiving packets and adding buffers.
> >     >  step 1: The buf is not enough, for example, a big packet
> >     >          needs 5 buf, but the available buf count is 3.
> >     >          The host read current avail idx.
> >     >  step 2: The guest adds some buf, then checks whether the
> >     >          host is waiting for kick signal, not at this time.
> >     >          The used ring is not empty, the guest continues
> >     >          the second loop of NAPI.
> >     >  step 3: The host writes the avail idx read from avail
> >     >          ring to used ring as event idx via
> >     >          virtio_queue_set_notification(q->rx_vq, 1).
> >     >  step 4: At the end of the second loop of NAPI, recheck
> >     >          whether kick is needed, as the event idx in the
> >     >          used ring written by the host is beyound the
> >     >          range of kick condition, the guest will not
> >     >          send kick signal to the host.
> >     >
> >     > Fixes: 06b12970174 ("virtio-net: fix network stall under load")
> >     > Signed-off-by: Wencheng Yang <east.moutain.yang@gmail.com>
> >     > ---
> >     >
> >     > Changelog:
> >     > v7:
> >     > - Add function virtio_queue_set_notification_and_check()
> >     > - Restore the function sequence introduce in v6
> >     >
> >     > v6:
> >     > - Take packed packed queue into cosideration
> >     > - Adjust function sequence to fix compilation issue
> >     >
> >     > v5:
> >     > - Modify return type of virtio_queue_set_notification() to
> >     >   bool to indicate whether the guest has added some buffers
> >     >   after last check of avail idx
> >     > - Loop in virtio_net_has_buffers() if the available buffers
> >     >   are not sufficient and the guest has added some buffers.
> >     > - Revert patch "06b12970174"
> >     > - Update the subject
> >     >
> >     > v4:
> >     > - Correct spelling mistake in the subject
> >     > - Describe the issue that virtio-net is blocked at host side
> >     >
> >     > v3:
> >     > - Add virtio-net tag in the subject
> >     > - Refine commit log
> >     >
> >     > v2:
> >     > - Add SOB tag at the end of the commit message
> >     > - Place Fixes tag at the end of the commit message
> >     >
> >     > v1:
> >     > - Initial patch
> >     >
> >     >  hw/net/virtio-net.c        | 19 ++++++++-----------
> >     >  hw/virtio/virtio.c         | 39
> ++++++++++++++++++++++++++++++++++++++
> >     >  include/hw/virtio/virtio.h |  1 +
> >     >  3 files changed, 48 insertions(+), 11 deletions(-)
> >     >
> >     > diff --git a/hw/net/virtio-net.c b/hw/net/virtio-net.c
> >     > index 9c7e85caea..357c651d9b 100644
> >     > --- a/hw/net/virtio-net.c
> >     > +++ b/hw/net/virtio-net.c
> >     > @@ -1642,18 +1642,15 @@ static bool
> virtio_net_can_receive(NetClientState
> >     *nc)
> >     >  static int virtio_net_has_buffers(VirtIONetQueue *q, int bufsize=
)
> >     >  {
> >     >      VirtIONet *n =3D q->n;
> >     > -    if (virtio_queue_empty(q->rx_vq) ||
> >     > -        (n->mergeable_rx_bufs &&
> >     > -         !virtqueue_avail_bytes(q->rx_vq, bufsize, 0))) {
> >     > -        virtio_queue_set_notification(q->rx_vq, 1);
> >     > -
> >     > -        /* To avoid a race condition where the guest has made so=
me
> >     buffers
> >     > -         * available after the above check but before
> notification was
> >     > -         * enabled, check for available buffers again.
> >     > -         */
> >     > -        if (virtio_queue_empty(q->rx_vq) ||
> >     > +
> >     > +    while (virtio_queue_empty(q->rx_vq) ||
> >     >              (n->mergeable_rx_bufs &&
> >     > -             !virtqueue_avail_bytes(q->rx_vq, bufsize, 0))) {
> >     > +            !virtqueue_avail_bytes(q->rx_vq, bufsize, 0))) {
> >     > +        /* guest may have made some buf, try again */
> >     > +        if (virtio_queue_set_notification_and_check(q->rx_vq, 1)=
)
> {
> >     > +            virtio_queue_set_notification(q->rx_vq, 0);
> >     > +            continue;
> >     > +        } else {
> >     >              return 0;
> >     >          }
> >     >      }
> >     > diff --git a/hw/virtio/virtio.c b/hw/virtio/virtio.c
> >     > index 893a072c9d..b165764017 100644
> >     > --- a/hw/virtio/virtio.c
> >     > +++ b/hw/virtio/virtio.c
> >     > @@ -668,6 +668,45 @@ static inline bool is_desc_avail(uint16_t
> flags,
> >     bool wrap_counter)
> >     >      return (avail !=3D used) && (avail =3D=3D wrap_counter);
> >     >  }
> >     >
> >     > +bool virtio_queue_set_notification_and_check(VirtQueue *vq, int
> enable)
> >     > +{
> >     > +    uint16_t shadow_idx;
> >     > +    VRingPackedDesc desc;
> >     > +    VRingMemoryRegionCaches *caches;
> >     > +
> >     > +    vq->notification =3D enable;
> >     > +
> >     > +    if (!vq->vring.desc) {
> >     > +        return false;
> >     > +    }
> >     > +
> >     > +    if (virtio_vdev_has_feature(vq->vdev, VIRTIO_F_RING_PACKED))=
 {
> >     > +        virtio_queue_packed_set_notification(vq, enable);
> >     > +
> >     > +        if (enable) {
> >     > +            caches =3D vring_get_region_caches(vq);
> >     > +            if (!caches) {
> >     > +                return false;
> >     > +            }
> >     > +
> >     > +            vring_packed_desc_read(vq->vdev, &desc, &caches->des=
c,
> >     > +                                   vq->shadow_avail_idx, true);
> >     > +            if (is_desc_avail(desc.flags, vq->
> >     shadow_avail_wrap_counter)) {
> >     > +                return true;
> >     > +            }
> >     > +        }
> >     > +    } else {
> >     > +        shadow_idx =3D vq->shadow_avail_idx;
> >     > +        virtio_queue_split_set_notification(vq, enable);
> >     > +
> >     > +        if (enable) {
> >     > +            return shadow_idx !=3D vring_avail_idx(vq);
> >     > +        }
> >     > +    }
> >     > +
> >     > +    return false;
> >     > +}
> >
> >     Please document what this does.
> >     So this will return false if ring has any availabe buffers?
> >     Equivalent to:
> >
> >     bool virtio_queue_set_notification_and_check(VirtQueue *vq, int
> enable)
> >     {
> >             virtio_queue_packed_set_notification(vq, enable);
> >             return virtio_queue_empty(vq);
> >     }
> >
> >
> >     or am I missing something?
> >
> >     > +
> >     >  /* Fetch avail_idx from VQ memory only when we really need to
> know if
> >     >   * guest has added some buffers.
> >     >   * Called within rcu_read_lock().  */
> >     > diff --git a/include/hw/virtio/virtio.h
> b/include/hw/virtio/virtio.h
> >     > index 7d5ffdc145..ed85023b87 100644
> >     > --- a/include/hw/virtio/virtio.h
> >     > +++ b/include/hw/virtio/virtio.h
> >     > @@ -302,6 +302,7 @@ void virtio_notify_config(VirtIODevice *vdev)=
;
> >     >
> >     >  bool virtio_queue_get_notification(VirtQueue *vq);
> >     >  void virtio_queue_set_notification(VirtQueue *vq, int enable);
> >     > +bool virtio_queue_set_notification_and_check(VirtQueue *vq, int
> enable);
> >     >
> >     >  int virtio_queue_ready(VirtQueue *vq);
> >     >
> >     > --
> >     > 2.39.0
> >
> >
>
>

--00000000000000e363061c383251
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: base64

PGRpdiBkaXI9Imx0ciI+PGRpdiBkaXI9Imx0ciI+Jmd0OyB3aGF0IGRvZXMgJnF1b3Q7Y2hhbmdl
ZCZxdW90OyBtZWFuIGhlcmU/IGNoYW5nZWQgY29tcGFyZWQgdG8gd2hhdD88YnI+PC9kaXY+PGRp
dj5Gb3IgYSBzcGxpdMKgcXVldWUsIGlmIHRoZSBzaGFkb3dfYXZhaWxfaWR4IHN5bmNlZCBmcm9t
IGF2YWlsIHJpbmcgaWR4PC9kaXY+PGRpdj5iecKgPGkgc3R5bGU9ImNvbG9yOnJnYigwLDAsMCki
PnZyaW5nX2F2YWlsX2lkeCh2cSkgbGFzdCB0aW1lIGRvZXNuJiMzOTt0IGVxdWFsIHRoZSBjdXJy
ZW50IHZhbHVlIG9mIGF2YWlsIHJpbmcgaWR4LjwvaT48L2Rpdj48ZGl2PjxwcmUgc3R5bGU9ImNv
bG9yOnJnYigwLDAsMCkiPjxpPnZxLSZndDtzaGFkb3dfYXZhaWxfaWR4IDwvaT48aSBzdHlsZT0i
Zm9udC1mYW1pbHk6QXJpYWwsSGVsdmV0aWNhLHNhbnMtc2VyaWYiPiE9IHZyaW5nX2F2YWlsX2lk
eCh2cSk7PC9pPjwvcHJlPjxwcmUgc3R5bGU9ImNvbG9yOnJnYigwLDAsMCkiPjxmb250IGZhY2U9
IkFyaWFsLCBIZWx2ZXRpY2EsIHNhbnMtc2VyaWYiPkZvciBwYWNrZWQgcXVldWUsIHRoZSBsb2dp
YyBpcyBzaW1pbGFyLCBpZiA8L2ZvbnQ+PHNwYW4gc3R5bGU9ImZvbnQtZmFtaWx5OkFyaWFsLEhl
bHZldGljYSxzYW5zLXNlcmlmIj52cS0mZ3Q7c2hhZG93X2F2YWlsX2lkeDwvc3Bhbj48L3ByZT48
cHJlIHN0eWxlPSJjb2xvcjpyZ2IoMCwwLDApIj48c3BhbiBzdHlsZT0iZm9udC1mYW1pbHk6QXJp
YWwsSGVsdmV0aWNhLHNhbnMtc2VyaWYiPmJlY29tZXMgYXZhaWxhYmxlLCBpdCBtZWFucyB0aGUg
Z3Vlc3QgaGFzIGFkZGVkIGJ1ZiBhdCB0aGUgc2xvdC48L3NwYW4+PC9wcmU+PHByZSBzdHlsZT0i
Y29sb3I6cmdiKDAsMCwwKSI+PHByZT48aT52cmluZ19wYWNrZWRfZGVzY19yZWFkKHZxLSZndDt2
ZGV2LCAmYW1wO2Rlc2MsICZhbXA7Y2FjaGVzLSZndDtkZXNjLDwvaT48L3ByZT48cHJlPjxpPiAg
ICAgICAgICAgICAgICAgICAgICAgIDwvaT48aSBzdHlsZT0iZm9udC1mYW1pbHk6QXJpYWwsSGVs
dmV0aWNhLHNhbnMtc2VyaWYiPnZxLSZndDtzaGFkb3dfYXZhaWxfaWR4LCB0cnVlKTs8L2k+PC9w
cmU+PHByZT48aT5pZiAoaXNfZGVzY19hdmFpbChkZXNjLmZsYWdzLCB2cS0mZ3Q7IDwvaT48aSBz
dHlsZT0iZm9udC1mYW1pbHk6QXJpYWwsSGVsdmV0aWNhLHNhbnMtc2VyaWYiPnNoYWRvd19hdmFp
bF93cmFwX2NvdW50ZXIpKTwvaT48L3ByZT48cHJlPjxpIHN0eWxlPSJmb250LWZhbWlseTpBcmlh
bCxIZWx2ZXRpY2Esc2Fucy1zZXJpZiI+ICAgIHJldHVybiB0cnVlOzwvaT48L3ByZT48L3ByZT48
cHJlIHN0eWxlPSJjb2xvcjpyZ2IoMCwwLDApIj48aSBzdHlsZT0iZm9udC1mYW1pbHk6QXJpYWws
SGVsdmV0aWNhLHNhbnMtc2VyaWYiPjxicj48L2k+PC9wcmU+PC9kaXY+PGJyPjxkaXYgY2xhc3M9
ImdtYWlsX3F1b3RlIj48ZGl2IGRpcj0ibHRyIiBjbGFzcz0iZ21haWxfYXR0ciI+T24gVHVlLCBK
dWwgMiwgMjAyNCBhdCAyOjQ24oCvQU0gTWljaGFlbCBTLiBUc2lya2luICZsdDs8YSBocmVmPSJt
YWlsdG86bXN0QHJlZGhhdC5jb20iPm1zdEByZWRoYXQuY29tPC9hPiZndDsgd3JvdGU6PGJyPjwv
ZGl2PjxibG9ja3F1b3RlIGNsYXNzPSJnbWFpbF9xdW90ZSIgc3R5bGU9Im1hcmdpbjowcHggMHB4
IDBweCAwLjhleDtib3JkZXItbGVmdDoxcHggc29saWQgcmdiKDIwNCwyMDQsMjA0KTtwYWRkaW5n
LWxlZnQ6MWV4Ij5PbiBUdWUsIEp1bCAwMiwgMjAyNCBhdCAwMToxODoxNUFNICswODAwLCBZYW5n
IERvbmdzaGFuIHdyb3RlOjxicj4NCiZndDsgJmd0OyBQbGVhc2UgZG9jdW1lbnQgd2hhdCB0aGlz
IGRvZXMuPGJyPg0KJmd0OyBva2F5LCBpIHdpbGwuPGJyPg0KJmd0OyA8YnI+DQomZ3Q7ICZndDsg
U28gdGhpcyB3aWxsIHJldHVybiBmYWxzZSBpZiByaW5nIGhhcyBhbnkgYXZhaWxhYmxlIGJ1ZmZl
cnM/PGJyPg0KJmd0OyAmZ3Q7IEVxdWl2YWxlbnQgdG86PGJyPg0KJmd0OyAmZ3Q7wqA8YnI+DQom
Z3Q7ICZndDsgYm9vbCB2aXJ0aW9fcXVldWVfc2V0X25vdGlmaWNhdGlvbl9hbmRfY2hlY2soVmly
dFF1ZXVlICp2cSwgaW50IGVuYWJsZSk8YnI+DQomZ3Q7ICZndDsgezxicj4NCiZndDsgJmd0O8Kg
IMKgIMKgIMKgIHZpcnRpb19xdWV1ZV9wYWNrZWRfc2V0X25vdGlmaWNhdGlvbih2cSwgZW5hYmxl
KTs8YnI+DQomZ3Q7ICZndDvCoCDCoCDCoCDCoCDCoHJldHVybiB2aXJ0aW9fcXVldWVfZW1wdHko
dnEpOzxicj4NCiZndDsgJmd0OyB9PGJyPg0KJmd0OyA8YnI+DQomZ3Q7IE5vLCBvbmx5IHdoZW4g
dGhlwqBzaGFkb3dfYXZhaWxfaWR4IGlzIGNoYW5nZWTCoHNoYWxsIHRoZcKgZnVuY3Rpb24gcmV0
dXJuIHRydWUsPGJyPg0KPGJyPg0KPGJyPg0Kd2hhdCBkb2VzICZxdW90O2NoYW5nZWQmcXVvdDsg
bWVhbiBoZXJlPyBjaGFuZ2VkIGNvbXBhcmVkIHRvIHdoYXQ/PGJyPg0KPGJyPg0KJmd0OyBjb21w
YXJlZCB3aXRoIHRoZSB2YWx1ZcKgc2VlbiBieSB0aGUgaG9zdCBsYXN0IHRpbWUswqBlbHNlIHJl
dHVybiBmYWxzZSBldmVuIGlmPGJyPg0KJmd0OyB0aGVyZSBhcmUgc29tZSBidWZmZXJzIGF2YWls
YWJsZSBpbiB0aGUgcXVldWUsIGFzIHRoZSB0b3RhbCBzaXplIG9mIHRoZTxicj4NCiZndDsgYXZh
aWxhYmxlPGJyPg0KJmd0OyBidWZmZXJzIGluIHRoZSBxdWV1ZSBjYW4mIzM5O3Qgc2F0aXNmeSB0
aGUgcmVxdWVzdC48YnI+DQomZ3Q7IDxicj4NCiZndDsgSXQgbWF5YmUgYmV0dGVyIHRvIHBhc3Mg
b25seSBvbmUgYXJnIHRvIHRoZSBmdW5jdGlvbiBsaWtlIHRoaXM6PGJyPg0KJmd0OyBib29sIHZp
cnRpb19xdWV1ZV9zZXRfbm90aWZpY2F0aW9uX2FuZF9jaGVjayhWaXJ0UXVldWUgKnZxKTxicj4N
CiZndDsgezxicj4NCiZndDsgwqAgwqAgwqAgwqB2aXJ0aW9fcXVldWVfcGFja2VkX3NldF9ub3Rp
ZmljYXRpb24odnEsIHRydWUpOzxicj4NCiZndDsgwqAgwqAgwqAgwqA8YnI+DQomZ3Q7IMKgIMKg
IMKgIMKgcmV0dXJuIHNoYWRvd19hdmFpbF9pZHhfY2hhbmdlZCgpPyB0cnVlOiBmYWxzZTs8YnI+
DQomZ3Q7IH08YnI+DQomZ3Q7IDxicj4NCiZndDsgVGhhbmtzIE1pY2hhZWwgYSBsb3QhPGJyPg0K
Jmd0OyA8YnI+DQomZ3Q7IE9uIE1vbiwgSnVsIDEsIDIwMjQgYXQgMTE6MDXigK9QTSBNaWNoYWVs
IFMuIFRzaXJraW4gJmx0OzxhIGhyZWY9Im1haWx0bzptc3RAcmVkaGF0LmNvbSIgdGFyZ2V0PSJf
YmxhbmsiPm1zdEByZWRoYXQuY29tPC9hPiZndDsgd3JvdGU6PGJyPg0KJmd0OyA8YnI+DQomZ3Q7
wqAgwqAgwqBPbiBNb24sIEp1bCAwMSwgMjAyNCBhdCAxMDowMDoxN1BNICswODAwLCBXZW5jaGVu
ZyBZYW5nIHdyb3RlOjxicj4NCiZndDvCoCDCoCDCoCZndDsgRnJvbTogdGhvbWFzICZsdDs8YSBo
cmVmPSJtYWlsdG86ZWFzdC5tb3V0YWluLnlhbmdAZ21haWwuY29tIiB0YXJnZXQ9Il9ibGFuayI+
ZWFzdC5tb3V0YWluLnlhbmdAZ21haWwuY29tPC9hPiZndDs8YnI+DQomZ3Q7wqAgwqAgwqAmZ3Q7
PGJyPg0KJmd0O8KgIMKgIMKgJmd0OyBQYXRjaCAwNmIxMjk3MDE3NCAoJnF1b3Q7dmlydGlvLW5l
dDogZml4IG5ldHdvcmsgc3RhbGwgdW5kZXIgbG9hZCZxdW90Oyk8YnI+DQomZ3Q7wqAgwqAgwqAm
Z3Q7IGFkZGVkIGRvdWJsZS1jaGVjayB0byB0ZXN0IHdoZXRoZXIgdGhlIGF2YWlsYWJsZSBidWZm
ZXIgc2l6ZTxicj4NCiZndDvCoCDCoCDCoCZndDsgY2FuIHNhdGlzZnkgdGhlIHJlcXVlc3Qgb3Ig
bm90LCBpbiBjYXNlIHRoZSBndWVzdCBoYXMgYWRkZWQ8YnI+DQomZ3Q7wqAgwqAgwqAmZ3Q7IHNv
bWUgYnVmZmVycyB0byB0aGUgYXZhaWwgcmluZyBzaW11bHRhbmVvdXNseSBhZnRlciB0aGUgZmly
c3Q8YnI+DQomZ3Q7wqAgwqAgwqAmZ3Q7IGNoZWNrLiBJdCB3aWxsIGJlIGx1Y2t5IGlmIHRoZSBh
dmFpbGFibGUgYnVmZmVyIHNpemUgYmVjb21lczxicj4NCiZndDvCoCDCoCDCoCZndDsgb2theSBh
ZnRlciB0aGUgZG91YmxlLWNoZWNrLCB0aGVuIHRoZSBob3N0IGNhbiBzZW5kIHRoZSBwYWNrZXQ8
YnI+DQomZ3Q7wqAgwqAgwqAmZ3Q7IHRvIHRoZSBndWVzdC4gSWYgdGhlIGJ1ZmZlciBzaXplIHN0
aWxsIGNhbiYjMzk7dCBzYXRpc2Z5IHRoZSByZXF1ZXN0LDxicj4NCiZndDvCoCDCoCDCoCZndDsg
ZXZlbiBpZiB0aGUgZ3Vlc3QgaGFzIGFkZGVkIHNvbWUgYnVmZmVycywgdmlyaXRpby1uZXQgd291
bGQ8YnI+DQomZ3Q7wqAgwqAgwqAmZ3Q7IHN0YWxsIGF0IHRoZSBob3N0IHNpZGUgZm9yZXZlci48
YnI+DQomZ3Q7wqAgwqAgwqAmZ3Q7PGJyPg0KJmd0O8KgIMKgIMKgJmd0OyBUaGUgcGF0Y2ggY2hl
Y2tzIHdoZXRoZXIgdGhlIGd1ZXN0IGhhcyBhZGRlZCBzb21lIGJ1ZmZlcnM8YnI+DQomZ3Q7wqAg
wqAgwqAmZ3Q7IGFmdGVyIGxhc3QgY2hlY2sgb2YgYXZhaWwgaWR4IHdoZW4gdGhlIGF2YWlsYWJs
ZSBidWZmZXJzIGFyZTxicj4NCiZndDvCoCDCoCDCoCZndDsgbm90IHN1ZmZpY2llbnQsIGlmIHNv
IHRoZW4gcmVjaGVjayB0aGUgYXZhaWxhYmxlIGJ1ZmZlcnM8YnI+DQomZ3Q7wqAgwqAgwqAmZ3Q7
IGluIHRoZSBsb29wLjxicj4NCiZndDvCoCDCoCDCoCZndDs8YnI+DQomZ3Q7wqAgwqAgwqAmZ3Q7
IFRoZSBwYXRjaCBhbHNvIHJldmVydHMgcGF0Y2ggJnF1b3Q7MDZiMTI5NzAxNzQmcXVvdDsuPGJy
Pg0KJmd0O8KgIMKgIMKgJmd0Ozxicj4NCiZndDvCoCDCoCDCoCZndDsgVGhlIGNhc2UgYmVsb3cg
Y2FuIHJlcHJvZHVjZSB0aGUgc3RhbGwuPGJyPg0KJmd0O8KgIMKgIMKgJmd0Ozxicj4NCiZndDvC
oCDCoCDCoCZndDvCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDC
oCDCoCDCoCDCoCDCoCBHdWVzdCAwPGJyPg0KJmd0O8KgIMKgIMKgJmd0O8KgIMKgIMKgIMKgIMKg
IMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgICstLS0tLS0tLSs8YnI+
DQomZ3Q7wqAgwqAgwqAmZ3Q7wqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAg
wqAgwqAgwqAgwqAgwqAgwqAgfCBpcGVyZsKgIHw8YnI+DQomZ3Q7wqAgwqAgwqAmZ3Q7wqAgwqAg
wqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAtLS0tLS0tLS0tLS0tLS0mZ3Q7IHwgc2VydmVyIHw8
YnI+DQomZ3Q7wqAgwqAgwqAmZ3Q7wqAgwqAgwqAgwqAgwqAgSG9zdMKgIMKgIMKgIMKgfMKgIMKg
IMKgIMKgIMKgIMKgIMKgIMKgICstLS0tLS0tLSs8YnI+DQomZ3Q7wqAgwqAgwqAmZ3Q7wqAgwqAg
wqAgwqAgKy0tLS0tLS0tK8KgIMKgfMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIC4uLjxi
cj4NCiZndDvCoCDCoCDCoCZndDvCoCDCoCDCoCDCoCB8IGlwZXJmwqAgfC0tLS08YnI+DQomZ3Q7
wqAgwqAgwqAmZ3Q7wqAgwqAgwqAgwqAgfCBjbGllbnQgfC0tLS3CoCDCoCDCoCDCoCDCoCDCoCDC
oCDCoCDCoCBHdWVzdCBuPGJyPg0KJmd0O8KgIMKgIMKgJmd0O8KgIMKgIMKgIMKgICstLS0tLS0t
LSvCoCDCoHzCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCArLS0tLS0tLS0rPGJyPg0KJmd0O8KgIMKg
IMKgJmd0O8KgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgfMKgIMKgIMKgIMKgIMKgIMKg
IMKgIMKgIHwgaXBlcmbCoCB8PGJyPg0KJmd0O8KgIMKgIMKgJmd0O8KgIMKgIMKgIMKgIMKgIMKg
IMKgIMKgIMKgIMKgIMKgLS0tLS0tLS0tLS0tLS0tJmd0OyB8IHNlcnZlciB8PGJyPg0KJmd0O8Kg
IMKgIMKgJmd0O8KgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKg
IMKgIMKgIMKgICstLS0tLS0tLSs8YnI+DQomZ3Q7wqAgwqAgwqAmZ3Q7PGJyPg0KJmd0O8KgIMKg
IMKgJmd0OyBCb290IG1hbnkgZ3Vlc3RzIGZyb20gcWVtdSB3aXRoIHZpcnRpbyBuZXR3b3JrOjxi
cj4NCiZndDvCoCDCoCDCoCZndDvCoCBxZW11IC4uLiAtbmV0ZGV2IHRhcCxpZD1uZXRfeCBcPGJy
Pg0KJmd0O8KgIMKgIMKgJmd0O8KgIMKgIMKgLWRldmljZSB2aXJ0aW8tbmV0LXBjaS1ub24tdHJh
bnNpdGlvbmFsLFw8YnI+DQomZ3Q7wqAgwqAgwqAmZ3Q7wqAgwqAgwqBpb21tdV9wbGF0Zm9ybT1v
bixtYWM9eHg6eHg6eHg6eHg6eHg6eHgsbmV0ZGV2PW5ldF94PGJyPg0KJmd0O8KgIMKgIMKgJmd0
Ozxicj4NCiZndDvCoCDCoCDCoCZndDsgRWFjaCBndWVzdCBhY3RzIGFzIGlwZXJmIHNlcnZlciB3
aXRoIGNvbW1hbmRzIGJlbG93Ojxicj4NCiZndDvCoCDCoCDCoCZndDvCoCBpcGVyZjMgLXMgLUQg
LWkgMTAgLXAgODAwMTxicj4NCiZndDvCoCDCoCDCoCZndDvCoCBpcGVyZjMgLXMgLUQgLWkgMTAg
LXAgODAwMjxicj4NCiZndDvCoCDCoCDCoCZndDs8YnI+DQomZ3Q7wqAgwqAgwqAmZ3Q7IFRoZSBo
b3N0IGFzIGlwZXJmIGNsaWVudDo8YnI+DQomZ3Q7wqAgwqAgwqAmZ3Q7wqAgaXBlcmYzIC1jIGd1
ZXN0X0lQIC1wIDgwMDEgLWkgMzAgLXcgMjU2ayAtUCAyMCAtdCA0MDAwMDxicj4NCiZndDvCoCDC
oCDCoCZndDvCoCBpcGVyZjMgLWMgZ3Vlc3RfSVAgLXAgODAwMiAtaSAzMCAtdyAyNTZrIC1QIDIw
IC10IDQwMDAwPGJyPg0KJmd0O8KgIMKgIMKgJmd0Ozxicj4NCiZndDvCoCDCoCDCoCZndDsgQWZ0
ZXIgc29tZSB0aW1lLCB0aGUgaG9zdCBsb3NlcyBjb25uZWN0aW9uIHRvIHRoZSBndWVzdCw8YnI+
DQomZ3Q7wqAgwqAgwqAmZ3Q7IHRoZSBndWVzdCBjYW4gc2VuZCBwYWNrZXQgdG8gdGhlIGhvc3Qs
IGJ1dCBjYW4mIzM5O3QgcmVjZWl2ZTxicj4NCiZndDvCoCDCoCDCoCZndDsgcGFja2V0IGZyb20g
aG9zdC48YnI+DQomZ3Q7wqAgwqAgwqAmZ3Q7PGJyPg0KJmd0O8KgIMKgIMKgJmd0OyBJdCYjMzk7
cyBtb3JlIGxpa2VseSB0byBoYXBwZW4gaWYgU1dJT1RMQiBpcyBlbmFibGVkIGluIHRoZSBndWVz
dCw8YnI+DQomZ3Q7wqAgwqAgwqAmZ3Q7IGFsbG9jYXRpbmcgYW5kIGZyZWVpbmcgYm91bmNlIGJ1
ZmZlciB0YWtlcyBzb21lIENQVSB0aWNrcyw8YnI+DQomZ3Q7wqAgwqAgwqAmZ3Q7IGNvcHlpbmcg
ZnJvbS90byBib3VuY2UgYnVmZmVyIHRha2VzIG1vcmUgQ1BVIHRpY2tzLCBjb21wYXJlZDxicj4N
CiZndDvCoCDCoCDCoCZndDsgd2l0aCB0aGF0IHRoZXJlIGlzIG5vIGJvdW5jZSBidWZmZXIgaW4g
dGhlIGd1ZXN0Ljxicj4NCiZndDvCoCDCoCDCoCZndDsgT25jZSB0aGUgcmF0ZSBvZiBwcm9kdWNp
bmcgcGFja2V0cyBmcm9tIHRoZSBob3N0IGFwcHJveGltYXRlczxicj4NCiZndDvCoCDCoCDCoCZn
dDsgdGhlIHJhdGUgb2YgcmVjZWl2ZWluZyBwYWNrZXRzIGluIHRoZSBndWVzdCwgdGhlIGd1ZXN0
IHdvdWxkPGJyPg0KJmd0O8KgIMKgIMKgJmd0OyBsb29wIGluIE5BUEkuPGJyPg0KJmd0O8KgIMKg
IMKgJmd0Ozxicj4NCiZndDvCoCDCoCDCoCZndDvCoCDCoCDCoCDCoCDCoCByZWNlaXZlIHBhY2tl
dHPCoCDCoCAtLS08YnI+DQomZ3Q7wqAgwqAgwqAmZ3Q7wqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAg
fMKgIMKgIMKgIMKgIMKgIMKgIMKgfDxicj4NCiZndDvCoCDCoCDCoCZndDvCoCDCoCDCoCDCoCDC
oCDCoCDCoCDCoCB2wqAgwqAgwqAgwqAgwqAgwqAgwqB8PGJyPg0KJmd0O8KgIMKgIMKgJmd0O8Kg
IMKgIMKgIMKgIMKgIMKgIGZyZWUgYnVmwqAgwqAgwqAgdmlydG5ldF9wb2xsPGJyPg0KJmd0O8Kg
IMKgIMKgJmd0O8KgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIHzCoCDCoCDCoCDCoCDCoCDCoCDCoHw8
YnI+DQomZ3Q7wqAgwqAgwqAmZ3Q7wqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgdsKgIMKgIMKgIMKg
IMKgIMKgIMKgfDxicj4NCiZndDvCoCDCoCDCoCZndDvCoCDCoCDCoCBhZGQgYnVmIHRvIGF2YWls
IHJpbmfCoCAtLS08YnI+DQomZ3Q7wqAgwqAgwqAmZ3Q7wqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAg
fDxicj4NCiZndDvCoCDCoCDCoCZndDvCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCB8wqAgbmVlZCBr
aWNrIHRoZSBob3N0Pzxicj4NCiZndDvCoCDCoCDCoCZndDvCoCDCoCDCoCDCoCDCoCDCoCDCoCDC
oCB8wqAgTkFQSSBjb250aW51ZXM8YnI+DQomZ3Q7wqAgwqAgwqAmZ3Q7wqAgwqAgwqAgwqAgwqAg
wqAgwqAgwqAgdjxicj4NCiZndDvCoCDCoCDCoCZndDvCoCDCoCDCoCDCoCDCoCByZWNlaXZlIHBh
Y2tldHPCoCDCoCAtLS08YnI+DQomZ3Q7wqAgwqAgwqAmZ3Q7wqAgwqAgwqAgwqAgwqAgwqAgwqAg
wqAgfMKgIMKgIMKgIMKgIMKgIMKgIMKgfDxicj4NCiZndDvCoCDCoCDCoCZndDvCoCDCoCDCoCDC
oCDCoCDCoCDCoCDCoCB2wqAgwqAgwqAgwqAgwqAgwqAgwqB8PGJyPg0KJmd0O8KgIMKgIMKgJmd0
O8KgIMKgIMKgIMKgIMKgIMKgIGZyZWUgYnVmwqAgwqAgwqAgdmlydG5ldF9wb2xsPGJyPg0KJmd0
O8KgIMKgIMKgJmd0O8KgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIHzCoCDCoCDCoCDCoCDCoCDCoCDC
oHw8YnI+DQomZ3Q7wqAgwqAgwqAmZ3Q7wqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgdsKgIMKgIMKg
IMKgIMKgIMKgIMKgfDxicj4NCiZndDvCoCDCoCDCoCZndDvCoCDCoCDCoCBhZGQgYnVmIHRvIGF2
YWlsIHJpbmfCoCAtLS08YnI+DQomZ3Q7wqAgwqAgwqAmZ3Q7wqAgwqAgwqAgwqAgwqAgwqAgwqAg
wqAgfDxicj4NCiZndDvCoCDCoCDCoCZndDvCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCB2PGJyPg0K
Jmd0O8KgIMKgIMKgJmd0O8KgIMKgIMKgIMKgIMKgIMKgIMKgIMKgLi4uwqAgwqAgwqAgwqAgwqAg
wqAuLi48YnI+DQomZ3Q7wqAgwqAgwqAmZ3Q7PGJyPg0KJmd0O8KgIMKgIMKgJmd0OyBPbiB0aGUg
b3RoZXIgaGFuZCwgdGhlIGhvc3QgZmV0Y2hlcyBmcmVlIGJ1ZiBmcm9tIGF2YWlsPGJyPg0KJmd0
O8KgIMKgIMKgJmd0OyByaW5nLCBpZiB0aGUgYnVmIGluIHRoZSBhdmFpbCByaW5nIGlzIG5vdCBl
bm91Z2gsIHRoZTxicj4NCiZndDvCoCDCoCDCoCZndDsgaG9zdCBub3RpZmllcyB0aGUgZ3Vlc3Qg
dGhlIGV2ZW50IGJ5IHdyaXRpbmcgdGhlIGF2YWlsPGJyPg0KJmd0O8KgIMKgIMKgJmd0OyBpZHgg
cmVhZCBmcm9tIGF2YWlsIHJpbmcgdG8gdGhlIGV2ZW50IGlkeCBvZiB1c2VkIHJpbmcsPGJyPg0K
Jmd0O8KgIMKgIMKgJmd0OyB0aGVuIHRoZSBob3N0IGdvZXMgdG8gc2xlZXAsIHdhaXRpbmcgZm9y
IHRoZSBraWNrIHNpZ25hbDxicj4NCiZndDvCoCDCoCDCoCZndDsgZnJvbSB0aGUgZ3Vlc3QuPGJy
Pg0KJmd0O8KgIMKgIMKgJmd0Ozxicj4NCiZndDvCoCDCoCDCoCZndDsgT25jZSB0aGUgZ3Vlc3Qg
ZmluZHMgdGhlIGhvc3QgaXMgd2FpdGluZyBmb3Iga2ljayBzaW5nYWw8YnI+DQomZ3Q7wqAgwqAg
wqAmZ3Q7IChpbiB2aXJ0cXVldWVfa2lja19wcmVwYXJlX3NwbGl0KCkpLCBpdCBraWNrcyB0aGUg
aG9zdC48YnI+DQomZ3Q7wqAgwqAgwqAmZ3Q7PGJyPg0KJmd0O8KgIMKgIMKgJmd0OyBUaGUgaG9z
dCBtYXkgc3RhbGwgZm9yZXZlciBhdCB0aGUgc2VxdWVuY2VzIGJlbG93Ojxicj4NCiZndDvCoCDC
oCDCoCZndDs8YnI+DQomZ3Q7wqAgwqAgwqAmZ3Q7wqAgwqAgwqAgwqAgwqAgSG9zdMKgIMKgIMKg
IMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIEd1ZXN0PGJyPg0KJmd0O8KgIMKgIMKgJmd0O8Kg
IMKgIMKgIC0tLS0tLS0tLS0tLcKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgLS0tLS0tLS0tLS08
YnI+DQomZ3Q7wqAgwqAgwqAmZ3Q7wqAgZmV0Y2ggYnVmLCBzZW5kIHBhY2tldMKgIMKgIMKgIMKg
IMKgIMKgcmVjZWl2ZSBwYWNrZXQgLS0tPGJyPg0KJmd0O8KgIMKgIMKgJmd0O8KgIMKgIMKgIMKg
IMKgIC4uLsKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIC4uLsKgIMKgIMKg
IMKgIMKgfDxicj4NCiZndDvCoCDCoCDCoCZndDvCoCBmZXRjaCBidWYsIHNlbmQgcGFja2V0wqAg
wqAgwqAgwqAgwqAgwqAgwqBhZGQgYnVmwqAgwqAgwqAgwqB8PGJyPg0KJmd0O8KgIMKgIMKgJmd0
O8KgIMKgIMKgIMKgIMKgIC4uLsKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIGFk
ZCBidWbCoCDCoHZpcnRuZXRfcG9sbDxicj4NCiZndDvCoCDCoCDCoCZndDvCoCDCoCDCoGJ1ZiBu
b3QgZW5vdWdowqAgwqAgwqAgYXZhaWwgaWR4LSZndDsgYWRkIGJ1ZsKgIMKgIMKgIMKgfDxicj4N
CiZndDvCoCDCoCDCoCZndDvCoCDCoCDCoHJlYWQgYXZhaWwgaWR4wqAgwqAgwqAgwqAgwqAgwqAg
wqAgwqAgwqAgYWRkIGJ1ZsKgIMKgIMKgIMKgfDxicj4NCiZndDvCoCDCoCDCoCZndDvCoCDCoCDC
oCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoGFkZCBidWbC
oCDCoCDCoCAtLS08YnI+DQomZ3Q7wqAgwqAgwqAmZ3Q7wqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAg
wqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqByZWNlaXZlIHBhY2tldCAtLS08YnI+DQomZ3Q7
wqAgwqAgwqAmZ3Q7wqAgwqAgwqB3cml0ZSBldmVudCBpZHjCoCDCoCDCoCDCoCDCoCDCoCDCoCDC
oCDCoCDCoC4uLsKgIMKgIMKgIMKgIMKgfDxicj4NCiZndDvCoCDCoCDCoCZndDvCoCDCoCDCoHdh
aXQgZm9yIGtpY2vCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoGFkZCBidWbCoCDCoHZpcnRu
ZXRfcG9sbDxicj4NCiZndDvCoCDCoCDCoCZndDvCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDC
oCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoC4uLsKgIMKgIMKgIMKgIMKgfDxicj4NCiZn
dDvCoCDCoCDCoCZndDvCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDC
oCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCAtLS08YnI+DQomZ3Q7wqAgwqAgwqAmZ3Q7
wqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgbm8gbW9y
ZSBwYWNrZXQsIGV4aXQgTkFQSTxicj4NCiZndDvCoCDCoCDCoCZndDs8YnI+DQomZ3Q7wqAgwqAg
wqAmZ3Q7IEluIHRoZSBmaXJzdCBsb29wIG9mIE5BUEkgYWJvdmUsIGluZGljYXRlZCBpbiB0aGUg
cmFuZ2Ugb2Y8YnI+DQomZ3Q7wqAgwqAgwqAmZ3Q7IHZpcnRuZXRfcG9sbCBhYm92ZSwgdGhlIGhv
c3QgaXMgc2VuZGluZyBwYWNrZXRzIHdoaWxlIHRoZTxicj4NCiZndDvCoCDCoCDCoCZndDsgZ3Vl
c3QgaXMgcmVjZWl2aW5nIHBhY2tldHMgYW5kIGFkZGluZyBidWZmZXJzLjxicj4NCiZndDvCoCDC
oCDCoCZndDvCoCBzdGVwIDE6IFRoZSBidWYgaXMgbm90IGVub3VnaCwgZm9yIGV4YW1wbGUsIGEg
YmlnIHBhY2tldDxicj4NCiZndDvCoCDCoCDCoCZndDvCoCDCoCDCoCDCoCDCoCBuZWVkcyA1IGJ1
ZiwgYnV0IHRoZSBhdmFpbGFibGUgYnVmIGNvdW50IGlzIDMuPGJyPg0KJmd0O8KgIMKgIMKgJmd0
O8KgIMKgIMKgIMKgIMKgIFRoZSBob3N0IHJlYWQgY3VycmVudCBhdmFpbCBpZHguPGJyPg0KJmd0
O8KgIMKgIMKgJmd0O8KgIHN0ZXAgMjogVGhlIGd1ZXN0IGFkZHMgc29tZSBidWYsIHRoZW4gY2hl
Y2tzIHdoZXRoZXIgdGhlPGJyPg0KJmd0O8KgIMKgIMKgJmd0O8KgIMKgIMKgIMKgIMKgIGhvc3Qg
aXMgd2FpdGluZyBmb3Iga2ljayBzaWduYWwsIG5vdCBhdCB0aGlzIHRpbWUuPGJyPg0KJmd0O8Kg
IMKgIMKgJmd0O8KgIMKgIMKgIMKgIMKgIFRoZSB1c2VkIHJpbmcgaXMgbm90IGVtcHR5LCB0aGUg
Z3Vlc3QgY29udGludWVzPGJyPg0KJmd0O8KgIMKgIMKgJmd0O8KgIMKgIMKgIMKgIMKgIHRoZSBz
ZWNvbmQgbG9vcCBvZiBOQVBJLjxicj4NCiZndDvCoCDCoCDCoCZndDvCoCBzdGVwIDM6IFRoZSBo
b3N0IHdyaXRlcyB0aGUgYXZhaWwgaWR4IHJlYWQgZnJvbSBhdmFpbDxicj4NCiZndDvCoCDCoCDC
oCZndDvCoCDCoCDCoCDCoCDCoCByaW5nIHRvIHVzZWQgcmluZyBhcyBldmVudCBpZHggdmlhPGJy
Pg0KJmd0O8KgIMKgIMKgJmd0O8KgIMKgIMKgIMKgIMKgIHZpcnRpb19xdWV1ZV9zZXRfbm90aWZp
Y2F0aW9uKHEtJmd0O3J4X3ZxLCAxKS48YnI+DQomZ3Q7wqAgwqAgwqAmZ3Q7wqAgc3RlcCA0OiBB
dCB0aGUgZW5kIG9mIHRoZSBzZWNvbmQgbG9vcCBvZiBOQVBJLCByZWNoZWNrPGJyPg0KJmd0O8Kg
IMKgIMKgJmd0O8KgIMKgIMKgIMKgIMKgIHdoZXRoZXIga2ljayBpcyBuZWVkZWQsIGFzIHRoZSBl
dmVudCBpZHggaW4gdGhlPGJyPg0KJmd0O8KgIMKgIMKgJmd0O8KgIMKgIMKgIMKgIMKgIHVzZWQg
cmluZyB3cml0dGVuIGJ5IHRoZSBob3N0IGlzIGJleW91bmQgdGhlPGJyPg0KJmd0O8KgIMKgIMKg
Jmd0O8KgIMKgIMKgIMKgIMKgIHJhbmdlIG9mIGtpY2sgY29uZGl0aW9uLCB0aGUgZ3Vlc3Qgd2ls
bCBub3Q8YnI+DQomZ3Q7wqAgwqAgwqAmZ3Q7wqAgwqAgwqAgwqAgwqAgc2VuZCBraWNrIHNpZ25h
bCB0byB0aGUgaG9zdC48YnI+DQomZ3Q7wqAgwqAgwqAmZ3Q7PGJyPg0KJmd0O8KgIMKgIMKgJmd0
OyBGaXhlczogMDZiMTI5NzAxNzQgKCZxdW90O3ZpcnRpby1uZXQ6IGZpeCBuZXR3b3JrIHN0YWxs
IHVuZGVyIGxvYWQmcXVvdDspPGJyPg0KJmd0O8KgIMKgIMKgJmd0OyBTaWduZWQtb2ZmLWJ5OiBX
ZW5jaGVuZyBZYW5nICZsdDs8YSBocmVmPSJtYWlsdG86ZWFzdC5tb3V0YWluLnlhbmdAZ21haWwu
Y29tIiB0YXJnZXQ9Il9ibGFuayI+ZWFzdC5tb3V0YWluLnlhbmdAZ21haWwuY29tPC9hPiZndDs8
YnI+DQomZ3Q7wqAgwqAgwqAmZ3Q7IC0tLTxicj4NCiZndDvCoCDCoCDCoCZndDs8YnI+DQomZ3Q7
wqAgwqAgwqAmZ3Q7IENoYW5nZWxvZzo8YnI+DQomZ3Q7wqAgwqAgwqAmZ3Q7IHY3Ojxicj4NCiZn
dDvCoCDCoCDCoCZndDsgLSBBZGQgZnVuY3Rpb24gdmlydGlvX3F1ZXVlX3NldF9ub3RpZmljYXRp
b25fYW5kX2NoZWNrKCk8YnI+DQomZ3Q7wqAgwqAgwqAmZ3Q7IC0gUmVzdG9yZSB0aGUgZnVuY3Rp
b24gc2VxdWVuY2UgaW50cm9kdWNlIGluIHY2PGJyPg0KJmd0O8KgIMKgIMKgJmd0Ozxicj4NCiZn
dDvCoCDCoCDCoCZndDsgdjY6PGJyPg0KJmd0O8KgIMKgIMKgJmd0OyAtIFRha2UgcGFja2VkIHBh
Y2tlZCBxdWV1ZSBpbnRvIGNvc2lkZXJhdGlvbjxicj4NCiZndDvCoCDCoCDCoCZndDsgLSBBZGp1
c3QgZnVuY3Rpb24gc2VxdWVuY2UgdG8gZml4IGNvbXBpbGF0aW9uIGlzc3VlPGJyPg0KJmd0O8Kg
IMKgIMKgJmd0Ozxicj4NCiZndDvCoCDCoCDCoCZndDsgdjU6PGJyPg0KJmd0O8KgIMKgIMKgJmd0
OyAtIE1vZGlmeSByZXR1cm4gdHlwZSBvZiB2aXJ0aW9fcXVldWVfc2V0X25vdGlmaWNhdGlvbigp
IHRvPGJyPg0KJmd0O8KgIMKgIMKgJmd0O8KgIMKgYm9vbCB0byBpbmRpY2F0ZSB3aGV0aGVyIHRo
ZSBndWVzdCBoYXMgYWRkZWQgc29tZSBidWZmZXJzPGJyPg0KJmd0O8KgIMKgIMKgJmd0O8KgIMKg
YWZ0ZXIgbGFzdCBjaGVjayBvZiBhdmFpbCBpZHg8YnI+DQomZ3Q7wqAgwqAgwqAmZ3Q7IC0gTG9v
cCBpbiB2aXJ0aW9fbmV0X2hhc19idWZmZXJzKCkgaWYgdGhlIGF2YWlsYWJsZSBidWZmZXJzPGJy
Pg0KJmd0O8KgIMKgIMKgJmd0O8KgIMKgYXJlIG5vdCBzdWZmaWNpZW50IGFuZCB0aGUgZ3Vlc3Qg
aGFzIGFkZGVkIHNvbWUgYnVmZmVycy48YnI+DQomZ3Q7wqAgwqAgwqAmZ3Q7IC0gUmV2ZXJ0IHBh
dGNoICZxdW90OzA2YjEyOTcwMTc0JnF1b3Q7PGJyPg0KJmd0O8KgIMKgIMKgJmd0OyAtIFVwZGF0
ZSB0aGUgc3ViamVjdDxicj4NCiZndDvCoCDCoCDCoCZndDs8YnI+DQomZ3Q7wqAgwqAgwqAmZ3Q7
IHY0Ojxicj4NCiZndDvCoCDCoCDCoCZndDsgLSBDb3JyZWN0IHNwZWxsaW5nIG1pc3Rha2UgaW4g
dGhlIHN1YmplY3Q8YnI+DQomZ3Q7wqAgwqAgwqAmZ3Q7IC0gRGVzY3JpYmUgdGhlIGlzc3VlIHRo
YXQgdmlydGlvLW5ldCBpcyBibG9ja2VkIGF0IGhvc3Qgc2lkZTxicj4NCiZndDvCoCDCoCDCoCZn
dDs8YnI+DQomZ3Q7wqAgwqAgwqAmZ3Q7IHYzOjxicj4NCiZndDvCoCDCoCDCoCZndDsgLSBBZGQg
dmlydGlvLW5ldCB0YWcgaW4gdGhlIHN1YmplY3Q8YnI+DQomZ3Q7wqAgwqAgwqAmZ3Q7IC0gUmVm
aW5lIGNvbW1pdCBsb2c8YnI+DQomZ3Q7wqAgwqAgwqAmZ3Q7PGJyPg0KJmd0O8KgIMKgIMKgJmd0
OyB2Mjo8YnI+DQomZ3Q7wqAgwqAgwqAmZ3Q7IC0gQWRkIFNPQiB0YWcgYXQgdGhlIGVuZCBvZiB0
aGUgY29tbWl0IG1lc3NhZ2U8YnI+DQomZ3Q7wqAgwqAgwqAmZ3Q7IC0gUGxhY2UgRml4ZXMgdGFn
IGF0IHRoZSBlbmQgb2YgdGhlIGNvbW1pdCBtZXNzYWdlPGJyPg0KJmd0O8KgIMKgIMKgJmd0Ozxi
cj4NCiZndDvCoCDCoCDCoCZndDsgdjE6PGJyPg0KJmd0O8KgIMKgIMKgJmd0OyAtIEluaXRpYWwg
cGF0Y2g8YnI+DQomZ3Q7wqAgwqAgwqAmZ3Q7PGJyPg0KJmd0O8KgIMKgIMKgJmd0O8KgIGh3L25l
dC92aXJ0aW8tbmV0LmPCoCDCoCDCoCDCoCB8IDE5ICsrKysrKysrLS0tLS0tLS0tLS08YnI+DQom
Z3Q7wqAgwqAgwqAmZ3Q7wqAgaHcvdmlydGlvL3ZpcnRpby5jwqAgwqAgwqAgwqAgwqB8IDM5ICsr
KysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrPGJyPg0KJmd0O8KgIMKgIMKgJmd0
O8KgIGluY2x1ZGUvaHcvdmlydGlvL3ZpcnRpby5oIHzCoCAxICs8YnI+DQomZ3Q7wqAgwqAgwqAm
Z3Q7wqAgMyBmaWxlcyBjaGFuZ2VkLCA0OCBpbnNlcnRpb25zKCspLCAxMSBkZWxldGlvbnMoLSk8
YnI+DQomZ3Q7wqAgwqAgwqAmZ3Q7PGJyPg0KJmd0O8KgIMKgIMKgJmd0OyBkaWZmIC0tZ2l0IGEv
aHcvbmV0L3ZpcnRpby1uZXQuYyBiL2h3L25ldC92aXJ0aW8tbmV0LmM8YnI+DQomZ3Q7wqAgwqAg
wqAmZ3Q7IGluZGV4IDljN2U4NWNhZWEuLjM1N2M2NTFkOWIgMTAwNjQ0PGJyPg0KJmd0O8KgIMKg
IMKgJmd0OyAtLS0gYS9ody9uZXQvdmlydGlvLW5ldC5jPGJyPg0KJmd0O8KgIMKgIMKgJmd0OyAr
KysgYi9ody9uZXQvdmlydGlvLW5ldC5jPGJyPg0KJmd0O8KgIMKgIMKgJmd0OyBAQCAtMTY0Miwx
OCArMTY0MiwxNSBAQCBzdGF0aWMgYm9vbCB2aXJ0aW9fbmV0X2Nhbl9yZWNlaXZlKE5ldENsaWVu
dFN0YXRlPGJyPg0KJmd0O8KgIMKgIMKgKm5jKTxicj4NCiZndDvCoCDCoCDCoCZndDvCoCBzdGF0
aWMgaW50IHZpcnRpb19uZXRfaGFzX2J1ZmZlcnMoVmlydElPTmV0UXVldWUgKnEsIGludCBidWZz
aXplKTxicj4NCiZndDvCoCDCoCDCoCZndDvCoCB7PGJyPg0KJmd0O8KgIMKgIMKgJmd0O8KgIMKg
IMKgIFZpcnRJT05ldCAqbiA9IHEtJmd0O247PGJyPg0KJmd0O8KgIMKgIMKgJmd0OyAtwqAgwqAg
aWYgKHZpcnRpb19xdWV1ZV9lbXB0eShxLSZndDtyeF92cSkgfHw8YnI+DQomZ3Q7wqAgwqAgwqAm
Z3Q7IC3CoCDCoCDCoCDCoCAobi0mZ3Q7bWVyZ2VhYmxlX3J4X2J1ZnMgJmFtcDsmYW1wOzxicj4N
CiZndDvCoCDCoCDCoCZndDsgLcKgIMKgIMKgIMKgIMKgIXZpcnRxdWV1ZV9hdmFpbF9ieXRlcyhx
LSZndDtyeF92cSwgYnVmc2l6ZSwgMCkpKSB7PGJyPg0KJmd0O8KgIMKgIMKgJmd0OyAtwqAgwqAg
wqAgwqAgdmlydGlvX3F1ZXVlX3NldF9ub3RpZmljYXRpb24ocS0mZ3Q7cnhfdnEsIDEpOzxicj4N
CiZndDvCoCDCoCDCoCZndDsgLTxicj4NCiZndDvCoCDCoCDCoCZndDsgLcKgIMKgIMKgIMKgIC8q
IFRvIGF2b2lkIGEgcmFjZSBjb25kaXRpb24gd2hlcmUgdGhlIGd1ZXN0IGhhcyBtYWRlIHNvbWU8
YnI+DQomZ3Q7wqAgwqAgwqBidWZmZXJzPGJyPg0KJmd0O8KgIMKgIMKgJmd0OyAtwqAgwqAgwqAg
wqAgwqAqIGF2YWlsYWJsZSBhZnRlciB0aGUgYWJvdmUgY2hlY2sgYnV0IGJlZm9yZSBub3RpZmlj
YXRpb24gd2FzPGJyPg0KJmd0O8KgIMKgIMKgJmd0OyAtwqAgwqAgwqAgwqAgwqAqIGVuYWJsZWQs
IGNoZWNrIGZvciBhdmFpbGFibGUgYnVmZmVycyBhZ2Fpbi48YnI+DQomZ3Q7wqAgwqAgwqAmZ3Q7
IC3CoCDCoCDCoCDCoCDCoCovPGJyPg0KJmd0O8KgIMKgIMKgJmd0OyAtwqAgwqAgwqAgwqAgaWYg
KHZpcnRpb19xdWV1ZV9lbXB0eShxLSZndDtyeF92cSkgfHw8YnI+DQomZ3Q7wqAgwqAgwqAmZ3Q7
ICs8YnI+DQomZ3Q7wqAgwqAgwqAmZ3Q7ICvCoCDCoCB3aGlsZSAodmlydGlvX3F1ZXVlX2VtcHR5
KHEtJmd0O3J4X3ZxKSB8fDxicj4NCiZndDvCoCDCoCDCoCZndDvCoCDCoCDCoCDCoCDCoCDCoCDC
oCAobi0mZ3Q7bWVyZ2VhYmxlX3J4X2J1ZnMgJmFtcDsmYW1wOzxicj4NCiZndDvCoCDCoCDCoCZn
dDsgLcKgIMKgIMKgIMKgIMKgIMKgIMKgIXZpcnRxdWV1ZV9hdmFpbF9ieXRlcyhxLSZndDtyeF92
cSwgYnVmc2l6ZSwgMCkpKSB7PGJyPg0KJmd0O8KgIMKgIMKgJmd0OyArwqAgwqAgwqAgwqAgwqAg
wqAgIXZpcnRxdWV1ZV9hdmFpbF9ieXRlcyhxLSZndDtyeF92cSwgYnVmc2l6ZSwgMCkpKSB7PGJy
Pg0KJmd0O8KgIMKgIMKgJmd0OyArwqAgwqAgwqAgwqAgLyogZ3Vlc3QgbWF5IGhhdmUgbWFkZSBz
b21lIGJ1ZiwgdHJ5IGFnYWluICovPGJyPg0KJmd0O8KgIMKgIMKgJmd0OyArwqAgwqAgwqAgwqAg
aWYgKHZpcnRpb19xdWV1ZV9zZXRfbm90aWZpY2F0aW9uX2FuZF9jaGVjayhxLSZndDtyeF92cSwg
MSkpIHs8YnI+DQomZ3Q7wqAgwqAgwqAmZ3Q7ICvCoCDCoCDCoCDCoCDCoCDCoCB2aXJ0aW9fcXVl
dWVfc2V0X25vdGlmaWNhdGlvbihxLSZndDtyeF92cSwgMCk7PGJyPg0KJmd0O8KgIMKgIMKgJmd0
OyArwqAgwqAgwqAgwqAgwqAgwqAgY29udGludWU7PGJyPg0KJmd0O8KgIMKgIMKgJmd0OyArwqAg
wqAgwqAgwqAgfSBlbHNlIHs8YnI+DQomZ3Q7wqAgwqAgwqAmZ3Q7wqAgwqAgwqAgwqAgwqAgwqAg
wqAgcmV0dXJuIDA7PGJyPg0KJmd0O8KgIMKgIMKgJmd0O8KgIMKgIMKgIMKgIMKgIH08YnI+DQom
Z3Q7wqAgwqAgwqAmZ3Q7wqAgwqAgwqAgfTxicj4NCiZndDvCoCDCoCDCoCZndDsgZGlmZiAtLWdp
dCBhL2h3L3ZpcnRpby92aXJ0aW8uYyBiL2h3L3ZpcnRpby92aXJ0aW8uYzxicj4NCiZndDvCoCDC
oCDCoCZndDsgaW5kZXggODkzYTA3MmM5ZC4uYjE2NTc2NDAxNyAxMDA2NDQ8YnI+DQomZ3Q7wqAg
wqAgwqAmZ3Q7IC0tLSBhL2h3L3ZpcnRpby92aXJ0aW8uYzxicj4NCiZndDvCoCDCoCDCoCZndDsg
KysrIGIvaHcvdmlydGlvL3ZpcnRpby5jPGJyPg0KJmd0O8KgIMKgIMKgJmd0OyBAQCAtNjY4LDYg
KzY2OCw0NSBAQCBzdGF0aWMgaW5saW5lIGJvb2wgaXNfZGVzY19hdmFpbCh1aW50MTZfdCBmbGFn
cyw8YnI+DQomZ3Q7wqAgwqAgwqBib29sIHdyYXBfY291bnRlcik8YnI+DQomZ3Q7wqAgwqAgwqAm
Z3Q7wqAgwqAgwqAgcmV0dXJuIChhdmFpbCAhPSB1c2VkKSAmYW1wOyZhbXA7IChhdmFpbCA9PSB3
cmFwX2NvdW50ZXIpOzxicj4NCiZndDvCoCDCoCDCoCZndDvCoCB9PGJyPg0KJmd0O8KgIMKgIMKg
Jmd0O8KgPGJyPg0KJmd0O8KgIMKgIMKgJmd0OyArYm9vbCB2aXJ0aW9fcXVldWVfc2V0X25vdGlm
aWNhdGlvbl9hbmRfY2hlY2soVmlydFF1ZXVlICp2cSwgaW50IGVuYWJsZSk8YnI+DQomZ3Q7wqAg
wqAgwqAmZ3Q7ICt7PGJyPg0KJmd0O8KgIMKgIMKgJmd0OyArwqAgwqAgdWludDE2X3Qgc2hhZG93
X2lkeDs8YnI+DQomZ3Q7wqAgwqAgwqAmZ3Q7ICvCoCDCoCBWUmluZ1BhY2tlZERlc2MgZGVzYzs8
YnI+DQomZ3Q7wqAgwqAgwqAmZ3Q7ICvCoCDCoCBWUmluZ01lbW9yeVJlZ2lvbkNhY2hlcyAqY2Fj
aGVzOzxicj4NCiZndDvCoCDCoCDCoCZndDsgKzxicj4NCiZndDvCoCDCoCDCoCZndDsgK8KgIMKg
IHZxLSZndDtub3RpZmljYXRpb24gPSBlbmFibGU7PGJyPg0KJmd0O8KgIMKgIMKgJmd0OyArPGJy
Pg0KJmd0O8KgIMKgIMKgJmd0OyArwqAgwqAgaWYgKCF2cS0mZ3Q7dnJpbmcuZGVzYykgezxicj4N
CiZndDvCoCDCoCDCoCZndDsgK8KgIMKgIMKgIMKgIHJldHVybiBmYWxzZTs8YnI+DQomZ3Q7wqAg
wqAgwqAmZ3Q7ICvCoCDCoCB9PGJyPg0KJmd0O8KgIMKgIMKgJmd0OyArPGJyPg0KJmd0O8KgIMKg
IMKgJmd0OyArwqAgwqAgaWYgKHZpcnRpb192ZGV2X2hhc19mZWF0dXJlKHZxLSZndDt2ZGV2LCBW
SVJUSU9fRl9SSU5HX1BBQ0tFRCkpIHs8YnI+DQomZ3Q7wqAgwqAgwqAmZ3Q7ICvCoCDCoCDCoCDC
oCB2aXJ0aW9fcXVldWVfcGFja2VkX3NldF9ub3RpZmljYXRpb24odnEsIGVuYWJsZSk7PGJyPg0K
Jmd0O8KgIMKgIMKgJmd0OyArPGJyPg0KJmd0O8KgIMKgIMKgJmd0OyArwqAgwqAgwqAgwqAgaWYg
KGVuYWJsZSkgezxicj4NCiZndDvCoCDCoCDCoCZndDsgK8KgIMKgIMKgIMKgIMKgIMKgIGNhY2hl
cyA9IHZyaW5nX2dldF9yZWdpb25fY2FjaGVzKHZxKTs8YnI+DQomZ3Q7wqAgwqAgwqAmZ3Q7ICvC
oCDCoCDCoCDCoCDCoCDCoCBpZiAoIWNhY2hlcykgezxicj4NCiZndDvCoCDCoCDCoCZndDsgK8Kg
IMKgIMKgIMKgIMKgIMKgIMKgIMKgIHJldHVybiBmYWxzZTs8YnI+DQomZ3Q7wqAgwqAgwqAmZ3Q7
ICvCoCDCoCDCoCDCoCDCoCDCoCB9PGJyPg0KJmd0O8KgIMKgIMKgJmd0OyArPGJyPg0KJmd0O8Kg
IMKgIMKgJmd0OyArwqAgwqAgwqAgwqAgwqAgwqAgdnJpbmdfcGFja2VkX2Rlc2NfcmVhZCh2cS0m
Z3Q7dmRldiwgJmFtcDtkZXNjLCAmYW1wO2NhY2hlcy0mZ3Q7ZGVzYyw8YnI+DQomZ3Q7wqAgwqAg
wqAmZ3Q7ICvCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDC
oCDCoHZxLSZndDtzaGFkb3dfYXZhaWxfaWR4LCB0cnVlKTs8YnI+DQomZ3Q7wqAgwqAgwqAmZ3Q7
ICvCoCDCoCDCoCDCoCDCoCDCoCBpZiAoaXNfZGVzY19hdmFpbChkZXNjLmZsYWdzLCB2cS0mZ3Q7
PGJyPg0KJmd0O8KgIMKgIMKgc2hhZG93X2F2YWlsX3dyYXBfY291bnRlcikpIHs8YnI+DQomZ3Q7
wqAgwqAgwqAmZ3Q7ICvCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCByZXR1cm4gdHJ1ZTs8YnI+DQom
Z3Q7wqAgwqAgwqAmZ3Q7ICvCoCDCoCDCoCDCoCDCoCDCoCB9PGJyPg0KJmd0O8KgIMKgIMKgJmd0
OyArwqAgwqAgwqAgwqAgfTxicj4NCiZndDvCoCDCoCDCoCZndDsgK8KgIMKgIH0gZWxzZSB7PGJy
Pg0KJmd0O8KgIMKgIMKgJmd0OyArwqAgwqAgwqAgwqAgc2hhZG93X2lkeCA9IHZxLSZndDtzaGFk
b3dfYXZhaWxfaWR4Ozxicj4NCiZndDvCoCDCoCDCoCZndDsgK8KgIMKgIMKgIMKgIHZpcnRpb19x
dWV1ZV9zcGxpdF9zZXRfbm90aWZpY2F0aW9uKHZxLCBlbmFibGUpOzxicj4NCiZndDvCoCDCoCDC
oCZndDsgKzxicj4NCiZndDvCoCDCoCDCoCZndDsgK8KgIMKgIMKgIMKgIGlmIChlbmFibGUpIHs8
YnI+DQomZ3Q7wqAgwqAgwqAmZ3Q7ICvCoCDCoCDCoCDCoCDCoCDCoCByZXR1cm4gc2hhZG93X2lk
eCAhPSB2cmluZ19hdmFpbF9pZHgodnEpOzxicj4NCiZndDvCoCDCoCDCoCZndDsgK8KgIMKgIMKg
IMKgIH08YnI+DQomZ3Q7wqAgwqAgwqAmZ3Q7ICvCoCDCoCB9PGJyPg0KJmd0O8KgIMKgIMKgJmd0
OyArPGJyPg0KJmd0O8KgIMKgIMKgJmd0OyArwqAgwqAgcmV0dXJuIGZhbHNlOzxicj4NCiZndDvC
oCDCoCDCoCZndDsgK308YnI+DQomZ3Q7IDxicj4NCiZndDvCoCDCoCDCoFBsZWFzZSBkb2N1bWVu
dCB3aGF0IHRoaXMgZG9lcy48YnI+DQomZ3Q7wqAgwqAgwqBTbyB0aGlzIHdpbGwgcmV0dXJuIGZh
bHNlIGlmIHJpbmcgaGFzIGFueSBhdmFpbGFiZSBidWZmZXJzPzxicj4NCiZndDvCoCDCoCDCoEVx
dWl2YWxlbnQgdG86PGJyPg0KJmd0OyA8YnI+DQomZ3Q7wqAgwqAgwqBib29sIHZpcnRpb19xdWV1
ZV9zZXRfbm90aWZpY2F0aW9uX2FuZF9jaGVjayhWaXJ0UXVldWUgKnZxLCBpbnQgZW5hYmxlKTxi
cj4NCiZndDvCoCDCoCDCoHs8YnI+DQomZ3Q7wqAgwqAgwqDCoCDCoCDCoCDCoCB2aXJ0aW9fcXVl
dWVfcGFja2VkX3NldF9ub3RpZmljYXRpb24odnEsIGVuYWJsZSk7PGJyPg0KJmd0O8KgIMKgIMKg
wqAgwqAgwqAgwqAgcmV0dXJuIHZpcnRpb19xdWV1ZV9lbXB0eSh2cSk7PGJyPg0KJmd0O8KgIMKg
IMKgfTxicj4NCiZndDsgPGJyPg0KJmd0OyA8YnI+DQomZ3Q7wqAgwqAgwqBvciBhbSBJIG1pc3Np
bmcgc29tZXRoaW5nPzxicj4NCiZndDsgPGJyPg0KJmd0O8KgIMKgIMKgJmd0OyArPGJyPg0KJmd0
O8KgIMKgIMKgJmd0O8KgIC8qIEZldGNoIGF2YWlsX2lkeCBmcm9tIFZRIG1lbW9yeSBvbmx5IHdo
ZW4gd2UgcmVhbGx5IG5lZWQgdG8ga25vdyBpZjxicj4NCiZndDvCoCDCoCDCoCZndDvCoCDCoCog
Z3Vlc3QgaGFzIGFkZGVkIHNvbWUgYnVmZmVycy48YnI+DQomZ3Q7wqAgwqAgwqAmZ3Q7wqAgwqAq
IENhbGxlZCB3aXRoaW4gcmN1X3JlYWRfbG9jaygpLsKgICovPGJyPg0KJmd0O8KgIMKgIMKgJmd0
OyBkaWZmIC0tZ2l0IGEvaW5jbHVkZS9ody92aXJ0aW8vdmlydGlvLmggYi9pbmNsdWRlL2h3L3Zp
cnRpby92aXJ0aW8uaDxicj4NCiZndDvCoCDCoCDCoCZndDsgaW5kZXggN2Q1ZmZkYzE0NS4uZWQ4
NTAyM2I4NyAxMDA2NDQ8YnI+DQomZ3Q7wqAgwqAgwqAmZ3Q7IC0tLSBhL2luY2x1ZGUvaHcvdmly
dGlvL3ZpcnRpby5oPGJyPg0KJmd0O8KgIMKgIMKgJmd0OyArKysgYi9pbmNsdWRlL2h3L3ZpcnRp
by92aXJ0aW8uaDxicj4NCiZndDvCoCDCoCDCoCZndDsgQEAgLTMwMiw2ICszMDIsNyBAQCB2b2lk
IHZpcnRpb19ub3RpZnlfY29uZmlnKFZpcnRJT0RldmljZSAqdmRldik7PGJyPg0KJmd0O8KgIMKg
IMKgJmd0O8KgPGJyPg0KJmd0O8KgIMKgIMKgJmd0O8KgIGJvb2wgdmlydGlvX3F1ZXVlX2dldF9u
b3RpZmljYXRpb24oVmlydFF1ZXVlICp2cSk7PGJyPg0KJmd0O8KgIMKgIMKgJmd0O8KgIHZvaWQg
dmlydGlvX3F1ZXVlX3NldF9ub3RpZmljYXRpb24oVmlydFF1ZXVlICp2cSwgaW50IGVuYWJsZSk7
PGJyPg0KJmd0O8KgIMKgIMKgJmd0OyArYm9vbCB2aXJ0aW9fcXVldWVfc2V0X25vdGlmaWNhdGlv
bl9hbmRfY2hlY2soVmlydFF1ZXVlICp2cSwgaW50IGVuYWJsZSk7PGJyPg0KJmd0O8KgIMKgIMKg
Jmd0O8KgPGJyPg0KJmd0O8KgIMKgIMKgJmd0O8KgIGludCB2aXJ0aW9fcXVldWVfcmVhZHkoVmly
dFF1ZXVlICp2cSk7PGJyPg0KJmd0O8KgIMKgIMKgJmd0O8KgPGJyPg0KJmd0O8KgIMKgIMKgJmd0
OyAtLTxicj4NCiZndDvCoCDCoCDCoCZndDsgMi4zOS4wPGJyPg0KJmd0OyA8YnI+DQomZ3Q7IDxi
cj4NCjxicj4NCjwvYmxvY2txdW90ZT48L2Rpdj48L2Rpdj4NCg==
--00000000000000e363061c383251--

