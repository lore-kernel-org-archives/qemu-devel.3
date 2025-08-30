Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6F525CA0EFF
	for <qemu-devel@archiver.kernel.org>; Sat, 30 Aug 2025 16:47:31 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1usOQk-0001BY-UV; Sat, 30 Aug 2025 12:27:55 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1)
 (envelope-from <bounce+db73df.54ef4-qemu-devel=nongnu.org@0x65c.net>)
 id 1usI2z-0007pA-Li
 for qemu-devel@nongnu.org; Sat, 30 Aug 2025 05:38:57 -0400
Received: from m239-4.eu.mailgun.net ([185.250.239.4])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1)
 (envelope-from <bounce+db73df.54ef4-qemu-devel=nongnu.org@0x65c.net>)
 id 1usI2x-0002Me-Ea
 for qemu-devel@nongnu.org; Sat, 30 Aug 2025 05:38:57 -0400
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=0x65c.net; q=dns/txt;
 s=email; t=1756546733; x=1756553933; 
 h=Content-Transfer-Encoding: MIME-Version: References: In-Reply-To:
 Message-ID: Date: Subject: Subject: Cc: To: To: From: From: Sender: Sender; 
 bh=BEBbS3D81KIa7i5AIgyciRF8qIIH2Siayt4a3kPs16c=;
 b=CfYBBVAEASub6x608psb/mSFGhcVsnn/0WnGargJBjGC3ARtje7MGcwnetsMpmbRkrBrdPSAX7v+e/fFNhQWW2wsukOb50BNjhTvi5W2WpiGjuwsL605f1QJYBPpsw2RpR7S0om40abcAtxf3qp0dytobIHj2HbT95C98f6UbbDfWSH0OFlv804twp14AXXu86Bm+wQXLj0P9gmOuaHuG093GpCnsES5QCKUqutGE12EMrjrJFI0QtUByJxWxCrradnk1EdHiP3T5zFLtK/zqrlBWkG6uHxM1BD7/b+2lXD0yz3OHyNSpel+4B/AVWkoyRRqCLClJmRi4cFaYI9YPg==
X-Mailgun-Sid: WyJiNjdhNCIsInFlbXUtZGV2ZWxAbm9uZ251Lm9yZyIsIjU0ZWY0Il0=
Received: from fedora (pub082136115007.dh-hfc.datazug.ch [82.136.115.7]) by
 93518a5527e07c5c8c323cd912038c47e23a9b50108f025ab03e83a0b0c23c7b with SMTP id
 68b2c6ad64422a0f643c0ac8; Sat, 30 Aug 2025 09:38:53 GMT
X-Mailgun-Sending-Ip: 185.250.239.4
From: Alessandro Ratti <alessandro@0x65c.net>
To: qemu-devel@nongnu.org
Cc: alessandro.ratti@gmail.com,
	Alessandro Ratti <alessandro@0x65c.net>
Subject: [PATCH] virtio: prefix error messages with "virtio:"
Date: Sat, 30 Aug 2025 11:31:47 +0200
Message-ID: <20250830093844.452039-2-alessandro@0x65c.net>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20250830093844.452039-1-alessandro@0x65c.net>
References: <20250830093844.452039-1-alessandro@0x65c.net>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=185.250.239.4;
 envelope-from=bounce+db73df.54ef4-qemu-devel=nongnu.org@0x65c.net;
 helo=m239-4.eu.mailgun.net
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_MSPIKE_H2=0.001, RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-Mailman-Approved-At: Sat, 30 Aug 2025 09:06:12 -0400
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

The error message introduced in commit e45da653223 in
virtio_init_region_cache() was unclear:

    qemu-system-i386: Cannot map used

This patch modifies virtio_error() to prepend all error messages with
"virtio: ", making it easier to trace their origin.

Resolves: https://gitlab.com/qemu-project/qemu/-/issues/230
Buglink: https://bugs.launchpad.net/qemu/+bug/1919021

Signed-off-by: Alessandro Ratti <alessandro@0x65c.net>
---
 hw/virtio/virtio.c | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/hw/virtio/virtio.c b/hw/virtio/virtio.c
index 9a81ad912e..c43ac4d320 100644
--- a/hw/virtio/virtio.c
+++ b/hw/virtio/virtio.c
@@ -3934,11 +3934,16 @@ void virtio_device_set_child_bus_name(VirtIODevice *vdev, char *bus_name)
 void G_GNUC_PRINTF(2, 3) virtio_error(VirtIODevice *vdev, const char *fmt, ...)
 {
     va_list ap;
+    char *prefixed_fmt;
+
+    prefixed_fmt = g_strdup_printf("virtio: %s", fmt);
 
     va_start(ap, fmt);
-    error_vreport(fmt, ap);
+    error_vreport(prefixed_fmt, ap);
     va_end(ap);
 
+    g_free(prefixed_fmt);
+
     if (virtio_vdev_has_feature(vdev, VIRTIO_F_VERSION_1)) {
         vdev->status = vdev->status | VIRTIO_CONFIG_S_NEEDS_RESET;
         virtio_notify_config(vdev);
-- 
2.39.5


