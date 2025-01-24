Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 48E15C0218B
	for <qemu-devel@archiver.kernel.org>; Fri, 24 Jan 2025 09:47:21 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tbGHS-0000n4-73; Fri, 24 Jan 2025 04:47:15 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1tbGFz-0007Jf-Pp
 for qemu-devel@nongnu.org; Fri, 24 Jan 2025 04:45:44 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1tbGFx-0003w6-DP
 for qemu-devel@nongnu.org; Fri, 24 Jan 2025 04:45:42 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1737711940;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=WuoN8SLEI/o39maAHg/7so9lLNQmaFy/97KoTszJKKQ=;
 b=XlztEyWJRYeNvB/tiRnUhuMNFRhVKtxp7bDqZSnGCpSEbz3aUPYxmTGtzNazVkvJd5r9MJ
 5vsuySiUKwYPp22jyp6OGTzPCPkXzdKUtbObHVzQlL3mF1zlaGAGcsqNz1/GNO44oFHMVi
 65mqbTzmikcLpg7/sjaRy9xZWdRNdV0=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-302-UQNJI1oKO9yvAvo7ljR4Uw-1; Fri, 24 Jan 2025 04:45:38 -0500
X-MC-Unique: UQNJI1oKO9yvAvo7ljR4Uw-1
X-Mimecast-MFC-AGG-ID: UQNJI1oKO9yvAvo7ljR4Uw
Received: by mail-wm1-f72.google.com with SMTP id
 5b1f17b1804b1-4361ac8b25fso10149085e9.2
 for <qemu-devel@nongnu.org>; Fri, 24 Jan 2025 01:45:38 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1737711936; x=1738316736;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=WuoN8SLEI/o39maAHg/7so9lLNQmaFy/97KoTszJKKQ=;
 b=ZLDddjG9xuqmS/cxRqsVM+5Ijck3mxVLuXS0LcIuoi7m+W7ZK0aEg/jeaAeGLCxcDp
 /2rcbkbqSjRMLZDBN2oz76Y3mtxmtEyuYneMad8SPUXqGb9YCLoWGhmm4YI6hi8ZO8dN
 F/GMQ1szmADVyILT1rXltxp+guP5KDWyq/3P43jW++fP5PIkVTWJ4hFZrb/vEXMPtRuE
 R0G8JWvLmehZICh5x8iSF+pqLlwe8cA4G66fzF2UI7+dh1Fxl27viFEsJMs5gqkqrv1Q
 U+xzgKYmLbn1zglu43/xV54SuBa51WHFSbjcN3qGcpBuXjExFQHBB9nHDBFWLA5t4VC1
 jjBA==
X-Gm-Message-State: AOJu0YzmM+B5gXhLTY3sk66iF//e3wjWRRUH6GYhuVT/7Kd7aydVrG18
 5YN3vGOhfT1U+8VcDjOnOjStZxlsry7LKHzpfWpKqXvazeJhdNvczysndyn/kZy3bYTl8oKlVqo
 O88+BzttuRY/lH3zv37SdzMoac8Y3kVaNc4F0MskCs5BgQA11ahc/D6hWL4DgkZm4tvRy2LRZqS
 VJxIGE3Wxyxu1t9rnPFG3TrS4Ik6O2XQixp7W9+wY=
X-Gm-Gg: ASbGncsFa4twHTCy3nKa49QM1rmbH3lMJwAie34EtBwvvWDHprD5I9ifRh0wBzzFoCH
 XYIwiyoiH8wOgUh1CYViZnxEWLyGOlocnzHXvcu7x1CeobOegSxuCG92PwgrGZthukpuegsL9ap
 4B6QT3FxEV/x1DZuPIqPTo+o4HC0fTVVa3/jXw1EDcUc4V7jXMbuV453uBO2DrxElhsGgzUAouC
 F3+k+9NoXgQ/AiE5tbca6ZXTdF9AKwWdykscBeOasxCJ8k/agjp2AFyf0WUz5i2K5/miExXjg==
X-Received: by 2002:a05:600c:5021:b0:436:1c0c:bfb6 with SMTP id
 5b1f17b1804b1-438914514f2mr244848995e9.27.1737711936470; 
 Fri, 24 Jan 2025 01:45:36 -0800 (PST)
X-Google-Smtp-Source: AGHT+IE+cxcSOIcrJqmFFnL92uu2ZGDmPzzYW4L4730MT2xj8Ea51jXn02blTc6ontKhcpM0Fkw7lA==
X-Received: by 2002:a05:600c:5021:b0:436:1c0c:bfb6 with SMTP id
 5b1f17b1804b1-438914514f2mr244848755e9.27.1737711935992; 
 Fri, 24 Jan 2025 01:45:35 -0800 (PST)
Received: from [192.168.10.48] ([151.95.59.125])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-438bd47f355sm20441285e9.4.2025.01.24.01.45.34
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 24 Jan 2025 01:45:35 -0800 (PST)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PULL 26/48] rust: vmstate: implement VMState for non-leaf types
Date: Fri, 24 Jan 2025 10:44:20 +0100
Message-ID: <20250124094442.13207-27-pbonzini@redhat.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250124094442.13207-1-pbonzini@redhat.com>
References: <20250124094442.13207-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -50
X-Spam_score: -5.1
X-Spam_bar: -----
X-Spam_report: (-5.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-2.996,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.043,
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

Arrays, pointers and cells use a VMStateField that is based on that
for the inner type.  The implementation therefore delegates to the
VMState implementation of the inner type.

Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 rust/qemu-api/src/vmstate.rs | 79 +++++++++++++++++++++++++++++++++++-
 1 file changed, 78 insertions(+), 1 deletion(-)

diff --git a/rust/qemu-api/src/vmstate.rs b/rust/qemu-api/src/vmstate.rs
index b839a7d6b7f..211c3d096b7 100644
--- a/rust/qemu-api/src/vmstate.rs
+++ b/rust/qemu-api/src/vmstate.rs
@@ -19,8 +19,9 @@
 //!   `include/migration/vmstate.h`. These are not type-safe and should not be
 //!   used if the equivalent functionality is available with `vmstate_of!`.
 
-use core::marker::PhantomData;
+use core::{marker::PhantomData, mem, ptr::NonNull};
 
+use crate::bindings::VMStateFlags;
 pub use crate::bindings::{VMStateDescription, VMStateField};
 
 /// This macro is used to call a function with a generic argument bound
@@ -102,6 +103,15 @@ macro_rules! vmstate_of {
     };
 }
 
+impl VMStateFlags {
+    const VMS_VARRAY_FLAGS: VMStateFlags = VMStateFlags(
+        VMStateFlags::VMS_VARRAY_INT32.0
+            | VMStateFlags::VMS_VARRAY_UINT8.0
+            | VMStateFlags::VMS_VARRAY_UINT16.0
+            | VMStateFlags::VMS_VARRAY_UINT32.0,
+    );
+}
+
 // Add a couple builder-style methods to VMStateField, allowing
 // easy derivation of VMStateField constants from other types.
 impl VMStateField {
@@ -111,6 +121,73 @@ pub const fn with_version_id(mut self, version_id: i32) -> Self {
         self.version_id = version_id;
         self
     }
+
+    #[must_use]
+    pub const fn with_array_flag(mut self, num: usize) -> Self {
+        assert!(num <= 0x7FFF_FFFFusize);
+        assert!((self.flags.0 & VMStateFlags::VMS_ARRAY.0) == 0);
+        assert!((self.flags.0 & VMStateFlags::VMS_VARRAY_FLAGS.0) == 0);
+        if (self.flags.0 & VMStateFlags::VMS_POINTER.0) != 0 {
+            self.flags = VMStateFlags(self.flags.0 & !VMStateFlags::VMS_POINTER.0);
+            self.flags = VMStateFlags(self.flags.0 | VMStateFlags::VMS_ARRAY_OF_POINTER.0);
+        }
+        self.flags = VMStateFlags(self.flags.0 & !VMStateFlags::VMS_SINGLE.0);
+        self.flags = VMStateFlags(self.flags.0 | VMStateFlags::VMS_ARRAY.0);
+        self.num = num as i32;
+        self
+    }
+
+    #[must_use]
+    pub const fn with_pointer_flag(mut self) -> Self {
+        assert!((self.flags.0 & VMStateFlags::VMS_POINTER.0) == 0);
+        self.flags = VMStateFlags(self.flags.0 | VMStateFlags::VMS_POINTER.0);
+        self
+    }
+}
+
+// Transparent wrappers: just use the internal type
+
+macro_rules! impl_vmstate_transparent {
+    ($type:ty where $base:tt: VMState $($where:tt)*) => {
+        unsafe impl<$base> VMState for $type where $base: VMState $($where)* {
+            const BASE: VMStateField = VMStateField {
+                size: mem::size_of::<$type>(),
+                ..<$base as VMState>::BASE
+            };
+        }
+    };
+}
+
+impl_vmstate_transparent!(std::cell::Cell<T> where T: VMState);
+impl_vmstate_transparent!(std::cell::UnsafeCell<T> where T: VMState);
+impl_vmstate_transparent!(crate::cell::BqlCell<T> where T: VMState);
+impl_vmstate_transparent!(crate::cell::BqlRefCell<T> where T: VMState);
+
+// Pointer types using the underlying type's VMState plus VMS_POINTER
+// Note that references are not supported, though references to cells
+// could be allowed.
+
+macro_rules! impl_vmstate_pointer {
+    ($type:ty where $base:tt: VMState $($where:tt)*) => {
+        unsafe impl<$base> VMState for $type where $base: VMState $($where)* {
+            const BASE: VMStateField = <$base as VMState>::BASE.with_pointer_flag();
+        }
+    };
+}
+
+impl_vmstate_pointer!(*const T where T: VMState);
+impl_vmstate_pointer!(*mut T where T: VMState);
+impl_vmstate_pointer!(NonNull<T> where T: VMState);
+
+// Unlike C pointers, Box is always non-null therefore there is no need
+// to specify VMS_ALLOC.
+impl_vmstate_pointer!(Box<T> where T: VMState);
+
+// Arrays using the underlying type's VMState plus
+// VMS_ARRAY/VMS_ARRAY_OF_POINTER
+
+unsafe impl<T: VMState, const N: usize> VMState for [T; N] {
+    const BASE: VMStateField = <T as VMState>::BASE.with_array_flag(N);
 }
 
 #[doc(alias = "VMSTATE_UNUSED_BUFFER")]
-- 
2.48.1


