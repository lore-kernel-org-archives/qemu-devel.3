Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9AAF1C44506
	for <qemu-devel@archiver.kernel.org>; Thu,  9 Jul 2026 14:06:56 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1whpOZ-0006lK-3a; Thu, 09 Jul 2026 10:06:31 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1)
 (envelope-from <d07de8d7b33fbbdd84909c21b67156fe564dc050@kylie.crudebyte.com>)
 id 1whpOX-0006l4-Bz
 for qemu-devel@nongnu.org; Thu, 09 Jul 2026 10:06:29 -0400
Received: from kylie.crudebyte.com ([5.189.157.229])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1)
 (envelope-from <d07de8d7b33fbbdd84909c21b67156fe564dc050@kylie.crudebyte.com>)
 id 1whpOV-0003FA-OE
 for qemu-devel@nongnu.org; Thu, 09 Jul 2026 10:06:29 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=crudebyte.com; s=kylie; h=Cc:To:Subject:Date:From:References:In-Reply-To:
 Message-ID:Content-Type:Content-Transfer-Encoding:MIME-Version:Content-ID:
 Content-Description; bh=a9kk3nEJUJVMFkYDzYsvSFLuPOkZ2fBYXKASbT2Jrzo=; b=vqDIW
 kIF01iVGBL9Q38D4bSiux2nISG2RBS5276wKiV3XyndB8FXdYSfHzziy7DEIxaAlR9aqy+MkRSRlL
 wbyoiDubw4/SolhABkqTPWitg1BM7RxAvlobNJo6kqcMQx5oSroGtJhzqOWekNUU0ES9u37zIF8PW
 XLBRquSPZ6MSoEa4ggDhlpTLCQRm/C78zFTNhgEov5BAnNJND16aHV64aBg/i+/6+kpKxjofAbp24
 knQcGWr7H8JNrvFD+7IJG+LYNDgRaBy5zVHjpNWKMUtlGWQ3LfThtDwmge/2qcaCaw2ImLRMb+xz8
 FZkr/9WLCgI01i73n8tH3hP/XanHP8Vqo7JUaDKZ2oaQM9Fo2KkxhoXvLWMrDslga2AXqH1j0B3/Z
 bYmF66+ktGwaPS/O647n0NpUvEUK98ZkitBteIHyWGd1S+lg/gsqX9+5DlDxzFhgMvkSLFYLhCHQ/
 6wLnI2wTYFkEL3B3rJsoX6d1mqPkxttU7zhIOkA17j7u+gOqvfaeov4Zhqc+PArd1eQF97Bz9+eb8
 n/Fgf5eljMjH+5+ZmtPPFeWk0dboRoFWYkIK+BUa6+9lluo6AV8i1GcSvO03NbgYpcUO0pkvVu8br
 W2EWbofHLYjdw8aIHuWBGwzZyzKf9c0/mB+w4QXFda6PZOJsB1DvAOOQ8EC0x0=;
Message-ID: <d07de8d7b33fbbdd84909c21b67156fe564dc050.1783604079.git.qemu_oss@crudebyte.com>
In-Reply-To: <cover.1783604079.git.qemu_oss@crudebyte.com>
References: <cover.1783604079.git.qemu_oss@crudebyte.com>
From: Christian Schoenebeck <qemu_oss@crudebyte.com>
Date: Thu, 9 Jul 2026 15:50:36 +0200
Subject: [PATCH 2/3] hw/9pfs/virtio: disable hotpluggable property of
 virtio-9p device
To: qemu-devel@nongnu.org
Cc: Greg Kurz <groug@kaod.org>,
    Jia Jia <physicalmtea@gmail.com>
Received-SPF: pass client-ip=5.189.157.229;
 envelope-from=d07de8d7b33fbbdd84909c21b67156fe564dc050@kylie.crudebyte.com;
 helo=kylie.crudebyte.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

Harden security by disabling hotpluggable property, to prevent
issues like fixed in the previous commit.

Virtio-9p is a pass-through file-sharing device that provides a
guest mount of a host filesystem tree. Unlike block or network
devices, guest-triggered hotplug of the 9p device has no practical
use case: the guest cannot recover from the device removal, and there
is no protocol-level device-loss scenario as with block or ethernet
devices.

Prevent guest-triggered hotplug by marking the device as
non-hotpluggable. Device removal via QMP is not affected by this, as
the QMP removal path is not reading the device's hotpluggable field
at all.

Signed-off-by: Christian Schoenebeck <qemu_oss@crudebyte.com>
---
 hw/9pfs/virtio-9p-device.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/hw/9pfs/virtio-9p-device.c b/hw/9pfs/virtio-9p-device.c
index 1ec48fc9e0..ba43fd22d2 100644
--- a/hw/9pfs/virtio-9p-device.c
+++ b/hw/9pfs/virtio-9p-device.c
@@ -273,6 +273,7 @@ static void virtio_9p_class_init(ObjectClass *klass, const void *data)
 
     device_class_set_props(dc, virtio_9p_properties);
     dc->vmsd = &vmstate_virtio_9p;
+    dc->hotpluggable = false;
     set_bit(DEVICE_CATEGORY_STORAGE, dc->categories);
     vdc->realize = virtio_9p_device_realize;
     vdc->unrealize = virtio_9p_device_unrealize;
-- 
2.47.3


