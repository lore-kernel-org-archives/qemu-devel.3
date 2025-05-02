Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4155AC3ABAC
	for <qemu-devel@archiver.kernel.org>; Fri,  2 May 2025 10:25:13 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uAnYj-0001Ht-5p; Fri, 02 May 2025 06:23:57 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1uAnYd-0001GP-L7
 for qemu-devel@nongnu.org; Fri, 02 May 2025 06:23:53 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1uAnYb-0000jp-N6
 for qemu-devel@nongnu.org; Fri, 02 May 2025 06:23:51 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1746181429;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=yjgeAmjjptt4bC7ZVHkPoYUwGWimgF5Hq5dOUJ/c8mk=;
 b=ix9U6cF7UEn5alfIpKjudz1TX4t7jV4Yolsi3rCpzw0xyVbMqgMAUQPkF8SFpsAdwXCjD2
 7KL/7rf0hyEPKhqg8KYZudUlSLCWym/AS48gGdXsnnNxDILQWNxc3Qip7PYfNDiJO60BsZ
 YohupM9IWKONkYxlxxWfx9oGEPzt3N8=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-322-rxCBwC-PMH-5uL9iMFqHkw-1; Fri, 02 May 2025 06:23:47 -0400
X-MC-Unique: rxCBwC-PMH-5uL9iMFqHkw-1
X-Mimecast-MFC-AGG-ID: rxCBwC-PMH-5uL9iMFqHkw_1746181427
Received: by mail-wm1-f72.google.com with SMTP id
 5b1f17b1804b1-43f251dc364so10000845e9.2
 for <qemu-devel@nongnu.org>; Fri, 02 May 2025 03:23:47 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1746181426; x=1746786226;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=yjgeAmjjptt4bC7ZVHkPoYUwGWimgF5Hq5dOUJ/c8mk=;
 b=QQOx8sKmcJzsEi7qegTc7SbPJSus4k78fO5vJsrOb9Gu66tshUIi6fS7ke2qAY/coX
 9DEbwROWYim8k7vEK/4qJ/Mgx1lx59fDogOCsuoFTomxaOcIgitSLEtATP5Ni3wK+XUf
 b13wl6hiKcpM+IFFrnwL11pFuBP9vSN1DaKYA+e1ucq7TPOH1JPyP0odxI3E5GzZ5FXd
 nZureASX8tDEqDA98xh3EovsxCHcxtgYKbZjDbRrI/whdXGeSlCjjh1E78SIUJmLw7mz
 DJvPmRjgAxqPYzs7/pz0FgvRHwVO3hZV/uS9tB2HiUS9p9IfB4l5u8HqTqtANg8ORG7A
 BoDg==
X-Gm-Message-State: AOJu0Yw6XLocPqtr7+PlZSL+TSqI7jCUfTUfrAuCupEY6zm6yI6bDvyA
 H88nLeHHoSKoQdUDBMdy+Dx8liLm+zZm2UWo/T1ntNy2TCOrTfsmchKUUXc+85mVTwz3BD9Z7Uo
 nZN4YeMpBcP8/JaBGnB9S+8TWNyMTOHuJONgHt2jKd7q98jYvVqwpUCU8ugp5XPqtdZMFF4Pao1
 g+f+PDrfcOus/ISt4C6mpNHKEZUPFhHU+cFY/F
X-Gm-Gg: ASbGncsrB8GpwApbcbCb3UEnA2k6nEc+FRXXnglEx5pV9cmy8yJUi5O/h1TTKhoE/Ix
 Z1XWpxTdnCqBS/XconpYq9zGi0IqUXlkRP7OxDzBXBYBewujTN+QVEh9VLo+/WrfmisILCeT3Ql
 9qdEJ0mTd1eXgzg87w2vbq4UH9PRzpETUeIujX2SlPoC/XnyjKD+iaEOEflUmL2i2v87ISRy7Q4
 b2kWDIF9aRzxxaOtnt+dSiz6fDVBDY0JX3ZCSaiO9n1hKwAGUcRz09sRpJOovrwehvSbDeUtB2R
 w9rgEtdA2x2iO4E=
X-Received: by 2002:a05:600c:4e94:b0:43b:ce3c:19d0 with SMTP id
 5b1f17b1804b1-441bbf37ee3mr12825455e9.29.1746181425730; 
 Fri, 02 May 2025 03:23:45 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFpLIh/UxlZVWi7hqjePlhUGWWx01PChVRCAeQUiUz1sUQyw1j2XB65NV17GrXgkMCdfNHcQw==
X-Received: by 2002:a05:600c:4e94:b0:43b:ce3c:19d0 with SMTP id
 5b1f17b1804b1-441bbf37ee3mr12825255e9.29.1746181425294; 
 Fri, 02 May 2025 03:23:45 -0700 (PDT)
Received: from [192.168.10.48] ([151.95.54.106])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-441b89cc67fsm40682395e9.5.2025.05.02.03.23.42
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 02 May 2025 03:23:42 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Cc: qemu-rust@nongnu.org
Subject: [PATCH 8/9] rust: enable clippy::ptr_cast_constness
Date: Fri,  2 May 2025 12:23:21 +0200
Message-ID: <20250502102323.104815-9-pbonzini@redhat.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250502102323.104815-1-pbonzini@redhat.com>
References: <20250502102323.104815-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -26
X-Spam_score: -2.7
X-Spam_bar: --
X-Spam_report: (-2.7 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.644,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 docs/devel/rust.rst             | 2 --
 rust/Cargo.toml                 | 2 +-
 rust/clippy.toml                | 2 +-
 rust/hw/char/pl011/Cargo.toml   | 2 +-
 rust/hw/timer/hpet/Cargo.toml   | 2 +-
 rust/hw/timer/hpet/src/hpet.rs  | 2 +-
 rust/qemu-api-macros/Cargo.toml | 2 +-
 rust/qemu-api/Cargo.toml        | 2 +-
 rust/qemu-api/src/cell.rs       | 2 +-
 rust/qemu-api/src/chardev.rs    | 2 +-
 rust/qemu-api/src/qom.rs        | 4 ++--
 rust/qemu-api/src/timer.rs      | 2 +-
 12 files changed, 12 insertions(+), 14 deletions(-)

diff --git a/docs/devel/rust.rst b/docs/devel/rust.rst
index cae2634a2e9..92550d9d581 100644
--- a/docs/devel/rust.rst
+++ b/docs/devel/rust.rst
@@ -74,8 +74,6 @@ Supported tools
 QEMU supports rustc version 1.63.0 and newer.  Notably, the following features
 are missing:
 
-* ``cast_mut()``/``cast_const()`` (1.65.0).  Use ``as`` instead.
-
 * Generic Associated Types (1.65.0)
 
 * "Return position ``impl Trait`` in Traits" (1.75.0, blocker for including
diff --git a/rust/Cargo.toml b/rust/Cargo.toml
index ea2a85a1d07..bcf43718cf9 100644
--- a/rust/Cargo.toml
+++ b/rust/Cargo.toml
@@ -64,6 +64,7 @@ no_effect_underscore_binding = "deny"
 option_option = "deny"
 or_fun_call = "deny"
 ptr_as_ptr = "deny"
+ptr_cast_constness = "deny"
 pub_underscore_fields = "deny"
 redundant_clone = "deny"
 redundant_closure_for_method_calls = "deny"
@@ -85,7 +86,6 @@ used_underscore_binding = "deny"
 
 # nice to have, but cannot be enabled yet
 #wildcard_imports = "deny"   # still have many bindings::* imports
-#ptr_cast_constness = "deny" # needs 1.65.0 for cast_mut()/cast_const()
 
 # these may have false positives
 #option_if_let_else = "deny"
diff --git a/rust/clippy.toml b/rust/clippy.toml
index 5d190f91dec..933e46a2ffb 100644
--- a/rust/clippy.toml
+++ b/rust/clippy.toml
@@ -1,2 +1,2 @@
 doc-valid-idents = ["PrimeCell", ".."]
-msrv = "1.63.0"
+msrv = "1.77.0"
diff --git a/rust/hw/char/pl011/Cargo.toml b/rust/hw/char/pl011/Cargo.toml
index f2296cad58b..4766badd73e 100644
--- a/rust/hw/char/pl011/Cargo.toml
+++ b/rust/hw/char/pl011/Cargo.toml
@@ -9,7 +9,7 @@ resolver = "2"
 publish = false
 keywords = []
 categories = []
-rust-version = "1.63.0"
+rust-version = "1.77.0"
 
 [lib]
 crate-type = ["staticlib"]
diff --git a/rust/hw/timer/hpet/Cargo.toml b/rust/hw/timer/hpet/Cargo.toml
index 147f216e725..c6c48b2f887 100644
--- a/rust/hw/timer/hpet/Cargo.toml
+++ b/rust/hw/timer/hpet/Cargo.toml
@@ -5,7 +5,7 @@ edition = "2021"
 authors = ["Zhao Liu <zhao1.liu@intel.com>"]
 license = "GPL-2.0-or-later"
 description = "IA-PC High Precision Event Timer emulation in Rust"
-rust-version = "1.63.0"
+rust-version = "1.77.0"
 
 [lib]
 crate-type = ["staticlib"]
diff --git a/rust/hw/timer/hpet/src/hpet.rs b/rust/hw/timer/hpet/src/hpet.rs
index 6afef083a57..779681d6509 100644
--- a/rust/hw/timer/hpet/src/hpet.rs
+++ b/rust/hw/timer/hpet/src/hpet.rs
@@ -218,7 +218,7 @@ fn init(&mut self, index: u8, state: &HPETState) {
             // SAFETY: the HPETTimer will only be used after the timer
             // is initialized below.
             qemu_timer: unsafe { Timer::new() },
-            state: NonNull::new(state as *const _ as *mut _).unwrap(),
+            state: NonNull::new((state as *const HPETState).cast_mut()).unwrap(),
             config: 0,
             cmp: 0,
             fsb: 0,
diff --git a/rust/qemu-api-macros/Cargo.toml b/rust/qemu-api-macros/Cargo.toml
index 89dee1cfb39..8344b1f939d 100644
--- a/rust/qemu-api-macros/Cargo.toml
+++ b/rust/qemu-api-macros/Cargo.toml
@@ -9,7 +9,7 @@ resolver = "2"
 publish = false
 keywords = []
 categories = []
-rust-version = "1.63.0"
+rust-version = "1.77.0"
 
 [lib]
 proc-macro = true
diff --git a/rust/qemu-api/Cargo.toml b/rust/qemu-api/Cargo.toml
index c5b7b2464e9..be00ef1ae9b 100644
--- a/rust/qemu-api/Cargo.toml
+++ b/rust/qemu-api/Cargo.toml
@@ -12,7 +12,7 @@ resolver = "2"
 publish = false
 keywords = []
 categories = []
-rust-version = "1.63.0"
+rust-version = "1.77.0"
 
 [dependencies]
 qemu_api_macros = { path = "../qemu-api-macros" }
diff --git a/rust/qemu-api/src/cell.rs b/rust/qemu-api/src/cell.rs
index b35d19723f6..05ce09f6cb6 100644
--- a/rust/qemu-api/src/cell.rs
+++ b/rust/qemu-api/src/cell.rs
@@ -1016,7 +1016,7 @@ pub const fn as_mut_ptr(&self) -> *mut T {
 
     /// Returns a raw pointer to the opaque data.
     pub const fn as_ptr(&self) -> *const T {
-        self.as_mut_ptr() as *const _
+        self.as_mut_ptr().cast_const()
     }
 
     /// Returns a raw pointer to the opaque data that can be passed to a
diff --git a/rust/qemu-api/src/chardev.rs b/rust/qemu-api/src/chardev.rs
index 146a4852da3..6e0590d758e 100644
--- a/rust/qemu-api/src/chardev.rs
+++ b/rust/qemu-api/src/chardev.rs
@@ -160,7 +160,7 @@ pub fn enable_handlers<
                 receive_cb,
                 event_cb,
                 None,
-                (owner as *const T as *mut T).cast::<c_void>(),
+                (owner as *const T).cast_mut().cast::<c_void>(),
                 core::ptr::null_mut(),
                 true,
             );
diff --git a/rust/qemu-api/src/qom.rs b/rust/qemu-api/src/qom.rs
index 6929e4d33ae..9766a607e73 100644
--- a/rust/qemu-api/src/qom.rs
+++ b/rust/qemu-api/src/qom.rs
@@ -388,7 +388,7 @@ fn as_mut_ptr<U: ObjectType>(&self) -> *mut U
     {
         #[allow(clippy::as_ptr_cast_mut)]
         {
-            self.as_ptr::<U>() as *mut _
+            self.as_ptr::<U>().cast_mut()
         }
     }
 }
@@ -637,7 +637,7 @@ pub unsafe fn from_raw(ptr: *const T) -> Self {
         // SAFETY NOTE: while NonNull requires a mutable pointer, only
         // Deref is implemented so the pointer passed to from_raw
         // remains const
-        Owned(NonNull::new(ptr as *mut T).unwrap())
+        Owned(NonNull::new(ptr.cast_mut()).unwrap())
     }
 
     /// Obtain a raw C pointer from a reference.  `src` is consumed
diff --git a/rust/qemu-api/src/timer.rs b/rust/qemu-api/src/timer.rs
index d697fd742bc..868bd88575f 100644
--- a/rust/qemu-api/src/timer.rs
+++ b/rust/qemu-api/src/timer.rs
@@ -81,7 +81,7 @@ pub fn init_full<'timer, 'opaque: 'timer, T, F>(
                 scale as c_int,
                 attributes as c_int,
                 Some(timer_cb),
-                (opaque as *const T).cast::<c_void>() as *mut c_void,
+                (opaque as *const T).cast::<c_void>().cast_mut(),
             )
         }
     }
-- 
2.49.0


