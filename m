Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AF131C7EE30
	for <qemu-devel@archiver.kernel.org>; Fri, 20 Jun 2025 16:42:13 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uSeno-0006W7-DJ; Fri, 20 Jun 2025 12:41:20 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1uSenm-0006Vt-LA
 for qemu-devel@nongnu.org; Fri, 20 Jun 2025 12:41:18 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1uSenk-0000FD-P8
 for qemu-devel@nongnu.org; Fri, 20 Jun 2025 12:41:18 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1750437676;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=WkypQBs3Sa9da/mafe2M70UFin4AWq9me2xp5g/DFmw=;
 b=Ew4sqcuXLBjxn3x2uBLk1YKMeHBFkLCA74dzzcxHVuLTnA5XaQCo2r3PNHWqSy7s5K+7c5
 u1dNwSM4YbMMgPioAoanMRIXpnFSz2oxR4Po+M+fDVb9YndcU1bvGdB2fhsHftNgjNI3C5
 +RAWcU3/xyg2QJzo7V2qOvaUJil1xik=
Received: from mail-ej1-f70.google.com (mail-ej1-f70.google.com
 [209.85.218.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-568-I2aV4cJlOr63wDTsA550tw-1; Fri, 20 Jun 2025 12:41:09 -0400
X-MC-Unique: I2aV4cJlOr63wDTsA550tw-1
X-Mimecast-MFC-AGG-ID: I2aV4cJlOr63wDTsA550tw_1750437669
Received: by mail-ej1-f70.google.com with SMTP id
 a640c23a62f3a-ade6db50bb4so147884166b.2
 for <qemu-devel@nongnu.org>; Fri, 20 Jun 2025 09:41:09 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1750437668; x=1751042468;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=WkypQBs3Sa9da/mafe2M70UFin4AWq9me2xp5g/DFmw=;
 b=U2WT0hf+8py1TYgp6dYD6RiHM5PMT13PsuUNSr6E6cGpmuObHAEgZDy/43paACMyD/
 vMREc6koAXiTxhe+/uglrBQsXxBTLepkOTwqWNXlLZWUs2zTFLAQQ4D5yFZvZi+BcDtL
 BkH020I1kmL4w8XEGwrDHrp398bdStfv/PT/MeJpl6y8jTEV335prg9kwV5uDQgnsgCE
 3hFH/mDKTnDyELLSlb/BSeQ/aens5ifvafHDI3nnUV1FpoEpMhI9l8YP7G+4p7M+UNlM
 1Ub0j4Y1WGaAdZ+ESlKJbVfPYaR6gSR7IErK2Kw06rkU/aryPzXBf1l9UhoZdgwDM/Ub
 +vtw==
X-Gm-Message-State: AOJu0YyqX9YknV6ghu0xCdJu7eiRA0DZB61Jq4ib0i7eNQDzO1ARbUpI
 eVuMKwDM4no1cQBQlBWIC0n/2wOPwvaE/TjbpfXaGkFZufRNFPvq755eOMgyl56Oy9kmTXjXK42
 zP4gGmujlNwAm9k5gm9W8PlPj4gLW1dhpLMlQyG5Q1TUb6Tr/MkqvTzeAwF2W+zW3QgZodt+ux/
 qyl44XevBuIUzvRpCWtaDvzV8ZZUbOUCRaccK7x/uX
X-Gm-Gg: ASbGnctUkl7V1NIbmmEkRxxq7pvtvjxQAs4ivLgUhL5p/UN/m+sN8Aszr2VxnmEwRJY
 MJVr9Q6aSO5CxfFn1BWKkLETysFosNkeMXNyeX7pz9OdKDDGa/iZh1Yhdgb4SM7ODiV8lrQo4X7
 Od2gk7NFURZEKUa0pWLHEfAgkwTIgaQLYdyvkcZQ//gHMO/oajgk9k9OmYXxnn1jPhnoGRb0Fv3
 6TTA9gipemBg2VgiVYac0On3eDZqKACMmyF9YBwl98GnnlL9LQM6utUBJUurnxsEzHpjUiVvUt9
 PivfhTPfeNFjCJi1EYCg2cE2/w==
X-Received: by 2002:a17:907:7e95:b0:ade:4121:8d3d with SMTP id
 a640c23a62f3a-ae0579d0ccbmr317732966b.12.1750437668194; 
 Fri, 20 Jun 2025 09:41:08 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHyVuD0q70sY+MQRuj5/PBIb2e1d+8S2NhbMN1B3vLeINSEAscFnZ3dddj9YqsZBXk3zjnQPw==
X-Received: by 2002:a17:907:7e95:b0:ade:4121:8d3d with SMTP id
 a640c23a62f3a-ae0579d0ccbmr317729666b.12.1750437667616; 
 Fri, 20 Jun 2025 09:41:07 -0700 (PDT)
Received: from [192.168.122.1] ([151.62.200.93])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-ae054080dbdsm185493666b.76.2025.06.20.09.41.05
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 20 Jun 2025 09:41:05 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Cc: Zhao Liu <zhao1.liu@intel.com>
Subject: [PULL 05/24] rust: qemu_api: introduce MaybeUninit field projection
Date: Fri, 20 Jun 2025 18:40:33 +0200
Message-ID: <20250620164053.579416-6-pbonzini@redhat.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250620164053.579416-1-pbonzini@redhat.com>
References: <20250620164053.579416-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -39
X-Spam_score: -4.0
X-Spam_bar: ----
X-Spam_report: (-4.0 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.897,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

Add a macro that makes it possible to convert a MaybeUninit<> into
another MaybeUninit<> for a single field within it.  Furthermore, it is
possible to use the resulting MaybeUninitField<> in APIs that take the
parent object, such as memory_region_init_io().

This allows removing some of the undefined behavior from instance_init()
functions, though this may not be the definitive implementation.

Reviewed-by: Zhao Liu <zhao1.liu@intel.com>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 rust/qemu-api/meson.build   |  1 +
 rust/qemu-api/src/lib.rs    |  1 +
 rust/qemu-api/src/uninit.rs | 85 +++++++++++++++++++++++++++++++++++++
 3 files changed, 87 insertions(+)
 create mode 100644 rust/qemu-api/src/uninit.rs

diff --git a/rust/qemu-api/meson.build b/rust/qemu-api/meson.build
index cac8595a148..33653b4a28e 100644
--- a/rust/qemu-api/meson.build
+++ b/rust/qemu-api/meson.build
@@ -28,6 +28,7 @@ _qemu_api_rs = static_library(
       'src/qom.rs',
       'src/sysbus.rs',
       'src/timer.rs',
+      'src/uninit.rs',
       'src/vmstate.rs',
       'src/zeroable.rs',
     ],
diff --git a/rust/qemu-api/src/lib.rs b/rust/qemu-api/src/lib.rs
index 93902fc94bc..c78198f0f41 100644
--- a/rust/qemu-api/src/lib.rs
+++ b/rust/qemu-api/src/lib.rs
@@ -27,6 +27,7 @@
 pub mod qom;
 pub mod sysbus;
 pub mod timer;
+pub mod uninit;
 pub mod vmstate;
 pub mod zeroable;
 
diff --git a/rust/qemu-api/src/uninit.rs b/rust/qemu-api/src/uninit.rs
new file mode 100644
index 00000000000..04123b4ae99
--- /dev/null
+++ b/rust/qemu-api/src/uninit.rs
@@ -0,0 +1,85 @@
+//! Access fields of a [`MaybeUninit`]
+
+use std::{
+    mem::MaybeUninit,
+    ops::{Deref, DerefMut},
+};
+
+pub struct MaybeUninitField<'a, T, U> {
+    parent: &'a mut MaybeUninit<T>,
+    child: *mut U,
+}
+
+impl<'a, T, U> MaybeUninitField<'a, T, U> {
+    #[doc(hidden)]
+    pub fn new(parent: &'a mut MaybeUninit<T>, child: *mut U) -> Self {
+        MaybeUninitField { parent, child }
+    }
+
+    /// Return a constant pointer to the containing object of the field.
+    ///
+    /// Because the `MaybeUninitField` remembers the containing object,
+    /// it is possible to use it in foreign APIs that initialize the
+    /// child.
+    pub fn parent(f: &Self) -> *const T {
+        f.parent.as_ptr()
+    }
+
+    /// Return a mutable pointer to the containing object.
+    ///
+    /// Because the `MaybeUninitField` remembers the containing object,
+    /// it is possible to use it in foreign APIs that initialize the
+    /// child.
+    pub fn parent_mut(f: &mut Self) -> *mut T {
+        f.parent.as_mut_ptr()
+    }
+}
+
+impl<'a, T, U> Deref for MaybeUninitField<'a, T, U> {
+    type Target = MaybeUninit<U>;
+
+    fn deref(&self) -> &MaybeUninit<U> {
+        // SAFETY: self.child was obtained by dereferencing a valid mutable
+        // reference; the content of the memory may be invalid or uninitialized
+        // but MaybeUninit<_> makes no assumption on it
+        unsafe { &*(self.child.cast()) }
+    }
+}
+
+impl<'a, T, U> DerefMut for MaybeUninitField<'a, T, U> {
+    fn deref_mut(&mut self) -> &mut MaybeUninit<U> {
+        // SAFETY: self.child was obtained by dereferencing a valid mutable
+        // reference; the content of the memory may be invalid or uninitialized
+        // but MaybeUninit<_> makes no assumption on it
+        unsafe { &mut *(self.child.cast()) }
+    }
+}
+
+/// ```
+/// #[derive(Debug)]
+/// struct S {
+///     x: u32,
+///     y: u32,
+/// }
+///
+/// # use std::mem::MaybeUninit;
+/// # use qemu_api::{assert_match, uninit_field_mut};
+///
+/// let mut s: MaybeUninit<S> = MaybeUninit::zeroed();
+/// uninit_field_mut!(s, x).write(5);
+/// let s = unsafe { s.assume_init() };
+/// assert_match!(s, S { x: 5, y: 0 });
+/// ```
+#[macro_export]
+macro_rules! uninit_field_mut {
+    ($container:expr, $($field:tt)+) => {{
+        let container__: &mut ::std::mem::MaybeUninit<_> = &mut $container;
+        let container_ptr__ = container__.as_mut_ptr();
+
+        // SAFETY: the container is not used directly, only through a MaybeUninit<>,
+        // so the safety is delegated to the caller and to final invocation of
+        // assume_init()
+        let target__ = unsafe { std::ptr::addr_of_mut!((*container_ptr__).$($field)+) };
+        $crate::uninit::MaybeUninitField::new(container__, target__)
+    }};
+}
-- 
2.49.0


