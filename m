Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5CA92C021A6
	for <qemu-devel@archiver.kernel.org>; Thu, 13 Feb 2025 16:07:54 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tibfP-00018i-GH; Thu, 13 Feb 2025 11:02:19 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1tibfF-000141-Gg
 for qemu-devel@nongnu.org; Thu, 13 Feb 2025 11:02:12 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1tibfB-0005dW-Ai
 for qemu-devel@nongnu.org; Thu, 13 Feb 2025 11:02:08 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1739462523;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=wmFwjn7DirEUg9I0UDe0I1UL7FmQO7ZwjSM+vupQK5I=;
 b=dW+yrK2xClUFXl+84AyqvgwNF2qHDgmrhr5OQA9bPG+ppUcJlhIL00K0ijwe0UurulF1cl
 Flm9J/WfCzwlhVNvrzdtf3oBVgjqLvKNpwRg3kv7Kgmdb4MOruqRnqoKt/du/V8kLgt1UW
 AOX9wC02lAv7I3xgZ20bhIc6824UKXM=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-653-FxFGmBtMPOi7IluTsWwwAA-1; Thu, 13 Feb 2025 11:02:00 -0500
X-MC-Unique: FxFGmBtMPOi7IluTsWwwAA-1
X-Mimecast-MFC-AGG-ID: FxFGmBtMPOi7IluTsWwwAA
Received: by mail-wm1-f69.google.com with SMTP id
 5b1f17b1804b1-43933b8d9b1so5800975e9.3
 for <qemu-devel@nongnu.org>; Thu, 13 Feb 2025 08:02:00 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1739462519; x=1740067319;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=wmFwjn7DirEUg9I0UDe0I1UL7FmQO7ZwjSM+vupQK5I=;
 b=eq7c6rQH1q3qCdXgD1Ifbw0bnbY8dGFWwcW5B1bxVcDxQnfUmDB6AYMC4+isaw8Sng
 n/EQnlCo3bhHo9c5+k7AUNvyzRcXlSPdArQHlNPN3tY2M559C/vNkJGJGlE2xfuT02ri
 6wVTy6unzUkCg5ZRHJgUkl91h08F82DhHq4dz6Hre7k34mgeqkbU5azaqAVd+EYRV5d/
 1c+VHWxg1brPDiRUVvQDUM1lURvlKVySmglPYWagS6gDoQ3yk0T1+cE0AnHv/Hb5a+cp
 HvGBYtjJ0/DEhxLMoy6oeJ+Gyy9l7yxh2K4QNUSntS0qdF+ePNz0e8tGEnpgPIqXp9zN
 YlZw==
X-Gm-Message-State: AOJu0YwNALyFWXdZexCaH4Fl/kqqqOhFhqbvqms0cCtNmS9Ze17L7cAR
 cJ6tpA/Scv7UhYlJrZeGiOcQO83ccDWOak6kztUZ4C//iFSLv0aKNRJM6WSyshDBgHRTae7wC63
 v9ass381UQuUM2MIvN669bFoDUkJTo7IYw8SVyz7PX0bjN7dWHk1+2opxnzMyZnAZjAIedaOADc
 IoTJz8vS5DvpiwHaUPmw3n5sdR5vlCb0Ro3miZvy0=
X-Gm-Gg: ASbGncs0OG5NnF965NYY9C6s8wHykTY8qw9BFxhZlG1Lfs7mRJAGB+4Q2f9zVJ5EpwT
 9xNMO9Rx2u3yVntlQZnEC6ghzKyhkiCXJmawVG3rRs5bjn6Nd4BR77HL2t/hJQ9zV0b4t6un1wX
 cbOmP+m8sDEBBAwsArlKKXJL1v6iyhys2OujUK1sA2WjcEn50q0Hh4pzkKpvbJ8HlLc7wgoi8tV
 BQGNEYDXpowge0llGXhnrlZ0LXpeCzXDIYKnuJS4t/DuRfm9+Jk+60Tcem72DOm+JHpYEo8FZIQ
 S0v0gwchtRIORCOqaZET2bGvW/Fv3bjugSEDIL6JCMWjgg==
X-Received: by 2002:a05:600c:1d92:b0:439:5a37:815f with SMTP id
 5b1f17b1804b1-439601b92e9mr55558475e9.30.1739462518343; 
 Thu, 13 Feb 2025 08:01:58 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHEjQwvPfitfdSbmdTYVmH+Tl581LLKnhVsjw8LNp9rd0RISbqRIv1Ums3Fl8t+yp91Y9qTTw==
X-Received: by 2002:a05:600c:1d92:b0:439:5a37:815f with SMTP id
 5b1f17b1804b1-439601b92e9mr55556405e9.30.1739462516846; 
 Thu, 13 Feb 2025 08:01:56 -0800 (PST)
Received: from [192.168.126.123] (93-38-211-213.ip72.fastwebnet.it.
 [93.38.211.213]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-38f258b4123sm2320983f8f.17.2025.02.13.08.01.53
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 13 Feb 2025 08:01:54 -0800 (PST)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Cc: Zhao Liu <zhao1.liu@intel.com>
Subject: [PULL 21/27] rust/timer/hpet: add basic HPET timer and HPETState
Date: Thu, 13 Feb 2025 17:00:48 +0100
Message-ID: <20250213160054.3937012-22-pbonzini@redhat.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250213160054.3937012-1-pbonzini@redhat.com>
References: <20250213160054.3937012-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -35
X-Spam_score: -3.6
X-Spam_bar: ---
X-Spam_report: (-3.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.495,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
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

From: Zhao Liu <zhao1.liu@intel.com>

Add the HPETTimer and HPETState (HPET timer block), along with their
basic methods and register definitions.

This is in preparation for supporting the QAPI interfaces.

Note, wrap all items in HPETState that may be changed in the callback
called by C code into the BqlCell/BqlRefCell.

Signed-off-by: Zhao Liu <zhao1.liu@intel.com>
Link: https://lore.kernel.org/r/20250210030051.2562726-9-zhao1.liu@intel.com
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 rust/wrapper.h                 |   1 +
 rust/hw/timer/hpet/src/hpet.rs | 629 +++++++++++++++++++++++++++++++++
 rust/hw/timer/hpet/src/lib.rs  |   1 +
 3 files changed, 631 insertions(+)
 create mode 100644 rust/hw/timer/hpet/src/hpet.rs

diff --git a/rust/wrapper.h b/rust/wrapper.h
index a35bfbd1760..d927ad6799d 100644
--- a/rust/wrapper.h
+++ b/rust/wrapper.h
@@ -64,3 +64,4 @@ typedef enum memory_order {
 #include "chardev/char-serial.h"
 #include "exec/memattrs.h"
 #include "qemu/timer.h"
+#include "exec/address-spaces.h"
diff --git a/rust/hw/timer/hpet/src/hpet.rs b/rust/hw/timer/hpet/src/hpet.rs
new file mode 100644
index 00000000000..795610f8e88
--- /dev/null
+++ b/rust/hw/timer/hpet/src/hpet.rs
@@ -0,0 +1,629 @@
+// Copyright (C) 2024 Intel Corporation.
+// Author(s): Zhao Liu <zhai1.liu@intel.com>
+// SPDX-License-Identifier: GPL-2.0-or-later
+
+#![allow(dead_code)]
+
+use std::ptr::{addr_of_mut, null_mut, NonNull};
+
+use qemu_api::{
+    bindings::{address_space_memory, address_space_stl_le},
+    cell::{BqlCell, BqlRefCell},
+    irq::InterruptSource,
+    memory::{MemoryRegion, MEMTXATTRS_UNSPECIFIED},
+    prelude::*,
+    qom::ParentField,
+    sysbus::SysBusDevice,
+    timer::{Timer, CLOCK_VIRTUAL},
+};
+
+/// Register space for each timer block (`HPET_BASE` is defined in hpet.h).
+const HPET_REG_SPACE_LEN: u64 = 0x400; // 1024 bytes
+
+/// Minimum recommended hardware implementation.
+const HPET_MIN_TIMERS: usize = 3;
+/// Maximum timers in each timer block.
+const HPET_MAX_TIMERS: usize = 32;
+
+/// Flags that HPETState.flags supports.
+const HPET_FLAG_MSI_SUPPORT_SHIFT: usize = 0;
+
+const HPET_NUM_IRQ_ROUTES: usize = 32;
+const HPET_LEGACY_PIT_INT: u32 = 0; // HPET_LEGACY_RTC_INT isn't defined here.
+const RTC_ISA_IRQ: usize = 8;
+
+const HPET_CLK_PERIOD: u64 = 10; // 10 ns
+const FS_PER_NS: u64 = 1000000; // 1000000 femtoseconds == 1 ns
+
+/// General Capabilities and ID Register
+const HPET_CAP_REG: u64 = 0x000;
+/// Revision ID (bits 0:7). Revision 1 is implemented (refer to v1.0a spec).
+const HPET_CAP_REV_ID_VALUE: u64 = 0x1;
+const HPET_CAP_REV_ID_SHIFT: usize = 0;
+/// Number of Timers (bits 8:12)
+const HPET_CAP_NUM_TIM_SHIFT: usize = 8;
+/// Counter Size (bit 13)
+const HPET_CAP_COUNT_SIZE_CAP_SHIFT: usize = 13;
+/// Legacy Replacement Route Capable (bit 15)
+const HPET_CAP_LEG_RT_CAP_SHIFT: usize = 15;
+/// Vendor ID (bits 16:31)
+const HPET_CAP_VENDER_ID_VALUE: u64 = 0x8086;
+const HPET_CAP_VENDER_ID_SHIFT: usize = 16;
+/// Main Counter Tick Period (bits 32:63)
+const HPET_CAP_CNT_CLK_PERIOD_SHIFT: usize = 32;
+
+/// General Configuration Register
+const HPET_CFG_REG: u64 = 0x010;
+/// Overall Enable (bit 0)
+const HPET_CFG_ENABLE_SHIFT: usize = 0;
+/// Legacy Replacement Route (bit 1)
+const HPET_CFG_LEG_RT_SHIFT: usize = 1;
+/// Other bits are reserved.
+const HPET_CFG_WRITE_MASK: u64 = 0x003;
+
+/// General Interrupt Status Register
+const HPET_INT_STATUS_REG: u64 = 0x020;
+
+/// Main Counter Value Register
+const HPET_COUNTER_REG: u64 = 0x0f0;
+
+/// Timer N Configuration and Capability Register (masked by 0x18)
+const HPET_TN_CFG_REG: u64 = 0x000;
+/// bit 0, 7, and bits 16:31 are reserved.
+/// bit 4, 5, 15, and bits 32:64 are read-only.
+const HPET_TN_CFG_WRITE_MASK: u64 = 0x7f4e;
+/// Timer N Interrupt Type (bit 1)
+const HPET_TN_CFG_INT_TYPE_SHIFT: usize = 1;
+/// Timer N Interrupt Enable (bit 2)
+const HPET_TN_CFG_INT_ENABLE_SHIFT: usize = 2;
+/// Timer N Type (Periodic enabled or not, bit 3)
+const HPET_TN_CFG_PERIODIC_SHIFT: usize = 3;
+/// Timer N Periodic Interrupt Capable (support Periodic or not, bit 4)
+const HPET_TN_CFG_PERIODIC_CAP_SHIFT: usize = 4;
+/// Timer N Size (timer size is 64-bits or 32 bits, bit 5)
+const HPET_TN_CFG_SIZE_CAP_SHIFT: usize = 5;
+/// Timer N Value Set (bit 6)
+const HPET_TN_CFG_SETVAL_SHIFT: usize = 6;
+/// Timer N 32-bit Mode (bit 8)
+const HPET_TN_CFG_32BIT_SHIFT: usize = 8;
+/// Timer N Interrupt Rout (bits 9:13)
+const HPET_TN_CFG_INT_ROUTE_MASK: u64 = 0x3e00;
+const HPET_TN_CFG_INT_ROUTE_SHIFT: usize = 9;
+/// Timer N FSB Interrupt Enable (bit 14)
+const HPET_TN_CFG_FSB_ENABLE_SHIFT: usize = 14;
+/// Timer N FSB Interrupt Delivery (bit 15)
+const HPET_TN_CFG_FSB_CAP_SHIFT: usize = 15;
+/// Timer N Interrupt Routing Capability (bits 32:63)
+const HPET_TN_CFG_INT_ROUTE_CAP_SHIFT: usize = 32;
+
+/// Timer N Comparator Value Register (masked by 0x18)
+const HPET_TN_CMP_REG: u64 = 0x008;
+
+/// Timer N FSB Interrupt Route Register (masked by 0x18)
+const HPET_TN_FSB_ROUTE_REG: u64 = 0x010;
+
+const fn hpet_next_wrap(cur_tick: u64) -> u64 {
+    (cur_tick | 0xffffffff) + 1
+}
+
+const fn hpet_time_after(a: u64, b: u64) -> bool {
+    ((b - a) as i64) < 0
+}
+
+const fn ticks_to_ns(value: u64) -> u64 {
+    value * HPET_CLK_PERIOD
+}
+
+const fn ns_to_ticks(value: u64) -> u64 {
+    value / HPET_CLK_PERIOD
+}
+
+// Avoid touching the bits that cannot be written.
+const fn hpet_fixup_reg(new: u64, old: u64, mask: u64) -> u64 {
+    (new & mask) | (old & !mask)
+}
+
+const fn activating_bit(old: u64, new: u64, shift: usize) -> bool {
+    let mask: u64 = 1 << shift;
+    (old & mask == 0) && (new & mask != 0)
+}
+
+const fn deactivating_bit(old: u64, new: u64, shift: usize) -> bool {
+    let mask: u64 = 1 << shift;
+    (old & mask != 0) && (new & mask == 0)
+}
+
+fn timer_handler(timer_cell: &BqlRefCell<HPETTimer>) {
+    timer_cell.borrow_mut().callback()
+}
+
+/// HPET Timer Abstraction
+#[repr(C)]
+#[derive(Debug, Default)]
+#[cfg_attr(has_offset_of, derive(qemu_api_macros::offsets))]
+pub struct HPETTimer {
+    /// timer N index within the timer block (`HPETState`)
+    #[doc(alias = "tn")]
+    index: usize,
+    qemu_timer: Option<Box<Timer>>,
+    /// timer block abstraction containing this timer
+    state: Option<NonNull<HPETState>>,
+
+    // Memory-mapped, software visible timer registers
+    /// Timer N Configuration and Capability Register
+    config: u64,
+    /// Timer N Comparator Value Register
+    cmp: u64,
+    /// Timer N FSB Interrupt Route Register
+    fsb: u64,
+
+    // Hidden register state
+    /// comparator (extended to counter width)
+    cmp64: u64,
+    /// Last value written to comparator
+    period: u64,
+    /// timer pop will indicate wrap for one-shot 32-bit
+    /// mode. Next pop will be actual timer expiration.
+    wrap_flag: u8,
+    /// last value armed, to avoid timer storms
+    last: u64,
+}
+
+impl HPETTimer {
+    fn init(&mut self, index: usize, state_ptr: *mut HPETState) -> &mut Self {
+        *self = HPETTimer::default();
+        self.index = index;
+        self.state = NonNull::new(state_ptr);
+        self
+    }
+
+    fn init_timer_with_state(&mut self) {
+        self.qemu_timer = Some(Box::new({
+            let mut t = Timer::new();
+            t.init_full(
+                None,
+                CLOCK_VIRTUAL,
+                Timer::NS,
+                0,
+                timer_handler,
+                &self.get_state().timers[self.index],
+            );
+            t
+        }));
+    }
+
+    fn get_state(&self) -> &HPETState {
+        // SAFETY:
+        // the pointer is convertible to a reference
+        unsafe { self.state.unwrap().as_ref() }
+    }
+
+    fn is_int_active(&self) -> bool {
+        self.get_state().is_timer_int_active(self.index)
+    }
+
+    const fn is_fsb_route_enabled(&self) -> bool {
+        self.config & (1 << HPET_TN_CFG_FSB_ENABLE_SHIFT) != 0
+    }
+
+    const fn is_periodic(&self) -> bool {
+        self.config & (1 << HPET_TN_CFG_PERIODIC_SHIFT) != 0
+    }
+
+    const fn is_int_enabled(&self) -> bool {
+        self.config & (1 << HPET_TN_CFG_INT_ENABLE_SHIFT) != 0
+    }
+
+    const fn is_32bit_mod(&self) -> bool {
+        self.config & (1 << HPET_TN_CFG_32BIT_SHIFT) != 0
+    }
+
+    const fn is_valset_enabled(&self) -> bool {
+        self.config & (1 << HPET_TN_CFG_SETVAL_SHIFT) != 0
+    }
+
+    fn clear_valset(&mut self) {
+        self.config &= !(1 << HPET_TN_CFG_SETVAL_SHIFT);
+    }
+
+    /// True if timer interrupt is level triggered; otherwise, edge triggered.
+    const fn is_int_level_triggered(&self) -> bool {
+        self.config & (1 << HPET_TN_CFG_INT_TYPE_SHIFT) != 0
+    }
+
+    /// calculate next value of the general counter that matches the
+    /// target (either entirely, or the low 32-bit only depending on
+    /// the timer mode).
+    fn calculate_cmp64(&self, cur_tick: u64, target: u64) -> u64 {
+        if self.is_32bit_mod() {
+            let mut result: u64 = cur_tick.deposit(0, 32, target);
+            if result < cur_tick {
+                result += 0x100000000;
+            }
+            result
+        } else {
+            target
+        }
+    }
+
+    const fn get_individual_route(&self) -> usize {
+        ((self.config & HPET_TN_CFG_INT_ROUTE_MASK) >> HPET_TN_CFG_INT_ROUTE_SHIFT) as usize
+    }
+
+    fn get_int_route(&self) -> usize {
+        if self.index <= 1 && self.get_state().is_legacy_mode() {
+            // If LegacyReplacement Route bit is set, HPET specification requires
+            // timer0 be routed to IRQ0 in NON-APIC or IRQ2 in the I/O APIC,
+            // timer1 be routed to IRQ8 in NON-APIC or IRQ8 in the I/O APIC.
+            //
+            // If the LegacyReplacement Route bit is set, the individual routing
+            // bits for timers 0 and 1 (APIC or FSB) will have no impact.
+            //
+            // FIXME: Consider I/O APIC case.
+            if self.index == 0 {
+                0
+            } else {
+                RTC_ISA_IRQ
+            }
+        } else {
+            // (If the LegacyReplacement Route bit is set) Timer 2-n will be
+            // routed as per the routing in the timer n config registers.
+            // ...
+            // If the LegacyReplacement Route bit is not set, the individual
+            // routing bits for each of the timers are used.
+            self.get_individual_route()
+        }
+    }
+
+    fn set_irq(&mut self, set: bool) {
+        let route = self.get_int_route();
+
+        if set && self.is_int_enabled() && self.get_state().is_hpet_enabled() {
+            if self.is_fsb_route_enabled() {
+                // SAFETY:
+                // the parameters are valid.
+                unsafe {
+                    address_space_stl_le(
+                        addr_of_mut!(address_space_memory),
+                        self.fsb >> 32,  // Timer N FSB int addr
+                        self.fsb as u32, // Timer N FSB int value, truncate!
+                        MEMTXATTRS_UNSPECIFIED,
+                        null_mut(),
+                    );
+                }
+            } else if self.is_int_level_triggered() {
+                self.get_state().irqs[route].raise();
+            } else {
+                self.get_state().irqs[route].pulse();
+            }
+        } else if !self.is_fsb_route_enabled() {
+            self.get_state().irqs[route].lower();
+        }
+    }
+
+    fn update_irq(&mut self, set: bool) {
+        // If Timer N Interrupt Enable bit is 0, "the timer will
+        // still operate and generate appropriate status bits, but
+        // will not cause an interrupt"
+        self.get_state()
+            .update_int_status(self.index as u32, set && self.is_int_level_triggered());
+        self.set_irq(set);
+    }
+
+    fn arm_timer(&mut self, tick: u64) {
+        let mut ns = self.get_state().get_ns(tick);
+
+        // Clamp period to reasonable min value (1 us)
+        if self.is_periodic() && ns - self.last < 1000 {
+            ns = self.last + 1000;
+        }
+
+        self.last = ns;
+        self.qemu_timer.as_ref().unwrap().modify(self.last);
+    }
+
+    fn set_timer(&mut self) {
+        let cur_tick: u64 = self.get_state().get_ticks();
+
+        self.wrap_flag = 0;
+        self.cmp64 = self.calculate_cmp64(cur_tick, self.cmp);
+        if self.is_32bit_mod() {
+            // HPET spec says in one-shot 32-bit mode, generate an interrupt when
+            // counter wraps in addition to an interrupt with comparator match.
+            if !self.is_periodic() && self.cmp64 > hpet_next_wrap(cur_tick) {
+                self.wrap_flag = 1;
+                self.arm_timer(hpet_next_wrap(cur_tick));
+                return;
+            }
+        }
+        self.arm_timer(self.cmp64);
+    }
+
+    fn del_timer(&mut self) {
+        // Just remove the timer from the timer_list without destroying
+        // this timer instance.
+        self.qemu_timer.as_ref().unwrap().delete();
+
+        if self.is_int_active() {
+            // For level-triggered interrupt, this leaves interrupt status
+            // register set but lowers irq.
+            self.update_irq(true);
+        }
+    }
+
+    /// Configuration and Capability Register
+    fn set_tn_cfg_reg(&mut self, shift: u32, len: u32, val: u64) {
+        // TODO: Add trace point - trace_hpet_ram_write_tn_cfg(addr & 4)
+        let old_val: u64 = self.config;
+        let mut new_val: u64 = old_val.deposit(shift, len, val);
+        new_val = hpet_fixup_reg(new_val, old_val, HPET_TN_CFG_WRITE_MASK);
+
+        // Switch level-type interrupt to edge-type.
+        if deactivating_bit(old_val, new_val, HPET_TN_CFG_INT_TYPE_SHIFT) {
+            // Do this before changing timer.config; otherwise, if
+            // HPET_TN_FSB is set, update_irq will not lower the qemu_irq.
+            self.update_irq(false);
+        }
+
+        self.config = new_val;
+
+        if activating_bit(old_val, new_val, HPET_TN_CFG_INT_ENABLE_SHIFT) && self.is_int_active() {
+            self.update_irq(true);
+        }
+
+        if self.is_32bit_mod() {
+            self.cmp = u64::from(self.cmp as u32); // truncate!
+            self.period = u64::from(self.period as u32); // truncate!
+        }
+
+        if self.get_state().is_hpet_enabled() {
+            self.set_timer();
+        }
+    }
+
+    /// Comparator Value Register
+    fn set_tn_cmp_reg(&mut self, shift: u32, len: u32, val: u64) {
+        let mut length = len;
+        let mut value = val;
+
+        // TODO: Add trace point - trace_hpet_ram_write_tn_cmp(addr & 4)
+        if self.is_32bit_mod() {
+            // High 32-bits are zero, leave them untouched.
+            if shift != 0 {
+                // TODO: Add trace point - trace_hpet_ram_write_invalid_tn_cmp()
+                return;
+            }
+            length = 64;
+            value = u64::from(value as u32); // truncate!
+        }
+
+        if !self.is_periodic() || self.is_valset_enabled() {
+            self.cmp = self.cmp.deposit(shift, length, value);
+        }
+
+        if self.is_periodic() {
+            self.period = self.period.deposit(shift, length, value);
+        }
+
+        self.clear_valset();
+        if self.get_state().is_hpet_enabled() {
+            self.set_timer();
+        }
+    }
+
+    /// FSB Interrupt Route Register
+    fn set_tn_fsb_route_reg(&mut self, shift: u32, len: u32, val: u64) {
+        self.fsb = self.fsb.deposit(shift, len, val);
+    }
+
+    fn reset(&mut self) {
+        self.del_timer();
+        self.cmp = u64::MAX; // Comparator Match Registers reset to all 1's.
+        self.config = (1 << HPET_TN_CFG_PERIODIC_CAP_SHIFT) | (1 << HPET_TN_CFG_SIZE_CAP_SHIFT);
+        if self.get_state().has_msi_flag() {
+            self.config |= 1 << HPET_TN_CFG_FSB_CAP_SHIFT;
+        }
+        // advertise availability of ioapic int
+        self.config |=
+            (u64::from(self.get_state().int_route_cap)) << HPET_TN_CFG_INT_ROUTE_CAP_SHIFT;
+        self.period = 0;
+        self.wrap_flag = 0;
+    }
+
+    /// timer expiration callback
+    fn callback(&mut self) {
+        let period: u64 = self.period;
+        let cur_tick: u64 = self.get_state().get_ticks();
+
+        if self.is_periodic() && period != 0 {
+            while hpet_time_after(cur_tick, self.cmp64) {
+                self.cmp64 += period;
+            }
+            if self.is_32bit_mod() {
+                self.cmp = u64::from(self.cmp64 as u32); // truncate!
+            } else {
+                self.cmp = self.cmp64;
+            }
+            self.arm_timer(self.cmp64);
+        } else if self.wrap_flag != 0 {
+            self.wrap_flag = 0;
+            self.arm_timer(self.cmp64);
+        }
+        self.update_irq(true);
+    }
+}
+
+/// HPET Event Timer Block Abstraction
+#[repr(C)]
+#[derive(qemu_api_macros::offsets)]
+pub struct HPETState {
+    parent_obj: ParentField<SysBusDevice>,
+    iomem: MemoryRegion,
+
+    // HPET block Registers: Memory-mapped, software visible registers
+    /// General Capabilities and ID Register
+    capability: BqlCell<u64>,
+    ///  General Configuration Register
+    config: BqlCell<u64>,
+    /// General Interrupt Status Register
+    #[doc(alias = "isr")]
+    int_status: BqlCell<u64>,
+    /// Main Counter Value Register
+    #[doc(alias = "hpet_counter")]
+    counter: BqlCell<u64>,
+
+    // Internal state
+    /// Capabilities that QEMU HPET supports.
+    /// bit 0: MSI (or FSB) support.
+    flags: u32,
+
+    /// Offset of main counter relative to qemu clock.
+    hpet_offset: BqlCell<u64>,
+    hpet_offset_saved: bool,
+
+    irqs: [InterruptSource; HPET_NUM_IRQ_ROUTES],
+    rtc_irq_level: BqlCell<u32>,
+    pit_enabled: InterruptSource,
+
+    /// Interrupt Routing Capability.
+    /// This field indicates to which interrupts in the I/O (x) APIC
+    /// the timers' interrupt can be routed, and is encoded in the
+    /// bits 32:64 of timer N's config register:
+    #[doc(alias = "intcap")]
+    int_route_cap: u32,
+
+    /// HPET timer array managed by this timer block.
+    #[doc(alias = "timer")]
+    timers: [BqlRefCell<HPETTimer>; HPET_MAX_TIMERS],
+    num_timers: BqlCell<usize>,
+
+    /// Instance id (HPET timer block ID).
+    hpet_id: BqlCell<usize>,
+}
+
+impl HPETState {
+    const fn has_msi_flag(&self) -> bool {
+        self.flags & (1 << HPET_FLAG_MSI_SUPPORT_SHIFT) != 0
+    }
+
+    fn is_legacy_mode(&self) -> bool {
+        self.config.get() & (1 << HPET_CFG_LEG_RT_SHIFT) != 0
+    }
+
+    fn is_hpet_enabled(&self) -> bool {
+        self.config.get() & (1 << HPET_CFG_ENABLE_SHIFT) != 0
+    }
+
+    fn is_timer_int_active(&self, index: usize) -> bool {
+        self.int_status.get() & (1 << index) != 0
+    }
+
+    fn get_ticks(&self) -> u64 {
+        ns_to_ticks(CLOCK_VIRTUAL.get_ns() + self.hpet_offset.get())
+    }
+
+    fn get_ns(&self, tick: u64) -> u64 {
+        ticks_to_ns(tick) - self.hpet_offset.get()
+    }
+
+    fn handle_legacy_irq(&self, irq: u32, level: u32) {
+        if irq == HPET_LEGACY_PIT_INT {
+            if !self.is_legacy_mode() {
+                self.irqs[0].set(level != 0);
+            }
+        } else {
+            self.rtc_irq_level.set(level);
+            if !self.is_legacy_mode() {
+                self.irqs[RTC_ISA_IRQ].set(level != 0);
+            }
+        }
+    }
+
+    fn init_timer(&self) {
+        let raw_ptr: *mut HPETState = self as *const HPETState as *mut HPETState;
+
+        for (index, timer) in self.timers.iter().enumerate() {
+            timer
+                .borrow_mut()
+                .init(index, raw_ptr)
+                .init_timer_with_state();
+        }
+    }
+
+    fn update_int_status(&self, index: u32, level: bool) {
+        self.int_status
+            .set(self.int_status.get().deposit(index, 1, u64::from(level)));
+    }
+
+    /// General Configuration Register
+    fn set_cfg_reg(&self, shift: u32, len: u32, val: u64) {
+        let old_val = self.config.get();
+        let mut new_val = old_val.deposit(shift, len, val);
+
+        new_val = hpet_fixup_reg(new_val, old_val, HPET_CFG_WRITE_MASK);
+        self.config.set(new_val);
+
+        if activating_bit(old_val, new_val, HPET_CFG_ENABLE_SHIFT) {
+            // Enable main counter and interrupt generation.
+            self.hpet_offset
+                .set(ticks_to_ns(self.counter.get()) - CLOCK_VIRTUAL.get_ns());
+
+            for timer in self.timers.iter().take(self.num_timers.get()) {
+                let mut t = timer.borrow_mut();
+
+                if t.is_int_enabled() && t.is_int_active() {
+                    t.update_irq(true);
+                }
+                t.set_timer();
+            }
+        } else if deactivating_bit(old_val, new_val, HPET_CFG_ENABLE_SHIFT) {
+            // Halt main counter and disable interrupt generation.
+            self.counter.set(self.get_ticks());
+
+            for timer in self.timers.iter().take(self.num_timers.get()) {
+                timer.borrow_mut().del_timer();
+            }
+        }
+
+        // i8254 and RTC output pins are disabled when HPET is in legacy mode
+        if activating_bit(old_val, new_val, HPET_CFG_LEG_RT_SHIFT) {
+            self.pit_enabled.set(false);
+            self.irqs[0].lower();
+            self.irqs[RTC_ISA_IRQ].lower();
+        } else if deactivating_bit(old_val, new_val, HPET_CFG_LEG_RT_SHIFT) {
+            // TODO: Add irq binding: qemu_irq_lower(s->irqs[0])
+            self.irqs[0].lower();
+            self.pit_enabled.set(true);
+            self.irqs[RTC_ISA_IRQ].set(self.rtc_irq_level.get() != 0);
+        }
+    }
+
+    /// General Interrupt Status Register: Read/Write Clear
+    fn set_int_status_reg(&self, shift: u32, _len: u32, val: u64) {
+        let new_val = val << shift;
+        let cleared = new_val & self.int_status.get();
+
+        for (index, timer) in self.timers.iter().take(self.num_timers.get()).enumerate() {
+            if cleared & (1 << index) != 0 {
+                timer.borrow_mut().update_irq(false);
+            }
+        }
+    }
+
+    /// Main Counter Value Register
+    fn set_counter_reg(&self, shift: u32, len: u32, val: u64) {
+        if self.is_hpet_enabled() {
+            // TODO: Add trace point -
+            // trace_hpet_ram_write_counter_write_while_enabled()
+            //
+            // HPET spec says that writes to this register should only be
+            // done while the counter is halted. So this is an undefined
+            // behavior. There's no need to forbid it, but when HPET is
+            // enabled, the changed counter value will not affect the
+            // tick count (i.e., the previously calculated offset will
+            // not be changed as well).
+        }
+        self.counter
+            .set(self.counter.get().deposit(shift, len, val));
+    }
+}
diff --git a/rust/hw/timer/hpet/src/lib.rs b/rust/hw/timer/hpet/src/lib.rs
index 44e9f3fb8ab..d6ac0b2521a 100644
--- a/rust/hw/timer/hpet/src/lib.rs
+++ b/rust/hw/timer/hpet/src/lib.rs
@@ -8,3 +8,4 @@
 //! Precision Event Timers) device in QEMU.
 
 pub mod fw_cfg;
+pub mod hpet;
-- 
2.48.1


