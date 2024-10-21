Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 77731D15DBB
	for <qemu-devel@archiver.kernel.org>; Mon, 21 Oct 2024 16:39:03 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t2vP2-0006yC-1k; Mon, 21 Oct 2024 12:37:08 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1t2vOD-00067m-VV
 for qemu-devel@nongnu.org; Mon, 21 Oct 2024 12:36:18 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1t2vO9-0006Jx-Li
 for qemu-devel@nongnu.org; Mon, 21 Oct 2024 12:36:17 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1729528572;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=kvb89qSp/JxmYfOj6SZi8Bx0KqHl+LVpfSQJUogsuq4=;
 b=UxvnHXxUvAngz3NM7pQsn7W1Gpx3F0T690YPCi24AOnJk+w6Xe1xefvLMLRwMd+ujX6MNQ
 qFL6eVRzFZh+y7Nf4ixodcsYlZbo6iDQSWn7PXBlW7Nf8cmvyz4D5u4VhyOz8E7LHEw4Cr
 t+Og0WGDuaGzGvF0i/QQHJpFU34/aTc=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-385-IsaXhJRgMfC9XKIlxMzokA-1; Mon, 21 Oct 2024 12:36:11 -0400
X-MC-Unique: IsaXhJRgMfC9XKIlxMzokA-1
Received: by mail-wm1-f72.google.com with SMTP id
 5b1f17b1804b1-4315544642eso37410185e9.3
 for <qemu-devel@nongnu.org>; Mon, 21 Oct 2024 09:36:11 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1729528569; x=1730133369;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=kvb89qSp/JxmYfOj6SZi8Bx0KqHl+LVpfSQJUogsuq4=;
 b=mVVkyBcrkE5nJEKV9PTTZGMDk4VTCFpShtfdtWt0G+iqWE0FyfolbCOwaZgUBIRsvK
 MBj6RVSHHnQUM8b/wFzOSjndi2/68AQSyDtziSv6QfXFgtBDjQekGnc/W5EpSX0zRKMl
 V6VGz6kGu/FwNfLrIm+aH/Z8Niu4DRyLsilkQZWOxURavFIeJmTRBXOQHIox/FWn8dLH
 q16fetw8Kr+/KTQRbC1XmbYutjAnjzd4XcQcvatOtdkEjHiSSm0VpirhEN1uF+sks5V2
 znY+XDgpv/m54VKDWOq3WEGE19xcEdYoePGDjvLPjuheLreOfZLpi3lBulV+pOuslaNp
 Xoog==
X-Gm-Message-State: AOJu0Yz/5yvw+LNTA6PiFRiDUlQHGckZtWxFzQ/wOAY2xJiw3rUSmTQ9
 aX/BhO+4S/NeGzPHwapwWBa6iZ+0THHXInTwgID5kuXjSAMmqRDdQY5u0RouE3WWiWJMK/UILB0
 Vo/KUP/szWzK4N92DAyRBuYj4MQHPq8Gd6H+lYzJwk9wSQCNyOefwFMga89p65FOKPt6YkGJheO
 yQX9ziN4/KIuxnCbZIn9oszFkOulu7WgqJiEyIgd4=
X-Received: by 2002:a05:600c:1d01:b0:42c:b74c:d8c3 with SMTP id
 5b1f17b1804b1-4316168ff01mr99496365e9.32.1729528569240; 
 Mon, 21 Oct 2024 09:36:09 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGoo2DZlzYa5tO9scq9rSbVdszZ2ED+SvdnMr+4+YYOsddyVtq1HlTczBGmh8mLjTphc1v7jg==
X-Received: by 2002:a05:600c:1d01:b0:42c:b74c:d8c3 with SMTP id
 5b1f17b1804b1-4316168ff01mr99496045e9.32.1729528568746; 
 Mon, 21 Oct 2024 09:36:08 -0700 (PDT)
Received: from avogadro.local ([151.95.144.54])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4316f57fa4fsm62774405e9.16.2024.10.21.09.36.08
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 21 Oct 2024 09:36:08 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Cc: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>,
 Junjie Mao <junjie.mao@hotmail.com>
Subject: [PATCH v2 08/13] rust: cleanup module_init!,
 use it from #[derive(Object)]
Date: Mon, 21 Oct 2024 18:35:33 +0200
Message-ID: <20241021163538.136941-9-pbonzini@redhat.com>
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

Remove the duplicate code by using the module_init! macro; at the same time,
simplify how module_init! is used, by taking inspiration from the implementation
of #[derive(Object)].

Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 rust/qemu-api-macros/src/lib.rs  | 33 +++-------------
 rust/qemu-api/src/definitions.rs | 66 ++++++++++++++------------------
 2 files changed, 33 insertions(+), 66 deletions(-)

diff --git a/rust/qemu-api-macros/src/lib.rs b/rust/qemu-api-macros/src/lib.rs
index 70e3f920460..a4bc5d01ee8 100644
--- a/rust/qemu-api-macros/src/lib.rs
+++ b/rust/qemu-api-macros/src/lib.rs
@@ -3,43 +3,20 @@
 // SPDX-License-Identifier: GPL-2.0-or-later
 
 use proc_macro::TokenStream;
-use quote::{format_ident, quote};
+use quote::quote;
 use syn::{parse_macro_input, DeriveInput};
 
 #[proc_macro_derive(Object)]
 pub fn derive_object(input: TokenStream) -> TokenStream {
     let input = parse_macro_input!(input as DeriveInput);
-
     let name = input.ident;
-    let module_static = format_ident!("__{}_LOAD_MODULE", name);
 
     let expanded = quote! {
-        #[allow(non_upper_case_globals)]
-        #[used]
-        #[cfg_attr(
-            not(any(target_vendor = "apple", target_os = "windows")),
-            link_section = ".init_array"
-        )]
-        #[cfg_attr(target_vendor = "apple", link_section = "__DATA,__mod_init_func")]
-        #[cfg_attr(target_os = "windows", link_section = ".CRT$XCU")]
-        pub static #module_static: extern "C" fn() = {
-            extern "C" fn __register() {
-                unsafe {
-                    ::qemu_api::bindings::type_register_static(&<#name as ::qemu_api::definitions::ObjectImpl>::TYPE_INFO);
-                }
+        ::qemu_api::module_init! {
+            MODULE_INIT_QOM => unsafe {
+                ::qemu_api::bindings::type_register_static(&<#name as ::qemu_api::definitions::ObjectImpl>::TYPE_INFO);
             }
-
-            extern "C" fn __load() {
-                unsafe {
-                    ::qemu_api::bindings::register_module_init(
-                        Some(__register),
-                        ::qemu_api::bindings::module_init_type::MODULE_INIT_QOM
-                    );
-                }
-            }
-
-            __load
-        };
+        }
     };
 
     TokenStream::from(expanded)
diff --git a/rust/qemu-api/src/definitions.rs b/rust/qemu-api/src/definitions.rs
index 3323a665d92..f180c38bfb2 100644
--- a/rust/qemu-api/src/definitions.rs
+++ b/rust/qemu-api/src/definitions.rs
@@ -29,51 +29,40 @@ pub trait Class {
 
 #[macro_export]
 macro_rules! module_init {
-    ($func:expr, $type:expr) => {
-        #[used]
-        #[cfg_attr(
-            not(any(target_vendor = "apple", target_os = "windows")),
-            link_section = ".init_array"
-        )]
-        #[cfg_attr(target_vendor = "apple", link_section = "__DATA,__mod_init_func")]
-        #[cfg_attr(target_os = "windows", link_section = ".CRT$XCU")]
-        pub static LOAD_MODULE: extern "C" fn() = {
-            extern "C" fn __load() {
-                unsafe {
-                    $crate::bindings::register_module_init(Some($func), $type);
-                }
-            }
-
-            __load
-        };
-    };
-    (qom: $func:ident => $body:block) => {
-        // NOTE: To have custom identifiers for the ctor func we need to either supply
-        // them directly as a macro argument or create them with a proc macro.
-        #[used]
-        #[cfg_attr(
-            not(any(target_vendor = "apple", target_os = "windows")),
-            link_section = ".init_array"
-        )]
-        #[cfg_attr(target_vendor = "apple", link_section = "__DATA,__mod_init_func")]
-        #[cfg_attr(target_os = "windows", link_section = ".CRT$XCU")]
-        pub static LOAD_MODULE: extern "C" fn() = {
-            extern "C" fn __load() {
-                unsafe extern "C" fn $func() {
+    ($type:ident => $body:block) => {
+        const _: () = {
+            #[used]
+            #[cfg_attr(
+                not(any(target_vendor = "apple", target_os = "windows")),
+                link_section = ".init_array"
+            )]
+            #[cfg_attr(target_vendor = "apple", link_section = "__DATA,__mod_init_func")]
+            #[cfg_attr(target_os = "windows", link_section = ".CRT$XCU")]
+            pub static LOAD_MODULE: extern "C" fn() = {
+                extern "C" fn init_fn() {
                     $body
                 }
 
-                unsafe {
-                    $crate::bindings::register_module_init(
-                        Some($func),
-                        $crate::bindings::module_init_type::MODULE_INIT_QOM,
-                    );
+                extern "C" fn ctor_fn() {
+                    unsafe {
+                        $crate::bindings::register_module_init(
+                            Some(init_fn),
+                            $crate::bindings::module_init_type::$type,
+                        );
+                    }
                 }
-            }
 
-            __load
+                ctor_fn
+            };
         };
     };
+
+    // shortcut because it's quite common that $body needs unsafe {}
+    ($type:ident => unsafe $body:block) => {
+        $crate::module_init! {
+            $type => { unsafe { $body } }
+        }
+    };
 }
 
 #[macro_export]
-- 
2.46.2


