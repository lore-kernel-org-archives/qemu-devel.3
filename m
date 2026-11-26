Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 324A5606A31C
	for <qemu-devel@archiver.kernel.org>; Thu, 26 Nov 2026 23:18:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=AAWiKwde;
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=google header.b=XxMUi5YK
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xWiht-00087Q-Ns; Thu, 26 Nov 2026 18:16:49 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1xWihp-00085h-PF
 for qemu-devel@nongnu.org; Thu, 26 Nov 2026 18:16:46 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1xWihn-00061x-Oq
 for qemu-devel@nongnu.org; Thu, 26 Nov 2026 18:16:45 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1795735003;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=sJvie1o+hdDvsHvqpC1jKetF2TiTISIEGLTx8zoN3dU=;
 b=AAWiKwdeDN+etxZ500bU8MLmjenV4OJVP4BwKNkrRXlijqGE9ivTH74GgjTR+0aBGJrRao
 VoI5IHYONGKDiwoG47nmM8i9aJyDJNM49MV0cfuGRSlwcV64gsOuPCdqwpuf/aLrPCCknf
 0qsl6zvfnUFMLpMCmHJ/A+L7Z9X1XCM=
Received: from mail-qt1-f200.google.com (mail-qt1-f200.google.com
 [209.85.160.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-437-m9GeVHMpMIipTrg95OFdhQ-1; Thu, 26 Nov 2026 23:16:40 +0000
X-MC-Unique: m9GeVHMpMIipTrg95OFdhQ-1
X-Mimecast-MFC-AGG-ID: m9GeVHMpMIipTrg95OFdhQ_1795735000
Received: by mail-qt1-f200.google.com with SMTP id
 d75a77b69052e-55d2c49c3d9so98441371cf.3
 for <qemu-devel@nongnu.org>; Thu, 26 Nov 2026 15:16:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1795735000; x=1796339800; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=sJvie1o+hdDvsHvqpC1jKetF2TiTISIEGLTx8zoN3dU=;
 b=XxMUi5YKvPEyFUfNGaCOrvELheN8rxWmG+PwQHMhrqF5XLC1BRPokBg2QCQWhYHVhR
 J4Dmc/whvmd517deay/RNzDgfM7w47sO1aTxfksnuvqRgQXbYf1sVvxJ2u9L6bZqTBlA
 U1s28JyNRwHDpcFaoM9EuJYFPqF/7R38v97/pFqiDFMshbBQKbacJ37UP+vwlYAelS6f
 OIdqrEjxAzqljgQlWaTIYYGXkiHx1qNOtUgAToK8WHgptGSPj1VR84K5BrZXYyquYfdf
 P+WIiijmOryv2wBeMPncoyqOWG4HAWMCz3JQ580ORK0yfdqbMC7NuYssRTKufEhB5bsO
 Sm7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1795735000; x=1796339800;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=sJvie1o+hdDvsHvqpC1jKetF2TiTISIEGLTx8zoN3dU=;
 b=viC+KqnZjdHb/rPcnixtHSAcCTvsoKj+oGxHgkzVIXRb0jsGUJhKAVmYieOw/9Nqib
 5FLWhOOxeHqd02OJBGaUGruElzurPoDqi3zYw74o5lRw1gk0JwsFTrwTEyqynr8V7uFv
 w6CXtgBdCS8jI800K82BxRjTD6dzEERl+wVzibFl0KCJqCl128FmLf/DpFNRX3BBBK5n
 dgIipcEYsEjIv5s5R9N54JFBywNeuE+cRqtyw7HxMMOhEb5kJW/L4tpTwDfwlEUswt9I
 07/Oo4Jlmxv9y8oRY5FN8b8q3YAaf7iY5KkCUV1/yRyOtpnrn9RVE7vsX6YZCwoBA8bl
 vuTQ==
X-Gm-Message-State: APuU4Z/iNbA2LD4IyReJj23GDH6LZLQfGRqRu8YvMOZwM1C7MUwWimc7
 NPgHt6hB/1JjUgUG4XEBbPIYdQKgs67odSs+voI0wVuw/TU4kyyjsXvV4pM5vyPe8QaXRqwHlWd
 NC90wpylV1DNr5hBYfXPhvR6qd4Aqr5haw02ElEIshCI/MUjoHvF3T/wzl2trGIrYp8I4BAYLz3
 nmbXeljT9db0niE+hRuUDXFh08lWAj/CU5irzAUw==
X-Gm-Gg: AZFdTZfZIv0DTvc4Xj5FsblRgWJMQDR8+rzPkY7FhXuMN1RAI64+1QOzp1XpoLyatLJ
 fmGJpI3zNwy+0o7BS5S/jigNXhnaUtdIQY9aBtn0b8ObHihMIByfhEZIyXKAsyOgOqOUJ88Uqdy
 fmbxg4nuD06UueJZkaHU5ju78OBFj1T2ObtBDcY3p5a44KuiRfY0g5XlJQaghdcYA4C6J/jKyw4
 fjURxzcNHI6Wdc+x+vpau290CB7BvNrTYl/C4x/nG8pLJ2NTnYbXq/+tppZDVIIa1dLC0wjyls1
 sz/A4ABxheufUOmQQpViNtsJmJQNIQnAQwTiekNzuzmyNByLnQ6zFwhT9RVKMF8FWqrPm2oCoAM
 bVeNYk08kph0aiKb4jEBG4ti97VnH9U4O4UVgGU1OlM8A
X-Received: by 2002:a05:622a:248c:b0:55d:3350:d270 with SMTP id
 d75a77b69052e-55d769f5705mr453489231cf.35.1795735000110; 
 Thu, 26 Nov 2026 15:16:40 -0800 (PST)
X-Received: by 2002:a05:622a:248c:b0:55d:3350:d270 with SMTP id
 d75a77b69052e-55d769f5705mr453488431cf.35.1795734999400; 
 Thu, 26 Nov 2026 15:16:39 -0800 (PST)
Received: from localhost ([142.188.212.246]) by smtp.gmail.com with ESMTPSA id
 d75a77b69052e-55dcdd1a2c6sm4502181cf.20.2026.11.26.15.16.37
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 26 Nov 2026 15:16:38 -0800 (PST)
From: Peter Xu <peterx@redhat.com>
To: qemu-devel@nongnu.org
Cc: Juraj Marcin <jmarcin@redhat.com>,
 Peter Maydell <peter.maydell@linaro.org>, peterx@redhat.com,
 Fabiano Rosas <farosas@suse.de>, Gavin Shan <gshan@redhat.com>,
 Zhao Liu <zhao1.liu@intel.com>
Subject: [PATCH for-12.0 v2 3/9] rust/migration: Remove vmstate_validate!()
 macro and test
Date: Thu, 26 Nov 2026 18:16:25 -0500
Message-ID: <20261126231631.3392756-4-peterx@redhat.com>
X-Mailer: git-send-email 2.56.0
In-Reply-To: <20261126231631.3392756-1-peterx@redhat.com>
References: <20261126231631.3392756-1-peterx@redhat.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
X-Spam-Status: No, score=-18.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

From: Zhao Liu <zhao1.liu@intel.com>

We have moved all users (in Rust side) to other API, now they're never
used.

After the related test (originally FOOD) was removed, rename FOOE to
new FOOD test.

Suggested-by: Peter Xu <peterx@redhat.com>
Signed-off-by: Zhao Liu <zhao1.liu@intel.com>
Link: https://lore.kernel.org/r/20261124095814.437738-4-zhao1.liu@intel.com
Signed-off-by: Peter Xu <peterx@redhat.com>
---
 rust/migration/src/prelude.rs     |  1 -
 rust/migration/src/vmstate.rs     | 17 ------
 rust/tests/tests/vmstate_tests.rs | 93 +++----------------------------
 3 files changed, 8 insertions(+), 103 deletions(-)

diff --git a/rust/migration/src/prelude.rs b/rust/migration/src/prelude.rs
index 797e7ec59d..e2cbbda43e 100644
--- a/rust/migration/src/prelude.rs
+++ b/rust/migration/src/prelude.rs
@@ -16,4 +16,3 @@
 pub use crate::vmstate_of;
 pub use crate::vmstate_subsections;
 pub use crate::vmstate_unused;
-pub use crate::vmstate_validate;
diff --git a/rust/migration/src/vmstate.rs b/rust/migration/src/vmstate.rs
index 0b05db4e70..ec8b712cbf 100644
--- a/rust/migration/src/vmstate.rs
+++ b/rust/migration/src/vmstate.rs
@@ -384,23 +384,6 @@ macro_rules! vmstate_fields {
     }}
 }
 
-#[doc(alias = "VMSTATE_VALIDATE")]
-#[macro_export]
-macro_rules! vmstate_validate {
-    ($struct_name:ty, $test_name:expr, $test_fn:expr $(,)?) => {
-        $crate::bindings::VMStateField {
-            name: ::std::ffi::CStr::as_ptr($test_name),
-            field_exists: $crate::vmstate_exist_fn!($struct_name, $test_fn),
-            flags: $crate::bindings::VMStateFlags(
-                $crate::bindings::VMStateFlags::VMS_MUST_EXIST.0
-                    | $crate::bindings::VMStateFlags::VMS_NO_STATE.0,
-            ),
-            num: 0, // 0 elements: no data, only run test_fn callback
-            ..::common::zeroable::Zeroable::ZERO
-        }
-    };
-}
-
 /// Helper macro to allow using a struct in [`vmstate_of!`]
 ///
 /// # Safety
diff --git a/rust/tests/tests/vmstate_tests.rs b/rust/tests/tests/vmstate_tests.rs
index b680cfd3c7..9dbbb848b8 100644
--- a/rust/tests/tests/vmstate_tests.rs
+++ b/rust/tests/tests/vmstate_tests.rs
@@ -411,106 +411,29 @@ fn test_vmstate_macro_array_of_pointer_wrapped() {
 // Test the use cases of the vmstate macro, corresponding to the following C
 // macro variants:
 //   * VMSTATE_FOOD:
-//     - VMSTATE_VALIDATE
-
-// Add more member fields when vmstate_of support "test" parameter.
-struct FooD;
-
-impl FooD {
-    fn validate_food_0(&self, _version_id: u8) -> bool {
-        true
-    }
-
-    fn validate_food_1(_state: &FooD, _version_id: u8) -> bool {
-        false
-    }
-}
-
-fn validate_food_2(_state: &FooD, _version_id: u8) -> bool {
-    true
-}
-
-static VMSTATE_FOOD: VMStateDescription<FooD> = VMStateDescriptionBuilder::<FooD>::new()
-    .name(c"foo_d")
-    .version_id(3)
-    .minimum_version_id(1)
-    .fields(vmstate_fields! {
-        vmstate_validate!(FooD, c"foo_d_0", FooD::validate_food_0),
-        vmstate_validate!(FooD, c"foo_d_1", FooD::validate_food_1),
-        vmstate_validate!(FooD, c"foo_d_2", validate_food_2),
-    })
-    .build();
-
-#[test]
-fn test_vmstate_validate() {
-    let foo_fields: &[VMStateField] =
-        unsafe { slice::from_raw_parts(VMSTATE_FOOD.as_ref().fields, 4) };
-    let mut foo_d = FooD;
-    let foo_d_p = std::ptr::addr_of_mut!(foo_d).cast::<c_void>();
-
-    // 1st VMStateField in VMSTATE_FOOD
-    assert_eq!(
-        unsafe { CStr::from_ptr(foo_fields[0].name) }.to_bytes_with_nul(),
-        b"foo_d_0\0"
-    );
-    assert_eq!(foo_fields[0].offset, 0);
-    assert_eq!(foo_fields[0].num_indirect.size, 0);
-    assert!(foo_fields[0].info.is_null());
-    assert_eq!(foo_fields[0].version_id, 0);
-    assert_eq!(foo_fields[0].size, 0);
-    assert_eq!(foo_fields[0].num, 0);
-    assert_eq!(
-        foo_fields[0].flags.0,
-        VMStateFlags::VMS_NO_STATE.0 | VMStateFlags::VMS_MUST_EXIST.0
-    );
-    assert!(foo_fields[0].vmsd.is_null());
-    assert!(unsafe { foo_fields[0].field_exists.unwrap()(foo_d_p, 0) });
-
-    // 2nd VMStateField in VMSTATE_FOOD
-    assert_eq!(
-        unsafe { CStr::from_ptr(foo_fields[1].name) }.to_bytes_with_nul(),
-        b"foo_d_1\0"
-    );
-    assert!(!unsafe { foo_fields[1].field_exists.unwrap()(foo_d_p, 1) });
-
-    // 3rd VMStateField in VMSTATE_FOOD
-    assert_eq!(
-        unsafe { CStr::from_ptr(foo_fields[2].name) }.to_bytes_with_nul(),
-        b"foo_d_2\0"
-    );
-    assert!(unsafe { foo_fields[2].field_exists.unwrap()(foo_d_p, 2) });
-
-    // The last VMStateField in VMSTATE_FOOD.
-    assert_eq!(foo_fields[3].flags, VMStateFlags::VMS_END);
-}
-
-// =========================== Test VMSTATE_FOOE ===========================
-// Test the use cases of the vmstate macro, corresponding to the following C
-// macro variants:
-//   * VMSTATE_FOOE:
 //     - VMSTATE_VARRAY with a `usize` length
 #[repr(C)]
 #[derive(Default)]
-struct FooE {
+struct FooD {
     arr: [u8; FOO_ARRAY_MAX],
     num: usize,
 }
 
-static VMSTATE_FOOE: VMStateDescription<FooE> = VMStateDescriptionBuilder::<FooE>::new()
-    .name(c"foo_e")
+static VMSTATE_FOOD: VMStateDescription<FooD> = VMStateDescriptionBuilder::<FooD>::new()
+    .name(c"foo_d")
     .version_id(1)
     .minimum_version_id(1)
     .fields(vmstate_fields! {
-        vmstate_of!(FooE, arr[0 .. num]),
+        vmstate_of!(FooD, arr[0 .. num]),
     })
     .build();
 
 #[test]
 fn test_vmstate_varray_usize() {
     let foo_fields: &[VMStateField] =
-        unsafe { slice::from_raw_parts(VMSTATE_FOOE.as_ref().fields, 2) };
+        unsafe { slice::from_raw_parts(VMSTATE_FOOD.as_ref().fields, 2) };
 
-    // 1st VMStateField ("arr") in VMSTATE_FOOE
+    // 1st VMStateField ("arr") in VMSTATE_FOOD
     assert_eq!(
         unsafe { CStr::from_ptr(foo_fields[0].name) }.to_bytes_with_nul(),
         b"arr\0"
@@ -518,7 +441,7 @@ fn test_vmstate_varray_usize() {
     assert_eq!(foo_fields[0].offset, 0);
     assert_eq!(
         foo_fields[0].num_indirect.offset,
-        std::mem::offset_of!(FooE, num) as u32
+        std::mem::offset_of!(FooD, num) as u32
     );
     assert_eq!(foo_fields[0].num_indirect.size, size_of::<usize>() as u8);
     assert_eq!(foo_fields[0].info, unsafe { &vmstate_info_uint8 });
@@ -529,6 +452,6 @@ fn test_vmstate_varray_usize() {
     assert!(foo_fields[0].vmsd.is_null());
     assert!(foo_fields[0].field_exists.is_none());
 
-    // The last VMStateField in VMSTATE_FOOE.
+    // The last VMStateField in VMSTATE_FOOD.
     assert_eq!(foo_fields[1].flags, VMStateFlags::VMS_END);
 }
-- 
2.56.0


