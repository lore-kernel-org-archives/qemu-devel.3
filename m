Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 36376C3DA6D
	for <qemu-devel@archiver.kernel.org>; Wed, 21 May 2025 00:53:09 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uHXgd-0003mm-Or; Tue, 20 May 2025 20:51:59 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jasowang@redhat.com>)
 id 1uHXgb-0003mb-QT
 for qemu-devel@nongnu.org; Tue, 20 May 2025 20:51:57 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jasowang@redhat.com>)
 id 1uHXgZ-0007Aa-Am
 for qemu-devel@nongnu.org; Tue, 20 May 2025 20:51:57 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1747788710;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=U9XuFfjdEpcDnC0R2j4HiRi1373pSeV7IBRmtGBo/ZI=;
 b=FZqKGY9q3b+B+RpMFKLYs8EdMir3HqKJkBF8zEsf7/vrljZbuc/XeWVmYzxXJq5LYRFqNE
 i0ArnmxtG2TCffzVtB0bkwhTrYNzh0JhONBa5dc3gNcS9GghTbh4SmhtDkvhyDrRVHzXnp
 VmUyvM049v8JOk6zIB2/zBwxrNK+/QA=
Received: from mail-pj1-f72.google.com (mail-pj1-f72.google.com
 [209.85.216.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-549-CAze1FrAN4WD1nFvt3ftuA-1; Tue, 20 May 2025 20:51:49 -0400
X-MC-Unique: CAze1FrAN4WD1nFvt3ftuA-1
X-Mimecast-MFC-AGG-ID: CAze1FrAN4WD1nFvt3ftuA_1747788708
Received: by mail-pj1-f72.google.com with SMTP id
 98e67ed59e1d1-3108d4ea2edso175447a91.0
 for <qemu-devel@nongnu.org>; Tue, 20 May 2025 17:51:49 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1747788708; x=1748393508;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=U9XuFfjdEpcDnC0R2j4HiRi1373pSeV7IBRmtGBo/ZI=;
 b=iKt3htjp8SybxRMRk5K4zXwtVDGB8yJ+EFEcQMqNEaD40KrLgegcwT1ifd43JzJoL1
 +Lup6Est3ay/9zRaJCMLwxyzhSms3GGz224sWj8zNBDj3zMHW7ft4d5bT6A4tJVZLJok
 pBNy40YQvHm289bx5WQ6C1DfX6IZTNdsVasViM3YDKS6TrVxW0Vpt2jOY6D9qbdJ1eg/
 6dXAq/J8dgimSY3wsn7gTGtys4WVpobgil6sODBCVKMqVns6Mh8Djwq/0GIRnjq5pflT
 isYB0ga9AzH1UVSO58JVCF6dJNi/FdKUSmFal+IgV8qP1eck5ioCZA+ha87nmwTVdg7/
 H9tQ==
X-Gm-Message-State: AOJu0Yx3XK9bhPIU6DZ1ppzYVsfd1SwGgEKfUUb9PYDBHhy5DV5p6EQW
 EP0+KMU7e0jwlmptBH4gW+0PKH3IOiw9s4w5TMtsDYoo7C6pK9c+r5NWTMnUcU0THaHdLR9dfVq
 c0zFmsWMwRsT879bx2a3B2CfHifoEVGBByWGbBkNb1OFJl4VM8R27kliwt9YRrOwQpodx2+trko
 5ou73fAxBYgBFifZaiKyvH9/HXjLdEdYQ=
X-Gm-Gg: ASbGncsdLAqMiahNvM+c+bXvdHUQHoXsuD/7VLO2HsU9UtpbkcckB0Ue0rviMRGOrAW
 5PlQ7b19QEGgU2TkKB/CZtnjoPFsdN9eXIUqeZxFKvTaGS54Ff69y+iS6rf9UgQUTBX0eUA==
X-Received: by 2002:a17:90b:3bce:b0:2fe:b907:5e5a with SMTP id
 98e67ed59e1d1-30e4db3d8c5mr32878012a91.10.1747788707864; 
 Tue, 20 May 2025 17:51:47 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGr9UCNlts7/fbEqZuUfH4x5qipSKh2qMqiJw9bFXZWl0dwyFpyHveGem8CsyHnHX8OsUEwbzQfGgelyJslVu4=
X-Received: by 2002:a17:90b:3bce:b0:2fe:b907:5e5a with SMTP id
 98e67ed59e1d1-30e4db3d8c5mr32877992a91.10.1747788707384; Tue, 20 May 2025
 17:51:47 -0700 (PDT)
MIME-Version: 1.0
References: <20250510-n-v1-1-19ee26ac3ca6@daynix.com>
 <CACGkMEt7xoX-HvV1mOo=zqpyV0se2ELBMvNV-uGpKUZPQ-PB2A@mail.gmail.com>
 <f3d10b18-9755-46af-9623-fb0ed7d99c51@daynix.com>
 <CACGkMEu_hyc-mP4zk9kJprCpFQbVzO0D2SEMy9eid5TmUH7Uaw@mail.gmail.com>
 <7f1c31de-de22-4290-a4fd-44e523477ca5@daynix.com>
In-Reply-To: <7f1c31de-de22-4290-a4fd-44e523477ca5@daynix.com>
From: Jason Wang <jasowang@redhat.com>
Date: Wed, 21 May 2025 08:51:36 +0800
X-Gm-Features: AX0GCFuDERwfzi-R-76RPJslknmdM96xzFTSQQTeepiAQgVkj0jCmlYFlaCWlyY
Message-ID: <CACGkMEsPb6TdT5qx9CkNOeT3ScJmS8_-FDjGh916fi8pWkuxNQ@mail.gmail.com>
Subject: Re: [PATCH] virtio-net: Add queues for RSS during migration
To: Akihiko Odaki <akihiko.odaki@daynix.com>
Cc: qemu-devel@nongnu.org, "Michael S. Tsirkin" <mst@redhat.com>,
 devel@daynix.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=170.10.129.124; envelope-from=jasowang@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -25
X-Spam_score: -2.6
X-Spam_bar: --
X-Spam_report: (-2.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.487,
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

On Fri, May 16, 2025 at 11:29=E2=80=AFAM Akihiko Odaki <akihiko.odaki@dayni=
x.com> wrote:
>
> On 2025/05/16 10:44, Jason Wang wrote:
> > On Wed, May 14, 2025 at 2:58=E2=80=AFPM Akihiko Odaki <akihiko.odaki@da=
ynix.com> wrote:
> >>
> >> On 2025/05/14 14:05, 'Jason Wang' via devel wrote:
> >>> On Sat, May 10, 2025 at 3:24=E2=80=AFPM Akihiko Odaki <akihiko.odaki@=
daynix.com> wrote:
> >>>>
> >>>> virtio_net_pre_load_queues() inspects vdev->guest_features to tell i=
f
> >>>> VIRTIO_NET_F_RSS or VIRTIO_NET_F_MQ is enabled to infer the required
> >>>> number of queues. This works for VIRTIO_NET_F_MQ but it doesn't for
> >>>> VIRTIO_NET_F_RSS because only the lowest 32 bits of vdev->guest_feat=
ures
> >>>> is set at the point and VIRTIO_NET_F_RSS uses bit 60 while
> >>>> VIRTIO_NET_F_MQ uses bit 22.
> >>>>
> >>>> Instead of inferring the required number of queues from
> >>>> vdev->guest_features, use the number loaded from the vm state.
> >>>>
> >>>> Fixes: 8c49756825da ("virtio-net: Add only one queue pair when reali=
zing")
> >>>> Signed-off-by: Akihiko Odaki <akihiko.odaki@daynix.com>
> >>>> ---
> >>>>    include/hw/virtio/virtio.h |  2 +-
> >>>>    hw/net/virtio-net.c        | 11 ++++-------
> >>>>    hw/virtio/virtio.c         | 14 +++++++-------
> >>>>    3 files changed, 12 insertions(+), 15 deletions(-)
> >>>>
> >>>> diff --git a/include/hw/virtio/virtio.h b/include/hw/virtio/virtio.h
> >>>> index 638691028050..af52580c1e63 100644
> >>>> --- a/include/hw/virtio/virtio.h
> >>>> +++ b/include/hw/virtio/virtio.h
> >>>> @@ -211,7 +211,7 @@ struct VirtioDeviceClass {
> >>>>        int (*start_ioeventfd)(VirtIODevice *vdev);
> >>>>        void (*stop_ioeventfd)(VirtIODevice *vdev);
> >>>>        /* Called before loading queues. Useful to add queues before =
loading. */
> >>>> -    int (*pre_load_queues)(VirtIODevice *vdev);
> >>>> +    int (*pre_load_queues)(VirtIODevice *vdev, uint32_t n);
> >>>
> >>> This turns out to be tricky as it has a lot of assumptions as
> >>> described in the changelog (e.g only lower 32bit of guest_features is
> >>> correct etc when calling this function).
> >>
> >> The problem is that I missed the following comment in
> >> hw/virtio/virtio.c:
> >>       /*
> >>        * Temporarily set guest_features low bits - needed by
> >>        * virtio net load code testing for VIRTIO_NET_F_CTRL_GUEST_OFFL=
OADS
> >>        * VIRTIO_NET_F_GUEST_ANNOUNCE and VIRTIO_NET_F_CTRL_VQ.
> >>        *
> >>        * Note: devices should always test host features in future - do=
n't
> >> create
> >>        * new dependencies like this.
> >>        */
> >>       vdev->guest_features =3D features;
> >>
> >> This problem is specific to guest_features so avoiding it should give =
us
> >> a reliable solution.
> >
> > I meant not all the states were fully loaded for pre_load_queues(),
> > this seems another trick besides the above one. We should seek a way
> > to do it in post_load() or at least document the assumptions.
>
> The name of the function already clarifies the state is not fully
> loaded. An implementation of the function can make no assumption on the
> state except that you can add queues here, which is already documented.

Where? I can only see this:

    /* Called before loading queues. Useful to add queues before loading. *=
/

>
> >
> >>
> >>>
> >>> Looking at the commit that introduces this which is 9379ea9db3c that =
says:
> >>>
> >>> """
> >>> Otherwise the loaded queues will not have handlers and elements
> >>> in them will not be processed.
> >>> """
> >>>
> >>> I fail to remember what it means or what happens if we don't do 9379e=
a9db3c.
> >>
> >> The packets and control commands in the queues except the first queue
> >> will not be processed because they do not have handle_output set.
> >
> > I don't understand here, the VM is not resumed in this case. Or what
> > issue did you see here?
>
> Below is the order of relevant events that happen when loading and
> resuming a VM for migration:
>
> 1) vdc->realize() gets called. virtio-net adds one RX queue, one TX
> queue, and one control queue.
> 2) vdc->pre_load_queues() gets called. virtio-net adds more queues if
> the "n" parameter requires that.
> 3) The state of queues are loaded.
> 4) The VM gets resumed.
>
> If we skip 2), 3) will load states of queues that are not added yet,
> which breaks these queues and packets and leave control packets on them
> unprocessed.

Ok, let's document this and

1) explain why only virtio-net requires the pre_load_queues (due to
the fact that the index of ctrl vq could be changed according to
#queue_paris)
2) the commit also fixes the issue that changing the TAP queue pairs twice

Thanks

>
> Regards,
> Akihiko Odaki
>


