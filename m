Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5FCB7C3ABAA
	for <qemu-devel@archiver.kernel.org>; Mon,  5 May 2025 16:51:57 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uBz2N-0006ha-1B; Mon, 05 May 2025 12:51:27 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1uBz2D-0006dO-Oo
 for qemu-devel@nongnu.org; Mon, 05 May 2025 12:51:22 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1uBz28-0002Cf-KJ
 for qemu-devel@nongnu.org; Mon, 05 May 2025 12:51:16 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1746463871;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding;
 bh=gPd0oWdRc16ZPxIiLcZrURGcaj+pbKtzOTzYPdfX13s=;
 b=Hb/lgxjVqLxCVXb6sB8/sUWyfV5m0uhPFGu7+Yo9chWEZKuLl4vpLBufHrF9wOH7n7daKH
 qoaWMrTKE1BJbI+pkDFjyfkaIjwBYdBslSxrkFtHQElvOLYrX91KjUpHebxACP8dV6dH60
 5Y4QI5XPqHpdvCbp/LC4FnPGRn/exqI=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-122-3RyeF8nBOSupdAZo4Ty1xw-1; Mon, 05 May 2025 12:51:09 -0400
X-MC-Unique: 3RyeF8nBOSupdAZo4Ty1xw-1
X-Mimecast-MFC-AGG-ID: 3RyeF8nBOSupdAZo4Ty1xw_1746463869
Received: by mail-wm1-f69.google.com with SMTP id
 5b1f17b1804b1-43ced8c2eb7so36409735e9.1
 for <qemu-devel@nongnu.org>; Mon, 05 May 2025 09:51:09 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1746463868; x=1747068668;
 h=content-transfer-encoding:mime-version:message-id:date:subject:to
 :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=gPd0oWdRc16ZPxIiLcZrURGcaj+pbKtzOTzYPdfX13s=;
 b=pKtMaMGlFOYaFgHDw3K77zZU70Wt8LisGZeRh5yXPp4vW8BEwXPZ+/stHKGYrpsP3l
 WzXT8lk4QlPJ8Jye0ZhD0oNeeLTMbWWOhRNoioQJUt/WXukNoYp7cS2510f9eowNzGY4
 sDAjjA/DJtj4eAHY5xX84FeEE82+knl9ERUGt207PX8uhcegSuKIlKXulCkZNf4kxlTN
 5D+3bBTIySfUMYAHVNxVGeny73vWItR0kg1G1QoP9DgfcNiu+XOBryzXpKQuUYnPdXEQ
 BuQU1cNxpyX+shF7FaLQ8bnSJIMY0PBn4tHiXFE8aGjqMXb0vZDFSXTqYFPbXivPy+Lp
 aepQ==
X-Gm-Message-State: AOJu0Yy/4qTH81rnYBvp8AaKhIPuzy8+reXhRuxosLrTkQoM8PvsIjhS
 IALZaQXHxSSNRS7aukzGJtzrwwa1EoJBfDCkPUCmUaR2NOU+s0PY1Str2uVOzDDAckABk8uBon3
 l5zPpyaukfWb7eOEl84p9qPjNYjhww3v4WifGKkPdJnBd4F3WcjwDE41FZhzV3iMdhpiaHEug+s
 ZGg7CKWb4hFftCA0yoc8ly2sVUYkYdJOlIkrWK
X-Gm-Gg: ASbGncvTvMo2He3dxyUxvKgtwBlMw653BJg2vFgMsfgu8N0/2SRjlDFSHhq7pW0ZZqA
 T8MlYH3mYate1ZCdzlf9O17SUhwIlw3HUOFX67KjNCvQ88RjuGJIICWg4R06wVEanUuLp2OAEJo
 i9aQGh42ZAF7qfttYclcwBWLOfuZMqBW33LlF7Yuxgb+qAPdFgVBxFObsrzOQx4aS7NhuGY0Ifd
 CMHLeUzGr0XpLtTsKKcVKQI4LxpGNVFOA+XUXEGc7Vqm/VXqBdX6/DTWRzVFdEgZ1sFGer5ex94
 8rd4g5xqeOUJjck=
X-Received: by 2002:a05:600c:a4d:b0:43b:ce3c:19d0 with SMTP id
 5b1f17b1804b1-441c4933cf9mr68941175e9.29.1746463868128; 
 Mon, 05 May 2025 09:51:08 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHv4AygLSipNq0FIjZqZGN3P6WEWL/SjWEufYIfr5XKVsLcALn+p2+1U/mlff6Abq0XaGstxw==
X-Received: by 2002:a05:600c:a4d:b0:43b:ce3c:19d0 with SMTP id
 5b1f17b1804b1-441c4933cf9mr68941035e9.29.1746463867604; 
 Mon, 05 May 2025 09:51:07 -0700 (PDT)
Received: from [192.168.122.1] ([151.95.54.106])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-441b2b287desm185395165e9.38.2025.05.05.09.51.06
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 05 May 2025 09:51:07 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH] rust: clippy: enable uninlined_format_args lint
Date: Mon,  5 May 2025 18:51:05 +0200
Message-ID: <20250505165105.145180-1-pbonzini@redhat.com>
X-Mailer: git-send-email 2.49.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -34
X-Spam_score: -3.5
X-Spam_bar: ---
X-Spam_report: (-3.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.414,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 rust/Cargo.toml                 |  1 +
 rust/clippy.toml                |  1 +
 rust/qemu-api-macros/src/lib.rs | 16 ++++++++--------
 rust/qemu-api/build.rs          |  4 ++--
 4 files changed, 12 insertions(+), 10 deletions(-)

diff --git a/rust/Cargo.toml b/rust/Cargo.toml
index 4f6fe17b50f..d9faeecb10b 100644
--- a/rust/Cargo.toml
+++ b/rust/Cargo.toml
@@ -89,6 +89,7 @@ suspicious_operation_groupings = "deny"
 transmute_ptr_to_ptr = "deny"
 transmute_undefined_repr = "deny"
 type_repetition_in_bounds = "deny"
+uninlined_format_args = "deny"
 used_underscore_binding = "deny"
 
 # nice to have, but cannot be enabled yet
diff --git a/rust/clippy.toml b/rust/clippy.toml
index 933e46a2ffb..58a62c0e632 100644
--- a/rust/clippy.toml
+++ b/rust/clippy.toml
@@ -1,2 +1,3 @@
 doc-valid-idents = ["PrimeCell", ".."]
+allow-mixed-uninlined-format-args = false
 msrv = "1.77.0"
diff --git a/rust/qemu-api-macros/src/lib.rs b/rust/qemu-api-macros/src/lib.rs
index dc14cac4ffa..f97449bb304 100644
--- a/rust/qemu-api-macros/src/lib.rs
+++ b/rust/qemu-api-macros/src/lib.rs
@@ -18,13 +18,13 @@ fn get_fields<'a>(
 ) -> Result<&'a Punctuated<Field, Comma>, MacroError> {
     let Data::Struct(ref s) = &input.data else {
         return Err(MacroError::Message(
-            format!("Struct required for {}", msg),
+            format!("Struct required for {msg}"),
             input.ident.span(),
         ));
     };
     let Fields::Named(ref fs) = &s.fields else {
         return Err(MacroError::Message(
-            format!("Named fields required for {}", msg),
+            format!("Named fields required for {msg}"),
             input.ident.span(),
         ));
     };
@@ -34,19 +34,19 @@ fn get_fields<'a>(
 fn get_unnamed_field<'a>(input: &'a DeriveInput, msg: &str) -> Result<&'a Field, MacroError> {
     let Data::Struct(ref s) = &input.data else {
         return Err(MacroError::Message(
-            format!("Struct required for {}", msg),
+            format!("Struct required for {msg}"),
             input.ident.span(),
         ));
     };
     let Fields::Unnamed(FieldsUnnamed { ref unnamed, .. }) = &s.fields else {
         return Err(MacroError::Message(
-            format!("Tuple struct required for {}", msg),
+            format!("Tuple struct required for {msg}"),
             s.fields.span(),
         ));
     };
     if unnamed.len() != 1 {
         return Err(MacroError::Message(
-            format!("A single field is required for {}", msg),
+            format!("A single field is required for {msg}"),
             s.fields.span(),
         ));
     }
@@ -60,7 +60,7 @@ fn is_c_repr(input: &DeriveInput, msg: &str) -> Result<(), MacroError> {
         Ok(())
     } else {
         Err(MacroError::Message(
-            format!("#[repr(C)] required for {}", msg),
+            format!("#[repr(C)] required for {msg}"),
             input.ident.span(),
         ))
     }
@@ -73,7 +73,7 @@ fn is_transparent_repr(input: &DeriveInput, msg: &str) -> Result<(), MacroError>
         Ok(())
     } else {
         Err(MacroError::Message(
-            format!("#[repr(transparent)] required for {}", msg),
+            format!("#[repr(transparent)] required for {msg}"),
             input.ident.span(),
         ))
     }
@@ -168,7 +168,7 @@ fn get_repr_uN(input: &DeriveInput, msg: &str) -> Result<Path, MacroError> {
     }
 
     Err(MacroError::Message(
-        format!("#[repr(u8/u16/u32/u64) required for {}", msg),
+        format!("#[repr(u8/u16/u32/u64) required for {msg}"),
         input.ident.span(),
     ))
 }
diff --git a/rust/qemu-api/build.rs b/rust/qemu-api/build.rs
index 470be2a4d54..1e720641d2b 100644
--- a/rust/qemu-api/build.rs
+++ b/rust/qemu-api/build.rs
@@ -14,7 +14,7 @@ fn main() -> Result<()> {
     let path = env::var("MESON_BUILD_ROOT")
         .unwrap_or_else(|_| format!("{}/src", env!("CARGO_MANIFEST_DIR")));
 
-    let file = format!("{}/bindings.inc.rs", path);
+    let file = format!("{path}/bindings.inc.rs");
     let file = Path::new(&file);
     if !Path::new(&file).exists() {
         panic!(concat!(
@@ -29,7 +29,7 @@ fn main() -> Result<()> {
     }
 
     let out_dir = env::var("OUT_DIR").unwrap();
-    let dest_path = format!("{}/bindings.inc.rs", out_dir);
+    let dest_path = format!("{out_dir}/bindings.inc.rs");
     let dest_path = Path::new(&dest_path);
     if dest_path.symlink_metadata().is_ok() {
         remove_file(dest_path)?;
-- 
2.49.0


