Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2C004C61DB9
	for <qemu-devel@archiver.kernel.org>; Thu, 27 Aug 2026 19:41:22 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wzfxm-0007JT-8c; Thu, 27 Aug 2026 15:40:38 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ombarkare123@gmail.com>)
 id 1wzfxl-0007JI-35
 for qemu-devel@nongnu.org; Thu, 27 Aug 2026 15:40:37 -0400
Received: from mail-pl1-x633.google.com ([2607:f8b0:4864:20::633])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <ombarkare123@gmail.com>)
 id 1wzfxj-0000Zu-2t
 for qemu-devel@nongnu.org; Thu, 27 Aug 2026 15:40:36 -0400
Received: by mail-pl1-x633.google.com with SMTP id
 d9443c01a7336-2d6fe26ef1cso371835ad.2
 for <qemu-devel@nongnu.org>; Thu, 27 Aug 2026 12:40:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1787859633; x=1788464433; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=k2zIlgdFQU3TY4LMMxQgH15G917M3Or+0AL8VyTPDfw=;
 b=CsXF0g8Xz0iFLhU1nWSHBmGXkQFP0eB7FE5KaNfrtnI8d4cfspj4nnjMGLXekumaN4
 cNgqs9f82t26+CFS0Ln0sfc636BezCnD2nuih7rFovAG1BZgXEXXlo+W25ZuaB4HRK4b
 Zb6asVwcGkjdBm8XPKnVcVt4Wf4wym6WnVCGBnNHZcG9nHLUulXaVPD8bF586lTwFPdw
 DBEOsqea+wrEEHWpalYzYMakf1LqrvAmH9n5qjG8SG5WavJiMiRT2ySxrJss2jZnjaXZ
 +mxxQAzh4pvziJ7xEBfhGVfcsneX+buOkRk2cx2O/Mav00EaZUhcAt4tBHreCzIDS5IO
 8KcQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787859633; x=1788464433;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=k2zIlgdFQU3TY4LMMxQgH15G917M3Or+0AL8VyTPDfw=;
 b=r3BnyAR7ONogHjh64qgQxIG/j9XKQ+6K2T4fPlL1BYaTze2LwNkH/OdBAbzqY9Tr6z
 mAtTI2A4WhB74FhCTEV3N5tLAmoTlz7pQsSDSnDrdX7zKX0da4yCXsV23v15uUHRvtwQ
 dE+XNdQnoMIcWodUYfH+r4whLj3MhlT8wH7NqfPKVl3s7vTbz7+mc6BriTsmowG10Vbd
 QxsTGObeWSvZTk8U7XJ7vZnBDMpn3DAqNuq5BD5VW7X3DYpvhjc9T7HpeJwTdPxvfYOh
 kli+7lZh7bsn1s1ErZcDxUUIMVt09UQHuTfTqMblpXZcv9OZ5LmCF1+b6B1uCzGBrE+2
 azAQ==
X-Gm-Message-State: AFuF++kkvK3D5gLsnFJh55bhHiJMR3N7LflML17FCMscx5rl88RcpM3I
 YJJSm9LgCLpLexemcRElzs69BivoQJF9M4xpCAiC/m2LugMOfGyHbvP4i+Rdc9QQc6pmoYh5
X-Gm-Gg: AR+sD11RZqk0qje2svEkyoXFa3utSHE1yg4dhofEPGjjRYRcEbiouGdDweWL4LkTqEv
 S5uaco7cuhdEcTWFd1TDwN2yD26m4qPQoVhbLDbeCpttxaRKEy1ZOwI4QbG0+oXbNNbwLrFGPZG
 g+x4HYxZxRwcPfPe8NxZWlverNMP/i9gOCzYITqEJFTvTJqhjH47BSaPiTKlMQgCAYTbfh56Gwc
 Sl5pNYLSFeXAk93uyLJFMKNBo1XiuLLekgx09RpV4R3rbi0Q21QJPRcZerQnIit+gTf0HXvg6oY
 waBJTwQHCqYqS48/AAmTKCXB4IxFLn5o/NSYCuqWLKF2pJdhZTcLKgpLEdAKFj1kv/yEmj282JO
 rj3wDQmdfRUZeKeaoIiMUTUwoiYikx7+cpRS94eUU0gZweYbLKEq25j0P00W9wZpxEgPAhXTOZ/
 A/GcV1+X/7od04hU/WclhgzJVx8scfDVNWFTiE+BAp//kkYXfVOovcfhbTuAs=
X-Received: by 2002:a17:903:46cb:b0:2d0:cc92:f7c2 with SMTP id
 d9443c01a7336-2d74dbe9c82mr26007935ad.1.1787859633301; 
 Thu, 27 Aug 2026 12:40:33 -0700 (PDT)
Received: from fedora ([103.199.188.243]) by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-3283d60b59dsm22150797eec.3.2026.08.27.12.40.28
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 27 Aug 2026 12:40:32 -0700 (PDT)
From: Om Barkare <ombarkare123@gmail.com>
To: qemu-devel@nongnu.org
Cc: peter.maydell@linaro.org, philmd@mailo.com, kwolf@redhat.com,
 hreitz@redhat.com, OmBarkare <ombarkare123@gmail.com>
Subject: [PATCH v2] hw/block: Add migration support for pflash_cfi02.c
Date: Fri, 28 Aug 2026 01:09:42 +0530
Message-ID: <20260827193942.69406-1-ombarkare123@gmail.com>
X-Mailer: git-send-email 2.55.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::633;
 envelope-from=ombarkare123@gmail.com; helo=mail-pl1-x633.google.com
X-Spam_score_int: -17
X-Spam_score: -1.8
X-Spam_bar: -
X-Spam_report: (-1.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FREEMAIL_ENVFROM_END_DIGIT=0.25, FREEMAIL_FROM=0.001,
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

From: OmBarkare <ombarkare123@gmail.com>

Device did not have migration support, which would result in its
internal state being lost during migration or saves.

Add VMStateDescription to serialize state and set memory regions
romd_mode to rom_mode field in post load hook

total_sectors was changed from uint32_t to int32_t to satisfy the
VMSTATE_BITMAP macro's _field_size argument, but that is OK because
it's a value is calculated using the size of the flash and it will
never be large enough to overflow int32_t

The only boards using pflash_cfi02 are the sh4 r2d and
the arm canon-a1100, musicpal and xilinx-zynq-a9

Resolves: https://gitlab.com/qemu-project/qemu/-/work_items/4157

Suggested-by: Peter Maydell <peter.maydell@linaro.org>
Signed-off-by: Om Barkare <ombarkare123@gmail.com>
---
Changes since v1
- Add "bypass" to vmstate
- Remove the vmstate subsection and add these states to the main vmstate
  instead
- Remove the pflash_erase_sector_needed function which was related to
  the subsection as no longer needed

 hw/block/pflash_cfi02.c | 52 ++++++++++++++++++++++++++++++++++++++++-
 1 file changed, 51 insertions(+), 1 deletion(-)

diff --git a/hw/block/pflash_cfi02.c b/hw/block/pflash_cfi02.c
index 6f952fe7de..4f72c438c0 100644
--- a/hw/block/pflash_cfi02.c
+++ b/hw/block/pflash_cfi02.c
@@ -46,6 +46,7 @@
 #include "qemu/module.h"
 #include "hw/core/sysbus.h"
 #include "migration/vmstate.h"
+#include "system/runstate.h"
 #include "trace.h"
 
 #define PFLASH_LAZY_ROMD_THRESHOLD 42
@@ -71,7 +72,7 @@ struct PFlashCFI02 {
     BlockBackend *blk;
     uint32_t uniform_nb_blocs;
     uint32_t uniform_sector_len;
-    uint32_t total_sectors;
+    int32_t total_sectors;
     uint32_t nb_blocs[PFLASH_MAX_ERASE_REGIONS];
     uint32_t sector_len[PFLASH_MAX_ERASE_REGIONS];
     uint32_t chip_len;
@@ -107,6 +108,29 @@ struct PFlashCFI02 {
     unsigned long *sector_erase_map;
     char *name;
     void *storage;
+    VMChangeStateEntry *vmstate;
+};
+
+static int pflash_post_load(void *opaque, int version_id);
+
+static const VMStateDescription vmstate_pflash = {
+    .name = "pflash_cfi02",
+    .version_id = 1,
+    .minimum_version_id = 1,
+    .post_load = pflash_post_load,
+    .fields = (const VMStateField[]) {
+        VMSTATE_INT32(wcycle, PFlashCFI02),
+        VMSTATE_INT32(bypass, PFlashCFI02),
+        VMSTATE_UINT8(cmd, PFlashCFI02),
+        VMSTATE_UINT8(status, PFlashCFI02),
+        VMSTATE_TIMER(timer, PFlashCFI02),
+        VMSTATE_BOOL(rom_mode, PFlashCFI02),
+        VMSTATE_INT32(read_counter, PFlashCFI02),
+        VMSTATE_INT32(sectors_to_erase, PFlashCFI02),
+        VMSTATE_UINT64(erase_time_remaining, PFlashCFI02),
+        VMSTATE_BITMAP(sector_erase_map, PFlashCFI02, 1, total_sectors),
+        VMSTATE_END_OF_LIST()
+    }
 };
 
 /*
@@ -976,6 +1000,7 @@ static void pflash_cfi02_class_init(ObjectClass *klass, const void *data)
     device_class_set_legacy_reset(dc, pflash_cfi02_reset);
     dc->unrealize = pflash_cfi02_unrealize;
     device_class_set_props(dc, pflash_cfi02_properties);
+    dc->vmsd = &vmstate_pflash;
     set_bit(DEVICE_CATEGORY_STORAGE, dc->categories);
 }
 
@@ -1028,3 +1053,28 @@ PFlashCFI02 *pflash_cfi02_register(hwaddr base,
     sysbus_mmio_map(SYS_BUS_DEVICE(dev), 0, base);
     return PFLASH_CFI02(dev);
 }
+
+static void postload_update_cb(void *opaque, bool running, RunState state)
+{
+    PFlashCFI02 *pfl = opaque;
+
+    /* This is called after bdrv_activate_all.  */
+    qemu_del_vm_change_state_handler(pfl->vmstate);
+    pfl->vmstate = NULL;
+
+    trace_pflash_postload_cb(pfl->name);
+    pflash_update(pfl, 0, pfl->chip_len);
+}
+
+static int pflash_post_load(void *opaque, int version_id)
+{
+    PFlashCFI02 *pfl = opaque;
+
+    if (!pfl->ro) {
+        pfl->vmstate = qemu_add_vm_change_state_handler(postload_update_cb, pfl);
+    }
+
+    memory_region_rom_device_set_romd(&pfl->orig_mem, pfl->rom_mode);
+
+    return 0;
+}
-- 
2.55.0


