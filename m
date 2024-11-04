Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1864CD1BDD0
	for <qemu-devel@archiver.kernel.org>; Mon,  4 Nov 2024 17:28:24 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t80s0-0005Dv-Vn; Mon, 04 Nov 2024 12:28:05 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1t80ry-0005Cw-SF
 for qemu-devel@nongnu.org; Mon, 04 Nov 2024 12:28:02 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1t80rs-0000Fw-Hl
 for qemu-devel@nongnu.org; Mon, 04 Nov 2024 12:28:02 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1730741275;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=A9+GxjZBE101yDjjA0Qt1X0NpiGdJaUq+zHWXHIOAas=;
 b=G9fzXmuHaKOhZtbXcKgYs/WNKntcLRDjDIL4ghNtqGCL+329xsT3K6wV6oRQbob/CMELiC
 kXTozOg350RI2H7YbpOhJ6TqT/VHpkv024Q8/M6pK01/m7RSDsICXcJJxnwMGbdBkLynYJ
 nagRLHFRA17SFYjJb8Lb6woFuAFkTOg=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-159-i3ccn-fhPW6Mxt2xkEjaSw-1; Mon, 04 Nov 2024 12:27:54 -0500
X-MC-Unique: i3ccn-fhPW6Mxt2xkEjaSw-1
Received: by mail-wm1-f69.google.com with SMTP id
 5b1f17b1804b1-43157cff1d1so33012305e9.2
 for <qemu-devel@nongnu.org>; Mon, 04 Nov 2024 09:27:53 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1730741272; x=1731346072;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=A9+GxjZBE101yDjjA0Qt1X0NpiGdJaUq+zHWXHIOAas=;
 b=WO98hqJTp9JmSwWNl7TuG4693nSsLPJ31I9dtMXG0LHnBuMFdd8nmKAwaSixLfGVaX
 ejtAtHhKJfAKwNXGb650TPgUTVnFpMxuLOr88QgzbBitlSdX7UZ64olx3j4ifuFXyBvR
 kSgMGBuMx1zVbvkImyOV3b5Ax2QhpVWpdtGGAIAQ/Kids5QNdX0TjRml4tM1ZDbETRTA
 SjtbSL/HxQR68BSiJqDnWesXl4eUOtZWcpsFKg6F/VL37m6SRCDgCp2NpUhuwDU2OoIt
 8Q28NUawhonUIt3GCBb/TvMwAajY+gK+PqEE5sjvtgWr/XRpdhCDrsxNxbsk78+whNZF
 T5wQ==
X-Gm-Message-State: AOJu0YyEFC73lCDwWY+VAfrczlb/nV8rP3E+ayW1Y7n3wVNiHgvgpfs2
 ApXW2uN6THoNJn4pxi/q8QuMBEYs8CfL+4z0nfM4OVldfYibjaI80BmVhs4Kowa3a7aAY0zILVM
 i05iPD8KDjqGmj/vOMcXbBE09/wE+WxVaRyqeLy04lcroB/bYOLkcDrQ82pDLFs5g6NYj03+qz9
 K+w0ChOtXU4MfDecT2DSEGZog8qMrnHP3crcejq4E=
X-Received: by 2002:a05:600c:1396:b0:430:582f:3a9d with SMTP id
 5b1f17b1804b1-4327b80d1a9mr152247555e9.26.1730741272065; 
 Mon, 04 Nov 2024 09:27:52 -0800 (PST)
X-Google-Smtp-Source: AGHT+IG7hmlApj1LQZ4Rj7bpAn4i0fx0kKZFEK8dvqvgNwd7dSLiYyfO8asezG1r2QowDbtsYp8hxw==
X-Received: by 2002:a05:600c:1396:b0:430:582f:3a9d with SMTP id
 5b1f17b1804b1-4327b80d1a9mr152247245e9.26.1730741271614; 
 Mon, 04 Nov 2024 09:27:51 -0800 (PST)
Received: from [192.168.10.3] ([151.49.226.83])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-431bd8e8466sm190429555e9.2.2024.11.04.09.27.49
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 04 Nov 2024 09:27:50 -0800 (PST)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Junjie Mao <junjie.mao@hotmail.com>, Kevin Wolf <kwolf@redhat.com>,
 Manos Pitsidianakis <manos.pitsidianakis@linaro.org>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 Zhao Liu <zhao1.liu@intel.com>
Subject: [PULL 13/40] rust: cleanup module_init!, use it from #[derive(Object)]
Date: Mon,  4 Nov 2024 18:26:52 +0100
Message-ID: <20241104172721.180255-14-pbonzini@redhat.com>
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
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001,
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


