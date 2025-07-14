Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D3F46C83F1B
	for <qemu-devel@archiver.kernel.org>; Mon, 14 Jul 2025 11:13:19 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ubH78-0007pL-OJ; Mon, 14 Jul 2025 07:13:02 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1ubGyx-0000Yu-CE
 for qemu-devel@nongnu.org; Mon, 14 Jul 2025 07:04:43 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1ubGys-0001Uv-M3
 for qemu-devel@nongnu.org; Mon, 14 Jul 2025 07:04:26 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1752491058;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Iz1uX/fPHm96LL/GLvQKBENI0zWW46MxM6ylmWl1pqE=;
 b=dyveLpKV2gpd7NYI3TNbeFsLXL/yo6Cgr+xum2U0t26MUc4gYMNCZfLXOs4hsIcReVbvhv
 oszy7dwj/VYXcy1ltmhWoaKGYcwhWN60IZRiG8JXBZuUINlS1vrin7H9IWY0JDyonGRKIz
 QVfF8fqtkqLWMh4gIXR0WRQyN1P0HiA=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-34-XEY-bza7P0y8Gl5vZlOwig-1; Mon, 14 Jul 2025 07:04:17 -0400
X-MC-Unique: XEY-bza7P0y8Gl5vZlOwig-1
X-Mimecast-MFC-AGG-ID: XEY-bza7P0y8Gl5vZlOwig_1752491056
Received: by mail-wm1-f71.google.com with SMTP id
 5b1f17b1804b1-45526e19f43so10418305e9.3
 for <qemu-devel@nongnu.org>; Mon, 14 Jul 2025 04:04:16 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1752491055; x=1753095855;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Iz1uX/fPHm96LL/GLvQKBENI0zWW46MxM6ylmWl1pqE=;
 b=pa1N4DWv0SU6nzyCOyyDdhWKdbDzoKE5kwUigFmu705O7s88gUTcVke67aVhhpGXcL
 r0xKmZ8unQLrqIWiXjbi0tJ6MpzIzALdUnRGWiB1AZHFUgGKVfk/0P1P7iD3o6I9t1jW
 WEG2zmIE3lbkP3DihsQGZNmlt4w1hJLEvaL2/McEag/ekMJTVXRupr9QU45c0Np+TGM2
 QUeZP96Bq0fOsq5FIb1AjXZahqXBZjLEo6MxdooARQzYxVIHf9g4Ktpfo+H4KZcid79G
 rJVHB+smj7SCeyHyTuwZRSvlZThVhgAZ9tUu/tcbwHTp7V1RyuWqh/veN1m9c/aEFHKE
 /T9g==
X-Gm-Message-State: AOJu0Yzl9+Cej7TTycaA0bpfNkLU/19SbpwgUNVSn1Fi/To/8ctz1HzX
 RSp7aS2THwqy5pu69j9zAoODn/8rTfGq/YpZpYZIIbuvRe9Ne/O/L/M+QOxnNx6Ina6w6p+0WoW
 6S6rY4jcYddvUtXtWk9GaWGs2NyRZlXoCEk4C35JtAZUVfARv6W7ODWHGeLVwLV58VpS8HuwDLS
 YwhZPUcT17NUMy73/YAJk6KPS2TLsDiCO3S3r8Ewd3
X-Gm-Gg: ASbGncv+VWSJlukC0pXVmiPqSIyjgny5JdMfGLo/UFO5PlQzpnutXbUv8BuleZ41fEv
 VnQJX13LpkYms8su8bFFKlA5aSbI6pEaPr4NeLYJz8PBofMpk86w2plwEQt1JIwsSOtDYJbBu2d
 e6559J190Fao9F/so6VIZPC0X81GXrtGnoNb4PvX4TyIr3jJKyxYGhGYHWo0KGOsmEDms6/mYin
 o1dR1z9FISZGniWx/73oRpTQvPk+X3n7SPUHfdbQl4t0SgnFq5lhgRqw75z0zuZu9WSnfmhFwR5
 GOaq/dohdH7FjsOLso5/Hxtxz+iYGX+52MeNP0+gnwE=
X-Received: by 2002:a05:600c:821a:b0:456:207e:fd86 with SMTP id
 5b1f17b1804b1-456207f008bmr15525845e9.2.1752491054391; 
 Mon, 14 Jul 2025 04:04:14 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGwA7B+PRARDDHe8M7qvyewZTH9ldlNqFXdXmb+qMMgOtnjvXHfGCnl7TC795fk/9tBHt0qiw==
X-Received: by 2002:a05:600c:821a:b0:456:207e:fd86 with SMTP id
 5b1f17b1804b1-456207f008bmr15525125e9.2.1752491053534; 
 Mon, 14 Jul 2025 04:04:13 -0700 (PDT)
Received: from [192.168.10.48] ([151.49.73.155])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3b5e8e0d785sm12355227f8f.59.2025.07.14.04.04.10
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 14 Jul 2025 04:04:10 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Cc: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>
Subject: [PULL 02/77] rust/qemu-api-macros: use syn::Error directly
Date: Mon, 14 Jul 2025 13:02:51 +0200
Message-ID: <20250714110406.117772-3-pbonzini@redhat.com>
X-Mailer: git-send-email 2.50.0
In-Reply-To: <20250714110406.117772-1-pbonzini@redhat.com>
References: <20250714110406.117772-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

From: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>

Our MacroError type wraps syn::Error as a variant, and uses another
variant for custom errors. Fortunately syn::Error can be used directly,
avoiding extra code on our side, so change the proc macro crate to use
it.

Signed-off-by: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>
Link: https://lore.kernel.org/r/20250703-rust_macros-v1-1-b99f82febbbf@linaro.org
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 docs/devel/rust.rst               | 11 ++--
 rust/qemu-api-macros/src/bits.rs  | 58 ++++++++-------------
 rust/qemu-api-macros/src/lib.rs   | 86 +++++++++++++++----------------
 rust/qemu-api-macros/src/utils.rs | 26 ----------
 4 files changed, 70 insertions(+), 111 deletions(-)
 delete mode 100644 rust/qemu-api-macros/src/utils.rs

diff --git a/docs/devel/rust.rst b/docs/devel/rust.rst
index dc8c44109e1..b6737536c69 100644
--- a/docs/devel/rust.rst
+++ b/docs/devel/rust.rst
@@ -351,7 +351,7 @@ Writing procedural macros
 '''''''''''''''''''''''''
 
 By conventions, procedural macros are split in two functions, one
-returning ``Result<proc_macro2::TokenStream, MacroError>`` with the body of
+returning ``Result<proc_macro2::TokenStream, syn::Error>`` with the body of
 the procedural macro, and the second returning ``proc_macro::TokenStream``
 which is the actual procedural macro.  The former's name is the same as
 the latter with the ``_or_error`` suffix.  The code for the latter is more
@@ -361,18 +361,19 @@ from the type after ``as`` in the invocation of ``parse_macro_input!``::
     #[proc_macro_derive(Object)]
     pub fn derive_object(input: TokenStream) -> TokenStream {
         let input = parse_macro_input!(input as DeriveInput);
-        let expanded = derive_object_or_error(input).unwrap_or_else(Into::into);
 
-        TokenStream::from(expanded)
+        derive_object_or_error(input)
+            .unwrap_or_else(syn::Error::into_compile_error)
+            .into()
     }
 
 The ``qemu_api_macros`` crate has utility functions to examine a
 ``DeriveInput`` and perform common checks (e.g. looking for a struct
-with named fields).  These functions return ``Result<..., MacroError>``
+with named fields).  These functions return ``Result<..., syn::Error>``
 and can be used easily in the procedural macro function::
 
     fn derive_object_or_error(input: DeriveInput) ->
-        Result<proc_macro2::TokenStream, MacroError>
+        Result<proc_macro2::TokenStream, Error>
     {
         is_c_repr(&input, "#[derive(Object)]")?;
 
diff --git a/rust/qemu-api-macros/src/bits.rs b/rust/qemu-api-macros/src/bits.rs
index 5ba84757ee0..a80a3b9fee1 100644
--- a/rust/qemu-api-macros/src/bits.rs
+++ b/rust/qemu-api-macros/src/bits.rs
@@ -6,8 +6,7 @@
 use proc_macro2::{
     Delimiter, Group, Ident, Punct, Spacing, Span, TokenStream, TokenTree, TokenTree as TT,
 };
-
-use crate::utils::MacroError;
+use syn::Error;
 
 pub struct BitsConstInternal {
     typ: TokenTree,
@@ -36,27 +35,21 @@ fn parse_primary(
         tok: TokenTree,
         it: &mut dyn Iterator<Item = TokenTree>,
         out: &mut TokenStream,
-    ) -> Result<Option<TokenTree>, MacroError> {
+    ) -> Result<Option<TokenTree>, Error> {
         let next = match tok {
             TT::Group(ref g) => {
                 if g.delimiter() != Delimiter::Parenthesis && g.delimiter() != Delimiter::None {
-                    return Err(MacroError::Message("expected parenthesis".into(), g.span()));
+                    return Err(Error::new(g.span(), "expected parenthesis"));
                 }
                 let mut stream = g.stream().into_iter();
                 let Some(first_tok) = stream.next() else {
-                    return Err(MacroError::Message(
-                        "expected operand, found ')'".into(),
-                        g.span(),
-                    ));
+                    return Err(Error::new(g.span(), "expected operand, found ')'"));
                 };
                 let mut output = TokenStream::new();
                 // start from the lowest precedence
                 let next = self.parse_or(first_tok, &mut stream, &mut output)?;
                 if let Some(tok) = next {
-                    return Err(MacroError::Message(
-                        format!("unexpected token {tok}"),
-                        tok.span(),
-                    ));
+                    return Err(Error::new(tok.span(), format!("unexpected token {tok}")));
                 }
                 out.extend(Some(paren(output)));
                 it.next()
@@ -74,20 +67,17 @@ fn parse_primary(
             }
             TT::Punct(ref p) => {
                 if p.as_char() != '!' {
-                    return Err(MacroError::Message("expected operand".into(), p.span()));
+                    return Err(Error::new(p.span(), "expected operand"));
                 }
                 let Some(rhs_tok) = it.next() else {
-                    return Err(MacroError::Message(
-                        "expected operand at end of input".into(),
-                        p.span(),
-                    ));
+                    return Err(Error::new(p.span(), "expected operand at end of input"));
                 };
                 let next = self.parse_primary(rhs_tok, it, out)?;
                 out.extend([punct('.'), ident("invert"), paren(TokenStream::new())]);
                 next
             }
             _ => {
-                return Err(MacroError::Message("unexpected literal".into(), tok.span()));
+                return Err(Error::new(tok.span(), "unexpected literal"));
             }
         };
         Ok(next)
@@ -99,7 +89,7 @@ fn parse_binop<
             TokenTree,
             &mut dyn Iterator<Item = TokenTree>,
             &mut TokenStream,
-        ) -> Result<Option<TokenTree>, MacroError>,
+        ) -> Result<Option<TokenTree>, Error>,
     >(
         &self,
         tok: TokenTree,
@@ -108,7 +98,7 @@ fn parse_binop<
         ch: char,
         f: F,
         method: &'static str,
-    ) -> Result<Option<TokenTree>, MacroError> {
+    ) -> Result<Option<TokenTree>, Error> {
         let mut next = f(self, tok, it, out)?;
         while next.is_some() {
             let op = next.as_ref().unwrap();
@@ -118,10 +108,7 @@ fn parse_binop<
             }
 
             let Some(rhs_tok) = it.next() else {
-                return Err(MacroError::Message(
-                    "expected operand at end of input".into(),
-                    p.span(),
-                ));
+                return Err(Error::new(p.span(), "expected operand at end of input"));
             };
             let mut rhs = TokenStream::new();
             next = f(self, rhs_tok, it, &mut rhs)?;
@@ -136,7 +123,7 @@ pub fn parse_sub(
         tok: TokenTree,
         it: &mut dyn Iterator<Item = TokenTree>,
         out: &mut TokenStream,
-    ) -> Result<Option<TokenTree>, MacroError> {
+    ) -> Result<Option<TokenTree>, Error> {
         self.parse_binop(tok, it, out, '-', Self::parse_primary, "difference")
     }
 
@@ -146,7 +133,7 @@ fn parse_and(
         tok: TokenTree,
         it: &mut dyn Iterator<Item = TokenTree>,
         out: &mut TokenStream,
-    ) -> Result<Option<TokenTree>, MacroError> {
+    ) -> Result<Option<TokenTree>, Error> {
         self.parse_binop(tok, it, out, '&', Self::parse_sub, "intersection")
     }
 
@@ -156,7 +143,7 @@ fn parse_xor(
         tok: TokenTree,
         it: &mut dyn Iterator<Item = TokenTree>,
         out: &mut TokenStream,
-    ) -> Result<Option<TokenTree>, MacroError> {
+    ) -> Result<Option<TokenTree>, Error> {
         self.parse_binop(tok, it, out, '^', Self::parse_and, "symmetric_difference")
     }
 
@@ -166,13 +153,13 @@ pub fn parse_or(
         tok: TokenTree,
         it: &mut dyn Iterator<Item = TokenTree>,
         out: &mut TokenStream,
-    ) -> Result<Option<TokenTree>, MacroError> {
+    ) -> Result<Option<TokenTree>, Error> {
         self.parse_binop(tok, it, out, '|', Self::parse_xor, "union")
     }
 
     pub fn parse(
         it: &mut dyn Iterator<Item = TokenTree>,
-    ) -> Result<proc_macro2::TokenStream, MacroError> {
+    ) -> Result<proc_macro2::TokenStream, Error> {
         let mut pos = Span::call_site();
         let mut typ = proc_macro2::TokenStream::new();
 
@@ -198,15 +185,15 @@ pub fn parse(
         };
 
         let Some(tok) = next else {
-            return Err(MacroError::Message(
-                "expected expression, do not call this macro directly".into(),
+            return Err(Error::new(
                 pos,
+                "expected expression, do not call this macro directly",
             ));
         };
         let TT::Group(ref _group) = tok else {
-            return Err(MacroError::Message(
-                "expected parenthesis, do not call this macro directly".into(),
+            return Err(Error::new(
                 tok.span(),
+                "expected parenthesis, do not call this macro directly",
             ));
         };
         let mut out = TokenStream::new();
@@ -219,10 +206,7 @@ pub fn parse(
         // A parenthesized expression is a single production of the grammar,
         // so the input must have reached the last token.
         if let Some(tok) = next {
-            return Err(MacroError::Message(
-                format!("unexpected token {tok}"),
-                tok.span(),
-            ));
+            return Err(Error::new(tok.span(), format!("unexpected token {tok}")));
         }
         Ok(out)
     }
diff --git a/rust/qemu-api-macros/src/lib.rs b/rust/qemu-api-macros/src/lib.rs
index c18bb4e036f..2cb79c799a2 100644
--- a/rust/qemu-api-macros/src/lib.rs
+++ b/rust/qemu-api-macros/src/lib.rs
@@ -6,83 +6,79 @@
 use quote::quote;
 use syn::{
     parse_macro_input, parse_quote, punctuated::Punctuated, spanned::Spanned, token::Comma, Data,
-    DeriveInput, Field, Fields, FieldsUnnamed, Ident, Meta, Path, Token, Variant,
+    DeriveInput, Error, Field, Fields, FieldsUnnamed, Ident, Meta, Path, Token, Variant,
 };
-
-mod utils;
-use utils::MacroError;
-
 mod bits;
 use bits::BitsConstInternal;
 
 fn get_fields<'a>(
     input: &'a DeriveInput,
     msg: &str,
-) -> Result<&'a Punctuated<Field, Comma>, MacroError> {
+) -> Result<&'a Punctuated<Field, Comma>, Error> {
     let Data::Struct(ref s) = &input.data else {
-        return Err(MacroError::Message(
-            format!("Struct required for {msg}"),
+        return Err(Error::new(
             input.ident.span(),
+            format!("Struct required for {msg}"),
         ));
     };
     let Fields::Named(ref fs) = &s.fields else {
-        return Err(MacroError::Message(
-            format!("Named fields required for {msg}"),
+        return Err(Error::new(
             input.ident.span(),
+            format!("Named fields required for {msg}"),
         ));
     };
     Ok(&fs.named)
 }
 
-fn get_unnamed_field<'a>(input: &'a DeriveInput, msg: &str) -> Result<&'a Field, MacroError> {
+fn get_unnamed_field<'a>(input: &'a DeriveInput, msg: &str) -> Result<&'a Field, Error> {
     let Data::Struct(ref s) = &input.data else {
-        return Err(MacroError::Message(
-            format!("Struct required for {msg}"),
+        return Err(Error::new(
             input.ident.span(),
+            format!("Struct required for {msg}"),
         ));
     };
     let Fields::Unnamed(FieldsUnnamed { ref unnamed, .. }) = &s.fields else {
-        return Err(MacroError::Message(
-            format!("Tuple struct required for {msg}"),
+        return Err(Error::new(
             s.fields.span(),
+            format!("Tuple struct required for {msg}"),
         ));
     };
     if unnamed.len() != 1 {
-        return Err(MacroError::Message(
-            format!("A single field is required for {msg}"),
+        return Err(Error::new(
             s.fields.span(),
+            format!("A single field is required for {msg}"),
         ));
     }
     Ok(&unnamed[0])
 }
 
-fn is_c_repr(input: &DeriveInput, msg: &str) -> Result<(), MacroError> {
+fn is_c_repr(input: &DeriveInput, msg: &str) -> Result<(), Error> {
     let expected = parse_quote! { #[repr(C)] };
 
     if input.attrs.iter().any(|attr| attr == &expected) {
         Ok(())
     } else {
-        Err(MacroError::Message(
-            format!("#[repr(C)] required for {msg}"),
+        Err(Error::new(
             input.ident.span(),
+            format!("#[repr(C)] required for {msg}"),
         ))
     }
 }
 
-fn is_transparent_repr(input: &DeriveInput, msg: &str) -> Result<(), MacroError> {
+fn is_transparent_repr(input: &DeriveInput, msg: &str) -> Result<(), Error> {
     let expected = parse_quote! { #[repr(transparent)] };
 
     if input.attrs.iter().any(|attr| attr == &expected) {
         Ok(())
     } else {
-        Err(MacroError::Message(
-            format!("#[repr(transparent)] required for {msg}"),
+        Err(Error::new(
             input.ident.span(),
+            format!("#[repr(transparent)] required for {msg}"),
         ))
     }
 }
 
-fn derive_object_or_error(input: DeriveInput) -> Result<proc_macro2::TokenStream, MacroError> {
+fn derive_object_or_error(input: DeriveInput) -> Result<proc_macro2::TokenStream, Error> {
     is_c_repr(&input, "#[derive(Object)]")?;
 
     let name = &input.ident;
@@ -103,12 +99,13 @@ fn derive_object_or_error(input: DeriveInput) -> Result<proc_macro2::TokenStream
 #[proc_macro_derive(Object)]
 pub fn derive_object(input: TokenStream) -> TokenStream {
     let input = parse_macro_input!(input as DeriveInput);
-    let expanded = derive_object_or_error(input).unwrap_or_else(Into::into);
 
-    TokenStream::from(expanded)
+    derive_object_or_error(input)
+        .unwrap_or_else(syn::Error::into_compile_error)
+        .into()
 }
 
-fn derive_opaque_or_error(input: DeriveInput) -> Result<proc_macro2::TokenStream, MacroError> {
+fn derive_opaque_or_error(input: DeriveInput) -> Result<proc_macro2::TokenStream, Error> {
     is_transparent_repr(&input, "#[derive(Wrapper)]")?;
 
     let name = &input.ident;
@@ -149,13 +146,14 @@ pub const fn raw_get(slot: *mut Self) -> *mut <Self as crate::cell::Wrapper>::Wr
 #[proc_macro_derive(Wrapper)]
 pub fn derive_opaque(input: TokenStream) -> TokenStream {
     let input = parse_macro_input!(input as DeriveInput);
-    let expanded = derive_opaque_or_error(input).unwrap_or_else(Into::into);
 
-    TokenStream::from(expanded)
+    derive_opaque_or_error(input)
+        .unwrap_or_else(syn::Error::into_compile_error)
+        .into()
 }
 
 #[allow(non_snake_case)]
-fn get_repr_uN(input: &DeriveInput, msg: &str) -> Result<Path, MacroError> {
+fn get_repr_uN(input: &DeriveInput, msg: &str) -> Result<Path, Error> {
     let repr = input.attrs.iter().find(|attr| attr.path().is_ident("repr"));
     if let Some(repr) = repr {
         let nested = repr.parse_args_with(Punctuated::<Meta, Token![,]>::parse_terminated)?;
@@ -170,23 +168,23 @@ fn get_repr_uN(input: &DeriveInput, msg: &str) -> Result<Path, MacroError> {
         }
     }
 
-    Err(MacroError::Message(
-        format!("#[repr(u8/u16/u32/u64) required for {msg}"),
+    Err(Error::new(
         input.ident.span(),
+        format!("#[repr(u8/u16/u32/u64) required for {msg}"),
     ))
 }
 
-fn get_variants(input: &DeriveInput) -> Result<&Punctuated<Variant, Comma>, MacroError> {
+fn get_variants(input: &DeriveInput) -> Result<&Punctuated<Variant, Comma>, Error> {
     let Data::Enum(ref e) = &input.data else {
-        return Err(MacroError::Message(
-            "Cannot derive TryInto for union or struct.".to_string(),
+        return Err(Error::new(
             input.ident.span(),
+            "Cannot derive TryInto for union or struct.",
         ));
     };
     if let Some(v) = e.variants.iter().find(|v| v.fields != Fields::Unit) {
-        return Err(MacroError::Message(
-            "Cannot derive TryInto for enum with non-unit variants.".to_string(),
+        return Err(Error::new(
             v.fields.span(),
+            "Cannot derive TryInto for enum with non-unit variants.",
         ));
     }
     Ok(&e.variants)
@@ -197,7 +195,7 @@ fn derive_tryinto_body(
     name: &Ident,
     variants: &Punctuated<Variant, Comma>,
     repr: &Path,
-) -> Result<proc_macro2::TokenStream, MacroError> {
+) -> Result<proc_macro2::TokenStream, Error> {
     let discriminants: Vec<&Ident> = variants.iter().map(|f| &f.ident).collect();
 
     Ok(quote! {
@@ -210,7 +208,7 @@ fn derive_tryinto_body(
 }
 
 #[rustfmt::skip::macros(quote)]
-fn derive_tryinto_or_error(input: DeriveInput) -> Result<proc_macro2::TokenStream, MacroError> {
+fn derive_tryinto_or_error(input: DeriveInput) -> Result<proc_macro2::TokenStream, Error> {
     let repr = get_repr_uN(&input, "#[derive(TryInto)]")?;
     let name = &input.ident;
     let body = derive_tryinto_body(name, get_variants(&input)?, &repr)?;
@@ -247,9 +245,10 @@ fn try_from(value: #repr) -> Result<Self, #repr> {
 #[proc_macro_derive(TryInto)]
 pub fn derive_tryinto(input: TokenStream) -> TokenStream {
     let input = parse_macro_input!(input as DeriveInput);
-    let expanded = derive_tryinto_or_error(input).unwrap_or_else(Into::into);
 
-    TokenStream::from(expanded)
+    derive_tryinto_or_error(input)
+        .unwrap_or_else(syn::Error::into_compile_error)
+        .into()
 }
 
 #[proc_macro]
@@ -257,6 +256,7 @@ pub fn bits_const_internal(ts: TokenStream) -> TokenStream {
     let ts = proc_macro2::TokenStream::from(ts);
     let mut it = ts.into_iter();
 
-    let expanded = BitsConstInternal::parse(&mut it).unwrap_or_else(Into::into);
-    TokenStream::from(expanded)
+    BitsConstInternal::parse(&mut it)
+        .unwrap_or_else(syn::Error::into_compile_error)
+        .into()
 }
diff --git a/rust/qemu-api-macros/src/utils.rs b/rust/qemu-api-macros/src/utils.rs
deleted file mode 100644
index 02c91aed7f6..00000000000
--- a/rust/qemu-api-macros/src/utils.rs
+++ /dev/null
@@ -1,26 +0,0 @@
-// Procedural macro utilities.
-// Author(s): Paolo Bonzini <pbonzini@redhat.com>
-// SPDX-License-Identifier: GPL-2.0-or-later
-
-use proc_macro2::Span;
-use quote::quote_spanned;
-
-pub enum MacroError {
-    Message(String, Span),
-    ParseError(syn::Error),
-}
-
-impl From<syn::Error> for MacroError {
-    fn from(err: syn::Error) -> Self {
-        MacroError::ParseError(err)
-    }
-}
-
-impl From<MacroError> for proc_macro2::TokenStream {
-    fn from(err: MacroError) -> Self {
-        match err {
-            MacroError::Message(msg, span) => quote_spanned! { span => compile_error!(#msg); },
-            MacroError::ParseError(err) => err.into_compile_error(),
-        }
-    }
-}
-- 
2.50.0


