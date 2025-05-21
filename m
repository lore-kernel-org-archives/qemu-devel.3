Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 84C99C54E65
	for <qemu-devel@archiver.kernel.org>; Wed, 21 May 2025 08:19:54 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uHefW-0004s8-Py; Wed, 21 May 2025 04:19:20 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1uHefK-0004nR-HL
 for qemu-devel@nongnu.org; Wed, 21 May 2025 04:19:06 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1uHefD-0000B3-Sp
 for qemu-devel@nongnu.org; Wed, 21 May 2025 04:19:05 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1747815538;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=sm4FDV9XcvaUoJSoDVM8BTJfAISob2kgbvzU5BLD5+0=;
 b=Pjsj0hsI07+Hp293T3xg4JOlcRUuHbuDb3ZKuff3SrY0yPXaxY5hmy1b74YRKK/DdCEEPC
 oYxkt7brOfqnvAc+/ltKTXJp/1J0gpd5fVS1CLFtxLs7wp0Qs4OA9qa43qeg8i4znwP84o
 9j1Sy85MN+QCvZlqM4uy5U0/q0cprX4=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-248-yRrH88Y5MZadLjgR_byZZQ-1; Wed, 21 May 2025 04:18:57 -0400
X-MC-Unique: yRrH88Y5MZadLjgR_byZZQ-1
X-Mimecast-MFC-AGG-ID: yRrH88Y5MZadLjgR_byZZQ_1747815536
Received: by mail-wm1-f70.google.com with SMTP id
 5b1f17b1804b1-442fa43e018so28565945e9.0
 for <qemu-devel@nongnu.org>; Wed, 21 May 2025 01:18:57 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1747815535; x=1748420335;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=sm4FDV9XcvaUoJSoDVM8BTJfAISob2kgbvzU5BLD5+0=;
 b=uYumNuS3VIV2NW5zbRTpRgKxJz+cn352IpHtL7ZJ0S+X1Eq3XRch9sOXF6YxOyCY7O
 hE+sCqgM67sMZ16z9CMlqyAy3+nqpLaOPLOe2Hm6UDY2rWlRVvAtm1Wh7rUiOZfGPDrK
 erO1MCd4fky2Ia8LSB23ISX1yNci50NLb8d8/T0dlpa3iWKA43yGHc3lo6kH3U7GEZHr
 GWC8qZz9JUFaDWIFFLleP5ENketEBCoewFrFoZljVVbZOLpBJS/GQ4wh9M6Iq/7hSlVV
 bReGZ/U1/z3Wj0IgnAQGZf2mWsyMmq3f40Mkqqilp8WbUIwSS5YwFfvTmtaVlW02kUvR
 WyyA==
X-Gm-Message-State: AOJu0YzmplnaiAZFBEmkRZ1F7N+Zy6G8KvB9JNp3ROB3/S2Xj1X8o2JI
 KwhxEAgNpu9e6jk+ECzLePk04XUo7J15CBdp6X7DeNBzkY7VwHEl3W/iXDqquAq5Q4roJprld/d
 YwiJZm6hCVS7QGJTiQCMJvy7nkaPElB4jHfhxN+HQ4cd/yqRfFeD27ZliB5qCa4sWx9SmDqmbIJ
 N0UcrnwHxvq4KOoIX+cxZcZb5N8tP/j2iyGEIxlOPu
X-Gm-Gg: ASbGncusP7WFcbabRvJlo3hL5AxQrh1tlIQPCPPjLC+HVFKp/Mdd/yAXMwixLsVZiKU
 UINsmer1Xg7Gmjp66cveQixM5+S76BX+t0U16d9pX2MkiYGMjpkTpENMf6JDmkhPipKdN9KjdWH
 rOuEqIovXhl0Uq8uKF6rv//E4kdteubLtd/YwUCsYxjR0LIeN/JYlvR5OLvyJaqJhcAB01EBLD5
 69Fywr0QDzLe0GRObClaaCtAKmP/oqCQ3U9lm2LRMuePAriQF17oYoUhJPUOnFDogclWpKZ+lQR
 EQuWlFb9ilhO7g==
X-Received: by 2002:a05:600c:3e8d:b0:43d:174:2668 with SMTP id
 5b1f17b1804b1-442f844e5d4mr208404045e9.0.1747815535301; 
 Wed, 21 May 2025 01:18:55 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFcK8YTwPUKcO65rs2si2DQU9nhEw3TQ5CTI6CUM2IeHnAm8wcOmtgnkQnf+sn8QKK4TIOxHw==
X-Received: by 2002:a05:600c:3e8d:b0:43d:174:2668 with SMTP id
 5b1f17b1804b1-442f844e5d4mr208403745e9.0.1747815534893; 
 Wed, 21 May 2025 01:18:54 -0700 (PDT)
Received: from [192.168.122.1] ([151.95.46.79])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3a35ca5a87fsm18560962f8f.29.2025.05.21.01.18.52
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 21 May 2025 01:18:52 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Cc: peter.maydell@linaro.org, qemu-rust@nongnu.org,
 manos.pitsidianakis@linaro.org
Subject: [RFC PATCH 3/6] rust: qemu-api-macros: add from_bits and into_bits to
 #[derive(TryInto)]
Date: Wed, 21 May 2025 10:18:42 +0200
Message-ID: <20250521081845.496442-4-pbonzini@redhat.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250521081845.496442-1-pbonzini@redhat.com>
References: <20250521081845.496442-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -25
X-Spam_score: -2.6
X-Spam_bar: --
X-Spam_report: (-2.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.487,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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


