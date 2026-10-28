Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B00EE606A31D
	for <qemu-devel@archiver.kernel.org>; Wed, 28 Oct 2026 20:19:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=qJaBMQnp
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xMA5O-0005cw-UE; Wed, 28 Oct 2026 16:17:27 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <luoyonggang@gmail.com>)
 id 1xMA5I-0005Ug-QP
 for qemu-devel@nongnu.org; Wed, 28 Oct 2026 16:17:20 -0400
Received: from mail-dy1-x132c.google.com ([2607:f8b0:4864:20::132c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <luoyonggang@gmail.com>)
 id 1xMA5G-0002M6-SA
 for qemu-devel@nongnu.org; Wed, 28 Oct 2026 16:17:20 -0400
Received: by mail-dy1-x132c.google.com with SMTP id
 5a478bee46e88-36661f953e4so2233775eec.1
 for <qemu-devel@nongnu.org>; Wed, 28 Oct 2026 13:17:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20260707; t=1793218636; x=1793823436; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=A2nlZgLz6sOn2cs4PXVlolOczLlJRNmVj0kMGdu8wlM=;
 b=qJaBMQnpuVoilaeUh32c3c0R98wrFN5357aJXuLbfzgSHZMcr6pvjE+m9/CoVy0sHc
 nHSbGwPpZdf70CoqNAdNdx7d1qh+2RgV1iVk7c15ZmhjT7QpdB22M6nE3F2aQAqeGJ1S
 Qfug4x+56V6DuUbSeQs4c+LYXRu84DG1ZHtgbReH2lOOwV5pGSgpaBjbPnxNioZJC/Kj
 APTnMj4xfR4EMbARvxr+IX22A5Q+WlQALuEQ0Yqb0Hm1xfLgcdPo7KOd446GDW3j++hz
 A8TSQ9y7gws5Nmhl/BSshYtI6yZPvFXeBLy+m8EoyU84Bd76AAnWXvwPEMWwn7ZenXtZ
 J80A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793218636; x=1793823436;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=A2nlZgLz6sOn2cs4PXVlolOczLlJRNmVj0kMGdu8wlM=;
 b=VBPaWU8Nh75TIx8JYXnyZL5JdormeaWQulJsu5P3tVriiUT3WTcjLgH46owvZ3BuND
 +ORNy0X8yl53cwHbMw4LkygiskpBDMmX/00mgN3VuShfIwLT3yujcHK8j5zqfExQZnrb
 +hfigtPftfhr8O9FLZ3KsgW0jQUSzSspMKzyVapjdHpfGKGrKOeQvHkr09kZ8R/qZmvb
 ZrPFBDz02wg9/oQTGXhKvK/G7NAxNXEncQF7NTbxFkk89YfIHCWfX1cKf4a6uU38qffR
 xun8ZLURveYuKgZHCq19/mGEJOl+qAZR2f6ftXpLzrjI05629MpQmkM8Yp1U3Mlnc9cX
 Obzg==
X-Gm-Message-State: AFq9FYLe+ST/Se1HSi5g+tJTHs4nq9vQYjKvmQw2LumohKmWPooDGqbn
 wpdRbSy+GplTaSVysterG6wXDTxIkMBWu9vl79pHwGJn9aARgyUt2iP9Qtfzxwxh
X-Gm-Gg: AYBFou0iwynbOuNUecWwjkG0sZNfYTM1XsiqZtHKzLmN3cUX2So7CQ6d3YcHyw94kmV
 2QBnzBvkFdeYd9fq9eoVuo0yO4d3Ao+/bUkosVDmVwTRej8JCc5gS6aFSQ9zcq8DhSzHcqvmEKA
 opKimNPelpc0QTthxzsIr6Q5bphmaQpZeBvRno4qbYRKL9te0Upx/O7KC3pr8vm1A4+Tup1Kgps
 LQFt+ndXaP+VS+WRwKfmQY9X0i46sfknj80XbFPn06MZjzA/hvz0kUzdvQfXy06eYbDN1Adg46b
 JqqRbNe5In0HJWMMdSQgrc6fUHvUytDiv6gcWLNyhfA+tOrYEnu4H3zN8o7AF4Nmy9AgOda446Z
 JhFKYRJw+rQdDNAXWXTb55JPUpZlKmRW2T/88DBSwPNINyZrJR8i0Ge99YeeeSXqkVswCGUs1Ny
 pDUKgJLv2X1/mT5a2Mm9Io6aMd3mZmF54zNiUcYqhDjQREoA0al8w47ien/oGzsQ307olHxaQWV
 qWoIkxGk/pXvXYnTdnUCXsiMSySphwnQxZ5GxjwzGczo3USv+/i5tg6wbpaeRNgrJiX7DEMDMlD
 gu/UKb6g4sYdbaKKJgeZvyRXz8Ms1w3uhGHI4UnFtzxr7gyb
X-Received: by 2002:a05:7300:c7ca:b0:359:1b05:ed30 with SMTP id
 5a478bee46e88-36a202d5537mr4429450eec.4.1793218635936; 
 Wed, 28 Oct 2026 13:17:15 -0700 (PDT)
Received: from DESKTOP-Q716RM7 ([103.94.185.75])
 by smtp.googlemail.com with ESMTPSA id
 5a478bee46e88-36a23951e00sm12016896eec.20.2026.10.28.13.17.10
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 28 Oct 2026 13:17:15 -0700 (PDT)
From: Yonggang Luo <luoyonggang@gmail.com>
To: qemu-devel@nongnu.org
Cc: "Michael S. Tsirkin" <mst@redhat.com>,
 David Hildenbrand <david@kernel.org>, qemu-s390x@nongnu.org,
 Jiaxun Yang <jiaxun.yang@flygoat.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 Eric Farman <farman@linux.ibm.com>, Song Gao <17746591750@163.com>,
 Max Filippov <jcmvbkbc@gmail.com>, Cornelia Huck <cohuck@redhat.com>,
 Fam Zheng <fam@euphon.net>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>,
 Matthew Rosato <mjrosato@linux.ibm.com>,
 Philippe Mathieu-Daude <philmd@mailo.com>, qemu-arm@nongnu.org,
 "Edgar E. Iglesias" <edgar.iglesias@gmail.com>,
 Paolo Bonzini <pbonzini@redhat.com>
Subject: [PATCH 11/12] hw/virtio/virtio-mem: register legacy-guest variant
 with is_available
Date: Thu, 29 Oct 2026 04:15:55 +0800
Message-ID: <20261028201557.2688-12-luoyonggang@gmail.com>
X-Mailer: git-send-email 2.55.0.windows.3
In-Reply-To: <20261028201557.2688-1-luoyonggang@gmail.com>
References: <20261028201557.2688-1-luoyonggang@gmail.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::132c;
 envelope-from=luoyonggang@gmail.com; helo=mail-dy1-x132c.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_PASS,SPF_PASS,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

virtio-mem decided in class_init and realize whether x86 guests can
leave unplugged memory accessible. Register a second virtio-mem type
that adds virtio_mem_legacy_guests_properties and sets
VirtIOMEMClass.has_legacy_guests. Select the two with
target_base_i386() and target_not_base_i386().

Signed-off-by: Yonggang Luo <luoyonggang@gmail.com>
---
 hw/virtio/virtio-mem.c         | 47 +++++++++++++++++++---------------
 include/hw/virtio/virtio-mem.h |  2 ++
 2 files changed, 29 insertions(+), 20 deletions(-)

diff --git a/hw/virtio/virtio-mem.c b/hw/virtio/virtio-mem.c
index 7130ed852d9..bf241a3112b 100644
--- a/hw/virtio/virtio-mem.c
+++ b/hw/virtio/virtio-mem.c
@@ -15,6 +15,7 @@
 #include "qemu/cutils.h"
 #include "qemu/error-report.h"
 #include "qemu/units.h"
+#include "qemu/target-info.h"
 #include "qemu/target-info-qapi.h"
 #include "system/memory.h"
 #include "system/numa.h"
@@ -35,22 +36,6 @@
 
 static const VMStateDescription vmstate_virtio_mem_device_early;
 
-static bool virtio_mem_has_legacy_guests(void)
-{
-    /*
-     * We only had legacy x86 guests that did not support
-     * VIRTIO_MEM_F_UNPLUGGED_INACCESSIBLE. Other targets don't have
-     * legacy guests.
-     */
-    switch (target_arch()) {
-    case SYS_EMU_TARGET_I386:
-    case SYS_EMU_TARGET_X86_64:
-        return true;
-    default:
-        return false;
-    }
-}
-
 /*
  * Let's not allow blocks smaller than 1 MiB, for example, to keep the tracking
  * bitmap small.
@@ -859,7 +844,7 @@ static void virtio_mem_device_realize(DeviceState *dev, Error **errp)
     rb = vmem->memdev->mr.ram_block;
     page_size = qemu_ram_pagesize(rb);
 
-    if (virtio_mem_has_legacy_guests()) {
+    if (VIRTIO_MEM_GET_CLASS(vmem)->has_legacy_guests) {
         switch (vmem->unplugged_inaccessible) {
         case ON_OFF_AUTO_AUTO:
             if (virtio_mem_has_shared_zeropage(rb)) {
@@ -1635,9 +1620,6 @@ static void virtio_mem_class_init(ObjectClass *klass, const void *data)
     RamDiscardSourceClass *rdsc = RAM_DISCARD_SOURCE_CLASS(klass);
 
     device_class_set_props(dc, virtio_mem_properties);
-    if (virtio_mem_has_legacy_guests()) {
-        device_class_set_props(dc, virtio_mem_legacy_guests_properties);
-    }
     dc->vmsd = &vmstate_virtio_mem;
 
     set_bit(DEVICE_CATEGORY_MISC, dc->categories);
@@ -1660,6 +1642,14 @@ static void virtio_mem_class_init(ObjectClass *klass, const void *data)
     rdsc->is_populated = virtio_mem_rds_is_populated;
 }
 
+static void virtio_mem_legacy_class_init(ObjectClass *klass, const void *data)
+{
+    virtio_mem_class_init(klass, data);
+    device_class_set_props(DEVICE_CLASS(klass),
+                           virtio_mem_legacy_guests_properties);
+    VIRTIO_MEM_CLASS(klass)->has_legacy_guests = true;
+}
+
 static const TypeInfo virtio_mem_info = {
     .name = TYPE_VIRTIO_MEM,
     .parent = TYPE_VIRTIO_DEVICE,
@@ -1668,6 +1658,22 @@ static const TypeInfo virtio_mem_info = {
     .instance_finalize = virtio_mem_instance_finalize,
     .class_init = virtio_mem_class_init,
     .class_size = sizeof(VirtIOMEMClass),
+    .is_available = target_not_base_i386,
+    .interfaces = (const InterfaceInfo[]) {
+        { TYPE_RAM_DISCARD_SOURCE },
+        { }
+    },
+};
+
+static const TypeInfo virtio_mem_legacy_info = {
+    .name = TYPE_VIRTIO_MEM,
+    .parent = TYPE_VIRTIO_DEVICE,
+    .instance_size = sizeof(VirtIOMEM),
+    .instance_init = virtio_mem_instance_init,
+    .instance_finalize = virtio_mem_instance_finalize,
+    .class_init = virtio_mem_legacy_class_init,
+    .class_size = sizeof(VirtIOMEMClass),
+    .is_available = target_base_i386,
     .interfaces = (const InterfaceInfo[]) {
         { TYPE_RAM_DISCARD_SOURCE },
         { }
@@ -1677,6 +1683,7 @@ static const TypeInfo virtio_mem_info = {
 static void virtio_register_types(void)
 {
     type_register_static(&virtio_mem_info);
+    type_register_static(&virtio_mem_legacy_info);
 }
 
 type_init(virtio_register_types)
diff --git a/include/hw/virtio/virtio-mem.h b/include/hw/virtio/virtio-mem.h
index 5d1d19c6bec..f367959ecb0 100644
--- a/include/hw/virtio/virtio-mem.h
+++ b/include/hw/virtio/virtio-mem.h
@@ -134,6 +134,8 @@ struct VirtIOMEMClass {
     VirtioDeviceClass parent_class;
 
     /* public */
+    bool has_legacy_guests;
+
     void (*fill_device_info)(const VirtIOMEM *vmen, VirtioMEMDeviceInfo *vi);
     MemoryRegion *(*get_memory_region)(VirtIOMEM *vmem, Error **errp);
     void (*decide_memslots)(VirtIOMEM *vmem, unsigned int limit);
-- 
2.55.0.windows.3


