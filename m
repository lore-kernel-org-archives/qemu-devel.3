Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E0D3DC021A0
	for <qemu-devel@archiver.kernel.org>; Thu, 13 Feb 2025 16:10:14 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tibfM-000178-B3; Thu, 13 Feb 2025 11:02:16 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1tibfJ-00015E-20
 for qemu-devel@nongnu.org; Thu, 13 Feb 2025 11:02:13 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1tibfG-0005ed-Dd
 for qemu-devel@nongnu.org; Thu, 13 Feb 2025 11:02:12 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1739462529;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=AXSirWChTae0VbHv/LtCDoICPe1wlXJZ8L6gaZA9kvQ=;
 b=GTtyagnzIV4kxPdjXvMFqAjk1G4KE2TZFkaUBkXvuMBMuvofnn8eauFDe7kY6coB+Og7A4
 cGcaMxfdAdeKw8EzqVL38WFKO/7iA0LQfqDszFxlI+l9Y/+bIP2z2wUHxQTvEHGJfHO5tY
 92n5co5Ei1W6yR3yhb58b5SSW5FdMJs=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-619-MQnFB6lLMLOHUuYNj-toWg-1; Thu, 13 Feb 2025 11:02:05 -0500
X-MC-Unique: MQnFB6lLMLOHUuYNj-toWg-1
X-Mimecast-MFC-AGG-ID: MQnFB6lLMLOHUuYNj-toWg
Received: by mail-wm1-f71.google.com with SMTP id
 5b1f17b1804b1-439605aea5bso5745965e9.1
 for <qemu-devel@nongnu.org>; Thu, 13 Feb 2025 08:02:04 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1739462523; x=1740067323;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=AXSirWChTae0VbHv/LtCDoICPe1wlXJZ8L6gaZA9kvQ=;
 b=i1NsJoCNzNTTMq08VMJq9Mrb+0neEy3dr9dyc7z8l05T8AZHMEfDkyg7v2aPpsz963
 jPrdzFFPWcJbhUWppimuW3v8ZMHs3AY4As7js1NEFUrcDeiFB4MqH2kxWAPsZwuWNL+S
 SuPW7bTVPazREpNkLn9GqCroB5eK4vrWGOdkF2A5mdeu7nto4Hxp4DmZYO6PD78PBGC+
 SfydVfdEVTzdokaPYPT4vYC6/RBOe2XBiESejq+zvvxH0lap+vZ/ljmgTfcds6ZFUGtP
 tT1THEnZq2s31D7xsAZax48yXGUwpP1Nw45MgeoImuM8Po2vNe5q6zXiIXaiBufRiDQu
 f9GQ==
X-Gm-Message-State: AOJu0Yy8A4fl9md2sCrzyWGuEba76KWCnyfdNLejtx5eyVrkRrTnS2sS
 ty/eU5oqvibme4prrAh4EgJWfrWuCUD4IuMsCfS02IoI4uF+gn882cHgmG0R2zgeM5M4I1fHuKP
 oHbJLqiUpANsDf1re+ALclU/mmDqMZ8Cg4OfV9Ee+b5+CdJm4DxIXhoxVys1dCBCMGIt5zemRle
 7b+eCN3/5KOVPVbhsq/AgrrCP9dhuNDlsUq7TLpeA=
X-Gm-Gg: ASbGncsTD0oabNXtTbpGb1AjnYO0MtlRVV83qB4XBNYaG9E1cBC7jIpnsEiEszEI6xx
 V/RUKB6TojM5R1Ldz2Gn+r8SAHsGq+MmLRONw27mz6k6RWoBNGjsqlF1zrL7e/vkQ9Wx0UNGU+V
 t0rgc2y4J7RBhYcDm/Eif8D8VConzv4L0dIqqfR7h86ZX+yIusR7T7fDx9ZVohjVKNy35oBg9Cx
 LexIfvAldqvhm9Gil6jYGmvXckb+FFIcwi8NzNlYr0Hgyt0fKf9vqqexQEJkVH3nAA615RDJ2Sg
 HmxRvBcsXjwi9efA12SS47FqN2X3nv40aQWt4UulJhOBcw==
X-Received: by 2002:a05:600c:444d:b0:439:5529:33e0 with SMTP id
 5b1f17b1804b1-439581bf09fmr74772315e9.27.1739462520985; 
 Thu, 13 Feb 2025 08:02:00 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHy5z4A87oPWYlBQJfmcSJcYWVMoyMF4Lvtu+b8bgwzEYKYW2fgqP0WvUw1oZ86nj2SZZxeyQ==
X-Received: by 2002:a05:600c:444d:b0:439:5529:33e0 with SMTP id
 5b1f17b1804b1-439581bf09fmr74770295e9.27.1739462518680; 
 Thu, 13 Feb 2025 08:01:58 -0800 (PST)
Received: from [192.168.126.123] (93-38-211-213.ip72.fastwebnet.it.
 [93.38.211.213]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-439618a9421sm21146025e9.34.2025.02.13.08.01.57
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 13 Feb 2025 08:01:58 -0800 (PST)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Cc: Zhao Liu <zhao1.liu@intel.com>
Subject: [PULL 22/27] rust/timer/hpet: add qom and qdev APIs support
Date: Thu, 13 Feb 2025 17:00:49 +0100
Message-ID: <20250213160054.3937012-23-pbonzini@redhat.com>
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

Implement QOM & QAPI support for HPET device.

Signed-off-by: Zhao Liu <zhao1.liu@intel.com>
Link: https://lore.kernel.org/r/20250210030051.2562726-10-zhao1.liu@intel.com
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 rust/hw/timer/hpet/src/fw_cfg.rs |   2 -
 rust/hw/timer/hpet/src/hpet.rs   | 278 ++++++++++++++++++++++++++++++-
 rust/hw/timer/hpet/src/lib.rs    |   4 +
 3 files changed, 273 insertions(+), 11 deletions(-)

diff --git a/rust/hw/timer/hpet/src/fw_cfg.rs b/rust/hw/timer/hpet/src/fw_cfg.rs
index 849e277d483..bef03727ea3 100644
--- a/rust/hw/timer/hpet/src/fw_cfg.rs
+++ b/rust/hw/timer/hpet/src/fw_cfg.rs
@@ -2,8 +2,6 @@
 // Author(s): Zhao Liu <zhai1.liu@intel.com>
 // SPDX-License-Identifier: GPL-2.0-or-later
 
-#![allow(dead_code)]
-
 use std::ptr::addr_of_mut;
 
 use qemu_api::{cell::bql_locked, impl_zeroable, zeroable::Zeroable};
diff --git a/rust/hw/timer/hpet/src/hpet.rs b/rust/hw/timer/hpet/src/hpet.rs
index 795610f8e88..75ff5b3e8d6 100644
--- a/rust/hw/timer/hpet/src/hpet.rs
+++ b/rust/hw/timer/hpet/src/hpet.rs
@@ -2,21 +2,33 @@
 // Author(s): Zhao Liu <zhai1.liu@intel.com>
 // SPDX-License-Identifier: GPL-2.0-or-later
 
-#![allow(dead_code)]
-
-use std::ptr::{addr_of_mut, null_mut, NonNull};
+use std::{
+    ffi::CStr,
+    ptr::{addr_of_mut, null_mut, NonNull},
+    slice::from_ref,
+};
 
 use qemu_api::{
-    bindings::{address_space_memory, address_space_stl_le},
+    bindings::{
+        address_space_memory, address_space_stl_le, qdev_prop_bit, qdev_prop_bool,
+        qdev_prop_uint32, qdev_prop_uint8,
+    },
+    c_str,
     cell::{BqlCell, BqlRefCell},
     irq::InterruptSource,
-    memory::{MemoryRegion, MEMTXATTRS_UNSPECIFIED},
+    memory::{
+        hwaddr, MemoryRegion, MemoryRegionOps, MemoryRegionOpsBuilder, MEMTXATTRS_UNSPECIFIED,
+    },
     prelude::*,
-    qom::ParentField,
+    qdev::{DeviceImpl, DeviceMethods, DeviceState, Property, ResetType, ResettablePhasesImpl},
+    qom::{ObjectImpl, ObjectType, ParentField},
+    qom_isa,
     sysbus::SysBusDevice,
     timer::{Timer, CLOCK_VIRTUAL},
 };
 
+use crate::fw_cfg::HPETFwConfig;
+
 /// Register space for each timer block (`HPET_BASE` is defined in hpet.h).
 const HPET_REG_SPACE_LEN: u64 = 0x400; // 1024 bytes
 
@@ -139,8 +151,7 @@ fn timer_handler(timer_cell: &BqlRefCell<HPETTimer>) {
 
 /// HPET Timer Abstraction
 #[repr(C)]
-#[derive(Debug, Default)]
-#[cfg_attr(has_offset_of, derive(qemu_api_macros::offsets))]
+#[derive(Debug, Default, qemu_api_macros::offsets)]
 pub struct HPETTimer {
     /// timer N index within the timer block (`HPETState`)
     #[doc(alias = "tn")]
@@ -451,11 +462,41 @@ fn callback(&mut self) {
         }
         self.update_irq(true);
     }
+
+    const fn read(&self, addr: hwaddr, _size: u32) -> u64 {
+        let shift: u64 = (addr & 4) * 8;
+
+        match addr & !4 {
+            HPET_TN_CFG_REG => self.config >> shift, // including interrupt capabilities
+            HPET_TN_CMP_REG => self.cmp >> shift,    // comparator register
+            HPET_TN_FSB_ROUTE_REG => self.fsb >> shift,
+            _ => {
+                // TODO: Add trace point - trace_hpet_ram_read_invalid()
+                // Reserved.
+                0
+            }
+        }
+    }
+
+    fn write(&mut self, addr: hwaddr, value: u64, size: u32) {
+        let shift = ((addr & 4) * 8) as u32;
+        let len = std::cmp::min(size * 8, 64 - shift);
+
+        match addr & !4 {
+            HPET_TN_CFG_REG => self.set_tn_cfg_reg(shift, len, value),
+            HPET_TN_CMP_REG => self.set_tn_cmp_reg(shift, len, value),
+            HPET_TN_FSB_ROUTE_REG => self.set_tn_fsb_route_reg(shift, len, value),
+            _ => {
+                // TODO: Add trace point - trace_hpet_ram_write_invalid()
+                // Reserved.
+            }
+        }
+    }
 }
 
 /// HPET Event Timer Block Abstraction
 #[repr(C)]
-#[derive(qemu_api_macros::offsets)]
+#[derive(qemu_api_macros::Object, qemu_api_macros::offsets)]
 pub struct HPETState {
     parent_obj: ParentField<SysBusDevice>,
     iomem: MemoryRegion,
@@ -626,4 +667,223 @@ fn set_counter_reg(&self, shift: u32, len: u32, val: u64) {
         self.counter
             .set(self.counter.get().deposit(shift, len, val));
     }
+
+    unsafe fn init(&mut self) {
+        static HPET_RAM_OPS: MemoryRegionOps<HPETState> =
+            MemoryRegionOpsBuilder::<HPETState>::new()
+                .read(&HPETState::read)
+                .write(&HPETState::write)
+                .native_endian()
+                .valid_sizes(4, 8)
+                .impl_sizes(4, 8)
+                .build();
+
+        // SAFETY:
+        // self and self.iomem are guaranteed to be valid at this point since callers
+        // must make sure the `self` reference is valid.
+        MemoryRegion::init_io(
+            unsafe { &mut *addr_of_mut!(self.iomem) },
+            addr_of_mut!(*self),
+            &HPET_RAM_OPS,
+            "hpet",
+            HPET_REG_SPACE_LEN,
+        );
+    }
+
+    fn post_init(&self) {
+        self.init_mmio(&self.iomem);
+        for irq in self.irqs.iter() {
+            self.init_irq(irq);
+        }
+    }
+
+    fn realize(&self) {
+        if self.int_route_cap == 0 {
+            // TODO: Add error binding: warn_report()
+            println!("Hpet's hpet-intcap property not initialized");
+        }
+
+        self.hpet_id.set(HPETFwConfig::assign_hpet_id());
+
+        if self.num_timers.get() < HPET_MIN_TIMERS {
+            self.num_timers.set(HPET_MIN_TIMERS);
+        } else if self.num_timers.get() > HPET_MAX_TIMERS {
+            self.num_timers.set(HPET_MAX_TIMERS);
+        }
+
+        self.init_timer();
+        // 64-bit General Capabilities and ID Register; LegacyReplacementRoute.
+        self.capability.set(
+            HPET_CAP_REV_ID_VALUE << HPET_CAP_REV_ID_SHIFT |
+            1 << HPET_CAP_COUNT_SIZE_CAP_SHIFT |
+            1 << HPET_CAP_LEG_RT_CAP_SHIFT |
+            HPET_CAP_VENDER_ID_VALUE << HPET_CAP_VENDER_ID_SHIFT |
+            ((self.num_timers.get() - 1) as u64) << HPET_CAP_NUM_TIM_SHIFT | // indicate the last timer
+            (HPET_CLK_PERIOD * FS_PER_NS) << HPET_CAP_CNT_CLK_PERIOD_SHIFT, // 10 ns
+        );
+
+        self.init_gpio_in(2, HPETState::handle_legacy_irq);
+        self.init_gpio_out(from_ref(&self.pit_enabled));
+    }
+
+    fn reset_hold(&self, _type: ResetType) {
+        let sbd = self.upcast::<SysBusDevice>();
+
+        for timer in self.timers.iter().take(self.num_timers.get()) {
+            timer.borrow_mut().reset();
+        }
+
+        self.counter.set(0);
+        self.config.set(0);
+        self.pit_enabled.set(true);
+        self.hpet_offset.set(0);
+
+        HPETFwConfig::update_hpet_cfg(
+            self.hpet_id.get(),
+            self.capability.get() as u32,
+            sbd.mmio[0].addr,
+        );
+
+        // to document that the RTC lowers its output on reset as well
+        self.rtc_irq_level.set(0);
+    }
+
+    fn timer_and_addr(&self, addr: hwaddr) -> Option<(&BqlRefCell<HPETTimer>, hwaddr)> {
+        let timer_id: usize = ((addr - 0x100) / 0x20) as usize;
+
+        // TODO: Add trace point - trace_hpet_ram_[read|write]_timer_id(timer_id)
+        if timer_id > self.num_timers.get() {
+            // TODO: Add trace point -  trace_hpet_timer_id_out_of_range(timer_id)
+            None
+        } else {
+            // Keep the complete address so that HPETTimer's read and write could
+            // detect the invalid access.
+            Some((&self.timers[timer_id], addr & 0x1F))
+        }
+    }
+
+    fn read(&self, addr: hwaddr, size: u32) -> u64 {
+        let shift: u64 = (addr & 4) * 8;
+
+        // address range of all TN regs
+        // TODO: Add trace point - trace_hpet_ram_read(addr)
+        if (0x100..=0x3ff).contains(&addr) {
+            match self.timer_and_addr(addr) {
+                None => 0, // Reserved,
+                Some((timer, tn_addr)) => timer.borrow_mut().read(tn_addr, size),
+            }
+        } else {
+            match addr & !4 {
+                HPET_CAP_REG => self.capability.get() >> shift, /* including HPET_PERIOD 0x004 */
+                // (CNT_CLK_PERIOD field)
+                HPET_CFG_REG => self.config.get() >> shift,
+                HPET_COUNTER_REG => {
+                    let cur_tick: u64 = if self.is_hpet_enabled() {
+                        self.get_ticks()
+                    } else {
+                        self.counter.get()
+                    };
+
+                    // TODO: Add trace point - trace_hpet_ram_read_reading_counter(addr & 4,
+                    // cur_tick)
+                    cur_tick >> shift
+                }
+                HPET_INT_STATUS_REG => self.int_status.get() >> shift,
+                _ => {
+                    // TODO: Add trace point- trace_hpet_ram_read_invalid()
+                    // Reserved.
+                    0
+                }
+            }
+        }
+    }
+
+    fn write(&self, addr: hwaddr, value: u64, size: u32) {
+        let shift = ((addr & 4) * 8) as u32;
+        let len = std::cmp::min(size * 8, 64 - shift);
+
+        // TODO: Add trace point - trace_hpet_ram_write(addr, value)
+        if (0x100..=0x3ff).contains(&addr) {
+            match self.timer_and_addr(addr) {
+                None => (), // Reserved.
+                Some((timer, tn_addr)) => timer.borrow_mut().write(tn_addr, value, size),
+            }
+        } else {
+            match addr & !0x4 {
+                HPET_CAP_REG => {} // General Capabilities and ID Register: Read Only
+                HPET_CFG_REG => self.set_cfg_reg(shift, len, value),
+                HPET_INT_STATUS_REG => self.set_int_status_reg(shift, len, value),
+                HPET_COUNTER_REG => self.set_counter_reg(shift, len, value),
+                _ => {
+                    // TODO: Add trace point - trace_hpet_ram_write_invalid()
+                    // Reserved.
+                }
+            }
+        }
+    }
+}
+
+qom_isa!(HPETState: SysBusDevice, DeviceState, Object);
+
+unsafe impl ObjectType for HPETState {
+    // No need for HPETClass. Just like OBJECT_DECLARE_SIMPLE_TYPE in C.
+    type Class = <SysBusDevice as ObjectType>::Class;
+    const TYPE_NAME: &'static CStr = crate::TYPE_HPET;
+}
+
+impl ObjectImpl for HPETState {
+    type ParentType = SysBusDevice;
+
+    const INSTANCE_INIT: Option<unsafe fn(&mut Self)> = Some(Self::init);
+    const INSTANCE_POST_INIT: Option<fn(&Self)> = Some(Self::post_init);
+}
+
+// TODO: Make these properties user-configurable!
+qemu_api::declare_properties! {
+    HPET_PROPERTIES,
+    qemu_api::define_property!(
+        c_str!("timers"),
+        HPETState,
+        num_timers,
+        unsafe { &qdev_prop_uint8 },
+        u8,
+        default = HPET_MIN_TIMERS
+    ),
+    qemu_api::define_property!(
+        c_str!("msi"),
+        HPETState,
+        flags,
+        unsafe { &qdev_prop_bit },
+        u32,
+        bit = HPET_FLAG_MSI_SUPPORT_SHIFT as u8,
+        default = false,
+    ),
+    qemu_api::define_property!(
+        c_str!("hpet-intcap"),
+        HPETState,
+        int_route_cap,
+        unsafe { &qdev_prop_uint32 },
+        u32,
+        default = 0
+    ),
+    qemu_api::define_property!(
+        c_str!("hpet-offset-saved"),
+        HPETState,
+        hpet_offset_saved,
+        unsafe { &qdev_prop_bool },
+        bool,
+        default = true
+    ),
+}
+
+impl DeviceImpl for HPETState {
+    fn properties() -> &'static [Property] {
+        &HPET_PROPERTIES
+    }
+
+    const REALIZE: Option<fn(&Self)> = Some(Self::realize);
+}
+
+impl ResettablePhasesImpl for HPETState {
+    const HOLD: Option<fn(&Self, ResetType)> = Some(Self::reset_hold);
 }
diff --git a/rust/hw/timer/hpet/src/lib.rs b/rust/hw/timer/hpet/src/lib.rs
index d6ac0b2521a..5e7c961c289 100644
--- a/rust/hw/timer/hpet/src/lib.rs
+++ b/rust/hw/timer/hpet/src/lib.rs
@@ -7,5 +7,9 @@
 //! This library implements a device model for the IA-PC HPET (High
 //! Precision Event Timers) device in QEMU.
 
+use qemu_api::c_str;
+
 pub mod fw_cfg;
 pub mod hpet;
+
+pub const TYPE_HPET: &::std::ffi::CStr = c_str!("hpet");
-- 
2.48.1


