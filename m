Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 94E4CC54FB3
	for <qemu-devel@archiver.kernel.org>; Mon, 26 May 2025 00:42:39 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uJLuM-00016V-3w; Sun, 25 May 2025 20:41:38 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jasowang@redhat.com>)
 id 1uJLuJ-00016F-O3
 for qemu-devel@nongnu.org; Sun, 25 May 2025 20:41:35 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jasowang@redhat.com>)
 id 1uJLuH-0004N0-Gf
 for qemu-devel@nongnu.org; Sun, 25 May 2025 20:41:35 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1748220090;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=ictjcWjM74I/b6X+vAlZ8vSUSV9YNpJrEb/77HRkcmM=;
 b=SHa4a8TW1AmMVJ5qKgs3jN+x+RNqERrozQCrctmRN3B1R7ZSErM41bCn0JFKDk4FYjR1if
 jKAuNMeMACPAkKiFAdohaTOneZHLLGkPg5EMahw17CuVMN9ck0zuyE4WR3d6h+UQZHAXSl
 KCK2LEDMSgD/lZrJNny86ZRqAD2i3nA=
Received: from mail-pf1-f199.google.com (mail-pf1-f199.google.com
 [209.85.210.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-578-NzvcnYm9P4Kc_ileptNnqw-1; Sun, 25 May 2025 20:41:28 -0400
X-MC-Unique: NzvcnYm9P4Kc_ileptNnqw-1
X-Mimecast-MFC-AGG-ID: NzvcnYm9P4Kc_ileptNnqw_1748220088
Received: by mail-pf1-f199.google.com with SMTP id
 d2e1a72fcca58-7375e2642b4so1150963b3a.2
 for <qemu-devel@nongnu.org>; Sun, 25 May 2025 17:41:28 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1748220088; x=1748824888;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=ictjcWjM74I/b6X+vAlZ8vSUSV9YNpJrEb/77HRkcmM=;
 b=jNgeMYqRK4McjtO0w707ZtZ5iSqMZB4pJBU0pQPEN0/PvOU8ftoVFee8h4jH994mL+
 QepgVkSexsnhPxny986iLmYShkQ0Lpur4LXVeyJLc45KHp7YDz1HfwhNoW/9k5a+R53g
 +oXsEbt8gcro4N5MRoNS8mIE35jFKAB4EJsUXl4Evco0ts1Id3CjS6xvU/4UzrklEpUU
 h3FTghAUND9LDulCkialtbI1iXHvwbnDj9sJNn02J+lyMQeaR+ZpQ+fmGaEim60PXZdR
 OefB5mr64hPzZAl4DawVrPwj6DNXPNSmz1ijxuwuZ9LmfxMzLaLXMBrAzEjyD4ppdDUC
 j4Mw==
X-Gm-Message-State: AOJu0YzE+SJqBsaN1FJGI/CkTBLOuAPkcFpxerhAnlzq3c7VjwDHKG+x
 HOvnv/A1eWoIRqhhvz5Mk4hNSuDd/X9jNL98xsusf0cXGL0tWwVuvCumZeQxUEThTUZXgLvpIva
 LnLPiicDLxOjK8YmZ+DTYn9prZQUBX+7B2Njm1/vzIUsPCTq/oxyofRPIIXoiOYGwh0n8phe0a6
 6P1l7WnQ+VnSRuX8PqAzxQjVe9Nw33UAQ=
X-Gm-Gg: ASbGncuk6vyQzV4gs+XR6R2xO7qHZm8KLFV8myP3mqOCUyK+PGzy/0n9Mm6W0ZHQl59
 7OJgRYknF1toBwMA+aJxZ6HWBwJl6VAIpBMPybupd/wEvE+NMrjpvKFLNVUphRCQE/NSJzg==
X-Received: by 2002:a05:6a00:3d45:b0:742:a7e3:7c84 with SMTP id
 d2e1a72fcca58-745fdfea9afmr9483324b3a.13.1748220087798; 
 Sun, 25 May 2025 17:41:27 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEFig4BTos6F09QVulgpoqCeMieCl1t5YfBGAuOks6aRmgsLr7ZW9v0dIGKy3z0HDawZhnweTtFRwt0ioOPCeM=
X-Received: by 2002:a05:6a00:3d45:b0:742:a7e3:7c84 with SMTP id
 d2e1a72fcca58-745fdfea9afmr9483301b3a.13.1748220087394; Sun, 25 May 2025
 17:41:27 -0700 (PDT)
MIME-Version: 1.0
References: <20250510-n-v1-1-19ee26ac3ca6@daynix.com>
 <CACGkMEt7xoX-HvV1mOo=zqpyV0se2ELBMvNV-uGpKUZPQ-PB2A@mail.gmail.com>
 <f3d10b18-9755-46af-9623-fb0ed7d99c51@daynix.com>
 <CACGkMEu_hyc-mP4zk9kJprCpFQbVzO0D2SEMy9eid5TmUH7Uaw@mail.gmail.com>
 <7f1c31de-de22-4290-a4fd-44e523477ca5@daynix.com>
 <CACGkMEsPb6TdT5qx9CkNOeT3ScJmS8_-FDjGh916fi8pWkuxNQ@mail.gmail.com>
 <f299600a-cf0b-47e4-85d1-5c3d1b4eaef0@daynix.com>
 <CACGkMEvEoZsdQh10ofOq4S-ZOJ7orJBK5MzDZ_0mV0f-Y=POFg@mail.gmail.com>
 <fb575fb3-d17c-4fd2-8dff-a77fd91b1d6a@daynix.com>
In-Reply-To: <fb575fb3-d17c-4fd2-8dff-a77fd91b1d6a@daynix.com>
From: Jason Wang <jasowang@redhat.com>
Date: Mon, 26 May 2025 08:41:15 +0800
X-Gm-Features: AX0GCFtHQigos9hRwb7axZ70xp5boieSYRXirEngeEJfuJ2Y1y6qA4ouDl1qpwA
Message-ID: <CACGkMEvkbgGeWwBLd=9RzTzA3PkiiRu0QiDkF56ATrRzz72m5g@mail.gmail.com>
Subject: Re: [PATCH] virtio-net: Add queues for RSS during migration
To: Akihiko Odaki <akihiko.odaki@daynix.com>
Cc: qemu-devel@nongnu.org, "Michael S. Tsirkin" <mst@redhat.com>,
 devel@daynix.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=170.10.133.124; envelope-from=jasowang@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -59
X-Spam_score: -6.0
X-Spam_bar: ------
X-Spam_report: (-6.0 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-2.904,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=-1, RCVD_IN_MSPIKE_WL=-0.01,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, SPF_HELO_NONE=0.001,
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

On Thu, May 22, 2025 at 12:39=E2=80=AFPM Akihiko Odaki <akihiko.odaki@dayni=
x.com> wrote:
>
> On 2025/05/22 10:50, 'Jason Wang' via devel wrote:
> > On Wed, May 21, 2025 at 11:51=E2=80=AFAM Akihiko Odaki <akihiko.odaki@d=
aynix.com> wrote:
> >>
> >> On 2025/05/21 9:51, Jason Wang wrote:
> >>> On Fri, May 16, 2025 at 11:29=E2=80=AFAM Akihiko Odaki <akihiko.odaki=
@daynix.com> wrote:
> >>>>
> >>>> On 2025/05/16 10:44, Jason Wang wrote:
> >>>>> On Wed, May 14, 2025 at 2:58=E2=80=AFPM Akihiko Odaki <akihiko.odak=
i@daynix.com> wrote:
> >>>>>>
> >>>>>> On 2025/05/14 14:05, 'Jason Wang' via devel wrote:
> >>>>>>> On Sat, May 10, 2025 at 3:24=E2=80=AFPM Akihiko Odaki <akihiko.od=
aki@daynix.com> wrote:
> >>>>>>>>
> >>>>>>>> virtio_net_pre_load_queues() inspects vdev->guest_features to te=
ll if
> >>>>>>>> VIRTIO_NET_F_RSS or VIRTIO_NET_F_MQ is enabled to infer the requ=
ired
> >>>>>>>> number of queues. This works for VIRTIO_NET_F_MQ but it doesn't =
for
> >>>>>>>> VIRTIO_NET_F_RSS because only the lowest 32 bits of vdev->guest_=
features
> >>>>>>>> is set at the point and VIRTIO_NET_F_RSS uses bit 60 while
> >>>>>>>> VIRTIO_NET_F_MQ uses bit 22.
> >>>>>>>>
> >>>>>>>> Instead of inferring the required number of queues from
> >>>>>>>> vdev->guest_features, use the number loaded from the vm state.
> >>>>>>>>
> >>>>>>>> Fixes: 8c49756825da ("virtio-net: Add only one queue pair when r=
ealizing")
> >>>>>>>> Signed-off-by: Akihiko Odaki <akihiko.odaki@daynix.com>
> >>>>>>>> ---
> >>>>>>>>      include/hw/virtio/virtio.h |  2 +-
> >>>>>>>>      hw/net/virtio-net.c        | 11 ++++-------
> >>>>>>>>      hw/virtio/virtio.c         | 14 +++++++-------
> >>>>>>>>      3 files changed, 12 insertions(+), 15 deletions(-)
> >>>>>>>>
> >>>>>>>> diff --git a/include/hw/virtio/virtio.h b/include/hw/virtio/virt=
io.h
> >>>>>>>> index 638691028050..af52580c1e63 100644
> >>>>>>>> --- a/include/hw/virtio/virtio.h
> >>>>>>>> +++ b/include/hw/virtio/virtio.h
> >>>>>>>> @@ -211,7 +211,7 @@ struct VirtioDeviceClass {
> >>>>>>>>          int (*start_ioeventfd)(VirtIODevice *vdev);
> >>>>>>>>          void (*stop_ioeventfd)(VirtIODevice *vdev);
> >>>>>>>>          /* Called before loading queues. Useful to add queues b=
efore loading. */
> >>>>>>>> -    int (*pre_load_queues)(VirtIODevice *vdev);
> >>>>>>>> +    int (*pre_load_queues)(VirtIODevice *vdev, uint32_t n);
> >>>>>>>
> >>>>>>> This turns out to be tricky as it has a lot of assumptions as
> >>>>>>> described in the changelog (e.g only lower 32bit of guest_feature=
s is
> >>>>>>> correct etc when calling this function).
> >>>>>>
> >>>>>> The problem is that I missed the following comment in
> >>>>>> hw/virtio/virtio.c:
> >>>>>>         /*
> >>>>>>          * Temporarily set guest_features low bits - needed by
> >>>>>>          * virtio net load code testing for VIRTIO_NET_F_CTRL_GUES=
T_OFFLOADS
> >>>>>>          * VIRTIO_NET_F_GUEST_ANNOUNCE and VIRTIO_NET_F_CTRL_VQ.
> >>>>>>          *
> >>>>>>          * Note: devices should always test host features in futur=
e - don't
> >>>>>> create
> >>>>>>          * new dependencies like this.
> >>>>>>          */
> >>>>>>         vdev->guest_features =3D features;
> >>>>>>
> >>>>>> This problem is specific to guest_features so avoiding it should g=
ive us
> >>>>>> a reliable solution.
> >>>>>
> >>>>> I meant not all the states were fully loaded for pre_load_queues(),
> >>>>> this seems another trick besides the above one. We should seek a wa=
y
> >>>>> to do it in post_load() or at least document the assumptions.
> >>>>
> >>>> The name of the function already clarifies the state is not fully
> >>>> loaded. An implementation of the function can make no assumption on =
the
> >>>> state except that you can add queues here, which is already document=
ed.
> >>>
> >>> Where? I can only see this:
> >>>
> >>>       /* Called before loading queues. Useful to add queues before lo=
ading. */
> >>
> >> I meant it is documented that it can add queues. There is nothing else
> >> to document as an implementation of the function can make no assumptio=
n
> >> else.
> >>
> >>>
> >>>>
> >>>>>
> >>>>>>
> >>>>>>>
> >>>>>>> Looking at the commit that introduces this which is 9379ea9db3c t=
hat says:
> >>>>>>>
> >>>>>>> """
> >>>>>>> Otherwise the loaded queues will not have handlers and elements
> >>>>>>> in them will not be processed.
> >>>>>>> """
> >>>>>>>
> >>>>>>> I fail to remember what it means or what happens if we don't do 9=
379ea9db3c.
> >>>>>>
> >>>>>> The packets and control commands in the queues except the first qu=
eue
> >>>>>> will not be processed because they do not have handle_output set.
> >>>>>
> >>>>> I don't understand here, the VM is not resumed in this case. Or wha=
t
> >>>>> issue did you see here?
> >>>>
> >>>> Below is the order of relevant events that happen when loading and
> >>>> resuming a VM for migration:
> >>>>
> >>>> 1) vdc->realize() gets called. virtio-net adds one RX queue, one TX
> >>>> queue, and one control queue.
> >>>> 2) vdc->pre_load_queues() gets called. virtio-net adds more queues i=
f
> >>>> the "n" parameter requires that.
> >>>> 3) The state of queues are loaded.
> >>>> 4) The VM gets resumed.
> >>>>
> >>>> If we skip 2), 3) will load states of queues that are not added yet,
> >>>> which breaks these queues and packets and leave control packets on t=
hem
> >>>> unprocessed.
> >>>
> >>> Ok, let's document this and
> >>>
> >>> 1) explain why only virtio-net requires the pre_load_queues (due to
> >>> the fact that the index of ctrl vq could be changed according to
> >>> #queue_paris)
> >>
> >> We would need this logic even if the index of ctrl vq didn't change. W=
e
> >> need it because virtio-net have varying number of queues, which needs =
to
> >> be added before loading.
> >
> > Well, if the ctrl vq index doesn't change we don't need a dynamic
> > virtio_add_queue() we can do them all in realize just like other
> > multiqueue devices.
>
> The number of virtqueues also affects the behavior visible to the guest
> so we shouldn't add them all in realize anyway. In particular, struct
> virtio_pci_common_cfg contains fields related virtqueus, and most (if
> not all) of them are affected by the number of virtqueues.

I don't understand here, is this requested by the spec for example?

Thanks

>
> Regards,
> Akihiko Odaki
>


