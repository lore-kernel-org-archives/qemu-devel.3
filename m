Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CAC71C3DA49
	for <qemu-devel@archiver.kernel.org>; Tue, 23 Jul 2024 14:18:33 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sWGJV-0006g7-3C; Tue, 23 Jul 2024 10:16:25 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1sWGJE-0005Ra-Ca
 for qemu-devel@nongnu.org; Tue, 23 Jul 2024 10:16:11 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1sWGJB-0007En-NV
 for qemu-devel@nongnu.org; Tue, 23 Jul 2024 10:16:07 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1721744162;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=/9Fji9Ivp6/jtBZXZ8/sCNqAbb9UXPEOh7/iIjbW6HM=;
 b=Y4BTWzbpavbnKHzFQ3FJ/p+xhCA90TxMA78noVIHj+iy88GJFW/88NUyvdl/BZqpwd/c0f
 uMUMFUSU3aIkPi9SGBCm7FfvCMt4rJ7Y1NUBVPIEBwm1V9dysvkCdgx/eLQk7WOu/qe/kY
 3hmzHfIn5thdArOMGT3CVMb9COm96/s=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-364-Ej5iiS7CNGiRNXdWpTFXQQ-1; Tue, 23 Jul 2024 10:15:58 -0400
X-MC-Unique: Ej5iiS7CNGiRNXdWpTFXQQ-1
Received: by mail-wm1-f70.google.com with SMTP id
 5b1f17b1804b1-42725d3ae3eso40985975e9.3
 for <qemu-devel@nongnu.org>; Tue, 23 Jul 2024 07:15:58 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1721744156; x=1722348956;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=/9Fji9Ivp6/jtBZXZ8/sCNqAbb9UXPEOh7/iIjbW6HM=;
 b=PwOxMWfCjoIMhkSW1jaUN/qJ9grooxhEnDSDf/krGOnveWY5QMb5d1x7TQnnh7so6J
 4l1cx6oUgFe3AVf3gl4OBq0gLwlDLrawaRodDoJs26hFsXOFhkPzcZ7mEwsk7vMDW9kH
 jIk4AO9DOfTZx9mRSQoEyObU81qYbXVEEh2SmCv7wLHwnsBG5gMZj9HNCxdr+NExhCD9
 22ULMCx5tyh7yKbs4bCr0OInonea88KiLx9+M6B0BHpAYuVv+RIebZufba9412GY097Q
 wv/M3WBDJmwFYs/aXSfuYVcyNbcQMt2jIpaqIaSlrx1GEIhCgD28WznfqIKinM0AZHey
 ld+A==
X-Gm-Message-State: AOJu0Yxy8tABDcbQWGIUGP8X90zzHioAuvpS7Gl9JyT+4P1vWvM3jr4W
 J8PfUdjmy3fZnmK7fQh37idlrMShyo5bIzI7NP0oDtO2WRfmZdCyGwZWqwZ39io1h7t3WEedfNQ
 66tS8ZVsW+WsBlo4ahh3a36RYmFCnZncO6vsDUOOG5XN+BJxhpz9VhpCMbWKvCWEhgY1lg+2gtE
 /gYCzPBFmJQxIsu0n/cplZxNfBN3UfwdyHUI/v
X-Received: by 2002:a05:600c:1914:b0:426:6314:3336 with SMTP id
 5b1f17b1804b1-427dc56801cmr55867525e9.36.1721744156566; 
 Tue, 23 Jul 2024 07:15:56 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHfkRGr/BRMHBbS/ftHFh/PWHI8R1zZJzkB1uLjtKRg29HaG9Eulfk0+hcBIfd84/c0Ol/IvQ==
X-Received: by 2002:a05:600c:1914:b0:426:6314:3336 with SMTP id
 5b1f17b1804b1-427dc56801cmr55867295e9.36.1721744155957; 
 Tue, 23 Jul 2024 07:15:55 -0700 (PDT)
Received: from avogadro.local ([151.95.101.29])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-427db2a4e3bsm142183615e9.44.2024.07.23.07.15.55
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 23 Jul 2024 07:15:55 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PULL 09/11] hpet: accept 64-bit reads and writes
Date: Tue, 23 Jul 2024 16:15:27 +0200
Message-ID: <20240723141529.551737-10-pbonzini@redhat.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20240723141529.551737-1-pbonzini@redhat.com>
References: <20240723141529.551737-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.133,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
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


