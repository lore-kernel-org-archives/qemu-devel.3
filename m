Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 76EC4E77184
	for <qemu-devel@archiver.kernel.org>; Thu, 19 Dec 2024 16:37:03 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tOJGI-0002Rn-At; Thu, 19 Dec 2024 11:20:30 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1tOFsX-0002KC-Si
 for qemu-devel@nongnu.org; Thu, 19 Dec 2024 07:43:45 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1tOFsW-0006R5-Cg
 for qemu-devel@nongnu.org; Thu, 19 Dec 2024 07:43:45 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1734612222;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Szoag27KIkqUli3n0xSrTUcaxn0aravcRGL/6Nt+Rm8=;
 b=BB6HSiZPiNwrHDpP0Y/io6IihDGxJoF+jkQiEI+PSG4ho+qxUoRcVVG7bDOL3xpTVDNYaW
 4DdQ3+d1Vi7pBF+JPt4aI1Wq3MGAa24yPC1imdRTLQAZscf/3nV7MnCsHA9l2qQAz85LKW
 4ngMOGXOVsRQVffdHU/UyK2S4WoHvJk=
Received: from mail-lj1-f198.google.com (mail-lj1-f198.google.com
 [209.85.208.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-341-zWV4_998OiWkrToLU5q9kg-1; Thu, 19 Dec 2024 07:43:41 -0500
X-MC-Unique: zWV4_998OiWkrToLU5q9kg-1
X-Mimecast-MFC-AGG-ID: zWV4_998OiWkrToLU5q9kg
Received: by mail-lj1-f198.google.com with SMTP id
 38308e7fff4ca-3023f0f1852so4072261fa.1
 for <qemu-devel@nongnu.org>; Thu, 19 Dec 2024 04:43:41 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1734612219; x=1735217019;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Szoag27KIkqUli3n0xSrTUcaxn0aravcRGL/6Nt+Rm8=;
 b=prfouKt2IxEwhiL/deMFH7+MXAEh2dRWefA/Cch9C0IJAoDQBRtsxdKfY/JGCCtxBC
 A+jkpDzlYPkiRKH31e9CG+hP/zmq92GxiTCkkR53r5KgCU4qiKc3K7LHnX8zPH/M8qQC
 FiWEoDatj2czGRDVNE0wLVeRG+5dPQyyHUQXDX0H7HN3Q8kOx1hXzD4sRlGsNlFcx4ub
 TspBgeSKxuiHMFf/a03dggzD+PA11TOo7YXR395r+I3RHjoS8cTWBR1+yp8xehYYNOPd
 XkRLSEiv9HqGw6NSMVFNQfczlMzg+j9icQSVsf0DXNeoVe1ScNLK4zPOEE9vPy9UGLYy
 j77g==
X-Gm-Message-State: AOJu0YzOH8ZEkwepmgtdPLxmGMXVUJxnbuZBBTta34dzu28Mh6F2xdcG
 VDjT1oPdXfInVq35N2xR9pS74qtyXMP6woTn7S3u5PBUzxQGn6JpO0vqSOVA+05wTvkQiNWhq1T
 ccnxVqlYVqrhcC32CB1vP7YbC8eRLEDuvHwkbrzd/7pk2t+eGIci9e11eAH47Liq7Okr6rEGtZK
 vm4Tdf0qeBIergaS82XXxNpYee8ottqMsPIcNG
X-Gm-Gg: ASbGncuqRvMjgCMHrRV1ZNugjEyv2jyLwnLxZe+NZISG5Si4+BLDkuksZAsNEN6W86O
 yVJguMiGHIPTodbqN4tK0JeE+MQ9JVfnAgfxMS1j01FlhGGyhSavl/ZsFCteFt7loLlb4etNtCc
 v5+HWE+vQttPubuqnQvgUR/ZMjojEmboYPsvtC5wdiBT6iHrRaO1ha8kTTHm4QlFKDhc3pbGRQ1
 ufejjtAbctchFe6NWAVp9Bc4z/si8LytwQjkdrruBz3+T3kcdMx5OB1+SDG
X-Received: by 2002:a05:600c:2303:b0:434:f335:83b with SMTP id
 5b1f17b1804b1-4365c77e441mr26215515e9.5.1734610359393; 
 Thu, 19 Dec 2024 04:12:39 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFp8w+yg9TiVsrWbDzZp13nv15+EZCExns15U2PsP9opFPSacpvlxA3rOl0ZzAZrcvWhUDiFg==
X-Received: by 2002:a05:600c:2303:b0:434:f335:83b with SMTP id
 5b1f17b1804b1-4365c77e441mr26215205e9.5.1734610358873; 
 Thu, 19 Dec 2024 04:12:38 -0800 (PST)
Received: from [192.168.10.47] ([151.81.118.45])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-38a1c828897sm1416417f8f.20.2024.12.19.04.12.36
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 19 Dec 2024 04:12:36 -0800 (PST)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Cc: zhao1.liu@intel.com
Subject: [PATCH 09/10] rust: qemu-api-macros: extend error reporting facility
 to parse errors
Date: Thu, 19 Dec 2024 13:12:15 +0100
Message-ID: <20241219121216.416905-10-pbonzini@redhat.com>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20241219121216.416905-1-pbonzini@redhat.com>
References: <20241219121216.416905-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -31
X-Spam_score: -3.2
X-Spam_bar: ---
X-Spam_report: (-3.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-1.116,
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

Generalize the CompileError tuple to an enum, that can be either an error
message or a parse error from syn.

Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 rust/qemu-api-macros/src/lib.rs   | 27 ++++++++++-----------------
 rust/qemu-api-macros/src/utils.rs | 26 ++++++++++++++++++++++++++
 2 files changed, 36 insertions(+), 17 deletions(-)
 create mode 100644 rust/qemu-api-macros/src/utils.rs

diff --git a/rust/qemu-api-macros/src/lib.rs b/rust/qemu-api-macros/src/lib.rs
index 0f04cca3841..539c48df298 100644
--- a/rust/qemu-api-macros/src/lib.rs
+++ b/rust/qemu-api-macros/src/lib.rs
@@ -3,57 +3,50 @@
 // SPDX-License-Identifier: GPL-2.0-or-later
 
 use proc_macro::TokenStream;
-use proc_macro2::Span;
-use quote::{quote, quote_spanned};
+use quote::quote;
 use syn::{
     parse_macro_input, parse_quote, punctuated::Punctuated, token::Comma, Data, DeriveInput, Field,
     Fields, Ident, Type, Visibility,
 };
 
-struct CompileError(String, Span);
-
-impl From<CompileError> for proc_macro2::TokenStream {
-    fn from(err: CompileError) -> Self {
-        let CompileError(msg, span) = err;
-        quote_spanned! { span => compile_error!(#msg); }
-    }
-}
+mod utils;
+use utils::MacroError;
 
 fn get_fields<'a>(
     input: &'a DeriveInput,
     msg: &str,
-) -> Result<&'a Punctuated<Field, Comma>, CompileError> {
+) -> Result<&'a Punctuated<Field, Comma>, MacroError> {
     if let Data::Struct(s) = &input.data {
         if let Fields::Named(fs) = &s.fields {
             Ok(&fs.named)
         } else {
-            Err(CompileError(
+            Err(MacroError::Message(
                 format!("Named fields required for {}", msg),
                 input.ident.span(),
             ))
         }
     } else {
-        Err(CompileError(
+        Err(MacroError::Message(
             format!("Struct required for {}", msg),
             input.ident.span(),
         ))
     }
 }
 
-fn is_c_repr(input: &DeriveInput, msg: &str) -> Result<(), CompileError> {
+fn is_c_repr(input: &DeriveInput, msg: &str) -> Result<(), MacroError> {
     let expected = parse_quote! { #[repr(C)] };
 
     if input.attrs.iter().any(|attr| attr == &expected) {
         Ok(())
     } else {
-        Err(CompileError(
+        Err(MacroError::Message(
             format!("#[repr(C)] required for {}", msg),
             input.ident.span(),
         ))
     }
 }
 
-fn derive_object_or_error(input: DeriveInput) -> Result<proc_macro2::TokenStream, CompileError> {
+fn derive_object_or_error(input: DeriveInput) -> Result<proc_macro2::TokenStream, MacroError> {
     is_c_repr(&input, "#[derive(Object)]")?;
 
     let name = &input.ident;
@@ -80,7 +73,7 @@ pub fn derive_object(input: TokenStream) -> TokenStream {
 }
 
 #[rustfmt::skip::macros(quote)]
-fn derive_offsets_or_error(input: DeriveInput) -> Result<proc_macro2::TokenStream, CompileError> {
+fn derive_offsets_or_error(input: DeriveInput) -> Result<proc_macro2::TokenStream, MacroError> {
     is_c_repr(&input, "#[derive(offsets)]")?;
 
     let name = &input.ident;
diff --git a/rust/qemu-api-macros/src/utils.rs b/rust/qemu-api-macros/src/utils.rs
new file mode 100644
index 00000000000..02c91aed7f6
--- /dev/null
+++ b/rust/qemu-api-macros/src/utils.rs
@@ -0,0 +1,26 @@
+// Procedural macro utilities.
+// Author(s): Paolo Bonzini <pbonzini@redhat.com>
+// SPDX-License-Identifier: GPL-2.0-or-later
+
+use proc_macro2::Span;
+use quote::quote_spanned;
+
+pub enum MacroError {
+    Message(String, Span),
+    ParseError(syn::Error),
+}
+
+impl From<syn::Error> for MacroError {
+    fn from(err: syn::Error) -> Self {
+        MacroError::ParseError(err)
+    }
+}
+
+impl From<MacroError> for proc_macro2::TokenStream {
+    fn from(err: MacroError) -> Self {
+        match err {
+            MacroError::Message(msg, span) => quote_spanned! { span => compile_error!(#msg); },
+            MacroError::ParseError(err) => err.into_compile_error(),
+        }
+    }
+}
-- 
2.47.1


