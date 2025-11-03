Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2BEEACCF9F8
	for <qemu-devel@archiver.kernel.org>; Mon,  3 Nov 2025 10:15:10 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vFrZs-0006AQ-Cd; Mon, 03 Nov 2025 05:14:20 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vFrZr-0006A7-45
 for qemu-devel@nongnu.org; Mon, 03 Nov 2025 05:14:19 -0500
Received: from mail-wm1-x32a.google.com ([2a00:1450:4864:20::32a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vFrZl-00031G-4w
 for qemu-devel@nongnu.org; Mon, 03 Nov 2025 05:14:18 -0500
Received: by mail-wm1-x32a.google.com with SMTP id
 5b1f17b1804b1-47721293fd3so22617155e9.1
 for <qemu-devel@nongnu.org>; Mon, 03 Nov 2025 02:14:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1762164849; x=1762769649; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=hhmyK4oEIpSWjXpku9unHriewKy+XN/2ZADa1rxHLbo=;
 b=dpN9WfvGd09DT3LiiUHQce1eN+9ZRzVhXa9Y25Yb4dCVr1lwORgKAFwQznrwvOtWjo
 NOtBFu9s6oFkWDcC6Wo7FyGrL0mXWbmlAXuW0q+DZv2jH+pezuuqP25gTIXDdmaAvYYp
 UDrLYD/FYiDjT/QTNBZmxOm31BIXgjv6QzbPgpsBGPW2QAQA/Liln00IuXP18rTKPGqH
 zbBWlAQ5O0xNSqBu97QtkvDh0Y+T8lTEZrT7rSSybWE51suh2GxQ5g4jgjjZHDVxQp6j
 dqOe8gqnsUVVDh1Zo7cG1Yw3U4gafHNB/fFgo/b49I7Ic4dtEv6JlFiDFvu9qis11BNO
 u9Mg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1762164849; x=1762769649;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=hhmyK4oEIpSWjXpku9unHriewKy+XN/2ZADa1rxHLbo=;
 b=qhmvF2mp3nY2D/D1HZvpUovVLUJncPXtudBYL0ocum04xgAVY0mO3QSifW9zeQcKrn
 EGeyydqh57dWjMu7n+AbPMbomOxVsD5/etY0v8sNT+c7aG2kdP7vLb9VmwzXgnWjbH2c
 tr+sZ/OcssfFhKAmmABlIWh0o2Xozx7oYvb/VkRaPUzoYtr+/bxUQ0N9xJ/dKIFTXzJj
 tSuwb/IcJxX3VFG/9b+iaGh2x/fxZx6RcbCX9smuRuw71s3FV6EunUC5Gov6x+prCa1A
 XizYusDUJeHGAD3DSJp02QxRTZrGAYExrj+g6QUYLmQrX9ZXsJY4110hOCP6tBJFkoqq
 0hrA==
X-Gm-Message-State: AOJu0YwOOPJpR57GX5uTWt+UqViFACVQ0GC+J5+R3OUfYmngZAZJhUAe
 o0FEgnk7E/6mCBgwmJfpQrBrBQ0DYNTsivKp8Ixu1unSYFESdBruuEt0c/K4uNF5/EiKupcC523
 Jotmyayc=
X-Gm-Gg: ASbGncudbxYvFOTAxpyfhGCcCF9o82OUi4Ivm5THTbsAe0I4dX6uwpCb1xs14Zfr9Bv
 TLx+VX6+Y41+W+0LutoScF2JmSU9Ykx8K9xOQOTQoHnMrpuAIMLxDJz77GzBvjVe372oLN32RjB
 xku4T4iFOs0DHuuiijnUHfmE19fL1gfH/1awSvEVXLvjt03+MCLGWUBjvM/uq0vCRCu2Ts6IjF2
 XAwjMRzIa7MOLiXBb74ZNEiTuvazT6iuFQvABoF4WhIlN6SDT/E/IqAloIp/4pn/1ilC5j30vgW
 1GwnAks4kGFpxmh0nBdQSR/pVezeNZreIw2KRUzKBlIv4jcElcQrC0fEmwpB6+dmE85jnSSQF5j
 TS4e4aTsfNLpyjMGhEb/Wcce9wNQjexVdmSKnMM9/R6vlj2Prf/bARY5oVhuLwWifqZFHZaJVmc
 Cs/qPuX2LdaCEKjPa8o/46fWUh1bKzmjvMShXw5vaB8r2LjgahFaJCXIBmDXE=
X-Google-Smtp-Source: AGHT+IHBSr31da1TwutqIu8czWMLdsq8PZHoB7esZKvm/GO3vd2GN0EgTC9gtfSBf2Eq4K6O+eHExQ==
X-Received: by 2002:a05:600c:358f:b0:477:25c0:798c with SMTP id
 5b1f17b1804b1-47730175fcfmr133189035e9.20.1762164848706; 
 Mon, 03 Nov 2025 02:14:08 -0800 (PST)
Received: from localhost.localdomain (ip-185-104-138-122.ptr.icomera.net.
 [185.104.138.122]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4773c583d91sm147214345e9.17.2025.11.03.02.14.06
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Mon, 03 Nov 2025 02:14:07 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Roman Bolshakov <rbolshakov@ddn.com>, Alexander Graf <agraf@csgraf.de>,
 Phil Dennis-Jordan <phil@philjordan.eu>, qemu-arm@nongnu.org,
 Paolo Bonzini <pbonzini@redhat.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Richard Henderson <richard.henderson@linaro.org>,
 Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>,
 Peter Collingbourne <pcc@google.com>, Cameron Esfahani <dirty@apple.com>,
 Mads Ynddal <mads@ynddal.dk>, Mohamed Mediouni <mohamed@unpredictable.fr>
Subject: [PATCH v4 08/23] accel/hvf: Simplify hvf_set_phys_mem
Date: Mon,  3 Nov 2025 11:10:17 +0100
Message-ID: <20251103101034.59039-9-philmd@linaro.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251103101034.59039-1-philmd@linaro.org>
References: <20251103101034.59039-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32a;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x32a.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 T_SPF_TEMPERROR=0.01 autolearn=unavailable autolearn_force=no
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

From: Richard Henderson <richard.henderson@linaro.org>

All of the complicated parts of updating the address space
are handled by address_space_update_topology_pass.
Do not create or use hvf_slot structures.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 accel/hvf/hvf-all.c | 111 +++++++-------------------------------------
 1 file changed, 17 insertions(+), 94 deletions(-)

diff --git a/accel/hvf/hvf-all.c b/accel/hvf/hvf-all.c
index f203a6251f0..76b8d4d4068 100644
--- a/accel/hvf/hvf-all.c
+++ b/accel/hvf/hvf-all.c
@@ -87,45 +87,16 @@ void hvf_unprotect_dirty_range(hwaddr addr, size_t size)
                      HV_MEMORY_READ | HV_MEMORY_WRITE | HV_MEMORY_EXEC);
 }
 
-static int do_hvf_set_memory(hvf_slot *slot, hv_memory_flags_t flags)
-{
-    struct mac_slot *macslot;
-    hv_return_t ret;
-
-    macslot = &mac_slots[slot->slot_id];
-
-    if (macslot->present) {
-        if (macslot->size != slot->size) {
-            macslot->present = 0;
-            trace_hvf_vm_unmap(macslot->gpa_start, macslot->size);
-            ret = hv_vm_unmap(macslot->gpa_start, macslot->size);
-            assert_hvf_ok(ret);
-        }
-    }
-
-    if (!slot->size) {
-        return 0;
-    }
-
-    macslot->present = 1;
-    macslot->gpa_start = slot->start;
-    macslot->size = slot->size;
-    trace_hvf_vm_map(slot->start, slot->size, slot->mem, flags,
-                     flags & HV_MEMORY_READ ?  'R' : '-',
-                     flags & HV_MEMORY_WRITE ? 'W' : '-',
-                     flags & HV_MEMORY_EXEC ?  'X' : '-');
-    ret = hv_vm_map(slot->mem, slot->start, slot->size, flags);
-    assert_hvf_ok(ret);
-    return 0;
-}
-
 static void hvf_set_phys_mem(MemoryRegionSection *section, bool add)
 {
-    hvf_slot *mem;
     MemoryRegion *area = section->mr;
     bool writable = !area->readonly && !area->rom_device;
     hv_memory_flags_t flags;
     uint64_t page_size = qemu_real_host_page_size();
+    uint64_t gva = section->offset_within_address_space;
+    uint64_t size = int128_get64(section->size);
+    hv_return_t ret;
+    void *mem;
 
     if (!memory_region_is_ram(area)) {
         if (writable) {
@@ -139,69 +110,28 @@ static void hvf_set_phys_mem(MemoryRegionSection *section, bool add)
         }
     }
 
-    if (!QEMU_IS_ALIGNED(int128_get64(section->size), page_size) ||
-        !QEMU_IS_ALIGNED(section->offset_within_address_space, page_size)) {
+    if (!QEMU_IS_ALIGNED(size, page_size) ||
+        !QEMU_IS_ALIGNED(gva, page_size)) {
         /* Not page aligned, so we can not map as RAM */
         add = false;
     }
 
-    mem = hvf_find_overlap_slot(
-            section->offset_within_address_space,
-            int128_get64(section->size));
-
-    if (mem && add) {
-        if (mem->size == int128_get64(section->size) &&
-            mem->start == section->offset_within_address_space &&
-            mem->mem == (memory_region_get_ram_ptr(area) +
-            section->offset_within_region)) {
-            return; /* Same region was attempted to register, go away. */
-        }
-    }
-
-    /* Region needs to be reset. set the size to 0 and remap it. */
-    if (mem) {
-        mem->size = 0;
-        if (do_hvf_set_memory(mem, 0)) {
-            error_report("Failed to reset overlapping slot");
-            abort();
-        }
-    }
-
     if (!add) {
+        trace_hvf_vm_unmap(gva, size);
+        ret = hv_vm_unmap(gva, size);
+        assert_hvf_ok(ret);
         return;
     }
 
-    if (area->readonly ||
-        (!memory_region_is_ram(area) && memory_region_is_romd(area))) {
-        flags = HV_MEMORY_READ | HV_MEMORY_EXEC;
-    } else {
-        flags = HV_MEMORY_READ | HV_MEMORY_WRITE | HV_MEMORY_EXEC;
-    }
+    flags = HV_MEMORY_READ | HV_MEMORY_EXEC | (writable ? HV_MEMORY_WRITE : 0);
+    mem = memory_region_get_ram_ptr(area) + section->offset_within_region;
 
-    /* Now make a new slot. */
-    int x;
-
-    for (x = 0; x < hvf_state->num_slots; ++x) {
-        mem = &hvf_state->slots[x];
-        if (!mem->size) {
-            break;
-        }
-    }
-
-    if (x == hvf_state->num_slots) {
-        error_report("No free slots");
-        abort();
-    }
-
-    mem->size = int128_get64(section->size);
-    mem->mem = memory_region_get_ram_ptr(area) + section->offset_within_region;
-    mem->start = section->offset_within_address_space;
-    mem->region = area;
-
-    if (do_hvf_set_memory(mem, flags)) {
-        error_report("Error registering new memory slot");
-        abort();
-    }
+    trace_hvf_vm_map(gva, size, mem, flags,
+                     flags & HV_MEMORY_READ ?  'R' : '-',
+                     flags & HV_MEMORY_WRITE ? 'W' : '-',
+                     flags & HV_MEMORY_EXEC ?  'X' : '-');
+    ret = hv_vm_map(mem, gva, size, flags);
+    assert_hvf_ok(ret);
 }
 
 static void hvf_log_start(MemoryListener *listener,
@@ -260,7 +190,6 @@ static MemoryListener hvf_memory_listener = {
 
 static int hvf_accel_init(AccelState *as, MachineState *ms)
 {
-    int x;
     hv_return_t ret;
     HVFState *s = HVF_STATE(as);
     int pa_range = 36;
@@ -281,12 +210,6 @@ static int hvf_accel_init(AccelState *as, MachineState *ms)
     }
     assert_hvf_ok(ret);
 
-    s->num_slots = ARRAY_SIZE(s->slots);
-    for (x = 0; x < s->num_slots; ++x) {
-        s->slots[x].size = 0;
-        s->slots[x].slot_id = x;
-    }
-
     QTAILQ_INIT(&s->hvf_sw_breakpoints);
 
     hvf_state = s;
-- 
2.51.0


