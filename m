Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7F7E4606A31C
	for <qemu-devel@archiver.kernel.org>; Thu, 26 Nov 2026 23:18:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=RLGCcwQH;
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=google header.b=KqGrMyNP
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xWiht-000874-8H; Thu, 26 Nov 2026 18:16:49 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1xWihm-00083V-3J
 for qemu-devel@nongnu.org; Thu, 26 Nov 2026 18:16:43 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1xWihj-000617-FE
 for qemu-devel@nongnu.org; Thu, 26 Nov 2026 18:16:41 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1795734998;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=XXJ9ypDY2AOxVAmalw6mBL3xjy7VFUMWeYLCvMdaV+U=;
 b=RLGCcwQHrQ6Ax2IhlFgg86irxmYivePvXOkE/NTSv2HDQbs9kRIAbWHOfdvgMiUmlnC5um
 Fk75ZTm6mMNjlJrTdZGoX1/1RMjMFpS1B7lSc4IgEczQv/ogE5w81FUg0kOIrnFV2lnFTr
 /zWJYlvPWIyiLb6FK7qj1o6nnANYOxA=
Received: from mail-qt1-f197.google.com (mail-qt1-f197.google.com
 [209.85.160.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-675-BM9sezzKNByCf_iBIK9Ihw-1; Thu, 26 Nov 2026 23:16:36 +0000
X-MC-Unique: BM9sezzKNByCf_iBIK9Ihw-1
X-Mimecast-MFC-AGG-ID: BM9sezzKNByCf_iBIK9Ihw_1795734996
Received: by mail-qt1-f197.google.com with SMTP id
 d75a77b69052e-55d2bde4c78so102694141cf.1
 for <qemu-devel@nongnu.org>; Thu, 26 Nov 2026 15:16:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1795734996; x=1796339796; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=XXJ9ypDY2AOxVAmalw6mBL3xjy7VFUMWeYLCvMdaV+U=;
 b=KqGrMyNPnH6SL8JgmrVtp8qjwI8i5FaLXWRyQbClsAeMIrm+pddNQY5Y3dTb9G34QE
 UbF10AgrJ6fHnw9bWanLhHpfMCEV3KxR36ueojRqfgtFaiRsSIcXXMxWsNJPuVq1t2Cc
 h8ffrEMaIzkYXr6R9vELErIZJPJT9GEEG9b7CLMu1VaMbAoUhCwpQn02rnNyRT3pTa3N
 8KDacZ7ip2TVpA46Y38l2Xr13m6hsKfi793wLzx7J5oDIodnjYweEy4keUEOqxYOeH8L
 8mhczjFHcHhV6CX+uJWkJHT3y0js3wWeLW8D1XvJg1NEnAke0PLKPLBPrSPBquXxTgmD
 0l5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1795734996; x=1796339796;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=XXJ9ypDY2AOxVAmalw6mBL3xjy7VFUMWeYLCvMdaV+U=;
 b=TXApR13xkLMTixoGjQASVhcqTJ5Q71PVNT2MXC9Vw6THd2wc3SDjeVhRc7v2D74tJu
 e3bW2Gv5k3bHcs/K7jS3B0MR+QttrAIxhsCdFBkc6ELiXO8VGk2cmBcNS3mnz296i43C
 ceyImCnoGDHISWVv4osCLx52yRSZpbiWQWFzXnzZQcrcwkUa7n95sFiqVS+NyBtJIvlK
 1ScvgkTvy1i5ZKAicIK1DTPp7P+M0DI0jrMsvjqicD7c/ZeNa03vukU8g689VPX/eJQI
 6VDRs+1xLib5UDswc46mNI3W0f9RN4c5XWJbgUtaDh+OWasVXja2aFKoB6/rfmFZzJbG
 yWQg==
X-Gm-Message-State: APuU4Z+JkKrbGqPaWwS8NEsj51A4Lh9JW7tpgUtMKLOVq9Owf0Trwqra
 xQQs4DS5ZlTBu46dFgLDHGxR8ieG57wZ3quzO5AX3SjpDGKjbUscsUALHWgrBR/LgGV8gm54coC
 vOW8wbpw+gTfI7t9WbnqJQpVuli0oLK/gIYHJvbEdLF8SgJXj8AA2KbkECv+HJOrvY7fkqHTLlg
 +JvwU1c+ug6KV2Wr93ugeWH7W92tjBSBgHdBj30Q==
X-Gm-Gg: AZFdTZe/SaIZiJ8cBFqYoq4sNi9Kc+c2ocedzxZrFWnE27lUwNs2R5MZW05WGTfwKul
 mG3RWBif4t3o03Ai5pTwBSKo3pK3Y6Ez0I2clVc9aaAXtFiWL1DL7v+99grf//QVoWYmstPHjhy
 RTB1aRY3C/BLeHt63TzfejHDZ02KzKiTzdGFJBiOd6FL30yrhNTf8B99BxQ0P7gCZ90E+tkFmMA
 5LQ/jU8PulCdM/WHtOCr57V7rC3Vh0UoUrKEDncr9VzCIzx51m0CSXHw/KNFga314LCVfNgsk1x
 RlG6WffNh9+OroKYnRXGsrQ3tzqa7jqlaE+zXyNc8JU+VGRHIpNqJ2nMSZYVvvoxbSFAR/94eqJ
 jawzOon5jUHJmo1h5LqgnKBdAlu8w5AQbUwCOYDRSnsJw
X-Received: by 2002:a05:622a:313:b0:55d:1944:a2ab with SMTP id
 d75a77b69052e-55d76a5af8dmr423326741cf.49.1795734996156; 
 Thu, 26 Nov 2026 15:16:36 -0800 (PST)
X-Received: by 2002:a05:622a:313:b0:55d:1944:a2ab with SMTP id
 d75a77b69052e-55d76a5af8dmr423326121cf.49.1795734995529; 
 Thu, 26 Nov 2026 15:16:35 -0800 (PST)
Received: from localhost ([142.188.212.246]) by smtp.gmail.com with ESMTPSA id
 d75a77b69052e-55dcdd1a2c6sm4501211cf.20.2026.11.26.15.16.34
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 26 Nov 2026 15:16:34 -0800 (PST)
From: Peter Xu <peterx@redhat.com>
To: qemu-devel@nongnu.org
Cc: Juraj Marcin <jmarcin@redhat.com>,
 Peter Maydell <peter.maydell@linaro.org>, peterx@redhat.com,
 Fabiano Rosas <farosas@suse.de>, Gavin Shan <gshan@redhat.com>,
 Zhao Liu <zhao1.liu@intel.com>
Subject: [PATCH for-12.0 v2 1/9] rust/migration: Allow usize as the length of
 a varray
Date: Thu, 26 Nov 2026 18:16:23 -0500
Message-ID: <20261126231631.3392756-2-peterx@redhat.com>
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
X-Spam-Status: No, score=-23.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_PASS,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

From: Zhao Liu <zhao1.liu@intel.com>

Since commit f9f70b50e3eb ("migration: Introduce VMStateStructMember")
and commit 1f0b40dccfe5 ("Rmigration: Remove redundant flags"), the
length of a varray is no longer tied to a specific integer type.

This makes it possible to use `usize` type for varray length. It's safe
since it is used only to resolve varray lengths in the local vmstate
code and is not used for migration.

Thus, implement a "dummy" VMState for `usize` so that it can provide
VARRAY_FLAG, and panic when anyone tries to define VMStateField with
`usize` type (including integers, pointers, [usize; N], Box<usize>,
BqlCell<usize>, etc).

In addition, add a test case for such case.

Signed-off-by: Zhao Liu <zhao1.liu@intel.com>
Link: https://lore.kernel.org/r/20261124095814.437738-2-zhao1.liu@intel.com
Signed-off-by: Peter Xu <peterx@redhat.com>
---
 rust/migration/src/vmstate.rs     | 16 ++++++++--
 rust/tests/tests/vmstate_tests.rs | 49 +++++++++++++++++++++++++++++++
 2 files changed, 63 insertions(+), 2 deletions(-)

diff --git a/rust/migration/src/vmstate.rs b/rust/migration/src/vmstate.rs
index 5ed061f2ab..0b05db4e70 100644
--- a/rust/migration/src/vmstate.rs
+++ b/rust/migration/src/vmstate.rs
@@ -97,8 +97,8 @@ pub unsafe trait VMState {
 
     /// A flag that is added to another field's `VMStateField` to specify the
     /// length's type in a variable-sized array.  If this is not a supported
-    /// type for the length (i.e. if it is not `u8`, `u16`, `u32`), using it
-    /// in a call to [`vmstate_of!`](crate::vmstate_of) will cause a
+    /// type for the length (i.e. if it is not `u8`, `u16`, `u32`, `usize`),
+    /// using it in a call to [`vmstate_of!`](crate::vmstate_of) will cause a
     /// compile-time error.
     #[doc(hidden)] // https://github.com/rust-lang/rust/issues/149635
     const VARRAY_FLAG: VMStateFlags = {
@@ -256,6 +256,18 @@ unsafe impl $crate::vmstate::VMState for $type {
 impl_vmstate_scalar!(vmstate_info_uint64, u64);
 impl_vmstate_scalar!(vmstate_info_timer, util::timer::Timer);
 
+// SAFETY: BASE is never produced (any use of a usize as migrated data will
+// always result in a compile-time error). VARRAY_FLAG only tells the C code to
+// read `size_of::<usize>()` bytes (see `size_of_field_type!`) at the length's
+// offset.
+unsafe impl VMState for usize {
+    #[doc(hidden)] // https://github.com/rust-lang/rust/issues/149635
+    const BASE: VMStateField = {
+        panic!("usize cannot be migrated, use a fixed-size integer type");
+    };
+    const VARRAY_FLAG: VMStateFlags = VMStateFlags::VMS_VARRAY;
+}
+
 #[macro_export]
 macro_rules! impl_vmstate_c_struct {
     ($type:ty, $vmsd:expr) => {
diff --git a/rust/tests/tests/vmstate_tests.rs b/rust/tests/tests/vmstate_tests.rs
index 6578d54b37..b680cfd3c7 100644
--- a/rust/tests/tests/vmstate_tests.rs
+++ b/rust/tests/tests/vmstate_tests.rs
@@ -483,3 +483,52 @@ fn test_vmstate_validate() {
     // The last VMStateField in VMSTATE_FOOD.
     assert_eq!(foo_fields[3].flags, VMStateFlags::VMS_END);
 }
+
+// =========================== Test VMSTATE_FOOE ===========================
+// Test the use cases of the vmstate macro, corresponding to the following C
+// macro variants:
+//   * VMSTATE_FOOE:
+//     - VMSTATE_VARRAY with a `usize` length
+#[repr(C)]
+#[derive(Default)]
+struct FooE {
+    arr: [u8; FOO_ARRAY_MAX],
+    num: usize,
+}
+
+static VMSTATE_FOOE: VMStateDescription<FooE> = VMStateDescriptionBuilder::<FooE>::new()
+    .name(c"foo_e")
+    .version_id(1)
+    .minimum_version_id(1)
+    .fields(vmstate_fields! {
+        vmstate_of!(FooE, arr[0 .. num]),
+    })
+    .build();
+
+#[test]
+fn test_vmstate_varray_usize() {
+    let foo_fields: &[VMStateField] =
+        unsafe { slice::from_raw_parts(VMSTATE_FOOE.as_ref().fields, 2) };
+
+    // 1st VMStateField ("arr") in VMSTATE_FOOE
+    assert_eq!(
+        unsafe { CStr::from_ptr(foo_fields[0].name) }.to_bytes_with_nul(),
+        b"arr\0"
+    );
+    assert_eq!(foo_fields[0].offset, 0);
+    assert_eq!(
+        foo_fields[0].num_indirect.offset,
+        std::mem::offset_of!(FooE, num) as u32
+    );
+    assert_eq!(foo_fields[0].num_indirect.size, size_of::<usize>() as u8);
+    assert_eq!(foo_fields[0].info, unsafe { &vmstate_info_uint8 });
+    assert_eq!(foo_fields[0].version_id, 0);
+    assert_eq!(foo_fields[0].size, 1);
+    assert_eq!(foo_fields[0].num, 0);
+    assert_eq!(foo_fields[0].flags, VMStateFlags::VMS_VARRAY);
+    assert!(foo_fields[0].vmsd.is_null());
+    assert!(foo_fields[0].field_exists.is_none());
+
+    // The last VMStateField in VMSTATE_FOOE.
+    assert_eq!(foo_fields[1].flags, VMStateFlags::VMS_END);
+}
-- 
2.56.0


