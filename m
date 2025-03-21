Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 47BAFC36000
	for <qemu-devel@archiver.kernel.org>; Fri, 21 Mar 2025 18:40:55 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tvhFT-0004GP-Un; Fri, 21 Mar 2025 14:37:41 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1tvhEs-0003NV-6I
 for qemu-devel@nongnu.org; Fri, 21 Mar 2025 14:37:07 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1tvhEo-000780-O6
 for qemu-devel@nongnu.org; Fri, 21 Mar 2025 14:37:00 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1742582218;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=zxHQkV48tuPPh4skSGkR+Kk+7dztE2eJ25IcFhaYuDw=;
 b=hnF922Ubj75bJf5JnfasYewTPXH3KZ2fYeKdfjsBgVKUO/LDniL1AZuzaLPQYKs930dH+H
 roVthlvZav7MN+fR5s+67TMV9fkQcSxG2HIMb4SnMWwh/ekwzN0oLVcjBwK6o50H0RRsem
 dDoGt8Kp5Iu6dTEgJKC5roYv8Nsl+0M=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-670-Wxv2xBd8PEyIJkCpbaS6AA-1; Fri, 21 Mar 2025 14:36:49 -0400
X-MC-Unique: Wxv2xBd8PEyIJkCpbaS6AA-1
X-Mimecast-MFC-AGG-ID: Wxv2xBd8PEyIJkCpbaS6AA_1742582208
Received: by mail-wr1-f70.google.com with SMTP id
 ffacd0b85a97d-3914bc0cc4aso1156855f8f.3
 for <qemu-devel@nongnu.org>; Fri, 21 Mar 2025 11:36:48 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1742582207; x=1743187007;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=zxHQkV48tuPPh4skSGkR+Kk+7dztE2eJ25IcFhaYuDw=;
 b=E2bpMdjzu+ofaWiFFvScHqUObZHGiucK87Xle3eFFSjkou8ZqzaEwPyBbs67MssbSM
 j+5+Nk9xOelBaTDbEe00XwhuKhvujdxNPU/1bkgPb6fYbU4EpuFSH/HxibGsGHefwOrP
 NNYW1ZXE7NYaFVjVKVDheki8QR3xP03jnk2t94doH9Q3z7lLo4tDc1vtCKQbIQvCewn6
 gQZxDvmZignb7XPKRLSQW00FGuarfRuy/xNcNFktxanpRqqQUzK5R6EKkYuCDxigjIgh
 C/9XZRruP90TPgiBs7kKRTnl5XxYXW4nWEWVVl2QQ3kpM3ssQzNcWXti1YSVBmmdQN/t
 q5Fg==
X-Gm-Message-State: AOJu0YwQ35ky9qsPVy8ZmOMbcqyqVhWFnzAeZUW1aG/VH/1wSiatlPl6
 73SqoOWmIc58vTlKlAH1rtBMliXHcU7NI5Aov4ysdREhB9mg0QDIJ4FWURKbmgN1+5NcyARLyy1
 e+8mdLkQ4zKStFiTrIrmTaiqPSJ28FCdup8shnf4iK3AFHVA68VTRbuMssDEY2WhBmcDD2/pugs
 79bfOkUGPEF7LttHbzoW3wLpULmSJ29ZLWKvCm
X-Gm-Gg: ASbGncsfJGQ/R3QmutVyo5/ObYGlMBzxvUIG1DFTi6LaccQWWLYBz7CvQCYVCXgVnLc
 JxFN115CTGBKEu6RjrXwG3xPhZA0MUKpovo8wMwjX3i8zvHzVGZ8hhKqvjcEZkZ2w02wDU78/LW
 dp2l+WecU1r6Fcl7mw8vyV8saDxfMe+zuPzpDyhpgsdXTSKOcvKaCZHF8KfKoi9fNevXCxVie6z
 0SLDf6AMuTaoyUtairyTq6/Al7v6s3i/Rf8f37PHUAgb1IB0eWeEGckklcDkTHn+mveX/ClOixS
 llZDrtGa87Fzrv7UircH
X-Received: by 2002:a5d:6d88:0:b0:391:1473:336a with SMTP id
 ffacd0b85a97d-3997f937d76mr4210009f8f.36.1742582206816; 
 Fri, 21 Mar 2025 11:36:46 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGdmEXaFsqQICMncMlB+Im2KoVQ0WuRm+oQI7eQBf/kavf0U6/RvXqgRMDxpjx7DUDCoTL14A==
X-Received: by 2002:a5d:6d88:0:b0:391:1473:336a with SMTP id
 ffacd0b85a97d-3997f937d76mr4209992f8f.36.1742582206284; 
 Fri, 21 Mar 2025 11:36:46 -0700 (PDT)
Received: from [192.168.122.1] ([151.49.194.153])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3997f995789sm3089435f8f.17.2025.03.21.11.36.43
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 21 Mar 2025 11:36:43 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Cc: Zhao Liu <zhao1.liu@intel.com>
Subject: [PULL 18/24] rust/vmstate: Support vmstate_validate
Date: Fri, 21 Mar 2025 19:35:50 +0100
Message-ID: <20250321183556.155097-19-pbonzini@redhat.com>
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

In C version, VMSTATE_VALIDATE accepts the function pointer, which is
used to check if some conditions of structure could meet, although the
C version macro doesn't accept any structure as the opaque type.

But it's hard to integrate VMSTATE_VALIDAE into vmstate_struct, a new
macro has to be introduced to specifically handle the case corresponding
to VMSTATE_VALIDATE.

One of the difficulties is inferring the type of a callback by its name
`test_fn`. We can't directly use `test_fn` as a parameter of
test_cb_builder__() to get its type "F", because in this way, Rust
compiler will be too conservative on drop check and complain "the
destructor for this type cannot be evaluated in constant functions".

Fortunately, PhantomData<T> could help in this case, because it is
considered to never have a destructor, no matter its field type [*].

The `phantom__()` in the `call_func_with_field` macro provides a good
example of using PhantomData to infer type. So copy this idea and apply
it to the `vmstate_validate` macro.

[*]: https://doc.rust-lang.org/std/ops/trait.Drop.html#drop-check

Signed-off-by: Zhao Liu <zhao1.liu@intel.com>
Link: https://lore.kernel.org/r/20250318130219.1799170-11-zhao1.liu@intel.com
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 rust/qemu-api/src/vmstate.rs | 52 +++++++++++++++++++++++++++++++++++-
 1 file changed, 51 insertions(+), 1 deletion(-)

diff --git a/rust/qemu-api/src/vmstate.rs b/rust/qemu-api/src/vmstate.rs
index 01f06ed7379..9740931fb16 100644
--- a/rust/qemu-api/src/vmstate.rs
+++ b/rust/qemu-api/src/vmstate.rs
@@ -25,9 +25,12 @@
 //!   functionality that is missing from `vmstate_of!`.
 
 use core::{marker::PhantomData, mem, ptr::NonNull};
+use std::os::raw::{c_int, c_void};
 
 pub use crate::bindings::{VMStateDescription, VMStateField};
-use crate::{bindings::VMStateFlags, prelude::*, qom::Owned, zeroable::Zeroable};
+use crate::{
+    bindings::VMStateFlags, callbacks::FnCall, prelude::*, qom::Owned, zeroable::Zeroable,
+};
 
 /// This macro is used to call a function with a generic argument bound
 /// to the type of a field.  The function must take a
@@ -508,6 +511,53 @@ macro_rules! vmstate_fields {
     }}
 }
 
+pub extern "C" fn rust_vms_test_field_exists<T, F: for<'a> FnCall<(&'a T, u8), bool>>(
+    opaque: *mut c_void,
+    version_id: c_int,
+) -> bool {
+    let owner: &T = unsafe { &*(opaque.cast::<T>()) };
+    let version: u8 = version_id.try_into().unwrap();
+    // SAFETY: the opaque was passed as a reference to `T`.
+    F::call((owner, version))
+}
+
+pub type VMSFieldExistCb = unsafe extern "C" fn(
+    opaque: *mut std::os::raw::c_void,
+    version_id: std::os::raw::c_int,
+) -> bool;
+
+#[doc(alias = "VMSTATE_VALIDATE")]
+#[macro_export]
+macro_rules! vmstate_validate {
+    ($struct_name:ty, $test_name:expr, $test_fn:expr $(,)?) => {
+        $crate::bindings::VMStateField {
+            name: ::std::ffi::CStr::as_ptr($test_name),
+            field_exists: {
+                const fn test_cb_builder__<
+                    T,
+                    F: for<'a> $crate::callbacks::FnCall<(&'a T, u8), bool>,
+                >(
+                    _phantom: ::core::marker::PhantomData<F>,
+                ) -> $crate::vmstate::VMSFieldExistCb {
+                    let _: () = F::ASSERT_IS_SOME;
+                    $crate::vmstate::rust_vms_test_field_exists::<T, F>
+                }
+
+                const fn phantom__<T>(_: &T) -> ::core::marker::PhantomData<T> {
+                    ::core::marker::PhantomData
+                }
+                Some(test_cb_builder__::<$struct_name, _>(phantom__(&$test_fn)))
+            },
+            flags: $crate::bindings::VMStateFlags(
+                $crate::bindings::VMStateFlags::VMS_MUST_EXIST.0
+                    | $crate::bindings::VMStateFlags::VMS_ARRAY.0,
+            ),
+            num: 0, // 0 elements: no data, only run test_fn callback
+            ..$crate::zeroable::Zeroable::ZERO
+        }
+    };
+}
+
 /// A transparent wrapper type for the `subsections` field of
 /// [`VMStateDescription`].
 ///
-- 
2.49.0


