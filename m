Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 08D34C77B7C
	for <qemu-devel@archiver.kernel.org>; Thu,  3 Jul 2025 13:34:34 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uXK4m-00079x-5W; Thu, 03 Jul 2025 09:34:08 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <manos.pitsidianakis@linaro.org>)
 id 1uXK4e-000767-LB
 for qemu-devel@nongnu.org; Thu, 03 Jul 2025 09:34:03 -0400
Received: from mail-wm1-x336.google.com ([2a00:1450:4864:20::336])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <manos.pitsidianakis@linaro.org>)
 id 1uXK4W-00019R-TL
 for qemu-devel@nongnu.org; Thu, 03 Jul 2025 09:33:56 -0400
Received: by mail-wm1-x336.google.com with SMTP id
 5b1f17b1804b1-453749aef9eso31896375e9.3
 for <qemu-devel@nongnu.org>; Thu, 03 Jul 2025 06:33:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1751549629; x=1752154429; darn=nongnu.org;
 h=cc:to:message-id:content-transfer-encoding:mime-version:subject
 :date:from:from:to:cc:subject:date:message-id:reply-to;
 bh=lPoLRXwQ2Qc0igi1+T6XuwBUXl7SWUBoR7DXhHIDuaI=;
 b=Ne8no013CoqyQEgg7FLhoYOSBqxQas1CbYRDMbNEcnII+r41v2FObvSHL53jfBI+Ju
 po5EhlP2JJQQgFZsoaA4v/07U+nFoGDbbYvbpolwl4AxRSROu3r7brUGE04pYXOjZ2iL
 JJbS4PLAKFfI6aAda6DsGC8y9h3LvucrKG/HNisgoqB7KmjbcRkKKahy51Zd24IHgHN7
 UAGk47KgFMPrU1sJL0g2hk6i+BvukDeNWADYY6/GPY9Im6zTdNo8yqeOn3e3iue6V1lS
 Glzt+WyJ6Z9MXU5PHb/KO8SR/G/USYcx96i8EkF18QRQCUyZ2TgdxsO0iSqhx7vuCVB/
 Hotg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1751549629; x=1752154429;
 h=cc:to:message-id:content-transfer-encoding:mime-version:subject
 :date:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=lPoLRXwQ2Qc0igi1+T6XuwBUXl7SWUBoR7DXhHIDuaI=;
 b=Bhs6DGLgxafOGKRbcugNLXQesqf2gU6Bp8oePBqV8kwY/tujjZ5c0vbPrRCGFXrhrE
 wsSBUBpL0LNYi+Quia25HZTMUhcG+6iH662q/MFdkoz8SDev+gMSfqkI398HwRvEL7ow
 M4c1I8nMnw6BcJCJV9b713vLdxd48izIyBq5UiD7CWxI04VhUDbE4iKnMj/VHzvNBvb0
 EYLpgpBxhTshTkQDQZ2tWvzelv/w3JtUtK1VecgN21TPibG1jumNvIYdI5jLW4zk0n9y
 leqFwAOrfEFIgfYytsD2u3qYph3beGI+Z8SRceb/dxu1U3ChauWngP++1m0DK4mUFx/T
 S2lg==
X-Gm-Message-State: AOJu0YzEBXYWFxIaEsOATc9kzz8UMgErI6uhF8dphq2MAgSv+wgq4NfE
 fv6Gp8caz/Mb82IpUbzCVtLx+6LIkbIbEpJ6d4g6K1oI6ETfCFiQGR0oZKbRgGFUhAgdoW7yGux
 qGMu6MXs=
X-Gm-Gg: ASbGncuYN1mhwNCfg8vWJ+DdzFduKrckSxlWlhgRYFRDWLk6xJmRWpWQEdXyHGShNkn
 VO8fT0wGFr/C67xqabp39OJI4wBcmqil5bP6DJflWlLHM5ouvPx7jQaBQofvVDejidJ3S3e2OP7
 /jVYlG+BaA4/zfsHql2tWLbs8LKUnAAEBHxmiN3KELjUdKM5D/fmzIslIAal9a/UxDnykjVxsZ+
 xtvnUCb/j3Xx28NpuMlfczaQ+ZIMSccU+ot4WkLTDLNkM64VuQ4T6a2qmqqFF9zfghVkmO8fDKZ
 IItdsCFBoabtLT1AWQe31A/zHNccJhbFToM7xN/z2S+GMETtz8CMuNVcL/hdI62+E+Xbnwxc2af
 8brcefhGgTbl5jpHPDntGBkMBowoKIWE=
X-Google-Smtp-Source: AGHT+IHJQN4bD7ZZkMNvOxx4ZGWQ8VgFpi6pNG4OTkatF1r5BkReFQRqMwpIdA9X+nXEU4hCNWzPdA==
X-Received: by 2002:adf:9dc2:0:b0:3a4:e665:ca5 with SMTP id
 ffacd0b85a97d-3b32cd20f10mr2176556f8f.23.1751549628698; 
 Thu, 03 Jul 2025 06:33:48 -0700 (PDT)
Received: from [127.0.1.1] (ppp-2-86-212-125.home.otenet.gr. [2.86.212.125])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-454a9972d83sm26993475e9.11.2025.07.03.06.33.47
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 03 Jul 2025 06:33:48 -0700 (PDT)
From: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>
Date: Thu, 03 Jul 2025 16:33:43 +0300
Subject: [PATCH] rust/qemu-api-macros: use syn::Error directly
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20250703-rust_macros-v1-1-b99f82febbbf@linaro.org>
X-B4-Tracking: v=1; b=H4sIALaGZmgC/6tWKk4tykwtVrJSqFYqSi3LLM7MzwNyDHUUlJIzE
 vPSU3UzU4B8JSMDI1MDcwNj3aLS4pL43MTkovxiXVPjFMtUs0SDJAsDIyWgjoKi1LTMCrBp0bG
 1tQCtsOeEXQAAAA==
X-Change-ID: 20250703-rust_macros-53d9e6a0b802
To: qemu-devel@nongnu.org
Cc: qemu-rust@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>, 
 Zhao Liu <zhao1.liu@intel.com>, 
 Manos Pitsidianakis <manos.pitsidianakis@linaro.org>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=19173;
 i=manos.pitsidianakis@linaro.org; h=from:subject:message-id;
 bh=Of5AnNPDvej2ZFXoTltV/Wb4vvhC5vIttMxc2b/uIK8=;
 b=LS0tLS1CRUdJTiBQR1AgTUVTU0FHRS0tLS0tCgpvd0VCYlFLUy9aQU5Bd0FLQVhjcHgzQi9mZ
 25RQWNzbVlnQm9ab2E3UUozdFQ4QWM4L2Mwd3Z2cXBncStQRHNYCmhDaWMrT1NXYk01QklkcVk0
 bEdKQWpNRUFBRUtBQjBXSVFUTVhCdE9SS0JXODRkd0hSQjNLY2R3ZjM0SjBBVUMKYUdhR3V3QUt
 DUkIzS2Nkd2YzNEowQW0yRC85UkI5aUhmUjZ1Vnl0UkpEVU45azV0Y0h4cXNEODR1Vm90VTdRUw
 pta0NzZ2RvZmVHQlNRVzNDL0J5aGZ0cEN6K2pmT0N4SmtwaFlUMHBNMGIvWkM2d2VqUTVRU210Z
 2dvd05reUxECm9jUnVQb0JIVEdYZnJMUzlQQzNGN2JSZE91TW1sajdYN1d4ZDh6OS96c2lXaUNE
 dVB6THV3OEJ5MFFQQjdDRUsKWlNFdWNyRVM3Y3FDajlMWFArOUNVcFEvK0dBaGllYTRHODFzOUp
 iQVdXd2FiZ2xFaUVmbzlqRTkvTUMrNkVkRAp6aVRMaHdFWUdOQjFKb2M0Tm1LVkFPdFNBa3dXWk
 V1WFk2cDBDbCt6WFF6WkRVcURtbE90WDNqVUpxNUFRaXFTCmtldTgzUjZTZDVxN1BWR1RiRWZPZ
 Wg3SGN2akhkUytEK1pRQ085TTVaaDJmcDd0NnNKY1gxTHFlRUNrajk5eVYKa0NEdUVBZGZRVlZV
 d3lucXR4dHN4dVhrdk9zQXpIdTg0OGZDb2JTY0hoZ1RPT2RkU2l5WnRHazBXcURPTW9ENgpsSFd
 ZZjNXSDBNM2tXMlBLWUluaHBGUEd6L1N1TlRiL1VVVzhIS3lzNkRRRkxSYm40RHh0am51em5UTz
 RESkRnCjIyZkt1eS9Yc0pEeE5IY3MwTmdxT2MySmJCa29PQ1IrQWY3TndZU3AySXZuYjhtTEIwK
 25ULy9kblErTEVRa0cKU2tSVzJVN1RqS1pGbmpyK3RBaHBZUEFHRVFUdDdHM3NxM2sybjRIUER6
 U0E4UVB4MjZDRmpSM2pJMjlMdDBCUgpTQ2g4V0RtNG83TkJMOEcyTUdXRXFPeUkzdjhpaVVNYXh
 PUnRpWEpnYkhWQXIxdWUyRnNFV3Q4eTZ3b2Z1M2NnClpVd21iUT09Cj1FNWUxCi0tLS0tRU5EIF
 BHUCBNRVNTQUdFLS0tLS0K
X-Developer-Key: i=manos.pitsidianakis@linaro.org; a=openpgp;
 fpr=7C721DF9DB3CC7182311C0BF68BC211D47B421E1
Received-SPF: pass client-ip=2a00:1450:4864:20::336;
 envelope-from=manos.pitsidianakis@linaro.org; helo=mail-wm1-x336.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

Our MacroError type wraps syn::Error as a variant, and uses another
variant for custom errors. Fortunately syn::Error can be used directly,
avoiding extra code on our side, so change the proc macro crate to use
it.

Signed-off-by: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>
---
 docs/devel/rust.rst               | 11 ++---
 rust/qemu-api-macros/src/bits.rs  | 58 ++++++++++----------------
 rust/qemu-api-macros/src/lib.rs   | 86 +++++++++++++++++++--------------------
 rust/qemu-api-macros/src/utils.rs | 26 ------------
 4 files changed, 70 insertions(+), 111 deletions(-)

diff --git a/docs/devel/rust.rst b/docs/devel/rust.rst
index dc8c44109e1c17dde0707439dc6255257532cb84..b6737536c694fd54fd0d3204c0dd1145a9b0e973 100644
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
index 5ba84757ee029e79c52dccf14335733e99d631aa..a80a3b9fee16b0d4a474dc6e1c0052d6b1ce9928 100644
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
index c18bb4e036f4e7737f9b95ac300b7d1e8742ef1f..2cb79c799a2807cbb6ca7ed47d018ba22deaa372 100644
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
+        return Err(Error::new(
+            input.ident.span(),
             format!("Named fields required for {msg}"),
-            input.ident.span(),
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
+        return Err(Error::new(
+            s.fields.span(),
             format!("Tuple struct required for {msg}"),
-            s.fields.span(),
         ));
     };
     if unnamed.len() != 1 {
-        return Err(MacroError::Message(
+        return Err(Error::new(
+            s.fields.span(),
             format!("A single field is required for {msg}"),
-            s.fields.span(),
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
+        Err(Error::new(
+            input.ident.span(),
             format!("#[repr(C)] required for {msg}"),
-            input.ident.span(),
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
+        Err(Error::new(
+            input.ident.span(),
             format!("#[repr(transparent)] required for {msg}"),
-            input.ident.span(),
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
index 02c91aed7f6a6d33075bbaa8b4fec4536da94e60..0000000000000000000000000000000000000000
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

---
base-commit: c77283dd5d79149f4e7e9edd00f65416c648ee59
change-id: 20250703-rust_macros-53d9e6a0b802

--
γαῖα πυρί μιχθήτω


