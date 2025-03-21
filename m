Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C4C3DC36000
	for <qemu-devel@archiver.kernel.org>; Fri, 21 Mar 2025 18:40:12 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tvhFg-00050H-6l; Fri, 21 Mar 2025 14:37:52 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1tvhEn-0003K0-10
 for qemu-devel@nongnu.org; Fri, 21 Mar 2025 14:37:03 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1tvhEk-000774-S0
 for qemu-devel@nongnu.org; Fri, 21 Mar 2025 14:36:56 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1742582214;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=LPHhMj1Xxuz7O/11AXvujJmBVBPeJBVatLFwLDa/u7s=;
 b=DBd0CQ8A8vvF7DjRYmtiHlmMae4ytfpgZgUvPco0Vljzj5GM4fkJii10aaKgOMYZUFHqc4
 3800xpMClv1/lF5KoAos76WoCbD8p25xP9fVSJK07Kxr2QHPLnM9vbzRsL8NXKcHF6RWt1
 GFDSMyVcq2yzttBqP0QafPWtt9XJdQM=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-120-CLJoKt3MPjCNDMgXjJ4FHw-1; Fri, 21 Mar 2025 14:36:52 -0400
X-MC-Unique: CLJoKt3MPjCNDMgXjJ4FHw-1
X-Mimecast-MFC-AGG-ID: CLJoKt3MPjCNDMgXjJ4FHw_1742582212
Received: by mail-wr1-f69.google.com with SMTP id
 ffacd0b85a97d-39126c3469fso1023546f8f.3
 for <qemu-devel@nongnu.org>; Fri, 21 Mar 2025 11:36:52 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1742582211; x=1743187011;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=LPHhMj1Xxuz7O/11AXvujJmBVBPeJBVatLFwLDa/u7s=;
 b=EsuvuM/i5w1Rmoh3e5ABoiIUFaBOVG4yhRGWeaUkscEKfBLO07RnI5VdUkoz2U9tyg
 ahPO3Ts/wVSeRJ6jWKf2yHtXDvocRou4j2G4O5z92dVQbsk2vBkW2FgZjnuxSJI4M3I1
 Josykky40eTHGPMqUixnEE9psX7i9rxDOgjnjb7WfsxwQz4/1AWm8jtHwS+A0zpaBCkT
 UyGclESEfqxH7WMLJJ53ZtE8oA+fCQi4K25lPKRei2piwSidEGVPjqyuHWrESMVWJs2o
 K+MWEVJ1InHLJE0aMJsdZizNVZp8qV/vptF6+FjMNdcPEaT/2KyslUnzOJwNSYlBRDk1
 KFRA==
X-Gm-Message-State: AOJu0YwLFXhqfAuxHCROhH1LLe78lh6p2ztHq8ZMKaIe/OwPcy54z1gx
 ayd/ObzxtGTuPwX364cwM0qkgPpnESZst7nCqyLyOKH9GnLYk0KJVJ6YeNLaRo8lkuVvNoeRVbs
 PgK5oTcnyNBFnckT4nYckpJZXvRZsJapr6OlUrde9X2veNFTUcHAkvzWu+54VML0m0rxOSdAtW0
 fuHPzCJ37uPf2IEyTCNcCQjCF/0hS89N6bVP3c
X-Gm-Gg: ASbGncuk+/oqwWBLJ/xf+PJklmhMxPxAdy7alDqUAwyumsVCXf8/UkSPjEjjCYnq7/X
 oPzFQm9jfeVRoC+sKkWTugV0NaLAzgjio0tghfCTODBdW6tm8FUtHKPORZQsiA79lG3x4pQWTBZ
 nPGbOpgpLZnM9r2Htrhr/dBACrW0ZOYcrkwsS7LGZ+aHTbYY4Fw6AhjCCH7PbPmKzERpxl1CSCN
 IySJ0VnqYnUrCWr/ANZJUB9R+CNCUHum6JDucSPRh2jGPxVXzfbDB3ifD8Ia3nx8jLKB9GL5oM2
 eCVhOGLm5MOYpsfl+eB2
X-Received: by 2002:a05:6000:1a8d:b0:391:489a:ce12 with SMTP id
 ffacd0b85a97d-3997f90de52mr4418660f8f.26.1742582210923; 
 Fri, 21 Mar 2025 11:36:50 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGsNmwLLghu4EcbJ3YotQlVIDZzKeabA7qMNIYunBBkFnu4Oi5b18ce2XGGYFpYXY/nD/sMpA==
X-Received: by 2002:a05:6000:1a8d:b0:391:489a:ce12 with SMTP id
 ffacd0b85a97d-3997f90de52mr4418640f8f.26.1742582210383; 
 Fri, 21 Mar 2025 11:36:50 -0700 (PDT)
Received: from [192.168.122.1] ([151.49.194.153])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3997f9957aasm3096706f8f.10.2025.03.21.11.36.47
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 21 Mar 2025 11:36:48 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Cc: Zhao Liu <zhao1.liu@intel.com>
Subject: [PULL 20/24] rust/vmstate: Add unit test for vmstate_{of|struct} macro
Date: Fri, 21 Mar 2025 19:35:52 +0100
Message-ID: <20250321183556.155097-21-pbonzini@redhat.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250321183556.155097-1-pbonzini@redhat.com>
References: <20250321183556.155097-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -23
X-Spam_score: -2.4
X-Spam_bar: --
X-Spam_report: (-2.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.332,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001,
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

From: Zhao Liu <zhao1.liu@intel.com>

Add a unit test to cover some patterns accepted by vmstate_of and
vmstate_struct macros, which correspond to the following C version
macros:

 * VMSTATE_BOOL_V
 * VMSTATE_U64
 * VMSTATE_STRUCT_VARRAY_UINT8
 * (no C version) MULTIPLY variant of VMSTATE_STRUCT_VARRAY_UINT32
 * VMSTATE_ARRAY

Signed-off-by: Zhao Liu <zhao1.liu@intel.com>
Link: https://lore.kernel.org/r/20250318130219.1799170-13-zhao1.liu@intel.com
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 rust/qemu-api/tests/vmstate_tests.rs | 158 ++++++++++++++++++++++++++-
 1 file changed, 156 insertions(+), 2 deletions(-)

diff --git a/rust/qemu-api/tests/vmstate_tests.rs b/rust/qemu-api/tests/vmstate_tests.rs
index eb1bb2f8a04..2c3301e02af 100644
--- a/rust/qemu-api/tests/vmstate_tests.rs
+++ b/rust/qemu-api/tests/vmstate_tests.rs
@@ -5,10 +5,14 @@
 use std::{ffi::CStr, mem::size_of, slice};
 
 use qemu_api::{
-    bindings::{vmstate_info_int8, vmstate_info_uint8, vmstate_info_unused_buffer, VMStateFlags},
+    bindings::{
+        vmstate_info_bool, vmstate_info_int64, vmstate_info_int8, vmstate_info_uint64,
+        vmstate_info_uint8, vmstate_info_unused_buffer, VMStateFlags,
+    },
     c_str,
+    cell::BqlCell,
     vmstate::{VMStateDescription, VMStateField},
-    vmstate_fields, vmstate_of, vmstate_unused,
+    vmstate_fields, vmstate_of, vmstate_struct, vmstate_unused,
     zeroable::Zeroable,
 };
 
@@ -132,3 +136,153 @@ fn test_vmstate_varray_multiply() {
     // The last VMStateField in VMSTATE_FOOA.
     assert_eq!(foo_fields[4].flags, VMStateFlags::VMS_END);
 }
+
+// =========================== Test VMSTATE_FOOB ===========================
+// Test the use cases of the vmstate macro, corresponding to the following C
+// macro variants:
+//   * VMSTATE_FOOB:
+//     - VMSTATE_BOOL_V
+//     - VMSTATE_U64
+//     - VMSTATE_STRUCT_VARRAY_UINT8
+//     - (no C version) MULTIPLY variant of VMSTATE_STRUCT_VARRAY_UINT32
+//     - VMSTATE_ARRAY
+#[repr(C)]
+#[derive(qemu_api_macros::offsets)]
+struct FooB {
+    arr_a: [FooA; FOO_ARRAY_MAX],
+    num_a: u8,
+    arr_a_mul: [FooA; FOO_ARRAY_MAX],
+    num_a_mul: u32,
+    wrap: BqlCell<u64>,
+    val: bool,
+    // FIXME: Use Timer array. Now we can't since it's hard to link savevm.c to test.
+    arr_i64: [i64; FOO_ARRAY_MAX],
+}
+
+static VMSTATE_FOOB: VMStateDescription = VMStateDescription {
+    name: c_str!("foo_b").as_ptr(),
+    version_id: 2,
+    minimum_version_id: 1,
+    fields: vmstate_fields! {
+        vmstate_of!(FooB, val).with_version_id(2),
+        vmstate_of!(FooB, wrap),
+        vmstate_struct!(FooB, arr_a[0 .. num_a], &VMSTATE_FOOA, FooA).with_version_id(1),
+        vmstate_struct!(FooB, arr_a_mul[0 .. num_a_mul * 32], &VMSTATE_FOOA, FooA).with_version_id(2),
+        vmstate_of!(FooB, arr_i64),
+    },
+    ..Zeroable::ZERO
+};
+
+#[test]
+fn test_vmstate_bool_v() {
+    let foo_fields: &[VMStateField] = unsafe { slice::from_raw_parts(VMSTATE_FOOB.fields, 6) };
+
+    // 1st VMStateField ("val") in VMSTATE_FOOB (corresponding to VMSTATE_BOOL_V)
+    assert_eq!(
+        unsafe { CStr::from_ptr(foo_fields[0].name) }.to_bytes_with_nul(),
+        b"val\0"
+    );
+    assert_eq!(foo_fields[0].offset, 136);
+    assert_eq!(foo_fields[0].num_offset, 0);
+    assert_eq!(foo_fields[0].info, unsafe { &vmstate_info_bool });
+    assert_eq!(foo_fields[0].version_id, 2);
+    assert_eq!(foo_fields[0].size, 1);
+    assert_eq!(foo_fields[0].num, 0);
+    assert_eq!(foo_fields[0].flags, VMStateFlags::VMS_SINGLE);
+    assert!(foo_fields[0].vmsd.is_null());
+    assert!(foo_fields[0].field_exists.is_none());
+}
+
+#[test]
+fn test_vmstate_uint64() {
+    let foo_fields: &[VMStateField] = unsafe { slice::from_raw_parts(VMSTATE_FOOB.fields, 6) };
+
+    // 2nd VMStateField ("wrap") in VMSTATE_FOOB (corresponding to VMSTATE_U64)
+    assert_eq!(
+        unsafe { CStr::from_ptr(foo_fields[1].name) }.to_bytes_with_nul(),
+        b"wrap\0"
+    );
+    assert_eq!(foo_fields[1].offset, 128);
+    assert_eq!(foo_fields[1].num_offset, 0);
+    assert_eq!(foo_fields[1].info, unsafe { &vmstate_info_uint64 });
+    assert_eq!(foo_fields[1].version_id, 0);
+    assert_eq!(foo_fields[1].size, 8);
+    assert_eq!(foo_fields[1].num, 0);
+    assert_eq!(foo_fields[1].flags, VMStateFlags::VMS_SINGLE);
+    assert!(foo_fields[1].vmsd.is_null());
+    assert!(foo_fields[1].field_exists.is_none());
+}
+
+#[test]
+fn test_vmstate_struct_varray_uint8() {
+    let foo_fields: &[VMStateField] = unsafe { slice::from_raw_parts(VMSTATE_FOOB.fields, 6) };
+
+    // 3rd VMStateField ("arr_a") in VMSTATE_FOOB (corresponding to
+    // VMSTATE_STRUCT_VARRAY_UINT8)
+    assert_eq!(
+        unsafe { CStr::from_ptr(foo_fields[2].name) }.to_bytes_with_nul(),
+        b"arr_a\0"
+    );
+    assert_eq!(foo_fields[2].offset, 0);
+    assert_eq!(foo_fields[2].num_offset, 60);
+    assert!(foo_fields[2].info.is_null()); // VMSTATE_STRUCT_VARRAY_UINT8 doesn't set info field.
+    assert_eq!(foo_fields[2].version_id, 1);
+    assert_eq!(foo_fields[2].size, 20);
+    assert_eq!(foo_fields[2].num, 0);
+    assert_eq!(
+        foo_fields[2].flags.0,
+        VMStateFlags::VMS_STRUCT.0 | VMStateFlags::VMS_VARRAY_UINT8.0
+    );
+    assert_eq!(foo_fields[2].vmsd, &VMSTATE_FOOA);
+    assert!(foo_fields[2].field_exists.is_none());
+}
+
+#[test]
+fn test_vmstate_struct_varray_uint32_multiply() {
+    let foo_fields: &[VMStateField] = unsafe { slice::from_raw_parts(VMSTATE_FOOB.fields, 6) };
+
+    // 4th VMStateField ("arr_a_mul") in VMSTATE_FOOB (corresponding to
+    // (no C version) MULTIPLY variant of VMSTATE_STRUCT_VARRAY_UINT32)
+    assert_eq!(
+        unsafe { CStr::from_ptr(foo_fields[3].name) }.to_bytes_with_nul(),
+        b"arr_a_mul\0"
+    );
+    assert_eq!(foo_fields[3].offset, 64);
+    assert_eq!(foo_fields[3].num_offset, 124);
+    assert!(foo_fields[3].info.is_null()); // VMSTATE_STRUCT_VARRAY_UINT8 doesn't set info field.
+    assert_eq!(foo_fields[3].version_id, 2);
+    assert_eq!(foo_fields[3].size, 20);
+    assert_eq!(foo_fields[3].num, 32);
+    assert_eq!(
+        foo_fields[3].flags.0,
+        VMStateFlags::VMS_STRUCT.0
+            | VMStateFlags::VMS_VARRAY_UINT32.0
+            | VMStateFlags::VMS_MULTIPLY_ELEMENTS.0
+    );
+    assert_eq!(foo_fields[3].vmsd, &VMSTATE_FOOA);
+    assert!(foo_fields[3].field_exists.is_none());
+}
+
+#[test]
+fn test_vmstate_macro_array() {
+    let foo_fields: &[VMStateField] = unsafe { slice::from_raw_parts(VMSTATE_FOOB.fields, 6) };
+
+    // 5th VMStateField ("arr_i64") in VMSTATE_FOOB (corresponding to
+    // VMSTATE_ARRAY)
+    assert_eq!(
+        unsafe { CStr::from_ptr(foo_fields[4].name) }.to_bytes_with_nul(),
+        b"arr_i64\0"
+    );
+    assert_eq!(foo_fields[4].offset, 144);
+    assert_eq!(foo_fields[4].num_offset, 0);
+    assert_eq!(foo_fields[4].info, unsafe { &vmstate_info_int64 });
+    assert_eq!(foo_fields[4].version_id, 0);
+    assert_eq!(foo_fields[4].size, 8);
+    assert_eq!(foo_fields[4].num, FOO_ARRAY_MAX as i32);
+    assert_eq!(foo_fields[4].flags, VMStateFlags::VMS_ARRAY);
+    assert!(foo_fields[4].vmsd.is_null());
+    assert!(foo_fields[4].field_exists.is_none());
+
+    // The last VMStateField in VMSTATE_FOOB.
+    assert_eq!(foo_fields[5].flags, VMStateFlags::VMS_END);
+}
-- 
2.49.0


