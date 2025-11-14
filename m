Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A2C73CEACC1
	for <qemu-devel@archiver.kernel.org>; Fri, 14 Nov 2025 20:09:41 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vK070-0004a1-8d; Fri, 14 Nov 2025 15:09:38 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vK030-0007PK-8A
 for qemu-devel@nongnu.org; Fri, 14 Nov 2025 15:05:34 -0500
Received: from mail-wm1-x32d.google.com ([2a00:1450:4864:20::32d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vK02y-00051p-Bp
 for qemu-devel@nongnu.org; Fri, 14 Nov 2025 15:05:29 -0500
Received: by mail-wm1-x32d.google.com with SMTP id
 5b1f17b1804b1-47758595eecso13260515e9.0
 for <qemu-devel@nongnu.org>; Fri, 14 Nov 2025 12:05:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1763150726; x=1763755526; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=LrCvW2q7zC748sZfNybE9cKpHZrZs8xKn7Qk86qnoug=;
 b=BCBKQPjuVqoSbeLeixCXXpn5h3IZoS0SqF2m4SINLTsQjKNqWXE0tulTXA+oCnNyKz
 H3aFjWmN0GFHTU8ywBH8d8zEFTd88vjZ0INt+O1shZs3CWVoMS/8BKUpK8SQO5pFgdNp
 //8WMIliEsVF3lEOn+MTgQr5QsjnGz6rJfWPl08y4iU0j3cCoMuvdDgTza02U+I/466t
 bikLTaxs7B59BHshdXqg+pyfpJ5gJyEoyiZzzF43tx0zlpNHCbMPdh9LmerWmwOrZx7h
 kAAuGrGe6d3RCtqKzkiNg4Qjif5emHdMYuA1JElL/zW7eZPCkytGyzhtrgyIxJVU4of1
 M9Bw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1763150726; x=1763755526;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=LrCvW2q7zC748sZfNybE9cKpHZrZs8xKn7Qk86qnoug=;
 b=NWvxv2NDstE9QiMlUFkokpXNn4iPLUP7rWO8p2uisyYdHCPmhXuCcNw2DQZoXiJtR6
 jJvKwI3Y2jBwrhMcqZhU8MYLKdkXsy4NRKThQ0jXKBfAf07Wsby5J2/IywO4/uf0MDc8
 wlmfEraprtSFPmVPiT3svK3GJW6Uza7yHAGgkULtcedqbVdu0u3QtOm/G0alaKOmTZ1M
 NpCTxtO1MO2GeRdz6npLBIbOjCMMM62yc+szBUPYdkqVTNXTAOja0csYkc2eQbeBn1Z8
 yelof4IWcez/vPDOA+zHNZpIcO9FCza778VPURyCtmSEJfFK5aMK9DqIh+sWSxgoo0lJ
 FKrA==
X-Gm-Message-State: AOJu0YySZCrWimykBpkh6Q+ivUpZZeuvIJqQgTR3eKqVUdg+iKOhqEGF
 u7AWGT3eGtEG6k7s0j5jIaFl5jtsz8nCjTrqhOPTyl1DqJVg2T2bDU30TQluX1Na3u0qVDt2j1p
 Cjb19ajftaA==
X-Gm-Gg: ASbGncuQ0lOgvS1c+RzNIiRS8tFXhEAb+eIFlPY8WKYMyR8GCkMK9wGVgxUT0Qs5CdZ
 MvRBGvavAwRy0KOC820tPsGonZDrWgRMuUFHi2MM0SOqZGhFzpAX+PMPb/I3cYHEVzNq9QROtM8
 KmA7vsZPW3AQbpgStGuElsDmrvEvVlfXLdbTLedHb3FVr6xSFzlbrMbkTI6qxRbRW0guV4Y/k74
 zHZhjnL38hSptIh+AgW74W3MLv4VHRBfXxjTLwUR7o0qjiNP4KqtulcHulgQ62G7FGj7T1AL+ep
 oxZl9pdhKqpvCururJk1taFU39kSzgynVEIl266ri/e5Yi13pBuDsH5RI6vgelRD++LMSaf4GuC
 fttpM63WRFyYjoZ4pSkK8uYvgAdNKJVtmKBE3assTbSpagw2lhtbkVEslcrlZJys4sbr62SiXzF
 IqBMXMeK25crtm5GCVa+w1A/oPIdN2sOqfKRP0njXZvuT59b7dPQ==
X-Google-Smtp-Source: AGHT+IHQsaThjE2qdbCDz7zwpPJ0/O1j5OI7r9+EcbTbsslvUnvm0CpbxyicAsCWwDeyxfrQ367/Qg==
X-Received: by 2002:a05:600c:c83:b0:475:de12:d3b5 with SMTP id
 5b1f17b1804b1-4778feaa58fmr43129125e9.34.1763150725894; 
 Fri, 14 Nov 2025 12:05:25 -0800 (PST)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4779525d2bcsm24719925e9.5.2025.11.14.12.05.24
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Fri, 14 Nov 2025 12:05:25 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Alexander Graf <agraf@csgraf.de>, qemu-arm@nongnu.org,
 Phil Dennis-Jordan <phil@philjordan.eu>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Peter Collingbourne <pcc@google.com>, Cameron Esfahani <dirty@apple.com>,
 Mohamed Mediouni <mohamed@unpredictable.fr>,
 Peter Maydell <peter.maydell@linaro.org>,
 Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Roman Bolshakov <rbolshakov@ddn.com>, Mads Ynddal <mads@ynddal.dk>
Subject: [PATCH v5 08/19] accel/hvf: Simplify hvf_set_phys_mem
Date: Fri, 14 Nov 2025 21:04:10 +0100
Message-ID: <20251114200422.4280-9-philmd@linaro.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251114200422.4280-1-philmd@linaro.org>
References: <20251114200422.4280-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32d;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x32d.google.com
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
v5: s/gva/gpa/ (Akihiko)
---
 accel/hvf/hvf-all.c | 111 +++++++-------------------------------------
 1 file changed, 17 insertions(+), 94 deletions(-)

diff --git a/accel/hvf/hvf-all.c b/accel/hvf/hvf-all.c
index f203a6251f0..5781b17fa4e 100644
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
+    uint64_t gpa = section->offset_within_address_space;
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
+        !QEMU_IS_ALIGNED(gpa, page_size)) {
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
+        trace_hvf_vm_unmap(gpa, size);
+        ret = hv_vm_unmap(gpa, size);
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
+    trace_hvf_vm_map(gpa, size, mem, flags,
+                     flags & HV_MEMORY_READ ?  'R' : '-',
+                     flags & HV_MEMORY_WRITE ? 'W' : '-',
+                     flags & HV_MEMORY_EXEC ?  'X' : '-');
+    ret = hv_vm_map(mem, gpa, size, flags);
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


