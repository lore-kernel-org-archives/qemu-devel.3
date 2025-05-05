Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 43205C3ABB0
	for <qemu-devel@archiver.kernel.org>; Mon,  5 May 2025 09:05:47 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uBrlZ-00042U-Rj; Mon, 05 May 2025 05:05:37 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1uBrky-0003Yv-RV
 for qemu-devel@nongnu.org; Mon, 05 May 2025 05:05:01 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1uBrku-0005kw-7X
 for qemu-devel@nongnu.org; Mon, 05 May 2025 05:04:58 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1746435895;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Ya2k66L69MguUJ7e/92cimrey+KKi+WpqMAX7zuo+gA=;
 b=N07bl3Kz97+4g8lbVbV+tWTrVOOEFKFxX74zHmXdiJ9ojRmAPV1p2mCbjzsEWb9iS3xtdE
 7dIq94IMpPpx2+/X5UPARS1TakIelO6P9bQc6Iu8/sPKgrMmVhq5GAFvRWfLXiqw6c5DbQ
 nXUVm4STwlK9mxV7D1gFkuDvwQ1AO/4=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-176-0Tybdb6UNLaW_vztsMHiPA-1; Mon, 05 May 2025 05:04:54 -0400
X-MC-Unique: 0Tybdb6UNLaW_vztsMHiPA-1
X-Mimecast-MFC-AGG-ID: 0Tybdb6UNLaW_vztsMHiPA_1746435893
Received: by mail-wm1-f72.google.com with SMTP id
 5b1f17b1804b1-43e9b0fd00cso17492485e9.0
 for <qemu-devel@nongnu.org>; Mon, 05 May 2025 02:04:54 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1746435892; x=1747040692;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Ya2k66L69MguUJ7e/92cimrey+KKi+WpqMAX7zuo+gA=;
 b=vHZiQZzVrpcWiKFUIA8G00Degy3xSxOBxGE31ZRrUF6wyT2Kd4RI2wS2xE+x0ytuow
 JNRQc8ekS0RCk0qiBJAVQEICwOP63HKaRYUlEK7O4/6SJjSFFz8/2fOwTDRblc/4I1Uj
 UyY/HzGJxdvwiMWL8AWrrqxERuM2ZLJKn5JgtSTOaHGZPZdYe6QZLepFGizKomiXjUN0
 VAYDCa2uAAd4Tg7Xmj/YEQBQuMNo164yqQsjBNeArp3WBvXzqLCaskM55ccTkkTCHCu1
 C/4CW3g2HlP4juB9mTd71s9T6rl0AkqX7KVowHsl83lALMN6oUEXCfgPetdpidRV/UtZ
 Hx8g==
X-Gm-Message-State: AOJu0YzDbDLuYMy/7ZqBK0HzPoomseykqBRZdoKPbZI3pXWY+E2IG3gC
 o4K5KdT5xbIPhncZmKvApH8xGwqAV7kHki7PZ+nDHVA1lYc7AQqXIWpZc/dKihJy/D+ikM7+9Eq
 66mfK1gM4SdJc7TKB8p1ONQrSnFYqNTfiqkQtBIJQT/T1qLh0rdQJQDnpAYuCick2YAHUu4bsta
 +1EeElRnbfg80+f/upCgbJu6//OwN/WTswVqb0
X-Gm-Gg: ASbGncv8/A7qcVG336nUkrfG72pb2Z8u96cH3TQoUXTqm+4Zsxte1ICIrcGZI25K8VP
 Z9ABa+bG4wOr+hPUno7PAIQEwHot0liq5Bfnuii9/lxoSlLEcXxw3nFDS6VSjnoRxTlnre75f3c
 sIIE549d2BpjJtcllACiKmBxkMKjf8yjTSohITLl+VE1uq0Eo14hhhqWr65/Rzvr96XsO8Bq7Ii
 E/K9r5F2MJ6IsgGW3FWepNedIXnwZTvuYo3OhBhSuiUqntZYK7+gIERVLvnL/mh490Us1YV16a4
 lUiJbPTFpYYSPDQ=
X-Received: by 2002:a05:600c:3acd:b0:43b:c6a7:ac60 with SMTP id
 5b1f17b1804b1-441bb88c9f1mr92244435e9.10.1746435892018; 
 Mon, 05 May 2025 02:04:52 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFVe8c/SXPKpUkmPyijE1jDB1zNxdbJ/AaUB37n6Rffwj3hvKuLJVKKEiaOAleaEtbv4n76JQ==
X-Received: by 2002:a05:600c:3acd:b0:43b:c6a7:ac60 with SMTP id
 5b1f17b1804b1-441bb88c9f1mr92244075e9.10.1746435891520; 
 Mon, 05 May 2025 02:04:51 -0700 (PDT)
Received: from [192.168.10.48] ([151.95.54.106])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-441b89d150fsm125522215e9.15.2025.05.05.02.04.49
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 05 May 2025 02:04:49 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Cc: manos.pitsidianakis@linaro.org,
	qemu-rust@nongnu.org
Subject: [PATCH 05/11] rust: qemu_api_macros: make pattern matching more
 readable and efficient
Date: Mon,  5 May 2025 11:04:30 +0200
Message-ID: <20250505090438.24992-6-pbonzini@redhat.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250505090438.24992-1-pbonzini@redhat.com>
References: <20250505090438.24992-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -44
X-Spam_score: -4.5
X-Spam_bar: ----
X-Spam_report: (-4.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.411,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=-1, RCVD_IN_MSPIKE_WL=-0.01,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
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

"let ... else" is useful when visiting syntax trees; it avoids multiple
levels of indentation and places the error close to the pattern.

While at it, use "ref" to avoid moving the syntax tree objects.

Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 rust/qemu-api-macros/src/lib.rs | 84 +++++++++++++++------------------
 1 file changed, 37 insertions(+), 47 deletions(-)

diff --git a/rust/qemu-api-macros/src/lib.rs b/rust/qemu-api-macros/src/lib.rs
index eda0d46d122..0bffd2691b4 100644
--- a/rust/qemu-api-macros/src/lib.rs
+++ b/rust/qemu-api-macros/src/lib.rs
@@ -16,50 +16,41 @@ fn get_fields<'a>(
     input: &'a DeriveInput,
     msg: &str,
 ) -> Result<&'a Punctuated<Field, Comma>, MacroError> {
-    if let Data::Struct(s) = &input.data {
-        if let Fields::Named(fs) = &s.fields {
-            Ok(&fs.named)
-        } else {
-            Err(MacroError::Message(
-                format!("Named fields required for {}", msg),
-                input.ident.span(),
-            ))
-        }
-    } else {
-        Err(MacroError::Message(
+    let Data::Struct(ref s) = &input.data else {
+        return Err(MacroError::Message(
             format!("Struct required for {}", msg),
             input.ident.span(),
-        ))
-    }
+        ));
+    };
+    let Fields::Named(ref fs) = &s.fields else {
+        return Err(MacroError::Message(
+            format!("Named fields required for {}", msg),
+            input.ident.span(),
+        ));
+    };
+    Ok(&fs.named)
 }
 
 fn get_unnamed_field<'a>(input: &'a DeriveInput, msg: &str) -> Result<&'a Field, MacroError> {
-    if let Data::Struct(s) = &input.data {
-        let unnamed = match &s.fields {
-            Fields::Unnamed(FieldsUnnamed {
-                unnamed: ref fields,
-                ..
-            }) => fields,
-            _ => {
-                return Err(MacroError::Message(
-                    format!("Tuple struct required for {}", msg),
-                    s.fields.span(),
-                ))
-            }
-        };
-        if unnamed.len() != 1 {
-            return Err(MacroError::Message(
-                format!("A single field is required for {}", msg),
-                s.fields.span(),
-            ));
-        }
-        Ok(&unnamed[0])
-    } else {
-        Err(MacroError::Message(
+    let Data::Struct(ref s) = &input.data else {
+        return Err(MacroError::Message(
             format!("Struct required for {}", msg),
             input.ident.span(),
-        ))
+        ));
+    };
+    let Fields::Unnamed(FieldsUnnamed { ref unnamed, .. }) = &s.fields else {
+        return Err(MacroError::Message(
+            format!("Tuple struct required for {}", msg),
+            s.fields.span(),
+        ));
+    };
+    if unnamed.len() != 1 {
+        return Err(MacroError::Message(
+            format!("A single field is required for {}", msg),
+            s.fields.span(),
+        ));
     }
+    Ok(&unnamed[0])
 }
 
 fn is_c_repr(input: &DeriveInput, msg: &str) -> Result<(), MacroError> {
@@ -210,20 +201,19 @@ fn get_repr_uN(input: &DeriveInput, msg: &str) -> Result<Path, MacroError> {
 }
 
 fn get_variants(input: &DeriveInput) -> Result<&Punctuated<Variant, Comma>, MacroError> {
-    if let Data::Enum(e) = &input.data {
-        if let Some(v) = e.variants.iter().find(|v| v.fields != Fields::Unit) {
-            return Err(MacroError::Message(
-                "Cannot derive TryInto for enum with non-unit variants.".to_string(),
-                v.fields.span(),
-            ));
-        }
-        Ok(&e.variants)
-    } else {
-        Err(MacroError::Message(
+    let Data::Enum(ref e) = &input.data else {
+        return Err(MacroError::Message(
             "Cannot derive TryInto for union or struct.".to_string(),
             input.ident.span(),
-        ))
+        ));
+    };
+    if let Some(v) = e.variants.iter().find(|v| v.fields != Fields::Unit) {
+        return Err(MacroError::Message(
+            "Cannot derive TryInto for enum with non-unit variants.".to_string(),
+            v.fields.span(),
+        ));
     }
+    Ok(&e.variants)
 }
 
 #[rustfmt::skip::macros(quote)]
-- 
2.49.0


