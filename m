Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5B8A3CD1292
	for <qemu-devel@archiver.kernel.org>; Thu, 11 Apr 2024 11:30:50 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rusd8-00079Z-2M; Thu, 11 Apr 2024 07:30:10 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <yvugenfi@redhat.com>)
 id 1rusd6-00079L-HW
 for qemu-devel@nongnu.org; Thu, 11 Apr 2024 07:30:08 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <yvugenfi@redhat.com>)
 id 1rusd1-0005NS-JG
 for qemu-devel@nongnu.org; Thu, 11 Apr 2024 07:30:06 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1712835001;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=lWP8YJ9yBcd8qk+1BA6LPl8zTQkP0435Yl7U64yQuPU=;
 b=KMKEwPdbtYmXt8kA5owZ9gm8vOPDa08M2XMfU4rfFafrON9mgdY6CJEti1wNlGVicuXsSq
 RwecWR7dB3JfL0BlUahJIMw2flvp3jJKAwTAPphmtIrueSbvCSyYcwLk9kbRC3XulWQLOJ
 ujJ5KQrBqrPd4U/9lkO5OAEdsxvuWfw=
Received: from mail-vk1-f198.google.com (mail-vk1-f198.google.com
 [209.85.221.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-386-T_PkyaSJNtyWhGqBnK-3tw-1; Thu, 11 Apr 2024 07:28:28 -0400
X-MC-Unique: T_PkyaSJNtyWhGqBnK-3tw-1
Received: by mail-vk1-f198.google.com with SMTP id
 71dfb90a1353d-4dab1c18858so2907192e0c.1
 for <qemu-devel@nongnu.org>; Thu, 11 Apr 2024 04:28:28 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1712834908; x=1713439708;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=lWP8YJ9yBcd8qk+1BA6LPl8zTQkP0435Yl7U64yQuPU=;
 b=Pqz4rwKwTSCtj8NcW6rkBde6UDHhVU7O7tkZmHxhRyBLmLyRxcUkh6kEMpMYbQEy48
 8nKlJp2vy/zNEb/8HexwLyIb/nQTEStp0fwwj2OiaQRxSRd6rsYH0eoFFUBNt+VBneas
 J3HcNuWM63a67ialLJFVsJuqQQ7CJBNYj2tlWDCig6bMCiWuSec3zGFE/r+qPU1cCUE1
 jtNWEbWBXF2TjRjM4O+DTua0cn1E5ig9JYNUNCTYlNC9f/ID7uZGAzyrG8yneAr1aOs0
 vzYjEx/pJAlPnQYDDOfBTnkcnwsW5nO8VfTYYyjnH6czJXIZdkHjtQ4tUHMDdwDvksmW
 Ju8g==
X-Forwarded-Encrypted: i=1;
 AJvYcCVHOGjg+2T5lhBjNmraUR2zG34sWGMQUYbExm1KLPiiG7wmXRLlvXgBIK/vkGuuShnQAXJ6BVfogQ6yKf3O00WM6+DO6Bc=
X-Gm-Message-State: AOJu0YyUkGnXM7ueKGwnNYT+I2oMY8wWMJ3vF2sVqdSwc1LS68YuWSlC
 3RfJ7iibWq4m11nRmZdKoJaz14TuDTxOwOgPfVBlFCJN4YSeJMtbtk0IPvWluKoMGt6YTtCd1sT
 ojpQ+Ye/07M0bhfnGhY3VU7G05hi8vy2bFNAerueWyrOt70WEOB4+yMMbMCa3WXcH7El0gf9EIk
 GBkXZ8ITgYF83qagceKOtyqMe5bsY=
X-Received: by 2002:a1f:c904:0:b0:4d1:34a1:c892 with SMTP id
 z4-20020a1fc904000000b004d134a1c892mr4587832vkf.13.1712834908067; 
 Thu, 11 Apr 2024 04:28:28 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFwuwXt3eCC+T2m+g0krApKMC5nlf4MdIuVXgfJxNuoIYnrHzVWmdCr3ZYUE7OVTJbplmC8N1B18oOywNyrOvo=
X-Received: by 2002:a1f:c904:0:b0:4d1:34a1:c892 with SMTP id
 z4-20020a1fc904000000b004d134a1c892mr4587776vkf.13.1712834906272; Thu, 11 Apr
 2024 04:28:26 -0700 (PDT)
MIME-Version: 1.0
References: <20240403-rss-v9-0-c6d87e69d38b@daynix.com>
 <20240403-rss-v9-13-c6d87e69d38b@daynix.com>
 <CAOEp5OdKAsUoJnLMXTM3RxbPT3c9Sob-7QRexCSqMNX10Enoug@mail.gmail.com>
 <60ad2ff3-ad95-49b8-8d6c-32bdcddde899@daynix.com>
In-Reply-To: <60ad2ff3-ad95-49b8-8d6c-32bdcddde899@daynix.com>
From: Yan Vugenfirer <yvugenfi@redhat.com>
Date: Thu, 11 Apr 2024 14:28:15 +0300
Message-ID: <CAGoVJZwEASjMwtuFZXcr0kmhzmGotAn+oKHB3Oen_bCpAWiAnQ@mail.gmail.com>
Subject: Re: [PATCH v9 13/20] virtio-net: Return an error when vhost cannot
 enable RSS
To: Akihiko Odaki <akihiko.odaki@daynix.com>
Cc: Yuri Benditovich <yuri.benditovich@daynix.com>,
 Jason Wang <jasowang@redhat.com>, 
 Dmitry Fleytman <dmitry.fleytman@gmail.com>,
 Sriram Yagnaraman <sriram.yagnaraman@est.tech>, 
 "Michael S. Tsirkin" <mst@redhat.com>, Luigi Rizzo <rizzo@iet.unipi.it>, 
 Giuseppe Lettieri <g.lettieri@iet.unipi.it>,
 Vincenzo Maffione <v.maffione@gmail.com>, 
 Andrew Melnychenko <andrew@daynix.com>, qemu-devel@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=170.10.133.124; envelope-from=yvugenfi@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -45
X-Spam_score: -4.6
X-Spam_bar: ----
X-Spam_report: (-4.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-2.49,
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

On Mon, Apr 8, 2024 at 4:31=E2=80=AFAM Akihiko Odaki <akihiko.odaki@daynix.=
com> wrote:
>
> On 2024/04/08 6:46, Yuri Benditovich wrote:
> > On Wed, Apr 3, 2024 at 2:11=E2=80=AFPM Akihiko Odaki <akihiko.odaki@day=
nix.com> wrote:
> >>
> >> vhost requires eBPF for RSS. When eBPF is not available, virtio-net
> >> implicitly disables RSS even if the user explicitly requests it. Retur=
n
> >> an error instead of implicitly disabling RSS if RSS is requested but n=
ot
> >> available.
> >>
> >> Signed-off-by: Akihiko Odaki <akihiko.odaki@daynix.com>
> >> ---
> >>   hw/net/virtio-net.c | 97 ++++++++++++++++++++++++++-----------------=
----------
> >>   1 file changed, 48 insertions(+), 49 deletions(-)
> >>
> >> diff --git a/hw/net/virtio-net.c b/hw/net/virtio-net.c
> >> index 61b49e335dea..3d53eba88cfc 100644
> >> --- a/hw/net/virtio-net.c
> >> +++ b/hw/net/virtio-net.c
> >> @@ -793,9 +793,6 @@ static uint64_t virtio_net_get_features(VirtIODevi=
ce *vdev, uint64_t features,
> >>           return features;
> >>       }
> >>
> >> -    if (!ebpf_rss_is_loaded(&n->ebpf_rss)) {
> >> -        virtio_clear_feature(&features, VIRTIO_NET_F_RSS);
> >> -    }
> >>       features =3D vhost_net_get_features(get_vhost_net(nc->peer), fea=
tures);
> >>       vdev->backend_features =3D features;
> >>
> >> @@ -3591,6 +3588,50 @@ static bool failover_hide_primary_device(Device=
Listener *listener,
> >>       return qatomic_read(&n->failover_primary_hidden);
> >>   }
> >>
> >> +static void virtio_net_device_unrealize(DeviceState *dev)
> >> +{
> >> +    VirtIODevice *vdev =3D VIRTIO_DEVICE(dev);
> >> +    VirtIONet *n =3D VIRTIO_NET(dev);
> >> +    int i, max_queue_pairs;
> >> +
> >> +    if (virtio_has_feature(n->host_features, VIRTIO_NET_F_RSS)) {
> >> +        virtio_net_unload_ebpf(n);
> >> +    }
> >> +
> >> +    /* This will stop vhost backend if appropriate. */
> >> +    virtio_net_set_status(vdev, 0);
> >> +
> >> +    g_free(n->netclient_name);
> >> +    n->netclient_name =3D NULL;
> >> +    g_free(n->netclient_type);
> >> +    n->netclient_type =3D NULL;
> >> +
> >> +    g_free(n->mac_table.macs);
> >> +    g_free(n->vlans);
> >> +
> >> +    if (n->failover) {
> >> +        qobject_unref(n->primary_opts);
> >> +        device_listener_unregister(&n->primary_listener);
> >> +        migration_remove_notifier(&n->migration_state);
> >> +    } else {
> >> +        assert(n->primary_opts =3D=3D NULL);
> >> +    }
> >> +
> >> +    max_queue_pairs =3D n->multiqueue ? n->max_queue_pairs : 1;
> >> +    for (i =3D 0; i < max_queue_pairs; i++) {
> >> +        virtio_net_del_queue(n, i);
> >> +    }
> >> +    /* delete also control vq */
> >> +    virtio_del_queue(vdev, max_queue_pairs * 2);
> >> +    qemu_announce_timer_del(&n->announce_timer, false);
> >> +    g_free(n->vqs);
> >> +    qemu_del_nic(n->nic);
> >> +    virtio_net_rsc_cleanup(n);
> >> +    g_free(n->rss_data.indirections_table);
> >> +    net_rx_pkt_uninit(n->rx_pkt);
> >> +    virtio_cleanup(vdev);
> >> +}
> >> +
> >>   static void virtio_net_device_realize(DeviceState *dev, Error **errp=
)
> >>   {
> >>       VirtIODevice *vdev =3D VIRTIO_DEVICE(dev);
> >> @@ -3760,53 +3801,11 @@ static void virtio_net_device_realize(DeviceSt=
ate *dev, Error **errp)
> >>
> >>       net_rx_pkt_init(&n->rx_pkt);
> >>
> >> -    if (virtio_has_feature(n->host_features, VIRTIO_NET_F_RSS)) {
> >> -        virtio_net_load_ebpf(n);
> >> -    }
> >> -}
> >> -
> >> -static void virtio_net_device_unrealize(DeviceState *dev)
> >> -{
> >> -    VirtIODevice *vdev =3D VIRTIO_DEVICE(dev);
> >> -    VirtIONet *n =3D VIRTIO_NET(dev);
> >> -    int i, max_queue_pairs;
> >> -
> >> -    if (virtio_has_feature(n->host_features, VIRTIO_NET_F_RSS)) {
> >> -        virtio_net_unload_ebpf(n);
> >> +    if (virtio_has_feature(n->host_features, VIRTIO_NET_F_RSS) &&
> >
> > I disagree with this change of qemu behavior.
> >  From my point of view:
> > - this is not a major problem and it should not be a reason to stop VM =
execution
> > - it is enough to disable the RSS feature and continue working. Dependi=
ng on
> >    other qemu parameters (number of queues, number of cpus) this might =
be just
> >    suboptimal. might be a minor problem and might be not a problem at a=
ll
>

I think the basic example is when the kernel doesn't support ebpf
loading (either old kernel or kernel that, for some security reason,
disabled the capability). In this case, we will get a behavior change.

Best regards,
Yan.

>
> The reasoning is that we shouldn't disable what the user explicitly
> requested. c.f.,
> https://lore.kernel.org/all/20231102091717-mutt-send-email-mst@kernel.org=
/
>
> > - this change defines rss as _only_ feature whose absence breaks the VM=
 start,
> >    _all_ other features are dropped silently and only rss is not. Why??
>
> I'm following what QEMU does in the other places rather than what it
> does just in virtio-net. I have pointed out virtio-gpu raises errors in
> such a situation. c.f.,
> https://lore.kernel.org/all/8880b6f9-f556-46f7-a191-eeec0fe208b0@daynix.c=
om
>
> > - the series has a title 'Fixes and improvements' . This is not a fix a=
nd not an
> >    improvement, this is significant behavioral change that should be di=
scussed in
> >    light of future plans regarding rss
> > - I suggest to remove this change from the series, submit it separately
> >    and discuss from all the sides
>
> We should have already discussed about these matters; I responded all
> past replies in the previous versions months ago and had no update after
> that. Let's focus on matters that were not previously pointed out.
>
> Regards,
> Akihiko Odaki
>


