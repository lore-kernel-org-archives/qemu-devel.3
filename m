Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 23F6BCA0EE8
	for <qemu-devel@archiver.kernel.org>; Wed, 17 Sep 2025 12:30:19 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uyrIM-0006aE-0J; Wed, 17 Sep 2025 08:29:58 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <sgarzare@redhat.com>)
 id 1uyrIK-0006Zl-J7
 for qemu-devel@nongnu.org; Wed, 17 Sep 2025 08:29:56 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <sgarzare@redhat.com>)
 id 1uyrII-0001Rp-1u
 for qemu-devel@nongnu.org; Wed, 17 Sep 2025 08:29:56 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1758112193;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=R/PbDCGvSxRS566pt/R4BtZ+IRl/O6Rxsv9coAPJZQk=;
 b=YzBxmewMSoF3zHAsabeRBqXsWZ76y6FCRkP82FbTZAkJsEKwlUntVTPeiNpGG5VvfXU2Hh
 h9R+k7n5epjEoa9e17ArZVDoXRWbn6ZOR2MeMaKX4jg1GcIvzmWVv+FrZz99BoKLFDCDVA
 kzGMiJG6CC0a+9REDDeZ8senIDJCCyc=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-629-dZISyGtAPCeiHwFK0YyjWQ-1; Wed, 17 Sep 2025 08:29:50 -0400
X-MC-Unique: dZISyGtAPCeiHwFK0YyjWQ-1
X-Mimecast-MFC-AGG-ID: dZISyGtAPCeiHwFK0YyjWQ_1758112190
Received: by mail-wm1-f69.google.com with SMTP id
 5b1f17b1804b1-45f2f15003aso21273995e9.0
 for <qemu-devel@nongnu.org>; Wed, 17 Sep 2025 05:29:50 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1758112189; x=1758716989;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=R/PbDCGvSxRS566pt/R4BtZ+IRl/O6Rxsv9coAPJZQk=;
 b=TUJK8x9/vwDmyTYaeH7nBdVRVK+I4GycKyX4RjfblbXZSxT1eUhcte6R5iD6rDGNFp
 QLRZmn8+2Xg69yJNBr9PfsNQ+uE/UaV35iMgMJuGy/0sEjWUCe+ey+iT3GDoFRPCYyXW
 mvr8bnjKljZgBO5RfYKrcdKGRpaQt4HXqVMgOKouyfbLJvdnrrococGFnYsJJtHYoT/I
 PSxRuuC9uoZi678h+rQQXZmxK5N7S7mW4hUn7ZcBO8s6sPAThAUByPbkxeJ9eVlZTIPl
 LPQfHwpajdTOK+QSQWM4dRB0Ke1di29D42iT1UDD1FAkIVz3rXNttSZtO3u0yiupweNR
 8qUw==
X-Gm-Message-State: AOJu0Yzd1f8IOuNfiAyKzViCNbAsRfLHM4e5pRNkVeJa4LLNXAHSeA1n
 d/DvkBRE3XHpbkv/Wcsrksj3IMXciBH0sYWiizRdfWCYbaDF/pkGEv9y7keLx5Iy09XX4tiT6Nz
 Qev1Qv7I1yCQHqR1BafWObJwQ4GzFwPxxDidLA0a9dbXRis/CavKnjYei
X-Gm-Gg: ASbGncvWnuZq48RsEHLzSKUNrAcMNH2e4w+lSE9TCNnae/Ivc28KPS7H3th1y6mT3rX
 yxuM4Ice3u1a8ZWEgBY1NJsDCYyfSq2eMGsUCJ94lDSpK7zUMYDeiTbv7DywqCmOf/E2Ak/vvcD
 S/S0kFT7bVIafCZZJg0v3PgJmDgJYMjCmaLfOydtLOehwEmO66aJj0L0JqpOWRXRUo2xqrHiJ2p
 V2J6/veVm7HsuClXF+pbgaoRLR0fPJGSw6Px4aWM9o/zXdwxVPIkTdhb5dHDzTtX3KByLxWOkuT
 uaHpXit7ldotaCKep7PBwjcuJqeECTuh1PZSneGA1iii
X-Received: by 2002:a05:600c:198f:b0:45b:9961:9c09 with SMTP id
 5b1f17b1804b1-46205adf769mr24287845e9.17.1758112189471; 
 Wed, 17 Sep 2025 05:29:49 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGWIpm0lpbF8cxJqMHwttm1C0gpz/sJeuiyCrLhZ+w1CORBgt18OQ9Ig9v/h2KBchXa6j1gig==
X-Received: by 2002:a05:600c:198f:b0:45b:9961:9c09 with SMTP id
 5b1f17b1804b1-46205adf769mr24287415e9.17.1758112188899; 
 Wed, 17 Sep 2025 05:29:48 -0700 (PDT)
Received: from sgarzare-redhat ([5.179.183.148])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-46136daf54fsm39753255e9.5.2025.09.17.05.29.47
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 17 Sep 2025 05:29:48 -0700 (PDT)
Date: Wed, 17 Sep 2025 14:29:45 +0200
From: Stefano Garzarella <sgarzare@redhat.com>
To: Paolo Abeni <pabeni@redhat.com>
Cc: qemu-devel@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>, 
 Dmitry Fleytman <dmitry.fleytman@gmail.com>,
 Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>, 
 Jason Wang <jasowang@redhat.com>,
 Sriram Yagnaraman <sriram.yagnaraman@ericsson.com>, 
 "Michael S. Tsirkin" <mst@redhat.com>, Cornelia Huck <cohuck@redhat.com>, 
 Luigi Rizzo <lrizzo@google.com>, Giuseppe Lettieri <g.lettieri@iet.unipi.it>, 
 Vincenzo Maffione <v.maffione@gmail.com>, Eric Blake <eblake@redhat.com>, 
 Markus Armbruster <armbru@redhat.com>
Subject: Re: [PATCH v6 10/14] vhost-backend: implement extended features
 support
Message-ID: <66nse2kwrtb342irpnxm664sqmzmlj2hlfpusuajlelwys2vc7@lygaes6y4hmp>
References: <cover.1757676218.git.pabeni@redhat.com>
 <1f14d4e9e1847ca9c5d787bdac0dd967ea8937c1.1757676218.git.pabeni@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <1f14d4e9e1847ca9c5d787bdac0dd967ea8937c1.1757676218.git.pabeni@redhat.com>
Received-SPF: pass client-ip=170.10.129.124; envelope-from=sgarzare@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

On Fri, Sep 12, 2025 at 03:07:01PM +0200, Paolo Abeni wrote:
>Leverage the kernel extended features manipulation ioctls(), if
>available, and fallback to old ops otherwise. Error out when setting
>extended features but kernel support is not available.
>
>Note that extended support for get/set backend features is not needed,
>as the only feature that can be changed belongs to the 64 bit range.
>
>Reviewed-by: Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>
>Acked-by: Jason Wang <jasowang@redhat.com>
>Signed-off-by: Paolo Abeni <pabeni@redhat.com>
>---
>v3 -> v4:
>  - use new virtio_features macro names
>
>v1 -> v2:
>  - synced with kernel ioctl changes
>---
> hw/virtio/vhost-backend.c | 62 ++++++++++++++++++++++++++++++++-------
> 1 file changed, 51 insertions(+), 11 deletions(-)

Acked-by: Stefano Garzarella <sgarzare@redhat.com>

>
>diff --git a/hw/virtio/vhost-backend.c b/hw/virtio/vhost-backend.c
>index 833804dd40..4367db0d95 100644
>--- a/hw/virtio/vhost-backend.c
>+++ b/hw/virtio/vhost-backend.c
>@@ -20,6 +20,11 @@
> #include <linux/vhost.h>
> #include <sys/ioctl.h>
>
>+struct vhost_features {
>+    uint64_t count;
>+    uint64_t features[VIRTIO_FEATURES_NU64S];
>+};
>+
> static int vhost_kernel_call(struct vhost_dev *dev, unsigned long int request,
>                              void *arg)
> {
>@@ -182,12 +187,6 @@ static int vhost_kernel_get_vring_worker(struct vhost_dev *dev,
>     return vhost_kernel_call(dev, VHOST_GET_VRING_WORKER, worker);
> }
>
>-static int vhost_kernel_set_features(struct vhost_dev *dev,
>-                                     uint64_t features)
>-{
>-    return vhost_kernel_call(dev, VHOST_SET_FEATURES, &features);
>-}
>-
> static int vhost_kernel_set_backend_cap(struct vhost_dev *dev)
> {
>     uint64_t features;
>@@ -210,10 +209,51 @@ static int vhost_kernel_set_backend_cap(struct vhost_dev *dev)
>     return 0;
> }
>
>-static int vhost_kernel_get_features(struct vhost_dev *dev,
>-                                     uint64_t *features)
>+static int vhost_kernel_set_features(struct vhost_dev *dev,
>+                                     const uint64_t *features)
> {
>-    return vhost_kernel_call(dev, VHOST_GET_FEATURES, features);
>+    struct vhost_features farray;
>+    bool extended_in_use;
>+    int r;
>+
>+    farray.count = VIRTIO_FEATURES_NU64S;
>+    virtio_features_copy(farray.features, features);
>+    extended_in_use = virtio_features_use_ex(farray.features);
>+
>+    /*
>+     * Can't check for ENOTTY: for unknown ioctls the kernel interprets
>+     * the argument as a virtio queue id and most likely errors out validating
>+     * such id, instead of reporting an unknown operation.
>+     */
>+    r = vhost_kernel_call(dev, VHOST_SET_FEATURES_ARRAY, &farray);
>+    if (!r) {
>+        return 0;
>+    }
>+
>+    if (extended_in_use) {
>+        error_report("Trying to set extended features without kernel support");
>+        return -EINVAL;
>+    }
>+    return vhost_kernel_call(dev, VHOST_SET_FEATURES, &farray.features[0]);
>+}
>+
>+static int vhost_kernel_get_features(struct vhost_dev *dev, uint64_t *features)
>+{
>+    struct vhost_features farray;
>+    int r;
>+
>+    farray.count = VIRTIO_FEATURES_NU64S;
>+    r = vhost_kernel_call(dev, VHOST_GET_FEATURES_ARRAY, &farray);
>+    if (r) {
>+        memset(&farray, 0, sizeof(farray));
>+        r = vhost_kernel_call(dev, VHOST_GET_FEATURES, &farray.features[0]);
>+    }
>+    if (r) {
>+        return r;
>+    }
>+
>+    virtio_features_copy(features, farray.features);
>+    return 0;
> }
>
> static int vhost_kernel_set_owner(struct vhost_dev *dev)
>@@ -341,8 +381,8 @@ const VhostOps kernel_ops = {
>         .vhost_attach_vring_worker = vhost_kernel_attach_vring_worker,
>         .vhost_new_worker = vhost_kernel_new_worker,
>         .vhost_free_worker = vhost_kernel_free_worker,
>-        .vhost_set_features = vhost_kernel_set_features,
>-        .vhost_get_features = vhost_kernel_get_features,
>+        .vhost_set_features_ex = vhost_kernel_set_features,
>+        .vhost_get_features_ex = vhost_kernel_get_features,
>         .vhost_set_backend_cap = vhost_kernel_set_backend_cap,
>         .vhost_set_owner = vhost_kernel_set_owner,
>         .vhost_get_vq_index = vhost_kernel_get_vq_index,
>-- 
>2.51.0
>


