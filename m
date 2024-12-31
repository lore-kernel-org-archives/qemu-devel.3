Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 39BD7E77194
	for <qemu-devel@archiver.kernel.org>; Tue, 31 Dec 2024 00:25:25 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tSQ3B-0003Nx-BZ; Mon, 30 Dec 2024 19:23:57 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1tSQ38-0003N0-Iu
 for qemu-devel@nongnu.org; Mon, 30 Dec 2024 19:23:55 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1tSQ35-0001y5-I4
 for qemu-devel@nongnu.org; Mon, 30 Dec 2024 19:23:54 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1735604630;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=V8eqX+r29sPapJhn/vLbtpBrgqJq/aUh19hK4P3NE2Y=;
 b=EYjWqiH05lJnIzFs7CD4vjU92c08+9iD3KxCucsTmQ22PJxaHmlQoLRlhfxqn6XVuEv+95
 /RcD3wGZIQUffoweYnLeCzr5b7ePxhIEmSlh6jqzcxbu4UMpIVg66wOEiLSWEt+pm/mUAC
 c4T3U41U9On8aY936yBPV3PXlzYyzaQ=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-436-htVhSm9mNuONmhrfJZJJeQ-1; Mon, 30 Dec 2024 19:23:48 -0500
X-MC-Unique: htVhSm9mNuONmhrfJZJJeQ-1
X-Mimecast-MFC-AGG-ID: htVhSm9mNuONmhrfJZJJeQ
Received: by mail-wm1-f72.google.com with SMTP id
 5b1f17b1804b1-43623bf2a83so70814715e9.0
 for <qemu-devel@nongnu.org>; Mon, 30 Dec 2024 16:23:48 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1735604626; x=1736209426;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=V8eqX+r29sPapJhn/vLbtpBrgqJq/aUh19hK4P3NE2Y=;
 b=vXCK1Aj0dbFFIQuXneTE7G4SbVe5hMhnmx9SmxubTrDzD93JFeWb08WLjV5kVLW9N+
 Uph3G2sr/OP9Ps5+kZu91orspIiU0Ev+6JAXVz9s6Gr0BE3QGPsMk5Bol25tXq2vMwEa
 4I2tJVO3z9Wl0EEFvxycOfxDCjmAGP85Z62qXwn66Q0GIu8beiApHejCy/hCjHvoF6uM
 QLOiP6T+fqY2tDgF4PJpaoIdRuXOtbqft0OEBPWQuvy0dX0UvGf2t14cS7PFt09WzJ9j
 tRtwjd/l+dxdt/0g9mKCtSWerkEre/mLItOdDP8vVepmZ+31UWW2b+MshOHthqSEqhRR
 P1Lg==
X-Gm-Message-State: AOJu0YwmUz3vjZv053cJlNGIgS+KlncXXO1ExyJr2FnbeWLj/gKA63ox
 XBbYNJgeXGQZrvI+7V1LrHgM5/opAIc2FzMe9tM14IuYg69JLQT0fxPFhsn9BOIxVMQtDezWog6
 tLMEnxFUxW40xM13b6dx5Wpm+k0J5YuqyiQ7krw6FhlnC10rSLPYCG5llWqf1hMHBlg4ulQqdkv
 z/ctdT7aT26oMV8TMwXUlY7dlO36EO2rTEp8JYDqQ=
X-Gm-Gg: ASbGncs/NWNs/Nojs2tnUjzHanjJmCs7CdXHjv/r1VXO9CHw3NOxToblvUwDig37L4m
 pz39b0lZfoptFe5xaclAeUQLZDf+xeVqZ+E1bI48mvvyScA2kMBv2CPxbzsLOM/g1F63y37svC8
 TY7bvr77Lyf7MJaoYrcIXyKIGPxsD00e8iuoLVC/zRV09i2AOEZPe8TSiz/G+EC9mLz4uLVyoNA
 xxepBcShAts5wkDS64JsHCBLlE1qGZPOwS4bO9eCiwYg3sw8J5K1atbjqw=
X-Received: by 2002:a5d:59ad:0:b0:386:32ca:aa12 with SMTP id
 ffacd0b85a97d-38a223feed2mr24894073f8f.49.1735604626472; 
 Mon, 30 Dec 2024 16:23:46 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFZv9t08NRGO27ZZdgCK2GIiscRqxj0W9Mj/2mSZkxJaFIPLTAS5vXRDNETy4qIatVFZKL1uQ==
X-Received: by 2002:a5d:59ad:0:b0:386:32ca:aa12 with SMTP id
 ffacd0b85a97d-38a223feed2mr24894063f8f.49.1735604626072; 
 Mon, 30 Dec 2024 16:23:46 -0800 (PST)
Received: from [192.168.10.3] ([151.62.105.73])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-38a1c832e8asm30944218f8f.37.2024.12.30.16.23.44
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 30 Dec 2024 16:23:44 -0800 (PST)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Cc: qemu-rust@nongnu.org,
	zhao1.liu@intel.com,
	junjie.mao@hotmail.com
Subject: [RFC PATCH 3/9] rust: vmstate: add varray support to vmstate_of!
Date: Tue, 31 Dec 2024 01:23:30 +0100
Message-ID: <20241231002336.25931-4-pbonzini@redhat.com>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20241231002336.25931-1-pbonzini@redhat.com>
References: <20241231002336.25931-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -42
X-Spam_score: -4.3
X-Spam_bar: ----
X-Spam_report: (-4.3 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-2.187,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.001,
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

Untested...

Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 rust/qemu-api/src/vmstate.rs | 45 +++++++++++++++++++++++++++++++++---
 1 file changed, 42 insertions(+), 3 deletions(-)

diff --git a/rust/qemu-api/src/vmstate.rs b/rust/qemu-api/src/vmstate.rs
index e20f27b172b..079c19c687b 100644
--- a/rust/qemu-api/src/vmstate.rs
+++ b/rust/qemu-api/src/vmstate.rs
@@ -69,6 +69,15 @@ pub unsafe trait VMState {
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
@@ -77,6 +86,13 @@ pub const fn vmstate_base<T: VMState>(_: PhantomData<T>) -> VMStateField {
     T::BASE
 }
 
+/// Internal utility function to retrieve a type's `VMStateFlags` when it
+/// is used as the element count of a `VMSTATE_VARRAY`; used by
+/// [`vmstate_of!`](crate::vmstate_of).
+pub const fn vmstate_varray_flag<T: VMState>(_: PhantomData<T>) -> VMStateField {
+    T::BASE
+}
+
 /// Return the `VMStateField` for a field of a struct.  The field must be
 /// visible in the current scope.
 ///
@@ -84,18 +100,24 @@ pub const fn vmstate_base<T: VMState>(_: PhantomData<T>) -> VMStateField {
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
-            // Compute most of the VMStateField from the type of the field.
+            $(.num_offset: $crate::offset_of!($struct_name, $num),)?
+            // The calls to `call_func_with_field!` are the magic that
+            // computes most of the VMStateField from the type of the field.
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
@@ -130,6 +152,22 @@ pub const fn with_pointer_flag(mut self) -> Self {
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
@@ -141,6 +179,7 @@ unsafe impl<$base> VMState for $type where $base: VMState $($where)* {
                 size: mem::size_of::<$type>(),
                 ..<$base as VMState>::BASE
             };
+            const VARRAY_FLAG: VMStateFlags = <$base as VMState>::VARRAY_FLAG;
         }
     };
 }
-- 
2.47.1


