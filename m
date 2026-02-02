Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F03AEE7FDE4
	for <qemu-devel@archiver.kernel.org>; Mon,  2 Feb 2026 21:23:09 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vn1M6-0004X3-CD; Mon, 02 Feb 2026 16:21:10 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vn1M4-0004Wd-EK
 for qemu-devel@nongnu.org; Mon, 02 Feb 2026 16:21:08 -0500
Received: from mail-wm1-x336.google.com ([2a00:1450:4864:20::336])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vn1M2-0007Lz-Iq
 for qemu-devel@nongnu.org; Mon, 02 Feb 2026 16:21:08 -0500
Received: by mail-wm1-x336.google.com with SMTP id
 5b1f17b1804b1-4805ef35864so42032015e9.0
 for <qemu-devel@nongnu.org>; Mon, 02 Feb 2026 13:21:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1770067261; x=1770672061; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=legVcGNyjRa2lR5kbPRfIkXIuqxbddQOaBVHlXWvfIY=;
 b=odf/hVMPd4Jrgl+txLoZL+uvpKOpmJXJtbZfOE5S9kBuNKSltxWPpR5syGHblTmumM
 rH2QedjOyJsYbHPy5A2g/wfql7lBx2PSOD8oxIXqt6MKbCgYBl5B44FUpyk8EyTzpn8o
 44UnKGSCFBJI88W1jVvK8Ab6Hq9AL5Jvw/fH5qKqOriq/pLxrxcZAas0pYlw5OkKSmRm
 QR1kKK6ns7qU6yu9pGHBBxy1Umhq51Jb2bRkHBpPJmvvVb6Wp6v8eMBTxnBsCf4enhgs
 jM5I9yniwIWGAShv9p341GlMiiOemlrJybOakK7cPhRyDFGuFrHtoHydVE0Vpo0/ryH2
 9RaA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1770067261; x=1770672061;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=legVcGNyjRa2lR5kbPRfIkXIuqxbddQOaBVHlXWvfIY=;
 b=koq6qVS4MUJsTcbGQj5P3i+AkQgIttP0ePEa6DlYmm2Fm8QGCu018lOPWYZqKddoax
 sH/k9Q0XemcRpZNN6dyNVb29jrbywfoOVEMOnJXAq9xEzKGgN731U/D6VUttmwi39sPI
 1sWvLMlJmn59sA7xsw42k5bunpczR6dYWZTnTCyW20BEp7BhSMCh6QQa5WNZHL+00v+v
 COpBpQKQ24cal3zRKq7v3nPof32TtYhYm/Qr24GNhWejTTXE0Yhwh9s+gaM2hIv5YwkI
 GVA72s/LVqMxd3P/TPazY2Mkc3JDKp2Zix/WvDo84f0gmhSjIggPwmHR74M0yGhlN9dB
 D8wA==
X-Gm-Message-State: AOJu0YwSBRdowN38Yys6Mqs1fwu4ZKj4zD3hFdm5N/CiHZSRNAfGXrvW
 lWucbFl904PNU/DIEiIQYVeOOxTsUV2zkPDddxmELcQESc5h5gROCCruMDh/OyY9iyIXFsc9ama
 NiXdCbKU=
X-Gm-Gg: AZuq6aJB5BY3AluEtyIVikfE7PorfXXERWvS4zRETHqs6TbLWHt/2nNAn5IcOe7fbw5
 HeuB5s1qbhljG0Gs5pQrnXvWnATs3XUIWrxte7FWH16MKywrFQbaT/+yxuSTZoFAEZTSnBsoFp0
 2yRyDESDYFA2KqCR6xb6Pxk7zEabLPs4ZrS8ovnGF+dpJ49TQQHVrgucJm9e6ZvY1BoVq8iFg8u
 mqZ3fv+hRXvCPhLyphPLL2e4aRp36ZSG1wWO5/hVbVE2eKY5yJSvCg4mILSfxl6tJ96ghaknvK7
 YEINouJRqrHh77pjf60S78xUQsswJmpA+lcWpP0B1+kUgy3CBjP21IvCOoxdFE8HKH6BTOggYUp
 HfeaNdVVwPnPIgVqeZsUZznn5abDQK3b7L79J/FZFLKmxFw4zrNMhS6DjBYYZXDjYUbXasY9NUD
 ZBZXgq8ZXaueUt0P9HlUKn4hd3vochMCv6njldErJX0CQUNYosVE5u2RM4S51b
X-Received: by 2002:a05:600c:3e1b:b0:477:afc5:fb02 with SMTP id
 5b1f17b1804b1-482db47cd93mr140204285e9.21.1770067260906; 
 Mon, 02 Feb 2026 13:21:00 -0800 (PST)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4830511ccd0sm13520285e9.1.2026.02.02.13.21.00
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Mon, 02 Feb 2026 13:21:00 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 06/16] memory: Remove memory_region_init_rom_device_nomigrate()
Date: Mon,  2 Feb 2026 22:20:09 +0100
Message-ID: <20260202212019.94205-7-philmd@linaro.org>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260202212019.94205-1-philmd@linaro.org>
References: <20260202212019.94205-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::336;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x336.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
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

From: BALATON Zoltan <balaton@eik.bme.hu>

This function is not used outside of memory_region_init_rom_device()
which is its only caller. Inline it there and remove it.

Signed-off-by: BALATON Zoltan <balaton@eik.bme.hu>
Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Message-ID: <e6f973ff3c243fe1780bf01c3e67c9e019b08fa9.1770042013.git.balaton@eik.bme.hu>
Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 docs/devel/memory.rst                         |  1 -
 .../memory-region-housekeeping.cocci          |  8 ----
 include/system/memory.h                       | 27 ------------
 system/memory.c                               | 41 ++++++-------------
 4 files changed, 13 insertions(+), 64 deletions(-)

diff --git a/docs/devel/memory.rst b/docs/devel/memory.rst
index f22146e56ce..8558f70a421 100644
--- a/docs/devel/memory.rst
+++ b/docs/devel/memory.rst
@@ -114,7 +114,6 @@ the backing memory yourself, you can call the functions:
 
 - memory_region_init_ram_nomigrate()
 - memory_region_init_rom_nomigrate()
-- memory_region_init_rom_device_nomigrate()
 
 which only initialize the MemoryRegion and leave handling
 migration to the caller.
diff --git a/scripts/coccinelle/memory-region-housekeeping.cocci b/scripts/coccinelle/memory-region-housekeeping.cocci
index 29651ebde90..7f89e9712ec 100644
--- a/scripts/coccinelle/memory-region-housekeeping.cocci
+++ b/scripts/coccinelle/memory-region-housekeeping.cocci
@@ -97,14 +97,6 @@ expression NAME;
 expression SIZE;
 expression ERRP;
 @@
--memory_region_init_rom_device_nomigrate(MR, NULL, OPS, OPAQUE, NAME, SIZE, ERRP);
-+memory_region_init_rom_device(MR, NULL, OPS, OPAQUE, NAME, SIZE, ERRP);
- ...
--vmstate_register_ram_global(MR);
-
-
-// Device is owner
-@@
 typedef DeviceState;
 identifier device_fn, dev, obj;
 expression E1, E2, E3, E4, E5;
diff --git a/include/system/memory.h b/include/system/memory.h
index 8f8725ea2d5..0562af31361 100644
--- a/include/system/memory.h
+++ b/include/system/memory.h
@@ -1614,33 +1614,6 @@ bool memory_region_init_rom_nomigrate(MemoryRegion *mr,
                                       uint64_t size,
                                       Error **errp);
 
-/**
- * memory_region_init_rom_device_nomigrate:  Initialize a ROM memory region.
- *                                 Writes are handled via callbacks.
- *
- * Note that this function does not do anything to cause the data in the
- * RAM side of the memory region to be migrated; that is the responsibility
- * of the caller.
- *
- * @mr: the #MemoryRegion to be initialized.
- * @owner: the object that tracks the region's reference count
- * @ops: callbacks for write access handling (must not be NULL).
- * @opaque: passed to the read and write callbacks of the @ops structure.
- * @name: Region name, becomes part of RAMBlock name used in migration stream
- *        must be unique within any device
- * @size: size of the region.
- * @errp: pointer to Error*, to store an error if it happens.
- *
- * Return: true on success, else false setting @errp with error.
- */
-bool memory_region_init_rom_device_nomigrate(MemoryRegion *mr,
-                                             Object *owner,
-                                             const MemoryRegionOps *ops,
-                                             void *opaque,
-                                             const char *name,
-                                             uint64_t size,
-                                             Error **errp);
-
 /**
  * memory_region_init_iommu: Initialize a memory region of a custom type
  * that translates addresses
diff --git a/system/memory.c b/system/memory.c
index 4bf00d82bcf..a9032fb2cfe 100644
--- a/system/memory.c
+++ b/system/memory.c
@@ -1748,32 +1748,6 @@ bool memory_region_init_rom_nomigrate(MemoryRegion *mr,
     return true;
 }
 
-bool memory_region_init_rom_device_nomigrate(MemoryRegion *mr,
-                                             Object *owner,
-                                             const MemoryRegionOps *ops,
-                                             void *opaque,
-                                             const char *name,
-                                             uint64_t size,
-                                             Error **errp)
-{
-    Error *err = NULL;
-    assert(ops);
-    memory_region_init(mr, owner, name, size);
-    mr->ops = ops;
-    mr->opaque = opaque;
-    mr->terminates = true;
-    mr->rom_device = true;
-    mr->destructor = memory_region_destructor_ram;
-    mr->ram_block = qemu_ram_alloc(size, 0, mr, &err);
-    if (err) {
-        mr->size = int128_zero();
-        object_unparent(OBJECT(mr));
-        error_propagate(errp, err);
-        return false;
-    }
-    return true;
-}
-
 void memory_region_init_iommu(void *_iommu_mr,
                               size_t instance_size,
                               const char *mrtypename,
@@ -3802,9 +3776,20 @@ bool memory_region_init_rom_device(MemoryRegion *mr,
                                    Error **errp)
 {
     DeviceState *owner_dev;
+    Error *err = NULL;
 
-    if (!memory_region_init_rom_device_nomigrate(mr, owner, ops, opaque,
-                                                 name, size, errp)) {
+    assert(ops);
+    memory_region_init(mr, owner, name, size);
+    mr->ops = ops;
+    mr->opaque = opaque;
+    mr->terminates = true;
+    mr->rom_device = true;
+    mr->destructor = memory_region_destructor_ram;
+    mr->ram_block = qemu_ram_alloc(size, 0, mr, &err);
+    if (err) {
+        mr->size = int128_zero();
+        object_unparent(OBJECT(mr));
+        error_propagate(errp, err);
         return false;
     }
     /* This will assert if owner is neither NULL nor a DeviceState.
-- 
2.52.0


