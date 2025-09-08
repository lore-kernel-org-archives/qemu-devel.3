Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 06518CAC581
	for <qemu-devel@archiver.kernel.org>; Mon,  8 Sep 2025 10:52:24 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uvZSW-00066K-EO; Mon, 08 Sep 2025 06:50:53 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1uvZSQ-00064F-Lq
 for qemu-devel@nongnu.org; Mon, 08 Sep 2025 06:50:48 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1uvZS8-0005yf-VZ
 for qemu-devel@nongnu.org; Mon, 08 Sep 2025 06:50:37 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1757328620;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=SZbJleeyulOpA5LrkMwUKjkXRJN+Q3YBVWNLlLwx58A=;
 b=DqctccKuyI0eQo7xAcgMGovJGM5Khxg87aiYPpFPiOrXGsY7u2oClg4cNx3z6D1iB7CzSJ
 ybtdwPxWcoRxzLSvNShzTSt4mYjZxr8JGojmQqhYm39Ho8T3PQBG/13RFT81VQDIsOEATn
 70fkNWtnF5C96+rrsJDbgvPSXSTlKks=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-683-OpDBZtkyM0yI-8aL_8bTgA-1; Mon, 08 Sep 2025 06:50:19 -0400
X-MC-Unique: OpDBZtkyM0yI-8aL_8bTgA-1
X-Mimecast-MFC-AGG-ID: OpDBZtkyM0yI-8aL_8bTgA_1757328618
Received: by mail-wm1-f69.google.com with SMTP id
 5b1f17b1804b1-45dcf5f1239so16370715e9.2
 for <qemu-devel@nongnu.org>; Mon, 08 Sep 2025 03:50:19 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1757328618; x=1757933418;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=SZbJleeyulOpA5LrkMwUKjkXRJN+Q3YBVWNLlLwx58A=;
 b=bpCNjV82tdJiuPt70AAfJgjQu2hzNpPBzh8o0vfAIm8Kp32BKD/AptZ+3FYhgKNsTb
 KuljL4ezyArgL/Rn1HNDJ492x7ezXYH+JuV7w/Bggf7+PKPwbOsUPN026XSeJ8ipVNWh
 H0lqJUULRPgr1HiPAfp9O2Kh/53x2vJNWlaapBQKaVyRWPpZvFiQ7iVWA5upwGKa8LOB
 g3lnDIoaoCs3KcifkfgSGrO6/mPdMnUYZGeOSqCWQyIw1byjT6Cgk0uzS2Bmsa9NqXAl
 WL0jqFLe4i0U8HoQs5bbA/WzS2y0s8BMGmxnoek9FFiPEyseKwVErftC2fBSghsofx9M
 naEQ==
X-Gm-Message-State: AOJu0Yxsqch1Bv5BYaINCvR3Er8EcvMsmI4KqJJjDHvxV1FisdCfgwWx
 EjEXNLJUIo02dBpyBR2ngvDAfY1a5bv1xgYuKYk/k+ZWqHrK/BEHTzwenYeDbyz0aXXru8//SfN
 Rh//SpXjbVBGvMqy1htuSYIDX8gVeRm89KM+KDxYC1DHQTgl4Ru0KHhEGikBy1A+Khe3WzpH/Pn
 ZZo4avP4Sd7yxcpUoRqGG344/CSURDGX2nIS9uOaVu
X-Gm-Gg: ASbGnctsxIKJp27Zh1YquTzX1aE78nXk2WKmyb8mpb323Mml5/4K5ehciSVdR3Tn73S
 JzaTComewkFg5HpXZ9nytgHUlYIKfmtVJzq/gdUNb3U2Fv3U9Pvx4EK07wiaBptFQ3SVdkb4NOJ
 tLjY23VohvNEFJOGpPBDetHwC3CRc2ISSTRUh6xDbbmNLeE16zF07o9QnxeyVrFJemsOnKQ/HYG
 g6fr35cF60zLRZb3Nt0E5AJZRZf/J+7UDg0QxXy9oWvuEHwggnRXzGHY+c3D3rNW/FQgNPGC3sJ
 bUZ4jgI6p2mhoYMcnfbltXSCFTfCyGgIS4Z03e1BAArP2pXwZnhyQxAEwa0gWlfbMSc+N0u5Dj9
 LSgf17UiRs9z4nayIa15mzU16JvBs4Ey1mrrgOxHhknM=
X-Received: by 2002:a05:600c:6298:b0:459:d451:3364 with SMTP id
 5b1f17b1804b1-45dddecdaa7mr67425405e9.24.1757328617624; 
 Mon, 08 Sep 2025 03:50:17 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHHl9yOQe29Rdv8jl1S4Rx2noZPEQ8W5VP9dYHUPVe58UCa0wwkMkRy9/DdwEX/Ed+0PE3wCg==
X-Received: by 2002:a05:600c:6298:b0:459:d451:3364 with SMTP id
 5b1f17b1804b1-45dddecdaa7mr67425025e9.24.1757328617036; 
 Mon, 08 Sep 2025 03:50:17 -0700 (PDT)
Received: from [192.168.10.48] ([151.95.56.250])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-45c447244c4sm240568135e9.6.2025.09.08.03.50.15
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 08 Sep 2025 03:50:15 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH 04/33] rust: add missing const markers for MSRV==1.83.0
Date: Mon,  8 Sep 2025 12:49:36 +0200
Message-ID: <20250908105005.2119297-5-pbonzini@redhat.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20250908105005.2119297-1-pbonzini@redhat.com>
References: <20250908105005.2119297-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -30
X-Spam_score: -3.1
X-Spam_bar: ---
X-Spam_report: (-3.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=-1, RCVD_IN_MSPIKE_WL=-0.01,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

Rust 1.83 allows more functions to be marked const.
Fix clippy with bumped minimum supported Rust version.

Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 rust/bits/src/lib.rs            | 6 +++---
 rust/qemu-api/src/assertions.rs | 4 ++--
 rust/qemu-api/src/cell.rs       | 6 ++----
 rust/qemu-api/src/qom.rs        | 6 +++---
 rust/qemu-api/src/timer.rs      | 2 +-
 rust/qemu-api/src/uninit.rs     | 6 +++---
 6 files changed, 14 insertions(+), 16 deletions(-)

diff --git a/rust/bits/src/lib.rs b/rust/bits/src/lib.rs
index d485d6bd110..e9d15ad0cb5 100644
--- a/rust/bits/src/lib.rs
+++ b/rust/bits/src/lib.rs
@@ -165,19 +165,19 @@ pub const fn into_bits(self) -> $type {
 
             #[allow(dead_code)]
             #[inline(always)]
-            pub fn set(&mut self, rhs: Self) {
+            pub const fn set(&mut self, rhs: Self) {
                 self.0 |= rhs.0;
             }
 
             #[allow(dead_code)]
             #[inline(always)]
-            pub fn clear(&mut self, rhs: Self) {
+            pub const fn clear(&mut self, rhs: Self) {
                 self.0 &= !rhs.0;
             }
 
             #[allow(dead_code)]
             #[inline(always)]
-            pub fn toggle(&mut self, rhs: Self) {
+            pub const fn toggle(&mut self, rhs: Self) {
                 self.0 ^= rhs.0;
             }
 
diff --git a/rust/qemu-api/src/assertions.rs b/rust/qemu-api/src/assertions.rs
index a2d38c877df..e74fa3ef826 100644
--- a/rust/qemu-api/src/assertions.rs
+++ b/rust/qemu-api/src/assertions.rs
@@ -81,8 +81,8 @@ macro_rules! assert_field_type {
     (@internal $param_name:ident, $ti:ty, $t:ty, $($field:tt)*) => {
         const _: () = {
             #[allow(unused)]
-            fn assert_field_type($param_name: &$t) {
-                fn types_must_be_equal<T, U>(_: &T)
+            const fn assert_field_type($param_name: &$t) {
+                const fn types_must_be_equal<T, U>(_: &T)
                 where
                     T: $crate::assertions::EqType<Itself = U>,
                 {
diff --git a/rust/qemu-api/src/cell.rs b/rust/qemu-api/src/cell.rs
index 27063b049d5..148a13e3f56 100644
--- a/rust/qemu-api/src/cell.rs
+++ b/rust/qemu-api/src/cell.rs
@@ -980,8 +980,7 @@ pub unsafe fn from_raw<'a>(ptr: *mut T) -> &'a Self {
     /// but the functions containing the dereference are usually safe.  The
     /// value returned from `uninit()` must be initialized and pinned before
     /// calling them.
-    #[allow(clippy::missing_const_for_fn)]
-    pub unsafe fn uninit() -> Self {
+    pub const unsafe fn uninit() -> Self {
         Self {
             value: UnsafeCell::new(MaybeUninit::uninit()),
             _pin: PhantomPinned,
@@ -997,8 +996,7 @@ pub unsafe fn uninit() -> Self {
     /// but the functions containing the dereference are usually safe.  The
     /// value returned from `uninit()` must be pinned (and possibly initialized)
     /// before calling them.
-    #[allow(clippy::missing_const_for_fn)]
-    pub unsafe fn zeroed() -> Self {
+    pub const unsafe fn zeroed() -> Self {
         Self {
             value: UnsafeCell::new(MaybeUninit::zeroed()),
             _pin: PhantomPinned,
diff --git a/rust/qemu-api/src/qom.rs b/rust/qemu-api/src/qom.rs
index e20ee014cb1..014ffb1fd88 100644
--- a/rust/qemu-api/src/qom.rs
+++ b/rust/qemu-api/src/qom.rs
@@ -307,7 +307,7 @@ impl<T: ObjectType> ParentInit<'_, T> {
     /// Fields beyond `Object` could be uninitialized and it's your
     /// responsibility to avoid that they're used when the pointer is
     /// dereferenced, either directly or through a cast.
-    pub fn as_object_mut_ptr(&self) -> *mut bindings::Object {
+    pub const fn as_object_mut_ptr(&self) -> *mut bindings::Object {
         self.as_object_ptr().cast_mut()
     }
 
@@ -318,7 +318,7 @@ pub fn as_object_mut_ptr(&self) -> *mut bindings::Object {
     /// Fields beyond `Object` could be uninitialized and it's your
     /// responsibility to avoid that they're used when the pointer is
     /// dereferenced, either directly or through a cast.
-    pub fn as_object_ptr(&self) -> *const bindings::Object {
+    pub const fn as_object_ptr(&self) -> *const bindings::Object {
         self.0.as_ptr().cast()
     }
 }
@@ -336,7 +336,7 @@ impl<'a, T: ObjectImpl> ParentInit<'a, T> {
     /// However, while the fields of the resulting reference are initialized,
     /// calls might use uninitialized fields of the subclass.  It is your
     /// responsibility to avoid this.
-    pub unsafe fn upcast<U: ObjectType>(&self) -> &'a U
+    pub const unsafe fn upcast<U: ObjectType>(&self) -> &'a U
     where
         T::ParentType: IsA<U>,
     {
diff --git a/rust/qemu-api/src/timer.rs b/rust/qemu-api/src/timer.rs
index 0a2d111d490..0daec62f926 100644
--- a/rust/qemu-api/src/timer.rs
+++ b/rust/qemu-api/src/timer.rs
@@ -39,7 +39,7 @@ impl Timer {
     ///
     /// The timer must be initialized before it is armed with
     /// [`modify`](Self::modify).
-    pub unsafe fn new() -> Self {
+    pub const unsafe fn new() -> Self {
         // SAFETY: requirements relayed to callers of Timer::new
         Self(unsafe { Opaque::zeroed() })
     }
diff --git a/rust/qemu-api/src/uninit.rs b/rust/qemu-api/src/uninit.rs
index 04123b4ae99..b0a829729dd 100644
--- a/rust/qemu-api/src/uninit.rs
+++ b/rust/qemu-api/src/uninit.rs
@@ -12,7 +12,7 @@ pub struct MaybeUninitField<'a, T, U> {
 
 impl<'a, T, U> MaybeUninitField<'a, T, U> {
     #[doc(hidden)]
-    pub fn new(parent: &'a mut MaybeUninit<T>, child: *mut U) -> Self {
+    pub const fn new(parent: &'a mut MaybeUninit<T>, child: *mut U) -> Self {
         MaybeUninitField { parent, child }
     }
 
@@ -21,7 +21,7 @@ pub fn new(parent: &'a mut MaybeUninit<T>, child: *mut U) -> Self {
     /// Because the `MaybeUninitField` remembers the containing object,
     /// it is possible to use it in foreign APIs that initialize the
     /// child.
-    pub fn parent(f: &Self) -> *const T {
+    pub const fn parent(f: &Self) -> *const T {
         f.parent.as_ptr()
     }
 
@@ -30,7 +30,7 @@ pub fn parent(f: &Self) -> *const T {
     /// Because the `MaybeUninitField` remembers the containing object,
     /// it is possible to use it in foreign APIs that initialize the
     /// child.
-    pub fn parent_mut(f: &mut Self) -> *mut T {
+    pub const fn parent_mut(f: &mut Self) -> *mut T {
         f.parent.as_mut_ptr()
     }
 }
-- 
2.51.0


