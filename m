Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A11BDD30011
	for <qemu-devel@archiver.kernel.org>; Fri, 18 Oct 2024 14:44:27 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t1oCS-0008Ex-Jl; Fri, 18 Oct 2024 10:43:32 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1t1oCR-0008Ep-4d
 for qemu-devel@nongnu.org; Fri, 18 Oct 2024 10:43:31 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1t1oCP-0002bT-3x
 for qemu-devel@nongnu.org; Fri, 18 Oct 2024 10:43:30 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1729262607;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=WDMAh1URWn4hp3LDQ7fEvPpcwUuvxbAfyftmYDYSiMc=;
 b=D5tkVH3/vBSi7v76mciUD0E/7wrzGJt92Rde/5xwOfUUp0yqJfb8C/pfLEGKYNw6zbvswG
 DM40j0BF5FSIkBHnA24/g0xAz9X9jVLbdI61Rx5A52f0C0AqjKvDcnF4xPHPIp0dhP0CAU
 23S5g6k6rXJ4Br11Bbq/ncrLQHA2feo=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-677-2uyLSTu9OHyFDlzxhhvN9w-1; Fri, 18 Oct 2024 10:43:26 -0400
X-MC-Unique: 2uyLSTu9OHyFDlzxhhvN9w-1
Received: by mail-wm1-f72.google.com with SMTP id
 5b1f17b1804b1-43151e4ef43so15662145e9.3
 for <qemu-devel@nongnu.org>; Fri, 18 Oct 2024 07:43:26 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1729262605; x=1729867405;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=WDMAh1URWn4hp3LDQ7fEvPpcwUuvxbAfyftmYDYSiMc=;
 b=fYcfOf2u8gjvSTqNSwRWcZykFR9GIeDsJY4CO/vd0B95zGvawBxlNQnPw/6x1gAHa1
 kSI8/3d/xcJiy+q4ZrF2lKiYiDxAoTNXMQDWYzeBQhZ7Bapdd0p7UhCRE/IqDekULhCI
 sLONq5ioUT7BLUsyOBh3dIfEy7NZuHpp4Uhvvk+gL+NmJsfEU3blte+ypN11StDBaw6W
 tgZZcOaPUAQxhZnevckgMjwcRXAasUofEcKAit1eEmn9Xd4FDu7krcy4Sn+aOCDgz99s
 OyOsP2Xys6l3UWGT6vx+P4ri61+3r/89QD+GHhRg8NfSXKepw26R+OUULuQMPY+jERe1
 fTSg==
X-Gm-Message-State: AOJu0YzptlA/savxUoFBoQl8e5edyCov++Er80JLhfvUKUzMRwsrFHLP
 f1It8luhSgkGjyrSNzmn1ZFLTRsr6ItVdYbfPhl2S1td7k9f0I3ahI5Jz9GaF/+ogZPhwz6qZvB
 bY8VQ5VtvkDT+tk+oB8bPMUY8l4LA4Vwnsa2g7qSTIs3BWIk3caNivueGXbxVXPcO/tN3xuB905
 hEwqvKfqplyZf2+IU3t60mWvVJQRQEDtV0GCyK9Js=
X-Received: by 2002:a05:600c:3b9b:b0:42c:b037:5f9d with SMTP id
 5b1f17b1804b1-43161636f67mr21257745e9.3.1729262604562; 
 Fri, 18 Oct 2024 07:43:24 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFgFOSJSlu0kfDBE4750eBymTbwtcY3y4QPANHcUJmBCnVByjmrBD8GQoTgQMmm+G1JonIaqA==
X-Received: by 2002:a05:600c:3b9b:b0:42c:b037:5f9d with SMTP id
 5b1f17b1804b1-43161636f67mr21257455e9.3.1729262603953; 
 Fri, 18 Oct 2024 07:43:23 -0700 (PDT)
Received: from avogadro.local ([151.95.144.54])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-37ecf027e49sm2162410f8f.3.2024.10.18.07.43.23
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 18 Oct 2024 07:43:23 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Cc: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>,
 Junjie Mao <junjie.mao@hotmail.com>
Subject: [PATCH 05/13] rust: remove uses of #[no_mangle]
Date: Fri, 18 Oct 2024 16:42:57 +0200
Message-ID: <20241018144306.954716-6-pbonzini@redhat.com>
X-Mailer: git-send-email 2.46.2
In-Reply-To: <20241018144306.954716-1-pbonzini@redhat.com>
References: <20241018144306.954716-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.016,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
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


