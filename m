Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 216F7D3398E
	for <qemu-devel@archiver.kernel.org>; Mon, 28 Oct 2024 14:36:16 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t5Qnz-00037I-Rw; Mon, 28 Oct 2024 10:33:16 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1t5QlL-0000XU-Ks
 for qemu-devel@nongnu.org; Mon, 28 Oct 2024 10:30:35 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1t5QlI-0003zx-DQ
 for qemu-devel@nongnu.org; Mon, 28 Oct 2024 10:30:31 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1730125827;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=A9+GxjZBE101yDjjA0Qt1X0NpiGdJaUq+zHWXHIOAas=;
 b=O2qF7tJOSOBRsED24rj0AGrImNnNGob6vXCxx38ZuqSjNr8jTnGOq4JSuiyfOTdqQD7H7l
 q8aQuOwvjmYKKqGFaR4LEW3QC6DhOwgrudmyONgjdRk+wsurgl16slaRirZrUmmbGoqIzf
 Z8Ug7NrdsmoO4yZGhP52zTCnJ6UA0VQ=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-563-FYBOiREsOAWwiGgFbXeLFQ-1; Mon, 28 Oct 2024 10:30:22 -0400
X-MC-Unique: FYBOiREsOAWwiGgFbXeLFQ-1
Received: by mail-wm1-f69.google.com with SMTP id
 5b1f17b1804b1-43157e3521dso29925645e9.1
 for <qemu-devel@nongnu.org>; Mon, 28 Oct 2024 07:30:19 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1730125818; x=1730730618;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=A9+GxjZBE101yDjjA0Qt1X0NpiGdJaUq+zHWXHIOAas=;
 b=P/f8AbscXMeUvWeg0BI4Qiy9niMigTazCLtotMEqSR7jYUp92+tHzTyNOR3ubtErB7
 GZLOquPjG9cpYnHVpna6IIcts8E8pFlH72YdQd69OWVtNof8vdqoYQMTPCmRxdRIUms8
 oNi32nV50hMoWQOk0F+FqFKN6SoETiLPHyjzDnoyoApENqnRpdWsHtY/WhxOJPLeb5dD
 3DMfJ9yON7c0GS68Llfe14a5n5/6iuXkXUaOFFJTFwzi3Yhbx6Ak+koUKo48K1d7UR4i
 DLXgW34Skw5pnOOcBibi+D6dOwhze14horQ3ziuTuWGkSvyl8CXoyjLWl03gF7f/Riyg
 Jh5w==
X-Gm-Message-State: AOJu0Yz5ZZPp5LKDf9AakpMpuVfSDqNv0CluQSFA12jYbwBfPGyzgyWM
 fgEoU3GNOeycJXDflZvYQmd79YnEvSRoQJTxlGwYjvtR58l6HbEMqNs0p/MNvaCOYIcjzodHTqD
 8FZsqBESh+OSiYAE7o3THgH/IkHGWUKlNq3X8lukPF6g63OpFE5B/fB0vk7gMOpuMk8sC25Tczc
 fkHsuifErm7Z5tHaPdjQl+SzNBYDt48HaS2WBPttE=
X-Received: by 2002:a05:600c:46d0:b0:431:5465:807b with SMTP id
 5b1f17b1804b1-4319ad237dfmr74624965e9.32.1730125817783; 
 Mon, 28 Oct 2024 07:30:17 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEzQaYLtSYN6+sszzTqo4y23qXBh5kqUQ/zCFFpiRZ27NlM8Sf/57HFSif9gsvbWLwPeaX3xQ==
X-Received: by 2002:a05:600c:46d0:b0:431:5465:807b with SMTP id
 5b1f17b1804b1-4319ad237dfmr74624715e9.32.1730125817372; 
 Mon, 28 Oct 2024 07:30:17 -0700 (PDT)
Received: from [192.168.10.3] ([151.49.226.83])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4318b5430b6sm141801965e9.3.2024.10.28.07.30.14
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 28 Oct 2024 07:30:14 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Cc: Junjie Mao <junjie.mao@hotmail.com>,
	Kevin Wolf <kwolf@redhat.com>
Subject: [PULL 17/24] rust: cleanup module_init!, use it from #[derive(Object)]
Date: Mon, 28 Oct 2024 15:29:24 +0100
Message-ID: <20241028142932.363687-18-pbonzini@redhat.com>
X-Mailer: git-send-email 2.47.0
In-Reply-To: <20241028142932.363687-1-pbonzini@redhat.com>
References: <20241028142932.363687-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.373,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.001,
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

Remove the duplicate code by using the module_init! macro; at the same time,
simplify how module_init! is used, by taking inspiration from the implementation
of #[derive(Object)].

Reviewed-by: Junjie Mao <junjie.mao@hotmail.com>
Reviewed-by: Kevin Wolf <kwolf@redhat.com>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 rust/qemu-api-macros/src/lib.rs  | 33 +++-------------
 rust/qemu-api/src/definitions.rs | 65 +++++++++++++-------------------
 2 files changed, 32 insertions(+), 66 deletions(-)

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
index 3323a665d92..064afe60549 100644
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
2.47.0


