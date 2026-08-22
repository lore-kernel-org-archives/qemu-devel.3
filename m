Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3C571C5DF8C
	for <qemu-devel@archiver.kernel.org>; Sat, 22 Aug 2026 18:58:20 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wxquM-0002s7-5q; Sat, 22 Aug 2026 14:57:34 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ombarkare123@gmail.com>)
 id 1wxqdM-0008Kt-6f
 for qemu-devel@nongnu.org; Sat, 22 Aug 2026 14:40:00 -0400
Received: from mail-pl1-x635.google.com ([2607:f8b0:4864:20::635])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <ombarkare123@gmail.com>)
 id 1wxqdK-0006qN-AG
 for qemu-devel@nongnu.org; Sat, 22 Aug 2026 14:39:59 -0400
Received: by mail-pl1-x635.google.com with SMTP id
 d9443c01a7336-2d560775ca2so17807085ad.1
 for <qemu-devel@nongnu.org>; Sat, 22 Aug 2026 11:39:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1787423996; x=1788028796; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=sNCgd9GVXjdJAM8q8xdOHvRMqxnWF8AKk/p9/Yk7tHo=;
 b=a+ULWQboStF4uRt07ZPk9hBPbVOJRfBcBAnIA1bYxaC5o2WG6TPJ92i1iHwpCwYAFM
 rP6lu65Ncr0b1DZbgvIxk14HOrFzpTlLQIlrF4KSAKZZi2EUYTqmBdcMQmZhi52gnQcA
 6UI0PVbid5A0KipsQgprI2uL2MecocDvyu1UdkrrZKmdOMKiIKJX66Fy5lZF294Dy3QJ
 4JE3sEkeZy7x7iXi6UGE0Xhdgw9lHWHiVavTOy5VW+vtcm+rJ1zK/66PILGfZh133NnL
 +Y2KsJVMhFXjVZhqa0ql9TLmABbWfQ4F9Fvx6MhtPvvKQvfeoSfNJgbAQvA++c/wtDE3
 qceA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787423996; x=1788028796;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=sNCgd9GVXjdJAM8q8xdOHvRMqxnWF8AKk/p9/Yk7tHo=;
 b=UN+/W78wpwJ5kozN6S6F6Chi2P4kXgdfF8V1FMUAU+AAASLZnYofBtsvyEsB7HSV8W
 WAAFD2idMSCk/ForMDbG1nhJTki7Gan+kyhVX4R8ayozLK+8FgIW/og7FAbe/JmgHI7r
 RT3Y2j9o1Eb2QdfB2z6L49zOhLs1LLC2omi046WIpSQbwzD/6//FAzxMhkDsT5t1Vjcr
 zzElRcPFCWTb3Rkp9X9me4ZroA0EChp89nV3lK6vKxdUByu3g9M24Tj2xkR4P3Ffmn1Y
 OGknjNGXifudKWIOZ7VdNy2joToVj0CsbHExgs+pCP20fU0NVlhWnX+LIQT27Gqhh2fP
 PoLQ==
X-Gm-Message-State: AFuF++n3rozToJY/sLH9h/iphbiY6aSH8vFbjP9ce10xUMfOYSwiyrSc
 6htbDKAO+J2rHDwIwNoVKaS5dUsf35J3M6pOVehT6xBNAsCDzhRNifdQTc5MLVkRgX+lG+ip
X-Gm-Gg: AR+sD13H4iBSA+sVAISAyShxxu+ZKe1v2efO2cx/hQv7FnbBYQGkNdZ3sY/pl4BePRX
 pw9ezkTLH2x0enSspWw20t6tY29W22i7h9TVjqifDuJYvketCOWQZLE07Rp2AJ83PkbzHh4F7rb
 136LPzc3H1ElQYdqBsoSGyNU3i82rL3Jrei6inQwBQ4EgjMJjNoYUEUxnf4tmbrOqh6/YY7aZ+F
 Tq8uZwWcmzYlkT8xogddihdhXVWO1ycZ7S8s1qdKdAVAvSc3psERk3tvy3lGuSBEU1Q7NdvJeAl
 qvL8sZdDB9GyPSi/3/Tw4J/otpT2J9mbK+UibZnArcFla3s4QXKpCzx8owHnhe4Ab5vkH/54ODD
 +tq1ddNCvUtXWAeWw3CQn/eKivWzi24dZI8Br2gg2yDa+QOJ8oPh6tM3qZzG/auNU28RsdtWoTO
 Ykxjoy/B7whwzjNR+G/5gGG2HA1ayPwTppe48/6uemN6OcWTiTqDJ3FOqsp+jcB4ylNfVfM3mC4
 BXV
X-Received: by 2002:a17:903:476f:b0:2c0:e5ee:f55e with SMTP id
 d9443c01a7336-2d670bcd316mr124209355ad.7.1787423996202; 
 Sat, 22 Aug 2026 11:39:56 -0700 (PDT)
Received: from fedora.iiitdmj.ac.in ([14.139.241.214])
 by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-327f91d33dcsm11749788eec.18.2026.08.22.11.39.49
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 22 Aug 2026 11:39:55 -0700 (PDT)
From: Om Barkare <ombarkare123@gmail.com>
To: qemu-devel@nongnu.org
Cc: philmd@mailo.com, kwolf@redhat.com, hreitz@redhat.com,
 peter.maydell@linaro.org, OmBarkare <ombarkare123@gmail.com>
Subject: [PATCH] hw/block: Add migration support for pflash_cfi02.c
Date: Sun, 23 Aug 2026 00:09:00 +0530
Message-ID: <20260822183900.110111-1-ombarkare123@gmail.com>
X-Mailer: git-send-email 2.55.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::635;
 envelope-from=ombarkare123@gmail.com; helo=mail-pl1-x635.google.com
X-Spam_score_int: -17
X-Spam_score: -1.8
X-Spam_bar: -
X-Spam_report: (-1.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FREEMAIL_ENVFROM_END_DIGIT=0.25, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-Mailman-Approved-At: Sat, 22 Aug 2026 14:57:26 -0400
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

Resolves: https://gitlab.com/qemu-project/qemu/-/work_items/4157

Signed-off-by: Om Barkare <ombarkare123@gmail.com>
---
 hw/block/pflash_cfi02.c | 73 ++++++++++++++++++++++++++++++++++++++++-
 1 file changed, 72 insertions(+), 1 deletion(-)

diff --git a/hw/block/pflash_cfi02.c b/hw/block/pflash_cfi02.c
index 6f952fe7de..82965e6cdc 100644
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
@@ -107,6 +108,50 @@ struct PFlashCFI02 {
     unsigned long *sector_erase_map;
     char *name;
     void *storage;
+    VMChangeStateEntry *vmstate;
+};
+
+static int pflash_post_load(void *opaque, int version_id);
+
+static bool pflash_sector_erase_needed(void *opaque)
+{
+    PFlashCFI02 *pfl = opaque;
+
+    return (pfl->sectors_to_erase > 0);
+}
+
+static const VMStateDescription vmstate_pflash_sector_erase = {
+    .name = "pflash_cfi02_erase_sector",
+    .version_id = 1,
+    .minimum_version_id = 1,
+    .needed = pflash_sector_erase_needed,
+    .fields = (const VMStateField[]) {
+        VMSTATE_INT32(sectors_to_erase, PFlashCFI02),
+        VMSTATE_UINT64(erase_time_remaining, PFlashCFI02),
+        VMSTATE_BITMAP(sector_erase_map, PFlashCFI02, 1, total_sectors),
+        VMSTATE_END_OF_LIST()
+    }
+
+};
+
+static const VMStateDescription vmstate_pflash = {
+    .name = "pflash_cfi02",
+    .version_id = 1,
+    .minimum_version_id = 1,
+    .post_load = pflash_post_load,
+    .fields = (const VMStateField[]) {
+        VMSTATE_INT32(wcycle, PFlashCFI02),
+        VMSTATE_UINT8(cmd, PFlashCFI02),
+        VMSTATE_UINT8(status, PFlashCFI02),
+        VMSTATE_INT32(read_counter, PFlashCFI02),
+        VMSTATE_BOOL(rom_mode, PFlashCFI02),
+        VMSTATE_TIMER(timer, PFlashCFI02),
+        VMSTATE_END_OF_LIST()
+    },
+    .subsections = (const VMStateDescription * const []) {
+        &vmstate_pflash_sector_erase,
+        NULL
+    }
 };
 
 /*
@@ -976,6 +1021,7 @@ static void pflash_cfi02_class_init(ObjectClass *klass, const void *data)
     device_class_set_legacy_reset(dc, pflash_cfi02_reset);
     dc->unrealize = pflash_cfi02_unrealize;
     device_class_set_props(dc, pflash_cfi02_properties);
+    dc->vmsd = &vmstate_pflash;
     set_bit(DEVICE_CATEGORY_STORAGE, dc->categories);
 }
 
@@ -1028,3 +1074,28 @@ PFlashCFI02 *pflash_cfi02_register(hwaddr base,
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


