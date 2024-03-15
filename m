Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 88FC8C54E67
	for <qemu-devel@archiver.kernel.org>; Fri, 15 Mar 2024 15:08:52 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rl9A8-0001jr-Ni; Fri, 15 Mar 2024 11:08:00 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <sgarzare@redhat.com>)
 id 1rl9A7-0001iy-91
 for qemu-devel@nongnu.org; Fri, 15 Mar 2024 11:07:59 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <sgarzare@redhat.com>)
 id 1rl9A2-0007OR-DN
 for qemu-devel@nongnu.org; Fri, 15 Mar 2024 11:07:58 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1710515273;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=KkDKLvNu1cZWPQdFoHazfvg9l7f5VzwLsoLGtElFrfs=;
 b=Y+4Zf3hLxWJhzR6RwgT5vvi1xwEwuyf6k58nFgcT0WDnPPloPFmadUxLbL4q0j7BNqNZcm
 GZACmIbkDTq0Pr1uriCXfD5snxI8QHdizu2KBq/E5GRZTpBg9S9H7U+yJadDEacGHyy46V
 t3JTv1dWDB2XGPfZ17sieNQRgE7EBs0=
Received: from mail-qk1-f197.google.com (mail-qk1-f197.google.com
 [209.85.222.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-464-ZrMmomcLMM6H1njdo1mHjA-1; Fri, 15 Mar 2024 11:07:52 -0400
X-MC-Unique: ZrMmomcLMM6H1njdo1mHjA-1
Received: by mail-qk1-f197.google.com with SMTP id
 af79cd13be357-787dea68f58so202371385a.3
 for <qemu-devel@nongnu.org>; Fri, 15 Mar 2024 08:07:52 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1710515272; x=1711120072;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=KkDKLvNu1cZWPQdFoHazfvg9l7f5VzwLsoLGtElFrfs=;
 b=rGP9X3YHn2rx8/oibcLtYIK7SiAK6PIDcAJI8ZlaG5XdpCtOkYqiw03vC2ykETq5NS
 LIKSGhwK7cDGc2V6bsLPpZDeyJcktKyvcPGWcNVuw/hNxcRdsq5nnOAyjYOXSbXq7+L3
 ltkYl5NgZK3dyKvFQQaMwctVps5GT+0Qq29xT8KigudRP0iNsVlYjw0KRftq0wh/g8xD
 dbsOGeT5xM9fkPne302F+Uh2BQWj58o4UBikuMEY1f6wK7rdhlq6uipFZVpZq9E8LziG
 qw1Nrr7IbI29ZbQAu725VQbGHYQ981+H885FLOveQaacuTbUkPBHNn7gdlSFXNOQAQeE
 YwdA==
X-Forwarded-Encrypted: i=1;
 AJvYcCV4I15HfwBN+Gw6/+fK/3KW+QopzAb4z/chg1LadaBnpbveY+QoGH4XXji5A1NjTg/H8345IiZ1cjr+0fPMv/S2ie5+BaM=
X-Gm-Message-State: AOJu0Yy94D7VP3gCI2ISni0E2mNzdwR3JFOUzt504iR5n4VuiMZKNyK7
 /wetjDoQ+J2L/Fxy42C5zREcb0hYqSOuzQ8Ikhm7Je//c2/nCym6ROQBNJoeeyZSnVMRTdntTKP
 nTu5EDJrcizSk+QolRIiuwDU1a7n+Bsqc2S8qdIMg1i3R1OlX7NRS
X-Received: by 2002:a05:620a:1108:b0:788:21f3:bfa4 with SMTP id
 o8-20020a05620a110800b0078821f3bfa4mr5168232qkk.57.1710515272051; 
 Fri, 15 Mar 2024 08:07:52 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFFKOxU5mswKEnJBLp+ACpWqciai9VipzVtZBvXGJXjwcL7az0fitp7Xi8TGKZ3d5g9TAwe/A==
X-Received: by 2002:a05:620a:1108:b0:788:21f3:bfa4 with SMTP id
 o8-20020a05620a110800b0078821f3bfa4mr5168207qkk.57.1710515271701; 
 Fri, 15 Mar 2024 08:07:51 -0700 (PDT)
Received: from sgarzare-redhat (host-87-12-25-33.business.telecomitalia.it.
 [87.12.25.33]) by smtp.gmail.com with ESMTPSA id
 c25-20020ae9e219000000b00789d7111878sm1927847qkc.76.2024.03.15.08.07.49
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 15 Mar 2024 08:07:51 -0700 (PDT)
Date: Fri, 15 Mar 2024 16:07:45 +0100
From: Stefano Garzarella <sgarzare@redhat.com>
To: Kevin Wolf <kwolf@redhat.com>
Cc: qemu-block@nongnu.org, mst@redhat.com, eperezma@redhat.com, 
 jasowang@redhat.com, qemu-devel@nongnu.org, qemu-stable@nongnu.org
Subject: Re: [PATCH for-9.0 v2] vdpa-dev: Fix initialisation order to restore
 VDUSE compatibility
Message-ID: <emqti7b54jqyqxpug7jewzhviukilpeshlk6puu7gsy5y7jhzx@7crtolsz7qhd>
References: <20240315140331.59227-1-kwolf@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <20240315140331.59227-1-kwolf@redhat.com>
Received-SPF: pass client-ip=170.10.133.124; envelope-from=sgarzare@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -29
X-Spam_score: -3.0
X-Spam_bar: ---
X-Spam_report: (-3.0 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.933,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

On Fri, Mar 15, 2024 at 03:03:31PM +0100, Kevin Wolf wrote:
>VDUSE requires that virtqueues are first enabled before the DRIVER_OK
>status flag is set; with the current API of the kernel module, it is
>impossible to enable the opposite order in our block export code because
>userspace is not notified when a virtqueue is enabled.
>
>This requirement also mathces the normal initialisation order as done by
>the generic vhost code in QEMU. However, commit 6c482547 accidentally
>changed the order for vdpa-dev and broke access to VDUSE devices with
>this.
>
>This changes vdpa-dev to use the normal order again and use the standard
>vhost callback .vhost_set_vring_enable for this. VDUSE devices can be
>used with vdpa-dev again after this fix.
>
>vhost_net intentionally avoided enabling the vrings for vdpa and does
>this manually later while it does enable them for other vhost backends.
>Reflect this in the vhost_net code and return early for vdpa, so that
>the behaviour doesn't change for this device.
>
>Cc: qemu-stable@nongnu.org
>Fixes: 6c4825476a4351530bcac17abab72295b75ffe98
>Signed-off-by: Kevin Wolf <kwolf@redhat.com>
>---
>v2:
>- Actually make use of the @enable parameter
>- Change vhost_net to preserve the current behaviour
>
> hw/net/vhost_net.c     | 10 ++++++++++
> hw/virtio/vdpa-dev.c   |  5 +----
> hw/virtio/vhost-vdpa.c | 27 +++++++++++++++++++++++++--
> hw/virtio/vhost.c      |  8 +++++++-
> 4 files changed, 43 insertions(+), 7 deletions(-)
>
>diff --git a/hw/net/vhost_net.c b/hw/net/vhost_net.c
>index e8e1661646..fd1a93701a 100644
>--- a/hw/net/vhost_net.c
>+++ b/hw/net/vhost_net.c
>@@ -541,6 +541,16 @@ int vhost_set_vring_enable(NetClientState *nc, int enable)
>     VHostNetState *net = get_vhost_net(nc);
>     const VhostOps *vhost_ops = net->dev.vhost_ops;
>
>+    /*
>+     * vhost-vdpa network devices need to enable dataplane virtqueues after
>+     * DRIVER_OK, so they can recover device state before starting dataplane.
>+     * Because of that, we don't enable virtqueues here and leave it to
>+     * net/vhost-vdpa.c.
>+     */
>+    if (nc->info->type == NET_CLIENT_DRIVER_VHOST_VDPA) {
>+        return 0;
>+    }
>+
>     nc->vring_enable = enable;
>
>     if (vhost_ops && vhost_ops->vhost_set_vring_enable) {
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
>index ddae494ca8..401afac2f5 100644
>--- a/hw/virtio/vhost-vdpa.c
>+++ b/hw/virtio/vhost-vdpa.c
>@@ -886,12 +886,13 @@ static int vhost_vdpa_get_vq_index(struct vhost_dev *dev, int idx)
>     return idx;
> }
>
>-int vhost_vdpa_set_vring_ready(struct vhost_vdpa *v, unsigned idx)
>+static int vhost_vdpa_set_vring_enable_one(struct vhost_vdpa *v, unsigned idx,
>+                                           int enable)
> {
>     struct vhost_dev *dev = v->dev;
>     struct vhost_vring_state state = {
>         .index = idx,
>-        .num = 1,
>+        .num = enable,
>     };
>     int r = vhost_vdpa_call(dev, VHOST_VDPA_SET_VRING_ENABLE, &state);
>

After this line we now have:

       trace_vhost_vdpa_set_vring_ready(dev, idx, r);

Should we rename it or move it to the new function?

If we rename it, we should trace also `enable`.

>@@ -899,6 +900,27 @@ int vhost_vdpa_set_vring_ready(struct vhost_vdpa 
>*v, unsigned idx)
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
>+        ret = vhost_vdpa_set_vring_enable_one(v, i, enable);
>+        if (ret < 0) {
>+            return ret;
>+        }
>+    }
>+
>+    return 0;
>+}
>+
>+int vhost_vdpa_set_vring_ready(struct vhost_vdpa *v, unsigned idx)
>+{
>+    return vhost_vdpa_set_vring_enable_one(v, idx, 1);
>+}
>+
> static int vhost_vdpa_set_config_call(struct vhost_dev *dev,
>                                        int fd)
> {
>@@ -1514,6 +1536,7 @@ const VhostOps vdpa_ops = {
>         .vhost_set_features = vhost_vdpa_set_features,
>         .vhost_reset_device = vhost_vdpa_reset_device,
>         .vhost_get_vq_index = vhost_vdpa_get_vq_index,
>+        .vhost_set_vring_enable = vhost_vdpa_set_vring_enable,
>         .vhost_get_config  = vhost_vdpa_get_config,
>         .vhost_set_config = vhost_vdpa_set_config,
>         .vhost_requires_shm_log = NULL,
>diff --git a/hw/virtio/vhost.c b/hw/virtio/vhost.c
>index 2c9ac79468..decfb85184 100644
>--- a/hw/virtio/vhost.c
>+++ b/hw/virtio/vhost.c
>@@ -1984,7 +1984,13 @@ static int vhost_dev_set_vring_enable(struct vhost_dev *hdev, int enable)
>     return hdev->vhost_ops->vhost_set_vring_enable(hdev, enable);
> }
>
>-/* Host notifiers must be enabled at this point. */
>+/*
>+ * Host notifiers must be enabled at this point.
>+ *
>+ * If @vring is true, this function will enable all vrings before starting the

Nit: @vrings

>+ * device. If it is false, the vring initialization is left to be done by the
>+ * caller.
>+ */
> int vhost_dev_start(struct vhost_dev *hdev, VirtIODevice *vdev, bool vrings)
> {
>     int i, r;
>-- 
>2.44.0
>

The rest LGTM, but while reviewing I was thinking whether it would be
better to split the patch into two: first patch to support
.vhost_set_vring_enable() for vhost-vdpa, second patch to fix
hw/virtio/vdpa-dev.c.

But I'm not sure this is a good idea since the second is strictly
dependent on the first.

Thanks,
Stefano


