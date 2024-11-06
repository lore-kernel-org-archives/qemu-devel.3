Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BF05ED44D41
	for <qemu-devel@archiver.kernel.org>; Wed,  6 Nov 2024 10:12:34 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t8d0y-0004rf-Id; Wed, 06 Nov 2024 05:11:52 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ppandit@redhat.com>)
 id 1t8d0x-0004rS-0H
 for qemu-devel@nongnu.org; Wed, 06 Nov 2024 05:11:51 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ppandit@redhat.com>)
 id 1t8d0v-00048c-6m
 for qemu-devel@nongnu.org; Wed, 06 Nov 2024 05:11:50 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1730887906;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=cfFJbE4+0/AissjINl1gGve3deDNd3HwLDGjYh43uCs=;
 b=bV7vEF6RNPs+1YWVIzvvE0jBqE+siYrEmw9j0bje8MMPn41Xfca+3guHqEwPchg9+bpSnW
 BqnN8gc9Q5r+D1jGflkZtpRfEA9UL32BNpSsD/9bSGXGM/AJdIA1hlW722rGdPDHGxEtCx
 Vd0bS/ucFdUaoDzkNXm/iHQZo+55xvE=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-561-Ow3He6B9N8KXg6Cy7ETHjw-1; Wed, 06 Nov 2024 05:11:43 -0500
X-MC-Unique: Ow3He6B9N8KXg6Cy7ETHjw-1
X-Mimecast-MFC-AGG-ID: Ow3He6B9N8KXg6Cy7ETHjw
Received: by mail-wm1-f69.google.com with SMTP id
 5b1f17b1804b1-4315544642eso47660225e9.3
 for <qemu-devel@nongnu.org>; Wed, 06 Nov 2024 02:11:43 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1730887902; x=1731492702;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=cfFJbE4+0/AissjINl1gGve3deDNd3HwLDGjYh43uCs=;
 b=chFmYFt0C/gfUQEHgaUmtUi7+o+KRP57WP35DZtECINU/yN9pIbByJgTmyP+qmW8gO
 Mvrymz72WK3hEdQlDE0ubFKkf29qH3OsvHYjsfrO8AeSxQWlV+NORWViJA70ukhLDSwv
 w3aaG+D5UYt9o9LpSqV6h6ewr96Fj8o/g7eg+8knQiS8W3rh3wKOvkEoVFEGpZNq+hzA
 fa4507NZyJpur9veSf3rnRSWrVjcb1jQaTK3JnJZLlUVOErnNa29p3KMD/Cm6G/L5A6u
 1ggf2o93RmRkdrirph+koxGxIzwcRiZ5WKB7tq4i0WV90PGUkjs173iqyi3G5167l20+
 z3dg==
X-Gm-Message-State: AOJu0YwwAeNnHW2ciXT0UpPyDvmzjaVZgIlX6LeDKOzeB9/Gv/48/QWX
 XexSlUmT0Am8jld+j+Z6tit+IDKqi6mRDzKBR1hJGybx1NvJw8cawaoyfDz9jXjYSMnfyQo7XJ0
 MiZ+GHoEpjDt93P1aPCSmgBCSrqVuiJwoQLwcCIeU0DYIGdYKXkX9Z3Gljzfk69gYdLOP12IOXK
 FKGq/HY7NF6r/ljUlxCMFmrTzWOfM=
X-Received: by 2002:a05:600c:468f:b0:431:4f5e:1f61 with SMTP id
 5b1f17b1804b1-4327b6fda2cmr197252295e9.14.1730887902473; 
 Wed, 06 Nov 2024 02:11:42 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHcuLyNHiB17FFFi6fGxJ7G+xu1hgARSWihGN3HH596vayDLU7oJEQ6282QoOlO2L1bsIx1ubxvxrO3jRlSxak=
X-Received: by 2002:a05:600c:468f:b0:431:4f5e:1f61 with SMTP id
 5b1f17b1804b1-4327b6fda2cmr197252125e9.14.1730887902176; Wed, 06 Nov 2024
 02:11:42 -0800 (PST)
MIME-Version: 1.0
References: <20241105060053.61973-1-ppandit@redhat.com>
 <a664pk3wefui7tyvs6rjln2tm2fxwir6yvshffwkjypksechjj@3amhddyqxwiz>
 <CAE8KmOxHTx=ZxTWype-YVizogDEVVXVg=jRdYU8eRtHP7ngr9w@mail.gmail.com>
 <kxiffscfbs4njd6cfuebstpm5yrp7jdkgulcwbsmsyyxfowixw@yrhyrmhaj7da>
In-Reply-To: <kxiffscfbs4njd6cfuebstpm5yrp7jdkgulcwbsmsyyxfowixw@yrhyrmhaj7da>
From: Prasad Pandit <ppandit@redhat.com>
Date: Wed, 6 Nov 2024 15:41:24 +0530
Message-ID: <CAE8KmOwWDw7fxbLcVLo1BwkLYfi4X_9mKP73MaZz177LNgaaJg@mail.gmail.com>
Subject: Re: [PATCH] vhost: fail device start if iotlb update fails
To: Stefano Garzarella <sgarzare@redhat.com>
Cc: qemu-devel@nongnu.org, "Michael S . Tsirkin" <mst@redhat.com>, 
 Prasad Pandit <pjp@fedoraproject.org>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=170.10.129.124; envelope-from=ppandit@redhat.com;
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

On Wed, 6 Nov 2024 at 14:21, Stefano Garzarella <sgarzare@redhat.com> wrote:
> I think we should call that functions in the reverse order, so just add them in the error path, as we already do for other calls.
===
diff --git a/hw/virtio/vhost.c b/hw/virtio/vhost.c
index a70b7422b5..f168e1f02a 100644
--- a/hw/virtio/vhost.c
+++ b/hw/virtio/vhost.c
@@ -2153,14 +2153,16 @@ int vhost_dev_start(struct vhost_dev *hdev,
VirtIODevice *vdev, bool vrings)
             struct vhost_virtqueue *vq = hdev->vqs + i;
             r = vhost_device_iotlb_miss(hdev, vq->used_phys, true);
             if (r) {
-                VHOST_OPS_DEBUG(r, "vhost_device_iotlb_miss failed");
-                goto fail_start;
+                goto fail_iotlb;
             }
         }
     }
     vhost_start_config_intr(hdev);
     return 0;
+fail_iotlb:
+    hdev->vhost_ops->vhost_set_iotlb_callback(hdev, false);
 fail_start:
+    hdev->vhost_ops->vhost_dev_start(hdev, false);
     if (vrings) {
         vhost_dev_set_vring_enable(hdev, false);
     }
===

* Is this okay?

* Looking at the vhost_vdpa_dev_start(), when it is called with
'started=false' parameter, it calls the vdpa_suspend, vdpa_stop etc.
functions. ie. probably other ->vhost_dev_start() and
->vhost_set_iotlb_callback() functions need to take appropriate action
when called with 'started/enabled=false' parameter.

Thank you.
---
  - Prasad


