Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4FE15C3ABAC
	for <qemu-devel@archiver.kernel.org>; Tue,  6 May 2025 15:32:50 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uCKEt-0003hx-4T; Tue, 06 May 2025 11:29:47 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1uCKEr-0003h8-1O
 for qemu-devel@nongnu.org; Tue, 06 May 2025 11:29:45 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1uCKEo-0001wo-VA
 for qemu-devel@nongnu.org; Tue, 06 May 2025 11:29:44 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1746545382;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=qV5jZjq5WmzYGnh8gNqYnniJTawdtt4+HmcKtmlbKmw=;
 b=VHkGlQQSWAQ0Y44g/ZcrL1eyezlKhANvQvKOvDok56tXjGPc1YtlsuXCLcPyd/jaVI4tcy
 YAi5glC+kk6rTF/fbSO2370RRxErfqsLxbJ9nYk7SCefqhC9k7PRvch8BBVBGAhxC/SbMQ
 zfGT76tqyCI8EKVjo/2ID0qtvDFU3do=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-52-hBXLblALMp6t9cszhAJt9Q-1; Tue, 06 May 2025 11:29:40 -0400
X-MC-Unique: hBXLblALMp6t9cszhAJt9Q-1
X-Mimecast-MFC-AGG-ID: hBXLblALMp6t9cszhAJt9Q_1746545379
Received: by mail-wr1-f69.google.com with SMTP id
 ffacd0b85a97d-391315098b2so2006877f8f.2
 for <qemu-devel@nongnu.org>; Tue, 06 May 2025 08:29:40 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1746545378; x=1747150178;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=qV5jZjq5WmzYGnh8gNqYnniJTawdtt4+HmcKtmlbKmw=;
 b=vJKgJDgMcg2P7C+RyRQIv43FmFqAB9ZecBNhMlQxE8Udf7Ctc8I72mqnijBMXnaYar
 U9YL9n24YxLzHaWe+1VfSHGm2P2Aje9Q8qTAi7xiJRVl5Qo+C1S+u60znqy6OBTLDeKP
 eTcJyna8a/ZkoPOf/Gn91sf0liZyVBgbSRpJHwWDGBBYB2Bp9h1t+NalSPmPS7oaWyDh
 DaBBrxhi+6tdmMWg9MzOYLUjgN8L6pth4fj8oLNlZznZyiYP+GOfyAdDUcypQGLWUlUb
 1V6ldTa36Pxur6eoQBOKbtz9hnzudsv9f3Iz9KJF/wmd9aKGzJudo7bDJvJCm+6k8dGK
 TXFw==
X-Gm-Message-State: AOJu0YyZngjJoh4LVKwh3vtYskVqCiOdXuAFevNFlL/p6VCx8/vpVsiZ
 9QduI3bRNjjcL12/S63VLGESSap8Jo7YZZCg1ib9v0XFstl65vNjpoZnTpWff+1geue4jNVZSBa
 qwIUT5MM9wQEPqIs7sZgvcxueXpbdx688IvqcYY/pX/cvvngbUEX5N4vWAjpd6eRne15QTL6yma
 3rP2O1lrKrWVCIPwGL/1y1pJtJlNBX1gSoSWlo
X-Gm-Gg: ASbGnctseDhYHnlscBDrgibEUhAaz2N1i8V85IbdED5qsejIhoUDCP6crJ1sal2zLbD
 9p+OptTJwSzp0nCZVvG+3gGES9bxH542HDqEQUHcB27Z3AI8e+NMnz6PbQXZ5WMP3JnRCAvyzRN
 RX1rH2PzP6S0bVL1uPudWYmOF3FgGcBMRxW6uEsgpW0t7UU5z8cs/Wh3yEXh7+QFz9iZhaTAUnY
 W+0mjdjlTglWAIBbd8T8q7VJy2bIG0Uk0Jd4FnhoFZOgMYxxgSqY3XKtNGOuvsU/V/odsvhZXYE
 Mtqu84s7k0ktrnA=
X-Received: by 2002:a5d:588a:0:b0:391:4ca:490 with SMTP id
 ffacd0b85a97d-3a0ac0eaab8mr2267972f8f.29.1746545377725; 
 Tue, 06 May 2025 08:29:37 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IH8Q7mHYIEtKeCaHXU9f12f87Hox/yoSY4Oqhu/WDuPYTkUbVz7czWsq4g4yJoce1iYizpyog==
X-Received: by 2002:a5d:588a:0:b0:391:4ca:490 with SMTP id
 ffacd0b85a97d-3a0ac0eaab8mr2267954f8f.29.1746545377310; 
 Tue, 06 May 2025 08:29:37 -0700 (PDT)
Received: from [192.168.122.1] ([151.95.54.106])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3a099b1702dsm13785925f8f.88.2025.05.06.08.29.36
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 06 May 2025 08:29:36 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Cc: Zhao Liu <zhao1.liu@intel.com>
Subject: [PULL 05/30] rust: qemu_api_macros: make pattern matching more
 readable and efficient
Date: Tue,  6 May 2025 17:29:00 +0200
Message-ID: <20250506152927.222671-6-pbonzini@redhat.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250506152927.222671-1-pbonzini@redhat.com>
References: <20250506152927.222671-1-pbonzini@redhat.com>
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

"let ... else" is useful when visiting syntax trees; it avoids multiple
levels of indentation and places the error close to the pattern.

While at it, use "ref" to avoid moving the syntax tree objects.

Reviewed-by: Zhao Liu <zhao1.liu@intel.com>
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


