Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 83B5AEA811B
	for <qemu-devel@archiver.kernel.org>; Tue, 10 Feb 2026 13:53:10 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vpoAD-00026O-Ot; Tue, 10 Feb 2026 08:52:25 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1vpoAC-00022p-Ts
 for qemu-devel@nongnu.org; Tue, 10 Feb 2026 08:52:24 -0500
Received: from mail-wm1-x333.google.com ([2a00:1450:4864:20::333])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1vpoAB-0006Lp-9S
 for qemu-devel@nongnu.org; Tue, 10 Feb 2026 08:52:24 -0500
Received: by mail-wm1-x333.google.com with SMTP id
 5b1f17b1804b1-4801c2fae63so46995605e9.2
 for <qemu-devel@nongnu.org>; Tue, 10 Feb 2026 05:52:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1770731541; x=1771336341; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=73Gszeg/ABaJHBRXvm523fWNFo3Mo1lJgEc7Wi/TY9M=;
 b=H7ZFiOXlf6v7R5KUS3avqXKuCAzCcw6qNOqoBvAGF3d6JHNw0EuIRh6zyHk2AlssPr
 zNPCyFFEbNAKfzwczRE2EDd82O+StZ4PvH2hsEv6AiTkRyi43cfDlWERwz7VDXGCxw5a
 kldNqapabjNMO3BD/0Hmw11akIo9boGfxSJuvSEF/UqbPl6k4v/uno+onNbvJl5efwY9
 MaRTCv1kK8MT+5ysdW9KAtZZgP+q/mvouAiE3MqSFR+EYN3URT4ZMZOV9pb0urc/tf11
 MLYJ1XEESRhiH4WgiD2xP/mvAAxyRn/ns/rBbEjWzwN3416GDGZVpNxlr1BZCqgOJzej
 jpmA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1770731541; x=1771336341;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=73Gszeg/ABaJHBRXvm523fWNFo3Mo1lJgEc7Wi/TY9M=;
 b=BEEdWbr741bjVePZScFCeXeY7EXqKb9iQhicI4ZjflzSmVDEfZ885+KwNZbYF9t8be
 eWkUZBT0Rn4hL4KJodIvbFxo1lwhKPuqXWdY3UPOLqb7VcqCtulf9SWVJlYGyqpqXh+u
 KnyZ6fj5ZnsmM7IwhOiphgCJY5oM3RQb6TucjeTbjCG8sd6GY/rZs5oeVNhXvX2BjkhF
 g2h7hVgvLKGCB3HBPAf7w8v93baHeEphe8+vB2i5ACJP19oUvtrtkPNP4NH0whNFqBns
 G5fcsBr0glyBlFJ/oam0qhH+x1m35qqWX7X1PzLpmmnFVTNI4UGt7wgErO+wgUT7+EIy
 bXVA==
X-Gm-Message-State: AOJu0YyCdHpGLJ6nPXXdk4G16siaFhg0nA/V31ROxZ26CuwS4q7KyPz5
 6bOwa2jD27f/zDmhk1ybDlTAr9NTipGskMY4IH1DaTwuGr8Dtm6e1FFaDjryPiMGXg0YTxHSuQN
 BJQeK
X-Gm-Gg: AZuq6aLf6QMjdzZR1TO0b9919p7U3wCXsqLNClSKxs2qVl2oOX56/jKjqJZDskrEpat
 d7WKZZLGntaPfkB3xnN/q2mZaGy9lCqNyZaZqPxWd/qS4CIsbkV+ZinvinW55k+UJ1iTVhWR4Iu
 PNOvwj1xkG0Y3oGsPZBi3sNd0iLmE4T91nebunjLGQ9t9gbUbcFjtR3iGipTk99eH3+u5sBMP+t
 0pPnFQyV6p5jn+KwoSCASd9aiJsNigPR2rsAIiO9aVgDK4SLCw4Pr31q7+BnMHKLRY4+6spkkYG
 JEWsAhseA/xEt7BQls0wU73lfVXcPKorO3IzPLl8vlwwdB+HUtlH6/0Bb518EzE41a0+zQPfcuZ
 TiOJbcMm6xQG3pH41dwBLhQdiphOHu1Nl4rBwqF/Qji08tdTZ44w4SagNoXLC7Sv08ULuP+pKHF
 QFBb9QW4iiu8YlySdFBHERkl7/QbAfLNLFyAng805SZM11XYfTGnopPPu4s8ncszH2lxbKAvSL/
 b5MpJvuqm8BdLPsmWbnt+nYQxBn+l4=
X-Received: by 2002:a05:600c:8b12:b0:480:4be7:4f53 with SMTP id
 5b1f17b1804b1-4835083392dmr35903785e9.31.1770731540462; 
 Tue, 10 Feb 2026 05:52:20 -0800 (PST)
Received: from lanath.. (wildly.archaic.org.uk. [81.2.115.145])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4834d5d77f9sm64344875e9.3.2026.02.10.05.52.19
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 10 Feb 2026 05:52:19 -0800 (PST)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 15/26] whpx: change memory management logic
Date: Tue, 10 Feb 2026 13:51:55 +0000
Message-ID: <20260210135206.229528-16-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260210135206.229528-1-peter.maydell@linaro.org>
References: <20260210135206.229528-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::333;
 envelope-from=peter.maydell@linaro.org; helo=mail-wm1-x333.google.com
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

From: Mohamed Mediouni <mohamed@unpredictable.fr>

This allows edk2 to work on Arm, although u-boot is still not functional.

Signed-off-by: Mohamed Mediouni <mohamed@unpredictable.fr>
Reviewed-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 accel/whpx/whpx-common.c | 99 +++++++++++++++-------------------------
 1 file changed, 37 insertions(+), 62 deletions(-)

diff --git a/accel/whpx/whpx-common.c b/accel/whpx/whpx-common.c
index 827f50f3e0..f018a8f5c7 100644
--- a/accel/whpx/whpx-common.c
+++ b/accel/whpx/whpx-common.c
@@ -255,89 +255,64 @@ void whpx_vcpu_kick(CPUState *cpu)
  * Memory support.
  */
 
-static void whpx_update_mapping(hwaddr start_pa, ram_addr_t size,
-                                void *host_va, int add, int rom,
-                                const char *name)
+static void whpx_set_phys_mem(MemoryRegionSection *section, bool add)
 {
     struct whpx_state *whpx = &whpx_global;
+    MemoryRegion *area = section->mr;
+    bool writable = !area->readonly && !area->rom_device;
+    WHV_MAP_GPA_RANGE_FLAGS flags;
+    uint64_t page_size = qemu_real_host_page_size();
+    uint64_t gva = section->offset_within_address_space;
+    uint64_t size = int128_get64(section->size);
     HRESULT hr;
+    void *mem;
 
-    /*
-    if (add) {
-        printf("WHPX: ADD PA:%p Size:%p, Host:%p, %s, '%s'\n",
-               (void*)start_pa, (void*)size, host_va,
-               (rom ? "ROM" : "RAM"), name);
-    } else {
-        printf("WHPX: DEL PA:%p Size:%p, Host:%p,      '%s'\n",
-               (void*)start_pa, (void*)size, host_va, name);
+    if (!memory_region_is_ram(area)) {
+        if (writable) {
+            return;
+        } else if (!memory_region_is_romd(area)) {
+            add = false;
+        }
     }
-    */
 
-    if (add) {
-        hr = whp_dispatch.WHvMapGpaRange(whpx->partition,
-                                         host_va,
-                                         start_pa,
-                                         size,
-                                         (WHvMapGpaRangeFlagRead |
-                                          WHvMapGpaRangeFlagExecute |
-                                          (rom ? 0 : WHvMapGpaRangeFlagWrite)));
-    } else {
+    if (!QEMU_IS_ALIGNED(size, page_size) ||
+        !QEMU_IS_ALIGNED(gva, page_size)) {
+        /* Not page aligned, so we can not map as RAM */
+        add = false;
+    }
+
+    if (!add) {
         hr = whp_dispatch.WHvUnmapGpaRange(whpx->partition,
-                                           start_pa,
-                                           size);
+                gva, size);
+        if (FAILED(hr)) {
+            error_report("WHPX: failed to unmap GPA range");
+            abort();
+        }
+        return;
     }
 
+    flags = WHvMapGpaRangeFlagRead | WHvMapGpaRangeFlagExecute
+     | (writable ? WHvMapGpaRangeFlagWrite : 0);
+    mem = memory_region_get_ram_ptr(area) + section->offset_within_region;
+
+    hr = whp_dispatch.WHvMapGpaRange(whpx->partition,
+         mem, gva, size, flags);
     if (FAILED(hr)) {
-        error_report("WHPX: Failed to %s GPA range '%s' PA:%p, Size:%p bytes,"
-                     " Host:%p, hr=%08lx",
-                     (add ? "MAP" : "UNMAP"), name,
-                     (void *)(uintptr_t)start_pa, (void *)size, host_va, hr);
+        error_report("WHPX: failed to map GPA range");
+        abort();
     }
 }
 
-static void whpx_process_section(MemoryRegionSection *section, int add)
-{
-    MemoryRegion *mr = section->mr;
-    hwaddr start_pa = section->offset_within_address_space;
-    ram_addr_t size = int128_get64(section->size);
-    unsigned int delta;
-    uint64_t host_va;
-
-    if (!memory_region_is_ram(mr)) {
-        return;
-    }
-
-    delta = qemu_real_host_page_size() - (start_pa & ~qemu_real_host_page_mask());
-    delta &= ~qemu_real_host_page_mask();
-    if (delta > size) {
-        return;
-    }
-    start_pa += delta;
-    size -= delta;
-    size &= qemu_real_host_page_mask();
-    if (!size || (start_pa & ~qemu_real_host_page_mask())) {
-        return;
-    }
-
-    host_va = (uintptr_t)memory_region_get_ram_ptr(mr)
-            + section->offset_within_region + delta;
-
-    whpx_update_mapping(start_pa, size, (void *)(uintptr_t)host_va, add,
-                        memory_region_is_rom(mr), mr->name);
-}
-
 static void whpx_region_add(MemoryListener *listener,
                            MemoryRegionSection *section)
 {
-    memory_region_ref(section->mr);
-    whpx_process_section(section, 1);
+    whpx_set_phys_mem(section, true);
 }
 
 static void whpx_region_del(MemoryListener *listener,
                            MemoryRegionSection *section)
 {
-    whpx_process_section(section, 0);
-    memory_region_unref(section->mr);
+    whpx_set_phys_mem(section, false);
 }
 
 static void whpx_transaction_begin(MemoryListener *listener)
-- 
2.43.0


