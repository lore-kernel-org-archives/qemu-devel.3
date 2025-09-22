Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F1A2DCAC592
	for <qemu-devel@archiver.kernel.org>; Mon, 22 Sep 2025 09:37:31 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v0cyr-0001S3-2f; Mon, 22 Sep 2025 05:37:10 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1)
 (envelope-from <bounce+db73df.54ef4-qemu-devel=nongnu.org@0x65c.net>)
 id 1v0cyh-0001L2-3D
 for qemu-devel@nongnu.org; Mon, 22 Sep 2025 05:37:00 -0400
Received: from m239-4.eu.mailgun.net ([185.250.239.4])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1)
 (envelope-from <bounce+db73df.54ef4-qemu-devel=nongnu.org@0x65c.net>)
 id 1v0cyU-0000XL-ES
 for qemu-devel@nongnu.org; Mon, 22 Sep 2025 05:36:58 -0400
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=0x65c.net; q=dns/txt;
 s=email; t=1758533800; x=1758541000; 
 h=Content-Transfer-Encoding: MIME-Version: References: In-Reply-To:
 Message-ID: Date: Subject: Subject: Cc: To: To: From: From: Sender: Sender; 
 bh=GfB7TJ/R+SmBPiIs7bTkD5S39munCenXb9QGVz606qk=;
 b=A/ypi+7JkUS7teorcAEk6zt2ELN7ewI3auVnoFIgyMP2pDLoT5fYjoQ4emXVzmSx2XimrHfcwqaWQF0T+CYf8snh8KJlLAFK4vbdYhGZIbrZVpcwVQk3CRuBqBno/ODWQiMbWOJxslVWcmAeO/SVXXk/y7VCld7WkLCIr2QgJEHojR/hgW86CFoQZ241nCrXdFA8DV01+TzaDSrYUjs/aC6hOJnhETYu1szCWugQA3A14QgrGZsMAyGRgJYPXRDHqGvQZEKWrBM8YK4qDv5rnwnestKa0MYhlNAnuowrt/rDPvNd+tm1AXvdXqM/b4JAiCiV86A7MVfJWIrx4s4PVQ==
X-Mailgun-Sid: WyJiNjdhNCIsInFlbXUtZGV2ZWxAbm9uZ251Lm9yZyIsIjU0ZWY0Il0=
Received: from fedora (pub082136115007.dh-hfc.datazug.ch [82.136.115.7]) by
 828b261a786e1b88f6f0348b70940623e6e0bda0119f79194ebef0939f7d6478 with SMTP id
 68d118a87efe7a88ac0fb2b6; Mon, 22 Sep 2025 09:36:40 GMT
X-Mailgun-Sending-Ip: 185.250.239.4
From: Alessandro Ratti <alessandro@0x65c.net>
To: qemu-devel@nongnu.org
Cc: alex.bennee@linaro.org, philmd@linaro.org, mst@redhat.com,
 david@redhat.com, mjt@tls.msk.ru, Alessandro Ratti <alessandro@0x65c.net>
Subject: [PATCH v2] virtio: Add function name to error messages
Date: Mon, 22 Sep 2025 11:33:16 +0200
Message-ID: <20250922093632.381955-2-alessandro@0x65c.net>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20250922093632.381955-1-alessandro@0x65c.net>
References: <20250915162643.44716-2-alessandro@0x65c.net>
 <20250922093632.381955-1-alessandro@0x65c.net>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=185.250.239.4;
 envelope-from=bounce+db73df.54ef4-qemu-devel=nongnu.org@0x65c.net;
 helo=m239-4.eu.mailgun.net
X-Spam_score_int: -30
X-Spam_score: -3.1
X-Spam_bar: ---
X-Spam_report: (-3.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, RCVD_IN_MSPIKE_H5=-1,
 RCVD_IN_MSPIKE_WL=-0.01, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001, SPF_HELO_NONE=0.001,
 T_SPF_TEMPERROR=0.01 autolearn=ham autolearn_force=no
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

Replace virtio_error() with a macro that automatically prepends the
calling function name to error messages. This provides better context
for debugging virtio issues by showing exactly which function
encountered the error.

Before: "Invalid queue size: 1024"
After:  "virtio_queue_set_num: Invalid queue size: 1024"

The implementation uses a macro to insert __func__ at compile time,
avoiding any runtime overhead while providing more specific error
context than a generic "virtio:" prefix.

Also remove manual __func__ usage in virtio-balloon to avoid duplicate
function names in error messages.

Resolves: https://gitlab.com/qemu-project/qemu/-/issues/230
Buglink: https://bugs.launchpad.net/qemu/+bug/1919021

Signed-off-by: Alessandro Ratti <alessandro@0x65c.net>
---
 hw/virtio/virtio-balloon.c | 2 +-
 hw/virtio/virtio.c         | 2 +-
 include/hw/virtio/virtio.h | 4 +++-
 3 files changed, 5 insertions(+), 3 deletions(-)

diff --git a/hw/virtio/virtio-balloon.c b/hw/virtio/virtio-balloon.c
index db787d00b3..e443f71c01 100644
--- a/hw/virtio/virtio-balloon.c
+++ b/hw/virtio/virtio-balloon.c
@@ -697,7 +697,7 @@ virtio_balloon_free_page_hint_notify(NotifierWithReturn *n, void *data,
     case PRECOPY_NOTIFY_COMPLETE:
         break;
     default:
-        virtio_error(vdev, "%s: %d reason unknown", __func__, pnd->reason);
+        virtio_error(vdev, "%d reason unknown", pnd->reason);
     }
 
     return 0;
diff --git a/hw/virtio/virtio.c b/hw/virtio/virtio.c
index 9a81ad912e..44528d7f2b 100644
--- a/hw/virtio/virtio.c
+++ b/hw/virtio/virtio.c
@@ -3931,7 +3931,7 @@ void virtio_device_set_child_bus_name(VirtIODevice *vdev, char *bus_name)
     vdev->bus_name = g_strdup(bus_name);
 }
 
-void G_GNUC_PRINTF(2, 3) virtio_error(VirtIODevice *vdev, const char *fmt, ...)
+void G_GNUC_PRINTF(2, 3) virtio_error_impl(VirtIODevice *vdev, const char *fmt, ...)
 {
     va_list ap;
 
diff --git a/include/hw/virtio/virtio.h b/include/hw/virtio/virtio.h
index c594764f23..961d021497 100644
--- a/include/hw/virtio/virtio.h
+++ b/include/hw/virtio/virtio.h
@@ -249,7 +249,9 @@ void virtio_init(VirtIODevice *vdev, uint16_t device_id, size_t config_size);
 
 void virtio_cleanup(VirtIODevice *vdev);
 
-void virtio_error(VirtIODevice *vdev, const char *fmt, ...) G_GNUC_PRINTF(2, 3);
+#define virtio_error(vdev, fmt, ...) \
+    virtio_error_impl(vdev, "%s: " fmt, __func__, ##__VA_ARGS__)
+void virtio_error_impl(VirtIODevice *vdev, const char *fmt, ...) G_GNUC_PRINTF(2, 3);
 
 /* Set the child bus name. */
 void virtio_device_set_child_bus_name(VirtIODevice *vdev, char *bus_name);
-- 
2.39.5


