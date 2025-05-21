Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D5C54C2D0CD
	for <qemu-devel@archiver.kernel.org>; Wed, 21 May 2025 08:20:31 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uHefe-0004uv-KH; Wed, 21 May 2025 04:19:26 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1uHefU-0004qs-91
 for qemu-devel@nongnu.org; Wed, 21 May 2025 04:19:16 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1uHefM-0000DX-Ds
 for qemu-devel@nongnu.org; Wed, 21 May 2025 04:19:15 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1747815546;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=DYNNR8kxdpigAzsfIWV54lNrAJSCQ81aFM7IBOhn2ic=;
 b=JqGSB6IBDdVBkEFFYzLTt2eLt4B3uMVBuipBrATyDT7PWI5nBVyZ/e/sUMAJV3JTvm+cXW
 J6fosvPoFXJZikNzH7U3mPFAer4Q/yRnvWczyAiep0OFwXWamRA7T8dKdyewl7KS8F9FDs
 FEgY1BLQu2096pfgXgqTwm8hi2zkDjQ=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-275-fkmscUJxPdq_ST0gwrOPtA-1; Wed, 21 May 2025 04:19:03 -0400
X-MC-Unique: fkmscUJxPdq_ST0gwrOPtA-1
X-Mimecast-MFC-AGG-ID: fkmscUJxPdq_ST0gwrOPtA_1747815543
Received: by mail-wm1-f70.google.com with SMTP id
 5b1f17b1804b1-43cf446681cso39564465e9.1
 for <qemu-devel@nongnu.org>; Wed, 21 May 2025 01:19:03 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1747815542; x=1748420342;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=DYNNR8kxdpigAzsfIWV54lNrAJSCQ81aFM7IBOhn2ic=;
 b=X+ve3XNoS0RkQbQXP0X1TzSBT3Z3qZFpncMNM3mXmVq1jr+vldaqaHiFaH8LwRVXUK
 fmiFq7AJ2q6lOj4pUNMZEMCuElk3uxp06hGikTSVGc9mm3PWBBlyh9G560V0cdSqo2fO
 d04YZ7rDKrnoZH96pK/AleVf5qp6HW4Xmuj+yDlq9J/d0zq39HM2WAOLiPnoDwIcyvw2
 AR+pnqTQMV4BHURB4/mrrMOX0Rt+1RTpy3SMgEs4YEw71E/HY7NAWtPJIGv+ANQF+Pub
 I8+EEEn0oYxVR+GUA553hDC7Byo3HmjAYjaHzyKC91YiajzPSUM8Dnjxkwg643QHkfVA
 LaBw==
X-Gm-Message-State: AOJu0YyUaD/uMm+NslizuV3Bsm9FVXFpTVVMLCnG9mkxGGGYDOHy5DWl
 T57KDnUMv+SmnaKUF+eMQSu+YH3CkOczgLm3XRJaVwX6DneA+fZQdu+DymLq9OfljD0w5UvRPY0
 HAZvfvV8a3Z+9RhVsvRhM1yUdFvHivZAOFM5Gcmo4kf+44xZYlbzvVKDciP9LYA6xVVBvwEzSPY
 q4BWV31woSM5h8s3uMRGr0eb96AoYAjEDlErEUyCGF
X-Gm-Gg: ASbGnctuRuq2ySd9fA4wdEiDuL5Q/XOyiii33LcQe8dnPNwZryyf5zUhkdEle3xQyOw
 72eRKA/I0O8rD8AJzFORy7TECCpRVHWq+ghJ7EgxzXT4hhFzjkZmMgg6p+ghhikUXkK117Q2wi5
 57nXaonteQSZWYCOocvxGRhd+VI1dlO4F3arrYu1+CpckzmYSyGjdPAXUaP3/QeASxpxx+L70z1
 vI98IoWt81xgfgLBu/cTH5nJ8gQb9p8E+o5BQ2bdXM7G7ItWDWd7c13Myob+kvLcvT9qjHQheRu
 Z+awxm3WlC5cqQ==
X-Received: by 2002:a05:6000:2912:b0:3a3:7cbd:39b1 with SMTP id
 ffacd0b85a97d-3a37cbd3a4amr3969548f8f.24.1747815542185; 
 Wed, 21 May 2025 01:19:02 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGTv4UneDWAAT5256cTYhIwEYTuV/wYGAzeZOfqdtUiMDzLj9p2MCij0/aDKFQHgODH8wa6EQ==
X-Received: by 2002:a05:6000:2912:b0:3a3:7cbd:39b1 with SMTP id
 ffacd0b85a97d-3a37cbd3a4amr3969500f8f.24.1747815541606; 
 Wed, 21 May 2025 01:19:01 -0700 (PDT)
Received: from [192.168.122.1] ([151.95.46.79])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3a36749f622sm15154505f8f.93.2025.05.21.01.19.00
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 21 May 2025 01:19:01 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Cc: peter.maydell@linaro.org, qemu-rust@nongnu.org,
 manos.pitsidianakis@linaro.org
Subject: [RFC PATCH 6/6] rust: remove bilge crate
Date: Wed, 21 May 2025 10:18:45 +0200
Message-ID: <20250521081845.496442-7-pbonzini@redhat.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250521081845.496442-1-pbonzini@redhat.com>
References: <20250521081845.496442-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -25
X-Spam_score: -2.6
X-Spam_bar: --
X-Spam_report: (-2.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.487,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_FILL_THIS_FORM_SHORT=0.01 autolearn=unavailable autolearn_force=no
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
 rust/Cargo.lock                             | 71 ++-------------------
 rust/qemu-api/src/vmstate.rs                | 34 ++--------
 subprojects/.gitignore                      |  7 --
 subprojects/arbitrary-int-1-rs.wrap         | 10 ---
 subprojects/bilge-0.2-rs.wrap               | 10 ---
 subprojects/bilge-impl-0.2-rs.wrap          | 10 ---
 subprojects/either-1-rs.wrap                | 10 ---
 subprojects/itertools-0.11-rs.wrap          | 10 ---
 subprojects/proc-macro-error-1-rs.wrap      | 10 ---
 subprojects/proc-macro-error-attr-1-rs.wrap | 10 ---
 10 files changed, 10 insertions(+), 172 deletions(-)
 delete mode 100644 subprojects/arbitrary-int-1-rs.wrap
 delete mode 100644 subprojects/bilge-0.2-rs.wrap
 delete mode 100644 subprojects/bilge-impl-0.2-rs.wrap
 delete mode 100644 subprojects/either-1-rs.wrap
 delete mode 100644 subprojects/itertools-0.11-rs.wrap
 delete mode 100644 subprojects/proc-macro-error-1-rs.wrap
 delete mode 100644 subprojects/proc-macro-error-attr-1-rs.wrap

diff --git a/rust/Cargo.lock b/rust/Cargo.lock
index bccfe855a70..29ac523bfdb 100644
--- a/rust/Cargo.lock
+++ b/rust/Cargo.lock
@@ -3,29 +3,11 @@
 version = 3
 
 [[package]]
-name = "arbitrary-int"
-version = "1.2.7"
+name = "bitfield-struct"
+version = "0.9.5"
 source = "registry+https://github.com/rust-lang/crates.io-index"
-checksum = "c84fc003e338a6f69fbd4f7fe9f92b535ff13e9af8997f3b14b6ddff8b1df46d"
-
-[[package]]
-name = "bilge"
-version = "0.2.0"
-source = "registry+https://github.com/rust-lang/crates.io-index"
-checksum = "dc707ed8ebf81de5cd6c7f48f54b4c8621760926cdf35a57000747c512e67b57"
+checksum = "b2869c63ccf4f8bf0d485070b880e60e097fb7aeea80ee82a0a94a957e372a0b"
 dependencies = [
- "arbitrary-int",
- "bilge-impl",
-]
-
-[[package]]
-name = "bilge-impl"
-version = "0.2.0"
-source = "registry+https://github.com/rust-lang/crates.io-index"
-checksum = "feb11e002038ad243af39c2068c8a72bcf147acf05025dcdb916fcc000adb2d8"
-dependencies = [
- "itertools",
- "proc-macro-error",
  "proc-macro2",
  "quote",
  "syn",
@@ -38,12 +20,6 @@ dependencies = [
  "qemu_api_macros",
 ]
 
-[[package]]
-name = "either"
-version = "1.12.0"
-source = "registry+https://github.com/rust-lang/crates.io-index"
-checksum = "3dca9240753cf90908d7e4aac30f630662b02aebaa1b58a3cadabdb23385b58b"
-
 [[package]]
 name = "hpet"
 version = "0.1.0"
@@ -52,15 +28,6 @@ dependencies = [
  "qemu_api_macros",
 ]
 
-[[package]]
-name = "itertools"
-version = "0.11.0"
-source = "registry+https://github.com/rust-lang/crates.io-index"
-checksum = "b1c173a5686ce8bfa551b3563d0c2170bf24ca44da99c7ca4bfdab5418c3fe57"
-dependencies = [
- "either",
-]
-
 [[package]]
 name = "libc"
 version = "0.2.162"
@@ -71,36 +38,12 @@ checksum = "18d287de67fe55fd7e1581fe933d965a5a9477b38e949cfa9f8574ef01506398"
 name = "pl011"
 version = "0.1.0"
 dependencies = [
- "bilge",
- "bilge-impl",
+ "bitfield-struct",
  "bits",
  "qemu_api",
  "qemu_api_macros",
 ]
 
-[[package]]
-name = "proc-macro-error"
-version = "1.0.4"
-source = "registry+https://github.com/rust-lang/crates.io-index"
-checksum = "da25490ff9892aab3fcf7c36f08cfb902dd3e71ca0f9f9517bea02a73a5ce38c"
-dependencies = [
- "proc-macro-error-attr",
- "proc-macro2",
- "quote",
- "version_check",
-]
-
-[[package]]
-name = "proc-macro-error-attr"
-version = "1.0.4"
-source = "registry+https://github.com/rust-lang/crates.io-index"
-checksum = "a1be40180e52ecc98ad80b184934baf3d0d29f979574e439af5a55274b35f869"
-dependencies = [
- "proc-macro2",
- "quote",
- "version_check",
-]
-
 [[package]]
 name = "proc-macro2"
 version = "1.0.84"
@@ -152,9 +95,3 @@ name = "unicode-ident"
 version = "1.0.12"
 source = "registry+https://github.com/rust-lang/crates.io-index"
 checksum = "3354b9ac3fae1ff6755cb6db53683adb661634f67557942dea4facebec0fee4b"
-
-[[package]]
-name = "version_check"
-version = "0.9.4"
-source = "registry+https://github.com/rust-lang/crates.io-index"
-checksum = "49874b5167b65d7193b8aba1567f5c7d93d001cafc34600cee003eda787e483f"
diff --git a/rust/qemu-api/src/vmstate.rs b/rust/qemu-api/src/vmstate.rs
index 9c8b2398e9d..38faf6ce0dc 100644
--- a/rust/qemu-api/src/vmstate.rs
+++ b/rust/qemu-api/src/vmstate.rs
@@ -11,10 +11,9 @@
 //!   migration format for a struct.  This is based on the [`VMState`] trait,
 //!   which is defined by all migrateable types.
 //!
-//! * [`impl_vmstate_forward`](crate::impl_vmstate_forward) and
-//!   [`impl_vmstate_bitsized`](crate::impl_vmstate_bitsized), which help with
-//!   the definition of the [`VMState`] trait (respectively for transparent
-//!   structs and for `bilge`-defined types)
+//! * [`impl_vmstate_forward`](crate::impl_vmstate_forward), which help with the
+//!   definition of the [`VMState`] trait (respectively for transparent structs
+//!   and for `bilge`-defined types)
 //!
 //! * helper macros to declare a device model state struct, in particular
 //!   [`vmstate_subsections`](crate::vmstate_subsections) and
@@ -141,7 +140,7 @@ macro_rules! info_enum_to_ref {
 /// The contents of this trait go straight into structs that are parsed by C
 /// code and used to introspect into other structs.  Generally, you don't need
 /// to implement it except via macros that do it for you, such as
-/// `impl_vmstate_bitsized!`.
+/// `impl_vmstate_forward!`.
 pub unsafe trait VMState {
     /// The `info` member of a `VMStateField` is a pointer and as such cannot
     /// yet be included in the [`BASE`](VMState::BASE) associated constant;
@@ -195,9 +194,8 @@ pub const fn vmstate_varray_flag<T: VMState>(_: PhantomData<T>) -> VMStateFlags
 /// * an array of any of the above
 ///
 /// In order to support other types, the trait `VMState` must be implemented
-/// for them.  The macros
-/// [`impl_vmstate_bitsized!`](crate::impl_vmstate_bitsized)
-/// and [`impl_vmstate_forward!`](crate::impl_vmstate_forward) help with this.
+/// for them.  The macro
+/// [`impl_vmstate_forward!`](crate::impl_vmstate_forward) helps with this.
 #[macro_export]
 macro_rules! vmstate_of {
     ($struct_name:ty, $field_name:ident $([0 .. $num:ident $(* $factor:expr)?])? $(, $test_fn:expr)? $(,)?) => {
@@ -345,26 +343,6 @@ unsafe impl<$base> VMState for $type where $base: VMState $($where)* {
 impl_vmstate_transparent!(crate::cell::BqlRefCell<T> where T: VMState);
 impl_vmstate_transparent!(crate::cell::Opaque<T> where T: VMState);
 
-#[macro_export]
-macro_rules! impl_vmstate_bitsized {
-    ($type:ty) => {
-        unsafe impl $crate::vmstate::VMState for $type {
-            const SCALAR_TYPE: $crate::vmstate::VMStateFieldType =
-                                        <<<$type as ::bilge::prelude::Bitsized>::ArbitraryInt
-                                          as ::bilge::prelude::Number>::UnderlyingType
-                                         as $crate::vmstate::VMState>::SCALAR_TYPE;
-            const BASE: $crate::bindings::VMStateField =
-                                        <<<$type as ::bilge::prelude::Bitsized>::ArbitraryInt
-                                          as ::bilge::prelude::Number>::UnderlyingType
-                                         as $crate::vmstate::VMState>::BASE;
-            const VARRAY_FLAG: $crate::bindings::VMStateFlags =
-                                        <<<$type as ::bilge::prelude::Bitsized>::ArbitraryInt
-                                          as ::bilge::prelude::Number>::UnderlyingType
-                                         as $crate::vmstate::VMState>::VARRAY_FLAG;
-        }
-    };
-}
-
 // Scalar types using predefined VMStateInfos
 
 macro_rules! impl_vmstate_scalar {
diff --git a/subprojects/.gitignore b/subprojects/.gitignore
index 180c3134864..183700d986e 100644
--- a/subprojects/.gitignore
+++ b/subprojects/.gitignore
@@ -6,15 +6,8 @@
 /keycodemapdb
 /libvfio-user
 /slirp
-/arbitrary-int-1.2.7
-/bilge-0.2.0
-/bilge-impl-0.2.0
 /bitfield-struct-0.9.5
-/either-1.12.0
-/itertools-0.11.0
 /libc-0.2.162
-/proc-macro-error-1.0.4
-/proc-macro-error-attr-1.0.4
 /proc-macro2-1.0.84
 /quote-1.0.36
 /syn-2.0.66
diff --git a/subprojects/arbitrary-int-1-rs.wrap b/subprojects/arbitrary-int-1-rs.wrap
deleted file mode 100644
index a1838b20b0f..00000000000
--- a/subprojects/arbitrary-int-1-rs.wrap
+++ /dev/null
@@ -1,10 +0,0 @@
-[wrap-file]
-directory = arbitrary-int-1.2.7
-source_url = https://crates.io/api/v1/crates/arbitrary-int/1.2.7/download
-source_filename = arbitrary-int-1.2.7.tar.gz
-source_hash = c84fc003e338a6f69fbd4f7fe9f92b535ff13e9af8997f3b14b6ddff8b1df46d
-#method = cargo
-patch_directory = arbitrary-int-1-rs
-
-# bump this version number on every change to meson.build or the patches:
-# v2
diff --git a/subprojects/bilge-0.2-rs.wrap b/subprojects/bilge-0.2-rs.wrap
deleted file mode 100644
index 900bb1497b9..00000000000
--- a/subprojects/bilge-0.2-rs.wrap
+++ /dev/null
@@ -1,10 +0,0 @@
-[wrap-file]
-directory = bilge-0.2.0
-source_url = https://crates.io/api/v1/crates/bilge/0.2.0/download
-source_filename = bilge-0.2.0.tar.gz
-source_hash = dc707ed8ebf81de5cd6c7f48f54b4c8621760926cdf35a57000747c512e67b57
-#method = cargo
-patch_directory = bilge-0.2-rs
-
-# bump this version number on every change to meson.build or the patches:
-# v2
diff --git a/subprojects/bilge-impl-0.2-rs.wrap b/subprojects/bilge-impl-0.2-rs.wrap
deleted file mode 100644
index 4f84eca1ccd..00000000000
--- a/subprojects/bilge-impl-0.2-rs.wrap
+++ /dev/null
@@ -1,10 +0,0 @@
-[wrap-file]
-directory = bilge-impl-0.2.0
-source_url = https://crates.io/api/v1/crates/bilge-impl/0.2.0/download
-source_filename = bilge-impl-0.2.0.tar.gz
-source_hash = feb11e002038ad243af39c2068c8a72bcf147acf05025dcdb916fcc000adb2d8
-#method = cargo
-patch_directory = bilge-impl-0.2-rs
-
-# bump this version number on every change to meson.build or the patches:
-# v2
diff --git a/subprojects/either-1-rs.wrap b/subprojects/either-1-rs.wrap
deleted file mode 100644
index 352e11cfee6..00000000000
--- a/subprojects/either-1-rs.wrap
+++ /dev/null
@@ -1,10 +0,0 @@
-[wrap-file]
-directory = either-1.12.0
-source_url = https://crates.io/api/v1/crates/either/1.12.0/download
-source_filename = either-1.12.0.tar.gz
-source_hash = 3dca9240753cf90908d7e4aac30f630662b02aebaa1b58a3cadabdb23385b58b
-#method = cargo
-patch_directory = either-1-rs
-
-# bump this version number on every change to meson.build or the patches:
-# v2
diff --git a/subprojects/itertools-0.11-rs.wrap b/subprojects/itertools-0.11-rs.wrap
deleted file mode 100644
index ee12d0053bc..00000000000
--- a/subprojects/itertools-0.11-rs.wrap
+++ /dev/null
@@ -1,10 +0,0 @@
-[wrap-file]
-directory = itertools-0.11.0
-source_url = https://crates.io/api/v1/crates/itertools/0.11.0/download
-source_filename = itertools-0.11.0.tar.gz
-source_hash = b1c173a5686ce8bfa551b3563d0c2170bf24ca44da99c7ca4bfdab5418c3fe57
-#method = cargo
-patch_directory = itertools-0.11-rs
-
-# bump this version number on every change to meson.build or the patches:
-# v2
diff --git a/subprojects/proc-macro-error-1-rs.wrap b/subprojects/proc-macro-error-1-rs.wrap
deleted file mode 100644
index 59f892f7825..00000000000
--- a/subprojects/proc-macro-error-1-rs.wrap
+++ /dev/null
@@ -1,10 +0,0 @@
-[wrap-file]
-directory = proc-macro-error-1.0.4
-source_url = https://crates.io/api/v1/crates/proc-macro-error/1.0.4/download
-source_filename = proc-macro-error-1.0.4.tar.gz
-source_hash = da25490ff9892aab3fcf7c36f08cfb902dd3e71ca0f9f9517bea02a73a5ce38c
-#method = cargo
-patch_directory = proc-macro-error-1-rs
-
-# bump this version number on every change to meson.build or the patches:
-# v2
diff --git a/subprojects/proc-macro-error-attr-1-rs.wrap b/subprojects/proc-macro-error-attr-1-rs.wrap
deleted file mode 100644
index 5aeb224a103..00000000000
--- a/subprojects/proc-macro-error-attr-1-rs.wrap
+++ /dev/null
@@ -1,10 +0,0 @@
-[wrap-file]
-directory = proc-macro-error-attr-1.0.4
-source_url = https://crates.io/api/v1/crates/proc-macro-error-attr/1.0.4/download
-source_filename = proc-macro-error-attr-1.0.4.tar.gz
-source_hash = a1be40180e52ecc98ad80b184934baf3d0d29f979574e439af5a55274b35f869
-#method = cargo
-patch_directory = proc-macro-error-attr-1-rs
-
-# bump this version number on every change to meson.build or the patches:
-# v2
-- 
2.49.0


