Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 054D7D15DBB
	for <qemu-devel@archiver.kernel.org>; Mon, 21 Oct 2024 16:37:25 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t2vOz-0006nf-KE; Mon, 21 Oct 2024 12:37:05 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1t2vOM-0006IJ-7T
 for qemu-devel@nongnu.org; Mon, 21 Oct 2024 12:36:30 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1t2vOK-0006Ln-2X
 for qemu-devel@nongnu.org; Mon, 21 Oct 2024 12:36:25 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1729528583;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Qr5dagb8vQ3bDNxUa7EXxPicbCEKo86t7f8oVBzNrBQ=;
 b=XENkGCsOzPl1nrfhusyvB++SFMKpgsTM86HLqFyTEt+lNNTLSdcpOUI9m3mrr5KDpfpZVT
 stthyp/+TKyDdflHvLoec2iVj4JQQBtzGwbK+nOnBKN0wYCHcACF2kOaErbbQ2nPryXO7g
 KdovhL8AAbIRyahcMzL2pDD/FGPbL0M=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-619-5TJ3YyfQMGiyftT7h7QEfw-1; Mon, 21 Oct 2024 12:36:22 -0400
X-MC-Unique: 5TJ3YyfQMGiyftT7h7QEfw-1
Received: by mail-wm1-f72.google.com with SMTP id
 5b1f17b1804b1-431518e6d8fso32226885e9.0
 for <qemu-devel@nongnu.org>; Mon, 21 Oct 2024 09:36:22 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1729528580; x=1730133380;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Qr5dagb8vQ3bDNxUa7EXxPicbCEKo86t7f8oVBzNrBQ=;
 b=ldu/LlQqjoxSmzLkiQo8QonXVBIG6urXMYOvt/pLIlQ5w8zLic4vu/921ksD50O1zk
 IFVxCwOnA+t1fXJLdE2N01EN7GW6iH/Py2g6Is1IuwzyBlWs+gSVZNmvQPzDigt+CxHt
 4lGyXp8lHZ3sTCLKq16ZzbWDyk+HI4DupVgv8SP2M5hCeqLc1mD1C/yJML80+gVxOz5R
 opmZtaOxFvjIyNJ5v28hRnXcz4Be4iiC/bBv2FLPh1bCwgTWWItcTYlMqFAkWQjpqHdn
 XTd0/Ity8dKqnMSN5951hjKXpwo9dRIpS1gfxGvbXWU8jawKPr4Nyb5E0S1xd2dcRGmq
 /3vA==
X-Gm-Message-State: AOJu0Yw8x1bcbKikDrrfoCa8azw+5q11vxMdZpjFBUi1USn35z2IGd86
 CLldoouL+4hbl0lJNGfjixgiIx59C7Tiui1HuU/smKInfiOxoWnUz8Kb+UBZwhI6xpiE9b/OKAZ
 KwSGetzs4fOSRjRBr8IdMMWUYNZFnoDoXW/kz6x6rYwCUqL2J81JlFNNYf+hCNZffXJ4UgUC1+z
 2V5nqOLKvMwwSiYB7u45WMqY8T72Wrn2SlpUrjAfU=
X-Received: by 2002:a05:600c:4751:b0:431:612f:189b with SMTP id
 5b1f17b1804b1-43161649510mr87412265e9.12.1729528579913; 
 Mon, 21 Oct 2024 09:36:19 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHlDNUJ9aNFHH9akQxzvIEapV8Kx8cor6fWetajxrgiuBLxLfD496WyLG6iD92BJfxFAHhtPw==
X-Received: by 2002:a05:600c:4751:b0:431:612f:189b with SMTP id
 5b1f17b1804b1-43161649510mr87412035e9.12.1729528579456; 
 Mon, 21 Oct 2024 09:36:19 -0700 (PDT)
Received: from avogadro.local ([151.95.144.54])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4316f5709efsm63926925e9.10.2024.10.21.09.36.18
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 21 Oct 2024 09:36:18 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Cc: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>,
 Junjie Mao <junjie.mao@hotmail.com>
Subject: [PATCH v2 11/13] rust: make properties array immutable
Date: Mon, 21 Oct 2024 18:35:36 +0200
Message-ID: <20241021163538.136941-12-pbonzini@redhat.com>
X-Mailer: git-send-email 2.46.2
In-Reply-To: <20241021163538.136941-1-pbonzini@redhat.com>
References: <20241021163538.136941-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -41
X-Spam_score: -4.2
X-Spam_bar: ----
X-Spam_report: (-4.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.421,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-1.699,
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

Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 rust/qemu-api/src/device_class.rs | 42 ++++++-------------------------
 1 file changed, 8 insertions(+), 34 deletions(-)

diff --git a/rust/qemu-api/src/device_class.rs b/rust/qemu-api/src/device_class.rs
index 5aba426d243..d885f2fcf19 100644
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
             defval: $crate::bindings::Property__bindgen_ty_1 { u: $defval.into() },
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
2.46.2


