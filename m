Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 35023C3ABBE
	for <qemu-devel@archiver.kernel.org>; Tue,  6 May 2025 15:30:48 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uCKFK-00045I-5c; Tue, 06 May 2025 11:30:14 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1uCKF8-0003rE-WE
 for qemu-devel@nongnu.org; Tue, 06 May 2025 11:30:06 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1uCKF4-0001ys-TA
 for qemu-devel@nongnu.org; Tue, 06 May 2025 11:30:02 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1746545397;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=gPd0oWdRc16ZPxIiLcZrURGcaj+pbKtzOTzYPdfX13s=;
 b=PuOL2vJp33K9siFQtm9O/HbOqk8PZNlQWTqFOICA0TNsqgZkNN5lCt2EQjXXpK3UBEQjZS
 +4G0oFOPMC8meSBoIKHCMRn/8P2dEnN0fW8fUbJvpV5KXvcpB1kvsaOyQMKDznBavPqdwx
 6zwAZgPcaJNwTSL+69F0c3chWI6wF9g=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-115-DYscTFFFOL-vOXMZW_hLFg-1; Tue, 06 May 2025 11:29:56 -0400
X-MC-Unique: DYscTFFFOL-vOXMZW_hLFg-1
X-Mimecast-MFC-AGG-ID: DYscTFFFOL-vOXMZW_hLFg_1746545395
Received: by mail-wr1-f72.google.com with SMTP id
 ffacd0b85a97d-39ee4b91d1cso2611683f8f.0
 for <qemu-devel@nongnu.org>; Tue, 06 May 2025 08:29:56 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1746545395; x=1747150195;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=gPd0oWdRc16ZPxIiLcZrURGcaj+pbKtzOTzYPdfX13s=;
 b=himweKNX20tTJRQCPuak1Nk6sxZIYop3atfHFie8py7RqvLYzUpgGCa96DfsTBXyVa
 OUHFBGJgd6uaNKmwp9gSsFfYHpzWluSSvivHJo4cuihhY9rzKNuXV5Zw7PqxslXC4BIb
 wQLigBSzLZ06PT9E/aQCkeAY34gj2X6LYgRt0hnRgBGALwqZUueHIbUP3hZvMVm3mkoJ
 9buIajs/C2Ozhi8Tntnslr9bhq1pO+jzZGXPD6JNH+wt9CntHv1ID00LKh6eeugKvY7N
 D5FNLOjDRNmFYnVU91FfOxbyDecplZtmbKXD5O8YhaXHe1FGOaZLeh8kKgjQ+nUMhlJ5
 Rmvg==
X-Gm-Message-State: AOJu0YyYslblJMpIwlNI0etZ8xX8MEnjOHD/rbwyfPMxy00y4wkYPosr
 BBatIu6wLG2RoDmRQDLEsoIq/0qstjGfay3kLWuAEirzdmnp7co7imUSN5YuuJD92W7lnDFa+lw
 zD+vna7BeJTlMOcCZ/rBgHKac14Xv92OomzXgCEAKuwee52HDDb9ZDjWxUUkZMiH3zd8KEXklzQ
 EFI3O/PYklZpEnM3/XglalpKyya0jvBb2vQ7bU
X-Gm-Gg: ASbGnctgFcGc/Ov2VHTM8fC8cPHUrI6dBunjpqwlKQB7MvTc4nrD2Xj3VW7Kr2FsZ4H
 DI4c8Rl7ubP7kBpCQWZKI3Rzg2oaRlu6fft+Boct+pZeUFw3RTRjuYrFUWebE+7YzxGq/znj5Yo
 F7yBD9EtjfHUdC6m+rqQ+m097BhZ7MeXmyDCjpXtL3R1Z5DHDbuh3xhEpiUm7SjLbUK72xxEwoE
 vv60lX1uf9M/qM2c0DXoc1QySRPjKDQ7F5WVWHXOMDQC8dtpxTUfwJb3+XVxQohq7CaZlut0ddu
 torJEa6hrSWR7Eg=
X-Received: by 2002:a5d:5987:0:b0:39c:2673:4f10 with SMTP id
 ffacd0b85a97d-3a0b4429465mr192492f8f.23.1746545394721; 
 Tue, 06 May 2025 08:29:54 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHvlF+iWADZBkhidJHkUCCYLKVlmtZz8J6sir8rL6TkYaQ7zgyOA7RRTspgjbnZ6q9Za6JEPQ==
X-Received: by 2002:a5d:5987:0:b0:39c:2673:4f10 with SMTP id
 ffacd0b85a97d-3a0b4429465mr192469f8f.23.1746545394342; 
 Tue, 06 May 2025 08:29:54 -0700 (PDT)
Received: from [192.168.122.1] ([151.95.54.106])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-441bc264e2dsm152580895e9.12.2025.05.06.08.29.53
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 06 May 2025 08:29:53 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PULL 13/30] rust: clippy: enable uninlined_format_args lint
Date: Tue,  6 May 2025 17:29:08 +0200
Message-ID: <20250506152927.222671-14-pbonzini@redhat.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250506152927.222671-1-pbonzini@redhat.com>
References: <20250506152927.222671-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=pbonzini@redhat.com;
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


