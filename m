Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1B044C36002
	for <qemu-devel@archiver.kernel.org>; Fri, 21 Mar 2025 18:39:33 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tvhFT-0004GG-UV; Fri, 21 Mar 2025 14:37:41 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1tvhEp-0003MW-DL
 for qemu-devel@nongnu.org; Fri, 21 Mar 2025 14:37:07 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1tvhEn-00077t-JB
 for qemu-devel@nongnu.org; Fri, 21 Mar 2025 14:36:59 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1742582217;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=tf/SDamM19yAM6CCTmMmuE8QR5FpAhIVUEPhMergYRQ=;
 b=UBbrxKB1zz4JzjmflTCMojXJAJcyRk8lFy1qr7TKtU0LpXpFntO1S8N2urKLIpzaypA1oK
 fQMAvx0njC7FK4Wf8QmO3ew79mgj58cnMUOzUxol7Nprrg9jpMQ4QxyQZwDYb4pLNfnZxG
 xLNnIpILR0YZ5cbWpYHzxwWW7lWi3nQ=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-146-joKmhasPNBePNnQ9Kiy2ZA-1; Fri, 21 Mar 2025 14:36:55 -0400
X-MC-Unique: joKmhasPNBePNnQ9Kiy2ZA-1
X-Mimecast-MFC-AGG-ID: joKmhasPNBePNnQ9Kiy2ZA_1742582214
Received: by mail-wr1-f72.google.com with SMTP id
 ffacd0b85a97d-3913f97d115so1123890f8f.0
 for <qemu-devel@nongnu.org>; Fri, 21 Mar 2025 11:36:55 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1742582213; x=1743187013;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=tf/SDamM19yAM6CCTmMmuE8QR5FpAhIVUEPhMergYRQ=;
 b=w2QjfPASnscHGQVTxm1UNAEGCj/xt9FF9a0In5u63A/k4G2o0mrh3MJRw5ySaUU24o
 krR1W1bGsUijyKSfmgT62p/e2YpFnWfDKh6G2cFsecDvpslXafTt5tB0ifLYlYOkV/Ti
 6+fECPQPOnS4qshFbXiT2A5KDQeaOxNLLU9lkcJSNH+FxVgyotQhr4M5Ggatu7c39cjI
 hZeoRgqPKXzgF/sZpxbJhN4FGv8I5A1Qh/l2utIPqbE1kihjlG8W1/KeCrXb6xlJ2KKE
 jf0yml2NyCFbsRV9YRmsRXn/VW5Dg8EzyxB9lz2b2FeuHokkPcIJ5a7X8yxCvrZlZ4yR
 WVRw==
X-Gm-Message-State: AOJu0Yzw/gPwHuEgRJGJDyXy8PAzBspUgrJSO/Czxny3dxpLob33SWYf
 AIf3R9dmuvvbtYRdogTipyZy2dz4DeXP81UWtpJQim2tK8ZDqq5EAwd4JXpfBF0VVoqGt7NsQZx
 lTjm0xpmDd7ywNVnl06grFXGKLHNxTJXn27fvOpqSlXm4mxjRVK/fZ6N2RHUH59jXD2HCFRts7m
 W5OF4OveIYqjhPh0leDvmujKRrMhhb5Fkzkxdh
X-Gm-Gg: ASbGncsoS10ftUbgoFbmUB1Bje/Qnqk/Yu+n2Q5wPpbUOIfSUL3DquTr3jIdDJHwt+T
 pY46M5Wkp+/ZFos6++roAOa7fVk9XvTVP9hYfDif92LJxN8XlsIOIEmjtM0M/1zC02mDjH7dM2e
 2BfK4vwn/RrLYj9YIWWUvSCmGCdq/6yJYVMpZmj4A9odpj8aGGkwnr2tyu9NSKGJPVK3FqttpFQ
 bFibsz0pdmFWtwv5N2lnRkC8CCqJuP+W/DZTPzgNrxPMrHJBl1dXgYNckUslwKKsc8NvIhniA0k
 Ato4zaXtSJorhai7N0mg
X-Received: by 2002:a5d:5f4b:0:b0:38d:ba8e:7327 with SMTP id
 ffacd0b85a97d-3997f900873mr4709398f8f.8.1742582213217; 
 Fri, 21 Mar 2025 11:36:53 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFm8OPdeBraUHB8MTmakWzrOd6aOcLN0/FDGDD1nY/YJQI4ypbSpHkyuWUhwJ5FkDovuHR8dA==
X-Received: by 2002:a5d:5f4b:0:b0:38d:ba8e:7327 with SMTP id
 ffacd0b85a97d-3997f900873mr4709373f8f.8.1742582212648; 
 Fri, 21 Mar 2025 11:36:52 -0700 (PDT)
Received: from [192.168.122.1] ([151.49.194.153])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3997f9a3c7fsm3096780f8f.34.2025.03.21.11.36.52
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 21 Mar 2025 11:36:52 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Cc: Zhao Liu <zhao1.liu@intel.com>
Subject: [PULL 22/24] rust/vmstate: Add unit test for vmstate_validate
Date: Fri, 21 Mar 2025 19:35:54 +0100
Message-ID: <20250321183556.155097-23-pbonzini@redhat.com>
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

Add a unit test for vmstate_validate, which corresponds to the C version
macro: VMSTATE_VALIDATE.

Signed-off-by: Zhao Liu <zhao1.liu@intel.com>
Link: https://lore.kernel.org/r/20250318130219.1799170-15-zhao1.liu@intel.com
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 rust/qemu-api/tests/vmstate_tests.rs | 82 +++++++++++++++++++++++++++-
 1 file changed, 80 insertions(+), 2 deletions(-)

diff --git a/rust/qemu-api/tests/vmstate_tests.rs b/rust/qemu-api/tests/vmstate_tests.rs
index 027b2266753..b8d8b45b19d 100644
--- a/rust/qemu-api/tests/vmstate_tests.rs
+++ b/rust/qemu-api/tests/vmstate_tests.rs
@@ -2,7 +2,7 @@
 // Author(s): Zhao Liu <zhai1.liu@intel.com>
 // SPDX-License-Identifier: GPL-2.0-or-later
 
-use std::{ffi::CStr, mem::size_of, ptr::NonNull, slice};
+use std::{ffi::CStr, mem::size_of, os::raw::c_void, ptr::NonNull, slice};
 
 use qemu_api::{
     bindings::{
@@ -13,7 +13,7 @@
     cell::{BqlCell, Opaque},
     impl_vmstate_forward,
     vmstate::{VMStateDescription, VMStateField},
-    vmstate_fields, vmstate_of, vmstate_struct, vmstate_unused,
+    vmstate_fields, vmstate_of, vmstate_struct, vmstate_unused, vmstate_validate,
     zeroable::Zeroable,
 };
 
@@ -397,3 +397,81 @@ fn test_vmstate_macro_array_of_pointer_wrapped() {
     // The last VMStateField in VMSTATE_FOOC.
     assert_eq!(foo_fields[4].flags, VMStateFlags::VMS_END);
 }
+
+// =========================== Test VMSTATE_FOOD ===========================
+// Test the use cases of the vmstate macro, corresponding to the following C
+// macro variants:
+//   * VMSTATE_FOOD:
+//     - VMSTATE_VALIDATE
+
+// Add more member fields when vmstate_of/vmstate_struct support "test"
+// parameter.
+struct FooD;
+
+impl FooD {
+    fn validate_food_0(&self, _version_id: u8) -> bool {
+        true
+    }
+
+    fn validate_food_1(_state: &FooD, _version_id: u8) -> bool {
+        false
+    }
+}
+
+fn validate_food_2(_state: &FooD, _version_id: u8) -> bool {
+    true
+}
+
+static VMSTATE_FOOD: VMStateDescription = VMStateDescription {
+    name: c_str!("foo_d").as_ptr(),
+    version_id: 3,
+    minimum_version_id: 1,
+    fields: vmstate_fields! {
+        vmstate_validate!(FooD, c_str!("foo_d_0"), FooD::validate_food_0),
+        vmstate_validate!(FooD, c_str!("foo_d_1"), FooD::validate_food_1),
+        vmstate_validate!(FooD, c_str!("foo_d_2"), validate_food_2),
+    },
+    ..Zeroable::ZERO
+};
+
+#[test]
+fn test_vmstate_validate() {
+    let foo_fields: &[VMStateField] = unsafe { slice::from_raw_parts(VMSTATE_FOOD.fields, 4) };
+    let mut foo_d = FooD;
+    let foo_d_p = std::ptr::addr_of_mut!(foo_d).cast::<c_void>();
+
+    // 1st VMStateField in VMSTATE_FOOD
+    assert_eq!(
+        unsafe { CStr::from_ptr(foo_fields[0].name) }.to_bytes_with_nul(),
+        b"foo_d_0\0"
+    );
+    assert_eq!(foo_fields[0].offset, 0);
+    assert_eq!(foo_fields[0].num_offset, 0);
+    assert!(foo_fields[0].info.is_null());
+    assert_eq!(foo_fields[0].version_id, 0);
+    assert_eq!(foo_fields[0].size, 0);
+    assert_eq!(foo_fields[0].num, 0);
+    assert_eq!(
+        foo_fields[0].flags.0,
+        VMStateFlags::VMS_ARRAY.0 | VMStateFlags::VMS_MUST_EXIST.0
+    );
+    assert!(foo_fields[0].vmsd.is_null());
+    assert!(unsafe { foo_fields[0].field_exists.unwrap()(foo_d_p, 0) });
+
+    // 2nd VMStateField in VMSTATE_FOOD
+    assert_eq!(
+        unsafe { CStr::from_ptr(foo_fields[1].name) }.to_bytes_with_nul(),
+        b"foo_d_1\0"
+    );
+    assert!(!unsafe { foo_fields[1].field_exists.unwrap()(foo_d_p, 1) });
+
+    // 3rd VMStateField in VMSTATE_FOOD
+    assert_eq!(
+        unsafe { CStr::from_ptr(foo_fields[2].name) }.to_bytes_with_nul(),
+        b"foo_d_2\0"
+    );
+    assert!(unsafe { foo_fields[2].field_exists.unwrap()(foo_d_p, 2) });
+
+    // The last VMStateField in VMSTATE_FOOD.
+    assert_eq!(foo_fields[3].flags, VMStateFlags::VMS_END);
+}
-- 
2.49.0


