Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 34270CAC598
	for <qemu-devel@archiver.kernel.org>; Mon, 15 Sep 2025 10:08:40 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uy67e-0007a0-Am; Mon, 15 Sep 2025 06:07:47 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1)
 (envelope-from <bounce+db73df.54ef4-qemu-devel=nongnu.org@0x65c.net>)
 id 1uy67Z-0007Yg-6S
 for qemu-devel@nongnu.org; Mon, 15 Sep 2025 06:07:42 -0400
Received: from m204-227.eu.mailgun.net ([161.38.204.227])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1)
 (envelope-from <bounce+db73df.54ef4-qemu-devel=nongnu.org@0x65c.net>)
 id 1uy67H-00066H-2X
 for qemu-devel@nongnu.org; Mon, 15 Sep 2025 06:07:39 -0400
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=0x65c.net; q=dns/txt;
 s=email; t=1757930835; x=1757938035; 
 h=Content-Transfer-Encoding: MIME-Version: References: In-Reply-To:
 Message-ID: Date: Subject: Subject: Cc: To: To: From: From: Sender: Sender; 
 bh=Ef9WWfDKKJeIQWBsT8z6C3UgYBxxs9P5Yo4QHnZh3IU=;
 b=OV4qQJdVpOXfefzUO5b7BSs18ibshRJCwd3Un8my/xE9RTivSuZ8Htr9bToYgAFJ+ilkAkWqdlGvHXvj4MRj+aKRizXRqPjrpws1XDQUPhpsi7B6DSXvS4VJ+oFcS/XXw7lUQIY2GpytslmRajwfhGKkv2IYUqrMGN59MB5NRWJagn335z2o5GaQct1LEwJClnKu7vT9sqjdK3rf99FiV2CjUFBoD4BP5htBWLhnJ9vCwXaWFWTALFZLnStU05s/wmofy1uYAGwXItQ2kmFZBsBsjTzgZCj9j6M1pxM6ttIVikob24ix575DEQ9Z8fqJ+KTb5leW6E+eCayEhl8sYg==
X-Mailgun-Sid: WyJiNjdhNCIsInFlbXUtZGV2ZWxAbm9uZ251Lm9yZyIsIjU0ZWY0Il0=
Received: from fedora (pub082136115007.dh-hfc.datazug.ch [82.136.115.7]) by
 72144cfb99b61755965ba36ab48da239f3e5d8856025c89e1aebabc970f2747b with SMTP id
 68c7e550e2b51d529c044bb1; Mon, 15 Sep 2025 10:07:12 GMT
X-Mailgun-Sending-Ip: 161.38.204.227
From: Alessandro Ratti <alessandro@0x65c.net>
To: qemu-devel@nongnu.org
Cc: alessandro.ratti@gmail.com, philmd@linaro.org, alex.bennee@linaro.org,
 Alessandro Ratti <alessandro@0x65c.net>
Subject: [PATCH] virtio: Add function name to error messages
Date: Mon, 15 Sep 2025 12:01:07 +0200
Message-ID: <20250915100701.224156-2-alessandro@0x65c.net>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20250915100701.224156-1-alessandro@0x65c.net>
References: <20250915100701.224156-1-alessandro@0x65c.net>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=161.38.204.227;
 envelope-from=bounce+db73df.54ef4-qemu-devel=nongnu.org@0x65c.net;
 helo=m204-227.eu.mailgun.net
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
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

Replace virtio_error() with a macro that automatically prepends the
calling function name to error messages. This provides better context
for debugging virtio issues by showing exactly which function
encountered the error.

Before: "Invalid queue size: 1024"
After:  "virtio_queue_set_num: Invalid queue size: 1024"

The implementation uses a macro to insert __func__ at compile time,
avoiding any runtime overhead while providing more specific error
context than a generic "virtio:" prefix.

Resolves: https://gitlab.com/qemu-project/qemu/-/issues/230
Buglink: https://bugs.launchpad.net/qemu/+bug/1919021

Signed-off-by: Alessandro Ratti <alessandro@0x65c.net>
---
 hw/virtio/virtio.c         | 2 +-
 include/hw/virtio/virtio.h | 4 +++-
 2 files changed, 4 insertions(+), 2 deletions(-)

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


