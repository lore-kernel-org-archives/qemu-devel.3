Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BAAF6E87822
	for <qemu-devel@archiver.kernel.org>; Tue,  3 Feb 2026 12:49:19 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vnFpo-0001zc-VV; Tue, 03 Feb 2026 07:48:49 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1vnFpl-0001yl-HE
 for qemu-devel@nongnu.org; Tue, 03 Feb 2026 07:48:45 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1vnFpj-0002m3-Hf
 for qemu-devel@nongnu.org; Tue, 03 Feb 2026 07:48:45 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1770122921;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=W7eYw02tjAxzfZe6gejgbddh6JJKoigYaRzE+1EQfpE=;
 b=B9J8wEU734KJtWEBFeBFPl0vd0slvJ1Ow4iXC05skBbeq9QFkDJbPKTpgE8eaD47VFdQqs
 CKm6RpsmtxE9XUY1qhXNg0n8r/mNxiYNri+Tmo8SEOTYp3y2BebJnckIjL1XpAGPhIruBO
 pv1QLfeAIEhhBoQp/Bii5JQmruaEF6k=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-358-KvJtLkpuNGaCvw9vzXbBZQ-1; Tue, 03 Feb 2026 07:48:40 -0500
X-MC-Unique: KvJtLkpuNGaCvw9vzXbBZQ-1
X-Mimecast-MFC-AGG-ID: KvJtLkpuNGaCvw9vzXbBZQ_1770122919
Received: by mail-wm1-f71.google.com with SMTP id
 5b1f17b1804b1-47edfdc6c1aso44980755e9.3
 for <qemu-devel@nongnu.org>; Tue, 03 Feb 2026 04:48:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1770122919; x=1770727719; darn=nongnu.org;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :mime-version:references:message-id:subject:cc:to:from:date:from:to
 :cc:subject:date:message-id:reply-to;
 bh=W7eYw02tjAxzfZe6gejgbddh6JJKoigYaRzE+1EQfpE=;
 b=uA+LOUgAe//W3/7RyEwF0xAQxtaR4JqwGTaun0AGzbWoowmwsKvlypYCyp55nQ7aPp
 JaBBK2e/vmqxbQI8knLUUeJno0ZNqjOCrDdhAwqmI6wDB9BcegZtwgeYilDg7P3eOBKj
 e4XUR2LYgKJo1qLajXn2bhPwlmR9cNT3d9Lfp4+jKc9cWQAPeMRKp7mvuPGGsydAEPrx
 M8DFY6TYOCBJhYUTgUMsfQfMjS8WpdkSLZTUWkViugLTjbnVx53qoUZzEsZjUYhvY+nl
 igcTOHfwqAMESMsfSSh0xGxIu0/bmmXLj9GfDCiPSNafhbJQsiDILcacnqzCwnhOey64
 4Itg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1770122919; x=1770727719;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :mime-version:references:message-id:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=W7eYw02tjAxzfZe6gejgbddh6JJKoigYaRzE+1EQfpE=;
 b=rZnSgj35k6EBkaaUPnDkxbcSfPISa6coXpx7jocy8SyK8BOSsu8CQgtuNVBU7aEjSb
 GPiyrLXKEyua3cb0LdAoyj2lv34kz4gDv11i6V+yCKkXiq3Hs7JG9NoRiKvWryAJLNwF
 WhFcnnHnwVhr21jBoI6BXHhlIR1H47lyZz98pm53tgYav8HE0bwETp1GSdWw0niZFDom
 M17a2PywZpCVzAv8haPG4A3LuEUS7lRgtfHacCnubJFieQnrGwkJBPB9bX68FXLk8ovd
 EvGPswno6RNjMrbXwJC/1mgZf02LO7rqHGRSS2W+8SVPPirbB15r5MYVbVlqaA7fJR/a
 Ping==
X-Forwarded-Encrypted: i=1;
 AJvYcCXaYz9wh8RpKsyxptdIcRlQkCD50KIhKZ46g+NtyIXszb/UBEbhgE0bd8yLywWJOBJdckmkLkWHJMth@nongnu.org
X-Gm-Message-State: AOJu0YwP+y6+/Tkqjgx4ROYW8uo74zZ1ElqiNndWspMsw5hs6WEfqgCc
 j0SeTf/wk1oICWZg/bkTLtTJ6lys8a3WZViHya2rHxQ+BsZAtZbYG/tAEL4GQYScpW2TJ6aejMN
 xW7p/EfEWLYUDND0TYdRAEeLwWQ21eS2siRxXxQy5+Q6s1w3/yQsdZmEL
X-Gm-Gg: AZuq6aKwO/PcORyo9yxLEWRUy9Yqj6NbCIoazTzlOlj5OlJlgPMQwwe5mbzzMf7XNPH
 QcrQoQqQXhpfp3RG5clzJdmyFb8JtJ0FoWlkwr6zMzXKyzhb4s6Ym3MwCbkgPN1tbWaR3A9HfVH
 gHhcini3GR1v4XLV8BRN9aq65zW4uRaxfZjk5oD5jbz52rC3dP+WXH9sHG86MqXBfkxhGgrnrSx
 Ly4jTlmdkmH8wVZHmRSPbx8oy1ngEkfjcMGfmya2PH2PcBcgYZjPCwHev9Nalq8RkZOAk0wiRji
 MX1gOt9nGWUSYPLS+e6XdZcP5a7Mu1qcNflbkUU9MxmeO9JKlExKBbSsq5S8Yj6TlZEGZnzhznY
 P2Iw+q47LljDBnEOCNiiVKF7ajh35GuQe0A==
X-Received: by 2002:a05:600c:3b1e:b0:477:58af:a91d with SMTP id
 5b1f17b1804b1-482db4569b5mr188809625e9.5.1770122918924; 
 Tue, 03 Feb 2026 04:48:38 -0800 (PST)
X-Received: by 2002:a05:600c:3b1e:b0:477:58af:a91d with SMTP id
 5b1f17b1804b1-482db4569b5mr188809245e9.5.1770122918428; 
 Tue, 03 Feb 2026 04:48:38 -0800 (PST)
Received: from redhat.com (IGLD-80-230-34-155.inter.net.il. [80.230.34.155])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-435e131cfc9sm51465454f8f.21.2026.02.03.04.48.36
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 03 Feb 2026 04:48:37 -0800 (PST)
Date: Tue, 3 Feb 2026 07:48:34 -0500
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Jason Wang <jasowang@redhat.com>
Cc: =?utf-8?B?6ZmI5rWp?= <chenh@yusur.tech>,
 Raphael Norwitz <raphael.norwitz@nutanix.com>,
 "kwolf@redhat.com" <kwolf@redhat.com>,
 "hreitz@redhat.com" <hreitz@redhat.com>,
 "qemu-block@nongnu.org" <qemu-block@nongnu.org>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
 "houyl@yusur.tech" <houyl@yusur.tech>, "zy@yusur.tech" <zy@yusur.tech>,
 "lulu@redhat.com" <lulu@redhat.com>
Subject: Re: [PATCH v2] hw/virtio/vhost-user: support obtain vdpa device's
 mac address automatically
Message-ID: <20260203074633-mutt-send-email-mst@kernel.org>
References: <20220921060026.392164-1-chenh@yusur.tech>
 <BL3PR02MB79380882D0B877C2D5A754FFEA4F9@BL3PR02MB7938.namprd02.prod.outlook.com>
 <CACGkMEttGsDrFo_U7AKHEof0HwVfHaRTeQSRE+QTiRPPtnU3hQ@mail.gmail.com>
 <20220922055531-mutt-send-email-mst@kernel.org>
 <fbf87d19-f7ab-dfdb-9f93-4087262cad57@yusur.tech>
 <CACGkMEuc22yQwNTe5NeQH1ooxk_HgM7tpuTFcNKWZVmYEJPAwA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CACGkMEuc22yQwNTe5NeQH1ooxk_HgM7tpuTFcNKWZVmYEJPAwA@mail.gmail.com>
Received-SPF: pass client-ip=170.10.133.124; envelope-from=mst@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

On Fri, Sep 23, 2022 at 11:36:38AM +0800, Jason Wang wrote:
> On Fri, Sep 23, 2022 at 11:33 AM 陈浩 <chenh@yusur.tech> wrote:
> >
> >
> > On 2022/9/22 17:56, Michael S. Tsirkin wrote:
> > > On Thu, Sep 22, 2022 at 09:34:41AM +0800, Jason Wang wrote:
> > >> On Thu, Sep 22, 2022 at 1:58 AM Raphael Norwitz
> > >> <raphael.norwitz@nutanix.com> wrote:
> > >>> If I read your response on the other thread correctly, this change is intended
> > >>>
> > >>> to prioritize the MAC address exposed by DPDK over the one provided by the
> > >>>
> > >>> QEMU command line? Sounds reasonable in principle, but I would get confirmation
> > >>>
> > >>> from vDPA/vhost-net maintainers.
> > >> I think the best way is to (and it seems easier)
> > >>
> > >> 1) have the management layer to make sure the mac came from cli
> > >> matches the underlayer vDPA
> > >> 2) having a sanity check and fail the device initialization if they don't match
> > >>
> > >> Thanks
> > > I think I agree, we should not overwrite user supplied arguments.
> > > I think the case where we might want to get the mac from VDPA
> > > and use it is when it's been assigned randomly as opposed to coming from cli.
> > Yes, when the cli passes in a random mac address that is inconsistent
> > with the vdpa device, qemu still starts the virtual machine as usual,
> > but in this case, the qemu and vdpa environments do not work correctly.
> > So I want to get mac address directly from vdpa device instead of cli.
> 
> Let's teach the management to do that. It has a lot of advantages, more below.


No, making command line friendlier is a good idea.
the random address from cli is just that, random,
so why not take it from backend?


> Not sure for the DPDK case, but kernel vDPA allows the mgmt to
> provision the vDPA with a mac address which could be used in this
> case.
> 
> >
> > Having a sanity check and fail the device initialization if they don't
> > match is a good idea, but it seems more convenient to directly overwrite
> > the cli mac address.
> 
> This will confuse the management where it may do a lot of mac related setups.
> 
> Thanks

i do not think any management relies on the random mac hack.

> > >
> > >
> > >>>
> > >>>
> > >>> That said the way you’re hacking the vhost-user code breaks a valuable check for
> > >>>
> > >>> bad vhost-user-blk backends. I would suggest finding another implementation which
> > >>>
> > >>> does not regress functionality for other device types.
> > >>>
> > >>>
> > >>>
> > >>>
> > >>>
> > >>>> From: Hao Chen <chenh@yusur.tech>
> > >>>> When use dpdk-vdpa tests vdpa device. You need to specify the mac address to
> > >>>> start the virtual machine through libvirt or qemu, but now, the libvirt or
> > >>>> qemu can call dpdk vdpa vendor driver's ops .get_config through vhost_net_get_config
> > >>>> to get the mac address of the vdpa hardware without manual configuration.
> > >>>> v1->v2:
> > >>>> Only copy ETH_ALEN data of netcfg for some vdpa device such as
> > >>>> NVIDIA BLUEFIELD DPU(BF2)'s netcfg->status is not right.
> > >>>> We only need the mac address and don't care about the status field.
> > >>>> Signed-off-by: Hao Chen <chenh@yusur.tech>
> > >>>> ---
> > >>>> hw/block/vhost-user-blk.c |  1 -
> > >>>> hw/net/virtio-net.c       |  7 +++++++
> > >>>> hw/virtio/vhost-user.c    | 19 -------------------
> > >>>> 3 files changed, 7 insertions(+), 20 deletions(-)
> > >>>> diff --git a/hw/block/vhost-user-blk.c b/hw/block/vhost-user-blk.c
> > >>>> index 9117222456..5dca4eab09 100644
> > >>>> --- a/hw/block/vhost-user-blk.c
> > >>>> +++ b/hw/block/vhost-user-blk.c
> > >>>> @@ -337,7 +337,6 @@ static int vhost_user_blk_connect(DeviceState *dev, Error **errp)
> > >>>>      vhost_dev_set_config_notifier(&s->dev, &blk_ops);
> > >>>> -    s->vhost_user.supports_config = true;
> > >>>>      ret = vhost_dev_init(&s->dev, &s->vhost_user, VHOST_BACKEND_TYPE_USER, 0,
> > >>>>                           errp);
> > >>>>      if (ret < 0) {
> > >>>> diff --git a/hw/net/virtio-net.c b/hw/net/virtio-net.c
> > >>>> index dd0d056fde..90405083b1 100644
> > >>>> --- a/hw/net/virtio-net.c
> > >>>> +++ b/hw/net/virtio-net.c
> > >>>> @@ -166,6 +166,13 @@ static void virtio_net_get_config(VirtIODevice *vdev, uint8_t *config)
> > >>>>              }
> > >>>>              memcpy(config, &netcfg, n->config_size);
> > >>>>          }
> > >>>> +    } else if (nc->peer && nc->peer->info->type == NET_CLIENT_DRIVER_VHOST_USER) {
> > >>>> +        ret = vhost_net_get_config(get_vhost_net(nc->peer), (uint8_t *)&netcfg,
> > >>>> +                                   n->config_size);
> > >>>> +        if (ret != -1) {
> > >>>> +               /* Automatically obtain the mac address of the vdpa device
> > >>>> +                * when using the dpdk vdpa */
> > >>>> +                memcpy(config, &netcfg, ETH_ALEN);
> > >>>>      }
> > >>>> }
> > >>>> diff --git a/hw/virtio/vhost-user.c b/hw/virtio/vhost-user.c
> > >>>> index bd24741be8..8b01078249 100644
> > >>>> --- a/hw/virtio/vhost-user.c
> > >>>> +++ b/hw/virtio/vhost-user.c
> > >>>> @@ -2013,8 +2013,6 @@ static int vhost_user_backend_init(struct vhost_dev *dev, void *opaque,
> > >>>>      }
> > >>>>      if (virtio_has_feature(features, VHOST_USER_F_PROTOCOL_FEATURES)) {
> > >>>> -        bool supports_f_config = vus->supports_config ||
> > >>>> -            (dev->config_ops && dev->config_ops->vhost_dev_config_notifier);
> > >>>>          uint64_t protocol_features;
> > >>>>          dev->backend_features |= 1ULL << VHOST_USER_F_PROTOCOL_FEATURES;
> > >>>> @@ -2033,23 +2031,6 @@ static int vhost_user_backend_init(struct vhost_dev *dev, void *opaque,
> > >>>>           */
> > >>>>          protocol_features &= VHOST_USER_PROTOCOL_FEATURE_MASK;
> > >>>> -        if (supports_f_config) {
> > >>>> -            if (!virtio_has_feature(protocol_features,
> > >>>> -                                    VHOST_USER_PROTOCOL_F_CONFIG)) {
> > >>>> -                error_setg(errp, "vhost-user device expecting "
> > >>>> -                           "VHOST_USER_PROTOCOL_F_CONFIG but the vhost-user backend does "
> > >>>> -                           "not support it.");
> > >>>> -                return -EPROTO;
> > >>>> -            }
> > >>>> -        } else {
> > >>>> -            if (virtio_has_feature(protocol_features,
> > >>>> -                                   VHOST_USER_PROTOCOL_F_CONFIG)) {
> > >>>> -                warn_reportf_err(*errp, "vhost-user backend supports "
> > >>>> -                                 "VHOST_USER_PROTOCOL_F_CONFIG but QEMU does not.");
> > >>>> -                protocol_features &= ~(1ULL << VHOST_USER_PROTOCOL_F_CONFIG);
> > >>>> -            }
> > >>>> -        }
> > >>>> -
> > >>>>          /* final set of protocol features */
> > >>>>          dev->protocol_features = protocol_features;
> > >>>>          err = vhost_user_set_protocol_features(dev, dev->protocol_features);
> > >>>> --
> > >>>> 2.27.0
> > >>>
> > >
> >


