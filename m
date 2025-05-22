Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BEE63C54E65
	for <qemu-devel@archiver.kernel.org>; Thu, 22 May 2025 01:52:20 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uHv5e-0006cD-Ga; Wed, 21 May 2025 21:51:22 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jasowang@redhat.com>)
 id 1uHv5a-0006bu-AX
 for qemu-devel@nongnu.org; Wed, 21 May 2025 21:51:18 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jasowang@redhat.com>)
 id 1uHv5X-0004td-UD
 for qemu-devel@nongnu.org; Wed, 21 May 2025 21:51:18 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1747878673;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=erBulIA8UiHc45nZ2VN32QR1WwXOqAOjvDikG29BQn0=;
 b=Gy38/DAkbth4scyx6uXQWlUj/cbpvxlcFl+2hUtrHMrN5mAht50zFHqzszJhZWJJHJZvZk
 rEIDscRk91gCZo8/+VvSEVjnAmhDuFFPb5WAZ9b56Weu9k9GMY/nKUV84N62GJvbawt/rh
 6uLYhgZOx1j0mlr5WZ9ps7SL84PLzFQ=
Received: from mail-pj1-f72.google.com (mail-pj1-f72.google.com
 [209.85.216.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-552-SBPAu76KOfGJfP70Lwlb5w-1; Wed, 21 May 2025 21:51:12 -0400
X-MC-Unique: SBPAu76KOfGJfP70Lwlb5w-1
X-Mimecast-MFC-AGG-ID: SBPAu76KOfGJfP70Lwlb5w_1747878671
Received: by mail-pj1-f72.google.com with SMTP id
 98e67ed59e1d1-30ebd48a3c7so4693193a91.1
 for <qemu-devel@nongnu.org>; Wed, 21 May 2025 18:51:12 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1747878671; x=1748483471;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=erBulIA8UiHc45nZ2VN32QR1WwXOqAOjvDikG29BQn0=;
 b=cd2tZmtmMJGHCvJaYdyIY1jdr2fraPiSB2p6/UeHos8sDFPMRuKc8lrDSROs4MjV8Y
 fhgQIPvXS68yn2GeKZroCzfsgRjie4Cqog0CzvVNIolWc3w/1VPfk2RoZtIPpavZZj3A
 T7w2IRMy0gCAriqTjUfX+1vvF47RZN0kRMRcDrPkFYwIDRjr8fT98Ir0pETahrrwQvcw
 qLuCIO2oeJ5gySpHyEEW+slLP8RUoOUIlSuCUjrXMbv5GLCPGvcb8KyTI9u/1eY8Gen+
 Hm7122K1qtdsm0hHKucM7HD0NFdNgq9VAymDQaDE6anRQLdBH3HU3iZaZgADS0jizL7G
 lokw==
X-Gm-Message-State: AOJu0Yy75oaYv0c+Z3mNsqfn3xP6BDEWFNQIHKbCZc2CYAAm4miXK+Du
 c379tYxiw3ptjJhXbGiaRHRH/k6yQefplfj7+YRzMBXyX8I1+cKvvFNt7Ag3Rs49I/GNZyMMxxb
 G8zHph2ShKM+n+RgBvyxYyT3vWNw4UYbtVf6w4B+yDt/r0gCv++kut2ngZ2wYj58FFleOKbD0am
 Qb3mouGLnS7jvGV0M80Sq4L0odMiOc4XY=
X-Gm-Gg: ASbGncs4j43dHCKHr1zN2C9iSXgKzxahWs2L4b4bCyy7iZcuWB9fdyznjaIrCLKoasd
 7cDTNTW4IK5ooFFTFyETq4R68gvScirrbxYFwBkvuGXFb8q57zfXoFzQv8pEMUDJQuVsiLw==
X-Received: by 2002:a17:90b:2f85:b0:30e:8f60:b53 with SMTP id
 98e67ed59e1d1-30e8f600d9bmr28445142a91.19.1747878671247; 
 Wed, 21 May 2025 18:51:11 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHAjx+5x3HG9wTMJvOznIfa4I4mDXyV1ELCeCdwnTRCjU7jy5yMT9Ls/pS7j+kH+VRGIE8wqfj4XaEbKfuGOms=
X-Received: by 2002:a17:90b:2f85:b0:30e:8f60:b53 with SMTP id
 98e67ed59e1d1-30e8f600d9bmr28445099a91.19.1747878670762; Wed, 21 May 2025
 18:51:10 -0700 (PDT)
MIME-Version: 1.0
References: <20250510-n-v1-1-19ee26ac3ca6@daynix.com>
 <CACGkMEt7xoX-HvV1mOo=zqpyV0se2ELBMvNV-uGpKUZPQ-PB2A@mail.gmail.com>
 <f3d10b18-9755-46af-9623-fb0ed7d99c51@daynix.com>
 <CACGkMEu_hyc-mP4zk9kJprCpFQbVzO0D2SEMy9eid5TmUH7Uaw@mail.gmail.com>
 <7f1c31de-de22-4290-a4fd-44e523477ca5@daynix.com>
 <CACGkMEsPb6TdT5qx9CkNOeT3ScJmS8_-FDjGh916fi8pWkuxNQ@mail.gmail.com>
 <f299600a-cf0b-47e4-85d1-5c3d1b4eaef0@daynix.com>
In-Reply-To: <f299600a-cf0b-47e4-85d1-5c3d1b4eaef0@daynix.com>
From: Jason Wang <jasowang@redhat.com>
Date: Thu, 22 May 2025 09:50:59 +0800
X-Gm-Features: AX0GCFuq49unf2hu55AcjgbRC9o9Vsq_ustdOItQx7Ol2BdVTD3OTSzyNhn8cbE
Message-ID: <CACGkMEvEoZsdQh10ofOq4S-ZOJ7orJBK5MzDZ_0mV0f-Y=POFg@mail.gmail.com>
Subject: Re: [PATCH] virtio-net: Add queues for RSS during migration
To: Akihiko Odaki <akihiko.odaki@daynix.com>
Cc: qemu-devel@nongnu.org, "Michael S. Tsirkin" <mst@redhat.com>,
 devel@daynix.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=170.10.133.124; envelope-from=jasowang@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -22
X-Spam_score: -2.3
X-Spam_bar: --
X-Spam_report: (-2.3 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.184,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
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

On Wed, May 21, 2025 at 11:51=E2=80=AFAM Akihiko Odaki <akihiko.odaki@dayni=
x.com> wrote:
>
> On 2025/05/21 9:51, Jason Wang wrote:
> > On Fri, May 16, 2025 at 11:29=E2=80=AFAM Akihiko Odaki <akihiko.odaki@d=
aynix.com> wrote:
> >>
> >> On 2025/05/16 10:44, Jason Wang wrote:
> >>> On Wed, May 14, 2025 at 2:58=E2=80=AFPM Akihiko Odaki <akihiko.odaki@=
daynix.com> wrote:
> >>>>
> >>>> On 2025/05/14 14:05, 'Jason Wang' via devel wrote:
> >>>>> On Sat, May 10, 2025 at 3:24=E2=80=AFPM Akihiko Odaki <akihiko.odak=
i@daynix.com> wrote:
> >>>>>>
> >>>>>> virtio_net_pre_load_queues() inspects vdev->guest_features to tell=
 if
> >>>>>> VIRTIO_NET_F_RSS or VIRTIO_NET_F_MQ is enabled to infer the requir=
ed
> >>>>>> number of queues. This works for VIRTIO_NET_F_MQ but it doesn't fo=
r
> >>>>>> VIRTIO_NET_F_RSS because only the lowest 32 bits of vdev->guest_fe=
atures
> >>>>>> is set at the point and VIRTIO_NET_F_RSS uses bit 60 while
> >>>>>> VIRTIO_NET_F_MQ uses bit 22.
> >>>>>>
> >>>>>> Instead of inferring the required number of queues from
> >>>>>> vdev->guest_features, use the number loaded from the vm state.
> >>>>>>
> >>>>>> Fixes: 8c49756825da ("virtio-net: Add only one queue pair when rea=
lizing")
> >>>>>> Signed-off-by: Akihiko Odaki <akihiko.odaki@daynix.com>
> >>>>>> ---
> >>>>>>     include/hw/virtio/virtio.h |  2 +-
> >>>>>>     hw/net/virtio-net.c        | 11 ++++-------
> >>>>>>     hw/virtio/virtio.c         | 14 +++++++-------
> >>>>>>     3 files changed, 12 insertions(+), 15 deletions(-)
> >>>>>>
> >>>>>> diff --git a/include/hw/virtio/virtio.h b/include/hw/virtio/virtio=
.h
> >>>>>> index 638691028050..af52580c1e63 100644
> >>>>>> --- a/include/hw/virtio/virtio.h
> >>>>>> +++ b/include/hw/virtio/virtio.h
> >>>>>> @@ -211,7 +211,7 @@ struct VirtioDeviceClass {
> >>>>>>         int (*start_ioeventfd)(VirtIODevice *vdev);
> >>>>>>         void (*stop_ioeventfd)(VirtIODevice *vdev);
> >>>>>>         /* Called before loading queues. Useful to add queues befo=
re loading. */
> >>>>>> -    int (*pre_load_queues)(VirtIODevice *vdev);
> >>>>>> +    int (*pre_load_queues)(VirtIODevice *vdev, uint32_t n);
> >>>>>
> >>>>> This turns out to be tricky as it has a lot of assumptions as
> >>>>> described in the changelog (e.g only lower 32bit of guest_features =
is
> >>>>> correct etc when calling this function).
> >>>>
> >>>> The problem is that I missed the following comment in
> >>>> hw/virtio/virtio.c:
> >>>>        /*
> >>>>         * Temporarily set guest_features low bits - needed by
> >>>>         * virtio net load code testing for VIRTIO_NET_F_CTRL_GUEST_O=
FFLOADS
> >>>>         * VIRTIO_NET_F_GUEST_ANNOUNCE and VIRTIO_NET_F_CTRL_VQ.
> >>>>         *
> >>>>         * Note: devices should always test host features in future -=
 don't
> >>>> create
> >>>>         * new dependencies like this.
> >>>>         */
> >>>>        vdev->guest_features =3D features;
> >>>>
> >>>> This problem is specific to guest_features so avoiding it should giv=
e us
> >>>> a reliable solution.
> >>>
> >>> I meant not all the states were fully loaded for pre_load_queues(),
> >>> this seems another trick besides the above one. We should seek a way
> >>> to do it in post_load() or at least document the assumptions.
> >>
> >> The name of the function already clarifies the state is not fully
> >> loaded. An implementation of the function can make no assumption on th=
e
> >> state except that you can add queues here, which is already documented=
.
> >
> > Where? I can only see this:
> >
> >      /* Called before loading queues. Useful to add queues before loadi=
ng. */
>
> I meant it is documented that it can add queues. There is nothing else
> to document as an implementation of the function can make no assumption
> else.
>
> >
> >>
> >>>
> >>>>
> >>>>>
> >>>>> Looking at the commit that introduces this which is 9379ea9db3c tha=
t says:
> >>>>>
> >>>>> """
> >>>>> Otherwise the loaded queues will not have handlers and elements
> >>>>> in them will not be processed.
> >>>>> """
> >>>>>
> >>>>> I fail to remember what it means or what happens if we don't do 937=
9ea9db3c.
> >>>>
> >>>> The packets and control commands in the queues except the first queu=
e
> >>>> will not be processed because they do not have handle_output set.
> >>>
> >>> I don't understand here, the VM is not resumed in this case. Or what
> >>> issue did you see here?
> >>
> >> Below is the order of relevant events that happen when loading and
> >> resuming a VM for migration:
> >>
> >> 1) vdc->realize() gets called. virtio-net adds one RX queue, one TX
> >> queue, and one control queue.
> >> 2) vdc->pre_load_queues() gets called. virtio-net adds more queues if
> >> the "n" parameter requires that.
> >> 3) The state of queues are loaded.
> >> 4) The VM gets resumed.
> >>
> >> If we skip 2), 3) will load states of queues that are not added yet,
> >> which breaks these queues and packets and leave control packets on the=
m
> >> unprocessed.
> >
> > Ok, let's document this and
> >
> > 1) explain why only virtio-net requires the pre_load_queues (due to
> > the fact that the index of ctrl vq could be changed according to
> > #queue_paris)
>
> We would need this logic even if the index of ctrl vq didn't change. We
> need it because virtio-net have varying number of queues, which needs to
> be added before loading.

Well, if the ctrl vq index doesn't change we don't need a dynamic
virtio_add_queue() we can do them all in realize just like other
multiqueue devices.

>
> > 2) the commit also fixes the issue that changing the TAP queue pairs tw=
ice
>
> Commit 9379ea9db3c makes it change the TAP queue pairs once more. This
> patch reverts it, but that doesn't matter because the operation is
> idempotent.

It avoids unnecessary stuff like uevent etc...

>
> More concretely, before commit 9379ea9db3c, we had two points that
> updates the TAP queue pairs when loading a VM for migration:
> 1) virtio_net_set_features()
> 2) virtio_net_post_load_device()
>
> Commit 9379ea9db3c added a third point: virtio_net_pre_load_queues().
> This patch removes the third point by avoid calling
> virtio_net_set_queue_pairs(), which is a nice side effect.
>
> Regards,
> Akihiko Odaki
>

Thanks


