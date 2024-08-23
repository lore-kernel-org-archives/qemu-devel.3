Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1E73CC531DC
	for <qemu-devel@archiver.kernel.org>; Fri, 23 Aug 2024 08:13:29 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1shPPM-0004wG-Ut; Fri, 23 Aug 2024 04:12:32 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <manos.pitsidianakis@linaro.org>)
 id 1shPPK-0004l0-87
 for qemu-devel@nongnu.org; Fri, 23 Aug 2024 04:12:30 -0400
Received: from mail-lf1-x12a.google.com ([2a00:1450:4864:20::12a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <manos.pitsidianakis@linaro.org>)
 id 1shPPH-0004sS-9K
 for qemu-devel@nongnu.org; Fri, 23 Aug 2024 04:12:29 -0400
Received: by mail-lf1-x12a.google.com with SMTP id
 2adb3069b0e04-5333b2fbedaso2702866e87.0
 for <qemu-devel@nongnu.org>; Fri, 23 Aug 2024 01:12:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1724400745; x=1725005545; darn=nongnu.org;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=s/qCp4bbU8LCVmpYzYj8gBdo5MeHc/8bdKsj5UpcQMs=;
 b=TtrQDLCTu3yesj52NFNV+lZ8IopEhbkEY6ihVIIl62ZNGelA9kcmq/RQyQttmKhTuc
 A+5TuvkB/h7Gpa+YyCA03LBZaw7NYydTdylrCF7mnm4j4DyYF7qhXEJLlPxk0MBJMJGv
 cTPppdqaf5sLT6UqI3bL19g2eLYrszZnER3HH50ElXhUK9WIS0P4uw91F2ldsxiFr9yh
 vm9oBiis6eRMfZkZQucaZjnSboZq+/OHtHyqf3577RXgX0XZgFsc5oB4yHZ9cvdNoWbr
 mdEbNTGTfP3FA8/GOqnBbiV+njE4dFIKkvXVviveCTwTz9ISGadhX7SNrpB07IU2g5N7
 qrnw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1724400745; x=1725005545;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=s/qCp4bbU8LCVmpYzYj8gBdo5MeHc/8bdKsj5UpcQMs=;
 b=OX6d1JyrFyyvJ72trP4PpAX7RFDiZOgmP3pe4BSiU5Dtkx5NqwsDkzhyN+67Wo1fT3
 qnEiGHt0u7zXxblK0e+OPBxoC/cPhhQ+Q72My0n4tEUKcWtxSs20+I57H7IpgeqexWh9
 o0cxCd66G5cuRrgcFSMLE+J4njoWLB2GwlmGRkk1JXd+2MV1n8KDQglqmelga5zxAns3
 ekumCp61aSkwm5/dtOdtaF5lof+yMqi4WRjKuR6JTA/AUEALnvGadBY1YTsrbq0uHiG+
 KqJCskhf+4+4f0M3MWbN9hGS2+VNu1tLU6j2mHXlYAj4uQR7ktvXZ4niIPvFT8nakdQL
 dAEw==
X-Gm-Message-State: AOJu0Yz/x5MYqkqrBem4kS/Rk87kZ2t7A3VAY6GwwAoDOfoGaxGo5oWe
 eEodeh0gFFYiOuaWGVi3ajMmMCdfWQ8C+RT1vYdcO6/8kQjHdlqrGCipSJikTvM=
X-Google-Smtp-Source: AGHT+IEcpKZTYE67Op8TZg6VNB3PPD8TkIRtEQ5swCoW/lwL8agSzwnd0p+ddYs5NH3mFkUlKTyxmA==
X-Received: by 2002:a05:6512:239e:b0:52f:d15f:d46b with SMTP id
 2adb3069b0e04-5343877a8f0mr1022677e87.14.1724400745062; 
 Fri, 23 Aug 2024 01:12:25 -0700 (PDT)
Received: from [127.0.1.1] (adsl-26.37.6.162.tellas.gr. [37.6.162.26])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-a868ee6b390sm223620066b.0.2024.08.23.01.12.23
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 23 Aug 2024 01:12:24 -0700 (PDT)
From: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>
Date: Fri, 23 Aug 2024 11:11:55 +0300
Subject: [PATCH v8 7/8] rust: add utility procedural macro crate
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20240823-rust-pl011-v8-7-b9f5746bdaf3@linaro.org>
References: <20240823-rust-pl011-v8-0-b9f5746bdaf3@linaro.org>
In-Reply-To: <20240823-rust-pl011-v8-0-b9f5746bdaf3@linaro.org>
To: qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>, 
 =?utf-8?q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>, 
 =?utf-8?q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>, 
 Thomas Huth <thuth@redhat.com>, 
 =?utf-8?q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>, 
 Pierrick Bouvier <pierrick.bouvier@linaro.org>, 
 Richard Henderson <richard.henderson@linaro.org>, 
 Gustavo Romero <gustavo.romero@linaro.org>, 
 =?utf-8?q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>, 
 Peter Maydell <peter.maydell@linaro.org>, Junjie Mao <junjie.mao@intel.com>, 
 Zhao Liu <zhao1.liu@intel.com>
X-Mailer: b4 0.15-dev-b8758
X-Developer-Signature: v=1; a=openpgp-sha256; l=17310;
 i=manos.pitsidianakis@linaro.org; h=from:subject:message-id;
 bh=yKCUQJN2qRyVIJ6kvRrFwdW1cHMEsdilUCJcgdk5sc4=;
 b=LS0tLS1CRUdJTiBQR1AgTUVTU0FHRS0tLS0tCgpvd0VCYlFLUy9aQU5Bd0FLQVhjcHgzQi9mZ
 25RQWNzbVlnQm15RVJZLzArUXNuSzR0OVcyVDQxZ3hWOUZQYlIyCmZPY3hRQ1RSdE1zTzlJR25q
 UXVKQWpNRUFBRUtBQjBXSVFUTVhCdE9SS0JXODRkd0hSQjNLY2R3ZjM0SjBBVUMKWnNoRVdBQUt
 DUkIzS2Nkd2YzNEowRndORUFDQXFhQXJ0ajRocVBoSVFSaUVkRFYxQzVRVGhsaVEwVC84cDJKZA
 pHZjcvTTVpS2tUbTRuTGN0S3BjaHhReHVVei9PWnNrM1A0WWJaZmdLeU5LV0pBM3hVS0JCMm50S
 VRSNnd6U1cxClFlVEwzNnhwc1F1OFdZRmxVd3RlTUVYc1F3Y0U4cFZzV3Vvcy9DcGtBUU5OM1lX
 eVhxa1VYUG1IYmx2Um5rNysKaTcwbVh6ekIrY1VEZkYzNXZYbUFmUEZVcFRjbHlXTm1MbjhuZEx
 wTElTOFoya3JVeDBDbmdnRis0YVR1RUdBTApCNnZVUVdGRml3TzRDVXBib1BuUjF6MTM4dy9PaH
 grV1FVYUdzeWc0MGVSUW1PY2ZBZXAyVGxmK3N0UHp0Szh6CkNQc3JVUjY5bTFFa2ovYkdXc3Y5Q
 W9DTmtKRkxMbW91Zy96NG1uRlp3UkxycVNQK25VMWxIeG5DYjJFWUsxdC8KVEFzVnZQRGhKdTRV
 a1Y4SDFFaDQ2UW5tN1JUNVplSXRjVFZ5ZHd6ZHVqSW1hcng1NzN0d3hEMlJlaEh0ZnRWeQpnczQ
 4K21zNW1PMHRWdDlCUGRJemFFYytNSHVGd3hYRnFHcGcySTdkMm9QdWlpSmVSeEdmdzkrK3VmTV
 VhVHRPCmkxdWZSTDBuOEtzRklpakFUcE9uc2k3d21kek1kaFFnQ0RTY1VvaTZJb1JwZDlDeGcyN
 0UzZ3JFYlE4NFBlQ3IKMjgxTFQxUmNxemUrRFRHRjZHOXFoaG8wYVQxdHM4b3J6bUhiWFF6emZr
 UjRsOFh2ZmZjbklORXI1RGx2UGpPVApvT1FQd1ZubDMxaG5OUTY3K1ZQSkJvQ3VsOUNhUkkxbUN
 NSktoRk9xNkpRWG5xRzN1b3NDeUFJZEowU2l1M1RxCnQwb0JvQT09Cj01OGhaCi0tLS0tRU5EIF
 BHUCBNRVNTQUdFLS0tLS0K
X-Developer-Key: i=manos.pitsidianakis@linaro.org; a=openpgp;
 fpr=7C721DF9DB3CC7182311C0BF68BC211D47B421E1
Received-SPF: pass client-ip=2a00:1450:4864:20::12a;
 envelope-from=manos.pitsidianakis@linaro.org; helo=mail-lf1-x12a.google.com
X-Spam_score_int: -19
X-Spam_score: -2.0
X-Spam_bar: --
X-Spam_report: (-2.0 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01, URIBL_CSS_A=0.1 autolearn=ham autolearn_force=no
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

This commit adds a helper crate library, qemu-api-macros for derive (and
other procedural) macros to be used along qemu-api.

It needs to be a separate library because in Rust, procedural macros, or
macros that can generate arbitrary code, need to be special separate
compilation units.

Only one macro is introduced in this patch, #[derive(Object)]. It
generates a constructor to register a QOM TypeInfo on init and it must
be used on types that implement qemu_api::definitions::ObjectImpl trait.

Signed-off-by: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>
---
 MAINTAINERS                            |   1 +
 rust/meson.build                       |   1 +
 rust/qemu-api-macros/Cargo.lock        |  47 +++++++
 rust/qemu-api-macros/Cargo.toml        |  25 ++++
 rust/qemu-api-macros/README.md         |   1 +
 rust/qemu-api-macros/meson.build       |  25 ++++
 rust/qemu-api-macros/src/cstr/mod.rs   |  55 ++++++++
 rust/qemu-api-macros/src/cstr/parse.rs | 225 +++++++++++++++++++++++++++++++++
 rust/qemu-api-macros/src/lib.rs        |  43 +++++++
 rust/qemu-api/meson.build              |   3 +
 10 files changed, 426 insertions(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index d35e9f6b20..727f3a7a2c 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -3352,6 +3352,7 @@ Rust
 M: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>
 S: Maintained
 F: rust/qemu-api
+F: rust/qemu-api-macros
 F: rust/rustfmt.toml
 
 SLIRP
diff --git a/rust/meson.build b/rust/meson.build
index 4a58d106b1..7a32b1b195 100644
--- a/rust/meson.build
+++ b/rust/meson.build
@@ -1 +1,2 @@
+subdir('qemu-api-macros')
 subdir('qemu-api')
diff --git a/rust/qemu-api-macros/Cargo.lock b/rust/qemu-api-macros/Cargo.lock
new file mode 100644
index 0000000000..fdc0fce116
--- /dev/null
+++ b/rust/qemu-api-macros/Cargo.lock
@@ -0,0 +1,47 @@
+# This file is automatically @generated by Cargo.
+# It is not intended for manual editing.
+version = 3
+
+[[package]]
+name = "proc-macro2"
+version = "1.0.86"
+source = "registry+https://github.com/rust-lang/crates.io-index"
+checksum = "5e719e8df665df0d1c8fbfd238015744736151d4445ec0836b8e628aae103b77"
+dependencies = [
+ "unicode-ident",
+]
+
+[[package]]
+name = "qemu_api_macros"
+version = "0.1.0"
+dependencies = [
+ "proc-macro2",
+ "quote",
+ "syn",
+]
+
+[[package]]
+name = "quote"
+version = "1.0.36"
+source = "registry+https://github.com/rust-lang/crates.io-index"
+checksum = "0fa76aaf39101c457836aec0ce2316dbdc3ab723cdda1c6bd4e6ad4208acaca7"
+dependencies = [
+ "proc-macro2",
+]
+
+[[package]]
+name = "syn"
+version = "2.0.72"
+source = "registry+https://github.com/rust-lang/crates.io-index"
+checksum = "dc4b9b9bf2add8093d3f2c0204471e951b2285580335de42f9d2534f3ae7a8af"
+dependencies = [
+ "proc-macro2",
+ "quote",
+ "unicode-ident",
+]
+
+[[package]]
+name = "unicode-ident"
+version = "1.0.12"
+source = "registry+https://github.com/rust-lang/crates.io-index"
+checksum = "3354b9ac3fae1ff6755cb6db53683adb661634f67557942dea4facebec0fee4b"
diff --git a/rust/qemu-api-macros/Cargo.toml b/rust/qemu-api-macros/Cargo.toml
new file mode 100644
index 0000000000..144cc3650f
--- /dev/null
+++ b/rust/qemu-api-macros/Cargo.toml
@@ -0,0 +1,25 @@
+[package]
+name = "qemu_api_macros"
+version = "0.1.0"
+edition = "2021"
+authors = ["Manos Pitsidianakis <manos.pitsidianakis@linaro.org>"]
+license = "GPL-2.0-or-later"
+readme = "README.md"
+homepage = "https://www.qemu.org"
+description = "Rust bindings for QEMU - Utility macros"
+repository = "https://gitlab.com/qemu-project/qemu/"
+resolver = "2"
+publish = false
+keywords = []
+categories = []
+
+[lib]
+proc-macro = true
+
+[dependencies]
+proc-macro2 = "1"
+quote = "1"
+syn = "2"
+
+# Do not include in any global workspace
+[workspace]
diff --git a/rust/qemu-api-macros/README.md b/rust/qemu-api-macros/README.md
new file mode 100644
index 0000000000..f60f54ac4b
--- /dev/null
+++ b/rust/qemu-api-macros/README.md
@@ -0,0 +1 @@
+# `qemu-api-macros` - Utility macros for defining QEMU devices
diff --git a/rust/qemu-api-macros/meson.build b/rust/qemu-api-macros/meson.build
new file mode 100644
index 0000000000..48af91ed38
--- /dev/null
+++ b/rust/qemu-api-macros/meson.build
@@ -0,0 +1,25 @@
+add_languages('rust', required: true, native: true)
+
+quote_dep = dependency('quote-1-rs', native: true)
+syn_dep = dependency('syn-2-rs', native: true)
+proc_macro2_dep = dependency('proc-macro2-1-rs', native: true)
+
+_qemu_api_macros_rs = import('rust').proc_macro(
+  'qemu_api_macros',
+  files('src/lib.rs'),
+  override_options: ['rust_std=2021', 'build.rust_std=2021'],
+  rust_args: [
+    '--cfg', 'use_fallback',
+    '--cfg', 'feature="syn-error"',
+    '--cfg', 'feature="proc-macro"',
+  ],
+  dependencies: [
+    proc_macro2_dep,
+    quote_dep,
+    syn_dep,
+  ],
+)
+
+qemu_api_macros = declare_dependency(
+  link_with: _qemu_api_macros_rs,
+)
diff --git a/rust/qemu-api-macros/src/cstr/mod.rs b/rust/qemu-api-macros/src/cstr/mod.rs
new file mode 100644
index 0000000000..b88e5fd10b
--- /dev/null
+++ b/rust/qemu-api-macros/src/cstr/mod.rs
@@ -0,0 +1,55 @@
+// Copyright (c) 2018-2020 Xidorn Quan
+//
+// Permission is hereby granted, free of charge, to any
+// person obtaining a copy of this software and associated
+// documentation files (the "Software"), to deal in the
+// Software without restriction, including without
+// limitation the rights to use, copy, modify, merge,
+// publish, distribute, sublicense, and/or sell copies of
+// the Software, and to permit persons to whom the Software
+// is furnished to do so, subject to the following
+// conditions:
+//
+// The above copyright notice and this permission notice
+// shall be included in all copies or substantial portions
+// of the Software.
+//
+// THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF
+// ANY KIND, EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED
+// TO THE WARRANTIES OF MERCHANTABILITY, FITNESS FOR A
+// PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT
+// SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY
+// CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION
+// OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR
+// IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER
+// DEALINGS IN THE SOFTWARE.
+
+use self::parse::parse_input;
+use proc_macro::TokenStream as RawTokenStream;
+use proc_macro2::{Literal, Span, TokenStream};
+use quote::{quote, quote_spanned};
+use std::ffi::CString;
+
+mod parse;
+
+struct Error(Span, &'static str);
+
+pub(crate) fn cstr(input: RawTokenStream) -> RawTokenStream {
+    let tokens = match build_byte_str(input.into()) {
+        Ok(s) => quote!(unsafe { ::core::ffi::CStr::from_bytes_with_nul_unchecked(#s) }),
+        Err(Error(span, msg)) => quote_spanned!(span => compile_error!(#msg)),
+    };
+    tokens.into()
+}
+
+fn build_byte_str(input: TokenStream) -> Result<Literal, Error> {
+    let (bytes, span) = parse_input(input)?;
+    match CString::new(bytes) {
+        Ok(s) => {
+            let mut lit = Literal::byte_string(s.as_bytes_with_nul());
+            lit.set_span(span);
+            Ok(lit)
+        }
+        Err(_) => Err(Error(span, "nul byte found in the literal")),
+    }
+}
diff --git a/rust/qemu-api-macros/src/cstr/parse.rs b/rust/qemu-api-macros/src/cstr/parse.rs
new file mode 100644
index 0000000000..1d495296ad
--- /dev/null
+++ b/rust/qemu-api-macros/src/cstr/parse.rs
@@ -0,0 +1,225 @@
+use super::Error;
+use core::char;
+use proc_macro2::{Delimiter, Ident, Literal, Span, TokenStream, TokenTree};
+
+macro_rules! unexpected_content {
+    () => {
+        "expected one of: byte string literal, string literal, identifier"
+    };
+}
+
+pub(crate) fn parse_input(mut input: TokenStream) -> Result<(Vec<u8>, Span), Error> {
+    loop {
+        let mut tokens = input.into_iter();
+        let token = match tokens.next() {
+            Some(token) => token,
+            None => {
+                return Err(Error(
+                    Span::call_site(),
+                    concat!("unexpected end of input, ", unexpected_content!()),
+                ))
+            }
+        };
+        let span = token.span();
+        let result = match token {
+            // Unwrap any empty group which may be created from macro expansion.
+            TokenTree::Group(group) if group.delimiter() == Delimiter::None => Err(group),
+            TokenTree::Literal(literal) => match parse_literal(literal) {
+                Ok(result) => Ok(result),
+                Err(msg) => return Err(Error(span, msg)),
+            },
+            TokenTree::Ident(ident) => Ok(parse_ident(ident)),
+            _ => return Err(Error(span, unexpected_content!())),
+        };
+        if let Some(token) = tokens.next() {
+            return Err(Error(token.span(), "unexpected token"));
+        }
+        match result {
+            Ok(result) => return Ok((result, span)),
+            Err(group) => input = group.stream(),
+        }
+    }
+}
+
+fn parse_literal(literal: Literal) -> Result<Vec<u8>, &'static str> {
+    let s = literal.to_string();
+    let s = s.as_bytes();
+    match s[0] {
+        b'"' => Ok(parse_cooked_content(s)),
+        b'r' => Ok(parse_raw_content(&s[1..])),
+        b'b' => match s[1] {
+            b'"' => Ok(parse_cooked_content(&s[1..])),
+            b'r' => Ok(parse_raw_content(&s[2..])),
+            _ => Err(unexpected_content!()),
+        },
+        _ => Err(unexpected_content!()),
+    }
+}
+
+fn all_pounds(bytes: &[u8]) -> bool {
+    bytes.iter().all(|b| *b == b'#')
+}
+
+/// Parses raw string / bytes content after `r` prefix.
+fn parse_raw_content(s: &[u8]) -> Vec<u8> {
+    let q_start = s.iter().position(|b| *b == b'"').unwrap();
+    let q_end = s.iter().rposition(|b| *b == b'"').unwrap();
+    assert!(all_pounds(&s[0..q_start]));
+    assert!(all_pounds(&s[q_end + 1..q_end + q_start + 1]));
+    Vec::from(&s[q_start + 1..q_end])
+}
+
+/// Parses the cooked string / bytes content within quotes.
+fn parse_cooked_content(mut s: &[u8]) -> Vec<u8> {
+    s = &s[1..s.iter().rposition(|b| *b == b'"').unwrap()];
+    let mut result = Vec::new();
+    while !s.is_empty() {
+        match s[0] {
+            b'\\' => {}
+            b'\r' => {
+                assert_eq!(s[1], b'\n');
+                result.push(b'\n');
+                s = &s[2..];
+                continue;
+            }
+            b => {
+                result.push(b);
+                s = &s[1..];
+                continue;
+            }
+        }
+        let b = s[1];
+        s = &s[2..];
+        match b {
+            b'x' => {
+                let (b, rest) = backslash_x(s);
+                result.push(b);
+                s = rest;
+            }
+            b'u' => {
+                let (c, rest) = backslash_u(s);
+                result.extend_from_slice(c.encode_utf8(&mut [0; 4]).as_bytes());
+                s = rest;
+            }
+            b'n' => result.push(b'\n'),
+            b'r' => result.push(b'\r'),
+            b't' => result.push(b'\t'),
+            b'\\' => result.push(b'\\'),
+            b'0' => result.push(b'\0'),
+            b'\'' => result.push(b'\''),
+            b'"' => result.push(b'"'),
+            b'\r' | b'\n' => {
+                let next = s.iter().position(|b| {
+                    let ch = char::from_u32(u32::from(*b)).unwrap();
+                    !ch.is_whitespace()
+                });
+                match next {
+                    Some(pos) => s = &s[pos..],
+                    None => s = b"",
+                }
+            }
+            b => panic!("unexpected byte {:?} after \\", b),
+        }
+    }
+    result
+}
+
+fn backslash_x(s: &[u8]) -> (u8, &[u8]) {
+    let ch = hex_to_u8(s[0]) * 0x10 + hex_to_u8(s[1]);
+    (ch, &s[2..])
+}
+
+fn hex_to_u8(b: u8) -> u8 {
+    match b {
+        b'0'..=b'9' => b - b'0',
+        b'a'..=b'f' => b - b'a' + 10,
+        b'A'..=b'F' => b - b'A' + 10,
+        _ => unreachable!("unexpected non-hex character {:?} after \\x", b),
+    }
+}
+
+fn backslash_u(s: &[u8]) -> (char, &[u8]) {
+    assert_eq!(s[0], b'{');
+    let end = s[1..].iter().position(|b| *b == b'}').unwrap();
+    let mut ch = 0;
+    for b in &s[1..=end] {
+        ch *= 0x10;
+        ch += u32::from(hex_to_u8(*b));
+    }
+    (char::from_u32(ch).unwrap(), &s[end + 2..])
+}
+
+fn parse_ident(ident: Ident) -> Vec<u8> {
+    ident.to_string().into_bytes()
+}
+
+#[cfg(test)]
+mod tests {
+    use super::*;
+    use std::str::FromStr;
+
+    // Tests below were modified from
+    // https://github.com/dtolnay/syn/blob/cd5fdc0f530f822446fccaf831669cd0cf4a0fc9/tests/test_lit.rs
+
+    fn lit(s: &str) -> Vec<u8> {
+        match TokenStream::from_str(s)
+            .unwrap()
+            .into_iter()
+            .next()
+            .unwrap()
+        {
+            TokenTree::Literal(lit) => parse_literal(lit).unwrap(),
+            _ => panic!(),
+        }
+    }
+
+    #[test]
+    fn strings() {
+        #[track_caller]
+        fn test_string(s: &str, value: &[u8]) {
+            assert_eq!(lit(s), value);
+        }
+
+        test_string("\"a\"", b"a");
+        test_string("\"\\n\"", b"\n");
+        test_string("\"\\r\"", b"\r");
+        test_string("\"\\t\"", b"\t");
+        test_string("\"🐕\"", b"\xf0\x9f\x90\x95"); // NOTE: This is an emoji
+        test_string("\"\\\"\"", b"\"");
+        test_string("\"'\"", b"'");
+        test_string("\"\"", b"");
+        test_string("\"\\u{1F415}\"", b"\xf0\x9f\x90\x95");
+        test_string(
+            "\"contains\nnewlines\\\nescaped newlines\"",
+            b"contains\nnewlinesescaped newlines",
+        );
+        test_string("r\"raw\nstring\\\nhere\"", b"raw\nstring\\\nhere");
+        test_string("\"...\"q", b"...");
+        test_string("r\"...\"q", b"...");
+        test_string("r##\"...\"##q", b"...");
+    }
+
+    #[test]
+    fn byte_strings() {
+        #[track_caller]
+        fn test_byte_string(s: &str, value: &[u8]) {
+            assert_eq!(lit(s), value);
+        }
+
+        test_byte_string("b\"a\"", b"a");
+        test_byte_string("b\"\\n\"", b"\n");
+        test_byte_string("b\"\\r\"", b"\r");
+        test_byte_string("b\"\\t\"", b"\t");
+        test_byte_string("b\"\\\"\"", b"\"");
+        test_byte_string("b\"'\"", b"'");
+        test_byte_string("b\"\"", b"");
+        test_byte_string(
+            "b\"contains\nnewlines\\\nescaped newlines\"",
+            b"contains\nnewlinesescaped newlines",
+        );
+        test_byte_string("br\"raw\nstring\\\nhere\"", b"raw\nstring\\\nhere");
+        test_byte_string("b\"...\"q", b"...");
+        test_byte_string("br\"...\"q", b"...");
+        test_byte_string("br##\"...\"##q", b"...");
+    }
+}
diff --git a/rust/qemu-api-macros/src/lib.rs b/rust/qemu-api-macros/src/lib.rs
new file mode 100644
index 0000000000..331bc9e215
--- /dev/null
+++ b/rust/qemu-api-macros/src/lib.rs
@@ -0,0 +1,43 @@
+// Copyright 2024, Linaro Limited
+// Author(s): Manos Pitsidianakis <manos.pitsidianakis@linaro.org>
+// SPDX-License-Identifier: GPL-2.0-or-later
+
+use proc_macro::TokenStream;
+use quote::{format_ident, quote};
+use syn::{parse_macro_input, DeriveInput};
+
+#[proc_macro_derive(Object)]
+pub fn derive_object(input: TokenStream) -> TokenStream {
+    let input = parse_macro_input!(input as DeriveInput);
+
+    let name = input.ident;
+    let module_static = format_ident!("__{}_LOAD_MODULE", name);
+
+    let expanded = quote! {
+        #[allow(non_upper_case_globals)]
+        #[used]
+        #[cfg_attr(target_os = "linux", link_section = ".ctors")]
+        #[cfg_attr(target_os = "macos", link_section = "__DATA,__mod_init_func")]
+        #[cfg_attr(target_os = "windows", link_section = ".CRT$XCU")]
+        pub static #module_static: extern "C" fn() = {
+            extern "C" fn __register() {
+                unsafe {
+                    ::qemu_api::bindings::type_register_static(&<#name as ::qemu_api::definitions::ObjectImpl>::TYPE_INFO);
+                }
+            }
+
+            extern "C" fn __load() {
+                unsafe {
+                    ::qemu_api::bindings::register_module_init(
+                        Some(__register),
+                        ::qemu_api::bindings::module_init_type_MODULE_INIT_QOM
+                    );
+                }
+            }
+
+            __load
+        };
+    };
+
+    TokenStream::from(expanded)
+}
diff --git a/rust/qemu-api/meson.build b/rust/qemu-api/meson.build
index 85838d31b4..a0802ad858 100644
--- a/rust/qemu-api/meson.build
+++ b/rust/qemu-api/meson.build
@@ -13,6 +13,9 @@ _qemu_api_rs = static_library(
   rust_args: [
     '--cfg', 'MESON',
   ],
+  dependencies: [
+    qemu_api_macros,
+  ],
 )
 
 qemu_api = declare_dependency(

-- 
2.44.0


