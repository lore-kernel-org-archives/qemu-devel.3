Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1371EC2BD09
	for <qemu-devel@archiver.kernel.org>; Mon,  1 Jul 2024 17:19:59 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sOKfo-0007ww-M0; Mon, 01 Jul 2024 13:18:40 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <east.moutain.yang@gmail.com>)
 id 1sOKfl-0007wh-Fo; Mon, 01 Jul 2024 13:18:37 -0400
Received: from mail-wm1-x331.google.com ([2a00:1450:4864:20::331])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <east.moutain.yang@gmail.com>)
 id 1sOKfd-00049h-HZ; Mon, 01 Jul 2024 13:18:37 -0400
Received: by mail-wm1-x331.google.com with SMTP id
 5b1f17b1804b1-4256aee6e4dso24344995e9.1; 
 Mon, 01 Jul 2024 10:18:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1719854307; x=1720459107; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=dEIoazWNFzA65k6gGAfuiS2Kj+lZlSUPT3HYjNA82XA=;
 b=JSB0+NUe4LV618eMbAHKUGVU/ViFTWDGRyuN5dgtR4hEKuTfsPNiPFAtl8zcbH+HKV
 1ksC9dyRLrnqNBuTSzpoZ9rUfZEUvMN16OxuG7OevDy5DqaCj2b6vPohxlnDCyHEUaJs
 OFqqGr/Yk4MIStHqJpQRpzAXn8YN1hapPtm6WCQN8xLoT5ceL0LUHsGddJV+yKd0aKzK
 mS83OrRlnakNoEKBWIOVxCC6fb35LbwXKmkaWAibMv2jHo/MDadkLW7l5I+89UjaKzm5
 U54bajJmEc6l7CVyRTAycL98frgH2KINnPRulAga3deRZb4RY0ur4TG1Ldaoro8Fd01G
 LUOw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1719854307; x=1720459107;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=dEIoazWNFzA65k6gGAfuiS2Kj+lZlSUPT3HYjNA82XA=;
 b=AOeib6bQD8/eHmcCbSBOqaMfE5vzyxLsg4qpu0estNB2NLcyCJcZJirqZ8gE+UR1+T
 /ly5hJQE1B8Pz3G88d+xdTLO3vFYKnHsFjhLGOeSWbVKvSvKBLeOaBwMLLLf1ysEHRQw
 sf99DDKIMePtgDeXGkvMziv8Biva1HsG9Z1DYNieayHomCgaMZ468EaI1z+xEOtArjZN
 FP+l8qtV9lV0lCv6WFGL+jwHAjK8hwcyluZWbqmnXuCH4qRjYpXzANLtsQZa9iyOpJ1V
 q8i2P7nsIQNKd4RmaOydJ0xQvK1ZKVgwkGdhWla8PbZVoZ2t2YBMrIwLimcds2K+eMat
 5dmw==
X-Forwarded-Encrypted: i=1;
 AJvYcCUXNcQq8JqQ+WC0F8VamvPuZNjJXLFLr3+61FnaaF0SCzIft4UUL3gnfDkG1a7zIECKhgBuzlawVlRprE6Cdyr0XRxG+Yh1
X-Gm-Message-State: AOJu0YwbN8FhkTaintZ/zoVsxAyzMRKDbElTIO5gmswHXx/5aRmqCCrY
 AHG7FXECxtiS5ORc1f9tess9IeETWUrnuxDka0Nd1tOMhRlaCrF7Wx5vQgS69EGoU66S1Yd0dCG
 aLsO+Lqn8ZwtyCU1ehrJpKDdnYiDgiqSnyZXjCSGl
X-Google-Smtp-Source: AGHT+IHcM/lkirFQ8sptXMEaCgyxtrVatSpbGJQwVSgc0bLPtJU2Xdf6/XHKVGYR7Ju76T6QugtIIwzXhMIZtRFjnqY=
X-Received: by 2002:a7b:c455:0:b0:425:622f:581f with SMTP id
 5b1f17b1804b1-4257a0282a0mr37834775e9.38.1719854306923; Mon, 01 Jul 2024
 10:18:26 -0700 (PDT)
MIME-Version: 1.0
References: <20240701140017.49223-1-east.moutain.yang@gmail.com>
 <20240701105110-mutt-send-email-mst@kernel.org>
In-Reply-To: <20240701105110-mutt-send-email-mst@kernel.org>
From: Yang Dongshan <east.moutain.yang@gmail.com>
Date: Tue, 2 Jul 2024 01:18:15 +0800
Message-ID: <CALrP2iW7VRLnNmyyM451OiiE3serP1ViT8wvsNCK1CadqKU09Q@mail.gmail.com>
Subject: Re: [PATCH v7] virtio-net: Fix network stall at the host side waiting
 for kick
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: qemu-devel@nongnu.org, jasowang@redhat.com, stefanha@redhat.com, 
 kwolf@redhat.com, hreitz@redhat.com, qemu-stable@nongnu.org
Content-Type: multipart/alternative; boundary="00000000000007a1c0061c32c9e8"
Received-SPF: pass client-ip=2a00:1450:4864:20::331;
 envelope-from=east.moutain.yang@gmail.com; helo=mail-wm1-x331.google.com
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

--00000000000007a1c0061c32c9e8
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

> Please document what this does.
okay, i will.

> So this will return false if ring has any available buffers?
> Equivalent to:
>
> bool virtio_queue_set_notification_and_check(VirtQueue *vq, int enable)
> {
>        virtio_queue_packed_set_notification(vq, enable);
>         return virtio_queue_empty(vq);
> }

No, only when the *shadow_avail_idx *is changed shall the function return
true,
compared with the value seen by the host last time, else return false even
if
there are some buffers available in the queue, as the total size of the
available
buffers in the queue can't satisfy the request.

It maybe better to pass only one arg to the function like this:
bool virtio_queue_set_notification_and_check(VirtQueue *vq)
{
       virtio_queue_packed_set_notification(vq, true);

       return shadow_avail_idx_changed()? true: false;
}

Thanks Michael a lot!

On Mon, Jul 1, 2024 at 11:05=E2=80=AFPM Michael S. Tsirkin <mst@redhat.com>=
 wrote:

> On Mon, Jul 01, 2024 at 10:00:17PM +0800, Wencheng Yang wrote:
> > From: thomas <east.moutain.yang@gmail.com>
> >
> > Patch 06b12970174 ("virtio-net: fix network stall under load")
> > added double-check to test whether the available buffer size
> > can satisfy the request or not, in case the guest has added
> > some buffers to the avail ring simultaneously after the first
> > check. It will be lucky if the available buffer size becomes
> > okay after the double-check, then the host can send the packet
> > to the guest. If the buffer size still can't satisfy the request,
> > even if the guest has added some buffers, viritio-net would
> > stall at the host side forever.
> >
> > The patch checks whether the guest has added some buffers
> > after last check of avail idx when the available buffers are
> > not sufficient, if so then recheck the available buffers
> > in the loop.
> >
> > The patch also reverts patch "06b12970174".
> >
> > The case below can reproduce the stall.
> >
> >                                        Guest 0
> >                                      +--------+
> >                                      | iperf  |
> >                     ---------------> | server |
> >          Host       |                +--------+
> >        +--------+   |                    ...
> >        | iperf  |----
> >        | client |----                  Guest n
> >        +--------+   |                +--------+
> >                     |                | iperf  |
> >                     ---------------> | server |
> >                                      +--------+
> >
> > Boot many guests from qemu with virtio network:
> >  qemu ... -netdev tap,id=3Dnet_x \
> >     -device virtio-net-pci-non-transitional,\
> >     iommu_platform=3Don,mac=3Dxx:xx:xx:xx:xx:xx,netdev=3Dnet_x
> >
> > Each guest acts as iperf server with commands below:
> >  iperf3 -s -D -i 10 -p 8001
> >  iperf3 -s -D -i 10 -p 8002
> >
> > The host as iperf client:
> >  iperf3 -c guest_IP -p 8001 -i 30 -w 256k -P 20 -t 40000
> >  iperf3 -c guest_IP -p 8002 -i 30 -w 256k -P 20 -t 40000
> >
> > After some time, the host loses connection to the guest,
> > the guest can send packet to the host, but can't receive
> > packet from host.
> >
> > It's more likely to happen if SWIOTLB is enabled in the guest,
> > allocating and freeing bounce buffer takes some CPU ticks,
> > copying from/to bounce buffer takes more CPU ticks, compared
> > with that there is no bounce buffer in the guest.
> > Once the rate of producing packets from the host approximates
> > the rate of receiveing packets in the guest, the guest would
> > loop in NAPI.
> >
> >          receive packets    ---
> >                |             |
> >                v             |
> >            free buf      virtnet_poll
> >                |             |
> >                v             |
> >      add buf to avail ring  ---
> >                |
> >                |  need kick the host?
> >                |  NAPI continues
> >                v
> >          receive packets    ---
> >                |             |
> >                v             |
> >            free buf      virtnet_poll
> >                |             |
> >                v             |
> >      add buf to avail ring  ---
> >                |
> >                v
> >               ...           ...
> >
> > On the other hand, the host fetches free buf from avail
> > ring, if the buf in the avail ring is not enough, the
> > host notifies the guest the event by writing the avail
> > idx read from avail ring to the event idx of used ring,
> > then the host goes to sleep, waiting for the kick signal
> > from the guest.
> >
> > Once the guest finds the host is waiting for kick singal
> > (in virtqueue_kick_prepare_split()), it kicks the host.
> >
> > The host may stall forever at the sequences below:
> >
> >          Host                        Guest
> >      ------------                 -----------
> >  fetch buf, send packet           receive packet ---
> >          ...                          ...         |
> >  fetch buf, send packet             add buf       |
> >          ...                        add buf   virtnet_poll
> >     buf not enough      avail idx-> add buf       |
> >     read avail idx                  add buf       |
> >                                     add buf      ---
> >                                   receive packet ---
> >     write event idx                   ...         |
> >     wait for kick                   add buf   virtnet_poll
> >                                       ...         |
> >                                                  ---
> >                                  no more packet, exit NAPI
> >
> > In the first loop of NAPI above, indicated in the range of
> > virtnet_poll above, the host is sending packets while the
> > guest is receiving packets and adding buffers.
> >  step 1: The buf is not enough, for example, a big packet
> >          needs 5 buf, but the available buf count is 3.
> >          The host read current avail idx.
> >  step 2: The guest adds some buf, then checks whether the
> >          host is waiting for kick signal, not at this time.
> >          The used ring is not empty, the guest continues
> >          the second loop of NAPI.
> >  step 3: The host writes the avail idx read from avail
> >          ring to used ring as event idx via
> >          virtio_queue_set_notification(q->rx_vq, 1).
> >  step 4: At the end of the second loop of NAPI, recheck
> >          whether kick is needed, as the event idx in the
> >          used ring written by the host is beyound the
> >          range of kick condition, the guest will not
> >          send kick signal to the host.
> >
> > Fixes: 06b12970174 ("virtio-net: fix network stall under load")
> > Signed-off-by: Wencheng Yang <east.moutain.yang@gmail.com>
> > ---
> >
> > Changelog:
> > v7:
> > - Add function virtio_queue_set_notification_and_check()
> > - Restore the function sequence introduce in v6
> >
> > v6:
> > - Take packed packed queue into cosideration
> > - Adjust function sequence to fix compilation issue
> >
> > v5:
> > - Modify return type of virtio_queue_set_notification() to
> >   bool to indicate whether the guest has added some buffers
> >   after last check of avail idx
> > - Loop in virtio_net_has_buffers() if the available buffers
> >   are not sufficient and the guest has added some buffers.
> > - Revert patch "06b12970174"
> > - Update the subject
> >
> > v4:
> > - Correct spelling mistake in the subject
> > - Describe the issue that virtio-net is blocked at host side
> >
> > v3:
> > - Add virtio-net tag in the subject
> > - Refine commit log
> >
> > v2:
> > - Add SOB tag at the end of the commit message
> > - Place Fixes tag at the end of the commit message
> >
> > v1:
> > - Initial patch
> >
> >  hw/net/virtio-net.c        | 19 ++++++++-----------
> >  hw/virtio/virtio.c         | 39 ++++++++++++++++++++++++++++++++++++++
> >  include/hw/virtio/virtio.h |  1 +
> >  3 files changed, 48 insertions(+), 11 deletions(-)
> >
> > diff --git a/hw/net/virtio-net.c b/hw/net/virtio-net.c
> > index 9c7e85caea..357c651d9b 100644
> > --- a/hw/net/virtio-net.c
> > +++ b/hw/net/virtio-net.c
> > @@ -1642,18 +1642,15 @@ static bool
> virtio_net_can_receive(NetClientState *nc)
> >  static int virtio_net_has_buffers(VirtIONetQueue *q, int bufsize)
> >  {
> >      VirtIONet *n =3D q->n;
> > -    if (virtio_queue_empty(q->rx_vq) ||
> > -        (n->mergeable_rx_bufs &&
> > -         !virtqueue_avail_bytes(q->rx_vq, bufsize, 0))) {
> > -        virtio_queue_set_notification(q->rx_vq, 1);
> > -
> > -        /* To avoid a race condition where the guest has made some
> buffers
> > -         * available after the above check but before notification was
> > -         * enabled, check for available buffers again.
> > -         */
> > -        if (virtio_queue_empty(q->rx_vq) ||
> > +
> > +    while (virtio_queue_empty(q->rx_vq) ||
> >              (n->mergeable_rx_bufs &&
> > -             !virtqueue_avail_bytes(q->rx_vq, bufsize, 0))) {
> > +            !virtqueue_avail_bytes(q->rx_vq, bufsize, 0))) {
> > +        /* guest may have made some buf, try again */
> > +        if (virtio_queue_set_notification_and_check(q->rx_vq, 1)) {
> > +            virtio_queue_set_notification(q->rx_vq, 0);
> > +            continue;
> > +        } else {
> >              return 0;
> >          }
> >      }
> > diff --git a/hw/virtio/virtio.c b/hw/virtio/virtio.c
> > index 893a072c9d..b165764017 100644
> > --- a/hw/virtio/virtio.c
> > +++ b/hw/virtio/virtio.c
> > @@ -668,6 +668,45 @@ static inline bool is_desc_avail(uint16_t flags,
> bool wrap_counter)
> >      return (avail !=3D used) && (avail =3D=3D wrap_counter);
> >  }
> >
> > +bool virtio_queue_set_notification_and_check(VirtQueue *vq, int enable=
)
> > +{
> > +    uint16_t shadow_idx;
> > +    VRingPackedDesc desc;
> > +    VRingMemoryRegionCaches *caches;
> > +
> > +    vq->notification =3D enable;
> > +
> > +    if (!vq->vring.desc) {
> > +        return false;
> > +    }
> > +
> > +    if (virtio_vdev_has_feature(vq->vdev, VIRTIO_F_RING_PACKED)) {
> > +        virtio_queue_packed_set_notification(vq, enable);
> > +
> > +        if (enable) {
> > +            caches =3D vring_get_region_caches(vq);
> > +            if (!caches) {
> > +                return false;
> > +            }
> > +
> > +            vring_packed_desc_read(vq->vdev, &desc, &caches->desc,
> > +                                   vq->shadow_avail_idx, true);
> > +            if (is_desc_avail(desc.flags,
> vq->shadow_avail_wrap_counter)) {
> > +                return true;
> > +            }
> > +        }
> > +    } else {
> > +        shadow_idx =3D vq->shadow_avail_idx;
> > +        virtio_queue_split_set_notification(vq, enable);
> > +
> > +        if (enable) {
> > +            return shadow_idx !=3D vring_avail_idx(vq);
> > +        }
> > +    }
> > +
> > +    return false;
> > +}
>
> Please document what this does.
> So this will return false if ring has any availabe buffers?
> Equivalent to:
>
> bool virtio_queue_set_notification_and_check(VirtQueue *vq, int enable)
> {
>         virtio_queue_packed_set_notification(vq, enable);
>         return virtio_queue_empty(vq);
> }
>
>
> or am I missing something?
>
> > +
> >  /* Fetch avail_idx from VQ memory only when we really need to know if
> >   * guest has added some buffers.
> >   * Called within rcu_read_lock().  */
> > diff --git a/include/hw/virtio/virtio.h b/include/hw/virtio/virtio.h
> > index 7d5ffdc145..ed85023b87 100644
> > --- a/include/hw/virtio/virtio.h
> > +++ b/include/hw/virtio/virtio.h
> > @@ -302,6 +302,7 @@ void virtio_notify_config(VirtIODevice *vdev);
> >
> >  bool virtio_queue_get_notification(VirtQueue *vq);
> >  void virtio_queue_set_notification(VirtQueue *vq, int enable);
> > +bool virtio_queue_set_notification_and_check(VirtQueue *vq, int enable=
);
> >
> >  int virtio_queue_ready(VirtQueue *vq);
> >
> > --
> > 2.39.0
>
>

--00000000000007a1c0061c32c9e8
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr">&gt; Please document what this does.<div>okay, i will.</di=
v><div><br></div><div>&gt; So this will return false if ring has any availa=
ble buffers?</div>&gt; Equivalent to:<br>&gt;=C2=A0<br>&gt; bool virtio_que=
ue_set_notification_and_check(VirtQueue *vq, int enable)<br>&gt; {<br>&gt;=
=C2=A0 =C2=A0 =C2=A0 =C2=A0 virtio_queue_packed_set_notification(vq, enable=
);<br>&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0return virtio_queue_empty(vq);<=
br>&gt; }<br><div><br></div><div>No, only when the=C2=A0<i style=3D"color:r=
gb(0,0,0)">shadow_avail_idx </i><span style=3D"color:rgb(0,0,0)">is changed=
=C2=A0</span>shall the=C2=A0function return true,</div><div><span style=3D"=
color:rgb(0,0,0)">compared with the value=C2=A0</span><span style=3D"color:=
rgb(0,0,0)">seen by the host last time,=C2=A0</span>else return false even =
if</div><div>there are some buffers available in the queue, as the total si=
ze of the available</div><div>buffers in the queue can&#39;t satisfy the re=
quest.</div><div><br></div><div>It maybe better to pass only one arg to the=
 function like this:</div><div>bool virtio_queue_set_notification_and_check=
(VirtQueue *vq)<br>{<br>=C2=A0 =C2=A0 =C2=A0 =C2=A0virtio_queue_packed_set_=
notification(vq, true);<br>=C2=A0 =C2=A0 =C2=A0 =C2=A0</div><div>=C2=A0 =C2=
=A0 =C2=A0 =C2=A0return shadow_avail_idx_changed()? true: false;<br>}<br></=
div><div><br></div><div>Thanks Michael a lot!</div></div><br><div class=3D"=
gmail_quote"><div dir=3D"ltr" class=3D"gmail_attr">On Mon, Jul 1, 2024 at 1=
1:05=E2=80=AFPM Michael S. Tsirkin &lt;<a href=3D"mailto:mst@redhat.com">ms=
t@redhat.com</a>&gt; wrote:<br></div><blockquote class=3D"gmail_quote" styl=
e=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);paddin=
g-left:1ex">On Mon, Jul 01, 2024 at 10:00:17PM +0800, Wencheng Yang wrote:<=
br>
&gt; From: thomas &lt;<a href=3D"mailto:east.moutain.yang@gmail.com" target=
=3D"_blank">east.moutain.yang@gmail.com</a>&gt;<br>
&gt; <br>
&gt; Patch 06b12970174 (&quot;virtio-net: fix network stall under load&quot=
;)<br>
&gt; added double-check to test whether the available buffer size<br>
&gt; can satisfy the request or not, in case the guest has added<br>
&gt; some buffers to the avail ring simultaneously after the first<br>
&gt; check. It will be lucky if the available buffer size becomes<br>
&gt; okay after the double-check, then the host can send the packet<br>
&gt; to the guest. If the buffer size still can&#39;t satisfy the request,<=
br>
&gt; even if the guest has added some buffers, viritio-net would<br>
&gt; stall at the host side forever.<br>
&gt; <br>
&gt; The patch checks whether the guest has added some buffers<br>
&gt; after last check of avail idx when the available buffers are<br>
&gt; not sufficient, if so then recheck the available buffers<br>
&gt; in the loop.<br>
&gt; <br>
&gt; The patch also reverts patch &quot;06b12970174&quot;.<br>
&gt; <br>
&gt; The case below can reproduce the stall.<br>
&gt; <br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 Guest=
 0<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 +--------+<b=
r>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 | iperf=C2=
=A0 |<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0---------------&gt; | server |<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 Host=C2=A0 =C2=A0 =C2=A0 =C2=A0|=C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 +--------+<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 +--------+=C2=A0 =C2=A0|=C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 ...<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 | iperf=C2=A0 |----<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 | client |----=C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 Guest n<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 +--------+=C2=A0 =C2=A0|=C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 +--------+<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0|=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 | iperf=C2=
=A0 |<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0---------------&gt; | server |<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 +--------+<b=
r>
&gt; <br>
&gt; Boot many guests from qemu with virtio network:<br>
&gt;=C2=A0 qemu ... -netdev tap,id=3Dnet_x \<br>
&gt;=C2=A0 =C2=A0 =C2=A0-device virtio-net-pci-non-transitional,\<br>
&gt;=C2=A0 =C2=A0 =C2=A0iommu_platform=3Don,mac=3Dxx:xx:xx:xx:xx:xx,netdev=
=3Dnet_x<br>
&gt; <br>
&gt; Each guest acts as iperf server with commands below:<br>
&gt;=C2=A0 iperf3 -s -D -i 10 -p 8001<br>
&gt;=C2=A0 iperf3 -s -D -i 10 -p 8002<br>
&gt; <br>
&gt; The host as iperf client:<br>
&gt;=C2=A0 iperf3 -c guest_IP -p 8001 -i 30 -w 256k -P 20 -t 40000<br>
&gt;=C2=A0 iperf3 -c guest_IP -p 8002 -i 30 -w 256k -P 20 -t 40000<br>
&gt; <br>
&gt; After some time, the host loses connection to the guest,<br>
&gt; the guest can send packet to the host, but can&#39;t receive<br>
&gt; packet from host.<br>
&gt; <br>
&gt; It&#39;s more likely to happen if SWIOTLB is enabled in the guest,<br>
&gt; allocating and freeing bounce buffer takes some CPU ticks,<br>
&gt; copying from/to bounce buffer takes more CPU ticks, compared<br>
&gt; with that there is no bounce buffer in the guest.<br>
&gt; Once the rate of producing packets from the host approximates<br>
&gt; the rate of receiveing packets in the guest, the guest would<br>
&gt; loop in NAPI.<br>
&gt; <br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 receive packets=C2=A0 =C2=A0 ---<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 |=C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0|<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 v=C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0|<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 free buf=C2=A0 =C2=A0 =C2=A0 =
virtnet_poll<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 |=C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0|<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 v=C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0|<br>
&gt;=C2=A0 =C2=A0 =C2=A0 add buf to avail ring=C2=A0 ---<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 |<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 |=C2=A0 need ki=
ck the host?<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 |=C2=A0 NAPI co=
ntinues<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 v<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 receive packets=C2=A0 =C2=A0 ---<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 |=C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0|<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 v=C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0|<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 free buf=C2=A0 =C2=A0 =C2=A0 =
virtnet_poll<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 |=C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0|<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 v=C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0|<br>
&gt;=C2=A0 =C2=A0 =C2=A0 add buf to avail ring=C2=A0 ---<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 |<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 v<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0...=C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0...<br>
&gt; <br>
&gt; On the other hand, the host fetches free buf from avail<br>
&gt; ring, if the buf in the avail ring is not enough, the<br>
&gt; host notifies the guest the event by writing the avail<br>
&gt; idx read from avail ring to the event idx of used ring,<br>
&gt; then the host goes to sleep, waiting for the kick signal<br>
&gt; from the guest.<br>
&gt; <br>
&gt; Once the guest finds the host is waiting for kick singal<br>
&gt; (in virtqueue_kick_prepare_split()), it kicks the host.<br>
&gt; <br>
&gt; The host may stall forever at the sequences below:<br>
&gt; <br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 Host=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 Guest<br>
&gt;=C2=A0 =C2=A0 =C2=A0 ------------=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0-----------<br>
&gt;=C2=A0 fetch buf, send packet=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0r=
eceive packet ---<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 ...=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 ...=C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0|<br>
&gt;=C2=A0 fetch buf, send packet=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0add buf=C2=A0 =C2=A0 =C2=A0 =C2=A0|<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 ...=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 add buf=C2=A0 =C2=A0vi=
rtnet_poll<br>
&gt;=C2=A0 =C2=A0 =C2=A0buf not enough=C2=A0 =C2=A0 =C2=A0 avail idx-&gt; a=
dd buf=C2=A0 =C2=A0 =C2=A0 =C2=A0|<br>
&gt;=C2=A0 =C2=A0 =C2=A0read avail idx=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 add buf=C2=A0 =C2=A0 =C2=A0 =C2=A0|<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0add buf=C2=A0=
 =C2=A0 =C2=A0 ---<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0receive packet ---<b=
r>
&gt;=C2=A0 =C2=A0 =C2=A0write event idx=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0...=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0|<br=
>
&gt;=C2=A0 =C2=A0 =C2=A0wait for kick=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0add buf=C2=A0 =C2=A0virtnet_poll<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0...=C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0|<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 ---<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 no more packet, exit NAPI<=
br>
&gt; <br>
&gt; In the first loop of NAPI above, indicated in the range of<br>
&gt; virtnet_poll above, the host is sending packets while the<br>
&gt; guest is receiving packets and adding buffers.<br>
&gt;=C2=A0 step 1: The buf is not enough, for example, a big packet<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 needs 5 buf, but the available buf c=
ount is 3.<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 The host read current avail idx.<br>
&gt;=C2=A0 step 2: The guest adds some buf, then checks whether the<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 host is waiting for kick signal, not=
 at this time.<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 The used ring is not empty, the gues=
t continues<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 the second loop of NAPI.<br>
&gt;=C2=A0 step 3: The host writes the avail idx read from avail<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 ring to used ring as event idx via<b=
r>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 virtio_queue_set_notification(q-&gt;=
rx_vq, 1).<br>
&gt;=C2=A0 step 4: At the end of the second loop of NAPI, recheck<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 whether kick is needed, as the event=
 idx in the<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 used ring written by the host is bey=
ound the<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 range of kick condition, the guest w=
ill not<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 send kick signal to the host.<br>
&gt; <br>
&gt; Fixes: 06b12970174 (&quot;virtio-net: fix network stall under load&quo=
t;)<br>
&gt; Signed-off-by: Wencheng Yang &lt;<a href=3D"mailto:east.moutain.yang@g=
mail.com" target=3D"_blank">east.moutain.yang@gmail.com</a>&gt;<br>
&gt; ---<br>
&gt; <br>
&gt; Changelog:<br>
&gt; v7:<br>
&gt; - Add function virtio_queue_set_notification_and_check()<br>
&gt; - Restore the function sequence introduce in v6<br>
&gt; <br>
&gt; v6:<br>
&gt; - Take packed packed queue into cosideration<br>
&gt; - Adjust function sequence to fix compilation issue<br>
&gt; <br>
&gt; v5:<br>
&gt; - Modify return type of virtio_queue_set_notification() to<br>
&gt;=C2=A0 =C2=A0bool to indicate whether the guest has added some buffers<=
br>
&gt;=C2=A0 =C2=A0after last check of avail idx<br>
&gt; - Loop in virtio_net_has_buffers() if the available buffers<br>
&gt;=C2=A0 =C2=A0are not sufficient and the guest has added some buffers.<b=
r>
&gt; - Revert patch &quot;06b12970174&quot;<br>
&gt; - Update the subject<br>
&gt; <br>
&gt; v4:<br>
&gt; - Correct spelling mistake in the subject<br>
&gt; - Describe the issue that virtio-net is blocked at host side<br>
&gt; <br>
&gt; v3:<br>
&gt; - Add virtio-net tag in the subject<br>
&gt; - Refine commit log<br>
&gt; <br>
&gt; v2:<br>
&gt; - Add SOB tag at the end of the commit message<br>
&gt; - Place Fixes tag at the end of the commit message<br>
&gt; <br>
&gt; v1:<br>
&gt; - Initial patch<br>
&gt; <br>
&gt;=C2=A0 hw/net/virtio-net.c=C2=A0 =C2=A0 =C2=A0 =C2=A0 | 19 ++++++++----=
-------<br>
&gt;=C2=A0 hw/virtio/virtio.c=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0| 39 +++++++=
+++++++++++++++++++++++++++++++<br>
&gt;=C2=A0 include/hw/virtio/virtio.h |=C2=A0 1 +<br>
&gt;=C2=A0 3 files changed, 48 insertions(+), 11 deletions(-)<br>
&gt; <br>
&gt; diff --git a/hw/net/virtio-net.c b/hw/net/virtio-net.c<br>
&gt; index 9c7e85caea..357c651d9b 100644<br>
&gt; --- a/hw/net/virtio-net.c<br>
&gt; +++ b/hw/net/virtio-net.c<br>
&gt; @@ -1642,18 +1642,15 @@ static bool virtio_net_can_receive(NetClientSt=
ate *nc)<br>
&gt;=C2=A0 static int virtio_net_has_buffers(VirtIONetQueue *q, int bufsize=
)<br>
&gt;=C2=A0 {<br>
&gt;=C2=A0 =C2=A0 =C2=A0 VirtIONet *n =3D q-&gt;n;<br>
&gt; -=C2=A0 =C2=A0 if (virtio_queue_empty(q-&gt;rx_vq) ||<br>
&gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0 (n-&gt;mergeable_rx_bufs &amp;&amp;<br>
&gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0!virtqueue_avail_bytes(q-&gt;rx_vq,=
 bufsize, 0))) {<br>
&gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0 virtio_queue_set_notification(q-&gt;rx_vq=
, 1);<br>
&gt; -<br>
&gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0 /* To avoid a race condition where the gu=
est has made some buffers<br>
&gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0* available after the above check b=
ut before notification was<br>
&gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0* enabled, check for available buff=
ers again.<br>
&gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0*/<br>
&gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0 if (virtio_queue_empty(q-&gt;rx_vq) ||<br=
>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 while (virtio_queue_empty(q-&gt;rx_vq) ||<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 (n-&gt;mergeable_rx_bu=
fs &amp;&amp;<br>
&gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0!virtqueue_avail_byte=
s(q-&gt;rx_vq, bufsize, 0))) {<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 !virtqueue_avail_bytes(q-&g=
t;rx_vq, bufsize, 0))) {<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 /* guest may have made some buf, try agai=
n */<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 if (virtio_queue_set_notification_and_che=
ck(q-&gt;rx_vq, 1)) {<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 virtio_queue_set_notificati=
on(q-&gt;rx_vq, 0);<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 continue;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 } else {<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 return 0;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 }<br>
&gt;=C2=A0 =C2=A0 =C2=A0 }<br>
&gt; diff --git a/hw/virtio/virtio.c b/hw/virtio/virtio.c<br>
&gt; index 893a072c9d..b165764017 100644<br>
&gt; --- a/hw/virtio/virtio.c<br>
&gt; +++ b/hw/virtio/virtio.c<br>
&gt; @@ -668,6 +668,45 @@ static inline bool is_desc_avail(uint16_t flags, =
bool wrap_counter)<br>
&gt;=C2=A0 =C2=A0 =C2=A0 return (avail !=3D used) &amp;&amp; (avail =3D=3D =
wrap_counter);<br>
&gt;=C2=A0 }<br>
&gt;=C2=A0 <br>
&gt; +bool virtio_queue_set_notification_and_check(VirtQueue *vq, int enabl=
e)<br>
&gt; +{<br>
&gt; +=C2=A0 =C2=A0 uint16_t shadow_idx;<br>
&gt; +=C2=A0 =C2=A0 VRingPackedDesc desc;<br>
&gt; +=C2=A0 =C2=A0 VRingMemoryRegionCaches *caches;<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 vq-&gt;notification =3D enable;<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 if (!vq-&gt;vring.desc) {<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 return false;<br>
&gt; +=C2=A0 =C2=A0 }<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 if (virtio_vdev_has_feature(vq-&gt;vdev, VIRTIO_F_RING_=
PACKED)) {<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 virtio_queue_packed_set_notification(vq, =
enable);<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 if (enable) {<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 caches =3D vring_get_region=
_caches(vq);<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 if (!caches) {<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 return false;=
<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 }<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 vring_packed_desc_read(vq-&=
gt;vdev, &amp;desc, &amp;caches-&gt;desc,<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0vq-&gt;shadow_avail=
_idx, true);<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 if (is_desc_avail(desc.flag=
s, vq-&gt;shadow_avail_wrap_counter)) {<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 return true;<=
br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 }<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 }<br>
&gt; +=C2=A0 =C2=A0 } else {<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 shadow_idx =3D vq-&gt;shadow_avail_idx;<b=
r>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 virtio_queue_split_set_notification(vq, e=
nable);<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 if (enable) {<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 return shadow_idx !=3D vrin=
g_avail_idx(vq);<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 }<br>
&gt; +=C2=A0 =C2=A0 }<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 return false;<br>
&gt; +}<br>
<br>
Please document what this does.<br>
So this will return false if ring has any availabe buffers?<br>
Equivalent to:<br>
<br>
bool virtio_queue_set_notification_and_check(VirtQueue *vq, int enable)<br>
{<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 virtio_queue_packed_set_notification(vq, enable=
);<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 return virtio_queue_empty(vq);<br>
}<br>
<br>
<br>
or am I missing something?<br>
<br>
&gt; +<br>
&gt;=C2=A0 /* Fetch avail_idx from VQ memory only when we really need to kn=
ow if<br>
&gt;=C2=A0 =C2=A0* guest has added some buffers.<br>
&gt;=C2=A0 =C2=A0* Called within rcu_read_lock().=C2=A0 */<br>
&gt; diff --git a/include/hw/virtio/virtio.h b/include/hw/virtio/virtio.h<b=
r>
&gt; index 7d5ffdc145..ed85023b87 100644<br>
&gt; --- a/include/hw/virtio/virtio.h<br>
&gt; +++ b/include/hw/virtio/virtio.h<br>
&gt; @@ -302,6 +302,7 @@ void virtio_notify_config(VirtIODevice *vdev);<br>
&gt;=C2=A0 <br>
&gt;=C2=A0 bool virtio_queue_get_notification(VirtQueue *vq);<br>
&gt;=C2=A0 void virtio_queue_set_notification(VirtQueue *vq, int enable);<b=
r>
&gt; +bool virtio_queue_set_notification_and_check(VirtQueue *vq, int enabl=
e);<br>
&gt;=C2=A0 <br>
&gt;=C2=A0 int virtio_queue_ready(VirtQueue *vq);<br>
&gt;=C2=A0 <br>
&gt; -- <br>
&gt; 2.39.0<br>
<br>
</blockquote></div>

--00000000000007a1c0061c32c9e8--

