Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0BE09D33990
	for <qemu-devel@archiver.kernel.org>; Mon, 28 Oct 2024 14:37:55 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t5Qm4-0001lQ-0n; Mon, 28 Oct 2024 10:31:17 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1t5QlB-0000TM-9o
 for qemu-devel@nongnu.org; Mon, 28 Oct 2024 10:30:21 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1t5Ql7-0003y8-VG
 for qemu-devel@nongnu.org; Mon, 28 Oct 2024 10:30:20 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1730125817;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=rJNsDbAV50RLo0Vi2FXdvCjsDtZaOavVS7U5n7y+ISs=;
 b=YoBbWz0+nWsYwahNttlHlskM3SHBTjAdxdOPFX9lkUC/+9lc5paS6GrwaU9uSO+KwDi6Rk
 QKDwHm7eyjNUxrbs1JLbfNhxNwsIbfj+XaEg22xFapER/MBsWMIAz/1MwbbE2w4feCRxiM
 oGgFvqUi/8a15ORY+ukr1xrt5l775oc=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-693-WgB1_zEXMa6i1PysluhQTw-1; Mon, 28 Oct 2024 10:30:15 -0400
X-MC-Unique: WgB1_zEXMa6i1PysluhQTw-1
Received: by mail-wm1-f70.google.com with SMTP id
 5b1f17b1804b1-4316ac69e6dso34156155e9.0
 for <qemu-devel@nongnu.org>; Mon, 28 Oct 2024 07:30:12 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1730125811; x=1730730611;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=rJNsDbAV50RLo0Vi2FXdvCjsDtZaOavVS7U5n7y+ISs=;
 b=OQ7nc2q2BeYA8ms/o7Nar3Jn6nxlkuNLv4m3Yt/OILIBjWJcjx/iU2HVHvImWlO+iq
 HThWumIftChl0I8qP9f7lkV5Kfhvlce07wij0iOhqtbv1qvxUtJ3Athya7cdqMCrzPTi
 UWYiBG1YDXjqMXCO0goxM6Zg22DNs9xjaHSqM5sjqfKVtXH+UvlZkOcgmA4urHMqobtl
 fSzEIEjdWDTsLZc0K8stxzdR+XiMoA+D17LJuLg9FRUAe1GyabSt0nau4Fyj++Ooc5fZ
 PFJ22bcMGpfxa01RzJB3VocZWBjfWTzJ/2HpaQq9gOESoDvo1Du/o9XMMzaICZ2OQz2c
 9Fgw==
X-Gm-Message-State: AOJu0Ywnkj9aecyQGumajNDXXG4U1dhzJ4tHKrHEguak5dDL28stNS3L
 xC7DHRr2UCbO+2cLb39LsfDVjuPs5gex0MQFW2iqDdaAkc4IlRA9Yg1e4//e5Gz5ECCqvm4ZjUC
 Lfp1lJlHe8UXdU/F2X4vzlPy2FuNvN4le7PuKowZ2NIpcdUlsQdDXpXAgcFUynzVGAER0a95DbX
 AEoWx8C3+dIIReAwju74QsZ134rPoMN3cZy3+exC8=
X-Received: by 2002:a5d:49c2:0:b0:37d:39c1:4d3 with SMTP id
 ffacd0b85a97d-380610f2ea6mr6908676f8f.6.1730125810569; 
 Mon, 28 Oct 2024 07:30:10 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGmuKwZr1pb3EjDNLOLIPWO1DQ142q+JnVsJFgo96KdOb95qMPd9bUjfua18HxeLi07LVhu2Q==
X-Received: by 2002:a5d:49c2:0:b0:37d:39c1:4d3 with SMTP id
 ffacd0b85a97d-380610f2ea6mr6908650f8f.6.1730125810158; 
 Mon, 28 Oct 2024 07:30:10 -0700 (PDT)
Received: from [192.168.10.3] ([151.49.226.83])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-38058b71406sm9669144f8f.84.2024.10.28.07.30.08
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 28 Oct 2024 07:30:08 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Cc: Junjie Mao <junjie.mao@hotmail.com>, Kevin Wolf <kwolf@redhat.com>,
 Zhao Liu <zhao1.liu@intel.com>
Subject: [PULL 14/24] rust: remove uses of #[no_mangle]
Date: Mon, 28 Oct 2024 15:29:21 +0100
Message-ID: <20241028142932.363687-15-pbonzini@redhat.com>
X-Mailer: git-send-email 2.47.0
In-Reply-To: <20241028142932.363687-1-pbonzini@redhat.com>
References: <20241028142932.363687-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.373,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.001,
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


