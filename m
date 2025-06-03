Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 87441C5AE59
	for <qemu-devel@archiver.kernel.org>; Tue,  3 Jun 2025 21:48:43 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uMZSz-0005ak-KY; Tue, 03 Jun 2025 17:46:42 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1uMZSS-0004yV-RB
 for qemu-devel@nongnu.org; Tue, 03 Jun 2025 17:46:11 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1uMZSP-00068Y-LY
 for qemu-devel@nongnu.org; Tue, 03 Jun 2025 17:46:08 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1748987164;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=sm4FDV9XcvaUoJSoDVM8BTJfAISob2kgbvzU5BLD5+0=;
 b=EuKHFjlFCoh17FGsSAlJYe1sLwVsmJ2jDA1SocAF3/zUR+qQu7uAc0czz2qDcwTNasP+cA
 +kDyginFr4WWjavguRYeF+1KpYgBcGiLz2ei9ioTN1Tx82d7iQcgn2DZVyHeCg8UFv5u/l
 j5YdteSPS1YUW68VKBnEjI/HsYRjoq4=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-468-xByV4RX5OGOR2edI7JHqKw-1; Tue, 03 Jun 2025 17:46:03 -0400
X-MC-Unique: xByV4RX5OGOR2edI7JHqKw-1
X-Mimecast-MFC-AGG-ID: xByV4RX5OGOR2edI7JHqKw_1748987162
Received: by mail-wr1-f72.google.com with SMTP id
 ffacd0b85a97d-3a4f6cc5332so3209102f8f.2
 for <qemu-devel@nongnu.org>; Tue, 03 Jun 2025 14:46:03 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1748987161; x=1749591961;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=sm4FDV9XcvaUoJSoDVM8BTJfAISob2kgbvzU5BLD5+0=;
 b=qxtfC9D5pQNlEbQLmpsas3N6o+g9CGNkDjQf8784HTl3ADGSfS7InUkgkEO6qC77GX
 wx6MvFaM9/h/NVB/i7XboY9g7mQS2Uvs1wQRmaZtSacfOWDof57K4HhTDd9sdTSIrTtU
 S6ctx6PALFvOwTesIKsQjur0PH8XIAxs8TUeqz4bQ7BQ0wQ4HM0EbW01JUW1u10MAuav
 VBegsTozZz8ZgqSi+DZun3zx6Nv9F+eWLgpQZBAvFSfGiXYZ+N1Z1apR5GMXZgvH/AnM
 rSWkoRwaMegDhjnD3Qydt/237BNVBPLYPRfRWTtLB1GP0y8abOc774bJc0v+8+A1cIcs
 cgjQ==
X-Gm-Message-State: AOJu0YyTkbDJid7uk3qH8G2hw1YANL7iouPjh4t/C9vXpp3WKPPp+wsy
 95WF2VJ63L9p8oDj2Vbz4qBUtpr+Z0qA+5kGiyoUQTq9NHndas+6qHPadNqGfgi/MR3BDwpv99S
 XhjDH+751vDeCeyh4YgGuj+b2WJGFr8IpoklTM46W8KDTdlEtLGjk0THT8WAwTucB7YPcUGEi65
 wXB8l+hS+7rY/qlRqfLoawVyFONZF504AdXeLFvvp/
X-Gm-Gg: ASbGncttboOiGR8PWjIcN5csHzfHyIc8hqmRnQBJep+B37WMdX0UW16l3ekJj11YDsh
 ZFhInBJqSQYK7HT1ZTwRdQtz9ZY49/XW0el5tPuG+xcJixjSi264Q/LS/Wm+4b0qlQUEKOMW+aq
 Mtfp5TEdqggPUCnMJnpD7DB17Lla/1Aa+7x5L3HoB51zVUFjOgG9jRZNc4TGpy35w6hS5mFb+/H
 4xaSeQr4n6hShBZ5jdPiombq3T04TZrxlMIn6cRzphR3nBdYLvq6BdO/asHvoohwLaPCcnSiWop
 rF9kgcHaiO+gjg==
X-Received: by 2002:a05:6000:381:b0:3a0:b940:d479 with SMTP id
 ffacd0b85a97d-3a51d97982amr258396f8f.53.1748987161461; 
 Tue, 03 Jun 2025 14:46:01 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGtoZMiK+sn5VloQukrhegxv82SPV8te6CzEGyaHsfhD7kGxZtOG0CaGD0nl5tNpCbIXFfNIQ==
X-Received: by 2002:a05:6000:381:b0:3a0:b940:d479 with SMTP id
 ffacd0b85a97d-3a51d97982amr258376f8f.53.1748987160979; 
 Tue, 03 Jun 2025 14:46:00 -0700 (PDT)
Received: from [192.168.10.48] ([151.49.64.79])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3a4efe5b871sm19777113f8f.13.2025.06.03.14.45.59
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 03 Jun 2025 14:45:59 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PULL 16/16] rust: qemu-api-macros: add from_bits and into_bits to
 #[derive(TryInto)]
Date: Tue,  3 Jun 2025 23:45:23 +0200
Message-ID: <20250603214523.131185-17-pbonzini@redhat.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250603214523.131185-1-pbonzini@redhat.com>
References: <20250603214523.131185-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.128,
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

These const functions make it possible to use enums easily together
with the bitfield-struct crate.

Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 rust/qemu-api-macros/src/lib.rs | 48 ++++++++++++++++++++++++++-------
 1 file changed, 38 insertions(+), 10 deletions(-)

diff --git a/rust/qemu-api-macros/src/lib.rs b/rust/qemu-api-macros/src/lib.rs
index ceb79f09f97..103470785e3 100644
--- a/rust/qemu-api-macros/src/lib.rs
+++ b/rust/qemu-api-macros/src/lib.rs
@@ -193,23 +193,51 @@ fn get_variants(input: &DeriveInput) -> Result<&Punctuated<Variant, Comma>, Macr
 }
 
 #[rustfmt::skip::macros(quote)]
-fn derive_tryinto_or_error(input: DeriveInput) -> Result<proc_macro2::TokenStream, MacroError> {
-    let repr = get_repr_uN(&input, "#[derive(TryInto)]")?;
-
-    let name = &input.ident;
-    let variants = get_variants(&input)?;
+fn derive_tryinto_body(
+    name: &Ident,
+    variants: &Punctuated<Variant, Comma>,
+    repr: &Path,
+) -> Result<proc_macro2::TokenStream, MacroError> {
     let discriminants: Vec<&Ident> = variants.iter().map(|f| &f.ident).collect();
 
     Ok(quote! {
+        #(const #discriminants: #repr = #name::#discriminants as #repr;)*;
+        match value {
+            #(#discriminants => Ok(#name::#discriminants),)*
+            _ => Err(value),
+        }
+    })
+}
+
+#[rustfmt::skip::macros(quote)]
+fn derive_tryinto_or_error(input: DeriveInput) -> Result<proc_macro2::TokenStream, MacroError> {
+    let repr = get_repr_uN(&input, "#[derive(TryInto)]")?;
+    let name = &input.ident;
+    let body = derive_tryinto_body(name, get_variants(&input)?, &repr)?;
+    let errmsg = format!("invalid value for {name}");
+
+    Ok(quote! {
+        impl #name {
+            #[allow(dead_code)]
+            pub const fn into_bits(self) -> #repr {
+                self as #repr
+            }
+
+            #[allow(dead_code)]
+            pub const fn from_bits(value: #repr) -> Self {
+                match ({
+                    #body
+                }) {
+                    Ok(x) => x,
+                    Err(_) => panic!(#errmsg)
+                }
+            }
+        }
         impl core::convert::TryFrom<#repr> for #name {
             type Error = #repr;
 
             fn try_from(value: #repr) -> Result<Self, Self::Error> {
-                #(const #discriminants: #repr = #name::#discriminants as #repr;)*;
-                match value {
-                    #(#discriminants => Ok(Self::#discriminants),)*
-                    _ => Err(value),
-                }
+                #body
             }
         }
     })
-- 
2.49.0


