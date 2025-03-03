Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9E78FC282CD
	for <qemu-devel@archiver.kernel.org>; Mon,  3 Mar 2025 15:59:45 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tp8CO-0004RF-Kf; Mon, 03 Mar 2025 10:59:20 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1tp8CL-0004Py-Pd
 for qemu-devel@nongnu.org; Mon, 03 Mar 2025 10:59:18 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1tp8CH-0001Kn-Sq
 for qemu-devel@nongnu.org; Mon, 03 Mar 2025 10:59:17 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1741017552;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=0giVfc+ZNnv7QJz1p/HeTF37RkNRtkcZUpFCbkrpntc=;
 b=bDYMlhTc3xbeMDN8P61knXOI0HR4AXCgU/Q4gRaPh7t6bqJV/8JcoDdF9PBIql9BSrcuOh
 PEikKDmHP+vR35AZGVNcjlSFXLQRPgnWhL+tqmKNzqDJj+s6DURSRC9hWQjuMEV5b/B6pL
 xerEmTgPlYevljOp5emgwUJ2mzkBHOU=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-441-_ZgLtEVRML21lYFp5oaI6Q-1; Mon, 03 Mar 2025 10:59:01 -0500
X-MC-Unique: _ZgLtEVRML21lYFp5oaI6Q-1
X-Mimecast-MFC-AGG-ID: _ZgLtEVRML21lYFp5oaI6Q_1741017540
Received: by mail-wm1-f71.google.com with SMTP id
 5b1f17b1804b1-43bca561111so725085e9.3
 for <qemu-devel@nongnu.org>; Mon, 03 Mar 2025 07:59:01 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1741017540; x=1741622340;
 h=content-transfer-encoding:in-reply-to:autocrypt:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=0giVfc+ZNnv7QJz1p/HeTF37RkNRtkcZUpFCbkrpntc=;
 b=gT664MzulxPZSBM1g88EZr2iLO5VETUMfBckyk3KQxdpULWuwMF5ae80Z6CVMQikbA
 Wl1bnD1lY0St5YCL/LnOA2QxiIQkLxwItdnv8O7px+tHUsGrqHaj6XWlztysuqO5SBzj
 2kuMUdYr7zT2Ff5fR9Cm1bsXvfMwkBxIT2RvY9e4KumkoiDgzekzbxgi6cO+apt8xvLC
 vqkcOwVT12cHFZgavv/jSiCIP0yDE7tOvEX0XoHzS43hshTNOvhtsXypTC8t72oVxO3S
 aB+q5z+3x79q0I5gL27fdqGz9+WKIWTtWoZ3Oy63j6Q4xMuZrdhYRL4TZRcm5zc8IolD
 NPYQ==
X-Gm-Message-State: AOJu0Ywx94XGf/PvB1uPHAc650iOgEVZGFOLY106jXI7dwgXctRl7qYy
 WXZuHd2WuSUpOZM/xMk4iG2WbqovfRXM3lvojPtCEY7CDl/Hccz7O8NgsZOFwuEDhxaqyUSSdni
 gAuQMt+0NSFxmcL7OJTQ6bWc7WLrY5xvcb1HQROs0UVWKqlqGpFoKfgJMW9Chmr8=
X-Gm-Gg: ASbGncvp/G2pBqqIEHirzFMeGtQIcKskn8L1RROpP8R3rchUXHxdrchAahIAiGGpnqH
 yUT0x3YTvb2qimcSd/CD85tnPe1AxCiyG6Q2ZEFeBjUqu+87X0Rt6xmFdypYpVpFMz+h1QjIs8u
 pv+91SOCXmiNSxlanMwLK1J3dfWexM9YqpJJOA93yqJU4zXHZIlisn6MaeuNu9x4D+bu1JYAPEq
 4ZXAvzlWkQUsivIYOGrtrMlAZ3Wiq3RyMzL8r2GSHihA8jdnPk8dEqKHQkN5Ou4iH0OBNYGNvzL
 +oRXSEU1lYplPubej1o=
X-Received: by 2002:a05:600c:4706:b0:43b:c878:144c with SMTP id
 5b1f17b1804b1-43bc87815d8mr18899135e9.12.1741017539659; 
 Mon, 03 Mar 2025 07:58:59 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGOm20lvmKU3oPR5zZ5npqqcdGR9mfFaZbsa/W6AqBWV1uDiPGVcFZWnyfXgcFJC3KQjUM50w==
X-Received: by 2002:a05:600c:4706:b0:43b:c878:144c with SMTP id
 5b1f17b1804b1-43bc87815d8mr18898495e9.12.1741017538282; 
 Mon, 03 Mar 2025 07:58:58 -0800 (PST)
Received: from [192.168.10.27] ([151.95.119.44])
 by smtp.googlemail.com with ESMTPSA id
 5b1f17b1804b1-43b8d6bc3fcsm132944215e9.0.2025.03.03.07.58.57
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 03 Mar 2025 07:58:57 -0800 (PST)
Message-ID: <7b09b4e3-3c1f-4c94-ad3a-054eaf74f24c@redhat.com>
Date: Mon, 3 Mar 2025 16:58:57 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 04/12] rust: timer: wrap QEMUTimer with Opaque<> and
 express pinning requirements
To: Zhao Liu <zhao1.liu@intel.com>
Cc: qemu-devel@nongnu.org, qemu-rust@nongnu.org
References: <20250227142219.812270-1-pbonzini@redhat.com>
 <20250227142219.812270-5-pbonzini@redhat.com> <Z8WzRyPbt6d7CHWM@intel.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Content-Language: en-US
Autocrypt: addr=pbonzini@redhat.com; keydata=
 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
In-Reply-To: <Z8WzRyPbt6d7CHWM@intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -30
X-Spam_score: -3.1
X-Spam_bar: ---
X-Spam_report: (-3.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=-1, RCVD_IN_MSPIKE_WL=-0.01,
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

On 3/3/25 14:48, Zhao Liu wrote:
>> @@ -156,7 +157,7 @@ pub struct HPETTimer {
>>       /// timer N index within the timer block (`HPETState`)
>>       #[doc(alias = "tn")]
>>       index: usize,
>> -    qemu_timer: Option<Box<Timer>>,
>> +    qemu_timer: Option<Pin<Box<Timer>>>,
> 
> I'm removing this Option<> wrapper in migration series. This is because
> Option<> can't be treated as pointer as you mentioned in [*].
> 
> So for this reason, does this mean that VMStateField cannot accept
> Option<>? I realize that all the current VMStateFlags don't seem
> compatible with Option<> unless a new flag is introduced.
> 
> [*]: https://lore.kernel.org/qemu-devel/9a0389fa-765c-443b-ac2f-7c99ed862982@redhat.com/

Ok, so let's get rid of the option.  I didn't really like it anyway...

If the Timer is embedded in the HPETTimer, there needs to be some
"unsafe" in order to make sure that the pinning is observed, and also
because an uninitialized Timer is bad and can cause a NULL pointer
dereference in modify()... i.e. Timer shouldn't have implemented
Default!

However, the lifetime checks in init_full() are preserved, so overall
this is better---at least for now.  Linux also had unsafe initialization
for quite some time, so I'm okay with it.

The replacements for this patch are below.

Paolo



 From 2d74bdf176b2fbeb6205396d0021f68a9e72bde1 Mon Sep 17 00:00:00 2001
From: Paolo Bonzini <pbonzini@redhat.com>
Date: Mon, 3 Mar 2025 16:27:08 +0100
Subject: [PATCH 1/2] rust: hpet: embed Timer without the Option and Box
  indirection

This simplifies things for migration, since Option<Box<QEMUTimer>> does not
implement VMState.

This also shows a soundness issue because Timer::new() will leave a NULL
timer list pointer, which can then be dereferenced by Timer::modify().  It
will be fixed shortly.

Suggested-by: Zhao Liu <zhao1.liu@intel.com>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
  rust/hw/timer/hpet/src/hpet.rs | 59 ++++++++++++++++------------------
  1 file changed, 28 insertions(+), 31 deletions(-)

diff --git a/rust/hw/timer/hpet/src/hpet.rs b/rust/hw/timer/hpet/src/hpet.rs
index be27eb0eff4..02c81ae048f 100644
--- a/rust/hw/timer/hpet/src/hpet.rs
+++ b/rust/hw/timer/hpet/src/hpet.rs
@@ -151,14 +151,14 @@ fn timer_handler(timer_cell: &BqlRefCell<HPETTimer>) {
  
  /// HPET Timer Abstraction
  #[repr(C)]
-#[derive(Debug, Default, qemu_api_macros::offsets)]
+#[derive(Debug, qemu_api_macros::offsets)]
  pub struct HPETTimer {
      /// timer N index within the timer block (`HPETState`)
      #[doc(alias = "tn")]
      index: usize,
-    qemu_timer: Option<Box<Timer>>,
+    qemu_timer: Timer,
      /// timer block abstraction containing this timer
-    state: Option<NonNull<HPETState>>,
+    state: NonNull<HPETState>,
  
      // Memory-mapped, software visible timer registers
      /// Timer N Configuration and Capability Register
@@ -181,32 +181,34 @@ pub struct HPETTimer {
  }
  
  impl HPETTimer {
-    fn init(&mut self, index: usize, state_ptr: *mut HPETState) -> &mut Self {
-        *self = HPETTimer::default();
-        self.index = index;
-        self.state = NonNull::new(state_ptr);
-        self
-    }
+    fn init(&mut self, index: usize, state: &HPETState) {
+        *self = HPETTimer {
+            index,
+            qemu_timer: Timer::new(),
+            state: NonNull::new(state as *const _ as *mut _).unwrap(),
+            config: 0,
+            cmp: 0,
+            fsb: 0,
+            cmp64: 0,
+            period: 0,
+            wrap_flag: 0,
+            last: 0,
+        };
  
-    fn init_timer_with_state(&mut self) {
-        self.qemu_timer = Some(Box::new({
-            let mut t = Timer::new();
-            t.init_full(
-                None,
-                CLOCK_VIRTUAL,
-                Timer::NS,
-                0,
-                timer_handler,
-                &self.get_state().timers[self.index],
-            );
-            t
-        }));
+        self.qemu_timer.init_full(
+            None,
+            CLOCK_VIRTUAL,
+            Timer::NS,
+            0,
+            timer_handler,
+            &state.timers[self.index],
+        )
      }
  
      fn get_state(&self) -> &HPETState {
          // SAFETY:
          // the pointer is convertible to a reference
-        unsafe { self.state.unwrap().as_ref() }
+        unsafe { self.state.as_ref() }
      }
  
      fn is_int_active(&self) -> bool {
@@ -330,7 +332,7 @@ fn arm_timer(&mut self, tick: u64) {
          }
  
          self.last = ns;
-        self.qemu_timer.as_ref().unwrap().modify(self.last);
+        self.qemu_timer.modify(self.last);
      }
  
      fn set_timer(&mut self) {
@@ -353,7 +355,7 @@ fn set_timer(&mut self) {
      fn del_timer(&mut self) {
          // Just remove the timer from the timer_list without destroying
          // this timer instance.
-        self.qemu_timer.as_ref().unwrap().delete();
+        self.qemu_timer.delete();
  
          if self.is_int_active() {
              // For level-triggered interrupt, this leaves interrupt status
@@ -581,13 +583,8 @@ fn handle_legacy_irq(&self, irq: u32, level: u32) {
      }
  
      fn init_timer(&self) {
-        let raw_ptr: *mut HPETState = self as *const HPETState as *mut HPETState;
-
          for (index, timer) in self.timers.iter().enumerate() {
-            timer
-                .borrow_mut()
-                .init(index, raw_ptr)
-                .init_timer_with_state();
+            timer.borrow_mut().init(index, self);
          }
      }
  
-- 
2.48.1


 From 276020645786b6537c50bb37795f281b5d630f27 Mon Sep 17 00:00:00 2001
From: Paolo Bonzini <pbonzini@redhat.com>
Date: Fri, 14 Feb 2025 12:06:13 +0100
Subject: [PATCH 2/2] rust: timer: wrap QEMUTimer with Opaque<> and express
  pinning requirements

Timers must be pinned in memory, because modify() stores a pointer to them
in the TimerList.  To express this requirement, change init_full() to take
a pinned reference.  Because the only way to obtain a Timer is through
Timer::new(), which is unsafe, modify() can assume that the timer it got
was later initialized; and because the initialization takes a Pin<&mut
Timer> modify() can assume that the timer is pinned.  In the future the
pinning requirement will be expressed through the pin_init crate instead.

Note that Timer is a bit different from other users of Opaque, in that
it is created in Rust code rather than C code.  This is why it has to
use the unsafe constructors provided by Opaque; and in fact Timer::new()
is also unsafe, because it leaves it to the caller to invoke init_full()
before modify().  Without a call to init_full(), modify() will cause a
NULL pointer dereference.

An alternative could be to combine new() + init_full() by returning a
pinned box; however, using a reference makes it easier to express
the requirement that the opaque outlives the timer.

Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
  meson.build                    |  7 -----
  rust/hw/timer/hpet/src/hpet.rs | 10 ++++++--
  rust/qemu-api/src/timer.rs     | 47 ++++++++++++++++++++++++++--------
  3 files changed, 44 insertions(+), 20 deletions(-)

diff --git a/meson.build b/meson.build
index 9b1c0ba6346..4e8f0a6c00d 100644
--- a/meson.build
+++ b/meson.build
@@ -4098,13 +4098,6 @@ if have_rust
    foreach enum : c_bitfields
      bindgen_args += ['--bitfield-enum', enum]
    endforeach
-  c_nocopy = [
-    'QEMUTimer',
-  ]
-  # Used to customize Drop trait
-  foreach struct : c_nocopy
-    bindgen_args += ['--no-copy', struct]
-  endforeach
  
    # TODO: Remove this comment when the clang/libclang mismatch issue is solved.
    #
diff --git a/rust/hw/timer/hpet/src/hpet.rs b/rust/hw/timer/hpet/src/hpet.rs
index 02c81ae048f..3d3d6ef8eec 100644
--- a/rust/hw/timer/hpet/src/hpet.rs
+++ b/rust/hw/timer/hpet/src/hpet.rs
@@ -4,6 +4,7 @@
  
  use std::{
      ffi::CStr,
+    pin::Pin,
      ptr::{addr_of_mut, null_mut, NonNull},
      slice::from_ref,
  };
@@ -184,7 +185,9 @@ impl HPETTimer {
      fn init(&mut self, index: usize, state: &HPETState) {
          *self = HPETTimer {
              index,
-            qemu_timer: Timer::new(),
+            // SAFETY: the HPETTimer will only be used after the timer
+            // is initialized below.
+            qemu_timer: unsafe { Timer::new() },
              state: NonNull::new(state as *const _ as *mut _).unwrap(),
              config: 0,
              cmp: 0,
@@ -195,7 +198,10 @@ fn init(&mut self, index: usize, state: &HPETState) {
              last: 0,
          };
  
-        self.qemu_timer.init_full(
+        // SAFETY: HPETTimer is only used as part of HPETState, which is
+        // always pinned.
+        let qemu_timer = unsafe { Pin::new_unchecked(&mut self.qemu_timer) };
+        qemu_timer.init_full(
              None,
              CLOCK_VIRTUAL,
              Timer::NS,
diff --git a/rust/qemu-api/src/timer.rs b/rust/qemu-api/src/timer.rs
index a593538917a..f0b04ef95d7 100644
--- a/rust/qemu-api/src/timer.rs
+++ b/rust/qemu-api/src/timer.rs
@@ -2,31 +2,51 @@
  // Author(s): Zhao Liu <zhai1.liu@intel.com>
  // SPDX-License-Identifier: GPL-2.0-or-later
  
-use std::os::raw::{c_int, c_void};
+use std::{
+    os::raw::{c_int, c_void},
+    pin::Pin,
+};
  
  use crate::{
      bindings::{self, qemu_clock_get_ns, timer_del, timer_init_full, timer_mod, QEMUClockType},
      callbacks::FnCall,
+    cell::Opaque,
  };
  
-pub type Timer = bindings::QEMUTimer;
-pub type TimerListGroup = bindings::QEMUTimerListGroup;
+/// A safe wrapper around [`bindings::QEMUTimer`].
+#[repr(transparent)]
+#[derive(Debug, qemu_api_macros::Wrapper)]
+pub struct Timer(Opaque<bindings::QEMUTimer>);
+
+unsafe impl Send for Timer {}
+unsafe impl Sync for Timer {}
+
+#[repr(transparent)]
+#[derive(qemu_api_macros::Wrapper)]
+pub struct TimerListGroup(Opaque<bindings::QEMUTimerListGroup>);
+
+unsafe impl Send for TimerListGroup {}
+unsafe impl Sync for TimerListGroup {}
  
  impl Timer {
      pub const MS: u32 = bindings::SCALE_MS;
      pub const US: u32 = bindings::SCALE_US;
      pub const NS: u32 = bindings::SCALE_NS;
  
-    pub fn new() -> Self {
-        Default::default()
-    }
-
-    const fn as_mut_ptr(&self) -> *mut Self {
-        self as *const Timer as *mut _
+    /// Create a `Timer` struct without initializing it.
+    ///
+    /// # Safety
+    ///
+    /// The timer must be initialized before it is armed with
+    /// [`modify`](Self::modify).
+    pub unsafe fn new() -> Self {
+        // SAFETY: requirements relayed to callers of Timer::new
+        Self(unsafe { Opaque::zeroed() })
      }
  
+    /// Create a new timer with the given attributes.
      pub fn init_full<'timer, 'opaque: 'timer, T, F>(
-        &'timer mut self,
+        self: Pin<&'timer mut Self>,
          timer_list_group: Option<&TimerListGroup>,
          clk_type: ClockType,
          scale: u32,
@@ -51,7 +71,7 @@ pub fn init_full<'timer, 'opaque: 'timer, T, F>(
          // SAFETY: the opaque outlives the timer
          unsafe {
              timer_init_full(
-                self,
+                self.as_mut_ptr(),
                  if let Some(g) = timer_list_group {
                      g as *const TimerListGroup as *mut _
                  } else {
@@ -67,14 +87,19 @@ pub fn init_full<'timer, 'opaque: 'timer, T, F>(
      }
  
      pub fn modify(&self, expire_time: u64) {
+        // SAFETY: the only way to obtain a Timer safely is via methods that
+        // take a Pin<&mut Self>, therefore the timer is pinned
          unsafe { timer_mod(self.as_mut_ptr(), expire_time as i64) }
      }
  
      pub fn delete(&self) {
+        // SAFETY: the only way to obtain a Timer safely is via methods that
+        // take a Pin<&mut Self>, therefore the timer is pinned
          unsafe { timer_del(self.as_mut_ptr()) }
      }
  }
  
+// FIXME: use something like PinnedDrop from the pinned_init crate
  impl Drop for Timer {
      fn drop(&mut self) {
          self.delete()
-- 
2.48.1




