Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 598EE606A31A
	for <qemu-devel@archiver.kernel.org>; Sat, 31 Oct 2026 16:42:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=Nrgs83P5
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xNC9F-0002u9-Bj; Sat, 31 Oct 2026 12:41:41 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <luoyonggang@gmail.com>)
 id 1xNC98-0002gd-04
 for qemu-devel@nongnu.org; Sat, 31 Oct 2026 12:41:34 -0400
Received: from mail-dl1-x122a.google.com ([2607:f8b0:4864:20::122a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <luoyonggang@gmail.com>)
 id 1xNC93-0007n1-CK
 for qemu-devel@nongnu.org; Sat, 31 Oct 2026 12:41:33 -0400
Received: by mail-dl1-x122a.google.com with SMTP id
 a92af1059eb24-1931ff67a29so1890038c88.1
 for <qemu-devel@nongnu.org>; Sat, 31 Oct 2026 09:41:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20260707; t=1793464888; x=1794069688; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=MmRCsAW5mavSOXDoD+r4sX5W+ESmptKLUqpCEz6dVjI=;
 b=Nrgs83P5QEeZi0YGWgRBGH+TvTSBwOrStM4h2ErHelxVJ7/3q9NsDOODPflV8Sv150
 pR+A4aG2LsPXLHHMC8p0e+FBqRLem0m0kRsvh5yOPm1hoHI7y4TmbsEeF2Z90ff5paoQ
 gbAWfiNHNNHw2gm8UA6cny2QB3lrA31W7vKtOUoVD2edGoFlKUaZYZ2U00K+kthiUi3L
 tYddi7wxOqUqbiHdkpxCuqNnnJ7wIJ85VgvdelIJnBn48dF4/DDZ71IS2jgkw+KmCA2C
 CoITvUTaQYp838O/uzAGRb/cZvWKemi9kCAWc35EK874GL6f0B6pBkO3miNNapuVXJwJ
 MyZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793464888; x=1794069688;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=MmRCsAW5mavSOXDoD+r4sX5W+ESmptKLUqpCEz6dVjI=;
 b=dxSkUjAYCSix/nNAdWY0uImmrI3gPwcyDxQnkCfHKl7+sW2aKO9AawGBcwShsdF2oF
 Y2XVLpx7h9h5rImxpMarXNU+Gx1HNWNLza/xpFnxJ92wCTzgQaWMvWAnEQVsIRNd/e6+
 EJynmeqSrQdhP7SZz9tnke7M8693sQbfIzfSTMks4NZsau+6CUnCiA+N7BbLW2WJliwY
 T4L6FUGLaPCnACv+gJFyGrkHXkjZuzM6GQ0QmPGiPYR//lsj8SO2WlVpkrmcbIlP+kOq
 3Nn8wbbt1OE2VF8nMXhz1KlhdKz8TYtxUJB6lqiXIHDznaal7L8T3hJ9yaP1rw+oatIl
 4ulQ==
X-Gm-Message-State: AFq9FYIG7KnHpdoHr8b7XFHisZA4vtoPPXrUF0rUS7VKrO1EALUc4xpF
 jTC0OJAGngdqrE/6EBlCwLLMTPza04zGZhbAQhdxO77LTuKgsqRA4XPY2JnCSruA
X-Gm-Gg: AYBFou0DvCfxp/m30CbgfSylJJ3Y+nhgKorikQ/crcyiwX/Whw2MnU89SGp1O5ittb0
 km7t2IShzWCt0S0H2OyLFh1R33ef219hA4C01almuYZV05q/fBtIvv4VsGG7XwyPoeZ1v/9hVEu
 AUh9BatHKu1ApL5FfZWoj3yorbsOC9VfcaOchHwj7WJVVnlYuRxgwp6AjyaIF+3DBTkYoUiPqVm
 bGg10DrXHOXnx/jAP2t6fBRtTdUDTr/GVfwIlqIKhMr5K9Cdtg/eVmRltaoO0jI3Jx4ZWUx2VtH
 TUA4u9hujU6Dn/dQci/+gXHTvWlbOFV2j5qF531LFq6IIL8DvPx3CWKNFwo66TeOyuXmpisIOJj
 Pj6Meo3mLzx2PfArrZ7w3VrW8wYkbbfzPX/YExdNGVN7zDIw0NRxQIfiMN6hiP9jvPYjJe83AhK
 35fEeHZtN/GLwJ6WeIxpNeXWF4yY4TZUBTzCNxAyJ7M4KIVtElf7S6H02SJSc5YYJWT3PLS9SWn
 w/zLHK6SMBfkVuU0P/KRCegFg0rejIVgIcwiuHy8vwQGhIdAcMwSb4N18jeOUY9UdGlxWZi3UlJ
 4ZhKBG8nJby2NH2RtpRyZwbFm5kDuOIQpZMjCTu37DxX6AMe
X-Received: by 2002:a05:7022:170c:b0:1b0:166c:6a94 with SMTP id
 a92af1059eb24-1b0166c6be4mr1392307c88.28.1793464887661; 
 Sat, 31 Oct 2026 09:41:27 -0700 (PDT)
Received: from DESKTOP-Q716RM7 ([103.94.185.75])
 by smtp.googlemail.com with ESMTPSA id
 a92af1059eb24-1ac193b8179sm19574572c88.11.2026.10.31.09.41.22
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 31 Oct 2026 09:41:26 -0700 (PDT)
From: Yonggang Luo <luoyonggang@gmail.com>
To: qemu-devel@nongnu.org
Cc: "Michael S. Tsirkin" <mst@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 qemu-arm@nongnu.org, Song Gao <17746591750@163.com>,
 Matthew Rosato <mjrosato@linux.ibm.com>,
 Philippe Mathieu-Daude <philmd@mailo.com>,
 David Hildenbrand <david@kernel.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>,
 Fam Zheng <fam@euphon.net>, Max Filippov <jcmvbkbc@gmail.com>,
 qemu-s390x@nongnu.org, Jiaxun Yang <jiaxun.yang@flygoat.com>,
 "Edgar E. Iglesias" <edgar.iglesias@gmail.com>,
 Eric Farman <farman@linux.ibm.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 Cornelia Huck <cohuck@redhat.com>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
Subject: [PATCH v2 11/12] hw/virtio/virtio-mem: register legacy-guest variant
 with is_available
Date: Sun,  1 Nov 2026 00:40:06 +0800
Message-ID: <20261031164009.2048-12-luoyonggang@gmail.com>
X-Mailer: git-send-email 2.55.0.windows.3
In-Reply-To: <20261031164009.2048-1-luoyonggang@gmail.com>
References: <20261031164009.2048-1-luoyonggang@gmail.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::122a;
 envelope-from=luoyonggang@gmail.com; helo=mail-dl1-x122a.google.com
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
 hw/virtio/virtio-mem.c         | 52 +++++++++++++++++++++-------------
 include/hw/virtio/virtio-mem.h |  2 ++
 2 files changed, 34 insertions(+), 20 deletions(-)

diff --git a/hw/virtio/virtio-mem.c b/hw/virtio/virtio-mem.c
index ee6a0c206af..ab2864d18c3 100644
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
@@ -1660,6 +1642,19 @@ static void virtio_mem_class_init(ObjectClass *klass, const void *data)
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
+static bool target_not_base_i386(void)
+{
+    return !target_base_i386();
+}
+
 static const TypeInfo virtio_mem_info = {
     .name = TYPE_VIRTIO_MEM,
     .parent = TYPE_VIRTIO_DEVICE,
@@ -1668,6 +1663,22 @@ static const TypeInfo virtio_mem_info = {
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
@@ -1677,6 +1688,7 @@ static const TypeInfo virtio_mem_info = {
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


