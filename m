Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E2713C0219D
	for <qemu-devel@archiver.kernel.org>; Thu, 13 Feb 2025 15:44:38 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tibNZ-0002a7-Qr; Thu, 13 Feb 2025 10:43:53 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <sgarzare@redhat.com>)
 id 1tibNX-0002Zn-R1
 for qemu-devel@nongnu.org; Thu, 13 Feb 2025 10:43:51 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <sgarzare@redhat.com>)
 id 1tibNV-0002dz-Ud
 for qemu-devel@nongnu.org; Thu, 13 Feb 2025 10:43:51 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1739461428;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=ACyBtYFfCtMsFuuaFrla2QDZZooI4bNTevGfI4ONTBg=;
 b=HWAH7WhLq+MM75uOdNx5gNquijgCN5G4ljnFH04uZRoDMCdxlta1VIEPq33n3m1lqkUf1S
 MjGvXf+KkKkbRo/zzTClTXIg46owWZRFhciEG5ZgOGmnklS18dBOMYHu2K876VKJ7lF9mX
 YpkPW02DsmFRzevyaLElEktFQ4HvpvM=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-326-_qtviuWWMECD3bCtix3LRw-1; Thu, 13 Feb 2025 10:43:43 -0500
X-MC-Unique: _qtviuWWMECD3bCtix3LRw-1
X-Mimecast-MFC-AGG-ID: _qtviuWWMECD3bCtix3LRw_1739461420
Received: by mail-wm1-f70.google.com with SMTP id
 5b1f17b1804b1-4394c0a58e7so7746535e9.0
 for <qemu-devel@nongnu.org>; Thu, 13 Feb 2025 07:43:42 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1739461420; x=1740066220;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=ACyBtYFfCtMsFuuaFrla2QDZZooI4bNTevGfI4ONTBg=;
 b=i+rjpMtyRfy7bXbG9jVjwqdC0iUPHjqC1Uf9/1tJHLmqAxBHxq/7HwCdjHlVZN8BPp
 k+fGkPASU2Qa9SScnoTsvE/HeAOS7H48UrScI4eX/CJZmP5X6FtNr0+a70vES+EtdM9m
 fZGUogg6xHBcIszSGhOo3X787aNKX1zzCL2uy2PVUasn7WUzV7Sra2YX8s8+8pMZr01X
 21N+lb3S/2GVZQpf+IKdBCW/tYMIGjRnTWNbhCdnfGOf4sdk03QMrq/2BF5Eo24R6E6W
 iyl1einMwMJYHdZohl0wUxSBdZajZLD7/lmmfdhOEtw4KLhz9sMkkIJBjmMkO8iys2X+
 i0QA==
X-Gm-Message-State: AOJu0YzarEEOA4Peoa7Wz5fkkwPkn34I/bAbSqy+q1oJ7/q7ahVFNcFA
 tPTllQeZDbH/x/gdiJR5RuGKt2vDfOYkEmA6Dv/U2lhB2H8N+dCqn4bK4wV2Pd+gbsEFYVjiBJF
 zXoLL/qbfY6Rkw7ax1Qt1UK9rI9e90wcEUdVn8t143wNabrwjHQbl5G/cSb3P
X-Gm-Gg: ASbGncsZLHSpnr5l4sc9/O6RpqdOL0XgAUhz2y0RxPUHHngnMDvg6M8T7pacGglUp7O
 kaXWaWtUY8yUjkCDWYxCtcrRIsF8zpWUxLX8QLMLLdITBmIX5CvXSgW9RcVT5UQWVt/4hJ5WEPp
 /D9liXQ/SBWXftdS0X9rGsnodDKtJe56eL7BYLZfI2Km4/fJvd7KIjwzKWk/XAXJL7xlLEFyoqy
 4wD43lsO2dz9LoOO4jiZlOB3097N+trXiVIxCfyDLJJjNx4PNknNRu5gtdHK+kgp7//BEJw2jAb
 20nc4HfiyoWF+8DF8hHIvqn/hozJW1Sxiibt8nEca6OYrKdM0623Pw==
X-Received: by 2002:a05:600c:33a3:b0:439:5a37:815c with SMTP id
 5b1f17b1804b1-4395a3781dcmr72247695e9.20.1739461419861; 
 Thu, 13 Feb 2025 07:43:39 -0800 (PST)
X-Google-Smtp-Source: AGHT+IE1djmtDElUXYxJxHCg/o5SUO6OrcDtAh6fN7u/mYQtpjxUfHyhqopxqZ38AlF4xIwygpcArA==
X-Received: by 2002:a05:600c:33a3:b0:439:5a37:815c with SMTP id
 5b1f17b1804b1-4395a3781dcmr72247065e9.20.1739461419144; 
 Thu, 13 Feb 2025 07:43:39 -0800 (PST)
Received: from sgarzare-redhat (host-79-46-200-29.retail.telecomitalia.it.
 [79.46.200.29]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-38f259d65dfsm2237141f8f.64.2025.02.13.07.43.38
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 13 Feb 2025 07:43:38 -0800 (PST)
Date: Thu, 13 Feb 2025 16:43:34 +0100
From: Stefano Garzarella <sgarzare@redhat.com>
To: Matias Ezequiel Vara Larsen <mvaralar@redhat.com>
Cc: qemu-devel@nongnu.org, "Michael S. Tsirkin" <mst@redhat.com>, 
 Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Manos Pitsidianakis <manos.pitsidianakis@linaro.org>
Subject: Re: [PATCH] vhost-user-snd: Use virtio_get_config_size()
Message-ID: <CAGxU2F4Jzi+16Z_JKjhQREJ2FBGPOHheLhSoCOJ=6O-XL+k1NA@mail.gmail.com>
References: <20250213132513.767709-1-mvaralar@redhat.com>
 <z2bfkwpwfohvmj6xesdm2zmatlcwxta4aexq6x543lpnt47333@ayqfx3yxs5eb>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <z2bfkwpwfohvmj6xesdm2zmatlcwxta4aexq6x543lpnt47333@ayqfx3yxs5eb>
Received-SPF: pass client-ip=170.10.133.124; envelope-from=sgarzare@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -35
X-Spam_score: -3.6
X-Spam_bar: ---
X-Spam_report: (-3.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.495,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001,
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

Unrelated to this patch, but since we are talking about
VIRTIO_SND_F_CTLS, I think it would be good to send a patch to Linux to
make it clear that `controls` depends on VIRTIO_SND_F_CTLS.

For example in linux/include/uapi/linux/virtio_blk.h we have:

struct virtio_blk_config {
	/* The capacity (in 512-byte sectors). */
	__virtio64 capacity;
	/* The maximum segment size (if VIRTIO_BLK_F_SIZE_MAX) */
	__virtio32 size_max;
	/* The maximum number of segments (if VIRTIO_BLK_F_SEG_MAX) */
	__virtio32 seg_max;
	....

So I suggest something like this:

diff --git a/include/uapi/linux/virtio_snd.h b/include/uapi/linux/virtio_snd.h
index 5f4100c2cf04..a4cfb9f6561a 100644
--- a/include/uapi/linux/virtio_snd.h
+++ b/include/uapi/linux/virtio_snd.h
@@ -25,7 +25,7 @@ struct virtio_snd_config {
        __le32 streams;
        /* # of available channel maps */
        __le32 chmaps;
-       /* # of available control elements */
+       /* # of available control elements (if VIRTIO_SND_F_CTLS) */
        __le32 controls;
 };

Thanks,
Stefano


On Thu, 13 Feb 2025 at 16:31, Stefano Garzarella <sgarzare@redhat.com> wrote:
>
> For the title, what about this?
>
>    vhost-user-snd: fix incorrect config_size computation
>
> Or something like that, just to make clear that we are fixing a
> real issue.
>
> On Thu, Feb 13, 2025 at 02:25:13PM +0100, Matias Ezequiel Vara Larsen
> wrote:
> >Use virtio_get_config_size() rather than sizeof(struct
> >virtio_snd_config) for the config_size in the vhost-user-snd frontend.
> >The frontend shall rely on device features for the size of the device
> >configuration space. This fixes an issue introduced by commit ab0c7fb2
>
> When we refer to a commit it's a good practice to put both the sha1, but
> also the title, like this:
> This fixes an issue introduced by commit ab0c7fb22b ("linux-headers:
> update to current kvm/next") ...
>
> >in which the optional field `control` is added to the virtio_snd_config
>
> s/control/controls
>
> I would also specify here that the presence of `controls` in the config
> space depends on VIRTIO_SND_F_CTLS, citing the specification:
>
> 5.14.4 Device Configuration Layout
>   ...
>   controls
>      (driver-read-only) indicates a total number of all available control
>      elements if VIRTIO_SND_F_CTLS has been negotiated.
>
> >structure. This breaks vhost-user-device backends that do not implement
> >the `controls` field.
> >
>
> I'd suggest to add the fixes tag:
>
> Fixes: ab0c7fb22b ("linux-headers: update to current kvm/next")
>
> And maybe also:
>
> Cc: qemu-stable@nongnu.org
>
> >Resolves: https://gitlab.com/qemu-project/qemu/-/issues/2805
> >Suggested-by: Stefano Garzarella <sgarzare@redhat.com>
> >Signed-off-by: Matias Ezequiel Vara Larsen <mvaralar@redhat.com>
> >---
> > hw/virtio/vhost-user-snd.c | 18 +++++++++++++++++-
> > 1 file changed, 17 insertions(+), 1 deletion(-)
> >
> >diff --git a/hw/virtio/vhost-user-snd.c b/hw/virtio/vhost-user-snd.c
> >index 8610370af8..8da4309470 100644
> >--- a/hw/virtio/vhost-user-snd.c
> >+++ b/hw/virtio/vhost-user-snd.c
> >@@ -16,6 +16,18 @@
> > #include "standard-headers/linux/virtio_ids.h"
> > #include "standard-headers/linux/virtio_snd.h"
> >
> >+static const VirtIOFeature feature_sizes[] = {
> >+    {.flags = 1ULL << VIRTIO_SND_F_CTLS,
> >+    .end = endof(struct virtio_snd_config, controls)},
> >+    {}
> >+};
> >+
> >+static const VirtIOConfigSizeParams cfg_size_params = {
> >+    .min_size = endof(struct virtio_snd_config, chmaps),
> >+    .max_size = sizeof(struct virtio_snd_config),
> >+    .feature_sizes = feature_sizes
> >+};
> >+
> > static const VMStateDescription vu_snd_vmstate = {
> >     .name = "vhost-user-snd",
> >     .unmigratable = 1,
> >@@ -23,16 +35,20 @@ static const VMStateDescription vu_snd_vmstate = {
> >
> > static const Property vsnd_properties[] = {
> >     DEFINE_PROP_CHR("chardev", VHostUserBase, chardev),
> >+    DEFINE_PROP_BIT64("config-controls", VHostUserBase,
>
> In almost all other virtio/vhost-user devices, the property name does
> not have the prefix `config-`, but usually the thing after F_, in this
> case CTLS is cryptic, so IMO just `controls` should be fine.
>
> The only example I found is `config-wce` for vhost-user-blk, but in that
> case the feature is actually called VIRTIO_BLK_F_CONFIG_WCE.
>
> Thanks,
> Stefano
>
> >+                      parent_obj.host_features, VIRTIO_SND_F_CTLS, false),
> > };
> >
> > static void vu_snd_base_realize(DeviceState *dev, Error **errp)
> > {
> >     VHostUserBase *vub = VHOST_USER_BASE(dev);
> >     VHostUserBaseClass *vubs = VHOST_USER_BASE_GET_CLASS(dev);
> >+    VirtIODevice *vdev = &vub->parent_obj;
> >
> >     vub->virtio_id = VIRTIO_ID_SOUND;
> >     vub->num_vqs = 4;
> >-    vub->config_size = sizeof(struct virtio_snd_config);
> >+    vub->config_size = virtio_get_config_size(&cfg_size_params,
> >+                                              vdev->host_features);
> >     vub->vq_size = 64;
> >
> >     vubs->parent_realize(dev, errp);
> >--
> >2.42.0
> >


