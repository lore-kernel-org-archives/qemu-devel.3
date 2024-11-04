Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B90B8D1BDD2
	for <qemu-devel@archiver.kernel.org>; Mon,  4 Nov 2024 17:29:32 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t80s2-0005F8-Ma; Mon, 04 Nov 2024 12:28:06 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1t80s0-0005Do-MP
 for qemu-devel@nongnu.org; Mon, 04 Nov 2024 12:28:04 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1t80rw-0000Ha-ND
 for qemu-devel@nongnu.org; Mon, 04 Nov 2024 12:28:04 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1730741279;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=l2dZTvoQGa7EAtC2HDpwzcBQ7yI0kzC/1TBZHRMxmWE=;
 b=fovK47NhSV7WXgJZRIp/tFvL29j5SzI13ea4R0yTpwL6aOSw5QfXdimtGL68S+LMs1BLLK
 qmZLJZt9EXVhbT41jJFuCe22VIVDjSZAfZixmqnhlZOzzcbQSi9MsbINaki1LMzyr9OCNO
 FcwvBIAwcQajFqMLBZU8Kx12bwBheak=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-587-Rhrniya9ORGFWAj38NzPhQ-1; Mon, 04 Nov 2024 12:27:58 -0500
X-MC-Unique: Rhrniya9ORGFWAj38NzPhQ-1
Received: by mail-wm1-f70.google.com with SMTP id
 5b1f17b1804b1-431518ae047so29613035e9.0
 for <qemu-devel@nongnu.org>; Mon, 04 Nov 2024 09:27:58 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1730741276; x=1731346076;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=l2dZTvoQGa7EAtC2HDpwzcBQ7yI0kzC/1TBZHRMxmWE=;
 b=CopJMaXNyH/gL6/PUAxo6vNgGznxoPfLxN1a+Heav5TgNegZ5jAzMIFNYzA8PadLxc
 7w6CeyixfUc9JDxB4a/FYMdVqiUiGh1zW1a3v7//yU7iQ3NY4HoGJ+wNV0o8YRmDW33i
 /a8gc2J7DDjMb1jnqH1volYjU+XQElbMfLjDN4BorXugyi9KOCzQ1sdjkGRfBI1IiNMH
 93fZOEj4AgDIBdxkZeh2rSHH8qDHmUGtzYMdbIkqxG8dlYvysT+VlXX5N0O+4rm03/Vs
 5z+EK04ps9ikYWeUl4yb9l5AZ7nIskG+SOtHdGs4BycMUj1XAiM5o0NUELJuvYbF06lJ
 rQ9A==
X-Gm-Message-State: AOJu0Yy2gHVb1DQvJbZFvGjfbSVv4nbuZM9uFL3EBbi+bKt6pSKHOCdf
 aiWb3BJ0pS1lGU+v4NvowEHofGpXNWy/i9WWdWIN0+sb4ziyrZJf+RWZP6EU78DRFXft+Fg8xWS
 vkP4oABF6WfM7nWEVKdrdlkcbbpX1h1E2K7/arytHOMMAzBH0gMbU0Krm7eiOX2PnVKAjZ0Pn0x
 BT5j+m+JRLlH/uS42QRSeOjaXgVq2R9cgAI90IM2g=
X-Received: by 2002:a5d:59a6:0:b0:37d:3baa:9f34 with SMTP id
 ffacd0b85a97d-381c1305999mr16042051f8f.1.1730741276392; 
 Mon, 04 Nov 2024 09:27:56 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFmLmGZYoBGhTIsj+v6S0YXVk3wLRcqjHy0osvNlF9rcOn8KgMc6WZMD3KyU0HJ+Efn/iF3rw==
X-Received: by 2002:a5d:59a6:0:b0:37d:3baa:9f34 with SMTP id
 ffacd0b85a97d-381c1305999mr16042012f8f.1.1730741275869; 
 Mon, 04 Nov 2024 09:27:55 -0800 (PST)
Received: from [192.168.10.3] ([151.49.226.83])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-381c113e528sm13831378f8f.78.2024.11.04.09.27.54
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 04 Nov 2024 09:27:54 -0800 (PST)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Junjie Mao <junjie.mao@hotmail.com>, Kevin Wolf <kwolf@redhat.com>,
 Manos Pitsidianakis <manos.pitsidianakis@linaro.org>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 Zhao Liu <zhao1.liu@intel.com>
Subject: [PULL 15/40] rust: make properties array immutable
Date: Mon,  4 Nov 2024 18:26:54 +0100
Message-ID: <20241104172721.180255-16-pbonzini@redhat.com>
X-Mailer: git-send-email 2.47.0
In-Reply-To: <20241104172721.180255-1-pbonzini@redhat.com>
References: <20241104172721.180255-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -23
X-Spam_score: -2.4
X-Spam_bar: --
X-Spam_report: (-2.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.34,
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

Now that device_class_set_props() takes a const pointer, the only part of
"define_property!" that needs to be non-const is the call to try_into().
This in turn will only break if offset_of returns a value with the most
significant bit set (i.e. a struct size that is >=2^31 or >= 2^63,
respectively on 32- and 64-bit system), which is impossible.

Just use a cast and clean everything up to remove the run-time
initialization.  This also removes a use of OnceLock, which was only
stabilized in 1.70.0.

Reviewed-by: Kevin Wolf <kwolf@redhat.com>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 rust/qemu-api/src/device_class.rs | 42 ++++++-------------------------
 1 file changed, 8 insertions(+), 34 deletions(-)

diff --git a/rust/qemu-api/src/device_class.rs b/rust/qemu-api/src/device_class.rs
index aab60484096..4b14cb3ffd6 100644
--- a/rust/qemu-api/src/device_class.rs
+++ b/rust/qemu-api/src/device_class.rs
@@ -2,10 +2,6 @@
 // Author(s): Manos Pitsidianakis <manos.pitsidianakis@linaro.org>
 // SPDX-License-Identifier: GPL-2.0-or-later
 
-use std::sync::OnceLock;
-
-use crate::bindings::Property;
-
 #[macro_export]
 macro_rules! device_class_init {
     ($func:ident, props => $props:ident, realize_fn => $realize_fn:expr, legacy_reset_fn => $legacy_reset_fn:expr, vmsd => $vmsd:ident$(,)*) => {
@@ -19,7 +15,7 @@ macro_rules! device_class_init {
                 dc.as_mut().realize = $realize_fn;
                 dc.as_mut().vmsd = &$vmsd;
                 $crate::bindings::device_class_set_legacy_reset(dc.as_mut(), $legacy_reset_fn);
-                $crate::bindings::device_class_set_props(dc.as_mut(), $props.as_mut_ptr());
+                $crate::bindings::device_class_set_props(dc.as_mut(), $props.as_ptr());
             }
         }
     };
@@ -32,9 +28,7 @@ macro_rules! define_property {
             // use associated function syntax for type checking
             name: ::core::ffi::CStr::as_ptr($name),
             info: $prop,
-            offset: ::core::mem::offset_of!($state, $field)
-                .try_into()
-                .expect("Could not fit offset value to type"),
+            offset: ::core::mem::offset_of!($state, $field) as isize,
             set_default: true,
             defval: $crate::bindings::Property__bindgen_ty_1 { u: $defval as u64 },
             ..unsafe { ::core::mem::MaybeUninit::<$crate::bindings::Property>::zeroed().assume_init() }
@@ -45,47 +39,27 @@ macro_rules! define_property {
             // use associated function syntax for type checking
             name: ::core::ffi::CStr::as_ptr($name),
             info: $prop,
-            offset: ::core::mem::offset_of!($state, $field)
-                .try_into()
-                .expect("Could not fit offset value to type"),
+            offset: ::core::mem::offset_of!($state, $field) as isize,
             set_default: false,
             ..unsafe { ::core::mem::MaybeUninit::<$crate::bindings::Property>::zeroed().assume_init() }
         }
     };
 }
 
-#[repr(C)]
-pub struct Properties<const N: usize>(pub OnceLock<[Property; N]>, pub fn() -> [Property; N]);
-
-impl<const N: usize> Properties<N> {
-    pub fn as_mut_ptr(&mut self) -> *mut Property {
-        _ = self.0.get_or_init(self.1);
-        self.0.get_mut().unwrap().as_mut_ptr()
-    }
-}
-
 #[macro_export]
 macro_rules! declare_properties {
     ($ident:ident, $($prop:expr),*$(,)*) => {
-
-        const fn _calc_prop_len() -> usize {
+        pub static $ident: [$crate::bindings::Property; {
             let mut len = 1;
             $({
                 _ = stringify!($prop);
                 len += 1;
             })*
             len
-        }
-        const PROP_LEN: usize = _calc_prop_len();
-
-        fn _make_properties() -> [$crate::bindings::Property; PROP_LEN] {
-            [
-                $($prop),*,
-                    unsafe { ::core::mem::MaybeUninit::<$crate::bindings::Property>::zeroed().assume_init() },
-            ]
-        }
-
-        pub static mut $ident: $crate::device_class::Properties<PROP_LEN> = $crate::device_class::Properties(::std::sync::OnceLock::new(), _make_properties);
+        }] = [
+            $($prop),*,
+            unsafe { ::core::mem::MaybeUninit::<$crate::bindings::Property>::zeroed().assume_init() },
+        ];
     };
 }
 
-- 
2.47.0


