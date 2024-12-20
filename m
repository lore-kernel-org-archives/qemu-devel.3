Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 54636E77188
	for <qemu-devel@archiver.kernel.org>; Fri, 20 Dec 2024 14:31:16 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tOe1O-0004RN-VB; Fri, 20 Dec 2024 09:30:31 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1tOe15-0004Kt-3N
 for qemu-devel@nongnu.org; Fri, 20 Dec 2024 09:30:11 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1tOe13-0006CW-J2
 for qemu-devel@nongnu.org; Fri, 20 Dec 2024 09:30:10 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1734705008;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=IqbmpoLQyfb2UAoXyBV1EOkxQeun0T/cCIXmsB4p+Sw=;
 b=dA1o3E2iKH5K4Oj74xoMZbTHuvmpVzBVqMHDHf4WgPTm9wHjgXqbTLyV8rLybomFIz2zAm
 tioLNUfPki/jTktJpYmrCNhw52cormPty9c8kPbHU6dXiIZy2KXK9xKO7i9AwOS5Sb6CmB
 I+eIlHoi3nY52k4jOam4N3N03Ue+33A=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-656-uo4pgqnnPHODMnXIAoc5HQ-1; Fri, 20 Dec 2024 09:30:07 -0500
X-MC-Unique: uo4pgqnnPHODMnXIAoc5HQ-1
X-Mimecast-MFC-AGG-ID: uo4pgqnnPHODMnXIAoc5HQ
Received: by mail-wr1-f70.google.com with SMTP id
 ffacd0b85a97d-386321c8f4bso1149457f8f.0
 for <qemu-devel@nongnu.org>; Fri, 20 Dec 2024 06:30:07 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1734705005; x=1735309805;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=IqbmpoLQyfb2UAoXyBV1EOkxQeun0T/cCIXmsB4p+Sw=;
 b=na34YW4frB6WkNCEsBuP9ndW2WT+IMVChr7j/ZSvuF9dQZ8EAnmLSPTRzJXUTmZeqE
 FgGxI8J0HNsDvD4wTUxUV4bPfKGaYFD6L3vy8JxQQi7JmoX1XFpJWgY5tO1gClEWgkdx
 bkF++ViD153h7J8Ad6w7t54V5A9fs4Xb8ZwtC7c9H6W3+3GHAYdOGp5CsF2NAeSBIPvk
 9f2VlcPQqrx0qnbm0bcnjSN+An3yratZfxOaKrJvWIdwrvOnpKTUVc2Nke7vcsFTLOgy
 XNXMkMrRmsczt6c7P51pTl7WZz9JzPNYZGyXAflap1574ZxKo1CFZCtKXvVas5Q+Qm+w
 xf+g==
X-Gm-Message-State: AOJu0YylL/o5oZNdNgpc2842bXnExMAbgil2cBP1gxelSNrbhqm1+VSI
 IHGUMO/ZkI/8sC4JoolRIEwE8Rc5y34eS6PeDtaL+33JNUwSTaP5b7gLIsvcfW142CovmpVOGyM
 ghOrvoCPVG2uxMK6XUQXIjmH3p6epy+SNC03pr3SYUzIdPlj20uQE5yk34B62ortvo/gcKFl7BZ
 syW95vOA98w8h2g9e8eMUjiuLhvq/0x6tzlmGb
X-Gm-Gg: ASbGncvvJe79jtFRd2Bx0/WemuvRo+1FpAmwEtQaJzn9U0+JK5t6EI0u2UW/uz02dpK
 jhIXYN4wfXekjbrCyukA0kuKNg59nO0PpROhAhe9l9bfg3UjjqWa7/r8x5oYLRWeEITFYmqnMam
 y4JlKQkxiHrv/fQF35iAObsjXUl2/L6+rNIEgtubcHc/kuU9lL8yQCJjU2eKaIE0AbgtbAjdlOz
 ZYW/zRccpG53jX+RSHpDrP/j8cXDD6Cju0Z6RHDKP8P1ar9aQ7a/mq+DpXo
X-Received: by 2002:a05:6000:70a:b0:385:fd07:8616 with SMTP id
 ffacd0b85a97d-38a221403c5mr3545175f8f.0.1734705005284; 
 Fri, 20 Dec 2024 06:30:05 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFMO0aSdbfgVn0axKuvleQYQ7bUuDKX2ggtYKCo1HVYZ+0BomAdEB53tfQHu74Dyu9+vfOCrw==
X-Received: by 2002:a05:6000:70a:b0:385:fd07:8616 with SMTP id
 ffacd0b85a97d-38a221403c5mr3545159f8f.0.1734705004934; 
 Fri, 20 Dec 2024 06:30:04 -0800 (PST)
Received: from [192.168.10.47] ([151.81.118.45])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-43656af6cbbsm81364845e9.3.2024.12.20.06.30.02
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 20 Dec 2024 06:30:02 -0800 (PST)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Cc: zhao1.liu@intel.com,
	junjie.mao@hotmail.com
Subject: [PATCH 03/12] rust: macros: check that the first field of a
 #[derive(Object)] struct is a ParentField
Date: Fri, 20 Dec 2024 15:29:45 +0100
Message-ID: <20241220142955.652636-4-pbonzini@redhat.com>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20241220142955.652636-1-pbonzini@redhat.com>
References: <20241220142955.652636-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -31
X-Spam_score: -3.2
X-Spam_bar: ---
X-Spam_report: (-3.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-1.129,
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
 rust/qemu-api-macros/src/lib.rs | 61 +++++++++++++++++++--------------
 1 file changed, 36 insertions(+), 25 deletions(-)

diff --git a/rust/qemu-api-macros/src/lib.rs b/rust/qemu-api-macros/src/lib.rs
index 74a8bc7503e..778b698be45 100644
--- a/rust/qemu-api-macros/src/lib.rs
+++ b/rust/qemu-api-macros/src/lib.rs
@@ -19,6 +19,27 @@ fn from(err: CompileError) -> Self {
     }
 }
 
+fn get_fields<'a>(
+    input: &'a DeriveInput,
+    msg: &str,
+) -> Result<&'a Punctuated<Field, Comma>, CompileError> {
+    if let Data::Struct(s) = &input.data {
+        if let Fields::Named(fs) = &s.fields {
+            Ok(&fs.named)
+        } else {
+            Err(CompileError(
+                format!("Named fields required for {}", msg),
+                input.ident.span(),
+            ))
+        }
+    } else {
+        Err(CompileError(
+            format!("Struct required for {}", msg),
+            input.ident.span(),
+        ))
+    }
+}
+
 fn is_c_repr(input: &DeriveInput, msg: &str) -> Result<(), CompileError> {
     let expected = parse_quote! { #[repr(C)] };
 
@@ -32,38 +53,28 @@ fn is_c_repr(input: &DeriveInput, msg: &str) -> Result<(), CompileError> {
     }
 }
 
-#[proc_macro_derive(Object)]
-pub fn derive_object(input: TokenStream) -> TokenStream {
-    let input = parse_macro_input!(input as DeriveInput);
-    let name = input.ident;
+fn derive_object_or_error(input: DeriveInput) -> Result<proc_macro2::TokenStream, CompileError> {
+    let name = &input.ident;
+    let parent = &get_fields(&input, "#[derive(Object)]")?[0].ident;
+
+    Ok(quote! {
+        ::qemu_api::assert_field_type!(#name, #parent,
+            ::qemu_api::qom::ParentField<<#name as ::qemu_api::qom::ObjectImpl>::ParentType>);
 
-    let expanded = quote! {
         ::qemu_api::module_init! {
             MODULE_INIT_QOM => unsafe {
                 ::qemu_api::bindings::type_register_static(&<#name as ::qemu_api::qom::ObjectImpl>::TYPE_INFO);
             }
         }
-    };
-
-    TokenStream::from(expanded)
+    })
 }
 
-fn get_fields(input: &DeriveInput) -> Result<&Punctuated<Field, Comma>, CompileError> {
-    if let Data::Struct(s) = &input.data {
-        if let Fields::Named(fs) = &s.fields {
-            Ok(&fs.named)
-        } else {
-            Err(CompileError(
-                "Cannot generate offsets for unnamed fields.".to_string(),
-                input.ident.span(),
-            ))
-        }
-    } else {
-        Err(CompileError(
-            "Cannot generate offsets for union or enum.".to_string(),
-            input.ident.span(),
-        ))
-    }
+#[proc_macro_derive(Object)]
+pub fn derive_object(input: TokenStream) -> TokenStream {
+    let input = parse_macro_input!(input as DeriveInput);
+    let expanded = derive_object_or_error(input).unwrap_or_else(Into::into);
+
+    TokenStream::from(expanded)
 }
 
 #[rustfmt::skip::macros(quote)]
@@ -71,7 +82,7 @@ fn derive_offsets_or_error(input: DeriveInput) -> Result<proc_macro2::TokenStrea
     is_c_repr(&input, "#[derive(offsets)]")?;
 
     let name = &input.ident;
-    let fields = get_fields(&input)?;
+    let fields = get_fields(&input, "#[derive(offsets)]")?;
     let field_names: Vec<&Ident> = fields.iter().map(|f| f.ident.as_ref().unwrap()).collect();
     let field_types: Vec<&Type> = fields.iter().map(|f| &f.ty).collect();
     let field_vis: Vec<&Visibility> = fields.iter().map(|f| &f.vis).collect();
-- 
2.47.1


