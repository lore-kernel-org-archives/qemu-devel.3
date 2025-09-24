Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 51D35CAC5A5
	for <qemu-devel@archiver.kernel.org>; Wed, 24 Sep 2025 09:33:15 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v1LoT-0004ff-U4; Wed, 24 Sep 2025 05:29:25 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1v1LoS-0004dY-9E
 for qemu-devel@nongnu.org; Wed, 24 Sep 2025 05:29:24 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1v1LoP-0004me-K0
 for qemu-devel@nongnu.org; Wed, 24 Sep 2025 05:29:24 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1758706158;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=i/j0P/MSV+X5BLJW2jx5BBKNa2M5lI05wnZcxCRbxSk=;
 b=e57obKe10H4g6OtLrJIkU5K5x7Jb7LO773GgveJfHizi+W+u4TkrS21YD32LiwillxPTQ5
 znX7//Lh4xTjfJOb9CPUv19oMGoX7EIDuE5xsu05OxKnyUuIOomEv26dq6ttMNHKsqfiz6
 7YppdldRViuHhSZxalsRB6CHHAytmh4=
Received: from mail-ej1-f71.google.com (mail-ej1-f71.google.com
 [209.85.218.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-210-7XHbMKErPqySi057Tk8vvQ-1; Wed, 24 Sep 2025 05:29:17 -0400
X-MC-Unique: 7XHbMKErPqySi057Tk8vvQ-1
X-Mimecast-MFC-AGG-ID: 7XHbMKErPqySi057Tk8vvQ_1758706156
Received: by mail-ej1-f71.google.com with SMTP id
 a640c23a62f3a-b2f989de76eso73893966b.1
 for <qemu-devel@nongnu.org>; Wed, 24 Sep 2025 02:29:16 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1758706155; x=1759310955;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=i/j0P/MSV+X5BLJW2jx5BBKNa2M5lI05wnZcxCRbxSk=;
 b=P5dpGzEIkXQylxdIo26kHarcbh3S/aoBrpAbxomZbrFDEQA3qK/jFjueiF2dAj/UEk
 z2xhzc2l/Fecf28Hjeku8EM09Sj5oGLA+MQqf9Bg3osEc0qi1Lh7zYzPjGNmerD6u5X/
 9Jv4Pj+1uRAEtB7hrbZuZ/Oi1xW1EgSwYk3+T2hPlH2z+mZQGfhewKfFCbaaucPRCgWy
 3vjfJylxD5R1Wgls1d+X+EufEENueq+Mg3KtDpB/cQ5wO8KFhG1otHwDVLCtdjsCE3G4
 PWHP4vrv3n7SVBWc0akNBIdc3uCuC2lfObMolYMdeEAEmxv4u49ltgs7dWtZ5atvveMU
 UEVg==
X-Gm-Message-State: AOJu0Yw/PwcGmouXHxYUnR2YBcSYiDyhhXJYXfHVf8hoziShwbP3NrJk
 HoN+DH0L14PgGgAAxG/Lj+Jrca0heglkan/BNamVtoAFZleSkO86DCdTfu0a3O+P+0ooVB4SYWr
 lttBYL3AghtDO6FXpSROtzDNi4K6XmmLF5JV0Ne/Tt/LtPXjn8cHuqP5PkQBjyJa4EoqrEXfmOT
 mXitUxHDn5dpb/8z4kMedEGYOq/rePNRLsAQ3mszEC
X-Gm-Gg: ASbGncvKIjVzmDndnMEVCdq7wc4A9AsLjRcFX8uqCYjRudmuJIaBkNzOQM23cPU0puv
 zOJZT8GAVecfS7CYMijoVbgTu79KKP3/4ItEmxJLal7CbaHLD+GNuQiMnuILHOpHDEoU2DcyWvh
 zc+uGmAejs8UdCmbMHi9ROIooxByPE10/q2u/oLP9N60KZXykzoorPuDAu1GVzMthNOWyQZxU16
 n5w9RP2vJfx4qJVwblP03h432DiOJs847HiU7HF/6xzzfjj7CYl8/tqJCg4DzBBbHAsnd7OEmVR
 OaMKbwwvM6Nf8DK6SeemduxfWM2HPQ5VI2q+bTQ5ll2EpYeNPsjdte4kLDvJFrkzTENPbKJHG9C
 CK85vQOuUg/GJLWcjCIzXSiWZVn/AbA2fOEfIqYQCwAP7QQ==
X-Received: by 2002:a17:907:d1a:b0:b2a:10a3:7112 with SMTP id
 a640c23a62f3a-b32caf90a7emr175817066b.24.1758706154963; 
 Wed, 24 Sep 2025 02:29:14 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGMlv3+YnITlkTGPOSxHh5xSGdLNPdYRVziQLvktkLpNKacbi9KQjjECAXYQhgJxXfHsYOOKQ==
X-Received: by 2002:a17:907:d1a:b0:b2a:10a3:7112 with SMTP id
 a640c23a62f3a-b32caf90a7emr175776166b.24.1758706146742; 
 Wed, 24 Sep 2025 02:29:06 -0700 (PDT)
Received: from [192.168.10.48] ([176.206.127.188])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-b2ba267f745sm720317166b.33.2025.09.24.02.29.05
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 24 Sep 2025 02:29:05 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PULL 06/29] rust: qemu-macros: switch #[property] parsing to use
 combinators
Date: Wed, 24 Sep 2025 11:28:26 +0200
Message-ID: <20250924092850.42047-7-pbonzini@redhat.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20250924092850.42047-1-pbonzini@redhat.com>
References: <20250924092850.42047-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.442,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

Since we are going to add more attribute parsing for high-level migration
state macros, use the attrs crate instead of a handwritten parser for
device properties as well.

Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 rust/Cargo.lock               | 11 +++++
 rust/qemu-macros/src/lib.rs   | 86 ++++++++++++++---------------------
 rust/qemu-macros/src/tests.rs |  8 ++--
 3 files changed, 49 insertions(+), 56 deletions(-)

diff --git a/rust/Cargo.lock b/rust/Cargo.lock
index eea928621a7..8315f98c46f 100644
--- a/rust/Cargo.lock
+++ b/rust/Cargo.lock
@@ -14,6 +14,16 @@ version = "1.2.7"
 source = "registry+https://github.com/rust-lang/crates.io-index"
 checksum = "c84fc003e338a6f69fbd4f7fe9f92b535ff13e9af8997f3b14b6ddff8b1df46d"
 
+[[package]]
+name = "attrs"
+version = "0.2.9"
+source = "registry+https://github.com/rust-lang/crates.io-index"
+checksum = "2a207d40f43de65285f3de0509bb6cb16bc46098864fce957122bbacce327e5f"
+dependencies = [
+ "proc-macro2",
+ "syn",
+]
+
 [[package]]
 name = "bilge"
 version = "0.2.0"
@@ -188,6 +198,7 @@ dependencies = [
 name = "qemu_macros"
 version = "0.1.0"
 dependencies = [
+ "attrs",
  "proc-macro2",
  "quote",
  "syn",
diff --git a/rust/qemu-macros/src/lib.rs b/rust/qemu-macros/src/lib.rs
index 830b4326985..7ab18061776 100644
--- a/rust/qemu-macros/src/lib.rs
+++ b/rust/qemu-macros/src/lib.rs
@@ -3,10 +3,14 @@
 // SPDX-License-Identifier: GPL-2.0-or-later
 
 use proc_macro::TokenStream;
-use quote::{quote, quote_spanned, ToTokens};
+use quote::{quote, quote_spanned};
 use syn::{
-    parse::Parse, parse_macro_input, parse_quote, punctuated::Punctuated, spanned::Spanned,
-    token::Comma, Data, DeriveInput, Error, Field, Fields, FieldsUnnamed, Ident, Meta, Path, Token,
+    parse::{Parse, ParseStream},
+    parse_macro_input, parse_quote,
+    punctuated::Punctuated,
+    spanned::Spanned,
+    token::Comma,
+    Attribute, Data, DeriveInput, Error, Field, Fields, FieldsUnnamed, Ident, Meta, Path, Token,
     Variant,
 };
 mod bits;
@@ -159,61 +163,37 @@ enum DevicePropertyName {
     Str(syn::LitStr),
 }
 
-#[derive(Debug)]
+impl Parse for DevicePropertyName {
+    fn parse(input: ParseStream<'_>) -> syn::Result<Self> {
+        let lo = input.lookahead1();
+        if lo.peek(syn::LitStr) {
+            Ok(Self::Str(input.parse()?))
+        } else if lo.peek(syn::LitCStr) {
+            Ok(Self::CStr(input.parse()?))
+        } else {
+            Err(lo.error())
+        }
+    }
+}
+
+#[derive(Default, Debug)]
 struct DeviceProperty {
     rename: Option<DevicePropertyName>,
     defval: Option<syn::Expr>,
 }
 
-impl Parse for DeviceProperty {
-    fn parse(input: syn::parse::ParseStream) -> syn::Result<Self> {
-        let _: syn::Token![#] = input.parse()?;
-        let bracketed;
-        _ = syn::bracketed!(bracketed in input);
-        let attribute = bracketed.parse::<syn::Ident>()?;
-        debug_assert_eq!(&attribute.to_string(), "property");
-        let mut retval = Self {
-            rename: None,
-            defval: None,
-        };
-        let content;
-        _ = syn::parenthesized!(content in bracketed);
-        while !content.is_empty() {
-            let value: syn::Ident = content.parse()?;
-            if value == "rename" {
-                let _: syn::Token![=] = content.parse()?;
-                if retval.rename.is_some() {
-                    return Err(syn::Error::new(
-                        value.span(),
-                        "`rename` can only be used at most once",
-                    ));
-                }
-                if content.peek(syn::LitStr) {
-                    retval.rename = Some(DevicePropertyName::Str(content.parse::<syn::LitStr>()?));
-                } else {
-                    retval.rename =
-                        Some(DevicePropertyName::CStr(content.parse::<syn::LitCStr>()?));
-                }
-            } else if value == "default" {
-                let _: syn::Token![=] = content.parse()?;
-                if retval.defval.is_some() {
-                    return Err(syn::Error::new(
-                        value.span(),
-                        "`default` can only be used at most once",
-                    ));
-                }
-                retval.defval = Some(content.parse()?);
-            } else {
-                return Err(syn::Error::new(
-                    value.span(),
-                    format!("unrecognized field `{value}`"),
-                ));
-            }
+impl DeviceProperty {
+    fn parse_from(&mut self, a: &Attribute) -> syn::Result<()> {
+        use attrs::{set, with, Attrs};
+        let mut parser = Attrs::new();
+        parser.once("rename", with::eq(set::parse(&mut self.rename)));
+        parser.once("default", with::eq(set::parse(&mut self.defval)));
+        a.parse_args_with(&mut parser)
+    }
 
-            if !content.is_empty() {
-                let _: syn::Token![,] = content.parse()?;
-            }
-        }
+    fn parse(a: &Attribute) -> syn::Result<Self> {
+        let mut retval = Self::default();
+        retval.parse_from(a)?;
         Ok(retval)
     }
 }
@@ -235,7 +215,7 @@ fn derive_device_or_error(input: DeriveInput) -> Result<proc_macro2::TokenStream
             f.attrs
                 .iter()
                 .filter(|a| a.path().is_ident("property"))
-                .map(|a| Ok((f.clone(), syn::parse2(a.to_token_stream())?)))
+                .map(|a| Ok((f.clone(), DeviceProperty::parse(a)?)))
         })
         .collect::<Result<Vec<_>, Error>>()?;
     let name = &input.ident;
diff --git a/rust/qemu-macros/src/tests.rs b/rust/qemu-macros/src/tests.rs
index 9ab7eab7f37..00a106612fc 100644
--- a/rust/qemu-macros/src/tests.rs
+++ b/rust/qemu-macros/src/tests.rs
@@ -60,7 +60,7 @@ struct DummyState {
                 migrate_clock: bool,
             }
         },
-        "unrecognized field `defalt`"
+        "Expected one of `default` or `rename`"
     );
     // Check that repeated attributes are not allowed:
     derive_compile_fail!(
@@ -73,7 +73,8 @@ struct DummyState {
                 migrate_clock: bool,
             }
         },
-        "`rename` can only be used at most once"
+        "Duplicate argument",
+        "Already used here",
     );
     derive_compile_fail!(
         derive_device_or_error,
@@ -85,7 +86,8 @@ struct DummyState {
                 migrate_clock: bool,
             }
         },
-        "`default` can only be used at most once"
+        "Duplicate argument",
+        "Already used here",
     );
     // Check that the field name is preserved when `rename` isn't used:
     derive_compile!(
-- 
2.51.0


