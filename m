Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 759BEC021A4
	for <qemu-devel@archiver.kernel.org>; Thu, 13 Feb 2025 16:02:37 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tibfB-00010s-86; Thu, 13 Feb 2025 11:02:05 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1tibez-0000zC-MS
 for qemu-devel@nongnu.org; Thu, 13 Feb 2025 11:01:54 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1tibex-0005bF-Oj
 for qemu-devel@nongnu.org; Thu, 13 Feb 2025 11:01:53 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1739462511;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=mivfeOqK0XtIeqrjyFn8pgXSCxXVOfe1ZMdvogAVIRk=;
 b=K+dC8Mfl8WFnbb7OpWsqX1E8PAknXxFJgf73eMv4GXR8tfoIoXpj2+C06ROjj3flDT6FnK
 oBjuDdwkWa3p78t1w0bFM7XrYA8sT+WrWlRgl+pk1WQOpCIvpy54toZO5nI7UmWouWBM3P
 sSbMVFxprP3Z0efYe5enisT8eAWtYsE=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-644-ggKGpwhWNCS7I1FbHFrR-Q-1; Thu, 13 Feb 2025 11:01:47 -0500
X-MC-Unique: ggKGpwhWNCS7I1FbHFrR-Q-1
X-Mimecast-MFC-AGG-ID: ggKGpwhWNCS7I1FbHFrR-Q
Received: by mail-wr1-f72.google.com with SMTP id
 ffacd0b85a97d-38f20b530dfso1060679f8f.3
 for <qemu-devel@nongnu.org>; Thu, 13 Feb 2025 08:01:47 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1739462506; x=1740067306;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=mivfeOqK0XtIeqrjyFn8pgXSCxXVOfe1ZMdvogAVIRk=;
 b=t3exQYQc3bBpUeFoZKR/TwstEfAti2sRph5YycGly2Wg2uvORZUbcUKPFZH0MX2ReF
 r8Ns4f6aJ1UHmj3F7wVh0h/YY3aPC80f3d0QpMapFijZP4nfK3meEETa6P9Qm1NJoMYt
 p6hjOUQgSrTN1JBk64764c6TN7+gopsaEX7SDT5Wm7Cok1dYvftd/qhzUiu8CBEPaACx
 eYHPIdlM2rSyIcfRlWt5yh8dTSHWP2sgMRkaZJs7TVYjS9S7PWXdi5CmHTFLQQ7/XI/H
 m1TTOqzpWF+iZsEPH5D5SGK+L/6avBjGZSPwVl4/fafNwGuvznVBm3BLPzGtfTAjAya/
 7ANg==
X-Gm-Message-State: AOJu0YyhWLmxUGhIbCYqe5TCjRsf6xegUb1jaBuIq4b9iG7QJjU79tbo
 Hm7jJqur2PxgnXYs9trNsPU19qdo0SrRv1TA4nHh8000w/uHBFoUfSI0vNWGwtXGgKytFkc0sVA
 /Zki+t5ffXKn21fuI0yWHw5gFwQZQ/gr8IF4aZOsb3tjHlvNLFqwL05Dvex3ui5mRP0RYMGf7Wg
 JbAHT4Mmwc+WRt8QGpOXNI8QBuqTMFf5usSiQPoOY=
X-Gm-Gg: ASbGncuG9p6ewG/PotJMnG3chsaFB+WAJ4RGTJfPfQWAf+H7g8R1NWpG/ih9D+Ncmct
 BsSSnEH7GbsjKY7wdYRPP8EYzh03hVS1P5bnNeEu8r4F8O9wS50iwnRG4JtnN0bhktnkMZgxGW+
 c3BJ/+obKHth2mM45XFfUy/6yrtKYE8MF0x7pLriDvXwVpCt3CZbQTgse3G4LhacFUvijna0COP
 XWbjX1rB1CoL12m3oaPVogyasq45c9CMUs/i4JHngPbqDcQx3Q2MPWdQeBBfT3etRPktnySIFzn
 yzJ/R1Qu0uDhJKFitZvP0nmc3x3WDkImLRa2u4yMnIeESg==
X-Received: by 2002:a05:6000:1868:b0:38d:e0be:71a3 with SMTP id
 ffacd0b85a97d-38dea2fa9fdmr8502046f8f.54.1739462504860; 
 Thu, 13 Feb 2025 08:01:44 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFBZ0AJzJ6RThTRI63zaw+dhT6Wid1pjduAqrAQms4tBdlrua7qdRZ9GTkWn/cP39VTWBz7GA==
X-Received: by 2002:a05:6000:1868:b0:38d:e0be:71a3 with SMTP id
 ffacd0b85a97d-38dea2fa9fdmr8501970f8f.54.1739462504225; 
 Thu, 13 Feb 2025 08:01:44 -0800 (PST)
Received: from [192.168.126.123] (93-38-211-213.ip72.fastwebnet.it.
 [93.38.211.213]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-43961826cd4sm21228355e9.24.2025.02.13.08.01.43
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 13 Feb 2025 08:01:43 -0800 (PST)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Cc: Zhao Liu <zhao1.liu@intel.com>
Subject: [PULL 17/27] rust: add bindings for gpio_{in|out} initialization
Date: Thu, 13 Feb 2025 17:00:44 +0100
Message-ID: <20250213160054.3937012-18-pbonzini@redhat.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250213160054.3937012-1-pbonzini@redhat.com>
References: <20250213160054.3937012-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -35
X-Spam_score: -3.6
X-Spam_bar: ---
X-Spam_report: (-3.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.495,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001,
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

Wrap qdev_init_gpio_{in|out} as methods in DeviceMethods. And for
qdev_init_gpio_in, based on FnCall, it can support idiomatic Rust
callback without the need for C style wrapper.

Signed-off-by: Zhao Liu <zhao1.liu@intel.com>
Link: https://lore.kernel.org/r/20250210030051.2562726-5-zhao1.liu@intel.com
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 rust/qemu-api/src/irq.rs  |  1 -
 rust/qemu-api/src/qdev.rs | 47 +++++++++++++++++++++++++++++++++++----
 2 files changed, 43 insertions(+), 5 deletions(-)

diff --git a/rust/qemu-api/src/irq.rs b/rust/qemu-api/src/irq.rs
index 672eec1430f..d1c9dc96eff 100644
--- a/rust/qemu-api/src/irq.rs
+++ b/rust/qemu-api/src/irq.rs
@@ -84,7 +84,6 @@ pub(crate) const fn as_ptr(&self) -> *mut *mut IRQState {
         self.cell.as_ptr()
     }
 
-    #[allow(dead_code)]
     pub(crate) const fn slice_as_ptr(slice: &[Self]) -> *mut *mut IRQState {
         assert!(!slice.is_empty());
         slice[0].as_ptr()
diff --git a/rust/qemu-api/src/qdev.rs b/rust/qemu-api/src/qdev.rs
index c44a22876b9..3a7aa4def62 100644
--- a/rust/qemu-api/src/qdev.rs
+++ b/rust/qemu-api/src/qdev.rs
@@ -6,17 +6,18 @@
 
 use std::{
     ffi::{CStr, CString},
-    os::raw::c_void,
+    os::raw::{c_int, c_void},
     ptr::NonNull,
 };
 
 pub use bindings::{Clock, ClockEvent, DeviceClass, DeviceState, Property, ResetType};
 
 use crate::{
-    bindings::{self, Error, ResettableClass},
+    bindings::{self, qdev_init_gpio_in, qdev_init_gpio_out, Error, ResettableClass},
     callbacks::FnCall,
     cell::bql_locked,
     chardev::Chardev,
+    irq::InterruptSource,
     prelude::*,
     qom::{ClassInitImpl, ObjectClass, ObjectImpl, Owned},
     vmstate::VMStateDescription,
@@ -28,8 +29,8 @@ pub trait ResettablePhasesImpl {
     /// If not None, this is called when the object enters reset. It
     /// can reset local state of the object, but it must not do anything that
     /// has a side-effect on other objects, such as raising or lowering an
-    /// [`InterruptSource`](crate::irq::InterruptSource), or reading or
-    /// writing guest memory. It takes the reset's type as argument.
+    /// [`InterruptSource`], or reading or writing guest memory. It takes the
+    /// reset's type as argument.
     const ENTER: Option<fn(&Self, ResetType)> = None;
 
     /// If not None, this is called when the object for entry into reset, once
@@ -318,6 +319,44 @@ fn prop_set_chr(&self, propname: &str, chr: &Owned<Chardev>) {
             bindings::qdev_prop_set_chr(self.as_mut_ptr(), c_propname.as_ptr(), chr.as_mut_ptr());
         }
     }
+
+    fn init_gpio_in<F: for<'a> FnCall<(&'a Self::Target, u32, u32)>>(
+        &self,
+        num_lines: u32,
+        _cb: F,
+    ) {
+        let _: () = F::ASSERT_IS_SOME;
+
+        unsafe extern "C" fn rust_irq_handler<T, F: for<'a> FnCall<(&'a T, u32, u32)>>(
+            opaque: *mut c_void,
+            line: c_int,
+            level: c_int,
+        ) {
+            // SAFETY: the opaque was passed as a reference to `T`
+            F::call((unsafe { &*(opaque.cast::<T>()) }, line as u32, level as u32))
+        }
+
+        let gpio_in_cb: unsafe extern "C" fn(*mut c_void, c_int, c_int) =
+            rust_irq_handler::<Self::Target, F>;
+
+        unsafe {
+            qdev_init_gpio_in(
+                self.as_mut_ptr::<DeviceState>(),
+                Some(gpio_in_cb),
+                num_lines as c_int,
+            );
+        }
+    }
+
+    fn init_gpio_out(&self, pins: &[InterruptSource]) {
+        unsafe {
+            qdev_init_gpio_out(
+                self.as_mut_ptr::<DeviceState>(),
+                InterruptSource::slice_as_ptr(pins),
+                pins.len() as c_int,
+            );
+        }
+    }
 }
 
 impl<R: ObjectDeref> DeviceMethods for R where R::Target: IsA<DeviceState> {}
-- 
2.48.1


