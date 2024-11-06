Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DAABBD29FB3
	for <qemu-devel@archiver.kernel.org>; Wed,  6 Nov 2024 07:51:48 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t8aoc-00069a-Uf; Wed, 06 Nov 2024 02:50:58 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ppandit@redhat.com>)
 id 1t8aob-00069R-Es
 for qemu-devel@nongnu.org; Wed, 06 Nov 2024 02:50:57 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ppandit@redhat.com>)
 id 1t8aoZ-0007jz-GZ
 for qemu-devel@nongnu.org; Wed, 06 Nov 2024 02:50:57 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1730879451;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=/zhJPVqMwr3rhHdUOcaFkUzYEi8tjIRi66wWfPFsId4=;
 b=dghV9PJKr/N9Osk4EsOrJE4iGftshOmPM/eTX0q35OcunC65hxz8sjnTIOGKyrmTgRof1r
 5/AAIMICHL6oKQ/2dOM6gT6iatg/Rr0y8ZNX7vaaOMqqN6a+hxun+30nLWhUYi7XmYRu/s
 QmKP/Mc2XXelbI5R+NDe5fsfX8Su0nQ=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-452-FctRGAqFPTyGTfUagwXy8A-1; Wed, 06 Nov 2024 02:50:50 -0500
X-MC-Unique: FctRGAqFPTyGTfUagwXy8A-1
Received: by mail-wr1-f72.google.com with SMTP id
 ffacd0b85a97d-37d563a1af4so3156826f8f.2
 for <qemu-devel@nongnu.org>; Tue, 05 Nov 2024 23:50:50 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1730879448; x=1731484248;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=/zhJPVqMwr3rhHdUOcaFkUzYEi8tjIRi66wWfPFsId4=;
 b=s6lg70ZY/CzTk6lGhxC6rDPwlo7LlFSxqPgDIJz9/JUJPRkKzPeXskY6bkIpkNmf+i
 xZZ0POHxl/Kqj8o6Kw3jsSGMbQHmmEpsCivLAq77HzihNuCapItQ5XxmzdH50J5wHA05
 2O2dsTmZl2SphactPVPelBaQ/XulrGS2Mdinu0CZelExdULdHUvjHzg1etXQBfsPowyG
 4wSwCOdf8iv0UlRUewAimUvK9/AbznkMBqoAvUF85hHoz7bO7CbearyeRIjHT26HR5yM
 b2DDCgE+vKYcyEkyzVRzVUTQ/5zlcM8WpdX7DBKZCGb2e9qI1lHN2EjedLH/N+OCt07P
 yEHQ==
X-Gm-Message-State: AOJu0YwJ23OAv2mwNp/v7zBOuYBm2xboTXWbPtCTiKIc/SKX4LMUsQ4u
 LAaprUEwiFd+XRMpTcL54qBBINlFrQlHWOyLL8eizHvpUkF8CHI3GutESHzjFP2rYnv/Rg2ko3X
 s0xIN2HRNQ3ZmuzJFgdbXSYXPgKC/KXUA2NymHkCkz6cuJ9OGJinDHPKoIn2wkWYmT0Lx82sscv
 AIeyR93c/d5JANLBYe7rMNJCBkWyThK/SOnWzenw==
X-Received: by 2002:a05:6000:693:b0:37d:39c8:ecca with SMTP id
 ffacd0b85a97d-381c7ab3097mr15972357f8f.55.1730879448203; 
 Tue, 05 Nov 2024 23:50:48 -0800 (PST)
X-Google-Smtp-Source: AGHT+IG7br97vuh72nhmmBJXRcds9jQoomZYbvjvzzoSyr8sRQod+EnybgyUOlf5g8ficmxZE/joQhAcCdxEGI4s74Q=
X-Received: by 2002:a05:6000:693:b0:37d:39c8:ecca with SMTP id
 ffacd0b85a97d-381c7ab3097mr15972342f8f.55.1730879447901; Tue, 05 Nov 2024
 23:50:47 -0800 (PST)
MIME-Version: 1.0
References: <20241105060053.61973-1-ppandit@redhat.com>
 <a664pk3wefui7tyvs6rjln2tm2fxwir6yvshffwkjypksechjj@3amhddyqxwiz>
In-Reply-To: <a664pk3wefui7tyvs6rjln2tm2fxwir6yvshffwkjypksechjj@3amhddyqxwiz>
From: Prasad Pandit <ppandit@redhat.com>
Date: Wed, 6 Nov 2024 13:20:31 +0530
Message-ID: <CAE8KmOxHTx=ZxTWype-YVizogDEVVXVg=jRdYU8eRtHP7ngr9w@mail.gmail.com>
Subject: Re: [PATCH] vhost: fail device start if iotlb update fails
To: Stefano Garzarella <sgarzare@redhat.com>
Cc: qemu-devel@nongnu.org, "Michael S . Tsirkin" <mst@redhat.com>, 
 Prasad Pandit <pjp@fedoraproject.org>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=170.10.133.124; envelope-from=ppandit@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -23
X-Spam_score: -2.4
X-Spam_bar: --
X-Spam_report: (-2.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.34,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

On Tue, 5 Nov 2024 at 16:19, Stefano Garzarella <sgarzare@redhat.com> wrote:
> VHOST_OPS_DEBUG() is usually used in the error path when calling a
> `dev->vhost_ops` callback. In addition vhost_device_iotlb_miss() is
> already reporting error through error_report() in the error path, so I
> think we can remove this line.

* Okay.

> Should we add a new label in the error path and call
> `hdev->vhost_ops->vhost_dev_start` with `false`?
>
> Maybe we need to call also `hdev->vhost_ops->vhost_set_iotlb_callback`
> with `false`.
===
diff --git a/hw/virtio/vhost.c b/hw/virtio/vhost.c
index a70b7422b5..089eff438e 100644
--- a/hw/virtio/vhost.c
+++ b/hw/virtio/vhost.c
@@ -2137,15 +2137,18 @@ int vhost_dev_start(struct vhost_dev *hdev,
VirtIODevice *vdev, bool vrings)
             goto fail_log;
         }
     }
+
+    bool start = true;
+dev_restart:
     if (hdev->vhost_ops->vhost_dev_start) {
-        r = hdev->vhost_ops->vhost_dev_start(hdev, true);
+        r = hdev->vhost_ops->vhost_dev_start(hdev, start);
         if (r) {
             goto fail_start;
         }
     }
     if (vhost_dev_has_iommu(hdev) &&
         hdev->vhost_ops->vhost_set_iotlb_callback) {
-            hdev->vhost_ops->vhost_set_iotlb_callback(hdev, true);
+            hdev->vhost_ops->vhost_set_iotlb_callback(hdev, start);

         /* Update used ring information for IOTLB to work correctly,
          * vhost-kernel code requires for this.*/
@@ -2154,7 +2157,8 @@ int vhost_dev_start(struct vhost_dev *hdev,
VirtIODevice *vdev, bool vrings)
             r = vhost_device_iotlb_miss(hdev, vq->used_phys, true);
             if (r) {
                 VHOST_OPS_DEBUG(r, "vhost_device_iotlb_miss failed");
-                goto fail_start;
+                start = false;
+                goto dev_restart;
             }
         }
     }
===

* Something like above?

===
static int vhost_user_dev_start(struct vhost_dev *dev, bool started)
{
    ...
    if (started) {
        return vhost_user_add_status(dev, VIRTIO_CONFIG_S_ACKNOWLEDGE |
                                          VIRTIO_CONFIG_S_DRIVER |
                                          VIRTIO_CONFIG_S_DRIVER_OK);
    } else {
        return 0;
    }
}

static void vhost_user_set_iotlb_callback(struct vhost_dev *dev, int enabled)
{
    /* No-op as the receive channel is not dedicated to IOTLB messages. */
}
===

* Calling vhost_user_dev_start() and vhost_user_set_iotlb_callback()
with 'false' does not seem to do much. Not sure how'll that help. If
we 'goto fail_start;', libvirtd(8) might restart the guest and thus
start the vhost device again.

...wdyt?

Thank you.
---
  - Prasad


