Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AC681D44D45
	for <qemu-devel@archiver.kernel.org>; Wed,  6 Nov 2024 10:36:06 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t8dOF-0001VW-0b; Wed, 06 Nov 2024 05:35:55 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <sgarzare@redhat.com>)
 id 1t8dOD-0001Uz-6X
 for qemu-devel@nongnu.org; Wed, 06 Nov 2024 05:35:53 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <sgarzare@redhat.com>)
 id 1t8dOA-0003WP-IY
 for qemu-devel@nongnu.org; Wed, 06 Nov 2024 05:35:52 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1730889347;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=ueI0LRMdGHiZF1SXUI+ExLLMNYc/Wnqjg4iwB1jfQZw=;
 b=AMPMkeq4FyVcYSnBSOSLuXOum9/WJ9gi3sWldNsPeUn6WVsAU3ayj7K5slT+9mf7P6dpYv
 leA47peA1Ij3WaBE/4Ow5DEaQiErrEl2S7yrziF4TJc0d7mbeGGRAj2LgofpvQnBAGZrjT
 Y/t84Pkv5tOxideAnL4Q6xIB9C94t8g=
Received: from mail-oi1-f198.google.com (mail-oi1-f198.google.com
 [209.85.167.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-193-c2N6GltzNYaKjTViyN45oQ-1; Wed, 06 Nov 2024 05:35:46 -0500
X-MC-Unique: c2N6GltzNYaKjTViyN45oQ-1
X-Mimecast-MFC-AGG-ID: c2N6GltzNYaKjTViyN45oQ
Received: by mail-oi1-f198.google.com with SMTP id
 5614622812f47-3e62bfb7c12so636694b6e.0
 for <qemu-devel@nongnu.org>; Wed, 06 Nov 2024 02:35:45 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1730889345; x=1731494145;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=ueI0LRMdGHiZF1SXUI+ExLLMNYc/Wnqjg4iwB1jfQZw=;
 b=myetVX/wULPYB35vekSMh9UCimuwRIHl0D9PIVYnt/RsTc0OxB9oHqdLarP1ewVscS
 AJNNWK1jkZiGZ/cUARKODFJDEzXrOEkKG892ZlvgAAzqZ8XgD95evBXDjphuVox6F7aN
 9L2v8Ak3WZVO0ggtGSOtiy0Pk0lk6oDl9Vz/Cr+G06UkoZM2mshR7Ali1FyhJuUjSizT
 GMV9HHM70VKyfrp2JtuOn6nM57EkdUipTmBuJe9gOvtIh9MLrqhV/JVMMKOyspcwHrh3
 +GbWhjNI7UzkCCW8Mfkuw6zxR0qLnAj8x52Fkgo9Yt2MtlatUm4seQh6Zs789bKSqOCK
 e72A==
X-Gm-Message-State: AOJu0YzU3W/0uHHrZol+vfTw1Fj15KiA6BBQnykaBSudZ05bYnP8XvvJ
 vnjWsxIQy8Y/2CqIBVNW6Wb1wX/9depDZ96x3OE8mWncbM50YVMr6UxqaYRUZGqLdqKRqsSKLHp
 Tx6+YkldNyP8bjp8igD/vv4Xor4LLQK7lOisvKTwepqMgic4YCcWJ
X-Received: by 2002:a05:6808:1388:b0:3e2:a4a8:49fc with SMTP id
 5614622812f47-3e78287e6f2mr915078b6e.15.1730889345325; 
 Wed, 06 Nov 2024 02:35:45 -0800 (PST)
X-Google-Smtp-Source: AGHT+IG7+nu0+7GzQ6fgBbUoDgjobaZ0L118qTVtyHFoT0FX0wr7FMUTics+zStnS2kPkL06YlwWXQ==
X-Received: by 2002:a05:6808:1388:b0:3e2:a4a8:49fc with SMTP id
 5614622812f47-3e78287e6f2mr915070b6e.15.1730889344917; 
 Wed, 06 Nov 2024 02:35:44 -0800 (PST)
Received: from sgarzare-redhat ([5.77.86.226])
 by smtp.gmail.com with ESMTPSA id
 5614622812f47-3e66123f363sm2961443b6e.37.2024.11.06.02.35.42
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 06 Nov 2024 02:35:44 -0800 (PST)
Date: Wed, 6 Nov 2024 11:35:36 +0100
From: Stefano Garzarella <sgarzare@redhat.com>
To: Prasad Pandit <ppandit@redhat.com>
Cc: qemu-devel@nongnu.org, "Michael S . Tsirkin" <mst@redhat.com>, 
 Prasad Pandit <pjp@fedoraproject.org>, Jason Wang <jasowang@redhat.com>, 
 Eugenio =?utf-8?B?UMOpcmV6?= <eperezma@redhat.com>
Subject: Re: [PATCH] vhost: fail device start if iotlb update fails
Message-ID: <ez2fb2yg7zha6ccdey47zxhaxcgwim7f6p4zzj4ucrgjnbavyk@mrnhs47uyx5e>
References: <20241105060053.61973-1-ppandit@redhat.com>
 <a664pk3wefui7tyvs6rjln2tm2fxwir6yvshffwkjypksechjj@3amhddyqxwiz>
 <CAE8KmOxHTx=ZxTWype-YVizogDEVVXVg=jRdYU8eRtHP7ngr9w@mail.gmail.com>
 <kxiffscfbs4njd6cfuebstpm5yrp7jdkgulcwbsmsyyxfowixw@yrhyrmhaj7da>
 <CAE8KmOwWDw7fxbLcVLo1BwkLYfi4X_9mKP73MaZz177LNgaaJg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <CAE8KmOwWDw7fxbLcVLo1BwkLYfi4X_9mKP73MaZz177LNgaaJg@mail.gmail.com>
Received-SPF: pass client-ip=170.10.129.124; envelope-from=sgarzare@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -23
X-Spam_score: -2.4
X-Spam_bar: --
X-Spam_report: (-2.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.34,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.001,
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

On Wed, Nov 06, 2024 at 03:41:24PM +0530, Prasad Pandit wrote:
>On Wed, 6 Nov 2024 at 14:21, Stefano Garzarella <sgarzare@redhat.com> wrote:
>> I think we should call that functions in the reverse order, so just add them in the error path, as we already do for other calls.
>===
>diff --git a/hw/virtio/vhost.c b/hw/virtio/vhost.c
>index a70b7422b5..f168e1f02a 100644
>--- a/hw/virtio/vhost.c
>+++ b/hw/virtio/vhost.c
>@@ -2153,14 +2153,16 @@ int vhost_dev_start(struct vhost_dev *hdev,
>VirtIODevice *vdev, bool vrings)
>             struct vhost_virtqueue *vq = hdev->vqs + i;
>             r = vhost_device_iotlb_miss(hdev, vq->used_phys, true);
>             if (r) {
>-                VHOST_OPS_DEBUG(r, "vhost_device_iotlb_miss failed");
>-                goto fail_start;
>+                goto fail_iotlb;
>             }
>         }
>     }
>     vhost_start_config_intr(hdev);
>     return 0;
>+fail_iotlb:
>+    hdev->vhost_ops->vhost_set_iotlb_callback(hdev, false);
> fail_start:
>+    hdev->vhost_ops->vhost_dev_start(hdev, false);

This should go before the fail_start label, since it should not be 
called when vhost_dev_start() fails.

Also we need to check if that callback is defined.

I suggest to follow what we do in vhost_dev_stop(), so something like 
this (not tested):

diff --git a/hw/virtio/vhost.c b/hw/virtio/vhost.c
index 76f9b2aaad..c40f48ac4d 100644
--- a/hw/virtio/vhost.c
+++ b/hw/virtio/vhost.c
@@ -2095,11 +2095,22 @@ int vhost_dev_start(struct vhost_dev *hdev, VirtIODevice *vdev, bool vrings)
           * vhost-kernel code requires for this.*/
          for (i = 0; i < hdev->nvqs; ++i) {
              struct vhost_virtqueue *vq = hdev->vqs + i;
-            vhost_device_iotlb_miss(hdev, vq->used_phys, true);
+            r = vhost_device_iotlb_miss(hdev, vq->used_phys, true);
+            if (r) {
+                goto fail_iotlb;
+            }
          }
      }
      vhost_start_config_intr(hdev);
      return 0;
+fail_iotlb:
+    if (vhost_dev_has_iommu(hdev) &&
+        hdev->vhost_ops->vhost_set_iotlb_callback) {
+        hdev->vhost_ops->vhost_set_iotlb_callback(hdev, false);
+    }
+    if (hdev->vhost_ops->vhost_dev_start) {
+        hdev->vhost_ops->vhost_dev_start(hdev, false);
+    }
  fail_start:
      if (vrings) {
          vhost_dev_set_vring_enable(hdev, false);

>     if (vrings) {
>         vhost_dev_set_vring_enable(hdev, false);
>     }
>===
>
>* Is this okay?
>
>* Looking at the vhost_vdpa_dev_start(), when it is called with
>'started=false' parameter, it calls the vdpa_suspend, vdpa_stop etc.
>functions. ie. probably other ->vhost_dev_start() and
>->vhost_set_iotlb_callback() functions need to take appropriate action
>when called with 'started/enabled=false' parameter.

We already call them in vhost_dev_stop(), so I guess we are fine.

@Michael @Jason @Eugenio WDYT?

Thanks,
Stefano


