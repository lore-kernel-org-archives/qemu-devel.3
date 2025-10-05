Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 93582CAC5B8
	for <qemu-devel@archiver.kernel.org>; Sun,  5 Oct 2025 19:20:07 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v5UFM-0002IZ-4B; Sun, 05 Oct 2025 15:18:17 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1v5UEs-0000Ux-SW
 for qemu-devel@nongnu.org; Sun, 05 Oct 2025 15:17:47 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1v5UEq-0006YY-JK
 for qemu-devel@nongnu.org; Sun, 05 Oct 2025 15:17:46 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1759691863;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=qaaiPsY2w5X1nM8WzdUOv5p6rMVvIWhXGJwIV0z7Nm0=;
 b=G37fLBIz3CwVEs+afwETqFgyPdgvoEkVxbtAzVQ7CQGMzESUeS+DO6vozEj8HSDqWQD/p0
 RW4rIYMrpU8E660OljKV6gq/lMckP74E7qQG6uepi2bE7cnpULN26AzpiPZEwEfo+xLJ0M
 X72TY62sl6B+cYZEe1TGKyUaSU9r7BQ=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-267-NL3s316JM_6O4lxWQfAn1g-1; Sun, 05 Oct 2025 15:17:42 -0400
X-MC-Unique: NL3s316JM_6O4lxWQfAn1g-1
X-Mimecast-MFC-AGG-ID: NL3s316JM_6O4lxWQfAn1g_1759691861
Received: by mail-wm1-f70.google.com with SMTP id
 5b1f17b1804b1-46e46486972so11981475e9.0
 for <qemu-devel@nongnu.org>; Sun, 05 Oct 2025 12:17:42 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1759691861; x=1760296661;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :mime-version:references:message-id:subject:cc:to:from:date
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=qaaiPsY2w5X1nM8WzdUOv5p6rMVvIWhXGJwIV0z7Nm0=;
 b=KYZDq9HqaP6IZj/nCwJize6HhYvTa55hTe1SKVsHDEXqiXyBPAxxWAsL4YF3MmI0ic
 siBcB5cqSZMeI22CC7co6mR30sZwz/7X3fqMofB6mzPwS8B01PNdUCWI5Kia3VSs4PI0
 dv+ZwhvgekiNAYPu2k9Q9kEOcPw09L3qGK7jlQrX8O/Bb7gVqZrvxCTyq+KdZ7YNHczx
 Ln2gxSXj590N/i7ts4UkyRUiIUZPF+DkwSW7Hspt2WEp7RVnZvFDSldWz7FUFucd7483
 l3XQ9kt85w2jLfsWSQqjFEU18eixEOOlwXIfZfTqK+pWH1rPvNgctKo6q+GGpuTFmWDi
 CH1A==
X-Gm-Message-State: AOJu0YwpI39Vz9q0dCzyQjyGYOekH+yUSD7yo9Dg5UftlZ4dSlVZLDkK
 lgX7h2r/ECaTcZfr12svOrVYytktSe50QBtJ06WM/DzjhJkDBum0q9ruYwEJhrmK/riDi+tbva4
 2PGOwX+flwlnRSohlcOrwCN+4DX2Yz/szaYPB2xEKx4i80Apc03vucarbZrr3HSgsVIqYvLSmNY
 9PmyDrCxQ0BXUbOHIl24Kz3f9OBiVdv0ihug==
X-Gm-Gg: ASbGncvsKYlgyUBcqkxH7O2j3DB68hZYE+l6Aj2aXZF2RKJFwuSQDa60TsMHa2VfRGD
 he6HNMrBBU0tUG+lf0ssZYJ/FdEJtwaSeioFhs/4qS6lyJ0wE9/cFbKtAHvWsF3rQAPn2hMYS/6
 z7DKzltlEl4nzqFYKXY8BYx4IqmXY04nqGtlMDbMUFct6jy0qALFzdEuPuG88FlG9Rgqig8zrCJ
 yKo9YWH84+aCbiGK8Do9dWMVaiVGUpHQ+Na3/4K2Ya/a0dWvICxr/d4xdOXkXBZ0aDlCSp/y9nV
 evvh9LFPoIHseiEvVu6K/GY0Zgu4rsBwt/RIHYs=
X-Received: by 2002:a05:600c:348b:b0:46e:37fc:def0 with SMTP id
 5b1f17b1804b1-46e71109e9bmr73743435e9.9.1759691861184; 
 Sun, 05 Oct 2025 12:17:41 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IE7MG29ead6ZhiEZE+wFOJBGbwp4ZdkzxVyFIDonZ1hd485L+ZqXS/rKLyM/HEIehckecG8bg==
X-Received: by 2002:a05:600c:348b:b0:46e:37fc:def0 with SMTP id
 5b1f17b1804b1-46e71109e9bmr73743235e9.9.1759691860609; 
 Sun, 05 Oct 2025 12:17:40 -0700 (PDT)
Received: from redhat.com ([2a0d:6fc0:1518:6900:b69a:73e1:9698:9cd3])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-4255d8f011bsm17778306f8f.46.2025.10.05.12.17.39
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 05 Oct 2025 12:17:40 -0700 (PDT)
Date: Sun, 5 Oct 2025 15:17:38 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Stefan Hajnoczi <stefanha@redhat.com>,
 Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Stefano Garzarella <sgarzare@redhat.com>
Subject: [PULL 43/75] vhost: use virtio_config_get_guest_notifier()
Message-ID: <2e41580328a9cdfffce3ee496857c1b2d6ed365e.1759691708.git.mst@redhat.com>
References: <cover.1759691708.git.mst@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <cover.1759691708.git.mst@redhat.com>
X-Mailer: git-send-email 2.27.0.106.g8ac3dc51b1
X-Mutt-Fcc: =sent
Received-SPF: pass client-ip=170.10.129.124; envelope-from=mst@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.43,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
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

From: Stefan Hajnoczi <stefanha@redhat.com>

There is a getter function so avoid accessing the ->config_notifier
field directly.

Signed-off-by: Stefan Hajnoczi <stefanha@redhat.com>
Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Michael S. Tsirkin <mst@redhat.com>
Message-ID: <20250922220149.498967-2-stefanha@redhat.com>
Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
---
 hw/virtio/vhost.c | 11 +++++++----
 1 file changed, 7 insertions(+), 4 deletions(-)

diff --git a/hw/virtio/vhost.c b/hw/virtio/vhost.c
index 5f485ad6cb..c120ef38b9 100644
--- a/hw/virtio/vhost.c
+++ b/hw/virtio/vhost.c
@@ -1846,7 +1846,7 @@ void vhost_config_mask(struct vhost_dev *hdev, VirtIODevice *vdev, bool mask)
     int r;
     EventNotifier *notifier =
         &hdev->vqs[VHOST_QUEUE_NUM_CONFIG_INR].masked_config_notifier;
-    EventNotifier *config_notifier = &vdev->config_notifier;
+    EventNotifier *config_notifier = virtio_config_get_guest_notifier(vdev);
     assert(hdev->vhost_ops);
 
     if ((hdev->started == false) ||
@@ -1877,13 +1877,15 @@ static void vhost_stop_config_intr(struct vhost_dev *dev)
 static void vhost_start_config_intr(struct vhost_dev *dev)
 {
     int r;
+    EventNotifier *config_notifier =
+        virtio_config_get_guest_notifier(dev->vdev);
 
     assert(dev->vhost_ops);
-    int fd = event_notifier_get_fd(&dev->vdev->config_notifier);
+    int fd = event_notifier_get_fd(config_notifier);
     if (dev->vhost_ops->vhost_set_config_call) {
         r = dev->vhost_ops->vhost_set_config_call(dev, fd);
         if (!r) {
-            event_notifier_set(&dev->vdev->config_notifier);
+            event_notifier_set(config_notifier);
         }
     }
 }
@@ -2167,12 +2169,13 @@ static int do_vhost_dev_stop(struct vhost_dev *hdev, VirtIODevice *vdev,
 {
     int i;
     int rc = 0;
+    EventNotifier *config_notifier = virtio_config_get_guest_notifier(vdev);
 
     /* should only be called after backend is connected */
     assert(hdev->vhost_ops);
     event_notifier_test_and_clear(
         &hdev->vqs[VHOST_QUEUE_NUM_CONFIG_INR].masked_config_notifier);
-    event_notifier_test_and_clear(&vdev->config_notifier);
+    event_notifier_test_and_clear(config_notifier);
     event_notifier_cleanup(
         &hdev->vqs[VHOST_QUEUE_NUM_CONFIG_INR].masked_config_notifier);
 
-- 
MST


