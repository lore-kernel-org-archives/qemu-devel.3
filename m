Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8866BC02181
	for <qemu-devel@archiver.kernel.org>; Fri, 24 Jan 2025 09:52:33 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tbGIi-0007Qc-Mm; Fri, 24 Jan 2025 04:48:33 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1tbGG2-0007Nn-5T
 for qemu-devel@nongnu.org; Fri, 24 Jan 2025 04:45:48 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1tbGG0-0003wS-Je
 for qemu-devel@nongnu.org; Fri, 24 Jan 2025 04:45:45 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1737711943;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=iUzMFIurVFZDuf9mlbfI79G6/XfuTB6fCKo65mN+6bA=;
 b=eGDi1ZDYPYDDOMXoVb+fK6Nchki1EBCla7YlV22dsN6+tU8ilgPen/A+4vFj6APLf24g5a
 jr5fMcIcf8Vn3K3MXOyONLuyJs6z4IwsOggqu7ApA9rKc8S0hEXQ5s5XarbLkJwE0CZExW
 ZGO5URvwqvY6l+pqZ7T0R+I52XNFcw8=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-517-BKGuiY_jN3uqEcFp2Ab2-g-1; Fri, 24 Jan 2025 04:45:42 -0500
X-MC-Unique: BKGuiY_jN3uqEcFp2Ab2-g-1
X-Mimecast-MFC-AGG-ID: BKGuiY_jN3uqEcFp2Ab2-g
Received: by mail-wr1-f70.google.com with SMTP id
 ffacd0b85a97d-388d1f6f3b2so848841f8f.0
 for <qemu-devel@nongnu.org>; Fri, 24 Jan 2025 01:45:41 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1737711940; x=1738316740;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=iUzMFIurVFZDuf9mlbfI79G6/XfuTB6fCKo65mN+6bA=;
 b=cSPr9DO9cLObT00lhPKSqmvGEoQFKUhCp5U7y7EOQ4VprloUdlbTuOHxFcmsquv6Ov
 G1h5Dc8RazQDAooSEoybdlMbTQH1z5sWP+P9APUCyYLCOURIMQ/7sHbaSQfFxlRT1iTO
 H+G5ZcclvoheBQzHhHsqR9KDlo08hSn+or/NfBF1XbKUlFM01m7uRWScM2+825NCRS0F
 wFXedWSdYdNPVkuVmQUYQjmM5Oj1teOylJr27AqIqcxvhyVI6U3gXtopFhfFqVhdmIuI
 lU8oDEyLZM1nhdjXfDHqIlELzY9+I92BVHW7CXHVQl8sRS6ACElMHVWgHjMSxJKkMQAD
 VOUA==
X-Gm-Message-State: AOJu0YwcLTgKdbcdq7BHcgCl2j8G4MF5FHquAFj+1GGhSJ8MWQhfo76l
 ynsNhv6euxyLb0+u/u4m/u2Y/nQxEHTAnuCEehybZst7A9hnbu3oEdVR6E0EfcS9lIuurr7ckj5
 cSYGeTkgifZwfDVhRFRdizbywxvDfYSlO6HGcYZqUnrEO5IvEr85RDSnuwJJlUUoNWfOT6OkFoJ
 YsSYLe1folTKezvDPRuCPY4k7dNsSBN8SVLWBEmFQ=
X-Gm-Gg: ASbGncteUkwdHy9pjrveU17bGc8H7pazjWHbtZxCtWWCcMSrO7pMGdYctFgOko483a7
 ZeInhbRGW7JvwzlZG6ZQjvrk0cI2tS544ygGqJlxHzbNBD9KToa0QkbC4JTPuQi1P8J17YuYSk2
 DR/DD6uVNhgCh+9t90SqZRnb4JzCWe38GGN35fIfhre8EeEbJQ6W4D14YdBY0SYShZEs5dfI3B0
 NBNuyszSKFSeQ1Z26eMfrSbPvokoq8dDwUzZyRQeA07JjIntRwAqivuU4x7TYFdRdV+Ky9UHA==
X-Received: by 2002:a5d:4207:0:b0:38b:ebcd:305c with SMTP id
 ffacd0b85a97d-38bf5675826mr21816588f8f.29.1737711939630; 
 Fri, 24 Jan 2025 01:45:39 -0800 (PST)
X-Google-Smtp-Source: AGHT+IEVv96LqD7sfaqk8mv6sYQsgNUHWv3HMbkMyQOw0qVEXsAHBPEQQd5mihfPaWGDzMS1uIVEMw==
X-Received: by 2002:a5d:4207:0:b0:38b:ebcd:305c with SMTP id
 ffacd0b85a97d-38bf5675826mr21816558f8f.29.1737711939057; 
 Fri, 24 Jan 2025 01:45:39 -0800 (PST)
Received: from [192.168.10.48] ([151.95.59.125])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-38c2a18859asm2145107f8f.42.2025.01.24.01.45.38
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 24 Jan 2025 01:45:38 -0800 (PST)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PULL 27/48] rust: vmstate: add varray support to vmstate_of!
Date: Fri, 24 Jan 2025 10:44:21 +0100
Message-ID: <20250124094442.13207-28-pbonzini@redhat.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250124094442.13207-1-pbonzini@redhat.com>
References: <20250124094442.13207-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -50
X-Spam_score: -5.1
X-Spam_bar: -----
X-Spam_report: (-5.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-2.996,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 rust/qemu-api/src/vmstate.rs | 42 ++++++++++++++++++++++++++++++++++--
 1 file changed, 40 insertions(+), 2 deletions(-)

diff --git a/rust/qemu-api/src/vmstate.rs b/rust/qemu-api/src/vmstate.rs
index 211c3d096b7..2b14d4839df 100644
--- a/rust/qemu-api/src/vmstate.rs
+++ b/rust/qemu-api/src/vmstate.rs
@@ -72,6 +72,15 @@ pub unsafe trait VMState {
     /// The base contents of a `VMStateField` (minus the name and offset) for
     /// the type that is implementing the trait.
     const BASE: VMStateField;
+
+    /// A flag that is added to another field's `VMStateField` to specify the
+    /// length's type in a variable-sized array.  If this is not a supported
+    /// type for the length (i.e. if it is not `u8`, `u16`, `u32`), using it
+    /// in a call to [`vmstate_of!`](crate::vmstate_of) will cause a
+    /// compile-time error.
+    const VARRAY_FLAG: VMStateFlags = {
+        panic!("invalid type for variable-sized array");
+    };
 }
 
 /// Internal utility function to retrieve a type's `VMStateField`;
@@ -80,6 +89,13 @@ pub const fn vmstate_base<T: VMState>(_: PhantomData<T>) -> VMStateField {
     T::BASE
 }
 
+/// Internal utility function to retrieve a type's `VMStateFlags` when it
+/// is used as the element count of a `VMSTATE_VARRAY`; used by
+/// [`vmstate_of!`](crate::vmstate_of).
+pub const fn vmstate_varray_flag<T: VMState>(_: PhantomData<T>) -> VMStateFlags {
+    T::VARRAY_FLAG
+}
+
 /// Return the `VMStateField` for a field of a struct.  The field must be
 /// visible in the current scope.
 ///
@@ -87,18 +103,23 @@ pub const fn vmstate_base<T: VMState>(_: PhantomData<T>) -> VMStateField {
 /// for them.
 #[macro_export]
 macro_rules! vmstate_of {
-    ($struct_name:ty, $field_name:ident $(,)?) => {
+    ($struct_name:ty, $field_name:ident $([0 .. $num:ident $(* $factor:expr)?])? $(,)?) => {
         $crate::bindings::VMStateField {
             name: ::core::concat!(::core::stringify!($field_name), "\0")
                 .as_bytes()
                 .as_ptr() as *const ::std::os::raw::c_char,
             offset: $crate::offset_of!($struct_name, $field_name),
             // Compute most of the VMStateField from the type of the field.
+            $(.num_offset: $crate::offset_of!($struct_name, $num),)?
             ..$crate::call_func_with_field!(
                 $crate::vmstate::vmstate_base,
                 $struct_name,
                 $field_name
-            )
+            )$(.with_varray_flag($crate::call_func_with_field!(
+                    $crate::vmstate::vmstate_varray_flag,
+                    $struct_name,
+                    $num))
+               $(.with_varray_multiply($factor))?)?
         }
     };
 }
@@ -143,6 +164,22 @@ pub const fn with_pointer_flag(mut self) -> Self {
         self.flags = VMStateFlags(self.flags.0 | VMStateFlags::VMS_POINTER.0);
         self
     }
+
+    #[must_use]
+    pub const fn with_varray_flag<T: VMState>(mut self, flag: VMStateFlags) -> VMStateField {
+        assert!((self.flags.0 & VMStateFlags::VMS_ARRAY.0) != 0);
+        self.flags = VMStateFlags(self.flags.0 & !VMStateFlags::VMS_ARRAY.0);
+        self.flags = VMStateFlags(self.flags.0 | flag.0);
+        self
+    }
+
+    #[must_use]
+    pub const fn with_varray_multiply(mut self, num: u32) -> VMStateField {
+        assert!(num <= 0x7FFF_FFFFu32);
+        self.flags = VMStateFlags(self.flags.0 | VMStateFlags::VMS_MULTIPLY_ELEMENTS.0);
+        self.num = num as i32;
+        self
+    }
 }
 
 // Transparent wrappers: just use the internal type
@@ -154,6 +191,7 @@ unsafe impl<$base> VMState for $type where $base: VMState $($where)* {
                 size: mem::size_of::<$type>(),
                 ..<$base as VMState>::BASE
             };
+            const VARRAY_FLAG: VMStateFlags = <$base as VMState>::VARRAY_FLAG;
         }
     };
 }
-- 
2.48.1


