Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 75888D1BDD0
	for <qemu-devel@archiver.kernel.org>; Mon,  4 Nov 2024 17:31:34 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t80rq-000585-OW; Mon, 04 Nov 2024 12:27:54 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1t80ro-00057E-PA
 for qemu-devel@nongnu.org; Mon, 04 Nov 2024 12:27:53 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1t80rl-0000DT-OD
 for qemu-devel@nongnu.org; Mon, 04 Nov 2024 12:27:52 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1730741268;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=rJNsDbAV50RLo0Vi2FXdvCjsDtZaOavVS7U5n7y+ISs=;
 b=CfBKyELN5Nj0wXVw8S/kjrugdDt1MESfnWGwqH09dlPRahiQ6NAVnx1kla2UMJBW7pBFsh
 2VTd1PvPna6NJqPqi4lM+TppubdRm400hjymQAtX0rkw63bhor9VpX+mEfbNyCAjXlNQTm
 sAVYyB4CzczHNUT8ubE1LsecKmqzuO8=
Received: from mail-lf1-f70.google.com (mail-lf1-f70.google.com
 [209.85.167.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-9-BtnaXuVOPXyFw6v0_s_5aw-1; Mon, 04 Nov 2024 12:27:47 -0500
X-MC-Unique: BtnaXuVOPXyFw6v0_s_5aw-1
Received: by mail-lf1-f70.google.com with SMTP id
 2adb3069b0e04-539f7ed336bso2776531e87.2
 for <qemu-devel@nongnu.org>; Mon, 04 Nov 2024 09:27:47 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1730741265; x=1731346065;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=rJNsDbAV50RLo0Vi2FXdvCjsDtZaOavVS7U5n7y+ISs=;
 b=lvWwlcEk0pf4CBxm5Mi4U90WQZ7hDilNCyQQBNbFJLMQXRcQYPV5RMwGcSOWjYhVvO
 qNsnrnJkMWnEpGBJ4eKCrk4dIEyRrZuhNkayFtG13zJXYofwh8lNU7Br5aex5KWODsvH
 ismacY7n+czIbFUtxlMOylz/1C18Bi5uJhuHlqfMnudQlMsKj69oi2qSezRS5vUM9zNo
 r2ICH3ydCfWKzF6uw2esONHVZQ1ses5NkYjekWlYJWO2I9jwxrLmwLnsGo89TdP0PQWm
 /LEXit+6i0SwmNRFQZCO3mZJ+ab8zcrfQ2PJFo/iDK5KpvnlqbJN+/D3nrN7XKuLwYzj
 3pDA==
X-Gm-Message-State: AOJu0YyM7FaYpWY1gLQfXJfGPxMtWTYLDTqXG4hB0AqxGNAihz7ucUZO
 ldMdSA7SzMDi6OXw9c8pMxxuaWJcSUJH4hQkqViC12/RBg03WI3J1LMFn44ifX8agsPIErB1y3o
 IYrx596B124WQ20X01bPIWGv1nIMSrO2VtIOZ+qNaNzWytY6XvEeA8I3P5SWBee1ZAG9PPcjbia
 Kfp5IU7ERO9nxBq4Ar7EpW0pcACSDES23qDo1v4ws=
X-Received: by 2002:a05:6512:10c7:b0:539:fcb2:2ff4 with SMTP id
 2adb3069b0e04-53b34b373dcmr14278426e87.53.1730741265127; 
 Mon, 04 Nov 2024 09:27:45 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGlT+hpJ0aCm//XZ3HY8wC27OYoLAW4lEWKXwL/wMigi+xlVsujdyAoJ9FRT1yye+S+1sYI2A==
X-Received: by 2002:a05:6512:10c7:b0:539:fcb2:2ff4 with SMTP id
 2adb3069b0e04-53b34b373dcmr14278401e87.53.1730741264614; 
 Mon, 04 Nov 2024 09:27:44 -0800 (PST)
Received: from [192.168.10.3] ([151.49.226.83])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4327d685308sm157860855e9.33.2024.11.04.09.27.42
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 04 Nov 2024 09:27:43 -0800 (PST)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Junjie Mao <junjie.mao@hotmail.com>, Kevin Wolf <kwolf@redhat.com>,
 Manos Pitsidianakis <manos.pitsidianakis@linaro.org>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 Zhao Liu <zhao1.liu@intel.com>
Subject: [PULL 10/40] rust: remove uses of #[no_mangle]
Date: Mon,  4 Nov 2024 18:26:49 +0100
Message-ID: <20241104172721.180255-11-pbonzini@redhat.com>
X-Mailer: git-send-email 2.47.0
In-Reply-To: <20241104172721.180255-1-pbonzini@redhat.com>
References: <20241104172721.180255-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -23
X-Spam_score: -2.4
X-Spam_bar: --
X-Spam_report: (-2.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.34,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.001,
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
Reviewed-by: Kevin Wolf <kwolf@redhat.com>
Reviewed-by: Zhao Liu <zhao1.liu@intel.com>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 rust/hw/char/pl011/src/device.rs       | 4 ----
 rust/hw/char/pl011/src/device_class.rs | 2 --
 rust/hw/char/pl011/src/memory_ops.rs   | 2 --
 rust/qemu-api/src/definitions.rs       | 1 -
 rust/qemu-api/src/device_class.rs      | 2 --
 5 files changed, 11 deletions(-)

diff --git a/rust/hw/char/pl011/src/device.rs b/rust/hw/char/pl011/src/device.rs
index c7193b41bee..0347a027c5f 100644
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
@@ -589,7 +586,6 @@ pub fn update(&self) {
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
2.47.0


