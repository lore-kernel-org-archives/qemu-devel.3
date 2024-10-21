Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 63464D15DBA
	for <qemu-devel@archiver.kernel.org>; Mon, 21 Oct 2024 16:37:26 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t2vOz-0006ol-Lo; Mon, 21 Oct 2024 12:37:05 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1t2vOD-00067n-Va
 for qemu-devel@nongnu.org; Mon, 21 Oct 2024 12:36:18 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1t2vOA-0006K1-RG
 for qemu-devel@nongnu.org; Mon, 21 Oct 2024 12:36:17 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1729528572;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=ieLsbmqkTfVjeUAmxOVRrXd6Rl3o+mJGozPICAN/5xE=;
 b=F0E6w98mn9oeKoZh4sjhz28+jiI4X0vrYO0gk0KT4+/hcrDS2U/V5hxQzfpcrfvJfR+QCN
 v7HPKTIF1GtByNhR61hcz3NRSHx11JZ5wKpg9TpSJsHZ9zod6BJv8WBZ0XTKAbCYStdWyd
 NJiRBliBWfT+j0RRI1Wj5x7GXvSRhs0=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-631-rM1olqiiMguaYboKpJrx_Q-1; Mon, 21 Oct 2024 12:36:10 -0400
X-MC-Unique: rM1olqiiMguaYboKpJrx_Q-1
Received: by mail-wm1-f70.google.com with SMTP id
 5b1f17b1804b1-43163a40ee0so25575105e9.0
 for <qemu-devel@nongnu.org>; Mon, 21 Oct 2024 09:36:06 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1729528559; x=1730133359;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=ieLsbmqkTfVjeUAmxOVRrXd6Rl3o+mJGozPICAN/5xE=;
 b=hC3jHqS1Ekt8PTe+Jv9B6ChxFjlwYgVQUsUMWIkgpw5v2Lccz+7BStlRS2QS0OHyNp
 FBoQOlKw8ARbF6z8mJ7Rw3pU3ZNbuoO+9UNGRr1I4Nks6/9jYHSTEcD9P3OWzkS63NcR
 atDpVszDpI5vABRd7sPGJFVXa12aK5yttKr5doxRib4o262feJzu0aABYIOsn9Z9j7sQ
 ckQY9A/vPjXss5fu043zVjS9nyyMS4MpvMjGX483kvbb1ANqWG/i+AAUx0dZeUL7slLE
 0mmFQrYstlFpnx0KOEPo570G2NwYCljBQ7vB4BQKVlq4X7r/n/SR3jh3IX3iRrk3Pvyu
 c6vA==
X-Gm-Message-State: AOJu0YztnBQvxRUcZJNUT7wdF6yXcyBwfwAFv64Od5XPbIgvIe/iLgkw
 Bz4XUdxnuPzvKfb0A7VTJo+/Beac1IEGLTtTHcxlr0KPLnJAo1ZyOMJqvhOKYOGGB2uWoMR0Vmp
 VWstsiqLMED+57Ay4r1Mz5cBTFkZJyRYH9pN13SwwVBNZOwgxx+1EZz5KYT2ulpCfDP71rOTl+7
 kAmi4ve0nJfbq8jjb93W96gQClgvFUCq1cVvtcDxA=
X-Received: by 2002:a05:600c:45cb:b0:431:3927:d1bc with SMTP id
 5b1f17b1804b1-431616331f5mr86372445e9.2.1729528559291; 
 Mon, 21 Oct 2024 09:35:59 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHu9Toro2BrXmSEvXUExVMxKz8xGKwSpCitVQrOvid8rCqjZyXrzFvZ3FJcdm0RkCQisHmB1Q==
X-Received: by 2002:a05:600c:45cb:b0:431:3927:d1bc with SMTP id
 5b1f17b1804b1-431616331f5mr86372195e9.2.1729528558754; 
 Mon, 21 Oct 2024 09:35:58 -0700 (PDT)
Received: from avogadro.local ([151.95.144.54])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-37ee0b9bb15sm4711993f8f.99.2024.10.21.09.35.57
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 21 Oct 2024 09:35:58 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Cc: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>,
 Junjie Mao <junjie.mao@hotmail.com>
Subject: [PATCH v2 05/13] rust: remove uses of #[no_mangle]
Date: Mon, 21 Oct 2024 18:35:30 +0200
Message-ID: <20241021163538.136941-6-pbonzini@redhat.com>
X-Mailer: git-send-email 2.46.2
In-Reply-To: <20241021163538.136941-1-pbonzini@redhat.com>
References: <20241021163538.136941-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -41
X-Spam_score: -4.2
X-Spam_bar: ----
X-Spam_report: (-4.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.421,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-1.699,
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

Mangled symbols do not cause any issue; disabling mangling is only useful if
C headers reference the Rust function, which is not the case here.

Reviewed-by: Junjie Mao <junjie.mao@hotmail.com>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 rust/hw/char/pl011/src/device.rs       | 5 -----
 rust/hw/char/pl011/src/device_class.rs | 2 --
 rust/hw/char/pl011/src/memory_ops.rs   | 2 --
 rust/qemu-api/src/definitions.rs       | 1 -
 rust/qemu-api/src/device_class.rs      | 2 --
 5 files changed, 12 deletions(-)

diff --git a/rust/hw/char/pl011/src/device.rs b/rust/hw/char/pl011/src/device.rs
index c7193b41bee..2b43f5e0939 100644
--- a/rust/hw/char/pl011/src/device.rs
+++ b/rust/hw/char/pl011/src/device.rs
@@ -514,7 +514,6 @@ pub fn update(&self) {
 /// We expect the FFI user of this function to pass a valid pointer, that has
 /// the same size as [`PL011State`]. We also expect the device is
 /// readable/writeable from one thread at any time.
-#[no_mangle]
 pub unsafe extern "C" fn pl011_can_receive(opaque: *mut c_void) -> c_int {
     unsafe {
         debug_assert!(!opaque.is_null());
@@ -530,7 +529,6 @@ pub fn update(&self) {
 /// readable/writeable from one thread at any time.
 ///
 /// The buffer and size arguments must also be valid.
-#[no_mangle]
 pub unsafe extern "C" fn pl011_receive(
     opaque: *mut core::ffi::c_void,
     buf: *const u8,
@@ -554,7 +552,6 @@ pub fn update(&self) {
 /// We expect the FFI user of this function to pass a valid pointer, that has
 /// the same size as [`PL011State`]. We also expect the device is
 /// readable/writeable from one thread at any time.
-#[no_mangle]
 pub unsafe extern "C" fn pl011_event(opaque: *mut core::ffi::c_void, event: QEMUChrEvent) {
     unsafe {
         debug_assert!(!opaque.is_null());
@@ -566,7 +563,6 @@ pub fn update(&self) {
 /// # Safety
 ///
 /// We expect the FFI user of this function to pass a valid pointer for `chr`.
-#[no_mangle]
 pub unsafe extern "C" fn pl011_create(
     addr: u64,
     irq: qemu_irq,
@@ -589,7 +585,6 @@ pub fn update(&self) {
 /// We expect the FFI user of this function to pass a valid pointer, that has
 /// the same size as [`PL011State`]. We also expect the device is
 /// readable/writeable from one thread at any time.
-#[no_mangle]
 pub unsafe extern "C" fn pl011_init(obj: *mut Object) {
     unsafe {
         debug_assert!(!obj.is_null());
diff --git a/rust/hw/char/pl011/src/device_class.rs b/rust/hw/char/pl011/src/device_class.rs
index b7ab31af02d..2ad80451e87 100644
--- a/rust/hw/char/pl011/src/device_class.rs
+++ b/rust/hw/char/pl011/src/device_class.rs
@@ -46,7 +46,6 @@
 /// We expect the FFI user of this function to pass a valid pointer, that has
 /// the same size as [`PL011State`]. We also expect the device is
 /// readable/writeable from one thread at any time.
-#[no_mangle]
 pub unsafe extern "C" fn pl011_realize(dev: *mut DeviceState, _errp: *mut *mut Error) {
     unsafe {
         assert!(!dev.is_null());
@@ -60,7 +59,6 @@
 /// We expect the FFI user of this function to pass a valid pointer, that has
 /// the same size as [`PL011State`]. We also expect the device is
 /// readable/writeable from one thread at any time.
-#[no_mangle]
 pub unsafe extern "C" fn pl011_reset(dev: *mut DeviceState) {
     unsafe {
         assert!(!dev.is_null());
diff --git a/rust/hw/char/pl011/src/memory_ops.rs b/rust/hw/char/pl011/src/memory_ops.rs
index 8d066ebf6d0..5a5320e66c3 100644
--- a/rust/hw/char/pl011/src/memory_ops.rs
+++ b/rust/hw/char/pl011/src/memory_ops.rs
@@ -22,7 +22,6 @@
     },
 };
 
-#[no_mangle]
 unsafe extern "C" fn pl011_read(
     opaque: *mut core::ffi::c_void,
     addr: hwaddr,
@@ -44,7 +43,6 @@
     }
 }
 
-#[no_mangle]
 unsafe extern "C" fn pl011_write(
     opaque: *mut core::ffi::c_void,
     addr: hwaddr,
diff --git a/rust/qemu-api/src/definitions.rs b/rust/qemu-api/src/definitions.rs
index 0b681c593f2..49ac59af123 100644
--- a/rust/qemu-api/src/definitions.rs
+++ b/rust/qemu-api/src/definitions.rs
@@ -53,7 +53,6 @@ extern "C" fn __load() {
         #[cfg_attr(target_os = "windows", link_section = ".CRT$XCU")]
         pub static LOAD_MODULE: extern "C" fn() = {
             extern "C" fn __load() {
-                #[no_mangle]
                 unsafe extern "C" fn $func() {
                     $body
                 }
diff --git a/rust/qemu-api/src/device_class.rs b/rust/qemu-api/src/device_class.rs
index b6b68cf9ce2..2219b9f73d0 100644
--- a/rust/qemu-api/src/device_class.rs
+++ b/rust/qemu-api/src/device_class.rs
@@ -9,7 +9,6 @@
 #[macro_export]
 macro_rules! device_class_init {
     ($func:ident, props => $props:ident, realize_fn => $realize_fn:expr, legacy_reset_fn => $legacy_reset_fn:expr, vmsd => $vmsd:ident$(,)*) => {
-        #[no_mangle]
         pub unsafe extern "C" fn $func(
             klass: *mut $crate::bindings::ObjectClass,
             _: *mut ::core::ffi::c_void,
@@ -103,7 +102,6 @@ const fn _calc_prop_len() -> usize {
             ]
         }
 
-        #[no_mangle]
         pub static mut $ident: $crate::device_class::Properties<PROP_LEN> = $crate::device_class::Properties(::std::sync::OnceLock::new(), _make_properties);
     };
 }
-- 
2.46.2


