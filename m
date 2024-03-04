Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1CE2BC5478C
	for <qemu-devel@archiver.kernel.org>; Mon,  4 Mar 2024 10:07:31 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rh5DB-0007T3-6c; Mon, 04 Mar 2024 05:06:21 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mnissler@rivosinc.com>)
 id 1rh5DA-0007SR-7T
 for qemu-devel@nongnu.org; Mon, 04 Mar 2024 05:06:20 -0500
Received: from mail-pl1-x629.google.com ([2607:f8b0:4864:20::629])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <mnissler@rivosinc.com>)
 id 1rh5D8-0006IL-9O
 for qemu-devel@nongnu.org; Mon, 04 Mar 2024 05:06:19 -0500
Received: by mail-pl1-x629.google.com with SMTP id
 d9443c01a7336-1dc13fb0133so31047145ad.3
 for <qemu-devel@nongnu.org>; Mon, 04 Mar 2024 02:06:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=rivosinc-com.20230601.gappssmtp.com; s=20230601; t=1709546775; x=1710151575;
 darn=nongnu.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=8rF+7GtIf1rtTmKIckGnSl1eaAm4N6ysn3Y/c7lHL+s=;
 b=hk6WXwIBjHNwC6OFk1xIw1nVV7bVDy0l9BqRjITIMb6C4PjwHAWRz/zNvJsW7u/k9f
 ViLKUZGTNsE8H/CoLuYkT9fbixJJ5i+Wp1GIUNWxBz2krfm/82ykz+g/sZW5jw1V6uDx
 l2T+5qV5Y1arFCd4R2HSSXX79O3Oewjy9INcRMhXECknekSuha1Xo980xzU3cJwwbAko
 EMO5ely7eO0YmDx1lCf5vnbjRDO5gwIr1q3BqzcfyIyQkwoBevJaUvOFf4YeANbMSpaA
 4M9VO3qi8SOMfbQUEIwxvFcNUrh11/zGPK0X0iFbSS9S+QxFOBpP8YB/NinWKnU2otoR
 laEw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1709546775; x=1710151575;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=8rF+7GtIf1rtTmKIckGnSl1eaAm4N6ysn3Y/c7lHL+s=;
 b=fTxEbKGTjN9fjK+ekj11dcfVpn9UWG5bGVCDc3a99tMkCDkuYt54ONPbm2Vm53l/BM
 GB7/otGL8pq8XzY/UFUVbL8vaiXjO+V1RnU+pghzGRL3X/9AwMRmx7dOAxYoPDvld9Cr
 kRRsSP5kdwsotRpCurJtvzuC+LE7Y1DE95iZLkH8nG8Gnz73IoIVxusU2t+MuBY7WjHh
 LKcjv//B1lzdV5acz2ydCma7Uf3ZTklmBADhgkfJTaZ/xp6AECBgZKTJUUCp2UFGnfuu
 rMsQl2y9TXhowzxATp1QeTES20w9ywkqW7/7QrMqNvsQFQjCMbTeDU9zMKU2DxyiKyW6
 YNbg==
X-Forwarded-Encrypted: i=1;
 AJvYcCVIYUIa/23YkOrgI7IZbDEnPjExik7dmkhsz0bXmkmoPvoYiy0ucZ2AfmUGVMaUrlLQ+UuQi63PklnlHES/SceSXkMku7g=
X-Gm-Message-State: AOJu0Yx5u0xTUuGQF0ftTIQ1vnfuiVIvImPfjwaKrYLpZ0O3WjtMSwAW
 2j3Jz3hmsqqS45s5/LWvqxw121m9kzpW6d5XNTb9lFHfFFGU9e2lZ8IVD2mvvJU=
X-Google-Smtp-Source: AGHT+IGqIhHmp3DUy138+wzLN9QrpTtKaV9YLz3kGPCmnoOJoQhs1RKGrrQIok5dotOJaNSRn45x2g==
X-Received: by 2002:a17:902:b717:b0:1db:51ee:8677 with SMTP id
 d23-20020a170902b71700b001db51ee8677mr7783405pls.59.1709546775355; 
 Mon, 04 Mar 2024 02:06:15 -0800 (PST)
Received: from mnissler.ba.rivosinc.com ([64.71.180.162])
 by smtp.gmail.com with ESMTPSA id
 y18-20020a170902e19200b001dc95e7e191sm8091570pla.298.2024.03.04.02.06.14
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 04 Mar 2024 02:06:15 -0800 (PST)
From: Mattias Nissler <mnissler@rivosinc.com>
To: stefanha@redhat.com, jag.raman@oracle.com, peterx@redhat.com,
 qemu-devel@nongnu.org
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 john.levon@nutanix.com, David Hildenbrand <david@redhat.com>,
 "Michael S. Tsirkin" <mst@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Elena Ufimtseva <elena.ufimtseva@oracle.com>,
 Mattias Nissler <mnissler@rivosinc.com>
Subject: [PATCH v8 4/5] vfio-user: Message-based DMA support
Date: Mon,  4 Mar 2024 02:05:53 -0800
Message-Id: <20240304100554.1143763-5-mnissler@rivosinc.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240304100554.1143763-1-mnissler@rivosinc.com>
References: <20240304100554.1143763-1-mnissler@rivosinc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::629;
 envelope-from=mnissler@rivosinc.com; helo=mail-pl1-x629.google.com
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001, T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

Wire up support for DMA for the case where the vfio-user client does not
provide mmap()-able file descriptors, but DMA requests must be performed
via the VFIO-user protocol. This installs an indirect memory region,
which already works for pci_dma_{read,write}, and pci_dma_map works
thanks to the existing DMA bounce buffering support.

Note that while simple scenarios work with this patch, there's a known
race condition in libvfio-user that will mess up the communication
channel. See https://github.com/nutanix/libvfio-user/issues/279 for
details as well as a proposed fix.

Reviewed-by: Jagannathan Raman <jag.raman@oracle.com>
Signed-off-by: Mattias Nissler <mnissler@rivosinc.com>
---
 hw/remote/trace-events    |   2 +
 hw/remote/vfio-user-obj.c | 100 ++++++++++++++++++++++++++++++++------
 2 files changed, 87 insertions(+), 15 deletions(-)

diff --git a/hw/remote/trace-events b/hw/remote/trace-events
index 0d1b7d56a5..358a68fb34 100644
--- a/hw/remote/trace-events
+++ b/hw/remote/trace-events
@@ -9,6 +9,8 @@ vfu_cfg_read(uint32_t offset, uint32_t val) "vfu: cfg: 0x%x -> 0x%x"
 vfu_cfg_write(uint32_t offset, uint32_t val) "vfu: cfg: 0x%x <- 0x%x"
 vfu_dma_register(uint64_t gpa, size_t len) "vfu: registering GPA 0x%"PRIx64", %zu bytes"
 vfu_dma_unregister(uint64_t gpa) "vfu: unregistering GPA 0x%"PRIx64""
+vfu_dma_read(uint64_t gpa, size_t len) "vfu: DMA read 0x%"PRIx64", %zu bytes"
+vfu_dma_write(uint64_t gpa, size_t len) "vfu: DMA write 0x%"PRIx64", %zu bytes"
 vfu_bar_register(int i, uint64_t addr, uint64_t size) "vfu: BAR %d: addr 0x%"PRIx64" size 0x%"PRIx64""
 vfu_bar_rw_enter(const char *op, uint64_t addr) "vfu: %s request for BAR address 0x%"PRIx64""
 vfu_bar_rw_exit(const char *op, uint64_t addr) "vfu: Finished %s of BAR address 0x%"PRIx64""
diff --git a/hw/remote/vfio-user-obj.c b/hw/remote/vfio-user-obj.c
index d9b879e056..a15e291c9a 100644
--- a/hw/remote/vfio-user-obj.c
+++ b/hw/remote/vfio-user-obj.c
@@ -300,6 +300,63 @@ static ssize_t vfu_object_cfg_access(vfu_ctx_t *vfu_ctx, char * const buf,
     return count;
 }
 
+static MemTxResult vfu_dma_read(void *opaque, hwaddr addr, uint64_t *val,
+                                unsigned size, MemTxAttrs attrs)
+{
+    MemoryRegion *region = opaque;
+    vfu_ctx_t *vfu_ctx = VFU_OBJECT(region->owner)->vfu_ctx;
+    uint8_t buf[sizeof(uint64_t)];
+
+    trace_vfu_dma_read(region->addr + addr, size);
+
+    g_autofree dma_sg_t *sg = g_malloc0(dma_sg_size());
+    vfu_dma_addr_t vfu_addr = (vfu_dma_addr_t)(region->addr + addr);
+    if (vfu_addr_to_sgl(vfu_ctx, vfu_addr, size, sg, 1, PROT_READ) < 0 ||
+        vfu_sgl_read(vfu_ctx, sg, 1, buf) != 0) {
+        return MEMTX_ERROR;
+    }
+
+    *val = ldn_he_p(buf, size);
+
+    return MEMTX_OK;
+}
+
+static MemTxResult vfu_dma_write(void *opaque, hwaddr addr, uint64_t val,
+                                 unsigned size, MemTxAttrs attrs)
+{
+    MemoryRegion *region = opaque;
+    vfu_ctx_t *vfu_ctx = VFU_OBJECT(region->owner)->vfu_ctx;
+    uint8_t buf[sizeof(uint64_t)];
+
+    trace_vfu_dma_write(region->addr + addr, size);
+
+    stn_he_p(buf, size, val);
+
+    g_autofree dma_sg_t *sg = g_malloc0(dma_sg_size());
+    vfu_dma_addr_t vfu_addr = (vfu_dma_addr_t)(region->addr + addr);
+    if (vfu_addr_to_sgl(vfu_ctx, vfu_addr, size, sg, 1, PROT_WRITE) < 0 ||
+        vfu_sgl_write(vfu_ctx, sg, 1, buf) != 0) {
+        return MEMTX_ERROR;
+    }
+
+    return MEMTX_OK;
+}
+
+static const MemoryRegionOps vfu_dma_ops = {
+    .read_with_attrs = vfu_dma_read,
+    .write_with_attrs = vfu_dma_write,
+    .endianness = DEVICE_HOST_ENDIAN,
+    .valid = {
+        .min_access_size = 1,
+        .max_access_size = 8,
+        .unaligned = true,
+    },
+    .impl = {
+        .min_access_size = 1,
+        .max_access_size = 8,
+    },
+};
+
 static void dma_register(vfu_ctx_t *vfu_ctx, vfu_dma_info_t *info)
 {
     VfuObject *o = vfu_get_private(vfu_ctx);
@@ -308,17 +365,30 @@ static void dma_register(vfu_ctx_t *vfu_ctx, vfu_dma_info_t *info)
     g_autofree char *name = NULL;
     struct iovec *iov = &info->iova;
 
-    if (!info->vaddr) {
-        return;
-    }
-
     name = g_strdup_printf("mem-%s-%"PRIx64"", o->device,
-                           (uint64_t)info->vaddr);
+                           (uint64_t)iov->iov_base);
 
     subregion = g_new0(MemoryRegion, 1);
 
-    memory_region_init_ram_ptr(subregion, NULL, name,
-                               iov->iov_len, info->vaddr);
+    if (info->vaddr) {
+        memory_region_init_ram_ptr(subregion, OBJECT(o), name,
+                                   iov->iov_len, info->vaddr);
+    } else {
+        /*
+         * Note that I/O regions' MemoryRegionOps handle accesses of at most 8
+         * bytes at a time, and larger accesses are broken down. However,
+         * many/most DMA accesses are larger than 8 bytes and VFIO-user can
+         * handle large DMA accesses just fine, thus this size restriction
+         * unnecessarily hurts performance, in particular given that each
+         * access causes a round trip on the VFIO-user socket.
+         *
+         * TODO: Investigate how to plumb larger accesses through memory
+         * regions, possibly by amending MemoryRegionOps or by creating a new
+         * memory region type.
+         */
+        memory_region_init_io(subregion, OBJECT(o), &vfu_dma_ops, subregion,
+                              name, iov->iov_len);
+    }
 
     dma_as = pci_device_iommu_address_space(o->pci_dev);
 
@@ -330,20 +400,20 @@ static void dma_register(vfu_ctx_t *vfu_ctx, vfu_dma_info_t *info)
 static void dma_unregister(vfu_ctx_t *vfu_ctx, vfu_dma_info_t *info)
 {
     VfuObject *o = vfu_get_private(vfu_ctx);
+    MemoryRegionSection mr_section;
     AddressSpace *dma_as = NULL;
-    MemoryRegion *mr = NULL;
-    ram_addr_t offset;
 
-    mr = memory_region_from_host(info->vaddr, &offset);
-    if (!mr) {
+    dma_as = pci_device_iommu_address_space(o->pci_dev);
+
+    mr_section =
+        memory_region_find(dma_as->root, (hwaddr)info->iova.iov_base, 1);
+    if (!mr_section.mr) {
         return;
     }
 
-    dma_as = pci_device_iommu_address_space(o->pci_dev);
-
-    memory_region_del_subregion(dma_as->root, mr);
+    memory_region_del_subregion(dma_as->root, mr_section.mr);
 
-    object_unparent((OBJECT(mr)));
+    object_unparent((OBJECT(mr_section.mr)));
 
     trace_vfu_dma_unregister((uint64_t)info->iova.iov_base);
 }
-- 
2.34.1


