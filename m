Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EC10DC41513
	for <qemu-devel@archiver.kernel.org>; Fri,  5 Jul 2024 05:04:04 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sPb5s-0004s2-6O; Fri, 05 Jul 2024 01:02:48 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1sPb5q-0004pV-5j
 for qemu-devel@nongnu.org; Fri, 05 Jul 2024 01:02:46 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1sPb5m-0001KH-Pk
 for qemu-devel@nongnu.org; Fri, 05 Jul 2024 01:02:45 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1720155761;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=wpwdcbYq2OZqYh1Uac64sy+8Vd8c46GnpRIC0+BDg8E=;
 b=K+Un0sKqPNt9oU9Rb1+8S4tc0Bf0RdsiRHxrFbjTMhZeTDZ3CEpwdOKtOIOeZXQSk7cdCc
 ygbM5ea2bv027H+gCSGTA9QSUaGpjFSpbaTaOSY7U8epqPVO32pxUPAsfOi5WMLIkkfL7Q
 PIZ5M6kjYiK/6mbVwqMil+y7TwG4WFA=
Received: from mail-ed1-f70.google.com (mail-ed1-f70.google.com
 [209.85.208.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-55-VNV_iSrjOQSEhrZcl2GETA-1; Fri, 05 Jul 2024 01:02:37 -0400
X-MC-Unique: VNV_iSrjOQSEhrZcl2GETA-1
Received: by mail-ed1-f70.google.com with SMTP id
 4fb4d7f45d1cf-58cd7a95dabso577503a12.2
 for <qemu-devel@nongnu.org>; Thu, 04 Jul 2024 22:02:37 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1720155756; x=1720760556;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :mime-version:references:message-id:subject:cc:to:from:date
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=wpwdcbYq2OZqYh1Uac64sy+8Vd8c46GnpRIC0+BDg8E=;
 b=iUTaGx87B0jUNQz4dyWZAcoM55eXaj9Xr43CGH+hIQ0vGsjHf2byWrSPm2ofoOVMxR
 JKltCP6FTruoWS+GFbTzYSrgjlZAt5o3G1+aOYCTgYmXUNwsFe793kO/kZ5ytIpdK6Yv
 q7si4/VsmYs1K/2v55qsEvDtk+J/7hwNbaC56BbtaCLIhQ/dtE2wbjPqBg51VdnDkMQ9
 w7YcWmZb550SM2tdbDEOqQIL0t1+nslBcXPcmF6MADDQfR3cWJ9fdRn24Jwuzt5HKGBo
 DZx5bwu6eX3XCl4wximyEh4D+Kqp7KhJTnppAjfmpBOE2h8GPcTLwKXhMeUlrcUdFmJ/
 2mzA==
X-Gm-Message-State: AOJu0YxRRuIJ4qYB8wB5qQcIfvPCsM8TMvwbs+whq3zYmMaxi5AECZQV
 uOD9sWwnwxLkvEWILT+9kjTkdth1WNhbrcNm7Wf7tIHR4YOTX1E4WsiMnKrx7HN6tNn/AmUgAkX
 duKIL0fwxJoeafPl88G7tAbv9tO/Hj3+VqBDbi9pwJ4ItV+3M86bI
X-Received: by 2002:a05:6402:22f0:b0:58c:8c63:22ee with SMTP id
 4fb4d7f45d1cf-58e5be72411mr2058123a12.42.1720155755891; 
 Thu, 04 Jul 2024 22:02:35 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHtWozLl+42pzFESSo/rE4+H/oZwbie8aOILRbOv2g5BRlKTfz+As4FJFBRMF4QliZ4DC53XQ==
X-Received: by 2002:a05:6402:22f0:b0:58c:8c63:22ee with SMTP id
 4fb4d7f45d1cf-58e5be72411mr2058105a12.42.1720155755092; 
 Thu, 04 Jul 2024 22:02:35 -0700 (PDT)
Received: from redhat.com ([2a0d:6fc7:441:1b5b:ac5c:b82e:a18c:2c6e])
 by smtp.gmail.com with ESMTPSA id
 4fb4d7f45d1cf-58eeabbf108sm1048324a12.93.2024.07.04.22.02.32
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 04 Jul 2024 22:02:34 -0700 (PDT)
Date: Fri, 5 Jul 2024 01:02:30 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Yang Dongshan <east.moutain.yang@gmail.com>
Cc: "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
 "jasowang@redhat.com" <jasowang@redhat.com>,
 "stefanha@redhat.com" <stefanha@redhat.com>,
 "kwolf@redhat.com" <kwolf@redhat.com>,
 "hreitz@redhat.com" <hreitz@redhat.com>,
 "qemu-stable@nongnu.org" <qemu-stable@nongnu.org>
Subject: Re: [PATCH v7] virtio-net: Fix network stall at the host side
 waiting for kick
Message-ID: <20240705010053-mutt-send-email-mst@kernel.org>
References: <20240701140017.49223-1-east.moutain.yang@gmail.com>
 <20240701105110-mutt-send-email-mst@kernel.org>
 <CALrP2iW7VRLnNmyyM451OiiE3serP1ViT8wvsNCK1CadqKU09Q@mail.gmail.com>
 <20240701144507-mutt-send-email-mst@kernel.org>
 <CALrP2iVVFzrP_zy5g1Noh0Mo0OgdFSLO=Ruan_5ZHuZxt6EhFQ@mail.gmail.com>
 <20240702070803-mutt-send-email-mst@kernel.org>
 <SI6PR01MB6848F2D07BA34D71BDBC6C64A7DE2@SI6PR01MB6848.apcprd01.prod.exchangelabs.com>
 <20240704072009-mutt-send-email-mst@kernel.org>
 <SI6PR01MB684867B7FDB0DDA2E24A0DB2A7DF2@SI6PR01MB6848.apcprd01.prod.exchangelabs.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <SI6PR01MB684867B7FDB0DDA2E24A0DB2A7DF2@SI6PR01MB6848.apcprd01.prod.exchangelabs.com>
Received-SPF: pass client-ip=170.10.129.124; envelope-from=mst@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

On Fri, Jul 05, 2024 at 02:21:35AM +0000, Yang Dongshan wrote:
> > virtqueue_get_avail_bytes would always return the opaque.
> Then the condition will change from:
> 
> static int virtio_net_has_buffers(VirtIONetQueue *q, int bufsize)
> {
>       if (virtio_queue_empty(q->rx_vq) ||
>           (n->mergeable_rx_bufs &&
>            !virtqueue_avail_bytes(q->rx_vq, bufsize, 0)))
>     ...
> }
> 
> to:
> 
> static int virtio_net_has_buffers(VirtIONetQueue *q, int bufsize)
> {
>       if (virtio_queue_empty(q->rx_vq) || n->mergeable_rx_bufs) { 
>            shadow_Idx = virtqueue_get_avail_bytes (q->rx_vq, &in_total, NULL, bufsize, 0));
>            if (bufsize <= in_totail) {
>                 // bufsize is okay
>             } else {
>                  // do notification and recheck available buffers.
>                 If (virtio_queue_set_notification_and_check(q->rx_vq, shadow_idx)) {
>                      ...
>                 } else {
>                     ...
>                }
>            }
>     ...
> }
> 
> When the queue is empty, always call virtqueue_get_avail_bytes() just to
> get the opaque, it seems not friendly to the performance.
> Why not get the shadow idx within virtio_queue_set_notification_and_check()
> directly and change the function name to
> virtio_queue_set_notification_and_check_shadow()? 

Keep shadow an internal implementation detail otherwise
it's unmaintainable.

We already call virtqueue_get_avail_bytes.
The situation with the stall is super unlikely, it is not
worth worrying about the performance in that case.




> ﻿On 2024/7/4, 19:24, "Michael S. Tsirkin" <mst@redhat.com <mailto:mst@redhat.com>> wrote:
> 
> 
> On Thu, Jul 04, 2024 at 10:20:15AM +0000, Yang Dongshan wrote:
> > Hi, Michael
> > 
> > > My suggestion:
> > > 
> > > 
> > > change virtqueue_get_avail_bytes to return the shadow
> > > in an opaque unsigned value.
> > > 
> > > 
> > > add virtqueue_poll that gets this opaque and tells us whether any new
> > > buffers became available in the queue since that value> 
> > > was returned.
> > 
> > 
> > > accordingly, virtio_queue_set_notification_and_check
> > > will accept this opaque value and check avail buffers
> > > against it.
> > 
> > According to your suggestion, it's able to handle the case where the
> > queue is not empty, when the queue is empty, should I add an API to
> > get the shadow idx as virtio_queue_set_notification_and_check()
> > needs the opaque arg.
> 
> 
> virtqueue_get_avail_bytes would always return the opaque.
> 
> 
> > What value should return from virtqueue_get_avail_bytes() in case of
> > error branch in the function? 
> 
> 
> One way would be to make opaque int, return a negative value on error,
> positive on success.
> 
> 
> 
> 
> > ﻿On 2024/7/2, 19:27, "Michael S. Tsirkin" <mst@redhat.com <mailto:mst@redhat.com> <mailto:mst@redhat.com <mailto:mst@redhat.com>>> wrote:
> > 
> > 
> > On Tue, Jul 02, 2024 at 07:45:31AM +0800, Yang Dongshan wrote:
> > > > what does "changed" mean here? changed compared to what?
> > > For a split queue, if the shadow_avail_idx synced from avail ring idx
> > > by vring_avail_idx(vq) last time doesn't equal the current value of avail ring
> > > idx.
> > > 
> > > vq->shadow_avail_idx != vring_avail_idx(vq);
> > > 
> > > For packed queue, the logic is similar, if vq->shadow_avail_idx
> > > 
> > > becomes available, it means the guest has added buf at the slot.
> > > 
> > > vring_packed_desc_read(vq->vdev, &desc, &caches->desc,
> > > 
> > > vq->shadow_avail_idx, true);
> > > 
> > > if (is_desc_avail(desc.flags, vq-> shadow_avail_wrap_counter))
> > > 
> > > return true;
> > > 
> > > 
> > 
> > 
> > This answer does not make sense from API POV.
> > 
> > 
> > My suggestion:
> > 
> > 
> > change virtqueue_get_avail_bytes to return the shadow
> > in an opaque unsigned value.
> > 
> > 
> > add virtqueue_poll that gets this opaque and tells us whether any new
> > buffers became available in the queue since that value
> > was returned.
> > 
> > 
> > accordingly, virtio_queue_set_notification_and_check
> > will accept this opaque value and check avail buffers
> > against it.
> > 
> > 
> > 
> > 
> > 
> > 
> > > On Tue, Jul 2, 2024 at 2:46 AM Michael S. Tsirkin <mst@redhat.com <mailto:mst@redhat.com> <mailto:mst@redhat.com <mailto:mst@redhat.com>>> wrote:
> > > 
> > > On Tue, Jul 02, 2024 at 01:18:15AM +0800, Yang Dongshan wrote:
> > > > > Please document what this does.
> > > > okay, i will.
> > > >
> > > > > So this will return false if ring has any available buffers?
> > > > > Equivalent to:
> > > > > 
> > > > > bool virtio_queue_set_notification_and_check(VirtQueue *vq, int enable)
> > > > > {
> > > > > virtio_queue_packed_set_notification(vq, enable);
> > > > > return virtio_queue_empty(vq);
> > > > > }
> > > >
> > > > No, only when the shadow_avail_idx is changed shall the function return
> > > true,
> > > 
> > > 
> > > what does "changed" mean here? changed compared to what?
> > > 
> > > > compared with the value seen by the host last time, else return false
> > > even if
> > > > there are some buffers available in the queue, as the total size of the
> > > > available
> > > > buffers in the queue can't satisfy the request.
> > > >
> > > > It maybe better to pass only one arg to the function like this:
> > > > bool virtio_queue_set_notification_and_check(VirtQueue *vq)
> > > > {
> > > > virtio_queue_packed_set_notification(vq, true);
> > > > 
> > > > return shadow_avail_idx_changed()? true: false;
> > > > }
> > > >
> > > > Thanks Michael a lot!
> > > >
> > > > On Mon, Jul 1, 2024 at 11:05 PM Michael S. Tsirkin <mst@redhat.com <mailto:mst@redhat.com> <mailto:mst@redhat.com <mailto:mst@redhat.com>>>
> > > wrote:
> > > >
> > > > On Mon, Jul 01, 2024 at 10:00:17PM +0800, Wencheng Yang wrote:
> > > > > From: thomas <east.moutain.yang@gmail.com <mailto:east.moutain.yang@gmail.com> <mailto:east.moutain.yang@gmail.com <mailto:east.moutain.yang@gmail.com>>>
> > > > >
> > > > > Patch 06b12970174 ("virtio-net: fix network stall under load")
> > > > > added double-check to test whether the available buffer size
> > > > > can satisfy the request or not, in case the guest has added
> > > > > some buffers to the avail ring simultaneously after the first
> > > > > check. It will be lucky if the available buffer size becomes
> > > > > okay after the double-check, then the host can send the packet
> > > > > to the guest. If the buffer size still can't satisfy the request,
> > > > > even if the guest has added some buffers, viritio-net would
> > > > > stall at the host side forever.
> > > > >
> > > > > The patch checks whether the guest has added some buffers
> > > > > after last check of avail idx when the available buffers are
> > > > > not sufficient, if so then recheck the available buffers
> > > > > in the loop.
> > > > >
> > > > > The patch also reverts patch "06b12970174".
> > > > >
> > > > > The case below can reproduce the stall.
> > > > >
> > > > > Guest 0
> > > > > +--------+
> > > > > | iperf |
> > > > > ---------------> | server |
> > > > > Host | +--------+
> > > > > +--------+ | ...
> > > > > | iperf |----
> > > > > | client |---- Guest n
> > > > > +--------+ | +--------+
> > > > > | | iperf |
> > > > > ---------------> | server |
> > > > > +--------+
> > > > >
> > > > > Boot many guests from qemu with virtio network:
> > > > > qemu ... -netdev tap,id=net_x \
> > > > > -device virtio-net-pci-non-transitional,\
> > > > > iommu_platform=on,mac=xx:xx:xx:xx:xx:xx,netdev=net_x
> > > > >
> > > > > Each guest acts as iperf server with commands below:
> > > > > iperf3 -s -D -i 10 -p 8001
> > > > > iperf3 -s -D -i 10 -p 8002
> > > > >
> > > > > The host as iperf client:
> > > > > iperf3 -c guest_IP -p 8001 -i 30 -w 256k -P 20 -t 40000
> > > > > iperf3 -c guest_IP -p 8002 -i 30 -w 256k -P 20 -t 40000
> > > > >
> > > > > After some time, the host loses connection to the guest,
> > > > > the guest can send packet to the host, but can't receive
> > > > > packet from host.
> > > > >
> > > > > It's more likely to happen if SWIOTLB is enabled in the guest,
> > > > > allocating and freeing bounce buffer takes some CPU ticks,
> > > > > copying from/to bounce buffer takes more CPU ticks, compared
> > > > > with that there is no bounce buffer in the guest.
> > > > > Once the rate of producing packets from the host approximates
> > > > > the rate of receiveing packets in the guest, the guest would
> > > > > loop in NAPI.
> > > > >
> > > > > receive packets ---
> > > > > | |
> > > > > v |
> > > > > free buf virtnet_poll
> > > > > | |
> > > > > v |
> > > > > add buf to avail ring ---
> > > > > |
> > > > > | need kick the host?
> > > > > | NAPI continues
> > > > > v
> > > > > receive packets ---
> > > > > | |
> > > > > v |
> > > > > free buf virtnet_poll
> > > > > | |
> > > > > v |
> > > > > add buf to avail ring ---
> > > > > |
> > > > > v
> > > > > ... ...
> > > > >
> > > > > On the other hand, the host fetches free buf from avail
> > > > > ring, if the buf in the avail ring is not enough, the
> > > > > host notifies the guest the event by writing the avail
> > > > > idx read from avail ring to the event idx of used ring,
> > > > > then the host goes to sleep, waiting for the kick signal
> > > > > from the guest.
> > > > >
> > > > > Once the guest finds the host is waiting for kick singal
> > > > > (in virtqueue_kick_prepare_split()), it kicks the host.
> > > > >
> > > > > The host may stall forever at the sequences below:
> > > > >
> > > > > Host Guest
> > > > > ------------ -----------
> > > > > fetch buf, send packet receive packet ---
> > > > > ... ... |
> > > > > fetch buf, send packet add buf |
> > > > > ... add buf virtnet_poll
> > > > > buf not enough avail idx-> add buf |
> > > > > read avail idx add buf |
> > > > > add buf ---
> > > > > receive packet ---
> > > > > write event idx ... |
> > > > > wait for kick add buf virtnet_poll
> > > > > ... |
> > > > > ---
> > > > > no more packet, exit NAPI
> > > > >
> > > > > In the first loop of NAPI above, indicated in the range of
> > > > > virtnet_poll above, the host is sending packets while the
> > > > > guest is receiving packets and adding buffers.
> > > > > step 1: The buf is not enough, for example, a big packet
> > > > > needs 5 buf, but the available buf count is 3.
> > > > > The host read current avail idx.
> > > > > step 2: The guest adds some buf, then checks whether the
> > > > > host is waiting for kick signal, not at this time.
> > > > > The used ring is not empty, the guest continues
> > > > > the second loop of NAPI.
> > > > > step 3: The host writes the avail idx read from avail
> > > > > ring to used ring as event idx via
> > > > > virtio_queue_set_notification(q->rx_vq, 1).
> > > > > step 4: At the end of the second loop of NAPI, recheck
> > > > > whether kick is needed, as the event idx in the
> > > > > used ring written by the host is beyound the
> > > > > range of kick condition, the guest will not
> > > > > send kick signal to the host.
> > > > >
> > > > > Fixes: 06b12970174 ("virtio-net: fix network stall under load")
> > > > > Signed-off-by: Wencheng Yang <east.moutain.yang@gmail.com <mailto:east.moutain.yang@gmail.com> <mailto:east.moutain.yang@gmail.com <mailto:east.moutain.yang@gmail.com>>>
> > > > > ---
> > > > >
> > > > > Changelog:
> > > > > v7:
> > > > > - Add function virtio_queue_set_notification_and_check()
> > > > > - Restore the function sequence introduce in v6
> > > > >
> > > > > v6:
> > > > > - Take packed packed queue into cosideration
> > > > > - Adjust function sequence to fix compilation issue
> > > > >
> > > > > v5:
> > > > > - Modify return type of virtio_queue_set_notification() to
> > > > > bool to indicate whether the guest has added some buffers
> > > > > after last check of avail idx
> > > > > - Loop in virtio_net_has_buffers() if the available buffers
> > > > > are not sufficient and the guest has added some buffers.
> > > > > - Revert patch "06b12970174"
> > > > > - Update the subject
> > > > >
> > > > > v4:
> > > > > - Correct spelling mistake in the subject
> > > > > - Describe the issue that virtio-net is blocked at host side
> > > > >
> > > > > v3:
> > > > > - Add virtio-net tag in the subject
> > > > > - Refine commit log
> > > > >
> > > > > v2:
> > > > > - Add SOB tag at the end of the commit message
> > > > > - Place Fixes tag at the end of the commit message
> > > > >
> > > > > v1:
> > > > > - Initial patch
> > > > >
> > > > > hw/net/virtio-net.c | 19 ++++++++-----------
> > > > > hw/virtio/virtio.c | 39
> > > ++++++++++++++++++++++++++++++++++++++
> > > > > include/hw/virtio/virtio.h | 1 +
> > > > > 3 files changed, 48 insertions(+), 11 deletions(-)
> > > > >
> > > > > diff --git a/hw/net/virtio-net.c b/hw/net/virtio-net.c
> > > > > index 9c7e85caea..357c651d9b 100644
> > > > > --- a/hw/net/virtio-net.c
> > > > > +++ b/hw/net/virtio-net.c
> > > > > @@ -1642,18 +1642,15 @@ static bool virtio_net_can_receive
> > > (NetClientState
> > > > *nc)
> > > > > static int virtio_net_has_buffers(VirtIONetQueue *q, int bufsize)
> > > > > {
> > > > > VirtIONet *n = q->n;
> > > > > - if (virtio_queue_empty(q->rx_vq) ||
> > > > > - (n->mergeable_rx_bufs &&
> > > > > - !virtqueue_avail_bytes(q->rx_vq, bufsize, 0))) {
> > > > > - virtio_queue_set_notification(q->rx_vq, 1);
> > > > > -
> > > > > - /* To avoid a race condition where the guest has made some
> > > > buffers
> > > > > - * available after the above check but before notification
> > > was
> > > > > - * enabled, check for available buffers again.
> > > > > - */
> > > > > - if (virtio_queue_empty(q->rx_vq) ||
> > > > > +
> > > > > + while (virtio_queue_empty(q->rx_vq) ||
> > > > > (n->mergeable_rx_bufs &&
> > > > > - !virtqueue_avail_bytes(q->rx_vq, bufsize, 0))) {
> > > > > + !virtqueue_avail_bytes(q->rx_vq, bufsize, 0))) {
> > > > > + /* guest may have made some buf, try again */
> > > > > + if (virtio_queue_set_notification_and_check(q->rx_vq, 1))
> > > {
> > > > > + virtio_queue_set_notification(q->rx_vq, 0);
> > > > > + continue;
> > > > > + } else {
> > > > > return 0;
> > > > > }
> > > > > }
> > > > > diff --git a/hw/virtio/virtio.c b/hw/virtio/virtio.c
> > > > > index 893a072c9d..b165764017 100644
> > > > > --- a/hw/virtio/virtio.c
> > > > > +++ b/hw/virtio/virtio.c
> > > > > @@ -668,6 +668,45 @@ static inline bool is_desc_avail(uint16_t
> > > flags,
> > > > bool wrap_counter)
> > > > > return (avail != used) && (avail == wrap_counter);
> > > > > }
> > > > > 
> > > > > +bool virtio_queue_set_notification_and_check(VirtQueue *vq, int
> > > enable)
> > > > > +{
> > > > > + uint16_t shadow_idx;
> > > > > + VRingPackedDesc desc;
> > > > > + VRingMemoryRegionCaches *caches;
> > > > > +
> > > > > + vq->notification = enable;
> > > > > +
> > > > > + if (!vq->vring.desc) {
> > > > > + return false;
> > > > > + }
> > > > > +
> > > > > + if (virtio_vdev_has_feature(vq->vdev, VIRTIO_F_RING_PACKED)) {
> > > > > + virtio_queue_packed_set_notification(vq, enable);
> > > > > +
> > > > > + if (enable) {
> > > > > + caches = vring_get_region_caches(vq);
> > > > > + if (!caches) {
> > > > > + return false;
> > > > > + }
> > > > > +
> > > > > + vring_packed_desc_read(vq->vdev, &desc, &caches->desc,
> > > > > + vq->shadow_avail_idx, true);
> > > > > + if (is_desc_avail(desc.flags, vq->
> > > > shadow_avail_wrap_counter)) {
> > > > > + return true;
> > > > > + }
> > > > > + }
> > > > > + } else {
> > > > > + shadow_idx = vq->shadow_avail_idx;
> > > > > + virtio_queue_split_set_notification(vq, enable);
> > > > > +
> > > > > + if (enable) {
> > > > > + return shadow_idx != vring_avail_idx(vq);
> > > > > + }
> > > > > + }
> > > > > +
> > > > > + return false;
> > > > > +}
> > > >
> > > > Please document what this does.
> > > > So this will return false if ring has any availabe buffers?
> > > > Equivalent to:
> > > >
> > > > bool virtio_queue_set_notification_and_check(VirtQueue *vq, int
> > > enable)
> > > > {
> > > > virtio_queue_packed_set_notification(vq, enable);
> > > > return virtio_queue_empty(vq);
> > > > }
> > > >
> > > >
> > > > or am I missing something?
> > > >
> > > > > +
> > > > > /* Fetch avail_idx from VQ memory only when we really need to know
> > > if
> > > > > * guest has added some buffers.
> > > > > * Called within rcu_read_lock(). */
> > > > > diff --git a/include/hw/virtio/virtio.h b/include/hw/virtio/
> > > virtio.h
> > > > > index 7d5ffdc145..ed85023b87 100644
> > > > > --- a/include/hw/virtio/virtio.h
> > > > > +++ b/include/hw/virtio/virtio.h
> > > > > @@ -302,6 +302,7 @@ void virtio_notify_config(VirtIODevice *vdev);
> > > > > 
> > > > > bool virtio_queue_get_notification(VirtQueue *vq);
> > > > > void virtio_queue_set_notification(VirtQueue *vq, int enable);
> > > > > +bool virtio_queue_set_notification_and_check(VirtQueue *vq, int
> > > enable);
> > > > > 
> > > > > int virtio_queue_ready(VirtQueue *vq);
> > > > > 
> > > > > --
> > > > > 2.39.0
> > > >
> > > >
> > > 
> > > 
> > 
> > 
> > 
> > 
> 
> 
> 
> 


