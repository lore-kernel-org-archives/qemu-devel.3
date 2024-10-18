Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 04DACD30016
	for <qemu-devel@archiver.kernel.org>; Fri, 18 Oct 2024 14:44:39 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t1oCl-0008IH-M0; Fri, 18 Oct 2024 10:43:51 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1t1oCj-0008I7-Uo
 for qemu-devel@nongnu.org; Fri, 18 Oct 2024 10:43:49 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1t1oCi-0002cf-EL
 for qemu-devel@nongnu.org; Fri, 18 Oct 2024 10:43:49 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1729262627;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Qr5dagb8vQ3bDNxUa7EXxPicbCEKo86t7f8oVBzNrBQ=;
 b=NJ585F2RaXAio8Jvs/TP1RzYogFcOy9juwoojw1zPTKN6pvkXYanKCyENBExGELVe3vWJj
 FvcaZaOPPUAN4o0v+ZEIrfv66Pf+9Zr+GPPcfjW1tAqlbLYQxFmBA/IqC1sX1N+uOhQdgC
 TIfZGE21XOZo1Cd8f6abt94w31CcJmo=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-504-oVX88SV4Oi-gKGNpQ1mjFA-1; Fri, 18 Oct 2024 10:43:46 -0400
X-MC-Unique: oVX88SV4Oi-gKGNpQ1mjFA-1
Received: by mail-wm1-f70.google.com with SMTP id
 5b1f17b1804b1-4316655b2f1so1362215e9.0
 for <qemu-devel@nongnu.org>; Fri, 18 Oct 2024 07:43:45 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1729262623; x=1729867423;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Qr5dagb8vQ3bDNxUa7EXxPicbCEKo86t7f8oVBzNrBQ=;
 b=FQf6sKO1veG3TBMduMAJr9c5s9Bb2aYJ8Ybz3BeD20wdO2ekyKgiiiKvlrEOT14SJM
 QuYnYpREHA1l2ptE67AKxbWyr1TrWBF45nk5m/nwr26q8ZXNEp7fRLDE7yOd8fufkXOd
 XOjPjj1qgHBBjuDzWJvCtHrsnv4vo3h4patrUoEW03BTyprZULOi3ORm/tftwR4HIwec
 9lAYliJnEBECH78gKeWxSNwKelNDCnAGE5mGK7VXqpSYQnRQVLa2obhqkZALO2xtFXh+
 Xcr1EBTOrQ48lllOQoV5oVXtL8ag+dO9+GqhvGRTGAWVUBbZWwFs6vLqKcLpXPdTEEts
 YtEQ==
X-Gm-Message-State: AOJu0YzL3/dIEVgymYlyHatxN4+YJEdTBIDfVxVXumaRqdRQyUEqI81s
 uqdaZYyayKRv55CkyruHaNCUTr7FnVf9/qbouOwOsjuj61IEWUQSUMgZkIXgs1PCvmn/juG5/ny
 M239nK9ceefy8S3Zanec7VL+7D77L8yCluRoqQ1Q/6ZSnijvQ12zNeMWxd0eFKCXMaXoBFT7SOK
 SXTS/3gDb4K+sJGmuURcapAR6hs5PSZ6LY7V0Q8fo=
X-Received: by 2002:a05:600c:5124:b0:431:5bf2:2d4 with SMTP id
 5b1f17b1804b1-431616a388cmr21866525e9.29.1729262623500; 
 Fri, 18 Oct 2024 07:43:43 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFaSGjlQKknbJVwEuYZZVU30k72n+n1WrGSyD7f5FtRHRlGzfUZq+z8LuJhOKtRYpMnY/7QIA==
X-Received: by 2002:a05:600c:5124:b0:431:5bf2:2d4 with SMTP id
 5b1f17b1804b1-431616a388cmr21866275e9.29.1729262623079; 
 Fri, 18 Oct 2024 07:43:43 -0700 (PDT)
Received: from avogadro.local ([151.95.144.54])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-43160dbe7c5sm25845785e9.6.2024.10.18.07.43.41
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 18 Oct 2024 07:43:41 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Cc: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>,
 Junjie Mao <junjie.mao@hotmail.com>
Subject: [PATCH 11/13] rust: make properties array immutable
Date: Fri, 18 Oct 2024 16:43:03 +0200
Message-ID: <20241018144306.954716-12-pbonzini@redhat.com>
X-Mailer: git-send-email 2.46.2
In-Reply-To: <20241018144306.954716-1-pbonzini@redhat.com>
References: <20241018144306.954716-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.016,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
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


