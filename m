Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 216FEC3DA59
	for <qemu-devel@archiver.kernel.org>; Mon, 22 Jul 2024 12:06:50 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sVrnz-0000SO-Ka; Mon, 22 Jul 2024 08:06:15 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1sVrnp-0008Ak-Sr
 for qemu-devel@nongnu.org; Mon, 22 Jul 2024 08:06:07 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1sVrnl-0007vd-5v
 for qemu-devel@nongnu.org; Mon, 22 Jul 2024 08:06:03 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1721649959;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=/9Fji9Ivp6/jtBZXZ8/sCNqAbb9UXPEOh7/iIjbW6HM=;
 b=C2v58XCxNIXw7VFXC9XZe+fpJDsPhRtBPKt/k2iWsMSYRAzisDNvysJTSUC5IeQzyP5Ayz
 G9JLPz43sRw4Sx9BEYqbW+BRGZqThJmr4uk940PFhmIadIH5qk++kbqrV37rUaJUBky0qD
 tTFMDZlnzIB7E/r1Lzquwa3bVQ9m6bM=
Received: from mail-lf1-f69.google.com (mail-lf1-f69.google.com
 [209.85.167.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-245-VsmeqFCQOqys_4dVWDIEiQ-1; Mon, 22 Jul 2024 08:05:57 -0400
X-MC-Unique: VsmeqFCQOqys_4dVWDIEiQ-1
Received: by mail-lf1-f69.google.com with SMTP id
 2adb3069b0e04-52ebdb0ef28so4846665e87.0
 for <qemu-devel@nongnu.org>; Mon, 22 Jul 2024 05:05:56 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1721649955; x=1722254755;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=/9Fji9Ivp6/jtBZXZ8/sCNqAbb9UXPEOh7/iIjbW6HM=;
 b=Nbm5EZ6RBTOs1anDY8JLEmJv0otgufOmXOusY7XhTgoKnBPWk+cmtbnw0sQxjRi0aS
 YFUQptDbCEWZxOy61R4TW5aNJGNzBwsbsuNSPxLWBhYuxfhNldHQhhXbcLj6hWun3nJX
 s5d0F978iHJmrmqNXO+be6uw502qPiadbXL32AGoPUL+HIslp1jT7QlXZLl7tqpqqQQX
 Lf1O8Zcnb+CNA5joI38ReHk2gf8Ak7EjKkiRGCHImrk/utO7IchukQbNZxvpovclDHoc
 Fxa9KQ1Z90ScEEckPXHuQ6Que+Z46RFdS+vDB1jn6RCm3Cj6a1/TsCVsnvEQckHLOhu8
 JLtQ==
X-Gm-Message-State: AOJu0YzzBUoaecTzyGiHG3hKkzL7Z5YVrHGtsJY72O/7z62GJfPAzMKt
 1XR+nPaY0yBtA3TdtbyzwO9FYxWxMSYaja4h0VbTmWu9i5Z5M80w6G3ITfi20Rft+xZuTcvmTWq
 bRJAW78E//lOM4/KSwcyftm68rZOKJdHKlgOTBc4O/NsXcjTSERf3fmzpFXK3mskn3O7LJ1nxTV
 1o5szpHRxca+oXRASGLAeO8J/Qk5N0CbxswiN3
X-Received: by 2002:a05:6512:3b82:b0:52c:df77:6507 with SMTP id
 2adb3069b0e04-52efb791e9cmr5057074e87.37.1721649955046; 
 Mon, 22 Jul 2024 05:05:55 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFaRa8ZPK2DDNMjbnfZQFg2WdV2kMfJ2emnEir8QQZf/cyGJfMVu42ohmzHQBDxxjderS1bqw==
X-Received: by 2002:a05:6512:3b82:b0:52c:df77:6507 with SMTP id
 2adb3069b0e04-52efb791e9cmr5057042e87.37.1721649954490; 
 Mon, 22 Jul 2024 05:05:54 -0700 (PDT)
Received: from avogadro.local ([151.95.101.29])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-a7a3c8be70csm415101966b.125.2024.07.22.05.05.53
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 22 Jul 2024 05:05:54 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH 5/7] hpet: accept 64-bit reads and writes
Date: Mon, 22 Jul 2024 14:05:39 +0200
Message-ID: <20240722120541.70790-6-pbonzini@redhat.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20240722120541.70790-1-pbonzini@redhat.com>
References: <20240722120541.70790-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.133,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

Declare the MemoryRegionOps so that 64-bit reads and writes to the HPET
are received directly.  This makes it possible to unify the code to
process low and high parts: for 32-bit reads, extract the desired word;
for 32-bit writes, just merge the desired part into the old value and
proceed as with a 64-bit write.

Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 hw/timer/hpet.c       | 137 +++++++++++++-----------------------------
 hw/timer/trace-events |   3 +-
 2 files changed, 44 insertions(+), 96 deletions(-)

diff --git a/hw/timer/hpet.c b/hw/timer/hpet.c
index 831e5a95b09..ac55dd1ebd6 100644
--- a/hw/timer/hpet.c
+++ b/hw/timer/hpet.c
@@ -437,6 +437,7 @@ static uint64_t hpet_ram_read(void *opaque, hwaddr addr,
                               unsigned size)
 {
     HPETState *s = opaque;
+    int shift = (addr & 4) * 8;
     uint64_t cur_tick;
 
     trace_hpet_ram_read(addr);
@@ -451,52 +452,33 @@ static uint64_t hpet_ram_read(void *opaque, hwaddr addr,
             return 0;
         }
 
-        switch ((addr - 0x100) % 0x20) {
-        case HPET_TN_CFG:
-            return timer->config;
-        case HPET_TN_CFG + 4: // Interrupt capabilities
-            return timer->config >> 32;
+        switch (addr & 0x18) {
+        case HPET_TN_CFG: // including interrupt capabilities
+            return timer->config >> shift;
         case HPET_TN_CMP: // comparator register
-            return timer->cmp;
-        case HPET_TN_CMP + 4:
-            return timer->cmp >> 32;
+            return timer->cmp >> shift;
         case HPET_TN_ROUTE:
-            return timer->fsb;
-        case HPET_TN_ROUTE + 4:
-            return timer->fsb >> 32;
+            return timer->fsb >> shift;
         default:
             trace_hpet_ram_read_invalid();
             break;
         }
     } else {
-        switch (addr) {
-        case HPET_ID:
-            return s->capability;
-        case HPET_PERIOD:
-            return s->capability >> 32;
+        switch (addr & ~4) {
+        case HPET_ID: // including HPET_PERIOD
+            return s->capability >> shift;
         case HPET_CFG:
-            return s->config;
-        case HPET_CFG + 4:
-            trace_hpet_invalid_hpet_cfg(4);
-            return 0;
+            return s->config >> shift;
         case HPET_COUNTER:
             if (hpet_enabled(s)) {
                 cur_tick = hpet_get_ticks(s);
             } else {
                 cur_tick = s->hpet_counter;
             }
-            trace_hpet_ram_read_reading_counter(0, cur_tick);
-            return cur_tick;
-        case HPET_COUNTER + 4:
-            if (hpet_enabled(s)) {
-                cur_tick = hpet_get_ticks(s);
-            } else {
-                cur_tick = s->hpet_counter;
-            }
-            trace_hpet_ram_read_reading_counter(4, cur_tick);
-            return cur_tick >> 32;
+            trace_hpet_ram_read_reading_counter(addr & 4, cur_tick);
+            return cur_tick >> shift;
         case HPET_STATUS:
-            return s->isr;
+            return s->isr >> shift;
         default:
             trace_hpet_ram_read_invalid();
             break;
@@ -510,11 +492,11 @@ static void hpet_ram_write(void *opaque, hwaddr addr,
 {
     int i;
     HPETState *s = opaque;
+    int shift = (addr & 4) * 8;
+    int len = MIN(size * 8, 64 - shift);
     uint64_t old_val, new_val, cleared;
 
     trace_hpet_ram_write(addr, value);
-    old_val = hpet_ram_read(opaque, addr, 4);
-    new_val = value;
 
     /*address range of all TN regs*/
     if (addr >= 0x100 && addr <= 0x3ff) {
@@ -526,9 +508,12 @@ static void hpet_ram_write(void *opaque, hwaddr addr,
             trace_hpet_timer_id_out_of_range(timer_id);
             return;
         }
-        switch ((addr - 0x100) % 0x20) {
+        switch (addr & 0x18) {
         case HPET_TN_CFG:
-            trace_hpet_ram_write_tn_cfg();
+            trace_hpet_ram_write_tn_cfg(addr & 4);
+            old_val = timer->config;
+            new_val = deposit64(old_val, shift, len, value);
+            new_val = hpet_fixup_reg(new_val, old_val, HPET_TN_CFG_WRITE_MASK);
             if (deactivating_bit(old_val, new_val, HPET_TN_TYPE_LEVEL)) {
                 /*
                  * Do this before changing timer->config; otherwise, if
@@ -536,8 +521,7 @@ static void hpet_ram_write(void *opaque, hwaddr addr,
                  */
                 update_irq(timer, 0);
             }
-            new_val = hpet_fixup_reg(new_val, old_val, HPET_TN_CFG_WRITE_MASK);
-            timer->config = (timer->config & 0xffffffff00000000ULL) | new_val;
+            timer->config = new_val;
             if (activating_bit(old_val, new_val, HPET_TN_ENABLE)
                 && (s->isr & (1 << timer_id))) {
                 update_irq(timer, 1);
@@ -550,56 +534,28 @@ static void hpet_ram_write(void *opaque, hwaddr addr,
                 hpet_set_timer(timer);
             }
             break;
-        case HPET_TN_CFG + 4: // Interrupt capabilities
-            trace_hpet_ram_write_invalid_tn_cfg(4);
-            break;
         case HPET_TN_CMP: // comparator register
-            trace_hpet_ram_write_tn_cmp(0);
             if (timer->config & HPET_TN_32BIT) {
-                new_val = (uint32_t)new_val;
-            }
-            if (!timer_is_periodic(timer)
-                || (timer->config & HPET_TN_SETVAL)) {
-                timer->cmp = (timer->cmp & 0xffffffff00000000ULL) | new_val;
-            }
-            if (timer_is_periodic(timer)) {
-                /*
-                 * FIXME: Clamp period to reasonable min value?
-                 * Clamp period to reasonable max value
-                 */
-                if (timer->config & HPET_TN_32BIT) {
-                    new_val = MIN(new_val, ~0u >> 1);
+                /* High 32-bits are zero, leave them untouched.  */
+                if (shift) {
+                    trace_hpet_ram_write_invalid_tn_cmp();
+                    break;
                 }
-                timer->period =
-                    (timer->period & 0xffffffff00000000ULL) | new_val;
+                len = 64;
+                value = (uint32_t) value;
             }
-            /*
-             * FIXME: on a 64-bit write, HPET_TN_SETVAL should apply to the
-             * high bits part as well.
-             */
-            timer->config &= ~HPET_TN_SETVAL;
-            if (hpet_enabled(s)) {
-                hpet_set_timer(timer);
-            }
-            break;
-        case HPET_TN_CMP + 4: // comparator register high order
-            if (timer->config & HPET_TN_32BIT) {
-                trace_hpet_ram_write_invalid_tn_cmp();
-                break;
-            }
-            trace_hpet_ram_write_tn_cmp(4);
+            trace_hpet_ram_write_tn_cmp(addr & 4);
             if (!timer_is_periodic(timer)
                 || (timer->config & HPET_TN_SETVAL)) {
-                timer->cmp = (timer->cmp & 0xffffffffULL) | new_val << 32;
+                timer->cmp = deposit64(timer->cmp, shift, len, value);
             }
             if (timer_is_periodic(timer)) {
                 /*
                  * FIXME: Clamp period to reasonable min value?
                  * Clamp period to reasonable max value
                  */
-                new_val = MIN(new_val, ~0u >> 1);
-                timer->period =
-                    (timer->period & 0xffffffffULL) | new_val << 32;
+                new_val = deposit64(timer->period, shift, len, value);
+                timer->period = MIN(new_val, (timer->config & HPET_TN_32BIT ? ~0u : ~0ull) >> 1);
             }
             timer->config &= ~HPET_TN_SETVAL;
             if (hpet_enabled(s)) {
@@ -607,10 +563,7 @@ static void hpet_ram_write(void *opaque, hwaddr addr,
             }
             break;
         case HPET_TN_ROUTE:
-            timer->fsb = (timer->fsb & 0xffffffff00000000ULL) | new_val;
-            break;
-        case HPET_TN_ROUTE + 4:
-            timer->fsb = (new_val << 32) | (timer->fsb & 0xffffffff);
+            timer->fsb = deposit64(timer->fsb, shift, len, value);
             break;
         default:
             trace_hpet_ram_write_invalid();
@@ -618,12 +571,14 @@ static void hpet_ram_write(void *opaque, hwaddr addr,
         }
         return;
     } else {
-        switch (addr) {
+        switch (addr & ~4) {
         case HPET_ID:
             return;
         case HPET_CFG:
+            old_val = s->config;
+            new_val = deposit64(old_val, shift, len, value);
             new_val = hpet_fixup_reg(new_val, old_val, HPET_CFG_WRITE_MASK);
-            s->config = (s->config & 0xffffffff00000000ULL) | new_val;
+            s->config = new_val;
             if (activating_bit(old_val, new_val, HPET_CFG_ENABLE)) {
                 /* Enable main counter and interrupt generation. */
                 s->hpet_offset =
@@ -653,10 +608,8 @@ static void hpet_ram_write(void *opaque, hwaddr addr,
                 qemu_set_irq(s->irqs[RTC_ISA_IRQ], s->rtc_irq_level);
             }
             break;
-        case HPET_CFG + 4:
-            trace_hpet_invalid_hpet_cfg(4);
-            break;
         case HPET_STATUS:
+            new_val = value << shift;
             cleared = new_val & s->isr;
             for (i = 0; i < s->num_timers; i++) {
                 if (cleared & (1 << i)) {
@@ -668,15 +621,7 @@ static void hpet_ram_write(void *opaque, hwaddr addr,
             if (hpet_enabled(s)) {
                 trace_hpet_ram_write_counter_write_while_enabled();
             }
-            s->hpet_counter =
-                (s->hpet_counter & 0xffffffff00000000ULL) | value;
-            trace_hpet_ram_write_counter_written(0, value, s->hpet_counter);
-            break;
-        case HPET_COUNTER + 4:
-            trace_hpet_ram_write_counter_write_while_enabled();
-            s->hpet_counter =
-                (s->hpet_counter & 0xffffffffULL) | (((uint64_t)value) << 32);
-            trace_hpet_ram_write_counter_written(4, value, s->hpet_counter);
+            s->hpet_counter = deposit64(s->hpet_counter, shift, len, value);
             break;
         default:
             trace_hpet_ram_write_invalid();
@@ -690,7 +635,11 @@ static const MemoryRegionOps hpet_ram_ops = {
     .write = hpet_ram_write,
     .valid = {
         .min_access_size = 4,
-        .max_access_size = 4,
+        .max_access_size = 8,
+    },
+    .impl = {
+        .min_access_size = 4,
+        .max_access_size = 8,
     },
     .endianness = DEVICE_NATIVE_ENDIAN,
 };
diff --git a/hw/timer/trace-events b/hw/timer/trace-events
index a5fafbc6796..f48a712801e 100644
--- a/hw/timer/trace-events
+++ b/hw/timer/trace-events
@@ -108,8 +108,7 @@ hpet_ram_read_reading_counter(uint8_t reg_off, uint64_t cur_tick) "reading count
 hpet_ram_read_invalid(void) "invalid hpet_ram_readl"
 hpet_ram_write(uint64_t addr, uint64_t value) "enter hpet_ram_writel at 0x%" PRIx64 " = 0x%" PRIx64
 hpet_ram_write_timer_id(uint64_t timer_id) "hpet_ram_writel timer_id = 0x%" PRIx64
-hpet_ram_write_tn_cfg(void) "hpet_ram_writel HPET_TN_CFG"
-hpet_ram_write_invalid_tn_cfg(uint8_t reg_off) "invalid HPET_TN_CFG + %" PRIu8 " write"
+hpet_ram_write_tn_cfg(uint8_t reg_off) "hpet_ram_writel HPET_TN_CFG + %" PRIu8
 hpet_ram_write_tn_cmp(uint8_t reg_off) "hpet_ram_writel HPET_TN_CMP + %" PRIu8
 hpet_ram_write_invalid_tn_cmp(void) "invalid HPET_TN_CMP + 4 write"
 hpet_ram_write_invalid(void) "invalid hpet_ram_writel"
-- 
2.45.2


