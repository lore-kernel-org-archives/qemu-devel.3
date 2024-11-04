Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DF619D1BDD0
	for <qemu-devel@archiver.kernel.org>; Mon,  4 Nov 2024 17:29:23 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t80sC-0005N4-IZ; Mon, 04 Nov 2024 12:28:16 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1t80s9-0005Iq-G1
 for qemu-devel@nongnu.org; Mon, 04 Nov 2024 12:28:14 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1t80s7-0000Kg-Hn
 for qemu-devel@nongnu.org; Mon, 04 Nov 2024 12:28:13 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1730741290;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=OqkXxw1bduZ43gp4lqA3txKBa+8d8snHV/hj05OBUDY=;
 b=eg9DyoTLZ3bybLM0OFqqxAxn4ZCE+aIUhOvukHyWlEnjzEZKNhVzhoXhpz0K9OjSVKzDVe
 mYAhcYtPxmvx6oLvx0TgrhqCJBW8MGQjxRQmjn4gQr2F9s02z71hdDKXXPs8M7YHVlBCzi
 rBRkUaqJ7UOoa8EJwGpJh+u28Eg81/4=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-578-vtGrVKQUO0Sy8bkKKxuRpA-1; Mon, 04 Nov 2024 12:28:09 -0500
X-MC-Unique: vtGrVKQUO0Sy8bkKKxuRpA-1
Received: by mail-wm1-f70.google.com with SMTP id
 5b1f17b1804b1-4317391101aso29008745e9.2
 for <qemu-devel@nongnu.org>; Mon, 04 Nov 2024 09:28:09 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1730741288; x=1731346088;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=OqkXxw1bduZ43gp4lqA3txKBa+8d8snHV/hj05OBUDY=;
 b=FiwMO6to0Ul98h1HVh3+XemOOysXYLHkCnspGOXl2oSFqyBW+GzVa6fHo2eG4STDBZ
 xIwAQkfrfrfx7TJBvmWemZx0qohMAKzJ20eglldK7swrDs2CxbdxrCv/Ipbc4nRWOU8n
 YOHsf+F06lSYX/1nWbee0te8MyFLx49/I8ZewbGjb3mW8Al7BhPh7vqw46baizvGlMNY
 jtuH7CfYb6QNWoXNb7KL35+rCmsURI4C/+FI+zJurn49Ow/MrSL+X8ZdGCCgRtrBZCMo
 7K1xFqnHt+yfO+6dlLiWgOsUGmFqLc22+/HHGcxRS6y3E5kJMIpmPBtb7KMqVAxATAsc
 QDbQ==
X-Gm-Message-State: AOJu0Yxqu2aJKSLAVreaxbNBHMDbN8dwB7/IYzaTkGp2S4A4aYKVRqKx
 8ESNIocunwqKfvvTIcfq765onmmbbSHvP5g6YqjmSl5Z6g9ppVTvQ/FIYJHJkfIWNOFgTrBho+w
 /XZCF8XKWUmpgDq0fgJlWb8UlUdDuCM4UrtlNoexnu8TGwpZKy8eyAUk/Aqz0KrZ2mp6ph4c7zV
 3P4aXR8xnj32mbKCqpdTCM1y1EvEaI/sOQ/nlIs5k=
X-Received: by 2002:a05:600c:5492:b0:431:251a:9dc9 with SMTP id
 5b1f17b1804b1-4328328481dmr115241165e9.25.1730741287598; 
 Mon, 04 Nov 2024 09:28:07 -0800 (PST)
X-Google-Smtp-Source: AGHT+IF627EkzTNHR41jLSPP1AztaSa8/xZraM0fCiAnCN6KBp6k6u1Cls1P17UZpjh3Edesg+Y2Dg==
X-Received: by 2002:a05:600c:5492:b0:431:251a:9dc9 with SMTP id
 5b1f17b1804b1-4328328481dmr115240805e9.25.1730741287172; 
 Mon, 04 Nov 2024 09:28:07 -0800 (PST)
Received: from [192.168.10.3] ([151.49.226.83])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-431bd8e853esm193969385e9.8.2024.11.04.09.28.05
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 04 Nov 2024 09:28:05 -0800 (PST)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Junjie Mao <junjie.mao@hotmail.com>, Kevin Wolf <kwolf@redhat.com>,
 Manos Pitsidianakis <manos.pitsidianakis@linaro.org>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 Zhao Liu <zhao1.liu@intel.com>
Subject: [PULL 20/40] rust/pl011: add support for migration
Date: Mon,  4 Nov 2024 18:26:59 +0100
Message-ID: <20241104172721.180255-21-pbonzini@redhat.com>
X-Mailer: git-send-email 2.47.0
In-Reply-To: <20241104172721.180255-1-pbonzini@redhat.com>
References: <20241104172721.180255-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -23
X-Spam_score: -2.4
X-Spam_bar: --
X-Spam_report: (-2.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.34,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

From: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>

Declare the vmstate description of the PL011 device.

Based on a patch by Manos Pitsidianakis
(https://lore.kernel.org/qemu-devel/20241024-rust-round-2-v1-4-051e7a25b978@linaro.org/).

Signed-off-by: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
Link: https://lore.kernel.org/r/20241024-rust-round-2-v1-4-051e7a25b978@linaro.org
---
 rust/hw/char/pl011/src/device.rs       | 27 ++++++++++
 rust/hw/char/pl011/src/device_class.rs | 73 +++++++++++++++++++++++---
 rust/hw/char/pl011/src/lib.rs          |  1 +
 3 files changed, 95 insertions(+), 6 deletions(-)

diff --git a/rust/hw/char/pl011/src/device.rs b/rust/hw/char/pl011/src/device.rs
index b3d8bc004e0..dd9145669dc 100644
--- a/rust/hw/char/pl011/src/device.rs
+++ b/rust/hw/char/pl011/src/device.rs
@@ -20,6 +20,12 @@
 
 static PL011_ID_ARM: [c_uchar; 8] = [0x11, 0x10, 0x14, 0x00, 0x0d, 0xf0, 0x05, 0xb1];
 
+/// Integer Baud Rate Divider, `UARTIBRD`
+const IBRD_MASK: u32 = 0x3f;
+
+/// Fractional Baud Rate Divider, `UARTFBRD`
+const FBRD_MASK: u32 = 0xffff;
+
 const DATA_BREAK: u32 = 1 << 10;
 
 /// QEMU sourced constant.
@@ -492,6 +498,27 @@ pub fn update(&self) {
             unsafe { qemu_set_irq(*irq, i32::from(flags & i != 0)) };
         }
     }
+
+    pub fn post_load(&mut self, _version_id: u32) -> Result<(), ()> {
+        /* Sanity-check input state */
+        if self.read_pos >= self.read_fifo.len() || self.read_count > self.read_fifo.len() {
+            return Err(());
+        }
+
+        if !self.fifo_enabled() && self.read_count > 0 && self.read_pos > 0 {
+            // Older versions of PL011 didn't ensure that the single
+            // character in the FIFO in FIFO-disabled mode is in
+            // element 0 of the array; convert to follow the current
+            // code's assumptions.
+            self.read_fifo[0] = self.read_fifo[self.read_pos];
+            self.read_pos = 0;
+        }
+
+        self.ibrd &= IBRD_MASK;
+        self.fbrd &= FBRD_MASK;
+
+        Ok(())
+    }
 }
 
 /// Which bits in the interrupt status matter for each outbound IRQ line ?
diff --git a/rust/hw/char/pl011/src/device_class.rs b/rust/hw/char/pl011/src/device_class.rs
index 9282dc4d151..6a554ad7926 100644
--- a/rust/hw/char/pl011/src/device_class.rs
+++ b/rust/hw/char/pl011/src/device_class.rs
@@ -2,16 +2,77 @@
 // Author(s): Manos Pitsidianakis <manos.pitsidianakis@linaro.org>
 // SPDX-License-Identifier: GPL-2.0-or-later
 
-use core::ptr::NonNull;
+use core::{
+    ffi::{c_int, c_void},
+    ptr::NonNull,
+};
 
-use qemu_api::{bindings::*, definitions::ObjectImpl, zeroable::Zeroable};
+use qemu_api::{
+    bindings::*, vmstate_clock, vmstate_fields, vmstate_int32, vmstate_subsections, vmstate_uint32,
+    vmstate_uint32_array, vmstate_unused, zeroable::Zeroable,
+};
 
-use crate::device::PL011State;
+use crate::device::{PL011State, PL011_FIFO_DEPTH};
+
+extern "C" fn pl011_clock_needed(opaque: *mut c_void) -> bool {
+    unsafe {
+        debug_assert!(!opaque.is_null());
+        let state = NonNull::new_unchecked(opaque.cast::<PL011State>());
+        state.as_ref().migrate_clock
+    }
+}
+
+/// Migration subsection for [`PL011State`] clock.
+pub static VMSTATE_PL011_CLOCK: VMStateDescription = VMStateDescription {
+    name: c"pl011/clock".as_ptr(),
+    version_id: 1,
+    minimum_version_id: 1,
+    needed: Some(pl011_clock_needed),
+    fields: vmstate_fields! {
+        vmstate_clock!(clock, PL011State),
+    },
+    ..Zeroable::ZERO
+};
+
+extern "C" fn pl011_post_load(opaque: *mut c_void, version_id: c_int) -> c_int {
+    unsafe {
+        debug_assert!(!opaque.is_null());
+        let mut state = NonNull::new_unchecked(opaque.cast::<PL011State>());
+        let result = state.as_mut().post_load(version_id as u32);
+        if result.is_err() {
+            -1
+        } else {
+            0
+        }
+    }
+}
 
-#[used]
 pub static VMSTATE_PL011: VMStateDescription = VMStateDescription {
-    name: PL011State::TYPE_INFO.name,
-    unmigratable: true,
+    name: c"pl011".as_ptr(),
+    version_id: 2,
+    minimum_version_id: 2,
+    post_load: Some(pl011_post_load),
+    fields: vmstate_fields! {
+        vmstate_unused!(core::mem::size_of::<u32>()),
+        vmstate_uint32!(flags, PL011State),
+        vmstate_uint32!(line_control, PL011State),
+        vmstate_uint32!(receive_status_error_clear, PL011State),
+        vmstate_uint32!(control, PL011State),
+        vmstate_uint32!(dmacr, PL011State),
+        vmstate_uint32!(int_enabled, PL011State),
+        vmstate_uint32!(int_level, PL011State),
+        vmstate_uint32_array!(read_fifo, PL011State, PL011_FIFO_DEPTH),
+        vmstate_uint32!(ilpr, PL011State),
+        vmstate_uint32!(ibrd, PL011State),
+        vmstate_uint32!(fbrd, PL011State),
+        vmstate_uint32!(ifl, PL011State),
+        vmstate_int32!(read_pos, PL011State),
+        vmstate_int32!(read_count, PL011State),
+        vmstate_int32!(read_trigger, PL011State),
+    },
+    subsections: vmstate_subsections! {
+        VMSTATE_PL011_CLOCK
+    },
     ..Zeroable::ZERO
 };
 
diff --git a/rust/hw/char/pl011/src/lib.rs b/rust/hw/char/pl011/src/lib.rs
index 2939ee50c99..73474a07e7c 100644
--- a/rust/hw/char/pl011/src/lib.rs
+++ b/rust/hw/char/pl011/src/lib.rs
@@ -36,6 +36,7 @@
     clippy::cognitive_complexity,
     clippy::missing_safety_doc,
     )]
+#![allow(clippy::result_unit_err)]
 
 extern crate bilge;
 extern crate bilge_impl;
-- 
2.47.0


