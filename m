Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 22028FD9E1A
	for <qemu-devel@archiver.kernel.org>; Thu, 26 Feb 2026 22:04:59 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vvjSV-0002t0-Mn; Thu, 26 Feb 2026 17:03:49 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vvjRz-0002ZR-Al
 for qemu-devel@nongnu.org; Thu, 26 Feb 2026 17:03:24 -0500
Received: from mail-wm1-x334.google.com ([2a00:1450:4864:20::334])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vvjRx-0001uw-Ms
 for qemu-devel@nongnu.org; Thu, 26 Feb 2026 17:03:15 -0500
Received: by mail-wm1-x334.google.com with SMTP id
 5b1f17b1804b1-4836f363d0dso11336755e9.3
 for <qemu-devel@nongnu.org>; Thu, 26 Feb 2026 14:03:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1772143391; x=1772748191; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=t1EnJk3wPeLwBeWTp7ZSpg6ulILpuVB2qbJBtvmV7es=;
 b=wnTmp33E3/g4keVi1swvVsZUr3BFJQp/TKqD9Kiogjah1lM5b64ERhfp+5mam+7qY1
 6XdQJAgXJg515w0M3mMrTZAJlU1N/dkF/uebiX5yhJ4t4AxA8sItTuRRF5uYCjlZkKVn
 YCOipFlTXjF/xERBiZC1HokSzyBRjvoBS8h+yAbBJxgpU1KmZqkbzR0/jCJtGA5IUgh5
 Z6YuJ9bcwW5p2xvuC9jwNzJS30nIrBNJElJs0uYeNAWwYrRuR6iRjp4kD+yrHHAqinxH
 HlaBEeMaQrzSg1sE9DRbVz7lEK9ZYqYhA0l5r8jiOUC5Deu4TZ0EzluNuO57HVKRCZpi
 BT2A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1772143391; x=1772748191;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=t1EnJk3wPeLwBeWTp7ZSpg6ulILpuVB2qbJBtvmV7es=;
 b=E4V+TKMFVZEQTRcUV+JpeC+yLCuspWF871jizWys38K/CstycN3tjDZlwpycrDtsw7
 RAZVJLJqTgEJwr19ZqygQdmR/A2GUDjcliFZnbask5Xlj+YdwNC1oUh3NGB6bTzr17oO
 L/Ak3+driO2h8j29qfN1mcsXW6rRyS4GNHh+sVbj/Z0Qwyqnmh9RCl8tv+H8aL6Q+aYq
 Qh9KFiEiOcu374RNzQIvJ9z7MtnrSHVdQJvNXs+kjP4b95sXq/WpD/w7g0hT1ens2V2K
 LZsNAozrfjqGH66J6lf7sOKm1aOR24Tb95ly0L1+gYRwlfyxVVNPtlKb6jTF9NGW7U41
 pRiA==
X-Gm-Message-State: AOJu0YyYnWu1UWoDF3ZNjXuQIGSf1kIWOK18BfCoN2OQRZG+FsZaK9fO
 fArt9q4GnwU4DMv0EFaXLrYYSLAybTrAD3itKup0SIlso32aP0viYiDq6i21sprqYUjYhkpGfMu
 KBHBvpHk=
X-Gm-Gg: ATEYQzyWKgHNHOZpEJzE4AsS5WZolVzjeKYms9UdE99PaTDwl2NvCpTNADDwn2wab27
 lD0BW2Pa+PP66iiVJWq7IdT32qiFjl2TxsA61igDUefRirNoyMEkTIBfijAjzhsWYWEyVo+NVxZ
 S7qwAU0XNfHCWLW+oaWtDqzvbZ9MBxHWMJJU5I/p3OUCZXTo84pIjqbBfqGKlSKYtPRsBxU0P2G
 pYeinejMbPSnnJs93g0wFBW+9rnEFEwThrJM4M6N9nqzkN+8R9NS2wi+tgogijnmaNeGkhMpnVl
 k8CQV+WZn0GciRpBuGRR7dAeJquzi1abTO+A7X+75BS5yvOmYrHQPWLFcA8krEvGzWwk2jMHwS7
 2DccwrDdkGR53J5FaC9dwg0jljD8dzse8i2vx8aH1MqsBYApq3UnxJaGmp2pj8919hnkAW6nEPJ
 L54HAj8bmTXkZqIVeP9F1Ft/h9WNIujfzvpty5xLhGtWaMmoEm06Q1yCVDip8eY8HDNRxdrGlP
X-Received: by 2002:a05:600c:1548:b0:480:1c10:5633 with SMTP id
 5b1f17b1804b1-483c9c1045cmr5341675e9.26.1772143391422; 
 Thu, 26 Feb 2026 14:03:11 -0800 (PST)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-483bd75df90sm174167475e9.14.2026.02.26.14.03.10
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Thu, 26 Feb 2026 14:03:10 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Richard Henderson <richard.henderson@linaro.org>,
 Mark Cave-Ayland <mark.caveayland@nutanix.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Peter Xu <peterx@redhat.com>, Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>
Subject: [PATCH 6/7] system/memory: Allow mtree_print_mr() to display distinct
 address width
Date: Thu, 26 Feb 2026 23:02:24 +0100
Message-ID: <20260226220226.20164-7-philmd@linaro.org>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260226220226.20164-1-philmd@linaro.org>
References: <20260226220226.20164-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::334;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x334.google.com
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

mtree_print_mr() display addresses using 16 chars on 64-bit
binaries, and 8 chars on 32-bit ones. Some MR / AS don't
always benefit of 16 chars, for example the ISA I/O region
fits in 16 bits, and displaying 12 extra '0' in 64-bit
binaries isn't really a good user experience.

Add an extra @width argument to mtree_print_mr(). Next
commit will make use of it.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 system/memory.c | 48 +++++++++++++++++++++++++++---------------------
 1 file changed, 27 insertions(+), 21 deletions(-)

diff --git a/system/memory.c b/system/memory.c
index 1106f48d0d5..4d276307da5 100644
--- a/system/memory.c
+++ b/system/memory.c
@@ -3321,6 +3321,7 @@ typedef QTAILQ_HEAD(, MemoryRegionList) MemoryRegionListHead;
 
 #define MR_SIZE(size) (int128_nz(size) ? (hwaddr)int128_get64( \
                            int128_sub((size), int128_one())) : 0)
+#define MR_ADDR_WIDTH   16
 #define MTREE_INDENT "  "
 
 static void mtree_expand_owner(const char *label, Object *obj)
@@ -3360,6 +3361,7 @@ static void mtree_print_mr_owner(const MemoryRegion *mr)
 }
 
 static void mtree_print_mr(const MemoryRegion *mr, unsigned int level,
+                           unsigned int width,
                            hwaddr offset, bool detect_overflow,
                            MemoryRegionListHead *alias_print_queue,
                            bool owner, bool display_disabled)
@@ -3405,17 +3407,17 @@ static void mtree_print_mr(const MemoryRegion *mr, unsigned int level,
             for (i = 0; i < level; i++) {
                 qemu_printf(MTREE_INDENT);
             }
-            qemu_printf(HWADDR_FMT_plx "-" HWADDR_FMT_plx
-                        " (prio %d, %s%s): alias %s @%s " HWADDR_FMT_plx
-                        "-" HWADDR_FMT_plx "%s",
-                        cur_start, cur_end,
+            qemu_printf("%0*" PRIx64 "-" "%0*" PRIx64
+                        " (prio %d, %s%s): alias %s @%s "
+                        "%0*" PRIx64"-" "%0*" PRIx64 "%s",
+                        width, cur_start, width, cur_end,
                         mr->priority,
                         mr->nonvolatile ? "nv-" : "",
                         memory_region_type((MemoryRegion *)mr),
                         memory_region_name(mr),
                         memory_region_name(mr->alias),
-                        mr->alias_offset,
-                        mr->alias_offset + MR_SIZE(mr->size),
+                        width, mr->alias_offset,
+                        width, mr->alias_offset + MR_SIZE(mr->size),
                         mr->enabled ? "" : " [disabled]");
             if (owner) {
                 mtree_print_mr_owner(mr);
@@ -3427,9 +3429,9 @@ static void mtree_print_mr(const MemoryRegion *mr, unsigned int level,
             for (i = 0; i < level; i++) {
                 qemu_printf(MTREE_INDENT);
             }
-            qemu_printf(HWADDR_FMT_plx "-" HWADDR_FMT_plx
+            qemu_printf("%0*" PRIx64 "-" "%0*" PRIx64
                         " (prio %d, %s%s): %s%s",
-                        cur_start, cur_end,
+                        width, cur_start, width, cur_end,
                         mr->priority,
                         mr->nonvolatile ? "nv-" : "",
                         memory_region_type((MemoryRegion *)mr),
@@ -3462,7 +3464,7 @@ static void mtree_print_mr(const MemoryRegion *mr, unsigned int level,
     }
 
     QTAILQ_FOREACH(ml, &submr_print_queue, mrqueue) {
-        mtree_print_mr(ml->mr, level + 1, cur_start, true,
+        mtree_print_mr(ml->mr, level + 1, width, cur_start, true,
                        alias_print_queue, owner, display_disabled);
     }
 
@@ -3485,6 +3487,7 @@ static void mtree_print_flatview(gpointer key, gpointer value,
     GArray *fv_address_spaces = value;
     struct FlatViewInfo *fvi = user_data;
     FlatRange *range = &view->ranges[0];
+    unsigned int width;
     int n = view->nr;
     int i;
     AddressSpace *as;
@@ -3510,26 +3513,27 @@ static void mtree_print_flatview(gpointer key, gpointer value,
         return;
     }
 
+    width = MR_ADDR_WIDTH;
     while (n--) {
         const MemoryRegion *mr = range->mr;
 
         if (range->offset_in_region) {
-            qemu_printf(MTREE_INDENT HWADDR_FMT_plx "-" HWADDR_FMT_plx
-                        " (prio %d, %s%s): %s @" HWADDR_FMT_plx,
-                        int128_get64(range->addr.start),
-                        int128_get64(range->addr.start)
-                        + MR_SIZE(range->addr.size),
+            qemu_printf(MTREE_INDENT "%0*" PRIx64 "-" "%0*" PRIx64
+                        " (prio %d, %s%s): %s @" "%0*" PRIx64,
+                        width, int128_get64(range->addr.start),
+                        width, int128_get64(range->addr.start)
+                                + MR_SIZE(range->addr.size),
                         mr->priority,
                         range->nonvolatile ? "nv-" : "",
                         range->readonly ? "rom" : memory_region_type(mr),
                         memory_region_name(mr),
-                        range->offset_in_region);
+                        width, range->offset_in_region);
         } else {
-            qemu_printf(MTREE_INDENT HWADDR_FMT_plx "-" HWADDR_FMT_plx
+            qemu_printf(MTREE_INDENT "%0*" PRIx64 "-" "%0*" PRIx64
                         " (prio %d, %s%s): %s",
-                        int128_get64(range->addr.start),
-                        int128_get64(range->addr.start)
-                        + MR_SIZE(range->addr.size),
+                        width, int128_get64(range->addr.start),
+                        width, int128_get64(range->addr.start)
+                               + MR_SIZE(range->addr.size),
                         mr->priority,
                         range->nonvolatile ? "nv-" : "",
                         range->readonly ? "rom" : memory_region_type(mr),
@@ -3639,9 +3643,10 @@ static void mtree_print_as(gpointer key, gpointer value, gpointer user_data)
     MemoryRegion *mr = key;
     GSList *as_same_root_mr_list = value;
     struct AddressSpaceInfo *asi = user_data;
+    const unsigned int width = MR_ADDR_WIDTH;
 
     g_slist_foreach(as_same_root_mr_list, mtree_print_as_name, NULL);
-    mtree_print_mr(mr, 1, -mr->addr, false,
+    mtree_print_mr(mr, 1, width, -mr->addr, false,
                    asi->ml_head, asi->owner, asi->disabled);
     qemu_printf("\n");
 }
@@ -3687,9 +3692,10 @@ static void mtree_info_as(bool dispatch_tree, bool owner, bool disabled)
     /* print aliased regions */
     QTAILQ_FOREACH(ml, &ml_head, mrqueue) {
         const MemoryRegion *mr = ml->mr;
+        const unsigned int width = MR_ADDR_WIDTH;
 
         qemu_printf("memory-region: %s\n", memory_region_name(mr));
-        mtree_print_mr(mr, 1, 0, false, &ml_head, owner, disabled);
+        mtree_print_mr(mr, 1, width, 0, false, &ml_head, owner, disabled);
         qemu_printf("\n");
     }
 
-- 
2.52.0


