Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 97071C48291
	for <qemu-devel@archiver.kernel.org>; Mon,  5 Feb 2024 10:51:30 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rWwZM-0002ez-Cu; Mon, 05 Feb 2024 05:51:20 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <sgarzare@redhat.com>)
 id 1rWwZF-0002cU-LO
 for qemu-devel@nongnu.org; Mon, 05 Feb 2024 05:51:13 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <sgarzare@redhat.com>)
 id 1rWwZD-0000sv-Vf
 for qemu-devel@nongnu.org; Mon, 05 Feb 2024 05:51:13 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1707130271;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=sN2ADiOPTTMpaxcZmcPJP9kREbay7WNQTG4cJ7VhlWo=;
 b=TJBup1YvsGhfLtsOAZDLF12Jy2y80K9zXP2GcTPfEx/f3Z9Mfz8mfTAzYyTis6SzxmIczZ
 03ryPd1Y6HAq2xcGtr3bRQWSqyBUiMzwZ7Q8GiD53OVchiUuqZC4ZzpypbY5sO+8viC6UW
 jkX2Zs/UquAQNAtK+6tvSlEx6JrgtXY=
Received: from mail-ej1-f71.google.com (mail-ej1-f71.google.com
 [209.85.218.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-509-H5A8JB0FOXiCh6JjHYoYRQ-1; Mon, 05 Feb 2024 05:51:09 -0500
X-MC-Unique: H5A8JB0FOXiCh6JjHYoYRQ-1
Received: by mail-ej1-f71.google.com with SMTP id
 a640c23a62f3a-a2bc65005feso309987266b.0
 for <qemu-devel@nongnu.org>; Mon, 05 Feb 2024 02:51:09 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1707130268; x=1707735068;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=sN2ADiOPTTMpaxcZmcPJP9kREbay7WNQTG4cJ7VhlWo=;
 b=WfXMb7+W1mHyuaT+G1I7Nn0K1/LLZytbwz1VlqLywl5WVCem9RKzlUsHyJ6hHUMFrN
 p8/Z53qFQXFB03oUzh6njzC1IVwLE9BRLS8M25Qmn2iiFthiQlJhBe3j2CkRBmdygts0
 zCtFhRJsXWm4vnQDyXtM1rDOhQEoGbKmtcclp89eqUFqVX9JjOUuzVzk6swpaPHAmJSU
 XelwjkujHgH4m/dc4GrHoy7+HoyxQuHGCJAN7VPiZq0SwsSvBasx5+2AW5fzu8jsVJ5g
 eln3fmtZcmDl7MULuo2WTX1J4gxo1oKhtoO2dnoIqIluJOoy68A/YSZtU4FvlQjY07fI
 R1vw==
X-Gm-Message-State: AOJu0Yy3tOHMaVMDd9DOIrd6WpNAtdjUQ4/FTgPNF/r7YX1SeqCzChh5
 ETUR3/HfE85IAJMAbycxnSTT0BdpkqUxhg4XE3YWIA0aRvIENlXw4K9zDnQxwFiui/oP6/woVCG
 mB9P6RGt855+NdbRfz6WCJYG6XiMAGjb6DA0tX6vrAPzVXpP35lcO
X-Received: by 2002:a17:907:7746:b0:a37:29a8:affd with SMTP id
 kx6-20020a170907774600b00a3729a8affdmr4798962ejc.7.1707130268225; 
 Mon, 05 Feb 2024 02:51:08 -0800 (PST)
X-Google-Smtp-Source: AGHT+IEJXRw4QLY66QlLWk31Q8H/ghPb6oWTdSl/N9tWoqJriK6h9Roja5Cz3eBS8QRyUoUGJxbDeg==
X-Received: by 2002:a17:907:7746:b0:a37:29a8:affd with SMTP id
 kx6-20020a170907774600b00a3729a8affdmr4798950ejc.7.1707130267856; 
 Mon, 05 Feb 2024 02:51:07 -0800 (PST)
X-Forwarded-Encrypted: i=0;
 AJvYcCWQBVCiu7nAVNKh2xDfyEy3H2aUMg8ALLVxZJRGXmXGl3W21X6gjwIt3ICpdSc5+b/AwoF6MUiTrTs7GBdHaBB7d7T3JghHPWB6ug4GgzKqBCpV+RJh41YYBkVTIVN1t8IXxwcG6jT6yJo1b6hym1QqzdKDTpLmE5RhgMYsFtizxGT1ZuJ+vwZze//GNPGAWOq6V3d2DfQC
Received: from sgarzare-redhat (host-87-12-25-87.business.telecomitalia.it.
 [87.12.25.87]) by smtp.gmail.com with ESMTPSA id
 gf11-20020a170906e20b00b00a37cb06d937sm756521ejb.222.2024.02.05.02.51.06
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 05 Feb 2024 02:51:07 -0800 (PST)
Date: Mon, 5 Feb 2024 11:51:03 +0100
From: Stefano Garzarella <sgarzare@redhat.com>
To: Kevin Wolf <kwolf@redhat.com>, 
 Eugenio =?utf-8?B?UMOpcmV6?= <eperezma@redhat.com>,
 Jason Wang <jasowang@redhat.com>
Cc: qemu-block@nongnu.org, mst@redhat.com, eperezma@redhat.com, 
 qemu-devel@nongnu.org, qemu-stable@nongnu.org
Subject: Re: [PATCH] vdpa-dev: Fix initialisation order to restore VDUSE
 compatibility
Message-ID: <zmopxf5zt6m36nfujntn72idlinm7qmx23wjvwiazmq4b75lsa@a2omit34pjif>
References: <20240202132521.32714-1-kwolf@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <20240202132521.32714-1-kwolf@redhat.com>
Received-SPF: pass client-ip=170.10.129.124; envelope-from=sgarzare@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.361,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001, T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

On Fri, Feb 02, 2024 at 02:25:21PM +0100, Kevin Wolf wrote:
>VDUSE requires that virtqueues are first enabled before the DRIVER_OK
>status flag is set; with the current API of the kernel module, it is
>impossible to enable the opposite order in our block export code because
>userspace is not notified when a virtqueue is enabled.

Yeah, IMHO the VDUSE protocol is missing a VDUSE_SET_VQ_READY message,
I'll start another thread about that, but in the meantime I agree that
we should fix QEMU since we need to work properly with old kernels as
well.

>
>This requirement also mathces the normal initialisation order as done by
>the generic vhost code in QEMU. However, commit 6c482547 accidentally
>changed the order for vdpa-dev and broke access to VDUSE devices with
>this.
>
>This changes vdpa-dev to use the normal order again and use the standard
>vhost callback .vhost_set_vring_enable for this. VDUSE devices can be
>used with vdpa-dev again after this fix.

I like this approach and the patch LGTM, but I'm a bit worried about
this function in hw/net/vhost_net.c:

     int vhost_set_vring_enable(NetClientState *nc, int enable)
     {
         VHostNetState *net = get_vhost_net(nc);
         const VhostOps *vhost_ops = net->dev.vhost_ops;

         nc->vring_enable = enable;

         if (vhost_ops && vhost_ops->vhost_set_vring_enable) {
             return vhost_ops->vhost_set_vring_enable(&net->dev, enable);
         }

         return 0;
     }

@Eugenio, @Jason, should we change some things there if vhost-vdpa
implements the vhost_set_vring_enable callback?

Do you remember why we didn't implement it from the beginning?

Thanks,
Stefano

>
>Cc: qemu-stable@nongnu.org
>Fixes: 6c4825476a4351530bcac17abab72295b75ffe98
>Signed-off-by: Kevin Wolf <kwolf@redhat.com>
>---
> hw/virtio/vdpa-dev.c   |  5 +----
> hw/virtio/vhost-vdpa.c | 17 +++++++++++++++++
> 2 files changed, 18 insertions(+), 4 deletions(-)
>
>diff --git a/hw/virtio/vdpa-dev.c b/hw/virtio/vdpa-dev.c
>index eb9ecea83b..13e87f06f6 100644
>--- a/hw/virtio/vdpa-dev.c
>+++ b/hw/virtio/vdpa-dev.c
>@@ -253,14 +253,11 @@ static int vhost_vdpa_device_start(VirtIODevice *vdev, Error **errp)
>
>     s->dev.acked_features = vdev->guest_features;
>
>-    ret = vhost_dev_start(&s->dev, vdev, false);
>+    ret = vhost_dev_start(&s->dev, vdev, true);
>     if (ret < 0) {
>         error_setg_errno(errp, -ret, "Error starting vhost");
>         goto err_guest_notifiers;
>     }
>-    for (i = 0; i < s->dev.nvqs; ++i) {
>-        vhost_vdpa_set_vring_ready(&s->vdpa, i);
>-    }
>     s->started = true;
>
>     /*
>diff --git a/hw/virtio/vhost-vdpa.c b/hw/virtio/vhost-vdpa.c
>index 3a43beb312..c4574d56c5 100644
>--- a/hw/virtio/vhost-vdpa.c
>+++ b/hw/virtio/vhost-vdpa.c
>@@ -904,6 +904,22 @@ int vhost_vdpa_set_vring_ready(struct vhost_vdpa *v, unsigned idx)
>     return r;
> }
>
>+static int vhost_vdpa_set_vring_enable(struct vhost_dev *dev, int enable)
>+{
>+    struct vhost_vdpa *v = dev->opaque;
>+    unsigned int i;
>+    int ret;
>+
>+    for (i = 0; i < dev->nvqs; ++i) {
>+        ret = vhost_vdpa_set_vring_ready(v, i);
>+        if (ret < 0) {
>+            return ret;
>+        }
>+    }
>+
>+    return 0;
>+}
>+
> static int vhost_vdpa_set_config_call(struct vhost_dev *dev,
>                                        int fd)
> {
>@@ -1524,6 +1540,7 @@ const VhostOps vdpa_ops = {
>         .vhost_set_features = vhost_vdpa_set_features,
>         .vhost_reset_device = vhost_vdpa_reset_device,
>         .vhost_get_vq_index = vhost_vdpa_get_vq_index,
>+        .vhost_set_vring_enable = vhost_vdpa_set_vring_enable,
>         .vhost_get_config  = vhost_vdpa_get_config,
>         .vhost_set_config = vhost_vdpa_set_config,
>         .vhost_requires_shm_log = NULL,
>-- 
>2.43.0
>


