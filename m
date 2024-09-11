Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AA0FDEE49BC
	for <qemu-devel@archiver.kernel.org>; Wed, 11 Sep 2024 15:06:17 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1soOjN-000488-Kr; Wed, 11 Sep 2024 10:54:09 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1soOiS-0001fb-G1
 for qemu-devel@nongnu.org; Wed, 11 Sep 2024 10:53:13 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1soOiP-0007HI-Jt
 for qemu-devel@nongnu.org; Wed, 11 Sep 2024 10:53:07 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1726066383;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=H3/RbhQGQ6+o6xoRvkRMHa82wsOC3BKipqBPf5VTk9U=;
 b=QMF+C6SXSVE0pa9s6W1VyOtHDYEy/KPVtWBzqhdDV+1Bg3W5JbB/9zl7AhCmTO3aAxhGEN
 ojQrmZjntMkHCY45wy+D32Qe56QfrgorgxbFPJa40AZUJMT0DjqQwU8CRQURwpSQ/KHT7d
 IG7wXbDGe8jZKFEQAZychwYdn/u9EEE=
Received: from mail-lf1-f69.google.com (mail-lf1-f69.google.com
 [209.85.167.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-250-xX71cbeAMSaKl3xvr-KG7A-1; Wed, 11 Sep 2024 09:51:34 -0400
X-MC-Unique: xX71cbeAMSaKl3xvr-KG7A-1
Received: by mail-lf1-f69.google.com with SMTP id
 2adb3069b0e04-536589936d3so1813392e87.0
 for <qemu-devel@nongnu.org>; Wed, 11 Sep 2024 06:51:34 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1726062693; x=1726667493;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=H3/RbhQGQ6+o6xoRvkRMHa82wsOC3BKipqBPf5VTk9U=;
 b=kNT1yLa5UkyETYzsCfAZiH2akdmB6GlxcZxOHvBlMwTzDuIIQB0guCy4be2J5ZvdcT
 yaLZcIQy/IZEFrptZi7CYiOvAxLElzRXtHLg+vIdNBpQE/a1PR1pI02GWzye0Da2kGjH
 fXzukTo9pJ3Vhs97edLavWjKBIKRzphSEKa6KRElDeLM4ZgcAu+ao8vfTVWSJnMhhniG
 ZExSroEnmKiv6vo7mjbHMuEIfTV0fJrD+HvqQV0i0QWapzmb7Bpa8NNE5ZQ613eJMiZU
 NA08VSTUUHZckv78S09UATUWy1hq0IdslPiqL75S9UaSzK/ohVSe/7n/guHQWaam66Lw
 pXRQ==
X-Gm-Message-State: AOJu0YxKvpErl8AINKOpLYwnx6YDZ9TtQIUWrqX/D7ZSMCvAFjZwazYk
 T2HNnbL1+wW77PJwm8jv7DdJEIqHX2aswqfNMJOqODsA35QWwQyHTnEZbdiFc/qGhHBnlp3EXGR
 HmFHd0p760Lo4BFu6IvmfI7TPumectNK2NOREC9DINWdpwifQAr6Dt02phhhz+U/BTlmDW5N0Dh
 eG+eC9ddiNp0fdBjPwxvMA2nY17h8XWw==
X-Received: by 2002:a05:6512:b1c:b0:52c:dfa2:5ac1 with SMTP id
 2adb3069b0e04-53673b5fa9bmr1671326e87.24.1726062692846; 
 Wed, 11 Sep 2024 06:51:32 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFYvyO7rDO2vQrMeqXdTh83xQG9qGuW9kbCIlblfYqUWqLcu2QsOKRrsj/bTuarXyVcehKXBg==
X-Received: by 2002:a05:6512:b1c:b0:52c:dfa2:5ac1 with SMTP id
 2adb3069b0e04-53673b5fa9bmr1671271e87.24.1726062691756; 
 Wed, 11 Sep 2024 06:51:31 -0700 (PDT)
Received: from redhat.com ([2.55.9.133]) by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-a8d25835b0bsm625639466b.12.2024.09.11.06.51.30
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 11 Sep 2024 06:51:31 -0700 (PDT)
Date: Wed, 11 Sep 2024 09:51:29 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Hanna Czenczek <hreitz@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>
Subject: [PULL 02/18] virtio: Always reset vhost devices
Message-ID: <2688e8df60f5a655dc34c5e38523e425556f8483.1726062663.git.mst@redhat.com>
References: <cover.1726062663.git.mst@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1726062663.git.mst@redhat.com>
X-Mailer: git-send-email 2.27.0.106.g8ac3dc51b1
X-Mutt-Fcc: =sent
Received-SPF: pass client-ip=170.10.133.124; envelope-from=mst@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.144,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
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

From: Hanna Czenczek <hreitz@redhat.com>

Requiring `vhost_started` to be true for resetting vhost devices in
`virtio_reset()` seems like the wrong condition: Most importantly, the
preceding `virtio_set_status(vdev, 0)` call will (for vhost devices) end
up in `vhost_dev_stop()` (through vhost devices' `.set_status`
implementations), setting `vdev->vhost_started = false`.  Therefore, the
gated `vhost_reset_device()` call is unreachable.

`vhost_started` is not documented, so it is hard to say what exactly it
is supposed to mean, but judging from the fact that `vhost_dev_start()`
sets it and `vhost_dev_stop()` clears it, it seems like it indicates
whether there is a vhost back-end, and whether that back-end is
currently running and processing virtio requests.

Making a reset conditional on whether the vhost back-end is processing
virtio requests seems wrong; in fact, it is probably better to reset it
only when it is not currently processing requests, which is exactly the
current order of operations in `virtio_reset()`: First, the back-end is
stopped through `virtio_set_status(vdev, 0)`, then we want to send a
reset.

Therefore, we should drop the `vhost_started` condition, but in its
stead we then have to verify that we can indeed send a reset to this
vhost device, by not just checking `k->get_vhost != NULL` (introduced by
commit 95e1019a4a9), but also that the vhost back-end is connected
(`hdev = k->get_vhost(); hdev != NULL && hdev->vhost_ops != NULL`).

Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>
Reviewed-by: Michael S. Tsirkin <mst@redhat.com>
Signed-off-by: Hanna Czenczek <hreitz@redhat.com>
Message-Id: <20240723163941.48775-3-hreitz@redhat.com>
Reviewed-by: Michael S. Tsirkin <mst@redhat.com>
Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
---
 hw/virtio/virtio.c | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/hw/virtio/virtio.c b/hw/virtio/virtio.c
index 9e10cbc058..42589adf2c 100644
--- a/hw/virtio/virtio.c
+++ b/hw/virtio/virtio.c
@@ -2331,8 +2331,12 @@ void virtio_reset(void *opaque)
         vdev->device_endian = virtio_default_endian();
     }
 
-    if (vdev->vhost_started && k->get_vhost) {
-        vhost_reset_device(k->get_vhost(vdev));
+    if (k->get_vhost) {
+        struct vhost_dev *hdev = k->get_vhost(vdev);
+        /* Only reset when vhost back-end is connected */
+        if (hdev && hdev->vhost_ops) {
+            vhost_reset_device(hdev);
+        }
     }
 
     if (k->reset) {
-- 
MST


