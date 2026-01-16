Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 052C7D48981
	for <qemu-devel@archiver.kernel.org>; Fri, 16 Jan 2026 11:20:02 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vghrg-0001JJ-Sn; Fri, 16 Jan 2026 06:19:40 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vghrf-0001HY-Mj
 for qemu-devel@nongnu.org; Fri, 16 Jan 2026 06:19:39 -0500
Received: from mail-wm1-x335.google.com ([2a00:1450:4864:20::335])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vghre-0006GH-2f
 for qemu-devel@nongnu.org; Fri, 16 Jan 2026 06:19:39 -0500
Received: by mail-wm1-x335.google.com with SMTP id
 5b1f17b1804b1-47ee76e8656so22846185e9.0
 for <qemu-devel@nongnu.org>; Fri, 16 Jan 2026 03:19:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1768562376; x=1769167176; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=OyfPLIv6CoMr8kyKBxR+dLvug2cD6tJc7HIr84MLnZ8=;
 b=iWyK1zNSc+49yZ6k1gm2W/9Dfd+yyz//e34t6Pn0lmDRQIaE1GHjKL561FuMk+kebN
 9lwUAkc6tY34GbKxphSiZLZS+jkzBYNXKhwoG+jnmw/Ef2sgRMGnOD6NQ2AN1dwbzpGu
 hxuMEw0FFruYSJ5mKbsn6FzhuwndfWblliGrQJpCl2gEOq92HqHqxxF0uE2Cl2H0bT9n
 iqpv0I+fA2RYVp1Dpf9NslTp/0skzaQ9sqPHXZauXOKaZYN4KRvh/qC4FjWu2NIscbxh
 T5Cdx6D//hRCccaJWMRmfAh39eWVdZiXNMKs5wW9ZyzEUMzMZu/aAMl4MiFy4T1FmeU4
 2XlQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1768562376; x=1769167176;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=OyfPLIv6CoMr8kyKBxR+dLvug2cD6tJc7HIr84MLnZ8=;
 b=R6khLVbBh24nYYB3sMeifX2P6RtchzEQh3OwK2+5gctScDeCghH39YebrvIF61Sjfc
 yI6r2jDBs5A5q9dKaZN+3vNUgj6DDcNjCh+xvORiNjTfAQ/ys2t7YviZAu3AEX9VNSqw
 4EL0r2ocPZTjPgCljGegQR2DLu9rf/A1iOHzsnhf3kF4nYv/3zTN0nYqgB2O2rk70xdM
 oOUpYK+aUSuKY7qzEAmg4cgbdETThgrVKqCd8juhnOBeh2NeS0AVF8ueQRjeF1U7WeVm
 V4da3SHZyYSnBmUyYZRxpI7OWY2gm8nInHY5TGjWni8VRvU+Juxs/4AOmBYKQsIK46Wy
 dz0w==
X-Gm-Message-State: AOJu0YzJ1VkAhqVUvqzvWhtxHrue6sjRK2xwEOVjztmx5rKDbDlfxDne
 tYCFDWveUVhF4HPZhirtv5OgKKpBeZQVz8tspDfe8kj0DjCoFaS0LK+kv8WLB5URYZkCNxP9c2w
 3iJ+tncA=
X-Gm-Gg: AY/fxX6uHDoJgClaKLD7iq+7NDQ5pqsdkKuaxQASMpXMHGIX+fmns3XxWxa881k08V5
 2Bs3HEp4dObEv3S1cnBmY51aLf+jkCO+79eOKrJdZ3EN8ZYPi/Cba2WDgG7voOelSOAFaOEPtll
 NjHZIgKLvaVleCGGV0qPA/LEhPFuQ9eiwaBERTInfJVSKevPG+kxdmAxpimZkVC0pH8PVKQ+Xnm
 kmZxsjN/wnfqV70u4AKtJuHzPBIOyq9aL8VMAuk4+88IsOeo+gTE7c9ZBaynqVCNaOkFKJcTPCa
 m50SP4EBgIEk+HV004demuWHSZNOu/mIcdM4mJ0GmQNU7bSDo+9Lu99QfqKRJ476omzQz+hKgTn
 IQUU+flh+lTtJ7d2Q89R6ywyzLnQ3mlJ8dSG/7Tdvt8oGEXBW4hCM+SvQtwb5m0VUCViFQmH75b
 GU0X7amPCn8bOvqVAkHM/JbtUzaGAsjJp7YLZI0+Cxzt0RYkIck9VCZkniM3tjV47FAwoSN84=
X-Received: by 2002:a05:600c:3495:b0:479:1348:c614 with SMTP id
 5b1f17b1804b1-4801e34343cmr33901785e9.26.1768562376069; 
 Fri, 16 Jan 2026 03:19:36 -0800 (PST)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-47f4289b83csm94187775e9.3.2026.01.16.03.19.35
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Fri, 16 Jan 2026 03:19:35 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 13/30] accel/hvf: Simplify hvf_log_*
Date: Fri, 16 Jan 2026 12:17:50 +0100
Message-ID: <20260116111807.36053-14-philmd@linaro.org>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260116111807.36053-1-philmd@linaro.org>
References: <20260116111807.36053-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::335;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x335.google.com
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

From: Richard Henderson <richard.henderson@linaro.org>

Rely on the AddressSpace and MemoryRegion structures
rather than hvf_slot.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
Tested-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>
Message-ID: <20260112103034.65310-7-philmd@linaro.org>
---
 include/system/hvf_int.h |  3 ---
 accel/hvf/hvf-all.c      | 40 ++++++++++------------------------------
 2 files changed, 10 insertions(+), 33 deletions(-)

diff --git a/include/system/hvf_int.h b/include/system/hvf_int.h
index 5a57691885f..ee7ab689f45 100644
--- a/include/system/hvf_int.h
+++ b/include/system/hvf_int.h
@@ -24,9 +24,6 @@ typedef hv_vcpu_t hvf_vcpuid;
 typedef hv_vcpuid_t hvf_vcpuid;
 #endif
 
-/* hvf_slot flags */
-#define HVF_SLOT_LOG (1 << 0)
-
 typedef struct hvf_slot {
     uint64_t start;
     uint64_t size;
diff --git a/accel/hvf/hvf-all.c b/accel/hvf/hvf-all.c
index 96ed79108a6..bbb0403d246 100644
--- a/accel/hvf/hvf-all.c
+++ b/accel/hvf/hvf-all.c
@@ -204,45 +204,24 @@ static void hvf_set_phys_mem(MemoryRegionSection *section, bool add)
     }
 }
 
-static void hvf_set_dirty_tracking(MemoryRegionSection *section, bool on)
-{
-    hvf_slot *slot;
-
-    slot = hvf_find_overlap_slot(
-            section->offset_within_address_space,
-            int128_get64(section->size));
-
-    /* protect region against writes; begin tracking it */
-    if (on) {
-        slot->flags |= HVF_SLOT_LOG;
-        hv_vm_protect((uintptr_t)slot->start, (size_t)slot->size,
-                      HV_MEMORY_READ | HV_MEMORY_EXEC);
-    /* stop tracking region*/
-    } else {
-        slot->flags &= ~HVF_SLOT_LOG;
-        hv_vm_protect((uintptr_t)slot->start, (size_t)slot->size,
-                      HV_MEMORY_READ | HV_MEMORY_WRITE | HV_MEMORY_EXEC);
-    }
-}
-
 static void hvf_log_start(MemoryListener *listener,
                           MemoryRegionSection *section, int old, int new)
 {
-    if (old != 0) {
-        return;
+    assert(new != 0);
+    if (old == 0) {
+        hvf_protect_clean_range(section->offset_within_address_space,
+                                int128_get64(section->size));
     }
-
-    hvf_set_dirty_tracking(section, 1);
 }
 
 static void hvf_log_stop(MemoryListener *listener,
                          MemoryRegionSection *section, int old, int new)
 {
-    if (new != 0) {
-        return;
+    assert(old != 0);
+    if (new == 0) {
+        hvf_unprotect_dirty_range(section->offset_within_address_space,
+                                  int128_get64(section->size));
     }
-
-    hvf_set_dirty_tracking(section, 0);
 }
 
 static void hvf_log_sync(MemoryListener *listener,
@@ -252,7 +231,8 @@ static void hvf_log_sync(MemoryListener *listener,
      * sync of dirty pages is handled elsewhere; just make sure we keep
      * tracking the region.
      */
-    hvf_set_dirty_tracking(section, 1);
+    hvf_protect_clean_range(section->offset_within_address_space,
+                            int128_get64(section->size));
 }
 
 static void hvf_region_add(MemoryListener *listener,
-- 
2.52.0


